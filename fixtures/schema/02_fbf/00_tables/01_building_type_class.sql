--
-- Name: building_type_class; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE IF NOT EXISTS public.building_type_class (
    id integer NOT NULL,
    building_class character varying(100)
);


--
-- Name: building_type_class_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE IF NOT EXISTS public.building_type_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: building_type_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.building_type_class_id_seq OWNED BY public.building_type_class.id;


--
-- Name: building_type_class id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.building_type_class ALTER COLUMN id SET DEFAULT nextval('public.building_type_class_id_seq'::regclass);


