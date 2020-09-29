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
              250);


SELECT cc.cod_conta,
       year(rs.dt_saque) AS ano,
       month(rs.dt_saque) AS mes,
       if(sum(rs.valor_saque) IS NULL, "Sem registro de saques", concat("Saques: ", cast(sum(rs.valor_saque) AS char))) movimento
FROM conta_corrente cc
LEFT JOIN Registro_Saque rs ON cc.cod_conta = rs.cod_conta
GROUP BY month(rs.dt_saque),
         year(rs.dt_saque),
         cc.cod_conta
UNION ALL
SELECT cc.cod_conta,
       year(rd.dt_deposito) AS ano,
       month(rd.dt_deposito) AS mes,
       if(sum(rd.valor_deposito)IS NULL, "Sem registro de depositos", concat("Depositos: ", cast(sum(rd.valor_deposito) AS char))) movimento
FROM conta_corrente cc
LEFT JOIN Registro_Deposito rd ON cc.cod_conta = rd.cod_conta
GROUP BY month(rd.dt_deposito),
         year(rd.dt_deposito),
         cc.cod_conta
