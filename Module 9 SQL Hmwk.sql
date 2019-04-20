USE sakila;

#1a first and last name of actors
select * from actor;

#1b Display First and Last Name of Actors in single column
SELECT concat(first_name, " ", last_name) as "Actor Names"
FROM actor;