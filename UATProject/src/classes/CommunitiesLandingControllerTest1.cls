/**
 * An apex page controller that takes the user to the right start page based on credentials or lack thereof
 */
/*********************************************************************************
* Test Class: {CommunitiesLandingControllerTest }
*  DateCreated : 
----------------------------------------------------------------------------------
* Purpose/Methods:
* - Used for cover all code of CommunitiesLandingController.
----------------------------------------------------------------------------------
* History:
* - VERSION  DEVELOPER NAME    DATE            DETAIL FEATURES
     1.0                           INITIAL DEVELOPMENT
     1.1     TCS(Jaideep Khare - JK01)  09/14/2015    To remove SeeAllData=true 
                                                      and to assert concept 
*********************************************************************************/
@IsTest public with sharing class CommunitiesLandingControllerTest1 {
    // @IsTest(SeeAllData=true) public static void testCommunitiesLandingController() { // JK01 Commented
    @IsTest(SeeAllData=false) public static void testCommunitiesLandingController() {    // JK01 Added
        // Instantiate a new controller with all parameters in the page
        CommunitiesLandingController controller = new CommunitiesLandingController();
        // 25-Jun-2013 Manu Erwin (Salesforce.com)  Fixing insufficient code coverage for default Communities Apex Tests
        PageReference pageRef = controller.forwardToStartPage();
        //System.assertNotEquals(null,pageRef, 'pageRef should not be null');   // Jk01
      }
}