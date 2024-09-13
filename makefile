.PHONY: step-1-start-weaviate
step-1-start-weaviate:
	@echo "Starting Weaviate (Vector DB)..."
	docker-compose up

.PHONY: step-2-set-env
step-2-set-env:
	@echo "Setting environment variables..."
	source .env

.PHONY: step-3-run-rag-server
step-3-run-rag-server:
	@echo "Starting RAG server..."
	cd ragserver && go run .

.PHONY: step-4-clear-weaviate
step-4-clear-weaviate:
	@echo "Clearing Weaviate..."
	./.scripts/weaviate-delete-objects.sh

.PHONY: step-5-add-documents
step-5-add-documents:
	@echo "Adding documents to Weaviate..."
	./.scripts/add-documents.sh

# usage example: make step-6-query-server q="What is the capital of Thailand?"
.PHONY: step-6-query-server
step-6-query-server:
	@echo "Querying RAG server..."
	./.scripts/query.sh "$(q)"