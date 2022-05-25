-- Table: chantiers.suivi_chantier

-- DROP TABLE chantiers.suivi_chantier;

CREATE TABLE chantiers.suivi_chantier
(
    id integer NOT NULL DEFAULT nextval('chantiers.suivi_chantier_id_seq'::regclass),
    fk_chantier integer NOT NULL,
    fk_reseau integer NOT NULL,
    plan_pose text COLLATE pg_catalog."default",
    date_envoi_plan_te date,
    date_envoi_sire date,
    date_validation_sch date,
    installation_existante text COLLATE pg_catalog."default",
    changement_bassin_versant boolean,
    bouclage_definitif character varying COLLATE pg_catalog."default",
    remarque text COLLATE pg_catalog."default",
    fk_export_sire integer,
    fk_checker_sire integer,
    fk_impression_plan_te integer,
    fk_envoi_plan_te integer,
    fk_envoi_sire integer,
    fk_impression_sch integer,
    fk_validation_sch integer,
    fk_report_installation_existante integer,
    fk_envoi_plan_existant integer,
    fk_report_plan_architecte integer,
    fk_report_bouclage_definitif integer,
    fk_envoi_donnees_externe integer,
    schematique_interne_touchee boolean,
    CONSTRAINT suivi_chantier_pk PRIMARY KEY (id),
    CONSTRAINT suivi_chantier_fk_chantier FOREIGN KEY (fk_chantier)
        REFERENCES chantiers.chantiers (id) MATCH FULL
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT suivi_chantier_fk_reseau FOREIGN KEY (fk_reseau)
        REFERENCES chantiers.reseau (id) MATCH FULL
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT suivi_chantier_validation_sch_check CHECK (fk_impression_sch >= fk_validation_sch),
    CONSTRAINT suivi_chantier_envoi_sire_check CHECK (fk_checker_sire >= fk_envoi_sire)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE chantiers.suivi_chantier
    OWNER to pulfase;

GRANT REFERENCES, SELECT, TRIGGER ON TABLE chantiers.suivi_chantier TO grp_dtsi_due_r;

GRANT ALL ON TABLE chantiers.suivi_chantier TO pulfase;

GRANT DELETE, INSERT, REFERENCES, SELECT, TRIGGER, UPDATE ON TABLE chantiers.suivi_chantier TO grp_dtsi_due_w;

-- Trigger: tr_suivi_chantier_check

-- DROP TRIGGER tr_suivi_chantier_check ON chantiers.suivi_chantier;

CREATE TRIGGER tr_suivi_chantier_check
    BEFORE INSERT OR UPDATE 
    ON chantiers.suivi_chantier
    FOR EACH ROW
    EXECUTE PROCEDURE chantiers.ft_check_attribute_suivi_chantier();

COMMENT ON TRIGGER tr_suivi_chantier_check ON chantiers.suivi_chantier
    IS 'Trigger: check field according to the fluid of the suivi_chantier after insert.';