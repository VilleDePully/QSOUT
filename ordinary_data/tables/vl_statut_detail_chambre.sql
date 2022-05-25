-- Table: chantiers.vl_statut_detail_chambre

-- DROP TABLE chantiers.vl_statut_detail_chambre;

CREATE TABLE chantiers.vl_statut_detail_chambre
(
    id integer NOT NULL DEFAULT nextval('chantiers.vl_statut_detail_chambre_id_seq'::regclass),
    value character varying(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT vl_statut_detail_chambre_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE chantiers.vl_statut_detail_chambre
    OWNER to pulfase;

GRANT REFERENCES, SELECT, TRIGGER ON TABLE chantiers.vl_statut_detail_chambre TO grp_dtsi_due_r;

GRANT ALL ON TABLE chantiers.vl_statut_detail_chambre TO grp_dtsi_due_w;

GRANT ALL ON TABLE chantiers.vl_statut_detail_chambre TO pulfase;