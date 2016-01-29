unit fcdbtreeview;
{
//
// Components : TfcDBTreeView
//
// Copyright (c) 1999 by Woll2Woll Software
//
// 5/25/99 - RSW - Fix BorderStyle=bsNone bug where horizontal scrollbar and
//           buttons drawn in wrong position
// 6/22/99 - RSW - Support way to disable Up/Down tree buttons
// 6/22/99 - RSW - Add Select All method
// 7/4/99 -  Fire OnKeyDown event
// 7/26/99 - RSW - Support Builder notation for datasources
}
interface

{$i fcIfDef.pas}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, db, dbtables, commctrl, stdctrls, extctrls, fccommon, fccanvas,
  fcdbcommon, buttons, fcscrollbar, fcshapebtn, fcbutton, fcimager, fcchangelink
  {$ifdef fcDelphi4Up}, ImgList{$endif};

type
  TfcDBCustomTreeView = class;
  TfcTreeHitTest = (fchtdOnButton, fchtdOnStateIcon, fchtdOnImageIcon, fchtdOnText,
                    fchtdOnActiveNode);
  TfcTreeHitTests = set of TfcTreeHitTest;
  TfcTreeDataLink = class(TDataLink)
  private
    FTree: TfcDBCustomTreeView;
  protected
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    procedure ActiveChanged; override;
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create(ATree: TfcDBCustomTreeView);
    destructor Destroy; override;
  end;

  TfcMultiSelectItem = class
     Bookmark: TBookmark;
     DataSet: TDataSet;
  end;

  TfcDBMultiSelectAttributes = class(TPersistent)
  private
     FEnabled: Boolean;
     FAutoUnselect: boolean;
     FMultiSelectLevel: integer;
     FMultiSelectCheckbox: boolean;
     TreeView: TfcDBCustomTreeView;
     procedure SetEnabled(val: boolean);
     procedure SetMultiSelectLevel(val: integer);
     procedure SetMultiSelectCheckBox(val: boolean);

  public
     constructor Create(Owner: TComponent);
     procedure Assign(Source: TPersistent); override;

  published
     property AutoUnselect : boolean read FAutoUnselect write FAutoUnselect default False;
     property Enabled: boolean read FEnabled write SetEnabled default False;
     property MultiSelectLevel: integer read FMultiSelectLevel write SetMultiSelectLevel default 0;
     property MultiSelectCheckbox: boolean read FMultiSelectCheckbox write SetMultiSelectCheckbox default True;
  end;

  TfcDBTreeViewOption = (
     dtvoKeysScrollLevelOnly,
     dtvoAutoExpandOnDSScroll,
     dtvoExpandButtons3D,
     dtvoHideSelection,
     dtvoRowSelect, dtvoShowNodeHint, dtvoShowButtons,
     dtvoShowLines, dtvoShowRoot, dtvoShowHorzScrollBar,
     dtvoShowVertScrollBar, dtvoHotTracking);

  TfcDBTreeViewOptions = set of TfcDBTreeViewOption;

  TfcDBTreeNode = class
    protected
     HasPrevSibling: boolean;
     HasNextSibling: boolean;
    public
     ActiveRecord: integer;
     DataLink: TfcTreeDataLink;

     Text: string;
     Level: integer;
     DataSet: TDataSet;
     Field: TField;
     Expanded: boolean;
     HasChildren: boolean;
     Parent: TfcDBTreeNode;
     ImageIndex: integer;
     StateIndex: integer;
     Selected: boolean;
     Hot: boolean;
     MultiSelected: boolean;

     function GetFieldValue(FieldName: string): Variant;
  end;


  TfcDBTreeEvent = procedure(TreeView: TfcDBCustomTreeView;
      Node: TfcDBTreeNode) of object;

  TfcDBTreeMouseEvent = procedure(TreeView: TfcDBCustomTreeView;
      Node: TfcDBTreeNode;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer) of object;

  TfcDBTreeMouseMoveEvent = procedure(TreeView: TfcDBCustomTreeView;
      Node: TfcDBTreeNode;
      Shift: TShiftState; X, Y: Integer)of object;

  TfcDBTreeDrawTextEvent = procedure (TreeView: TfcDBCustomTreeview;
    Node: TfcDBTreeNode; ARect: TRect;
    var DefaultDrawing: boolean) of object;

  TfcDBCustomTreeView = class(TWinControl)
  private
    FOptions: TfcDBTreeViewOptions;
    FDisplayFields: TStrings;
    FBorderStyle: TBorderStyle;
    FOnCalcNodeAttributes: TfcDBTreeEvent;
    FOnChange: TfcDBTreeEvent;
    FOnUserExpand: TfcDBTreeEvent;
    FOnUserCollapse: TfcDBTreeEvent;
    FMultiSelectAttributes: TfcDBMultiSelectAttributes;
    FOnMouseDown, FOnMouseUp, FOnDblClick: TfcDBTreeMouseEvent;
    FOnMouseMove: TfcDBTreeMouseMoveEvent;
    FLevelIndent : integer;
    FDataSourcesMiddle: string;
    FImager: TfcCustomImager;

    FMultiSelectList: TList;
    FImages: TCustomImageList;
    FStateImages: TCustomImageList;
    FLineColor: TColor;
    FInactiveFocusColor: TColor;
    FScrollWithinLevel: boolean;

    FDataLinks: TList;

    FCanvas: TControlCanvas;
    FPaintCanvas: TfcCanvas;
    FPaintBitmap: TBitmap;
//    InChange, InFetchData, InScroll: boolean;
//    SkipSetTop: boolean;
    SkipErase, SkipReload: boolean;
    FFirstDataLink, FLastDataLink: TfcTreeDataLink;
    FActiveDataSet: TDataSet;
    FLastVisibleDataset: TDataSet;
    ActiveDataSetChanged: boolean;
    ActiveNodeIndex: integer;
    HintTimer: TTimer;
    HintTimerCount: integer;
    LastHintRow: integer;

    Nodes: TList;
    RowHeight : integer;
    FixedOffset : integer;
    CacheSize : integer;
    FActiveNode: TfcDBTreeNode;
    MaxTextWidth: integer;
    ResetScroll: boolean;

    Down: boolean;     { Used by MouseLoop}
    MouseRow: integer; { Used by MouseLoop}
    PaintingRow: integer;
    FOnDrawText: TfcDBTreeDrawTextEvent;
    SaveCursor: TCursor;
    CheckMaxWidth: boolean; { Set to True to force wmpaint to check horzscrollbar }
    CheckMaxWidthGrow: boolean; { Set to True to force wmpaint to check horzscrollbar }
    InPaint: boolean;
    InComputeHorzWidthOnly : boolean;
    FChangeLink: TfcChangeLink;
    NodesCleared: boolean;
    HaveBadLink: boolean; { True if DataSources property is referencing external form that has not been created yet }
    {$ifdef fcDelphi4Up}
    FHideUpDownButtons: boolean;
    procedure SetHideUpDownButtons(val: boolean);
    {$endif}

    function GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
    function GetLastDataSource: TDataSource;
    procedure SetLastDataSource(Value: TDataSource);
    procedure SetDataSources(Value: String);
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CMExit(var Message: TMessage); message CM_EXIT;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBkgnd;
//    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
//    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
//    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;

    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure TreeDownClick(Sender : TObject);
    procedure TreeUpClick(Sender : TObject);
    Function GetParentDataLink(Dataset: TDataset): TfcTreeDataLink;
    Function GetChildDataLink(Dataset: TDataset): TfcTreeDataLink;
    Procedure MouseToRow(X, Y: integer; var Row: integer);
    function RowToNode(Row: integer; var Node: TfcDBTreeNode): boolean;
//    function NodeToIndex(Node: TfcDBTreeNode): integer;
    function NodeToRow(Node: TfcDBTreeNode; var Row: integer): boolean;
    procedure SetBorderStyle(Value: TBorderStyle);
    Function GetCenterPoint(ARect: TRect): TPoint;
    procedure ResetStartOffsets(ActiveDataSet: TDataSet);
    Function GetStartOffset: integer;
    Procedure SetStartOffset(ActiveDataSet: TDataSet; val: integer);
    procedure SetImages(Value: TCustomImageList);
    procedure SetStateImages(Value: TCustomImageList);
    function UseStateImages(Node: TfcDBTreeNode): Boolean;
    function GetMultiSelectItem(Index: integer): TfcMultiSelectItem;
    procedure HintTimerEvent(Sender: TObject);
    function GetMultiSelectListCount: integer;
    Function GetStateImageWidth: integer;
    procedure ScrollRight;
    procedure ScrollLeft;
    procedure SetLineColor(Value: TColor);
    procedure SetInactiveFocusColor(Value: TColor);
    procedure SetOptions(Value: TfcDBTreeViewOptions);
    Function GetStartX(Node: TfcDBTreeNode): integer;
    procedure SetDisplayFields(Value: TStrings);
    procedure UpdateScrollBarPosition;
    procedure SetLevelIndent(val: integer);
    procedure SetImager(Value: TfcCustomImager);
    procedure ImagerChange(Sender: TObject);
    procedure FreeRootBookmark;

  protected
    HintWindow: THintWindow;
    LastActiveBookmark, FirstBookmark: TBookmark;
    ScrollSize: integer;
    HotTrackRow: integer;
    FMouseInControl : boolean;
    SkipFreeNodes: boolean;
    OldNodes: TList;
    HorzScrollBar, VertScrollBar: TfcScrollBar;
    UpTreeButton, DownTreeButton: TfcShapeBtn;
    StartOffsets: Array[0..50] of integer;
    RootDataSetBookmark: TBookmark;

    {$ifdef fcDelphi4Up}
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    {$endif}

    Function IsRootDataSetMoved: boolean; virtual;
    procedure CreateWnd; override;
    procedure UpdateScrollBar; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure PaintButton(Node: TfcDBTreeNode;
              pt: TPoint; Size: integer; Expanded: Boolean); virtual;
    procedure PaintLines(Node: TfcDBTreeNode); virtual;
    procedure PaintImage(Node: TfcDBTreeNode); virtual;
    procedure DataChanged(DataSet: TDataSet); virtual;
    procedure Scroll(DataSet: TDataSet; Distance: Integer); virtual;
    procedure LinkActive(DataSet: TDataSet; Value: Boolean); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DoCalcNodeAttributes(Node: TfcDBTreeNode); virtual;

    Function InMasterChanging(DataSet: TDataSet): boolean; virtual;
    procedure RefreshDataLinks(FirstDS, LastDS: TDataSource); virtual;
    procedure Notification(AComponent: TComponent;
         Operation: TOperation); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    Function LevelRect(Node: TfcDBTreeNode): TRect;
    Function TextRect(Node: TfcDBTreeNode; Row: integer): TRect;
    Function MultiSelectCheckboxNeeded(Node: TfcDBTreeNode): boolean;
    function ValidMultiSelectLevel(ALevel: Integer): Boolean;
    Function FindCurrentMultiSelectIndex(DataSet: TDataSet): integer; virtual;
    procedure LayoutChanged; virtual;
    procedure Loaded; override;
    procedure FreeHintWindow; virtual;
    Function CreateHintWindow: THintWindow; virtual;

    procedure Change(FSelected: TfcDBTreeNode); virtual;
    Procedure SaveIfFirstRecordBookmark(DataSet: TDataSet);
    Procedure FreeFirstBookmark;
    Procedure FreeLastActiveBookmark;
    Function HaveValidDataLinks: boolean;
    function IsChildDataSetOfActive(DataSet: TDataSet): boolean;
    function IsMasterDataSetOfActive(DataSet: TDataSet): boolean;
    Procedure ToggleMultiSelection(
       RequireControlKey: boolean; Shift: TShiftState);
    procedure MouseLoop(X, Y: Integer); virtual;

    function UpdateDataLinkToActive(Node: TfcDBTreeNode): boolean;
    procedure PriorRow(WithinLevel: boolean); virtual;
    procedure NextRow(WithinLevel: boolean); virtual;
    procedure PriorPage(WithinLevel: boolean); virtual;
    procedure NextPage(WithinLevel: boolean); virtual;
    function GetClientRect: TRect; override;
    procedure VScroll(ScrollCode: integer; Position: integer); virtual;
    procedure HScroll(ScrollCode: integer; Position: integer); virtual;
    function CreateUpTreeButton: TfcShapeBtn; virtual;
    function CreateDownTreeButton: TfcShapeBtn; virtual;
    procedure DoDrawText(TreeView: TfcDBCustomTreeView;
         Node: TfcDBTreeNode; ARect: TRect;
         var DefaultDrawing: boolean); virtual;
    procedure WndProc(var Message: TMessage); override;
    procedure FreeOldNodes;
    procedure DoUserExpand(Node: TfcDBTreeNode); virtual;
    procedure DoUserCollapse(Node: TfcDBTreeNode); virtual;
    procedure SetActiveDataSet(DataSet: TDataSet); virtual;
    procedure SetLastVisibleDataSet(DataSet: TDataSet); virtual;
    Function GetDataLink(Dataset: TDataset): TfcTreeDataLink;
    Function GetDataLinkIndex(Dataset: TDataset): integer;
  public
    Patch: Variant;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MoveTo(Node: TfcDBTreeNode);
    function GetHitTestInfoAt(X, Y: Integer): TfcTreeHitTests;
    procedure UnselectAll; virtual;
    {$ifdef fcDelphi4Up}
    procedure SelectAll(ADataSet: TDataSet); virtual;
    {$endif}
    procedure SelectRecord; virtual;
    procedure UnselectRecord; virtual;
    Function IsSelectedRecord: boolean;
    procedure InvalidateNode(Node: TfcDBTreeNode);
    procedure InvalidateRow(Row: integer);
    procedure InvalidateClient; virtual;
    procedure Expand(Node: TfcDBTreeNode); virtual;
    procedure Collapse(Node: TfcDBTreeNode); virtual;
    procedure MakeActiveDataSet(DataSet: TDataSet; Collapse: boolean);
    Function GetNodeAt(X,Y: integer): TfcDBTreeNode;
    procedure SortMultiSelectList;

    property ActiveNode: TfcDBTreeNode read FActiveNode;
    property Canvas : TfcCanvas read FPaintCanvas;
    property MultiSelectList[Index: Integer]: TfcMultiSelectItem read GetMultiSelectItem;
    property MultiSelectListCount : integer read GetMultiSelectListCount;
    property ActiveDataSet : TDataSet read FActiveDataSet write SetActiveDataSet;
    property LastVisibleDataSet: TDataSet read FLastVisibleDataSet write SetLastVisibleDataSet;

//  published
    property LevelIndent : integer read FLevelIndent write SetLevelIndent;
    property LineColor: TColor read FLineColor write SetLineColor default clBtnShadow;
    property InactiveFocusColor: TColor read FInactiveFocusColor write SetInactiveFocusColor default clBtnFace;
    property ParentColor default False;
    property BorderStyle : TBorderStyle read FBorderStyle write SetBorderStyle;
    property DataSourceFirst: TDataSource read GetDataSource write SetDataSource;
    property DataSourceLast: TDataSource read GetLastDataSource write SetLastDataSource;
    property DataSources: String read FDataSourcesMiddle write SetDataSources;
    property Options: TfcDBTreeViewOptions read FOptions write SetOptions default
          [dtvoAutoExpandOnDSScroll,
           dtvoShowButtons, dtvoShowNodeHint, dtvoShowLines, dtvoShowRoot, dtvoShowHorzScrollBar,
           dtvoShowVertScrollBar];
    property DisplayFields: TStrings read FDisplayFields write SetDisplayFields;
    property Images: TCustomImageList read FImages write SetImages;
    property Imager: TfcCustomImager read FImager write SetImager;
    property StateImages: TCustomImageList read FStateImages write SetStateImages;
    property MultiSelectAttributes: TfcDBMultiSelectAttributes
        read FMultiSelectAttributes write FMultiSelectAttributes;
    property OnCalcNodeAttributes: TfcDBTreeEvent read FOnCalcNodeAttributes
             write FOnCalcNodeAttributes;
    property OnChange: TfcDBTreeEvent read FOnChange write FOnChange;
    property OnUserCollapse: TfcDBTreeEvent read FOnUserCollapse write FOnUserCollapse;
    property OnUserExpand: TfcDBTreeEvent read FOnUserExpand write FOnUserExpand;
    property OnDblClick: TfcDBTreeMouseEvent read FOnDblClick write FOnDblClick;
    property OnMouseDown: TfcDBTreeMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TfcDBTreeMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TfcDBTreeMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnDrawText: TfcDBTreeDrawTextEvent read FOnDrawText write FOnDrawText;
    {$ifdef fcDelphi4Up}
    property HideUpDownButtons: boolean read FHideUpDownButtons write SetHideUpDownButtons default False;
    {$endif}
  end;

  TfcDBTreeView = class(TfcDBCustomTreeView)
  published
    property Align;
    property BorderStyle;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property TabStop default True;
    property TabOrder;
    property Visible;

    {$ifdef fcDelphi4Up}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property ParentBiDiMode;
    {$endif}

    property DataSourceFirst;
    property DataSourceLast;
    property DataSources;
    property DisplayFields;
//    {$ifdef fcDelphi4Up}
//    property HideUpDownButtons;
//    {$endif}
    property Imager;
    property InactiveFocusColor;
    property LineColor;
    property Options;

    {$ifdef fcDelphi4Up}
    property OnStartDock;
    property OnEndDock;
    {$endif}
    property LevelIndent;
    property Images;
    property StateImages;
    property MultiSelectAttributes;
    property PopupMenu;
    property OnCalcNodeAttributes;
    property OnChange;
    property OnUserCollapse;
    property OnUserExpand;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;
    property OnDrawText;
  end;


implementation

uses
  BDE { To resolve CmpBkmkRslt type }
  {$IfDef fcDelphi6Up}
  ,
  Variants
  {$EndIf fcDelphi6Up}
  ; 

constructor TfcTreeDataLink.Create(ATree: TfcDBCustomTreeView);
begin
  inherited Create;
  FTree := ATree;
end;

procedure TfcTreeDataLink.RecordChanged(Field: TField);
begin
  if (Field<>Nil) and (Dataset.State in [dsEdit, dsInsert]) then
  begin
    FTree.invalidateClient;
  end;
end;

procedure TfcDBCustomTreeView.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    if (FBorderStyle = bsSingle) then
    begin
       Style := Style and not WS_BORDER;
       ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
  end;
end;

destructor TfcTreeDataLink.Destroy;
begin
  inherited Destroy;
end;

procedure TfcTreeDataLink.DataSetChanged;
begin
  FTree.DataChanged(self.dataset);
end;

procedure TfcTreeDataLink.DataSetScrolled(Distance: Integer);
begin
  FTree.Scroll(self.dataset, Distance);
end;

type

TfcTreeVertScrollBar = class(TfcScrollBar)
  protected
    procedure Scroll(ScrollCode: integer; Position: integer); override;
end;

TfcTreeHorzScrollBar = class(TfcScrollBar)
  protected
    procedure Scroll(ScrollCode: integer; Position: integer); override;
end;

constructor TfcDBCustomTreeView.Create(AOwner: TComponent);
var i: Integer;
begin
  inherited;
  CacheSize:= 1;
  FDataLinks:= TList.create;
  FFirstDataLink:= TfcTreeDataLink.create(self);
  FLastDataLink:= TfcTreeDataLink.create(self);
  FFirstDataLink.BufferCount := CacheSize;
  FLastDataLink.BufferCount := CacheSize;
  Nodes:= TList.create;
  OldNodes:= TList.create;
  FPaintBitmap:= TBitmap.create;
  FPaintCanvas:= TfcCanvas(FPaintBitmap.Canvas);
  FOptions:=
     [dtvoAutoExpandOnDSScroll, dtvoShowButtons, dtvoShowNodeHint,
      dtvoShowLines, dtvoShowRoot, dtvoShowHorzScrollBar,
      dtvoShowVertScrollBar];
  FBorderStyle:= bsSingle;
  for i:= 0 to 50 do StartOffsets[i]:= 0;
  LevelIndent := 21;
  LevelIndent:= 19; { Seems to be more consistent with TTreeView. Find out when 21
                      is better }
  FixedOffset := 1;
  RowHeight:= 16;
  HintTimer:= TTimer.create(self);

  FMultiSelectAttributes:= TfcDBMultiSelectAttributes.create(self);
  FMultiSelectList:= TList.create;

  HotTrackRow:= -1;
  Width := 121;
  Height := 97;
  Color:= clWindow;
  ParentColor:= False;
  FLineColor:= clBtnShadow;
  FInactiveFocusColor:= clBtnFace;
  FDisplayFields:= TStringList.create;

  VertScrollBar:= TfcTreeVertScrollBar.create(self);
  VertScrollBar.Kind:= sbVertical;
  VertScrollBar.Width:= GetSystemMetrics(SM_CXVSCROLL);

  VertScrollBar.parent:= self;

  HorzScrollBar:= TfcTreeHorzScrollBar.create(self);
  HorzScrollBar.Kind:= sbHorizontal;
  HorzScrollBar.Height:= GetSystemMetrics(SM_CXVSCROLL);
  HorzScrollBar.Max:= 5;
  HorzScrollBar.PageSize:= 10;
  HorzScrollBar.visible:= false;
  HorzScrollBar.parent:= self;
  HorzScrollBar.SmallChange:= 10;
  HorzScrollBar.ContinuousDrag:= True;

  UpTreeButton:= CreateUpTreeButton;
  DownTreeButton:= CreateDownTreeButton;

  FScrollWithinLevel:= True;
  FChangeLink := TfcChangeLink.Create;
  FChangeLink.OnChange := ImagerChange;
  TabStop:= True;

end;

destructor TfcDBCustomTreeView.Destroy;
var i: integer;
begin
   FChangeLink.Free;
   VertScrollBar.Free;
   VertScrollBar:= nil;

   for i:= 0 to Nodes.count-1 do TfcDBTreeNode(Nodes[i]).Free;
   Nodes.Free;
   FreeOldNodes;
   OldNodes.Free;
   for i:= 0 to FDataLinks.count-1 do begin
      if FDataLinks[i]=FFirstDataLink then continue;
      if FDataLinks[i]=FLastDataLink then continue;
      TfcTreeDataLink(FDataLinks[i]).Free;
   end;
   FMultiSelectList.Free;
   FMultiSelectAttributes.Free;

   FFirstDataLink.Free;
   FLastDataLink.Free;
   FDataLinks.Free;
   HintTimer.Free;
   FreeFirstBookmark;
   FreeLastActiveBookmark;
   FDisplayFields.Free;
   FPaintBitmap.Free;
   FCanvas.Free;

   FreeRootBookmark;
   inherited Destroy;
end;

procedure TfcDBCustomTreeView.FreeRootBookmark;
begin
  {$ifdef fcdelphi4up}
  if RootDataSetBookmark<>Nil then FreeMem(RootDataSetBookmark);
  RootDataSetBookmark:= nil;
  {$else}
  if RootDataSetBookmark<>Nil then StrDispose(RootDataSetBookmark);
  RootDataSetBookmark:= nil;
  {$endif}
end;


procedure TfcTreeDataLink.ActiveChanged;
begin
  if (DataSource=FTree.DataSourceFirst) or (DataSource=FTree.DataSourceLast) then
     FTree.RefreshDataLinks(FTree.DataSourceFirst, FTree.DataSourceLast);
  FTree.LinkActive(Dataset, Active);
end;

function TfcDBCustomTreeView.GetDataSource: TDataSource;
begin
    Result := FFirstDataLink.DataSource
end;

function TfcDBCustomTreeView.GetLastDataSource: TDataSource;
begin
    Result := FLastDataLink.DataSource
end;

{type
  TwwGetWordOption = (wwgwSkipLeadingBlanks, wwgwQuotesAsWords, wwgwStripQuotes,
                      wwgwSpacesInWords);
  TwwGetWordOptions = set of TwwGetWordOption;
  strCharSet = Set of char;

Function wwGetWord(s: string; var APos: integer;
         Options: TwwGetWordOptions; DelimSet: strCharSet): string;
var i: integer;

   Function max(x,y: integer): integer;
   begin
     if x>y then result:= x
     else result:= y;
   end;

   Procedure StripQuotes;
   begin
      if not (wwgwStripQuotes in Options) then exit;
      if (Result[1]='"') or (Result[1]='''') then
         if (Result[length(Result)] = '"') or
            (Result[length(Result)] = '''') then
            Result:= copy(Result, 2, length(Result)-2)
         else
            Result:= copy(Result, 2, length(Result)-1);
   end;

begin
   result:= '';
   if APos<=0 then exit;
   if APos>length(s) then exit;

   i:= APos;
   if (wwgwSkipLeadingBlanks in Options) then
   begin
      while (i<=length(s)) and ((s[i]=' ') or (s[i]=#9)) do inc(i);
      APos:= i;
   end;

   if (wwgwQuotesAsWords in Options) then
   begin
      if s[i]='"' then begin
         inc(i);
         while (i<=length(s)) and (s[i]<>'"') do inc(i);
         if s[i]='"' then begin
            result:= copy(s, APos, i+1-APos);
            APos:= i+1;
         end
         else if (i>length(s)) then begin
            result:= copy(s, APos, length(s));
            APos:= length(s)+1;
         end;
         StripQuotes;
         exit;
      end
   end;

   if wwgwSpacesInWords in Options then
   begin
      while (i<=length(s)) and (s[i] in [#32..#255]) do begin
         if (s[i] in DelimSet) then break
         else inc(i);
      end
   end
   else begin
      while (i<=length(s)) and (s[i] in [#33..#255]) do begin
         if (s[i] in DelimSet) then break
         else inc(i);
      end
   end;

   result:= copy(s, APos, max(i-APos, 1));

   if length(result)>1 then APos:= i
   else APos:= i+1;

end;
}
procedure TfcDBCustomTreeView.RefreshDataLinks(FirstDS, LastDS: TDataSource);
var i:integer;
    FDataLink: TfcTreeDataLink;
    tempDS, curDS: TDataSource;
    index, tempIndex: integer;
    token: string;
    OldLinks: TList;

   { Retrieve TDataSource with the name of the datasource }
   Function DataSourceFromToken(DataSourceName: string): TDataSource;
   var Component: TComponent;
       token1, token2: string;
   begin
      result:= nil;
      if (pos('.', DataSourceName)<=0) and
         (pos('->', DataSourceName)<=0) then
      begin
         Component:= GetParentForm(self).FindComponent(DataSourceName);
      end
      else begin
         token1:= fcGetToken(DataSourceName, '.', 0);
         token2:= fcGetToken(DataSourceName, '.', 1);
         Component:= FindGlobalComponent(token1);
         if Component<>nil then
            Component:= Component.FindComponent(token2);

         if Component=nil then { 7/25/99 - Builder notation }
         begin
           token1:= fcGetToken(DataSourceName, '->', 0);
           token2:= fcGetToken(DataSourceName, '->', 1);
           Component:= FindGlobalComponent(token1);
           if Component<>nil then
              Component:= Component.FindComponent(token2);
         end
      end;
      if Component is TDataSource then
         result:= TDataSource(Component);
   end;

   Function GetDataLink(curDS: TDataSource): TfcTreeDataLink;
   var i: integer;
   begin
      for i:= 0 to OldLinks.count-1 do begin
         if TfcTreeDataLink(OldLinks[i]).DataSource = curDS then
         begin
             result:= OldLinks[i];
             OldLinks.Delete(i);  { Remove from list so that its not destroyed later }
             exit;
         end
      end;
      result:= TfcTreeDataLink.Create(Self);
   end;


begin
   if csDestroying in ComponentState then exit;
   
   OldLinks:= TList.Create;
   try
     for i:= 0 to FDataLinks.count-1 do begin
        if (FDataLinks[i]<>FFirstDataLink) and
           (FDataLinks[i]<>FLastDataLink) then
         OldLinks.Add(FDataLinks[i]);
     end;

     if ((LastDS=nil) or (LastDS.DataSet=nil)) and (DataSources='') then
     begin
        { Clearing datasource }
        if FDataLinks.Count>0 then invalidate;
        FDataLinks.Clear;
        exit;
     end;

     FDataLinks.Clear;

     if FFirstDataLink.DataSet<>nil then
     begin
        FDataLinks.Add(FFirstDataLink);
        FFirstDataLink.BufferCount := CacheSize;
        index:= 1;
     end
     else index:= 0;

     if FFirstDataLink.Dataset<>FLastDataLink.DataSet then
     begin
        FDataLinks.Add(FLastDataLink);
        FLastDataLink.BufferCount := CacheSize;
     end;

     if (DataSources='') then begin
       { 3/2/99 - Special case of only one level so don't add any more datalinks}
       if FFirstDataLink.Dataset=FLastDataLink.DataSet then exit;

       try
          curDS:= LastDS;
          repeat
             tempDS:= fcGetControlMasterSource(curDS.dataset);
             if tempDS=nil then
                tempDS:= fcGetControlDataSource(curDS.dataset);
             curDS:= tempDS;

             if (curDS<>FirstDS) and (curDS<>nil) then
             begin
                FDataLink:= GetDataLink(curDS);
                FDataLink.BufferCount := CacheSize;
                FDataLink.DataSource := curDS;
                FDataLinks.Insert(index, FDataLink);
             end
          until (curDS=FirstDS) or (curDS=nil);
       finally
       end
     end
     else begin
        HaveBadLink:= False;

        tempIndex:= 0;
        repeat
           token:= fcGetToken(DataSources, ';', tempIndex);
           curDS:= DataSourceFromToken(token);
           if (curDS=nil) and
              ((pos('.', token)>0) or (pos('->', token)>0)) then { 7/25/99 - Suppport Builder notation }
                 HaveBadLink:= True;

           if (curDS<>nil) and (curDS<>FirstDS) and (curDS<>LastDS) then
           begin
              FDataLink:= TfcTreeDataLink.Create(Self);
              FDataLink.BufferCount := CacheSize;
              FDataLink.DataSource := curDS;
              FDataLinks.Insert(index, FDataLink);
              inc(index);
           end;
           inc(tempIndex);
        until token = '';
     end;
  finally
     for i:= 0 to OldLinks.Count-1 do TfcTreeDataLink(OldLinks[i]).Free;
     OldLinks.Free;
  end
end;

procedure TfcDBCustomTreeView.SetDataSource(Value: TDataSource);
begin
  FFirstDataLink.Datasource:= Value;
  RefreshDataLinks(Value, FLastDataLink.DataSource);

  { Initialize other data links }
  if (Value<>nil) and (Value.DataSet<>nil) then
     LinkActive(Value.DataSet, Value.Dataset.Active);
end;

procedure TfcDBCustomTreeView.SetDataSources(Value: String);
begin
  if Value<>FDataSourcesMiddle then
  begin
     FDataSourcesMiddle:= Value;
     RefreshDataLinks(FFirstDataLink.DataSource, FLastDataLink.DataSource);
     if not HaveValidDataLinks then invalidate;
  end
end;

procedure TfcDBCustomTreeView.SetLastDataSource(Value: TDataSource);
begin
  FLastDataLink.Datasource:= Value;
  RefreshDataLinks(FFirstDataLink.DataSource, Value);

  { Initialize other data links }
  if (Value<>nil) and (Value.DataSet<>nil) then
     LinkActive(Value.DataSet, Value.Dataset.Active);
end;

procedure TfcDBCustomTreeView.LinkActive(DataSet: TDataSet; Value: Boolean);
begin
  SaveIfFirstRecordBookmark(DataSet);
  if (FDataLinks.count>0) and (Dataset = TfcTreeDataLink(FDataLinks[0]).DataSet) then begin
     FreeRootBookmark;
     IsRootDataSetMoved;
  end;
  LayoutChanged;
  UpdateScrollBar;
end;

{ Return true if master node has changed }
{ This code is not implemented yet }
Function TfcDBCustomTreeView.InMasterChanging(DataSet: TDataSet): boolean;
begin
    if DataSet = DatasourceFirst.dataset then result:= False
    else result:= True;
end;

Function TfcDBCustomTreeView.IsRootDataSetMoved: boolean;
var TempRootDataSetBookmark: TBookmark;
   res: CmpBkmkRslt;
   RootDataSet: TDataSet;
begin
   result:= False;
   if FDataLinks.count<=0 then exit;
   RootDataSet:= TfcTreeDataLink(FDataLinks[0]).DataSet;
   if (RootDataSet=nil) then exit;
   if RootDataSet.state <> dsBrowse then exit;

   TempRootDataSetBookmark:= RootDataSet.GetBookmark;
   if TempRootDataSetBookmark=nil then exit;

   if RootDataSetBookmark=nil then begin
      RootDataSetBookmark:= TempRootDataSetBookmark;
      exit;
   end;

   res:= RootDataSet.CompareBookmarks(RootDataSetBookmark, TempRootDataSetBookmark);
   if (res=CMPKeyEql) or (res=CMPEql) then begin
      RootDataSet.FreeBookmark(TempRootDataSetBookmark);
      exit;
   end;
   result:= True;
   FreeRootBookmark;
   RootDataSetBookmark:= TempRootDataSetBookmark;
end;

procedure TfcDBCustomTreeView.DataChanged(DataSet: TDataSet);
var ChildDataLink: TfcTreeDataLink;
begin
  if FDataLinks.Count=0 then exit;
  
  if Dataset = TfcTreeDataLink(FDataLinks[0]).DataSet then begin
     SaveIfFirstRecordBookmark(DataSet);
     if IsRootDataSetMoved then
        ActiveDataSet:= DataSet;
     UpdateScrollBar;
  end
  else if FScrollWithinLevel then UpdateScrollBar;

  if dataset.state = dsBrowse then
  begin
     ChildDataLink:= GetChildDataLink(Dataset);
     if ChildDataLink<>nil then ResetStartOffsets(ChildDataLink.DataSet);
  end;
//     ResetStartOffsets(DataSet); { 12/23/98 }

  CheckMaxWidthGrow:= True;
  invalidateClient;

end;

Function TfcDBCustomTreeView.GetDataLinkIndex(Dataset: TDataset): integer;
var i:integer;
begin
   result:= -1;
   if DataSet =nil then exit;

   for i:= 0 to FDataLinks.count-1 do begin
      if TfcTreeDataLink(FDataLinks[i]).dataset = DataSet then
      begin
         result:= i;
         break;
      end
   end;
end;

Function TfcDBCustomTreeView.GetDataLink(Dataset: TDataset): TfcTreeDataLink;
var i:integer;
begin
   result:= nil;
   if DataSet =nil then exit;

   for i:= 0 to FDataLinks.count-1 do begin
      if TfcTreeDataLink(FDataLinks[i]).dataset = DataSet then
         result:= TfcTreeDataLink(FDataLinks[i]);
   end;
end;

Function TfcDBCustomTreeView.GetParentDataLink(Dataset: TDataset): TfcTreeDataLink;
var i:integer;
begin
   result:= nil;
   for i:= 0 to FDataLinks.count-1 do begin
      if TfcTreeDataLink(FDataLinks[i]).dataset = DataSet then
      begin
         if i>0 then
            result:= TfcTreeDataLink(FDataLinks[i-1]);
         break;
      end
   end;
end;

Function TfcDBCustomTreeView.GetChildDataLink(Dataset: TDataset): TfcTreeDataLink;
var i:integer;
begin
   result:= nil;
   for i:= 0 to FDataLinks.count-1 do begin
      if TfcTreeDataLink(FDataLinks[i]).dataset = DataSet then
      begin
         if (i+1)<=FDataLinks.count-1 then
            result:= TfcTreeDataLink(FDataLinks[i+1]);
         break;
      end
   end;
end;

procedure TfcDBCustomTreeView.Scroll(DataSet: TDataSet; Distance: Integer);
var DataLink: TfcTreeDataLink;
begin
  if not HandleAllocated then Exit;

  if FDataLinks.Count>0 then begin
     if Dataset = TfcTreeDataLink(FDataLinks[0]).DataSet then begin
        IsRootDataSetMoved;
        UpdateScrollBar;
     end
     else if FScrollWithinLevel then UpdateScrollBar;
  end;

  if IsChildDataSetOfActive(DataSet) then
  begin
     if (dtvoAutoExpandOnDSScroll in Options) then
        LastVisibleDataSet:= dataset;
  end
  else LastVisibleDataSet:= dataset;

  if ActiveDataSet<>DataSet then
  begin
     if (dtvoAutoExpandOnDSScroll in Options) then
        ActiveDataSet:= DataSet;
     DataLink:= GetChildDataLink(ActiveDataSet);
     if DataLink<>nil then begin
        ResetStartOffsets(DataLink.DataSet);
     end;
  end
  else begin
     DataLink:= GetChildDataLink(ActiveDataSet);
     if DataLink<>nil then ResetStartOffsets(DataLink.DataSet);
  end;

  SaveIfFirstRecordBookmark(DataSet);
  CheckMaxWidthGrow:= True;
  InvalidateClient;
end;

Procedure TfcDBCustomTreeView.SaveIfFirstRecordBookmark(DataSet: TDataSet);
begin
  if DataSet=nil then exit;
  if FDataLinks.Count>0 then
  begin
     if Dataset <> TfcTreeDataLink(FDataLinks[0]).DataSet then exit;

     if (DataSet.state = dsBrowse) and (DataSet.Bof) and (TfcTreeDataLink(FDataLinks[0]).DataSet = DataSet) then
     begin
         FreeFirstBookmark;
         FirstBookmark:= dataset.GetBookmark;
     end
  end;

  if DataSet.state in [dsEdit, dsInsert] then FreeFirstBookmark;

end;

Procedure TfcDBCustomTreeView.FreeFirstBookmark;
begin
     {$ifdef fcdelphi4up}
     if FirstBookmark<>Nil then FreeMem(FirstBookmark);
     FirstBookmark:= nil;
     {$else}
     if FirstBookmark<>Nil then StrDispose(FirstBookmark);
     FirstBookmark:= nil;
     {$endif}
end;

Procedure TfcDBCustomTreeView.FreeLastActiveBookmark;
begin
     {$ifdef fcdelphi4up}
     if LastActiveBookmark<>Nil then FreeMem(LastActiveBookmark);
     LastActiveBookmark:= nil;
     {$else}
     if LastActiveBookmark<>Nil then StrDispose(LastActiveBookmark);
     LastActiveBookmark:= nil;
     {$endif}
end;

procedure TfcDBCustomTreeView.DoCalcNodeAttributes(Node: TfcDBTreeNode);
begin
   if Assigned(FOnCalcNodeAttributes) then
      FOnCalcNodeAttributes(Self, Node);
end;


Function fcGetWord(s: string; var APos: integer; var IsFieldName: boolean): string;
var i: integer;

   Function max(x,y: integer): integer;
   begin
     if x>y then result:= x
     else result:= y;
   end;

begin
   result:= '';
   IsFieldName:= False;
   if APos<=0 then exit;
   if APos>length(s) then exit;

   i:= APos;
   if s[i]='"' then begin
      inc(i);
      while (i<=length(s)) and (s[i]<>'"') do inc(i);
      if s[i]='"' then begin
         result:= copy(s, APos+1, i-APos-1);
         IsFieldName:= True;
         APos:= i+1;
      end
   end
   else begin
      while (i<=length(s)) and (not (s[i] in ['"'])) do inc(i);
      result:= copy(s, APos, max(i-APos, 1));
      APos:= i;
   end;
end;

Function GetNodeText(
   DisplayFieldLine: string;
   DataSet: TDataSet;
   var Field: TField): string;
var line, word: string;
    APos: integer;
    isFieldName: boolean;
    curField: TField;
begin
  line:= '';
  APos:= 1;
  Field:= nil;
  repeat
      word:= fcGetWord(DisplayFieldLine, APos, isFieldName);
      if (word<>'') then begin
         if IsFieldName then
         begin
            curField:= dataset.findfield(word);
            if curField<>nil then
            begin
               if curField.datatype=ftMemo then
                 line:= line + curField.asString
               else
                 line:= line + curField.DisplayText;
               if Field=nil then Field:= curField;
            end
            else
               line:= line + '<Field not found ' + word + '>'
         end
         else begin
            if pos('"', DisplayFieldLine)>0 then
               line:= line + word
            else begin
               curField:= dataset.findfield(word);
               if curField=nil then
                  line:= line + ' <Field not found ' + word + '> '
               else begin
                  if curField.datatype=ftMemo then
                    line:= line + dataset.fieldbyname(word).asString
                  else line:= line + dataset.fieldbyname(word).DisplayText;

                  if Field=nil then Field:= curField;
               end
            end
         end
      end
  until (word='');
  result:= line;
end;

procedure TfcDBCustomTreeView.WMPaint(var Message: TWMPaint);
var
    Node: TfcDBTreeNode;
    NextDataLink: TfcTreeDataLink;
//    Flags: integer;
    FocusRect, R: TRect;
    i: Integer;
    ActiveNode: boolean;
    PrevActiveRecord: integer;
    sp: TPoint;
    NewMaxTextWidth : integer;
    UpdateRect: TRect;
    FActiveBookmark: TBookmark;
    res: CmpBkmkRslt;
    NewNode: boolean;
    DefaultDrawing: boolean;
    MousePos: TPoint;
    OrigCheckMaxWidth: boolean;

     procedure ScanDataLink(ParentNode: TfcDBTreeNode; DataLinkIndex: integer);
     var DataLink: TfcTreeDataLink;
         RecIndex: integer;
         PrevActiveRecord: integer;
         curBookmark: TBookmark;
         res: CmpBkmkRslt;
     begin
        if DataLinkIndex>=FDataLinks.count then exit;

        DataLink:= TfcTreeDataLink(FDataLinks[DataLinkIndex]);

        PrevActiveRecord:= DataLink.ActiveRecord;

        for RecIndex:= 0 to DataLink.RecordCount-1 do
        begin
           DataLink.ActiveRecord:= RecIndex;
           Node:= TfcDBTreeNode.create;
           if DataLinkIndex<=DisplayFields.count-1 then
             Node.Text:= GetNodeText(DisplayFields[DataLinkIndex], DataLink.DataSet, Node.Field)
           else
             Node.Text:= GetNodeText(DataLink.DataSet.Fields[0].FieldName, DataLink.DataSet, Node.Field);
           Node.Level:= DataLinkIndex;
           Node.DataLink:= DataLink;
           Node.DataSet:= DataLink.DataSet;
           Node.ActiveRecord:= RecIndex;
           Node.Expanded:= False;
           Node.HasChildren:= (DataLinkIndex < FDataLinks.count-1);
           Node.Parent:= ParentNode;
           Node.Selected:= False;
           Node.ImageIndex:= 0;
           Node.StateIndex:= -1;
           Node.HasPrevSibling:= (not DataLink.DataSet.Bof) or (DataLink.ActiveRecord>0);
           if Node.HasPrevSibling and (DataLinkIndex=0) then
           begin
              curBookmark:= DataLink.dataset.GetBookmark;
              if (curBookmark<>nil) and (FirstBookmark<>nil) then try
                 res:= DataLink.DataSet.CompareBookmarks(FirstBookmark, curBookmark);
                 if (res=CMPKeyEql) or (res=CMPEql) then
                 begin
                    if DataLink.ActiveRecord=0 then
                       Node.HasPrevSibling:= False
                    else
                       FreeFirstBookmark; { First Record inserted by another application }
                 end;
              finally
                 DataLink.dataset.FreeBookmark(curBookmark);
              end;
           end;
           if (not Node.HasPrevSibling) and (dsInsert = DataLink.DataSet.state) then
              Node.HasPrevSibling:= True;

           Node.HasNextSibling:=
             not ((RecIndex = DataLink.RecordCount-1) and
                  ((DataLink.RecordCount < DataLink.BufferCount) or DataLink.DataSet.eof));
           if (not Node.HasNextSibling) and (dsInsert = DataLink.DataSet.state) then
              Node.HasNextSibling:= True;
           Nodes.Add(Node);

           if (PrevActiveRecord=RecIndex) then
           begin
              if (DataLink.DataSet=ActiveDataSet) then
              begin
                 ActiveNodeIndex:= Nodes.count-1;
                 Node.Selected:= True;
              end;

              if (DataLink.DataSet=LastVisibleDataSet) or
                 (LastVisibleDataSet=nil) and not (csDesigning in ComponentState) then
              begin
                 NextDataLink:= GetChildDataLink(DataLink.DataSet);
                 if (NextDataLink<>nil) and
                    NextDataLink.DataSet.eof and NextDataLink.DataSet.bof then
                 begin
                    Node.HasChildren:= False;
                 end;
              end
              else begin
                 Node.Expanded:= True;
                 ScanDataLink(Node, DataLinkIndex + 1);
              end
           end
        end;
        DataLink.ActiveRecord:= PrevActiveRecord;
     end;

   { Fill with background color }
   Procedure BeginPainting;
   var PaintRect: TRect;
   begin
      InPaint:= True;
      if VertScrollBar.visible then
         FPaintBitmap.Width := fcMax(0, Width + HorzScrollBar.position - VertScrollBar.Width)
      else
         FPaintBitmap.Width := Width + HorzScrollBar.position;
      FPaintBitmap.Height := Height;
      FPaintCanvas.Brush.Color := Color;
      if (FImager <> nil){ and (FImager.visible) }then
      begin
         if FImager.WorkBitmap.Empty then FImager.UpdateWorkBitmap;
         if FImager.DrawStyle=dsTile then
         begin
            PaintRect:= Rect(0,0,FPaintBitmap.Width, FPaintBitmap.Height);
            FImager.WorkBitmap.TileDraw(Canvas, PaintRect);
         end
         else begin
            PaintRect:= Rect(horzscrollbar.position + 0, 0, horzscrollbar.position + ClientRect.Right, ClientRect.Bottom);
            Canvas.StretchDraw(PaintRect, FImager.WorkBitmap);
         end
      end
      else
        FPaintCanvas.FillRect(Rect(0, 0, FPaintBitmap.Width, FPaintBitmap.Height));
   end;

   procedure EndPainting;
   var r, sourceRect: TRect;
       scrollpos: integer;
       PaintClipRect: TRect;
   begin
     r := ClientRect;
     OffsetRect(r, 1, 0);
     FCanvas.CopyMode:= cmSrcCopy;
     scrollpos:= HorzScrollBar.position;

     PaintClipRect:= FPaintCanvas.ClipRect;
     if PaintClipRect.Right>ClientRect.Right then
     begin
        PaintClipRect.Right:= ClientRect.Right;
     end;
     if UpdateRect.Bottom>ClientRect.Bottom then
     begin
        UpdateRect.Bottom:= ClientRect.Bottom;
     end;

     if (UpdateRect.Top=0) and (UpdateRect.Bottom=0) and
        (UpdateRect.Left=0) and (UpdateRect.Right=0) then
        UpdateRect:= PaintClipRect;
     SourceRect:= Rect(Scrollpos, UpdateRect.Top,
        ScrollPos+PaintClipRect.Right, UpdateRect.Bottom );
     FCanvas.CopyRect(
        Rect(0,UpdateRect.Top,
        PaintClipRect.Right, UpdateRect.Bottom),
        FPaintCanvas, SourceRect);
      InPaint:= False;
   end;

begin
   GetUpdateRect(Handle, UpdateRect, False);

   SkipErase:= True;
   inherited;
   SkipErase:= False;

   if FCanvas = nil then
   begin
      FCanvas := TControlCanvas.Create;
      FCanvas.Control := Self;
   end;

   if (HaveBadLink) then begin { Fix data module problem }
      BeginPainting;
      EndPainting;
      RefreshDataLinks(nil, nil);
      HaveBadLink:= False;  { Just do first for first paint so clear flag }
      exit;
   end;

   if not HaveValidDataLinks then begin
      BeginPainting;
      EndPainting;
      exit;
   end;

   if (Images<>nil) and (StateImages<>nil) then
   begin
     FixedOffset := 2;
   end
   else begin
     FixedOffset := 2;
   end;


   BeginPainting;
   r:= Rect(0,0,0,0);

   try
      if FDataLinks.count<=0 then begin
         RefreshDataLinks(DataSourceFirst, DataSourceLast);
         if FDataLinks.count<=0 then begin
            exit;
         end;
      end;

     if (ActiveDataSet=nil) then
       ActiveDataSet:= TfcTreeDataLink(FDataLinks[0]).DataSet;
     if (ActiveDataSet=nil) or (not ActiveDataSet.Active) then exit;

     if dtvoHotTracking in Options then
     begin
        GetCursorPos(MousePos);
        sp:= ScreenToClient(MousePos);
        if (sp.x>0) and (sp.x<Width) and (sp.y>0) and (sp.y<height) then
           MouseToRow(sp.x, sp.y, HotTrackRow)
        else HotTrackRow:= -1;
     end;

     if not SkipReload then
     begin
        NodesCleared:= True;

        for i:= 0 to Nodes.count-1 do begin
          if SkipFreeNodes then OldNodes.Add(Nodes[i])
          else TfcDBTreeNode(Nodes[i]).Free;
        end;

        Nodes.Clear;

        ActiveNodeIndex:= TfcTreeDataLink(FDataLinks[0]).ActiveRecord;;
        ScanDataLink(nil, 0);
//        if ActiveNodeIndex-GetStartOffset(ActiveDataSet)>=CacheSize then
//           SetStartOffset(ActiveDataSet, fcmax(ActiveNodeIndex+1-CacheSize, 0));
     end;

     if ActiveNodeIndex-GetStartOffset>=CacheSize then
        SetStartOffset(ActiveDataSet, fcmax(ActiveNodeIndex+1-CacheSize, 0));

     if (ActiveNodeIndex>=0) and (ActiveNodeIndex<=Nodes.Count-1) then
     begin
        FActiveNode:= TfcDBTreeNode(Nodes[ActiveNodeIndex]);
     end
     else FActiveNode:= nil;

     NewMaxTextWidth:= 0;
     for i:= 0 to Nodes.Count-1 do begin
         if HorzScrollBar.Visible then
         begin
            if (i>=CacheSize+1) then break;
         end
         else if i>=CacheSize then break;

         if (i+GetStartOffset>=Nodes.count) then break;
         PaintingRow:= i;

         Node:= TfcDBTreeNode(Nodes[i+GetStartOffset]);
         FPaintCanvas.Font.Assign(Font); { Restore original font }

         FPaintCanvas.Pen.Color := FLineColor; //clBtnShadow; { for line drawing }

         PrevActiveRecord:= Node.DataLink.ActiveRecord;
         try
            Node.DataLink.ActiveRecord:= Node.ActiveRecord;
            Node.MultiSelected:= FindCurrentMultiSelectIndex(Node.DataLink.DataSet)>=0;
            ActiveNode:= ActiveNodeIndex=i+GetStartOffset;
            if ActiveNode and not FMultiSelectAttributes.enabled then
            begin
               if Focused then begin
                  FPaintCanvas.Brush.Color:= clHighlight;
                  FPaintCanvas.Font.Color := clHighlightText;
               end
               else begin
                  if not (dtvoHideSelection in Options) then
                  begin
                     if InactiveFocusColor<>Color then
                        FPaintCanvas.Brush.Color:= InactiveFocusColor
                     else
                        FPaintCanvas.Brush.Color:= clGray;
                  end
                  else begin
                     FPaintCanvas.Brush.Color := Color;
                  end;
                  FPaintCanvas.Font.Color:= Font.Color;
               end
            end
            else if FMultiSelectAttributes.enabled then
            begin
               if Node.MultiSelected then begin
                  if Focused then begin
                     FPaintCanvas.Brush.Color:= clHighlight;
                     FPaintCanvas.Font.Color := clHighlightText;
                  end
                  else begin
                     FPaintCanvas.Brush.Color:= InactiveFocusColor;
                     FPaintCanvas.Font.Color:= Font.Color;
                  end
               end
               else begin
                  if (Imager<>nil) and ActiveNode then
                     FPaintCanvas.Brush.Color := clNone
                  else
                     FPaintCanvas.Brush.Color := Color;
                  FPaintCanvas.Font.Color := Font.Color;
               end
            end
            else begin
               FPaintCanvas.Brush.Color := Color;
               FPaintCanvas.Font.Color := Font.Color;
            end;


            { 4/5/99 - Set Node.Hot property }
            if dtvoHotTracking in Options then
            begin
              R:= TextRect(Node, i);
              Node.Hot:= (PaintingRow = HotTrackRow) and (sp.x>r.left) and (sp.x<r.right);
            end;

            DoCalcNodeAttributes(Node);
            NewMaxTextWidth:=
              fcMax(Canvas.TextWidth(Node.Text) + TextRect(Node, i).Left, NewMaxTextWidth);
         finally
            Node.DataLink.ActiveRecord:= PrevActiveRecord;
         end;

         FocusRect:= TextRect(Node, i);
         if not odd(fcRectHeight(r) div 2) and (FocusRect.Top>0) then
         begin
            FocusRect.top:= FocusRect.Top - 1;
         end
         else FocusRect.Bottom:= FocusRect.Bottom + 1;

         FocusRect.Left:= FocusRect.Left - 1;
         if FPaintCanvas.Brush.Color <> clNone then
         begin
            if dtvoRowSelect in Options then
            begin
              if BorderStyle=bsNone then { 5/25/99 }
                 FocusRect.Right:= FPaintBitmap.Width
              else
                 FocusRect.Right:= FPaintBitmap.Width-4;
              if Images <> nil then dec(FocusRect.Left, TImageList(Images).Width);
              if UseStateImages(node) then dec(FocusRect.Left, GetStateImageWidth);
              if (Images<>nil) and UseStateImages(node) then dec(FocusRect.Left, 1);
              if (Images<>nil) or UseStateImages(node) then dec(FocusRect.Left, 2);
//              FocusRect.Bottom := FocusRect.Bottom + 1;
            end;
            if (Node.Selected or
                (Node.MultiSelected and FMultiSelectAttributes.enabled)) then
                FPaintCanvas.FillRect(FocusRect);
         end;

         PaintLines(node);
         PaintImage(node);

//         Flags:= DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX;

         R:= TextRect(Node, i);
         SetBkMode(FPaintCanvas.Handle, TRANSPARENT);

         try
//            if odd(fcRectHeight(r) div 2) then R.Top:= R.Top + 1;
//            R.Left:= R.Left + 1;

            DefaultDrawing:= True;

            if dtvoHotTracking in Options then
            begin
               R:= TextRect(Node, i);
//               Node.Hot:= (PaintingRow = HotTrackRow) and (sp.x>r.left) and (sp.x<r.right);
               if Node.Hot then begin
                  if not node.selected then FPaintCanvas.Font.Color:= clBlue;
                  FPaintCanvas.Font.Style:= [fsUnderline];
                  if (fsBold in Font.Style) then
                     FPaintCanvas.Font.Style:= FPaintCanvas.Font.Style + [fsbold];
               end
               else if (PaintingRow = HotTrackRow) then
                  HotTrackRow:= -1;
            end;

            if odd(fcRectHeight(r) div 2) then R.Top:= R.Top + 1;
            R.Left:= R.Left + 1;

            DoDrawText(self, Node, r, DefaultDrawing);

            if DefaultDrawing then begin
               FPaintCanvas.DrawText(Node.Text, R, DT_END_ELLIPSIS OR DT_NOPREFIX);
               R.Left:= R.Left - 1;
               if odd(fcRectHeight(r) div 2) then R.Top:= R.Top - 1;

               if ActiveNode and Focused then begin
                  if (not (dtvoRowSelect in Options)) then
                  begin
                     FPaintCanvas.Brush.Color := clBlack;
                     if FMultiSelectAttributes.enabled and (Imager=nil) then
                     begin
                        SetBkColor(FPaintCanvas.Handle, ColorToRGB(Color));
                        SetTextColor(FPaintCanvas.Handle, ColorToRGB(Font.Color));
                     end
                     else begin
                        SetBkColor(FPaintCanvas.Handle, ColorToRGB(clHighlight));
                        SetTextColor(FPaintCanvas.Handle, ColorToRGB(clHighlightText));
                     end;
                     FPaintCanvas.DrawFocusRect(FocusRect);
                  end
                  else begin
                     if FMultiSelectAttributes.enabled then
                     begin
//                        FocusRect.Left:= FocusRect.Left + 3;
                        FPaintCanvas.DrawFocusRect(FocusRect);
                     end;
                  end;
               end
            end
        finally
           SetBkMode(FPaintCanvas.Handle, OPAQUE);
        end;

     end;

     UpTreeButton.enabled:=  (FFirstDataLink<>nil) and (ActiveDataSet<>FFirstDataLink.DataSet);
     DownTreeButton.enabled:=  (FLastDataLink<>nil) and (ActiveDataSet<>FLastDataLink.DataSet) and
                               (FActiveNode<>nil) and FActiveNode.hasChildren;

     OrigCheckMaxWidth:= CheckMaxWidth;
     if (((MaxTextWidth<>NewMaxTextWidth) and (CheckMaxWidth or CheckMaxWidthGrow))
        or ResetScroll) and
        (dtvoShowHorzScrollBar in Options) then
     begin
        CheckMaxWidth:= False;
        CheckMaxWidthGrow:= False;
        if (MaxTextWidth<NewMaxTextWidth) or
           ((HorzScrollBar.position=0) and OrigCheckMaxWidth) then
        begin
           MaxTextWidth:= NewMaxTextWidth;
           ResetScroll:= False;
           with HorzScrollBar do begin
              Min:= 0;
              Max:= NewMaxTextWidth+3;

              InComputeHorzWidthOnly := True;
              PageSize:= self.ClientRect.Right - self.ClientRect.Left;
              InComputeHorzWidthOnly := False;
              GetClientRect; // Updates scrollbars if necessary after PageSize is set

              ScrollSize:= Max;
//           if PageSize>Max then
//              LayoutChanged;
              HorzScrollBar.Invalidate;
           end
        end;
     end
     else begin
        CheckMaxWidth:= False;
        CheckMaxWidthGrow:= False;
     end;

     if FActiveNode<>nil then with FActiveNode.DataLink.DataSet do
     begin
        FActiveBookmark:= GetBookmark;

        if ActiveDataSetChanged then
        begin
           FreeLastActiveBookmark;
           LastActiveBookmark:= FActiveBookmark;
           try { 4/25/99 - Catch exception }
              Change(FActiveNode);
           except
              ActiveDataSetChanged:= False;
              raise;
           end;
           ActiveDataSetChanged:= False;
           exit;
        end;

        if (FActiveBookmark<>nil) then
        begin
           if LastActiveBookmark<>nil then
           begin
              res:= CompareBookmarks(LastActiveBookmark, FActiveBookmark);
              NewNode:= (res<>CMPKeyEql) and (res<>CMPEql);
           end
           else NewNode:= True;

           if NewNode then
           begin
              FreeLastActiveBookmark;
              LastActiveBookmark:= FActiveBookmark;
              Change(FActiveNode);
              ActiveDataSetChanged:= False;
           end
           else FreeBookmark(FActiveBookmark);

        end
     end;

   finally
     EndPainting;
     if HotTrackRow>=0 then
     begin
        SaveCursor:= Screen.Cursor;
        Cursor:= crHandPoint;
     end
     else if Screen.Cursor<>crArrow then
        Cursor:= SaveCursor;
   end;


end;

procedure TfcDBCustomTreeView.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if True or SkipErase then begin { 4/31/99 - Always Remove erase to prevent flicker when resizing }
     Message.result:= 1;
     exit;
  end
  else inherited;
end;

Procedure TfcDBCustomTreeView.MouseToRow(X, Y: integer; var Row: integer);
begin
   row:= -1;
   if y<0 then exit;
   if y>Height then exit;

   row:= y div RowHeight;
end;

function TfcDBCustomTreeView.RowToNode(Row: integer; var Node: TfcDBTreeNode): boolean;
begin
   result:= false;
   Node:= nil;
   if row<0 then exit;
   if row> cacheSize-1 then exit;

   if GetStartOffset+Row<=Nodes.count-1 then
   begin
      Node:= Nodes[GetStartOffset + Row];
      result:= true;
   end
   else result:= false;
end;

{function TfcDBCustomTreeView.NodeToIndex(Node: TfcDBTreeNode): integer;
var i: Integer;
begin
   result:= -1;
   for i:= 0 to Nodes.count-1 do begin
      if nodes[i]=node then begin
         result:= i;
         break;
      end
   end
end;
}
function TfcDBCustomTreeView.NodeToRow(Node: TfcDBTreeNode; var Row: integer): boolean;
var i: integer;
begin
   result:= false;
   row:= -1;
   for i:= 0 to Nodes.count-1 do begin
      if nodes[i]=node then
      begin
         Row:= i - GetStartOffset;
         if Row>=0 then result:= True;
         break;
      end
   end;
end;

procedure TfcDBCustomTreeView.Collapse(Node: TfcDBTreeNode);
var DataLink: TfcTreeDataLink;
begin
   if Node=nil then exit;

   try
      SkipFreeNodes:= True;
      DoUserCollapse(Node);

      DataLink:= TfcTreeDataLink(FDataLinks[Node.Level]);
      ActiveDataSet:= DataLink.DataSet;
      if LastVisibleDataSet<>ActiveDataSet then
      begin
         LastVisibleDataSet := ActiveDataSet;
         CheckMaxWidth:= True;
      end;
      InvalidateClient;

   finally
      FreeOldNodes;
      SkipFreeNodes:= False;
   end;
end;

procedure TfcDBCustomTreeView.FreeOldNodes;
var i: integer;
begin
  for i:= 0 to OldNodes.count-1 do TfcDBTreeNode(OldNodes[i]).Free;
  OldNodes.Clear;
end;

procedure TfcDBCustomTreeView.Expand(Node: TfcDBTreeNode);
var DataLink: TfcTreeDataLink;
begin
   if Node=nil then exit;
   if ActiveNode<>Node then MoveTo(Node); { 3/9/99 }

   try
      SkipFreeNodes:= True;
      DoUserExpand(Node);  { !!!Node could be invalid after executing user event }

      DataLink:= TfcTreeDataLink(FDataLinks[Node.Level]);
      DataLink:= GetChildDataLink(DataLink.DataSet);
      if (DataLink<>nil) and (DataLink.RecordCount>0) then begin
         ActiveDataSet:= DataLink.DataSet;
         if not IsChildDataSetofActive(LastVisibleDataSet) then
            LastVisibleDataSet:= ActiveDataSet;
         CheckMaxWidth:= True;
         invalidateClient;
      end;

   finally
      FreeOldNodes;
      SkipFreeNodes:= False;
   end;

end;

Procedure TfcDBCustomTreeView.MoveTo(Node: TfcDBTreeNode);
begin
   UpdateDataLinkToActive(Node);
end;

function TfcDBCustomTreeView.UpdateDataLinkToActive(Node: TfcDBTreeNode): boolean;
var TempDataLink, DataLink: TfcTreeDataLink;
begin
   result:= False;
   if (Node=nil) or (Node.DataLink=nil) then exit;

   DataLink:= Node.DataLink;
   if not Node.DataLink.Active then exit; { 4/9/99 }
   if DataLink.ActiveRecord<>Node.ActiveRecord then
   begin
      Datalink.Dataset.MoveBy(Node.ActiveRecord - DataLink.ActiveRecord);
      if ActiveDataSet<>DataLink.DataSet then
      begin
         ActiveDataSet:= DataLink.DataSet;
         TempDataLink:= GetChildDataLink(ActiveDataSet);
         if TempDataLink<>nil then ResetStartOffsets(TempDataLink.DataSet);
      end
      else begin
         TempDataLink:= GetChildDataLink(ActiveDataSet);
         if TempDataLink<>nil then ResetStartOffsets(TempDataLink.DataSet);
      end;
      invalidateClient;
      result:= True;

   end
   else begin { Same master record }
      DataLink:= GetDataLink(DataLink.DataSet);
      if (DataLink<>nil) and (ActiveDataSet<>DataLink.DataSet) then begin
         ActiveDataSet:= DataLink.DataSet;
         invalidateClient;
         result:= True;
      end
   end;
end;

procedure TfcDBCustomTreeView.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var row: integer;
    node: TfcDBTreeNode;
begin
   inherited;
   if not HaveValidDataLinks then exit;

   MouseToRow(X, Y, Row);
   RowToNode(Row, Node);
   if Assigned(FOnMouseUp) then FOnMouseUp(self, Node, Button, Shift, X, Y);
end;

procedure TfcDBCustomTreeView.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var Node: TfcDBTreeNode;
    Row: integer;
    DataLink: TfcTreeDataLink;
    HitTest: TfcTreeHitTests;
    ValidNode: Boolean;
    NodeLevelRect: TRect;

{   Function SameLevelShiftSelect: boolean;
   begin
      ShowMessage('not implemented yet');
      result:= True;
   end;
}
begin
   inherited;
   if not HaveValidDataLinks then exit;

   SetFocus;
   MouseToRow(X, Y, Row);
   ValidNode:= RowToNode(Row, Node);
   NodesCleared:= False; { If nodes are cleared in Paint then node is invalid }

   DataLink:= nil;
   if ValidNode then DataLink:= TfcTreeDataLink(FDataLinks[Node.Level]);
   if Assigned(FOnMouseDown) then FOnMouseDown(self, Node, Button, Shift, X, Y);
   if (ssDouble in Shift) and Assigned(FOnDblClick) then FOnDblClick(self, Node, Button, Shift, X, Y);
   if not ValidNode then exit;

   hitTest:= GetHitTestInfoAt(X,Y);
   if hitTest=[] then exit;
   NodeLevelRect:= LevelRect(Node);

   if (fchtdOnButton in hitTest) and (ssLeft in Shift) then
   begin
      if dtvoExpandButtons3D in Options then
      begin
         MouseRow:= Row;
         MouseLoop(X,Y);
         MouseRow:= -1;
         exit;
      end
   end;

   if (not NodesCleared) and (not (ssDouble in Shift)) then
      UpdateDataLinkToActive(Node);

   if (fchtdOnButton in hitTest) and (ssLeft in Shift) and (not NodesCleared) then
   begin
      if node.expanded then Collapse(Node)
      else Expand(Node);
      exit;
   end;

   if (not NodesCleared) and (fchtdOnStateIcon in hitTest) and
     MultiSelectCheckBoxNeeded(Node) then
   begin
       if IsSelectedRecord then UnselectRecord
       else SelectRecord;
   end
   else if ([fchtdOnStateIcon, fchtdOnImageIcon, fchtdOnText] * hitTest <> []) and
      (ssDouble in Shift) and (not NodesCleared) then
   begin
      DataLink:= GetChildDataLink(DataLink.DataSet);
      if (DataLink<>nil) and (DataLink.RecordCount>0) then begin
         if node.expanded then Collapse(Node)
         else Expand(Node);
      end;
      invalidateClient;
   end;

   if FMultiSelectAttributes.Enabled and
    (((dtvoRowSelect in Options) and (X >= NodeLevelRect.Left)) or  // -ksw (Added to make behavior more
    (not (dtvoRowSelect in Options) and (hitTest * [fchtdOnText] <> []))) then    // consistent in non-databound cases)
   begin
      Update; { 5/5/99 - Updates active node before calling ToggleMultiSelection }
      { 7/29/99 - Support auto-unselect property }
      if ([ssCtrl, ssShift] * Shift = []) and
         (MultiSelectAttributes.AutoUnselect) then UnselectAll;
      ToggleMultiSelection(not MultiSelectAttributes.AutoUnselect, Shift);
   end;

end;

procedure TfcDBCustomTreeView.MouseLoop(X, Y: Integer);
var ACursor: TPoint;
    Msg: TMsg;

   Function InButton(ACursorPos: TPoint): boolean;
   var sp: TPoint;
   begin
      sp:= ScreenToClient(ACursorPos);
      Result:= (fchtdOnButton in GetHitTestInfoAt(sp.x, sp.y)) and
           (sp.y>=MouseRow * RowHeight) and (sp.y<=(MouseRow+1) * RowHeight -1);
   end;

   procedure MouseLoop_MouseMove(X, Y: Integer; ACursorPos: TPoint);
   begin
     Down:= InButton(ACursorPos);
     if not Down then
     begin
        Down:= InButton(ACursorPos);
        InvalidateRow(MouseRow)
     end
     else
        InvalidateRow(MouseRow)
   end;

   procedure MouseLoop_MouseUp(X, Y: Integer; ACursorPos: TPoint);
   var
      IsMouseInControl: Boolean;
      MouseNode: TfcDBTreeNode;
   begin
     IsMouseInControl:= InButton(ACursorPos);
     Down:= False;
     InvalidateRow(MouseRow);
     if IsMouseInControl then
     begin
        if RowToNode(MouseRow, MouseNode) then
        begin
           FActiveNode:= MouseNode;
           UpdateDataLinkToActive(MouseNode);

           if ActiveNode.expanded then
              Collapse(ActiveNode)
           else
              Expand(ActiveNode);
        end
     end
   end;

begin
  Down:= True;
  InvalidateRow(MouseRow); { Invalidate button icon }

  SetCapture(Handle);
  try
    while GetCapture = Handle do
    begin
      GetCursorPos(ACursor);
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
          PostQuitMessage(Msg.WParam);
          Break;
        end;
      end;
      case Msg.Message of
        WM_LBUTTONDOWN, WM_LBUTTONDBLCLK: ;
        WM_MOUSEMOVE: MouseLoop_MouseMove(X, Y, ACursor);
        WM_LBUTTONUP: begin
          MouseLoop_MouseUp(X, Y, ACursor);

          TranslateMessage(Msg);   // So OnMouseUp fires
          DispatchMessage(Msg);

          if GetCapture = Handle then ReleaseCapture;
        end;
        else begin
          TranslateMessage(Msg);   // So OnMouseUp fires
          DispatchMessage(Msg);
        end;
      end;
    end;
  finally
    if GetCapture = Handle then ReleaseCapture;
    if Dragging then EndDrag(False);
  end;
end;


Function TfcDBCustomTreeView.TextRect(Node: TfcDBTreeNode; Row: integer): TRect;
var R: TRect;
begin
   R:= Rect(FixedOffset + (Node.Level+1)*LevelIndent, row*RowHeight, Width,
       (row+1)*RowHeight-1);

   if Images<>nil then r.Left:= r.Left + TImageList(Images).Width;
   if UseStateImages(Node) then r.Left:= r.Left + GetStateImageWidth;
   if (Images<>nil) and (UseStateImages(Node)) then
      r.Left:= r.Left + 1;

   R.Right:= R.Left + FPaintCanvas.TextWidth(Node.Text) + 3;
   if not (dtvoShowRoot in Options) then begin
      r.Left:= r.Left - LevelIndent;
      r.Right:= r.Right - LevelIndent;
   end;
   result:= R;
end;

Function TfcDBCustomTreeView.LevelRect(Node: TfcDBTreeNode): TRect;
var r: TRect;
    row: Integer;
begin
   r:= Rect(0,0,0,0);
   r.Left:= Node.Level * LevelIndent + FixedOffset;
//   if Images<>nil then
     r.Right:= r.Left + LevelIndent - 1;
//   else r.Right:= r.Left + LevelIndent - 4;

   if NodeToRow(Node, Row) then begin
      r.Top:= Row * RowHeight;
      r.Bottom:= (Row+1) * RowHeight -1;
   end
   else begin
      r.Top:= 0;
      r.Bottom:= RowHeight-1;
   end;
   if not (dtvoShowRoot in Options) then begin
      if Node.Level=0 then
      begin
         r.Left:= 0;
         r.Right:= 0;
      end
      else begin
         r.Left:= r.Left - LevelIndent;
         r.Right:= r.Right - LevelIndent;
      end
   end;
   result:= r;

end;

Function TfcDBCustomTreeView.GetCenterPoint(ARect: TRect): TPoint;
var r: TRect;
begin
   r:= ARect;

   if odd(fcRectHeight(r) div 2) then
      result.y:= r.Top + (fcRectHeight(r)+2) div 2
   else
      result.y:= r.Top + (fcRectHeight(r)) div 2;

   result.x:= r.Left + (fcRectWidth(r)) div 2

end;

procedure TfcDBCustomTreeView.PaintImage(Node: TfcDBTreeNode);
const ItemChecked: array[Boolean] of Integer = (0, DFCS_CHECKED);
      CheckBoxFlat: array[Boolean] of Integer = (0, DFCS_FLAT);
      DrawSelected: array[Boolean] of Integer = (ILD_NORMAL, ILD_SELECTED);
var r: TRect;
    x: Integer;
    Index: Integer;
    cp: TPoint;
    offset: integer;
begin
  r := LevelRect(Node);

  if not((Images = nil) or (Node.ImageIndex < 0) or
    (Node.ImageIndex >= Images.Count)) then
  begin
    x := r.Right -2;
    if UseStateImages(Node) then
    begin
       inc(x, GetStateImageWidth+1);
    end;
    Index := Node.ImageIndex;

    ImageList_DrawEx(Images.Handle, Index, FPaintCanvas.Handle,
      x, r.Top + (r.Bottom - r.Top - TImageList(Images).Height) div 2, 0, 0,
      CLR_NONE, ColorToRGB(TImageList(Images).BlendColor),
      DrawSelected[Node.Selected and (TImageList(Images).BlendColor <> clNone)
      and not (dtvoRowSelect in Options)]);

  end;


  if UseStateImages(Node) then
  begin
     if MultiSelectCheckboxNeeded(Node) then begin
         cp:= GetCenterPoint(r);
         Offset:= 6;
         DrawFrameControl(FPaintCanvas.Handle,
            Rect(r.right+1, cp.y-offset, r.Right + 2*offset + 2, cp.y+offset+1),
              DFC_BUTTON, DFCS_BUTTONCHECK {or CheckBoxFlat[tvoFlatCheckBoxes in Options]} or ItemChecked[Node.MultiSelected])
     end
     else
        StateImages.Draw(FPaintCanvas, r.right-2, r.Top + (r.Bottom-r.Top-TImageList(StateImages).Height) div 2, Node.StateIndex)
//        StateImages.Draw(FPaintCanvas, r.Right, r.Top, Node.StateIndex)
  end;


end;

Function TfcDBCustomTreeView.GetStartX(Node: TfcDBTreeNode): integer;
var Offset : integer;
    r: TRect;
begin
   r := LevelRect(Node);
   Offset:= (((r.Bottom - r.Top) div 2) div 2)+2;
   Offset:= fcMin(Offset, 7);
   result:= r.Left + offset + 1; //r.Right + Offset + 1;
end;

procedure TfcDBCustomTreeView.PaintLines(Node: TfcDBTreeNode);
var LevelNode: TfcDBTreeNode;
    LineStartX:integer;
    LineTop, LineBottom: TPoint;
    y:integer;
    size: integer;
    r, OrigRect: TRect;

begin
  if (dtvoShowLines in Options) and
     ((dtvoShowRoot in Options) or (Node.Level<>0)) then
  begin
//    FPaintCanvas.Pen.Color := clBtnShadow;
    LevelNode := Node;
    OrigRect := LevelRect(Node);
    while (LevelNode <> nil) and ((LevelNode.Level = 0) or (LevelNode.Parent <> nil)) do
    begin
      if (LevelNode.Level=0) and (not (dtvoShowRoot in Options)) then break;
      r := LevelRect(LevelNode);
      r.Top := OrigRect.Top;
      r.Bottom := OrigRect.Bottom;
      LineStartX:= GetStartX(LevelNode);
      if (dtvoExpandButtons3D in Options) then
      begin
         LineTop:= Point(LineStartX, r.Top);
         LineBottom:= Point(LineStartX, r.Bottom);
      end
      else begin
         LineTop:= Point(LineStartX, r.Top);
         LineBottom:= Point(LineStartX, r.Bottom);
      end;
      if LevelNode.Level = Node.Level then
      begin
        if (not Node.HasPrevSibling) and (Node.Parent = nil) then
        begin
           inc(LineTop.y, GetCenterPoint(r).y);
        end;
        if (not Node.HasNextSibling) then
           dec(LineBottom.y, (r.bottom-r.top) div 2)
        else if (PaintingRow >= CacheSize-1) then
           LineBottom.y:= LineBottom.y+2;
      end;
      if (LevelNode.HasNextSibling) or (LevelNode.Level = Node.Level) then
        FPaintCanvas.DottedLine(LineTop, LineBottom);
      LevelNode := LevelNode.Parent;
    end;
    r := LevelRect(Node);
    if (dtvoShowRoot in Options) or (Node.Level <> 0) then
    begin
      y:= GetCenterPoint(r).y;
      if (Node.MultiSelected or (Node.Selected and Focused)) and
         UseStateImages(Node) and MultiSelectCheckboxNeeded(Node) and
         (dtvoRowSelect in Options) then
         r.right:= r.right - 4;
      if dtvoExpandButtons3D in Options then
         FPaintCanvas.DottedLine(Point(GetStartX(Node), y), Point(r.Right, y))
      else
         FPaintCanvas.DottedLine(Point(GetStartX(Node), y), Point(r.Right, y));
    end
  end;
  if Node.HasChildren then begin
     size:= ((r.bottom-r.top) div 2);
     size:= fcMax(size, 8);
     PaintButton(Node,
        Point(GetStartX(Node), GetCenterPoint(r).y), size, Node.Expanded)
  end

end;

procedure TfcDBCustomTreeView.PaintButton(Node: TfcDBTreeNode;
    pt: TPoint; Size: integer; Expanded: Boolean);
var offset: integer;
    drawRect: TRect;
    OrigColor: TColor;
    StateFlags: Word;
begin
   OrigColor:= FPaintCanvas.Brush.Color;
   if not (dtvoShowButtons in Options) then Exit;
   offset:= Size;
   Offset:= Offset div 2;

   DrawRect.Left:= pt.x - offset;
   DrawRect.Right:= pt.x + offset+1;
   DrawRect.Top:= pt.y-offset;
   DrawRect.Bottom:= pt.y+offset+1;

   if dtvoExpandButtons3D in Options then
   begin
      FPaintCanvas.Brush.Color := clBtnFace;
      FPaintCanvas.FillRect(DrawRect);
      FPaintCanvas.Brush.Color := clBtnShadow;

      StateFlags:= DFCS_BUTTONPUSH;
      if Down and (MouseRow=PaintingRow) then
         StateFlags := StateFlags or DFCS_PUSHED;

      with DrawRect do
         DrawFrameControl(FPaintCanvas.Handle, Rect(Left, Top, Right+1, Bottom+1),
              DFC_BUTTON, StateFlags);
      if ColorToRGB(Color)=clWhite then
      begin
         with DrawRect, FPaintCanvas do begin
           Pen.Color := clBtnFace;
           Polyline([Point(Left-1, Bottom), Point(Left-1, Top-1), Point(Right+1, Top-1)]);
         end;
      end;

      if Down and (MouseRow = PaintingRow) then
      begin
         pt.x:= pt.x+1;
         pt.y:= pt.y+1;
         DrawRect.Left:= DrawRect.Left + 1;
         DrawRect.Top:= DrawRect.Top + 1;
         DrawRect.Right:= DrawRect.Right + 1;
         DrawRect.Bottom:= DrawRect.Bottom + 1;
      end;
      FPaintCanvas.Brush.Color := Color;
      FPaintCanvas.Pen.Color := clBlack;
      if not Expanded then
         FPaintCanvas.Polyline([Point(pt.x, DrawRect.Top+Offset div 2), Point(pt.x, DrawRect.Bottom-Offset div 2)]);
      FPaintCanvas.Polyline([Point(DrawRect.Left+Offset div 2, pt.y), Point(DrawRect.Right-Offset div 2, pt.y)]);

      FPaintCanvas.Brush.Color:= OrigColor;
   end
   else begin
      FPaintCanvas.Brush.Color := clWhite;
      FPaintCanvas.FillRect(DrawRect);
      FPaintCanvas.Brush.Color := clBtnShadow;
      FPaintCanvas.FrameRect(DrawRect);
      FPaintCanvas.Brush.Color := Color;

      FPaintCanvas.Pen.Color := clBlack;
      if not Expanded then
         FPaintCanvas.Polyline([Point(pt.x, DrawRect.Top+Offset div 2), Point(pt.x, DrawRect.Bottom-Offset div 2)]);
      FPaintCanvas.Polyline([Point(DrawRect.Left+Offset div 2, pt.y), Point(DrawRect.Right-Offset div 2, pt.y)]);

      FPaintCanvas.Brush.Color:= OrigColor;
   end
end;

procedure TfcDBCustomTreeView.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TfcDBCustomTreeView.SetLineColor(Value: TColor);
begin
  if FLineColor <> Value then
  begin
    FLineColor:= Value;
    InvalidateClient;
  end;
end;

procedure TfcDBCustomTreeView.SetInactiveFocusColor(Value: TColor);
begin
  if FInactiveFocusColor <> Value then
  begin
    FInactiveFocusColor:= Value;
    InvalidateClient;
  end;
end;

procedure TfcDBCustomTreeView.SetOptions(Value: TfcDBTreeViewOptions);
const
  LayoutOptions = [dtvoShowHorzScrollBar];
var ChangedOptions: TfcDBTreeViewOptions;
begin
   if Value<>FOptions then
   begin
      ChangedOptions := (FOptions + Value) - (FOptions * Value);
      FOptions:= Value;
      if ChangedOptions * LayoutOptions <> [] then LayoutChanged
      else begin
         invalidate;
      end
   end
end;

procedure TfcDBCustomTreeView.SetLastVisibleDataSet(DataSet: TDataSet);
begin
  if FLastVisibleDataSet<>DataSet then
  begin
//     DoChangeLastExpandedDataSet;
     FLastVisibleDataSet:= DataSet;
  end;
end;

procedure TfcDBCustomTreeView.SetActiveDataSet(DataSet: TDataSet);
var DataLinkChild, DataLinkParent: TfcTreeDataLink;
begin
    if ActiveDataSet=DataSet then exit;

    if DataSet<>nil then
    begin
       DataLinkChild:= GetChildDataLink(ActiveDataSet);
       DataLinkParent:= GetParentDataLink(ActiveDataSet);
       if (DataLinkChild<>nil) and (DataLinkChild.DataSet = DataSet) then begin
          { Expanding }
          FreeHintWindow;
       end
       else if (DataLinkParent<>nil) and (DataLinkParent.dataset = DataSet) then begin
          { Collapsing }
          FreeHintWindow;
       end
    end;

    if not (DataSet.Bof and DataSet.eof) then
    begin
       FActiveDataSet:= DataSet;
       ActiveDataSetChanged:= True; { Next paint event will trigger Change event }
//       if GetDataLink(LastVisibleDataSet)<>Nil then LastVisibleDataSet:= DataSet; { 5/15/99 - Commented out this line }
//       if LastVisibleDataSet=nil then LastVisibleDataSet:= DataSet;
    end;

    if FScrollWithinLevel then UpdateScrollBar;

end;

procedure TfcDBCustomTreeView.ScrollLeft;
var scrollpos: integer;
begin
   scrollpos:= HorzScrollBar.position;
   if scrollpos>0 then
   begin
      scrollpos:= fcmax(0, scrollpos - 10);
      HorzScrollBar.position:= scrollpos;
      invalidateClient;
   end
end;

procedure TfcDBCustomTreeView.ScrollRight;
var scrollpos: integer;
begin
   scrollpos:= HorzScrollBar.position;
   if scrollpos + (ClientRect.right - ClientRect.Left) <MaxTextWidth then
   begin
      scrollpos:= fcmin(MaxTextWidth, scrollpos + 10);
      HorzScrollBar.position:= scrollpos;
      invalidateClient;
   end
end;

procedure TfcDBCustomTreeView.KeyDown(var Key: Word; Shift: TShiftState);
var DataLink: TfcTreeDataLink;
begin
   DataLink:= GetDataLink(ActiveDataSet);
   case key of
      vk_down: begin
          NextRow(dtvoKeysScrollLevelOnly in Options);
       end;

      vk_up: begin
          PriorRow(dtvoKeysScrollLevelOnly in Options);
       end;

      vk_multiply, vk_add, vk_right:
       begin
          if ssCtrl in Shift then
             ScrollRight
          else Expand(ActiveNode);
       end;

      vk_subtract, vk_left:
       begin
          if ssCtrl in Shift then
          begin
             ScrollLeft;
          end
          else begin
             if (ActiveNode<>nil) then
             begin
                if (ActiveNode.Parent<>nil) then
                    Collapse(ActiveNode.Parent)
                else
                    Collapse(ActiveNode);
             end
          end;
       end;

      vk_home:
         if (ssCtrl in Shift)then
         begin
            ActiveDataSet:= TfcTreeDataLink(FDataLinks[0]).DataSet;
            LastVisibleDataSet := ActiveDataSet;
            ResetStartOffsets(ActiveDataSet);
            TfcTreeDataLink(FDataLinks[0]).dataset.first;
         end
         else
            DataLink.dataset.first;

      vk_end:
         if (ssCtrl in Shift)then
         begin
            ActiveDataSet:= TfcTreeDataLink(FDataLinks[0]).DataSet;
            LastVisibleDataSet := ActiveDataSet;
            ResetStartOffsets(ActiveDataSet);
            TfcTreeDataLink(FDataLinks[0]).dataset.last;
         end
         else
            DataLink.dataset.last;

      vk_next:
          NextPage(dtvoKeysScrollLevelOnly in Options);

      vk_prior:
          PriorPage(dtvoKeysScrollLevelOnly in Options);

      vk_space: ToggleMultiSelection(not MultiSelectAttributes.MultiSelectCheckbox, Shift);
   end;

   if key in [vk_right, vk_left, vk_down, vk_up, vk_next, vk_prior, vk_space] then key:= 0;

   if Assigned(OnKeyDown) then OnKeyDown(self, Key, Shift); { 7/4/99 - Fire OnKeyDown event }


end;

function TfcDBCustomTreeView.IsChildDataSetOfActive(DataSet: TDataSet): boolean;
var DataLinkParent: TfcTreeDataLink;
begin
    result:= False;
    DataLinkParent:= GetDataLink(DataSet);
    if DataLinkParent=nil then exit;

    repeat
       DataLinkParent:= GetParentDataLink(DataLinkParent.DataSet);
    until (DataLinkParent=nil) or (DataLinkParent.DataSet = ActiveDataSet);
    if (DataLinkParent<>nil) then result:= True;
end;

function TfcDBCustomTreeView.IsMasterDataSetOfActive(DataSet: TDataSet): boolean;
var DataLinkChild: TfcTreeDataLink;
begin
    result:= False;
    if DataSet=nil then
    begin
       result:= True;
       exit;
    end;
    DataLinkChild:= GetDataLink(DataSet);
    if DataLinkChild=nil then exit;

    repeat
       DataLinkChild:= GetChildDataLink(DataLinkChild.DataSet);
    until (DataLinkChild=nil) or (DataLinkChild.DataSet = ActiveDataSet);
    if (DataLinkChild<>nil) then result:= True;
end;

procedure TfcDBCustomTreeView.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
   inherited;
   message.result:= DLGC_WANTARROWS;
end;

function TfcDBCustomTreeView.GetHitTestInfoAt(X, Y: Integer): TfcTreeHitTests;
var
  cbPoint: TPoint;
  Node: TfcDBTreeNode;
  Row: integer;
  r: TRect;
begin
  X:= X + HorzScrollBar.position;

  Result := [];
  MouseToRow(X, Y, Row);
  if not RowToNode(Row, Node) then exit;

  r:= LevelRect(Node);

  if dtvoShowButtons in Options then
  begin
     if (r.Left<>r.right) and (r.Top<>r.Bottom) then begin
        cbPoint:= GetCenterPoint(r);
        if (abs(GetStartX(Node)-x) <7) and (abs(cbPoint.y-y)<7) then
        begin
           result:= result + [fchtdOnButton];
           exit;
        end
     end;
  end;


  if UseStateImages(Node) then begin
     if (x>r.Right) and (x<r.Right + GetStateImageWidth) then
     begin
        result:= result + [fchtdOnStateIcon];
        exit;
     end
  end;

  if (Images<>nil) and (x>r.Right + GetStateImageWidth) and
     (x<r.Right + GetStateImageWidth + TImageList(Images).Width) then
  begin
     result:= result + [fchtdOnImageIcon];
     exit;
  end;

  R:= TextRect(Node, Row);
  if (x>=R.Left) and (x<=R.Right) then
  begin
     result:= result + [fchtdOnText];
     exit;
  end;


//  THitTest = (htAbove, htBelow, htNowhere, htOnItem, htOnButton, htOnIcon,
//    htOnIndent, htOnLabel, htOnRight, htOnStateIcon, htToLeft, htToRight);

end;

procedure TfcDBCustomTreeView.ResetStartOffsets(ActiveDataSet: TDataSet);
var i: integer;
    clear: boolean;
begin
   Clear:= False;
   for i:= 0 to FDataLinks.Count-1 do begin
      if ActiveDataSet = TfcTreeDataLink(FDataLinks[i]).dataset then
         Clear:= True;
      if Clear then StartOffsets[i]:= 0;
   end;
end;

Procedure TfcDBCustomTreeView.SetStartOffset(ActiveDataSet: TDataSet; val: integer);
var i: integer;
begin
   for i:= 0 to FDataLinks.Count-1 do
      if ActiveDataSet = TfcTreeDataLink(FDataLinks[i]).DataSet then
         StartOffsets[i]:= val;
end;

Function TfcDBCustomTreeView.GetStartOffset: integer;
var StartOffset: integer;
   Function GetOffset(Dataset: TDataSet): integer;
   var i: integer;
   begin
      result:= 0;
      for i:= 0 to FDataLinks.Count-1 do
      begin
         result:= fcmax(result, StartOffsets[i]);
         if DataSet = TfcTreeDataLink(FDataLinks[i]).DataSet then
         begin
            break;
         end
      end;
   end;


begin
   StartOffset:= GetOffset(LastVisibleDataSet);
   if ActiveNodeIndex<StartOffset then StartOffset:= GetOffset(ActiveDataSet);
   result:= StartOffset;
end;

procedure TfcDBCustomTreeView.SetImages(Value: TCustomImageList);
begin
  FImages := Value;
  invalidateClient;
end;

procedure TfcDBCustomTreeView.SetStateImages(Value: TCustomImageList);
begin
  FStateImages := Value;
  invalidateClient;
end;

function TfcDBCustomTreeView.UseStateImages(Node: TfcDBTreeNode): Boolean;
begin
  result := ((StateImages <> nil) and (Node.StateIndex >= 0) and
    (Node.StateIndex < StateImages.Count));
  if not Result then
     if MultiSelectCheckBoxNeeded(Node) then result:= True
end;

procedure TfcDBCustomTreeView.WMSetFocus(var Message: TWMSetFocus);
begin
   inherited;
   invalidateClient;
end;

procedure TfcDBCustomTreeView.CMExit(var Message: TMessage);
begin
   inherited;
   invalidateClient;
end;

procedure TfcDBCustomTreeView.UpdateScrollBar;
var
  recCount: longint;
  DataLink: TfcTreeDataLink;
  OldMax, OldPosition: integer;
begin
//  if not FShowVertScrollBar then exit;
  if FDataLinks.count<=0 then exit;


  if FScrollWithinLevel then
     DataLink:= GetDataLink(ActiveDataSet)
  else DataLink:= nil;

  if DataLink=Nil then DataLink:= TfcTreeDataLink(FDataLinks[0]);

  if Datalink.Active and HandleAllocated then
  begin

//    recNum:= 0;
//    recCount:= 0;

    { Set scroll bar precisely }
    if DataLink.DataSet.isSequenced then with DataLink.DataSet do
    begin
       DataLink.DataSet.UpdateCursorPos;
       recCount:= DataLink.DataSet.RecordCount;
//       recNum:= DataLink.DataSet.RecNo;
       with VertScrollBar do begin
          FixedThumbSize:= False;
          OldMax:= Max;
          OldPosition:= Position;
          PageSize:= CacheSize;
          Min:=1;
          Max:= fcMax(recCount + PageSize-1, PageSize+1);
          if State in [dsInactive, dsBrowse, dsEdit] then
          begin
             if BOF then position := 0
             else if EOF then position := fcMax(recCount, 2)
             else position:= recNo;
          end
          else Position := RecNo;  // else keep old pos
          if (OldPosition<>Position) or (Max<>OldMax) then
          begin
             VertScrollBar.invalidate;
          end;
       end;
    end
    else with Datalink.DataSet do
    begin
       with VertScrollBar do begin
          OldPosition:= Position;
          PageSize:= 1;
          Min:=0;
          Max:= 40;
          if BOF then Position := 0
          else if EOF then Position := 40
          else Position := 20;
          if (not FixedThumbSize) or (OldPosition<>Position) then
          begin
             FixedThumbSize:= True;
             VertScrollBar.invalidate;
          end;
       end
    end
  end
end;

procedure TfcDBCustomTreeView.CreateWnd;
begin
  inherited CreateWnd;
  UpdateScrollBarPosition;
  LayoutChanged;
  UpdateScrollBar;
end;

procedure TfcDBCustomTreeView.HScroll(ScrollCode: integer; Position: integer);
begin
   if Position<>HorzScrollBar.PriorPosition then
      invalidateClient;
end;

  procedure TfcDBCustomTreeView.NextRow(WithinLevel: boolean);
  var ActiveDataLink: TfcTreeDataLink;
  begin

    ActiveDataLink:= GetDataLink(ActiveDataSet);
    if ActiveDataLink=Nil then ActiveDataLink:= TfcTreeDataLink(FDataLinks[0]);

    if WithinLevel then
    begin
       if ActiveDataLink.ActiveRecord>=ActiveDataLink.RecordCount-1 then
       begin
          ActiveDataLink.DataSet.MoveBy(1);
       end
       else begin
          ActiveDataLink.DataSet.Next;
       end;
       exit;
    end;


    with ActiveDatalink.Dataset do
    begin
       if Eof and (ActiveDataLink.ActiveRecord>=0) and
         (ActiveDataLink.ActiveRecord<ActiveDataLink.RecordCount-1) and not (State=dsInsert) then
       begin
          ActiveDataLink.ActiveRecord:= ActiveDataLink.ActiveRecord + 1
       end
       else begin
          Next;
          if Eof then begin
             if GetParentDataLink(ActiveDataSet)<>nil then
             begin
                ActiveDataSet:= GetParentDataLink(ActiveDataSet).DataSet;
                LastVisibleDataSet:= ActiveDataSet; { 12/7/98 }
                NextRow(False);
             end
          end
       end
    end;
  end;

  { Move to next node for activedataset }
  procedure TfcDBCustomTreeView.NextPage(WithinLevel: boolean);
  var ActiveDataLink: TfcTreeDataLink;
  begin
    ActiveDataLink:= GetDataLink(ActiveDataSet);
    if ActiveDataLink=Nil then ActiveDataLink:= TfcTreeDataLink(FDataLinks[0]);

    if WithinLevel then begin
       ActiveDataLink.DataSet.MoveBy(CacheSize);
       exit;
    end;

    with ActiveDatalink.Dataset do
    begin
       ActiveDataLink.DataSet.MoveBy(CacheSize);
       if Eof then begin
          if GetParentDataLink(ActiveDataSet)<>nil then
          begin
             ActiveDataSet:= GetParentDataLink(ActiveDataSet).DataSet;
             LastVisibleDataSet:= ActiveDataSet; { 12/7/98 }
             NextRow(False);
          end
       end
    end;
  end;

  procedure TfcDBCustomTreeView.PriorRow(WithinLevel: boolean);
  var ActiveDataLink: TfcTreeDataLink;
  begin
     ActiveDataLink:= GetDataLink(ActiveDataSet);
     if ActiveDataLink=Nil then ActiveDataLink:= TfcTreeDataLink(FDataLinks[0]);

     if WithinLevel then
     begin
        if ActiveDataLink.ActiveRecord<=0 then
        begin
           ActiveDataLink.DataSet.MoveBy(-1);
           if ActiveDataLink.DataSet.Bof then
           begin
              StartOffsets[GetDataLinkIndex(ActiveDataLink.DataSet)]:= 0;
              InvalidateClient; { 4/9/99 }
           end
        end
        else begin
           ActiveDataLink.DataSet.Prior;
        end;
        exit;
     end;

     with ActiveDatalink.Dataset do
	if BOF and (ActiveDataLink.ActiveRecord>0) then
	   ActiveDataLink.ActiveRecord:= ActiveDataLink.ActiveRecord - 1
	else begin
           Prior;
           if bof then begin
             if GetParentDataLink(ActiveDataSet)<>nil then
             begin
                ActiveDataSet:= GetParentDataLink(ActiveDataSet).DataSet;
                LastVisibleDataSet:= ActiveDataSet; { 12/7/98 }
                invalidateClient;
             end
           end
        end;
  end;

  procedure TfcDBCustomTreeView.PriorPage(WithinLevel: boolean);
  var ActiveDataLink: TfcTreeDataLink;
  begin
     ActiveDataLink:= GetDataLink(ActiveDataSet);
     if ActiveDataLink=Nil then ActiveDataLink:= TfcTreeDataLink(FDataLinks[0]);

     if WithinLevel then
     begin
        ActiveDataLink.DataSet.MoveBy(-CacheSize);
        if ActiveDataLink.DataSet.Bof then begin
           StartOffsets[GetDataLinkIndex(ActiveDataLink.DataSet)]:= 0;
           InvalidateClient; { 4/9/99 }
        end;
        exit;
     end;
     with ActiveDatalink.Dataset do begin
       ActiveDataLink.DataSet.MoveBy(-CacheSize);
       if BOF then begin
          if GetParentDataLink(ActiveDataSet)<>nil then
          begin
             ActiveDataSet:= GetParentDataLink(ActiveDataSet).DataSet;
             LastVisibleDataSet:= ActiveDataSet; { 12/7/98 }
             InvalidateClient;
          end
       end
     end
  end;

procedure TfcDBCustomTreeView.VScroll(ScrollCode: integer; Position: integer);
var DataLink: TfcTreeDataLink;
  Function Sequencable: boolean;
  begin
     result:= DataLink.DataSet.isSequenced;
  end;

  procedure ParadoxPosition;
  var recNum : Longint;
  begin
     with DataLink.DataSet do begin
        recNum:= position;
        checkBrowseMode;
        RecNo:= recNum;
        resync([]);
     end;
  end;


  procedure MoveToFirst;
  var ActiveDataLink: TfcTreeDataLink;
  begin
    ActiveDataLink:= GetDataLink(ActiveDataSet);
    if ActiveDataLink=Nil then ActiveDataLink:= TfcTreeDataLink(FDataLinks[0]);

    StartOffsets[GetDataLinkIndex(ActiveDataLink.DataSet)]:= 0;
    InvalidateClient;
  end;


begin
  if not CanFocus then Exit;
  if not HaveValidDataLinks then exit;

  SetFocus;
  if FScrollWithinLevel then
     DataLink:= GetDataLink(ActiveDataSet)
  else DataLink:= nil;
  if DataLink=Nil then DataLink:= TfcTreeDataLink(FDataLinks[0]);

  if Datalink.Active then
    with DataLink.DataSet, Datalink do begin
      case ScrollCode of
	SB_LINEUP: PriorRow(FScrollWithinLevel);
	SB_LINEDOWN: NextRow(FScrollWithinLevel);
	SB_PAGEUP: PriorPage(FScrollWithinLevel);
	SB_PAGEDOWN: NextPage(FScrollWithinLevel);
	SB_THUMBPOSITION:
	  begin
	    if Sequencable then begin
               LastVisibleDataSet:= DataLink.DataSet;
	       if position<=1 then
               begin
                  First;
                  MoveToFirst;
               end
	       else if position>=DataLink.DataSet.recordCount then
                  Last
	       else ParadoxPosition;
	    end
	    else begin
               if position=0 then begin
                  LastVisibleDataSet:= DataLink.DataSet;
                  First;
                  MoveToFirst;
               end
               else if position=40 then begin
                  LastVisibleDataSet:= DataLink.DataSet;
                  Last;
               end
               else if Bof then begin
                  MoveBy(CacheSize);
               end
               else if Eof then begin
                  MoveBy(-CacheSize);
               end
               else if position<20 then begin
                  MoveBy(-CacheSize);
               end
               else if position>20 then begin
                  MoveBy(CacheSize);
               end
               else if position<20 then begin
                  MoveBy(-CacheSize);
               end;
{	       case Position of
		 0: begin
                       LastVisibleDataSet:= DataLink.DataSet;
                       First;
                    end;
		 1: MoveBy(-CacheSize);
		 2: exit;
		 3: MoveBy(CacheSize);
		 4: begin
                       LastVisibleDataSet:= DataLink.DataSet;
                       Last;
                    end;
	       end;}
	    end
	  end;

	SB_BOTTOM: begin
           LastVisibleDataSet:= DataLink.DataSet;
           Last;
        end;

	SB_TOP: begin
           LastVisibleDataSet:= DataLink.DataSet;
           First;
        end;
      end;
   end;
end;


(*
procedure TfcDBCustomTreeView.WMVScroll(var Message: TWMVScroll);
var DataLink: TfcTreeDataLink;
  Function Sequencable: boolean;
  begin
     result:= DataLink.DataSet.isSequenced;
  end;

  procedure ParadoxPosition;
  var recNum : Longint;
      {$ifndef wwDelphi3Up}
      recCount: Longint;
      {$endif}
  begin
     with DataLink.DataSet do begin
        recNum:= Message.Pos; // * recordCount) div GridScrollSize;
        checkBrowseMode;
        RecNo:= recNum;
        LastVisibleDataSet:= DataLink.DataSet;
        resync([]);
     end;
  end;

begin
  if not CanFocus then Exit;
  if not HaveValidDataLinks then exit;

  SetFocus;
  DataLink:= TfcTreeDataLink(FDAtaLinks[0]);
  if Datalink.Active then
    with Message, DataLink.DataSet, Datalink do
      case ScrollCode of
	SB_LINEUP: PriorRow(FScrollWithinLevel);
	SB_LINEDOWN: NextRow(FScrollWithinLevel);
	SB_PAGEUP: PriorPage(FScrollWithinLevel);
	SB_PAGEDOWN: NextPage(FScrollWithinLevel);
	SB_THUMBPOSITION:
	  begin
	    if Sequencable then begin
	       if pos<=1 then
                  First
	       else if pos>=DataLink.DataSet.recordCount then
                  Last
	       else ParadoxPosition;
	    end
	    else begin
	       case Pos of
		 0: First;
		 1: MoveBy(-CacheSize);
		 2: exit;
		 3: MoveBy(CacheSize);
		 4: Last;
	       end;
	    end
	  end;

	SB_BOTTOM: Last;
	SB_TOP: First;
      end;
end;
*)

Function TfcDBCustomTreeView.MultiSelectCheckboxNeeded(Node: TfcDBTreeNode): boolean;
begin
   with FMultiSelectAttributes do
      result:= Enabled and MultiSelectCheckbox and (ValidMultiSelectLevel(Node.Level))
end;

function TfcDBCustomTreeView.ValidMultiSelectLevel(ALevel: Integer): Boolean;
begin
  result := (FMultiSelectAttributes.MultiSelectLevel = ALevel) or
            (FMultiSelectAttributes.MultiSelectLevel = -1);
end;


constructor TfcDBMultiSelectAttributes.Create(Owner: TComponent);
begin
   TreeView:= Owner as TfcDBCustomTreeView;
   FAutoUnselect:= False;
   FMultiSelectCheckbox:= True;
end;

procedure TfcDBMultiSelectAttributes.Assign(Source: TPersistent);
var tsa: TfcDBMultiSelectAttributes;
begin
   If Source is TfcDBMultiSelectAttributes then
   begin
      tsa:= TfcDBMultiSelectAttributes(Source);
      Enabled:= tsa.Enabled;
      MultiSelectCheckbox:= tsa.MultiSelectCheckbox;
      MultiSelectLevel:= tsa.MultiSelectLevel;
   end
   else inherited Assign(Source);
end;

procedure TfcDBMultiSelectAttributes.SetEnabled(val: boolean);
//var Node: TfcDBTreeNode;
begin
   if val<>FEnabled then
   begin
      FEnabled:= val;
      TreeView.invalidateClient;
   end
end;

procedure TfcDBMultiSelectAttributes.SetMultiSelectCheckBox(val: boolean);
begin
   if val<>FMultiSelectCheckbox then
   begin
      FMultiSelectCheckbox:= val;
      TreeView.invalidateClient;
   end
end;

procedure TfcDBMultiSelectAttributes.SetMultiSelectLevel(val: integer);
begin
   if val<>FMultiSelectLevel then
   begin
      FMultiSelectLevel:= val;
      (TreeView as TfcDBCustomTreeView).UnselectAll;
      TreeView.InvalidateClient;
   end
end;

{$ifdef fcDelphi4Up}
procedure TfcDBCustomTreeView.SelectAll(ADataSet: TDataSet);
var saveBK : TBookmark;
    MultiSelectItem: TfcMultiSelectItem;
begin
   UnselectAll;

   with ADataset do
   begin
      saveBK := GetBookmark;  { Save current record position }
      CheckBrowseMode;  { bookmarks don't work in edit mode }
      DisableControls;
      First;
      while (not Eof) do begin
         MultiSelectItem:= TfcMultiSelectItem.create;
         with MultiSelectItem do
         begin
            Bookmark:= GetBookmark;
            DataSet:= ADataSet;
         end;
         FMultiSelectList.Add(MultiSelectItem);
         Next;
      end;
      GotoBookmark(saveBK);  { Restore original record position}
      Freebookmark(saveBK);
      EnableControls;
   end
end;
{$endif}

procedure TfcDBCustomTreeView.UnselectAll;
var i: integer;
begin
   for i:= 0 to FMultiSelectList.Count-1 do
   begin
      MultiSelectList[i].DataSet.Freebookmark(MultiSelectList[i].Bookmark);
      MultiSelectList[i].Free;
   end;
   FMultiSelectList.Clear;
   InvalidateClient;
end;

procedure TfcDBCustomTreeView.SelectRecord;
var MultiSelectItem: TfcMultiSelectItem;
begin
  MultiSelectItem:= TfcMultiSelectItem.create;
  with MultiSelectItem do
  begin
     ActiveDataSet.CheckBrowseMode;  { bookmarks don't work in edit mode }
     if IsSelectedRecord then exit;
     Bookmark:= ActiveDataSet.GetBookmark;
     DataSet:= ActiveDataSet;
  end;
  FMultiSelectList.Add(MultiSelectItem);
  InvalidateClient;
end;

Procedure TfcDBCustomTreeView.UnselectRecord;
var MultiSelectItem: TfcMultiSelectItem;
    MultiSelectItemIndex: integer;
begin
    MultiSelectItemIndex:= FindCurrentMultiSelectIndex(ActiveDataSet);
    if MultiSelectItemIndex<0 then exit; { Can't unselect since its not selected }

    MultiSelectItem:= MultiSelectList[MultiSelectItemIndex];
    MultiSelectItem.DataSet.Freebookmark(MultiSelectItem.Bookmark);
    MultiSelectItem.Free;
    FMultiSelectList.Delete(MultiSelectItemIndex);

    InvalidateClient;
end;

Function TfcDBCustomTreeView.IsSelectedRecord: boolean;
begin
   result:= FindCurrentMultiSelectIndex(ActiveDataSet)>=0;
end;

Function TfcDBCustomTreeView.FindCurrentMultiSelectIndex(DataSet: TDataSet): integer;
var i: integer;
    curBookmark: Tbookmark;
    thisTable: TDataset;
    res: CmpBkmkRslt;
begin
   thisTable:= DataSet;
   if (thisTable.state=dsEdit) or (thisTable.state=dsInsert) then begin
      result:= -1;
      exit;
   end;

   curBookmark:= thisTable.getBookmark;

   result:= -1;
   if curBookmark=Nil then exit;

   for i:= 0 to FMultiSelectList.count-1 do begin
      if thisTable<>MultiSelectList[i].DataSet then continue;
      if MultiSelectList[i]=nil then continue;

      res:= thisTable.CompareBookmarks(MultiSelectList[i].Bookmark, curBookmark);
      if (res=CMPKeyEql) or (res=CMPEql) then begin
         result:= i;
         break;
      end
   end;

   thisTable.freebookmark(curBookmark);

end;


function TfcDBCustomTreeView.GetMultiSelectItem(Index: integer): TfcMultiSelectItem;
begin
   result:= TfcMultiSelectItem(FMultiSelectList[Index]);
end;

procedure TfcDBCustomTreeView.CMFontChanged(var Message: TMessage);
begin
  inherited;
  LayoutChanged;
end;

procedure TfcDBCustomTreeView.LayoutChanged;
var i: Integer;
    DataLink: TfcTreeDataLink;
//    SINew: TScrollInfo;
    NewCacheSize: integer;
begin
  Canvas.Font := Font;
  RowHeight:= Canvas.Textheight('W') + 2;
  RowHeight:= fcmax(RowHeight, 16);

  if StateImages<>nil then
     RowHeight:= fcmax(RowHeight, TImageList(StateImages).Height);
  if Images<>nil then
     RowHeight:= fcmax(RowHeight, TImageList(Images).Height);
  RowHeight:= ((RowHeight+1) div 2) * 2; { Row height must be even }
  if BorderStyle=bsNone then  { 5/25/99 }
     NewCacheSize:= Height div RowHeight
  else
     NewCacheSize:= (Height-4) div RowHeight;
  if (dtvoShowHorzScrollBar in Options) and HandleAllocated then begin
     if HorzScrollBar.PageSize<HorzScrollBar.Max then
     begin
        if BorderStyle=bsNone then  { 5/25/99 }
           NewCacheSize:= (Height-GetSystemMetrics(SM_CYHSCROLL)) div RowHeight
        else
           NewCacheSize:= (Height-GetSystemMetrics(SM_CYHSCROLL) - 4) div RowHeight
     end
  end;
  if NewCacheSize<>CacheSize then begin
     CacheSize:= NewCacheSize;
     for i:= 0 to FDataLinks.Count-1 do
     begin
        DataLink:= TfcTreeDataLink(FDataLinks[i]);
//        if DataLink.Active then  { 3/31/99- Still set BufferCount so that its accurate}
        begin
           DataLink.BufferCount:= CacheSize;
        end
     end;
  end;
  if InPaint then
     CheckMaxWidthGrow:= True { 3/10/99 }
  else
     CheckMaxWidth:= True;
  InvalidateClient;
end;

procedure TfcDBCustomTreeView.Loaded;
begin
  inherited Loaded;
  if DataSources<>'' then
     RefreshDataLinks(FFirstDataLink.DataSource, FLastDataLink.DataSource);
  LayoutChanged;
end;

procedure TfcDBCustomTreeView.FreeHintWindow;
begin
   HintTimerCount:= 0;
   SkipErase:= True;
   HintWindow.Free;
   SkipErase:= False;
   HintWindow:= nil;
   if HintTimer<>nil then
      HintTimer.enabled:= False;
//   LastHintRow:= -1;
end;

procedure TfcDBCustomTreeView.HintTimerEvent(Sender: TObject);
var
    sp, cp: TPoint;
    OutsideClient: boolean;
begin
   if (dtvoHotTracking in Options) or (HintWindow<>nil) then
   begin
      GetCursorPos(cp);
      sp:= self.ClientToScreen(Point(0, 0));
      if (cp.x<sp.x) or (cp.x>sp.x+ClientRect.Right-ClientRect.Left) or
         (cp.y<sp.y) or (cp.y>sp.y+ClientRect.Bottom-ClientRect.Top) then
      begin
         OutsideClient:= True;
      end
      else OutsideClient:= False;
   end
   else exit;


   if (dtvoHotTracking in Options) then
   begin
      if Outsideclient and (HotTrackRow>=0) then
         InvalidateClient;
      exit; { Don't display hint window if hot-tracking }
   end;

   { Process Hint Timer clean-up}
   if OutsideClient then
   begin
      FreeHintWindow;
      LastHintRow:= -1;
      exit;
   end;

   inc(HintTimerCount);
   if HintTimerCount>16 then
   begin
      FreeHintWindow;
      exit;
   end;

end;

procedure TfcDBCustomTreeView.MouseMove(Shift: TShiftState; X, Y: Integer);
var Row: integer;
    Node: TfcDBTreeNode;
    R: TRect;
    SP: TPoint;
    HintText: string;
    DoDefault: boolean;
    ValidNode: boolean;
begin
   inherited MouseMove(Shift, X, Y);

   if not (Assigned(FOnMouseMove) or (dtvoShowNodeHint in Options)) then exit;
   sp:= self.ClientToScreen(Point(0, 0));
   MouseToRow(X, Y, Row);
   ValidNode:= RowToNode(Row, Node);

   if (dtvoHotTracking in Options) and ValidNode then begin
      if (Row<>HotTrackRow) then
      begin
         InvalidateClient;
         HotTrackRow:= Row;
      end
      else begin
         InvalidateClient;
      end;
      FreeHintWindow;
      HintTimer.Free;
      HintTimer:= nil;

      HintTimer:= TTimer.create(self);
      HintTimer.OnTimer:=HintTimerEvent;
      HintTimer.Interval:=250;
      HintTimer.Enabled:= True;
      if Assigned(FOnMouseMove) then FOnMouseMove(self, Node, Shift, X, Y);
      exit;
   end;

   if Assigned(FOnMouseMove) then FOnMouseMove(self, Node, Shift, X, Y);

   if not ValidNode then exit;
   if not (dtvoShowNodeHint in Options) then exit;

   { Show hint window on node that mouse is over}
   sp:= self.ClientToScreen(Point(0, 0));
   MouseToRow(X, Y, Row);
   if not RowToNode(Row, Node) then exit;
   if (x < LevelRect(Node).Right) then exit;

   if (Row<>LastHintRow) and (Row>=0) then begin
      FreeHintWindow;
      HintTimer.Free;
      HintTimer:= nil;

      if TextRect(Node, Row).Left+Canvas.TextWidth(Node.Text)>
         Width-GetSystemMetrics(SM_CXHThumb)-6 then
      begin
         HintWindow:= CreateHintWindow;
         HintTimer:= TTimer.create(self);
         HintTimer.OnTimer:=HintTimerEvent;
         HintTimer.Interval:=250;
         HintTimer.Enabled:= True;

         with HintWindow do
         begin
            R:= TextRect(Node, Row);
//            R.Left:= r.left + sp.x - 2 - GetScrollPos(self.Handle, SB_HORZ);
            R.Left:= r.left + sp.x - 2 - HorzScrollBar.position; //GetScrollPos(self.Handle, SB_HORZ);
            R.Right:= r.Right + sp.x + 2;
            if not odd(fcRectHeight(R) div 2) then
            begin
               R.Top:= R.Top + sp.y - 3;
               R.Bottom:= R.Bottom + sp.y - 3;
            end
            else begin
               R.Top:= R.Top + sp.y - 2;
               R.Bottom:= R.Bottom + sp.y - 2;
            end;
            HintText:= Node.Text;
            DoDefault:= True;
//            DoActivateHint(HintWindow, Node, HintText, DoDefault);
            if DoDefault then begin
              R.Right:= R.Left + FPaintCanvas.TextWidth(HintText) + 6;
              ActivateHint(R, HintText);
            end;

         end;
      end;
      LastHintRow:= Row;
   end
end;

procedure TfcDBCustomTreeView.InvalidateRow(Row: integer);
var r: TRect;
begin
   r.Top:= Row * RowHeight;
   r.Bottom:= (Row+1) * RowHeight -1;
   r.Left:= 0;
   r.Right:= GetClientRect.Right; //Width;
   InvalidateRect(Handle, @r, True);
end;

procedure TfcDBCustomTreeView.InvalidateNode(Node: TfcDBTreeNode);
var r: TRect;
begin
   r:= LevelRect(Node);
   r.Left:= 0;
   r.Right:= Width;
   InvalidateRect(Handle, @r, True);
end;

function TfcDBCustomTreeView.GetMultiSelectListCount: integer;
begin
  result:= FMultiSelectList.Count;
end;

procedure TfcDBCustomTreeView.Change(FSelected: TfcDBTreeNode);
begin
   if Assigned(FOnChange) then
      FOnChange(Self, FSelected);
end;

procedure TfcDBCustomTreeView.DoUserExpand(Node: TfcDBTreeNode);
begin
   if Assigned(FOnUserExpand) then
      FOnUserExpand(Self, Node);
end;

procedure TfcDBCustomTreeView.DoUserCollapse(Node: TfcDBTreeNode);
begin
   if Assigned(FOnUserCollapse) then
      FOnUserCollapse(Self, Node);
end;

{procedure TfcDBCustomTreeView.DoActivateHint(
   HintWindow: THintWindow; FSelected: TfcDBTreeNode;
   var HintText: string; var DoDefault: boolean);
begin
   if Assigned(FOnActivateHint) then
   begin
      DoDefault:= True;
      FOnActivateHint(Self, HintWindow, FSelected, HintText, DoDefault);
   end
end;
}
type
  TfcDBTreeHintWindow=class(THintWindow)
  protected
     procedure Paint; override;
//  public
//     Node: TfcTreeNode;
  end;

procedure TfcDBTreeHintWindow.Paint;
var
  R: TRect;
begin
  R := ClientRect;
  Inc(R.Left, 2);
  Inc(R.Top, 2);
  Canvas.Font.Color := clInfoText;

  SetBkMode(Canvas.Handle, TRANSPARENT);
  DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_NOPREFIX or
    DT_WORDBREAK);
end;

Function TfcDBCustomTreeView.CreateHintWindow: THintWindow;
begin
   HintWindow:= TfcDBTreeHintWindow.create(self);
   HintWindow.Color:= GetSysColor(COLOR_INFOBK);
   HintWindow.Canvas.Brush.Color:= GetSysColor(COLOR_INFOBK);
   HintWindow.Canvas.Font:= self.Font;
   HintWindow.Canvas.Font.Color:= GetSysColor(COLOR_INFOTEXT);
   HintWindow.Canvas.Pen.Color:= clBlack;
   result:= HintWindow;
end;

Function TfcDBCustomTreeView.GetStateImageWidth: integer;
begin
   if StateImages<>nil then result:= TImageList(StateImages).Width
   else result:= 16;
end;

Function TfcDBCustomTreeView.HaveValidDataLinks: boolean;
var i: Integer;
begin
   result:= FDataLinks.Count>0;
   for i:= 0 to FDataLinks.count-1 do
   begin
      if TfcTreeDataLink(FDataLinks[i]).DataSet=nil then result:= False;
      if not TfcTreeDataLink(FDataLinks[i]).Active then result:= False;
   end;
{
   result:= false;
   if FDataLinks.count<=0 then exit;
   DataLink:= TfcTreeDataLink(FDataLinks[0]);
   if datalink.dataset = nil then exit;
   if not datalink.active then exit;
   result:= true;}
end;

Procedure TfcDBCustomTreeView.ToggleMultiSelection(
       RequireControlKey: boolean; Shift: TShiftState);
begin
   if (ActiveNode<>nil) then begin
       if MultiSelectAttributes.Enabled and
          (ValidMultiSelectLevel(ActiveNode.Level)) then
       begin
          if RequireControlKey then
          begin
             if (ssCtrl in Shift) then
             begin
                if IsSelectedRecord then UnselectRecord
                else SelectRecord;
             end;
          end
          else begin
             if IsSelectedRecord then UnselectRecord
             else SelectRecord;
          end
       end;
    end;
end;

procedure TfcDBCustomTreeView.WMSize(var Message: TWMSize);
begin
  inherited;
  ResetScroll:= True;
  UpdateScrollBarPosition;
  LayoutChanged;
end;

{$ifdef fcDelphi4Up}
procedure TfcDBCustomTreeView.SetHideUpDownButtons(val: boolean);
begin
   if val<>FHideUpDownButtons then
   begin
      FHideUpDownButtons:=val;
      UpTreeButton.visible:= not val;
      DownTreeButton.visible:= not val;
      UpdateScrollBarPosition;
   end
end;
{$endif}

procedure TfcDBCustomTreeView.UpdateScrollBarPosition;
var
   VertHeight: integer;
//   curBottom: integer;
   ButtonHeight: integer;
begin
  { 5/25/99 - Fix BorderStyle=bsNone bug where horizontal scrollbar and
    buttons drawn in wrong position }
  ButtonHeight := GetSystemMetrics(SM_CXVSCROLL) + 1;
  if (VertScrollBar<>nil) then
  begin
     if BorderStyle=bsNone then
        VertHeight:= Height
     else
        VertHeight:= Height - 4;
     {$ifdef fcDelphi4Up}
     if UpTreeButton.visible and (not FHideUpDownButtons) then
     {$else}
     if UpTreeButton.visible then
     {$endif}

        VertHeight:= VertHeight - ButtonHeight + 1;
     VertScrollBar.Height:= VertHeight;
     VertScrollBar.Width:= ButtonHeight - 1;
     VertScrollBar.Left:= GetClientRect.Right;
  end;

  if (HorzScrollBar<>nil) then with HorzScrollBar do
  begin
     Left:=  0;
     if BorderStyle=bsNone then
        Width:= fcMax(0, self.Width - VertScrollBar.Width)
     else
        Width:= fcMax(0, self.Width - 4 - VertScrollBar.Width);
     Height:=
        GetSystemMetrics(SM_CYHSCROLL);
     if BorderStyle=bsNone then
       Top:= self.Height - Height
     else
       Top:= self.Height - Height - 4;
  end;
  with UpTreeButton do
  begin
     Height:= ButtonHeight;
     Width:= ButtonHeight;
     Top:= VertScrollBar.height;
     Left:= VertScrollBar.Left;
  end;
  with DownTreeButton do
  begin
     Height:= ButtonHeight;
     Width:= ButtonHeight;
     Top:= VertScrollBar.height;
     Left:= VertScrollBar.Left;
  end;

end;

procedure TfcDBCustomTreeView.SetLevelIndent(val: integer);
begin
   if FLevelIndent<>val then
   begin
      FLevelIndent:= val;
      InvalidateClient;
   end
end;

procedure TfcDBCustomTreeView.SetDisplayFields(Value: TStrings);
begin
   FDisplayFields.Assign(Value);
   InvalidateClient;
end;

procedure TfcDBCustomTreeView.MakeActiveDataSet(DataSet: TDataSet; Collapse: boolean);
begin
//   self.Update;  { Finish painting operations }

   ActiveDataSet:= DataSet;
   if Collapse then LastVisibleDataSet:= DataSet
   else begin
      if IsMasterDataSetOfActive(LastVisibleDataSet) then
         LastVisibleDataSet:= DataSet;
   end;
   invalidateClient;
end;


{ Make room for scroll bar if its shown }
function TfcDBCustomTreeView.GetClientRect: TRect;
begin
   result:= inherited GetClientRect;
   if VertScrollBar<>nil then
   begin
      result.Right:= result.Right - VertScrollBar.Width;
   end;

   if InComputeHorzWidthOnly then exit;

   if (HorzScrollBar<>nil) and
      (HorzScrollBar.Max-HorzScrollBar.Min>HorzScrollBar.PageSize) then
   begin
      result.Bottom:= result.Bottom - HorzScrollBar.Height;
      if not HorzScrollBar.visible then begin
         HorzScrollBar.visible:= True;
         LayoutChanged;
         HorzScrollBar.invalidate;
      end
   end
   else begin
      if HorzScrollBar.visible then begin
         HorzScrollBar.visible:= False;
         HorzScrollBar.Max:= 5;
         HorzScrollBar.PageSize:= 10;
         LayoutChanged;
      end
   end;
end;

procedure TfcDBCustomTreeView.InvalidateClient;
var r: TRect;
begin
   if not HandleAllocated then exit;
   r:= GetClientRect;
   InvalidateRect(Handle, @r, False);
end;

procedure TfcDBCustomTreeView.TreeUpClick(Sender : TObject);
begin
   if ActiveNode=nil then exit;
   
   if (ActiveNode.Parent<>nil) then
      Collapse(ActiveNode.Parent)
   else
      Collapse(ActiveNode);
end;

procedure TfcDBCustomTreeView.TreeDownClick(Sender : TObject);
begin
   Expand(ActiveNode);
end;

procedure TfcTreeVertScrollBar.Scroll(ScrollCode: integer; Position: integer);
begin
   inherited;
   (Parent as TfcDBCustomTreeView).VScroll(ScrollCode, Position);
end;

procedure TfcTreeHorzScrollBar.Scroll(ScrollCode: integer; Position: integer);
begin
   inherited;
   (Parent as TfcDBCustomTreeView).HScroll(ScrollCode, Position);
end;

function TfcDBCustomTreeView.CreateUpTreeButton: TfcShapeBtn;
var bm: TBitmap;
    resName: string;
begin
   UpTreeButton:= TfcShapeBtn.create(self);
   with UpTreeButton do begin
     Width := 17;
     Height := 17;
     Color := clBtnFace;
     Orientation := soUp;
     PointList.Add('0,0');
     PointList.Add('Width,0');
     PointList.Add('0,Height');
     PointList.Add('0,0');
     ShadeColors.Btn3DLight := clWhite;
     ShadeColors.BtnHighlight := clBtnFace;
     ShadeColors.BtnBlack := clBlack;
     Shape := bsCustom;
     TabStop:= False;
     offsets.glyphx:= 1;
     offsets.glyphy:= 1;
     bm := TBitmap.Create;
     bm.Transparent := True;
     resName:= 'FCTREEUP';
     bm.LoadFromResourceName(HINSTANCE, resName);
     glyph.assign(bm);
     bm.Free;
     parent:= self;
     OnClick:= TreeUpClick;
   end;

   result:= UpTreeButton;
end;

function TfcDBCustomTreeView.CreateDownTreeButton: TfcShapeBtn;
var bm: TBitmap;
    resName: string;
begin
   DownTreeButton:= TfcShapeBtn.create(self);
   with DownTreeButton do begin
     Width := 17;
     Height := 17;
     Color := clBtnFace;
     Orientation := soDown;
     PointList.Add('0,0');
     PointList.Add('Width,0');
     PointList.Add('0,Height');
     PointList.Add('0,0');
     Shape := bsCustom;
     TabStop:= False;
     offsets.glyphx:= 6;
     offsets.glyphy:= 6;
     bm := TBitmap.Create;
     bm.Transparent := True;
     resName:= 'FCTREEDOWN';
     bm.LoadFromResourceName(HINSTANCE, resName);
     glyph.assign(bm);
     bm.Free;
     parent:= self;
     OnClick:= TreeDownClick;
   end;

   result:= DownTreeButton;
end;

procedure TfcDBCustomTreeView.DoDrawText(TreeView: TfcDBCustomTreeView;
         Node: TfcDBTreeNode; ARect: TRect;
         var DefaultDrawing: boolean);
begin
   DefaultDrawing:= True;
   if Assigned(FOnDrawText) then FOnDrawText(Self, Node, ARect, defaultDrawing);
end;

procedure TfcDBCustomTreeView.WMNCHitTest(var Message: TWMNCHitTest);
begin
  DefaultHandler(Message);
end;

//procedure TfcdbCustomTreeView.CMDesignHitTest(var Message: TCMDesignHitTest);
//begin
//   message.result:= 1;
//   inherited;
//end;

procedure TfcDBCustomTreeView.WndProc(var Message: TMessage);
begin
{   if (csDesigning in ComponentState) then
   begin
      if (Message.Msg = wm_lbuttondown) then
      begin
         ControlState := ControlState + [csLButtonDown];
         Dispatch(Message);
         exit;
      end;
   end;
}
  inherited WndProc(Message);
end;

Function TfcDBCustomTreeView.GetNodeAt(X,Y: integer): TfcDBTreeNode;
var Row: integer;
begin
   MouseToRow(X, Y, Row);
   if not RowToNode(Row, Result) then Result:= nil;
end;

Function TfcDBTreeNode.GetFieldValue(FieldName: string): Variant;
var PrevActiveRecord: integer;
    curField: TField;
begin
   PrevActiveRecord:= DataLink.ActiveRecord;
   DataLink.ActiveRecord:= ActiveRecord;
   curField:= DataSet.FindField(FieldName);
   if curField=nil then result:= NULL
   else result:= curField.Value;
   DataLink.ActiveRecord:= PrevActiveRecord;
end;

procedure TfcDBCustomTreeView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
     if AComponent = Images then Images := nil;
     if AComponent = StateImages then StateImages := nil;
     if (AComponent = FImager) then FImager := nil

  end;
end;

{ Sorts by level, and then by bookmark order }
procedure TfcDBCustomTreeView.SortMultiSelectList;
var res: CmpBkmkRslt;
   Function LessThan(item1, item2: TfcMultiSelectItem): boolean;
   begin
      if item1.DataSet = item2.DataSet then begin
         res:= (item1.DataSet as TDataSet).CompareBookmarks(item1.bookmark, item2.bookmark);
         result:= integer(res)=CmpLESS;
      end
      else begin
         result:= GetDataLinkIndex(item1.dataset)<GetDataLinkIndex(item2.dataset)
      end
   end;
   Function GreaterThan(item1, item2: TfcMultiSelectItem): boolean;
   begin
      if item1.DataSet = item2.DataSet then begin
         res:= (item1.DataSet as TDataSet).CompareBookmarks(item1.bookmark, item2.bookmark);
         result:= integer(res)=CmpGtr;
      end
      else begin
         result:= GetDataLinkIndex(item1.dataset)>GetDataLinkIndex(item2.dataset)
      end
   end;

   procedure Partition(var i, j: integer);
   var Pivot, Temp: TfcMultiSelectItem;
   begin
      Pivot:= MultiSelectList[(i+j) div 2];
      repeat
         while LessThan(MultiSelectList[i], Pivot) do i:= i + 1;
         while GreaterThan(MultiSelectList[j], Pivot) do j:= j - 1;
         if (i<=j) then begin
            Temp:= FMultiSelectList[i];
            FMultiSelectList[i]:= FMultiSelectList[j];
            FMultiSelectList[j]:= Temp;
            i:= i +1;
            j:= j-1;
         end
      until (i>j);
   end;

   procedure QuickSort(m, n: integer);
   var i,j: integer;
   begin
      if (m<n) then begin
         i:= m; j:= n;
         Partition(i, j);
         QuickSort(m,j);
         QuickSort(i,n);
      end
   end;
begin
    QuickSort(0, MultiSelectListCount-1);
end;

procedure TfcDBCustomTreeview.SetImager(Value: TfcCustomImager);
begin
  if FImager <> nil then FImager.UnRegisterChanges(FChangeLink);
  if Value <> nil then
  begin
    Value.FreeNotification(self);
    Value.RegisterChanges(FChangeLink);
    Value.Parent := self;
    if Value.DrawStyle <> dsStretch then
       Value.DrawStyle := dsTile;
//    Value.Align := alClient;
    Value.Visible := False;
    Value.Left:= 0;
    Value.Top:= 0;
    Value.Width:= 25;
    Value.Height:= 25;
  end;
  if Value<>FImager then InvalidateClient;
  FImager := Value;

end;

procedure TfcDBCustomTreeView.ImagerChange(Sender: TObject);
begin
  invalidate;
end;

{$ifdef fcDelphi4Up}

function TfcDBCustomTreeView.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  NextRow(dtvoKeysScrollLevelOnly in Options);
  result := True;
end;

function TfcDBCustomTreeView.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  PriorRow(dtvoKeysScrollLevelOnly in Options);
  result := True;
end;

{$endif}

end.
