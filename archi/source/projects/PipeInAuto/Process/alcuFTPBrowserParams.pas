unit alcuFTPBrowserParams;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Process"
// Модуль: "w:/archi/source/projects/PipeInAuto/Process/alcuFTPBrowserParams.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Process::Process::TalcuFTPBrowserParams
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
  l3Variant,
  Classes,
  k2Base
  ;

type
 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}
 TalcuFTPBrowserParams = class(_evdTagHolder_)
 protected
 // property methods
   function pm_GetServerName: AnsiString;
   procedure pm_SetServerName(const aValue: AnsiString);
   function pm_GetPort: Integer;
   procedure pm_SetPort(aValue: Integer);
   function pm_GetLogin: AnsiString;
   procedure pm_SetLogin(const aValue: AnsiString);
   function pm_GetPassword: AnsiString;
   procedure pm_SetPassword(const aValue: AnsiString);
   function pm_GetPassiveMode: Boolean;
   procedure pm_SetPassiveMode(aValue: Boolean);
   function pm_GetRemoteFolder: AnsiString;
   procedure pm_SetRemoteFolder(const aValue: AnsiString);
   function pm_GetLogTitle: AnsiString;
   procedure pm_SetLogTitle(const aValue: AnsiString);
 public
 // realized methods
   class function GetTaggedDataType: Tk2Type; override;
 protected
 // overridden protected methods
   procedure InitFields; override;
 public
 // public properties
   property ServerName: AnsiString
     read pm_GetServerName
     write pm_SetServerName;
   property Port: Integer
     read pm_GetPort
     write pm_SetPort;
   property Login: AnsiString
     read pm_GetLogin
     write pm_SetLogin;
   property Password: AnsiString
     read pm_GetPassword
     write pm_SetPassword;
   property PassiveMode: Boolean
     read pm_GetPassiveMode
     write pm_SetPassiveMode;
   property RemoteFolder: AnsiString
     read pm_GetRemoteFolder
     write pm_SetRemoteFolder;
   property LogTitle: AnsiString
     read pm_GetLogTitle
     write pm_SetLogTitle;
 end;//TalcuFTPBrowserParams

implementation

uses
  IdAssignedNumbers,
  FTPBrowser_Const,
  evdNativeWriter,
  l3Filer,
  l3Types,
  k2TagGen,
  evdNativeReader,
  k2DocumentBuffer,
  SysUtils
  ;

{$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}

// start class TalcuFTPBrowserParams

function TalcuFTPBrowserParams.pm_GetServerName: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrServerName]);
end;//TalcuFTPBrowserParams.pm_GetServerName

procedure TalcuFTPBrowserParams.pm_SetServerName(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrServerName, nil] := (aValue);
end;//TalcuFTPBrowserParams.pm_SetServerName

function TalcuFTPBrowserParams.pm_GetPort: Integer;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrPort]);
end;//TalcuFTPBrowserParams.pm_GetPort

procedure TalcuFTPBrowserParams.pm_SetPort(aValue: Integer);
 {-}
begin
 TaggedData.IntW[k2_attrPort, nil] := (aValue);
end;//TalcuFTPBrowserParams.pm_SetPort

function TalcuFTPBrowserParams.pm_GetLogin: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrLogin]);
end;//TalcuFTPBrowserParams.pm_GetLogin

procedure TalcuFTPBrowserParams.pm_SetLogin(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrLogin, nil] := (aValue);
end;//TalcuFTPBrowserParams.pm_SetLogin

function TalcuFTPBrowserParams.pm_GetPassword: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrPassword]);
end;//TalcuFTPBrowserParams.pm_GetPassword

procedure TalcuFTPBrowserParams.pm_SetPassword(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrPassword, nil] := (aValue);
end;//TalcuFTPBrowserParams.pm_SetPassword

function TalcuFTPBrowserParams.pm_GetPassiveMode: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrPassiveMode]);
end;//TalcuFTPBrowserParams.pm_GetPassiveMode

procedure TalcuFTPBrowserParams.pm_SetPassiveMode(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrPassiveMode, nil] := (aValue);
end;//TalcuFTPBrowserParams.pm_SetPassiveMode

function TalcuFTPBrowserParams.pm_GetRemoteFolder: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrRemoteFolder]);
end;//TalcuFTPBrowserParams.pm_GetRemoteFolder

procedure TalcuFTPBrowserParams.pm_SetRemoteFolder(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrRemoteFolder, nil] := (aValue);
end;//TalcuFTPBrowserParams.pm_SetRemoteFolder

function TalcuFTPBrowserParams.pm_GetLogTitle: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrLogTitle]);
end;//TalcuFTPBrowserParams.pm_GetLogTitle

procedure TalcuFTPBrowserParams.pm_SetLogTitle(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrLogTitle, nil] := (aValue);
end;//TalcuFTPBrowserParams.pm_SetLogTitle

class function TalcuFTPBrowserParams.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typFTPBrowser;
end;//TalcuFTPBrowserParams.GetTaggedDataType

procedure TalcuFTPBrowserParams.InitFields;
//#UC START# *47A042E100E2_54041EBF03C6_var*
//#UC END# *47A042E100E2_54041EBF03C6_var*
begin
//#UC START# *47A042E100E2_54041EBF03C6_impl*
 inherited;
 Port := IDPORT_FTP;
//#UC END# *47A042E100E2_54041EBF03C6_impl*
end;//TalcuFTPBrowserParams.InitFields

end.