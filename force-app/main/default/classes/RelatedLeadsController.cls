/**
 * @Author: Ryan Headley (@lifewithryan)
 * exposes an apex method to the RelatedLeads lightning component
 * based on account Id passed in will query for the custom Email_Domain__c field
 * which can be a semi-colon separated list of email domains to match on. 
 * It will then return a list of any leads whose email address matches one of those domains.
 * NOTE: this class also avoids using any sort of "contains" logic as XABC and ABC would both
 * return values if the search was merely for ABC, therefore email domains are searched with an
 * "@" symbol prepended.
 **/ 
public class RelatedLeadsController {

    @AuraEnabled
    public static List<Lead> findRelatedLeads(String accountId) {
        List<Lead> leadList = new List<Lead>();
        
        if(accountId != null) {
        	Account acc = [SELECT Id, Email_Domain__c FROM Account WHERE Id = :accountId];
            
            //ensure we have email domains we are matching against otherwise
            //return an empty list to avoid nulls, etc
            if(acc.Email_Domain__c != null) {
            	List<String> domains = acc.Email_Domain__c.split(';');  
                
                //build the base query, we will loop over possible domains and an an OR for each
                String leadQuery = 'SELECT Id, FirstName, LastName, Email FROM Lead WHERE Email LIKE ';
                
                Integer currentIteration = 0;
                for(String domain : domains) {
                    //be sure to escapeSingleQuotes to avoid SQL Injection
                    leadQuery += '\'%@' + String.escapeSingleQuotes(domain) + '\'';
                    
                    //check to see if its the last domain to process
                    //if so, skip this part and just close the query
                    if(currentIteration < domains.size() - 1) {
                        leadQuery += ' OR Email LIKE ';   
                    }
                    currentIteration++;    
                }
                
                leadList = Database.query(leadQuery); 
            }       
        }
        
        return leadList; //returns empty list to avoid nulls if no leads are found
    }
}