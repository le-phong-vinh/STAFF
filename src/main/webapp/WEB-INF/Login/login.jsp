<%-- 
    Document   : login
    Created on : Oct 1, 2025, 11:46:46 AM
    Author     : Ho Gia Bao - CE191304
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/Include/header.jsp" />


 <div class="container flex-grow-1 my-5" style="">
                <h2 class="mb-4 text-center">Login to Your Account</h2>
                <!--<form class="mx-auto" style="max-width:400px;" onsubmit="return validateLoginForm();">-->
                <form class="mx-auto" style="max-width:400px;" method="post" action="${pageContext.request.contextPath}/login">
                    <div class="mb-3">
                        <label for="login-email" class="form-label">Username: </label>
                        <input type="text" id="login-email" class="form-control" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label for="login-pass" class="form-label">Password:</label>
                        <input type="password" id="login-pass" class="form-control" name="password" required>
                    </div>
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" value="remember-me" id="rememberMe">
                        <label class="form-check-label" for="rememberMe">Remember me</label>
                    </div>
                    <button class="btn btn-primary w-100" type="submit">Login</button>
                    <div class="mt-3 text-center">
                        <a href="${pageContext.request.contextPath}/register">Don't have an account? Register</a>
                    </div>
                </form>
            </div>

<jsp:include page="/WEB-INF/Include/footer.jsp" />