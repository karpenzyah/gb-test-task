-----------------------------I-------------------------------------

--  I. 1. a)
SELECT name
	FROM journal 
	WHERE name NOT IN
	(
		SELECT DISTINCT name
			FROM journal
			WHERE mark <> 3
	)
	ORDER BY name 

--  I. 1. b)
SELECT name
	FROM journal
	GROUP BY name
	HAVING COUNT(name)<2 and mark = 3
	ORDER BY name 


-- I. 2.
SELECT *,
	AVG(mark) OVER(PARTITION BY subject, name) AS avg_subj_mark,
	AVG(mark) OVER(PARTITION BY name) AS avg_gen_mark 
	FROM journal
	ORDER BY name 
	
	
-- I. 3.
SELECT DISTINCT name,
	COUNT(mark) OVER(PARTITION BY mark) AS mk2
	FROM 
	(
		SELECT *,
			COUNT(mark) OVER(PARTITION BY name) AS mk
			FROM journal
	)
	WHERE mk > 10 AND mark = 2	
	
	
	
-----------------------------II------------------------------------	
	
	
	
----------------------------III------------------------------------	
	
SELECT 
	
	
	
	
	
	
	
	
	
	