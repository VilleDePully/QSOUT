-- View: chantiers.vw_export_etape_electricite

-- DROP VIEW chantiers.vw_export_etape_electricite;

CREATE OR REPLACE VIEW chantiers.vw_export_etape_electricite
 AS
 SELECT etape.id,
    etape.fk_chantiers,
    etape.numero,
    etape.remarque,
    (((sum(releve.etat_releve_electricite))::real / (count(releve.id))::real) * (100)::double precision) AS etat_etape_electricite
   FROM (chantiers.etape
     JOIN chantiers.releve ON ((releve.fk_etape = etape.id)))
  GROUP BY etape.id;

ALTER TABLE chantiers.vw_export_etape_electricite
    OWNER TO pulfase;

