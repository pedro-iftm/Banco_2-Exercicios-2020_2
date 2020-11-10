use Clinica;
#
drop view DadosCons;
#
create view DadosCons as
select
  p.nomep,
  p.problema,
  m.nomem,
  m.especialidade,
  c.dt_consulta,
  c.hora,
  c.valor_consulta
from
  consulta c
  inner join paciente p on p.codp = c.codp
  inner join medico m on m.codm = c.codm;
#
select
  *
from
  DadosCons;
