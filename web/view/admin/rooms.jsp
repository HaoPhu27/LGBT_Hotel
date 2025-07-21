<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Rooms" %>

<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<c:if test="${param.success eq 'true'}">
    <script>
        alert("Cập nhật phòng thành công!");
        window.history.replaceState({}, document.title, window.location.pathname);
    </script>
</c:if>
<div class="flex min-h-screen bg-gray-100">

    <jsp:include page="sidebar.jsp" />
    
    <!-- Content -->
    <main class="flex-1 ml-64 p-8">
        <section id="rooms-section">
            <div class="flex justify-between items-center mb-6">
                <h1 class="text-3xl font-bold text-gray-800 flex items-center">
                    <i class="fas fa-bed mr-3 text-blue-500"></i>Quản lý Phòng
                </h1>
                <a href="${pageContext.request.contextPath}/createroom"
                   class="inline-block bg-blue-600 hover:bg-blue-700 text-white font-semibold px-5 py-2 rounded-lg shadow-md transition">
                    <i class="fas fa-plus mr-2"></i>Thêm Phòng
                </a>
            </div>

            <div class="bg-white shadow-xl rounded-2xl overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200 text-sm">
                        <thead class="bg-gray-100">
                            <tr class="text-gray-600 uppercase text-xs tracking-wider">
                                <th class="px-6 py-4 text-left">Mã</th>
                                <th class="px-6 py-4 text-left">Ảnh</th>
                                <th class="px-6 py-4 text-left">Loại</th>
                                <th class="px-6 py-4 text-left">Giá/đêm</th>
                                <th class="px-6 py-4 text-left">Trạng thái</th>
                                <th class="px-6 py-4 text-center">Hành động</th> <!-- NEW -->
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200 bg-white">
                            <c:forEach var="r" items="${rooms}">
                                <tr class="hover:bg-gray-50 transition-all duration-150">
                                    <td class="px-6 py-4 font-medium text-gray-800">${r.roomNumber}</td>
                                    <td class="px-6 py-4">
                                        <img src="${pageContext.request.contextPath}/assets/images/${r.imageUrl}" alt="Ảnh phòng" class="w-24 h-16 object-cover rounded-lg border border-gray-200">
                                    </td>
                                    <td class="px-6 py-4 text-gray-700">${r.type}</td>
                                    <td class="px-6 py-4 text-gray-700">
                                        <fmt:formatNumber value="${r.price}" type="number" groupingUsed="true"/> VNĐ
                                    </td>
                                    <td class="px-6 py-4">
                                        <c:choose>
                                            <c:when test="${r.status eq 'booked'}">
                                                <span class="inline-block px-3 py-1 text-xs font-semibold rounded-full bg-red-100 text-red-800">
                                                    Đã đặt
                                                </span>
                                            </c:when>
                                            <c:when test="${r.status eq 'repaired'}">
                                                <span class="inline-block px-3 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-800">
                                                    Đang sửa chữa
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="inline-block px-3 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">
                                                    Trống
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-4 text-center">
                                        <a href="${pageContext.request.contextPath}/roomedit?id=${r.roomId}"
                                           class="bg-yellow-400 hover:bg-yellow-500 text-white px-3 py-1 rounded text-xs mr-2">
                                            <i class="fas fa-edit"></i> Sửa
                                        </a>
                                        <form method="post" action="${pageContext.request.contextPath}/deleteroom" style="display:inline;">
                                            <input type="hidden" name="roomId" value="${r.roomId}" />
                                            <button type="submit"
                                                    class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded text-xs"
                                                    onclick="return confirm('Bạn có chắc muốn xóa phòng này?');">
                                                <i class="fas fa-trash"></i> Xóa
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>
    </main>
</div>
