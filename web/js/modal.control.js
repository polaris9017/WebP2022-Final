class DividendInfoParser {
    constructor(corp_code, year, report_code = "11011") {
        this.api_key = "f75aa37dfef583ae59bf7dadf9874f5bb715077d";
        this.corp_code = corp_code;
        this.bsns_year = year;
        this.report_code = report_code;  //기본값은 11011(사업보고서), 원하는 경우에는 변경 가능
        this.doc = "";
    }

    // Frontend에서 처리하려 했으나 브라우저 Cross Origin 보안 이슈로 인해 다운로드는 JSP 서블릿으로 넘김
    load() {
        let request = new XMLHttpRequest();
        var _this = this;

        request.onload = function () {
            if (request.readyState === request.DONE)
                //파일 시작 부분 공백으로 인한 오류 방지
                _this.doc = request.responseText.replace(/^\s*/, '').replace(/\s*$/, '');
        }
        request.onerror = function () {
            alert("Error while getting document.");
        }
        const url = window.location.origin +
            "/api/OpenDART?service=alotMatter.json&crtfc_key=" + this.api_key + "&corp_code=" + this.corp_code +
            "&bsns_year=" + this.bsns_year + "&reprt_code=" + this.report_code;
        request.open("GET", url, false);
        request.send();
    }

    query() {
        this.load();
        if (this.doc === "") {
            alert("Empty Document!");
            return;
        }
        const json_parse = JSON.parse(this.doc);
        let code_arr = [];
        let _this = this;

        if (json_parse['status'] === "000") {  //정상적으로 불러올때만 저장
            json_parse['list'].forEach(function (key) {
                if (key['se'] === "주당 현금배당금(원)") {
                    code_arr.push(
                        {
                            stock_knd: key['stock_knd'],
                            [_this.bsns_year]: key['thstrm'],
                            [_this.bsns_year - 1]: key['frmtrm'],
                            [_this.bsns_year - 2]: key['lwfr']
                        }
                    );
                }
            });
        }

        return code_arr;
    }
}

document.getElementById('apply_button').addEventListener('click', () => {
    const modal = new bootstrap.Modal('#selectModal');
    modal.hide();  // Modal 수동 닫기
});

var myModalEl = document.getElementById('selectModal');
myModalEl.addEventListener('hide.bs.modal', function (event) {  //Modal 닫힐 때
    const radio_selected = $('#radio_list input:radio:checked').val();
    const radioVal = radio_selected.split('_')[0];
    const nameVal = radio_selected.split('_')[1];

    const label_template_code = "<label for=\"query_str\" class=\"text-truncate fw-light\" style=\"max-width: 100%\">고유 코드</label>";
    const input_template_code = "<input class=\"form-control text-truncate\" id=\"corp_code_text\" type=\"text\" value=\"" + nameVal + "\" readonly >";
    const label_template_name = "<label for=\"query_str\" class=\"text-truncate fw-light\" style=\"max-width: 100%\">기업명</label>";
    const input_template_name = "<input class=\"form-control text-truncate\" id=\"corp_name_text\" type=\"text\" value=\"" + radioVal + "\" readonly >";

    document.getElementById('corp_name_div').innerHTML = label_template_name + input_template_name;
    document.getElementById('corp_code_div').innerHTML = label_template_code + input_template_code;

    // 결과 div 숨김 해제
    document.getElementById('container_info').classList.toggle('invisible');

    const year = document.getElementById('query_year').value;
    const corp_code = document.getElementById('corp_code_text').value;
    let parser = new DividendInfoParser(corp_code, year);

    let arr = parser.query();

    //내부 초기화
    document.getElementById('span_div_first').innerHTML = "";
    document.getElementById('span_div_norm').innerHTML = "";
    document.getElementById('span_div_pref').innerHTML = "";
    document.getElementById('span_div_tail').innerHTML = "";
    document.getElementById('span_none').innerText = "";
    document.getElementById('table_div').innerText = ""

    document.getElementById('span_year').innerText = year + "년 ";

    //배당 내역 출력
    if (arr.length < 1 || arr[0][year.toString()] === "-") {
        document.getElementById('span_none').innerText = "받은 배당금이 없네요😥";
    } else {
        document.getElementById('span_div_first').innerHTML = "<span class=\"fs-5\">기준 지급 배당금은 </span>";
        document.getElementById('span_div_tail').innerHTML = "<span class=\"fs-5\"> 이에요.</span>";
        let div_text_norm = "";  //보통주
        let div_text_pref = "";  //우선주

        arr.forEach(function (value) {
            if (value['stock_knd'] === '보통주' || value['stock_knd'] === '보통주식' && value[year.toString()] !== "-") {
                div_text_norm = "<span class=\"fs-5\">보통주</span>" + "<span class=\"fs-1 text-warning fw-semibold\"> " + value[year.toString()] + "</span>원"
            } else if (value['stock_knd'] === '우선주' || value['stock_knd'] === '우선주식' && value[year.toString()] !== "-") {
                if (arr.length === 2)
                    div_text_pref += "<span class=\"fs-5\">, </span>"
                div_text_pref = "<span class=\"fs-5\">우선주</span>" + "<span class=\"fs-1 text-warning fw-semibold\"> " + value[year.toString()] + "</span>원";
            }
        });

        document.getElementById('span_div_norm').innerHTML = div_text_norm;
        document.getElementById('span_div_pref').innerHTML = div_text_pref;

        //3개년 목록 출력
        for (let i = 0;i<3;i++){
            let template = document.createElement('template');

            template.innerHTML = "<tr>"
                + "<th scope=\"row\">" + (year - i).toString() + "</th>"
                + "<td>" + arr[0][(year - i).toString()] + "</td>"
                + "<td>" + arr[1][(year - i).toString()] + "</td>"
                + "</tr>";

            document.getElementById('table_div').appendChild(template.content.firstChild);
        }
    }
})