-- bulk update, so disable trigger
alter table osm_roads disable trigger all;
select kartoza_evaluate_road_score();
select kartoza_evaluate_road_admin();
-- reenable trigger
alter table osm_roads enable trigger all;

-- trigger database update to check trigger executions
update osm_roads set id = id
where id in (
    select id from osm_roads limit 1)
