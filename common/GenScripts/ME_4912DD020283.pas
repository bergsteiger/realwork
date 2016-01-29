unit eeInterfaces;

interface

uses
 l3IntfUses
 , l3Interfaces
 , k2Base
 , l3Variant
 , evdTypes
 , nevNavigation
 , ActiveX
 , evInternalInterfaces
 , Windows
 , nevTools
;

type
 TeeDirection = (
  ee_dUp
  , ee_dUpMax
  , ee_dDown
  , ee_dDownMax
  , ee_dLeft
  , ee_dRight
 );//TeeDirection
 
 IeeBase = interface(Il3Base)
  {* Базовый интерфейс слоя EE }
 end;//IeeBase
 
 IeeNode = interface;
 
 TeeNodeAction = function(const anIntf: IeeNode): Boolean;
 
 IeeSubList = interface;
 
 IeeBlock = interface;
 
 IeeDocument = interface;
 
 IeePara = interface(IeeBase)
  function IsKindOf(aType: Tk2Type): Boolean;
  function IsSame(const aPara: IeePara): Boolean;
  function Delete: Boolean;
  function IsUserComment: Boolean;
  function AsObject: Tl3Variant;
 end;//IeePara
 
 IeeLeafPara = interface(IeePara)
 end;//IeeLeafPara
 
 IeeSub = interface(IeeBase)
  function Delete: Boolean;
  function Exists: Boolean;
  function Select: Boolean;
  function IsSame(const aSub: IeeSub): Boolean;
 end;//IeeSub
 
 IeeSubList = interface(IeeBase)
  function Add(anID: Integer;
   const aName: Il3CString): IeeSub;
 end;//IeeSubList
 
 IeeBlock = interface(IeeSub)
  function IsKindOf(aType: Tk2Type): Boolean;
 end;//IeeBlock
 
 TeeSetBitType = (
  ee_sbSelect
  , ee_sbDeselect
  , ee_sbInvert
 );//TeeSetBitType
 
 TeeMouseButton = (
  ee_mbLeft
  , ee_mbMiddle
  , ee_mbRight
 );//TeeMouseButton
 
 TeeMouseAction = (
  ee_maDown
  , ee_maUp
  , ee_maDouble
  , ee_maMove
 );//TeeMouseAction
 
 TeeSS = (
  ee_ssShift
  , ee_ssAlt
  , ee_ssCtrl
  , ee_ssLeft
  , ee_ssRight
  , ee_ssMiddle
  , ee_ssDouble
 );//TeeSS
 
 IeeNode = interface(IeeBase)
  function Iterate(anAction: TeeNodeAction;
   anIterMode: Integer;
   const aFromNode: IeeNode): IeeNode;
   {* перебрать все дочерние узлы. IterMode см. imExpandOnly etc. }
  function InsertChildBefore(const aNextChild: IeeNode;
   const aChild: IeeNode): IeeNode;
  procedure Changing;
  procedure Changed;
  procedure Remove;
  procedure Delete;
  procedure RemoveChildren;
  function Move(aDirection: TeeDirection): Boolean;
  procedure RelocateChild(const aChild: IeeNode);
   {* перемещает указанного ребенка, руководствуясь критериями сортировки относительно других детей (в пределах одного уровня) }
  procedure SortChilds;
  function GetLevelForParent(const aParent: IeeNode): Integer;
   {* Рассчитывает уровень текущей ноды относительно заданного Paretnt'а }
  function InsertChild(const aNode: IeeNode): IeeNode;
  function IterateF(anAction: TeeNodeAction;
   anIterMode: Integer;
   const aFromNode: IeeNode): IeeNode;
   {* перебрать все дочерние узлы и освободить заглушку для Action }
  function IsSameNode(const aNode: IeeNode): Boolean;
 end;//IeeNode
 
 IeeDocument = interface(IeeBase)
 end;//IeeDocument
 
 IeeTree = interface(IeeBase)
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
 end;//IeeTree
 
 IeeHotSpot = interface(IeeBase)
 end;//IeeHotSpot
 
 IeeTreeView = interface(IeeBase)
  {* Корневой интерфейс, представляющий доступ к контейнеру дерева }
  function GetNode(anIndex: Integer): IeeNode;
  function GetNodeIndex(const aNode: IeeNode): Integer;
  function GetNodeAbsIndex(const aNode: IeeNode): Integer;
  procedure ExpandAll;
  procedure CollapseAll;
  function GoToNode(const aNode: IeeNode): LongInt;
 end;//IeeTreeView
 
 TeeScrollStyle = (
  {* Тип определяющий какие ScrollBar'ы нужны. }
  ee_ssNone
  , ee_ssHorizontal
  , ee_ssVertical
  , ee_ssBoth
 );//TeeScrollStyle
 
 TeeScrollCode = (
  {* Код события от скроллера }
  scLineUp
  , scLineDown
  , scPageUp
  , scPageDown
  , scPosition
  , scTrack
  , scTop
  , scBottom
  , scEndScroll
 );//TeeScrollCode
 
 TeeShiftState = set of TeeSS;
 
 TeeCommentType = (
  ee_ctUsual
  , ee_ctUser
  , ee_ctVersion
 );//TeeCommentType
 
 IeeData = interface(IeeBase)
  {* Данные редактора }
 end;//IeeData
 
 IeePicture = interface(IeePara)
  procedure SaveToStream(const aStream: IStream);
 end;//IeePicture
 
 IeeCommands = interface(IeeBase)
  procedure Cut;
  procedure Copy;
  procedure Delete;
  function Paste: Boolean;
  procedure SelectAll;
  procedure HideSelection;
 end;//IeeCommands
 
 IeeEditor = interface(IevF1LikeEditor)
  {* Корневой интерфейс, представляющий доступ к функциям редактора }
  function GetHotspotOnPoint(const aPt: TPoint;
   out theHotSpot: IeeHotSpot): Boolean;
  function CanSplitPara(const aPara: IeePara): Boolean;
 end;//IeeEditor
 
 IeeStyledLeafPara = interface(IeeLeafPara)
  function IsComment: Boolean; overload;
  function IsComment(aType: TeeCommentType): Boolean; overload;
 end;//IeeStyledLeafPara
 
 IeeTextPara = interface(IeeStyledLeafPara)
 end;//IeeTextPara
 
 TeeScrollInfo = record
 end;//TeeScrollInfo
 
 IeeSubViewDescriptor = interface(IeeBase)
  {* Описатель вида отображения слоя меток }
 end;//IeeSubViewDescriptor
 
 IeeSubViewDescriptors = interface(IeeBase)
 end;//IeeSubViewDescriptors
 
 IeeSubPanel = interface(IeeBase)
 end;//IeeSubPanel
 
implementation

uses
 l3ImplUses
;

end.
