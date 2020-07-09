
--PRACTICE JOINS--
-- 1. Get all invoices where the unit_price on the invoice_line is greater than $0.99.
SELECT * FROM invoice
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id 
WHERE invoice_line.unit_price > .99;

-- 2. Get the invoice_date, customer first_name and last_name, and total from all invoices.
SELECT i.invoice_date, c.first_name, c.last_name, i.total 
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;

-- 3. Get the customer first_name and last_name and the support rep's first_name and last_name from all customers.
-- Support reps are on the employee table.
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e ON e.employee_id = c.support_rep_id;

-- 4. Get the album title and the artist name from all albums.
SELECT album.title, artist.name
FROM album
JOIN artist ON album.artist_id = artist.artist_id;

-- 5. Get all playlist_track track_ids where the playlist name is Music.
SELECT playlist_track.track_id
FROM playlist_track
JOIN playlist ON playlist_track.playlist_id = playlist.playlist_id
WHERE playlist.name = 'Music';

-- 6. Get all track names for playlist_id 5.
SELECT track.name 
FROM track
JOIN playlist_track ON track.track_id = playlist_track.track_id
WHERE playlist_track.playlist_id = 5;

-- 7. Get all track names and the playlist name that they're on ( 2 joins ).
SELECT track.name, playlist.name
FROM playlist
JOIN playlist_track 
ON playlist.playlist_id = playlist_track.playlist_id
JOIN track
ON playlist_track.track_id = track.track_id;

-- 8. Get all track names and album titles that are the genre Alternative & Punk ( 2 joins ).
SELECT track.name, album.title
FROM genre
JOIN track
ON genre.genre_id = track.genre_id
JOIN album
ON track.album_id = album.album_id
WHERE genre.name = 'Alternative & Punk';