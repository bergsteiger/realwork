unit ListUserTypes_lftSynchroView_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftSynchroView_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftSynchroView
//
// Синхронный просмотр (ссылки из документа, ссылки на документ)
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
  ListUserTypes_lftCorrespondent_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы lftSynchroView }
  lftSynchroViewName = 'lftSynchroView';
   { Строковый идентификатор пользовательского типа "Синхронный просмотр (ссылки из документа, ссылки на документ)" }
  lftSynchroView = TvcmUserType(lftCorrespondent + 1);
   { Синхронный просмотр (ссылки из документа, ссылки на документ) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftSynchroView = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы lftSynchroView }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftSynchroView
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftSynchroView

class function Tkw_FormUserType_lftSynchroView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::lftSynchroView';
end;//Tkw_FormUserType_lftSynchroView.GetWordNameForRegister

function Tkw_FormUserType_lftSynchroView.GetInteger: Integer;
 {-}
begin
 Result := lftSynchroView;
end;//Tkw_FormUserType_lftSynchroView.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_lftSynchroView
 Tkw_FormUserType_lftSynchroView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.