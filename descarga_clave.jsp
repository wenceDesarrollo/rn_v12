<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" errorPage=""  import="java.util.Date"%>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<% 
/*------------------------------------------------------------------------------------------
Nombre de archivo: carga_clave.jsp
Funcion: Carga Clave a inventario de forma manual, se queda registro del asiento
  -----------------------------------------------------------------------------------------*/
// Conexión BDD vía JDBC
  Class.forName("org.gjt.mm.mysql.Driver");
  Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
  Statement stmt = con.createStatement();
  ResultSet rset=null;
// fin conexión bdd  
String sub="";
String clave="", desc="", lot="", cad="", ori="", cant="", cant_sum="", obser="", financ="";

try{
	sub=request.getParameter("submit");
	clave=request.getParameter("txtf_clave2");
	desc=request.getParameter("txtf_descrip");
	lot=request.getParameter("txtf_lote");
	cad=request.getParameter("txtf_cad");
	if(sub.equals("Clave")){
		clave=request.getParameter("txtf_clave");
		rset=stmt.executeQuery("select p.cla_pro, p.des_pro FROM productos p where p.cla_pro='"+clave+"'");
		while(rset.next()){
			desc=rset.getString("des_pro");
		}
		
	}
	
	if(sub.equals("Ingresar Descuento")){
		int tipo_en = 0, c1=0;
		String id_inv = "", det_pro = "";
		rset=stmt.executeQuery("select p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, i.cant, i.id_inv, o.des_ori, dp.det_pro, dp.cla_fin FROM usuarios us, unidades u, inventario i, detalle_productos dp, productos p, origen o where  us.cla_uni = u.cla_uni and u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro and dp.cla_pro = p.cla_pro AND dp.id_ori = o.id_ori and us.id_usu = '"+request.getParameter("id_usu")+"' and p.cla_pro='"+request.getParameter("txtf_clave2")+"' and dp.lot_pro='"+lot+"' and dp.cad_pro='"+df.format(df2.parse(cad))+"' and o.id_ori = '"+request.getParameter("ori")+"' and dp.cla_fin = '"+request.getParameter("cla_fin")+"'  ");
		while(rset.next()){
			tipo_en=1;
			id_inv=rset.getString("id_inv");
			det_pro=rset.getString("det_pro");
			c1=rset.getInt("cant");
		}
		//out.println(det_pro);
		if (Integer.parseInt(request.getParameter("txtf_cant"))>c1){
			//out.println("Mas de lo que se tiene");
			%>
            <script>alert("No se cuenta con el medicamento suficiente para dar de baja")</script>
            <%
		} else {
			int c3=c1-Integer.parseInt(request.getParameter("txtf_cant"));
			stmt.execute("update inventario set cant = '"+c3+"', web = '0' where id_inv = '"+id_inv+"'");
			stmt.execute("insert into kardex values ('0', '0', '"+det_pro+"', '"+c3+"', 'SALIDA POR AJUSTE', '-', NOW(), '"+request.getParameter("txta_razon")+"', '"+request.getParameter("id_usu")+"', '0')");
		}
	}
} catch (Exception e){
}
if (clave==null){
	clave="";
	desc="";
	lot="";
	cad="";
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.: SALIDA MANUAL :.</title>
<script language="javascript" src="list02.js"></script>
<script>
function checaRazon(){
	//obteniendo el valor que se puso en campo text del formulario
        miCampoTexto = document.form.txta_razon.value;
        //la condición
        if (miCampoTexto.length == 0) {
			alert("Ingrese la razón del ajuste");
            return false;
        }
        return true;
}
</script>
<link rel="stylesheet" href="mm_restaurant1.css" type="text/css" />
</head>

<body onLoad="foco_inicial();">
<table width="666" height="346" border="3" align="center" cellpadding="2" bgcolor="#FFFFFF">
  <tr>
  
    <td width="650"><form id="form" name="form" method="post" action="descarga_clave.jsp?id_usu=<%=request.getParameter("id_usu")%>">
      <table width="650" height="377" border="0" align="center" cellpadding="2">
        <tr>
          <td height="49" bgcolor="#FFFFFF" class="logo style1"><div align="center" class="logo style1"><img src="imagenes/nay_ima1.jpg" width="142" height="72" /></div></td>
          <td height="49" colspan="2" bgcolor="#FFFFFF" class="logo style1"><div align="center">Ajuste al Inventario<br />
            SALIDAS </div></td>
          <td height="49" bgcolor="#FFFFFF" class="logo style1"><img src="imagenes/ssn.jpg" width="156" height="65" /></td>
        </tr>
        <tr>
          <td height="14" colspan="4" bgcolor="#EC3237"><span class="style2"></span></td>
          </tr>
        <tr>
          <td width="114" height="20">Fecha:</td>
          <td width="90" class="bodyText"><label>
          <input name="txtf_date1" type="text" size="10" value="<%=df2.format(new Date())%>" onKeyPress="return handleEnter(this, event)" readonly/>
          </label></td>
          <td width="306"><a href="existencias.jsp?id_usu=<%=request.getParameter("id_usu")%>" target="_blank">Ver Existencias</a></td>
          <td width="114">&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left" class="Estilo6">Seleccione Origen  :</div>
          </div></td>
          <td class="style5"><span class="Estilo6">
            <select name="id_ori" class="Estilo6" onkeypress="return handleEnter(this, event)" onChange="put_cve()">
              <option selected="selected">--Origen--</option>
              <option value="1">SSN</option>
              <option value="2">SAVI</option>
            </select>
          </span></td>
          <td colspan="2" class="style5">
            <div align="left" class="Estilo6"></div></td>
          </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left" class="Estilo6">Ingrese Clave  :</div>
          </div></td>
          <td class="style5"><label><input name="txtf_clave" type="text" id="txtf_clave" size="15"/>
          </label></td>
          <td colspan="2" class="style5">
            <div align="left" class="Estilo6">
              <input type="submit" name="submit" value="Clave" />
          </div></td>
          </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left" class="Estilo6">Clave: </div>
          </div></td>
          <td colspan="2" class="style5"><label>
            <input name="txtf_clave2" type="text" id="txtf_clave2" onChange="mayNomm(this.form)" onKeyPress="return handleEnter(this, event)"  value="<%=clave%>" size="10" readonly/>
          </label></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left" class="Estilo6">Descripci&oacute;n:</div>
          </div></td>
          <td colspan="2" class="style5"><label>
            <textarea name="txtf_descrip" cols="50" id="txtf_descrip" onChange="mayApepm(this.form)" onKeyPress="return handleEnter(this, event)" readonly><%=desc%></textarea>
          </label></td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left"><span class="Estilo6">Lote: </span></div>
          </div></td>
          <td colspan="2" class="style5"><input name="txtf_lote" type="text" id="txtf_lote" onChange="mayApemm(this.form)" onKeyPress="return handleEnter(this, event)" value="<%=lot%>" size="10" readonly="readonly" />
          
        <select name="slct_lote" class="bodyText" onChange="setLot1(this.form);dimePropiedades(this.form);" onkeypress="return handleEnter(this, event)">
        <option>-- Lote --</option>
        <%
        try{
		sub=request.getParameter("submit");
		if(sub.equals("Clave")){
		clave=request.getParameter("txtf_clave");
		rset=stmt.executeQuery("select p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, i.cant, o.des_ori, dp.cla_fin FROM usuarios us, unidades u, inventario i, detalle_productos dp, productos p, origen o where  us.cla_uni = u.cla_uni and u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro and dp.cla_pro = p.cla_pro AND dp.id_ori = o.id_ori and us.id_usu = '"+request.getParameter("id_usu")+"' and p.cla_pro='"+clave+"' AND dp.id_ori = '"+request.getParameter("id_ori")+"'");
		while(rset.next()){
			out.println("<option value ='"+rset.getString("lot_pro")+"'>"+rset.getString("lot_pro")+"</option>");
			}
		}
		} catch (Exception e){
		}
        %>
      </select>
          
          </td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left"><span class="Estilo6">Caducidad: </span></div>
          </div></td>
          <td colspan="2" class="style5"><input name="txtf_cad" type="text" id="txtf_cad" onChange="mayApemm(this.form)" onKeyPress="return handleEnter(this, event)" value="<%=cad%>" size="10" readonly="readonly" />
            
      <select name="slct_cad" class="bodyText" onChange="setCad(this.form)" onkeypress="return handleEnter(this, event)">
        <option>-- Caducidad --</option>
        
        <%
        try{
		sub=request.getParameter("submit");
		if(sub.equals("Clave")){
		clave=request.getParameter("txtf_clave");
		rset=stmt.executeQuery("select p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, i.cant, o.des_ori FROM usuarios us, unidades u, inventario i, detalle_productos dp, productos p, origen o where  us.cla_uni = u.cla_uni and u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro and dp.cla_pro = p.cla_pro AND dp.id_ori = o.id_ori and us.id_usu = '"+request.getParameter("id_usu")+"' and p.cla_pro='"+clave+"'");
		while(rset.next()){
			out.println("<option  value ='"+df2.format(df.parse(rset.getString("cad_pro")))+"'>"+df2.format(df.parse(rset.getString("cad_pro")))+"</option>");
			}
		}
		} catch (Exception e){
		}
        %>
        
      </select>
      
          </td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left"><span class="Estilo6">Origen: </span></div>
          </div></td>
          <td colspan="2" class="style5">
          	<select name="ori">
            	<%
				try{
				sub=request.getParameter("submit");
				clave=request.getParameter("txtf_clave");
				rset=stmt.executeQuery("select id_ori, des_ori from origen");
				while(rset.next()){
					out.println("<option value ='"+rset.getString("id_ori")+"'>"+rset.getString("des_ori")+"</option>");
					}
				} catch (Exception e){
				}
				%>
            </select>
            &nbsp;&nbsp;&nbsp;&nbsp;
            Finanicamiento:
            <select name="cla_fin">
            	<%
				try{
				sub=request.getParameter("submit");
				clave=request.getParameter("txtf_clave");
				rset=stmt.executeQuery("select cla_fin, des_fin from financiamientos");
				while(rset.next()){
					out.println("<option value ='"+rset.getString("cla_fin")+"'>"+rset.getString("des_fin")+"</option>");
					}
				} catch (Exception e){
				}
				%>
            </select> 
          </td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20"><div align="right">
            <div align="left"><span class="Estilo6">Existencia: </span></div>
          </div></td>
          <td colspan="2" class="style5"><span class="style5"><label></label>
              </span>            <label>
              <%
				try{
				sub=request.getParameter("submit");
				cant="0";
				if(sub.equals("Checar Existencias")){
					clave=request.getParameter("txtf_clave");
					
					rset=stmt.executeQuery("select p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, i.cant, o.des_ori FROM usuarios us, unidades u, inventario i, detalle_productos dp, productos p, origen o where  us.cla_uni = u.cla_uni and u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro and dp.cla_pro = p.cla_pro AND dp.id_ori = o.id_ori and us.id_usu = '"+request.getParameter("id_usu")+"' and p.cla_pro='"+request.getParameter("txtf_clave2")+"' and dp.lot_pro='"+lot+"' and dp.cad_pro='"+df.format(df2.parse(cad))+"' and o.id_ori = '"+request.getParameter("ori")+"' and dp.cla_fin = '"+request.getParameter("cla_fin")+"' ");
					while(rset.next()){
						cant=rset.getString("cant");
						}
					}
				} catch (Exception e){
				}
			  %>
          <input name="txtf_exist" type="text" id="txtf_exist" onChange="mayApemm(this.form)" onKeyPress="return handleEnter(this, event)" value="<%=cant%>" size="10" readonly/>
            </label>
            <input type="submit" name="submit" value="Checar Existencias" />
            </td>
          <td>&nbsp;</td>
        </tr>
        
        <tr>
          <td height="20"><div align="left"><span class="Estilo6">Ingrese Cantidad ( - ): </span></div></td>
          <td class="style5"><span class="style5"><label></label>
              <input name="txtf_cant" type="text" id="txtf_cant"  value="0" onKeyPress="return handleEnter(this, event)" onClick="putClear();"  size="10"/>
          </span></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
  <tr>
          <td height="20"><div align="left"><span class="Estilo6">Razón de Ajuste: </span></div></td>
          <td colspan="2" class="style5"><span class="style5"><label><textarea name="txta_razon" cols="50" id="txta_razon" onChange="mayApepm(this.form)" onKeyPress="return handleEnter(this, event)"></textarea></label>
          </span></td>
          <td>&nbsp;</td>
        </tr>     
        
        <tr>
          <td height="20">&nbsp;</td>
          <td colspan="2"><div align="center">
            <input type="submit" name="submit" value="Ingresar Descuento" onClick="checaRazon();" />&nbsp;&nbsp;<!--input type="submit" name="Submit" value="Limpiar Claves" /-->
          &nbsp;Cerrar Aplicación <button name="boton" type="button" class="style7" onClick="CloseWin()" /><img src="imagenes/borr.jpg" /></button></div></div></td>
          <td>&nbsp;</td>
        </tr>
		<%
		  try{
		  sub=request.getParameter("submit");
		  cant="0";
		  if(sub.equals("Ingresar Descuento")){
			  clave=request.getParameter("txtf_clave");
			  
			  rset=stmt.executeQuery("select p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, i.cant, o.des_ori FROM usuarios us, unidades u, inventario i, detalle_productos dp, productos p, origen o where  us.cla_uni = u.cla_uni and u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro and dp.cla_pro = p.cla_pro AND dp.id_ori = o.id_ori and us.id_usu = '"+request.getParameter("id_usu")+"' and p.cla_pro='"+request.getParameter("txtf_clave2")+"' and dp.lot_pro='"+lot+"' and dp.cad_pro='"+df.format(df2.parse(cad))+"' and o.id_ori = '"+request.getParameter("ori")+"' and dp.cla_fin = '"+request.getParameter("cla_fin")+"' ");
			  while(rset.next()){
				  cant=rset.getString("cant");
				  
				  %>
                <tr>
                  <td height="20">Clave&nbsp;:&nbsp;<span class="Estilo7"><%=rset.getString("cla_pro")%></span></td>
                  <td colspan="3">Descripci&oacute;n&nbsp;:<span class="Estilo7"><%=rset.getString("des_pro")%></span></td>
                </tr>
                <tr>
                  <td height="20">Origen&nbsp;:&nbsp;<span class="Estilo7"><%=rset.getString("des_ori")%></span></td>
                  <td colspan="2">Total Piezas&nbsp;:&nbsp;&nbsp;<span class="Estilo7"><%=rset.getString("cant")%></span></td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td height="20">Lote: <%=rset.getString("lot_pro")%></td>
                  <td colspan="2">Caducidad: <%=df2.format(df.parse(rset.getString("cad_pro")))%></td>
                  <td>&nbsp;</td>
                </tr>
                  <%
				  
				  }
			  }
		  } catch (Exception e){
		  }
		%>
      </table>
          </form>
    </td>
  </tr>
</table>
<%
con.close();
%>
</body>
</html>
