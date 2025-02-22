SELECT * FROM ai_tool_analysis.ai_tool_usage;

-- Find the Most Popular AI Tool (Total Queries) --

 select ai_tool_name , sum(queries_made) AS Total_Queries
 from ai_tool_usage
 group by ai_tool_name
 order by Total_Queries desc;

-- Find the AI Tool with the Fastest Response Time --
 
 select ai_tool_name , max(avg_response_time) AS Fastest_Response_Time
 from ai_tool_usage
 group by ai_tool_name
 order by Fastest_Response_Time DESC;
 
 -- Count Total Users Who Used Each AI Tool --
 
 select ai_tool_name , count(distinct user_id) AS Total_Usage 
 from ai_tool_usage
 group by ai_tool_name;
 
 -- Find Users Who Have Made More Than 30 Queries from highest to lowest --
  
select user_id , ai_tool_name, queries_made
from ai_tool_usage
where queries_made >= 30;

-- Find AI Tools Used in February 2024 --
 
 SELECT DISTINCT ai_tool_name
FROM ai_tool_usage
WHERE usage_date BETWEEN '01-02-2024' AND '29-02-2024';

-- Find the Highest Rated AI Tool --
select ai_tool_name , max(rating) AS Highest_Rated_Tool
from ai_tool_usage
group by ai_tool_name
order by Highest_Rated_Tool
limit 1;

-- Show Average Queries Made by Subscription Type  --
select subscription_type , avg(queries_made) AS Avg_Queries_Sub
from ai_tool_usage
group by subscription_type;

-- Find AI Tool Popularity by Subscription Type --

 select  ai_tool_name , max(distinct rating) As Popularity , subscription_type 
 from ai_tool_usage
 group by ai_tool_name, subscription_type
 order by Popularity desc;
 
 -- Find AI Tools with More Than 20 Queries (Using HAVING) --
select ai_tool_name , queries_made
from ai_tool_usage
having queries_made >= 20;

-- Show AI Tool Usage Trends Over Time (Using DATE Functions) --

SELECT ai_tool_name, DATE(usage_date) AS usage_day, SUM(queries_made) AS total_queries
FROM ai_tool_usage
GROUP BY ai_tool_name, usage_day
ORDER BY usage_day DESC;

-- Find Single User Who Rated AI Tools 5  (Using IN) --
select ai_tool_name , user_id , rating 
from ai_tool_usage
where rating in (5)
limit 1; 

-- Show AI Tools Used by Free Users (Using JOINS) --
SELECT u.user_name, a.ai_tool_name, a.queries_made
FROM ai_tool_usage a
JOIN users u ON a.user_id = u.user_id
WHERE u.subscription_type = 'Free';

-- Find Top 3 AI Tools with the Most Users (Using LIMIT) --
select ai_tool_name , count(user_id) AS Max_users
from ai_tool_usage
group by ai_tool_name
order by MAX_users desc
limit 3;

-- Use CTE (Common Table Expression) to Find AI Tool with the Highest Engagement --
 
 with Highest_Engagement as (
 select  ai_tool_name , max(rating) AS Highest_Rating 
 from ai_tool_usage 
 group by ai_tool_name
 )
 select ai_tool_name , Highest_Rating
 from Highest_Engagement 
 limit 1;
