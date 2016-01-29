unit ListUserTypes_lftConsultation_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftConsultation_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftConsultation
//
// Консультация
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
  ListUserTypes_lftUserCR2_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы lftConsultation }
  lftConsultationName = 'lftConsultation';
   { Строковый идентификатор пользовательского типа "Консультация" }
  lftConsultation = TvcmUserType(lftUserCR2 + 1);
   { Консультация }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftConsultation = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы lftConsultation }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftConsultation
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftConsultation

class function Tkw_FormUserType_lftConsultation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::lftConsultation';
end;//Tkw_FormUserType_lftConsultation.GetWordNameForRegister

function Tkw_FormUserType_lftConsultation.GetInteger: Integer;
 {-}
begin
 Result := lftConsultation;
end;//Tkw_FormUserType_lftConsultation.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_lftConsultation
 Tkw_FormUserType_lftConsultation.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.