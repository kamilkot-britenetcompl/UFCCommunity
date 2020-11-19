global class UFC_SSOHandler implements Auth.RegistrationHandler {
    global User createUser(Id portalId, Auth.UserData data) {
        if (data.attributeMap.containsKey('sfdc_networkid')) {
            Account a = [SELECT Id FROM account WHERE name = 'Community Account'];
            Contact c = new Contact();
            c.accountId = a.Id;
            c.email = data.email;
            c.firstName = data.firstName;
            c.lastName = data.lastName;
            insert(c);

            User u = new User();
            Profile p = [SELECT Id FROM profile WHERE name = 'UFC Community User'];
            u.username = data.firstName + data.lastName + '@ufccommunity.com';
            u.email = data.email;
            u.lastName = data.lastName;
            u.firstName = data.firstName;
            String alias = data.firstName + data.lastName;
            if (alias.length() > 8) {
                alias = alias.substring(0, 8);
            }
            u.alias = alias;
            u.languagelocalekey = UserInfo.getLanguage();
            u.localesidkey = UserInfo.getLocale();
            u.emailEncodingKey = 'UTF-8';
            u.timeZoneSidKey = 'Europe/Berlin';
            u.profileId = p.Id;
            u.contactId = c.Id;
            return u;
        } else {
            User u = new User();
            Profile p = [SELECT Id FROM profile WHERE name = 'Customer Community User'];
            u.username = data.firstName + data.lastName + '@acmecorp.com';
            u.email = data.email;
            u.lastName = data.lastName;
            u.firstName = data.firstName;
            String alias = data.firstName + data.lastName;
            if (alias.length() > 8) {
                alias = alias.substring(0, 8);
            }
            u.alias = alias;
            u.languagelocalekey = UserInfo.getLanguage();
            u.localesidkey = UserInfo.getLocale();
            u.emailEncodingKey = 'UTF-8';
            u.timeZoneSidKey = 'America/Los_Angeles';
            u.profileId = p.Id;
            return u;
        }
    }

    global void updateUser(Id userId, Id portalId, Auth.UserData data) {
        User u = new User(id = userId);
        u.email = data.email;
        u.lastName = data.lastName;
        u.firstName = data.firstName;
        update(u);
    }
}