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
// fin conexión -----------------------------------	
String des_uni = "", fol_rec = "", fec_car="", hor_car="", cla_uni = "", nom_pac = "", sexo="", num_afi="", des_fin ="", des_ori ="", nombre="", des_tip="", fec_nac="", cedula="", nom_med = "", enc_ser = "", nom_ser="";
String sub="";

try{
	if (request.getParameter("submit").equals("Por Folio")){
		
		rset = stmt.executeQuery("SELECT t.des_tip, u.des_uni, r.fol_rec, bi.fec_carga, u.cla_uni, pa.nom_pac, pa.sexo, pa.num_afi, bi.fec_carga, f.des_fin, o.des_ori, p.cla_pro, p.des_pro, DP.lot_pro, dp.cad_pro, us.nombre, me.nom_med, pa.fec_nac, me.cedula, s.nom_ser, r.enc_ser FROM UNIDADES U, municipios M, usuarios US, receta R, detreceta DR, detalle_productos DP, productos P, origen O, pacientes pa, bitacora bi, financiamientos f, tipo_receta t, medicos me, servicios s where  m.cla_mun = u.cla_mun AND u.cla_uni = US.cla_uni and us.id_usu = r.id_usu AND r.id_rec = dr.id_rec and dr.det_pro = DP.det_pro AND dp.cla_pro = p.cla_pro AND DP.id_ori = o.id_ori and r.num_afi = pa.num_afi AND r.id_rec = bi.id_rec AND r.id_tip = t.id_tip and dp.cla_fin = f.cla_fin AND r.fol_rec = '"+request.getParameter("fol_rec")+"'  and r.cedula = me.cedula and r.id_ser = s.id_ser group by r.fol_rec;");
		
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
			nom_ser= rset.getString("nom_ser");
			enc_ser =rset.getString("enc_ser");
		}
	}
} catch(Exception e){
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.: Receta Colectiva :.</title>
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
<script type="text/javascript">
    function getfocus()
    {
            document.getElementById('w3s').focus();
    }
 
    function losefocus()
    {
            document.getElementById('w3s').blur();
    }
	
	function foco_inicial(){
	if (document.form.txtf_t3.value!="")
	{
		if (document.form.txtf_descrip1.value==""){
			document.form.txtf_med1.focus();
		}
		else{
			document.form.txtf_sol1.focus();
		}
	}
	else{
		document.form.txtf_t1.focus();
	}
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
.style7 {
	font-size: 16px;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.style11 {font-size: 12px}
.style12 {
	color: #CCCCCC;
	font-weight: bold;
}
.Estilo5 {color: #990000; font-weight: bold; }
.Estilo7 {
	font-size: 16;
	font-weight: bold;
}
doce {
	font-size: 12px;
}
dd {
	font-size: 12px;
}
-->
</style>
</head>

<body>
<script src="scw.js" type="text/javascript"> </script>
<form name="form" method="post" action="ver_receta_col.jsp?cla_uni=<%=request.getParameter("cla_uni")%>">
<table width="957" height="562" border="3" align="center" cellpadding="2">
  <tr>
    <td width="725" height="156"><table width="895" border="0" align="center" cellpadding="2">
      <tr>
        <td width="231"><img src="imagenes/nay_ima1.jpg" width="203" height="78" /></td>
        <td width="420"><div align="center"><span class="style7">SERVICIO DE SALUD DE NAYARIT<br />
        RECETA COLECTIVA </span></div></td>
        <td width="224"><img src="imagenes/ssn.jpg" width="219" height="89" /></td>
      </tr>
    </table>
      <a href="index.jsp">Regresar a Menu</a>
      <table width="912" height="61" border="0" align="center" cellpadding="2">
        <tr>
          <td width="91" height="55"><label></label>
            
            <span class="style2">INGRESE FOLIO:</span>
          <td width="346" class="style2"><input type="text" name="fol_rec" size="15" class="Estilo5"  value="<%=fol_rec%>" /><select name="slct_fol" id="slct_fol" onChange="putFolio();">
            <option>-- Folios --</option>
            <option value=""></option>
         
          </select><input name="submit" type="submit" class="subHeader" value="Por Folio"/> <input name="act" type="submit" value="ACT" />            
          <label>          </label></td>
          <td width="173"><span class="style2">HORA:</span>            <input name="reloj" type="text"  class="Estilo5" onKeyPress="return handleEnter(this, event)" value="<%=hor_car%>" size="15" readonly ></td>
          <td width="276" align="left" class="style2">FECHA
           
                <input type='text' name='txtf_t3' id='txtf_t3' title='DD/MM/AAAA' value="<%=fec_car%>" size='10' maxlength='10' onclick='scwShow(this, event);' readonly class="Estilo5"/>
       </td>
        </tr>
    </table>    </td>
  </tr>
        <tr>
          <td height="71" colspan="3" class="style4"><table width="895" border="0" align="center" cellpadding="2">
            <tr>
              <td height="2" class="style4"><div id="item7" style="display:none" align="justify" ><span class="style2">
            <input name="txtf_date1" type="text" size="20" value="" onKeyPress="return handleEnter(this, event)" readonly/>
          </span></div>
              <span class="style2"><strong>UNIDAD DE SALUD:</strong></span></td>
              <td height="2" class="style4"><span class="style2"><strong>ELABOR&Oacute; COLECTIVO:</strong></span></td>
              <td height="2" class="style4"><span class="style2"><strong>JURISDICCION:
                  
              </strong></span></td>
              <td width="1" height="2" class="style4">&nbsp;</td>
              <td width="42">&nbsp;</td>
            </tr>
            <tr>
              <td width="310" class="style2">
              <textarea name="txtf_unidadmed" cols="40" class="Estilo5" colspan="3" readonly><%=nom_ser%></textarea></td>
              <td width="230"><span class="style2">
                <textarea name="txtf_ela" cols="25"  class="Estilo5" readonly><%=enc_ser%></textarea>
              </span></td>
              <td width="280"><span class="style2">
              </span></td>
            </tr>
            
          </table>
		  
		  </td>
        </tr>
        <tr>
		<td height="241">
		<table width="939" border="0" align="center" cellpadding="2">
            
            <tr>
              <td colspan="2" class="style2">&nbsp;Servicio: 
              <input type="text" name="txtf_servicio" class="style2" size="30" value="<%=fol_rec%>"  readonly="readonly"/>&nbsp;&nbsp;Encargado del Servicio:
              <input type="text" name="txtf_encarser" class="style2" size="35" value="<%=fol_rec%>" readonly/></td>
              <td colspan="3" class="style2"><span class="style11">
               
              </span></td>
              <td width="75" class="style11">&nbsp;</td>
            </tr>
            
            
            <tr>
              <td colspan="7" class="style11"><hr /></td>
            </tr>
			
            <tr bordercolor="#000000">
              <td width="180" align="center" bordercolor="#333333" class="style11"><span class="style2">CLAVE</span></td>
              <td width="349" align="center" bordercolor="#333333" class="style11"><span class="style2">DESCRIPCI&Oacute;N</span></td>
              <td width="28" align="center" bordercolor="#333333" class="style11"><span class="style2">LOTE</span></td>
              <td width="90" align="center" bordercolor="#333333" class="style11"><span class="style2">CADUCIDAD</span></td>
              <td width="70" align="center" bordercolor="#333333" class="style11"><span class="style2">CANT. SOL</span></td>
              <td align="center" bordercolor="#333333" class="style11"><span class="style2">CANT. SUR </span></td>
              <td width="40" align="center" bordercolor="#333333" class="style11"><span class="style2">ORIGEN</span></td>
              <td width="57" class="style11">&nbsp;</td>
            </tr>
            <tr>
              <td colspan="7" class="style11"><hr /></td>
            </tr>
			 <%
			try{
				if (request.getParameter("submit").equals("Por Folio")){
					rset = stmt.executeQuery("SELECT o.des_ori, p.cla_pro, p.des_pro, DP.lot_pro, dp.cad_pro, dr.can_sol, dr.cant_sur FROM  receta R, detreceta DR, detalle_productos DP, productos P, origen O where r.id_rec = dr.id_rec and dr.det_pro = DP.det_pro AND dp.cla_pro = p.cla_pro AND DP.id_ori = o.id_ori and r.fol_rec = '"+request.getParameter("fol_rec")+"' and dr.cant_sur!='0' and dr.baja = '0' ;");
	
					while (rset.next()){
					String des_pro=rset.getString("des_pro");
					String cla_pro=rset.getString("cla_pro");
					String can_sol=rset.getString("can_sol");
					String can_sur=rset.getString("cant_sur");
					des_ori=rset.getString("des_ori");
					String lot_pro=rset.getString("lot_pro");
					String cad_pro=df2.format(df4.parse(rset.getString("cad_pro")));
			%>
            <tr>
              <td class="style11" align="center"><%=cla_pro%></td>
              <td class="style11" align="center"><%=des_pro%></td>
              <td class="style11" align="center"><%=lot_pro%></td>
              <td class="style11" align="center"><%=cad_pro%></td>
              <td class="style11" align="center"><%=can_sol%></td>
              <td class="style11" align="center"><%=can_sur%></td>
              <td class="style11" align="center"><%=des_ori%></td>
              <td class="style11"></td>
            </tr>
            <%
					}
				}
			}catch (Exception e) {
			}
			%>
            <tr>
              <td colspan="7" class="style11"><hr /></td>
            </tr>
			
       <tr>
              <td class="style11">&nbsp;</td>
              <td class="style11">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <label></label></td>
              <td class="style11">&nbsp;</td>
              <td class="style11">&nbsp;</td>
              <td class="style11">&nbsp;</td>
              <td class="style11"><a href="ticket_vrc.jsp?cla_uni=<%=request.getParameter("cla_uni")%>&fol_rec=<%=request.getParameter("fol_rec")%>">Imprimr</a></td>
            </tr>
          </table>
		</td>
		</tr>
        
       
	   <tr>
         <td height="40" colspan="3" class="style4"><div align="right" class="style12">
           <div align="center"><img src="imagenes/ima_main.jpg" width="517" height="77" /></div>
         </div></td>
  </tr>
</table>
</form>
</td></tr></td></td></td></td></td>


</body>
</html>
<%
con.close();
%>