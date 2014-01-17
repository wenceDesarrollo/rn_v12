<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="" %>
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<!-- DW6 -->
<head>
<script language="javascript" src="list02.js"></script>
<!-- Copyright 2005 Macromedia, Inc. All rights reserved. -->
<title>:: REPORTE CONCENTRADO::</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="mm_travel2.css" type="text/css" />
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
.Estilo3 {
	color: #000000;
	font-size: 14px;
}
.Estilo6 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
}
.Estilo9 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 16px;
}
.Estilo13 {
	font-size: 16px;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.Estilo14 {
	font-size: 16px
}
-->
</style>
</head>
<body bgcolor="#ffffff" onload="fillCategory2()">
<p> </p>
<table width="1048" border="0" align="center" cellpadding="2">
  <tr>
    <td width="104"><img src="imagenes/nay_ima1.jpg" width="142" height="72" /></td>
    <td height="63" colspan="2" align="center" valign="bottom" nowrap="nowrap" bgcolor="#FFFFFF" id="logo"><div align="center"> <span class="Estilo14">GOBIERNO DEL ESTADO DE NAYARIT<br />
        SECRETARIA DE SALUD</br>
        SAVI DISTRIBUCIONES S.A DE C.V<br />
        REPORTE GLOBAL DE CONSUMO<br />
        DE LA UNIDAD: <br />
        <%
        rset=stmt.executeQuery("select des_uni from unidades where cla_uni = '"+request.getParameter("cla_uni")+"'");
	  while(rset.next()){
		  out.println(rset.getString(1));
	  }
	  %>
        <br />
        PERIODO: <%=request.getParameter("f1")%> al <%=request.getParameter("f2")%></span><br />
        <br />
      </div></td>
    <td width="96"><img src="imagenes/ssn.jpg" width="162" height="78" /></td>
  </tr>
</table>
<table width="20%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="7" bgcolor="#003366"><img src="mm_spacer.gif" alt="" width="1" height="1" border="0" /></td>
  </tr>
  <tr bgcolor="#CCFF99">
    <td height="25" colspan="7" bgcolor="#D31145" id="dateformat">&nbsp;&nbsp;<span class="style76"> 
      <script language="JavaScript" type="text/javascript">
      //document.write(TODAY);	</script> 
      <a href="reportes_val_rc.jsp" class="style76"><span class="Estilo1">Regresar a Menú</span></a></span>&nbsp;<span class="Estilo1">&nbsp;&nbsp;Exportar</span></span>&nbsp;<img src="imagenes/exc.jpg" width="37" height="29" border="0" usemap="#Map2"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%
	  String ori="AMBOS";
	  try{
	  if((request.getParameter("ori")).equals("1")){
		  ori="SSN";
	  }
	  if((request.getParameter("ori")).equals("2")){
		  ori="SAVI";
	  }
	  }catch (Exception e) {}
	  %>
      <span class="Estilo1">ORIGEN "<%=ori%>"</span></td>
  </tr>
  <tr>
    <td colspan="7" bgcolor="#003366"><img src="mm_spacer.gif" alt="" width="1" height="1" border="0" /></td>
  </tr>
  <tr>
    <td colspan="2" valign="top"><form action="reporte_glob_val.jsp" method="post" name="form" onSubmit="javascript:return ValidateAbas(this)">
        <table width="1008" border="0" align="center">
          <tr>
            <td width="418"><table width="980" border="1">
                <tr>
                  <td width="83"><span class="Estilo13">Clave</span></td>
                  <td width="392"><div align="center"><span class="Estilo13">Descripci&oacute;n</span></div></td>
                  <td width="125"><div align="center"><span class="Estilo13">UM </span></div></td>
                  <td width="108"><div align="center"><span class="Estilo13">LOTE </span></div></td>
                  <td width="121"><div align="center"><span class="Estilo13">CADUCIDAD </span></div></td>
                  <td width="111"><div align="center"><span class="Estilo13">Total Cajas </span></div></td>
                </tr>
                <%
				int total=0;
				rset = stmt.executeQuery("SELECT p.pres_pro, r.fol_rec, m.nom_med, pa.nom_pac, p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, dr.can_sol, sum(dr.cant_sur) as sur FROM bitacora bi, unidades un, usuarios us, receta r, pacientes pa, medicos m, detreceta dr, detalle_productos dp, productos p WHERE r.id_rec = bi.id_rec and r.id_tip = '2' and un.cla_uni = us.cla_uni AND us.id_usu = r.id_usu AND r.num_afi = pa.num_afi AND r.cedula = m.cedula AND r.id_rec = dr.id_rec AND dr.det_pro = dp.det_pro AND dp.cla_pro = p.cla_pro AND un.cla_uni = '"+request.getParameter("cla_uni")+"' AND bi.fec_carga BETWEEN '"+df.format(df2.parse(request.getParameter("f1")))+" 00:00:01' and '"+df.format(df2.parse(request.getParameter("f2")))+" 23:59:59' and dp.id_ori like '%"+request.getParameter("ori")+"%' and dr.baja!=1 and dr.cant_sur!= 0 group by p.cla_pro, dp.lot_pro, dp.cad_pro ;");
				while(rset.next()){
					ban=1;
				%>
                <tr>
                  <td class="Estilo6"><%=rset.getString("cla_pro")%></td>
                  <td class="Estilo6"><%=rset.getString("des_pro")%></td>
                  <td align="center" class="Estilo9"><%=rset.getString("pres_pro")%></td>
                  <td align="center" class="Estilo9"><%=rset.getString("lot_pro")%></td>
                  <td align="center" class="Estilo9"><%=df2.format(df.parse(rset.getString("cad_pro")))%></td>
                  <td align="center" class="Estilo9"><%=rset.getString("sur")%></td>
                </tr>
                <%
				total = total+Integer.parseInt(rset.getString("sur"));
				}
				%>
                <tr>
                  <td>&nbsp;</td>
                  <td></td>
                  <td align="center" class="Estilo9">&nbsp;</td>
                  <td align="center" class="Estilo9">&nbsp;</td>
                  <td align="center" class="Estilo9">Total</td>
                  <td align="center" class="Estilo9"><%=total%></td>
                </tr>
                <tr>
                  <td colspan="9">&nbsp;</td>
                </tr>
                <tr>
                  <td colspan="9"><div align="left" class="Estilo3">ADMINISTRADOR&nbsp;DE LA UNIDAD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ENCARGADO(A) DE LA FARMACIA &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FILTRO DE LA SSN</div></td>
                </tr>
              </table></td>
          </tr>
        </table>
      </form>
      <div align="center"></div></td>
  </tr>
</table>
<%
if (ban==0){
%>
NO SE ENCONTRARON COINCIDENCIAS EN LA CONSULTA, INTENTE NUEVAMENTE
<%
}
%>
<br />
<a href="reportes_val_rc.jsp">Regresar a Men&uacute;</a>
<map name="Map" id="Map">
  <area shape="poly" coords="241,165" href="#" />
  <area shape="poly" coords="230,40,231,88,270,43" href="#" />
</map>
<map name="Map2" id="Map2">
  <area shape="rect" coords="6,5,33,31" href="repor_receta3_rc.jsp?f1=<%=request.getParameter("f1")%>&f2=<%=request.getParameter("f2")%>&boton=Show ALL&unidad=<%=request.getParameter("cla_uni")%>&ori=<%=request.getParameter("ori")%>" />
</map>
</body>
</html>
<%
con.close();
%>