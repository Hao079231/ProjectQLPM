<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>
  <jsp:include page="_meta.jsp"/>
  <title>Đăng nhập Admin</title>
  <!-- Thêm Bootstrap từ CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">
  <!-- Ảnh nền full màn hình -->
  <div class="container-fluid vh-100 d-flex justify-content-center align-items-center" style="background-image: url('https://hoangphucphoto.com/wp-content/uploads/2024/05/anh-sach-1.jpeg'); background-size: cover; background-position: center;">
    <!-- Form đăng nhập ở giữa màn hình -->
    <div class="card shadow-lg p-4" style="max-width: 400px; width: 100%; background-color: rgba(255, 255, 255, 0.85);">
      <div class="card-header text-center bg-success text-white">
        <h3 class="mb-0">Shop Bán Sách</h3>
      </div>
      <div class="card-body">
        <!-- Hiển thị thông báo lỗi nếu có -->
        <c:if test="${not empty requestScope.errorMessage}">
          <div class="alert alert-danger mb-3 small" role="alert">
            ${requestScope.errorMessage}
          </div>
        </c:if>

        <h4 class="card-title text-center mb-3">Đăng nhập Admin</h4>
        <p class="text-center mb-4 small">Chỉ dành cho quản trị viên và nhân viên</p>

        <form action="${pageContext.request.contextPath}/admin/signin" method="post">
          <!-- Tên đăng nhập -->
          <div class="mb-3">
            <input name="username"
                   class="form-control ${not empty requestScope.violations.usernameViolations
                     ? 'is-invalid' : (not empty requestScope.values.username ? 'is-valid' : '')}"
                   placeholder="Tên đăng nhập"
                   type="text"
                   autocomplete="off"
                   value="${requestScope.values.username}">
            <c:if test="${not empty requestScope.violations.usernameViolations}">
              <div class="invalid-feedback">
                <ul class="list-unstyled">
                  <c:forEach var="violation" items="${requestScope.violations.usernameViolations}">
                    <li>${violation}</li>
                  </c:forEach>
                </ul>
              </div>
            </c:if>
          </div>

          <!-- Mật khẩu -->
          <div class="mb-3">
            <input name="password"
                   class="form-control ${not empty requestScope.violations.passwordViolations
                     ? 'is-invalid' : (not empty requestScope.values.password ? 'is-valid' : '')}"
                   placeholder="Mật khẩu"
                   type="password"
                   autocomplete="off"
                   value="${requestScope.values.password}">
            <c:if test="${not empty requestScope.violations.passwordViolations}">
              <div class="invalid-feedback">
                <ul class="list-unstyled">
                  <c:forEach var="violation" items="${requestScope.violations.passwordViolations}">
                    <li>${violation}</li>
                  </c:forEach>
                </ul>
              </div>
            </c:if>
          </div>

          <!-- Nút đăng nhập -->
          <button type="submit" class="btn btn-success w-100">Đăng nhập</button>
        </form>
      </div> <!-- card-body.// -->
    </div> <!-- card .// -->
  </div> <!-- container-fluid .// -->
  
  <!-- Thêm Bootstrap JS từ CDN (tùy chọn) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
