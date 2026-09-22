---
name: repository-understanding
description: "Understand repo before modifying: map language, framework, entry points, modules, contracts, configs, data, tests, CI/CD. Never redesign un-understood code."
---

# repository-understanding

Understand repo before modifying: map language, framework, entry points, modules, contracts, configs, data, tests, CI/CD. Never redesign un-understood code.

## Structuring pipeline (how this skill connects)

```
UNDERSTAND REPOSITORY (this skill) -> IDENTIFY LANGUAGE + FRAMEWORK (languages/*, frameworks/*)
  -> IDENTIFY EXISTING ARCHITECTURE -> PRESERVE ESTABLISHED CONVENTIONS
  -> DETERMINE MODULE BOUNDARIES (architecture/modularity, architecture/language-modularity)
  -> IMPLEMENT (core/implementation) -> REVIEW DEPENDENCY DIRECTION (architecture/modularity step 4)
  -> TEST -> REVIEW DIFF (core/code-review)
```

Never restructure an existing project merely because another architecture is theoretically cleaner. Smallest safe change; deepen, don't rewrite.
