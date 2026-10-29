#!/usr/bin/env bash
# Unit: проверка конфигурации приложения (встроенная БД, порт, путь данных)
set -euo pipefail
grep -q 'type: sqlite' config.yml
grep -q 'storage: /wiki/data/db.sqlite' config.yml
grep -q '^port: 3000' config.yml
echo "unit: config OK"
