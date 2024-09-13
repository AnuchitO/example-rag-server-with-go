# ragserver

*RAG stands for Retrieval Augmented Generation*

./scriptss of implementing a "RAG Server" in Go, using [Google
AI](https://ai.google.dev/) for embeddings and language models and
[Weaviate](https://weaviate.io/) as a vector database.


## How it works

The server we're developing is a standard Go HTTP server, listening on a local
port. See the next section for the request schema for this server. It supports
adding new documents to its context, and getting queries that would use this
context.

Weaviate has the be installed locally; the easiest way to do so is by using
`docker-compose` as described in the Usage section.

## Server request schema

```
/add/: POST {"documents": [{"text": "..."}, {"text": "..."}, ...]}
  response: OK (no body)

/query/: POST {"content": "..."}
  response: model response as a string
```

## Server variants

* `ragserver`: uses the Google AI Go SDK directly for LLM calls and embeddings,
  and the Weaviate Go client library directly for interacting with Weaviate.
* `ragserver-langchaingo`: uses [LangChain for Go](https://github.com/tmc/langchaingo)
  to interact with Weaviate and Google's LLM and embedding models.
* `ragserver-genkit`: uses [Genkit Go](https://firebase.google.com/docs/genkit-go/get-started-go)
  to interact with Weaviate and Google's LLM and embedding models.

## Usage

* Step 1: start Weaviate (using `docker-compose`) command in `make step-1-start-weaviate`
* Step 2: set environment variable `GEMINI_API_KEY` to your Google AI API key copy the `.env.example` file to `.env` and fill in the `GEMINI_API_KEY` value Get an API key from https://aistudio.google.com/app
	- if you don't have `direnv` installed, you can run `source .env` to set the environment variable command in `make step-2-set-env`
* Step 3: run the server with run RAG server with command in `make step-3-run-rag-server`
* Step 4: clear all data in Weaviate with command in `make step-4-clear-weaviate`
* Step 5: add documents with command in `make step-5-add-documents` it will take document content then send it to **Embedding Model** then take the result store in **Weaviate** (Vector DB).
* Step 6: query the server with command in `make step-6-query-server` it will take the query content then send it to **Embedding Model** then take the result and query it in **Weaviate** (Vector DB).

Adjust the contents of these scripts as needed.

## Environment variables

* `SERVERPORT`: the port this server is listening on (default 9020)
* `WVPORT`: the port Weaviate is listening on (default 9035)
* `GEMINI_API_KEY`: API key for the Gemini service at https://ai.google.dev
