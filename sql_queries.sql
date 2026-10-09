create database sql_project;

use sql_project;
select * from employee;
select * from artist;
select * from genre;
select * from invoice;
select * from track;
select * from playlist;
select * from album;

describe employee;

describe artist;

describe genre;

describe invoice;

describe track;



describe playlist;

describe album;
SELECT album_id, COUNT(*)
FROM album
GROUP BY album_id
HAVING COUNT(*) > 1;

SELECT artist_id, COUNT(*)
FROM artist
GROUP BY artist_id
HAVING COUNT(*) > 1;

SELECT track_id, COUNT(*)
FROM track
GROUP BY track_id
HAVING COUNT(*) > 1;

SELECT genre_id, COUNT(*)
FROM genre
GROUP BY genre_id
HAVING COUNT(*) > 1;

SELECT *
FROM album
WHERE album_id IS NULL;

SELECT *
FROM genre
WHERE genre_id IS NULL;

SELECT *
FROM artist
WHERE artist_id IS NULL;

SELECT *
FROM track
WHERE track_id IS NULL;

ALTER TABLE artist
ADD PRIMARY KEY (artist_id);

ALTER TABLE album
ADD PRIMARY KEY (album_id);

ALTER TABLE track
ADD PRIMARY KEY (track_id);

ALTER TABLE genre
ADD PRIMARY KEY (genre_id);

show columns from album;

ALTER TABLE album
RENAME COLUMN `Ã¯Â»Â¿album_id` TO album_id;



SELECT *
FROM album
WHERE artist_id NOT IN (
    SELECT artist_id FROM artist
);


ALTER TABLE album
ADD CONSTRAINT fk_album_artist
FOREIGN KEY (artist_id)
REFERENCES artist(artist_id);


ALTER TABLE track
ADD CONSTRAINT fk_track_album
FOREIGN KEY (album_id)
REFERENCES album(album_id);

ALTER TABLE track
ADD CONSTRAINT fk_track_genre
FOREIGN KEY (genre_id)
REFERENCES genre(genre_id);


SELECT
    t.track_id,
    t.name AS track_name,
    al.title AS album_name,
    ar.name AS artist_name,
    g.name AS genre_name
FROM track t
INNER JOIN album al
    ON t.album_id = al.album_id
INNER JOIN artist ar
    ON al.artist_id = ar.artist_id
INNER JOIN genre g
    ON t.genre_id = g.genre_id;

SELECT
    t.track_id,
    t.name AS track_name,
    a.title AS album_name,
    ar.name AS artist_name,
    g.name AS genre_name
FROM track t
INNER JOIN album a
    ON t.album_id = a.album_id
INNER JOIN artist ar
    ON a.artist_id = ar.artist_id
INNER JOIN genre g
    ON t.genre_id = g.genre_id;
    
    SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.title AS employee_title,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name
FROM employee e
LEFT JOIN employee m
    ON e.reports_to = m.employee_id;
    
    SELECT
    invoice_id,
    invoice_date,
    billing_city,
    billing_country,
    total
FROM invoice
ORDER BY total DESC;

SELECT
    billing_country,
    COUNT(invoice_id) AS total_invoices,
    ROUND(SUM(total), 2) AS total_revenue
FROM invoice
GROUP BY billing_country
ORDER BY total_revenue DESC;

SELECT
    t.track_id,
    t.name AS track_name,
    a.title AS album_name,
    ar.name AS artist_name,
    t.unit_price
FROM track t
INNER JOIN album a
    ON t.album_id = a.album_id
INNER JOIN artist ar
    ON a.artist_id = ar.artist_id
ORDER BY t.unit_price DESC;


SELECT
    g.genre_id,
    g.name AS genre_name,
    COUNT(t.track_id) AS total_tracks
FROM genre g
LEFT JOIN track t
    ON g.genre_id = t.genre_id
GROUP BY
    g.genre_id,
    g.name
ORDER BY total_tracks DESC;

SELECT
    a.album_id,
    a.title AS album_name,
    COUNT(t.track_id) AS total_tracks
FROM album a
LEFT JOIN track t
    ON a.album_id = t.album_id
GROUP BY a.album_id, a.title
ORDER BY total_tracks DESC;

USE sql_project;

SELECT
    ar.artist_id,
    ar.name AS artist_name,
    COUNT(a.album_id) AS total_albums
FROM artist ar
LEFT JOIN album a
    ON ar.artist_id = a.artist_id
GROUP BY ar.artist_id, ar.name
ORDER BY total_albums DESC;

SELECT *
FROM employee
ORDER BY reports_to ASC;

SELECT
    billing_country,
    COUNT(invoice_id) AS total_invoices
FROM invoice
GROUP BY billing_country
ORDER BY total_invoices DESC;

SELECT DISTINCT total
FROM invoice
ORDER BY total DESC
LIMIT 3;

SELECT
    billing_city,
    ROUND(SUM(total), 2) AS total_revenue
FROM invoice
GROUP BY billing_city
ORDER BY total_revenue DESC
LIMIT 1;

SELECT
    ar.name AS artist_name,
    COUNT(t.track_id) AS total_tracks
FROM artist ar
INNER JOIN album a
    ON ar.artist_id = a.artist_id
INNER JOIN track t
    ON a.album_id = t.album_id
INNER JOIN genre g
    ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
GROUP BY ar.artist_id, ar.name
ORDER BY total_tracks DESC
LIMIT 10;




SELECT
    name AS track_name,
    milliseconds
FROM track
WHERE milliseconds > (
    SELECT AVG(milliseconds)
    FROM track
)
ORDER BY milliseconds DESC;