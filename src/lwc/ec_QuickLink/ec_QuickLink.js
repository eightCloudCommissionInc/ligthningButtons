import { LightningElement, wire } from 'lwc';
import Id from '@salesforce/user/Id';
import getQuickLinks from '@salesforce/apex/EC_QuickLinksController.getQuickLinks';

export default class Ec_QuickLink extends LightningElement {
    userId = Id;
    quickLinksList = [];
    error;

    @wire(getQuickLinks)
    wiredQuickLinks({error, data}){
        if(data){
            console.log(data);
            this.quickLinksList = JSON.parse(JSON.stringify(data));
            this.quickLinksList.forEach(element => {
                if(element.Link_For__c == 'Profile'){
                    element.URL__c = element.URL__c + this.userId;
                }
            });
            //this.quickLinksList = data;
            this.error = undefined;
        }else if(error){
            this.error = error;
            this.quickLinksList = [];
        }
    }

}