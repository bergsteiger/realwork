unit vtCombo;

interface
{$i fcIfDef.pas}

uses
  Forms, Menus, SysUtils, Windows, Graphics, Messages, Classes,
  Controls, Buttons, Mask, StdCtrls, fcCommon, TypInfo, Dialogs;

type
  TfcComboButtonStyle = (cbsEllipsis, cbsDownArrow);
  TfcComboStyle = (csDropDown, csDropDownList);
  TfcAlignVertical = (fcavTop, fcavCenter);
  TfcComboCloseUpEvent = procedure(Sender: TObject; Select: boolean) of object;

  TvtOnGetDropDownControl = procedure(Sender: TObject; var aDropDownControl : TWinControl) of object;

  TvtDropDownButton = class(TSpeedButton)
  private
    //procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
  protected
    //procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    //procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
  end;

  TvtCustomCombo = class(TCustomEdit)
  private
    FAlignmentVertical: TfcAlignVertical;
    FBtnParent: TWinControl;
    FButton: TvtDropDownButton;
    ///FDataLink: TFieldDataLink;
    FDropDownCount: Integer;
    //FInfoPower: Boolean;
    FOnCustomDlg: TNotifyevent;
    FOnCloseUp: TfcComboCloseUpEvent;
    FOnDropDown: TNotifyEvent;
    FButtonStyle: TfcComboButtonStyle;
    FCanvas, FPaintCanvas: TControlCanvas;
    FStyle: TfcComboStyle;
    FReadOnly: boolean;
    FAllowClearKey: boolean;

    FOnMouseEnterControl: TMouseEvent;
    FOnMouseLeaveControl: TMouseEvent;

    FSavedCursor: TCursor;
    FIgnoreCursorChange: Boolean;

    // Message Handlers
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMCursorChanged(var Message: TMessage); message CM_CURSORCHANGED;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBkgnd;

    // Property Access Methods
    ///function GetDataField: string;
    ///function GetDataSource: TDataSource;
    function  GetReadOnly: Boolean;
    procedure SetButtonStyle(Value: TfcComboButtonStyle);
    ///procedure SetDataField(Value: string);
    ///procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetStyle(Value: TfcComboStyle);
    procedure SetAlignmentVertical(Value: TfcAlignVertical);
  protected
    procedure SetDropDownCount(Value: Integer); virtual;
    function  GetDropDownControl: TWinControl; virtual; abstract;
    procedure SetDropDownControl(Value: TWinControl); virtual; abstract;

    function  GetDropDownContainer: TWinControl; virtual; abstract;
    ///function  GetItemCount: Integer; virtual; abstract;
    ///function  GetItemSize: TSize; virtual; abstract;
    function  GetLeftIndent: Integer; virtual;
    procedure BtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure DrawButton(Canvas: TCanvas; R: TRect; State: TButtonState; ControlState: TControlState; var DefaultPaint:boolean); virtual;
    procedure HideCaret; virtual;
    procedure Paint; virtual;
    procedure ShowCaret; virtual;

    // Virtual Property Access Methods
    function  GetShowButton: Boolean; virtual;
    procedure SetModified(Value: Boolean); virtual;
    procedure SetShowButton(Value: Boolean);

    // Virtual Methods
    function Editable: Boolean; virtual;
    function EditCanModify: Boolean; virtual;
    function GetClientEditRect: TRect; virtual;
    function GetEditRect: TRect; virtual;
    function GetIconIndent: Integer; virtual;
    function GetIconLeft: Integer; virtual;
    procedure DoDropDown; virtual;
    procedure CloseUp(Accept: Boolean); virtual;
    procedure DataChange(Sender: TObject); virtual;
    procedure EditingChange(Sender: TObject); virtual;
    procedure HandleDropDownKeys(var Key: Word; Shift: TShiftState); virtual;
    ///procedure HandleGridKeys(var Key: Word; Shift: TShiftState); virtual;
    procedure Reset; virtual;
    procedure SetEditRect; virtual;
    procedure UpdateButtonPosition; virtual;
    procedure UpdateData(Sender: TObject); virtual;
    function EffectiveReadOnly: Boolean; virtual;
    procedure DoCloseUp(Accept: boolean); virtual;
    procedure DoEnter; override;

    function GetRightIndent(Rect:TRect): Integer; virtual;
    function GetTopIndent: Integer; virtual;

    // Overridden Methods
    procedure Change; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure WndProc(var Message: TMessage); override;
    procedure PaintToCanvas(Canvas: TCanvas; Rect: TRect; Highlight, GridPaint: Boolean;
      Text: string); virtual; abstract;

    property Canvas: TControlCanvas read FCanvas;
    ///property DataLink: TFieldDataLink read FDataLink;
    property DropDownContainer: TWinControl read GetDropDownContainer;
    property BtnParent: TWinControl read FBtnParent;
  public
    ///ComboPatch: Variant;
    constructor Create(AOwner:tcomponent); override;
    destructor Destroy; override;

    procedure SelectAll; virtual;
    ///function IsDataBound: Boolean; virtual;
    function IsDroppedDown: Boolean; virtual;
    procedure CheckCancelMode; virtual;
    ///procedure DrawInGridCell(ACanvas: TCanvas; Rect: TRect; State: TGridDrawState); virtual;
    procedure DropDown; virtual;

    property AlignmentVertical: TfcAlignVertical read FAlignmentVertical write SetAlignmentVertical default fcavTop;
    property AllowClearKey: boolean read FAllowClearKey write FAllowClearKey default False;
    property Button: TvtDropDownButton read FButton;
    property ButtonStyle: TfcComboButtonStyle read FButtonStyle write SetButtonStyle;
    ///property DataField: string read GetDataField write SetDataField;
    ///property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DropDownCount: Integer read FDropDownCount write SetDropDownCount;
    property DropDownControl: TWinControl read GetDropDownControl write SetDropDownControl;
    ///property InfoPower: Boolean read FInfoPower;
    ///property ItemCount: Integer read GetItemCount;
    ///property ItemSize: TSize read GetItemSize;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
    property ShowButton: boolean read GetShowButton write SetShowButton default True;
    property Style: TfcComboStyle read FStyle write SetStyle;
    property OnCustomDlg: TNotifyevent read FOnCustomDlg write FOnCustomDlg;
    property OnCloseUp: TfcComboCloseUpEvent read FOnCloseUp write FOnCloseUp;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;

    property OnMouseEnterControl: TMouseEvent read FOnMouseEnterControl write FOnMouseEnterControl;
    property OnMouseLeaveControl: TMouseEvent read FOnMouseLeaveControl write FOnMouseLeaveControl;
  end;

  ///function fcGetControlInGrid(Form: TComponent; Grid: TComponent; FieldName: string): TvtCustomCombo;

  TvtCustomListCombo = class(TvtCustomCombo)
   protected
    function  GetItemCount: Integer; virtual; abstract;
    function  GetItemSize: TSize; virtual; abstract;
   public
    procedure DropDown; override;
    property ItemCount: Integer read GetItemCount;
    property ItemSize: TSize read GetItemSize;
  end;


  TvtComboEdit = class(TvtCustomCombo)
   protected
    fOnGetDropDownControl : TvtOnGetDropDownControl;

    procedure SetDropDownControl(Value: TWinControl); override;
    function  GetDropDownControl: TWinControl;        override;
    function  GetDropDownContainer: TWinControl;      override;
    ///function  GetItemCount: Integer;                  override;
    ///function  GetItemSize: TSize;                     override;

  published
    property OnGetDropDownControl : TvtOnGetDropDownControl read fOnGetDropDownControl write fOnGetDropDownControl;

    {$ifdef fcDelphi4Up}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property ParentBiDiMode;
    {$endif}

    ///property UnboundAlignment;
    property AlignmentVertical;
    property AllowClearKey;
    ///property AutoDropDown;
    property AutoSelect;
    property AutoSize;
    property ShowButton;
    property BorderStyle;
    property ButtonStyle;
    property CharCase;
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    ///property DropDownWidth;
    property Enabled;
    property Font;
    {$ifdef ver100}
    property ImeMode;
    property ImeName;
    {$endif}
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property Style default csDropDownList;
    property TabOrder;
    property TabStop;
    property Visible;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnCloseUp;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
end;


implementation

type
  ///TCheatGridCast = class(TCustomGrid);

  TBtnWinControl = class(TWinControl)
  private
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBkgnd;
  end;

var fcCOMBOHOOK: HHOOK = 0;
    WM_FC_CALLDROPDOWN: UINT = 0;

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


{function fcGetControlInGrid(Form: TComponent; Grid: TComponent; FieldName: string): TvtCustomCombo;
var i: Integer;
    ControlType: TStrings;
    AComponent: TComponent;
begin
  if not Boolean(fcGetOrdProp(Grid, 'ControlInfoInDataSet')) then
    ControlType := TStrings(fcGetOrdProp(Grid, 'ControlType'))
  else ControlType := TStrings(fcGetOrdProp(TDataSource(fcGetOrdProp(Grid, 'DataSource')).DataSet, 'ControlType'));

  result := nil;

  for i := 0 to ControlType.Count - 1 do
  begin
    if (fcGetToken(ControlType[i], ';', 0) = FieldName) then
    begin
      AComponent := Form.FindComponent(fcGetToken(ControlType[i], ';', 2));
      if AComponent is TvtCustomCombo then
         result := AComponent as TvtCustomCombo;
      Break;
    end;
  end;   vctrls
end;
}
function fcComboHookProc(nCode: Integer; wParam: Integer; lParam: Integer): LResult; stdcall;
var r1, r2: TRect;
    CurHandle: HWND;
begin
  result := CallNextHookEx(fcCOMBOHOOK, nCode, wParam, lParam);
  with PMouseHookStruct(lParam)^ do
  begin
    case wParam of
      WM_LBUTTONDOWN, WM_NCLBUTTONDOWN :
       begin
        if (Screen.ActiveControl <> nil) and (Screen.ActiveControl is TvtCustomCombo) then
         with (Screen.ActiveControl as TvtCustomCombo) do
          begin
           If (hwnd <> DropDownControl.Handle) then CloseUp(False);
           if IsDroppedDown and (hwnd = DropDownControl.Handle) then
            begin
             GetWindowRect(DropDownControl.Handle, r1);
             GetWindowRect(Handle, r2);
             with r1 do
              begin
               Right := Left + DropDownControl.Width;
               Bottom := Top + DropDownControl.Height;
              end;
             CurHandle := Handle;
             if wParam = WM_LBUTTONDOWN then CurHandle := DropDownControl.Handle;
             if not PtInRect(r1, pt) then
              with DropDownControl.ScreenToClient(Point(pt.x, pt.y)) do
               PostMessage(CurHandle, wParam, 0, MakeLParam(WORD(fcThisThat(x >= 0, x, -1)),WORD(fcThisThat(y >= 0, y, -1))));
            end
          end
       end;
      WM_MOUSEMOVE, WM_LBUTTONUP:
       begin
        if (Screen.ActiveControl <> nil) and (Screen.ActiveControl is TvtCustomCombo) then
         with (Screen.ActiveControl as TvtCustomCombo) do
          If (hwnd = DropDownControl.Handle) then
          if not PtInRect(r1, pt) then
           with DropDownControl.ScreenToClient(Point(pt.x, pt.y)) do
            PostMessage(DropDownControl.Handle, wParam, 0, MakeLParam(WORD(fcThisThat(x >= 0, x, -1)),WORD(fcThisThat(y >= 0, y, -1))));
       end
    end;
  end;
end;

{procedure TvtDropDownButton.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  inherited;
//  Message.Result := 1;
end;

procedure TvtDropDownButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//  TvtCustomCombo(Owner).FDroppingDown := True;
  inherited;
end;

procedure TvtDropDownButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
//  TvtCustomCombo(Owner).FDroppingDown := False;
end;
}
procedure TvtDropDownButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if not PtInRect(Clientrect, Point(x, y)) then
  begin
    Perform(WM_LBUTTONUP, 0, MAKELPARAM(x, y));
    ReleaseCapture;
  end;
end;

procedure TvtDropDownButton.Paint;
var R : TRect;
    DefaultPaint:boolean;
begin
  if (csPaintCopy in ControlState) and fcIsInWWGrid(parent.parent) then exit; { 6/28/99 }

  SetRect(R, 0, 0, ClientWidth, ClientHeight);
  with TvtCustomCombo(Parent.Parent) do
  begin
    DefaultPaint:= True;
    DrawButton(self.Canvas, R, FState, ControlState, DefaultPaint);
    if DefaultPaint then inherited Paint;
  end;
end;

constructor TvtCustomCombo.Create;
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle + [csReplicatable];

  FCanvas := TControlCanvas.Create;
  FCanvas.Control := self;

  FAlignmentVertical := fcavTop;
  FButtonStyle := cbsDownArrow;
  FDropDownCount := 8;

  FBtnParent := TBtnWinControl.Create (Self);
  with FBtnParent do
  begin
    ControlStyle := ControlStyle + [csReplicatable];
    Width := fcMax(GetSystemMetrics(SM_CXVSCROLL) + 4, 17);
    Height := 17;
    Visible := True;
    Parent := Self;
  end;

  FButton := TvtDropDownButton.Create(self);
  with FButton do
  begin
    ControlStyle := ControlStyle + [csReplicatable];
    SetBounds (0, 0, FBtnParent.Width, FBtnParent.Height);
    Width := fcMax(GetSystemMetrics(SM_CXVSCROLL), 15);
    Parent := FBtnParent;
    OnMouseDown := BtnMouseDown;
  end;

  {FDataLink := TFieldDataLink.Create;
  FDataLink.Control := self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;}

  FSavedCursor := crIBeam;
end;

destructor TvtCustomCombo.Destroy;
begin
  if fcCOMBOHOOK <> 0 then
  begin
    UnhookWindowsHookEx(fcCOMBOHOOK);
    fcCOMBOHOOK := 0;
  end;
  FCanvas.Free;
  FPaintCanvas.Free;
  {FDataLink.Free;
  FDataLink:= Nil;}
  inherited Destroy;
end;

function TvtCustomCombo.GetIconIndent: Integer;
begin
  result:= FBtnParent.Width;
end;

function TvtCustomCombo.GetIconLeft: Integer;
begin
  result:= FBtnParent.Left - 1;
end;

function TvtCustomCombo.GetShowButton: Boolean;
begin
  result:= FBtnParent.Visible;
end;

procedure TvtCustomCombo.SetShowButton(Value: Boolean);
begin
  if (FBtnParent.Visible <> Value) then
  begin
    FBtnParent.Visible := Value;
    UpdateButtonPosition;
    if not (csLoading in Owner.ComponentState) then SetEditRect;
    Invalidate;
  end
end;

procedure TvtCustomCombo.DrawButton(Canvas: TCanvas; R: TRect; State: TButtonState;
    ControlState: TControlState; var DefaultPaint:boolean);
begin
  DefaultPaint:= False;
  if ButtonStyle = cbsDownArrow then
     fcDrawDropDownArrow(Canvas, R, State, Enabled, ControlState)
  else fcDrawEllipsis(Canvas, R, State, Enabled, ControlState)
end;

procedure TvtCustomCombo.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    Style := Style and not (ES_AUTOVSCROLL or ES_WANTRETURN) or
      WS_CLIPCHILDREN or ES_MULTILINE;

end;

procedure TvtCustomCombo.CreateWnd;
begin
  inherited;
  SetEditRect;
end;

function TvtCustomCombo.GetEditRect: TRect;
begin
  result.Bottom := ClientHeight + 1;
  if ShowButton then result.Right := FBtnParent.Left - 1
  else result.Right := ClientWidth - 2;

  { RSW - 3/27/99 }
  Result.Top := GetTopIndent;
  if fcIsInwwObjectView(Self) then
  begin
    Result.Top:= 1;
    Result.Left:=1;
  end
  else if (BorderStyle = bsNone) and fcIsInwwGrid(Self) then begin
     Result.Left := 2;
  end
  else if (BorderStyle = bsNone) then
  begin
     Result.Left := 1;
  end
  else begin
     Result.Left := 0;
  end;
  inc(result.Left, GetLeftIndent);
end;

procedure TvtCustomCombo.SetEditRect;
var r: TRect;
begin
  Canvas.font:= Font; { 4/14/99 }
  r := GetEditRect;
  SendMessage(Handle, EM_SETRECTNP, 0, LPARAM(@r));
end;

procedure TvtCustomCombo.UpdateButtonPosition;
begin
  if (not NewStyleControls) or (BorderStyle = bsNone) or (not Ctl3d) then
    FBtnParent.SetBounds(Width - FButton.Width, 0, FButton.Width, ClientHeight)
  else
    FBtnParent.SetBounds(Width - FButton.Width - 4, 0, FButton.Width, ClientHeight);

  if not FBtnParent.Visible and (csDesigning in ComponentState) then
    FBtnParent.Left := BoundsRect.Right;

  if BorderStyle = bsNone then
  begin
    FButton.Top := -1;
    FButton.Height := FBtnParent.Height+1;
  end else begin
    FButton.Top:= 0;
    FButton.Height := FBtnParent.Height;
  end;

  SetEditRect;
end;

{function TvtCustomCombo.IsDataBound: Boolean;
begin
  result := (DataSource <> nil) and (DataSource.DataSet <> nil) and (DataField <> '');
end; }

procedure TvtCustomCombo.CheckCancelMode;
var p, p2: TPoint;
    wndRect: TRect;
begin
  GetCursorPos(p);
  p2 := DropDownControl.ClientToScreen(Point(0, 0));
  GetWindowRect(Handle, wndRect);
  with p2 do
  begin
    if (not PtInRect(Rect(x, y, x + DropDownControl.Width, y + DropDownControl.Height), p)) and
       (not PtInRect(wndRect, p)) then CloseUp(False);
  end;
end;

procedure TvtCustomCombo.DoCloseUp(Accept: boolean);
begin
   if Assigned(FOnCloseUp) then FOnCloseUp(self, Accept);
end;

procedure TvtCustomCombo.CloseUp(Accept: boolean);
//var i: Integer;
begin
//  i := GetCapture; { RSW }
//  if Accept then Modified := True; { RSW - Rely on parent class to set modified as we don't really know }
//  if i <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
  { RSW - comment out as this causes problem with button not getting mouse up }
  try
    SelectAll;

    if IsDroppedDown then
    begin
      SetWindowPos(DropDownContainer.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
        SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
      DropDownContainer.Visible := False;
      Invalidate;
      if DropDownControl.Focused then SetFocus;
     { RSW - Let parent class call CloseUP so that its fired after things are updated (i.e. modified flag )}
//    if Assigned(FOnCloseUp) then FOnCloseUp(self, Accept);
    end;
    if Style = csDropDownList then HideCaret;
  finally
    if fcCOMBOHOOK <> 0 then
    begin
      UnhookWindowsHookEx(fcCOMBOHOOK);
      fcCOMBOHOOK := 0;
    end;
  end;
end;

procedure TvtCustomCombo.DataChange(Sender: TObject);
begin
  {if FDataLink.Field <> nil then
  begin
    if not (csDesigning in ComponentState) then
    begin
      if (FDataLink.Field.DataType = ftString) and (MaxLength = 0) then
        MaxLength := FDataLink.Field.Size;
    end;
    if Focused and FDataLink.CanModify then
      Text := FDataLink.Field.Text
    else begin
      Text := FDataLink.Field.DisplayText;
      if FDataLink.Editing then
        Modified := True;
    end;
  end else }
  begin
    if csDesigning in ComponentState then
      Text := Name else
      Text := '';
  end;
end;

procedure TvtCustomCombo.EditingChange(Sender: TObject);
begin
  ///inherited ReadOnly := not FDataLink.Editing;  // RSW use inherited ReadOnly
end;

procedure TvtCustomCombo.UpdateData(Sender: TObject);
begin
  {if FDataLink.Field.Text <> Text then
    FDataLink.Field.Text := Text;}
end;

{procedure TvtCustomCombo.DrawInGridCell(ACanvas: TCanvas; Rect: TRect;
  State: TGridDrawState);
begin
end;}

procedure TvtCustomCombo.DoDropDown;
begin
  if Assigned(FOnDropDown) then FOnDropDown(self);
end;

procedure TvtCustomCombo.DropDown;
 var
  p: TPoint;
 begin
  if fcCOMBOHOOK = 0 then fcCOMBOHOOK := SetWindowsHookEx(WH_MOUSE, @fcComboHookProc, HINSTANCE, GetCurrentThreadID);
  DoDropDown;

  p := Parent.ClientToScreen(Point(Left, Top));

  if p.x > Screen.Width - DropDownContainer.Width
   then p.x := (p.x + Width) - DropDownContainer.Width;

  if p.y + Height + DropDownContainer.Height > Screen.Height
   then p.y := (p.y - Height) - DropDownContainer.Height;

  ///TEdit(DropDownContainer).Color := TEdit(DropDownControl).Color;

  ///Windows.SetParent(DropDownContainer.Handle, 0);
  { 6/22/99 - Use HWND_TOPMOST only for formstyle=fsStayOnTop }
  if TForm(GetParentForm(self)).formstyle = fsStayOnTop
   then
    SetWindowPos(DropDownContainer.Handle, HWND_TOPMOST, p.x, p.y + Height, 0, 0,
      {SWP_NOACTIVATE or }SWP_SHOWWINDOW or SWP_NOSIZE)
   else
    SetWindowPos(DropDownContainer.Handle, HWND_TOP,     p.x, p.y + Height, 0, 0,
      {SWP_NOACTIVATE or }SWP_SHOWWINDOW or SWP_NOSIZE);
  DropDownContainer.Visible := True;
  DropDownControl.Update;
  //2/25/99 - Let inherited classes do the selectall.
  //  SelectAll;
  ShowCaret;
 end;

{ return true if allowed to type text into control }
function TvtCustomCombo.Editable: boolean;
begin
  result := true;
//  Result := IsDroppedDown;
end;

procedure TvtCustomCombo.HandleDropDownKeys(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_UP, VK_DOWN:
      if ssAlt in Shift then
      begin
        if IsDroppedDown then CloseUp(True)
        else DropDown;
        Key := 0;
      end;
    VK_RETURN, VK_ESCAPE:
      if IsDroppedDown and not (ssAlt in Shift) then
      begin
        CloseUp(Key = VK_RETURN);
        Key := 0;
      end
  end;
end;

procedure TvtCustomCombo.Change;
begin
  //if ((DataLink<>Nil) and (FDataLink.Field=Nil)) then
  Modified:= True;
{  if (DataLink<>Nil) and
     ((FDataLink.Field=Nil) or
      (DataSource.dataset.state in [dsEdit, dsInsert])) then
  begin
     FDataLink.Modified;
     Modified:= True;
  end;}

  inherited;
end;

function TvtCustomCombo.EditCanModify: Boolean;
begin
  result:= False;
  if EffectiveReadOnly then exit; { RSW - otherwise CloseUP still goes into edit mode}
  {if FDatalink.Field <> nil then result := FDataLink.Edit
  else}
  result := True;
end;

(*procedure TvtCustomCombo.HandleGridKeys(var Key: Word; Shift: TShiftState);
type
  TSelection = record
    StartPos, EndPos: Integer;
  end;

var SkipGridCode: boolean;

  procedure SendToObjectView;
  begin
     TCheatGridCast(Parent).KeyDown(Key, Shift);
  end;

  procedure SendToParent;
  begin
    Parent.setFocus;
    if Parent.focused then
       SendMessage(Parent.handle,wm_keydown,key,0);
    Key := 0;
  end;

  procedure ParentEvent;
  var GridKeyDown: TKeyEvent;
  begin
    { 1/25/99 - RSW Prevent grid's OnKeyDown from firing twice when encounter tab or cr }
    if (Screen.ActiveControl<>self) and ((key=13) or (key=9)) then exit;

    GridKeyDown := TEdit(Parent).OnKeyDown;
    if Assigned(GridKeyDown) then GridKeyDown(Parent, Key, Shift);
  end;

  function Alt: Boolean;
  begin
    Result := ssAlt in Shift;
  end;

  function Ctrl: Boolean;
  begin
    Result := ssCtrl in Shift;
  end;

{  procedure Deselect;
  begin
    Exit;
    SendMessage(Handle, EM_SETSEL, -1, 0);
    selLength := 0;
  end;}

  function ForwardMovement: Boolean;
  begin
     Result := (dgAlwaysShowEditor in fcGetGridOptions(self));
  end;

  function Selection: TSelection;
  begin
    SendMessage(Handle, EM_GETSEL, Longint(@Result.StartPos), Longint(@Result.EndPos));
  end;

  function LeftSide: Boolean;
  begin
//    result := ((SelStart = 0) and (SelLength <> GetTextLen)) or (Style = csDropDownList)
    with Selection do
      Result := (StartPos = 0) and
      ((EndPos = 0) or (EndPos = GetTextLen));
  end;

  function RightSide: Boolean;
  begin
    with Selection do
      Result := ((StartPos = 0) or (EndPos = StartPos)) and
        (EndPos = GetTextLen);
   end;

  procedure Deselect; {!!! Don't do for Treecombo}
  begin
    SendMessage(Handle, EM_SETSEL, -1, 0);
    selLength:= 0;
  end;

begin
  if (Key in [vk_next, vk_prior, vk_up, vk_down, vk_home, vk_end, vk_right, vk_left]) and
     (IsDroppedDown) then skipGridCode:= True
  else SkipGridCode:= False;

  if (fcIsInwwGrid(Self)) and (not SkipGridCode) then begin
    case Key of
      VK_ESCAPE: if not Modified then SendToParent;
      VK_NEXT, VK_PRIOR, VK_UP, VK_DOWN: if (not Alt) then SendToParent;
      VK_LEFT: if fcIsInwwObjectView(self) then SendToObjectView
                else if ForwardMovement and (Ctrl or LeftSide) then SendToParent;
      VK_RIGHT: if fcIsInwwObjectView(self) then SendToObjectView
                 else if ForwardMovement and (Ctrl or RightSide) then SendToParent;
      VK_HOME: if ForwardMovement and (Ctrl or LeftSide) then SendToParent;
      //((SelStart = 0) and (SelLength <> GetTextLen)) or (Style = csDropDownList) then SendToParent;
      VK_END: if ForwardMovement and (Ctrl or RightSide) then SendToParent;
      //if (SelStart = GetTextLen) or (Style = csDropDownList) then SendToParent;
      VK_INSERT: if not (ssShift in Shift) then SendToParent;
      VK_DELETE: if Ctrl then SendToParent;
      VK_F2:
         begin
           ParentEvent;
           if Key = VK_F2 then
           begin
             if Editable and (Style=csDropDown) then Deselect;
             Key:=0;
           end;
         end;
    end;
    if not (Editable and (Style=csDropDown)) and
       (Key in [VK_LEFT, VK_RIGHT, VK_HOME, VK_END]) then
       if not fcIsInwwObjectView(self) then SendToParent;

    if Key <> 0 then ParentEvent;
  end;
  if Key = 0 then Exit;

  if (ssCtrl in Shift) then
  begin
    inherited KeyDown(Key, Shift);
     Exit;
  end;

  if fcIsInwwGrid(Self) and (Key = VK_TAB) then
  begin
    inherited KeyDown(Key, Shift);
    Exit;
  end;

  inherited KeyDown(Key, Shift);
end;
*)

procedure TvtCustomCombo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if GetKeyState(VK_MENU) < 0 then Include(Shift, ssAlt);

  if modified and (not isDroppedDown) and (key=VK_ESCAPE) then
  begin
    Reset;
    Key := 0;
  end;

  HandleDropDownKeys(Key, Shift);
  //HandleGridKeys(Key, Shift);

  inherited KeyDown(Key, Shift);

  {if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
   }
end;


procedure TvtCustomCombo.KeyPress(var Key: Char);
begin
  inherited;
  if EffectiveReadOnly then
  begin
     Key:= #0;
     exit;
  end;{ RSW }

(*  case Key of
    ^H, ^V, ^X, #32..#255:
//      if (Style = csDropDown) or IsDroppedDown then
//      if (Style = csDropDown) or isDroppedDown then
      if Editable then
      begin
         if (not IsDroppedDown) then FDataLink.Edit
      end
      else Key := #0;
    #27:
      begin
//        Reset;  //12/11/1998 - Moved to OnKeyDown event.
        Key := #0;
      end;
    #9, #13: if fcIsInwwGrid(Self) then Key:= #0;
                                                         { 4/28/99 - Ignore tab and cr                            }
                                                         { cr needs to be eaten so that parentgrid is not confused }
                                                         { when using dgEnterToTab }
  end;
 *)
end;

function TvtCustomCombo.GetClientEditRect: TRect;
begin
  result := ClientRect;
  if not fcIsInwwObjectViewPaint(self) and ShowButton then
     result.Right := FBtnParent.Left;
end;

{function TvtCustomCombo.GetDataField;
begin
  result := FDataLink.FieldName;
end;

function TvtCustomCombo.GetDataSource: TDataSource;
begin
  if FDataLink<>nil then
     result := FDataLink.DataSource
  else
    result:= nil;
end;
}
function TvtCustomCombo.EffectiveReadOnly: Boolean;
begin
  result:= FReadOnly;
  // or FDataLink.ReadOnly or {(inherited ReadOnly) or}
  //         ((FDataLink.Field<>nil) and (not FDataLink.Field.CanModify));
end;

function TvtCustomCombo.GetReadOnly: Boolean;
begin
  result:= FReadOnly;
//  if IsDataBound then result := FDataLink.ReadOnly else result := inherited ReadOnly;
end;

procedure TvtCustomCombo.SetButtonStyle(Value: TfcComboButtonStyle);
begin
  if Value <> FButtonStyle then
  begin
    FButtonStyle := Value;
    if HandleAllocated then RecreateWnd;
    FButton.Invalidate;
  end
end;

{procedure TvtCustomCombo.SetDataField(Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TvtCustomCombo.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(self);
end;
}
procedure TvtCustomCombo.SetReadOnly(Value: Boolean);
begin
//  FDataLink.ReadOnly:= Value;
  FReadOnly:= Value;
{  if Style <> csDropDownList then }inherited ReadOnly := Value;
//  if IsDataBound then FDataLink.ReadOnly := Value;
//{  if Style <> csDropDownList then }inherited ReadOnly := Value;
end;

procedure TvtCustomCombo.SetStyle(Value: TfcComboStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    if HandleAllocated and not (csLoading in ComponentState) then
    begin
      if FStyle = csDropDownList then
      begin
        inherited ReadOnly := True;  { Should be inherited Readonly, but Hidecaret already does this }
        HideCaret;
      end else begin
        ShowCaret;
      end;
    end;
  end;
end;

function TvtCustomCombo.IsDroppedDown: boolean;
begin
  result := False;
end;

procedure TvtCustomCombo.Loaded;
begin
  FButton.Width := fcMax(GetSystemMetrics(SM_CXVSCROLL), 15);
  if (Parent <> nil) or (Owner <> nil) then
    UpdateButtonPosition;
  inherited Loaded;
end;

procedure TvtCustomCombo.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Style = csDropDownList then
  begin
    if not IsDroppedDown and (Button = mbLeft) then begin
      PostMessage(Handle, WM_FC_CALLDROPDOWN, 0, 0);
      ReleaseCapture; { RSW - Capture causes cursor problems }
    end
    else CloseUp(True);
  end;
end;

procedure TvtCustomCombo.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FIgnoreCursorChange := True;
  if Style = csDropDownList then {Screen.}Cursor := crArrow else Cursor := FSavedCursor;   // Change component cursor, not screen cursor. -ksw (2/12/99)
  FIgnoreCursorChange := False;
end;

procedure TvtCustomCombo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  //if (Operation = opRemove) and (AComponent = DataSource) then DataSource := nil;
end;

procedure TvtCustomCombo.WndProc(var Message: TMessage);
begin
  if Message.Msg = WM_FC_CALLDROPDOWN then
    DropDown;
  case Message.Msg of
    WM_PASTE, WM_CUT, WM_KEYFIRST..WM_KEYLAST:
      if fcIsInwwGrid(self) then Change;
    WM_NCLBUTTONDOWN: CloseUp(True);
  end;

  inherited;
end;

procedure TvtCustomCombo.CMCancelMode(var Message: TCMCancelMode);
begin
//  if (Message.Sender <> Self) and (Message.Sender <> DropDownControl) then
//    CloseUp(False);
end;

procedure TvtCustomCombo.CMCursorChanged(var Message: TMessage);
begin
  inherited;
  if not FIgnoreCursorChange then FSavedCursor := Cursor;
end;

procedure TvtCustomCombo.CMEnter(var Message: TCMEnter);
begin
  if AutoSelect and not (csLButtonDown in ControlState) then SelectAll;
  inherited;
end;

procedure TvtCustomCombo.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  FButton.Enabled := Enabled;
end;

procedure TvtCustomCombo.CMExit(var Message: TCMExit);
begin
  {try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;}
  DoExit;
end;

//3/23/1999 - PYW - Need to automatically set datasource when dropping control
//                  in a TDBCtrlGrid.
procedure TvtCustomCombo.CMGetDataLink(var Message: TMessage);
begin
 // Message.Result := Integer(FDataLink);
end;

procedure TvtCustomCombo.CMTextChanged(var Message: TMessage);
begin
  inherited;
  //if fcIsInwwGrid(self) then Change;
end;

procedure TvtCustomCombo.CMFontChanged(var Message: TMessage);
begin
  inherited;
  // This is needed only when changing font in the middle of editing
  if not (csLoading in Owner.ComponentState) then SetEditRect;
end;

procedure TvtCustomCombo.CNKeyDown(var Message: TWMKeyDown);
var ShiftState: TShiftState;
begin
  if not (csDesigning in ComponentState) then
    with Message do
    begin
       if (charcode = VK_TAB) and IsDroppedDown then Closeup(True)
       else if((charcode=vk_return) or (charcode=vk_escape)) then begin
          if IsDroppedDown then exit
          else if (not modified) or (charcode = vk_return) then { 6/6/99 - Close this modal form }
             SendMessage(GetParent(Handle), TMessage(Message).Msg,
             TMessage(Message).wParam, TMessage(Message).lParam);
       end
    end;

  if not (csDesigning in ComponentState) and fcIsInwwGrid(self) then
  begin
    with Message do
    begin

      ShiftState := KeyDataToShiftState(KeyData);

      (*if (charcode = VK_TAB) or (charcode = VK_RETURN) then begin
         if parent is TCustomGrid then begin
           if (charcode <> VK_TAB) or (goTabs in TCheatGridCast(parent).Options) then {7/3/97}
           begin
              parent.setFocus;
              if parent.focused then { Bug fix - Abort in validation prevents focus change }
                TCheatGridCast(parent).KeyDown(charcode, shiftState);
              exit;
           end
         end
      end;

      if (CharCode = VK_TAB) or (CharCode = VK_RETURN) then
      begin
        if fcIsInwwGrid(self) then
        begin
          if (CharCode <> VK_TAB) or (dgTabs in (fcGetGridOptions(self))) then
          begin
            Parent.SetFocus;
            if Parent.Focused then
              SendMessage(Parent.Handle, WM_KEYDOWN, CharCode, 0);
            Exit;
          end
        end
      end
     *)
    end
  end;

  inherited;
end;

procedure TvtCustomCombo.WMPaint(var Message: TWMPaint);
var r: TRect;
    DC: HDC;
    PS: TPaintStruct;
begin
  if (csPaintCopy in ControlState) then
  begin
     // 6/28/99 - Support unbound csPaintCopy }
      { if not editable with focus, need to do drawing to show proper focus }
      try
         if FPaintCanvas = nil then
         begin
            FPaintCanvas := TControlCanvas.Create;
            FPaintCanvas.Control := Self;
         end;

         if Message.DC = 0 then DC := BeginPaint(Handle, PS)
         else DC:= Message.DC;
         FPaintCanvas.Handle := DC;

         {if FDataLink.Field=nil then}
            PaintToCanvas(FPaintCanvas, GetClientEditRect, True, False,
               Text);
         {else
            PaintToCanvas(FPaintCanvas, GetClientEditRect, True, False,
               FDataLink.Field.asString);}

      finally
         FPaintCanvas.Handle := 0;
         if Message.DC = 0 then EndPaint(Handle, PS);
      end;
  end
  else begin
     inherited;
     Paint;
  end;
  r := FBtnParent.ClientRect;
  InvalidateRect(FBtnParent.Handle, @r, False);
end;

procedure TvtCustomCombo.WMSize(var Message: TWMSize);
begin
  inherited;
  UpdateButtonPosition;
  SetEditRect;
end;

procedure TvtCustomCombo.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if DropDownContainer.HandleAllocated and (Message.FocusedWnd <> DropDownContainer.Handle) then
    CloseUp(True);
  if Style = csDropDownList then Invalidate;
end;

procedure TvtCustomCombo.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if Style = csDropDownList then
  begin
    Invalidate;
    ShowCaret;
    HideCaret;
  end;
end;

procedure TvtCustomCombo.SetModified(Value: Boolean);
begin
  //if Value then FDatalink.modified;
  inherited Modified := Value;
end;

procedure TvtCustomCombo.BtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Button <> mbLeft then Exit;
  if IsDroppedDown then CloseUp(True) { 2/11/99 - RSW }
  else begin
   { RSW - Kirk, what was this line for
     It causes a problem as its not ever reset.  For instance, your CMEnter code
     checks ControlState.  To see problem put control in grid and click in the control.
     Then tab to it and it does not select all }
//    ControlState := ControlState +[csLButtonDown];
    if CanFocus then SetFocus;
    if Focused then
       PostMessage(Handle, WM_FC_CALLDROPDOWN, 0, 0);
  end
end;

procedure TvtCustomCombo.HideCaret;
begin
  Windows.HideCaret(Handle);
  inherited ReadOnly := True;
end;

procedure TvtCustomCombo.Paint;
begin
end;

procedure TvtCustomCombo.Reset;
begin
  //if DataLink.Field <> nil then DataLink.Reset;
  SelectAll;
  SetModified(False);
  Paint;
end;

procedure TvtCustomCombo.SelectAll;
begin
   inherited SelectAll;
end;

procedure TvtCustomCombo.ShowCaret;
begin
  if not HandleAllocated then exit; //3/25/99-PYW - Make sure handle is allocated.
  Windows.ShowCaret(Handle);
  inherited ReadOnly := False;
end;

function TvtCustomCombo.GetLeftIndent: Integer;
begin
  result := 0;
end;

procedure TvtCustomCombo.SetDropDownCount(Value: Integer);
begin
  FDropDownCount := Value;
end;

procedure TvtCustomCombo.WMPaste(var Message: TMessage);
begin
  if (Style=csDropDown) and EditCanModify then
  begin
     //FDataLink.Edit;
     inherited;
     SetModified(True);
  end
  else inherited;
end;

function TvtCustomCombo.GetRightIndent(Rect:TRect): Integer;
begin
  result:= 0;
{  result := Width-2;
  if (ColorAlignment <> taRightJustify) then exit;
  if FColorListOptions = nil then exit;
  GetColorRectInfo(Rect,AWidth,AHeight);
  if (Awidth <> 0) then
     inc(result, -AWidth);}
end;

function TvtCustomCombo.GetTopIndent: Integer;
begin
  result := 0;
  if (BorderStyle = bsNone) and fcIsInwwGrid(Self) then begin
     Result := 2;
  end
  else if (BorderStyle = bsNone) then
  begin
     Result := 1;
  end;
  if AlignmentVertical = fcavCenter then
  begin
     if BorderStyle=bsNone then
        inc(result,(Height - Canvas.Textheight('A')-2) div 2)
     else
        result:= (Height - Canvas.Textheight('A')-5) div 2;
  end;
end;

procedure TvtCustomCombo.SetAlignmentVertical(Value: TfcAlignVertical);
begin
  if FAlignmentVertical <> Value then begin
     FAlignmentVertical := Value;
     Invalidate;
  end;
end;

Procedure TvtCustomCombo.DoEnter;
begin
   inherited DoEnter;
   //if (FDataLink.Field=Nil) then modified:= False;  { 1/21/97 - Only clear if unbound }
end;


procedure TBtnWinControl.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if fcIsInwwObjectViewPaint(parent)then
  begin
     Message.result:= 1;
     exit;
  end
  else inherited;
end;

procedure TvtCustomCombo.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if fcIsInwwObjectViewPaint(self)then
  begin
     Message.result:= 1;
     exit;
  end
  else inherited;
end;


{TvtCustomListCombo}

procedure TvtCustomListCombo.DropDown;
var p: TPoint;
    NewControlSize: TSize;
    Border: Integer;
begin
  if fcCOMBOHOOK = 0 then fcCOMBOHOOK := SetWindowsHookEx(WH_MOUSE, @fcComboHookProc, HINSTANCE, GetCurrentThreadID);
  DoDropDown;

  p := Parent.ClientToScreen(Point(Left, Top));

  // 2/25/99 - Handle Grid Paint bug when closing up in grid
  //if fcIsInwwGrid(Self) then inc(p.y);

  // Initialize size of DropDownControl
  Border := 2 * GetSystemMetrics(SM_CYBORDER);
  NewControlSize := ItemSize;
  if ItemCount > 0 then NewControlSize.cy :=
    fcMin(DropDownCount, ItemCount) * NewControlSize.cy
  else NewControlSize.cy := Height;
  inc(NewControlSize.cy, Border);
  DropDownContainer.Height := NewControlSize.cy;
  NewControlSize.cx := fcMax(Width, NewControlSize.cx + Border + 2 * GetSystemMetrics(SM_CXVSCROLL));

  // Adjust if near right edge of screen
  if p.x > Screen.Width - NewControlSize.cx then p.x := (p.x + Width) - NewControlSize.cx;
  // Adjust if near bottom of screen
  if p.y + Height + NewControlSize.cy > Screen.Height{GetSystemMetrics(SM_CYFULLSCREEN)} then p.y := (p.y - Height) - NewControlSize.cy;

  TEdit(DropDownContainer).Color := TEdit(DropDownControl).Color;

  { 6/22/99 - Use HWND_TOPMOST only for formstyle=fsStayOnTop }
  if TForm(GetParentForm(self)).formstyle = fsStayOnTop then
    SetWindowPos(DropDownContainer.Handle, HWND_TOPMOST, p.x, p.y + Height, NewControlSize.cx, NewControlSize.cy,
      SWP_NOACTIVATE or SWP_SHOWWINDOW)
  else
    SetWindowPos(DropDownContainer.Handle, HWND_TOP, p.x, p.y + Height, NewControlSize.cx, NewControlSize.cy,
      SWP_NOACTIVATE or SWP_SHOWWINDOW);
  DropDownContainer.Visible := True;
  DropDownControl.Update;
  //2/25/99 - Let inherited classes do the selectall.
  //  SelectAll;
  ShowCaret;
end;

{TvtComboEdit}

procedure TvtComboEdit.SetDropDownControl(Value: TWinControl);
 begin
  ///fDropDownCtrl := Value;
 end;

function TvtComboEdit.GetDropDownControl: TWinControl;
 begin
  If Assigned(fOnGetDropDownControl)
   then fOnGetDropDownControl(Self, Result)
   else Result := nil;
  ///fDropDownCtrl;
 end;

function TvtComboEdit.GetDropDownContainer: TWinControl;
 begin
  Result := GetDropDownControl;
 end;

{function TvtComboEdit.GetItemCount: Integer;
 begin
  result := 100;
 end;

function TvtComboEdit.GetItemSize: TSize;
 begin
  with result do
   begin
    cx := 120;
    cy :=  20;
   end;
 end;
 }
initialization
  WM_FC_CALLDROPDOWN := RegisterWindowMessage('FCCOMBODROPDOWNMESSAGE');
end.
