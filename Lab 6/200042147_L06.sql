CREATE TABLE BOOKS
(
    ISBN varchar(13),
    name varchar(50),
    Author varchar(50),
    genre varchar(50),
    quality int,
    price numeric(10, 2),
    CONSTRAINT PK_BOOKS PRIMARY KEY (ISBN)
);


CREATE TABLE PUBLISHER 
(
    publisher_name varchar(50),
    city varchar(50),
    publisher_est_year int,
    ISBN varchar(13),
    CONSTRAINT PK_PUBLISHER PRIMARY KEY (publisher_name, city),
    CONSTRAINT FK_BOOKS FOREIGN KEY (ISBN) REFERENCES BOOKS (ISBN)
);


CREATE TABLE BRANCH
(
    B_ID varchar(5),
    location varchar(20),
    branch_Est_year YEAR,
    ISBN varchar(13), 
    CONSTRAINT PK_BRANCH_ID PRIMARY KEY (ID),
    CONSTRAINT FK_BOOKS FOREIGN KEY (ISBN) REFERENCES BOOKS (ISBN)
);


CREATE TABLE TYPE
(
    typename varchar(50),
    base_salary numeric(10, 2),
    CONSTRAINT PK_TYPENAME PRIMARY KEY (typename)
);


CREATE TABLE Issued_book
(
    ISBN varchar(13),
    duration int,
    issued_date date,
    CONSTRAINT FK_BOOKS FOREIGN KEY (ISBN) REFERENCES BOOKS (ISBN) ON DELETE CASCADE
);


CREATE table SHIFT
(
    Working_Shift DATETIME
);


CREATE TABLE EMPLOYEE
(
    NID int,
    name varchar(30),
    Blood_Group varchar(3),
    DOB DATE,
    B_ID varchar(5),
    Working_Shift DATETIME,
    typename varchar(50),
    duration int,
    CONSTRAINT PK_EMPLOYEE_NID PRIMARY KEY (NID),
    CONSTRAINT FK_BRANCH_ID FOREIGN KEY (B_ID) REFERENCES BRANCH (B_ID),
    CONSTRAINT FK_SHIFT FOREIGN KEY (Working_Shift) REFERENCES SHIFT (Working_Shift),
    CONSTRAINT FK_TYPE FOREIGN KEY (typename) REFERENCES TYPE (typename),
    CONSTRAINT FK_ISSUED_BOOK FOREIGN KEY (duration) REFERENCES Issued_book (duration)
);



CREATE TABLE ACCOUNT
(
    USERNAME VARCHAR(50),
    USER_DOB DATE,
    NAME varchar(50),
    occupation VARCHAR(50),
    ISBN VARCHAR(13),
    duration INT,
    CONSTRAINT PK_ACCOUNT PRIMARY KEY (USERNAME),
    CONSTRAINT FK_BOOKS FOREIGN KEY (ISBN) REFERENCES BOOKS (ISBN),
    CONSTRAINT FK_ISSUED_BOOK FOREIGN KEY (duration) REFERENCES ISSUED_BOOK (duration)
);

