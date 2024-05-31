<%--
  Created by IntelliJ IDEA.
  User: Asus ROG
  Date: 12/3/2023
  Time: 11:16 PM
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
        <h1><i class="fas fa-folder"></i> Categories</h1>
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
          <input type="text" class="form-control" placeholder="Search Categories...">
          <div class="input-group-append">
            <button class="btn btn-success">Search</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<!--Actions-->
<section id="actions" class="py-4 mb-4 bg-light">
  <div class="container">
      <div class="col-md-3">
        <a href="#" class="btn btn-success btn-block" data-toggle="modal" data-target="#addCategoryModal">
          <i class="fas fa-plus"></i> Add Category
        </a>
      </div>
  </div>
</section>


<!--Add Category Modal-->
<div class="modal fade" id="addCategoryModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title">Add Category</h5>
        <button class="close" data-dismiss="modal">
          <span>&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="<%= request.getContextPath() %>/category/Insert_Categories" method="post">

          <div class="form-group">
            <label for="CategoryName">Category Name :</label>
            <input type="text" id = "CategoryName" name ="CategoryName" class="form-control">
          </div>
          <div class="form-group">
            <label for="DateAdd">Date Add :</label>
            <input type="date" id = "DateAdd"  name ="DateAdd" class="form-control">
          </div>
          <div class="modal-footer">
            <button type = "submit" class="btn btn-warning">Save Add</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<!--Categories-->
<section id="Categories">
  <div class="container" style="white-space:nowrap;">
    <div class="row">
      <div class="col">
        <div class="card">
          <div class="card-header">
            <h4>Latest Categories</h4>
          </div>
          <table class="table table-striped">
            <thead class="thead-dark">
            <tr>
              <th>CategoryID</th>
              <th>CategorieName</th>
              <th style="white-space:nowrap;" >DateAdd</th>
              <th></th>
              <th></th>
            </tr>
            </thead>
            <tbody>
            <tr>
              <c:forEach var = "category" items = "${listcategory}">
            <tr >
              <td name="CategoryID" value ="${category.categoryID}">${category.categoryID}</td>
              <td>${category.categoryName}</td>
              <td>${category.dateAdd}</td>
              <td>
                <a href="ShowFormEdit_Categories?CategoryID=<c:out value='${category.categoryID}' />"  class="btn btn-secondary">
                  <i class="fas fa-angle-double-right"></i> Details
                </a>
              </td>
              <td>
                <a href="delete_Categories?CategoryID=<c:out value='${category.categoryID}' />" class="btn btn-secondary" style="background-color:indianred">
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
</body>

</html>
