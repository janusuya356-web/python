CREATE DATABASE AmazonDB;

-- Step 2: Use the database
USE AmazonDB;

-- Step 3: Create the Users table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    registered_date DATE NOT NULL,
    membership ENUM('Basic', 'Prime') DEFAULT 'Basic'
);
INSERT INTO Users (name, email, registered_date, membership) VALUES
('Alice Johnson', 'alice.j@example.com', '2024-01-15', 'Prime'),
('Bob Smith', 'bob.s@example.com', '2024-02-01', 'Basic'),
('Charlie Brown', 'charlie.b@example.com', '2024-03-10', 'Prime'),
('Daisy Ridley', 'daisy.r@example.com', '2024-04-12', 'Basic');


select * from Users;

-- Step 4: Create the Products table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(100) NOT NULL,
    stock INT NOT NULL
);

INSERT INTO Products (name, price, category, stock) VALUES
('Echo Dot', 49.99, 'Electronics', 120),
('Kindle Paperwhite', 129.99, 'Books', 50),
('Fire Stick', 39.99, 'Electronics', 80),
('Yoga Mat', 19.99, 'Fitness', 200),
('Wireless Mouse', 24.99, 'Electronics', 150);

select * from Products ;

-- Step 5: Create the Orders table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Orders (user_id, order_date, total_amount) VALUES
(1, '2024-05-01', 79.98),
(2, '2024-05-03', 129.99),
(1, '2024-05-04', 49.99),
(3, '2024-05-05', 24.99);

select * from Orders  ;


-- Step 6: Create the OrderDetails table
CREATE TABLE OrderDetails (
    order_details_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 1, 1),
(4, 5, 1);

-- 1.List all customers who have made purchases of more than $80.
SELECT 
    U.name, 
    U.email, 
    SUM(O.total_amount) AS total_spent
FROM 
    Users U
JOIN 
    Orders O ON U.user_id = O.user_id
GROUP BY 
    U.user_id
HAVING 
    total_spent > 80;
-- 2. Retrieve all orders placed in the last 30 days along with the customer name and email.
SELECT 
    O.order_id, 
    O.order_date, 
    U.name, 
    U.email, 
    O.total_amount
FROM 
    Orders O
JOIN 
    Users U ON O.user_id = U.user_id
WHERE 
    O.order_date >= CURDATE() - INTERVAL 280 DAY;
    
-- 3. Find the average product price for each category.
SELECT 
    category, 
    AVG(price) AS avg_price
FROM 
    Products
GROUP BY 
    category;
    
-- 4. List all customers who have purchased a product from the category Electronics.
SELECT DISTINCT 
    U.name, 
    U.email
FROM 
    Users U
JOIN 
    Orders O ON U.user_id = O.user_id
JOIN 
    OrderDetails OD ON O.order_id = OD.order_id
JOIN 
    Products P ON OD.product_id = P.product_id
WHERE 
    P.category = 'Electronics';

-- 5.Find the total number of products sold and the total revenue generated for each product.
SELECT 
    P.name AS product_name, 
    SUM(OD.quantity) AS total_quantity_sold, 
    SUM(OD.quantity * P.price) AS total_revenue
FROM 
    OrderDetails OD
JOIN 
    Products P ON OD.product_id = P.product_id
GROUP BY 
    P.product_id;

-- 6. Update the price of all products in the Books category, increasing it by 10%.

SET SQL_SAFE_UPDATES = 0;

UPDATE 
    Products
SET 
    price = price * 1.10
WHERE 
    category = 'Books';
-- 7. Remove all orders that were placed before 2020.
DELETE FROM 
    Orders
WHERE 
    order_date < '2020-01-01';

select* FROM orders;
-- 8. Fetch the order details, including customer name, product name, and quantity, for orders placed on 2024-11-01.

SELECT 
    O.order_id, 
    U.name AS customer_name, 
    P.name AS product_name, 
    OD.quantity
FROM 
    Orders O
JOIN 
    Users U ON O.user_id = U.user_id
JOIN 
    OrderDetails OD ON O.order_id = OD.order_id
JOIN 
    Products P ON OD.product_id = P.product_id
WHERE 
    O.order_date = '2024-5-01';
-- 9. Fetch all customers and the total number of orders they have placed.

SELECT 
    U.name AS customer_name, 
    U.email, 
    COUNT(O.order_id) AS total_orders
FROM 
    Users U
LEFT JOIN 
    Orders O ON U.user_id = O.user_id
GROUP BY 
    U.user_id;

-- 10.  List all customers who purchased more than 3 units of any product, including the product name and total quantity purchased.
SELECT 
    U.name AS customer_name, 
    U.email, 
    P.name AS product_name, 
    SUM(OD.quantity) AS total_quantity
FROM 
    Users U
JOIN 
    Orders O ON U.user_id = O.user_id
JOIN 
    OrderDetails OD ON O.order_id = OD.order_id
JOIN 
    Products P ON OD.product_id = P.product_id
GROUP BY 
    U.user_id, P.product_id
HAVING 
    total_quantity > 1;
    
-- 11. Find the total revenue generated by each category along with the category name.
SELECT 
    P.category, 
    SUM(OD.quantity * P.price) AS total_revenue
FROM 
    Products P
JOIN 
    OrderDetails OD ON P.product_id = OD.product_id
GROUP BY 
    P.category;


























