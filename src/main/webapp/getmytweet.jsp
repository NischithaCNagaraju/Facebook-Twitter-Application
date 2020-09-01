<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page
	import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<%@ page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@ page
	import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@ page
	import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery"%>
<%@ page import="com.google.appengine.api.datastore.Query.SortDirection"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/css/tweet.css">
<script type="text/javascript" src="/js/tweet.js"></script>
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
		<a href="friendstweet.jsp">Friends</a> 
		<a id=toptweet href="toptweet.jsp">Top Tweet</a>
	   <a href="#about">About</a>
		<div id="fb-root"></div>
		<div align="right">
			<div class="fb-login-button" data-max-rows="1" data-size="large"
				data-button-type="login_with" data-show-faces="false"
				data-auto-logout-link="true" data-use-continue-as="true"
				scope="public_profile,email" onlogin="checkLoginState();"></div>
		</div>
	</div>


</body>
</html>

<%
	DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
	Entity e = new Entity("tweet");
	Query q = new Query("tweet");
	PreparedQuery pq = ds.prepare(q);
	int count = 0;
	for (Entity result : pq.asIterable()) {
		if (result.getProperty("user_id") != null
				&& ((result.getProperty("user_id")).equals(request.getParameter("user_ids")))) {
			//out.println(result.getProperty("first_name")+" "+request.getParameter("name"));
			String first_name = (String) result.getProperty("first_name");
			count++;
			String lastName = (String) result.getProperty("last_name");
			String user_id = (String) result.getProperty("user_id");
			String picture = (String) result.getProperty("picture");
			String status = (String) result.getProperty("status");
			Long id = (Long) result.getKey().getId();
			String time = (String) result.getProperty("timestamp");
			Long visited_count = (Long) ((result.getProperty("visited_count")));
			StringBuffer sb = new StringBuffer();
			String url = request.getRequestURL().toString();
			String baseURL = url.substring(0, url.length() - request.getRequestURI().length())
					+ request.getContextPath() + "/";
			sb.append(baseURL + "direct_tweet.jsp?id=" + id);
%>

<table>
	<tr>
		<td><div style="height: 100px; width: 100px">
				<%=picture%></div>
		<td>
		<td>User: <%=first_name + " " + lastName%>
		</td>
	</tr>
	<div>
		<tr>
			<td><br>
			<br>Status: <%=status%></td>
		</tr>
	<tr>
		<td>Posted at: <%=time%></td>
	</tr>
	<tr>
		<td>#Visited: <%=visited_count%></td>
	</tr>
	<tr>
		<form action="getmytweet.jsp" action="GET">
			<input type=hidden name=user_id id=user_id value=<%=user_id%> /> <input
				type=hidden name=u_id id=u_id value=<%=id%> />
			<td><button name="Delete" type="submit" class="button"
					value=Delete />Delete</button></td>
		</form>
		<div align="center">
			<div id="mypopup" class="popup">
				<div class="popup-content">
					<span class="close">&times;</span> 
					<script type="text/javascript">message="<%= sb  %>"</script>
					<button type="button"
						class="button" 
						onclick=shareMyTweet(message) > Share Tweet</button> 
					<button type="button" class="button"
						 name="send_direct_msg"
						onclick=sendmyDirectTweet(message) >Send Direct Message</button>
				</div>
			</div>
		</div>
		<td><button name="Share" type="button" class="button" id=share
				value=<%=sb%>  onclick=modalOpen(this) />share</td>
	</tr>
	<script type="text/javascript">
	function modalOpen(obj){
		console.log("inside"+obj.value);
	var modal = document.getElementById('mypopup');
	var btn = obj;
	var span = document.getElementsByClassName("close")[0];
	modal.style.display = "block";
	span.onclick = function() {
		modal.style.display = "none";
	};
	window.onclick = function(event) {
		if (event.target == modal) {
			modal.style.display = "none";
		}
	};
	}
	</script>
	</div>
</table>
<script type="text/javascript">

function shareMyTweet( message){
	FB.ui({method: 'share',
		href: message,
		//quote: document.getElementById('text_content').value,
		},function(response){
		if (!response || response.error)
		{
			console.log(response.error);
			alert('Posting error occured');
		}
	});
}

function sendmyDirectTweet(message){
	FB.ui({method:  'send',
		  link: message,});
	console.log(document.getElementById("status"));
}
</script>
<%
	Entity s = ds.get(KeyFactory.createKey("tweet", id));
			s.setProperty("visited_count", visited_count + 1);
			ds.put(s);
			//  count++;
		}
	}
	if (request.getParameter("u_id") != null) {
		Entity s = ds.get(KeyFactory.createKey("tweet", Long.parseLong(request.getParameter("u_id"))));
		//s.getKey();
		ds.delete(s.getKey());
		out.println("STATUS-->ID:" + Long.parseLong(request.getParameter("u_id")) + " deleted from GAE");
	}
%>
