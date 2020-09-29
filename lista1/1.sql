USE MePoupe;


DELETE
FROM Registro_Deposito;


DELETE
FROM Registro_Saque;


INSERT INTO Registro_Deposito (cod_deposito, cod_conta, dt_deposito, valor_deposito)
VALUES (1,
        1,
        "2020-09-14",
        500), (2,
               1,
               "2020-09-16",
               100) ;


INSERT INTO Registro_Saque (cod_saque, cod_conta, dt_saque, valor_saque)
VALUES (1,
        1,
        "2020-09-20",
        200),(2,
              1,
              "2020-09-21",
              200);


INSERT INTO Registro_Deposito (cod_deposito, cod_conta, dt_deposito, valor_deposito)
VALUES (3,
        2,
        "2020-08-19",
        900), (4,
               2,
               "2020-08-24",
               50) ;


INSERT INTO Registro_Saque (cod_saque, cod_conta, dt_saque, valor_saque)
VALUES (3,
        2,
        "2020-09-22",
        300),(4,
              2,
              "2020-09-28",
              500);


SELECT c.nome,
       cc.cod_conta,
       concat("Saque: ", cast(sum(rs.valor_saque) AS char)) operacao
FROM conta_corrente cc
LEFT JOIN cliente c ON cc.cod_cliente = c.cod_cliente
LEFT JOIN Registro_Saque rs ON cc.cod_conta = rs.cod_conta
GROUP BY c.nome,
         cc.cod_conta
UNION
SELECT c.nome,
       cc.cod_conta,
       concat("Deposito: ", cast(sum(rd.valor_deposito) AS char)) operacao
FROM conta_corrente cc
LEFT JOIN cliente c ON cc.cod_cliente = c.cod_cliente
LEFT JOIN Registro_Deposito rd ON cc.cod_conta = rd.cod_conta
GROUP BY c.nome,
         cc.cod_conta;

