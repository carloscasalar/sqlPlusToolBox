select osuser, count('d'),to_char(min(LOGON_TIME), 'dd/mm/yyyy HH24:MI:SS') min,
to_char(max(LOGON_TIME),'DD/MM/YYYY HH24:MI:SS') MAX
 from v$session group by osuser
/
