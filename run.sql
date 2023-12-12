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


-- Процедура, яка перевіряє чи існує виконавець з таким ім'ям в таблиці, якщо ні - то додає його в таблицю як нового виконавця
SELECT * FROM artists;
DROP PROCEDURE IF EXISTS add_artist(varchar(50));

CREATE OR REPLACE PROCEDURE add_artist(p_artist_id INT,p_artist_name VARCHAR(50))
LANGUAGE plpgsql
AS $$
BEGIN
    -- Перевірка, чи виконавець із таким artist_id вже існує
    IF EXISTS (SELECT 1 FROM Artists WHERE artist_id = p_artist_id OR artist_name = p_artist_name) THEN
        RAISE EXCEPTION 'Виконавець з таким імям вже існує.';
    ELSE
        -- Додавання нового виконавця
        INSERT INTO Artists (Artist_ID, artist_name) VALUES (p_artist_id, p_artist_name);
        RAISE NOTICE 'Виконавець "%", успішно доданий', p_artist_name, p_artist_id;
    END IF;
END;
$$;

-- Виклик процедури для додавання нового виконавця
Call add_artist(2828, 'Cardi B');
Call add_artist(2828, 'Cardi');
Call add_artist(2727, 'Cardi B');
CALL add_artist(6060, 'Каlush');
SELECT * FROM artists;


-- тригер , який при вставці нового рядка в таблицю 
-- Songs записує id пісні  (значення поля song_id) у нижньому регістрі 
select * from songs;

DROP TRIGGER IF EXISTS AFTER_insert_songs ON songs;

CREATE OR REPLACE FUNCTION convert_song_id_lower()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- Запис song_id у нижньому регістрі 
    UPDATE songs SET song_id = LOWER(song_id)  
    WHERE songs.song_id = NEW.song_id;
    RETURN NEW;
END;
$$;

CREATE TRIGGER AFTER_insert_songs
AFTER INSERT ON Songs
FOR EACH ROW EXECUTE FUNCTION convert_song_id_lower();

select * from songs;
INSERT INTO Songs (Song_ID, Artist_ID, song_name, album, energy, duration_ms) 
VALUES ('R1B51', 6060, 'Stefania', 'Stefania', 0.980, 430040);
