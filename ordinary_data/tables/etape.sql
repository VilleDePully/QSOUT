-- Table: chantiers.etape

-- DROP TABLE chantiers.etape;

CREATE TABLE chantiers.etape
(
    id integer NOT NULL DEFAULT nextval('chantiers.etape_id_seq'::regclass),
    fk_chantiers integer NOT NULL,
    numero character varying(50) COLLATE pg_catalog."default" NOT NULL,
    remarque text COLLATE pg_catalog."default",
    the_geom geometry(MultiPolygon,21781),
    CONSTRAINT etape_pk PRIMARY KEY (id),
    CONSTRAINT etape_fk_chantier FOREIGN KEY (fk_chantiers)
        REFERENCES chantiers.chantiers (id) MATCH FULL
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE chantiers.etape
    OWNER to pulfase;

GRANT REFERENCES, SELECT, TRIGGER ON TABLE chantiers.etape TO grp_dtsi_due_r;

GRANT ALL ON TABLE chantiers.etape TO grp_dtsi_due_w;

GRANT ALL ON TABLE chantiers.etape TO pulfase;