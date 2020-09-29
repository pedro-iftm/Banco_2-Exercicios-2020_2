USE MePoupe;


DELETE
FROM Registro_Saque;


DELETE
FROM Registro_Deposito;


INSERT INTO Registro_Deposito (cod_deposito, cod_conta, dt_deposito, valor_deposito)
VALUES (1,
        1,
        "2019-09-14",
        500), (2,
               1,
               "2019-09-16",
               100) ;


INSERT INTO Registro_Saque (cod_saque, cod_conta, dt_saque, valor_saque)
VALUES (1,
        1,
        "2019-09-20",
        200),(2,
              1,
              "2019-09-21",
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


SELECT DISTINCT cc.cod_conta,
                c.nome,
                c.telefone,
                c.email
FROM conta_corrente cc
LEFT JOIN cliente c ON cc.cod_cliente = c.cod_cliente
LEFT JOIN Registro_Saque rs ON cc.cod_conta = rs.cod_conta
LEFT JOIN Registro_Deposito rd ON cc.cod_conta = rd.cod_conta
WHERE rs.dt_saque < now() - interval 6 MONTH
  OR rd.dt_deposito < now() - interval 6 MONTH;

