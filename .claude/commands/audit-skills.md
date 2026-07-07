# /audit-skills — Skills reuse/gap audit (run FIRST, before any content work)

TIMEBOX: one session. Output is a one-page report. If you find yourself
producing more than one page, you are doing planning, not auditing — stop
and ship the page.

## Steps
1. Read my existing skills: the ~/.claude/ config repo, all SKILL.md files,
   and the five engineering-discipline skills (Grill Me, PRD writing,
   PRD-to-Issues, TDD, Architecture Review).
2. Cross-reference against what this project needs (see CLAUDE.md).
3. Produce the report — exactly three sections:
   - REUSE AS-IS: existing skills that apply directly. Name them, one line each.
   - EXTEND: existing skills needing a small addition. Name the skill, name
     the one addition, nothing more.
   - GENUINELY NEW: skills this project needs that don't exist. PROPOSE each
     (name + 2-line purpose). Do NOT build any of them.
4. STOP. Wait for approval on any proposed new skill before creating it.

## Why this exists
I over-index on planning and under-index on reusing what's built.
This command is the guardrail: check before you create, and do it once.
