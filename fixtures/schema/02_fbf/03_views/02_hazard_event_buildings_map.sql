--
-- Name: vw_hazard_event_buildings_map; Type: VIEW; Schema: public; Owner: -
--

CREATE OR REPLACE VIEW public.vw_hazard_event_buildings_map AS
 SELECT row_number() OVER () AS id,
    b.geometry,
    b.building_type,
    b.district_id,
    b.sub_district_id,
    b.village_id,
    feb.depth_class_id,
    feb.flood_event_id
   FROM public.osm_buildings b,
    public.hazard_event_buildings feb
  WHERE (feb.building_id = b.id);

--
-- Name: VIEW vw_hazard_event_buildings_map; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON VIEW public.vw_hazard_event_buildings_map IS 'Flooded event buildings map view. Added by Tim to show when we select a flood.';
