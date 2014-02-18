<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" session="true"
         import="java.util.*" import="java.io.File" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("hh:mm:ss"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("yyyy_MM_dd"); %>
<%
//out.print (val+user+id);
//--------------------------------------------------------
%>

<%
    //---------------------------------------Modulo de Conexion a la BD
    Connection conexion = null;
    Statement stmt = null;
    ResultSet rset = null;

    Connection conexion2 = null;
    Statement stmt2 = null;
    ResultSet rset2 = null;

/*parametros para la conexión*/
    String driver = "org.gjt.mm.mysql.Driver";
    String url_con = "jdbc:mysql://189.197.187.15:3306/abastos";
    String url_con2 = "jdbc:mysql://localhost:3306/receta_electronica";
    String user_con = "root";
    String pass_con = "eve9397";
    String mensaje = "";
  /*procedimiento de la conexion*/
    try {
        Class.forName(driver);
        conexion = DriverManager.getConnection(url_con, "gnkl_rep", "Avxkc4");
        conexion2 = DriverManager.getConnection(url_con2, user_con, pass_con);
         /*guardando la conexion en la session*/
        stmt = conexion.createStatement();
        stmt2 = conexion2.createStatement();
        mensaje = "conectado";
    } catch (Exception ex) {
        mensaje = ex.toString();
    }

    if (conexion.isClosed()) {
        mensaje = "desconectado";
    }
    if (conexion2.isClosed()) {
        mensaje = "desconectado";
    }

//-----------------------------------------------------------------
%>
<%
	String user = request.getParameter("id_usu");
	String cla_uni = request.getParameter("cla_uni");
    String usuario = "", but = "", folio = "", clave = "", descrip = "", lote = "", cad = "", cant = "", cantent = "", ori = "", id_abasto = "", accion = "", id_ab = "", surtido = "", nom_abasto = "";
    int ban = 0, ban_error = 0;
    try {
        accion = request.getParameter("Accion");
        but = request.getParameter("Submit");
        folio = request.getParameter("folio");
    } catch (Exception e) {
        System.out.print("not");
    }
    if (folio == null) {
        folio = "";
    }
//out.print(but);
    rset = stmt.executeQuery("select folio from abasto_unidades where folio = '" + folio + "'");
    while (rset.next()) {
        ban = 1;
    }
    rset = stmt.executeQuery("select surtido from abasto_unidades where folio = '" + folio + "'");
    while (rset.next()) {
        surtido = rset.getString(1);
        if (surtido.equals("1")) {
            ban_error = 1;
        }
    }
//out.print(accion);
    if (accion != null) {
        if (accion.equals("Eliminar")) {
            id_ab = request.getParameter("id_abasto");

            String qry_lee = "SELECT a.ClaPro, p.DesPro, a.ClaLot, a.FecCad, a.CanReq, a.CanEnt, a.Origen, a.Id FROM abastos a INNER JOIN productos p ON a.ClaPro = p.ClaPro INNER JOIN abasto_unidades au ON a.IdAbasto = au.IdAbasto WHERE A.ID = '" + id_ab + "';";
            rset = stmt.executeQuery(qry_lee);
            while (rset.next()) {
                clave = rset.getString(1);
                descrip = rset.getString(2);
                lote = rset.getString(3);
                cad = rset.getString(4);
                cant = rset.getString(5);
                cantent = rset.getString(6);
                ori = rset.getString(7);
                id_abasto = rset.getString(8);

				try{
                stmt2.execute("insert into modificacion_abastos values('" + folio + "', '" + clave + "', '" + descrip + "', '" + lote + "', '" + cad + "', '" + cant + "','" + cantent + "', '" + ori + "', '" + df.format(new java.util.Date()) + "', '" + df2.format(new java.util.Date()) + "', 'ELIMINACION', '0','-','-','-','-', '0')");
				}catch(Exception e){
				out.println(e.getMessage());
				}

            }


            String qry_elimina = "DELETE FROM ABASTOS WHERE ID = '" + id_ab + "'";

            //out.print(qry_elimina);
            stmt.execute(qry_elimina);
        }


    }
//---------------Metodo para cargar el archivo web
    if (but != null) {
        if (but.equals("Cargar")) {

            try {
                folio = request.getParameter("folio2");
            } catch (Exception e) {
                System.out.print("not");
            }
            if (folio == null) {
                folio = "";
            }

            //out.print(folio);
            stmt2.execute("truncate table abasto_web");

            String query_abasto = "SELECT a.ClaPro, p.DesPro, a.ClaLot, a.FecCad, a.CanReq, a.CanEnt, a.Origen, a.Id, au.nomarc FROM abastos a INNER JOIN productos p ON a.ClaPro = p.ClaPro INNER JOIN abasto_unidades au ON a.IdAbasto = au.IdAbasto WHERE Folio = '" + folio + "';";


            rset = stmt.executeQuery(query_abasto);
            while (rset.next()) {
                clave = rset.getString(1);
                descrip = rset.getString(2);
                lote = rset.getString(3);
                cad = rset.getString(4);
                cant = rset.getString(5);
                cantent = rset.getString(6);
                ori = rset.getString(7);
                id_abasto = rset.getString(8);
                nom_abasto = rset.getString(9);

                stmt2.execute("insert into abasto_web values( '" + clave + "', '" + descrip + "', '" + lote + "', '" + cad + "', '" + cantent + "', '" + ori + "' )");
            }

            //Creacion de las carpetas de almacenamiento de los respaldos----------------------------------------------------------
            String carpeta = "c:/abastos_web";
            //out.print(carpeta);
            File file = new File(carpeta);
            boolean directorio = file.mkdir();

            carpeta = "c:/abastos_web/abasto_" + folio + "_" + df.format(new java.util.Date()) + "";
            //out.print(carpeta);
            file = new File(carpeta);
			//---------------------------------
			File fichero = new File("c:/abastos_web/abasto_" + folio + "_" + df.format(new java.util.Date()) + "/" + nom_abasto );
			if (fichero.delete()){
			}
			else
			   System.out.println("El fichero no puede ser borrado");
			//---------------------------------
            directorio = file.mkdir();
            //----------------------------------------------------------------------------------------------------------------------

            String qry_desc = "select * from abasto_web into outfile 'c:/abastos_web/abasto_" + folio + "_" + df.format(new java.util.Date()) + "/" + nom_abasto + "'  FIELDS TERMINATED BY ','  OPTIONALLY ENCLOSED BY '\"'  LINES TERMINATED BY '\r\n'";
            //out.print("<br>"+qry_desc);
            try {
                stmt2.execute(qry_desc);

            } catch (Exception e) {
                ban_error = 1;
                //out.println("Abasto Web Ya generado");
%>
<script>
    alert("Abasto Web Ya generado");
	alert("<%=e.getMessage()%>");
    self.location = 'abasto_web.jsp?id_usu=<%=user%>&cla_uni=<%=cla_uni%>';
</script>
<%
    }
%>
<script>
    self.location = 'csv_abasto.jsp?archivo=c:/abastos_web/abasto_<%=(folio+"_"+df.format(new java.util.Date()))%>/<%=nom_abasto%>&token=<%=nom_abasto%>&id_usu=<%=user%>&folio=<%=folio%>&cla_uni=<%=cla_uni%>';
</script>
<%


        }
    }

//-------------------------------------------------
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>.: Carga de Abasto Web :.</title>
    <script>
        function valida() {
            return confirm("Seguro que desea Eliminarlo?")
        }
    </script>
    <style type="text/css">
        a:link {
            color: #09F;
        }

        a:visited {
            color: #09F;
        }

        a:hover {
            color: #06F;
        }
    </style>
</head>

<body style="background-color:#F7F7F7">
<div style="width:800px; margin:auto; font-family:Verdana, Geneva, sans-serif; font-size:14px; background-color:#FFF; padding:15px">
    <p><a href="index.jsp">Regresar</a></p>
    <table width="800" align="center">
        <tr>
            <td width="150">
                <img src="imagenes/Internet-icon.png" width="100" height="100"/>
            </td>
            <td style="text-align:center"><h1>Carga de Abasto vía Web</h1></td>
            <td><img src="imagenes/nay_ima1.jpg" width="200" height="85"/></td>
        </tr>

    </table>
    <div style="width:800; height:10; background-color:#F00">&nbsp;</div>
    <br/><br/>

    <form id="form1" name="form1" method="post" action="abasto_web.jsp?id_usu=<%=user%>&cla_uni=<%=cla_uni%>">
        Ingrese el Folio:
        <input type="text" name="folio" id="folio" value="<%=folio%>"/>
        <input type="submit" name="Submit" id="Submit" value="Folio"/>
        <input type="submit" name="Submit" id="Submit" value="Cargar" <%
            if (ban == 0) {
                out.print("style='visibility:hidden'");
            }
            if (ban == 0) {
                if (folio.equals("")) {
                    out.print("style='visibility:hidden'");
                }
            }%>  />
      <input type="text" name="folio2" id="folio2" value="<%=folio%>" readonly style="visibility:hidden"/>
    </form>
    <br/>

    <table border="0" style="font-size:10px; text-align:center" width="800">

        <%


            if (but != null) {
                //out.print("Boton:"+folio);
                if (!folio.equals("")) {
                    if (but.equals("Folio")) {
                        if (ban_error != 1) {
                            if (ban == 1) {
        %>
        <tr>
            <td></td>
            <td></td>
            <td><strong>CLAVE</strong></td>
            <td><strong>DESCRIPCION</strong></td>
            <td><strong>LOTE</strong></td>
            <td><strong>CADUCIDAD</strong></td>
            <td><strong>CANT SOL</strong></td>
            <td><strong>CANT ENT</strong></td>
            <td><strong>ORIGEN</strong></td>
        </tr>
        <%


            String query_abasto = "SELECT a.ClaPro, p.DesPro, a.ClaLot, a.FecCad, a.CanReq, a.CanEnt, a.Origen, a.Id FROM abastos a INNER JOIN productos p ON a.ClaPro = p.ClaPro INNER JOIN abasto_unidades au ON a.IdAbasto = au.IdAbasto WHERE Folio = '" + folio + "';";


            rset = stmt.executeQuery(query_abasto);
            while (rset.next()) {
                clave = rset.getString(1);
                descrip = rset.getString(2);
                lote = rset.getString(3);
                cad = rset.getString(4);
                cant = rset.getString(5);
                cantent = rset.getString(6);
                ori = rset.getString(7);
                id_abasto = rset.getString(8);
                //out.print(clave+descrip+lote+cad+cant+ori);
        %>
        <tr>
            <td>
                <a href="edita_clave_abasto.jsp?id_abasto=<%=id_abasto%>&folio=<%=folio%>&id_usu=<%=user%>&cla_uni=<%=cla_uni%>"><img src="imagenes/edit.png"
                                                                                                width="20" height="20"/></a>
            </td>
            <td>
                <a onClick="return confirm('Estas seguro de Eliminarla?')"
                   href="abasto_web.jsp?id_abasto=<%=id_abasto%>&folio=<%=folio%>&Submit=Folio&Accion=Eliminar&id_usu=<%=user%>&cla_uni=<%=cla_uni%>"><img
                        src="imagenes/Delete-icon.png" width="20" height="20"/></a>
            </td>
            <td><%=clave%>
            </td>
            <td><%=descrip%>
            </td>
            <td><%=lote%>
            </td>
            <td><%=cad%>
            </td>
            <td><%=cant%>
            </td>
            <td><%=cantent%>
            </td>
            <td><%=ori%>
            </td>
        </tr>
        <%

            }
        } else {
        %>
        <script>
            alert("Folio Inexistente");
            location.href = "abasto_web.jsp?id_usu=<%=user%>&cla_uni=<%=cla_uni%>";
        </script>
        <%
            }
        } else {
        %>
        <script>
            alert("Folio ya cargado");
            location.href = "abasto_web.jsp?id_usu=<%=user%>&cla_uni=<%=cla_uni%>";
        </script>
        <%
                }
            }
        } else {
        %>
        <script>
            alert("Favor de ingresar un Folio");
            location.href = "abasto_web.jsp?id_usu=<%=user%>&cla_uni=<%=cla_uni%>";
        </script>
        <%
                }
            }

        %></table>
</div>
</body>
</html>

<%
    conexion.close();
    conexion2.close();
%>