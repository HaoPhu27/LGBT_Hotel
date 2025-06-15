<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Bookings" %>
<%
    List<Bookings> bookings = (List<Bookings>) request.getAttribute("bookings");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Phòng đã đặt</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 py-8 min-h-screen">

<div class="max-w-4xl mx-auto bg-white p-6 rounded shadow">
    <h2 class="text-2xl font-bold mb-4 text-center">Danh sách phòng bạn đã đặt</h2>

    <% if (bookings != null && !bookings.isEmpty()) { %>
        <table class="table-auto w-full text-left border border-gray-300">
            <thead class="bg-gray-200">
                <tr>
                    <th class="px-4 py-2">Mã đơn</th>
                    <th class="px-4 py-2">Mã phòng</th>
                    <th class="px-4 py-2">Ngày nhận</th>
                    <th class="px-4 py-2">Ngày trả</th>
                    <th class="px-4 py-2">Trạng thái</th>
                    <th class="px-4 py-2">Ngày đặt</th>
                </tr>
            </thead>
            <tbody>
            <% for (Bookings b : bookings) { %>
                <tr class="border-t">
                    <td class="px-4 py-2"><%= b.getBookingId() %></td>
                    <td class="px-4 py-2"><%= b.getRoomId() %></td>
                    <td class="px-4 py-2"><%= b.getCheckIn() %></td>
                    <td class="px-4 py-2"><%= b.getCheckOut() %></td>
                    <td class="px-4 py-2"><span class="text-blue-600 font-medium"><%= b.getStatus() %></span></td>
                    <td class="px-4 py-2"><%= b.getCreatedAt() %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    <% } else { %>
        <p class="text-center text-gray-600">Bạn chưa đặt phòng nào.</p>
    <% } %>
</div>

</body>
</html>
