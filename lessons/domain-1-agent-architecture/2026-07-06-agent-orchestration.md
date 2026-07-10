# agent-orchestration
Maps to: Domain 1 (Agent architecture and orchestration)
Source: W5 "Agent_Orchestration", "Multi-Agent Engineering & Organizational Tooling"
Risk: MED. Orchestration decides which agent acts with which authority.
Boundary errors here are authorization errors, the SOAR playbook analogy:
every automated step needs a defined actor and approval gate.

## A. Index
Orchestration patterns: hub-and-spoke (coordinator delegates to specialists),
fixed pipeline (deterministic stage order), and dynamic decomposition (the
model splits the task at runtime). Pick fixed pipelines for production paths,
dynamic for exploration.

## B. Build
Take one real task you did manually this month and decompose it on paper into
a coordinator plus 2-3 specialist roles, each with: goal, inputs, tools it
may use, and what it must NOT do. Then run it as a single Claude Code session
dispatching subagents per your design.
You're done when: the task completes, and each subagent stayed inside the
role card you wrote (check the transcript).

## C. Read
https://docs.claude.com/en/api/agent-sdk/overview
TODO: verify against current Anthropic multi-agent guidance when reviewing.
