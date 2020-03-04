DROP TRIGGER IF EXISTS census_kemendagri_tg_00 ON public.census_kemendagri;
CREATE TRIGGER census_kemendagri_tg_00 AFTER INSERT OR UPDATE ON public.census_kemendagri FOR EACH ROW EXECUTE PROCEDURE public.kartoza_census_kemendagri_populate_census();
