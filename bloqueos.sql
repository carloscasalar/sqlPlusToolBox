prompt Para matar: alter system kill session 'SID,serial#'
COLUMN owner       format a15
COLUMN object_name format a15
COLUMN object_type format a15
COLUMN sid         format 9990
COLUMN serial#     format 999990
COLUMN status      format a15
COLUMN osuser      format a15
COLUMN machine     format a20
select
   c.owner,
   c.object_name,
   c.object_type,
   b.sid,
   b.serial#,
   b.status,
   b.osuser,
   b.machine
from
   v$locked_object a ,
   v$session b,
   all_objects c
where
   b.sid = a.session_id
and
   a.object_id = c.object_id
/

