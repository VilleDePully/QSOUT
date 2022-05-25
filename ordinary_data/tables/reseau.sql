-- Table: chantiers.reseau

-- DROP TABLE chantiers.reseau;

CREATE TABLE chantiers.reseau
(
    id integer NOT NULL DEFAULT nextval('chantiers.reseau_id_seq'::regclass),
    fluide character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT reseau_pk PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE chantiers.reseau
    OWNER to pulfase;

GRANT REFERENCES, SELECT, TRIGGER ON TABLE chantiers.reseau TO grp_dtsi_due_r;

GRANT DELETE, INSERT, REFERENCES, SELECT, TRIGGER, UPDATE ON TABLE chantiers.reseau TO grp_dtsi_due_w;

GRANT ALL ON TABLE chantiers.reseau TO pulfase;