CREATE DATABASE ElectronicStoreDB;
GO

USE ElectronicStoreDB;
GO

CREATE TABLE Categories
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
);

CREATE TABLE Suppliers
(
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierName NVARCHAR(150),
    Address NVARCHAR(200),
    Phone VARCHAR(20),
    Email VARCHAR(100)
);

CREATE TABLE Products
(
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(200) NOT NULL,
    CategoryID INT,
    SupplierID INT,
    ImportPrice DECIMAL(18,2),
    SalePrice DECIMAL(18,2),
    Quantity INT,
    Warranty INT,
    ImagePath NVARCHAR(255),
    Description NVARCHAR(500),

    CONSTRAINT FK_Product_Category
        FOREIGN KEY(CategoryID)
        REFERENCES Categories(CategoryID),

    CONSTRAINT FK_Product_Supplier
        FOREIGN KEY(SupplierID)
        REFERENCES Suppliers(SupplierID)
);

CREATE TABLE Customers
(
    CustomerID INT IDENTITY PRIMARY KEY,
    CustomerName NVARCHAR(150),
    Gender NVARCHAR(10),
    Phone VARCHAR(20),
    Address NVARCHAR(200),
    Email VARCHAR(100)
);

CREATE TABLE Employees
(
    EmployeeID INT IDENTITY PRIMARY KEY,
    FullName NVARCHAR(150),
    Gender NVARCHAR(10),
    Phone VARCHAR(20),
    Address NVARCHAR(200),
    Position NVARCHAR(100),
    HireDate DATE
);

CREATE TABLE Users
(
    UserID INT IDENTITY PRIMARY KEY,
    EmployeeID INT UNIQUE,
    Username VARCHAR(50) UNIQUE,
    Password VARCHAR(100),
    Role NVARCHAR(30),
    CONSTRAINT FK_User_Employee
        FOREIGN KEY(EmployeeID)
        REFERENCES Employees(EmployeeID)
);

CREATE TABLE Invoices
(
    InvoiceID INT IDENTITY PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    InvoiceDate DATETIME DEFAULT GETDATE(),
    Total DECIMAL(18,2),
    CONSTRAINT FK_Invoice_Customer
        FOREIGN KEY(CustomerID)
        REFERENCES Customers(CustomerID),
    CONSTRAINT FK_Invoice_Employee
        FOREIGN KEY(EmployeeID)
        REFERENCES Employees(EmployeeID)
);

CREATE TABLE InvoiceDetails
(
    DetailID INT IDENTITY PRIMARY KEY,
    InvoiceID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(18,2),
    Amount DECIMAL(18,2),
    CONSTRAINT FK_Detail_Invoice
        FOREIGN KEY(InvoiceID)
        REFERENCES Invoices(InvoiceID),
    CONSTRAINT FK_Detail_Product
        FOREIGN KEY(ProductID)
        REFERENCES Products(ProductID)
);

CREATE TABLE RepairOrders
(
    RepairID INT IDENTITY PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    DeviceName NVARCHAR(200),
    Brand NVARCHAR(100),
    Problem NVARCHAR(500),
    ReceiveDate DATE,
    ReturnDate DATE,
    RepairCost DECIMAL(18,2),
    Status NVARCHAR(50),

    CONSTRAINT FK_Repair_Customer
        FOREIGN KEY(CustomerID)
        REFERENCES Customers(CustomerID),

    CONSTRAINT FK_Repair_Employee
        FOREIGN KEY(EmployeeID)
        REFERENCES Employees(EmployeeID)
);

CREATE TABLE RepairDetails
(
    RepairDetailID INT IDENTITY PRIMARY KEY,
    RepairID INT,
    Description NVARCHAR(500),
    SparePart NVARCHAR(200),
    Cost DECIMAL(18,2),

    CONSTRAINT FK_RepairDetail_Order
        FOREIGN KEY(RepairID)
        REFERENCES RepairOrders(RepairID)
);

INSERT INTO Categories(CategoryName)
VALUES
(N'Điện thoại'),
(N'Laptop'),
(N'Máy tính bảng'),
(N'Đồng hồ thông minh'),
(N'Tai nghe');

INSERT INTO Suppliers(SupplierName, Address, Phone, Email)
VALUES
(N'Apple Việt Nam', N'Hồ Chí Minh', '0901111111', 'apple@gmail.com'),
(N'Samsung Việt Nam', N'Hà Nội', '0902222222', 'samsung@gmail.com'),
(N'Dell Việt Nam', N'Hồ Chí Minh', '0903333333', 'dell@gmail.com'),
(N'ASUS Việt Nam', N'Hà Nội', '0904444444', 'asus@gmail.com'),
(N'Lenovo Việt Nam', N'Đà Nẵng', '0905555555', 'lenovo@gmail.com');

INSERT INTO Employees
(FullName, Gender, Phone, Address, Position, HireDate)
VALUES
(N'Nguyễn Văn An',N'Nam','0911111111',N'Cao Lãnh',N'Quản lý','2025-01-01'),
(N'Trần Minh Khang',N'Nam','0922222222',N'Sa Đéc',N'Bán hàng','2025-02-10'),
(N'Lê Quốc Huy',N'Nam','0933333333',N'Cao Lãnh',N'Kỹ thuật','2025-03-15');

INSERT INTO Customers
(CustomerName, Gender, Phone, Address, Email)
VALUES
(N'Nguyễn Văn Bình',N'Nam','0901111222',N'Cao Lãnh','binh@gmail.com'),
(N'Trần Thị Lan',N'Nữ','0902222333',N'Sa Đéc','lan@gmail.com'),
(N'Lê Minh Đức',N'Nam','0903333444',N'Lấp Vò','duc@gmail.com'),
(N'Phạm Ngọc Mai',N'Nữ','0904444555',N'Lai Vung','mai@gmail.com'),
(N'Võ Thanh Sơn',N'Nam','0905555666',N'Thanh Bình','son@gmail.com');

INSERT INTO Users
(EmployeeID, Username, Password, Role)
VALUES
(1,'admin','123','Admin'),
(2,'staff01','123','Staff'),
(3,'tech01','123','Staff');

INSERT INTO Products
(ProductName, CategoryID, SupplierID, ImportPrice, SalePrice, Quantity, Warranty, ImagePath, Description)
VALUES
(N'iPhone 15',1,1,18000000,21000000,20,12,'iphone15.jpg',N'Điện thoại Apple'),
(N'Samsung Galaxy S25',1,2,17000000,20000000,15,12,'s25.jpg',N'Điện thoại Samsung'),
(N'Dell Inspiron 15',2,3,14000000,17000000,10,24,'dell.jpg',N'Laptop Dell'),
(N'ASUS TUF Gaming',2,4,20000000,24000000,8,24,'tuf.jpg',N'Laptop Gaming'),
(N'AirPods Pro 2',5,1,4500000,5500000,30,12,'airpods.jpg',N'Tai nghe Apple');

INSERT INTO Invoices
(CustomerID, EmployeeID, InvoiceDate, Total)
VALUES
(1,2,GETDATE(),21000000),
(2,2,GETDATE(),24000000),
(3,2,GETDATE(),5500000);

INSERT INTO InvoiceDetails
(InvoiceID, ProductID, Quantity, UnitPrice, Amount)
VALUES
(1,1,1,21000000,21000000),
(2,4,1,24000000,24000000),
(3,5,1,5500000,5500000);

INSERT INTO RepairOrders
(CustomerID, EmployeeID, DeviceName, Brand, Problem, ReceiveDate, ReturnDate, RepairCost, Status)
VALUES
(1,3,N'iPhone 14',N'Apple',N'Không lên nguồn',GETDATE(),NULL,800000,N'Đang sửa'),
(2,3,N'Dell Latitude',N'Dell',N'Vỡ màn hình',GETDATE(),NULL,2500000,N'Đang kiểm tra'),
(3,3,N'Samsung A54',N'Samsung',N'Thay pin',GETDATE(),GETDATE(),500000,N'Hoàn thành');

INSERT INTO RepairDetails
(RepairID, Description, SparePart, Cost)
VALUES
(1,N'Thay IC nguồn',N'IC nguồn',800000),
(2,N'Thay màn hình',N'Màn hình Dell',2500000),
(3,N'Thay pin',N'Pin Samsung',500000);

SELECT * FROM Categories;
SELECT * FROM Suppliers;
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Employees;
SELECT * FROM Users;
SELECT * FROM Invoices;
SELECT * FROM InvoiceDetails;
SELECT * FROM RepairOrders;
SELECT * FROM RepairDetails;
