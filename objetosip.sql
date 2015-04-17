select object_type, object_name, status
from user_objects
where object_type in ('PACKAGE', 'PACKAGE BODY')
and object_type not like '%JAVA%'
and status='INVALID'
order by object_type, object_name
/
