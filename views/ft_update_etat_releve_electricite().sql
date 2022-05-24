-- FUNCTION: chantiers.ft_update_etat_releve_electricite()

-- DROP FUNCTION chantiers.ft_update_etat_releve_electricite();

CREATE FUNCTION chantiers.ft_update_etat_releve_electricite()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
		IF NEW.electricite IS TRUE AND NEW.electricite_import IS TRUE AND NEW.electricite_report IS TRUE THEN
		   NEW.etat_releve_electricite := 1;
		ELSIF NEW.electricite IS TRUE AND NEW.electricite_report IS FALSE THEN
		   NEW.etat_releve_electricite := 0;
		ELSIF NEW.electricite IS FALSE THEN
		   NEW.etat_releve_electricite := 1;
		ELSE 
		   NEW.etat_releve_electricite := 0;
		END IF;
		RETURN NEW;
	END;
$BODY$;

ALTER FUNCTION chantiers.ft_update_etat_releve_electricite()
    OWNER TO pulfase;
