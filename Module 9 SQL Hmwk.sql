USE sakila;

#1a Create a table that displays the first and last name of actors
select * from actor;

#1b Display First and Last Name of Actors in single column
SELECT concat(first_name, " ", last_name) as "Actor Names"
FROM actor;

#2a Locate the ID number, first name, and last name of "Joe"
select * from actor
where first_name = "Joe";

#2b Find all actors whose last name contain the letters GEN
SELECT * FROM actor
where last_name LIKE "%GEN%";

#2c Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order
SELECT actor_id, last_name, first_name
FROM actor
where last_name LIKE "%LI%";

#2d Using IN, display the country_id and country columns of the following countries: 
#Afghanistan, Bangladesh, and China
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3a Create Description column of Actors in 'Actor'
ALTER TABLE actor
ADD COLUMN Description BLOB;

#3b Delete Description Column
ALTER TABLE actor
DROP COLUMN Description;

#4a List the Last Name of Actors AND How many of that Last Name
SELECT last_name, COUNT(last_name) AS "Last Name Count"
from actor 
GROUP BY last_name;

#4b List the last name of actors AND number of actors who have the same last name 
# BUT they must be shared by at least TWO actors
SELECT last_name, COUNT(last_name) as "Last Name Count"
from actor 
GROUP BY last_name HAVING COUNT(last_name) >=2;

#4c Edit "Harpo Williams" into "Groucho Williams"
UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";

#4d Revert "Groucho Willams" BACK to "Harpo Williams"
UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO" AND last_name = "WILLIAMS";

#5a Locate the schema of the address table
SHOW CREATE TABLE address;

#6a Use JOIN to find the "First Name", "Last Name" and "Address" of all staff members
SELECT first_name, last_name, address
FROM staff s
JOIN address a
ON s.address_id = a.address_id;

#6b Use JOIN to find the amount of payments by each staff in August 2005
SELECT s.first_name, s.last_name, SUM(p.amount) AS "Total Payments"
FROM (
	SELECT staff_id, amount, payment_date
    FROM payment
    WHERE payment_date LIKE '2005-08%') AS p
JOIN staff s 
ON p.staff_id=s.staff_ID
GROUP BY s.first_name, s.last_name;

#6c List each film and the number of actors who are listed for that film
SELECT f.title, COUNT(fa.actor_id) AS 'Number of Actors'
FROM film f
INNER JOIN  film_actor fa
ON f.film_id = fa.film_id
GROUP BY f.title;


#6d How many copies of Hunchback Impossible Exist in Inventory?
SELECT f.title, COUNT(i.inventory_id) AS "Film Count" 
FROM film f, inventory i
WHERE f.film_id = i.film_id
AND f.title = "Hunchback Impossible"
GROUP BY f.title
;
#6e. Using the tables payment and customer and the JOIN command, 
#list the total paid by each customer. 
#List the customers alphabetically by last name
SELECT c.first_name, c.last_name, sum(p.amount) AS "Total Paid"
FROM payment p, customer c
WHERE p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name ASC
;

#7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. 
#As an unintended consequence, films starting with the letters K and Q have also soared in popularity. 
#Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
SELECT f.title
FROM film f
WHERE  (f.title LIKE "K%" OR f.title LIKE "Q%" )
AND f.language_id = (
	SELECT language_id
	FROM language
	WHERE name = "English");
    
#7b Use subqueries to display all actors who appear in the film Alone Trip
SELECT a.first_name, a.last_name
FROM actor a, film_actor fa
WHERE a.actor_id =  fa.actor_id
AND fa.film_id = (
	SELECT film_id
	FROM film
	WHERE title = "Alone Trip");





;

 