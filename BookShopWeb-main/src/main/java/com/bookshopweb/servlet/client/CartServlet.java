package com.bookshopweb.servlet.client;

import com.bookshopweb.beans.Order;
import com.bookshopweb.beans.OrderItem;
import com.bookshopweb.dto.ErrorMessage;
import com.bookshopweb.dto.OrderRequest;
import com.bookshopweb.dto.SuccessMessage;
import com.bookshopweb.service.CartService;
import com.bookshopweb.service.OrderItemService;
import com.bookshopweb.service.OrderService;
import com.bookshopweb.utils.JsonUtils;
import com.bookshopweb.utils.Protector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "CartServlet", value = "/cart")
public class CartServlet extends HttpServlet {
    private final OrderService orderService = new OrderService();
    private final OrderItemService orderItemService = new OrderItemService();
    private final CartService cartService = new CartService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/cartView.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy đối tượng orderRequest từ JSON trong request
        OrderRequest orderRequest = JsonUtils.get(request, OrderRequest.class);

        // Tạo order
        Order order = new Order(
                0L,
                orderRequest.getUserId(),
                1,
                orderRequest.getDeliveryMethod(),
                orderRequest.getDeliveryPrice(),
                LocalDateTime.now(),
                null
        );
        long orderId = Protector.of(() -> orderService.insert(order)).get(0L);

        String successMessage = "Đã đặt hàng và tạo đơn hàng thành công!";
        String errorMessage = "Đã có lỗi truy vấn!";

        Runnable doneFunction = () -> JsonUtils.out(
                response,
                new SuccessMessage(200, successMessage),
                HttpServletResponse.SC_OK);
        Runnable failFunction = () -> JsonUtils.out(
                response,
                new ErrorMessage(404, errorMessage),
                HttpServletResponse.SC_NOT_FOUND);

        if (orderId > 0L) {
            List<OrderItem> orderItems = orderRequest.getOrderItems().stream().map(orderItemRequest -> new OrderItem(
                    0L,
                    orderId,
                    orderItemRequest.getProductId(),
                    orderItemRequest.getPrice(),
                    orderItemRequest.getDiscount(),
                    orderItemRequest.getQuantity(),
                    LocalDateTime.now(),
                    null
            )).collect(Collectors.toList());

            Protector.of(() -> {
                        orderItemService.bulkInsert(orderItems);
                        cartService.delete(orderRequest.getCartId());
                        sendOrderEmail(orderId);
                    })
                    .done(r -> doneFunction.run())
                    .fail(e -> failFunction.run());
        } else {
            failFunction.run();
        }
    }
    
    private void sendOrderEmail(Long orderId) {
        try {
            System.out.println("OrderId received: " + orderId);
            // Tạo kết nối HTTP để gọi Servlet gửi email
            URL url = new URL("http://localhost:8080/BookShopWeb/sendOrderEmail");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setDoOutput(true);

            // Gửi orderId trong body yêu cầu
            String jsonBody = "{\"orderId\":" + orderId + "}";
            try (OutputStream os = connection.getOutputStream()) {
                os.write(jsonBody.getBytes());
                os.flush();
            }

            // Đọc phản hồi từ Servlet
            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                System.out.println("Email sent successfully for orderId: " + orderId);
            } else {
                System.out.println("Failed to send email. Response code: " + responseCode);
            }
        } catch (Exception e) {
            System.err.println("Error while sending email: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
