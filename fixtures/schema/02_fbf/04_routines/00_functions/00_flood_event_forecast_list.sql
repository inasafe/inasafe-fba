--
-- Name: flood_event_forecast_list_f(timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--
DROP FUNCTION IF EXISTS public.flood_event_forecast_list_f;
CREATE FUNCTION public.flood_event_forecast_list_f(acquisition_date_start timestamp without time zone, acquisition_date_end timestamp without time zone) RETURNS TABLE(total_forecast bigint, lead_time bigint, trigger_status_id integer)
    LANGUAGE plpgsql
    AS $$
begin return query
         select count(a.id) as total_forecast,
               a.lead_time, MAX(a.trigger_status) as trigger_status_id
        from (
            select id,
                   extract(day from forecast_date - acquisition_date)::bigint as lead_time, trigger_status
            from hazard_event
            where (
                acquisition_date >= acquisition_date_start
                    and acquisition_date < acquisition_date_end)
            ) as a
        group by a.lead_time;
    end;
$$;
