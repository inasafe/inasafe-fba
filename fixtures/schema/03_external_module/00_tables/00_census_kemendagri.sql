-- Table structure taken from ArcGIS REST API of GIS Dukcapil Kemendagri Indonesia:
-- source: https://gis.dukcapil.kemendagri.go.id/peta/
-- ArcGIS REST API Endpoint: https://gis.dukcapil.kemendagri.go.id/arcgis/rest/services/Data_Baru_26092017/MapServer/
create table census_kemendagri
(
    objectid bigint not null,
    no_prop double precision,
    no_kab double precision,
    no_kec double precision,
    no_kel double precision,
    kode_desa_ varchar(25),
    nama_prop_ varchar(40),
    nama_kab_s varchar(40) not null,
    nama_kec_s varchar(40) not null,
    nama_kel_s varchar(40) not null,
    jumlah_pen double precision,
    jumlah_kk double precision,
    pria double precision,
    wanita double precision,
    u0 double precision,
    u5 double precision,
    u10 double precision,
    u15 double precision,
    u20 double precision,
    u25 double precision,
    u30 double precision,
    u35 double precision,
    u40 double precision,
    u45 double precision,
    u50 double precision,
    u55 double precision,
    u60 double precision,
    u65 double precision,
    u70 double precision,
    u75 double precision,
    p01_belum_ double precision,
    constraint census_kemendagri_pk
        primary key (nama_kab_s, nama_kec_s, nama_kel_s)
);

create unique index census_kemendagri_objectid_uindex
    on census_kemendagri (objectid);
