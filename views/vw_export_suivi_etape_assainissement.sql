-- View: chantiers.vw_export_suivi_etape_assainissement

-- DROP VIEW chantiers.vw_export_suivi_etape_assainissement;

CREATE OR REPLACE VIEW chantiers.vw_export_suivi_etape_assainissement
 AS
 SELECT suivi_etape.id,
    suivi_etape.fk_reseau,
    chantiers.nom AS nom_chantier,
    etape.numero AS numero_etape,
    suivi_etape.fk_etape,
        CASE
            WHEN (suivi_etape.fk_detail_chambre = ANY (ARRAY[4, 5])) THEN 1
            WHEN (suivi_etape.fk_detail_chambre = ANY (ARRAY[1, 2])) THEN 2
            WHEN (suivi_etape.fk_detail_chambre = 3) THEN 3
            ELSE 0
        END AS detail_chambre,
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
        CASE
            WHEN (suivi_etape.fk_releve_complement = ANY (ARRAY[3, 4])) THEN 1
            WHEN (suivi_etape.fk_releve_complement = 1) THEN 2
            WHEN (suivi_etape.fk_releve_complement = 2) THEN 3
            ELSE 0
        END AS releve_complement,
        CASE
            WHEN (suivi_etape.fk_report_complement = ANY (ARRAY[3, 4])) THEN 1
            WHEN (suivi_etape.fk_report_complement = 1) THEN 2
            WHEN (suivi_etape.fk_report_complement = 2) THEN 3
            ELSE 0
        END AS report_complement,
    suivi_etape.croquis_si,
    suivi_etape.report_croquis_si,
    suivi_etape.remarque
   FROM ((chantiers.suivi_etape
     LEFT JOIN chantiers.etape etape ON ((suivi_etape.fk_etape = etape.id)))
     LEFT JOIN chantiers.chantiers chantiers ON ((etape.fk_chantiers = chantiers.id)))
  WHERE (suivi_etape.fk_reseau = 2);

ALTER TABLE chantiers.vw_export_suivi_etape_assainissement
    OWNER TO pulfase;

