<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.vote.service.*"%>
    <%@page import="java.util.*"%>
    <%@page import="com.google.gson.JsonObject" %>
<%
List listThead=null;
List< ArrayList<Float> > listContent=null;
String id = request.getParameter("oid");
System.out.println("oid=" + id);
int oid = Integer.parseInt(id);
session.setAttribute("oid", id);
listThead=ObjectBeanService.findThead(oid);

listContent=ObjectBeanService.average(oid);
%>
<!doctype html>
<html>
<head>
  <meta charset='utf-8'>
  <title>Date cell type - Handsontable</title>

  <link data-jsfiddle="common" rel="stylesheet" media="screen" href="dist/handsontable.css">
  <link data-jsfiddle="common" rel="stylesheet" media="screen" href="dist/pikaday/pikaday.css">
  <script data-jsfiddle="common" src="dist/pikaday/pikaday.js"></script>
  <script data-jsfiddle="common" src="dist/moment/moment.js"></script>
  <script data-jsfiddle="common" src="dist/zeroclipboard/ZeroClipboard.js"></script>
  <script data-jsfiddle="common" src="dist/handsontable.js"></script>
  <script data-jsfiddle="common" src="js/jquery-2.2.3.min.js"></script>
  <script data-jsfiddle="common" src="dist/jqueryHOT.js"></script>
  
  <link data-jsfiddle="common" rel="stylesheet" media="screen" href="css/samples.css">
  
  <script type="text/javascript">
  
  var tableContent=new Array();
  var jsonHead=new Array();
  var index;
  function getCarData() {
      return data = tableContent;
	
    };
  function getTheadData(){
    	return data=jsonHead;
   };
   
   
	$(document).ready(function(){

	<%
	System.out.println("zheli"+listThead);
	
	for(int k=0;k<listThead.size();k++){
		%>
		jsonHead.push( "<%=(String)listThead.get(k)%>" ) ;
		
	<% } %>
	//alert("jsonHead"+jsonHead);
	<%
	for(int i=0;i<listContent.size();i++){
		ArrayList<Float> array=listContent.get(i);
		JsonObject jobContent=new JsonObject();
		for(int j=0;j<array.size();j++){
			jobContent.addProperty( (String)listThead.get(j), 
					 array.get(j)  );
	%>
	<% } %>
	var temp=<%=jobContent %>;
	tableContent.push( temp );
	<% } %>
	
		var container = document.getElementById('example1'),hot;
		
        hot = new Handsontable(container, {
        	  colHeaders: getTheadData(),
			  data: getCarData(),
			  maxRows:tableContent.length,
			  rowHeaders: false,//标号
			  //minSpareRows: 1,//初始化行
			  //colHeaders: true,
			  columnSorting: true,sortIndicator:true,
			  
			  autoWrapCol:false,autoWrapRow:false,
			  
			  manualColumnResize: false,
			  manualRowResize: false,//stretchH: 'all',
			  //outsideClickDeselects: false,removeRowPlugin: true,
			  contextMenu: false,
			  comments: false,
			  readOnly: true,
			  //colWidths:[100,100,80,100,100,200,80],
		});
		
	});
  </script>
</head>

<body>
	
	<div id="example1" style="width:900px;"></div>
	<br/>
	<a href="excel.jsp?exportToExcel=YES">导出到Excel</a>
</body>
</html>
