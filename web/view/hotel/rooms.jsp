<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://cdn.tailwindcss.com"></script>
<script>
    const bookedDatesByRoom = {
    <c:forEach var="entry" items="${roomBookedDatesMap}">
        ${entry.key}: [<c:forEach var="date" items="${entry.value}" varStatus="loop">
    '${date}'<c:if test="${!loop.last}">,</c:if>
        </c:forEach>],
    </c:forEach>
    };</script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8"/>
        <title>Tất cả phòng</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@ include file="header.jsp" %>
    </head>

    <body class="bg-gray-900 pt-24 min-h-screen font-sans text-gray-100">

        <div class="max-w-7xl mx-auto px-4 my-3">

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
                                        <button type="button"
                                                class="mt-4 w-full bg-green-600 hover:bg-green-500 text-white font-semibold py-2 px-4 rounded-full shadow"
                                                onclick="checkLoginBeforeBooking(${room.roomId}, '${room.type}', ${room.price})">
                                            Đặt ngay
                                        </button>
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
        <%@ include file="footer.jsp" %>
        <div id="bookingModal"
             class="fixed inset-0 bg-black bg-opacity-60 hidden z-50 flex items-center justify-center">

            <div class="bg-white rounded-2xl shadow-2xl p-6 w-full max-w-xl text-black relative">

                <!-- Close button -->
                <button type="button" onclick="closeBookingModal()"
                        class="absolute top-3 right-4 text-gray-500 hover:text-gray-800 text-xl font-bold">
                    ×
                </button>

                <!-- Tiêu đề -->
                <h3 class="text-2xl font-bold mb-6 text-center text-indigo-700">
                    Đặt phòng <span id="modalRoomType"></span>
                </h3>

                <!-- Form -->
                <form action="${pageContext.request.contextPath}/book" method="post" class="space-y-4">

                    <input type="hidden" name="roomId" id="modalRoomId"/>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Từ ngày:</label>
                        <input type="date" name="checkIn" id="checkInDate" required class="border border-gray-300 px-3 py-2 rounded w-full"/>
                    </div>



                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Đến ngày:</label>
                        <input type="date" name="checkOut" id="checkOutDate" required class="border border-gray-300 px-3 py-2 rounded w-full"/>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Chọn dịch vụ kèm theo:</label>
                        <div class="space-y-2 max-h-40 overflow-y-auto pr-2">
                            <c:forEach var="svc" items="${services}">
                                <div class="flex items-center">
                                    <input type="checkbox"
                                           name="serviceIds"
                                           value="${svc.serviceId}"
                                           class="mr-2 service-checkbox"
                                           data-price="${svc.price}"/>
                                    <label class="text-gray-700 text-sm">
                                        ${svc.name} (+<fmt:formatNumber value="${svc.price}" type="number" groupingUsed="true"/> VNĐ)
                                    </label>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Tình trạng thanh toán:</label>
                        <div class="flex gap-6">
                            <label class="text-sm text-gray-700">
                                <input type="radio" name="paymentStatus" value="paid" required class="mr-2"/>
                                Đã thanh toán
                            </label>
                            <label class="text-sm text-gray-700">
                                <input type="radio" name="paymentStatus" value="unpaid" required class="mr-2"/>
                                Chưa thanh toán
                            </label>
                        </div>
                    </div>

                    <!-- Giá -->
                    <div class="bg-gray-100 p-4 rounded-lg">
                        <p class="text-sm text-gray-600">Giá gốc: <span id="basePrice" class="font-medium text-gray-800"></span> VNĐ/đêm</p>
                        <p class="text-lg font-semibold text-indigo-700 mt-1">Tổng giá: <span id="totalPrice"></span> VNĐ</p>
                    </div>

                    <!-- Nút -->
                    <div class="flex justify-end gap-3 pt-4">
                        <button type="button" onclick="closeBookingModal()"
                                class="px-4 py-2 rounded border border-gray-400 text-gray-600 hover:bg-gray-200">
                            Hủy
                        </button>
                        <button type="submit" onclick="return validateForm()"
                                class="bg-green-600 hover:bg-green-500 text-white px-5 py-2 rounded font-semibold shadow">
                            Xác nhận
                        </button>
                    </div>
                </form>
            </div>
        </div>

    </body>

    <script>
        let currentBasePrice = 0;
        const isLoggedIn = ${user != null ? 'true' : 'false'};
        const bookedDates = "${bookedDatesJSON}".split(",").filter(d => d);
        function disableBookedDates(input) {
        input.addEventListener("input", () => {
        const selected = input.value;
        if (bookedDates.includes(selected)) {
        alert("Ngày này đã được đặt, vui lòng chọn ngày khác.");
        input.value = "";
        }
        });
        }
        function validateForm() {
        const inVal = document.getElementById("checkInDate").value;
        const outVal = document.getElementById("checkOutDate").value;
        if (!inVal || !outVal) {
        alert("Vui lòng chọn ngày nhận và trả phòng.");
        return false;
        }
        return true;
        }
        function openBookingModal(roomId, roomType, basePrice) {
        document.getElementById('modalRoomId').value = roomId;
        document.getElementById('modalRoomType').innerText = roomType;
        document.getElementById('basePrice').innerText = basePrice.toLocaleString();
        document.getElementById('totalPrice').innerText = basePrice.toLocaleString();
        currentBasePrice = basePrice;
        const checkIn = document.getElementById("checkInDate");
        const checkOut = document.getElementById("checkOutDate");
        const bookedDates = bookedDatesByRoom[roomId] || [];
        checkIn.value = "";
        checkOut.value = "";
        // clear old flatpickr instance if any
        if (checkIn._flatpickr)
                checkIn._flatpickr.destroy();
        if (checkOut._flatpickr)
                checkOut._flatpickr.destroy();
        // disable các ngày đã đặt
        flatpickr(checkIn, {
        disable: bookedDates,
                minDate: "today",
                disable: bookedDates,
                dateFormat: "Y-m-d",
                onChange: function (selectedDates, dateStr) {
                if (checkOut._flatpickr) {
                checkOut._flatpickr.set('minDate', dateStr);
                }
                calculateTotal();
                }
        });
        flatpickr(checkOut, {
        minDate: "today",
                disable: bookedDates,
                dateFormat: "Y-m-d",
                onChange: calculateTotal
        });
        document.getElementById('bookingModal').classList.remove('hidden');
        }


        function closeBookingModal() {
        document.getElementById('bookingModal').classList.add('hidden');
        }

        function calculateTotal() {
        const checkInVal = document.getElementById("checkInDate").value;
        const checkOutVal = document.getElementById("checkOutDate").value;
        let nights = 1;
        if (checkInVal && checkOutVal) {
        const inDate = new Date(checkInVal);
        const outDate = new Date(checkOutVal);
        const diffTime = outDate - inDate;
        nights = Math.max(1, Math.ceil(diffTime / (1000 * 60 * 60 * 24)));
        }

        let total = nights * currentBasePrice;
        document.querySelectorAll('.service-checkbox:checked').forEach(cb => {
        total += parseFloat(cb.getAttribute('data-price'));
        });
        document.getElementById('totalPrice').innerText = total.toLocaleString();
        }

        document.addEventListener('change', function (e) {
        if (e.target.classList.contains('service-checkbox') ||
                e.target.id === "checkInDate" || e.target.id === "checkOutDate") {
        calculateTotal();
        }
        });
        function checkLoginBeforeBooking(roomId, roomType, price) {
        if (!isLoggedIn) {
        alert("Vui lòng đăng nhập để đặt phòng.");
        window.location.href = "${pageContext.request.contextPath}/login";
        return;
        }
        openBookingModal(roomId, roomType, price);
        }

        document.addEventListener("DOMContentLoaded", function () {
        const today = new Date().toISOString().split('T')[0];
        const checkIn = document.getElementById("checkInDate");
        const checkOut = document.getElementById("checkOutDate");
        checkIn.min = today;
        checkOut.min = today;
        checkIn.addEventListener("change", function () {
        checkOut.min = this.value;
        if (checkOut.value < this.value) {
        checkOut.value = this.value;
        }
        calculateTotal();
        });
        checkOut.addEventListener("change", calculateTotal);
        });
    </script>


</html>
