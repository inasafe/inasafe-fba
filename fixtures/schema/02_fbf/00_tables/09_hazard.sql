--
-- Name: hazard; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE IF NOT EXISTS public.hazard (
    id integer NOT NULL,
    geometry public.geometry(MultiPolygon,4326),
    name character varying(80),
    source character varying(255),
    reporting_date_time timestamp without time zone,
    forecast_date_time timestamp without time zone,
    station character varying(255)
);

--
-- Name: osm_flood_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE IF NOT EXISTS public.osm_flood_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: osm_flood_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.osm_flood_id_seq OWNED BY public.hazard.id;

-- Name: id_osm_flood_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX id_osm_flood_idx ON public.hazard USING btree (id);


--
-- Name: id_osm_flood_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX id_osm_flood_name ON public.hazard USING btree (name);


--
-- Name: osm_flood_gix; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX osm_flood_gix ON public.hazard USING gist (geometry);
