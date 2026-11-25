# Databases

## Create and display a playlist

Run these scripts once, in this order, in the same Oracle schema:

1. `usertable.sql`
2. `mood.sql`
3. `movietable.sql`
4. `musictable.sql`
5. `insertions.sql`
6. `playlist`

Then run this PL/SQL block to create and display a playlist for Interstellar's
`Soundtrack` songs:

```sql
SET SERVEROUTPUT ON

DECLARE
    v_playlist_id NUMBER;
BEGIN
    generate_playlist(
        101,
        'Soundtrack',
        'Interstellar soundtrack',
        v_playlist_id
    );
    display_playlist(v_playlist_id);
END;
/
```