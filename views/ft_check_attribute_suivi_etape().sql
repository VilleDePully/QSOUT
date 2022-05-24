-- FUNCTION: chantiers.ft_check_attribute_suivi_etape()

-- DROP FUNCTION chantiers.ft_check_attribute_suivi_etape();

CREATE FUNCTION chantiers.ft_check_attribute_suivi_etape()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
		CASE
		   WHEN (NEW.fk_reseau = 1 AND NEW.fk_numero_vanne IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Numérotation des vannes" devrait être renseigné';
                   WHEN (NEW.fk_reseau = 1 AND NEW.fk_numero_bh IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Numérotation de BH" devrait être renseigné';
                   WHEN (NEW.fk_reseau != 1 AND NEW.fk_numero_vanne IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Numérotation des vannes" devrait être vide';
                   WHEN (NEW.fk_reseau != 1 AND NEW.fk_numero_bh IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Numérotation de BH" devrait être vide';
                   WHEN (NEW.fk_reseau IN (1,2) AND NEW.fk_impression_plan_te IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Impression plan TE" devrait être renseigné';
                   WHEN (NEW.fk_reseau  IN (1,2) AND NEW.fk_releve_complement IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Relevé complémentaire" devrait être renseigné';
                   WHEN (NEW.fk_reseau  IN (1,2) AND NEW.fk_report_complement IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Report de complément" devrait être renseigné';
                   WHEN (NEW.fk_reseau  IN (1,2) AND NEW.fk_validation_plan_te IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Validation plan TE" devrait être renseigné';
                    WHEN (NEW.fk_reseau NOT IN (1,2) AND NEW.fk_impression_plan_te IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Impression plan TE" devrait être vide';
                   WHEN (NEW.fk_reseau  NOT IN (1,2) AND NEW.fk_releve_complement IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Relevé complémentaire" devrait être vide';
                   WHEN (NEW.fk_reseau  NOT IN (1,2) AND NEW.fk_report_complement IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Report de complément" devrait être vide';
                   WHEN (NEW.fk_reseau  NOT IN (1,2) AND NEW.fk_validation_plan_te IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Validation plan TE" devrait être vide';
                   WHEN (NEW.fk_reseau = 1 AND NEW.fk_schematique_nouveau IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Génération nouveau tracé" devrait être renseigné';
                   WHEN (NEW.fk_reseau = 1 AND NEW.fk_schematique_ancien IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Suppression/modification ancien tracé" devrait être renseigné';
                   WHEN (NEW.fk_reseau = 1 AND NEW.fk_schematique_deplacement_vanne IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Déplacement des vannes" devrait être renseigné';
                   WHEN (NEW.fk_reseau = 1 AND NEW.fk_schematique_deplacement_borne_hydrante IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Déplacement des BH" devrait être renseigné';
                   WHEN (NEW.fk_reseau = 1 AND NEW.fk_schematique_deplacement_label IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Déplacement des labels" devrait être renseigné';
                   WHEN (NEW.fk_reseau = 1 AND NEW.fk_schematique_impression_plan IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Impression plan" devrait être renseigné';
                   WHEN (NEW.fk_reseau = 1 AND NEW.fk_schematique_validation_plan IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Validation plan" devrait être renseigné';
                   WHEN (NEW.fk_reseau != 1 AND NEW.fk_schematique_nouveau IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Génération nouveau tracé" devrait être vide';
                   WHEN (NEW.fk_reseau != 1 AND NEW.fk_schematique_ancien IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Suppression/modification ancien tracé" devrait être vide';
                   WHEN (NEW.fk_reseau != 1 AND NEW.fk_schematique_deplacement_vanne IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Déplacement des vannes" devrait être vide';
                   WHEN (NEW.fk_reseau != 1 AND NEW.fk_schematique_deplacement_borne_hydrante IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Déplacement des BH" devrait être vide';
                   WHEN (NEW.fk_reseau != 1 AND NEW.fk_schematique_deplacement_label IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Déplacement des labels" devrait être vide';
                   WHEN (NEW.fk_reseau != 1 AND NEW.fk_schematique_impression_plan IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Impression plan" devrait être vide';
                   WHEN (NEW.fk_reseau != 1 AND NEW.fk_schematique_validation_plan IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Validation plan" devrait être vide';
                   WHEN (NEW.fk_reseau != 2 AND NEW.fk_detail_chambre IS NOT NULL) THEN
                      RAISE EXCEPTION 'Le champ "Détail de chambre" devrait être vide';
                   WHEN (NEW.fk_reseau = 2 AND NEW.fk_detail_chambre IS NULL) THEN
                      RAISE EXCEPTION 'Le champ "Détail de chambre" devrait être renseigné';
		   ELSE NULL;
		END CASE;
		RETURN NEW;
	END;
$BODY$;

ALTER FUNCTION chantiers.ft_check_attribute_suivi_etape()
    OWNER TO pulfase;
