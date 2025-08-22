#Creating Junction Tables 

CREATE TABLE BOOK_GENRES (
    Book_ID INT,
    Genre_ID INT,
    title VARCHAR(100),
    genre_name VARCHAR(50),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID) ON DELETE CASCADE,
    FOREIGN KEY (Genre_ID) REFERENCES genres(Genre_ID) ON DELETE CASCADE);
    
   CREATE TABLE User_Book (
    User_id varchar(20),
    Book_ID INT,
    PRIMARY KEY (User_ID, Book_ID),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE CASCADE,
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID) ON DELETE CASCADE
);
	INSERT IGNORE INTO User_Book (User_ID, Book_ID)
SELECT DISTINCT User_ID, Book_ID FROM Ratings;


