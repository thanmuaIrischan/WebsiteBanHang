<%--
  Created by IntelliJ IDEA.
  User: quyth
  Date: 12/19/2023
  Time: 2:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css"
          integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <title>Invoice</title>
    <style>
        .card-container {
            display: flex;
            flex-direction: column;
        }

        .card {
            flex-grow: 1;
            padding: 20px;
            margin-bottom: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .pagination {
            margin-top: auto;
        }
        #modalDetail {
            width: 80%;
            height: 50%;
            margin: 10% 0 0 10%; /* Đặt giá trị margin theo yêu cầu của bạn */
        }
    </style>
</head>

<body>
<!-- ... (Phần đầu trang HTML) ... -->
<jsp:include page="./header_admin.jsp" />
<header id="main-header" class="py-2 bg-primary text-white">
    <div class="container">
        <div class="ro">
            <div class="col-md-6">
                <h1><i class="fas fa-pencil-alt"></i> Posts</h1>
            </div>
        </div>
    </div>
</header>
<!--Posts-->
<section id="posts">
    <div class="container">
        <div class="row">
            <div class="col">
                <div class="card-container" id="card-container">
                    <div class="card">
                        <div class="card-header">
                            <h4>Invoice</h4>
                        </div>
                        <table class="table table-striped">
                            <thead class="thead-dark">
                            <tr>
                                <th>InvoiceID</th>
                                <th>OrderID</th>
                                <th>Total</th>
                                <th>TypePayment</th>
                                <th>Status</th>
                                <th>InvoiceDateTime</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <!---product 1---->
                            <c:forEach var="item" items="${lstData}">
                                <tr>
                                    <td>${item.invoiceID}</td>
                                    <td>${item.orderID}</td>
                                    <td>${item.total}</td>
                                    <td>${item.getTypePaymentString()}</td>
                                    <td class="status-column">${item.getStatusString()}</td>
                                    <td>${item.invoiceDateTime}</td>
                                    <td>
                                        <button type="button" class="detail-btn btn btn-primary" data-toggle="modal" data-target="" data-whever ="${item.orderID}" >Details</button>

                                        <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#exampleModal" data-1="${item.getStatus()}" data-2="${item.invoiceID}">Update</button>
                                    </td>
                                </tr>
                            </c:forEach>

                            </tbody>

                        </table>
                    </div>
                    <!--Pagination-->
                    <c:if test="${not empty lstData}">
                        <div class="pagination" id="pagination">
                            <c:url value="/admin/invoice" var="url">
                                <c:param name="page" value="${currentPage + 1}" />
                            </c:url>

                            <c:if test="${currentPage > 1}">
                                <c:url value="/admin/invoice" var="prevUrl">
                                    <c:param name="page" value="${currentPage - 1}" />
                                </c:url>
                                <a href="${prevUrl}" class="page-link">Previous</a>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:url value="/admin/invoice" var="pageUrl">
                                    <c:param name="page" value="${i}" />
                                </c:url>

                                <c:if test="${currentPage != i}">
                                    <a href="${pageUrl}" class="page-link">${i}</a>
                                </c:if>

                                <c:if test="${currentPage == i}">
                                    <strong><a href="${pageUrl}" class="page-link active">${i}</a></strong>
                                </c:if>
                            </c:forEach>

                            <c:url value="/admin/invoice" var="url">
                                <c:param name="page" value="${currentPage + 1}" />
                            </c:url>

                            <c:if test="${currentPage < totalPages}">
                                <a href="${url}" class="page-link">Next</a>
                            </c:if>
                        </div>
                    </c:if>

                </div>
            </div>
        </div>
    </div>
</section>

<%--modal update --%>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">New message</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="idinvoice" class="col-form-label">
                            InvoiceID:</label>
                        <input type="text" name="idinvoice" class="form-control" id="idinvoice" disabled>
                    </div>
                    <div class="form-group">
                        <label for="idstatus" class="col-form-label">Status:</label>
                        <select id="idstatus" name="idstatus" class="form-control">
                            <option value="0">Pedding</option>
                            <option value="1">Done</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="fConfirm()">Confirm</button>
            </div>
        </div>
    </div>
</div>
<%--modal details--%>
<div class="modal fade bd-example-modal-lg" id="modalDetail" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Detail Order</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="modal-detal">
                <table class="table table-striped" id="p-detail">
                    <thead class="thead-dark">
                    <tr>
                        <th>ProductID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                    </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>
<<!--Footer-->
<footer id="main-footer" class="bg-dark text-white mt-5 p-5">
    <div class="container">
        <div class="row">
            <div class="col">
                <p class="lead text-center">
                    Copyright &copy; <span id="year"></span>
                    Blogen
                </p>
            </div>
        </div>
    </div>
</footer>

<!--Custom JavaScript-->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        adjustCardContainerHeight();
    });

    window.addEventListener("resize", function () {
        adjustCardContainerHeight();
    });

    function adjustCardContainerHeight() {
        const windowHeight = window.innerHeight;
        const headerHeight = document.getElementById("main-header").offsetHeight;
        const footerHeight = document.getElementById("main-footer").offsetHeight;

        const cardContainer = document.getElementById("card-container");
        const paginationHeight = document.getElementById("pagination").offsetHeight;
        const cardContainerHeight = windowHeight - headerHeight - footerHeight - paginationHeight;
        cardContainer.style.height = cardContainerHeight + "px";
    }
</script>
<!-- ... (Phần cuối trang HTML) ... -->

</body>

<script>
    jQuery('#exampleModal').on('show.bs.modal', function (event) {
        var button = jQuery(event.relatedTarget) // Button that triggered the modal
        var idinvoice = button.data('2') // Extract info from data-* attributes
        var status = button.data('1')
        var modal = $(this)
        modal.find('.modal-title').text("Update Invoice")
        modal.find('#idinvoice').val(idinvoice)
        modal.find('#idstatus option').each(function () {
            if ($(this).val() == status) {
                $(this).prop('selected', true);
            } else {
                $(this).prop('selected', false);
            }
        });
    })
    jQuery('.detail-btn').on('click',function (event){
        var button = $(this);
        let url = window.location.href;
        var pdetail = jQuery("#p-detail").find('tbody');
        pdetail.empty();
        jQuery.ajax({
            url: url,
            method: "GET",
            data: {
                orderid: $(button).data('whever')
            },
            success: function (data) {
                console.log(data)
                jQuery(data).each(function (index, element) {
                    pdetail.append(`<tr class="row100 body"><td class="cell100 column1">\${element.productID}</td><td class="cell100 column2">\${element.name}</td><td class="cell100 column3">\${element.price}</td><td class="cell100 column4">\${element.quantity}</td></tr>`);
                });
                var modal = $(this);
                modal.find('.modal-body').html();
                $("#modalDetail").modal("show");
            },
            error: function (xhr, status, error) {
                console.error('Ajax request failed:', status, error);
            },
            done: function (){
            }
        })

    })

</script>
<script>
    function fConfirm() {
        let url = window.location.href;
        jQuery.ajax({
            url: url,
            method: "POST",
            data: {
                idinvoice: jQuery('#idinvoice').val(),
                status: jQuery('#idstatus').val()
            },
            success: function () {
                alert("success")
                var finstatus = $('button[data-2="' + jQuery('#idinvoice').val() + '"]').closest('tr').find('.status-column');
                finstatus.text(jQuery('#idstatus').val() == '1' ? 'Done' : 'Pending');
                $('#exampleModal').modal('hide');

            },
            error: function () {
                alert("ERROR !!!")
            }
        })
    }


</script>

</html>
