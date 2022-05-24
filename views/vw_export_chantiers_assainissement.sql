-- View: chantiers.vw_export_chantiers_assainissement

-- DROP VIEW chantiers.vw_export_chantiers_assainissement;

CREATE OR REPLACE VIEW chantiers.vw_export_chantiers_assainissement
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
    ((sum(vw_etape.etat_etape_assainissement))::real / (count(vw_etape.id))::real) AS etat_assainissement,
    max(vw_etape.etat_impression_plan_te) AS etat_impression_plan_te,
    max(vw_etape.etat_validation_plan_te) AS etat_validation_plan_te,
    max(vw_etape.etat_detail_chambre) AS etat_detail_chambre,
    max(vw_etape.etat_releve_complement) AS etat_releve_complement,
    max(vw_etape.etat_report_complement) AS etat_report_complement,
        CASE
            WHEN (max(suivi_chantier.report_installation_existante) = 1) THEN 0
            WHEN (max(suivi_chantier.report_installation_existante) = 2) THEN 2
            ELSE 1
        END AS etat_report_installation_existante,
        CASE
            WHEN (max(suivi_chantier.envoi_plan_existant) = 1) THEN 0
            WHEN (max(suivi_chantier.envoi_plan_existant) = 2) THEN 2
            ELSE 1
        END AS etat_envoi_plan_existant,
        CASE
            WHEN (max(suivi_chantier.report_plan_architecte) = 1) THEN 0
            WHEN (max(suivi_chantier.report_plan_architecte) = 2) THEN 2
            ELSE 1
        END AS etat_report_plan_architecte,
    chantiers.the_geom
   FROM ((((chantiers.chantiers
     LEFT JOIN chantiers.vw_export_etape_assainissement vw_etape ON ((chantiers.id = vw_etape.fk_chantiers)))
     LEFT JOIN chantiers.vw_export_suivi_chantier_assainissement suivi_chantier ON ((chantiers.id = suivi_chantier.fk_chantier)))
     LEFT JOIN chantiers.reseau reseau ON ((reseau.id = ANY (chantiers.fk_reseau))))
     LEFT JOIN chantiers.contact contact ON ((contact.id = chantiers.fk_contact)))
  GROUP BY chantiers.id, contact.nom
  ORDER BY chantiers.id;

ALTER TABLE chantiers.vw_export_chantiers_assainissement
    OWNER TO pulfase;