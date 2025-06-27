<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, model.Service" %>
<%@ include file="../hotel/header.jsp" %>
<%
    List<Service> services = (List<Service>) request.getAttribute("services");
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Danh sách dịch vụ</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-900 pt-24 min-h-screen font-sans text-gray-100">
  <div class="max-w-7xl mx-auto px-4">
    <h2 class="text-4xl font-extrabold text-center mb-10 text-indigo-300 tracking-tight">
      🛎️ Các dịch vụ tại Royal Paradise
    </h2>

    <% if (error != null) { %>
      <div class="bg-red-900 text-red-200 border border-red-500 px-4 py-3 rounded mb-6 text-center font-medium">
        <%= error %>
      </div>
    <% } %>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
      <% if (services != null && !services.isEmpty()) {
           for (Service s : services) { %>
        <div class="bg-gray-800 rounded-2xl shadow-xl hover:shadow-2xl transition-transform transform hover:-translate-y-1 duration-300 overflow-hidden flex flex-col p-6">
          <h3 class="text-xl font-semibold text-indigo-100 mb-2"><%= s.getName() %></h3>
          <p class="text-gray-400 mb-4 text-sm">Dịch vụ được cung cấp cho khách nghỉ dưỡng</p>
          <p class="text-red-400 text-lg font-bold"><%= s.getPrice() %> VNĐ</p>
        </div>
      <% } } else { %>
        <p class="col-span-3 text-center text-gray-400 text-lg">
          Hiện không có dịch vụ nào được hiển thị.
        </p>
      <% } %>
    </div>
  </div>

  <!-- Footer -->
  <footer class="bg-gray-800 text-white text-center py-8 mt-16">
    <div class="max-w-screen-xl mx-auto px-4">
      <p>&copy; 2025 Royal Paradise Hotel. Tất cả quyền được bảo lưu.</p>
      <p>📞 Hotline: 1900-1234 | 📧 Email: info@royalparadise.com</p>
    </div>
  </footer>
</body>
</html>
