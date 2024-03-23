select
	m.id,count(crew_jt.id)
from
	movies m
inner join credits c on
	c.movie_id = m.id
CROSS join JSON_table(c.crew , '$[*]' columns(id int path '$.id', name text path '$.name')) crew_jt
where
	vote_count / 100 >10
and m.budget >0
GROUP BY m.id