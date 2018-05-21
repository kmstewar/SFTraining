Public class AutoConvertLeads
{
    @InvocableMethod
    public static void LeadAssign(List<Lead> LeadList)
    {
        List<String> LeadAcc = new List<String>();
        for(Lead L : LeadList){
            LeadAcc.add(L.Company);
        }
        list<Account> AccList = [SELECT ID, Name FROM Account WHERE Name IN :LeadAcc];
        LeadStatus CLeadStatus= [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true Limit 1];
        List<Database.LeadConvert> MassLeadconvert = new List<Database.LeadConvert>();
        for(Lead L : LeadList){
            Database.LeadConvert Leadconvert = new Database.LeadConvert();
            for(Account A : AccList){
                if(L.Company == A.Name){
                    Leadconvert.setAccountId(A.Id);
                    Leadconvert.setDoNotCreateOpportunity(TRUE);
                }else{
                    Leadconvert.setDoNotCreateOpportunity(FALSE);
                }
            }
            Leadconvert.setLeadId(L.Id);                
            Leadconvert.setConvertedStatus(CLeadStatus.MasterLabel);
            MassLeadconvert.add(Leadconvert);
        }
        
        if (!MassLeadconvert.isEmpty()) {
            List<Database.LeadConvertResult> lcr = Database.convertLead(MassLeadconvert);
        }
    }
}