# CedarPeak Systems - Cloud Platform Handbook

Document ID: PH-2026-06
Owner: Platform Engineering
Status: Current handbook with dated platform updates
Last reviewed: 2026-09-10

## 1. Workload pattern

The standard production pattern for `document-processor` is:

- API: Python service behind an Application Load Balancer on ECS Fargate.
- Worker: ECS Fargate service consuming jobs from SQS.
- Database: PostgreSQL on RDS, private subnets only.
- Documents: S3 bucket encrypted with a customer-managed KMS key.
- Queue: SQS Standard queue with a dead-letter queue.

The API container listens on port 8000 and exposes `GET /health` for load-balancer health checks.

## 2. Environments

| Environment | Purpose | Default region | Notes |
|---|---|---|---|
| sandbox | Developer validation | ap-south-1 | No customer document content |
| staging | Integration testing | ap-south-1 | May use scoped temporary exception in ADR-004 |
| production | Customer traffic | ap-south-1 | Security policy is mandatory |

The default region is a platform default, not a data-residency decision.

## 3. Region matrix

| Workload/data category | Allowed data-plane region |
|---|---|
| Public or Internal data | ap-south-1 |
| Restricted-EU customer document content | eu-central-1 |

**Footnote 1:** The region matrix applies to the data plane that stores or processes the restricted document content. Control-plane metadata that contains no document content may remain in the platform default region.

## 4. Required tags

Every managed resource must include:

- `service=document-processor`
- `owner=billing-platform`
- `environment=<environment>`
- `cost-center=FIN-42`
- `data-class=<public|internal|restricted-eu>`

## 5. Approved module versions

The handbook originally listed older module versions. The dated Platform Update below supersedes those versions where it differs.

| Module | Older handbook listing | Current approved version |
|---|---|---|
| VPC | 2.9.0 | 5.1.0 |
| ECS service | 3.2.0 | 3.4.1 |
| RDS PostgreSQL | 5.7.0 | 6.1.2 |
| S3 bucket | 1.7.0 | 1.9.0 |
| SQS queue | 2.3.0 | 2.5.0 |

## 6. Platform Update PU-2026-09-10

Effective: 2026-09-10
Approved by: Platform Architecture Board

The following module versions are approved for new changes:

- VPC module 5.1.0
- ECS service module 3.4.1
- RDS PostgreSQL module 6.1.2
- S3 bucket module 1.9.0
- SQS queue module 2.5.0

Existing environments may still show older versions in read-only inventory. Treat inventory as current state evidence, not as approval for new deployments.

## 7. Service networking pattern

Public ingress terminates at the ALB. ECS services are not directly exposed with public IPs. RDS is private. SQS and S3 are accessed through AWS APIs. The worker must not expose a public listener.
