-- View: chantiers.vw_export_suivi_chantier_electricite

-- DROP VIEW chantiers.vw_export_suivi_chantier_electricite;

CREATE OR REPLACE VIEW chantiers.vw_export_suivi_chantier_electricite
 AS
 SELECT suivi_chantier.id,
    chantiers.nom,
    suivi_chantier.fk_chantier,
    suivi_chantier.fk_reseau,
        CASE
            WHEN (suivi_chantier.schematique_interne_touchee = true) THEN 1
            WHEN (suivi_chantier.schematique_interne_touchee = false) THEN 2
            ELSE 0
        END AS schematique_interne_touchee,
    suivi_chantier.bouclage_definitif,
        CASE
            WHEN (suivi_chantier.fk_report_bouclage_definitif = ANY (ARRAY[3, 4])) THEN 1
            WHEN (suivi_chantier.fk_report_bouclage_definitif = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS report_bouclage_definitif,
        CASE
            WHEN (suivi_chantier.fk_impression_sch = ANY (ARRAY[3, 4])) THEN 1
            WHEN (suivi_chantier.fk_impression_sch = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS impression_sch,
        CASE
            WHEN (suivi_chantier.fk_validation_sch = ANY (ARRAY[3, 4])) THEN 1
            WHEN (suivi_chantier.fk_validation_sch = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS validation_sch,
    suivi_chantier.date_validation_sch,
    suivi_chantier.remarque
   FROM (chantiers.suivi_chantier
     LEFT JOIN chantiers.chantiers chantiers ON ((suivi_chantier.fk_chantier = chantiers.id)))
  WHERE (suivi_chantier.fk_reseau = 3)
  GROUP BY suivi_chantier.id, chantiers.nom;

ALTER TABLE chantiers.vw_export_suivi_chantier_electricite
    OWNER TO pulfase;

