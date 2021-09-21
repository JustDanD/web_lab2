import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ControllerServlet extends HttpServlet {
    private static JsonObject data;

    public static JsonObject getData() {
        return data;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("utf-8");
        try {
            data = new Gson().fromJson(req.getReader(), JsonObject.class);
            data.get("X").getAsFloat();
            data.get("Y").getAsFloat();
            data.get("R").getAsFloat();
            req.getRequestDispatcher("/check").forward(req, resp);
        }
        catch (Exception e) {
            resp.sendError(400);
        }
    }
}