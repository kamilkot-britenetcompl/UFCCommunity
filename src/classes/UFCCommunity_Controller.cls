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
        List<Basket_Element__c> basketElements = [SELECT Id, Product__r.Name, Quantity__c FROM Basket_Element__c WHERE Contact__c = :userId];
        return basketElements;
    }

    @AuraEnabled
    public static void removeBasketElement (String sObjectId) {
        List<Basket_Element__c> basketElements = [SELECT Id, Product__c FROM Basket_Element__c WHERE Id = :sObjectId];
        delete basketElements;
    }
}