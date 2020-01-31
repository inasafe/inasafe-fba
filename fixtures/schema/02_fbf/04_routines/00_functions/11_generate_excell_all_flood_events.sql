
--
-- Name: kartoza_fba_generate_excel_all_flood_events(); Type: FUNCTION; Schema: public; Owner: -
--
DROP FUNCTION IF EXISTS public.kartoza_fba_generate_excel_all_flood_events;
CREATE FUNCTION public.kartoza_fba_generate_excel_all_flood_events() RETURNS character varying
    LANGUAGE plpython3u
    AS $_$
   res = plpy.execute("SELECT id from hazard_event")

   for flood_event in res:
     plan = plpy.prepare("SELECT * from kartoza_fba_generate_excel_report_for_flood(($1))", ["integer"])
     plpy.execute(plan, [flood_event['id']])
   return "OK"
$_$;
