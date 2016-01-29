unit DocumentUserTypes_dftRelatedSynchroView_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftRelatedSynchroView_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftRelatedSynchroView
//
// Справка к документу (синхронный просмотр)
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
  DocumentUserTypes_dftDocSynchroView_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы dftRelatedSynchroView }
  dftRelatedSynchroViewName = 'dftRelatedSynchroView';
   { Строковый идентификатор пользовательского типа "Справка к документу (синхронный просмотр)" }
  dftRelatedSynchroView = TvcmUserType(dftDocSynchroView + 1);
   { Справка к документу (синхронный просмотр) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftRelatedSynchroView = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы dftRelatedSynchroView }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftRelatedSynchroView
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftRelatedSynchroView

class function Tkw_FormUserType_dftRelatedSynchroView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::dftRelatedSynchroView';
end;//Tkw_FormUserType_dftRelatedSynchroView.GetWordNameForRegister

function Tkw_FormUserType_dftRelatedSynchroView.GetInteger: Integer;
 {-}
begin
 Result := dftRelatedSynchroView;
end;//Tkw_FormUserType_dftRelatedSynchroView.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_dftRelatedSynchroView
 Tkw_FormUserType_dftRelatedSynchroView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.