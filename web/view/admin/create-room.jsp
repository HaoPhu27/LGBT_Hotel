<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <title>Tạo phòng mới</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    </head>
    <body class="min-h-screen bg-gradient-to-br from-gray-100 via-white to-indigo-100 py-10 px-4">
        <div class="max-w-2xl mx-auto bg-white p-8 rounded-2xl shadow-2xl">
            <c:if test="${not empty error}">
                <div class="bg-red-100 text-red-700 p-3 rounded mb-4 font-semibold">${error}</div>
            </c:if>
            <h1 class="text-3xl font-extrabold text-center text-indigo-700 mb-8">➕ Tạo Phòng Mới</h1>

            <form method="post" action="${pageContext.request.contextPath}/createroom" enctype="multipart/form-data" class="space-y-6">

                <!-- Số phòng -->
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Số phòng</label>
                    <input type="text" name="roomNumber"
                           class="w-full border border-gray-300 p-3 rounded-lg focus:ring-2 focus:ring-indigo-400 outline-none" required />
                </div>

                <!-- Loại phòng -->
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Loại phòng</label>
                    <input type="text" name="type"
                           class="w-full border border-gray-300 p-3 rounded-lg focus:ring-2 focus:ring-indigo-400 outline-none" required />
                </div>

                <!-- Giá -->
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Giá / đêm (VNĐ)</label>
                    <input type="number" name="price"
                           class="w-full border border-gray-300 p-3 rounded-lg focus:ring-2 focus:ring-indigo-400 outline-none" required />
                </div>

                <!-- Trạng thái -->
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Trạng thái</label>
                    <select name="status"
                            class="w-full border border-gray-300 p-3 rounded-lg focus:ring-2 focus:ring-indigo-400 outline-none">
                        <option value="available">Trống</option>
                        <option value="booked">Đã đặt</option>
                        <option value="repaired">Đang sửa chữa</option>
                    </select>
                </div>

                <!-- Ghi chú -->
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Ghi chú</label>
                    <textarea name="note"
                              class="w-full border border-gray-300 p-3 rounded-lg focus:ring-2 focus:ring-indigo-400 outline-none"
                              rows="3"></textarea>
                </div>

                <!-- Ảnh -->
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Ảnh phòng</label>
                    <input type="file" name="imageFile" id="imageFile" accept="image/*"
                           class="block w-full text-sm text-gray-600 border border-gray-300 rounded-lg p-3 bg-white focus:ring-2 focus:ring-indigo-400" />
                    <img id="previewImage" class="mt-4 max-h-64 rounded-lg shadow border hidden" />
                </div>

                <!-- Nút -->
                <div class="flex justify-between pt-4">
                    <a href="${pageContext.request.contextPath}/roomadmin"
                       class="px-4 py-2 bg-gray-300 text-gray-700 rounded hover:bg-gray-400 font-semibold">↩️ Quay lại</a>
                    <button type="submit"
                            class="px-6 py-2 bg-indigo-600 text-white rounded hover:bg-indigo-700 font-semibold shadow-md">
                        ✅ Tạo phòng
                    </button>
                </div>
            </form>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const input = document.getElementById("imageFile");
                const img = document.getElementById("previewImage");

                input.addEventListener("change", function (event) {
                    const file = event.target.files[0];
                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function () {
                            img.src = reader.result;
                            img.classList.remove("hidden");
                        };
                        reader.readAsDataURL(file);
                    }
                });
            });
        </script>
    </body>
</html>
