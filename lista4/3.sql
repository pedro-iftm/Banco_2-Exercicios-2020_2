set GLOBAL log_bin_trust_function_creators = 1;

delimiter ;;

create function mascaraCNPJ(cnpj varchar(14))
returns varchar(18)
begin
    return concat(
      substring(cnpj, 1, 2),
      '.',
      substring(cnpj, 3, 3),
      '.',
      substring(cnpj, 5, 3),
      '/',
      substring(cnpj, 8, 4),
      '-',
      substring(cnpj, 12, 2)
    );
end ;;

delimiter ;

select
  mascaraCNPJ('32058484000116');
