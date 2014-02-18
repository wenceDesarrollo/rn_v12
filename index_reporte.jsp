<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.:Reportes:.</title>
<script language="javascript" src="list02.js">



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
  
    <td width="650"><form id="form" name="form" method="post" action="index_movi2.jsp">
      <table width="650" height="323" border="0" align="center" cellpadding="2">
        <tr>
          <td height="49" bgcolor="#FFFFFF" class="logo style1"><div align="center" class="logo style1">
            <img src="imagenes/nay_ima1.jpg" width="142" height="72" />
          </div></td>
          <td height="49" colspan="2" bgcolor="#FFFFFF" class="logo style1"><div align="center">Men&uacute; Impresi&oacute;n de Reportes Diarios </div></td>
          <td height="49" bgcolor="#FFFFFF" class="logo style1"><img src="imagenes/ssn.jpg" width="162" height="78" /></td>
        </tr>
        <tr>
          <td height="14" colspan="4" bgcolor="#F82D33"><a href="index.jsp" class="Estilo10 Estilo8">Regresar a Menú </a></td>
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
          <td colspan="2" class="style5"><label><a href="reportes_farmacia.jsp?cla_uni=<%=request.getParameter("cla_uni")%>">REPORTE DIARIO RECETA POR FARMACIA</a></label></td>
          <td class="style5">&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left" class="Estilo6"></div>
          </div></td>
          <td colspan="2" class="style5"><label><a href="reportes_colectiva.jsp?cla_uni=<%=request.getParameter("cla_uni")%>">REPORTE DIARIO RECETA COLECTIVA</a> </label></td>
          <td>&nbsp;</td>
        </tr>
       
       
        
        <tr>
          <td height="20">&nbsp;</td>
          <td colspan="2" class="style5"><label><a href="index_reporte_val.jsp?cla_uni=<%=request.getParameter("cla_uni")%>">REPORTE VALIDACI&Oacute;N MENSUAL </a></label></td>
          <td>&nbsp;</td>
        </tr>
      </table>
          </form>
    </td>
  </tr>
</table>
</body>
</html>
