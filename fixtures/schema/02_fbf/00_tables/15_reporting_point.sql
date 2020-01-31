--
-- Name: reporting_point; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE IF NOT EXISTS public.reporting_point (
    id bigint NOT NULL,
    glofas_id bigint,
    name character varying(80),
    geometry public.geometry(Point,4326),
    CONSTRAINT reporting_point_pk PRIMARY KEY (id)
);


--
-- Name: reporting_point_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE IF NOT EXISTS public.reporting_point_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reporting_point_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reporting_point_id_seq OWNED BY public.reporting_point.id;

--
-- Name: reporting_point id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reporting_point ALTER COLUMN id SET DEFAULT nextval('public.reporting_point_id_seq'::regclass);

--
-- Name: reporting_point_glofas_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX IF NOT EXISTS reporting_point_glofas_id_uindex ON public.reporting_point USING btree (glofas_id);


--
-- Name: reporting_point_id_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX IF NOT EXISTS reporting_point_id_uindex ON public.reporting_point USING btree (id);
