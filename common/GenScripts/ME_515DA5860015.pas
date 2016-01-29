unit vtOutliner;

interface

uses
 l3IntfUses
 , l3TreeInterfaces
 , l3Except
 , l3Interfaces
 , Graphics
 , vtLister
 , l3Tree_TLB
 , l3ControlsTypes
 , l3LongintList
 , vtTreeSource
 , Classes
 , Messages
 , ImgList
 , Types
 , l3Base
 , l3InternalInterfaces
 , l3Units
;

type
 TvtTreeChangedEvent = procedure(aSender: TObject;
  const anOldTree: Il3SimpleTree;
  const aNewTree: Il3SimpleTree) of object;
 
 TvtSelectCountChanged = procedure(aSender: TObject;
  anOldCount: Integer;
  aNewCount: Integer) of object;
 
 TvtFocusedEvent = procedure(aSender: TObject;
  var aFocused: Boolean) of object;
 
 TvtEditOption = (
  eoItemHMoving
  , eoItemVMoving
  , eoItemDelete
  , eoItemExpand
 );//TvtEditOption
 
 TvtEditOptions = set of TvtEditOption;
 
 TOnExpandNode = procedure(Sender: TObject;
  const CNode: Il3SimpleNode) of object;
 
 ESkipOperation = class(El3Exception)
 end;//ESkipOperation
 
 TBeforeWake = procedure(Sender: TObject) of object;
 
 TAfterWake = procedure(Sender: TObject;
  aWakeResult: Boolean) of object;
 
 TNodeMoveEnd = procedure(Sender: TObject;
  const CNode: Il3SimpleNode;
  aParentWasChange: Boolean) of object;
 
 TGetItemStyleEvent = procedure(Sender: TObject;
  aItemIndex: Integer;
  const aFont: Il3Font;
  var aTextBackColor: TColor;
  var aItemBackColor: TColor;
  var aVJustify: TvtVJustify) of object;
  {* ������� ��� ��������� ����������� "����������" �������� }
 
 TGetItemImageVertOffsetEvent = procedure(Sender: TObject;
  aItemIndex: Integer;
  var theImageVertOffset: Integer) of object;
 
 TGetItemHeightEvent = function(Sender: TObject;
  aItemIndex: Integer;
  aHeight: Integer): Integer of object;
  {* ������� ��� ������� ������ �������� ������� }
 
 TGetItemIndentEvent = function(Sender: TObject): Integer of object;
  {* ������� ��������� ������� �������� }
 
 TvtOutlinerHystoryData = record
 end;//TvtOutlinerHystoryData
 
 TvtTreeModifiedData = record
  {* ���������� �� ���������� � ������ }
 end;//TvtTreeModifiedData
 
 TSetOfByte = set of Byte;
 
 TGetItemExtendExEvent = function(Sender: TObject;
  anItemIndex: Integer): Integer of object;
 
 TvtSimpleOutliner = class(TvtCustomLister, Il3SimpleTreeSource)
  function MakeTreeStruct: Il3SimpleTree;
  function Tree: Il3SimpleTree;
 end;//TvtSimpleOutliner
 
 TvtCustomOutliner = class(TvtSimpleOutliner, Il3ContextFilterTarget, Il3SelectCountChangedRecipient, Il3ExternalTreeChangedRecipient, Il3TreeSource, Il3ContextFilterNotifier, Il3ContextFilterNotifySource, Il3ContextFilterTargetContainer)
  {* ������� ����� ��������� ��� ����������� �������� }
  function DoOnGetItemImageIndex(aItemIndex: LongInt;
   var aImages: TCustomImageList): Integer;
  procedure DoOnGetItemStyle(aItemIndex: Integer;
   const aFont: Il3Font;
   var aTextBackColor: TColor;
   var aItemBackColor: TColor;
   var aVJustify: TvtVJustify;
   var aFocused: Boolean;
   var theImageVertOffset: Integer);
  procedure UpdateImagesOptions;
   {* ��������� ��������� voWithoutImages. }
  procedure ExternalSetTotal(aTotal: LongInt;
   aCurrent: LongInt;
   aTop: LongInt;
   aAnchor: LongInt);
  function GetDrawLevel(const CNode: Il3SimpleNode): Integer;
  procedure MakeTreeStructOnDraw;
   {* ���������� ����� ����������, ������ ��� �� ����� ������� ����� _TreeStruct �� �������, ���� ������� ��� ������. }
  function DoOnExpand(Expand: Boolean;
   const CNode: Il3SimpleNode): Boolean;
   {* ���� CNode = nil ������ ��������� �������� ��������\���������� ��� }
  procedure DoAfterFirstPaint;
  function GetHistoryData: TvtOutlinerHystoryData;
  procedure DoTreeChanged(const anOldTree: Il3SimpleTree;
   const aNewTree: Il3SimpleTree);
  procedure SetTreeStructFromHistory(const aTreeStruct: Il3SimpleTree;
   const aData: TvtOutlinerHystoryData);
  function Wake: Boolean;
  function GetNode(Index: LongInt): Il3SimpleNode;
  function GetCurrentNode: Il3SimpleNode;
  function CurrentCNode: Il3Node;
  procedure CheckParam;
  procedure ChangeSelect(Index: LongInt);
  function GetItemTextDim(aItemIndex: Integer): TPoint;
  function IsTreeAssign: Boolean;
  function TryExpandNode(const aExpNode: Il3SimpleNode;
   aExpand: Boolean;
   aRecalcTop: Boolean): Boolean;
  procedure ExpandNode(const aExpNode: Il3SimpleNode;
   aExpand: Boolean;
   aRecalcTop: Boolean);
  procedure ExpandNodeOnDeep(const aExpNode: Il3SimpleNode;
   aExpand: Boolean;
   aDeepLevel: Byte;
   aRecalcTop: Boolean);
  procedure ShowMoreChildrenOnScreen(const aParentNode: Il3SimpleNode);
  function SearchOccurStr(const SrchStr: AnsiString;
   FromCurrent: Boolean): LongInt;
  function GotoOnNode(const aNode: Il3SimpleNode): LongInt;
  function IterateF(Action: Tl3NodeAction;
   IterMode: Byte): Il3Node;
  procedure ReplaceTreeStructForceAsSame(const aTree: Il3SimpleTree);
  function CompileTabstopsFromMultipartText(const aMT: Il3MultipartText): Tl3String;
  procedure SubscribeTreeStruct(const aTreeStruct: Il3SimpleTree);
  procedure UnsubscribeTreeStruct(const aTreeStruct: Il3SimpleTree);
  function DoOnGetItemIndentEx(anItemIndex: Integer): Integer;
   {* ��� ������ ���� ����� ������ ���� "������������" ����� }
  function NeedDrawSelectionOnItem(aItemIndex: Integer): Boolean;
  function NeedDrawArrowSelection(aItemIndex: Integer): Boolean;
  function GetRealClientWidth: Integer;
  function NeedAssignTreeStructFromHistory: Boolean;
  procedure WMLButtonDown(var Msg: TWMLButtonDown);
  procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk);
  procedure SelectCountChanged(anOldCount: Integer;
   aNewCount: Integer);
   {* ������ ��������. }
  procedure ExternalVisibleCountChanged(aNewCount: Integer;
   aNodeIndex: Integer;
   aDelta: Integer);
   {* ������ ��������. }
  procedure ExternalInvalidate;
   {* �����������. }
  procedure ExternalModified(aNode: Integer;
   aDelta: Integer);
   {* � ������ ���� ���������/������� ��������.
             - aNode:
                 ���� ���� �������� ��������/������� ����. ��������� ����������
                 � ����;
             - aDelta:
                 ���������� ��������� ������� ���� ���������/�������. ����
                 aDelta �� ������ ����� �������� ���� �������; }
  function Tree: Il3Tree;
   {* ������, ��������������� ����������. }
  procedure RequestReapply;
   {* ���������� ������������� ������. }
  procedure RequestClearAndTurnOff;
   {* ������ ��������� �� ���� ������. }
  procedure RequestCheckValid;
   {* ������ ���������� - ����� ��������� ���������� �������. }
  procedure SubscribeToContextFilter(const aSubscriber: Il3ContextFilterNotifier);
  procedure UnSubscribeFromContextFilter(const aSubscriber: Il3ContextFilterNotifier);
  function IsSameContext(const aContext: Il3CString;
   out DiffStart: Cardinal): Boolean;
  function Unfold: Il3ContextFilterTarget;
  function MakeTreeStruct: Il3SimpleTree;
  function TreeStruct: Il3SimpleTree;
   {* ��������� ������ � ������� �������� ������ ��� ����������� }
 end;//TvtCustomOutliner
 
 TvtOutliner = class(TvtCustomOutliner)
 end;//TvtOutliner
 
implementation

uses
 l3ImplUses
 , OvcConst
 , vtStdRes
 , l3Tree
 , l3MinMax
 , l3String
 , l3Types
 , l3ScreenIC
 , l3TabStops
 , Windows
 , afwFacade
 , l3TreeUtils
 , l3Chars
 , l3Region
 , l3Bits
 , Forms
 , TtfwClassRef_Proxy
 , vtOutlinerWordsPack
;

end.
