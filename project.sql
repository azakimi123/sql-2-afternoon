
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


--PRACTICE NESTED QUERIES--
-- 1. Get all invoices where the unit_price on the invoice_line is greater than $0.99.
SELECT * 
FROM invoice
WHERE invoice_id IN 
(SELECT invoice_id FROM invoice_line WHERE unit_price > .99);

-- 2. Get all playlist tracks where the playlist name is Music.
SELECT * 
FROM playlist_track
WHERE playlist_id IN
(SELECT playlist_id FROM playlist WHERE name = 'Music');

-- 3. Get all track names for playlist_id 5.
SELECT name 
FROM track
WHERE track_id IN
(SELECT track_id FROM playlist_track WHERE playlist_id = 5);

-- 4. Get all tracks where the genre is Comedy.
SELECT * 
FROM track
WHERE genre_id IN
(SELECT genre_id FROM genre WHERE name = 'Comedy');

-- 5. Get all tracks where the album is Fireball.
SELECT *
FROM track
WHERE album_id IN
(SELECT album_id FROM album WHERE title = 'Fireball');

-- SELECT * FROM album
-- ORDER BY title ASC;

-- SELECT * FROM track
-- WHERE album_id = 60;

-- 6. Get all tracks for the artist Queen ( 2 nested subqueries ).
SELECT *
FROM track
WHERE album_id IN
(SELECT album_id FROM album WHERE artist_id IN
(SELECT artist_id FROM artist WHERE name = 'Queen'));


--PRACTICING UPDATING ROWS--
-- 1. Find all customers with fax numbers and set those numbers to null.
SELECT * FROM customer
WHERE fax IS NOT null;

UPDATE customer
SET fax = null
WHERE fax IS NOT null;

-- 2. Find all customers with no company (null) and set their company to "Self".
SELECT * FROM customer
WHERE company IS null;

UPDATE customer
SET company = 'Self'
WHERE company IS null;

-- 3. Find the customer Julia Barnett and change her last name to Thompson.
SELECT * FROM customer
WHERE first_name = 'Julia';

UPDATE customer
SET last_name = 'Thompson'
WHERE customer_id = 28;

-- 4. Find the customer with this email luisrojas@yahoo.cl and change his support rep to 4.
SELECT * FROM customer
WHERE email = 'luisrojas@yahoo.cl';

UPDATE customer
SET support_rep_id = 4
WHERE customer_id = 57;
-- 5. Find all tracks that are the genre Metal and have no composer. Set the composer to "The darkness around us".
SELECT * 
FROM track
WHERE composer is null 
AND genre_id IN
(SELECT genre_id FROM genre WHERE name = 'Metal');

UPDATE track
SET composer = 'The darkness around us'
WHERE composer IS null AND genre_id = 3;
-- 6. Refresh your page to remove all database changes.

--GROUP BY--
-- 1. Find a count of how many tracks there are per genre. Display the genre name with the count.
SELECT COUNT(*), genre.name 
FROM track
JOIN genre ON track.genre_id = genre.genre_id
GROUP BY genre.name;

-- 2. Find a count of how many tracks are the "Pop" genre and how many tracks are the "Rock" genre.
SELECT COUNT(*), genre.name 
FROM track
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Pop'
OR genre.name = 'Rock'
GROUP BY genre.name;

-- 3. Find a list of all artists and how many albums they have.
SELECT COUNT(*), artist.name 
FROM album
JOIN artist ON album.artist_id = artist.artist_id
GROUP BY artist.name;

--USE DISTINCT--
-- 1. From the track table find a unique list of all composers.
SELECT DISTINCT composer
FROM track;

-- 2. From the invoice table find a unique list of all billing_postal_codes.
SELECT DISTINCT billing_postal_code
FROM invoice;

-- 3. From the customer table find a unique list of all companys.
SELECT DISTINCT company
FROM customer;

--DELETE PRACTICE--
-- 1. Copy, paste, and run the SQL code from the summary.
-- 2. Delete all 'bronze' entries from the table.
DELETE FROM practice_delete
WHERE type = 'bronze';

-- 3. Delete all 'silver' entries from the table.
DELETE FROM practice_delete
WHERE type = 'silver';

-- 4. Delete all entries whose value is equal to 150.
DELETE FROM practice_delete
WHERE value = 150;




--eCommerce Simulation--
-- 1. Create 3 tables following the criteria in the summary.
CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
  user_name VARCHAR(50),
  email VARCHAR(200)
);

CREATE TABLE products (
	product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(100),
  price INT
);

CREATE TABLE orders (
	order_id SERIAL PRIMARY KEY,
    order_number INT,
  product_id INT REFERENCES products(product_id)
);

-- 2. Add some data to fill up each table. At least 3 users, 3 products, 3 orders.
--Users Table--
INSERT INTO users (
	user_name,
    email
) VALUES (
	'Kurt',
    'kurt123@gmail.com'
);

INSERT INTO users (
	user_name,
    email
) VALUES (
	'Lynne',
    'lynne456@gmail.com'
);

INSERT INTO users (
	user_name,
    email
) VALUES (
	'Kay',
    'kay789@gmail.com'
);

--Products Table--
INSERT INTO products (
	product_name,
    price
) VALUES (
	'peony',
    50
);
INSERT INTO products (
	product_name,
    price
) VALUES (
	'rose',
    75
);

INSERT INTO products (
	product_name,
    price
) VALUES (
	'mixed flower',
    85
);

--Orders Table--
INSERT INTO orders (
	product_id,
    order_number
) VALUES (
    1,
    1
);

INSERT INTO orders (
	product_id,
    order_number
) VALUES (
    2,
    2
);

INSERT INTO orders (
	product_id,
    order_number
) VALUES (
    3,
    3
);

INSERT INTO orders (
	product_id,
    order_number
) VALUES (
    2,
    3
);

-- 3. Run queries against your data.
-- Get all products for the first order.
SELECT *
FROM products
WHERE product_id IN 
(SELECT product_id FROM orders WHERE order_id = 1);

-- Get all orders.
SELECT * FROM orders;

-- Get the total cost of an order ( sum the price of all products on an order ).
SELECT SUM(price)
FROM products
WHERE product_id IN 
(SELECT product_id FROM orders WHERE order_number = 3);

-- 4. Add a foreign key reference from orders to users.
ALTER TABLE orders
ADD COLUMN user_id INT REFERENCES users(user_id);

-- 5. Update the orders table to link a user to each order.
UPDATE orders
SET user_id = 1
WHERE order_id = 1;

UPDATE orders
SET user_id = 2
WHERE order_id = 2;

UPDATE orders
SET user_id = 3
WHERE order_id = 3;

UPDATE orders
SET user_id = 3
WHERE order_id = 4;


-- Run queries against your data.
-- 6. Get all orders for a user.
SELECT COUNT(orders.order_id), users.user_name
FROM orders 
JOIN users on users.user_id = orders.user_id
WHERE users.user_id = 3
GROUP BY users.user_id;

-- 7. Get how many orders each user has.

SELECT COUNT(DISTINCT orders.order_id), users.user_name
FROM orders
JOIN users ON users.user_id = orders.user_id
GROUP BY users.user_id;