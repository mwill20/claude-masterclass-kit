# Draft station: docker-deployment-artifacts  [LANE 6 — whats-new, FLAGGED]
Maps to: whats-new (deployment is not a CCA-F domain; Michael's call on
graduation or leaving it staged)
Source: W6 "Docker & Deployment Artifact Generation", "Docker _ Deployment Artifacts"
Risk: MED. Generated Dockerfiles and compose files are executable
infrastructure: review base images, exposed ports, and secrets handling
before running anything generated.

## A. Index
Claude Code generates deployment artifacts (Dockerfile, compose, CI deploy
steps) from the repo it can already read, which beats copying templates
because the artifact matches the actual app. You still own the review.

## B. Build
Have Claude Code containerize one of your Python projects: Dockerfile,
.dockerignore, compose file. Review line by line for pinned base image
version, non-root user, and no secrets baked in, then build and run it.
You're done when: the container runs the app, and your review notes list
the three checks above with pass/fail.

## C. Read
TODO: no single canonical Anthropic doc for this topic; candidate is the
common-workflows page. Decide at review time.
