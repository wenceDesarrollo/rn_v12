<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" import ="java.awt.image.BufferedImage" import ="java.io.*" import ="javax.imageio.ImageIO" import ="net.sourceforge.jbarcodebean.*" import ="net.sourceforge.jbarcodebean.model.*" errorPage="" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
<%java.text.DateFormat df4 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("HH:mm:ss"); %>
<%
/* ----------------------------------------------------------------------------------------------------
Nombre de JSP: ticket.jsp
Función      : Formato para imprimir el Ticket de Salida de una receta emitida por Farmacia, muestra
               lote y caducidades, según la dispensación
   ---------------------------------------------------------------------------------------------------- */
//Conexión a la BDD vía JDBC	
Class.forName("org.gjt.mm.mysql.Driver");

Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset = null;
// fin conexión -----------------------------------				  

String des_ubi = "", fol_rec = "", fec_car="", hor_car="", cla_uni = "", nom_pac = "", sexo="", num_afi="", des_fin ="", des_ori ="", nombre="", des_tip="";
rset = stmt.executeQuery("SELECT t.des_tip, u.des_uni, r.fol_rec, bi.fec_carga, u.cla_uni, pa.nom_pac, pa.sexo, pa.num_afi, bi.fec_carga, f.des_fin, o.des_ori, p.cla_pro, p.des_pro, DP.lot_pro, dp.cad_pro, us.nombre FROM UNIDADES U, municipios M, usuarios US, receta R, detreceta DR, detalle_productos DP, productos P, origen O, pacientes pa, bitacora bi, financiamientos f, tipo_receta t where  m.cla_mun = u.cla_mun AND u.cla_uni = US.cla_uni and us.id_usu = r.id_usu AND r.id_rec = dr.id_rec and dr.det_pro = DP.det_pro AND dp.cla_pro = p.cla_pro AND DP.id_ori = o.id_ori and r.num_afi = pa.num_afi AND r.id_rec = bi.id_rec AND r.id_tip = t.id_tip and dp.cla_fin = f.cla_fin AND r.fol_rec = '"+request.getParameter("fol_rec")+"' group by r.fol_rec;");

while (rset.next()){
	des_ubi=rset.getString("des_uni");
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
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: Ticket de Salida ::</title>
<style type="text/css">
<!--
.style5 {font-family: Arial, Helvetica, sans-serif; font-size: 12; }
.style6 {font-size: 12}
.style7 {	font-size: 12px;
	font-weight: bold;
}
.style8 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
}
-->
</style>
</head>

<body>
<table width="384" height="490"  border="3" align="left" cellpadding="2">
  <tr>
    <td width="372" height="92"><table width="370" border="0" cellpadding="2">
      <tr>
        <td width="362" class="style7"><div align="center"><strong><span class="style5"><a href="menu_mod_rf.jsp?cla_uni=<%=request.getParameter("cla_uni")%>&id_usu=<%=request.getParameter("id_usu")%>">*</a>SAVI DISTRIBUCIONES  S.A DE C.V.* </span></strong></div></td>
      </tr>
      <tr>
        <td class="style7"><div align="center"><strong><span class="style5">AV. MAGNOCENTRO No. 11, PISO 5<br /> COL. CENTRO URBANO HUIXQUILUCAN

 </span></strong><strong><span class="style5"></span></strong></div></td>
      </tr>
      <tr>
        <td class="style7"><div align="center">ESTADO DE M&Eacute;XICO, C.P. 52760 </div></td>
      </tr>
      
      <tr>
        <td class="style7"><div align="center"><%=des_ubi%></div></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="254"><table width="370" border="0" cellpadding="2">
      <tr>
	  
        <td width="364"><div align="right" class="style6 style8">FECHA DE VENTA:&nbsp;&nbsp; &nbsp;  </div></td>
      </tr>
	  
      <tr>
        <td><table width="364" border="0" cellpadding="2">
          <tr>
            <td width="196" class="style8">FOLIO:              <%=des_tip%>&nbsp;-&nbsp;<%=cla_uni%>&nbsp;-&nbsp;<%=fol_rec%></td>
            <td width="77" class="style8"><%=fec_car%></td>
            <td width="71" class="style8">
              <%=hor_car%></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><span class="style8">CLIENTE:
           <%=nom_pac%></span></td>
      </tr>
      <tr>
        <td class="style8">SUB-CLIENTE: 
          SERVICIOS DE SALUD DE NAYARIT</td>
      </tr>
      
      <tr>
        <td class="style8"><table width="352" border="0" cellpadding="2">
          <tr>
            <td width="89" class="style8">BENEFICIARIO:</td>
            <td width="249" class="style8"><%=nom_pac%></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td class="style8">SEXO: <%=sexo%> </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td class="style8">FOLIO REFERENCIA: 
              <%=num_afi%></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td class="style8">RECETA: 
              <%=fol_rec%></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td class="style8">FECHA DE RECETA: 
              <%=fec_car%></td>
          </tr>
		  
          <tr>
            <td class="style8">PROGRAMA:</td>
            <td class="style8">SP<%//=rset4.getString("fuente")%></td>
          </tr>
          <tr>
            <td class="style8">SUB-PROGRAMA:</td>
            <td class="style8">SP<%//=rset4.getString("fuente")%></td>
          </tr>
          
        </table></td>
      </tr>

    </table></td>
  </tr>
 
  <tr>
    <td height="25"><table width="375" border="0" cellpadding="2">
      <tr>
        <td width="263" class="style8">DESCRIPCION</td>
        <td width="52" class="style8"><div align="center">CANTIDAD</div></td>
        <td width="40" class="style8"><div align="center">ORIGEN</div></td>
		
      </tr>
	   <%
  
rset = stmt.executeQuery("SELECT u.des_uni, r.fol_rec, bi.fec_carga, u.cla_uni, pa.nom_pac, pa.sexo, pa.num_afi, bi.fec_carga, f.des_fin, o.des_ori, p.cla_pro, p.des_pro, DP.lot_pro, dp.cad_pro, us.nombre, dr.can_sol, dr.cant_sur FROM UNIDADES U, municipios M, usuarios US, receta R, detreceta DR, detalle_productos DP, productos P, origen O, pacientes pa, bitacora bi, financiamientos f where  m.cla_mun = u.cla_mun AND u.cla_uni = US.cla_uni and us.id_usu = r.id_usu AND r.id_rec = dr.id_rec and dr.det_pro = DP.det_pro AND dp.cla_pro = p.cla_pro AND DP.id_ori = o.id_ori and r.num_afi = pa.num_afi AND r.id_rec = bi.id_rec AND dp.cla_fin = f.cla_fin AND r.fol_rec = '"+request.getParameter("fol_rec")+"' and dr.cant_sur!='0' and dr.baja = '0' ;");

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
     	<td height="21" class="style8"><%=cla_pro%> - <%=des_pro%></td>
        <td class="style8" align="center"><%=can_sur%></td>
        <td height="21" class="style8" align="center"><%=des_ori%></td>
		
			<td class="style8" align="center">Caja</td>
		
      </tr>
       <tr>
     	<td height="21" class="style8">LOTE:&nbsp;<%=lot_pro%> - CADUCIDAD:&nbsp;<%=cad_pro%></td>
        <td class="style8" align="center">&nbsp;</td>
        <td height="21" class="style8" align="center">&nbsp;</td>
		
			<td class="style8" align="center"></td>
		
      </tr>
<%
}
%>
    </table></td>
  </tr>
  
  <tr>
    <td height="77"><table width="369" border="0" cellpadding="2">
      <tr>
        <td width="361"></td>
      </tr>
      <tr>
        <td class="style8"><div align="center">FIRMA DE RECIBIDO </div></td>
      </tr>
     
      <tr>
        <td class="style8">ENCARGADO(A): 
          <%=nombre%></td>
      </tr>
      <tr>
        <td class="style8">FECHA DE IMPRESION: 
          <%=(df2.format(new Date()))%>&nbsp;-&nbsp;<%=df3.format(new Date())%></td>  
		   <td class="style8" align="center">&nbsp;</td>
		  
      </tr>
      <tr>
        <td class="style8" align="center"><img src="cb/<%=request.getParameter("fol_rec")%>.png"  /></td>
        <td class="style8" align="center">&nbsp;</td>
      </tr>
      
    </table></td>
  </tr>
  
</table>
<%
                 con.close();
	  
%>
</body>
</html>
