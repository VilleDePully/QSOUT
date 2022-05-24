-- FUNCTION: chantiers.ft_update_etat_releve_assainissement()

-- DROP FUNCTION chantiers.ft_update_etat_releve_assainissement();

CREATE FUNCTION chantiers.ft_update_etat_releve_assainissement()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
		IF NEW.assainissement IS TRUE AND NEW.assainissement_import IS TRUE AND NEW.assainissement_report IS TRUE THEN
		   NEW.etat_releve_assainissement := 1;
		ELSIF NEW.assainissement IS TRUE AND NEW.assainissement_report IS FALSE THEN
		   NEW.etat_releve_assainissement := 0;
		ELSIF NEW.assainissement IS FALSE THEN
		   NEW.etat_releve_assainissement := 1;
		ELSE 
		   NEW.etat_releve_assainissement := 0;
		END IF;
		RETURN NEW;
	END;
$BODY$;

ALTER FUNCTION chantiers.ft_update_etat_releve_assainissement()
    OWNER TO pulfase;
