column username format a20
column osuser   format a20
column machine  format a20
column terminal format a20
column program  format a20
select username, osuser,MACHINE,        
TERMINAL       ,
PROGRAM        
from v$Session
where username='&username'
order by username
/
