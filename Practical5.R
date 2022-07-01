#Practical 5

#Name and surname: KETRO SITHOLE 

#Student number: 


library(sqldf)
library(readr)
library(lubridate)
library(RH2)
library(stringr)
library(rJava)
library(RJDBC)

orion_employee_payroll <- read_csv("orion_employee_payroll.csv")
orion_staff <- read_csv("orion_staff.csv")
orion_employee_donations <- read_csv("orion_employee_donations.csv")
orion_employee_addresses <- read_csv("orion_employee_addresses2.csv")
orion_order_fact <- read_csv("orion_order_fact.csv")
orion_customer <- read_csv("orion_customer.csv")
orion_customer_type <- read_csv("orion_customer_type.csv")
orion_sales <- read_csv("orion_sales.csv")
orion_employee_organisation <- read_csv("orion_employee_organisation.csv")


# Question 1

q1a <- sqldf("SELECT Employee_ID
             FROM orion_employee_payroll
             WHERE month(Employee_Hire_Date) =3")


q1b <- sqldf("SELECT Employee_ID , FirstName ,LastName
             FROM orion_employee_addresses
             WHERE Employee_ID IN (SELECT Employee_ID
             FROM orion_employee_payroll
             WHERE month(Employee_Hire_Date) =3)
             ORDER BY LastName")

# Question 2

orion_staff$Birth_Date <- as.Date(orion_staff$Birth_Date , format ="%Y/%m/%d")

inner <- sqldf("SELECT Employee_ID , Job_title ,Birth_Date , 2013 -year(Birth_Date) AS Age
               FROM orion_staff
               WHERE Job_Title IS 'Purchasing Agent III' ")


q2 <- sqldf("SELECT Employee_ID , Job_title ,Birth_Date ,(2013 - year(Birth_Date)) AS Age
            FROM orion_staff
            WHERE Job_title IN ('Purchasing Agent I' , 'Purchasing Agent II')
            AND Birth_Date < ALL(SELECT Birth_Date
                FROM orion_staff
                WHERE Job_Title IS ' Purchasing Agent III')")

q2 <- sqldf("SELECT Employee_ID , Job_title ,Birth_Date ,(2013 -year(Birth_Date)) AS Age
            FROM orion_staff
            WHERE Job_title IN ('Purchasing Agent I' , 'Purchasing Agent II')
            AND Birth_Date <  ALL( SELECT Birth_Date
                FROM orion_staff
                WHERE Job_Title IS 'Purchasing Agent III')")





# Question 3

inner <-  sqldf("SELECT a.Customer_ID
                FROM orion_customer AS a
                INNER JOIN orion_customer_type AS b
                ON a.Customer_Type_ID = b.Customer_Type_ID
                WHERE a.Customer_Type_ID ='1020' OR a.Customer_Type_ID = '2010'")

q3 <- sqldf("SELECT Customer_ID , Max(Order_placed) AS order_Date
            FROM orion_order_fact
            WHERE Customer_ID IN (SELECT a.Customer_ID
                  FROM orion_customer AS a
                  INNER JOIN orion_customer_type AS b
                  ON a.Customer_Type_ID ='1020') AND Order_placed < '2012-01-01'
            GROUP BY Customer_ID")


# Question 4

q4a <- sqldf("SELECT a.Department,SUM(b.Salary) AS Department_sal_tota
             FROM orion_employee_organisation AS a
             INNER JOIN orion_employee_payroll AS b
             ON a.Employee_ID = b.Employee_ID
             GROUP BY a.Department")

q4b <- sqldf("SELECT a.Employee_ID , a.FirstName , a.LastName , b.Department
             FROM orion_employee_addresses as a
             INNER JOIN orion_employee_organisation AS b
             ON a.Employee_ID = b.Employee_ID")

q4c <-sqldf("SELECT d.Department , d.FirstName , d.LastName ,Salary , Salary/(Dept_sal) AS Percent
            FROM orion_employee_payroll AS a
            LEFT JOIN(SELECT c.Employee_ID , FirstName , LastName , Department FROM orion_employee_addresses AS c

INNER JOIN orion_employee_organisation AS b ON c.Employee_ID = b.Employee_ID) AS d
            ON a.Employee_ID = d.Employee_ID
            LEFT JOIN(SELECT Department ,SUM(Salary) AS  Dept_sal FROM orion_employee_payroll as k
INNER JOIN orion_employee_organisation AS b ON k.Employee_ID = b.Employee_ID GROUP BY Department) AS f
            ON d.Department = f.Department
            ORDER BY Department , Percent DESC
            
            ")


