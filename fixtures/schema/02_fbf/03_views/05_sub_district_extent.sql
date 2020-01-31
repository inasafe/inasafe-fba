--
-- Name: vw_sub_district_extent; Type: VIEW; Schema: public; Owner: -
--

CREATE OR REPLACE VIEW public.vw_sub_district_extent AS
 SELECT subdistrict_extent.id,
    subdistrict_extent.id_code,
    public.st_xmin((subdistrict_extent.extent)::public.box3d) AS x_min,
    public.st_ymin((subdistrict_extent.extent)::public.box3d) AS y_min,
    public.st_xmax((subdistrict_extent.extent)::public.box3d) AS x_max,
    public.st_ymax((subdistrict_extent.extent)::public.box3d) AS y_max
   FROM ( SELECT sub_district.id,
            sub_district.sub_dc_code AS id_code,
            public.st_extent(sub_district.geom) AS extent
           FROM public.sub_district
          GROUP BY sub_district.id, sub_district.sub_dc_code) subdistrict_extent;

