-- common
Select * from customer;
select * from film;
select * from rental;
select * from payment;
select * from category;
select * from inventory;
select * from film_category;
select * from staff;
select * from store;
select * from country;
select * from address;
select * from city;
select * from actor;
select * from film_actor;

-- 1. List the first name and last name of all customers.
select first_name, last_name from customer;

-- 2. Find all the movies that are currently rented out.
SELECT f.film_id, f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NULL;

-- 3. Show the titles of all movies in the 'Action' category.
Select f.title from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name LIKE '%Action%';

-- 4. Count the number of films in each category.
SELECT c.name AS category, COUNT(f.film_id) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

--  5. What is the total amount spent by each customer?
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS name, SUM(p.amount) AS total
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

-- 6. Find the top 5 customers who spent the most.
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS name, SUM(p.amount) AS total
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id Order by total DESC LIMIT 5 ;

--  7. Display the rental date and return date for each rental.
select rental_id, rental_date, return_date from rental group by rental_id;

--  8. List the names of staff members and the stores they manage.
Select st.store_id, CONCAT(st.first_name, ' ', st.last_name) as names from staff st 
join store s on st.store_id = s.store_id ;

--  9. Find all customers living in 'California'.
SELECT customer_id, CONCAT(first_name, ' ' ,last_name) as names
FROM customer
WHERE address_id IN (
  SELECT address_id FROM address WHERE district = 'California');

-- 10. Count how many customers are from each city.
SELECT ci.city, COUNT(c.customer_id) AS total_customers
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY ci.city;

-- 11. Find the film(s) with the longest duration.
SELECT title, length
FROM film
WHERE length = (SELECT MAX(length) FROM film);

-- 12. Which actors appear in the film titled 'Alien Center'?
select CONCAT(first_name, ' ', last_name) as name from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
where f.title =  'Alien Center';

-- 13. Find the number of rentals made each month.
SELECT EXTRACT(MONTH FROM rental_date) AS month, COUNT(rental_id) AS total_rentals
FROM rental
GROUP BY month;

-- 14. Show all payments made by customer 'Mary Smith'.
select amount, payment_date from payment 
join customer c on payment.customer_id = c.customer_id
where c.CONCAT(first_name, ' ', last_name) =  'Mary Smith';

-- 15. List all films that have never been rented.
SELECT f.film_id, f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;

--  16. What is the average rental duration per category?
select avg(f.rental_duration) as avg_rental_duration ,c.name as category from film f 
join film_category fc on fc.film_id = f.film_id
join category c on fc.category_id = c.category_id
group by c.name;

--  17. Which films were rented more than 50 times?
SELECT f.film_id, f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) > 50;

--  18. List all employees hired after the year 2005. INCOMPLETE
SELECT staff_id, first_name, last_name, start_date
FROM staff
WHERE YEAR(start_date) > 2005;

--  19. Show the number of rentals processed by each staff member.
SELECT s.staff_id, CONCAT(s.first_name, ' ' ,s.last_name) as name , COUNT(r.rental_id) AS total_rentals
FROM staff s
JOIN rental r ON s.staff_id = r.staff_id
GROUP BY s.staff_id, s.first_name, s.last_name;

--  20. Display all customers who have not made any payments.
SELECT c.customer_id, CONCAT(c.first_name, ' ',c.last_name) as name 
FROM customer c
left JOIN payment p ON c.customer_id = p.customer_id
WHERE p.payment_id IS NULL;

--  21. What is the most popular film (rented the most)?
SELECT f.film_id, f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
order by rental_count desc limit 1;

--  22. Show all films longer than 2 hours.
SELECT title, length 
FROM film
WHERE length > '120';

-- 23. Find all rentals that were returned late.
SELECT rental_id, rental_date, return_date
FROM rental
WHERE return_date > rental_date + INTERVAL '3 DAYs';

-- 24. List customers and the number of films they rented.
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS name, COUNT(r.rental_id) AS total_rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 25. Write a query to show top 3 rented film categories.
SELECT c.name AS category, COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_rentals DESC
LIMIT 3;

-- 26. Create a view that shows all customer names and their payment totals.
CREATE VIEW Customer_View AS
SELECT 
  CONCAT(c.first_name, ' ', c.last_name) AS name, 
  SUM(p.amount) AS total_payment
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, name;

select * from Customer_View;

-- 27. Update a customer's email address given their ID.
UPDATE customer
SET email = 'new_email@example.com'
WHERE customer_id = 1;

-- 28. Insert a new actor into the actor table. INCOMPLETE
Insert into actor values('201', 'John' , 'Thomas' , now()::timestamp(2));

-- 29. Delete all records from the rentals table where return_date is NULL.
DELETE FROM rental
WHERE return_date IS NULL
AND rental_id NOT IN (SELECT rental_id FROM payment);

-- 30. Add a new column 'age' to the customer table.
alter table customer
add age int default 20 not null;

-- 31. Create an index on the 'title' column of the film table.
create index  film_title  on film(title);

-- 32. Find the total revenue generated by each store.
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

-- 33. What is the city with the highest number of rentals?
SELECT ci.city, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY ci.city
ORDER BY rental_count DESC
LIMIT 1;

-- 34. How many films belong to more than one category?
SELECT COUNT(*) AS multi_category_films
FROM (
  SELECT film_id
  FROM film_category
  GROUP BY film_id
  HAVING COUNT(category_id) > 1
) ;

-- 35. List the top 10 actors by number of films they appeared in.
SELECT 
  CONCAT(a.first_name, ' ', a.last_name) AS name, 
  COUNT(f.film_id) AS no_of_films
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON f.film_id = fa.film_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY no_of_films DESC
LIMIT 10;

-- 36. Retrieve the email addresses of customers who rented 'Matrix Revolutions'.
SELECT DISTINCT c.email
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Matrix Revolutions';

-- 37. Create a stored function to return customer payment total given their ID.
CREATE FUNCTION get_customer_payment_total(cust_id INT)
RETURNS NUMERIC AS $$
BEGIN
  RETURN (
    SELECT SUM(amount)
    FROM payment
    WHERE customer_id = cust_id
  );
END;
$$ LANGUAGE plpgsql;

SELECT get_customer_payment_total(1);

-- 38. Begin a transaction that updates stock and inserts a rental record. INCOMPLETE 
BEGIN;

UPDATE inventory
SET available = false
WHERE inventory_id = 1001;

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (NOW(), 1001, 1, 2);

COMMIT;

rollback;

-- 39. Show the customers who rented films in both 'Action' and 'Comedy' categories.
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name IN ('Action', 'Comedy')
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT cat.name) = 2;

-- 40. Find actors who have never acted in a film.
SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS name
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL;

-- END OF ASSIGNMENT --


