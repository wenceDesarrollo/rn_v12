<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*"
         import="java.lang.*" import="java.util.*" import="javax.swing.*" import="java.io.*"
         import="java.text.DateFormat"
         import="java.text.ParseException" import="java.text.DecimalFormat" import="java.text.SimpleDateFormat"
         import="java.util.Calendar" import="java.util.Date" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyyMMdd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("hhmmss"); %>
<% java.util.Calendar currDate = new java.util.GregorianCalendar();
    Class.forName("org.gjt.mm.mysql.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica", "root", "eve9397");
    // add 1 to month because Calendar's months start at 0, not 1
%>
<%
    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-Disposition", "attachment;filename=\"Reporte de Reabastecimiento.xls\"");
//declaracion de variables-------------------------------------------------------------------------------------------------------------------
    String but = "";
    String fecha1 = "", fecha2 = "", mensaje = "";
//-------------------------------------------------------------------------------------------------------------------------------------------

    Statement stmt = null;
    ResultSet rset = null;
    stmt = conn.createStatement();

    Statement stmt2 = null;
    ResultSet rset2 = null;
    stmt2 = conn.createStatement();


    Calendar calendar = Calendar.getInstance();
	Calendar calendar2 = Calendar.getInstance();
//out.println("Fecha Actual: " + calendar.getTime());
    calendar.add(Calendar.MONTH, -1);
//out.println("Fecha antigua: " + df.format(calendar.getTime()));
    String fecha_act = "" + df.format(calendar.getTime());
	
    String d = "0";
    int dias = 0;


    try {
        but = "" + request.getParameter("submit");
    } catch (Exception e) {
        System.out.print("not");
    }

    //out.print(but);

    try {
        d = request.getParameter("dias");
    } catch (Exception e) {
        System.out.print("not");
    }
    if (d.equals("")) {
        d = "0";
    }
    //out.print(d);
    dias = Integer.parseInt(d);
	calendar2.add(Calendar.DATE, dias);
	String fecha_imp= "" + df.format(calendar2.getTime());
%>
<html>
<head>
    <script language="javascript" src="scw.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
    <style type="text/css">
        body {
            background-color: #F5F5F5;
        }
    </style>
    <style type="text/css">
        <!--
        .style1 {
            font-size: 12px
        }

        body {
            background-image: url();
            background-color: #F5F5F5;
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

        .style9 {
            font-size: 12px;
            font-family: Arial, Helvetica, sans-serif;
            color: #990000;
            font-weight: bold;
        }

        .style10 {
            color: #EF6703
        }

        .style11 {
            color: #EF6703;
            font-weight: bold;
        }

        .style13 {
            color: #000000
        }

        -->
    </style>
    <title>Reporte de Reabastecimiento</title>
</head>
<body>
<div>
Reporte de Reabastecimiento</div>
<form method="post" style="">
      <p>
        <%
	String qry_unidad = "SELECT des_uni FROM unidades where cla_uni = '"+request.getParameter("cla_uni")+"'";
	String unidad ="";
	rset = stmt.executeQuery(qry_unidad);
	while (rset.next()) {
		unidad = rset.getString("des_uni");
	}
	%>
        Unidad: <%=unidad%>
        <br />D&iacute;as para su pr&oacute;ximo abasto: <%=d%>
      <br />
      Fecha de entrega: <%=fecha_imp%></p>
    </form>
<table width="780" border="1" style="font-size: 8px;">
        <tr>
            <td width="258"><Strong>Descripcion</Strong></td>
            <td width="53"><Strong>IFQ</Strong></td>
            <td width="57"><Strong>Exist.<br/>Inventario</Strong></td>
            <td width="54"><Strong>Sobreabasto</Strong></td>
            <td width="54"><Strong>Recomendado<br /> a Surtir</Strong></td>
            <td width="62"><strong>Clave</strong></td>
            <td width="60"><Strong>Confirmacion / <br /> Autorizacion</Strong></td>
            <td width="130"><Strong>Observaciones</Strong></td>
        </tr>

       <%
            String clave_rf = "", descrip_rf = "" ;

            String qry_clave = "select cla_pro, des_pro from productos order by cla_pro+0";
            //out.print(qry_clave);

            rset = stmt.executeQuery(qry_clave);
            while (rset.next()) {
                clave_rf = rset.getString("cla_pro");
                descrip_rf = rset.getString("des_pro");
				String cant_rf = "0", cant_rc = "0", cant_inv = "0";
                String qry_rf = "select sum(dr.can_sol) from detreceta dr, detalle_productos dp where dr.fec_sur>='" + fecha_act + "' and dp.cla_pro='" + clave_rf + "' and dr.det_pro = dp.det_pro group by dp.cla_pro";
				//out.print(qry_rf+"<br>");
                rset2 = stmt2.executeQuery(qry_rf);
                while (rset2.next()) {
                    cant_rf = rset2.getString(1);
                    if (cant_rf.equals("")) {
                        cant_rf = "0";
                    }

                }
				
                String qry_inv = "select sum(i.cant) from inventario i, detalle_productos dp where i.det_pro = dp.det_pro and dp.cla_pro='" + clave_rf + "' group by dp.cla_pro";
                rset2 = stmt2.executeQuery(qry_inv);
                while (rset2.next()) {
                    cant_inv = rset2.getString(1);
                    if (cant_inv.equals("")) {
                        cant_inv = "0";
                    }
                }

                float cant_total = (Float.parseFloat(cant_rf));
				
                if (cant_total > -1) {
                    float con_diario = (cant_total / 30);
                    float cons_dia = con_diario;
                    double dia_abasto2 = Math.ceil(cons_dia * dias);
                    int dia_abasto = (int) (dia_abasto2);
                    float cant_quincenal = (float) (Math.ceil(cant_total / 2));
                    float cant_semana = (float) (Math.ceil(cant_quincenal / 2));
                    float sobre = 0;
                    int exist_fut = (Integer.parseInt(cant_inv)) - dia_abasto;
					
                    float cant_re = (cant_quincenal) - ((int) (exist_fut));
                    if (cant_re <= 0) {
                        sobre = (cant_re) * -1;
                        cant_re = 0;
                    }
                    float x = 3;
                    float y = 30;
                    float min_con = (x / y);
                    //out.print(qry_rf+"<br>");
                    //cant_rf=rset.getString("sum(cant_sol)");
                    //out.print(clave_rf + " " + cant_rf+"<br>");

                    int total_t = (int) (cant_re);

                    if (exist_fut <= 0) {
                        total_t = (int) cant_quincenal;
                    }
                    if (exist_fut > (int) (cant_quincenal)) {//Sobreabasto
                        total_t = 0;
                    }
                    if (con_diario <= min_con) {
                        total_t = 1;
                    }


                    if (cant_total != 0) {
                        String qry_inserta = "insert into reabastecimientos () values ()";
                    }


        %>
        <tr <%/*
            if (cant_total == 0) {
                out.print("style='visibility:hidden'");
            }*/
        %>>
            <td style="text-align:left"><%=descrip_rf%></td>
            <td><%=(int) cant_quincenal%>
            </td>
            <td><%=cant_inv%>
            </td>
            <td <%
                if ((int) sobre != 0) {
                    out.print("style='color:#FFF; background-color:#F00;'");
                }
            %>><%=(int) sobre%>
            </td>
            <td><strong><%=total_t%>
            </strong></td>
            <td><%=clave_rf%></td>
            <td><strong><%=total_t%>
            </strong></td>
            <td></td>
          <!--td><input type="text" size="3" value="<%=total_t%>"></td>
            <td><input type="text" size="35" value=""></td-->
        </tr>
        <%

                    con_diario = 0;
                    cons_dia = 0;
                    dia_abasto = 0;
                    dia_abasto2 = 0;
                    cant_quincenal = 0;
                    cant_semana = 0;
                    exist_fut = 0;
                    cant_re = 0;
                    sobre = 0;
                    min_con = 0;
                    total_t = 0;

                }
            }
        %>
    </table>
    <p>&nbsp;</p>


</body>
    <%
    // ----- try que cierra la conexión a la base de datos
                     try{
                   // Se cierra la conexión dentro del try
                     conn.close();
                      }catch (Exception e){mensaje=e.toString();}
               finally{ 
                   if (conn!=null){
                       conn.close();
                                    if(conn.isClosed()){
                                 mensaje="desconectado2";}
                     }
                 }
                             //out.print(mensaje);
                    // ---- fin de la conexión	 	  

    %>
