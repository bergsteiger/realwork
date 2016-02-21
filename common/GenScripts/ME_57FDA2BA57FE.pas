unit CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType;
 {* Редактор панели задач }

// Модуль: "w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType.pas"
// Стереотип: "UserType"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
;

const
 {* Константы для типа формы ut_CustomizeTasksPanel }
 ut_CustomizeTasksPanelName = 'ut_CustomizeTasksPanel';
  {* Строковый идентификатор пользовательского типа "Редактор панели задач" }
 ut_CustomizeTasksPanel = TvcmUserType(0);
  {* Редактор панели задач }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_CustomizeTasksPanel = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_CustomizeTasksPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_CustomizeTasksPanel
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_CustomizeTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_CustomizeTasksPanel';
end;//Tkw_FormUserType_ut_CustomizeTasksPanel.GetWordNameForRegister

function Tkw_FormUserType_ut_CustomizeTasksPanel.GetInteger: Integer;
begin
 Result := ut_CustomizeTasksPanel;
end;//Tkw_FormUserType_ut_CustomizeTasksPanel.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_CustomizeTasksPanel.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_CustomizeTasksPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
