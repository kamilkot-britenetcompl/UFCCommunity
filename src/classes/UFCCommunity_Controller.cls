public with sharing class UFCCommunity_Controller {
    @AuraEnabled
    public static String getUserId() {
        return UserInfo.getUserId();
//        Id userId = UserInfo.getUserId();
//        return [SELECT IsActive FROM User WHERE Id = :userId].IsActive;
    }

    @AuraEnabled
    public static String getContactId() {
        Id userId = UserInfo.getUserId();
        User myUser = [SELECT ContactId FROM User WHERE Id = :userId limit 1];
        return myUser.ContactId;
    }

    @AuraEnabled
    public static List<Basket_Element__c> getBasketElements() {
        Id userId = getContactId();
        List<Basket_Element__c> basketElements = [Select Id, Product__r.Name, Quantity__c from Basket_Element__c where Contact__c = :userId];
        return basketElements;
    }
}