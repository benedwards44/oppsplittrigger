/**
* Author:       Ben Edwards
* Date:         13/05/2015
* Description:  Trigger for OpportunityTeamMember object
*
*/
trigger OpportunityTeamMemberTrigger on OpportunityTeamMember (after insert) {

	// Instantiate handler class
	OpportunityTeamMemberHandler handler = new OpportunityTeamMemberHandler();

	// Determine action to run
    if (Trigger.isAfter) {

    	if (Trigger.isInsert) {

    		handler.onAfterInsert(trigger.new);

    	}

    }

}