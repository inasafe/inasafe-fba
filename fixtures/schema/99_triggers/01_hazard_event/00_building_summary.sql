--
-- Name: hazard_event hazard_event_tg_00_exposed_buildings_mv; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS hazard_event_tg_00_exposed_buildings_mv ON public.hazard_event;
CREATE TRIGGER hazard_event_tg_00_exposed_buildings_mv AFTER INSERT ON public.hazard_event FOR EACH STATEMENT EXECUTE PROCEDURE public.kartoza_refresh_flood_event_buildings_mv();

--
-- Name: hazard_event hazard_event_tg_01_exposed_buildings_summary_mv; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS hazard_event_tg_01_exposed_buildings_summary_mv ON public.hazard_event;
CREATE TRIGGER hazard_event_tg_01_exposed_buildings_summary_mv AFTER INSERT ON public.hazard_event FOR EACH STATEMENT EXECUTE PROCEDURE public.kartoza_refresh_flooded_building_summary();

--
-- Name: hazard_event hazard_event_tg_02_exposed_village_buildings_mv; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS hazard_event_tg_02_exposed_village_buildings_mv ON public.hazard_event;
CREATE TRIGGER hazard_event_tg_02_exposed_village_buildings_mv AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_flood_village_event_summary();


--
-- Name: hazard_event hazard_event_tg_03_exposed_sub_district_buildings_mv; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS hazard_event_tg_03_exposed_sub_district_buildings_mv ON public.hazard_event;
CREATE TRIGGER hazard_event_tg_03_exposed_sub_district_buildings_mv AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_flood_sub_event_summary();

--
-- Name: hazard_event hazard_event_tg_04_exposed_district_buildings_mv; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS hazard_event_tg_04_exposed_district_buildings_mv ON public.hazard_event;
CREATE TRIGGER hazard_event_tg_04_exposed_district_buildings_mv AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_flood_district_summary();

