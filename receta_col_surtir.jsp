<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.DecimalFormat" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="" %>

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
Statement stmt3 = con.createStatement();
ResultSet rset3 = null;
// fin conexión -----------------------------------	
String fol_rec = "", sub="";
try{
	fol_rec = request.getParameter("txtf_foliore");
	
} catch (Exception e){
}
if (fol_rec==null){
	fol_rec="";
}

try{
	sub=request.getParameter("submit");
	if (sub.equals("surtir")){
		int sol = 0, sur=0, sol1=0;
		int sur1=0;
		String cla_pro="", id_rec="", det_pro="";
		rset=stmt.executeQuery("SELECT dp.cla_pro, dr.can_sol, dr.cant_sur, dr.id_rec FROM detreceta dr, detalle_productos dp where dr.det_pro = dp.det_pro AND dr.fol_det = '"+request.getParameter("fol_det")+"';");
		while(rset.next()){
			sol = Integer.parseInt(rset.getString("can_sol"));
			sur = Integer.parseInt(rset.getString("can_sol"));
			sol1=0;
			cla_pro=rset.getString("cla_pro");
			id_rec=rset.getString("id_rec");
		}
		
		rset2=stmt2.executeQuery("select i.cant, dp.det_pro, i.id_inv, dp.cad_pro, dp.id_ori, dp.cla_fin FROM detalle_productos dp, inventario i, unidades u, usuarios us where  dp.det_pro = i.det_pro AND i.cla_uni = u.cla_uni AND u.cla_uni = us.cla_uni AND us.id_usu = '"+request.getParameter("id_usu")+"' AND dp.cla_pro='"+cla_pro+"' ORDER BY  DP.id_ori, DP.cad_pro, I.cant ASC ;");
		while(rset2.next()){
			if(Integer.parseInt(rset2.getString("cant"))>0){
				sur1=sur1+sol1;
				sol1=sol;
				det_pro=rset2.getString("det_pro");
				sol = sol-Integer.parseInt(rset2.getString("cant"));
				if(sol <= 0){
					if (sol == 0 ){
						stmt3.execute("update inventario set cant = '"+(-1*sol)+"' where id_inv = '"+rset2.getString("id_inv")+"'");
						sur = Integer.parseInt(rset2.getString("cant"));
						stmt3.execute("update detreceta set can_sol = '"+sol1+"', cant_sur = '"+sol1+"', fec_sur = CURDATE(), status='1' where fol_det = '"+request.getParameter("fol_det")+"'"); 
						stmt3.execute("insert into kardex values ('0', '"+id_rec+"', '"+rset2.getString("det_pro")+"', '"+sur+"', 'SALIDA RECETA SURTIR', '-', NOW(), 'SALIDA POR RECETA FAR SURTIR', '"+request.getParameter("id_usu")+"')");
					}
					if (sol < 0 ){
						stmt3.execute("update inventario set cant = '"+(-1*sol)+"' where id_inv = '"+rset2.getString("id_inv")+"'");
						sur = sol*-1;
						stmt3.execute("update detreceta set can_sol = '"+sol1+"', cant_sur = '"+sol1+"', fec_sur = CURDATE(), status='1' where fol_det = '"+request.getParameter("fol_det")+"'"); 
						stmt3.execute("insert into kardex values ('0', '"+id_rec+"', '"+rset2.getString("det_pro")+"', '"+sol1+"', 'SALIDA RECETA SURTIR', '-', NOW(), 'SALIDA POR RECETA FAR SURTIR', '"+request.getParameter("id_usu")+"')");
					}
					break;
				}
				//out.println("insert into detreceta values ('0', '"+rset2.getString("det_pro")+"', '"+rset.getString("cant")+"', '"+rset.getString("cant")+"', '1', '"+df.format(df2.parse(request.getParameter("txtf_date1")))+"', '1', '"+id_rec+"', CURTIME() )
				stmt3.execute("update detreceta set can_sol = '"+rset2.getString("cant")+"', cant_sur = '"+rset2.getString("cant")+"', fec_sur = CURDATE(), status='1' where fol_det = '"+request.getParameter("fol_det")+"'");                    
				//out.println("insert into kardex values ('0', '"+id_rec+"', '"+rset.getString("det_pro")+"', '"+rset.getString("cant")+"', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA FAR', '"+request.getParameter("id_usu")+"')");
				stmt3.execute("insert into kardex values ('0', '"+id_rec+"', '"+rset2.getString("det_pro")+"', '"+rset2.getString("cant")+"', 'SALIDA RECETA SURTIR', '-', NOW(), 'SALIDA POR RECETA FAR SURTIR', '"+request.getParameter("id_usu")+"')");
				stmt3.execute("update inventario set cant = '0' where id_inv = '"+rset2.getString("id_inv")+"' ");
			}
		}
		if (sol>0){
			rset = stmt.executeQuery("select id_rec from receta where fol_rec = '"+fol_rec+"' and id_tip = '1' and id_usu = '"+request.getParameter("id_usu")+"' ");
                while (rset.next()){
                    id_rec = rset.getString("id_rec");
                }
                stmt3.execute("insert into detreceta values ('0', '"+det_pro+"', '"+sol+"', '0', '1', '"+df.format(new Date())+"', '0', '"+id_rec+"', CURTIME() )");
              stmt3.execute("insert into kardex values ('0', '"+id_rec+"', '"+det_pro+"', '0', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA FAR', '"+request.getParameter("id_usu")+"')");
		}
	}
}catch (Exception e){
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.: Pendiente por Surtir Receta Colectiva :.</title>
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
<!-------onLoad="mueveReloj();SetCur();"----------------->
<body >
<script src="scw.js" type="text/javascript"> </script>
<form name="form" method="post" action="receta_col_surtir.jsp?id_usu=<%=request.getParameter("id_usu")%>">
<table width="957" height="562" border="3" align="center" cellpadding="2">
  <tr>
    <td width="725" height="156"><table width="895" border="0" align="center" cellpadding="2">
      <tr>
        <td width="231"><img src="imagenes/nay_ima1.jpg" width="203" height="78" /></td>
        <td width="420"><div align="center"><span class="style7">SERVICIO DE SALUD DE NAYARIT<br />
        RECETA COLECTIVA PENDIENTE POR SURTIR</span></div></td>
        <td width="224"><img src="imagenes/ssn.jpg" width="219" height="89" /></td>
      </tr>
    </table>
      <a href="index.jsp">Regresar a Menu</a>
      <table width="912" height="61" border="0" align="center" cellpadding="2">
        <tr>
          <td width="91" height="55"><label></label>
            
            <span class="style2">INGRESE FOLIO:</span>
          <td width="346" class="style2"><input type="text" name="txtf_foliore" size="15" class="Estilo5"  value="<%=fol_rec%>" /><select name="slct_fol" id="slct_fol" onChange="putFolio();">
            <option>-- Folios --</option>
         
                <%
			rset=stmt.executeQuery("select fol_rec from receta r, detreceta dr where r.id_tip='2' and r.id_rec=dr.id_rec and dr.status = '0' and r.id_usu='"+request.getParameter("id_usu")+"' group by r.fol_rec");
			while(rset.next()){
				out.println("<option>"+rset.getString("fol_rec")+"</option>");
			}
			%>
         
          </select>
          <input name="Submit" type="submit" class="subHeader" value="Por Folio"/> <input name="act" type="submit" value="ACT" />            
          </td>
          <%
		  String hora="", fec="", des_uni="", nombre="", sexo="", nom_ser="", enc_ser="", nom_med="", cedula="", des_cau="";
		  rset=stmt.executeQuery("SELECT b.fec_carga, un.des_uni, u.nombre, s.nom_ser, r.enc_ser  FROM usuarios u, receta r, bitacora b, causes c, pacientes p, medicos m, tipo_receta t, unidades un, servicios s, detreceta dr WHERE r.id_ser=s.id_ser and u.id_usu = r.id_usu AND r.id_rec = b.id_rec AND r.id_cau = c.id_cau AND r.num_afi = p.num_afi AND  r.cedula = m.cedula AND r.id_tip = t.id_tip AND u.cla_uni = un.cla_uni AND r.fol_rec = '"+fol_rec+"' and u.id_usu = '"+request.getParameter("id_usu")+"'");
		  while(rset.next()){
			  fec=df2.format(df.parse(rset.getString("fec_carga")));
			  hora=df3.format(df.parse(rset.getString("fec_carga")));
			  des_uni=rset.getString("des_uni");
			  nombre=rset.getString("nombre");
			  nom_ser=rset.getString("nom_ser");
			  enc_ser=rset.getString("enc_ser");
		  }
		  %>
          <td width="173"><span class="style2">HORA:</span>            <input name="reloj" type="text"  class="Estilo5" onKeyPress="return handleEnter(this, event)" size="15" value="<%=hora%>" readonly ></td>
          <td width="276" align="left" class="style2">FECHA
           
                <input type='text' name='txtf_t3' id='txtf_t3' title='DD/MM/AAAA' value="<%=fec%>" size='10' maxlength='10'  readonly class="Estilo5"/>
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
              <td height="2" class="style4">&nbsp;</td>
              <td width="1" height="2" class="style4">&nbsp;</td>
              <td width="42">&nbsp;</td>
            </tr>
            <tr>
              <td width="310" class="style2">
              <textarea name="txtf_unidadmed" cols="40" class="Estilo5" colspan="3" readonly><%=des_uni%></textarea></td>
              <td width="230"><span class="style2">
                <textarea name="txtf_ela" cols="25"  class="Estilo5" readonly><%=nombre%></textarea>
              </span></td>
              <td width="280">&nbsp;</td>
            </tr>
            <tr>
              <td colspan="3">
              <a href="index_carga_clave.jsp?id_usu=<%=request.getParameter("id_usu")%>" target="_blank">Agregar Clave</a>| <a href="existencias.jsp?id_usu=<%=request.getParameter("id_usu")%>" target="_blank">Ver Existencias</a>
              </td>
            </tr>
          </table>
		  
		  </td>
        </tr>
        <tr>
		<td height="241">
		<table width="939" border="0" align="center" cellpadding="2">
            
            <tr>
              <td colspan="2" class="style2">&nbsp;Servicio: 
              <input type="text" name="txtf_servicio" class="style2" size="30" value="<%=nom_ser%>" readonly="readonly" />&nbsp;&nbsp;Encargado del Servicio:
              <input type="text" name="txtf_encarser" class="style2" size="35" value="<%=enc_ser%>" readonly/></td>
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
			rset=stmt.executeQuery("SELECT p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, dr.can_sol, dr.cant_sur, o.des_ori, dr.fol_det FROM usuarios u, receta r, detreceta dr, detalle_productos dp, origen o, financiamientos f, productos p WHERE u.id_usu = r.id_usu AND r.id_rec = dr.id_rec AND dr.det_pro = dp.det_pro AND dp.id_ori = o.id_ori AND dp.cla_fin = f.cla_fin AND dp.cla_pro = p.cla_pro and u.id_usu = '"+request.getParameter("id_usu")+"' AND r.fol_rec = '"+fol_rec+"';");
			while(rset.next()){
			%>
            <tr>
              <td class="style11" align="center"><span class="style2"><%=rset.getString("cla_pro")%></span></td>
              <td class="style11" align="center"><span class="style2"><%=rset.getString("des_pro")%></span></td>
              <td class="style11" align="center"><span class="style2"><%=rset.getString("lot_pro")%></span></td>
              <td class="style11" align="center"><span class="style2"><%=df2.format(df4.parse(rset.getString("cad_pro")))%></span></td>
              <td class="style11" align="center"><span class="style2"><%=rset.getString("can_sol")%></span></td>
              <td class="style11" align="center"><span class="style2"><%=rset.getString("cant_sur")%></span></td>
              <td class="style11" align="center"><span class="style2"><%=rset.getString("des_ori")%></span></td>
			  <td class="style11">&nbsp;</td>
			  
              <td class="style11"><a href="receta_col_surtir.jsp?submit=surtir&id_usu=<%=request.getParameter("id_usu")%>&txtf_foliore=<%=fol_rec%>&fol_det=<%=rset.getString("fol_det")%>" <%if(!rset.getString("cant_sur").equals("0")){out.println("style='visibility:hidden'");}%> class="subHeader" />Surtir</a>&nbsp;
              </td>
            </tr>
            <%
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
              <td class="style11"><a href="ticket_rsf.jsp?fol_rec=<%=fol_rec%>&id_usu=<%=request.getParameter("id_usu")%>&tipo=<%=request.getParameter("tipo")%>">Imprimir</a></td>
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