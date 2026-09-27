# Cloud Infrastructure Agent

A company-aware assistant that turns an incomplete deployment request into a source-backed infrastructure design, a reviewable Terraform change, and — only after approval — a sandbox deployment.

The product specification is in [`context.md`](context.md). The Python application lives in [`Cloud-Infra-Agent/`](Cloud-Infra-Agent/).

## Quick start

Prerequisites: Python 3.11–3.13.

```powershell
Set-Location .\Cloud-Infra-Agent
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install -e ".[dev]"
cloud-agent --version
python -m pytest -q
```

## Current commands

```powershell
cloud-agent --version
```

Request and design commands arrive as later build parts land.

## Build roadmap

Each part ends with a reviewable behavior and a validation checkpoint. Parts are completed in order while preserving working behavior from earlier parts.

| Part | Milestone | Done when | Status |
|---:|---|---|---|
| 1 | Foundation and packaging | The project has pinned dependencies, an installable CLI, packaged corpus data, documented commands, and clean repository ignores. | Complete |
| 2 | Corpus and source precedence | Current policies, handbook, ADR, catalog, contracts, inventory, and Terraform facts load through typed APIs; conflicting or superseded sources resolve predictably. | Not started |
| 3 | Typed requirements extraction | A request produces facts with values, statuses, and sources; policy conflicts and hard blockers stop planning. | Not started |
| 4 | Conversational completion | Follow-up answers merge into the record; the agent asks only consequential questions and writes versioned `requirements.yaml` with acceptance criteria. | Not started |
| 5 | Architecture and resource design | Passing requirements expand into the approved API/worker/database pattern with requirement, evidence, module, cost, and health links per resource. | Not started |
| 6 | Cost and risk checks | A dated, bounded estimate uses workload quantities, exposes assumptions/omissions, compares the budget, and never weakens safety constraints to reduce cost. | Not started |
| 7 | Terraform generation | The approved design renders pinned modules and variables into a deterministic branch-ready Terraform change. | Not started |
| 8 | Validation and plan parsing | An isolated runner performs format/validate, creates a saved sandbox plan, parses plan JSON, and summarizes creates, updates, deletes, and replacements. | Not started |
| 9 | Plan policy engine | Checks run against actual planned resources for region, public RDS, encryption, tags, and destructive changes, returning exact resource addresses and rules. | Not started |
| 10 | Approval and stale-plan protection | Approval binds requirements version, commit, workspace, variables, and plan digest; any relevant change invalidates approval. | Not started |
| 11 | Sandbox apply and recovery | Scoped credentials apply only the approved plan; partial failure records completed work, refreshes state, replans, and verifies API and worker health. | Not started |
| 12 | Evaluation and demo | All twelve fixed cases report expected behavior, regressions are visible, and the five-minute end-to-end demo is reproducible. | Not started |

## Safety boundary

The company and its policies are a fictional but realistic sample. Terraform apply is not implemented yet; when added, it will be sandbox-only, approval-bound, and scoped to the exact saved plan.
