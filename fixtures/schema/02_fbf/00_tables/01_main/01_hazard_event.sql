--
-- Name: hazard_event; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE IF NOT EXISTS public.hazard_event (
    id integer NOT NULL,
    flood_map_id integer,
    acquisition_date timestamp without time zone DEFAULT now() NOT NULL,
    forecast_date timestamp without time zone,
    source text,
    notes text,
    link text,
    trigger_status integer,
    progress integer,
    hazard_type_id integer,
    CONSTRAINT flood_event_progress_fkey FOREIGN KEY (progress) REFERENCES public.progress_status(id),
    CONSTRAINT flood_event_trigger_status_fkey FOREIGN KEY (trigger_status) REFERENCES public.trigger_status(id),
    CONSTRAINT forecast_flood_event_flood_map_id_fkey FOREIGN KEY (flood_map_id) REFERENCES public.hazard_map(id),
    CONSTRAINT hazard_type_fkey FOREIGN KEY (hazard_type_id) REFERENCES public.hazard_type(id),
    CONSTRAINT forecast_flood_event_pkey PRIMARY KEY (id)
);


--
-- Name: forecast_flood_event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE IF NOT EXISTS public.forecast_flood_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forecast_flood_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.forecast_flood_event_id_seq OWNED BY public.hazard_event.id;

--
-- Name: hazard_event id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hazard_event ALTER COLUMN id SET DEFAULT nextval('public.forecast_flood_event_id_seq'::regclass);

--
-- Name: flood_event_idx_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX IF NOT EXISTS flood_event_idx_id ON public.hazard_event USING btree (id);


--
-- Name: flood_event_idx_map_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX IF NOT EXISTS flood_event_idx_map_id ON public.hazard_event USING btree (flood_map_id);
