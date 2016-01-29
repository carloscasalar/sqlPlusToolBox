-- Ver https://blogs.oracle.com/opal/entry/sqlplus_101_substitution_varia
SET VERIFY OFF
SET DEF ON
ACCEPT script PROMPT "Nombre del paquete: "
SET TERMOUT OFF
COLUMN USUARIO new_value esquema
COLUMN SCRIPT_SPEC new_value script_spec_low
COLUMN SCRIPT_BODY new_value script_body_low
SELECT LOWER(USER) USUARIO,
       LOWER('&&script') || '.s.sql' SCRIPT_SPEC,
       LOWER('&&script') || '.b.sql' SCRIPT_BODY
FROM DUAL;
DEFINE esquema
DEFINE script_spec_low
DEFINE script_body_low
SET TERMOUT ON
PROMPT Compilando &&script_spec_low
@@./&&esquema/ddl/pack/&&script_spec_low
PROMPT Compilando &&script_body_low
@@./&&esquema/ddl/pack/&&script_body_low
SET VERIFY ON
