package model;

import java.util.Date;

public class Invoice {
    private int invoiceId;
    private int appointmentId;
    private double totalAmount;
    private String paymentMethod;
    private Date issuedAt;
    private boolean status;
    private String patientName;

    public Invoice() {}

    public Invoice(int invoiceId, int appointmentId, double totalAmount, String paymentMethod,
                   Date issuedAt, boolean status, String patientName) {
        this.invoiceId = invoiceId;
        this.appointmentId = appointmentId;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.issuedAt = issuedAt;
        this.status = status;
        this.patientName = patientName;
    }

    public int getInvoiceId() { return invoiceId; }
    public int getAppointmentId() { return appointmentId; }
    public double getTotalAmount() { return totalAmount; }
    public String getPaymentMethod() { return paymentMethod; }
    public Date getIssuedAt() { return issuedAt; }
    public boolean isStatus() { return status; }
    public String getPatientName() { return patientName; }

    public void setInvoiceId(int invoiceId) { this.invoiceId = invoiceId; }
    public void setAppointmentId(int appointmentId) { this.appointmentId = appointmentId; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public void setIssuedAt(Date issuedAt) { this.issuedAt = issuedAt; }
    public void setStatus(boolean status) { this.status = status; }
    public void setPatientName(String patientName) { this.patientName = patientName; }
}
