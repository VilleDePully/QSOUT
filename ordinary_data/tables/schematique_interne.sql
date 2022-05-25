-- Table: chantiers.schematique_interne

-- DROP TABLE chantiers.schematique_interne;

CREATE TABLE chantiers.schematique_interne
(
    id integer NOT NULL DEFAULT nextval('chantiers.schematique_interne_id_seq'::regclass),
    fk_suivi_chantier integer NOT NULL,
    numero_pd integer,
    nom_ss character varying(50) COLLATE pg_catalog."default",
    fid_pd_ss boolean,
    lien_photo text COLLATE pg_catalog."default",
    photo_tb2 boolean,
    liaison_cable_depart boolean,
    date_validation date,
    remarque text COLLATE pg_catalog."default",
    fk_impression integer NOT NULL DEFAULT 1,
    fk_validation integer NOT NULL DEFAULT 1,
    fk_modification integer NOT NULL DEFAULT 1,
    fk_photo_nouvel_etat integer NOT NULL DEFAULT 2,
    CONSTRAINT schematique_interne_pk PRIMARY KEY (id),
    CONSTRAINT schematique_interne_fk_suivi_chantier FOREIGN KEY (fk_suivi_chantier)
        REFERENCES chantiers.suivi_chantier (id) MATCH FULL
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT schematique_interne_validation_check CHECK (fk_impression >= fk_validation)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE chantiers.schematique_interne
    OWNER to pulfase;

GRANT REFERENCES, SELECT, TRIGGER ON TABLE chantiers.schematique_interne TO grp_dtsi_due_r;

GRANT ALL ON TABLE chantiers.schematique_interne TO pulfase;

GRANT DELETE, INSERT, REFERENCES, SELECT, TRIGGER, UPDATE ON TABLE chantiers.schematique_interne TO grp_dtsi_due_w;

COMMENT ON COLUMN chantiers.schematique_interne.photo_tb2
    IS 'lien dans TB2';