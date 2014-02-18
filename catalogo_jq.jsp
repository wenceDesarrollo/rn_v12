<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" import="java.sql.*" errorPage="" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("ddMMyyyy"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("HH:mm:ss"); %>
<%
//  Conexión a la BDD -------------------------------------------------------------
Class.forName("org.gjt.mm.mysql.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset= null;
// fin objetos de conexión ------------------------------------------------------
    String but = "", clave = "", descrip = "", present = "", id_med = "", cs_jv = "", descr_jv = "";


    try {
        but = "" + request.getParameter("submit");
        //out.print(but);
    } catch (Exception e) {
        System.out.print("not");
    }

    if (but.equals("Clave")) {
        cs_jv = request.getParameter("clave_med");
        if (!cs_jv.equals("")) {
            String qry_cen_sad = "select cla_pro, des_pro, tip_pro, pres_pro from productos where cla_pro = '" + cs_jv + "'";

            rset = stmt.executeQuery(qry_cen_sad);
            while (rset.next()) {
                clave = rset.getString("cla_pro");
                descrip = rset.getString("des_pro");
                present = rset.getString("pres_pro");
                id_med = rset.getString("tip_pro");
            }
        } else {
%>
<script>alert("Ingrese la Clave");</script>
<%
        }
    }

    if (but.equals("Descripcion")) {
        descr_jv = request.getParameter("country");
        if (!descr_jv.equals("")) {
            String qry_cen_sad = "select cla_pro, des_pro, tip_pro, pres_pro from productos where des_pro = '" + descr_jv + "'";
            //out.print (qry_cen_sad);
            rset = stmt.executeQuery(qry_cen_sad);
            while (rset.next()) {
                clave = rset.getString("cla_pro");
                descrip = rset.getString("des_pro");
                present = rset.getString("pres_pro");
                id_med = rset.getString("tip_pro");
            }
        } else {
%>
<script>alert("Ingrese la Clave");</script>
<%
        }
    }

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script>
    function focus_locus() {
        if (document.form1.clave.value == "") {
            document.form1.clave_med.focus();
        } else {
            document.form2.cant.focus();
        }
    }
    function tufuncion(e) {
        tecla = (document.all) ? e.keyCode : e.which;
        if (tecla == 13) {
            document.getElementById("Capturar").focus();
        }
    }
</script>
<script src="jqry/ui/jquery-1.8.3.js"></script>
<script src="jqry/ui/jquery-ui.js"></script>
<script src="jqry/ui/jquery.ui.autocomplete.js"></script>
<link rel="stylesheet" href="jqry/themes/base/jquery-ui.css"/>

<script>
var data = [
	<%
	rset = stmt.executeQuery("select cla_pro, des_pro from productos ");
	while(rset.next()){
		out.println("\""+rset.getString("des_pro")+"\",\n");
	}
	%>
];
</script>
<link rel="stylesheet" type="text/css" href="css/style.css"/>
<link rel="stylesheet" type="text/css" href="css/botones.css"/>
<style type="text/css">
    body {
        background-color: #F9F9F9;
    }

    body, td, th {
        font-family: Verdana, Geneva, sans-serif;
    }

    a:link {
        color: #FFFFFF;
    }

    a:visited {
        color: #FFFFFF;
    }

    a:hover {
        color: #FFFFFF;
    }

    a:active {
        color: #FFFFFF;
    }
</style>
<title>Sistema de Captura de Invetarios</title>
</head>
<body onLoad="focus_locus();">

<form style="margin:0px" name="form1">

    <div style=" margin: 50px auto;" class="letra">

        <H1>CATÁLOGO DE INSUMOS Y MATERIAL DE CURACIÓN</H1>
    </div>
    <div style="height:20px; background-color:#F00; margin-bottom:25px;"><a href="index.jsp">Regresar</a></div>
    <div style=" background-color:#FFFFFF; width:1000px; padding:10px;">
        <div style="width: 1000px; margin:auto; background-color:#FFFFFF; margin:auto;" class="letra"><br/><br/>
            <table width="793" align="center">
                <tr>
                    <td width="117">Clave</td>
                    <td width="441"><input type="text" value="" name="clave_med" id="clave_med" size="15"/> <input type="submit"
                                                                                                       name="submit"
                                                                                                       value="Clave"/>
                        <br/><input type="text" id="country" name="country" class="input_text" size="60"/><input
                                type="submit" name="submit" value="Descripcion"/></td>
                    <td width="51"><!--Descripcion<input type="text" id="country" name="country" class="input_text"/--></td>
                    <td width="150">&nbsp;</td>
                    <td width="10"></td>
                </tr>
                <tr>
                    <td colspan="4"><hr /></td>
                </tr>
                <tr>
                    <td>Descripción</td>
                    <td><textarea name="descrip" cols="70" readonly id="descrip"><%=descrip%></textarea></td>
                    <td>Clave</td>
                    <td><input type="text" value="<%=clave%>" name="clave" id="clave" size="15" readonly/></td>
                </tr>
                <tr>
                    <td>Presentación</td>
                    <td><input type="text" value="<%=present%>" name="present" id="present" size="60" readonly/></td>
                    <td>Tipo</td>
                    <td><input type="text" value="<%=id_med%>" name="tipo" id="tipo" size="30" readonly/></td>
                </tr>
            </table>
        </div>
    </div>
</form>


</body>
<script>
    $(function () {
        $("#country").autocomplete(
                {
                    source: data
                });
    });
</script>
<%
con.close();
%>
</html>