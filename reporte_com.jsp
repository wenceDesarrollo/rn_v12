<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<% 
//  Conexión a la BDD -------------------------------------------------------------
Class.forName("org.gjt.mm.mysql.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset= null;
// fin objetos de conexión --------------------------------------------------------
int sur1=0;
int sol1=0;

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<!-- DW6 -->
<head>
<script language="javascript" src="file:///C|/Program Files/Apache Group/Tomcat 4.1/webapps/r_n_v2/list02.js"></script>
<!-- Copyright 2005 Macromedia, Inc. All rights reserved. -->
<title>:: REPORTE VENTAS ::</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="file:///C|/Program Files/Apache Group/Tomcat 4.1/webapps/r_n_v2/mm_travel2.css" type="text/css" />
<script language="JavaScript" type="text/javascript">
//--------------- LOCALIZEABLE GLOBALS ---------------
var d=new Date();
var monthname=new Array("January","February","March","April","May","June","July","August","September","October","November","December");
//Ensure correct for language. English is "January 1, 2004"
var TODAY = monthname[d.getMonth()] + " " + d.getDate() + ", " + d.getFullYear();
//---------------   END LOCALIZEABLE   ---------------

//<script language="javascript" src="list02.js"></script>
<style type="text/css">
<!--
.style1 {
	color: #000000;
	font-weight: bold;
}
.style33 {
	font-size: x-small
}
.style40 {
	font-size: 9px
}
.style41 {
	font-size: 9
}
.style42 {
	font-family: Arial, Helvetica, sans-serif
}
.style32 {
	font-size: x-small;
	font-family: Arial, Helvetica, sans-serif;
}
.style43 {
	font-size: x-small;
	color: #FFFFFF;
	font-weight: bold;
}
.style47 {
	font-size: x-small;
	font-weight: bold;
}
.style49 {
	font-size: x-small;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.style50 {
	color: #000000
}
.style51 {
	color: #BA236A
}
.style58 {
	font-size: x-small;
	font-weight: bold;
	color: #666666;
}
.style66 {
	font-size: x-small;
	font-weight: bold;
	color: #333333;
}
a:hover {
	color: #333333;
}
.style68 {
	color: #CCCCCC
}
.style75 {
	color: #333333;
}
a:link {
	color: #711321;
}
.style76 {
	color: #003366
}
.style77 {
	color: #711321;
	font-weight: bold;
}
.Estilo1 {
	color: #FFFFFF
}
-->
</style>
</head>
<body bgcolor="#ffffff" onload="fillCategory2()">
<p> </p>
<table width="618" border="0" align="center" cellpadding="2">
  <tr>
    <td width="102"><img src="imagenes/nay_ima1.jpg" width="142" height="72" /></td>
    <td height="63" colspan="2" align="center" valign="bottom" nowrap="nowrap" bgcolor="#FFFFFF" id="logo"><div align="center"> <span class="style49"> SAVI DISTRIBUCIONES S.A DE C.V<br />
        REPORTE PARA COMPRAS<br />
        SOLICITADO CONTRA SURTIDO<br />
        DE LA UNIDAD: <br />
        <%
	  rset=stmt.executeQuery("select des_uni from unidades where cla_uni = '"+request.getParameter("cla_uni")+"'");
	  while(rset.next()){
		  out.println(rset.getString(1));
	  }
	  %><br />
    PERIODO: <%=df.format(df2.parse(request.getParameter("f1")))%> al <%=df.format(df2.parse(request.getParameter("f2")))%><br />
    </span>
        </span> </div></td>
    <td width="103"><img src="imagenes/ssn.jpg" width="162" height="78" /></td>
  </tr>
</table>
<table width="40%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="7" bgcolor="#003366"><img src="file:///C|/Program Files/Apache Group/Tomcat 4.1/webapps/r_n_v2/mm_spacer.gif" alt="" width="1" height="1" border="0" /></td>
  </tr>
  <tr bgcolor="#CCFF99">
    <td height="25" colspan="7" bgcolor="#D31145" id="dateformat">&nbsp;&nbsp;<span class="style76"> 
      <script language="JavaScript" type="text/javascript">
      //document.write(TODAY);	</script> 
      <a href="menu_compras.jsp" class="style76"><span class="Estilo1">Regresar a Menú</span></a></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="Estilo1">REPORTE PARA REPOSICI&Oacute;N / VENTAS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="imagenes/exc.jpg" width="37" height="29" usemap="#Map" border="0" /></span></td>
  </tr>
  <tr>
    <td colspan="7" bgcolor="#003366"><img src="mm_spacer.gif" alt="" width="1" height="1" border="0" /></td>
  </tr>
  <tr>
    <td colspan="2" valign="top"><form action="reporte_com.jsp" method="post" name="form" onSubmit="javascript:return ValidateAbas(this)">
        <table width="618" border="0" align="center">
          <tr>
            <td width="418"><table width="612" border="1">
                <tr>
                  <td width="56" align="center"><span class="style49">Clave </span></td>
                  <td width="193" align="center"><span class="style49">Descripci&oacute;n</span></td>
                  <td width="31" align="center"><span class="style49">Cant. Sol </span></td>
                  <td width="44" align="center"><span class="style49">Cant. Sur</span></td>
                </tr>
                <%
				try{
				rset = stmt.executeQuery("SELECT p.cla_pro, p.des_pro, sum(dr.can_sol) as sol, sum(dr.cant_sur) as sur FROM unidades un, usuarios us, receta r, detreceta dr, detalle_productos dp, productos p, bitacora bi where r.id_rec = bi.id_rec and un.cla_uni = us.cla_uni AND us.id_usu = r.id_usu AND r.id_rec = dr.id_rec AND dr.det_pro = dp.det_pro AND dp.cla_pro = p.cla_pro AND un.cla_uni = '"+request.getParameter("cla_uni")+"' AND bi.fec_carga BETWEEN '"+df.format(df2.parse(request.getParameter("f1")))+" 00:00:01' AND '"+df.format(df2.parse(request.getParameter("f2")))+" 23:59:59' and dr.baja!=1 and dp.id_ori LIKE '%"+request.getParameter("id_ori")+"%' group by p.cla_pro ;");
				while(rset.next()){
				%>
                <tr>
                  <td align="center"><%=rset.getString("cla_pro")%></td>
                  <td><%=rset.getString("des_pro")%></td>
                  <td align="center"><%=rset.getString("sol")%></td>
                  <td align="center"><%=rset.getString("sur")%></td>
                </tr>
                <%
					sol1=sol1+Integer.parseInt(rset.getString("sol"));
					sur1=sur1+Integer.parseInt(rset.getString("sur"));
				}
                }catch(Exception e){
                }%>
                <tr>
                  <td class="style49" align="center">&nbsp;</td>
                  <td class="style49" align="right">PIEZAS</td>
                  <td class="style49" align="center"><%=sol1%></td>
                  <td class="style49" align="center"><%=sur1%></td>
                </tr>
              </table></td>
          </tr>
        </table>
      </form>
</table>
</div>
</td>
</tr>
</table>
</td>
<td width="4">&nbsp;</td>
<td width="6" valign="top"><br />
  &nbsp;<br /></td>
<td width="96">&nbsp;</td>
</tr>
<tr>
  <td width="4">&nbsp;</td>
  <td width="68">&nbsp;</td>
  <td width="27">&nbsp;</td>
  <td width="1036">&nbsp;</td>
  <td width="4">&nbsp;</td>
  <td width="6">&nbsp;</td>
  <td width="96">&nbsp;</td>
</tr>
</table>
<map name="Map" id="Map">
  <area shape="rect" coords="2,5,36,28" href="excel_compras.jsp?txtf_hf=&reporte=<%=request.getParameter("reporte")%>&cla_uni=<%=request.getParameter("cla_uni")%>&id_ori=<%=request.getParameter("id_ori")%>&f1=<%=request.getParameter("f1")%>&f2=<%=request.getParameter("f2")%>&Submit=<%=request.getParameter("Submit")%>" />
</map>
</body>
</html>
<%
con.close();
%>