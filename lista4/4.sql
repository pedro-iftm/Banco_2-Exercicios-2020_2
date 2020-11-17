use venda_p1;

delimiter ;;

delete from Pedido;
delete from cliente;

insert into cliente (codCliente, Nome, Endereco, Telefone, CNPJ)
values (1, 'pedro', 'rua 10', '34999', '127560');

insert into Pedido (codPedido, codCliente, dataCompra, valor_compra, Status)
values (1, 1, '2020-02-01', 80.0, 'entregue'),
       (2, 1, '2020-02-01', 1000.0, 'entregue'),
       (3, 1, '2020-02-01', 2000.0, 'entregue'),
       (4, 1, '2020-02-01', 3000.0, 'entregue'),
       (5, 1, '2020-02-01', 4000.0, 'entregue'),
       (6, 1, '2020-02-01', 5000.0, 'entregue');

drop procedure mediaVendas;
create procedure mediaVendas(ano int, mes int)
begin
    if (mes is null) then
        select dayname(dataCompra) diaSemana, avg(valor_compra) media
        from Pedido
        where year(dataCompra)=ano
        group by diaSemana;
    else
        select dayname(dataCompra) diaSemana, avg(valor_compra) media
        from Pedido
        where year(dataCompra)=ano and month(dataCompra)=mes
        group by diaSemana;
    end if;
end ;;

delimiter ;

call mediaVendas(2020, 02);
