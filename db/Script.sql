-----------------------------I-------------------------------------
-- Журнал вида ФИО, предмет, оценка.
-- 1. Вывести ФИО учеников, у которых только тройки: а) с подзапросом, б) без подзапроса.
-- 2. Вывести ФИО, предмет, оценку, средний балл ученика по предмету и общий средний балл
-- ученика, используя оконные функции.
-- 3. Вывести ФИО и количество двоек для учеников, у которых 10 и больше пятерок

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
-- Дана таблица wh:
--	product volume date
--	Наушники 5 16.07.2021
--	Телефон 5 17.07.2021
--	Наушники 2 19.07.2021
--	...
--
-- Написать запрос для преобразования в таблицу вида:
--	product volume date_from date_to
--
-- , т.е
--	product volume date_from date_to
--	Наушники 5 16.07.2021 19.07.2021
--	Наушники 2 19.07.2021 31.12.2999

SELECT product,
       volume,
       date AS date_from,
	   LEAD(date, 1, '31.12.2999') OVER(PARTITION BY product) AS date_to
    FROM wh
	
	
----------------------------III------------------------------------
-- Дана таблица clicks с полями:
--	user_id - идентификатор пользователя
--	http_id - идентификатор сайта
--	click_time - timestamp с временем клика на сайте
--
-- Сессией считаются все клики пользователя в пределах одного сайта,
-- временной промежуток между которыми не более 30 минут.
-- Необходимо написать запрос, который трансформирует клики пользователей в сессии, т.е. в таблицу вида:
-- user_id, http_id, session_start_time, session_end_time

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

	
	
	
	
	
	
	
	
	
