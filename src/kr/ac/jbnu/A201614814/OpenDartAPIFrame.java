package kr.ac.jbnu.A201614814;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Enumeration;

public class OpenDartAPIFrame extends HttpServlet {
    protected String buffer;
    protected URL url;

    /*
    크로스도메인 보안 이슈로 의한 API 호출 우회방법 (https://opendart.fss.or.kr/ --> FAQ 참조)
    OpenDartAPIwithZIP, OpenDartAPI의 부모 클래스로, 서블릿 공통 사용 부분 포함
     */
    protected void requestAPI(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String baseUrl = "https://opendart.fss.or.kr/api/";
        String urlString = "";
        Enumeration<String> params = request.getParameterNames();
        while (params.hasMoreElements()) {
            String key = params.nextElement();
            if (key.equals("service"))
                urlString = baseUrl.concat(request.getParameter(key)).concat("?");
            else {
                urlString = urlString.concat(key + "=" + request.getParameter(key));
                if (params.hasMoreElements())
                    urlString = urlString.concat("&");
            }
        }
        url = new URL(urlString);
        URLConnection connection = url.openConnection();
        connection.setRequestProperty("CONTENT-TYPE", "text/html");

        buffer = "";
    }

    protected void dispatch(HttpServletRequest request, HttpServletResponse response, String servlet) throws ServletException, IOException {
        getServletContext().getRequestDispatcher("/api/" + servlet + ".jsp").forward(request, response);
    }
}
