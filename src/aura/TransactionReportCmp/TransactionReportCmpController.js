({
	openRep : function(component, event, helper) {
        var toDate=component.get("v.toDAteValue");
        var fromDate=component.get("v.fromdateValue");
        //var type=component.get("v.type");
        window.open("/apex/TransReport?fDate="+fromDate+'&tDate='+toDate,"_blank"); //+'&type='+type
	}
})