<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

// Conexion BDD via JDBC
Class.forName("org.gjt.mm.mysql.Driver"); 
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset=null;
// fin conexion --------

String f1="2013-01-01";
String f2="2015-01-01";

try{
	String but = request.getParameter("submit");
	if (but.equals("Por Fechas")) {
		f1=request.getParameter("txtf_caduc");
		f2=request.getParameter("txtf_caduci");
	}
} catch(Exception e) {
}
int total=0;
response.setContentType ("application/vnd.ms-excel"); //Tipo de fichero.
response.setHeader ("Content-Disposition", "attachment;filename=\"Dispensado por dia_colecitvo_del"+f1+"al"+f2+".xls\"");
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="CENSITOSMMMMM_archivos/filelist.xml">
<link rel=Edit-Time-Data href="CENSITOSMMMMM_archivos/editdata.mso">
<link rel=OLE-Object-Data href="CENSITOSMMMMM_archivos/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author> RICARDO HERNANDEZ WENCE</o:Author>
  <o:LastAuthor> RICARDO HERNANDEZ WENCE</o:LastAuthor>
  <o:LastPrinted>2009-09-04T17:35:32Z</o:LastPrinted>
  <o:Created>2009-09-03T22:48:47Z</o:Created>
  <o:LastSaved>2009-09-04T17:37:50Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.98in .79in .98in .79in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl24
	{mso-style-parent:style0;
	color:white;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:black;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:black;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	text-align:right;}
.xl29
	{mso-style-parent:style0;
	text-align:left;}
.xl30
	{mso-style-parent:style0;
	text-decoration:underline;
	text-underline-style:single;}
.xl31
	{mso-style-parent:style0;
	border:1.0pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	text-align:center;}
.xl33
	{mso-style-parent:style0;
	color:white;
	text-align:center;
	background:black;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:black;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>

</head>

<body link=blue vlink=purple>
<p></p>
<p>&nbsp;</p>
<table width="400" cellpadding="3" cellspacing="1" border="2" >
   
    <tr height="20">
    <td height="20" colspan="3" style="border:double"><p align="center">DISPENSADO POR UNIDAD RECETA COLECTIVA </p></td>
  </tr>
  <tr height="20">
		  <td height="33" >		  </td>
		  <td >
		    <div align="center" class="Estilo8">Rango 
		      <%=df.format(df2.parse(f1))%> 
		      del al 
		      <%=df.format(df2.parse(f2))%> 
	          </div></td>
		  <td>
		  </td>
		  </tr>
  <tr height="20">
    <td width="52" height="20" style="border:double"><div align="center">CLAVE&nbsp;</div></td>
    <td width="42"   style="border:double">DESCRIPCI&Oacute;N</td>
    <td width="42"   style="border:double"><div align="center">CANTIDAD</div></td>
  </tr>
  <%
		 rset=stmt.executeQuery("SELECT p.cla_pro, p.des_pro, sum(dr.cant_sur) as cant FROM bitacora bi, productos p, detalle_productos dp, detreceta dr, receta r, usuarios u, unidades un where bi.id_rec = r.id_rec and r.id_tip = '2' and p.cla_pro = dp.cla_pro AND dp.det_pro = dr.det_pro AND dr.id_rec = r.id_rec AND r.id_usu = u.id_usu AND u.cla_uni = un.cla_uni AND bi.fec_carga BETWEEN '"+f1+" 00:00:01' and '"+f2+" 23:59:59' and dr.baja!=1  GROUP BY p.cla_pro, dr.baja ORDER BY dp.cla_pro+0 ASC ;");
		 while(rset.next()){
		 %>
	<tr height="20" >
    <td style="border:double" align="left" ><%=rset.getString("cla_pro")%></td>
    <td  style="border:double"><%=rset.getString("des_pro")%></td>
    <td  style="border:double"><div align="center"><%=rset.getString("cant")%></div></td>
  </tr>
  <%
  total = total+Integer.parseInt(rset.getString("cant"));
  }
  
  %>
  <tr height="20" >
    <td style="border:double" align="left" >&nbsp;</td>
    <td  style="border:double">Total de Piezas</td>
    <td  style="border:double"><div align="center"><%=total%></div></td>
  </tr>
</table>
<p>&nbsp;</p>
</body>

</html>
<%
con.close();
%>