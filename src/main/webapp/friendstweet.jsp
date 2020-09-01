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
<%@ page import="com.google.appengine.api.datastore.Query.SortDirection" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/css/tweet.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-164320664-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-164320664-1');
</script>

<title>Insert title here</title>
</head>
<body>
<div class="topnav">
  <a href="tweet.jsp">Tweet</a>
  <a href="friendstweet.jsp" style="background-color: green">Friends</a>
  <a  id=toptweet href="toptweet.jsp">Top Tweet</a>
  <div id="fb-root"></div>
  <div align="right">
  <div class="fb-login-button" data-max-rows="1"    data-size="large" data-button-type="login_with" data-show-faces="false" data-auto-logout-link="true"  data-use-continue-as="true" scope="public_profile,email" onlogin="checkLoginState();"></div>
  </div>
</div>

</body>
</html>

<%
	DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
	Entity e=new Entity("tweet");
	Query q=new Query("tweet");
	PreparedQuery pq = ds.prepare(q);
	int count=0;
	for (Entity result : pq.asIterable()) {
			  //out.println(result.getProperty("first_name")+" "+request.getParameter("name"));
			  String first_name = (String) result.getProperty("first_name");
			  String lastName = (String) result.getProperty("last_name");
			  String picture = (String) result.getProperty("picture");
			  String status = (String) result.getProperty("status");
			  Long id = (Long) result.getKey().getId();
			  String time = (String) result.getProperty("timestamp");
			  Long visited_count = (Long)((result.getProperty("visited_count"))); %>
			
			  
			   <table frame=box style="width: 100%;">
			  <tr><td><div style="height: 150px; width:150px; position: relative"> <%= picture %></div><td></tr>
			  <td><input type="button" value="User : " class="user_button"></input> <%= first_name+" "+lastName %> </td></tr>
			  <tr>
			  	<td><input type="button" value="Tweet : " class="user_button"></button> <%= status %></td>
			  </tr>
			  <tr>
			  	<td><input type="button" value="Posted at : " class="user_button"></input> <%=time %></td>
			  </tr>
			  <tr>
			  	<td><input type="button" value="#Visited : " class="user_button"></button> <%= visited_count %></td>
			  	</tr>
			  </table>
			  
			  <% Entity s=ds.get(KeyFactory.createKey("tweet", id));
			  s.setProperty("visited_count", visited_count+1);
			  ds.put(s);
			//  count++;
			  }
%>