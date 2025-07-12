/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import  java.sql.Timestamp;



/**
 *
 * @author admin
 */
public class Payment {
    private int paymentId;
private int bookingId;
private BigDecimal amount;
private String method;
private Timestamp paidAt;
private String status;
public Payment(int bookingId, BigDecimal amount, String method, Timestamp paidAt, String status) {
    this.bookingId = bookingId;
    this.amount = amount;
    this.method = method;
    this.paidAt = paidAt;
    this.status = status;
}

    public Payment() {
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public void setPaidAt(Timestamp paidAt) {
        this.paidAt = paidAt;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public String getMethod() {
        return method;
    }

    public Timestamp getPaidAt() {
        return paidAt;
    }

    public String getStatus() {
        return status;
    }
}
