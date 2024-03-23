-- getting the dim_movies

select
	id,
	homepage,
	original_language ,
	original_title ,
	overview ,
	tagline ,
	title
from
	movies m ;

-- getting the dim_genras

SELECT
	jt.id, jt.name
from
	movies m
CROSS join JSON_table(m.genres  , '$[*]' columns(id int path '$.id', name text path '$.name')) jt 
group by jt.id,jt.name order by jt.id;



-- creating dim_keywords

SELECT
	jt.id, jt.name
from
	movies m
CROSS join JSON_table(m.keywords  , '$[*]' columns(id int path '$.id', name text path '$.name')) jt 
group by jt.id,jt.name order by jt.id;


-- creating dim_production_companies

SELECT
	jt.id, jt.name
from
	movies m
CROSS join JSON_table(m.production_companies  , '$[*]' columns(id int path '$.id', name text path '$.name')) jt 
group by jt.id,jt.name order by jt.id;


-- creating dim_production_countires

SELECT
	jt.id, jt.name
from
	movies m
CROSS join JSON_table(m.production_countries  , '$[*]' columns(id char(2) path '$.iso_3166_1', name text path '$.name')) jt 
group by jt.id,jt.name order by jt.id;


-- creating dim_production_countires

SELECT
	jt.id, jt.name
from
	movies m
CROSS join JSON_table(m.spoken_languages  , '$[*]' columns(id text path '$.iso_639_1', name text path '$.name')) jt 
group by jt.id,jt.name order by jt.id;


-- creating dim_cast

select
	cast_jt.id,
	cast_jt.name,
	cast_jt.cast_order,
	cast_jt.gender,
	cast_jt.cast_id,
	cast_jt.cast_character,
	cast_jt.credit_id
from
	credits c
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

select
	cast_jt.id,
	cast_jt.name,
	cast_jt.gender,
	cast_jt.credit_id,
	cast_jt.job,
	cast_jt.department
from
	credits c
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


select
	m.id,
	budget ,
	m.popularity ,
	m.release_date ,
	m.revenue ,
	status ,
	vote_average ,
	vote_count ,
	runtime
from
	movies m left outer join credits c on m.id =c.movie_id  ;

