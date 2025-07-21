<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>💬 Chatbot Lễ Tân Khách Sạn</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 min-h-screen flex flex-col items-center p-6">

        <div class="bg-white rounded-2xl shadow-lg w-full max-w-3xl p-6 flex flex-col space-y-4">
            <h1 class="text-2xl font-bold text-center text-blue-600">🤖 Chat với lễ tân khách sạn</h1>

            <!-- Vùng hiển thị chat -->
            <div id="chat-box" class="flex flex-col space-y-4 max-h-[60vh] overflow-y-auto pr-2">
                <c:forEach var="entry" items="${history}">
                    <div class="self-end max-w-[80%]">
                        <div class="bg-green-100 text-gray-800 p-3 rounded-xl whitespace-pre-line">
                            🧑 <span class="font-semibold">Bạn:</span><br/>${entry[0]}
                        </div>
                    </div>
                    <div class="self-start max-w-[80%]">
                        <div class="bg-blue-100 text-gray-800 p-3 rounded-xl whitespace-pre-line">
                            🤖 <span class="font-semibold">Lễ tân:</span><br/>${entry[1]}
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Form gửi -->
            <form id="chat-form" class="flex flex-col space-y-2">
                <textarea id="message-input" name="message" rows="3" required
                          class="resize-none p-3 border border-gray-300 rounded-xl focus:outline-none focus:ring focus:border-blue-400"
                          placeholder="Nhập câu hỏi của bạn..."></textarea>
                <button type="submit"
                        class="bg-blue-600 text-white font-semibold py-2 px-6 rounded-xl hover:bg-blue-700 transition">
                    Gửi
                </button>
            </form>
        </div>

        <!-- Script xử lý AJAX -->
        <script>
            const form = document.getElementById("chat-form");
            const input = document.getElementById("message-input");
            const chatBox = document.getElementById("chat-box");

            form.addEventListener("submit", function (e) {
                e.preventDefault();
                const userMessage = input.value.trim();
                if (!userMessage)
                    return;

                // Thêm câu hỏi người dùng
                const userBubble = document.createElement("div");
                userBubble.className = "self-end max-w-[80%]";
                userBubble.innerHTML = `
            <div class="bg-green-100 text-gray-800 p-3 rounded-xl whitespace-pre-line">
                🧑 <span class="font-semibold">Bạn:</span><br/>${userMessage}
            </div>`;
                chatBox.appendChild(userBubble);
                chatBox.scrollTop = chatBox.scrollHeight;

                input.value = ""; // xóa ô nhập sau khi thêm vào giao diện

                // Thêm hiệu ứng đang gõ
                const loadingBubble = document.createElement("div");
                loadingBubble.id = "loading";
                loadingBubble.className = "self-start max-w-[80%]";
                loadingBubble.innerHTML = `
            <div class="bg-blue-100 text-gray-800 p-3 rounded-xl animate-pulse">
                🤖 <span class="font-semibold">Lễ tân:</span><br/>Đang soạn câu trả lời...
            </div>`;
                chatBox.appendChild(loadingBubble);
                chatBox.scrollTop = chatBox.scrollHeight;

                // Gửi tới servlet
                fetch("chatbot", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: "message=" + encodeURIComponent(userMessage)
                })
                        .then(response => response.text())
                        .then(botReply => {
                            document.getElementById("loading").remove();

                            const botBubble = document.createElement("div");
                            botBubble.className = "self-start max-w-[80%]";
                            const botMessage = document.createElement("div");
                            botMessage.className = "bg-blue-100 text-gray-800 p-3 rounded-xl whitespace-pre-line";
                            botMessage.innerHTML = `🤖 <span class="font-semibold">Lễ tân:</span><br/><span id="typing-text"></span>`;
                            botBubble.appendChild(botMessage);
                            chatBox.appendChild(botBubble);

                            const typingText = botMessage.querySelector("#typing-text");
                            let index = 0;
                            const typeInterval = setInterval(() => {
                                if (index < botReply.length) {
                                    typingText.textContent += botReply.charAt(index);
                                    index++;
                                    chatBox.scrollTop = chatBox.scrollHeight;
                                } else {
                                    clearInterval(typeInterval);
                                }
                            }, 30);
                        })
                        .catch(err => {
                            console.error("Lỗi:", err);
                            document.getElementById("loading").remove();
                            const errorBubble = document.createElement("div");
                            errorBubble.className = "self-start max-w-[80%]";
                            errorBubble.innerHTML = `
                    <div class="bg-red-100 text-red-800 p-3 rounded-xl">
                        🤖 <span class="font-semibold">Lễ tân:</span><br/>Có lỗi xảy ra, vui lòng thử lại.
                    </div>`;
                            chatBox.appendChild(errorBubble);
                        });
            });
        </script>
    </body>
</html>
