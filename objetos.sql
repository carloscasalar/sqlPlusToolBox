column object_name format a30
select object_type, object_name, status
from user_objects
where object_type not in ('TABLE','INDEX','SYNONYM','SEQUENCE')
order by object_type, object_name
/
