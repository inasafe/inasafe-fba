--
-- Name: sub_district_trigger_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sub_district_trigger_status (
    id integer NOT NULL,
    sub_district_id double precision,
    trigger_status integer,
    flood_event_id integer
);


--
-- Name: sub_district_trigger_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sub_district_trigger_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sub_district_trigger_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sub_district_trigger_status_id_seq OWNED BY public.sub_district_trigger_status.id;


--
-- Name: sub_district_trigger_status id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sub_district_trigger_status ALTER COLUMN id SET DEFAULT nextval('public.sub_district_trigger_status_id_seq'::regclass);

--
-- Name: sub_district_trigger_status sub_district_trigger_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sub_district_trigger_status
    ADD CONSTRAINT sub_district_trigger_status_pkey PRIMARY KEY (id);

--
-- Name: sub_district_trigger_status sub_district_trigger_status_trigger_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sub_district_trigger_status
    ADD CONSTRAINT sub_district_trigger_status_trigger_status_fkey FOREIGN KEY (trigger_status) REFERENCES public.trigger_status(id);
