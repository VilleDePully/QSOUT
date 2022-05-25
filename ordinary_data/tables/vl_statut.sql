-- Table: chantiers.vl_statut

-- DROP TABLE chantiers.vl_statut;

CREATE TABLE chantiers.vl_statut
(
    id integer NOT NULL DEFAULT nextval('chantiers.vl_statut_id_seq'::regclass),
    value character varying(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT vl_statut_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE chantiers.vl_statut
    OWNER to pulfase;

GRANT REFERENCES, SELECT, TRIGGER ON TABLE chantiers.vl_statut TO grp_dtsi_due_r;

GRANT ALL ON TABLE chantiers.vl_statut TO grp_dtsi_due_w;

GRANT ALL ON TABLE chantiers.vl_statut TO pulfase;