unit PrimTasksPanel_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimTasksPanel_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimTasksPanel" MUID: (4B13C72F0167)
// Имя типа: "TPrimTasksPanelForm"

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
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TnsUseTaskPanelOperationEvent = class(TnsCounterEvent)
  protected
   function EventID: TLogEvent; override;
  public
   class function Instance: TnsUseTaskPanelOperationEvent;
    {* Метод получения экземпляра синглетона TnsUseTaskPanelOperationEvent }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsUseTaskPanelOperationEvent

 _vcmScrollableFormWithWheelSupport_Parent_ = TvcmEntityForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\vcmScrollableFormWithWheelSupport.imp.pas}
 TPrimTasksPanelForm = class(_vcmScrollableFormWithWheelSupport_)
  private
   f_tpvMain: TnscTasksPanelView;
  private
   procedure WMSetFocus(var aMessage: TMessage); message WM_SETFOCUS;
  protected
   procedure tpvMainOperationExecute(Sender: TObject);
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
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
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimTasksPanel_tpMain_UserType
 //#UC START# *4B13C72F0167impl_uses*
 //#UC END# *4B13C72F0167impl_uses*
;

{$If NOT Defined(NoVCM)}
var g_TnsUseTaskPanelOperationEvent: TnsUseTaskPanelOperationEvent = nil;
 {* Экземпляр синглетона TnsUseTaskPanelOperationEvent }

procedure TnsUseTaskPanelOperationEventFree;
 {* Метод освобождения экземпляра синглетона TnsUseTaskPanelOperationEvent }
begin
 l3Free(g_TnsUseTaskPanelOperationEvent);
end;//TnsUseTaskPanelOperationEventFree

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

class function TnsUseTaskPanelOperationEvent.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsUseTaskPanelOperationEvent <> nil;
end;//TnsUseTaskPanelOperationEvent.Exists

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

procedure TPrimTasksPanelForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Fake, nil);
  PublishOp(en_Fake, op_Fake, nil, nil, nil);
  ShowInContextMenu(en_Fake, op_Fake, False);
  ShowInToolbar(en_Fake, op_Fake, False);
 end;//with Entities.Entities
end;//TPrimTasksPanelForm.InitEntities

procedure TPrimTasksPanelForm.MakeControls;
begin
 inherited;
 with AddUsertype(tpMainName,
  str_tpMainCaption,
  str_tpMainCaption,
  False,
  165,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccEnable) do
 begin
 end;//with AddUsertype(tpMainName
 f_tpvMain := TnscTasksPanelView.Create(Self);
 f_tpvMain.Name := 'tpvMain';
 f_tpvMain.Parent := Self;
end;//TPrimTasksPanelForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimTasksPanelForm);
 {* Регистрация PrimTasksPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
