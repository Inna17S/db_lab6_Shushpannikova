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

