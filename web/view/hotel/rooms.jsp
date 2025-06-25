<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8"/>
  <title>Danh sách phòng trống</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-900 pt-24 min-h-screen font-sans text-gray-100">

  <div class="max-w-7xl mx-auto px-4">
    <h2 class="text-4xl font-extrabold text-center mb-10 text-indigo-300 tracking-tight">
      🏨 Danh sách phòng còn trống
    </h2>

    <c:if test="${not empty error}">
      <div class="bg-red-900 text-red-200 border border-red-500 px-4 py-3 rounded mb-6 text-center font-medium">
        ${error}
      </div>
    </c:if>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">

      <c:choose>
        <c:when test="${not empty rooms}">
          <c:forEach var="room" items="${rooms}">
            <div class="bg-gray-800 rounded-2xl shadow-xl hover:shadow-2xl transition-transform transform hover:-translate-y-1 duration-300 overflow-hidden flex flex-col">
              <c:if test="${not empty room.imageUrl}">
                <img src="${room.imageUrl}"
                     alt="Phòng ${room.roomNumber}"
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

                  <span class="inline-block text-xs font-semibold px-3 py-1 rounded-full 
                        ${room.status eq 'AVAILABLE' ? 'bg-green-900 text-green-300' : 'bg-gray-700 text-gray-400'}">
                    ${room.status}
                  </span>
                </div>

                <form action="${pageContext.request.contextPath}/book" method="post" class="mt-4">
                  <input type="hidden" name="roomId" value="${room.roomId}"/>
                  <button type="submit"
                          class="w-full bg-indigo-700 hover:bg-indigo-600 text-white font-semibold py-2 px-4 rounded-full shadow">
                    Đặt ngay
                  </button>
                </form>
              </div>
            </div>
          </c:forEach>
        </c:when>

        <c:otherwise>
          <p class="text-center text-gray-400 text-lg col-span-3">
            Hiện không có phòng trống nào.
          </p>
        </c:otherwise>
      </c:choose>

    </div>
  </div>
</body>
</html>
