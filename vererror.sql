column text format a50
column line format 9999
column position format 99
select type, line, position, text from user_errors where name=UPPER('&OBJETO')
/
