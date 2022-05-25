-- View: chantiers.vw_export_suivi_chantier_assainissement

-- DROP VIEW chantiers.vw_export_suivi_chantier_assainissement;

CREATE OR REPLACE VIEW chantiers.vw_export_suivi_chantier_assainissement
 AS
 SELECT suivi_chantier.id,
    chantiers.nom,
    suivi_chantier.fk_chantier,
    suivi_chantier.fk_reseau,
    suivi_chantier.installation_existante,
        CASE
            WHEN (suivi_chantier.fk_report_installation_existante = ANY (ARRAY[3, 4])) THEN 1
            WHEN (suivi_chantier.fk_report_installation_existante = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS report_installation_existante,
        CASE
            WHEN (suivi_chantier.fk_envoi_plan_existant = ANY (ARRAY[4, 5])) THEN 1
            WHEN (suivi_chantier.fk_envoi_plan_existant = ANY (ARRAY[1, 2, 3])) THEN 2
            ELSE 0
        END AS envoi_plan_existant,
        CASE
            WHEN (suivi_chantier.fk_report_plan_architecte = ANY (ARRAY[3, 4])) THEN 1
            WHEN (suivi_chantier.fk_report_plan_architecte = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS report_plan_architecte,
    suivi_chantier.changement_bassin_versant,
    suivi_chantier.remarque
   FROM (chantiers.suivi_chantier
     LEFT JOIN chantiers.chantiers chantiers ON ((suivi_chantier.fk_chantier = chantiers.id)))
  WHERE (suivi_chantier.fk_reseau = 1)
  GROUP BY suivi_chantier.id, chantiers.nom;

ALTER TABLE chantiers.vw_export_suivi_chantier_assainissement
    OWNER TO pulfase;

