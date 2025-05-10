DO
$$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'admin') THEN
            CREATE ROLE admin WITH LOGIN PASSWORD 'admin' CREATEDB CREATEROLE;
        END IF;

        IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'postgres') THEN
            CREATE ROLE postgres WITH LOGIN PASSWORD 'postgres' SUPERUSER;
        END IF;

        IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'replicator') THEN
            CREATE ROLE replicator WITH REPLICATION LOGIN PASSWORD 'rep-pass';
        END IF;

        IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'strapi') THEN
            CREATE ROLE strapi WITH LOGIN PASSWORD 'strapi' CREATEDB;
        END IF;
    END
$$;
