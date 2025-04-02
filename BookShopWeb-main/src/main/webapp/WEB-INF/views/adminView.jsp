<%@page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="vi">

<head>
  <jsp:include page="_meta.jsp" />
  <title>Trang chủ Admin</title>
  <!-- Thêm Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        var data = google.visualization.arrayToDataTable([
            ['Thời gian', 'Doanh thu'],
            <% 
                Map<String, Double> revenueData = (Map<String, Double>) request.getAttribute("revenueData");
                if (revenueData != null && !revenueData.isEmpty()) {
                    for (Map.Entry<String, Double> entry : revenueData.entrySet()) {
                        String month = entry.getKey();
                        Double revenue = entry.getValue();
                        if (month != null && revenue != null) {
            %>
            ['<%= month %>', <%= revenue %>],
            <% 
                        }
                    }
                } else {
            %>
            ['Không có dữ liệu', 0.0],
            <% } %>
        ]);

        var options = {
            
            hAxis: {title: 'Thời gian', titleTextStyle: {color: '#333'}},
            vAxis: {minValue: 0},
            chartArea: {width: '70%', height: '70%'},
            colors: ['#1b9e77']
        };

        var chart = new google.visualization.ColumnChart(document.getElementById('revenue_chart'));
        chart.draw(data, options);
    }
  </script>
</head>

<body>
  <!-- Include Header -->
  <jsp:include page="_headerAdmin.jsp" />

  <!-- Main Content Section -->
  <section class="section-content padding-y">
    <div class="container">
      <div class="card bg-light">
        <div class="card-body p-5">
          <h1 class="display-5 mb-5 text-center">Quản lý Shop Bán Sách</h1>

          <!-- Thống kê tổng quan -->
          <div class="row">
            <!-- Người dùng -->
            <div class="col-12 col-md-6 col-lg-3 mb-4">
              <figure class="card shadow-sm border-primary">
                <div class="card-body bg-primary text-white text-center p-4">
                  <h4 class="title display-6">${requestScope.totalUsers}</h4>
                  <span>Người dùng</span>
                </div>
              </figure>
            </div>

            <!-- Thể loại sách -->
            <div class="col-12 col-md-6 col-lg-3 mb-4">
                <figure class="card shadow-sm border-success">
                <div class="card-body bg-success text-white text-center p-4">
                  <h4 class="title display-6">${requestScope.totalCategories}</h4>
                  <span>Thể loại sách</span>
                </div>
              </figure>
            </div>

            <!-- Sách -->
            <div class="col-12 col-md-6 col-lg-3 mb-4">
              <figure class="card shadow-sm border-info">
                <div class="card-body bg-info text-white text-center p-4">
                  <h4 class="title display-6">${requestScope.totalProducts}</h4>
                  <span>Sách</span>
                </div>
              </figure>
            </div>

            <!-- Đơn hàng -->
            <div class="col-12 col-md-6 col-lg-3 mb-4">
              <figure class="card shadow-sm border-warning">
                <div class="card-body bg-warning text-dark text-center p-4">
                  <h4 class="title display-6">${requestScope.totalOrders}</h4>
                  <span>Đơn hàng</span>
                </div>
              </figure>
            </div>
          </div>

          <!-- Form chọn thời gian -->
         <h2 style="text-align: center; color: #4CAF50;">Chọn Thời Gian</h2>

<!-- Form để chọn thời gian, sử dụng phương thức POST -->
        <form action="admin" method="post" style="background-color: #f9f9f9; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); max-width: 400px; margin: auto;">
        <label for="startDate" style="font-weight: bold; color: #333;">Ngày bắt đầu:</label>
        <input type="date" id="startDate" name="startDate" required style="width: 100%; padding: 10px; margin: 8px 0 16px 0; border: 1px solid #ccc; border-radius: 5px;">

        <label for="endDate" style="font-weight: bold; color: #333;">Ngày kết thúc:</label>
        <input type="date" id="endDate" name="endDate" required style="width: 100%; padding: 10px; margin: 8px 0 16px 0; border: 1px solid #ccc; border-radius: 5px;">

        <button type="submit" style="background-color: #4CAF50; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; width: 100%;">Xem thống kê</button>
        </form>

            
             <hr>

            <!-- Hiển thị thông báo từ Servlet -->
            <% 
                String message = (String) request.getAttribute("message");
                if (message != null) {
                    out.println("<p>" + message + "</p>");
                }
            %>

          <!-- Biểu đồ doanh thu -->
          <div class="row mt-5">
            <div class="col-12">
              <h2 class="text-center">Thống kê doanh thu theo ngày</h2>
              <div id="revenue_chart" style="width: 100%; height: 500px;"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</body>

</html>