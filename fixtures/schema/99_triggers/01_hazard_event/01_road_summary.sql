--
-- Name: hazard_event flood_event_roads_mv_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS hazard_event_tg_00_exposed_roads_mv ON public.hazard_event;
CREATE TRIGGER hazard_event_tg_00_exposed_roads_mv AFTER INSERT ON public.hazard_event FOR EACH STATEMENT EXECUTE PROCEDURE public.kartoza_refresh_flood_event_roads_mv();


--
-- Name: hazard_event hazard_event_tg_01_exposed_roads_summary_mv; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS hazard_event_tg_01_exposed_roads_summary_mv ON public.hazard_event;
CREATE TRIGGER hazard_event_tg_01_exposed_roads_summary_mv AFTER INSERT ON public.hazard_event FOR EACH STATEMENT EXECUTE PROCEDURE public.kartoza_refresh_flooded_roads_summary_mv();

--
-- Name: hazard_event hazard_event_tg_02_exposed_village_roads_mv; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS hazard_event_tg_02_exposed_village_roads_mv ON public.hazard_event;
CREATE TRIGGER hazard_event_tg_02_exposed_village_roads_mv AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_road_village_summary();


--
-- Name: hazard_event hazard_event_tg_03_exposed_sub_district_roads_mv; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS hazard_event_tg_03_exposed_sub_district_roads_mv ON public.hazard_event;
CREATE TRIGGER hazard_event_tg_03_exposed_sub_district_roads_mv AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_road_sub_district_summary();

--
-- Name: hazard_event hazard_event_tg_04_exposed_district_roads_mv; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS hazard_event_tg_04_exposed_district_roads_mv ON public.hazard_event;
CREATE TRIGGER hazard_event_tg_04_exposed_district_roads_mv AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_road_district_summary();
