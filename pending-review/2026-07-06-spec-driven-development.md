# Draft station: spec-driven-development
Maps to: Domain 3 (Claude Code configuration and workflows)
Source: W2 "SpecDriven Development", "Spec Kit", "Specs 3", Assignment 2 "SpecDriven FeatureFactory"
Risk: LOW

## A. Index
Spec first, code second: a written spec is the contract the agent builds
against and the referee when output drifts. Fixes go in the spec file, not
in chat corrections that evaporate at session end.

## B. Build
Pick a small feature for a real project. Write the spec (behavior, inputs,
outputs, acceptance checks), then have Claude Code implement strictly from
the spec file with the instruction to stop and report any gap instead of
improvising.
You're done when: the feature passes the acceptance checks written in the
spec, and at least one gap got reported back instead of silently guessed.

## C. Read
https://github.com/github/spec-kit
TODO: swap for Anthropic's own spec-driven workflow doc if one exists at
review time; Spec Kit is the course's tool but it is a GitHub project.
