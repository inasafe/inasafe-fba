INSERT INTO public.progress_status (id, status) VALUES (1, 'in_progress') ON CONFLICT DO NOTHING ;
INSERT INTO public.progress_status (id, status) VALUES (2, 'done') ON CONFLICT DO NOTHING ;
