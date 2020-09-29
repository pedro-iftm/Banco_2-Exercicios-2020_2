USE MePoupe;


DELETE
FROM Registro_Saque;


DELETE
FROM Registro_Deposito;


INSERT INTO Registro_Deposito (cod_deposito, cod_conta, dt_deposito, valor_deposito)
VALUES (1,
        1,
        now(),
        500), (2,
               1,
               now(),
               100) ;


INSERT INTO Registro_Saque (cod_saque, cod_conta, dt_saque, valor_saque)
VALUES (1,
        1,
        now(),
        200),(2,
              1,
              now(),
              250);


SELECT cc.cod_conta,
       c.nome,
       if(count(rs.valor_saque) IS NULL, 0, count(rs.valor_saque)) qtde_saques
FROM conta_corrente cc
LEFT JOIN cliente c ON cc.cod_cliente = c.cod_cliente
LEFT JOIN Registro_Saque rs ON cc.cod_conta = rs.cod_conta
AND month(rs.dt_saque) = month(now())
GROUP BY cc.cod_conta
