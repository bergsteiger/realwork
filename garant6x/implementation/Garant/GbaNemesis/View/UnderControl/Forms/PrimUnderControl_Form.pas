unit PrimUnderControl_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/UnderControl/Forms/PrimUnderControl_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::UnderControl::View::UnderControl::PrimUnderControl
//
// На контроле
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
  l3Interfaces,
  l3TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ControlsTypes,
  eeInterfaces,
  eeTreeView,
  FoldersDomainInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  Base_Operations_Editions_Controls,
  Base_Operations_Strange_Controls
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  Search_Strange_Controls,
  l3StringIDEx
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  ,
  vtLister
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  nscTreeViewWithAdapterDragDrop,
  PrimUnderControl_utUnderControl_UserType,
  nsTypes,
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimUnderControlForm = {form} class(TvcmEntityForm, InsUnderControlRootListener)
  {* На контроле }
 private
 // private fields
   f_UnderControlList : TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства UnderControlList}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure UnderControlListSelectChanged(Sender: TObject;
     Index: LongInt;
     var SelectedState: Integer);
     {* event to notify of a selection change }
   function UnderControlListGetItemIconHint(Sender: TObject;
     Index: LongInt): Il3CString;
     {* event to get Hint String; }
   procedure UnderControlListMakeTreeSource(out theTree: Il3SimpleTree);
   function UnderControlListGetItemImage(Sender: TObject;
     Index: Integer;
     var aImages: TCustomImageList): Integer;
     {* Event to get Index of Bitmap in ImageIndex. }
   function UnderControlListGetItemTextHint(Sender: TObject;
     Index: LongInt): Il3CString;
     {* получение hint-а при задерке курсора над текстом. }
   procedure UnderControlListActionElement(Sender: TObject;
     Index: LongInt);
   procedure UnderControlListCurrentChanged(Sender: TObject;
     aNewCurrent: LongInt;
     aOldCurrent: LongInt);
   procedure UnderControlListGetItemFont(Sender: TObject;
     Index: LongInt;
     const aFont: Il3Font);
     {* event to get Font of the item cell
событие для получения шрифта элемента. }
   procedure VcmEntityFormGetStatus(aSender: TObject;
     out theStatus: TvcmStatusStrings);
   procedure StatusParamsShow;
     {* Сигнатура метода StatusParamsShow }
 protected
 // realized methods
   function Loadable_Load_Execute(const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = LLO_NONE): Boolean;
     {* Коллеги, кто может описать этот метод? }
   procedure Loadable_Load(const aParams: IvcmExecuteParams);
     {* Коллеги, кто может описать этот метод? }
   procedure Updated;
     {* список обновился }
   procedure ControlCenter_Refresh_Execute;
   procedure ControlCenter_Refresh(const aParams: IvcmExecuteParams);
   {$If not defined(NoVCM)}
   procedure Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
     {* Развернуть все }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
     {* Свернуть все }
   {$IfEnd} //not NoVCM
   procedure Document_ShowChanges_Test(const aParams: IvcmTestParamsPrim);
     {* Показать изменения }
   procedure Document_ShowChanges_GetState(var State: TvcmOperationStateIndex);
     {* Показать изменения }
   procedure Document_ShowChanges_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Показать изменения }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure SetupFormLayout; override;
     {* Тут можно настроить внешний вид формы }
    {$IfEnd} //not NoVCM
 protected
 // protected methods
   function CanCompareEditions(const aNode: Il3SimpleNode;
     WithState: Boolean): Boolean;
   procedure CompareEditions(const aNode: Il3SimpleNode);
   function IsChangeObjects: Boolean;
     {* определяет есть ли измененный объект в списке }
   function IsObjectChanged(const aNode: IeeNode): Boolean;
     {* определяет является ли объект измененным }
   procedure ResetElementStatus(const aNode: IeeNode);
   procedure UpdateRoot;
 protected
 // protected properties
   property UnderControlList: TnscTreeViewWithAdapterDragDrop
     read f_UnderControlList;
 end;//TPrimUnderControlForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If defined(Nemesis)}
  ,
  eeTreeMisc
  {$IfEnd} //Nemesis
  ,
  nsFolders,
  SysUtils,
  UnderControlUnit,
  DocumentUnit
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  FoldersUnit,
  BaseTreeSupportUnit
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  Graphics,
  l3InterfacesMisc,
  ControlStatusUtils,
  nsFolderNodes,
  BaseTypesUnit,
  IOUnit,
  FoldersRes,
  l3Base,
  l3String,
  nsOpenUtils,
  nsQuestionsWithChoices
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки utUnderControlLocalConstants }
  str_utUnderControlCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utUnderControlCaption'; rValue : 'Документы на контроле');
   { Заголовок пользовательского типа "Документы на контроле" }
  str_utUnderControlSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utUnderControlSettingsCaption'; rValue : 'Документы на контроле (вкладка)');
   { Заголовок пользовательского типа "Документы на контроле" для настройки панелей инструментов }

// start class TPrimUnderControlForm

procedure TPrimUnderControlForm.UnderControlListSelectChanged(Sender: TObject;
  Index: LongInt;
  var SelectedState: Integer);
//#UC START# *527B587200CA_4A7C349D02CB_var*
//#UC END# *527B587200CA_4A7C349D02CB_var*
begin
//#UC START# *527B587200CA_4A7C349D02CB_impl*
 StatusParamsShow;
//#UC END# *527B587200CA_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.UnderControlListSelectChanged

function TPrimUnderControlForm.UnderControlListGetItemIconHint(Sender: TObject;
  Index: LongInt): Il3CString;
//#UC START# *527B588701E5_4A7C349D02CB_var*
var
 l_CurNode: IeeNode;
 l_ControlledNode: InsUnderControlNode;
//#UC END# *527B588701E5_4A7C349D02CB_var*
begin
//#UC START# *527B588701E5_4A7C349D02CB_impl*
 l_CurNode := UnderControlList.TreeView.GetNode(Index);
 try
  if l3BQueryInterface(l_CurNode, InsUnderControlNode, l_ControlledNode) then
  try
   Result := bsControlStatusHint(l_ControlledNode.Status, true);
  finally
   l_ControlledNode := nil;
  end//try..finally
  else
   Result := nil;
 finally
  l_CurNode := nil;
 end;//try..finally
//#UC END# *527B588701E5_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.UnderControlListGetItemIconHint

procedure TPrimUnderControlForm.UnderControlListMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *527B58910002_4A7C349D02CB_var*
//#UC END# *527B58910002_4A7C349D02CB_var*
begin
//#UC START# *527B58910002_4A7C349D02CB_impl*
 theTree := TnsUnderControlTree.Make;
//#UC END# *527B58910002_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.UnderControlListMakeTreeSource

function TPrimUnderControlForm.UnderControlListGetItemImage(Sender: TObject;
  Index: Integer;
  var aImages: TCustomImageList): Integer;
//#UC START# *527B58980313_4A7C349D02CB_var*
var
 l_CurNode        : IeeNode;
 l_ControlledNode : InsUnderControlNode;
 l_Status         : Integer;
const
 cImageMap : array [TItemStatus] of Integer = (
  UCDocument_Abolished, // IS_ABOLISHED // Утратил силу
  UCDocument_Active, // IS_ACTIVE // Действующий
  UCDocument_Preactive, // IS_PREACTIVE // Не вступил в силу
  UCDocument_Unknown // IS_UNKNOWN // Неопределен
 );
//#UC END# *527B58980313_4A7C349D02CB_var*
begin
//#UC START# *527B58980313_4A7C349D02CB_impl*
 l_CurNode := UnderControlList.TreeView.GetNode(Index);
 try
  if l3BQueryInterface(l_CurNode, InsUnderControlNode, l_ControlledNode) then
   try
    l_Status := l_ControlledNode.Status;
    if l_Status and CS_DELETED = CS_DELETED then
     Result := UCStatus_DeletedIcon
    else
    if l_Status and CS_ACTIVE = CS_ACTIVE then
     Result := UCStatus_ActiveIcon
    else
    if l_Status and CS_CHANGED = CS_CHANGED then
     Result := UCStatus_ChangedIcon
    else
    if l_Status and CS_ABOLISHED = CS_ABOLISHED then
     Result := UCStatus_AbolishedIcon
    else
    if l_Status and CS_REGISTERED = CS_REGISTERED then
     Result := UCStatus_RegistredMUIcon
    else
    if l_Status and CS_NOT_REGISTERED = CS_NOT_REGISTERED then
     Result := UCStatus_NotRegistredMUIcon
    else
     Result := cImageMap[l_ControlledNode.DocumentStatus];
   finally
    l_ControlledNode := nil;
   end
  else
  begin
   aImages := dmStdRes.ImageList;
   Result := 115; // (i) - информация
  end;
 finally
  l_CurNode := nil;
 end;
//#UC END# *527B58980313_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.UnderControlListGetItemImage

function TPrimUnderControlForm.UnderControlListGetItemTextHint(Sender: TObject;
  Index: LongInt): Il3CString;
//#UC START# *527B58A30059_4A7C349D02CB_var*
var
 l_eeNode: IeeNode;
 l_Control: IControllable;
 l_Hint: IString;
//#UC END# *527B58A30059_4A7C349D02CB_var*
begin
//#UC START# *527B58A30059_4A7C349D02CB_impl*
 Result := nil;
 if (Index >= 0) then
 begin
  l_eeNode := UnderControlList.TreeView.GetNode(Index);
  try
   if Supports(l_eeNode, IControllable, l_Control) then
   begin
    l_Control.GetName(l_Hint);
    Result := nsCStr(l_Hint);
    if l3Same(Result, l_eeNode.Text) then
     Result := nil;
   end;
  finally
   l_eeNode := nil;
  end;//try..finally
 end;//Index >= 0
//#UC END# *527B58A30059_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.UnderControlListGetItemTextHint

procedure TPrimUnderControlForm.UnderControlListActionElement(Sender: TObject;
  Index: LongInt);
//#UC START# *527B58AB02FB_4A7C349D02CB_var*
//#UC END# *527B58AB02FB_4A7C349D02CB_var*
begin
//#UC START# *527B58AB02FB_4A7C349D02CB_impl*
 if CanCompareEditions(UnderControlList.GetNode(Index), True) then
 case MessageDlg(str_ChangedDocumentOnControl) of
  -1: OpenControllableElement(self.as_IvcmEntityForm, UnderControlList.GetNode(Index),
   vcm_okInCurrentTab);
  -2: CompareEditions(UnderControlList.GetNode(Index));
 end
 else
  OpenControllableElement(self.as_IvcmEntityForm, UnderControlList.GetNode(Index),
   vcm_okInCurrentTab);
//#UC END# *527B58AB02FB_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.UnderControlListActionElement

procedure TPrimUnderControlForm.UnderControlListCurrentChanged(Sender: TObject;
  aNewCurrent: LongInt;
  aOldCurrent: LongInt);
//#UC START# *527B58B30211_4A7C349D02CB_var*
//#UC END# *527B58B30211_4A7C349D02CB_var*
begin
//#UC START# *527B58B30211_4A7C349D02CB_impl*
 StatusParamsShow;
//#UC END# *527B58B30211_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.UnderControlListCurrentChanged

procedure TPrimUnderControlForm.UnderControlListGetItemFont(Sender: TObject;
  Index: LongInt;
  const aFont: Il3Font);
//#UC START# *527B58BA038B_4A7C349D02CB_var*
var
 l_CurNode: IeeNode;
 l_ControlledNode: InsUnderControlNode;
//#UC END# *527B58BA038B_4A7C349D02CB_var*
begin
//#UC START# *527B58BA038B_4A7C349D02CB_impl*
 l_CurNode := UnderControlList.TreeView.GetNode(Index);
 try
  if Supports(l_CurNode, InsUnderControlNode, l_ControlledNode) then
  try
   if LongWord(l_ControlledNode.Status) <> CS_NONE then
    aFont.Style := [fsBold];
  finally
   l_ControlledNode := nil;
  end;
 finally
  l_CurNode := nil;
 end;
//#UC END# *527B58BA038B_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.UnderControlListGetItemFont

procedure TPrimUnderControlForm.VcmEntityFormGetStatus(aSender: TObject;
  out theStatus: TvcmStatusStrings);
//#UC START# *527B58FA0051_4A7C349D02CB_var*
var
 l_Node: InsUnderControlNode;
//#UC END# *527B58FA0051_4A7C349D02CB_var*
begin
//#UC START# *527B58FA0051_4A7C349D02CB_impl*
 if Length(theStatus.rStrings) <> 1 then
  SetLength(theStatus.rStrings, 1);
 theStatus.rStrings[0] := nil;

 if (UnderControlList.TreeView.Tree.Root <> nil) and
    not ((UnderControlList.TreeView.Tree.Root.AllChildrenCount = 1) and
         not Supports(UnderControlList.TreeView.Tree.Root.ChildNode, InsUnderControlNode, l_Node)) then
 with UnderControlList.TreeView.Tree.Root do
 begin
  if UnderControlList.TreeView.Current >= 0 then
   theStatus.rStrings[0] := vcmFmt(str_ucsStatusWithSelected, [UnderControlList.TreeView.Current + 1, AllChildrenCount, UnderControlList.TreeView.Tree.SelectedCount])
  else
   theStatus.rStrings[0] := vcmFmt(str_ucsStatusWithOutSelected, [AllChildrenCount, UnderControlList.TreeView.Tree.SelectedCount]);
 end;
//#UC END# *527B58FA0051_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.VcmEntityFormGetStatus

procedure TPrimUnderControlForm.StatusParamsShow;
//#UC START# *527B591500AD_4A7C349D02CB_var*
//#UC END# *527B591500AD_4A7C349D02CB_var*
begin
//#UC START# *527B591500AD_4A7C349D02CB_impl*
 if Dispatcher <> nil then
  Dispatcher.UpdateStatus;
//#UC END# *527B591500AD_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.StatusParamsShow

function TPrimUnderControlForm.CanCompareEditions(const aNode: Il3SimpleNode;
  WithState: Boolean): Boolean;
//#UC START# *4B88CAAF01CF_4A7C349D02CB_var*
var
 l_C: InsUnderControlNode;
 l_CO: IControllable;
 l_D: IDocument;
 l_State: IDocumentState;
//#UC END# *4B88CAAF01CF_4A7C349D02CB_var*
begin
//#UC START# *4B88CAAF01CF_4A7C349D02CB_impl*
 if Supports(aNode, InsUnderControlNode, l_C) then
  try
   if WithState then
    Result := (l_C.Status and CS_CHANGED = CS_CHANGED)
   else
    Result := True;
   if Result then
   begin
    if Supports(l_C, IControllable, l_CO) then
    begin
     if Supports(l_CO, IDocument, l_D) then
      Result := l_D.HasPrevRedaction
     else
      Result := false;
     if Result then
     begin
      l_D.GetCurrentState(l_State);
      Result := l_State.CanCompareWithAnyOtherRedaction;
     end;//Result
    end//Supports(l_C, IControllable, l_CO)
    else
     Result := false;
   end;//Result
  finally
   l_C := nil;
  end//try..finally
 else
  Result := false;
//#UC END# *4B88CAAF01CF_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.CanCompareEditions

procedure TPrimUnderControlForm.CompareEditions(const aNode: Il3SimpleNode);
//#UC START# *4B88CAC20097_4A7C349D02CB_var*
var
 l_C : IControllable;
 l_D : IDocument;
//#UC END# *4B88CAC20097_4A7C349D02CB_var*
begin
//#UC START# *4B88CAC20097_4A7C349D02CB_impl*
 if Supports(aNode, IControllable, l_C) then
  try
   if Supports(l_C, IDocument, l_D) then
    try
     TdmStdRes.MakeCompareEditions(l_D, nil);
    finally
     l_D := nil;
    end;//try..finally
  finally
   l_C := nil;
  end;//try..finally
//#UC END# *4B88CAC20097_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.CompareEditions

function TPrimUnderControlForm.IsChangeObjects: Boolean;
//#UC START# *4C7E504C01E1_4A7C349D02CB_var*
var
 lChange : Boolean;

 function CheckStatus(const anIntf: IeeNode) : Boolean;
 begin
  Result := IsObjectChanged(anIntf);
  lChange := Result;
 end;

//#UC END# *4C7E504C01E1_4A7C349D02CB_var*
begin
//#UC START# *4C7E504C01E1_4A7C349D02CB_impl*
 lChange := False;
 UnderControlList.TreeView.Tree.Root.IterateF(eeL2NA(@CheckStatus),
  imCheckResult);
 Result := lChange;
//#UC END# *4C7E504C01E1_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.IsChangeObjects

function TPrimUnderControlForm.IsObjectChanged(const aNode: IeeNode): Boolean;
//#UC START# *4C7E506D0050_4A7C349D02CB_var*
var
 l_UCNode : InsUnderControlNode;
//#UC END# *4C7E506D0050_4A7C349D02CB_var*
begin
//#UC START# *4C7E506D0050_4A7C349D02CB_impl*
 Result := False;
 if Supports(aNode, InsUnderControlNode, l_UCNode) then
  try
   Result := (l_UCNode.Status <> 0);
  finally
   l_UCNode := nil;
  end
//#UC END# *4C7E506D0050_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.IsObjectChanged

procedure TPrimUnderControlForm.ResetElementStatus(const aNode: IeeNode);
//#UC START# *4C7E50AD006F_4A7C349D02CB_var*
var
 l_UCNode : InsUnderControlNode;
//#UC END# *4C7E50AD006F_4A7C349D02CB_var*
begin
//#UC START# *4C7E50AD006F_4A7C349D02CB_impl*
 if Supports(aNode, InsUnderControlNode, l_UCNode) then
  try
   l_UCNode.ResetStatus;
  finally
   l_UCNode := nil;
  end;
//#UC END# *4C7E50AD006F_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.ResetElementStatus

procedure TPrimUnderControlForm.UpdateRoot;
//#UC START# *4C7E558F0001_4A7C349D02CB_var*
//#UC END# *4C7E558F0001_4A7C349D02CB_var*
begin
//#UC START# *4C7E558F0001_4A7C349D02CB_impl*
 UnderControlList.TreeStruct.RootNode := UserFoldersTree.ControlledObj.Root as Il3SimpleRootNode;
//#UC END# *4C7E558F0001_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.UpdateRoot

function TPrimUnderControlForm.Loadable_Load_Execute(const aNode: IeeNode;
  const aData: IUnknown;
  anOp: TListLogicOperation = LLO_NONE): Boolean;
//#UC START# *49895A2102E8_4A7C349D02CBexec_var*
var
 l_Node         : INode;
 l_Controllable : IControllable;

 l_FoldersNode  : InsFoldersNode;
//#UC END# *49895A2102E8_4A7C349D02CBexec_var*
begin
//#UC START# *49895A2102E8_4A7C349D02CBexec_impl*
 Result := true;
 if Supports(aNode, INode, l_Node) then
  try
   if Supports(l_Node, IControllable, l_Controllable) then
    try
     if l_Controllable.GetControlled then
      begin
       Say(inf_AlreadyControlledObject);
       Result := false;
      end
     else //l_Controllable.GetControlled
     begin
      if Supports(aNode, InsFoldersNode, l_FoldersNode) then
       try
        l_FoldersNode.ChangeUnderControlStatus;
       finally
        l_FoldersNode := nil;
       end;
     end;
    finally
     l_Controllable := nil;
    end
   else//Supports(l_Node, IControllable, l_Controllable)
    begin
     Say(err_InvalidControlledObject);
     Result := false;
    end;
  finally
   l_Node := nil;
  end;
//#UC END# *49895A2102E8_4A7C349D02CBexec_impl*
end;//TPrimUnderControlForm.Loadable_Load_Execute

procedure TPrimUnderControlForm.Loadable_Load(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ILoadable_Load_Params) do
  ResultValue := Loadable_Load_Execute(Node, Data, nOp);
end;

procedure TPrimUnderControlForm.Updated;
//#UC START# *499043510214_4A7C349D02CB_var*
//#UC END# *499043510214_4A7C349D02CB_var*
begin
//#UC START# *499043510214_4A7C349D02CB_impl*
 UpdateRoot;
//#UC END# *499043510214_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.Updated

procedure TPrimUnderControlForm.ControlCenter_Refresh_Execute;
//#UC START# *4AF836720144_4A7C349D02CBexec_var*
//#UC END# *4AF836720144_4A7C349D02CBexec_var*
begin
//#UC START# *4AF836720144_4A7C349D02CBexec_impl*
 UnderControlList.Invalidate;
//#UC END# *4AF836720144_4A7C349D02CBexec_impl*
end;//TPrimUnderControlForm.ControlCenter_Refresh_Execute

procedure TPrimUnderControlForm.ControlCenter_Refresh(const aParams: IvcmExecuteParams);
begin
 ControlCenter_Refresh_Execute;
end;

{$If not defined(NoVCM)}
procedure TPrimUnderControlForm.Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7880236_4A7C349D02CBtest_var*
//#UC END# *4BDAF7880236_4A7C349D02CBtest_var*
begin
//#UC START# *4BDAF7880236_4A7C349D02CBtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7880236_4A7C349D02CBtest_impl*
end;//TPrimUnderControlForm.Tree_ExpandAll_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimUnderControlForm.Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7A2005C_4A7C349D02CBtest_var*
//#UC END# *4BDAF7A2005C_4A7C349D02CBtest_var*
begin
//#UC START# *4BDAF7A2005C_4A7C349D02CBtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7A2005C_4A7C349D02CBtest_impl*
end;//TPrimUnderControlForm.Tree_CollapseAll_Test
{$IfEnd} //not NoVCM

procedure TPrimUnderControlForm.Document_ShowChanges_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4DD1260D02D1_4A7C349D02CBtest_var*
//#UC END# *4DD1260D02D1_4A7C349D02CBtest_var*
begin
//#UC START# *4DD1260D02D1_4A7C349D02CBtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanCompareEditions(UnderControlList.GetCurrentNode, true);
//#UC END# *4DD1260D02D1_4A7C349D02CBtest_impl*
end;//TPrimUnderControlForm.Document_ShowChanges_Test

procedure TPrimUnderControlForm.Document_ShowChanges_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4DD1260D02D1_4A7C349D02CBgetstate_var*
//#UC END# *4DD1260D02D1_4A7C349D02CBgetstate_var*
begin
//#UC START# *4DD1260D02D1_4A7C349D02CBgetstate_impl*
 State := vcm_DefaultOperationState;
//#UC END# *4DD1260D02D1_4A7C349D02CBgetstate_impl*
end;//TPrimUnderControlForm.Document_ShowChanges_GetState

procedure TPrimUnderControlForm.Document_ShowChanges_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4DD1260D02D1_4A7C349D02CBexec_var*
//#UC END# *4DD1260D02D1_4A7C349D02CBexec_var*
begin
//#UC START# *4DD1260D02D1_4A7C349D02CBexec_impl*
 CompareEditions(UnderControlList.GetCurrentNode);
//#UC END# *4DD1260D02D1_4A7C349D02CBexec_impl*
end;//TPrimUnderControlForm.Document_ShowChanges_Execute

procedure TPrimUnderControlForm.Cleanup;
//#UC START# *479731C50290_4A7C349D02CB_var*
//#UC END# *479731C50290_4A7C349D02CB_var*
begin
//#UC START# *479731C50290_4A7C349D02CB_impl*
 if FoldersReaded then
  if (UserFoldersTree.ControlledObj <> nil) then
   UserFoldersTree.ControlledObj.As_Il3ChangeNotifier.Unsubscribe(InsUnderControlRootListener(Self));
 inherited;
//#UC END# *479731C50290_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.Cleanup

procedure TPrimUnderControlForm.InitFields;
//#UC START# *47A042E100E2_4A7C349D02CB_var*
//#UC END# *47A042E100E2_4A7C349D02CB_var*
begin
//#UC START# *47A042E100E2_4A7C349D02CB_impl*
 inherited;
 UnderControlList.Images := nsFoldersRes.FoldersItemImages;
 UpdateRoot;
 if (UserFoldersTree.ControlledObj <> nil) then
  UserFoldersTree.ControlledObj.As_Il3ChangeNotifier.Subscribe(InsUnderControlRootListener(Self));
 UnderControlList.VJustify := vt_vjTop;

 ActiveControl := UnderControlList;
//#UC END# *47A042E100E2_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.InitFields

{$If not defined(NoVCM)}
procedure TPrimUnderControlForm.InitControls;
//#UC START# *4A8E8F2E0195_4A7C349D02CB_var*
//#UC END# *4A8E8F2E0195_4A7C349D02CB_var*
begin
//#UC START# *4A8E8F2E0195_4A7C349D02CB_impl*
 Self.OnGetStatus := vcmEntityFormGetStatus;

 with UnderControlList do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  MultiSelect := True;
  MultiStrokeItem := True;
  ActionElementMode := l3_amSecondSingleClick;
  ViewOptions := [voShowInterRowSpace, voShowIcons, voShowExpandable, voShowLines, voShowOpenChip, voVariableItemHeight];
  OnSelectChanged := UnderControlListSelectChanged;
  OnGetItemIconHint := UnderControlListGetItemIconHint;
  OnMakeTreeSource := UnderControlListMakeTreeSource;
  OnGetItemImage := UnderControlListGetItemImage;
  OnGetItemTextHint := UnderControlListGetItemTextHint;
  OnActionElement := UnderControlListActionElement;
  OnCurrentChanged := UnderControlListCurrentChanged;
  OnGetItemFont := UnderControlListGetItemFont;
  SettingId := 'stidUnderControlList';
 end;
//#UC END# *4A8E8F2E0195_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimUnderControlForm.SetupFormLayout;
//#UC START# *529332B40230_4A7C349D02CB_var*
//#UC END# *529332B40230_4A7C349D02CB_var*
begin
//#UC START# *529332B40230_4A7C349D02CB_impl*
 inherited;
 Width := 220;
 Height := 480;
//#UC END# *529332B40230_4A7C349D02CB_impl*
end;//TPrimUnderControlForm.SetupFormLayout
{$IfEnd} //not NoVCM

procedure TPrimUnderControlForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Loadable, nil);
  PublishFormEntity(en_ControlCenter, nil);
  PublishFormEntity(en_Tree, nil);
  PublishFormEntity(en_Document, nil);
  MakeEntitySupportedByControl(en_Tree, UnderControlList);
  PublishOpWithResult(en_Loadable, op_Load, Loadable_Load, nil, nil);
  PublishOpWithResult(en_ControlCenter, op_Refresh, ControlCenter_Refresh, nil, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_ExpandAll, nil, Tree_ExpandAll_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_CollapseAll, nil, Tree_CollapseAll_Test, nil);
  {$IfEnd} //not NoVCM

  PublishOp(en_Document, op_ShowChanges, Document_ShowChanges_Execute, Document_ShowChanges_Test, Document_ShowChanges_GetState);
 end;//with Entities.Entities
end;

procedure TPrimUnderControlForm.MakeControls;
begin
 inherited;
 with AddUsertype(utUnderControlName,
  str_utUnderControlCaption,
  str_utUnderControlSettingsCaption,
  true,
  67,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utUnderControlName
 f_UnderControlList := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_UnderControlList.Name := 'UnderControlList';
 f_UnderControlList.Parent := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utUnderControlCaption
 str_utUnderControlCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utUnderControlSettingsCaption
 str_utUnderControlSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimUnderControl
 TtfwClassRef.Register(TPrimUnderControlForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.