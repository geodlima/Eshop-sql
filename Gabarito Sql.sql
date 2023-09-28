-- Criação do banco de dados
CREATE DATABASE eshop_connect_a;

-- Ativar o uso do Banco de Dados
USE eshop_connect_a;

-- Tabela users
CREATE TABLE users(
    pk_userid        INT NOT NULL,
    name            VARCHAR(50) NOT NULL,
    phoneNumber        CHAR(12) NOT NULL,
    
    PRIMARY KEY (pk_userid    )

);

-- Tabela Buyer 
CREATE TABLE buyer(
    pk_userid        INT NOT NULL,
    
    PRIMARY KEY (pk_userid),
    FOREIGN KEY (pk_userid) REFERENCES users(pk_userid)
);

-- Tabela Seller
CREATE TABLE seller(
    pk_userid        INT NOT NULL,
    
    PRIMARY KEY (pk_userid),
    FOREIGN KEY (pk_userid) REFERENCES users(pk_userid)
);

CREATE TABLE BankCard(
	pk_CardNumber Varchar(25) NOT NULL,
    ExpiryDate date,
    Bnak varchar(20),
    
    PRIMARY KEY(pk_CardNumber)
);

Create Table CreditCard(
	pk_CardNumber varchar(25) not null,
    fk_UserId int not null,
    Organization varchar(20) not null,
    
	primary key (pk_CardNumber),
    foreign key (pk_CardNumber) references BankCard(pk_CardNumber),
    foreign key (fk_UserId) references users(pk_UserId)
);

Create Table DebitCard(
	pk_CardNumber varchar(25) not null,
    fk_UserId int not null,
    organization varchar(20) not null,
    
    primary key (pk_CardNumber),
    foreign key (pk_CardNumber) references BankCard(pk_CardNumber),
    foreign key (fk_UserId) references users(pk_UserId)
);


Create Table Store(
	pk_sid INT NOT NULL,
	Name varchar(20),
    City Varchar(20),
    Province varchar(20),
    StreetAddr varchar(20),
    CustomerGrade int,
    StartDate date,
    
    primary key (pk_Sid)
);

Create Table Brand(
	pk_BrandName Varchar(20) not null,
    
    primary key (pk_BrandName)

);

Create Table Product(
	pk_Pid int not null,
    fk_Sid int not null,
    fk_Brand varchar(50) not null,
    Name varchar(100),
    Type varchar(50),
    ModelNumber varchar(50),
    Color Varchar(50),
    Amount int,
    Price int,
    primary key(pk_Pid),
    Foreign key(fk_Sid) references Store(pk_Sid),
    foreign key (fk_Brand) References Brand(pk_BrandName)

);

Create Table OrderItem(
	pk_ItemId int not null,
    fk_Pid int not null,
    Price decimal(10,2),
    CreationTime date,
    primary key(pk_ItemId),
    foreign key(fk_Pid) references Product(pk_Pid)

);


Create Table Orders(
	pk_OrderNumber int not null,
    PaymentState Varchar(12),
    CreationTime date,
    TotalAmount Decimal(10,2),
    primary key (pk_OrderNumber)


);


Create Table Comments(
	CreationTime time not null,
    fk_UserId int not null,
    fk_Pid int not null,
    Grade Float,
    Content varchar(100),
    primary key(CreationTime,fk_UserId,fk_Pid), -- Chave Composta
    foreign key(fk_UserId) references users(pk_UserId),
    foreign key(fk_Pid) references Product(pk_Pid)
);


Create Table ServicePoint(
	pk_SPid int not null,
    StreetAddr Varchar(40),
    City varchar(30),
    Province varchar(20),
    StartTime time,
    EndTime time,
    primary key(pk_SPid)
);

Create Table Save_To_Shopping_Cart(
	pk_UserId int not null,
    pk_Pid int not null,
    AddTime time,
    Quantity int,
    primary key(pk_UserId, pk_Pid),
	foreign key(pk_UserId) references Buyer(pk_UserId),
    foreign key(pk_Pid) references Product(pk_Pid)

);

Create Table Contain(
	pk_OrderNumber int not null,
    fk_ItemId int not null,
    Quantity int,
    primary key(pk_OrderNumber, fk_ItemId),
    Foreign key (pk_OrderNumber) references Orders(pk_OrderNumber),
    foreign key(fk_ItemId) references OrderItem(pk_ItemId)

);

Create Table Payment(
	fk_OrderNumber int not null,
    fk_CardNumber varchar(25) not null,
    PayTime datetime,
    primary key(fk_OrderNumber, fk_CardNumber),
    foreign key(fk_OrderNumber) references Orders(pk_OrderNumber),
    foreign key(fk_CardNumber) references BankCard(pk_CardNumber)

);


Create Table Address(
	pk_AddrId int not null,
    fk_UserId int not null,
    Name Varchar(50),
    ConatctPhoneNumber Varchar(20),
    Province varchar(100),
    City varchar(100),
    StreetAddr varchar(100),
    PostCode varchar(12),
    primary key(pk_AddrId),
    foreign key(fk_UserId) References users(pk_UserId)

);

Create Table Deliver_To(
	fk_AddrId int not null,
    fk_OrderNumber int not null,
    TimeDelivered date,
    primary key(fk_AddrId, fk_OrderNumber),
    foreign key(fk_AddrId) references Address(pk_AddrId),
    foreign key(fk_OrderNumber) references Orders(pk_OrderNumber)

);

Create Table Manage(
	fk_UserId int not null,
    fk_Sid int not null,
    SetUpTime date,
    primary key(fk_UserId,fk_Sid),
    foreign key(fk_UserId) references Seller(pk_UserId),
    foreign key(fk_Sid) references Store(pk_Sid)

);

Create Table After_Sales_Service_At(
	fk_BrandName varchar(20) not null,
    fk_SPid int not null,
    primary key(fk_BrandName, fk_SPid),
    foreign key(fk_BrandName) references Brand (PK_BrandName),
    foreign key(fk_SPid) references ServicePoint(pk_SPid)

);