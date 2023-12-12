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


