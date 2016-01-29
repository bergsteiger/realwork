unit DocumentUserTypes_dftTranslation_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftTranslation_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftTranslation
//
// Перевод
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
  DocumentUserTypes_dftConsultation_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы dftTranslation }
  dftTranslationName = 'dftTranslation';
   { Строковый идентификатор пользовательского типа "Перевод" }
  dftTranslation = TvcmUserType(dftConsultation + 1);
   { Перевод }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftTranslation = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы dftTranslation }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftTranslation
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftTranslation

class function Tkw_FormUserType_dftTranslation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::dftTranslation';
end;//Tkw_FormUserType_dftTranslation.GetWordNameForRegister

function Tkw_FormUserType_dftTranslation.GetInteger: Integer;
 {-}
begin
 Result := dftTranslation;
end;//Tkw_FormUserType_dftTranslation.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_dftTranslation
 Tkw_FormUserType_dftTranslation.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.