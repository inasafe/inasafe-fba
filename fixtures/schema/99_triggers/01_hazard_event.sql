--
-- Name: hazard_event flood_event_buildings_mv_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS flood_event_buildings_mv_tg ON public.hazard_event;
CREATE TRIGGER flood_event_buildings_mv_tg AFTER INSERT ON public.hazard_event FOR EACH STATEMENT EXECUTE PROCEDURE public.kartoza_refresh_flood_event_buildings_mv();


--
-- Name: hazard_event flood_event_roads_mv_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS flood_event_roads_mv_tg ON public.hazard_event;
CREATE TRIGGER flood_event_roads_mv_tg AFTER INSERT ON public.hazard_event FOR EACH STATEMENT EXECUTE PROCEDURE public.kartoza_refresh_flood_event_roads_mv();


--
-- Name: hazard_event game_non_flooded_roads_mv_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS game_non_flooded_roads_mv_tg ON public.hazard_event;
CREATE TRIGGER game_non_flooded_roads_mv_tg AFTER INSERT ON public.hazard_event FOR EACH STATEMENT EXECUTE PROCEDURE public.kartoza_refresh_non_flooded_roads_summary_mv();


--
-- Name: hazard_event hame_flooded_roads_mv_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS hame_flooded_roads_mv_tg ON public.hazard_event;
CREATE TRIGGER hame_flooded_roads_mv_tg AFTER INSERT ON public.hazard_event FOR EACH STATEMENT EXECUTE PROCEDURE public.kartoza_refresh_flooded_roads_summary_mv();


--
-- Name: hazard_event home_non_flooded_fd_summary_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS home_non_flooded_fd_summary_tg ON public.hazard_event;
CREATE TRIGGER home_non_flooded_fd_summary_tg AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_flood_non_flooded_building_summary();


--
-- Name: hazard_event jade_dist_summary_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS jade_dist_summary_tg ON public.hazard_event;
CREATE TRIGGER jade_dist_summary_tg AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_flood_district_summary();


--
-- Name: hazard_event jade_roads_district_summary_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS jade_roads_district_summary_tg ON public.hazard_event;
CREATE TRIGGER jade_roads_district_summary_tg AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_road_district_summary();


--
-- Name: hazard_event kade_roads_sub_district_summary_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS kade_roads_sub_district_summary_tg ON public.hazard_event;
CREATE TRIGGER kade_roads_sub_district_summary_tg AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_road_sub_district_summary();


--
-- Name: hazard_event kalk_sub_fd_summary_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS kalk_sub_fd_summary_tg ON public.hazard_event;
CREATE TRIGGER kalk_sub_fd_summary_tg AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_flood_sub_event_summary();


--
-- Name: hazard_event lade_roads_village_summary_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS lade_roads_village_summary_tg ON public.hazard_event;
CREATE TRIGGER lade_roads_village_summary_tg AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_road_village_summary();


--
-- Name: hazard_event lame_village_event_smry_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS lame_village_event_smry_tg ON public.hazard_event;
CREATE TRIGGER lame_village_event_smry_tg AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_flood_village_event_summary();


--
-- Name: hazard_event z_event_populate_spreadsheet_flood_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS z_event_populate_spreadsheet_flood_tg ON public.hazard_event;
CREATE TRIGGER z_event_populate_spreadsheet_flood_tg BEFORE INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_populate_spreadsheet_table();
