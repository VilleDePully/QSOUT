-- Table: chantiers.suivi_etape

-- DROP TABLE chantiers.suivi_etape;

CREATE TABLE chantiers.suivi_etape
(
    id integer NOT NULL DEFAULT nextval('chantiers.suivi_etape_id_seq'::regclass),
    fk_reseau integer,
    fk_etape integer,
    provisoire character varying(50) COLLATE pg_catalog."default",
    essai_pression character varying(50) COLLATE pg_catalog."default",
    date_validation_plan_te date,
    croquis_si character varying(50) COLLATE pg_catalog."default",
    report_croquis_si boolean,
    detail_chambre character varying(50) COLLATE pg_catalog."default",
    schematique_date_validation_plan date,
    remarque text COLLATE pg_catalog."default",
    fk_numero_vanne integer,
    fk_numero_bh integer,
    fk_impression_plan_te integer,
    fk_validation_plan_te integer,
    fk_releve_complement integer,
    fk_report_complement integer,
    fk_schematique_nouveau integer,
    fk_schematique_ancien integer,
    fk_schematique_deplacement_vanne integer,
    fk_schematique_deplacement_borne_hydrante integer,
    fk_schematique_deplacement_label integer,
    fk_schematique_impression_plan integer,
    fk_schematique_validation_plan integer,
    fk_detail_chambre integer,
    CONSTRAINT suivi_etape_pk PRIMARY KEY (id),
    CONSTRAINT suivi_etape_fk_etape FOREIGN KEY (fk_etape)
        REFERENCES chantiers.etape (id) MATCH FULL
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT suivi_etape_fk_reseau FOREIGN KEY (fk_reseau)
        REFERENCES chantiers.reseau (id) MATCH FULL
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT suivi_etape_fk_validation_plan_te_check CHECK (fk_impression_plan_te >= fk_validation_plan_te),
    CONSTRAINT suivi_etape_fk_schematique_validation_check CHECK (fk_schematique_impression_plan >= fk_schematique_validation_plan),
    CONSTRAINT suivi_etape_fk_report_complement_check CHECK (fk_releve_complement >= fk_report_complement)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE chantiers.suivi_etape
    OWNER to pulfase;

GRANT REFERENCES, SELECT, TRIGGER ON TABLE chantiers.suivi_etape TO grp_dtsi_due_r;

GRANT ALL ON TABLE chantiers.suivi_etape TO pulfase;

GRANT DELETE, INSERT, REFERENCES, SELECT, TRIGGER, UPDATE ON TABLE chantiers.suivi_etape TO grp_dtsi_due_w;

-- Trigger: tr_suivi_etape_check

-- DROP TRIGGER tr_suivi_etape_check ON chantiers.suivi_etape;

CREATE TRIGGER tr_suivi_etape_check
    BEFORE INSERT OR UPDATE 
    ON chantiers.suivi_etape
    FOR EACH ROW
    EXECUTE PROCEDURE chantiers.ft_check_attribute_suivi_etape();

COMMENT ON TRIGGER tr_suivi_etape_check ON chantiers.suivi_etape
    IS 'Trigger: check field according to the fluid of the suivi_etape after insert.';