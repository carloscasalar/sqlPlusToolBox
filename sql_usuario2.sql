select vs.sql_text, /*vs.sharable_mem,
  vs.persistent_mem, vs.runtime_mem,  vs.sorts,
  vs.executions, vs.parse_calls, vs.module,
  vs.buffer_gets, vs.disk_reads, vs.version_count,
  vs.users_opening, vs.loads,
  to_char(to_date(vs.first_load_time,
  'YYYY-MM-DD/HH24:MI:SS'),'MM/DD  HH24:MI:SS') first_load_time,
  rawtohex(vs.address) address, vs.hash_value hash_value ,
  rows_processed  , vs.command_type, vs.parsing_user_id  ,
  OPTIMIZER_MODE  , au.USERNAME parseuser,buffer_gets*/ executions
from v$sqlarea vs , all_users au
where (parsing_user_id != 0)  AND
(au.user_id(+)=vs.parsing_user_id)
and (executions >= 1)
and au.USERNAME = upper('&usuario')
group by executions, vs.sql_text
/
