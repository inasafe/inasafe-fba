--
-- Name: hazard_class; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE IF NOT EXISTS public.hazard_class (
    id integer NOT NULL,
    min_m double precision,
    max_m double precision,
    label character varying(255),
    CONSTRAINT depth_class_pkey PRIMARY KEY (id)
);

--
-- Name: depth_class_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE IF NOT EXISTS public.depth_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: depth_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.depth_class_id_seq OWNED BY public.hazard_class.id;



--
-- Name: hazard_class id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hazard_class ALTER COLUMN id SET DEFAULT nextval('public.depth_class_id_seq'::regclass);
