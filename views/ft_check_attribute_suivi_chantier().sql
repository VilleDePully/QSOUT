-- FUNCTION: chantiers.ft_check_attribute_suivi_chantier()

-- DROP FUNCTION chantiers.ft_check_attribute_suivi_chantier();

CREATE FUNCTION chantiers.ft_check_attribute_suivi_chantier()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
		CASE
                   WHEN (NEW.fk_reseau = 1 AND NEW.fk_impression_plan_te IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Impression plan TE (ECA)" devrait être renseigné';
                   WHEN (NEW.fk_reseau = 1 AND NEW.fk_envoi_plan_te IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Envoi plan TE (ECA)" devrait être renseigné';
                   WHEN (NEW.fk_reseau = 1 AND NEW.fk_envoi_plan_te = 3 AND NEW.date_envoi_plan_te IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Date envoi plan TE" devrait être renseigné'; 
                   WHEN (NEW.fk_reseau = 1 AND NEW.fk_export_sire IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Export SIRE" devrait être renseigné';
                   WHEN (NEW.fk_reseau  = 1 AND NEW.fk_checker_sire IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Checker SIRE" devrait être renseigné';
                   WHEN (NEW.fk_reseau  = 1 AND NEW.fk_envoi_sire IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Envoi SIRE" devrait être renseigné';
                   WHEN (NEW.fk_reseau = 1 AND NEW.fk_envoi_sire = 3 AND NEW.date_envoi_sire IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Date envoi SIRE" devrait être renseigné';
                   WHEN (NEW.fk_reseau != 1 AND NEW.fk_impression_plan_te IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Impression plan TE (ECA)" devrait être vide';
                   WHEN (NEW.fk_reseau != 1 AND NEW.fk_envoi_plan_te IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Envoi plan TE (ECA)" devrait être vide';
                   WHEN (NEW.fk_reseau != 1 AND NEW.date_envoi_plan_te IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Date envoi plan TE" devrait être vide'; 
                   WHEN (NEW.fk_reseau != 1 AND NEW.fk_export_sire IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Export SIRE" devrait être vide';
                   WHEN (NEW.fk_reseau != 1 AND NEW.fk_checker_sire IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Checker SIRE" devrait être vide';
                   WHEN (NEW.fk_reseau != 1 AND NEW.fk_envoi_sire IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Envoi SIRE" devrait être vide';
                   WHEN (NEW.fk_reseau != 1 AND NEW.date_envoi_sire IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Date envoi SIRE" devrait être vide';
                   WHEN (NEW.fk_reseau = 2 AND NEW.fk_report_installation_existante IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Report des installations existantes" devrait être renseigné';
                   WHEN (NEW.fk_reseau = 2 AND NEW.fk_envoi_plan_existant IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Envoi plan existant" devrait être renseigné';
                   WHEN (NEW.fk_reseau = 2 AND NEW.fk_report_plan_architecte IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Report plan architecte" devrait être renseigné';
		   WHEN (NEW.fk_reseau != 2 AND NEW.fk_report_installation_existante IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Report des installations existantes" devrait être vide';
                   WHEN (NEW.fk_reseau != 2 AND NEW.fk_envoi_plan_existant IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Envoi plan existant" devrait être vide';
                   WHEN (NEW.fk_reseau != 2 AND NEW.fk_report_plan_architecte IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Report plan architecte" devrait être vide';
		   WHEN (NEW.fk_reseau = 3 AND NEW.fk_report_bouclage_definitif IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Report bouclage définitif" devrait être renseigné';
                   WHEN (NEW.fk_reseau = 3 AND NEW.fk_impression_sch IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Impression schématique" devrait être renseigné';
                   WHEN (NEW.fk_reseau = 3 AND NEW.fk_validation_sch IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Validation schématique" devrait être renseigné';
                   WHEN (NEW.fk_reseau != 3 AND NEW.fk_report_bouclage_definitif IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Report bouclage définitif" devrait être vide';
                   WHEN (NEW.fk_reseau != 3 AND NEW.fk_impression_sch IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Impression schématique" devrait être vide';
                   WHEN (NEW.fk_reseau != 3 AND NEW.fk_validation_sch IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Validation schématique" devrait être vide';
                   WHEN (NEW.fk_reseau != 3 AND NEW.schematique_interne_touchee = 'true') THEN
                      RAISE EXCEPTION 'Le champ "Schematique interne touchée?" devrait être vide';
                   WHEN (NEW.fk_reseau IN (4,5) AND NEW.fk_envoi_donnees_externe IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Envoi données à l externe" devrait être renseigné';
                   WHEN (NEW.fk_reseau NOT IN (4,5) AND NEW.fk_envoi_donnees_externe IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Envoi données à l externe" devrait être vide'; 
		   ELSE NULL;
		END CASE;
		RETURN NEW;
	END;
$BODY$;

ALTER FUNCTION chantiers.ft_check_attribute_suivi_chantier()
    OWNER TO pulfase;
