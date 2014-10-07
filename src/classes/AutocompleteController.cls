public with sharing class AutocompleteController {
	
	private List<Sobject> content;

	public AutocompleteController() {
		String term = ApexPages.currentPage().getParameters().get('term');

		content = Database.query('SELECT Name FROM Countries__c WHERE Name like \'%'+term+'%\'');

	}

	public String getJSONContent()
    {
        String jsonString = '';
        Jsongenerator gen = JSON.createGenerator(true);
        
        if(content.size() > 0)
        {
            gen.writeStartArray();
            for(Sobject item: content)
            {
                gen.writeStartObject();
                //gen.writeStringField('code', product.Name);
                //gen.writeStringField('description',product.Product_Description__c);
                gen.writeStringField('label', (String)item.get('Name'));
                gen.writeStringField('value', (String)item.get('Name'));
                
                gen.writeEndObject();
            }
            gen.writeEndArray();
            jsonString = gen.getAsString();
        }
        
        return jsonString;
    }
}