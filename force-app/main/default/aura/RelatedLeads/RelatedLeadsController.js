({
	doInit : function(component, event, helper) {
		var accountId = component.get("v.recordId");
        console.log('accountid:' + accountId);
        var action = component.get("c.findRelatedLeads");
        
        action.setParams({
            accountId: accountId
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            
            if(state === "SUCCESS") {
                component.set("v.leadList", response.getReturnValue());
            } else {
                console.log('state:' + state);
                console.log('error:' + response.getReturnValue());
                var toast = $A.get("e.force:showToast");
                toast.setParams({
                    "type": 'error',
                    "message": 'There was an error retrieving leads for this account',
                    "title": 'Related Leads Retrieval Error'
                });
                
                toast.fire();   
            }
        });
        
        $A.enqueueAction(action);
	} 
})