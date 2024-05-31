<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Asus ROG
  Date: 12/3/2023
  Time: 11:19 PM
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
<header id="main-header" class="py-2 bg-warning text-white">
    <div class="container">
        <div class="ro">
            <div class="col-md-6">
                <h1><i class="fas fa-users"></i> Users</h1>
            </div>
        </div>
    </div>
</header>

<!--Users-->
<section id="users" class="py-4 mb-4 bg-light">
    <div class="container">
        <div class="row">
            <div class="col-md-6 ml-auto">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search Users...">
                    <div class="input-group-append">
                        <button class="btn btn-warning">Search</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section id="actions" class="py-4 mb-4 bg-light">
    <div class="container">
        <div class="row">
            <!--<div class="col-md-3">
                <a href="#" class="btn btn-primary btn-block" data-toggle="modal" data-target="#addPostModal">
                    <i class="fas fa-plus"></i> Add Post
                </a>
            </div>
            <div class="col-md-3">
                <a href="#" class="btn btn-success btn-block" data-toggle="modal" data-target="#addCategoryModal">
                    <i class="fas fa-plus"></i> Add Category
                </a>
            </div>
            -->
            <div class="col-md-3">
                <a href="#" class="btn btn-warning btn-block" data-toggle="modal" data-target="#addUserModal">
                    <i class="fas fa-plus"></i> Add User
                </a>
            </div>
        </div>
    </div>
</section>


<!--Add User Modal-->
<div class="modal fade" id="addUserModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-warning text-white">
                <h5 class="modal-title">Add User</h5>
                <button class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="<%= request.getContextPath() %>/user/insert_UserController" method="post">

                    <input type="hidden" name="from" value=users>
                    <div class="form-group">
                        <label for="FullName">Full Name</label>
                        <input type="text" id = "FullName" name ="FullName" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="BirthDate">Birthday</label>
                        <input type="date" id = "BirthDate"  name ="BirthDate" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="Address">Address</label>
                        <input type="text" id = "Address"  name = "Address" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="Phone">Phone</label>
                        <input type="text" id = "Phone" name = "Phone" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="Email">Email</label>
                        <input type="email" id = "Email"  name = "Email" class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="Password">Password</label>
                        <input type="password" id = "Password" name = "Password" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="Role">Role</label>
                        <select id="Role" name = "Role" class ="form-control">
                            <option value="Customer">Customer</option>
                            <option value="Manager">Manager</option>
                        </select>
                    </div>
                    <input type="hidden" name="encodedImage" id="encodedImage" value="">
                    <div class="col-md-12 d-flex flex-column justify-content-center">
                        <div class="mb-3 text-center" style="height: 200px;">
                            <img id="image" src=""
                                 alt="Hình ảnh" class="img-fluid mx-auto d-block mw-100 mh-100">
                        </div>
                        <div class="text-center"><input type="file" id="selectImage" accept="image/*"></div>
                    </div>
                    <div class="modal-footer">
                        <button type = "submit" class="btn btn-warning">Save Add</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
<!--User Accounts-->
<section id="userAccounts">
    <div class="container" style="white-space:nowrap;">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header">
                        <h4>Latest Users</h4>
                    </div>
                    <table class="table table-striped">
                        <thead class="thead-dark">
                        <tr>
                            <th>UserID</th>
                            <th>FullName</th>
                            <th style="white-space:nowrap;" >Birthdate</th>
                            <th style="white-space:nowrap;">Address</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th></th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <c:forEach var = "user" items = "${listUser}">
                                <tr >
                            <td name="UserID" value ="${user.userID}">${user.userID}</td>
                            <td>${user.fullName}</td>
                            <td>${user.birthDate}</td>
                            <td>${user.address}</td>
                            <td>${user.phone}</td>
                            <td>${user.email}</td>
                            <td>${user.role}</td>
                            <td>
                                <a href="edit_UserController?UserID=<c:out value='${user.userID}' />"  class="btn btn-secondary">
                                    <i class="fas fa-angle-double-right"></i> Details
                                </a>
                            </td>
                            <td>
                                <a href="delete_UserController?UserID=<c:out value='${user.userID}' />" class="btn btn-secondary" style="background-color:indianred">
                                    <i class="fas fa-angle-double-right"></i> Delete
                                </a>
                            </td>
                            </c:forEach>
                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>

<!--Footer-->
<jsp:include page="./footer.jsp" />

<!--jQuery CDN-->
<jsp:include page="./scripts.jsp" />
<!--Custom JavaScript-->
<script>
    document.getElementById('selectImage').addEventListener('change', function(event) {
        var files = event.target.files;
        if (files && files.length > 0) {
            var reader = new FileReader();
            reader.onload = function() {
                var dataURL = reader.result;
                if (dataURL != null) {
                    document.getElementById('image').src = dataURL;
                    document.getElementById('encodedImage').value = dataURL;
                }
            };
            reader.readAsDataURL(files[0]);
        } else {
            console.error("No files selected or FileReader not supported.");
        }
    });
</script>
</body>

</html>
