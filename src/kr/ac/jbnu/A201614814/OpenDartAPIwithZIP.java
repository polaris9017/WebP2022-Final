package kr.ac.jbnu.A201614814;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

/*
API 호출 반환 형식이 ZIP 파일인 경우의 호출 서블릿
 */
@WebServlet("/api/OpenDARTwithZIP")
public class OpenDartAPIwithZIP extends OpenDartAPIFrame {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        requestAPI(request, response);
        unzip(request);
        request.setAttribute("result", buffer);
        dispatch(request, response, this.getClass().getSimpleName());
    }

    private void unzip(HttpServletRequest request) throws IOException {
        BufferedInputStream bis = new BufferedInputStream(url.openStream());
        ZipInputStream zis = new ZipInputStream(bis);

        ZipEntry entry = zis.getNextEntry();

        // 공시 문서와 고유번호 파일 인코딩 차이로 인한 구분
        InputStreamReader reader;
        if (request.getParameter("service").equals("corpCode.xml"))
            reader = new InputStreamReader(zis, StandardCharsets.UTF_8);
        else
            reader = new InputStreamReader(zis, "euc-kr");

        BufferedReader in = new BufferedReader(reader);

        buffer = in.lines().collect(Collectors.joining("\n"));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}