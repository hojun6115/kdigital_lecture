use w3schools;

desc customers;

select count(country) from customers where country='France';
#실습 1번
select productname, price from products where productname like 'C%' and price > 20 order by price desc;
#실습 2번
select categoryid, sum(price), max(price), min(price) from products group by categoryid;
