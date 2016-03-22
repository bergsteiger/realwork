unit csNetSupport;
{ Процедуры, реализующие сетевые функции (отключение пользователей) }

interface

function NetLogoffUsers(const theMe, theBaseFolder: string): Boolean;

function UserInFolder(const theUser, theFolder: String): Boolean;

implementation

Uses
  JwaLM, l3Base, JwaWinError, Windows, SysUtils, IdStack;

function NetLogoffUsers(const theMe, theBaseFolder: string): Boolean;
var
 l_Buf: Pointer;
 l_Count: Cardinal;
 l_TotalCount: Cardinal;
 l_Resume: Pointer;
 l_Result, i: Integer;
 l_Client: PWideChar;
 l_ClientIP: String;
 l_ClientName: String;
 l_ServerIP: String;
begin
 TIdStack.IncUsage;
 try
  l_ServerIP := GStack.ResolveHost(theMe);
  Result:= False;
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  try
   l_Buf:= nil;
   l_Result:= NetSessionEnum(nil, nil, nil, 1, l_buf, MAX_PREFERRED_LENGTH, l_Count, l_TotalCount, nil);
   if l_Result = NERR_Success then
   begin
    if l_Count > 0 then
    begin
     l3System.Msg2Log('Принудительное закрытие сессий:');
     for i:= 0 to Pred(l_Count) do
      with PSessionInfo1(PChar(l_Buf)+i*SizeOf(TSessionInfo1))^ do
      begin
       try
        l_ClientIP := GStack.ResolveHost(sesi1_cname);
       except
        on E: Exception do
        begin
         l3System.Msg2Log('* Resolve host failed %s - %s (%s)' ,[sesi1_cname, E.Message, E.ClassName]);
         raise;
        end;
       end;
       try
        l_ClientName := GStack.HostByAddress(l_ClientIP);
       except
        on E: Exception do
        begin
         l3System.Msg2Log('* Resolve IP failed %s - %s (%s)' ,[l_ClientIP, E.Message, E.ClassName]);
         raise;
        end; 
       end;
       if (l_ClientIP <> l_ServerIP) and UserInFolder(sesi1_cname, theBaseFolder) then
       begin
        // По-хорошему, нужно проверить открыты ли файлы в папке с базой
        l3System.Msg2Log('* %s@%s(%s)', [sesi1_username, l_ClientName, l_ClientIP]);
        l_Client:= PWideChar(WideString('\\'+sesi1_cname));
        case NetSessionDel(nil, PChar(l_Client), nil) of
         ERROR_ACCESS_DENIED:
          begin
           l3System.Msg2Log('* The user does not have access to the requested information.');
           break;
          end;
         ERROR_INVALID_PARAMETER: l3System.Msg2Log('* The specified parameter is not valid.');
         ERROR_NOT_ENOUGH_MEMORY: l3System.Msg2Log('* Insufficient memory is available.');
         NERR_ClientNameNotFound: l3System.Msg2Log('* A session does not exist with that computer name.');
        else
         Result:= True;
        end; //case
       end; // sesi1_cname <> theMe
      end; //with PSessionInfo1(PChar(l_Buf)+i*SizeOf(TSessionInfo1))^
     // for i
     NetApiBufferFree(l_Buf);
    end; // l_Count > 0
   end // l_Result = NERR_Success
   else
   case l_Result of
    ERROR_ACCESS_DENIED: l3System.Msg2Log('* The user does not have access to the requested information.');
    ERROR_INVALID_LEVEL: l3System.Msg2Log('* The value specified for the level parameter is not valid.');
    ERROR_INVALID_PARAMETER: l3System.Msg2Log('* The specified parameter is not valid.');
    ERROR_MORE_DATA: l3System.Msg2Log('* More entries are available. Specify a large enough buffer to receive all entries.');
    ERROR_NOT_ENOUGH_MEMORY: l3System.Msg2Log('* Insufficient memory is available.');
    NERR_ClientNameNotFound: l3System.Msg2Log('* A session does not exist with the computer name.');
    NERR_InvalidComputer: l3System.Msg2Log('* The computer name is not valid.');
    NERR_UserNotFound: l3System.Msg2Log('* The user name could not be found.');
   end;
  except
   on E: Exception do
   begin
    l3System.Msg2Log('* Ошибка вызова NetSessionEnum');
    l3System.Exception2Log(E);
   end;
  end;
 finally
  TIdStack.DecUsage;
 end;
end;

function UserInFolder(const theUser, theFolder: String): Boolean;
var
 FileInfo: Pointer;
 entriesreadNT,  totalentries: Cardinal;
 l_User, l_Base: WideString;
begin
 Result:= False;
 FileInfo := nil;
 l_Base:= WideString(theFolder);
 l_User:= WideString('\\'+theUser);
 if NetFileEnum(nil, PAnsiChar(PWideChar(l_Base)), PAnsiChar(PWideChar(l_User)),
                    3, FileInfo, MAX_PREFERRED_LENGTH, entriesreadNT,  totalentries, nil) = 0 then
  Result:= EntriesReadNT > 0;
 NetApiBufferFree(FileInfo);
end;

end.
