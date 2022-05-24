-- FUNCTION: chantiers.ft_get_folios()

-- DROP FUNCTION chantiers.ft_get_folios();

CREATE FUNCTION chantiers.ft_get_folios()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE
	result text;
	BEGIN
	SELECT string_agg(folios.numero , ', ') INTO result
			FROM  plans.folios
			WHERE ST_Intersects(NEW.the_geom,folios.geometry) IS TRUE;
		NEW.folios := result;		
		RETURN NEW;
	END;
$BODY$;

ALTER FUNCTION chantiers.ft_get_folios()
    OWNER TO pulfase;
