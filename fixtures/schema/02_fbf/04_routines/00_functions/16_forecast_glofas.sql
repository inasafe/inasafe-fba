-- Register function
DROP FUNCTION IF EXISTS public.kartoza_fba_forecast_glofas;
CREATE OR REPLACE FUNCTION public.kartoza_fba_forecast_glofas() RETURNS CHARACTER VARYING
    LANGUAGE plpython3u
as
$$
from fbf.forecast.glofas.reporting_point import GloFASForecast
import os
postgrest_url = os.environ.get('POSTGREST_BASE_URL')
job = GloFASForecast(postgrest_url=postgrest_url)
job.run()

return 'OK'
$$;

CREATE OR REPLACE FUNCTION public.kartoza_fba_forecast_glofas(hazard_event_id bigint) RETURNS CHARACTER VARYING
    LANGUAGE plpython3u
as
$$
from fbf.forecast.glofas.reporting_point import GloFASForecast
import os
import requests
postgrest_url = os.environ.get('POSTGREST_BASE_URL')
job = GloFASForecast(postgrest_url=postgrest_url)

url = '{postgrest_url}{endpoint}{query_param}'.format(
    postgrest_url=postgrest_url,
    endpoint=job.flood_event_insert_endpoint,
    query_param='&id=eq.{id}'.format(id=hazard_event_id))

response = requests.get(url)
job.flood_forecast_events = response.json()
job.evaluate_trigger_status(job.flood_forecast_events)
job.calculate_impact()

return 'OK'
$$;

-- Include in cron
INSERT INTO cron.job (schedule, command)
SELECT
    '0 * * * *', $$ select kartoza_fba_forecast_glofas() $$
WHERE
      NOT EXISTS (
          SELECT schedule, command FROM cron.job
          WHERE schedule = '0 * * * *' AND command = $$ SELECT kartoza_fba_forecast_glofas() $$)

