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
SELECT product,
       volume,
       date AS date_from,
	   LEAD(date, 1, '31.12.2999') OVER(PARTITION BY product) AS date_to
    FROM wh
	
	
----------------------------III------------------------------------	
SELECT DISTINCT user_id, http_id,
	CASE 
		WHEN abs_u_time = 0 OR abs_u_time > 1800 THEN click_time 
		ELSE LAG(click_time, cnt-1) OVER(PARTITION BY user_id, http_id)
	END session_start_time,
	CASE 
		WHEN (LEAD(abs_u_time, rev_cnt-1) OVER(PARTITION BY user_id, http_id)) > 1800 THEN click_time 
		ELSE LEAD(click_time, rev_cnt-1) OVER(PARTITION BY user_id, http_id)
	END session_end_time
	FROM
	(
		SELECT *,
			u_time - MIN(u_time) OVER(PARTITION BY user_id, http_id) AS abs_u_time,
			ROW_NUMBER() over(PARTITION BY user_id, http_id ORDER BY click_time DESC) AS rev_cnt
			FROM
			(
				SELECT *,
					ROW_NUMBER() over(PARTITION BY user_id, http_id) AS cnt,
					STRFTIME('%s', click_time) AS u_time
					FROM clicks
			)
			ORDER BY user_id, cnt
	)

	
	
	
	
	
	
	
	
	
