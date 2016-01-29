unit fctreecombo;
{
//
// Components : TfcTreeCombo
//
// Copyright (c) 1999 by Woll2Woll Software
// 4/10/99 - PYW - When closed up ignore visible when getting the new node.
// 7/24/99 - Publish Color and Text property for Delphi 4 and later
}

interface

{$i fcIfDef.pas}

uses
  Forms, Graphics, Menus, SysUtils, Windows, Messages, Classes,
  Controls, Buttons, fcCommon, fcCombo, fcTreeView, ExtCtrls, Dialogs, Grids
  {$ifdef fcDelphi4Up}
  , ImgList
  {$endif};

const FCPOPUPTIMERID = 1000;
      FCPOPUPINTERVAL = 50;

type
  TfcPopupPanel = class(TPanel)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TfcCustomTreeCombo = class;

  TfcTreeComboTreeNode = class(TfcTreeNode)
  private
    FSelectable: Boolean;
  protected
    procedure ReadData(Stream: TStream; Info: PfcNodeInfo); override;
    procedure WriteData(Stream: TStream; Info: PfcNodeInfo); override;
    Function GetSizeOfNodeInfo: integer; override;
  public
    constructor Create(AOwner: TfcTreeNodes); override;
  published
    property Selectable: Boolean read FSelectable write FSelectable;
  end;

  TfcPopupTreeView = class(TfcTreeView)
  private
    FLastPoint: TPoint;
    FTimerOn: Boolean;
    FCheckChange: Boolean;
    FTreeCombo: TfcCustomTreeCombo;
    FCloseOnUp: Boolean;
    FClickedInControl: Boolean;
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMTimer(var Message: TWMTimer); message WM_TIMER;
  protected
    procedure CalcNodeAttributes(Node: TfcTreeNode; AItemState: TfcItemStates); override;
    procedure Change(Node: TfcTreeNode); override;
    procedure KillTimer; virtual;
    procedure SetTimer; virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure WndProc(var Message: TMessage); override;
    procedure Collapse(Node: TfcTreeNode); override;

    property TreeCombo: TfcCustomTreeCombo read FTreeCombo;
  public
    constructor Create(AOwner: TComponent); override;
    function ValidNode(Node: TfcTreeNode): Boolean;
    function MovePage(Node: TfcTreeNode; Down: Boolean): TfcTreeNode;
    function GetLastVisible: TfcTreeNode;
    function GetLastNode: TfcTreeNode;
    function SelectValidNode(StartingNode: TfcTreeNode; SelectedNode: TfcTreeNode; Key: Word): Boolean;

    property Items;
  end;

  TfcImgComboOption = (icoExpanded, icoEndNodesOnly);
  TfcImgComboOptions = set of TfcImgComboOption;

  TfcCheckValidItemEvent = procedure(Sender: TObject; Node: TfcTreeNode; var Accept: Boolean) of object;

  TfcCustomTreeCombo = class(TfcCustomCombo)
  private
    // Property Storage Variables
//    FAlignmentVertical: TfcAlignVertical;
    FOriginalNode: TfcTreeNode;
    FOriginalText: String;
    FSelectedNode: TfcTreeNode;
    FPanel: TfcPopupPanel;
    FShowMatchText: Boolean;
    FOptions: TfcImgComboOptions;
    FTreeView: TfcPopupTreeView;
    FDropDownWidth: integer;

    FOnCheckValidItem: TfcCheckValidItemEvent;
    FOnSelectionChange: TNotifyEvent;

    FItemsList: TStringList;

    function GetCalcNodeAttributes: TfcCalcNodeAttributesEvent;
    function GetImageList: TCustomImageList;
    function GetStateImageList: TCustomImageList;
    function GetItems: TfcTreeNodes;
    function GetSorted: Boolean;
    function GetTreeOptions: TfcTreeViewOptions;
//    procedure SetAlignmentVertical(Value: TfcAlignVertical);
    procedure SetCalcNodeAttributes(Value: TfcCalcNodeAttributesEvent);
    procedure SetItems(Value: TfcTreeNodes);
    procedure SetImageList(Value: TCustomImageList);
    procedure SetStateImageList(Value: TCustomImageList);
    procedure SetSorted(Value: Boolean);
    procedure SetTreeOptions(Value: TfcTreeViewOptions);

    // Message Handlers
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure InvalidateImage;
    function CalcImageRect(Rect: TRect): TRect;
  protected
    // Virtual Methods
    function CreatePopupTreeView: TfcPopupTreeView; virtual;
    function GetStartingNode: TfcTreeNode; virtual;
    procedure Change; override;
    procedure ItemsChange(TreeView: TfcCustomTreeView; Node: TfcTreeNode;
      Action: TfcItemChangeAction; NewValue: Variant); virtual;
    procedure PaintToCanvas(Canvas: TCanvas; Rect: TRect; Highlight, GridPaint: Boolean;
      Text: string); override;
    procedure ResyncTreeSelected(LookupText: string); virtual;
    procedure SelectionChange; virtual;
    procedure SelectionChanging; virtual;


    // Overridden Methods
    function GetDropDownControl: TWinControl; override;
    function GetDropDownContainer: TWinControl; override;
    function GetItemCount: Integer; override;
    function GetItemSize: TSize; override;
    function GetLeftIndent: Integer; override;
    function GetEditRect: TRect; override;
    procedure CreateWnd; override;
    procedure KeyUp(var Key: WORD; Shift: TShiftState); override;
    procedure KeyDown(var Key: WORD; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;
    Function Editable: boolean; override;
    procedure HideCaret; override;
    property ItemsList: TStringList read FItemsList;
  public
    BasePatch: Variant;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function IsValidNode(Node: TfcTreeNode): Boolean; virtual;
    procedure CloseUp(Accept: Boolean); override;
    procedure DrawInGridCell(ACanvas: TCanvas; Rect: TRect;
      State: TGridDrawState); override;
    procedure DropDown; override;
    function IsDroppedDown: Boolean; override;

    property DropDownWidth : integer read FDropDownWidth write FDropDownWidth default 0;
    property Sorted: Boolean read GetSorted write SetSorted;
    property TreeView: TfcPopupTreeView read FTreeView;
    property Images: TCustomImageList read GetImageList write SetImageList;
    property StateImages: TCustomImageList read GetStateImageList write SetStateImageList;
    property Items: TfcTreeNodes read GetItems write SetItems;
    property Options: TfcImgComboOptions read FOptions write FOptions;
    property SelectedNode: TfcTreeNode read FSelectedNode;
    property ShowMatchText: Boolean read FShowMatchText write FShowMatchText;
    property TreeOptions: TfcTreeViewOptions read GetTreeOptions write SetTreeOptions default
        [tvoShowButtons, tvoShowRoot, tvoShowLines, tvoHideSelection, tvoToolTips];

    property OnCheckValidItem: TfcCheckValidItemEvent read FOnCheckValidItem write FOnCheckValidItem;
    property OnCalcNodeAttributes: TfcCalcNodeAttributesEvent read GetCalcNodeAttributes write SetCalcNodeAttributes;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
  end;

  TfcTreeCombo = class(TfcCustomTreeCombo)
  published
    property AlignmentVertical;
    {$ifdef fcDelphi4Up}
    property Anchors;
    property Constraints;
    {$endif}

    property AllowClearKey;
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property ButtonStyle;
    property CharCase;
    {$ifdef fcDelphi4Up}
    property Color;
    property Text;
    {$endif}
    property DataField;
    property DataSource;
    property DropDownCount;
    property DropDownWidth;
    property Enabled;
    property Font;
    property HideSelection;
    property Images;
    property InfoPower;
    property MaxLength;
    property Items;
    property Options;
    property ReadOnly;
    property ShowButton;
    property ShowHint;
    property ShowMatchText;
    property Sorted;
    property StateImages;
    property Style;
    property TabOrder;
    property TreeOptions;
    property Visible;

    property OnCalcNodeAttributes;
    property OnClick;
    property OnChange;
    property OnCheckValidItem;
    property OnCloseUp;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    {$ifdef fcDelphi4up}
    property OnEndDock;
    property OnStartDock;
    {$endif}
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnSelectionChange;
    property OnStartDrag;
  end;

implementation

{$IfDef fcDelphi6Up}
uses
  Variants
  ;
{$EndIf fcDelphi6Up}

{$ifndef fcDelphi4Up}
function fcIsInwwObjectView(control: TWinControl):boolean;
begin
  result := False;
end;
function fcIsInwwObjectViewPaint(control: TWinControl):boolean;
begin
  result := False;
end;
{$endif}

procedure TfcPopupPanel.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := WS_POPUP or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW;
    {$ifdef fcDelphi4up}
    AddBiDiModeExStyle(ExStyle);
    {$endif}
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

constructor TfcPopupPanel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csNoDesignVisible, csReflector, csReplicatable];
  BevelInner := bvNone;
  BevelOuter := bvNone;
  Height := 100;
end;

constructor TfcTreeComboTreeNode.Create(AOwner: TFCTreeNodes);
begin
  inherited Create(AOwner);
  FSelectable := True;
  SelectedIndex := -1;
end;

// Read/WriteData Methods overridden and implemented to support any
// boolean properties added to TfcTreeComboTreeNode.  The Selectable
// property, to be specific.

Function TfcTreeComboTreeNode.GetSizeOfNodeInfo: integer;
var BoolProps: TStringList;
begin
  BoolProps := TStringList.Create;
  result:= inherited GetSizeOfNodeInfo;
  fcGetBooleanProps(self, BoolProps);
  result:= result + BoolProps.Count* SizeOf(boolean) + SizeOf(Integer);
  BoolProps.Free;
end;


procedure TfcTreeComboTreeNode.ReadData(Stream: TStream; Info: PfcNodeInfo);
var BoolProps: TStringList;
    i: Integer;
    CurBool: Boolean;
    Count: Integer;
    {$ifdef fcDelphi4Up}
    L, Size: integer;
    {$endif}
begin
  if TfcCustomTreeView(TreeView).StreamVersion=1 then inherited;

  BoolProps := TStringList.Create;
  fcGetBooleanProps(self, BoolProps);

  if TfcCustomTreeView(TreeView).StreamVersion=1 then
  begin
     { If streaming from TfcTreeView then don't read in flags }
     { ReadDataSize represents the size of the node written to the stream }
     {$ifdef fcDelphi4Up}
      L := Length(Text);
     if L > 255 then L := 255;
     Size := GetSizeOfNodeInfo + L - 255;

     if (ReadDataSize<Size) then
     begin
        BoolProps.Free;
        exit; { No more data to read so finished }
     end
     else
     {$endif}

     { Base class does not know about our structure so subtract the amount }
     Stream.Position:= Stream.Position - (GetSizeOfNodeInfo - SizeOf(Info^));
  end;

  Stream.ReadBuffer(Count, SizeOf(Count));
  for i := 0 to Count - 1 do
  begin
    Stream.ReadBuffer(CurBool, SizeOf(CurBool));
    fcSetOrdProp(self, BoolProps[i], ord(CurBool));
  end;
  BoolProps.Free;

  if TfcCustomTreeView(TreeView).StreamVersion=0 then inherited;
end;

procedure TfcTreeComboTreeNode.WriteData(Stream: TStream; Info: PfcNodeInfo);
var BoolProps: TStringList;
    i: Integer;
    CurBool: Boolean;
    Count: Integer;
begin
  inherited;
  BoolProps := TStringList.Create;
  fcGetBooleanProps(self, BoolProps);
  Count := BoolProps.Count;
  Stream.WriteBuffer(Count, SizeOf(Count));
  for i := 0 to Count - 1 do
  begin
    CurBool := Boolean(fcGetOrdProp(self, BoolProps[i]));
    Stream.WriteBuffer(CurBool, SizeOf(CurBool));
  end;
  BoolProps.Free;
end;

constructor TfcPopupTreeView.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csReplicatable];

  FCheckChange := False;
  NodeClass := TfcTreeComboTreeNode;
  FCloseOnUp := True;

  Options:= [tvoShowButtons, tvoShowRoot,
             tvoShowLines, tvoHideSelection, tvoToolTips];

end;

// Added so that PageDown/PageUp works properly with the Selectable property
// of the TfcTreeComboTreeNode.

function TfcPopupTreeView.MovePage(Node: TfcTreeNode; Down: Boolean): TfcTreeNode;
var ItemsPerPage: Integer;
    i: Integer;
begin
  result := nil;
  ItemsPerPage := (Height div ItemHeight) + 1;
  for i := 0 to ItemsPerPage - 1 do
  begin
    if Node = nil then Break;
    result := Node;
    if Down then Node := Node.GetNextVisible
    else Node := Node.GetPrevVisible;
  end;
  if Node <> nil then result := Node;
end;

function TfcPopupTreeView.GetLastVisible: TfcTreeNode;
var Node: TfcTreeNode;
begin
  result := nil;
  Node := Items.GetFirstNode;
  while Node <> nil do
  begin
    result := Node;
    Node := Node.GetNextVisible;
  end;
end;

// 4/10/99 - PYW - Get last node regardless of whether or not it is visible.
function TfcPopupTreeView.GetLastNode: TfcTreeNode;
var Node: TfcTreeNode;
begin
  result := nil;
  Node := Items.GetFirstNode;
  while Node <> nil do
  begin
    result := Node;
    Node := Node.GetNext;
  end;
end;


// Support methods for the Selectable property of the TfcTreeComboTreeNode.
function TfcPopupTreeView.ValidNode(Node: TfcTreeNode): Boolean;
begin
  if (TreeCombo <> nil) and (icoEndNodesOnly in TreeCombo.Options) then result := Node.Count = 0
  else result := True;

  if not TfcTreeComboTreeNode(Node).Selectable then result := False;

end;

function TfcPopupTreeView.SelectValidNode(StartingNode, SelectedNode: TfcTreeNode; Key: Word): Boolean;
begin
  result := False;
  if StartingNode = nil then
  begin
    StartingNode := Items.GetFirstNode;
    if not (Key in [VK_NEXT, VK_END]) then Key := 0;
  end;

  if (SelectedNode <> nil) and (SelectedNode = Selected) then
  begin
    Selected := StartingNode;
    Exit;
  end;

  if SelectedNode = nil then SelectedNode := StartingNode;

{ if Key in [vk_up, vk_down, vk_prior, vk_next, vk_home, vk_end] then
  begin
     if EditCanModify then begin
        SetModified(True);
     end
     else exit;
  end;
}

  if (TreeCombo.isDroppedDown) then begin
    case Key of
      VK_UP: SelectedNode := SelectedNode.GetPrevVisible;
      VK_DOWN: SelectedNode := SelectedNode.GetNextVisible;
      VK_PRIOR: SelectedNode := MovePage(SelectedNode, False);
      VK_NEXT: SelectedNode := MovePage(SelectedNode, True);
      VK_HOME: SelectedNode := Items.GetFirstNode;
      VK_END: SelectedNode := GetLastVisible;
    end;
  end
  else begin // 4/10/99 - PYW - When closed up ignore visible when getting the new node.
    case Key of
      VK_UP: SelectedNode := SelectedNode.GetPrev;
      VK_DOWN: SelectedNode := SelectedNode.GetNext;
      VK_PRIOR: SelectedNode := MovePage(SelectedNode, False);
      VK_NEXT: SelectedNode := MovePage(SelectedNode, True);
      VK_HOME: SelectedNode := Items.GetFirstNode;
      VK_END: SelectedNode := GetLastNode;
    end;
  end;

  if SelectedNode = nil then Exit;
  if not TreeCombo.IsValidNode(SelectedNode) then
  begin
    if Key in [VK_UP, VK_PRIOR, VK_END] then Key := VK_UP else Key := VK_DOWN;
    SelectValidNode(StartingNode, SelectedNode, Key);
  end else Selected := SelectedNode;
  result := True;
end;

procedure TfcPopupTreeView.WMLButtonDown(var Message: TWMLButtonDown);
var HitTest: TfcHitTests;
    Node: TfcTreeNode;
begin
  FClickedInControl := True;
  if TreeCombo <> nil then TreeCombo.CheckCancelMode;

  FCloseOnUp := False;
  if PtInRect(Rect(0, 0, ClientWidth, ClientHeight), Point(Message.XPos, Message.YPos)) then
    FCloseOnUp := True;

  HitTest := GetHitTestInfoAt(Message.XPos, Message.YPos);
  if fchtOnButton in HitTest then
  begin
    FCloseOnUp := False;
    Node := GetNodeAt(Message.XPos, Message.YPos);
    if Node <> nil then
    begin
      if Node.Expanded then Node.Collapse(False) else Node.Expand(False);
    end;
  end
end;

procedure TfcPopupTreeView.WMTimer(var Message: TWMTimer);
var p: TPoint;
begin
  inherited;
  if GetKeyState(VK_LBUTTON) >= 0 then
  begin
    if TreeCombo <> nil then TreeCombo.CloseUp(True);
    Exit;
  end;
  if Selected = nil then Exit;

  GetCursorPos(p);
  with ClientToScreen(Point(0, 0)) do
  begin
    if p.y < y then SelectValidNode(Selected, nil, VK_UP)
    else if p.y > y + Height then SelectValidNode(Selected, nil, VK_DOWN);
  end;
end;

procedure TfcPopupTreeView.Collapse(Node: TfcTreeNode);
begin
   inherited;
   if (TreeCombo<>nil) and (icoEndNodesOnly in TreeCombo.Options) then
      Selected:= nil;
end;

// Support hot-tracking of the iten in the drop-down treeview.

procedure TfcPopupTreeView.MouseMove(Shift: TShiftState; X, Y: Integer);
var Node: TfcTreeNode;
    p: TPoint;
    Msg: TWMTimer;
begin
  inherited;
  if TreeCombo.EffectiveReadOnly then Exit;  // Prevent hot-tracking when readonly
  if ((FLastPoint.x = x) and (FLastPoint.y = y)) or ((FLastPoint.x = -1) and (FLastPoint.y = -1)) then
  begin
    FLastPoint := Point(x, y);
    Exit;
  end;

  Node := GetNodeAt(X, Y);
  if (Node <> nil) and TreeCombo.IsValidNode(Node) then Selected := Node;

  // Allow mouse to move selection down or up past window
  if (TreeCombo <> nil) and (GetKeyState(VK_LBUTTON) < 0) then
  begin
    GetCursorPos(p);
    with ClientToScreen(Point(0, 0)) do
    begin
      FillChar(Msg, SizeOf(Msg), 0);
      if (p.y < y - TreeCombo.Height) or (p.y > y + Height) then
      begin
        WMTimer(Msg);
        SetTimer;
      end{ else
        KillTimer; 4/5/99 - Leave timer on until MouseUP or CloseUp}
    end;
  end;
  FLastPoint := Point(x, y);
end;

procedure TfcPopupTreeView.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var hittest: TfcHitTests;
    ClickedNode: TfcTreeNode;
begin
  if (TreeCombo <> nil) and (Button = mbLeft) and FCloseOnUp and
     (FClickedInControl or PtInRect(ClientRect, Point(X, Y))) then
  begin
    hitTest:= GetHitTestInfoAt(X, Y);
    if not (fchtOnButton in hittest) then begin { 4/5/99 - RSW }
       ClickedNode:= GetNodeAt(X, Y);
       if (ClickedNode<>nil) and TreeCombo.IsValidNode(ClickedNode) then begin
         TreeCombo.FSelectedNode:= Selected; { RSW }
         TreeCombo.CloseUp(PtInRect(ClientRect, Point(X, Y)));
       end
    end
  end;
  KillTimer;
  FCloseOnUp := True;
end;

procedure TfcPopupTreeView.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_LBUTTONDBLCLK, WM_RBUTTONDOWN, WM_RBUTTONDBLCLK: ;
  else
    inherited;
  end;
end;

procedure TfcPopupTreeView.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TfcPopupTreeView.CalcNodeAttributes(Node: TfcTreeNode; AItemState: TfcItemStates);
begin
  if Node.Selected then
  begin
    Canvas.Brush.Color := clHighlight;
    Canvas.Font.Color := clHighlightText;
  end;
  inherited;
end;

procedure TfcPopupTreeView.Change(Node: TfcTreeNode);
begin
  inherited;
  if (TreeCombo <> nil) and FCheckChange and (Selected <> nil) then
  begin
    TreeCombo.FSelectedNode:= Selected; { RSW }
    TreeCombo.Text := Selected.Text;
  end;
end;

procedure TfcPopupTreeView.SetTimer;
begin
  Windows.SetTimer(Handle, FCPOPUPTIMERID, FCPOPUPINTERVAL, nil);
  FTimerOn := True;
end;

procedure TfcPopupTreeView.KillTimer;
begin
  if HandleAllocated then Windows.KillTimer(Handle, FCPOPUPTIMERID);
  FTimerOn := False;
end;

constructor TfcCustomTreeCombo.Create(AOwner: TComponent);
begin
  inherited;
  ButtonStyle := cbsDownArrow;
  ShowMatchText := True;
  FOptions := [icoExpanded];

//  FAlignmentVertical := fcavTop; { RSW - Used to be fcavCenter }

  FPanel := TfcPopupPanel.Create(self);
  FPanel.Visible := False;

  FTreeView := CreatePopupTreeView;
  FTreeView.FTreeCombo := self;
  with FTreeView do
  begin
    BorderStyle := bsNone;
    Parent := FPanel;
    Visible := True;
    Align := alClient;
    OnItemChange := ItemsChange;
  end;

  FItemsList := TStringList.Create
end;

destructor TfcCustomTreeCombo.Destroy;
begin
  FItemsList.Free;

  inherited;
end;

function TfcCustomTreeCombo.CreatePopupTreeView: TfcPopupTreeView;
begin
  result := TfcPopupTreeView.Create(self);
end;

function TfcCustomTreeCombo.GetStartingNode: TfcTreeNode;
begin
  result := TreeView.Items.GetFirstNode;
end;

procedure TfcCustomTreeCombo.InvalidateImage;
var r: TRect;
begin
  if not HandleAllocated then exit;

  { RSW - Clear image area }
  r:= GetEditRect;
  r:= Rect(1, 1, r.left-1, Height-1);
  InvalidateRect(Handle, @r, True);
end;

procedure TfcCustomTreeCombo.Change;
begin
  inherited;

  if (TreeView.Selected = nil) or (TreeView.Selected.Text <> Text) then
     InvalidateImage;
end;

procedure TfcCustomTreeCombo.ItemsChange(TreeView: TfcCustomTreeView; Node: TfcTreeNode;
  Action: TfcItemChangeAction; NewValue: Variant);
var Index: Integer;
begin
  if csDestroying in ComponentState then Exit;
  Index := FItemsList.IndexOf(Node.Text + '=' + InttoStr(Node.ImageIndex));
  case Action of
    icaAdd: FItemsList.Add(Node.Text + '=' + InttoStr(Node.ImageIndex));
    icaDelete: if Index <> -1 then FItemsList.Delete(Index);
    icaText: if (Index <> -1) and (NewValue <> NULL) then FItemsList[Index] := NewValue + '=' + InttoStr(Node.ImageIndex);
    icaImageIndex: if Index <> -1 then FItemsList[Index] := Node.Text + '=' + InttoStr(NewValue);
  end;
end;

function TfcCustomTreeCombo.CalcImageRect(Rect: TRect): TRect;
var LineHeight, LineOffset: integer;
begin
   if Images=nil then  { RSW }
   begin
      result:= Rect;
      exit;
   end;

  { 4/14/99 - Center icon with respect to the middle of the text's height  - RSW }
  if AlignmentVertical = fcavTop then
  begin
     LineHeight:=
             fcMax(Canvas.Textheight('A')+2, TImageList(Images).Height);
     LineOffset:= (LineHeight-TImageList(Images).Height) div 2;

//     if BorderStyle=bsNone then
//        LineOffset:= LineOffset - 1;
     LineOffset:= fcMax(-1, LineOffset);
     result := Classes.Rect(Rect.Left + 1,  Rect.Top + 1 + LineOffset,
             TImageList(Images).Width,
             Rect.Top + 1 + LineOffset + TImageList(Images).Height);
  end else
  begin
     result := Classes.Rect( Rect.Left + 1, Rect.Top + (Rect.Bottom-Rect.Top - TImageList(Images).Height) div 2 + 1,
                 TImageList(Images).Width,TImageList(Images).Height);
//     if Style = csDropDownList then OffsetRect(result, 1, 0); { 4/27/99 - RSW Remove this code as it makes image move to left unnecessarily}
  end;
end;

procedure TfcCustomTreeCombo.PaintToCanvas(Canvas: TCanvas; Rect: TRect; Highlight,GridPaint: Boolean;
  Text: string);
var ImageIndex,OldBkMode: Integer;
    s: String;
    Flags: UINT;
    TempRect:TRect;
    OldBkColor:TColor;
    SkipPaintImage: boolean;

    function GetTextRect:TRect;
    begin
       result := Classes.Rect(Rect.Left + GetLeftIndent + 2,
                              Rect.Top + 2,
                              Rect.Right,Rect.Bottom);
       {$ifdef fcDelphi4Up}
       if fcIsInwwObjectView(self) then begin
          result.Top:= result.Top -1;
       end
       {$endif}
    end;

  function DrawHighlight:boolean;
  begin
     result := ((not Editable and Focused) or fcParentGridFocused(Self));
     if (not ShowMatchText) and (Style = csDropDownList) and Focused and not IsDroppedDown then result:= True; { RSW - 3/27/99 }
     if csPaintCopy in ControlState then result:= False;
  end;

  procedure PaintText;
  begin
    // 2/25/99 - Added vertical alignment.
    Flags := 0;
    TempRect := GetTextRect;
    if AlignmentVertical = fcavCENTER then flags := Flags or DT_VCENTER or DT_SINGLELINE
    else flags := Flags or DT_TOP or DT_SINGLELINE;
    if not fcIsInwwGrid(self) and { 4/27/99 - RSW, Adjust left,top in special case }
      ((Style = csDropDownList) and not IsDroppedDown and not showmatchtext) then
    begin
       TempRect.left:= TempRect.left - 1;
       TempRect.Top:= TempRect.Top - 1;
    end;
    DrawText(Canvas.Handle,PChar(Text),Length(Text),TempRect,Flags);
  end;

  procedure PaintImage;
  var ImageRect: TRect;
  begin
     if Images=nil then exit; { 3/3/99 }

     ImageRect := CalcImageRect(Rect);

     if (Images <> nil) and (ImageIndex >= 0) and (ImageIndex < Images.Count) then
     begin
       fcImageListDraw(Images, ImageIndex, Canvas,
         ImageRect.Left, ImageRect.Top,
           0, Enabled)  // Changed calculation of y pos to ignore self's height.  Made it constant for now.  -ksw (2/24/99)
     end
  end;


begin
  OldBkColor := GetBkColor(Canvas.Handle);
  OldBkMode := GetBkMode(Canvas.Handle);
  SkipPaintImage:= False;

  Canvas.Font := Font; { 7/8/99 - Fixes problem where font not set for csPaintCopy }

  try
     ImageIndex:= -1;
//     if (not HandleAllocated) or (not TreeView.HandleAllocated) then
//        if TreeView.Selected=nil then
//           s:= 'abc';

     if (not (csPaintCopy in ControlState)) and
        (TreeView.Selected <> nil) and (TreeView.Selected.Text = Text) then
        ImageIndex := TreeView.Selected.ImageIndex
     else begin
        s := FItemsList.Values[Text];
        if s <> '' then ImageIndex := StrtoInt(s)
        else ImageIndex := -1;
     end;

     // Draw Highlight rect with focus rect
     if (fcIsInwwGrid(self) and (not Focused or not Highlight)) or
        ((Style = csDropDownList) and Focused and not IsDroppedDown and not showmatchtext) then
     begin
        if not fcIsInwwGrid(self) then
        begin
           Rect.Right := BtnParent.Left-1; { RSW, just set right and bottom}
        end;

        // Draw Background in the Highlight color and surround it with a focus rect
        if (not fcIsInwwGrid(self)) or (not GridPaint) then
           Canvas.Brush.Color :=
             fcThisThat(Highlight and (DrawHighlight or not fcIsInwwGrid(self)), clHighlight, self.Color); { 7/8/99 - RSW - Use color of control }

        if not fcIsInwwObjectViewPaint(self) then Canvas.FillRect(Rect);
        if (not GridPaint) and Highlight and (DrawHighlight or not fcIsInwwGrid(self)) then
        begin
           SetBkColor(Canvas.Handle, ColorToRGB(clHighlightText));
           SetTextColor(Canvas.Handle, ColorToRGB(clHighlight));
           TempRect := Rect;
           if fcIsInwwGrid(self) then
              TempRect.Right := TempRect.Right - GetIconIndent;

           PaintImage;
           SkipPaintImage:= True;
           Canvas.DrawFocusRect(TempRect);
        end;

        // Draw the text
        if not fcIsInwwGrid(self) or (not GridPaint) then begin
           SetBkMode(Canvas.Handle, TRANSPARENT);
           SetBkColor(Canvas.Handle, ColorToRGB(fcThisThat(Highlight and (DrawHighlight or not fcIsInwwGrid(self)), clHighlight, clWindow)));
           SetTextColor(Canvas.Handle, ColorToRGB(fcThisThat(Highlight and (DrawHighlight or not fcIsInwwGrid(self)), clWindow, Font.Color)));
        end;

        PaintText;
     end
     else if not fcisinwwGrid(Self) and (csPaintCopy in ControlState) and
       (not Focused) then begin { RSW - 3/17/99 }
        PaintText;
     end;

     if not SkipPaintImage then PaintImage;

  finally
     SetBkMode(Canvas.Handle,OldBkMode);
     SetBkColor(Canvas.Handle, OldBkColor);
  end;
end;

procedure TfcCustomTreeCombo.ResyncTreeSelected(LookupText: string);
begin
  if ((TreeView.Selected = nil) or
      (TreeView.Selected.Text <> LookupText)) then
  begin
     if (fcNameInList(Text, FItemsList) <> -1) then
     begin
        TreeView.Selected := TreeView.Items.FindNode(LookupText, False);
        invalidate; { RSW - 2/24/99 }
     end
     else TreeView.Selected:= nil { RSW }
  end
end;

procedure TfcCustomTreeCombo.SelectionChange;
begin
  if Assigned(FOnSelectionChange) then FOnSelectionChange(self);
  TreeView.FCheckChange := False;
end;

procedure TfcCustomTreeCombo.SelectionChanging;
begin
  DataLink.Edit;
  TreeView.FCheckChange := True;
end;

function TfcCustomTreeCombo.GetSorted: Boolean;
begin
  result := TreeView.SortType = fcstText;
end;

function TfcCustomTreeCombo.GetCalcNodeAttributes: TfcCalcNodeAttributesEvent;
begin
  result := TreeView.OnCalcNodeAttributes;
end;

function TfcCustomTreeCombo.GetImageList: TCustomImageList;
begin
  result := TreeView.Images;
end;

function TfcCustomTreeCombo.GetStateImageList: TCustomImageList;
begin
  result := TreeView.StateImages;
end;

function TfcCustomTreeCombo.GetItems: TfcTreeNodes;
begin
  result := TreeView.Items;
end;

function TfcCustomTreeCombo.GetTreeOptions: TfcTreeViewOptions;
begin
  result := TreeView.Options;
end;

{procedure TfcCustomTreeCombo.SetAlignmentVertical(Value: TfcAlignVertical);
begin
  if FAlignmentVertical <> Value then FAlignmentVertical := Value;
end;
}
procedure TfcCustomTreeCombo.SetCalcNodeAttributes(Value: TfcCalcNodeAttributesEvent);
begin
  TreeView.OnCalcNodeAttributes := Value;
end;

procedure TfcCustomTreeCombo.SetItems(Value: TfcTreeNodes);
begin
  TreeView.Items := Value;
end;

procedure TfcCustomTreeCombo.SetImageList(Value: TCustomImageList);
begin
  TreeView.Images := Value;
  if Value <> nil then Value.FreeNotification(self);
  SetEditRect;
end;

procedure TfcCustomTreeCombo.SetStateImageList(Value: TCustomImageList);
begin
  TreeView.StateImages := Value;
  if Value <> nil then Value.FreeNotification(self);
  SetEditRect;
end;

procedure TfcCustomTreeCombo.SetSorted(Value: Boolean);
begin
  if Value then TreeView.SortType := fcstText else TreeView.SortType := fcstNone;
end;

procedure TfcCustomTreeCombo.SetTreeOptions(Value: TfcTreeViewOptions);
begin
  TreeView.Options := Value;
end;

function TfcCustomTreeCombo.GetDropDownControl: TWinControl;
begin
  result := TreeView;
end;

function TfcCustomTreeCombo.GetDropDownContainer: TWinControl;
begin
  result := FPanel;
end;

function TfcCustomTreeCombo.GetItemCount: Integer;
begin
  result := Items.Count;
end;

function TfcCustomTreeCombo.GetItemSize: TSize;
  function LargestRect: TSize;
  var Node: TfcTreeNode;
      i: Integer;
  begin
    result := fcSize(0, 0);
    Node := TreeView.Items.GetFirstNode;
    while Node <> nil do
    begin
      with Node.DisplayRect(True) do
      begin
        TreeView.Canvas.Font:= TreeView.Font; { 4/24/99 - RSW }
        i:= Left + TreeView.Canvas.TextWidth(Node.Text) + 6; { 4/5/99 - RSW }
        if (Node.ImageIndex=-2) and (TreeView.Images<>nil) then inc(i, TImageList(TreeView.Images).Width);

        result.cy := Bottom - Top;
      end;
      if i > result.cx then result.cx := i;
      Node := Node.GetNextVisible;
    end;
  end;
var Node: TfcTreeNode;
begin
  if DropDownWidth=0 then
  begin
     Node := Items.GetFirstNode;
     if Node <> nil then result := LargestRect
     else result := fcSize(0, 0);
  end
  else begin
     Node := Items.GetFirstNode;
     if Node <> nil then begin
       result.cx:= DropDownWidth;
       with Node.DisplayRect(True) do
          result.cy:= Bottom-Top
     end
     else result := fcSize(0, 0);
  end;

end;

procedure TfcCustomTreeCombo.CMTextChanged(var Message: TMessage);
begin
  inherited;
end;

procedure TfcCustomTreeCombo.DropDown;
begin
  // 2/25/99 - Make certain that combo does not dropdown if datasource is not enabled.
  if (Datalink.field=nil) and ((datasource<>nil) or (datafield<>'')) then exit;
//  ControlStyle := ControlStyle - [csNoDesignVisible];
  TreeView.FLastPoint := Point(-1, -1);
  TreeView.FClickedInControl := False;
  TreeView.FCloseOnUp := True;

  ResyncTreeSelected(Text);  { Move earlier }

  FOriginalNode := TreeView.Selected;
  FOriginalText:= Text;
  FSelectedNode:= FOriginalNode; { RSW }
  if icoExpanded in Options then begin
     TreeView.FullExpand;
     if ((Text='') or (FSelectedNode=nil)) and (TreeView.Items.GetFirstNode<>nil) then
     begin
        { 4/5/99 - Default to top of tree.  Don't use TopItem here as it has strange horizontal scrolling behavior}
        TreeView.selected:= TreeView.Items.GetFirstNode;
        TreeView.Selected:= nil;
     end
     else if FSelectedNode<>Nil then FSelectedNode.MakeVisible;
  end;
  if Style = csDropDownList then Invalidate;

  inherited;
  //2/25/99 - Removed from fcCombo so needs to be added here.
  Update;
  Selectall;
//  SetScrollPos(TreeView.Handle, sb_horz, 50, True);
end;

procedure TfcCustomTreeCombo.CloseUp(Accept: Boolean);
var IsDroppedDown: Boolean;
begin
//  ControlStyle := ControlStyle + [csNoDesignVisible];
  IsDroppedDown := self.IsDroppedDown;
  inherited;
  if IsDroppedDown then
  begin
    if Accept and (FOriginalNode<>FSelectedNode) and EditCanModify then { RSW }
    begin
      SelectionChanging;
      if FSelectedNode<>nil then Text:= FSelectedNode.Text; { RSW }
//      if TreeView.Selected <> nil then Text := TreeView.Selected.Text;
      SelectionChange;
      SetModified(True);
    end else begin
      TreeView.Selected := FOriginalNode;
      if TreeView.Selected <> nil then Text := TreeView.Selected.Text
      else Text:= FOriginalText; // if not fcIsInwwGrid(self) then Text := '';
    end;
    DoCloseUp(Accept);
  end;
  TreeView.KillTimer;
  if Editable then SelectAll; //(Style = csDropDown) then SelectAll;
end;

function TfcCustomTreeCombo.IsDroppedDown: Boolean;
begin
  result := FPanel.Visible;
end;

procedure TfcCustomTreeCombo.DrawInGridCell(ACanvas: TCanvas; Rect: TRect;
  State: TGridDrawState);
begin
  PaintToCanvas(ACanvas, Rect, (gdSelected in State), True, DataLink.Field.Text);
end;

procedure TfcCustomTreeCombo.CreateWnd;
begin
  inherited;
  FPanel.Parent := self;
end;

procedure TfcCustomTreeCombo.KeyUp(var Key: WORD; Shift: TShiftState);
begin
  inherited;

{  if EffectiveReadOnly then Exit;  // Prevent selection change with keyboard when readonly

  case Key of
    VK_BACK:
       if (Style=csDropDownList) and (not isDroppedDown) then
       begin
         key:= 0;
       end;
  end;}
end;

procedure TfcCustomTreeCombo.KeyDown(var Key: WORD; Shift: TShiftState);
var r: TRect;
begin
  inherited;
  if EffectiveReadOnly then Exit;  // Prevent selection change with keyboard when readonly

  case Key of
    VK_BACK, VK_DELETE:
       if (Style=csDropDownList) {and (not isDroppedDown) }then
       begin
         //4/27/99 - Handle BackSpace Key as well.
         if (AllowClearKey) and
            ((selText=Text) or
             (not IsDroppedDown) and ((key=vk_delete) or ((key=vk_back) and (not ShowMatchText)))) then
         begin
            SelectionChanging;
            Text:= '';
            TreeView.Selected := nil;
//            SelectionChange;
            TreeView.FCheckChange := False;
            SetModified(True);
            key:= 0;
         end
         else begin
            if (selStart>0) and ShowMatchText then
            begin
               SendMessage(Handle, EM_SETSEL, length(Text), selStart-1);
               SendMessage(Handle, EM_SCROLLCARET, 0,0);
            end;
            key:= 0;
         end;
       end;

    VK_UP, VK_DOWN, VK_HOME, VK_END, VK_PRIOR, VK_NEXT:
    begin
      if (Key in [VK_HOME, VK_END]) and not (ssCtrl in Shift) and IsDroppedDown then Exit;
      if Items.Count > 0 then
        if (Style = csDropDownList) or (((Key = VK_UP) or (Key = VK_DOWN)) and not IsDroppedDown) then
        begin
          SelectionChanging;
          if not TreeView.SelectValidNode(TreeView.Selected, nil, Key) then
          begin
            r := GetEditRect;
            InvalidateRect(Handle, @r, False);
          end;
          SelectionChange;
          SetModified(True);
          Key := 0;
        end else if IsDroppedDown then begin
          SelectionChanging;
          TreeView.SelectValidNode(TreeView.Selected, nil, Key);
          SelectionChange;
          Key := 0;
        end;
      SelectAll;
    end;
  end;
end;

procedure TfcCustomTreeCombo.WndProc(var Message: TMessage);
begin
  inherited;
end;

procedure TfcCustomTreeCombo.KeyPress(var Key: Char);
  // This method occurs before the text has changed on the edit, so
  // this method returns what the text will be after the key has been
  // processed.
  function NewText: string;
  var CurStr: string;
  begin
    CurStr:= Text;
    result:= Copy(CurStr, 1, SelStart) + Char(Key) +
      Copy(CurStr, SelStart + 1 + Length(SelText), 32767);
  end;
var Text: string;
  // Return the first node whose beginning text matches the current
  // text of the combo.
  function FindNode: TfcTreeNode;
  var InitialNode: TfcTreeNode;
  begin
    InitialNode := TreeView.Selected;
    if InitialNode.Index < GetStartingNode.Index then InitialNode := GetStartingNode;
    result := InitialNode;
    repeat
      if IsValidNode(result) and (UpperCase(Copy(result.Text, 1, Length(Text))) = UpperCase(Text)) then Exit;
      result := result.GetNext;
      if result = nil then result := GetStartingNode;
    until result = InitialNode;
    result := nil;
  end;
var Node: TfcTreeNode;
    TextLen: Integer;
    HaveChangedText: boolean;
begin
  inherited;
  TreeView.HandleNeeded;  { Allows Items to be valid }

  if (key=#8) and (Style=csDropDownList) and ShowMatchText then
  begin
     key:= #0;
     if key=#0 then exit;
  end;

  if (Items.Count > 0) and (key<>#0) and
     (IsDroppedDown or (ShowMatchText {and (Style = csDropDown)})) and not (Key in [#8]) then
  begin
    Text := NewText;
    Node := FindNode;
    if Node <> nil then
    begin
      TreeView.Selected := Node;
      FSelectedNode:= Node; { RSW }

      // Quicken-style highlighting
      if ShowMatchText then
      begin
        HaveChangedText:= self.text<>node.text;
        self.Text := Node.Text;
        TextLen := Length(Text);
        SelStart := Length(Node.Text);
        SelLength := - (Length(Node.Text) - TextLen);
      end else begin
        HaveChangedText:= self.text<>node.text;
        self.Text := Text;
        SelStart := Length(Text);
      end;

//      TreeView.Selected := Node;  { 4/22/99 RSW - Already set so redundant }
      if HaveChangedText then
      begin
         SelectionChange; { 4/22/99 - RSW }
         SetModified(True);
      end;
      Key := #0;
    end else begin
//      if IsDroppedDown and (Style = csDropDownList) then Key := #0  // If selection is not in list, but dropped down, then don't allow invalid entries
      if (Style = csDropDownList) then Key := #0  // If selection is not in list, but dropped down, then don't allow invalid entries
      else TreeView.Selected := nil; //4/27/99 - Clear selection only if dropdown style and not found.
    end;
  end;

{  if (key=#8) and (Style=csDropDownList) then
  begin
     if (not isDroppedDown) then key:= #0
     else if Text=SelText then key:= #0
  end;
}
  if (Key<>#0) and (Style=csDropDown) then SetModified(True) { RSW };

  if Key = #13 then Key := #0;
end;

procedure TfcCustomTreeCombo.Loaded;
begin
  inherited;
  if Sorted then TreeView.AlphaSort;
end;

procedure TfcCustomTreeCombo.Paint;
begin
   with ClientRect do PaintToCanvas(Canvas, Rect(0, 0, Right - Left, Bottom - Top), True, False, Text);
end;

function TfcCustomTreeCombo.GetLeftIndent: Integer;
begin
  result := inherited GetLeftIndent + 1;
  if fcIsInwwGrid(self) then Result:= Result -1; { 7/5/99 }

  if (Images <> nil) then inc(result, TImageList(Images).Width + 2);
end;

function TfcCustomTreeCombo.GetEditRect: TRect;
begin
  result:= inherited GetEditRect;
  if result.Right<=result.Left+10 then
     result.Right:= result.Left + 10; // 5/3/99 - RSW - Ensure edit rectangle is at least 10 pixels wide
end;

function TfcCustomTreeCombo.Editable: Boolean;
begin
   Result := (Style <> csDropDownList) or isDroppedDown or ShowMatchText;
end;

function TfcCustomTreeCombo.IsValidNode(Node: TfcTreeNode): Boolean;
begin
   result:= TreeView.ValidNode(Node);
   if Assigned(OnCheckValidItem) then OnCheckValidItem(Self, Node, result);
end;

procedure TfcCustomTreeCombo.HideCaret;
begin
  if (not showMatchText) then inherited;
end;

end.
