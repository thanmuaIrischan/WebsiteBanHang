<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Base64"%>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Shop Homepage - Start Bootstrap Template</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap icons-->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
            rel="stylesheet"
    />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet" />
</head>
<body>
<!-- Navigation-->
<jsp:include page="homepage_navbar.jsp"/>
<!-- Header-->
<header class="bg-dark py-5">
    <div class="container px-4 px-lg-5 my-5">
        <div class="text-center text-white">
            <h1 class="display-4 fw-bolder">Shoes On Popular</h1>
        </div>
    </div>
</header>
<!-- Section-->
<section class="py-5">
    <div class="container px-4 px-lg-5 mt-5">
        <div
                class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
            <!---Product 1-->
            <c:forEach var="product" items="${listProduct}">
                <div class="col mb-5">
                    <div class="card h-100">
                        <!-- Sale badge-->
                        <c:if test="${product.discount != 0}">
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">
                                Sale
                            </div>
                        </c:if>
                        <!-- Product image-->
                        <c:if test="${product.image==null}">
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                        </c:if><c:if test="${product.image!=null}">
                        <img class="card-img-top" src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(product.getImage())}" alt="..." />
                    </c:if>
                        <!-- Product details-->
                        <div class="card-body p-4">
                            <div class="text-center">
                                <!-- Product name-->
                                <h5 class="fw-bolder">${product.name}</h5>

                                <c:if test="${product.discount != 0}">
                                <span class="text-muted text-decoration-line-through">
                                <fmt:formatNumber value="${product.price}" type="number" pattern="#,##0.##" />VNĐ
                                </span>
                                </c:if>
                                <!-- Làm tròn giá nếu có giảm giá -->
                                <fmt:formatNumber value="${(100 - product.discount) * product.price / 100}" type="number" pattern="#,##0.##" />
                                VNĐ

                            </div>
                        </div>
                        <!-- Product actions-->
                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                            <div class="text-center">
                                <a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>
<!-- Footer-->
<footer class="py-5 bg-dark">
    <div class="container">
        <p class="m-0 text-center text-white">
            Copyright &copy; Shoe Store 2023
        </p>
    </div>
</footer>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>
</body>
</html>
