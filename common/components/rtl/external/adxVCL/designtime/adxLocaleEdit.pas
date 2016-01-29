{*********************************************************************}
{                                                                     }
{             Add-In Express Component Library                        }
{                  Add-in Express for VCL                             }
{                                                                     }
{             Copyright (C) Add-in Express Ltd.                       }
{             ALL RIGHTS RESERVED                                     }
{                                                                     }
{    The entire contents of this file is protected by U.S. and        }
{    International Copyright Laws. Unauthorized reproduction,         }
{    reverse-engineering, and distribution of all or any portion of   } 
{    the code contained in this file is strictly prohibited and may   }
{    result in severe civil and criminal penalties and will be        }
{    prosecuted to the maximum extent possible under the law.         }
{                                                                     }
{    RESTRICTIONS                                                     }
{                                                                     }
{    THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE        }
{    CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS     }
{    LTD.                                                             }
{    THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE THE Add-in    }
{    Express VCL AND ALL ACCOMPANYING VCL COMPONENTS AS PART          }
{    OF AN EXECUTABLE PROGRAM ONLY.                                   }
{                                                                     }
{    THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{    FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{    COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{    AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT           }
{    AND PERMISSION FROM ADD-IN EXPRESS LTD.                          }
{                                                                     }
{    CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{    ADDITIONAL RESTRICTIONS.                                         }
{                                                                     }
{*********************************************************************}

unit adxLocaleEdit;

{$I adxDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  {$IFNDEF ADX_VCL5}
  Variants,
  {$ENDIF}
  Dialogs, Grids, StdCtrls, ExtCtrls;

type
  {$IFDEF ADX_VCL5}
  TEditStyle = (esSimple, esEllipsis, esPickList);
  {$ENDIF}

  TLocaleEditorGrid = class(TStringGrid)
  private
    FLanguages: TStrings;
    FEdit: TInplaceEdit;
    function RestoreCurrentRow: Boolean;
    function IsEmptyRow: Boolean;
  protected
    procedure DeleteRow(ARow: Integer); override;
    function CanEditModify: Boolean; override;
    function CreateEditor: TInplaceEdit; override;
    procedure EditListGetItems(ACol, ARow: Integer; Items: TStrings);
    {$IFNDEF ADX_VCL5}
    function GetEditStyle(ACol, ARow: Longint): TEditStyle; override;
    {$ELSE}
    function GetEditStyle(ACol, ARow: Longint): TEditStyle; 
    {$ENDIF}
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent; const AStrings: TStrings); reintroduce;
    destructor Destroy; override;
  published
  end;

  TadxLocaleEditor = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    FGrid: TLocaleEditorGrid;
    FLanguages: TStringList;
    FSourceList: TStringList;
  public
    constructor Create(Source: TStringList); reintroduce;
    destructor Destroy; override;
  end;

var
  adxLocaleEditor: TadxLocaleEditor;

implementation

{$R *.dfm}

{ TadxLocaleEditor }

constructor TadxLocaleEditor.Create(Source: TStringList);
var
  i: Integer;
  L: TLanguages;
begin
  inherited Create(nil);
  FSourceList := Source;
  FLanguages := TStringList.Create;
  FLanguages.AddObject('(Default)', nil);
  L := TLanguages.Create;
  try
    for i := 0 to L.Count - 1 do
      FLanguages.AddObject(L.Name[i], Pointer(L.LocaleID[i]));
    FLanguages.Sort;
  finally
    L.Free;
  end;
end;

destructor TadxLocaleEditor.Destroy;
begin
  FSourceList := nil;
  FLanguages.Free;
  inherited Destroy;
end;

procedure TadxLocaleEditor.FormCreate(Sender: TObject);
var
  i, Index: Integer;
begin
  FGrid := TLocaleEditorGrid.Create(Self, FLanguages);
  FGrid.Parent := Panel2;
  FGrid.Align := alClient;

  FGrid.RowCount := FSourceList.Count + 1;
  for i := 0 to FSourceList.Count - 1 do begin
    Index := FLanguages.IndexOfObject(Pointer(StrToInt(FSourceList.Names[i])));
    if Index >= 0 then begin
      FGrid.Cells[0, i + 1] := FLanguages[Index];
      FGrid.Cells[1, i + 1] := FSourceList.Values[FSourceList.Names[i]];
    end;
  end;
end;

procedure TadxLocaleEditor.btnOKClick(Sender: TObject);
var
  i, Index: Integer;
begin
  if FGrid.Cells[1, 1] = '' then begin
    FGrid.Row := 1;
    FGrid.Col := 1;
    ModalResult := mrNone;
    raise Exception.Create('The value of Default language must not be empty!');
  end;
  FSourceList.Clear;
  for i := 1 to FGrid.RowCount - 1 do
    if (FGrid.Cells[0, i] <> '') and (FGrid.Cells[1, i] <> '') then begin
      Index := FLanguages.IndexOf(FGrid.Cells[0, i]);
      if Index >= 0 then
        FSourceList.Values[IntToStr(Integer(FLanguages.Objects[Index]))] := FGrid.Cells[1, i];
    end;
end;

type
  TPopupListbox = class(TCustomListbox)
  private
    FSearchText: string;
    FSearchTickCount: Longint;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  end;

  TOnGetPickListItems = procedure(ACol, ARow: Integer; Items: TStrings) of object;

  TInplaceLocaleEdit = class(TInPlaceEdit)
  private
    FButtonWidth: Integer;
    FPickList: TCustomListbox;
    FActiveList: TWinControl;
    FEditStyle: TEditStyle;
    FDropDownRows: Integer;
    FListVisible: Boolean;
    FTracking: Boolean;
    FPressed: Boolean;
    FPickListLoaded: Boolean;
    FOnGetPickListitems: TOnGetPickListItems;
    FOnEditButtonClick: TNotifyEvent;
    function GetPickList: TCustomListbox;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CancelMode;
    procedure WMCancelMode(var Message: TMessage); message WM_CancelMode;
    procedure WMKillFocus(var Message: TMessage); message WM_KillFocus;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message wm_LButtonDblClk;
    procedure WMPaint(var Message: TWMPaint); message wm_Paint;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SetCursor;
  protected
    procedure BoundsChanged; override;
    function ButtonRect: TRect;
    procedure CloseUp(Accept: Boolean); dynamic;
    procedure DblClick; override;
    procedure DoDropDownKeys(var Key: Word; Shift: TShiftState); virtual;
    procedure DoEditButtonClick; virtual;
    procedure DoGetPickListItems; dynamic;
    procedure DropDown; dynamic;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    function OverButton(const P: TPoint): Boolean;
    procedure PaintWindow(DC: HDC); override;
    procedure StopTracking;
    procedure TrackButton(X,Y: Integer);
    procedure UpdateContents; override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(Owner: TComponent); override;
    procedure RestoreContents;
    property ActiveList: TWinControl read FActiveList write FActiveList;
    property ButtonWidth: Integer read FButtonWidth write FButtonWidth;
    property DropDownRows: Integer read FDropDownRows write FDropDownRows;
    property EditStyle: TEditStyle read FEditStyle;
    property ListVisible: Boolean read FListVisible write FListVisible;
    property PickList: TCustomListbox read GetPickList;
    property PickListLoaded: Boolean read FPickListLoaded write FPickListLoaded;
    property Pressed: Boolean read FPressed;
    property OnGetPickListItems: TOnGetPickListItems read FOnGetPickListItems
      write FOnGetPickListItems;
  end;

{ TPopupListBox }

procedure TPopupListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do begin
    Style := Style or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    AddBiDiModeExStyle(ExStyle);
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure TPopupListbox.CreateWnd;
begin
  inherited CreateWnd;
  Windows.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, wm_SetFocus, 0, 0);
end;

procedure TPopupListbox.Keypress(var Key: Char);
var
  TickCount: Integer;
begin
  case Key of
    #8, #27: FSearchText := '';
    #32..#255:
      begin
        TickCount := GetTickCount;
        if TickCount - FSearchTickCount > 2000 then FSearchText := '';
        FSearchTickCount := TickCount;
        if Length(FSearchText) < 32 then FSearchText := FSearchText + Key;
        SendMessage(Handle, LB_SelectString, WORD(-1), Longint(PChar(FSearchText)));
        Key := #0;
      end;
  end;
  inherited Keypress(Key);
end;

procedure TPopupListbox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  TInplaceLocaleEdit(Owner).CloseUp((X >= 0) and (Y >= 0) and
      (X < Width) and (Y < Height));
end;

{ TInplaceLocaleEdit }

constructor TInplaceLocaleEdit.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  FEditStyle := esSimple;
end;

procedure TInplaceLocaleEdit.BoundsChanged;
var
  R: TRect;
begin
  SetRect(R, 2, 2, Width - 2, Height);
  if EditStyle <> esSimple then
    if not Grid.UseRightToLeftAlignment then
      Dec(R.Right, ButtonWidth)
    else
      Inc(R.Left, ButtonWidth - 2);
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
  if SysLocale.FarEast then
    SetImeCompositionWindow(Font, R.Left, R.Top);
end;

type
  TAccessCustomGrid = class(TCustomGrid);

procedure TInplaceLocaleEdit.CloseUp(Accept: Boolean);
var
  ListValue: Variant;
begin
  if ListVisible and (ActiveList = FPickList) then begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    if PickList.ItemIndex <> -1 then
      ListValue := PickList.Items[PickList.ItemIndex];
    SetWindowPos(ActiveList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FListVisible := False;
    Invalidate;
    if Accept then
      if (not VarIsEmpty(ListValue) or VarIsNull(ListValue))
         and (ListValue <> Text) then
      begin
        Perform(WM_SETTEXT, 0, Longint(string(ListValue)));
        Modified := True;
        with TAccessCustomGrid(Grid) do
          SetEditText(Col, Row, ListValue);
      end;
  end;
end;

procedure TInplaceLocaleEdit.DoDropDownKeys(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_UP, VK_DOWN:
      if ssAlt in Shift then begin
        if ListVisible then CloseUp(True) else DropDown;
        Key := 0;
      end;
    VK_RETURN, VK_ESCAPE:
      if ListVisible and not (ssAlt in Shift) then begin
        CloseUp(Key = VK_RETURN);
        Key := 0;
      end;
  end;
end;

procedure TInplaceLocaleEdit.DoEditButtonClick;
begin
  if Assigned(FOnEditButtonClick) then
    FOnEditButtonClick(Grid);
end;

procedure TInplaceLocaleEdit.DoGetPickListItems;
begin
  if not PickListLoaded then begin
    if Assigned(OnGetPickListItems) then
      OnGetPickListItems(TAccessCustomGrid(Grid).Col, TAccessCustomGrid(Grid).Row, PickList.Items);
    PickListLoaded := (PickList.Items.Count > 0);
  end;
end;

function TInplaceLocaleEdit.GetPickList: TCustomListbox;
var
  PopupListbox: TPopupListbox;
begin
  if not Assigned(FPickList) then begin
    PopupListbox := TPopupListbox.Create(Self);
    PopupListbox.Visible := False;
    PopupListbox.Parent := Self;
    PopupListbox.OnMouseUp := ListMouseUp;
    PopupListbox.IntegralHeight := True;
    PopupListbox.ItemHeight := 11;
    FPickList := PopupListBox;
  end;
  Result := FPickList;
end;

procedure TInplaceLocaleEdit.DropDown;
var
  P: TPoint;
  I,J,Y: Integer;
begin
  if not ListVisible then begin
    ActiveList.Width := Width;
    if ActiveList = FPickList then begin
      DoGetPickListItems;
      TPopupListbox(PickList).Color := Color;
      TPopupListbox(PickList).Font := Font;
      if (DropDownRows > 0) and (PickList.Items.Count >= DropDownRows) then
        PickList.Height := DropDownRows * TPopupListbox(PickList).ItemHeight + 4
      else
        PickList.Height := PickList.Items.Count * TPopupListbox(PickList).ItemHeight + 4;
      if Text = '' then
        PickList.ItemIndex := -1
      else
        PickList.ItemIndex := PickList.Items.IndexOf(Text);
      J := PickList.ClientWidth;
      for I := 0 to PickList.Items.Count - 1 do begin
        Y := PickList.Canvas.TextWidth(PickList.Items[I]);
        if Y > J then J := Y;
      end;
      PickList.ClientWidth := J;
    end;
    P := Parent.ClientToScreen(Point(Left, Top));
    Y := P.Y + Height;
    if Y + ActiveList.Height > Screen.Height then Y := P.Y - ActiveList.Height;
    SetWindowPos(ActiveList.Handle, HWND_TOP, P.X, Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
    FListVisible := True;
    Invalidate;
    Windows.SetFocus(Handle);
  end;
end;

procedure KillMessage(Wnd: HWnd; Msg: Integer);
var
  M: TMsg;
begin
  M.Message := 0;
  if PeekMessage(M, Wnd, Msg, Msg, pm_Remove) and (M.Message = WM_QUIT) then
    PostQuitMessage(M.wparam);
end;

procedure TInplaceLocaleEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (EditStyle = esEllipsis) and (Key = VK_RETURN) and (Shift = [ssCtrl]) then begin
    DoEditButtonClick;
    KillMessage(Handle, WM_CHAR);
  end
  else
    inherited KeyDown(Key, Shift);
end;

procedure TInplaceLocaleEdit.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(ActiveList.ClientRect, Point(X, Y)));
end;

procedure TInplaceLocaleEdit.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if (Button = mbLeft) and (EditStyle <> esSimple) and
    OverButton(Point(X,Y)) then
  begin
    if ListVisible then
      CloseUp(False)
    else
    begin
      MouseCapture := True;
      FTracking := True;
      TrackButton(X, Y);
      if Assigned(ActiveList) then
        DropDown;
    end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TInplaceLocaleEdit.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ListPos: TPoint;
  MousePos: TSmallPoint;
begin
  if FTracking then
  begin
    TrackButton(X, Y);
    if ListVisible then
    begin
      ListPos := ActiveList.ScreenToClient(ClientToScreen(Point(X, Y)));
      if PtInRect(ActiveList.ClientRect, ListPos) then
      begin
        StopTracking;
        MousePos := PointToSmallPoint(ListPos);
        SendMessage(ActiveList.Handle, WM_LBUTTONDOWN, 0, Integer(MousePos));
        Exit;
      end;
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TInplaceLocaleEdit.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  WasPressed: Boolean;
begin
  WasPressed := Pressed;
  StopTracking;
  if (Button = mbLeft) and (EditStyle = esEllipsis) and WasPressed then
    DoEditButtonClick;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TInplaceLocaleEdit.PaintWindow(DC: HDC);
var
  R: TRect;
  Flags: Integer;
  W, X, Y: Integer;
begin
  if EditStyle <> esSimple then
  begin
    R := ButtonRect;
    Flags := 0;
    case EditStyle of
      esPickList:
        begin
          if ActiveList = nil then
            Flags := DFCS_INACTIVE
          else if Pressed then
            Flags := DFCS_FLAT or DFCS_PUSHED;
          DrawFrameControl(DC, R, DFC_SCROLL, Flags or DFCS_SCROLLCOMBOBOX);
        end;
      esEllipsis:
        begin
          if Pressed then Flags := BF_FLAT;
          DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
          X := R.Left + ((R.Right - R.Left) shr 1) - 1 + Ord(Pressed);
          Y := R.Top + ((R.Bottom - R.Top) shr 1) - 1 + Ord(Pressed);
          W := ButtonWidth shr 3;
          if W = 0 then W := 1;
          PatBlt(DC, X, Y, W, W, BLACKNESS);
          PatBlt(DC, X - (W * 2), Y, W, W, BLACKNESS);
          PatBlt(DC, X + (W * 2), Y, W, W, BLACKNESS);
        end;
    end;
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
  inherited PaintWindow(DC);
end;

procedure TInplaceLocaleEdit.StopTracking;
begin
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
  end;
end;

procedure TInplaceLocaleEdit.TrackButton(X,Y: Integer);
var
  NewState: Boolean;
  R: TRect;
begin
  R := ButtonRect;
  NewState := PtInRect(R, Point(X, Y));
  if Pressed <> NewState then
  begin
    FPressed := NewState;
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TInplaceLocaleEdit.UpdateContents;
begin
  ActiveList := nil;
  PickListLoaded := False;
  FEditStyle := TLocaleEditorGrid(Grid).GetEditStyle(TAccessCustomGrid(Grid).Col, TAccessCustomGrid(Grid).Row);
  if EditStyle = esPickList then
    ActiveList := PickList;
  inherited UpdateContents;
end;

procedure TInplaceLocaleEdit.RestoreContents;
begin
  Reset;
end;

procedure TInplaceLocaleEdit.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> ActiveList) then
    CloseUp(False);
end;

procedure TInplaceLocaleEdit.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

procedure TInplaceLocaleEdit.WMKillFocus(var Message: TMessage);
begin
  if not SysLocale.FarEast then inherited
  else
  begin
    ImeName := Screen.DefaultIme;
    ImeMode := imDontCare;
    inherited;
    if HWND(Message.WParam) <> Grid.Handle then
      ActivateKeyboardLayout(Screen.DefaultKbLayout, KLF_ACTIVATE);
  end;
  CloseUp(False);
end;

function TInplaceLocaleEdit.ButtonRect: TRect;
begin
  if not Grid.UseRightToLeftAlignment then
    Result := Rect(Width - ButtonWidth, 0, Width, Height)
  else
    Result := Rect(0, 0, ButtonWidth, Height);
end;

function TInplaceLocaleEdit.OverButton(const P: TPoint): Boolean;
begin
  Result := PtInRect(ButtonRect, P);
end;

procedure TInplaceLocaleEdit.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  with Message do
  if (EditStyle <> esSimple) and OverButton(Point(XPos, YPos)) then
    Exit;
  inherited;
end;

procedure TInplaceLocaleEdit.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
end;

procedure TInplaceLocaleEdit.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  if (EditStyle <> esSimple) and OverButton(P) then
    Windows.SetCursor(LoadCursor(0, idc_Arrow))
  else
    inherited;
end;

procedure TInplaceLocaleEdit.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    wm_KeyDown, wm_SysKeyDown, wm_Char:
      if EditStyle = esPickList then
      with TWMKey(Message) do
      begin
        DoDropDownKeys(CharCode, KeyDataToShiftState(KeyData));
        if (CharCode <> 0) and ListVisible then
        begin
          with TMessage(Message) do
            SendMessage(ActiveList.Handle, Msg, WParam, LParam);
          Exit;
        end;
      end
  end;
  inherited;
end;

procedure TInplaceLocaleEdit.DblClick;
var
  Index: Integer;
  ListValue: string;
begin
  if (EditStyle = esSimple) or Assigned(TAccessCustomGrid(Grid).OnDblClick) then
    inherited
  else if (EditStyle = esPickList) and (ActiveList = PickList) then
  begin
    DoGetPickListItems;
    if PickList.Items.Count > 0 then begin
      Index := PickList.ItemIndex + 1;
      if Index >= PickList.Items.Count then Index := 0;
      PickList.ItemIndex := Index;
      ListValue := PickList.Items[PickList.ItemIndex];
      Perform(WM_SETTEXT, 0, Longint(ListValue));
      Modified := True;
      with TAccessCustomGrid(Grid) do
        SetEditText(Col, Row, ListValue);
      SelectAll;
    end;
  end
  else if EditStyle = esEllipsis then
    DoEditButtonClick;
end;

{ TLocaleEditorGrid }

constructor TLocaleEditorGrid.Create(AOwner: TComponent; const AStrings: TStrings);
begin
  inherited Create(AOwner);
  FLanguages := TStringList.Create;
  FLanguages.AddStrings(AStrings);
  ColCount := 2;
  inherited RowCount := 2;
  FixedCols := 0;
  DefaultColWidth := 150;
  DefaultRowHeight := 18;
  ColWidths[1] := 230;
  Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine,
    goColSizing, goEditing, goThumbTracking];
  Cells[0, 0] := 'Language';
  Cells[1, 0] := 'Value';
  Cells[0, 1] := '(Default)';
end;

destructor TLocaleEditorGrid.Destroy;
begin
  FLanguages.Free;
  inherited Destroy;
end;

function TLocaleEditorGrid.CreateEditor: TInplaceEdit;
begin
  FEdit := TInplaceLocaleEdit.Create(Self);
  TInplaceLocaleEdit(FEdit).DropDownRows := 8;
  TInplaceLocaleEdit(FEdit).OnGetPickListitems := EditListGetItems;
  Result := FEdit;
end;

procedure TLocaleEditorGrid.EditListGetItems(ACol, ARow: Integer; Items: TStrings);
begin
  if ACol = 0then begin
    Items.Clear;
    Items.AddStrings(FLanguages);
  end;
end;

function TLocaleEditorGrid.GetEditStyle(ACol, ARow: Integer): TEditStyle;
begin
  if (ACol = 0) and (ARow > 1) then Result := esPickList
  else Result := esSimple;
end;

function TLocaleEditorGrid.CanEditModify: Boolean;
begin
  Result := inherited CanEditModify;
  if Result then
    Result := Col = 1;
end;

procedure TLocaleEditorGrid.KeyDown(var Key: Word; Shift: TShiftState);

  procedure SetRow(NewRow: Integer);
  begin
    Row := NewRow;
    Key := 0;
  end;

begin
  case Key of
    VK_DOWN:
      if (Shift = []) and (Row = RowCount - 1) and not IsEmptyRow then begin
        RowCount := RowCount + 1;
        Row := RowCount - 1;
        Col := 0;
        Key := 0;
      end;
    VK_UP:
      if (Shift = []) and (Row = RowCount - 1) and IsEmptyRow then begin
        DeleteRow(Row);
        Key := 0;
      end;
    VK_INSERT:
      if (Shift = []) and ((Cells[0, RowCount - 1] <> '') or (Cells[1, RowCount - 1] <> '')) then begin
        RowCount := RowCount + 1;
        Row := RowCount - 1;
        Col := 0;
        Key := 0;
      end;
    VK_DELETE:
      if (Shift = []) then begin
        DeleteRow(Row);
        Key := 0;
      end;
    VK_ESCAPE:
      RestoreCurrentRow;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TLocaleEditorGrid.DeleteRow(ARow: Integer);
begin
  if (ARow >= 2) then begin
    Cells[0, Row] := '';
    Cells[1, Row] := '';
    inherited DeleteRow(ARow);
    if ARow <> RowCount then Row := ARow;
  end;
end;

function TLocaleEditorGrid.IsEmptyRow: Boolean;
begin
  Result := (Cells[0, Row] = '') and (Cells[1, Row] = '');
end;

function TLocaleEditorGrid.RestoreCurrentRow: Boolean;

  function RestoreInplaceEditor: Boolean;
  var
    ChangedText: string;
  begin
    Result := False;
    if Assigned(FEdit) and FEdit.Modified then
    begin
      ChangedText := FEdit.EditText;
      TInplaceLocaleEdit(FEdit).RestoreContents;
      Result := ChangedText <> FEdit.EditText;
      if Result then
        FEdit.SelectAll;
    end;
  end;

begin
  Result := RestoreInplaceEditor;
  if not Result and IsEmptyRow then
  begin
    DeleteRow(Row);
    Result := True;
  end
end;

end.
