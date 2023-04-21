/*
	This is a simple project that takes celebrities and the movies they worked on and creates a network, connecting actors through 	movies, It started as a observation that actors Ryan Reynolds and Chris Pratt have never starred in a movie together, so through 	creating a SQL chain I connected them through other actors and actresses. For an added challenge I added additional criteria, adding 	Jack black to the chain, splitting the chain and adding Jojo rabbit, one of my favorite movies, to the mix. 

	Then I wrote a JOIN query to show the realtionship between stars and costars and their respective movies.
*/ 

CREATE TABLE celebrities (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    age INTEGER,
    act_start INTEGER
);

CREATE TABLE movies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    release_year INTEGER
);

CREATE TABLE costar (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    costar1_id INTEGER,
    costar2_id INTEGER,
    movie_id INTEGER
);

INSERT INTO celebrities (name, age, act_start)
Values 
    ("Chris Pratt", 43, 2000), --Ending Star
    ("Ryan Rynolds", 46, 1991), --Starting Star
    ("John Krasinski", 43, 2002),
    ("Amy Poehler", 51, 1999),
    ("Will Ferrel", 51, 1995),
    ("Taika Waititi", 47, 2007),
    ("Scarlett Johansson", 38, 1994),
    ("Nick Offerman", 52, 1994),
    ("Emily Blunt", 40, 2001),
    ("Jack Black", 53, 1982);
    
INSERT INTO movies (name, release_year)
Values 
    ("Free Guy", 2021),
    ("Shrek 3", 2007),
    ("Lego Movie", 2014),
    ("Blades of Glory", 2007),
    ("Jojo Rabbit", 2019),
    ("SING", 2016),
    ("Quiet Place", 2018),
    ("The Muppets", 2011),
    ("Anchorman", 2004);
    
INSERT INTO costar (costar1_id, costar2_id, movie_id)
Values 
    (2, 3, 1),
    (3, 4, 2),
    (4, 5, 4),
    (1, 5, 3),
    (2, 6, 1),
    (6, 7, 5),
    (7, 8, 6),
    (1, 8, 3),
    (3, 9, 7),
    (9, 10, 8),
    (5, 10, 9);

SELECT star1.name AS star_1, star2.name AS star_2, movie.name AS movie from costar
    JOIN celebrities star1
    ON costar.costar1_id = star1.id
    JOIN celebrities star2
    ON costar.costar2_id = star2.id
    JOIN movies movie
    ON costar.movie_id = movie.id;
