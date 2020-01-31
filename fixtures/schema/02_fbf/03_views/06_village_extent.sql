--
-- Name: vw_village_extent; Type: VIEW; Schema: public; Owner: -
--

CREATE OR REPLACE VIEW public.vw_village_extent AS
 SELECT village_extent.id,
    village_extent.id_code,
    public.st_xmin((village_extent.extent)::public.box3d) AS x_min,
    public.st_ymin((village_extent.extent)::public.box3d) AS y_min,
    public.st_xmax((village_extent.extent)::public.box3d) AS x_max,
    public.st_ymax((village_extent.extent)::public.box3d) AS y_max
   FROM ( SELECT village.id,
            village.village_code AS id_code,
            public.st_extent(village.geom) AS extent
           FROM public.village
          GROUP BY village.id, village.village_code) village_extent;

