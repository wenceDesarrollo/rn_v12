<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
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
response.setHeader("Content-Disposition","attachment; filename=REPORTE DE CONSUMO POR RECETA COLECTIVA.xls");
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

<table width="1320" cellpadding="3" cellspacing="1" border="0" >
  <tr height="20">
    <td height="20" colspan="12"  align="center"><p align="center">GOBIERNO DEL ESTADO DE NAYARIT</p>
      <p align="center">SECRETARIA DE SALUD</p>
      <p align="center">SAVI DISTRIBUCIONES S.A DE C.V.</p>
      <p align="center">REPORTE  DE CONSUMO POR RECETA COLECTIVA </p>
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
    <td width="140" height="20" style="border:double"><div align="center">CLAVE ARTICULO </div></td>
    <td width="421" height="20" colspan="5" style="border:double"><div align="center">DESCRIPCI&Oacute;N</div></td>
    <td width="94" style="border:double"><div align="center">LOTE</div></td>
    <td width="94" style="border:double"><div align="center">CADUCIDAD</div></td>
    <td width="94" style="border:double"><div align="center">TOTAL CAJAS</div></td>
    
  </tr>
 
 <%
				rset = stmt.executeQuery("SELECT p.pres_pro, r.fol_rec, m.nom_med, pa.nom_pac, p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, dr.can_sol, sum(dr.cant_sur) as sur FROM bitacora bi, unidades un, usuarios us, receta r, pacientes pa, medicos m, detreceta dr, detalle_productos dp, productos p WHERE r.id_rec = bi.id_rec and r.id_tip = '2' and un.cla_uni = us.cla_uni AND us.id_usu = r.id_usu AND r.num_afi = pa.num_afi AND r.cedula = m.cedula AND r.id_rec = dr.id_rec AND dr.det_pro = dp.det_pro AND dp.cla_pro = p.cla_pro AND un.cla_uni = '"+request.getParameter("unidad")+"' AND bi.fec_carga BETWEEN '"+df.format(df2.parse(request.getParameter("f1")))+" 00:00:01' and '"+df.format(df2.parse(request.getParameter("f2")))+" 23:59:59' and dp.id_ori like '%"+request.getParameter("ori")+"%' and dr.baja!=1 and dr.cant_sur!= 0 group by p.cla_pro, dp.lot_pro, dp.cad_pro ;");
				while(rset.next()){
					ban=1;
				%>		   
                  <tr height="20" >
                    <td align="left" style="border:double" ><%=rset.getString("cla_pro")%></td>
                    <td height="20" colspan="5" style="border:double"><div align="center"><%=rset.getString("des_pro")%></div><div align="center"></div></td>
                    <td style="border:double"><%=rset.getString("lot_pro")%></td>
                    <td style="border:double"><%=df2.format(df.parse(rset.getString("cad_pro")))%></td>
                    <td style="border:double"><%=rset.getString("sur")%></td>
                  </tr>
                <%
				total = total+Integer.parseInt(rset.getString("sur"));
				}
				%>
					<tr height="20" >
                    <td align="left" style="border:double" ></td>
                    <td height="20" colspan="5" style="border:double"><div align="center"></div><div align="center"></div></td>
                    <td style="border:double"></td>
                    <td style="border:double">TOTAL</td>
                    <td style="border:double"><%=total%></td>
                  </tr>
</table>
<p>&nbsp;</p>
</body>

</html>
<%
con.close();
%>
