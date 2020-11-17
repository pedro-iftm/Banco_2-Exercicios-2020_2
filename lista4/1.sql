set global log_bin_trust_function_creators = 1;

delimiter ;;

create function to_br_date(data date)
returns varchar(10)
begin
    return date_format(data, '%d/%m/%Y');
end ;;

delimiter ;

select to_br_date('2019-09-10');
