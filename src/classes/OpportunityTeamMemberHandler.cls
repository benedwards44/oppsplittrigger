/*
* Author:       Ben Edwards
* Date:         13/05/2015
* Description:  Trigger handler for OpportunityTeamMember Trigger
*/
public with sharing class OpportunityTeamMemberHandler {
	
	// Before Insert logic
	public void onAfterInsert (List<OpportunityTeamMember> newList) {

		// Create Opportunity Splits for new Team Members
		createOpportunitySplits(newList);
	}

	/*
	* Author:       Ben Edwards
	* Date:         13/05/2015
	* Description:  Creates associcate Split record when Team member is created
	*/
	private void createOpportunitySplits (List<OpportunityTeamMember> newList) {

		// List of Opp Splits to create
		List<OpportunitySplit> oppSplitsToCreate = new List<OpportunitySplit>();

		// Iterate over new team members to create new splits
		for (OpportunityTeamMember oppMember :newList) {

			// Create Opp Split and add to list
			oppSplitsToCreate.add(new OpportunitySplit(
				OpportunityId 	= oppMember.OpportunityId,
				SplitOwnerId 	= oppMember.UserId,
				SplitPercentage = 0
			));

		}

		// Insert results
		try {

			// Insert records.
			// Allow partial save. If splits already exist for users, it will fail. But that's ok
			// the others will create
			database.insert(oppSplitsToCreate, false);
		}

		catch (Exception ex) {

			// Fail silently. If splits fail to create, so be it.
			system.debug('### Error creating splits: ' + ex);
		}

	}

}