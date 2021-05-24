public class Fon_ItemRegistrationWrapper {
    public String api_key;
    public String remote_user_id;
    public String firstname;
    public String lastname;
    public String email ;
    public String remote_product_id;
    public Double amount_paid;
	public boolean send_email;

    public static List<Fon_ItemRegistrationWrapper> parse(String json) {
        return (List<Fon_ItemRegistrationWrapper>) System.JSON.deserialize(json, List<Fon_ItemRegistrationWrapper>.class);
    }
    
}