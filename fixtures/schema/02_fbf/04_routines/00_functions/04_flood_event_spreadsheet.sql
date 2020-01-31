
--
-- Name: flood_event_spreadsheet(integer); Type: FUNCTION; Schema: public; Owner: -
--
DROP FUNCTION IF EXISTS public.flood_event_spreadsheet;
CREATE FUNCTION public.flood_event_spreadsheet(hazard_event_id integer) RETURNS TABLE(spreadsheet_content text)
    LANGUAGE plpgsql
    AS $$
begin return query
        select encode(spreadsheet, 'base64') as spreadsheet_content from spreadsheet_reports where flood_event_id=hazard_event_id;
    end;
$$;
