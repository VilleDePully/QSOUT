-- FUNCTION: chantiers.ft_update_etat_releve_swisscom()

-- DROP FUNCTION chantiers.ft_update_etat_releve_swisscom();

CREATE FUNCTION chantiers.ft_update_etat_releve_swisscom()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
		IF NEW.swisscom IS TRUE AND NEW.swisscom_import IS TRUE AND NEW.swisscom_report IS TRUE THEN
		   NEW.etat_releve_swisscom := 1;
		ELSIF NEW.swisscom IS TRUE AND NEW.swisscom_report IS FALSE THEN
		   NEW.etat_releve_swisscom := 0;
		ELSIF NEW.swisscom IS FALSE THEN
		   NEW.etat_releve_swisscom := 1;
		ELSE 
		   NEW.etat_releve_swisscom := 0;
		END IF;
		RETURN NEW;
	END;
$BODY$;

ALTER FUNCTION chantiers.ft_update_etat_releve_swisscom()
    OWNER TO pulfase;
