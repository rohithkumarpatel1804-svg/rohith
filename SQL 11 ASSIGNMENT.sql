CREATE TABLE lab_products (
    product_sku VARCHAR(50) PRIMARY KEY,
    product_serial_code VARCHAR(100) NOT NULL,
    wholesale_cost DECIMAL(10,2)
);

INSERT INTO lab_products
    (product_sku, product_serial_code, wholesale_cost)
VALUES
    ('SKU-100', 'SER-999-AAA', 45.00),
    ('SKU-200', 'SER-888-BBB', 120.50);

select*from lab_products;

CREATE INDEX idx_products_serial
ON lab_products(product_serial_code);

SELECT *
FROM lab_products
WHERE product_serial_code = 'SER-888-BBB';


CREATE TABLE perf_products (
    product_id INT PRIMARY KEY,
    product_serial_code VARCHAR(30) NOT NULL,
    wholesale_cost DECIMAL(10,2)
);

INSERT INTO perf_products (product_id, product_serial_code, wholesale_cost)
SELECT
    g,
    'SER-' || LPAD(g::text, 7, '0'),
    ROUND((random() * 500)::numeric, 2)
FROM generate_series(1, 500000) AS g;

-- before indexing
select*from perf_products
where product_id=1;

-- after indexing
create index idx_product_serial_code
on perf_products(product_serial_code);
EXPLAIN
select * from perf_products
where product_id=3;


