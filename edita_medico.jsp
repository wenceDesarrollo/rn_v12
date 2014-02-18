<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
    /*------------------------------------------------------------------------------------------
    Nombre de archivo: medico.jsp
    Funcion: Guarda datos del Médico
      -----------------------------------------------------------------------------------------*/
// Conexión BDD vía JDBC
Class.forName("org.gjt.mm.mysql.Driver"); 
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset=null;
// fin conexión --------
// Variables de entorno
    String noaf_jv = "", nom_jv = "", ap_jv = "", am_jv = "", nombre1_jv = "", mensaje = "", noafa_jv = "";
    String but = "r";
// fin variables 
// Para obtener el botón oprimido
    try {
        but = "" + request.getParameter("Submit");
    } catch (Exception e) {
        System.out.print("not");
    }

// inicio proceso Guardar --------------
    if (but.equals("Guardar")) {
        noaf_jv = request.getParameter("txtf_ced");
        noafa_jv = request.getParameter("txtf_ced2");
        nombre1_jv = request.getParameter("txtf_nom");
        stmt.execute("update medicos set nom_med ='" + nombre1_jv + "', cedula='" + noaf_jv + "', web='0' where cedula = '" + noafa_jv + "'");
%>
<script>
    alert("DATOS GUARDADOS")
</script>
<%
    }
    String nombre = "", ced = "";
//-------------------------------------------

//----------------Ver el medico   

    if (but.equals("Ver")) {
        ced = request.getParameter("txtf_ced2");

        String qry_paciente = "select * from medicos where cedula= '" + ced + "'";
//out.print(qry_paciente);
        rset = stmt.executeQuery(qry_paciente);
        while (rset.next()) {
            nombre = rset.getString("nom_med");
        }
        if (nombre.equals("")) {
            ced = "";
%>
<script>alert("Folio Inexistente");</script>
<%
        }
    }

//---------------------------------

//----------------Eliminar el medico   

    if (but.equals("Eliminar")) {
        ced = request.getParameter("txtf_ced");

        String qry_paciente = "delete from medico where cedula= '" + ced + "'";
//out.print(qry_paciente);
        stmt.execute(qry_paciente);
        ced = "";
    }

//---------------------------------
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
    <title>.: Datos Medico:.</title>
    <script language="javascript" src="pacienteMedico.js">
    </script>
    <script language="javascript" src="list02.js">
        function close1() {//alert("huge");


            top.close();
            /*if(navigator.appName=="Microsoft Internet Explorer") {
             this.focus();self.opener = this;self.close(); }
             else { window.open('','_parent',''); window.close(); }

             */
        }

    </script>

    <link rel="stylesheet" href="mm_restaurant1.css" type="text/css"/>
</head>

<body>
<table width="688" height="346" border="3" align="center" cellpadding="2" bgcolor="#FFFFFF">
    <tr>
        <td width="650">
            <form id="form" name="form" method="post" action="edita_medico.jsp">
                <table width="662" height="323" border="0" align="center" cellpadding="2">
                    <tr>
                        <td height="49" bgcolor="#FFFFFF" class="logo style1">
                            <div align="center" class="logo style1"><img src="imagenes/nay_ima1.jpg" width="142"
                                                                         height="72"/></div>
                        </td>
                        <td height="49" colspan="2" bgcolor="#FFFFFF" class="logo style1">
                            <div align="center">Datos del M&eacute;dico</div>
                        </td>
                        <td height="49" bgcolor="#FFFFFF" class="logo style1"><img src="imagenes/ssn.jpg" width="156"
                                                                                   height="65"/></td>
                    </tr>
                    <tr>
                        <td height="14" colspan="4" bgcolor="#EC3237"><span class="style2"></span></td>
                    </tr>
                    <tr>
                        <td width="142" height="20">&nbsp;</td>
                        <td width="202" class="bodyText">
                            <div align="right">
                                <div align="left" class="Estilo6">C&Eacute;DULA PROFESIONAL :</div>
                            </div>
                            <label></label></td>
                        <td width="146"><input name="txtf_ced2" type="text" id="txtf_ced2"
                                               onkeypress="return handleEnter(this, event)" value="<%=ced%>"/></td>
                        <td width="146"><input type="submit" name="Submit" value="Ver"/></td>
                    </tr>
                    <tr>
                        <td height="20">
                            <div align="right"></div>
                        </td>
                        <td class="style5">
                            <div align="left" class="Estilo6">NUEVA C&Eacute;DULA PROFESIONAL :</div>
                        </td>
                        <td><label>
                            <input name="txtf_ced" type="text" id="txtf_ced"
                                   onKeyPress="return handleEnter(this, event)" value="<%=ced%>"/>
                        </label></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="20">
                            <div align="right"></div>
                        </td>
                        <td class="style5">
                            <div align="left" class="Estilo6">NOMBRE:</div>
                        </td>
                        <td>&nbsp;</td>
                        <td><input type="submit" name="Submit" value="Eliminar"
                                   onClick="return confirm('Desea Eliminarlo');"/></td>
                    </tr>
                    <tr>
                        <td height="20">
                            <div align="right"></div>
                        </td>
                        <td colspan="2" class="style5"><input name="txtf_nom" type="text" id="txtf_nom"
                                                              onKeyPress="return handleEnter(this, event)"
                                                              onChange="mayNomm(this.form)" size="50"
                                                              value="<%=nombre%>"/></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="20">
                            <div align="right"></div>
                        </td>
                        <td class="style5"><span class="style5"><label></label>
                                    </span></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>

                    <tr>
                        <td height="20">&nbsp;</td>
                        <td colspan="2"><label>
                                        <span class="style5">
                                            <label></label>
                                            <div align="center"></div>
                        </label></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="20">&nbsp;</td>
                        <td colspan="2">
                            <div align="center">
                                <input type="submit" name="Submit" value="Guardar"
                                       onClick="return verificaMedico(document.forms.form)"/>
                                &nbsp;Cerrar Aplicación
                                <button name="boton" type="button" class="style7" onClick="CloseWin()"/>
                                <img src="imagenes/borr.jpg"/></button></div>
                            </div></td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
</table>
<%

        con.close();
 
%>
</body>
</html>
