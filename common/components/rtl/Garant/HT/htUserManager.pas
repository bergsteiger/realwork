unit htUserManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "HT"
// ������: "w:/common/components/rtl/Garant/HT/htUserManager.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::HT::Provider::ThtUserManager
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\HT\htDefineDA.inc}

interface

uses
  l3ProtoObject,
  daInterfaces,
  daTypes
  ;

type
 ThtUserManager = class(Tl3ProtoObject, IdaUserManager)
 protected
 // realized methods
   function CheckPassword(const aLogin: AnsiString;
    const aPassword: AnsiString;
    RequireAdminRights: Boolean;
    out theUserID: TdaUserID): TdaLoginError;
 public
 // public methods
   constructor Create; reintroduce;
     {* ��������� ������ Create }
   class function Make: IdaUserManager; reintroduce;
     {* ��������� ������� ThtUserManager.Make }
 end;//ThtUserManager

implementation

uses
  Classes
  {$If not defined(Nemesis)}
  ,
  dt_Serv
  {$IfEnd} //not Nemesis
  
  ;

// start class ThtUserManager

constructor ThtUserManager.Create;
//#UC START# *5629F0F901C8_5629E343023B_var*
//#UC END# *5629F0F901C8_5629E343023B_var*
begin
//#UC START# *5629F0F901C8_5629E343023B_impl*
 inherited Create;
// !!! Needs to be implemented !!!
//#UC END# *5629F0F901C8_5629E343023B_impl*
end;//ThtUserManager.Create

class function ThtUserManager.Make: IdaUserManager;
var
 l_Inst : ThtUserManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function ThtUserManager.CheckPassword(const aLogin: AnsiString;
  const aPassword: AnsiString;
  RequireAdminRights: Boolean;
  out theUserID: TdaUserID): TdaLoginError;
//#UC START# *5628D14D0151_5629E343023B_var*
var
 l_Result: Boolean;
//#UC END# *5628D14D0151_5629E343023B_var*
begin
//#UC START# *5628D14D0151_5629E343023B_impl*
 l_Result:= GlobalHtServer.xxxCheckArchivariusPassword(aLogin, aPassword, RequireAdminRights);
 if l_Result then
  Result := da_leOk
 else
 begin
  if RequireAdminRights and GlobalHtServer.xxxCheckArchivariusPassword(aLogin, aPassword, False) then
   Result := da_leInsufficientRights
  else
   Result := da_leUserParamsWrong;
 end;
 theUserID := GlobalHTServer.xxxUserID;
//#UC END# *5628D14D0151_5629E343023B_impl*
end;//ThtUserManager.CheckPassword

end.