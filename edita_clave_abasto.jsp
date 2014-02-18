<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" session="true"
         import="java.util.*" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("hh:mm:ss"); %>


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

//-----------------------------------------------------------------
%>
<%
    String usuario = "", but = "", clave = "", descrip = "", lote = "", cad = "", cant = "", cantent = "", ori = "", id_abasto = "", accion = "", id_ab = "", folio = "";
    String caduc = "", cat = "", desc = "";
    String id_cla = request.getParameter("id_abasto");
    try {
        but = request.getParameter("Submit");
    } catch (Exception e) {
        System.out.print("not");
    }

    if (but != null) {
        if (but.equals("Actualizar")) {
            //out.println(but);

            String lote_up = request.getParameter("Lote");
            String fecha_up = request.getParameter("Caducidad");
            String cant_up = request.getParameter("Cantidad");
            String cantent_up = request.getParameter("Cantidad2");
            String ori_up = request.getParameter("Origen");

            if ((Integer.parseInt(cantent_up)) > (Integer.parseInt(cant_up))) {
%>
<script>alert("La cantidad Entregada NO puede ser mayor a la Solicitada");</script>
<%
} else {


    String qry_lee = "SELECT a.ClaPro, p.DesPro, a.ClaLot, a.FecCad, a.CanReq, a.CanEnt, a.Origen, a.Id, au.folio FROM abastos a INNER JOIN productos p ON a.ClaPro = p.ClaPro INNER JOIN abasto_unidades au ON a.IdAbasto = au.IdAbasto WHERE A.ID = '" + id_cla + "';";
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
        folio = rset.getString(9);

        stmt2.execute("insert into modificacion_abastos values('" + folio + "', '" + clave + "', '" + descrip + "', '" + lote_up + "', '" + fecha_up + "', '" + cant_up + "','" + cantent_up + "', '" + ori_up + "', '" + df.format(new java.util.Date()) + "', '" + df2.format(new java.util.Date()) + "', 'MODIFICACION', '0','" + lote + "','" + cad + "','" + cantent + "','" + ori + "', '0')");

    }
    String qry_actualiza = "UPDATE ABASTOS SET CLALOT='" + lote_up + "', FECCAD='" + fecha_up + "', CANREQ='" + cant_up + "', CANENT='" + cantent_up + "', ORIGEN= '" + ori_up + "' WHERE ID='" + id_cla + "'";
//out.print(qry_actualiza);
    stmt.execute(qry_actualiza);
%>
<script>alert("Actualizacion Correcta");</script>
<%
            }
        }
    }

%>
<%


    folio = request.getParameter("folio");
    String qry_medicamento = "SELECT ABASTOS.CLAPRO, ABASTOS.CLALOT, ABASTOS.FECCAD, ABASTOS.CANREQ, ABASTOS.CANent, ABASTOS.ORIGEN, PRODUCTOS.DESPRO FROM ABASTOS, PRODUCTOS WHERE ABASTOS.CLAPRO=PRODUCTOS.CLAPRO AND ABASTOS.ID='" + id_cla + "'";
//out.print(qry_medicamento);

    rset = stmt.executeQuery(qry_medicamento);
    while (rset.next()) {
        clave = rset.getString(1);
        lote = rset.getString(2);
        caduc = rset.getString(3);
        cat = rset.getString(4);
        cantent = rset.getString(5);
        ori = rset.getString(6);
        desc = rset.getString(7);
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>.: Edicion de Medicamento :.</title>
    <style type="text/css">
        .style2 {
            font-size: 10px;
            font-family: Arial, Helvetica, sans-serif;
        }
    </style>
    <script language="javascript" src="scw.js"></script>
</head>

<body style="font-family:Verdana, Geneva, sans-serif; font-size:14px; color:#333; background-color:#F7F7F7">
<div style="width:800px; margin:auto; background-color:#FFF; padding:20px">
    <table align="center">
        <tr>
            <td></td>
            <td style="text-align:center">
                <h1>Carga de Abasto</h1>

                <h2>Edición de Medicamento</h2>
            </td>
            <td>
            </td>
        </tr>
    </table>
    <div style="width:800; height:10; background-color:#F00">&nbsp;</div>
    <br/>

    <form id="form1" name="form1" method="post" action="">
        <table width="600" border="0" align="center">
            <tr>
                <td width="116"><label for="Clave2">Clave</label></td>
                <td width="474"><input type="text" name="Clave" id="Clave" value="<%=clave%>" readonly/></td>
            </tr>
            <tr>
                <td>Descripcion</td>
                <td><input name="Descripcion" type="text" id="Descripcion" size="60" value="<%=desc%>" readonly/></td>
            </tr>
            <tr>
                <td>Lote</td>
                <td><input type="text" name="Lote" id="Lote" value="<%=lote%>"/></td>
            </tr>
            <tr>
                <td>Caducidad</td>
                <td><input type="text" name="Caducidad" id="Caducidad" value="<%=caduc%>" readonly/>
                    <span class="style2"><img src="imagenes/cal.jpg" alt="Calendario" width="26" height="27"
                                              onClick="scwShow(scwID('Caducidad'), event)" border="0"/></span></td>
            </tr>
            <tr>
                <td><label for="Cantidad">Cant. Solicitada</label></td>
                <td><input type="text" name="Cantidad" id="Cantidad" value="<%=cat%>" readonly/> Cant. Entregada<input
                        type="text" name="Cantidad2" id="Cantidad2" value="<%=cantent%>"/></td>
            </tr>
            <tr>
                <td>Origen</td>
                <td><input type="text" name="Origen" id="Origen" value="<%=ori%>"/></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <input type="submit" name="Submit" id="Submit" value="Actualizar"
                           onClick="return confirm('Estas Seguro de Actualizar?')"/></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td><a href="abasto_web.jsp?folio=<%=folio%>&Submit=Folio&cla_uni=<%=request.getParameter("cla_uni")%>&id_usu=<%=request.getParameter("id_usu")%>">Regresar</a></td>
            </tr>
        </table>
        <p>&nbsp;</p>
    </form>
    <table align="center">
        <tr>
            <td><img src="imagenes/nay_ima1.jpg" alt="" width="200" height="95"/></td>
        </tr>
    </table>
</div>
</body>
</html>