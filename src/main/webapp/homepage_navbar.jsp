<%@ page import="com.cloud.Models.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.cloud.Models.Session" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css"
          integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
          integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
            rel="stylesheet"
    />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Shop Homepage - Start Bootstrap Template</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap icons-->

    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet" />
    <%
        String name ="" ;

        if(Session.fullName!= null){
            name = Session.fullName;
        }
        String action = request.getParameter("action");
        if(action == null) action = "";
    %>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container px-4 px-lg-5">

        <a class="navbar-brand" href="home">Fashion Shop</a>
        <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent"
                aria-expanded="false"
                aria-label="Toggle navigation"
        >
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="home">Home</a>
                </li>
                <li class="nav-item"><a class="nav-link" href="home?action=about">About</a></li>
                <li class="nav-item dropdown">
                    <a
                            class="nav-link dropdown-toggle"
                            id="navbarDropdown"
                            href="#"
                            role="button"
                            data-bs-toggle="dropdown"
                            aria-expanded="false"
                    >Shop</a
                    >
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="home?action=all">All Products</a></li>
                        <li>
                            <hr class="dropdown-divider"/>
                        </li>
                        <li>
                            <a class="dropdown-item" href="home?action=hot"
                            >Popular Items</a
                            >
                        </li>
                        <li><a class="dropdown-item" href="home?action=new-arrival">New Arrivals</a></li>
                    </ul>
                </li>
            </ul>
            <%
                if(action.equals("all") || action.equals("new-arrival") || action.equals("hot")){
            %>

            <form class="d-flex mx-auto" action="home" method="get">
                <input type="hidden" name="action" value=<%= action %> >
                <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="search" value="${searchValue}">
                <button class="btn btn-outline-dark" type="submit">
                    <i class="bi-search"></i>
                </button>
            </form>
            <%
                };
            %>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown mr-3">
                    <a
                            href="#"
                            class="nav-link dropdown-toggle"
                            data-toggle="dropdown"
                    >
                        <i class="fas fa-user"></i> Welcome <%= name%>
                        <!--Placeholder Username-->
                    </a>
                    <div class="dropdown-menu">
                        <a href="profile.jsp" class="dropdown-item">
                            <i class="fas fa-user-circle"></i> Profile
                        </a>
                        <a href="settings.jsp" class="dropdown-item">
                            <i class="fas fa-cog"></i> Settings
                        </a>
                    </div>
                </li>
                <li class="nav-item">
                    <a href="<%=request.getContextPath()%>/user/logout_UserController" class="nav-link">
                        <i class="fas fa-user-times"></i> Logout
                    </a>
                </li>
            </ul>
            <form class="d-flex">
                <a class="btn btn-outline-dark" href="${pageContext.request.getContextPath()}/cart?action=list">
                    <i class="bi-cart-fill me-1"></i>
                    Cart
                    <span class="badge bg-dark text-white ms-1 rounded-pill"></span>
                </a>
            </form>
        </div>
    </div>
</nav>
<!--jQuery CDN-->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>

<!--popper js CDN-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>

<!--Bootstrap 4 CDN-->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
        integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
        crossorigin="anonymous"></script>

<!--CKEditor CDN-->
<script src="https://cdn.ckeditor.com/4.15.1/standard/ckeditor.js"></script>
</body>
</html>
