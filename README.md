# database_hotel

Nowadays, while new technology is developing, all the traditional industry is facing new opportunities and challenges at the same time, such as the hospitality industry. As a very intense and high-pressure industry, there are always misunderstandings and communication issues because of lacking information, which is data in this project. Our group believes that an effective, user-friendly and fully functional database will not only help the management team perform better service for customers and manage employees' performance but also help customers create better accommodation experience. So, they would choose doing business with certain hotels again. Therefore, our business problem is going to design a database to help hotels maximize profits for certain property.

To build a database solving all the business problems that have been mentioned in previous paragraph, there are a few entities that the database has to include, which have been listed as below:

Reservation
● For reservations, we have created a Reservation entity. The primary key of the entity is the ReservationID, identifying different reservations. Each ReservationID could only reserve one room. The whole entity contains the basic information of reservations. Such as the room type, the customer id, assumed check-in date and check-out date, date of the reservation and the number of guests. If the guest wants to change the reservation, it will create a new reservation. In the reservation entity, the key called ReservationStatus could be used to identify whether the reservation is canceled or it is active. This entity uses foreign keys called RoomTypeID, CustomerID and CheckInID related to RoomType, Customer and CheckInOut entities.

Customer, Membership
● In order to store information about customers, we create an entity called customer, The primary key is the customer id, identifying the different customer. The whole entity contains the basic information of customers. In addition, it has a foreign key called MemberID, which relate to the Member entity.
● The membership entity contains member information of the hotel. We can use MemberID to find out the VIP level of the member and the discount for this member.

RoomType, RoomRate, Room
● To clearly store and use the room information, we create three entities.
● The RoomType entity contains room types, the rate id of each type and the total room amount of each type. It uses the RateID as a foreign key to relate to the RoomRate entity.
● The RoomRate entity contains the exact rate for a specific type of room and the duration of this rate, which could allow the manager of the hotel to change the rate.
● The Room entity contains room number, room availability, clean status, and
maintenance status of the room. It could help search the available room and the search rooms by location, clean status, and maintenance status. It uses the RoomTypeID as a foreign key to relate to the RoomType entity.

RoomClean, Maintenance, Case, Employee, Department
● The RoomClean entity contains the room clean designation. Shows who is assigned to work for the specific room. The primary key of this entity is the combination of EmployeeID and RoomID. Which relate this entity to Room and Employee.
● The MaintenanceCase entity contains the rooms that need maintenance service and what kinds of service they need. It uses the CaseID to identify different cases. In addition, it uses EmployeeID and RoomNO as foreign keys to relate to Employee and Room entity.
● The Employee entity stores information for all employees in the hotel. It uses the DepartmentID as a primary key to relating to the Department entity.
● The Department entity stores department name by DepartmentID

CheckInOut, CheckInRoom, Bill, Feedback
● The CheckInOut entity has a primary key called ​CheckInID​, which is assigned to the customer once they check-in. And CheckInID is also essential to the customer and hotel because ​other consumptions in the hotel could be retrieved by the CheckInID.The entity also contains the information of actually check-in date and actually check out date, which could be very helpful if the customer did not check out as expected.
● The CheckInRoom entity assigns the room to the customer by CheckInID. It also records the occupied duration of the room. It could help when the customer wants to change the room before they check out.
● The Bill entity contains the information we need for bills, For each bill, it has a primary key called Bill_ID, and for each Bill_ID it can relate to several CheckinID(foreign key), which means a customer can pay for several reservations. In addition, we can use the MemberID(foreign key) in the entity to retrieve the discount for the customer. Other than that, we can use the CustomerID(foreign key) to retrieve the address of the customer and send the bill. The TotalAmount is calculated by adding all orders together linked to each CheckInID. This entity is related to CheckInOut, Customer and Member entity by using CheckInID, CustomerID, and MemberID as foreign keys.
● The Feedback entity is trying to provide a quantified evaluation method. Every
customer will receive a feedback survey after their check-out based on their ChcekInID. By setting FeedbackID as a primary key, it will be easier for the management team to find out customer’s degrees of certification, and look for a solution for existing problems. This entity is related to the CheckInOut entity by using the CheckInID as a foreign key.

ResaurantOrder, Dish, Table, RestaurantTable, Restaurant
● The RestaurantOrder entity has the information on orders generated in restaurants. The primary key RorderID identifies each order. The RestaurantOrder entity has the TableID(relate to Table entity), DishID(relate to Dish entity), and CheckInID(relate to ) as the foreign keys, that could identify the table and dish information of the order, and use the CheckInID relate the restaurant order with the customer’s other consumptions.
● The Dish entity has the dishes information of the hotel. This entity uses RestaurantID as a foreign key to relate to the Restaurant entity.
● The Table entity describes the detail of each table in the restaurant. It could be used to search the available table by the number of guests.
● The RestaurantTable demonstrate the relationship between Restaurant and table. Both of the keys are primary keys relate to this entity to the Restaurant entity and Table entity.
● The Restaurant entity contains information for different restaurants in the hotel. we can perform a search of the restaurant by location and open time.

StoreOrder, StoreOrderProduct, Store, StoreProduct, Product, Supplier
● The StoreOrder entity contains the general order information created by the customer when a customer buys products from the store, it generates an order. Each row of the entity contains the StoreID that could tell where the order is generated. In addition, it uses the CheckInID to identify the customer of the order.
● The StoreOrderProduct entity contains the detailed information of the order, that is which product and the amount of the product. Both SOrderID and ProductID are primary keys. They link the entity to the Product entity and StoreOrder entity.
● The Store entity contains the information related to multiple stores located inside the hotel. This entity can easily look for each store information based on StoreID, and it will help the management team find out which store has better performance based on selling net profit.
● The StoreProduct entity contains both StoreID and ProductID. It demonstrates the relationships between the stores and products. Both of the keys are primary keys, that link the entity to the Product entity and Store entity.
● The Product entity using ProductID as primary key, this database will be able to add and update items on the inventory, and also perform the selling function for customers. It uses SupplierID as a foreign key to relate to the Supplier entity.
● The Supplier entity has a non-identity relationship with the Product entity. It’s aiming to contain information on product suppliers, therefore the hotel will be able to easily access the necessary information for reordering based on the primary key which is SupplierID.

LaudaryService
● The LaudayService entity contains information regarding laundry service. Using
LSeriveID as a primary key can help staff to look up details about service order. By using the MemberID, staffs will be able to set up ReturnTime and LaundryPrice based on member level, which is going to allow the hotel to perform some special service for its members, such as the same-day laundry service. Meanwhile, customers will be able to order a laundry service base on CheckInID, and users of the system are able to perform research based on CheckInID and MemeberID. This entity uses MemberID and CheckInID as foreign keys to relate to the Member entity and CheckInOut entity.
