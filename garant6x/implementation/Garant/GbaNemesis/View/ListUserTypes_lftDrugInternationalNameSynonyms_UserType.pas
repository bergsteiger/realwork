unit ListUserTypes_lftDrugInternationalNameSynonyms_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftDrugInternationalNameSynonyms_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftDrugInternationalNameSynonyms
//
// Синонимы по международному названию
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
  ListUserTypes_lftDrugList_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы lftDrugInternationalNameSynonyms }
  lftDrugInternationalNameSynonymsName = 'lftDrugInternationalNameSynonyms';
   { Строковый идентификатор пользовательского типа "Синонимы по международному названию" }
  lftDrugInternationalNameSynonyms = TvcmUserType(lftDrugList + 1);
   { Синонимы по международному названию }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftDrugInternationalNameSynonyms = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы lftDrugInternationalNameSynonyms }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftDrugInternationalNameSynonyms
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftDrugInternationalNameSynonyms

class function Tkw_FormUserType_lftDrugInternationalNameSynonyms.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::lftDrugInternationalNameSynonyms';
end;//Tkw_FormUserType_lftDrugInternationalNameSynonyms.GetWordNameForRegister

function Tkw_FormUserType_lftDrugInternationalNameSynonyms.GetInteger: Integer;
 {-}
begin
 Result := lftDrugInternationalNameSynonyms;
end;//Tkw_FormUserType_lftDrugInternationalNameSynonyms.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_lftDrugInternationalNameSynonyms
 Tkw_FormUserType_lftDrugInternationalNameSynonyms.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.