unit PrimSelectedAttributes_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimSelectedAttributes_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimSelectedAttributes" MUID: (497EC3B20359)
// Имя типа: "TPrimSelectedAttributesForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchLite_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchInterfaces
 , SearchDomainInterfaces
 , nscTreeViewWithAdapterDragDrop
 , l3TreeInterfaces
 , DynamicTreeUnit
 , l3Tree_TLB
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , nsNodeBaseList
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimSelectedAttributesForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_SelectedTree: TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства SelectedTree }
  protected
   dsSelectedAttributes: IdsSelectedAttributes;
    {* Выбранные атрибуты }
   f_InternalOp: Boolean;
  private
   function SelectedTreeGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure SelectedTreeCurrentChanged(Sender: TObject;
    aNewCurrent: LongInt;
    aOldCurrent: LongInt);
   procedure SelectedTreeActionElement(Sender: TObject;
    Index: LongInt);
   procedure SelectedTreeMakeTreeSource(out theTree: Il3SimpleTree);
   procedure SyncCurrent(aIndex: Integer);
   procedure AddChain(const aNode: INodeBase;
    aNodePath: TnsNodeBaseList);
  protected
   function pm_GetTaggedTreeInfo: InsTaggedTreeInfo; virtual;
   procedure DeleteElement(const aNode: Il3Node;
    WithChildren: Boolean = False);
   function GetTaggedTreeInfo: InsTaggedTreeInfo;
   procedure AddNodes(aOp: TLogicOperation;
    const aIterator: INodeIterator);
   function GetTreeNode(const aNode: INodeBase): Il3SimpleNode; overload;
   function GetTreeNode(const aNode: Il3SimpleNode): Il3SimpleNode; overload;
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
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
   procedure AttributeTree_SetRoot_Execute(const aTag: Il3CString);
   procedure AttributeTree_SetRoot(const aParams: IvcmExecuteParams);
   procedure SelectedList_RefreshValues_Execute(const aData: InsSelectedAttributesIterators);
   procedure SelectedList_RefreshValues(const aParams: IvcmExecuteParams);
   {$If NOT Defined(NoVCM)}
   procedure Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
  private
   property TaggedTreeInfo: InsTaggedTreeInfo
    read pm_GetTaggedTreeInfo;
  public
   property SelectedTree: TnscTreeViewWithAdapterDragDrop
    read f_SelectedTree;
 end;//TPrimSelectedAttributesForm

implementation

uses
 l3ImplUses
 , l3StringIDEx
 , nsTreeAttributeNodesNew
 , SearchRes
 , nsSelectedTreeStruct
 , l3Nodes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimSelectedAttributes_utSelectedAttributes_UserType
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки utSelectedAttributesLocalConstants }
 str_utSelectedAttributesCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utSelectedAttributesCaption'; rValue : 'Поиск: Выбранные значения реквизита');
  {* Заголовок пользовательского типа "Поиск: Выбранные значения реквизита" }

function TPrimSelectedAttributesForm.pm_GetTaggedTreeInfo: InsTaggedTreeInfo;
//#UC START# *525FEC2A0302_497EC3B20359get_var*
//#UC END# *525FEC2A0302_497EC3B20359get_var*
begin
//#UC START# *525FEC2A0302_497EC3B20359get_impl*
 Supports(SelectedTree.TreeStruct, InsTaggedTreeInfo, Result);
//#UC END# *525FEC2A0302_497EC3B20359get_impl*
end;//TPrimSelectedAttributesForm.pm_GetTaggedTreeInfo

procedure TPrimSelectedAttributesForm.DeleteElement(const aNode: Il3Node;
 WithChildren: Boolean = False);
//#UC START# *4C87B5D300B0_497EC3B20359_var*
var
 l_Parent: Il3SimpleNode;
//#UC END# *4C87B5D300B0_497EC3B20359_var*
begin
//#UC START# *4C87B5D300B0_497EC3B20359_impl*
 if (aNode <> nil) and
    (WithChildren or not aNode.HasChild) then
 begin
  l_Parent := aNode.Parent;
  try
   aNode.Remove;
   DeleteElement(l_Parent as Il3Node);
  finally
   l_Parent := nil;
  end;
 end;
//#UC END# *4C87B5D300B0_497EC3B20359_impl*
end;//TPrimSelectedAttributesForm.DeleteElement

function TPrimSelectedAttributesForm.SelectedTreeGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *525FEB0400DB_497EC3B20359_var*
var
 l_l3Node: Il3SimpleNode;
 l_Node: INodeBase;
 l_Op: InsLogicOperation;
//#UC END# *525FEB0400DB_497EC3B20359_var*
begin
//#UC START# *525FEB0400DB_497EC3B20359_impl*
 l_l3Node := SelectedTree.GetNode(Index);
 if l_l3Node.Parent = nil then
  Result := siilSelectedRoot
 else
 begin
  if Supports(l_l3Node, INodeBase, l_Node) then
  begin;
   if l_Node.HasChildren then
    Result := siilFolderStart
   else
    Result := siilSelectedElement;
  end
  else
   if Supports(l_l3Node, InsLogicOperation, l_Op) then
    Result := siilFolderStart + Integer(l_Op.Operation)
   else
    Result := siilSelectedElement;
 end;
//#UC END# *525FEB0400DB_497EC3B20359_impl*
end;//TPrimSelectedAttributesForm.SelectedTreeGetItemImage

procedure TPrimSelectedAttributesForm.SelectedTreeCurrentChanged(Sender: TObject;
 aNewCurrent: LongInt;
 aOldCurrent: LongInt);
//#UC START# *525FEB0E0386_497EC3B20359_var*
//#UC END# *525FEB0E0386_497EC3B20359_var*
begin
//#UC START# *525FEB0E0386_497EC3B20359_impl*
 if aNewCurrent <> -1 then
  SyncCurrent(aNewCurrent);
//#UC END# *525FEB0E0386_497EC3B20359_impl*
end;//TPrimSelectedAttributesForm.SelectedTreeCurrentChanged

procedure TPrimSelectedAttributesForm.SelectedTreeActionElement(Sender: TObject;
 Index: LongInt);
//#UC START# *525FEB180374_497EC3B20359_var*
//#UC END# *525FEB180374_497EC3B20359_var*
begin
//#UC START# *525FEB180374_497EC3B20359_impl*
 SyncCurrent(Index);
//#UC END# *525FEB180374_497EC3B20359_impl*
end;//TPrimSelectedAttributesForm.SelectedTreeActionElement

procedure TPrimSelectedAttributesForm.SelectedTreeMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *525FEB3B015A_497EC3B20359_var*
//#UC END# *525FEB3B015A_497EC3B20359_var*
begin
//#UC START# *525FEB3B015A_497EC3B20359_impl*
 theTree := TnsSelectedTreeStruct.Make(nil, SelectedTree.ShowRoot);
//#UC END# *525FEB3B015A_497EC3B20359_impl*
end;//TPrimSelectedAttributesForm.SelectedTreeMakeTreeSource

procedure TPrimSelectedAttributesForm.SyncCurrent(aIndex: Integer);
//#UC START# *525FEBEA03A1_497EC3B20359_var*
var
 l_l3Node: Il3SimpleNode;
 l_Node: INodeBase;
//#UC END# *525FEBEA03A1_497EC3B20359_var*
begin
//#UC START# *525FEBEA03A1_497EC3B20359_impl*
 if (aIndex >= 0) and not f_InternalOp then
 begin
  l_l3Node := SelectedTree.GetNode(aIndex);
  if (Aggregate <> nil) and Supports(l_l3Node, INodeBase, l_Node) then
   op_AttributeTree_SetCurrent.Call(Aggregate, l_l3Node);
 end;
//#UC END# *525FEBEA03A1_497EC3B20359_impl*
end;//TPrimSelectedAttributesForm.SyncCurrent

procedure TPrimSelectedAttributesForm.AddChain(const aNode: INodeBase;
 aNodePath: TnsNodeBaseList);
//#UC START# *525FED16034D_497EC3B20359_var*
var
 l_Parent: INodeBase;
 l_Node: INodeBase;
 l_Root,
 l_TempNode: Il3Node;
 l_Searching: Boolean;
 l_Index: Integer;
 l_CurNode: INodeBase;

 function FindNode(const anIntf: Il3Node) : Boolean;
 var
  l_LevelNode: INodeBase;
 begin
  Result := Supports(anIntf, INodeBase, l_LevelNode) and l_CurNode.IsSameNode(l_LevelNode);
 end;
//#UC END# *525FED16034D_497EC3B20359_var*
begin
//#UC START# *525FED16034D_497EC3B20359_impl*
 aNodePath.Clear;

 l_Node := aNode;
 while True do
 begin
  l_Node.GetParent(l_Parent);
  if l_Parent = nil then
   break;
  aNodePath.Insert(0, l_Node);
  l_Node := l_Parent;
 end;

 l_Searching := True;
 l_Root := SelectedTree.CTree.CRootNode;
 for l_Index := 0 to aNodePath.Count - 1 do
 begin
  l_CurNode := aNodePath[l_Index];
  if l_Searching then
  begin
   l_TempNode := l_Root.IterateF(l3L2NA(@FindNode), imOneLevel or imCheckResult);
   if l_TempNode <> nil then
   begin
    l_Root := l_TempNode;
    continue;
   end
   else
    l_Searching := False;
  end;

  l_TempNode := TnsSelectedNode.Make(l_CurNode, False);
  l_Root.InsertChild(l_TempNode);
  SelectedTree.ExpandNode(l_Root, True);
  l_Root := l_TempNode;
 end;
//#UC END# *525FED16034D_497EC3B20359_impl*
end;//TPrimSelectedAttributesForm.AddChain

function TPrimSelectedAttributesForm.GetTaggedTreeInfo: InsTaggedTreeInfo;
//#UC START# *4AF3F36700D7_497EC3B20359_var*
//#UC END# *4AF3F36700D7_497EC3B20359_var*
begin
//#UC START# *4AF3F36700D7_497EC3B20359_impl*
 Result := TaggedTreeInfo;
//#UC END# *4AF3F36700D7_497EC3B20359_impl*
end;//TPrimSelectedAttributesForm.GetTaggedTreeInfo

procedure TPrimSelectedAttributesForm.AddNodes(aOp: TLogicOperation;
 const aIterator: INodeIterator);
//#UC START# *4AF40E300070_497EC3B20359_var*
var
 l_LogicNode,
 l_CacheNode: Il3Node;
 l_NodeBase: INodeBase;
 l_NodePath: TnsNodeBaseList;
 l_Brief: Boolean;
//#UC END# *4AF40E300070_497EC3B20359_var*
begin
//#UC START# *4AF40E300070_497EC3B20359_impl*
 if (dsSelectedAttributes <> nil) then
  l_Brief := not dsSelectedAttributes.IsOneOperation
 else
 if Assigned(TaggedTreeInfo) then
  l_Brief := not TaggedTreeInfo.IsOneLogicOperation
 else
  l_Brief := True;

 l_NodePath := TnsNodeBaseList.Create;
 try
  while True do
  begin
   aIterator.GetNext(l_NodeBase);
   if l_NodeBase = nil then
    break;

   if l_Brief then
   begin
    l_CacheNode := TnsSelectedNode.Make(l_NodeBase, True);
    try
     if l_LogicNode = nil then
      l_LogicNode := TnsLogicNode.Make(aOp);
     l_LogicNode.InsertChild(l_CacheNode);
    finally
     l_CacheNode := nil;
    end;
   end
   else
    AddChain(l_NodeBase, l_NodePath);
  end;

  if (l_LogicNode <> nil) and
     l_Brief then
   SelectedTree.ExpandNode(SelectedTree.CTree.CRootNode.InsertChild(l_LogicNode), True);
 finally
  vcmFree(l_NodePath);
 end;
//#UC END# *4AF40E300070_497EC3B20359_impl*
end;//TPrimSelectedAttributesForm.AddNodes

function TPrimSelectedAttributesForm.GetTreeNode(const aNode: INodeBase): Il3SimpleNode;
//#UC START# *4AF410BE0093_497EC3B20359_var*
  function FindNode(const anNode: Il3SimpleNode): boolean;
  Var
   l_Node: INodeBase;
  begin
   Result := False;
   if Supports(anNode, INodeBase, l_Node) then
   try
    if l_Node.IsSameNode(aNode) then
     Result := True;
   finally
    l_Node := nil;
   end;
  end;
//#UC END# *4AF410BE0093_497EC3B20359_var*
begin
//#UC START# *4AF410BE0093_497EC3B20359_impl*
 Result := SelectedTree.IterateF(l3L2NA(@FindNode), imCheckResult);
//#UC END# *4AF410BE0093_497EC3B20359_impl*
end;//TPrimSelectedAttributesForm.GetTreeNode

function TPrimSelectedAttributesForm.GetTreeNode(const aNode: Il3SimpleNode): Il3SimpleNode;
//#UC START# *4AF410CF023F_497EC3B20359_var*
  function FindNode(const anNode: Il3SimpleNode): boolean;
  begin
   Result := aNode.IsSame(anNode);   
  end;
//#UC END# *4AF410CF023F_497EC3B20359_var*
begin
//#UC START# *4AF410CF023F_497EC3B20359_impl*
 Result := SelectedTree.IterateF(l3L2NA(@FindNode), imCheckResult);
//#UC END# *4AF410CF023F_497EC3B20359_impl*
end;//TPrimSelectedAttributesForm.GetTreeNode

procedure TPrimSelectedAttributesForm.AttributeTree_SetRoot_Execute(const aTag: Il3CString);
//#UC START# *4AF3EBC001C4_497EC3B20359exec_var*
//#UC END# *4AF3EBC001C4_497EC3B20359exec_var*
begin
//#UC START# *4AF3EBC001C4_497EC3B20359exec_impl*
 GetTaggedTreeInfo.Tag := aTag
//#UC END# *4AF3EBC001C4_497EC3B20359exec_impl*
end;//TPrimSelectedAttributesForm.AttributeTree_SetRoot_Execute

procedure TPrimSelectedAttributesForm.AttributeTree_SetRoot(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IAttributeTree_SetRoot_Params) do
  Self.AttributeTree_SetRoot_Execute(Tag);
end;//TPrimSelectedAttributesForm.AttributeTree_SetRoot

procedure TPrimSelectedAttributesForm.SelectedList_RefreshValues_Execute(const aData: InsSelectedAttributesIterators);
//#UC START# *4AF40D070123_497EC3B20359exec_var*
var
 l_CurNode     : Il3SimpleNode;
 l_Node        : INodeBase;
 l_OpInterface : InsLogicOperation;
 l_Op          : TLogicOperation;
//#UC END# *4AF40D070123_497EC3B20359exec_var*
begin
//#UC START# *4AF40D070123_497EC3B20359exec_impl*
 l_Op := loNone;
 l_CurNode := SelectedTree.GetCurrentNode;
 try
  if not Supports(l_CurNode, INodeBase, l_Node) then
   if Supports(l_CurNode, InsLogicOperation, l_OpInterface) then
    l_Op := l_OpInterface.Operation;

  SelectedTree.CTree.CRootNode.ReleaseChilds;

  if Assigned(aData.OrIterator) then
   AddNodes(loOr, aData.OrIterator);
  if Assigned(aData.AndIterator) then
   AddNodes(loAnd, aData.AndIterator);
  if Assigned(aData.NotIterator) then
   AddNodes(loNot, aData.NotIterator);

  f_InternalOp := True;
  try
   if l_OpInterface <> nil then
    SelectedTree.GotoOnNode(GetTreeNode(TnsLogicNode.Make(l_Op)))
   else
    if l_Node <> nil then
     SelectedTree.GotoOnNode(GetTreeNode(TnsSelectedNode.Make(l_Node)))
    else
     SelectedTree.GotoOnNode(SelectedTree.TreeStruct.RootNode);
  finally
   f_InternalOp := False;
  end;
 finally
  l_CurNode := nil;
 end;
//#UC END# *4AF40D070123_497EC3B20359exec_impl*
end;//TPrimSelectedAttributesForm.SelectedList_RefreshValues_Execute

procedure TPrimSelectedAttributesForm.SelectedList_RefreshValues(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ISelectedList_RefreshValues_Params) do
  Self.SelectedList_RefreshValues_Execute(Data);
end;//TPrimSelectedAttributesForm.SelectedList_RefreshValues

procedure TPrimSelectedAttributesForm.Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
 {* Развернуть все }
//#UC START# *4BDAF7880236_497EC3B20359test_var*
//#UC END# *4BDAF7880236_497EC3B20359test_var*
begin
//#UC START# *4BDAF7880236_497EC3B20359test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := SelectedTree.TreeStruct.RootNode.HasChild;
//#UC END# *4BDAF7880236_497EC3B20359test_impl*
end;//TPrimSelectedAttributesForm.Tree_ExpandAll_Test

procedure TPrimSelectedAttributesForm.Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_497EC3B20359test_var*
//#UC END# *4BDAF7A2005C_497EC3B20359test_var*
begin
//#UC START# *4BDAF7A2005C_497EC3B20359test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := SelectedTree.TreeStruct.RootNode.HasChild;
//#UC END# *4BDAF7A2005C_497EC3B20359test_impl*
end;//TPrimSelectedAttributesForm.Tree_CollapseAll_Test

procedure TPrimSelectedAttributesForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_497EC3B20359_var*
var
 l_V : InsSelectedAttributesIterators;
//#UC END# *497469C90140_497EC3B20359_var*
begin
//#UC START# *497469C90140_497EC3B20359_impl*
 // Борьба с фильтром vs. история vs. _datasource
// if aFromHistory then
//  Exit;
 if (dsSelectedAttributes <> nil) then
 begin
  if Assigned(dsSelectedAttributes.RefreshValues) then
  begin
   l_V := dsSelectedAttributes.RefreshValues;
   try
    SelectedTree.TreeStruct := TnsSelectedTreeStruct.Make(dsSelectedAttributes.Search.Tag, SelectedTree.ShowRoot);
    // Обновим выбранные атрибуты
    SelectedList_RefreshValues_Execute(l_V);
   finally
    l_V := nil;
   end;//try..finally
  end;//if Assigned(l_DS.Data) then
 end;//dsSelectedAttributes <> nil
//#UC END# *497469C90140_497EC3B20359_impl*
end;//TPrimSelectedAttributesForm.NotifyDataSourceChanged

procedure TPrimSelectedAttributesForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_497EC3B20359_var*
//#UC END# *49803F5503AA_497EC3B20359_var*
begin
//#UC START# *49803F5503AA_497EC3B20359_impl*
 inherited;
 SelectedTree.Images := nsSearchRes.SearchItemsImageList;
 f_InternalOp := False;
//#UC END# *49803F5503AA_497EC3B20359_impl*
end;//TPrimSelectedAttributesForm.DoInit

procedure TPrimSelectedAttributesForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_497EC3B20359_var*
//#UC END# *4A8E8F2E0195_497EC3B20359_var*
begin
//#UC START# *4A8E8F2E0195_497EC3B20359_impl*
 inherited;
 ActiveControl := SelectedTree;
 Scaled := False;
 Style.Toolbars.Top.MergeWithContainer := vcm_bFalse;
 with SelectedTree do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  TabOrder := 0;
  ShowRoot := True;
  MultiStrokeItem := True;
  ViewOptions := [voShowInterRowSpace, voShowIcons, voShowExpandable, voShowRoot, voShowLines, voShowOpenChip];
  OnMakeTreeSource := SelectedTreeMakeTreeSource;
  OnGetItemImage := SelectedTreeGetItemImage;
  OnActionElement := SelectedTreeActionElement;
  OnCurrentChanged := SelectedTreeCurrentChanged;
  SettingId := 'stidSelectedTree';
 end;
//#UC END# *4A8E8F2E0195_497EC3B20359_impl*
end;//TPrimSelectedAttributesForm.InitControls

procedure TPrimSelectedAttributesForm.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
end;//TPrimSelectedAttributesForm.SignalDataSourceChanged

procedure TPrimSelectedAttributesForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_AttributeTree, nil);
  PublishFormEntity(en_SelectedList, nil);
  PublishFormEntity(en_Tree, nil);
  PublishOpWithResult(en_AttributeTree, op_SetRoot, AttributeTree_SetRoot, nil, nil);
  PublishOpWithResult(en_SelectedList, op_RefreshValues, SelectedList_RefreshValues, nil, nil);
  PublishOp(en_Tree, op_ExpandAll, nil, Tree_ExpandAll_Test, nil);
  PublishOp(en_Tree, op_CollapseAll, nil, Tree_CollapseAll_Test, nil);
 end;//with Entities.Entities
end;//TPrimSelectedAttributesForm.InitEntities

procedure TPrimSelectedAttributesForm.MakeControls;
begin
 inherited;
 with AddUsertype(utSelectedAttributesName,
  str_utSelectedAttributesCaption,
  str_utSelectedAttributesCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utSelectedAttributesName
 f_SelectedTree := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_SelectedTree.Name := 'SelectedTree';
 f_SelectedTree.Parent := Self;
end;//TPrimSelectedAttributesForm.MakeControls

initialization
 str_utSelectedAttributesCaption.Init;
 {* Инициализация str_utSelectedAttributesCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSelectedAttributesForm);
 {* Регистрация PrimSelectedAttributes }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
