--
-- Name: spreadsheet_reports flood_report_tg; Type: TRIGGER; Schema: public; Owner: -
--
-- DROP TRIGGER IF EXISTS  flood_report_tg ON public.spreadsheet_reports;
-- CREATE TRIGGER flood_report_tg BEFORE INSERT ON public.spreadsheet_reports FOR EACH ROW EXECUTE PROCEDURE public.kartoza_generate_excel_report_for_flood();

