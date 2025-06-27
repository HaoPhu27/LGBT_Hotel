/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author admin
 */
public class Service {
    private int serviceId; // IDENTITY - sẽ được DB tự tăng
    private String name;
    private BigDecimal price;

    public Service() {};

    public Service(String name, BigDecimal price) {
        this.name = name;
        this.price = price;
    }

    // Dùng nếu cần khởi tạo với id (ví dụ khi SELECT từ DB)
    public Service(int serviceId, String name, BigDecimal price) {
        this.serviceId = serviceId;
        this.name = name;
        this.price = price;
    }

    public int getServiceId() {
        return serviceId;
    }

    // ⚠️ KHÔNG GỌI setter NÀY khi INSERT, chỉ dùng khi SELECT
    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Service{" +
                "serviceId=" + serviceId +
                ", name='" + name + '\'' +
                ", price=" + price +
                '}';
    }
}
