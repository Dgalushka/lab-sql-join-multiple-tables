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
JOIN sakila.address a on a.address_id = s.address_id 
JOIN sakila.city USING(city_ID)
JOIN sakila.country USING(country_ID)
GROUP BY s.store_id;

-- 3. What is the average running time of films by category?
SELECT name AS Category_Neme, concat(round(AVG(length), 1), ' min') AS Avarage_Running_Time from sakila.film
JOIN sakila.film_category fc USING(film_id)
JOIN sakila.Category c USING(Category_id)
GROUP BY category_id
ORDER BY concat(round(AVG(length))) DESC;