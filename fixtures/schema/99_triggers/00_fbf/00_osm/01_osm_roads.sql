DROP TRIGGER IF EXISTS osm_roads_tg_00_road_type_mapper_tg ON public.osm_roads;
CREATE TRIGGER osm_roads_tg_00_road_type_mapper_tg BEFORE INSERT OR UPDATE ON public.osm_roads FOR EACH ROW EXECUTE PROCEDURE public.kartoza_road_type_mapping();

DROP TRIGGER IF EXISTS osm_roads_tg_00_building_admin_mapper_tg ON public.osm_roads;
CREATE TRIGGER osm_roads_tg_00_building_admin_mapper_tg BEFORE INSERT OR UPDATE ON public.osm_roads FOR EACH ROW EXECUTE PROCEDURE public.kartoza_road_admin_boundary_mapper();

DROP TRIGGER IF EXISTS osm_roads_tg_01_road_type_score_tg ON public.osm_roads;
CREATE TRIGGER osm_roads_tg_01_road_type_score_tg AFTER INSERT OR UPDATE ON osm_roads FOR EACH ROW EXECUTE PROCEDURE public.kartoza_road_score_mapper();
