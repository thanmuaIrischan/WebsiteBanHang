<%@ page import="com.cloud.Models.User" %><%--
  Created by IntelliJ IDEA.
  User: Asus ROG
  Date: 12/3/2023
  Time: 11:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Base64"%>
<%@ page import="com.cloud.Models.Session" %>
<%@ page import="com.cloud.Daos.UserDao" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <jsp:include page="./css.jsp" />
    <title>Admin Dashboard</title>
</head>

<body>

<%
    int  userid = Session.userID;
    User userLogin = new UserDao().selectUserById(userid);
%>

<%
if (userLogin.getRole().equals("Manager"))
{


%>

<jsp:include page="admin_navbar.jsp"/>
<%
    }else{
%>
    <jsp:include page="homepage_navbar.jsp"/>
<%
    };
%>

<!--Header-->
<header id="main-header" class="py-2 bg-primary text-white">
    <div class="container">
        <div class="ro">
            <div class="col-md-6">
                <h1><i class="fas fa-user"></i> Edit Profile</h1>
            </div>
        </div>
    </div>
</header>

<!--Actions-->
<section id="actions" class="py-4 mb-4 bg-light">
    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <a href="index.jsp" class="btn btn-primary btn-block">
                    <i class="fas fa-arrow-left"></i> Back To Dashboard
                </a>
            </div>
            <div class="col-md-3">
                <a href="#" class="btn btn-success btn-block" data-toggle="modal" data-target="#changePasswordModal">
                    <i class="fas fa-lock"></i> Change Password
                </a>
            </div>
        </div>
    </div>
</section>

<!--Profile-->
<section id="profile">
    <div class="container">
        <div class="row">
            <div class="col-md-9">
                <div class="card">
                    <div class="card-header">
                        <h4>Edit Profile</h4>
                    </div>
                    <div class="card-body">
                        <form action="<%= request.getContextPath() %>/user/update_UserController" method = "post">
                            <input type="hidden" name="from" value="profile">
                            <div class="form-group">
                                <label for="UserID">User ID</label>
                                <input readonly type="text" value="<%=userLogin.getUserID()%>" id = "UserID" name ="UserID"  class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="FullName">Name</label>
                                <input type="text" id="FullName" name="FullName" class="form-control" value="<%=userLogin.getFullName()%>">
                            </div>
                            <div class="form-group">
                                <label for="Email">Email</label>
                                <input type="email" value="<%=userLogin.getEmail()%>" id = "Email"  name = "Email" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="BirthDate">Birthday</label>
                                <input type="date" value="$<%=userLogin.getBirthDate()%>" id = "BirthDate"  name ="BirthDate" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="Address">Address</label>
                                <input type="text" value="<%=userLogin.getAddress()%>" id = "Address"  name = "Address" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="Phone">Phone</label>
                                <input type="text" value="<%=userLogin.getPhone()%>" id = "Phone" name = "Phone" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="Role">Role</label>
                                <select id="Role" class ="form-control" disabled>
                                    <option value="Customer" <%=userLogin.getRole().equals("Customer") ? "selected" : ""%>>Customer</option>
                                    <option value="Manager" <%=userLogin.getRole().equals("Manager") ? "selected" : ""%>>Manager</option>
                                    <input type="hidden" name="Role" value="<%=userLogin.getRole()%>">
                                </select>
                            </div>
                            <!-- Hình ảnh -->
                            <input type="hidden" name="encodedImage" id="encodedImage" value="<%=Base64.getEncoder().encodeToString(userLogin.getAvatar())%>">
                            <div class="col-md-12 d-flex flex-column justify-content-center">
                                <div class="mb-3 text-center" style="height: 200px;">
                                    <img id="image" src="data:image/jpeg;base64,<%=Base64.getEncoder().encodeToString(userLogin.getAvatar())%>"
                                         alt="Hình ảnh" class="img-fluid mx-auto d-block mw-100 mh-100">
                                </div>
                                <div class="text-center"><input type="file" id="selectImage" accept="image/*"></div>
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

<!--Change Password Modal-->
<div class="modal fade" id="changePasswordModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title">Change Password</h5>
                <button class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="oldPassword">Old Password</label>
                        <input type="password" id="oldPassword" name="oldPassword" class="form-control">
                        <p id="oldPasswordError" class="text-danger"></p>
                    </div>
                    <div class="form-group">
                        <label for="newPassword">New Password</label>
                        <input type="password" id="newPassword" name="newPassword" class="form-control">
                        <p id="newPasswordError" class="text-danger"></p>
                    </div>
                    <div class="form-group">
                        <label for="confirmNew">Confirm New Password</label>
                        <input type="password" id="confirmNew" name="confirmNew" class="form-control">
                        <p id="confirmNewError" class="text-danger"></p>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button id="btnChangePassword" type="submit" class="btn btn-success">Save Changes</button>
                <button  class="btn" data-dismiss="modal">Exit</button>
            </div>
        </div>
    </div>
</div>

<!--jQuery CDN-->
<jsp:include page="./scripts.jsp" />
<!--Custom JavaScript-->
<script>
    CKEDITOR.replace('editor1');
</script>
<script>
    $(document).ready(function(){
        $("#btnChangePassword").click(function(event){
            event.preventDefault();

            var oldPassword = $("#oldPassword").val();
            var newPassword = $("#newPassword").val();
            var confirmNew = $("#confirmNew").val();
            var userID = $("#UserID").val();
            if (oldPassword.trim() === "") {
                $("#oldPasswordError").text("Please enter old password");
                return;
            } else {
                $("#oldPasswordError").text("");
            }

            if (newPassword.trim() === "") {
                $("#newPasswordError").text("Please enter new password");
                return;
            } else {
                $("#newPasswordError").text("");
            }

            if (confirmNew.trim() === "") {
                $("#confirmNewError").text("Please confirm new password");
                return;
            } else {
                $("#confirmNewError").text("");
            }

            if (newPassword !== confirmNew) {
                $("#confirmNewError").text("Passwords do not match");
                return;
            } else {
                $("#confirmNewError").text("");
            }
            var requestData = {
                oldPassword: oldPassword,
                userID: userID
            };

            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/user/checkOldPassword_UserController",
                data: requestData,
                success: function(response, status, xhr){
                    var isPasswordValid = xhr.status === 200;
                    console.log(isPasswordValid);
                    if(isPasswordValid){
                        var encodedNewPassword = btoa(newPassword);
                        var encodedUserID = btoa(userID);

                        var redirectUrl = "<%=request.getContextPath()%>/user/updatePasswordProfile_UserController" +
                            "?newPassword=" + encodeURIComponent(encodedNewPassword) +
                            "&userID=" + encodeURIComponent(encodedUserID);

                        window.location.href = redirectUrl;

                    } else {
                        alert("Password change failed. Please check your old password.");
                    }
                },
                error: function(xhr, status, error){
                    console.error("Ajax request failed:", status, error);
                }
            });
        });
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
    });
</script>
<% if (request.getAttribute("resultMsg") != null) { %>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Thông báo</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                ${resultMsg}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Thoát</button>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript to trigger the modal -->
<script>
    $(document).ready(function() {
        console.log('Document ready function');
        $('#myModal').modal('show');
    });

</script>
<% } %>
</body>

</html>