({
	doInit : function(component, event, helper) {
        var dt = new Date();
        var id = component.get("v.recordId");
        dt = new Date(dt.getFullYear(), dt.getMonth(),1);
        console.log('Id and date in CS controller: '+id+' '+dt);
        helper.previewInvoiceEmail(id, dt, component);
	}
})