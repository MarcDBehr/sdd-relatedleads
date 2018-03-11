@isTest
public class TestRelatedLeadsController {
	
    @testSetup 
    public static void testSetup() {
        Account acc1 = new Account(Name='Test Account 1', Email_Domain__c='test.net;testing.net');
        insert acc1;
        
        List<Lead> testLeads = new List<Lead>();
        Lead l1 = new Lead(FirstName='Testy', LastName='Testerson', Email='testy@test.net', Company='Some Company');
        testLeads.add(l1);
        Lead l2 = new Lead(FirstName='Jake', LastName='Blues', Email='jolietjake@testing.net', Company='Some Company');
        testLeads.add(l2);
        Lead l3 = new Lead(FirstName='Elwood', LastName='Blues', Email='elwood@thiswillnotmatch.org', Company='Some Company');
        testLeads.add(l3);
        
        insert testLeads;
    }
    
    @isTest
    public static void testControllerFindsMultipleLeads() {
        List<Account> accounts = [SELECT Id FROM Account];
        System.assertEquals(1, accounts.size(), 'Test received unexpected number of accounts');
        
        List<Lead> relatedLeads = RelatedLeadsController.findRelatedLeads(accounts[0].Id);
        System.assertEquals(2, relatedLeads.size(), 'Test found unexpected number of leads');
    }
    
    @isTest
    public static void testControllerFindsOneLead() {
        List<Account> accounts = [SELECT Id FROM Account];
        System.assertEquals(1, accounts.size(), 'Test received unexpected number of accounts');
        Account acc = accounts[0];
        acc.Email_Domain__c = 'test.net';
        update acc;
        
        List<Lead> relatedLeads = RelatedLeadsController.findRelatedLeads(accounts[0].Id);
        System.assertEquals(1, relatedLeads.size(), 'Test found unexpected number of leads');
    }
    
    @isTest
    public static void testControllerFindsNoLeadsWithNonMatchedDomain() {
        List<Account> accounts = [SELECT Id FROM Account];
        System.assertEquals(1, accounts.size(), 'Test received unexpected number of accounts');
        Account acc = accounts[0];
        acc.Email_Domain__c = 'whatever.org';
        update acc;
        
        List<Lead> relatedLeads = RelatedLeadsController.findRelatedLeads(accounts[0].Id);
        System.assertEquals(0, relatedLeads.size(), 'Test found unexpected number of leads');
    }
    
    @isTest
    public static void testControllerFindsNoLeadsWithEmptyDomain() {
        List<Account> accounts = [SELECT Id FROM Account];
        System.assertEquals(1, accounts.size(), 'Test received unexpected number of accounts');
        Account acc = accounts[0];
        acc.Email_Domain__c = '';
        update acc;
        
        List<Lead> relatedLeads = RelatedLeadsController.findRelatedLeads(accounts[0].Id);
        System.assertEquals(0, relatedLeads.size(), 'Test found unexpected number of leads');
    }
}