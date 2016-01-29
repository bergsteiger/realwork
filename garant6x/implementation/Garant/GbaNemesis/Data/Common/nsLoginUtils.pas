unit nsLoginUtils;

// $Id: nsLoginUtils.pas,v 1.1 2013/10/21 13:56:50 kostitsin Exp $

// $Log: nsLoginUtils.pas,v $
// Revision 1.1  2013/10/21 13:56:50  kostitsin
// [$377169452] - Settings
//
// Revision 1.1  2013/10/14 14:19:28  kostitsin
// [$377169452] - Registration
//
// Revision 1.6  2013/04/24 09:35:55  lulin
// - портируем.
//
// Revision 1.5  2007/02/28 16:17:01  lulin
// - корректнее обрабатываем юникодные строки.
//
// Revision 1.4  2005/10/11 12:49:40  lulin
// - модуль регулярных выражений переехал в правильную библиотеку.
//
// Revision 1.3  2005/03/24 13:36:11  mmorozov
// change: проверка логина, пароля и почтового адреса перекочевала в nsVerifyValue;
//
// Revision 1.2  2005/03/23 17:35:33  dinishev
// GetCurrentUserName -> LoginUtils
//
// Revision 1.1  2005/03/21 13:35:17  dinishev
// Процедуры проверки пароля, почтового адреса и логина на корректность вынесены в отдельный модуль.
//
// Revision 1.1  2003/07/02 19:45:58  law
// - задел на заковыривание IDocument в TextSource.
//

{$Include nsDefine.inc }

interface

uses
  l3Interfaces
  ;

function GetCurrentUserName: Il3CString;
  {-} 
  
implementation

uses
  Types,
  Windows,

  l3Base
  ;
         
function GetCurrentUserName: Il3CString;
var
 l_UserNameLen : DWORD;
 l_UserName    : AnsiString;
begin
 l_UserNameLen := MAX_COMPUTERNAME_LENGTH;
 SetLength(l_UserName, l_UserNameLen);
 if GetUserNameA(PAnsiChar(l_UserName), l_UserNameLen) then
 begin
  SetLength(l_UserName, Pred(l_UserNameLen));
  Result := l3CStr(l_UserName);
 end//GetUserName..
 else
  Result := nil;
end;

end.
