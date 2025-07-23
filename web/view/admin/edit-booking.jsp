<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Chỉnh sửa Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-8">
    <div class="max-w-2xl mx-auto bg-white p-6 rounded shadow">
        <h1 class="text-xl font-semibold mb-4">Chỉnh sửa Đặt Phòng #${booking.bookingId}</h1>

        <div class="mb-4">
            <p><strong>Khách hàng:</strong> ${booking.customerName}</p>
            <p><strong>Email:</strong> ${email}</p>
            <p><strong>Phòng:</strong> ${booking.roomNumber}</p>
            <p><strong>Check-in:</strong> <fmt:formatDate value="${booking.checkIn}" pattern="dd/MM/yyyy"/></p>
            <p><strong>Check-out:</strong> <fmt:formatDate value="${booking.checkOut}" pattern="dd/MM/yyyy"/></p>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/bookingedit?id=${b.bookingId}">
            <input type="hidden" name="bookingId" value="${booking.bookingId}" />

            <div class="mb-4">
                <label class="block text-gray-700">Trạng thái đặt phòng</label>
                <select name="bookingStatus" class="border w-full p-2 rounded">
                    <option value="Booked" ${booking.status == 'Booked' ? 'selected' : ''}>Đã đặt</option>
                    <option value="Cancelled" ${booking.status == 'Cancelled' ? 'selected' : ''}>Bị hủy</option>
                </select>
            </div>

            <div class="mb-4">
                <label class="block text-gray-700">Trạng thái thanh toán</label>
                <select name="paymentStatus" class="border w-full p-2 rounded">
                    <option value="paid">Đã thanh toán</option>
                    <option value="unpaid">Chưa thanh toán</option>
                </select>
            </div>

            <h2 class="text-lg font-semibold mt-6 mb-2">Dịch vụ đã chọn</h2>
            <table class="w-full text-sm border">
                <thead class="bg-gray-100">
                    <tr>
                        <th class="p-2 text-left">Tên dịch vụ</th>
                        <th class="p-2 text-right">Giá</th>
                        <th class="p-2 text-center">Số lượng</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${services}">
                        <tr>
                            <td class="p-2">${s.name}</td>
                            <td class="p-2 text-right">
                                <fmt:formatNumber value="${s.price}" type="number" groupingUsed="true"/> VNĐ
                            </td>
                            <td class="p-2 text-center">${s.quantity}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="flex justify-end gap-2 mt-6">
                <a href="${pageContext.request.contextPath}/bookingadmin"
                   class="px-4 py-2 rounded bg-gray-400 text-white">Hủy</a>
                <button type="submit" class="px-4 py-2 rounded bg-blue-500 text-white hover:bg-blue-600">
                    Lưu thay đổi
                </button>
            </div>
        </form>
    </div>
</body>
</html>
