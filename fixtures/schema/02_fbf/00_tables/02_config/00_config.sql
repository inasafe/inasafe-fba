CREATE SEQUENCE IF NOT EXISTS public.config_id_sq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE IF NOT EXISTS public.config (
    id integer NOT NULL default nextval('public.config_id_sq'::regclass),
    key character varying(255),
    value json,
    constraint config_id_pkey primary key (id),
    constraint config_key_unique unique (key)
);
