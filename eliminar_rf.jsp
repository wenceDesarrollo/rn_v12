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

rset = stmt.executeQuery("SELECT dr.det_pro, dr.cant_sur, dr.can_sol, dr.id_rec, i.id_inv FROM usuarios us, unidades u, inventario i, detalle_productos dp, detreceta dr WHERE us.cla_uni = u.cla_uni and u.cla_uni = i.cla_uni and i.det_pro = dp.det_pro and dp.det_pro = dr.det_pro and us.id_usu = '"+request.getParameter("id_usu")+"' and dr.fol_det = '"+request.getParameter("fol_det")+"' ;");

while(rset.next()){
	out.println(rset.getString("det_pro"));
	out.println(rset.getString("cant_sur"));
	out.println(rset.getString("can_sol"));
	out.println(rset.getString("id_rec"));
	out.println(rset.getString("id_inv"));
	int cant=rset.getInt("cant_sur");
	rset2 = stmt2.executeQuery(("SELECT CANT FROM INVENTARIO WHERE id_inv = '"+rset.getString("id_inv")+"' "));
	while (rset2.next()){
		cant = cant + rset2.getInt("cant");
	}
	
	stmt2.execute(("UPDATE INVENTARIO SET CANT = '"+cant+"', web = '0' WHERE id_inv = '"+rset.getString("id_inv")+"';     "));
	stmt2.execute(("insert into kardex values ('0', '"+rset.getString("id_rec")+"', '"+rset.getString("det_pro")+"', '"+rset.getString("cant_sur")+"', 'ENTRADA RECETA', '-', NOW(), 'ENTRADA RECETA', '"+request.getParameter("id_usu")+"', '0')"));
	stmt2.execute(("update detreceta set baja = '1', can_sol = '0', cant_sur = '0' where fol_det = '"+request.getParameter("fol_det")+"'"));
	
}
response.sendRedirect("rf.jsp?tipo=RFA&id_usu="+request.getParameter("id_usu")+"&txtf_foliore="+request.getParameter("txtf_foliore")+"&receta_cap=1");

con.close();
%>