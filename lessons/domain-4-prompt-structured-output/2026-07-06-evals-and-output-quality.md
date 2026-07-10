# evals-and-output-quality
Maps to: Domain 4 (Prompt engineering and structured output)
Source: W6 "EvalsWeek 6 Session 1"
Risk: LOW. One caution: never let an LLM judge gate a security decision by
itself; evals inform, deterministic checks decide.

## A. Index
Evals turn "the prompt seems better" into a measured claim: a fixed input
set, expected outputs or grading criteria, and a score you can compare
across prompt versions. Same discipline as tuning a SIEM rule against a
known-alert corpus before deploying it.

## B. Build
Take one prompt you use repeatedly and build a 10-case eval set: inputs,
expected outcomes, pass criteria. Run the current prompt, change one thing
(add explicit criteria or two few-shot examples), and run again.
You're done when: both runs are scored on the same 10 cases and you can say
which version won, by how much, and on which case types.

## C. Read
https://docs.claude.com/en/docs/test-and-evaluate/eval-tool
TODO: verify current location of Anthropic's eval guidance at review time.
