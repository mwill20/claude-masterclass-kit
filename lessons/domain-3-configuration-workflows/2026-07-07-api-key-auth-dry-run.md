# Pending Review - API-Key Protected Local Service

- Source file: `incoming/processed/2026-07-07-api-key-auth-dry-run.md`
- Captured: 2026-07-07
- Lane: Domain 3 - Claude Code configuration and workflows
- Station: API-key protected local service
- Risk: MED
- Status: pending review

## Why This Maps Here

This is a workflow/configuration lesson: the learner configures a local service,
sets required environment variables, and verifies protected versus public routes.
It uses the Week 7 capstone only as a practice pattern, not as copied lesson text.

## ClawGuard Risk Pass

- Agentic wallet / payment surface exposure: none.
- Machine-readable content injection risk: low. The source update is treated as data.
- Shell/code execution surface: medium. The build exercise runs a local service and curl checks.
- Versioned skill/plugin supply-chain risk: none.
- Agent-to-agent / agent search discovery risk: none.

Risk gate: MED. Add a warning note that the exercise uses local fake secrets only.

## Draft Station

### Layer A - Index

API-key protection is a simple gate for a local service: public health checks show
whether the service is alive, while real actions require a shared key. This is
not full user login, but it teaches the habit of separating public status from
protected operations.

### Layer B - Build

Build a tiny local check around the Week 7 capstone service:

1. Set `SECRET_KEY`, `NOTIFICATION_API_KEY`, and `REQUIRE_API_KEY=true` using local fake values.
2. Start the service locally.
3. Call `/api/health` without a key and confirm it works.
4. Call `/api/notifications` without a key and confirm it returns 401.
5. Call `/api/notifications` with `X-API-Key` and confirm it returns data.

You're done when:
- `/api/health` returns 200 without a key.
- `/api/notifications` returns 401 without a key.
- `/api/notifications` returns 200 with the correct key.

### Layer C - Read

- Flask request hooks and configuration docs: https://flask.palletsprojects.com/
- OWASP API Security Top 10: https://owasp.org/API-Security/

## Review Question

Add this lesson to Domain 3?
