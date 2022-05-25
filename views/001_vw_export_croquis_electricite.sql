-- View: chantiers.vw_export_croquis_electricite

-- DROP VIEW chantiers.vw_export_croquis_electricite;

CREATE OR REPLACE VIEW chantiers.vw_export_croquis_electricite
 AS
 SELECT croquis.id,
    croquis.fk_secteur,
    croquis.lien,
    croquis.remarque,
        CASE
            WHEN (croquis.fk_report = ANY (ARRAY[3, 4])) THEN 1
            WHEN (croquis.fk_report = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS fk_report,
        CASE
            WHEN (croquis.fk_mise_hs_reseau = ANY (ARRAY[3, 4])) THEN 1
            WHEN (croquis.fk_mise_hs_reseau = ANY (ARRAY[1, 2])) THEN 2
            ELSE 0
        END AS fk_mise_hs_reseau,
        CASE
            WHEN ((croquis.fk_report = ANY (ARRAY[3, 4])) AND (croquis.fk_mise_hs_reseau = ANY (ARRAY[3, 4]))) THEN 1
            ELSE 0
        END AS etat_croquis
   FROM (chantiers.croquis
     LEFT JOIN chantiers.secteur secteur ON ((croquis.fk_secteur = secteur.id)))
  ORDER BY croquis.id;

ALTER TABLE chantiers.vw_export_croquis_electricite
    OWNER TO pulfase;

