unit nsENOIntegration;

// $Id: nsENOIntegration.pas,v 1.3 2014/01/15 12:57:28 kostitsin Exp $

// $Log: nsENOIntegration.pas,v $
// Revision 1.3  2014/01/15 12:57:28  kostitsin
// {requestlink: 451251129}
//
// Revision 1.2  2011/06/23 15:30:00  lulin
// {RequestLink:254944102}.
//
// Revision 1.1  2009/09/22 14:49:21  lulin
// - переносим модуль поиска на модель.
//
// Revision 1.10  2009/03/19 08:45:01  oman
// - fix: Сменили каталог в инсталляторе (К-139440771)
//
// Revision 1.9  2009/03/18 08:15:43  oman
// - fix: Не хватало сплеша (К-139440771)
//
// Revision 1.8  2008/08/08 06:30:32  oman
// - fix: Недоотрубили ЭНО (K-106594448)
//
// Revision 1.7  2008/08/08 05:14:30  oman
// - fix: Недоотрубили ЭНО (K-106594448)
//
// Revision 1.6  2008/08/07 13:15:11  oman
// - new: Отрубаем ЭНО (K-106594448)
//
// Revision 1.5  2008/07/22 06:41:31  oman
// - new: Открытие ЭНО "без ничего" (К-103940446)
//
// Revision 1.4  2008/07/17 05:46:44  oman
// - new: Правильно передаем параметр (К-102465668)
//
// Revision 1.3  2008/07/16 11:29:20  oman
// - new: Реагируем на отсутствие инсталятора (К-102465668)
//
// Revision 1.2  2008/07/16 11:11:38  oman
// - new: Пытаемся пускать инсталятор (К-102465668)
//
// Revision 1.1  2008/07/16 09:53:14  oman
// - new: Проверяем наличие ЭНО и открываемся более правильным способом (К-102465668)
//
//

interface

uses
 l3Interfaces;

function nsIsENOInstalled(const aLink: Il3CString): Boolean;
function nsIsENOInstall: Boolean;
function nsExecuteENOLink(const aLink: Il3CString): Boolean;
procedure nsProcessENOLink(const aLink: Il3CString);

implementation

uses
 SHellAPI,
 SysUtils,
 Windows,
 Registry,

 l3Base,

 vcmForm,

 nsExternalObject,
 nsExternalObjectPrim,
 nsTypes,
 StdRes,
 DataAdapter,

 vcmMessagesSupport
 ;

function nsIsENOInstalled(const aLink: Il3CString): Boolean;
var
 l_Reg: TRegistry;
 l_Extension: string;
begin
 l_Reg := TRegistry.Create;
 try
  l_Reg.RootKey := HKEY_CLASSES_ROOT;
  Result := l_Reg.KeyExists(ExtractFileExt(nsAStr(aLink).S));
 finally
  FreeAndNil(l_Reg);
 end;
end;

function nsIsENOInstall: Boolean;
var
 l_Path: String;

 function lp_TryInstall(const aSuffix: String): Boolean;
 var
  l_Name: String;
 begin
  l_Name := l_Path + aSuffix + 'setup.exe';
  Result := FileExists(l_Name);
  if Result then
   nsDoShellExecute(nsCStr(l_Name));
 end;

begin
 l_Path := ExtractFilePath(ParamStr(0));
 Result := True;
 if not lp_TryInstall('..\EO\') then
  Result := False;
end;

function nsExecuteENOLink(const aLink: Il3CString): Boolean;
var
 l_ShellExecuteInfo: TShellExecuteInfo;
 l_FileName: String;
begin
 if Assigned(aLink) then
 begin
  l_FileName := nsAStr(nsMakeTemporaryFileName(aLink, '')).S;
  l_FileName := ExtractFilePath(l_FileName) + nsAStr(aLink).S;
  l3FillChar(l_ShellExecuteInfo, SizeOf(l_ShellExecuteInfo), 0);
  with l_ShellExecuteInfo do
  begin
   cbSize := SizeOf(l_ShellExecuteInfo);
   lpFile := PChar(l_FileName);
   nShow := SW_SHOWNORMAL;
   fMask := SEE_MASK_FLAG_NO_UI;
  end;//with l_ShellExecuteInfo
  Result := ShellExecuteEx(@l_ShellExecuteInfo);
 end
 else
  Result := False;
end;

procedure nsProcessENOLink(const aLink: Il3CString);
begin
 if not defDataAdapter.IsENOEnabled then
 begin
  vcmSay(war_ENOSetupNotFound, [defDataAdapter.GetDealerInfo]);
  Exit;
 end;
 if not nsIsENOInstalled(aLink) then
 begin
  if vcmAsk(qr_ENONotFound) then
  begin
   if not nsIsENOInstall then
    vcmSay(war_ENOSetupNotFound, [defDataAdapter.GetDealerInfo]);
  end
  else
   Exit;
 end
 else
  if not nsExecuteENOLink(aLink) then
   vcmSay(war_CheckENO, [defDataAdapter.GetDealerInfo]);
end;

end.
