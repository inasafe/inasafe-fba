
--
-- Name: report_notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE IF NOT EXISTS public.report_notes (
    id integer NOT NULL,
    notes text,
    hazard_type integer,
    "order" integer,
    CONSTRAINT report_notes_hazard_type_fkey FOREIGN KEY (hazard_type) REFERENCES public.hazard_type(id),
    CONSTRAINT report_notes_pkey PRIMARY KEY (id)
);


--
-- Name: report_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE IF NOT EXISTS public.report_notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: report_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.report_notes_id_seq OWNED BY public.report_notes.id;


--
-- Name: report_notes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.report_notes ALTER COLUMN id SET DEFAULT nextval('public.report_notes_id_seq'::regclass);

