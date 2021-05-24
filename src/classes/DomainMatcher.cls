public class DomainMatcher{
private string emailVal;

public DomainMatcher(string myEmail){
    this.emailVal = myEmail;
}

public list<Account> matchedAccounts(){

    list<account> matchedAccount = new list<account>();
    
    If(emailVal==NULL)
        return null;
    
    integer charQ = emailVal.indexOf('@');
    
    if(charQ==-1)
        return null;
    
    string domainStr = emailVal.subString(charQ+1, emailVal.length());
    // now identify if it has domain and subdomiain
    string mainDomain;
    if(domainStr.countMatches('.')>1){// subDomain
        List<String> parts = domainStr.split('\\.');
        set<id> accountId = new set<id>();
        // exact subdomain matching
        for(OrderApi__AccountDomain__c aDomain : [Select Id, OrderApi__Company__c From OrderApi__AccountDomain__c Where OrderApi__Value__c=:domainStr]){
            accountId.add(aDomain.OrderApi__Company__c);
        }
        if(!accountId.isEmpty()){
            matchedAccount = [Select ID, Name, Company_Category__c,ShippingCountry  From Account where id=:accountId];
            if(matchedAccount.size()>0){
                system.debug('SubDomian = True ' + 'Account record found ');
                for(account acc: matchedAccount){
                    system.debug('Account id = ' + acc.Id + ' Account name = ' + acc.Name);
                }
                return matchedAccount;
            }
        }
        // if exact subdomain matches failed, match main domain
        mainDomain = parts[0]+ '.' + parts[1];
        system.debug('SubDomian = True ' + 'mainDomain= ' + mainDomain);
    }else{
        mainDomain = domainStr;
        system.debug('SubDomian = False ' + 'mainDomain= ' + domainStr);
    }
    for(Account domainAcc : [Select ID,Name, Company_Category__c,ShippingCountry From Account where Id in (Select OrderApi__Company__c From OrderApi__AccountDomain__c Where OrderApi__Value__c=:mainDomain)]){
        system.debug('Account id = ' + domainAcc.Id + ' comapny name = ' + domainAcc.Name);
        matchedAccount.add(domainAcc);
    }
    
    if(matchedAccount.size()>0){
        return matchedAccount;
    }
    return null;
}

}