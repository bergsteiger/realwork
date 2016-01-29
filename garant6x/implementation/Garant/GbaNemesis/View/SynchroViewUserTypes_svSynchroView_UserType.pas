unit SynchroViewUserTypes_svSynchroView_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/SynchroViewUserTypes_svSynchroView_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::SynchroViewUserTypes::svSynchroView
//
// Синхронный просмотр
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
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы svSynchroView }
  svSynchroViewName = 'svSynchroView';
   { Строковый идентификатор пользовательского типа "Синхронный просмотр" }
  svSynchroView = TvcmUserType(0);
   { Синхронный просмотр }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_svSynchroView = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы svSynchroView }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_svSynchroView
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_svSynchroView

class function Tkw_FormUserType_svSynchroView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::svSynchroView';
end;//Tkw_FormUserType_svSynchroView.GetWordNameForRegister

function Tkw_FormUserType_svSynchroView.GetInteger: Integer;
 {-}
begin
 Result := svSynchroView;
end;//Tkw_FormUserType_svSynchroView.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_svSynchroView
 Tkw_FormUserType_svSynchroView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.