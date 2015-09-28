/*********************************************************************************
*@author         :TCS Developer    
*@date           :19/11/2014
*@description    : This is a test class for Trigger in HPC Framework.
*@Used for       : GM_HPCtrigger,GM_HPCTriggerHandler
*********************************************************************************/
@isTest
public class GM_HPCTriggerHandler_test{

    public static testMethod void TestHPCSendMailToPRs() {
        test.startTest();
        Account portalAccount = new Account(
            Name = 'TestAccount'
        );
        insert portalAccount ;
      
        
        Contact objContactPR = new Contact(
            FirstName = 'Test',
            Lastname = 'Amit',
            AccountId = portalAccount.Id,
            Email = 'test@test.com'
        );
        insert objContactPR; 
        
        Contact objContactTest = new Contact(
            FirstName = 'Test',
            Lastname = 'Amita',
            AccountId = portalAccount.Id,
            Email = 'test@test.com',
            Boolean_Duplicate__c = true
        );
        insert objContactTest; 
        
               test.StopTest();     
            Country__c objCon = new Country__c();
            objCon.Name = 'Hakunamatata';
            insert objCon; 
        
        List<Profile> objProfiles = [SELECT id FROM profile WHERE name in ('PR Admin', 'PR Read Write Edit') Limit 3]; 
            
            User objEsUser = new User(alias = 'u1', email='eS@testorg.com',
            emailencodingkey='UTF-8', lastname='TestingEs', languagelocalekey='es',
            localesidkey='en_US', profileid = objProfiles[0].Id, country = objCon.Id, CommunityNickname = 'u1', contactid = objContactPR.Id,
            timezonesidkey='America/Los_Angeles', username='eS@testorg.com');
            insert objEsUser;  
            
            User objRuUser = new User(alias = 'u2', email='rU@testorg.com',
            emailencodingkey='UTF-8', lastname='TestingRu', languagelocalekey='ru',
            localesidkey='en_US', profileid = objProfiles[1].Id, country = objCon.Id, CommunityNickname = 'u2', contactId = objContactTest.Id,
            timezonesidkey='America/Los_Angeles', username='rU@testorg.com');
            insert objRuUser; 

            objCon.FPM__c = objEsUser.Id;  
            objCon.Finance_Officer__c = objRuUser.Id; 
            objCon.HPM_Specialist__c = objEsUser.Id; 
            objCon.MEPH_Specialist__c = objRuUser.Id;
            objCon.PO_1__c = objEsUser.Id;
            objCon.PO_1__c = objRuUser.Id;
            objCon.PO_1__c = objEsUser.Id;
            update objCon;
            
            Grant__c objGrant = TestClassHelper.createGrant(portalAccount);
            objGrant.Grant_Status__c = 'Not yet submitted';
            insert objGrant;
        
            Implementation_Period__c objIP = TestClassHelper.createIP(objGrant,portalAccount);
    //      objIP.Status__c = 'Grant-Making';
            objIP.Status__c = 'Concept Note';
            objIP.CurrencyIsoCode='USD';
            objIP.Grant_Making_submission_date__c=Date.today().addYears(3);
            objIP.High_level_budget_GAC_1_EUR__c = 1000.00;
            objIP.High_level_budget_GAC_1_USD__c = 10002.99;
            objIP.High_level_budget_TRP_USD__c= 10003.77;
            objIP.High_level_budget_TRP_EUR__c= 10003.67;
            insert objIP;
            
             IP_Detail_Information__c IPD = new IP_Detail_Information__c();
        IPD.Implementation_Period__c = objIP.id;
        IPD.Total_Approved_Budget__c = 10000000;
        insert IPD;
            
            HPC_Framework__c hpcFW = new HPC_Framework__c();
            hpcFW.Grant_Implementation_Period__c = objIP.Id;
            hpcFW.HPC_Status__c = 'Not Yet Submitted by PR';
            hpcFW.Total_HPC_Amount_USD__c = 2000;
            
            insert hpcFW; 
            
            /*EmailTemplate objEmailTempPR = EmailTemplate();
            objEmailTemp.DeveloperName='Detailed_Budget_Request_input_from_PR';
            insert objEmailTempPR;
            
            EmailTemplate objEmailTempCT = EmailTemplate();
            objEmailTemp.DeveloperName='CT agrees with final budget';
            insert objEmailTempCT;
            */
            hpcFW.HPC_Status__c = Label.IP_Return_back_to_PR;    
            update hpcFW; 
            
            hpcFW.HPC_Status__c = Label.IP_Sub_to_GF;
            update hpcFW;
            system.assertEquals(hpcFW.HPC_Status__c,Label.IP_Sub_to_GF);
            /*Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId(objContactPR.Id);
            mail.setWhatId(ipDetail.Id);
            // assuming this Template ID exists in your org
            mail.setTemplateId('00X17000000QEIr'); 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });*/
    
    }
       public static testMethod void TestHPCSendMailToPRs2() {
        test.startTest();
        Account portalAccount = new Account(
            Name = 'TestAccount'
        );
        insert portalAccount ;
      
        
        Contact objContactPR = new Contact(
            FirstName = 'Test',
            Lastname = 'Amit',
            AccountId = portalAccount.Id,
            Email = 'test@test.com'
        );
        insert objContactPR; 
        
        Contact objContactTest = new Contact(
            FirstName = 'Test',
            Lastname = 'Amita',
            AccountId = portalAccount.Id,
            Email = 'test@test.com',
            Boolean_Duplicate__c = true
        );
        insert objContactTest; 
        
               test.StopTest();     
            Country__c objCon = new Country__c();
            objCon.Name = 'Hakunamatata';
            insert objCon; 
        
        List<Profile> objProfiles = [SELECT id FROM profile WHERE name in ('PR Admin', 'PR Read Write Edit') Limit 3]; 
            
            User objEsUser = new User(alias = 'u1', email='eS@testorg.com',
            emailencodingkey='UTF-8', lastname='TestingEs', languagelocalekey='es',
            localesidkey='en_US', profileid = objProfiles[0].Id, country = objCon.Id, CommunityNickname = 'u1', contactid = objContactPR.Id,
            timezonesidkey='America/Los_Angeles', username='eS@testorg.com');
            insert objEsUser;  
            
            User objRuUser = new User(alias = 'u2', email='rU@testorg.com',
            emailencodingkey='UTF-8', lastname='TestingRu', languagelocalekey='ru',
            localesidkey='en_US', profileid = objProfiles[1].Id, country = objCon.Id, CommunityNickname = 'u2', contactId = objContactTest.Id,
            timezonesidkey='America/Los_Angeles', username='rU@testorg.com');
            insert objRuUser; 

            objCon.FPM__c = objEsUser.Id;  
            objCon.Finance_Officer__c = objRuUser.Id; 
            objCon.HPM_Specialist__c = objEsUser.Id; 
            objCon.MEPH_Specialist__c = objRuUser.Id;
            objCon.PO_1__c = objEsUser.Id;
            objCon.PO_1__c = objRuUser.Id;
            objCon.PO_1__c = objEsUser.Id;
            update objCon;
            
            Grant__c objGrant = TestClassHelper.createGrant(portalAccount);
            objGrant.Grant_Status__c = 'Not yet submitted';
            insert objGrant;
        
            Implementation_Period__c objIP = TestClassHelper.createIP(objGrant,portalAccount);
    //      objIP.Status__c = 'Grant-Making';
            objIP.Status__c = 'Concept Note';
            objIP.CurrencyIsoCode='USD';
            objIP.Grant_Making_submission_date__c=Date.today().addYears(3);
            objIP.High_level_budget_GAC_1_EUR__c = 1000.00;
            objIP.High_level_budget_GAC_1_USD__c = 10002.99;
            objIP.High_level_budget_TRP_USD__c= 10003.77;
            objIP.High_level_budget_TRP_EUR__c= 10003.67;
            insert objIP;
            
             IP_Detail_Information__c IPD = new IP_Detail_Information__c();
        IPD.Implementation_Period__c = objIP.id;
        IPD.Total_Approved_Budget__c = 10000000;
        insert IPD;
            
            HPC_Framework__c hpcFW = new HPC_Framework__c();
            hpcFW.Grant_Implementation_Period__c = objIP.Id;
            hpcFW.HPC_Status__c = 'Not Yet Submitted by PR';
            hpcFW.Total_HPC_Amount_USD__c = 2000;
            
            insert hpcFW; 
            
            /*EmailTemplate objEmailTempPR = EmailTemplate();
            objEmailTemp.DeveloperName='Detailed_Budget_Request_input_from_PR';
            insert objEmailTempPR;
            
            EmailTemplate objEmailTempCT = EmailTemplate();
            objEmailTemp.DeveloperName='CT agrees with final budget';
            insert objEmailTempCT;
            */
            //hpcFW.HPC_Status__c = Label.IP_Return_back_to_PR;    
            //update hpcFW; 
            
            hpcFW.HPC_Status__c = Label.HPC_Accepted;
            update hpcFW;
            system.assertEquals(hpcFW.HPC_Status__c,Label.HPC_Accepted);
            /*Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId(objContactPR.Id);
            mail.setWhatId(ipDetail.Id);
            // assuming this Template ID exists in your org
            mail.setTemplateId('00X17000000QEIr'); 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });*/
    
    }
}