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

    // Find Duplicate
    public static List<Location_Tracing__c> checkDuplicate(List<Location_Tracing__c> newlocationTraces){
        //get unique location ids.
        Set<Id> locationIds = new Set<Id>();
        //get unique person ids.
        Set<Id> personIds = new Set<Id>();

        for(Location_Tracing__c trace: newlocationTraces){
            locationIds.add(trace.Location__c);
            personIds.add(trace.Person__c);
        }

        // map of locationids and map of personids
        Map<Id, Set<id>> existinglocationIdPersonIdMap = new Map<Id, Set<Id>>();

        //List of duplicate Records
        List<Location_Tracing__c> dupliateRecord = new List<Location_Tracing__c>();

        // get existing location Tracing record
        List<Location_Tracing__c> existingRecords = [select Id, Person__c, Location__c, Visit_Date__c 
                                     from Location_Tracing__c
                                     where Location__c In: locationIds
                                     and Person__c In: personIds];
        
        if(existingRecords != null && existingRecords.size() > 0){
            for(Location_Tracing__c trace : existingRecords){
                if(!existinglocationIdPersonIdMap.containsKey(trace.Location__c)){
                    existinglocationIdPersonIdMap.put(trace.Location__c,new Set<Id> {});
                }
                existinglocationIdPersonIdMap.get(trace.Location__c).add(trace.Person__c);
            }
        }

        //loop over new lotion tracing records
        for(Location_Tracing__c newRecord: newlocationTraces){
            // check if new record contains location id.
            // if found then check for person id in set
            if(existinglocationIdPersonIdMap != null && existinglocationIdPersonIdMap.containsKey(newRecord.Location__c)
                && existinglocationIdPersonIdMap.get(newRecord.Location__c).contains(newRecord.Person__c)){
                    dupliateRecord.add(newRecord);
                }
        }

        return dupliateRecord;
    }
}