# AGENTS.md

This file provides guidance to AI coding agents when working with code in this repository.

## Setup commands
- Common commands should be defined in the Taskfile.
- Run validation tests: `task validate`.
 
## Testing instructions
- Find the CI plan in the .github/workflows folder.

## Code style
- Use double quotes where possible.

## Project knowledge
- **Tech Stack:** Terraform/Tofu, Talos, Kubernetes, Helm, Gateway API.
- **File Structure:**
  - `infrastructure/` – Infrastructure-As-Code with Terraform code.
  - `services/` – Objects deployed on the Kubernetes cluster.
    - `services/apps/` - Manifests of separate apps like web apps and app servers.
    - `services/cluster` - Manifests of cluster supportive tooling like Gateway configuration, central authentication and secrets support.
  - `README.md` – Important information about the platform and how to use it.

## Documentation style
- Be concise, specific, and value dense.
- Write so that a new developer to this codebase can understand your writing, don’t assume your audience are experts in the topic/area you are writing about.
