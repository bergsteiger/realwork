unit DocumentUserTypes_dftDocSynchroView_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftDocSynchroView_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftDocSynchroView
//
// Текст документа (синхронный просмотр)
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
  DocumentUserTypes_dftRelatedDoc_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы dftDocSynchroView }
  dftDocSynchroViewName = 'dftDocSynchroView';
   { Строковый идентификатор пользовательского типа "Текст документа (синхронный просмотр)" }
  dftDocSynchroView = TvcmUserType(dftRelatedDoc + 1);
   { Текст документа (синхронный просмотр) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftDocSynchroView = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы dftDocSynchroView }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftDocSynchroView
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftDocSynchroView

class function Tkw_FormUserType_dftDocSynchroView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::dftDocSynchroView';
end;//Tkw_FormUserType_dftDocSynchroView.GetWordNameForRegister

function Tkw_FormUserType_dftDocSynchroView.GetInteger: Integer;
 {-}
begin
 Result := dftDocSynchroView;
end;//Tkw_FormUserType_dftDocSynchroView.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_dftDocSynchroView
 Tkw_FormUserType_dftDocSynchroView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.