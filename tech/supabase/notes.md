- https://github.com/supabase/gotrue#external-authentication-providers
- Self-hosted OAuth Redirect URI: http://localhost:8000/auth/v1/callback
- On create user trigger: https://supabase.com/docs/guides/auth/managing-user-data#advanced-techniques
- https://supabase.com/docs/guides/cli/local-development#database-migrations
  - `supabase db diff create_employees -f create_employees`
- Reset database
  - `supabase db reset`
- ```sql
  CREATE or REPLACE FUNCTION fetch_user_data() 
  RETURNS void AS $$
  DECLARE user_data json;
  
  BEGIN
    user_data := fetch_json_from_url('http://some.url/api/user/1');
    INSERT INTO users (id, data) VALUES (1, user_data);
  END;
  
  $$ LANGUAGE plpgsql;
  ```
- automatic `updated_at`
  - 
    ```sql
    CREATE EXTENSION IF NOT EXISTS moddatetime SCHEMA public;

    CREATE TRIGGER table_name_handle_updated_at BEFORE UPDATE ON table_name 
      FOR EACH ROW EXECUTE PROCEDURE moddatetime (updated_at);
    ```