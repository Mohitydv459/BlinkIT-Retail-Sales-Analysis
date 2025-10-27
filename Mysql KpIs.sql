use blinkit;
/*
create table blinkit_store(
Item_Fat_Content varchar(50),
Item_Identifier varchar(50),
Item_Type varchar(50),
Outlet_Establishment_Year int,
Outlet_Identifier varchar(50),
Outlet_Location_Type varchar(50),
Outlet_Size varchar(50),
Outlet_Type varchar(50),
Item_Visibility float,
Item_Weight float,
Total_Sales float,
Rating float,
outlet_Age int
);
*/

select*from blinkit_store;

-- 1. calculating total sales in million
SELECT CONCAT(ROUND(SUM(Total_Sales)/1000000,2),' Million') AS Total_Sales
FROM blinkit_store;

-- 2. Average revenue per sale 
SELECT ROUND(AVG(Total_Sales),2) AS Avg_Revenue
FROM blinkit_store;

-- 3. Total item sold by Item_Fat_Content
SELECT Item_Fat_Content,count(*)
FROM blinkit_store
GROUP BY Item_Fat_Content;

-- 4. Avg Rtaing by item_type
SELECT Item_Type,ROUND(AVG(Rating),1) AS Avg_Ratings
FROM blinkit_store
GROUP BY Item_Type;

-- 5. Total Revenue(sales), avg_sales, Avg_rating  by Fat_Content
SELECT Item_Fat_Content,
ROUND(sum(Total_Sales),2) AS Total_Revenue,
ROUND(avg(Total_Sales),2) AS Avg_sales,
ROUND(avg(Rating),1) AS Avg_Rating
FROM blinkit_store
GROUP BY Item_Fat_Content
ORDER BY Total_Revenue desc;

-- 6. Total Revenue(sales), avg_sales, Avg_rating by item type(Top 5)
SELECT Item_Type,
ROUND(sum(Total_Sales),2) AS Total_Revenue,
ROUND(AVG(Total_Sales),2) AS Avg_sales,
ROUND(AVG(Rating),1) AS Avg_Rating
FROM blinkit_store
GROUP BY Item_Type
ORDER BY Total_Revenue desc
LIMIT 5;

-- 7. Total Revenue of each Item_Fat_content by Outlet_location_type
SELECT
    Outlet_Location_Type,
    -- Calculated Low Fat Revenue
    ROUND(SUM(case when Item_Fat_Content = 'Low Fat' then Total_Sales else 0 end), 2) AS Low_Fat,
    -- Calculated Regular Revenue
    ROUND(SUM(case when Item_Fat_Content = 'Regular' then Total_Sales else 0 end), 2) AS Regular
FROM blinkit_store
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;

-- 8. Total sales by outlet_establishment
SELECT Outlet_Establishment_Year,
ROUND(SUM(Total_Sales),2) AS Total_Revenue
FROM blinkit_store
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year;

-- 9. Percenatge of sales by outlet_size
SELECT Outlet_Size,
ROUND(SUM(Total_Sales),2) AS Total_Revenue,
    ROUND(SUM(Total_Sales) / (SELECT SUM(Total_Sales) FROM blinkit_store) * 100, 2)  AS Sales_Percentage
FROM blinkit_store
GROUP BY Outlet_Size;

-- 10. Sales By outlet_location
SELECT Outlet_Location_Type,
ROUND(SUM(Total_Sales),2) AS Total_Revenue
FROM blinkit_store
GROUP BY Outlet_Location_Type;

-- 11. All Metrices By Outlet_Type
SELECT Outlet_Type,
ROUND(SUM(Total_Sales),2) AS Total_Revenue,
ROUND(AVG(Total_Sales),2) As Avg_Sales,
COUNT(*) AS No_of_Items,
ROUND(AVG(Rating),1) AS Avg_Ratings,
ROUND(AVG(Item_Visibility),2) AS Item_Visibility
FROM blinkit_store
GROUP BY Outlet_type;

-- 12. Sales and Rating by Outlet Age Group
SELECT
    CASE
        WHEN Outlet_Age <= 5 THEN 'New (1-5 yrs)'
        WHEN Outlet_Age <= 15 THEN 'Mid (6-15 yrs)'
        ELSE 'Mature (>15 yrs)'
    END AS Outlet_Age_Group,
    ROUND(SUM(Total_Sales), 2) AS Total_Revenue,
    ROUND(AVG(Total_Sales), 2) AS Avg_Transaction_Value,
    ROUND(AVG(Rating), 1) AS Avg_Rating
FROM blinkit_store
GROUP BY Outlet_Age_Group
ORDER BY Total_Revenue DESC;

-- 13. Top Item Type by Total Sales per Outlet Type
WITH Ranked_Item_Performance AS (
    SELECT
        Outlet_Type,
        Item_Type,
        ROUND(SUM(Total_Sales), 2) AS Total_Revenue,
        ROW_NUMBER() OVER (PARTITION BY Outlet_Type ORDER BY SUM(Total_Sales) DESC) AS Sales_Rank
    FROM blinkit_store
    GROUP BY Outlet_Type, Item_Type
)
SELECT Outlet_Type,
    Item_Type,
    Total_Revenue
FROM Ranked_Item_Performance
WHERE Sales_Rank = 1
ORDER BY Total_Revenue DESC;










CREATE VIEW V_Outlet_Performance AS
SELECT
    Outlet_Identifier,
    Outlet_Location_Type,
    Outlet_Size,
    Outlet_Type,
    Outlet_Establishment_Year,
    Outlet_Age,
    ROUND(SUM(Total_Sales), 2) AS Total_Revenue,
    ROUND(AVG(Total_Sales), 2) AS Avg_Transaction_Value,
    COUNT(Item_Identifier) AS No_of_Items_Sold,
    ROUND(AVG(Rating), 1) AS Avg_Ratings,
    ROUND(AVG(Item_Visibility), 4) AS Avg_Item_Visibility,
    -- Pivoted sales for Low Fat vs. Regular items
    ROUND(SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Total_Sales ELSE 0 END), 2) AS Low_Fat_Sales,
    ROUND(SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Total_Sales ELSE 0 END), 2) AS Regular_Sales
FROM
    blinkit_store
GROUP BY
    Outlet_Identifier,
    Outlet_Location_Type,
    Outlet_Size,
    Outlet_Type,
    Outlet_Establishment_Year,
    Outlet_Age;


CREATE VIEW V_Item_Performance AS
SELECT
    Item_Type,
    Item_Fat_Content,
    ROUND(SUM(Total_Sales), 2) AS Total_Revenue,
    ROUND(AVG(Total_Sales), 2) AS Avg_Sales,
    COUNT(Item_Identifier) AS No_of_Items_Sold,
    ROUND(AVG(Rating), 1) AS Avg_Rating
FROM blinkit_store
GROUP BY Item_Type,Item_Fat_Content;