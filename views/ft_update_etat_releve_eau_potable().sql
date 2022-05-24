-- FUNCTION: chantiers.ft_update_etat_releve_eau_potable()

-- DROP FUNCTION chantiers.ft_update_etat_releve_eau_potable();

CREATE FUNCTION chantiers.ft_update_etat_releve_eau_potable()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
		IF NEW.eau_potable IS TRUE AND NEW.eau_potable_import IS TRUE AND NEW.eau_potable_report IS TRUE THEN
		   NEW.etat_releve_eau_potable := 1;
		ELSIF NEW.eau_potable IS TRUE AND NEW.eau_potable_report IS FALSE THEN
		   NEW.etat_releve_eau_potable := 0;
		ELSIF NEW.eau_potable IS FALSE THEN
		   NEW.etat_releve_eau_potable := 1;
		ELSE 
		   NEW.etat_releve_eau_potable := 0;
		END IF;
		RETURN NEW;
	END;
$BODY$;

ALTER FUNCTION chantiers.ft_update_etat_releve_eau_potable()
    OWNER TO pulfase;
