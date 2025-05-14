-- Assignment: Database Design and Normalization

-- Question 1: Achieving 1NF (First Normal Form) 🛠️
-- Task: Transform the table into 1NF by ensuring each row represents a single product for an order.

-- Given the original table:
-- OrderID | CustomerName | Products
-- 101     | John Doe     | Laptop, Mouse
-- 102     | Jane Smith   | Tablet, Keyboard, Mouse
-- 103     | Emily Clark  | Phone

-- The current Products column contains multiple values, which violates 1NF.

-- SQL query to transform the table into 1NF:
-- Create a new table where each row represents a single product for an order.

CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- Insert the data in a way that each product has its own row
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- This ensures the table is now in 1NF.

-- Question 2: Achieving 2NF (Second Normal Form) 🧩
-- Task: Remove partial dependencies and transform the table into 2NF.

-- Given the original table:
-- OrderID | CustomerName | Product  | Quantity
-- 101     | John Doe     | Laptop   | 2
-- 101     | John Doe     | Mouse    | 1
-- 102     | Jane Smith   | Tablet   | 3
-- 102     | Jane Smith   | Keyboard | 1
-- 102     | Jane Smith   | Mouse    | 2
-- 103     | Emily Clark  | Phone    | 1

-- The CustomerName column depends on OrderID, which is a partial dependency that violates 2NF.

-- SQL query to remove partial dependencies and transform the table into 2NF:
-- We need to create two new tables: Orders and OrderProducts.
-- Orders table will contain OrderID and CustomerName.
-- OrderProducts table will contain OrderID, Product, and Quantity.

-- Create the Orders table (to eliminate partial dependency on CustomerName)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Insert data into Orders table
INSERT INTO Orders (OrderID, CustomerName)
VALUES
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- Create the OrderProducts table (to store the product details)
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product), -- Composite primary key
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into OrderProducts table
INSERT INTO OrderProducts (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);

-- The database is now in 2NF as the non-key attributes (CustomerName) depend on the whole primary key.
