<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="vi">

<head>
  <jsp:include page="_meta.jsp"/>
  <title>Trang chủ</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<jsp:include page="_header.jsp"/>

<section id="category-section" class="section-content mb-4">
  <div class="container">
    <header class="section-heading py-4 d-flex justify-content-between align-items-center">
      <h3 class="section-title fs-4 fw-bold">Danh mục sản phẩm</h3>
    </header>
    <div class="row g-4">
      <c:forEach var="category" items="${requestScope.categories}">
        <div class="col-lg-3 col-md-4 col-sm-6">
          <div class="card shadow-sm">
            <div class="card-body">
              <a href="${pageContext.request.contextPath}/category?id=${category.id}" class="stretched-link text-decoration-none">
                <div class="d-flex align-items-center">
                  <c:choose>
                    <c:when test="${empty category.imageName}">
                      <img width="50" height="50" src="${pageContext.request.contextPath}/img/50px.png" alt="category-image" class="rounded-circle">
                    </c:when>
                    <c:otherwise>
                      <img width="50" height="50" src="${pageContext.request.contextPath}/image/${category.imageName}" alt="${category.imageName}" class="rounded-circle">
                    </c:otherwise>
                  </c:choose>
                  <span class="category-title ms-3 fs-5 fw-semibold">${category.name}</span>
                </div>
              </a>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</section>

<section id="new-products" class="section-content mb-5">
  <div class="container">
    <header class="section-heading py-4 d-flex justify-content-between align-items-center">
      <h3 class="section-title fs-4 fw-bold">Sản phẩm mới nhất</h3>
    </header>
    <div class="row g-4">
      <c:forEach var="product" items="${requestScope.products}">
        <div class="col-xl-3 col-lg-4 col-md-6">
          <div class="card p-3 shadow-sm">
            <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="img-wrap text-center">
              <c:choose>
                <c:when test="${empty product.imageName}">
                  <img width="200" height="200" class="img-fluid rounded" src="${pageContext.request.contextPath}/img/280px.png" alt="default-image">
                </c:when>
                <c:otherwise>
                  <img width="200" height="200" class="img-fluid rounded" src="${pageContext.request.contextPath}/image/${product.imageName}" alt="${product.imageName}">
                </c:otherwise>
              </c:choose>
            </a>
            <figcaption class="info-wrap mt-3">
              <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="title h5 text-decoration-none text-dark">${product.name}</a>
              <div class="d-flex justify-content-between align-items-center mt-2">
                <c:choose>
                  <c:when test="${product.discount == 0}">
                    <span class="price fw-bold text-success">
                      <fmt:formatNumber pattern="#,##0" value="${product.price}"/>₫
                    </span>
                  </c:when>
                  <c:otherwise>
                    <span class="price fw-bold text-danger">
                      <fmt:formatNumber pattern="#,##0" value="${product.price * (100 - product.discount) / 100}"/>₫
                    </span>
                    <span class="text-muted text-decoration-line-through">
                      <fmt:formatNumber pattern="#,##0" value="${product.price}"/>₫
                    </span>
                    <span class="badge bg-info text-white">
                      -<fmt:formatNumber pattern="#,##0" value="${product.discount}"/>%
                    </span>
                  </c:otherwise>
                </c:choose>
              </div>
            </figcaption>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</section>
<script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
<df-messenger
  intent="WELCOME"
  chat-title="Chat_box_WebBook"
  agent-id="b5fa1fb1-75eb-4cc2-83e9-32b585163786"
  language-code="en"
></df-messenger>
<jsp:include page="_footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>
