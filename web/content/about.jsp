<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>2022 웹프로그래밍 프로젝트 - About project</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <script src="https://unpkg.com/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
    <script src="https://unpkg.com/jquery@3.6.0/dist/jquery.js"></script>
    <script src="https://unpkg.com/react@18/umd/react.production.min.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js"></script>

    <!-- Babel JSX interpreter -->
    <script src="https://unpkg.com/babel-standalone@6/babel.min.js"></script>

    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/css/custom/sticky-footer-navbar.css" rel="stylesheet">
</head>

<body class="d-flex flex-column h-100">

<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
                aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <ul class="navbar-nav me-auto mb-2 mb-md-0" id="page">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/" id="main">배당
                        정보(Home)</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page"
                       href="content/about.jsp" id="about">About</a>
                </li>
                <script src="${pageContext.request.contextPath}/js/construction.alert.js" type="text/babel"></script>
            </ul>
        </div>
    </div>
</nav>


<!-- Begin page content -->
<main class="flex-shrink-0">
    <div class="container">
        <div class="d-flex flex-column justify-content-start">
            <p class="fw-bold fs-3">Used library</p>
            <div id="list_body"></div>
        </div>
    </div>
</main>

<footer class="footer mt-auto py-3 bg-light">
    <div class="container">
        <span class="text-muted">2022 웹프로그래밍 프로젝트</span>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/content/about.js" type="text/babel"></script>
</body>
</html>
