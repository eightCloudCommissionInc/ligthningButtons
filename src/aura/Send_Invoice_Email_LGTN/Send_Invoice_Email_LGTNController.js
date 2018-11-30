({
	doInit : function(component, event, helper) {
        var id = component.get("v.recordId");
		var dt = new Date();
        dt = new Date(dt.getFullYear(), dt.getMonth(), 1);
        helper.sendForContact(id, dt, component);
	}
})