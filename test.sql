
-- Question 1 List all customers who live in Texas(use JOINs)
--Answer Dorothy Taylor, Thelma Murray, Daniel Cabral, Leonard Schofield, Alfredo Mcadams

select first_name, last_name
from customer 
inner join address 
on customer.customer_id = address.address_id
and address.district = 'Texas';

--Question 2 Get all payments above %6.99 with the Customer's Full Name
--Answer theres tons of names here
select first_name, last_name 
from customer 
inner join payment
on customer.customer_id = payment.customer_id 
where payment.amount > 6.99;

--Question 3 Show all customers names who have made payments over $175(use subqueries)
--Answer Peter Menard

select first_name, last_name
from customer 
where customer_id in (
select customer_id 
from payment
group by customer_id 
having max(amount) > 175
);

--Question 4 List all customers that live in Nepal (use the city table)
--Answer Kevin Schuler 
select country_id
from country 
where country = 'Nepal'


select first_name, last_name
from customer 
where address_id in (
select address_id
from address 
where city_id in (select city_id from address where city_id in (select city_id from city where country_id = 66)));


--Question 5 Which staff member had the most transactions?
-- Answer Jon Stephens
select staff_id, count(payment_id)
from payment
group by staff_id 
order by count(payment_id) desc; -- staff id 2

select first_name, last_name, staff_id
from staff
where staff_id = 2;

--Question 6 How many movies of each rating are there?
--Answer G- 178, PG- 194, R-196, NC-17- 209, PG-13- 223
select rating, count(film_id)
from film
group by rating;

--Question 7 Show all customers who have made a single payment above $6.99 (use Subqueries)
--Answer 11 customers
select customer_id, first_name, last_name
from customer 
where customer_id in (
	select customer_id from payment where amount > 6.99 group by customer_id having count(payment_id) = 1
);

--Question 8 How many free rentals did our stores give away?
--Answer 1452

select count(rental_id)
from rental 
where rental_id in (
	select rental.rental_id  from rental
	LEFT join payment 
	on payment.rental_id = rental.rental_id 
	where payment.rental_id is null);
)