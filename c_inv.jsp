<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
//  Conexión a la BDD -------------------------------------------------------------
Class.forName("org.gjt.mm.mysql.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset= null;
Statement stmt2 = con.createStatement();
ResultSet rset2= null;

rset = stmt.executeQuery("select * from c_inv;");

while(rset.next()){
	String det_pro="";
	rset2 = stmt2.executeQuery(("SELECT det_pro FROM detalle_productos WHERE cla_pro = '"+rset.getString("cla_pro")+"' "));
	while (rset2.next()){
		det_pro = rset2.getString("det_pro");
	}
	try{
	stmt2.execute(("insert into inventario values ('2014-01-01', '"+rset.getString("uni")+"', '"+det_pro+"', '0', '0');"));
	}catch (Exception e) {
	out.println(("insert into inventario values ('2014-01-01', '"+rset.getString("uni")+"', '"+det_pro+"', '0', '0');"));
	}
	
}
con.close();
%>