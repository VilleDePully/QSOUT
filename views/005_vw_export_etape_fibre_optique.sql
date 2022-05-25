-- View: chantiers.vw_export_etape_fibre_optique

-- DROP VIEW chantiers.vw_export_etape_fibre_optique;

CREATE OR REPLACE VIEW chantiers.vw_export_etape_fibre_optique
 AS
 SELECT etape.id,
    etape.fk_chantiers,
    etape.numero,
    etape.remarque,
    (((sum(releve.etat_releve_fibre_optique))::real / (count(releve.id))::real) * (100)::double precision) AS etat_etape_fibre_optique
   FROM (chantiers.etape
     JOIN chantiers.releve ON ((releve.fk_etape = etape.id)))
  GROUP BY etape.id;

ALTER TABLE chantiers.vw_export_etape_fibre_optique
    OWNER TO pulfase;

