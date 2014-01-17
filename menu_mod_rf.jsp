<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.: MEN&Uacute; MODIFICAR :.</title>
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
.Estilo6 {font-size: 12; }
.Estilo8 {color: #FFFFFF}
-->
</style></head>

<body onLoad="foco_inicial();">
<table width="666" height="346" border="3" align="center" cellpadding="2" bgcolor="#FFFFFF">
  <tr>
  
    <td width="650"><form id="form" name="form" method="post" action="menu_mod_rf.jsp">
      <table width="650" height="323" border="0" align="center" cellpadding="2">
        <tr>
          <td height="49" bgcolor="#FFFFFF" class="logo style1"><div align="center" class="logo style1">
            <img src="imagenes/nay_ima1.jpg" width="142" height="72" />
          </div></td>
          <td height="49" colspan="2" bgcolor="#FFFFFF" class="logo style1"><div align="center">Modificar Recetas Farmacia</div></td>
          <td height="49" bgcolor="#FFFFFF" class="logo style1"><img src="imagenes/ssn.jpg" width="162" height="78" /></td>
        </tr>
        <tr>
          <td height="14" colspan="4" bgcolor="#D51046"><a href="index_menu_receta.jsp" class="Estilo10 Estilo8">Regresar a Menú </a></td>
          </tr>
        <tr>
          <td width="114" height="20">&nbsp;</td>
          <td width="122" class="bodyText"><label></label></td>
          <td width="274">&nbsp;</td>
          <td width="114">&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left" class="Estilo6"></div>
          </div></td>
          <td colspan="2" class="style5"><label><a href="elim_datos.jsp?cla_uni=<%=request.getParameter("cla_uni")%>&id_usu=<%=request.getParameter("id_usu")%>">ELIMINAR FOLIO DE LA RECETA</a></label></td>
          <td class="style5">&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left" class="Estilo6"></div>
          </div></td>
          <td colspan="2" class="style5"><label><a href="modi_datos.jsp?cla_uni=<%=request.getParameter("cla_uni")%>&id_usu=<%=request.getParameter("id_usu")%>">MODIFICAR DATOS DE LA RECETA (ENCABEZADO)</a></label></td>
          <td class="style5">&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left" class="Estilo6"></div>
          </div></td>
          <td colspan="3" class="style5"><label><a href="modi2_receta.jsp?cla_uni=<%=request.getParameter("cla_uni")%>&id_usu=<%=request.getParameter("id_usu")%>">REINTEGRAR INSUMO AL INVENTARIO (ERROR DE CAPTURA)</a> </label></td>
          </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td colspan="2" class="style5"><label><a href="modi3_receta.jsp?cla_uni=<%=request.getParameter("cla_uni")%>&id_usu=<%=request.getParameter("id_usu")%>">AGREGAR/ ELIMINAR CLAVE A LA RECETA</a> </label></td>
          <td>&nbsp;</td>
        </tr>
      </table>
          </form>
    </td>
  </tr>
</table>
</body>
</html>
