USE SAKILA;

-- 1. Write a query to display for each store its store ID, city, and country.
SELECT Store_ID, City, Country FROM sakila.store s
JOIN sakila.address USING(address_ID)
JOIN sakila.city USING(city_ID)
JOIN sakila.country USING(country_ID);

-- 2.Write a query to display how much business, in dollars, each store brought in.
SELECT Store_ID, City, Country, sum(amount) AS Business_in_USD FROM sakila.payment p
JOIN sakila.customer cust USING(Customer_ID)
JOIN sakila.store s USING(Store_ID)
JOIN sakila.address a ON a.address_id = s.address_id 
JOIN sakila.city USING(city_ID)
JOIN sakila.country USING(country_ID)
GROUP BY s.store_id;

-- 3. What is the average running time of films by category?
SELECT name AS Category_Neme, concat(round(AVG(length), 1), ' min') AS Avarage_Running_Time from sakila.film
JOIN sakila.film_category fc USING(film_id)
JOIN sakila.Category c USING(Category_id)
GROUP BY category_id
ORDER BY concat(round(AVG(length))) DESC;

-- 4.Which film categories are longest?
SELECT name AS Category_Neme, concat(round(AVG(length), 1), ' min') AS Avarage_Running_Time from sakila.film
JOIN sakila.film_category fc USING(film_id)
JOIN sakila.Category c USING(Category_id)
GROUP BY category_id
ORDER BY concat(round(AVG(length))) DESC
LIMIT 3; -- hereby 3 longest film categories

SELECT f.title, f.film_id, r.rental_id, r.inventory_id FROM sakila.film f
JOIN sakila.inventory i 
ON f.film_id = i.film_id
JOIN sakila.rental r 
ON i.inventory_id = r.inventory_id;

-- 5. Display the most frequently rented movies in descending order.
SELECT f.title, f.film_id, count(distinct r.rental_id) AS number_of_times_rented, RANK() OVER (ORDER BY count(DISTINCT r.rental_id) DESC) 'Rank' FROM sakila.film f
JOIN sakila.inventory i 
ON f.film_id = i.film_id
JOIN sakila.rental r 
ON i.inventory_id = r.inventory_id
GROUP BY film_id
Limit 15; -- 15 most rented films

-- 6. List the top five genres in gross revenue in descending order.
SELECT RANK() OVER (ORDER BY sum(amount) DESC) 'Rank', name, category_id, sum(amount) Gross_Revenue FROM sakila.category c
JOIN sakila.film_category fc USING(category_id)
JOIN sakila.film f USING(Film_id)
JOIN sakila.inventory i ON f.film_id = i.film_id
JOIN sakila.rental r ON i.inventory_id = r.inventory_id
JOIN sakila.payment p ON r.rental_id = p.rental_id
GROUP BY category_id, name
ORDER BY sum(amount) DESC
Limit 5; 

-- 7. Is "Academy Dinosaur" available for rent from Store 1?

select * from inventory 
where film_id = 1; -- as we can see there are 4 'Acadamy Dinasaur' tapes initialy at store 1

SELECT title AS FILM_NOT_RETURNED, f.film_id, r.inventory_id, store_id FROM sakila.film f
JOIN sakila.inventory i ON f.film_id = i.film_id
JOIN sakila.rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NULL AND r.inventory_id < 9; -- the one taken for rent and not returned is in the Store 2
--  so all 4 tapes are available for rent in the Store 1.

