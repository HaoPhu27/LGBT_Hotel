<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://cdn.tailwindcss.com"></script>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Liên hệ & Giới thiệu - Khu Nghỉ Dưỡng Sinh Thái</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <jsp:include page="header.jsp" />
</head>

<body class="bg-gray-900 pt-24 min-h-screen text-gray-100 font-sans">

  <div class="max-w-5xl mx-auto px-6 py-12">
    <h1 class="text-4xl sm:text-5xl font-extrabold text-center text-indigo-300 mb-8 tracking-tight">
      🏝️ LGBT HOTEL
    </h1>

    <div class="bg-gray-800 rounded-2xl p-8 shadow-xl">
      <h2 class="text-2xl font-bold text-indigo-200 mb-4">Về chúng tôi</h2>
      <p class="text-gray-300 leading-relaxed text-justify mb-6">
        Tọa lạc giữa không gian thiên nhiên hoang sơ và yên bình, <span class="text-indigo-300 font-semibold">LGBT Hotel</span> là nơi lý tưởng dành cho những tâm hồn tìm kiếm sự thư giãn và đẳng cấp. Với nhiều hạng phòng từ <em>Standard Garden Room</em> ấm cúng đến <em>Presidential Cliff Villa</em> sang trọng, mỗi trải nghiệm tại đây đều mang lại cảm giác gần gũi thiên nhiên nhưng đầy tinh tế và riêng tư.
      </p>
      <p class="text-gray-400 italic">
        “Không chỉ là nơi nghỉ chân, chúng tôi mang đến một hành trình nghỉ dưỡng đáng nhớ.”
      </p>
    </div>

    <div class="mt-12 bg-gray-800 rounded-2xl p-8 shadow-xl">
      <h2 class="text-2xl font-bold text-indigo-200 mb-4">Thông tin liên hệ</h2>
      <ul class="space-y-3 text-gray-300">
        <li><strong>📍 Địa chỉ:</strong> Phú Quốc, Kiên Giang, Việt Nam</li>
        <li><strong>📞 Hotline:</strong> 0936 036 036</li>
        <li><strong>📧 Email:</strong> <a href="mailto:contact@lgbthotel.vn" class="text-indigo-400 hover:underline">contact@lgbthotel.vn</a></li>
        <li><strong>🌐 Website:</strong> <a href="http://www.lgbthotel.vn" target="_blank" class="text-indigo-400 hover:underline">www.lgbthotel.vn</a></li>
      </ul>
    </div>
  </div>

  <%@ include file="footer.jsp" %>
</body>
</html>
