-- bulk update, so disable trigger
alter table osm_buildings disable trigger all;
select kartoza_evaluate_building_score();
select kartoza_evaluate_building_admin();
-- reenable trigger
alter table osm_buildings enable trigger all;

-- trigger database update to check trigger executions
update osm_buildings set id = id
where id in (
    select id from osm_buildings limit 1)
