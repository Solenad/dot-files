---
name: github-workflows
description: Use when scaffolding CI/CD pipelines with GitHub Actions for Node.js projects, creating lint-test-scan and build-push workflows with Docker support
tags: [github-actions, ci-cd, docker, workflows, automation, nodejs]
---

# GitHub Workflows

## Overview

Scaffolds production-ready GitHub Actions workflows with security scanning, Docker builds, and PR templates. Opinionated for Node.js/Next.js projects following established patterns.

## When to Use

- Setting up new repository CI/CD
- Adding lint-test-scan workflow with security scanning
- Adding Docker build and push workflow
- Need pull request template scaffolding
- Migrating from other CI platforms to GitHub Actions

## Prerequisites

### Required package.json Scripts

Ensure these scripts exist in your `package.json`:

```json
{
  "scripts": {
    "dev": "next dev --turbopack",
    "build": "next build",
    "start": "next start",
    "lint": "eslint . --ext .ts,.tsx,.js,.jsx",
    "format": "prettier --write .",
    "test": "vitest"
  }
}
```

**Critical:** The `format` and `lint` scripts are **required** for the workflows to function.

## Core Pattern

### Phase 1: Detect Project Requirements

The AI will analyze your project and customize the workflows:

1. **Check package.json** - Verify required scripts exist
2. **Check framework** - Detect Next.js, Express, or vanilla Node.js
3. **Check for Dockerfile** - Determine if containerization applies
4. **Check for tests** - Determine if test step should be uncommented

### Phase 2: Configure Environment

**Required secrets:**
- `GITHUB_TOKEN` (auto-provided by GitHub)
- `NEXT_PUBLIC_API_URL` (for Next.js projects, optional)
- `CDN_URL` (optional)

**Optional secrets (for commented features):**
- `SONAR_TOKEN` (for SonarCloud)
- `DOCKER_USERNAME` / `DOCKER_PASSWORD` (for Docker Hub)

### Phase 3: Customize Workflows

The AI will:
- Uncomment test step if tests exist
- Uncomment Docker build step if Dockerfile exists
- Uncomment security scanners if requested
- Configure environment variables based on project needs

### Phase 4: Verify

- Check workflow syntax with `actionlint`
- Enable workflows in repository settings
- Test with manual dispatch

## Workflows Generated

### 001-setup-lint-test-scan.yml

**Triggers:** push/PR to main/dev/staging, releases, manual dispatch

**Jobs:**
1. **Setup** - Node.js 22 with npm cache
2. **Dependencies** - `npm ci`
3. **Format** - `npm run format`
4. **Lint** - `npm run lint`
5. **Build** - `npm run build`
6. **Security Scans** (commented out):
   - Dockerfile linting (Hadolint) - auto-enabled if Dockerfile exists
   - CodeQL analysis
   - Semgrep SAST
   - Trivy filesystem scan
   - SonarCloud (requires token)

**Optional Features (commented):**
- Scheduled dependency checks (cron)
- Test execution (`npm test`)

### 002-build-push-image.yml

**Triggers:** After successful 001 workflow on main/dev

**Jobs:**
1. **Buildx Setup** - Docker builder with layer caching
2. **Registry Login** - GHCR by default (Docker Hub commented)
3. **Metadata** - Multi-tag strategy (branch, SHA, semver, latest)
4. **Build & Push** - Multi-platform image build
5. **Health Verification** - Validates container starts and responds
6. **Security Scan** (commented): Trivy image vulnerability scan

### pull_request_template.md

Standard PR template with:
- Summary section
- Linked issues
- Type of change checklist
- Notes for reviewers
- Husky setup instructions (commented)

## AI Instructions

When using this skill, the AI MUST:

1. **Read package.json** - Verify required scripts exist
2. **Check for Dockerfile** - Determine if Docker workflows apply
3. **Check for test files** - Decide if test step should be uncommented
4. **Customize workflow** - Write appropriate commands based on project structure

### Detection Logic

```
IF package.json exists:
  - Verify "format" and "lint" scripts exist
  - Check for "test" script
  - Detect Node version (default to 22)
  - Check for Dockerfile

IF Dockerfile exists:
  - Include Dockerfile linting step
  - Include 002-build-push-image.yml

IF test files exist (e.g., *.test.ts, *.spec.js, __tests__/):
  - Uncomment test execution step
```

### Required Scripts Checklist

Before generating workflows, the AI MUST confirm:

- [ ] `npm run format` exists and works
- [ ] `npm run lint` exists and works
- [ ] `npm run build` exists and works
- [ ] `npm test` exists (optional, will be commented if missing)

**If required scripts are missing:** Warn user and suggest adding them to package.json before proceeding.

## Configuration

### Container Registry

**Default:** GitHub Container Registry (GHCR)

**To use Docker Hub instead:**

1. Uncomment Docker Hub login step in 002-build-push-image.yml:
   ```yaml
   - name: Log in to Docker Hub
     uses: docker/login-action@v3
     with:
       username: ${{ secrets.DOCKER_USERNAME }}
       password: ${{ secrets.DOCKER_PASSWORD }}
   ```

2. Update image reference:
   ```yaml
   images: ${{ secrets.DOCKER_USERNAME }}/your-image-name
   ```

### Branch Triggers

Default: `[main, dev, staging]`

Modify in both workflow files:
```yaml
on:
  push:
    branches: [main, dev, staging, your-branch]
```

### Environment Variables

Add to workflow steps as needed:
```yaml
env:
  NEXT_PUBLIC_API_URL: ${{ secrets.NEXT_PUBLIC_API_URL }}
  CDN_URL: ${{ secrets.CDN_URL }}
  # Add other env vars here
```

## Husky Setup (Manual)

The skill provides Husky configuration instructions but does NOT auto-enable it.

**To enable Husky:**

1. Install dependencies:
   ```bash
   npm install --save-dev husky prettier eslint
   ```

2. Initialize Husky:
   ```bash
   npx husky init
   ```

3. Configure pre-commit hook (`.husky/pre-commit`):
   ```bash
   #!/bin/sh
   . "$(dirname "$0")/_/husky.sh"
   npm run format
   npm run lint
   ```

4. Make hook executable:
   ```bash
   chmod +x .husky/pre-commit
   ```

**Why manual?** Husky modifies git hooks which affects all contributors. This should be an intentional team decision.

## Usage

**Trigger phrases:**
- "set up github workflows"
- "scaffold CI/CD pipeline"
- "create github actions"
- "add build pipeline"
- "configure docker build workflow"
- "add husky to project"

## File Locations

Templates are relative to skill directory:
- `templates/001-setup-lint-test-scan.yml`
- `templates/002-build-push-image.yml`
- `templates/pull_request_template.md`

Generated files location:
- `.github/workflows/001-setup-lint-test-scan.yml`
- `.github/workflows/002-build-push-image.yml`
- `.github/pull_request_template.md`

## Verification Steps

1. **Syntax check:**
   ```bash
   # Install actionlint
   brew install actionlint  # macOS
   # or
   winget install actionlint  # Windows

   # Validate
   actionlint .github/workflows/*.yml
   ```

2. **Enable workflows:**
   - Go to Repository Settings → Actions → General
   - Ensure "Allow all actions and reusable workflows" is selected
   - Save

3. **Test manually:**
   - Go to Actions tab
   - Select workflow
   - Click "Run workflow"

## Common Mistakes

- ❌ Missing `format` or `lint` scripts in package.json
- ❌ Missing `workflow_run` dependency between workflows
- ❌ Not configuring branch protection to require checks
- ❌ Forgetting to enable GitHub Container Registry access
- ❌ Hardcoding secrets instead of using `${{ secrets.NAME }}`
- ❌ Not making Husky pre-commit executable
- ❌ Uncommenting features without configuring required secrets
- ❌ Running workflows before required scripts are configured

## Optional Features Reference

### Security Scanning

**CodeQL:**
```yaml
- name: CodeQL Analysis
  uses: github/codeql-action/init@v3
  with:
    languages: javascript,typescript
```

**Semgrep:**
```yaml
- name: Run Semgrep scan
  uses: returntocorp/semgrep-action@v1
  with:
    config: auto
```

**Trivy:**
```yaml
- name: Run Trivy security scan
  uses: aquasecurity/trivy-action@master
  with:
    scan-type: "fs"
    format: "sarif"
```

### Scheduled Scans

```yaml
on:
  schedule:
    - cron: "0 2 * * 1"  # Weekly on Monday 2 AM
```

### Test Execution

**With Vitest:**
```yaml
- name: Run tests
  run: npm test
```

**With Jest:**
```yaml
- name: Run tests
  run: npm test -- --coverage
```

## Troubleshooting

### Workflow not triggering

- Check branch name matches trigger configuration
- Ensure workflow file is in `.github/workflows/`
- Verify Actions are enabled in repository settings

### Docker build fails

- Ensure `Dockerfile` exists in repository root
- Check `output: "standalone"` in `next.config.ts` for Next.js projects
- Verify registry credentials

### Health check fails

- Ensure application exposes port 3000 (or adjust HEALTHCHECK)
- Check root path `/` responds with HTTP 200
- Verify wget is installed in final image stage

### "npm run format" not found

- Add to package.json: `"format": "prettier --write ."`
- Install Prettier: `npm install --save-dev prettier`

### "npm run lint" not found

- Add to package.json: `"lint": "eslint . --ext .ts,.tsx,.js,.jsx"`
- Install ESLint: `npm install --save-dev eslint`

## Version History

- v1.0.0: Initial release for Node.js/Next.js projects
