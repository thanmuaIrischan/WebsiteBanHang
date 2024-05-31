<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Your Shopping Cart</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap icons-->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
            rel="stylesheet"
    />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

    <style>
        #cart-total {
            border: none;
            font-family: inherit;
            font-size: inherit;
            padding: 0;
            width: auto;
            text-align: right;
            color: inherit;
        }
    </style>
</head>
<body>
<!-- Navigation-->
<jsp:include page="homepage_navbar.jsp"/>
<!-- Section-->
<section class="h-100 h-custom">
    <div class="container h-100 py-5">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col">
                <div class="table-responsive">
                    <c:choose>
                        <c:when test="${cartEmpty != null}">
                            <h2 class="text-center ">${cartEmpty}</h2>
                        </c:when>
                        <c:when test="${cartEmpty == null}">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th scope="col">Item</th>
                                    <th scope="col">Price</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Subtotal</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${cart}" var="item">
                                    <tr cart-id="${item.cartID}">
                                        <th scope="row">
                                            <div class="d-flex align-items-center">
                                                <img src="data:image/jpeg;base64, ${item.base64ProductImage}" class="img-fluid rounded-3" style="width: 100px; height: 100px;" alt="...">
                                                <div class="flex-column ms-4">
                                                    <p class="mb-2">${item.productName}</p>
                                                    <p class="mb-2" style="font-weight: 300;">Stock: ${item.productStock}</p>
                                                </div>
                                            </div>
                                        </th>
                                        <td class="align-middle">
                                            <p class="mb-0" style="font-weight: 300;">${item.productPrice}</p>
                                        </td>
                                        <td class="align-middle">
                                            <div class="d-flex flex-row">
                                                <button class="btn btn-link px-2"
                                                        onclick="this.parentNode.querySelector('input[type=number]').stepDown()">
                                                    <i class="bi bi-dash-lg"></i>
                                                </button>
                                                <input id="input-quantity" min="0" max="${item.productStock}" name="quantity" value="${item.quantity}" type="number"
                                                       class="form-control form-control-sm" style="width: 50px;" />

                                                <button class="btn btn-link px-2"
                                                        onclick="this.parentNode.querySelector('input[type=number]').stepUp()">
                                                    <i class="bi bi-plus-lg"></i>
                                                </button>
                                            </div>
                                        </td>
                                        <td class="align-middle">
                                            <p class="mb-0" style="font-weight: 500;">${item.quantity * item.productPrice}</p>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                    </c:choose>
                </div>

                <div class="card shadow-2-strong mb-5 mb-lg-0" style="border-radius: 16px;">
                    <div class="card-body p-4">
                        <div class="row">
                            <div class="col">
                                <form id="frmCreateOrder" method="post">
                                    <div class="d-flex justify-content-between mb-4" style="font-weight: 500;">
                                        <label for="cart-total" class="mb-2">Total</label>
                                        <input id="cart-total" class="mb-2" name="amount" value="100000" readonly>
                                    </div>

                                    <hr class="my-4">

                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="typepayment" id="payment--cod" value="0" checked>
                                        <label class="form-check-label" for="payment--cod">
                                            COD
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="typepayment" id="payment--vnpay" value="1">
                                        <label class="form-check-label" for="payment--vnpay">
                                            VNPAY
                                        </label>
                                    </div>

                                    <button type="submit" class="order-confirm btn btn-primary btn-block btn-lg w-auto">
                                        <div class="d-flex justify-content-between">
                                            <span>Confirm Order</span>
                                        </div>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Footer-->
<footer class="py-5 bg-dark">
    <div class="container">
        <p class="m-0 text-center text-white">
            Copyright &copy; Your Website 2023
        </p>
    </div>
</footer>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>
<script>
    $("document").ready(function () {
        let cartTotal = 0;
        let cartItems = $("tr[cart-id]");
        cartItems.each(function () {
            let quantity = $(this).find("#input-quantity").val();
            let price = $(this).find("td:nth-child(2)").text();
            let subtotal = quantity * price;
            cartTotal += subtotal;
        });
        $("#cart-total").val(cartTotal);
    });

    $("#frmCreateOrder").submit(function (event) {
        event.preventDefault();

        var postData = $("#frmCreateOrder").serialize();
        let vnpayChecked = $("#payment--vnpay").is(":checked");

        $.ajax({
            type: "POST",
            url: "${pageContext.request.getContextPath()}/order?action=new",
            data: postData,
            success: function (x) {
                alert("Success! Your order has been processed.");
                if (vnpayChecked) {
                    vnpayAjax();
                } else {
                    window.location.href = "${pageContext.request.getContextPath()}/home";
                }
            },
            error: function () {
                // Handle errors here
                alert("Error occurred while processing the order. Please try again.");
            }
        });
    });

    function vnpayAjax() {
        var postData = $("#frmCreateOrder").serialize();

        $.ajax({
            type: "POST",
            url: "${pageContext.request.getContextPath()}/vnpayajax",
            data: postData,
            dataType: 'JSON',
            success: function (x) {
                if (x.code === '00') {
                    if (window.vnpay) {
                        vnpay.open({width: 768, height: 600, url: x.data});
                    } else {
                        location.href = x.data;
                    }
                } else {
                    alert(x.Message);
                }
            },
            error: function () {
                alert("Error occurred during VNPAY processing. Please try again.");
            }
        });
    }

</script>
</body>
</html>
