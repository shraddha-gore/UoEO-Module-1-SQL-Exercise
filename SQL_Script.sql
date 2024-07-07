/* Use the default 'sys' schema */
USE sys;

/* Create 'DEPT' table and add records */
CREATE TABLE DEPT (
    DEPTNO INT PRIMARY KEY,
    DNAME VARCHAR(50),
    LOC VARCHAR(50)
);

INSERT INTO DEPT (DEPTNO, DNAME, LOC) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO');

/* Create 'EMP' table and add records */
CREATE TABLE EMP (
    EMPNO INT PRIMARY KEY,
    ENAME VARCHAR(50),
    JOB VARCHAR(50),
    MGR INT,
    HIREDATE VARCHAR(9),
    SAL INT,
    COMM INT,
    DEPTNO INT,
    FOREIGN KEY (DEPTNO)
        REFERENCES DEPT (DEPTNO)
);

INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES
(7369, 'SMITH', 'CLERK', 7902, '17-DEC-80', 800, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '20-FEB-81', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '22-FEB-81', 1250, 500, 30),
(7566, 'JONES', 'MANAGER', 7839, '02-APR-81', 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '28-SEP-81', 1250, 1400, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '01-MAY-81', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '09-JUN-81', 2450, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '19-APR-87', 3000, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '17-NOV-81', 5000, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '08-SEP-81', 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, '23-MAY-87', 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '03-DEC-81', 950, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '03-DEC-81', 3000, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '23-JAN-82', 1300, NULL, 10);


/* ----------------------------------------------------*/
/* --------------------- EXERCISE ---------------------*/
/* ----------------------------------------------------*/

/* 01. List all Employees whose salary is greater than 1,000 but not 2,000. Show the Employee Name, Department and Salary. */
-- Solution:
SELECT ENAME AS 'Employee Name', DNAME AS 'Department', SAL AS 'Salary'
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE SAL > 1000 AND SAL < 2000;

-- Alternative:
SELECT ENAME AS 'Employee Name', DNAME AS 'Department', SAL AS 'Salary'
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE SAL BETWEEN 1001 AND 1999;


/* 02. Count the number of people in department 30 who receive a salary and a commission. */
-- Solution:
SELECT COUNT(*) AS 'Number of Employees'
FROM EMP
WHERE DEPTNO = 30 AND SAL > 0 AND COMM > 0;

-- Alternative:
SELECT COUNT(*) AS 'Number of Employees'
FROM EMP
WHERE DEPTNO = 30 AND SAL >= 1 AND COMM >= 1;


/* 03. Find the name and salary of the employees that have a salary greater or equal to 1,000 and live in Dallas. */
-- Solution:
SELECT ENAME AS 'Employee Name', SAL AS 'Salary'
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE SAL >= 1000 AND LOC = 'DALLAS';

-- Alternative:
SELECT ENAME AS 'Employee Name', SAL AS 'Salary'
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE SAL > 999 AND LOC = 'DALLAS';


/* 04. Find all departments that do not have any current employees. */
-- Solution:
SELECT D.DEPTNO, D.DNAME
FROM DEPT D
LEFT JOIN EMP E ON D.DEPTNO = E.DEPTNO
WHERE E.EMPNO IS NULL;

-- Alternative:
SELECT DEPTNO, DNAME
FROM DEPT
WHERE DEPTNO NOT IN (SELECT DISTINCT DEPTNO FROM EMP);


/* 05. List the department number, the average salary, and the number/count of employees of each department. */
-- Solution:
SELECT DEPTNO, AVG(SAL) AS 'Average Salary', COUNT(*) AS 'Number of Employees'
FROM EMP
GROUP BY DEPTNO;

-- Alternative:
SELECT DEPTNO, AVG(SAL) AS 'Average Salary', COUNT(*) AS 'Number of Employees'
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) > 0;