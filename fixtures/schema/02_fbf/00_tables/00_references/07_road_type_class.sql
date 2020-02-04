--
-- Name: road_type_class; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE IF NOT EXISTS public.road_type_class (
    id integer NOT NULL,
    road_class character varying(100),
    constraint road_type_class_pkey primary key (id)
);


--
-- Name: road_type_class_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE IF NOT EXISTS public.road_type_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: road_type_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.road_type_class_id_seq OWNED BY public.road_type_class.id;

--
-- Name: road_type_class id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.road_type_class ALTER COLUMN id SET DEFAULT nextval('public.road_type_class_id_seq'::regclass);
