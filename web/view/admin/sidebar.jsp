<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .gradient-bg {
        background: linear-gradient(to bottom right, #3f51b5, #5c6bc0);
    }

    .sidebar-link {
        display: flex;
        align-items: center;
        padding: 12px 16px;
        margin-bottom: 10px;
        color: white;
        text-decoration: none;
        border-radius: 8px;
        transition: background 0.3s ease;
    }

    .sidebar-link:hover {
        background-color: rgba(255, 255, 255, 0.2);
    }

    .sidebar-link i {
        margin-right: 10px;
        font-size: 16px;
    }

    .sidebar-link.active {
        background-color: rgba(255, 255, 255, 0.3);
        font-weight: bold;
    }

    .sidebar-logout {
     
        left: 24px;
        right: 24px;
    }

    .sidebar-logout a {
        display: flex;
        align-items: center;
        padding: 12px 16px;
        color: white;
        text-decoration: none;
        border-radius: 8px;
        transition: background 0.3s ease;
    }

    .sidebar-logout a:hover {
        background-color: rgba(255, 255, 255, 0.2);
    }

    .sidebar-logout i {
        margin-right: 10px;
    }
</style>

<aside class="w-64 gradient-bg text-white fixed top-0 left-0 h-full z-50 shadow-lg">

    <div class="p-6">
        <div class="text-center mb-8">
            <i class="fas fa-hotel text-4xl mb-3"></i>
            <h2 class="text-xl font-bold">Hotel&nbsp;Admin</h2>
            <p class="text-sm opacity-90 mt-1">Xin chào, <c:out value="${username}"/></p>
        </div>

        <nav>
            <a href="${pageContext.request.contextPath}/DashboardController" class="sidebar-link">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/roomadmin" class="sidebar-link">
                <i class="fas fa-bed"></i> Quản lý Phòng
            </a>
            <a href="${pageContext.request.contextPath}/bookingadmin" class="sidebar-link">
                <i class="fas fa-calendar-check"></i> Đặt Phòng
            </a>
            <a href="${pageContext.request.contextPath}/revenue" class="sidebar-link">
                <i class="fas fa-chart-line"></i> Doanh Thu
            </a>
        </nav>

        <div class="sidebar-logout">
            <a href="${pageContext.request.contextPath}/logout">
                <i class="fas fa-sign-out-alt"></i> Đăng Xuất
            </a>
        </div>
    </div>
</aside>
