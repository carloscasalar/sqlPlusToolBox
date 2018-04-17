-- Copy pasted from https://stackoverflow.com/a/19804738/840635
Accept foo PROMPT "About to create new_uuid in this schema. Press enter to continue or CTRL + C and then enter to cancel... "
create or replace function new_uuid return VARCHAR2 is
  v_uuid VARCHAR2(40);
begin
  select regexp_replace(rawtohex(sys_guid()), '([A-F0-9]{8})([A-F0-9]{4})([A-F0-9]{4})([A-F0-9]{4})([A-F0-9]{12})', '\1-\2-\3-\4-\5') into v_uuid from dual;
  return LOWER(v_uuid);
end new_uuid;
/

SELECT NEW_UUID() FROM DUAL;

show errors;
