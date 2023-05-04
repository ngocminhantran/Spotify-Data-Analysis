-- Create temp table "tracks_modified" where we can manipulate and restructure data without altering the original one
DROP TABLE IF EXISTS tracks_modified;
    SELECT
        id,
        name,
        popularity,
        (CAST(duration_ms AS FLOAT(53))/1000)  AS duration,
        explicit,
        REPLACE(REPLACE(REPLACE(artists, '''', ''), '[', ''), ']', '') AS artists,
        REPLACE(REPLACE(REPLACE(id_artists, '''', ''), '[', ''), ']', '') AS id_artists,
        CASE WHEN LEN(TRIM(release_date)) = 10  THEN CONVERT(DATE, release_date, 111)
            WHEN LEN(TRIM(release_date)) = 7 THEN CONVERT(DATE, release_date + '-01', 111)
            WHEN LEN(TRIM(release_date)) = 4 THEN CONVERT(DATE, release_date + '-01-01', 111)
            ELSE NULL END AS release_date,
        danceability, 
        energy,
        [key],
        loudness,
        mode,
        speechiness, 
        acousticness, 
        instrumentalness,
        liveness,
        valence,
        tempo,
        time_signature
    INTO [dbo].[tracks_modified]
    FROM Spotify_Project.dbo.tracks;



-- Create temp table "artists_modified" where we can manipulate and restructure data without altering the original one
DROP TABLE IF EXISTS artists_modified;
    SELECT
        id,
        followers,
        REPLACE(REPLACE(REPLACE(genres, '''', ''), '[', ''), ']', '') AS genres,
        name,
        popularity
    INTO [dbo].[artists_modified]
    FROM Spotify_Project.dbo.artists;



-- Check for null values in "id" field in 'tracks_modified'
SELECT
    COUNT(*) AS count_all, 
    COUNT(id) AS count_id
FROM Spotify_Project.dbo.tracks_modified;



-- Check for duplicates in "id" field in "tracks_modified"
SELECT 
    id, 
    COUNT(id) AS count_id
FROM Spotify_Project.dbo.tracks_modified
GROUP BY id
HAVING COUNT(id) > 1;



-- Check for null values in "id" field in "artists_modified"
SELECT id 
FROM Spotify_Project.dbo.artists_modified
WHERE id = NULL;



-- Check for duplicates in "id" field in "artists_modified"
SELECT id, COUNT(id) AS count_id
FROM Spotify_Project.dbo.artists_modified
GROUP BY id
HAVING COUNT(id) > 1;



-- Find correlation between popularity and track variables
SELECT
    'popularity' AS var1,
    'duration' AS var2,
    ((SUM(popularity * duration) - SUM(popularity)*SUM(duration)/COUNT(*))
        /(SQRT(SUM(SQUARE(popularity))-SQUARE(SUM(popularity))/COUNT(*))*SQRT(SUM(SQUARE(duration))-SQUARE(SUM(duration))/COUNT(*)))) AS coeff
FROM Spotify_Project.dbo.tracks_modified
WHERE duration IS NOT NULL
UNION
SELECT
    'popularity' AS var1,
    'danceability' AS var2,
    ((SUM(popularity * danceability) - SUM(popularity)*SUM(danceability)/COUNT(*))
        /(SQRT(SUM(SQUARE(popularity))-SQUARE(SUM(popularity))/COUNT(*))*SQRT(SUM(SQUARE(danceability))-SQUARE(SUM(danceability))/COUNT(*)))) AS coeff
FROM Spotify_Project.dbo.tracks_modified
WHERE danceability IS NOT NULL
UNION
SELECT
    'popularity' AS var1,
    'loudness' AS var2,
    ((SUM(popularity * loudness) - SUM(popularity)*SUM(loudness)/COUNT(*))
        /(SQRT(SUM(SQUARE(popularity))-SQUARE(SUM(popularity))/COUNT(*))*SQRT(SUM(SQUARE(loudness))-SQUARE(SUM(loudness))/COUNT(*)))) AS coeff
FROM Spotify_Project.dbo.tracks_modified
WHERE loudness IS NOT NULL
UNION
SELECT 
    'popularity' AS var1,
    'energy' AS var2,
    ((SUM(popularity * energy) - SUM(popularity)*SUM(energy)/COUNT(*))
        /(SQRT(SUM(SQUARE(popularity))-SQUARE(SUM(popularity))/COUNT(*))*SQRT(SUM(SQUARE(energy))-SQUARE(SUM(energy))/COUNT(*)))) AS coeff
FROM Spotify_Project.dbo.tracks_modified
WHERE energy IS NOT NULL
UNION
select 
    'popularity' AS var1,
    'speechiness' AS var2,
    ((SUM(popularity * speechiness) - SUM(popularity)*SUM(speechiness)/COUNT(*))
        /(SQRT(SUM(SQUARE(popularity))-SQUARE(SUM(popularity))/COUNT(*))*SQRT(SUM(SQUARE(speechiness))-SQUARE(SUM(speechiness))/COUNT(*)))) AS coeff
FROM Spotify_Project.dbo.tracks_modified
WHERE speechiness IS NOT NULL
UNION
SELECT
    'popularity' AS var1,
    'acousticness' AS var2,
    ((SUM(popularity * acousticness) - SUM(popularity)*SUM(acousticness)/COUNT(*))
        /(SQRT(SUM(SQUARE(popularity))-SQUARE(SUM(popularity))/COUNT(*))*SQRT(SUM(SQUARE(acousticness))-SQUARE(SUM(acousticness))/COUNT(*)))) AS coeff
FROM Spotify_Project.dbo.tracks_modified
WHERE acousticness IS NOT NULL
UNION
SELECT
    'popularity' AS var1,
    'instrumentalness' AS var2,
    ((SUM(popularity * instrumentalness) - SUM(popularity)*SUM(instrumentalness)/COUNT(*))
        /(SQRT(SUM(SQUARE(popularity))-SQUARE(SUM(popularity))/COUNT(*))*SQRT(SUM(SQUARE(instrumentalness))-SQUARE(SUM(instrumentalness))/COUNT(*)))) AS coeff
FROM Spotify_Project.dbo.tracks_modified
WHERE instrumentalness IS NOT NULL
UNION
SELECT
    'popularity' AS var1,
    'liveness' AS var2,
    ((SUM(popularity * liveness) - SUM(popularity)*SUM(liveness)/COUNT(*))
        /(SQRT(SUM(SQUARE(popularity))-SQUARE(SUM(popularity))/COUNT(*))*SQRT(SUM(SQUARE(liveness))-SQUARE(SUM(liveness))/COUNT(*)))) AS coeff
FROM Spotify_Project.dbo.tracks_modified
WHERE liveness IS NOT NULL
UNION
SELECT 
    'popularity' AS var1,
    'valence' AS var2,
    ((SUM(popularity * valence) - SUM(popularity)*SUM(valence)/COUNT(*))
        /(SQRT(SUM(SQUARE(popularity))-SQUARE(SUM(popularity))/COUNT(*))*SQRT(SUM(SQUARE(valence))-SQUARE(SUM(valence))/COUNT(*)))) AS coeff
FROM Spotify_Project.dbo.tracks_modified
WHERE valence IS NOT NULL
UNION
SELECT 
    'popularity' AS var1,
    'tempo' AS var2,
    ((SUM(popularity * tempo) - SUM(popularity)*SUM(tempo)/COUNT(*))
        /(SQRT(SUM(SQUARE(popularity))-SQUARE(SUM(popularity))/COUNT(*))*SQRT(SUM(SQUARE(tempo))-SQUARE(SUM(tempo))/COUNT(*)))) AS coeff
FROM Spotify_Project.dbo.tracks_modified
WHERE tempo IS NOT NULL
UNION
SELECT
    'popularity' AS var1,
    'time_signature' AS var2,
    ((SUM(popularity * time_signature) - SUM(popularity)*SUM(time_signature)/COUNT(*))
        /(SQRT(SUM(SQUARE(popularity))-SQUARE(SUM(popularity))/COUNT(*))*SQRT(SUM(SQUARE(time_signature))-SQUARE(SUM(time_signature))/COUNT(*)))) AS coeff
FROM Spotify_Project.dbo.tracks_modified
WHERE time_signature IS NOT NULL;



-- Find the most popular tracks
SELECT TOP 10 * 
FROM Spotify_Project.dbo.tracks_modified
ORDER BY popularity DESC;



-- Find the least popular songs
SELECT TOP 10 * 
FROM Spotify_Project.dbo.tracks_modified
ORDER BY popularity ASC;



-- Find the proportion between explicit tracks and non-explicit tracks
SELECT COUNT(id), explicit 
FROM Spotify_Project.dbo.tracks_modified
GROUP BY explicit;



-- Find the correlation between popularity and explicit score
SELECT COUNT(id), explicit 
FROM Spotify_Project.dbo.tracks_modified
WHERE popularity = 0
GROUP BY explicit;



-- Find the years with the highest number of tracks published
SELECT 
    COUNT(id) AS count_tracks,
    YEAR(release_date) AS year
FROM Spotify_Project.dbo.tracks_modified
GROUP BY YEAR(release_date)
ORDER BY count_tracks DESC;



-- Find the change in the track average duration over years
WITH CTE AS (
    SELECT 
        AVG(duration) AS average_duration,
        YEAR(release_date) AS year
    FROM Spotify_Project.dbo.tracks_modified
    GROUP BY YEAR(release_date)
    )
SELECT average_duration, year, RANK() OVER(ORDER BY average_duration) AS rank
FROM CTE
ORDER BY year DESC;



-- Find artists behind most popular track
WITH CTE1 AS (
        SELECT id_artists
        FROM Spotify_Project.dbo.tracks_modified 
        WHERE popularity = 
            (SELECT TOP 1 popularity
            FROM Spotify_Project.dbo.tracks_modified
            ORDER BY popularity DESC)
    ),
    CTE2 AS (
        SELECT value AS individual_artist
        FROM CTE1
        CROSS APPLY STRING_SPLIT(id_artists, ',') 
    )
SELECT id, name, popularity
FROM Spotify_Project.dbo.artists_modified
WHERE id IN (
    SELECT TRIM(individual_artist)
    FROM CTE2
    );



-- Find artists with the highest number of followers
SELECT TOP 10 id, name, followers
FROM Spotify_Project.dbo.artists_modified
ORDER BY followers DESC;



-- Find the most popular artists
SELECT TOP 10 id, name, popularity
FROM Spotify_Project.dbo.artists_modified
ORDER BY popularity DESC;



-- Find the correlation between popularity and number of followers
SELECT
    'popularity' AS var1,
    'followers' AS var2,
    ((SUM(popularity * followers) - SUM(popularity)*SUM(followers)/COUNT(*))
            /(SQRT(SUM(SQUARE(popularity))-SQUARE(SUM(popularity))/COUNT(*))*SQRT(SUM(SQUARE(followers))-SQUARE(SUM(followers))/COUNT(*)))) AS coeff
FROM Spotify_Project.dbo.artists_modified
WHERE followers IS NOT NULL;



-- How popular are artists with the least popular tracks?
WITH CTE1 AS (
    SELECT id_artists
    FROM Spotify_Project.dbo.tracks_modified 
    WHERE popularity = 
        (SELECT TOP 1 popularity
        FROM Spotify_Project.dbo.tracks_modified
        ORDER BY popularity ASC)
    ),
    CTE2 AS (
        SELECT value AS individual_artist
        FROM CTE1
        CROSS APPLY STRING_SPLIT(id_artists, ',') 
    )
SELECT id, name, popularity
FROM Spotify_Project.dbo.artists_modified
WHERE id in (
    SELECT TRIM(individual_artist)
    FROM CTE2
    )
ORDER BY popularity DESC;



-- Find artists who appear in the highest number of tracks
WITH artists AS (
    SELECT value as individual_artist
    FROM Spotify_Project.dbo.tracks_modified 
    CROSS APPLY STRING_SPLIT(id_artists, ',')
    ),
    artist_count AS (
        SELECT TOP 5 TRIM(individual_artist) AS id_artist, COUNT(individual_artist) AS count 
        FROM artists
        GROUP BY individual_artist 
        ORDER BY count DESC
    )
SELECT c.id_artist, c.count,
    (SELECT artists
    FROM Spotify_Project.dbo.tracks_modified AS t
    WHERE t.id_artists = c.id_artist
    GROUP BY artists) AS artists
FROM artist_count as c;


-- Find the genre having the largest number of artists
WITH genres_table AS (
    SELECT value AS individual_genre
    FROM Spotify_Project.dbo.artists_modified 
    CROSS APPLY STRING_SPLIT(genres, ',')
    WHERE genres IS NOT NULL AND genres <> ''
    )
SELECT TOP 5 TRIM(individual_genre) AS genre, COUNT(individual_genre) AS count 
FROM genres_table
GROUP BY individual_genre 
ORDER BY count DESC;
    
  
        
    
    