USE MePoupe;


DELETE
FROM Registro_Saque;


DELETE
FROM Registro_Deposito;


INSERT INTO Registro_Saque (cod_saque, cod_conta, dt_saque, valor_saque)
VALUES (1,
        1,
        now(),
        150),(2,
              1,
              now(),
              100), (3,
                     1,
                     now(),
                     200), (4,
                            1,
                            "2019-09-21",
                            500), (5,
                                   1,
                                   now(),
                                   250);


SELECT c.CPF,
       c.nome,
       c.telefone,
       c.email,
       cc.cod_conta,
       rs.valor_saque
FROM conta_corrente cc
LEFT JOIN cliente c ON cc.cod_cliente = c.cod_cliente
LEFT JOIN Registro_Saque rs ON rs.cod_conta = cc.cod_conta
WHERE rs.valor_saque >
    (SELECT avg(rs.valor_saque)
     FROM conta_corrente cc
     LEFT JOIN cliente c ON cc.cod_cliente = c.cod_cliente
     LEFT JOIN Registro_Saque rs ON rs.cod_conta = cc.cod_conta)
  AND year(rs.dt_saque) = "2020"
GROUP BY c.CPF,
         c.nome,
         c.telefone,
         c.email,
         cc.cod_conta,
         rs.valor_saque
