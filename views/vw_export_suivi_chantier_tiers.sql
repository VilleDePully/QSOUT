-- View: chantiers.vw_export_suivi_chantier_tiers

-- DROP VIEW chantiers.vw_export_suivi_chantier_tiers;

CREATE OR REPLACE VIEW chantiers.vw_export_suivi_chantier_tiers
 AS
 SELECT suivi_chantier.id,
    chantiers.nom,
    suivi_chantier.fk_chantier,
    suivi_chantier.fk_reseau,
    suivi_chantier.fk_envoi_donnees_externe,
    suivi_chantier.remarque
   FROM (chantiers.suivi_chantier
     LEFT JOIN chantiers.chantiers chantiers ON ((suivi_chantier.fk_chantier = chantiers.id)))
  WHERE (suivi_chantier.fk_reseau = ANY (ARRAY[4, 5]))
  GROUP BY suivi_chantier.id, chantiers.nom;

ALTER TABLE chantiers.vw_export_suivi_chantier_tiers
    OWNER TO pulfase;

