select
	geners_jt.name,
	max(popularity) as popularity 
from
	movies m
cross join json_table(m.genres, '$[*]' columns(id int path '$.id', name varchar(255) path '$.name')) geners_jt
group by geners_jt.name
order by popularity desc
;
