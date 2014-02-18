<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.io.*"
         import="com.csvreader.CsvReader" import="javax.swing.*" import="java.util.Date" import="java.text.SimpleDateFormat" import="java.util.*" errorPage="" %>
         <%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyyMMddHHmmss"); %>
<%
    //objeto de la Clase Connection, nos sirve para hacer la conexiC3n a la base correspondiente
    Connection conexion = null;
    Connection conexion2 = null;
    Statement stmt = null;
    Statement stmt_2 = null;
    Statement stmt_3 = null;
    Statement stmt4 = null;
    ResultSet rset = null, rset_2 = null, rset_3 = null, rset4 = null;

// Variables de entorno
    String mensaje = "", mensaje2 = "", usuario_url = "";
    int inv_ini = 0, cant_int = 0, no_existe = 0, existe = 0;
    String clave = "", descri = "", lote = "", cadu = "", cant = "", origen = "";
    int ingreso = 0, salidas = 0, abasto = 0, exis_tot = 0, ingreso_actual = 0;
    int abast = 0, pres_amp = 0, total_amp = 0, clave_amp = 0;//varibles para calcular el ampuleo
    int cajas_1 = 0, ing_amp1 = 0, existencias_amp = 0, var_ingreso = 0, ingreso_inv = 0, cant_ant = 0;
    String cajas_2 = "", ing_amp2 = "", id = "";
    int para_amp = 0;
    String folio = "";
     
/*parametros para la conexiC3n*/
    String driver = "org.gjt.mm.mysql.Driver";
    String url = "jdbc:mysql://localhost:3306/r_nayarit";
    String usuario = "root";
    String clave2 = "eve9397";
    String url_con2 = "jdbc:mysql://189.197.187.15:3306/abastos";
    String user_con = "gnkl_rep";
    String pass_con = "Avxkc4";
  /*procedimiento de la conexion*/
    try {
        Class.forName(driver);
        conexion = DriverManager.getConnection(url, usuario, clave2);
        conexion2 = DriverManager.getConnection(url_con2, user_con, pass_con);
         /*guardando la conexion en la session*/

        session.setAttribute("conexion", conexion);
        stmt = conexion.createStatement();
        stmt_2 = conexion.createStatement();
        stmt_3 = conexion.createStatement();
        stmt4 = conexion2.createStatement();
        mensaje = "conectado";
    } catch (Exception ex) {
        mensaje = ex.toString();
    }

    if (conexion.isClosed()) {
        mensaje = "desconectado";
    }
    String ruta = "";
    try {
        ruta = request.getParameter("archivo");
        usuario_url = request.getParameter("usuario");
        folio = request.getParameter("folio");
    } catch (Exception ex) {
        mensaje2 = ex.toString();
    }
    //out.print(ruta);
//String mensaje="";
//String csv="com.csvreader.CsvReader.class";

    String but = "r";

// try que obtiene el valor del botC3n que el usuario haya activado
    try {
        but = "" + request.getParameter("Submit");
        //altaOK="no";
    } catch (Exception e) {
        System.out.print("not");
    }
// fin try --------------------------------------------------------  

// Se obtiene la fecha ---------------------------------------------------------------------------------  
    String fecha_ins = "";
    java.util.Calendar currDate = new java.util.GregorianCalendar();
    // add 1 to month because Calendar's months start at 0, not 1
    int month = currDate.get(currDate.MONTH) + 1;
    int day = currDate.get(currDate.DAY_OF_MONTH);
    int year = currDate.get(currDate.YEAR);
    String date = "";
    String res = "";
    if (month >= 1 && month <= 9) {
        res = "0" + month;
// month=Integer.parseInt(res);
        date = " " + day;
        date = date + "/" + res;
        date = date + "/" + year;

        //out.print(""+res);
    } else {
        date = " " + day;
        date = date + "/" + month;
        date = date + "/" + year;
        res += month;
    }
    fecha_ins = year + "-" + res + "-" + day;
// fin fecha --------------------------------------------------------------------------------------------   

//ObtenciC3n de la hora
    Calendar calendario = new GregorianCalendar();
    //Calendar calendario = Calendar.getInstance();

    int hora = 0, minutos = 0, segundos = 0;
    int existe_abasto = 0;
    String min_0 = "", hora_com = "";
    hora = calendario.get(Calendar.HOUR_OF_DAY);
    minutos = calendario.get(Calendar.MINUTE);
    segundos = calendario.get(Calendar.SECOND);

    if (minutos >= 0 && minutos <= 9) {
        min_0 = "0" + minutos;
        hora_com = hora + ":" + min_0 + ":" + segundos;
    } else {
        hora_com = hora + ":" + minutos + ":" + segundos;
    }
// -------------------

    String token = request.getParameter("token");
    int cont_reader = 0, cont_rset = 0, contador_reg = 0, ban_err = 0;
    rset = stmt.executeQuery("select * from receta_carga_archivos where archivo='" + token + "'");
    while (rset.next()) {
        existe_abasto = 1;
        break;
    }
    if (existe_abasto == 1)//if para archivo cargado anteriormente----------------------------------------------
    {
%>

<html>
    <head>
        <meta name="generator"
              content="JS Editor v9, http://www.c-point.com"/>
        <script type="text/javascript"
                xml:space="preserve">
//<![CDATA[
                    alert("El archivo ya ha sido CARGADO EN EL INVENTARIO, intente con un archivo vC!lido");
//]]>
        </script>
        <%
            }//--------------------------------------------------------------------------------------------------------
            else {//else para para archivo no cargado antes-------------------------------------------------------------
                //out.print("entro");
                //try{//inicio de try

                //Class.forName(csv);
                CsvReader reader = new CsvReader(ruta);//ruta
                CsvReader reader_chk = new CsvReader(ruta);//ruta
                reader.setDelimiter(',');
                reader_chk.setDelimiter(',');
                while (reader_chk.readRecord()) {//inicio de while
                    //out.print("imprime:"+contador_reg++);
                    for (int x = 0; x < 6; x++) {
                        if (reader_chk.get(x).equals("")) {
                            ban_err = 1;
                            break;
                        }
                        if (ban_err == 1) {
                            break;
                        }
                    }
                }

                if (ban_err == 0) {
                    // rutina para saber si es Inventario Inicial por cargar
                            try {
                            stmt.execute("create table respaldo_inventario"+df.format(new java.util.Date())+" select * from inventario_uni");
                            }catch(Exception e){
								//out.println("Error creacion tabla: "+e.getMessage());
                            }
                    rset = stmt.executeQuery("select * from inventario_uni");
                    while (rset.next()) {
                        inv_ini = 1;
                    }//inicio - fin de while
                    if (inv_ini == 0) { //inicio de if
                        while (reader.readRecord()) {//inicio de while
                            clave_amp = 0;
                            abasto = 0;
                            pres_amp = 0;
                            total_amp = 0;
                            
                            rset = stmt.executeQuery("select clave, cant from pasti_ampu where clave='" + reader.get(0) + "'");
                            while (rset.next()) {// inicio de while
                                //out.print("La clave: "+reader.get(0)+" Existe en pasti_ampu"+"<br>");
                                abasto = Integer.parseInt(reader.get(4));
                                pres_amp = Integer.parseInt(rset.getString("cant"));
                                total_amp = abasto * pres_amp;
                                //out.print("abasto: "+abasto+" cant_amp: "+pres_amp+"total: "+total_amp+"<br>");
                                //para inventario inicial y es clave de ampuleo
                                stmt.execute("insert into inv_ini values ('" + reader.get(0) + "','" + reader.get(1) + "','" + reader.get(2) + "','" + reader.get(3) + "','" + abasto + "','" + pres_amp + "','" + total_amp + "','" + reader.get(5) + "','A','" + fecha_ins + "','" + hora_com + "',0)");
                                // --------------------------------------------
                                // Se ingresan los datos para la tabla de entradas
                                stmt.execute("insert into movimientos_entradas values ('" + reader.get(0) + "','" + reader.get(1) + "','" + reader.get(2) + "','" + reader.get(3) + "','" + abasto + "','" + pres_amp + "','" + total_amp + "','" + reader.get(5) + "','A','" + fecha_ins + "','" + hora_com + "','1')");
                                // fin de ingreso a entradas ---------------------

                                // Se ingresan los datos para la tabla de inventario
                                stmt.execute("insert into inventario_uni values ('" + reader.get(0) + "','" + reader.get(1) + "','" + reader.get(2) + "','" + reader.get(3) + "','" + abasto + "','" + pres_amp + "','" + total_amp + "','" + total_amp + "','0','" + reader.get(5) + "','A','1','" + fecha_ins + "','" + hora_com + "',0)");
                                // fin de tabla inventario -------------------------

                                // se agrega info a la tabla modificacion
                                stmt.execute("insert into modificacion values ('" + reader.get(0) + "','" + reader.get(1) + "','" + reader.get(2) + "','" + reader.get(3) + "','0','" + reader.get(5) + "','" + abasto + "','" + total_amp + "','" + fecha_ins + "','" + usuario_url + "','ENTRADA POR ABASTO','CARGA DE ABASTO INVENTARIO INICIAL',current_timestamp,'-','-','1','" + ruta + "','" + pres_amp + "','" + total_amp + "',0)");
                                // fin tabla modi

                                clave_amp = 1;
                                break;
                            }
                            if (clave_amp == 0) {
                                abasto = Integer.parseInt(reader.get(4));
                                pres_amp = 1;
                                total_amp = abasto * pres_amp;
                                //out.print("La clave: "+reader.get(0)+" NO Existe en pasti_ampu"+"<br>");
                                //para inventario inicial y es clave de NO ampuleo
                                stmt.execute("insert into inv_ini values ('" + reader.get(0) + "','" + reader.get(1) + "','" + reader.get(2) + "','" + reader.get(3) + "','" + abasto + "','" + pres_amp + "','" + total_amp + "','" + reader.get(5) + "','NA','" + fecha_ins + "','" + hora_com + "',0)");
                                // --------------------------------------------

                                // Se ingresan los datos para la tabla de entradas
                                stmt.execute("insert into movimientos_entradas values ('" + reader.get(0) + "','" + reader.get(1) + "','" + reader.get(2) + "','" + reader.get(3) + "','" + abasto + "','" + pres_amp + "','" + total_amp + "','" + reader.get(5) + "','NA','" + fecha_ins + "','" + hora_com + "','1')");
                                // fin de ingreso a entradas ---------------------

                                // Se ingresan los datos para la tabla de inventario
                                stmt.execute("insert into inventario_uni values ('" + reader.get(0) + "','" + reader.get(1) + "','" + reader.get(2) + "','" + reader.get(3) + "','" + abasto + "','" + pres_amp + "','" + total_amp + "','" + total_amp + "','0','" + reader.get(5) + "','NA','1','" + fecha_ins + "','" + hora_com + "',0)");
                                // fin de tabla inventario -------------------------
                            }

                            // se agrega info a la tabla modificacion
                            stmt.execute("insert into modificacion values ('" + reader.get(0) + "','" + reader.get(1) + "','" + reader.get(2) + "','" + reader.get(3) + "','0','" + reader.get(5) + "','" + abasto + "','" + total_amp + "','" + fecha_ins + "','" + usuario_url + "','ENTRADA POR ABASTO','CARGA DE ABASTO INVENTARIO INICIAL',current_timestamp,'-','-','1','" + ruta + "','" + pres_amp + "','" + total_amp + "',0)");
                            // fin tabla modi
                        }// end while - recorrido del csv

                        out.print("Se cargo el Inventario Inicial con Exito");
                        if (folio != null) {
                            stmt4.execute("update abasto_unidades set surtido='1' where folio = '" + folio + "'");
                            //stmt.execute("truncate table abasto_web;");
                        }
                    }//end if
                    // proceso para ingresar la clave en la tablas de movimientos (si el inventario inicial tiene datos)
                    else { // inicio else
                        try {
                            stmt.execute("create table respaldo_inventario"+df.format(new java.util.Date())+" select * from inventario_uni");
                            }catch(Exception e){
								//out.println("Error creacion tabla: "+e.getMessage());
                            }
                        while (reader.readRecord()) {  //inicio while recorre el archivo CSV
                            existe = 0;
                            no_existe = 0;
                            cont_reader++;
                            //out.print("Ingreso al reader y existen datos en la BDD"+cont_rset+"<br>");
                                     /*out.print("Clave : "
                                                                    + reader.get(0) + " lote: " + reader.get(2)+ " Caducidad: " + reader.get(3)+ " Cantidad: " + reader.get(4)+ " Origen: " + reader.get(5)+"<br>");*/

                            rset = stmt.executeQuery("select * from inventario_uni");
                            while (rset.next()) {// inicio de while para recorrer las claves que hay en la tabla inventario_uni
                                cont_rset = cont_rset + 1;
                                clave_amp = 0;

                                //clave_amp=0;abasto=0;pres_amp=0;total_amp=0;cajas_1=0;ing_amp1=0;salidas=0;existencias_amp=0;
                                //out.print("Ingreso al rset"+cont_rset+"<br>");

                                if ((rset.getString("clave").equals(reader.get(0))) && (rset.getString("lote").equals(reader.get(2))) && (rset.getString("caducidad").equals(reader.get(3))) && (rset.getString("origen").equals(reader.get(5)))) {
                                    // out.print("EXISTE en el inventario"+"<br>");
                                  
                                                                    /*  out.print("Clave : "
                                                                    + rset.getString("clave") + " lote: " + rset.getString("lote") + " Caducidad: " + rset.getString("caducidad")+ " Entradas: " + rset.getString("ingreso")+"<br>"+" Origen: " + rset.getString("origen")+"<br>");
                                                                     out.print("Clave : "
                                                                    + reader.get(0) + " lote: " + reader.get(2)+ " Caducidad: " + reader.get(3)+ " Cantidad: " + reader.get(4)+ " Origen: " + reader.get(5)+"<br>");*/
                                    cajas_1 = Integer.parseInt(rset.getString("cajas"));
                                    cant_ant = cajas_1;
                                    ing_amp1 = Integer.parseInt(rset.getString("ingreso"));
                                    ingreso_inv = Integer.parseInt(rset.getString("ingreso"));
                                    salidas = Integer.parseInt(rset.getString("salidas"));
                                    id = rset.getString("id");
                                    //operaciones
                                    abasto = Integer.parseInt(reader.get(4));
                                    cajas_1 = cajas_1 + abasto;
                                    ing_amp1 = cajas_1 * 1;
                                    existencias_amp = ing_amp1 - salidas;
                                  
                                                                      /*
                                  
                                                                            cajas_1=cajas_1+abasto;
                                                                            ing_amp1=Integer.parseInt(rset.getString("ingreso"));
                                                                            ing_amp1=ing_amp1+total_amp;
                                                                            salidas=Integer.parseInt(rset.getString("salidas"));*/


                                    // out.print("Cajas Inv: "+rset.getString("cajas")+" ingreso:"+ing_amp1+" salidas:"+salidas+" id:"+id+"<br>");


                                    // rutina para saber si la clave es de ampuleo
                                    //clave_amp=0;abasto=0;pres_amp=0;total_amp=0;cajas_1=0;ing_amp1=0;salidas=0;existencias_amp=0;

                                    rset_2 = stmt_2.executeQuery("select clave, cant from pasti_ampu where clave='" + reader.get(0) + "'");
                                    while (rset_2.next()) {// inicio de while
                                        cajas_1 = Integer.parseInt(rset.getString("cajas"));
                                        cant_ant = cajas_1;
                                        ing_amp1 = Integer.parseInt(rset.getString("ingreso"));
                                        salidas = Integer.parseInt(rset.getString("salidas"));
                                        //out.print("La clave: "+reader.get(0)+" Existe en pasti_ampu"+"<br>");
                                        abasto = Integer.parseInt(reader.get(4));
                                        pres_amp = Integer.parseInt(rset_2.getString("cant"));
                                        total_amp = abasto * pres_amp;
                                        //out.print("abasto: "+abasto+" cant_amp: "+pres_amp+"total: "+total_amp+"<br>");

                                        // Se ingresan los datos para la tabla de entradas
                                        stmt.execute("insert into movimientos_entradas values ('" + reader.get(0) + "','" + reader.get(1) + "','" + reader.get(2) + "','" + reader.get(3) + "','" + abasto + "','" + pres_amp + "','" + total_amp + "','" + reader.get(5) + "','A','" + fecha_ins + "','" + hora_com + "','2')");
                                        // fin de ingreso a entradas ---------------------


                                        // update para inventario_uni
                                        ing_amp1 = ing_amp1 + total_amp;
                                        cajas_1 = cajas_1 + abasto;
                                        existencias_amp = ing_amp1 - salidas;

                                        //cajas_1=Integer.parseInt(rset.getString("cajas"));
                            /*cajas_1=cajas_1+abasto;
                            ing_amp1=Integer.parseInt(rset.getString("ingreso"));
                            ing_amp1=ing_amp1+total_amp;
                            salidas=Integer.parseInt(rset.getString("salidas"));
                            //existencias = ingresos - salidas
                    existencias_amp=ing_amp1-salidas;   */

                                        //out.print("Cajas: "+cajas_1+" ingreso:"+ing_amp1+" salidas:"+salidas+" exis:"+existencias_amp+"<br>");

                                        stmt.execute("update inventario_uni set cajas='" + cajas_1 + "', existencias='" + existencias_amp + "', ingreso='" + ing_amp1 + "' where id='" + id + "'");
                                        // fin de update ------------

                                        // se agrega info a la tabla modificacion
                                        stmt.execute("insert into modificacion values ('" + reader.get(0) + "','" + reader.get(1) + "','" + reader.get(2) + "','" + reader.get(3) + "','" + cant_ant + "','" + reader.get(5) + "','" + abasto + "','" + existencias_amp + "','" + fecha_ins + "','" + usuario_url + "','ENTRADA POR ABASTO','CARGA DE ABASTO',current_timestamp,'-','-','2','" + ruta + "','" + pres_amp + "','" + existencias_amp + "',0)");
                                        // fin tabla modi cajas_1

                                        clave_amp = 1;
                                        break;
                                    }// fin del while que recorre pasti_ampu
                                    // fin checar clave es de ampuleo -------------------------------------------

                                    if (clave_amp == 0) {
                                        //out.print("La clave: "+reader.get(0)+" NO Existe en pasti_ampu, pero SI en el Inventario"+"<br>");

                                        abasto = Integer.parseInt(reader.get(4));

                                        // para obtener la presentaciC3n ??????
                                        rset_3 = stmt_3.executeQuery("select clave, cant from pasti_ampu where clave='" + reader.get(0) + "'");
                                        while (rset_3.next()) {// inicio de while
                                            //out.print("La clave que NO estC! en el inv: "+reader.get(0)+" Existe en pasti_ampu"+"<br>");

                                            pres_amp = Integer.parseInt(rset_3.getString("cant"));
                                        }
                                        // fin presentaciC3n------------ ??????


                                        pres_amp = 1;
                                        total_amp = abasto * pres_amp;

                                        // proceso para obtener los totales de inventario_uni
                                        //cajas_1=cajas_1+abasto;// para total de cajas
                                        var_ingreso = ingreso_inv + abasto;
                                        existencias_amp = var_ingreso - salidas;
                                        // fin proceso --------------------------------------

                                        // Se ingresan los datos para la tabla de entradas
                                        stmt.execute("insert into movimientos_entradas values ('" + reader.get(0) + "','" + reader.get(1) + "','" + reader.get(2) + "','" + reader.get(3) + "','" + abasto + "','" + pres_amp + "','" + abasto + "','" + reader.get(5) + "','NA','" + fecha_ins + "','" + hora_com + "','2')");
                                        // fin de ingreso a entradas ---------------------


                                        // update para inventario_uni
                            /*cajas_1=Integer.parseInt(rset.getString("cajas"));
                            cajas_1=cajas_1+abasto;
                            ing_amp1=Integer.parseInt(rset.getString("ingreso"));
                            ing_amp1=ing_amp1+total_amp;
                            salidas=Integer.parseInt(rset.getString("salidas"));*/
                                        //existencias = ingresos - salidas
                                        //existencias_amp=ing_amp1-salidas;

                                        //out.print("Cajass: "+cajas_1+" ingreso:"+ing_amp1+" salidas:"+salidas+" exis:"+existencias_amp+"<br>");

                                        //stmt.execute("update inventario_uni set cajas='"+cajas_1+"',existencias='"+existencias_amp+"', ingreso='"+ing_amp1+"' where id='"+rset.getString("id")+"'");
                                        // fin de update ------------
                                        stmt.execute("update inventario_uni set cajas='" + cajas_1 + "', existencias='" + existencias_amp + "', ingreso='" + var_ingreso + "' where id='" + id + "'");
                                        //out.print(""+cant_ant);
                                        // se agrega info a la tabla modificacion
                                        stmt.execute("insert into modificacion values ('" + reader.get(0) + "','" + reader.get(1) + "','" + reader.get(2) + "','" + reader.get(3) + "','" + cant_ant + "','" + reader.get(5) + "','" + abasto + "','" + existencias_amp + "','" + fecha_ins + "','" + usuario_url + "','ENTRADA POR ABASTO','CARGA DE ABASTO',current_timestamp,'-','-','2','" + ruta + "','" + pres_amp + "','" + existencias_amp + "',0)");
                                        // fin tabla modi cajas_1

                                    }// fin del if clave_amp
                                    existe = 1;
                                    break;

                                }// fin del if si coincide clave, lote, caducidad y origen

                            }// fin del while que recorre las claves del inventario
                            //if cuando es una clave que no existe en el inventario, la ingresa en la tabla de inventarios y entradas
                            if (existe == 0) {
                                //out.print("INGRESOssssss"+no_existe+"<br>");

                                abasto = Integer.parseInt(reader.get(4));

                                rset_3 = stmt_3.executeQuery("select clave, cant from pasti_ampu where clave='" + reader.get(0) + "'");
                                while (rset_3.next()) {// inicio de while
                                    //out.print("La clave: "+reader.get(0)+" Existe en pasti_ampu"+"<br>");
                                    pres_amp = Integer.parseInt(rset_3.getString("cant"));
                                    para_amp = 1;
                                    break;
                                }
                                if (para_amp == 0) {
                                    pres_amp = 1;
                                }

                                // rutina para
                                total_amp = abasto * pres_amp;
                                //out.print("La clave: "+reader.get(0)+" NO Existe en pasti_ampu"+"<br>");


                                // Se ingresan los datos para la tabla de entradas
                                stmt.execute("insert into movimientos_entradas values ('" + reader.get(0) + "','" + reader.get(1) + "','" + reader.get(2) + "','" + reader.get(3) + "','" + abasto + "','" + pres_amp + "','" + total_amp + "','" + reader.get(5) + "','NA','" + fecha_ins + "','" + hora_com + "','2')");
                                // fin de ingreso a entradas ---------------------
                                //out.print("Cajas: "+abasto+" ingreso:"+pres_amp+" salidas:"+salidas+" exis:"+total_amp+"<br>");
                                // Se ingresan los datos para la tabla de inventario
                                stmt.execute("insert into inventario_uni values ('" + reader.get(0) + "','" + reader.get(1) + "','" + reader.get(2) + "','" + reader.get(3) + "','" + abasto + "','" + pres_amp + "','" + total_amp + "','" + total_amp + "','0','" + reader.get(5) + "','NA','2','" + fecha_ins + "','" + hora_com + "',0)");
                                // fin de tabla inventario -------------------------
                                // se agrega info a la tabla modificacion
                                stmt.execute("insert into modificacion values ('" + reader.get(0) + "','" + reader.get(1) + "','" + reader.get(2) + "','" + reader.get(3) + "','0','" + reader.get(5) + "','" + abasto + "','" + total_amp + "','" + fecha_ins + "','" + usuario_url + "','ENTRADA POR ABASTO','CARGA DE ABASTO INVENTARIO INICIAL',current_timestamp,'-','-','2','" + ruta + "','" + pres_amp + "','" + total_amp + "',0)");
                                // fin tabla modi cajas_1

                            }
                            para_amp = 0;

                        }// while del reader
                        out.print("Se realizo con EXITO la carga del ABASTO");
                        if (folio != null) {
                            stmt4.execute("update abasto_unidades set surtido='1' where folio = '" + folio + "'");
                            //stmt.execute("truncate table abasto_web;");
                        }
                    }// fin del else
                    //  } catch (Exception ex){mensaje=ex.toString();}


                    stmt.execute("insert into receta_carga_archivos values ('" + token + "','" + fecha_ins + "')");
                }//fin del if archivo vC!lido
                else {
                    out.print("ERROR -9 Archivo Invalido, CONSULTE AL ADMINISTRADOR DEL SISTEMA");
                }

            }//-----------------------------------------------------------------------------------------------------------
        %>
        <meta http-equiv="Content-Type"
              content="text/html; charset=us-ascii"/>

        <title>:: CARGA DE ABASTOS ::</title>
    </head>

    <body>
        <br/>
        <a href="index.jsp">Regresar a Men&#250;</a><%//=mensaje%><%
            // ----- try que cierra la conexiC3n a la base de datos
            try {
                // Se cierra la conexiC3n dentro del try
                conexion.close();
            } catch (Exception e) {
                mensaje = e.toString();
            } finally {
                if (conexion != null) {
                    conexion.close();
                    if (conexion.isClosed()) {
                        mensaje = "desconectado2";
                    }
                }
            }
            //out.print(mensaje);
            // ---- fin de la conexiC3n

        %>
    </body>
</html>