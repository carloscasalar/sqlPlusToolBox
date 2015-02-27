set heading off
select 'PROMPT COMPILANDO ' || object_name  || CHR(10) || 
       'alter ' || REPLACE( object_type, 'BODY', ' ') || ' ' || object_name || ' compile;'
from user_objects
where status='INVALID'
/
set heading on
