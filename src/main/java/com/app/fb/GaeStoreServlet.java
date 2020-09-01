package com.app.fb;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;


@SuppressWarnings("serial")
public class GaeStoreServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		DateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
		Entity e=new Entity("tweet");
		e.setProperty("status",req.getParameter("text_content"));
		e.setProperty("user_id", req.getParameter("user_id"));
		e.setProperty("first_name", req.getParameter("first_name"));
		e.setProperty("last_name", req.getParameter("last_name"));
		e.setProperty("picture", req.getParameter("picture"));
		e.setProperty("visited_count", 0);
		Cookie user_id = new Cookie("user_id", req.getParameter("user_id"));
		Cookie f_name= new Cookie("first_name",req.getParameter("first_name"));
		Cookie l_name=new Cookie("last_name", req.getParameter("last_name"));
		Cookie pic = new Cookie("picture", URLEncoder.encode(req.getParameter("picture"), "UTF-8"));
		resp.addCookie(user_id);
		resp.addCookie(f_name);
		resp.addCookie(l_name);
		
		resp.addCookie(pic);
		Date date = new Date();
        System.out.println(sdf.format(date));
		e.setProperty("timestamp", sdf.format(date));
		Key id=ds.put(e);		
		StringBuffer sb=new StringBuffer();
		String url = req.getRequestURL().toString();
		String baseURL = url.substring(0, url.length() - req.getRequestURI().length()) + req.getContextPath() + "/";
		sb.append(baseURL+"direct_tweet.jsp?id="+id.getId());
		req.setAttribute("status", sb);
		req.getRequestDispatcher("tweet.jsp").forward(req, resp);
	}
}
