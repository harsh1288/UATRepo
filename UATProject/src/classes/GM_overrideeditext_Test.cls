/*********************************************************************************
@author       :TCS Developer   
*@date        : 27-04-2015
*@description : This test class is used for overrideeditext.
*@Used for    : overrideeditext.
**********************************************************************************/
@isTest(seealldata=false)
public class GM_overrideeditext_Test{       
public static testMethod void overrideeditextTest(){
    
    List<Profile_Access_Setting__c> customSettingRecList = new List<Profile_Access_Setting__c>();
    
    Profile_Access_Setting__c customSettingRec = new Profile_Access_Setting__c();
    customSettingRec.Name = 'overrideeditext01';
    customSettingRec.Profile_Name__c = 'System Administrator';
    customSettingRec.Salesforce_Item__c = 'Edit_Global fund comment to PR';
    customSettingRec.Page_Name__c = 'overrideeditext';
    customSettingRecList.add(customSettingRec);
    
    Profile_Access_Setting__c customSettingRec1 = new Profile_Access_Setting__c();
    customSettingRec1.Name = 'overrideeditext02';
    customSettingRec1.Profile_Name__c = 'System Administrator';
    customSettingRec1.Salesforce_Item__c = 'Edit record based on status';
    customSettingRec1.Page_Name__c = 'overrideeditext';
    customSettingRecList.add(customSettingRec1);
    //insert customSettingRecList this a comment;
        
    Profile_Access_Setting__c customSettingRec2 = new Profile_Access_Setting__c();
    customSettingRec2.Name = 'overrideeditext00';
    customSettingRec2.Profile_Name__c = 'System Administrator';
    customSettingRec2.Salesforce_Item__c = 'Read_Global fund comment to PR';
    customSettingRec2.Page_Name__c = 'overrideeditext';
    customSettingRecList.add(customSettingRec2);
    
    Profile_Access_Setting__c customSettingRec3 = new Profile_Access_Setting__c();
    customSettingRec3.Name = 'overrideeditext03';
    customSettingRec3.Profile_Name__c = 'System Administrator';
    customSettingRec3.Salesforce_Item__c = 'Edit_Global fund comment to LFA';
    customSettingRec3.Page_Name__c = 'overrideeditext';
    customSettingRecList.add(customSettingRec3);
    
    Profile_Access_Setting__c customSettingRec4 = new Profile_Access_Setting__c();
    customSettingRec4.Name = 'overrideeditext04';
    customSettingRec4.Profile_Name__c = 'System Administrator';
    customSettingRec4.Salesforce_Item__c = 'Edit LFA Comments';
    customSettingRec4.Page_Name__c = 'overrideeditext';
    customSettingRecList.add(customSettingRec4);
    
    insert customSettingRecList;
    
    Map<String, RecordType> mapRecordType = new Map<String, RecordType>();
    List<RecordType> objRecordTypeList = [SELECT id, Name 
                                          FROM RecordType 
                                          WHERE SobjectType='Grant_Indicator__c'];
    for(RecordType objRt : objRecordTypeList) {
        mapRecordType.put(objRt.name, objRt);
    }                                   
    Account objAcnt = TestClassHelper.createAccount();
    insert objAcnt;
    
    Grant__c objGrant = TestClassHelper.createGrant(objAcnt);
    insert objGrant;
    
    Implementation_Period__c objIp = TestClassHelper.createIP(objGrant, objAcnt);
    insert objIp;
    objIP.Reporting_Frequency__c = 'Half-yearly';
    update objIp;
    
     Performance_Framework__c objPf = TestClassHelper.createPF(objIp);
    insert objPf;
    
    Period__c objPeriod = TestClassHelper.createPeriod();
    objPeriod.Implementation_Period__c = objIP.Id;
    objPeriod.Start_Date__c = Date.today();
    objPeriod.EFR__c = true;
    objPeriod.EFR_Due_Date__c = system.today();
    objPeriod.PU__c=true;
    objPeriod.PU_Due_Date__c = system.today();
    objPeriod.Audit_Report__c = true;
    objPeriod.AR_Due_Date__c=system.today();
    objPeriod.DR__c=true;
    objPeriod.Type__c = 'Reporting';
    objPeriod.Due_Date__c =system.today();
    objPeriod.Flow_to_GrantIndicator__c = False;
    objPeriod.Performance_Framework__c = objPf.Id;
    insert objPeriod;
        
    
    Indicator__c objCatalogIndi = TestClassHelper.createCatalogIndicator();
    objCatalogIndi.Indicator_Type__c = 'Coverage/Output';
    objCatalogIndi.Reporting_Frequency__c = 'Based on Reporting Frequency';
    insert objCatalogIndi;   
     
    MultipleDataType__c objMultipleDt = TestClassHelper.createMultipleDataType(objCatalogIndi.id);
    insert objMultipleDt;
    
    Module__c objModule = TestClassHelper.createModule();
    objModule.Implementation_Period__c = objIp.id;
    objModule.Performance_Framework__c = objPf.id;
    insert objModule;
    
    Grant_Indicator__c objGrantIndi = new Grant_Indicator__c();
    objGrantIndi = TestClassHelper.createGrantIndicator();
    objGrantIndi.RecordTypeId = mapRecordType.get('Coverage/Output_IP').id;
    objGrantIndi.Performance_Framework__c = objPf.id;
    objGrantIndi.Grant_Implementation_Period__c = objIp.id;
    objGrantIndi.Indicator_Type__c = 'Coverage/Output';
    objGrantIndi.Reporting_Frequency__c = 'Based on Reporting Frequency';
    objGrantIndi.Standard_or_Custom__c = 'Standard';
    objGrantIndi.Target_Accumulation__c = 'Non cumulated';
    objGrantIndi.Indicator__c = objCatalogIndi.id;
    objGrantIndi.Parent_Module__c = objModule.Id;
    insert objGrantIndi;
    
    System.assertEquals(objGrantIndi.Reporting_Frequency__c,'Based on Reporting Frequency');
    
    
    PageReference pgRef = Page.overideedit;
    Test.setCurrentPage(pgRef);
    ApexPages.Standardcontroller controller = new ApexPages.Standardcontroller(objGrantIndi);
    ApexPages.currentPage().getParameters().put('Id',objGrantIndi.id);
    overrideeditext overrideEditRef = new overrideeditext(controller);
    overrideEditRef.save();
    overrideEditRef.cancel();
    overrideEditRef.showsign();
    overrideEditRef.ChangeFreq();
    overrideEditRef.changeCumilation();
    overrideEditRef.changeCumilationText();
    
    objCatalogIndi.Reporting_Frequency__c = '12 months;Based on Reporting Frequency';
    update objCatalogIndi; 
    
    MultipleDataType__c objMultipleDt1 = TestClassHelper.createMultipleDataType(objCatalogIndi.id);
    insert objMultipleDt1;
    
    objPeriod.Flow_to_GrantIndicator__c = true;
    update objPeriod;
    
    objGrantIndi.Subset_Of__c = objGrantIndi.id;
    objGrantIndi.Reporting_Frequency__c = '12 Months';    
    update objGrantIndi;
        
    PageReference pgRef1 = Page.overideedit;
    Test.setCurrentPage(pgRef1);
    ApexPages.Standardcontroller controller1 = new ApexPages.Standardcontroller(objGrantIndi);
    ApexPages.currentPage().getParameters().put('Id',objGrantIndi.id);
    overrideeditext overrideEditRef1 = new overrideeditext(controller1);
    overrideEditRef1.showsign();
    
    objGrantIndi.Reporting_Frequency__c = '';
    update objGrantIndi;
    
    overrideEditRef1.save();
    
    objGrantIndi.Data_Type__c = ''; 
    objGrantIndi.Reporting_Frequency__c = '12 Months';
    update objGrantIndi;
    
    overrideEditRef1.save();
    
        
    
}

public static testMethod void overrideeditextTest1(){
    
    Map<String, RecordType> mapRecordType = new Map<String, RecordType>();
    List<RecordType> objRecordTypeList = [SELECT id, Name 
                                          FROM RecordType 
                                          WHERE SobjectType='Grant_Indicator__c'];
    for(RecordType objRt : objRecordTypeList) {
        mapRecordType.put(objRt.name, objRt);
    }                                   
    Account objAcnt = TestClassHelper.createAccount();
    insert objAcnt;
    
    Grant__c objGrant = TestClassHelper.createGrant(objAcnt);
    insert objGrant;
    
    Implementation_Period__c objIp = TestClassHelper.createIP(objGrant, objAcnt);
    insert objIp;
    objIP.Reporting_Frequency__c = 'Half-yearly';
    update objIp;
    
     Performance_Framework__c objPf = TestClassHelper.createPF(objIp);
    insert objPf;
    
    Period__c objPeriod = TestClassHelper.createPeriod();
    objPeriod.Implementation_Period__c = objIP.Id;
    objPeriod.Start_Date__c = Date.today();
    objPeriod.EFR__c = true;
    objPeriod.EFR_Due_Date__c = system.today();
    objPeriod.PU__c=true;
    objPeriod.PU_Due_Date__c = system.today();
    objPeriod.Audit_Report__c = true;
    objPeriod.AR_Due_Date__c=system.today();
    objPeriod.DR__c=true;
    objPeriod.Type__c = 'Reporting';
    objPeriod.Due_Date__c =system.today();
    objPeriod.Flow_to_GrantIndicator__c = False;
    objPeriod.Base_Frequency__c = 'Yearly';
    objPeriod.is_Active__c = true;
    objPeriod.Performance_Framework__c = objPf.Id;
    insert objPeriod;
        
   
    Indicator__c objCatalogIndi = TestClassHelper.createCatalogIndicator();
    objCatalogIndi.Indicator_Type__c = 'Coverage/Output';
    objCatalogIndi.Reporting_Frequency__c = 'Based on Reporting Frequency';
    insert objCatalogIndi;   
     
    MultipleDataType__c objMultipleDt = TestClassHelper.createMultipleDataType(objCatalogIndi.id);
    insert objMultipleDt;
    
    Module__c objModule = TestClassHelper.createModule();
    objModule.Implementation_Period__c = objIp.id;
    objModule.Performance_Framework__c = objPf.id;
    insert objModule;
    
    Grant_Indicator__c objGrantIndi = new Grant_Indicator__c();
    objGrantIndi = TestClassHelper.createGrantIndicator();
    objGrantIndi.RecordTypeId = mapRecordType.get('Coverage/Output_IP').id;
    objGrantIndi.Performance_Framework__c = objPf.id;
    objGrantIndi.Grant_Implementation_Period__c = objIp.id;
    objGrantIndi.Indicator_Type__c = 'Coverage/Output';
    objGrantIndi.Reporting_Frequency__c = 'Based on Reporting Frequency';
    objGrantIndi.Standard_or_Custom__c = 'Custom';
    objGrantIndi.Target_Accumulation__c = 'Non cumulated';
    objGrantIndi.Indicator__c = objCatalogIndi.id;
    objGrantIndi.Parent_Module__c = objModule.Id;
    insert objGrantIndi;
    
    System.assertEquals(objGrantIndi.Indicator_Type__c ,'Coverage/Output');
    
    Result__c objResult = new Result__c();
    objResult.Target__c = 67;
    objResult.Target_Numerator__c = 98;
    objResult.Target_Denominator__c = 100;
    objResult.Indicator__c = objGrantIndi.id;
    objResult.Period__c = objPeriod.Id;
    insert objResult;
    
    PageReference pgRef2 = Page.overideedit;
    Test.setCurrentPage(pgRef2);
    ApexPages.Standardcontroller controller2 = new ApexPages.Standardcontroller(objGrantIndi);
    ApexPages.currentPage().getParameters().put('Id',objGrantIndi.id);
    overrideeditext overrideEditRef2 = new overrideeditext(controller2);
    
}

public static testMethod void overrideeditextTest2(){
    
    Country__c objCon = TestClassHelper.insertCountry();
                                 
    Account objAcnt = TestClassHelper.createAccount();
    insert objAcnt;
    
    Grant__c objGrant = TestClassHelper.createGrant(objAcnt);
    insert objGrant;
    
    Implementation_Period__c objIp = TestClassHelper.createIP(objGrant, objAcnt);
    insert objIp;
    objIP.Reporting_Frequency__c = 'Half-yearly';
    update objIp;
    
    Performance_Framework__c objPf = TestClassHelper.createPF(objIp);
    insert objPf;

    Indicator__c objCatalogIndi = TestClassHelper.createCatalogIndicator();
    objCatalogIndi.Indicator_Type__c = 'Impact';
    objCatalogIndi.Reporting_Frequency__c = 'Based on Reporting Frequency';
    insert objCatalogIndi;
    
    Grant_Indicator__c objGrantIndi = new Grant_Indicator__c();
    objGrantIndi = TestClassHelper.createGrantIndicator();
    objGrantIndi.Performance_Framework__c = objPf.id;
    objGrantIndi.Grant_Implementation_Period__c = objIp.id;
    objGrantIndi.Indicator_Type__c = 'Impact';
    objGrantIndi.Reporting_Frequency__c = 'Based on Reporting Frequency';
    objGrantIndi.Standard_or_Custom__c = 'Standard';
    objGrantIndi.Target_Accumulation__c = 'Non cumulated';
    objGrantIndi.Indicator__c = objCatalogIndi.id;
    
    insert objGrantIndi;
    System.assertEquals(objGrantIndi.Indicator_Type__c ,'Impact');
    objGrantIndi.Data_Type__c = 'Ratio';
    objGrantIndi.Baseline_Value1__c = '100 Per 100 K';
    objGrantIndi.Target_Value_Y12__c = '10 Per 100 K';
    objGrantIndi.Target_Value_Y22__c = '20 Per 100 K';
    objGrantIndi.Target_Value_Y32__c = '30 Per 100 K';
    objGrantIndi.Target_Value_Y42__c = '40 Per 100 K';
    
    update objGrantIndi;
    
    Goals_Objectives__c objGoalAndObj = TestClassHelper.createGoalsAndObjective('Goal', objIp.Id);
    insert objGoalAndObj;

    Ind_Goal_Jxn__c objGoalJunction = TestClassHelper.createGoalsJunction(objGrantIndi.id, objGoalAndObj.id);
    insert objGoalJunction;
    
    
    Reporting_Period_Detail__c objRepPeriod = new Reporting_Period_Detail__c();
    objRepPeriod.reporting_frequency__c = 'Half-Yearly';
    objRepPeriod.Grant_Implementation_Period__c = objIp.Id;
    objRepPeriod.Is_Active__c = false;
    objRepPeriod.Implementation_Period_Start_Date__c = Date.today();
    objRepPeriod.Implementation_Period_End_Date__c = Date.today();
    objRepPeriod.PR_Reporting_Cycle__c = 'January-December';
    insert objRepPeriod;
    
    Period__c objPeriod = TestClassHelper.createPeriod();
    objPeriod.Implementation_Period__c = objIP.Id;
    objPeriod.Start_Date__c = Date.today();
    objPeriod.EFR__c = true;
    objPeriod.EFR_Due_Date__c = system.today();
    objPeriod.PU__c=true;
    objPeriod.PU_Due_Date__c = system.today();
    objPeriod.Audit_Report__c = true;
    objPeriod.AR_Due_Date__c=system.today();
    objPeriod.DR__c=true;
    objPeriod.Type__c = 'Reporting';
    objPeriod.Due_Date__c =system.today();
    objPeriod.Flow_to_GrantIndicator__c = False;
    objPeriod.Reporting_Period_Detail__c = objRepPeriod.Id;
    objPeriod.Base_Frequency__c = 'Yearly';
    objPeriod.Performance_Framework__c = objPf.Id;
    insert objPeriod;
        
        
    Result__c objResult = new Result__c();
    objResult.Target__c = 67;
    objResult.Target_Numerator__c = 98;
    objResult.Target_Denominator__c = 100;
    objResult.Indicator__c = objGrantIndi.id;
    objResult.Period__c = objPeriod.Id;
    insert objResult;
    
    
    PageReference pgRef3 = Page.overideedit;
    Test.setCurrentPage(pgRef3);
    ApexPages.Standardcontroller controller3 = new ApexPages.Standardcontroller(objGrantIndi);
    ApexPages.currentPage().getParameters().put('Id',objGrantIndi.id);
    overrideeditext overrideEditRef3 = new overrideeditext(controller3); 
    overrideEditRef3.save();
    
    objCatalogIndi.Indicator_Type__c = 'Outcome';
    update objCatalogIndi;
    
    objGrantIndi.Baseline_Value1__c = '100 %';
    objGrantIndi.Target_Value_Y12__c = '10 %';
    objGrantIndi.Target_Value_Y22__c = '20 %';
    objGrantIndi.Target_Value_Y32__c = '30 %';
    objGrantIndi.Target_Value_Y42__c = '40 %';
    objGrantIndi.Reporting_Frequency__c = '';
    objGrantIndi.Data_Type__c = 'Percent';
    objGrantIndi.Indicator_Type__c = 'Outcome';
    update objGrantIndi;
    
    Goals_Objectives__c objObjective = TestClassHelper.createGoalsObjectives();
    objObjective.Implementation_Period__c = objIp.id;
    objObjective.Type__c  = 'Objective';
    objObjective.Performance_Framework__c = objPf.Id;
    insert objObjective;
    
    Goals_Objectives__c objObjective1 = TestClassHelper.createGoalsObjectives();
    objObjective1.Implementation_Period__c = objIp.id;
    objObjective1.Type__c  = 'Objective';
    objObjective1.Performance_Framework__c = objPf.Id;
    insert objObjective1;
    
    Ind_Goal_Jxn__c objObjectiveJN = TestClassHelper.createGoalsJunction(objGrantIndi.id, objGoalAndObj.id);
    insert objObjectiveJN;
    
    Grant_Multi_Country__c objGrntMultiCon = TestClassHelper.createGrntMultiCountry(objCon.Id,objIp.Id);
    insert objGrntMultiCon;
    
    PageReference pgRef4 = Page.overideedit;
    Test.setCurrentPage(pgRef4);
    ApexPages.Standardcontroller controller4 = new ApexPages.Standardcontroller(objGrantIndi);
    ApexPages.currentPage().getParameters().put('Id',objGrantIndi.id);
    overrideeditext overrideEditRef4 = new overrideeditext(controller4); 
    overrideEditRef4.save();
    overrideEditRef4.detailObjId = objRepPeriod.Id;
    overrideEditRef4.displayReadOnlyTargets();
    overrideEditRef4.reDirect();
}
public static testMethod void overrideeditextTest3(){
    
    Country__c objCon = TestClassHelper.insertCountry();
                                 
    Account objAcnt = TestClassHelper.createAccount();
    insert objAcnt;
    
    Grant__c objGrant = TestClassHelper.createGrant(objAcnt);
    insert objGrant;
    
    Implementation_Period__c objIp = TestClassHelper.createIP(objGrant, objAcnt);
    insert objIp;
    objIP.Reporting_Frequency__c = 'Half-yearly';
    update objIp;
    
    Performance_Framework__c objPf = TestClassHelper.createPF(objIp);
    insert objPf;

    Indicator__c objCatalogIndi = TestClassHelper.createCatalogIndicator();
    objCatalogIndi.Indicator_Type__c = 'Impact';
    objCatalogIndi.Reporting_Frequency__c = '12 Months';
    insert objCatalogIndi;
    
    Grant_Indicator__c objGrantIndi = new Grant_Indicator__c();
    objGrantIndi = TestClassHelper.createGrantIndicator();
    objGrantIndi.Performance_Framework__c = objPf.id;
    objGrantIndi.Grant_Implementation_Period__c = objIp.id;
    objGrantIndi.Indicator_Type__c = 'Impact';
    objGrantIndi.Reporting_Frequency__c = '12 Months';
    objGrantIndi.Standard_or_Custom__c = 'Standard';
    objGrantIndi.Target_Accumulation__c = 'Non cumulated';
    objGrantIndi.Indicator__c = objCatalogIndi.id;
    
    insert objGrantIndi;
    System.assertEquals(objGrantIndi.Reporting_Frequency__c,'12 Months');
    objGrantIndi.Data_Type__c = 'Ratio';
    objGrantIndi.Baseline_Value1__c = '100 Per 100 K';
    objGrantIndi.Target_Value_Y12__c = '10 Per 100 K';
    objGrantIndi.Target_Value_Y22__c = '20 Per 100 K';
    objGrantIndi.Target_Value_Y32__c = '30 Per 100 K';
    objGrantIndi.Target_Value_Y42__c = '40 Per 100 K';
    
    update objGrantIndi;
    
    Goals_Objectives__c objGoalAndObj = TestClassHelper.createGoalsAndObjective('Goal', objIp.Id);
    insert objGoalAndObj;

    Ind_Goal_Jxn__c objGoalJunction = TestClassHelper.createGoalsJunction(objGrantIndi.id, objGoalAndObj.id);
    insert objGoalJunction;
    
    
    Reporting_Period_Detail__c objRepPeriod = new Reporting_Period_Detail__c();
    objRepPeriod.reporting_frequency__c = 'Half-Yearly';
    objRepPeriod.Grant_Implementation_Period__c = objIp.Id;
    objRepPeriod.Is_Active__c = false;
    objRepPeriod.Implementation_Period_Start_Date__c = Date.today();
    objRepPeriod.Implementation_Period_End_Date__c = Date.today();
    objRepPeriod.PR_Reporting_Cycle__c = 'January-December';
    insert objRepPeriod;
    
    Period__c objPeriod = TestClassHelper.createPeriod();
    objPeriod.Implementation_Period__c = objIP.Id;
    objPeriod.Start_Date__c = Date.today();
    objPeriod.EFR__c = true;
    objPeriod.EFR_Due_Date__c = system.today();
    objPeriod.PU__c=true;
    objPeriod.PU_Due_Date__c = system.today();
    objPeriod.Audit_Report__c = true;
    objPeriod.AR_Due_Date__c=system.today();
    objPeriod.DR__c=true;
    objPeriod.Type__c = 'Reporting';
    objPeriod.Due_Date__c =system.today();
    objPeriod.Flow_to_GrantIndicator__c = False;
    objPeriod.Reporting_Period_Detail__c = objRepPeriod.Id;
    objPeriod.Base_Frequency__c = 'Yearly';
    objPeriod.Performance_Framework__c = objPf.Id;
    insert objPeriod;
        
        
    Result__c objResult = new Result__c();
    objResult.Target__c = 67;
    objResult.Target_Numerator__c = 98;
    objResult.Target_Denominator__c = 100;
    objResult.Indicator__c = objGrantIndi.id;
    objResult.Period__c = objPeriod.Id;
    insert objResult;
    
     List<Profile_Access_Setting__c> customSettingRecList = new List<Profile_Access_Setting__c>();
    
    Profile_Access_Setting__c customSettingRec = new Profile_Access_Setting__c();
    customSettingRec.Name = 'overrideeditext01';
    customSettingRec.Profile_Name__c = 'System Administrator';
    customSettingRec.Salesforce_Item__c = 'View_Global Fund Comments to LFA';
    customSettingRec.Page_Name__c = 'overrideeditext';
    customSettingRecList.add(customSettingRec);
    
    Profile_Access_Setting__c customSettingRec1 = new Profile_Access_Setting__c();
    customSettingRec1.Name = 'overrideeditext02';
    customSettingRec1.Profile_Name__c = 'System Administrator';
    customSettingRec1.Salesforce_Item__c = 'View LFA Comments';
    customSettingRec1.Page_Name__c = 'overrideeditext';
    customSettingRecList.add(customSettingRec1);
    //insert customSettingRecList;
        
    Profile_Access_Setting__c customSettingRec2 = new Profile_Access_Setting__c();
    customSettingRec2.Name = 'overrideeditext00';
    customSettingRec2.Profile_Name__c = 'System Administrator';
    customSettingRec2.Salesforce_Item__c = 'PR Responsible Field';
    customSettingRec2.Page_Name__c = 'overrideeditext';
    customSettingRecList.add(customSettingRec2);
    insert customSettingRecList;
    
    PageReference pgRef3 = Page.overideedit;
    Test.setCurrentPage(pgRef3);
    ApexPages.Standardcontroller controller3 = new ApexPages.Standardcontroller(objGrantIndi);
    ApexPages.currentPage().getParameters().put('Id',objGrantIndi.id);
    overrideeditext overrideEditRef3 = new overrideeditext(controller3); 
    overrideEditRef3.save();
    
    objCatalogIndi.Indicator_Type__c = 'Outcome';
    update objCatalogIndi;
    
    objGrantIndi.Baseline_Value1__c = '100 %';
    objGrantIndi.Target_Value_Y12__c = '10 %';
    objGrantIndi.Target_Value_Y22__c = '20 %';
    objGrantIndi.Target_Value_Y32__c = '30 %';
    objGrantIndi.Target_Value_Y42__c = '40 %';
    objGrantIndi.Reporting_Frequency__c = '';
    objGrantIndi.Data_Type__c = 'Percent';
    objGrantIndi.Indicator_Type__c = 'Outcome';
    update objGrantIndi;
    
    Goals_Objectives__c objObjective = TestClassHelper.createGoalsObjectives();
    objObjective.Implementation_Period__c = objIp.id;
    objObjective.Type__c  = 'Objective';
    objObjective.Performance_Framework__c = objPf.Id;
    insert objObjective;
    
    Goals_Objectives__c objObjective1 = TestClassHelper.createGoalsObjectives();
    objObjective1.Implementation_Period__c = objIp.id;
    objObjective1.Type__c  = 'Objective';
    objObjective1.Performance_Framework__c = objPf.Id;
    insert objObjective1;
    
    Ind_Goal_Jxn__c objObjectiveJN = TestClassHelper.createGoalsJunction(objGrantIndi.id, objGoalAndObj.id);
    insert objObjectiveJN;
    
    Grant_Multi_Country__c objGrntMultiCon = TestClassHelper.createGrntMultiCountry(objCon.Id,objIp.Id);
    insert objGrntMultiCon;
    
    PageReference pgRef4 = Page.overideedit;
    Test.setCurrentPage(pgRef4);
    ApexPages.Standardcontroller controller4 = new ApexPages.Standardcontroller(objGrantIndi);
    ApexPages.currentPage().getParameters().put('Id',objGrantIndi.id);
    overrideeditext overrideEditRef4 = new overrideeditext(controller4); 
    overrideEditRef4.save();
    overrideEditRef4.detailObjId = objRepPeriod.Id;
    overrideEditRef4.displayReadOnlyTargets();
    overrideEditRef4.reDirect();
}
}