DC := docker compose

# ---------- Docker ----------
.PHONY: up down ps

up: ## Docker環境を起動（PostgreSQL + Swagger UI）
	@$(DC) up -d

down: ## Docker環境を停止
	@$(DC) down

ps: ## Docker環境のステータスを表示
	@$(DC) ps

# ---------- Code Generation ----------
.PHONY: gen gen-back gen-flutter gen-web

gen: ## OpenAPI定義からコードを再生成（Go + Flutter + Web）
	@$(MAKE) gen-back gen-flutter gen-web

gen-back: ## OpenAPI定義からGoのサーバースタブを生成
	@mkdir -p backend/internal/api
	@oapi-codegen --config openapi/config.yaml openapi/openapi.yaml

gen-flutter: ## OpenAPI定義からDart/DioのAPIクライアントを生成
	@mkdir -p flutter/packages/wai_api
	@npx --yes @openapitools/openapi-generator-cli generate \
		-i openapi/openapi.yaml \
		-g dart-dio \
		-o flutter/packages/wai_api \
		--additional-properties=pubName=wai_api,nullableFields=true
	@cd flutter/packages/wai_api && dart pub get && dart run build_runner build --delete-conflicting-outputs

gen-web: ## OpenAPI定義からTypeScript FetchのAPIクライアントを生成
	@mkdir -p web/packages/wai-api
	@npx --yes @openapitools/openapi-generator-cli generate \
		-i openapi/openapi.yaml \
		-g typescript-fetch \
		-o web/packages/wai-api \
		--additional-properties=npmName=wai-api,npmVersion=0.0.1,supportsES6=true

# ---------- Swagger UI ----------
.PHONY: docs-up docs-down

docs-up: ## Swagger UIを起動（http://localhost:8081）
	@$(DC) up -d swagger-ui

docs-down: ## Swagger UIを停止
	@$(DC) stop swagger-ui

# ---------- Mock Server ----------
.PHONY: mock-up mock-down

mock-up: ## Prism mock サーバーを起動（http://localhost:4010）
	@$(DC) up -d prism

mock-down: ## Prism mock サーバーを停止
	@$(DC) stop prism

# ---------- Database ----------
.PHONY: db migrate erd schema

db: ## PostgreSQLを起動して準備完了を待つ
	@$(DC) up -d postgres
	@echo "Waiting for PostgreSQL to be ready..."
	@until $(DC) exec -T postgres pg_isready -U postgres > /dev/null 2>&1; do sleep 1; done
	@echo "PostgreSQL is ready."

migrate: ## マイグレーションを実行
	@cat backend/cmd/server/migrations/*.sql | $(DC) exec -T postgres psql -U postgres -d app

erd: ## tbls で ERD を生成
	@tbls doc --force

schema: db migrate erd ## DB起動 → マイグレーション → ERD生成を一括実行

# ---------- Local Development ----------
.PHONY: server clean

server: ## サーバーのみ起動（ローカル開発）
	@cd backend && go run ./cmd/server

clean: ## Docker環境を停止してボリュームも削除
	@$(DC) down -v
	