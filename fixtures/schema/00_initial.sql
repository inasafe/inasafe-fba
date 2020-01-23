--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1 (Debian 12.1-1.pgdg100+1)
-- Dumped by pg_dump version 12.1 (Debian 12.1-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;



--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA IF NOT EXISTS public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: asbinary(public.geometry); Type: FUNCTION; Schema: public; Owner: -
--


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: layer_styles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.layer_styles (
    id integer NOT NULL,
    f_table_catalog character varying,
    f_table_schema character varying,
    f_table_name character varying,
    f_geometry_column character varying,
    stylename character varying(30),
    styleqml xml,
    stylesld xml,
    useasdefault boolean,
    description text,
    owner character varying(30),
    ui xml,
    update_time timestamp without time zone DEFAULT now()
);


--
-- Name: layer_styles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.layer_styles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: layer_styles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.layer_styles_id_seq OWNED BY public.layer_styles.id;


--
-- Name: osm_admin; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.osm_admin (
    id integer NOT NULL,
    osm_id bigint NOT NULL,
    name character varying,
    type character varying,
    admin_level integer,
    geometry public.geometry(Geometry,4326)
);


--
-- Name: osm_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.osm_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: osm_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.osm_admin_id_seq OWNED BY public.osm_admin.id;


--
-- Name: osm_buildings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.osm_buildings (
    id integer NOT NULL,
    osm_id bigint NOT NULL,
    name character varying,
    leisure character varying,
    height integer,
    "building:levels" character varying,
    "building:height" integer,
    "building:min_level" integer,
    "roof:height" integer,
    "roof:material" character varying,
    "building:material" character varying,
    use character varying,
    religon character varying,
    type character varying,
    amenity character varying,
    landuse character varying,
    geometry public.geometry(Geometry,4326)
);


--
-- Name: osm_buildings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.osm_buildings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: osm_buildings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.osm_buildings_id_seq OWNED BY public.osm_buildings.id;


--
-- Name: osm_roads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.osm_roads (
    id integer NOT NULL,
    osm_id bigint NOT NULL,
    type character varying,
    name character varying,
    oneway smallint,
    z_order integer,
    service character varying,
    class character varying,
    geometry public.geometry(LineString,4326)
);


--
-- Name: osm_roads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.osm_roads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: osm_roads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.osm_roads_id_seq OWNED BY public.osm_roads.id;


--
-- Name: osm_waterways; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.osm_waterways (
    id integer NOT NULL,
    osm_id bigint NOT NULL,
    name character varying,
    waterway character varying,
    geometry public.geometry(LineString,4326)
);


--
-- Name: osm_waterways_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.osm_waterways_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: osm_waterways_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.osm_waterways_id_seq OWNED BY public.osm_waterways.id;


--
-- Name: layer_styles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.layer_styles ALTER COLUMN id SET DEFAULT nextval('public.layer_styles_id_seq'::regclass);


--
-- Name: osm_admin id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.osm_admin ALTER COLUMN id SET DEFAULT nextval('public.osm_admin_id_seq'::regclass);


--
-- Name: osm_buildings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.osm_buildings ALTER COLUMN id SET DEFAULT nextval('public.osm_buildings_id_seq'::regclass);


--
-- Name: osm_roads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.osm_roads ALTER COLUMN id SET DEFAULT nextval('public.osm_roads_id_seq'::regclass);


--
-- Name: osm_waterways id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.osm_waterways ALTER COLUMN id SET DEFAULT nextval('public.osm_waterways_id_seq'::regclass);


--
-- Name: layer_styles layer_styles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.layer_styles
    ADD CONSTRAINT layer_styles_pkey PRIMARY KEY (id);


--
-- Name: osm_admin osm_admin_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.osm_admin
    ADD CONSTRAINT osm_admin_pkey PRIMARY KEY (osm_id, id);


--
-- Name: osm_buildings osm_buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.osm_buildings
    ADD CONSTRAINT osm_buildings_pkey PRIMARY KEY (osm_id, id);


--
-- Name: osm_roads osm_roads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.osm_roads
    ADD CONSTRAINT osm_roads_pkey PRIMARY KEY (osm_id, id);


--
-- Name: osm_waterways osm_waterways_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.osm_waterways
    ADD CONSTRAINT osm_waterways_pkey PRIMARY KEY (osm_id, id);


--
-- Name: osm_admin_geom; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX osm_admin_geom ON public.osm_admin USING gist (geometry);


--
-- Name: osm_buildings_geom; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX osm_buildings_geom ON public.osm_buildings USING gist (geometry);


--
-- Name: osm_roads_geom; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX osm_roads_geom ON public.osm_roads USING gist (geometry);


--
-- Name: osm_waterways_geom; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX osm_waterways_geom ON public.osm_waterways USING gist (geometry);





--
-- PostgreSQL database dump complete
--

