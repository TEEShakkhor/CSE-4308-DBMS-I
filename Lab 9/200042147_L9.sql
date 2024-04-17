1--
a--

SET SERVEROUTPUT ON SIZE 1000000
BEGIN
DBMS_OUTPUT . PUT_LINE ( '200042147');
END ;
/
b--

DECLARE
    NAME VARCHAR2 (20);
BEGIN
    NAME := '&name';
    DBMS_OUTPUT . PUT_LINE ( ' Length of my name is ' || Length(NAME));
END ;
/

c--

DECLARE
    NUM1 NUMBER(5);
    NUM2 NUMBER(5);
BEGIN
    NUM1 := '& first';
    NUM2 := '& second';
    DBMS_OUTPUT.PUT_LINE(' Sum : ' || (NUM1+NUM2));
END;
/
d--

DECLARE
D DATE := SYSDATE ;
BEGIN
DBMS_OUTPUT . PUT_LINE ( TO_CHAR (D, 'DD-MON-YY HH24:MI:SS '));
END ;
/

e--
without case--

DECLARE
X NUMBER ;
BEGIN
X := '&number';
IF (MOD(x, 2)) = 0 THEN
DBMS_OUTPUT . PUT_LINE ( 'EVEN');
ELSE
DBMS_OUTPUT . PUT_LINE ( 'ODD');
END IF;
END ;
/

WITH CASE--

DECLARE
X NUMBER(6);
BEGIN
X := '&number';
    CASE MOD(X, 2)
        WHEN 0 THEN
            DBMS_OUTPUT . PUT_LINE ( 'EVEN');
        WHEN 1 THEN
            DBMS_OUTPUT . PUT_LINE ( 'ODD');
        ELSE
            DBMS_OUTPUT . PUT_LINE ( 'NULL');    
    END CASE;
END ;
/

f--

CREATE OR REPLACE
PROCEDURE FIND_PRIME ( NUM IN NUMBER , RESULT OUT VARCHAR2 )
AS
BEGIN
    RESULT := 'Number is prime';
    FOR i IN 2 .. (NUM/2)
        LOOP
            IF MOD(NUM, i) = 0 THEN
                RESULT := 'Number is not prime';
                EXIT;
            END IF;
        END LOOP;

END;
/

DECLARE
    NUM NUMBER(5);
    VERIFY VARCHAR2(20);
BEGIN 
    NUM := '& number';
    FIND_PRIME(NUM,VERIFY);
    DBMS_OUTPUT . PUT_LINE (VERIFY);

END;
/

2--
a--
CREATE OR REPLACE
PROCEDURE FIND_RICH_BRANCH(NUM IN NUMBER)
AS
ROW NUMBER(3);
BEGIN
    SELECT MAX(ROWNUM) INTO ROW 
    FROM (SELECT * FROM BRANCH ORDER BY ASSETS DESC);

    IF(NUM>ROW) THEN 
        DBMS_OUTPUT . PUT_LINE ('ERROR');
        RETURN;
    END IF;

    FOR i IN (SELECT * FROM (SELECT * FROM BRANCH ORDER BY ASSETS DESC) WHERE ROWNUM<=NUM) LOOP
        DBMS_OUTPUT . PUT_LINE (i.BRANCH_NAME || ' ' || i.BRANCH_CITY || ' ' || i.ASSETS);
    END LOOP;

END;
/

DECLARE
    NUM NUMBER(3);
BEGIN 
    NUM := '& number';
    FIND_RICH_BRANCH(NUM);

END;
/

b--
CREATE OR REPLACE
PROCEDURE customer_status(name IN VARCHAR2)
AS
net_balance NUMBER;
net_loan NUMBER;
BEGIN
    SELECT MAX(account.balance) INTO net_balance 
    FROM depositor, account
    WHERE depositor.customer_name = name and depositor.account_number = account.account_number;

    SELECT MAX(loan.amount) INTO net_loan 
    FROM borrower, loan 
    WHERE borrower.customer_name = name and borrower.loan_number = loan.loan_number;

    IF((net_balance) > (net_loan)) THEN
        DBMS_OUTPUT.PUT_LINE('Red Zone');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Green Zone');
    END IF;
END;  
/

DECLARE
    name VARCHAR2(15);
BEGIN
    name := '& Customer_Name';
    customer_status(name);
END;
/

c--
CREATE OR REPLACE
FUNCTION customer_tax(name VARCHAR2)
RETURN NUMBER
AS
net_balance NUMBER;
tax NUMBER;
BEGIN
    SELECT MAX(account.balance) INTO net_balance 
    FROM depositor, account
    WHERE depositor.customer_name = name and depositor.account_number = account.account_number;

    IF((net_balance)>=750) THEN
        tax := (0.08*net_balance);
    ELSE
        tax := 0;
    END IF;

    RETURN tax;
END;
/

DECLARE
    name VARCHAR2(15);
BEGIN
    name := '& Customer_Name';
    
    DBMS_OUTPUT.PUT_LINE(customer_tax(name));
END;
/

d--
CREATE OR REPLACE
FUNCTION customer_category(name VARCHAR2)
RETURN VARCHAR2
AS
balance NUMBER;
loan NUMBER;
category VARCHAR2(10);

BEGIN
    SELECT MAX(account.balance) INTO balance 
    FROM depositor, account
    WHERE depositor.customer_name = name and depositor.account_number = account.account_number;

    SELECT MAX(loan.amount) INTO loan
    FROM borrower, loan 
    WHERE borrower.customer_name = name and borrower.loan_number = loan.loan_number;

    IF(((balance) > 1000) AND ((loan) < 1000)) THEN
        category := 'C-A1';
    ELSIF(((balance)<500) AND ((loan)>2000)) THEN
        category := 'C-C3';
    ELSE
        category :=' C-B1';
    END IF;
    RETURN category;
END;
/   


DECLARE
    name VARCHAR2(15);
BEGIN
    name := '& Customer_Name';
    DBMS_OUTPUT.PUT_LINE(customer_category(name));
END;
/
