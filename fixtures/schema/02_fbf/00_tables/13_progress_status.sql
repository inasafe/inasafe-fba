--
-- Name: progress_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE IF NOT EXISTS public.progress_status (
    id integer NOT NULL,
    status character varying(50),
    CONSTRAINT progress_status_pkey PRIMARY KEY (id)
);


--
-- Name: progress_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE IF NOT EXISTS public.progress_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: progress_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.progress_status_id_seq OWNED BY public.progress_status.id;


--
-- Name: progress_status id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.progress_status ALTER COLUMN id SET DEFAULT nextval('public.progress_status_id_seq'::regclass);
