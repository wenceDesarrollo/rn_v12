<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" import="java.util.Date" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyyMMddHHmmss"); %>
<%
/*------------------------------------------------------------------------------------------
Nombre de archivo: paciente.jsp
Funcion: Guarda datos del Paciente
  -----------------------------------------------------------------------------------------*/
// Conexión BDD vía JDBC
Class.forName("org.gjt.mm.mysql.Driver"); 
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset=null;
// fin conexión --------
String no_af="";
String but="", nombre="", fec_nac="";
try{
        but=request.getParameter("submit");
} catch (Exception e){

}
if (but!=null){
        if(but.equals("Guardar"))
        {
		no_af=request.getParameter("txtf_noaf");
		if (!request.getParameter("programa").equals("SP")){
		no_af=df.format(new Date())+request.getParameter("id_usu");
		}
        nombre = request.getParameter("txtf_nom")+" "+request.getParameter("txtf_ap")+" "+request.getParameter("txtf_am");
	    fec_nac = request.getParameter("txtf_t3a")+"-"+request.getParameter("txtf_t2a")+"-"+request.getParameter("txtf_t1a");
	    String ini_vig = request.getParameter("txtf_t3b")+"-"+request.getParameter("txtf_t2b")+"-"+request.getParameter("txtf_t1b");
	    String fin_vig = request.getParameter("txtf_t3c")+"-"+request.getParameter("txtf_t2c")+"-"+request.getParameter("txtf_t1c");
		try{
        stmt.execute("insert into pacientes values ('"+nombre+"', '"+fec_nac+"', '"+request.getParameter("slct_sexo")+"', '"+no_af+"', '"+request.getParameter("programa")+"', '"+ini_vig+"', '"+fin_vig+"', '0')");
		} catch(Exception e){
			%>
				<script>alert("Paciente ya capturado")</script>
				<script>window.locationf="paciente.jsp";</script>
			<%
		}
        }
}
// ---------------------
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>.: Crear Nuevo Paciente:.</title>

        <script language="javascript" src="pacienteMedico.js"></script>
        <script language="javascript" src="list02.js"></script>
        <script>

            function inicio() {
                document.getElementById('mensaje').style.display = "none";
            }

            function tipo_ser(val) {

                if (val != "SP") {
                    document.getElementById('f_ini_div').disabled = true;
                    document.getElementById('f_fin_div').disabled = true;
                    document.getElementById('txtf_noaf').disabled = true;
                    document.getElementById('txtf_noaf').value = "-";
                    document.getElementById('fechadia_id').value = "";
                    document.getElementById('fechames_id').value = "";
                    document.getElementById('fechaano_id').value = "";
                    document.getElementById('fecha_diav').value = "";
                    document.getElementById('fecha_mesv').value = "";
                    document.getElementById('fecha_anov').value = "";
                    document.getElementById('mensaje').style.display = "block";
                    document.getElementById('txtf_noaf').focus();
                }
                else {
                    document.getElementById('f_ini_div').disabled = false;
                    document.getElementById('f_fin_div').disabled = false;
                    document.getElementById('txtf_noaf').disabled = false;
                    document.getElementById('mensaje').style.display = "none";
                }
            }
        </script>

        <link rel="stylesheet" href="mm_restaurant1.css" type="text/css" />
    </head>

    <body onLoad="inicio()">
        <form id="form" name="form" method="post" action="paciente.jsp?id_usu=<%=request.getParameter("id_usu")%>">
            <table width="650" height="335" border="3" align="center" cellpadding="2" bgcolor="#FFFFFF">
                <tr>
                    <td width="731"><table width="650" height="478" border="0" align="center" cellpadding="2">
                            <tr>
                                <th width="142" height="82" scope="row"><label><img src="imagenes/nay_ima1.jpg" width="142" height="72" /><br />
                                    </label></th>
                                <td colspan="2"><div align="center" class="pageHeader style7">
                                        <p class="style8">Datos del Paciente</p>
                                    </div>
                                    <label></label>
                                    <label></label></td>
                                <td width="163"><img src="imagenes/ssn.jpg" width="162" height="78" /></td>
                            </tr>
                            <tr>
                                <th height="14" colspan="4" bgcolor="#EC3237" scope="row">&nbsp;</th>
                            </tr>
                            <tr>
                                <th height="26" colspan="4" scope="row"><div align="center" style="font-size:12px" >*Si el paciente es de OP o PA NO CAPTURAR No. de Afiliaci&oacute;n, ESCOJA PROGRAMA*</div></th>
                            </tr>
                            <tr>
                                <th height="26" scope="row">&nbsp;</th>
                                <td width="161"><span class="style5">
                                        <label></label>
                                    </span><div align="left" class="Estilo1"><strong>No. AFILIACION</strong>:
                                    </div></td>
                                <td width="158"><input name="txtf_noaf" type="text" id="txtf_noaf"  onKeyPress="validar(event);"/></td>
                                <td><div id="mensaje" >Se generar&aacute; Autom&aacute;ticamente el no. de Afiliaci&oacute;n</div></td>
                            </tr>
                            <tr>
                                <th height="26" scope="row">&nbsp;</th>
                                <td class="bodyText"><div align="left" class="Estilo1"><strong>NOMBRE(s)</strong>:
                                        <label></label>
                                    </div></td>
                                <td><span class="bodyText"><span class="style5">
                                            <input name="txtf_nom" type="text" id="txtf_nom" onKeyPress="return handleEnter(this, event)" onChange="mayNom(this.form)"/>
                                        </span></span></td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th height="26" scope="row">&nbsp;</th>
                                <td class="bodyText"><div align="left" class="Estilo1"><strong>APELLIDO PATERNO:</strong>
                                        <label></label>
                                    </div></td>
                                <td><span class="bodyText"><span class="style5">
                                            <input name="txtf_ap" type="text" id="txtf_ap" onKeyPress="return handleEnter(this, event)" onChange="mayApep(this.form)"/>
                                        </span></span></td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th height="26" scope="row">&nbsp;</th>
                                <td class="bodyText"><div align="left" class="Estilo1"><strong>APELLIDO MATERNO:</strong>
                                        <label></label>
                                    </div></td>
                                <td><span class="bodyText"><span class="style5">
                                            <input name="txtf_am" type="text" id="txtf_am" onKeyPress="return handleEnter(this, event)" onChange="mayApem(this.form)"/>
                                        </span></span></td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th height="28" scope="row">&nbsp;</th>
                                <td class="bodyText"><div align="left" class="Estilo1">FECHA DE NACIMIENTO: </div></td>
                                <td><span class="bodyText"><div align="left" class="Estilo1">

                                            <input name="txtf_t1a" id="txtf_t1a" type="text" onKeyPress="return handleEnter(this, event)" onKeyUp="putDaysa()"  size="1" maxlength="2"/>
                                            <strong>                    /</strong>
                                            <input name="txtf_t2a" id="txtf_t2a" type="text" size="1" maxlength="2" onKeyUp="putMonthssa()"  onKeyPress="return handleEnter(this, event)" />
                                            <strong>                    /</strong>
                                            <input name="txtf_t3a" id="txtf_t3a" type="text" size="2" maxlength="4" onKeyUp="putYearssa(this.form)" onKeyPress="return handleEnter(this, event)" />
                                        </div></span></td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th height="26" scope="row">&nbsp;</th>
                                <td class="bodyText"><div align="left" class="Estilo1"><strong>SEXO:</strong>
                                        <label></label>
                                    </div></td>
                                <td>
                                    <select name="slct_sexo" id="slct_sexo" class="style13" onChange="focus_inicioVig(this.form)">
                                        <option value="Escoja Genero">-- Escoja G&eacute;nero --</option>
                                        <option value="M">Masculino</option>
                                        <option value="F">Femenino</option>
                                    </select></td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th height="23" scope="row">&nbsp;</th>
                                <td class="style5"><div align="left" class="Estilo1">PROGRAMA: </div></td>
                                <td class="style5"><select name="programa" class="style13" id="programa" onChange="tipo_ser(this.value);" >
                                        <option value="SP">SEGURO POPULAR</option>
                                        <option value="PA">POBLACION ABIERTA</option>
                                        <option value="OP">OPORTUNIDADES</option>
                                    </select></td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th height="11" scope="row">&nbsp;</th>
                                <td bordercolor="#FF0000" bgcolor="#CCCCCC" class="style5"><div align="left" class="Estilo1">DATOS DE LA POLIZA</div></td>
                                <td class="style5">&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th height="13" scope="row">&nbsp;</th>
                                <td><div align="left" class="Estilo1"><strong>FECHA DE INICIO VIGENCIA </strong>: </div></td>
                                <td><div align="left" class="Estilo1" id="f_ini_div">

                                        <input name="txtf_t1b" type="text" id="fechadia_id" onKeyPress="return handleEnter(this, event)" onKeyUp="putDaysb()"  size="1" maxlength="2"/>
                                        <strong>                    /</strong>
                                        <input name="txtf_t2b" type="text" id="fechames_id" size="1" maxlength="2" onKeyUp="putMonthssb()"  onKeyPress="return handleEnter(this, event)" />
                                        <strong>                    /</strong>
                                        <input name="txtf_t3b" type="text" id="fechaano_id" size="2" maxlength="4" onKeyUp="putYearssb(this.form)"  onKeyPress="return handleEnter(this, event)" />
                                    </div></td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th height="26" scope="row">&nbsp;</th>
                                <td><div align="left" class="Estilo1"><strong>FECHA DE FIN VIGENCIA </strong>:</span></div></td>
                                <td><div align="left" class="Estilo1" id="f_fin_div">

                                        <input name="txtf_t1c" id="fecha_diav" type="text" onKeyPress="return handleEnter(this, event)" onKeyUp="putDaysc()"  size="1" maxlength="2"/>
                                        <strong>                    /</strong>
                                        <input name="txtf_t2c"  id="fecha_mesv" type="text" size="1" maxlength="2" onKeyUp="putMonthssc()"  onKeyPress="return handleEnter(this, event)" />
                                        <strong>                    /</strong>
                                        <input name="txtf_t3c"  id="fecha_anov" type="text" size="2" maxlength="4" onKeyUp="putYearssc(this.form)"  onKeyPress="return handleEnter(this, event)" />
                                    </div></td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th height="18" scope="row">&nbsp;</th>
                                <td colspan="2"><div align="center"><a href="edita_paciente.jsp" target="_blank">Editar Paciente</a></div></td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th height="47" scope="row">&nbsp;</th>
                                <td colspan="2"><div align="center">
                                        <input type="submit" name="submit" value="Guardar" onClick="return verificaPaciente(document.forms.form)" />
                                        &nbsp;Cerrar Aplicación <button name="boton" type="button" class="style7" onClick="CloseWin()" /><img src="imagenes/borr.jpg" /></button></div></td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th height="47" scope="row">&nbsp;</th>
                                <td colspan="2"><div align="left">

                                        <%
										if (but!=null){
                                                    if(but.equals("Guardar")){
                                                            out.print("Paciente Capturado:<br>");
                                                            out.print("No de Afiliación: "+no_af);
                                                            out.print("<br>Nombre: "+nombre);
                                                            out.print("<br>Fecha de nacimiento:"+fec_nac);
                                                    }
										}
                                        %>
                                    </div></td>
                                <td>&nbsp;</td>
                            </tr>
                        </table></td>
                </tr>
            </table>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
        </form>
        <%
        
        // ----- try que cierra la conexión a la base de datos
        con.close();
        %>
    </body>
</html>
