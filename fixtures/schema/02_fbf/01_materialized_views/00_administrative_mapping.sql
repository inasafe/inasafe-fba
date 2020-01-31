--
-- Name: mv_administrative_mapping; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--
DROP MATERIALIZED VIEW IF EXISTS public.mv_administrative_mapping;
CREATE  MATERIALIZED VIEW public.mv_administrative_mapping AS
 SELECT district.dc_code AS district_id,
    district.name AS district_name,
    sub_district.sub_dc_code AS sub_district_id,
    sub_district.name AS sub_district_name,
    village.village_code AS village_id,
    village.name AS village_name
   FROM ((public.district
     JOIN public.sub_district ON ((district.dc_code = (sub_district.dc_code)::double precision)))
     JOIN public.village ON (((sub_district.sub_dc_code)::double precision = village.sub_dc_code)))
  WITH NO DATA;
