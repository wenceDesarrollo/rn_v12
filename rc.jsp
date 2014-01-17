<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" 
import="java.text.ParseException" import="java.text.DecimalFormat" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date" errorPage="" import ="java.awt.image.BufferedImage" import ="java.io.*" import ="javax.imageio.ImageIO" import ="net.sourceforge.jbarcodebean.*" import ="net.sourceforge.jbarcodebean.model.*" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("yyMMddhhmmss"); %>
<% 
/* ----------------------------------------------------------------------------------------------------
Nombre de JSP: rc.jsp
Función      : Valida Claves por fuente de financiamiento, muestra datos del insumo a guardar ,guarda datos 
               de la receta colectiva, pantalla principal para guardar una RC. 
   ---------------------------------------------------------------------------------------------------- */
//  Conexión a la BDD -------------------------------------------------------------
Class.forName("org.gjt.mm.mysql.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Statement stmt = con.createStatement();
ResultSet rset= null;
Statement stmt2 = con.createStatement();
ResultSet rset2= null;
JBarcodeBean barcode = new JBarcodeBean();
// fin objetos de conexión ------------------------------------------------------
// fin proceso Imprimir
String fol_rec =request.getParameter("txtf_foliore");
String servicio =request.getParameter("txtf_servicio");
String encargado=request.getParameter("txtf_encarser");
String but = request.getParameter("submit");
String cla_uni="";

rset = stmt.executeQuery("SELECT cla_uni from usuarios where ID_USU = '"+request.getParameter("id_usu")+"'");
while(rset.next()){
		cla_uni=(rset.getString("cla_uni"));
}
if (fol_rec==null){
	fol_rec=df3.format(new Date())+request.getParameter("id_usu");
	servicio="";
	encargado="";
}


if (but!=null){
	if (but.equals("Clave")||but.equals("Ver")){
		try{
				 barcode.setCode(fol_rec);
				 barcode.setCheckDigit(true);
				 BufferedImage bufferedImage = barcode.draw(new BufferedImage(100, 100, BufferedImage.TYPE_INT_RGB));
				 File file = new File("C://Program Files (x86)/Apache Group/Tomcat 4.1/webapps/rn_v12/cb/"+fol_rec+".png");
				 ImageIO.write(bufferedImage, "png", file);	
		}catch (Exception e) {}
        try{
            int ban = 0;
			String id_ser="";
			rset = stmt.executeQuery("select id_ser from servicios where nom_ser = '"+request.getParameter("txtf_servicio")+"' ");
            while (rset.next()){
                id_ser = rset.getString(1);
            }
            rset = stmt.executeQuery("select id_rec from receta r, usuarios u where r.fol_rec = '"+fol_rec+"' and r.id_tip = '2' and r.id_usu = u.id_usu and u.cla_uni = '"+cla_uni+"' ");
            while (rset.next()){
                ban = 1;
            }
            if (ban==0){
                stmt.execute("insert into receta values ('0', '"+fol_rec+"', '-', '-', '2', '"+request.getParameter("id_usu")+"', '1', '"+encargado+"','-', '0', '0', '"+id_ser+"')");
                rset = stmt.executeQuery("select id_rec from receta r, usuarios u where r.fol_rec = '"+fol_rec+"' and r.id_tip = '2' and r.id_usu = u.id_usu and u.cla_uni = '"+cla_uni+"' ");
                while (rset.next()){
                        stmt2.execute("insert into bitacora values('0', '"+rset.getString("id_rec")+"', NOW(), '0')");
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
					rset2 = stmt2.executeQuery("select id_rec from receta r, usuarios u where r.fol_rec = '"+fol_rec+"' and r.id_tip = '2' and r.id_usu = u.id_usu and u.cla_uni = '"+cla_uni+"' ");
					while (rset2.next()){
						id_rec = rset2.getString("id_rec");
					}
					if(sol <= 0){
						if (sol == 0 ){
							stmt2.execute("update inventario set cant = '0', web = '0' where id_inv = '"+rset.getString("id_inv")+"' ");
							sur = Integer.parseInt(rset.getString("cant"));
							stmt2.execute("insert into detreceta values ('0', '"+rset.getString("det_pro")+"', '"+request.getParameter("txtf_sol1")+"', '"+sur+"', '"+df.format(df2.parse(request.getParameter("txtf_date1")))+"', '1', '"+id_rec+"', CURTIME(), '0', '0' ) ");
							stmt2.execute("insert into kardex values ('0', '"+id_rec+"', '"+rset.getString("det_pro")+"', '"+sur+"', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA COL', '"+request.getParameter("id_usu")+"', '0')");
						}
						if (sol < 0 ){
							stmt2.execute("update inventario set cant = '"+(-1*sol)+"', web = '0' where id_inv = '"+rset.getString("id_inv")+"' ");
							sur = sol*-1;
							stmt2.execute("insert into detreceta values ('0', '"+rset.getString("det_pro")+"', '"+(sol1)+"', '"+(sol1)+"', '"+df.format(df2.parse(request.getParameter("txtf_date1")))+"', '1', '"+id_rec+"', CURTIME(), '0', '0' ) ");
							stmt2.execute("insert into kardex values ('0', '"+id_rec+"', '"+rset.getString("det_pro")+"', '"+sol1+"', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA COL', '"+request.getParameter("id_usu")+"', '0')");
						}
						break;
					}
					stmt2.execute("insert into detreceta values ('0', '"+rset.getString("det_pro")+"', '"+rset.getString("cant")+"', '"+rset.getString("cant")+"', '"+df.format(df2.parse(request.getParameter("txtf_date1")))+"', '1', '"+id_rec+"', CURTIME(), '0', '0' ) ");                    
					stmt2.execute("insert into kardex values ('0', '"+id_rec+"', '"+rset.getString("det_pro")+"', '"+rset.getString("cant")+"', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA COL', '"+request.getParameter("id_usu")+"', '0')");
					stmt2.execute("update inventario set cant = '0', web = '0' where id_inv = '"+rset.getString("id_inv")+"' ");
				}
            }
            } catch (Exception e) {out.println(e.getMessage());}
            if (sol>0){
                rset = stmt.executeQuery("select id_rec from receta r, usuarios u where r.fol_rec = '"+fol_rec+"' and r.id_tip = '2' and r.id_usu = u.id_usu and u.cla_uni = '"+cla_uni+"' ");
                while (rset.next()){
                    id_rec = rset.getString("id_rec");
                }
                stmt2.execute("insert into detreceta values ('0', '"+det_pro+"', '"+sol+"', '0', '"+df.format(df2.parse(request.getParameter("txtf_date1")))+"', '0', '"+id_rec+"', CURTIME(), '0', '0' ) ");
                stmt2.execute("insert into kardex values ('0', '"+id_rec+"', '"+det_pro+"', '0', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA COL', '"+request.getParameter("id_usu")+"', '0')");
            }
        } catch (Exception e) {out.println(e.getMessage());}
    }
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="css/cupertino/jquery-ui-1.10.3.custom.css" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.: Receta Colectiva Fecha Autom&aacute;tica :.</title>
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
	if (document.form.txtf_t1.value=="")
			{
			document.form.txtf_t1.focus();
			}	
	else	
	if (document.form.txtf_t3.value!="")
	{
		if (document.form.txtf_descrip1.value==""){
			document.form.txtf_servicio.focus();
			window.scrollTo(100,600);
		}
		else{
			if (document.form.txtf_med1.value==""){
			document.form.txtf_med1.focus();
			window.scrollTo(100,400);
			}
			else{
				document.form.txtf_sol1.focus();
				window.scrollTo(100,400);
			}
			
		}
	}
	else{
		document.form.txtf_t1.focus();
	}
	
				location.href='#ancla1';
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
.Estilo6 {
	color: #000000;
	font-size: 16;
	font-weight: bold;
}
.Estilo7 {color: #003399}
.style2 .style11 h4 strong {
	color: #A00;
}
-->
</style>
</head>

<body onLoad="foco_inicial();mueveReloj();">
<form name="form" method="post" action="rc.jsp?tipo=<%=request.getParameter("tipo")%>&id_usu=<%=request.getParameter("id_usu")%>">
<table width="957" height="562" border="3" align="center" cellpadding="2">
  <tr>
    <td width="725" height="156"><table width="860" border="0" align="center" cellpadding="2">
      <tr>
        <td width="114"><img src="imagenes/nay_ima1.jpg" width="203" height="78" /></td>
        <td width="339"><div align="center"><span class="style7">SERVICIO DE SALUD DE NAYARIT<br />
        RECETA COLECTIVA</span>*</div></td>
        <td width="225"><div align="center"><img src="imagenes/ssn.jpg" width="219" height="89" /></div></td>
      </tr>
    </table>
      <a href="index.jsp">Regresar a Menu</a>
      <table width="763" height="61" border="0" align="center" cellpadding="2">
        <tr>
          <td width="284" height="55"><label></label>
            <table width="270" height="0%" border="0" cellpadding="2">
              <tr>
                <td width="221" height="100%" class="style2">FECHA:
                <%
												if(request.getParameter("txtf_date1")==null){
													%>
                                                    <input name="txtf_date1" id="cadu" type="text" size="20" value="<%=df2.format(new Date())%>" onKeyUp="putFecha(this.form)" onKeyPress="return handleEnter(this, event)" readonly/>
                                                    <%
												}
												else{
													%>
                                                    <input name="txtf_date1" id="cadu" type="text" size="20" value="<%=(request.getParameter("txtf_date1"))%>" onKeyUp="putFecha(this.form)" onKeyPress="return handleEnter(this, event)" readonly/>
                                                    <%
												}
												%>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>       
              </tr>
            </table>
          <label>          </label></td>
          <td width="250"><table width="167" height="0%" border="0" cellpadding="2">
            <tr>
              <td width="225" height="100%" class="style2">&nbsp;</td>
            </tr>
          </table>          
            <label></label></td>
          <td width="172" align="center" class="style2"> No. Folio
            <table width="152" height="0%" border="0" align="right" cellpadding="2">
            <tr>
              <td width="144" height="100%"><label>
                <input type="text" name="txtf_foliore" size="20" class="Estilo5"  value="<%=fol_rec%>" readonly/>
              </label></td>
            </tr>
          </table></td>
        </tr>
    </table>    </td>
  </tr>
        <tr>
          <td height="71" colspan="3" class="style4"><table width="784" border="0" align="center" cellpadding="2">
            <tr>
              <td height="2" colspan="3" class="style4"><div id="item7" style="display:none" align="justify" ><span class="style2">
            <input name="txtf_date1" type="text" size="20" value="" onKeyPress="return handleEnter(this, event)" readonly/>
          </span></div></td>
            </tr>
            <%
			rset = stmt.executeQuery("SELECT US.CLA_UNI, U.DES_UNI, US.nombre FROM USUARIOS US, UNIDADES U WHERE U.CLA_UNI = US.CLA_UNI AND US.ID_USU = '"+request.getParameter("id_usu")+"'");
            while(rset.next()){
			%>
            <tr>
              <td width="411" class="style2">UNIDAD DE SALUD&nbsp;</td>
              <td width="359"><table width="170" border="0" align="left" cellpadding="2">
                <tr>
                  <td width="162" align="center"><div align="center" class="style2">ELABOR&Oacute; COLECTIVO:</div></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td colspan="2"><textarea name="txtf_unidadmed" cols="40" class="Estilo5" colspan="3" readonly><%=rset.getString("DES_UNI")%></textarea>
                <label>
                <textarea name="txtf_ela" cols="35"  class="Estilo5" readonly><%=rset.getString("nombre")%></textarea>
              </label></td>
            </tr>
            <%
			}
			%>
          </table>
		  
		  </td>
        </tr>
        <tr>
		<td height="241">
		<table width="939" border="0" align="center" cellpadding="2">
            
            <tr>
              <td width="136" class="style2">Tipos de Servicios:&nbsp;&nbsp; </td>
              <td width="365" class="style11"><span class="style2">
                <select name="select_servi"  class="style2" onChange="Servi_col(this.form)" onkeypress="return document.form.txtf_med1.focus();">
                  <option selected="selected">-----Seleccione Tipo de Servicio-----</option>
                <%
			rset = stmt.executeQuery("SELECT ID_SER, NOM_SER FROM SERVICIOS");
            while(rset.next()){
			%>
            <option value='<%=rset.getString("NOM_SER")%>'><%=rset.getString("NOM_SER")%></option>
            <%
			}
			%>
                </select>
              </span></td>
              <td width="176" class="style11">&nbsp;</td>
              <td class="style11"><input type="text" name="txtf_resul" size="20" value="" style="visibility:hidden"/></td>
            </tr>
            <%
			if (servicio==null){
				rset = stmt.executeQuery("select r.enc_ser, s.nom_ser from receta r, servicios s where r.id_ser = s.id_ser and r.fol_rec = '"+request.getParameter("txtf_foliore")+"' and r.id_usu = '"+request.getParameter("id_usu")+"' ");
				while (rset.next()){
					servicio = rset.getString("nom_ser");
					encargado = rset.getString("enc_ser");
				}
			}
			%>
            <tr>
              <td class="style2">Servicio:</td>
              <td class="style11"><span class="style2">
                <input type="text" name="txtf_servicio" class="style2" size="30" value="<%=servicio%>" readonly />
              </span></td>
              <td class="style11">&nbsp;</td>
              <td class="style11">&nbsp;</td>
            </tr>
            <tr>
              <td class="style2">Encargado del Servicio: </td>
              <td class="style11"><span class="style2">
                <input type="text" name="txtf_encarser" id="txtf_encarser" class="style2" size="60" value="<%=encargado%>" onChange="mayeE(this.form)" onKeyPress="return handleEnter(this, event)" />
              </span></td>
              <td class="style11">&nbsp;</td>
              <td class="style11">&nbsp;</td>
            </tr>
            <tr>
              <td class="style2">Ingrese Clave:</td>
              <td colspan="2" class="style11"><span class="style2">
                <input type="text" name="txtf_med1" size="20" value="" onChange=""/>
              </span><span class="style2">
              <input name="submit" type="submit" class="but" value="Clave" onClick="getfocus()"/>
              </span><a href="index_carga_clave.jsp?id_usu=<%=request.getParameter("id_usu")%>" target="_blank">Agregar Clave</a>| <a href="existencias.jsp?id_usu=<%=request.getParameter("id_usu")%>" target="_blank">Ver Existencias</a></td>
              <td width="236" class="style11">&nbsp;</td>
            </tr>
            <tr>
              <td class="style11">Ingrese descripci&oacute;n:                </td>
              <td colspan="3" class="style11"><input type="text" name="txtf_descmed" size="80" value="" onKeyPress="return handleEnter(this, event)" />
              <input name="submit" type="submit" class="but" value="Por Descripción" onClick="getfocus()"/></td>
            </tr>
            <tr>
              <td class="style11">Seleccione Descripci&oacute;n:                &nbsp;&nbsp;&nbsp;</td>
              <td class="style11">
              <select name="select_servi2" size="1"  class="style2"  onkeypress="return document.form.txtf_med1.focus();">
                <option selected="selected">-----Seleccione Descripción-----</option>
              <%
			  rset = stmt.executeQuery("select cla_pro, des_pro from productos where des_pro like '%"+request.getParameter("txtf_descmed")+"%'");
			  while(rset.next()){
					out.println("<option value = '"+rset.getString("cla_pro")+"'>"+rset.getString("des_pro")+"</option>");
			  }
			  %>
                
              </select>
              <input name="submit" type="submit" class="but" value="Ver" onClick="getfocus()"/></td>
              <td class="style11">&nbsp;</td>
              <td class="style11">&nbsp;</td>
            </tr>
            <tr>
              <td colspan="4"><hr /></td>
            </tr>
            <tr>
              <td colspan="4">
              <table width="875" border="0" align="center" cellpadding="2">
            
           <tr class="style2">
    <td colspan="4" class="style11" align="center"><h4><strong>CAPTURAR CANTIDAD SOLICITADA</strong></h4></td>
               <td colspan="5" class="style11"><span class="style2"><span class="Estilo8">TOTAL EXISTENCIAS:</span><span class="Estilo5"> *<br />
               <%
			   int ban_cla=0;
				String clave="", descr="", fuente = "", cantidad = "0", det_pro="";
				rset = stmt.executeQuery("SELECT DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, sum(I.cant) as cant, DP.cla_fin FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla_pro = '"+request.getParameter("txtf_med1")+"' AND US.id_usu='"+request.getParameter("id_usu")+"' and DP.id_ori='1' GROUP BY P.cla_pro ORDER BY DP.cad_pro, I.cant ASC ;");
				rset2 = stmt2.executeQuery("SELECT DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, sum(I.cant) as cant, DP.cla_fin FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla_pro = '"+request.getParameter("txtf_med1")+"' AND US.id_usu='"+request.getParameter("id_usu")+"' and DP.id_ori='1' GROUP BY P.cla_pro ORDER BY DP.cad_pro, I.cant ASC ;");
				
				
				if (but!=null){
					if (but.equals("Ver")){
						rset = stmt.executeQuery("SELECT DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, sum(I.cant) as cant, DP.cla_fin FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla_pro = '"+request.getParameter("select_servi2")+"' AND US.id_usu='"+request.getParameter("id_usu")+"' and DP.id_ori='1' GROUP BY P.cla_pro ORDER BY DP.cad_pro, I.cant ASC ;");
                        rset2 = stmt2.executeQuery("SELECT DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, sum(I.cant) as cant, DP.cla_fin FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla = '"+request.getParameter("select_servi2")+"' AND US.id_usu='"+request.getParameter("id_usu")+"' and DP.id_ori='2' GROUP BY P.cla_pro ORDER BY DP.cad_pro, I.cant ASC ;");
					}
					if (but.equals("Clave")) {
						rset = stmt.executeQuery("SELECT DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, sum(I.cant) as cant, DP.cla_fin FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla_pro = '"+request.getParameter("txtf_med1")+"' AND US.id_usu='"+request.getParameter("id_usu")+"' and DP.id_ori='1' GROUP BY P.cla_pro ORDER BY DP.cad_pro, I.cant ASC ;");
						rset2 = stmt2.executeQuery("SELECT DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, sum(I.cant) as cant, DP.cla_fin FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla_pro = '"+request.getParameter("txtf_med1")+"' AND US.id_usu='"+request.getParameter("id_usu")+"' and DP.id_ori='2' GROUP BY P.cla_pro ORDER BY DP.cad_pro, I.cant ASC ;");
                    }
				}
				while(rset.next()){
					clave = rset.getString("cla_pro");
					descr = rset.getString("des_pro");
					cantidad = rset.getString("cant");
					fuente = rset.getString("cla_fin");
					det_pro = rset.getString("det_pro");
					ban_cla=1;
				}
				%>
                Origen 1=<%=cantidad%>&nbsp;
                <%
				cantidad="0";
				ban_cla=0;
				while(rset2.next()){
					clave = rset2.getString("cla_pro");
					descr = rset2.getString("des_pro");
					cantidad = rset2.getString("cant");
					fuente = rset2.getString("cla_fin");
					det_pro = rset2.getString("det_pro");
					ban_cla=1;
				}
               %>
               Origen 2=<%=cantidad%>
               <%
				if (ban_cla==0&&but!=null&&but.equals("Clave")){
					%>
					<script>
					alert('Insumo sin existencia');
					</script>
					<%
				}
				%>
               </span></span></td>
              <td colspan="2" class="style11"><label>
                <div align="center">
                  
                </div>
                
              </label></td>
      </tr>
      <tr>
        <td width="70" class="style11"><span class="letras"><span class="style2">CLAVE</span></span></td>
              <td colspan="2" class="style11"><span class="letras"><span class="style2">DESCRIPCI&Oacute;N</span></span></td>
              <td width="68" class="style11"><span class="letras"><span class="style2">CANT SOL</span></span></td>
              <td colspan="2" class="style11"><span class="letras"><span class="style2">CANT SUR</span></span></td>
              <td colspan="3" class="style11">&nbsp;</td>
              <td colspan="2" class="style11">&nbsp;</td>
            </tr>
            <%
			
			%>
            <tr>
              <td class="style11"><input type="text" name="txtf_clave1" size="10" class="style2" value="<%=clave%>"  readonly="true"/></td>
              <td colspan="2" class="style11"><textarea name="txtf_descrip1" cols="50"  class="style2" readonly><%=descr%></textarea></td>
              <td class="style11"><input type="text" name="txtf_sol1" id="txtf_sol1" size="5" value="" onKeyPress="return handleEnter(this, event)"  /></td>
              <td colspan="2" class="style11"><input type="text" name="txtf_sur1" size="5" value="0"  onchange="setSur(this.form)" onKeyPress="return handleEnter(this, event)" readonly/></td>
              <td colspan="3" class="style11"><div align="center">&nbsp;</div></td>
              <td colspan="2" class="style11">&nbsp;
              
              <input name="submit" type="submit" id="capturaid" class="but" value="Capturar" onClick="return verifica_RC(document.forms.form);" onChange="setSur(this.form)"/></td>
             <tr class="letras">
              <td colspan="9" class="style11"><hr /></td>
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
                            rset = stmt.executeQuery("SELECT dr.fol_det, p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, dr.can_sol, dr.cant_sur, dr.status, o.des_ori from productos p, detalle_productos dp, detreceta dr, receta r, origen o where p.cla_pro = dp.cla_pro and dp.det_pro = dr.det_pro AND dr.id_rec = r.id_rec AND dp.id_ori = o.id_ori AND dr.baja='0' and r.fol_rec = '"+request.getParameter("txtf_foliore")+"' ;");
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
                                    <a href = "eliminar_rc.jsp?fol_det=<%=rset.getString("fol_det")%>&id_usu=<%=request.getParameter("id_usu")%>&txtf_foliore=<%=fol_rec%>">Eliminar</a>
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
                                    <a href="ticket_c.jsp?fol_rec=<%=fol_rec%>&id_usu=<%=request.getParameter("id_usu")%>&tipo=<%=request.getParameter("tipo")%>">Imprimir</a>
                                  </p>
                                    </div>
                                </td>
              </tr>
    <tr class="letras">
              <td colspan="9" class="style11"><hr /></td>
            </tr>
    
        </table>
              </td>
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

<script src="jqry/jquery-1.9.1.js"></script>
<script src="jqry/jquery-ui-1.10.3.custom.js"></script>
<script>

	function foco_inicial() {
                
				location.href='#ancla1'
				document.form.select_servi.focus()
				if (document.form.txtf_encarser.value != "") {
                    document.form.txtf_med1.focus()
                }
				
				if (document.form.txtf_clave1.value != "") {
                    document.form.txtf_sol1.focus()
                }
				
				if (document.form.txtf_nomed.value != "") {
                    document.form.txtf_med1.focus()
                }
				
				if (document.form.txtf_clave1.value != "") {
					document.form.txtf_sol1.value=""
                    document.form.txtf_sol1.focus()
                }

            }


    $(function() {
        $("#cadu").datepicker({dateFormat: "dd/mm/yy"}).val()
    });
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
<%
con.close();
%>