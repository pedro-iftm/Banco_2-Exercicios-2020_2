use MePoupe;

/* update conta_corrente set saldo=500 where cod_conta = 2; */
/* drop table td_red_clients; */
drop trigger td_red_clients;

create table td_red_clients(
    id int not null auto_increment,
    cod_cliente int not null,
    nome varchar(50) not null,
    CPF char(11) not null,
    cod_conta int not null,
    dt_vermelho date not null default (now()),
    dt_verde date default null,
    valor_taxa date default null,
    primary key(id)
);


delimiter $

create trigger tr_red_clients
before insert
on Registro_Saque for each row
begin
    declare novo_saldo decimal(9, 2);
    set novo_saldo=(select c.saldo - new.valor_saque from conta_corrente c where c.cod_conta = new.cod_conta);
    if (novo_saldo < -200) then
        signal sqlstate '45000' set message_text = 'Saldo insuficiente';
    else if (novo_saldo < 0) then
        update conta_corrente c set saldo=novo_saldo where c.cod_conta = new.cod_conta;
        if not exists(select t.cod_cliente
                      from td_red_clients t
                      where t.cod_conta = new.cod_conta
                      and t.dt_verde is null) then
            insert into td_red_clients (id, cod_cliente, nome, CPF, cod_conta, dt_vermelho)
            select null, c.cod_cliente, c.nome, c.CPF, cc.cod_conta, now()
            from cliente c
            inner join conta_corrente cc on c.cod_cliente = cc.cod_cliente
            where cc.cod_conta = new.cod_conta;
        end if;
    else
        update conta_corrente c set saldo=novo_saldo where c.cod_conta = new.cod_conta;
    end if;
    end if;
end$

delimiter ;

delete from Registro_Saque where cod_saque = 3;
insert into Registro_Saque (cod_saque, cod_conta, dt_saque, valor_saque) values (3, 2, '2020-11-16', 50);
select * from conta_corrente;
select * from td_red_clients;
