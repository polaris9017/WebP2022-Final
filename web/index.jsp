<%@ page import="java.util.List" %>
<%@ page import="java.util.stream.IntStream" %>
<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<html lang="en" class="h-100">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>2022 웹프로그래밍 프로젝트 - 홈</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <script src="https://unpkg.com/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
    <script src="https://unpkg.com/jquery@3.6.0/dist/jquery.js"></script>
    <script src="https://unpkg.com/react@18/umd/react.production.min.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js"></script>

    <!-- Babel JSX interpreter -->
    <script src="https://unpkg.com/babel-standalone@6/babel.min.js"></script>

    <!-- Custom styles for this template -->
    <link href="css/custom/sticky-footer-navbar.css" rel="stylesheet">
</head>
<body class="d-flex flex-column h-100">

<header>
    <!-- Fixed navbar -->
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
                    <script src="js/construction.alert.js" type="text/babel"></script>
                </ul>
            </div>
        </div>
    </nav>
</header>

<!-- Begin page content -->
<main class="flex-shrink-0">
    <div class="container">
        <div id="alert_area"></div>
        <div class="bg-light d-flex flex-column p-3 rounded" id="container">
            <div class="flex-row row-cols-4 mb-3 justify-content-between bg-body input-group">
                <div class="col-sm-auto mt-2 mb-3 mx-1">
                    <label for="query_type" class="text-truncate fw-light" style="max-width: 100%">구분</label>
                    <select class="form-select" id="query_type">
                        <option value="corp_name">회사명</option>
                        <option value="stock_code">종목 코드</option>
                    </select>
                </div>
                <div class="col-sm-2 mt-2 mb-3 mx-1">
                    <label for="query_str" class="text-truncate fw-light" style="max-width: 100%">회사명/종목 코드</label>
                    <input type="text" class="form-control flex-grow-1" id="query_str">
                </div>
                <div class="col-sm-2 mt-2 mb-3 mx-1" id="corp_name_div"></div>
                <div class="col-sm-2 mt-2 mb-3 mx-1" id="corp_code_div"></div>
                <div class="col-sm-2 mt-2 mb-3 mx-1" id="bsns_year_div">
                    <label for="query_type" class="text-truncate fw-light" style="max-width: 100%">조회 연도</label>
                    <%
                        //https://stackoverflow.com/questions/16711147/populating-a-list-with-a-contiguous-range-of-integers
                        List<Integer> arr_year = IntStream.range(2015, LocalDate.now().getYear()).boxed().toList();
                    %>
                    <select class="form-select" id="query_year">
                        <%
                            for (int year : arr_year) {
                                if (year == LocalDate.now().getYear() - 1)
                                    out.println("<option value=\"" + year + "\" selected>" + year + "</option>");
                                else
                                    out.println("<option value=\"" + year + "\">" + year + "</option>");
                            }
                        %>
                    </select>
                </div>
                <div class="col-sm-auto mt-2 mb-3 mx-1">
                    <button type="button" class="btn btn-primary mt-2 p-3 text-truncate" style="max-width: 100%"
                            id="query_button">조회
                    </button>
                </div>

                <div class="col-12">
                    <p class="fs-6 fw-semibold">2015년 이후 자료만 조회 가능하며, 조회하는 정보는 사업보고서를 기준으로 합니다.</p>
                </div>
            </div>

            <div class="modal fade" id="selectModal" data-bs-backdrop="static" data-bs-keyboard="false">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">목록 선택</h5>
                        </div>
                        <div class="modal-body overflow-auto">
                            <ul class="list-group" id="radio_list"></ul>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" id="apply_button" data-bs-toggle="modal">선택
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="bg-light d-flex flex-column p-3 rounded invisible" id="container_info">
            <div class="card">
                <div class="card-body text-center">
                    <p id="div_result">
                        <span class="fs-5" id="span_year"></span>

                        <span class="fs-5" id="span_div_first"></span>
                        <span class="fs-1 text-warning fw-semibold" id="span_div_norm"></span>
                        <span class="fs-1 text-warning fw-semibold" id="span_div_pref"></span>
                        <span class="fs-5" id="span_div_tail"></span>

                        <span class="fs-5" id="span_none"></span>
                    </p>

                    <p class="card-text fs-6 mt-3 fw-semibold">아래는 최근 3년간의 지급 내역입니다.</p>
                    <div class="card">
                        <h5 class="card-header">최근 3년 지급 내역</h5>
                        <div class="card-body">
                            <table class="table table-bordered table-hover card-text">
                                <thead>
                                <tr>
                                    <th scope="col">연도</th>
                                    <th scope="col">배당금(보통주)</th>
                                    <th scope="col">배당금(우선주)</th>
                                </tr>
                                </thead>
                                <tbody class="table-group-divider" id="table_div">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="js/corpCode.js"></script>
        <script src="js/modal.control.js"></script>
        <script src="js/construction.alert.js"></script>
    </div>
</main>

<footer class="footer mt-auto py-3 bg-light">
    <div class="container">
        <span class="text-muted">2022 웹프로그래밍 프로젝트</span>
    </div>
</footer>

</body>
</html>
