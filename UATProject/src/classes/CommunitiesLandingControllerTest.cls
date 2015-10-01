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
                                                      and to add assert concept 
*********************************************************************************/

@IsTest public with sharing class CommunitiesLandingControllerTest {
    //@IsTest(SeeAllData=true) public static void testCommunitiesLandingController() { //JK01 commented
    @IsTest(SeeAllData=false) public static void testCommunitiesLandingController() {  // JK01 Added
        // Instantiate a new controller with all parameters in the page
        CommunitiesLandingController controller = new CommunitiesLandingController();
        PageReference p1 = controller.forwardToStartPage(); // JK01
        //System.assertNotEquals(null,p1, 'p1 should not be null');   // Jk01
      }
}