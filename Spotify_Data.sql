/*
  In this project, I downloaded Spotify data from Kaggle.
  Link: https://www.kaggle.com/datasets/equinxx/spotify-top-50-songs-in-2021?select=spotify_top50_2021.csv
  
  I created a table to insert Spotify data into and performed analytics on the data. 
*/

CREATE TABLE BIT_DB.Spotifydata (
    id integer PRIMARY KEY,
    artist_name varchar NOT NULL,
    track_name varchar NOT NULL,
    track_id varchar NOT NULL,
    popularity integer NOT NULL,
    danceability decimal(4,3) NOT NULL,
    energy decimal(4,3) NOT NULL,
    song_key integer NOT NULL,
    loudness decimal(5,3) NOT NULL,
    song_mode integer NOT NULL,
    speechiness decimal(5,4) NOT NULL,
    acousticness decimal(6,5) NOT NULL,
    instrumentalness decimal(8,7) NOT NULL,
    liveness decimal(5,4) NOT NULL,
    valence decimal(4,3) NOT NULL,
    tempo decimal(6,3) NOT NULL,
    duration_ms integer NOT NULL,
    time_signature integer NOT NULL 
);

-- Total number of tracks per artist
SELECT artist_name, COUNT(track_name) AS song_count
FROM DB.Spotifydata
GROUP BY artist_name;

-- Average danceability by artist/track, ordered from high to low
SELECT artist_name, AVG(danceability) AS dance
FROM DB.Spotifydata
GROUP BY artist_name
ORDER BY dance DESC;

-- Top 10 artists based on popularity
SELECT artist_name
FROM DB.Spotifydata
GROUP BY artist_name
ORDER BY AVG(popularity) DESC
LIMIT 10;

-- Longest song and its artist by minutes (originally in milliseconds)
SELECT track_name, artist_name, duration_ms / 60000.00 AS duration_minutes
FROM DB.Spotifydata
ORDER BY duration_minutes DESC
LIMIT 1;

-- Most energetic Artist
SELECT artist_name AS artist, AVG(energy) AS energy
FROM DB.Spotifydata
GROUP BY artist_name
LIMIT 1;

-- average danceability for the 10 most popular songs
SELECT AVG(danceability) AS top_avg
FROM DB.Spotifydata
WHERE danceability IN (
    SELECT danceability 
    FROM DB.Spotifydata 
    ORDER BY danceability DESC
    LIMIT 10
);


-- 'Top Star' Artist and their respective average popularity using a CTE.
WITH avg_popularity AS (
    SELECT artist_name, AVG(popularity) AS popularity
    FROM Spotifydata 
    GROUP BY artist_name
)

SELECT artist_name AS artist, popularity,'Top Star' AS tag
FROM avg_popularity
WHERE popularity >= 90;        
