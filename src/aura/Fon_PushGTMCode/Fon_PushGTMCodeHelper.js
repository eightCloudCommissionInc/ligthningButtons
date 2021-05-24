({
	initMethod : function(component,event, helper) {
		var compEvent = $A.get('e.FDService:SparkPlugLoadedEvent');
        compEvent.setParams({extensionPoint : component.get('v.extensionPoint')});
        compEvent.fire();
        
        var salesorderData = component.get("v.data");       
        console.log('salesorderData--'+JSON.stringify(salesorderData));
        console.log('salesorder Id--'+salesorderData.name);
        console.log('salesorder Id--'+salesorderData.url);
        console.log('salesorder productUrl--'+salesorderData.productUrl);
        /*  var u = salesorderData.url;
        var urlSplit=u.indexof("id=");
         console.log('urlSplit='+urlSplit);
        var urlSplit1=urlSplit.indexof("&");
        var receiptIds=u.substring(urlSplit,urlSplit1);
        console.log(receiptIds);*/
        //TESTING if any data is gettting sent to GTM 30sept
        /*window.dataLayer = window.dataLayer || [];
        window.dataLayer.push({
         'transactionId':salesorderData.id ,
         'transactionAffiliation': 'Test arpita',
         'transactionTotal': 38.26, 
         'transactionTax': 1.29,
         'transactionShipping': 5,
         'transactionProducts': [{
           'sku': 'DD44',
           'name': 'T-Shirt TEST',
           'category': 'Apparel',
           'price': 11.99,  
           'quantity': 1 
         }]
        });*/
        
        // call backend method and Create a callback that is executed after 
        // the server-side action returns
        
        var action = component.get("c.getOrderProducts");
        action.setParams({
            soId : salesorderData.name
        });
        action.setCallback(this,function(response){   
            console.log('iiiiii success');
              console.log('response.getState()....'+response.getState());
            if (response.getState() == 'SUCCESS') {
                //console.log('test1 = ' + response.getReturnValue());
                if(response.getReturnValue()){
                    console.log('test = ' + response.getReturnValue());
                    component.set("v.jsonSTR", response.getReturnValue());
                    component.set("v.jsonOBJ", JSON.parse(response.getReturnValue()));
                    var productUrl = component.get("v.jsonOBJ");     
                    console.log('productUrl-'+JSON.stringify[productUrl]);
                    console.log('url-t1-'+productUrl[0].productUrl);
                    component.set("v.productUrl",productUrl[0].productUrl);
                    var url1 = component.get("v.productUrl");
                    console.log('url....'+url1);
                    var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                        "url": url1
                    });
                    urlEvent.fire();


                   // window.dataLayer = window.dataLayer;
                  //  window.dataLayer = window.dataLayer || [];
                  //  console.log('test = ' + window.dataLayer);
                  //  console.log(SecureWindow.dataLayer);
                    //window.dataLayer.push(JSON.parse(response.getReturnValue()));
                    //CHANGE BELOW LINES TO TEST FOR GOOGLE TAG MANAGER
                    window.dataLayer.push({
                         "event":"TestEvent"
        				});
                    console.log('data is pushed');
                    console.log(window.dataLayer);
                   
                    // END CHANGE LINES TO TEST FOR GOOGLE TAG MANAGER
                    var compEvent = $A.get('e.FDService:SparkPlugCompleteEvent');
                    compEvent.setParams({extensionPoint : component.get('v.extensionPoint')});
                    compEvent.fire();
                }
            }
            else if (response.getState() === "INCOMPLETE") {
                // do something
            }
                else if (response.getState() === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        $A.enqueueAction(action);
	}
})