<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
//  Conexión a la BDD -------------------------------------------------------------
Class.forName("org.gjt.mm.mysql.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset= null;
// fin objetos de conexión ------------------------------------------------------
int ban=0;
try{
	if(request.getParameter("Submit").equals("Validar"))
	{
		rset=stmt.executeQuery("select cla_uni from usuarios where nombre='"+request.getParameter("txtf_usu")+"' and pass='"+request.getParameter("txtf_pass")+"' ");
		while(rset.next()){
			response.sendRedirect("rep_reabastecimiento.jsp?cla_uni="+rset.getString("cla_uni"));
			ban=1;
		}
		
		if (ban==0)
		{
			%>
			<script>
			alert("Datos Incorrectos");
			</script>
			<%	
		}
	} 
}catch(Exception e){
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.:VALIDACI&Oacute;N USUARIO:.</title>
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
if (document.form.txtf_usu.value==""){
document.form.txtf_usu.focus();
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
.Estilo10 {color: #FFFFFF}
-->
</style></head>

<body onLoad="foco_inicial();">
<table width="666" height="346" border="3" align="center" cellpadding="2" bgcolor="#FFFFFF">
  <tr>
  
    <td width="650"><form id="form" name="form" method="get" action="">
      <table width="650" height="323" border="0" align="center" cellpadding="2">
        <tr>
          <td height="49" bgcolor="#FFFFFF" class="logo style1"><div align="center" class="logo style1">
            <img src="imagenes/nay_ima1.jpg" width="142" height="72" />
          </div></td>
          <td height="49" colspan="2" bgcolor="#FFFFFF" class="logo style1"><div align="center">Validaci&oacute;n de Usuario<br />
          REPORTE DE REABASTECIMIENTO</div></td>
          <td height="49" bgcolor="#FFFFFF" class="logo style1"><img src="imagenes/ssn.jpg" width="162" height="78" /></td>
        </tr>
        <tr>
          <td height="14" colspan="4" bgcolor="#EC3237"><a href="index.jsp" class="Estilo10">Regresar a Menú </a></td>
          </tr>
        <tr>
          <td width="142" height="20">&nbsp;</td>
          <td width="121" class="bodyText"><label></label></td>
          <td width="198">&nbsp;</td>
          <td width="163">&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left" class="Estilo6"></div>
          </div></td>
          <td class="style5"><label><span class="Estilo6">Ingrese Usuario  :</span></label></td>
          <td class="style5"><input name="txtf_usu" type="text" id="txtf_usu" onKeyPress="return handleEnter(this, event)" size="15"/></td>
          <td class="style5">&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left" class="Estilo6"></div>
          </div></td>
          <td class="style5"><label><span class="Estilo6">Password: </span></label></td>
          <td class="style5"><input name="txtf_pass" type="password" id="txtf_pass" onChange="mayNomm(this.form)" onKeyPress="return handleEnter(this, event)"  size="15" /></td>
          <td>&nbsp;</td>
        </tr>
       
       
        
        <tr>
          <td height="20">&nbsp;</td>
          <td colspan="2"><div align="center">
            <input type="submit" name="Submit" value="Validar" />&nbsp;&nbsp;
          &nbsp;</div>
          </div></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td colspan="2">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20" colspan="4" align="center"><img src="imagenes/ima_main.jpg" width="471" height="72" /></td>
          </tr>
      </table>
          </form>
    </td>
  </tr>
</table>
<%  //----- CIERRE DE LAS CONEXIONES  ------
con.close();       
%>
</body>
</html>
