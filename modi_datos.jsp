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
		rset = stmt.executeQuery("SELECT r.id_rec, t.des_tip, u.des_uni, r.fol_rec, bi.fec_carga, u.cla_uni, pa.nom_pac, pa.sexo, pa.num_afi, bi.fec_carga, f.des_fin, o.des_ori, p.cla_pro, p.des_pro, DP.lot_pro, dp.cad_pro, us.nombre, me.nom_med, pa.fec_nac, me.cedula FROM UNIDADES U, municipios M, usuarios US, receta R, detreceta DR, detalle_productos DP, productos P, origen O, pacientes pa, bitacora bi, financiamientos f, tipo_receta t, medicos me where  m.cla_mun = u.cla_mun AND u.cla_uni = US.cla_uni and us.id_usu = r.id_usu AND r.id_rec = dr.id_rec and dr.det_pro = DP.det_pro AND dp.cla_pro = p.cla_pro AND DP.id_ori = o.id_ori and r.num_afi = pa.num_afi AND r.id_rec = bi.id_rec AND r.id_tip = t.id_tip and dp.cla_fin = f.cla_fin AND r.fol_rec = '"+request.getParameter("fol_rec")+"' and r.id_tip='1' and u.cla_uni = '"+request.getParameter("cla_uni")+"' and r.baja != '1' and r.cedula = me.cedula group by r.fol_rec;");
		
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
	
	if (request.getParameter("submit").equals("Actualizar Datos")){
		rset = stmt.executeQuery("SELECT r.id_rec, t.des_tip, u.des_uni, r.fol_rec, bi.fec_carga, u.cla_uni, pa.nom_pac, pa.sexo, pa.num_afi, bi.fec_carga, f.des_fin, o.des_ori, p.cla_pro, p.des_pro, DP.lot_pro, dp.cad_pro, us.nombre, me.nom_med, pa.fec_nac, me.cedula FROM UNIDADES U, municipios M, usuarios US, receta R, detreceta DR, detalle_productos DP, productos P, origen O, pacientes pa, bitacora bi, financiamientos f, tipo_receta t, medicos me where  m.cla_mun = u.cla_mun AND u.cla_uni = US.cla_uni and us.id_usu = r.id_usu AND r.id_rec = dr.id_rec and dr.det_pro = DP.det_pro AND dp.cla_pro = p.cla_pro AND DP.id_ori = o.id_ori and r.num_afi = pa.num_afi AND r.id_rec = bi.id_rec AND r.id_tip = t.id_tip and dp.cla_fin = f.cla_fin AND r.fol_rec = '"+request.getParameter("fol_rec")+"' and r.id_tip='1' and u.cla_uni = '"+request.getParameter("cla_uni")+"' and r.baja != '1' and r.cedula = me.cedula group by r.fol_rec;");
		
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
			
			stmt2.execute("update receta set num_afi = '"+request.getParameter("txtf_foliosp")+"' where id_rec = '"+rset.getString("id_rec")+"' ");
			
			stmt2.execute("update receta set fol_rec = '"+request.getParameter("txtf_f")+"' where id_rec = '"+rset.getString("id_rec")+"' ");
			
			stmt2.execute("update receta set cedula = '"+request.getParameter("txtf_cedu")+"' where id_rec = '"+rset.getString("id_rec")+"' ");
			
			stmt2.execute("update bitacora set fec_carga = '"+df4.format(df2.parse(request.getParameter("txtf_t1")))+" "+hor_car+"' where id_rec = '"+rset.getString("id_rec")+"' ");
		}
		rset = stmt.executeQuery("SELECT r.id_rec, t.des_tip, u.des_uni, r.fol_rec, bi.fec_carga, u.cla_uni, pa.nom_pac, pa.sexo, pa.num_afi, bi.fec_carga, f.des_fin, o.des_ori, p.cla_pro, p.des_pro, DP.lot_pro, dp.cad_pro, us.nombre, me.nom_med, pa.fec_nac, me.cedula FROM UNIDADES U, municipios M, usuarios US, receta R, detreceta DR, detalle_productos DP, productos P, origen O, pacientes pa, bitacora bi, financiamientos f, tipo_receta t, medicos me where  m.cla_mun = u.cla_mun AND u.cla_uni = US.cla_uni and us.id_usu = r.id_usu AND r.id_rec = dr.id_rec and dr.det_pro = DP.det_pro AND dp.cla_pro = p.cla_pro AND DP.id_ori = o.id_ori and r.num_afi = pa.num_afi AND r.id_rec = bi.id_rec AND r.id_tip = t.id_tip and dp.cla_fin = f.cla_fin AND r.fol_rec = '"+request.getParameter("fol_rec")+"' and r.id_tip='1' and u.cla_uni = '"+request.getParameter("cla_uni")+"' and r.baja != '1' and r.cedula = me.cedula group by r.fol_rec;");
		
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



%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.: Modificar Receta Datos :.</title>
<script language="javascript" src="list02.js"></script>
<script language="javascript" src="scw.js"></script>

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

<form name="form" method="post" action="modi_datos.jsp?cla_uni=<%=request.getParameter("cla_uni")%>&id_usu=<%=request.getParameter("id_usu")%>">
<a href="menu_mod_rf.jsp?cla_uni=<%=request.getParameter("cla_uni")%>&id_usu=<%=request.getParameter("id_usu")%>">REGRESAR A MENÚ</a>
<table width="893" height="427" border="3" align="center" cellpadding="2">
  <tr>
    <td width="877" height="114"><table width="864" border="0" align="center" cellpadding="2">
      <tr>
        <td width="201" height="59"><div align="center"><img src="imagenes/nay_ima1.jpg" width="203" height="78" />&nbsp;</div></td>
        <td width="417"><div align="center" class="style7">SERVICIOS DE SALUD DE NAYARIT<br />
        RECETA FARMACIA</div>
         </td>
        <td width="226"><div align="center"><img src="imagenes/ssn.jpg" width="219" height="89" />&nbsp;</div>
          <!--input name="Submit"  type="reset" class="bodyText" value="Borrar Datos" /--></td>
      </tr>
    </table>
      <table width="877" height="59" border="0" align="center" cellpadding="2">
        <tr>
          <td width="440" height="55" class="style2">
            Ingrese No. Folio:
          <input name="fol_rec" type="text" class="style13" onKeyPress="return handleEnter(this, event)"  value="<%=fol_rec%>" size="15" />
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
                <input name="reloj" type="text" class="style13" onKeyPress="return handleEnter(this, event)" value="<%=hor_car%>" size="15" readonly ></td>
            </tr>
          </table></td>
          <td width="250" align="center" class="style2">
            FECHA:
                  <input name="txtf_t1" type="text" class="style13" id='txtf_t1' onKeyPress="return handleEnter(this, event)"  value="<%=fec_car%>" size="10" readonly/> &nbsp;&nbsp;                 <img src="imagenes/cal.jpg" width="26" height="27" border="0" onClick="scwShow(scwID('txtf_t1'), event)" />
                  &nbsp;&nbsp;</td>
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
              <td width="685" class="style2">FOLIO:<input type="text" name="txtf_f" size="10" colspan="3" class="style13"  value="<%=fol_rec%>"  onKeyPress="return handleEnter(this, event)"/>&nbsp;&nbsp;UNIDAD DE SALUD
              <input name="txtf_unidadmed" type="text" class="style13" onKeyPress="return handleEnter(this, event)"  value="<%=des_uni%>" size="55" readonly colspan="3"/></td>
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
                <input name="txtf_paciente" type="text" class="style13"  onKeyPress="return handleEnter(this, event)" value="<%=nom_pac%>" size="55" readonly="readonly"/>
                </span>
                <label><!--span class="style2"> Carnet:&nbsp;
                <input name="txtf_carnet" type="text" class="style13" value="<%//=carnet_jv%>" size="8"  onKeyPress="return handleEnter(this, event)"/-->
                 Sexo:
                <input name="txtf_sexo" type="text" class="style13"  onKeyPress="return handleEnter(this, event)" value="<%=sexo%>" size="5" readonly="readonly"/>
                EDAD:
                <input name="txtf_edad" type="text" class="style13"  onkeypress="return handleEnter(this, event)" value="<%=fec_nac%>" size="10" readonly="readonly"/>
                <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NOMBRE</span><span class="style2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;APELLIDO PATERNO &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;APELLIDO MATERNO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></label></td>
              <td width="15">&nbsp;</td>
            </tr>
            <tr>
              <td height="52" class="style2">No. DE FOLIO S.P.<span class="style11">
                <input name="txtf_foliosp" type="text" class="style13" onKeyPress="return handleEnter(this, event)" value="<%=num_afi%>" size="20"/>
              </span>
              NOMBRE M&Eacute;DICO:
                <input name="txtf_nomed" type="text" class="style13"  onKeyPress="return handleEnter(this, event)" value="<%=nom_med%>" size="35" readonly="readonly" />
              <span class="style2">C&Eacute;DULA: 
              <input name="txtf_cedu" type="text" class="style13" id="a"  onKeyPress="return handleEnter(this, event)" value="<%=cedula%>" size="10"/> <!--input name="txtf_id" type="text" class="style13" value="<%//=id_rec%>" size="5"  onkeypress="return handleEnter(this, event)" readonly="readonly"/-->
              </span>
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
    </table>          </td>
  </tr>
       
        
        <tr>
          <td height="25" colspan="3" align="center">
            <input name="submit" type="submit" class="subHeader" value="Actualizar Datos" onClick="return verifica_ACT(document.forms.form);"/>
          </td>
  </tr>
        </tr>
</table>
<%
con.close();	  
%>

</body>
</html>
