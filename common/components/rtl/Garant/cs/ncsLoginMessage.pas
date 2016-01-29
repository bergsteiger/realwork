unit ncsLoginMessage;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsLoginMessage.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsLoginMessage
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  ncsMessage,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsLoginMessage = class(TncsMessage)
 protected
 // property methods
   function pm_GetServerHost: AnsiString;
   procedure pm_SetServerHost(const aValue: AnsiString);
   function pm_GetLogin: AnsiString;
   procedure pm_SetLogin(const aValue: AnsiString);
   function pm_GetPassword: AnsiString;
   procedure pm_SetPassword(const aValue: AnsiString);
   function pm_GetServerPort: Integer;
   procedure pm_SetServerPort(aValue: Integer);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property ServerHost: AnsiString
     read pm_GetServerHost
     write pm_SetServerHost;
   property Login: AnsiString
     read pm_GetLogin
     write pm_SetLogin;
   property Password: AnsiString
     read pm_GetPassword
     write pm_SetPassword;
   property ServerPort: Integer
     read pm_GetServerPort
     write pm_SetServerPort;
 end;//TncsLoginMessage
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csLogin_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsLoginMessage

function TncsLoginMessage.pm_GetServerHost: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrServerHost]);
end;//TncsLoginMessage.pm_GetServerHost

procedure TncsLoginMessage.pm_SetServerHost(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrServerHost, nil] := (aValue);
end;//TncsLoginMessage.pm_SetServerHost

function TncsLoginMessage.pm_GetLogin: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrLogin]);
end;//TncsLoginMessage.pm_GetLogin

procedure TncsLoginMessage.pm_SetLogin(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrLogin, nil] := (aValue);
end;//TncsLoginMessage.pm_SetLogin

function TncsLoginMessage.pm_GetPassword: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrPassword]);
end;//TncsLoginMessage.pm_GetPassword

procedure TncsLoginMessage.pm_SetPassword(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrPassword, nil] := (aValue);
end;//TncsLoginMessage.pm_SetPassword

function TncsLoginMessage.pm_GetServerPort: Integer;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrServerPort]);
end;//TncsLoginMessage.pm_GetServerPort

procedure TncsLoginMessage.pm_SetServerPort(aValue: Integer);
 {-}
begin
 TaggedData.IntW[k2_attrServerPort, nil] := (aValue);
end;//TncsLoginMessage.pm_SetServerPort

class function TncsLoginMessage.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsLogin;
end;//TncsLoginMessage.GetTaggedDataType

{$IfEnd} //not Nemesis

end.