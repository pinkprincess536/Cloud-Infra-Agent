# CedarPeak Systems - Cost Guidance and Operational Notes

Document ID: OPS-2026-09
Owner: FinOps + SRE

## Cost guidance

The platform team does not define a universal "reasonable cost" for document processing because the answer depends strongly on request rate, average file size, maximum file size, retention, and concurrency.

For a first production estimate, collect:

- peak documents per minute
- average file size
- maximum file size
- expected retention period
- required monthly budget ceiling

Without those values, produce a qualitative architecture and ask for the missing sizing/cost inputs rather than inventing a precise monthly estimate.

Sandbox guidance: keep non-production validation below INR 12,000/month where practical. This is guidance, not a hard security rule.

## Operational lesson - queue backlog

Incident OPS-2026-08-21 recorded an 18-minute backlog during a partner file burst. The API remained healthy, but worker concurrency was too low. The lesson was to size worker concurrency from measured peak queue depth and processing time, not from API request rate alone.

Recommended initial signal: alert when the oldest SQS message age exceeds 120 seconds for 10 consecutive minutes.

## Cost and architecture boundary

Do not trade away private RDS access, encryption, or residency controls solely to lower cost. Cost choices must remain within security policy and approved architecture boundaries.
