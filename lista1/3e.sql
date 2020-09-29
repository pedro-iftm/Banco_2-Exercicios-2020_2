USE MePoupe;


DELETE
FROM Registro_Saque;


INSERT INTO Registro_Saque (cod_saque, cod_conta, dt_saque, valor_saque)
VALUES (1,
        1,
        "2020-08-20",
        2700),(2,
               2,
               "2020-08-21",
               1500);


SELECT c.nome,
       cc.*
FROM conta_corrente cc
LEFT JOIN cliente c ON cc.cod_cliente = c.cod_cliente
LEFT JOIN Registro_Saque rs ON cc.cod_conta = rs.cod_conta
WHERE rs.valor_saque > 1000
  AND year(rs.dt_saque) = "2020"
  AND month(rs.dt_saque) = "08" ;

