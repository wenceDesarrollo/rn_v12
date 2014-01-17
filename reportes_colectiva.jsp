<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat"  import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date"  import="java.text.NumberFormat" import="java.util.Locale" errorPage="" %>
<% 
//  Conexión a la BDD -------------------------------------------------------------
Class.forName("org.gjt.mm.mysql.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset= null;
// fin objetos de conexión --------------------------------------------------------



%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- DW6 -->
<head>
<!-- Copyright 2005 Macromedia, Inc. All rights reserved. -->
<title>Reportes por Farmacia</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="mm_health_nutr.css" type="text/css" />
<script language="JavaScript" type="text/javascript">
//--------------- LOCALIZEABLE GLOBALS ---------------
var d=new Date();
var monthname=new Array("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septimbre","Octubre","Noviembre","Diciembre");
//Ensure correct for language. English is "January 1, 2004"
var TODAY = monthname[d.getMonth()] + " " + d.getDate() + ", " + d.getFullYear();
//---------------   END LOCALIZEABLE   ---------------
</script>
<script language="javascript" src="list02.js"></script>
<style type="text/css">
<!--
.style1 {
	font-size: 12px
}
body {
	background-image: url();
	background-color: #E1E1E1;
}
.style2 {
	font-family: Arial, Helvetica, sans-serif
}
a:link {
	color: #000000;
}
a:visited {
	color: #990000;
}
a:hover {
	color: #0000FF;
}
.style5 {
	font-size: 36px;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
}
.style6 {
	font-size: 18px
}
.style7 {
	font-size: 12px;
	font-family: Arial, Helvetica, sans-serif;
}
-->
</style>
</head>
<body onload="hora_Inv()">
<script src="scw.js" type="text/javascript"> </script>
<table width="103%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr bgcolor="#D5EDB3">
    <td colspan="2" bgcolor="#FFFFFF"><img src="imagenes/nay_ima1.jpg" width="163" height="82" /></td>
    <td height="50" colspan="3" align="center" valign="bottom" nowrap="nowrap" bgcolor="#FFFFFF" id="logo"><div align="right">
        <table width="721" border="0" align="left" cellpadding="2">
          <tr>
            <td width="509"><div align="center" class="style5 style6">SISTEMA REPORTEADOR </div></td>
            <td width="198" height="67"><img src="imagenes/ssn.jpg" width="219" height="89" /></td>
          </tr>
        </table>
      </div></td>
    <td width="4" bgcolor="#FFFFFF">&nbsp;</td>
  </tr>
  <tr bgcolor="#99CC66">
    <td height="20" colspan="7" background="fn1.jpg" bgcolor="#FFFFFF" id="dateformat">&nbsp;&nbsp; 
      <script language="JavaScript" type="text/javascript">
      document.write(TODAY);	</script></td>
  </tr>
  <tr>
    <td width="165" valign="top" bgcolor="#FFFFFF"><table border="0" cellspacing="0" cellpadding="0" width="165" id="navigation">
      </table>
          <br />
      &nbsp;<br />
      &nbsp;<br />
      &nbsp;<br /></td>
    <td width="4">&nbsp;</td>
    <td colspan="2" valign="top"><div align="center"></div>
      <div align="left"></div>
      <div align="left"></div>
      <table width="751" border="3" align="left" cellpadding="0" cellspacing="0">
        <tr>
          <td width="453" class="bodyText"><table width="652" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="37" colspan="4" bgcolor="#FFFFFF"><div align="center">
                    <p align="center"><img src="imagenes/ima_main.jpg" width="524" height="111" /></p>
                  </div></td>
              </tr>
              <tr>
                <td width="4" nowrap bgcolor="#FFFFFF">&nbsp;</td>
                <td width="5" bgcolor="#FFFFFF">&nbsp;</td>
                <td width="453"><div align="center">
                    <table width="555" border="0" align="center" cellpadding="2" cellspacing="3">
                      <form action="reporte_rerf2_col.jsp" method="post" >
                        <tr>
                          <td colspan="14"><div id="item21" style="display:none" align="justify" >
                              <input type="text" name="txtf_hf" id="txtf_hf" size="10" readonly="true"/>
                            </div></td>
                        </tr>
                        <tr>
                          <td colspan="14" class="style1"><div align="left"><a href="index_reporte.jsp">Regresar a Menú</a></div></td>
                        </tr>
                        <tr>
                          <td colspan="14" class="style1" >Tipo de Reporte:
                            <input name="reporte" type="radio" value="2" checked="checked" />
                            RECETA POR COLECTIVA </td>
                          <td colspan="2" >&nbsp;</td>
                        </tr>
                        <tr>
                          <td colspan="2" align="right"><span class="style1"><span class="style2">Unidad</span></span>:</td>
                          <td colspan="12" align="right" class="style1"><div align="left"></div>
                            <label>
                            <div align="left">
                              <select name="cla_uni" class="style1">
                                <option selected="selected">-----------------------Escoja un unidad-------------------------</option>
                                <%
								rset = stmt.executeQuery("select cla_uni, des_uni from unidades");
								while(rset.next()){
								%>
                                <option value="<%=rset.getString("cla_uni")%>"><%=rset.getString("des_uni")%></option>
                                <%
								}
								%>
                              </select>
                              Origen
                              <select name="id_ori" class="style1">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="">AMBOS</option>
                              </select>
                            </div>
                            </label></td>
                        </tr>
                        <tr>
                          <td bgcolor="#FFFFFF" colspan="15" class="style1">Rango de fechas del:&nbsp;&nbsp;
                            <label>
                              <input name="txtf_caduc" type="text" id="txtf_caduc" size="10" readonly title="dd/mm/aaaa">
                            </label>
                            <img src="imagenes/cal.jpg" width="26" height="27" border="0" /> &nbsp;&nbsp;&nbsp;&nbsp;
                            <label> al&nbsp;&nbsp;
                              <input name="txtf_caduci" type="text" id="txtf_caduci" size="10" readonly title="dd/mm/aaaa">
                            </label>
                            <img src="imagenes/cal.jpg" width="26" height="27" border="0" /> &nbsp;&nbsp;&nbsp;&nbsp;
                            <label>&nbsp;&nbsp; </label>
                            <input type="submit" name="Submit" value="Por Fechas" class="style1"/>
                            <label></label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                      </form>
                    </table>
                  </div></td>
                <td width="194" nowrap bgcolor="#FFFFFF"><img src="imagenes/px.gif" width="1" height="1" alt="" border="0" /><img src="imagenes/caps2.jpg" width="134" height="108" /></td>
              </tr>
              <tr>
                <td colspan="4">&nbsp;</td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<link rel="stylesheet" href="themes/base/jquery.ui.all.css">
<script src="jqry/jquery-1.9.1.js"></script>
<script src="jqry/jquery-ui-1.10.3.custom.js"></script>
<script>
    $(function() {
        $("#txtf_caduc").datepicker({dateFormat: "dd/mm/yy"}).val()
    });
	$(function() {
        $("#txtf_caduci").datepicker({dateFormat: "dd/mm/yy"}).val()
    });
	// Traducción al español
$(function($){
    $.datepicker.regional['es'] = {
        closeText: 'Cerrar',
        prevText: '<Ant',
        nextText: 'Sig>',
        currentText: 'Hoy',
        monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
        monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
        dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
        dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
        dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
        weekHeader: 'Sm',
        dateFormat: 'dd/mm/yy',
        firstDay: 1,
        isRTL: false,
        showMonthAfterYear: false,
        yearSuffix: ''
    };
    $.datepicker.setDefaults($.datepicker.regional['es']);
});
</script>
</body>
</html>
<%
con.close();
%>