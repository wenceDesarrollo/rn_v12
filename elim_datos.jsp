<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
<%java.text.DateFormat df4 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("HH:mm:ss"); %>
<%
//Conexión a la BDD vía JDBC	
Class.forName("org.gjt.mm.mysql.Driver");

Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset = null;
Statement stmt2 = con.createStatement();
ResultSet rset2 = null;
// fin conexión -----------------------------------	
String des_uni = "", fol_rec = "", fec_car="", hor_car="", cla_uni = "", nom_pac = "", sexo="", num_afi="", des_fin ="", des_ori ="", nombre="", des_tip="", fec_nac="", cedula="", nom_med = "";
String sub="";

try{
	if (request.getParameter("submit").equals("Por Folio")){
		rset = stmt.executeQuery("SELECT t.des_tip, u.des_uni, r.fol_rec, bi.fec_carga, u.cla_uni, pa.nom_pac, pa.sexo, pa.num_afi, bi.fec_carga, f.des_fin, o.des_ori, p.cla_pro, p.des_pro, DP.lot_pro, dp.cad_pro, us.nombre, me.nom_med, pa.fec_nac, me.cedula FROM UNIDADES U, municipios M, usuarios US, receta R, detreceta DR, detalle_productos DP, productos P, origen O, pacientes pa, bitacora bi, financiamientos f, tipo_receta t, medicos me where  m.cla_mun = u.cla_mun AND u.cla_uni = US.cla_uni and us.id_usu = r.id_usu AND r.id_rec = dr.id_rec and dr.det_pro = DP.det_pro AND dp.cla_pro = p.cla_pro AND DP.id_ori = o.id_ori and r.num_afi = pa.num_afi AND r.id_rec = bi.id_rec AND r.id_tip = t.id_tip and dp.cla_fin = f.cla_fin AND r.fol_rec = '"+request.getParameter("fol_rec")+"' and u.cla_uni = '"+request.getParameter("cla_uni")+"' and r.baja != '1' and r.cedula = me.cedula and r.id_tip='1' group by r.fol_rec;");
		
		while (rset.next()){
			des_uni=rset.getString("des_uni");
			fol_rec=rset.getString("fol_rec");
			fec_car=df2.format(df.parse(rset.getString("fec_carga")));
			hor_car=df3.format(df.parse(rset.getString("fec_carga")));
			cla_uni=rset.getString("cla_uni");
			nom_pac=rset.getString("nom_pac");
			sexo=rset.getString("sexo");
			num_afi=rset.getString("num_afi");
			des_ori=rset.getString("des_ori");
			nombre=rset.getString("nombre");
			des_tip=rset.getString("des_tip");
			fec_nac = rset.getString("fec_nac");
			nom_med = rset.getString("nom_med");
			fec_nac = rset.getString("fec_nac");
			cedula = rset.getString("cedula");
		}
	}
} catch(Exception e){
}

try{
	if (request.getParameter("submit").equals("eliminar")){
		rset = stmt.executeQuery("SELECT dp.det_pro, i.id_inv, dr.cant_sur, us.id_usu, r.id_rec, dr.fol_det FROM UNIDADES U, municipios M, usuarios US, receta R, detreceta DR, detalle_productos DP, productos P, origen O, pacientes pa, bitacora bi, financiamientos f, tipo_receta t, medicos me, inventario i where  m.cla_mun = u.cla_mun AND u.cla_uni = US.cla_uni and us.id_usu = r.id_usu AND r.id_rec = dr.id_rec and dr.det_pro = DP.det_pro AND dp.cla_pro = p.cla_pro AND DP.id_ori = o.id_ori and r.num_afi = pa.num_afi AND r.id_rec = bi.id_rec AND r.id_tip = t.id_tip and dp.cla_fin = f.cla_fin AND r.fol_rec = '"+request.getParameter("fol_rec")+"' and u.cla_uni = '"+request.getParameter("cla_uni")+"' and r.cedula = me.cedula and i.cla_uni = u.cla_uni and i.det_pro = dp.det_pro and r.baja != '1' and r.id_tip='1'");
		
		while (rset.next()){
			int cant_i=0, n_cant=0;
			//out.println("select cant from inventario where id_inv = '"+rset.getString("id_inv")+"'");
			rset2 = stmt2.executeQuery("select cant from inventario where id_inv = '"+rset.getString("id_inv")+"'");
			while(rset2.next()){
				cant_i = Integer.parseInt(rset2.getString("cant"));
			}
			n_cant=cant_i+Integer.parseInt(rset.getString("cant_sur"));
			//out.println("<br>");
			stmt2.execute("update inventario set cant = '"+n_cant+"', web = '0' where id_inv = '"+rset.getString("id_inv")+"'");
			//out.println("<br>");
			stmt2.execute("insert into kardex values ('0', '"+rset.getString("id_rec")+"', '"+rset.getString("det_pro")+"', '"+rset.getString("cant_sur")+"', 'REINTEGRO POR ELIMINACION DE RECETA', '-', NOW(), 'REINTEGRO POR ELIMINACION DE RECETA', '"+rset.getString("id_usu")+"', '0')");
			//stmt2.execute("update inventario set cant = '"+n_cant+"', web = '0' where id_inv = '"+rset.getString("id_inv")+"'");
			//out.println("<br>");
			stmt2.execute("update receta set baja = '1', web = '0' where id_rec = '"+rset.getString("id_rec")+"'");
			//out.println("<br>");
			stmt2.execute("update detreceta set baja = '1', cant_sur = '0', can_sol = '0', web = '0' where fol_det = '"+rset.getString("fol_det")+"'");
			//out.println("<br>");
		}
		%>
        <script>alert("Folio eliminado")</script>
        <%
	}
} catch(Exception e){
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.: Eliminar Folio :.</title>
<script language="javascript" src="list02.js"></script>

<script type="text/javascript">
function validar(e) { // 1
    tecla = (document.all) ? e.keyCode : e.which; // 2
    if (tecla==8) return true; // 3
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
</script>

<style type="text/css">
<!--
.style2 {
	font-size: 10px;
	font-family: Arial, Helvetica, sans-serif;
}
.style4 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
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
doce {
	font-size: 12px;
}
-->
</style>
</head>

<body>
<script src="scw.js" type="text/javascript"> </script>
<form name="form" method="post" action="elim_datos.jsp?cla_uni=<%=request.getParameter("cla_uni")%>&id_usu=<%=request.getParameter("id_usu")%>">
<a href="menu_mod_rf.jsp?cla_uni=<%=request.getParameter("cla_uni")%>&id_usu=<%=request.getParameter("id_usu")%>" class="style2">REGRESAR A MENÚ</a>
<table width="893" height="427" border="3" align="center" cellpadding="2">
  <tr>
    <td width="877" height="114"><table width="864" border="0" align="center" cellpadding="2">
      <tr>
        <td width="201" height="59"><div align="center"><img src="imagenes/nay_ima1.jpg" width="203" height="78" />&nbsp;</div></td>
        <td width="417"><div align="center" class="style7">SERVICIOS DE SALUD DE NAYARIT<br />
        RECETA FARMACIA<br />
        ELIMINAR FOLIO**</div>
         </td>
        <td width="226"><div align="center"><img src="imagenes/ssn.jpg" width="219" height="89" />&nbsp;</div>
          <!--input name="Submit"  type="reset" class="bodyText" value="Borrar Datos" /--></td>
      </tr>
    </table>
      <table width="877" height="59" border="0" align="center" cellpadding="2">
        <tr>
          <td width="440" height="55" class="style2">
            Ingrese No. Folio:
          <input name="fol_rec" type="text" class="style13"  value="<%=fol_rec%>" size="15" onKeyPress="return handleEnter(this, event)"/>
          <label for="select"></label>
          <select name="slct_fol" id="slct_fol" onChange="putFolio();">
            <option>-- Folios --</option>
         
                <option value=""></option>
       
          </select>
          &nbsp;<input name="submit" type="submit" class="subHeader" value="Por Folio"/>
          <input name="act" type="submit" value="ACT" /></td>
          <td width="167"><table width="167" height="0%" border="0" cellpadding="2">
            <tr>
              <td width="225" height="100%" class="style2">HORA:
                <input name="reloj" type="text" class="style13" value="<%=hor_car%>" onKeyPress="return handleEnter(this, event)" size="15" readonly ></td>
            </tr>
          </table></td>
          <td width="250" align="center" class="style2">
            FECHA:
                  <input name="txtf_t1" type="text" class="style13" id='txtf_t1' onKeyPress="return handleEnter(this, event)"  value="<%=fec_car%>" size="10" readonly/>&nbsp;&nbsp;
          </td>
        </tr>
    </table>    </td>
  </tr>
        
        <tr>
          <td height="2" colspan="3" class="style4"><div id="item7" style="display:none" align="justify" ><span class="style2">
            <input name="txtf_date1" type="text" size="20" value="" onKeyPress="return handleEnter(this, event)" readonly/>
          </span></div></td>
        </tr>
        <tr>
          <td height="41" colspan="3" class="style4"><table width="874" border="0" align="center" cellpadding="2">
            <tr>
              <td width="685" class="style2">FOLIO:<input name="txtf_f" type="text" class="style13"  onKeyPress="return handleEnter(this, event)"  value="<%=fol_rec%>" size="10" readonly colspan="3"/>&nbsp;&nbsp;UNIDAD DE SALUD
              <input type="text" name="txtf_unidadmed" size="55" colspan="3" class="style13"  value="<%=des_uni%>" readonly onKeyPress="return handleEnter(this, event)"/></td>
              <td width="175"><table width="170" border="0" align="left" cellpadding="2">
                <tr>
                  <td width="162" align="center"><div align="center" class="style2">
                  </div></td>
                </tr>
              </table></td>
            </tr>
            
          </table></td>
        </tr>
  <tr>
          <td height="62" colspan="3" class="style4"><table width="859" border="0" align="center" cellpadding="2">
            <tr>
              <td width="724" height="52" class="style2">NOMBRE DEL PACIENTE:
                <label> </label>
                <span class="style5">
                <label> </label>
                <input name="txtf_paciente" type="text" class="style13"  onKeyPress="return handleEnter(this, event)" value="<%=nom_pac%>" size="55" readonly/>
                </span>
                <label>
                 Sexo:
                <input name="txtf_sexo" type="text" class="style13"  onKeyPress="return handleEnter(this, event)" value="<%=sexo%>" size="5" readonly/>
                EDAD:
                <input name="txtf_edad" type="text" class="style13"  onkeypress="return handleEnter(this, event)" value="<%=fec_nac%>" size="10" readonly/>
                <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NOMBRE</span><span class="style2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;APELLIDO PATERNO &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;APELLIDO MATERNO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></label></td>
              <td width="15">&nbsp;</td>
            </tr>
            <tr>
              <td height="52" class="style2">No. DE FOLIO S.P.<span class="style11">
                <input name="txtf_foliosp" type="text" class="style13" onKeyPress="return handleEnter(this, event)" value="<%=num_afi%>" size="20" readonly/>
              </span>
              NOMBRE M&Eacute;DICO:
                <input name="txtf_nomed" type="text" class="style13"  onKeyPress="return handleEnter(this, event)" value="<%=nom_med%>" size="35" readonly />
              <span class="style2">C&Eacute;DULA: 
              <input name="txtf_cedu" type="text" class="style13" id="a"  onKeyPress="return handleEnter(this, event)" value="<%=cedula%>" size="10" readonly/> 
              </span>
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
    </table>          </td>
  </tr>
     <tr>
     	<td>
        <table>
        <tr class="letras">
              <td colspan="9" class="style11"><hr /></td>
            </tr>
            <tr class="letras">
              <td class="style11"><span class="style2">CLAVE</span></td>
              <td width="213" class="style11"><span class="style2">DESCRIPCI&Oacute;N</span></td>
              <td width="67" class="style11"><span class="style2">LOTE</span></td>
              <td class="style11"><span class="style2">CADUCIDAD</span></td>
              <td colspan="1" class="style11"><span class="style2">CANT. SOL</span></td>
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
				if (request.getParameter("submit").equals("Por Folio")){
					rset = stmt.executeQuery("SELECT u.des_uni, r.fol_rec, bi.fec_carga, u.cla_uni, pa.nom_pac, pa.sexo, pa.num_afi, bi.fec_carga, f.des_fin, o.des_ori, p.cla_pro, p.des_pro, DP.lot_pro, dp.cad_pro, us.nombre, dr.can_sol, dr.cant_sur, dr.status FROM UNIDADES U, municipios M, usuarios US, receta R, detreceta DR, detalle_productos DP, productos P, origen O, pacientes pa, bitacora bi, financiamientos f where  m.cla_mun = u.cla_mun AND u.cla_uni = US.cla_uni and us.id_usu = r.id_usu AND r.id_rec = dr.id_rec and dr.det_pro = DP.det_pro AND dp.cla_pro = p.cla_pro AND DP.id_ori = o.id_ori and r.num_afi = pa.num_afi AND r.id_rec = bi.id_rec AND dp.cla_fin = f.cla_fin AND r.fol_rec = '"+request.getParameter("fol_rec")+"' and u.cla_uni = '"+request.getParameter("cla_uni")+"' and r.baja != '1' and dr.baja = '0' and r.id_tip='1' ;");
	
					while (rset.next()){
					String des_pro=rset.getString("des_pro");
					String cla_pro=rset.getString("cla_pro");
					String can_sol=rset.getString("can_sol");
					String can_sur=rset.getString("cant_sur");
					des_ori=rset.getString("des_ori");
					String lot_pro=rset.getString("lot_pro");
					String cad_pro=df2.format(df4.parse(rset.getString("cad_pro")));
					String status = rset.getString("status");
			%>
            <tr>
              <td class="style11" align="center"><%=cla_pro%></td>
              <td class="style11" align="center"><%=des_pro%></td>
              <td class="style11" align="center"><%=lot_pro%></td>
              <td class="style11" align="center"><%=cad_pro%></td>
              <td class="style11" align="center"><%=can_sol%></td>
              <td class="style11" align="center"><%=can_sur%></td>
              <td class="style11" align="center"><%=status%></td>
			  <td class="style11"><%=des_ori%></td>
              <td class="style11">&nbsp;</td>
            </tr>
            <%
					}
				}
			}catch (Exception e) {
			}
			%>
    <tr class="letras">
              <td colspan="9" class="style11"><hr /></td>
            </tr>
        </table>
        </td>
     </tr>  
        
        <tr>
          <td height="25" colspan="3" align="center">
            
          <a onClick="return confirm('Seguro que desea eliminarlo?')" href="elim_datos.jsp?fol_rec=<%=fol_rec%>&cla_uni=<%=request.getParameter("cla_uni")%>&id_usu=<%=request.getParameter("id_usu")%>&submit=eliminar">Eliminar Folio</a></td>
  </tr>
        </tr>
        <tr>
         <td height="40" colspan="3" class="style4"><div align="right" class="style12">
           <div align="center"><img src="imagenes/ima_main.jpg" width="517" height="77" /></div>
         </div></td>
  </tr>
</table>


</body>
</html>
<%
con.close();
%>