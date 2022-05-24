-- FUNCTION: chantiers.ft_update_etat_releve_gaz()

-- DROP FUNCTION chantiers.ft_update_etat_releve_gaz();

CREATE FUNCTION chantiers.ft_update_etat_releve_gaz()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
		IF NEW.gaz IS TRUE AND NEW.gaz_import IS TRUE AND NEW.gaz_report IS TRUE THEN
		   NEW.etat_releve_gaz := 1;
		ELSIF NEW.gaz IS TRUE AND NEW.gaz_report IS FALSE THEN
		   NEW.etat_releve_gaz := 0;
		ELSIF NEW.gaz IS FALSE THEN
		   NEW.etat_releve_gaz := 1;
		ELSE 
		   NEW.etat_releve_gaz := 0;
		END IF;
		RETURN NEW;
	END;
$BODY$;

ALTER FUNCTION chantiers.ft_update_etat_releve_gaz()
    OWNER TO pulfase;
