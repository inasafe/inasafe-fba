
--
-- Name: osm_buildings area_mapper_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER area_mapper_tg AFTER INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_building_area_mapper();


--
-- Name: osm_buildings area_recode_mapper_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER area_recode_mapper_tg AFTER INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_building_area_score_mapper();


--
-- Name: osm_buildings building_material_recode_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER building_material_recode_tg AFTER INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_building_materials_mapper();


--
-- Name: osm_buildings building_type_mapper_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER building_type_mapper_tg AFTER INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_building_types_mapper();


--
-- Name: osm_buildings building_type_recode_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER building_type_recode_tg AFTER INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_building_recode_mapper();


--
-- Name: hazard_event flood_event_buildings_mv_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER flood_event_buildings_mv_tg AFTER INSERT ON public.hazard_event FOR EACH STATEMENT EXECUTE PROCEDURE public.kartoza_refresh_flood_event_buildings_mv();


--
-- Name: hazard_event flood_event_roads_mv_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER flood_event_roads_mv_tg AFTER INSERT ON public.hazard_event FOR EACH STATEMENT EXECUTE PROCEDURE public.kartoza_refresh_flood_event_roads_mv();


--
-- Name: spreadsheet_reports flood_report_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER flood_report_tg BEFORE INSERT ON public.spreadsheet_reports FOR EACH ROW EXECUTE PROCEDURE public.kartoza_generate_excel_report_for_flood();


--
-- Name: hazard_event game_non_flooded_roads_mv_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER game_non_flooded_roads_mv_tg AFTER INSERT ON public.hazard_event FOR EACH STATEMENT EXECUTE PROCEDURE public.kartoza_refresh_non_flooded_roads_summary_mv();


--
-- Name: hazard_event hame_flooded_roads_mv_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER hame_flooded_roads_mv_tg AFTER INSERT ON public.hazard_event FOR EACH STATEMENT EXECUTE PROCEDURE public.kartoza_refresh_flooded_roads_summary_mv();


--
-- Name: hazard_event home_non_flooded_fd_summary_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER home_non_flooded_fd_summary_tg AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_flood_non_flooded_building_summary();


--
-- Name: hazard_event jade_dist_summary_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER jade_dist_summary_tg AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_flood_district_summary();


--
-- Name: hazard_event jade_roads_district_summary_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER jade_roads_district_summary_tg AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_road_district_summary();


--
-- Name: hazard_event kade_roads_sub_district_summary_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER kade_roads_sub_district_summary_tg AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_road_sub_district_summary();


--
-- Name: hazard_event kalk_sub_fd_summary_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER kalk_sub_fd_summary_tg AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_flood_sub_event_summary();


--
-- Name: hazard_event lade_roads_village_summary_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER lade_roads_village_summary_tg AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_road_village_summary();


--
-- Name: hazard_event lame_village_event_smry_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER lame_village_event_smry_tg AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_refresh_flood_village_event_summary();


--
-- Name: hazard_event z_event_populate_spreadsheet_flood_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER z_event_populate_spreadsheet_flood_tg BEFORE INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_populate_spreadsheet_table();
