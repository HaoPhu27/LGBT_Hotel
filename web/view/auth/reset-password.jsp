<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>

<%
    Boolean verified = (Boolean) session.getAttribute("otpVerified");
    Integer userId = (Integer) session.getAttribute("resetUserId");

    if (verified == null || !verified || userId == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
    <div class="bg-white p-6 rounded-lg shadow-lg max-w-md w-full">
        <h2 class="text-2xl font-bold text-center mb-4">Đặt lại mật khẩu</h2>
        <p class="text-sm text-gray-600 text-center mb-6">Vui lòng nhập mật khẩu mới của bạn</p>

        <% if (error != null) { %>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-2 rounded text-sm mb-4">
            <%= error %>
        </div>
        <% } %>

        <form id="resetForm" method="post" action="<%= request.getContextPath() %>/reset-password" class="space-y-4">
            <div>
                <label for="password" class="block text-sm font-medium">Mật khẩu</label>
                <input type="password" id="password" name="newPassword" required placeholder="Tạo mật khẩu"
                       class="w-full border rounded px-3 py-2" oninput="validatePassword()" />
                <!-- Hiển thị yêu cầu -->
                <ul id="password-requirements" class="text-sm mt-2 space-y-1 text-gray-700">
                    <li id="lenCheck">❌ Từ 8 đến 14 ký tự</li>
                    <li id="upperCheck">❌ Ít nhất 1 chữ cái viết hoa</li>
                    <li id="numCheck">❌ Ít nhất 1 chữ số</li>
                    <li id="specialCheck">❌ Ít nhất 1 ký tự đặc biệt (!@#$...)</li>
                </ul>
            </div>

            <button type="submit"
                    class="w-full bg-indigo-600 text-white py-2 rounded hover:bg-indigo-700">
                Xác nhận & Đặt lại
            </button>
        </form>
    </div>

    <script>
        function validatePassword() {
            const password = document.getElementById("password").value;

            const lenCheck = document.getElementById("lenCheck");
            const upperCheck = document.getElementById("upperCheck");
            const numCheck = document.getElementById("numCheck");
            const specialCheck = document.getElementById("specialCheck");

            let isValid = true;

            // Độ dài
            if (password.length >= 8 && password.length <= 14) {
                lenCheck.innerHTML = "✅ Từ 8 đến 14 ký tự";
                lenCheck.className = "text-green-600";
            } else {
                lenCheck.innerHTML = "❌ Từ 8 đến 14 ký tự";
                lenCheck.className = "text-red-500";
                isValid = false;
            }

            // Chữ hoa
            if (/[A-Z]/.test(password)) {
                upperCheck.innerHTML = "✅ Ít nhất 1 chữ cái viết hoa";
                upperCheck.className = "text-green-600";
            } else {
                upperCheck.innerHTML = "❌ Ít nhất 1 chữ cái viết hoa";
                upperCheck.className = "text-red-500";
                isValid = false;
            }

            // Số
            if (/\d/.test(password)) {
                numCheck.innerHTML = "✅ Ít nhất 1 chữ số";
                numCheck.className = "text-green-600";
            } else {
                numCheck.innerHTML = "❌ Ít nhất 1 chữ số";
                numCheck.className = "text-red-500";
                isValid = false;
            }

            // Ký tự đặc biệt
            if (/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
                specialCheck.innerHTML = "✅ Ít nhất 1 ký tự đặc biệt";
                specialCheck.className = "text-green-600";
            } else {
                specialCheck.innerHTML = "❌ Ít nhất 1 ký tự đặc biệt";
                specialCheck.className = "text-red-500";
                isValid = false;
            }

            return isValid;
        }

        document.getElementById("resetForm").addEventListener("submit", function (e) {
            if (!validatePassword()) {
                e.preventDefault();
                alert("⚠ Mật khẩu chưa đáp ứng đủ yêu cầu!");
            }
        });
    </script>
</body>
</html>
