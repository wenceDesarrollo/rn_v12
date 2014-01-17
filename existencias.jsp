<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.DecimalFormat" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/**-----------------------------------------------------------------------------------------------------------------------------
ARCHIVO: inven.jsp
FUNCIÓN: Muestra los inventarios según la unidad que se haya escogido- nayarit 2013
CONECTOR Y DBMS:  JDBC Y MySQL 
DISEÑO Y AUTOR :  RHW
------------------------------------------------------------------------------------------------------------------------------*/
// Conexión a la BDD ------------------------------------
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection con=null;
	con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
	Statement stmt = con.createStatement();
	ResultSet rset = null;
// ------------------------------------------------------
// Variables de entorno ---------------------------------
	NumberFormat nf1 = NumberFormat.getInstance(Locale.US);				  
	
// fin bloque try ---------------------------------------
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTARIOS ::</title>
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
.style2 {
	font-size: 11px;
	font-family: Arial, Helvetica, sans-serif;
}
.style4 {color: #FFFFFF; font-size: 11px; font-family: Arial, Helvetica, sans-serif; }
.style5 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 18px;
	color: #006;
	font-weight: bold;
}
.FECHA {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color: #333;
}
-->
</style>
<link href="css/demo_table_jui.css" rel="stylesheet" type="text/css" />
<script src="Scripts/jquery-1.6.1.min.js" type="text/javascript"></script>
<script src="Scripts/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="Scripts/jquery.dataTables.columnFilter.js" type="text/javascript"></script>
<script src="Scripts/jquery.dataTables.pagination.js" type="text/javascript"></script>
<style type="text/css">
/* BeginOAWidget_Instance_2586523: #dataTable */

	@import url("css/custom/base/jquery.ui.all.css");
	#dataTable {padding: 0;margin:0;width:100%;}
	#dataTable_wrapper{width:100%;}
	#dataTable_wrapper th {cursor:pointer} 
	#dataTable_wrapper tr.odd {color:#000; background-color:#FFF}
	#dataTable_wrapper tr.odd:hover {color:#333; background-color:#CCC}
	#dataTable_wrapper tr.odd td.sorting_1 {color:#000; background-color:#999}
	#dataTable_wrapper tr.odd:hover td.sorting_1 {color:#000; background-color:#666}
	#dataTable_wrapper tr.even {color:#FFF; background-color:#666}
	#dataTable_wrapper tr.even:hover, tr.even td.highlighted{color:#EEE; background-color:#333}
	#dataTable_wrapper tr.even td.sorting_1 {color:#CCC; background-color:#333}
	#dataTable_wrapper tr.even:hover td.sorting_1 {color:#FFF; background-color:#000}
		
/* EndOAWidget_Instance_2586523 */
tam14 {
	font-size: 14px;
}
.negritas {
	font-weight: bold;
}
.rojo {
	color: #900;
}
.FECHA {
	font-size: 12px;
}
.gray {
	color: #CCC;
}
.gray strong {
	color: #999;
}
.neg2 {
	font-weight: bold;
}
.MAR {
	color: #2A0000;
}
.rr {
	color: #A00;
	font-size: 18px;
	font-weight: bold;
}
</style>
<script type="text/xml">
<!--
<oa:widgets>
  <oa:widget wid="2586523" binding="#dataTable" />
</oa:widgets>
-->
</script>
<script>
function CloseWin(){
window.opener = top ;
window.close();
}
</script>
</head>

<body>
<div align="center">
  <table width="837" cellpadding="0" cellspacing="0">
    <col width="137" />
    <col width="80" span="2" />
    <col width="107" />
    <col width="101" />
    <col width="120" />
    <col width="80" span="2" />
    <tr height="20">
      <td height="20"><img src="imagenes/nay_ima1.jpg" width="142" height="72" /></td>
      <td height="20"><div align="left" class="style5"><span class="MAR">EXISTENCIAS EN EL INVENTARIO</span></div></td>
    </tr>
    <tr height="20">
      <td height="20" colspan="2"></td>
    </tr>
    <tr height="20">
      <td width="279" height="20" class="style2"><form id="form1" name="form1" method="post" action="existencias.jsp?id_usu=<%=request.getParameter("id_usu")%>">
        
        <input name="Submit" type="submit" class="style2" id="Submit" value="Actualizar" />
      </form></td>
      <td width="556" height="20" align="right" class="style2"><span class="neg2">Exportar</span> <img src="imagenes/exc.jpg" alt="Importar a Excel" width="41" height="29" usemap="#mapa_exp" border="0" /></td>
    </tr>
    <tr height="20">
      <td height="20" colspan="2" class="style2"><!--a href="#abajo">Ir a Totales</a--> </td>
    </tr>
  </table>
  <table width="840" height="56" border="1" cellpadding="0" cellspacing="0">
    <col width="137" />
    <col width="80" span="2" />
    <col width="107" />
    <col width="101" />
    <col width="120" />
    <col width="80" span="2" />
    
      <tr height="20">
	  <td class="style2">
<table width="97%" border="0" cellpadding="0" cellspacing="0" id="dataTable">
  <thead>
  <tr>
      <th colspan="6" class="FECHA" ><hr /></th>
      </tr>
    <tr>
      <th width="7%" class="FECHA" >CLAVE</th>
      <th width="51%" class="FECHA">DESCRIPCI&Oacute;N</th>
      <th width="14%" class="FECHA">LOTE</th>
      <th width="16%" class="FECHA">CADUCIDAD</th>
      <th width="12%" class="FECHA">EXISTENCIAS</th>
      <th width="12%" class="FECHA">ORIGEN</th>
      
    </tr>
    <tr>
      <th colspan="6" class="FECHA" ><hr /></th>
      </tr>
  </thead>
  <tbody>
    <!--Loop start, you could use a repeat region here-->
  <%
 		 rset=stmt.executeQuery("select p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, i.cant, o.des_ori FROM usuarios us, unidades u, inventario i, detalle_productos dp, productos p, origen o where  us.cla_uni = u.cla_uni and u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro and dp.cla_pro = p.cla_pro AND dp.id_ori = o.id_ori and us.id_usu = '"+request.getParameter("id_usu")+"' and i.cant!='0'");
		 while(rset.next()){
  %> 
   <tr height="20">
      <td class="negritas" align="center"><%=rset.getString("cla_pro")%></td>
      <td class="negritas" ><%=rset.getString("des_pro")%></td>
      <td class="negritas" align="center"><%=rset.getString("lot_pro")%></td>
      <td class="negritas" align="center"><%=rset.getString("cad_pro")%></td>
      <td  align="center" class="negritas"><%=rset.getString("cant")%></td>
      <td  align="center" class="negritas"><%=rset.getString("des_ori")%></td>
    </tr>
	<%
		 }
%>
    <!--Loop end-->
  </tbody>
</table>
      
      
      </td>
    </tr>
  </table>
  <map name="mapa_exp" id="mapa_exp">
  <area shape="rect" coords="5,3,40,27" href="repor_inventario.jsp?boton=Show ALL" />
</map>
</div>
<h5 align="center">Cerrar Aplicación <button name="boton" type="button" class="style7" onClick="CloseWin()" /><img src="imagenes/borr.jpg" /></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="rojo"></span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOTAL DE PIEZAS EN EL INVENTARIO:<span class="rr"> <%//=nf1.format(suma_cant)%></span></h5>
<h6 align="center" class="gray"><strong>DERECHOS RESERVADOS GNKL/DESARROLLOS WEB ® 2009 - 2013 PARA SSN/SAVI DISTRIBUCIONES</strong></h6>

<script type="text/javascript">
// BeginOAWidget_Instance_2586523: #dataTable

$(document).ready(function() {
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bScrollCollapse": false,
		"sScrollY": "200px",
		"bAutoWidth": true,
		"bPaginate": true,
		"sPaginationType": "two_button", //full_numbers,two_button
		"bStateSave": true,
		"bInfo": true,
		"bFilter": true,
		"iDisplayLength": 25,
		"bLengthChange": true,
		"aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Todos"]]
	});
} );
		
// EndOAWidget_Instance_2586523
</script>
  
<%
	con.close();
%>
</table>
</body>
</body>
</html>
