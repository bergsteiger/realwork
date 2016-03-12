unit eeInterfaces;

// ћодуль: "w:\common\components\gui\Garant\Everest_Engine\eeInterfaces.pas"
// —тереотип: "Interfaces"

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , k2Base
 , l3Variant
 , evdTypes
 , eeConst
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
  {* Ѕазовый интерфейс сло€ EE }
  ['{6EBCA3B6-40B1-40F1-98ED-AE0BE2BA29D5}']
 end;//IeeBase

 IeeNode = interface;

 TeeNodeAction = function(const anIntf: IeeNode): Boolean;

 IeeSubList = interface;

 IeeBlock = interface;

 IeeDocument = interface;

 IeePara = interface(IeeBase)
  ['{50FCF7A0-873B-4B9D-82AD-E74F44E8E87A}']
  function Get_Document: IeeDocument;
  function Get_Parent: IeePara;
  function Get_Block: IeeBlock;
  function Get_Subs: IeeSubList;
  function Get_Markers: IeeSubList;
  function Get_Bookmarks: IeeSubList;
  function Get_Marks: IeeSubList;
  function Get_ID: Integer;
  function Get_IndexInParent: Integer;
  function Get_Prev: IeePara;
  function Get_Next: IeePara;
  function IsKindOf(aType: Tk2Type): Boolean;
  function IsSame(const aPara: IeePara): Boolean;
  function Delete: Boolean;
  function IsUserComment: Boolean;
  function AsObject: Tl3Variant;
  property Document: IeeDocument
   read Get_Document;
  property Parent: IeePara
   read Get_Parent;
  property Block: IeeBlock
   read Get_Block;
  property Subs: IeeSubList
   read Get_Subs;
  property Markers: IeeSubList
   read Get_Markers;
  property Bookmarks: IeeSubList
   read Get_Bookmarks;
  property Marks: IeeSubList
   read Get_Marks;
  property ID: Integer
   read Get_ID;
  property IndexInParent: Integer
   read Get_IndexInParent;
  property Prev: IeePara
   read Get_Prev;
  property Next: IeePara
   read Get_Next;
 end;//IeePara

 IeeLeafPara = interface(IeePara)
  ['{DDC1952D-5A31-4579-BC1F-EDC964F2F7E5}']
 end;//IeeLeafPara

 IeeSub = interface(IeeBase)
  ['{D6B4D665-A330-410A-A2D2-067093332B58}']
  function Get_SubPlace: TevSubPlace;
  function Get_ID: Integer;
  function Get_LayerID: Integer;
  function Get_Flag: Integer;
  function Get_Flags: Integer;
  function Get_Name: Tl3WString;
  procedure Set_Name(const aValue: Tl3WString);
  function Get_Next: IeeSub;
  function Get_LeafPara: IeeLeafPara;
  function Get_Para: IeePara;
  function Delete: Boolean;
  function Exists: Boolean;
  function Select: Boolean;
  function IsSame(const aSub: IeeSub): Boolean;
  property SubPlace: TevSubPlace
   read Get_SubPlace;
  property ID: Integer
   read Get_ID;
  property LayerID: Integer
   read Get_LayerID;
  property Flag: Integer
   read Get_Flag;
  property Flags: Integer
   read Get_Flags;
  property Name: Tl3WString
   read Get_Name
   write Set_Name;
  property Next: IeeSub
   read Get_Next;
   {* следующа€ метка параграфа в том же слое }
  property LeafPara: IeeLeafPara
   read Get_LeafPara;
   {* абзац, на который указывает метка, €вл€етс€ абзацем нижнего уровн€ }
  property Para: IeePara
   read Get_Para;
   {* абзац, на который указывает метка }
 end;//IeeSub

 IeeSubList = interface(IeeBase)
  ['{8F526E93-54F7-4870-B526-49A1BCD5A044}']
  function Get_Count: Integer;
  function Get_Subs(anIndex: Integer): IeeSub;
  function Get_SubsByID(anID: Integer): IeeSub;
  function Add(anID: Integer = ee_SubAutoID;
   const aName: Il3CString = nil): IeeSub;
  property Count: Integer
   read Get_Count;
  property Subs[anIndex: Integer]: IeeSub
   read Get_Subs;
  property SubsByID[anID: Integer]: IeeSub
   read Get_SubsByID;
 end;//IeeSubList

 IeeBlock = interface(IeeSub)
  ['{9213003C-15E4-42AE-AEA4-A1DC9C3A15CA}']
  function Get_Document: IeeDocument;
  function Get_ParentBlock: IeeBlock;
  function IsKindOf(aType: Tk2Type): Boolean;
  property Document: IeeDocument
   read Get_Document;
  property ParentBlock: IeeBlock
   read Get_ParentBlock;
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
  ['{7CEC8F4B-E01D-42D9-BC8C-B6C98B0A820D}']
  function Get_Text: Il3CString;
  procedure Set_Text(const aValue: Il3CString);
  function Get_ID: Integer;
  procedure Set_ID(aValue: Integer);
  function Get_HasChild: Boolean;
  function Get_IsFirst: Boolean;
  function Get_IsLast: Boolean;
  function Get_ChildNode: IeeNode;
  function Get_ParentNode: IeeNode;
  function Get_NextNode: IeeNode;
  function Get_PrevNode: IeeNode;
  function Get_AllChildrenCount: Integer;
  function Get_ThisChildrenCount: Integer;
  function Iterate(anAction: TeeNodeAction;
   anIterMode: Integer = 0;
   const aFromNode: IeeNode = nil): IeeNode;
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
   {* перемещает указанного ребенка, руководству€сь критери€ми сортировки относительно других детей (в пределах одного уровн€) }
  procedure SortChilds;
  function GetLevelForParent(const aParent: IeeNode): Integer;
   {* –ассчитывает уровень текущей ноды относительно заданного Paretnt'а }
  function InsertChild(const aNode: IeeNode): IeeNode;
  function IterateF(anAction: TeeNodeAction;
   anIterMode: Integer = 0;
   const aFromNode: IeeNode = nil): IeeNode;
   {* перебрать все дочерние узлы и освободить заглушку дл€ Action }
  function IsSameNode(const aNode: IeeNode): Boolean;
  property Text: Il3CString
   read Get_Text
   write Set_Text;
  property ID: Integer
   read Get_ID
   write Set_ID;
  property HasChild: Boolean
   read Get_HasChild;
  property IsFirst: Boolean
   read Get_IsFirst;
  property IsLast: Boolean
   read Get_IsLast;
  property ChildNode: IeeNode
   read Get_ChildNode;
  property ParentNode: IeeNode
   read Get_ParentNode;
  property NextNode: IeeNode
   read Get_NextNode;
  property PrevNode: IeeNode
   read Get_PrevNode;
  property AllChildrenCount: Integer
   read Get_AllChildrenCount;
  property ThisChildrenCount: Integer
   read Get_ThisChildrenCount;
 end;//IeeNode

 IeeDocument = interface(IeeBase)
  ['{C907AEFF-93E2-44DF-84D9-C9C19505CF8B}']
  function Get_Block(anID: Integer): IeeBlock;
  function Get_BlockEx(anID: Integer;
   aLayerID: Integer): IeeBlock;
  function Get_Subs: IeeSubList;
  function Get_Markers: IeeSubList;
  function Get_Bookmarks: IeeSubList;
  function Get_Marks: IeeSubList;
  function Get_ExternalHandle: Integer;
  property Block[anID: Integer]: IeeBlock
   read Get_Block;
  property BlockEx[anID: Integer; aLayerID: Integer]: IeeBlock
   read Get_BlockEx;
  property Subs: IeeSubList
   read Get_Subs;
   {* список меток в документе (Sub'ы) }
  property Markers: IeeSubList
   read Get_Markers;
   {* список пользовательскиx меток в документе }
  property Bookmarks: IeeSubList
   read Get_Bookmarks;
   {* список пользовательскиx закладок в документе }
  property Marks: IeeSubList
   read Get_Marks;
  property ExternalHandle: Integer
   read Get_ExternalHandle;
   {* внешний идентификатор документа }
 end;//IeeDocument

 IeeTree = interface(IeeBase)
  ['{AFE22594-A88D-4A72-816C-91AAD1347145}']
  function Get_Root: IeeNode;
  procedure Set_Root(const aValue: IeeNode);
  function Get_SelectedCount: Integer;
  function Get_NodeFlags(const aNode: IeeNode): Integer;
  procedure Set_NodeFlags(const aNode: IeeNode;
   aValue: Integer);
  function Get_FlagsByAbsIndex(anAbsIndex: Integer): Integer;
  procedure Set_FlagsByAbsIndex(anAbsIndex: Integer;
   aValue: Integer);
  function TestFlagMask(aAbsIndex: LongInt;
   aFlagMask: Integer): Boolean;
  procedure SetFlagMask(aAbsIndex: LongInt;
   aFlagMask: Integer;
   aMode: TeeSetBitType); overload;
  procedure SetFlagMask(const aRNode: IeeNode;
   aFlagMask: Integer;
   aMode: TeeSetBitType); overload;
  procedure ExpandSubDir(const RNode: IeeNode = nil;
   Expand: Boolean = True;
   DeepLevel: Byte = 0);
   {* развернуть/свернуть узлы }
  function ChangeExpand(const RNode: IeeNode;
   Mode: TeeSetBitType;
   aForceMode: Boolean = False): Boolean;
  function IsChanging: Boolean;
   {* дерево находитс€ в фазе обновлени€ }
  procedure Changing;
  procedure Changed;
  function GetAbsIndex(const aNode: IeeNode): Integer; overload;
  function GetAbsIndex(anIndex: Integer): Integer; overload;
  function Iterate(Action: TeeNodeAction;
   IterMode: Integer = 0;
   const aSubRootNode: IeeNode = nil;
   const aFromNode: IeeNode = nil): IeeNode;
   {* перебрать все узлы. IterMode см. imExpandOnly etc. }
  function IterateF(Action: TeeNodeAction;
   IterMode: Integer = 0;
   const aSubRootNode: IeeNode = nil;
   const aFromNode: IeeNode = nil): IeeNode;
   {* перебрать все узлы и освободить заглушку дл€ Action }
  function GetNextSelected(const aCurNode: IeeNode): IeeNode;
  procedure ClearSelected;
  procedure SetAllFlags(aMode: TeeSetBitType;
   aFlags: Integer);
  function GetNode(anIndex: Integer): IeeNode;
  function GetNodeByAbsIndex(anAbsIndex: Integer): IeeNode;
  function Wake: Boolean;
  function IsExpanded(const aNode: IeeNode): Boolean;
  property Root: IeeNode
   read Get_Root
   write Set_Root;
  property SelectedCount: Integer
   read Get_SelectedCount;
  property NodeFlags[const aNode: IeeNode]: Integer
   read Get_NodeFlags
   write Set_NodeFlags;
  property FlagsByAbsIndex[anAbsIndex: Integer]: Integer
   read Get_FlagsByAbsIndex
   write Set_FlagsByAbsIndex;
 end;//IeeTree

 IeeHotSpot = interface(IeeBase)
  ['{5325BA64-95EF-4AB9-816F-4CA45522F6EB}']
  function Get_Para: IeePara;
  function Get_Hyperlink: IevHyperlink;
  function Get_InSelection: Boolean;
  function Get_Sub: IeeSub;
  property Para: IeePara
   read Get_Para;
  property Hyperlink: IevHyperlink
   read Get_Hyperlink;
  property InSelection: Boolean
   read Get_InSelection;
  property Sub: IeeSub
   read Get_Sub;
 end;//IeeHotSpot

 IeeTreeView = interface(IeeBase)
  {*  орневой интерфейс, представл€ющий доступ к контейнеру дерева }
  ['{665E6CFE-7A3C-45EE-AEDA-868F8D47DD77}']
  function Get_Tree: IeeTree;
  function Get_Current: Integer;
  procedure Set_Current(aValue: Integer);
  function Get_AbsCurrent: Integer;
  function Get_NodeFlags(const aNode: IeeNode): Integer;
  procedure Set_NodeFlags(const aNode: IeeNode;
   aValue: Integer);
  function Get_CurrentNode: IeeNode;
  function GetNode(anIndex: Integer): IeeNode;
  function GetNodeIndex(const aNode: IeeNode): Integer;
  function GetNodeAbsIndex(const aNode: IeeNode): Integer;
  procedure ExpandAll;
  procedure CollapseAll;
  function GoToNode(const aNode: IeeNode): LongInt;
  property Tree: IeeTree
   read Get_Tree;
  property Current: Integer
   read Get_Current
   write Set_Current;
  property AbsCurrent: Integer
   read Get_AbsCurrent;
  property NodeFlags[const aNode: IeeNode]: Integer
   read Get_NodeFlags
   write Set_NodeFlags;
  property CurrentNode: IeeNode
   read Get_CurrentNode;
 end;//IeeTreeView

 TeeScrollStyle = (
  {* “ип определ€ющий какие ScrollBar'ы нужны. }
  ee_ssNone
  , ee_ssHorizontal
  , ee_ssVertical
  , ee_ssBoth
 );//TeeScrollStyle

 TeeScrollCode = (
  {*  од событи€ от скроллера }
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
  {* ƒанные редактора }
  ['{3248992B-F2CF-45C5-A69B-BE2F0D3766CE}']
  function Get_Document: IeeDocument;
  property Document: IeeDocument
   read Get_Document;
 end;//IeeData

 IeePicture = interface(IeePara)
  ['{31F256EF-8A06-4440-B46C-254F58983A0A}']
  function Get_Name: Il3CString;
  procedure SaveToStream(const aStream: IStream);
  property Name: Il3CString
   read Get_Name;
 end;//IeePicture

 IeeCommands = interface(IeeBase)
  ['{3203A6BE-6BCE-41F6-9BEC-F0DA89C3D589}']
  procedure Cut;
  procedure Copy;
  procedure Delete;
  function Paste: Boolean;
  procedure SelectAll;
  procedure HideSelection;
 end;//IeeCommands

 IeeEditor = interface(IevF1LikeEditor)
  {*  орневой интерфейс, представл€ющий доступ к функци€м редактора }
  ['{30C8F152-1DA6-4B92-8A76-A4588838F823}']
  function Get_Commands: IeeCommands;
  function Get_Data: IeeData;
  function GetHotspotOnPoint(const aPt: TPoint;
   out theHotSpot: IeeHotSpot): Boolean;
  function CanSplitPara(const aPara: IeePara): Boolean;
  property Commands: IeeCommands
   read Get_Commands;
  property Data: IeeData
   read Get_Data;
 end;//IeeEditor

 IeeStyledLeafPara = interface(IeeLeafPara)
  ['{E0EF05C5-B464-4BA0-901A-A243F3083D7D}']
  function IsComment: Boolean; overload;
  function IsComment(aType: TeeCommentType): Boolean; overload;
 end;//IeeStyledLeafPara

 IeeTextPara = interface(IeeStyledLeafPara)
  ['{5BCD3B21-8ADA-4AA4-B79A-61AA3087F1F5}']
  function Get_Text: Il3CString;
  property Text: Il3CString
   read Get_Text;
 end;//IeeTextPara

 TeeScrollInfo = packed record
  rScrollInfo: TScrollInfo;
  rSmallChange: Integer;
  rLargeChange: Integer;
 end;//TeeScrollInfo

 IeeSubViewDescriptor = interface(IeeBase)
  {* ќписатель вида отображени€ сло€ меток }
  ['{C8D943E0-754E-45EA-9A8A-2B3993492251}']
  function Get_Visible: Boolean;
  procedure Set_Visible(aValue: Boolean);
  property Visible: Boolean
   read Get_Visible
   write Set_Visible;
 end;//IeeSubViewDescriptor

 IeeSubViewDescriptors = interface(IeeBase)
  ['{F6FA23AB-490C-46A3-8576-2D6A048360F6}']
  function Get_Subs: IeeSubViewDescriptor;
  function Get_Markers: IeeSubViewDescriptor;
  function Get_Bookmarks: IeeSubViewDescriptor;
  property Subs: IeeSubViewDescriptor
   read Get_Subs;
  property Markers: IeeSubViewDescriptor
   read Get_Markers;
  property Bookmarks: IeeSubViewDescriptor
   read Get_Bookmarks;
 end;//IeeSubViewDescriptors

 IeeSubPanel = interface(IeeBase)
  ['{64864378-1C17-45F6-B9B8-CDEE17D9431B}']
  function Get_SubViewDescriptors: IeeSubViewDescriptors;
  property SubViewDescriptors: IeeSubViewDescriptors
   read Get_SubViewDescriptors;
 end;//IeeSubPanel

implementation

uses
 l3ImplUses
;

end.
