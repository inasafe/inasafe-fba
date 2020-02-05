
--
-- Name: hazard_event hazard_event_tg_99_populate_spreadsheet; Type: TRIGGER; Schema: public; Owner: -
--
DROP TRIGGER IF EXISTS hazard_event_tg_99_populate_spreadsheet ON public.hazard_event;
CREATE TRIGGER hazard_event_tg_99_populate_spreadsheet AFTER INSERT ON public.hazard_event FOR EACH ROW EXECUTE PROCEDURE public.kartoza_populate_spreadsheet_table();
