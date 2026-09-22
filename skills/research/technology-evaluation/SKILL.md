---
name: technology-evaluation
description: "Technology evaluation: fitness functions, landscape, proportional governance, migration guidance. Decide with trade-offs and reversibility."
---

# technology-evaluation

Technology evaluation: fitness functions, landscape, proportional governance, migration guidance. Decide with trade-offs and reversibility.

## Sources fused without loss (verbatim)

- source-1 magnus919-agent-skills/technology-radar in references/source-1-verbatim/
- source-2 magnus919-agent-skills/research-methodology in references/source-2-verbatim/
- Both bodies inlined below in full. Stricter wins on overlap; if conflict prefer safer/security-first and note assumption.

--- BEGIN VERBATIM SOURCE 1: magnus919-agent-skills/technology-radar ---

---
name: technology-radar
description: Build and maintain technology radars for adoption, trial, assessment, and hold decisions, and choose proportionate architecture-governance paths for technology portfolios. Use when governing technology choices, build-versus-buy decisions, architecture standards, exceptions, or engineering portfolio risk. Do not use for enterprise capability or target-state architecture, writing ADRs, implementing systems, security engineering, or operational incident/runbook work.
license: MIT
compatibility: No runtime dependency.
metadata:
  source_repo: https://github.com/magnus919/hermes-profiles
  source_commit: 867a555
---


# Technology Radar

CTO methodology for making technology decisions, governing architecture, measuring engineering effectiveness, managing technical debt, and operating an innovation pipeline. These frameworks help a CTO balance short-term delivery velocity with long-term platform health.

## When Not to Use

- Route enterprise capability maps, operating-model design, and current/target-state roadmaps to [`enterprise-architecture`](../enterprise-architecture/SKILL.md). This skill stays focused on technology portfolio posture and governance mechanics; use [`software-architecture`](../software-architecture/SKILL.md) for system-level target design.
- Route the durable record of one consequential decision to `adr-authoring`; use this skill to choose the governance path and connect the decision to standards or radar feedback.
- Route system design and code changes to the relevant engineering skill, security requirements and threat modeling to `secure-software-engineering`, and live operations or SLO work to `site-reliability-engineering`.

## Domain Model

| Domain | Covers | Artifact |
|--------|--------|----------|
| **Technology Radar** | Adopt/Trial/Assess/Hold quadrants, tool selection criteria, deprecation policy | Technology radar document |
| **Build vs Buy** | TCO analysis, decision matrices, vendor evaluation, integration cost | Build-vs-buy recommendation |
| **Architecture Governance** | Automated policy, federated decisions, advice processes, centralized review, standards, exceptions, and feedback | Governance decision record, standard, exception, radar update |
| **Engineering Metrics** | DORA (deploy frequency, lead time, MTTR, change failure rate), SPACE, DevEx | Engineering dashboard, health report |
| **Technical Debt** | Interest calculation, remediation prioritization, principal estimation | Technical debt register |
| **Innovation Pipeline** | Horizon scanning, POC criteria, production readiness gates | Innovation funnel, POC report |

## When to Load

Load this skill when the task involves:

- Evaluating a new technology or tool for adoption
- Making a build-vs-buy decision with TCO analysis
- Designing or auditing architecture governance processes
- Setting up engineering metrics dashboards (DORA, SPACE)
- Quantifying and prioritizing technical debt remediation
- Running an innovation pipeline with POC-to-production gates
- Deprecating or retiring legacy technology
- Selecting or auditing automated policy, federated decisions, advice processes, or centralized review


## Governance Workflow

For architecture or technology-governance work, read `references/architecture-governance.md` and:

1. Establish the decision, intended outcome, affected systems and teams, evidence available, and the decision owner.
2. Assess reversibility, scope, risk, blast radius, regulatory exposure, and cross-team impact. Record uncertainty instead of converting it into a false score.
3. Select the lightest governance mode that still controls the credible downside: automated policy, federated decision, advice process, or centralized review. Escalate when evidence shows that the decision is less reversible, broader, riskier, or more regulated than first assumed.
4. Define the decision record, implementation checks, exception path, and signals that will cause reconsideration.
5. Feed implementation and operational evidence back into the decision, standards, exceptions, and radar posture. Treat feedback as a reason to learn, not as retroactive blame.

## Reference Files

| Reference | Load When | File |
|-----------|-----------|------|
| Technology Radar | You need to evaluate and categorize a technology or tool for adoption, trial, assessment, or hold | `references/technology-radar.md` |
| Build vs Buy | You're comparing build vs buy options with TCO analysis and decision criteria | `references/build-vs-buy.md` |
| Architecture Governance | You're choosing or auditing proportional governance modes, standards, exceptions, escalation, or feedback | `references/architecture-governance.md` |
| Engineering Metrics | You need to measure engineering effectiveness with DORA, SPACE, or DevEx frameworks | `references/engineering-metrics.md` |

## Design Principles

1. **Technology is a means, not an end.** Every technology decision must trace back to a business outcome. "Because it's new" is not a reason to adopt. "Because it solves X faster/safer/cheaper" is.
2. **Radar is a living document.** A technology radar should be refreshed when evidence, strategy, risk, or usage changes materially. Set a cadence that fits the portfolio, and make significant adoption, hold, promotion, or retirement decisions trigger an update rather than waiting for a calendar event.
3. **Build vs buy is never just cost.** Total Cost of Ownership includes maintenance, hiring, training, integration, migration, and opportunity cost. A cheaper build today may be vastly more expensive over 3 years.
4. **Engineering metrics measure the system, not the people.** DORA metrics measure the delivery capability of the org. SPACE measures developer satisfaction. Neither is a performance review tool for individuals.
5. **Technical debt has a principal and an interest payment.** The principal is the cost to fix it properly. The interest is the recurring drag on velocity. Prioritize debt where interest/principal ratio is highest.
6. **Production readiness gates exist to prevent crisis.** Every gate that is skipped in the name of speed will be paid for in incident response time later.
7. **Governance should follow consequence.** Local and reversible decisions should stay local; irreversible, regulated, high-blast-radius, or materially cross-team decisions need stronger coordination or authority.

## Portability

This skill is intentionally host-neutral. Use your agent's normal mechanisms to load the references, templates, and scripts listed here. Do not assume a particular profile system, task orchestrator, memory service, or response-handoff format.

--- END SOURCE 1 ---

--- BEGIN VERBATIM SOURCE 2: magnus919-agent-skills/research-methodology ---

---
name: research-methodology
description: >-
  Plan, conduct, evaluate, and synthesize rigorous research investigations with credible
  evidence and a traceable method, including source-to-claim closure for media evidence.
  Do not use this skill for repeated source extraction and durable note orchestration;
  use `research-and-vault` for that capture workflow, or `ffmpeg` for media operations.
license: MIT
compatibility: No runtime dependency. Use appropriate retrieval tools and retain source URLs and access dates in the research log.
metadata:
  source_repo: https://github.com/magnus919/hermes-profiles
  source_commit: 867a555
---


# Research Methodology

Professional research process for a subagent. Three tracks based on the type of research:

- **Journalistic** — investigative pieces, primary source research, source-heavy narrative work
- **Industry analysis** — market research and strategy, signal detection
- **Academic/Comprehensive** — deep systematic research when depth matters most

All three share the same lifecycle (Scope → Gather → Evaluate → Analyze → Synthesize → Report) but differ in evidence standards, speed, and output format.

Media evidence is a technical-verification extension, not a fourth operational track. This skill owns research scope, source evaluation, claim closure, sampling-completeness audits, exclusions, and durable preservation. The `ffmpeg` skill owns FFmpeg commands, media probes, extraction, editing, rendering, and target verification; human or capable reviewers own semantic/editorial observations and approval. Load `references/media-evidence-routing.md` whenever a research conclusion depends on media tooling, sampled frames/audio/transcripts, or editorial judgment.

## When not to use

Do **not** load this skill for:

- A single factual lookup or a quick answer — respond directly; a full research lifecycle adds cost without adding credibility.
- Direct implementation work that needs no investigation — build and verify the change instead (`backend-engineering`, `frontend-engineering`).
- Operating a specific retrieval or capture tool — load that tool's skill for runbook-level configuration and diagnostics.
- Raw capture of web content without evaluation or synthesis — the capture tool's own skill covers fetching; this skill starts where source evaluation begins.
- Structuring already-gathered findings into durable summaries, analysis files, and evidence dossiers — use `artifact-pyramids` for the output architecture.
- Persisting captured sources into durable notes across a repeated research-to-note sequence — use `research-and-vault`.

## The Research Lifecycle

```
SCOPE → GATHER → EVALUATE → ANALYZE → SYNTHESIZE → REPORT
```

## Durable Artifact Gate

Research is not complete when an agent has produced a plausible answer. It is complete when the reusable evidence and reasoning have been preserved in the durable format that is natural to the host system and its users.

Before reporting, make the preservation decision explicit:

1. **Identify the durable destination.** Use the host's normal long-lived research surface: linked knowledge records, a tracked report package, a research database, a project document, or another user-visible artifact. Do not leave the only useful output in chat, a transient workspace, or an untracked scratch file.
2. **Extract at the source's natural granularity.** Capture every distinct, reusable claim, data point, method, contradiction, and open question that materially changes future reasoning. Do not use a fixed atom, finding, or note count as a stopping rule. Continue until each retained source is accounted for in the extraction log.
3. **Preserve provenance and relationships.** Each durable artifact must retain its source URL or citation, access date, evidence strength, and links to the question, related artifacts, and any synthesis that depends on it.
4. **Separate extraction from synthesis.** A brief or report explains the conclusion; it does not replace the underlying evidence records. Preserve source-level records and reusable claims before compacting them into a synthesis.
5. **Record what was not preserved.** If a source was rejected, too weak, inaccessible, redundant, or out of scope, record that decision in the research log. A future researcher must be able to distinguish an intentional exclusion from an overlooked source.

The right artifact shape depends on the environment. Do not assume a particular database, note-taking application, or orchestration system. The invariant is durable, navigable, evidence-linked research that a later user or agent can discover and build on.

## Interruption and Timeout Recovery

A research worker timeout is an interruption, not a research result. Never close the investigation, summarize it as complete, or infer that no useful work exists because a delegated worker exceeded its execution cap. Long research jobs commonly encounter slow extraction, rate limits, or one unresponsive source after producing valuable partial work. Plan long research as bounded, resumable subtasks: use task-appropriate execution windows, write incremental checkpoints, and resume from the latest verified checkpoint instead of imposing arbitrary short caps or assuming an unbounded window is available.

When a worker times out:

1. Read the complete delegation transcript and inspect the workspace or scratch directory before deciding what was lost.
2. Recover and verify every partial artifact, source log, and extracted claim already written.
3. Resume from the last durable checkpoint rather than restarting broad discovery.
4. Narrow or replace the slow operation, especially large PDF extraction or repeated rate-limited search, and write each subsequent stage incrementally.
5. If the worker cannot be resumed safely, continue the missing research directly or split it into smaller bounded tasks. A timeout changes the execution path, not the acceptance criteria.
6. Do not report completion until the research question is covered, retained sources and claims are represented in the durable evidence artifacts, and unresolved gaps are explicit.

The acceptance gate is evidence completeness and artifact verification, not elapsed time, worker status, or the existence of a plausible partial summary.

## Reference Files

### Tracks

| Track | Reference | When to load |
|-------|-----------|-------------|
| **Journalistic** | `references/journalistic-research.md` | You're researching an investigative piece — primary sources, interviews, documents, series management, pre-publication verification |
| **Industry analysis** | `references/industry-analysis.md` | You're researching an industry analysis piece — signal detection, corporate evidence, competitive intelligence, case study standards |
| **Academic / Comprehensive** | `references/research-lifecycle.md` | You're doing deep systematic research — question scoping, search strategy, inclusion/exclusion criteria |

### Shared Methodology

| Reference | When to load |
|-----------|-------------|
| `references/source-evaluation.md` | You need to judge whether a source is credible — CRAAP test, triangulation, reliability tiers |
| `references/structured-analytic-techniques.md` | You need to evaluate competing explanations — ACH, driving forces, pre-mortem, indicators |
| `references/synthesis-patterns.md` | You need to combine findings from multiple sources into synthesized conclusions |
| `references/technical-verification.md` | You need to test a technical claim by reproducing it — benchmarks, API behavior, configuration |
| `references/media-evidence-routing.md` | Media research needs an explicit research/FFmpeg/reviewer boundary, sampling audit, or source-to-claim closure |

### Assets

| Asset | What it produces |
|-------|-----------------|
| `assets/research-brief.md` | Structured brief with findings, confidence assessment, evidence table, open questions |
| `assets/research-log.md` | Traceable record of searches, sources, and decisions |
| `assets/media-claim-ledger.md` | Media brief boundary, claim-to-source/experiment closure, sampling audit, and exclusion log |

Use both assets for every substantial investigation. Before closing the work, complete their durable-artifact sections and verify that retained sources and extracted claims are represented in the destination system.

## Pre-Publication Gateway

For any piece that makes factual claims, load the relevant track's verification protocol before reporting back:

- **Journalistic:** 7-step pre-publication protocol from `references/journalistic-research.md`
- **Industry:** 7-step research protocol from `references/industry-analysis.md`
- **Technical:** 5-step reproduction protocol from `references/technical-verification.md`

## Portability

This skill is intentionally host-neutral. Use your agent's normal mechanisms to load the references, templates, and scripts listed here. Do not assume a particular profile system, task orchestrator, memory service, or response-handoff format.

--- END SOURCE 2 ---
