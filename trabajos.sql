 SELECT JOB,to_char(LAST_DATE,'dd/mm/yyyy hh24:mi'),
to_char(THIS_DATE,'dd/mm/yyyy hh24:mi'),to_char(NEXT_DATE,'dd/mm/yyyy hh24:mi')
,BROKEN, INTERVAL,FAILURES FROM USER_JOBS
/
