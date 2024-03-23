select
	cast_jt.id,
	cast_jt.name,
	SUM(DISTINCT m.revenue) as total_rev
from
	movies m
left outer join credits c on
	m.id = c.movie_id
CROSS join JSON_table(c.`cast`, '$[*]' columns(id int path '$.id', name text path '$.name',
cast_order int path '$.order' ,
gender int path '$.gender' ,
cast_id int path '$.cast_id',
cast_character text path '$.character',
credit_id text path '$.credit_id'
)) cast_jt
group by
	cast_jt.id,
	cast_jt.name
order by
	total_rev desc
;