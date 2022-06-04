<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<% response.setStatus(200); %>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <title>500 Error</title>

  <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">
  <script src="https://unpkg.com/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>

  <!-- Custom styles for this template -->
  <link href="${pageContext.request.contextPath}/css/custom/sticky-footer-navbar.css" rel="stylesheet">
  <link href="error.css" rel="stylesheet">
</head>

<body class="d-flex flex-column h-100">
<!-- Begin page content -->
<main class="flex-shrink-0">
  <div class="container">
    <div class="ex-page-content bootstrap snippets bootdeys">
      <div class="container">
        <div class="row">
          <div class="col-sm-6">
            <svg class="svg-box" width="380px" height="500px" viewBox="0 0 837 1045" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:sketch="http://www.bohemiancoding.com/sketch/ns">
              <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" sketch:type="MSPage">
                <path d="M353,9 L626.664028,170 L626.664028,487 L353,642 L79.3359724,487 L79.3359724,170 L353,9 Z" id="Polygon-1" stroke="#3bafda" stroke-width="6" sketch:type="MSShapeGroup"></path>
                <path d="M78.5,529 L147,569.186414 L147,648.311216 L78.5,687 L10,648.311216 L10,569.186414 L78.5,529 Z" id="Polygon-2" stroke="#7266ba" stroke-width="6" sketch:type="MSShapeGroup"></path>
                <path d="M773,186 L827,217.538705 L827,279.636651 L773,310 L719,279.636651 L719,217.538705 L773,186 Z" id="Polygon-3" stroke="#f76397" stroke-width="6" sketch:type="MSShapeGroup"></path>
                <path d="M639,529 L773,607.846761 L773,763.091627 L639,839 L505,763.091627 L505,607.846761 L639,529 Z" id="Polygon-4" stroke="#00b19d" stroke-width="6" sketch:type="MSShapeGroup"></path>
                <path d="M281,801 L383,861.025276 L383,979.21169 L281,1037 L179,979.21169 L179,861.025276 L281,801 Z" id="Polygon-5" stroke="#ffaa00" stroke-width="6" sketch:type="MSShapeGroup"></path>
              </g>
            </svg>
          </div>

          <div class="col-sm-6">
            <div class="message-box">
              <h1 class="m-b-0">500</h1>
              <p>Internal Server Error.</p>
              <div class="buttons-con">
                <div class="action-link-wrap">
                  <a href="javascript:history.back()" class="btn btn-custom btn-info waves-effect waves-light m-t-20">뒤로가기</a>
                  <a href="/" class="btn btn-custom btn-info waves-effect waves-light m-t-20">메인 페이지로</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</main>

<footer class="footer mt-auto py-3 bg-light">
  <div class="container">
    <span class="text-muted">2022 웹프로그래밍 프로젝트</span>
  </div>
</footer>

</body>
</html>
