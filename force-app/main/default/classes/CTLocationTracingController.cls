public class CTLocationTracingController {

    // Get visitor details based on locationId
    public static List<Location_Tracing__c> getVisitors(String locationId){
        return [select Id, Person__c, Location__c, Visit_Date__c, Person__r.Name, Person__r.Health_Status__c, Person__r.Token__c                
                from Location_Tracing__c
                where Id =: locationId order by Visit_Date__c desc];
    }


    // Get location details based on personI where person visited in last 10 days
    public static List<Location_Tracing__c> getLocationsByPersonIds(Set<Id> personIds){
        return [select Id, Person__c, Location__c, Visit_Date__c              
                from Location_Tracing__c
                where Person__c In : personIds
                      and Visit_Date__c = LAST_N_DAYS:10];
    }

    // Get location details by location id where health status is green and visite date in past 10 days
    public static List<Location_Tracing__c> getLocationsByLocationIds(Set<Id> locationIds){
        return [select Id, Person__c, Location__c, Visit_Date__c 
                from Location_Tracing__c
                where Location__c =: locationIds
                      and Person__r.Health_Status__c = 'Green'
                      and Visit_Date__c = LAST_N_DAYS:10];
    }
}