# Desbravadores Banco De Dados

Repositorio responsavel pela modelagem e pelos scripts de banco de dados do
sistema Desbravadores.

Este e o unico repositorio do projeto que deve manter arquivos de banco como
scripts SQL, modelagens, diagramas e artefatos equivalentes.

## Conteudo

```text
Modelagem v3.mwb
SQL- Criacao Banco Desbravadores.sql
README.md
```

Observacao: no Windows, o arquivo SQL pode aparecer como
`SQL- Criação Banco Desbravadores.sql`.

## Responsabilidade deste repositorio

- Guardar a modelagem atualizada do banco.
- Guardar o script oficial de criacao do banco.
- Centralizar alteracoes estruturais em tabelas, chaves e constraints.
- Servir de referencia para o backend `Desbravadores-BackEnd-Java`.

Os repositorios `Desbravadores-BackEnd-Java` e `Desbravadores-poc` nao devem
conter scripts SQL ou modelagens de banco.

## Banco criado pelo script

O script atual cria o banco:

```sql
desbravadores
```

Tabelas principais:

- `Clube`
- `Unidade`
- `Convite`
- `Usuario`
- `Tarefa`
- `TarefaUnidade`
- `Evidencia`

O script tambem cria o usuario MySQL `jpauser` e concede permissoes de
`INSERT`, `SELECT`, `UPDATE` e `DELETE` no banco `desbravadores`.

## Como executar o SQL

Pelo MySQL CLI:

```bash
mysql -u root -p < "SQL- Criação Banco Desbravadores.sql"
```

Ou pelo MySQL Workbench:

1. Abra uma conexao local.
2. Abra o arquivo `SQL- Criação Banco Desbravadores.sql`.
3. Execute o script completo.

Atencao: o script atual contem `DROP DATABASE IF EXISTS desbravadores;`.
Executar esse comando remove o banco existente antes de recriar a estrutura.

## Integracao com o backend

Depois de executar o script, configure o backend com variaveis de ambiente:

```powershell
$env:DB_URL="jdbc:mysql://localhost:3306/desbravadores"
$env:DB_USER="jpauser"
$env:DB_PASSWORD="senha-segura123"
$env:JWT_SECRET="uma-chave-local-para-desenvolvimento"
```

Em seguida, execute a API principal no repositorio
`Desbravadores-BackEnd-Java/APIDesbravadores`.

## Fluxo recomendado de alteracao

1. Atualizar modelagem e SQL neste repositorio.
2. Revisar se as entidades JPA do backend precisam mudar.
3. Atualizar o backend em `Desbravadores-BackEnd-Java`.
4. Rodar os testes do backend.
5. Evitar duplicar scripts SQL nos repositorios de backend ou POC.
