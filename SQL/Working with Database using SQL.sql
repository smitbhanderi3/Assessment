create database customer_details;
use customer_details;
drop database customer_details;
create table city
	(city_id integer,
	city_name varchar(100),
	latitude float,
	longitude float,
	country_id int(100),
    primary key(city_id));

create table customers     
	(customer_id integer,
	customer_name varchar(100),
	city_id integer,
	customer_address varchar(100),
	next_date_call date,
    ts_inserted datetime,
    primary key(customer_id),
	foreign key (city_id) references city (city_id));
    
    
    

   
create table country
	(country_id integer,
    country_name varchar(100),
    country_name_eng varchar(100),
    country_code varchar(100),
    primary key(country_id));
    
    
# alter table country add 
# foreign key (country_id) references city (city_id);

insert into city value
	(1,"Berlin",52.520008,13.404954,1),
    (2,"Belgrade",44.787197,20.457273,2),
    (3,"Zagreb",45.815399,15.966568,3),
    (4,"New York",40.730610,-73.935242,4),
    (5,"Los Angeles",34.052235,-118.243683,4),
    (6,"Warsaw",52.237049,21.017532,5);
    
insert into customers value
	(1,"Jewelry Store",4,"Long Street 120","2020-01-21","2020-01-09 14:01:20"),
    (2,"Bakery",1,"Kurfustendamm 25","2020-02-21","2020-01-09 17:52:15"),
    (3,"Cafe",1,"Tauentzienstrabe 44","2020-01-21","2020-01-10 08:02:49"),
    (4,"Restaurant",3,"Ulica lips 15","2020-01-21","2020-01-10 09:20:21");
    
insert into country value
	(1,"Deutschland","Germany","DEU"),
    (2,"Srbija","Serbia","SRB"),
    (3,"Hrvatska","Croatia","HRV"),
    (4,"United States of America","United States of America","USA"),
    (5,"Polska","poland","POL"),
    (6,"Espana","Spain","ESP"),
    (7,"Rossiya","Russia","RUS");

select * from city;
select * from customers;
select * from country;

# Task : 1 (join multiple tables using left join)
# List all Countries and customers related to these countries.
# For each country displaying its name in English, the name of the city customer is located in as
# well as the name of the customer.
# Return even countries without related cities and customers.

SELECT
    co.country_name_eng AS CountryNameEnglish,
    IFNULL(ci.city_name, 'No City') AS CityName,
    IFNULL(cu.customer_name, 'No Customer') AS CustomerName
FROM country co
LEFT JOIN city ci ON co.country_id = ci.country_id
LEFT JOIN customers cu ON ci.city_id = cu.city_id;


# Task : 2 (join multiple tables using both left and inner join)
# Return the list of all countries that have pairs(exclude countries which are not referenced by any
# city). For such pairs return all customers.
# Return even pairs of not having a single custome


SELECT
    co.country_name_eng AS CountryNameEnglish,
    ci.city_name AS CityName,
    cu.customer_name AS CustomerName
FROM country co
LEFT JOIN city ci ON co.country_id = ci.country_id
LEFT JOIN customers cu ON ci.city_id = cu.city_id
WHERE ci.city_id IS NOT NULL
UNION
SELECT
    co.country_name_eng AS CountryNameEnglish,
    'No City' AS CityName,
    'No Customer' AS CustomerName
FROM country co
WHERE co.country_id NOT IN (SELECT DISTINCT country_id FROM city);

