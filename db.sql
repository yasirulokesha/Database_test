/* 
    DATABASE ANALYSIS & DESIGN 
    ASSIGNMENT 1 ( Group ) 
*/

--Task 1

--1A

/*
    104067180  Yohani Uthpala
    104060309  Yasiru  Lokesha
    104053891  Sithum Nimlaka
    104048389  Inuka Herath
    104048664  Chamodi Perera
    104060202  Shihara Fernando
    104048651  Naveen Nisal
*/

-- 1B

-- Book Table

CREATE TABLE book(
bid number(4),
title varchar2(30) NOT NULL,
sellingprice number(6,2) CHECK (sellingprice>=0),
PRIMARY KEY (bid)
);

-- Author Table

CREATE TABLE author(
authid number(4),
sname varchar2 (30),
fname varchar2 (30),
PRIMARY KEY (authid),
CONSTRAINT CHK_Name UNIQUE(sname, fname)
);

-- Allocation Table

CREATE TABLE allocation(
bid number(4),
authid number(4),
payrate number(6,2),
PRIMARY KEY (bid,authid),
FOREIGN KEY (bid) REFERENCES BOOK,
FOREIGN KEY (authid) REFERENCES AUTHOR,
CONSTRAINT CHK_Pay check(payrate>=1 AND payrate <=79.99)
);


-- 1C 

-- Author Data

INSERT INTO author VALUES (40,  'Abott', 'Tony');
INSERT INTO author VALUES  ( 42,  'Bishop', 'Bronwyn');
INSERT INTO author VALUES ( 44,  'Fischer', 'Tim');
INSERT INTO author VALUES ( 45,  'Grossman', 'Paul');
INSERT INTO author VALUES ( 47,  'Ziggle', 'Annie');
INSERT INTO author VALUES ( 48,  'Zhao', 'Cheng'); 
INSERT INTO author VALUES ( 50,  'Phan', 'Annie');
 
-- Book Data 

INSERT INTO book VALUES ( 101, 'Knitting with Dog Hair', 6.99);
INSERT INTO book VALUES ( 105, 'Avoiding Large Ships', 11);
INSERT INTO book VALUES ( 107, 'Dealing with stuff', 6.5);
INSERT INTO book VALUES ( 108, 'Teach fish to sing', 10.99);
INSERT INTO book VALUES ( 109, 'Guide to hands free texting', 10.5);
INSERT INTO book VALUES ( 113, 'You call that a lecture?', 17.5); 

-- Allocation Data

INSERT INTO allocation VALUES (101,42,25);
INSERT INTO allocation VALUES (101,45,32);
INSERT INTO allocation VALUES (108,47,35);
INSERT INTO allocation VALUES (113,48,40);
INSERT INTO allocation VALUES (109,47,42);
INSERT INTO allocation VALUES (105,42,28);
INSERT INTO allocation VALUES (105,47,26);
INSERT INTO allocation VALUES (105,40,19);
INSERT INTO allocation VALUES (107,42,35);
INSERT INTO allocation VALUES (108,40,45);

-- END OF INITALS --

-- 1D

-- Statement 1 
-- INSERT INTO author (authid,sname, fname) VALUES (47,'Ziggle','Annie');

-- Statement 2
-- INSERT INTO book (bookid, sellingprice) VALUES (101,6.99);

-- Statement 3
-- INSERT INTO book (bookid,title, sellingprice) VALUES (587,'Dealing with stuff',-9.5);

-- Statement 4
-- INSERT INTO allocation (allocationid,bid,authid, payrate) VALUES (111,108,40,85);


-- 1E

-- Query 1

SELECT * from allocation 
ORDER by bid,authid;

-- Query 2

SELECT book.bid,book.title,allocation.authid,allocation.payrate 
FROM book
INNER JOIN allocation
ON allocation.bid=book.bid
ORDER BY bid, authid;

-- Query 3

SELECT book.bid,book.title,book.sellingprice,author.authid,author.sname,allocation.payrate
FROM book
INNER JOIN allocation
ON  allocation.bid=book.bid
INNER JOIN author
ON allocation.authid=author.authid  
ORDER BY bid,authid; 

-- Query 4

SELECT AVG (sellingprice) 
FROM book;

-- Query 5

SELECT * FROM book
Where sellingprice < 10.58;

-- Query 6  

SELECT allocation.bid, COUNT(allocation.bid) as "COUNT(*)"
FROM allocation
GROUP by bid
ORDER BY COUNT(allocation.bid),allocation.bid;

-- Query 7

SELECT allocation.bid, book.title,COUNT(allocation.bid) as "COUNT(*)"
FROM allocation
INNER JOIN book
ON book.bid = allocation.bid
GROUP by allocation.bid
ORDER BY COUNT(allocation.bid),allocation.bid;

-- Query 8

SELECT allocation.bid as "BID",book.title AS "TITLE",COUNT(allocation.bid) AS "COUNT"
FROM allocation
INNER JOIN book 
ON book.bid=allocation.bid
HAVING COUNT(allocation.bid)>1
GROUP BY ALLOCATION.bid,BOOK.title
ORDER BY COUNT;

-- Query 9
SELECT author.authid,author.sname,author.fname,allocation.bid
FROM author
INNER JOIN allocation
ON author.authid=allocation.authid
ORDER BY authid,bid;

-- Query 10

SELECT author.authid,author.sname,author.fname,allocation.bid 
FROM author 
LEFT JOIN allocation 
ON author.authid=allocation.authid
ORDER BY author.authid,allocation.bid;

-- Query 11

SELECT author.authid,author.sname,author.fname,allocation.bid,book.title
FROM author
LEFT JOIN allocation
ON author.authid=allocation.authid
LEFT JOIN book
ON book.bid=allocation.bid
ORDER BY author.authid,allocation.bid;

-- TASK 2

-- 2A

-- Creating the worksession table

CREATE TABLE  worksession(
bid number(4),
authid number(4),
WorkYear number (4),
WorkWeek number(2),
WorkHours number(4,2),
FOREIGN KEY (authid) REFERENCES author,
FOREIGN KEY (bid) REFERENCES book,
PRIMARY KEY (bid, authid,WorkYear,WorkWeek),
constraint CHK_year CHECK (WorkYear>=2019 AND WorkYear <=2020),
constraint CHK_week CHECK (WorkWeek>=1 AND WorkWeek <=52),
constraint CHK_hours  CHECK (WorkHours>=0.5 AND WorkHours <=99.99)
);

-- 2B

INSERT INTO worksession VALUES (101,42,2020,5,5);
INSERT INTO worksession VALUES (101,42,2020,6,4);
INSERT INTO worksession VALUES (101,42,2020,7,5);
INSERT INTO worksession VALUES (101,45,2020,5,10);
INSERT INTO worksession VALUES (101,45,2020,7,10);
INSERT INTO worksession VALUES (105,42,2020,5,6);
INSERT INTO worksession VALUES (105,47,2020,4,8);
INSERT INTO worksession VALUES (105,47,2020,6,7);
INSERT INTO worksession VALUES (105,47,2020,8,8);
INSERT INTO worksession VALUES (108,40,2019,52,4);
INSERT INTO worksession VALUES (108,40,2020,4,15);
INSERT INTO worksession VALUES (108,40,2020,6,6);
INSERT INTO worksession VALUES (108,47,2020,8,4);
INSERT INTO worksession VALUES (109,47,2020,5,5);
INSERT INTO worksession VALUES (109,47,2020,6,5);
INSERT INTO worksession VALUES (113,48,2020,10,15);
INSERT INTO worksession VALUES (113,48,2020,11,4);
INSERT INTO worksession VALUES (113,48,2020,12,1);

-- 2C

INSERT INTO worksession VALUES (199,48,2020,1,1);
INSERT INTO worksession VALUES (109,41,2020,2,2);
INSERT INTO worksession VALUES (101,42,2022,9,6);
INSERT INTO worksession VALUES (101,45,2020,55,3);
INSERT INTO worksession VALUES (108,40,2020,7,120);


-- 2D

-- Query 1

SELECT authid,WorkYear,WorkWeek,WorkHours 
FROM worksession
ORDER by authid,WorkYear,WorkWeek;

-- Query 2

SELECT authid,WorkYear, SUM(worksession.WorkHours) as "TotalHours"
FROM worksession
GROUP BY (authid,WorkYear)
ORDER BY authid DESC;

-- Query 3

SELECT * FROM worksession;

-- Query 4

SELECT bid,authid,WorkYear,SUM(WorkHours) AS "Totalhours"
FROM worksession
GROUP BY (bid,authid,WorkYear)
ORDER BY bid;


-- Query 5

SELECT allocation.bid,worksession.authid,REPLACE(WorkYear,'2020','2012') AS "workyear" ,SUM(WorkHours)*(allocation.payrate) AS "Total Pays"
FROM worksession
INNER JOIN allocation
ON worksession.authid = allocation.authid
GROUP BY (worksession.bid,worksession.authid,worksession.WorkYear)
ORDER BY bid;

select b.bid,a.authid,w.WorkYear,SUM(w.WorkHours*al.payrate)as "Total Hours" from WorkSession w 
inner join book b on w.bid = b.bid
inner join author a on w.authid = a.authid
inner join allocation al on w.authid = al.authid
group by b.bid, a.authid, w.WorkYear
order by bid, authid, WorkYear;


-- TASK 3

-- Dropping table WORKSESSION
Drop Table worksession;

-- Dropping table ALLOCATION
Drop Table allocation;

-- Dropping table BOOK
Drop Table book;

-- Dropping table AUTHOR
Drop Table author;