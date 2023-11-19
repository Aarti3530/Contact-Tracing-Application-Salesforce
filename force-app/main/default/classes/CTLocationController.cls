public class CTLocationController {

    // Get Recent health Change List
    public static List<Location__c> getRecentStatusChanges(){
        return [select Id, Name, Address__c, Pincode__c, Red_Score__c, Status__c, Status_Update_Date__c 
                from Location__c 
                order by Status_Update_Date__c desc Nulls last 
                limit 100];

    }

    // Serach Location
    public static List<Location__c> searchLocation(String serchItem){
        return [select Id, Name, Address__c, Pincode__c, Red_Score__c, Status__c, Status_Update_Date__c 
                from Location__c  
                where Name =: serchItem  
                      or Address__c =: serchItem 
                      or Pincode__c =: serchItem 
                order by Status_Update_Date__c desc NULLS LAST];

    }

    // Get Location By ID 
    public static Location__c getLocationById(String locationId){
        List<Location__c> location = [select Id, Name, Address__c, Pincode__c, Red_Score__c, Status__c, Status_Update_Date__c 
                from Location__c 
                where ID =: locationId];

        if(location != null && location.size() > 0)
          return location[0];

        return null;
    }

}