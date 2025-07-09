---
description: "Split a task into independent sub-tasks and execute them sequentially"
allowed-tools: ["bash", "write"]
---

# Task Orchestrator

Take this task, and split it up into independent sub-tasks to be implemented by claude code. Note, the output from one task will NOT be passed to the output of the next task, so each sub-task must be independent. You can make each task check the result of the task before it to ensure there are no conflicts.

$ARGUMENTS

Now, write a bash script at `orchestrator.sh` that contains an array of strings, each string representing one sub-task. The script should call `claude -p <subtask>` in a loop so each subtask is properly executed. Finally, execute the orchestrator script.

!chmod +x orchestrator.sh && ./orchestrator.sh