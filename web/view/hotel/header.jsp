<%@ page pageEncoding="UTF-8" %>
<%@ page import="model.Users" %>
<!-- Header dùng chung -->
<%
    Users user = (Users) session.getAttribute("user");
    String username = (user != null) ? user.getName() : null;
%>
<header class="bg-gradient-to-r from-indigo-500 to-purple-600 text-white py-4 fixed w-full top-0 z-50 shadow-md">
  <div class="max-w-screen-xl mx-auto px-4">
    <nav class="flex justify-between items-center">
      <a href="<%= request.getContextPath() %>/home" class="text-2xl font-bold text-white">🏨 LGBT Hotel</a>
      <ul class="hidden md:flex gap-8 list-none">
        <li><a href="<%= request.getContextPath() %>/home" class="hover:bg-white/20 rounded-full px-4 py-2">Trang chủ</a></li>
        <li><a href="<%= request.getContextPath() %>/rooms" class="hover:bg-white/20 rounded-full px-4 py-2">Phòng</a></li>
        <li><a href="<%= request.getContextPath() %>/services" class="hover:bg-white/20 rounded-full px-4 py-2">Dịch vụ</a></li>
        <li><a href="<%= request.getContextPath() %>/chatbot" class="hover:bg-white/20 rounded-full px-4 py-2">Chatbot</a></li>
        <li><a href="<%= request.getContextPath() %>/view/hotel/contact.jsp" class="hover:bg-white/20 rounded-full px-4 py-2">Liên hệ</a></li>
      </ul>
      <div class="flex gap-4 items-center">
        <% if (username == null) { %>
          <a href="<%= request.getContextPath() %>/login" class="px-4 py-2 border border-white rounded-full text-white hover:bg-white hover:text-indigo-600">Đăng nhập</a>
          <a href="<%= request.getContextPath() %>/register" class="px-4 py-2 bg-red-500 hover:bg-red-600 rounded-full text-white">Đăng ký</a>
        <% } else { %>
          <a href="<%= request.getContextPath() %>/profile" class="px-4 py-2 bg-white text-indigo-600 rounded-full hover:bg-gray-200 font-medium">
            Hồ sơ cá nhân
          </a>
          <span class="px-4 py-2 text-white font-semibold"><%= username %></span>
          <a href="<%= request.getContextPath() %>/logout" class="px-4 py-2 bg-red-600 hover:bg-red-700 rounded-full text-white">Đăng xuất</a>
        <% } %>
      </div>
    </nav>
  </div>
</header>
