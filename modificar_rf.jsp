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
String des_uni="";
rset = stmt.executeQuery("select des_uni from unidades where cla_uni = '"+request.getParameter("cla_uni")+"'");
while(rset.next()){
	des_uni = rset.getString("des_uni");
}

try{
	if (request.getParameter("submit").equals("Modificar")){
	    rset = stmt.executeQuery("SELECT u.des_uni, r.fol_rec, bi.fec_carga, u.cla_uni, pa.nom_pac, pa.sexo, pa.num_afi, bi.fec_carga, f.des_fin, o.des_ori, p.cla_pro, p.des_pro, DP.lot_pro, dp.cad_pro, us.nombre, dr.can_sol, dr.cant_sur, dr.status, dr.fol_det, i.id_inv, i.cant, dp.det_pro FROM UNIDADES U, municipios M, usuarios US, receta R, detreceta DR, detalle_productos DP, productos P, origen O, pacientes pa, bitacora bi, financiamientos f, inventario i where  m.cla_mun = u.cla_mun AND u.cla_uni = US.cla_uni and us.id_usu = r.id_usu AND r.id_rec = dr.id_rec and dr.det_pro = DP.det_pro AND dp.cla_pro = p.cla_pro AND DP.id_ori = o.id_ori and r.num_afi = pa.num_afi AND r.id_rec = bi.id_rec AND dp.cla_fin = f.cla_fin AND dr.fol_det = '"+request.getParameter("fol_det")+"' and r.baja != '1' and u.cla_uni = '"+request.getParameter("cla_uni")+"' and i.cla_uni = u.cla_uni and dp.det_pro = i.det_pro;");
  
		while (rset.next()){
			String can_sur=rset.getString("cant_sur");
			//out.println(can_sur);
			int canti =Integer.parseInt(rset.getString("cant"));
			int cant = Integer.parseInt(request.getParameter("txtf_sur1"))-Integer.parseInt(can_sur);
			//out.println(cant);
			if (cant>=0){
				//Cantidad anterior menor o igual que cantidad nueva
				int n_cant=canti - cant;
				//out.println("<br>Detalle de producto : "+rset.getString("dp.det_pro"));
				//out.println("<br>Inventario : "+rset.getString("i.id_inv")+" "+rset.getString("i.cant")+"--->"+n_cant);
				if (n_cant<0){
					%>
                    <script>alert("Este producto no cuenta con las piezas requeridas, agregue un nuevo lote")</script>
                    <%
				}
				else{
					stmt2.execute("update detreceta set cant_sur = '"+request.getParameter("txtf_sur1")+"', can_sol = '"+request.getParameter("txtf_sol1")+"', web = '0' where fol_det = '"+request.getParameter("fol_det")+"'");
					stmt2.execute("update inventario set cant = '"+n_cant+"', web = '0' where id_inv = '"+rset.getString("id_inv")+"' ");
				}
				
			} else{
				//Cantidad anterior mayor que cantidad nueva
				int n_cant=canti - cant;
				stmt2.execute("update detreceta set cant_sur = '"+request.getParameter("txtf_sur1")+"', can_sol = '"+request.getParameter("txtf_sol1")+"', web = '0' where fol_det = '"+request.getParameter("fol_det")+"'");
				stmt2.execute("update inventario set cant = '"+n_cant+"', web = '0' where id_inv = '"+rset.getString("id_inv")+"' ");
				
			}
		}
	}
} catch(Exception e){
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.:Receta Farmacia MODIFICACION:.</title>
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
}
.style5 {font-size: 14px}
.style6 {
	font-size: 12px;
	font-weight: bold;
}
.style7 {
	font-size: 16px;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.style11 {font-size: 12px}
-->
</style>
</head>

<body>
<form name="form" method="post" action="modificar_rf.jsp?fol_det=<%=request.getParameter("fol_det")%>&fol_rec=<%=request.getParameter("fol_rec")%>&cla_uni=<%=request.getParameter("cla_uni")%>&id_usu=<%=request.getParameter("id_usu")%>">

<table width="885" height="339" border="3" align="center" cellpadding="2">
  <tr>
    <td width="725" height="137"><table width="710" border="0" align="center" cellpadding="2">
      <tr>
        <td width="114" height="82"><img src="imagenes/nay_ima1.jpg" width="142" height="72" /></td>
        <td width="339"><div align="center"><span class="style7">SERVICIO DE SALUD DE NAYARIT<br />
        RECETA MEDICA<br />MODIFICAR SOL Y SUR </span></div></td>
        <td width="225" align="center"><img src="imagenes/ssn.jpg" width="162" height="78" /></td>
      </tr>
    </table>
      <table width="710" height="45" border="0" align="center" cellpadding="2">
        <tr>
          <td width="284" height="41">
            <table width="270" height="0%" border="0" cellpadding="2">
              <tr>
                <td width="221" height="100%" class="style2">FECHA:
                    
                
                  <span class="style2">
                  <label>                  </label>
                  <input name="txtf_date1" type="text" size="15" value="<%=df2.format(new Date())%>"  onKeyPress="return handleEnter(this, event)" readonly/></td>
              </tr>
            </table>          </td>
          <td width="250"><table width="167" height="0%" border="0" cellpadding="2">
            <tr>
              <td width="225" height="100%" class="style2">&nbsp;</td>
            </tr>
          </table>            </td>
          <td width="172" align="center" class="style2">No. Folio
            <input type="text" name="txtf_foliore" size="20"  value="<%=request.getParameter("fol_rec")%>" readonly/>
            <table width="152" height="0%" border="0" align="right" cellpadding="2">
          </table></td>
        </tr>
    </table>    </td>
  </tr>
        <tr>
          <td height="71" colspan="3" class="style4"><table width="710" border="0" align="center" cellpadding="2">
            <tr>
              <td width="533" class="style2">UNIDAD DE SALUD</td>
              <td width="170"><table width="170" border="0" align="left" cellpadding="2">
                <tr>
                  <td width="162" align="center"><div align="center" class="style2">
                  </div></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td colspan="2"><input type="text" name="txtf_unidadmed" size="55" colspan="3" class="style4"  value="<%=des_uni%>" readonly/></td>
            </tr>
          </table></td>
        </tr>
        
        
        
        <tr>
          <td height="123" colspan="3" class="style4"><table width="863" border="0" align="center" cellpadding="2">
            
            
            <tr>
              <td width="49" class="style11"><label> <br />
              </label></td>
              <td width="182" class="style11"><label></label></td>
              <td width="57" class="style11">&nbsp;</td>
              <td width="92" class="style11"><label></label></td>
              <td width="79" class="style11">&nbsp;</td>
              <td width="71" class="style11">&nbsp;</td>
              <td width="66" class="style11">&nbsp;</td>
              <td width="72" class="style11">&nbsp;</td>
              <td width="139" class="style11">&nbsp;</td>
            </tr>
            <tr>
              <td width="49" class="style11"><span class="style2">CLAVE </span></td>
              <td align="center"><span class="style2">DESCRIPCI&Oacute;N</span></td>
              <td align="center"><span class="style2">LOTE</span></td>
              <td align="center"><span class="style2">CADUCIDAD</span></td>
              <td align="center" class="style11"><span class="style2">CANT. SOL</span></td>
              <td class="style11"><span class="style2">CANT. A MOD</span></td>
              <td class="style11"><span class="style2">CANT. SUR</span></td>
              <td class="style11"><span class="style2">CANT. A MOD</span></td>
              <td class="style11">&nbsp;</td>
            </tr>
			<%
			try{
				
					rset = stmt.executeQuery("SELECT u.des_uni, r.fol_rec, bi.fec_carga, u.cla_uni, pa.nom_pac, pa.sexo, pa.num_afi, bi.fec_carga, f.des_fin, o.des_ori, p.cla_pro, p.des_pro, DP.lot_pro, dp.cad_pro, us.nombre, dr.can_sol, dr.cant_sur, dr.status, dr.fol_det FROM UNIDADES U, municipios M, usuarios US, receta R, detreceta DR, detalle_productos DP, productos P, origen O, pacientes pa, bitacora bi, financiamientos f where  m.cla_mun = u.cla_mun AND u.cla_uni = US.cla_uni and us.id_usu = r.id_usu AND r.id_rec = dr.id_rec and dr.det_pro = DP.det_pro AND dp.cla_pro = p.cla_pro AND DP.id_ori = o.id_ori and r.num_afi = pa.num_afi AND r.id_rec = bi.id_rec AND dp.cla_fin = f.cla_fin AND dr.fol_det = '"+request.getParameter("fol_det")+"' and r.baja != '1' and u.cla_uni = '"+request.getParameter("cla_uni")+"';");
	
					while (rset.next()){
					String des_pro=rset.getString("des_pro");
					String cla_pro=rset.getString("cla_pro");
					String can_sol=rset.getString("can_sol");
					String can_sur=rset.getString("cant_sur");
					String des_ori=rset.getString("des_ori");
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
              <td class="style11" align="center"><input type="text" name="txtf_sol1" size="5"  onkeypress="return validar(event)" value="<%=can_sol%>"/></td>
              <td align="center" class="style11"><%=can_sur%></td>
              <td class="style11" align="center"><input type="text" name="txtf_sur1" size="5"  onchange="setSur1(this.form)" onKeyPress="return validar(event)" value="<%=can_sur%>"/></td>
              <td class="style11"><input name="submit" type="submit" class="but" value="Modificar" onChange="setSur1(this.form)" onClick="return verificaN1(document.forms.form)"/>
              &nbsp; <a href="modi2_receta.jsp?cla_uni=<%=request.getParameter("cla_uni")%>&id_usu=<%=request.getParameter("id_usu")%>">Regresar</a></td>
            </tr>
            <%
			}
		}catch (Exception e) {
		}
		%>
		</table></td>
        </tr>
</table>


</body>
</html>
<%
con.close();
%>