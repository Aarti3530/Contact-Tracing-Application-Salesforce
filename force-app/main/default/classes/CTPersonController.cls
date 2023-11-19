public class CTPersonController {
    
    //generate unique hash using MD5 algorithm
    public static String getToken(String mobileNo){

        Blob targetBlob = Blob.valueOf(mobileNo);
        Blob hash = Crypto.generateDigest('MD5', targetBlob);

        return EncodingUtil.base64Encode(hash);
    }

    // Get Recent health Change List
    public static List<Person__c> getRecentHealthChanges(){
        return [select Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c 
                FROM Person__c 
                order by Status_Update_Date__c desc NULLS LAST 
                limit 100];

    }

    // Serach People
    public static List<Person__c> searchPeople(String searchItem){
        searchItem = searchItem + '%';
        return [select Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c 
                from Person__c  
                where Name LIKE : searchItem  
                      or Mobile__c LIKE: searchItem 
                      or Token__c LIKE: searchItem 
                order by Status_Update_Date__c desc NULLS LAST];

    }

    // Get Person by its Id
    public static Person__c getPersonById(String personId){
        return [select Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c 
                from Person__c 
                where ID =: personId limit 1];
    }
}