<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.DecimalFormat" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%
// Conexion BDD via JDBC
Class.forName("org.gjt.mm.mysql.Driver"); 
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset=null;
// fin conexion --------
String lote="", caduca_mes="", but="";
rset = stmt.executeQuery("select p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, i.cant, o.des_ori FROM unidades u, inventario i, detalle_productos dp, productos p, origen o where u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro and dp.cla_pro = p.cla_pro AND dp.id_ori = o.id_ori ");

try {
	but = "" + request.getParameter("submit");
	lote = "" + request.getParameter("lote");
	caduca_mes=""+request.getParameter("caduca_mes");
	if (caduca_mes==null || caduca_mes.equals("0") || caduca_mes.equals("null") || caduca_mes.equals(""))
		{
			caduca_mes="100";
		}
	int cad_mes=Integer.parseInt(caduca_mes);
	Calendar calendar = Calendar.getInstance();
	calendar.add (Calendar.MONTH, cad_mes);
	String fecha_act=""+df.format(calendar.getTime());
	if (but.equals("Omitir Existencias en 0")){
		if (lote.equals("on")){
			rset = stmt.executeQuery("select p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro,  i.cant, o.des_ori FROM unidades u, inventario i, detalle_productos dp, productos p, origen o where u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro and dp.cla_pro = p.cla_pro AND dp.id_ori = o.id_ori  and dp.cad_pro < '"+fecha_act+"' and i.cant != 0 order by p.cla_pro asc ");
		} else {
			rset = stmt.executeQuery("select p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro,  sum(i.cant) as cant, o.des_ori FROM unidades u, inventario i, detalle_productos dp, productos p, origen o where u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro and dp.cla_pro = p.cla_pro AND dp.id_ori = o.id_ori and  dp.cad_pro < '"+fecha_act+"' and i.cant != 0 group by p.cla_pro order by p.cla_pro asc");
		}
	} if (but.equals("Existencias con 0")){
		if (lote.equals("on")){
			rset = stmt.executeQuery("select p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, i.cant, o.des_ori FROM unidades u, inventario i, detalle_productos dp, productos p, origen o where u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro and dp.cla_pro = p.cla_pro AND dp.id_ori = o.id_ori  and dp.cad_pro < '"+fecha_act+"' order by p.cla_pro asc");
		} else {
			rset = stmt.executeQuery("select p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro,  sum(i.cant) as cant, o.des_ori FROM unidades u, inventario i, detalle_productos dp, productos p, origen o where u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro and dp.cla_pro = p.cla_pro AND dp.id_ori = o.id_ori  and dp.cad_pro < '"+fecha_act+"'  group by p.cla_pro order by p.cla_pro asc");
		}
	}
} catch (Exception e) {
	System.out.print("not");
}

// ------------------------------------------------------------------
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.: INVENTARIO UNIDAD:.</title>
<script language="javascript" src="list02.js">
function close1()
{//alert("huge");
top.close();  
/*if(navigator.appName=="Microsoft Internet Explorer") { 
this.focus();self.opener = this;self.close(); } 
else { window.open('','_parent',''); window.close(); } 

*/
}
</script>
<script>
function foco_inicial(){
if (document.form.txtf_clave2.value==""){
document.form.txtf_clave.focus();
}
else
{
document.form.txtf_cant.focus();
}
}
</script>
<link rel="stylesheet" href="mm_restaurant1.css" type="text/css" />
<style type="text/css">
<!--
body {
	background-color: #E6E6E6;
}
.style1 {color: #000000}
.style2 {
	font-size: 8px;
	color: #009999;
}
.style5 {font-size: 36}
.Estilo8 {
	color: #FFFBF0;
	font-weight: bold;
}
.Estilo9 {font-size: 14px}
.Estilo10 {
	font-size: 12px;
	font-weight: bold;
}
.Estilo11 {font-size: 12px}
.Estilo12 {
	font-size: 14px;
	font-weight: bold;
	text-align: center;
}
.Estilo13 {color: #009999}
.Estilo14 {color: #FFFFFF; font-size: 14px; }
-->
</style></head>
<body onLoad="foco_inicial();">
<table width="850" height="346" border="3" align="center" cellpadding="2" bgcolor="#FFFFFF">
  <tr>
    <td width="650"><form id="form" name="form" method="post" action="inv_lyc.jsp?cla_uni=<%=request.getParameter("cla_uni")%>">
        <a href="index.jsp">Regresar a Menú </a>
        <table width="836" height="227" border="0" align="center" cellpadding="2">
        <tr>
          <td height="90" colspan="8" bgcolor="#FFFFFF" class="logo style1">
            <div align="center">
  <img src="imagenes/nay_ima1.jpg" width="142" height="72" />
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="Arriba" id="Arriba"></a>&nbsp;Inventario Unidad&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <img src="imagenes/ssn.jpg" width="162" height="78" />
            </div></td>
          </tr>
        <tr>
          <td height="14" colspan="8" bgcolor="#D51045"><span class="style2"><span class="Estilo8"><!--span class="Estilo9">Exportar&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span--><!--img src="icono_excel.gif" border="0" usemap="#Map2"/-->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span class="Estilo8">&nbsp;&nbsp;<span class="Estilo8"><a href="#Total" class="Estilo8">Ir a Totales</a></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Exportar a Excel&nbsp;&nbsp;<img src="imagenes/exc.jpg" width="37" height="29" usemap="#Map" border="0" /></span></td>
          </tr>
        <tr>
          <td height="33">&nbsp;</td>
          <td class="bodyText" style="text-align:right">Pr&oacute;ximos a Caducar en <input type="text" name="caduca_mes" size="1" value = "" /> meses &nbsp;&nbsp;&nbsp;&nbsp;
            <input type="checkbox" name="lote" id="lote"  <%if(lote.equals("on")){out.println("checked='checked'");}%>  />
            <label for="lote" >Separar x Lote</label></td>
          <td colspan="4" align="center"><input name="submit" type="submit" class="subHeader" value="Omitir Existencias en 0" />&nbsp;&nbsp;<input name="submit" type="submit" class="subHeader" value="Existencias con 0" /></td>
          </tr>
        <tr>
          
          <td height="33"><div align="center">CLAVE</div></td>
          <td class="bodyText"><div align="center">DESCRIPCI&Oacute;N</div></td>
          <td><div align="center">LOTE</div></td>
          <td>CADUCIDAD</td>
          <td align="center">CAJAS</td>
          <td><div align="center">ORIGEN</div></td>
        </tr>
        <%
		while(rset.next()){
			String lot_pro = rset.getString("lot_pro");
			String cad_pro = df2.format(df.parse(rset.getString("cad_pro")));
			if (!lote.equals("on")){
				lot_pro="---";
				cad_pro="---";
			}
		%>
        <tr>
          <td width="85" height="20" ><div align="center"><%=rset.getString("cla_pro")%></div></td>
          <td width="360" class="bodyText" align="center"><%=rset.getString("des_pro")%></td>
          <td width="120"><div align="center" class="Estilo10"><%=lot_pro%></div></td>
          <td width="77" align="center"><%=cad_pro%></td>
          <td width="85" align="center"><span class="Estilo10"><%=rset.getString("cant")%></span></td>
          <td width="71"><div align="center"><%=rset.getString("des_ori")%></div></td>
          <td><div ></div></td>
        </tr>
		<%
		}
		%>
		<tr>
		<td height="22"><a href="#Arriba">Ir al Inicio</a></td>
		<td>
		  <p align="right" class="Estilo9">&nbsp;</p>		  </td>
		<td><div align="right" class="Estilo12"></div></td>
		<td><span class="Estilo9"><strong><a name="Total" id="Total"></a>Total</strong></span></td>
		<td align="center"><span class="Estilo10"></span></td>
			<td><div align="center" class="Estilo11"> 
			 &nbsp;
		    </div></td>
		</tr>
      </table>
          </form>
    </td>
  </tr>
</table>
<map name="Map" id="Map">
<area shape="poly" coords="241,165" href="#" />
<area shape="poly" coords="230,40,231,88,270,43" href="#" />
<area shape="rect" coords="0,3,38,29" href="gnr_inv_lyc.jsp?caduca_mes=<%=caduca_mes%>&lote=<%=lote%>&submit=<%=request.getParameter("submit")%>&cla_uni=<%=request.getParameter("cla_uni")%>" />
</map>
<map name="Map2" id="Map2">
  <area shape="rect" coords="4,2,31,28" href="repor_inventario.jsp?boton=Show ALL" />
</map>
</body>
</html>
<%
con.close();
%>