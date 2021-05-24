({
	handleClickDownload : function(component, event, helper) {
        component.set("v.isLoading", true);
        let action = component.get("c.updateDownloadCount");
        action.setParams({
            recId: component.get("v.asset").Id
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            component.set("v.isLoading", false);
            if (state === "SUCCESS") {
                let url = component.get("v.asset").PagesApi__Path__c;
                window.open(url);
            } else if (state === 'ERROR') {
                let errors = response.getError();
                if (errors) {
                    console.error(errors);
                } else {
                    console.error("Unknown error while calling verifyUserApex");
                }
            } else {
                console.warn(state+"returned while calling verifyUserApex");
            }
        });
        $A.enqueueAction(action);
	}
})