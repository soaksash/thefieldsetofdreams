public with sharing class NewSubscription_Live_Extension {
	public Subscription__c mySubscription {get;set;}
    private String fieldset;
    private Id recordTypeId;
    private String recordTypeName;
    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public NewSubscription_Live_Extension(ApexPages.StandardController stdController) {
        this.mySubscription = (Subscription__c)stdController.getRecord();
        recordTypeId = mySubscription.RecordTypeId;
    }

    public List<Schema.FieldSetMember> getSubscriptionFieldSet()
    {
        return FieldSetHelper.retrieveFieldSetByProfileAndRecordType(recordTypeId);
    }
}