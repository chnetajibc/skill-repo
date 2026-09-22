# Validation (2026-09-23, `bash scripts/validate.sh` + doc-behavior tests)

- Leaves: 103 top-level SKILL.md. Frontmatter name+description: OK all.
- Relative links: new-skill links all resolve; pre-existing upstream-layout breaks allowlisted in `scripts/known-broken-links.txt` (warn, migration-queued) — any NEW broken link fails validation.
- Registry: `framework-registry.yaml` — 110 entries, all https, key hosts verified (incl. expressjs.com, chakra-ui.com, ant.design, headlessui.com, react-spectrum.adobe.com, schema.org), no duplicate keys.
- Duplicate leaf names: none unexpected (`api-design` intentional split).
- Orphaned references: none. Executable scripts: all own scripts +x (vendored upstream excluded).
- Doc-behavior tests: `run-doc-behavior-tests.sh` — 17/17 PASS.
- Size: 0 long leaves remaining from the original 37 (all migrated to references-first routers; verbatim preserved under each leaf's references/).
- Scanner/tool gates: search/MCP tool gates in documentation-search; scanner gates in secrets-supply-chain; UI-lib detection in detect-versions.sh; graceful-degradation notes in framework/deploy skills.
