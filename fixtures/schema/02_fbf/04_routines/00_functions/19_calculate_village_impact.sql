drop function if exists kartoza_fba_calculate_village_impact;
create or replace function kartoza_fba_calculate_village_impact(event_id int, impact_limit double precision) returns
    table (
        flood_event_id int,
        district_id double precision,
        sub_district_id double precision,
        village_id double precision,
        impact_ratio numeric
          )
    language plpgsql
as
$$
    begin
        return query
WITH total_village_count_table AS (
    SELECT mv_non_flooded_building_summary.district_id,
           mv_non_flooded_building_summary.sub_district_id,
           mv_non_flooded_building_summary.village_id,
           sum(
                   mv_non_flooded_building_summary.building_type_count) AS total_building
    FROM mv_non_flooded_building_summary
    WHERE ((mv_non_flooded_building_summary.district_id IS NOT NULL) AND
           (mv_non_flooded_building_summary.sub_district_id IS NOT NULL) AND
           (mv_non_flooded_building_summary.village_id IS NOT NULL))
    GROUP BY mv_non_flooded_building_summary.district_id,
             mv_non_flooded_building_summary.sub_district_id,
             mv_non_flooded_building_summary.village_id
),
     building_filter AS (
         SELECT mv_flood_event_buildings.flood_event_id,
                mv_flood_event_buildings.district_id,
                mv_flood_event_buildings.sub_district_id,
                mv_flood_event_buildings.village_id,
                mv_flood_event_buildings.building_id,
                max(mv_flood_event_buildings.depth_class) AS             depth_class,
                max(
                        mv_flood_event_buildings.total_vulnerability) AS total_vulnerability
         FROM mv_flood_event_buildings
         WHERE
             mv_flood_event_buildings.flood_event_id = event_id AND
               ((mv_flood_event_buildings.district_id IS NOT NULL) AND
                (mv_flood_event_buildings.sub_district_id IS NOT NULL) AND
                (mv_flood_event_buildings.village_id IS NOT NULL))
         GROUP BY mv_flood_event_buildings.flood_event_id,
                  mv_flood_event_buildings.district_id,
                  mv_flood_event_buildings.sub_district_id,
                  mv_flood_event_buildings.village_id,
                  mv_flood_event_buildings.building_id
     ),
     impact_count AS (
         SELECT building_filter.flood_event_id,
                building_filter.village_id,
                CASE
                    WHEN ((building_filter.depth_class = 2) AND
                          (building_filter.total_vulnerability > 0.6))
                        THEN 1
                    WHEN ((building_filter.depth_class = 3) AND
                          (building_filter.total_vulnerability > 0.3))
                        THEN 1
                    WHEN ((building_filter.depth_class = 4) AND
                          (building_filter.total_vulnerability >
                           (0)::numeric)) THEN 1
                    ELSE 0
                    END AS impacted_count
         FROM building_filter
     ),
     impact_sum AS (
         SELECT impact_count.flood_event_id,
                impact_count.village_id,
                sum(impact_count.impacted_count) AS total_impact
         FROM impact_count
         GROUP BY impact_count.flood_event_id, impact_count.village_id
     )
SELECT impact_sum.flood_event_id,
       total_village_count_table.district_id::double precision,
       total_village_count_table.sub_district_id::double precision,
       impact_sum.village_id::double precision,
       ((impact_sum.total_impact)::numeric /
        total_village_count_table.total_building) AS impact_ratio
FROM (total_village_count_table
         JOIN impact_sum ON (((impact_sum.village_id =
                               total_village_count_table.village_id) AND
                              (total_village_count_table.total_building >
                               (0)::numeric))))
WHERE ((impact_sum.total_impact)::numeric /
       total_village_count_table.total_building) >= impact_limit;
end;
$$
