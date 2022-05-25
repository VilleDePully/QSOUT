-- Table: chantiers.chantiers

-- DROP TABLE chantiers.chantiers;

CREATE TABLE chantiers.chantiers
(
    id integer NOT NULL DEFAULT nextval('chantiers.chantiers_id_seq'::regclass),
    numero character varying(40) COLLATE pg_catalog."default",
    nom character varying(255) COLLATE pg_catalog."default",
    localisation text COLLATE pg_catalog."default" NOT NULL,
    type_chantier character varying(50) COLLATE pg_catalog."default" NOT NULL,
    date_debut date,
    date_fin date,
    remarque text COLLATE pg_catalog."default",
    the_geom geometry(MultiPolygon,21781),
    commune character varying(50) COLLATE pg_catalog."default" NOT NULL,
    fk_contact integer,
    etat_chantier character varying(50) COLLATE pg_catalog."default" NOT NULL,
    plan_projet text COLLATE pg_catalog."default",
    dossier text COLLATE pg_catalog."default",
    fk_reseau integer[] NOT NULL,
    folios text COLLATE pg_catalog."default",
    plan_investissement character varying(50) COLLATE pg_catalog."default",
    gestionnaire character varying(50) COLLATE pg_catalog."default",
    date_ref_pi date,
    CONSTRAINT chantiers_pkey PRIMARY KEY (id),
    CONSTRAINT check_date_debut CHECK (date_debut < '2100-01-01'::date AND date_debut > '2010-01-01'::date),
    CONSTRAINT check_dates CHECK (date_debut <= date_fin)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE chantiers.chantiers
    OWNER to pulfase;

GRANT REFERENCES, SELECT, TRIGGER ON TABLE chantiers.chantiers TO grp_dtsi_due_r;

GRANT ALL ON TABLE chantiers.chantiers TO pulfase;

GRANT ALL ON TABLE chantiers.chantiers TO grp_dtsi_due_w;

COMMENT ON COLUMN chantiers.chantiers.date_ref_pi
    IS 'Date de référence d''établissement du plan des investissement';

COMMENT ON CONSTRAINT check_date_debut ON chantiers.chantiers
    IS 'Contrôle que l''année est comprise entre 2010 et 2100';
COMMENT ON CONSTRAINT check_dates ON chantiers.chantiers
    IS 'Contrôle que la date de début ne soit pas plus récente que la date de fin';
-- Index: chantiers_the_geom_1551964322866

-- DROP INDEX chantiers.chantiers_the_geom_1551964322866;

CREATE INDEX chantiers_the_geom_1551964322866
    ON chantiers.chantiers USING gist
    (the_geom)
    TABLESPACE pg_default;

-- Trigger: tr_chantiers_folios

-- DROP TRIGGER tr_chantiers_folios ON chantiers.chantiers;

CREATE TRIGGER tr_chantiers_folios
    BEFORE INSERT OR UPDATE 
    ON chantiers.chantiers
    FOR EACH ROW
    EXECUTE PROCEDURE chantiers.ft_get_folios();

COMMENT ON TRIGGER tr_chantiers_folios ON chantiers.chantiers
    IS 'Trigger: updates auto field of the chantier after insert.';