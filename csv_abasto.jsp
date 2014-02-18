<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.io.*" import="com.csvreader.CsvReader" import="javax.swing.*" import="java.util.Date" import="java.text.SimpleDateFormat" import="java.util.*" errorPage="" %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%
// Conexion BDD via JDBC
Class.forName("org.gjt.mm.mysql.Driver"); 
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/receta_electronica","root","eve9397");
Connection con2 = DriverManager.getConnection("jdbc:mysql://189.197.187.15:3306/abastos","gnkl_rep","Avxkc4");
Statement stmt = con.createStatement();
ResultSet rset=null;

Statement stmt_d = con2.createStatement();
ResultSet rset_d=null;
// fin conexion --------

String ruta_split[];
int flag = 0;
String usuario_jv = request.getParameter("id_usu");
File[] roots = File.listRoots();
int existe_abasto = 0;
int pos = 0;

// ------------------------------------------------------------------
String ruta = "", car = "\\";
ruta = request.getParameter("archivo");
ruta = ruta.replace('\\', '/');
//Obtener el nombre del archivo------------------------------------------------------------------

int largo_ruta = 0;
String token = request.getParameter("token");//out.print(ruta);
try{
	StringTokenizer ruta_token = new StringTokenizer(ruta, "/");
	//out.print(ruta_token.lenght);
	while (ruta_token.hasMoreTokens()) {
			largo_ruta++;
			token = ruta_token.nextToken();
	}
} catch (Exception e) {out.println(e.getMessage());}
//------------------------------------------------------------------
int ban_invini=0;
try{
	rset = stmt.executeQuery("select id_inv from inventario_inicial");
	while (rset.next()) {
			ban_invini = 1;
			break;
	}
} catch (Exception e) {out.println(e.getMessage());}
//------------------------------------------------------------------
try{
	rset = stmt.executeQuery("select fol_aba from kardex where fol_aba='" + token + "'");
	while (rset.next()) {
			existe_abasto = 1;
			break;
	}
} catch (Exception e) {out.println(e.getMessage());}
if (existe_abasto == 1) {
%>
<script>alert('Abasto ya cargado con anterioridad')</script>
<script>location.href="index.jsp"</script>
<%
} else {
	try{
		int ban_err=0;
		CsvReader reader = new CsvReader(ruta);//ruta
		CsvReader reader_chk = new CsvReader(ruta);//ruta
		reader.setDelimiter(',');
		reader_chk.setDelimiter(',');
		while (reader_chk.readRecord()) {//inicio de while
				//out.print("imprime:"+contador_reg++);
				for (int x = 0; x < 6; x++) {
						if (reader_chk.get(x).equals("")) {
								ban_err = 1;
								break;
						}
						if (ban_err == 1) {
								break;
						}
				}
		}
		
		if (ban_err == 0) {
				while (reader.readRecord()) {
					try{
						String id_inv="", det_pro="";
						int tipo_en=0, c1=0, c2=0, c3=0;
						c2=Integer.parseInt(reader.get(4));
						
						rset=stmt.executeQuery("select p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, i.cant, i.id_inv, o.des_ori, dp.det_pro, dp.cla_fin FROM usuarios us, unidades u, inventario i, detalle_productos dp, productos p, origen o where  us.cla_uni = u.cla_uni and u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro and dp.cla_pro = p.cla_pro AND dp.id_ori = o.id_ori and us.id_usu = '"+request.getParameter("id_usu")+"' and p.cla_pro='"+reader.get(0)+"' and dp.lot_pro='"+reader.get(2)+"' and dp.cad_pro='"+df.format(df2.parse(reader.get(3)))+"' and o.id_ori = '"+reader.get(5)+"' and dp.cla_fin = '1'  ");
						while(rset.next()){
								tipo_en=1;
								id_inv=rset.getString("id_inv");
								det_pro=rset.getString("det_pro");
								c1=rset.getInt("cant");
						}
						c3=c1+c2;
						if (tipo_en==1){//Insumo existente
								stmt.execute("update inventario set cant = '"+c3+"', web = '0' where id_inv = '"+id_inv+"'");
								stmt.execute("insert into kardex values ('0', '0', '"+det_pro+"', '"+c3+"', 'ENTRADA POR AJUSTE', '"+token+"', NOW(), 'Entrada por abasto', '"+request.getParameter("id_usu")+"', '0')");
						} else {//Insumo inexistente
								String cla_uni="", detalle = "";
								stmt.execute("insert into detalle_productos values ('0', '"+reader.get(0)+"', '"+reader.get(2)+"', '"+df.format(df2.parse(reader.get(3)))+"', '1', '"+reader.get(5)+"', '0')");
								rset=stmt.executeQuery("select cla_uni from usuarios where id_usu = '"+request.getParameter("id_usu")+"' ");
								while(rset.next()){
										cla_uni=rset.getString("cla_uni");
								}
								rset=stmt.executeQuery("select det_pro from detalle_productos where cla_pro = '"+reader.get(0)+"' and lot_pro = '"+reader.get(2)+"' and cad_pro = '"+df.format(df2.parse(reader.get(3)))+"' and cla_fin = '1' and id_ori = '"+reader.get(5)+"' ");
								while(rset.next()){
										detalle=rset.getString("det_pro");
								}
								stmt.execute("insert into inventario values (NOW(), '"+cla_uni+"', '"+detalle+"', '"+reader.get(4)+"', '0', '0')");
								if (ban_invini==0){
									stmt.execute("insert into inventario_inical values (NOW(), '"+cla_uni+"', '"+detalle+"', '"+reader.get(4)+"', '0', '0')");
								}
								rset=stmt.executeQuery("select p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, i.cant, i.id_inv, o.des_ori, dp.det_pro FROM usuarios us, unidades u, inventario i, detalle_productos dp, productos p, origen o where  us.cla_uni = u.cla_uni and u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro and dp.cla_pro = p.cla_pro AND dp.id_ori = o.id_ori and us.id_usu = '"+request.getParameter("id_usu")+"' and p.cla_pro='"+reader.get(0)+"' and dp.lot_pro='"+reader.get(2)+"' and dp.cad_pro='"+df.format(df2.parse(reader.get(3)))+"' ");
								while(rset.next()){
										tipo_en=1;
										id_inv=rset.getString("id_inv");
										det_pro=rset.getString("det_pro");
										c1=rset.getInt("cant");
								}
								c3=c1+c2;
								stmt.execute("insert into kardex values ('0', '0', '"+det_pro+"', '"+c3+"', 'ENTRADA POR Abasto', '"+token+"', NOW(), 'ENTRADA POR Abasto', '"+request.getParameter("id_usu")+"', '0')");
						}
				}catch(Exception e){
					out.println("Clave Fuera de catalogo<br>");
					out.println("select p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, i.cant, i.id_inv, o.des_ori, dp.det_pro, dp.cla_fin FROM usuarios us, unidades u, inventario i, detalle_productos dp, productos p, origen o where  us.cla_uni = u.cla_uni and u.cla_uni = i.cla_uni AND i.det_pro = dp.det_pro and dp.cla_pro = p.cla_pro AND dp.id_ori = o.id_ori and us.id_usu = '"+request.getParameter("id_usu")+"' and p.cla_pro='"+reader.get(0)+"' and dp.lot_pro='"+reader.get(2)+"' and dp.cad_pro='"+df.format(df2.parse(reader.get(3)))+"' and o.id_ori = '"+reader.get(5)+"' and dp.cla_fin = '1'  <br>");
				}
			}
		}
	}catch(Exception e){out.println(e.getMessage());}
	try{
	stmt_d.execute("update abasto_unidades set Surtido = '1' where folio = '"+request.getParameter("folio")+"'");
	} catch(Exception e){}
	%>
	<script>alert('Abasto cargado con éxito')</script>
	<script>location.href="index.jsp"</script>
<%
}


con.close();
%>