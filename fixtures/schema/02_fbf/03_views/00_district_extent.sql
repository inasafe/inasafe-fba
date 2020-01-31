--
-- Name: vw_district_extent; Type: VIEW; Schema: public; Owner: -
--

CREATE OR REPLACE VIEW public.vw_district_extent AS
 SELECT district_extent.id,
    district_extent.id_code,
    public.st_xmin((district_extent.extent)::public.box3d) AS x_min,
    public.st_ymin((district_extent.extent)::public.box3d) AS y_min,
    public.st_xmax((district_extent.extent)::public.box3d) AS x_max,
    public.st_ymax((district_extent.extent)::public.box3d) AS y_max
   FROM ( SELECT district.id,
            district.dc_code AS id_code,
            public.st_extent(district.geom) AS extent
           FROM public.district
          GROUP BY district.id, district.dc_code) district_extent;
