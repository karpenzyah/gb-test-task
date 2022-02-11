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
SELECT *,
	CASE 
		WHEN abs_u_time = 0 or abs_u_time > 1800 THEN click_time 
		ELSE 0
	END session_start_time,
	CASE 
		WHEN abs_u_time > 0 and abs_u_time < 1800 THEN click_time 
		ELSE 0
	END session_end_time
	FROM (
SELECT *,
	u_time - MIN(u_time) OVER(PARTITION BY user_id, http_id) AS abs_u_time 
	FROM (
		SELECT *,
			STRFTIME('%s', click_time) AS u_time
			FROM clicks
			ORDER BY user_id, http_id
	)
)
	
	
	
	
	
	
	
	
	
	