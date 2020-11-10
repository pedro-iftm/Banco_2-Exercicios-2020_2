use Clinica;
#
drop view ReceitaporProblema;
#
create view ReceitaporProblema as
select
  p.problema,
  sum(c.valor_consulta)
from
  paciente p
  inner join consulta c on c.codp = p.codp
group by
  p.problema;
#
select * from ReceitaporProblema;
