-- View: chantiers.vw_export_etape_eau_potable

-- DROP VIEW chantiers.vw_export_etape_eau_potable;

CREATE OR REPLACE VIEW chantiers.vw_export_etape_eau_potable
 AS
 SELECT etape.id,
    etape.fk_chantiers,
    etape.numero,
    etape.remarque,
    (((sum(releve.etat_releve_eau_potable))::real / (count(releve.id))::real) * (100)::double precision) AS etat_etape_eau_potable,
    (sum(vw_export_suivi_etape_eau_potable.essai_pression))::integer AS essai_pression,
        CASE
            WHEN ((max(vw_export_suivi_etape_eau_potable.impression_plan_te) = 1) AND (((sum(releve.etat_releve_eau_potable) / count(releve.id)) * 100) = 100)) THEN 0
            WHEN ((max(vw_export_suivi_etape_eau_potable.impression_plan_te) = 2) AND (((sum(releve.etat_releve_eau_potable) / count(releve.id)) * 100) = 100)) THEN 2
            WHEN ((max(vw_export_suivi_etape_eau_potable.impression_plan_te) = 2) AND (((sum(releve.etat_releve_eau_potable) / count(releve.id)) * 100) <> 100)) THEN 1
            ELSE 1
        END AS etat_impression_plan_te,
        CASE
            WHEN ((max(vw_export_suivi_etape_eau_potable.validation_plan_te) = 1) AND (((sum(releve.etat_releve_eau_potable) / count(releve.id)) * 100) = 100)) THEN 0
            WHEN ((max(vw_export_suivi_etape_eau_potable.validation_plan_te) = 2) AND (((sum(releve.etat_releve_eau_potable) / count(releve.id)) * 100) = 100)) THEN 2
            WHEN ((max(vw_export_suivi_etape_eau_potable.validation_plan_te) = 2) AND (((sum(releve.etat_releve_eau_potable) / count(releve.id)) * 100) <> 100)) THEN 1
            ELSE 1
        END AS etat_validation_plan_te,
        CASE
            WHEN ((max(vw_export_suivi_etape_eau_potable.schematique_impression_plan) = 1) AND (((sum(releve.etat_releve_eau_potable) / count(releve.id)) * 100) = 100)) THEN 0
            WHEN ((max(vw_export_suivi_etape_eau_potable.schematique_impression_plan) = 2) AND (((sum(releve.etat_releve_eau_potable) / count(releve.id)) * 100) = 100)) THEN 2
            WHEN ((max(vw_export_suivi_etape_eau_potable.schematique_impression_plan) = 2) AND (((sum(releve.etat_releve_eau_potable) / count(releve.id)) * 100) <> 100)) THEN 1
            ELSE 1
        END AS etat_schematique_impression_plan,
        CASE
            WHEN ((max(vw_export_suivi_etape_eau_potable.schematique_validation_plan) = 1) AND (((sum(releve.etat_releve_eau_potable) / count(releve.id)) * 100) = 100)) THEN 0
            WHEN ((max(vw_export_suivi_etape_eau_potable.schematique_validation_plan) = 2) AND (((sum(releve.etat_releve_eau_potable) / count(releve.id)) * 100) = 100)) THEN 2
            WHEN ((max(vw_export_suivi_etape_eau_potable.schematique_validation_plan) = 2) AND (((sum(releve.etat_releve_eau_potable) / count(releve.id)) * 100) <> 100)) THEN 1
            ELSE 1
        END AS etat_schematique_validation_plan
   FROM ((chantiers.etape
     JOIN chantiers.releve ON ((releve.fk_etape = etape.id)))
     JOIN chantiers.vw_export_suivi_etape_eau_potable ON ((vw_export_suivi_etape_eau_potable.fk_etape = etape.id)))
  GROUP BY etape.id, vw_export_suivi_etape_eau_potable.id;

ALTER TABLE chantiers.vw_export_etape_eau_potable
    OWNER TO pulfase;

