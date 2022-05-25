-- Table: chantiers.croquis

-- DROP TABLE chantiers.croquis;

CREATE TABLE chantiers.croquis
(
    id integer NOT NULL DEFAULT nextval('chantiers.croquis_id_seq'::regclass),
    fk_secteur integer NOT NULL,
    lien text COLLATE pg_catalog."default" NOT NULL,
    remarque text COLLATE pg_catalog."default",
    fk_report integer NOT NULL DEFAULT 1,
    fk_mise_hs_reseau integer NOT NULL DEFAULT 2,
    CONSTRAINT croquis_pk PRIMARY KEY (id),
    CONSTRAINT croquis_fk_secteur FOREIGN KEY (fk_secteur)
        REFERENCES chantiers.secteur (id) MATCH FULL
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE chantiers.croquis
    OWNER to pulfase;

GRANT REFERENCES, SELECT, TRIGGER ON TABLE chantiers.croquis TO grp_dtsi_due_r;

GRANT ALL ON TABLE chantiers.croquis TO grp_dtsi_due_w;

GRANT ALL ON TABLE chantiers.croquis TO pulfase;