<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="model.Customers" %>
<%
    String error = (String) request.getAttribute("error");
    String rememberedEmail = (String) request.getAttribute("rememberedEmail");
    Customers user = (Customers) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập hệ thống</title>
    <!-- Tailwind CDN -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">

<div class="w-full max-w-md">

    <% if (user != null) { %>
        <!-- Nếu đã đăng nhập, hiện lời chào -->
        <div class="bg-white rounded-lg shadow-lg p-6 mb-6">
            <h2 class="text-xl font-semibold text-green-700 mb-2">Xin chào, <%= user.getName() %>!</h2>
            <p class="text-sm text-gray-600 mb-2">Vai trò: <strong><%= user.getRole() %></strong></p>
            <a href="<%= request.getContextPath() %>/logout"
               class="text-blue-600 text-sm underline hover:text-blue-800">Đăng xuất</a>
        </div>
    <% } else { %>
        <!-- Nếu chưa đăng nhập, hiện form -->
        <div class="bg-white rounded-lg shadow-lg p-6">
            <h2 class="text-2xl font-bold text-center mb-1">Đăng nhập hệ thống</h2>
            <p class="text-sm text-gray-500 text-center mb-4">Vui lòng nhập thông tin để đăng nhập</p>

            <form action="<%= request.getContextPath() %>/login" method="post" class="space-y-4">
                <div>
                    <label class="block mb-1 font-medium" for="email">Email</label>
                    <input type="email" id="email" name="email" required
                           placeholder="Nhập địa chỉ email"
                           value="<%= rememberedEmail != null ? rememberedEmail : "" %>"
                           class="w-full border rounded px-3 py-2"/>
                </div>

                <div>
                    <label class="block mb-1 font-medium" for="password">Mật khẩu</label>
                    <input type="password" id="password" name="password" required
                           placeholder="Nhập mật khẩu"
                           class="w-full border rounded px-3 py-2"/>
                </div>

                <div class="flex items-center">
                    <input type="checkbox" id="remember" name="remember"
                           <%= rememberedEmail != null ? "checked" : "" %>
                           class="mr-2"/>
                    <label for="remember" class="text-sm text-gray-700">Ghi nhớ đăng nhập</label>
                </div>

                <% if (error != null) { %>
                    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-2 rounded text-sm">
                        <%= error %>
                    </div>
                <% } %>

                <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700">
                    Đăng nhập
                </button>
            </form>

            <p class="mt-4 text-sm text-center text-gray-600">
                Chưa có tài khoản?
                <a href="<%= request.getContextPath() %>/register" class="text-blue-600 hover:underline">Đăng ký tại đây</a>
            </p>
        </div>
    <% } %>

</div>

</body>
</html>
