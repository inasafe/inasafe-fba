select
       prov_code::int,
       dc_code::int,
       sub_dc_code::bigint,
       village_code::bigint,
       name,
       round(pop_sum)::bigint as pop_sum,
       round(pop_count)::bigint as pop_count,
       round(pop_mean)::bigint as pop_mean,
       round(pop_min)::bigint as pop_min,
       round(pop_max)::bigint as pop_max
from world_pop_village_stats;
