<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query.Filter" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
 <link rel="stylesheet" href="/css/tweet.css">
</head>
<body>
<div class="topnav">
  <a href="tweet.jsp">Tweet</a>
  <a href="friendstweet.jsp">Friends</a>
  <a  id=toptweet>Top Tweet</a>
  <a href="#about">About</a>
  <div id="fb-root"></div>
  <div align="right">
  <div class="fb-login-button" data-max-rows="1"    data-size="large" data-button-type="login_with" data-show-faces="false" data-auto-logout-link="true"  data-use-continue-as="true" scope="public_profile,email" onlogin="checkLoginState();"></div>
  </div>
  </div>
<%
try{
	DatastoreService ds=DatastoreServiceFactory.getDatastoreService();

Entity e=new Entity("tweet");

//Key k=KeyFactory.createKey("tweet", request.getParameter("id"));
//Key k=KeyFactory.stringToKey(request.getParameter("id"));
//out.println(k);
//out.println(temp.getId());
//Filter filter = new FilterPredicate("ID/Name",FilterOperator.EQUAL,request.getParameter("id"));
//out.println(filter.toString());
Query q=new Query("tweet");
//out.println(q.toString());
PreparedQuery pq = ds.prepare(q);
long visited_count=0;
for (Entity result : pq.asIterable()) {
   	  String first_name = (String) result.getProperty("first_name");
	  String lastName = (String) result.getProperty("last_name");
	  String picture = (String) result.getProperty("picture");
	  String status = (String) result.getProperty("status");
	  Long id = (Long) result.getKey().getId();
	  String time = (String) result.getProperty("timestamp");
	  visited_count = (Long)((result.getProperty("visited_count")));
	  Key k= result.getKey();
	  if(id==Long.parseLong(request.getParameter("id"))){
	 // out.println(result.getKey().getId()+" "+first_name + " " + lastName + ", " + picture + " "+visited_count);
	  Entity s=ds.get(KeyFactory.createKey("tweet", id));
	  s.setProperty("visited_count", visited_count+1);
	//  out.println("check"+s.getProperty("visited_count"));
	  ds.put(s);
	  out.println("<h1>Status of "+ s.getProperty("first_name")+" "+s.getProperty("last_name")+"</h1>");
	  out.println("<table frame=box>");
	 // out.println("<tr><td><div style="+"height: 50px; width:50px>"+picture+"</div><td>");
	  out.println("<td><div id=name>"+ first_name+" "+lastName +"</div></td>");
	  out.println("<tr><h3><div id=status> "+s.getProperty("first_name")+" said "+status +"</div></h3></tr>");
	  out.println("<tr><div id=postedate>Posted at:"+ time +"</div></tr>");
	  out.println("</table>");
	  }
	}
}catch(Exception e){
	out.println(e);
}
%>
</body>
<script type="text/javascript">
console.log("validate");
</script>
</html>