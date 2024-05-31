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
<nav class="navbar navbar-expand-sm navbar-dark bg-dark p-0">
    <div class="container">
        <a href="index.jsp" class="navbar-brand">Cloud Shop</a>
    </div>
</nav>

<!--Header-->
<header id="main-header" class="py-2 bg-primary text-white">
    <div class="container">
        <div class="ro">
            <div class="col-md-6">
                <h1><i class="fas fa-user"></i> Login</h1>
            </div>
        </div>
    </div>
</header>

<!--Actions-->
<section id="actions" class="py-4 mb-4 bg-light">
    <div class="container">
        <div class="row">
        </div>
    </div>
</section>

<!--Login-->
<section id="login">
    <div class="container">
        <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="card">
                    <div class="card-header">
                        <span class="h4">Account Login</span>
                    </div>
                    <div class="card-body">
                        <form action="<%= request.getContextPath() %>/user/insert_UserController" method="post">

                            <input type="hidden" name="from" value="signup">
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
                                <input type="text" id = "Role" name = "Role" class="form-control" value="Customer" readonly>
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
                                <button type = "submit" class="btn btn-warning">Sign Up</button>
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
