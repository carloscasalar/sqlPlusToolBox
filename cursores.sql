column MACHINE format a30
select sum(a.value) total_cur, avg(a.value) avg_cur, max(a.value) max_cur,
s.username, s.machine
from v$sesstat a, v$statname b, v$session s
where a.statistic# = b.statistic#  and s.sid=a.sid
and b.name = 'opened cursors current'
group by s.username, s.machine
order by 1 desc
/
