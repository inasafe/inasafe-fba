
--
-- Name: osm_buildings area_mapper_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS osm_buildings_tg_00_area_mapper_tg ON public.osm_buildings;
CREATE TRIGGER osm_buildings_tg_00_area_mapper_tg BEFORE INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_building_area_mapper();


--
-- Name: osm_buildings area_recode_mapper_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS osm_buildings_tg_01_area_recode_mapper_tg ON public.osm_buildings;
CREATE TRIGGER osm_buildings_tg_01_area_recode_mapper_tg BEFORE INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_building_area_score_mapper();


--
-- Name: osm_buildings building_material_recode_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS osm_buildings_tg_00_building_material_recode_tg ON public.osm_buildings;
CREATE TRIGGER osm_buildings_tg_00_building_material_recode_tg BEFORE INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_building_materials_mapper();


--
-- Name: osm_buildings building_type_mapper_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS osm_buildings_tg_00_building_type_mapper_tg ON public.osm_buildings;
CREATE TRIGGER osm_buildings_tg_00_building_type_mapper_tg BEFORE INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_building_types_mapper();


--
-- Name: osm_buildings building_type_recode_tg; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS osm_buildings_tg_01_building_type_recode_tg ON public.osm_buildings;
CREATE TRIGGER osm_buildings_tg_01_building_type_recode_tg BEFORE INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_building_recode_mapper();


DROP TRIGGER IF EXISTS osm_buildings_tg_02_building_total_vulnerability_tg ON public.osm_buildings;
CREATE TRIGGER osm_buildings_tg_02_building_total_vulnerability_tg BEFORE INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_generate_building_vulnerability();

DROP TRIGGER IF EXISTS osm_buildings_tg_00_building_admin_mapper_tg ON public.osm_buildings;
CREATE TRIGGER osm_buildings_tg_00_building_admin_mapper_tg BEFORE INSERT OR UPDATE ON public.osm_buildings FOR EACH ROW EXECUTE PROCEDURE public.kartoza_building_admin_boundary_mapper();
