<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
//  Conexión a la BDD -------------------------------------------------------------
Class.forName("org.gjt.mm.mysql.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset= null;
// fin objetos de conexión ------------------------------------------------------
int ban = 0;
int total=0;
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","attachment; filename=REPORTE DETALLDO DE CONSUMO POR RECETA FARMACIA .xls");
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="CENSITOSMMMMM_archivos/filelist.xml">
<link rel=Edit-Time-Data href="CENSITOSMMMMM_archivos/editdata.mso">
<link rel=OLE-Object-Data href="CENSITOSMMMMM_archivos/oledata.mso">

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
.style5 {font-family: Arial, Helvetica, sans-serif; font-size: 12; }
-->
</style>

</head>

<body link=blue vlink=purple>
<p>

</p>

<table width="1320">
  <tr height="20">
    <td height="20" colspan="11"  align="center"><p align="center">GOBIERNO DEL ESTADO DE NAYARIT</p>
      <p align="center">SECRETARIA DE SALUD</p>
      <p align="center">SAVI DISTRIBUICIONES   S.A DE C.V.</p>
      <p align="center">REPORTE DETALLDO DE CONSUMO POR RECETA FARMACIA </p>
      <p align="center">DE LA UNIDAD: <%
        rset=stmt.executeQuery("select des_uni from unidades where cla_uni = '"+request.getParameter("unidad")+"'");
	  while(rset.next()){
		  out.println(rset.getString(1));
	  }
	  %></p>
    <p align="center">PERIODO: <%=request.getParameter("f1")%> al <%=request.getParameter("f2")%></p>      
    <p align="center">ORIGEN &quot;<%=request.getParameter("ori")%>&quot;  </p>    </td>
  </tr>
  
  <tr height="20">
    <td width="58" style="border:double"><div align="center">
      Fecha
      </div></td>
    <td width="47" height="20"   style="border:double"><div align="center">Folio</div></td>
    <td height="20" width="225" style="border:double"><div align="center">No. Padron </div></td>
    <td width="145" style="border:double"><div align="center">Ced. M&eacute;dico </div></td>
    <td width="124" style="border:double"><div align="center">Nombre M&eacute;dico </div></td>
    <td width="163" style="border:double"><div align="center">Paciente</div></td>
    <td width="91" style="border:double"><div align="center">Clave Articulo </div></td>
    <td width="238" style="border:double"><div align="center">Descripci&oacute;n</div></td>
    
    <td width="76" style="border:double"><div align="center">Cant. Sol </div></td>
    <td width="82" style="border:double"><div align="center">Cant. Sur</div></td>
  </tr>

				   
  <%
				rset = stmt.executeQuery("SELECT bi.fec_carga, r.fol_rec, r.num_afi, r.cedula, m.nom_med, pa.nom_pac, p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, dr.can_sol, dr.cant_sur FROM bitacora bi, unidades un, usuarios us, receta r, pacientes pa, medicos m, detreceta dr, detalle_productos dp, productos p WHERE bi.id_rec = r.id_rec and un.cla_uni = us.cla_uni AND us.id_usu = r.id_usu AND r.num_afi = pa.num_afi AND r.cedula = m.cedula AND r.id_rec = dr.id_rec AND dr.det_pro = dp.det_pro AND dp.cla_pro = p.cla_pro AND un.cla_uni = '"+request.getParameter("unidad")+"' AND bi.fec_carga BETWEEN '"+df.format(df2.parse(request.getParameter("f1")))+" 00:00:01' and '"+df.format(df2.parse(request.getParameter("f2")))+" 23:59:59' and dp.id_ori like '%"+request.getParameter("ori")+"%' and r.id_tip = '1' and dr.baja!=1 and dr.cant_sur!=0 ;");
				while(rset.next()){
					ban=1;
				%>
            <tr>
              <td style="border:double" class="Estilo8"><%=df2.format(df.parse(rset.getString("fec_carga")))%></td>
              <td style="border:double" > <%=rset.getString("fol_rec")%></td>
              <td style="border:double"><%=rset.getString("num_afi")%></td>
              <td style="border:double"><%=rset.getString("cedula")%></td>
              <td style="border:double"><%=rset.getString("nom_med")%></td>
              <td style="border:double"><%=rset.getString("nom_pac")%></td>
              <td style="border:double"><%=rset.getString("cla_pro")%></td>
              <td style="border:double"><%=rset.getString("des_pro")%></td>
              <td style="border:double" align="center"><%=rset.getString("can_sol")%></td>
			  <td style="border:double" align="center"><%=rset.getString("cant_sur")%></td>
			 </tr>
			<%
				}
			%>

</table>
<p>&nbsp;</p>
</body>

</html>
<%
con.close();
%>