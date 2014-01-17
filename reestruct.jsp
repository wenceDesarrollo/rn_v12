<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.io.*" import="com.csvreader.CsvReader" import="javax.swing.*" import="java.util.Date" import="java.text.SimpleDateFormat" import="java.util.*" errorPage="" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%
// Conexion BDD via JDBC
Class.forName("org.gjt.mm.mysql.Driver"); 
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset=null;
Statement stmt2 = con.createStatement();
ResultSet rset2=null;
// fin conexion --------

rset = stmt.executeQuery("select * from receta where id_rec not in (select id_rec from detreceta);");
while (rset.next()){
	stmt2.execute("delete from receta where id_rec = '"+rset.getString("id_rec")+"'");
}

con.close();
response.sendRedirect("index.jsp");
%>