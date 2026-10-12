-- Garante leitura correta dos acentos em qualquer cliente MySQL
SET NAMES utf8mb4;

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
       AND TIMESTAMPDIFF(YEAR, d.data_nascimento, CURDATE()) = c.idade_alvo) AS total_vinculados,
    -- 4. Datas e status derivados do ciclo vinculado ao caderno (Caderno.id_ciclo -> Ciclo)
    ci.data_inicio,
    ci.data_fim,
    CASE
        WHEN c.id_ciclo IS NULL THEN 'Não iniciado'
        WHEN ci.ativo = TRUE AND (ci.data_fim IS NULL OR ci.data_fim >= CURDATE()) THEN 'Ativo'
        WHEN ci.ativo = FALSE AND ci.data_fim IS NOT NULL AND ci.data_fim >= CURDATE() THEN 'Concluído antecipadamente'
        ELSE 'Encerrado'
    END AS status_caderno
FROM Caderno c
LEFT JOIN Ciclo ci ON ci.id_ciclo = c.id_ciclo;

CREATE OR REPLACE VIEW vw_resumo_unidades AS
SELECT
    u.id_clube,
    u.id_unidade,
    u.nome AS nome_unidade,
    -- Conselheiro vinculado à unidade (perfil CONSELHEIRO); NULL se a unidade estiver sem conselheiro
    (SELECT us.nome
     FROM Usuario us
     JOIN Perfil p ON p.id_perfil = us.id_perfil
     WHERE us.id_unidade = u.id_unidade
       AND us.ativo = TRUE
       AND UPPER(p.nome) = 'CONSELHEIRO'
     ORDER BY us.id_usuario ASC
     LIMIT 1) AS nome_conselheiro,
    -- Pontuação = soma dos pontos das tarefas CONCLUIDA no ciclo ativo do clube
    -- (pontuacao_concedida pela Diretoria tem precedência sobre Tarefa.pontuacao)
    COALESCE(SUM(CASE WHEN ut.status_kanban = 'CONCLUIDA' THEN COALESCE(ut.pontuacao_concedida, t.pontuacao) ELSE 0 END), 0) AS pontuacao,
    COUNT(ut.id_unidade_tarefa) AS total_tarefas,
    COALESCE(SUM(CASE WHEN ut.status_kanban = 'CONCLUIDA' THEN 1 ELSE 0 END), 0) AS tarefas_concluidas
FROM Unidade u
LEFT JOIN Unidade_Tarefa ut
       ON ut.id_unidade = u.id_unidade
      AND ut.id_ciclo = (SELECT ci.id_ciclo FROM Ciclo ci
                         WHERE ci.id_clube = u.id_clube AND ci.ativo = TRUE
                         ORDER BY ci.data_inicio DESC, ci.id_ciclo DESC
                         LIMIT 1)
LEFT JOIN Tarefa t ON t.id_tarefa = ut.id_tarefa
GROUP BY u.id_clube, u.id_unidade, u.nome;
