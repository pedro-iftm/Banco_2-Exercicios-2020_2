use clinica;
#
drop view GanhosMed;
#
create view GanhosMed as
select
  m.nomem,
  year(c.dt_consulta),
  sum(c.valor_consulta)
from
  consulta c
  inner join medico m on m.codm = c.codm
group by
  m.nomem,
  year(c.dt_consulta);
#
select
  *
from
  GanhosMed;
