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

rset = stmt.executeQuery("select id_rec from receta;");
while (rset.next()){
	out.println("update receta set id_rec = '"+(Integer.parseInt(rset.getString(1))+5500000)+"' where id_rec = '"+Integer.parseInt(rset.getString(1))+"'");
	out.println("<br>");
}

rset = stmt.executeQuery("select fol_det from detreceta;");
while (rset.next()){
	out.println("update detreceta set fol_det = '"+(Integer.parseInt(rset.getString(1))+5500000)+"' where fol_det = '"+Integer.parseInt(rset.getString(1))+"'");
	out.println("<br>");
}

rset = stmt.executeQuery("select det_pro from detalle_producto;");
while (rset.next()){
	out.println("update detalle_producto set det_pro = '"+(Integer.parseInt(rset.getString(1))+5500000)+"' where det_pro = '"+Integer.parseInt(rset.getString(1))+"'");
	out.println("<br>");
}

rset = stmt.executeQuery("select id_kardex from kardex;");
while (rset.next()){
	out.println("update kardex set id_kardex = '"+(Integer.parseInt(rset.getString(1))+5500000)+"' where id_kardex = '"+Integer.parseInt(rset.getString(1))+"'");
	out.println("<br>");
}

rset = stmt.executeQuery("select id_inv from inventario;");
while (rset.next()){
	out.println("update inventario set id_inv = '"+(Integer.parseInt(rset.getString(1))+5500000)+"' where id_inv = '"+Integer.parseInt(rset.getString(1))+"'");
	out.println("<br>");
}

try{
} catch(Exception e) {
}
con.close();
//response.sendRedirect("index.jsp");
%>