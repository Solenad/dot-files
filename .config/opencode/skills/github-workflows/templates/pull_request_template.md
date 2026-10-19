### Summary
(Short description of the changes)

### Linked Issues
closes #ISSUE_NUMBER

### Type of Change
- [ ] feat: New feature
- [ ] fix: Bug fix
- [ ] docs: Documentation update
- [ ] chore/refactor: Maintenance or code restructure

### Notes for Reviewers
- (Anything important for the reviewer to know)

<!--
## Husky Setup Instructions

To enable pre-commit hooks with Husky:

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

Note: Husky modifies git hooks which affects all contributors.
This should be an intentional team decision.
-->
