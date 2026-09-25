CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),s
    country VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT, -- Note: Contains NULLs for guest checkouts
    product_id INT,
    order_date DATE
);

-- Insert Mock Data
INSERT INTO customers VALUES 
(1, 'Alice Smith', 'USA'),
(2, 'Bob Jones', 'Canada'),
(3, 'Charlie Brown', 'UK'),
(4, 'Diana Prince', 'USA'); -- Has never placed an order

INSERT INTO products VALUES 
(101, 'Laptop', 1200.00),
(102, 'Smartphone', 800.00),
(103, 'Wireless Headphones', 150.00),
(104, 'Tablet', 400.00); -- Has never been ordered

INSERT INTO orders VALUES 
(5001, 1, 101, '2026-06-01'), -- Alice bought Laptop
(5002, 2, 102, '2026-06-02'), -- Bob bought Smartphone
(5003, 1, 103, '2026-06-03'), -- Alice bought Headphones
(5004, NULL, 101, '2026-06-04'); -- Guest checkout bought Laptop

--inner join excluds guest orders because null customer_id as no matching customer

select o.order_id,c.customer_name,p.product_name
from orders as o 
inner join customers as c
on o.customer_id = c.customer_id
inner join products as p
on o.product_id = p.product_id;
--left join keeps every customer, so customer with no orders recive null
select o.order_id,c.customer_name
from customers as c 
left join orders as o
on o.customer_id=c.customer_id;
--right join keeps every product so products with no orders recived null
select p.product_name,o.order_id
from products as p right join orders as o
on p.product_id = o.product_id;
--full outer join keeps unmatched customers and unmatched orders
select c.customer_id,o.order_id
from customers as c
full outer join orders as o
on c.customer_id=o.customer_id;
--cross join creates every possible customer-product combination 
select c.customer_name,
p.product_name
from customers c 
cross join products p;




