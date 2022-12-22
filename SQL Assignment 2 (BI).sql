


create database superstores ;

use superstores ;

select * from cust_dimen ;
select * from market_fact ;
select * from orders_dimen ;
select * from prod_dimen ;
select * from shipping_dimen ;



/******* 1. To display the Customer_Name and Customer Segment using alias 
name “Customer Name", "Customer Segment" from table Cust_dimen *******/

select Customer_Name as 'Customer Name', Customer_Segment as 'Customer Segment' from cust_dimen ;


/******* 2. To find all the details of the customer from the table cust_dimen 
order by desc *******/

select * from cust_dimen order by Customer_Name desc ;


/******* 3. To get the Order ID, Order date from table orders_dimen where 
‘Order Priority’ is high *******/

select Order_ID, Order_Date from orders_dimen where Order_Priority = 'HIGH' ;


/******* 4. To find the total and the average sales (display total_sales and avg_sales) *******/

select sum(Sales) as total_sales, avg(Sales) as avg_sales from market_fact ;


/******* 5. To get the maximum and minimum sales from market_fact table *******/

select max(Sales) as maximum_sales, min(Sales) as minimum_sales from market_fact ;


/******* 6. To display the number of customers in each region in decreasing order of 
no_of_customers *******/

select Region, count(Cust_id) as no_of_customers from cust_dimen group by Region order by no_of_customers desc ;


/******* 7. To find the region having maximum customers (display the region name and 
max(no_of_customers) *******/

select Region, count(Cust_id) as no_of_customers from cust_dimen group by Region order by count(Cust_id) desc limit 1;


/******* 8. To find all the customers from Atlantic region who have ever purchased ‘TABLES’ 
and the number of tables purchased (display the customer name, no_of_tables 
purchased) *******/

select c.Customer_Name, count(m.Prod_id) as no_of_tables_purchased
from cust_dimen c
inner join 
market_fact m on c.Cust_id = m.Cust_id
inner join
prod_dimen p on m.Prod_id = p.Prod_id
where c.Region = 'ATLANTIC' and p.Product_Sub_Category = 'TABLES'
group by c.Customer_Name ;


/******* 9. To find all the customers from Ontario province who own Small Business. (display 
the customer name, no of small business owners) *******/

select Customer_Name, Customer_Segment as no_of_small_business_owners
from cust_dimen where Customer_Segment = 'SMALL BUSINESS' and Province = 'ONTARIO'  ;



/******* 10. To find the number and id of products sold in decreasing order of products sold 
(display product id, no_of_products sold) *******/

select Prod_id, sum(Order_Quantity) as no_of_products_sold 
from market_fact
group by Prod_id
order by no_of_products_sold desc ;


/******* 11. To display product Id and product sub category whose produt category belongs to 
Furniture and Technlogy. The result should contain columns product id, product 
sub category *******/

select Prod_id, Product_Sub_Category from prod_dimen where Product_Category in ('FURNITURE', 'TECHNOLOGY') ;


/******* 12. To display the product categories in descending order of profits (display the product 
category wise profits i.e. product_category, profits) *******/

select p.Product_Category, m.Profit
from prod_dimen p
inner join
market_fact m on p.Prod_id = m.Prod_id
order by m.Profit desc ;


/******* 13. To display the product category, product sub-category and the profit within each 
subcategory in three columns *******/

select p.Product_Category, p.Product_Sub_Category, m.Profit
from prod_dimen p
inner join
market_fact m on p.Prod_id = m.Prod_id
group by p.Product_Sub_Category ;


/******* 14. To display the order date, order quantity and the sales for the order *******/

select o.Order_Date, m.Order_Quantity, m.Sales 
from orders_dimen o
inner join
market_fact m on o.Ord_id = m.Ord_id ;


/******* 15. To display the names of the customers whose name contains the 
 i) Second letter as ‘R’
 ii) Fourth letter as ‘D’
*******/

select Customer_Name from cust_dimen where Customer_Name like '_R%' ;

select Customer_Name from cust_dimen where Customer_Name like '___D%' ;


/******* 16. To make a list with Cust_Id, Sales, Customer Name and 
their region where sales are between 1000 and 5000 *******/

select c.Cust_id, m.Sales, c.Customer_Name, c.Region
from cust_dimen c
inner join
market_fact m on c.Cust_id = m.Cust_id
where m.Sales between 1000 and 5000 ;


/******* 17. To find the 3rd highest sales *******/

select a.Sales from
(
select Sales,
dense_rank() over (order by Sales desc) as Rnk
FROM market_fact 
) a
where Rnk = 3 ; 


/******* 18. Where is the least profitable product subcategory shipped the most? For the least 
profitable product sub-category, display the region-wise no_of_shipments and the 
profit made in each region in decreasing order of profits (i.e. region, 
no_of_shipments, profit_in_each_region) *******/

select c.Region, count(m.Ship_id) as no_of_shipments, sum(m.Profit) as profit_in_each_region
from cust_dimen c
inner join 
market_fact m on c.Cust_id = m.Cust_id
inner join
prod_dimen p on m.Prod_id = p.Prod_id
where Product_Sub_Category =
(
   select p.Product_Sub_Category 
   from market_fact m
   inner join
   prod_dimen p on m.Prod_id = p.Prod_id
   group by Product_Sub_Category
   order by sum(m.Profit) limit 1
)
group by c.Region
order by sum(m.Profit) ;   



