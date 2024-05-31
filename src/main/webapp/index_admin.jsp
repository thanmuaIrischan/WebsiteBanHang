<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Asus ROG
  Date: 12/3/2023
  Time: 11:15 PM
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
                <h1><i class="fas fa-cog"></i> Dashboard</h1>
            </div>
        </div>
    </div>
</header>

<!--Actions
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
-->
<!--Posts-->
<section id="posts">
    <div class="container">
        <div class="row">
            <div class="col-md-9">
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
                            <!--<td>
                                <a href="delete_product?ProductID=<c:out value='${product.productID}' />" class="btn btn-secondary" style="background-color:indianred">
                                    <i class="fas fa-angle-double-right"></i> Delete
                                </a>
                            </td>-->
                        </tr>
                        </c:forEach>
                        <!---Post 1--->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-center bg-primary text-white mb-3">
                    <div class="card-body">
                        <h3>Posts</h3>
                        <h4 class="display-4">
                            <i class="fas fa-pencil-alt"></i>
                        </h4>
                        <a href="<%= request.getContextPath() %>/pro/list_product" class="btn btn-outline-light btn-sm">View</a>
                    </div>
                </div>

                <div class="card text-center bg-success text-white mb-3">
                    <div class="card-body">
                        <h3>Categories</h3>
                        <h4 class="display-4">
                            <i class="fas fa-folder"></i>
                        </h4>
                        <a  href="<%= request.getContextPath() %>/category/list_Category" class="btn btn-outline-light btn-sm">View</a>
                    </div>
                </div>

                <div class="card text-center bg-warning text-white mb-3">
                    <div class="card-body">
                        <h3>Users</h3>
                        <h4 class="display-4">
                            <i class="fas fa-users"></i>
                        </h4>
                        <a href="<%= request.getContextPath() %>/user/list_UserController"
                           class="btn btn-outline-light btn-sm">View</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!--Footer-->
<jsp:include page="./footer.jsp" />

<!--Modals-->
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
                            <input type="file" class="custom-file-input" id="Image" name = "Image">
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

</body>

</html>