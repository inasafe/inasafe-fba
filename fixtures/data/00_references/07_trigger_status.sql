INSERT INTO public.trigger_status (id, name) VALUES (1, 'pre-activation') ON CONFLICT DO NOTHING ;
INSERT INTO public.trigger_status (id, name) VALUES (2, 'activation') ON CONFLICT DO NOTHING ;
INSERT INTO public.trigger_status (id, name) VALUES (3, 'stop') ON CONFLICT DO NOTHING ;
INSERT INTO public.trigger_status (id, name) VALUES (0, 'no activation') ON CONFLICT DO NOTHING ;
