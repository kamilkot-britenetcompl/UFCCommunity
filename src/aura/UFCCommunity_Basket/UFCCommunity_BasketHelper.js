({
    fetchContactId : function(component) {
        const action = component.get('c.getContactId');
        action.setCallback(this, function(response) {
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
        $A.enqueueAction(action);
    },
    fetchBasketElements : function(component) {
        const action = component.get('c.getBasketElements');
        action.setCallback(this, function(response) {
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
        $A.enqueueAction(action);
    },
    removeItem : function(component, event) {
        var ctarget = event.currentTarget;
        var id_str = ctarget.dataset.value;
        console.log(id_str);
        console.log(component.get('v.basketElements')[id_str].Id);
        console.log(component.get('v.basketElements')[id_str].Product__r.Name);
        console.log(component.get('v.basketElements')[id_str].Quantity__c);

        const action = component.get('c.removeBasketElement');
        action.setParams({
            sObjectId: component.get('v.basketElements')[id_str].Id
        });
        action.setCallback(this, function(response) {
            console.log('im in callback');
            const status = response.getState();
            console.log('callbacl response state: ' + response.getState());
            if (status === 'SUCCESS') {
                console.log('im in callback: success');
                console.log('Old Basket Elements: '+ component.get('v.basketElements'));
                let basketElements = component.get('v.basketElements');
                basketElements.remove(id_str);
                component.set('v.basketElements', basketElements);
                console.log('New Basket Elements: '+ component.get('v.basketElements'));
                this.handleShowToast(component, event, 'Error', 'Error', 'Error while processing loading data');
            } else {
                console.log('im in callback: non success');
                this.handleShowToast(component, event, 'Success', 'Success', 'Product deleted from your basket');
                let errors = response.getError();
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    console.error(JSON.stringify(errors[0].message));
                }
            }
        });
        $A.enqueueAction(action);
    },
    handleShowToast: function(component, event, title, variant, message) {
        component.find('notification').showToast({
            "title": title,
            "variant": variant,
            "message": message
        });
    },
});