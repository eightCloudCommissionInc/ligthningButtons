public class Fon_ItemRegistrationResponseWrapper {
   
	public class Error_messages {
		public String registration;
		public String registration_datetime;
		public String product_url;
		public Integer registration_id;
	}
	public String product_url;
	public Integer registration_id;
	public Error_messages error_messages;
    
    public static Fon_ItemRegistrationResponseWrapper parse(String json) {
        return (Fon_ItemRegistrationResponseWrapper) System.JSON.deserialize(json, Fon_ItemRegistrationResponseWrapper.class);
    }
    
}