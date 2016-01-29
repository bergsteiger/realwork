{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DcTree;

interface
{$I dc.inc}
uses

  Windows, Messages, SysUtils, Classes, Graphics, Controls,  Forms,dcsystem,
  ComCtrls,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  CommCtrl,dcgen,menus,dialogs,dcdtree, dcconsts,dcdreamlib
  {$IFDEF D4},imglist{$ENDIF};


const

  TSIMAGECHANGED = 122;

type

  TNodeList = class(TSortedList)
    function CompareWithKey(Item,Key:Pointer):Integer;override;
    function Compare(Item1, Item2: Pointer):integer;override;
  end;

  TDCTreeNodes= class;

  TDCTreeNode = class(TDrawNode)
  private
    FItems:TDCTreeNodes;
    procedure FMoveTo(Destination: TTreeNode; Mode: TNodeAttachMode);
  public
    TreeSource: TTreeSource;  
    RootId:integer;
    ObjId:integer;
    function GetObjId:integer;
    procedure  AssignNodeRec(NodeRec:TNodeRec;withSource:boolean);
    procedure MoveTo(Destination: TTreeNode; Mode: TNodeAttachMode);  {$IFDEF D3}override;{$ENDIF}
  end;

  TDCTreeNodes= class(TDrawtreeNodes)
  private
    FRoot:integer;
    FNodeList:TNodeList;
    FSource : TTreeSource;
    FRootNode:TTreeNode;
    FRefData : integer;
    FExpandedList:TList;
    procedure AssignNode(Node : TTreeNode; NodeRec:TNodeRec;withSource:boolean);
    procedure FillTree(const NodeRec:TNodeRec);
    procedure ReplaceTree(const NodeRec:TNodeRec);
    procedure DeleteFromNodeList(Node:TTReeNode);
    procedure AddPseudoItem(Node:TTreeNode);
    procedure AddPseudoNode(Node : TTreeNode);
    function  PseudoItem(Node: TTreeNode):TTreeNode;
    function  IsPseudoItem(Node: TTreeNode):boolean;
    procedure ExpandNode(Sender: TObject; Node: TTreeNode);
    procedure CollapseNode(Node : TTreeNode);
    procedure RefreshData(ObjId:integer);
    procedure CheckNode(Node:TTreeNode;gonext:boolean);
    procedure CheckPseudoNode(Node:TTreeNode;gonext:boolean);
    function  InternalAddObject(Node: TTreeNode; const S: string; Ptr:Pointer; InsertType: TNodeAttachMode): TTreeNode;
    procedure BeforeRefresh(ANode : TTreeNode);
    procedure AfterRefresh;
  protected
    function  InternalAdd(Node: TTreeNode; const S: string; Ptr:Pointer; InsertType: TNodeAttachMode): TTreeNode; override;
  public
    function  FindObject(ObjId:integer):TTReeNode;
    function  GetParentSource(Node:TTreeNode):TTreeSource;
    function  GetSelfSource(Node:TTreeNode):TTreeSource;
    constructor Create(AOwner: TCustomMsTreeView); override;
    destructor  Destroy; override;
    procedure Clear; override;
    procedure Delete(Node: TTreeNode); override;
    procedure MoveItemUp(S:TTreeNode);
    procedure MoveItemDown(S:TTreeNode);
  end;



  TtreeViewOption = (toProcessInsKey,toProcessDelKey,toCanEdit,toCanNavigate,toProcessEnterKey,
                    toProcessDblClick,toTrackInsert,toSmartPopup, toConfirmDelete,toCheckChild, toFreeOnCollapse{,toShowLeafs});
  TtreeViewOptions = set of TtreeViewOption;

  TCustomDcTreeView=class(TCustomMSTreeView)
  private
    Fmenu:TPopupMenu;
    FDesign:TFormDesigner;
    fcedit:TDCDsgnComp;
    FSource:TTreeSource;
    FItems:TDCTreeNodes;
    FRoot:integer;
    FOptions : TtreeViewOptions;
    FEditDisabled: boolean;
    FDestroying :boolean;
    FInspectorControls : TList;
    FVersion : TDCVersion;
    FOnNodeChanged : TTVExpandedEvent;
    procedure  SetSource(value:TTreeSource);
    procedure  DcTreeViewEdited(Sender: TObject; Node: TTreeNode; const NewText:string);
    procedure  ShowPopup(X, Y : integer;C:TComponent);
    function   GetInspectorControl:TPersistent;
    function   GetParentSource:TTreeSource;
    procedure  NodeMoved(ObjId:integer);
    procedure  NodeInserted(ObjId:integer);
    procedure  DoInsertNode(R:TNodeRec; DestNode :TTreeNode;withmove:boolean);
    procedure  NodeChanged(ObjId:integer);
    procedure  NodeDeleted(ObjId:integer);
    procedure  NodeSelected(ObjId:integer);
    procedure  SetRoot(Value : integer);
    procedure  AssignImages;
    function   IsSourceStored:boolean;
    function   IsEditedSource(AObject:TObject):boolean;
    function   IsImagesStored : boolean;
    function   IsStateImagesStored : boolean;
    procedure  SetSelectedObject(Node : TTreeNode);
    procedure  SetOptions(Value :  TTreeViewOptions);
    function   GetInspectorControls : TList;
    function   ShowPopupMenu(X, Y : integer) : boolean;

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
    function  CreateNode: TTreeNode; override;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    {$IFDEF D5}
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    {$ENDIF}
    procedure NotifyEvent(Sender:TObject;wParam,lParam:Integer);
    procedure CMTSNOTIFY(var Message: TMessage); message CM_TSNOTIFY;
    procedure DragOver(ASource: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure CMDrag(var Message: TCMDrag); message CM_Drag;
    procedure KeyDown(var Key: Word; Shift: TShiftState);override;
    procedure WMLBUTTONDBLCLK(var Message:TWMMouse);  message WM_LBUTTONDBLCLK;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure KeyPress(var Key: Char); override;
    procedure Change(Node: TTreeNode); override;
    procedure CreateHandle; override;
    function  StoreDrawData : boolean; override;
  public
    constructor Create(Aowner:TComponent);override;
    destructor  Destroy; override;
    procedure   DragDrop(ASource: TObject; X, Y: Integer); override;
    procedure   DefaultDragDrop(ASource: TObject; X, Y: Integer);
    procedure   DefaultDragOver(ASource: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure   BeginUpdate;override;
    procedure   EndUpdate; override;
    function    RootSource : TTreeSource;
    procedure   RefreshTree;
    procedure   RefreshNode(Node : TTreeNode);
    procedure   DeleteSelectedItems; override;
    function    CanDeleteSelection : boolean;

    property    InspectorControl:TPersistent read GetInspectorControl;
    property    InspectorControls : TList read GetInspectorControls;

    property    Source:TTreeSource read GetParentSource write SetSource stored IsSourceStored;
    property    Items:TDCTreeNodes read FItems;
    property    Root:integer  read FRoot write SetRoot;
    property    Options : TtreeViewOptions read FOptions write SetOptions;
    property    Images stored IsImagesStored;
    property    StateImages stored IsStateImagesStored;
    property    OnNodeChanged : TTVExpandedEvent read FOnNodeChanged write FOnNodeChanged;
  published
    property Version : TDCVersion read FVersion write FVersion stored false;
  end;

  TDCTreeView=class(TCustomDcTreeView)
  public
    property Items;
  published
    property Options;
    property ShowButtons;
    property BorderStyle;
    property DragCursor;
    property ShowLines;
    property ShowRoot;
    property ReadOnly;
    {$IFDEF D3}
    property RightClickSelect;
    {$ENDIF}
    property DragMode;
    property HideSelection;
    property Indent;
    property OnEditing;
    property OnEdited;
    property OnExpanding;
    property OnExpanded;
    property OnCollapsing;
    property OnCompare;
    property OnCollapsed;
    property OnChanging;
    property OnChange;
    property OnDeletion;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property Align;
    property Enabled;
    property Font;
    property Color;
    property ParentColor;
    property ParentCtl3D;
    property Ctl3D;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property PopupMenu;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property MultiSelect;
    property Source;
    property ToolTips;
    property HotTrack;
    property RowSelect;
    property OnSelectionChanged;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnClickCheck;
    property OnNodeChanged;
    property CheckBoxes;                      
    property AllowGrayed;
    property AutoScroll;
    property ExpandOnDrag;
    property DragExpandDelay;
    property SelectOnlySiblings;
    {$IFDEF D4}
    property Anchors;
    property AutoExpand;
    property BiDiMode;
    property BorderWidth;
    property ChangeDelay;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}


  end;
  
  TItemList = class(TSortedList)
    function CompareWithKey(Item,Key:Pointer):Integer;override;
    function Compare(Item1, Item2: Pointer):integer;override;
  end;

  TCustomDCListView = class;
      
  TDCListItems = class(TDrawListItems)
  private
    //FOwner: TCustomDCListView;
    FItemList:TItemList;
    FRoot:Integer;
    function InternalAddObject(Index:integer; const S:String; InsertType: TNodeAttachMode):TListItem;
    procedure SetRoot(Value:integer);
    procedure DeleteListItem(ListItem:TListItem);
    procedure SetSource(Value:TTreeSource);
    function  GetSource : TTreeSource;
  protected
    function  FindObject(ObjId:integer):TListItem;
    procedure AssignItem(ListItem:TListItem; NodeRec:TNodeRec);
    procedure FillList(const NodeRec:TNodeRec);
    function  InternalAdd(Index:integer; const S:String; InsertType: TNodeAttachMode):TListItem; override;
  public
    constructor Create(AOwner: TCustomListView); override;
    destructor Destroy; override;
    procedure RefreshList(ObjId:Integer);
    procedure GetPrevLevel;
    procedure GetNextLevel;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    //property  Owner: TCustomDCListView read FOwner;
    property  Root:integer read FRoot write SetRoot;
    property  Source : TTreeSource read GetSource write SetSource;
  end;

  TDCListItem = class(TListItem)
  private
    FItems : TDCListITems;
    FObjId : integer;
    procedure SetObjID(Value : integer);
    procedure FMoveTo(Destination: TListITem; Mode: TNodeAttachMode);
  public
    property ObjId:Integer read FObjId write SetObjId;
    procedure MoveTo(Destination: TListITem; Mode: TNodeAttachMode);
  end;
  TListViewOption = (loProcessDelKey,loProcessInsKey,loCanEdit,loCanNavigate,loProcessDblClick,
                     loSmartPopup,loTrackInsert,loProcessEnterKey,loShowSubItems,loConfirmDelete);
  TListViewOptions = set of TListViewOption;


  TCustomDcListView = class(TCustomDrawListView)
  private
    Fmenu:TPopupMenu;
    FDesign:TFormDesigner;
    fcedit:TDCDsgnComp;
    FItems:TDCListItems;
    FSource:TTreeSource;
    FUpdateCount:integer;
    FOptions :TListViewOptions;
    FDestroying: boolean;
    FInspectorControls : TList;
    FVersion : TDCVersion;
    procedure SetOptions(Value :TListViewOptions );
    procedure SetSource(Value:TTreeSource);
    procedure ItemMoved(ObjId:integer);
    procedure ItemInserted(ObjId:integer);
    procedure DoItemInserted(ListItem: TListItem;R:TNodeRec);
    procedure ItemSelected(ObjId:integer);
    procedure ItemChanged(ObjId:integer);
    procedure ShowPopup(X, Y : integer;C:TComponent);
    procedure ListViewEdited (Sender: TObject; Item: TListItem; const NewCaption: string);
    function  IsSourceStored:boolean;
    function  IsSmallImagesStored:boolean;
    function  IsLargeImagesStored:boolean;
    function  IsStateImagesStored:boolean;
    procedure AssignImages;
    procedure SetSelectedObject(Item: TListItem);
    function  GetInspectorControls : TList;
    function  ShowPopupMenu(X, Y : integer) : boolean;

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure NotifyEvent(Sender:TObject;wParam,lParam:Integer);
    procedure CMTSNOTIFY(var Message: TMessage); message CM_TSNOTIFY;
    procedure DragOver(ASource: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure CMDrag(var Message: TCMDrag); message CM_Drag;
    {$IFDEF D5}
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    {$ENDIF}

    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure CreateHandle;override;
    procedure DblClick;override;
    procedure Change(Item: TListItem; Change: Integer); override;
    function  CreateListItem: TListItem; override;
    procedure DeselectAllItems;
    function  GetListItem(Value: TLVItem): TListItem;

  public
    constructor Create(AOwner:TComponent);override;
    destructor  Destroy;override;
    procedure DragDrop(ASource: TObject; X, Y: Integer); override;
    procedure DefaultDragDrop(ASource: TObject; X, Y: Integer);
    procedure DeleteSelectedItems;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Clear;{$IFDEF D6}override;{$ENDIF}
    procedure InvalidateSelection;
    procedure RefreshList;
    procedure SourceAssigned;
    procedure SetSourceWithRoot(ASource:TTreeSource;ARoot:integer);
    property  Source:TTreeSource read FSource write SetSource  stored IsSourceStored;
    property  InspectorControls : TList read GetInspectorControls;
    property  Items:TDCListItems read FItems;
    property  Options :TListViewOptions read  FOptions write SetOptions;
    property  SmallImages stored IsSmallImagesStored;
    property  LargeImages stored IsLargeImagesStored;
    property  StateImages stored IsStateImagesStored;
  published
    property Version : TDCVersion read FVersion write FVersion stored false;
  end;


  TDCListView = class(TCustomDCListView)
  published
    property Options;
    property Align;
    property BorderStyle;
    property Color;
    property ColumnClick;
    property OnClick;
    property OnDblClick;
    property Columns;
    property Ctl3D;
    property DragMode;
    property ReadOnly default False;
    property Enabled;
    property Font;
    property GridLines;
    property HotTrack;
    property Checkboxes;
    property RowSelect;
    property HideSelection;
    property IconOptions;
    property AllocBy;
    property MultiSelect;
    property OnChange;
    property OnChanging;
    property OnColumnClick;
    property OnCompare;
    property OnDeletion;
    property OnGetImageIndex;
    property OnEdited;
    property OnEditing;
    property OnEnter;
    property OnExit;
    property OnInsert;
    property OnDragDrop;
    property OnDragOver;
    property DragCursor;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property PopupMenu;
    property ShowColumnHeaders;
    property TabOrder;
    property TabStop default True;
    property Regional;
    property ViewStyle;
    property Visible;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property Source;

    property FlatScrollBars;
    property FullDrag;
    property HotTrackStyles;

    property  OnSelectionChanged;
    {$IFDEF D4}
    property Anchors;
    property BiDiMode;
    property BorderWidth;
    property Constraints;
    property DragKind;
    property OwnerDraw;
    property ParentBiDiMode;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnCustomDrawSubItem;
    property OnData;
    property OnDataFind;
    property OnDataHint;
    property OnDataStateChange;
    property OnDrawItem;
    property OnEndDock;
    property OnResize;
    property OnSelectItem;
    property OnStartDock;
    {$ENDIF}
  end;

  procedure NotifyTreeObjDeleted(ObjID:Integer;TreeSource:TTreeSource);
  procedure NotifyTreeRefresh(TreeSource:TTreeSource);

implementation

type
  TMsource = class(TTreeSource);
  TMlistView = class(TCustomListView);
  TMTreeView = class(TCustomMSTreeView);
  TFNode = class
  public
    Node:TTreeNode;
    ObjId:integer;
    constructor Create(Item:TTreeNode;Id:integer);
  end;

{------------------------------------------------------------------}

function GetCaptionFrom(const s : string) : string ;
var
  p : integer;
begin
  p := Pos('|', s);
  if p <> 0 then
    result := copy(s, 1, p - 1)
  else
    result := s;
end;

{------------------------------------------------------------------}

function GetSubItemsFrom(const s : string) : string ;
var
  p : integer;
begin
  result := s;
  delete(result, 1, length(GetCaptionFrom(result)) + 1);
  p := Pos('|', result);
  while p <> 0 do
  begin
    delete(result, p , 1);
    insert(#13#10, result, p);
    p := Pos('|', result);
  end;
end;

{----------------TFNode--------------------------------------------}

constructor TFNode.Create(Item:TTreeNode;Id:integer);
begin
  inherited Create;
  Node:=Item;
  ObjId:=Id;
end;

{------------------------------------------------------------------}

function TNodeList.CompareWithKey(Item,Key:Pointer):Integer;
begin
  result :=  TFNode(Item).ObjId  - Integer(key);
end;

{------------------------------------------------------------------}

function TNodeList.Compare(Item1, Item2: Pointer):integer;
begin
  result := TFNode(Item1).ObjId -  TFNode(Item2).ObjId ;
end;

{----------TDCTreeNode-------------------------------------------}

procedure TDCTreeNode.FMoveTo(Destination: TTreeNode; Mode: TNodeAttachMode);
var
  oldStyle: TFontStyles;
begin
  oldStyle:= FontStyle;
  inherited MoveTo(Destination,Mode);
  FontStyle:=oldStyle;
end;

{------------------------------------------------------------------}

procedure TDCTreeNode.MoveTo(Destination: TTreeNode; Mode: TNodeAttachMode);
begin
  if (FItems.GetParentSource(Self)<> nil) and (FItems.GetParentSource(Self) = FItems.GetParentSource(Destination)) then
     Fitems.GetParentSource(Self).MoveTo(ObjId,Integer(TDCTreeNode(Destination).ObjID),Mode)
  else
    FMoveTo(Destination,Mode)
end;

{------------------------------------------------------------------}

function TDCTreeNode.GetObjId:integer;
begin
  if RootId <> -1 then
    result:=RootId
  else
    result:=ObjId;
end;

{------------------------------------------------------------------}

procedure  TDCTreeNode.AssignNodeRec(NodeRec:TNodeRec;withSource:boolean);
begin
  Text          := GetCaptionFrom(NodeRec.Caption);
  ObjID         := NodeRec.ObjId;
  ImageIndex    := NodeRec.ImageIndex;
  SelectedIndex := NodeRec.SelectedIndex;
  StateIndex    := NodeRec.StateIndex;
  OverlayIndex  := NodeRec.OverlayIndex;
  Data          := NodeRec.Data;
  FontColor     := NodeRec.FontColor;
  FontStyle     := NodeRec.FontStyle;
  if withSource then
  begin
    TreeSource    := NodeRec.TreeSource;
    RootId        := NodeRec.RootId;
  end;
  with TCustomDcTreeView(TreeView) do
    if Assigned(FOnNodeChanged) then
      FOnNodeChanged(TreeView, Self);
end;

{----------TDCTreeNodes-------------------------------------------}

constructor TDCTreeNodes.Create(AOwner: TCustomMsTreeView);
begin
  inherited Create(AOwner);
  FNodeList:=TNodeList.Create;
  FExpandedList:=TList.Create;
end;

{------------------------------------------------------------------}

destructor  TDCTreeNodes.Destroy;
begin
  FreeSortedList(FNodeList,FNodeList);
  FExpandedList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

function TDCTreeNodes.InternalAddObject(Node: TTreeNode; const S: string; Ptr:Pointer;InsertType: TNodeAttachMode): TTreeNode;
begin
  if (GetFirstNode = nil) then
  begin
    BeginUpdate;
    try
      result := inherited InternalAdd(Node, S, Ptr, InsertType)
    finally
      EndUpdate;
    end;
  end
  else
    result := inherited InternalAdd(Node, S, Ptr, InsertType)
end;

{------------------------------------------------------------------}

function TDCTreeNodes.InternalAdd(Node: TTreeNode; const S: string; Ptr:Pointer;InsertType: TNodeAttachMode): TTreeNode;
var
  NewData:integer;
begin
  result:=nil;
  NewData:=FRoot;
  if Assigned(Node) then
    NewData:=TDCTreeNode(Node).ObjId;
  if Assigned(GetParentSource(Node)) then
  begin
    if Assigned(Node) and (InsertType in [naAddChild , naAddChildFirst]) then
       Node.Expand(false);
    GetParentSource(Node).Add(NewData,S,InsertType)
  end
  else
    result := InternalAddObject(Node,S,Ptr,InsertType);
end;

{------------------------------------------------------------------}

procedure TDCTreeNodes.Clear;
var
  Node:TTreeNode;
begin
  TMTreeView(Owner).BeginUpdate;
  try
    if (FSource <> nil) then
      if Froot = 0 then
        FSource.Clear
      else
      begin
        Node:= GetFirstNode;
        while Assigned(Node) do
        begin
          FSource.Delete(TDCTReeNode(Node).ObjId);
          Node:= Node.GetNextSibling;
        end;
      end;
    inherited Clear;
    ClearSortedList(FNodeList);
  finally
    TMTreeView(Owner).EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCTreeNodes.Delete(Node: TTreeNode);
var
  Source:TTreeSource;
begin
  Source := GetParentSource(Node);
  if Assigned(Source) then
    Source.Delete(TDCTreeNode(Node).ObjId)
  else
    inherited Delete(Node);
  if Assigned(Source) and Assigned(Owner.Selected) then
    TMSource(Source).SetSelectedObject(TDCTreeNode(Owner.Selected).ObjId);
end;

{------------------------------------------------------------------}

procedure TDCTreeNodes.AssignNode(Node : TTreeNode; NodeRec:TNodeRec;withSource:boolean);
var
  Ind:integer;
begin
  with TDCTreeNode(Node) do
  begin
    AssignNodeRec(NodeRec,WithSource);
    with FNodeList do
      if not FindByKey(Pointer(objId),Ind) then
         Add(TFNode.Create(Node,objId));
{    with  FSourceList do
      if not Find(NodeRec.TreeSource,Ind) then
        Add(NodeRec.TreeSource);              }
  end;
end;


{------------------------------------------------------------------}

function  TDCTreeNodes.GetParentSource(Node:TTreeNode):TTreeSource;
begin
  if (Node <> nil) and (Node.Parent<> nil) and (TDCTreeNode(Node.Parent).TreeSource <> nil) then
    result := TDCTreeNode(Node.Parent).TreeSource
  else
    result := FSource;
end;

{------------------------------------------------------------------}

function  TDCTreeNodes.GetSelfSource(Node:TTreeNode):TTreeSource;
begin
  if (Node <> nil) and (TDCTreeNode(Node).TreeSource <> nil) then
    result := TDCTreeNode(Node).TreeSource
  else
    result := GetParentSource(Node);;
end;

{------------------------------------------------------------------}

procedure TDCTreeNodes.ReplaceTree(const NodeRec:TNodeRec);
var
  s : string;
begin
  if Assigned(FRootNode) then
  begin
    AssignNode(FRootNode,NodeRec,true);
    FRootNode:=FRootNode.GetNext;
  end
  else
  begin
    s :=  GetCaptionFrom(NodeRec.Caption);
    AssignNode(inherited InternalAdd(GetFirstNode, s, nil, naAdd),NodeRec,true);
  end;
end;

{------------------------------------------------------------------}

procedure TDCTreeNodes.FillTree(const NodeRec:TNodeRec);
var
  s : string;
begin
  s := GetCaptionFrom(NodeRec.Caption);
  if Assigned(FRootNode) then
    AssignNode(inherited InternalAdd(FRootNode,s, nil, naAddChild),NodeRec,true)
  else
    AssignNode(inherited InternalAdd(GetFirstNode,s, nil, naAdd),NodeRec,true);
end;

{------------------------------------------------------------------}

procedure  TDCTreeNodes.DeleteFromNodeList(Node:TTReeNode);
Var
  Index:Integer;
begin
  if Assigned(Node) then
    with FNodeList do
     if  FindByKey(Pointer(TDCTreeNode(Node).ObjId),Index) then
     begin
       TObject(Items[Index]).Free;
       Delete(Index);
     end;
end;

{------------------------------------------------------------------}

procedure TDCTreeNodes.CollapseNode(Node : TTreeNode);
begin
  Node.DeleteChildren;
  AddPseudoNode(Node);
end;

{------------------------------------------------------------------}

procedure TDCTreeNodes.ExpandNode(Sender: TObject; Node: TTreeNode);
var
  S:TTreeSource;
begin
  if Assigned(Node) and not (Node.Expanded) and (TDCTreeNode(Node).ObjId <>0 ) and (PseudoItem(Node) <> nil) then
  begin
    S:= GetSelfSource(Node);
    if Assigned(S) then
    begin
      TMTreeView(Owner).BeginUpdate;
      S.BeginUpdate;
      Screen.Cursor:=crHourGlass;
      try
        FRootNode:=Node;
        with TDCTreeNode(FRootNode) do
        begin
          inherited Delete(PseudoItem(FRootNode));
          S.GetItems(GetObjId,FillTree);
          AddPseudoItem(FRootNode);
        end;
      finally
        S.EndUpdate;
        TMTreeView(Owner).EndUpdate;
        Screen.Cursor:=crDefault;
      end;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCTreeNodes.AddPseudoItem(Node:TTreeNode);
var
  TempItem : TTreeNode;
begin
  if  Assigned(Node) then
    with Node do
      if Count > 0 then
      begin
        TempItem:=TDCTreeNode(Item[0]);
        while Assigned(TempItem) do
        begin
          AddPseudoNode(TempItem);
          TempItem:=TDCTreeNode(TempItem.GetNextSibling);
        end;
      end;
end;

{------------------------------------------------------------------}

procedure TDCTreeNodes.AddPseudoNode(Node : TTreeNode);
var
  S : TTreeSource;
begin
  S := GetSelfSource(Node);
  if (PseudoItem(Node) = nil) and ((Assigned(S) and S.HasChild(TDCTreeNode(Node).GetObjId))
      or not (toCheckChild in TDCTreeView(Self.Owner).FOptions)) then
    inherited InternalAdd(Node, '', nil, naAddChild);
end;

{------------------------------------------------------------------}

function TDCTreeNodes.IsPseudoItem(Node: TTreeNode):boolean;
begin
  with TDCTreeNode(Node) do
    result := (ObjId = 0) and (Text='') and (GetNextSibling = nil)
end;

{------------------------------------------------------------------}

function TDCTreeNodes.PseudoItem(Node: TTreeNode):TTreeNode;
begin
  if Assigned(Node) then
  begin
    result:= Node.GetFirstChild;
    if Result=nil then
      exit;
    with TDCTreeNode(Result) do
      if (ObjId <> 0) or (Text<>'') or (GetNextSibling <> nil) then
        result := nil;
  end
  else
    result := nil;
end;

{------------------------------------------------------------------}

function TDCTreeNodes.FindObject(ObjId:integer):TTReeNode;
var
   index:integer;
begin
  result:=nil;
  if ObjId = 0 then
    exit;
  if Assigned(Owner.Selected) and (TDCTreeNode(Owner.Selected).ObjId = ObjId) then
    result:= Owner.Selected
  else
    with FNodeList do
      if FindByKey(Pointer(objId),index) then
        result:= TFNode(Items[Index]).Node;
end;

{------------------------------------------------------------------}

procedure  TDCTreeNodes.MoveItemUp(S:TTreeNode);
var
  Prev:TDCTreeNode;
begin
  if S= nil then
    Exit;
  Prev:=TDCTreeNode(S.GetPrev);
  if Assigned(Prev) then
    TDCTreeNode(S).MoveTo(Prev,naInsert);
end;

{------------------------------------------------------------------}

procedure  TDCTreeNodes.MoveItemDown(S:TTreeNode);
var
  Next1:TDCTreeNode;
  Next2:TDCTreeNode;
begin
  if S= nil then
    Exit;
   Next1:= TDCTreeNode(S.GetNext);
   if Assigned(Next1) then
   begin
     Next2:=TDCTreeNode(Next1.GetNext);
     if Assigned(Next2) then
      TDCTreeNode(S).MoveTo(Next2,naInsert)
     else
      TDCTreeNode(S).MoveTo(Next1,naAdd);
   end;
end;

{------------------------------------------------------------------}

procedure TDCTreeNodes.CheckPseudoNode(Node:TTreeNode;gonext:boolean);
var
  Item : TTreeNode;
  S    : TTreeSource;
begin
  while Assigned(Node) do
  begin
    Item := PseudoItem(Node);
    S := GetParentSource(Node);
    if Assigned(S) and Assigned(Item) and not S.HasChild(TDCTreeNode(Node).ObjId) then
      inherited Delete(Item);
    if gonext then
      Node:=Node.GetNext
    else
      break;
  end;
end;

{------------------------------------------------------------------}

procedure TDCTreeNodes.CheckNode(Node:TTreeNode;gonext:boolean);
var
  S : TTreeSource;

begin
  while Assigned(Node) do
  begin
    S := GetParentSource(Node);
    if (PseudoItem(Node) = nil) and ( (Assigned(S) and S.HasChild(TDCTreeNode(Node).ObjId))
                                or not (toCheckChild in TDCTreeView(Owner).FOptions)) then
       inherited InternalAdd(Node,'', nil, naAddChild);
    if gonext then
      Node:=Node.GetNextSibling
    else
      break;
  end;
end;

{------------------------------------------------------------------}

procedure TDCTreeNodes.BeforeRefresh(ANode : TTreeNode);
var
  Node : TTreeNode;
begin
  if Assigned(Owner.Selected)  then
    FRefData := TDCTreeNode(Owner.Selected).ObjId
  else
    FRefData:=0;
  FExpandedList.Clear;
  Node := ANode;
  if ANode = nil then
    Node := GetFirstNode;
  while Assigned(Node) do
  begin
    if (Node.Expanded) and (Node.getfirstchild <> nil) then
       FExpandedList.Add(Pointer(TDCTreeNode(Node).ObjId));
    Node:=Node.GetNextVisible;
  end;
end;

{------------------------------------------------------------------}

procedure TDCTreeNodes.AfterRefresh;
var
  Node :TTreeNode;
  i:integer;
begin
  TMTreeView(Owner).BeginUpdate;
  TMTreeView(Owner).FAllowNotify :=true;
  try
    for i:= 0 to FExpandedList.Count -1 do
    begin
      Node := FindObject(integer(FExpandedList.Items[i]));
      if Assigned(Node) then
        Node.Expand(False);
    end;
    FExpandedList.Clear;
    if FRefData<> 0 then
      Node:= FindObject(FRefData)
    else
      Node:=nil ;
    with Owner do
    begin
      if Assigned(Node) then
        Selected:=Node
      else
        Selected:=GetFirstNode;
      if Assigned(Selected) then
        Selected.MakeVisible;
    end;
  finally
    TMTreeView(Owner).EndUpdate;
    TMTreeView(Owner).FAllowNotify:=false;
  end;
end;

{------------------------------------------------------------------}

procedure TDCTreeNodes.RefreshData(ObjId:integer);
var
  Node         : TTreeNode;
  FOldSortType : TSortType;
  FRefNode     : TTreeNode;
begin
  if ([csDestroying, csReading]*Owner.ComponentState<>[]) or not (Owner.HandleAllocated) then
    Exit;

  FRefNode := FindObject(ObjId);
  if (FRefNode = nil) and (ObjId <> 0) then
    exit;

  BeforeRefresh(FRefNode);

  TMTreeView(Owner).BeginUpdate;

  FOldSortType := TMTreeView(Owner).SortType;
  TMTreeView(Owner).SortType := stNone;
  try
    if FRefNode = nil then
      ClearSortedList(FNodeList);

    if Assigned(FSource)  then
      if FSource.ActionAllowed(0,acCanHaveChild) or (ObjId <> 0) then
      begin
        if FRefNode = nil then
          inherited Clear
        else
          FRefNode.DeleteChildren;
        FRootNode:= FRefNode;
        if ObjId <> -1 then
          if FRefNode = nil then
            FSource.GetItems(FRoot, FillTree)
          else
            FSource.GetItems(ObjId, FillTree);
        if FRefNode = nil then
          CheckNode(GetFirstNode,true)
        else
          CheckNode(FRefNode.GetFirstChild, true)
      end
      else
      begin
        FRootNode:=GetFirstNode;
        if ObjId <> -1 then
          FSource.GetItems(FRoot,ReplaceTree);
        while FRootNode <> nil do
        begin
          Node:=FRootNode.GetNext;
          inherited Delete(FRootNode);
          FRootNode:= Node;
        end;
      end
    else
    begin
      inherited Clear;
      FRootNode:=nil;
    end;
  finally
    TMTreeView(Owner).SortType := FOldSortType;
    AfterRefresh;
    TMTreeView(Owner).EndUpdate;
  end;
  with TMTreeView(Owner) do
  begin
    FFirstSelNode := Selected;
    ChangeSelect(Selected);
  end;
end;

{----------------TCustomDcTreeView--------------------------------------}

constructor TCustomDcTreeView.Create(Aowner:TComponent);
begin
  inherited Create(Aowner);
  GetTreeNotifiers.AddMethod(NotifyEvent);
  FItems:= TDCTreeNodes.Create(Self);
  Fmenu:=TPopupMenu.Create(nil);
  FDesign:=TFdesigner.Create;
  FInspectorControls := TList.Create;
  AllowMultidrag := false;
  FOptions:=[toProcessInsKey,toProcessDelKey,toCanEdit,toProcessEnterKey,
             toTrackInsert, toCheckChild ,toConfirmDelete{,toShowLeafs}];
end;

{------------------------------------------------------------------}

destructor TCustomDcTreeView.Destroy;
begin
  FDestroying := true;
  GetTreeNotifiers.DeleteMethod(NotifyEvent);
  Fmenu.Free;
  FItems.Free;
  FInspectorControls.Free;
{$IFNDEF D4}
  FDesign.Free;
{$ENDIF}

  {$IFNDEF D6}
  FcEdit.Free;
  {$ENDIF}

  FSource:=nil;
  inherited Destroy;
end;

{------------------------------------------------------------------}

function TCustomDcTreeView.CreateNode: TTreeNode;
begin
  result:= TDCTreeNode.Create(inherited Items);
  TDCTreeNode(result).Fitems := Items;
  FFirstSelNode := Result;
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.SetSource(value:TTreeSource);
begin
  If FSource<>Value then
  begin
    FSource :=value;
    Items.FSource:=value;
    if Assigned(FSource) then
    begin
      FSource.FreeNotification(Self);
      if (SortType = stNone) then
        SortType := Source.GetSortType;
    end;
    Items.RefreshData(0);
    AssignImages;
  end;
end;

{------------------------------------------------------------------}

function  TCustomDcTreeView.RootSource : TTreeSource;
begin
  result := FSource;
end;

{------------------------------------------------------------------}

function  TCustomDcTreeView.GetParentSource:TTreeSource;
begin
  result := Items.GetParentSource(Selected);
end;
{------------------------------------------------------------------}

procedure TCustomDcTreeView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Acomponent = FSource) and (operation= opRemove) then
    Source:=nil;
end;

{------------------------------------------------------------------}

procedure  TCustomDcTreeView.SetRoot(Value :integer);
begin
  if Froot <> Value then
  begin
    FRoot := Value;
    Items.FRoot := Value;
    Items.RefreshData(0);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.DcTreeViewEdited(Sender: TObject; Node: TTreeNode; const NewText:string);
begin
  if Assigned(Node) and Assigned(Items.GetParentSource(Node)) then
    with TDCTreeNode(Node) do
      Items.GetParentSource(Node).SetCaption(ObjId, NewText);
end;


{------------------------------------------------------------------}

procedure TCustomDcTreeView.CMDrag(var Message: TCMDrag);
var
  id : integer;
begin
  if Selected <> nil then
    id := TDCTreeNode(Selected).ObjId
  else
    id := 0;
  if Assigned(Source) and not Source.ActionAllowed(id,acCanDrag) then
    exit;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.DefaultDragOver(ASource: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
var
  Node:TTreeNode;
begin
  Node:=GetNodeAt(X,Y);
  Accept:= (ASource = Self) and (Node<>nil) and (Selected<>nil) and (Selected<>Node) and
            not (Node.HasAsParent(Selected)) and Assigned(Source) and (Source =Items.GetParentSource(Node)) and
            Source.CanMove(TDCTreeNode(Selected).ObjId,TDCTreeNode(Node).ObjId,naAdd);

end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.DragOver(ASource: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Assigned(OnDragOver) then
    OnDragOver(Self,ASource,X,Y,State,Accept)
  else
    DefaultDragOver(ASource,X,Y,State,Accept);
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.DefaultDragDrop(ASource: TObject; X, Y: Integer);
var
   Node:TTreeNode;
   Next:TTreeNode;
begin
  Node:=GetNodeAt(X,Y);
  if not((Node=nil) or (Selected=nil) or (Selected=Node) or Node.HasAsParent(Selected)) then
    if (Node.AbsoluteIndex > Selected.AbsoluteIndex)  then
    begin
      Next:=Node.GetNextSibling;
      if Assigned(Next) then
        TDCTreeNode(Selected).MoveTo(Next,naInsert)
      else
        TDCTreeNode(Selected).MoveTo(Node,naAdd)
    end
    else
      TDCTreeNode(Selected).MoveTo(Node,naInsert);
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.DragDrop(ASource: TObject; X, Y: Integer);
begin
  if Assigned(OnDragDrop) then
    OnDragDrop(Self,ASource,X,Y)
  else
    DefaultDragDrop(ASource,X, Y);
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.CNNotify(var Message: TWMNotify);
var
  Node:TTReeNode;
begin
  if  FDestroying then
  begin
    inherited;
    exit;
  end;
  if  ( ( (FUpdateCount<=0) or FAllowNotify ) and Assigned(Source) ) or (Message.NMHdr^.Code =TVN_DELETEITEM )  then
  with Message.NMHdr^ do
    case code of
       TVN_ITEMEXPANDING:
          with PNMTreeView(Pointer(Message.NMHdr))^ do
            if (action = TVE_EXPAND) then
            begin
              inherited;
              Node := GetDrawNodeFromItem(itemNew);
              Items.ExpandNode(self,Node);
              exit;
            end
            else
            if (action = TVE_COLLAPSE) and (toFreeOnCollapse in FOptions) then
            begin
              Node := GetDrawNodeFromItem(itemNew);
              if not CanCollapse(Node) then
                Message.Result  := 1
              else
                Items.CollapseNode(Node);
              exit;
            end;
       TVN_BEGINLABELEDIT:
         with PTVDispInfo(Pointer(Message.NMHdr))^ do
         begin
           Node:=GetDrawNodeFromItem(item);
           if  (FEditDisabled) or ( Assigned(Node) and Assigned(Items.GetParentSource(Node))
           and not Items.GetParentSource(Node).ActionAllowed(TDCTReeNode(Node).ObjId,acCanEdit)) then
           begin
             message.Result:=1;
             FEditDisabled:=false;
             exit;
           end;
         end;
       TVN_DELETEITEM :
         with PNMTreeView(Pointer(Message.NMHdr))^ do
         begin
           Node :=GetDrawNodeFromItem(itemOld);
           if Assigned(Node) and not Items.IsPseudoItem(Node) then
           begin
             Items.DeleteFromNodeList(Node);
             if Assigned(FSource)  then
               TMSource(FSource).SetSelectedObject(0);
           end;
         end;
       TVN_ENDLABELEDIT:
         begin
           with PTVDispInfo(Pointer(Message.NMHdr))^ do
           begin
             if item.pszText <> nil  then
                DcTreeViewEdited(Self,GetDrawNodeFromItem(item),item.pszText);
             Edit(item);
           end;
         end
      end;
   inherited;
end;

{------------------------------------------------------------------}

procedure  TCustomDcTreeView.NodeChanged(ObjId:integer);
  procedure DoNodeChanged;
  var
    i , cnt : integer;
    R:TNodeRec;
    Node:TTreeNode;
  begin
    cnt := TList(ObjID).Count;
    for i:= 0 to  cnt - 1 do
    begin
      R:=PNodeRec(TList(ObjId).Items[i])^;
      Node:=Items.FindObject(R.ObjId);
      if Assigned(Node) then
        TDCTreeNode(Node).AssignNodeRec(R,false);
    end;
  end;
begin
  if TList(ObjID).Count >1 then
  begin
    BeginUpdate;
    try
      DoNodeChanged;
    finally
      EndUpdate;
    end;
  end
  else
    DoNodeChanged;
end;

{------------------------------------------------------------------}

procedure  TCustomDcTreeView.NodeDeleted(ObjId:integer);
var
  R:TNodeRec;
  Node:TTreeNode;
begin
  R := PNodeRec(ObjId)^;
  Node:=Items.FindObject(R.ObjId);
  if Assigned(Node) then
  begin
    BeginUpdate;
    try
      if R.Data<> nil then
        Node.DeleteChildren
      else
        inherited Items.Delete(Node);
    finally
      EndUpdate;
      ChangeSelect(Selected);
    end;
  end;
end;

{------------------------------------------------------------------}

procedure  TCustomDcTreeView.DoInsertNode(R:TNodeRec; DestNode :TTreeNode;withmove:boolean);
var
  Node:TTreeNode;
begin
  if (R.InsertType in [naAddChild , naAddChildFirst]) and (Items.PseudoItem(DestNode) <> nil) then
  begin
    DestNode.Expand(false);
    NodeSelected(R.ObjId);
    exit;
  end;
  if (DestNode = nil) then
  begin
    NodeSelected(R.ObjId);
    if Assigned(Selected) and (TDCTreeNode(Selected).ObjId = R.ObjID) then
      exit;
  end;
  with R do
    Node:= Items.InternalAddObject(DestNode,Caption,Data,InsertType);
  Items.AssignNode(Node,R,false);
  with TDCTreeNode(Node) do
    if withMove then
    begin
      TreeSource := R.TreeSource;
      Items.CheckNode(Node,false);
    end
    else
      RootId := -1;
  if Items.GetParentSource(Node) <> nil then
    TMSource(Items.GetParentSource(Node)).ObjectInserted(R.ObjId);
  ClearSelection;
  Selected:= Node;
end;

{------------------------------------------------------------------}

procedure  TCustomDcTreeView.NodeInserted(ObjId:integer);
var
  R:TNodeRec;
  R1:TNodeRec;
  Node : TTreeNode;
  DestNode:TTreeNode;
begin
  if not (toTrackInsert in FOptions) then
    exit;
  R := PNodeRec(ObjId)^;
  Node :=Items.FindObject(R.ObjId);
  if Node  <> nil then
  begin
    Selected := Node;
    exit;
  end;
  R1:=R;
  if R.RootId <> -1 then
    DestNode:=Items.FindObject(R.RootID)
  else
    DestNode := nil;
  if ( Assigned(DestNode) and (TDCTreeNode(DestNode).RootId = 0) ) or
     ( Assigned(Source) and (Integer(TMSource(Source).GettreeLink) = R.RootId) )  then
  begin
    R1.InsertType := naAddChild;
    DoInsertNode(R1,DestNode,false);
  end
  else
  if Assigned(DestNode) or (Assigned(FSource) and (FSource = R.TreeSource)) then
    DoInsertNode(R1,DestNode,false);

end;

{------------------------------------------------------------------}

procedure  TCustomDcTreeView.NodeMoved(ObjId:integer);
var
  R:TNodeRec;
  Node:TTreeNode;
  DestNode:TTreeNode;
begin
  R := PNodeRec(ObjId)^;
  Node:=Items.FindObject(R.ObjID);
  DestNode := Items.FindObject(R.DestID);
  if Assigned(Node) and Assigned(DestNode) then
  begin
    if Node <> DestNode then
    begin
      if (R.InsertType in [naAddChild , naAddChildFirst]) and (Items.PseudoItem(DestNode) <> nil) then
      begin
        inherited Items.Delete(Node);
        DestNode.Expand(false);
        NodeSelected(R.ObjId);
      end
      else
        TDCTreeNode(Node).FMoveTo(DestNode,R.InsertType);
    end;
  end
  else
  begin
    if Assigned(Node) then
      inherited Items.Delete(Node);
    if Assigned(DestNode)  then
      DoInsertNode(R,DestNode,true);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.NodeSelected(ObjId:integer);
var
  Node:TTreeNode;
  Id:integer;
  i:integer;
  Tmp:integer;
  procedure CheckSelection(Node : TTreeNode);
  begin
    if not(Assigned(Node) and (msSelected in GetNodeState(Node))) then
    begin
      ClearSelection;
      Selected := Node;
    end;
  end;
begin
  TreeView_EndEditLabelNow(Handle,true);

  if ObjId = 0 then
    ObjId := TMSource(Source).GetSelectedObject;

  Node:=Items.FindObject(ObjID);
  if Assigned(Node) then
    CheckSelection(Node)
  else
    with TList.Create do
    try
      Id:= ObjID;
      while (Id <> 0)  do
      begin
        tmp:= Source.GetParentId(Id);
        if IndexOf(Pointer(tmp)) < 0 then  id := tmp else break;
        Insert(0,Pointer(Id));
        if Self.Items.FindObject(Id) <> nil  then
          break;
      end;
      for i:= 0 to Count-1 do
      begin
        Node:=Self.Items.FindObject(Integer(Items[i]));
        if Assigned(Node) then
          Node.Expand(false);
      end;
      Node:= Self.Items.FindObject(ObjID);
      CheckSelection(Node);
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.CMTSNOTIFY(var Message: TMessage);
var
  R:TNodeRec;
begin
  with Message do
  begin
    R := PNodeRec(Wparam)^;
    NotifyEvent(R.Data,Wparam,Lparam);
  end;
end;

{------------------------------------------------------------------}

function TCustomDcTreeView.IsEditedSource(AObject:TObject):boolean;
begin
  result := Aobject = FSource;
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.NotifyEvent(Sender:TObject;wParam,lParam:Integer);
var
  R:TNodeRec;
  Node:TTreeNode;
begin
  if not (csDestroying in ComponentState )    then
  case Lparam of
    TSOBJECTCHANGED :
      NodeChanged(Wparam);
    TSDELETE :
      NodeDeleted(Wparam);
    TSINSERT:
      NodeInserted(Wparam);
    TSMOVETO:
      NodeMoved(Wparam);
    TSIMAGECHANGED :
      AssignImages;
    TSREFRESH,TSSELCHANGED,TSSELEXPANDED :
    if IsEditedSource(Sender) then
      begin
        R := PNodeRec(Wparam)^;
        case Lparam of
           TSREFRESH    :begin
                           BeginUpdate;
                           try
                             Items.RefreshData(R.ObjId);
                           finally
                             EndUpdate;
                           end;
                        end;
          TSSELCHANGED :   if (toCanNavigate in Options) then
                              NodeSelected(R.ObjID);
          TSSELEXPANDED: begin
                           Node:=Items.FindObject(R.ObjID);
                           if Assigned(Node) then
                           begin
                             Node.Expand(False);
                             Selected:=Node;
                           end;
                         end;
        end;
      end;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.ShowPopup(X, Y : integer;C:TComponent);
var
  pt     : TPoint;
  fpopup : TPopupMenu;
begin
  If fcEdit<>nil then
    FreeObject(FcEdit,FcEdit);
  if  Assigned(C) then
  begin
    fcedit := GetComponentEditor(C,fdesign);
    fpopup := GetControlPopupMenu(self);
    if Assigned(FPopup) and Assigned(fPopup.OnPopup) then
      fPopup.OnPopup(FPopup);
    MakeComponentPopup(fpopup, fmenu, fcedit);
    if Assigned(fmenu) then
    begin
      fmenu.OnPopup := nil;
      fmenu.PopupComponent := Self;
      pt := ClientToScreen(Point(X, Y));
      fmenu.Popup(pt.X, pt.Y);
    end;
  end;
end;

{------------------------------------------------------------------}

function  TCustomDcTreeView.ShowPopupMenu(X, Y : integer) : boolean;
var
  C : TObject;
begin
  result := (toSmartPopup in FOptions) and Assigned(Source) and Source.ActionAllowed(0,acShowPopup);
  if result then
  begin
    if not Source.ActionAllowed(0,acShowSourceinPopup) and Assigned(Selected) then
      C:= Source.GetInspectorControl(TDCTreeNode(Selected).ObjId)
    else
      C:=Source;
    result := Source is TComponent;
    if result then
      ShowPopup(X, Y, TComponent(C));
  end
end;

{------------------------------------------------------------------}

{$IFDEF D5}
procedure TCustomDcTreeView.WMContextMenu(var Message: TWMContextMenu);
var
  Pt : TPoint;
begin
  GetCursorPos(Pt);
  with ScreenToClient(Pt) do
    if not ShowPopupMenu(X, Y) then
      inherited;
end;
{$ENDIF}

{------------------------------------------------------------------}

procedure TCustomDcTreeView.WMRButtonUp(var Message: TWMRButtonUp);
begin
  with Message do
    if not ShowPopupMenu(XPos, YPos) then
      inherited;

end;

{------------------------------------------------------------------}

function  TCustomDcTreeView.GetInspectorControls : TList;
var
  i:integer;

  procedure AddInTree(Node : TTreeNode);
  var
    P:pointer;
  begin
    P :=pointer(Source.GetInspectorControl(TDCTreeNode(Node).ObjId));
    if (P <> nil) and (FInspectorControls.IndexOf(P) <0) then
      FInspectorControls.Add(P);
  end;
begin
  FInspectorControls.Clear;
  if Assigned(Source) then
  begin
    with FItemsSelected do
      for i:= 0 to Count-1  do
        AddInTree(Items[i]);
    if Assigned(Selected) then
      AddInTree(Selected);
  end;
  result := FInspectorControls;
end;

{------------------------------------------------------------------}

function  TCustomDcTreeView.GetInspectorControl:Tpersistent;
begin
  if Assigned(Source) and Assigned(Selected) then
    result:= Source.GetInspectorControl(TDCTreeNode(Selected).ObjId)
  else
    result:=nil;
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.WMLBUTTONDBLCLK(var Message:TWMMouse);
var
  Node :TTreeNode;
  OnBut:boolean;
begin
  with Message do
  begin
    Node := GetNodeAt(Xpos,Ypos);
    OnBut := htOnButton in GetHitTestInfoAt(Xpos,Ypos);
  end;
  if (toProcessDblClick in FOptions) and not Assigned(OnDblClick) and Assigned(Source) and
     Assigned(Node) and not (OnBut) then
  begin
    FEditDisabled := true;
    Source.Edit(TDCTreeNode(Node).ObjId);
  end
  else
    inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.CreateHandle;
begin
  inherited;
  Items.RefreshData(Root);
  AssignImages;
end;

{------------------------------------------------------------------}

function  TCustomDCTreeView.StoreDrawData : boolean;
begin                                                           
  result := inherited StoreDrawData and (Source = nil);
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.KeyPress(var Key: Char);
begin
  inherited;
  if (toProcessEnterKey in FOptions) and (key = #13) then
    key:=#0;
end;

{------------------------------------------------------------------}

function TCustomDcTreeView.CanDeleteSelection : boolean;
var
  i : integer;
  {----------------------------------------------}

  function _AllowDel(Node : TTreeNode) : boolean;
  var
    S : TTreeSource;
  begin
    S:=Items.GetParentSource(Node);
    result := Assigned(S) and S.ActionAllowed(TDCTreeNode(Node).ObjId, acCanDelete);
  end;

  {----------------------------------------------}
begin

  if Assigned(Selected) then
    result := _AllowDel(Selected)
  else
    result := true;

  if result then
    with FItemsSelected do
      for i:= 0 to Count - 1 do
      begin
        result := _AllowDel(TTreeNode(Items[i]));
        if not result then break;
      end;
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.KeyDown(var Key: Word; Shift: TShiftState);
var
  Id : integer;
begin
  if (not  IsEditing ) and (not ReadOnly)then
  begin
    if Selected <> nil then
      Id := TDCTreeNode(Selected).ObjId
    else
      Id := 0;
    case Key of
      Vk_f2:
        if (Selected <> nil) and (toCanEdit in FOptions)  and
        ( (Assigned(Source) and Source.ActionAllowed(Id,acCanEdit)) or (Source = nil)) then
        begin
          Selected.EditText;
          key := 0;
        end;
       Vk_Insert:
       if (toProcessInsKey in FOptions ) then
         if (ssCtrl in Shift ) and ( (Assigned(Source) and Source.ActionAllowed(Id,acCanAddChild)) or (Source = nil)) then
         begin
           Items.AddChild(Selected,'');
           key:=0;
         end
         else
         if ( (Assigned(Source) and Source.ActionAllowed(Id,acCanAdd)) or (Source = nil)) then
         begin
           Items.Insert(Selected,'');
           key:=0;
         end;
       Vk_Delete:
       if (toProcessDelKey in FOptions) and  ( CanDeleteSelection or (Source = nil))  then
         begin
          DeleteSelectedItems;
           key:=0;
         end;
       Vk_Return:
         if toProcessEnterKey in FOptions then
         begin
           If Assigned(Source) and Assigned(Selected) then
              Source.Edit(TDCTreeNode(Selected).ObjId);
           key:=0;
         end;
    end;
  end;
  inherited;
end;

{------------------------------------------------------------------}

procedure  TCustomDcTreeView.SetOptions(Value :  TTreeViewOptions);
var
  Node : TTreeNode;
begin
  if Foptions <> Value then
  begin
    if (toCanNavigate in Value) and not (toCanNavigate in FOptions) and  Assigned(Source) then
    begin
      Node:=Items.FindObject(TMsource(Source).GetselectedObject);
      if Assigned(Node) and (Selected <> Node) then
        Selected := Node;
    end;
    if (toCheckChild in Value) and not (toCheckChild  in Foptions) then
      Items.CheckPseudoNode(Items.GetFirstNode,true);
    FOptions := Value;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.SetSelectedObject(Node : TTreeNode);
begin
  if  (FUpdateCount<=0 )  and Assigned(Source) and Focused  then
    if Assigned(Node) then
      TMSource(Source).SetSelectedObject(TDCTreeNode(Node).ObjId)
    else
      TMSource(Source).SetSelectedObject(0);
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  SetSelectedObject(Selected);
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.Change(Node: TTreeNode);
begin
  if  (FUpdateCount<=0 ) then
  begin
    inherited;
    SetSelectedObject(Node);
  end;
  FEditDisabled := false;
end;

{------------------------------------------------------------------}

procedure  TCustomDcTreeView.RefreshNode(Node : TTreeNode);
begin
  if Assigned(Node) then
    Items.RefreshData(TDCTreeNode(Node).ObjId)
  else
    Items.RefreshData(0);
  if Assigned(Source) and Assigned(Selected) then
    TMSource(Source).SetSelectedObject(TDCTreeNode(Selected).ObjId);
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.RefreshTree;
begin
  RefreshNode(nil);
end;

{------------------------------------------------------------------}

procedure  TCustomDcTreeView.DeleteSelectedItems;
var
  P:Pointer;
begin
  if ((Selected = nil) and (FItemsSelected.Count = 0)) then
    exit;
  if (toConfirmDelete in FOptions) then
    if MessageDlg(SConfirmDelete,mtConfirmation, [mbYes,mbNo],0 ) <> idYes then
      exit;

  NotifyDestroyObjects(InspectorControls);
  with FItemsSelected do
    if (Count = 0) and Assigned(Selected) then
      Self.Items.Delete(Selected)
    else
    begin
      if Assigned(Selected) and (IndexOf(Selected) <0) then
        Add(Selected);
      BeginUpdate;
      try
        while Count >0 do
        begin
          P:=Items[0];
          Self.Items.Delete(P);
          Remove(P);
        end;
      finally
        EndUpdate;
      end;
    end;
  if Assigned(Source) and Source.ActionAllowed(0,acRefreshDelete) then
    Items.RefreshData(0);
  Change(Selected);
  ChangeSelect(Selected);
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.BeginUpdate;
begin
  inherited;
  if Assigned(FSource) then
    FSource.BeginUpdate;
end;

{------------------------------------------------------------------}

procedure TCustomDcTreeView.EndUpdate;
begin
  inherited;
  if Assigned(FSource) then
     FSource.EndUpdate;
end;

{------------------------------------------------------------------}

function   TCustomDcTreeView.IsImagesStored : boolean;
begin
  result := not ( Assigned(FSource) and (Images = TMSource(FSource).GetSmallImages))
end;

{------------------------------------------------------------------}

function   TCustomDcTreeView.IsStateImagesStored : boolean;
begin
  result := not ( Assigned(FSource) and (StateImages = TMSource(FSource).GetStateImages))
end;

{------------------------------------------------------------------}

procedure  TCustomDcTreeView.AssignImages;
begin
  if Assigned(FSource) and HandleAllocated then
  begin
    Images := TImageList(TMSource(FSource).GetSmallImages);
    if Images <> nil then
      Images.FreeNotification(Self);
    StateImages := TImageList(TMSource(FSource).GetStateImages);
    if (StateImages <> nil) and (StateImages.Name <> SCheckImages) then
      StateImages.FreeNotification(Self);
  end;
end;

{------------------------------------------------------------------}

function TCustomDcTreeView.IsSourceStored:boolean;
begin
  result := CsDesigning in ComponentState;
end;

{------------------------------------------------------------------}
type
  TFItem = class
  public
    ListItem:TListItem;
    ObjId:integer;
    constructor Create(Item:TListITem;Id:integer);
  end;

{------------------------------------------------------------------}

procedure NotifyTreeObjDeleted(ObjID:Integer;TreeSource:TTreeSource);
var
  R:TNodeRec;
begin
  R.ObjId:=ObjId;
  R.Data:=nil;
  GetTreeNotifiers.NotifyEvents(TreeSource,Integer(@R),TSDELETE);
end;

{------------------------------------------------------------------}

procedure NotifyTreeRefresh(TreeSource:TTreeSource);
var
  R:TNodeRec;
begin
  R.ObjId := 0;
  GetTreeNotifiers.NotifyEvents(TreeSource,Integer(@R),TSREFRESH);
end;


{-------TFItem------------------------------------------------------}

constructor TFItem.Create(Item:TListITem;Id:integer);
begin
  inherited Create;
  ListItem := Item;
  ObjId:=Id;
end;


{-----------TDCListItem-----------------------------------------}

procedure TDCListItem.SetObjID(Value : integer);
var
  Index:integer;
begin
  if FObjId <> Value then
  begin
    with FItems.FItemList do
      if FIndByKey(Pointer(FObjId),Index) then
        TFItem(Items[Index]).ObjId := Value;
    FObjId := Value;
  end;
end;

{------------------------------------------------------------------}

procedure TDCListItem.FMoveTo(Destination: TListITem; Mode: TNodeAttachMode);
var
  OldSel:TListItem;
begin
  with TDCListView(ListView) do
  begin
    OldSel := Selected;
    MoveListItem(Self,Destination,Mode);
    Selected := OldSel;
    if Assigned(Selected) then
       Selected.Focused :=  true;
  end;
end;

{------------------------------------------------------------------}

procedure TDCListItem.MoveTo(Destination: TListITem; Mode: TNodeAttachMode);
begin
  if Assigned(Fitems.Source) and Assigned(Destination) then
     Fitems.Source.MoveTo(ObjID,TDCListItem(Destination).ObjId,Mode)
  else
    FMoveTo(Destination,Mode);
end;

{----------TItemList------------------------------------------------}

function TItemList.CompareWithKey(Item,Key:Pointer):Integer;
begin
   result := TFItem(Item).ObjId  - Integer(Key);
end;

{------------------------------------------------------------------}

function TItemList.Compare(Item1, Item2: Pointer):integer;
begin
   result :=  TFItem(Item1).ObjId  - TFItem(Item2).ObjId;
end;

{-----------TDCListItems-----------------------------------------}

constructor TDCListItems.Create(AOwner: TCustomListView);
begin
  inherited Create(AOwner);
  FItemList:=TItemList.Create;
end;

{------------------------------------------------------------------}

destructor TDCListItems.Destroy;
begin
  FreeSortedList(FItemList,FItemList);
end;

{------------------------------------------------------------------}

procedure TDCListItems.SetRoot(Value:integer);
begin
  if (Froot <> Value) {or (FRoot = 0)} then
  begin
    FRoot:=Value;
    RefreshList(FRoot);
  end;
end;

{------------------------------------------------------------------}

function TDCListItems.InternalAddObject(Index:integer; const S:String; InsertType: TNodeAttachMode):TListItem;
begin
  result := inherited InternalAdd(Index, S, InsertType);
end;

{------------------------------------------------------------------}

function TDCListItems.InternalAdd(Index:integer; const S:String; InsertType: TNodeAttachMode):TListItem;
begin
  result := nil;
  if Assigned(Source) and (Froot <> -1) then
  begin
    if InsertType = naInsert then
    begin
      if (Index >=0) and (Index < Count) then
        Source.Add(TDCListITem(Item[Index]).ObjID,S,InsertType)
      else
        Source.Add(0,S,InsertType);
    end
    else
      Source.Add(FRoot,S,InsertType);
  end
  else
  begin
    result := InternalAddObject(Index,S,InsertType);
    result.Caption := S;
  end;
end;

{------------------------------------------------------------------}

procedure TDCListItems.Clear;
begin
  TCustomDCListView(Owner).BeginUpdate;
  try
    if (Source <> nil) then
      Source.Clear;
    inherited Clear;
    ClearSortedList(FItemList);
  finally
   TCustomDCListView(Owner).EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCListItems.Delete(Index: Integer);
begin
  if Assigned(Source) then
    Source.Delete(TDCListItem(Item[Index]).ObjId)
  else
    inherited Delete(Index);
  if Assigned(Source) and Assigned(Owner.Selected) then
    TMSource(Source).SetSelectedObject(TDCListItem(Owner.Selected).ObjId);
end;

{------------------------------------------------------------------}

function  TDCListItems.FindObject(ObjId:integer):TListItem;
var
  Index:integer;
begin
  result:=nil;
  if Assigned(Owner.Selected) and (TDCListItem(Owner.Selected).ObjID= ObjId) then
     result:= Owner.Selected
  else
    with FItemList do
      if FindByKey(Pointer(objId),index) then
          result:= TFItem(Items[Index]).ListItem;
end;

{------------------------------------------------------------------}

procedure TDCListItems.AssignItem(ListItem:TListItem; NodeRec:TNodeRec);
var
  Ind:integer;
begin
  with TDCListItem(ListItem) do
  begin
    Caption       := GetCaptionFrom(NodeRec.Caption);
    SubItems.Text := GetSubItemsFrom(NodeRec.Caption);
    FObjID        := NodeRec.ObjId;
    ImageIndex    := NodeRec.ImageIndex;
    StateIndex    := NodeRec.StateIndex;
    OverlayIndex  := NodeRec.OverlayIndex;
    Data          := NodeRec.Data;
  end;
  with FItemList do
    if not FindByKey(Pointer(NodeRec.ObjId),Ind) then
       Add(TFItem.Create(ListItem,NodeRec.ObjId));
end;

{------------------------------------------------------------------}

procedure TDCListItems.FillList(const NodeRec:TNodeRec);
begin
  AssignItem(inherited InternalAdd(0, '', naAdd), NodeRec);
end;

{------------------------------------------------------------------}

procedure  TDCListItems.DeleteListItem(ListItem:TListItem);
Var
  Index:Integer;
begin
  if Assigned(ListItem) then
    with FItemList do
      if FindByKey(Pointer(TDCListItem(ListItem).ObjId),Index) then
      begin
        TObject(Items[Index]).Free;
        Delete(Index);
      end;
end;

{------------------------------------------------------------------}

procedure TDCListItems.RefreshList(ObjId:Integer);
var
  SelectedData : integer;
  Item         : TListItem;
begin

  if ([csDestroying,CsReading]*Owner.ComponentState<>[])  or not (Owner.handleallocated) then
    Exit;
  if Assigned(Owner.Selected) then
    SelectedData := TDCListItem(Owner.Selected).ObjId
  else
    SelectedData := 0;
  TCustomDCListView(Owner).BeginUpdate;
  try
    ClearSortedList(FItemList);
    inherited Clear;
    if Assigned(Source) and ( ObjId <> -1) then
      Source.GetItems(ObjId,FillList);
  finally
    TCustomDCListView(Owner).EndUpdate;
  end;
  Item := FindObject(SelectedData);
  if Item <> nil then
    Owner.Selected := Item
  else
  if (Owner.Selected=nil) and (Count > 0) then
    Owner.Selected := inherited Item[0];
  FRoot:=ObjId
end;

{------------------------------------------------------------------}

procedure TDCListItems.GetPrevLevel;
begin
  if Assigned(Source) then
    Root := Source.GetParentId(FRoot);
end;

{------------------------------------------------------------------}

procedure TDCListItems.GetNextLevel;
var
  Id:integer;
begin
  if Assigned(Source) and Assigned(Owner.Selected) then
  begin
    Id := TDCListItem(Owner.Selected).ObjID;
    if Source.HasChild(Id) then
      Root := ID;
  end;
end;

{------------------------------------------------------------------}

procedure TDCListItems.SetSource(Value:TTreeSource);
begin
  TCustomDCListView(Owner).Source := Value;
end;

{------------------------------------------------------------------}

function TDCListItems.GetSource : TTreeSource;
begin
  result := TCustomDCListView(Owner).Source;
end;

{-----------TCustomDcListView--------------------------------------}

function CustomSortProc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
  Result := byte(Item1.Index>Item2.Index);
end;

{------------------------------------------------------------------}

constructor TCustomDcListView.Create(AOwner:TComponent);
begin
  inherited Create(Aowner);
  Fmenu:=TPopupMenu.Create(nil);
  FDesign:=TFdesigner.Create;
  FItems := TDCListItems.Create(Self);
  FInspectorControls := TList.Create;
  GetTreeNotifiers.AddMethod(NotifyEvent);
  Foptions := [loProcessDelKey,loProcessInsKey,loCanEdit,loCanNavigate,
  loTrackInsert,loProcessEnterKey,loConfirmDelete];
end;

{------------------------------------------------------------------}

destructor  TCustomDcListView.Destroy;
begin
  GetTreeNotifiers.DeleteMethod(NotifyEvent);
  FItems.Free;
  Fmenu.Free;
  FInspectorControls.Free;
{$IFNDEF D4}
  FDesign.Free;
{$ENDIF}
  {$IFNDEF D6}
  FcEdit.Free;
  {$ENDIF}
  FDestroying := true;
  Inherited Destroy;
end;

{------------------------------------------------------------------}

function TCustomDcListView.CreateListItem: TListItem;
begin
  Result := TDCListItem.Create(inherited  Items);
  TDCListItem(result).Fitems := Items;
end;


{------------------------------------------------------------------}

procedure TCustomDcListView.SourceAssigned;
begin
  if Assigned(Source) and  (SortType = stNone) then
    SortType := Source.GetSortType;
  Items.RefreshList(Items.FRoot);
  AssignImages;
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.SetOptions(Value :TListViewOptions );
begin
  if Foptions <> Value then
  begin
    Foptions := Value;
    if ([loCanNavigate,loShowSubItems] * FOptions <> [] ) and Assigned(Source) then
      ItemSelected(TMsource(Source).GetselectedObject);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.SetSource(Value:TTreeSource);
begin
  If FSource<>Value then
  begin
    FSource :=value;
    if Fsource <> nil then
    begin
      Fsource.FreeNotification(Self);
      if (SortType = stNone) then
        SortType := Source.GetSortType;
    end;
    Items.FRoot:= 0;
    SourceAssigned;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Acomponent = FSource) and (operation= opRemove) then
    Source:=nil;
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.ItemChanged(ObjId:integer);
  procedure DoItemChanged;
  var
    i:integer;
    Item:TListItem;
    R:TNodeRec;
  begin
    for i:= 0 to TList(ObjId).Count-1 do
    begin
      R:=PNodeRec(TList(ObjId).Items[i])^;
      Item:=Items.FindObject(R.ObjId);
      if Assigned(Item) then
        with Item do
        begin
          Caption:= GetCaptionFrom(R.Caption);
          ImageIndex:=R.ImageIndex;
          StateIndex:=R.StateIndex;
          OverlayIndex := R.OverlayIndex;
        end;
    end;
  end;
begin
  if TList(ObjId).Count > 1 then
  begin
    BeginUpdate;
    try
      DoItemChanged;
    finally
     EndUpdate;
    end;
  end
  else
    DoItemChanged;
end;

{------------------------------------------------------------------}

procedure  TCustomDcListView.ItemSelected(ObjId:integer);
var
  ParentId:integer;
  ListItem:TListItem;
begin
  if not (loCanNavigate in FOptions) then
    exit;
  ListView_EditLabel(Handle,-1);
  if ObjId = 0 then
    ObjId := TMSource(Source).GetSelectedObject;

  if (loShowSubItems in Options) and (not Focused) and Source.HasChild(ObjId) then
    Items.Root := ObjId
  else
  begin
    ParentId := Source.GetParentId(ObjId);
    if Items.Froot <> ParentId then
       Items.Root:=ParentId;
    ListItem:=Items.FindObject(ObjId);
    if not (Assigned(ListItem) and ListItem.Selected) then
    begin
      DeselectAllItems;
      Selected := ListItem;
      if Assigned(Selected) then
        Selected.Focused := true;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure  TCustomDcListView.ItemInserted(ObjId:integer);
var
  R:TNodeRec;
  ListItem:TListItem;
  DestItem:TListItem;
  Index:integer;
  RId :integer;
begin
  if not(loTrackInsert in Foptions) then
    exit;
  R := PNodeRec(ObjId)^;
  ListItem:=Items.FindObject(R.ObjID);
  if Assigned(ListItem) then
    exit;

  if Assigned(Source) then
    RId := integer(TMSource(Source).GettreeLink)
  else
    RId := 0 ;
  if (Items.FRoot = RId) or (Items.FRoot =0) then
  begin
    DestItem:=Items.FindObject(R.RootId);
    if  Assigned(DestItem) then
      Index :=DestItem.Index
    else
      Index := 0;
    case R.InsertType of
      naAdd,naAddFirst :  ListItem := inherited Items.Add;
      naInsert         :  ListItem := inherited items.Insert(Index);
    end;
  end
  else
  if  (Items.FRoot = R.RootId) and (R.RootID <> 0) and (R.InsertType in [naAddChild,naAddChildFirst]) then
    ListItem := inherited Items.Add;
  if Assigned(ListItem) then
    DoItemInserted(ListItem,R);
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.DoItemInserted(ListItem: TListItem;R:TNodeRec);
begin
  if Assigned(ListItem) then
  begin
    Items.AssignItem(ListItem,R);
    if Assigned(Source) then
      TMsource(Source).ObjectInserted(R.ObjId);
    CustomSort(@CustomSortProc, 0);
    DeselectAllItems;
    Selected:= ListItem;
    ListItem.Focused:=true;
  end;
end;

{------------------------------------------------------------------}

procedure  TCustomDcListView.ItemMoved(ObjId:integer);
var
  R:TNodeRec;
  ListItem:TListItem;
  DestItem:TListItem;
begin
  if not(loTrackInsert in Foptions) then
    exit;
  R := PNodeRec(ObjId)^;
  ListItem:=Items.FindObject(R.ObjID);
  DestItem := Items.FindObject(R.DestID);
  if Assigned(ListItem) and Assigned(DestItem) then
  begin
     TDCListITem(ListItem).FMoveTo(DestItem,R.InsertType);
     CustomSort(@CustomSortProc, 0);
     exit;
  end
  else
  if Assigned(ListItem) then
      ListItem.Delete
  else
  if Assigned(DestItem) then
  begin
    case R.InsertType of
      naAdd,naAddFirst,
      naAddChild,naAddChildFirst :  ListItem := Inherited Items.Add;
      naInsert                   :  ListItem := Inherited Items.Insert(DestItem.Index)
    end;
    DoItemInserted(ListItem,R);
  end;
end;


{------------------------------------------------------------------}

function TCustomDcListView.GetListItem(Value: TLVItem): TListItem;
begin
  with Value do
    if (mask and LVIF_PARAM) <> 0 then
      Result := TListItem(lParam)
    else
      Result := Items[IItem];
end;


{------------------------------------------------------------------}

procedure TCustomDcListView.CNNotify(var Message: TWMNotify);
var
  Item : TListItem;
begin
  if  FDestroying then
  begin
    inherited;
    exit;
  end;
  if (fUpdateCount <=0 ) or (Message.NMHdr^.Code = LVN_DELETEITEM ) then
  with Message.NMHdr^ do
    case code of
      LVN_DELETEITEM :
        with PNMListView(Pointer(Message.NMHdr))^ do
          Items.DeleteListItem(TListItem(lParam));
      LVN_BEGINLABELEDIT:
      begin
        Item := GetListItem(PLVDispInfo(Pointer(Message.NMHdr))^.Item);
        if Assigned(Item ) and Assigned(Source) and
        not Source.ActionAllowed(TDCListItem(Item).ObjId,acCanEdit) then
          message.Result:= 1;
      end;
      LVN_ENDLABELEDIT:
        with PLVDispInfo(Pointer(Message.NMHdr))^ do
          if (item.pszText <> nil) and (item.IItem <> -1) then
          begin
            if item.pszText <> nil  then
              ListViewEdited(Self,GetListItem(Item),item.pszText);
            Edit(item);
          end;
    end;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.CMTSNOTIFY(var Message: TMessage);
var
  R:TNodeRec;
begin
  with Message do
  begin
    R := PNodeRec(Wparam)^;
    NotifyEvent(R.Data,Wparam,Lparam);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.NotifyEvent(Sender:TObject;wParam,lParam:Integer);
var
  R:TNodeRec;
  ListItem: TListItem;
begin
  if not (csDestroying in ComponentState ) and ( Sender = Source )then
  case Lparam of
    TSOBJECTCHANGED :
      ItemChanged(Wparam);
    TSIMAGECHANGED:
      AssignImages;
    TSDELETE :
      begin
        R := PNodeRec(Wparam)^;
        if (integer(R.Data) = 1) or (R.Objid = Items.Root) then
        begin
          inherited Items.Clear;
          exit;
        end;
        ListItem:=Items.FindObject(R.ObjId);
        if Assigned(ListItem) then
          ListItem.Delete;
      end;
    TSINSERT: ItemInserted(Wparam);
    TSMOVETO: ItemMoved(Wparam);
    TSREFRESH,TSSELCHANGED         :
      begin
        R := PNodeRec(Wparam)^;
        if Lparam = TSREFRESH then
          Items.RefreshList(R.ObjId)
        else
          ItemSelected(R.ObjId);
      end;

  end;
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.ListViewEdited(Sender: TObject; Item: TListItem ;const NewCaption: string);
begin
  if Assigned(Item) and Assigned(Source) then
    with TDCListItem(Item) do
      Source.SetCaption(ObjId, NewCaption);
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.DefaultDragDrop(ASource: TObject; X, Y: Integer);
var
  Item:TListItem;
begin
  Item:=GetItemAt(X,Y);
  if (Item <> nil) and (Selected <> nil) and (Item <> Selected) then
  begin
    if Item.Index > Selected.Index then
    begin
      if Item.Index = Items.Count-1 then
        TDCListItem(Selected).MoveTo(Item,naAdd)
      else
        TDCListItem(Selected).MoveTo(Items[Item.Index+1],naInsert);
    end
    else
      TDCListItem(Selected).MoveTo(Item,naInsert);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.DragDrop(ASource: TObject; X, Y: Integer);
begin
  if Assigned(OnDragDrop) then
    OnDragDrop(Self,ASource, X, Y)
  else
    DefaultDragDrop(ASource, X, Y);
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.CMDrag(var Message: TCMDrag);
var
  id : integer;
begin
  if Selected <> nil then
    id := TDCListItem(Selected).ObjId
  else
    id := 0;
  if Assigned(Source) and not Source.ActionAllowed(id,acCanDrag) then
    exit;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.DragOver(ASource: TObject; X, Y: Integer;
                       State: TDragState; var Accept: Boolean);
begin
  if Assigned(OnDragOver) then
    OnDragOver(Self, ASource, X, Y, State, Accept)
  else
    Accept:=(ASource = Self);
end;


{------------------------------------------------------------------}

procedure TCustomDcListView.DblClick;
begin
  if (loProcessDblClick in Options) and Assigned(Selected) then
    Source.Edit(TDCListITem(Selected).ObjId)
  else
    inherited;
end;

{------------------------------------------------------------------}

function  TCustomDcListView.ShowPopupMenu(X, Y : integer) : boolean;
var
  C : TObject;
begin
  result := (loSmartPopup in FOptions) and Assigned(Source) and Source.ActionAllowed(0,acShowPopup);
  if result then
  begin
    if not Source.ActionAllowed(0,acShowSourceinPopup) and Assigned(Selected) then
      C:= Source.GetInspectorControl(TDCListItem(Selected).ObjId)
    else
      C:=Source;
    result := C is TComponent;
    if result then
      ShowPopup(X, Y, TComponent(C));
  end
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.WMRButtonUp(var Message: TWMRButtonUp);
begin
  with Message do
    if not ShowPopupMenu(XPos, YPos) then
      inherited;
end;

{------------------------------------------------------------------}

{$IFDEF D5}
procedure TCustomDcListView.WMContextMenu(var Message: TWMContextMenu);
var
  Pt : TPoint;
begin
  GetCursorPos(Pt);
  with ScreenToClient(Pt) do
    if not ShowPopupMenu(X, Y) then
      inherited;
end;
{$ENDIF}


{------------------------------------------------------------------}

procedure TCustomDcListView.ShowPopup(X, Y : integer;C:TComponent);
var
  pt     : TPoint;
  fpopup : TPopupMenu;
begin
  If fcEdit<>nil then
    FreeObject(FcEdit,FcEdit);
  if  Assigned(C) then
  begin
    fcedit := GetComponentEditor(C,fdesign);
    fpopup := GetControlPopupMenu(self);
    if Assigned(FPopup) and Assigned(fPopup.OnPopup) then
      fPopup.OnPopup(FPopup);
    MakeComponentPopup(fpopup, fmenu, fcedit);
    if Assigned(fmenu) then
    begin
      fmenu.OnPopup := nil;
      fmenu.PopupComponent := Self;
      pt := ClientToScreen(Point(X, Y));
      fmenu.Popup(pt.X, pt.Y);
    end;
  end;
end;
{------------------------------------------------------------------}

procedure TCustomDcListView.DeselectAllItems;
begin
  Selected := nil;
end;

{------------------------------------------------------------------}


procedure TCustomDcListView.DeleteSelectedItems;
var
  i:integer;
  Index:integer;
begin
  if Selected = nil then
    exit;
  if (loConfirmDelete in FOptions) then
    if MessageDlg(SConfirmDelete,mtConfirmation, [mbYes,mbNo],0 ) <> idYes then
      exit;

  NotifyDestroyObjects(InspectorControls);

  BeginUpdate;
  try
    Index:=Selected.Index;
    if SelCount > 1 then
    begin
      for i:=Items.Count-1 downto 0 do
        if Items[i].Selected then
          Items.Delete(i);
    end
    else
      Items.Delete(Selected.Index);
    if Assigned(Source) and Source.ActionAllowed(0,acRefreshDelete) then
       Items.RefreshList(Items.Froot);
    if Index >Items.Count-1 then
      Index:=Items.Count-1;
    if Index >=0 then
    begin
      DeselectAllItems;
      Selected :=  Items[Index];
    end;
  finally
    EndUpdate;
    Change(Selected,0);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.Clear;
begin
  if Assigned(FSource) then
    FSource.Clear;
  BeginUpdate;
  try
    Items.Clear;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}
function  TCustomDcListView.GetInspectorControls : TList;
var
  i:integer;
  procedure AddInList(Item:TListItem);
  var
    NewData:Pointer;
  begin
    NewData:=FSource.GetInspectorControl(TDCListItem(Item).ObjID);
    if NewData<> nil then
      FInspectorControls.Add(NewData)
  end;
begin
  FInspectorControls.Clear;
  if Assigned(FSource) and Assigned(Selected) then
    if SelCount = 1 then
      AddInList(Selected)
    else
      for i:= 0 to Items.Count-1 do
        if Items[i].Selected then
          AddInList(Items[i]);
  result := FInspectorControls;
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.BeginUpdate;
begin
  inc(fUpdateCount);
  Items.BeginUpdate;
  if Assigned(FSource) then
    FSource.BeginUpdate;
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.EndUpdate;
begin
  dec(fUpdateCount);
  Items.EndUpdate;
  if Assigned(FSource) then
    FSource.EndUpdate;
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.CreateHandle;
begin
  inherited;
  with Items do
    RefreshList(Root);
  AssignImages;
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.KeyDown(var Key: Word; Shift: TShiftState);
var
  Id : integer;
begin
  if (not  IsEditing) and (not ReadOnly)then
  begin
    if Selected <> nil then
      Id := TDCListItem(Selected).ObjId
    else
      Id := 0;
    case Key of
      Vk_f2:
        if (Selected <> nil) and (loCanEdit in FOptions)  and
        ( (Assigned(Source) and Source.ActionAllowed(Id,acCanEdit)) or (Source = nil)) then
        begin
          Selected.EditCaption;
          key := 0;
        end;
       Vk_Insert:
       if (loProcessInsKey in FOptions ) and
       ( (Assigned(Source) and Source.ActionAllowed(Id,acCanAdd)) or (Source = nil)) then
         begin
           if Assigned(Selected)  then
             Items.Insert(Selected.Index)
           else
             Items.Insert(0);
           key:=0;
         end;
       Vk_Delete:
       if (loProcessDelKey in FOptions) and
          ( (Assigned(Source) and Source.ActionAllowed(Id,acCanDelete)) or (Source = nil))  then
         begin
           DeleteSelectedItems;
           key:=0;
         end;
       Vk_Return:
         if loProcessEnterKey in FOptions then
         begin
           If Assigned(Source) and Assigned(Selected) then
              Source.Edit(TDCListItem(Selected).ObjId);
           key:=0;
         end;
    end;
  end;
  inherited;
end;


{------------------------------------------------------------------}

procedure TCustomDcListView.SetSelectedObject(Item: TListItem);
begin
  if (fUpdateCount <=0 ) and  Assigned(Source) and Focused  then
    if Assigned(Item) then
      TMSource(Source).SetSelectedObject(TDCListItem(Item).ObjId)
    else
      TMSource(Source).SetSelectedObject(0);
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  SetSelectedObject(Selected);
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.Change(Item: TListItem; Change: Integer);
begin
  if fUpdateCount <=0 then
  begin
    inherited Change(Item,Change);
    if Assigned(Item) and Item.Selected then
      SetSelectedObject(Item);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.InvalidateSelection;
var
  i:integer;
  R:TRect;
begin
  if not HandleAllocated then
    Exit;
  for i:= 0 to items.Count-1 do
    with Items[i] do
      if Selected then
      begin
        R:=DisplayRect(drIcon);
        InvalidateRect(Handle,@R,true);
     end;
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.RefreshList;
begin
  Items.RefreshList(0);
end;

{------------------------------------------------------------------}

procedure TCustomDcListView.SetSourceWithRoot(ASource:TTreeSource;ARoot:integer);
begin
  if (FSource <> ASource) or (Items.FRoot <> ARoot) then
  begin
    FSource:=ASource;
    Items.FRoot:=ARoot;
    SourceAssigned;
  end;
end;

{------------------------------------------------------------------}

function   TCustomDcListView.IsSmallImagesStored : boolean;
begin
  result := not ( Assigned(FSource) and (SmallImages = TMSource(FSource).GetSmallImages))
end;

{------------------------------------------------------------------}

function   TCustomDcListView.IsLargeImagesStored : boolean;
begin
  result := not ( Assigned(FSource) and (LargeImages = TMSource(FSource).GetLargeImages))
end;

{------------------------------------------------------------------}

function   TCustomDcListView.IsStateImagesStored : boolean;
begin
  result := not ( Assigned(FSource) and (StateImages = TMSource(FSource).GetStateImages))
end;

{------------------------------------------------------------------}

procedure  TCustomDcListView.AssignImages;
begin
  if Assigned(FSource) and HandleAllocated then
  begin
    LargeImages := TImageList(TMSource(FSource).GetLargeImages);
    if LargeImages <> nil then
      LargeImages.FreeNotification(Self);
    SmallImages := TImageList(TMSource(FSource).GetSmallImages);
    if SmallImages <> nil then
      SmallImages.FreeNotification(Self);
    StateImages := TImageList(TMSource(FSource).GetStateImages);
    if StateImages <> nil then
      StateImages.FreeNotification(Self);
  end;
end;

{------------------------------------------------------------------}

function TCustomDcListView.IsSourceStored:boolean;
begin
  result := CsDesigning in ComponentState;
end;


{------------------------------------------------------------------}

procedure _Register;
begin

end;

{------------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
end;

{------------------------------------------------------------------}

initialization
  RunRegister;
end.
