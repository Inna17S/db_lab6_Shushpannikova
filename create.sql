---------------------------------------------
CREATE TABLE Artists
(
  Artist_ID INT NOT NULL,
  artist_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (Artist_ID)
);

CREATE TABLE Genre
(
  GenreID INT NOT NULL,
  genre_name VARCHAR(40) NOT NULL,
  PRIMARY KEY (GenreID)
);

CREATE TABLE Songs
(
  Song_ID VARCHAR(10) NOT NULL,
  Artist_ID INT NOT NULL,
  song_name VARCHAR(50) NOT NULL,
  album VARCHAR(50) NOT NULL,
  energy FLOAT NOT NULL,
  duration_ms FLOAT NOT NULL,
  PRIMARY KEY (Song_ID),
  FOREIGN KEY (Artist_ID) REFERENCES Artists(Artist_ID)
);

CREATE TABLE Chart
(
  Chart_song_ID VARCHAR(50) NOT NULL,
  Song_ID VARCHAR(10) NOT NULL,
  position INT NOT NULL,
  PRIMARY KEY (Chart_song_ID),
  FOREIGN KEY (Song_ID) REFERENCES Songs(Song_ID)
);

CREATE TABLE SongsGenre
(
  Song_ID VARCHAR(10) NOT NULL,
  GenreID INT NOT NULL,
  PRIMARY KEY (Song_ID, GenreID),
  FOREIGN KEY (Song_ID) REFERENCES Songs(Song_ID),
  FOREIGN KEY (GenreID) REFERENCES Genre(GenreID)
);