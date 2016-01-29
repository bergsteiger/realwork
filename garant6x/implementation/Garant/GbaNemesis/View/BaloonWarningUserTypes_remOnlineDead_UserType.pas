unit BaloonWarningUserTypes_remOnlineDead_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes_remOnlineDead_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes::remOnlineDead
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
  BaloonWarningUserTypes_remUnreadConsultations_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  BaloonWarningUserTypes_Fake_UserType
  ;

const
   { Константы для типа формы remOnlineDead }
  remOnlineDeadName = 'remOnlineDead';
   { Строковый идентификатор пользовательского типа "" }
  remOnlineDead = TvcmUserType(remUnreadConsultations + 1);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_remOnlineDead = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы remOnlineDead }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_remOnlineDead
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_remOnlineDead

class function Tkw_FormUserType_remOnlineDead.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::remOnlineDead';
end;//Tkw_FormUserType_remOnlineDead.GetWordNameForRegister

function Tkw_FormUserType_remOnlineDead.GetInteger: Integer;
 {-}
begin
 Result := remOnlineDead;
end;//Tkw_FormUserType_remOnlineDead.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_remOnlineDead
 Tkw_FormUserType_remOnlineDead.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.