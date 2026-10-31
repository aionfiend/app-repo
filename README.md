# wiki-app

Wiki.js (CMS) в Docker: версионирование страниц, встроенная БД SQLite, пользовательские данные в `/wiki/data`.

## Запуск локально
    docker build -t wiki-app .
    docker run -d -p 3000:3000 -v wikidata:/wiki/data wiki-app
    # открыть http://localhost:3000 и пройти первичную настройку

## Ветвление
- `main`: продакшен, каждый push запускает CI и деплой
- `develop`: интеграция, запускает только CI
- `feature/*`: ветки задач, merge в `develop` через Pull Request

## CI/CD
Workflow `ci-cd.yml`: lint (hadolint, yamllint) -> unit -> build -> Trivy -> integration/functional -> push в GHCR -> deploy.
Откат вручную: Actions -> `rollback` -> Run workflow.

## Secrets (Settings -> Secrets and variables -> Actions)
`SSH_HOST`, `SSH_USER`, `SSH_KEY`, `TELEGRAM_TOKEN`, `TELEGRAM_CHAT_ID`

Проект сдаётся с демонстрацией blue-green деплоя и отката.
