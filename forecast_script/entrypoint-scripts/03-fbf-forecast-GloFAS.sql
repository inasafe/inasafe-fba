-- Register function
create or replace function kartoza_fba_forecast_glofas() returns character varying
    language plpython3u
as
$$
from fbf.forecast.glofas.reporting_point import GloFASForecast
job = GloFASForecast()
job.run()

return 'OK'
$$;

-- Include in cron
insert into cron.job (schedule, command)
select
    '0 * * * *', $$ select kartoza_fba_forecast_glofas() $$
where
      not exists (
          select schedule, command from cron.job
          where schedule = '0 * * * *' and command = $$ select kartoza_fba_forecast_glofas() $$)

