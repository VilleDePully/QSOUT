-- View: chantiers.vw_export_secteur_electricite

-- DROP VIEW chantiers.vw_export_secteur_electricite;

CREATE OR REPLACE VIEW chantiers.vw_export_secteur_electricite
 AS
 SELECT secteur.id,
    secteur.numero,
    secteur.date_validation_plan_te,
    secteur.schematique_date_validation_plan,
    secteur.remarque,
    secteur.fk_chantiers,
        CASE
            WHEN (secteur.fk_fid_candelabre = ANY (ARRAY[3, 4])) THEN 1
            WHEN (secteur.fk_fid_candelabre = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS fid_candelabre,
        CASE
            WHEN (secteur.fk_impression_plan_te = ANY (ARRAY[3, 4])) THEN 1
            WHEN (secteur.fk_impression_plan_te = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS impression_plan_te,
        CASE
            WHEN (secteur.fk_validation_plan_te = ANY (ARRAY[3, 4])) THEN 1
            WHEN (secteur.fk_validation_plan_te = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS validation_plan_te,
        CASE
            WHEN (secteur.fk_releve_complement = ANY (ARRAY[3, 4])) THEN 1
            WHEN (secteur.fk_releve_complement = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS releve_complement,
        CASE
            WHEN (secteur.fk_report_complement = ANY (ARRAY[3, 4])) THEN 1
            WHEN (secteur.fk_report_complement = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS report_complement,
        CASE
            WHEN (secteur.fk_schematique_impression_plan = ANY (ARRAY[3, 4])) THEN 1
            WHEN (secteur.fk_schematique_impression_plan = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS schematique_impression_plan,
        CASE
            WHEN (secteur.fk_schematique_validation_plan = ANY (ARRAY[3, 4])) THEN 1
            WHEN (secteur.fk_schematique_validation_plan = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS schematique_validation_plan,
        CASE
            WHEN (secteur.croquis_livre = true) THEN 1
            WHEN (secteur.croquis_livre = false) THEN 2
            ELSE 0
        END AS croquis_livre,
    (((sum(croquis.etat_croquis))::real / (count(croquis.id))::real) * (100)::double precision) AS etat_secteur
   FROM (chantiers.secteur
     JOIN chantiers.vw_export_croquis_electricite croquis ON ((croquis.fk_secteur = croquis.id)))
  GROUP BY secteur.id;

ALTER TABLE chantiers.vw_export_secteur_electricite
    OWNER TO pulfase;

