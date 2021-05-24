/**
 * Created by Jason Cookman on 6/10/20.
 */

({
    doInit : function (component, event, helper) {

        let user = $A.get("$SObjectType.CurrentUser.Id");
        if (user !== null && user !== undefined) {
            helper.getCollaborationGroup(component);
            helper.verifyUser(component);
        } else {
            //show not logged in message (design component)
            component.set('v.notLoggedIn', true);
        }
    },

    handleSectionToggle : function (component, event, helper) {
    },

    handleClickUpload : function (component, event, helper) {
        let collectionId = event.getSource().get('v.name');
        let host = window.location.hostname;
        let formId = component.get('v.uploadFormId');
        let fieldId = component.get('v.uploadFieldId');

        let url = 'https://'+host+'/ITCP/s/forms-page?id='+formId+'&'+fieldId+'_SOQL=Id%3D%27'+collectionId+'%27';
        window.open(url);
    },

    handleClickDownload : function (component, event, helper) {
        let url = event.getSource().get('v.value');
        window.open(url);
    },

    handleSearch : function(component, event, helper) {
        let searchIn = event.getSource().get('v.value');
        var fsIntervalId = component.get('v.fsIntervalId');

        if (searchIn === null || searchIn === undefined || searchIn === '') {
            if (fsIntervalId !== null) {
                clearTimeout(fsIntervalId);
                fsIntervalId = null;
                component.set('v.fsIntervalId', fsIntervalId);
            }
            helper.resetWorkingAssetList(component);
            helper.closeAllAccordionSections(component);
        } else {
            if(fsIntervalId !== null) {
                clearTimeout(fsIntervalId);
            }

            var fsIntervalId = setTimeout($A.getCallback(function() {
                helper.modifyWorkingAssetList(component);
                helper.openAllAccordionSections(component);
            }), 100);

            component.set('v.fsIntervalId', fsIntervalId);
        }
    }


});