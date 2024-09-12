# Mantella Brawl
This is an example project to show how to plug into Mantella's mod interface.

## Requirements
- SKSE
- Mantella

Mantella does not need to be a hard reference of your mod.

## Reacting to MantellaConversations

Mantella comes with a `MantellaInterface.psc`. This script contains the official interface to hook into Mantella:
- Events
  - A prefix for arbitrary action events (see [Actions](#Actions) below)
  - Start of a Mantella conversation
  - End of a Mantella conversation
  - An Actor was added to a Mantella conversation
  - An Actor was removed from a Mantella conversation
- Functions
  - AddMantellaEvent <- Adds an ingame event to Mantella's list of events that will be added to the next user message. e.g. "*The location is now Whiterun.*"

Mantella uses the SKSE ModEvent to send event notification to registered callbacks. Examples for how to register can be found in [`MantellaBrawl.psc`](https://github.com/Leidtier/MantellaBrawl/blob/main/Scripts/Source/MantellaBrawl.psc). 
`MantellaBrawl.esp` provides a single `MantellaBrawl` Quest that has two scripts: `MantellaBrawl.psc` and `MantellaInterface.psc`. `MantellaBrawl.psc` is referencing `MantellaInterface.psc` using a property.

## Actions

It is possible to define custom actions for the LLM to trigger that can then be caught on the Papyrus side.
1. Add a `.json` file to `SKSE\Plugins\MantellaSoftware\data\actions\` of your mod. Similar to [`Brawl.json` here](https://github.com/Leidtier/MantellaBrawl/blob/main/SKSE/Plugins/MantellaSoftware/data/actions/Brawl.json). The name does not matter but it should not collide with an action of Mantella or of another mod. Try to keep it unique.
2. The content of the `.json` needs to look like this:
  ```json
  {
    "identifier": "npc_brawl",
    "name": "Brawl",
    "description": "The keyword used by the NPC when they want to brawl with the player.",
    "key": "Brawl",
    "prompt": "If the speaking NPC prefers to settle a dispute with the player by a fist fight lead your reply with '{key}:'",
    "is-interrupting": false,
    "one-on-one": true,
    "multi-npc": false,
    "radiant": false,
    "info-text": "The NPC wants to beat up the player!"
  }
  ```
  - `identifier`: This is the identifier of your action. The name of the event that will be triggered is the action prefix from 'MantellaInterface.psc' + this identifier
  - `name`: Used in the Mantella UI to identify your action to the user in a human readable format
  - `description`: Used in the Mantella UI to describe your action
  - `key`: This is the default keyword the LLM is gonna use to trigger your action. Can be overriden by the user in the langauge settings
  - `prompt`: The action instruction added to the prompt. '{key}' will be replaced by the key.
  - `is-interrupting`: Is this an interrupting action? If yes the generation of the LLM will be stopped after the sentence it is in
  - `one-on-one`: Can be triggered in a One-on-One conversation (PC + NPC)
  - `multi-npc`: Can be triggered in a multi-npc conversation (PC + multiple NPCs)
  - `radiant`: Can be triggered in a radiant conversation (multiple NPCs, no PC)
  - `info-text`: Info message logged in 'Mantella.exe's console when the action is triggered.
3. Now Mantella will trigger a ModEvent called `MantellaConversation_Action_npc_brawl` (prefix + identifier from 2.)
4. Register as listener for the ModEvent like [here](https://github.com/Leidtier/MantellaBrawl/blob/ae9565be4f1e5ae60cb77293658dc7d36ace74f6/Scripts/Source/MantellaBrawl.psc#L7-L13) (you only need to register to the events you are interested in)
