<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Rooms" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    List<?> rooms = (List<?>) request.getAttribute("rooms");
    int totalRooms = (rooms != null) ? rooms.size() : 0;
    long bookedRooms = 0;
    if (rooms != null) {
        bookedRooms = rooms.stream()
            .filter(r -> "booked".equals(((Rooms) r).getStatus()))
            .count();
    }
    long repairRooms = 0;
     if (rooms != null) {
        repairRooms = rooms.stream()
            .filter(r -> "repaired".equals(((Rooms) r).getStatus()))
            .count();
    }
    int emptyRooms = totalRooms - (int) bookedRooms - (int)repairRooms;
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>

    <!-- Tailwind CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">

    <!-- FontAwesome CDN -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        .card-hover:hover {
            transform: scale(1.02);
            transition: all 0.2s ease-in-out;
        }
    </style>
</head>
<body class="bg-gray-100 flex">
 <jsp:include page="sidebar.jsp" />
 <main  class="flex-1 ml-64 p-6">
<section id="dashboard-section" class="content-section">
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-3xl font-bold text-gray-800">
            <i class="fas fa-tachometer-alt mr-3"></i>Dashboard
        </h1>
        <div class="text-gray-600">
            <i class="fas fa-calendar mr-2"></i>
            <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy HH:mm"/>
        </div>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <div class="bg-gradient-to-r from-blue-500 to-blue-600 text-white p-6 rounded-xl shadow-lg card-hover">
            <div class="flex justify-between">
                <div>
                    <p class="text-blue-100 text-sm">Tổng Phòng</p>
                    <p class="text-3xl font-bold"><%= totalRooms %></p>
                </div>
                <i class="fas fa-bed text-3xl text-blue-200"></i>
            </div>
        </div>

        <div class="bg-gradient-to-r from-indigo-500 to-indigo-600 text-white p-6 rounded-xl shadow-lg card-hover">
            <div class="flex justify-between">
                <div>
                    <p class="text-indigo-100 text-sm">Phòng Đã Đặt</p>
                    <p class="text-3xl font-bold"><%= bookedRooms %></p>
                </div>
                <i class="fas fa-door-closed text-3xl text-indigo-200"></i>
            </div>
        </div>

        <div class="bg-gradient-to-r from-green-500 to-green-600 text-white p-6 rounded-xl shadow-lg card-hover">
            <div class="flex justify-between">
                <div>
                    <p class="text-green-100 text-sm">Phòng Trống</p>
                    <p class="text-3xl font-bold"><%= emptyRooms %></p>
                </div>
                <i class="fas fa-door-open text-3xl text-green-200"></i>
            </div>
        </div>

        <div class="bg-gradient-to-r from-pink-500 to-pink-600 text-white p-6 rounded-xl shadow-lg card-hover">
            <div class="flex justify-between">
                <div>
                    <p class="text-pink-100 text-sm">Doanh Thu</p>
                    <p class="text-2xl font-bold">
                        <fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true"/> VNĐ
                    </p>
                </div>
                <i class="fas fa-dollar-sign text-3xl text-pink-200"></i>
            </div>
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <div class="bg-white p-6 rounded-xl shadow-lg">
            <h3 class="text-lg font-semibold mb-4">
                <i class="fas fa-chart-pie mr-2 text-blue-500"></i>Tỷ lệ Phòng
            </h3>
            <canvas id="roomChart"></canvas>
        </div>
        <div class="bg-white p-6 rounded-xl shadow-lg">
            <h3 class="text-lg font-semibold mb-4">
                <i class="fas fa-chart-line mr-2 text-green-500"></i>Doanh Thu Theo Tháng
            </h3>
            <canvas id="revenueChart"></canvas>
        </div>
    </div>
</section>
</main>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        new Chart(document.getElementById('roomChart'), {
            type: 'doughnut',
            data: {
                labels: ['Đã Đặt', 'Trống', 'Đang sửa chữa'],
                datasets: [{
                    data: [<%= bookedRooms %>, <%= emptyRooms %>,<%= repairRooms %>],
                    backgroundColor: ['#ef4444', '#10b981','#46A5DC'],
                    borderWidth: 0
                }]
            },
            options: {
                plugins: { legend: { position: 'bottom' } },
                responsive: true
            }
        });

        new Chart(document.getElementById('revenueChart'), {
            type: 'line',
            data: {
                labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6'],
                datasets: [{
                    label: 'Doanh Thu (triệu)',
                    data: [12, 15, 8, 20, 18, 15.6],
                    borderColor: '#3b82f6',
                    backgroundColor: 'rgba(59,130,246,.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                scales: { y: { beginAtZero: true } },
                responsive: true
            }
        });
    });
</script>

</body>
</html>
