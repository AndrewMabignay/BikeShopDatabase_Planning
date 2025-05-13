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
CREATE TABLE orders(
  ID INT PRIMARY KEY AUTO_INCREMENT,
  UserID INT NOT NULL,
  TotalAmount DOUBLE NOT NULL,
  Status ENUM('Pending', 'Confirmed', 'Shipped', 'Cancelled') DEFAULT 'Pending',
  CreatedAt DATE DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (UserID) REFERENCES users(ID)
);

CREATE TABLE order_items(
  ID int [primary key, increment]
  OrderID int [not null, ref: > orders.ID]
  BikeID int [not null, ref: < bikes.ID]
  Quantity int [not null]
  Price double [not null]
);


CREATE TABLE carts(
  ID INT PRIMARY KEY AUTO_INCREMENT,  -- Unique ID for the cart entry
  UserID INT NOT NULL,  -- Reference to the user who added the item to the cart
  BikeID INT NOT NULL,  -- Reference to the bike being added to the cart
  Quantity INT NOT NULL,  -- Quantity of the bike being added
  FOREIGN KEY (UserID) REFERENCES users(ID) ON DELETE CASCADE,  -- Relation to users
  FOREIGN KEY (BikeID) REFERENCES bikes(ID) ON DELETE CASCADE  -- Relation to bikes
);

// CONTACTS
Table contacts {
  ID int [primary key, increment]
  Name varchar(40) [not null]
  Email varchar(100) [not null]
  Message text [not null]
}



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
