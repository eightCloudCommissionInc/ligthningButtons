/**
 * Created by dfitzgerald on 6/10/20.
 */

({
    getListOfMediaCollectionsWithMediaAssets : function (component) {
        let collaborationGroupId = component.get("v.collaborationGroupId");
        let action = component.get("c.getListOfMediaCollectionsWithMediaAssetsApex");
        action.setParams({collaborationGroupId: collaborationGroupId});
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                this.processAndSetList(component, response.getReturnValue());
            } else if (state === 'ERROR') {
                let errors = response.getError();
                if (errors) {
                    console.error(errors);
                } else {
                    console.error("Unknown error while calling getListOfMediaCollectionsWithMediaAssetsApex");
                }
            } else {
                console.warn(state+"returned while calling getListOfMediaCollectionsWithMediaAssetsApex");
            }
        });
        $A.enqueueAction(action);
    },

    verifyUser : function (component) {
        let collaborationGroupId = component.get("v.collaborationGroupId");
        let action = component.get("c.verifyUserApex");
        action.setParams({collaborationGroupId: collaborationGroupId});
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                if (response.getReturnValue()) {
                    component.set('v.accessDenied', false);
                    this.getListOfMediaCollectionsWithMediaAssets(component);
                } else {
                    //show access denied message (design component)
                    component.set('v.accessDenied', true);
                }
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

    },

    processAndSetList : function (component, apexAssetList) {
        //get all collection names
        var sections = [];
        apexAssetList.forEach(function(item, index, assetList){
            sections[index] = item.Name;
        });

        component.set('v.apexAssetList', apexAssetList);
        component.set('v.workingAssetList', apexAssetList);
        component.set('v.allSectionNames', sections);
    },

    closeAllAccordionSections : function (component) {
        component.find("accordion").set('v.activeSectionName', '');
    },

    openAllAccordionSections : function (component) {
        component.set('v.activeSections', component.get('v.allSectionNames'));
    },

    resetWorkingAssetList : function (component) {
        let deepCopyAssetList = JSON.parse(JSON.stringify(component.get('v.apexAssetList')));
        component.set('v.workingAssetList', deepCopyAssetList);
    },

    modifyWorkingAssetList : function (component) {
        this.resetWorkingAssetList(component);
        let searchString = component.get('v.searchIn');
        var fullAssetList = component.get('v.workingAssetList');
        var workingAssetList = [];

        fullAssetList.forEach(function(collection, index, thisCollection){
            workingAssetList[index] = collection;
            let assetList = collection.PagesApi__Media_Assets__r;
            if (!$A.util.isEmpty(collection.PagesApi__Media_Assets__r)) {
                var tempAssets = assetList.filter(
                    asset => ((!$A.util.isEmpty(asset.PagesApi__Title__c) && asset.PagesApi__Title__c.toLowerCase().includes(searchString.toLowerCase()))
                        || (!$A.util.isEmpty(asset.PagesApi__Short_Description__c) && asset.PagesApi__Short_Description__c.toLowerCase().includes(searchString.toLowerCase())))
                );
                workingAssetList[index].PagesApi__Media_Assets__r = tempAssets;
            }
        });

        component.set('v.workingAssetList', workingAssetList);
    },

    getCollaborationGroup : function(component) {
        let collabGroupId = component.get("v.collaborationGroupId"); //0F9
        if($A.util.isEmpty(collabGroupId)) {

            // get the group from the url
            let regex = /0F9[0-9a-zA-Z]{15}/gm;
            let url = window.location.href;
            let m;

            m = regex.exec(url);

               if (m != null) {
                   if (m.length > 0) {
                       collabGroupId = m[0];
                   }

                   // The result can be accessed through the `m`-variable.
                   m.forEach((match, groupIndex) => {
                       collabGroupId = match;
                       //console.log(`Found match, group ${groupIndex}: ${match}`);
                   });
               }
            }
            component.set("v.collaborationGroupId", collabGroupId);
    }

});