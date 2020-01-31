
--
-- Name: osm_buildings area_mapper_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS area_mapper_tg ON public.osm_buildings;
CREATE TRIGGER area_mapper_tg AFTER INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_building_area_mapper();


--
-- Name: osm_buildings area_recode_mapper_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS area_recode_mapper_tg ON public.osm_buildings;
CREATE TRIGGER area_recode_mapper_tg AFTER INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_building_area_score_mapper();


--
-- Name: osm_buildings building_material_recode_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS building_material_recode_tg ON public.osm_buildings;
CREATE TRIGGER building_material_recode_tg AFTER INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_building_materials_mapper();


--
-- Name: osm_buildings building_type_mapper_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS building_type_mapper_tg ON public.osm_buildings;
CREATE TRIGGER building_type_mapper_tg AFTER INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_building_types_mapper();


--
-- Name: osm_buildings building_type_recode_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS building_type_recode_tg ON public.osm_buildings;
CREATE TRIGGER building_type_recode_tg AFTER INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_building_recode_mapper();
