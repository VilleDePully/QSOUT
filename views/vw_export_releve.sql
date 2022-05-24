-- View: chantiers.vw_export_releve

-- DROP VIEW chantiers.vw_export_releve;

CREATE OR REPLACE VIEW chantiers.vw_export_releve
 AS
 SELECT releve.id,
    chantiers.nom,
    etape.numero AS numero_etape,
    releve.date_releve,
    releve.eau_potable,
    releve.eau_potable_import,
    releve.eau_potable_report,
    releve.assainissement,
    releve.assainissement_import,
    releve.assainissement_report,
    releve.electricite,
    releve.electricite_import,
    releve.electricite_report,
    releve.gaz,
    releve.gaz_import,
    releve.gaz_report,
    releve.moyenne_tension,
    releve.moyenne_tension_import,
    releve.moyenne_tension_report,
    releve.swisscom,
    releve.swisscom_import,
    releve.swisscom_report,
    releve.cablecom,
    releve.cablecom_import,
    releve.cablecom_report,
    releve.divers_tiers,
    releve.divers_tiers_import,
    releve.divers_tiers_report,
    releve.etat_releve_eau_potable,
    releve.etat_releve_assainissement,
    releve.etat_releve_electricite,
    releve.etat_releve_gaz,
    releve.etat_releve_moyenne_tension,
    releve.etat_releve_swisscom,
    releve.etat_releve_cablecom,
    releve.etat_releve_divers_tiers,
    releve.remarque,
    releve.fibre_optique,
    releve.fibre_optique_import,
    releve.fibre_optique_report,
    releve.etat_releve_fibre_optique
   FROM ((chantiers.releve
     LEFT JOIN chantiers.etape etape ON ((releve.fk_etape = etape.id)))
     LEFT JOIN chantiers.chantiers chantiers ON ((etape.fk_chantiers = chantiers.id)));

ALTER TABLE chantiers.vw_export_releve
    OWNER TO pulfase;

