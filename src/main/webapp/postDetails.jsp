<%--
  Created by IntelliJ IDEA.
  User: Asus ROG
  Date: 12/3/2023
  Time: 11:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<header id="main-header" class="py-2 bg-primary text-white">
  <div class="container">
    <div class="ro">
      <div class="col-md-6">
        <h1><i class="fas fa-pencil-alt"></i> Post Details</h1>
      </div>
    </div>
  </div>
</header>

<!--Actions-->
<section id="actions" class="py-4 mb-4 bg-light">
  <div class="container">
    <div class="row">
      <div class="col-md-3">
        <a href="index.jsp" class="btn btn-light btn-block border">
          <i class="fas fa-arrow-left"></i> Back To Dashboard
        </a>
      </div>
      <div class="col-md-3">
        <a href="posts.jsp" class="btn btn-light btn-block border">
          <i class="fas fa-arrow-left"></i> Back To Posts
        </a>
      </div>
      <div class="col-md-3">
        <a href="index.jsp" class="btn btn-success btn-block">
          <i class="fas fa-check"></i> Save Changes
        </a>
      </div>
      <div class="col-md-3">
        <a href="index.jsp" class="btn btn-danger btn-block">
          <i class="fas fa-trash"></i> Delete Post
        </a>
      </div>
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
            <h4>Edit Post</h4>
          </div>
          <div class="card-body">
            <form action="<%= request.getContextPath() %>/pro/update_product" method = "post" >
              <input type="hidden" name="from" value="productDetails">
              <div class="form-group">
                <label for="ProductID">Product ID</label>
                <!--
                                Có hai cách lấy giá trị cho value:
                                    value="<c:out value='${product.productID}' />"
                                    value="${product.name}"
                                 -->
                <input readonly type="text" value="<c:out value='${Product.productID}'/>" id = "ProductID" name ="ProductID"  class="form-control">
              </div>
              <div class="form-group">
                <label for="name">Name</label>
                <input type="text" value="${Product.name}" id="Name" name = "Name" class="form-control">
              </div>
              <div class="form-group">
                <label for="Price">Price</label>
                <input type="text" value="${Product.price}" id="Price" name = "Price" class="form-control">
              </div>
              <div class="form-group">
                <label for="Stock">Stock</label>
                <input type="text" value="${Product.stock}" id="Stock" name = "Stock" class="form-control">
              </div>
              <div class="form-group">
                <label for="CategoryID">Category</label>
                <input type="text" value="${Product.categoryID}" id="CategoryID" name = "CategoryID" class="form-control">
              </div>
              <div class="form-group">
                <label for="image">Upload Image</label>
                <div class="custom-file">
                  <input type="hidden" name="encodedImage" id="encodedImage" value="${Base64.getEncoder().encodeToString(Product.getImage())}">
                  <input type="file" class="custom-file-input" id="Image" name="Image" onchange="handleImageChange()">
                  <label for="Image" class="custom-file-label">Choose File</label>

                </div>
                <small class="form-text text-muted">Max Size 3mb</small>
              </div>
              <div class="form-group">
                <label for="DateAdd">Date Add</label>
                <input type="date" value="${Product.dateAdd}" id = "DateAdd"  name ="DateAdd" class="form-control">
              </div>
              <div class="form-group">
                <label for="Description">Description</label>
                <textarea id="Description" name="Description" class="form-control">${Product.description}</textarea>
              </div>

              <div class="form-group">
                <label for="Rate">Rate</label>
                <input type="text" value="${Product.rate}" id="Rate" name = "Rate" class="form-control">
              </div>
              <div class="modal-footer">
                <button type = "submit" class="btn btn-warning">Save Add</button>
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
  function handleImageChange() {
    var inputElement = document.getElementById('Image');
    var files = inputElement.files;

    if (files && files.length > 0) {
      var reader = new FileReader();

      reader.onload = function () {
        var dataURL = reader.result;

        if (dataURL != null) {
          document.getElementById('encodedImage').value = dataURL;
        }
      };

      reader.readAsDataURL(files[0]);
    } else {
      console.error("No files selected or FileReader not supported.");
    }
  }

</script>
</body>

</html>