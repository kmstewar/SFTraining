public class CreateAccountContactController {

    public Contact newCon { get; set; }

   public CreateAccountContactController (ApexPages.StandardController con){
      newCon = (Contact)con.getRecord();
   }

   public pagereference save(){
      Account a = New Account(Name = 'Student-' + newCon.FirstName + newCon.LastName,
                                   BillingStreet = newCon.MailingStreet,
                                   BillingCity = newCon.MailingCity,
                                   BillingState = newCon.MailingState,
                                   BillingPostalCode = newCon.MailingPostalCode,
                                   BillingCountry = newCon.MailingCountry
        );
      Insert a;
      newCon.AccountID = a.id;
      insert newCon;

    Pagereference pr = New PageReference('/' + a.id);
      return pr;
   }

}
