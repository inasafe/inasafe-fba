
--
-- Name: kartoza_fba_generate_excel_report_for_flood(integer); Type: FUNCTION; Schema: public; Owner: -
--
DROP FUNCTION IF EXISTS public.kartoza_fba_generate_excel_report_for_flood;
CREATE FUNCTION public.kartoza_fba_generate_excel_report_for_flood(flood_event_id integer) RETURNS character varying
    LANGUAGE plpython3u
    AS $_$
    import io
    import sys
    import json
    plpy.execute("select * from satisfy_dependency('xlsxwriter')")
    plpy.execute("select * from satisfy_dependency('openpyxl')")
    result = plpy.execute("select value from config where key = 'WMS_BASE_URL'")
    wms_base_url = json.loads(result[0]['value'])

    from smartexcel.smart_excel import SmartExcel
    from smartexcel.fbf.data_model import FbfFloodData
    from smartexcel.fbf.definition import FBF_DEFINITION

    excel = SmartExcel(
        output=io.BytesIO(),
        definition=FBF_DEFINITION,
        data=FbfFloodData(
            wms_base_url=wms_base_url,
            flood_event_id=flood_event_id,
            pl_python_env=True
        )
    )

    excel.dump()

    plan = plpy.prepare("UPDATE spreadsheet_reports SET spreadsheet = ($1) where flood_event_id = ($2)", ["bytea", "integer"])
    plpy.execute(plan, [excel.output.getvalue(), flood_event_id])

    return "OK"
$_$;
