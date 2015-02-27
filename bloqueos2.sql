prompt Para matar: alter system kill session 'SID,serial#'
COLUMN owner       format a10
COLUMN object_name format a15
COLUMN object_type format a15
COLUMN sid         format 9990
COLUMN serial#     format 999990
COLUMN status      format a15
COLUMN osuser      format a15
COLUMN machine     format a20
COLUMN USERNAME    FORMAT A10
columN TIEMPO      FORMAT A5
COLUMN HORAS_BLOQUEO FORMAT 90.000
column dias        format 90
select
   b.username,
   trunc( sysdate ) - trunc( LOGON_TIME) dias,
   to_char( trunc( SYSDATE ) + (sysdate - b.LOGON_TIME), 'hh24:mi' ) TIEMPO,
   --ROUND( SYSDATE-b.LOGON_TIME, 2 ) HORAS_BLOQUEO,
   c.owner,
   c.object_name,
   --c.object_type,
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

