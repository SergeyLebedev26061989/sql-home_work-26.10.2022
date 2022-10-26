
--1 количество исполнителей в каждом жанре!
SELECT g.name, COUNT(s.name) FROM singer s 
JOIN genre_singer gs ON s.id = gs.id 
JOIN genre g ON gs.genre_id = g.id 
GROUP BY g.name ;


--2 количество треков, вошедших в альбомы 2019-2020 годов!
SELECT t.name, COUNT(DISTINCT t.id) FROM tracks t 
JOIN albums a ON t.id  = a.id
WHERE YEAR BETWEEN 2019 AND 2020
GROUP BY t.id;

--3 средняя продолжительность треков по каждому альбому!
SELECT AVG(time), a.name FROM albums a 
JOIN tracks t ON a.id = t.albums_id 
GROUP BY a.name;

--4 все исполнители, которые не выпустили альбомы в 2020 году!
SELECT s.name FROM singer s
JOIN albums a ON s.id = a.id 
WHERE YEAR != 2020
GROUP BY s.name;

--5 названия сборников, в которых присутствует конкретный исполнитель (выберите сами)!
SELECT s.name, c.name  FROM collections c  
JOIN singer s ON s.id = c.id 
WHERE s.name = 'singer2';

--6 название альбомов, в которых присутствуют исполнители более 1 жанра!
SELECT a.name, a.year FROM albums a 
JOIN singer_albums sa ON a.id = sa.albums_id 
JOIN singer s ON sa.albums_id = s.id
JOIN genre_singer gs ON s.id = gs.singer_id 
GROUP BY s.name, a.name, gs.genre_id, a.year 
HAVING (gs.genre_id) > 1;


--7 наименование треков, которые не входят в сборники!
SELECT t.name FROM tracks t 
JOIN tracks_collections tc ON t.id = tc.track_id 
WHERE tc.track_id IS NULL; 


--8 исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько)!
SELECT s.name, min(t.time) AS small_time FROM singer s
JOIN singer_albums sa ON s.id = sa.singer_id 
JOIN albums a ON sa.singer_id = a.id 
JOIN tracks t ON a.id = t.albums_id 
WHERE t.time = (SELECT min(time) FROM tracks)
GROUP BY s.name;

--9 название альбомов, содержащих наименьшее количество треков!
SELECT a.name, COUNT(t.id)  FROM albums a 
JOIN tracks t ON a.id = t.albums_id 
GROUP BY a.name 
HAVING COUNT(t.id) IN (SELECT COUNT(t.id) 
  FROM albums a
  JOIN tracks t  ON a.id = t.albums_id 
  GROUP BY a.name 
  ORDER BY count(t.id)
  LIMIT 1
  );

