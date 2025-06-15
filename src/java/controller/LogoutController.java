package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // ✅ Huỷ session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // ✅ (Tuỳ chọn) Xoá cookie ghi nhớ email
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie ck : cookies) {
                if ("rememberedEmail".equals(ck.getName())) {
                    ck.setValue("");
                    ck.setMaxAge(0);
                    response.addCookie(ck);
                }
            }
        }

        // ✅ Chuyển về login
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
