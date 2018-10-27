use sakila;

select first_name, last_name
from actor;

ALTER TABLE actor
ADD COLUMN `Actor Name` varchar(100) NOT NULL;

UPDATE actor
SET `Actor Name` = CONCAT(first_name, ' ', last_name);

select `Actor Name`
from actor
where last_name like '%GEN%';

select `Actor Name`,first_name,last_name
from actor
where last_name like '%LI%'
order by last_name, first_name;

select country_id, country from country
where country in ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE actor
ADD COLUMN description blob;

ALTER TABLE actor
DROP COLUMN description;

select last_name, count(actor_id)
from actor
group by last_name;

select last_name, count(actor_id)
from actor
group by last_name
having count(actor_id) > 1;

UPDATE actor
SET first_name = 'HARPO', `Actor Name` = 'HARPO WILLIAMS'
WHERE `Actor Name` = 'GROUCHO WILLIAMS';

create table address_new (
	address_id int not null auto_increment,
    address varchar(50),
    address2 varchar(50),
    district varchar(50),
    city_id int,
    postal_code varchar(5),
    phone varchar(11),
    location blob not null,
    last_update datetime,
    primary key (address_id)
);

select first_name, last_name, address
from staff s
left join address a on a.address_id = s.address_id;

select s.staff_id, first_name, last_name, sum(amount)
from staff s
left join payment p on p.staff_id = s.staff_id and month(p.payment_date) = 8 and year(p.payment_date) = 2005
group by staff_id;

select title, count(title) from film_actor fa
left join film f on f.film_id = fa.film_id
group by fa.film_id;

select title, count(title) from film_actor fa
left join film f on f.film_id = fa.film_id
group by fa.film_id
having title = 'HUNCHBACK IMPOSSIBLE';

select c.customer_id, first_name, last_name, sum(amount) from customer c
left join payment p on p.customer_id = c.customer_id
group by c.customer_id
order by last_name ASC;

select f.film_id, f.title, f.language_id from film f
where (title like 'K%' or title like 'Q%')
and f.language_id = (
	select l.language_id from language l
	where l.name = 'English'
);

select first_name, last_name from actor
where actor_id in (
	select actor_id from film_actor
	where film_id = (
		select film_id from film
		where title = 'ALONE TRIP'
	)
);

select * from customer
where address_id in (
	select address_id from address
	where city_id in (
		select city_id from city
		where country_id = (
			select country_id from country
			where country = 'Canada'
		)
	)    
);

select title from film
where film_id in (
	select film_id from film_category
	where category_id = (
		select category_id from category
		where name = 'Family'
	)
);

select f.title, count(f.title) from rental r
left join inventory i on i.inventory_id = r.inventory_id
left join film f on f.film_id = i.film_id
group by f.title
order by count(f.title) desc;


select s.store_id, sum(amount)
from payment p
left join staff s on s.staff_id = p.staff_id
group by p.staff_id;

select s.store_id, c.city, ct.country from store s
left join address a on a.address_id = s.address_id
left join city c on c.city_id = a.city_id
left join country ct on ct.country_id = c.country_id;

select c.name, sum(p.amount) from payment p
left join rental r on r.rental_id = p.rental_id
left join inventory i on i.inventory_id = r.inventory_id
left join film_category fc on fc.film_id = i.film_id
left join category c on c.category_id = fc.category_id
group by c.name
order by sum(p.amount) desc
limit 5;

create view `top_five_genres` as

select c.name, sum(p.amount) from payment p
left join rental r on r.rental_id = p.rental_id
left join inventory i on i.inventory_id = r.inventory_id
left join film_category fc on fc.film_id = i.film_id
left join category c on c.category_id = fc.category_id
group by c.name
order by sum(p.amount) desc
limit 5;

select * from top_five_genres;

drop view top_five_genres;














