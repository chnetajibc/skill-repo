---
name: api-security
description: "Secure APIs as hard gate: BOLA, authn/authz, property-level authz, consumption limits, SSRF, misconfig, inventory. Ask: can A access Bs object? Can low-privilege hit admin?"
---

# api-security

Secure APIs as hard gate: BOLA, authn/authz, property-level authz, consumption limits, SSRF, misconfig, inventory. Ask: can A access Bs object? Can low-privilege hit admin?

## Sources fused without loss

- 1: owasp-secure-agent-playbook/plugins/code-security-skills/skills/api-security-review
- 2: bjornjee-skills/skills/security-design
- 3: rubencr14-agent-skills/skills/cybersecurity
- All inlined below in full. Stricter wins.

--- BEGIN 1: owasp-secure-agent-playbook/plugins/code-security-skills/skills/api-security-review ---

---
name: api-security-review
description: Comprehensive API security review against OWASP API Security Top 10 (2023). Use when reviewing OpenAPI/Swagger specs, auditing REST/GraphQL/gRPC implementations, testing authentication mechanisms, or checking API gateway configurations. Covers BOLA/IDOR, broken auth, mass assignment, rate limiting, SSRF, and more with real-world attack scenarios.
license: CC-BY-4.0
---

# API Security Review

Perform comprehensive API security assessment following `plays/api-security-review.md`.

## Steps

1. **Discovery & Reconnaissance**
   - Parse OpenAPI/Swagger specs or scan code for endpoints
   - Identify authentication mechanisms (JWT, OAuth 2.0, API keys, mTLS)
   - Map API gateway and middleware configurations
   - Enumerate all API versions and deprecated endpoints

2. **Authentication Deep Dive**
   - JWT security (algorithm confusion, weak signing, token expiration)
   - OAuth 2.0 flows (PKCE, state parameter, redirect URI validation)
   - API key exposure and rotation policies
   - Session management and token storage

3. **Assess All 10 OWASP API Risks** with attack scenarios:
   - **API1 BOLA** — IDOR via predictable IDs, batch endpoint bypasses, ownership verification gaps
   - **API2 Broken Authentication** — JWT attacks, OAuth flaws, brute force, credential stuffing
   - **API3 BOPA** — Mass assignment, response over-exposure, field-level authz bypasses
   - **API4 Resource Consumption** — Rate limit bypasses, pagination abuse, GraphQL DoS
   - **API5 BFLA** — Admin endpoint discovery, horizontal/vertical privilege escalation
   - **API6 Business Flows** — Automated abuse, inventory exhaustion, scraping attacks
   - **API7 SSRF** — URL bypasses, DNS rebinding, cloud metadata access
   - **API8 Misconfiguration** — CORS bypasses, verbose errors, missing headers
   - **API9 Inventory** — Shadow APIs, zombie endpoints, version confusion
   - **API10 Unsafe Consumption** — XXE, deserialization, webhook replay attacks

4. **Automated Testing**
   - Run API security scanners (OWASP ZAP, Burp Suite, Postman tests)
   - Test for common vulnerabilities with specific payloads
   - Validate rate limiting and throttling mechanisms

5. **API Gateway & Infrastructure Review**
   - Kong, nginx, Envoy, AWS API Gateway configurations
   - WAF rules and bypass opportunities
   - TLS configuration and certificate validation

## Output

Comprehensive API security report including:
- API surface inventory with authentication mechanisms
- Risk matrix with severity ratings for all 10 categories
- Detailed findings with proof-of-concept examples
- Exploit scenarios and business impact analysis
- Prioritized remediation roadmap with code examples
- Testing artifacts and vulnerability evidence

## OWASP References

- OWASP API Security Top 10 (2023)
- OWASP ASVS v5.0 — V13: API and Web Service
- OWASP Testing Guide: WSTG-APIT
- OWASP Cheat Sheet: REST Security, GraphQL Security, JWT Security, OAuth 2.0

--- END 1 ---

--- BEGIN 2: bjornjee-skills/skills/security-design ---

---
name: security-design
description: Use when designing anything with a trust boundary — auth systems, secrets handling, service-to-service calls, user input surfaces. Design-time security; review-time checks live in the core doctrine.
---
# Security Design

Design-time rules. (Review-time checks — injection, XSS, SSRF, path traversal — already run in the core doctrine's Phase 4 pass; don't duplicate them here.)

## Threat model at the boundary
- New trust boundary (new input surface, new caller, new stored credential, new network hop) ⇒ a written 10-minute STRIDE pass in the plan: what can be Spoofed, Tampered, Repudiated, Info-leaked, DoS'd, Elevated. Skipping this is skipping the design.
- Name the assets (what's worth stealing), the actors (who touches the boundary), and the blast radius of each credential before writing the auth code.

## Secrets
- Injected at runtime: env vars from a secret manager / KMS, mounted files. Never in code, config files, images, or logs — grep the diff for high-entropy strings and known prefixes (`sk-`, `ghp_`, `AKIA`) in review.
- One secret, one purpose, one owner. Shared "the API key" across services means rotation breaks everything at once.
- Rotation is designed in, not bolted on: two valid credentials during the window (old + new), then revoke.
- `.env` files are for local dev only and are gitignored; the presence of a real production secret in one is an incident, not a convention.

## Authentication
- Service-to-service: mTLS or short-lived signed tokens (OIDC/workload identity). Static shared API keys between services are a migration debt the day they ship.
- Token lifetimes: access tokens ≤ 1 hour; refresh tokens rotate on every use and are revocable server-side. A non-expiring token is a credential leak with a delay.
- Passwords: argon2id/bcrypt via a maintained library, never hand-rolled comparison (timing) or hashing.
- Webhooks verify the provider-documented signature over the unmodified payload using its supported verification method; enforce signed freshness data when supplied. Delivery deduplication and idempotency belong to `distributed-systems`.

## Authorization
- Deny by default. The absence of a rule is a rejection, not an allow.
- Authz decisions live in **one** place (middleware/policy layer/service method) — scattered `if user.role ==` checks guarantee one path forgets.
- Check at the resource, not just the route: `GET /orders/{id}` verifies the order belongs to the caller (IDOR is the most common real-world authz bug).
- Log authz denials with actor + resource + rule — silent denials hide both attacks and misconfigurations.

## Data
- Validate input at the boundary (schema, types, ranges); encode output at the sink (HTML-escape at render, parameterize at SQL). Middle layers pass data through untouched.
- PII gets an inventory: which tables, which logs, which backups. You cannot honor deletion requests for data you can't locate.
- Encrypt in transit everywhere (TLS internal too); at rest for anything you'd disclose in a breach notification.

## When NOT to apply
Local dev tools and single-user scripts with no network surface: skip mTLS/rotation ceremony. The secrets rules apply everywhere — "it's just a script" is how keys reach GitHub.

--- END 2 ---

--- BEGIN 3: rubencr14-agent-skills/skills/cybersecurity ---

---
name: cybersecurity
description: Security rules, architecture decisions, and hardening guidelines for building secure systems. Use this skill whenever designing or reviewing a Next.js frontend, FastAPI backend, authentication flow, Docker environment, AI agent, RAG pipeline, admin tool, or any feature that handles user input, secrets, file uploads, external integrations, or sensitive business data. Also use when reviewing pull requests for security, preparing production deployments, or building any system that processes untrusted content. Covers OWASP top 10, container hardening, prompt injection defense, and supply-chain security.
---

## 10 Core Principles

1. Validate everything.
2. Authorize everything.
3. Trust nothing from the client.
4. Trust nothing from the model.
5. Minimize privileges everywhere.
6. Keep secrets out of code and logs.
7. Harden containers and networks by default.
8. Restrict tools, files, and outbound access.
9. Log security-relevant actions.
10. Design so compromise has limited blast radius.

## When to Use

- Designing or reviewing a Next.js frontend or FastAPI backend
- Creating authentication or authorization flows
- Building Dockerfiles or Docker Compose environments
- Adding file upload, search, scraping, or external integrations
- Creating admin dashboards or internal tools
- Building AI chat, agent, RAG, tool-calling, or automation systems
- Handling user-generated content or third-party content
- Preparing production deployments
- Reviewing pull requests for security-sensitive changes
- Implementing APIs that expose sensitive business data

## Core Security Philosophy

- Security must be designed into the architecture, not added as a final step
- Every external input is untrusted until validated
- Every internal component may eventually be compromised — design accordingly
- Prefer secure defaults, least privilege, narrow permissions, and explicit allowlists
- Prevention matters, but limiting blast radius after compromise matters equally
- Simplicity is a security feature — avoid unnecessary complexity and hidden magic
- Never trust the frontend for security decisions
- Never trust LLM output as safe, correct, or authorized
- If a feature is security-sensitive and unclear, choose the more restrictive behavior

## Golden Rules

1. **Validate all inputs** at every boundary
2. **Escape or sanitize all outputs** based on rendering context
3. **Authenticate every sensitive action**
4. **Authorize every resource access** — authentication ≠ authorization
5. **Never expose secrets** in code, logs, images, or client bundles
6. **Never execute user-controlled input** in shells, SQL, templates, or interpreters
7. **Never assume internal traffic is trustworthy**
8. **Never mount dangerous host resources** into containers
9. **Never let AI outputs directly perform privileged actions** without validation and authorization
10. **Every sensitive action must be observable**, auditable, and attributable

## Secure Architecture Rules

- Separate domain logic, application logic, infrastructure, and API layers — sensitive logic must not be scattered across routers or middleware
- Enforce authentication and authorization separately — being authenticated does not imply permission
- Perform object-level authorization on every resource access (IDOR prevention)
- Centralize auth rules — inconsistent enforcement across routes causes privilege escalation
- Apply least privilege by default to users, service accounts, tools, and background jobs
- Treat background jobs, workers, cron tasks, and internal endpoints as production attack surfaces
- Use allowlists instead of blocklists for input validation
- Validate at the boundary, then work with trusted internal types

## AI & Agent Security Rules

These rules are critical when building any AI-powered feature:

- **Treat all model inputs as untrusted** — user instructions, retrieved documents, web content, OCR, tool outputs can all contain prompt injection
- **Never let the model decide authorization** — LLMs are not security boundaries and can be manipulated
- **Separate trust layers explicitly** — system instructions, developer rules, user input, retrieved content, and tool results are NOT equally authoritative
- **Tell the model that retrieved content is data, not instructions** — hostile text can imitate system guidance
- **Use strict tool allowlists** — every available tool is part of the attack surface
- **Validate all tool arguments server-side** before execution — even aligned models can generate dangerous parameters
- **Require authorization checks outside the model** for sensitive tool calls (file access, email, payments, shell, data export, admin)
- **Treat model-generated code, SQL, shell commands, URLs as untrusted** — prompt injection and hallucinations produce harmful actions
- **Sandbox tool execution** with timeouts, memory limits, network restrictions, filesystem isolation
- **Prevent unrestricted browsing/retrieval** from feeding the model with high-trust privileges — malicious websites contain hidden prompt injection
- **Never give the model raw secrets or broad credentials** — assume they may appear in logs, outputs, or downstream prompts
- **Protect memory/context stores** from untrusted writes — persistent prompt injection survives across sessions
- **Require human approval for high-risk actions** — sending messages, writing files, purchases, production changes
- **Log every tool call** — validated arguments, acting identity, policy decision, execution result
- **Use typed output schemas** for planning and tool execution — structure reduces attack opportunities
- **Model proposes, policy layer decides** — separate reasoning from enforcement
- **Never let the model self-modify its security rules or tool permissions**
- **Test for prompt injection explicitly** — "ignore previous instructions," hidden HTML, fake tool responses, poisoned PDFs

## Quick Security Checklist

Before shipping any feature, verify:

- [ ] All external inputs validated with schemas (Pydantic/Zod)
- [ ] Authentication required for sensitive endpoints
- [ ] Authorization checked per resource (not just per route)
- [ ] No secrets in code, config, logs, or Docker images
- [ ] SQL uses parameterized queries (no string concatenation)
- [ ] No unsafe shell execution with user input
- [ ] Error responses do not leak internals
- [ ] Rate limits and request size limits applied
- [ ] Containers run as non-root with minimal capabilities
- [ ] AI tool calls validated and authorized outside the model
- [ ] Security-relevant events logged with request IDs
- [ ] Dependencies scanned for known vulnerabilities

## Security Review Decision Tree

```
Does the feature handle...
|
+-- Auth, secrets, uploads, external URLs, HTML rendering, admin actions, AI tool execution
|     --> Requires explicit security review
|
+-- New dependency, third-party API, browser script, Docker image, background worker
|     --> Requires supply-chain and privilege review
|
+-- User files, prompts, markdown, URLs, or documents that influence model behavior
|     --> Requires prompt injection and content safety review
|
+-- Payments, account data, exports, or internal tooling
|     --> Requires authorization and auditability review
|
+-- Shell execution, filesystem access, or code execution
      --> Must be sandboxed and reviewed as high risk
```

## Deep Dives

| File | Content |
|------|---------|
| `references/web-security.md` | Frontend (Next.js) + Backend (FastAPI) security rules, auth, secrets, input validation, API design |
| `references/docker-security.md` | Container hardening, infrastructure, network isolation, supply chain |
| `references/ai-agent-security.md` | AI/agent security, RAG, prompt injection, tool safety, admin tools |

## Practical Examples

| File | Content |
|------|---------|
| `examples/secure-fastapi-endpoint.py` | FastAPI endpoint with validation, auth, authorization, error handling |
| `examples/secure-nextjs-auth-flow.md` | Next.js auth with CSP, cookies, CSRF, redirect validation |
| `examples/secure-docker-compose.yml` | Hardened docker-compose with all security measures |

## Checklists

| File | Content |
|------|---------|
| `checklists/pull-request-security-checklist.md` | Security review checklist for PRs |
| `checklists/production-security-checklist.md` | Pre-deploy production readiness checklist |

--- END 3 ---
