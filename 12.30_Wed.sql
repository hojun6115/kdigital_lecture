use w3schools;

alter table customers2 modify customerID varchar(255);

update customers2 set customerID = concat("customer", CustomerID);

select * from customers2;

-- JOIN 실습 --
-- 실습1
select city, suppliername, productname, price from suppliers
inner join products on suppliers.supplierid = products.supplierid
where city = 'Tokyo';
-- as p, as s를 통해 products, suppliers 를 간편하게 사용할 수 있음



-- 실습2 : inner join 활용
select categoryname, productname from categories
inner join products on categories.categoryid = products.categoryid
where categoryname = 'seafood'; 

-- 실습2 : join 없이
-- select categories.categoryname, products.productname from categories, products
-- where 공통된 것 = 해주고, categoryname = seafood;


-- 실습3
select country, categoryname, count(productname), avg(price) from products
left join suppliers on suppliers.supplierid = products.supplierid
left join categories on products.categoryid = categories.categoryid
group by country, categoryname
order by count(*) desc, avg(price) desc;
-- inner join들로 연결할 수도 있음(서로 연관된 애들을 다 가져오는 것)
-- count(*) 해도 됨


-- 실습4
select orders.orderid, customername, lastname, shippername, sum(quantity) from order_details
left join orders on order_details.orderid = orders.orderid
left join customers on orders.customerid = customers.customerid
left join employees on orders.employeeid = employees.employeeid
left join shippers on orders.shipperid = shippers.shipperid
group by orders.orderid, customername;
-- orderid가 orderdetails에도 있고 orders에도 있어서. orders에 있는 걸 활용해야함!


-- 실습5
select suppliername, sum(quantity) from order_details
left join products on order_details.productid = products.productid
left join suppliers on products.supplierid = suppliers.supplierid
group by suppliername
order by sum(quantity) desc
limit 3;

-- 실습5 모범답안
select s.suppliername, sum(od.quantity) as qsum
from order_details od
inner join products p
on od.productid = p.productid
inner join suppliers s
on p.supplierid = s.supplierid
group by s.suppliername
order by qsum desc
limit 3;


-- 실습6
select categoryname, city, sum(quantity) from order_details
left join orders on order_details.orderid = orders.orderid
left join customers on orders.customerid = customers.customerid
left join products on order_details.productid = products.productid
left join categories on products.categoryid = categories.categoryid
group by categoryname, city
order by sum(quantity) desc;

-- 실습6 모범답안
select c.categoryname, cm.city, sum(od.quantity) as qsum
from order_details od
inner join products p
on od.productid = p.productid
inner join categories c
on c.categoryid = p.categoryid
inner join orders o
on od.orderid = o.orderid
inner join customers cm
on o.customerid = cm.customerid
group by c.categoryname, cm.city
order by qsum desc;


-- 실습7
select country, productname, sum(quantity), sum(quantity * price) from order_details
left join orders on order_details.orderid = orders.orderid
left join customers on orders.customerid = customers.customerid
left join products on order_details.productid = products.productid
where country = 'USA'
group by productname
order by sum(quantity) desc;

-- 실습7 모범답안
select c.country, p.productname, sum(od.quantity) as qsum, sum(od.quantity * p.price)
from order_details od
inner join orders o
on od.orderid = o.orderid
inner join customers c
on o.customerid = c.customerid
inner join products p
on od.productid = p.productid
where c.country = 'USA'
group by p.productname
order by qsum desc;


-- order_details에는 orderId, productID, quantity 존재
-- orders에는 orderId, customerID, employeeID, shipperID
-- customers에는 customerID, customername, city 존재
-- categories에는 categoryID, categoryname 존재
-- products에는 productID, productname, supplierID, categoryID 존재

