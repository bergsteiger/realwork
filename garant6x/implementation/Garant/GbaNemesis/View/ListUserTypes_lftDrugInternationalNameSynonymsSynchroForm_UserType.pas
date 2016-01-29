unit ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftDrugInternationalNameSynonymsSynchroForm
//
// Синхронный просмотр (синонимы по международному названию)
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
  ListUserTypes_lftProducedDrugsSynchroForm_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы lftDrugInternationalNameSynonymsSynchroForm }
  lftDrugInternationalNameSynonymsSynchroFormName = 'lftDrugInternationalNameSynonymsSynchroForm';
   { Строковый идентификатор пользовательского типа "Синхронный просмотр (синонимы по международному названию)" }
  lftDrugInternationalNameSynonymsSynchroForm = TvcmUserType(lftProducedDrugsSynchroForm + 1);
   { Синхронный просмотр (синонимы по международному названию) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы lftDrugInternationalNameSynonymsSynchroForm }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm

class function Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::lftDrugInternationalNameSynonymsSynchroForm';
end;//Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.GetWordNameForRegister

function Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.GetInteger: Integer;
 {-}
begin
 Result := lftDrugInternationalNameSynonymsSynchroForm;
end;//Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm
 Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.