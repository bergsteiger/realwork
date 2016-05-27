unit ncsLoginMessage;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsLoginMessage.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsLoginMessage" MUID: (544E07C6034D)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TncsLoginMessage = class(TncsMessage)
  protected
   function pm_GetServerHost: AnsiString;
   procedure pm_SetServerHost(const aValue: AnsiString);
   function pm_GetLogin: AnsiString;
   procedure pm_SetLogin(const aValue: AnsiString);
   function pm_GetPassword: AnsiString;
   procedure pm_SetPassword(const aValue: AnsiString);
   function pm_GetServerPort: Integer;
   procedure pm_SetServerPort(aValue: Integer);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
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
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csLogin_Const
;

function TncsLoginMessage.pm_GetServerHost: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrServerHost]);
end;//TncsLoginMessage.pm_GetServerHost

procedure TncsLoginMessage.pm_SetServerHost(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrServerHost, nil] := (aValue);
end;//TncsLoginMessage.pm_SetServerHost

function TncsLoginMessage.pm_GetLogin: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrLogin]);
end;//TncsLoginMessage.pm_GetLogin

procedure TncsLoginMessage.pm_SetLogin(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrLogin, nil] := (aValue);
end;//TncsLoginMessage.pm_SetLogin

function TncsLoginMessage.pm_GetPassword: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrPassword]);
end;//TncsLoginMessage.pm_GetPassword

procedure TncsLoginMessage.pm_SetPassword(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrPassword, nil] := (aValue);
end;//TncsLoginMessage.pm_SetPassword

function TncsLoginMessage.pm_GetServerPort: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrServerPort]);
end;//TncsLoginMessage.pm_GetServerPort

procedure TncsLoginMessage.pm_SetServerPort(aValue: Integer);
begin
 TaggedData.IntW[k2_attrServerPort, nil] := (aValue);
end;//TncsLoginMessage.pm_SetServerPort

class function TncsLoginMessage.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsLogin;
end;//TncsLoginMessage.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
