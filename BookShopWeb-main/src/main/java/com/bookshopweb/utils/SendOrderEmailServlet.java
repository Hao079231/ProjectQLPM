/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.bookshopweb.utils;

// src/main/java/com/example/servlet/SendOrderEmailServlet.java
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

@WebServlet("/sendOrderEmail")
public class SendOrderEmailServlet extends HttpServlet {

    // Cấu hình email (cập nhật theo thông tin của bạn)
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_USERNAME = "nguyenhongha19hh@gmail.com";
    private static final String EMAIL_PASSWORD = "sntekljotbaiuadj";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy orderId từ body JSON của request
        
        String orderId = "1";request.getParameter("orderId");
        System.out.println("OrderId received: " + orderId);
        // Xử lý logic để lấy thông tin chi tiết đơn hàng (mock dữ liệu ở đây)
        String customerEmail = "nguyenhongha19hh@gmail.com"; // Thay bằng email khách hàng
        String orderDetails = "Chi tiết đơn hàng: Sản phẩm ABC, Số lượng: 1, Giá: 1.000.000₫";

        try {
            // Gửi email
            sendEmail(customerEmail, "Xác nhận đơn hàng #" + orderId, orderDetails);

            // Trả về phản hồi thành công
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Email đã được gửi thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Không thể gửi email!");
        }
    }

    private void sendEmail(String recipientEmail, String subject, String body) throws MessagingException, UnsupportedEncodingException {
        // Thiết lập các thuộc tính cho SMTP
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", SMTP_HOST);
        properties.put("mail.smtp.port", SMTP_PORT);

        // Tạo session với thông tin xác thực
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
            }
        });

        // Tạo email
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(EMAIL_USERNAME, "BookShopHa&Khai"));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
        message.setSubject(subject);
        message.setText(body);

        // Gửi email
        Transport.send(message);
    }
}
