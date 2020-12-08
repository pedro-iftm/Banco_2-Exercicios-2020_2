use MePoupe;

drop trigger td_redout_clients;
drop function calculate_taxes;
/* drop table td_red_clients; */

create table td_red_clients(
    id int not null auto_increment,
    cod_cliente int not null,
    nome varchar(50) not null,
    CPF char(11) not null,
    cod_conta int not null,
    dt_vermelho date not null default (now()),
    dt_verde date default null,
    valor_taxa decimal(9, 2) default null,
    primary key(id)
);

delimiter $

create function calculate_taxes(start_date date, end_date date)
returns decimal(9, 2)
begin
    declare days_quantity int;
    set days_quantity=(select datediff(end_date, start_date));
    return days_quantity * 1.5;
end$


create trigger td_redout_clients
after insert
on Registro_Deposito for each row
begin
    declare novo_saldo decimal(9, 2);
    declare data_inicio decimal(50);
    declare valor_taxa decimal(9, 2);
    set novo_saldo=(select c.saldo + new.valor_deposito from conta_corrente c where c.cod_conta = new.cod_conta);
    update conta_corrente c set saldo=novo_saldo where c.cod_conta = new.cod_conta;
    if (novo_saldo >= 0) then
        set data_inicio=(select t.dt_verde from td_red_clients t where t.cod_conta = new.cod_conta and t.dt_vermelho is null);
        set data_inicio=(select now());
        if exists(select * from td_red_clients t where t.cod_conta = new.cod_conta and t.dt_verde is null) then
            set valor_taxa=(select calculate_taxes(data_inicio, now()));
            update td_red_clients t set t.dt_verde=now(), t.valor_taxa=valor_taxa where t.cod_conta = new.cod_conta;
        end if;
    end if;
end$

delimiter ;

delete from Registro_Deposito where cod_deposito = 3;
insert into Registro_Deposito (cod_deposito, cod_conta, dt_deposito, valor_deposito) values (3, 2, '2020-11-16', 50);
select * from conta_corrente;
select * from td_red_clients;

