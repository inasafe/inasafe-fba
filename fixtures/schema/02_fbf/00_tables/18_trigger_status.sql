--
-- Name: trigger_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trigger_status (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: trigger_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.trigger_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: trigger_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.trigger_status_id_seq OWNED BY public.trigger_status.id;



--
-- Name: trigger_status id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trigger_status ALTER COLUMN id SET DEFAULT nextval('public.trigger_status_id_seq'::regclass);

--
-- Name: trigger_status status_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trigger_status
    ADD CONSTRAINT status_name_key UNIQUE (name);

--
-- Name: trigger_status trigger_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trigger_status
    ADD CONSTRAINT trigger_status_pkey PRIMARY KEY (id);
