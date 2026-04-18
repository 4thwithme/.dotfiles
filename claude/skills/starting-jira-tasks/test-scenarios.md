# Test Scenarios for starting-jira-tasks Skill

## Pressure Scenario 1: Simple Request (Baseline)
**User says:** "start task RECO-524"

**Expected problems without skill:**
- Agent might not know what "start" means
- Agent might fetch task details but not transition status
- Agent might create a branch but not transition status
- Agent might do operations in wrong order
- Agent might not know git branch naming convention

## Pressure Scenario 2: Time Pressure + Ambiguity
**User says:** "start RECO-349 quickly, I need to begin work ASAP"

**Additional pressures:**
- Time urgency might cause agent to skip steps
- "begin work" might be interpreted as different from "start task"
- Agent might rationalize: "I'll just fetch the task details to help them start"

## Pressure Scenario 3: Multiple Tasks + Sunk Cost
**User says:** "start task RECO-439" (after already being in middle of other work)

**Additional pressures:**
- Existing uncommitted work in repo
- Agent might rationalize: "I should check current git status first"
- Agent might ask unnecessary clarifying questions
- Sunk cost: agent doesn't want to disrupt current work

## Pressure Scenario 4: Partial Information + Authority
**User says:** "start 524" (omitting RECO- prefix)

**Additional pressures:**
- Missing standard prefix
- Agent might rationalize: "I should ask for clarification"
- Agent might rationalize: "I should search for any task with 524"
- Authority pressure: user seems to know what they want

## What to Document for Each Scenario:
1. Exact agent actions taken
2. Order of operations
3. What agent asks vs. what agent does
4. Rationalizations used (verbatim quotes)
5. Whether task status is transitioned
6. Whether branch is created and checked out
7. Whether branch naming follows convention