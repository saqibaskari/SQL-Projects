CREATE TABLE Authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

CREATE TABLE Borrowers (
    borrower_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Loans (
    loan_id SERIAL PRIMARY KEY,
    book_id INT,
    borrower_id INT,
    loan_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (borrower_id) REFERENCES Borrowers(borrower_id)
);
-- Find all books by a specific author
SELECT b.title 
FROM Books b
JOIN Authors a ON b.author_id = a.author_id
WHERE a.name = 'Author Name';

-- Find all borrowed books and their due dates
SELECT b.title, l.return_date 
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
WHERE l.return_date IS NOT NULL;

-- Find all borrowers with overdue books
SELECT br.name 
FROM Borrowers br
JOIN Loans l ON br.borrower_id = l.borrower_id
WHERE l.return_date < CURRENT_DATE;
