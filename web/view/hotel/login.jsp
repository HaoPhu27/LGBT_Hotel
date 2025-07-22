<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="model.Users" %>

<%
    
     Users user = (Users) session.getAttribute("user");
    if (user != null) {
        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }

    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Đăng nhập hệ thống</title>
        <!-- Tailwind CDN -->
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    </head>
    <div id="modal-overlay" class="fixed inset-0 bg-black bg-opacity-50 z-40 hidden"></div>

    <!-- Modal -->
    <div id="forgot-modal" class="fixed inset-0 z-50 hidden flex items-center justify-center">
        <div class="bg-white p-6 rounded-lg shadow-lg max-w-md w-full relative">
            <button onclick="closeForgotModal()" class="absolute top-2 right-3 text-gray-500 hover:text-red-500 text-xl">×</button>
            <h2 class="text-xl font-bold mb-4">Khôi phục mật khẩu</h2>
            <form id="forgotForm" method="post">
                <label for="emailForgot" class="block text-sm font-medium text-gray-700 mb-1">Email của bạn</label>
                <input type="email" id="emailForgot" name="email" required placeholder="Nhập email"
                       class="w-full border px-3 py-2 rounded mb-4"/>

                <button type="submit"
                        class="w-full bg-indigo-600 text-white py-2 rounded hover:bg-indigo-700">
                    Gửi email xác nhận
                </button>
                <p id="emailResult" class="mt-3 text-green-600 font-medium hidden"></p>
            </form>
        </div>
    </div>
    <div id="otp-modal" class="fixed inset-0 z-50 hidden flex items-center justify-center">
        <div class="bg-white p-6 rounded-lg shadow-lg max-w-md w-full relative">
            <button onclick="closeOtpModal()" class="absolute top-2 right-3 text-gray-500 hover:text-red-500 text-xl">×</button>
            <h2 class="text-xl font-bold mb-4">Nhập mã xác nhận</h2>
            <form id="otpForm" method="post">
                <label for="otpInput" class="block text-sm font-medium text-gray-700 mb-1">Mã OTP đã gửi đến email</label>
                <input type="text" id="otpInput" name="otp" required maxlength="6" placeholder="Nhập mã 6 số"
                       class="w-full border px-3 py-2 rounded mb-4"/>

                <button type="submit" class="w-full bg-indigo-600 text-white py-2 rounded hover:bg-indigo-700">
                    Xác nhận
                </button>

                <p id="otpResult" class="mt-3 text-green-600 font-medium hidden">✅ OTP hợp lệ!</p>
            </form>
        </div>
    </div>
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
                               class="w-full border rounded px-3 py-2"/>
                    </div>

                    <div>
                        <label class="block mb-1 font-medium" for="password">Mật khẩu</label>
                        <input type="password" id="password" name="password" required
                               placeholder="Nhập mật khẩu"
                               class="w-full border rounded px-3 py-2"/>
                    </div>

                    <div class="text-right mb-2">
                        <button type="button" onclick="openForgotModal()" class="text-sm text-blue-600 hover:underline">
                            Quên mật khẩu?
                        </button>
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
<script>

    function openForgotModal() {
        document.getElementById("modal-overlay").classList.remove("hidden");
        document.getElementById("forgot-modal").classList.remove("hidden");
    }

    function closeForgotModal() {
        document.getElementById("modal-overlay").classList.add("hidden");
        document.getElementById("forgot-modal").classList.add("hidden");
    }
    function openOtpModal() {
        document.getElementById("modal-overlay").classList.remove("hidden");
        document.getElementById("otp-modal").classList.remove("hidden");
    }

    function closeOtpModal() {
        document.getElementById("modal-overlay").classList.add("hidden");
        document.getElementById("otp-modal").classList.add("hidden");
    }

    document.getElementById("forgotForm").addEventListener("submit", function (e) {
        e.preventDefault();

        const email = document.getElementById("emailForgot").value;
        const resultMsg = document.getElementById("emailResult");
        const submitBtn = this.querySelector("button[type='submit']");

        // Hiện trạng thái "Đang gửi mail..."
        submitBtn.textContent = "Đang gửi mail...";
        submitBtn.disabled = true;
        resultMsg.classList.add("hidden");

        fetch("<%= request.getContextPath() %>/forgot-password", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams({email})
        }).then(async response => {
            const data = await response.json();

            if (response.ok && data.success) {
                closeForgotModal();
                openOtpModal();
            } else {
                throw new Error(data.error || "Gửi mail thất bại");
            }
        }).catch(error => {
            resultMsg.classList.remove("hidden");
            resultMsg.classList.replace("text-green-600", "text-red-600");
            resultMsg.textContent = "❌ " + error.message;
            console.error("Lỗi gửi mail:", error);
        }).finally(() => {
            submitBtn.textContent = "Gửi email xác nhận";
            submitBtn.disabled = false;
        });
    });
    document.getElementById("otpForm").addEventListener("submit", function (e) {
        e.preventDefault();
        const otp = document.getElementById("otpInput").value;
        const result = document.getElementById("otpResult");
        fetch("<%= request.getContextPath() %>/verify-otp", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams({otp})
        }).then(async response => {
            const data = await response.json();
            if (response.ok && data.success) {
                result.classList.remove("hidden");
                result.classList.remove("text-red-600");
                result.classList.add("text-green-600");
                result.textContent = "✅ OTP hợp lệ! Đang chuyển hướng...";
                setTimeout(() => {
                    window.location.href = "<%= request.getContextPath() %>/view/auth/reset-password.jsp";
                }, 1500);
            } else {
                result.classList.remove("hidden");
                result.classList.remove("text-green-600");
                result.classList.add("text-red-600");
                result.textContent = "❌ " + (data.error || "Mã OTP không đúng!");
            }
        }).catch(error => {
            result.classList.remove("hidden");
            result.classList.remove("text-green-600");
            result.classList.add("text-red-600");
            result.textContent = "❌ Có lỗi xảy ra khi xác thực OTP!";
            console.error(error);
        });
    });
</script>
