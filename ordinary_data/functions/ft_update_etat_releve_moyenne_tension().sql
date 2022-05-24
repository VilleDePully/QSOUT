-- FUNCTION: chantiers.ft_update_etat_releve_moyenne_tension()

-- DROP FUNCTION chantiers.ft_update_etat_releve_moyenne_tension();

CREATE FUNCTION chantiers.ft_update_etat_releve_moyenne_tension()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
		IF NEW.moyenne_tension IS TRUE AND NEW.moyenne_tension_import IS TRUE AND NEW.moyenne_tension_report IS TRUE THEN
		   NEW.etat_releve_moyenne_tension := 1;
		ELSIF NEW.moyenne_tension IS TRUE AND NEW.moyenne_tension_report IS FALSE THEN
		   NEW.etat_releve_moyenne_tension := 0;
		ELSIF NEW.moyenne_tension IS FALSE THEN
		   NEW.etat_releve_moyenne_tension := 1;
		ELSE 
		   NEW.etat_releve_moyenne_tension := 0;
		END IF;
		RETURN NEW;
	END;
$BODY$;

ALTER FUNCTION chantiers.ft_update_etat_releve_moyenne_tension()
    OWNER TO pulfase;
