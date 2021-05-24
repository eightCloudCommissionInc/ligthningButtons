public class SO_JSON2Apex {
    public class TransactionProducts {
        public String sku;
        public String name;
        public String category;
        public Double price;
        public Integer quantity;
    }

    public String transactionId;
    public String productUrl;
    public String transactionAffiliation;
    public Double transactionTotal;
    public Double transactionTax;
    public Integer transactionShipping;
    public List<TransactionProducts> transactionProducts;

    
    public static SO_JSON2Apex parse(String json) {
        return (SO_JSON2Apex) System.JSON.deserialize(json, SO_JSON2Apex.class);
    }
}