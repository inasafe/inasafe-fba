DELETE FROM hazard_areas WHERE hazard_areas.flood_map_id = 85;
DELETE FROM hazard_area WHERE id NOT IN (SELECT flooded_area_id FROM hazard_areas);

DELETE FROM spreadsheet_reports WHERE flood_event_id = 257;
DELETE FROM hazard_event WHERE id = 257;
DELETE FROM hazard_map WHERE id = 85;
