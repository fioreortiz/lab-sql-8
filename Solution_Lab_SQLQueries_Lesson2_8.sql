-- 1. Write a query to display for each store its store ID, city, and country.
USE sakila;

SELECT s.store_id, city, country FROM sakila.store as s
JOIN sakila.address as a
ON s.address_id = a.address_id
JOIN sakila.city as c
ON a.city_id = c.city_id
JOIN sakila.country as co
ON c.country_id = co.country_id;


-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT sum(amount) FROM sakila.payment;

SELECT s.store_id, sum(amount) FROM sakila.store as s
JOIN sakila.customer as c
ON s.store_id = c.store_id
JOIN sakila.payment as p
ON c.customer_id = p.customer_id
GROUP BY s.store_id;


-- 3. Which film categories are longest?
SELECT * FROM sakila.film;

SELECT c.category_id, name, round(AVG(length),2) AS longest_category FROM sakila.category as c
JOIN sakila.film_category as fc
ON c.category_id = fc.category_id
JOIN sakila.film as f
ON fc.film_id = f.film_id
GROUP BY c.category_id
ORDER BY longest_category DESC;


-- 4. Display the most frequently rented movies in descending order.
SELECT f.film_id, title, count(rental_id) AS most_rented_movies FROM sakila.film as f
JOIN sakila.inventory as i
ON f.film_id = i.film_id
JOIN sakila.rental as r
ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY most_rented_movies DESC;


-- 5. List the top five genres in gross revenue in descending order.
SELECT c.category_id, name, sum(amount) AS gross_revenue FROM sakila.category as c
JOIN sakila.film_category as fc
ON c.category_id = fc.category_id
JOIN sakila.film as f
ON fc.film_id = f.film_id
JOIN sakila.inventory as i
ON f.film_id = i.film_id
JOIN sakila.rental as r
ON i.inventory_id = r.inventory_id
JOIN sakila.payment as p
ON r.rental_id = p.rental_id
GROUP BY c.category_id
ORDER BY gross_revenue DESC
LIMIT 5;


-- 6. Is "Academy Dinosaur" available for rent from Store 1?
-- The answer es Yes, but I can't not understand why is the only film than results after join the tables.
SELECT s.store_id, title, return_date FROM sakila.store as s
JOIN sakila.inventory as i
ON s.store_id = i.inventory_id
JOIN sakila.film as f
ON i.film_id = f.film_id
JOIN sakila.rental as r
ON i.inventory_id = r.inventory_id
WHERE s.store_id = 1;


-- 7. Get all pairs of actors that worked together.
SELECT f.film_id, title, fa.actor_id, first_name, last_name FROM sakila.film as f
JOIN sakila.film_actor as fa
ON f.film_id = fa.film_id
JOIN sakila.actor as a
ON fa.actor_id = a.actor_id
ORDER BY title;


-- These questions are tricky, you can wait until after Monday's lesson to use new techniques to answer them!

-- 8. Get all pairs of customers that have rented the same film more than 3 times.

-- I made this table first to understand the variable that I want to select.
SELECT c.customer_id, first_name, last_name, f.film_id, title FROM sakila.customer as c
JOIN sakila.rental as r
ON c.customer_id = r.customer_id
JOIN sakila.inventory as i
ON r.inventory_id = i.inventory_id
JOIN sakila.film as f
ON i.film_id = f.film_id;

-- In this table I add the function to obtain the name of the customers that have rented the same film more than 3 times. It's 0. But, if I change the number por 1, or 2, displays names, so I think it's correct

SELECT c.customer_id, first_name, last_name, f.film_id, title FROM sakila.customer as c
JOIN sakila.rental as r
ON c.customer_id = r.customer_id
JOIN sakila.inventory as i
ON r.inventory_id = i.inventory_id
JOIN sakila.film as f
ON i.film_id = f.film_id
GROUP BY c.customer_id, r.customer_id, f.film_id
HAVING COUNT(*)>3;

-- 9. For each film, list actor that has acted in more films.
SELECT a.actor_id, first_name, last_name, fa.film_id FROM sakila.actor as a
JOIN sakila.film_actor as fa
ON a.actor_id = fa.actor_id;

-- I'm not sure if understand the instruction, I list the actor than has acted in more films. Because is confusing how by each film I can obtain a list actor that has acted in more films.
SELECT a.actor_id, first_name, last_name, count(fa.film_id) AS films_for_actor FROM sakila.actor as a
JOIN sakila.film_actor as fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY films_for_actor DESC;



