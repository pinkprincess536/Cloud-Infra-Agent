# CLOUD INFRASTRUCTURE AGENT

## PROJECT SPECIFICATION / SEPTEMBER 2026

# Cloud Infrastructure Agent

A company-aware assistant that turns an incomplete deployment request into a reviewable Terraform change, then applies an approved plan to a sandbox.

> **The project in one sentence**
>
> Given a service request, the agent checks company rules and current context, asks only for missing decisions, explains each proposed resource, and refuses to use a plan when its evidence or state has changed.

## 01 / THE JOB

A developer describes a workload in ordinary language. The agent uses the company handbook, service catalog, security policy and approved Terraform modules to work out what is already known. It asks for remaining requirements, proposes a design, creates a Terraform pull request, and shows the actual plan before anyone approves an apply.

First workload: a document-processing service on AWS. A FastAPI service accepts requests; an asynchronous worker handles documents; PostgreSQL stores results. A typical deployment uses an ALB, ECS services, SQS, RDS PostgreSQL and S3 for document bodies. The approved modules decide the exact resources.

### Example request

> “Deploy our document-processing API. It should accept PDFs, process them in the background, and store results. We expect customers in India now. Keep the first-month bill reasonable.”

The first response identifies the repo and company defaults, then asks about the few things that block a sound design: peak volume and file size, the data residency requirement, retention, the target environment, and an actual budget ceiling. It does not pretend “reasonable” is a usable number.

### Working boundary

- One sample company, one approved deployment pattern, one AWS region per deployment, and Terraform as the source of intended infrastructure.
- Sandbox apply only, after explicit review of the exact plan. The generated pull request is still useful without an apply.
- Repository inspection is an optional intake aid: it reads selected files and never treats code as proof of business requirements.

*Project specification / AWS + Terraform / Sandbox — 1*

---

# CLOUD INFRASTRUCTURE AGENT

## 02 / EVIDENCE AND REQUIREMENTS

# Keep each source in its proper role

Build a small, believable sample organization. A handful of current documents with realistic constraints will teach the system more than a large pile of generic cloud pages.

| INPUT | WHAT IT ANSWERS |
|---|---|
| Platform handbook + approved modules | Which regions, modules, tags and service patterns may be used? |
| Security policy + an ADR | What are the residency and network constraints, and why were choices made? |
| Service catalog + backend/API docs | Who owns the service, what does it depend on, and which contracts already exist? |
| Read-only cloud inventory + Terraform state | What currently exists in the sandbox? What will the proposed change touch? |
| Optional repo profile | Runtime, port, health route, queue use and database dependency, each linked to a file and commit. |

Use document search for prose and policy clauses. Use a catalog lookup for service ownership and dependencies, a cloud API for live resources, and the parsed Terraform plan for the change set. When two current sources disagree, show the conflict and ask for an owner decision. A code inference remains provisional until verified.

### The conversation should leave a typed record

Each entry has a value, source and status. The record distinguishes confirmed facts, document-derived defaults, assumptions and unresolved decisions. A missing blocker prevents planning; a nonblocking assumption is visible in the design and cost estimate.

```yaml
environment: sandbox # user confirmed
region: ap-south-1 # platform default, handbook v3
peak_jobs_per_hour: ? # blocking question
average_pdf_mb: 8 # assumption; affects cost
data_class: restricted # security policy SEC-04
```

### Question rule

Ask only when the answer changes the design, its safety, or an important estimate. Reuse documented defaults and say where they came from. Read the completed requirements and remaining assumptions back to the user before generating code.

If a rule requires EU document data to remain in the EU, a Mumbai-only storage design is invalid even if most customers are in India. The agent must surface that conflict before selecting resources.

*Project specification / AWS + Terraform / Sandbox — 2*

---

# CLOUD INFRASTRUCTURE AGENT

## 03 / FROM REQUEST TO DESIGN

# Pick a pattern; justify the resources

Start with hard constraints: environment, region and residency, public exposure, data class, approved modules and budget. If the requirements contradict a policy or each other, stop and name the conflict. Otherwise expand the approved API + worker + database pattern into resources.

| RESOURCE | WHY IT EXISTS | WHAT TO VERIFY |
|---|---|---|
| ALB + ECS API | Public HTTPS endpoint and a deployable container service. | Health route, ingress boundary, request latency. |
| SQS + ECS worker | The document job must outlive the API request. | Queue age, retries, failed messages. |
| S3 | Document bodies need durable object storage. | Region, encryption, lifecycle and access. |
| RDS PostgreSQL | The app needs relational results and migrations. | Private access, backups, connection limits. |

For every resource, retain the requirement or policy that caused it, the approved module that implements it, the cost assumption, and the health signal. The reviewer should be able to click a resource and see those four answers.

### An example decision

> **RDS PostgreSQL in a private subnet**
>
> Requirement: persist extracted results. Evidence: the app migration files and user-confirmed retention. Policy: production-style databases use private networking and the approved RDS module. Cost: instance and storage estimates with stated quantities. Health: connectivity, CPU, storage and backup status.

### Cost is a check, not a second project

Estimate the monthly cost for this one pattern from resource quantities and stated workload assumptions. Include region, pricing date, range and obvious omissions. If the user sets a $500 ceiling and the estimate is $720, show the mismatch and ask for a choice; do not quietly squeeze the architecture into an unsupported budget.

The design is a single readable page: architecture and data flow, source-backed decisions, cost assumptions, risks, and open decisions. Compare an alternative only when it would meaningfully change the choice.

*Project specification / AWS + Terraform / Sandbox — 3*

---

# CLOUD INFRASTRUCTURE AGENT

## 04 / A REAL, REVIEWABLE CHANGE

# Three durable outputs

| OUTPUT | WHAT GOES IN IT |
|---|---|
| requirements.yaml | Facts and their sources, assumptions, unresolved blockers and acceptance criteria. |
| design.md | Diagram, resource decisions, data flow, estimate, operational checks and links to evidence. |
| Terraform pull request | Pinned modules and variables, diff, validation result, redacted plan summary and policy findings. |

The application can display Requirements, Design, Cost, Risks, Terraform Diff and Apply Status without making each section a separate document.

### Plan and sandbox apply

1. Generate a branch against a known commit. Run `terraform fmt` and `terraform validate` in an isolated runner. Create a saved plan against the selected sandbox workspace and parse its JSON to list creates, updates, deletes and replacements.

2. Check a short set of rules against the actual plan, including public RDS access, allowed region, required tags, storage encryption and forbidden destructive changes. Return the exact failing resource and rule. A small, readable rule set is sufficient.

3. Show the diff and redacted plan summary. Human approval is bound to the requirements version, repository commit, workspace, variable inputs and saved-plan digest. Keep saved plans out of Git; they can contain sensitive values.

4. Before applying, confirm those inputs and the current state still match. If a requirement, policy, commit or state changes, invalidate the approval, make a new plan and request review again. Apply only in the sandbox with a separate scoped credential; verify the service health route and worker path afterward.

### Failure behavior

> **Policy violation:** the planned database is publicly accessible. Block apply and show the offending plan resource.
>
> **Changed residency:** the user changes the requirement from India to EU after approval. Invalidate the design and plan, rebuild for Frankfurt, and require a new approval.
>
> **Partial apply:** record what completed, inspect current state and present a fresh plan. Do not blindly retry or claim a generic rollback for a database.

*Project specification / AWS + Terraform / Sandbox — 4*

---

# CLOUD INFRASTRUCTURE AGENT

## 05 / BUILD AND PROVE IT

# A build order that reaches a working demo

| STEP | DONE WHEN |
|---|---|
| 1. Sample company | The handbook, security policy, ADR, service catalog and approved modules disagree in at least one intentional, explainable scenario. |
| 2. Requirements chat | A request produces a typed record with source links, asks blockers and names policy conflicts. |
| 3. Design | The single workload pattern produces a source-backed design with resource reasons and a bounded cost estimate. |
| 4. Terraform PR | Generated code validates, the sandbox plan is parsed and the planned resources pass or fail clear checks. |
| 5. Sandbox apply | A human approves the exact plan; apply runs with scoped credentials and reports verification or partial failure. |

### Twelve cases are enough to expose the weak points

Run three normal requests, three incomplete requests, two policy conflicts, two changed-state or changed-requirement cases, and two tool or apply failures. Keep the prompts and expected behavior fixed. For each case record whether a hard constraint was missed, whether the agent asked an unnecessary question, whether Terraform validated, whether a forbidden change was blocked, and whether a stale plan was rejected.

### The five-minute demo

1. Ask to deploy the document processor. Show facts recovered from company documents and the repo profile, then the two or three remaining questions.

2. Answer them. Open `requirements.yaml`, `design.md`, and the pull request. Pick a resource and follow its evidence back to a requirement.

3. Introduce a public database setting. Show the plan check reject the specific resource; fix it and create a fresh plan.

4. Approve and apply to the sandbox. Show the health check. Change the residency requirement and demonstrate that the previous plan cannot be applied.

### What to claim

Describe the organization and policies as a realistic sample if you authored them. Report which pieces used live AWS inventory and which ran in a sandbox. Bring one end-to-end trace and the twelve case results, including failures. That is a stronger project than claiming the agent can manage arbitrary cloud systems.

*Project specification / AWS + Terraform / Sandbox — 5*
