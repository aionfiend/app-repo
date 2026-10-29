#!/usr/bin/env bash
# Integration + functional: usage tests/integration.sh <image>
set -euo pipefail
IMAGE=${1:?usage: integration.sh <image>}
docker volume create it-data >/dev/null
cid=$(docker run -d -p 3000:3000 -v it-data:/wiki/data "$IMAGE")
trap 'docker rm -f "$cid" >/dev/null; docker volume rm it-data >/dev/null' EXIT

for _ in $(seq 1 40); do
  curl -fsS http://localhost:3000/healthz >/dev/null 2>&1 && break
  sleep 3
done

curl -fsS http://localhost:3000/healthz >/dev/null || { echo "integration: healthz FAILED"; docker logs "$cid"; exit 1; }
echo "integration: /healthz OK"

docker exec "$cid" test -f /wiki/data/db.sqlite || { echo "integration: SQLite file missing"; exit 1; }
echo "integration: embedded SQLite OK"

code=$(curl -s -o /dev/null -L -w '%{http_code}' http://localhost:3000/)
[ "$code" = 200 ] || { echo "functional: GET / returned $code"; exit 1; }
echo "functional: GET / -> 200"
