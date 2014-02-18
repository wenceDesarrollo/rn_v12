<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
/*------------------------------------------------------------------------------------------
Nombre de archivo: medico.jsp
Funcion: Guarda datos del Médico
  -----------------------------------------------------------------------------------------*/
// Conexión BDD vía JDBC
Class.forName("org.gjt.mm.mysql.Driver");
Connection conn__001 = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = conn__001.createStatement();
ResultSet rset= null;
// fin conexión --------
// Variables de entorno
String noaf_jv="",nom_jv="",ap_jv="",am_jv="",nombre1_jv="",mensaje="";
String but="r";
// fin variables 
// Para obtener el botón oprimido
try { 
        but=""+request.getParameter("Submit");
}catch(Exception e){System.out.print("not");} 
	
// inicio proceso Guardar --------------
if(but.equals("Guardar"))
   {
	 int ban_pac = 0;
	 
	 noaf_jv=request.getParameter("txtf_ced");
	 nom_jv=request.getParameter("txtf_nom");
	 ap_jv=request.getParameter("txtf_pat");
	 am_jv=request.getParameter("txtf_mat");
	 nombre1_jv=nom_jv+" "+ap_jv+" "+am_jv;
	 
	 String qry_comp_med="select cedula from medicos where cedula = '"+noaf_jv+"'";
	  rset = stmt.executeQuery(qry_comp_med);
	  while (rset.next()) {
		  ban_pac = 1;
	  }
	 
	 if (ban_pac==0){
	 	stmt.execute("insert into medicos values ('"+nombre1_jv+"','"+noaf_jv+"', '0')");
		 %>
	 <script>
	 alert("DATOS GUARDADOS")
	 </script>
	 <%
	 } else {
		  %>
	 <script>
	 alert("MEDICO YA EXISTENTE")
	 </script>
	 <%
	 }
	
   }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.: Datos Medico:.</title>
<script language="javascript" src="pacienteMedico.js">
</script>
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

<link rel="stylesheet" href="mm_restaurant1.css" type="text/css" />
</head>

<body>
<table width="688" height="346" border="3" align="center" cellpadding="2" bgcolor="#FFFFFF">
  <tr>
    <td width="650"><form id="form" name="form" method="post" action="">
      <table width="662" height="323" border="0" align="center" cellpadding="2">
        <tr>
          <td height="49" bgcolor="#FFFFFF" class="logo style1"><div align="center" class="logo style1"><img src="imagenes/nay_ima1.jpg" width="142" height="72" /></div></td>
          <td height="49" colspan="2" bgcolor="#FFFFFF" class="logo style1"><div align="center">Datos del M&eacute;dico</div></td>
          <td height="49" bgcolor="#FFFFFF" class="logo style1"><img src="imagenes/ssn.jpg" width="156" height="65" /></td>
        </tr>
        <tr>
          <td height="14" colspan="4" bgcolor="#EC3237"><span class="style2"></span></td>
          </tr>
        <tr>
          <td width="142" height="20">&nbsp;</td>
          <td width="202" class="bodyText"><div align="right"></div>            
          <label></label></td>
          <td width="146">&nbsp;</td>
          <td width="146">&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right"></div></td>
          <td class="style5"><div align="left" class="Estilo6">C&Eacute;DULA PROFESIONAL :</div></td>
          <td><label>
            <input name="txtf_ced" type="text" id="txtf_ced" onKeyPress="return handleEnter(this, event)"/>
          </label></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right"></div></td>
          <td class="style5"><div align="left" class="Estilo6">NOMBRE: </div></td>
          <td><label>
            <input name="txtf_nom" type="text" id="txtf_nom" onKeyPress="return handleEnter(this, event)" onChange="mayNomm(this.form)" />
          </label></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right"></div></td>
          <td class="style5"><div align="left" class="Estilo6">APELLIDO PATERNO:</div></td>
          <td><label>
            <input name="txtf_pat" type="text" id="txtf_pat" onKeyPress="return handleEnter(this, event)" onChange="mayApepm(this.form)"/>
          </label></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right"></div></td>
          <td class="style5"><div align="left"><span class="Estilo6">APELLIDO MATERNO:
          </span></div>            
          <span class="style5"><label></label>
              </span></td>
          <td><label>
          <input name="txtf_mat" type="text" id="txtf_mat" onKeyPress="return handleEnter(this, event)" onChange="mayApemm(this.form)"/>
          </label></td>
          <td>&nbsp;</td>
        </tr>
        
        <tr>
          <td height="20">&nbsp;</td>
          <td colspan="2"><label>
            <span class="style5">
            <label></label>
            <div align="center"><a href="edita_medico.jsp">Editar Medico</a></div>
          </label></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td colspan="2"><div align="center">
            <input type="submit" name="Submit" value="Guardar" onClick="return verificaMedico(document.forms.form)"  />
          &nbsp;Cerrar Aplicación <button name="boton" type="button" class="style7" onClick="CloseWin()" /><img src="imagenes/borr.jpg" /></button></div></div></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td colspan="2"><div align="center">
          <%
		  if(but.equals("Guardar"))
   			{
			 int ban_pac = 0;
	 
	 
			 out.print("Nombre del medico: "+nombre1_jv+"<br>");
			 out.print("Cedula del Medico: "+noaf_jv+"<br>");
			 
	
		   }
		  %>
          </div>
           </td>
          <td>&nbsp;</td>
        </tr>
      </table>
          </form>
    </td>
  </tr>
</table>
<%
// ----- try que cierra la conexión a la base de datos
		 try{
               // Se cierra la conexión dentro del try
                 conn__001.close();
	          }catch (Exception e){mensaje=e.toString();}
           finally{ 
               if (conn__001!=null){
                   conn__001.close();
		                if(conn__001.isClosed()){
                             mensaje="desconectado2";}
                 }
             }
			 //out.print(mensaje);
		// ---- fin de la conexión	 	  

%>
</body>
</html>
