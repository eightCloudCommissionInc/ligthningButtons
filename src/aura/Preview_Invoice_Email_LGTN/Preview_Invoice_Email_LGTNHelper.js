({
	previewInvoiceEmail : function(id, date, component) {
        var action = component.get("c.PreviewForContactString");
        var dt = date.toISOString().substring(0,10);
        console.log('Id and Date in helper');
        console.log('Id:'+id+"\ndate: "+date);
        console.log("before isostring: "+date);
        action.setParams({
            "id":id,
            "forDate":dt
        });
        
        console.log('Date in after isostring: '+dt);
       
        action.setCallback(this, function(response){
        	var state = response.getState();
            
            console.log("This is the state: "+state);
            
            if(state==="SUCCESS"){
            	console.log("Helper success");
                
                var res = response.getReturnValue();
                //var win = window.open("","","menubar=no,location=no,resizable=yes,scrollbars=yes,centerscreen=yes,chrome=yes,height=700,width=700");
                //win.document.write(res);
                component.set("v.isOpen", true);
                component.set("v.resp", res);

                console.log('res: '+res);
 
            }
            else{
                console.log("Error on helper");
            }
            
            
        });
        
        $A.enqueueAction(action);
	}
})