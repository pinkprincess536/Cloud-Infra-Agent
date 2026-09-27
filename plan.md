# Cloud Infrastructure Agent — Flexible 12-Day Plan

## Day 1 — Part 1: Architecture, Scope & Repository

**Purpose:** Understand the whole project before implementation. Establish the boundaries, interfaces and repository structure.

### Topics to know before starting this sub-part

- AWS fundamentals: Region, VPC, subnet, security group, ECS, ALB, SQS, S3, RDS, IAM
- Terraform fundamentals: resource, module, state, plan, apply, workspace
- Agent fundamentals: LLM, tool calling, structured output, retrieval, agent state
- Project boundaries: one fictional company, one workload pattern, one region per deployment, Terraform as intended infrastructure

### Subtasks

- [ ] **1A** — Read and annotate the project specification.
- [ ] **1B** — Draw the end-to-end architecture.
- [ ] **1C** — Identify every input, output and decision point.
- [ ] **1D** — Create repository and folder structure.
- [ ] **1E** — Create `context.md` describing the project, boundaries and terminology.
- [ ] **1F** — Create a journal template for every future day.

### Questions / understanding checklist

- [ ] What enters the system?
- [ ] What does the agent know from company evidence?
- [ ] When does it ask the user?
- [ ] What are requirements, design, Terraform and plan?
- [ ] Why is human approval required?
- [ ] Why is sandbox apply the boundary?

> **End-of-Day Goal: 10–15% of the project.** You should have the complete architecture documented and the repository ready. You are not expected to have a working agent yet.

## Day 2 — Part 2A: Synthetic Company Corpus

**Purpose:** Create the fictional organization and its evidence sources.

### Topics to know before starting this sub-part

- Document authority and source roles
- Current vs historical documents
- Effective dates and scope
- Hard rules vs defaults
- Exceptions and superseded documents

### Subtasks

- [ ] **2A** — Define the fictional company.
- [ ] **2B** — Define the document-processing workload.
- [ ] **2C** — Create the platform handbook.
- [ ] **2D** — Create the current security policy.
- [ ] **2E** — Create an older/superseded policy.
- [ ] **2F** — Create the ADR.
- [ ] **2G** — Create the service catalog.
- [ ] **2H** — Create API and worker contracts.
- [ ] **2I** — Create cost guidance and an incident note.

### Questions / understanding checklist

- [ ] Which source answers region questions?
- [ ] Which source answers security questions?
- [ ] Which source answers ownership/dependencies?
- [ ] Which source describes API port and health route?
- [ ] Which source is current and which is historical?
- [ ] How will an exception be scoped?

> **End-of-Day Goal: 20–25% of the project.** The company corpus exists and is internally believable. You should be able to manually answer most basic deployment questions from the files.

## Day 3 — Part 2B: Canonical Fact Ledger + Intentional Difficulty

**Purpose:** Create the answer key that keeps the synthetic documents consistent and deliberately introduces testable conflicts.

### Topics to know before starting this sub-part

- YAML/JSON structures
- Source-of-truth concept
- Fact metadata
- Scope and effective date
- Configuration drift
- Superseded rule vs current rule
- Staging exception vs production rule

### Subtasks

- [ ] **3A** — Create `dataset/facts.yaml`.
- [ ] **3B** — Record owner, scope, effective date, source and rule/default status.
- [ ] **3C** — Check every company document against the ledger.
- [ ] **3D** — Add one superseded rule.
- [ ] **3E** — Add one scoped exception.
- [ ] **3F** — Add one intentional infrastructure drift case.
- [ ] **3G** — Create incomplete user requests with missing values.
- [ ] **3H** — Create the dataset folder structure.

### Questions / understanding checklist

- [ ] What is the canonical answer?
- [ ] Which source proves each fact?
- [ ] Why should one source outrank another?
- [ ] How is an exception prevented from becoming a global rule?
- [ ] What is intentional drift?
- [ ] Can every contradiction be resolved using a documented rule?

> **End-of-Day Goal: 30% of the project.** The evidence layer is now defined. You have a canonical answer key and deliberate difficulty that the agent will later be tested against.

## Day 4 — Part 3: Evidence Retrieval Layer

**Purpose:** Give the future agent reliable ways to retrieve company evidence and preserve source information.

### Topics to know before starting this sub-part

- RAG basics
- Document chunking
- Embeddings and semantic search
- Keyword search
- Metadata filtering
- Retrieval vs generation
- Source citation

### Subtasks

- [ ] **4A** — Load company documents.
- [ ] **4B** — Implement document search.
- [ ] **4C** — Implement policy-clause retrieval.
- [ ] **4D** — Implement catalog lookup.
- [ ] **4E** — Implement API/worker contract lookup.
- [ ] **4F** — Add repository/Terraform inspection.
- [ ] **4G** — Return source, section, version and effective date with evidence.
- [ ] **4H** — Test retrieval against the fact ledger.

### Questions / understanding checklist

- [ ] Can the system find the current rule?
- [ ] Can it distinguish old and current sources?
- [ ] Can it preserve scope?
- [ ] Can it return evidence rather than just an answer?
- [ ] Can retrieval expose a conflict instead of hiding it?

> **End-of-Day Goal: 40% of the project.** You should have a working evidence layer that can retrieve source-backed facts from the synthetic company corpus.

## Day 5 — Part 4: Requirements / Clarification Agent

**Purpose:** Turn a natural-language deployment request into a typed record containing confirmed facts, defaults, assumptions and blockers.

### Topics to know before starting this sub-part

- Structured output / JSON schema
- Tool calling
- Conversation state
- Requirements engineering
- Blocking vs non-blocking questions
- Hard constraints vs assumptions

### Subtasks

- [ ] **5A** — Define the requirements schema.
- [ ] **5B** — Connect the agent to evidence tools.
- [ ] **5C** — Extract known facts.
- [ ] **5D** — Reuse documented defaults instead of asking unnecessary questions.
- [ ] **5E** — Detect missing blockers.
- [ ] **5F** — Ask only questions that change design, safety or important estimates.
- [ ] **5G** — Track assumptions separately.
- [ ] **5H** — Generate `requirements.yaml`.
- [ ] **5I** — Read requirements and remaining assumptions back before code generation.

### Questions / understanding checklist

- [ ] What does the user explicitly confirm?
- [ ] What comes from company defaults?
- [ ] What is an assumption?
- [ ] What is blocking?
- [ ] Does this missing value actually change the design?
- [ ] Is the question already answered by evidence?

> **End-of-Day Goal: 50% of the project.** A deployment request can now become a source-backed `requirements.yaml` with blockers and assumptions.

## Day 6 — Part 5: Architecture & Design Generator

**Purpose:** Convert completed requirements into the approved API + worker + database deployment pattern and an explainable design.

### Topics to know before starting this sub-part

- ALB + ECS architecture
- SQS and asynchronous processing
- S3 durable object storage
- RDS PostgreSQL
- Private networking
- Resource-to-requirement mapping
- Cost assumptions and health signals

### Subtasks

- [ ] **6A** — Build resource-selection logic.
- [ ] **6B** — Generate API + worker + database architecture.
- [ ] **6C** — Map each resource to a requirement/evidence source.
- [ ] **6D** — Map each resource to an approved Terraform module.
- [ ] **6E** — Add cost assumptions.
- [ ] **6F** — Add operational health checks.
- [ ] **6G** — Add risks and open decisions.
- [ ] **6H** — Generate `design.md`.

### Questions / understanding checklist

- [ ] Why does each resource exist?
- [ ] What evidence caused the resource?
- [ ] What policy applies?
- [ ] What module implements it?
- [ ] What does it cost?
- [ ] How will health be checked?
- [ ] What happens when requirements conflict with policy?

> **End-of-Day Goal: 60% of the project.** You should have a source-backed `design.md` describing architecture, data flow, resource reasons, cost, risks and open decisions.

## Day 7 — Part 6: Terraform Generation + PR Workflow

**Purpose:** Turn the design into a reviewable Terraform change.

### Topics to know before starting this sub-part

- HCL
- Terraform modules and variables
- Module version pinning
- Git branches, commits and diffs
- `terraform fmt`
- `terraform validate`

### Subtasks

- [ ] **7A** — Prepare approved Terraform modules.
- [ ] **7B** — Generate variables from requirements.
- [ ] **7C** — Generate Terraform resources/modules.
- [ ] **7D** — Pin module versions.
- [ ] **7E** — Create a branch against a known commit.
- [ ] **7F** — Run `terraform fmt`.
- [ ] **7G** — Run `terraform validate` in an isolated runner.
- [ ] **7H** — Produce a Terraform diff / PR representation.
- [ ] **7I** — Store validation results.

### Questions / understanding checklist

- [ ] Which Terraform values are user-confirmed?
- [ ] Which are defaults?
- [ ] Which module version is approved?
- [ ] Does the generated Terraform match `design.md`?
- [ ] Could the generated change destroy something?

> **End-of-Day Goal: 70% of the project.** The system can move from requirements/design to a Terraform PR candidate that formats and validates successfully.

## Day 8 — Part 7: Saved Terraform Plan + Plan Parser

**Purpose:** Inspect the actual infrastructure change produced by Terraform rather than trusting generated source code.

### Topics to know before starting this sub-part

- `terraform plan`
- Saved plans
- `terraform show`
- Plan JSON
- Terraform state and workspace
- Create/update/delete/replace actions
- Sensitive-value redaction

### Subtasks

- [ ] **8A** — Configure/select sandbox workspace.
- [ ] **8B** — Generate a saved plan.
- [ ] **8C** — Convert the saved plan to JSON.
- [ ] **8D** — Parse resource changes.
- [ ] **8E** — Classify creates, updates, deletes and replacements.
- [ ] **8F** — Produce a redacted plan summary.
- [ ] **8G** — Compare plan changes against design expectations.

### Questions / understanding checklist

- [ ] What will actually change?
- [ ] Which resources are created?
- [ ] Which are updated?
- [ ] Which are deleted?
- [ ] Which are replaced?
- [ ] Does the plan match the intended design?
- [ ] Could sensitive values leak into logs or Git?

> **End-of-Day Goal: 78% of the project.** You can produce and inspect a real saved Terraform plan and summarize its change set programmatically.

## Day 9 — Part 8: Plan Policy / Safety Engine

**Purpose:** Evaluate the actual Terraform plan against a small, readable set of infrastructure safety rules.

### Topics to know before starting this sub-part

- Policy-as-code
- IAM / least privilege
- Public vs private resources
- Encryption
- Data residency
- Required tags
- Destructive changes

### Subtasks

- [ ] **9A** — Define policy rules.
- [ ] **9B** — Check RDS public access.
- [ ] **9C** — Check allowed region.
- [ ] **9D** — Check required tags.
- [ ] **9E** — Check storage encryption.
- [ ] **9F** — Check forbidden destructive changes.
- [ ] **9G** — Return exact resource + rule + actual value.
- [ ] **9H** — Test both passing and failing plans.

### Questions / understanding checklist

- [ ] Are rules evaluated against the actual plan?
- [ ] Can the system identify the exact offending resource?
- [ ] Can the user understand why the plan failed?
- [ ] Does a policy exception have the correct scope?
- [ ] Are destructive changes blocked when forbidden?

> **End-of-Day Goal: 85% of the project.** An unsafe plan is now automatically blocked with a precise, reviewable policy finding.

## Day 10 — Part 9: Approval Binding + Freshness + Sandbox Apply

**Purpose:** Make human approval meaningful by binding it to the exact requirements, code, workspace, variables and saved plan.

### Topics to know before starting this sub-part

- Terraform state and drift
- Plan digest/hash
- Versioning
- Approval records
- Scoped credentials
- Freshness verification
- Least privilege

### Subtasks

- [ ] **10A** — Create an approval record.
- [ ] **10B** — Bind approval to requirements version.
- [ ] **10C** — Bind approval to repository commit.
- [ ] **10D** — Bind approval to workspace and variable inputs.
- [ ] **10E** — Bind approval to saved-plan digest.
- [ ] **10F** — Re-check requirements/policy/commit/state before apply.
- [ ] **10G** — Invalidate stale approvals.
- [ ] **10H** — Apply only to the sandbox using scoped credentials.
- [ ] **10I** — Verify API health and worker path.

### Questions / understanding checklist

- [ ] What exactly did the human approve?
- [ ] What changes invalidate the approval?
- [ ] How do you detect stale state?
- [ ] Why is a new plan required after a relevant change?
- [ ] Why are saved plans kept out of Git?
- [ ] What permissions should the apply credential have?

> **End-of-Day Goal: 92% of the project.** The complete safety boundary works: approved plans apply only when their evidence and state are still valid.

## Day 11 — Part 10: Failure Handling + 12 Evaluation Cases

**Purpose:** Prove the system handles normal requests, missing information, conflicts, stale plans and failures correctly.

### Topics to know before starting this sub-part

- Exception handling
- Retries and idempotency
- Partial apply
- State inspection
- Negative testing
- Regression testing
- Evaluation datasets

### Subtasks

- [ ] **11A** — Build 3 normal cases.
- [ ] **11B** — Build 3 incomplete cases.
- [ ] **11C** — Build 2 policy-conflict cases.
- [ ] **11D** — Build 2 changed-requirement/state cases.
- [ ] **11E** — Build 2 tool/apply-failure cases.
- [ ] **11F** — Write expected results before execution.
- [ ] **11G** — Run all cases.
- [ ] **11H** — Record evidence, actual behavior and PASS/FAIL.
- [ ] **11I** — Fix failures and rerun regression cases.

### Questions / understanding checklist

- [ ] Did the agent miss a hard requirement?
- [ ] Did it ask an unnecessary question?
- [ ] Did Terraform validate?
- [ ] Did policy checks catch forbidden changes?
- [ ] Did stale plans get rejected?
- [ ] Did partial failure lead to inspection rather than blind retry?

> **End-of-Day Goal: 97% of the project.** All 12 fixed cases are documented and the major weak points are fixed or explicitly recorded.

## Day 12 — Part 11: Full Integration + Five-Minute Demo

**Purpose:** Integrate every component and prove the project with the exact end-to-end scenarios expected by the specification.

### Topics to know before starting this sub-part

- Integration testing
- End-to-end testing
- Logging and observability
- Project documentation
- Architecture explanation
- Evidence tracing
- Demo storytelling

### Subtasks

- [ ] **12A** — Run the normal deployment request.
- [ ] **12B** — Show recovered facts and the remaining questions.
- [ ] **12C** — Open `requirements.yaml` and `design.md`.
- [ ] **12D** — Show Terraform PR and validation.
- [ ] **12E** — Trace a resource back to its requirement/evidence.
- [ ] **12F** — Introduce public database access and show policy rejection.
- [ ] **12G** — Fix it and generate a fresh plan.
- [ ] **12H** — Approve and apply to sandbox.
- [ ] **12I** — Show service health.
- [ ] **12J** — Change residency and show the previous plan becoming invalid.
- [ ] **12K** — Rebuild, replan and reapprove.
- [ ] **12L** — Finalize README, architecture diagram, journal and twelve-case results.

### Questions / understanding checklist

- [ ] Can I explain the entire architecture without code?
- [ ] Can I explain why every resource exists?
- [ ] Can I trace a resource to evidence?
- [ ] Can I demonstrate a policy rejection?
- [ ] Can I demonstrate stale-plan rejection?
- [ ] Can I explain what is live AWS, what is sandbox, and what is synthetic?

> **End-of-Day Goal: 100% project completion.** You should have a working end-to-end demo, the required durable outputs, the 12-case evaluation results, documentation and a defensible explanation of the architecture.

# Project Progress Gates

Use these percentages as **scope gates**, not as a measure of coding hours. The goal is to know exactly how much of the final system should exist at the end of each day.

| End of | Target | What should exist |
|---|---:|---|
| Day 1 | 10–15% | Architecture, scope, repo, context and journal |
| Day 2 | 20–25% | Fictional company corpus |
| Day 3 | 30% | `facts.yaml` + controlled conflicts/drift |
| Day 4 | 40% | Evidence retrieval tools |
| Day 5 | 50% | Requirements agent + `requirements.yaml` |
| Day 6 | 60% | Design generator + `design.md` |
| Day 7 | 70% | Terraform generation + validation |
| Day 8 | 78% | Saved plan + JSON parser |
| Day 9 | 85% | Plan policy engine |
| Day 10 | 92% | Approval/freshness + sandbox apply |
| Day 11 | 97% | 12 evaluation cases + failure handling |
| Day 12 | 100% | Integrated demo + documentation |

> **Important:** If you finish a day's sub-part early, do not artificially stretch it. Move forward. If a day takes longer, the later days can absorb the delay because the roadmap is organized around dependencies and milestones rather than arbitrary daily limits.

# Daily Journal Template

```markdown
## Day X

### What I learned

### Why this concept is needed

### Where it appears in the architecture

### What I implemented

### Design decisions I made

### What could go wrong

### How I tested it

### What evidence proves it works

### What remains for the next day
```
