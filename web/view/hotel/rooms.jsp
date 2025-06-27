<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8"/>
        <title>Tất cả phòng</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body class="bg-gray-900 pt-24 min-h-screen font-sans text-gray-100">

        <div class="max-w-7xl mx-auto px-4">

            <!-- Tiêu đề -->
            <h2 class="text-4xl font-extrabold text-center mb-8 text-indigo-100 tracking-tight">
                🏨 Danh sách tất cả phòng
            </h2>

            <!-- Form tìm kiếm -->
            <form method="get" action="${pageContext.request.contextPath}/searchRoom"
                  class="flex flex-wrap gap-2 justify-center mb-8">

                <input type="text" name="search" placeholder="Từ khóa" value="${keyword}"
                       class="border px-3 py-2 rounded text-black w-52"/>

                <input type="number" name="minPrice" placeholder="Giá từ" value="${minPrice}"
                       class="border px-3 py-2 rounded text-black w-32"/>

                <input type="number" name="maxPrice" placeholder="Đến" value="${maxPrice}"
                       class="border px-3 py-2 rounded text-black w-32"/>

                <select name="status" class="border px-3 py-2 rounded text-black">
                    <option value="">-- Trạng thái --</option>
                     <option value="" ${empty status ? 'selected' : ''}>Tất cả</option>
                    <option value="available" ${status == 'available' ? 'selected' : ''}>Available</option>
                    <option value="booked" ${status == 'booked' ? 'selected' : ''}>Booked</option>
                    <option value="occupied" ${status == 'occupied' ? 'selected' : ''}>Occupied</option>
                </select>

                <select name="type" class="border px-3 py-2 rounded text-black">
                    <option value="">-- Loại phòng --</option>
                    <option value="" ${empty type ? 'selected' : ''}>Tất cả</option>
                    <option value="Standard Garden Room" ${type == 'Standard Garden Room' ? 'selected' : ''}>Standard Garden Room</option>
                    <option value="Deluxe Forest View" ${type == 'Deluxe Forest View' ? 'selected' : ''}>Deluxe Forest View</option>
                    <option value="Ocean Breeze Room" ${type == 'Ocean Breeze Room' ? 'selected' : ''}>Ocean Breeze Room</option>
                    <option value="Beachfront Bungalow" ${type == 'Beachfront Bungalow' ? 'selected' : ''}>Beachfront Bungalow</option>
                    <option value="Treetop Villa" ${type == 'Treetop Villa' ? 'selected' : ''}>Treetop Villa</option>
                    <option value="Presidential Cliff Villa" ${type == 'Presidential Cliff Villa' ? 'selected' : ''}>Presidential Cliff Villa</option>
                </select>

                <select name="sort" class="border px-3 py-2 rounded text-black">
                    <option value="asc" ${sort == 'asc' ? 'selected' : ''}>Giá tăng dần</option>
                    <option value="desc" ${sort == 'desc' ? 'selected' : ''}>Giá giảm dần</option>
                </select>

                <button type="submit" class="bg-blue-600 hover:bg-blue-500 text-white px-4 py-2 rounded">
                    🔍 Tìm kiếm
                </button>
            </form>

            <!-- Thông báo lỗi -->
            <c:if test="${not empty error}">
                <div class="bg-red-900 text-red-200 border border-red-500 px-4 py-3 rounded mb-6 text-center font-medium">
                    ${error}
                </div>
            </c:if>

            <!-- Danh sách phòng -->
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">

                <c:choose>
                    <c:when test="${not empty rooms}">
                        <c:forEach var="room" items="${rooms}">
                            <div class="bg-gray-800 rounded-2xl shadow-xl hover:shadow-2xl transition-transform transform hover:-translate-y-1 duration-300 overflow-hidden flex flex-col">

                                <!-- Ảnh -->
                                <c:if test="${not empty room.imageUrl}">
                                    <img src="${pageContext.request.contextPath}/assets/${room.imageUrl}" alt="Phòng ${room.roomNumber}"
                                         class="h-48 w-full object-cover opacity-90"/>
                                </c:if>

                                <div class="p-5 flex-1 flex flex-col justify-between">
                                    <div>
                                        <h3 class="text-xl font-semibold text-white mb-1">
                                            Phòng ${room.roomNumber} – ${room.type}
                                        </h3>

                                        <p class="text-gray-400 mb-2 text-sm">
                                            <c:out value="${empty room.note ? 'Không có mô tả' : room.note}"/>
                                        </p>

                                        <p class="text-lg font-bold text-red-400 mb-2">
                                            <fmt:formatNumber value="${room.price}" type="number" groupingUsed="true"/> VNĐ/đêm
                                        </p>

                                        <!-- Màu trạng thái -->
                                        <c:set var="isAvailable" value="${fn:toLowerCase(room.status) eq 'available'}"/>
                                        <span class="inline-block text-xs font-semibold px-3 py-1 rounded-full
                                              ${isAvailable ? 'bg-green-900 text-green-300' : 'bg-yellow-900 text-yellow-300'}">
                                            ${room.status}
                                        </span>
                                    </div>

                                    <!-- Đặt ngay nếu là available -->
                                    <c:if test="${isAvailable}">
                                        <form action="${pageContext.request.contextPath}/book" method="post" class="mt-4">
                                            <input type="hidden" name="roomId" value="${room.roomId}"/>
                                            <button type="submit"
                                                    class="w-full bg-green-600 hover:bg-green-500 text-white font-semibold py-2 px-4 rounded-full shadow">
                                                Đặt ngay
                                            </button>
                                        </form>
                                    </c:if>

                                    <c:if test="${not isAvailable}">
                                        <div class="mt-4 text-center text-sm text-gray-400 italic">
                                            Không khả dụng hiện tại
                                        </div>
                                    </c:if>

                                </div>
                            </div>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <p class="text-center text-gray-400 text-lg col-span-3">
                            Không có phòng nào phù hợp.
                        </p>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </body>
</html>
