<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" errorPage="error.html" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%
// Conexión BDD vía JDBC
  Class.forName("org.gjt.mm.mysql.Driver");
  Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
  Statement stmt = con.createStatement();
  ResultSet rset=null;
// fin conexión bdd  
String cla_pro="", id_ori = "", des_pro="", sub = "", cad_pro = "", lot_pro="";
try{
	cla_pro = request.getParameter("txtf_clave");
	id_ori = request.getParameter("id_ori_");
	des_pro = "";
}catch(Exception e){
}
if (cla_pro == null){
	cla_pro ="";
	id_ori ="";
}
try{
	sub = request.getParameter("submit");
	if (sub.equals("Mostrar")){
		id_ori = request.getParameter("id_ori");
		cla_pro = request.getParameter("cla_pro");
		des_pro = request.getParameter("des_pro");
		cad_pro = request.getParameter("cad_pro");
		lot_pro = request.getParameter("lot_pro");
	}
}catch(Exception e){
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
    <title>.: KARDEX :.</title>
    <script language="javascript" src="list02.js"></script>
    <script>
        function foco_inicial() {
            if (document.form.txtf_clave2.value == "") {
                document.form.txtf_clave.focus();
            }
            else {
                document.form.txtf_cant.focus();
            }
        }
    </script>
    <link rel="stylesheet" href="mm_restaurant1.css" type="text/css"/>
    </style>
    <link href="css/demo_table_jui.css"
    rel="stylesheet"
    type ="text/css"/>
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

</head>

<body onLoad="foco_inicial();">
<table width="952" height="346" border="3" align="center" cellpadding="2" bgcolor="#FFFFFF">
    <tr>

        <td width="650">
            <form id="form" name="form" method="post" action="kardex_lc.jsp?cla_uni=<%=request.getParameter("cla_uni")%>">
                <span class="style5">
                </span>
                <table width="856" height="344" border="0" align="center" cellpadding="2">
                    <tr>
                        <td height="49" bgcolor="#FFFFFF" class="logo style1">
                            <div align="center" class="logo style1"><img src="imagenes/nay_ima1.jpg" width="142"
                                                                         height="72"/></div>
                        </td>
                        <td height="49" colspan="3" bgcolor="#FFFFFF" class="logo style1">
                            <div align="center">KARDEX POR CLAVE*</div>
                        </td>
                        <td width="156" height="49" bgcolor="#FFFFFF" class="logo style1"><img src="imagenes/ssn.jpg"
                                                                                               width="156" height="65"/>
                        </td>
                    </tr>
                    <tr>
                        <td height="6" colspan="5"><a href="index.jsp">Regresar a Men&uacute;</a></td>
                    </tr>
                    <tr>
                        <td height="6" colspan="5">
                            <hr/>
                        </td>
                    </tr>
                    <tr>
                        <td width="142" height="20"><span class="Estilo6">Seleccione Origen  :</span></td>
                        <td colspan="4" class="bodyText"><span class="Estilo6"><span class="style5">
                                            <select name="id_ori_" class="Estilo6"
                                                    onkeypress="return handleEnter(this, event)" onChange="put_cve()">
                                                <option value="">--Todos--</option>
                                                <option value="1">SSN</option>
                                                <option value="2">SAVI</option>
                                            </select>
                                            Ingrese Clave  :
                                            <input name="txtf_clave" type="text" id="txtf_clave" size="15"/>
                                            <input type="submit" name="submit" value="Clave"/>
                                            <%
											
											rset = stmt.executeQuery("select cla_pro, des_pro from productos where cla_pro = '"+request.getParameter("txtf_clave")+"'");
											while(rset.next()){
												des_pro = rset.getString("des_pro");
											}
											%>
                                        </span></span><span class="Estilo6">Origen: <span class="style5">
                                            <input name="id_ori" type="text" id="txtf_origen" onChange="mayApemm(this.form)" onKeyPress="return handleEnter(this, event)" value="<%=id_ori%>" size="10"/>
                                        </span></span></td>
                    </tr>
                    <tr>
                        <td height="8" colspan="5">
                            <hr/>
                        </td>
                    </tr>
                    <tr>
                        <td height="20">
                            <div align="right">
                                <div align="left" class="Estilo6">Clave:</div>
                            </div>
                        </td>
                        <td colspan="4" class="style5"><span class="Estilo6">
                                        <input name="cla_pro" type="text" id="txtf_clave2"
                                               onChange="mayNomm(this.form)"
                                               onKeyPress="return handleEnter(this, event)" value="<%=cla_pro%>"
                                               size="10" readonly/>
                                        Descripci&oacute;n:</span><span class="Estilo6">
                                        <textarea name="des_pro" cols="50" id="txtf_descrip"
                                                  onChange="mayApepm(this.form)"
                                                  onKeyPress="return handleEnter(this, event)" readonly><%=des_pro%>
                                        </textarea>
                                    </span>

                            <div align="left" class="Estilo6"></div>
                        </td>
                    </tr>
                    <tr>
                        <td height="20">
                            <div align="right">
                                <div align="left"><span class="Estilo6">Lote: </span></div>
                            </div>
                        </td>
                        <td colspan="4" class="style5"><input name="lot_pro" type="text" id="txtf_lote"
                                                              onChange="mayApemm(this.form)"
                                                              onKeyPress="return handleEnter(this, event)"
                                                              value="<%=lot_pro%>" size="10"/>
                          <select name="slct_lote" class="bodyText" onChange="setLot1(this.form);
                dimePropiedades(this.form);" onkeypress="return handleEnter(this, event)">
                            <option value="">-- Todos --</option>
                              <%
							  try{
							  sub=request.getParameter("submit");
							  if(sub.equals("Clave")){
							  rset=stmt.executeQuery("select p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, i.cant, o.des_ori, dp.cla_fin FROM usuarios us, unidades u, inventario i, detalle_productos dp, productos p, origen o where  us.cla_uni = u.cla_uni and u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro and dp.cla_pro = p.cla_pro AND dp.id_ori = o.id_ori and p.cla_pro='"+cla_pro+"' group by dp.lot_pro");
							  while(rset.next()){
								  out.println("<option value ='"+rset.getString("lot_pro")+"'>"+rset.getString("lot_pro")+"</option>");
								  }
							  }
							  } catch (Exception e){
							  }
							  %>
                                </option>
                            </select>
                          <span class="Estilo6">Caducidad: 
                              <input name="cad_pro" type="text" id="txtf_cad" onChange="mayApemm(this.form)"
                                               onKeyPress="return handleEnter(this, event)" value="<%=cad_pro%>"
                                               size="10"/>
                              <select name="slct_cad" class="bodyText" onChange="setCad(this.form)"
                                                onkeypress="return handleEnter(this, event)">
                                  <option value="">-- Todas --</option>
                                  <%
									try{
									sub=request.getParameter("submit");
									if(sub.equals("Clave")){
									rset=stmt.executeQuery("select p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, i.cant, o.des_ori FROM usuarios us, unidades u, inventario i, detalle_productos dp, productos p, origen o where  us.cla_uni = u.cla_uni and u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro and dp.cla_pro = p.cla_pro AND dp.id_ori = o.id_ori and p.cla_pro='"+cla_pro+"' group by cad_pro");
									while(rset.next()){
										out.println("<option  value ='"+df2.format(df.parse(rset.getString("cad_pro")))+"'>"+df2.format(df.parse(rset.getString("cad_pro")))+"</option>");
										}
									}
									} catch (Exception e){
									}
									%>
                                            </option>
                                        </select>
                              <input type="submit" name="submit" value="Mostrar"/>
                                    </span></td>
                    </tr>
                    <tr>
                        <td height="7" colspan="5">
                            <hr/>
                        </td>
                    </tr>


                    <tr>
                        <td height="20" colspan="10">
                            <table width="97%" border="0" cellpadding="0" cellspacing="0" id="dataTable">
                                <thead>
                                <tr>
                                    <th colspan="10" class="FECHA">
                                        <hr/>
                                    </th>
                                </tr>
                                <tr>
                                    <th width="4%" class="FECHA">FOLIO</th>
                                    <th width="8%" class="FECHA">FOLIO DE ABASTO</th>
                                    <th width="9%" class="FECHA">CANTIDAD</th>
                                    <th width="7%" class="FECHA">TIPO DE MOVIMIENTO</th>
                                    <th width="27%" class="FECHA">OBSERVACION</th>
                                    <th width="8%" class="FECHA">ORIGEN</th>
                                    <th width="11%" class="FECHA">USUARIO</th>
                                    <th width="9%" class="FECHA">FECHA</th>


                                </tr>
                                <tr>
                                    <th colspan="10" class="FECHA">
                                        <hr/>
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                <!--Loop start, you could use a repeat region here-->
                                <%
								try{
								rset = stmt.executeQuery("SELECT r.fol_rec, k.fol_aba, k.cant, k.tipo_mov, k.obser, dp.id_ori, us.nombre, k.fecha FROM unidades un, usuarios us, kardex k, detalle_productos dp, productos p, receta r WHERE un.cla_uni = us.cla_uni AND us.id_usu = k.id_usu AND k.det_pro = dp.det_pro AND dp.cla_pro = p.cla_pro AND k.id_rec = r.id_rec AND p.cla_pro = '"+request.getParameter("cla_pro")+"' AND dp.lot_pro = '"+request.getParameter("lot_pro")+"' AND dp.cad_pro = '"+df.format(df2.parse(request.getParameter("cad_pro")))+"' AND dp.id_ori = '"+request.getParameter("id_ori")+"' ;");
								while(rset.next()){
									try{
								%>
                                <tr height="20">
                                    <td class="negritas" align="center"><%=rset.getString("fol_rec")%></td>
                                    <td class="negritas"><%=rset.getString("fol_aba")%></td>
                                    <td class="negritas" align="center"><%=rset.getString("cant")%></td>
                                    <td align="center" class="negritas"><%=rset.getString("tipo_mov")%></td>
                                    <td align="center" class="negritas"><%=rset.getString("obser")%></td>
                                    <td align="center" class="negritas"><%=rset.getString("id_ori")%></td>
                                    <td align="center" class="negritas"><%=rset.getString("nombre")%></td>
                                    <td align="center" class="negritas"><%=rset.getString("fecha")%></td>
                                </tr>
                                <%
									}catch(Exception e){}
								}
								}catch(Exception e){}
								%>
                                </tbody>
                            </table>
                            *
                        </td>
                    </tr>
                    <tr>
                        <td height="20"><!--TOTAL DE ENTRADAS:--></td>
                        <td width="165" class="style5">&nbsp;</td>
                        <td width="259" class="style5">&nbsp;</td>
                        <td width="102" class="style5">&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="20"><!--TOTAL DE SALIDAS:--></td>
                        <td class="style5">&nbsp;</td>
                        <td class="style5"></td>

                        <td class="style5">&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="20">EXISTENCIAS:</td>
                        <%
						
						try{
						  rset = stmt.executeQuery("SELECT i.cant FROM inventario i, detalle_productos dp WHERE dp.cla_pro = '"+request.getParameter("cla_pro")+"' AND dp.lot_pro = '"+request.getParameter("lot_pro")+"' AND dp.cad_pro = '"+df.format(df2.parse(request.getParameter("cad_pro")))+"' AND dp.id_ori = '"+request.getParameter("id_ori")+"' and i.det_pro = dp.det_pro  ;");
						  while(rset.next()){
							  try{
							  %>
							  <td class="style5"><%=rset.getString("CANT")%></td>
							  <%
							  }catch(Exception e){}
						  }
						  }catch(Exception e){}
						  %>
                        <td class="style5">&nbsp;</td>
                        <td class="style5">&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
</table>

<script type="text/javascript">
    // BeginOAWidget_Instance_2586523: #dataTable

    $(document).ready(function () {
        oTable = $('#dataTable').dataTable({
            "bJQueryUI": true,
            "bScrollCollapse": false,
            "sScrollY": "200px",
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

</body>
</html>

<%
con.close();
%>
