<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Bookings, model.Payment, dao.PaymentDAO" %>
<%@ include file="header.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    List<Bookings> bookings = (List<Bookings>) request.getAttribute("bookings");
    PaymentDAO paymentDAO = new PaymentDAO();
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Phòng đã đặt</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body  class="bg-gray-900 text-gray-100 font-sans min-h-screen flex flex-col">
        <main class="flex-grow pt-24">
            <div class="max-w-6xl mx-auto px-4 mb-8">

                <h2 class="text-3xl font-extrabold text-center mb-8 text-indigo-100 tracking-tight">
                    📄 Danh sách phòng đã đặt
                </h2>

                <c:if test="${not empty error}">
                    <div class="bg-red-800 text-red-200 border border-red-400 px-4 py-3 rounded mb-4 text-center">
                        ${error}
                    </div>
                </c:if>

                <% if (bookings != null && !bookings.isEmpty()) { %>
                <div class="overflow-x-auto">
                    <table class="min-w-full bg-gray-800 rounded-lg shadow-md">
                        <thead class="bg-gray-700 text-indigo-200 text-sm uppercase text-left">
                            <tr>
                                <th class="px-6 py-3">Mã phòng</th>
                                <th class="px-6 py-3">Nhận</th>
                                <th class="px-6 py-3">Trả</th>
                                <th class="px-6 py-3">Trạng thái Booking</th>
                                <th class="px-6 py-3">Ngày đặt</th>
                                <th class="px-6 py-3">Thanh toán</th>
                                <th class="px-6 py-3">Tổng tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Bookings b : bookings) {
                                Payment payment = paymentDAO.getPaymentByBookingId(b.getBookingId());
                            %>
                            <tr class="border-t border-gray-600 hover:bg-gray-700 transition">
                                <td class="px-6 py-3 font-semibold text-indigo-200"><%= b.getRoomNumber() %></td>
                                <td class="px-6 py-3"><%= b.getCheckIn() %></td>
                                <td class="px-6 py-3"><%= b.getCheckOut() %></td>

                                <td class="px-6 py-3">
                                    <%= b.getStatus() %>
                                </td>

                                <%
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                                %>
                                <td class="px-6 py-3"><%= sdf.format(b.getCreatedAt()) %></td>

                                <td class="px-6 py-3">
                                    <% if (payment != null) { %>
                                    <span class="px-2 py-1 rounded-full text-xs font-semibold
                                          <%= payment.getStatus().equalsIgnoreCase("paid") ? "bg-green-800 text-green-300" : "bg-yellow-800 text-yellow-300" %>">
                                        <%= payment.getStatus().equalsIgnoreCase("paid") ? "Đã thanh toán" : "Chưa thanh toán" %>
                                    </span>
                                    <% } else { %>
                                    <span class="text-red-400 text-sm italic">Chưa tạo thanh toán</span>
                                    <% } %>
                                </td>

                                <td class="px-6 py-3 font-medium text-right">
                                    <% if (payment != null) { %>
                                    <span class="text-green-300"><%= String.format("%,.0f VNĐ", payment.getAmount()) %></span>
                                    <% } else { %>
                                    <span class="text-gray-400">-</span>
                                    <% } %>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <% } else { %>
                <div class="text-center text-gray-400 text-lg mt-8">
                    Bạn chưa có đơn đặt phòng nào.
                </div>
                <% } %>
            </div>
        </main>
        <%@ include file="footer.jsp" %>
    </body>
</html>
