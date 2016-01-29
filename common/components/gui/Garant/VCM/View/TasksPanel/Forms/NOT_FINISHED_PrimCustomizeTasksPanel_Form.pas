unit NOT_FINISHED_PrimCustomizeTasksPanel_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/View/TasksPanel/Forms/NOT_FINISHED_PrimCustomizeTasksPanel_Form.pas"
// Начат: 13.09.2010
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> Shared Delphi Operations::VCMCustomization::View::TasksPanel::PrimCustomizeTasksPanel
//
// Редактор панели задач
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3Interfaces,
  l3TreeInterfaces,
  vcmInterfaces,
  l3Tree_TLB,
  Classes,
  l3Tree
  {$If not defined(NoVCL)}
  ,
  StdCtrls
  {$IfEnd} //not NoVCL
  ,
  eeTreeView,
  vcmEntityForm,
  vcmTaskPanelInterfaces,
  vtPanel,
  vtCtrls,
  eeCheckBox,
  vtGroupBox,
  vtLabel
  {$If not defined(NoVCL)}
  ,
  Buttons
  {$IfEnd} //not NoVCL
  ,
  eeButton,
  vtButton,
  l3NodesModelPart,
  vcmExternalInterfaces {a},
  vcmBase {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TtpState = (
  {* Состояние узла }
   sNone
 , sNew
 , sChanged
 , sDeleted
 );//TtpState

 ItpBaseNode = interface(Il3Node)
  {* Базовый узел дерева }
   ['{316EBEA8-258F-4BA9-8C9C-315CC00EE294}']
   procedure Save;
     {* сохранить изменения }
   function pm_GetState: TtpState;
   procedure pm_SetState(aValue: TtpState);
   property State: TtpState
     read pm_GetState
     write pm_SetState;
 end;//ItpBaseNode

 ItpRepGroupNode = interface(ItpBaseNode)
  {* Узел репозитария групп }
   ['{07E387B8-2DC6-4170-BA75-7EB4685ADFA1}']
   function Get_RepGroup: IvcmCustOpsRepGroup;
   procedure Set_RepGroup(const aValue: IvcmCustOpsRepGroup);
   property RepGroup: IvcmCustOpsRepGroup
     read Get_RepGroup
     write Set_RepGroup;
 end;//ItpRepGroupNode

 ItpTasksPanelNode = interface(ItpBaseNode)
  {* Узел панели задач }
   ['{2E263AEA-CDF1-4F37-AD18-DFFB9FCB1470}']
   function pm_GetPosition: Integer;
   procedure pm_SetPosition(aValue: Integer);
   property Position: Integer
     read pm_GetPosition
     write pm_SetPosition;
     {* позиция операции }
 end;//ItpTasksPanelNode

 ItpGroup = interface(ItpTasksPanelNode)
  {* Группа панели задач }
   ['{BECD8B95-0021-4CED-BB78-50B1E85B2941}']
   function pm_GetRepGroup: IvcmCustOpsRepGroup;
   procedure pm_SetRepGroup(const aValue: IvcmCustOpsRepGroup);
   function pm_GetGroup: IvcmCustOpsGroup;
   procedure pm_SetGroup(const aValue: IvcmCustOpsGroup);
   property RepGroup: IvcmCustOpsRepGroup
     read pm_GetRepGroup
     write pm_SetRepGroup;
   property Group: IvcmCustOpsGroup
     read pm_GetGroup
     write pm_SetGroup;
 end;//ItpGroup

 ItpGroupOperation = interface(ItpTasksPanelNode)
   ['{C1668D24-8965-49AE-98EB-B1BE886AF588}']
   function pm_GetOp: IvcmCustOpsGroupOperation;
   procedure pm_SetOp(const aValue: IvcmCustOpsGroupOperation);
   function pm_GetRepOp: IvcmCustOpsRepOperation;
   procedure pm_SetRepOp(const aValue: IvcmCustOpsRepOperation);
   function pm_GetForAllUseCases: Boolean;
   procedure pm_SetForAllUseCases(aValue: Boolean);
   function pm_GetGroupChanged: Boolean;
   procedure pm_SetGroupChanged(aValue: Boolean);
   property Op: IvcmCustOpsGroupOperation
     read pm_GetOp
     write pm_SetOp;
   property RepOp: IvcmCustOpsRepOperation
     read pm_GetRepOp
     write pm_SetRepOp;
   property ForAllUseCases: Boolean
     read pm_GetForAllUseCases
     write pm_SetForAllUseCases;
     {* всегда показывать в панели при наличии операции }
   property GroupChanged: Boolean
     read pm_GetGroupChanged
     write pm_SetGroupChanged;
 end;//ItpGroupOperation

 ItpRepGroupOperationsNode = interface(ItpBaseNode)
  {* Группа репозитария }
   ['{52E01144-72A4-4233-A459-18F530704F1F}']
   function pm_GetGroup: IvcmCustOpsRepGroupOperations;
   property Group: IvcmCustOpsRepGroupOperations
     read pm_GetGroup;
 end;//ItpRepGroupOperationsNode

 ItpRepOperationNode = interface(ItpBaseNode)
   ['{FAFFA0AB-E97B-4D96-958A-11621C2E37D7}']
   function pm_GetOp: IvcmCustOpsRepOperation;
   property Op: IvcmCustOpsRepOperation
     read pm_GetOp;
 end;//ItpRepOperationNode

 ItpTree = interface(Il3SimpleTree)
  {* Интерефейс дерева групп }
   ['{8AE49184-028C-4160-A01A-89C7A17C9413}']
   procedure Save;
     {* Сигнатура метода Save }
 end;//ItpTree

 TPrimCustomizeTasksPanelForm = {form} class(TvcmEntityForm)
  {* Редактор панели задач }
 private
 // private fields
   f_spRight : TvtSplitter;
    {* Поле для свойства spRight}
   f_pnlBottom : TvtPanel;
    {* Поле для свойства pnlBottom}
   f_lblConfirmSave : TvtLabel;
    {* Поле для свойства lblConfirmSave}
   f_lblAvailableOpsCaption : TvtLabel;
    {* Поле для свойства lblAvailableOpsCaption}
   f_btOk : TvtButton;
    {* Поле для свойства btOk}
   f_btCancel : TvtButton;
    {* Поле для свойства btCancel}
   f_btApply : TvtButton;
    {* Поле для свойства btApply}
   f_pnlRep : TvtPanel;
    {* Поле для свойства pnlRep}
   f_splRep : TvtSplitter;
    {* Поле для свойства splRep}
   f_gbAvailableGroups : TvtGroupBox;
    {* Поле для свойства gbAvailableGroups}
   f_tvRepGroups : TeeTreeView;
    {* Поле для свойства tvRepGroups}
   f_vtPanel1 : TvtPanel;
    {* Поле для свойства vtPanel1}
   f_cbGroupName : TvtComboBox;
    {* Поле для свойства cbGroupName}
   f_btnAddGroup : TeeButton;
    {* Поле для свойства btnAddGroup}
   f_btnChangeGroup : TeeButton;
    {* Поле для свойства btnChangeGroup}
   f_btnDeleteGroup : TeeButton;
    {* Поле для свойства btnDeleteGroup}
   f_gbAvailableOperations : TvtGroupBox;
    {* Поле для свойства gbAvailableOperations}
   f_tvRepOps : TeeTreeView;
    {* Поле для свойства tvRepOps}
   f_pnlForms : TvtPanel;
    {* Поле для свойства pnlForms}
   f_lblForms : TvtLabel;
    {* Поле для свойства lblForms}
   f_cbForms : TComboBox;
    {* Поле для свойства cbForms}
   f_pnlMain : TvtPanel;
    {* Поле для свойства pnlMain}
   f_pnlLeft : TvtPanel;
    {* Поле для свойства pnlLeft}
   f_btnMoveOpToPanel : TBitBtn;
    {* Поле для свойства btnMoveOpToPanel}
   f_btnMoveOpToRep : TBitBtn;
    {* Поле для свойства btnMoveOpToRep}
   f_btnMoveGroupToPanel : TBitBtn;
    {* Поле для свойства btnMoveGroupToPanel}
   f_btnMoveGroupToRep : TBitBtn;
    {* Поле для свойства btnMoveGroupToRep}
   f_pnlTasksPanel : TvtPanel;
    {* Поле для свойства pnlTasksPanel}
   f_gbTasksPanel : TvtGroupBox;
    {* Поле для свойства gbTasksPanel}
   f_tvTasksPanel : TeeTreeView;
    {* Поле для свойства tvTasksPanel}
   f_vtGroupBox3 : TvtGroupBox;
    {* Поле для свойства vtGroupBox3}
   f_lblCaption : TvtLabel;
    {* Поле для свойства lblCaption}
   f_edChange : TvtComboBox;
    {* Поле для свойства edChange}
   f_cbForAllUseCases : TeeCheckBox;
    {* Поле для свойства cbForAllUseCases}
   f_btnChangeItem : TeeButton;
    {* Поле для свойства btnChangeItem}
   f_pnlOperationPos : TvtPanel;
    {* Поле для свойства pnlOperationPos}
   f_UpBitBtn : TBitBtn;
    {* Поле для свойства UpBitBtn}
   f_DownBitBtn : TBitBtn;
    {* Поле для свойства DownBitBtn}
   f_IsChanged : Boolean;
    {* Поле для свойства IsChanged}
 protected
  procedure MakeControls; override;
 private
 // private methods
   procedure TvRepOpsGetItemImage;
     {* Сигнатура метода tvRepOpsGetItemImage }
   procedure CbGroupNameChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure BtnAddGroupClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure BtnChangeGroupClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure TvRepGroupsCurrentChanged;
     {* Сигнатура метода tvRepGroupsCurrentChanged }
   procedure BtnDeleteGroupClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure BtOkClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure BtApplyClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure BtnMoveGroupToPanelClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure TvRepOpsCurrentChanged;
     {* Сигнатура метода tvRepOpsCurrentChanged }
   procedure TvTasksPanelCurrentChanged;
     {* Сигнатура метода tvTasksPanelCurrentChanged }
   procedure BtnMoveOpToPanelClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure TvTasksPanelGetItemImage;
     {* Сигнатура метода tvTasksPanelGetItemImage }
   procedure BtnChangeItemClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure BtnMoveGroupToRepClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure BtnMoveOpToRepClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure CbForAllUseCasesClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure UpBitBtnClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure DownBitBtnClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure CbFormsChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure UpdateState;
     {* Сигнатура метода UpdateState }
   procedure Save;
     {* Сигнатура метода Save }
   function FindRepGroupOps(const aGroup: IvcmCustOpsRepGroupOperations): Il3Node;
   procedure UpdateControls;
     {* Сигнатура метода UpdateControls }
   procedure MoveTasksPanelItem(aUp: Boolean;
     const aNewParent: Il3Node);
   procedure UpdatePositions(const aParent: Il3Node);
   procedure RemoveGroup(const aGroup: Il3Node);
     {* удалить группу панели задач }
   procedure RemoveNode(const aNode: Il3Node);
     {* удалить узел панели задач, без относительно операция это или группа }
   procedure DeleteOp(const aNode: Il3Node);
     {* удалить операцию панели задач }
   procedure ReturnRepOp(const aRepOp: IvcmCustOpsRepOperation);
     {* вернуть операцию в репозиторий }
   function GetSelectedUserType: IvcmUserTypeDef;
 protected
 // property methods
   function pm_GetTasksPanel: IvcmCustOps;
   procedure pm_SetTasksPanel(const aValue: IvcmCustOps);
   procedure pm_SetIsChanged(aValue: Boolean); virtual;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
 protected
 // protected methods
   class function VcmComparePostions(const aNode1: Il3Node;
     const aNode2: Il3Node): Integer;
 public
 // public methods
   class function Make(const aPanel: IvcmCustOps;
     const aParams : IvcmMakeParams = nil;
     aZoneType     : TvcmZoneType = vcm_ztAny;
     aUserType     : TvcmEffectiveUserType = 0;
     aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
     {* Фабрика }
 private
 // private properties
   property IsChanged: Boolean
     read f_IsChanged
     write pm_SetIsChanged;
 public
 // public properties
   property spRight: TvtSplitter
     read f_spRight;
   property pnlBottom: TvtPanel
     read f_pnlBottom;
   property lblConfirmSave: TvtLabel
     read f_lblConfirmSave;
     {* Объект системы изменен. Применить изменения? }
   property lblAvailableOpsCaption: TvtLabel
     read f_lblAvailableOpsCaption;
     {* Редактор доступных операций панели инструментов }
   property btOk: TvtButton
     read f_btOk;
     {* Ок }
   property btCancel: TvtButton
     read f_btCancel;
     {* Отмена }
   property btApply: TvtButton
     read f_btApply;
     {* Применить }
   property pnlRep: TvtPanel
     read f_pnlRep;
   property splRep: TvtSplitter
     read f_splRep;
   property gbAvailableGroups: TvtGroupBox
     read f_gbAvailableGroups;
     {* Доступные группы: }
   property tvRepGroups: TeeTreeView
     read f_tvRepGroups;
   property vtPanel1: TvtPanel
     read f_vtPanel1;
   property cbGroupName: TvtComboBox
     read f_cbGroupName;
   property btnAddGroup: TeeButton
     read f_btnAddGroup;
     {* Добавить }
   property btnChangeGroup: TeeButton
     read f_btnChangeGroup;
     {* Изменить }
   property btnDeleteGroup: TeeButton
     read f_btnDeleteGroup;
     {* Удалить }
   property gbAvailableOperations: TvtGroupBox
     read f_gbAvailableOperations;
     {* Доступные операции: }
   property tvRepOps: TeeTreeView
     read f_tvRepOps;
   property pnlForms: TvtPanel
     read f_pnlForms;
   property lblForms: TvtLabel
     read f_lblForms;
     {* Выберите форму: }
   property cbForms: TComboBox
     read f_cbForms;
   property pnlMain: TvtPanel
     read f_pnlMain;
   property pnlLeft: TvtPanel
     read f_pnlLeft;
   property btnMoveOpToPanel: TBitBtn
     read f_btnMoveOpToPanel;
   property btnMoveOpToRep: TBitBtn
     read f_btnMoveOpToRep;
   property btnMoveGroupToPanel: TBitBtn
     read f_btnMoveGroupToPanel;
   property btnMoveGroupToRep: TBitBtn
     read f_btnMoveGroupToRep;
   property pnlTasksPanel: TvtPanel
     read f_pnlTasksPanel;
   property gbTasksPanel: TvtGroupBox
     read f_gbTasksPanel;
     {* Текущая панель задач: }
   property tvTasksPanel: TeeTreeView
     read f_tvTasksPanel;
   property vtGroupBox3: TvtGroupBox
     read f_vtGroupBox3;
     {* Текущий элемент: }
   property lblCaption: TvtLabel
     read f_lblCaption;
     {* Название: }
   property edChange: TvtComboBox
     read f_edChange;
   property cbForAllUseCases: TeeCheckBox
     read f_cbForAllUseCases;
     {* Для всех панелей задач }
   property btnChangeItem: TeeButton
     read f_btnChangeItem;
     {* Изменить }
   property pnlOperationPos: TvtPanel
     read f_pnlOperationPos;
   property UpBitBtn: TBitBtn
     read f_UpBitBtn;
   property DownBitBtn: TBitBtn
     read f_DownBitBtn;
   property TasksPanel: IvcmCustOps
     read pm_GetTasksPanel
     write pm_SetTasksPanel;
 end;//TPrimCustomizeTasksPanelForm

 TvcmEntityFormRef = TPrimCustomizeTasksPanelForm;
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  CustomizeTasksPanelRes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a},
  l3Base {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TPrimCustomizeTasksPanelForm

procedure TPrimCustomizeTasksPanelForm.TvRepOpsGetItemImage;
//#UC START# *5397160601D9_4C8E4D21001F_var*
//#UC END# *5397160601D9_4C8E4D21001F_var*
begin
//#UC START# *5397160601D9_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397160601D9_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.TvRepOpsGetItemImage

procedure TPrimCustomizeTasksPanelForm.CbGroupNameChange(Sender: TObject);
//#UC START# *5397162701C7_4C8E4D21001F_var*
//#UC END# *5397162701C7_4C8E4D21001F_var*
begin
//#UC START# *5397162701C7_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397162701C7_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.CbGroupNameChange

procedure TPrimCustomizeTasksPanelForm.BtnAddGroupClick(Sender: TObject);
//#UC START# *5397163F0110_4C8E4D21001F_var*
//#UC END# *5397163F0110_4C8E4D21001F_var*
begin
//#UC START# *5397163F0110_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397163F0110_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.BtnAddGroupClick

procedure TPrimCustomizeTasksPanelForm.BtnChangeGroupClick(Sender: TObject);
//#UC START# *5397165B00E5_4C8E4D21001F_var*
//#UC END# *5397165B00E5_4C8E4D21001F_var*
begin
//#UC START# *5397165B00E5_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397165B00E5_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.BtnChangeGroupClick

procedure TPrimCustomizeTasksPanelForm.TvRepGroupsCurrentChanged;
//#UC START# *5397166401F3_4C8E4D21001F_var*
//#UC END# *5397166401F3_4C8E4D21001F_var*
begin
//#UC START# *5397166401F3_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397166401F3_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.TvRepGroupsCurrentChanged

procedure TPrimCustomizeTasksPanelForm.BtnDeleteGroupClick(Sender: TObject);
//#UC START# *5397166E0319_4C8E4D21001F_var*
//#UC END# *5397166E0319_4C8E4D21001F_var*
begin
//#UC START# *5397166E0319_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397166E0319_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.BtnDeleteGroupClick

procedure TPrimCustomizeTasksPanelForm.BtOkClick(Sender: TObject);
//#UC START# *53971677023D_4C8E4D21001F_var*
//#UC END# *53971677023D_4C8E4D21001F_var*
begin
//#UC START# *53971677023D_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53971677023D_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.BtOkClick

procedure TPrimCustomizeTasksPanelForm.BtApplyClick(Sender: TObject);
//#UC START# *53971685025A_4C8E4D21001F_var*
//#UC END# *53971685025A_4C8E4D21001F_var*
begin
//#UC START# *53971685025A_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53971685025A_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.BtApplyClick

procedure TPrimCustomizeTasksPanelForm.BtnMoveGroupToPanelClick(Sender: TObject);
//#UC START# *539716C1038C_4C8E4D21001F_var*
//#UC END# *539716C1038C_4C8E4D21001F_var*
begin
//#UC START# *539716C1038C_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539716C1038C_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.BtnMoveGroupToPanelClick

procedure TPrimCustomizeTasksPanelForm.TvRepOpsCurrentChanged;
//#UC START# *539716CB0215_4C8E4D21001F_var*
//#UC END# *539716CB0215_4C8E4D21001F_var*
begin
//#UC START# *539716CB0215_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539716CB0215_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.TvRepOpsCurrentChanged

procedure TPrimCustomizeTasksPanelForm.TvTasksPanelCurrentChanged;
//#UC START# *539716D400B2_4C8E4D21001F_var*
//#UC END# *539716D400B2_4C8E4D21001F_var*
begin
//#UC START# *539716D400B2_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539716D400B2_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.TvTasksPanelCurrentChanged

procedure TPrimCustomizeTasksPanelForm.BtnMoveOpToPanelClick(Sender: TObject);
//#UC START# *539716DC0168_4C8E4D21001F_var*
//#UC END# *539716DC0168_4C8E4D21001F_var*
begin
//#UC START# *539716DC0168_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539716DC0168_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.BtnMoveOpToPanelClick

procedure TPrimCustomizeTasksPanelForm.TvTasksPanelGetItemImage;
//#UC START# *539716E6010C_4C8E4D21001F_var*
//#UC END# *539716E6010C_4C8E4D21001F_var*
begin
//#UC START# *539716E6010C_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539716E6010C_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.TvTasksPanelGetItemImage

procedure TPrimCustomizeTasksPanelForm.BtnChangeItemClick(Sender: TObject);
//#UC START# *539716F1001F_4C8E4D21001F_var*
//#UC END# *539716F1001F_4C8E4D21001F_var*
begin
//#UC START# *539716F1001F_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539716F1001F_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.BtnChangeItemClick

procedure TPrimCustomizeTasksPanelForm.BtnMoveGroupToRepClick(Sender: TObject);
//#UC START# *539716F90347_4C8E4D21001F_var*
//#UC END# *539716F90347_4C8E4D21001F_var*
begin
//#UC START# *539716F90347_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539716F90347_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.BtnMoveGroupToRepClick

procedure TPrimCustomizeTasksPanelForm.BtnMoveOpToRepClick(Sender: TObject);
//#UC START# *53971707031F_4C8E4D21001F_var*
//#UC END# *53971707031F_4C8E4D21001F_var*
begin
//#UC START# *53971707031F_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53971707031F_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.BtnMoveOpToRepClick

procedure TPrimCustomizeTasksPanelForm.CbForAllUseCasesClick(Sender: TObject);
//#UC START# *53971712035F_4C8E4D21001F_var*
//#UC END# *53971712035F_4C8E4D21001F_var*
begin
//#UC START# *53971712035F_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53971712035F_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.CbForAllUseCasesClick

procedure TPrimCustomizeTasksPanelForm.UpBitBtnClick(Sender: TObject);
//#UC START# *5397171D03AB_4C8E4D21001F_var*
//#UC END# *5397171D03AB_4C8E4D21001F_var*
begin
//#UC START# *5397171D03AB_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397171D03AB_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.UpBitBtnClick

procedure TPrimCustomizeTasksPanelForm.DownBitBtnClick(Sender: TObject);
//#UC START# *53971727008B_4C8E4D21001F_var*
//#UC END# *53971727008B_4C8E4D21001F_var*
begin
//#UC START# *53971727008B_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53971727008B_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.DownBitBtnClick

procedure TPrimCustomizeTasksPanelForm.CbFormsChange(Sender: TObject);
//#UC START# *5397173100AF_4C8E4D21001F_var*
//#UC END# *5397173100AF_4C8E4D21001F_var*
begin
//#UC START# *5397173100AF_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397173100AF_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.CbFormsChange

procedure TPrimCustomizeTasksPanelForm.UpdateState;
//#UC START# *539719370059_4C8E4D21001F_var*
//#UC END# *539719370059_4C8E4D21001F_var*
begin
//#UC START# *539719370059_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539719370059_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.UpdateState

procedure TPrimCustomizeTasksPanelForm.Save;
//#UC START# *5397193E01AE_4C8E4D21001F_var*
//#UC END# *5397193E01AE_4C8E4D21001F_var*
begin
//#UC START# *5397193E01AE_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397193E01AE_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.Save

function TPrimCustomizeTasksPanelForm.FindRepGroupOps(const aGroup: IvcmCustOpsRepGroupOperations): Il3Node;
//#UC START# *5397194B015D_4C8E4D21001F_var*
//#UC END# *5397194B015D_4C8E4D21001F_var*
begin
//#UC START# *5397194B015D_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397194B015D_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.FindRepGroupOps

procedure TPrimCustomizeTasksPanelForm.UpdateControls;
//#UC START# *53971960001A_4C8E4D21001F_var*
//#UC END# *53971960001A_4C8E4D21001F_var*
begin
//#UC START# *53971960001A_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53971960001A_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.UpdateControls

procedure TPrimCustomizeTasksPanelForm.MoveTasksPanelItem(aUp: Boolean;
  const aNewParent: Il3Node);
//#UC START# *5397196E005A_4C8E4D21001F_var*
//#UC END# *5397196E005A_4C8E4D21001F_var*
begin
//#UC START# *5397196E005A_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397196E005A_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.MoveTasksPanelItem

procedure TPrimCustomizeTasksPanelForm.UpdatePositions(const aParent: Il3Node);
//#UC START# *5397198300E4_4C8E4D21001F_var*
//#UC END# *5397198300E4_4C8E4D21001F_var*
begin
//#UC START# *5397198300E4_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397198300E4_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.UpdatePositions

procedure TPrimCustomizeTasksPanelForm.RemoveGroup(const aGroup: Il3Node);
//#UC START# *539719990176_4C8E4D21001F_var*
//#UC END# *539719990176_4C8E4D21001F_var*
begin
//#UC START# *539719990176_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539719990176_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.RemoveGroup

procedure TPrimCustomizeTasksPanelForm.RemoveNode(const aNode: Il3Node);
//#UC START# *539719B300A9_4C8E4D21001F_var*
//#UC END# *539719B300A9_4C8E4D21001F_var*
begin
//#UC START# *539719B300A9_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539719B300A9_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.RemoveNode

procedure TPrimCustomizeTasksPanelForm.DeleteOp(const aNode: Il3Node);
//#UC START# *539719D803D8_4C8E4D21001F_var*
//#UC END# *539719D803D8_4C8E4D21001F_var*
begin
//#UC START# *539719D803D8_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539719D803D8_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.DeleteOp

procedure TPrimCustomizeTasksPanelForm.ReturnRepOp(const aRepOp: IvcmCustOpsRepOperation);
//#UC START# *539719F00157_4C8E4D21001F_var*
//#UC END# *539719F00157_4C8E4D21001F_var*
begin
//#UC START# *539719F00157_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539719F00157_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.ReturnRepOp

function TPrimCustomizeTasksPanelForm.GetSelectedUserType: IvcmUserTypeDef;
//#UC START# *53971A0D001F_4C8E4D21001F_var*
//#UC END# *53971A0D001F_4C8E4D21001F_var*
begin
//#UC START# *53971A0D001F_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53971A0D001F_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.GetSelectedUserType

class function TPrimCustomizeTasksPanelForm.Make(const aPanel: IvcmCustOps;
  const aParams : IvcmMakeParams = nil;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TPrimCustomizeTasksPanelForm);
 begin
  with aForm do
  begin
//#UC START# *4C8E51FA022E_4C8E4D21001F_impl*
   TasksPanel := aPanel;
//#UC END# *4C8E51FA022E_4C8E4D21001F_impl*
  end;//with aForm
 end;

var
 l_AC : TvcmInitProc;
 l_ACHack : Pointer absolute l_AC;
begin
 l_AC := l3LocalStub(@AfterCreate);
 try
  Result := inherited Make(aParams, aZoneType, aUserType, nil, aDataSource, vcm_utAny, l_AC);
 finally
  l3FreeLocalStub(l_ACHack);
 end;//try..finally
end;

class function TPrimCustomizeTasksPanelForm.VcmComparePostions(const aNode1: Il3Node;
  const aNode2: Il3Node): Integer;
//#UC START# *53973C440228_4C8E4D21001F_var*
//#UC END# *53973C440228_4C8E4D21001F_var*
begin
//#UC START# *53973C440228_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53973C440228_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.VcmComparePostions

type
  TvcmBaseNode = class(Tl3UsualNode, ItpBaseNode)
  private
  // private fields
   f_State : TtpState;
    {* Поле для свойства State}
  protected
  // realized methods
   procedure Remove;
     {* удалить узел из дерева. }
   function Get_AllChildrenCount: Integer;
   function Get_NextNode: Il3Node;
   function Get_PrevNode: Il3Node;
   function Get_ParentNode: Il3Node;
   function Get_ChildNode: Il3Node;
   function pm_GetState: TtpState;
   procedure pm_SetState(aValue: TtpState);
   procedure Save;
     {* сохранить изменения }
  protected
  // protected methods
   procedure DoSave; virtual;
     {* Сигнатура метода DoSave }
  public
  // public methods
   constructor Create; reintroduce;
     {* Сигнатура метода Create }
  protected
  // protected properties
   property State: TtpState
     read pm_GetState
     write pm_SetState;
  end;//TvcmBaseNode

// start class TvcmBaseNode

procedure TvcmBaseNode.DoSave;
//#UC START# *53972500009A_5397246F0175_var*
//#UC END# *53972500009A_5397246F0175_var*
begin
//#UC START# *53972500009A_5397246F0175_impl*
 !!! Needs to be implemented !!!
//#UC END# *53972500009A_5397246F0175_impl*
end;//TvcmBaseNode.DoSave

constructor TvcmBaseNode.Create;
//#UC START# *5397295A01BA_5397246F0175_var*
//#UC END# *5397295A01BA_5397246F0175_var*
begin
//#UC START# *5397295A01BA_5397246F0175_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397295A01BA_5397246F0175_impl*
end;//TvcmBaseNode.Create

procedure TvcmBaseNode.Remove;
//#UC START# *47710C6002AA_5397246F0175_var*
//#UC END# *47710C6002AA_5397246F0175_var*
begin
//#UC START# *47710C6002AA_5397246F0175_impl*
 !!! Needs to be implemented !!!
//#UC END# *47710C6002AA_5397246F0175_impl*
end;//TvcmBaseNode.Remove

function TvcmBaseNode.Get_AllChildrenCount: Integer;
//#UC START# *47710E730361_5397246F0175get_var*
//#UC END# *47710E730361_5397246F0175get_var*
begin
//#UC START# *47710E730361_5397246F0175get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47710E730361_5397246F0175get_impl*
end;//TvcmBaseNode.Get_AllChildrenCount

function TvcmBaseNode.Get_NextNode: Il3Node;
//#UC START# *4771102F01C3_5397246F0175get_var*
//#UC END# *4771102F01C3_5397246F0175get_var*
begin
//#UC START# *4771102F01C3_5397246F0175get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771102F01C3_5397246F0175get_impl*
end;//TvcmBaseNode.Get_NextNode

function TvcmBaseNode.Get_PrevNode: Il3Node;
//#UC START# *477110580184_5397246F0175get_var*
//#UC END# *477110580184_5397246F0175get_var*
begin
//#UC START# *477110580184_5397246F0175get_impl*
 !!! Needs to be implemented !!!
//#UC END# *477110580184_5397246F0175get_impl*
end;//TvcmBaseNode.Get_PrevNode

function TvcmBaseNode.Get_ParentNode: Il3Node;
//#UC START# *4771108100D0_5397246F0175get_var*
//#UC END# *4771108100D0_5397246F0175get_var*
begin
//#UC START# *4771108100D0_5397246F0175get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771108100D0_5397246F0175get_impl*
end;//TvcmBaseNode.Get_ParentNode

function TvcmBaseNode.Get_ChildNode: Il3Node;
//#UC START# *477110A2026C_5397246F0175get_var*
//#UC END# *477110A2026C_5397246F0175get_var*
begin
//#UC START# *477110A2026C_5397246F0175get_impl*
 !!! Needs to be implemented !!!
//#UC END# *477110A2026C_5397246F0175get_impl*
end;//TvcmBaseNode.Get_ChildNode

function TvcmBaseNode.pm_GetState: TtpState;
//#UC START# *539720060390_5397246F0175get_var*
//#UC END# *539720060390_5397246F0175get_var*
begin
//#UC START# *539720060390_5397246F0175get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539720060390_5397246F0175get_impl*
end;//TvcmBaseNode.pm_GetState

procedure TvcmBaseNode.pm_SetState(aValue: TtpState);
//#UC START# *539720060390_5397246F0175set_var*
//#UC END# *539720060390_5397246F0175set_var*
begin
//#UC START# *539720060390_5397246F0175set_impl*
 !!! Needs to be implemented !!!
//#UC END# *539720060390_5397246F0175set_impl*
end;//TvcmBaseNode.pm_SetState

procedure TvcmBaseNode.Save;
//#UC START# *5397202C0298_5397246F0175_var*
//#UC END# *5397202C0298_5397246F0175_var*
begin
//#UC START# *5397202C0298_5397246F0175_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397202C0298_5397246F0175_impl*
end;//TvcmBaseNode.Save

type
  TvcmCustOpsRootNode = class(Tl3RootNode)
  protected
  // realized methods
   procedure Remove;
     {* удалить узел из дерева. }
   function Get_AllChildrenCount: Integer;
   function Get_NextNode: Il3Node;
   function Get_PrevNode: Il3Node;
   function Get_ParentNode: Il3Node;
   function Get_ChildNode: Il3Node;
  end;//TvcmCustOpsRootNode

// start class TvcmCustOpsRootNode

procedure TvcmCustOpsRootNode.Remove;
//#UC START# *47710C6002AA_5397256F007A_var*
//#UC END# *47710C6002AA_5397256F007A_var*
begin
//#UC START# *47710C6002AA_5397256F007A_impl*
 !!! Needs to be implemented !!!
//#UC END# *47710C6002AA_5397256F007A_impl*
end;//TvcmCustOpsRootNode.Remove

function TvcmCustOpsRootNode.Get_AllChildrenCount: Integer;
//#UC START# *47710E730361_5397256F007Aget_var*
//#UC END# *47710E730361_5397256F007Aget_var*
begin
//#UC START# *47710E730361_5397256F007Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *47710E730361_5397256F007Aget_impl*
end;//TvcmCustOpsRootNode.Get_AllChildrenCount

function TvcmCustOpsRootNode.Get_NextNode: Il3Node;
//#UC START# *4771102F01C3_5397256F007Aget_var*
//#UC END# *4771102F01C3_5397256F007Aget_var*
begin
//#UC START# *4771102F01C3_5397256F007Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771102F01C3_5397256F007Aget_impl*
end;//TvcmCustOpsRootNode.Get_NextNode

function TvcmCustOpsRootNode.Get_PrevNode: Il3Node;
//#UC START# *477110580184_5397256F007Aget_var*
//#UC END# *477110580184_5397256F007Aget_var*
begin
//#UC START# *477110580184_5397256F007Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *477110580184_5397256F007Aget_impl*
end;//TvcmCustOpsRootNode.Get_PrevNode

function TvcmCustOpsRootNode.Get_ParentNode: Il3Node;
//#UC START# *4771108100D0_5397256F007Aget_var*
//#UC END# *4771108100D0_5397256F007Aget_var*
begin
//#UC START# *4771108100D0_5397256F007Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771108100D0_5397256F007Aget_impl*
end;//TvcmCustOpsRootNode.Get_ParentNode

function TvcmCustOpsRootNode.Get_ChildNode: Il3Node;
//#UC START# *477110A2026C_5397256F007Aget_var*
//#UC END# *477110A2026C_5397256F007Aget_var*
begin
//#UC START# *477110A2026C_5397256F007Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *477110A2026C_5397256F007Aget_impl*
end;//TvcmCustOpsRootNode.Get_ChildNode

type
  TvcmCustOpsNode = class(TvcmBaseNode, ItpTasksPanelNode)
  private
  // private fields
   f_Position : Integer;
    {* Поле для свойства Position}
  private
  // private methods
   procedure DoSetPosition(aValue: Integer); virtual; abstract;
  protected
  // realized methods
   function pm_GetPosition: Integer;
   procedure pm_SetPosition(aValue: Integer);
  protected
  // protected properties
   property Position: Integer
     read pm_GetPosition
     write pm_SetPosition;
  end;//TvcmCustOpsNode

// start class TvcmCustOpsNode

function TvcmCustOpsNode.pm_GetPosition: Integer;
//#UC START# *5397209700B8_539725B701B4get_var*
//#UC END# *5397209700B8_539725B701B4get_var*
begin
//#UC START# *5397209700B8_539725B701B4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397209700B8_539725B701B4get_impl*
end;//TvcmCustOpsNode.pm_GetPosition

procedure TvcmCustOpsNode.pm_SetPosition(aValue: Integer);
//#UC START# *5397209700B8_539725B701B4set_var*
//#UC END# *5397209700B8_539725B701B4set_var*
begin
//#UC START# *5397209700B8_539725B701B4set_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397209700B8_539725B701B4set_impl*
end;//TvcmCustOpsNode.pm_SetPosition

type
  TvcmGroup = class(TvcmCustOpsNode, ItpGroup)
   {* Группа панели задач }
  private
  // private fields
   f_Group : IvcmCustOpsGroup;
    {* Поле для свойства Group}
   f_RepGroup : IvcmCustOpsRepGroup;
    {* Поле для свойства RepGroup}
  private
  // private methods
   procedure LoadOps;
     {* Сигнатура метода LoadOps }
  protected
  // realized methods
   function pm_GetRepGroup: IvcmCustOpsRepGroup;
   procedure pm_SetRepGroup(const aValue: IvcmCustOpsRepGroup);
   function pm_GetGroup: IvcmCustOpsGroup;
   procedure pm_SetGroup(const aValue: IvcmCustOpsGroup);
   procedure DoSetPosition(aValue: Integer); override;
  protected
  // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen); override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
   procedure DoSave; override;
     {* Сигнатура метода DoSave }
  public
  // public methods
   constructor Create(const aGroup: IvcmCustOpsGroup); overload; 
   class function Make(const aGroup: IvcmCustOpsGroup): Il3Node; reintroduce; overload; 
     {* Сигнатура фабрики TvcmGroup.Make$1 }
   constructor Create(const aText: Tl3PCharLenPrim;
      const aRepGroup: IvcmCustOpsRepGroup); overload; 
   class function Make(const aText: Tl3PCharLenPrim;
      const aRepGroup: IvcmCustOpsRepGroup): Il3Node; reintroduce; overload; 
     {* Сигнатура фабрики TvcmGroup.Make$2 }
  protected
  // protected properties
   property Group: IvcmCustOpsGroup
     read f_Group;
   property RepGroup: IvcmCustOpsRepGroup
     read f_RepGroup;
  end;//TvcmGroup

// start class TvcmGroup

procedure TvcmGroup.LoadOps;
//#UC START# *5397276701BB_539726940063_var*
//#UC END# *5397276701BB_539726940063_var*
begin
//#UC START# *5397276701BB_539726940063_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397276701BB_539726940063_impl*
end;//TvcmGroup.LoadOps

constructor TvcmGroup.Create(const aGroup: IvcmCustOpsGroup);
//#UC START# *539728AF00C2_539726940063_var*
//#UC END# *539728AF00C2_539726940063_var*
begin
//#UC START# *539728AF00C2_539726940063_impl*
 !!! Needs to be implemented !!!
//#UC END# *539728AF00C2_539726940063_impl*
end;//TvcmGroup.Create

class function TvcmGroup.Make(const aGroup: IvcmCustOpsGroup): Il3Node;
var
 l_Inst : TvcmGroup;
begin
 l_Inst := Create(aGroup);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

constructor TvcmGroup.Create(const aText: Tl3PCharLenPrim;
  const aRepGroup: IvcmCustOpsRepGroup);
//#UC START# *53972905022F_539726940063_var*
//#UC END# *53972905022F_539726940063_var*
begin
//#UC START# *53972905022F_539726940063_impl*
 !!! Needs to be implemented !!!
//#UC END# *53972905022F_539726940063_impl*
end;//TvcmGroup.Create

class function TvcmGroup.Make(const aText: Tl3PCharLenPrim;
  const aRepGroup: IvcmCustOpsRepGroup): Il3Node;
var
 l_Inst : TvcmGroup;
begin
 l_Inst := Create(aText, aRepGroup);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TvcmGroup.pm_GetRepGroup: IvcmCustOpsRepGroup;
//#UC START# *539721310077_539726940063get_var*
//#UC END# *539721310077_539726940063get_var*
begin
//#UC START# *539721310077_539726940063get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539721310077_539726940063get_impl*
end;//TvcmGroup.pm_GetRepGroup

procedure TvcmGroup.pm_SetRepGroup(const aValue: IvcmCustOpsRepGroup);
//#UC START# *539721310077_539726940063set_var*
//#UC END# *539721310077_539726940063set_var*
begin
//#UC START# *539721310077_539726940063set_impl*
 !!! Needs to be implemented !!!
//#UC END# *539721310077_539726940063set_impl*
end;//TvcmGroup.pm_SetRepGroup

function TvcmGroup.pm_GetGroup: IvcmCustOpsGroup;
//#UC START# *5397213B01F7_539726940063get_var*
//#UC END# *5397213B01F7_539726940063get_var*
begin
//#UC START# *5397213B01F7_539726940063get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397213B01F7_539726940063get_impl*
end;//TvcmGroup.pm_GetGroup

procedure TvcmGroup.pm_SetGroup(const aValue: IvcmCustOpsGroup);
//#UC START# *5397213B01F7_539726940063set_var*
//#UC END# *5397213B01F7_539726940063set_var*
begin
//#UC START# *5397213B01F7_539726940063set_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397213B01F7_539726940063set_impl*
end;//TvcmGroup.pm_SetGroup

procedure TvcmGroup.DoSetPosition(aValue: Integer);
//#UC START# *5397264A01C8_539726940063_var*
//#UC END# *5397264A01C8_539726940063_var*
begin
//#UC START# *5397264A01C8_539726940063_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397264A01C8_539726940063_impl*
end;//TvcmGroup.DoSetPosition

procedure TvcmGroup.Cleanup;
//#UC START# *479731C50290_539726940063_var*
//#UC END# *479731C50290_539726940063_var*
begin
//#UC START# *479731C50290_539726940063_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_539726940063_impl*
end;//TvcmGroup.Cleanup

procedure TvcmGroup.DoSetAsPCharLen(const Value: Tl3PCharLen);
//#UC START# *47A869D10074_539726940063_var*
//#UC END# *47A869D10074_539726940063_var*
begin
//#UC START# *47A869D10074_539726940063_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A869D10074_539726940063_impl*
end;//TvcmGroup.DoSetAsPCharLen

procedure TvcmGroup.ClearFields;
 {-}
begin
 {$If not defined(NoVCM)}
 f_Group := nil;
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 f_RepGroup := nil;
 {$IfEnd} //not NoVCM
 inherited;
end;//TvcmGroup.ClearFields

procedure TvcmGroup.DoSave;
//#UC START# *53972500009A_539726940063_var*
//#UC END# *53972500009A_539726940063_var*
begin
//#UC START# *53972500009A_539726940063_impl*
 !!! Needs to be implemented !!!
//#UC END# *53972500009A_539726940063_impl*
end;//TvcmGroup.DoSave

type
  TvcmGroupOperation = class(TvcmCustOpsNode, ItpGroupOperation)
  private
  // private fields
   f_Op : IvcmCustOpsGroupOperation;
    {* Поле для свойства Op}
   f_RepOp : IvcmCustOpsRepOperation;
    {* Поле для свойства RepOp}
   f_ForAllUseCases : Boolean;
    {* Поле для свойства ForAllUseCases}
   f_GroupChanged : Boolean;
    {* Поле для свойства GroupChanged}
  protected
  // property methods
   function pm_GetGroup: ItpGroup;
  protected
  // realized methods
   function pm_GetOp: IvcmCustOpsGroupOperation;
   procedure pm_SetOp(const aValue: IvcmCustOpsGroupOperation);
   function pm_GetRepOp: IvcmCustOpsRepOperation;
   procedure pm_SetRepOp(const aValue: IvcmCustOpsRepOperation);
   function pm_GetForAllUseCases: Boolean;
   procedure pm_SetForAllUseCases(aValue: Boolean);
   function pm_GetGroupChanged: Boolean;
   procedure pm_SetGroupChanged(aValue: Boolean);
   procedure DoSetPosition(aValue: Integer); override;
  protected
  // overridden protected methods
   procedure InitFields; override;
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen); override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
   procedure DoSave; override;
     {* Сигнатура метода DoSave }
  public
  // public methods
   constructor Create(const aOp: IvcmCustOpsGroupOperation); overload; 
   constructor Create(const aRepOp: IvcmCustOpsRepOperation); overload; 
   class function Make(const aOp: IvcmCustOpsGroupOperation): Il3Node; reintroduce; overload; 
     {* Сигнатура фабрики TvcmGroupOperation.Make$1 }
   class function Make(const aRepOp: IvcmCustOpsRepOperation): Il3Node; reintroduce; overload; 
     {* Сигнатура фабрики TvcmGroupOperation.Make$2 }
  protected
  // protected properties
   property Op: IvcmCustOpsGroupOperation
     read f_Op
     write f_Op;
   property RepOp: IvcmCustOpsRepOperation
     read f_RepOp
     write f_RepOp;
   property ForAllUseCases: Boolean
     read pm_GetForAllUseCases
     write pm_SetForAllUseCases;
   property GroupChanged: Boolean
     read pm_GetGroupChanged
     write pm_SetGroupChanged;
   property Group: ItpGroup
     read pm_GetGroup;
  end;//TvcmGroupOperation

// start class TvcmGroupOperation

constructor TvcmGroupOperation.Create(const aOp: IvcmCustOpsGroupOperation);
//#UC START# *5397303B0195_539729990330_var*
//#UC END# *5397303B0195_539729990330_var*
begin
//#UC START# *5397303B0195_539729990330_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397303B0195_539729990330_impl*
end;//TvcmGroupOperation.Create

constructor TvcmGroupOperation.Create(const aRepOp: IvcmCustOpsRepOperation);
//#UC START# *5397305603D4_539729990330_var*
//#UC END# *5397305603D4_539729990330_var*
begin
//#UC START# *5397305603D4_539729990330_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397305603D4_539729990330_impl*
end;//TvcmGroupOperation.Create

class function TvcmGroupOperation.Make(const aOp: IvcmCustOpsGroupOperation): Il3Node;
var
 l_Inst : TvcmGroupOperation;
begin
 l_Inst := Create(aOp);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

class function TvcmGroupOperation.Make(const aRepOp: IvcmCustOpsRepOperation): Il3Node;
var
 l_Inst : TvcmGroupOperation;
begin
 l_Inst := Create(aRepOp);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TvcmGroupOperation.pm_GetGroup: ItpGroup;
//#UC START# *53972F530397_539729990330get_var*
//#UC END# *53972F530397_539729990330get_var*
begin
//#UC START# *53972F530397_539729990330get_impl*
 !!! Needs to be implemented !!!
//#UC END# *53972F530397_539729990330get_impl*
end;//TvcmGroupOperation.pm_GetGroup

function TvcmGroupOperation.pm_GetOp: IvcmCustOpsGroupOperation;
//#UC START# *539721C90125_539729990330get_var*
//#UC END# *539721C90125_539729990330get_var*
begin
//#UC START# *539721C90125_539729990330get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539721C90125_539729990330get_impl*
end;//TvcmGroupOperation.pm_GetOp

procedure TvcmGroupOperation.pm_SetOp(const aValue: IvcmCustOpsGroupOperation);
//#UC START# *539721C90125_539729990330set_var*
//#UC END# *539721C90125_539729990330set_var*
begin
//#UC START# *539721C90125_539729990330set_impl*
 !!! Needs to be implemented !!!
//#UC END# *539721C90125_539729990330set_impl*
end;//TvcmGroupOperation.pm_SetOp

function TvcmGroupOperation.pm_GetRepOp: IvcmCustOpsRepOperation;
//#UC START# *539721CC02A5_539729990330get_var*
//#UC END# *539721CC02A5_539729990330get_var*
begin
//#UC START# *539721CC02A5_539729990330get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539721CC02A5_539729990330get_impl*
end;//TvcmGroupOperation.pm_GetRepOp

procedure TvcmGroupOperation.pm_SetRepOp(const aValue: IvcmCustOpsRepOperation);
//#UC START# *539721CC02A5_539729990330set_var*
//#UC END# *539721CC02A5_539729990330set_var*
begin
//#UC START# *539721CC02A5_539729990330set_impl*
 !!! Needs to be implemented !!!
//#UC END# *539721CC02A5_539729990330set_impl*
end;//TvcmGroupOperation.pm_SetRepOp

function TvcmGroupOperation.pm_GetForAllUseCases: Boolean;
//#UC START# *539721E6003F_539729990330get_var*
//#UC END# *539721E6003F_539729990330get_var*
begin
//#UC START# *539721E6003F_539729990330get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539721E6003F_539729990330get_impl*
end;//TvcmGroupOperation.pm_GetForAllUseCases

procedure TvcmGroupOperation.pm_SetForAllUseCases(aValue: Boolean);
//#UC START# *539721E6003F_539729990330set_var*
//#UC END# *539721E6003F_539729990330set_var*
begin
//#UC START# *539721E6003F_539729990330set_impl*
 !!! Needs to be implemented !!!
//#UC END# *539721E6003F_539729990330set_impl*
end;//TvcmGroupOperation.pm_SetForAllUseCases

function TvcmGroupOperation.pm_GetGroupChanged: Boolean;
//#UC START# *539722010052_539729990330get_var*
//#UC END# *539722010052_539729990330get_var*
begin
//#UC START# *539722010052_539729990330get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539722010052_539729990330get_impl*
end;//TvcmGroupOperation.pm_GetGroupChanged

procedure TvcmGroupOperation.pm_SetGroupChanged(aValue: Boolean);
//#UC START# *539722010052_539729990330set_var*
//#UC END# *539722010052_539729990330set_var*
begin
//#UC START# *539722010052_539729990330set_impl*
 !!! Needs to be implemented !!!
//#UC END# *539722010052_539729990330set_impl*
end;//TvcmGroupOperation.pm_SetGroupChanged

procedure TvcmGroupOperation.DoSetPosition(aValue: Integer);
//#UC START# *5397264A01C8_539729990330_var*
//#UC END# *5397264A01C8_539729990330_var*
begin
//#UC START# *5397264A01C8_539729990330_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397264A01C8_539729990330_impl*
end;//TvcmGroupOperation.DoSetPosition

procedure TvcmGroupOperation.InitFields;
//#UC START# *47A042E100E2_539729990330_var*
//#UC END# *47A042E100E2_539729990330_var*
begin
//#UC START# *47A042E100E2_539729990330_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_539729990330_impl*
end;//TvcmGroupOperation.InitFields

procedure TvcmGroupOperation.DoSetAsPCharLen(const Value: Tl3PCharLen);
//#UC START# *47A869D10074_539729990330_var*
//#UC END# *47A869D10074_539729990330_var*
begin
//#UC START# *47A869D10074_539729990330_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A869D10074_539729990330_impl*
end;//TvcmGroupOperation.DoSetAsPCharLen

function TvcmGroupOperation.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_539729990330_var*
//#UC END# *4A60B23E00C3_539729990330_var*
begin
//#UC START# *4A60B23E00C3_539729990330_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A60B23E00C3_539729990330_impl*
end;//TvcmGroupOperation.COMQueryInterface

procedure TvcmGroupOperation.ClearFields;
 {-}
begin
 {$If not defined(NoVCM)}
 Op := nil;
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 RepOp := nil;
 {$IfEnd} //not NoVCM
 inherited;
end;//TvcmGroupOperation.ClearFields

procedure TvcmGroupOperation.DoSave;
//#UC START# *53972500009A_539729990330_var*
//#UC END# *53972500009A_539729990330_var*
begin
//#UC START# *53972500009A_539729990330_impl*
 !!! Needs to be implemented !!!
//#UC END# *53972500009A_539729990330_impl*
end;//TvcmGroupOperation.DoSave

type
  TvcmRepGroupOperationsNode = {final} class(TvcmBaseNode, ItpRepGroupOperationsNode)
  private
  // private fields
   f_Group : IvcmCustOpsRepGroupOperations;
    {* Поле для свойства Group}
  protected
  // realized methods
   function pm_GetGroup: IvcmCustOpsRepGroupOperations;
  protected
  // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
  public
  // public methods
   constructor Create(const aGroup: IvcmCustOpsRepGroupOperations); reintroduce;
   class function Make(const aGroup: IvcmCustOpsRepGroupOperations): Il3Node; reintroduce;
     {* Сигнатура фабрики TvcmRepGroupOperationsNode.Make }
  protected
  // protected properties
   property Group: IvcmCustOpsRepGroupOperations
     read f_Group;
  end;//TvcmRepGroupOperationsNode

// start class TvcmRepGroupOperationsNode

constructor TvcmRepGroupOperationsNode.Create(const aGroup: IvcmCustOpsRepGroupOperations);
//#UC START# *5397386402F9_539730BD0307_var*
//#UC END# *5397386402F9_539730BD0307_var*
begin
//#UC START# *5397386402F9_539730BD0307_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397386402F9_539730BD0307_impl*
end;//TvcmRepGroupOperationsNode.Create

class function TvcmRepGroupOperationsNode.Make(const aGroup: IvcmCustOpsRepGroupOperations): Il3Node;
var
 l_Inst : TvcmRepGroupOperationsNode;
begin
 l_Inst := Create(aGroup);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TvcmRepGroupOperationsNode.pm_GetGroup: IvcmCustOpsRepGroupOperations;
//#UC START# *539722450260_539730BD0307get_var*
//#UC END# *539722450260_539730BD0307get_var*
begin
//#UC START# *539722450260_539730BD0307get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539722450260_539730BD0307get_impl*
end;//TvcmRepGroupOperationsNode.pm_GetGroup

procedure TvcmRepGroupOperationsNode.Cleanup;
//#UC START# *479731C50290_539730BD0307_var*
//#UC END# *479731C50290_539730BD0307_var*
begin
//#UC START# *479731C50290_539730BD0307_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_539730BD0307_impl*
end;//TvcmRepGroupOperationsNode.Cleanup

procedure TvcmRepGroupOperationsNode.ClearFields;
 {-}
begin
 {$If not defined(NoVCM)}
 f_Group := nil;
 {$IfEnd} //not NoVCM
 inherited;
end;//TvcmRepGroupOperationsNode.ClearFields

type
  TvcmRepOperationNode = class(TvcmBaseNode, ItpRepOperationNode)
  private
  // private fields
   f_Op : IvcmCustOpsRepOperation;
    {* Поле для свойства Op}
  protected
  // realized methods
   function pm_GetOp: IvcmCustOpsRepOperation;
  protected
  // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
  public
  // public methods
   constructor Create(const aOp: IvcmCustOpsRepOperation); reintroduce;
   class function Make(const aOp: IvcmCustOpsRepOperation): Il3Node; reintroduce;
     {* Сигнатура фабрики TvcmRepOperationNode.Make }
  protected
  // protected properties
   property Op: IvcmCustOpsRepOperation
     read f_Op;
  end;//TvcmRepOperationNode

// start class TvcmRepOperationNode

constructor TvcmRepOperationNode.Create(const aOp: IvcmCustOpsRepOperation);
//#UC START# *5397395D01D0_539738CD0281_var*
//#UC END# *5397395D01D0_539738CD0281_var*
begin
//#UC START# *5397395D01D0_539738CD0281_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397395D01D0_539738CD0281_impl*
end;//TvcmRepOperationNode.Create

class function TvcmRepOperationNode.Make(const aOp: IvcmCustOpsRepOperation): Il3Node;
var
 l_Inst : TvcmRepOperationNode;
begin
 l_Inst := Create(aOp);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TvcmRepOperationNode.pm_GetOp: IvcmCustOpsRepOperation;
//#UC START# *539722A401F2_539738CD0281get_var*
//#UC END# *539722A401F2_539738CD0281get_var*
begin
//#UC START# *539722A401F2_539738CD0281get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539722A401F2_539738CD0281get_impl*
end;//TvcmRepOperationNode.pm_GetOp

procedure TvcmRepOperationNode.Cleanup;
//#UC START# *479731C50290_539738CD0281_var*
//#UC END# *479731C50290_539738CD0281_var*
begin
//#UC START# *479731C50290_539738CD0281_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_539738CD0281_impl*
end;//TvcmRepOperationNode.Cleanup

procedure TvcmRepOperationNode.ClearFields;
 {-}
begin
 {$If not defined(NoVCM)}
 f_Op := nil;
 {$IfEnd} //not NoVCM
 inherited;
end;//TvcmRepOperationNode.ClearFields

type
  TvcmTree = class(Tl3TreeItpTree)
  protected
  // realized methods
   procedure Save;
     {* Сигнатура метода Save }
  end;//TvcmTree

// start class TvcmTree

procedure TvcmTree.Save;
//#UC START# *539723610044_539739B2024F_var*
//#UC END# *539723610044_539739B2024F_var*
begin
//#UC START# *539723610044_539739B2024F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539723610044_539739B2024F_impl*
end;//TvcmTree.Save

type
  TvcmCustOpsTree = class(TvcmTree)
  private
  // private methods
   procedure LoadGroups;
     {* Сигнатура метода LoadGroups }
  protected
  // overridden protected methods
   procedure InitFields; override;
  end;//TvcmCustOpsTree

// start class TvcmCustOpsTree

procedure TvcmCustOpsTree.LoadGroups;
//#UC START# *53973A2E02CB_539739FB0026_var*
//#UC END# *53973A2E02CB_539739FB0026_var*
begin
//#UC START# *53973A2E02CB_539739FB0026_impl*
 !!! Needs to be implemented !!!
//#UC END# *53973A2E02CB_539739FB0026_impl*
end;//TvcmCustOpsTree.LoadGroups

procedure TvcmCustOpsTree.InitFields;
//#UC START# *47A042E100E2_539739FB0026_var*
//#UC END# *47A042E100E2_539739FB0026_var*
begin
//#UC START# *47A042E100E2_539739FB0026_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_539739FB0026_impl*
end;//TvcmCustOpsTree.InitFields

type
  TvcmRepTree = class(TvcmTree)
  private
  // private methods
   procedure ReadRepGroups;
     {* прочитаем данные репозитория }
   procedure ReadRepGroup(const aGroup: IvcmCustOpsRepGroupOperations;
      const aGroupNode: Il3Node);
  protected
  // overridden protected methods
   procedure InitFields; override;
  end;//TvcmRepTree

// start class TvcmRepTree

procedure TvcmRepTree.ReadRepGroups;
//#UC START# *53973AA903CB_53973A55033D_var*
//#UC END# *53973AA903CB_53973A55033D_var*
begin
//#UC START# *53973AA903CB_53973A55033D_impl*
 !!! Needs to be implemented !!!
//#UC END# *53973AA903CB_53973A55033D_impl*
end;//TvcmRepTree.ReadRepGroups

procedure TvcmRepTree.ReadRepGroup(const aGroup: IvcmCustOpsRepGroupOperations;
  const aGroupNode: Il3Node);
//#UC START# *53973ABF00D4_53973A55033D_var*
//#UC END# *53973ABF00D4_53973A55033D_var*
begin
//#UC START# *53973ABF00D4_53973A55033D_impl*
 !!! Needs to be implemented !!!
//#UC END# *53973ABF00D4_53973A55033D_impl*
end;//TvcmRepTree.ReadRepGroup

procedure TvcmRepTree.InitFields;
//#UC START# *47A042E100E2_53973A55033D_var*
//#UC END# *47A042E100E2_53973A55033D_var*
begin
//#UC START# *47A042E100E2_53973A55033D_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_53973A55033D_impl*
end;//TvcmRepTree.InitFields

type
  TvcmRepGroupsTree = class(TvcmTree)
  protected
  // overridden protected methods
   procedure InitFields; override;
  end;//TvcmRepGroupsTree

// start class TvcmRepGroupsTree

procedure TvcmRepGroupsTree.InitFields;
//#UC START# *47A042E100E2_53973AEC028A_var*
//#UC END# *47A042E100E2_53973AEC028A_var*
begin
//#UC START# *47A042E100E2_53973AEC028A_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_53973AEC028A_impl*
end;//TvcmRepGroupsTree.InitFields

type
  TvcmRepGroupNode = class(TvcmBaseNode, ItpRepGroupNode)
  private
  // private fields
   f_RepGroup : IvcmCustOpsRepGroup;
    {* Поле для свойства RepGroup}
  protected
  // realized methods
   function Get_RepGroup: IvcmCustOpsRepGroup;
   procedure Set_RepGroup(const aValue: IvcmCustOpsRepGroup);
  protected
  // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen); override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
   procedure DoSave; override;
     {* Сигнатура метода DoSave }
  public
  // public methods
   constructor Create(const aCaption: Tl3PCharLenPrim;
      const aRepGroup: IvcmCustOpsRepGroup = nil); reintroduce;
   class function Make(const aCaption: Tl3PCharLenPrim;
      const aRepGroup: IvcmCustOpsRepGroup = nil): Il3Node; reintroduce;
     {* Сигнатура фабрики TvcmRepGroupNode.Make }
  protected
  // protected properties
   property RepGroup: IvcmCustOpsRepGroup
     read f_RepGroup
     write f_RepGroup;
  end;//TvcmRepGroupNode

// start class TvcmRepGroupNode

constructor TvcmRepGroupNode.Create(const aCaption: Tl3PCharLenPrim;
  const aRepGroup: IvcmCustOpsRepGroup = nil);
//#UC START# *53973BE603E6_53973B3F02F2_var*
//#UC END# *53973BE603E6_53973B3F02F2_var*
begin
//#UC START# *53973BE603E6_53973B3F02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *53973BE603E6_53973B3F02F2_impl*
end;//TvcmRepGroupNode.Create

class function TvcmRepGroupNode.Make(const aCaption: Tl3PCharLenPrim;
  const aRepGroup: IvcmCustOpsRepGroup = nil): Il3Node;
var
 l_Inst : TvcmRepGroupNode;
begin
 l_Inst := Create(aCaption, aRepGroup);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TvcmRepGroupNode.Get_RepGroup: IvcmCustOpsRepGroup;
//#UC START# *539722EE0350_53973B3F02F2get_var*
//#UC END# *539722EE0350_53973B3F02F2get_var*
begin
//#UC START# *539722EE0350_53973B3F02F2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539722EE0350_53973B3F02F2get_impl*
end;//TvcmRepGroupNode.Get_RepGroup

procedure TvcmRepGroupNode.Set_RepGroup(const aValue: IvcmCustOpsRepGroup);
//#UC START# *539722EE0350_53973B3F02F2set_var*
//#UC END# *539722EE0350_53973B3F02F2set_var*
begin
//#UC START# *539722EE0350_53973B3F02F2set_impl*
 !!! Needs to be implemented !!!
//#UC END# *539722EE0350_53973B3F02F2set_impl*
end;//TvcmRepGroupNode.Set_RepGroup

procedure TvcmRepGroupNode.Cleanup;
//#UC START# *479731C50290_53973B3F02F2_var*
//#UC END# *479731C50290_53973B3F02F2_var*
begin
//#UC START# *479731C50290_53973B3F02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_53973B3F02F2_impl*
end;//TvcmRepGroupNode.Cleanup

procedure TvcmRepGroupNode.DoSetAsPCharLen(const Value: Tl3PCharLen);
//#UC START# *47A869D10074_53973B3F02F2_var*
//#UC END# *47A869D10074_53973B3F02F2_var*
begin
//#UC START# *47A869D10074_53973B3F02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A869D10074_53973B3F02F2_impl*
end;//TvcmRepGroupNode.DoSetAsPCharLen

procedure TvcmRepGroupNode.ClearFields;
 {-}
begin
 {$If not defined(NoVCM)}
 RepGroup := nil;
 {$IfEnd} //not NoVCM
 inherited;
end;//TvcmRepGroupNode.ClearFields

procedure TvcmRepGroupNode.DoSave;
//#UC START# *53972500009A_53973B3F02F2_var*
//#UC END# *53972500009A_53973B3F02F2_var*
begin
//#UC START# *53972500009A_53973B3F02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *53972500009A_53973B3F02F2_impl*
end;//TvcmRepGroupNode.DoSave

function TPrimCustomizeTasksPanelForm.pm_GetTasksPanel: IvcmCustOps;
//#UC START# *4C8E4F1702F8_4C8E4D21001Fget_var*
//#UC END# *4C8E4F1702F8_4C8E4D21001Fget_var*
begin
//#UC START# *4C8E4F1702F8_4C8E4D21001Fget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8E4F1702F8_4C8E4D21001Fget_impl*
end;//TPrimCustomizeTasksPanelForm.pm_GetTasksPanel

procedure TPrimCustomizeTasksPanelForm.pm_SetTasksPanel(const aValue: IvcmCustOps);
//#UC START# *4C8E4F1702F8_4C8E4D21001Fset_var*
//#UC END# *4C8E4F1702F8_4C8E4D21001Fset_var*
begin
//#UC START# *4C8E4F1702F8_4C8E4D21001Fset_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8E4F1702F8_4C8E4D21001Fset_impl*
end;//TPrimCustomizeTasksPanelForm.pm_SetTasksPanel

procedure TPrimCustomizeTasksPanelForm.pm_SetIsChanged(aValue: Boolean);
//#UC START# *5397181C036E_4C8E4D21001Fset_var*
//#UC END# *5397181C036E_4C8E4D21001Fset_var*
begin
//#UC START# *5397181C036E_4C8E4D21001Fset_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397181C036E_4C8E4D21001Fset_impl*
end;//TPrimCustomizeTasksPanelForm.pm_SetIsChanged

procedure TPrimCustomizeTasksPanelForm.Cleanup;
//#UC START# *479731C50290_4C8E4D21001F_var*
//#UC END# *479731C50290_4C8E4D21001F_var*
begin
//#UC START# *479731C50290_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.Cleanup

procedure TPrimCustomizeTasksPanelForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4C8E4D21001F_var*
//#UC END# *49803F5503AA_4C8E4D21001F_var*
begin
//#UC START# *49803F5503AA_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *49803F5503AA_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.DoInit

procedure TPrimCustomizeTasksPanelForm.InitControls;
//#UC START# *4A8E8F2E0195_4C8E4D21001F_var*
//#UC END# *4A8E8F2E0195_4C8E4D21001F_var*
begin
//#UC START# *4A8E8F2E0195_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8E8F2E0195_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.InitControls

procedure TPrimCustomizeTasksPanelForm.MakeControls;
begin
 inherited;
 f_spRight := TvtSplitter.Create(Self);
 f_spRight.Name := 'spRight';
 f_spRight.Parent := Self;
 f_pnlBottom := TvtPanel.Create(Self);
 f_pnlBottom.Name := 'pnlBottom';
 f_pnlBottom.Parent := Self;
 f_lblConfirmSave := TvtLabel.Create(Self);
 f_lblConfirmSave.Name := 'lblConfirmSave';
 f_lblConfirmSave.Parent := pnlBottom;
 f_lblConfirmSave.Caption := 'Объект системы изменен. Применить изменения?';
 f_lblAvailableOpsCaption := TvtLabel.Create(Self);
 f_lblAvailableOpsCaption.Name := 'lblAvailableOpsCaption';
 f_lblAvailableOpsCaption.Parent := pnlBottom;
 f_lblAvailableOpsCaption.Caption := 'Редактор доступных операций панели инструментов';
 f_btOk := TvtButton.Create(Self);
 f_btOk.Name := 'btOk';
 f_btOk.Parent := pnlBottom;
 f_btOk.Caption := 'Ок';
 f_btCancel := TvtButton.Create(Self);
 f_btCancel.Name := 'btCancel';
 f_btCancel.Parent := pnlBottom;
 f_btCancel.Caption := 'Отмена';
 f_btApply := TvtButton.Create(Self);
 f_btApply.Name := 'btApply';
 f_btApply.Parent := pnlBottom;
 f_btApply.Caption := 'Применить';
 f_pnlRep := TvtPanel.Create(Self);
 f_pnlRep.Name := 'pnlRep';
 f_pnlRep.Parent := Self;
 f_splRep := TvtSplitter.Create(Self);
 f_splRep.Name := 'splRep';
 f_splRep.Parent := pnlRep;
 f_gbAvailableGroups := TvtGroupBox.Create(Self);
 f_gbAvailableGroups.Name := 'gbAvailableGroups';
 f_gbAvailableGroups.Parent := pnlRep;
 f_gbAvailableGroups.Caption := 'Доступные группы:';
 f_tvRepGroups := TeeTreeView.Create(Self);
 f_tvRepGroups.Name := 'tvRepGroups';
 f_tvRepGroups.Parent := gbAvailableGroups;
 f_vtPanel1 := TvtPanel.Create(Self);
 f_vtPanel1.Name := 'vtPanel1';
 f_vtPanel1.Parent := gbAvailableGroups;
 f_cbGroupName := TvtComboBox.Create(Self);
 f_cbGroupName.Name := 'cbGroupName';
 f_cbGroupName.Parent := vtPanel1;
 f_btnAddGroup := TeeButton.Create(Self);
 f_btnAddGroup.Name := 'btnAddGroup';
 f_btnAddGroup.Parent := vtPanel1;
 f_btnAddGroup.Caption := 'Добавить';
 f_btnChangeGroup := TeeButton.Create(Self);
 f_btnChangeGroup.Name := 'btnChangeGroup';
 f_btnChangeGroup.Parent := vtPanel1;
 f_btnChangeGroup.Caption := 'Изменить';
 f_btnDeleteGroup := TeeButton.Create(Self);
 f_btnDeleteGroup.Name := 'btnDeleteGroup';
 f_btnDeleteGroup.Parent := vtPanel1;
 f_btnDeleteGroup.Caption := 'Удалить';
 f_gbAvailableOperations := TvtGroupBox.Create(Self);
 f_gbAvailableOperations.Name := 'gbAvailableOperations';
 f_gbAvailableOperations.Parent := pnlRep;
 f_gbAvailableOperations.Caption := 'Доступные операции:';
 f_tvRepOps := TeeTreeView.Create(Self);
 f_tvRepOps.Name := 'tvRepOps';
 f_tvRepOps.Parent := gbAvailableOperations;
 f_pnlForms := TvtPanel.Create(Self);
 f_pnlForms.Name := 'pnlForms';
 f_pnlForms.Parent := Self;
 f_lblForms := TvtLabel.Create(Self);
 f_lblForms.Name := 'lblForms';
 f_lblForms.Parent := pnlForms;
 f_lblForms.Caption := 'Выберите форму:';
 f_cbForms := TComboBox.Create(Self);
 f_cbForms.Name := 'cbForms';
 f_cbForms.Parent := pnlForms;
 f_pnlMain := TvtPanel.Create(Self);
 f_pnlMain.Name := 'pnlMain';
 f_pnlMain.Parent := Self;
 f_pnlLeft := TvtPanel.Create(Self);
 f_pnlLeft.Name := 'pnlLeft';
 f_pnlLeft.Parent := pnlMain;
 f_btnMoveOpToPanel := TBitBtn.Create(Self);
 f_btnMoveOpToPanel.Name := 'btnMoveOpToPanel';
 f_btnMoveOpToPanel.Parent := pnlLeft;
 f_btnMoveOpToRep := TBitBtn.Create(Self);
 f_btnMoveOpToRep.Name := 'btnMoveOpToRep';
 f_btnMoveOpToRep.Parent := pnlLeft;
 f_btnMoveGroupToPanel := TBitBtn.Create(Self);
 f_btnMoveGroupToPanel.Name := 'btnMoveGroupToPanel';
 f_btnMoveGroupToPanel.Parent := pnlLeft;
 f_btnMoveGroupToRep := TBitBtn.Create(Self);
 f_btnMoveGroupToRep.Name := 'btnMoveGroupToRep';
 f_btnMoveGroupToRep.Parent := pnlLeft;
 f_pnlTasksPanel := TvtPanel.Create(Self);
 f_pnlTasksPanel.Name := 'pnlTasksPanel';
 f_pnlTasksPanel.Parent := pnlMain;
 f_gbTasksPanel := TvtGroupBox.Create(Self);
 f_gbTasksPanel.Name := 'gbTasksPanel';
 f_gbTasksPanel.Parent := pnlTasksPanel;
 f_gbTasksPanel.Caption := 'Текущая панель задач:';
 f_tvTasksPanel := TeeTreeView.Create(Self);
 f_tvTasksPanel.Name := 'tvTasksPanel';
 f_tvTasksPanel.Parent := gbTasksPanel;
 f_vtGroupBox3 := TvtGroupBox.Create(Self);
 f_vtGroupBox3.Name := 'vtGroupBox3';
 f_vtGroupBox3.Parent := gbTasksPanel;
 f_vtGroupBox3.Caption := 'Текущий элемент:';
 f_lblCaption := TvtLabel.Create(Self);
 f_lblCaption.Name := 'lblCaption';
 f_lblCaption.Parent := vtGroupBox3;
 f_lblCaption.Caption := 'Название:';
 f_edChange := TvtComboBox.Create(Self);
 f_edChange.Name := 'edChange';
 f_edChange.Parent := vtGroupBox3;
 f_cbForAllUseCases := TeeCheckBox.Create(Self);
 f_cbForAllUseCases.Name := 'cbForAllUseCases';
 f_cbForAllUseCases.Parent := vtGroupBox3;
 f_cbForAllUseCases.Caption := 'Для всех панелей задач';
 f_btnChangeItem := TeeButton.Create(Self);
 f_btnChangeItem.Name := 'btnChangeItem';
 f_btnChangeItem.Parent := vtGroupBox3;
 f_btnChangeItem.Caption := 'Изменить';
 f_pnlOperationPos := TvtPanel.Create(Self);
 f_pnlOperationPos.Name := 'pnlOperationPos';
 f_pnlOperationPos.Parent := pnlTasksPanel;
 f_UpBitBtn := TBitBtn.Create(Self);
 f_UpBitBtn.Name := 'UpBitBtn';
 f_UpBitBtn.Parent := pnlOperationPos;
 f_DownBitBtn := TBitBtn.Create(Self);
 f_DownBitBtn.Name := 'DownBitBtn';
 f_DownBitBtn.Parent := pnlOperationPos;
end;

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация PrimCustomizeTasksPanel
 TtfwClassRef.Register(TPrimCustomizeTasksPanelForm);
{$IfEnd} //not NoScripts AND not NoVCM

end.