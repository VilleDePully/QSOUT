-- View: chantiers.vw_export_suivi_etape_eau_potable

-- DROP VIEW chantiers.vw_export_suivi_etape_eau_potable;

CREATE OR REPLACE VIEW chantiers.vw_export_suivi_etape_eau_potable
 AS
 SELECT suivi_etape.id,
    suivi_etape.fk_reseau,
    chantiers.nom AS nom_chantier,
    etape.numero AS numero_etape,
    suivi_etape.fk_etape,
    suivi_etape.provisoire,
        CASE
            WHEN (suivi_etape.essai_pression IS NOT NULL) THEN 1
            ELSE 0
        END AS essai_pression,
    suivi_etape.fk_numero_vanne,
    suivi_etape.fk_numero_bh,
        CASE
            WHEN (suivi_etape.fk_impression_plan_te = ANY (ARRAY[3, 4])) THEN 1
            WHEN (suivi_etape.fk_impression_plan_te = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS impression_plan_te,
        CASE
            WHEN (suivi_etape.fk_validation_plan_te = ANY (ARRAY[3, 4])) THEN 1
            WHEN (suivi_etape.fk_validation_plan_te = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS validation_plan_te,
    suivi_etape.date_validation_plan_te,
    suivi_etape.fk_releve_complement,
    suivi_etape.fk_report_complement,
    suivi_etape.croquis_si,
    suivi_etape.report_croquis_si,
    suivi_etape.fk_schematique_nouveau,
    suivi_etape.fk_schematique_ancien,
    suivi_etape.fk_schematique_deplacement_vanne,
    suivi_etape.fk_schematique_deplacement_borne_hydrante,
    suivi_etape.fk_schematique_deplacement_label,
        CASE
            WHEN (suivi_etape.fk_schematique_impression_plan = ANY (ARRAY[3, 4])) THEN 1
            WHEN (suivi_etape.fk_schematique_impression_plan = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS schematique_impression_plan,
        CASE
            WHEN (suivi_etape.fk_schematique_validation_plan = ANY (ARRAY[3, 4])) THEN 1
            WHEN (suivi_etape.fk_schematique_validation_plan = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS schematique_validation_plan,
    suivi_etape.schematique_date_validation_plan,
    suivi_etape.remarque
   FROM ((chantiers.suivi_etape
     LEFT JOIN chantiers.etape etape ON ((suivi_etape.fk_etape = etape.id)))
     LEFT JOIN chantiers.chantiers chantiers ON ((etape.fk_chantiers = chantiers.id)))
  WHERE (suivi_etape.fk_reseau = 1);

ALTER TABLE chantiers.vw_export_suivi_etape_eau_potable
    OWNER TO pulfase;

