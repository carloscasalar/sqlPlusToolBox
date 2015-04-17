REM ########################################################################
REM ##   Author : Sunil Kumar
REM ##
REM ##   This script gives the following:
REM ##   1. The list of all foreign keys of the given table.
REM ##   2. The list of all foreign keys that references the given table.
REM ##   3. Self referential integrity constraints
REM ##
REM ##   The output is in tabular format that contains the list of columns
REM ##   that consists the foreign key.
REM #######################################################################

set linesize 110
set verify   off

break on owner on table_name on constraint_name on r_constraint_name

column owner format a5
column r_owner format a5
column column_name format a12
column tt noprint
column position heading P format 9
column table_name format a15
column r_table_name format a15
column constraint_name format a15
column r_constraint_name format a15

select
        a.tt,
        a.owner,
        b.table_name,
        a.constraint_name,
        b.column_name,
        b.position,
        a.r_constraint_name,
        c.column_name,
        c.position,
        c.table_name r_table_name,
        a.r_owner
from
        (select
                owner,
                constraint_name,
                r_constraint_name,
                r_owner,1 tt
        from
                all_constraints
        where
                owner=upper('&&owner')
                and table_name=upper('&&table_name')
                and constraint_type!='C'
        union
        select
                owner,
                constraint_name,
                r_constraint_name,
                r_owner,2
        from
                all_constraints
        where
                (r_constraint_name,r_owner) in
                (select
                        constraint_name,
                        owner
                from
                        all_constraints
                where
                        owner=upper('&owner')
                        and table_name=upper('&table_name'))
        ) a,
        all_cons_columns b,
        all_cons_columns c
where
        b.constraint_name=a.constraint_name
        and b.owner=a.owner
        and c.constraint_name=a.r_constraint_name
        and c.owner=a.r_owner
        and b.position=c.position
order   by 1,2,3,4,5
/

set verify on

clear columns
clear breaks

undef owner
undef table_name


