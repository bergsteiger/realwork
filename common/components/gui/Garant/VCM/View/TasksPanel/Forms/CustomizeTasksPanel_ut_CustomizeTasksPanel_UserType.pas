unit CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/View/TasksPanel/Forms/CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType.pas"
// Начат: 13.09.2010 20:12
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> Shared Delphi Operations::VCMCustomization::View::TasksPanel::PrimTasksPanelMenu::CustomizeTasksPanel::ut_CustomizeTasksPanel
//
// Редактор панели задач
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmUserControls
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
    { Константы для типа формы ut_CustomizeTasksPanel }
   ut_CustomizeTasksPanelName = 'ut_CustomizeTasksPanel';
    { Строковый идентификатор пользовательского типа "Редактор панели задач" }
   ut_CustomizeTasksPanel = TvcmUserType(0);
    { Редактор панели задач }
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
{$If not defined(NoScripts) AND not defined(NoVCM)}
type
   Tkw_FormUserType_ut_CustomizeTasksPanel = {final scriptword} class(TtfwInteger)
    {* Слово словаря для типа формы ut_CustomizeTasksPanel }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_CustomizeTasksPanel
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class Tkw_FormUserType_ut_CustomizeTasksPanel

class function Tkw_FormUserType_ut_CustomizeTasksPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_CustomizeTasksPanel';
end;//Tkw_FormUserType_ut_CustomizeTasksPanel.GetWordNameForRegister

function Tkw_FormUserType_ut_CustomizeTasksPanel.GetInteger: Integer;
 {-}
begin
 Result := ut_CustomizeTasksPanel;
end;//Tkw_FormUserType_ut_CustomizeTasksPanel.GetInteger

{$IfEnd} //not NoScripts AND not NoVCM
{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_FormUserType_ut_CustomizeTasksPanel
 Tkw_FormUserType_ut_CustomizeTasksPanel.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.