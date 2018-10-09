<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "com.mysql.jdbc.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<sql:query dataSource="jdbc/employees" var="result">
    SELECT * FROM employees
</sql:query>

<sql:query dataSource="jdbc/employees" var="employees">
    SELECT * FROM employees WHERE emp_no = ?
    <sql:param value="${param.emp_no}" />
</sql:query>

<!DOCTYPE html>
<!--update-->
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employee</title>
</head>
<body>
<h1>Employee <c:out value="${param.emp_no}"/></h1>
<c:forEach var="e" items="${employees.rows}">
    <form action="Employee-Controller">
        <input type="hidden" name="cmd" value="u"/>
        <input type="hidden" name="emp_no" value='<c:out value="${e.emp_no}"/>'/>
        <table>
            <tr>
                <td>Birth Date</td>
                <td><input type="date" name="birth_date" value='<c:out value="${e.birth_date}"/>'></td>
            </tr>
            <tr>
                <td>First name</td>
                <td><input type="text" name="first_name" value='<c:out value="${e.first_name}"/>'></td>
            </tr>
            <tr>
                <td>Last name</td>
                <td><input type="text" name="last_name" value='<c:out value="${e.last_name}"/>'></td>
            </tr>
            <tr>
                <td>Gender</td>
                <td><input type="text" name="gender" value='<c:out value="${e.gender}"/>'></td>
            </tr>
            <tr>
                <td>Hire Date</td>
                <td><input type="date" name="hire_date" value='<c:out value="${e.hire_date}"/>'></td>
            </tr>

            <td colspan="2">
                <input type="submit" value="Update">
            </td>
            </tr>
        </table>
    </form>
</c:forEach>

</body>
</html>