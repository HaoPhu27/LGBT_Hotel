<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String error = (String) request.getAttribute("error");
    String success = request.getParameter("success");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">

<div class="w-full max-w-md">
    <% if ("1".equals(success)) { %>
        <div class="bg-white p-6 rounded-lg shadow-lg text-center">
            <h2 class="text-green-600 text-xl font-bold mb-2">Đăng ký thành công!</h2>
            <p class="text-gray-700">Đang chuyển đến trang đăng nhập...</p>
        </div>
        <script>
            setTimeout(() => {
                window.location.href = "<%=request.getContextPath()%>/login";
            }, 2000);
        </script>
    <% } else { %>
        <div class="bg-white rounded-lg shadow-lg p-6">
            <h2 class="text-2xl font-bold text-center mb-1">Đăng ký tài khoản khách hàng</h2>
            <p class="text-sm text-gray-500 text-center mb-4">Điền thông tin của bạn để tạo tài khoản mới</p>

            <form action="<%=request.getContextPath()%>/register" method="post" class="space-y-4">
                <div>
                    <label class="block mb-1 font-medium" for="name">Họ tên</label>
                    <input type="text" id="name" name="name" required placeholder="Nhập họ tên đầy đủ"
                           class="w-full border rounded px-3 py-2"/>
                </div>

                <div>
                    <label class="block mb-1 font-medium" for="gender">Giới tính</label>
                    <select id="gender" name="gender" class="w-full border rounded px-3 py-2">
                        <option value="Male">Nam</option>
                        <option value="Female">Nữ</option>
                        <option value="Other">Khác</option>
                    </select>
                </div>

                <div>
                    <label class="block mb-1 font-medium" for="phone">Số điện thoại</label>
                    <input type="text" id="phone" name="phone" required placeholder="Nhập số điện thoại"
                           class="w-full border rounded px-3 py-2"/>
                </div>

                <div>
                    <label class="block mb-1 font-medium" for="email">Email</label>
                    <input type="email" id="email" name="email" required placeholder="Nhập địa chỉ email"
                           class="w-full border rounded px-3 py-2"/>
                </div>

                <div>
                    <label class="block mb-1 font-medium" for="address">Địa chỉ</label>
                    <input type="text" id="address" name="address" required placeholder="Nhập địa chỉ"
                           class="w-full border rounded px-3 py-2"/>
                </div>

                <div>
                    <label class="block mb-1 font-medium" for="idNumber">CMND/CCCD</label>
                    <input type="text" id="idNumber" name="idNumber" required placeholder="Nhập số CMND/CCCD"
                           class="w-full border rounded px-3 py-2"/>
                </div>

                <div>
                    <label class="block mb-1 font-medium" for="password">Mật khẩu</label>
                    <input type="password" id="password" name="password" required placeholder="Tạo mật khẩu"
                           class="w-full border rounded px-3 py-2" oninput="validatePassword()" />
                    <!-- Hiển thị yêu cầu -->
                    <ul id="password-requirements" class="text-sm mt-2 space-y-1 text-gray-700">
                        <li id="lenCheck">❌ Từ 8 đến 14 ký tự</li>
                        <li id="upperCheck">❌ Ít nhất 1 chữ cái viết hoa</li>
                        <li id="numCheck">❌ Ít nhất 1 chữ số</li>
                        <li id="specialCheck">❌ Ít nhất 1 ký tự đặc biệt (!@#$...)</li>
                    </ul>
                </div>

                <div>
                    <label class="block mb-1 font-medium" for="confirmPassword">Xác nhận mật khẩu</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required
                           placeholder="Nhập lại mật khẩu"
                           class="w-full border rounded px-3 py-2"/>
                </div>

                <% if (error != null) { %>
                    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-2 rounded text-sm">
                        <%= error %>
                    </div>
                <% } %>

                <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700">
                    Đăng ký
                </button>
            </form>

            <p class="mt-4 text-sm text-center text-gray-600">
                Đã có tài khoản?
                <a href="<%= request.getContextPath() %>/login" class="text-blue-600 hover:underline">Đăng nhập</a>
            </p>
        </div>
    <% } %>
</div>

<!-- JavaScript kiểm tra mật khẩu -->
<script>
function validatePassword() {
    const password = document.getElementById("password").value;

    const lenCheck = document.getElementById("lenCheck");
    const upperCheck = document.getElementById("upperCheck");
    const numCheck = document.getElementById("numCheck");
    const specialCheck = document.getElementById("specialCheck");

    // Độ dài
    if (password.length >= 8 && password.length <= 14) {
        lenCheck.innerHTML = "✅ Từ 8 đến 14 ký tự";
        lenCheck.className = "text-green-600";
    } else {
        lenCheck.innerHTML = "❌ Từ 8 đến 14 ký tự";
        lenCheck.className = "text-red-500";
    }

    // Chữ hoa
    if (/[A-Z]/.test(password)) {
        upperCheck.innerHTML = "✅ Ít nhất 1 chữ cái viết hoa";
        upperCheck.className = "text-green-600";
    } else {
        upperCheck.innerHTML = "❌ Ít nhất 1 chữ cái viết hoa";
        upperCheck.className = "text-red-500";
    }

    // Số
    if (/\d/.test(password)) {
        numCheck.innerHTML = "✅ Ít nhất 1 chữ số";
        numCheck.className = "text-green-600";
    } else {
        numCheck.innerHTML = "❌ Ít nhất 1 chữ số";
        numCheck.className = "text-red-500";
    }

    // Ký tự đặc biệt
    if (/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
        specialCheck.innerHTML = "✅ Ít nhất 1 ký tự đặc biệt";
        specialCheck.className = "text-green-600";
    } else {
        specialCheck.innerHTML = "❌ Ít nhất 1 ký tự đặc biệt";
        specialCheck.className = "text-red-500";
    }
}
</script>

</body>
</html>
