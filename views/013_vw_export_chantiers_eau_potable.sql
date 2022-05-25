-- View: chantiers.vw_export_chantiers_eau_potable

-- DROP VIEW chantiers.vw_export_chantiers_eau_potable;

CREATE OR REPLACE VIEW chantiers.vw_export_chantiers_eau_potable
 AS
 SELECT chantiers.id,
    chantiers.numero,
    chantiers.nom,
    chantiers.localisation,
    chantiers.type_chantier,
    chantiers.date_debut,
    chantiers.date_fin,
    chantiers.commune,
    contact.nom AS nom_contact,
    chantiers.etat_chantier,
    chantiers.plan_projet,
    chantiers.dossier,
    string_agg((reseau.fluide)::text, ' , '::text) AS fluides_concernes,
    chantiers.folios,
    chantiers.remarque,
    ((sum(vw_etape.etat_etape_eau_potable))::real / (count(vw_etape.id))::real) AS etat_eau_potable,
    ((sum(vw_etape.essai_pression))::real / (count(vw_etape.id))::real) AS essai_pression,
    max(vw_etape.etat_impression_plan_te) AS etat_impression_plan_te,
    max(vw_etape.etat_validation_plan_te) AS etat_validation_plan_te,
    max(vw_etape.etat_schematique_impression_plan) AS etat_schematique_impression_plan,
    max(vw_etape.etat_schematique_validation_plan) AS etat_schematique_validation_plan,
        CASE
            WHEN (max(suivi_chantier.checker_sire) = 1) THEN 0
            WHEN (max(suivi_chantier.checker_sire) = 2) THEN 2
            ELSE 1
        END AS etat_checker_sire,
        CASE
            WHEN (max(suivi_chantier.envoi_sire) = 1) THEN 0
            WHEN (max(suivi_chantier.envoi_sire) = 2) THEN 2
            ELSE 1
        END AS etat_envoi_sire,
        CASE
            WHEN (max(suivi_chantier.impression_plan_te) = 1) THEN 0
            WHEN (max(suivi_chantier.impression_plan_te) = 2) THEN 2
            ELSE 1
        END AS etat_impression_plan_te_eca,
        CASE
            WHEN (max(suivi_chantier.envoi_plan_te) = 1) THEN 0
            WHEN (max(suivi_chantier.envoi_plan_te) = 2) THEN 2
            ELSE 1
        END AS etat_envoi_plan_te_eca,
    chantiers.the_geom
   FROM ((((chantiers.chantiers
     LEFT JOIN chantiers.vw_export_etape_eau_potable vw_etape ON ((chantiers.id = vw_etape.fk_chantiers)))
     LEFT JOIN chantiers.vw_export_suivi_chantier_eau_potable suivi_chantier ON ((chantiers.id = suivi_chantier.fk_chantier)))
     LEFT JOIN chantiers.reseau reseau ON ((reseau.id = ANY (chantiers.fk_reseau))))
     LEFT JOIN chantiers.contact contact ON ((contact.id = chantiers.fk_contact)))
  GROUP BY chantiers.id, contact.nom
  ORDER BY chantiers.id;

ALTER TABLE chantiers.vw_export_chantiers_eau_potable
    OWNER TO pulfase;

