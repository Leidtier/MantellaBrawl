Scriptname MantellaBrawl extends Quest hidden

Actor Property PlayerRef Auto
FavorDialogueScript Property DialogueFavorGeneric Auto
MantellaInterface Property EventInterface Auto

event OnInit()
    RegisterForModEvent(EventInterface.EVENT_ACTIONS_PREFIX + "npc_brawl","OnNpcBrawlActionReceived")
    RegisterForModEvent(EventInterface.EVENT_CONVERSATION_STARTED,"OnConversationStartedReceived")
    RegisterForModEvent(EventInterface.EVENT_CONVERSATION_ENDED,"OnConversationEndedReceived")
    RegisterForModEvent(EventInterface.EVENT_CONVERSATION_NPC_ADDED,"OnConversationNpcAddedReceived")
    RegisterForModEvent(EventInterface.EVENT_CONVERSATION_NPC_REMOVED,"OnConversationNpcRemovedReceived")
EndEvent

event OnNpcBrawlActionReceived(Form speaker)
    Actor aSpeaker = speaker as Actor
    if (aSpeaker)
        EventInterface.AddMantellaEvent(aSpeaker.GetDisplayName() + " wants to brawl with "+ PlayerRef.GetDisplayName())
        DialogueFavorGeneric.Brawl(aSpeaker, PlayerRef)
    endif
endEvent

event OnConversationStartedReceived()
    Debug.Notification("A brawl is about to happen!")
endEvent

event OnConversationEndedReceived()
    Debug.Notification("Everyone goes their separate ways.")
endEvent

event OnConversationNpcAddedReceived(Form npc)
    Actor aSpeaker = npc as Actor
    Debug.Notification("A new challenger approaches. It is " + aSpeaker.GetDisplayName())
endEvent

event OnConversationNpcRemovedReceived(Form npc)
    Actor aSpeaker = npc as Actor
    Debug.Notification("Battered and bruised, " + aSpeaker.GetDisplayName() + " leaves the brawl.")
endEvent