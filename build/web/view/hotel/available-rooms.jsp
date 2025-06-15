<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Rooms" %>
<%
    List<Rooms> rooms = (List<Rooms>) request.getAttribute("rooms");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách phòng trống</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 py-8 min-h-screen">

<div class="max-w-5xl mx-auto px-4">
    <h2 class="text-3xl font-bold text-center mb-6">Danh sách phòng còn trống</h2>

    <% if (error != null) { %>
        <div class="bg-red-100 text-red-700 border border-red-400 px-4 py-2 rounded mb-4">
            <%= error %>
        </div>
    <% } %>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <% if (rooms != null && !rooms.isEmpty()) {
            for (Rooms room : rooms) { %>
            <div class="bg-white rounded-lg shadow p-4 flex flex-col md:flex-row">
                <% if (room.getImageUrl() != null && !room.getImageUrl().isEmpty()) { %>
                    <img src="<%= room.getImageUrl() %>" alt="Hình phòng" class="w-full md:w-48 h-32 object-cover rounded mr-4 mb-4 md:mb-0">
                <% } %>
                <div class="flex-1">
                    <h3 class="text-xl font-semibold mb-1">Phòng <%= room.getRoomNumber() %> - <%= room.getType() %></h3>
                    <p class="text-gray-700 mb-1">Giá: <strong><%= room.getPrice() %> VND</strong></p>
                    <p class="text-sm text-gray-600 mb-2"><%= room.getNote() != null ? room.getNote() : "Không có mô tả" %></p>
                    <form action="<%= request.getContextPath() %>/book" method="post">
                        <input type="hidden" name="roomId" value="<%= room.getRoomId() %>"/>
                        <button type="submit"
                                class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
                            Đặt ngay
                        </button>
                    </form>
                </div>
            </div>
        <% }
        } else { %>
            <p class="text-center text-gray-600 col-span-2">Hiện không có phòng trống nào.</p>
        <% } %>
    </div>
</div>

</body>
</html>
