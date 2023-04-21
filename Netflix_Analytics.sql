-- In this code I was querying within a database containing Netflix data. This set of queries was made using PostgreSQL.

-- Total movie titles are there in the database, I excluded tv shows in this query
SELECT COUNT(*)
FROM "Database"."netflix_titles_info" titles
WHERE titles.type = 'Movie';

-- Recent batch of titles added to the database
SELECT MAX(date(date_added))
FROM "Database"."netflix_titles_info" titles;

-- Lists all the movies / tv shows in alphabetical order
SELECT title, type
FROM "Database"."netflix_titles_info" titles
ORDER BY title;

-- Displays the director for Squid Game
SELECT people.director
FROM "Database"."netflix_titles_info" titles
LEFT JOIN "Database"."netflix_people" people
ON people.show_id = titles.show_id
WHERE titles.title = 'Squid Game';

-- Pulls the oldest movie in the database and the year that it was made
SELECT title, release_year
FROM "Database"."netflix_titles_info" titles
ORDER BY release_year
LIMIT 1;
