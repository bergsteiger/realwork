unit NOT_FINISHED_CustomizeTasksPanel_Form;
 {* Редактор панели задач }

// Модуль: "w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\NOT_FINISHED_CustomizeTasksPanel_Form.pas"
// Стереотип: "VCMFinalForm"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimCustomizeTasksPanel_Form
;

type
 TCustomizeTasksPanelForm = {final} class(TPrimCustomizeTasksPanelForm)
  {* Редактор панели задач }
 end;//TCustomizeTasksPanelForm
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3StringIDEx
 , vcmCustOpsRepGroupList
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , CustomizeTasksPanelKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки ut_CustomizeTasksPanelLocalConstants }
 str_ut_CustomizeTasksPanelCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_CustomizeTasksPanelCaption'; rValue : 'Редактор панели задач');
  {* Заголовок пользовательского типа "Редактор панели задач" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomizeTasksPanelForm);
 {* Регистрация CustomizeTasksPanel }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_CustomizeTasksPanelCaption.Init;
 {* Инициализация str_ut_CustomizeTasksPanelCaption }
{$IfEnd} // NOT Defined(NoVCM)

end.
