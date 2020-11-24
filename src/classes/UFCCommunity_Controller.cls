public with sharing class UFCCommunity_Controller {

    @AuraEnabled
    public static void addProductToBasket(String productId) {
        Basket_Element__c myBasketElement = new Basket_Element__c(
                Contact__c = getContactId(),
                Product__c = productId,
                Quantity__c = 1
        );
        insert myBasketElement;
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

    @auraEnabled
    public static List<UFCCommunity_ProductViewService.documentContentWrapper> getProductPictures(String productId){
        System.debug('controller');
        return UFCCommunity_ProductViewService.getProductPictures(productId);
    }

}