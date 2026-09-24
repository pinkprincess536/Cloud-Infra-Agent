# CedarPeak Systems - Synthetic Cloud Infrastructure Agent Corpus

This is a fictional, self-contained evaluation corpus for a document-processing API with an asynchronous worker, PostgreSQL, S3, and SQS.

## Directory layout

```text
cloud_infra_corpus/
├── facts.yaml
├── company-docs/
│   ├── platform-handbook.md
│   ├── security-policy-SEC-04.pdf
│   ├── security-policy-SEC-03-superseded.pdf
│   ├── adr-004.md
│   ├── service-catalog.csv
│   ├── cost-and-incident-guide.md
│   └── incident-log.csv
├── repo/
│   ├── contracts/
│   │   ├── api-contract.yaml
│   │   └── worker-contract.json
│   └── app/
│       └── app.py
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── inventory-snapshot.json
│   ├── plan-fixtures/
│   │   ├── public-rds.json
│   │   └── destructive-rds-replacement.json
│   └── modules/
│       ├── network/main.tf
│       ├── ecs-service/main.tf
│       ├── rds-postgres/main.tf
│       ├── s3-bucket/main.tf
│       └── sqs/main.tf
├── requests.jsonl
└── expected-results.jsonl
```

## Intentional difficulty

- Freshness: SEC-03 is superseded by SEC-04; old module versions remain as history.
- Scope: Restricted-EU applies to the data plane, not every control-plane service.
- Exception: ADR-004 allows temporary staging-only public RDS under explicit conditions and an expiry date.
- Cross-file joins: owner, ports, health checks, region rules, module approvals, and architecture boundaries live in different sources.
- Missing values: several requests omit sizing and cost inputs.
- Drift: Terraform/configuration and read-only inventory intentionally disagree on RDS region.
- Tool/apply failure: two cases require state inspection and recovery instead of blind retries.

## Source of truth

`facts.yaml` is the canonical fact ledger and answer key. Source documents were written from it. Deliberate old versions, the staging exception, and observed-state drift are intentional fixtures.

## Evaluation

There are 12 fixed cases in `requests.jsonl`: 3 normal, 3 incomplete, 2 policy conflict, 2 changed requirement/state, and 2 tool/apply failure cases. `expected-results.jsonl` contains the gold record for each case.

## Terraform fixtures

`terraform/plan-fixtures/public-rds.json` contains a saved plan that changes RDS public access from false to true and should be blocked. `terraform/plan-fixtures/destructive-rds-replacement.json` contains a delete/create replacement of the production database and is intended to exercise destructive-change detection.
