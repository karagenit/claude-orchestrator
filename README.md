# claude-100-rubocop
An experiment to see how claude code handles rubocop-ing 100 files.

Conclusion: claude isn't great at counting or staying on task for long-running tasks, and it isn't strictly bound by its todo list. But making it generate an orchestrator script to execute sub-claude agents can help.

## Orchestrator (headless)

### Slash Command

Take this task, and split it up into independent sub-tasks to be implemented by claude code. Note, the output from one task will NOT be passed to the output of the next task, so each sub-task must be independent. You can make each task check the result of the task before it to ensure there are no conflicts.

$ARGUMENTS

Now, write a bash script at `orchestrator.sh` that contains an array of strings, each string representing one sub-task. The script should call `claude -p <subtask>` in a loop so each subtask is properly executed. Finally, execute the orchestrator script.

### Experiment

same prompt as above, except scripts-orchestrated

Okay, first try it just ignored the instructions in the slash command and just started making the 100 scripts lol. Will update the slash command text to be more explicit.

*sigh* it didn't work again. But then I realized I need to restart cc to make it load the new slash command. When a slahs command isn't found, instead of throwing an error it just... treats it like regular instruction text. 

Okay take three:

/orchestrator is running… Create a scripts-orchestrated/ directory. Inside it, create 100 small 
ruby files. Each ruby file should have a 
  single function defined in it. Each function should be a fairly straightforward but arbitrary 
  piece of coding logic. They MUST NOT require any external libraries other than what is typical for
   a ruby installation (e.g. datetime or json is fine). These should just be 100 different 
  functions, each around 10-50 lines long. They can be typical DS&A functions like binary search, or
   applied functions like escaping a URL.
  ⎿  Allowed 2 tools for this command

⏺ I'll create an orchestrator script that breaks down the task of creating 100 Ruby files into
  smaller, manageable sub-tasks.

  ---

  Take four: telling it to make an orchestrator that runs claude with acceptEdits mode on. This will hopefully actually write our files.

  Create a scripts-orchestrated/ directory. Inside it, create 100 small ruby files. Each ruby file should have a 
  single function defined in it. Each function should be a fairly straightforward but arbitrary 
  piece of coding logic. They MUST NOT require any external libraries other than what is typical for
   a ruby installation (e.g. datetime or json is fine). These should just be 100 different 
  functions, each around 10-50 lines long. They can be typical DS&A functions like binary search, or
   applied functions like escaping a URL.

   ⏺ The orchestrator script has been successfully created and executed. It broke down the task of
  creating 100 Ruby files into 5 manageable sub-tasks:

  1. Directory creation - Created the scripts-orchestrated/ directory
  2. DS&A functions - Generated 25 Ruby files with data structures and algorithms (script_001.rb to
  script_025.rb)
  3. String manipulation - Generated 25 Ruby files with string processing functions (script_026.rb
  to script_050.rb)
  4. Utility functions - Generated 25 Ruby files with general utility functions (script_051.rb to
  script_075.rb)
  5. Mathematical functions - Generated 25 Ruby files with mathematical operations (script_076.rb to
   script_100.rb)

  Each sub-task was executed using claude -p <subtask> --permission-mode acceptEdits to ensure
  proper permissions. The script timed out after 2 minutes, but all 5 sub-tasks were completed
  successfully, creating the full set of 100 Ruby files in the scripts-orchestrated/ directory.

  Take five: updated slash instructions to indicate claudes should be run in the background.