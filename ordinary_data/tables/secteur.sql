-- Table: chantiers.secteur

-- DROP TABLE chantiers.secteur;

CREATE TABLE chantiers.secteur
(
    id integer NOT NULL DEFAULT nextval('chantiers.secteur_id_seq'::regclass),
    numero integer,
    date_validation_plan_te date,
    schematique_date_validation_plan date,
    remarque text COLLATE pg_catalog."default",
    fk_chantiers integer,
    fk_fid_candelabre integer NOT NULL DEFAULT 1,
    fk_impression_plan_te integer NOT NULL DEFAULT 1,
    fk_validation_plan_te integer NOT NULL DEFAULT 1,
    fk_releve_complement integer NOT NULL DEFAULT 2,
    fk_report_complement integer NOT NULL DEFAULT 2,
    fk_schematique_impression_plan integer NOT NULL DEFAULT 1,
    fk_schematique_validation_plan integer NOT NULL DEFAULT 1,
    croquis_livre boolean,
    CONSTRAINT secteur_pk PRIMARY KEY (id),
    CONSTRAINT secteur_fk_chantier FOREIGN KEY (fk_chantiers)
        REFERENCES chantiers.chantiers (id) MATCH FULL
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT secteur_validation_schematique_check CHECK (fk_schematique_impression_plan >= fk_schematique_validation_plan),
    CONSTRAINT secteur_validation_plan_check CHECK (fk_impression_plan_te >= fk_validation_plan_te),
    CONSTRAINT secteur_report_complement_check CHECK (fk_releve_complement >= fk_report_complement)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE chantiers.secteur
    OWNER to pulfase;

GRANT REFERENCES, SELECT, TRIGGER ON TABLE chantiers.secteur TO grp_dtsi_due_r;

GRANT ALL ON TABLE chantiers.secteur TO pulfase;

GRANT DELETE, INSERT, REFERENCES, SELECT, TRIGGER, UPDATE ON TABLE chantiers.secteur TO grp_dtsi_due_w;