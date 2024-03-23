-- getting the dim_movies
CREATE TABLE dim_movies (
    id INT,
    homepage VARCHAR(255),
    original_language VARCHAR(50),
    original_title VARCHAR(255),
    overview TEXT,
    tagline TEXT,
    title VARCHAR(255)
);


insert into dim_movies select
	id,
	homepage,
	original_language ,
	original_title ,
	overview ,
	tagline ,
	title
from
	TMDb.movies m ;

-- getting the dim_genras
CREATE TABLE dim_genres (
    id INT,
    name VARCHAR(255)
);

insert into dim_genres SELECT
	jt.id, jt.name
from
	TMDb.movies m
CROSS join JSON_table(m.genres  , '$[*]' columns(id int path '$.id', name text path '$.name')) jt 
group by jt.id,jt.name order by jt.id;



-- creating dim_keywords
CREATE TABLE dim_keywords (
    id INT,
    name VARCHAR(255)
);

insert into dim_keywords SELECT
	jt.id, jt.name
from
	TMDb.movies m
CROSS join JSON_table(m.keywords  , '$[*]' columns(id int path '$.id', name text path '$.name')) jt 
group by jt.id,jt.name order by jt.id;


-- creating dim_production_companies
CREATE TABLE dim_production_companies (
    id INT,
    name VARCHAR(255)
);

insert into dim_production_companies SELECT
	jt.id, jt.name
from
	TMDb.movies m
CROSS join JSON_table(m.production_companies  , '$[*]' columns(id int path '$.id', name text path '$.name')) jt 
group by jt.id,jt.name order by jt.id;


-- creating dim_production_countires

CREATE TABLE dim_production_countries (
    id INT,
    name VARCHAR(255)
);

insert into dim_production_countries SELECT
	jt.id, jt.name
from
	TMDb.movies m
CROSS join JSON_table(m.production_countries  , '$[*]' columns(id char(2) path '$.iso_3166_1', name text path '$.name')) jt 
group by jt.id,jt.name order by jt.id;


-- creating dim_spoken_languages

CREATE TABLE dim_spoken_languages (
    id INT,
    name VARCHAR(255)
);

insert into dim_spoken_languages SELECT
	jt.id, jt.name
from
	TMDb.movies m
CROSS join JSON_table(m.spoken_languages  , '$[*]' columns(id text path '$.iso_639_1', name text path '$.name')) jt 
group by jt.id,jt.name order by jt.id;


-- creating dim_cast
CREATE TABLE dim_cast (
    id INT,
    name TEXT,
    cast_order INT,
    gender INT,
    cast_id INT,
    cast_character TEXT,
    credit_id TEXT
);


select
	cast_jt.id,
	cast_jt.name,
	cast_jt.cast_order,
	cast_jt.gender,
	cast_jt.cast_id,
	cast_jt.cast_character,
	cast_jt.credit_id
from
	TMDb.credits c
CROSS join JSON_table(c.`cast`, '$[*]' columns(
id int path '$.id',
name text path '$.name',
cast_order int path '$.order' ,
gender int path '$.gender' ,
cast_id int path '$.cast_id',
cast_character text path '$.character',
credit_id text path '$.credit_id'
)) cast_jt
group by
	cast_jt.id,
	cast_jt.name,
	cast_jt.cast_order,
	cast_jt.gender,
	cast_jt.cast_id,
	cast_jt.cast_character,
	cast_jt.credit_id
;





-- create dim_crew
CREATE TABLE dim_crew (
    id INT,
    name TEXT,
    gender INT,
    credit_id TEXT,
    job TEXT,
    department TEXT
);

INSERT into dim_crew
select
	cast_jt.id,
	cast_jt.name,
	cast_jt.gender,
	cast_jt.credit_id,
	cast_jt.job,
	cast_jt.department
from
	TMDb.credits c
CROSS join JSON_table(c.crew , '$[*]' columns(
id int path '$.id',
name text path '$.name',
department text path '$.department',
job text path '$.job',
gender int path '$.gender' ,
credit_id text path '$.credit_id'
)) cast_jt
group by
	cast_jt.id,
	cast_jt.name,
	cast_jt.gender,
	cast_jt.credit_id,
	cast_jt.job,
	cast_jt.department
	
;

-- crerating fct
CREATE TABLE fct_movies_statistics (
    id INT,
    release_date DATE,
    status VARCHAR(255),
    genres_id INT,
    keywords_id INT,
    production_companies_id INT,
    spoken_languages_id TEXT,
    production_countries_id CHAR(2),
    cast_credit_id TEXT,
    crew_credit_id TEXT,
    budget DECIMAL(15, 2),
    popularity DECIMAL(15, 2),
    revenue DECIMAL(15, 2),
    vote_average DECIMAL(5, 2),
    vote_count INT,
    runtime INT
);

INSERT
	into
	fct_movies_statistics
select
	m.id,
	m.release_date ,
	m.status ,
	genres_jt.id as genres_id,
	keywords_jt.id as keywords_id,
	production_companies_jt.id as production_companies_id,
	spoken_languages_jt.id as spoken_languages_id,
	production_countries_jt.id as production_countries_id,
	cast_jt.credit_id as cast_credit_id,
	crew_jt.credit_id as crew_credit_id,
	m.budget ,
	m.popularity ,	
	m.revenue ,	
	m.vote_average ,
	m.vote_count ,
	m.runtime
from
	TMDb.movies m
left outer join TMDb.credits c on
	m.id = c.movie_id
CROSS join JSON_table(m.genres , '$[*]' columns(id int path '$.id', name text path '$.name')) genres_jt
CROSS join JSON_table(m.keywords , '$[*]' columns(id int path '$.id', name text path '$.name')) keywords_jt
CROSS join JSON_table(m.production_companies , '$[*]' columns(id int path '$.id', name text path '$.name')) production_companies_jt
CROSS join JSON_table(m.production_countries , '$[*]' columns(id char(2) path '$.iso_3166_1', name text path '$.name')) production_countries_jt
CROSS join JSON_table(m.spoken_languages , '$[*]' columns(id text path '$.iso_639_1', name text path '$.name')) spoken_languages_jt
CROSS join JSON_table(c.`cast`, '$[*]' columns(
id int path '$.id',
name text path '$.name',
cast_order int path '$.order' ,
gender int path '$.gender' ,
cast_id int path '$.cast_id',
cast_character text path '$.character',
credit_id text path '$.credit_id'
)) cast_jt
CROSS join JSON_table(c.crew , '$[*]' columns(
id int path '$.id',
name text path '$.name',
department text path '$.department',
job text path '$.job',
gender int path '$.gender' ,
credit_id text path '$.credit_id'
)) crew_jt
 ;

