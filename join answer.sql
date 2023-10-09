** How to import your data. **

--1. In PgAdmin, right click on Databases (under Servers -> Postgresql 15). Hover over Create, then click Database.
ANS --
SELECT film_title,release_year,worldwide_gross
  FROM specs
  INNER JOIN revenue
  USING(movie_id)
  ORDER BY worldwide_gross asc;
  
2. Enter in the name ‘Joins’ (not the apostrophes). Click Save.

3. Left click the server ‘Joins’. Left click Schemas. 

4. Right click public and select Restore.

5. Select the folder icon in the filename row. Navigate to the data folder of your repo and select the file movies.backup. Click Restore.


** Movie Database project. See the file movies_erd for table\column info. **

--1. Give the name, release year, and worldwide gross of the lowest grossing movie.

  SELECT film_title,release_year,worldwide_gross
  FROM specs
  INNER JOIN revenue
  USING(movie_id)
  ORDER BY worldwide_gross asc;
   
  
  

--2. What year has the highest average imdb rating?

  SELECT s.release_year,AVG(r.imdb_rating) AS avg_rating
  FROM specs s
  INNER JOIN rating r
  USING (movie_id)
  GROUP BY s.release_year
  ORDER BY avg_rating DESC;
  
  ANS '1991' avg_rating 7.45
  
  
  
  
  
  
  
  
 
--3. What is the highest grossing G-rated movie? Which company distributed it?

   SELECT film_title,mpaa_rating,worldwide_gross
  FROM specs
   INNER JOIN revenue
   USING(movie_id)
   WHERE mpaa_rating='G';
   
   ans 'Toy story 4'
   
   
   
   
   
   
   
   
   SELECT film_title,mpaa_rating,company_name
    FROM specs
	INNER JOIN distributors
	ON specs.domestic_distributor_id=distributors.distributor_id
	WHERE film_title='Toy Story 4';
	
	
	 
	 ANS company_name 'Walt Disney'
	 
	
	
	
   
   
  



     
  

4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

-- ANS

    SELECT company_name,COUNT(movie_id)AS count_movie
	 FROM distributors d
	 Left join specs s
	 ON s.domestic_distributor_id=d.distributor_id
	  GROUP BY company_name;
	  
	  
	  
	

--5. Write a query that returns the five distributors with the highest average movie budget.

---ANS

    SELECT d.company_name,AVG(film_budget) AS AVG_budget
	FROM revenue  r
	INNER JOIN specs s
	ON s.movie_id=r.movie_id	
	INNER JOIN distributors d
	ON d.distributor_id=s.domestic_distributor_id
	GROUP BY d.company_name
	ORDER BY AVG_budget DESC
	LIMIT 5;
	
	

--6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?


    SELECT COUNT(film_title) AS count_movie,s.film_title,d.headquarters,r.imdb_rating
	from rating r
	LEFT JOIN specs s
	ON r.movie_id=s.movie_id
	LEFT JOIN distributors d
	ON s.domestic_distributor_id=d.distributor_id
	WHERE headquarters NOT LIKE '%CA%'
	GROUP BY film_title,headquarters,imdb_rating
	ORDER BY imdb_rating DESC;
	
	how many movies 
	ans '2'
	
	which movies highest imdb_rating
	ANS 'dirty dancing'
	
	

	
	
	


--7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
--
     SELECT
    CASE 
	WHEN length_in_min>120 THEN 'OVER TWO HOURS'
	ELSE 'UNDER TWO HOURS'
	END,
	AVG(imdb_rating) AS average_rating
	FROM specs s
	INNER JOIN rating r
	USING(movie_id)
	GROUP BY 
	CASE
	WHEN s.length_in_min>120 THEN 'OVER TWO HOURS'
	ELSE 'UNDER TWO HOURS'
	END
	ORDER BY
	average_rating DESC;
	
	
--ANS 'over two hors movie'	  
	
       
     
	   
       

