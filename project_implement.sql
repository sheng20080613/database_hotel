create database GROUP_22_PROJ02
Use GROUP_22_PROJ02
use WANG_QIUCHENG_TEST
drop GROUP_22_PROJ
--create tables 
create schema Employee
create table Employee.Department
 ( 
   DepartmentID int identity not null primary key,
   DepartmentName varchar(40) not null
 );
 create table Employee.Employee
 (
   EmployeeID varchar(40) not null primary key,
   EmplFName varchar(40) not null,
   EmplLName varchar(40) not null,
   DepartmentID int not null references Employee.Department,
   Salary money not null,
   EphoneNo varchar(60) not null,
   EEmail varchar(60) not null,
   HireDate date not null,
   Title varchar(40) null,
   Job varchar(40) not null
 );
 drop table Employee.Employee


 CREATE SCHEMA Room
  create table Room.RoomType
 (
   RoomTypeID int identity not null primary key,
   RoomType varchar(40) not null,
   AmountEachType int
 );

create table Room.RoomRate
 (
   RateID int identity not null Primary key,
   RoomTypeID int references Room.RoomType(RoomTypeID),
   Rate money not null,
   RateStartDate date not null,
   RateEndDate date not null
 );

create table Room.Room
(
RoomNO int not null primary key,
RoomTypeID int references Room.RoomType(RoomTypeID),
RoomLocation varchar(40),
CleanStatus varchar(40),
MaintenanceStatus varchar(40)
)

 drop table Room.Room

 CREATE SCHEMA Task
 create table Task.RoomClean
 (
  EmployeeID varchar(40) not null 
    references Employee.Employee(EmployeeID),
  RoomNO int not null 
    references Room.Room(RoomNO),
 );
 
 create table Task.MaintenanceCase
 (
  CaseID int not null primary key,
  CaseType varchar(20),
  CaseStartDate date,
  CaseEndDate date,
  CaseStatus varchar(20),
  CaseDescription varchar(100),
  EmployeeID varchar(40) references Employee.Employee(EmployeeID),
  RoomNO int references Room.Room(RoomNO)
 );
 drop table Task.MaintenanceCase
 

 create schema Customer 
 create table Customer.Membership
 (
  MemberID int identity not null primary key,
  VIPLevel int not null,
  Discount float 
 );
 
 create table Customer.Customer
 (
  CustomerID varchar(40) not null primary key,
  FirstName Varchar(40) not null,
  MiddleName varchar(40),
  LastName varchar(40) not null,
  DateOfBirth date,
  StreetNumber varchar(60),
  City varchar(40),
  ZipCode varchar(20),
  PhoneNO varchar(40) not null,
  Email varchar(40) not null,
  CreditCardNubmber varchar(60),
  MemberID int null references Customer.Membership(MemberID)
 );	
 drop table Customer.Customer

create schema Reservation
create table Reservation.Reservation
 (
  ReservationID varchar(40) not null primary key,
  RoomTypeID int NOT NULL references  Room.RoomType(RoomTypeID),
  CustomerID VARCHAR(40) NOT NULL REFERENCES Customer.Customer(CustomerID),
  ReservationStatus varchar(20) not null,
  ReservationDate date not null,
  RCheckInDate date not null,
  RCheckOutDate date not null,
  NumberOfGuest int);
 drop table Reservation.Reservation

 create schema CheckIn
 create table CheckIn.CheckInOut 
 (
  CheckInID varchar(40) not null primary key,
  ReservationID varchar(40)not null references Reservation.Reservation(ReservationID),
  RoomNo int references Room.Room(RoomNO),
  ACheckInDate date not null,
  ACheckOutDate date not null,
  Duration varchar
 );

create table CheckIn.FeedBack
(
 FeedBackID varchar(40) not null primary key,
 CheckInID varchar(40) references CheckIn.CheckInOut(CheckInID),
 Score float(10),
 FeedBackContent varchar(60)
);

CREATE TABLE CheckIn.Bill
(
 BillID int identity not null primary key,
 CheckInID varchar(40) not null references CheckIn.CheckInOut(CheckInID),
 BillStatus varchar(40),
 PaymentType varchar(40)
)
drop table CheckIn.Bill;

create schema Restaurant
create table Restaurant.TableInfo
(
 TableID varchar(40) not null primary key,
 NumberOfGuest int,
 TableDescription varchar(40),
 IsAvailable varchar(20)
);

create table Restaurant.Restaurant 
(
 RestaurantID int identity not null primary key,
 RestaurantName varchar(40) not null,
 RestaurantDescription varchar(40),
 RestaurantLocation varchar(40),
 RestaurantOpenTime varchar(40) 
);

create table Restaurant.RestaurantTable
(
 RestaurantID int not null references Restaurant.Restaurant(RestaurantID),
 TableID varchar(40) not null references Restaurant.TableInfo(TableID)
);

create table Restaurant.Dish
(
 DishID varchar(40) not null primary key,
 RestaurantID int references Restaurant.Restaurant(RestaurantID),
 DishDescription varchar(100),
 DishPrice money not null
 );

create schema Store
create table Store.Store
(
 StoreID varchar(40) not null primary key,
 StoreName varchar(40) not null,
 StoreLocation varchar(40),
 StoreDescription varchar(40),
 StoreOpenTime varchar(40)
);

create table Store.Supplier
(
 SupplierID varchar(40) not null primary key,
 Company varchar(40) not null,
 Address varchar(60),
 PhoneNO varchar(40),
 Email varchar(40) 
);

create table Store.Product
(
 ProductID varchar(40) not null primary key,
 ProductPrice money not null,
 SupplierID varchar(40) References Store.Supplier(SupplierID),
 ProductCost money
);

Create table Store.StoreProduct
(
 ProductID varchar(40) not null references Store.Product(ProductID),
 StoreID varchar(40) not null references Store.Store(StoreID)
);

create schema CheckInOrder
create table  CheckInOrder.RestaurantOrder
(
 ROrderID varchar(40) not null primary key,
 TableID varchar(40) not null references Restaurant.TableInfo(TableID),
 CheckInID varchar(40) not null references CheckIn.CheckInOut(CheckInID),
 SpecialRequest varchar(40),
 OrderTime datetime,
);

create table CheckInOrder.OrderDish 
( 
 ROrderID varchar(40) not null references CheckInOrder.RestaurantOrder(ROrderID),
 DishID varchar(40) not null references Restaurant.Dish(DishID),
 DAmount int not null
);

create table CheckInOrder.StoreOrder
(
 SOrderID varchar(40) not null primary key,
 StoreID varchar(40) not null references Store.Store(StoreID),
 CheckInID varchar(40) not null references CheckIn.CheckInOut(CheckInID),
 OrderDate datetime
);

create table CheckInOrder.StoreOrderProduct
(
 SOrderID VARCHAR(40) NOT NULL references CheckInOrder.StoreOrder(SorderID),
 ProductID varchar(40) not null references Store.Product(ProductID),
 ProductAmount int not null
);

Create table CheckInOrder.LaundryService
(
 LServiceID VARCHAR(40) not null primary key,
 ReceiveTime datetime not null,
 ReturnDate datetime,
 LaundryPrice money,
 CheckInID varchar(40) references CheckIn.CheckInOut(CheckInID)
);

drop table CheckInOrder.LaundryService

--Add Constraint with function, canclled reservation cannot checkIn
 create function RStatusCheck(@ReservationID varchar(40))
 returns smallint
 as begin 
     declare @count smallint=0;
	 select @count=count(@ReservationID)
	 from Reservation.Reservation
	 where ReservationID=@ReservationID
	 and ReservationStatus='Canclled';
 return @count;
 End;
 Alter table CheckIn.CheckInOut add constraint BanCancleReservation check (dbo.RStatusCheck(ReservationID)=0);

--add trigger insert constraints on Time sequency
Create trigger TR_checkinouttime
on CheckIn.CheckInOut
After insert AS
Begin
 Declare @intime date
 Declare @outtime date
 Select @intime=ACheckInDate from inserted
 Select @outtime=ACheckOutDate from inserted
 IF @outtime<@intime
  Begin
   Rollback
  END
END

--import data 
INSERT into Employee.Department
VALUES
('Front office'),
('Dinning Service'),
('Housekeeping'),
('Maintenance'),
('HR'),
('Sales'),
('Accounting'),
('Laundry'),
('Store'),
('Kitchen');


INSERT into Employee.Employee
VALUES
('1001', 'Anne', 'Smith', '001', '3500', '4158789030', 'anne.smith@feelinghotel.com', '11-10-2017', 'Manager', 'Front desk Manager'),
('1002', 'Sam', 'Happy', '001', '4500', '8150789023', 'sam.happy@feelinghotel.com', '01-27-2016', 'Manager', 'Front office Manager'),
('1003', 'William', 'Walker', '001', '3000', '7799301257', 'william.walker@feelinghotel.com', '03-01-2018', '', 'Front desk Agent'),
('1004', 'Xiaoying', 'Sun', '002', '3800', '9083469870', 'xiaoying.sun@feelinghotel.com', '05-15-2015', 'Manager', 'Resaurant Manager'),
('1005', 'Sakura', 'Matsumoto', '002', '3500', '8086735432', 'sakura.matsumoto@feelinghotel.com', '11-01-2015', 'Manager', 'Resaurant Manager'),
('1006', 'Nicolas', 'Smith', '002', '3200', '4531428759', 'nicolas.smith@feelinghotel.com', '01-10-2017', 'Supervisor', 'Resaurant Supervisor'),
('1007', 'Alan', 'Lee', '002', '2800', '4156704321', 'alan.lee@feelinghotel.com', '01-01-2019', '', 'Resaurant Server'),
('1008', 'Manny', 'Willson', '002', '2800', '8682538711', 'manny.willson@feelinghotel.com', '01-03-2019', '', 'Resaurant Server'),
('1009', 'Bella', 'Ludwig', '003', '3800', '6501438787', 'bella.ludwig@feelinghotel.com', '10-20-2015', 'Manager', 'Housekeeping Manager'),
('1010', 'Dean', 'Strider', '003', '3500', '8091660980', 'dean.strider@feelinghotel.com', '06-30-2018', 'Supervisor', 'Housekeeping Supervisor'),
('1011', 'Juan', 'Gomez', '003', '3000', '4156067930', 'juan.gomez@feelinghotel.com', '01-15-2018', '', 'Houseman'),
('1012', 'Lucian', 'Norway', '003', '3000', '8681265093', 'lucian.norway@feelinghotel.com', '01-15-2018', '', 'Housekeeper'),
('1013', 'Norman', 'Roland', '003', '3000', '8689362143', 'norman.roland@feelinghotel.com', '03-15-2019', '', 'Housekeeper'),
('1014', 'Yixin', 'Wang', '003', '3000', '8019243738', 'yixin.wang@feelinghotel.com', '01-10-2019', '', 'Housekeeper'),
('1015', 'Joseph', 'Gomez', '004', '3000', '6505871990', 'joseph.gomez@feelinghotel.com', '01-15-2017', '', 'Maintenance'),
('1016', 'Matt', 'Lancent', '004', '2800', '4156067830', 'matt.lancent@feelinghotel.com', '10-10-2018', '', 'Maintenance'),
('1017', 'Qingfeng', 'Wu', '004', '3500', '8783261209', 'qingfeng.wu@feelinghotel.com', '03-15-2019', 'Manager', 'Maintenance'),
('1018', 'Erica', 'Sunday', '005', '3200', '5578390377', 'erica.sunday@feelinghotel.com', '01-15-2019', '', 'HR Agent'),
('1019', 'Milsa', 'Kurtz', '006', '6000', '2314758900', 'milsa.kurtz@feelinghotel.com', '05-10-2017', 'Manager', 'Sales'),
('1020', 'Farneez', 'Alade', '007', '4500', '3445761901', 'farneez.alade@feelinghotel.com', '04-01-2019', '', 'Bookeeper'),
('1021', 'Dan', 'Chan', '008', '2800', '8779001266', 'dan.chan@feelinghotel.com', '01-01-2019', '', 'Laundry'),
('1022', 'Sam', 'Wayer', '009', '3500', '7780063142', 'sam.wayer@feelinghotel.com', '01-01-2019', '', 'Store Assistant'),
('1023', 'BeYing', 'Chan', '010', '4000', '7902034578', 'beying.chan@feelinghotel.com', '10-15-2018', '', 'Chef');

SELECT * FROM Employee.Employee

INSERT INTO Room.RoomType
VALUES
('STKT', '9'),
('STQQ', '9'),
('STDD', '8'),
('ONBT', '8'),
('ONBQ', '8'),
('TOBR', '8');

 INSERT INTO Room.RoomRate
VALUES
--STKT
(1,'85','01-01-2018', '08-31-2018'),
(1,'80','09-01-2018', '12-31-2018'),
(1,'83','01-01-2019', '08-31-2019'),
(1,'82','09-01-2019', '12-31-2019'),
--STQQ
(2,'90', '01-01-2018', '08-31-2018'),
(2,'85','09-01-2018', '12-31-2018'),
(2,'95', '01-01-2019', '08-31-2019'),
(2,'88','09-01-2019', '12-31-2019'),
--STDD
(3,'70','01-01-2018', '08-31-2018'),
(3,'60', '09-01-2018', '12-31-2018'),
(3,'75', '01-01-2019', '08-31-2019'),
(3,'65', '09-01-2019', '12-31-2019'),
--ONBT
(4,'130','01-01-2018', '08-31-2018'),
(4,'115','09-01-2018', '12-31-2018'),
(4,'140','01-01-2019', '08-31-2019'),
(4,'135','09-01-2019', '12-31-2019'),
--ONBQ
(5,'135', '01-01-2018', '08-31-2018'),
(5,'120','09-01-2018', '12-31-2018'),
(5,'145', '01-01-2019', '08-31-2019'),
(5,'140','09-01-2019', '12-31-2019'),
--TOBR
(6,'220','01-01-2018', '08-31-2018'),
(6,'200','09-01-2018', '12-31-2018'),
(6,'235','01-01-2019', '08-31-2019'),
(6,'210','09-01-2019', '12-31-2019');

 --Import from csv
insert into Room.Room
 select*from WANG_QIUCHENG_TEST.dbo.roomcsv

Insert into Task.RoomClean
 select *from WANG_QIUCHENG_TEST.dbo.roomcleancsv

Insert into Task.MaintenanceCase
 select*from WANG_QIUCHENG_TEST.dbo.maintainance_csv

 INSERT Customer.Membership
	VALUES (1,0.95),
	(2,0.85),
	(2,0.85),
	(1,0.95),
	(1,0.95),
	(1,0.95),
	(2,0.85),
	(1,0.95),
	(1,0.95),
	(1,0.95),
	(2,0.85),
	(2,0.85),
	(2,0.85),
	(1,0.95),
	(1,0.95),
	(1,0.95),
	(1,0.95),
	(1,0.95);

 INSERT Customer.Customer
	VALUES ('c1','Ashley','','Ivy','1982-03-22','834 Summer St.','Columbus','02343','7236324424','Ashley@gmail.com','345323546223',null),
	('c2','Joyce','','Kelly','1993-04-30','43 Vinal St.','Des Moines','28423','6934823942','Joyce@hotmail.com','908358742075',1),
	('c3','Easter','','Ryan','1946-05-26','57 Avon St.','Cincinati','14345','8653857639','Easter@gmail.com','09277436856',7),
	('c4','Tommy','','Aidan','1973-02-23','245 Berkeley St.','Montgomery','03256','9763947592','Tommy@gmail.com','9727450948562',8),
	('c5','Alex','','Nick','1963-12-13','754 Laurel St.','Tallahassee','02384','3764927464','Alex@gmail.com','259084958976596',17),
	('c6','Diego','','Eve','1987-08-24','5 Preston St.','Albany','29437','1937492947','Diego@gmail.com','543786554767',6),
	('c7','Tina','','Randy','1935-07-17','265 Alblion St.','Boise','14353','5932758493','Tina@gmail.com','74765465779765',4),
	('c8','Fred','','Roger','1984-03-18','4765 Alpine St.','Cleveland','25432','9748264957','Fred@gmail.com','65454897656866',null),
	('c9','Alice','','Aurora','1957-02-01','564 Warwick St.','Des Moines','08342','8623847194','Alice@gmail.com','5638986765645',2),
	('c10','Glen','','Anthony','1974-08-08','56 Highland St.','Boston','13573','6892463864','Glen@gmail.com','36890985683657',9),
	('c11','Ben','','Edwin','1993-03-14','34 Willowr St.','Denver','18493','9673846285','Ben@gmail.com','1355677976978756',12),
	('c12','Elvis','','Alva','1947-05-19','375 Beech St.','Chicago','09782','6395839204','Elvis@gmail.com','7872415745705',11),
	('c13','Jackson','','Buster','1994-12-25','4562 Cherry St.','Dallas','18437','4938954829','Jackson@gmail.com','5637863045827',null),
	('c14','Kevin','','Carl','1979-03-19','579 Regent St.','Hawaii','27442','9872839487','Kevin@gmail.com','42908597860725',14),
	('c15','Bryson','','Zora','1949-08-17','67 Irving St.','Boston','08837','9754858526','Bryson@gmail.com','97457825790',4),
	('c16','Bahar','','Amelia','1983-06-07','354 Howard St.','Helena','02463','9847394950','Bahar@gmail.com','9374648592364',5),
	('c17','Zona','','Buzz','1985-09-10','78 Mason St.','Detroit','14527','6384927394','Zona@gmail.com','43567887457',null),
	('c18','Van','','Isla','1975-06-26','367 Talbot St.','Jackson','18346','3869472856','Van@gmail.com','4536578098743',10),
	('c19','Isabella','','Loren','1969-06-18','28 Billingham St.','Jefferson City','9475628643','6749234923','Isabella@gmail.com','90478526735',15),
	('c20','Colin','','Bella','1991-11-07','29 Raulina St.','Indianapolis','05923','6937927496','Colin@gmail.com','3286895845033',18);

INSERT Reservation.Reservation
	VALUES 
	('r1', 2, 'c3','In Process','2018-06-23','2018-07-12', '2018-07-20',2),
	('r2', 5, 'c8','In Process','2018-12-31','2019-01-18', '2019-01-21',4),
	('r3', 3, 'c12','Cancelled','2019-03-30','2019-04-06', '2019-04-16',1),
	('r4', 5, 'c9','Cancelled','2018-06-28','2019-07-04', '2019-07-14',4),
	('r5', 6, 'c16','In Process','2019-03-22','2019-03-24', '2019-03-29',3),
	('r6', 1, 'c6','Check In','2018-10-13','2018-11-07', '2018-11-11',2),
	('r7', 2, 'c1','Cancelled','2019-01-08','2019-02-12', '2019-02-23',2),
	('r8', 4, 'c10','In Process','2019-02-28','2019-03-24', '2019-03-29',1),
	('r9', 4, 'c4','In Process','2019-08-30','2019-09-17', '2019-12-19',2),
	('r10', 6, 'c13','Check In','2018-10-12','2018-10-19', '2018-10-24',3),
	('r11', 1, 'c17','Check In','2018-02-21','2018-02-24', '2018-02-28',2),
	('r12', 6, 'c20','Cancelled','2018-01-14','2018-07-26', '2018-08-03',3),
	('r13', 5, 'c5','Cancelled','2019-05-06','2019-05-15', '2019-05-19',2),
	('r14', 3, 'c14','Cancelled','2018-09-18','2019-01-04', '2019-02-12',2),
	('r15', 5, 'c19','In Process','2019-01-17','2019-01-19', '2019-01-20',2),
	('r16', 3, 'c7','In Process','2019-05-22','2019-05-23', '2019-06-02',1),
	('r17', 5, 'c2','In Process','2019-05-02','2019-05-09', '2019-05-23',2),
	('r18', 3, 'c15','Cancelled','2019-05-13','2019-06-25', '2019-07-04',1),
	('r19', 2, 'c11','In Process','2018-12-11','2018-12-13', '2019-01-12',2),
	('r20', 5, 'c18','Check In','2018-10-03','2018-10-12', '2018-10-24',4),
	('r21', 3, 'c8','In Process','2019-03-14','2019-03-28', '2019-04-05',3),
	('r22', 5, 'c15','In Process','2019-02-18','2019-02-19', '2019-02-27',2),
	('r23', 3, 'c3','In Process','2019-07-14','2019-08-16', '2019-08-21',1),
	('r24', 2, 'c6','Check In','2018-11-11','2018-11-13', '2018-11-19',4),
	('r25', 5, 'c20','Check In','2018-10-07','2018-12-01', '2018-12-18',2);

INSERT CheckIn.CheckInOut(CheckInID,ReservationID,RoomNO,ACheckInDatE,
  ACheckOutDate)
	VALUES 
	('ch1', 'r11', 207, '2018-02-24', '2018-02-28'),
	('ch2', 'r22', 409, '2019-02-18','2019-02-19'),
	('ch3', 'r25', 607, '2018-12-01', '2018-12-18'),
	('ch4', 'r1', 202, '2018-07-12', '2018-07-20'),
	('ch5', 'r8', 204, '2019-03-24', '2019-03-29'),
	('ch6', 'r21', 209, '2019-03-28', '2019-04-05'),
	('ch7', 'r9', 210, '2019-09-17', '2019-12-19'),
	('ch8', 'r19', 208, '2018-12-13', '2019-01-12'),
	('ch9', 'r15', 307, '2019-01-19', '2019-01-20'),
	('ch10', 'r20', 403, '2018-10-12', '2018-10-24'),
	('ch11', 'r2', 205, '2019-01-18', '2019-01-21'),
	('ch12', 'r23', 503, '2019-08-16', '2019-08-21'),
	('ch13', 'r10', 302, '2018-10-19', '2018-10-24'),
	('ch14', 'r17', 301, '2019-05-09', '2019-05-23'),
	('ch15', 'r5', 206, '2019-03-24', '2019-03-29'),
	('ch16', 'r16', 203, '2019-05-23', '2019-06-02'),
	('ch17', 'r24', 508, '2018-11-13', '2018-11-19'),
	('ch18', 'r6', 201, '2018-11-07', '2018-11-11');

INSERT CheckIn.FeedBack
	VALUES ('f1', 'ch6',9.3,'Food is good.'),
	('f2', 'ch8',9.9,'People are nice.'),
	('f3', 'ch13',9.6,'Service is good.'),
	('f4', 'ch1',9.0,'Good.'),
	('f5', 'ch18',7.4,'So-so.'),
	('f6', 'ch2',7.2,'Room is too small.'),
	('f7', 'ch9',5.0,'Too noisy.'),
	('f8', 'ch17',9.4,'Nice experience.'),
	('f9', 'ch11',10.0,'Highly recommand.'),
	('f10', 'ch3',9.6,'Nice trip.'),
	('f11', 'ch14',9.5,'Great.'),
	('f12', 'ch5',9.2,'Good.'),
	('f13', 'ch16',9.6,'Like the room here.'),
	('f14', 'ch12',9.7,'Nice decoration.'),
	('f15', 'ch4',9.4,'Good service.');

INSERT CheckIn.Bill(CheckInID,BillStatus,PaymentType)
	VALUES
	('ch1','Paid', 'Card'),
	('ch2','UnPaid', 'Company'),
	('ch3','UnPaid', 'Card'),
	('ch4','Paid', 'Card'),
	('ch5','UnPaid', 'Check'),
	('ch6','Paid', 'Company'),
	('ch7','Paid', 'Card'),
	('ch8','Paid', 'Check'),
	('ch9','UnPaid', 'Card'),
	('ch10','UnPaid', 'Cash'),
	('ch11','UnPaid', 'Card'),
	('ch12','Paid', 'Company'),
	('ch13','UnPaid', 'Company'),
	('ch14','UnPaid', 'Card'),
	('ch15','Paid', 'Card'),
	('ch16', 'UnPaid', 'Check'),
	('ch17', 'UnPaid', 'Cash'),
	('ch18', 'UnPaid', 'Cash');

Insert Restaurant.TableInfo VALUES
('C001','2','Indoor','NO'),
('C002','2','Outdoor','YES'),
('C003','4','Indoor','NO'),
('C004','4','Outdoor','YES'),
('C005','8','Indoor','YES'),
('W001','2','Indoor','YES'),
('W002','2','Outdoor','NO'),
('W003','4','Indoor','YES'),
('W004','4','Outdoor','NO'),
('W005','8','Indoor','YES'),
('B001','2','Indoor','YES'),
('B002','2','Outdoor','NO'),
('B003','4','Indoor','YES'),
('B004','4','Outdoor','NO'),
('B005','8','Indoor','YES');

--insert with stored procedure
drop procedure RestaurantInsert
CREATE PROCEDURE RestaurantInsert
       @name                   varchar(40) = NULL, 
       @description            VARCHAR(40)  = NULL, 
       @location               VARCHAR(40)  = NULL,
       @opentime               varchar(40) = NULL
AS 
BEGIN 
     
     INSERT INTO Restaurant.Restaurant
          (                    
            RestaurantName,
            RestaurantDescription,
            RestaurantLocation,
            RestaurantOpenTime
          ) 
     VALUES 
          ( 
            @name,
            @description,
            @location,
            @opentime
          ) 
          
END 

exec RestaurantInsert 
@name = 'Ming seafood',
@description = 'Breakfast',
@location = 'First Floor East',
@opentime = '8am-9pm';

exec RestaurantInsert 
@name = 'Jay Pizza',
@description = 'Pizza and dessert',
@location = 'Second Floor',
@opentime = '11am-8pm';

exec RestaurantInsert 
@name = 'Happy taste',
@description = 'Chinese cuisine',
@location = 'First Floor West',
@opentime = '8am-10pm';

Insert Restaurant.RestaurantTable VALUES
('3','C001'),
('3','C002'),
('3','C003'),
('3','C004'),
('3','C005'),
('2','W001'),
('2','W002'),
('2','W003'),
('2','W004'),
('2','W005'),
('1','B001'),
('1','B002'),
('1','B003'),
('1','B004'),
('1','B005');

 Insert Restaurant.Dish VALUES
('C1','3','The​ ​Hoisin​','8.50'),
('C2','3','Salted Crispy Chicken​','10.95'),
('C3','3','General Gau Chicken​','10.95'),
('C4','3','Sesame Crispy Chicken','10.95'),
('C5','3','Kung Pao Chicken w. Peanuts','9.95'),
('C6','3','Hunan Chicken','9.95'),
('C7','3','Chicken w. Broccoli​','9.95'),
('C8','3','Beef w. Broccoli​','11.95'),
('C9','3','Beef w. Chinese Vegetables​','11.95'),
('C10','3','Hunan Spiced Beef','11.95'),
('C11','3','Shredded Beef w. Yellow Leek','13.95'),
('C12','3','Shredded Beef w. Green Peppers​','11.95'),
('C13','3','Shredded Beef w. Hot Pepper','11.95'),
('C14','3','Shredded Beef w. Scallions','11.95'),
('C15','3','Shredded Beef w. Chinese Celery','11.95'),
('C16','3','Bitter Melon w. Beef in Black Bean Sauce','11.95'),
('C17','3','Chung-King Pork​','9.95'),
('C18','3','Pork w. Broccoli','9.95'),
('C19','3','Pork w. Scallions','9.95'),
('C20','3','Pork w. Garlic Sauce','9.95'),
('C21','3','Braised Pork Balls in Brown Sauce​','11.95'),
('C22','3','Bamboo Shoots w. Shredded Pork​','9.95'),
('C23','3','Minced Pork w. Scallions​','9.95'),
('C24','3','Salt Pepper Pork Chop​','10.95'),
('W1','2','Vegetarian Pizza','13.99'),
('W2','2','Margherita Pizza','13.99'),
('W3','2','Chicken Alfredo Pizza','13.99'),
('W4','2','The Hawaiian Pizza','12.99'),
('W5','2','The Greek Pizza​','13.99'),
('W6','2','Meat Lovers Pizza','13.99'),
('W7','2','Chicken Bacon Ranch Pizza​','13.99'),
('W8','2','BBQ Chicken Pizza','13.99'),
('B1','1','Steamed Spare Ribs','5.99'),
('B2','1','Lotus Leaf Rice with Chicken','5.99'),
('B3','1','Shrimp Dumplings','5.99'),
('B4','1','Pork Shumai​','5.99'),
('B5','1','Rice Noodle Roll with Beef','5.99'),
('B6','1','Salted Egg Custard Buns','5.99'),
('B7','1','Egg Tart','3.99'),
('B8','1','Taro Cake','3.99');

Insert Store.Store VALUES
('S001','Store1','First Floor','Beverages','9am-6pm'),
('S002','Store2','Second Floor','Snack','9am-6pm'),
('S003','Store3','Third Floor','Grocery','9am-6pm');

Insert Store.Supplier VALUES
('1001','North Company','193 State Hwy 13, Wisconsin Dells, WI 53965','6082547500','igvjhoobringe9@b4top.tk'),
('1002','South Company','11 Old Fort Rd, Fort Deposit, AL 36032','3342273423','psoomar-starq@projectku.me'),
('1003','West Company','11300 Houston Ave, Hanford, CA 93230','5595821728','tdjihad@projectoxygen.com'),
('1004','East Company','567 Southbridge st#6, Auburn, MA 01501','5088329688','cabdelwahab.mida@beed.ml');

Insert Store.Product(ProductID,ProductPrice,SupplierID,ProductCost)
 values
('001801','15.99','1001','5.99'),
('001802','10.99','1002','3.99'),
('001803','13.99','1003','6.99'),
('001804','12.99','1004','5.99'),
('001805','11.99','1001','3.99'),
('001806','19.99','1001','7.99'),
('001807','15.99','1004','5.99'),
('001808','12.99','1002','6.99'),
('001809','9.99','1003','3.99'),
('001810','11.99','1004','6.99'),
('001811','7.99','1004','1.99'),
('001812','8.99','1001','2.99'),
('001813','9.99','1002','5.99'),
('001814','12.99','1003','5.99'),
('001815','13.99','1003','5.99'),
('001816','19.99','1004','8.99'),
('001817','15.99','1001','5.99'),
('001818','11.99','1004','4.99'),
('001819','19.99','1002','6.99'),
('001820','23.99','1002','8.99');

Insert Store.StoreProduct VALUES
('001801','S001'),
('001802','S001'),
('001803','S001'),
('001804','S001'),
('001805','S001'),
('001806','S001'),
('001807','S002'),
('001808','S002'),
('001809','S002'),
('001810','S002'),
('001811','S002'),
('001812','S002'),
('001813','S002'),
('001814','S002'),
('001815','S003'),
('001816','S003'),
('001817','S003'),
('001818','S003'),
('001819','S003'),
('001820','S003');

Insert into CheckInOrder.RestaurantOrder(ROrderID,TableID,
 CheckInID, SpecialRequest,OrderTime) VALUES
('R001','C001','ch1','','2018-02-25 12:20:00'),
('R002','W001','ch17','No spicy','2018-11-12 12:00:00'),
('R003','W002','ch15','No sugar','2019-03-26 11:35:00'),
('R004','B005','ch15','','2019-03-26 09:00:00'),
('R005','B001','ch14','','2019-05-10 09:00:00'),
('R006','B004','ch14','','2019-05-11 08:30:00'),
('R007','C003','ch14','','2019-05-12 12:05:00'),
('R008','C005','ch12','No spicy','2019-08-17 13:00:00'),
('R009','C004','ch12','No spicy','2019-08-18 12:05:00'),
('R010','W005','ch7','','2019-09-20 13:05:00'),
('R011','W004','ch7','','2019-10-02 12:08:00');

INSERT CheckInOrder.OrderDish VALUES
('R001','C1','1'),
('R001','C6','1'),
('R001','C12','1'),
('R002','W1','1'),
('R003','W2','2'),
('R004','B1','2'),
('R004','B2','1'),
('R004','B3','1'),
('R004','B4','2'),
('R005','B1','2'),
('R005','B3','2'),
('R005','B4','1'),
('R005','B5','1'),
('R005','B6','1'),
('R006','B1','1'),
('R006','B3','1'),
('R006','B4','1'),
('R006','B7','2'),
('R007','C1','1'),
('R007','C12','1'),
('R007','C13','1'),
('R007','C20','1'),
('R008','C2','1'),
('R008','C16','1'),
('R009','C11','1'),
('R009','C5','1'),
('R009','C21','1'),
('R010','W5','1'),
('R010','W6','1'),
('R011','W8','1');

INSERT CheckInOrder.StoreOrder(SOrderID,StoreID,
 CheckInID,OrderDate) VALUES
('SOR001','S001','ch1','2018-02-25'),
('SOR002','S002','ch5','2019-03-26'),
('SOR003','S001','ch5','2019-03-28'),
('SOR004','S003','ch7','2019-09-18'),
('SOR005','S001','ch7','2018-09-18'),
('SOR006','S001','ch2','2019-02-18'),
('SOR007','S002','ch3','2018-12-02'),
('SOR008','S001','ch4','2018-07-13'),
('SOR009','S002','ch4','2018-07-14'),
('SOR010','S002','ch9','2019-01-20'),
('SOR011','S003','ch10','2018-10-13'),
('SOR012','S001','ch10','2018-10-15'),
('SOR013','S003','ch12','2019-08-18'),
('SOR014','S003','ch13','2018-10-20'),
('SOR015','S001','ch18','2018-11-10');

Insert CheckInOrder.StoreOrderProduct VALUES
('SOR001','001801','1'),
('SOR001','001805','1'),
('SOR001','001806','1'),
('SOR002','001807','1'),
('SOR002','001808','2'),
('SOR002','001811','1'),
('SOR002','001812','1'),
('SOR003','001802','1'),
('SOR004','001816','1'),
('SOR004','001818','2'),
('SOR004','001819','1'),
('SOR005','001802','1'),
('SOR005','001803','1'),
('SOR005','001806','2'),
('SOR006','001802','2'),
('SOR006','001803','1'),
('SOR007','001807','1'),
('SOR007','001809','1'),
('SOR007','001812','1'),
('SOR008','001802','1'),
('SOR008','001803','1'),
('SOR008','001806','1'),
('SOR009','001808','2'),
('SOR009','001809','1'),
('SOR010','001811','1'),
('SOR011','001816','1'),
('SOR011','001817','1'),
('SOR012','001802','2'),
('SOR012','001803','1'),
('SOR013','001816','1'),
('SOR013','001817','1'),
('SOR013','001818','1'),
('SOR014','001819','1'),
('SOR014','001820','2'),
('SOR015','001802','2'),
('SOR015','001803','1'),
('SOR015','001806','2');

Insert CheckInOrder.LaundryService VALUES
('LS0001','2018-02-25 09:00:00','2018-2-25 19:00:00','9.99','ch1'),
('LS0002','2018-02-27 10:00:00','2018-2-27 20:00:00','12.99','ch1'),
('LS0003','2018-10-20 09:00:00','2018-10-20 19:00:00','12.99','ch13'),
('LS0004','2018-11-15 08:00:00','2018-11-15 19:00:00','12.99','ch17'),
('LS0005','2018-11-17 08:00:00','2018-11-17 20:00:00','9.99','ch17'),
('LS0006','2018-12-05 08:30:00','2018-12-05 19:30:00','9.99','ch2'),
('LS0007','2018-12-10 07:30:00','2018-12-10 18:30:00','9.99','ch2'),
('LS0008','2019-03-26 09:00:00','2019-03-26 19:00:00','12.99','ch5'),
('LS0009','2019-05-12 09:00:00','2019-05-12 19:00:00','9.99','ch14'),
('LS0010','2019-09-20 09:00:00','2019-09-20 20:00:00','9.99','ch7'),
('LS0011','2019-10-20 10:00:00','2019-10-20 20:00:00','9.99','ch7'),
('LS00011','2019-05-12 09:00:00','2019-05-12 19:00:00','9.99','ch14'),
('LS00012','2018-10-20 09:00:00','2018-10-20 19:00:00','12.99','ch13');
-- use function insert Calculated column
--Calculate NetProfit in Store.Product
create function fn_NetProfit(@ProductID varchar(40))
returns money 
as begin 
   declare @NetProfit money=
           (select (ProductPrice-ProductCost) 
		   from Store.Product
		   WHERE ProductID=@ProductID
		   );
   return @NetProfit
end

alter table Store.Product 
add NetProfit as dbo.fn_NetProfit(ProductID)

--Calculate StotalOrder in CheckInOrder.StoreOrder

create function fn_StotalPrice(@SorderID varchar(40))
returns money
as begin 
    declare @StotalPrice money=
	     ( select sum(sp.ProductPrice*csop.ProductAmount)
		   from Store.Product sp
		   join CheckInOrder.StoreOrderProduct csop
		   on sp.ProductID=csop.ProductID
		   join CheckInOrder.StoreOrder cso
		   on csop.SOrderID=cso.SOrderID
		 where cso.SOrderID=@SorderID 
		 );
	return @StotalPrice;
end

alter table CheckInOrder.StoreOrder
add StotalPrice as dbo.fn_StotalPrice(SOrderID);

alter table CheckInOrder.StoreOrder
drop column StotalPrice;

--Calculate CheckInRate in CheckIn.CheckInOut
create function fn_CheckInRate(@CheckInID varchar(40))
returns money
as begin
   declare @CheckInRate money=(
      select Rate
	  from Room.RoomRate rrr
	  left join Room.RoomType rrt
	  on rrr.RoomTypeID=rrt.RoomTypeID
	  join Room.Room rr
	  on rrt.RoomTypeID=rr.RoomTypeID
	  join CheckIn.CheckInOut ccio
	  on ccio.RoomNo=rr.RoomNO
	  where ACheckInDate between RateStartDate and RateEndDate
	  and CheckInID=@CheckInID
	  );
   return @CheckInRate;
end
alter table CheckIn.CheckInOut
add CheckInRate as dbo.fn_CheckInRate(CheckInID)
select *from CheckIn.CheckInOut
alter table CheckIn.CheckInOut
drop column CheckInRate
--Calculate Duration
alter table CheckIn.CheckInOut
drop column Duration

alter table CheckIn.CheckInOut
add Duration as datediff(day,ACheckInDate,AcheckOutDate)

--Calculate ROrderPrice in CheckInOrder.RestaurantOrder

create function fn_Restr_Order(@RorderID varchar(40))
returns money 
as begin
 declare @OrderAmount money =
        (select SUM(DishPrice*DAmount)
		      from Restaurant.Dish rd
			  join CheckInOrder.OrderDish co
			  on rd.DishID=co.DishID
			  join CheckInOrder.RestaurantOrder cr
			  on co.ROrderID=cr.ROrderID
			  where cr.ROrderID=@RorderID);
	return @OrderAmount;
	end 
alter table CheckInOrder.RestaurantOrder
add RTotalPrice as (dbo.fn_Restr_Order(RorderID)) 
select*from CheckInOrder.RestaurantOrder
ALTER TABLE CheckInOrder.RestaurantOrder
drop column RTotalPrice



--Calculate Total consumptions in CheckIn.Bill
create function fn_TotalRoom(@CheckInID varchar(40))
returns money 
as begin
   declare @TotalRoom money =
   (select CheckInRate*Duration
    from CheckIn.CheckInOut
	where CheckInID=@CheckInID);
   return @TotalRoom;
end

alter table CheckIn.Bill
ADD TotalRoomConsumption as dbo.fn_TotalRoom(CheckInID);

Create function fn_TotalStore(@CheckInID varchar(40))
returns money 
as begin 
   declare @TotalStore money=
      (select sum(StotalPrice)
	   from CheckInOrder.StoreOrder
	   where CheckInID=@CheckInID)
	   set @TotalStore=ISNULL(@TotalStore,0);
	return @TotalStore;
end
alter table CheckIn.Bill
ADD TotalStoreConsumption as dbo.fn_TotalStore(CheckInID)
alter table CheckIn.Bill
drop column TotalStoreConsumption;
	  
create function fn_TotalRest (@CheckInID varchar(40))
returns money
as begin
   declare @TotalRest money =
      (select sum(RTotalPrice)
	   from CheckInOrder.RestaurantOrder
	   where CheckInID=@CheckInID)
	   set @TotalRest=isnull(@TotalRest,0);
	return @TotalRest;
	end
alter table CheckIn.Bill
ADD TotalRestaurantConsumption as dbo.fn_TotalRest(CheckInID)
alter table CheckIn.Bill
drop column TotalRestaurantConsumption;

create function fn_TotalLaun (@CheckInID varchar(40))
returns money
as begin 
    declare @TotalLaun money=
	  (select sum(LaundryPrice)
	   from CheckInOrder.LaundryService
	   WHERE CheckInID=@CheckInID)
	  set @TotalLaun=ISNULL(@TotalLaun,0);
	  return @TotalLaun;
end
alter table CheckIn.Bill
ADD TotalLaundryConsumption as dbo.fn_TotalLaun(CheckInID)
alter table CheckIn.Bill
drop column TotalLaundryConsumption

/*create function fn_MemberRoomPrice(@BillID int)
returns money
as begin 
    declare @MemberP money=
	(select TotalRoomConsumption*cm.Discount
     from CheckIn.Bill cib 
     left join CheckIn.CheckInOut cco
     on cib.CheckInID=cco.CheckInID
     left join Reservation.Reservation rr
     on cco.ReservationID=rr.ReservationID
     left join Customer.Customer cc
     on rr.CustomerID=cc.CustomerID
     left join Customer.Membership cm
     on cc.MemberID=cm.MemberID
	 where cib.BillID=@BillID);
	 return @Memberp;
end
drop function dbo.fn_MemberRoomPrice
alter table CheckIn.Bill
add MemberRoomPrice as dbo.fn_MemberRoomPrice(BillID)
alter table CheckIn.Bill
drop column MemberRoomPrice;*/



create function fn_TotalBill(@BillID int)
returns money 
as begin 
   declare @TotalBill money =
   (select TotalRoomConsumption+TotalStoreConsumption+TotalRestaurantConsumption+TotalLaundryConsumption
   from CheckIn.Bill 
   where BillID=@BillID);
 RETURN @TotalBill;
 end
alter table CheckIn.Bill
add TotalBillAmount as dbo.fn_TotalBill(BillID)
select*from CheckIn.Bill

--View 
CREATE VIEW [Customer Dining Record] AS
SELECT DISTINCT cc.FirstName, cc.LastName, cb.TotalRestaurantConsumption, cb.TotalBillAmount,
convert(varchar(10),round(cb.TotalRestaurantConsumption/cb.TotalBillAmount*100,2))+'%' AS [Dining sales percent]
from CheckIn.Bill cb
JOIN CheckIn.CheckInOut co
on cb.CheckInID=co.CheckInID
    JOIN Reservation.Reservation rr
    ON co.ReservationID =rr.ReservationID
    JOIN Customer.Customer cc
    ON rr.CustomerID =cc.CustomerID;

Drop VIEW [Customer Dining Record];


Create view[Customer Total Consumption] as
select cc.LastName,cc.FirstName,cb.TotalBillAmount,
CASE
    WHEN TotalBillAmount > 2000 THEN 'High Consumption'
    WHEN TotalBillAmount<=2000 and TotalBillAmount >700  THEN 'Midum Consumption'
    ELSE 'Normal Consumption'
END AS Consumprion
from CheckIn.Bill cb
left join 
CheckIn.CheckInOut cio
on cb.CheckInID=cio.CheckInID
left join Reservation.Reservation rr
on rr.ReservationID=cio.ReservationID
left join Customer.Customer cc
on cc.CustomerID=rr.CustomerID;

drop view [Customer Total Consumption]
