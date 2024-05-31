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
<header id="main-header" class="py-2 bg-primary text-white">
    <div class="container">
        <div class="ro">
            <div class="col-md-6">
                <h1><i class="fas fa-cog"></i> Settings</h1>
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
                <a href="index.jsp" class="btn btn-success btn-block">
                    <i class="fas fa-check"></i> Save Changes
                </a>
            </div>
        </div>
    </div>
</section>

<!--settings-->
<section id="settings">
    <div class="container">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header">
                        <h4>Change Settings</h4>
                    </div>
                    <div class="card-body">
                        <form>
                            <fieldset class="form-group">
                                <legend>Allow User Registration</legend>
                                <div class="form-check">
                                    <label for="" class="form-check-label">
                                        <input type="radio" name="userRegistration" id="" class="form-check-input" value="Yes"> Yes
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label for="" class="form-check-label">
                                        <input type="radio" name="userRegistration" id="" class="form-check-input" value="No"> No
                                    </label>
                                </div>
                            </fieldset>
                            <fieldset class="form-group">
                                <legend>Home Page Format</legend>
                                <div class="form-check">
                                    <label for="" class="form-check-label">
                                        <input type="radio" name="pageFormat" id="" class="form-check-input" value="Posts"> Blogpage
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label for="" class="form-check-label">
                                        <input type="radio" name="pageFormat" id="" class="form-check-input" value="Page"> Homepage
                                    </label>
                                </div>
                            </fieldset>
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
