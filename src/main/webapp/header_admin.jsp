<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.cloud.Models.User" %>
<%@ page import="com.cloud.Models.Session" %>
<html>
<body>
<c:if test="${empty Session.email}">
    <c:set var="errMsg" value="You need to login first" />
    <c:redirect url="./login.jsp" />
</c:if>
<nav class="navbar navbar-expand-sm navbar-dark bg-dark p-0">
    <div class="container">
        <a href="<%= request.getContextPath() %>/pro/list_product" class="navbar-brand">Fasion Shop</a>
        <button class="navbar-toggler" data-toggle="collapse" data-target=  "#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <ul class="navbar-nav">
                <li class="nav-item px-2">
                    <a href="<%= request.getContextPath() %>/pro/dashboard" class="nav-link active">Dashboard</a>
                </li>
                <li class="nav-item px-2">
                    <a href="<%= request.getContextPath() %>/pro/list_product" class="nav-link">Posts</a>
                </li>
                <li class="nav-item px-2">
                    <a href="<%= request.getContextPath() %>/category/list_Category" class="nav-link">Categories</a>
                </li>
                <li class="nav-item px-2">
                    <a href="<%= request.getContextPath() %>/user/list_UserController" class="nav-link">Users</a>
                </li><li class="nav-item px-2">
                <a href="<%= request.getContextPath() %>/admin/invoice" class="nav-link">Invoices</a>
            </li>

            </ul>

            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown mr-3">
                    <a href="<%= request.getContextPath() %>/index_admin.jsp" class="nav-link dropdown-toggle" data-toggle="dropdown">
                        <i class="fas fa-user"></i> ${Session.fullName}
                    </a>
                    <div class="dropdown-menu">
                        <a href="<%= request.getContextPath() %>/profile.jsp" class="dropdown-item">
                            <i class="fas fa-user-circle"></i> Profile
                        </a>
                    </div>
                </li>
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/user/logout_UserController" class="nav-link">
                        <i class="fas fa-user-times"></i> Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>
</body>
</html>
