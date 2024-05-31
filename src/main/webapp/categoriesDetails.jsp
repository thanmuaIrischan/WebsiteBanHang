<%@ page import="com.cloud.Models.Category" %><%--
  Created by IntelliJ IDEA.
  User: Asus ROG
  Date: 12/3/2023
  Time: 11:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
<header id="main-header" class="py-2 bg-success text-white">
  <div class="container">
    <div class="ro">
      <div class="col-md-6">
        <h1><i class="fas fa-folder"></i> Category Details</h1>
      </div>
    </div>
  </div>
</header>

<!--Actions-->
<section id="actions" class="py-4 mb-4 bg-light">
  <div class="container">
    <div class="row">
      <div class="col-md-3">
        <a href="<%= request.getContextPath() %>/pro/list_product"  class="btn btn-light btn-block border">
          <i class="fas fa-arrow-left"></i> Back To Dashboard
        </a>
      </div>
      <div class="col-md-3">
        <a href="<%= request.getContextPath() %>/category/list_Category" class="btn btn-light btn-block border">
          <i class="fas fa-arrow-left"></i> Back To Categories
        </a>
      </div>
    </div>
  </div>
</section>

<!--Details-->
<!--Details-->
<%
  Category category = (Category) request.getAttribute("category");
%>
<section id="details">
  <div class="container">
    <div class="row">
      <div class="col">
        <div class="card">
          <div class="card-header">
            <h4>Edit Category Information</h4>
          </div>
          <div class="modal-body" >
            <form action="<%= request.getContextPath() %>/category/update_Category" method = "post" >
              <input type="hidden" name="from" value="CategoryDetails">
              <div class="form-group">
                <label for="CategoryID">Category ID</label>
                <input readonly type="text" value="<c:out value='<%=category.getCategoryID()%>' />" id = "CategoryID" name ="CategoryID"  class="form-control">
              </div>

              <div class="form-group">
                <label for="CategoryName">Category Name </label>
                <input type="text" value="<%=category.getCategoryName()%>" id = "CategoryName" name ="CategoryName" class="form-control">
              </div>
              <div class="form-group">
                <label for="DateAdd">Date Add</label>
                <input type="date" value="<%=category.getDateAdd()%>" id = "DateAdd"  name ="DateAdd" class="form-control">
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
  //CKEditor
  CKEDITOR.replace('editor1');
</script>
</body>

</html>
