<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Asus ROG
  Date: 12/3/2023
  Time: 11:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <jsp:include page="./css.jsp" />
    <title>Admin Dashboard</title>
</head>

<body>

<jsp:include page="./header_admin.jsp" />

<!--Header-->
<header id="main-header" class="py-2 bg-primary text-white">
    <div class="container">
        <div class="ro">
            <div class="col-md-6">
                <h1><i class="fas fa-pencil-alt"></i> Posts</h1>
            </div>
        </div>
    </div>
</header>

<!--Search-->
<section id="search" class="py-4 mb-4 bg-light">
    <div class="container">
        <div class="row">
            <div class="col-md-6 ml-auto">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search Posts...">
                    <div class="input-group-append">
                        <button class="btn btn-primary">Search</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<section id="actions" class="py-4 mb-4 bg-light">
    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <a href="#" class="btn btn-primary btn-block" data-toggle="modal" data-target="#addPostModal">
                    <i class="fas fa-plus"></i> Add
                </a>
            </div>

        </div>
    </div>
</section>
<!--Posts-->
<section id="posts">
    <div class="container">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header">
                        <h4>Latest Posts</h4>
                    </div>
                    <table class="table table-striped">
                        <thead class="thead-dark">
                        <tr>
                            <th>#</th>
                            <th>Title</th>
                            <th>Category</th>
                            <th>Date</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <!---Post 1--->
                        <c:forEach var="product" items="${listProduct}">
                            <tr>
                                <td name="ProductID" value ="${product.productID}">${product.productID}</td>
                                <td>${product.name}</td>
                                <td>${product.categoryID}</td>
                                <td>${product.dateAdd}</td>
                                <td>
                                    <a href="edit_product?ProductID=<c:out value='${product.productID}' />" class="btn btn-secondary">
                                        <i class="fas fa-angle-double-right"></i> Details
                                    </a>
                                </td>
                                <td>
                                    <a href="delete_product?ProductID=<c:out value='${product.productID}' />" class="btn btn-secondary" style="background-color:indianred">
                                        <i class="fas fa-angle-double-right"></i> Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <!---Post 1--->
                        </tbody>
                    </table>

                    <!--Pagination-->
                    <nav class="ml-4">
                        <ul class="pagination">
                            <li class="page-item disabled">
                                <a href="#" class="page-link">Previous</a>
                            </li>
                            <li class="page-item active">
                                <a href="#" class="page-link">1</a>
                            </li>
                            <li class="page-item">
                                <a href="#" class="page-link">2</a>
                            </li>
                            <li class="page-item">
                                <a href="#" class="page-link">3</a>
                            </li>
                            <li class="page-item">
                                <a href="#" class="page-link">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</section>

<!--Footer-->
<jsp:include page="./footer.jsp" />
<!--Add Product Modal-->
<div class="modal fade" id="addPostModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Add Product</h5>
                <button class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="<%= request.getContextPath() %>/pro/insert_product" method="post">
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" id="Name" name = "Name" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="Price">Price</label>
                        <input type="text" id="Price" name = "Price" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="Stock">Stock</label>
                        <input type="text" id="Stock" name = "Stock" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="CategoryID">Category</label>
                        <select id="CategoryID" name = "CategoryID" class="form-control">
                            <option value="2">2</option>
                            <option value="1">1</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="image">Upload Image</label>
                        <div class="custom-file">
                            <input type="hidden" name="encodedImage" id="encodedImage" value="${Base64.getEncoder().encodeToString(Product.getImage())}">
                            <input type="file" class="custom-file-input" id="Image" name="Image" onchange="handleImageChange()">
                            <label for="Image" class="custom-file-label">Choose File</label>
                        </div>
                        <small class="form-text text-muted">Max Size 3mb</small>
                    </div>
                    <div class="form-group">
                        <label for="DateAdd">Date Add</label>
                        <input type="date" id = "DateAdd"  name ="DateAdd" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="Description">Description</label>
                        <textarea id="Description" name = "Description" class="form-control"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="Rate">Rate</label>
                        <input type="text" id="Rate" name = "Rate" class="form-control">
                    </div>
                    <div class="modal-footer">
                        <button type = "submit" class="btn btn-warning">Save Add</button>
                    </div>

                </form>
            </div>

        </div>
    </div>
</div>
<!--jQuery CDN-->
<jsp:include page="./scripts.jsp" />
<!--Custom JavaScript-->
<script>
    function handleImageChange() {
        var inputElement = document.getElementById('Image');
        var files = inputElement.files;

        if (files && files.length > 0) {
            var reader = new FileReader();

            reader.onload = function () {
                var dataURL = reader.result;

                if (dataURL != null) {
                    document.getElementById('encodedImage').value = dataURL;
                }
            };

            reader.readAsDataURL(files[0]);
        } else {
            console.error("No files selected or FileReader not supported.");
        }
    }

</script>
</body>

</html>
