TRUNCATE public.trigger_status CASCADE ;
INSERT INTO public.trigger_status (id, name) VALUES (1, 'pre-activation');
INSERT INTO public.trigger_status (id, name) VALUES (2, 'activation');
INSERT INTO public.trigger_status (id, name) VALUES (3, 'stop');
INSERT INTO public.trigger_status (id, name) VALUES (0, 'no activation');
