unit BaloonWarningUserTypes_remListModified_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes_remListModified_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes::remListModified
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
  BaloonWarningUserTypes_WarnTimeMachineException_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  BaloonWarningUserTypes_Fake_UserType
  ;

const
   { Константы для типа формы remListModified }
  remListModifiedName = 'remListModified';
   { Строковый идентификатор пользовательского типа "" }
  remListModified = TvcmUserType(WarnTimeMachineException + 1);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_remListModified = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы remListModified }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_remListModified
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_remListModified

class function Tkw_FormUserType_remListModified.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::remListModified';
end;//Tkw_FormUserType_remListModified.GetWordNameForRegister

function Tkw_FormUserType_remListModified.GetInteger: Integer;
 {-}
begin
 Result := remListModified;
end;//Tkw_FormUserType_remListModified.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_remListModified
 Tkw_FormUserType_remListModified.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.