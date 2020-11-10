use Clinica;
#
drop view ReceitaporSexo;
#
create view ReceitaporSexo as
select
  p.sexo,
  sum(c.valor_consulta)
from
  paciente p
  inner join consulta c on c.codp = p.codp
group by
  p.sexo;
#
select * from ReceitaporSexo;
