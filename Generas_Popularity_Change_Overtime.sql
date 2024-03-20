select
	geners_jt.name,STR_TO_DATE(release_date , '%Y-%m-%d') as release_date ,
	SUM(popularity)
from
	movies m
cross join json_table(m.genres, '$[*]' columns(id int path '$.id', name varchar(255) path '$.name')) geners_jt
group by geners_jt.name,STR_TO_DATE(release_date , '%Y-%m-%d') 
order by geners_jt.name,STR_TO_DATE(release_date , '%Y-%m-%d')
;
