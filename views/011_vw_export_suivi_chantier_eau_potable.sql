-- View: chantiers.vw_export_suivi_chantier_eau_potable

-- DROP VIEW chantiers.vw_export_suivi_chantier_eau_potable;

CREATE OR REPLACE VIEW chantiers.vw_export_suivi_chantier_eau_potable
 AS
 SELECT suivi_chantier.id,
    chantiers.nom,
    suivi_chantier.fk_chantier,
    suivi_chantier.fk_reseau,
    suivi_chantier.plan_pose,
        CASE
            WHEN (suivi_chantier.fk_export_sire = ANY (ARRAY[3, 4])) THEN 1
            WHEN (suivi_chantier.fk_export_sire = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS export_sire,
    suivi_chantier.fk_checker_sire,
        CASE
            WHEN (suivi_chantier.fk_checker_sire = ANY (ARRAY[4, 5])) THEN 1
            WHEN (suivi_chantier.fk_checker_sire = ANY (ARRAY[1, 2, 3])) THEN 2
            ELSE 0
        END AS checker_sire,
        CASE
            WHEN (suivi_chantier.fk_envoi_sire = ANY (ARRAY[3, 4])) THEN 1
            WHEN (suivi_chantier.fk_envoi_sire = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS envoi_sire,
    suivi_chantier.date_envoi_sire,
        CASE
            WHEN (suivi_chantier.fk_impression_plan_te = ANY (ARRAY[3, 4])) THEN 1
            WHEN (suivi_chantier.fk_impression_plan_te = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS impression_plan_te,
        CASE
            WHEN (suivi_chantier.fk_envoi_plan_te = ANY (ARRAY[3, 4])) THEN 1
            WHEN (suivi_chantier.fk_envoi_plan_te = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS envoi_plan_te,
    suivi_chantier.date_envoi_plan_te,
    suivi_chantier.remarque
   FROM (chantiers.suivi_chantier
     LEFT JOIN chantiers.chantiers chantiers ON ((suivi_chantier.fk_chantier = chantiers.id)))
  WHERE (suivi_chantier.fk_reseau = 1)
  GROUP BY suivi_chantier.id, chantiers.nom;

ALTER TABLE chantiers.vw_export_suivi_chantier_eau_potable
    OWNER TO pulfase;

