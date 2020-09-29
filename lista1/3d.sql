USE MePoupe;


INSERT
IGNORE INTO cliente (cod_cliente, nome, CPF, sexo, dt_nasc, telefone, email)
VALUES (3,
        "Katia",
        "12756654600",
        "F",
        "1998-09-04",
        "34988565544",
        "katia@mail.com"),(4,
                           "Amanda",
                           "22756654644",
                           "F",
                           "1994-03-12",
                           "34992083955",
                           "amanda@mail.com");


INSERT
IGNORE INTO conta_corrente (cod_conta, dt_hora_abertura, saldo, status, cod_cliente)
VALUES (3,
        now(),
        99999,
        "Ativa",
        3), (4,
             now(),
             99999,
             "Ativa",
             4);


SELECT cc.cod_conta,
       cc.saldo,
       cc.dt_hora_abertura
FROM conta_corrente cc
LEFT JOIN cliente c ON cc.cod_cliente = c.cod_cliente
WHERE c.sexo = "F"
  AND year(cc.dt_hora_abertura) = "2020"
