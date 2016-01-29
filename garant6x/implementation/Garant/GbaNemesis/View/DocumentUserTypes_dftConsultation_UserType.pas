unit DocumentUserTypes_dftConsultation_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftConsultation_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftConsultation
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
  DocumentUserTypes_dftAutoreferatAfterSearch_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы dftConsultation }
  dftConsultationName = 'dftConsultation';
   { Строковый идентификатор пользовательского типа "Консультация" }
  dftConsultation = TvcmUserType(dftAutoreferatAfterSearch + 1);
   { Консультация }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftConsultation = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы dftConsultation }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftConsultation
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftConsultation

class function Tkw_FormUserType_dftConsultation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::dftConsultation';
end;//Tkw_FormUserType_dftConsultation.GetWordNameForRegister

function Tkw_FormUserType_dftConsultation.GetInteger: Integer;
 {-}
begin
 Result := dftConsultation;
end;//Tkw_FormUserType_dftConsultation.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_dftConsultation
 Tkw_FormUserType_dftConsultation.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.