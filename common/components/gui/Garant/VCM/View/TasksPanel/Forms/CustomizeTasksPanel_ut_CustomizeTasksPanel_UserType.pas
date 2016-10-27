unit CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType;
 {* Редактор панели задач }

// Модуль: "w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_CustomizeTasksPanel" MUID: (57FDA2BA57FE)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки ut_CustomizeTasksPanelLocalConstants }
 str_ut_CustomizeTasksPanelCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_CustomizeTasksPanelCaption'; rValue : 'Редактор панели задач');
  {* Заголовок пользовательского типа "Редактор панели задач" }
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_CustomizeTasksPanel = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_CustomizeTasksPanel }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_CustomizeTasksPanel
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_CustomizeTasksPanel.GetInteger: Integer;
begin
 Result := ut_CustomizeTasksPanel;
end;//Tkw_FormUserType_ut_CustomizeTasksPanel.GetInteger

class function Tkw_FormUserType_ut_CustomizeTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_CustomizeTasksPanel';
end;//Tkw_FormUserType_ut_CustomizeTasksPanel.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_CustomizeTasksPanelCaption.Init;
 {* Инициализация str_ut_CustomizeTasksPanelCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_CustomizeTasksPanel.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_CustomizeTasksPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
