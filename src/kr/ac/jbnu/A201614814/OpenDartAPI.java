package kr.ac.jbnu.A201614814;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/*
API 호출 반환 형식이 평문인 경우의 호출 서블릿
 */
@WebServlet("/api/OpenDART")
public class OpenDartAPI extends OpenDartAPIFrame {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        requestAPI(request, response);
        write();
        request.setAttribute("result", buffer);
        dispatch(request, response, this.getClass().getSimpleName());
    }

    private void write() throws IOException {
        BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
        String inputLine;
        while ((inputLine = in.readLine()) != null) {
            buffer += inputLine.trim();
        }
        in.close();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}