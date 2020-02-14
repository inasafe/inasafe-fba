INSERT INTO public.config (id, key, value) VALUES (1, 'POSTGREST_BASE_URL', '"http://fbf.test/api/"') ON CONFLICT (id) DO UPDATE SET key = 'POSTGREST_BASE_URL', value = '"http://fbf.test/api/"' ;
INSERT INTO public.config (id, key, value) VALUES (2, 'WMS_BASE_URL', '"http://fbf.test/api/"') ON CONFLICT (id) DO UPDATE SET key = 'POSTGREST_BASE_URL', value = '"http://fbf.test/geoserver/wms"' ;
