column object_name format a30
select object_type, object_name, status
from user_objects
where object_type not in ('INDEX','SYNONYM','SEQUENCE')
and object_type not like '%JAVA%'
and status='INVALID'
order by object_type, object_name
/
