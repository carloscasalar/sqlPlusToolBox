select/* S.SID
      ,S.username
      ,to_char(
               to_date(substr(first_load_time,3,8),'YY-MM-DD')
                                                   ,'MON-DD') D1
      ,substr(first_load_time,12,10) "Time"
      ,A.users_opening
      ,A.users_executing
      ,A.buffer_gets
      ,A.executions
      ,buffer_gets/executions  buff_exec*/
      sql_text
 from  v$sqlarea A
      ,v$session S
      ,v$process P
where  address=sql_address
and    P.addr = S.paddr
and    S.username =upper('&usuario')
order by buffer_gets
/
