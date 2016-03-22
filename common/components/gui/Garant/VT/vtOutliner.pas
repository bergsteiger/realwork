unit vtOutliner;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Модуль: "w:/common/components/gui/Garant/VT/vtOutliner.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT::Outliner::TvtOutliner
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  l3Interfaces,
  l3TreeInterfaces,
  Types,
  l3Tree_TLB,
  Messages,
  l3Base,
  l3Except,
  Classes,
  l3LongintList,
  l3ControlsTypes,
  Graphics
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  vtLister,
  vtTreeSource,
  l3InternalInterfaces,
  l3Units
  ;

type
 TvtTreeChangedEvent = procedure (aSender: TObject;
  const anOldTree: Il3SimpleTree;
  const aNewTree: Il3SimpleTree) of object;

 TvtSelectCountChanged = procedure (aSender: TObject;
  anOldCount: Integer;
  aNewCount: Integer) of object;

 TvtFocusedEvent = procedure (aSender: TObject;
  var aFocused: Boolean) of object;

const
  { TvtOutliner Const }
 vtItemWithoutImage = MaxLongint;
  { специальное значение, возвращаемое из fOnGetItemImage. Означает, что картинки нет. }
 vtItemWithHollowImage = MaxLongint - 1;

type
 TvtEditOption = (
   eoItemHMoving
 , eoItemVMoving
 , eoItemDelete
 , eoItemExpand
 );//TvtEditOption

 TvtEditOptions = set of TvtEditOption;

 TOnExpandNode = procedure (Sender: TObject;
  const CNode: Il3SimpleNode) of object;

 ESkipOperation = class(El3Exception)
 end;//ESkipOperation

 TBeforeWake = procedure (Sender: TObject) of object;

 TAfterWake = procedure (Sender: TObject;
  aWakeResult: Boolean) of object;

 TNodeMoveEnd = procedure (Sender: TObject;
  const CNode: Il3SimpleNode;
  aParentWasChange: Boolean) of object;

 TGetItemStyleEvent = procedure (Sender: TObject;
  aItemIndex: Integer;
  const aFont: Il3Font;
  var aTextBackColor: TColor;
  var aItemBackColor: TColor;
  var aVJustify: TvtVJustify) of object;

 TGetItemImageVertOffsetEvent = procedure (Sender: TObject;
  aItemIndex: Integer;
  var theImageVertOffset: Integer) of object;

 TGetItemHeightEvent = function (Sender: TObject;
  aItemIndex: Integer;
  aHeight: Integer): Integer of object;

 TGetItemIndentEvent = function (Sender: TObject): Integer of object;

 TvtOutlinerHystoryData = record
   rCurrent : Integer;
   rTop : Integer;
   rAnchor : Integer;
 end;//TvtOutlinerHystoryData

 TvtTreeModifiedData = record
  {* Информация об изменениях в дереве }
   rNode : LongInt; // узел ниже которого добавили/удалили узлы. Нумерация начинается с нуля.
   rDelta : LongInt; // количество элементов которое было добавлено/удалено. Если aDelta со знаком минус элементы были удалены.
 end;//TvtTreeModifiedData

 TSetOfByte = set of Byte;

 TGetItemExtendExEvent = function (Sender: TObject;
  anItemIndex: Integer): Integer of object;

 TvtSimpleOutliner = class(TvtCustomLister, Il3SimpleTreeSource)
 protected
 // property methods
   function pm_GetTreeStruct: Il3SimpleTree; virtual; abstract;
   procedure pm_SetTreeStruct(const aValue: Il3SimpleTree); virtual; abstract;
 protected
 // realized methods
   function Get_Tree: Il3SimpleTree;
   procedure Set_Tree(const aValue: Il3SimpleTree);
 protected
 // protected methods
   function MakeTreeStruct: Il3SimpleTree; virtual; abstract;
 public
 // public properties
   property TreeStruct: Il3SimpleTree
     read pm_GetTreeStruct
     write pm_SetTreeStruct;
     {* структура данных в которой хранится дерево для отображения }
 end;//TvtSimpleOutliner

 TvtCustomOutliner = class(TvtSimpleOutliner, Il3ContextFilterTarget, Il3SelectCountChangedRecipient, Il3ExternalTreeChangedRecipient, Il3TreeSource, Il3ContextFilterNotifier, Il3ContextFilterNotifySource, Il3ContextFilterTargetContainer)
  {* Базовый класс элементов для отображения деревьев }
 private
 // private fields
   f_NodeInMove : Il3SimpleNode;
   f_SaveCurrentNode : Il3SimpleNode;
   f_SaveRootNode : Il3SimpleNode;
   f_LegalOperations : TSetOfByte;
   f_DrawPointsCounted : Boolean;
   f_TreeModifiedData : TvtTreeModifiedData;
   f_IsFirstPaintWas : Boolean;
   f_Subscribers : Tl3LongintList;
   f_WaitingCountChanged : Boolean;
   f_TotalWhenCountedDrawPoints : LongInt;
   f_ViewOptions : TvtViewOptions;
    {* Поле для свойства ViewOptions}
   f_EditOptions : TvtEditOptions;
    {* Поле для свойства EditOptions}
   f_SelfDrawNodes : Boolean;
    {* Поле для свойства SelfDrawNodes}
   f_TreeSource : TvtCustomTreeSource;
    {* Поле для свойства TreeSource}
   f_OnSelectCountChanged : TvtSelectCountChanged;
    {* Поле для свойства OnSelectCountChanged}
   f_OnExpand : TOnExpandNode;
    {* Поле для свойства OnExpand}
   f_OnCollapse : TOnExpandNode;
    {* Поле для свойства OnCollapse}
   f_OnBeforeWake : TBeforeWake;
    {* Поле для свойства OnBeforeWake}
   f_OnAfterWake : TAfterWake;
    {* Поле для свойства OnAfterWake}
   f_OnGetItemImage : TGetItemImage;
    {* Поле для свойства OnGetItemImage}
   f_OnGetItemStyle : TGetItemStyleEvent;
    {* Поле для свойства OnGetItemStyle}
   f_OnGetItemImageVertOffset : TGetItemImageVertOffsetEvent;
    {* Поле для свойства OnGetItemImageVertOffset}
   f_OnGetItemHeight : TGetItemHeightEvent;
    {* Поле для свойства OnGetItemHeight}
   f_OnGetItemIndent : TGetItemIndentEvent;
    {* Поле для свойства OnGetItemIndent}
   f_OnNodeMoveEnd : TNodeMoveEnd;
    {* Поле для свойства OnNodeMoveEnd}
   f_OnTreeChanged : TvtTreeChangedEvent;
    {* Поле для свойства OnTreeChanged}
   f_OnAfterFirstPaint : TNotifyEvent;
    {* Поле для свойства OnAfterFirstPaint}
   f_OnCheckFocusedInPaint : TvtFocusedEvent;
    {* Поле для свойства OnCheckFocusedInPaint}
   f_LineColor : TColor;
    {* Поле для свойства LineColor}
   f_OpenChipColor : TColor;
    {* Поле для свойства OpenChipColor}
   f_OpenChipBorderColor : TColor;
    {* Поле для свойства OpenChipBorderColor}
   f_OnGetItemIndentEx : TGetItemExtendExEvent;
    {* Поле для свойства OnGetItemIndentEx}
 private
 // private methods
   procedure UpdateImagesOptions;
     {* проверяет настройку voWithoutImages. }
   function CompileTabstopsFromMultipartText(const aMT: Il3MultipartText): Tl3String;
   procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
   procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
 protected
 // property methods
   procedure pm_SetViewOptions(aValue: TvtViewOptions);
   procedure pm_SetEditOptions(aValue: TvtEditOptions);
   procedure pm_SetSelfDrawNodes(aValue: Boolean);
   procedure pm_SetTreeSource(aValue: TvtCustomTreeSource);
   function pm_GetCTree: Il3Tree;
   function pm_GetShowRoot: Boolean;
   procedure pm_SetShowRoot(aValue: Boolean);
   function pm_GetShowOpenChip: Boolean;
   procedure pm_SetShowOpenChip(aValue: Boolean);
   function pm_GetShowExpandable: Boolean;
   procedure pm_SetShowExpandable(aValue: Boolean);
   function pm_GetIsShowLines: Boolean;
   procedure pm_SetIsShowLines(aValue: Boolean);
   function pm_GetFullLineSelect: Boolean;
   procedure pm_SetFullLineSelect(aValue: Boolean);
 protected
 // realized methods
   procedure SelectCountChanged(anOldCount: Integer;
   aNewCount: Integer);
     {* прошла операция. }
   procedure ExternalVisibleCountChanged(aNewCount: Integer;
   aNodeIndex: Integer;
   aDelta: Integer);
     {* прошла операция. }
   procedure ExternalInvalidate;
     {* перерисуйся. }
   procedure ExternalModified(aNode: Integer;
   aDelta: Integer);
     {* в дереве были добавлены/удалены элементы.
             - aNode:
                 Узел ниже которого добавили/удалили узлы. Нумерация начинается
                 с нуля;
             - aDelta:
                 Количество элементов которое было добавлено/удалено. Если
                 aDelta со знаком минус элементы были удалены; }
   function Get_Tree: Il3Tree;
   procedure Set_Tree(const aValue: Il3Tree);
   procedure RequestReapply;
     {* Желательно переприменить фильтр. }
   procedure RequestClearAndTurnOff;
     {* Дерево выключило на себе фильтр. }
   procedure RequestCheckValid;
     {* Дерево поменялось - нужно проверить валидность фильтра. }
   procedure SubscribeToContextFilter(const aSubscriber: Il3ContextFilterNotifier);
   procedure UnSubscribeFromContextFilter(const aSubscriber: Il3ContextFilterNotifier);
   function IsSameContext(const aContext: Il3CString;
   out DiffStart: Cardinal): Boolean;
   function Unfold: Il3ContextFilterTarget;
   function MakeTreeStruct: Il3SimpleTree; override;
   function pm_GetTreeStruct: Il3SimpleTree; override;
   procedure pm_SetTreeStruct(const aValue: Il3SimpleTree); override;
 protected
 // overridden property methods
   function pm_GetImages: TCustomImageList; override;
   procedure pm_SetImages(aValue: TCustomImageList); override;
   function pm_GetSelectedCount: Integer; override;
   procedure pm_SetTotal(aValue: LongInt); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function MouseAction(const aPt: Tl3Point;
   aButton: Tl3MouseButton;
   anAction: Tl3MouseAction;
   aKeys: TShiftState): Tl3MouseResult; override;
   procedure DoChanging; override;
   procedure DoChanged; override;
   procedure Paint(const CN: Il3Canvas); override;
     {* процедура рисования внешнего вида управляющего элемента }
   procedure Notification(AComponent: TComponent;
    Operation: TOperation); override;
   function IsNeedScrollBars: Boolean; override;
     {* определяет нужены ли в CreateParams стили WS_VSCROLL WS_HSCROLL. }
   function IsHintNeededForAnElement(anIndex: Integer): Boolean; override;
   function DoOnGetItemIndent: Integer; override;
     {* функция определяет добавляемое свободное место до иконки элемента.
Если отступ в обработчике будет определен как нулевой, то по
умолчанию отступ делается на ширину иконки, если таковые имеются. }
   function ItemOnScreen(OnlyWhole: Boolean): Integer; override;
   procedure MakeDrawPoints(aDrawPoints: Tl3LongintList); override;
   function CalcTopIndex(aMaxVisItem: LongInt): LongInt; override;
   function NeedInitScrollInfoInvlbInitScrollInfo: Boolean; override;
   procedure VlbDrawFocusRect(const CN: Il3Canvas;
     Index: LongInt); override;
     {* draw the focus rectangle }
   function VlbItemHitTest(aIndex: Integer;
     const aPt: TPoint;
     fromScreen: Boolean = False): Byte; override;
   function DoOnGetItem(Index: LongInt): Il3CString; override;
   function DoOnGetItemPickImage(aItemIndex: LongInt;
     var aImages: TCustomImageList): Integer; override;
   procedure DoOnGetItemFont(Index: LongInt;
     const aFont: Il3Font;
     anItemPart: TvtListerItemPart); override;
   function DoOnIsSelected(Index: LongInt): Integer; override;
   procedure DoOnSelect(Index: LongInt;
     aValue: Integer); override;
   procedure DoOnSelectOutRange(First: LongInt;
     Last: LongInt;
     aSelectState: Integer); override;
   function DoDoProcessCommand(Cmd: Tl3OperationCode): Boolean; override;
   procedure DoCountChanged(aCount: LongInt); override;
   function GetHint(anIndex: Integer): Il3CString; override;
   function UseDrawPoints: Boolean; override;
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
   function GetImagesStored: Boolean; override;
   procedure InvalidateItem(Index: LongInt); override;
   function GetItemTextIndent(Index: LongInt;
     aTextBoxHeight: Integer): Integer; override;
   function GetItemDim(aItemIndex: Integer): TPoint; override;
 protected
 // protected fields
   f_ChangingForHistory : Boolean;
   f_TreeStruct : Il3SimpleTree;
 protected
 // protected methods
   function DoOnGetItemImageIndex(aItemIndex: LongInt;
     var aImages: TCustomImageList): Integer; virtual;
   procedure DoOnGetItemStyle(aItemIndex: Integer;
     const aFont: Il3Font;
     var aTextBackColor: TColor;
     var aItemBackColor: TColor;
     var aVJustify: TvtVJustify;
     var aFocused: Boolean;
     var theImageVertOffset: Integer); virtual;
   procedure ExternalSetTotal(aTotal: LongInt;
     aCurrent: LongInt = -1;
     aTop: LongInt = -1;
     aAnchor: LongInt = -1);
   function GetDrawLevel(const CNode: Il3SimpleNode): Integer;
   procedure MakeTreeStructOnDraw; virtual;
     {* вызывается перед отрисовкой, бывает что до этого момента никто _TreeStruct не спросил, хотя сделать его готовы. }
   function DoOnExpand(Expand: Boolean;
     const CNode: Il3SimpleNode): Boolean; virtual;
     {* если CNode = nil значит выполнили операцию свернуть\развернуть все }
   procedure DoAfterFirstPaint;
     {* Сигнатура метода DoAfterFirstPaint }
   function GetHistoryData: TvtOutlinerHystoryData;
   procedure DoTreeChanged(const anOldTree: Il3SimpleTree;
     const aNewTree: Il3SimpleTree); virtual;
   procedure SetTreeStructFromHistory(const aTreeStruct: Il3SimpleTree;
     const aData: TvtOutlinerHystoryData); virtual;
   procedure SubscribeTreeStruct(const aTreeStruct: Il3SimpleTree); virtual;
   procedure UnsubscribeTreeStruct(const aTreeStruct: Il3SimpleTree); virtual;
   function DoOnGetItemIndentEx(anItemIndex: Integer): Integer; virtual;
     {* для каждой ноды можно задать свой "персональный" сдвиг }
   function NeedDrawSelectionOnItem(aItemIndex: Integer): Boolean; virtual;
   function NeedDrawArrowSelection(aItemIndex: Integer): Boolean; virtual;
   function GetRealClientWidth: Integer; virtual;
   function NeedAssignTreeStructFromHistory: Boolean; virtual;
 public
 // public methods
   function Wake: Boolean;
   function GetNode(Index: LongInt): Il3SimpleNode;
   function GetCurrentNode: Il3SimpleNode;
   function CurrentCNode: Il3Node;
   procedure CheckParam;
     {* Сигнатура метода CheckParam }
   procedure ChangeSelect(Index: LongInt);
   function GetItemTextDim(aItemIndex: Integer): TPoint;
   function IsTreeAssign: Boolean;
   function TryExpandNode(const aExpNode: Il3SimpleNode;
     aExpand: Boolean;
     aRecalcTop: Boolean = False): Boolean;
   procedure ExpandNode(const aExpNode: Il3SimpleNode;
     aExpand: Boolean;
     aRecalcTop: Boolean = False);
   procedure ExpandNodeOnDeep(const aExpNode: Il3SimpleNode = nil;
     aExpand: Boolean = True;
     aDeepLevel: Byte = 0;
     aRecalcTop: Boolean = False);
   procedure ShowMoreChildrenOnScreen(const aParentNode: Il3SimpleNode);
   function SearchOccurStr(const SrchStr: AnsiString;
     FromCurrent: Boolean): LongInt;
   function GotoOnNode(const aNode: Il3SimpleNode): LongInt;
   function IterateF(Action: Tl3NodeAction;
     IterMode: Byte): Il3Node;
   procedure ReplaceTreeStructForceAsSame(const aTree: Il3SimpleTree);
 public
 // public properties
   property ViewOptions: TvtViewOptions
     read f_ViewOptions
     write pm_SetViewOptions;
   property EditOptions: TvtEditOptions
     read f_EditOptions
     write pm_SetEditOptions;
   property SelfDrawNodes: Boolean
     read f_SelfDrawNodes
     write pm_SetSelfDrawNodes;
   property TreeSource: TvtCustomTreeSource
     read f_TreeSource
     write pm_SetTreeSource;
   property CTree: Il3Tree
     read pm_GetCTree;
   property ShowRoot: Boolean
     read pm_GetShowRoot
     write pm_SetShowRoot;
   property ShowOpenChip: Boolean
     read pm_GetShowOpenChip
     write pm_SetShowOpenChip;
   property ShowExpandable: Boolean
     read pm_GetShowExpandable
     write pm_SetShowExpandable;
   property IsShowLines: Boolean
     read pm_GetIsShowLines
     write pm_SetIsShowLines;
   property OnSelectCountChanged: TvtSelectCountChanged
     read f_OnSelectCountChanged
     write f_OnSelectCountChanged;
   property OnExpand: TOnExpandNode
     read f_OnExpand
     write f_OnExpand;
   property OnCollapse: TOnExpandNode
     read f_OnCollapse
     write f_OnCollapse;
   property OnBeforeWake: TBeforeWake
     read f_OnBeforeWake
     write f_OnBeforeWake;
   property OnAfterWake: TAfterWake
     read f_OnAfterWake
     write f_OnAfterWake;
   property OnGetItemImage: TGetItemImage
     read f_OnGetItemImage
     write f_OnGetItemImage;
   property OnGetItemStyle: TGetItemStyleEvent
     read f_OnGetItemStyle
     write f_OnGetItemStyle;
   property OnGetItemImageVertOffset: TGetItemImageVertOffsetEvent
     read f_OnGetItemImageVertOffset
     write f_OnGetItemImageVertOffset;
   property OnGetItemHeight: TGetItemHeightEvent
     read f_OnGetItemHeight
     write f_OnGetItemHeight;
   property OnGetItemIndent: TGetItemIndentEvent
     read f_OnGetItemIndent
     write f_OnGetItemIndent;
   property OnNodeMoveEnd: TNodeMoveEnd
     read f_OnNodeMoveEnd
     write f_OnNodeMoveEnd;
   property OnTreeChanged: TvtTreeChangedEvent
     read f_OnTreeChanged
     write f_OnTreeChanged;
   property OnAfterFirstPaint: TNotifyEvent
     read f_OnAfterFirstPaint
     write f_OnAfterFirstPaint;
   property OnCheckFocusedInPaint: TvtFocusedEvent
     read f_OnCheckFocusedInPaint
     write f_OnCheckFocusedInPaint;
   property LineColor: TColor
     read f_LineColor
     write f_LineColor;
     {* default clGray }
   property OpenChipColor: TColor
     read f_OpenChipColor
     write f_OpenChipColor;
     {* default clBlack }
   property OpenChipBorderColor: TColor
     read f_OpenChipBorderColor
     write f_OpenChipBorderColor;
     {* default clGray }
   property OnGetItemIndentEx: TGetItemExtendExEvent
     read f_OnGetItemIndentEx
     write f_OnGetItemIndentEx;
     {* для каждой ноды можно задать свой "персональный" сдвиг }
   property FullLineSelect: Boolean
     read pm_GetFullLineSelect
     write pm_SetFullLineSelect;
     {* default False }
 end;//TvtCustomOutliner

//#UC START# *515DA5860015ci*
//#UC END# *515DA5860015ci*
//#UC START# *515DA5860015cit*
//#UC END# *515DA5860015cit*
 TvtOutliner = class(TvtCustomOutliner)
//#UC START# *515DA5860015publ*
 public
  property TreeStruct;
 published
  property TreeSource;
  property Images;
  property AutoRowHeight;
  property BorderStyle;
  property Columns;
  property Header;
  property IntegralHeight;
  property MultiSelect;
  property MultiStrokeItem;
  property LineColor default clGray;
  property OpenChipColor default clGray;
  property OpenChipBorderColor default clGray;
  property ProtectColor;
  property RowHeight;
  property ScrollStyle;
  property SelectColor;
  property SelectNonFocusColor;
  property SelfDrawNodes;
  property ShowHeader;
  property UseTabStops;
  property PickedList;
  property ReadOnly;
  property ShowRoot;

  property OnCharToItem;
  property OnGetItemImage;
  property OnGetItemStyle;
  property OnGetItemHeight;

  property OnNodeMoveEnd;
  property OnGetItemColor;
  property OnGetItemFont;
  property OnGetItemCursor;
     
  property OnGetItemStatus;
  property OnIsSelected;
  property OnSelect;
  property OnSelectChange;
  property OnSelectChanged;
  property OnSelectCountChanged;
  property OnTopIndexChanged;
  property OnCurrentChanged;
  property OnValidateCurrent;
  property OnCountChanged;
  property OnUserCommand;
  property OnIsCommandProcessed;

  property OnExpand;
  property OnCollapse;
  property OnContextPopup;

  property OnBeforeWake;
  property OnAfterWake;
  property OnCheckFocusedInPaint;

  {inherited properties}
  property Align;
  property Color;
  property Controller;
  property Ctl3D;
  property DragCursor;
  property DragMode;
  property Enabled;
  property Font;
  property ParentColor;
  property ParentCtl3D;
  property ParentFont;
  property ParentShowHint;
  property PopupMenu;
  property ShowHint;
  property TabOrder;
  property TabStop;
  property Visible;
  property Anchors;
  property Constraints;
  property VJustify;

  {inherited events}
  property OnClick;
  property OnDblClick;
  property OnDragDrop;
  property OnDragOver;
  property OnEndDrag;
  property OnEnter;
  property OnExit;
  property OnKeyDown;
  property OnKeyPress;
  property OnKeyUp;
  property OnMouseDown;
  property OnMouseMove;
  property OnMouseUp;
  property OnActionElement;

  property IsShowLines;
  property ShowExpandable;
  property ShowOpenChip;
  property ViewOptions;
  property EditOptions;

  property OnResize;
//#UC END# *515DA5860015publ*
 end;//TvtOutliner

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  vtOutlinerWordsPack
  {$IfEnd} //not NoScripts
  ,
  OvcConst,
  vtStdRes,
  l3Tree,
  l3MinMax,
  l3String,
  l3Types,
  l3ScreenIC,
  l3TabStops,
  Windows,
  afwFacade,
  l3TreeUtils,
  l3Chars,
  l3Region,
  l3Bits
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;

const
   { TvtOutliner Const private }
  cAllOutlinerCommand = [ccTreeExpand, ccTreeAllExpand, ccMoveLeft, ccMoveRight, ccMoveUp, ccMoveDown, ccLeft, ccRight, ccFastFindNext, ccDel, ccTreeCollapse];
  cOutlinerHMovingCommand = [ccMoveLeft, ccMoveRight];
  cOutlinerVMovingCommand = [ccMoveUp, ccMoveDown];
  cOutlinerMovingCommand = cOutlinerHMovingCommand + cOutlinerVMovingCommand;
  cOutlinerDeleteCommand = [ccDel];

// start class TvtCustomOutliner

procedure TvtCustomOutliner.UpdateImagesOptions;
//#UC START# *515DC5090272_4CFFBEEA0109_var*
//#UC END# *515DC5090272_4CFFBEEA0109_var*
begin
//#UC START# *515DC5090272_4CFFBEEA0109_impl*
 if voWithoutImages in ViewOptions then
  Images := nil;
//#UC END# *515DC5090272_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.UpdateImagesOptions

function TvtCustomOutliner.CompileTabstopsFromMultipartText(const aMT: Il3MultipartText): Tl3String;
//#UC START# *51631EF60074_4CFFBEEA0109_var*
var
 I: Integer;
//#UC END# *51631EF60074_4CFFBEEA0109_var*
begin
//#UC START# *51631EF60074_4CFFBEEA0109_impl*
 Result := Tl3String.Create;
 for I := 0 to Pred(Header.Sections.Count) do
 begin
  Result.Append(aMT.GetTextPart(I));
  Result.Append(cc_Tab);
 end;//for I
 Result.Len := Result.Len-1;
//#UC END# *51631EF60074_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.CompileTabstopsFromMultipartText

function TvtCustomOutliner.DoOnGetItemImageIndex(aItemIndex: LongInt;
  var aImages: TCustomImageList): Integer;
//#UC START# *508F81110075_4CFFBEEA0109_var*
var
 CNode : Il3SimpleNode;
//#UC END# *508F81110075_4CFFBEEA0109_var*
begin
//#UC START# *508F81110075_4CFFBEEA0109_impl*
 Result := vtItemWithoutImage;
 aImages := pm_GetImages;

 CNode := GetNode(aItemIndex);
 if CNode = nil then
  Exit;

 if Assigned(f_OnGetItemImage) then
  Result := f_OnGetItemImage(Self, aItemIndex, aImages);

 if Result < 0 then
 begin
  aImages := vtResources.Images;
  if CNode.MaybeChild then
   if ShowExpandable then
    if f_TreeStruct.IsExpanded(CNode) then
     Result := vt_imgOtlOpen
    else
     Result := vt_imgOtlPlus
   else
    Result := vt_imgOtlClose
  else
   if f_TreeStruct.IsRoot(CNode)  then
    Result := vt_imgOtlClose
   else
    Result := vt_imgOtlLeaf;
 end;
//#UC END# *508F81110075_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoOnGetItemImageIndex

procedure TvtCustomOutliner.DoOnGetItemStyle(aItemIndex: Integer;
  const aFont: Il3Font;
  var aTextBackColor: TColor;
  var aItemBackColor: TColor;
  var aVJustify: TvtVJustify;
  var aFocused: Boolean;
  var theImageVertOffset: Integer);
//#UC START# *508F825303E4_4CFFBEEA0109_var*
var
 lFGColor : TColor;
 lCanChangeBackColor : Boolean;
//#UC END# *508F825303E4_4CFFBEEA0109_var*
begin
//#UC START# *508F825303E4_4CFFBEEA0109_impl*
 theImageVertOffset := 0;
 lCanChangeBackColor := False;
 {get colors}
 if DoOnGetItemStatus(aItemIndex) then
 begin
  aItemBackColor := ProtectColor.BackColor;
  lFGColor := ProtectColor.TextColor;
 end//DoOnGetItemStatus(aItemIndex)
 else
 begin
  aFocused := False;
  if ((aItemIndex = Current) and (not MultiSelect or PickedList)) or
     (Selected[aItemIndex] and not PickedList) then
  begin
   aFocused := Focused;
   if Assigned(f_OnCheckFocusedInPaint) then
    f_OnCheckFocusedInPaint(Self, aFocused);
   if aFocused and not (f_SelfDrawNodes and Supports(GetNode(aItemIndex), Il3NodePainter)) then
   begin
    aItemBackColor := SelectColor.BackColor;
    lFGColor := SelectColor.TextColor;
   end//aFocused and not (f_SelfDrawNodes and Supports(GetNode(aItemIndex), Il3NodePainter))
   else
   begin
    if aFocused then
     aItemBackColor := SelectColor.BackColor
    else
     aItemBackColor := SelectNonFocusColor.BackColor;
    lFGColor := SelectNonFocusColor.TextColor;
   end;//aFocused and not (f_SelfDrawNodes and Supports(GetNode(aItemIndex), Il3NodePainter))
  end//aItemIndex = f_Current..
  else
  begin
   aItemBackColor := Color;
   lFGColor := Font.Color;
   lCanChangeBackColor := True;
   DoOnGetItemColor(aItemIndex, lFGColor, aItemBackColor);
   aFont.BackColor := aItemBackColor;
  end; //aItemIndex = f_Current
 end;//DoOnGetItemStatus(aItemIndex)

 {assign colors to our canvas}
 aFont.ForeColor := lFGColor;
 aTextBackColor := aItemBackColor;

 inherited DoOnGetItemFont(aItemIndex, aFont, vt_lipText);
 if lCanChangeBackColor then
  aTextBackColor := aFont.BackColor;

 if Assigned(f_OnGetItemStyle) then
  f_OnGetItemStyle(Self, aItemIndex, aFont, aTextBackColor, aItemBackColor, aVJustify);
 if Assigned(f_OnGetItemImageVertOffset) then
  f_OnGetItemImageVertOffset(Self, aItemIndex, theImageVertOffset);
//#UC END# *508F825303E4_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoOnGetItemStyle

procedure TvtCustomOutliner.ExternalSetTotal(aTotal: LongInt;
  aCurrent: LongInt = -1;
  aTop: LongInt = -1;
  aAnchor: LongInt = -1);
//#UC START# *516299360286_4CFFBEEA0109_var*
//#UC END# *516299360286_4CFFBEEA0109_var*
begin
//#UC START# *516299360286_4CFFBEEA0109_impl*
 if aTotal <> Total then
 begin
  if aTotal < 0 then
   aTotal := High(aTotal);

  InternalSetTotal(aTotal);

  if Total = 0 then
   SearchStr := '';

  {reset high index}
  if Total = 0 then
   f_HighIndex := 0
  else
   f_HighIndex := Pred(Total);

  {reset horizontal offset}
  f_HDelta := 0;

  // {Тучнин Д.А.} Раньше текущий корректировался только вне скобок Changing/Changed -
  // "if not IsInChange and (aCurrent >= 0) then ...". Это работало неправильно.
  // В частности при операции "развернуть все". Пусть корректировка идет всегда,
  // кажется это более верный вариант.
  if (aCurrent >= 0) then
   InternalSetCurrent(aCurrent);

  if (aAnchor >= 0) then
   f_Anchor := aAnchor;

  if not ((csLoading in ComponentState) or
     (csDestroying in ComponentState)) and
     (aTop >= 0) then
   InternalSetTopIndex(aTop);

  DoCountChanged(Total);
 end;//if aTotal <> FTotal then
//#UC END# *516299360286_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.ExternalSetTotal

function TvtCustomOutliner.GetDrawLevel(const CNode: Il3SimpleNode): Integer;
//#UC START# *51629A30033B_4CFFBEEA0109_var*
//#UC END# *51629A30033B_4CFFBEEA0109_var*
begin
//#UC START# *51629A30033B_4CFFBEEA0109_impl*
  Result := TreeStruct.GetLevel(CNode);
  if ([voShowRoot, voShowOpenChip { voShowLines}] * f_ViewOptions = []) then
  //if not ((voShowRoot in f_ViewOptions) or
  //        ((voShowOpenChip in f_ViewOptions) and (voShowLines in f_ViewOptions))) then
   Dec(Result);
//#UC END# *51629A30033B_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.GetDrawLevel

procedure TvtCustomOutliner.MakeTreeStructOnDraw;
//#UC START# *51629A880103_4CFFBEEA0109_var*
//#UC END# *51629A880103_4CFFBEEA0109_var*
begin
//#UC START# *51629A880103_4CFFBEEA0109_impl*
 // вроде пусто
//#UC END# *51629A880103_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.MakeTreeStructOnDraw

function TvtCustomOutliner.DoOnExpand(Expand: Boolean;
  const CNode: Il3SimpleNode): Boolean;
//#UC START# *51629C9B00C2_4CFFBEEA0109_var*
 function lp_ExpandSingleNode: Boolean;
 var
  SB : Tl3SetBitType;
 begin
  if Expand then
   SB := sbSelect
  else
   SB := sbDeselect;
  Result := TreeStruct.ChangeExpand(CNode, SB);
  if Result then
   Total := TreeStruct.CountView;
 end;//lp_ExpandSingleNode

 procedure lp_DoExpand;
 begin
  if Assigned(f_OnExpand) then
   f_OnExpand(Self,CNode);
 end;//lp_DoExpand

 procedure lp_DoCollapse;
 begin
  if Assigned(f_OnCollapse) then
   f_OnCollapse(Self,CNode);
 end;//lp_DoCollapse
//#UC END# *51629C9B00C2_4CFFBEEA0109_var*
begin
//#UC START# *51629C9B00C2_4CFFBEEA0109_impl*
 if CNode = nil then
  Result := True
 else
  Result := lp_ExpandSingleNode;
 if Expand then
  lp_DoExpand
 else
  lp_DoCollapse;
//#UC END# *51629C9B00C2_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoOnExpand

procedure TvtCustomOutliner.DoAfterFirstPaint;
//#UC START# *51629CD1023F_4CFFBEEA0109_var*
//#UC END# *51629CD1023F_4CFFBEEA0109_var*
begin
//#UC START# *51629CD1023F_4CFFBEEA0109_impl*
 if (f_LastPageSize <> Max(ItemOnScreen(True), 1)) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=248195850
  vlbSetVScrollRange;
 if Assigned(f_OnAfterFirstPaint) then
  f_OnAfterFirstPaint(Self);
//#UC END# *51629CD1023F_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoAfterFirstPaint

function TvtCustomOutliner.GetHistoryData: TvtOutlinerHystoryData;
//#UC START# *51629D2B012D_4CFFBEEA0109_var*
//#UC END# *51629D2B012D_4CFFBEEA0109_var*
begin
//#UC START# *51629D2B012D_4CFFBEEA0109_impl*
 Result.rCurrent := Current;
 Result.rTop := TopIndex;
 Result.rAnchor := f_Anchor;
//#UC END# *51629D2B012D_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.GetHistoryData

procedure TvtCustomOutliner.DoTreeChanged(const anOldTree: Il3SimpleTree;
  const aNewTree: Il3SimpleTree);
//#UC START# *51629D5D018A_4CFFBEEA0109_var*
//#UC END# *51629D5D018A_4CFFBEEA0109_var*
begin
//#UC START# *51629D5D018A_4CFFBEEA0109_impl*
 f_IsFirstPaintWas := False;
 if Assigned(f_OnTreeChanged) then
  f_OnTreeChanged(Self, anOldTree, aNewTree);
 if not f_ChangingForHistory then
  RequestCheckValid;
//#UC END# *51629D5D018A_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoTreeChanged

procedure TvtCustomOutliner.SetTreeStructFromHistory(const aTreeStruct: Il3SimpleTree;
  const aData: TvtOutlinerHystoryData);
//#UC START# *51629D8E02C8_4CFFBEEA0109_var*
var
 l_OldTree : Il3SimpleTree;
 l_NeedSetCurrent: Boolean;
//#UC END# *51629D8E02C8_4CFFBEEA0109_var*
begin
//#UC START# *51629D8E02C8_4CFFBEEA0109_impl*
 if (f_TreeStruct = aTreeStruct) then
  Exit;

 l_NeedSetCurrent := NeedAssignTreeStructFromHistory;

 l_OldTree := f_TreeStruct;
 f_ChangingForHistory := True;
 try

   if l_NeedSetCurrent and (f_TreeStruct <> nil) then
   begin
    UnsubscribeTreeStruct(f_TreeStruct);
    f_TreeStruct := nil;
   end;//f_TreeStruct <> nil

   if (csDestroying in ComponentState) then
    Exit;

   if Assigned(aTreeStruct) then
   begin
    if l_NeedSetCurrent then
    begin
     f_TreeStruct := aTreeStruct;
     SubscribeTreeStruct(f_TreeStruct);
     f_TreeStruct.ShowRoot := (voShowRoot in f_ViewOptions);
    end; 
    InternalSetTotal(TreeStruct.CountView);
    TreeStruct.CursorTop;
    if AlignTopIndex then DropDrawPoints;
   end//Assigned(aTreeStruct)
   else
    InternalSetTotal(0);

   if (Total = 0) then
    f_HighIndex := 0
   else
    f_HighIndex := Pred(Total);

  InternalSetCurrent(aData.rCurrent);

  f_Anchor := aData.rAnchor;
  TopIndex := aData.rTop;

  vlbInitScrollInfo;

  DoTreeChanged(l_OldTree, f_TreeStruct);

  Invalidate;
 finally
  l_OldTree := nil;
  f_ChangingForHistory := False;
 end;//try..finally 
//#UC END# *51629D8E02C8_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.SetTreeStructFromHistory

function TvtCustomOutliner.Wake: Boolean;
//#UC START# *51629DB903CA_4CFFBEEA0109_var*
//#UC END# *51629DB903CA_4CFFBEEA0109_var*
begin
//#UC START# *51629DB903CA_4CFFBEEA0109_impl*
 if (f_TreeStruct = nil) then
  Result := False
 else
 begin
  if Assigned(f_OnBeforeWake) then
   f_OnBeforeWake(self);

  Result := f_TreeStruct.Wake;
  if Result then
  begin
   Total := f_TreeStruct.CountView;
   if (Total = 0) then
    f_HighIndex := 0
   else
    f_HighIndex := Pred(Total);
   if (Current = 0) then
    InternalSetCurrent(-1);
   if (Current < 0) then
   begin
    if Total > 0 then
    {f}Current := 0;
    //Selected[f_Current] := true;
   end;//f_Current < 0
  end;//Result

  if Assigned(f_OnAfterWake) then
   f_OnAfterWake(self, Result);
 end;//f_TreeStruct = nil
//#UC END# *51629DB903CA_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.Wake

function TvtCustomOutliner.GetNode(Index: LongInt): Il3SimpleNode;
//#UC START# *51629E7001AA_4CFFBEEA0109_var*
//#UC END# *51629E7001AA_4CFFBEEA0109_var*
begin
//#UC START# *51629E7001AA_4CFFBEEA0109_impl*
 if Assigned(f_TreeStruct) then
  Result := f_TreeStruct.Nodes[Index]
 else
  Result := nil;
//#UC END# *51629E7001AA_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.GetNode

function TvtCustomOutliner.GetCurrentNode: Il3SimpleNode;
//#UC START# *51629E91017B_4CFFBEEA0109_var*
//#UC END# *51629E91017B_4CFFBEEA0109_var*
begin
//#UC START# *51629E91017B_4CFFBEEA0109_impl*
 if (Total <= 0) or (Current < 0) then
  Result := nil
 else
  Result := TreeStruct.Nodes[Current];
//#UC END# *51629E91017B_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.GetCurrentNode

function TvtCustomOutliner.CurrentCNode: Il3Node;
//#UC START# *51629EB60323_4CFFBEEA0109_var*
//#UC END# *51629EB60323_4CFFBEEA0109_var*
begin
//#UC START# *51629EB60323_4CFFBEEA0109_impl*
 Supports(GetCurrentNode, Il3Node, Result);
//#UC END# *51629EB60323_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.CurrentCNode

procedure TvtCustomOutliner.CheckParam;
//#UC START# *51629ECF03CE_4CFFBEEA0109_var*
//#UC END# *51629ECF03CE_4CFFBEEA0109_var*
begin
//#UC START# *51629ECF03CE_4CFFBEEA0109_impl*
 inherited;
 if Assigned(f_TreeStruct) then
  Total := TreeStruct.CountView
 else
  Total := 0;
//#UC END# *51629ECF03CE_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.CheckParam

procedure TvtCustomOutliner.ChangeSelect(Index: LongInt);
//#UC START# *51629EEA029E_4CFFBEEA0109_var*
//#UC END# *51629EEA029E_4CFFBEEA0109_var*
begin
//#UC START# *51629EEA029E_4CFFBEEA0109_impl*
 DoOnSelect(Index, Ord(not TreeStruct.Select[Index]));
//#UC END# *51629EEA029E_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.ChangeSelect

function TvtCustomOutliner.GetItemTextDim(aItemIndex: Integer): TPoint;
//#UC START# *51629F26036A_4CFFBEEA0109_var*
var
 l_LPWidth: Integer;
 CR       : TRect;
 S        : Il3CString;
 l_S      : Tl3String;
 l_Canvas : Il3InfoCanvas;
 l_NP     : Il3NodePainter;
 l_MT     : Il3MultipartText;
 lSRect   : Tl3SRect;
 ll3Rect  : Tl3Rect;
 l_ClientWidth: Integer;
const
 lMeasureStr : Tl3PCharLen = (S: 'Wy'#0; SLen : 2; SCodePage: CP_ANSI; );
//#UC END# *51629F26036A_4CFFBEEA0109_var*
begin
//#UC START# *51629F26036A_4CFFBEEA0109_impl*
 Result := Point(0, 0);
 (* Учитывая, что вычислять размер текста мы будем с учетом переноса, если
    ширина не установлена, тогда посчитать ничего на удастся *)

 l_ClientWidth := GetRealClientWidth;

 if (l_ClientWidth = 0) then
  Exit;

 CR := Rect(0, 0, l_ClientWidth, MaxInt);
 l_Canvas := l3CrtIC;
 if f_SelfDrawNodes and Supports(GetNode(aItemIndex), Il3NodePainter, l_NP) then
 begin
  Dec(CR.Right, GetItemTextIndent(aItemIndex, -1));
  Dec(CR.Right, DoOnGetItemIndentEx(aItemIndex));
  if CR.Right < 3 then CR.Right := 3;
  l_LPWidth := l_Canvas.DP2LP(PointX(CR.Right-3)).X;
  l_Canvas.Font.AssignFont(Font);
  CR.Bottom := l_Canvas.LP2DP(l3PointX(l_NP.CalcHeight(l_Canvas, l_LPWidth))).X;
 end//f_SelfDrawNodes..
 else
 begin
  if MultiStrokeItem then
  begin
   Dec(CR.Right, GetItemTextIndent(aItemIndex, CR.Bottom - CR.Top));
   Dec(CR.Right, DoOnGetItemIndentEx(aItemIndex));
   if CR.Right < 3 then
    CR.Right := 3;
  end;//fMultiStrokeItem
  l_Canvas.Font.AssignFont(Font);
  DoOnGetItemFont(aItemIndex, l_Canvas.Font, vt_lipText);
  S := DoOnGetItem(aItemIndex);
  if l3IsNil(S) then
   S := l3CStr(lMeasureStr);
  if MultiStrokeItem then
  begin
   if (Header.Sections.Count > 0) and (Supports(TreeStruct.Nodes[aItemIndex], Il3MultipartText, l_MT)) then
   begin
    l_S := CompileTabstopsFromMultipartText(l_MT);
    try
     f_TabsFirstIndent := GetItemTextIndent(aItemIndex, CR.Bottom - CR.Top);
     Inc(CR.Left, f_TabsFirstIndent); // корректируем, чтобы правильно посчиталось по табстопам
     lSRect.R.WR := CR;
     Inc(lSRect.R.Left, 2);
     ll3Rect := l_Canvas.DR2LR(lSRect);
     l_Canvas.TabbedMultilineTextOut(l_S.AsPCharLen, Tl3TabStops.Make(TSGetTabStopPos, True),
                                      ll3Rect, True, vt_TabbedMLOutGap);
     lSRect := l_Canvas.LR2DR(ll3Rect);
     CR := lSRect.R.WR;
    finally
     l3Free(l_S);
    end///try..finally
   end//Header.Sections.Count > 0
   else
   begin
    Inc(CR.Left, 2); // эти прибавления/убавления нужны чтобы был небольшой отступ от
                     // прямоугольника, изображающего фокус
    l_Canvas.DrawText(l3PCharLen(S), CR, DT_CALCRECT or vtMultiLineDrawTextFormat);
    Dec(CR.Left, 2);
   end;//Header.Sections.Count > 0
  end//FMultiStrokeItem
  else
   l_Canvas.DrawText(l3PCharLen(S), CR, DT_CALCRECT);
 end;//f_SelfDrawNodes

 //if CR.Bottom < RowHeight then CR.Bottom := RowHeight;
 Result := Point(CR.Right - CR.Left, CR.Bottom - CR.Top);
//#UC END# *51629F26036A_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.GetItemTextDim

function TvtCustomOutliner.IsTreeAssign: Boolean;
//#UC START# *51629F480104_4CFFBEEA0109_var*
//#UC END# *51629F480104_4CFFBEEA0109_var*
begin
//#UC START# *51629F480104_4CFFBEEA0109_impl*
 Result := Assigned(f_TreeStruct);
//#UC END# *51629F480104_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.IsTreeAssign

function TvtCustomOutliner.TryExpandNode(const aExpNode: Il3SimpleNode;
  aExpand: Boolean;
  aRecalcTop: Boolean = False): Boolean;
//#UC START# *51629FA803AF_4CFFBEEA0109_var*
var
 l_NewIndex: Integer;                                               
//#UC END# *51629FA803AF_4CFFBEEA0109_var*
begin
//#UC START# *51629FA803AF_4CFFBEEA0109_impl*
 Result := eoItemExpand in EditOptions;
 if Result then
 begin
  // если текущая нода является ребенком сворачиваемой, то надо попытаться
  // сворачиваемую сделать текущей, а если не выйдет, то отказаться от этой затеи (не сворачивать)
  if (not aExpand) and l3IsNodeFromTree(aExpNode, GetCurrentNode) then
  begin
   GotoOnNode(aExpNode);
   if not aExpNode.IsSame(GetCurrentNode) then
    Exit;
  end;//not aExpand..
  ExpandNode(aExpNode, aExpand, aRecalcTop);
 end;//Result
//#UC END# *51629FA803AF_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.TryExpandNode

procedure TvtCustomOutliner.ExpandNode(const aExpNode: Il3SimpleNode;
  aExpand: Boolean;
  aRecalcTop: Boolean = False);
//#UC START# *51629FE90212_4CFFBEEA0109_var*
var
 lExpNode : Il3SimpleNode;
 l_Tree   : Il3SimpleTree;
//#UC END# *51629FE90212_4CFFBEEA0109_var*
begin
//#UC START# *51629FE90212_4CFFBEEA0109_impl*
 LockChangeSelected;
 LockMakeCurrentVisible;
 Changing;

 lExpNode := aExpNode;
 try
  if DoOnExpand(aExpand, lExpNode) then
  begin
   lExpNode := aExpNode;
   l_Tree := TreeStruct;
   while (lExpNode <> nil) AND
         not l_Tree.IsRoot(lExpNode) and
         not l_Tree.IsExpanded(lExpNode.Parent) do
    lExpNode := lExpNode.Parent;

   if not aExpand and MultiSelect and not PickedList then
    l_Tree.SetBranchFlag(lExpNode, sbDeselect, nfSelected, 0);
  end;
 finally
  Changed;
  UnLockMakeCurrentVisible;
  UnLockChangeSelected;
 end;//try..finally

 if aRecalcTop then
  if aExpand then
   ShowMoreChildrenOnScreen(lExpNode)
  else
  begin
   if AlignTopIndex then
    DropDrawPoints;
   vlbInitScrollInfo;
  end;//aExpand
//#UC END# *51629FE90212_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.ExpandNode

procedure TvtCustomOutliner.ExpandNodeOnDeep(const aExpNode: Il3SimpleNode = nil;
  aExpand: Boolean = True;
  aDeepLevel: Byte = 0;
  aRecalcTop: Boolean = False);
//#UC START# *5162A037022E_4CFFBEEA0109_var*
var
 NCur   : LongInt;
 l_Node : Il3SimpleNode;
//#UC END# *5162A037022E_4CFFBEEA0109_var*
begin
//#UC START# *5162A037022E_4CFFBEEA0109_impl*
  Changing;
  try
   if (aExpNode = nil) then
    l_Node := TreeStruct.RootNode
   else
    l_Node := aExpNode;
     
   TreeStruct.ExpandSubDir(l_Node, aExpand, aDeepLevel);

   Total := TreeStruct.CountView;
   if AlignTopIndex then
    DropDrawPoints;

   NCur := TreeStruct.GetIndex(l_Node);
   if NCur >= 0 then
    InternalSetCurrent(NCur);
  finally
   Changed;
  end;
  DoOnExpand(aExpand, nil);
//#UC END# *5162A037022E_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.ExpandNodeOnDeep

procedure TvtCustomOutliner.ShowMoreChildrenOnScreen(const aParentNode: Il3SimpleNode);
//#UC START# *5162A0800035_4CFFBEEA0109_var*
var
 lCurIndex   : Integer;
 lLastInOpen : Integer;
//#UC END# *5162A0800035_4CFFBEEA0109_var*
begin
//#UC START# *5162A0800035_4CFFBEEA0109_impl*
 lCurIndex := TreeStruct.GetIndex(aParentNode);
 lLastInOpen := lCurIndex + TreeStruct.CountViewItemsInSubDir(aParentNode);
 while (TopIndex < lCurIndex) and
       (TopIndex + Pred(Rows) < lLastInOpen) and
       (lLastInOpen < Total) do
 begin
  TopIndex := TopIndex + 1;
  afw.ProcessMessages;
 end;
//#UC END# *5162A0800035_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.ShowMoreChildrenOnScreen

function TvtCustomOutliner.SearchOccurStr(const SrchStr: AnsiString;
  FromCurrent: Boolean): LongInt;
//#UC START# *5162A09D031F_4CFFBEEA0109_var*
var
 lFindNode : Il3SimpleNode;
 lFromNode : Il3SimpleNode;
//#UC END# *5162A09D031F_4CFFBEEA0109_var*
begin
//#UC START# *5162A09D031F_4CFFBEEA0109_impl*
 if FromCurrent then
  lFromNode := GetCurrentNode
 else
  lFromNode := f_TreeStruct.RootNode;
 lFindNode := f_TreeStruct.SearchNameOccur(lFromNode, PAnsiChar(SrchStr), imNoSubRoot or imNoHidden);
 Result := GotoOnNode(lFindNode);
//#UC END# *5162A09D031F_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.SearchOccurStr

function TvtCustomOutliner.GotoOnNode(const aNode: Il3SimpleNode): LongInt;
//#UC START# *5162A0CC01EA_4CFFBEEA0109_var*
var
 l_Current: Il3SimpleNode;
//#UC END# *5162A0CC01EA_4CFFBEEA0109_var*
begin
//#UC START# *5162A0CC01EA_4CFFBEEA0109_impl*
 if aNode = Nil then
  Result := -1
 else
 begin
  Result := Current;
  l_Current := GetCurrentNode;
  if not Assigned(f_TreeStruct) or Assigned(l_Current) and
    l_Current.IsSame(aNode) then
   Exit;
  Result := f_TreeStruct.MakeNodeVisible(aNode);
  if Result < 0 then
   Exit;
  Total := TreeStruct.CountView;
  if IsInChange then
   f_SaveCurrentNode := aNode
  else
  if Current = Result then
  begin
   Current := Result;
   DoCurrentChanged(Result, Current);
  end else
   Current := Result;
 end;
//#UC END# *5162A0CC01EA_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.GotoOnNode

function TvtCustomOutliner.IterateF(Action: Tl3NodeAction;
  IterMode: Byte): Il3Node;
//#UC START# *5162A19701F3_4CFFBEEA0109_var*
//#UC END# *5162A19701F3_4CFFBEEA0109_var*
begin
//#UC START# *5162A19701F3_4CFFBEEA0109_impl*
 if f_TreeStruct <> nil then
  Result := (f_TreeStruct As Il3Tree).IterateF(Action, IterMode);
//#UC END# *5162A19701F3_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.IterateF

procedure TvtCustomOutliner.ReplaceTreeStructForceAsSame(const aTree: Il3SimpleTree);
//#UC START# *5162A1C102E3_4CFFBEEA0109_var*
//#UC END# *5162A1C102E3_4CFFBEEA0109_var*
begin
//#UC START# *5162A1C102E3_4CFFBEEA0109_impl*
 Changing;
 try
  TreeStruct := aTree;
  f_SaveRootNode := TreeStruct.RootNode;
 finally
  Changed;
 end;
//#UC END# *5162A1C102E3_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.ReplaceTreeStructForceAsSame

procedure TvtCustomOutliner.SubscribeTreeStruct(const aTreeStruct: Il3SimpleTree);
//#UC START# *516297E40319_4CFFBEEA0109_var*
var
 l_ContextNotifierSource: Il3ContextFilterNotifySource;
//#UC END# *516297E40319_4CFFBEEA0109_var*
begin
//#UC START# *516297E40319_4CFFBEEA0109_impl*
 aTreeStruct.Subscribe(Il3ChangeRecipient(Self));
 if Supports(aTreeStruct, Il3ContextFilterNotifySource, l_ContextNotifierSource) then
  l_ContextNotifierSource.SubscribeToContextFilter(Self);
//#UC END# *516297E40319_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.SubscribeTreeStruct

procedure TvtCustomOutliner.UnsubscribeTreeStruct(const aTreeStruct: Il3SimpleTree);
//#UC START# *5162982100FB_4CFFBEEA0109_var*
var
 l_ContextNotifierSource: Il3ContextFilterNotifySource;
//#UC END# *5162982100FB_4CFFBEEA0109_var*
begin
//#UC START# *5162982100FB_4CFFBEEA0109_impl*
 aTreeStruct.Unsubscribe(Il3ChangeRecipient(Self));
 if Supports(aTreeStruct, Il3ContextFilterNotifySource, l_ContextNotifierSource) then
  l_ContextNotifierSource.UnSubscribeFromContextFilter(Self);
//#UC END# *5162982100FB_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.UnsubscribeTreeStruct

function TvtCustomOutliner.DoOnGetItemIndentEx(anItemIndex: Integer): Integer;
//#UC START# *51D2DC290320_4CFFBEEA0109_var*
//#UC END# *51D2DC290320_4CFFBEEA0109_var*
begin
//#UC START# *51D2DC290320_4CFFBEEA0109_impl*
 if Assigned(f_OnGetItemIndentEx)
  then Result := f_OnGetItemIndentEx(Self, anItemIndex)
  else Result := 0;
//#UC END# *51D2DC290320_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoOnGetItemIndentEx

function TvtCustomOutliner.NeedDrawSelectionOnItem(aItemIndex: Integer): Boolean;
//#UC START# *51E8006D030E_4CFFBEEA0109_var*
//#UC END# *51E8006D030E_4CFFBEEA0109_var*
begin
//#UC START# *51E8006D030E_4CFFBEEA0109_impl*
 Result := Selected[aItemIndex];
//#UC END# *51E8006D030E_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.NeedDrawSelectionOnItem

function TvtCustomOutliner.NeedDrawArrowSelection(aItemIndex: Integer): Boolean;
//#UC START# *5266253D035D_4CFFBEEA0109_var*
//#UC END# *5266253D035D_4CFFBEEA0109_var*
begin
//#UC START# *5266253D035D_4CFFBEEA0109_impl*
 Result := aItemIndex = Current;
//#UC END# *5266253D035D_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.NeedDrawArrowSelection

function TvtCustomOutliner.GetRealClientWidth: Integer;
//#UC START# *543239ED008D_4CFFBEEA0109_var*
//#UC END# *543239ED008D_4CFFBEEA0109_var*
begin
//#UC START# *543239ED008D_4CFFBEEA0109_impl*
 Result := ClientWidth;
//#UC END# *543239ED008D_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.GetRealClientWidth

function TvtCustomOutliner.NeedAssignTreeStructFromHistory: Boolean;
//#UC START# *5604EC1403A8_4CFFBEEA0109_var*
//#UC END# *5604EC1403A8_4CFFBEEA0109_var*
begin
//#UC START# *5604EC1403A8_4CFFBEEA0109_impl*
 Result := True;
 // - КОСТЫЛЬ.
 // http://mdp.garant.ru/pages/viewpage.action?pageId=607760979
//#UC END# *5604EC1403A8_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.NeedAssignTreeStructFromHistory
// start class TvtSimpleOutliner

function TvtSimpleOutliner.Get_Tree: Il3SimpleTree;
//#UC START# *477252C801B5_515EE352036Eget_var*
//#UC END# *477252C801B5_515EE352036Eget_var*
begin
//#UC START# *477252C801B5_515EE352036Eget_impl*
 Result := TreeStruct;
//#UC END# *477252C801B5_515EE352036Eget_impl*
end;//TvtSimpleOutliner.Get_Tree

procedure TvtSimpleOutliner.Set_Tree(const aValue: Il3SimpleTree);
//#UC START# *477252C801B5_515EE352036Eset_var*
//#UC END# *477252C801B5_515EE352036Eset_var*
begin
//#UC START# *477252C801B5_515EE352036Eset_impl*
 TreeStruct := aValue;
//#UC END# *477252C801B5_515EE352036Eset_impl*
end;//TvtSimpleOutliner.Set_Tree

procedure TvtCustomOutliner.pm_SetViewOptions(aValue: TvtViewOptions);
//#UC START# *515DBA1202F9_4CFFBEEA0109set_var*
var
 lLOpt : TvlViewOptions;
//#UC END# *515DBA1202F9_4CFFBEEA0109set_var*
begin
//#UC START# *515DBA1202F9_4CFFBEEA0109set_impl*
 if aValue <> f_ViewOptions then
 begin
  f_ViewOptions := aValue;
  UpdateImagesOptions;
  Invalidate;
 end;

 if Assigned(f_TreeStruct) then
  f_TreeStruct.ShowRoot := (voShowRoot in aValue);

 lLOpt := [];
 if voShowInterRowSpace in f_ViewOptions then
  Include(lLOpt, TvlViewOption(voShowInterRowSpace));

 inherited ViewOptions := lLOpt;
//#UC END# *515DBA1202F9_4CFFBEEA0109set_impl*
end;//TvtCustomOutliner.pm_SetViewOptions

procedure TvtCustomOutliner.pm_SetEditOptions(aValue: TvtEditOptions);
//#UC START# *515DBAE900F9_4CFFBEEA0109set_var*
//#UC END# *515DBAE900F9_4CFFBEEA0109set_var*
begin
//#UC START# *515DBAE900F9_4CFFBEEA0109set_impl*
 f_EditOptions := aValue;
 f_LegalOperations := cAllOutlinerCommand;

 if not (eoItemHMoving in f_EditOptions) or ReadOnly then
  f_LegalOperations := f_LegalOperations - cOutlinerHMovingCommand;

 if not (eoItemVMoving in f_EditOptions) or ReadOnly then
  f_LegalOperations := f_LegalOperations - cOutlinerVMovingCommand;

 if not (eoItemDelete in f_EditOptions) or ReadOnly then
  f_LegalOperations := f_LegalOperations - cOutlinerDeleteCommand;
//#UC END# *515DBAE900F9_4CFFBEEA0109set_impl*
end;//TvtCustomOutliner.pm_SetEditOptions

procedure TvtCustomOutliner.pm_SetSelfDrawNodes(aValue: Boolean);
//#UC START# *515DBB3E0155_4CFFBEEA0109set_var*
//#UC END# *515DBB3E0155_4CFFBEEA0109set_var*
begin
//#UC START# *515DBB3E0155_4CFFBEEA0109set_impl*
 if (f_SelfDrawNodes <> aValue) then
 begin
  f_SelfDrawNodes := aValue;
  DropDrawPoints;
  Invalidate;
 end;//f_SelfDrawNodes <> aValue
//#UC END# *515DBB3E0155_4CFFBEEA0109set_impl*
end;//TvtCustomOutliner.pm_SetSelfDrawNodes

procedure TvtCustomOutliner.pm_SetTreeSource(aValue: TvtCustomTreeSource);
//#UC START# *515DC424037A_4CFFBEEA0109set_var*
//#UC END# *515DC424037A_4CFFBEEA0109set_var*
begin
//#UC START# *515DC424037A_4CFFBEEA0109set_impl*
 if (f_TreeSource <> aValue) then
 begin
  f_TreeSource := aValue;
  if (f_TreeSource <> nil) then
   TreeStruct := f_TreeSource.Tree;
 end;//f_TreeSource <> aValue
//#UC END# *515DC424037A_4CFFBEEA0109set_impl*
end;//TvtCustomOutliner.pm_SetTreeSource

function TvtCustomOutliner.pm_GetCTree: Il3Tree;
//#UC START# *516296F30260_4CFFBEEA0109get_var*
//#UC END# *516296F30260_4CFFBEEA0109get_var*
begin
//#UC START# *516296F30260_4CFFBEEA0109get_impl*
 Result := TreeStruct as Il3Tree;
//#UC END# *516296F30260_4CFFBEEA0109get_impl*
end;//TvtCustomOutliner.pm_GetCTree

function TvtCustomOutliner.pm_GetShowRoot: Boolean;
//#UC START# *5162A253038D_4CFFBEEA0109get_var*
//#UC END# *5162A253038D_4CFFBEEA0109get_var*
begin
//#UC START# *5162A253038D_4CFFBEEA0109get_impl*
 Result := voShowRoot in f_ViewOptions;
//#UC END# *5162A253038D_4CFFBEEA0109get_impl*
end;//TvtCustomOutliner.pm_GetShowRoot

procedure TvtCustomOutliner.pm_SetShowRoot(aValue: Boolean);
//#UC START# *5162A253038D_4CFFBEEA0109set_var*
//#UC END# *5162A253038D_4CFFBEEA0109set_var*
begin
//#UC START# *5162A253038D_4CFFBEEA0109set_impl*
 if (voShowRoot in f_ViewOptions) <> aValue then
  begin
   if aValue then
    f_ViewOptions := f_ViewOptions + [voShowRoot]
   else
    f_ViewOptions := f_ViewOptions - [voShowRoot];
   if Assigned(f_TreeStruct) then
   begin
    f_TreeStruct.ShowRoot := aValue;
    Invalidate;
   end;
  end;
//#UC END# *5162A253038D_4CFFBEEA0109set_impl*
end;//TvtCustomOutliner.pm_SetShowRoot

function TvtCustomOutliner.pm_GetShowOpenChip: Boolean;
//#UC START# *5162A27A02B1_4CFFBEEA0109get_var*
//#UC END# *5162A27A02B1_4CFFBEEA0109get_var*
begin
//#UC START# *5162A27A02B1_4CFFBEEA0109get_impl*
 Result := voShowOpenChip in f_ViewOptions;
//#UC END# *5162A27A02B1_4CFFBEEA0109get_impl*
end;//TvtCustomOutliner.pm_GetShowOpenChip

procedure TvtCustomOutliner.pm_SetShowOpenChip(aValue: Boolean);
//#UC START# *5162A27A02B1_4CFFBEEA0109set_var*
//#UC END# *5162A27A02B1_4CFFBEEA0109set_var*
begin
//#UC START# *5162A27A02B1_4CFFBEEA0109set_impl*
 if (voShowOpenChip in f_ViewOptions) = aValue then
  Exit;
 if aValue then
  f_ViewOptions := f_ViewOptions + [voShowOpenChip]
 else
  f_ViewOptions := f_ViewOptions - [voShowOpenChip];
 Invalidate;
//#UC END# *5162A27A02B1_4CFFBEEA0109set_impl*
end;//TvtCustomOutliner.pm_SetShowOpenChip

function TvtCustomOutliner.pm_GetShowExpandable: Boolean;
//#UC START# *5162A29F0091_4CFFBEEA0109get_var*
//#UC END# *5162A29F0091_4CFFBEEA0109get_var*
begin
//#UC START# *5162A29F0091_4CFFBEEA0109get_impl*
 Result := voShowExpandable in f_ViewOptions;
//#UC END# *5162A29F0091_4CFFBEEA0109get_impl*
end;//TvtCustomOutliner.pm_GetShowExpandable

procedure TvtCustomOutliner.pm_SetShowExpandable(aValue: Boolean);
//#UC START# *5162A29F0091_4CFFBEEA0109set_var*
//#UC END# *5162A29F0091_4CFFBEEA0109set_var*
begin
//#UC START# *5162A29F0091_4CFFBEEA0109set_impl*
 if (voShowExpandable in f_ViewOptions) = aValue then
  Exit;
 if aValue then
  f_ViewOptions := f_ViewOptions + [voShowExpandable]
 else
  f_ViewOptions := f_ViewOptions - [voShowExpandable];
 Invalidate;
//#UC END# *5162A29F0091_4CFFBEEA0109set_impl*
end;//TvtCustomOutliner.pm_SetShowExpandable

function TvtCustomOutliner.pm_GetIsShowLines: Boolean;
//#UC START# *5162A2F10264_4CFFBEEA0109get_var*
//#UC END# *5162A2F10264_4CFFBEEA0109get_var*
begin
//#UC START# *5162A2F10264_4CFFBEEA0109get_impl*
 Result := voShowLines in f_ViewOptions;
//#UC END# *5162A2F10264_4CFFBEEA0109get_impl*
end;//TvtCustomOutliner.pm_GetIsShowLines

procedure TvtCustomOutliner.pm_SetIsShowLines(aValue: Boolean);
//#UC START# *5162A2F10264_4CFFBEEA0109set_var*
//#UC END# *5162A2F10264_4CFFBEEA0109set_var*
begin
//#UC START# *5162A2F10264_4CFFBEEA0109set_impl*
 if aValue then
  f_ViewOptions := f_ViewOptions + [voShowLines]
 else
  f_ViewOptions := f_ViewOptions - [voShowLines];
//#UC END# *5162A2F10264_4CFFBEEA0109set_impl*
end;//TvtCustomOutliner.pm_SetIsShowLines

function TvtCustomOutliner.pm_GetFullLineSelect: Boolean;
//#UC START# *51D67CEF00B7_4CFFBEEA0109get_var*
//#UC END# *51D67CEF00B7_4CFFBEEA0109get_var*
begin
//#UC START# *51D67CEF00B7_4CFFBEEA0109get_impl*
 Result := voFullLineSelect in f_ViewOptions; 
//#UC END# *51D67CEF00B7_4CFFBEEA0109get_impl*
end;//TvtCustomOutliner.pm_GetFullLineSelect

procedure TvtCustomOutliner.pm_SetFullLineSelect(aValue: Boolean);
//#UC START# *51D67CEF00B7_4CFFBEEA0109set_var*
//#UC END# *51D67CEF00B7_4CFFBEEA0109set_var*
begin
//#UC START# *51D67CEF00B7_4CFFBEEA0109set_impl*
 if aValue <> pm_GetFullLineSelect then
 begin
  if aValue 
   then Include(f_ViewOptions, voFullLineSelect)
   else Exclude(f_ViewOptions, voFullLineSelect);
  Invalidate;
 end;
//#UC END# *51D67CEF00B7_4CFFBEEA0109set_impl*
end;//TvtCustomOutliner.pm_SetFullLineSelect

procedure TvtCustomOutliner.WMLButtonDown(var Msg: TWMLButtonDown);
//#UC START# *51668D0401E9_4CFFBEEA0109_var*
var
 Pt : TPoint;
 CNode : Il3SimpleNode;
 N  : Longint;
 GraphLen : Word;
 BMPX  : Integer;
 l_ItemPart      : Byte;
//#UC END# *51668D0401E9_4CFFBEEA0109_var*
begin
//#UC START# *51668D0401E9_4CFFBEEA0109_impl*
 afw.BeginOp;
 try
  {inherited;}

  if not Assigned(f_TreeStruct) or
     (csDestroying in ComponentState) then
   Exit;

  if CanFocus and TabStop and not (csDesigning in ComponentState) then
   SetFocus;

  {$IfDef Win32}
  Pt := SmallPointToPoint(Msg.Pos);
  {$Else  Win32}
  Pt:=Msg.Pos;
  {$EndIf Win32}

  N:=ItemAtPos(Pt, True);
  if N < 0 then
  begin
   HitTest(Pt, N, l_ItemPart);
   if (l_ItemPart = ihtFooter) then
    DoFooterClick;
   Exit;
  end;
  CNode:=GetNode(N);
  if not Assigned(CNode) then
   Exit;
  BMPX := DoOnGetItemIndent;

  GraphLen := {Ord(voShowLines in f_ViewOptions) *} (BMPX * GetDrawLevel(CNode) + (RowHeight div 4));

  if not (voShowOpenChip in f_ViewOptions) or f_TreeStruct.IsRoot(CNode) or
     (Pt.X < (GraphLen - BMPX)) or (Pt.X > GraphLen) or
     not f_TreeStruct.HasVisibleChildren(CNode) then
    Inherited
   else
    TryExpandNode(CNode, not f_TreeStruct.IsExpanded(CNode), True);
 finally
  afw.EndOp;
 end;//try..finally
//#UC END# *51668D0401E9_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.WMLButtonDown

procedure TvtCustomOutliner.WMLButtonDblClk(var Msg: TWMLButtonDblClk);
//#UC START# *51668D2203CC_4CFFBEEA0109_var*
var
  Pt : TPoint;
  //dX : Integer;
  CN : Il3SimpleNode;
  N  : Longint;
  //GraphLen : Word;

 procedure lp_DoAction;
 begin
  Current := N;
  if not f_InActionProcess then
   DoOnActionElement(N);
 end;
//#UC END# *51668D2203CC_4CFFBEEA0109_var*
begin
//#UC START# *51668D2203CC_4CFFBEEA0109_impl*
 {DblClick;}
 if not Assigned(f_TreeStruct) or
    (csDestroying in ComponentState) then
  Exit;

 if CanFocus and TabStop and not (csDesigning in ComponentState) then
  SetFocus;

 Pt := SmallPointToPoint(Msg.Pos);

 N:=ItemAtPos(Pt, True);

 case vlbItemHitTest(N, Pt) of
  ihtIcon :
   begin
    CN:=GetNode(N);
    TryExpandNode(CN, not f_TreeStruct.IsExpanded(CN), True);
    if not CN.HasChild then
     lp_DoAction;
   end;
  ihtText :
   lp_DoAction;
 end;
//#UC END# *51668D2203CC_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.WMLButtonDblClk

procedure TvtCustomOutliner.SelectCountChanged(anOldCount: Integer;
  aNewCount: Integer);
//#UC START# *46A454B40054_4CFFBEEA0109_var*
//#UC END# *46A454B40054_4CFFBEEA0109_var*
begin
//#UC START# *46A454B40054_4CFFBEEA0109_impl*
 if Assigned(f_OnSelectCountChanged) then
  f_OnSelectCountChanged(Self, anOldCount, aNewCount);

 Invalidate;
//#UC END# *46A454B40054_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.SelectCountChanged

procedure TvtCustomOutliner.ExternalVisibleCountChanged(aNewCount: Integer;
  aNodeIndex: Integer;
  aDelta: Integer);
//#UC START# *46A4555F0031_4CFFBEEA0109_var*
 function CorrectParam(aParam: LongInt): LongInt;
 begin//CorrectParam
  if (aNodeIndex < aParam) then
  begin
   Result := aParam;
   Inc(Result, aDelta);
   if Result < 0 then
    Result := 0;
  end//aNodeIndex < aParam
  else
   Result := -1;
 end;//CorrectParam

var
 l_NewCurrent,
 l_NewTop,
 l_NewAnchor: LongInt;
//#UC END# *46A4555F0031_4CFFBEEA0109_var*
begin
//#UC START# *46A4555F0031_4CFFBEEA0109_impl*
 if (Total <> aNewCount) then
 begin
  // Изменился невидимый корень - ставим все в начало
  if (aNodeIndex = -1) then
  begin
   l_NewCurrent := 0;
   l_NewTop := 0;
   l_NewAnchor := 0;
  end//aNodeIndex = -1
  else
  begin
   // Корректируем текущий элемент
   l_NewCurrent := CorrectParam(Current);
   // Корректируем верхнюю границу
   l_NewTop := CorrectParam(TopIndex);
   // Корректируем точку привязки для мультивыделения
   l_NewAnchor := CorrectParam(f_Anchor);
  end;//aNodeIndex = -1

  ExternalSetTotal(aNewCount, l_NewCurrent, l_NewTop, l_NewAnchor);

  // Изменился невидимый корень - проверим скроллеры
  if (aNodeIndex = -1) then
   vlbInitScrollInfo;
 end;//fTotal <> aNewCount
//#UC END# *46A4555F0031_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.ExternalVisibleCountChanged

procedure TvtCustomOutliner.ExternalInvalidate;
//#UC START# *46A455900227_4CFFBEEA0109_var*
//#UC END# *46A455900227_4CFFBEEA0109_var*
begin
//#UC START# *46A455900227_4CFFBEEA0109_impl*
 Invalidate;
 DropDrawPoints;
 vlbInitScrollInfo;
//#UC END# *46A455900227_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.ExternalInvalidate

procedure TvtCustomOutliner.ExternalModified(aNode: Integer;
  aDelta: Integer);
//#UC START# *46A455A60278_4CFFBEEA0109_var*
//#UC END# *46A455A60278_4CFFBEEA0109_var*
begin
//#UC START# *46A455A60278_4CFFBEEA0109_impl*
 with f_TreeModifiedData do
 begin
  rNode := aNode;
  rDelta := aDelta;
 end;
//#UC END# *46A455A60278_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.ExternalModified

function TvtCustomOutliner.Get_Tree: Il3Tree;
//#UC START# *477187FD0168_4CFFBEEA0109get_var*
//#UC END# *477187FD0168_4CFFBEEA0109get_var*
begin
//#UC START# *477187FD0168_4CFFBEEA0109get_impl*
 Supports(TreeStruct, Il3Tree, Result);
//#UC END# *477187FD0168_4CFFBEEA0109get_impl*
end;//TvtCustomOutliner.Get_Tree

procedure TvtCustomOutliner.Set_Tree(const aValue: Il3Tree);
//#UC START# *477187FD0168_4CFFBEEA0109set_var*
//#UC END# *477187FD0168_4CFFBEEA0109set_var*
begin
//#UC START# *477187FD0168_4CFFBEEA0109set_impl*
 TreeStruct := aValue;
//#UC END# *477187FD0168_4CFFBEEA0109set_impl*
end;//TvtCustomOutliner.Set_Tree

procedure TvtCustomOutliner.RequestReapply;
//#UC START# *477250FC0040_4CFFBEEA0109_var*
var
 l_Index : Integer;
//#UC END# *477250FC0040_4CFFBEEA0109_var*
begin
//#UC START# *477250FC0040_4CFFBEEA0109_impl*
 if (f_Subscribers <> nil) then
  for l_Index := 0 to Pred(f_Subscribers.Count) do
   Il3ContextFilterNotifier(f_Subscribers[l_Index]).RequestReapply;
//#UC END# *477250FC0040_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.RequestReapply

procedure TvtCustomOutliner.RequestClearAndTurnOff;
//#UC START# *4772510D0043_4CFFBEEA0109_var*
var
 l_Index : Integer;
//#UC END# *4772510D0043_4CFFBEEA0109_var*
begin
//#UC START# *4772510D0043_4CFFBEEA0109_impl*
 if (f_Subscribers <> nil) then
  for l_Index := 0 to Pred(f_Subscribers.Count) do
   Il3ContextFilterNotifier(f_Subscribers[l_Index]).RequestClearAndTurnOff;
//#UC END# *4772510D0043_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.RequestClearAndTurnOff

procedure TvtCustomOutliner.RequestCheckValid;
//#UC START# *4772511D0316_4CFFBEEA0109_var*
var
 l_Index : Integer;
//#UC END# *4772511D0316_4CFFBEEA0109_var*
begin
//#UC START# *4772511D0316_4CFFBEEA0109_impl*
 if (f_Subscribers <> nil) then
  for l_Index := 0 to Pred(f_Subscribers.Count) do
   Il3ContextFilterNotifier(f_Subscribers[l_Index]).RequestCheckValid;
//#UC END# *4772511D0316_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.RequestCheckValid

procedure TvtCustomOutliner.SubscribeToContextFilter(const aSubscriber: Il3ContextFilterNotifier);
//#UC START# *477251CC02BD_4CFFBEEA0109_var*
//#UC END# *477251CC02BD_4CFFBEEA0109_var*
begin
//#UC START# *477251CC02BD_4CFFBEEA0109_impl*
 if (f_Subscribers = nil) then
  f_Subscribers := Tl3LongintList.MakeSorted;
 f_Subscribers.Add(Integer(aSubscriber));
//#UC END# *477251CC02BD_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.SubscribeToContextFilter

procedure TvtCustomOutliner.UnSubscribeFromContextFilter(const aSubscriber: Il3ContextFilterNotifier);
//#UC START# *477251E203DD_4CFFBEEA0109_var*
//#UC END# *477251E203DD_4CFFBEEA0109_var*
begin
//#UC START# *477251E203DD_4CFFBEEA0109_impl*
 if (f_Subscribers <> nil) then
  f_Subscribers.Remove(Integer(aSubscriber));
//#UC END# *477251E203DD_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.UnSubscribeFromContextFilter

function TvtCustomOutliner.IsSameContext(const aContext: Il3CString;
  out DiffStart: Cardinal): Boolean;
//#UC START# *4772521703E3_4CFFBEEA0109_var*
var
 l_Target: Il3ContextFilterTarget;
//#UC END# *4772521703E3_4CFFBEEA0109_var*
begin
//#UC START# *4772521703E3_4CFFBEEA0109_impl*
 if Supports(f_TreeStruct, Il3ContextFilterTarget, l_Target) then
  Result := l_Target.IsSameContext(aContext, DiffStart)
 else
 begin
  Result := True;
  DiffStart := l3Len(aContext);
 end;
//#UC END# *4772521703E3_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.IsSameContext

function TvtCustomOutliner.Unfold: Il3ContextFilterTarget;
//#UC START# *4772524F0087_4CFFBEEA0109_var*
//#UC END# *4772524F0087_4CFFBEEA0109_var*
begin
//#UC START# *4772524F0087_4CFFBEEA0109_impl*
 Supports(f_TreeStruct, Il3ContextFilterTarget, Result);
//#UC END# *4772524F0087_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.Unfold

function TvtCustomOutliner.MakeTreeStruct: Il3SimpleTree;
//#UC START# *515EF1880228_4CFFBEEA0109_var*
//#UC END# *515EF1880228_4CFFBEEA0109_var*
begin
//#UC START# *515EF1880228_4CFFBEEA0109_impl*
 Result := Tl3Tree.Make;
//#UC END# *515EF1880228_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.MakeTreeStruct

function TvtCustomOutliner.pm_GetTreeStruct: Il3SimpleTree;
//#UC START# *515EF27A028F_4CFFBEEA0109get_var*
//#UC END# *515EF27A028F_4CFFBEEA0109get_var*
begin
//#UC START# *515EF27A028F_4CFFBEEA0109get_impl*
 if not Assigned(f_TreeStruct) then
 begin
  Result := MakeTreeStruct;
  pm_SetTreeStruct(Result);
 end;//not Assigned(f_TreeStruct)
 Result := f_TreeStruct;
//#UC END# *515EF27A028F_4CFFBEEA0109get_impl*
end;//TvtCustomOutliner.pm_GetTreeStruct

procedure TvtCustomOutliner.pm_SetTreeStruct(const aValue: Il3SimpleTree);
//#UC START# *515EF27A028F_4CFFBEEA0109set_var*
var
 l_OldTree : Il3SimpleTree;
//#UC END# *515EF27A028F_4CFFBEEA0109set_var*
begin
//#UC START# *515EF27A028F_4CFFBEEA0109set_impl*
 if (f_TreeStruct = aValue) then
  Exit;
 l_OldTree := f_TreeStruct;
 try
  if (f_TreeStruct <> nil) then
  begin
   UnsubscribeTreeStruct(f_TreeStruct);
   f_TreeStruct := nil;
  end;//f_TreeStruct <> nil
  if (csDestroying in ComponentState) then
   Exit;
  if Assigned(aValue) then
  begin
   f_TreeStruct := aValue;
   SubscribeTreeStruct(f_TreeStruct);
   f_TreeStruct.ShowRoot := (voShowRoot in ViewOptions);
   InternalSetCurrent(0);
   InternalSetTopIndex(0);
   Total := TreeStruct.CountView;
   if not f_LockSelectChange then
    Current := 0;
   TreeStruct.CursorTop;
   if AlignTopIndex then DropDrawPoints;
  end//Assigned(aValue)
  else
  begin
   InternalSetCurrent(0);
   InternalSetTopIndex(0);
   Total := 0;
  end;
  vlbInitScrollInfo;
  if (f_TreeSource <> nil) then
   f_TreeSource.Tree := f_TreeStruct;
  DoTreeChanged(l_OldTree, f_TreeStruct);
  Invalidate;
 finally
  l_OldTree := nil;
 end;//try..finally
//#UC END# *515EF27A028F_4CFFBEEA0109set_impl*
end;//TvtCustomOutliner.pm_SetTreeStruct

procedure TvtCustomOutliner.Cleanup;
//#UC START# *479731C50290_4CFFBEEA0109_var*
//#UC END# *479731C50290_4CFFBEEA0109_var*
begin
//#UC START# *479731C50290_4CFFBEEA0109_impl*
 l3Free(f_Subscribers);
 f_NodeInMove := nil;
 f_SaveCurrentNode := nil;
 f_SaveRootNode := nil;
 TreeSource := nil;
 TreeStruct := nil;
 inherited;
//#UC END# *479731C50290_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.Cleanup

constructor TvtCustomOutliner.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4CFFBEEA0109_var*
//#UC END# *47D1602000C6_4CFFBEEA0109_var*
begin
//#UC START# *47D1602000C6_4CFFBEEA0109_impl*
 inherited;
 f_WaitingCountChanged := False;
 //CreateGlyph;
 InternalSelector:=False;
 {FExpandLevelCnt:=0;}
 ReadOnly     := False;
 ViewOptions  := [voShowIcons,voShowLines,voShowOpenChip,voShowExpandable];
 EditOptions  := [eoItemExpand];
 OnCharToItem := CharToItem;
 {$IfOpt D+}
 DoubleBuffered := False;
 {$Else D+}
 DoubleBuffered := True;
 {$EndIf D+}
 f_SelfDrawNodes := False;
 f_LineColor := clGray;
 f_OpenChipColor := clBlack;
 f_OpenChipBorderColor := clGray;
//#UC END# *47D1602000C6_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.Create

function TvtCustomOutliner.MouseAction(const aPt: Tl3Point;
  aButton: Tl3MouseButton;
  anAction: Tl3MouseAction;
  aKeys: TShiftState): Tl3MouseResult;
//#UC START# *47E138F90081_4CFFBEEA0109_var*
var
 lPt       : TPoint;
 ll3Pt     : Tl3Point;
 lCNode    : Il3SimpleNode;
 lCR       : TRect;
 lIndex    : LongInt;
 lTextInd  : Integer;
 l_NP      : Il3NodePainter;
 l_Canvas  : Il3InfoCanvas;
 l_LPWidth : Integer;

 {$if not Declared(InevHotSpotTester)}
  {$Define evFormatOnDraw}
 {$IfEnd}
 {$IfNDef evFormatOnDraw}
 lHotSpotTester   : InevHotSpotTester;
 lAdvancedHotSpot : IevAdvancedHotSpot;
 lNeedAsyncLoop   : Bool;
 l_View           : InevControlView;
 {$EndIf  evFormatOnDraw}
//#UC END# *47E138F90081_4CFFBEEA0109_var*
begin
//#UC START# *47E138F90081_4CFFBEEA0109_impl*
 Result := l3_mrNotHandled;
 if not f_SelfDrawNodes then
  Exit;

 if not Assigned(f_TreeStruct) or
    (csDestroying in ComponentState) then
  Exit;

 //if CanFocus and TabStop and not (csDesigning in ComponentState) then
 // SetFocus;

 lPt := Point(aPT.X, aPT.Y);

 lIndex := ItemAtPos(lPt, True);

 lTextInd := GetItemTextIndent(lIndex, lPt.Y);
 if aPT.X < lTextInd then
  Exit;

 lCR := GetDrawRect(lIndex);
 ll3Pt.Init(aPT.X - lTextInd, aPT.Y - lCR.Top);

 lCNode := GetNode(lIndex);

 if Supports(lCNode, Il3NodePainter, l_NP) then
 begin
  l_Canvas := l3CrtIC;
  l_LPWidth := l_Canvas.DP2LP(PointX(lCR.Right - lCR.Left - lTextInd - 3)).X;
  l_Canvas.Font.AssignFont(Font);
  l_NP.CalcHeight(l_Canvas, l_LPWidth);

  {$IfNDef evFormatOnDraw}
  if Supports(lCNode, InevHotSpotTester, lHotSpotTester) then
  begin
   if Supports(Self, InevControlView, l_View) then
    if l3IOK(lHotSpotTester.GetAdvancedHotSpot(l_View, ll3Pt, Tl3GUID_C(IevAdvancedHotSpot), lAdvancedHotSpot)) then
     if lAdvancedHotSpot.MouseAction(Self, ll3Pt, aButton, anAction, aKeys, lNeedAsyncLoop) then
      if lNeedAsyncLoop then
       Result := l3_mrHandledAndMoveLoopNeed
      else
        Result := l3_mrNotHandled; //l3_mrHandled;
  end;//Supports(lCNode, InevHotSpotTester, lHotSpotTester)
  {$EndIf  evFormatOnDraw}
 end;//Supports(lCNode, Il3NodePainter, l_NP)
//#UC END# *47E138F90081_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.MouseAction

procedure TvtCustomOutliner.DoChanging;
//#UC START# *48BD5F73035B_4CFFBEEA0109_var*
//#UC END# *48BD5F73035B_4CFFBEEA0109_var*
begin
//#UC START# *48BD5F73035B_4CFFBEEA0109_impl*
 if Assigned(TreeStruct) then
 begin
  if Current > -1 then
   f_SaveCurrentNode := GetCurrentNode
  else
   f_SaveCurrentNode := nil;

  f_SaveRootNode := TreeStruct.RootNode;
 end
 else
 begin
  f_SaveRootNode := nil;
  f_SaveCurrentNode := nil;
 end;
//#UC END# *48BD5F73035B_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoChanging

procedure TvtCustomOutliner.DoChanged;
//#UC START# *48BD5F8303C4_4CFFBEEA0109_var*
 procedure ForceSetCurrent;
 begin//ForceSetCurrent
  // force pm_SetCurrent
  InternalSetCurrent(-1);
  CheckParam; //Total := TreeStruct.CountView;
  if (Total > 0) then
   Current := 0;
 end;//ForceSetCurrent

var
 lCur : Integer;
 l_OldCurrent : Il3SimpleNode;
 l_Root       : Il3SimpleNode;
//#UC END# *48BD5F8303C4_4CFFBEEA0109_var*
begin
//#UC START# *48BD5F8303C4_4CFFBEEA0109_impl*
 if csDestroying in ComponentState then Exit;

 try
  if not Assigned(TreeStruct) then
   ForceSetCurrent
  else
  if (f_SaveRootNode = nil) then
   ForceSetCurrent
  else
  begin
   l_Root := TreeStruct.RootNode;
   try
    if (l_Root = nil) then
     ForceSetCurrent
    else
    begin
     if (f_SaveRootNode = nil) then
     // - это не паранойя и не шизофрения и не бред сумасшедшего, это реальность:
     // http://mdp.garant.ru/pages/viewpage.action?pageId=294588730&focusedCommentId=294599592#comment-294599592
      ForceSetCurrent
     else
     if not f_SaveRootNode.IsSame(l_Root) then
      ForceSetCurrent
     else
     begin
      CheckParam; //Total := TreeStruct.CountView;
      lCur := -1;
      l_OldCurrent := f_SaveCurrentNode;
      try
       if (f_SaveCurrentNode <> nil) and not f_SaveCurrentNode.IsDisappeared then
        try
         Repeat
          lCur := TreeStruct.GetIndex(f_SaveCurrentNode);

          // если ничего не нашли, тогда (и только тогда) попробуем выше по дереву
          if lCur < 0 then
           f_SaveCurrentNode := f_SaveCurrentNode.Parent;
         until (lCur >= 0) or (f_SaveCurrentNode = nil);
        except
        end;
       //if lCur < 0 then lCur := f_Current;
       //f_Current := -1;
       if (lCur >= 0) then
        pm_SetCurrent(lCur)
       else
       begin
        if (l_OldCurrent <> nil) and
           not l_OldCurrent.IsSame(GetCurrentNode) and not PickedList then
         vlbDeselectAllItems;
        with f_TreeModifiedData do
         // Данные в дереве были удалены, текущим сделаем следующий за rNode:
         if (rDelta < 0) and (Succ(rNode) < Total) then
          pm_SetCurrent(Succ(rNode))
         else
          pm_SetCurrent(Current);
        l3FillChar(f_TreeModifiedData, SizeOf(f_TreeModifiedData), 0);
        if (l_OldCurrent <> nil) and
           not l_OldCurrent.IsSame(GetCurrentNode) then
         DoCurrentChanged(Current, Current);
       end;//lCur >= 0
      finally
       l_OldCurrent := nil;
      end;//try..finally
      TreeStruct.CursorTop;
     end;//not f_SaveRootNode.IsSame(l_Root)
    end;//l_Root = nil
   finally
    l_Root := nil;
   end;//try..finally
  end;//f_SaveRootNode = nil
 finally
  f_SaveRootNode := nil; // почистили, чтобы не висело лишних ссылок
  f_SaveCurrentNode := nil;
 end;//try..finally 

 if f_WaitingCountChanged then
 begin
  f_WaitingCountChanged := False;
  DoCountChanged(Total);
 end;//f_WaitingCountChanged
 inherited;
//#UC END# *48BD5F8303C4_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoChanged

procedure TvtCustomOutliner.Paint(const CN: Il3Canvas);
//#UC START# *48C6C044025E_4CFFBEEA0109_var*
var
 l_TopIndent : Integer;
 I           : Integer;
 IR          : TRect;
 Clip        : TRect;
 Last        : Integer;
 CNode       : Il3SimpleNode;
 LL          : LongInt;
 l_HalfInterRowIndent : Integer;

 procedure lpDrawLine(p1, p2: TPoint; aDotted : Boolean = True);
 var
  lNeedDraw: Boolean;
  i: Integer;
  x, y: Integer;
  dx, dy, dMax: Integer;

  //tot: Integer;
 begin
  with CN.Canvas do
   if aDotted then
   begin
    x := p1.x;
    y := p1.y;

    dx := Abs(p2.x - p1.x);
    dy := Abs(p2.y - p1.y);

    dMax := Max(dx,dy);

    if dMax = 0 then
     Exit;

    dx := dx div dMax;
    dy := dy div dMax;

    for i := ((x+y) mod 2) to dMax do
    begin
     if f_EvenScrolled then
      lNeedDraw := (i mod 2 = 0)
     else
      lNeedDraw := (i mod 2 <> 0);

     if lNeedDraw then
      Polyline([Point(x,y), Point(x+1,y+1)]);
     inc(x, dx);
     inc(y, dy);
    end;
   end else
    Polyline([p1,p2]);
 end;

 procedure DrawItem(N : LongInt; Row : Integer);
    {-Draw item N at Row}
 var
  CRFull       : Tl3SRect;
  CR           : Tl3SRect;
  l_LineTopAdd : Integer;
  l_NP         : Il3NodePainter;
  S            : Tl3PCharLenPrim;
  ST           : Tl3PCharLenPrim;
  lTextBGColor : TColor;
  lItemBGColor : TColor;
  lR           : Tl3SRect;
  lRect        : TRect;
  ll3Rect      : Tl3Rect;

  l_Indent     : Integer;
  l_FullLineSelectionLeft: Integer;

  BMPX,
  BMPX2        : Word;

  GraphLen     : Word;
  l_CurImages  : TCustomImageList;
  lImageIndex  : Integer;

  lVJustify    : TvtVJustify;

  lSize        : TPoint;
  lRegion      : Tl3Region;
  {$IFDEF vtStandardOpenChip}
  lGrDec       : Integer;
  {$EndIF vtStandardOpenChip}
  lExtraLevel  : Integer;
  lMultipartText: Il3MultipartText;
  CRTemp       : Tl3SRect;
  l_S          : Tl3String;
  lEnabled     : Boolean;
  l_IsFocused  : Boolean;
  l_ChipMidX: Integer;
  l_ChipTopY: Integer;
  l_ChipBottomY: Integer;
  l_ChipMidY: Integer;
  l_LineX: Integer;
  l_LineMidY: Integer;
  lLen : Integer;
  aPointArray : array of TPoint;
  l_Ex : TRect;
  l_ImageVertOffset : Integer;
 begin
  {get bounding rectangle}
  {CR := ClientRect;
  CR.Top := Pred(Row)*RowHeight + GetTopIndent;
  CR.Bottom := CR.Top+RowHeight;}
  l_Ex := ExcludeRect;
  CRFull.R.WR := GetDrawRect(N);
  CR := CRFull;

  {do we have anything to paint}
  if not IntersectRect(IR, Clip, CR.R.WR) then
   Exit;

  CN.BackColor := Color;

  if (CRFull.Right = l_Ex.Left - 1) then
   CN.FillRect(l3SRect(l_Ex.Left - 1, CRFull.Top, l_Ex.Right + 1, CRFull.Bottom));

  Il3Canvas(CN).Font.AssignFont(Font);

  {assign colors to our canvas}
  CNode := GetNode(N);
  if CNode = nil then
   Exit;

  BMPX := DoOnGetItemIndent;
  GraphLen := GetItemTextIndent(N, IR.Bottom - IR.Top);
  l_Indent := DoOnGetItemIndentEx(N);

  Inc(CR.R.Left, l_Indent);

  if MultiStrokeItem then
   lVJustify := vt_vjTop
  else
   lVJustify := VJustify;

  l_IsFocused := False;
  DoOnGetItemStyle(N, CN.Font, lTextBGColor, lItemBGColor, lVJustify, l_IsFocused, l_ImageVertOffset);

  if IR.Left < (CR.Left + GraphLen) then
  begin
   l_FullLineSelectionLeft := RowHeight div 4 + DoOnGetItemIndent;

   if (voShowIcons in f_ViewOptions) then
   begin
    lImageIndex := DoOnGetItemImageIndex(N, l_CurImages);
    l_FullLineSelectionLeft := l_FullLineSelectionLeft + (l_CurImages.Width + (RowHeight div 4));
   end;
   if (PickedList) then
    l_FullLineSelectionLeft := l_FullLineSelectionLeft + (PickImages.Width + 2 * (RowHeight div 4));

   if NeedDrawSelectionOnItem(N) and FullLineSelect then
   begin
    CN.BackColor := lTextBGColor;
    CN.FillRect(l3SBounds(l_FullLineSelectionLeft, CR.Top, CR.Right, CR.Bottom - CR.Top))
   end;

   if (voShowOpenChip in f_ViewOptions) and
      (voShowItemEdgeLine in f_ViewOptions) then
    CN.BackColor := lItemBGColor
   else
    CN.BackColor := Color;

   if NeedDrawSelectionOnItem(N) and FullLineSelect then
    CN.FillRect(l3SBounds(CR.Left - l_Indent, CR.Top, l_FullLineSelectionLeft, CR.Bottom - CR.Top))
   else
    CN.FillRect(l3SBounds(CR.Left - l_Indent, CR.Top, GraphLen + l_Indent, CR.Bottom - CR.Top));

   //Inc(CR.Left,RowHeight div 4);
   //CN.Canvas.Pen.Color:=clGray;
   //CN.Canvas.Pen.Style := psDashDot;
   if (voShowLines in f_ViewOptions) then
   begin
    if (Row = 1) then
     l_LineTopAdd := InterRowIndent
    else
     l_LineTopAdd := 0;
    Inc(CR.R.Left, RowHeight div 4);
    CN.Canvas.Pen.Color := f_LineColor; //clGray;
    lExtraLevel := GetDrawLevel(CNode);
    LL := f_TreeStruct.GetLines(CNode);
    if not (voShowOpenChip in f_ViewOptions) and not (voShowRoot in f_ViewOptions) then
     LL := LL shr 1;
    l_LineMidY := CR.Top + RowHeight shr 1 + l_HalfInterRowIndent;
    l_LineX := CR.Left + BMPX shr 1;
    while (LL <> 0) do
    begin
     if ((LL and 1) <> 0) and not (((LL shr 1) = 0) and (lExtraLevel = 1) and
         f_TreeStruct.HasVisibleChildren(CNode) and (voShowOpenChip in f_ViewOptions)) then
      if ((LL shr 1) = 0) and (lExtraLevel = 1) then
      begin
       if f_TreeStruct.IsLastVis(CNode) then
       begin {Draw L}
        if N <> 0 then
        begin
         lpDrawLine(Point(l_LineX, CR.Top-l_LineTopAdd),Point(l_LineX, l_LineMidY));
         lpDrawLine(Point(l_LineX, l_LineMidY),Point(CR.Left + BMPX - 2, l_LineMidY));
        end;
       end
       else
       begin {Draw I-}
        if N = 0 then
         lpDrawLine(Point(l_LineX, l_LineMidY),Point(l_LineX, CR.Bottom))
        else
         lpDrawLine(Point(l_LineX, CR.Top-l_LineTopAdd),Point(l_LineX, CR.Bottom));
        lpDrawLine(Point(l_LineX, l_LineMidY),Point(CR.Left + BMPX - 2, l_LineMidY));
       end
      end
      else
      begin {Draw I}
       lpDrawLine(Point(l_LineX, CR.Top-l_LineTopAdd),Point(l_LineX, CR.Bottom));
      end;
      LL:=LL shr 1;
      Inc(CR.R.Left,BMPX);
      Dec(lExtraLevel);
      l_LineX := CR.Left + BMPX shr 1;
     end;

    Inc(CR.R.Left, (DoOnGetItemIndent * lExtraLevel));

    if (CR.Bottom - CR.Top > RowHeight + 2) and
       f_TreeStruct.HasVisibleChildren(CNode) and f_TreeStruct.IsExpanded(CNode) then {Draw I}
     begin
      lpDrawLine(Point(l_LineX, CR.Top + RowHeight + 2),Point(l_LineX, CR.Bottom));
     end;
   end
   else //if (voShowLines in f_ViewOptions)
    Inc(CR.R.Left, (DoOnGetItemIndent * GetDrawLevel(CNode)));

   CN.Canvas.Pen.Style := psSolid;
   if (voShowOpenChip in f_ViewOptions) and not (f_TreeStruct.IsRoot(CNode)) then {Draw +}
   begin
    BMPX2 := (BMPX shr 1) shl 1;
    if not (voShowLines in f_ViewOptions) then
     Inc(CR.R.Left, (RowHeight div 4));
    Dec(CR.R.Left,BMPX);

    if f_TreeStruct.HasVisibleChildren(CNode) then
     With CN.Canvas do
     begin
     {$IFDEF vtStandardOpenChip}
      if BMPX2 > 16 then
       BMPX2 := Max(16, (((BMPX*2) div 3) shr 1) shl 1);

      lR := CR;

      Inc(lR.R.Top, (BMPX-BMPX2) div 2 + l_HalfInterRowIndent);
      Inc(lR.R.Left, (BMPX-BMPX2) div 2);

      lGrDec := 3;

      if voShowLines in f_ViewOptions then
      begin
       if f_TreeStruct.ShowRoot or
          not((f_TreeStruct.IsRoot(CNode.Parent)) and f_TreeStruct.IsFirstVis(CNode)) then
       begin
        lpDrawLine(Point(lR.Left + BMPX2 div 2, CR.Top),
                   Point(lR.Left + BMPX2 div 2, lR.Top + lGrDec));
       end;//f_TreeStruct.ShowRoot..

       if not f_TreeStruct.IsLastVis(CNode) then
       begin
        lpDrawLine(Point(lR.Left + BMPX2 div 2, lR.Top - 2 + BMPX2),
                   Point(lR.Left + BMPX2 div 2, CR.Bottom));
       end;//not f_TreeStruct.IsLastVis(CNode)
      end;//voShowLines in f_ViewOptions
      CN.Canvas.Pen.Color := f_OpenChipBorderColor;
      MoveTo(lR.Left + lGrDec, lR.Top + lGrDec);
      LineTo(lR.Left + lGrDec, lR.Top + BMPX2 - lGrDec);
      LineTo(lR.Left + BMPX2 - lGrDec, lR.Top + BMPX2 - lGrDec);
      LineTo(lR.Left + BMPX2 - lGrDec, lR.Top + lGrDec);
      LineTo(lR.Left + lGrDec, lR.Top + lGrDec);

      if (voShowLines in f_ViewOptions) then
       lpDrawLine(Point(lR.Left - 2 + BMPX2, lR.Top + BMPX2 div 2),
                  Point(CR.Left     + BMPX , lR.Top + BMPX2 div 2));

      CN.Canvas.Pen.Color := f_OpenChipColor;//clBlack;
      MoveTo(lR.Left + 5         , lR.Top + BMPX2 div 2);
      LineTo(lR.Left - 4 + BMPX2 , lR.Top + BMPX2 div 2);

      if not f_TreeStruct.IsExpanded(CNode) then
      begin
       MoveTo(lR.Left + BMPX2 div 2, lR.Top + 5);
       LineTo(lR.Left + BMPX2 div 2, lR.Top - 4 + BMPX2 );
      end;//not f_TreeStruct.IsExpanded(CNode)
      CN.Canvas.Pen.Color := clGray;

     {$ELSE vtStandardOpenChip}

      l_ChipMidX := CR.Left + BMPX2 div 2;
      l_ChipTopY := CR.Top + 2 + l_HalfInterRowIndent;
      l_ChipBottomY := CR.Top - 2 + BMPX2 + l_HalfInterRowIndent;
      l_ChipMidY := CR.Top + BMPX2 div 2 + l_HalfInterRowIndent;

      if voShowLines in f_ViewOptions then
      begin
       if f_TreeStruct.ShowRoot or
          not((f_TreeStruct.IsRoot(CNode.Parent)) and f_TreeStruct.IsFirstVis(CNode)) then
        lpDrawLine(Point(l_ChipMidX, CR.Top), Point(l_ChipMidX, l_ChipTopY));

       if not f_TreeStruct.IsLastVis(CNode) then
        lpDrawLine(Point(l_ChipMidX, l_ChipBottomY), Point(l_ChipMidX, CR.Bottom));
      end;//voShowLines in f_ViewOptions

      MoveTo(l_ChipMidX           , l_ChipTopY);
      LineTo(CR.Left - 2 + BMPX2  , l_ChipMidY);
      LineTo(l_ChipMidX           , l_ChipBottomY);
      LineTo(CR.Left + 2          , l_ChipMidY);
      LineTo(l_ChipMidX           , l_ChipTopY);

      if (voShowLines in f_ViewOptions) then
       lpDrawLine(Point(CR.Left - 2 + BMPX2 , l_ChipMidY),
                  Point(CR.Left     + BMPX2 , l_ChipMidY));

      // рисуем "минус"
      MoveTo(CR.Left + 5         , l_ChipMidY);
      LineTo(CR.Left - 4 + BMPX2 , l_ChipMidY);

      if not f_TreeStruct.IsExpanded(CNode) then
      begin
       // делаем из "минуса" - "плюс"
       MoveTo(l_ChipMidX, CR.Top + 5 + l_HalfInterRowIndent);
       LineTo(l_ChipMidX, CR.Top - 4 + BMPX2  + l_HalfInterRowIndent);
      end;//not f_TreeStruct.IsExpanded(CNode)
     {$ENDIF vtStandardOpenChip}
     end;//With CN.Canvas
    Inc(CR.R.Left,BMPX);
   end;//(voShowOpenChip in f_ViewOptions) and not (f_TreeStruct.IsRoot(CNode))

   if (voShowIcons in f_ViewOptions) then
   begin
    //lImageIndex := DoOnGetItemImageIndex(N, l_CurImages);

    CN.BackColor := Color;

    if (lImageIndex >= 0) and (lImageIndex <> vtItemWithoutImage) then
    begin
     lR := CR;
     case lVJustify of
      vt_vjTop : lR.Top := lR.Top + l_HalfInterRowIndent;
      vt_vjBottom :
       lR.Top := lR.Bottom - l_CurImages.Height;
      vt_vjCenter :
       lR.Top := lR.Top + (lR.Bottom - lR.Top - l_CurImages.Height) div 2;
     end;//case lVJustify

     Inc(lR.R.Top, l_ImageVertOffset);

     DoOnGetItemImageState(N, lEnabled);

     l_CurImages.Draw(CN.Canvas, lR.Left, lR.Top, lImageIndex, lEnabled);
     Inc(CR.R.Left,l_CurImages.Width);
     Inc(CR.R.Left,RowHeight div 4);
    end;//(lImageIndex >= 0) and (lImageIndex <> vtItemWithoutImage)

    //Пустышку не рисуем, тем более она не заливается фоном
    //Inc(CR.Left,pm_GetImages.Width{l_CurImages.Width});
    //Inc(CR.Left,RowHeight div 4);
   end;//voShowIcons in f_ViewOptions

   {Draw Picked List}
   if PickedList and (N <= f_HighIndex) then
   begin
    lImageIndex := DoOnGetItemPickImage(N, l_CurImages);

    if IR.Left < (CR.Left + l_CurImages.Width + 2 * (RowHeight div 4)) then
    begin
     CN.BackColor := Color;
     CN.FillRect(l3SBounds(CR.Left, CR.Top,
                 l_CurImages.Width + 2 * (RowHeight div 4), CR.Bottom - CR.Top));

     l_CurImages.Draw(CN.Canvas,
                      CR.Left + RowHeight div 4,
                      CR.Top  + (RowHeight - l_CurImages.Height) shr 1,
                      lImageIndex,
                      True);
    end;//if IR.Left < (CR.Left + ...
    Inc(CR.R.Left, l_CurImages.Width + 2 * (RowHeight div 4));
   end;//if FPickedList and (N <= f_HighIndex) then
  end//if IR.Left < (CR.Left + GraphLen) then
  else
   Inc(CR.R.Left, GraphLen);
  //DoOnGetItemStyle(N, CN.Font, lTextBGColor, lItemBGColor, lVJustify);

  CN.BackColor := lTextBGColor;
  {clear InterRowIndent}
  if InterRowIndent > 0 then
  begin
   lR := CR;
   lR.Top := lR.Bottom - InterRowIndent;
   CN.FillRect(lR);
   Dec(CR.R.Bottom, InterRowIndent);
  end;//InterRowIndent > 0

  {get the AnsiString}
  l3AssignNil(S);
  lMultipartText := nil;
  l_S := nil;
  try
   if Supports(CNode, Il3MultipartText, lMultipartText) then
   begin
    l_S := CompileTabstopsFromMultipartText(lMultipartText);
    S := l_S.AsPCharLen;
   end//Supports(CNode, Il3MultipartText, lMultipartText)
   else
   begin
    if (N <= f_HighIndex) then
    begin
     if (CNode <> nil) then
      ST := CNode.Text
     else
      l3AssignNil(ST);
     if not l3IsNil(ST) and (f_HDelta < ST.SLen) then
      ST.S := ST.S + f_HDelta;
     S := ST; 
    end;//N <= f_HighIndex
   end;//Supports(CNode, Il3MultipartText, lMultipartText)

   {draw the AnsiString}
   if l3IsNil(S) then
    CN.FillRect(CR)
   else
   begin
    if f_SelfDrawNodes and Supports(CNode, Il3NodePainter, l_NP) then
    begin
     CN.FillRect(l3SRect(CR.Left, CR.Top, CR.Right{Left+2}, CR.Bottom));
     CN.PushWO;
     try
      CN.PushClipRect;
      try
       l_NP.PaintNode(CN,
                      CN.DR2LR(l3SRect(CR.Left+2, CR.Top + l_HalfInterRowIndent, CR.Right, CR.Bottom)),
                      0, 0, l_IsFocused);
      finally
       CN.PopClipRect;
      end;
     finally
      CN.PopWO;
     end;
    end
    else
    begin
     if (Header.Sections.Count > 0) and (lMultipartText <> nil) then
     begin
      CN.FillRect(CR);
      f_TabsFirstIndent := CR.Left;
      if MultiStrokeItem then
      begin
       CRTemp := CR;
       Inc(CRTemp.R.Left, 2);
       ll3Rect := CN.DR2LR(CRTemp);
       CN.TabbedMultilineTextOut(S, Tl3TabStops.Make(TSGetTabStopPos, True),
           ll3Rect, False, vt_TabbedMLOutGap);
      end//FMultiStrokeItem
      else
       CN.TabbedTextOut(l3SPoint(CR.Left+2, CR.Top), l3SRect(CR.Left, CR.Top, CR.Right, CR.Bottom),
           S, Tl3TabStops.Make(TSGetTabStopPos, True));
     end//Header.Sections.Count > 0
     else
      if MultiStrokeItem then
      //GetItemTextDim(aItemIndex : Integer) : TPoint;
      begin
       CN.FillRect(CR);
       lRect := CR.R.WR;
       Inc(lRect.Left, 2);
       Inc(lRect.Top, l_HalfInterRowIndent);
       CN.DrawText(S, lRect, vtMultiLineDrawTextFormat);
      end
      else
      begin
       lR := CR;
       lSize := GetItemTextDim(N);

       if lSize.Y < lR.Bottom - lR.Top then
       begin
        case lVJustify of
         //vt_vjTop :;
         vt_vjBottom :
          lR.Top := lR.Bottom - lSize.Y;
         vt_vjCenter :
          lR.Top := (lR.Top + lR.Bottom - lSize.Y) div 2;
        end;//case lVJustify

        lRegion := Tl3Region.Create;
        try
         lRegion.Rect := Tl3SRect(CR);
         lRegion.CombineRect(Tl3SRect(lR), RGN_DIFF);

         CN.BackColor := lItemBGColor;
         CN.FillRgn(lRegion);

        finally
         l3Free(lRegion);
        end;//try..finally
       end;//lSize.Y < lR.Bottom - lR.Top

       CN.BackColor := lTextBGColor;
       CN.FillRect(lR);
       Inc(lR.R.Left, 2);
       CN.DrawText(S, lR.R.WR, 0{vtMultiLineDrawTextFormat});
       //CN.ExtTextOut(l3SPoint(CR.Left+2, CR.Top), Tl3SRect(CR), l3PCharLen(S, -1, l_CodePage));
      end;//FMultiStrokeItem
    end;//f_SelfDrawNodes
   end;//Supports(CNode, Il3MultipartText, lMultipartText)
  finally
   l3Free(l_S);
  end;//try..finally

  if NeedDrawArrowSelection(N) and (voShowSelectAsArrow in f_ViewOptions) then
  begin
   lRegion := Tl3Region.Create;
   try
    with CRFull do
    begin
     lLen := ((Bottom - Top) {+1}) div 2;
     SetLength(aPointArray, 5);
     aPointArray[0] := Point(Right,          Top);
     aPointArray[1] := Point(Right,          Top + 2 * lLen + 1);
     aPointArray[2] := Point(Right-1 - lLen, Top + 2 * lLen + 1);
     aPointArray[3] := Point(Right-1,        Top + lLen);
     aPointArray[4] := Point(Right-1 - lLen, Top);
    end;
    lRegion.Rgn := Windows.CreatePolygonRgn(aPointArray[0], Length(aPointArray), ALTERNATE{WINDING});

    CN.BackColor := Color;
    CN.FillRgn(lRegion);
   finally
    l3Free(lRegion);
   end;//try..finally
  end;//(N = f_Current) and (voShowSelectAsArrow in f_ViewOptions)

  if (voShowItemEdgeLine in f_ViewOptions) AND
    (Row <> Last) then
  begin
   CN.Canvas.Pen.Color := clSilver{clGray};
   with CRFull.R.WR do
    lpDrawLine(Point(Left, Pred(Bottom)), Point(Right, Pred(Bottom)), False);
  end;//voShowItemEdgeLine in f_ViewOptions

  if (N = Current) and Focused then
  begin
   vlbDrawFocusRect(CN, Current);
   if SearchStr <> '' then
   begin
    f_CaretPoint := Point(CR.Left + 2, CR.Top);
    SetCaret;
   end;//SearchStr <> ''
  end;//(N = f_Current) and Focused
 end;

var
 CR : Tl3SRect;
//#UC END# *48C6C044025E_4CFFBEEA0109_var*
begin
//#UC START# *48C6C044025E_4CFFBEEA0109_impl*
 if csDestroying in ComponentState then
  Exit;

 {Exit if the updating flag is set}
 if InUpdating then
 begin
  if DoubleBuffered then
   with CN do
   begin
    Brush.Color := Color;
    FillRect(ClipRect);
   end;//with CN
  Exit;
 end;//InUpdating

 MakeTreeStructOnDraw;
 Wake;

 CheckParam;

 CN.Font.AssignFont(Font);
 {we will erase our own background}
 SetBkMode(hDC(CN.DC), TRANSPARENT);

 {get the client rectangle}
 {CR := ClientRect;}

 {get the clipping region}
 GetClipBox(hDC(CN.DC), Clip);

 {do we have a header?}
(*   if ShowHeader then
  begin
   CR := ClientRect;
   {$IFDEF WIN32}
   if IntersectRect(IR, Clip, Rect(CR.Left, CR.Top, CR.Right, RowHeight))
   {$ELSE WIN32}
   if IntersectRect(IR, Clip, Rect(CR.Left, CR.Top, CR.Right, RowHeight)) > 0
   {$ENDIF WIN32}
    then vlbDrawHeader(CN);
  end;*)

 //MakeDrawPoints;

 { blank area  and above first item}
 l_TopIndent := GetTopIndent;
 if (InterRowIndent > 0) then
 begin
  CR.R.WR := ClientRect;
  CR.Bottom := l_TopIndent;
  CR.Top := CR.Bottom - InterRowIndent;
  CN.BackColor := Color;
  CN.FillRect(CR);
 end;//if (InterRowIndent > 0) then

 l_HalfInterRowIndent := (InterRowIndent div 2);

 {calculate last visible item}
 Last := Rows;
 if Last > Total - TopIndex then
  Last := Total - TopIndex;
 {display each row}
 for I := 1 to Last do
  begin
   DrawItem(TopIndex + Pred(I), I);
  end;
 {paint any blank area below last item}
 CR.R.WR := ClientRect;
 if UseDrawPoints then
 begin
  if (DrawPoints <> nil) and (DrawPoints.Count > 0) then
   CR.Top := DrawPoints.Last;
  Inc(CR.R.Top, l_TopIndent);
 end
 else
  CR.Top := CompleteRowHeight * Last + l_TopIndent;

 if (CR.Top < ClientHeight) and ((TopIndex + Last - 1 = f_HighIndex) or (Total = 0)) and FooterVisible then
  CR.Top := DrawFooter(CN, CR.Top);

 if CR.Top < ClientHeight then
 begin
  CR.Bottom := ClientHeight;
  {clear the area}
  CN.BackColor := Color;
  CN.FillRect(CR);
 end;
 // это сделано для корректной отрисовки хинтов,
 // которые берут шрифт из контрола (vtMultilineHint)
 CN.Font.AssignFont(Font);

 if IsTreeAssign then
 begin
   // http://mdp.garant.ru/pages/viewpage.action?pageId=298680577 
   DisableAlignTopIndex := False;

   // Событие для производства замеров:
   if not f_IsFirstPaintWas then
   begin
    DoAfterFirstPaint;
    f_IsFirstPaintWas := True;
   end;
 end;
//#UC END# *48C6C044025E_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.Paint

procedure TvtCustomOutliner.Notification(AComponent: TComponent;
  Operation: TOperation);
//#UC START# *4F884378016A_4CFFBEEA0109_var*
//#UC END# *4F884378016A_4CFFBEEA0109_var*
begin
//#UC START# *4F884378016A_4CFFBEEA0109_impl*
 inherited;
 if (Operation = opRemove) then
 begin
  if (aComponent = TreeSource) then
   TreeSource := nil;
 end;//Operation = opRemove
//#UC END# *4F884378016A_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.Notification

function TvtCustomOutliner.pm_GetImages: TCustomImageList;
//#UC START# *514C7F9103BB_4CFFBEEA0109get_var*
//#UC END# *514C7F9103BB_4CFFBEEA0109get_var*
begin
//#UC START# *514C7F9103BB_4CFFBEEA0109get_impl*
 Result := nil;
 if voWithoutImages in ViewOptions then
  Exit;
 if (inherited pm_GetImages <> nil)
  then Result := inherited pm_GetImages
  else Result := vtResources.Images;
//#UC END# *514C7F9103BB_4CFFBEEA0109get_impl*
end;//TvtCustomOutliner.pm_GetImages

procedure TvtCustomOutliner.pm_SetImages(aValue: TCustomImageList);
//#UC START# *514C7F9103BB_4CFFBEEA0109set_var*
//#UC END# *514C7F9103BB_4CFFBEEA0109set_var*
begin
//#UC START# *514C7F9103BB_4CFFBEEA0109set_impl*
 inherited;
//#UC END# *514C7F9103BB_4CFFBEEA0109set_impl*
end;//TvtCustomOutliner.pm_SetImages

function TvtCustomOutliner.pm_GetSelectedCount: Integer;
//#UC START# *514C82280017_4CFFBEEA0109get_var*
//#UC END# *514C82280017_4CFFBEEA0109get_var*
begin
//#UC START# *514C82280017_4CFFBEEA0109get_impl*
 if Assigned(f_TreeStruct) then
  Result := TreeStruct.SelectCount
 else
  Result := 0;
//#UC END# *514C82280017_4CFFBEEA0109get_impl*
end;//TvtCustomOutliner.pm_GetSelectedCount

procedure TvtCustomOutliner.pm_SetTotal(aValue: LongInt);
//#UC START# *514C89A601FE_4CFFBEEA0109set_var*
//#UC END# *514C89A601FE_4CFFBEEA0109set_var*
begin
//#UC START# *514C89A601FE_4CFFBEEA0109set_impl*
 if (aValue <> Total) then
 begin
  if aValue < 0 then
    aValue := High(aValue);

  {set new item index}
  {SelectFirst := FTotal = 0;}
  InternalSetTotal(aValue);
  if csDestroying in ComponentState then
   Exit;
  if Total = 0 then
   SearchStr := '';
  ResetSelectArray;
  {reset high index}
  if Total = 0 then
   f_HighIndex := 0
  else
   f_HighIndex := Pred(Total);
  {reset horizontal offset}
  f_HDelta := 0;

  if not IsInChange and (Current >= Total) then
   if Total = 0 then
    InternalSetCurrent(-1)
   else
    Current := Pred(Total);

  if not FixAnchor then
   f_Anchor := Current;

  {reset selected item}
  (*
  if not ({f_LockSelectChange or} (csLoading in ComponentState) or (csDestroying in ComponentState)) then
   begin
    {AlignTopIndex;}
    {if FTopIndex > f_HighIndex - lRows + 1 then TopIndex := f_HighIndex - lRows + 1;}
    NewCurrent := f_Current;
    if NewCurrent < 0 then NewCurrent := 0;
    if NewCurrent >= FTotal then NewCurrent := Pred(FTotal);
    f_Current := -1;
    vlbSetCurrentPrim(NewCurrent);

    DoCountChanged(fTotal);

    AlignTopIndex;
   end;
  *)
  if not ((csLoading in ComponentState) or (csDestroying in ComponentState)) then
   AlignTopIndex;

  DoCountChanged(Total);

  Invalidate;
  {Repaint;}

  vlbInitScrollInfo;
 end;//aValue <> FTotal
//#UC END# *514C89A601FE_4CFFBEEA0109set_impl*
end;//TvtCustomOutliner.pm_SetTotal

function TvtCustomOutliner.IsNeedScrollBars: Boolean;
//#UC START# *5151AC21016D_4CFFBEEA0109_var*
//#UC END# *5151AC21016D_4CFFBEEA0109_var*
begin
//#UC START# *5151AC21016D_4CFFBEEA0109_impl*
 Result := ((Assigned(f_TreeStruct) and (f_TreeStruct.CountView > 0))
           or
           (Assigned(f_TreeSource) and (f_TreeSource.Tree.CountView > 0)));
//#UC END# *5151AC21016D_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.IsNeedScrollBars

function TvtCustomOutliner.IsHintNeededForAnElement(anIndex: Integer): Boolean;
//#UC START# *5151ADD102D9_4CFFBEEA0109_var*
var
 l_NodePainter: Il3NodePainter;
//#UC END# *5151ADD102D9_4CFFBEEA0109_var*
begin
//#UC START# *5151ADD102D9_4CFFBEEA0109_impl*
 if f_SelfDrawNodes and
    Supports(GetNode(anIndex), Il3NodePainter, l_NodePainter) then
  Result := l_NodePainter.HintSupported
 else
  Result := True;
 if Result then
  Result := inherited IsHintNeededForAnElement(anIndex);
//#UC END# *5151ADD102D9_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.IsHintNeededForAnElement

function TvtCustomOutliner.GetImagesStored: Boolean;
//#UC START# *5151AF3B039A_4CFFBEEA0109_var*
//#UC END# *5151AF3B039A_4CFFBEEA0109_var*
begin
//#UC START# *5151AF3B039A_4CFFBEEA0109_impl*
 Result := inherited GetImagesStored and (Images <> vtResources.Images);
//#UC END# *5151AF3B039A_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.GetImagesStored

function TvtCustomOutliner.DoOnGetItemIndent: Integer;
//#UC START# *5151AF650239_4CFFBEEA0109_var*
//#UC END# *5151AF650239_4CFFBEEA0109_var*
begin
//#UC START# *5151AF650239_4CFFBEEA0109_impl*
 if Assigned(f_OnGetItemIndent) then
  Result := f_OnGetItemIndent(Self)
 else
  Result := inherited DoOnGetItemIndent;
//#UC END# *5151AF650239_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoOnGetItemIndent

function TvtCustomOutliner.ItemOnScreen(OnlyWhole: Boolean): Integer;
//#UC START# *5151B1F30312_4CFFBEEA0109_var*
//#UC END# *5151B1F30312_4CFFBEEA0109_var*
begin
//#UC START# *5151B1F30312_4CFFBEEA0109_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=488026845
 if UseDrawPoints AND (Total <> f_TotalWhenCountedDrawPoints) then
 begin
  DropDrawPoints;
  pm_GetDrawPoints;
 end;
 Result := Inherited ItemOnScreen(OnlyWhole);
//#UC END# *5151B1F30312_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.ItemOnScreen

procedure TvtCustomOutliner.MakeDrawPoints(aDrawPoints: Tl3LongintList);
//#UC START# *5151B22F0281_4CFFBEEA0109_var*
var
 I          : LongInt;
 lHeightSum : Integer;
 l_Ok       : Boolean;
 l_Total    : LongInt;
//#UC END# *5151B22F0281_4CFFBEEA0109_var*
begin
//#UC START# *5151B22F0281_4CFFBEEA0109_impl*
 if not UseDrawPoints then
  Exit;
 f_DrawPointsCounted := False;
 try
  repeat
   l_Ok := True;
   I := TopIndex;
   lHeightSum := 0;
   aDrawPoints.Count := 0;

   l_Total := Total;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=488026845
   f_TotalWhenCountedDrawPoints := l_Total;
   while (I < l_Total) do
   begin
    Inc(lHeightSum, GetItemDim(I).Y + InterRowIndent);

    if f_DrawPointsCounted then
     // Если массив уже сбросили и рассчитали в процессе текущего рассчета
     break
    else
     if aDrawPoints = nil then
     begin
      // Если массив сбросили в процессе текущего рассчета
      l_Ok := False;
      break;
     end;

    aDrawPoints.Add(lHeightSum);
    if (lHeightSum >= ClientHeight - GetTopIndent) then
     Break;
    Inc(I);
   end; // while
  until l_Ok;
 finally
  f_DrawPointsCounted := True;
 end;//try..finally
//#UC END# *5151B22F0281_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.MakeDrawPoints

function TvtCustomOutliner.CalcTopIndex(aMaxVisItem: LongInt): LongInt;
//#UC START# *5151B2C70248_4CFFBEEA0109_var*
var
 Len : Integer;
 l_HalfIndent: Integer;
//#UC END# *5151B2C70248_4CFFBEEA0109_var*
begin
//#UC START# *5151B2C70248_4CFFBEEA0109_impl*
 Result := 0;
 if not UseDrawPoints or (aMaxVisItem <= 0) then
  Exit;

 l_HalfIndent := InterRowIndent div 2;
 Len := GetTopIndent + l_HalfIndent;

 if (aMaxVisItem = f_HighIndex) and FooterVisible then
  Len := Len + GetFooterDim.Y + InterRowIndent;

 Result := aMaxVisItem;
 Repeat
  Inc(Len, GetItemDim(Result).Y + l_HalfIndent);
  if (Len > ClientHeight) and (Result < aMaxVisItem) then
   Inc(Result);
  if Len >= ClientHeight then
   Break;
  Dec(Result);
  if Result < 0 then
  begin
   Result := 0;
   Break;
  end;
  Inc(Len, l_HalfIndent);
 until False;
//#UC END# *5151B2C70248_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.CalcTopIndex

function TvtCustomOutliner.NeedInitScrollInfoInvlbInitScrollInfo: Boolean;
//#UC START# *5152BAD2033B_4CFFBEEA0109_var*
//#UC END# *5152BAD2033B_4CFFBEEA0109_var*
begin
//#UC START# *5152BAD2033B_4CFFBEEA0109_impl*
 Result := f_SelfDrawNodes or inherited NeedInitScrollInfoInvlbInitScrollInfo;
//#UC END# *5152BAD2033B_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.NeedInitScrollInfoInvlbInitScrollInfo

procedure TvtCustomOutliner.VlbDrawFocusRect(const CN: Il3Canvas;
  Index: LongInt);
//#UC START# *5152BD3E036D_4CFFBEEA0109_var*
var
 CR : TRect;
//#UC END# *5152BD3E036D_4CFFBEEA0109_var*
begin
//#UC START# *5152BD3E036D_4CFFBEEA0109_impl*
 if (voDoNotShowFocusRect in f_ViewOptions) then
  Exit;
 if not Assigned(f_TreeStruct) or (Index < 0) then
  Exit;
 if FooterSelected then
  Exit;
 if Focused then
 begin
  CR := GetDrawRect(Index);
  if (CR.Right = 0) then
   Exit;
  CN.Font.AssignFont(Self.Font);
  Inc(CR.Left, GetItemTextIndent(Index, CR.Bottom - CR.Top));
  Inc(CR.Left, DoOnGetItemIndentEx(Index));
  CN.BackColor := Self.Color;
  CN.Font.ForeColor := clBlack;
  CN.Canvas.Brush.Color := ColorToRGB(Self.Font.Color) xor ColorToRGB(Self.Color);
  CN.DrawFocusRect(Tl3SRect(CR));
  CN.Font.AssignFont(Self.Font);
  CN.BackColor := Self.Color;
 end;//Focused
//#UC END# *5152BD3E036D_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.VlbDrawFocusRect

function TvtCustomOutliner.VlbItemHitTest(aIndex: Integer;
  const aPt: TPoint;
  fromScreen: Boolean = False): Byte;
//#UC START# *5152C09F00DB_4CFFBEEA0109_var*
var
 l_CurImages   : TCustomImageList;
 l_ShowIcon    : Boolean;
 lImageIndex  : LongInt;
 lGLen        : Integer;
 l_Pt         : TPoint;
 lNodeByIndex : Il3SimpleNode;
//#UC END# *5152C09F00DB_4CFFBEEA0109_var*
begin
//#UC START# *5152C09F00DB_4CFFBEEA0109_impl*
 Result := ihtNone;
 if (aIndex < 0) or (aIndex >= Total) then
  Exit;
 lNodeByIndex := GetNode(aIndex);
 if not Assigned(lNodeByIndex) then
  Exit;
 if fromScreen then
  l_Pt := ScreenToClient(aPt)
 else
  l_Pt := aPt;
 try
  lGLen := Ord((voShowLines in f_ViewOptions) or (voShowOpenChip in f_ViewOptions)) * (RowHeight div 4);
  lGLen := lGLen + DoOnGetItemIndent * (GetDrawLevel(lNodeByIndex)) + DoOnGetItemIndentEx(aIndex);

  if l_Pt.X < (lGLen - DoOnGetItemIndent * Ord(voShowOpenChip in f_ViewOptions)) then
   Result := ihtNone
  else
  begin
   if (voShowOpenChip in f_ViewOptions) and (l_Pt.X < lGLen) then
    Result := ihtOpenChip
   else
   begin
    l_ShowIcon := (voShowIcons in f_ViewOptions);

    if l_ShowIcon then
    begin
     lImageIndex := DoOnGetItemImageIndex(aIndex, l_CurImages);
     l_ShowIcon := (lImageIndex <> vtItemWithoutImage);
    end;

    if l_ShowIcon then
     Inc(lGLen, l_CurImages.Width + (RowHeight div 4));

    if l_Pt.X < lGLen then
     Result := ihtIcon
    else
    if PickedList and (l_Pt.X >= lGLen) and
       (l_Pt.X <= lGLen + (PickImages.Width + RowHeight div 4)) then
     Result := ihtPickIcon
    else
     Result := ihtText;
   end;
  end;
 except
  Result := ihtNone;
 end;
//#UC END# *5152C09F00DB_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.VlbItemHitTest

function TvtCustomOutliner.DoOnGetItem(Index: LongInt): Il3CString;
//#UC START# *5152C3EC011B_4CFFBEEA0109_var*
var
 l_Node : Il3SimpleNode;
//#UC END# *5152C3EC011B_4CFFBEEA0109_var*
begin
//#UC START# *5152C3EC011B_4CFFBEEA0109_impl*
 Result := nil;
 if (f_TreeStruct <> nil) then
 begin
  l_Node := TreeStruct.Nodes[Index];
  if (l_Node <> nil) then
   Result := l3CStr(l_Node);
 end;//f_TreeStruct <> nil
//#UC END# *5152C3EC011B_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoOnGetItem

function TvtCustomOutliner.DoOnGetItemPickImage(aItemIndex: LongInt;
  var aImages: TCustomImageList): Integer;
//#UC START# *5152C5EF02BC_4CFFBEEA0109_var*
 function GetImageIndex : Byte;
 var
  lFlags : Integer;
 begin//GetImageIndex
  lFlags := TreeStruct.Flags[aItemIndex];

  if (MultiSelect and l3TestMask(lFlags, nfSelected)) or
     (not Multiselect and (aItemIndex = Current)) then
   Result := 1
  else
  if l3TestMask(lFlags, nfChildSelected) and
     not l3TestMask(lFlags, nfExpanded)
     {not TreeStruct.IsExpanded(N)} then
   Result := 3
  else
   Result := 0;
 end;//GetImageIndex
//#UC END# *5152C5EF02BC_4CFFBEEA0109_var*
begin
//#UC START# *5152C5EF02BC_4CFFBEEA0109_impl*
 aImages := vtResources.Images;
 if aItemIndex < 0 then // Index не спрашивали
  Result := -1
 else
  Result := vt_imgListUnCheck + GetImageIndex + vt_PickIconCnt*Ord(l3CRTIC.NearestColor(Color) = clWhite);

 if Assigned(OnGetItemPickImage) then
  OnGetItemPickImage(Self, aItemIndex, aImages, Result);
//#UC END# *5152C5EF02BC_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoOnGetItemPickImage

procedure TvtCustomOutliner.DoOnGetItemFont(Index: LongInt;
  const aFont: Il3Font;
  anItemPart: TvtListerItemPart);
//#UC START# *5152C7D50201_4CFFBEEA0109_var*
var
 lBackColor : TColor;
 lVJustify  : TvtVJustify;
 l_Focused  : Boolean;
 l_ImageVertOffset : Integer;
//#UC END# *5152C7D50201_4CFFBEEA0109_var*
begin
//#UC START# *5152C7D50201_4CFFBEEA0109_impl*
 l_Focused := False;
 l_ImageVertOffset := 0;
 DoOnGetItemStyle(Index, aFont, lBackColor, lBackColor, lVJustify, l_Focused, l_ImageVertOffset);
//#UC END# *5152C7D50201_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoOnGetItemFont

function TvtCustomOutliner.DoOnIsSelected(Index: LongInt): Integer;
//#UC START# *5152C8300174_4CFFBEEA0109_var*
//#UC END# *5152C8300174_4CFFBEEA0109_var*
begin
//#UC START# *5152C8300174_4CFFBEEA0109_impl*
 if csDesigning in ComponentState then
  Result := 0
 else
 begin
  if (Total < 0) then
   Result := 0
  else
  begin
   if MultiSelect then
    Result := Ord(TreeStruct.Select[Index])
   else
    Result := Ord(Index = Current);

   if Assigned(OnIsSelected) then
    OnIsSelected(Self, Index, Result);
  end;
 end;
//#UC END# *5152C8300174_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoOnIsSelected

procedure TvtCustomOutliner.DoOnSelect(Index: LongInt;
  aValue: Integer);
//#UC START# *5152C85403DA_4CFFBEEA0109_var*
var
 l_TreeWithLocks: Il3TreeWithLockRebuild;
//#UC END# *5152C85403DA_4CFFBEEA0109_var*
begin
//#UC START# *5152C85403DA_4CFFBEEA0109_impl*
 if not MultiSelect or (not Assigned(f_TreeStruct)) then
  Exit;

 if (csDesigning in ComponentState) or
    ((Index < 0) and (Index <> vt_smAllInvert) and (Index <> vt_smAllSelect)) or (Index >= Total) then
  Exit;

 if Supports(TreeStruct, Il3TreeWithLockRebuild, l_TreeWithLocks) then
  l_TreeWithLocks.LockRebuild; // это нужно, чтоб не перестраивалось дерево после OnSelectChange
                               // http://mdp.garant.ru/pages/viewpage.action?pageId=458074761
 try
  if not PickedList then
   ChangeNotifyOff;
  try
   if (aValue = -1) then
   begin
    aValue := Succ(SelectState[Index]);
    if aValue > Succ(Ord(TriplePicked)) then
     aValue := 0;
   end;//aValue = -1

   if Assigned(OnSelectChange) and (Index >= 0) then
    //!!!! если SelectAll, то заморочки с невозможностью селектирования некоторых элементов не учитываются
   begin
    OnSelectChange(Self,Index, aValue);
    if aValue < 0 then
     Exit;
   end;//Assigned(FOnSelectChange) and (Index >= 0)

   if Assigned(OnSelect) then
   begin
    OnSelect(Self, Index, aValue);
   end
   else
   begin
    case Index of
     vt_smAllInvert :
      TreeStruct.SelectAllNodes(sbInvert);
     vt_smAllSelect :
     begin
      if (aValue <> 0) then
       TreeStruct.SelectAllNodes(sbSelect)
      else
       TreeStruct.SelectAllNodes(sbDeselect);
     end;//vt_smAllSelect
     else
     begin
      {if Assigned(FOnSelectChange) then FOnSelectChange(Self,Index, aValue);}
      if (TreeStruct.Select[Index] <> Boolean(aValue)) then
      begin
       TreeStruct.Select[Index] := Boolean(aValue);
       InvalidateItem(Index);
      end//TreeStruct.Select[Index] <> Boolean(aValue)
      else
       Exit;
     end;//else
    end; //case
   end;//Assigned(FOnSelect)
   if Assigned(OnSelectChanged) then
    OnSelectChanged(Self,Index, aValue);
  finally
   if not PickedList then
    ChangeNotifyOn(False);
  end;//try..finally
 finally
  if Assigned(l_TreeWithLocks) then
   l_TreeWithLocks.UnlockRebuild;
 end;
//#UC END# *5152C85403DA_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoOnSelect

procedure TvtCustomOutliner.DoOnSelectOutRange(First: LongInt;
  Last: LongInt;
  aSelectState: Integer);
//#UC START# *5152C88400DC_4CFFBEEA0109_var*
var
 I : LongInt;
//#UC END# *5152C88400DC_4CFFBEEA0109_var*
begin
//#UC START# *5152C88400DC_4CFFBEEA0109_impl*
 if ReadOnly or
    FixAnchor or
    not MultiSelect then
  Exit;

 if (First > Last) then
 begin
  I := First;
  First := Last;
  Last := I;
 end;//First > Last

 if (First < 0) then
  First:=0;
 if (Last > f_HighIndex) then
  Last := f_HighIndex;

 if not Assigned(OnSelect) and
    not Assigned(OnSelectChange) and
    not Assigned(OnSelectChanged) and
    Assigned(f_TreeStruct) then
 begin
   if not PickedList then
    ChangeNotifyOff;
   try
    if (aSelectState = 0) then
     f_TreeStruct.SelectInterval(First, Last, sbDeselect, not PickedList)
    else
     f_TreeStruct.SelectInterval(First, Last, sbSelect, not PickedList);
    // Warning! Здесь не посылается нотификация элементам дерева
    // об изменении выделения !!!
   finally
    if not PickedList then
     ChangeNotifyOn(False);
   end;//try..finally
 end//not Assigned(FOnSelect)..
 else
 begin
  if not PickedList then
  begin
   for I := 0 to Pred(First) do
    Selected[I] := (aSelectState = 0);
   for I := Succ(Last) to f_HighIndex do
    Selected[I] := (aSelectState = 0);
  end;//not PickedList
  for I := First to Last do
   SelectState[I] := aSelectState;
 end;//not Assigned(FOnSelect)..
//#UC END# *5152C88400DC_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoOnSelectOutRange

function TvtCustomOutliner.DoDoProcessCommand(Cmd: Tl3OperationCode): Boolean;
//#UC START# *5152C93400EB_4CFFBEEA0109_var*
var
 lStartMove  : Boolean;
 CNode       : Il3Node;
 lSaveMoveParent : Il3SimpleNode;
 lUserParam  : Pointer;

  procedure StartMove;
  begin//StartMove
   lStartMove := f_NodeInMove = nil;
   if lStartMove then
   begin
    f_NodeInMove := CNode;
    lSaveMoveParent := CNode.Parent;
    f_NodeInMove.BeginMove(lUserParam);
   end;
  end;//StartMove

  procedure DoMove;
  var
   Msg: TMsg;
  begin//DoMove
  {$IfNDef DesignTimeLibrary}
   with Application do
   begin
    repeat
     try
      {$IfDef l3HackedVCL}
      HandleMessage(Msg);
      {$Else}
      HandleMessage;
      {$EndIf}
      if ((Msg.Message = WM_KEYUP) or (Msg.Message = WM_SYSKEYUP))
                  and (GetAsyncKeyState(vk_Menu) >= 0) then
       begin
        f_NodeInMove.EndMove(lUserParam);
        if Assigned(f_OnNodeMoveEnd) then
         f_OnNodeMoveEnd(Self, CNode, CNode.Parent <> lSaveMoveParent);
        f_NodeInMove := nil;
        Break;
       end;
     except
      HandleException(Self);
     end;
    until Terminated;
   end;
  {$EndIf}
  end;//DoMove
var
 SNode       : Il3SimpleNode;
 lNewCurrent : Integer;

 lSrchResult : Integer;
 ltmpStr     : AnsiString;
//#UC END# *5152C93400EB_4CFFBEEA0109_var*
begin
//#UC START# *5152C93400EB_4CFFBEEA0109_impl*
 lStartMove := False;
 try
  if (Cmd in cAllOutlinerCommand) then
  begin
   Result := true;

   if not Assigned(f_TreeStruct) or
      not (Cmd in f_LegalOperations) then
   begin
    Result := False;
    Exit;
   end;

   CNode := CurrentCNode;
   SNode := GetCurrentNode;
   lNewCurrent := Current;

   {TreeCursor.CNode^.Flags:=TreeStruct.CNode^.Flags and not nfSelected;}
   try
    case Cmd of
     ccDel :
      begin
       if MultiSelect then
        CTree.DeleteSelectedNodes
       else
        if CNode <> nil then
         CNode.Delete;
      end;

     ccTreeExpand:
      if not TryExpandNode(SNode, not f_TreeStruct.IsExpanded(SNode), True) then
       raise ESkipOperation.Create('');

     ccTreeCollapse:
      if not TryExpandNode(SNode, False, True) then
       raise ESkipOperation.Create('');

     ccTreeAllExpand :
      begin
       ExpandNodeOnDeep;
       lNewCurrent := Current; //работает процедура удержания текущего в Changing/Changed
      end;

     ccMoveLeft :
      begin
       StartMove;
       if (MultiSelect and CTree.MoveSelectedNodes(dLeft)) or
          (not MultiSelect and CTree.MoveNode(CNode, dLeft)) then
        lNewCurrent := CTree.GetIndex(CNode);
      end;

     ccMoveRight :
      begin
       StartMove;
       if (MultiSelect and CTree.MoveSelectedNodes(dRight)) or
          (not MultiSelect and CTree.MoveNode(CNode, dRight)) then
        lNewCurrent := CTree.GetIndex(CNode);
      end;

     ccMoveUp :
      begin
       StartMove;
       if TreeStruct.MoveNode(CNode, dUp) then
        lNewCurrent := TreeStruct.GetIndex(CNode);
      end;

     ccmoveDown :
      begin
       StartMove;
       if TreeStruct.MoveNode(CNode, dDown) then
        lNewCurrent := TreeStruct.GetIndex(CNode);
      end;

     ccLeft :
      begin
       if (SNode = nil) or
          (SNode.Parent = nil) then
        raise ESkipOperation.Create('');

       if f_TreeStruct.IsExpanded(SNode) then
        TryExpandNode(SNode, False)
       else
       begin
        if (TreeStruct.RootNode.IsSame(SNode.Parent) and
           not TreeStruct.ShowRoot) then
        raise ESkipOperation.Create('');

        Dec(lNewCurrent, TreeStruct.GetIndex(SNode, SNode.Parent));
       end; 
      end;

     ccRight :
      begin
       if (SNode = nil) or
          not TreeStruct.HasVisibleChildren(SNode) then
        raise ESkipOperation.Create('');

       if f_TreeStruct.IsExpanded(SNode) then
        Inc(lNewCurrent)
       else
        if not TryExpandNode(SNode, True, True) then
         raise ESkipOperation.Create('');
      end;

     ccFastFindNext :
      begin
       ltmpStr := SearchStr;
       CharToItem(Self, ltmpStr, True, lSrchResult);
       if lSrchResult = -1 {not Finded} then
        SearchStr := ''
       else
       begin
        if (lSrchResult = Current) then
         SetCaret
        else
         if (lSrchResult >= 0) and
            (lSrchResult <= f_HighIndex) then
          begin
           Inc(f_InQuickSearch);
           try
            pm_SetCurrent(lSrchResult);
            lNewCurrent := lSrchResult;
           finally
            Dec(f_InQuickSearch);
           end;
          end;
         end;
      end;
    end;

    if not PickedList then vlbDeselectAllItems;
    pm_SetCurrent(lNewCurrent);

    //Invalidate;
   except
   end;
  end else
   Result := False;

  if not Result then
   Result := inherited DoDoProcessCommand(Cmd);
 finally
  if lStartMove then
  begin
   DoMove;
   Result := true;
  end;//lStartMove
 end;
//#UC END# *5152C93400EB_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoDoProcessCommand

procedure TvtCustomOutliner.DoCountChanged(aCount: LongInt);
//#UC START# *5152CCBA007C_4CFFBEEA0109_var*
//#UC END# *5152CCBA007C_4CFFBEEA0109_var*
begin
//#UC START# *5152CCBA007C_4CFFBEEA0109_impl*
 if (csDestroying in ComponentState) then Exit;
 if Assigned(OnCountChanged) then
 begin
  if not IsInChange then
  // - если попадаем сюда "миллионы раз", вне скобок Changing/Changed то идём читать:
  //    http://mdp.garant.ru/pages/viewpage.action?pageId=259883587&focusedCommentId=261982042&#comment-261982042
  //if (FUpdateCount <= 1) then
   OnCountChanged(Self, aCount)
  else
   f_WaitingCountChanged := true;
 end;//Assigned(FOnCountChanged)
//#UC END# *5152CCBA007C_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.DoCountChanged

function TvtCustomOutliner.GetHint(anIndex: Integer): Il3CString;
//#UC START# *5152CE76012B_4CFFBEEA0109_var*
var
 l_Node : Il3SimpleNode;
//#UC END# *5152CE76012B_4CFFBEEA0109_var*
begin
//#UC START# *5152CE76012B_4CFFBEEA0109_impl*
 l_Node := TreeStruct.Nodes[anIndex];
 if (l_Node = nil) then
  Result := nil
 else
  Result := l3CStr(l_Node);
//#UC END# *5152CE76012B_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.GetHint

function TvtCustomOutliner.UseDrawPoints: Boolean;
//#UC START# *5152CFA002C3_4CFFBEEA0109_var*
//#UC END# *5152CFA002C3_4CFFBEEA0109_var*
begin
//#UC START# *5152CFA002C3_4CFFBEEA0109_impl*
 Result := MultiStrokeItem
           or f_SelfDrawNodes
           or (voVariableItemHeight in f_ViewOptions)
           or Assigned(OnGetItemHeight);
//#UC END# *5152CFA002C3_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.UseDrawPoints

procedure TvtCustomOutliner.InvalidateItem(Index: LongInt);
//#UC START# *5155852A01C2_4CFFBEEA0109_var*
var
 CR : TRect;
//#UC END# *5155852A01C2_4CFFBEEA0109_var*
begin
//#UC START# *5155852A01C2_4CFFBEEA0109_impl*
 if InUpdating or not Assigned(f_TreeStruct) or not HandleAllocated then
  Exit;
 if (Index >= TopIndex) and (Index - TopIndex < Rows) then
 begin
  CR := GetDrawRect(Index);
  //CN := GetNode(Index);
  //if (not PickedList) {and (lBMPDimension.X > 0) and (CN <> nil)}
  // then
  //  Inc(CR.Left,GetNodeTextIndent(CN));
  Windows.InvalidateRect(Handle, @CR, True);
 end;
//#UC END# *5155852A01C2_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.InvalidateItem

function TvtCustomOutliner.GetItemTextIndent(Index: LongInt;
  aTextBoxHeight: Integer): Integer;
//#UC START# *515585B90316_4CFFBEEA0109_var*
var
 l_CurImages  : TCustomImageList;
 l_Node       : Il3SimpleNode;
 l_ShowIcon   : Boolean;
 l_DrawLevel  : Integer;
 l_NodePainter: Il3NodePainter;
 l_Canvas: Il3InfoCanvas;
//#UC END# *515585B90316_4CFFBEEA0109_var*
begin
//#UC START# *515585B90316_4CFFBEEA0109_impl*
 Result := 0;

 l_Node := GetNode(Index);
 if (l_Node = nil) then
  Exit;

 l_ShowIcon := (voShowIcons in f_ViewOptions);

 if l_ShowIcon then
  l_ShowIcon := (DoOnGetItemImageIndex(Index, l_CurImages) <> vtItemWithoutImage);

 l_DrawLevel := GetDrawLevel(l_Node);
 //if not(voShowLines in f_ViewOptions) then Dec(l_DrawLevel);
 //l_CurImages := pm_GetImages;

 Result := Ord((voShowLines in f_ViewOptions) or
  (voShowOpenChip in f_ViewOptions)) * (RowHeight div 4) +
  (DoOnGetItemIndent * l_DrawLevel);
 if l_ShowIcon then
  Result := Result + (l_CurImages.Width + (RowHeight div 4));
 if (PickedList) then
  Result := Result + (PickImages.Width + 2 * (RowHeight div 4));
 if f_SelfDrawNodes and Supports(l_Node, Il3NodePainter, l_NodePainter) then
 begin
  l_Canvas := l3CrtIC;
  l_Canvas.Font.AssignFont(Font);
  Result := Result + l_Canvas.LP2DP(l3Point(l_NodePainter.GetItemTextIndent(l_Canvas, l_Canvas.DP2LP(l3SPoint(0, aTextBoxHeight)).Y),0)).X;
 end;
//#UC END# *515585B90316_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.GetItemTextIndent

function TvtCustomOutliner.GetItemDim(aItemIndex: Integer): TPoint;
//#UC START# *51558620037C_4CFFBEEA0109_var*
var
 l_CurImages : TCustomImageList;
//#UC END# *51558620037C_4CFFBEEA0109_var*
begin
//#UC START# *51558620037C_4CFFBEEA0109_impl*
 Result := GetItemTextDim(aItemIndex);
 Inc(Result.X, GetItemTextIndent(aItemIndex, Result.Y));
 // ^ http://mdp.garant.ru/pages/viewpage.action?pageId=100007969
 Result.Y := Max(Result.Y, RowHeight);
 if (voVariableItemHeight in f_ViewOptions) then
 begin
  if (DoOnGetItemImageIndex(aItemIndex, l_CurImages) <> vtItemWithoutImage) then
   Result.Y := Max(l_CurImages.Height, Result.Y);
 end;//if (voVariableItemHeight in f_ViewOptions) then
 if Assigned(f_OnGetItemHeight) then
  Result.Y := Max(f_OnGetItemHeight(Self, aItemIndex, Result.Y), Result.Y);
 if (voShowSelectAsArrow in f_ViewOptions) then
  if not Odd(Result.Y) then
   Inc(Result.Y);
//#UC END# *51558620037C_4CFFBEEA0109_impl*
end;//TvtCustomOutliner.GetItemDim

//#UC START# *515DA5860015impl*
//#UC END# *515DA5860015impl*

initialization
{$If not defined(NoScripts)}
// Регистрация TvtSimpleOutliner
 TtfwClassRef.Register(TvtSimpleOutliner);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация TvtCustomOutliner
 TtfwClassRef.Register(TvtCustomOutliner);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация TvtOutliner
 TtfwClassRef.Register(TvtOutliner);
{$IfEnd} //not NoScripts

end.