({
	sendForContact : function(id, dt, component) {
        var action = component.get("c.SendForContactString");
        var date = dt.toISOString().substring(0,10);
        console.log('Id and Date in helper');
        console.log('Id:'+id+"\ndate: "+dt);
        console.log("before isostring: "+dt);
        action.setParams({
            "id":id,
            "forDate":date
        });
        
        console.log('Date in after isostring: '+date);
        
        action.setCallback(this,function(response){
        	var state = response.getState();
            console.log(state);
            if(state==="SUCCESS"){
                
                var res = response.getReturnValue();
                console.log(res);
                
                if(res){
                    document.location = document.location.origin + document.location.pathname + '#{!Contact.id}_RelatedActivityList_target';
                    document.location.reload();
                }
            }
            else{
                //alert("Failed to send email");
                console.log('Error on helper');
            }
            
        });
		
        $A.enqueueAction(action);
	}
})