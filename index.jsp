<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% 
//  Conexión a la BDD -------------------------------------------------------------
Class.forName("org.gjt.mm.mysql.Driver");
Connection conn1 = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt1 = conn1.createStatement();
Statement stmt = conn1.createStatement();
Statement stmt_01 = conn1.createStatement();
ResultSet rset1= null;
ResultSet rset2= null;
// fin objetos de conexión ------------------------------------------------------

// Para obtener la fecha ---------------------------------------------
   java.util.Calendar currDate = new java.util.GregorianCalendar();
   // add 1 to month because Calendar's months start at 0, not 1
   int month = currDate.get(currDate.MONTH)+1;
   int day = currDate.get(currDate.DAY_OF_MONTH);
   int year = currDate.get(currDate.YEAR);
   String date=""; 
   String res=""; 
 if(month >=1 && month <= 9)  
     {
           res ="0"+month;
           date=" "+day;
           date= date+"/"+res;
           date= date+"/"+year;  
         }
 else 
     {
      date=" "+day;
      date= date+"/"+month;
      date= date+"/"+year;  
          res+=month;
     }
  
 // --------------------------------------------------------
 // Variables de entorno -----------------------------------
     int ban=0,cont2=0,cont3=0;
     int ban_ima=0;
     String cve_uni_2=""; 	
     String cve_uni="";
         int tam=0,tam2=0,x1=0;
     String cad1[]=new String[1000];  //array for show clients 
     String but="r";
         String id_usu="", usu_jv="",juris_jv="",no_jv="",receta_jv="",encar_jv="",unidad2_jv="",clave_jv="",cv_dgo_jv="",cv_uni_jv="",cv_mpio_jv="",perfil="",mensaje="",encar_validar="",contra_validar="";
         String pass_jv="";
         int correct1=0,customerIds=0;
         String val="h";
         String user="h";
     String hora_ini_jv="";
         int cont=0;
 // fin variables 
   
   try { 
        ban_ima=Integer.parseInt(request.getParameter("ban"));
        //altaOK="no";
    }catch(Exception e){System.out.print("not");}
	  
    try { 
         cve_uni=request.getParameter("cve");
                 if (cve_uni==null)
                 {
                         cve_uni="";
                 }
            }catch(Exception e){System.out.print("not");}
    try { 
        but=""+request.getParameter("Submit");
        //altaOK="no";
    }catch(Exception e){System.out.print("not");}

//Para saber que botón optado

if(but.equals("Mostrar"))
      {
         // out.print("ingreso");
                 cve_uni_2=request.getParameter("txtf_uni");
                 if (cve_uni_2.equals("")||cve_uni_2==null){
%><script>alert("Unidad no valida");</script><%
                        unidad2_jv="a";
                } else {
          
          rset1=stmt1.executeQuery("select un.des_uni, u.nombre, u.user, u.pass from usuarios u, unidades un where u.cla_uni = un.cla_uni and u.cla_uni='"+request.getParameter("txtf_uni")+"'");
          while (rset1.next()) 
           {
                        cad1[tam2]=rset1.getString("u.nombre");
                        unidad2_jv=rset1.getString("un.des_uni");
                        tam2++;	   
                        ban=1;
                    cont2++;
                                  }
                if(ban==1)
                    ban=4;
            else				  
                ban=3;
                        if(cont2>0)
                        {
                       ban_ima=1;
                    }
                        }
          }

if(but.equals("Validar Usuario"))
{
unidad2_jv=request.getParameter("txtf_unidad");
receta_jv=request.getParameter("select_receta");
encar_jv=request.getParameter("select_encar");
pass_jv=request.getParameter("txtf_pass");

//out.println(unidad2_jv+receta_jv+encar_jv+pass_jv);		

                if (unidad2_jv.equals("")||unidad2_jv==null){
%><script>alert("Unidad no valida");</script><%
                        unidad2_jv="a";
                } else {
			
			
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
                ResultSet rset = stmt.executeQuery("SELECT STR_TO_DATE('"+date+"', '%d/%m/%Y')"); 
                while(rset.next())
                date= rset.getString("STR_TO_DATE('"+date+"', '%d/%m/%Y')");
                //out.print("select nombre, rol, pass, id_usu from usuarios where nombre='"+encar_jv+"' and pass='"+pass_jv+"'");
rset2=stmt1.executeQuery("select nombre, rol, pass, id_usu from usuarios where nombre='"+encar_jv+"' and pass='"+pass_jv+"' ");
        while (rset2.next()) {
                        
                        encar_validar=rset2.getString("nombre");
						id_usu=rset2.getString("id_usu");
                        perfil=rset2.getString("rol");
                        contra_validar=rset2.getString("pass");
                        if(encar_jv.equals(encar_validar) && pass_jv.equals(contra_validar))
                          {cont3++;}
         }
                if (cont3>0)
                {  
                conn.close();
	
if ((cont3==1) && (receta_jv.equals("Receta por Farmacia Fecha Automatica")))
{
out.print("\nReceta por Farmacia Fecha auto");
stmt1.execute("insert into registro_entradas values ('"+id_usu+"', NOW(), 'RFA', '0');");
response.sendRedirect("rf.jsp?tipo=RFA&id_usu="+id_usu);
}							
if ((cont3==1) && (receta_jv.equals("Receta Colectiva Fecha Automatica")))
{
out.print("\nReceta por Colectiva Fecha Automatica");
stmt1.execute("insert into registro_entradas values ('"+id_usu+"', NOW(), 'RCA', '0');");
response.sendRedirect("rc.jsp?tipo=RCA&id_usu="+id_usu);
}
if ((cont3==1) && (perfil.equals("2") && (receta_jv.equals("Receta por Surtir Farmacia"))))
{
	//out.println(perfil);
//out.print("\nReceta por Surtir Farmacia");
stmt1.execute("insert into registro_entradas values ('"+id_usu+"', NOW(), 'RSF', '0');");
response.sendRedirect("receta_por_surtir.jsp?id_usu="+id_usu);
}
if ((cont3==1) && (perfil.equals("2") && (receta_jv.equals("Receta por Surtir Colectiva"))))
{
//out.print("\nReceta por Surtir Colectiva");
stmt1.execute("insert into registro_entradas values ('"+id_usu+"', NOW(), 'RSC', '0');");
response.sendRedirect("receta_col_surtir.jsp?id_usu="+id_usu);
}		
if(cont==0){
}
}else{
%>
<script>
    alert("USUARIO SIN PERMISOS")
</script>
<%
}
// si el perfil no es admin
if(perfil.equals("no")){
%>
<script>
    alert("USUARIO SIN PERMISOS")
</script>
<%
//out.print(""+juris_jv);
stmt1.execute("insert into registro_entradas values ('"+encar_validar+"', NOW(), 'INC', '0')");
unidad2_jv="";
cve_uni="";
}  
ban_ima=0;		
}
}
	   


%>


<html xmlns="http://www.w3.org/1999/xhtml">
    <!-- DW6 -->
    <head>
        <!-- Copyright 2005 Macromedia, Inc. All rights reserved. -->
        <title>:: SISTEMA DE CAPTURA ::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <link rel="stylesheet" href="mm_health_nutr.css" type="text/css" />
        <script language="JavaScript" type="text/javascript">
            //--------------- LOCALIZEABLE GLOBALS ---------------
            var d = new Date();
            var monthname = new Array("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre");
            //Ensure correct for language. English is "January 1, 2004"
            var TODAY = monthname[d.getMonth()] + " " + d.getDate() + ", " + d.getFullYear();
            //---------------   END LOCALIZEABLE   ---------------
        </script>
        <script language="javascript" src="list02.js"></script>
        <style type="text/css">
            <!--
            .style1 {font-size: 12px}
            body {
                background-image: url();
                background-color: #FFF;
            }
            .style2 {font-family: Arial, Helvetica, sans-serif}
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
            .style6 {font-size: 18px}
            .style7 {font-size: 12px; font-family: Arial, Helvetica, sans-serif; }
            .style9 {
                font-size: 12px;
                font-family: Arial, Helvetica, sans-serif;
                color: #990000;
                font-weight: bold;
            }
            .style10 {color: #EF6703}
            .style11 {color: #EF6703; font-weight: bold; }
            .style13 {color: #000000}
            -->
        </style>
    </head>
    <body onload="hora_Inv()">

        <table width="91%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
            <tr>
                <td height="50" colspan="5"><img src="imagenes/top1.jpg" width="901" height="104" /></td>
            </tr>
            <tr bgcolor="#99CC66">
                <td height="20" colspan="7" background="fn1.jpg" bgcolor="#FFFFFF" id="dateformat">&nbsp;&nbsp;</td>
            </tr>
            <tr>
                <td width="165" valign="top" bgcolor="#FFFFFF"><table border="0" cellspacing="0" cellpadding="0" width="165" id="navigation">
                    </table>
                    <p class="style1"><a href="pass_abasto.jsp" class="style1">CARGA ABASTO</a></p>
                    <p class="style1"><a href="inv_lyc.jsp?lote=on&cla_uni=<%=request.getParameter("cve")%>" class="style1">VER EXISTENCIAS</a></p>
                    <p><a href="index_reporte_consumo.jsp?cla_uni=<%=request.getParameter("cve")%>" class="style1">CONSUMO DIARIO </a></p>
                    <p class="style1"><a href="index_reporte.jsp?cla_uni=<%=request.getParameter("cve")%>" class="style1">REPORTES VALIDACION</a></p>
                    <p><a href="index_movi.jsp" class="style1">MOVIMIENTOS AL INVENTARIO </a></p>
                    <p><a href="kardex_lc.jsp?cla_uni=<%=request.getParameter("cve")%>" class="style1">KARDEX </a></p>
                    <p><a href="pass_compras.jsp" class="style1">REPOSICION/VENTAS</a></p>
                    <p><a href="ver_receta.jsp?cla_uni=<%=request.getParameter("cve")%>" class="style1">VER RECETA FARMACIA </a></p>
                    <p><a href="ver_receta_col.jsp?cla_uni=<%=request.getParameter("cve")%>" class="style1">VER RECETA COLECTIVA </a>      </p>

                    <p><a href="index_menu_receta.jsp" class="style1">MODIFICAR RECETA </a>      </p>
                    <p><a href="pass_nivel.jsp" class="style1">NIVEL DE SERVICIO EN FARMACIA </a>      <!--p><a href="rep_reabastecimiento.jsp" class="style1">REPORTE DE REABASTO </a></p-->

                        <!--p><a href="respaldo_base.jsp" class="style1">RESPALDAR BASE DE DATOS </a></p-->

                        <p><a href="catalogo_jq.jsp" class="style1" target="_blank">VER CAT&Aacute;LOGO</a></p>
                        <p><a href="pass_reabast.jsp" class="style1" target="_blank">REPORTE DE REABASTECIMIENTO</a></p>
                        <p><a href="reestruct.jsp" class="style1" target="_blank">REESTRUCTURACION DE LA BDD</a></p>
                        <!--p><a href="carga_inventario.jsp" class="style1" >SUBIR INVENTARIO</a></p-->
                </td>
                <td width="4">&nbsp;</td>
                <td colspan="2" valign="top"><div align="center"></div>
                    <div align="left"></div>
                    <div align="left"></div>
                    <table width="663" border="8" bordercolor="#EC3237" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="453" class="bodyText"><table width="652" border="0" align="center" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td height="37" colspan="4" bgcolor="#FFFFFF"><div align="center">
                                                <p align="center"><img src="imagenes/ima_main.jpg" width="431" height="82" /></p>
                                            </div></td>
                                    </tr>
                                    <tr>
                                        <td width="4" nowrap bgcolor="#FFFFFF">&nbsp;</td>
                                        <td width="5" bgcolor="#FFFFFF">&nbsp;</td>
                                        <td width="453"><div align="center">
                                                <table border="0" cellspacing="3" cellpadding="2" align="center">
                                                    <form action="index.jsp?cve=<%=cve_uni%>&ban=<%=ban_ima%>" method="post" name="form" >
                                                        <tr>
                                                            <td colspan="3"><div id="item21" style="display:none" align="justify" >
                                                                    <input type="text" name="txtf_hf" id="txtf_hf" size="10" readonly="true"/>
                                                                </div></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2"><div align="left"><span class="style7">Ingrese el N&uacute;mero de la Unidad:</span></div></td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3"><hr color="#000000" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td width="70" align="right"><div align="left"><span class="style1"><span class="style2">No. de Unidad</span></span>:</div></td>
                                                            <td colspan="2">

                                                                <div align="left">


                                                                    <input type="text" size="10" name="txtf_uni" readonly="readonly" value="<%=cve_uni%>" />

                                                                    <input type="submit" name="Submit" value="Mostrar"/>
                                                                    <span class="style7">                               <a href="tab.jsp" accesskey="n" target="_self">Ver Unidades</a></span>
                                                                    <%
                                                            if(ban_ima==0)
                                                             {
                                                                    %>
                                                                    <img src="imagenes/paso1.jpg" width="111" height="47"  />
                                                                    <%
                                                                    }
                                                                    if(ban==3)
                                                                    {
                                                                    cve_uni="-";
                                                                    //out.print("cve_uni"+cve_uni);
                                                                    %>
                                                                    <br />
                                                                    <span class="style9">Unidad inexistente CHECAR UNIDADES</span>

                                                                    <script>
                                                                        document.form.txtf_uni.focus();
                                                                    </script>
                                                                    <%
                                                                    }
                                                                    %>
                                                                    <script>
                                                                        document.form.select_encar.focus();
                                                                    </script>
                                                                </div></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" class="style1 style2"><hr color="#000000"/></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style1 style2"><div align="left">Nombre de la Unidad: </div></td>
                                                            <td colspan="2"><div align="left" class="style10">
                                                                    <textarea name="txtf_unidad" cols="50" class="style9"><%=unidad2_jv%></textarea>
                                                                </div></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style1 style2"><div align="left">Encargado:</div></td>
                                                            <td width="173"><div align="left"><select name="select_encar" class="style13" onchange="cerrar()" >
                                                                        <option selected="selected">--Escoja Encargado--</option>
                                                                        <%
		     
                                                       for(x1=0;x1<tam2;x1++)
                                                          {
                   
                                                                        %>
                                                                        <option value="<%=cad1[x1]%>"><%=cad1[x1]%></option>
                                                                        <%
                                                                  }
                                                                        %>
                                                                    </select>
                                                                </div></td>
                                                            <td width="220">
                                                                <%
                                                                if(ban_ima==1)
                                                                 {
                                                                %>
                                                                <div id="flotante" style="display:block;"> 
                                                                    <img src="imagenes/emp.jpg" />							</div>							</td>
                                                                    <%
                                                                                                }
                                                                    %>
                                                        </tr>
                                                        <tr>
                                                            <td class="style1 style2"><div align="left">Tipo Receta</div></td>
                                                            <td><div align="left">
                                                                    <select name="select_receta" class="style13" onchange="cerrar2()">
                                                                        <option selected="selected">--Escoja Receta--</option>
                                                                        <option value="Receta por Farmacia Fecha Automatica">1) Receta por Farmacia</option>
                                                                        
                                                                        <option value="Receta Colectiva Fecha Automatica">2) Receta Colectiva</option>
                                                                        

                                                                        <option value="Receta por Surtir Farmacia">3) Pendiente por Surtir Farmacia</option>
                                                                        <option value="Receta por Surtir Colectiva">4) Pendiente por Surtir Colectiva</option>
                                                                        <!--option value="Reporte Global por Fecha">Reporte Global por Fecha</option-->
                                                                    </select>
                                                                </div></td>
                                                            <td>
                                                                <div id="recetas" style="display:none;">
                                                                    <img src="imagenes/rece.jpg" width="160" height="39" />							</div>
                                                                <div align="left"></div></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" class="style1 style2"><div align="left">Contrase&ntilde;a:</div></td>
                                                            <td><div align="left">
                                                                    <input type="password" name="txtf_pass" id="txtf_pass" value="" style="width:90px" class="style2" onKeyPress="return handleEnter(this, event)" />
                                                                </div></td>
                                                            <td>
                                                                <div id="contra" style="display:none;">
                                                                    <img src="imagenes/contr.jpg" width="154" height="39" />							</div>							</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" class="style1 style2"><div align="left"></div></td>
                                                            <td colspan="2"><div align="left" class="style13"></div></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3"><p>
                                                                    <label>
                                                                        <div align="center">
                                                                            <div align="center">
                                                                                <input type="submit" name="Submit" value="Validar Usuario" />
                                                                            </div>
                                                                    </label>
                                                                    <p>
                                                                        <input type="hidden" value="1" name="altaOK" />
                                                                    </p></td>
                                                        </tr>
                                                        <input type="hidden" name="cmd" value="1" />
                                                    </form>
                                                </table>
                                            </div></td>
                                        <td width="194" nowrap bgcolor="#FFFFFF"><img src="imagenes/px.gif" width="1" height="1" alt="" border="0" /> 
                                            <img src="imagenes/caps.jpg" width="169" height="140" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">&nbsp;</td>
                                    </tr>
                                </table></td>
                        </tr>
                    </table>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                </td>
            </tr>
        </table>
         <br />
        &nbsp;<br />
        <td width="190" valign="top" bgcolor="#FFFFFF">&nbsp;</td>
        <td width="266" bordercolor="#FFFFFF">&nbsp;</td>
        </tr>
        <tr>
            <td width="165">&nbsp;</td>
            <td width="50">&nbsp;</td>
            <td width="4">&nbsp;</td>
            <td width="301">&nbsp;</td>
            <td width="50">&nbsp;</td>
            <td width="190">&nbsp;</td>
            <td width="266">&nbsp;</td>
        </tr>
        </table>
        <%
        // ----- try que cierra la conexión a la base de datos
                         try{
                       // Se cierra la conexión dentro del try
                         conn1.close();
                          }catch (Exception e){mensaje=e.toString();}
                   finally{ 
                       if (conn1!=null){
                           conn1.close();
                                        if(conn1.isClosed()){
                                     mensaje="desconectado2";}
                         }
                     }
                                 //out.print(mensaje);
                        // ---- fin de la conexión	 	  

        %>
    </body>
</html>
