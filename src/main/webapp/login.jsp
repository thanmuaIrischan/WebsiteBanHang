<%--
  Created by IntelliJ IDEA.
  User: Asus ROG
  Date: 12/3/2023
  Time: 11:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <form action="<%= request.getContextPath() %>/user/login" method="post">
              <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name ="email" class="form-control" value="${email}" required>
              </div>
              <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id= "password" name ="password" class="form-control" value="${password}" required>
              </div>
              <%
                String errMsg = (String) request.getAttribute("errMsg");
                if (errMsg != null) {
              %>
              <p class="text-danger"><%= errMsg %></p>
              <%
                }
              %>
              <input type="submit" value="Login" class="btn btn-primary btn-block">
              <a class="btn btn-primary btn-block" href="<%= request.getContextPath() %>/signup.jsp">Sign Up</a>
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
</body>

</html>
