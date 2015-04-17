select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'),to_char(max(LAST_DDL_TIME), 'dd/mm/yyyy hh24:mi:ss')from user_objects
/
