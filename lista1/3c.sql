USE MePoupe;


UPDATE conta_corrente
SET dt_hora_abertura="2020-08-10"
WHERE cod_cliente = 1;


UPDATE conta_corrente
SET dt_hora_abertura="2020-07-10"
WHERE cod_cliente = 2;


SELECT c.*,
       cc.cod_conta,
       cc.dt_hora_abertura
FROM conta_corrente cc
LEFT JOIN cliente c ON c.cod_cliente = cc.cod_cliente
WHERE year(cc.dt_hora_abertura) = "2020"
  AND month(cc.dt_hora_abertura) IN ("07",
                                     "08")
