CREATE DATABASE bikeshop;

USE bikeshop;

---------------------- ADMIN PORTION ----------------------
-- USERS
CREATE TABLE users(
  ID INT PRIMARY KEY AUTO_INCREMENT,
  First_Name VARCHAR(100) NOT NULL,
  Last_Name VARCHAR(100) NOT NULL,
  Email VARCHAR(200) NOT NULL,
  Password VARCHAR(100) NOT NULL,
  ConfirmPassword VARCHAR(100) NOT NULL, -- OPTIONAL
  Role ENUM('Client', 'Admin', 'Staff') DEFAULT 'Client',
  CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- BIKES
CREATE TABLE bikes(
  ID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100) NOT NULL,
  Description TEXT NOT NULL,
  Price DOUBLE NOT NULL,
  Stock INT NOT NULL,
  CategoriesID INT NOT NULL,
  SubCategoriesID INT NOT NULL,
  BrandID INT NOT NULL,
  Image VARCHAR(200) NOT NULL,
  FOREIGN KEY (CategoriesID) REFERENCES categories(ID), 
  FOREIGN KEY (SubCategoriesID) REFERENCES subcategories(ID), 
  FOREIGN KEY (BrandID) REFERENCES brands(ID) 
);

-- CATEGORIES
CREATE TABLE categories(
  ID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100) NOT NULL
);

-- SUBCATEGORIES
CREATE TABLE subcategories(
  ID INT PRIMARY KEY AUTO_INCREMENT,
  CategoryID INT NOT NULL,
  Name VARCHAR(100) NOT NULL,
  FOREIGN KEY (CategoryID) REFERENCES categories(ID) 
);

-- BRANDS
CREATE TABLE brands(
  ID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100) NOT NULL
);

---------------------- CLIENT PAYMENT PORTION ----------------------  
-- ORDERS
CREATE TABLE orders(
  ID INT PRIMARY KEY AUTO_INCREMENT,
  UserID INT NOT NULL,
  TotalAmount DOUBLE NOT NULL,
  Status ENUM('Pending', 'Confirmed', 'Shipped', 'Cancelled') DEFAULT 'Pending',
  CreatedAt DATE DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (UserID) REFERENCES users(ID)
);

-- ORDER ITEMS
CREATE TABLE order_items(
  ID INT PRIMARY KEY AUTO_INCREMENT,
  OrderID INT NOT NULL,
  BikeID INT NOT NULL,
  Quantity INT NOT NULL,
  Price DOUBLE NOT NULL,
  FOREIGN KEY (OrderID) REFERENCES orders(ID),
  FOREIGN KEY (BikeID) REFERENCES bikes(ID)
);

-- CARTS
CREATE TABLE carts(
  ID INT PRIMARY KEY AUTO_INCREMENT,  
  UserID INT NOT NULL, 
  BikeID INT NOT NULL,  
  Quantity INT NOT NULL,
  FOREIGN KEY (UserID) REFERENCES users(ID),
  FOREIGN KEY (BikeID) REFERENCES bikes(ID)
);

-- CONTACTS
CREATE TABLE contacts(
  ID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100) NOT NULL,
  Email VARCHAR(100) NOT NULL,
  Message TEXT NOT NULL
);


-- MAINTENANCE --
-- PAYMENTS TABLE
CREATE TABLE payments (
  ID INT PRIMARY KEY AUTO_INCREMENT,
  OrderID INT NOT NULL,  -- Reference to the order
  PaymentMethod ENUM('CreditCard', 'DebitCard', 'Paypal', 'BankTransfer') NOT NULL,  -- Payment method
  Amount DOUBLE NOT NULL,  -- The total amount paid
  PaymentStatus ENUM('Pending', 'Success', 'Failed', 'Cancelled') DEFAULT 'Pending',  -- Payment status
  PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Date of payment
  TransactionID VARCHAR(255),  -- Unique transaction ID from payment gateway
  PaymentDetails TEXT,  -- Additional details, like transaction metadata (optional)
  FOREIGN KEY (OrderID) REFERENCES orders(ID) ON DELETE CASCADE
);
