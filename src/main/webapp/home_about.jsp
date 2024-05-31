<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>About Us - Cloud Shop</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet" />
</head>

<body>
<!-- Navigation-->
<jsp:include page="homepage_navbar.jsp"/>
<!-- Include your navigation code here -->

<!-- Header-->
<header class="bg-dark py-5">
    <div class="container px-4 px-lg-5 my-5">
        <div class="text-center text-white">
            <h1 class="display-4 fw-bolder">About Shoe Shop</h1>
        </div>
    </div>
</header>

<!-- Section-->
<section class="py-5">
    <div class="container px-4 px-lg-5 mt-5">
        <div class="row">
            <div class="col-lg-6">
                <h2 class="display-4 fw-bolder">Our Story</h2>
                <p class="lead">Trang web bán giày được lên ý tưởng và thực hiện bởi các thành viên của nhóm
                    nhằm thực hiện 1 trang web bán giày sử dụng Google App Engine.
                </p>
            </div>
            <div class="col-lg-6">
                <h2 class="display-4 fw-bolder">Mission & Vision</h2>
                <p class="lead">Chúng tôi cam kết mang đến trải nghiệm mua sắm giày tốt nhất cho khách hàng của mình. Chúng tôi không chỉ cung cấp những đôi giày chất lượng hàng đầu mà còn tạo ra một không gian mua sắm độc đáo, nơi mà sự đa dạng, sáng tạo và phong cách được tôn trọng. Chúng tôi hình dung một cộng đồng nơi mọi người không chỉ tìm thấy đôi giày hoàn hảo phản ánh phong cách và cá nhân của họ, mà còn được tạo ra để tỏa sáng và tự tin mỗi ngày.</p>
            </div>
        </div>
    </div>
</section>

<!-- Footer-->
<footer class="py-5 bg-dark">
    <div class="container">
        <p class="m-0 text-center text-white">
            Copyright &copy; Cloud Shop 2023
        </p>
    </div>
</footer>

<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>
</body>

</html>
