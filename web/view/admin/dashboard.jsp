<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@page import="java.util.List"%>
<%
    String userRole = (String) session.getAttribute("userRole");
    String username = (String) session.getAttribute("username");
    if (userRole == null || !"admin".equals(userRole)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Dashboard Admin – Quản lý Khách sạn</title>

  <!-- Tailwind -->
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- Font-Awesome -->
  <link  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <!-- Chart.js -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>

  <style>
    .gradient-bg{background:linear-gradient(135deg,#667eea 0%,#764ba2 100%)}
    .card-hover{transition:transform .3s ease}
    .card-hover:hover{transform:translateY(-4px)}
  </style>
</head>
<body class="bg-gray-50">
  <div class="flex h-screen">

    <!-- ============ SIDEBAR ============ -->
    <aside class="w-64 gradient-bg text-white flex-shrink-0 relative">
      <div class="p-6">
        <div class="text-center mb-8">
          <i class="fas fa-hotel text-4xl mb-3"></i>
          <h2 class="text-xl font-bold">Hotel&nbsp;Admin</h2>
          <p class="text-sm opacity-75">Xin chào, <c:out value="${username}"/></p>
        </div>

        <nav class="space-y-2">
          <a href="#dashboard" class="nav-link flex items-center px-4 py-3 rounded-lg hover:bg-white/20 active"
             onclick="showSection('dashboard')">
            <i class="fas fa-tachometer-alt mr-3"></i>Dashboard
          </a>
          <a href="#rooms" class="nav-link flex items-center px-4 py-3 rounded-lg hover:bg-white/20"
             onclick="showSection('rooms')">
            <i class="fas fa-bed mr-3"></i>Quản lý Phòng
          </a>
          <a href="#bookings" class="nav-link flex items-center px-4 py-3 rounded-lg hover:bg-white/20"
             onclick="showSection('bookings')">
            <i class="fas fa-calendar-check mr-3"></i>Đặt Phòng
          </a>
          <a href="#revenue" class="nav-link flex items-center px-4 py-3 rounded-lg hover:bg-white/20"
             onclick="showSection('revenue')">
            <i class="fas fa-chart-line mr-3"></i>Doanh Thu
          </a>
        </nav>

        <div class="absolute bottom-6 left-6 right-6">
          <a href="${pageContext.request.contextPath}/logout.jsp"
             class="flex items-center px-4 py-3 rounded-lg hover:bg-white/20">
            <i class="fas fa-sign-out-alt mr-3"></i>Đăng Xuất
          </a>
        </div>
      </div>
    </aside>

    <!-- ============ MAIN ============ -->
    <main class="flex-1 overflow-hidden">
      <div class="h-full overflow-y-auto p-8">

        <!-- -------- DASHBOARD -------- -->
        <section id="dashboard-section" class="content-section">
          <div class="flex justify-between items-center mb-8">
            <h1 class="text-3xl font-bold text-gray-800">
              <i class="fas fa-tachometer-alt mr-3"></i>Dashboard
            </h1>
            <div class="text-gray-600">
              <i class="fas fa-calendar mr-2"></i>
              <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy HH:mm"/>
            </div>
          </div>

          <!-- Cards -->
          <%
              int totalRooms   = ((List<?>)request.getAttribute("rooms")).size();
              long bookedRooms = ((List<?>)request.getAttribute("rooms")).stream()
                                   .filter(r -> "booked".equals(((model.Rooms)r).getStatus())).count();
              int emptyRooms   = totalRooms - (int)bookedRooms;
              String totalRevenue = (String)request.getAttribute("totalRevenue"); // servlet set
          %>
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <div class="bg-gradient-to-r from-blue-500 to-blue-600 text-white p-6 rounded-xl shadow-lg card-hover">
              <div class="flex justify-between">
                <div>
                  <p class="text-blue-100 text-sm">Tổng Phòng</p>
                  <p class="text-3xl font-bold"><%= totalRooms %></p>
                </div><i class="fas fa-bed text-3xl text-blue-200"></i>
              </div>
            </div>
            <div class="bg-gradient-to-r from-indigo-500 to-indigo-600 text-white p-6 rounded-xl shadow-lg card-hover">
              <div class="flex justify-between">
                <div>
                  <p class="text-indigo-100 text-sm">Phòng Đã Đặt</p>
                  <p class="text-3xl font-bold"><%= bookedRooms %></p>
                </div><i class="fas fa-door-closed text-3xl text-indigo-200"></i>
              </div>
            </div>
            <div class="bg-gradient-to-r from-green-500 to-green-600 text-white p-6 rounded-xl shadow-lg card-hover">
              <div class="flex justify-between">
                <div>
                  <p class="text-green-100 text-sm">Phòng Trống</p>
                  <p class="text-3xl font-bold"><%= emptyRooms %></p>
                </div><i class="fas fa-door-open text-3xl text-green-200"></i>
              </div>
            </div>
            <div class="bg-gradient-to-r from-pink-500 to-pink-600 text-white p-6 rounded-xl shadow-lg card-hover">
              <div class="flex justify-between">
                <div>
                  <p class="text-pink-100 text-sm">Doanh Thu</p>
                  <p class="text-2xl font-bold"><c:out value="${totalRevenue}"/> VNĐ</p>
                </div><i class="fas fa-dollar-sign text-3xl text-pink-200"></i>
              </div>
            </div>
          </div>

          <!-- Charts (giữ nguyên Chart.js như cũ) -->
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
            <div class="bg-white p-6 rounded-xl shadow-lg">
              <h3 class="text-lg font-semibold mb-4">
                <i class="fas fa-chart-pie mr-2 text-blue-500"></i>Tỷ lệ Phòng
              </h3><canvas id="roomChart"></canvas>
            </div>
            <div class="bg-white p-6 rounded-xl shadow-lg">
              <h3 class="text-lg font-semibold mb-4">
                <i class="fas fa-chart-line mr-2 text-green-500"></i>Doanh Thu Theo Tháng
              </h3><canvas id="revenueChart"></canvas>
            </div>
          </div>
        </section>

        <!-- -------- ROOMS -------- -->
        <section id="rooms-section" class="content-section hidden">
          <div class="flex justify-between items-center mb-8">
            <h1 class="text-3xl font-bold text-gray-800">
              <i class="fas fa-bed mr-3"></i>Quản lý Phòng
            </h1>
            <button onclick="openRoomModal('add')" class="bg-blue-500 hover:bg-blue-600 text-white px-6 py-3 rounded-lg">
              <i class="fas fa-plus mr-2"></i>Thêm Phòng
            </button>
          </div>

          <div class="bg-white rounded-xl shadow-lg overflow-hidden">
            <div class="overflow-x-auto">
              <table class="min-w-full">
                <thead class="bg-gray-50">
                  <tr>
                    <th class="px-6 py-4 text-left text-xs font-medium text-gray-500 uppercase">Mã</th>
                    <th class="px-6 py-4 text-left text-xs font-medium text-gray-500 uppercase">Ảnh</th>
                    <th class="px-6 py-4 text-left text-xs font-medium text-gray-500 uppercase">Loại</th>
                    <th class="px-6 py-4 text-left text-xs font-medium text-gray-500 uppercase">Giá/đêm</th>
                    <th class="px-6 py-4 text-left text-xs font-medium text-gray-500 uppercase">Trạng thái</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-200">
                  <c:forEach var="r" items="${rooms}">
                    <tr class="hover:bg-gray-50">
                      <td class="px-6 py-4 text-sm font-medium"><c:out value="${r.roomNumber}"/></td>
                      <td class="px-6 py-4">
                        <img src="${r.imageUrl}" alt="" class="w-20 h-16 object-cover rounded">
                      </td>
                      <td class="px-6 py-4 text-sm"><c:out value="${r.type}"/></td>
                      <td class="px-6 py-4 text-sm">
                        <fmt:formatNumber value="${r.price}" type="number" groupingUsed="true"/> VNĐ
                      </td>
                      <td class="px-6 py-4">
                        <c:choose>
                          <c:when test="${r.status eq 'booked'}">
                            <span class="px-3 py-1 text-xs font-semibold rounded-full bg-red-100 text-red-800">Đã đặt</span>
                          </c:when>
                          <c:otherwise>
                            <span class="px-3 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">Trống</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
        </section>

        <!-- -------- BOOKINGS + REVENUE -------- -->
        <!-- (Giữ nguyên logic bookings-section & revenue-section cũ; bỏ mock nếu bạn đã nối DB) -->

      </div>
    </main>
  </div>

  <!-- ========= MODAL ADD ROOM ========= -->
  <div id="roomModal" class="fixed inset-0 bg-black/50 hidden items-center justify-center z-50">
    <div class="bg-white rounded-xl shadow-2xl w-full max-w-2xl mx-4 overflow-y-auto">
      <div class="p-6 border-b">
        <div class="flex justify-between items-center">
          <h2 id="roomModalTitle" class="text-2xl font-bold">Thêm Phòng Mới</h2>
          <button onclick="closeRoomModal()" class="text-gray-500 hover:text-gray-700">
            <i class="fas fa-times text-xl"></i>
          </button>
        </div>
      </div>

      <div class="p-6">
        <form id="roomForm"
              action="${pageContext.request.contextPath}/RoomController"
              method="post" enctype="multipart/form-data"
              class="space-y-4">

          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium mb-2">Mã Phòng</label>
              <input name="roomCode" type="text" required
                     class="w-full border rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label class="block text-sm font-medium mb-2">Loại Phòng</label>
              <select name="roomType" required
                      class="w-full border rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500">
                <option value="">Chọn loại phòng</option>
                <option>Standard</option><option>Deluxe</option>
                <option>Suite</option>   <option>VIP</option>
              </select>
            </div>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium mb-2">Giá/đêm (VNĐ)</label>
              <input name="roomPrice" type="number" step="1000" required
                     class="w-full border rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label class="block text-sm font-medium mb-2">Ảnh Phòng</label>
              <input name="roomImage" type="file" accept="image/*" required
                     class="w-full border rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500">
            </div>
          </div>

          <div>
            <label class="block text-sm font-medium mb-2">Mô tả</label>
            <textarea name="roomDescription" rows="3"
                      class="w-full border rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500"></textarea>
          </div>
        </form>
      </div>

      <div class="p-6 border-t flex justify-end space-x-3">
        <button onclick="closeRoomModal()" class="px-6 py-2 border rounded-lg">Huỷ</button>
        <button onclick="document.getElementById('roomForm').submit()"
                class="px-6 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded-lg">Lưu</button>
      </div>
    </div>
  </div>

  <!-- ========= JS ========= -->
  <script>
    /* toggle sections */
    function showSection(name){
      document.querySelectorAll('.content-section').forEach(s=>s.classList.add('hidden'));
      document.getElementById(name+'-section').classList.remove('hidden');
      document.querySelectorAll('.nav-link').forEach(l=>l.classList.remove('bg-white','bg-opacity-20'));
      event.target.classList.add('bg-white','bg-opacity-20');
    }
    /* modal */
    function openRoomModal(){document.getElementById('roomModal').classList.remove('hidden')}
    function closeRoomModal(){document.getElementById('roomModal').classList.add('hidden')}

    /* chart init */
    document.addEventListener('DOMContentLoaded',()=>{

      new Chart(document.getElementById('roomChart'),{
        type:'doughnut',
        data:{
          labels:['Đã Đặt','Trống'],
          datasets:[{data:[<%= bookedRooms %>,<%= emptyRooms %>],
            backgroundColor:['#ef4444','#10b981'],borderWidth:0}]
        },
        options:{plugins:{legend:{position:'bottom'}},responsive:true}
      });

      new Chart(document.getElementById('revenueChart'),{
        type:'line',
        data:{labels:['T1','T2','T3','T4','T5','T6'],
          datasets:[{label:'Doanh Thu (triệu)',
            data:[12,15,8,20,18,15.6],
            borderColor:'#3b82f6',
            backgroundColor:'rgba(59,130,246,.1)',fill:true,tension:.4}]},
        options:{scales:{y:{beginAtZero:true}},responsive:true}
      });
    });

    /*  close modal on ESC & backdrop */
    document.addEventListener('keydown',e=>{if(e.key==='Escape')closeRoomModal()});
    document.getElementById('roomModal').addEventListener('click',e=>{
      if(e.target.id==='roomModal')closeRoomModal();
    });
  </script>
</body>
</html>
