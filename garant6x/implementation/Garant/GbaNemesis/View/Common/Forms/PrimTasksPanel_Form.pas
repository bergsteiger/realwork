unit PrimTasksPanel_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/PrimTasksPanel_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Common::View::Common::PrimTasksPanel
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
  Messages
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  Common_Strange_Controls,
  nsCounterEvent,
  l3StringIDEx
  {$If defined(Nemesis)}
  ,
  nscTasksPanelView
  {$IfEnd} //Nemesis
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  LoggingUnit,
  PrimTasksPanel_tpMain_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsUseTaskPanelOperationEvent = class(TnsCounterEvent)
 protected
 // realized methods
   function EventID: TLogEvent; override;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsUseTaskPanelOperationEvent;
    {- возвращает экземпляр синглетона. }
 end;//TnsUseTaskPanelOperationEvent

 _vcmScrollableFormWithWheelSupport_Parent_ = TvcmEntityForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\vcmScrollableFormWithWheelSupport.imp.pas}
 TPrimTasksPanelForm = {form} class(_vcmScrollableFormWithWheelSupport_)
 private
 // private fields
   f_tpvMain : TnscTasksPanelView;
    {* Поле для свойства tpvMain}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure WMSetFocus(var aMessage: TMessage); message WM_SETFOCUS;
 protected
 // realized methods
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   procedure TpvMainOperationExecute(Sender: TObject);
 public
 // public properties
   property tpvMain: TnscTasksPanelView
     read f_tpvMain;
 end;//TPrimTasksPanelForm

 TvcmEntityFormRef = TPrimTasksPanelForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmTaskPanelInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  l3Defaults,
  afwFacade,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  MainMenuNewRes,
  Windows,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\vcmScrollableFormWithWheelSupport.imp.pas}

var
   { Локализуемые строки tpMainLocalConstants }
  str_tpMainCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'tpMainCaption'; rValue : 'Панель задач');
   { Заголовок пользовательского типа "Панель задач" }

// start class TPrimTasksPanelForm

procedure TPrimTasksPanelForm.TpvMainOperationExecute(Sender: TObject);
//#UC START# *4EE78AE903D9_4B13C72F0167_var*
//#UC END# *4EE78AE903D9_4B13C72F0167_var*
begin
//#UC START# *4EE78AE903D9_4B13C72F0167_impl*
 TnsUseTaskPanelOperationEvent.Instance.Log;
//#UC END# *4EE78AE903D9_4B13C72F0167_impl*
end;//TPrimTasksPanelForm.TpvMainOperationExecute

// start class TnsUseTaskPanelOperationEvent

var g_TnsUseTaskPanelOperationEvent : TnsUseTaskPanelOperationEvent = nil;

procedure TnsUseTaskPanelOperationEventFree;
begin
 l3Free(g_TnsUseTaskPanelOperationEvent);
end;

class function TnsUseTaskPanelOperationEvent.Instance: TnsUseTaskPanelOperationEvent;
begin
 if (g_TnsUseTaskPanelOperationEvent = nil) then
 begin
  l3System.AddExitProc(TnsUseTaskPanelOperationEventFree);
  g_TnsUseTaskPanelOperationEvent := Create;
 end;
 Result := g_TnsUseTaskPanelOperationEvent;
end;


class function TnsUseTaskPanelOperationEvent.Exists: Boolean;
 {-}
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

procedure TPrimTasksPanelForm.WMSetFocus(var aMessage: TMessage);
//#UC START# *4EE78AC500E3_4B13C72F0167_var*
//#UC END# *4EE78AC500E3_4B13C72F0167_var*
begin
//#UC START# *4EE78AC500E3_4B13C72F0167_impl*
 inherited;
 tpvMain.DefineActiveControl;
//#UC END# *4EE78AC500E3_4B13C72F0167_impl*
end;//TPrimTasksPanelForm.WMSetFocus

{$If not defined(NoVCM)}
procedure TPrimTasksPanelForm.InitControls;
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
{$IfEnd} //not NoVCM

procedure TPrimTasksPanelForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Fake, nil);
  PublishOp(en_Fake, op_Fake, nil, nil, nil);
  ShowInContextMenu(en_Fake, op_Fake, false);
  ShowInToolbar(en_Fake, op_Fake, false);
 end;//with Entities.Entities
end;

procedure TPrimTasksPanelForm.MakeControls;
begin
 inherited;
 with AddUsertype(tpMainName,
  str_tpMainCaption,
  str_tpMainCaption,
  false,
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
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_tpMainCaption
 str_tpMainCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimTasksPanel
 TtfwClassRef.Register(TPrimTasksPanelForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.