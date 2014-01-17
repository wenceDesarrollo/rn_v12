<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*"
         import="java.io.*" import="javax.swing.*" errorPage="" %>
         <%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
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
// Variables de entorno
    String t1a_jv = "", t2a_jv = "", t3a_jv = "", t1b_jv = "", t2b_jv = "", t3b_jv = "", t1c_jv = "", t2c_jv = "", t3c_jv = "", noaf_jv = "", nom_jv = "", ap_jv = "", am_jv = "", fechana = "", fechaini = "", fechafin = "", nombre1_jv = "", programa_jv = "", nom_unidad = "", no_jur = "", edad = "", sexo_jv = "", mensaje = "", noafa_jv = "";
    String but = "r";
// fin variables
// si se oprime el botón 
    try {
        but = "" + request.getParameter("Submit");
    } catch (Exception e) {
        System.out.print("not");
    }
// inicio proceso guardar	
    if (but.equals("Guardar")) {
        noaf_jv = request.getParameter("txtf_noaf");
        noafa_jv = request.getParameter("txtf_noaf2");
        nom_jv = request.getParameter("txtf_nom");
        ap_jv = request.getParameter("txtf_ap");
        am_jv = request.getParameter("txtf_am");
        programa_jv = request.getParameter("programa");
        edad = request.getParameter("txtf_edad");
        sexo_jv = request.getParameter("slct_sexo");
        fechana = request.getParameter("fec_nac");
        fechaini = request.getParameter("vig_ini");
        fechafin = request.getParameter("vig_fin");
        nombre1_jv = request.getParameter("txtf_nom");
        //out.print("update seguro_p2 set folio='"+noaf_jv+"', a_paterno='"+ap_jv+"', a_materno='"+am_jv+"', nombre1='"+nom_jv+"', nombre='"+nombre1_jv+"', f_inicio='"+fechaini+"', f_fin='"+fechafin+"', programa= '"+programa_jv+"', edad='"+edad+"', fecha_naci='"+fechana+"',sexo='"+sexo_jv+"' where folio='"+noaf_jv+"';");
        stmt.execute("update pacientes set num_afi='" + noaf_jv + "', nom_pac='" + nombre1_jv + "', ini_vig='" + df.format(df2.parse(fechaini)) + "', fin_vig='" + df.format(df2.parse(fechafin)) + "', tip_cob= 'SP', fec_nac='" + df.format(df2.parse(fechana)) + "', web = '0' ,sexo='" + sexo_jv + "' where num_afi='" + noafa_jv + "';");


%>
<script>
    alert("DATOS GUARDADOS")
</script>
<%
    }
// fin proceso guardar -------------------------------


//-----------------Eliminar-------------------------------------

    if (but.equals("Eliminar")) {
        noaf_jv = request.getParameter("txtf_noaf");
        String qry_elimina = "delete from pacientes where folio='" + noaf_jv + "'";
        //out.print(qry_elimina);
        stmt.execute(qry_elimina);
        noaf_jv = "";

%>
<script>
    alert("REGISTRO ELIMINADO");
    location.href = "edita_paciente.jsp";
</script>
<%

    }

//------------------------------------------------------

//out.print(but);
    String folio = "", nombre = "", ape_pat = "", ape_mat = "", nacimiento = "", edad1 = "", sexo = "", programa = "", vig_ini = "", vig_fin = "", anio1 = "", mes1 = "", dia1 = "", id = "";

    if (but.equals("Ver")) {
        folio = request.getParameter("txtf_noaf2");
        //out.print(folio);
        if (folio == null) {
            folio = "";
        }
        String qry_paciente = "select * from pacientes where num_afi= '" + folio + "'";

        rset = stmt.executeQuery(qry_paciente);
        while (rset.next()) {
            nombre = rset.getString("nom_pac");
            nacimiento = df2.format(df.parse(rset.getString("fec_nac")));
            sexo = rset.getString("sexo");
            programa = rset.getString("tip_cob");
            vig_ini = df2.format(df.parse(rset.getString("ini_vig")));
            vig_fin = df2.format(df.parse(rset.getString("fin_vig")));
        }
        if (nombre.equals("")) {
            folio = "";
%>
<script>alert("Folio Inexistente");</script>
<%
        }
    }


%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>.: Crear Nuevo Paciente:.</title>
	<link rel="stylesheet" href="css/cupertino/jquery-ui-1.10.3.custom.css" />
    <script language="javascript" src="pacienteMedico.js"></script>
    <script language="javascript" src="list02.js"></script>

    <link rel="stylesheet" href="mm_restaurant1.css" type="text/css"/>
</head>

<body>
<form id="form" name="form" method="post" action="edita_paciente.jsp">
    <table width="650" height="335" border="3" align="center" cellpadding="2" bgcolor="#FFFFFF">
        <tr>
            <td width="731">
                <table width="650" height="369" border="0" align="center" cellpadding="2">
                    <tr>
                        <th width="142" height="82" scope="row"><label><img src="imagenes/nay_ima1.jpg" width="142"
                                                                            height="72"/><br/>
                        </label></th>
                        <td colspan="2">
                            <div align="center" class="pageHeader style7">
                                <p class="style8">Editar al Paciente </p>
                            </div>
                            <label></label>
                            <label></label></td>
                        <td width="163"><img src="imagenes/ssn.jpg" width="162" height="78"/></td>
                    </tr>
                    <tr>
                        <th height="14" colspan="4" bgcolor="#EC3237" scope="row"><span class="style11"></span></th>
                    </tr>
                    <tr>
                        <th height="26" scope="row">
                            <div align="center"></div>
                        </th>
                        <td width="161">
                            <div align="left" class="Estilo1"><strong>No. AFILIACION</strong>:</div>
                        </td>
                        <td width="158"><input name="txtf_noaf2" type="text" id="txtf_noaf2"
                                               onkeypress="validar(event);" value="<%=folio%>"/></td>
                        <td><input type="submit" name="Submit" value="Ver"/></td>
                    </tr>
                    <tr>
                        <th height="26" scope="row">&nbsp;</th>
                        <td><span class="style5">
                                        <label></label>
                                    </span>

                            <div align="left" class="Estilo1"><strong>Nuevo No. AFILIACION</strong>:
                            </div>
                        </td>
                        <td><input name="txtf_noaf" type="text" id="txtf_noaf" onKeyPress="validar(event);"
                                   value="<%=folio%>"/></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <th height="26" scope="row">&nbsp;</th>
                        <td class="bodyText">
                            <div align="left" class="Estilo1"><strong>NOMBRE(s)</strong>:
                                <label></label>
                            </div>
                        </td>
                        <td><span class="bodyText"><span class="style5">
                                            <input name="txtf_nom" type="text" id="txtf_nom"
                                                   onKeyPress="return handleEnter(this, event)"
                                                   onChange="mayNom(this.form)" value="<%=nombre%>"/>
                                        </span></span></td>
                        <td><input type="submit" name="Submit" value="Eliminar"
                                   onClick="return confirm('Desea Eliminarlo');"/></td>
                    </tr>
                    <tr>
                        <th height="28" scope="row">&nbsp;</th>
                        <td class="bodyText">
                            <div align="left" class="Estilo1">FECHA DE NACIMIENTO:</div>
                        </td>
                        <td><span class="bodyText"><div align="left" class="Estilo1"><input name="fec_nac" id="fec_nac" value="<%=nacimiento%>" /></div></span></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <th height="26" scope="row">&nbsp;</th>
                        <td class="bodyText">
                            <div align="left" class="Estilo1"><strong>SEXO:</strong>
                                <label></label>
                            </div>
                        </td>
                        <td>
                            <select name="slct_sexo" id="slct_sexo" class="style13"
                                    onChange="focus_inicioVig(this.form)">
                                <option value = "Escoja Genero">-- Escoja G&eacute;nero --</option>
                                <option value="M">Masculino</option>
                                <option value="F">Femenino</option>
                            </select></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <th height="11" scope="row">&nbsp;</th>
                        <td bordercolor="#FF0000" bgcolor="#CCCCCC" class="style5">
                            <div align="left" class="Estilo1">DATOS DE LA POLIZA</div>
                        </td>
                        <td class="style5">&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                   <tr>
                        <th height="13" scope="row">&nbsp;</th>
                        <td>
                            <div align="left" class="Estilo1"><strong>FECHA DE INICIO VIGENCIA </strong>:</div>
                        </td>
                        <td>
                            <div align="left" class="Estilo1">
                              <input name="vig_ini" id="vig_ini" value="<%=vig_ini%>" />
                            </div>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    
                    <tr>
                        <th height="26" scope="row">&nbsp;</th>
                        <td>
                            <div align="left" class="Estilo1"><strong>FECHA DE FIN VIGENCIA </strong>:</span></div>
                        </td>
                        <td>
                            <div align="left" class="Estilo1">
                              <input name="vig_fin" id="vig_ini" value="<%=vig_fin%>" />
                            </div>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <th height="18" scope="row">&nbsp;</th>
                        <td colspan="2">
                            <div align="center"></div>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <th height="47" scope="row">&nbsp;</th>
                        <td colspan="2">
                            <div align="center">
                                <input type="submit" name="Submit" value="Guardar"
                                       onClick="return verificaPaciente(document.forms.form)"/>
                                &nbsp;Cerrar Aplicaci&oacute;n
                                <button name="boton" type="button" class="style7" onClick="CloseWin()"/>
                                <img src="imagenes/borr.jpg"/></button></div>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <p>&nbsp;</p>

    <p>&nbsp;</p>
</form>
<%
 con.close();
%>
</body>
</html>
<script src="jqry/jquery-1.9.1.js"></script>
<script src="jqry/jquery-ui-1.10.3.custom.js"></script>
<script>
    $(function() {
        $("#fec_nac").datepicker({dateFormat: "dd/mm/yy"}).val()
    });
	$(function() {
        $("#vig_ini").datepicker({dateFormat: "dd/mm/yy"}).val()
    });
	$(function() {
        $("#vig_fin").datepicker({dateFormat: "dd/mm/yy"}).val()
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