USE MePoupe;


DELETE
FROM Registro_Saque;


DELETE
FROM Registro_Deposito;


INSERT INTO Registro_Deposito (cod_deposito, cod_conta, dt_deposito, valor_deposito)
VALUES (1,
        2,
        now(),
        500), (2,
               2,
               now(),
               100) ;


INSERT INTO Registro_Deposito (cod_deposito, cod_conta, dt_deposito, valor_deposito)
VALUES (3,
        1,
        "2019-08-08",
        900), (4,
               1,
               now(),
               50) ;


SELECT c.*,
       max(rd.valor_deposito) valor
FROM conta_corrente cc
LEFT JOIN cliente c ON cc.cod_cliente = c.cod_cliente
LEFT JOIN Registro_Deposito rd ON rd.cod_conta = cc.cod_conta
AND month(rd.dt_deposito) = month(now())
GROUP BY c.cod_cliente,
         rd.valor_deposito
ORDER BY rd.valor_deposito DESC
LIMIT 1
