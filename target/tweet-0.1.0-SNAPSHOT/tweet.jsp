<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="/css/tweet.css">
  
  <!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-164320664-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-164320664-1');
</script>

</head>
<body>
 <script type="text/javascript" src="/js/tweet.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.7.1.min.js"></script>
<div class="topnav">
  <a href="#tweet" style="background-color: green">Tweet</a>
  <a href="friendstweet.jsp">Friends</a>
  <a  id=toptweet href=toptweet.jsp>Top Tweet</a>
  <div id="fb-root"></div>
  <div align="right">
  <div class="fb-login-button" data-max-rows="1"    data-size="large" data-button-type="login_with" data-show-faces="false" data-auto-logout-link="true"  data-use-continue-as="true" scope="public_profile,email" onlogin="checkLoginState();"></div>
  </div>
</div>
<script type="text/javascript">callme()</script>
<%
if(null != request.getParameter("status")){
	request.setAttribute("status",request.getAttribute("status"));
}
%>
${status}
<input type=hidden id=status value="${status}">
<br><div align="center">
<table>
<tr>
<form id="storegae" action="GaeStore" method="get" name="storegae"  >
<td><textarea id="text_content" name="text_content" class="textarea"
							placeholder="Enter your status to Tweet"></textarea></td>
<input type=hidden id=user_id name= user_id />
<input type=hidden id=first_name name=first_name  />
<input type=hidden id=last_name name=last_name  />
<input type=hidden id=picture name=picture  />
<script>

console.log(document.getElementById("first_name")+" "+document.getElementById("last_name")+" "+document.getElementById("picture"));
</script>
<td><input type="submit" id=submit name=save class="button" />
</form>
<br><input type="button"  id="create_tweet" class="button" value="Create Tweet" />

<form action="getmytweet.jsp" method="GET">
<input type=hidden id=user_ids name=user_ids  />
<br><input type="submit"  class="button" value="View my Tweets" name="view_tweet" />
</form>
</td>
</tr>
</table>
</div>

<div align="center">

<div id="mypopup" class="popup">
<div  class="popup-content">
<span class="close">&times;</span>
<p> Choose whether to share it in feed or send it as message </p>
<input type="button"  class="button" value="Share Tweet" name="share_tweet" onclick=shareTweet() />
<input type="button"  class="button" value="Send Direct Message" name="send_direct_msg" onclick=sendDirectMsg() />
</div>
</div>

</div>


<script>

var modal = document.getElementById('mypopup');
var btn = document.getElementById("create_tweet");
var span = document.getElementsByClassName("close")[0];
btn.onclick = function() {
    modal.style.display = "block";
};
span.onclick = function() {
    modal.style.display = "none";
};
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
};
document.getElementById("user_ids").value       = getCookie('user_id');
document.getElementById("user_id").value       = getCookie('user_id');
document.getElementById("first_name").value = getCookie('first_name');
document.getElementById("first_names").value = getCookie('first_name');
document.getElementById("last_name").value  = getCookie('last_name');
document.getElementById("picture").value    = getCookie('picture');
document.getElementById("toptweet").href="toptweet.jsp?name="+getCookie("first_name");

</script>
</body>
</html>

