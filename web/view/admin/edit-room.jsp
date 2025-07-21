<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.Rooms" %>
<jsp:useBean id="room" class="model.Rooms" scope="request" />

<html>
    <head>
        <title>Chỉnh sửa phòng</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    </head>
    <body class="min-h-screen bg-gradient-to-br from-gray-100 via-white to-indigo-100 py-10 px-4">
        <c:if test="${not empty error}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                ${error}
            </div>
        </c:if>
        <div class="max-w-2xl mx-auto bg-white p-8 rounded-2xl shadow-2xl">
            <h1 class="text-3xl font-extrabold text-center text-indigo-700 mb-8">
                ✏️ Chỉnh sửa Phòng #${room.roomId}
            </h1>

            <form method="post" action="${pageContext.request.contextPath}/roomedit" enctype="multipart/form-data" class="space-y-6">
                <input type="hidden" name="roomId" value="${room.roomId}" />

                <!-- Số phòng -->
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Số phòng</label>
                    <input type="text" name="roomNumber" value="${room.roomNumber}"
                           class="w-full border border-gray-300 p-3 rounded-lg focus:ring-2 focus:ring-indigo-400 outline-none" required />
                </div>

                <!-- Loại phòng -->
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Loại phòng</label>
                    <input type="text" name="type" value="${room.type}"
                           class="w-full border border-gray-300 p-3 rounded-lg focus:ring-2 focus:ring-indigo-400 outline-none" required />
                </div>

                <!-- Giá -->
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Giá / đêm (VNĐ)</label>
                    <input type="number" name="price" value="${room.price}"
                           class="w-full border border-gray-300 p-3 rounded-lg focus:ring-2 focus:ring-indigo-400 outline-none" required />
                </div>

                <!-- Trạng thái -->
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Trạng thái</label>
                    <select name="status"
                            class="w-full border border-gray-300 p-3 rounded-lg focus:ring-2 focus:ring-indigo-400 outline-none">
                        <option value="available" ${room.status == 'available' ? 'selected' : ''}>Trống</option>
                        <option value="booked" ${room.status == 'booked' ? 'selected' : ''}>Đã đặt</option>
                        <option value="repaired" ${room.status == 'repaired' ? 'selected' : ''}>Đang sửa chữa</option>
                    </select>
                </div>

                <!-- Ghi chú -->
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Ghi chú</label>
                    <textarea name="note"
                              class="w-full border border-gray-300 p-3 rounded-lg focus:ring-2 focus:ring-indigo-400 outline-none"
                              rows="3">${room.note}</textarea>
                </div>

                <!-- Ảnh hiện tại -->
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Ảnh hiện tại</label>
                    <img id="previewImage"
                         src="${pageContext.request.contextPath}/assets/images/${room.imageUrl}"
                         alt="Ảnh phòng"
                         class="w-full max-h-64 object-cover border rounded-lg shadow mt-2" />
                </div>

                <!-- Ảnh mới -->
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Thay ảnh mới (nếu có)</label>
                    <input type="file" name="imageFile" id="imageFile" accept="image/*"
                           class="block w-full text-sm text-gray-600 border border-gray-300 rounded-lg p-3 bg-white focus:ring-2 focus:ring-indigo-400" />
                </div>

                <!-- Nút -->
                <div class="flex justify-between pt-4">
                    <a href="${pageContext.request.contextPath}/roomadmin"
                       class="px-4 py-2 bg-gray-300 text-gray-700 rounded hover:bg-gray-400 font-semibold">↩️ Quay lại</a>
                    <button type="submit"
                            class="px-6 py-2 bg-indigo-600 text-white rounded hover:bg-indigo-700 font-semibold shadow-md">
                        💾 Lưu thay đổi
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
                        };
                        reader.readAsDataURL(file);
                    }
                });
            });
        </script>
    </body>


</html>
