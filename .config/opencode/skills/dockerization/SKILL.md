---
name: dockerization
description: Initiates a lightweight Docker setup via OpenSpec proposal to ensure stability and simple infrastructure
compatibility: opencode
tags: [docker, containerization, deployment, infrastructure]
metadata:
  workflow: openspec-proposal
  priority: stability-over-features
  requires: openspec-proposal
---

2. Enhanced Core Philosophy
   Expand on your philosophy with specific examples:

## Core Philosophy

- **Stability Over Complexity**: Prioritize simple `Dockerfiles` and `docker-compose.yml` files that work immediately. Avoid multi-stage builds unless absolutely necessary.
- **Spec-Driven**: Always propose changes before implementation. Never create Docker files without a reviewed proposal.
- **Lightweight & Secure**:
  - Use `alpine` or `slim` variants (e.g., `node:20-alpine`, `python:3.11-slim`)
  - Run containers as non-root users (UID 1000 by default)
  - Minimal attack surface - no unnecessary packages
- **Idiomatic**: Follow language-specific best practices (e.g., virtualenv for Python, multi-stage for Go when needed)
- **Standard Ports**: Use conventional port mappings (3000 for Node/Express, 8080 for generic web, 8000 for Python/Django)

3. Detailed Instructions Section
   Break down the steps more granularly:

## Instructions

### Phase 1: Project Analysis

**DEVELOPER NOTE:** You may use `/opsx-explore` to allow the agent to explore the directory
(If this fails, this means that openspec may not be initialized yet. Notify the developer/user regarding this before proceeding).

1. **Detect Runtime**: Use the `explore` agent to identify:
   - Primary language (Node.js, Python, Go, Rust, etc.)
   - Framework (Express, Django, Flask, etc.)
   - Package manager (npm, pip, go mod, cargo)
   - Existing configuration files
   - Required ports from code analysis
   - Database dependencies
   - Environment variable requirements
2. **Detect Application Type**:
   - Web API/Service
   - Static site
   - Full-stack application
   - CLI tool
   - Worker/Queue processor

### Phase 2: OpenSpec Proposal

Use the `openspec` agent to create a new proposal under `openspec/changes/dockerization/`
The proposal MUST include:
**A. Dockerfile Strategy**

- Base image selection with rationale
- Non-root user configuration
- Dependency installation approach
- Build steps (if applicable)
- Runtime configuration
- Health check instructions
- Port exposure
  **B. docker-compose.yml Strategy**
- Services (app + primary database only)
- Volume mappings for development
- Environment variable management
- Network configuration
- Port mapping
  **C. .dockerignore Strategy**
- Git files
- Node_modules (if using multi-stage)
- Build artifacts
- Local environment files
- IDE/editor files
  **D. Language-Specific Considerations**
- Python: virtualenv, pip requirements, gunicorn/uvicorn
- Node: npm ci vs npm install, production dependencies only
- Go: Multi-stage build for binary compilation
- Rust: Multi-stage build with cargo chef for caching
  **E. Security Considerations**
- Non-root user UID/GID
- No secrets in images
- Minimal base image justification
- COPY vs ADD usage

### Phase 3: Implementation Guardrails

- Create `.dockerignore` before any image build
- Use `DOCKER_BUILDKIT=1` for modern builds
- Tag images with `:${VERSION}` and `:latest`
- Document build and run commands in proposal

### Phase 4: User Review Process

Once proposal is written, stop and ask:
"Read through the proposal at `openspec/changes/dockerization/proposal.md` before applying."
Wait for explicit user approval before:

- Creating Dockerfiles
- Building images
- Running containers
- Modifying existing configurations

4. Project Type Detection Matrix

## Project Type Detection Matrix

| Language | Framework | Base Image         | Port | Package Manager | Key Files                      |
| -------- | --------- | ------------------ | ---- | --------------- | ------------------------------ |
| Node.js  | Express   | node:20-alpine     | 3000 | npm             | package.json, app.js, index.js |
| Node.js  | Next.js   | node:20-alpine     | 3000 | npm             | package.json, next.config.js   |
| Python   | Django    | python:3.11-slim   | 8000 | pip             | requirements.txt, manage.py    |
| Python   | Flask     | python:3.11-slim   | 5000 | pip             | requirements.txt, app.py       |
| Go       | Standard  | golang:1.21-alpine | 8080 | go mod          | go.mod, main.go                |
| Rust     | Actix     | rust:1.75-slim     | 8080 | cargo           | Cargo.toml, main.rs            |

5. Sample Proposal Template
   Include a sample of what the generated proposal.md would look like:

## Sample Proposal Structure

# Dockerization Proposal: {project-name}

## Project Analysis

- **Runtime**: Node.js 20
- **Framework**: Express
- **Port**: 3000
- **Database**: PostgreSQL 15

## Proposed Configuration

### Dockerfile

\```dockerfile
FROM node:20-alpine
WORKDIR /app
RUN addgroup -g 1001 -S nodejs && \
 adduser -S nodejs -u 1001
COPY package\*.json ./
RUN npm ci --only=production
COPY --chown=nodejs:nodejs . .
USER nodejs
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=3s \
 CMD node healthcheck.js || exit 1
CMD ["node", "index.js"]
\```

### docker-compose.yml

\```yaml
version: '3.8'
services:
app:
build: .
ports: - "3000:3000"
environment: - NODE_ENV=production - DATABASE_URL=postgresql://user:pass@db:5432/dbname
depends_on: - db
volumes: - ./logs:/app/logs
db:
image: postgres:15-alpine
environment:
POSTGRES_DB: dbname
POSTGRES_USER: user
POSTGRES_PASSWORD: pass
volumes: - pgdata:/var/lib/postgresql/data
volumes:
pgdata:
\```

### .dockerignore

node_modules
npm-debug.log
.git
.env
.env.local
.nyc_output
coverage
dist
build

### Build & Run Commands

\```bash

# Build

docker build -t myapp:1.0 .

# Run with Compose

docker-compose up -d

# View logs

docker-compose logs -f
\```

## Justification

- **node:20-alpine**: Latest LTS, minimal size (~40MB)
- **Non-root user**: Security best practice
- **npm ci**: Reproducible builds from lock file
- **PostgreSQL**: Matches project requirements
- **Two-service limit**: Keeping it lightweight

## Open Questions

1. Do we need Redis for caching?
2. Any additional environment variables required?
3. Volume strategy for uploads?
   Additional Suggestions
4. Add a "Common Pitfalls" Section

## Common Pitfalls to Avoid

- ❌ Using `latest` tag in production without version pinning
- ❌ Installing unnecessary dev dependencies in production images
- ❌ Running as root user
- ❌ Copying secrets into images
- ❌ Not using .dockerignore
- ❌ Multi-stage builds for simple projects (over-engineering)
- ❌ **GID/UID conflicts**: Many base images already have users at common IDs (e.g., UID 1000 in `node:alpine`). Always verify available IDs or use higher numbers (1001+) to avoid conflicts like `addgroup: gid '1000' in use`

7. Add a "Testing Strategy" Section

## Testing Strategy

After implementation, verify:

1. Container builds successfully: `docker build .`
2. Runs as non-root: `docker exec <container> id`
3. Health check passes
4. Port is accessible
5. Application logs show correct startup
6. Graceful shutdown works (SIGTERM handling)
7. Update "When to Use Me" Section

## When to Use This Skill

Trigger when user mentions:

- "docker" or "dockerize"
- "containerize" or "containerization"
- "deployment setup"
- "production build"
- "add Docker support"
- "create Dockerfile"
  Also trigger when:
- User is setting up new project infrastructure
- User asks about deployment options
- CI/CD pipeline setup is requested
