<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); %>
<% 
//  Conexión a la BDD -------------------------------------------------------------
Class.forName("org.gjt.mm.mysql.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset= null;
// fin objetos de conexión ------------------------------------------------------
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- DW6 -->
<head>
<script language="javascript" src="list02.js"></script>
<!-- Copyright 2005 Macromedia, Inc. All rights reserved. -->
<title>:: REPORTE DIARIO SALIDA POR FARMACIA ::</title>
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
.style33 {font-size: x-small}
.style40 {font-size: 9px}
.style41 {font-size: 9}
.style42 {font-family: Arial, Helvetica, sans-serif}
.style32 {font-size: x-small; font-family: Arial, Helvetica, sans-serif; }
.style43 {
	font-size: x-small;
	color: #FFFFFF;
	font-weight: bold;
}
.style47 {font-size: x-small; font-weight: bold; }
.style49 {font-size: x-small; font-family: Arial, Helvetica, sans-serif; font-weight: bold; }
.style50 {color: #000000}
.style51 {color: #BA236A}
.style58 {font-size: x-small; font-weight: bold; color: #666666; }
.style66 {font-size: x-small; font-weight: bold; color: #333333; }
a:hover {
	color: #333333;
}
.style68 {color: #CCCCCC}
.style75 {color: #333333; }
a:link {
	color: #711321;
}
.style76 {color: #003366}
.style77 {
	color: #711321;
	font-weight: bold;
}
.Estilo1 {color: #FFFFFF}
-->
</style>
</head>
<body bgcolor="#ffffff" onload="fillCategory2()">
<p>
 
</p>
<table width="662" border="0" align="center" cellpadding="2">
  <tr>
    <td width="102"><img src="imagenes/nay_ima1.jpg" width="142" height="72" /></td>
    <td height="63" colspan="2" align="center" valign="bottom" nowrap="nowrap" bgcolor="#FFFFFF" id="logo"><div align="center">
     <span class="style49"> GOBIERNO DEL ESTADO DE NAYARIT<br />
      SECRETARIA DE SALUD</br>
	  SAVI DISTRIBUCIONES S.A DE C.V<br />
	  REPORTE DETALLADO DE CONSUMO POR RECETA <br />
      
    DE LA UNIDAD:<br /><%
	  rset=stmt.executeQuery("select des_uni from unidades where cla_uni = '"+request.getParameter("cla_uni")+"'");
	  while(rset.next()){
		  out.println(rset.getString(1));
	  }
	  %> <br />
    PERIODO: <%=df.format(df2.parse(request.getParameter("txtf_caduc")))%> al <%=df.format(df2.parse(request.getParameter("txtf_caduci")))%><br />
    </span>
  
    </div></td>
    <td width="103"><img src="imagenes/ssn.jpg" width="162" height="78" /></td>
  </tr>
  
</table>
<table width="40%" border="0" align="center" cellpadding="0" cellspacing="0">

  <tr>
    <td colspan="7" bgcolor="#003366"><img src="mm_spacer.gif" alt="" width="1" height="1" border="0" /></td>
  </tr>

  <tr bgcolor="#CCFF99">
  	<td height="25" colspan="7" bgcolor="#D31145" id="dateformat">&nbsp;&nbsp;<span class="style76">
  	  <script language="JavaScript" type="text/javascript">
      //document.write(TODAY);	</script>
      <a href="reportes_colectiva.jsp" class="style76"><span class="Estilo1">Regresar a Menú</span></a></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%
	  String ori="AMBOS";
	  try{
	  if((request.getParameter("id_ori")).equals("1")){
		  ori="SSN";
	  }
	  if((request.getParameter("id_ori")).equals("2")){
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
    
    <td colspan="2" valign="top"><form action="reporte_rerf2.jsp" method="post" name="form" onSubmit="javascript:return ValidateAbas(this)">
    <table width="800" border="0" align="center">
      <tr>
        <td width="800"><table width="798" border="1">
            <tr>
              <td width="52" ><span class="style49">Fecha</span></td>
              <td width="26"> <span class="style49">Folio</span></td>
              <td width="118"> <span class="style49">Nombre Encargado</span></td>
              <td width="62"> <span class="style49">Servicio</span></td>
              <td width="104"> <span class="style49">Clave Articulo </span></td>
              <td width="119"> <span class="style49">Descripci&oacute;n</span></td>
             <td width="80"><span class="style49">Lote</span></td>
              <td width="89"><span class="style49">Caducidad</span></td>
              <!--td width="47"> <span class="style49">Costo Unitario </span></td-->
              <td width="41"> <span class="style49">Cant. Sol </span></td>
              <td width="43"> <span class="style49">Cant. Sur</span></td>
			</tr>
			<%
			rset = stmt.executeQuery("SELECT bi.fec_carga, r.fol_rec, r.enc_ser, s.nom_ser, p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, dr.can_sol, dr.cant_sur FROM bitacora bi, unidades un, usuarios us, receta r, pacientes pa, medicos m, detreceta dr, detalle_productos dp, productos p, servicios s WHERE bi.id_rec = r.id_rec and un.cla_uni = us.cla_uni AND us.id_usu = r.id_usu AND r.num_afi = pa.num_afi AND r.cedula = m.cedula AND r.id_rec = dr.id_rec AND dr.det_pro = dp.det_pro AND dp.cla_pro = p.cla_pro AND un.cla_uni = '"+request.getParameter("cla_uni")+"' AND bi.fec_carga BETWEEN '"+df.format(df2.parse(request.getParameter("txtf_caduc")))+" 00:00:01' and '"+df.format(df2.parse(request.getParameter("txtf_caduci")))+" 23:59:59' and dp.id_ori like '%"+request.getParameter("id_ori")+"%' and r.id_tip = '"+request.getParameter("reporte")+"' and r.id_ser = s.id_ser and dr.baja!=1 and dr.cant_sur!=0 ;");
			while(rset.next()){
			%>
            <tr>
              <td><span class="style49"><%=df2.format(df3.parse(rset.getString(1)))%></span></td>
              <td><span class="style49"><%=rset.getString(2)%></span></td>
              <td><span class="style49"><%=rset.getString(3)%></span></td>
              <td><span class="style49"><%=rset.getString(4)%></span></td>
              <td><span class="style49"><%=rset.getString(5)%></span></td>
              <td><span class="style49"><%=rset.getString(6)%></span></td>
              <td><span class="style49"><%=rset.getString(7)%></span></td>
              <td><span class="style49"><%=rset.getString(8)%></span></td>
              <td align="center"><span class="style49"><%=rset.getString(9)%></span></td>
              <td align="center"><span class="style49"><%=rset.getString(10)%></span></td>
			</tr>
			<%
			}
			%>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td class="style49" align="right">PIEZAS</td>
              <td class="style49" align="center">&nbsp;</td>
              <td class="style49" align="center">&nbsp;</td>
              <%
			  rset = stmt.executeQuery("SELECT dr.fec_sur, r.fol_rec, m.nom_med, pa.nom_pac, p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, sum(dr.can_sol) as sol, sum(dr.cant_sur) as sur FROM bitacora bi, unidades un, usuarios us, receta r, pacientes pa, medicos m, detreceta dr, detalle_productos dp, productos p WHERE bi.id_rec = r.id_rec and un.cla_uni = us.cla_uni AND us.id_usu = r.id_usu AND r.num_afi = pa.num_afi AND r.cedula = m.cedula AND r.id_rec = dr.id_rec AND dr.det_pro = dp.det_pro AND dp.cla_pro = p.cla_pro AND un.cla_uni = '"+request.getParameter("cla_uni")+"' AND bi.fec_carga BETWEEN '"+df.format(df2.parse(request.getParameter("txtf_caduc")))+" 00:00:01' and '"+df.format(df2.parse(request.getParameter("txtf_caduci")))+" 23:59:59' and dp.id_ori like '%"+request.getParameter("id_ori")+"%' and r.id_tip = '"+request.getParameter("reporte")+"' group by un.cla_uni  ;");
			  while(rset.next()){
			  %>
              <td class="style49" align="center"><%=rset.getString(9)%></td>
              <td class="style49" align="center"><%=rset.getString(10)%></td>
              <%
			  }
			  %>
			 </tr>

            <tr>
              <%
			  int recetas=0;
			  rset = stmt.executeQuery("SELECT dr.fec_sur, r.fol_rec, m.nom_med, pa.nom_pac, p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, sum(dr.can_sol) as sol, sum(dr.cant_sur) as sur FROM bitacora bi, unidades un, usuarios us, receta r, pacientes pa, medicos m, detreceta dr, detalle_productos dp, productos p WHERE r.id_rec = bi.id_rec and un.cla_uni = us.cla_uni AND us.id_usu = r.id_usu AND r.num_afi = pa.num_afi AND r.cedula = m.cedula AND r.id_rec = dr.id_rec AND dr.det_pro = dp.det_pro AND dp.cla_pro = p.cla_pro AND un.cla_uni = '"+request.getParameter("cla_uni")+"' AND bi.fec_carga BETWEEN '"+df.format(df2.parse(request.getParameter("txtf_caduc")))+"' and '"+df.format(df2.parse(request.getParameter("txtf_caduci")))+" 23:59:59' and dp.id_ori like '%"+request.getParameter("id_ori")+"%' and r.id_tip = '"+request.getParameter("reporte")+"' group by r.fol_rec  ;");
			  while(rset.next()){
				  recetas++;
			  }
			  %>
              <td height="24" colspan="5" align="center" class="style49">TOTAL RECETAS EMITIDAS= <%=recetas%></td>
              
			  <%
			  rset = stmt.executeQuery("SELECT dr.fec_sur, r.fol_rec, m.nom_med, pa.nom_pac, p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, sum(dr.can_sol) as sol, sum(dr.cant_sur) as sur FROM bitacora bi, unidades un, usuarios us, receta r, pacientes pa, medicos m, detreceta dr, detalle_productos dp, productos p WHERE r.id_rec = bi.id_rec and un.cla_uni = us.cla_uni AND us.id_usu = r.id_usu AND r.num_afi = pa.num_afi AND r.cedula = m.cedula AND r.id_rec = dr.id_rec AND dr.det_pro = dp.det_pro AND dp.cla_pro = p.cla_pro AND un.cla_uni = '"+request.getParameter("cla_uni")+"' AND bi.fec_carga BETWEEN '"+df.format(df2.parse(request.getParameter("txtf_caduc")))+" 00:00:01' and '"+df.format(df2.parse(request.getParameter("txtf_caduci")))+" 23:59:59' and dp.id_ori like '%"+request.getParameter("id_ori")+"%' and r.id_tip = '"+request.getParameter("reporte")+"' group by un.cla_uni  ;");
			  while(rset.next()){
			  %>
              <td colspan="6" class="style49" align="center">TOTAL PIEZAS DISPENSADAS= <%=rset.getString(10)%></td>
              <%
			  }
			  %>
              </tr>
          </table>
            </td>
       
      </tr>
    </table>
    </form>   
	  
	 
</table>
        </div></td>
        </tr>
    </table>    </td>
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
<area shape="poly" coords="241,165" href="#" />
<area shape="poly" coords="230,40,231,88,270,43" href="#" />
</map>

</body>
</html>
<%
con.close();
%>