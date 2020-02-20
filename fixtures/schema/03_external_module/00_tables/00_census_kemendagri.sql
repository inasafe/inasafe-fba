-- Table structure taken from ArcGIS REST API of GIS Dukcapil Kemendagri Indonesia:
-- source: https://gis.dukcapil.kemendagri.go.id/peta/
-- ArcGIS REST API Endpoint: https://gis.dukcapil.kemendagri.go.id/arcgis/rest/services/Data_Baru_26092017/MapServer/

create table if not exists public.census_kemendagri
(
    objectid bigint not null ,
    no_prop float8,
    no_kab float8,
    no_kec float8,
    no_kel float8,
    kode_desa_ varchar(25),
    nama_prop_ varchar(40),
    nama_kab_s varchar(40),
    nama_kec_s varchar(40),
    nama_kel_s varchar(40),
    jumlah_pen float8,
    jumlah_kk float8,
    pria float8,
    wanita float8,
    u0 float8,
    u5 float8,
    u10 float8,
    u15 float8,
    u20 float8,
    u25 float8,
    u30 float8,
    u35 float8,
    u40 float8,
    u45 float8,
    u50 float8,
    u55 float8,
    u60 float8,
    u65 float8,
    u70 float8,
    u75 float8,
    p01_belum_ float8,
    constraint census_kemendagri_pk primary key (objectid)
);

create unique index if not exists census_kemendagri_objectid_uindex
    on census_kemendagri (objectid);
