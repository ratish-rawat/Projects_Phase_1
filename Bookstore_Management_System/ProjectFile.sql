USE EBOOKSTORE_MANAGEMENT_SYSTEM;

#Table1 created 
CREATE TABLE STOCKS(
	Book_id INT,
    Quantity int,
    Availability_status VARCHAR(15)
    ); 
    
 #Table2 created    
    CREATE TABLE Users_Location(
		Location_ID INT auto_increment primary key,
        City VARCHAR(30) UNIQUE,
        Country VARCHAR(30)
        ); 
        
 #Table3        
CREATE TABLE USERS (
	User_id VARCHAR(20), 
    User_name VARCHAR(50),
    User_account VARCHAR(70),
    location_id int NOT NULL, 
	FOREIGN KEY (Location_ID) REFERENCES Users_Location(Location_Id)
    );
   ALTER TABLE USERS ADD COLUMN City VARCHAR(30);
   TRUNCATE TABLE USERS;
   
   SET SQL_SAFE_UPDATES=0;
   
   UPDATE Users u
JOIN Users_Location l ON u.City = l.City
SET u.Location_Id = l.Location_ID;        #To include the location_id in the Users Table 
ALTER TABLE USERS DROP COLUMN City; 
ALTER TABLE Users
ADD PRIMARY KEY (User_id);

#Table4 created
CREATE TABLE Ratings (
		Rating_ID INT auto_increment Primary Key,
        User_id VARCHAR(20), 
        FOREIGN KEY (User_id) REFERENCES USERS(User_id),
		Book_id INT, 
		ISBN VARCHAR(15),
        Rating TINYINT
        );

#Table5 created 
CREATE TABLE Book_Format (
		F_Id INT auto_increment primary key,
        Format_Type VARCHAR(15) UNIQUE
        );
        
	#To Check how many books of each type are there 
   SELECT  Format_Type,
   COUNT(Book_ID) as Copies_available FROM Book_Format
   GROUP BY Format_Type
   ORDER BY Copies_available DESC;
   
  #Table6 
  CREATE TABLE AUTHORS(
	A_ID INT primary key,
    Author_name VARCHAR(50)
    );
    
    #Table7
    CREATE TABLE PUBLISHERS(
    P_ID INT primary key auto_increment,
    Publisher_name VARCHAR(150) UNIQUE,
    City VARCHAR(50)
        );
        
     #Table8 
      CREATE TABLE PUBLISHERS_LOCATION (
			P_LOCATION_ID INT auto_increment primary key, 
            City VARCHAR(60) UNIQUE,
            Country VARCHAR(50)
            );
            
     #Table9       
      ALTER TABLE GENRE_TABLE  
     RENAME TO GENRES_AND_CATEGORIES;
     
     #Table10
     CREATE TABLE BOOKS (
			Book_id INT AUTO_INCREMENT PRIMARY KEY,
            Title VARCHAR(70) NOT NULL, 
            Author_name VARCHAR(40),
            Page_ INT, 
            Format_Type VARCHAR(15),
		    Publisher_name VARCHAR(150),
            Prices DECIMAL(10,3),
            Publication_Year Year, 
            ISBN VARCHAR(25), 
            Avg_ratings DECIMAL(5,2)
            );
            DROP TABLE BOOKS;

            
            
		