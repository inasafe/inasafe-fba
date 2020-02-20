create table if not exists public.census
(
    id bigserial not null,
    population bigint,
    elderly bigint,
    females bigint,
    males bigint,
    unemployed bigint,
    village_id bigint
        constraint census_village_village_code_fk
            references public.village
);

create unique index if not exists census_village_id_uindex
    on public.census (village_id);
