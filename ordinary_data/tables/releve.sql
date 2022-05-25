-- Table: chantiers.releve

-- DROP TABLE chantiers.releve;

CREATE TABLE chantiers.releve
(
    id integer NOT NULL DEFAULT nextval('chantiers.releve_id_seq'::regclass),
    fk_etape integer NOT NULL,
    date_releve date NOT NULL,
    eau_potable boolean,
    eau_potable_import boolean,
    eau_potable_report boolean,
    assainissement boolean,
    assainissement_import boolean,
    assainissement_report boolean,
    electricite boolean,
    electricite_import boolean,
    electricite_report boolean,
    gaz boolean,
    gaz_import boolean,
    gaz_report boolean,
    moyenne_tension boolean,
    moyenne_tension_import boolean,
    moyenne_tension_report boolean,
    swisscom boolean,
    swisscom_import boolean,
    swisscom_report boolean,
    cablecom boolean,
    cablecom_import boolean,
    cablecom_report boolean,
    divers_tiers boolean,
    divers_tiers_import boolean,
    divers_tiers_report boolean,
    remarque text COLLATE pg_catalog."default",
    etat_releve_eau_potable integer,
    etat_releve_assainissement integer,
    etat_releve_electricite integer,
    etat_releve_gaz integer,
    etat_releve_moyenne_tension integer,
    etat_releve_swisscom integer,
    etat_releve_cablecom integer,
    etat_releve_divers_tiers integer,
    fibre_optique boolean,
    fibre_optique_import boolean,
    fibre_optique_report boolean,
    etat_releve_fibre_optique integer,
    CONSTRAINT releve_pk PRIMARY KEY (id),
    CONSTRAINT releve_fk_etape FOREIGN KEY (fk_etape)
        REFERENCES chantiers.etape (id) MATCH FULL
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT releve_date_releve_check CHECK (date_releve < now())
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE chantiers.releve
    OWNER to pulfase;

GRANT REFERENCES, SELECT, TRIGGER ON TABLE chantiers.releve TO grp_dtsi_due_r;

GRANT ALL ON TABLE chantiers.releve TO pulfase;

GRANT DELETE, INSERT, REFERENCES, SELECT, TRIGGER, UPDATE ON TABLE chantiers.releve TO grp_dtsi_due_w;

COMMENT ON COLUMN chantiers.releve.fk_etape
    IS '
';

-- Trigger: tr_update_etat_releve_assainissement

-- DROP TRIGGER tr_update_etat_releve_assainissement ON chantiers.releve;

CREATE TRIGGER tr_update_etat_releve_assainissement
    BEFORE INSERT OR UPDATE 
    ON chantiers.releve
    FOR EACH ROW
    EXECUTE PROCEDURE chantiers.ft_update_etat_releve_assainissement();

COMMENT ON TRIGGER tr_update_etat_releve_assainissement ON chantiers.releve
    IS 'Trigger: updates auto field of the releve after insert.';

-- Trigger: tr_update_etat_releve_cablecom

-- DROP TRIGGER tr_update_etat_releve_cablecom ON chantiers.releve;

CREATE TRIGGER tr_update_etat_releve_cablecom
    BEFORE INSERT OR UPDATE 
    ON chantiers.releve
    FOR EACH ROW
    EXECUTE PROCEDURE chantiers.ft_update_etat_releve_cablecom();

COMMENT ON TRIGGER tr_update_etat_releve_cablecom ON chantiers.releve
    IS 'Trigger: updates auto field of the releve after insert.';

-- Trigger: tr_update_etat_releve_divers_tiers

-- DROP TRIGGER tr_update_etat_releve_divers_tiers ON chantiers.releve;

CREATE TRIGGER tr_update_etat_releve_divers_tiers
    BEFORE INSERT OR UPDATE 
    ON chantiers.releve
    FOR EACH ROW
    EXECUTE PROCEDURE chantiers.ft_update_etat_releve_divers_tiers();

COMMENT ON TRIGGER tr_update_etat_releve_divers_tiers ON chantiers.releve
    IS 'Trigger: updates auto field of the releve after insert.';

-- Trigger: tr_update_etat_releve_eau_potable

-- DROP TRIGGER tr_update_etat_releve_eau_potable ON chantiers.releve;

CREATE TRIGGER tr_update_etat_releve_eau_potable
    BEFORE INSERT OR UPDATE 
    ON chantiers.releve
    FOR EACH ROW
    EXECUTE PROCEDURE chantiers.ft_update_etat_releve_eau_potable();

COMMENT ON TRIGGER tr_update_etat_releve_eau_potable ON chantiers.releve
    IS 'Trigger: updates auto field of the releve after insert.';

-- Trigger: tr_update_etat_releve_electricite

-- DROP TRIGGER tr_update_etat_releve_electricite ON chantiers.releve;

CREATE TRIGGER tr_update_etat_releve_electricite
    BEFORE INSERT OR UPDATE 
    ON chantiers.releve
    FOR EACH ROW
    EXECUTE PROCEDURE chantiers.ft_update_etat_releve_electricite();

COMMENT ON TRIGGER tr_update_etat_releve_electricite ON chantiers.releve
    IS 'Trigger: updates auto field of the releve after insert.';

-- Trigger: tr_update_etat_releve_gaz

-- DROP TRIGGER tr_update_etat_releve_gaz ON chantiers.releve;

CREATE TRIGGER tr_update_etat_releve_gaz
    BEFORE INSERT OR UPDATE 
    ON chantiers.releve
    FOR EACH ROW
    EXECUTE PROCEDURE chantiers.ft_update_etat_releve_gaz();

COMMENT ON TRIGGER tr_update_etat_releve_gaz ON chantiers.releve
    IS 'Trigger: updates auto field of the releve after insert.';

-- Trigger: tr_update_etat_releve_moyenne_tension

-- DROP TRIGGER tr_update_etat_releve_moyenne_tension ON chantiers.releve;

CREATE TRIGGER tr_update_etat_releve_moyenne_tension
    BEFORE INSERT OR UPDATE 
    ON chantiers.releve
    FOR EACH ROW
    EXECUTE PROCEDURE chantiers.ft_update_etat_releve_moyenne_tension();

COMMENT ON TRIGGER tr_update_etat_releve_moyenne_tension ON chantiers.releve
    IS 'Trigger: updates auto field of the releve after insert.';

-- Trigger: tr_update_etat_releve_swisscom

-- DROP TRIGGER tr_update_etat_releve_swisscom ON chantiers.releve;

CREATE TRIGGER tr_update_etat_releve_swisscom
    BEFORE INSERT OR UPDATE 
    ON chantiers.releve
    FOR EACH ROW
    EXECUTE PROCEDURE chantiers.ft_update_etat_releve_swisscom();

COMMENT ON TRIGGER tr_update_etat_releve_swisscom ON chantiers.releve
    IS 'Trigger: updates auto field of the releve after insert.';