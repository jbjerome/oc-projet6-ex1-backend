-- Le dump PostgreSQL fourni (00001_0.0.0_init_create.sql) attribue la propriété
-- des objets au rôle "postgres". Or POSTGRES_USER vaut ici "workshops_user"
-- (qui est le superuser), et le rôle "postgres" n'existe donc pas.
-- On le crée (sans LOGIN) afin que les "ALTER ... OWNER TO postgres" du dump
-- s'exécutent sans erreur. workshops_user étant superuser, il conserve un
-- accès complet aux tables ainsi créées.
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'postgres') THEN
    CREATE ROLE postgres;
  END IF;
END
$$;
