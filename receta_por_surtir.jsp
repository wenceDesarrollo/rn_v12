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
<title>.: Surtir Receta Pendiente :.</title>
<script language="javascript" src="list02.js"></script>

<script type="text/javascript">
function validar(e) { // 1
    tecla = (document.all) ? e.keyCode : e.which; // 2
    if (tecla==8) return true; // 3
  patron = /\d/; 
   
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
<form name="form" method="post" action="receta_por_surtir.jsp?id_usu=<%=request.getParameter("id_usu")%>">
<a href="index.jsp" class="style2">REGRESAR A MENÚ</a>
<table width="893" height="621" border="3" align="center" cellpadding="2">
  <tr>
    <td width="877" height="114"><table width="864" border="0" align="center" cellpadding="2">
      <tr>
        <td width="201" height="59"><div align="center"><img src="imagenes/nay_ima1.jpg" width="203" height="78" />&nbsp;</div></td>
        <td width="417"><div align="center" class="style7">SERVICIOS DE SALUD DE NAYARIT<br />
        RECETA PENDIENTE POR SURTIR</div>
          <span class="style13"><span class="Estilo1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span class="style2"><strong>&nbsp;BIENVENIDOS:</strong><span class="Estilo4">&nbsp;</span></span></td>
        <td width="226"><div align="center"><img src="imagenes/ssn.jpg" width="219" height="89" />&nbsp;</div>
          <!--input name="Submit"  type="reset" class="bodyText" value="Borrar Datos" /--></td>
      </tr>
    </table>
      <table width="877" height="59" border="0" align="center" cellpadding="2">
        <tr>
          <td width="440" height="55" class="style2">
            Ingrese No. Folio:
          <input name="txtf_foliore" type="text" class="style13"  value="<%=fol_rec%>" size="15" onKeyPress="return handleEnter(this, event)"/>
          <label for="select"></label>
          <select name="slct_fol" id="slct_fol" onChange="putFolio();">
            <option>-- Folios --</option>
          	<%
			rset=stmt.executeQuery("select fol_rec from receta r, detreceta dr where r.id_tip='1' and r.id_rec=dr.id_rec and dr.status = '0' and r.id_usu='"+request.getParameter("id_usu")+"' group by r.fol_rec");
			while(rset.next()){
				out.println("<option>"+rset.getString("fol_rec")+"</option>");
			}
			%>
          </select>
          &nbsp;<input name="submit" type="submit" class="subHeader" value="Por Folio"/>
          <input name="act" type="submit" value="ACT" /></td>
          <%
		  String hora="", fec="", des_uni="", nom_pac="", sexo="", fec_nac="", num_afi="", nom_med="", cedula="", des_cau="";
		  rset=stmt.executeQuery("SELECT b.fec_carga, un.des_uni, p.nom_pac, p.sexo, p.fec_nac, p.num_afi, m.nom_med, m.cedula, c.des_cau  FROM usuarios u, receta r, bitacora b, causes c, pacientes p, medicos m, tipo_receta t, unidades un WHERE u.id_usu = r.id_usu AND r.id_rec = b.id_rec AND r.id_cau = c.id_cau AND r.num_afi = p.num_afi AND r.cedula = m.cedula AND r.id_tip = t.id_tip AND u.cla_uni = un.cla_uni AND r.fol_rec = '"+fol_rec+"' and u.id_usu = '"+request.getParameter("id_usu")+"'");
		  while(rset.next()){
			  fec=df2.format(df.parse(rset.getString("fec_carga")));
			  hora=df3.format(df.parse(rset.getString("fec_carga")));
			  des_uni=rset.getString("des_uni");
			  nom_pac=rset.getString("nom_pac");
			  sexo=rset.getString("sexo");
			  fec_nac=df2.format(df4.parse(rset.getString("fec_nac")));
			  num_afi=rset.getString("num_afi");
			  nom_med=rset.getString("nom_med");
			  cedula=rset.getString("cedula");
			  des_cau=rset.getString("des_cau");
		  }
		  %>
          <td width="167"><table width="167" height="0%" border="0" cellpadding="2">
            <tr>
              <td width="225" height="100%" class="style2">HORA:
                <input name="reloj" type="text" class="style13" onKeyPress="return handleEnter(this, event)" size="15" readonly value="<%=hora%>"></td>
            </tr>
          </table></td>
          <td width="250" align="center" class="style2">
            FECHA:
                  <input name="txtf_t1" type="text" id='txtf_t1' onKeyPress="return handleEnter(this, event)" onKeyUp="putDays()" value="<%=fec%>" size="10" class="style13" readonly="readonly"/>&nbsp;&nbsp;<a href="reimp.jsp" target="_blank">Reimprir TICKET</a>
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
          <td height="41" colspan="3" class="style4"><table width="710" border="0" align="center" cellpadding="2">
            <tr>
              <td width="533" class="style2">UNIDAD DE SALUD
              <input type="text" name="txtf_unidadmed" size="60" colspan="3" class="style13"  value="<%=des_uni%>" readonly onKeyPress="return handleEnter(this, event)"/></td>
              <td width="170">&nbsp;</td>
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
                <input name="txtf_paciente" type="text" class="style13" value="<%=nom_pac%>" size="55"  onKeyPress="return handleEnter(this, event)" readonly="readonly"/>
                </span>
                <label>
                 Sexo:
                <input name="txtf_sexo" type="text" class="style13" value="<%=sexo%>" size="5"  onKeyPress="return handleEnter(this, event)" readonly="readonly"/>
                EDAD:
                <input name="txtf_edad" type="text" class="style13" value="<%=fec_nac%>" size="12"  onkeypress="return handleEnter(this, event)" readonly="readonly"/>
                <br />
</label></td>
              <td width="15">&nbsp;</td>
            </tr>
            <tr>
              <td height="52" class="style2">No. DE FOLIO S.P.<span class="style11">
                <input name="txtf_foliosp" type="text" class="style13" value="<%=num_afi%>" size="20" onKeyPress="return handleEnter(this, event)" readonly="readonly"/>
              </span>
              NOMBRE M&Eacute;DICO:
                <input name="txtf_nomed" type="text" class="style13" value="<%=nom_med%>" size="35"  onKeyPress="return handleEnter(this, event)" readonly="readonly" />
                <br />
              <span class="style2">C&Eacute;DULA: 
              <input name="txtf_cedu" id="a" type="text" class="style13" value="<%=cedula%>" size="10"  onKeyPress="return handleEnter(this, event)" readonly="readonly"/>
              CAUSES:
              <input name="txtf_cause" type="text" class="style13" onKeyPress="return handleEnter(this, event)" value="<%=des_cau%>" size="8" onClick="putEmpty()" readonly="readonly" /><br /><br />
              <a href="index_carga_clave.jsp?id_usu=<%=request.getParameter("id_usu")%>" target="_blank">Agregar Clave</a>| <a href="existencias.jsp?id_usu=<%=request.getParameter("id_usu")%>" target="_blank">Ver Existencias</a>
              </span>
              </td>
              <td>&nbsp;</td>
            </tr>
    </table>          </td>
        </tr>
       
        
        <tr>
          <td height="219" colspan="3" class="style4">INSUMOS DISPENSADOS<table width="779" border="0" align="center" cellpadding="2">
            <tr>
              <td colspan="7" class="style11"><hr /></td>
            </tr>
			
            <tr>
              <td width="70" align="center" class="style11"><span class="style2">CLAVE</span></td>
              <td width="260" align="center" class="style11"><span class="style2">DESCRIPCI&Oacute;N</span></td>
              <td width="50" align="center" class="style11"><span class="style2">LOTE</span></td>
              <td width="70" align="center" class="style11"><span class="style2">CADUCIDAD</span></td>
              <td width="63" align="center" class="style11"><span class="style2">CANT. SOL</span></td>
              <td width="65" align="center" class="style11"><span class="style2">CANT. SUR </span></td>
              <td width="67" align="center" class="style11"><span class="style2">ORIGEN</span></td>
              <td width="7" class="style11">&nbsp;</td>
              <td width="71" class="style11">&nbsp;</td>
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
			  
              <td class="style11"><a href="receta_por_surtir.jsp?submit=surtir&id_usu=<%=request.getParameter("id_usu")%>&txtf_foliore=<%=fol_rec%>&fol_det=<%=rset.getString("fol_det")%>" <%if(!rset.getString("cant_sur").equals("0")){out.println("style='visibility:hidden'");}%> class="subHeader" />Surtir</a>&nbsp;
              </td>
            </tr>
            <%
			}
			%>
            <tr>
              <td colspan="7" class="style11"><hr /></td>
            </tr>
			
            <tr>
              <td height="28" class="style11">&nbsp;</td>
              <td class="style11">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <label>              </label></td>
              <td class="style11">&nbsp;</td>
              <td class="style11">&nbsp;</td>
              <td class="style11">&nbsp;</td>
              <td class="style11">&nbsp;</td>
              <td class="style11"><a href="ticket_rsf.jsp?fol_rec=<%=fol_rec%>&id_usu=<%=request.getParameter("id_usu")%>&tipo=<%=request.getParameter("tipo")%>">Imprimir</a></td>
            </tr>
          </table></td>
  </tr>
        </tr>
</table>


</body>
</html>
<%
con.close();
%>