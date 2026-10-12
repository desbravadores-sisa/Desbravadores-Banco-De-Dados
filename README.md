# Desbravadores Banco De Dados

Modelagem e scripts MySQL do sistema de gestão do Clube de Desbravadores **Tigre da Montanha** (Projeto Integrador SPTech).

Este é o **único** repositório que guarda artefatos de banco: scripts SQL, modelagem e migrações. O backend usa `ddl-auto=none`, ou seja, depende exatamente deste schema.

🎨 Protótipo de referência: [Figma Make — prototipo_versãofinal](https://www.figma.com/make/zdjDwsWCbkBmPXUXtR9QxT/prototipo_vers%C3%A3ofinal?t=SkffTCtZwgP5uuL2-1)

## Em que pé estamos (11/10/2026)

A branch **`consolidacao/sprint-final`** traz o schema usado pela versão integrada do sistema. Ela foi validada criando o banco do zero em MySQL 8.4 e rodando a API e o frontend sobre ele.

Novidades desta branch em relação à `main`:

- `Caderno.id_ciclo`, a view `vw_resumo_unidades` e `vw_resumo_cadernos` com datas e status do ciclo (commit `a1e35e4`).
- `Usuario.telefone`, usado na tela de Perfil.
- `Unidade_Tarefa.pontuacao_concedida`: pontos ajustados pela Diretoria ao aprovar uma evidência. A view `vw_resumo_unidades` passa a usar `COALESCE(pontuacao_concedida, Tarefa.pontuacao)`.
- `SET NAMES utf8mb4;` no topo dos scripts. Sem isso, clientes configurados em latin1 gravavam "JoÃ£o" em vez de "João".
- As migrações 001 e 002, para bancos que já existem.

## Conteúdo

| Arquivo | Para que serve |
|---|---|
| `SQL- Criação Banco Desbravadores.sql` | Cria **do zero** o banco `clube_desbravadores` (⚠️ começa com `DROP DATABASE IF EXISTS`) e o usuário MySQL da aplicação |
| `SQL - Views.sql` | `vw_resumo_cadernos` e `vw_resumo_unidades` |
| `SQL - Inserts para mock.sql` | Dados de exemplo (clube, ciclo, unidades, desbravadores, cadernos, tarefas, conselheiros) |
| `SQL - Migracao 001 telefone usuario.sql` | Acrescenta `Usuario.telefone` |
| `SQL - Migracao 002 pontuacao concedida.sql` | Acrescenta `Unidade_Tarefa.pontuacao_concedida` |
| `Modelagem v3.mwb` | Modelagem no MySQL Workbench (**não** reflete ainda as colunas das migrações 001 e 002) |

Tabelas: `Clube`, `Ciclo`, `Perfil`, `Unidade`, `Usuario`, `Convite`, `Desbravador`, `Caderno`, `Tarefa`, `Unidade_Tarefa`, `Evidencia`, `Execucao_Caderno`, `Checklist_Caderno`, `Notificacao`.

Conceitos importantes:
- Os **perfis** são `Diretoria` e `Conselheiro`. O backend gera as permissões `ROLE_DIRETORIA` e `ROLE_CONSELHEIRO` a partir desses nomes; se renomear, alinhe o backend.
- Os **requisitos de um caderno** são as tarefas com `tipo_tarefa = 'CADERNO'` e `id_caderno` preenchido.
- Os **vinculados** de um caderno são calculados pela idade (`TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) = idade_alvo`); não existe uma tabela de vínculo explícito.
- A **pontuação da unidade** é a soma dos pontos das tarefas `CONCLUIDA` no ciclo ativo.

## Como executar

### Banco novo

Execute, nesta ordem (MySQL Workbench ou CLI):

```bash
mysql -u root -p --default-character-set=utf8mb4 < "SQL- Criação Banco Desbravadores.sql"
mysql -u root -p --default-character-set=utf8mb4 < "SQL - Views.sql"
mysql -u root -p --default-character-set=utf8mb4 < "SQL - Inserts para mock.sql"   # opcional
```

### Banco que já existe (sem apagar os dados)

```bash
mysql -u root -p clube_desbravadores < "SQL - Migracao 001 telefone usuario.sql"
mysql -u root -p clube_desbravadores < "SQL - Migracao 002 pontuacao concedida.sql"
mysql -u root -p clube_desbravadores < "SQL - Views.sql"
```

### Opção com Docker (ambiente isolado)

```bash
docker run -d --name desbrav-mysql -e MYSQL_ROOT_PASSWORD=<senha-local> -p 3307:3306 \
  -v "<pasta com 01_schema.sql, 02_views.sql, 03_inserts.sql>:/docker-entrypoint-initdb.d:ro" \
  mysql:8.4 --lower-case-table-names=1
```

O parâmetro `--lower-case-table-names=1` é **obrigatório** em servidores Linux: o schema usa `Usuario`, `Convite`…, mas o Hibernate consulta em minúsculas.

## Integração com o backend

Configure a API (`Desbravadores-BackEnd-Java/APIDesbravadores/.env`) apontando para `jdbc:mysql://localhost:3306/clube_desbravadores`. Veja o README do backend.

## Fluxo recomendado de alteração

1. Altere o SQL aqui. Num banco existente, **crie uma migração numerada** (`SQL - Migracao 00N ...sql`), além de atualizar o script de criação.
2. Atualize a `Modelagem v3.mwb`.
3. Alinhe as entidades JPA no backend; com `ddl-auto=none`, uma coluna mapeada que não existe no banco quebra a API.
4. Rode os testes do backend e suba a API contra um banco criado por estes scripts.

## Próximos passos (banco)

1. PR `consolidacao/sprint-final` → `main` (ele deve ser o **primeiro** a ser mergeado, antes do backend e do front).
2. Atualizar a `Modelagem v3.mwb` com `telefone` e `pontuacao_concedida`.
3. Decidir junto com o backend a **capitalização dos nomes de tabela**, para permitir deploy em Linux sem `lower_case_table_names`.
4. Avaliar, a partir do protótipo: vínculo explícito entre desbravador e caderno (hoje é por idade), registro de **descontos** de pontos (o dashboard da unidade mostra "ganhos e descontos") e histórico de cadernos concluídos por desbravador.
5. Remover do script de criação a senha fixa do usuário MySQL da aplicação; configurá-la por ambiente.
