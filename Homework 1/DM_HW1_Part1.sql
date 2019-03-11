SELECT * FROM syria.birthplace_info;




#Find the citizens who are alive and are willing to immigrate to another countries?

SELECT ci.alive, wi.willing 
FROM 
syria.citizens_info ci left join syria.willing_info wi ON ci.ssn=wi.ssn 
ORDER BY ci.alive DESC;


#Find Head of the Family

SELECT ssn 
FROM syria.citizens_info 
WHERE dependent_id='no';


#Find all the citizens whose head of the family died?

SELECT ssn, cname 
FROM 
syria.citizens_info 
WHERE dependent_id='no' AND alive='no';


#Find all the citizens whose name starts with ‘A’

SELECT * 
FROM 
syria.citizens_info 
WHERE cname LIKE 'A%' ;


#Select the top 10 citizens from the citizens_info?

SELECT *
FROM 
syria.citizens_info LIMIT 10;


#Find how many citizens are there in citizens_info table?

SELECT COUNT(ssn) 
FROM syria.citizens_info;

#Use the wildcards in the your quries

SELECT *
FROM 
syria.death_details 
WHERE 
cause_of_death LIKE 's%%g';


#Return all the citizens whose ssn is  not between 2 and 20?
SELECT *
FROM  
syria.citizens_info 
WHERE 
ssn NOT BETWEEN '2' AND '20';


#Find the citizen name=‘Ahin’ is dead or alive and if he is dead find the death_date?

SELECT date_of_death 
FROM 
syria.death_details dd
WHERE 
exists(SELECT ssn FROM syria.citizens_info ci WHERE ci.cname='Ahin' AND ci.ssn=dd.ssn);




