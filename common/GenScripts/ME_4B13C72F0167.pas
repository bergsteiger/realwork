unit PrimTasksPanel_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimTasksPanel_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Common_Strange_Controls
 {$If Defined(Nemesis)}
 , nscTasksPanelView
 {$IfEnd} // Defined(Nemesis)
 , Messages
 , nsCounterEvent
 , LoggingUnit
;

type
 TnsUseTaskPanelOperationEvent = class(TnsCounterEvent)
  protected
   function EventID: TLogEvent; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TnsUseTaskPanelOperationEvent;
    {* Метод получения экземпляра синглетона TnsUseTaskPanelOperationEvent }
 end;//TnsUseTaskPanelOperationEvent

 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\vcmScrollableFormWithWheelSupport.imp.pas}
 TPrimTasksPanelForm = class(_vcmScrollableFormWithWheelSupport_)
  private
   f_tpvMain: TnscTasksPanelView;
    {* Поле для свойства tpvMain }
  private
   procedure WMSetFocus(var aMessage: TMessage); message WM_SETFOCUS;
  protected
   procedure tpvMainOperationExecute(Sender: TObject);
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
  public
   property tpvMain: TnscTasksPanelView
    read f_tpvMain;
 end;//TPrimTasksPanelForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , vcmTaskPanelInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Defaults
 , afwFacade
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , MainMenuNewRes
 , Windows
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Base
;

var g_TnsUseTaskPanelOperationEvent: TnsUseTaskPanelOperationEvent = nil;
 {* Экземпляр синглетона TnsUseTaskPanelOperationEvent }

const
 {* Локализуемые строки tpMainLocalConstants }
 str_tpMainCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'tpMainCaption'; rValue : 'Панель задач');
  {* Заголовок пользовательского типа "Панель задач" }

procedure TnsUseTaskPanelOperationEventFree;
 {* Метод освобождения экземпляра синглетона TnsUseTaskPanelOperationEvent }
begin
 l3Free(g_TnsUseTaskPanelOperationEvent);
end;//TnsUseTaskPanelOperationEventFree

class function TnsUseTaskPanelOperationEvent.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsUseTaskPanelOperationEvent <> nil;
end;//TnsUseTaskPanelOperationEvent.Exists

function TnsUseTaskPanelOperationEvent.EventID: TLogEvent;
//#UC START# *4B13A26203DB_4B13C75E02D1_var*
//#UC END# *4B13A26203DB_4B13C75E02D1_var*
begin
//#UC START# *4B13A26203DB_4B13C75E02D1_impl*
 Result := LE_USE_SUB_PANEL_DOCUMENT_OPERATION;
//#UC END# *4B13A26203DB_4B13C75E02D1_impl*
end;//TnsUseTaskPanelOperationEvent.EventID

class function TnsUseTaskPanelOperationEvent.Instance: TnsUseTaskPanelOperationEvent;
 {* Метод получения экземпляра синглетона TnsUseTaskPanelOperationEvent }
begin
 if (g_TnsUseTaskPanelOperationEvent = nil) then
 begin
  l3System.AddExitProc(TnsUseTaskPanelOperationEventFree);
  g_TnsUseTaskPanelOperationEvent := Create;
 end;
 Result := g_TnsUseTaskPanelOperationEvent;
end;//TnsUseTaskPanelOperationEvent.Instance

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\vcmScrollableFormWithWheelSupport.imp.pas}

procedure TPrimTasksPanelForm.tpvMainOperationExecute(Sender: TObject);
//#UC START# *4EE78AE903D9_4B13C72F0167_var*
//#UC END# *4EE78AE903D9_4B13C72F0167_var*
begin
//#UC START# *4EE78AE903D9_4B13C72F0167_impl*
 TnsUseTaskPanelOperationEvent.Instance.Log;
//#UC END# *4EE78AE903D9_4B13C72F0167_impl*
end;//TPrimTasksPanelForm.tpvMainOperationExecute

procedure TPrimTasksPanelForm.WMSetFocus(var aMessage: TMessage);
//#UC START# *4EE78AC500E3_4B13C72F0167_var*
//#UC END# *4EE78AC500E3_4B13C72F0167_var*
begin
//#UC START# *4EE78AC500E3_4B13C72F0167_impl*
 inherited;
 tpvMain.DefineActiveControl;
//#UC END# *4EE78AC500E3_4B13C72F0167_impl*
end;//TPrimTasksPanelForm.WMSetFocus

{$If NOT Defined(NoVCM)}
procedure TPrimTasksPanelForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4B13C72F0167_var*
var
 l_MainForm: IvcmMainForm;
//#UC END# *4A8E8F2E0195_4B13C72F0167_var*
begin
//#UC START# *4A8E8F2E0195_4B13C72F0167_impl*
 inherited;
 with tpvMain do
 begin
  Align := alClient;
  GroupImages := dmMainMenuNew.ilSmallIcons;
  CollapseGroupImage := 1;
  ExpandGroupImage := 0;
  ImageList := dmStdRes.SmallImageList;
  GroupColor := cGarant2011GradientStartColor{c_MainMenuColor};
 end;
 tpvMain.OnOperationExecute := tpvMainOperationExecute;
 // Настройка панели задач доступна только для внутренней версии:
 if afw.Application.IsInternal then
  tpvMain.PopupMenu := TdmStdRes.TasksPanelPopupMenu;
 if Supports(afw.GetMainForm(Self), IvcmMainForm, l_MainForm) then
 try
  tpvMain.TasksPanel := l_MainForm.TasksPanel;
 finally
  l_MainForm := nil;
 end;{try..finally}
//#UC END# *4A8E8F2E0195_4B13C72F0167_impl*
end;//TPrimTasksPanelForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_tpMainCaption.Init;
 {* Инициализация str_tpMainCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimTasksPanelForm);
 {* Регистрация PrimTasksPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
