@isTest
public class WorkPlanAnnualCalendarController_Test
{
    public static String profilename = 'Solution Manager';
    /*static testMethod void testingWorkPlanAnnualCalendarController ()
    {
        List<GroupMember> groupMemberList = new List<GroupMember>();
        groupMemberList = [SELECT GroupId FROM GroupMember WHERE UserOrGroupId=:UserInfo.getUserId()];
        
        Id groupId;      
        groupId = groupMemberList[0].GroupId;
                     
        //create Country record
        country__c countryRec = WorkPlanTestUtility.createCountry(groupId);
        insert countryRec;
        
        User newUser=WorkPlanTestUtility.singleUser(profilename);
        insert newUser;
    
        //create Account
        Account AccountRecord= WorkPlanTestUtility.createTestAccount();
        insert AccountRecord;
        
        //create Grant
        Grant__c grantRecord= WorkPlanTestUtility.createGrant(AccountRecord.Id);
        grantRecord.Country__c = countryRec.Id;
        insert grantRecord;
    
        //create Implementation Period
        Implementation_Period__c ImplementationPeriodRecord =  WorkPlanTestUtility.createIp(AccountRecord.Id,grantRecord.Id);
        ImplementationPeriodRecord.Name ='Testgrant';
        insert ImplementationPeriodRecord;
        
        Implementation_Period__c ImplementationPeriodRecord2 =  WorkPlanTestUtility.createIp(AccountRecord.Id,grantRecord.Id);
        ImplementationPeriodRecord2.Name = 'MyTestgrant';
        insert ImplementationPeriodRecord2;
        
        Implementation_Period__c ImplementationPeriodRecord3 =  WorkPlanTestUtility.createIp(AccountRecord.Id,grantRecord.Id);
        ImplementationPeriodRecord3.Name = 'WTestgrant';
        insert ImplementationPeriodRecord3;

        //create Task
        Task__c taskRecord=WorkPlanTestUtility.createTask(newUser.Id,ImplementationPeriodRecord.Id);
       // Task__c taskRecord=WorkPlanTestUtility.createTask3(newUser.Id,ImplementationPeriodRecord.Id);
        taskRecord.Responsible__c = 'Bhavya Mehta';
        taskRecord.Grant_Name__c = ImplementationPeriodRecord.Id;
        taskRecord.Name= 'ATestTask';
        insert taskRecord; 

        Task__c taskRecord1=WorkPlanTestUtility.createTask(newUser.Id,ImplementationPeriodRecord.Id);
       // Task__c taskRecord1=WorkPlanTestUtility.createTask3(newUser.Id,ImplementationPeriodRecord.Id);
        taskRecord1.Responsible__c = 'Rashmi';
        taskRecord1.Grant_Name__c = ImplementationPeriodRecord2.Id;
        taskRecord.Name= 'CTestTask';
        insert taskRecord1; 
        
        Task__c taskRecord2=WorkPlanTestUtility.createTask(newUser.Id,ImplementationPeriodRecord3.Id);
        //Task__c taskRecord2=WorkPlanTestUtility.createTask3(newUser.Id,ImplementationPeriodRecord3.Id);
        taskRecord2.Responsible__c = 'Rashmi';
        taskRecord2.Grant_Name__c = ImplementationPeriodRecord3.Id;
        taskRecord.Name= 'BTestTask';
        insert taskRecord2; 

        //create Step record
        Step__c stepRecord = WorkPlanTestUtility.createMileStoneWithoutParentMileStone(newUser.Id ,taskRecord.Id);
        stepRecord.Original_Due_Date__c = System.today()+5;
        stepRecord.Due_Date__c = System.today()+5;
        stepRecord.Country__c = countryRec.Id;
        stepRecord.Responsible__c = 'Bhavya Mehta';
        insert stepRecord;
        
        PageReference pg = Page.WorkPlanAnnualCalendar;
        Test.setCurrentPage(pg);
        ApexPages.currentPage().getParameters().put('selectedMilestone',stepRecord.Id);
        ApexPages.currentPage().getParameters().put('selectedMilestone1',stepRecord.Id);
        ApexPages.currentPage().getParameters().put('contextItem',stepRecord.Id);
        WorkPlanAnnualCalendarController calenderTest = new WorkPlanAnnualCalendarController();
                
        TEST.startTest();
        
        calenderTest.getshowsortedValues();
        calenderTest.refreshSelectedGrantList();
        calenderTest.grantListActive.add(new SelectOption(ImplementationPeriodRecord.Id,ImplementationPeriodRecord.Name));
        calenderTest.refreshTaskList();  
        calenderTest.refreshListonGrant();    
       
        calenderTest.selectedResponsible.add(new Selectoption(taskRecord.Responsible__c,taskRecord.Responsible__c)); 
        calenderTest.refreshListonResponsible();             
        calenderTest.grantListActive.clear();
        calenderTest.selectedResponsible.clear();
           
        calenderTest.refreshSelectedRespList();
        calenderTest.grouByVal='Task Name';
        calenderTest.refreshTaskList();
        
        calenderTest.grouByVal='Grant Name';
        System.assertEquals('Testgrant', ImplementationPeriodRecord.Name);
       
        calenderTest.refreshTaskList();
        
        calenderTest.grouByVal='Grant Name';
        System.assertEquals('MyTestgrant', ImplementationPeriodRecord2.Name);
       
        calenderTest.refreshTaskList();
        calenderTest.grouByVal='Grant Name';
        System.assertEquals('WTestgrant', ImplementationPeriodRecord3.Name);
       
        calenderTest.selectedGrantVals.add(ImplementationPeriodRecord.Id);
      
        calenderTest.refreshTaskList();
        
        calenderTest.selectedRespVals.add(taskRecord.Responsible__c);
        calenderTest.grouByVal='Task Name';
        calenderTest.refreshTaskList();
        calenderTest.refreshTaskListbyCountry_multi();
        
        calenderTest.grouByVal='Grant Name';
        calenderTest.refreshTaskList();
        calenderTest.refreshTaskListbyCountry_multi();       
       
        calenderTest.refreshListonResponsible();
        calenderTest.grantListActive.clear();
        calenderTest.selectedResponsible.clear();
       
        calenderTest.addTask();
        calenderTest.showTask();       
        calenderTest.cancelPopup();
        calenderTest.showPopup();
        calenderTest.refreshList();
        calenderTest.getCountries();
        calenderTest.downloadPDF();
        calenderTest.exportExcel();
     
     
        TEST.stopTest();
    }*/
}