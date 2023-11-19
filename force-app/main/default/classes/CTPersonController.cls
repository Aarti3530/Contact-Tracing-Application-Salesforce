public class CTPersonController {
    
    //generate unique hash using MD5 algorithm
    public static String getToken(String mobileNo){

        Blob targetBlob = Blob.valueOf(mobileNo);
        Blob hash = Crypto.generateDigest('MD5', targetBlob);

        return EncodingUtil.base64Encode(hash);
    }

    // Get Recent health Change List
    public static List<Person__c> getRecentHealthChanges(){
        return [select Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c 
                FROM Person__c 
                order by Status_Update_Date__c desc NULLS LAST 
                limit 100];

    }

    // Serach People
    public static List<Person__c> searchPeople(String serchItem){
        return [select Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c 
                from Person__c  
                where Name =: serchItem  
                      or Mobile__c =: serchItem 
                      or Token__c =: serchItem 
                order by Status_Update_Date__c desc NULLS LAST];

    }

    // Get Person
    public static Person__c getPersonById(String personId){
        List<Person__c> person = [select Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c 
                from Person__c 
                where Id =: personId];
        
        if(person != null && person.size() > 0)
           return person[0];
        
        return null;
    }
}