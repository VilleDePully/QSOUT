-- Table: chantiers.contact

-- DROP TABLE chantiers.contact;

CREATE TABLE chantiers.contact
(
    id integer NOT NULL DEFAULT nextval('chantiers.contact_id_seq'::regclass),
    nom character varying(50) COLLATE pg_catalog."default" NOT NULL,
    prenom character varying(50) COLLATE pg_catalog."default" NOT NULL,
    abreviation character varying(5) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT contact_pk PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE chantiers.contact
    OWNER to pulfase;

GRANT REFERENCES, SELECT, TRIGGER ON TABLE chantiers.contact TO grp_dtsi_due_r;

GRANT ALL ON TABLE chantiers.contact TO grp_dtsi_due_w;

GRANT ALL ON TABLE chantiers.contact TO pulfase;