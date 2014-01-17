<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
/*------------------------------------------------------------------------------------------
Nombre de archivo: index_carga_clave.jsp
Funcion: Valida entrada de Usuario Administrador
  -----------------------------------------------------------------------------------------*/
// Conexión BDD vía JDBC
Class.forName("org.gjt.mm.mysql.Driver");
Connection conn__001 = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt02 = conn__001.createStatement();
ResultSet rset_002=null;
// fin conexión --------
// Variables de entorno
String ap_jv="",am_jv="",mensaje="";
String but="r";
int cont6=0;
// fin variables
// si se oprime el botón 
try { 
        but=""+request.getParameter("Submit");
    }catch(Exception e){System.out.print("not");} 
// inicio del proceso validar	
	if(but.equals("Validar"))
     {
		 am_jv=request.getParameter("txtf_usu");
		 ap_jv=request.getParameter("txtf_pass");
		 rset_002=stmt02.executeQuery("select id_usu from usuarios where nombre='"+am_jv+"' and pass='"+ap_jv+"' and rol='2' ");
		 while(rset_002.next())
		 {
		    cont6++;
		 }
		 
		if (cont6>0)
		{
		%>
		<script>
alert("Datos correctos");
self.location='carga_clave.jsp?id_usu=<%=request.getParameter("id_usu")%>'
</script>
<%
		}else{
	%>
		<script>
alert("Datos Incorrectos");
self.location='index_carga_clave.jsp?id_usu=<%=request.getParameter("id_usu")%>'
</script>
<%	
		}
	 } 
// fin del proceso validar	  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.:VALIDACI&Oacute;N USUARIO:.</title>
<script language="javascript" src="list02.js"></script>
<script>
function foco_inicial(){
if (document.form.txtf_usu.value==""){
document.form.txtf_usu.focus();
}

}
</script>
<link rel="stylesheet" href="mm_restaurant1.css" type="text/css" />
</head>

<body onLoad="foco_inicial();">
<table width="666" height="346" border="3" align="center" cellpadding="2" bgcolor="#FFFFFF">
  <tr>
  
    <td width="650"><form id="form" name="form" method="post" action="index_carga_clave.jsp?id_usu=<%=request.getParameter("id_usu")%>">
      <table width="650" height="323" border="0" align="center" cellpadding="2">
        <tr>
          <td height="49" bgcolor="#FFFFFF" class="logo style1"><div align="center" class="logo style1"><img src="imagenes/nay_ima1.jpg" width="142" height="72" /></div></td>
          <td height="49" colspan="2" bgcolor="#FFFFFF" class="logo style1"><div align="center">Validaci&oacute;n de Usuario </div></td>
          <td height="49" bgcolor="#FFFFFF" class="logo style1"><img src="imagenes/ssn.jpg" width="156" height="65" /></td>
        </tr>
        <tr>
          <td height="14" colspan="4" bgcolor="#EC3237"><span class="style2"></span></td>
          </tr>
        <tr>
          <td width="142" height="20">&nbsp;</td>
          <td width="154" class="bodyText"><label></label></td>
          <td width="171">&nbsp;</td>
          <td width="157">&nbsp;</td>
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
          &nbsp;Cerrar Aplicación <button name="boton" type="button" class="style7" onClick="CloseWin()" /><img src="imagenes/borr.jpg" /></button></div></div></td>
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
