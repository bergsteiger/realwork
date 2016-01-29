unit eeTreeViewExport;

interface

uses
 l3IntfUses
 , eeInterfaces
 , l3Interfaces
 , vtOutlinerWithDragDrop
 , vcmExternalInterfaces
 , afwInterfaces
 , l3TreeInterfaces
 , Messages
 , l3IID
 , Classes
 , vtOutliner
 , l3CacheableBase
 , eeInterfacesEx
;

type
 TeeRootChangedEvent = procedure(aSender: TObject;
  const anOldRoot: IeeNode;
  const aNewRoot: IeeNode) of object;
 
 TeeFormatStatusInfo = procedure(aSender: TObject;
  var Info: Il3CString;
  aCurrent: Integer;
  aCount: Integer;
  aSelected: Integer) of object;
 
 TeeCurrentIndexChangedEvent = procedure(aNew: Integer;
  anOld: Integer) of object;
  {* Событие смены индекса текущего в дереве }
 
 TeeTreeViewExportPrim = class(TvtOutlinerWithDragDrop, IvcmState, Il3SelectCountChangedRecipient, IafwStatusElement, Il3RootSpy, Il3NodeNotifyRecipient, IvcmCloneableState)
  procedure DoCurrentIndexChanged(aNew: Integer;
   anOld: Integer);
  function DoLoadState(const aState: IUnknown;
   aStateType: TvcmStateType;
   aForClone: Boolean): Boolean;
  function DoSaveState(out aState: IUnknown;
   aStateType: TvcmStateType;
   aForClone: Boolean): Boolean;
  function GetSelectedCountForStatusbar: Integer;
  function IsTreeStructAssigned: Boolean;
  procedure MakeItemVisible(aIndex: Integer);
   {* делает узел видимым, влияет на прокрутку }
  procedure RootChanged(const anOldRoot: Il3SimpleRootNode;
   const aNewRoot: Il3SimpleRootNode); overload;
  procedure RootChanged(const anOldRoot: IeeNode;
   const aNewRoot: IeeNode); overload;
  procedure UpdateStatus;
   {* при появлении у дерева TreeStruct, TreeView обновляем строку состояния. До правок возникала ситуации когда статусная строка у дерева справшивалась до появления TreeStruct, TreeView (CQ: OIT500021361) }
  procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk);
  function SaveState(out theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  function LoadState(const theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  procedure GetStatusInfo(out theString: IafwCString;
   out theNeedProgress: Boolean);
  procedure Notify(aOperation: Integer;
   const aNode: Il3SimpleNode);
   {* прошла операция. }
  function SaveStateForClone(out theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  function LoadCloneState(const aState: IUnknown;
   aStateType: TvcmStateType): Boolean;
 end;//TeeTreeViewExportPrim
 
 TeeTreeViewShadow = class(Tl3CacheableBase, IeeTree, IeeTreeView, IeeTool)
  procedure Create(aTreeView: TeeTreeViewExportPrim);
  function Make(aTreeView: TeeTreeViewExportPrim): IeeTreeView;
  procedure OwnerDead;
   {* Нотификация о смерти родителя. }
  function Root: IeeNode;
  function SelectedCount: Integer;
  function NodeFlags: Integer;
  function FlagsByAbsIndex: Integer;
  function TestFlagMask(aAbsIndex: LongInt;
   aFlagMask: Integer): Boolean;
  procedure SetFlagMask(aAbsIndex: LongInt;
   aFlagMask: Integer;
   aMode: TeeSetBitType); overload;
  procedure SetFlagMask(const aRNode: IeeNode;
   aFlagMask: Integer;
   aMode: TeeSetBitType); overload;
  procedure ExpandSubDir(const RNode: IeeNode;
   Expand: Boolean;
   DeepLevel: Byte);
   {* развернуть/свернуть узлы }
  function ChangeExpand(const RNode: IeeNode;
   Mode: TeeSetBitType;
   aForceMode: Boolean): Boolean;
  function IsChanging: Boolean;
   {* дерево находится в фазе обновления }
  procedure Changing;
  procedure Changed;
  function GetAbsIndex(const aNode: IeeNode): Integer; overload;
  function GetAbsIndex(anIndex: Integer): Integer; overload;
  function Iterate(Action: TeeNodeAction;
   IterMode: Integer;
   const aSubRootNode: IeeNode;
   const aFromNode: IeeNode): IeeNode;
   {* перебрать все узлы. IterMode см. imExpandOnly etc. }
  function IterateF(Action: TeeNodeAction;
   IterMode: Integer;
   const aSubRootNode: IeeNode;
   const aFromNode: IeeNode): IeeNode;
   {* перебрать все узлы и освободить заглушку для Action }
  function GetNextSelected(const aCurNode: IeeNode): IeeNode;
  procedure ClearSelected;
  procedure SetAllFlags(aMode: TeeSetBitType;
   aFlags: Integer);
  function GetNode(anIndex: Integer): IeeNode;
  function GetNodeByAbsIndex(anAbsIndex: Integer): IeeNode;
  function Wake: Boolean;
  function IsExpanded(const aNode: IeeNode): Boolean;
  function Tree: IeeTree;
  function Current: Integer;
  function AbsCurrent: Integer;
  function CurrentNode: IeeNode;
  function GetNodeIndex(const aNode: IeeNode): Integer;
  function GetNodeAbsIndex(const aNode: IeeNode): Integer;
  procedure ExpandAll;
  procedure CollapseAll;
  function GoToNode(const aNode: IeeNode): LongInt;
 end;//TeeTreeViewShadow
 
 IeeTreeState = interface
  function GetTree: Il3SimpleTree;
  procedure SetTree(const aValue: Il3SimpleTree;
   const aData: TvtOutlinerHystoryData);
  function GetData: TvtOutlinerHystoryData;
 end;//IeeTreeState
 
 TeeTreeState = class(Tl3CacheableBase, IeeTreeState)
  procedure Create(const aTree: Il3SimpleTree;
   const aData: TvtOutlinerHystoryData);
  function Make(const aTree: Il3SimpleTree;
   const aData: TvtOutlinerHystoryData): IeeTreeState;
  function GetTree: Il3SimpleTree;
  procedure SetTree(const aValue: Il3SimpleTree;
   const aData: TvtOutlinerHystoryData);
  function GetData: TvtOutlinerHystoryData;
 end;//TeeTreeState
 
 TeeTreeViewExport = class(TeeTreeViewExportPrim)
  {* Компонент для экспорта отображения дерева }
 end;//TeeTreeViewExport
 
implementation

uses
 l3ImplUses
 , eeNode
 , afwFacade
 , Windows
 , l3ControlsTypes
 , SysUtils
 , l3String
 , nevInterfaces
 , l3Types
 , evStyleTableSpy
 , OvcConst
 , l3InterfacesMisc
 , l3Tree_TLB
 , l3Nodes
 , l3Base
 , TtfwClassRef_Proxy
;

type
 TeeBT2L3BTMap = array [TeeSetBitType] of Tl3SetBitType;
 
end.
