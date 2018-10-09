<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "com.mysql.jdbc.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<script>
    function confirmDelete(emp_no) {
        if (confirm('Are you sure?')) {
            window.location = "Employee-Controller?cmd=d&emp_no="+emp_no;
        }
    }
</script>
<head>
    <title>Employees</title>
</head>
<body>
<h1>Employees</h1>

<sql:query dataSource="jdbc/employees" var="result">
    SELECT * FROM employees
    WHERE employees.emp_no = employees.emp_no
</sql:query>

<table border="1">
    <c:forEach var="row" items="${result.rows}">
        <tr>
            <td><c:out value="${row.emp_no}"/></td>
            <td><c:out value="${row.birth_date}"/></td>
            <td><c:out value="${row.first_name}"/></td>
            <td><c:out value="${row.last_name}"/></td>
            <td><c:out value="${row.gender}"/></td>
            <td><c:out value="${row.hire_date}"/></td>
            <td>
                <button onclick="window.location='employee-update.jsp?emp_no=<c:out value="${row.emp_no}"/>';">UPDATE</button>
                <button onclick="confirmDelete(<c:out value="${row.emp_no}"/>);">DELETE</button>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
