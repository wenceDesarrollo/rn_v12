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
//out.println("Fecha Actual: " + calendar.getTime());
    calendar.add(Calendar.MONTH, -1);
//out.println("Fecha antigua: " + df.format(calendar.getTime()));
    String fecha_act = "" + df.format(calendar.getTime());
    String d = "0";
    int dias = 0;


//-----------------Genera Folio------------------------------------
    String folio = "";
    String cve_unidad = "";
    rset = stmt.executeQuery("select cla_uni from unidades where cla_uni = 1002;");
    while (rset.next()) {
        cve_unidad = rset.getString(1);
    }
    folio = cve_unidad + df2.format(new java.util.Date()) + df3.format(new java.util.Date());

//out.print(folio);
//.................................................................


//---------------Llena la tabla de reabasteciminento---------------------

//-----------------------------------------------------------------------

    try {
        but = "" + request.getParameter("submit");
    } catch (Exception e) {
        System.out.print("not");
    }

    //out.print(but);
    if (but.equals("Calcular Reposicion")) {


        try {
            d = request.getParameter("dia");
        } catch (Exception e) {
            System.out.print("not");
        }
        if (d.equals("")) {
            d = "0";
        }
        //out.print(d);
        dias = Integer.parseInt(d);

    }
    if (but.equals("Generar Abasto")) {
        //response.setContentType("application/vnd.ms-excel");
        //response.setHeader("Content-Disposition", "attachment;filename=\"report.xls\"");
    }

%>
<html>
<head>

 	<link rel="stylesheet" href="mm_restaurant1.css" type="text/css"/>
    </style>
    <link href="css/demo_table_jui.css" rel="stylesheet" type ="text/css"/>
    <script language="javascript" src="scw.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
    <script src ="Scripts/jquery-1.6.1.min.js" type = "text/javascript" ></script>
    <script src ="Scripts/jquery.dataTables.min.js" type =  "text/javascript" ></script>
    <script src="Scripts/jquery.dataTables.columnFilter.js" type ="text/javascript"></script>
    <script src="Scripts/jquery.dataTables.pagination.js" type="text/javascript"></script>
    <style type="text/css">
    /* BeginOAWidget_Instance_2586523: #dataTable */

    @import url("css/custom/base/jquery.ui.all.css");
    #dataTable {
        padding: 0;
        margin: 0;
        width: 100%;
    }

    #dataTable_wrapper {
        width: 100%;
    }

    #dataTable_wrapper th {
        cursor: pointer
    }

    #dataTable_wrapper tr.odd {
        color: #000;
        background-color: #FFF
    }

    #dataTable_wrapper tr.odd:hover {
        color: #333;
        background-color: #CCC
    }

    #dataTable_wrapper tr.odd td.sorting_1 {
        color: #000;
        background-color: #999
    }

    #dataTable_wrapper tr.odd:hover td.sorting_1 {
        color: #000;
        background-color: #666
    }

    #dataTable_wrapper tr.even {
        color: #FFF;
        background-color: #666
    }

    #dataTable_wrapper tr.even:hover, tr.even td.highlighted {
        color: #EEE;
        background-color: #333
    }

    #dataTable_wrapper tr.even td.sorting_1 {
        color: #CCC;
        background-color: #333
    }

    #dataTable_wrapper tr.even:hover td.sorting_1 {
        color: #FFF;
        background-color: #000
    }

        /* EndOAWidget_Instance_2586523 */
    tam14 {
        font-size: 14px;
    }

    .negritas {
        font-weight: bold;
        text-align: center;
        font-size: 9px;
    }

    .rojo {
        color: #900;
    }

    .FECHA {
        font-size: 10px;
    }

    .gray {
        color: #CCC;
    }

    .gray strong {
        color: #999;
    }

    .neg2 {
        font-weight: bold;
    }

    .MAR {
        color: #2A0000;
    }

    .rr {
        color: #A00;
        font-size: 18px;
        font-weight: bold;
    }
    </style>
    <script type="text/xml">
        <!--
        <oa:widgets>
            <oa:widget wid="2586523" binding="#dataTable" />
        </oa:widgets>
        -->
    </script>
    <script>
        function CloseWin() {
            window.opener = top;
            window.close();
        }
    </script>
    <title>Reporte de Reabastecimiento</title>
</head>
<body>
<div>
    <table border="1" align="center" bordercolor="#CCCCCC" bgcolor="#FFFFFF">
        <tr>
            <td><img src="imagenes/nay_ima1.jpg" width="142" height="72"/>
            </td>
            <td><h1>Reporte de Reabastecimiento</h1>
            </td>
            <td><img src="imagenes/ssn.jpg" width="162" height="78"/>
            </td>
        </tr>
    </table>


</div>
<div style="width:1000px; background-color:#FFF; padding:20px; margin:auto; font-family:Verdana, Geneva, sans-serif; font-size:10px">
    <a href="index.jsp" class="style1">Regresar</a>
</div>

<div style="width:1000px; background-color:#FFF; padding:20px; margin:auto; font-family:Verdana, Geneva, sans-serif; font-size:10px">
    <!--Folio: <%=folio%>-->
    <form method="post" style="text-align:center">
        <h3>D&iacute;as para su pr&oacute;ximo abasto:
            <input type="text" size="5" name="dia" id="dia" value="<%=d%>"/> <input type="submit" name="submit"
                                                                                    value="Calcular Reposicion"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!--input type="submit" name="Submit" value="Generar Abasto"/--><a href="gnr_reabast.jsp?dias=<%=dias%>&submit=<%=request.getParameter("submit")%>&cla_uni=<%=request.getParameter("cla_uni")%>" target="_blank"><img src="imagenes/exc.jpg" width="60px" height="50px" /></a>
            &nbsp;</h3>
    </form>
    <table width="97%" border="0" cellpadding="0" cellspacing="0" id="dataTable">
    	<thead>
        <tr>
            <th colspan="10" class="FECHA">
                <hr/>
            </th>
        </tr>
        <tr>
            <td class="FECHA"><Strong>Clave</Strong></td>
            <td style="text-align:left" class="FECHA"><Strong>Descripcion</Strong></td>
            <td class="FECHA"><Strong>Consumo <br/>Mensual</Strong></td>
            <td class="FECHA"><Strong>IFQ</Strong></td>
            <td class="FECHA"><Strong>Consumo <br/>Semanal</Strong></td>
            <td class="FECHA"><Strong>Existencia<br/>Actual</Strong></td>
            <td class="FECHA"><Strong>Sobreabasto</Strong></td>
            <td class="FECHA"><Strong>Cant. <br/>Sugerida</Strong></td>
            <!--td><Strong>Cant. <br/>Autorizada</Strong></td>
            <td><Strong>Observaciones</Strong></td-->
        </tr>
        <tr>
            <th colspan="10" class="FECHA">
                <hr/>
            </th>
        </tr>
		</thead>
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
        <tr  height="20" <%
            /*if (cant_total == 0) {
                out.print("style='visibility:hidden'");
            }*/
        %>>
        	
            <td class="negritas"><%=clave_rf%>
            </td>
            <td style="text-align:left" class="negritas"><%=descrip_rf%><%//=(min_con+"***"+con_diario+"***"+(cons_dia*dias)+"***"+dia_abasto2+"***"+exist_fut)%></td>
            <td class="negritas"><%=(int) cant_total%>
            </td>
            <td class="negritas"><%=(int) cant_quincenal%>
            </td>
            <td class="negritas"><%=(int) cant_semana%>
            </td>
            <td class="negritas"><%=cant_inv%>
            </td>
            <td class="negritas" <%
                if ((int) sobre != 0) {
                    out.print("style='color:#FFF; background-color:#F00;'");
                }
            %>><%=(int) sobre%>
            </td>
            <td class="negritas"><strong><%=total_t%>
            </strong></td>
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
</div>

</body>
<script type="text/javascript">
    // BeginOAWidget_Instance_2586523: #dataTable

    $(document).ready(function () {
        oTable = $('#dataTable').dataTable({
            "bJQueryUI": true,
            "bScrollCollapse": false,
            "sScrollY": "400px",
            "bAutoWidth": true,
            "bPaginate": true,
            "sPaginationType": "two_button", //full_numbers,two_button
            "bStateSave": true,
            "bInfo": true,
            "bFilter": true,
            "iDisplayLength": 25,
            "bLengthChange": true,
            "aLengthMenu": [
                [10, 25, 50, 100, -1],
                [10, 25, 50, 100, "Todos"]
            ]
        });
    });

    // EndOAWidget_Instance_2586523
</script>
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
