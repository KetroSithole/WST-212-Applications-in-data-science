# Surname, Name:SITHOLE   KETR0

# Packages:

library(sqldf)
library(lubridate)
library(RH2)
library(stringr)
library(readr)
library(rJava)
library(RJDBC)

# Data:

melody_album <- read_csv("melody_album.csv")
melody_album_category <- read_csv("melody_album_category.csv")
melody_album_price <- read_csv("melody_album_price.csv")
melody_album_type <- read_csv("melody_album_type.csv")
melody_branch <- read_csv("melody_branch.csv")
melody_customer <- read_csv("melody_customer.csv")
melody_employees <- read_csv("melody_employees.csv")
melody_invoice <- read_csv("melody_invoice.csv")
melody_invoice_line <- read_csv("melody_invoice_line.csv")
melody_stock_item <- read_csv("melody_stock_item.csv")

# Q1:
q1 <- sqldf("SELECT Branch_Name , Branch_Floor_Size , Branch_Phone , Branch_Contact_Name  , Branch_City
            FROM melody_branch
            WHERE Branch_City != 'Bellville' AND Branch_Floor_Size >75
            ORDER BY Branch_Name ")

# Q2:

melody_album$Album_runtime =as.character(melody_album$Album_runtime)
q2 <- sqldf("SELECT Album_Name,Album_Artist,Album_runtime
            FROM melody_album
            WHERE Album_Artist LIKE 'B%' or Album_Artist LIKE '%B' 
            ORDER BY Album_Artist" )

#Q3:
q3 <- sqldf("SELECT a.Album_Name , a.Album_Artist , b.Price_Amount , b.Price_Desc
            FROM melody_album AS a
            LEFT JOIN melody_album_price AS b
            ON a.Price_ID = b.Price_ID
            WHERE Album_Name = 'Purpose'")


# Q4:
q4<- sqldf("SELECT Album_Name, Album_Artist,Price_Amount
           FROM melody_album AS a
           LEFT JOIN  melody_album_price AS b
           on a.Price_ID=b.Price_ID
           WHERE Price_Amount=256
           ORDER BY Album_Name")


# Q5:
q5 <- sqldf("select Category_Desc, Album_Artist, Album_Name, Album_Year
            Price_Amount, Price_Desc, Price_Amount*0.85 as New_Price
            from melody_album as a
            inner join melody_album_price as p
            on a.Price_ID = p.Price_ID
            inner join melody_album_category as c
            on a. Category_Id = c.Category_ID
            order by New_Price")
# Q6:

q6<-sqldf("SELECT a.Customer_Acc_No,Customer_Surname,Customer_Name,sum(Purchase_Quantity*Item_Unit_Price) AS Total_Amount_Spent
          FROM melody_customer AS a
          INNER JOIN melody_invoice AS b
          ON a.Customer_Acc_No=b.Customer_Acc_No
          INNER JOIN melody_invoice_line AS C 
          ON c.Invoice_Num=b.Invoice_Num
          GROUP BY a.Customer_Acc_No
          ORDER BY Total_Amount_Spent")

# Q7:
q7<- sqldf("Select Employee_Acc_Num, Employee_Name, Employee_Surname,
            Employee_Phone, Employee_City
            From melody_employees
            intersect
            Select Customer_Acc_No, Customer_Name, Customer_Surname,
            Customer_Phone,Customer_City
            From melody_customer
            order by Employee_Surname")