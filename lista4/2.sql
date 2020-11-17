set global log_bin_trust_function_creators = 1;

drop function diaSemana;

delimiter ;;

create function diaSemana(data date)
returns varchar(50)
begin
    declare dia varchar(50);
    set dia=(select dayname(data));
    return dia;
end ;;

delimiter ;

select diaSemana('2020-11-09');
