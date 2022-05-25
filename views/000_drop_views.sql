
DROP VIEW IF EXISTS chantiers.vw_export_releve;

--DROP VIEWS export CHANTIERS
DROP VIEW IF EXISTS chantiers.vw_export_chantiers_assainissement;
DROP VIEW IF EXISTS chantiers.vw_export_chantiers_eau_potable;
DROP VIEW IF EXISTS chantiers.vw_export_chantiers_electricite;

--DROP VIEWS export suivi
DROP VIEW IF EXISTS chantiers.vw_export_suivi_chantier_assainissement;
DROP VIEW IF EXISTS chantiers.vw_export_suivi_chantier_eau_potable;
DROP VIEW IF EXISTS chantiers.vw_export_suivi_chantier_electricite;
DROP VIEW IF EXISTS chantiers.vw_export_suivi_chantier_tiers;

--DROP VIEWS export etapes
DROP VIEW IF EXISTS chantiers.vw_export_etape_assainissement;
DROP VIEW IF EXISTS chantiers.vw_export_etape_eau_potable;
DROP VIEW IF EXISTS chantiers.vw_export_etape_electricite;
DROP VIEW IF EXISTS chantiers.vw_export_etape_fibre_optique;

DROP VIEW IF EXISTS chantiers.vw_export_suivi_etape_assainissement;
DROP VIEW IF EXISTS chantiers.vw_export_suivi_etape_eau_potable;

DROP VIEW IF EXISTS chantiers.vw_export_secteur_electricite;
DROP VIEW IF EXISTS chantiers.vw_export_croquis_electricite;