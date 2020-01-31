
-- Name: satisfy_dependency(character varying); Type: FUNCTION; Schema: public; Owner: -
--
DROP FUNCTION IF EXISTS public.satisfy_dependency;
CREATE FUNCTION public.satisfy_dependency(package character varying) RETURNS character varying
    LANGUAGE plpython3u
    AS $$
import subprocess
import importlib

try:
  importlib.import_module(package)
except ModuleNotFoundError:
  subprocess.check_call(["pip3", "install", package])
return 'OK'

$$;
