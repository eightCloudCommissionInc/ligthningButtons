({
    doInit : function(component, event, helper) {
        window.setTimeout(
            $A.getCallback(function() {
                helper.initMethod(component,event, helper)
            }), 9000
        );
    }
})