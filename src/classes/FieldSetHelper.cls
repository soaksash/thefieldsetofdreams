public with sharing class FieldSetHelper {

	public FieldSetHelper() {
		
	}

	public static List<Schema.FieldSetMember> retrieveFieldSet(String fieldSetName, String ObjectName)
	{
		System.debug('***fieldsetName:'+fieldsetName);
	    Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
	    Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(ObjectName);
	    Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();

	    Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);
		return fieldSetObj.getFields(); 
	}  

	public static List<Schema.FieldSetMember> retrieveFieldSetByProfileAndRecordType(Id recordTypeId)
	{
		FieldsetAssignment__c fieldsetAssignment = FieldsetAssignment__c.getInstance();
		String fieldSetName;
		try
        { 
			 fieldSetName = (String)fieldsetAssignment.get(FieldSetHelper.getFieldsetColumn(recordTypeId));
		}
        catch(Exception ex)
        {
			 fieldSetName = (String)fieldsetAssignment.get('master__c');
        }
        return FieldSetHelper.retrieveFieldSet(fieldSetName, 'Subscription__c');
	}

	public static String getFieldsetColumn(Id recordTypeId)
    {
        try
        { 
            RecordType recordType = [SELECT Id, DeveloperName FROM RecordType WHERE Id = :recordTypeId];
            return recordType.DeveloperName+'__c';
        }
        catch(Exception ex)
        {
            return 'master__c';
        }
    }
}