<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>
  <jsp:include page="_meta.jsp"/>
  <title>Đăng nhập</title>
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <style>
      html, body {
        height: 100%;
        margin: 0;
      }
      body {
        display: flex;
        flex-direction: column;
      }
      .section-content {
        flex: 1 0 auto; /* Đảm bảo nội dung chính chiếm không gian còn lại */
      }
      .footer {
        flex-shrink: 0; /* Footer không bị co lại */
      }
    </style>
</head>

<body>
  <jsp:include page="_header.jsp"/>

  <section class="section-content py-5">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-md-6 col-lg-4">
            <div class="card-body">
              <h4 class="card-title text-center text-primary mb-4">Đăng nhập</h4> <!-- Màu chữ: xanh -->
              <form action="${pageContext.request.contextPath}/signin" method="post">
                
                <!-- Trường Tên đăng nhập -->
                <div class="form-group">
                  <input name="username"
                         class="form-control ${not empty requestScope.violations.usernameViolations ? 'is-invalid' : (not empty requestScope.values.username ? 'is-valid' : '')}"
                         placeholder="Tên đăng nhập"
                         type="text"
                         autocomplete="off"
                         value="${requestScope.values.username}">
                         
                  <!-- Thông báo lỗi nếu có -->
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

                <!-- Trường Mật khẩu -->
                <div class="form-group">
                  <input name="password"
                         class="form-control ${not empty requestScope.violations.passwordViolations ? 'is-invalid' : (not empty requestScope.values.password ? 'is-valid' : '')}"
                         placeholder="Mật khẩu"
                         type="password"
                         autocomplete="off"
                         value="${requestScope.values.password}">
                         
                  <!-- Thông báo lỗi nếu có -->
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

                <!-- Nút Đăng nhập -->
                <button type="submit" class="btn btn-success btn-block">Đăng nhập</button> <!-- Màu nút: xanh -->
              </form>
            </div> <!-- card-body -->
          </div> <!-- card -->
          <p class="text-center mt-3">Không có tài khoản? <a href="${pageContext.request.contextPath}/signup" class="text-danger">Đăng ký</a></p> <!-- Liên kết màu: đỏ -->
        </div> <!-- col -->
      </div> <!-- row -->
    </div> <!-- container -->
  </section> <!-- section-content -->

  <jsp:include page="_footer.jsp"/>
  
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
