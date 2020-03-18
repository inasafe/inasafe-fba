create table if not exists world_pop_district_stats
(
	id integer not null
        constraint world_pop_district_stats_pkey
            primary key,
	prov_code double precision,
	dc_code double precision,
	name varchar(254),
	pop_count double precision,
	pop_sum double precision,
	pop_mean double precision,
	pop_median double precision,
	pop_min double precision,
	pop_max double precision,
	pop_minority double precision,
	pop_majority double precision,
	pop_variety integer,
	pop_variance double precision
);


create unique index if not exists world_pop_district_stats_dc_code_uindex
	on world_pop_district_stats (dc_code);


create sequence if not exists world_pop_district_stats_id_seq;

alter table world_pop_district_stats alter column id set default nextval('public.world_pop_district_stats_id_seq');

alter sequence world_pop_district_stats_id_seq owned by world_pop_district_stats.id;


