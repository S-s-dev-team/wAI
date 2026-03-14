DC := docker-compose

# ---------- Docker ----------
.PHONY: up down ps

up: ## Docker環境を起動（サーバー + Swagger UI）
	@$(DC) up -d

down: ## Docker環境を停止
	@$(DC) down

ps: ## Docker環境のステータスを表示
	@$(DC) ps

# ---------- Code Generation ----------
.PHONY: gen gen-back gen-front

gen: ## OpenAPI定義からコードを再生成（Go + TypeScript）
	@$(MAKE) gen-back gen-front

gen-back: ## OpenAPI定義からGoのサーバースタブを生成
	@mkdir -p backend/internal/api
	@oapi-codegen --config openapi/config.yaml openapi/openapi.yaml

gen-front: ## OpenAPI定義からTypeScriptの型定義を生成
	@mkdir -p frontend/src/lib
	@cd frontend && npx openapi-typescript ../openapi/openapi.yaml -o src/lib/api-types.ts

# ---------- Swagger UI ----------
.PHONY: docs-up docs-down

docs-up: ## Swagger UIを起動（http://localhost:8081）
	@$(DC) up -d swagger-ui

docs-down: ## Swagger UIを停止
	@$(DC) stop swagger-ui

# ---------- Local Development ----------
.PHONY: server swagger

server: ## サーバーのみ起動（ローカル開発）
	@cd backend && go run ./cmd/server

swagger: ## Swagger UIのみ起動（ローカル開発）
	@python3 -m http.server 8081 --directory openapi
