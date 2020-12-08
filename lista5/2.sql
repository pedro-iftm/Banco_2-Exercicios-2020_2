set global log_bin_trust_function_creators = 1;

drop function calculate_taxes;

delimiter ;;

create function calculate_taxes(start_date date, end_date date)
returns decimal(9, 2)
begin
    declare days_quantity int;
    set days_quantity=(select datediff(end_date, start_date));
    return days_quantity * 1.5;
end;;

delimiter ;

select calculate_taxes('2020-12-07', '2020-12-26');

