<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Users" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen pt-24">
    <%@ include file="header.jsp" %>

    <div class="max-w-2xl mx-auto bg-white rounded-xl shadow-md p-6">
        <h1 class="text-2xl font-bold mb-6">Thông tin cá nhân</h1>

        <!-- Hiển thị thông tin -->
        <ul class="space-y-2 text-gray-800 mb-6">
            <li><strong>Họ tên:</strong> <%= user.getName() %></li>
            <li><strong>Giới tính:</strong> <%= user.getGender() %></li>
            <li><strong>Số điện thoại:</strong> <%= user.getPhone() %></li>
            <li><strong>Email:</strong> <%= user.getEmail() %></li>
            <li><strong>Địa chỉ:</strong> <%= user.getAddress() %></li>
        </ul>

        <!-- Nút bấm để mở form chỉnh sửa -->
        <div class="mb-4">
            <button onclick="toggleEditForm()"
                    class="bg-yellow-500 text-white px-4 py-2 rounded-full hover:bg-yellow-600 transition">
                Chỉnh sửa
            </button>
        </div>

        <!-- Form chỉnh sửa (ẩn mặc định) -->
        <form id="editForm" action="<%= request.getContextPath() %>/edit-profile" method="post"
              class="space-y-4 hidden">
            <div>
                <label for="phone" class="block text-sm font-medium text-gray-700">Số điện thoại mới</label>
                <input type="text" id="phone" name="phone" value="<%= user.getPhone() %>"
                       class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring focus:ring-indigo-200">
            </div>
            <div>
                <label for="address" class="block text-sm font-medium text-gray-700">Địa chỉ mới</label>
                <input type="text" id="address" name="address" value="<%= user.getAddress() %>"
                       class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring focus:ring-indigo-200">
            </div>
            <button type="submit" class="bg-indigo-600 text-white px-6 py-2 rounded-full hover:bg-indigo-700">
                Cập nhật
            </button>
        </form>

        <div class="mt-6">
            <a href="<%= request.getContextPath() %>/home" class="text-blue-600 hover:underline">← Quay lại trang chủ</a>
        </div>
    </div>

    <script>
        function toggleEditForm() {
            const form = document.getElementById("editForm");
            form.classList.toggle("hidden");
        }
    </script>
</body>
</html>
