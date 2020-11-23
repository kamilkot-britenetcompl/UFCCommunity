({
    init : function(component, event, helper){
        component.set('v.userId','hardcoded');
        const action = component.get('c.getUserId');
        action.setCallback(this, function(response) {
            const status = response.getState();
            if (status === 'SUCCESS') {
                component.set('v.userId', response.getReturnValue());
            } else {
                this.handleShowToast(component, event, 'Error', 'error', 'Error while processing loading data');
                let errors = response.getError();
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    console.error(JSON.stringify(errors[0].message));
                }
            }
        });
        $A.enqueueAction(action);

        component.set('v.contactId','hardcoded');
        const action2 = component.get('c.getContactId');
        action2.setCallback(this, function(response) {
            const status = response.getState();
            if (status === 'SUCCESS') {
                component.set('v.contactId', response.getReturnValue());
            } else {
                this.handleShowToast(component, event, 'Error', 'error', 'Error while processing loading data');
                let errors = response.getError();
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    console.error(JSON.stringify(errors[0].message));
                }
            }
        });
        $A.enqueueAction(action2);

        const action3 = component.get('c.getBasketElements');
        action3.setCallback(this, function(response) {
            const status = response.getState();
            if (status === 'SUCCESS') {
                component.set('v.basketElements', response.getReturnValue());
                console.log('Basket Elements: '+ component.get('v.basketElements'));
            } else {
                this.handleShowToast(component, event, 'Error', 'error', 'Error while processing loading data');
                let errors = response.getError();
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    console.error(JSON.stringify(errors[0].message));
                }
            }
        });
        $A.enqueueAction(action3);
    },
    removeItem: function(component, event, helper) {
        var ctarget = event.currentTarget;
        var id_str = ctarget.dataset.value;
        console.log(id_str);
        console.log(component.get('v.basketElements')[id_str].Id);
        console.log(component.get('v.basketElements')[id_str].Product__r.Name);
        console.log(component.get('v.basketElements')[id_str].Quantity__c);
    }
});