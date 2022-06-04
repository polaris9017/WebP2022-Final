class CorpCodeParser {
    constructor() {
        this.api_key = "f75aa37dfef583ae59bf7dadf9874f5bb715077d";
        this.doc = "";
    }

    // Frontend에서 처리하려 했으나 브라우저 Cross Origin 보안 이슈로 인해 다운로드 + 압축해제는 JSP 서블릿으로 넘김
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
        let url = window.location.origin + "/api/OpenDARTwithZIP?service=corpCode.xml&crtfc_key=" + this.api_key;
        request.open("GET", url, false);
        request.send();
    }

    query(attr, val) {
        this.load();
        if (this.doc === "") {
            alert("Empty Document!");
            return;
        }
        var xml_parse = $.parseXML(this.doc);
        var code_arr = [];

        $(xml_parse).find("result").find("list").each(function () {
            if ($(this).find(attr).text().includes(val) || val === $(this).find(attr).text()) {
                if ($(this).find("stock_code").text() !== " ") {
                    code_arr.push({
                        corp_code: $(this).find("corp_code").text(),
                        corp_name: $(this).find("corp_name").text(),
                        stock_code: $(this).find("stock_code").text()
                    });
                }
            }
        });
        return code_arr;
    }
}

function queryCode() {
    let doc = new CorpCodeParser();
    const query_type = document.getElementById('query_type').value;
    const query_str = document.getElementById('query_str').value;
    return doc.query(query_type, query_str)
}

function renderList() {
    const arr_json = queryCode();

    document.getElementById('radio_list').innerHTML = "";
    arr_json.forEach(function (value, index) {
        const list_code = "list_radio-" + value['corp_code'];
        const format_body = "<input class=\"form-check-input\" type=\"radio\" name=\"flexRadioDefault\" id=\"" + list_code + "\" " +
            "value= \"" + value['corp_name'] + '_' + value['corp_code'] + "\">";

        //리스트 임시 컨테이너 DOM
        const template = document.createElement('li');
        template.setAttribute('class', 'list-group-item d-flex justify-content-between align-items-start');
        template.innerHTML = format_body;

        //리스트 항목
        const div_item = document.createElement('div');
        div_item.setAttribute('class', 'ms-2 me-auto');
        div_item.innerHTML = "<div class=\"fw-bold\"><label class=\"form-check-label\" for=\"" + list_code + "\" aria-label=\"" + value['corp_name'] + "\">" + value['corp_name'] + "</label></div>"
            + "종목코드: " + value['stock_code'];

        template.appendChild(div_item);
        document.getElementById('radio_list').appendChild(template);
    });
}

document.getElementById('query_button').addEventListener('click', () => {
    if (document.getElementById('query_str').value === "") {
        alert('조회할 항목을 입력하세요!');
    } else if (isNaN(document.getElementById('query_str').value) && document.getElementById('query_type').value === 'stock_code') {
        alert('잘못된 입력값입니다.');
    } else {
        // 결과 div 표시되어 있는 경우 숨김
        if (!document.getElementById('container_info').classList.contains('invisible'))
            document.getElementById('container_info').classList.toggle('invisible');

        const modal = new bootstrap.Modal('#selectModal');
        modal.toggle();  // Modal 수동 출력
        renderList();
    }
});
