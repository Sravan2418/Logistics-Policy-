
--drop
drop database if exists project;
GO
--create 
if not exists(select * from sys.databases where name='project')
create DATABASE project
GO
use project
go

-- Down subscription table 
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'payments_zip_code')
    ALTER table payments drop CONSTRAINT payments_zip_code
GO

--Down zip_code 

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    where CONSTRAINT_NAME = 'fk_Company_order_type')
    ALTER table Company drop CONSTRAINT fk_Company_order_type
Go

--Down Constraint Warehouse
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_Warehouse_driver_id')
    ALTER table Warehouse drop CONSTRAINT fk_Warehouse_driver_id
GO
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_Warehouse_manager_id')
    ALTER table Warehouse drop CONSTRAINT fk_Warehouse_manager_id
GO
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_Warehouse_small_vechicle_id')
    ALTER table Warehouse drop CONSTRAINT fk_Warehouse_small_vechicle_id
GO


--Down Constraint orders
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'orders_customer_id')
    ALTER table orders drop CONSTRAINT orders_customer_id
GO
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'orders_transaction_id')
    ALTER table orders drop CONSTRAINT orders_transaction_id
GO

--Down Constraint small_vehicles
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_small_vehicles_driver_id')
    ALTER table small_vehicles drop CONSTRAINT fk_small_vehicles_driver_id
GO

if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_vehicles_vehicle_id')
    ALTER table vehicles drop CONSTRAINT fk_vehicles_vehicle_id

GO


--Down constraint manager 
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'managers_company_id')
    ALTER table managers drop CONSTRAINT managers_company_id
    GO


--Down Constraint transportation
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_transportation_shipment_id')
    ALTER table transportation drop CONSTRAINT fk_transportation_shipment_id
GO


--Down Constraint vehicles
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_vehicles_driver_id')
    ALTER table vehicles drop CONSTRAINT fk_vehicles_driver_id
GO

--Down Constraint stock_houses

if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_stock_houses_manager_id')
    ALTER table stock_houses drop CONSTRAINT fk_stock_houses_manager_id
GO

if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_stock_houses_vehicle_id')
    ALTER table stock_houses drop CONSTRAINT fk_stock_houses_vehicle_id
GO


--Down Constraint Shipment
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_Shipment_order_id')
    ALTER table Shipment drop CONSTRAINT fk_Shipment_order_id
GO
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_Shipment_transaction_id')
    ALTER table Shipment drop CONSTRAINT fk_Shipment_transaction_id
GO

--Down Constraint Customer
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_Customer_order_id')
    ALTER table Customer drop CONSTRAINT fk_Customer_order_id
GO

GO
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_Customer_transaction_id')
    ALTER table Customer drop CONSTRAINT fk_Customer_transaction_id
GO


--Down Constraint Company
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_Company_order_id')
    ALTER table Company drop CONSTRAINT fk_Company_order_id
GO


if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'managers_company_id')
    ALTER table managers drop CONSTRAINT managers_company_id

GO

--Down Constraint store_house
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_store_house_transportation_id')
    ALTER table store_house drop CONSTRAINT fk_store_house_transportation_id
GO
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_store_house_Manager_id')
    ALTER table store_house drop CONSTRAINT fk_store_house_Manager_id
GO



--Down Constraint driver_details
if exists(select *
from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME = 'fk_driver_license_number')
    ALTER table driver_details drop CONSTRAINT fk_driver_license_number
GO

--------------------------------_Drop table -----------------
--down zip_code
drop table if EXISTS zip_code
GO

-- Down licenses
drop table if EXISTS licenses
GO

-- Down driver_details
drop table if EXISTS driver_details 
    GO

-- Down store_house
drop table if EXISTS store_house 
    GO

-- Down Company

drop table if EXISTS Company 
    GO

-- Down Customer

drop table if EXISTS Customer 
    GO

-- Down Shipment

drop table if EXISTS Shipment 
    GO

-- Down stock_houses
drop table if EXISTS stock_houses
	GO

--Down transportation
drop table if EXISTS transportation
GO


-- Down small_vehicles

drop table if EXISTS small_vehicles
	GO

-- Down orders

drop table if EXISTS orders
	GO

-- Down vehicles
drop table if EXISTS vehicles
	GO

-- Down Warehouse
drop table if EXISTS Warehouse
GO

--drop table subscription
drop table if EXISTS subscription
	GO

-- Down managers

drop table if EXISTS managers
    GO


-- Down payments

drop table if EXISTS payments 
    GO


--------------------------------Licenses--------------------------------------

create table licenses
(
    licenses_id int IDENTITY not null,
    date_of_issue DATE not null,
    date_of_expiry DATE not null,
    state_of_issue char(2) not null,
    license_number varchar(50) not null,
    date_of_birth DATE not null,
    constraint pk_Licenses_license_number primary key (license_number),
)


--------------------------------Licenses--------------------------------------

-----------------------------------Driver ---------------------

CREATE table driver_details
(
    driver_id varchar(5) not null,
    driver_firstname varchar(25) not null,
    driver_lastname varchar(25) not null,
    driver_email varchar(50) not null,
    driver_phone_no VARCHAR(10) not null,
    license_number varchar(50) not null,

    CONSTRAINT pk_driver_details_driver_id PRIMARY key (driver_id),
    CONSTRAINT uk_driver_details_driver_phone_no UNIQUE (driver_phone_no)
)

-- Adding Constarint driver_details

alter table driver_details 
add CONSTRAINT fk_driver_license_number FOREIGN key (license_number)
REFERENCES licenses(license_number)
GO



-----------------------------driver----------

--------------------------------small_vehicles--------------------------------------

-- UP Metadata
CREATE table small_vehicles
(
    small_vechicle_id int not null,
    vehicle_model varchar(20) not null,
    vehicle_reg_number VARCHAR(10) not null,
    driver_id varchar(5) not NULL,
    pickup_location VARCHAR(200) not null,
    drop_location VARCHAR(200) not null,
    constraint pk_small_vehicles_vehicle_id primary key (small_vechicle_id),
    constraint u_small_vehicles_vehicle_reg_number unique (vehicle_reg_number)
)

-- Adding Constarint
ALTER table small_vehicles
add constraint fk_small_vehicles_driver_id FOREIGN key (driver_id)
REFERENCES driver_details(driver_id)

--------------------------------small_vehicles--------------------------------------

--------------------------------vehicles--------------------------------------

CREATE table vehicles
(
    vehicle_id int not null,
    vehicle_model varchar(20) not null,
    vehicle_size VARCHAR(10) not null,
    vehicle_reg_number VARCHAR(10) not null,
    cost_transportation money not null,
    driver_id int not NULL,
    constraint pk_vehicles_vehicle_id primary key (vehicle_id),
    constraint u_vehicles_vehicle_reg_number UNIQUE (vehicle_reg_number)
)

alter table vehicles 
add CONSTRAINT fk_vehicles_vehicle_id FOREIGN key (vehicle_id)
REFERENCES small_vehicles(small_vechicle_id)
GO
--------------------------------vehicles--------------------------------------


---------zip code -------

create table zip_code 
(
    zip_code varchar(5) not null,
    city varchar (25) not null
    constraint pk_zip_code_zip_code primary key (zip_code) 
)

------zip code a
--------------------------------payments--------------------------------------

CREATE table payments
(
    order_id VARCHAR(6) not null,
    bank_name VARCHAR(50) not null,
    transaction_date DATE not null,
    transaction_type VARCHAR (50) not null,
    transaction_id VARCHAR(6) not NULL,
    zip_code varchar(5) not null,
    constraint pk_payments_payment_id primary key (transaction_id)
)
GO

ALTER table payments
add constraint payments_zip_code FOREIGN key (zip_code)
REFERENCES zip_code(zip_code)
GO


--------------------------------payments--------------------------------------

--------------------------------orders--------------------------------------

CREATE table orders
(
    order_id VARCHAR(6) not null,
    order_type VARCHAR(50) not null,
    order_date DATE not null,
    customer_id VARCHAR(6) not null,
    transaction_id VARCHAR(6) not NULL,
    total_cost float not null,
    -- need to add insert commands 
    constraint pk_orders_order_id primary key (order_id)
)
GO


ALTER table orders
add constraint orders_transaction_id FOREIGN key (transaction_id)
REFERENCES payments(transaction_id)
GO

---------------------------------Company------------------------

-- UP Metadata -- Company  
CREATE table Company
(
    company_id varchar (6) not null,
    company_name varchar(50) not null,
    company_contact BIGINT not null,
    company_address varchar(200) not null,
    company_email varchar(50) not null,
    order_id VARCHAR(6) not null,
    order_type VARCHAR(50) not null,
    CONSTRAINT pk_Company_company_id PRIMARY key (company_id),
    CONSTRAINT uk_Company_company_contact UNIQUE (company_contact),
    Constraint uk_Company_company_email unique (company_email)
)

-- Adding Constarint 
alter table Company 
add CONSTRAINT fk_Company_order_id FOREIGN key (order_id)
REFERENCES orders(order_id)
GO


--------------------------------Company --------------------------------------

--------------------------------Customer--------------------------------------

-- UP Metadata -- Customer  
CREATE table Customer
(
    customer_id varchar (6) not null,
    customer_firstname varchar(50) not null,
    customer_lastname varchar(50) not null,
    customer_contact BIGINT not null,
    customer_email varchar (50) not null,
    customer_address varchar(200) not null,
    customer_instructions varchar(200) null,
    customer_subsciption char(1) not null,
    order_id VARCHAR (6) not null,
    order_type VARCHAR(50) not null,
    transaction_id varchar(6) not null,
    CONSTRAINT pk_Customer_customer_id PRIMARY key (customer_id),
    CONSTRAINT uk_Customer_customer_contact UNIQUE (customer_contact),
    CONSTRAINT uk_Customer_customer_email UNIQUE (customer_email)
)


-- Adding Constarint 
go
alter table Customer 
add CONSTRAINT fk_Customer_order_id FOREIGN key (order_id)
REFERENCES orders(order_id)
go

alter table Customer 
add CONSTRAINT fk_Customer_transaction_id FOREIGN key (transaction_id)
REFERENCES payments(transaction_id)
go


--------------------------------Customer--------------------------------------

--------------------------------Shipment--------------------------------------
-- UP Metadata -- Shipment
CREATE table Shipment
(
    shipment_id VARCHAR (5) not null,
    shipment_type varchar(50) not null,
    shipment_date date not null,
    order_id VARCHAR (6) not null,
    transaction_id varchar(6) not null,
    CONSTRAINT pk_Shipment_shipment_id PRIMARY key (shipment_id)
)
go
-- Adding Constarint 
alter table Shipment 
add CONSTRAINT fk_Shipment_order_id FOREIGN key (order_id)
REFERENCES orders(order_id)
go
alter table Shipment 
add CONSTRAINT fk_Shipment_transaction_id FOREIGN key (transaction_id)
REFERENCES payments(transaction_id)

GO

--------------------------------Shipment--------------------------------------

--------------------------------Transportation--------------------------------------

create table transportation
(
    transportation_id varchar(6) not null,
    transportation_type varchar(25) not null,
    shipment_id VARCHAR (5) not null,
    registration_no VARCHAR(10) not null,
    company_name varchar(50) not null,
    pickup_location varchar(200) not null,
    drop_location varchar(200) not null,
    cost FLOAT not null,
    CONSTRAINT pk_Transportation_transportation_id PRIMARY key (transportation_id),
    CONSTRAINT u_Transportation_registration_no UNIQUE (registration_no)
)
GO
-- Adding Constarint
ALTER table transportation
add constraint fk_transportation_shipment_id FOREIGN key(shipment_id)
REFERENCES Shipment(shipment_id)
Go
--------------------------------Transportation--------------------------------------

--------------------------------managers--------------------------------------
-- UP Metadata
CREATE table managers
(
    manager_id varchar(5) not null,
    manager_contact BIGINT not null,
    manager_email varchar(50) not null,
    company_name varchar(50) not null,
    company_id varchar(6) not null,
    no_of_workers int not null,
    constraint pk_managers_manager_id primary key (manager_id),
    constraint u_managers_manager_contact  UNIQUE (manager_contact)

)
GO
ALTER table managers
add constraint managers_company_id FOREIGN key (company_id)
REFERENCES company(company_id)
GO


--------------------------------managers--------------------------------------

----------------------Store House -------------------

-- UP Metadata -- STORE HOUSE 
CREATE table store_house
(
    storehouse_id VARCHAR(5) not null,
    storehouse_address varchar(200) not null,
    storehouse_contact BIGINT not null,
    transportation_id varchar(6) not null,
    manager_id varchar(5) not null,
    CONSTRAINT pk_store_house_storehouse_id PRIMARY key (storehouse_id),
    CONSTRAINT uk_driver_details_storehouse_contact UNIQUE (storehouse_contact)
)
GO

-- Adding Constarint 

alter table store_house 
add CONSTRAINT fk_store_house_transportation_id FOREIGN key (transportation_id)
REFERENCES transportation(transportation_id)
GO

alter table store_house 
add CONSTRAINT fk_store_house_Manager_id FOREIGN key (manager_id)
REFERENCES managers(manager_id)
GO
-------------------------------store_house-----------------------

--------------------------------stock_houses--------------------------------------

create table stock_houses
(
    stockhouse_id int IDENTITY not null,
    stockhouse_contact BIGINT not null,
    stockhouse_address varchar(200) not null,
    manager_id varchar(5) not null,
    CONSTRAINT pk_stock_houses_stockhouse_id PRIMARY key (stockhouse_id),
    CONSTRAINT u_stock_houses_stockhouse_contact UNIQUE (stockhouse_contact),
    CONSTRAINT u_stock_houses_stockhouse_address UNIQUE (stockhouse_address)
)
GO
-- Adding Constarint



--------------------------------stock_houses--------------------------------------

--------------------------------Warehouse--------------------------------------

create table Warehouse
(
    warehouse_id varchar(5) not null,
    warehouse_address varchar(200) not null,
    warehouse_contact varchar(10) not null,
    driver_id varchar(5) not null,
    manager_id varchar(5) not null,
    small_vechicle_id int not null,
    CONSTRAINT pk_warehouse_warehouse_id PRIMARY key (warehouse_id),
    CONSTRAINT u_Warehouse_warehouse_contact unique (warehouse_contact)
)
GO
-- Adding Constarint
ALTER table Warehouse
add constraint fk_Warehouse_driver_id FOREIGN key (driver_id)
REFERENCES driver_details(driver_id)
GO
ALTER table Warehouse
add constraint fk_Warehouse_manager_id FOREIGN key (manager_id)
REFERENCES managers(manager_id)
GO
ALTER table Warehouse
add constraint fk_Warehouse_small_vechicle_id FOREIGN key (small_vechicle_id)
REFERENCES small_vehicles(small_vechicle_id)
GO
--------------------------------Warehouse--------------------------------------
GO
--------------------------------subscription--------------------------------------

CREATE table subscription
(
    subscription_id int IDENTITY not null,
    subscription_type varchar(10) not null,
    transaction_id VARCHAR(6) not null,
    subscription_issue_date date not null,
    subscription_end_date date not null,
    constraint pk_subscription_subscription_id primary key (subscription_id)
)
GO
ALTER table subscription
add constraint fk_subscription_transaction_id FOREIGN key (transaction_id) REFERENCES payments(transaction_id)
GO



--------------------------------subscription--------------------------------------


------------------Insert table------------------------
---Zip code : 

insert into zip_code 
(zip_code,city)
values ('79634','NewYork'),
('13210','Syracuse '),
('75126','Buffalo'),
('47362','Colombus'),
('42004','Chichgo'),
('63510','Bridge Port')



----------Licenses---------------
INSERT into Licenses
    (date_of_issue,date_of_expiry,state_of_issue,license_number,date_of_birth)
values('2013-07-22', '2023-07-23', 'MA', 'MAC1234098AB', '1988-05-07'),
    ('2014-05-09', '2024-05-08', 'NY', 'NYC9876056CD', '1987-10-22'),
    ('2015-09-09', '2025-09-10', 'NY', 'NYC5671234EF', '1990-05-17'),
    ('2011-02-26', '2025-02-27', 'CA', 'CAL7788123GH', '1988-08-27'),
    ('2013-07-27', '2023-07-28', 'CA', 'CAL9812288IJ', '1982-11-11')

-----------driver_details----------
INSERT into driver_details
    (driver_id,driver_firstname,driver_lastname,driver_email,driver_phone_no,license_number)
values('101', 'Virat', 'Kohli', 'Kohli123@gmail.com', '3151234098', 'MAC1234098AB'),
    ('102', 'Sam', 'Bucha', 'bucha557@gmail.com', '3159876099', 'NYC9876056CD'),
    ('103', 'Tom', 'Tucker', 'tom000@outlook.com', '3156781234', 'NYC5671234EF'),
    ('104', 'Bret', 'Lee', 'lee908@gmail.com', '3157895522', 'CAL7788123GH'),
    ('105', 'James', 'Bond', 'bond007@gmail.com', '3159078555', 'CAL9812288IJ')

---------small_vehicles-------
INSERT into small_vehicles
    (small_vechicle_id,vehicle_model,vehicle_reg_number,driver_id,pickup_location,drop_location)
Values('555', 'OL515651', 'Bond007', '104', '189 lyons Ave, Syracuse,NY, 13210', '554 Big Ave,Syracuse,NY,13210'),
    ('777', 'AC156115', 'BigDaddy8', '105', '210 Wall street, New york City,NY, 16201', '205 manhattan,newyork city,NY,16201'),
    ('980', 'ASHF3719', 'CUSE 918', '103', '567 Fart Street, Buffalo, NY, 16320', '8934 NIGRARA STREET, Buffalo,NY, 16230'),
    ('819', 'HFSK2132', 'DIED918', '102', '98 Juile Ave,Colombus, OH, 23100', '71 LUIS AVE,COLUMBUS,OH, 23100'),
    ('780', 'URKA8192', 'YOYO5708', '101', '007 Kings Street, chicago,IL,60007', '444 BEACH STREET, chicago,IL, 60007')

--------vehicles--------
INSERT into vehicles
    (vehicle_id,vehicle_model,vehicle_size,vehicle_reg_number,cost_transportation,driver_id)
values('555', 'OL515651', 'Small', 'Bond007', '20', '104'),
    ('777', 'AC156115', 'Small', 'BigDaddy8', '27', '105')

--------payments--------
INSERT into payments
    (order_id,bank_name,transaction_date,transaction_type,transaction_id, zip_code)
values
    ('ER528', 'BOA', '2022-10-22', 'Credit Card', 'R1524T', '79634'),
    ('IR3874', 'BOA', '2022-11-22', 'Debit Card', 'S7912W', '13210'),
    ('YS8712', 'Chase', '2022-11-12', 'Venmo', 'S4237U', '75126'),
    ('AO5471', 'MNT', '2022-07-21', 'Bank transaction ', 'R1074M', '47362'),
    ('EO6274', 'MNT', '2022-07-11', 'Credit Card', 'P4322C', '42004'),
    ('WK0379', 'Chase', '2022-08-01', 'Venmo', 'Q7430L', '63510')

--------orders--------
INSERT into orders
    (order_id,order_type,order_date,customer_id, transaction_id,total_cost)
values('ER528', 'clothes', '2022-10-22', '895671', 'R1524T', 50.1),
    ('IR3874', 'electronics', '2022-11-22', '781232', 'S7912W', 90.98),
    ('YS8712', 'hardware', '2022-11-12', '856731', 'S4237U', 12.0),
    ('AO5471', 'clothes', '2022-07-21', '547310', 'R1074M', 67.53),
    ('EO6274', 'lifestyle', '2022-07-11', '785619', 'P4322C', 105.45),
    ('WK0379', 'electronics', '2022-09-07', '721914', 'Q7430L', 500.12)
--------Company--------
Insert into Company
    (company_id,company_name,company_contact,company_address,company_email,order_id,order_type)
Values
    ('112362', 'Amazon', 6809984523, '23,Downtown Syracuse,NY,13210', 'Ama177@amazon.com', 'ER528', 'clothes'),
    ('118931', 'Tesla', 3155568976, '890,Manhattan,New York City, NY,16201', 'eren7881@tesla.com', 'IR3874', 'electronics'),
    ('118767', 'Varsity', 9807542121, '1,peter street, Buffalo,NY,16230', 'ytuq@varsity.com', 'YS8712', 'hardware'),
    ('118209', 'Wall Mart', 9081235678, '290,james street,Colombus,OH,23100', 'steve@wallmart.com', 'AO5471', 'clothes'),
    ('219908', 'Costco', 7129996764, '89,winter ave,chicago,IL,60007', 'submantel@costco.com', 'EO6274', 'lifestyle'),
    ('245670', 'Gap', 5309987645, '156,summer ave, bridge port, CT, 06601', 'urtan@gap.com', 'WK0379', 'electronics')
--------Customer--------
Insert into Customer
    (customer_id,customer_firstname,customer_lastname,customer_contact,customer_address,customer_instructions,customer_subsciption,customer_email,order_id,order_type,transaction_id)
Values
    ('895671', 'Tom', 'Cruse', 9085231180, '212,lexginton ave,Syracuse,NY,13210', 'Need to leave at door', 'Y', 'Allu42@gmail.com', 'ER528', 'clothes', 'R1524T'),
    ('781232', 'Tom', 'Hanks', 6808903267, '908,Brooklyn,New York City,NY,16201', ' ', 'Y', 'john212@outlook.com', 'IR3874', 'electronics', 'S7912W'),
    ('856731', 'James', 'Bond', 4087661289, '78,Quagmire Street,Buffalo,NY,16230', ' ', 'N', 'sthephan1883@gmail.com', 'YS8712', 'hardware', 'S4237U'),
    ('547310', 'Pawan', 'Kalyan', 5309667431, '1016,Braain Ave,Colombus,OH,23100', 'Please keep in the shoe', 'Y', 'james128@outlook.com', 'AO5471', 'clothes', 'R1074M'),
    ('785619', 'Virat', 'Sachin', 3158873208, '13,Joe Street,Chicago,IL,60007', 'Leave at door step', 'Y', 'simha437@gmail.com', 'EO6274', 'lifestyle', 'P4322C'),
    ('985612', 'Paul', 'Walker', 6306712277, '908,Eucild Street,Bridge Port,NY,06601', '', 'N', 'willam8532@gmail.com', 'WK0379', 'electronics', 'Q7430L')
--------Shipment--------
Insert into Shipment
    (shipment_id,shipment_type,shipment_date,order_id,transaction_id)
Values
    ('55098', 'clothes', '2022-11-24', 'ER528', 'R1524T'),
    ('55212', 'electronics', '2022-11-22', 'IR3874', 'S7912W'),
    ('51246', 'hardware', '2022-11-20', 'YS8712', 'S4237U'),
    ('59812', 'clothes', '2022-11-24', 'AO5471', 'R1074M'),
    ('51108', 'lifestyle', '2022-11-22', 'EO6274', 'P4322C'),
    ('59012', 'Toys', '2022-11-21', 'WK0379', 'Q7430L')

--------transportation--------
insert into transportation
    (transportation_id,transportation_type,shipment_id,registration_no,company_name,pickup_location,drop_location,cost)
values
    ('BYT458', 'Airways', '55098', 'QUYTUE4791', 'Amazon', '554 Big Ave,Syracuse,NY,13210', '205 Manhattan,Newyork City,NY,16201', 20.12),
    ('AIC501', 'Airways', '55212', 'QUNFGE8665', 'Tesla', '554 Big Ave,Syracuse,NY,13210', '8934 NIGRARA STREET, Buffalo,NY, 16230', 18.12),
    ('YTEA9A', 'TRAIN', '51246', 'SAJFWQ4829', 'Varsity', '8934 NIGRARA STREET, Buffalo,NY, 16230', '71 LUIS AVE,COLUMBUS,OH, 23100', 10.27),
    ('XOIA9N', 'TRAIN', '59812', 'YRKAKG7820', 'Wall Mart', '444 BEACH STREET, chicago,IL, 60007', '71 LUIS AVE,COLUMBUS,OH, 23100', 15.23),
    ('12JFJA', 'TRUCK', '51108', 'DABALS9212', 'Costco', '554 Big Ave,Syracuse,NY,13210', '444 BEACH STREET, chicago,IL, 60007', 22.29),
    ('IRJQ09', 'TRUCK', '59012', 'UATSAF3876', 'Gap', '71 LUIS AVE,COLUMBUS,OH, 23100', '554 Big Ave,Syracuse,NY,13210', 24.87)
--------managers--------
INSERT into managers
    (manager_id,manager_contact,manager_email,company_name,company_id, no_of_workers)
valueS('CV410', 1428796365, 'alli.gator@gmail.com', 'Amazon', '112362', 45),
    ('CEW41', 7513941835, 'carol.singer@gmail.com', 'Tesla', '118931', 41),
    ('VBH41', 7301987561, 'lex.luthor@gmail.com', 'Varsity', '118767', 29),
    ('XZO91', 6132697845, 'clark.kent@gmail.com', 'Wall Mart', '118209', 30),
    ('MNM14', 9869502448, 'batman.manbat@gmail.com', 'Costco', '219908', 25),
    ('POL14', 8108535444, 'justice.law@gmail.com', 'Gap', '245670', 20)
--------store_house--------
Insert into store_house
    (storehouse_id,storehouse_address,storehouse_contact,transportation_id,manager_id)
Values
    ('56781', '1500 Maxwell Ave, Syracuse,NY, 13210', 6602728266, 'BYT458', 'CV410'),
    ('49121', '3478 Warner street, New york City,NY, 16201', 5801195674, 'AIC501', 'CEW41'),
    ('67342', '2316 Joe Street, Buffalo, NY, 16320', 4308865557, 'YTEA9A', 'VBH41'),
    ('34122', '1345  Tim  Ave,Colombus, OH, 23100', 3155543121, 'XOIA9N', 'XZO91'),
    ('45921', '6521 Anderson  Street, chicago,IL,60007', 9086688543, '12JFJA', 'MNM14'),
    ('71234', '8989 clemson street, bridge port, CT, 06601', 7168859090, 'IRJQ09', 'POL14')


--------stockhouse--------
insert into stock_houses
    (stockhouse_contact,stockhouse_address,manager_id)
values
    (1764012910, '1500 Maxwell Ave, Syracuse,NY,13210', 'CV410'),
    (7301849871, '3478 Warner street, New york City,NY,16201', 'CEW41'),
    (5403120732, '2316 Joe Street, Buffalo, NY, 16320', 'CV410'),
    (2314975818, '1345 ,Tim  Ave,Colombus, OH, 23100', 'XZO91'),
    (5781500127, '6521 Anderson  Street, chicago,IL,60007', 'MNM14'),
    (9801460128, '8989 clemson street, bridge port, CT, 06601', 'CV410')



--------Warehouse--------

Insert into Warehouse
    (warehouse_id,warehouse_address,warehouse_contact,driver_id,manager_id,small_vechicle_id)
VALUES
    ('AJE21', '554 Big Ave,Syracuse,NY,13210', '7301874393', '101', 'CV410', '555'),
    ('TYLQ6', '205 manhattan,newyork city,NY,16201', '5619577402', '102', 'CEW41', '777'),
    ('DHQ78', '8934 NIGRARA STREET, Buffalo,NY, 16230', '3651876513', '103', 'VBH41', '980'),
    ('HDSJ1', '71 LUIS AVE,COLUMBUS,OH, 23100', '7571914831', '104', 'XZO91', '819'),
    ('TYJ56', '444 BEACH STREET, chicago,IL, 60007', '7418817290', '105', 'MNM14', '780')

Insert into subscription
    (subscription_type,transaction_id,subscription_issue_date,subscription_end_date)
VALUES('small', 'R1524T', '2021-12-09', '2022-11-10'),
    ('small', 'S7912W', '2021-12-14', '2022-12-15'),
    ('big', 'S4237U', '2021-12-15', '2022-12-16'),
    ('big', 'R1074M', '2021-12-31', '2023-01-01'),
    ('small', 'P4322C', '2021-12-04', '2022-11-05'),
    ('big', 'Q7430L', '2021-12-01', '2022-12-02')




-- Verfiy

select *
from licenses
GO
-- Verfiy 
select *
from driver_details
GO
-- Verfiy
select *
from small_vehicles
GO
-- Verfiy
select *
from vehicles

go
select *
from payments
go
-- Verfiy
select *
from orders
GO
-- Verfiy 
select *
from Company
go
-- Verfiy 
select *
from Customer
GO
-- Verfiy 
select *
from Shipment
GO
-- Verfiy
select *
from transportation
Go
select *
from managers
go
select *
from store_house
go
select *
from stock_houses
GO
select * from Warehouse 
GO
select * from subscription

select *
from Warehouse w
    join driver_details m on m.driver_id = w.driver_id
where m.driver_id = 101

select *
from Warehouse w
RIGHT join driver_details m on m.driver_id = w.driver_id
    where w.manager_id = 'CV410'

select *
from small_vehicles s
LEFT join driver_details d on d.driver_id = s.driver_id
where d.driver_id = 101

select *
from small_vehicles s
RIGHT join driver_details d on d.driver_id = s.driver_id
where d.driver_id = 101

select * from Licenses l RIGHT join driver_details d on d.license_number = l.license_number
where d.driver_id = '104'

select * from orders r join company c on r.order_id = c.order_id 
where total_cost >100 




-------------------------------------------


/*        customer_id varchar(6) not null,
        customer_firstname varchar(50) not null,
        customer_lastname varchar(50) not null,
        customer_contact BIGINT not null,
        customer_email varchar(50) not null,
        customer_address varchar(200) not null,
        customer_instructions varchar(200) null,
        customer_subsciption char(1) not null,
        order_id VARCHAR(6) not null,
        order_type VARCHAR(50) not null,
        transaction_id varchar(6) not null,

    use project
    drop procedure  if exists p_insert_customer
    go 
    create procedure p_insert_customer(@new_customer_id varchar (6) , @new_customer_firstname varchar(50) , @new_customer_lastname varchar(50), @new_customer_contact BIGINT , @new_customer_email varchar (50) , @new_customer_address varchar(200), @new_customer_instructions varchar(200) , @new_customer_subsciption char(1) , @new_order_id VARCHAR (6) , @new_order_type VARCHAR(50) , @new_transaction_id varchar(6)))
    As begin
    If exists( select customer_id from Customer where customer_id =  @customer_id)
    Begin
    Update Customer 
    Set customer_firstname = @new_customer_firstname WHERE customer_id =  @customer_id
    Return null 
    End 
    Else
    Begin
    Print 'No Customer Found'
    Insert into Customer(customer_id , customer_firstname , customer_lastname)
    Values (@new_customer_id, @new_customer_firstname , @new_customer_lastname, @new_customer_contact BIGINT , @new_customer_email varchar (50) , @new_customer_address varchar(200), @new_customer_instructions varchar(200) , @new_customer_subsciption char(1) , @new_order_id VARCHAR (6) , @new_order_type VARCHAR(50) , @new_transaction_id varchar(6))
    Return null 
    End 
    End 
    Select * from Customer 
    Exec p_insert_customer  @new_customer_id = 'Tanfw0' , @new_customer_firstname ='Sravan'  , @new_customer_lastname ='king' , @new_customer_contact = 7814918491, @new_customer_email = 'stja@gmail.com' , @new_customer_address ='ajfhkashgksf' , @new_customer_instructions = 'nsajf', @new_customer_subsciption='Y' , @new_order_id= 'dshfshjdvfs', @new_order_type = 'electronics', @new_transaction_id = 'dfghaj'*/