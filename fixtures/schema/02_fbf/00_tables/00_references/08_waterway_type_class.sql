
--
-- Name: waterway_type_class; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE IF NOT EXISTS public.waterway_type_class (
    id integer NOT NULL,
    waterway_class character varying(100),
    constraint waterway_type_class_pkey primary key (id)
);


--
-- Name: waterway_type_class_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE IF NOT EXISTS public.waterway_type_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: waterway_type_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.waterway_type_class_id_seq OWNED BY public.waterway_type_class.id;

--
-- Name: waterway_type_class id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.waterway_type_class ALTER COLUMN id SET DEFAULT nextval('public.waterway_type_class_id_seq'::regclass);


