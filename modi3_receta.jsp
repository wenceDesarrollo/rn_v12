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
	//if (request.getParameter("submit").equals("Por Folio")){
		rset = stmt.executeQuery("SELECT t.des_tip, u.des_uni, r.fol_rec, bi.fec_carga, u.cla_uni, pa.nom_pac, pa.sexo, pa.num_afi, bi.fec_carga, f.des_fin, o.des_ori, p.cla_pro, p.des_pro, DP.lot_pro, dp.cad_pro, us.nombre, me.nom_med, pa.fec_nac, me.cedula FROM UNIDADES U, municipios M, usuarios US, receta R, detreceta DR, detalle_productos DP, productos P, origen O, pacientes pa, bitacora bi, financiamientos f, tipo_receta t, medicos me where  m.cla_mun = u.cla_mun AND u.cla_uni = US.cla_uni and us.id_usu = r.id_usu AND r.id_rec = dr.id_rec and dr.det_pro = DP.det_pro AND dp.cla_pro = p.cla_pro AND DP.id_ori = o.id_ori and r.num_afi = pa.num_afi AND r.id_rec = bi.id_rec AND r.id_tip = t.id_tip and dp.cla_fin = f.cla_fin AND r.fol_rec = '"+request.getParameter("fol_rec")+"' and r.id_tip='1' and r.baja != '1' and u.cla_uni = '"+request.getParameter("cla_uni")+"' and r.cedula = me.cedula group by r.fol_rec;");
		
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
	//}
	
	
	if (request.getParameter("submit").equals("eliminar")){
		
		rset = stmt.executeQuery("SELECT dr.det_pro, dr.cant_sur, dr.can_sol, dr.id_rec, i.id_inv FROM usuarios us, unidades u, inventario i, detalle_productos dp, detreceta dr WHERE us.cla_uni = u.cla_uni and u.cla_uni = i.cla_uni and i.det_pro = dp.det_pro and dp.det_pro = dr.det_pro and us.id_usu = '"+request.getParameter("id_usu")+"' and dr.fol_det = '"+request.getParameter("fol_det")+"' ;");

		while(rset.next()){
			//out.println(rset.getString("det_pro"));
			//out.println(rset.getString("cant_sur"));
			//out.println(rset.getString("can_sol"));
			//out.println(rset.getString("id_rec"));
			//out.println(rset.getString("id_inv"));
			int cant=rset.getInt("cant_sur");
			rset2 = stmt2.executeQuery(("SELECT CANT FROM INVENTARIO WHERE id_inv = '"+rset.getString("id_inv")+"' "));
			while (rset2.next()){
				cant = cant + rset2.getInt("cant");
			}
			
			stmt2.execute(("UPDATE INVENTARIO SET CANT = '"+cant+"', web = '0' WHERE id_inv = '"+rset.getString("id_inv")+"';     "));
			stmt2.execute(("insert into kardex values ('0', '"+rset.getString("id_rec")+"', '"+rset.getString("det_pro")+"', '"+rset.getString("cant_sur")+"', 'ENTRADA RECETA', '-', NOW(), 'ENTRADA RECETA', '"+request.getParameter("id_usu")+"', '0')"));
			stmt2.execute(("update detreceta set baja = '1', can_sol = '0', cant_sur = '0' where fol_det = '"+request.getParameter("fol_det")+"'"));
			
		}
	}
	
	if (request.getParameter("submit").equals("Capturar")){
        int sol = Integer.parseInt(request.getParameter("txtf_sol1"));
        int sur = Integer.parseInt(request.getParameter("txtf_sol1"));
        int sol1=0;
        String det_pro = "";
        try{
            String id_rec="";
            rset = stmt.executeQuery("SELECT i.id_inv, DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, I.cant, DP.cla_fin, DP.id_ori FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla_pro = '"+request.getParameter("txtf_clave1")+"' AND U.cla_uni='"+request.getParameter("cla_uni")+"' ORDER BY  DP.id_ori, DP.cad_pro, I.cant ASC ");
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
							stmt2.execute("insert into detreceta values ('0', '"+rset.getString("det_pro")+"', '"+request.getParameter("txtf_sol1")+"', '"+sur+"', '"+df.format(new Date())+"', '1', '"+id_rec+"', CURTIME(), '0', '0' ) ");
							stmt2.execute("insert into kardex values ('0', '"+id_rec+"', '"+rset.getString("det_pro")+"', '"+sur+"', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA FAR', '"+request.getParameter("id_usu")+"', '0')");
						}
						if (sol < 0 ){
							stmt2.execute("update inventario set cant = '"+(-1*sol)+"', web = '0' where id_inv = '"+rset.getString("id_inv")+"' ");
							sur = sol*-1;
							stmt2.execute("insert into detreceta values ('0', '"+rset.getString("det_pro")+"', '"+(sol1)+"', '"+(sol1)+"', '"+df.format((new Date()))+"', '1', '"+id_rec+"', CURTIME(), '0', '0' ) ");
							stmt2.execute("insert into kardex values ('0', '"+id_rec+"', '"+rset.getString("det_pro")+"', '"+sol1+"', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA FAR', '"+request.getParameter("id_usu")+"', '0')");
						}
						break;
					}
					stmt2.execute("insert into detreceta values ('0', '"+rset.getString("det_pro")+"', '"+rset.getString("cant")+"', '"+rset.getString("cant")+"', '"+df.format(new Date())+"', '1', '"+id_rec+"', CURTIME(), '0', '0' ) ");                    
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
                stmt2.execute("insert into detreceta values ('0', '"+det_pro+"', '"+sol+"', '0', '"+df.format(new Date())+"', '0', '"+id_rec+"', CURTIME(), '0', '0' ) ");
                stmt2.execute("insert into kardex values ('0', '"+id_rec+"', '"+det_pro+"', '0', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA FAR', '"+request.getParameter("id_usu")+"', '0')");
            }
        } catch (Exception e) {out.println(e.getMessage());}
    }
	
	
} catch(Exception e){
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.: Agregar / Eliminar Insumo :.</title>
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
.style5 {
	font-size: 14px
}
.style7 {
	font-size: 16px;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.style11 {
	font-size: 12px
}
.style13 {
	font-size: 12px;
	color: #990000;
	font-weight: bold;
}
.Estilo1 {
	color: #000000
}
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
<form name="form" method="post" action="modi3_receta.jsp?cla_uni=<%=request.getParameter("cla_uni")%>&id_usu=<%=request.getParameter("id_usu")%>">
<a href="menu_mod_rf.jsp?cla_uni=<%=request.getParameter("cla_uni")%>&id_usu=<%=request.getParameter("id_usu")%>" class="style2">REGRESAR A MENÚ</a>
<table width="893" height="621" border="3" align="center" cellpadding="2">
  <tr>
    <td width="877" height="114"><table width="864" border="0" align="center" cellpadding="2">
        <tr>
          <td width="201" height="59"><div align="center"><img src="imagenes/nay_ima1.jpg" width="203" height="78" />&nbsp;</div></td>
          <td width="417"><div align="center" class="style7">SERVICIOS DE SALUD DE NAYARIT<br />
              RECETA FARMACIA</div></td>
          <td width="226"><div align="center"><img src="imagenes/ssn.jpg" width="219" height="89" />&nbsp;</div>
            
            <!--input name="Submit"  type="reset" class="bodyText" value="Borrar Datos" /--></td>
        </tr>
      </table>
      <table width="877" height="59" border="0" align="center" cellpadding="2">
        <tr>
          <td width="440" height="55" class="style2"> Ingrese No. Folio:
            <input name="fol_rec" type="text" class="style13"  value="<%=fol_rec%>" size="15" onKeyPress="return handleEnter(this, event)"/>
            <label for="select"></label>
            <select name="slct_fol" id="slct_fol" onChange="putFolio();">
              <option>-- Folios --</option>
              <option value=""></option>
            </select>
            &nbsp;
            <input name="submit" type="submit" class="subHeader" value="Por Folio"/>
            <input name="act" type="submit" value="ACT" /></td>
          <td width="167"><table width="167" height="0%" border="0" cellpadding="2">
              <tr>
                <td width="225" height="100%" class="style2">HORA:
                  <input name="reloj" type="text" class="style13" value="<%=hor_car%>" onKeyPress="return handleEnter(this, event)" size="15" readonly ></td>
              </tr>
            </table></td>
          <td width="250" align="center" class="style2"> FECHA:
            <input name="txtf_t1" type="text" id='txtf_t1' onKeyPress="return handleEnter(this, event)"  value="<%=fec_car%>" size="10" class="style13" readonly/>
            &nbsp;&nbsp; </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="2" colspan="3" class="style4"><div id="item7" style="display:none" align="justify" ><span class="style2">
        <input name="txtf_date1" type="text" size="20" value="" onKeyPress="return handleEnter(this, event)" readonly/>
        </span></div></td>
  </tr>
  <tr>
    <td height="41" colspan="3" class="style4"><table width="710" border="0" align="center" cellpadding="2">
        <tr>
          <td width="533" class="style2">UNIDAD DE SALUD
            <input type="text" name="txtf_unidadmed" size="60" colspan="3" class="style13"  value="<%=des_uni%>" readonly onKeyPress="return handleEnter(this, event)"/></td>
          <td width="170"><table width="170" border="0" align="left" cellpadding="2">
              <tr>
                <td width="162" align="center"></td>
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
            <input name="txtf_paciente" type="text" class="style13" value="<%=nom_pac%>" size="55"  onKeyPress="return handleEnter(this, event)" readonly/>
            </span>
            <label> Sexo:
              <input name="txtf_sexo" type="text" class="style13" value="<%=sexo%>" size="5"  onKeyPress="return handleEnter(this, event)" readonly/>
              EDAD:
              <input name="txtf_edad" type="text" class="style13" value="<%=fec_nac%>" size="10"  onkeypress="return handleEnter(this, event)" readonly/>
              <br />
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;APELLIDO PATERNO </span><span class="style2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;APELLIDO MATERNO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NOMBRE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></label></td>
          <td width="15">&nbsp;</td>
        </tr>
        <tr>
          <td height="52" class="style2">No. DE FOLIO S.P.<span class="style11">
            <input name="txtf_foliosp" type="text" class="style13" onKeyPress="return handleEnter(this, event)" value="<%=num_afi%>" size="20" readonly/>
            </span> NOMBRE M&Eacute;DICO:
            <input name="txtf_nomed" type="text" class="style13"  onKeyPress="return handleEnter(this, event)" value="<%=nom_med%>" size="35" readonly />
            <span class="style2">C&Eacute;DULA:
            <input name="txtf_cedu" type="text" class="style13" id="a"  onKeyPress="return handleEnter(this, event)" value="<%=cedula%>" size="10" readonly/>
            </span></td>
          <td>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="219" colspan="3" class="style4"><table width="871" border="0" align="center" cellpadding="2">
        <tr>
          <td colspan="4" class="style11" align="left">Ingrese Clave:
            <input type="text" name="txtf_med1" id="txtf_med1" size="10" value="" onKeyPress="return handleEnter(this, event)"/>
            <input name="submit" type="submit" class="subHeader" value="Clave"/>
            &nbsp;<a href="index_carga_clave.jsp?id_usu=<%=request.getParameter("id_usu")%>" target="_blank">Agregar Clave</a>| <a href="existencias.jsp?id_usu=<%=request.getParameter("id_usu")%>" target="_blank">Ver Existencias</a></td>
          <td colspan="5" class="style11">
          
          <span class="style2">
          <span class="Estilo8">
          <%
			  int ban_cla=0;
			  String clave="", descr="", fuente = "", cantidad = "0", det_pro="";
			  rset = stmt.executeQuery("SELECT DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, sum(I.cant) as cant, DP.cla_fin FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla_pro = '"+request.getParameter("txtf_med1")+"' AND US.id_usu ='"+request.getParameter("id_usu")+"' GROUP BY P.cla_pro ORDER BY DP.cad_pro, I.cant ASC ;");
			  while(rset.next()){
				  clave = rset.getString("cla_pro");
				  descr = rset.getString("des_pro");
				  cantidad = rset.getString("cant");
				  fuente = rset.getString("cla_fin");
				  det_pro = rset.getString("det_pro");
				  ban_cla=1;
			  }
		  %>
          TOTAL EXISTENCIAS:
          <%=cantidad%>
          </span>
          <%
		  if (ban_cla==0&&request.getParameter("submit")!=null&&request.getParameter("submit").equals("Clave")){
		  %>
          <script>
		  alert('Insumo fuera de catalogo');
		  </script>
		  <%
		  }
		  %>
          <span class="Estilo5">
          <br />
          <%
			cantidad = "0";
			rset = stmt.executeQuery("SELECT DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, sum(I.cant) as cant, DP.cla_fin FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla_pro = '"+request.getParameter("txtf_med1")+"' AND US.id_usu ='"+request.getParameter("id_usu")+"' and DP.id_ori='1' GROUP BY P.cla_pro ORDER BY DP.cad_pro, I.cant ASC ;");
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
			rset = stmt.executeQuery("SELECT DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, sum(I.cant) as cant, DP.cla_fin FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla_pro = '"+request.getParameter("txtf_med1")+"' AND US.id_usu ='"+request.getParameter("id_usu")+"' and DP.id_ori='2' GROUP BY P.cla_pro ORDER BY DP.cad_pro, I.cant ASC ;");
			while(rset.next()){
				clave = rset.getString("cla_pro");
				descr = rset.getString("des_pro");
				cantidad = rset.getString("cant");
				fuente = rset.getString("cla_fin");
				det_pro = rset.getString("det_pro");
			}
			%>
            Origen 2=<%=cantidad%></span></span></td>
          <td width="140" colspan="2" class="style11" align="left"><label>
            <div align="left">
              <input type="text" name="txtf_idmed" size="1" value="" style="visibility:hidden" />
              <span class="style2">FUENTE </span>
              <input type="text" name="txtf_present" size="1" value="" style="visibility:hidden"/>
              <input type="text" name="txtf_finan" size="1"  style="visibility:hidden"/>
              <input type="text" class="style2" name="txtf_ff" value="" readonly />
            </div>
            </label></td>
        </tr>
        <tr>
          <td width="50" class="style11"><span class="letras"><span class="style2">CLAVE</span></span></td>
          <td colspan="2" class="style11"><span class="letras"><span class="style2">DESCRIPCI&Oacute;N</span></span></td>
          <td width="65" class="style11"><span class="letras"><span class="style2">CANT SOL</span></span></td>
          <td colspan="2" class="style11"><span class="letras"><span class="style2">CANT SUR</span></span></td>
          <td colspan="3" class="style11">&nbsp;</td>
          <td colspan="2" class="style11"><span class="letras"><span class="style2">CAUSES:
            <input name="txtf_cause" type="text" class="style13" onKeyPress="return handleEnter(this, event)" value="" size="1" onClick="putEmpty()" />
            </span></span></td>
        </tr>
        <tr>
          <td class="style11"><input type="text" name="txtf_clave1" size="10" class="style2" value="<%=clave%>"  readonly="true"/></td>
          <td colspan="2" class="style11"><textarea name="txtf_descrip1" cols="50"  class="style2" readonly><%=descr%></textarea></td>
          <td class="style11"><input type="text" name="txtf_sol1" id="txtf_sol1" size="5" value="0" onKeyPress="return validar(event)"  /></td>
          <td colspan="2" class="style11"><input type="text" name="txtf_sur1" size="5" value="0"  onchange="setSur(this.form)" onKeyPress="return validar(event)" readonly/></td>
          <td colspan="3" class="style11"><div align="center">
              <label for="textfield"></label>
              <input name="submit" type="submit" id="capturaid" class="but" value="Capturar" onClick="return verificaN_Fa(document.forms.form);" onChange="setSur(this.form)"/>
            </div></td>
          <td colspan="2" class="style11">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="10">INSUMOS DISPENSADOS</td>
        </tr>
        <tr>
          <td colspan="9" class="style11"><hr /></td>
        </tr>
        <tr>
          <td width="50" align="center" class="style11"><span class="style2">CLAVE</span></td>
          <td colspan="3" align="center" class="style11"><span class="style2">DESCRIPCI&Oacute;N</span></td>
          <td width="31" align="center" class="style11"><span class="style2">LOTE</span></td>
          <td width="65" align="center" class="style11"><span class="style2">CADUCIDAD</span></td>
          <td width="72" align="center" class="style11"><span class="style2">CANT. SOL</span></td>
          <td width="85" class="style11"><span class="style2">CANT. SUR</span></td>
          <td width="41" class="style11"><span class="style2">ORIGEN</span></td>
          <td width="140" class="style11">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="9" class="style11"><hr /></td>
        </tr>
        <%
			try{
				//if (request.getParameter("submit").equals("Por Folio")){
					rset = stmt.executeQuery("SELECT u.des_uni, r.fol_rec, bi.fec_carga, u.cla_uni, pa.nom_pac, pa.sexo, pa.num_afi, bi.fec_carga, f.des_fin, o.des_ori, p.cla_pro, p.des_pro, DP.lot_pro, dp.cad_pro, us.nombre, dr.can_sol, dr.cant_sur, dr.status, dr.fol_det FROM UNIDADES U, municipios M, usuarios US, receta R, detreceta DR, detalle_productos DP, productos P, origen O, pacientes pa, bitacora bi, financiamientos f where  m.cla_mun = u.cla_mun AND u.cla_uni = US.cla_uni and us.id_usu = r.id_usu AND r.id_rec = dr.id_rec and dr.det_pro = DP.det_pro AND dp.cla_pro = p.cla_pro AND DP.id_ori = o.id_ori and r.num_afi = pa.num_afi AND r.id_rec = bi.id_rec AND dp.cla_fin = f.cla_fin AND r.fol_rec = '"+request.getParameter("fol_rec")+"' and u.cla_uni = '"+request.getParameter("cla_uni")+"' and r.id_tip='1' and r.baja != '1' and dr.baja = '0' ;");
	
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
          <td class="style11" align="center"><span class="style2"><%=cla_pro%></span></td>
          <td colspan="3" align="center" class="style11"><span class="style2"><%=des_pro%></span></td>
          <td class="style11" align="center"><span class="style2"><%=lot_pro%></span></td>
          <td class="style11" align="center"><span class="style2"><%=cad_pro%></span></td>
          <td class="style11" align="center"><span class="style2"><%=can_sol%></span></td>
          <td class="style11"><span class="style2"><%=can_sur%></span></td>
          <td class="style11"><span class="style2"><%=des_ori%></span></td>
          <td><span class="style11">
            <a href = "modi3_receta.jsp?cla_uni=<%=request.getParameter("cla_uni")%>&fol_det=<%=rset.getString("fol_det")%>&id_usu=<%=request.getParameter("id_usu")%>&fol_rec=<%=fol_rec%>&submit=eliminar">Eliminar</a>
            </span></td>
        </tr>
        <%
				}
			//}
		}catch (Exception e) {
		}
		%>
        <tr>
          <td colspan="9" class="style11"><hr /></td>
        </tr>
        <tr>
          <td height="28" class="style11">&nbsp;</td>
          <td width="226" class="style11">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <label> </label></td>
          <td width="34" class="style11">&nbsp;</td>
          <td class="style11">&nbsp;</td>
          <td class="style11">&nbsp;</td>
          <td class="style11">&nbsp;</td>
          <td class="style11">&nbsp;</td>
          <td></td>
          <td></td>
          <td><span class="style11">
            <a href="ticket_mrf.jsp?cla_uni=<%=request.getParameter("cla_uni")%>&fol_rec=<%=fol_rec%>&id_usu=<%=request.getParameter("id_usu")%>">Imprimir</a>
            </span></td>
        </tr>
      </table></td>
  </tr>
  
    <td align="center"><a onClick="return confirm('Seguro que desea eliminarlo?')" href="elim_datos.jsp?fol_rec=<%=fol_rec%>&cla_uni=<%=request.getParameter("cla_uni")%>&id_usu=<%=request.getParameter("id_usu")%>&submit=eliminar">Eliminar Folio</a></td>
  </tr>
</table>
</body>
</html>
<%
con.close();
%>