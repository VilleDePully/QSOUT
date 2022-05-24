-- FUNCTION: chantiers.ft_update_etat_releve_divers_tiers()

-- DROP FUNCTION chantiers.ft_update_etat_releve_divers_tiers();

CREATE FUNCTION chantiers.ft_update_etat_releve_divers_tiers()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
		IF NEW.divers_tiers IS TRUE AND NEW.divers_tiers_import IS TRUE AND NEW.divers_tiers_report IS TRUE THEN
		   NEW.etat_releve_divers_tiers := 1;
		ELSIF NEW.divers_tiers IS TRUE AND NEW.divers_tiers_report IS FALSE THEN
		   NEW.etat_releve_divers_tiers := 0;
		ELSIF NEW.divers_tiers IS FALSE THEN
		   NEW.etat_releve_divers_tiers := 1;
		ELSE 
		   NEW.etat_releve_divers_tiers := 0;
		END IF;
		RETURN NEW;
	END;
$BODY$;

ALTER FUNCTION chantiers.ft_update_etat_releve_divers_tiers()
    OWNER TO pulfase;
