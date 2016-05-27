unit NOT_FINISHED_CustomizeTasksPanel_Form;
 {* Редактор панели задач }

// Модуль: "w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\NOT_FINISHED_CustomizeTasksPanel_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "CustomizeTasksPanel" MUID: (4C8E4D4F027D)
// Имя типа: "TCustomizeTasksPanelForm"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimCustomizeTasksPanel_Form
 , vcmEntities
;

type
 TCustomizeTasksPanelForm = {final} class(TPrimCustomizeTasksPanelForm)
  {* Редактор панели задач }
   Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
 end;//TCustomizeTasksPanelForm
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3StringIDEx
 , vcmCustOpsRepGroupList
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , vcmInterfaces
 , CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , CustomizeTasksPanelKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* Локализуемые строки ut_CustomizeTasksPanelLocalConstants }
 str_ut_CustomizeTasksPanelCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_CustomizeTasksPanelCaption'; rValue : 'Редактор панели задач');
  {* Заголовок пользовательского типа "Редактор панели задач" }

{$R *.DFM}

procedure TCustomizeTasksPanelForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_CustomizeTasksPanelName,
  str_ut_CustomizeTasksPanelCaption,
  str_ut_CustomizeTasksPanelCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_CustomizeTasksPanelName
end;//TCustomizeTasksPanelForm.MakeControls

initialization
 str_ut_CustomizeTasksPanelCaption.Init;
 {* Инициализация str_ut_CustomizeTasksPanelCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomizeTasksPanelForm);
 {* Регистрация CustomizeTasksPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
