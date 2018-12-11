({
	saveInvoice : function(component) {
		var self = this;

		var recordId = component.get('v.recordId');

		// Prepare Lightning Action
		var action = component.get('c.previewPDF');
		action.setParams({
			'contactId': recordId
		});

		action.setCallback(this, function(result) {
			var state = result.getState();
			if (state === 'SUCCESS') {
                var contentVersion = result.getReturnValue();
				self.handleSuccess(component, contentVersion); 
			} else if (state === 'ERROR') {
				var errors = result.getError();
				self.handleError(component, errors[0].message);
			}
		});

		// Call Action
		$A.enqueueAction(action);
	},

	handleSuccess: function(component, contentVersion) {        
		var event = $A.get("e.force:navigateToSObject");
	    event.setParams({
	    	"recordId": contentVersion.Id,
	        "slideDevName": "detail"
	    });
        
	    event.fire();
        $A.get("e.force:closeQuickAction").fire();
	},

	handleError: function(component, message) {
		var toastEvent = $A.get("e.force:showToast");
	    toastEvent.setParams({
	        "title": "ERROR",
	        "message": message,
	        "type": "error"
	    });
	    toastEvent.fire();
	    $A.get("e.force:closeQuickAction").fire();
	}
})