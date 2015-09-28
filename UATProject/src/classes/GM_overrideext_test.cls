/*********************************************************************************
@author       :TCS Developer   
*@date        : 12-09-2014
*@description : This test class is used for overrideedit.
*@Used for    : overrideeditext.
**********************************************************************************/
@isTest
 public with sharing class GM_overrideext_test{
    
   Public static testMethod void Testoverrideext(){
    
      Account objacc = TestClassHelper.insertAccount();
      
      Grant__c objGrant  = TestClassHelper.createGrant(objAcc);
         insert objGrant;
      
      Implementation_period__c objimp = TestClassHelper.createIPWithConceptNote(objGrant,objAcc);
        objimp.Reporting_Frequency__c = 'Half-yearly';
        insert objimp;
      
      Performance_Framework__c objpf = TestClassHelper.createPF(objimp);
          insert objpf;
      
      Indicator__c objind = TestClassHelper.createCatalogIndicator();
         insert objind;
       
       Catalog_Module__c objcatmod = TestClassHelper.createCatalogModule();
           insert objcatmod;
     
       Indicator__c objindcoverage = TestClassHelper.createCatalogIndicator();
         objindcoverage.Indicator_Type__c ='Coverage/Output';
         objindcoverage.Full_Name_En__c = 'test';
         objindcoverage.Is_Disaggregated__c = false;
         objindcoverage.Disaggregated_Name__c = 'testname';
         objindcoverage.Catalog_Module__c = objcatmod.id;
         insert objindcoverage;
      
       system.assertEquals(objindcoverage.Indicator_Type__c ,'Coverage/Output');
       
       objindcoverage = [select id,name,Indicator_Type__c,component__c,Catalog_Module__c,Is_Disaggregated__c from Indicator__c where id =:objindcoverage.Id ];
       system.debug('@@@catind'+objindcoverage.Name);
      
       List<RecordType> lstrec = [select id,Name from Recordtype where sObjectType='Grant_Indicator__c'];  
       
        Module__c objmod = TestClassHelper.createModule();
           objmod.Implementation_Period__c = objimp.id;
           objmod.Performance_Framework__c = objpf.id;
           objmod.Catalog_Module__c = objcatmod.Id;
           insert objmod;
       system.debug('@@catmod'+objmod.Catalog_Module__c);
       
       concept_note__c objcn = TestClassHelper.createCN();
         objcn.Concept_Note_Type__c = 'Regional';
         insert objcn;
       

       Grant_Indicator__c objgindcoverage = TestClassHelper.createGrantIndicator();
          objgindcoverage.Grant_Implementation_Period__c = objimp.id;
          objgindcoverage.Performance_Framework__c = objpf.id;
          for(RecordType objrec :lstrec){
             if(objrec.name == 'Coverage/Output_IP')
                 objgindcoverage.RecordTypeId = objrec.id;
          }
            
            objgindcoverage.Decimal_Places__c = '2';
            objgindcoverage.Indicator_Type__c = 'Coverage/Output';
            objgindcoverage.Reporting_Frequency__c = 'Based on Reporting Frequency';
                  
        
        Test.StartTest();   
        Reporting_Period_Detail__c detailObject = TestClassHelper.createReportingDetailPeriod(objimp.id, false);
        insert detailObject;
                      
       Period__c objPeriod = TestClassHelper.createPeriod();
         objPeriod.Implementation_Period__c =objimp.id;
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
         objPeriod.reporting_period_detail__c = detailObject.id;
         insert objPeriod; 
       
       system.assertEquals( objPeriod.Type__c,'Reporting');
       
       MultipleDataType__c objmul = TestClassHelper.createMultipleDataType(objindcoverage.Id);
       insert objmul;
       
       
       ApexPages.StandardController stdctrlr = new ApexPages.StandardController(objgindcoverage);
            ApexPages.currentPage().getParameters().put('gid',objimp.id);
            ApexPages.currentPage().getParameters().put('type',objgindcoverage.Indicator_Type__c);
            ApexPages.currentPage().getParameters().put('pf',objpf.id);
            ApexPages.currentPage().getParameters().put('RecordType',objgindcoverage.RecordTypeId);
         overrideext testoverrideext = new overrideext(stdctrlr);
            
             system.debug('@@'+objgindcoverage.Grant_Implementation_Period__c);
            system.debug('@@'+objgindcoverage.Performance_Framework__c);
       
           
            testoverrideext.ind.Grant_Implementation_Period__c = objimp.id;
            testoverrideext.ind.Performance_Framework__c = objpf.Id;
            testoverrideext.openlookupwindowmodule();
            objgindcoverage.Parent_Module__c = objmod.id;
             testoverrideext.module = objmod.Name;
             testoverrideext.openlookupwindow();
            testoverrideext.closepopup();
             testoverrideext.clearModuleRelVal();
            testoverrideext.ChangeFreq();
            objgindcoverage.Standard_or_Custom__c = 'Standard';
            objgindcoverage.Indicator__c =  objindcoverage.id; 
            testoverrideext.catind =  objindcoverage.Name;
            objgindcoverage.Reporting_Frequency__c = 'Based on Reporting Frequency';
            testoverrideext.ind.Reporting_Frequency__c = 'Based on Reporting Frequency';
            testoverrideext.showReportingFreqAndDataType();
            testoverrideext.changeCumilation();
            testoverrideext.changeCumilationText();
            testoverrideext.showdatatype();
            testoverrideext.fillsubset();
            testoverrideext.save();
            testoverrideext.cancel();
            testoverrideext.detailObjId = detailObject.id;
            testoverrideext.displayReadOnlyTargets();
        
       Test.StopTest();
      
   }
   Public static testMethod void Testoverrideext1(){
      Account objacc = TestClassHelper.insertAccount();
      
      Grant__c objGrant  = TestClassHelper.createGrant(objAcc);
         insert objGrant;
      
      Implementation_period__c objimp = TestClassHelper.createIPWithConceptNote(objGrant,objAcc);
        objimp.Reporting_Frequency__c = 'Half-yearly';
        objimp.Start_Date__c = Null;
       insert objimp;
      
      Performance_Framework__c objpf = TestClassHelper.createPF(objimp);
          objpf.Implementation_Period__c = objimp.Id;
          insert objpf;
      
      Indicator__c objind = TestClassHelper.createCatalogIndicator();
        objind.Type_of_Data__c = 'Ratio';
        objind.Component__c = 'Malaria';
        objind.Is_Disaggregated__c = true;
        objind.Disaggregated_Name__c = 'test';
         insert objind;
         
         system.assertEquals( objind.Is_Disaggregated__c,true);
         
       objind = [select id,name,Component__c,Is_Disaggregated__c from Indicator__c where id =:objind.Id ];
       
       List<RecordType> lstrec = [select id,Name from Recordtype where sObjectType='Grant_Indicator__c'];  
       
       Goals_Objectives__c objgoal = TestClassHelper.createGoalsObjectives();
         objgoal.Implementation_Period__c = objimp.id;
         objgoal.Performance_Framework__c = objpf.Id;
           insert objgoal;
       
       Grant_Indicator__c objgind2 = TestClassHelper.createGrantIndicator();
          objgind2.Grant_Implementation_Period__c = objimp.id;
          objgind2.Performance_Framework__c = objpf.id;
          objgind2.Standard_or_Custom__c = 'Standard';
          objgind2.Data_Type__c =  'Number' ;
          objgind2.Decimal_Places__c = '2';
          objgind2.Indicator_Type__c = 'Impact';
          objgind2.Baseline_Value1__c = '20';
          objgind2.Indicator__c =  objind.Id;
          for(RecordType objrec :lstrec){
             if(objrec.name == 'Impact_IP')
                 objgind2.RecordTypeId = objrec.id;
          }
          objgind2.Component__c = 'Malaria';
          insert objgind2;
       
       Grant_Indicator__c objgind = TestClassHelper.createGrantIndicator();
          objgind.Grant_Implementation_Period__c = objimp.id;
          objgind.Performance_Framework__c = objpf.id;
          objgind.Standard_or_Custom__c = 'Standard';
          objgind.Indicator__c =  objind.id;
          objgind.Data_Type__c =  'Ratio' ;
          objgind.Decimal_Places__c = '2';
          objgind.Indicator_Type__c = 'Impact';
          objgind.Baseline_Value1__c = '20';
          for(RecordType objrec :lstrec){
             if(objrec.name == 'Impact_IP')
                 objgind.RecordTypeId = objrec.id;
          }
          objgind.Component__c = 'Malaria';
       
       ApexPages.StandardController stdctrlr1 = new ApexPages.StandardController(objgind);
          ApexPages.currentPage().getParameters().put('gid',objimp.id);
            ApexPages.currentPage().getParameters().put('type',objgind.Indicator_Type__c);
            ApexPages.currentPage().getParameters().put('pf',objpf.id);
            ApexPages.currentPage().getParameters().put('RecordType',objgind.RecordTypeId);   
       overrideext testoverrideext1 = new overrideext(stdctrlr1);
       overrideext.wrapgoals goalswrap = new overrideext.wrapgoals(objgoal);
           // testoverrideext1.lstwgoalobj[0].Selected = true;
            testoverrideext1.catind = objind.name;
          
         Test.StartTest(); 
            testoverrideext1.showsign();
            testoverrideext1.onChangeType();
            testoverrideext1.showReportingFreqAndDataType();
            testoverrideext1.save();
            testoverrideext1.cancel();
            system.debug('@@comp'+objgind.Component__c);
            system.debug('@@comp'+objind.Component__c);
            testoverrideext1.openlookupwindow();
            Test.StopTest();
       
       Goals_Objectives__c objgoal1 = TestClassHelper.createGoalsObjectives();
         objgoal1.Implementation_Period__c = objimp.id;
         objgoal1.Performance_Framework__c = objpf.Id;
         objgoal1.Type__c  = 'Objective';
           insert objgoal1;
           
       
       
       Grant_Indicator__c objgind1 = TestClassHelper.createGrantIndicator();
          objgind1.Grant_Implementation_Period__c = objimp.id;
          objgind1.Performance_Framework__c = objpf.id;
          objgind1.Standard_or_Custom__c = 'Custom';
          objgind1.Data_Type__c =  'Number' ;
          objgind1.Decimal_Places__c = '2';
          objgind1.Indicator_Type__c = 'Outcome';
          objgind1.Baseline_Value1__c = '20';
          for(RecordType objrec :lstrec){
             if(objrec.name == 'Outcome_IP')
                 objgind1.RecordTypeId = objrec.id;
          }
          
          Profile_Access_Setting__c objpas = TestClassHelper.createProfileSetting();
          objpas.Page_Name__c = 'overideIndicator';
          objpas.Salesforce_Item__c = Label.Edit_Global_Fund_Comment_to_PR;
          objpas.Status__c = null; 
          insert objpas;
          
          Profile_Access_Setting__c objpas1 = TestClassHelper.createProfileSetting();
          objpas1.Page_Name__c = 'overideIndicator';
          objpas1.Salesforce_Item__c = 'Read_Global fund comment to PR';
          objpas1.Status__c = null; 
          insert objpas1;
          
          Profile_Access_Setting__c objpas2 = TestClassHelper.createProfileSetting();
          objpas2.Page_Name__c = 'overideIndicator';
          objpas2.Salesforce_Item__c = Label.Show_PR_comment;
          objpas2.Status__c = Label.Impact_type;
          objpas2.Status__c = null; 
          insert objpas2;
          
          Profile_Access_Setting__c objpas3 = TestClassHelper.createProfileSetting();
          objpas3.Page_Name__c = 'overideIndicator';
          objpas3.Salesforce_Item__c = 'Edit LFA Comments';
          objpas3.Status__c = null; 
          insert objpas3;
          
          Profile_Access_Setting__c objpas4 = TestClassHelper.createProfileSetting();
          objpas4.Page_Name__c = 'overideIndicator';
          objpas4.Salesforce_Item__c = 'View_Global Fund Comments to LFA';
          objpas4.Status__c = null; 
          insert objpas4;
          
          Profile_Access_Setting__c objpas5 = TestClassHelper.createProfileSetting();
          objpas5.Page_Name__c = 'overideIndicator';
          objpas5.Salesforce_Item__c = 'View LFA Comments';
          objpas5.Status__c = null; 
          insert objpas5;
          
           system.assertEquals(objgind1.Indicator_Type__c,'Outcome');
           
         ApexPages.StandardController stdctrlr2 = new ApexPages.StandardController(objgind1);
        ApexPages.currentPage().getParameters().put('type',objgind1.Indicator_Type__c);
        ApexPages.currentPage().getParameters().put('RecordType',objgind1.RecordTypeId);   
        overrideext testoverrideext2 = new overrideext(stdctrlr2);
        overrideext.wrapgoals goalswrap2 = new overrideext.wrapgoals(objgoal1);
            testoverrideext2.showsign();
            testoverrideext2.onChangeType();
            testoverrideext2.save();
            testoverrideext2.cancel();
   }
    Public static testMethod void Testoverrideext2(){
         Account objacct =  TestClassHelper.createAccount();
         insert objacct;
         
         Grant__c objGrant  = TestClassHelper.createGrant(objacct);
         objGrant.Principal_Recipient__c = objacct.Id;
         insert objGrant;
         
         Implementation_Period__c objimp = TestClassHelper.createIPWithConceptNote(objGrant, objacct);
         objimp.Grant__c = objGrant.Id;
         objimp.Principal_Recipient__c = objacct.Id;
         insert objimp;
         
         Performance_Framework__c objpf = TestClassHelper.createPF(objimp);
         objpf.Implementation_Period__c = objimp.Id;
         insert objpf;
         
         Indicator__c objcatind = TestClassHelper.createCatalogIndicator();
         objcatind.Grant__c = objGrant.Id;
         insert objcatind;
         
         Goals_Objectives__c objgoal = new Goals_Objectives__c();
         objgoal.Type__c = 'Goal';
         objgoal.Performance_Framework__c = objpf.Id;
         insert objgoal;
         
         Goals_Objectives__c objobj = new Goals_Objectives__c();
         objobj.Type__c = 'Objective';
         objobj.Performance_Framework__c = objpf.Id;
         insert objobj;
         
         List<RecordType> lstrec = [select id,Name from Recordtype where sObjectType='Grant_Indicator__c'];  
         
         Grant_Indicator__c objgiimp =  TestClassHelper.createGrantIndicator();
         objgiimp.Performance_Framework__c = objpf.Id;
         objgiimp.Type__c = 'Impact';
         objgiimp.Standard_or_Custom__c = 'Standard';
         
         system.assertEquals(objgiimp.Type__c ,'Impact');
         ApexPages.StandardController stdctrlimp = new ApexPages.StandardController(objgiimp);
        // overrideext objindimptest = new overrideext(stdctrlimp);
         
         ApexPages.currentpage().getparameters().put('gid',objimp.Id);
    }
   
         
   Public static testMethod void Testoverrideext10(){
    
      Account objacc = TestClassHelper.insertAccount();
      
      Grant__c objGrant  = TestClassHelper.createGrant(objAcc);
         insert objGrant;
      
      Implementation_period__c objimp = TestClassHelper.createIPWithConceptNote(objGrant,objAcc);
        objimp.Reporting_Frequency__c = 'Half-yearly';
        insert objimp;
      
      Performance_Framework__c objpf = TestClassHelper.createPF(objimp);
          insert objpf;
      
      Indicator__c objind = TestClassHelper.createCatalogIndicator();
         insert objind;
       
       Catalog_Module__c objcatmod = TestClassHelper.createCatalogModule();
           insert objcatmod;
     
       Indicator__c objindcoverage = TestClassHelper.createCatalogIndicator();
         objindcoverage.Indicator_Type__c ='Coverage/Output';
         objindcoverage.Full_Name_En__c = 'test';
         objindcoverage.Is_Disaggregated__c = false;
         objindcoverage.Disaggregated_Name__c = 'testname';
         objindcoverage.Catalog_Module__c = objcatmod.id;
         insert objindcoverage;
       
       objindcoverage = [select id,name,Indicator_Type__c,component__c,Catalog_Module__c,Is_Disaggregated__c from Indicator__c where id =:objindcoverage.Id ];
       system.debug('@@@catind'+objindcoverage.Name);
      
      
       List<RecordType> lstrec = [select id,Name from Recordtype where sObjectType='Grant_Indicator__c'];  
       
        Module__c objmod = TestClassHelper.createModule();
           objmod.Implementation_Period__c = objimp.id;
           objmod.Performance_Framework__c = objpf.id;
           objmod.Catalog_Module__c = objcatmod.Id;
           insert objmod;
       system.debug('@@catmod'+objmod.Catalog_Module__c);
       
       concept_note__c objcn = TestClassHelper.createCN();
         objcn.Concept_Note_Type__c = 'Regional';
         insert objcn;
       

       Grant_Indicator__c objgindcoverage = TestClassHelper.createGrantIndicator();
          objgindcoverage.Grant_Implementation_Period__c = objimp.id;
          objgindcoverage.Performance_Framework__c = objpf.id;
          for(RecordType objrec :lstrec){
             if(objrec.name == 'Coverage/Output_IP')
                 objgindcoverage.RecordTypeId = objrec.id;
          }
            
            objgindcoverage.Decimal_Places__c = '2';
            objgindcoverage.Indicator_Type__c = 'Coverage/Output';
            objgindcoverage.Reporting_Frequency__c = 'Based on Reporting Frequency';
                  
        
        Test.StartTest();   
        Reporting_Period_Detail__c detailObject = TestClassHelper.createReportingDetailPeriod(objimp.id, false);
        insert detailObject;
                      
       Period__c objPeriod = TestClassHelper.createPeriod();
         objPeriod.Implementation_Period__c =objimp.id;
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
         objPeriod.reporting_period_detail__c = detailObject.id;
         insert objPeriod; 
       
       MultipleDataType__c objmul = TestClassHelper.createMultipleDataType(objindcoverage.Id);
       insert objmul;
       
       
       ApexPages.StandardController stdctrlr = new ApexPages.StandardController(objgindcoverage);
            ApexPages.currentPage().getParameters().put('gid',objimp.id);
            ApexPages.currentPage().getParameters().put('type',objgindcoverage.Indicator_Type__c);
            ApexPages.currentPage().getParameters().put('pf',objpf.id);
            ApexPages.currentPage().getParameters().put('RecordType',objgindcoverage.RecordTypeId);
         overrideext testoverrideext = new overrideext(stdctrlr);
            
             system.debug('@@'+objgindcoverage.Grant_Implementation_Period__c);
            system.debug('@@'+objgindcoverage.Performance_Framework__c);
       
           
            testoverrideext.ind.Grant_Implementation_Period__c = objimp.id;
            testoverrideext.ind.Performance_Framework__c = objpf.Id;
            testoverrideext.openlookupwindowmodule();
            objgindcoverage.Parent_Module__c = objmod.id;
             testoverrideext.module = objmod.Name;
             testoverrideext.openlookupwindow();
            testoverrideext.closepopup();
             testoverrideext.clearModuleRelVal();
            testoverrideext.ChangeFreq();
          //  objgindcoverage.Standard_or_Custom__c = 'Standard';
            objgindcoverage.Indicator__c =  objindcoverage.id; 
            testoverrideext.catind =  objindcoverage.Name;
            objgindcoverage.Reporting_Frequency__c = 'Based on Reporting Frequency';
            
            system.assertEquals(objgindcoverage.Reporting_Frequency__c,'Based on Reporting Frequency');
            
            testoverrideext.ind.Reporting_Frequency__c = 'Based on Reporting Frequency';
            testoverrideext.showReportingFreqAndDataType();
            testoverrideext.changeCumilation();
            testoverrideext.changeCumilationText();
            testoverrideext.showdatatype();
            testoverrideext.fillsubset();
            testoverrideext.save();
            testoverrideext.cancel();
            testoverrideext.detailObjId = detailObject.id;
            testoverrideext.displayReadOnlyTargets();
            
            
       Test.StopTest();
      
   }
       
   Public static testMethod void Testoverrideext11(){
    
      Account objacc = TestClassHelper.insertAccount();
      
      Grant__c objGrant  = TestClassHelper.createGrant(objAcc);
         insert objGrant;
      
      Implementation_period__c objimp = TestClassHelper.createIPWithConceptNote(objGrant,objAcc);
        objimp.Reporting_Frequency__c = 'Half-yearly';
        insert objimp;
      
      Performance_Framework__c objpf = TestClassHelper.createPF(objimp);
          insert objpf;
      
      Indicator__c objind = TestClassHelper.createCatalogIndicator();
         insert objind;
       
       Catalog_Module__c objcatmod = TestClassHelper.createCatalogModule();
           insert objcatmod;
     
       Indicator__c objindcoverage = TestClassHelper.createCatalogIndicator();
         objindcoverage.Indicator_Type__c ='Coverage/Output';
         objindcoverage.Full_Name_En__c = 'test';
         objindcoverage.Is_Disaggregated__c = false;
         objindcoverage.Disaggregated_Name__c = 'testname';
         objindcoverage.Catalog_Module__c = objcatmod.id;
         insert objindcoverage;
       
       objindcoverage = [select id,name,Indicator_Type__c,component__c,Catalog_Module__c,Is_Disaggregated__c from Indicator__c where id =:objindcoverage.Id ];
       system.debug('@@@catind'+objindcoverage.Name);
      
       List<RecordType> lstrec = [select id,Name from Recordtype where sObjectType='Grant_Indicator__c'];  
       
        Module__c objmod = TestClassHelper.createModule();
           objmod.Implementation_Period__c = objimp.id;
           objmod.Performance_Framework__c = objpf.id;
           objmod.Catalog_Module__c = objcatmod.Id;
           insert objmod;
       system.debug('@@catmod'+objmod.Catalog_Module__c);
       
       concept_note__c objcn = TestClassHelper.createCN();
         objcn.Concept_Note_Type__c = 'Regional';
         insert objcn;
       

       Grant_Indicator__c objgindcoverage = TestClassHelper.createGrantIndicator();
          objgindcoverage.Grant_Implementation_Period__c = objimp.id;
          objgindcoverage.Performance_Framework__c = objpf.id;
          for(RecordType objrec :lstrec){
             if(objrec.name == 'Coverage/Output_IP')
                 objgindcoverage.RecordTypeId = objrec.id;
          }
            
            objgindcoverage.Decimal_Places__c = '2';
            objgindcoverage.Indicator_Type__c = 'Coverage/Output';
            objgindcoverage.Reporting_Frequency__c = 'Based on Reporting Frequency';
                  
        
       Test.StartTest();    
        Reporting_Period_Detail__c detailObject = TestClassHelper.createReportingDetailPeriod(objimp.id, false);
        insert detailObject;
                      
       Period__c objPeriod = TestClassHelper.createPeriod();
         objPeriod.Implementation_Period__c =objimp.id;
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
         objPeriod.reporting_period_detail__c = detailObject.id;
         insert objPeriod; 
       
       MultipleDataType__c objmul = TestClassHelper.createMultipleDataType(objindcoverage.Id);
       insert objmul;
       
       
       ApexPages.StandardController stdctrlr = new ApexPages.StandardController(objgindcoverage);
            ApexPages.currentPage().getParameters().put('gid',objimp.id);
            ApexPages.currentPage().getParameters().put('type',objgindcoverage.Indicator_Type__c);
            ApexPages.currentPage().getParameters().put('pf',objpf.id);
            ApexPages.currentPage().getParameters().put('RecordType',objgindcoverage.RecordTypeId);
            //ApexPages.currentPage().getParameters().put('cnid',objcn.id); 
            overrideext testoverrideext = new overrideext(stdctrlr);
            
             system.debug('@@'+objgindcoverage.Grant_Implementation_Period__c);
            system.debug('@@'+objgindcoverage.Performance_Framework__c);
       
           
            testoverrideext.ind.Grant_Implementation_Period__c = objimp.id;
            testoverrideext.ind.Performance_Framework__c = objpf.Id;
            testoverrideext.openlookupwindowmodule();
            objgindcoverage.Parent_Module__c = objmod.id;
           //  testoverrideext.module = objmod.Name;
             testoverrideext.openlookupwindow();
            testoverrideext.closepopup();
             testoverrideext.clearModuleRelVal();
            testoverrideext.ChangeFreq();
          //  objgindcoverage.Standard_or_Custom__c = 'Standard';
            objgindcoverage.Indicator_Type__c =  'Coverage/Output'; 
            testoverrideext.module = '';
            objgindcoverage.Indicator__c =  objindcoverage.id; 
            testoverrideext.catind =  objindcoverage.Name;
            objgindcoverage.Reporting_Frequency__c = 'Based on Reporting Frequency';
            testoverrideext.ind.Reporting_Frequency__c = 'Based on Reporting Frequency';
            testoverrideext.showReportingFreqAndDataType();
            testoverrideext.changeCumilation();
            testoverrideext.changeCumilationText();
            testoverrideext.showdatatype();
            testoverrideext.fillsubset();
            testoverrideext.save();
            system.assertEquals(objgindcoverage.Reporting_Frequency__c,'Based on Reporting Frequency');
            testoverrideext.cancel();
            testoverrideext.detailObjId = detailObject.id;
            testoverrideext.displayReadOnlyTargets();
            testoverrideext.onChangeStdCust();
            
       Test.StopTest();
      
   }
      
   
   Public static testMethod void Testoverrideext12(){
    
      Account objacc = TestClassHelper.insertAccount();
      
      Grant__c objGrant  = TestClassHelper.createGrant(objAcc);
         insert objGrant;
      
      Implementation_period__c objimp = TestClassHelper.createIPWithConceptNote(objGrant,objAcc);
        objimp.Reporting_Frequency__c = 'Half-yearly';
        insert objimp;
      
      Performance_Framework__c objpf = TestClassHelper.createPF(objimp);
          insert objpf;
      
      Indicator__c objind = TestClassHelper.createCatalogIndicator();
         insert objind;
       
       Catalog_Module__c objcatmod = TestClassHelper.createCatalogModule();
           insert objcatmod;
     
       Indicator__c objindcoverage = TestClassHelper.createCatalogIndicator();
         objindcoverage.Indicator_Type__c ='Coverage/Output';
         objindcoverage.Is_Disaggregated__c = true;
         objindcoverage.Disaggregated_Name__c = 'testname';
         objindcoverage.Catalog_Module__c = objcatmod.id;
         insert objindcoverage;
       system.assertEquals( objindcoverage.Is_Disaggregated__c, true);
       objindcoverage = [select id,name,Indicator_Type__c,component__c,Catalog_Module__c,Is_Disaggregated__c from Indicator__c where id =:objindcoverage.Id ];
       system.debug('@@@catind'+objindcoverage.Name);
      
       List<RecordType> lstrec = [select id,Name from Recordtype where sObjectType='Grant_Indicator__c'];  
       
        Module__c objmod = TestClassHelper.createModule();
           objmod.Implementation_Period__c = objimp.id;
           objmod.Performance_Framework__c = objpf.id;
           objmod.Catalog_Module__c = objcatmod.Id;
           insert objmod;
       system.debug('@@catmod'+objmod.Catalog_Module__c);
       
       concept_note__c objcn = TestClassHelper.createCN();
         objcn.Concept_Note_Type__c = 'Regional';
         insert objcn;
       

       Grant_Indicator__c objgindcoverage = TestClassHelper.createGrantIndicator();
          objgindcoverage.Grant_Implementation_Period__c = objimp.id;
          objgindcoverage.Performance_Framework__c = objpf.id;
          /*for(RecordType objrec :lstrec){
             if(objrec.name == 'Coverage/Output_IP')
                 objgindcoverage.RecordTypeId = objrec.id;
          }*/
            
            objgindcoverage.Decimal_Places__c = '2';
            objgindcoverage.Indicator_Type__c =Label.Impact_type ;
            objgindcoverage.Reporting_Frequency__c = 'Based on Reporting Frequency';
              
        
       Test.StartTest();    
        Reporting_Period_Detail__c detailObject = TestClassHelper.createReportingDetailPeriod(objimp.id, false);
        insert detailObject;
                      
       Period__c objPeriod = TestClassHelper.createPeriod();
         objPeriod.Implementation_Period__c =objimp.id;
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
         objPeriod.reporting_period_detail__c = detailObject.id;
         insert objPeriod; 
       
       MultipleDataType__c objmul = TestClassHelper.createMultipleDataType(objindcoverage.Id);
       insert objmul;
       
       
       ApexPages.StandardController stdctrlr = new ApexPages.StandardController(objgindcoverage);
            ApexPages.currentPage().getParameters().put('gid',objimp.id);
            ApexPages.currentPage().getParameters().put('type',objgindcoverage.Indicator_Type__c);
            ApexPages.currentPage().getParameters().put('pf',objpf.id);
            ApexPages.currentPage().getParameters().put('RecordType',objgindcoverage.RecordTypeId);
            //ApexPages.currentPage().getParameters().put('cnid',objcn.id); 
            overrideext testoverrideext = new overrideext(stdctrlr);
            
             system.debug('@@'+objgindcoverage.Grant_Implementation_Period__c);
            system.debug('@@'+objgindcoverage.Performance_Framework__c);
       
           
            testoverrideext.ind.Grant_Implementation_Period__c = objimp.id;
            testoverrideext.ind.Performance_Framework__c = objpf.Id;
            testoverrideext.openlookupwindowmodule();
            objgindcoverage.Parent_Module__c = objmod.id;
           //  testoverrideext.module = objmod.Name;
             testoverrideext.openlookupwindow();
            testoverrideext.closepopup();
             testoverrideext.clearModuleRelVal();
            testoverrideext.ChangeFreq();
          //  objgindcoverage.Standard_or_Custom__c = 'Standard';
            objgindcoverage.Indicator_Type__c =  Label.Impact_type ; 
            testoverrideext.module = '';
            objgindcoverage.Indicator__c =  objindcoverage.id; 
            testoverrideext.catind =  objindcoverage.Name;
            
            objgindcoverage.Reporting_Frequency__c = 'Based on Reporting Frequency';
            //testoverrideext.ind.Reporting_Frequency__c = 'Based on Reporting Frequency';
            testoverrideext.ind.Indicator_Full_Name__c= '';
            testoverrideext.ind.Standard_or_Custom__c = Label.Custom_type;
            testoverrideext.ind.Data_Type__c = '';
            testoverrideext.ind.Reporting_Frequency__c = '';  
              
            testoverrideext.showReportingFreqAndDataType();
            testoverrideext.changeCumilation();
            testoverrideext.changeCumilationText();
            testoverrideext.showdatatype();
            testoverrideext.fillsubset();
            testoverrideext.save();
            testoverrideext.cancel();
            testoverrideext.detailObjId = detailObject.id;
            testoverrideext.displayReadOnlyTargets();
            testoverrideext.onChangeStdCust();
            
       Test.StopTest();
      
   }
   
   Public static testMethod void Testoverrideext13(){
    
      Account objacc = TestClassHelper.insertAccount();
      
      Grant__c objGrant  = TestClassHelper.createGrant(objAcc);
         insert objGrant;
      
      Implementation_period__c objimp = TestClassHelper.createIPWithConceptNote(objGrant,objAcc);
        objimp.Reporting_Frequency__c = 'Half-yearly';
        insert objimp;
      
      Performance_Framework__c objpf = TestClassHelper.createPF(objimp);
          insert objpf;
      
      Indicator__c objind = TestClassHelper.createCatalogIndicator();
         insert objind;
       
       Catalog_Module__c objcatmod = TestClassHelper.createCatalogModule();
           insert objcatmod;
     
       Indicator__c objindcoverage = TestClassHelper.createCatalogIndicator();
         objindcoverage.Indicator_Type__c =Label.coverage_CN_rec_name;
         objindcoverage.Is_Disaggregated__c = true;
         objindcoverage.Disaggregated_Name__c = 'testname';
         objindcoverage.Catalog_Module__c = objcatmod.id;
         insert objindcoverage;
       
       objindcoverage = [select id,name,Indicator_Type__c,component__c,Catalog_Module__c,Is_Disaggregated__c from Indicator__c where id =:objindcoverage.Id ];
       system.debug('@@@catind'+objindcoverage.Name);
      
       List<RecordType> lstrec = [select id,Name from Recordtype where sObjectType='Grant_Indicator__c'];  
       
        Module__c objmod = TestClassHelper.createModule();
           objmod.Implementation_Period__c = objimp.id;
           objmod.Performance_Framework__c = objpf.id;
           objmod.Catalog_Module__c = objcatmod.Id;
           insert objmod;
          
       
       concept_note__c objcn = TestClassHelper.createCN();
         objcn.Concept_Note_Type__c = 'Regional';
         insert objcn;
        
        system.assertEquals(objcn.Concept_Note_Type__c , 'Regional'); 
        
        Country__c objCountry = TestClassHelper.insertCountry();
        
        Grant_Multi_Country__c objGrntMC = TestClassHelper.createGrntMultiCountry(objCountry.Id,objimp.Id );
        objGrntMC.Country__c = objCountry.Id;
        insert objGrntMC;
        
       Grant_Indicator__c objgindcoverage = TestClassHelper.createGrantIndicator();
          objgindcoverage.Grant_Implementation_Period__c = objimp.id;
          objgindcoverage.Performance_Framework__c = objpf.id;
          /*for(RecordType objrec :lstrec){
             if(objrec.name == 'Coverage/Output_IP')
                 objgindcoverage.RecordTypeId = objrec.id;
          }*/
            
            objgindcoverage.Decimal_Places__c = '2';
            objgindcoverage.Indicator_Type__c =Label.coverage_CN_rec_name ;
            //objgindcoverage.Reporting_Frequency__c = 'Based on Reporting Frequency';
             insert  objgindcoverage;
        
       Test.StartTest();    
        Reporting_Period_Detail__c detailObject = TestClassHelper.createReportingDetailPeriod(objimp.id, false);
        insert detailObject;
                      
       Period__c objPeriod = TestClassHelper.createPeriod();
         objPeriod.Implementation_Period__c =objimp.id;
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
         objPeriod.reporting_period_detail__c = detailObject.id;
         insert objPeriod; 
       
       MultipleDataType__c objmul = TestClassHelper.createMultipleDataType(objindcoverage.Id);
       insert objmul;
          
          Result__c objResult = new Result__c();
            objResult.Target__c = 67;
            objResult.Target_Numerator__c = 98;
            objResult.Target_Denominator__c = 100;
            objResult.Indicator__c = objgindcoverage.id;
            objResult.Period__c = objPeriod.Id;
            insert objResult;
       
       ApexPages.StandardController stdctrlr = new ApexPages.StandardController(objgindcoverage);
            ApexPages.currentPage().getParameters().put('gid',objimp.id);
            ApexPages.currentPage().getParameters().put('type',objgindcoverage.Indicator_Type__c);
            ApexPages.currentPage().getParameters().put('pf',objpf.id);
            ApexPages.currentPage().getParameters().put('RecordType',objgindcoverage.RecordTypeId);
            //ApexPages.currentPage().getParameters().put('cnid',objcn.id); 
            overrideext testoverrideext = new overrideext(stdctrlr);
            
             system.debug('@@'+objgindcoverage.Grant_Implementation_Period__c);
            system.debug('@@'+objgindcoverage.Performance_Framework__c);
       
           
            testoverrideext.ind.Grant_Implementation_Period__c = objimp.id;
            testoverrideext.ind.Performance_Framework__c = objpf.Id;
            testoverrideext.openlookupwindowmodule();
            objgindcoverage.Parent_Module__c = objmod.id;
           //  testoverrideext.module = objmod.Name;
             testoverrideext.openlookupwindow();
            testoverrideext.closepopup();
             testoverrideext.clearModuleRelVal();
            testoverrideext.ChangeFreq();
          //  objgindcoverage.Standard_or_Custom__c = 'Standard';
            objgindcoverage.Indicator_Type__c =  Label.coverage_CN_rec_name ; 
            testoverrideext.module = '';
            objgindcoverage.Indicator__c =  objindcoverage.id; 
            testoverrideext.catind =  objindcoverage.Name;
            
            objgindcoverage.Reporting_Frequency__c = 'Based on Reporting Frequency';
            testoverrideext.ind.Reporting_Frequency__c = 'Based on Reporting Frequency';
             
              
            testoverrideext.showReportingFreqAndDataType();
            testoverrideext.changeCumilation();
            testoverrideext.changeCumilationText();
            testoverrideext.showdatatype();
            testoverrideext.fillsubset();
            testoverrideext.save();
            testoverrideext.cancel();
            testoverrideext.detailObjId = detailObject.id;
            testoverrideext.displayReadOnlyTargets();
            testoverrideext.onChangeStdCust();
            
       Test.StopTest();
      
   }
 }