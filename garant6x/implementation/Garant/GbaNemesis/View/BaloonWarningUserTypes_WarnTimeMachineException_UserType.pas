unit BaloonWarningUserTypes_WarnTimeMachineException_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes_WarnTimeMachineException_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes::WarnTimeMachineException
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  BaloonWarningUserTypes_WarnTimeMachineWarning_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  BaloonWarningUserTypes_Fake_UserType
  ;

const
   { Константы для типа формы WarnTimeMachineException }
  WarnTimeMachineExceptionName = 'WarnTimeMachineException';
   { Строковый идентификатор пользовательского типа "" }
  WarnTimeMachineException = TvcmUserType(WarnTimeMachineWarning + 1);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_WarnTimeMachineException = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы WarnTimeMachineException }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_WarnTimeMachineException
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_WarnTimeMachineException

class function Tkw_FormUserType_WarnTimeMachineException.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::WarnTimeMachineException';
end;//Tkw_FormUserType_WarnTimeMachineException.GetWordNameForRegister

function Tkw_FormUserType_WarnTimeMachineException.GetInteger: Integer;
 {-}
begin
 Result := WarnTimeMachineException;
end;//Tkw_FormUserType_WarnTimeMachineException.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_WarnTimeMachineException
 Tkw_FormUserType_WarnTimeMachineException.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.