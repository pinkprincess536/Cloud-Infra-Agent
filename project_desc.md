# Cloud Infrastructure Agent

## Flexible 12-Day Project Roadmap

### How to use this roadmap

The project is divided by **sub-parts of the actual system**, not by an arbitrary number of days. Twelve days is the maximum working window. If a sub-part is completed early, move to the next one; if a sub-part needs more time, use the remaining days rather than rushing into the next layer.

The project specification defines the progression as:

**Sample company → requirements chat → design → Terraform PR → sandbox apply**

The dataset guide requires a canonical fact ledger, deliberate conflicts/drift, and twelve evaluation cases. This roadmap therefore builds those pieces in dependency order.

## Project broken into major sub-parts

| Part | System sub-part | Target days |
|---:|---|---|
| 1 | Architecture, scope and repository | Day 1 |
| 2 | Synthetic company knowledge base | Days 2–3 |
| 3 | Evidence retrieval layer | Day 4 |
| 4 | Requirements / clarification agent | Day 5 |
| 5 | Architecture and design generation | Day 6 |
| 6 | Terraform generation + PR workflow | Day 7 |
| 7 | Terraform plan + plan parser | Day 8 |
| 8 | Plan policy / safety engine | Day 9 |
| 9 | Approval, freshness and sandbox apply | Day 10 |
| 10 | Evaluation + failure handling | Day 11 |
| 11 | End-to-end integration + demo | Day 12 |

## Master Topic Checklist

### AWS / Cloud

Regions • AZs • VPC • Subnets • Route tables • Internet Gateway • Security Groups • ECS • ALB • SQS • S3 • RDS • IAM • Least privilege

### Terraform

HCL • Providers • Resources • Variables • Outputs • Modules • Pinned versions • State • Workspace • Plan • Apply • Saved plan • Plan JSON • Drift

### AI / Agent

LLM • Prompting • Tool calling • Structured output • Agent state • RAG • Chunking • Embeddings • Semantic search • Evidence-based reasoning

### Requirements

Facts • Defaults • Assumptions • Decisions • Blockers • Constraints • Acceptance criteria

### Knowledge

Source • Version • Effective date • Scope • Authority • Superseded documents • Exceptions • Conflicts • Citations

### Security / Policy

IAM • Least privilege • Encryption • Public/private networking • Database exposure • Residency • Tags • Destructive changes • Policy-as-code

### Safety

State • Drift • Plan digest • Approval binding • Requirements version • Commit • Workspace • Variables • Freshness

### Testing

Normal • Incomplete • Policy conflict • Changed state • Changed requirement • Tool failure • Partial apply • Regression

## Final architecture to remember

```text
Request
  ↓
Evidence
  ↓
Requirements
  ↓
Design
  ↓
Terraform PR
  ↓
Saved Plan
  ↓
Plan Parser
  ↓
Policy Gate
  ↓
Human Approval
  ↓
Freshness Check
  ↓
Sandbox Apply
  ↓
Health Verification
  ↓
Evaluation / Audit
```
