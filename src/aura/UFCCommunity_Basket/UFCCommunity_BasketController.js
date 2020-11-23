({
    init : function(component, event, helper){
        helper.fetchContactId(component);
        helper.fetchBasketElements(component);
    },
    removeItem: function(component, event, helper) {
        helper.removeItem(component, event);
    },
});