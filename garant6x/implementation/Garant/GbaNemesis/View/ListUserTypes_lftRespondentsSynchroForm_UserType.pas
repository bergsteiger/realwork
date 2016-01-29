unit ListUserTypes_lftRespondentsSynchroForm_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftRespondentsSynchroForm_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftRespondentsSynchroForm
//
// Синхронный просмотр (ссылка из документа)
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
  ListUserTypes_lftCorrespondentsSynchroForm_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы lftRespondentsSynchroForm }
  lftRespondentsSynchroFormName = 'lftRespondentsSynchroForm';
   { Строковый идентификатор пользовательского типа "Синхронный просмотр (ссылка из документа)" }
  lftRespondentsSynchroForm = TvcmUserType(lftCorrespondentsSynchroForm + 1);
   { Синхронный просмотр (ссылка из документа) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftRespondentsSynchroForm = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы lftRespondentsSynchroForm }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftRespondentsSynchroForm
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftRespondentsSynchroForm

class function Tkw_FormUserType_lftRespondentsSynchroForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::lftRespondentsSynchroForm';
end;//Tkw_FormUserType_lftRespondentsSynchroForm.GetWordNameForRegister

function Tkw_FormUserType_lftRespondentsSynchroForm.GetInteger: Integer;
 {-}
begin
 Result := lftRespondentsSynchroForm;
end;//Tkw_FormUserType_lftRespondentsSynchroForm.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_lftRespondentsSynchroForm
 Tkw_FormUserType_lftRespondentsSynchroForm.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.