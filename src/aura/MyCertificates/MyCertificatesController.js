({
   init: function (cmp, event, helper) {
        
        cmp.set('v.ceucolumns', [
                {label: 'CERTIFICATION AND CEU NAME', fieldName: 'Name', type: 'text'},
                {label: 'Contact Hours', fieldName: 'FON_Contact_Hours__c', type: 'number'},
                {label: 'Number Of Credits', fieldName: 'FON_Number_of_Credits__c', type: 'number'},
            	{label: 'Awarded Date', fieldName: 'FON_Awarded_Date__c', type: 'Date'},
            {type: "button", typeAttributes: {
                label: 'View Certificate',
                name: 'View',
                title: 'View',
                disabled: false,
                value: 'viewcertificate',
                iconPosition: 'left'
            }}
            ]);
       var urlString = window.location.href;
       console.log('---'+urlString);
       //https://staging-myzerotothree.cs8.force.com/ZT3StagingCommunity/s/my-certificates
 		var baseURLcom = urlString.substring(0, urlString.indexOf("/s/"));
 		cmp.set('v.cbaseURL', baseURLcom);
        helper.getCEUS(cmp);
    },
    viewRecord : function(component, event, helper) {
        var recId = event.getParam('row').Id;
        var actionName = event.getParam('action').name;
        if ( actionName == 'View') {
            alert('view');
            var viewRecordEvent = $A.get("e.force:navigateToURL");
            viewRecordEvent.setParams({
                "url": "/" + recId
            });
            viewRecordEvent.fire();
        }
    }

})