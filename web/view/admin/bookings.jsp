<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.Bookings" %>
<%@ page import="java.util.List" %>

<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<body class="flex min-h-screen bg-gray-100">
    <jsp:include page="sidebar.jsp" />
    <main class="flex-1 ml-64">
        <section class="p-6">
            <div class="flex justify-between items-center mb-6">
                <h1 class="text-3xl font-bold text-gray-800 flex items-center">
                    <i class="fas fa-calendar-check mr-3 text-green-500"></i>Danh sách Đặt Phòng
                </h1>
            </div>
            <c:if test="${not empty bookings}">
                <div class="overflow-x-auto bg-white rounded shadow">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-200 text-gray-700 text-sm">
                            <tr>
                                <th class="px-4 py-3 text-left">ID</th>
                                <th class="px-4 py-3 text-left">Khách</th>
                                <th class="px-4 py-3 text-left">Phòng</th>
                                <th class="px-4 py-3 text-left">Nhận</th>
                                <th class="px-4 py-3 text-left">Trả</th>
                                <th class="px-4 py-3 text-left">Ngày đặt</th>
                                <th class="px-4 py-3 text-left">Trạng thái</th>
                                <th class="px-4 py-3 text-left">Thanh toán</th>
                                <th class="px-4 py-3 text-right">Tổng tiền</th>
                                <th class="px-4 py-3 text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-100 text-sm">
                            <c:forEach var="b" items="${bookings}">
                                <tr>
                                    <td class="px-4 py-3">${b.bookingId}</td>
                                    <td class="px-4 py-3">${b.customerName}</td>
                                    <td class="px-4 py-3">${b.roomNumber}</td>
                                    <td class="px-4 py-3"><fmt:formatDate value="${b.checkIn}" pattern="dd/MM/yyyy"/></td>
                                    <td class="px-4 py-3"><fmt:formatDate value="${b.checkOut}" pattern="dd/MM/yyyy"/></td>
                                    <td class="px-4 py-3"><fmt:formatDate value="${b.createdAt}" pattern="dd/MM/yyyy"/></td>
                                    <td class="px-4 py-3">
                                        <span class="px-2 py-1 rounded-full text-xs font-medium
                                            <c:choose>
                                                <c:when test="${b.status == 'Booked'}">bg-yellow-200 text-yellow-800</c:when>
                                                <c:when test="${b.status == 'Cancelled'}">bg-red-200 text-red-800</c:when>
                                                <c:otherwise>bg-green-200 text-green-800</c:otherwise>
                                            </c:choose>">
                                            ${b.status}
                                        </span>
                                    </td>
                                    <td class="px-4 py-3">
                                        <span class="px-2 py-1 rounded-full text-xs font-medium
                                            <c:choose>
                                                <c:when test="${b.paymentStatus == 'paid'}">bg-green-100 text-green-800</c:when>
                                                <c:otherwise>bg-red-100 text-red-700</c:otherwise>
                                            </c:choose>">
                                            ${b.paymentStatus}
                                        </span>
                                    </td>
                                    <td class="px-4 py-3 text-right">
                                        <fmt:formatNumber value="${b.totalAmount}" type="number" groupingUsed="true"/> VNĐ
                                    </td>
                                    <td class="px-4 py-3 text-center">
                                        <a href="${pageContext.request.contextPath}/bookingedit?id=${b.bookingId}"
                                           class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1 rounded text-sm inline-block">
                                            Chỉnh sửa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <c:if test="${empty bookings}">
                <div class="text-center text-gray-500 mt-8">Không có đơn đặt phòng nào.</div>
            </c:if>
        </section>
    </main>
</body>
