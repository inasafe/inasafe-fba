--
-- Name: vw_hazard_wkt_view; Type: VIEW; Schema: public; Owner: -
--

CREATE OR REPLACE VIEW public.vw_hazard_wkt_view AS
 SELECT hazard.id,
    hazard.name,
    public.st_astext(hazard.geometry) AS st_astext,
    hazard.source,
    hazard.reporting_date_time,
    hazard.forecast_date_time,
    hazard.station
   FROM public.hazard;

