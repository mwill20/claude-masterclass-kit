# /review-queue — Surface pending items, take yes/no, commit approved ones

## Steps
1. List everything in /pending-review/. If empty, say so in one line and stop.
2. For each item, present conversationally, plain language, this exact shape:

   "Anthropic shipped [X]. Maps to [lane] → [station]. What it does: [2 lines].
   Risk: [tag]. Add it to the Master Class?"

3. Take the answer per item:
   - YES → move content into the live tree at the mapped lane/station.
     One commit per item: "add(domain-N): <station>" or "update(...)".
   - NO → move the file to /pending-review/declined/ (keep the record).
   - LATER → leave it in place, note the date it was deferred.
4. Michael's answer in this session IS the authorization. No answer = no action.
   Never merge, never push, never "helpfully" batch-approve.
5. After processing, one-line summary: N approved, N declined, N deferred.
6. Housekeeping flag: if the "what's new" lane now holds 2+ related entries,
   suggest graduating them to a real lane (per CLAUDE.md graduation rule).
   Suggest only — Michael decides.
