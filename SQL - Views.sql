USE clube_desbravadores;

CREATE OR REPLACE VIEW vw_resumo_cadernos AS
SELECT 
    c.id_clube,
    c.id_caderno, 
    c.nome AS nome_caderno, 
    c.idade_alvo,
    -- 1. Gera o cabeçalho agrupador (ex: "Leões e Tigresas") unindo os nomes das unidades que atendem essa idade
    (SELECT GROUP_CONCAT(u.nome ORDER BY u.nome ASC SEPARATOR ' e ') 
     FROM Unidade u 
     WHERE u.id_clube = c.id_clube 
       AND c.idade_alvo BETWEEN u.idade_minima AND u.idade_maxima) AS nome_grupo,
    -- 2. Conta as tarefas cadastradas para o caderno (Requisitos)
    (SELECT COUNT(t.id_tarefa) 
     FROM Tarefa t 
     WHERE t.id_caderno = c.id_caderno 
       AND t.tipo_tarefa = 'CADERNO') AS total_requisitos,
    -- 3. Conta os desbravadores do clube que têm a idade exata do caderno (Vinculados)
    (SELECT COUNT(d.id_desbravador) 
     FROM Desbravador d 
     WHERE d.id_clube = c.id_clube 
       AND d.ativo = TRUE 
       AND TIMESTAMPDIFF(YEAR, d.data_nascimento, CURDATE()) = c.idade_alvo) AS total_vinculados
FROM Caderno c;