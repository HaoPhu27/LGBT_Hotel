<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Royal Paradise Hotel - Khách sạn sang trọng</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
   <body class="bg-gray-900 pt-8 min-h-screen font-sans text-gray-100">

        <%@ include file="header.jsp" %>
        <%
           if (session.getAttribute("username") != null) {
               username = (String) session.getAttribute("username");
           }
        %>

        <!-- Hero Section -->
        <section id="home"
                 class="h-[70vh] bg-cover bg-center flex items-center justify-center text-white text-center mt-10"
                 style='background-image: url("${pageContext.request.contextPath}/assets/images/home-resort-hero-bg.jpg")'>
            <div>
                <h1 class="text-4xl md:text-5xl font-bold mb-4 drop-shadow-lg">Chào mừng đến Royal Paradise</h1>
                <p class="text-lg max-w-xl mx-auto mb-6">Trải nghiệm nghỉ dưỡng sang trọng với dịch vụ 5 sao và không gian tuyệt vời nhất</p>
                <a href="#rooms" class="inline-block px-6 py-3 bg-red-500 text-white rounded-full hover:bg-red-600 transition">Khám phá ngay</a>
            </div>
        </section>

        <!-- Rooms Section -->
        <!-- Rooms Section -->
        <section id="rooms" class="py-16">
            <div class="max-w-screen-xl mx-auto px-4">
                <h2 class="text-3xl font-bold text-center text-indigo-100 mb-12">Danh sách các loại phòng đề xuất</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">

                    <!-- 1. Standard Garden Room -->
                    <div class="bg-gray-800 rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transition cursor-pointer">
                        <div class="bg-green-700 text-white h-48 flex items-center justify-center text-lg">🛏️ Standard Garden Room</div>
                        <div class="p-6">
                            <h3 class="text-xl font-semibold mb-2">Phòng tiêu chuẩn vườn</h3>
                            <ul class="mb-4 text-gray-300 list-disc pl-5 space-y-1">
                                <li>Diện tích: 18–22 m²</li>
                                <li>View: Vườn cây/tiểu cảnh</li>
                                <li>Tiện nghi: Giường đôi/2 giường đơn, quạt hoặc máy lạnh, wifi, TV cơ bản</li>
                                <li>Vị trí: Gần lối đi chung, không gần biển</li>
                                <li>Thiết kế: Gỗ, tre hoặc vật liệu tự nhiên</li>
                            </ul>
                            <p class="text-red-500 font-semibold text-lg mb-4">Giá: Tiết kiệm</p>
                            <button class="bg-red-500 text-white py-2 px-4 rounded-full hover:bg-red-600" data-room="Standard Garden Room">Xem chi tiết</button>
                        </div>
                    </div>

                    <!-- 2. Deluxe Forest View -->
                    <div class="bg-gray-800 rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transition cursor-pointer">
                        <div class="bg-emerald-600 text-white h-48 flex items-center justify-center text-lg">🌲 Deluxe Forest View</div>
                        <div class="p-6">
                            <h3 class="text-xl font-semibold mb-2">Phòng cao cấp nhìn ra rừng</h3>
                            <ul class="mb-4 text-gray-300 list-disc pl-5 space-y-1">
                                <li>Diện tích: 25–28 m²</li>
                                <li>View: Toàn cảnh rừng nguyên sinh</li>
                                <li>Tiện nghi: Giường queen, điều hòa, ban công nhỏ, minibar</li>
                                <li>Khu yên tĩnh, lý tưởng nghỉ dưỡng</li>
                            </ul>
                            <p class="text-red-500 font-semibold text-lg mb-4">Giá: Trung bình</p>
                            <button class="bg-red-500 text-white py-2 px-4 rounded-full hover:bg-red-600" data-room="Deluxe Forest View">Xem chi tiết</button>
                        </div>
                    </div>

                    <!-- 3. Ocean Breeze Room -->
                    <div class="bg-gray-800 rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transition cursor-pointer">
                        <div class="bg-blue-500 text-white h-48 flex items-center justify-center text-lg">🌊 Ocean Breeze Room</div>
                        <div class="p-6">
                            <h3 class="text-xl font-semibold mb-2">Phòng gió biển</h3>
                            <ul class="mb-4 text-gray-300 list-disc pl-5 space-y-1">
                                <li>Diện tích: 28–32 m²</li>
                                <li>View: Hướng biển, đón gió</li>
                                <li>Tiện nghi: Giường king, ban công lớn, ghế thư giãn, bồn tắm</li>
                                <li>Thiết kế mở, tông trắng – gỗ sáng</li>
                            </ul>
                            <p class="text-red-500 font-semibold text-lg mb-4">Giá: Trung cao</p>
                            <button class="bg-red-500 text-white py-2 px-4 rounded-full hover:bg-red-600" data-room="Ocean Breeze Room">Xem chi tiết</button>
                        </div>
                    </div>

                    <!-- 4. Beachfront Bungalow -->
                    <div class="bg-gray-800 rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transition cursor-pointer">
                        <div class="bg-yellow-500 text-white h-48 flex items-center justify-center text-lg">🏖️ Beachfront Bungalow</div>
                        <div class="p-6">
                            <h3 class="text-xl font-semibold mb-2">Bungalow sát biển</h3>
                            <ul class="mb-4 text-gray-300 list-disc pl-5 space-y-1">
                                <li>Diện tích: 40–45 m²</li>
                                <li>View: Trực tiếp nhìn biển, có hiên riêng</li>
                                <li>Tiện nghi: Bồn tắm & vòi sen ngoài trời, ghế lười sát biển</li>
                                <li>Thiết kế mái lá truyền thống đầy đủ tiện nghi</li>
                            </ul>
                            <p class="text-red-500 font-semibold text-lg mb-4">Giá: Cao cấp</p>
                            <button class="bg-red-500 text-white py-2 px-4 rounded-full hover:bg-red-600" data-room="Beachfront Bungalow">Xem chi tiết</button>
                        </div>
                    </div>

                    <!-- 5. Treetop Villa -->
                    <div class="bg-gray-800 rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transition cursor-pointer">
                        <div class="bg-lime-600 text-white h-48 flex items-center justify-center text-lg">🌳 Treetop Villa</div>
                        <div class="p-6">
                            <h3 class="text-xl font-semibold mb-2">Biệt thự trên cây</h3>
                            <ul class="mb-4 text-gray-300 list-disc pl-5 space-y-1">
                                <li>Diện tích: 50–60 m²</li>
                                <li>View: Toàn cảnh rừng và biển</li>
                                <li>Tiện nghi: Bể ngâm, cầu treo, ban công 360 độ</li>
                                <li>Thiết kế gỗ & kính, hòa mình thiên nhiên</li>
                            </ul>
                            <p class="text-red-500 font-semibold text-lg mb-4">Giá: Rất cao</p>
                            <button class="bg-red-500 text-white py-2 px-4 rounded-full hover:bg-red-600" data-room="Treetop Villa">Xem chi tiết</button>
                        </div>
                    </div>

                    <!-- 6. Presidential Cliff Villa -->
                    <div class="bg-gray-800 rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transition cursor-pointer">
                        <div class="bg-gray-400 text-white h-48 flex items-center justify-center text-lg">🏰 Presidential Cliff Villa</div>
                        <div class="p-6">
                            <h3 class="text-xl font-semibold mb-2">Biệt thự vách đá Tổng thống</h3>
                            <ul class="mb-4 text-gray-300 list-disc pl-5 space-y-1">
                                <li>Diện tích: &gt;100 m²</li>
                                <li>View: Vách đá sát biển, cực kỳ riêng tư</li>
                                <li>Tiện nghi: Hồ bơi riêng, đầu bếp, gym mini, dịch vụ 24/7</li>
                                <li>Thiết kế kính tràn viền hiện đại – sinh thái</li>
                            </ul>
                            <p class="text-red-500 font-semibold text-lg mb-4">Giá: Siêu cao cấp</p>
                            <button class="bg-red-500 text-white py-2 px-4 rounded-full hover:bg-red-600" data-room="Presidential Cliff Villa">Xem chi tiết</button>
                        </div>
                    </div>

                </div>
            </div>
        </section>
        <!-- Modal -->
        <div id="modal-overlay" class="fixed inset-0 bg-black bg-opacity-50 z-40 hidden"></div>
        <div id="room-modal" class="fixed inset-0 flex items-center justify-center z-50 hidden">
            <div class="bg-white max-w-2xl w-full rounded-lg shadow-lg p-6 relative">
                <button onclick="closeRoomDetail()" class="absolute top-2 right-3 text-gray-500 hover:text-red-500 text-xl">×</button>
                <h3 id="modal-title" class="text-2xl font-bold text-gray-800 mb-4"></h3>
                <div id="modal-content" class="text-gray-700 space-y-2 mb-6"></div>
                <div class="text-center">
                    <form id="bookForm" method="get" action="${pageContext.request.contextPath}/searchRoom">
                        <input type="hidden" name="search" value="">
                        <input type="hidden" name="minPrice" value="">
                        <input type="hidden" name="maxPrice" value="">
                        <input type="hidden" name="status" value="">
                        <input type="hidden" name="type" id="roomTypeInput">
                        <input type="hidden" name="sort" value="asc">
                        <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded-full hover:bg-blue-700 transition">
                            Tìm & Đặt phòng
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <script>
            const contextPath = "${pageContext.request.contextPath}";
            const roomDetails = {
                "Standard Garden Room": `💵 Giá rẻ – Dịch vụ cơ bản, tiện lợi<br>• Dọn phòng mỗi ngày<br>• Wi-Fi miễn phí<br>• Nước suối + khăn lạnh miễn phí ngày đầu<br>• Tư vấn tour (qua lễ tân)<br>• Khu vực giữ hành lý<br>• Khu vực đỗ xe chung<br>• Nhà hàng chung (buffet sáng)<br>🔹 Không bao gồm minibar, không có dịch vụ phòng 24h`,

                "Deluxe Forest View": `🌳 Yên tĩnh, gần thiên nhiên, dịch vụ cải tiến<br>• Tất cả tiện ích từ hạng Standard<br>• Minibar cơ bản (miễn phí 1 lần/ngày)<br>• Ban công riêng với ghế thư giãn<br>• Ưu tiên đặt xe buggy nội khu<br>• Bữa sáng miễn phí tại phòng (theo yêu cầu)<br>• Dịch vụ giặt là (tính phí nhẹ)<br>• Massage cổ vai gáy tại phòng (tính phí)`,

                "Ocean Breeze Room": `🌊 Chill, ngắm biển, nhiều tiện ích hơn<br>• Toàn bộ dịch vụ hạng Deluxe<br>• Set trà & cà phê miễn phí trong phòng<br>• Dịch vụ thuê xe đạp địa hình miễn phí<br>• Tour sunset boat (miễn phí nếu đặt >2 đêm)<br>• Ưu đãi combo BBQ hải sản tại bãi biển<br>• Miễn phí dịch vụ đưa đón cảng/đảo<br>• Welcome drink đặc biệt khi check-in`,

                "Beachfront Bungalow": `🏖️ Sang trọng, lãng mạn, phục vụ cao cấp<br>• Tất cả dịch vụ hạng Ocean Breeze<br>• Hồ bơi riêng hoặc hiên riêng có vòi sen ngoài trời<br>• Set bữa tối riêng tư tại biển (1 lần nếu nghỉ >2 đêm)<br>• Trà chiều phục vụ tại hiên<br>• Dịch vụ phòng 24/7<br>• Miễn phí sử dụng kayak 1h/ngày<br>• Liệu trình massage 30 phút miễn phí/người`,

                "Treetop Villa": `🌿 View rừng + biển, trải nghiệm "giàu chất sống"<br>• Dịch vụ hạng Bungalow<br>• Hướng dẫn viên riêng cho tour<br>• Yoga sáng miễn phí tại deck riêng<br>• Dịch vụ xông thảo dược tại phòng<br>• Ưu tiên chọn vị trí check-in, chụp ảnh<br>• Dịch vụ đốt lửa trại riêng tư<br>• Hệ thống âm thanh Bluetooth, iPad điều khiển ánh sáng`,

                "Presidential Cliff Villa": `🏰 Đỉnh cao tiện nghi và phục vụ cá nhân hóa<br>• Dịch vụ Treetop Villa<br>• Xe riêng đưa đón sân bay/cảng (limousine/du thuyền)<br>• Đầu bếp riêng (theo yêu cầu)<br>• Hồ bơi tràn viền, ghế phơi nắng VIP<br>• Quản gia riêng 24/24<br>• Dịch vụ spa toàn thân mỗi ngày (miễn phí)<br>• Tủ rượu vang cá nhân trong phòng`
            };

            document.querySelectorAll("button[data-room]").forEach(btn => {
                btn.addEventListener("click", () => {
                    const roomKey = btn.dataset.room;

                    // Gán nội dung modal
                    document.getElementById("modal-title").textContent = roomKey;
                    document.getElementById("modal-content").innerHTML = roomDetails[roomKey] || "Đang cập nhật...";

                    // Gán type vào form ẩn
                    document.getElementById("roomTypeInput").value = roomKey;

                    // Mở modal
                    document.getElementById("modal-overlay").classList.remove("hidden");
                    document.getElementById("room-modal").classList.remove("hidden");
                });
            });

            function closeRoomDetail() {
                document.getElementById("room-modal").classList.add("hidden");
                document.getElementById("modal-overlay").classList.add("hidden");
            }

        </script>
        <!-- Footer -->
        <footer class="bg-gray-800 text-white text-center py-8">
            <div class="max-w-screen-xl mx-auto px-4">
                <p>&copy; 2025 Royal Paradise Hotel. Tất cả quyền được bảo lưu.</p>
                <p>📞 Hotline: 1900-1234 | 📧 Email: info@royalparadise.com</p>
            </div>
        </footer>
    </body>
</html>



