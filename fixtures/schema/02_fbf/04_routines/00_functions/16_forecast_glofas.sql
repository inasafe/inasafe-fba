-- Register function
DROP FUNCTION IF EXISTS public.kartoza_fba_forecast_glofas;
CREATE FUNCTION public.kartoza_fba_forecast_glofas() RETURNS CHARACTER VARYING
    LANGUAGE plpython3u
as
$$
from fbf.forecast.glofas.reporting_point import GloFASForecast
job = GloFASForecast()
job.run()

return 'OK'
$$;

SELECT pg_reload_conf();

-- Include in cron
INSERT INTO cron.job (schedule, command)
SELECT
    '0 * * * *', $$ select kartoza_fba_forecast_glofas() $$
WHERE
      NOT EXISTS (
          SELECT schedule, command FROM cron.job
          WHERE schedule = '0 * * * *' AND command = $$ SELECT kartoza_fba_forecast_glofas() $$)

