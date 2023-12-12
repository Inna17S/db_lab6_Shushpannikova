-- Функція ,яка повинна повертати інформацію про всі пісні вказаного жанру.
DROP FUNCTION get_songs_by_genre(character varying);

CREATE OR REPLACE FUNCTION get_songs_by_genre(p_genre_name VARCHAR(40))
RETURNS TABLE (song_name VARCHAR(50), artist_name VARCHAR(50), album VARCHAR(50), energy FLOAT, duration_ms FLOAT)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        Songs.song_name,
        Artists.artist_name,
        Songs.album,
        Songs.energy,
        Songs.duration_ms
    FROM Songs
    JOIN Artists ON Songs.Artist_ID = Artists.Artist_ID
    JOIN SongsGenre ON Songs.Song_ID = SongsGenre.Song_ID
    JOIN Genre ON SongsGenre.GenreID = Genre.GenreID
    WHERE Genre.genre_name = p_genre_name;
END;
$$;

select * from songs;
select * from genre;
SELECT * FROM get_songs_by_genre('Pop');
