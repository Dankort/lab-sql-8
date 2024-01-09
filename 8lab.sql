use sakila;

-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output

select 
    title,
    length,
rank() over (order by length desc) as ranking
from  film
where length is not null and length > 0;

-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
SELECT
    title,
    length,
    rating,
    rank() over (partition by rating order by length desc) as ranking
from film
where length is not null and length > 0;

-- 3.How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".

select
    c.category_id,
    c.name as category_name,
    COUNT(fc.film_id) as film_count
from
    category c
join
    film_category fc on c.category_id = fc.category_id
group by
    c.category_id, c.name
order by
    film_count desc;
    
-- 4.Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.  

select
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) as film_count
from
    actor a
join
    film_actor fa ON a.actor_id = fa.actor_id
group by
    a.actor_id, a.first_name, a.last_name
order by
    film_count desc
limit 1;  

-- 5.Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

select
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) as rental_count
from
    customer c
join
    rental r on c.customer_id = r.customer_id
group  by
    c.customer_id, c.first_name, c.last_name
order by
    rental_count desc
limit 1;

-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).

select
    f.film_id,
    f.title,
    COUNT(r.rental_id) as rental_count
from
    film f
join
    inventory i on f.film_id = i.film_id
join
    rental r on i.inventory_id = r.inventory_id
group by
    f.film_id, f.title
order by
    rental_count desc
limit 1;

