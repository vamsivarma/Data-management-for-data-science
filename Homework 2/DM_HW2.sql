
#Concepts to make use of, while building the queries

# Indexes - Done***
# Views - Done***
# Integrity constraints - NA - Need to check
# Query reformulation - Done***
# Schema restructuring - NA



#Queries to formulate - 

# 1.Using Single Column and Multi Column Indexes(single vs composite keys) - Done***

# 2.Making use of views - Done***

# 3.Analysis of Clustered vs Non-Clustered Indexes

# 4.Making use different types of indexes link Hash tables, R-tree indexes, bitmap indexes
#Useful reference for R-tree indexes - https://dev.mysql.com/doc/refman/5.5/en/create-index.html

# 5.Create Joins with INNER JOIN Rather than WHERE - Done***

# 6.When you have queries that have sub-selects, look to apply filtering to the inner statement of the sub-selects as opposed to the outer statements. - Done***

# 7.Remove OUTER Joins  - add a placeholder row in the customer table and update all NULL values in the sales table to the placeholder key.

# 8.Make use of temporary tables - In terms of efficiency, temporary tables are a good first choice as they have an associated histogram i.e. statistics. - Done***


# others

#Query only what is required in the select statement - Done***
#Formulate more stories by correlating the data available in different tables


#Queries start here...

#Summary of queries formulated
# 1. Query explaning that indexes are not always a viable soultion
# 2. Performance benifit of indexes
# 3. Query only what is required in the select statement
# 4. Analyzing Temparory tables vs Views
# 5. Create Joins with INNER JOIN Rather than WHERE - Query reformulation
# 6. When you have queries that have sub-selects, look to apply filtering to the inner statement of the sub-selects as opposed to the outer statements.
# 7. Single vs Composite keys indexes
# 8. Demonstation of R-tree vs Composite key indexes


################################ 1 ######################################
 
 #Top 10 users based on useful reviews   
 
 #Without Views and Indexes
 
 #Execution time - 54.96 seconds

 
SELECT u.name, TU.likes as useful_reviews
FROM
	(SELECT user_id, SUM(useful) as likes
		FROM yelp_db.review
		GROUP BY user_id
		ORDER BY 2 DESC
		LIMIT 10
	) TU JOIN yelp_db.user u 
WHERE TU.user_id = u.id;


#Using views

#Execution time - 50 seconds

CREATE VIEW top_users_on_useful_reviews
AS
    SELECT user_id, SUM(useful) as likes
    FROM yelp_db.review
    GROUP BY user_id
    ORDER BY 2 DESC
     LIMIT 10;

SELECT u.name, TU.likes as useful_reviews
FROM
yelp_db.top_users_on_useful_reviews TU JOIN yelp_db.user u 
WHERE TU.user_id = u.id;


#Using both Views and Indexes

# Execution time: 112.587 seconds

#Drop exisitng indexes
ALTER TABLE yelp_db.review DROP INDEX review_user_id_index;

# Execution time: 16.497 seconds
CREATE INDEX review_user_id_index ON yelp_db.review(user_id);

#Execution time: 70 seconds
#Indexing has a negative impact on query response time since the user_id in review table is not unique

SELECT u.name, TU.likes as useful_reviews
FROM
yelp_db.top_users_on_useful_reviews TU JOIN yelp_db.user u 
WHERE TU.user_id = u.id;

 
 
 ################################ 2 #########################################
 
 #Most popular users based on friends count  
 
 # With out indexes 

 CREATE VIEW popular_users
AS
    SELECT user_id, COUNT(user_id) as friend_count
    FROM yelp_db.friend
    GROUP BY user_id
    ORDER BY 2 DESC
    LIMIT 10;


CREATE VIEW user_id_to_name_map
AS
    SELECT id, name
    FROM  yelp_db.user
    ORDER BY name;
    
 
 #Execution time - 47.694 seconds

SELECT UM.name, PU.friend_count
FROM
yelp_db.popular_users PU JOIN yelp_db.user_id_to_name_map UM
WHERE PU.user_id = UM.id;


# With Indexes - 

#Drop exisitng indexes
ALTER TABLE yelp_db.user DROP INDEX user_id_index;
ALTER TABLE yelp_db.friend DROP INDEX friend_id_index;

# Execution time: 2.118 seconds
CREATE INDEX user_id_index ON yelp_db.user(id);
# Execution time: 112.587 seconds
CREATE INDEX friend_id_index ON yelp_db.friend(user_id);


#Execution time: 18 seconds
SELECT UM.name, PU.friend_count
FROM
yelp_db.popular_users PU JOIN yelp_db.user_id_to_name_map UM
WHERE PU.user_id = UM.id;


##################################### 3 ########################################

#Query only what is required in the select statement

# All columns in the table

#Execution time: 18 seconds
select * from yelp_db.review;

#Execution time: 23 seconds - id, user_id, friend_id
select * from yelp_db.friend;

#Execution time: 2.263 seconds - id, name,review_count, since, userful etc..,
select * from yelp_db.user;


# Only required columns 

#Execution time: 14 seconds
select user_id, useful from yelp_db.review;

#Execution time: 13 seconds
select user_id, friend_id from yelp_db.friend;


#Execution time: 0.546 seconds
select id,name from yelp_db.user;


##################################### 4 ########################################

# Analyzing Temparory tables vs Views

 #Top 10 users based on useful reviews   
 
 
 #Using Views
 
 #Execution time - 55.5 seconds

CREATE VIEW top_users_on_useful_reviews
AS
    SELECT user_id, SUM(useful) as likes
    FROM yelp_db.review
    GROUP BY user_id
    ORDER BY 2 DESC
     LIMIT 10;

SELECT u.name, TU.likes as useful_reviews
FROM
yelp_db.top_users_on_useful_reviews TU JOIN yelp_db.user u 
WHERE TU.user_id = u.id;


#Using Temparory tables
 
#Execution time - 50 seconds

DROP TEMPORARY TABLE IF EXISTS top_users_on_useful_reviews_table;

#Execution time - 56.299 seconds
CREATE TEMPORARY TABLE IF NOT EXISTS top_users_on_useful_reviews_table AS (
	SELECT user_id, SUM(useful) as likes
    FROM yelp_db.review
    GROUP BY user_id
    ORDER BY 2 DESC
     LIMIT 10);

#Execution time - 0 seconds
# Performance reasoning - In terms of efficiency, temporary tables are a good first choice as they have an associated histogram i.e. statistics.
SELECT u.name, TU.likes as useful_reviews
FROM
yelp_db.top_users_on_useful_reviews_table TU JOIN yelp_db.user u 
WHERE TU.user_id = u.id;


##################################### 5 ########################################


#Create Joins with INNER JOIN Rather than WHERE - Query reformulation


#0.72 seconds
SELECT b.name, c.category, b.city
FROM
yelp_db.business b JOIN yelp_db.category c
WHERE b.id = c.business_id;


#0.59 seconds
SELECT b.name, c.category, b.city
FROM
yelp_db.business b INNER JOIN yelp_db.category c
ON b.id = c.business_id;


##################################### 6 ###################################
#.When you have queries that have sub-selects, look to apply filtering to the inner statement of the sub-selects as opposed to the outer statements.

#Example 1

#0.758	
SELECT b.name, c.category
FROM
	(SELECT id,name,city 
		FROM yelp_db.business
	) b JOIN yelp_db.category c 
WHERE b.id = c.business_id AND b.city = 'Bedford';    


#0.711
SELECT b.name, c.category
FROM
	(SELECT id,name,city 
		FROM yelp_db.business
        WHERE city = 'Bedford'
	) b JOIN yelp_db.category c 
WHERE b.id = c.business_id;   


#Example 2
    
 #56 s   
SELECT u.name, TU.likes as useful_reviews
FROM
	(SELECT user_id, SUM(useful) as likes
		FROM yelp_db.review
		GROUP BY user_id
		ORDER BY 2 DESC
		LIMIT 10
	) TU JOIN yelp_db.user u 
WHERE TU.user_id = u.id;

#167.417 s
SELECT u.name, SUM(useful)
FROM
	(SELECT user_id, useful as likes
		FROM yelp_db.review
	) TU JOIN yelp_db.user u 
WHERE TU.user_id = u.id
GROUP BY user_id
ORDER BY 2 DESC
LIMIT 10;


#################################### 7 ####################################
#Using combination of single and composite key indexes

#Find users who have given more reviews based on business category

/* 
SELECT c.category, u.name, COUNT(r.user_id)
FROM yelp_db.category c  JOIN  yelp_db.review r JOIN yelp_db.user u
WHERE c.business_id = r.business_id AND r.user_id = u.id
GROUP BY c.category, r.user_id
ORDER BY 3 DESC; 
*/


#without indexes
#7.6 s
ALTER TABLE yelp_db.review DROP INDEX review_business_id_index;
ALTER TABLE yelp_db.review DROP INDEX review_business_id_user_id_index;

SELECT id 
FROM yelp_db.review 
WHERE business_id = 'TFd5t6QXqzZzAjVNXQCypA' AND user_id = '7u9HymKeOteWRx-NMBlALw';



#Using single key indexes
ALTER TABLE yelp_db.review DROP INDEX review_business_id_user_id_index;
ALTER TABLE yelp_db.review DROP INDEX review_business_id_index;

# Execution time: 13 s
CREATE INDEX review_business_id_index ON yelp_db.review(business_id);

#0.015 s
SELECT id 
FROM yelp_db.review 
WHERE business_id = 'TFd5t6QXqzZzAjVNXQCypA' AND user_id = '7u9HymKeOteWRx-NMBlALw';


#Using composite key indexes
ALTER TABLE yelp_db.review DROP INDEX review_business_id_index;
ALTER TABLE yelp_db.review DROP INDEX review_business_id_user_id_index;

# Execution time: 16 s
CREATE INDEX review_business_id_user_id_index ON yelp_db.review(business_id, user_id);

# 0.00040 s
SELECT id 
FROM yelp_db.review 
WHERE business_id = 'TFd5t6QXqzZzAjVNXQCypA' AND user_id = '7u9HymKeOteWRx-NMBlALw';




#################################### 8 ####################################
#r-tree vs composite-key indexes

#Pushing existing data in to geospatial table
#Preparing geospatial geometric data

INSERT INTO yelp_db.geospatial(latitude, longitude, coordinates)
SELECT latitude, longitude, Point(latitude, longitude)
FROM yelp_db.business WHERE latitude IS NOT NULL AND longitude IS NOT NULL;


#With out indexes
ALTER TABLE yelp_db.geospatial DROP INDEX geospatial_btree;

#0.782 s - 1740 results
SELECT id 
FROM yelp_db.geospatial
WHERE latitude = 36.169700622558594 AND longitude = -115.1240005493164
ORDER BY id ASC;

#With B-tree composite key indexes

ALTER TABLE yelp_db.geospatial DROP INDEX geospatial_btree;

#5.869 s
CREATE INDEX geospatial_btree ON yelp_db.geospatial(latitude, longitude);


#0.754 s - 1740 results
SELECT id 
FROM yelp_db.geospatial
WHERE latitude = 36.169700622558594 AND longitude = -115.1240005493164
ORDER BY id ASC;


#With Spatial indexes

ALTER TABLE yelp_db.geospatial DROP INDEX geospatial_btree;

#28.3 s
CREATE SPATIAL INDEX geospatial_rtree ON yelp_db.geospatial(coordinates);


#0.018 s - 1740 results
SELECT id
FROM yelp_db.geospatial
WHERE MBRWithin(coordinates,POINT(36.169700622558594, -115.1240005493164))
ORDER BY id ASC;











