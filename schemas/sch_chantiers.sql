-- SCHEMA: chantiers

-- DROP SCHEMA IF EXISTS chantiers ;

CREATE SCHEMA IF NOT EXISTS chantiers
    AUTHORIZATION postgres;

GRANT USAGE ON SCHEMA chantiers TO grp_dtsi_due_r;

GRANT USAGE ON SCHEMA chantiers TO grp_dtsi_due_w;

GRANT ALL ON SCHEMA chantiers TO grp_dtsi_expert_user;

GRANT ALL ON SCHEMA chantiers TO postgres;

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA chantiers
GRANT SELECT, REFERENCES, TRIGGER ON TABLES TO grp_dtsi_due_r;

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA chantiers
GRANT ALL ON TABLES TO grp_dtsi_due_w;

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA chantiers
GRANT SELECT ON SEQUENCES TO grp_dtsi_due_r;

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA chantiers
GRANT ALL ON SEQUENCES TO grp_dtsi_due_w;