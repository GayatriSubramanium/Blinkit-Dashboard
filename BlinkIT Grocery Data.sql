USE blinkitdb;
GO

SELECT * FROM BlinkIt_data

SELECT COUNT(*) FROM BlinkIt_data

UPDATE BlinkIt_data
SET Item_Fat_Content = 
CASE
WHEN Item_Fat_Content IN ('LF','low fat') THEN 'Low Fat'
WHEN Item_Fat_Content= 'reg' THEN 'Regular'
ELSE Item_Fat_Content
END

SELECT DISTINCT(Item_Fat_Content) FROM BlinkIt_data

SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
from BlinkIt_data
where Item_Fat_Content = 'Low Fat'


SELECT CAST(AVG(Sales)AS DECIMAL(10,0))AS Avg_Sales 
FROM BlinkIt_data
 
SELECT COUNT(*) AS No_Of_Items FROM BlinkIt_data
where Outlet_Establishment_Year = 2022

SELECT CAST(AVG(Rating)AS DECIMAL(10,2))AS Avg_Rating
from BlinkIt_data

SELECT 
    Item_Fat_Content, 
    CAST(SUM(Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_thousands,
    CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM BlinkIt_data
where Outlet_Establishment_Year = 2020
GROUP BY Item_Fat_Content
ORDER BY Total_Sales_thousands DESC;



SELECT 
    TOP 5 Item_Type, 
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM BlinkIt_data
WHERE Outlet_Establishment_Year = 2020
GROUP BY Item_Type
ORDER BY Total_Sales DESC;


SELECT 
    Outlet_Location_Type,
    ISNULL([Low Fat], 0) AS Low_Fat,
    ISNULL([Regular], 0) AS Regular
FROM
(
   SELECT 
       Outlet_Location_Type,
       Item_Fat_Content,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
   FROM BlinkIt_data
   GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT
(
   SUM(Total_Sales)
   FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;



SELECT 
    Outlet_Establishment_Year,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM BlinkIt_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year desc;


SELECT 
    Outlet_Size,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(
        100.0 * SUM(Sales) / (SELECT SUM(Sales) FROM BlinkIt_data)
        AS DECIMAL(5,2)
    ) AS Sales_Percentage
FROM BlinkIt_data
GROUP BY Outlet_Size
ORDER BY Sales_Percentage ;


SELECT 
    Outlet_Location_Type,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(
        100.0 * SUM(Sales) / (SELECT SUM(Sales) FROM BlinkIt_data)
        AS DECIMAL(5,2)
    ) AS Sales_Percentage,
    CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM BlinkIt_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

SELECT 
    Outlet_Identifier,
    Outlet_Location_Type,
    Outlet_Size,
    Outlet_Type,
    Outlet_Establishment_Year,
    
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(
        100.0 * SUM(Sales) / (SELECT SUM(Sales) FROM [dbo].[BlinkIt_data])
        AS DECIMAL(5,2)
    ) AS Sales_Percentage,
    
    CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating

FROM [dbo].[BlinkIt_data]
GROUP BY 
    Outlet_Identifier,
    Outlet_Location_Type,
    Outlet_Size,
    Outlet_Type,
    Outlet_Establishment_Year
ORDER BY Total_Sales DESC;

