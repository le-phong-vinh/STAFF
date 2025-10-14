package model;

public class InvoiceDetail {

    private String type;   // "service" | "medicine"
    private String name;
    private int quantity;
    private double price;   // chỉ dùng cho dịch vụ, thuốc mặc định = 0
    private String dosage;   // chỉ dùng cho thuốc
    private String duration; // chỉ dùng cho thuốc

    // Constructor cho dịch vụ
    public InvoiceDetail(String type, String name, int quantity, double price) {
        this.type = type;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
    }

    // Constructor cho thuốc
    public InvoiceDetail(String type, String name, int quantity, double price, String dosage, String duration) {
        this.type = type;
        this.name = name;
        this.quantity = quantity;
        this.price = price; // truyền = 0 khi là thuốc
        this.dosage = dosage;
        this.duration = duration;
    }

    // Getter - Setter
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDosage() {
        return dosage;
    }

    public void setDosage(String dosage) {
        this.dosage = dosage;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }
}
