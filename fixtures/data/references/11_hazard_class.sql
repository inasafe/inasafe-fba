TRUNCATE public.hazard_class CASCADE ;
INSERT INTO public.hazard_class (id, min_m, max_m, label) VALUES (1, 0, 0.7, '0 - 0.7m');
INSERT INTO public.hazard_class (id, min_m, max_m, label) VALUES (2, 0.7, 1.5, '0.7 - 1.5m');
INSERT INTO public.hazard_class (id, min_m, max_m, label) VALUES (3, 1.5, 3, '1.5 - 3.0m');
INSERT INTO public.hazard_class (id, min_m, max_m, label) VALUES (4, 3, 999999, '3 or greater');
