<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.text.SimpleDateFormat" import="java.util.Date" import="java.text.ParsePosition" errorPage="" import ="java.awt.image.BufferedImage" import ="java.io.*" import ="javax.imageio.ImageIO" import ="net.sourceforge.jbarcodebean.*" import ="net.sourceforge.jbarcodebean.model.*" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("HH:mm:ss"); %>
<% 
//  Conexión a la BDD -------------------------------------------------------------
Class.forName("org.gjt.mm.mysql.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset= null;
Statement stmt2 = con.createStatement();
ResultSet rset2= null;
JBarcodeBean barcode = new JBarcodeBean();
// fin objetos de conexión ------------------------------------------------------
String but="";
String fol_rec="", nom_pac="", car_pac="", sex_pac = "", fec_nac="", folio_sp="", med1="", med2="", cod_pac="";
String cla_uni="";

rset = stmt.executeQuery("SELECT cla_uni from usuarios where ID_USU = '"+request.getParameter("id_usu")+"'");
while(rset.next()){
		cla_uni=(rset.getString("cla_uni"));
}

try{

but = request.getParameter("submit");
cod_pac = request.getParameter("txtf_cb");
fol_rec = request.getParameter("txtf_foliore");
nom_pac = request.getParameter("txtf_paciente");
car_pac = request.getParameter("txtf_carnet");
sex_pac = request.getParameter("txtf_sexo");
fec_nac = request.getParameter("txtf_edad");
folio_sp = request.getParameter("txtf_foliosp");
med1=request.getParameter("txtf_nomed");
med2=request.getParameter("txtf_cedu");
}catch (Exception e){
}
if (fol_rec == null){
fol_rec = "";
nom_pac = "";
car_pac = "";
sex_pac = "";
fec_nac = "";
folio_sp = "";
cod_pac="";
}

if (but!=null){
    if (but.equals("Mostrar")){
        int ban1=0;
        rset = stmt.executeQuery("select id_rec from receta r, usuarios u where r.fol_rec = '"+fol_rec+"' and r.id_tip = '1' and r.id_usu = u.id_usu and u.cla_uni = '"+cla_uni+"' ");
        while(rset.next()){
            ban1=1;
			//response.sendRedirect("rf.jsp?id_usu="+request.getParameter("id_usu")+"&tipo="+request.getParameter("tipo"));
			out.println("<script>alert('Receta ya capturada')</script>");
			out.println("<script>location.href=('rf.jsp?id_usu="+request.getParameter("id_usu")+"&tipo="+request.getParameter("tipo")+"');</script>");
        }
        if (ban1==1) {
            %>
            <!--script>
                alert("Receta ya capturada");
                window.locationf="rf.jsp";
            </script-->
            <%
        }
    }
    if (but.equals("Médico")){
		rset = stmt.executeQuery("select id_rec from receta r, usuarios u where r.fol_rec = '"+fol_rec+"' and r.id_tip = '1' and r.id_usu = u.id_usu and u.cla_uni = '"+cla_uni+"' ");
		while (rset.next()){
			//response.sendRedirect("rf.jsp?id_usu="+request.getParameter("id_usu")+"&tipo="+request.getParameter("tipo"));
			out.println("<script>alert=('Receta ya capturada')</script>");
			out.println("<script>location.href=('rf.jsp?id_usu="+request.getParameter("id_usu")+"&tipo="+request.getParameter("tipo")+"');</script>");
		}
		try{
				 barcode.setCode(fol_rec);
				 barcode.setCheckDigit(true);
				 BufferedImage bufferedImage = barcode.draw(new BufferedImage(100, 100, BufferedImage.TYPE_INT_RGB));
				 File file = new File("C://Program Files/Apache Group/Tomcat 4.1/webapps/rn_v12/cb/"+fol_rec+".png");
				 ImageIO.write(bufferedImage, "png", file);	
		}catch (Exception e) {}
        try{
            int ban = 0;
            rset = stmt.executeQuery("select id_rec from receta r, usuarios u where r.fol_rec = '"+fol_rec+"' and r.id_tip = '1' and r.id_usu = u.id_usu and u.cla_uni = '"+cla_uni+"' ");
            while (rset.next()){
                ban = 1;
            }
            if (ban==0){
				try{
					stmt.execute("insert into receta values ('0', '"+fol_rec+"', '"+folio_sp+"', '"+request.getParameter("txtf_medico")+"', '1', '"+request.getParameter("id_usu")+"', '"+request.getParameter("txtf_cause")+"', '-', '"+request.getParameter("txtf_carnet")+"', '0', '0', '1')");
					rset = stmt.executeQuery("select id_rec from receta where fol_rec = '"+fol_rec+"' and id_tip = '1' and id_usu = '"+request.getParameter("id_usu")+"' ");
					while (rset.next()){
						stmt2.execute("insert into bitacora values('0', '"+rset.getString("id_rec")+"', '"+(df.format(df2.parse(request.getParameter("txtf_date1")))+" "+df3.format(new Date()))+"', '0')");
					}
				} catch (Exception e) {
					rset = stmt.executeQuery("select id_rec from receta where fol_rec = '"+fol_rec+"' and id_tip = '1' and id_usu = '"+request.getParameter("id_usu")+"' ");
					while (rset.next()){
						stmt2.execute("update receta set cedula = '"+request.getParameter("txtf_medico")+"' where id_rec = '"+rset.getString("id_rec")+"' ");
					}
				}
            }
        } catch (Exception e) {System.out.println(e.getMessage());}
    }

    if (but.equals("Capturar")){
        int sol = Integer.parseInt(request.getParameter("txtf_sol1"));
        int sur = Integer.parseInt(request.getParameter("txtf_sol1"));
        int sol1=0;
        String det_pro = "";
        try{
            String id_rec="";
            rset = stmt.executeQuery("SELECT i.id_inv, DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, I.cant, DP.cla_fin, DP.id_ori FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla_pro = '"+request.getParameter("txtf_clave1")+"' AND US.id_usu='"+request.getParameter("id_usu")+"' ORDER BY  DP.id_ori, DP.cad_pro, I.cant ASC ");
            try{
            while (rset.next()){
				det_pro = rset.getString("det_pro");
				if(Integer.parseInt(rset.getString("cant"))>0){
					sol1=sol;
					sol = sol-Integer.parseInt(rset.getString("cant"));
					rset2 = stmt2.executeQuery("select id_rec from receta r, usuarios u where r.fol_rec = '"+fol_rec+"' and r.id_tip = '1' and r.id_usu = u.id_usu and u.cla_uni = '"+cla_uni+"' ");
					while (rset2.next()){
						id_rec = rset2.getString("id_rec");
					}
					if(sol <= 0){
						if (sol == 0 ){
							stmt2.execute("update inventario set cant = '0', web = '0' where id_inv = '"+rset.getString("id_inv")+"' ");
							sur = Integer.parseInt(rset.getString("cant"));
							stmt2.execute("insert into detreceta values ('0', '"+rset.getString("det_pro")+"', '"+request.getParameter("txtf_sol1")+"', '"+sur+"', '"+df.format(df2.parse(request.getParameter("txtf_date1")))+"', '1', '"+id_rec+"', CURTIME(), '0', '0' ) ");
							stmt2.execute("insert into kardex values ('0', '"+id_rec+"', '"+rset.getString("det_pro")+"', '"+sur+"', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA FAR', '"+request.getParameter("id_usu")+"', '0')");
						}
						if (sol < 0 ){
							stmt2.execute("update inventario set cant = '"+(-1*sol)+"', web = '0' where id_inv = '"+rset.getString("id_inv")+"' ");
							sur = sol*-1;
							stmt2.execute("insert into detreceta values ('0', '"+rset.getString("det_pro")+"', '"+(sol1)+"', '"+(sol1)+"', '"+df.format(df2.parse(request.getParameter("txtf_date1")))+"', '1', '"+id_rec+"', CURTIME(), '0', '0' ) ");
							stmt2.execute("insert into kardex values ('0', '"+id_rec+"', '"+rset.getString("det_pro")+"', '"+sol1+"', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA FAR', '"+request.getParameter("id_usu")+"', '0')");
						}
						break;
					}
					stmt2.execute("insert into detreceta values ('0', '"+rset.getString("det_pro")+"', '"+rset.getString("cant")+"', '"+rset.getString("cant")+"', '"+df.format(df2.parse(request.getParameter("txtf_date1")))+"', '1', '"+id_rec+"', CURTIME(), '0', '0' ) ");                    
					stmt2.execute("insert into kardex values ('0', '"+id_rec+"', '"+rset.getString("det_pro")+"', '"+rset.getString("cant")+"', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA FAR', '"+request.getParameter("id_usu")+"', '0')");
					stmt2.execute("update inventario set cant = '0', web = '0' where id_inv = '"+rset.getString("id_inv")+"' ");
					}
					else{
					}
				}
            } catch (Exception e) {out.println(e.getMessage());}
            if (sol>0){
				out.println("Sin existencia");
                rset = stmt.executeQuery("select id_rec from receta r, usuarios u where r.fol_rec = '"+fol_rec+"' and r.id_tip = '1' and r.id_usu = u.id_usu and u.cla_uni = '"+cla_uni+"' ");
                while (rset.next()){
                    id_rec = rset.getString("id_rec");
					out.println(id_rec);
                }
                stmt2.execute("insert into detreceta values ('0', '"+det_pro+"', '"+sol+"', '0', '"+df.format(df2.parse(request.getParameter("txtf_date1")))+"', '0', '"+id_rec+"', CURTIME(), '0', '0' ) ");
                stmt2.execute("insert into kardex values ('0', '"+id_rec+"', '"+det_pro+"', '0', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA FAR', '"+request.getParameter("id_usu")+"', '0')");
            }
        } catch (Exception e) {out.println(e.getMessage());}
    }
}

try{
	if(request.getParameter("receta_cap").equals("1")){
		rset = stmt.executeQuery("SELECT us.nombre, p.nom_pac, p.num_afi, p.sexo, p.fec_nac, m.nom_med, m.cedula, r.carnet FROM receta r, usuarios us, causes c, pacientes p, medicos m, tipo_receta t where r.id_usu = us.id_usu and r.id_cau = c.id_cau AND r.num_afi = p.num_afi AND r.cedula = m.cedula and r.id_tip = t.id_tip and r.fol_rec = '"+request.getParameter("txtf_foliore")+"'; ");
		while (rset.next()){
			nom_pac = rset.getString("nom_pac");
			sex_pac = rset.getString("sexo");
			fec_nac = rset.getString("fec_nac");
			folio_sp = rset.getString("num_afi");
			med1=rset.getString("nom_med");
			med2=rset.getString("cedula");
			car_pac=rset.getString("carnet");
		}
	}
} catch (Exception e) {}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
        <link rel="stylesheet" href="css/cupertino/jquery-ui-1.10.3.custom.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>.:Captura Receta FECHA AUTOMATICA:.</title>
        <script language="javascript" src="list02.js"></script>
        

        <style type="text/css">
            <!--
            .style2 {
                font-size: 10px;
                font-family: Arial, Helvetica, sans-serif;
                text-align: center;
            }
            .style4 {
                font-family: Arial, Helvetica, sans-serif;
                font-size: 14px;
                text-align: left;
            }
            .style5 {font-size: 14px}
            .style7 {
                font-size: 16px;
                font-family: Arial, Helvetica, sans-serif;
                font-weight: bold;
            }
            .style11 {font-size: 12px}
            .style13 {
                font-size: 12px;
                color: #990000;
                font-weight: bold;
            }
            .Estilo1 {color: #000000}
            .Estilo4 {
                color: #000066;
                font-weight: bold;
            }
            .Estilo5 {
                font-size: 16px;
                font-weight: bold;
            }
            .Estilo6 {color: #000099}
            .Estilo7 {
                font-size: 10px;
                font-family: Arial, Helvetica, sans-serif;
                color: #000099;
                font-weight: bold;
            }
            .Estilo8 {color: #003399}
            cen {
                text-align: center;
            }
            cen2 {
                text-align: center;
            }
            .style4 table {
                text-align: center;
            }
            -->
        </style>
    </head>

    <body onLoad="foco_inicial();">
        <form name="form" method="post" action="rf.jsp?tipo=<%=request.getParameter("tipo")%>&id_usu=<%=request.getParameter("id_usu")%>">
            <a href="index.jsp" class="style2">REGRESAR A MENÚ</a>
            <table width="972" height="644" border="3" align="center" cellpadding="2">
                <input type="hidden" name="vigencia" />
                <tr>
                    <td width="956" height="114"><table width="837" border="0" align="center" cellpadding="2">

                            <tr>
                                <td width="114" height="59"><img src="imagenes/nay_ima1.jpg" width="203" height="78" /></td>
                                <td width="339"><div align="center" class="style7">RECETA M&Eacute;DICA<br />
                                        DIRECCI&Oacute;N DE ATENCI&Oacute;N M&Eacute;DICA</div>
                                    <span class="style13"><span class="Estilo1">
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="Estilo6">&nbsp;</span></span></span><span class="Estilo7">&nbsp;BIENVENIDO (A):</span>
                                    <span class="style2">
                                    <span class="Estilo4">
                                    <%
									rset = stmt.executeQuery("SELECT nombre from usuarios where ID_USU = '"+request.getParameter("id_usu")+"'");
									while(rset.next()){
											out.println(rset.getString("nombre"));
									}
									%>
                                    </span>
                                    </span></td>
                                <td width="225"><div align="right"><img src="imagenes/ssn.jpg" width="219" height="89" /></div>
                                    <!--input name="Submit"  type="reset" class="bodyText" value="Borrar Datos" /--></td>
                            </tr>
                        </table>
                        <table width="854" height="45" border="0" align="center" cellpadding="2">
                            <tr>
                                <td width="311" height="41">
                                    <table width="270" height="0%" border="0" cellpadding="2">
                                        <tr>

                                            <td width="221" height="100%" class="style2">
                                                FECHA:&nbsp;
                                                <%
												if(request.getParameter("txtf_date1")==null){
													%>
                                                    <input name="txtf_date1" id="txtf_date1" type="text" size="20" value="<%=df2.format(new Date())%>" onKeyUp="putFecha(this.form)" onKeyPress="return handleEnter(this, event)" readonly/>
                                                    <%
												}
												else{
													%>
                                                    <input name="txtf_date1" id="txtf_date1" type="text" size="20" value="<%=(request.getParameter("txtf_date1"))%>" onKeyUp="putFecha(this.form)" onKeyPress="return handleEnter(this, event)" readonly/>
                                                    <%
												}
												%>
                                                
                                            </td>
                                        </tr>
                                    </table>          </td>
                                <td width="197"><table width="167" height="0%" border="0" cellpadding="2">
                                        <tr>
                                            <td width="225" height="100%" class="style2">&nbsp;</td>
                                        </tr>
                                    </table>          </td>
                                <td width="326" align="center" class="style2">Ingrese No. Folio
                                    <input name="txtf_foliore" id="txtf_foliore" type="text" class="style13"  value="<%=fol_rec%>" size="20" onKeyPress="return handleEnter(this, event)" />
                                    <!--onKeyPress="return validar(event)"-->
                                    <a href="ver_receta.jsp?cla_uni=<%=cla_uni%>" target="_blank">Reimprir Ticket</a>
                                    <table width="152" height="0%" border="0" align="right" cellpadding="2">
                                    </table></td>
                            </tr>
                        </table>    </td>
                </tr>
                <tr>
                    <td height="2" colspan="3" class="style4"><div id="item7" style="display:block" align="justify" ></div></td>
                </tr>
                <tr>
                    <td height="41" colspan="3" class="style4"><table width="710" border="0" align="center" cellpadding="2">
                            <%
                            rset = stmt.executeQuery("SELECT US.CLA_UNI, U.DES_UNI FROM USUARIOS US, UNIDADES U WHERE U.CLA_UNI = US.CLA_UNI AND US.ID_USU = '"+request.getParameter("id_usu")+"'");
                            while(rset.next()){
                            %>
                            <tr>
                                <td width="533" class="style2">
                                    UNIDAD DE SALUD
                                    <input type="text" name="txtf_unidadmed" size="60" colspan="3" class="style13"  value="<%=rset.getString(2)%>" readonly onKeyPress="return handleEnter(this, event)"/></td>
                                <td width="170">
                                </td>
                            </tr>
                            <%
                            }
                            %>
                        </table></td>
                </tr>
                <tr>
                    <td height="91" colspan="3" class="style4"><table width="901" border="0" align="center" cellpadding="2">
                            <tr>
                                <td height="27" colspan="5" class="style2">Introduzca C&oacute;digo  Paciente: 
                                    <input name="txtf_cb" type="text" id="txtf_cb"  onchange="" value="<%=cod_pac%>" onkeypress="return handleEnter(this, event)"/>
                                    <input name="submit" type="submit" class="subHeader" value="Mostrar" onClick="return verifica_FOLIO(document.forms.form);"/>&nbsp;&nbsp;
                                    <select name="slct_afiliados" id="slct_afiliados" class="style2" onkeypress="return handleEnter(this, event)" onChange="putNom(this.form)">
                                        <option>---- AFILIADOS------</option>
                                        <%
										try{
                                        rset = stmt.executeQuery("select nom_pac, num_afi, fec_nac, fin_vig, sexo from pacientes where num_afi = '"+request.getParameter("txtf_cb")+"'");
                                        while (rset.next()){
											if ( (new Date()).before(df.parse(rset.getString("fin_vig"))) ){
												out.println("<option value = '"+rset.getString("nom_pac")+","+rset.getString("fec_nac")+","+rset.getString("sexo")+","+rset.getString("num_afi")+","+rset.getString("fin_vig")+"'>"+rset.getString("nom_pac")+"</option>");
											} else {
												out.println("<option value = '"+rset.getString("nom_pac")+","+rset.getString("fec_nac")+","+rset.getString("sexo")+","+rset.getString("num_afi")+","+rset.getString("fin_vig")+",true'>"+rset.getString("nom_pac")+"</option>");
											}
                                        }
										}catch (Exception e) {}
                                        %>
                                        <span class="style2">AFILIADOS
                                    </select>
                                    <a href="paciente.jsp?id_usu=<%=request.getParameter("id_usu")%>" target="_blank">Nuevo paciente</a></td>
                            </tr>
                            <tr>
                                <td width="146" height="52" class="style2">NOMBRE DEL PACIENTE:
                                    <label> </label>
                                    <span class="style5">
                                        <label> </label>
                                    </span>
                                    <label><span class="style2">
                                        </span></label></td>
                                <td width="318" class="style2"><span class="style5">
                                        <input name="txtf_paciente" type="text" class="style13" value="<%=nom_pac%>" size="50"  onkeypress="return handleEnter(this, event)" onChange="mayPaciente(this.form)" readonly/><span class="style2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />NOMBRE(S)&nbsp;&nbsp;APELLIDO PATERNO &nbsp;APELLIDO MATERNO
                                        </span></td>
                                <td width="112" class="style2">Carnet:&nbsp;
                                    <input name="txtf_carnet" type="text" class="style13" value="<%=car_pac%>" size="8"  onkeypress="return handleEnter(this, event)"/></td>
                                <td width="121" class="style2">Sexo:
                                    <input name="txtf_sexo" type="text" class="style13" value="<%=sex_pac%>" size="8"  onkeypress="return handleEnter(this, event)" onChange="maySexo(this.form)" readonly/></td>
                                <td width="172">
                                    <table width="137" border="0" align="right" cellpadding="2">
                                        <tr>
                                            <td width="129">
                                                <div align="left"><span class="style2">
                                                        Fecha Nac:</span><span class="style2">
                                                        <input name="txtf_edad" type="text" class="style13" value="<%=fec_nac%>" size="15"  onkeypress="return handleEnter(this, event)" readonly/>
                                                    </span>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="82" colspan="3" class="style4"><table width="733" border="0" align="center" cellpadding="2">
                            <tr>
                                <td width="87"  class="style2"><div align="center"> </div></td>
                                <td width="135" class="style2"><div align="center"></div></td>
                                <td width="140" class="style2"><div align="center"></div></td>
                                <td width="345" class="style2"><div align="center">No. DE FOLIO S.P. </div></td>
                            </tr>
                            <tr>
                                <td class="style11"><label> <br />
                                </label></td>
                                <td class="style11"><label><img src="imagenes/oportunidades.jpg" width="107" height="32" /></label></td>
                                <td class="style11"><label><img src="imagenes/salud_seguro_popu.jpg" width="107" height="32" /></label></td>
                                <td class="style11"><input name="txtf_foliosp" type="text" readonly class="style13" value="<%=folio_sp%>" size="50" onKeyPress="return handleEnter(this, event)"/></td>
                                <td><span class="style11"><span class="letras"><span class="style2">CAUSES:
                                        <input name="txtf_cause" type="text" class="style13" onKeyPress="return handleEnter(this, event)" value="1" size="1" onClick="putEmpty()" />
                                </span></span></span></td>
                            </tr>

                        </table></td>
                </tr>
                <tr>
                    <td height="38" colspan="3" class="style4"><table width="763" border="0" align="center" cellpadding="2">
                            <tr>
                                <td width="755" class="style2"><a href="medico.jsp" target="_blank">AGREGAR NUEVO MÉDICO</a>: 
                                <%
								String ced_med="";
								try{
									ced_med=request.getParameter("txtf_medico");
								}catch (Exception e){}
								if(ced_med==null){
									ced_med="";
								}
								%>
                                    <input name="txtf_medico" type="text" size="10" value="<%=ced_med%>" onchange="" onKeyPress="return handleEnter(this, event)" />
                                    <input name="submit" type="submit" class="subHeader" value="Médico" onClick="return verifica_FOLIO(document.forms.form);" />
                                    <%
                                    try{
                                    rset = stmt.executeQuery("select cedula, nom_med from medicos where cedula  ='"+request.getParameter("txtf_medico")+"'");
                                    while(rset.next()){
                                    %>
                                    NOMBRE:
                                    <input name="txtf_nomed" id="txtf_nomed" type="text" class="style13" value="<%=rset.getString(2)%>" size="35"  onKeyPress="return handleEnter(this, event)" readonly />
                                    <span class="style2">
                                        C&Eacute;DULA: 
                                        <input name="txtf_cedu" id="a" type="text" class="style13" value="<%=rset.getString(1)%>" size="10"  onKeyPress="return handleEnter(this, event)" readonly/>
                                    </span>
                                    <%
                                    }
                                    } catch (Exception e) {}
                                    %>
                                </td>
                            </tr>
                        </table></td>
                </tr>
                <tr>
                    <td height="219" colspan="3" class="style4">

                        <table width="875" border="0" align="center" cellpadding="2">

                            <tr class="style2">
                                <td colspan="4" class="style11" align="left">Ingrese Clave:
                                    <input type="text" name="txtf_med1" id="txtf_med1" size="10" value="" onKeyPress="return handleEnter(this, event)"/>
                                    <input name="submit" type="submit" class="subHeader" value="Clave" onClick="return verifica_FOLIO(document.forms.form);"/>&nbsp;
                                    <a href="index_carga_clave.jsp?id_usu=<%=request.getParameter("id_usu")%>" target="_blank">Agregar Clave</a>| <a href="existencias.jsp?id_usu=<%=request.getParameter("id_usu")%>" target="_blank">Ver Existencias</a>
                                </td>
                                
                                <td colspan="5" class="style11">
                                    <span class="style2">
                                        <span class="Estilo8">
                                        <%
											int ban_cla=0;
                                            String clave="", descr="", fuente = "", cantidad = "0", det_pro="";
                                            rset = stmt.executeQuery("SELECT DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, sum(I.cant) as cant, DP.cla_fin FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla_pro = '"+request.getParameter("txtf_med1")+"' AND US.id_usu='"+request.getParameter("id_usu")+"' GROUP BY P.cla_pro ORDER BY DP.cad_pro, I.cant ASC ;");
                                            while(rset.next()){
                                                clave = rset.getString("cla_pro");
                                                descr = rset.getString("des_pro");
                                                cantidad = rset.getString("cant");
                                                fuente = rset.getString("cla_fin");
                                                det_pro = rset.getString("det_pro");
												ban_cla=1;
                                            }
                                        %>
                                        TOTAL EXISTENCIAS:<%=cantidad%>
                                        </span>
                                        <%
										if (ban_cla==0&&but!=null&&but.equals("Clave")){
										%>
                                        <script>
										alert('Insumo sin existencia');
										</script>
                                        <%
										}
										%>
                                        <span class="Estilo5">
                                            <br />
                                            <%
											cantidad = "0";
                                            rset = stmt.executeQuery("SELECT DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, sum(I.cant) as cant, DP.cla_fin FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla_pro = '"+request.getParameter("txtf_med1")+"' AND US.id_usu='"+request.getParameter("id_usu")+"' and DP.id_ori='1' GROUP BY P.cla_pro ORDER BY DP.cad_pro, I.cant ASC ;");
                                            while(rset.next()){
                                                clave = rset.getString("cla_pro");
                                                descr = rset.getString("des_pro");
                                                cantidad = rset.getString("cant");
                                                fuente = rset.getString("cla_fin");
                                                det_pro = rset.getString("det_pro");
                                            }
                                            %>
                                            Origen 1=<%=cantidad%>
                                            <%
											cantidad="0";
                                            rset = stmt.executeQuery("SELECT DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, sum(I.cant) as cant, DP.cla_fin FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla_pro = '"+request.getParameter("txtf_med1")+"' AND US.id_usu='"+request.getParameter("id_usu")+"' and DP.id_ori='2' GROUP BY P.cla_pro ORDER BY DP.cad_pro, I.cant ASC ;");
                                            while(rset.next()){
                                                clave = rset.getString("cla_pro");
                                                descr = rset.getString("des_pro");
                                                cantidad = rset.getString("cant");
                                                fuente = rset.getString("cla_fin");
                                                det_pro = rset.getString("det_pro");
                                            }
                                            %>
                                            &nbsp;Origen 2=<%=cantidad%>
                                        </span>
                                    </span>
                                </td>
                                <td colspan="2" class="style11">
                                    <label>
                                    </label>
                                </td>
                            </tr>

                            <tr>
                                <td width="70" class="style11">
                                    <span class="letras">
                                        <span class="style2">
                                            CLAVE
                                        </span>
                                    </span>
                                </td>
                                <td colspan="2" class="style11">
                                    <span class="letras">
                                        <span class="style2">
                                            DESCRIPCI&Oacute;N
                                        </span>
                                    </span>
                                </td>
                                <td width="68" class="style11">
                                    <span class="letras">
                                        <span class="style2">
                                            CANT SOL
                                        </span>
                                    </span>
                                </td>
                                <td colspan="2" class="style11">
                                    <span class="letras">
                                        <span class="style2">
                                            CANT SUR
                                        </span>                                            
                                    </span>
                                </td>
                                <td colspan="3" class="style11">
                                    <span class="style2">
                                        INDICACIONES
                                    </span>
                                </td>
                                <td colspan="2" class="style11">&nbsp;</td>
                            </tr>

                            <tr>
                                <td class="style11">
                                    <input type="text" name="txtf_clave1" id="txtf_clave1" size="10" class="style2" value="<%=clave%>"  readonly="true"/>
                                </td>
                                <td colspan="2" class="style11">
                                    <textarea name="txtf_descrip1" cols="50"  class="style2" readonly><%=descr%></textarea>
                                </td>
                                <td class="style11">
                                    <input type="text" name="txtf_sol1" id="txtf_sol1" size="5" value="0" onKeyPress="return handleEnter(this, event)"  />
                                </td>
                                <td colspan="2" class="style11">
                                    <input type="text" name="txtf_sur1" size="5" value="0"  onchange="setSur(this.form)" onKeyPress="return handleEnter(this, event)" readonly/>
                                </td>
                                <td colspan="3" class="style11">
                                    <div align="center">
                                        <label for="textfield"></label>
                                        <input type="text" name="txtf_ind" id="txtf_ind" value="-" onKeyPress="return handleEnter(this, event)"/>
                                    </div>
                                </td>
                                <td colspan="2" class="style11">&nbsp;
                                    <input name="submit" type="submit" id="capturaid" class="but" value="Capturar" onClick="return verificaN_Fa(document.forms.form);" onChange="setSur(this.form)"/></td>
                            </tr>
                            <tr class="letras">
                                <td colspan="9" class="style11">
                                    <hr />
                                </td>
                            </tr>
                            <tr class="letras">
                                <td class="style11"><a name="ancla1"></a><span class="style2">CLAVE</span></td>
                                <td width="213" class="style11"><span class="style2">DESCRIPCI&Oacute;N</span></td>
                                <td width="67" class="style11"><span class="style2">LOTE</span></td>
                                <td class="style11"><span class="style2">CADUCIDAD</span></td>
                                <td colspan="2" class="style11"><span class="style2">CANT. SOL</span></td>
                                <td width="68" class="style11"><span class="style2">CANT. SUR</span></td>
                                <td width="56" class="style11"><span class="style2">ESTATUS</span></td>
                                <td width="48" class="style11"><span class="style2">ORIGEN</span></td>
                                <td width="161" class="style11">&nbsp;</td>
                            </tr>
                            <tr class="letras">
                                <td colspan="9" class="style11"><hr /></td>
                            </tr>
                            <%
                            try{
                            rset = stmt.executeQuery("SELECT dr.fol_det, p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, dr.can_sol, dr.cant_sur, dr.status, o.des_ori from productos p, detalle_productos dp, detreceta dr, receta r, origen o where dr.baja !='1' and p.cla_pro = dp.cla_pro and dp.det_pro = dr.det_pro AND dr.id_rec = r.id_rec AND dp.id_ori = o.id_ori AND r.fol_rec = '"+request.getParameter("txtf_foliore")+"' and r.id_usu = '"+request.getParameter("id_usu")+"' ;");
                            while(rset.next()){
                            %>
                            <tr>
                                <td class="style2"><%=rset.getString("cla_pro")%></td>
                                <td class="style2"><%=rset.getString("des_pro")%></td>
                                <td class="style2"><%=rset.getString("lot_pro")%></td>
                                <%
                                try{
                                %>  
                                <td class="style2"><%=df2.format(df.parse(rset.getString("cad_pro")))%></td>
                                <%
                                } catch (Exception e) {}
                                %>
                                <td colspan="2" class="style2"><%=rset.getString("can_sol")%></td>
                                <td class="style2"><%=rset.getString("cant_sur")%></td>
                                <td class="style2"><%=rset.getString("status")%></td>
                                <td class="style2"><%=rset.getString("des_ori")%></td>
                                <td class="style2">
                                    <a href = "eliminar_rf.jsp?fol_det=<%=rset.getString("fol_det")%>&id_usu=<%=request.getParameter("id_usu")%>&txtf_foliore=<%=fol_rec%>">Eliminar</a>
                                </td>
                            </tr>
                            <%
                            }}catch(Exception e){out.println(e.getMessage());}
                            %>
                            <tr class="letras">
                                <td colspan="9" class="style11"><hr /></td>
                            </tr>
                            <tr>
                                <td height="28" class="style11">&nbsp;</td>
                                <td class="style11">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td class="style11">&nbsp;</td>
                                <td class="style11">&nbsp;</td>
                                <td class="style11">&nbsp;</td>
                                <td class="style11">&nbsp;</td>
                                <td class="style11">&nbsp;</td>
                                <td class="style11">&nbsp;</td>
                                <td class="style11">&nbsp;</td>
                                <td class="style11"><div >
                                  <p>
                                    <a href="ticket.jsp?fol_rec=<%=fol_rec%>&id_usu=<%=request.getParameter("id_usu")%>&tipo=<%=request.getParameter("tipo")%>">Imprimir</a>
                                  </p>
                                    </div>
                                </td>
                            </tr>

                        </table></td>
                </tr>
            </table></td>
            </tr>
            </tr>
            </table>

        </form>

    </body>
</html>
<%
con.close();
%>
<script type="text/javascript">
            function validar(e) { // 1
                tecla = (document.all) ? e.keyCode : e.which; // 2
                if (tecla == 8)
                    return true; // 3
                patron = /\d/; // Solo acepta números



                //SOLO LETRAS-->patron =/[A-Za-z\s]/; // 4
                //SOLO LETRAS Y NUMEROS --> patron = /\d/; // Solo acepta números
                //numeros y letras --> patron = /\w/; // Acepta números y letras
                //no aceptan numeros --> patron = /\D/; // No acepta números
                //aceptan las letras ñÑ --> patron =/[A-Za-zñÑ\s]/; // igual que el ejemplo, pero acepta también las letras ñ y Ñ  
                //determinado letras y numeros --> patron = /[ajt69]/;//También se puede hacer un patrón que acepte determinados caracteres, poniendolos entre corchetes. Veamos un ejemplo para validar que solo se acepte a, j, t, 6 y 9:

                te = String.fromCharCode(tecla); // 5
                return patron.test(te); // 6
            }

            function foco_inicial() {
				location.href='#ancla1'
				document.form.txtf_foliore.focus()
				if (document.form.txtf_foliore.value != "") {
                    document.form.txtf_cb.focus()
                }
				if (document.form.txtf_cb.value != "") {
                    document.form.slct_afiliados.focus()
                }
				if (document.form.txtf_nomed.value != "") {
                    document.form.txtf_med1.focus()
                }
				if (document.form.txtf_clave1.value != "") {
					document.form.txtf_sol1.value=""
                    document.form.txtf_sol1.focus()
                }
            }

        </script>
<script src="jqry/jquery-1.9.1.js"></script>
<script src="jqry/jquery-ui-1.10.3.custom.js"></script>
<script>
    $(function() {
        $("#txtf_date1").datepicker({dateFormat: "dd/mm/yy"}).val()
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