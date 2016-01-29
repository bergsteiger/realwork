<%@ LANGUAGE=JScript%>
<%

 Session('authUser') = 0;

 var login    = String(Request.Form('login'));
 var password = String(Request.Form('password'));
 var newpassw = String(Request.Form('newpassw'));

 try {
  Session('db').UserLogon(login, password, 'GS', 2, '');
  Session('authUser') = 1;

 /*
  if (newpassw){
   var adminSession = Server.CreateObject("CLEARQUEST.ADMINSESSION");
   adminSession.Logon('superuser', 'superuser', '');
   var user = adminSession.GetUser(login);
   user.SetLoginName(login, newpassw);
   adminSession = null;
  }
 */

  Response.Cookies("userinfo")("login")    = login;
  Response.Cookies("userinfo")("password") = password;

//  Response.Cookies("userinfo").Expires     =  
  Response.Cookies("userinfo").Secure      = "true";

  Response.Redirect('main.asp');
 }
 catch(e){Response.Redirect('default.asp');
 }

%>