unit PrimRubricator_Form;
 {* Правовой навигатор }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator\Forms\PrimRubricator_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimRubricator" MUID: (4AA68CA10101)
// Имя типа: "TPrimRubricatorForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Common_Rubricator_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Rubricator_Strange_Controls
 , BaseTypesUnit
 , nscTreeViewWithAdapterDragDrop
 , vtPanel
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , nscSimpleEditor
 , DynamicTreeUnit
 , l3TreeInterfaces
 , MainMenuUnit
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , afwInterfaces
 , afwNavigation
 , nevTools
 , nevGUIInterfaces
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 InsRubricatorState = interface
  ['{E4FB5DDB-8888-4F1E-8408-E4D56CCB1FBD}']
  function Get_NewDocLabelVisible: Boolean;
  function Get_LinkType: TNavigatorMenuItemType;
  function As_IvcmBase: IvcmBase;
   {* Метод приведения нашего интерфейса к IvcmBase }
  property NewDocLabelVisible: Boolean
   read Get_NewDocLabelVisible;
  property LinkType: TNavigatorMenuItemType
   read Get_LinkType;
 end;//InsRubricatorState

 TnsRubricatorState = class(Tl3ProtoObject, InsRubricatorState{$If NOT Defined(NoVCM)}
 , IvcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_NewDocLabelVisible: Boolean;
   f_LinkType: TNavigatorMenuItemType;
  protected
   function As_IvcmBase: IvcmBase;
    {* Метод приведения нашего интерфейса к IvcmBase }
   function Get_NewDocLabelVisible: Boolean;
   function Get_LinkType: TNavigatorMenuItemType;
  public
   constructor Create(aNewDocLabelVisible: Boolean;
    aLinkType: TNavigatorMenuItemType); reintroduce;
   class function Make(aNewDocLabelVisible: Boolean;
    aLinkType: TNavigatorMenuItemType): InsRubricatorState; reintroduce;
 end;//TnsRubricatorState

 _vcmChromeLikeTabIconUpdater_Parent_ = TvcmEntityForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}
 TPrimRubricatorForm = class(_vcmChromeLikeTabIconUpdater_)
  {* Правовой навигатор }
  private
   f_LinkType: TNavigatorMenuItemType;
   f_RubricatorList: TnscTreeViewWithAdapterDragDrop;
   f_TopPanel: TvtPanel;
   f_DelimiterPanel: TvtPanel;
   f_ExampleTextSource: TnscTextSource;
   f_PaintBox: TPaintBox;
   f_NewDocLabel: TnscSimpleEditor;
  protected
   f_SetCurrentLock: Integer;
  private
   procedure InternalInitRoot(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem);
   procedure RubricatorListActionElement(Sender: TObject;
    Index: LongInt);
   function RubricatorListGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure RubricatorListTreeChanged(aSender: TObject;
    const anOldTree: Il3SimpleTree;
    const aNewTree: Il3SimpleTree);
   function NewDocLabelJumpTo(Sender: TObject;
    anEffects: TafwJumpToEffects;
    const aMoniker: IevMoniker): Boolean;
   procedure ExampleTextSourceMakeDocumentContainer(Sender: TObject;
    var aMade: InevDocumentContainer);
   procedure NewDocLabelBreakingPara(aSender: TObject;
    out aHandled: Boolean);
   procedure PaintBoxPaint(Sender: TObject);
   procedure NewDocLabelGetHotSpotInfo(Sender: TObject;
    const aHotSpot: IevHotSpot;
    const aKeys: TafwCursorState;
    var theInfo: TafwCursorInfo);
   procedure CallGarant;
   procedure vcmEntityFormSaveState(out aState: IvcmBase;
    aStateType: TvcmStateType;
    var Saved: Boolean);
   procedure vcmEntityFormLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType;
    var Loaded: Boolean);
  protected
   procedure InternalSetRoot(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem);
   procedure RubricExecute;
   procedure UpdateTopPanel(aNodeType: TNavigatorMenuItemType);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetTabImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure Rubricator_SetListRoot_Execute(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem);
   procedure Rubricator_SetListRoot(const aParams: IvcmExecuteParams);
   procedure Rubricator_InitListRoot_Execute(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem);
   procedure Rubricator_InitListRoot(const aParams: IvcmExecuteParams);
   procedure Rubricator_Synchronize_Execute;
   procedure Rubricator_Synchronize(const aParams: IvcmExecuteParams);
   function Rubricator_GetRoot_Execute: Il3SimpleNode;
   procedure Rubricator_GetRoot(const aParams: IvcmExecuteParams);
   procedure Rubric_Execute_Execute(const aParams: IvcmExecuteParamsPrim);
  public
   property RubricatorList: TnscTreeViewWithAdapterDragDrop
    read f_RubricatorList;
   property TopPanel: TvtPanel
    read f_TopPanel;
   property DelimiterPanel: TvtPanel
    read f_DelimiterPanel;
   property ExampleTextSource: TnscTextSource
    read f_ExampleTextSource;
   property PaintBox: TPaintBox
    read f_PaintBox;
   property NewDocLabel: TnscSimpleEditor
    read f_NewDocLabel;
 end;//TPrimRubricatorForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , RubricatorRes
 , Common_Strange_Controls
 , RubricatorInterfaces
 , evdTextStyle_Const
 , Graphics
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Memory
 , nevNavigation
 , afwFacade
 , l3String
 , nsExternalObjectPrim
 , nsTypes
 , nsConst
 , DataAdapter
 , DynamicDocListUnit
 , DocumentUnit
 , nsUtils
 , bsTypes
 , deDocInfo
 , evdStyles
 , nsTabbedInterfaceTypes
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , nsRubricatorList
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimRubricator_utRubricatorList_UserType
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4AA68CA10101impl_uses*
 , l3ControlsTypes
 //#UC END# *4AA68CA10101impl_uses*
;

{$If NOT Defined(NoVCM)}
constructor TnsRubricatorState.Create(aNewDocLabelVisible: Boolean;
 aLinkType: TNavigatorMenuItemType);
//#UC START# *4AA78D81011E_4AA78D4B020B_var*
//#UC END# *4AA78D81011E_4AA78D4B020B_var*
begin
//#UC START# *4AA78D81011E_4AA78D4B020B_impl*
 inherited Create;
 f_NewDocLabelVisible := aNewDocLabelVisible;
 f_LinkType := aLinkType;
//#UC END# *4AA78D81011E_4AA78D4B020B_impl*
end;//TnsRubricatorState.Create

class function TnsRubricatorState.Make(aNewDocLabelVisible: Boolean;
 aLinkType: TNavigatorMenuItemType): InsRubricatorState;
var
 l_Inst : TnsRubricatorState;
begin
 l_Inst := Create(aNewDocLabelVisible, aLinkType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsRubricatorState.Make

function TnsRubricatorState.As_IvcmBase: IvcmBase;
 {* Метод приведения нашего интерфейса к IvcmBase }
begin
 Result := Self;
end;//TnsRubricatorState.As_IvcmBase

function TnsRubricatorState.Get_NewDocLabelVisible: Boolean;
//#UC START# *4AA78D1501FF_4AA78D4B020Bget_var*
//#UC END# *4AA78D1501FF_4AA78D4B020Bget_var*
begin
//#UC START# *4AA78D1501FF_4AA78D4B020Bget_impl*
 Result := f_NewDocLabelVisible;
//#UC END# *4AA78D1501FF_4AA78D4B020Bget_impl*
end;//TnsRubricatorState.Get_NewDocLabelVisible

function TnsRubricatorState.Get_LinkType: TNavigatorMenuItemType;
//#UC START# *4AA78D2C012A_4AA78D4B020Bget_var*
//#UC END# *4AA78D2C012A_4AA78D4B020Bget_var*
begin
//#UC START# *4AA78D2C012A_4AA78D4B020Bget_impl*
 Result := f_LinkType;
//#UC END# *4AA78D2C012A_4AA78D4B020Bget_impl*
end;//TnsRubricatorState.Get_LinkType

type _Instance_R_ = TPrimRubricatorForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}

procedure TPrimRubricatorForm.InternalInitRoot(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem);
var l_Node: INodeBase;
//#UC START# *4AA781EA039B_4AA68CA10101_var*
//#UC END# *4AA781EA039B_4AA68CA10101_var*
begin
//#UC START# *4AA781EA039B_4AA68CA10101_impl*
 Inc(f_SetCurrentLock);
 try
  with RubricatorList.TreeStruct do
  begin
   if Supports(aNode, INodeBase, l_Node) and
      not aNode.IsSame(RootNode) then
   begin
    RubricatorList.TreeStruct := TnsRubricatorList.Make(l_Node, aRootToKeep, aMenuSectionItemToKeep);
    CCaption := l3CStr(RubricatorList.TreeStruct.RootNode);
    UpdateTopPanel(TNavigatorMenuItemType(l_Node.GetType));
    Op_Navigator_SetCurrent.Call(Aggregate, aNode);
   end;//Supports(aNode, INodeBase, l_Node)
  end;
 finally
  Dec(f_SetCurrentLock);
 end;//try..finally
//#UC END# *4AA781EA039B_4AA68CA10101_impl*
end;//TPrimRubricatorForm.InternalInitRoot

procedure TPrimRubricatorForm.InternalSetRoot(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem);
//#UC START# *4AA7824B03DF_4AA68CA10101_var*
//#UC END# *4AA7824B03DF_4AA68CA10101_var*
begin
//#UC START# *4AA7824B03DF_4AA68CA10101_impl*
 with RubricatorList.TreeStruct do
  if not aNode.IsSame(RootNode) then
   Dispatcher.History.SaveState(Self.As_IvcmEntityForm); //Запись в историю
 InternalInitRoot(aNode, aRootToKeep, aMenuSectionItemToKeep);
//#UC END# *4AA7824B03DF_4AA68CA10101_impl*
end;//TPrimRubricatorForm.InternalSetRoot

procedure TPrimRubricatorForm.RubricatorListActionElement(Sender: TObject;
 Index: LongInt);
//#UC START# *525D4BD701CF_4AA68CA10101_var*
//#UC END# *525D4BD701CF_4AA68CA10101_var*
begin
//#UC START# *525D4BD701CF_4AA68CA10101_impl*
 if (RubricatorList.GetNode(Index) <> nil) then
  RubricExecute;
//#UC END# *525D4BD701CF_4AA68CA10101_impl*
end;//TPrimRubricatorForm.RubricatorListActionElement

function TPrimRubricatorForm.RubricatorListGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *525D4BE202AC_4AA68CA10101_var*
var
 l_AdapterNode : INodeBase;
//#UC END# *525D4BE202AC_4AA68CA10101_var*
begin
//#UC START# *525D4BE202AC_4AA68CA10101_impl*
 if Supports(RubricatorList.GetNode(Index), INodeBase, l_AdapterNode) then
 try
  Result := GetRubricatorImageIndex(l_AdapterNode);
 finally
  l_AdapterNode := nil;
 end
 else
  Result := -1;
//#UC END# *525D4BE202AC_4AA68CA10101_impl*
end;//TPrimRubricatorForm.RubricatorListGetItemImage

procedure TPrimRubricatorForm.RubricatorListTreeChanged(aSender: TObject;
 const anOldTree: Il3SimpleTree;
 const aNewTree: Il3SimpleTree);
//#UC START# *525D4CF902DC_4AA68CA10101_var*
//#UC END# *525D4CF902DC_4AA68CA10101_var*
begin
//#UC START# *525D4CF902DC_4AA68CA10101_impl*
 if (f_SetCurrentLock = 0) then
  if (aNewTree <> nil) then
   Self.Rubricator_Synchronize_Execute;
//#UC END# *525D4CF902DC_4AA68CA10101_impl*
end;//TPrimRubricatorForm.RubricatorListTreeChanged

function TPrimRubricatorForm.NewDocLabelJumpTo(Sender: TObject;
 anEffects: TafwJumpToEffects;
 const aMoniker: IevMoniker): Boolean;
//#UC START# *525D4D05018C_4AA68CA10101_var*
//#UC END# *525D4D05018C_4AA68CA10101_var*
begin
//#UC START# *525D4D05018C_4AA68CA10101_impl*
 Result := True;
 CallGarant;
//#UC END# *525D4D05018C_4AA68CA10101_impl*
end;//TPrimRubricatorForm.NewDocLabelJumpTo

procedure TPrimRubricatorForm.ExampleTextSourceMakeDocumentContainer(Sender: TObject;
 var aMade: InevDocumentContainer);
//#UC START# *525D4D190205_4AA68CA10101_var*
//#UC END# *525D4D190205_4AA68CA10101_var*
begin
//#UC START# *525D4D190205_4AA68CA10101_impl*
 aMade.ReadFrom(Tl3StringStream.Make(l3PCharLen(vcmCStr(str_NewDocsEVD))));
//#UC END# *525D4D190205_4AA68CA10101_impl*
end;//TPrimRubricatorForm.ExampleTextSourceMakeDocumentContainer

procedure TPrimRubricatorForm.NewDocLabelBreakingPara(aSender: TObject;
 out aHandled: Boolean);
//#UC START# *525D4D28010E_4AA68CA10101_var*
//#UC END# *525D4D28010E_4AA68CA10101_var*
begin
//#UC START# *525D4D28010E_4AA68CA10101_impl*
 CallGarant;
 aHandled := True;
//#UC END# *525D4D28010E_4AA68CA10101_impl*
end;//TPrimRubricatorForm.NewDocLabelBreakingPara

procedure TPrimRubricatorForm.PaintBoxPaint(Sender: TObject);
//#UC START# *525D4D3402A7_4AA68CA10101_var*
var
 l_IndentX: Integer;
 l_IndentY: Integer;
//#UC END# *525D4D3402A7_4AA68CA10101_var*
begin
//#UC START# *525D4D3402A7_4AA68CA10101_impl*
 with PaintBox.Canvas do
 begin
  l_IndentX := (PaintBox.Width - 16) div 2;
  l_IndentY := (TopPanel.Height - 16) div 2;
  dmStdRes.SmallImageList.Draw(PaintBox.Canvas, l_IndentX, l_IndentY, cInternetTips);
 end;
//#UC END# *525D4D3402A7_4AA68CA10101_impl*
end;//TPrimRubricatorForm.PaintBoxPaint

procedure TPrimRubricatorForm.NewDocLabelGetHotSpotInfo(Sender: TObject;
 const aHotSpot: IevHotSpot;
 const aKeys: TafwCursorState;
 var theInfo: TafwCursorInfo);
//#UC START# *525D4D3F0361_4AA68CA10101_var*
//#UC END# *525D4D3F0361_4AA68CA10101_var*
begin
//#UC START# *525D4D3F0361_4AA68CA10101_impl*
 if Supports(aHotSpot, IevHyperlink) then
  theInfo.rCursor := ev_csExternalHand
 else
  theInfo.rCursor := ev_csArrow;
//#UC END# *525D4D3F0361_4AA68CA10101_impl*
end;//TPrimRubricatorForm.NewDocLabelGetHotSpotInfo

procedure TPrimRubricatorForm.CallGarant;
//#UC START# *525D4D500351_4AA68CA10101_var*
//#UC END# *525D4D500351_4AA68CA10101_var*
begin
//#UC START# *525D4D500351_4AA68CA10101_impl*
 case f_LinkType of
  NM_NEW_DOCS:
   if afw.Application.LocaleInfo.Language = afw_lngEnglish then
    nsDoShellExecute(nsCStr(ciitEnglishGarant))
   else
    nsDoShellExecute(nsCStr(ciitHotDocs));
  NM_MONITORINGS:
   if afw.Application.LocaleInfo.Language = afw_lngEnglish then
    nsDoShellExecute(nsCStr(ciitEnglishGarant))
   else
    nsDoShellExecute(nsCStr(ciitHotDocs));
 end;
//#UC END# *525D4D500351_4AA68CA10101_impl*
end;//TPrimRubricatorForm.CallGarant

procedure TPrimRubricatorForm.RubricExecute;
//#UC START# *525D4DC500E2_4AA68CA10101_var*
var
 l_l3Node: Il3SimpleNode;
 l_Node: INodeBase;

 procedure lp_List;
 var
  l_DynList: IDynList;
  l_EntityBase: IEntityBase;
 begin
  try
   l_Node.GetEntity(l_EntityBase);
  except
   on ENoEntity do
   begin
    defDataAdapter.ShowMessageWithDealerInfo(war_EmtryListEntity);
    exit;
   end;
  end;{try..except}
  if Supports(l_EntityBase, IDynList, l_DynList) then
  try
   nsOpenList(l_DynList, NativeMainForm, wdAlwaysOpen, True, lofRubricator);
   // Синхронизация с элементом в Навигаторе
   Op_Navigator_SetCurrent.Call(Aggregate, l_l3Node);
  finally
   l_DynList := nil;
  end;//if Supports(l_EntityBase, IDynList, l_DynList) then
 end;//lp_List

 procedure lp_Document;
 var
  l_Document: IDocument;
  l_EntityBase: IEntityBase;
 begin
  try
   l_Node.GetEntity(l_EntityBase);
  except
   on ENoEntity do
    exit;
  end;{try..except}
  if Supports(l_EntityBase, IDocument, l_Document) then
  try
   TdmStdRes.OpenDocument(TdeDocInfo.Make(l_Document), nil);
   op_Navigator_SetCurrent.Call(Aggregate, l_l3Node);
  finally
   l_Document := nil;
  end;//if Supports(l_EntityBase, IDocument, l_Document) then
 end;//lp_Document

var
 l_RubricatorTree: InsRubricatorTree;
//#UC END# *525D4DC500E2_4AA68CA10101_var*
begin
//#UC START# *525D4DC500E2_4AA68CA10101_impl*
 l_l3Node := RubricatorList.GetCurrentNode;
 if (l_l3Node = nil) or
    (Aggregate = nil) then
  Exit;
 if Supports(l_l3Node, INodeBase, l_Node) then
 try
  if TNavigatorMenuItemType(l_Node.GetType) = NM_DOCUMENT then
   lp_Document
  else
  if not l_Node.HasChildren then
   lp_List
  else
  begin
   if not Supports(RubricatorList.TreeStruct, InsRubricatorTree,  l_RubricatorTree) then
    Assert(false);
   InternalSetRoot(l_l3Node, l_RubricatorTree.RootToKeep, l_RubricatorTree.MenuSectionItemToKeep);
  end;//not l_Node.HasChildren
 finally
  l_Node := nil;
 end;//try..finally
//#UC END# *525D4DC500E2_4AA68CA10101_impl*
end;//TPrimRubricatorForm.RubricExecute

procedure TPrimRubricatorForm.UpdateTopPanel(aNodeType: TNavigatorMenuItemType);
//#UC START# *525D4DF700DE_4AA68CA10101_var*
var
 l_Para: IevCommonControl;
//#UC END# *525D4DF700DE_4AA68CA10101_var*
begin
//#UC START# *525D4DF700DE_4AA68CA10101_impl*
 f_LinkType := aNodeType;
 TopPanel.Visible := aNodeType in [NM_NEW_DOCS, NM_MONITORINGS];
 DelimiterPanel.Visible := not TopPanel.Visible;
 if NewDocLabel.Document.Para[0].AsObject.QT(IevCommonControl, l_Para, NewDocLabel.Processor) then
  l_Para.Collapsed := aNodeType = NM_MONITORINGS;
//#UC END# *525D4DF700DE_4AA68CA10101_impl*
end;//TPrimRubricatorForm.UpdateTopPanel

procedure TPrimRubricatorForm.vcmEntityFormSaveState(out aState: IvcmBase;
 aStateType: TvcmStateType;
 var Saved: Boolean);
//#UC START# *525E7A2D0076_4AA68CA10101_var*
//#UC END# *525E7A2D0076_4AA68CA10101_var*
begin
//#UC START# *525E7A2D0076_4AA68CA10101_impl*
 if aStateType = vcm_stContent then
 begin
  aState := TnsRubricatorState.Make(TopPanel.Visible, f_LinkType).As_IvcmBase;
  Saved := True;
 end;
//#UC END# *525E7A2D0076_4AA68CA10101_impl*
end;//TPrimRubricatorForm.vcmEntityFormSaveState

procedure TPrimRubricatorForm.vcmEntityFormLoadState(const aState: IvcmBase;
 aStateType: TvcmStateType;
 var Loaded: Boolean);
//#UC START# *525E7A6300A6_4AA68CA10101_var*
var
 l_State: InsRubricatorState;
//#UC END# *525E7A6300A6_4AA68CA10101_var*
begin
//#UC START# *525E7A6300A6_4AA68CA10101_impl*
 if (aStateType = vcm_stContent) and Supports(aState, InsRubricatorState, l_State) then
 begin
  TopPanel.Visible := l_State.NewDocLabelVisible;
  DelimiterPanel.Visible := not TopPanel.Visible;
  f_LinkType := l_State.LinkType;
  Loaded := True;
 end;
//#UC END# *525E7A6300A6_4AA68CA10101_impl*
end;//TPrimRubricatorForm.vcmEntityFormLoadState

procedure TPrimRubricatorForm.Rubricator_SetListRoot_Execute(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem);
//#UC START# *4AA7805301DC_4AA68CA10101exec_var*
//#UC END# *4AA7805301DC_4AA68CA10101exec_var*
begin
//#UC START# *4AA7805301DC_4AA68CA10101exec_impl*
 if (aNode <> nil) then
  InternalSetRoot(aNode, aRootToKeep, aMenuSectionItemToKeep)
 else
 begin
  CCaption := nil;
  RubricatorList.TreeStruct.RootNode := nil;
 end;//aNode <> nil
//#UC END# *4AA7805301DC_4AA68CA10101exec_impl*
end;//TPrimRubricatorForm.Rubricator_SetListRoot_Execute

procedure TPrimRubricatorForm.Rubricator_SetListRoot(const aParams: IvcmExecuteParams);
begin
 with IRubricator_SetListRoot_Params(aParams.Data) do
  Self.Rubricator_SetListRoot_Execute(Node, RootToKeep, MenuSectionItemToKeep);
end;//TPrimRubricatorForm.Rubricator_SetListRoot

procedure TPrimRubricatorForm.Rubricator_InitListRoot_Execute(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem);
//#UC START# *4AA7806601AE_4AA68CA10101exec_var*
//#UC END# *4AA7806601AE_4AA68CA10101exec_var*
begin
//#UC START# *4AA7806601AE_4AA68CA10101exec_impl*
 if (aNode <> nil) then
  InternalInitRoot(aNode, aRootToKeep, aMenuSectionItemToKeep)
 else
 begin
  CCaption := nil;
  RubricatorList.TreeStruct.RootNode := nil;
 end;//aNode <> nil
//#UC END# *4AA7806601AE_4AA68CA10101exec_impl*
end;//TPrimRubricatorForm.Rubricator_InitListRoot_Execute

procedure TPrimRubricatorForm.Rubricator_InitListRoot(const aParams: IvcmExecuteParams);
begin
 with IRubricator_InitListRoot_Params(aParams.Data) do
  Self.Rubricator_InitListRoot_Execute(Node, RootToKeep, MenuSectionItemToKeep);
end;//TPrimRubricatorForm.Rubricator_InitListRoot

procedure TPrimRubricatorForm.Rubricator_Synchronize_Execute;
//#UC START# *4AA7809901AE_4AA68CA10101exec_var*
//#UC END# *4AA7809901AE_4AA68CA10101exec_var*
begin
//#UC START# *4AA7809901AE_4AA68CA10101exec_impl*
 Op_Navigator_SetCurrent.Call(Aggregate, RubricatorList.TreeStruct.RootNode);
//#UC END# *4AA7809901AE_4AA68CA10101exec_impl*
end;//TPrimRubricatorForm.Rubricator_Synchronize_Execute

procedure TPrimRubricatorForm.Rubricator_Synchronize(const aParams: IvcmExecuteParams);
begin
 Self.Rubricator_Synchronize_Execute;
end;//TPrimRubricatorForm.Rubricator_Synchronize

function TPrimRubricatorForm.Rubricator_GetRoot_Execute: Il3SimpleNode;
//#UC START# *4B02CFA303DA_4AA68CA10101exec_var*
//#UC END# *4B02CFA303DA_4AA68CA10101exec_var*
begin
//#UC START# *4B02CFA303DA_4AA68CA10101exec_impl*
 if RubricatorList.IsTreeAssign then
  Result := RubricatorList.TreeStruct.RootNode
 else
  Result := nil;
//#UC END# *4B02CFA303DA_4AA68CA10101exec_impl*
end;//TPrimRubricatorForm.Rubricator_GetRoot_Execute

procedure TPrimRubricatorForm.Rubricator_GetRoot(const aParams: IvcmExecuteParams);
begin
 with IRubricator_GetRoot_Params(aParams.Data) do
  ResultValue := Self.Rubricator_GetRoot_Execute;
end;//TPrimRubricatorForm.Rubricator_GetRoot

procedure TPrimRubricatorForm.Rubric_Execute_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C4433150077_4AA68CA10101exec_var*
//#UC END# *4C4433150077_4AA68CA10101exec_var*
begin
//#UC START# *4C4433150077_4AA68CA10101exec_impl*
 RubricExecute;
//#UC END# *4C4433150077_4AA68CA10101exec_impl*
end;//TPrimRubricatorForm.Rubric_Execute_Execute

procedure TPrimRubricatorForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AA68CA10101_var*
//#UC END# *479731C50290_4AA68CA10101_var*
begin
//#UC START# *479731C50290_4AA68CA10101_impl*
 inherited;
 RubricatorList.TreeStruct := nil;
//#UC END# *479731C50290_4AA68CA10101_impl*
end;//TPrimRubricatorForm.Cleanup

procedure TPrimRubricatorForm.InitFields;
//#UC START# *47A042E100E2_4AA68CA10101_var*
//#UC END# *47A042E100E2_4AA68CA10101_var*
begin
//#UC START# *47A042E100E2_4AA68CA10101_impl*
 inherited;
 f_SetCurrentLock := 0;

 OnSaveState := VcmEntityFormSaveState;
 OnLoadState := VcmEntityFormLoadState;
//#UC END# *47A042E100E2_4AA68CA10101_impl*
end;//TPrimRubricatorForm.InitFields

procedure TPrimRubricatorForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4AA68CA10101_var*
//#UC END# *4A8E8F2E0195_4AA68CA10101_var*
begin
//#UC START# *4A8E8F2E0195_4AA68CA10101_impl*
 inherited;
 ActiveControl := RubricatorList;

 with RubricatorList do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  TabOrder := 1;
  ShowHeader := False;
  PickedList := False;
  MultiSelect := False;
  MultiStrokeItem := True;
  ActionElementMode := l3_amSingleClick;
  ViewOptions := [voShowInterRowSpace, voShowIcons, voShowExpandable, voShowLines];
  UseStyleTable := True;
  StyleId := ev_saInterface;
  AllowWithoutCurrent := False;
  FooterVisible := False;
  FooterStyleID := ev_saHyperLink;
  FooterActiveStyleID := ev_saActiveHyperlink;
  SettingId := 'stidRubricatorList';
  Images := nsRubricatorRes.RubricatorItemsImageList;

  OnGetItemImage := RubricatorListGetItemImage;
  OnActionElement := RubricatorListActionElement;
  OnTreeChanged := RubricatorListTreeChanged;
 end;
 with TopPanel do
 begin
  Align := alTop;
  Height := 41;
  BevelOuter := bvNone;
  Color := clWindow;
  TabOrder := 0;
  Visible := False;
 end;
 with PaintBox do
 begin
  Width := 25;
  Align := alLeft;
  OnPaint := PaintBoxPaint;
 end;
 with NewDocLabel do
 begin
  Align := alClient;
  TabOrder := 0;
  TextSource := ExampleTextSource;
  IsStaticText := True;
  ScrollStyle := ssNone;
  OnGetHotSpotInfo := NewDocLabelGetHotSpotInfo;
  OnJumpTo := NewDocLabelJumpTo;
  OnBreakingPara := NewDocLabelBreakingPara;
 end;
 with DelimiterPanel do
 begin
  Height := 12;
  Align := alTop;
  //Top := 0; // в самый верХ
  TopPanel.Top := 100; // сдвигаем под DelimiterPanel
  BevelOuter := bvNone;
  Color := clWindow;
  TabOrder := 2;
 end;
 with ExampleTextSource do
  OnMakeDocumentContainer := ExampleTextSourceMakeDocumentContainer;
//#UC END# *4A8E8F2E0195_4AA68CA10101_impl*
end;//TPrimRubricatorForm.InitControls

{$If NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TPrimRubricatorForm.DoGetTabImageIndex: Integer;
//#UC START# *543E3AA801D0_4AA68CA10101_var*
//#UC END# *543E3AA801D0_4AA68CA10101_var*
begin
//#UC START# *543E3AA801D0_4AA68CA10101_impl*
 Result := nsTabIconIndex(titRubricator);
//#UC END# *543E3AA801D0_4AA68CA10101_impl*
end;//TPrimRubricatorForm.DoGetTabImageIndex
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

procedure TPrimRubricatorForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_Rubricator, nil);
  PublishFormEntity(en_Tree, nil);
  PublishFormEntity(en_Rubric, nil);
  ContextMenuWeight(en_Tree, 10);
  MakeEntitySupportedByControl(en_Edit, RubricatorList);
  MakeEntitySupportedByControl(en_Tree, RubricatorList);
  PublishOpWithResult(en_Rubricator, op_SetListRoot, Rubricator_SetListRoot, nil, nil);
  PublishOpWithResult(en_Rubricator, op_InitListRoot, Rubricator_InitListRoot, nil, nil);
  PublishOpWithResult(en_Rubricator, op_Synchronize, Rubricator_Synchronize, nil, nil);
  PublishOpWithResult(en_Rubricator, op_GetRoot, Rubricator_GetRoot, nil, nil);
  PublishOp(en_Rubric, op_Execute, Rubric_Execute_Execute, nil, nil);
  ShowInContextMenu(en_Rubric, op_Execute, True);
 end;//with Entities.Entities
end;//TPrimRubricatorForm.InitEntities

procedure TPrimRubricatorForm.MakeControls;
begin
 inherited;
 with AddUsertype(utRubricatorListName,
  str_utRubricatorListCaption,
  str_utRubricatorListSettingsCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utRubricatorListName
 f_RubricatorList := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_RubricatorList.Name := 'RubricatorList';
 f_RubricatorList.Parent := Self;
 f_TopPanel := TvtPanel.Create(Self);
 f_TopPanel.Name := 'TopPanel';
 f_TopPanel.Parent := Self;
 f_PaintBox := TPaintBox.Create(Self);
 f_PaintBox.Name := 'PaintBox';
 f_PaintBox.Parent := TopPanel;
 f_NewDocLabel := TnscSimpleEditor.Create(Self);
 f_NewDocLabel.Name := 'NewDocLabel';
 f_NewDocLabel.Parent := TopPanel;
 f_DelimiterPanel := TvtPanel.Create(Self);
 f_DelimiterPanel.Name := 'DelimiterPanel';
 f_DelimiterPanel.Parent := Self;
 f_ExampleTextSource := TnscTextSource.Create(Self);
 f_ExampleTextSource.Name := 'ExampleTextSource';
end;//TPrimRubricatorForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimRubricatorForm);
 {* Регистрация PrimRubricator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
