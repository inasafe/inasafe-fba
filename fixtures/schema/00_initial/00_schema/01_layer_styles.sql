CREATE SEQUENCE IF NOT EXISTS public.layer_styles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE IF NOT EXISTS public.layer_styles (
    id integer NOT NULL,
    f_table_catalog character varying,
    f_table_schema character varying,
    f_table_name character varying,
    f_geometry_column character varying,
    stylename character varying(30),
    styleqml xml,
    stylesld xml,
    useasdefault boolean,
    description text,
    owner character varying(30),
    ui xml,
    update_time timestamp without time zone DEFAULT now(),
    constraint layer_styles_pkey
        primary key (id)
);


ALTER SEQUENCE public.layer_styles_id_seq OWNED BY public.layer_styles.id;



ALTER TABLE ONLY public.layer_styles ALTER COLUMN id SET DEFAULT nextval('public.layer_styles_id_seq'::regclass);
