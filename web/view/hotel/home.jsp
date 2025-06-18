<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Royal Paradise Hotel - Khách sạn sang trọng</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="font-sans text-gray-800">
  <!-- Header -->
  <header class="bg-gradient-to-r from-indigo-500 to-purple-600 text-white py-4 fixed w-full top-0 z-50 shadow-md">
    <div class="max-w-screen-xl mx-auto px-4">
      <nav class="flex justify-between items-center">
        <a href="#" class="text-2xl font-bold text-white">🏨 Royal Paradise</a>
        <ul class="hidden md:flex gap-8 list-none">
          <li><a href="#home" class="hover:bg-white/20 rounded-full px-4 py-2">Trang chủ</a></li>
          <li><a href="#rooms" class="hover:bg-white/20 rounded-full px-4 py-2">Phòng</a></li>
          <li><a href="#services" class="hover:bg-white/20 rounded-full px-4 py-2">Dịch vụ</a></li>
          <li><a href="#about" class="hover:bg-white/20 rounded-full px-4 py-2">Giới thiệu</a></li>
          <li><a href="#contact" class="hover:bg-white/20 rounded-full px-4 py-2">Liên hệ</a></li>
        </ul>
        <div class="flex gap-4">
          <a href="<%= request.getContextPath() %>/login" class="px-4 py-2 border border-white rounded-full text-white hover:bg-white hover:text-indigo-600">Đăng nhập</a>
          <a href="<%= request.getContextPath() %>/register" class="px-4 py-2 bg-red-500 hover:bg-red-600 rounded-full text-white">Đăng ký</a>
        </div>
      </nav>
    </div>
  </header>

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
  <section id="rooms" class="bg-gray-100 py-16">
    <div class="max-w-screen-xl mx-auto px-4">
      <h2 class="text-3xl font-bold text-center text-gray-800 mb-12">Các Loại Phòng</h2>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        <!-- Room Card -->
        <div class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transition cursor-pointer">
          <div class="bg-gradient-to-br from-indigo-500 to-purple-600 text-white h-48 flex items-center justify-center text-lg">🛏️ Phòng Deluxe</div>
          <div class="p-6">
            <h3 class="text-xl font-semibold mb-2">Phòng Deluxe</h3>
            <ul class="mb-4 text-gray-600 list-disc pl-5 space-y-1">
              <li>Diện tích 35m²</li>
              <li>Giường King size</li>
              <li>View thành phố</li>
              <li>Wifi miễn phí</li>
            </ul>
            <p class="text-red-500 font-semibold text-lg mb-4">2.500.000 VNĐ/đêm</p>
            <button class="bg-red-500 text-white py-2 px-4 rounded-full hover:bg-red-600">Xem chi tiết</button>
          </div>
        </div>
        <!-- Thêm các phòng khác tương tự -->
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer class="bg-gray-800 text-white text-center py-8">
    <div class="max-w-screen-xl mx-auto px-4">
      <p>&copy; 2025 Royal Paradise Hotel. Tất cả quyền được bảo lưu.</p>
      <p>📞 Hotline: 1900-1234 | 📧 Email: info@royalparadise.com</p>
    </div>
  </footer>
</body>
</html>


