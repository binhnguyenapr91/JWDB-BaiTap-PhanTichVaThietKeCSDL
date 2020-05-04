DROP DATABASE carretail;

CREATE DATABASE carretail;

USE carretail;

CREATE TABLE offices (
    officeNumber INT(10) PRIMARY KEY,
    phone VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50),
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    postalCode VARCHAR(15) NOT NULL
);

CREATE TABLE productline (
    productLineId VARCHAR(50) PRIMARY KEY,
    textDescription TEXT,
    image VARCHAR(100)
);

CREATE TABLE products (
    productCode INT(10) PRIMARY KEY,
    productLineId VARCHAR(50) NOT NULL,
    productName VARCHAR(50) NOT NULL,
    productScale VARCHAR(10) NOT NULL,
    productVendor VARCHAR(50) NOT NULL,
    productDescription TEXT,
    quantityInStock INT(10) NOT NULL,
    buyPrice FLOAT NOT NULL,
    msrp FLOAT NOT NULL,
    FOREIGN KEY (productLineId)
        REFERENCES productline (productLineId)
);

CREATE TABLE employees (
    employeeNumber INT(10) PRIMARY KEY,
    officeNumber INT(10) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    jobTitle VARCHAR(50) NOT NULL,
    reportTo INT(10) NOT NULL,
    FOREIGN KEY (reportTo)
        REFERENCES employees (employeeNumber),
    FOREIGN KEY (officeNumber)
        REFERENCES offices (officeNumber)
);

DROP TABLE employees;
CREATE TABLE customers (
    customerCode INT(10) PRIMARY KEY,
    employeeNumber INT(10),
    customerName VARCHAR(50) NOT NULL,
    contactLastname VARCHAR(50) NOT NULL,
    contactFirstname VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50),
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    postalCode VARCHAR(15) NOT NULL,
    creditLimit FLOAT,
    FOREIGN KEY (employeeNumber)
        REFERENCES employees (employeeNumber)
);

CREATE TABLE payments (
    checkNumber INT(10) PRIMARY KEY,
    customerCode INT(10),
    paymentDate DATE NOT NULL,
    amount FLOAT NOT NULL,
    FOREIGN KEY (customerCode)
        REFERENCES customers (customerCode)
);

CREATE TABLE orders (
    orderNumber INT(10) PRIMARY KEY,
    customerCode INT(10),
    orderDate DATE NOT NULL,
    requireDate DATE NOT NULL,
    shippedDate DATE,
    status VARCHAR(10) NOT NULL,
    comment TEXT,
    quantityOrder INT(10) NOT NULL,
    priceEach FLOAT NOT NULL,
    FOREIGN KEY (customerCode)
        REFERENCES customers (customerCode)
);

CREATE TABLE orderdetails (
    orderNumber INT(10),
    productCode INT(10),
    FOREIGN KEY (orderNumber)
        REFERENCES orders (orderNumber),
    FOREIGN KEY (productCode)
        REFERENCES products (productCode),
    CONSTRAINT pk PRIMARY KEY (orderNumber , productCode)
);