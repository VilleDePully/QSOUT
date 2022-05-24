-- FUNCTION: chantiers.ft_update_etat_releve_cablecom()

-- DROP FUNCTION chantiers.ft_update_etat_releve_cablecom();

CREATE FUNCTION chantiers.ft_update_etat_releve_cablecom()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
		IF NEW.cablecom IS TRUE AND NEW.cablecom_import IS TRUE AND NEW.cablecom_report IS TRUE THEN
		   NEW.etat_releve_cablecom := 1;
		ELSIF NEW.cablecom IS TRUE AND NEW.cablecom_report IS FALSE THEN
		   NEW.etat_releve_cablecom := 0;
		ELSIF NEW.cablecom IS FALSE THEN
		   NEW.etat_releve_cablecom := 1;
		ELSE 
		   NEW.etat_releve_cablecom := 0;
		END IF;
		RETURN NEW;
	END;
$BODY$;

ALTER FUNCTION chantiers.ft_update_etat_releve_cablecom()
    OWNER TO pulfase;
