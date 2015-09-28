/*********************************************************************************
@author       :TCS Developer   
*@date        : 12-09-2014
*@description : This test class is used for overrideindicatordetailext.
*@Used for    : overrideindicatordetailext.
**********************************************************************************/

@isTest
public class GM_overrideindicatordetailext_test {

   public static testMethod void Testoverrideindicatordetailext() {
        
           string recid = [select id from RecordType where SObjectType =: 'Account' and Name =: 'PR'].Id;
           Account objAccount = TestClassHelper.createAccount();
           objAccount.RecordTypeId = recid;
           insert objAccount;
           
           string recid1 = [select id from RecordType where SObjectType =: 'Contact' and Name =: 'PR'].Id;
           Contact objcnt = new Contact();
           objcnt.AccountId = objAccount.id;
           objcnt.Boolean_Duplicate__c = true;
           objcnt.LastName = 'portalTestUser';
           objcnt.External_User__c = true;
           objcnt.Email = 'test@asd.com';
           objcnt.FirstName = 'tsy';
           objcnt.RecordTypeId = recid1;
           insert objcnt;
           
           Country__c objCon = new Country__c();
           objCon.Name = 'Fiji';
           insert objCon;   
    
           List<Profile> objProfiles = [SELECT id FROM profile WHERE name =: 'System Administrator' Limit 1]; 
                
            User objEsUser = new User(alias = 'u1', email='eS@testorg.com',
            emailencodingkey='UTF-8', lastname='TestingEs', languagelocalekey='es',
            localesidkey='en_US', profileid = objProfiles[0].Id, country = objCon.Id, CommunityNickname = 'u1',
            timezonesidkey='America/Los_Angeles', username='eS@testorg.com');
            insert objEsUser;        
            
            User objRuUser = new User(alias = 'u2', email='rU@testorg.com',
            emailencodingkey='UTF-8', lastname='TestingRu', languagelocalekey='ru',
            localesidkey='en_US', profileid = objProfiles[0].Id, country = objCon.Id, CommunityNickname = 'u2',
            timezonesidkey='America/Los_Angeles', username='rU@testorg.com');
            insert objRuUser; 
            
            User objFrUser = new User(alias = 'u3', email='fR@testorg.com',
            emailencodingkey='UTF-8', lastname='TestingFr', languagelocalekey='fr',
            localesidkey='en_US', profileid = objProfiles[0].Id, country = objCon.Id, CommunityNickname = 'u3',
            timezonesidkey='America/Los_Angeles', username='fR@testorg.com');
            insert objFrUser;
            
           Grant__c objGrant = TestClassHelper.insertGrant(objAccount);
           
           Implementation_Period__c objIP = TestClassHelper.createIPWithConceptNote(objGrant, objAccount);
           objIP.Principal_Recipient__c = objAccount.Id;
           insert objIP;
           
           Performance_Framework__c objPF = TestClassHelper.createPF(objIP);
           objPF.PF_status__c = Label.IP_Return_back_to_PR;
           insert objPF;
           
           Catalog_Module__c objCatMod = TestClassHelper.createCatalogModule(); 
           insert objCatMod;
           
           Module__c objModule =  TestClassHelper.createModule();
           objModule.Catalog_Module__c = objCatMod.Id;
           objModule.Implementation_Period__c = objIP.Id;
           objModule.Performance_Framework__c = objPF.Id;
           insert objModule;
           
           Grant_Indicator__c objGIImp = TestClassHelper.createGrantIndicator();
           objGIImp.Performance_Framework__c = objPF.Id; 
           objGIImp.Indicator_Type__c = 'Impact';
           objGIImp.Grant_Implementation_Period__c = objIP.id; 
           insert objGIImp;   
           
           Grant_Indicator__c objGIOut = TestClassHelper.createGrantIndicator();
           objGIOut.Performance_Framework__c = objPF.Id; 
           objGIOut.Indicator_Type__c = 'Outcome'; 
           objGIImp.Grant_Implementation_Period__c = objIP.id; 
           insert objGIOut;
           
           Grant_Indicator__c objGICO = TestClassHelper.createGrantIndicator();
           objGICO.Performance_Framework__c = objPF.Id; 
           objGICO.Indicator_Type__c = 'Coverage/Output'; 
           objGIImp.Grant_Implementation_Period__c = objIP.id;
           objGIImp.Data_Type__c = 'Ratio';
           insert objGICO;
           
           Period__c objPeriod = TestClassHelper.createPeriod();
           objPeriod.Implementation_Period__c = objIP.Id;
           objPeriod.Performance_Framework__c = objPF.Id; 
           objGIImp.Grant_Implementation_Period__c = objIP.id;
           insert objPeriod;
           
           /*Result__c objResult = new Result__c();
           objResult.Indicator__c = objGI.Id;
           objResult.Period__c = objPeriod.Id;
           insert objResult;*/  
           
           Guidance__c gui_impact = TestClassHelper.createGuidance();
           gui_impact.Name = 'GM Goals & Impact Indicators';
           insert gui_impact; 
           
           Guidance__c gui_outcome = TestClassHelper.createGuidance();
           gui_outcome.Name = 'GM Objectives & Outcome Indicators';
           insert gui_outcome; 
           
           Guidance__c gui_coverage = TestClassHelper.createGuidance();
           gui_coverage.Name = 'GM Coverage & Output Indicators';
           insert gui_coverage; 
           
           Profile_Access_Setting__c objpr = new Profile_Access_Setting__c();
           objpr.Page_Name__c = 'overrideindicatordetail';
           objpr.Profile_Name__c = 'System Administrator';
           objpr.Name = 'test';
           objpr.Salesforce_Item__c = 'display Edit_Delete button';
           objpr.Status__c = Null;
           insert objpr;
           
           Profile_Access_Setting__c objpr1 = new Profile_Access_Setting__c();
           objpr1.Page_Name__c = 'overrideindicatordetail';
           objpr1.Profile_Name__c = 'System Administrator';
           objpr1.Name = 'test1';
           objpr1.Salesforce_Item__c = 'Read_Global fund comment to PR';
           objpr1.Status__c = Null;
           insert objpr1;
           
           Profile_Access_Setting__c objpr2 = new Profile_Access_Setting__c();
           objpr2.Page_Name__c = 'overrideindicatordetail';
           objpr2.Profile_Name__c = 'System Administrator';
           objpr2.Name = 'test2';
           objpr2.Salesforce_Item__c = 'View LFA Comments';
           objpr2.Status__c = Null;
           insert objpr2;
           
           Profile_Access_Setting__c objpr3 = new Profile_Access_Setting__c();
           objpr3.Page_Name__c = 'overrideindicatordetail';
           objpr3.Profile_Name__c = 'System Administrator';
           objpr3.Name = 'test3';
           objpr3.Salesforce_Item__c = 'View_Global Fund Comments to LFA';
           objpr3.Status__c = Null;
           insert objpr3;
           
           String pid = [select id from Profile where Name =: 'PR Admin'].Id;
          
           user extuser = new user();
           extuser.ContactId = objcnt.Id;
           extuser.ProfileId = pid;
           extuser.FirstName = 'test';
           extuser.Email = 'test@sales.com';
           extuser.emailencodingkey = 'UTF-8';
           extuser.Username = 'testPrread@gas.com';
           extuser.LastName = 'read';
           extuser.Alias = 'testrea';
           extuser.timezonesidkey = 'America/Los_Angeles';
           extuser.localesidkey = 'en_US';
           extuser.languagelocalekey = 'en_US';
           extuser.timezonesidkey = 'America/Los_Angeles';
           extuser.CommunityNickname = 'PR';
           insert extuser;
           
           /*npe5__Affiliation__c objaff = new npe5__Affiliation__c();
           objaff.Access_Level__c = 'Read';
           objaff.npe5__Contact__c = extuser.ContactId;
           objaff.npe5__Organization__c = objIP.Principal_Recipient__c;
           objaff.npe5__Status__c='Current';
           insert objaff;*/
           
           npe5__Affiliation__c objaff = [Select Access_Level__c, id,npe5__Contact__c,npe5__Organization__c FROM npe5__Affiliation__c where npe5__Contact__c=: objcnt.Id and npe5__Organization__c=:objIP.Principal_Recipient__c and npe5__Status__c='Current' limit 1]; 
         
           //npe5__Affiliation__c objaff = [select Access_Level__c from npe5__Affiliation__c where npe5__Contact__c=:objcnt.Id and npe5__Organization__c=: objAccount.Id and npe5__Status__c='Current' limit 1];
           system.debug('@@'+objaff);
           objaff.npe5__Status__c='Current';
           objaff.Access_Level__c = 'Admin';
           update objaff;
           
           system.debug('@@'+objaff);
           
           System.RunAs(extuser){
            system.debug('extuser'+extuser.ContactId);
            system.debug('objaff'+objaff.npe5__Contact__c);
            system.debug('objip'+objIP.Principal_Recipient__c);
            system.debug('objaff'+objaff.npe5__Organization__c);
              Apexpages.currentpage().getparameters().put('id',objGIImp.Id);       
              ApexPages.StandardController scext = new ApexPages.StandardController(objGIImp);
              overrideindicatordetailext objIndDetailext = new overrideindicatordetailext(scext); 
              objIndDetailext.reDirect();
              //objIndDetailext.edit();
           }
           test.starttest();
           //To Test with Users of three different languages and three different Type of Grant Indicator  
      System.RunAs(objEsUser){
           Apexpages.currentpage().getparameters().put('id',objGIImp.Id);       
           ApexPages.StandardController sc = new ApexPages.StandardController(objGIImp);
           overrideindicatordetailext objIndDetail = new overrideindicatordetailext(sc); 
           objIndDetail.edit();
           objIndDetail.deleteind();
           objIndDetail.addgoals();
           objIndDetail.ShowHistoryPopup();
           objIndDetail.HidePopupHistory();
           objIndDetail.openGuidance();
           objIndDetail.reDirect();
      } 
      
      System.RunAs(objRuUser){
          Apexpages.currentpage().getparameters().put('id',objGIOut.Id);       
          ApexPages.StandardController scOut = new ApexPages.StandardController(objGIOut);
          overrideindicatordetailext objIndDetOut = new overrideindicatordetailext(scOut); 
          objIndDetOut.edit();
          objIndDetOut.deleteind();
          objIndDetOut.addgoals();
          objIndDetOut.ShowHistoryPopup();
          objIndDetOut.HidePopupHistory();
          objIndDetOut.openGuidance();
          objIndDetOut.reDirect();
          objIndDetOut.openPF();
      } 
      
      system.debug('@@'+objFrUser.ProfileId);
      System.RunAs(objFrUser ){
          Apexpages.currentpage().getparameters().put('id',objGICO.Id);       
          ApexPages.StandardController scCO = new ApexPages.StandardController(objGICO);
          overrideindicatordetailext objIndDetCO = new overrideindicatordetailext(scCO); 
         
          objIndDetCO.reDirect();
          objIndDetCO.edit();
          objIndDetCO.deleteind();
          objIndDetCO.addgoals();
          objIndDetCO.ShowHistoryPopup();
          objIndDetCO.HidePopupHistory();
          objIndDetCO.openGuidance();
      } 
       
      Implementation_Period__c objIP1 = TestClassHelper.createIPWithConceptNote(objGrant, objAccount);
      objIP1.Start_Date__c = NUll;
      insert objIP1;
      System.assertEquals(objIP1.Start_Date__c,Null);
      
      Grant_Indicator__c objGIImp1 = TestClassHelper.createGrantIndicator();
      objGIImp1.Performance_Framework__c = objPF.Id; 
      objGIImp1.Indicator_Type__c = 'Impact';
      objGIImp1.Grant_Implementation_Period__c = objIP1.id; 
      insert objGIImp1;
      
      Apexpages.currentpage().getparameters().put('id',objGIImp1.Id);       
      ApexPages.StandardController sc = new ApexPages.StandardController(objGIImp1);
      overrideindicatordetailext objInd = new overrideindicatordetailext(sc);
      
      Grant_Indicator__c objCNImp = TestClassHelper.createGrantIndicator();
      objCNImp.Indicator_Type__c = 'Impact';
      insert objCNImp;
      
      Apexpages.currentpage().getparameters().put('id',objCNImp.Id);       
      ApexPages.StandardController scCN = new ApexPages.StandardController(objCNImp);
      overrideindicatordetailext objIndCN = new overrideindicatordetailext(scCN); 
      
      objIndCN.reDirect();
      
      test.stoptest(); 
      
           
    }
    
     
}