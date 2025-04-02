package com.bookshopweb.servlet.admin;

import com.bookshopweb.beans.Order;
import com.bookshopweb.service.CategoryService;
import com.bookshopweb.service.OrderItemService;
import com.bookshopweb.service.OrderService;
import com.bookshopweb.service.ProductService;
import com.bookshopweb.service.UserService;
import com.bookshopweb.utils.Protector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.bookshopweb.servlet.admin.order.OrderManagerServlet.calculateTotalPrice;

@WebServlet(name = "AdminServlet", value = "/admin")
public class AdminServlet extends HttpServlet {
    private final UserService userService = new UserService();
    private final CategoryService categoryService = new CategoryService();
    private final ProductService productService = new ProductService();
    private final OrderService orderService = new OrderService();
    private final OrderItemService orderItemService = new OrderItemService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // Lấy tham số từ request
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");
    String groupBy = request.getParameter("groupBy"); // Giá trị: "day", "month", "year"

    // Lấy số liệu tổng quan
    int totalUsers = Protector.of(userService::count).get(0);
    int totalCategories = Protector.of(categoryService::count).get(0);
    int totalProducts = Protector.of(productService::count).get(0);
    int totalOrders = Protector.of(orderService::count).get(0);

    // Lấy tất cả đơn hàng
    List<Order> allOrders = Protector.of(orderService::getAll).get(ArrayList::new);

    // Chuẩn bị dữ liệu thống kê doanh thu
    Map<String, Double> revenueData = new HashMap<>();
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat monthFormat = new SimpleDateFormat("yyyy-MM");
    SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");

    try {
        Date start = (startDate != null && !startDate.isEmpty()) ? dateFormat.parse(startDate) : null;
        Date end = (endDate != null && !endDate.isEmpty()) ? dateFormat.parse(endDate) : null;


        if (allOrders != null && !allOrders.isEmpty()) {
            for (Order order : allOrders) {
                if (order.getCreatedAt() != null) {
                    // Chuyển đổi LocalDateTime -> Date
                    Date createdAtDate = Date.from(order.getCreatedAt().atZone(ZoneId.systemDefault()).toInstant());

                    // Kiểm tra nếu ngày không nằm trong khoảng thời gian
                    if ((start != null && createdAtDate.before(start)) || (end != null && createdAtDate.after(end))) {
                        continue;
                    }

                    // Xác định khóa nhóm
                    String key;
                    if ("month".equalsIgnoreCase(groupBy)) {
                        key = monthFormat.format(createdAtDate);
                    } else if ("year".equalsIgnoreCase(groupBy)) {
                        key = yearFormat.format(createdAtDate);
                    } else {
                        key = dateFormat.format(createdAtDate);
                    }

                    // Tính tổng doanh thu
                    double totalPrice = calculateTotalPrice(orderItemService.getByOrderId(order.getId()), order.getDeliveryPrice());
                    revenueData.put(key, revenueData.getOrDefault(key, 0.0) + totalPrice);
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "Lỗi xử lý thống kê: " + e.getMessage());
    }

    // Nếu không có dữ liệu thống kê, thêm dữ liệu mặc định
    if (revenueData.isEmpty()) {
        revenueData.put("No Data", 0.0);
    }

    // Gửi dữ liệu đến JSP
    request.setAttribute("revenueData", revenueData);
    request.setAttribute("totalUsers", totalUsers);
    request.setAttribute("totalCategories", totalCategories);
    request.setAttribute("totalProducts", totalProducts);
    request.setAttribute("totalOrders", totalOrders);

    if (startDate != null && endDate != null) {
        request.setAttribute("message", "Thống kê từ " + startDate + " đến " + endDate + " theo " + groupBy);
    }

    request.getRequestDispatcher("/WEB-INF/views/adminView.jsp").forward(request, response);
}

}