<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
  <jsp:include page="_meta.jsp"/>
  <title>401 - Không được phép truy cập</title>
  <!-- Include Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
  <!-- Include Header -->
  <jsp:include page="_headerAdmin.jsp"/>

  <!-- Main Content Section -->
  <section class="section-content padding-y">
    <div class="container text-center py-5">
      <div class="row">
        <div class="col-md-8 offset-md-2">
          <div class="alert alert-danger" role="alert">
            <h4 class="alert-heading">Lỗi 401 - Không được phép truy cập</h4>
            <p>Quyền truy cập của bạn không đủ để vào khu vực này. Vui lòng kiểm tra lại quyền truy cập của bạn hoặc liên hệ với quản trị viên nếu có bất kỳ thắc mắc nào.</p>
            <hr>
            <p class="mb-0">Bạn có thể quay lại <a href="${pageContext.request.contextPath}/admin" class="alert-link">trang quản trị</a> hoặc trở về <a href="${pageContext.request.contextPath}/" class="alert-link">trang chủ</a>.</p>
          </div>
        </div>
      </div>
    </div> <!-- container.// -->
  </section> <!-- section-content.// -->

  <!-- Include Footer -->
  <jsp:include page="_footerAdmin.jsp"/>

  <!-- Include Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
