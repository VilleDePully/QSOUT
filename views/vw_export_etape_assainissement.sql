-- View: chantiers.vw_export_etape_assainissement

-- DROP VIEW chantiers.vw_export_etape_assainissement;

CREATE OR REPLACE VIEW chantiers.vw_export_etape_assainissement
 AS
 SELECT etape.id,
    etape.fk_chantiers,
    etape.numero,
    etape.remarque,
    max(vw_export_suivi_etape_assainissement.detail_chambre) AS etat_detail_chambre,
    (((sum(releve.etat_releve_assainissement))::real / (count(releve.id))::real) * (100)::double precision) AS etat_etape_assainissement,
        CASE
            WHEN ((max(vw_export_suivi_etape_assainissement.impression_plan_te) = 1) AND (((sum(releve.etat_releve_assainissement) / count(releve.id)) * 100) = 100)) THEN 0
            WHEN ((max(vw_export_suivi_etape_assainissement.impression_plan_te) = 2) AND (((sum(releve.etat_releve_assainissement) / count(releve.id)) * 100) = 100)) THEN 2
            WHEN ((max(vw_export_suivi_etape_assainissement.impression_plan_te) = 2) AND (((sum(releve.etat_releve_assainissement) / count(releve.id)) * 100) <> 100)) THEN 1
            ELSE 1
        END AS etat_impression_plan_te,
        CASE
            WHEN ((max(vw_export_suivi_etape_assainissement.validation_plan_te) = 1) AND (((sum(releve.etat_releve_assainissement) / count(releve.id)) * 100) = 100)) THEN 0
            WHEN ((max(vw_export_suivi_etape_assainissement.validation_plan_te) = 2) AND (((sum(releve.etat_releve_assainissement) / count(releve.id)) * 100) = 100)) THEN 2
            WHEN ((max(vw_export_suivi_etape_assainissement.validation_plan_te) = 2) AND (((sum(releve.etat_releve_assainissement) / count(releve.id)) * 100) <> 100)) THEN 1
            ELSE 1
        END AS etat_validation_plan_te,
    (max(vw_export_suivi_etape_assainissement.releve_complement) / (count(etape.id))::integer) AS etat_releve_complement,
    (max(vw_export_suivi_etape_assainissement.report_complement) / (count(etape.id))::integer) AS etat_report_complement
   FROM ((chantiers.etape
     JOIN chantiers.releve ON ((releve.fk_etape = etape.id)))
     JOIN chantiers.vw_export_suivi_etape_assainissement ON ((vw_export_suivi_etape_assainissement.fk_etape = etape.id)))
  GROUP BY etape.id, vw_export_suivi_etape_assainissement.id;

ALTER TABLE chantiers.vw_export_etape_assainissement
    OWNER TO pulfase;

