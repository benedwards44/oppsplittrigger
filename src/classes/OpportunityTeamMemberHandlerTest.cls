/*
* Author:       Ben Edwards
* Date:         13/05/2015
* Description:  Test class for the OpportunityTeamMemberHandler
*/
@isTest
public with sharing class OpportunityTeamMemberHandlerTest {

	/*
	* Author:       Ben Edwards
	* Date:         13/05/2015
	* Description:  Test the create Opp Splits method in trigger
	*/
	static testMethod void testCreateOpportunitySplits() {

		// Create Opportunity
		Opportunity testOpp = new Opportunity();
		testOpp.Name 		= 'Test Opportunity';
		testOpp.StageName 	= 'Prospecting';
		testOpp.CloseDate 	= system.today().addDays(30);
		testOpp.Amount 		= 1000;
		insert testOpp;

		// Create Opp Team Member
		OpportunityTeamMember testOppMember = new OpportunityTeamMember();
		testOppMember.OpportunityId 		= testOpp.Id;
		testOppMember.UserId 				= UserInfo.getUserId();
		testOppMember.TeamMemberRole 		= 'Person';
		insert testOppMember;

		// Validate that Opp Split is created
		system.assert(
			[Select count() From OpportunitySplit] == 1,
			'There should be one OpportunitySplit record created'
		);

	}
	
}