<%@ page import="com.cloud.Models.User" %><%--
  Created by IntelliJ IDEA.
  User: Asus ROG
  Date: 12/3/2023
  Time: 11:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Base64"%>
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
        <div class="row">
            <div class="col-md-6">
                <h1><i class="fas fa-user"></i> User Details</h1>
            </div>
        </div>
    </div>
</header>

<!--Actions-->
<section id="actions" class="py-4 mb-4 bg-light">
    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <a href="index_admin.jsp" class="btn btn-light btn-block border">
                    <i class="fas fa-arrow-left"></i> Back To Dashboard
                </a>
            </div>
            <div class="col-md-3">
                <a href="<%= request.getContextPath() %>/user/list_UserController" class="btn btn-light btn-block border">
                    <i class="fas fa-arrow-left"></i> Back To Users
                </a>
            </div>
            <!--
            <div class="col-md-3">
                <a href="users.jsp"  class="btn btn-success btn-block">
                    <i class="fas fa-check"></i> Save Changes
                </a>
            </div>
            <div class="col-md-3">
                <a href="users.jsp" class="btn btn-danger btn-block">
                    <i class="fas fa-trash"></i> Delete Changes
                </a>
            </div>
            -->
        </div>
    </div>
</section>



<!--Details-->
<section id="details">
    <div class="container">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header">
                        <h4>Edit User Information</h4>
                    </div>
                    <div class="modal-body" >
                        <form action="<%= request.getContextPath() %>/user/update_UserController" method = "post" >
                            <input type="hidden" name="from" value="userDetails">
                            <div class="form-group">
                                <label for="UserID">User ID</label>
                                <%--
                                <!--
                                Có hai cách lấy giá trị cho value:
                                    value="<c:out value='${User.userID}' />"
                                    value="${User.fullName}"
                                 -->
                                 --%>
                                <input readonly type="text" value="<c:out value='${User.userID}' />" id = "UserID" name ="UserID"  class="form-control">
                            </div>

                            <div class="form-group">
                                <label for="FullName">Full Name</label>
                                <input type="text" value="${User.fullName}" id = "FullName" name ="FullName" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="BirthDate">Birthday</label>
                                <input type="date" value="${User.birthDate}" id = "BirthDate"  name ="BirthDate" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="Address">Address</label>
                                <input type="text" value="${User.address}" id = "Address"  name = "Address" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="Phone">Phone</label>
                                <input type="text" value="${User.phone}" id = "Phone" name = "Phone" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="Email">Email</label>
                                <input type="email" value="${User.email}" id = "Email"  name = "Email" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="Password">Password</label>
                                <input type="password" value="${User.password}" id = "Password" name = "Password" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="password2">Confirm Password</label>
                                <input type="password" id = "password2" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="Role">Role</label>
                                <select id="Role" name = "Role" class ="form-control">
                                    <option value="Customer" ${User.role == 'Customer' ? 'selected' : ''}>Customer</option>
                                    <option value="Manager" ${User.role == 'Manager' ? 'selected' : ''}>Manager</option>
                                </select>
                            </div>

                            <!-- Hình ảnh -->
                            <input type="hidden" name="encodedImage" id="encodedImage" value="${encodedImage}">
                            <div class="col-md-12 d-flex flex-column justify-content-center">
                                <div class="mb-3 text-center" style="height: 200px;">
                                    <img id="image" src="data:image/jpeg;base64,${encodedImage}"
                                         alt="Avatar" class="img-fluid mx-auto d-block mw-100 mh-100">
                                </div>
                                <div class="text-center">
                                    <input type="file" id="selectImage" accept="image/*">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-success btn-block">
                                    Save Changes
                                </button>
                            </div>

                        </form>

                    </div>
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

    $(document).ready(function() {
        document.getElementById('selectImage').addEventListener('change', function (event) {
            console.log("Da click anh");
            var files = event.target.files;
            if (files && files.length > 0) {
                var reader = new FileReader();
                reader.onload = function () {
                    var dataURL = reader.result;
                    if (dataURL != null) {
                        console.log(dataURL);
                        document.getElementById('image').src = dataURL;
                        document.getElementById('encodedImage').value = dataURL;
                    }
                };
                reader.readAsDataURL(files[0]);
            } else {
                console.error("No files selected or FileReader not supported.");
            }
        });
    });
</script>
</body>

</html>
