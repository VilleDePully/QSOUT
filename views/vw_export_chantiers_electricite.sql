-- View: chantiers.vw_export_chantiers_electricite

-- DROP VIEW chantiers.vw_export_chantiers_electricite;

CREATE OR REPLACE VIEW chantiers.vw_export_chantiers_electricite
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
    ((sum(vw_etape.etat_etape_electricite))::real / (count(vw_etape.id))::real) AS etat_electricite,
        CASE
            WHEN (max(vw_secteur.fid_candelabre) = 1) THEN 0
            WHEN (max(vw_secteur.fid_candelabre) = 2) THEN 2
            ELSE 1
        END AS etat_fid_candelabre,
        CASE
            WHEN (max(vw_secteur.impression_plan_te) = 1) THEN 0
            WHEN (max(vw_secteur.impression_plan_te) = 2) THEN 2
            ELSE 1
        END AS etat_impression_plan_te,
        CASE
            WHEN (max(vw_secteur.validation_plan_te) = 1) THEN 0
            WHEN (max(vw_secteur.validation_plan_te) = 2) THEN 2
            ELSE 1
        END AS etat_validation_plan_te,
        CASE
            WHEN (max(vw_secteur.releve_complement) = 1) THEN 0
            WHEN (max(vw_secteur.releve_complement) = 2) THEN 2
            ELSE 1
        END AS etat_releve_complement,
        CASE
            WHEN (max(vw_secteur.report_complement) = 1) THEN 0
            WHEN (max(vw_secteur.report_complement) = 2) THEN 2
            ELSE 1
        END AS etat_report_complement,
        CASE
            WHEN (max(vw_secteur.schematique_impression_plan) = 1) THEN 0
            WHEN (max(vw_secteur.schematique_impression_plan) = 2) THEN 2
            ELSE 1
        END AS etat_schematique_impression_plan,
        CASE
            WHEN (max(vw_secteur.schematique_validation_plan) = 1) THEN 0
            WHEN (max(vw_secteur.schematique_validation_plan) = 2) THEN 2
            ELSE 1
        END AS etat_schematique_validation_plan,
        CASE
            WHEN (max(vw_secteur.croquis_livre) = 1) THEN 0
            WHEN (max(vw_secteur.croquis_livre) = 2) THEN 2
            ELSE 1
        END AS etat_croquis_livre,
        CASE
            WHEN (max(vw_suivi_chantier.schematique_interne_touchee) = 1) THEN 0
            WHEN (max(vw_suivi_chantier.schematique_interne_touchee) = 2) THEN 2
            ELSE 1
        END AS etat_schematique_interne_touchee,
        CASE
            WHEN (max(vw_suivi_chantier.report_bouclage_definitif) = 1) THEN 0
            WHEN (max(vw_suivi_chantier.report_bouclage_definitif) = 2) THEN 2
            ELSE 1
        END AS etat_report_bouclage_definitif,
        CASE
            WHEN (max(vw_suivi_chantier.impression_sch) = 1) THEN 0
            WHEN (max(vw_suivi_chantier.impression_sch) = 2) THEN 2
            ELSE 1
        END AS etat_impression_sch,
        CASE
            WHEN (max(vw_suivi_chantier.validation_sch) = 1) THEN 0
            WHEN (max(vw_suivi_chantier.validation_sch) = 2) THEN 2
            ELSE 1
        END AS etat_validation_sch,
    chantiers.the_geom
   FROM (((((chantiers.chantiers
     LEFT JOIN chantiers.vw_export_suivi_chantier_electricite vw_suivi_chantier ON ((chantiers.id = vw_suivi_chantier.fk_chantier)))
     LEFT JOIN chantiers.vw_export_etape_electricite vw_etape ON ((chantiers.id = vw_etape.fk_chantiers)))
     LEFT JOIN chantiers.vw_export_secteur_electricite vw_secteur ON ((chantiers.id = vw_secteur.fk_chantiers)))
     LEFT JOIN chantiers.reseau reseau ON ((reseau.id = ANY (chantiers.fk_reseau))))
     LEFT JOIN chantiers.contact contact ON ((contact.id = chantiers.fk_contact)))
  GROUP BY chantiers.id, contact.nom
  ORDER BY chantiers.id;

ALTER TABLE chantiers.vw_export_chantiers_electricite
    OWNER TO pulfase;

