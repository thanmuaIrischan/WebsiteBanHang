<%--
  Created by IntelliJ IDEA.
  User: Asus ROG
  Date: 12/20/2023
  Time: 5:23 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<footer id="main-footer" class="bg-dark text-white mt-5 p-5">
    <div class="container">
        <div class="row">
            <div class="col">
                <p class="lead text-center">
                    Copyright &copy; <span id="year"></span>
                    Cloud Shoe Shop
                </p>
            </div>
        </div>
    </div>
</footer>
<script>
    // Get the current year for the copyright
    $('#year').text(new Date().getFullYear());

</script>
</body>
</html>
