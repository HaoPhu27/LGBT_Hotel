package controller;

import dao.ServiceDAO;
import jakarta.servlet.RequestDispatcher;
import model.Service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/services")
public class ShowServiceController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ServiceDAO dao = new ServiceDAO();
        List<Service> services = dao.getAllServices();

        request.setAttribute("services", services);
        request.getRequestDispatcher("/view/hotel/services.jsp").forward(request, response);
    }
}
