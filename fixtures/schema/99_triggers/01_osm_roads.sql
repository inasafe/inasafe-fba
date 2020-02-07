DROP TRIGGER IF EXISTS osm_roads_tg_00_building_admin_mapper_tg ON public.osm_roads;
CREATE TRIGGER osm_roads_tg_00_building_admin_mapper_tg BEFORE INSERT OR UPDATE ON public.osm_roads FOR EACH ROW EXECUTE PROCEDURE public.kartoza_road_admin_boundary_mapper();
