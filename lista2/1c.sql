use clinica;
#
drop view ConsultasCardio;
#
create view ConsultasCardio as
select
  p.nomep,
  c.dt_consulta,
  c.hora
from
  consulta c
  inner join paciente p on p.codp = c.codp
  inner join medico m on m.codm = c.codm
where
  p.problema in ('Cardiaco', 'Hipertensao')
  and m.especialidade = 'Cardiologista';
#
select
  *
from
  ConsultasCardio;
