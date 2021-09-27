import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html");
        HttpSession session = req.getSession();
        ArrayList<String> history = new ArrayList<String>();
        float x = ControllerServlet.getData().get("X").getAsFloat();
        float y = ControllerServlet.getData().get("Y").getAsFloat();
        float r = ControllerServlet.getData().get("R").getAsFloat();
        boolean isSuccess;
        String response;
        isSuccess = (y >= 0 && x <= 0 && y <= x + r) || (y <= 0 && x >= 0 && y >= -r && x <= r) || (y <= 0 && x <= 0 && y >= -Math.sqrt((r) * (r) - x * x));

        if (!session.isNew() && session.getAttribute("history") != null) {
            try {
                history = (ArrayList<String>) session.getAttribute("history");
            } catch (Exception e) {
                history = new ArrayList<String>();
            }
        }
        history.add(Float.toString(x));
        history.add(Float.toString(y));
        history.add(Float.toString(r));
        history.add(isSuccess ? "Да" : "Нет");
        session.setAttribute("history", history);

        response = "Результат проверки:<br/><br/><table border='1px'><tr><th>X</th><th>Y</th><th>R</th><th>Попадание</th></tr><tr><td>"+ x
                +"</td><td>"+ y +"</td><td>"+ r +"</td><td>"+ (isSuccess ? "Да" : "Нет") +"</td></tr></table><br/><button onclick=\"window.location.href = '"+getServletContext().getContextPath()+"/controller';\">Назад в мир розовых единорогов</button>";
        resp.setStatus(200);
        resp.getWriter().println(response);
    }

}