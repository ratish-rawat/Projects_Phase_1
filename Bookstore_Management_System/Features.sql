
-- search by keyword (genre) Feature-1
SELECT 
    b.Book_id,
    b.title,
    b.Page_Length,
    b.Prices,
    b.Publication_Year,
    b.ISBN,
    b.Avg_ratings,
    g.genre_name
FROM books b
JOIN book_genres bg ON b.Book_id = bg.Book_ID
JOIN genres g ON bg.Genre_ID = g.GENRE_ID
WHERE g.genre_name LIKE '%science%';

#Searching By Author Feature-2 
SELECT 
    b.Book_id,
    b.title,
    b.Page_Length,
    b.Prices,
    b.Publication_Year,
    b.ISBN,
    a.author_name,
    b.Avg_ratings
FROM books b
JOIN authors a ON a.a_id= b.a_id
WHERE a.author_name='Kristin Hannah';

-- top rated books with  less than given price Feature-3
SELECT 
    b.Book_id,
    b.title,
    b.Page_Length,
    b.Prices,
    b.Publication_Year,
    b.ISBN,
    b.Avg_ratings,
    a.Author_name,
    GROUP_CONCAT(g.genre_name SEPARATOR ', ') AS genres
FROM books b
JOIN authors a ON b.A_ID = a.A_ID
JOIN book_genres bg ON b.Book_id = bg.Book_ID
JOIN genres g ON bg.Genre_ID = g.GENRE_ID
WHERE b.Prices <= 1000
GROUP BY b.Book_id
ORDER BY b.Avg_ratings DESC;


-- Management Feature countries with most book readers/ Feature-4 
SELECT ul.country, COUNT(DISTINCT ub.user_id) AS total_readers
FROM user_book ub
JOIN users u ON ub.user_id = u.user_id
JOIN users_location ul ON u.location_id = ul.location_id
GROUP BY ul.country
ORDER BY total_readers DESC;


-- Management Feature countries with most diverse readers/ Feature-5 
SELECT ul.country, COUNT(DISTINCT bg.Genre_ID) AS genre_variety
FROM user_book ub
JOIN users u ON ub.user_id = u.user_id
JOIN users_location ul ON u.location_id = ul.location_id
JOIN book_genres bg ON ub.book_id = bg.Book_ID
GROUP BY ul.country
ORDER BY genre_variety DESC;

-- most sold books with name of publisher too / Feature-6 
SELECT 
    p.Publisher_name,
    b.title,
    COUNT(*) AS book_sales
FROM user_book ub
JOIN books b ON ub.book_id = b.Book_id
JOIN publishers p ON b.P_ID = p.P_ID
WHERE p.Publisher_name = (
    SELECT p2.Publisher_name
    FROM user_book ub2
    JOIN books b2 ON ub2.book_id = b2.Book_id
    JOIN publishers p2 ON b2.P_ID = p2.P_ID
    GROUP BY p2.Publisher_name
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
GROUP BY b.Book_id, p.Publisher_name, b.title
ORDER BY book_sales DESC;


-- High-Priced & Highly-Rated Books/ Feature-7
SELECT *
FROM books
WHERE 
    Prices > (SELECT AVG(Prices) FROM books)
    AND Book_id IN (
        SELECT book_id
        FROM ratings
        GROUP BY book_id
        HAVING COUNT(*) > (
            SELECT AVG(rating_count)
            FROM (
                SELECT COUNT(*) AS rating_count
                FROM ratings
                GROUP BY book_id
            ) AS book_rating_counts
        )
    );


-- yearwise books/ Feature - 8 
SELECT Publication_Year, COUNT(*) AS total_books_published
FROM books
GROUP BY Publication_Year
ORDER BY Publication_Year DESC;


--  Top Rated Book Each Year/ Feature - 10
SELECT *
FROM books b1
WHERE Avg_ratings = (
    SELECT MAX(Avg_ratings)
    FROM books b2
    WHERE b2.Publication_Year = b1.Publication_Year
)
ORDER BY Publication_Year DESC;



-- top  authors who published most books user-dependant numbwe of authors/ Feature - 11
SELECT a.Author_Name, b.A_ID, COUNT(*) AS total_books
FROM books b
JOIN authors a ON b.A_ID = a.A_ID
GROUP BY b.A_ID, a.Author_Name
ORDER BY total_books DESC
LIMIT 3;

-- Authors Who Have Written in Multiple Genres/ Feature-12 
SELECT a.Author_Name, ag.A_ID
FROM (
    SELECT b.A_ID, bg.Genre_ID
    FROM books b
    JOIN book_genres bg ON b.Book_id = bg.Book_ID
    GROUP BY b.A_ID, bg.Genre_ID
) AS ag
JOIN authors a ON ag.A_ID = a.A_ID
GROUP BY ag.A_ID, a.Author_Name
HAVING COUNT(DISTINCT ag.Genre_ID) > 1;

-- User-Friendly Book_Length Filter/ Feature-13
SELECT title, prices, page_length,author_name
FROM Books b 
JOIN authors a ON b.a_id=a.a_id 
WHERE page_length>=300 AND page_Length<=600;

-- number of records in each table/  
SELECT 'books' AS table_name, COUNT(*) AS total_records FROM books
UNION ALL
SELECT 'authors', COUNT(*) FROM authors
UNION ALL
SELECT 'publishers', COUNT(*) FROM publishers
UNION ALL
SELECT 'genres', COUNT(*) FROM genres
UNION ALL
SELECT 'users', COUNT(*) FROM users
UNION ALL
SELECT 'stocks', COUNT(*) FROM stocks
UNION ALL
SELECT 'ratings', COUNT(*) FROM ratings
UNION ALL
SELECT 'user_book', COUNT(*) FROM user_book
UNION ALL
SELECT 'book_genre', COUNT(*) FROM book_genres
UNION ALL
SELECT 'book_format', COUNT(*) FROM book_format
UNION ALL
SELECT 'users_location', COUNT(*) FROM users_location
UNION ALL
SELECT 'publishers_location', COUNT(*) FROM publishers_location;




-- total number of records
SELECT SUM(total_records) AS total_records_in_all_tables
FROM (
    SELECT COUNT(*) AS total_records FROM books
    UNION ALL
    SELECT COUNT(*) FROM authors
    UNION ALL
    SELECT COUNT(*) FROM publishers
    UNION ALL
    SELECT COUNT(*) FROM genres
    UNION ALL
    SELECT COUNT(*) FROM users
    UNION ALL
    SELECT COUNT(*) FROM stocks
    UNION ALL
    SELECT COUNT(*) FROM ratings
    UNION ALL
    SELECT COUNT(*) FROM user_book
    UNION ALL
    SELECT COUNT(*) FROM book_genres
    UNION ALL
    SELECT COUNT(*) FROM book_format
    UNION ALL
    SELECT COUNT(*) FROM users_location
    UNION ALL
    SELECT COUNT(*) FROM publishers_location
) AS all_counts;

