package Employee.Controller;

import javax.naming.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EmployeeServlet extends HttpServlet {

    public void init() throws ServletException {
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Deletion
        String id = request.getParameter("id");
        String cmd = request.getParameter("cmd");

        // Insertion
        String emp_no = request.getParameter("emp_no");
        String birth_date = request.getParameter("birth_date");
        String first_name = request.getParameter("first_name");
        String last_name = request.getParameter("last_name");
        String gender = request.getParameter("gender");
        String hire_date = request.getParameter("hire_date");

        // Set response content type
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Insertion
        out.println(emp_no+"<br/>");
        out.println(birth_date+"<br/>");
        out.println(first_name+"<br/>");
        out.println(last_name+"<br/>");
        out.println(gender+"<br/>");
        out.println(hire_date+"<br/>");

        Context envContext = null;
        try {
            envContext = new InitialContext();
            out.println(envContext+"<br>");
            Context initContext = envContext;
            DataSource ds = (DataSource)envContext.lookup("java:/comp/env/jdbc/employees");
            Connection con = ds.getConnection();

            String sql = "";
            if (cmd != null && cmd.equals("d")) {
                // Delete a product
                sql = "DELETE FROM employees WHERE emp_no = ?";
                PreparedStatement stmt = con.prepareStatement(sql);
                stmt.setInt(1, Integer.parseInt(emp_no));
                stmt.execute();
            } else if (cmd != null && cmd.equals("u")) {
                // Update a product
                sql = "UPDATE employees SET birth_date = ?, first_name = ?, last_name = ?, gender = ?, hire_date = ? WHERE emp_no = ?";
                PreparedStatement stmt=con.prepareStatement(sql);
                stmt.setDate(1, Date.valueOf(birth_date));
                stmt.setString(2,first_name);
                stmt.setString(3,last_name);
                stmt.setString(4, gender);
                stmt.setDate(5, Date.valueOf(hire_date));
                stmt.setInt(6, Integer.parseInt(emp_no));
                stmt.execute();
            } else {
                // Insert
                sql = "insert into employees (emp_no, birth_date, first_name, last_name, gender, hire_date)  values (?,?,?,?,?,?)";
                PreparedStatement stmt=con.prepareStatement(sql);
                stmt.setInt(1, Integer.parseInt(emp_no));
                stmt.setDate(2, Date.valueOf(birth_date));
                stmt.setString(3,first_name);
                stmt.setString(4,last_name);
                stmt.setString(5, gender);
                stmt.setDate(6, Date.valueOf(hire_date));
                stmt.execute();
            }

            response.sendRedirect("Employees.jsp");

        }  catch (SQLException | NamingException e) {
            e.printStackTrace();
            out.print(e);
        }
    }
}