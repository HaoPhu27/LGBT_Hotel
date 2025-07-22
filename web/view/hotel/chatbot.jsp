<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        
        <title>🤖 Chatbot Lễ Tân</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: '#3b82f6',
                            user: '#22c55e',
                            bot: '#60a5fa'
                        }
                    }
                }
            }
        </script>
        <style>
            .typing-dots span {
                display: inline-block;
                width: 8px;
                height: 8px;
                margin: 0 2px;
                background: #60a5fa;
                border-radius: 9999px;
                opacity: 0.6;
                animation: typingBlink 1s infinite alternate;
            }
            .typing-dots span:nth-child(2) {
                animation-delay: .2s;
            }
            .typing-dots span:nth-child(3) {
                animation-delay: .4s;
            }

            @keyframes typingBlink {
                to {
                    opacity: 1;
                }
            }
        </style>
    </head>
    <body class="bg-gray-900 text-white min-h-screen flex items-center justify-center p-4">
         <%@ include file="header.jsp" %>
        <div class="w-full max-w-3xl space-y-4">
            <h1 class="text-center text-2xl font-bold text-primary">💬 Chat với lễ tân khách sạn</h1>

            <!-- Chat Box -->
            <div id="chat-box" class="bg-gray-800 rounded-xl shadow p-4 space-y-4 max-h-[60vh] overflow-y-auto">
                <!-- Welcome -->
                <div class="flex items-start space-x-2">
                    <div class="bg-bot text-gray-900 rounded-xl p-3 w-fit">
                        <div class="font-semibold text-bot mb-1">🤖 Lễ tân</div>
                        <div>Xin chào! Tôi có thể giúp gì cho kỳ nghỉ của bạn hôm nay?</div>
                    </div>
                </div>

                <!-- Typing -->
                <div id="typingIndicator" class="flex items-start space-x-2 hidden">
                    <div class="bg-blue-200 text-gray-900 rounded-xl p-3 w-fit">
                        <div class="font-semibold text-blue-600 mb-1">🤖 Lễ tân</div>
                        <div class="typing-dots"><span></span><span></span><span></span></div>
                    </div>
                </div>
            </div>

            <!-- Input -->
            <form id="chat-form" class="flex items-center space-x-2">
                <input id="message-input" name="message" required
                       class="flex-1 p-3 bg-gray-700 border border-gray-600 rounded-xl text-white placeholder-gray-400 focus:outline-none focus:ring focus:border-primary"
                       placeholder="Nhập câu hỏi của bạn..." />
                <button type="submit"
                        class="bg-primary text-white px-5 py-3 rounded-xl hover:bg-blue-700 transition">
                    Gửi
                </button>
            </form>
        </div>

        <script>
            const form = document.getElementById("chat-form");
            const input = document.getElementById("message-input");
            const chatBox = document.getElementById("chat-box");
            const typing = document.getElementById("typingIndicator");

            form.addEventListener("submit", function (e) {
                e.preventDefault();
                const userMessage = input.value.trim();
                if (!userMessage)
                    return;

                appendMessage(userMessage, 'user');
                input.value = '';
                showTyping();

                fetch("chatbot", {
                    method: "POST",
                    headers: {"Content-Type": "application/x-www-form-urlencoded"},
                    body: "message=" + encodeURIComponent(userMessage)
                })
                        .then(res => res.json())
                        .then(data => {
                            hideTyping();
                            appendMessage(data.response.replace(/\n/g, "<br>"), 'bot');
                        })
                        .catch(() => {
                            hideTyping();
                            appendMessage("❌ Xin lỗi, đã xảy ra lỗi. Vui lòng thử lại.", 'bot');
                        });
            });

            function appendMessage(text, sender) {
                const bubble = document.createElement("div");
                bubble.className = `flex items-start space-x-2 ${'$'}{sender === 'user' ? 'justify-end' : ''}`;

                const inner = document.createElement("div");
                inner.className = `rounded-xl p-3 w-fit whitespace-pre-line ${'$'}{sender === 'user'
                ? 'bg-green-100 text-gray-900 self-end'
                : 'bg-blue-100 text-gray-900'}`;

                const name = document.createElement("div");
                name.className = `font-semibold mb-1 ${'$'}{sender === 'user' ? 'text-green-400' : 'text-blue-400'}`;
                name.textContent = sender === 'user' ? '🧑 Bạn' : '🤖 Lễ tân';

                const content = document.createElement("div");
                if (sender === 'bot') {
                    content.innerHTML = text;
                } else {
                    content.textContent = text;
                }

                inner.appendChild(name);
                inner.appendChild(content);
                bubble.appendChild(inner);

                chatBox.insertBefore(bubble, typing);
                chatBox.scrollTop = chatBox.scrollHeight;
            }

            function showTyping() {
                typing.classList.remove("hidden");
                chatBox.scrollTop = chatBox.scrollHeight;
            }

            function hideTyping() {
                typing.classList.add("hidden");
            }
        </script>
    </body>
</html>
