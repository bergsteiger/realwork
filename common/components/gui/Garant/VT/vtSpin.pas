unit vtSpin;

{$I vtDefine.inc }

{ $Id: vtSpin.pas,v 1.38 2015/04/16 13:54:22 lulin Exp $ }

// $Log: vtSpin.pas,v $
// Revision 1.38  2015/04/16 13:54:22  lulin
// - перерисовываем.
//
// Revision 1.37  2015/02/02 06:11:07  morozov
// {RequestLink: 587164757}
//
// Revision 1.36  2014/09/15 12:36:42  lukyanets
// Красивей даем заводить -1
//
// Revision 1.35  2013/05/31 09:27:52  kostitsin
// [$457092525]
//
// Revision 1.34  2013/05/27 11:57:34  kostitsin
// [$457092525]
//
// Revision 1.33  2013/05/21 09:38:51  kostitsin
// [$454533279]
//
// Revision 1.32  2013/05/17 11:37:11  kostitsin
// [$454533279]
//
// Revision 1.31  2013/04/05 12:02:45  lulin
// - портируем.
//
// Revision 1.30  2012/07/25 12:49:26  kostitsin
// [$379242708]
//
// Revision 1.29  2011/10/20 10:10:32  voba
// - k : 281529538
//
// Revision 1.28  2009/03/12 08:40:07  voba
// - ужесточил обработку колеса мыши. Теперь будет обрабатываться только если контрол в фокусе и курсор мыши над ним
//
// Revision 1.27  2007/11/26 09:31:18  voba
// - bug fix
//
// Revision 1.26  2006/12/15 11:30:43  lulin
// - добавлена картинка со счетчиком ссылок.
//
// Revision 1.25  2005/04/12 10:39:49  voba
// - bug fix
//
// Revision 1.24  2004/12/08 15:02:24  fireton
// - bug fix: перемещаем курсор в конец текста после присвоения значения
//
// Revision 1.23  2004/11/19 16:33:07  lulin
// - bug fix: съедались двухбуквенные ShortCut'ы.
//
// Revision 1.22  2004/08/09 06:50:47  demon
// - cleanup: remove warning
//
// Revision 1.21  2004/03/19 11:37:29  nikitin75
// поддержка shortcut'ов;
//
// Revision 1.20  2004/03/17 16:22:49  voba
// -new behavior: при вставке в vtSpin из буфера обмена счищаются все нецифры
//

interface

uses {$IFDEF WIN32} Windows, ComCtrls, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Controls, ExtCtrls, Classes, Graphics, Messages, Forms, StdCtrls, Menus,
  SysUtils;

type

{ TvtSpinButton }

  TSpinButtonState = (sbNotDown, sbTopDown, sbBottomDown);

  TvtSpinButton = class(TGraphicControl)
  private
    FDown: TSpinButtonState;
    FUpBitmap: TBitmap;
    FDownBitmap: TBitmap;
    FDragging: Boolean;
    FInvalidate: Boolean;
    FTopDownBtn: TBitmap;
    FBottomDownBtn: TBitmap;
    FRepeatTimer: TTimer;
    FNotDownBtn: TBitmap;
    FLastDown: TSpinButtonState;
    FFocusControl: TWinControl;
    FOnTopClick: TNotifyEvent;
    FOnBottomClick: TNotifyEvent;
    procedure TopClick;
    procedure BottomClick;
    procedure GlyphChanged(Sender: TObject);
    function GetUpGlyph: TBitmap;
    function GetDownGlyph: TBitmap;
    procedure SetUpGlyph(Value: TBitmap);
    procedure SetDownGlyph(Value: TBitmap);
    procedure SetDown(Value: TSpinButtonState);
    procedure SetFocusControl(Value: TWinControl);
    procedure DrawAllBitmap;
    procedure DrawBitmap(ABitmap: TBitmap; ADownState: TSpinButtonState);
    procedure TimerExpired(Sender: TObject);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Down: TSpinButtonState read FDown write SetDown default sbNotDown;
  published
    property DragCursor;
    property DragMode;
    property Enabled;
    property Visible;
    property DownGlyph: TBitmap read GetDownGlyph write SetDownGlyph;
    property UpGlyph: TBitmap read GetUpGlyph write SetUpGlyph;
    property FocusControl: TWinControl read FFocusControl write SetFocusControl;
    property ShowHint;
    property ParentShowHint;
{$IFDEF Delphi4}
    property Anchors;
    property Constraints;
    property DragKind;
{$ENDIF}
    property OnBottomClick: TNotifyEvent read FOnBottomClick write FOnBottomClick;
    property OnTopClick: TNotifyEvent read FOnTopClick write FOnTopClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
{$IFDEF WIN32}
    property OnStartDrag;
{$ENDIF}
{$IFDEF Delphi4}
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

{ TvtSpinEdit }

{$IFDEF CBUILDER}
  TValueType = (vtInt, vtFloat);
{$ELSE}
  TValueType = (vtInteger, vtFloat);
{$ENDIF}

  TvtSpinEdit = class(TCustomEdit)
  private
    FAlignment: TAlignment;
    FMinValue: Extended;
    FMaxValue: Extended;
    FEmptyValue: Extended;
    FEmptyText: String;
    FIncrement: Extended;
    FDecimal: Byte;
    FChanging: Boolean;
    FEditorEnabled: Boolean;
    FValueType: TValueType;
    FButton: TvtSpinButton;
    FBtnWindow: TWinControl;
    FArrowKeys: Boolean;
    FOnTopClick: TNotifyEvent;
    FOnBottomClick: TNotifyEvent;
{$IFDEF WIN32}
    //FButtonKind: TSpinButtonKind;
    FUpDown: TCustomUpDown;
    FAllowAnyValueManualInput: Boolean;
    //function GetButtonKind: TSpinButtonKind;
    //procedure SetButtonKind(Value: TSpinButtonKind);
    procedure UpDownClick(Sender: TObject; Button: TUDBtnType);
{$ENDIF}
    function GetMinHeight: Integer;
    procedure GetTextHeight(var SysHeight, Height: Integer);
    function GetValue: Extended;
    function CheckValue(NewValue: Extended): Extended;
    function GetAsInteger: Longint;
    function IsIncrementStored: Boolean;
    function GetUseMaxValue: Boolean;
    function GetUseMinValue: Boolean;

    (*function IsMinStored: Boolean;
    function IsMaxStored: Boolean;*)

    function IsEmptyTextStored: Boolean;
    function IsEmptyStored: Boolean;
    function IsValueStored: Boolean;
    procedure SetArrowKeys(Value: Boolean);
    procedure SetAsInteger(NewValue: Longint);
    procedure SetValue(NewValue: Extended);
    procedure SetMaxValue(aValue: Extended);
    procedure SetUseMaxValue(aValue: Boolean);
    procedure SetMinValue(aValue: Extended);
    procedure SetUseMinValue(aValue: Boolean);
    procedure SetEmptyValue(aValue: Extended);
    procedure SetEmptyText(const aValue: String);
    procedure SetValueType(NewType: TValueType);
    procedure SetDecimal(NewValue: Byte);
    function GetButtonWidth: Integer;
    procedure RecreateButton;
    procedure ResizeButton;
    procedure SetEditRect;
    procedure SetAlignment(Value: TAlignment);
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMEnter(var Message: TMessage); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMPaste(var Message: TWMPaste); message WM_PASTE;
    procedure WMCut(var Message: TWMCut); message WM_CUT;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure WMKeyDown(var Msg : TWMKeyDown); message WM_KEYDOWN;
    procedure WMSysKeyDown(var Msg : TWMSysKeyDown); message WM_SYSKEYDOWN;

    function  IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
  protected
    procedure Change; override;
    function  IsValidChar(Key: Char): Boolean; virtual;
    procedure UpClick(Sender: TObject); virtual;
    procedure DownClick(Sender: TObject); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    function  CheckWheelAccept : boolean;
    function  DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function  DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    function  IsEmpty : Boolean;
    property  AsInteger: Longint read GetAsInteger write SetAsInteger default 0;
    procedure MouseWheelHandler(var Message: TMessage); override;
    property  Text;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment
      default taLeftJustify;
    property ArrowKeys: Boolean read FArrowKeys write SetArrowKeys default True;
{$IFDEF WIN32}
    //property ButtonKind: TSpinButtonKind read FButtonKind write SetButtonKind
    //  default bkDiagonal;
{$ENDIF}
    property Decimal: Byte read FDecimal write SetDecimal default 2;
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Increment: Extended read FIncrement write FIncrement stored IsIncrementStored;
    property ValueType: TValueType read FValueType write SetValueType
      default {$IFDEF CBUILDER} vtInt {$ELSE} vtInteger {$ENDIF};
    property MaxValue: Extended read FMaxValue write SetMaxValue stored GetUseMaxValue;
    property MinValue: Extended read FMinValue write SetMinValue stored GetUseMinValue;
    property UseMaxValue: Boolean read GetUseMaxValue write SetUseMaxValue default True; //stored False;
    property UseMinValue: Boolean read GetUseMinValue write SetUseMinValue default True; //stored False;
    property AllowAnyValueManualInput: Boolean read FAllowAnyValueManualInput write FAllowAnyValueManualInput default False;
    property EmptyValue: Extended read FEmptyValue write SetEmptyValue stored IsEmptyStored;
    property EmptyText: String read FEmptyText write SetEmptyText stored IsEmptyTextStored;

    property Value: Extended read GetValue write SetValue stored IsValueStored;
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
{$IFDEF Delphi4}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
{$ENDIF}
{$IFDEF WIN32}
  {$IFNDEF VER90}
    property ImeMode;
    property ImeName;
  {$ENDIF}
{$ENDIF}
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnBottomClick: TNotifyEvent read FOnBottomClick write FOnBottomClick;
    property OnTopClick: TNotifyEvent read FOnTopClick write FOnTopClick;
    property OnChange;
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
{$IFDEF WIN32}
    property OnStartDrag;
{$ENDIF}
{$IFDEF Delphi4}
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

 type
  TSpinButtonKind = (bkStandard, bkDiagonal);

 const
  gSpinButtonKind: TSpinButtonKind = bkStandard;

implementation

uses
  Math,
  {$IFDEF WIN32}
  CommCtrl,
  {$ENDIF}
  {VCLUtils,}
  Buttons,
  {$IfDef evNeedOvc}
  OvcBase,
  OvcCmd,
  OvcConst,
  {$EndIf evNeedOvc}

  l3Chars,
  l3Bitmap
  
  {$If not defined(NoScripts)}
  ,
  SpinEditWordsPack
  {$IfEnd} //not NoScripts
  ;

{$IFDEF WIN32}
 {$R *.RES}
{$ELSE}
 {$R *.R16}
{$ENDIF}

const
  sSpinUpBtn = 'VTSPINUP';
  sSpinDownBtn = 'VTSPINDOWN';

const
  InitRepeatPause = 400; { pause before repeat timer (ms) }
  RepeatPause     = 100;

//TButtonState = (bsUp, bsDisabled, bsDown, bsExclusive);
(*procedure vtDrawButtonArrow(Canvas: TCanvas; R: TRect;
    State: TButtonState; Enabled: Boolean{; ControlState: TControlState});
 var Flags: Integer;
 begin
  Flags := DFCS_SCROLLDOWN;

  if not Enabled
   then Flags := Flags or DFCS_INACTIVE
   {else
    if not ((State=bsUp) or (csPaintCopy in ControlState))
     then Flags := Flags or DFCS_FLAT or DFCS_PUSHED;}
  DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, Flags);
 end;
*)
//DFCS_SCROLLDOWN	Down arrow of scroll bar
//DFCS_SCROLLRIGHT

{ TvtSpinButton }

constructor TvtSpinButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FUpBitmap := Tl3Bitmap.Create;
  FDownBitmap := Tl3Bitmap.Create;
  FUpBitmap.Handle := LoadBitmap(HInstance, sSpinUpBtn);
  FDownBitmap.Handle := LoadBitmap(HInstance, sSpinDownBtn);
  FUpBitmap.OnChange := GlyphChanged;
  FDownBitmap.OnChange := GlyphChanged;
  Height := 20;
  Width := 20;
  FTopDownBtn := Tl3Bitmap.Create;
  FBottomDownBtn := Tl3Bitmap.Create;
  FNotDownBtn := Tl3Bitmap.Create;
  DrawAllBitmap;
  FLastDown := sbNotDown;
end;

destructor TvtSpinButton.Destroy;
begin
  FTopDownBtn.Free;
  FBottomDownBtn.Free;
  FNotDownBtn.Free;
  FUpBitmap.Free;
  FDownBitmap.Free;
  FRepeatTimer.Free;
  inherited Destroy;
end;

procedure TvtSpinButton.GlyphChanged(Sender: TObject);
begin
  FInvalidate := True;
  Invalidate;
end;

function TvtSpinButton.GetUpGlyph: TBitmap;
begin
  Result := FUpBitmap;
end;

procedure TvtSpinButton.SetUpGlyph(Value: TBitmap);
begin
  if Value <> nil then FUpBitmap.Assign(Value)
  else FUpBitmap.Handle := LoadBitmap(HInstance, sSpinUpBtn);
end;

function TvtSpinButton.GetDownGlyph: TBitmap;
begin
  Result := FDownBitmap;
end;

procedure TvtSpinButton.SetDownGlyph(Value: TBitmap);
begin
  if Value <> nil then FDownBitmap.Assign(Value)
  else FDownBitmap.Handle := LoadBitmap(HInstance, sSpinDownBtn);
end;

procedure TvtSpinButton.SetDown(Value: TSpinButtonState);
var
  OldState: TSpinButtonState;
begin
  OldState := FDown;
  FDown := Value;
  if OldState <> FDown then Repaint;
end;

procedure TvtSpinButton.SetFocusControl(Value: TWinControl);
begin
  FFocusControl := Value;
{$IFDEF WIN32}
  if Value <> nil then Value.FreeNotification(Self);
{$ENDIF}
end;

procedure TvtSpinButton.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFocusControl) then
    FFocusControl := nil;
end;

procedure TvtSpinButton.Paint;
begin
  if not Enabled and not (csDesigning in ComponentState) then
    FDragging := False;
  if (FNotDownBtn.Height <> Height) or (FNotDownBtn.Width <> Width) or
    FInvalidate then DrawAllBitmap;
  FInvalidate := False;
  with Canvas do
    case FDown of
      sbNotDown: Draw(0, 0, FNotDownBtn);
      sbTopDown: Draw(0, 0, FTopDownBtn);
      sbBottomDown: Draw(0, 0, FBottomDownBtn);
    end;
end;

procedure TvtSpinButton.DrawAllBitmap;
begin
  DrawBitmap(FTopDownBtn, sbTopDown);
  DrawBitmap(FBottomDownBtn, sbBottomDown);
  DrawBitmap(FNotDownBtn, sbNotDown);
end;

procedure TvtSpinButton.DrawBitmap(ABitmap: TBitmap; ADownState: TSpinButtonState);
var
  R, RSrc: TRect;
  dRect: Integer;
  {Temp: TBitmap;}
begin
  ABitmap.Height := Height;
  ABitmap.Width := Width;
  with ABitmap.Canvas do begin
    R := Bounds(0, 0, Width, Height);
    Pen.Width := 1;
    Brush.Color := clBtnFace;
    Brush.Style := bsSolid;
    FillRect(R);
    { buttons frame }
    Pen.Color := clWindowFrame;
    Rectangle(0, 0, Width, Height);
    MoveTo(-1, Height);
    LineTo(Width, -1);
    { top button }
    if ADownState = sbTopDown then Pen.Color := clBtnShadow
    else Pen.Color := clBtnHighlight;
    MoveTo(1, Height - 4);
    LineTo(1, 1);
    LineTo(Width - 3, 1);
    if ADownState = sbTopDown then Pen.Color := clBtnHighlight
      else Pen.Color := clBtnShadow;
    if ADownState <> sbTopDown then begin
      MoveTo(1, Height - 3);
      LineTo(Width - 2, 0);
    end;
    { bottom button }
    if ADownState = sbBottomDown then Pen.Color := clBtnHighlight
      else Pen.Color := clBtnShadow;
    MoveTo(2, Height - 2);
    LineTo(Width - 2, Height - 2);
    LineTo(Width - 2, 1);
    if ADownState = sbBottomDown then Pen.Color := clBtnShadow
      else Pen.Color := clBtnHighlight;
    MoveTo(2, Height - 2);
    LineTo(Width - 1, 1);
    { top glyph }
    dRect := 1;
    if ADownState = sbTopDown then Inc(dRect);
    R := Bounds(Round((Width / 4) - (FUpBitmap.Width / 2)) + dRect,
      Round((Height / 4) - (FUpBitmap.Height / 2)) + dRect, FUpBitmap.Width,
      FUpBitmap.Height);
    RSrc := Bounds(0, 0, FUpBitmap.Width, FUpBitmap.Height);
    {
    if Self.Enabled or (csDesigning in ComponentState) then
      BrushCopy(R, FUpBitmap, RSrc, FUpBitmap.TransparentColor)
    else begin
      Temp := CreateDisabledBitmap(FUpBitmap, clBlack);
      try
        BrushCopy(R, Temp, RSrc, Temp.TransparentColor);
      finally
        Temp.Free;
      end;
    end;
    }
    BrushCopy(R, FUpBitmap, RSrc, FUpBitmap.TransparentColor);
    { bottom glyph }
    R := Bounds(Round((3 * Width / 4) - (FDownBitmap.Width / 2)) - 1,
      Round((3 * Height / 4) - (FDownBitmap.Height / 2)) - 1,
      FDownBitmap.Width, FDownBitmap.Height);
    RSrc := Bounds(0, 0, FDownBitmap.Width, FDownBitmap.Height);
    {
    if Self.Enabled or (csDesigning in ComponentState) then
      BrushCopy(R, FDownBitmap, RSrc, FDownBitmap.TransparentColor)
    else begin
      Temp := CreateDisabledBitmap(FDownBitmap, clBlack);
      try
        BrushCopy(R, Temp, RSrc, Temp.TransparentColor);
      finally
        Temp.Free;
      end;
    end;
    }
    BrushCopy(R, FDownBitmap, RSrc, FDownBitmap.TransparentColor);
    if ADownState = sbBottomDown then begin
      Pen.Color := clBtnShadow;
      MoveTo(3, Height - 2);
      LineTo(Width - 1, 2);
    end;
  end;
end;

procedure TvtSpinButton.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  FInvalidate := True;
  Invalidate;
end;

procedure TvtSpinButton.TopClick;
begin
  if Assigned(FOnTopClick) then begin
    FOnTopClick(Self);
    if not (csLButtonDown in ControlState) then FDown := sbNotDown;
  end;
end;

procedure TvtSpinButton.BottomClick;
begin
  if Assigned(FOnBottomClick) then begin
    FOnBottomClick(Self);
    if not (csLButtonDown in ControlState) then FDown := sbNotDown;
  end;
end;

procedure TvtSpinButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and Enabled then begin
    if (FFocusControl <> nil) and FFocusControl.TabStop and
      FFocusControl.CanFocus and (GetFocus <> FFocusControl.Handle) then
        FFocusControl.SetFocus;
    if FDown = sbNotDown then begin
      FLastDown := FDown;
      if Y > (-(Height/Width) * X + Height) then begin
        FDown := sbBottomDown;
        BottomClick;
      end
      else begin
        FDown := sbTopDown;
        TopClick;
      end;
      if FLastDown <> FDown then begin
        FLastDown := FDown;
        Repaint;
      end;
      if FRepeatTimer = nil then FRepeatTimer := TTimer.Create(Self);
      FRepeatTimer.OnTimer := TimerExpired;
      FRepeatTimer.Interval := InitRepeatPause;
      FRepeatTimer.Enabled := True;
    end;
    FDragging := True;
  end;
end;

procedure TvtSpinButton.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewState: TSpinButtonState;
begin
  inherited MouseMove(Shift, X, Y);
  if FDragging then begin
    if (X >= 0) and (X <= Width) and (Y >= 0) and (Y <= Height) then begin
      NewState := FDown;
      if Y > (-(Width / Height) * X + Height) then begin
        if (FDown <> sbBottomDown) then begin
          if FLastDown = sbBottomDown then FDown := sbBottomDown
          else FDown := sbNotDown;
          if NewState <> FDown then Repaint;
        end;
      end
      else begin
        if (FDown <> sbTopDown) then begin
          if (FLastDown = sbTopDown) then FDown := sbTopDown
          else FDown := sbNotDown;
          if NewState <> FDown then Repaint;
        end;
      end;
    end else
      if FDown <> sbNotDown then begin
        FDown := sbNotDown;
        Repaint;
      end;
  end;
end;

procedure TvtSpinButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if FDragging then begin
    FDragging := False;
    if (X >= 0) and (X <= Width) and (Y >= 0) and (Y <= Height) then begin
      FDown := sbNotDown;
      FLastDown := sbNotDown;
      Repaint;
    end;
  end;
end;

procedure TvtSpinButton.TimerExpired(Sender: TObject);
begin
  FRepeatTimer.Interval := RepeatPause;
  if (FDown <> sbNotDown) and MouseCapture then begin
    try
      if FDown = sbBottomDown then BottomClick else TopClick;
    except
      FRepeatTimer.Enabled := False;
      raise;
    end;
  end;
end;

function DefBtnWidth: Integer;
begin
  Result := GetSystemMetrics(SM_CXVSCROLL);
  if Result > 15 then Result := 15;
end;

{$IFDEF WIN32}

type
  TvtUpDown = class(TCustomUpDown)
  private
    FChanging: Boolean;
    procedure ScrollMessage(var Message: TWMVScroll);
    procedure WMHScroll(var Message: TWMHScroll); message CN_HSCROLL;
    procedure WMVScroll(var Message: TWMVScroll); message CN_VSCROLL;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property OnClick;
  end;

constructor TvtUpDown.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Orientation := udVertical;
  Min := -1;
  Max := 1;
  Position := 0;
end;

destructor TvtUpDown.Destroy;
begin
  OnClick := nil;
  inherited Destroy;
end;

procedure TvtUpDown.ScrollMessage(var Message: TWMVScroll);
begin
  if Message.ScrollCode = SB_THUMBPOSITION then begin
    if not FChanging then begin
      FChanging := True;
      try
        if Message.Pos > 0 then Click(btNext)
        else if Message.Pos < 0 then Click(btPrev);
        if HandleAllocated then
          SendMessage(Handle, UDM_SETPOS, 0, 0);
      finally
        FChanging := False;
      end;
    end;
  end;
end;

procedure TvtUpDown.WMHScroll(var Message: TWMHScroll);
begin
  ScrollMessage(TWMVScroll(Message));
end;

procedure TvtUpDown.WMVScroll(var Message: TWMVScroll);
begin
  ScrollMessage(Message);
end;

procedure TvtUpDown.WMSize(var Message: TWMSize);
begin
  inherited;
  if Width <> DefBtnWidth then Width := DefBtnWidth;
end;
{$ENDIF WIN32}

{ TvtSpinEdit }

constructor TvtSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //Text := '0';
  ControlStyle := ControlStyle - [csSetCaption];
  FIncrement := 1.0;
  FDecimal := 2;
  FEditorEnabled := True;
  //FButtonKind := bkDiagonal;
  FArrowKeys := True;
  FAllowAnyValueManualInput := False;
  RecreateButton;
  if (aOwner = nil) or not (csLoading in aOwner.ComponentState) then
  begin
   UseMaxValue := False;
   UseMinValue := False;
  end;
end;

destructor TvtSpinEdit.Destroy;
begin
  Destroying;
  FChanging := True;
  if FButton <> nil then begin
    FButton.Free;
    FButton := nil;
    FBtnWindow.Free;
    FBtnWindow := nil;
  end;
{$IFDEF WIN32}
  if FUpDown <> nil then begin
    FUpDown.Free;
    FUpDown := nil;
  end;
{$ENDIF}
  inherited Destroy;
end;

procedure TvtSpinEdit.RecreateButton;
begin
  if (csDestroying in ComponentState) then Exit;
  FButton.Free;
  FButton := nil;
  FBtnWindow.Free;
  FBtnWindow := nil;
{$IFDEF WIN32}
  FUpDown.Free;
  FUpDown := nil;
  if gSpinButtonKind = bkStandard then begin
    FUpDown := TvtUpDown.Create(Self);
    with TvtUpDown(FUpDown) do begin
      Visible := True;
      SetBounds(0, 0, Self.Height {DefBtnWidth}, Self.Height);
{$IFDEF Delphi4}
      if (BiDiMode = bdRightToLeft) then Align := alLeft else
{$ENDIF}
      Align := alRight;
      Parent := Self;
      OnClick := UpDownClick;
    end;
  end
  else begin
{$ENDIF}
    FBtnWindow := TWinControl.Create(Self);
    FBtnWindow.Visible := True;
    FBtnWindow.Parent := Self;
    FBtnWindow.SetBounds(0, 0, Height, Height);
    FButton := TvtSpinButton.Create(Self);
    FButton.Visible := True;
    FButton.Parent := FBtnWindow;
    FButton.FocusControl := Self;
    FButton.OnTopClick := UpClick;
    FButton.OnBottomClick := DownClick;
    FButton.SetBounds(0, 0, FBtnWindow.Width, FBtnWindow.Height);
{$IFDEF WIN32}
  end;
{$ENDIF}
end;

procedure TvtSpinEdit.SetArrowKeys(Value: Boolean);
begin
  FArrowKeys := Value;
{$IFDEF WIN32}
  ResizeButton;
{$ENDIF}
end;

{$IFDEF WIN32}
{
function TvtSpinEdit.GetButtonKind: TSpinButtonKind;
begin
  if NewStyleControls then Result := FButtonKind
  else Result := bkDiagonal;
end;

procedure TvtSpinEdit.SetButtonKind(Value: TSpinButtonKind);
var
  OldKind: TSpinButtonKind;
begin
  OldKind := FButtonKind;
  FButtonKind := Value;
  if OldKind <> GetButtonKind then begin
    RecreateButton;
    ResizeButton;
    SetEditRect;
  end;
end;
}
procedure TvtSpinEdit.UpDownClick(Sender: TObject; Button: TUDBtnType);
begin
  if TabStop and CanFocus then SetFocus;
  case Button of
    btNext: UpClick(Sender);
    btPrev: DownClick(Sender);
  end;
end;
{$ENDIF WIN32}

function TvtSpinEdit.GetButtonWidth: Integer;
begin
{$IFDEF WIN32}
  if FUpDown <> nil then Result := FUpDown.Width else
{$ENDIF}
  if FButton <> nil then Result := FButton.Width
  else Result := DefBtnWidth;
end;

procedure TvtSpinEdit.ResizeButton;
{$IFDEF WIN32}
var
  R: TRect;
{$ENDIF}
begin
{$IFDEF WIN32}
  if FUpDown <> nil then begin
    FUpDown.Width := DefBtnWidth;
 {$IFDEF Delphi4}
    if (BiDiMode = bdRightToLeft) then FUpDown.Align := alLeft else
 {$ENDIF}
    FUpDown.Align := alRight;
  end
  else if FButton <> nil then begin { bkDiagonal }
    if NewStyleControls and Ctl3D and (BorderStyle = bsSingle) then
      R := Bounds(Width - Height - 1, -1, Height - 3, Height - 3)
    else
      R := Bounds(Width - Height, 0, Height, Height);
 {$IFDEF Delphi4}
    if (BiDiMode = bdRightToLeft) then begin
      if NewStyleControls and Ctl3D and (BorderStyle = bsSingle) then begin
        R.Left := -1;
        R.Right := Height - 4;
      end
      else begin
        R.Left := 0;
        R.Right := Height;
      end;
    end;
 {$ENDIF}
    with R do
      FBtnWindow.SetBounds(Left, Top, Right - Left, Bottom - Top);
    FButton.SetBounds(0, 0, FBtnWindow.Width, FBtnWindow.Height);
  end;
{$ELSE}
  if FButton <> nil then begin
    FBtnWindow.SetBounds(Width - Height, 0, Height, Height);
    FButton.SetBounds(0, 0, FBtnWindow.Width, FBtnWindow.Height);
  end;
{$ENDIF}
end;

procedure TvtSpinEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if ArrowKeys and (Key in [VK_UP, VK_DOWN]) then begin
    if Key = VK_UP then UpClick(Self)
    else if Key = VK_DOWN then DownClick(Self);
    Key := 0;
  end;
end;

function TvtSpinEdit.CheckWheelAccept : boolean;
var
 lPos    : TPoint;
begin
 Result := false;
 // только если мышь в компоненте и он в фокусе
 if not Focused then Exit;
 GetCursorPos(lPos);
 if Handle <> WindowFromPoint(lPos) then exit;
 Result := True;
end;

function TvtSpinEdit.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := CheckWheelAccept;
  if Result then
   DownClick(Self);
end;

function TvtSpinEdit.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := CheckWheelAccept;
  if Result then
   UpClick(Self);
end;

procedure TvtSpinEdit.MouseWheelHandler(var Message: TMessage);
begin
 if not CheckWheelAccept then exit;

 if (Integer(Message.wParam) > 0) then
  UpClick(Self)
 else
  DownClick(Self);

 Message.Result := 1;
end;

procedure TvtSpinEdit.Change;
begin
 if not FChanging then 
  inherited Change;
end;

procedure TvtSpinEdit.KeyPress(var Key: Char);
begin
  if not IsValidChar(Key) then begin
    Key := #0;
    MessageBeep(0)
  end;
  if Key <> #0 then begin
    inherited KeyPress(Key);
    if (Key = Char(VK_RETURN)) or (Key = Char(VK_ESCAPE)) then begin
      { must catch and remove this, since is actually multi-line }
      GetParentForm(Self).Perform(CM_DIALOGKEY, Byte(Key), 0);
      if Key = Char(VK_RETURN) then Key := #0;
    end;
  end;
end;

function TvtSpinEdit.IsValidChar(Key: Char): Boolean;
var
  ValidChars : set of Char;
  lStartPos,
  lEndPos    : DWORD;
begin
  SendMessage(Handle, EM_GETSEL, Integer(@lStartPos), Integer(@lEndPos));
  ValidChars := ['0'..'9'];
  If (lStartPos = 0) and ((Length(Text) = 0) or
                           not (Text[1] in ['+', '-']) or (lEndPos > 0)) then
  ValidChars := ValidChars + ['+', '-'];
  if ValueType = vtFloat then
  begin
   ValidChars := ValidChars + ['+', '-'];  // знак может стоять еще перед Е,
                                           //хорошо бы убедиться что предыдущая именно она
   if Pos({$IfDef XE}FormatSettings.{$EndIf}DecimalSeparator, Text) = 0 then
    ValidChars := ValidChars + [{$IfDef XE}FormatSettings.{$EndIf}DecimalSeparator];
   if Pos('E', AnsiUpperCase(Text)) = 0 then
    ValidChars := ValidChars + ['e', 'E'];
  end
  else
   begin
    If (lStartPos = 0) and ((Length(Text) = 0) or
                            (Text[1] <>'$') or (lEndPos > 0)) then
     ValidChars := ValidChars + ['$'];
    If (Length(Text) > 0) and (Text[1] ='$') then
     ValidChars := ValidChars + ['A','a','B','b','C','c','D','d','E','e','F','f'];
   end;
  Result := (Key in ValidChars) or (Key < #32);
  if not FEditorEnabled and Result and ((Key >= #32) or
    (Key = Char(VK_BACK)) or (Key = Char(VK_DELETE))) then Result := False;
end;

procedure TvtSpinEdit.CreateParams(var Params: TCreateParams);
const
{$IFDEF Delphi4}
 Alignments: array[Boolean, TAlignment] of DWORD =
   ((ES_LEFT, ES_RIGHT, ES_CENTER), (ES_RIGHT, ES_LEFT, ES_CENTER));
{$ELSE}
 Alignments: array[TAlignment] of Longint = (ES_LEFT, ES_RIGHT, ES_CENTER);
{$ENDIF}
begin
 inherited CreateParams(Params);
 Params.Style := Params.Style or WS_CLIPCHILDREN or
{$IFDEF Delphi4}
   Alignments[UseRightToLeftAlignment, FAlignment];
{$ELSE}
   Alignments[FAlignment];
{$ENDIF}
end;

procedure TvtSpinEdit.CreateWnd;
begin
  inherited CreateWnd;
  SetEditRect;
end;

procedure TvtSpinEdit.SetEditRect;
var
  Loc: TRect;
begin
{$IFDEF Delphi4}
  if (BiDiMode = bdRightToLeft) then
    SetRect(Loc, GetButtonWidth + 1, 0, ClientWidth - 1,
      ClientHeight + 1) else
{$ENDIF Delphi4}
  SetRect(Loc, 0, 0, ClientWidth - GetButtonWidth - 2, ClientHeight + 1);
  SendMessage(Handle, EM_SETRECTNP, 0, Longint(@Loc));
end;

procedure TvtSpinEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TvtSpinEdit.WMSize(var Message: TWMSize);
var
  MinHeight: Integer;
begin
  inherited;
  MinHeight := GetMinHeight;
  { text edit bug: if size to less than minheight, then edit ctrl does
    not display the text }
  if Height < MinHeight then
    Height := MinHeight
  else begin
    ResizeButton;
    SetEditRect;
  end;
end;

procedure TvtSpinEdit.GetTextHeight(var SysHeight, Height: Integer);
var
  DC: HDC;
  SaveFont: HFont;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  SysHeight := SysMetrics.tmHeight;
  Height := Metrics.tmHeight;
end;

function TvtSpinEdit.GetMinHeight: Integer;
var
  I, H: Integer;
begin
  GetTextHeight(I, H);
  if I > H then I := H;
  Result := H + {$IFNDEF WIN32} (I div 4) + {$ENDIF}
    (GetSystemMetrics(SM_CYBORDER) * 4) + 1;
end;

procedure TvtSpinEdit.UpClick(Sender: TObject);
var
  OldText: string;
begin
  if ReadOnly then MessageBeep(0)
  else begin
    FChanging := True;
    try
      OldText := inherited Text;
      Value := Value + FIncrement;
    finally
      FChanging := False;
    end;
    if CompareText(inherited Text, OldText) <> 0 then begin
      Modified := True;
      Change;
    end;
    if Assigned(FOnTopClick) then FOnTopClick(Self);
  end;
end;

procedure TvtSpinEdit.DownClick(Sender: TObject);
var
  OldText: string;
begin
  if ReadOnly then MessageBeep(0)
  else begin
    FChanging := True;
    try
      OldText := inherited Text;
      Value := Value - FIncrement;
    finally
      FChanging := False;
    end;
    if CompareText(inherited Text, OldText) <> 0 then begin
      Modified := True;
      Change;
    end;
    if Assigned(FOnBottomClick) then FOnBottomClick(Self);
  end;
end;

{$IFDEF Delphi4}
procedure TvtSpinEdit.CMBiDiModeChanged(var Message: TMessage);
begin
  inherited;
  ResizeButton;
  SetEditRect;
end;
{$ENDIF}

procedure TvtSpinEdit.WMKeyDown(var Msg : TWMKeyDown);
begin
 if IsHandledShortcut(Msg) then
  Exit;
 if (Text <> '-') and (Value = EmptyValue) then
  Text := '';
 inherited;
end;

procedure TvtSpinEdit.WMSysKeyDown(var Msg : TWMSysKeyDown);
begin
 if IsHandledShortcut(Msg) then
  Exit;
 inherited;
end;

function TvtSpinEdit.IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
{$IfDef evNeedOvc}
var
 l_Controller : TOvcController;
{$EndIf evNeedOvc}
begin
 Result := false;
 {$IfDef evNeedOvc}
 l_Controller := GetDefController;
 if Assigned(l_Controller) then
  with l_Controller.EntryCommands do
   if TranslateUsing([], TMessage(Msg), GetTickCount) = ccShortCut then
   begin
    Msg.Result := 0;  {indicate that this message was processed}
    Result := true;
   end;
 {$EndIf evNeedOvc}
end;

procedure TvtSpinEdit.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResizeButton;
  SetEditRect;
end;

procedure TvtSpinEdit.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  ResizeButton;
  SetEditRect;
end;

procedure TvtSpinEdit.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
{$IFDEF WIN32}
  if FUpDown <> nil then begin
    FUpDown.Enabled := Enabled;
    ResizeButton;
  end;
{$ENDIF}
  if FButton <> nil then FButton.Enabled := Enabled;
end;

procedure TvtSpinEdit.WMPaste(var Message: TWMPaste);
var
 lText : string;
 I, lCnt : Integer;
 lLen    : Integer;
begin
  if not FEditorEnabled or ReadOnly then Exit;
  SelectAll;
  inherited;
  lText := Text;
  I := 1;
  lLen := Length(lText);
  While (I <= lLen) and not (lText[I] in cc_Digits) do Inc(I);
  lCnt := 0;
  While (I + lCnt <= lLen) and (lText[I + lCnt] in cc_Digits) do Inc(lCnt);
  Text := System.Copy(lText, I, lCnt);
end;

procedure TvtSpinEdit.WMCut(var Message: TWMCut);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

procedure TvtSpinEdit.CMExit(var Message: TCMExit);
begin
 inherited;
 if not FAllowAnyValueManualInput then
  SetValue(CheckValue(Value));
end;

procedure TvtSpinEdit.CMEnter(var Message: TMessage);
begin
  if AutoSelect and not (csLButtonDown in ControlState) then SelectAll;
  inherited;
end;

function TvtSpinEdit.GetValue: Extended;
begin
 if Text = EmptyText
  then Result := fEmptyValue
  else
 if not FAllowAnyValueManualInput
  then Result := CheckValue(StrToFloatDef(Text, fEmptyValue))
  else Result := StrToFloatDef(Text, fEmptyValue);

 if ValueType = vtInteger then
 begin
  if Result > MaxInt then
   Result := MaxInt
  else
  if Result < -MaxInt then
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=587164757
   Result := -MaxInt
  else
   Result := Trunc(Result);
 end;
end;

function  TvtSpinEdit.IsEmpty : Boolean;
begin
 if ValueType = vtFloat then
  Result := (Value = fEmptyValue)
 else
  Result := (Value = Trunc(fEmptyValue));
end;

procedure TvtSpinEdit.SetValue(NewValue: Extended);
begin
  NewValue := CheckValue(NewValue);
  If (NewValue = fEmptyValue) {and
     ((fEmptyValue < fMinValue) or
      (fEmptyValue > fMaxValue) or
      (fMaxValue <= fMinValue))} then
   Text := EmptyText
  else
   if ValueType = vtFloat then
    Text := FloatToStrF(NewValue, ffFixed, 15, FDecimal)
   else
    Text := IntToStr(Round(NewValue));
  SelStart := Length(Text);
end;

procedure TvtSpinEdit.SetMaxValue(aValue: Extended);
 begin
  If fMaxValue <> aValue then
   fMaxValue := aValue;

  (*If fMaxValue = aValue then Exit;
  if (aValue >= FMinValue) then
   fMaxValue := aValue
  else
  begin
   fMaxValue:= fMinValue;
   fMinValue:= aValue;
  end;
  *)
  SetValue(Value);
 end;

procedure TvtSpinEdit.SetMinValue(aValue: Extended);
 begin
  If fMinValue <> aValue then
   fMinValue := aValue;

  (*If fMaxValue = aValue then Exit;
  if (aValue <= FMaxValue) then
   fMinValue := aValue
  else
  begin
   fMinValue:= fMaxValue;
   fMaxValue:= aValue;
  end;
  *)
  SetValue(Value);
 end;

procedure TvtSpinEdit.SetEmptyValue(aValue: Extended);
begin
 If fMaxValue = aValue then Exit;
 fEmptyValue := aValue;
 SetValue(Value);
end;

procedure TvtSpinEdit.SetEmptyText(const aValue: String);
begin
 fEmptyText := aValue;
 SetValue(Value);
end;

function TvtSpinEdit.GetAsInteger: Longint;
begin
 Result := Trunc(GetValue);
end;

procedure TvtSpinEdit.SetAsInteger(NewValue: Longint);
begin
 SetValue(NewValue);
end;

procedure TvtSpinEdit.SetValueType(NewType: TValueType);
begin
 if fValueType <> NewType then
 begin
  fValueType := NewType;
  Value := GetValue;
  if FValueType = {$IFDEF CBUILDER} vtInt {$ELSE} vtInteger {$ENDIF} then
  begin
   FIncrement := Round(FIncrement);
   if FIncrement = 0 then FIncrement := 1;
  end;
 end;
end;

function TvtSpinEdit.IsIncrementStored: Boolean;
begin
 Result := FIncrement <> 1.0;
end;

procedure TvtSpinEdit.SetUseMaxValue(aValue: Boolean);
begin
 if not aValue then
  case ValueType of
   vtInteger : fMaxValue := High(Longint);
   vtFloat   : fMaxValue := MaxExtended;
  end;
end;

function TvtSpinEdit.GetUseMaxValue: Boolean;
begin
 case ValueType of
  vtInteger : Result := (Trunc(FMaxValue) <> High(Longint));
  vtFloat   : Result := (FMaxValue <> MaxExtended);
  else
   Result := False;
 end;
end;

procedure TvtSpinEdit.SetUseMinValue(aValue: Boolean);
begin
 if not aValue then
  case ValueType of
   vtInteger : fMinValue := Low(Longint);
   vtFloat   : fMinValue := MinExtended;
  end;
end;

function TvtSpinEdit.GetUseMinValue: Boolean;
begin
 case ValueType of
  vtInteger : Result := (Trunc(fMinValue) <> Low(Longint));
  vtFloat   : Result := (fMinValue <> MinExtended);
  else
   Result := False;
 end;
end;

(*
function TvtSpinEdit.IsMaxStored: Boolean;
begin
 Result := UseMaxValue;
end;

function TvtSpinEdit.IsMinStored: Boolean;
begin
 Result := UseMinValue;
end;
*)

function TvtSpinEdit.IsEmptyStored: Boolean;
begin
 Result := (EmptyValue <> 0.0);
end;

function TvtSpinEdit.IsEmptyTextStored: Boolean;
begin
 Result := (EmptyText <> '');
end;

function TvtSpinEdit.IsValueStored: Boolean;
begin
 Result := (Value <> 0.0);
end;

procedure TvtSpinEdit.SetDecimal(NewValue: Byte);
begin
 if fDecimal <> NewValue then
 begin
  fDecimal := NewValue;
  Value := GetValue;
 end;
end;

function TvtSpinEdit.CheckValue(NewValue: Extended): Extended;
var
 l_Min, l_Max: Extended;
begin
 if UseMinValue
  then l_Min := MinValue
  else
 if ValueType = vtInteger
  then l_Min := Low(Int64)
  else l_Min := NegInfinity;

 if UseMaxValue
  then l_Max := MaxValue
  else
 if ValueType = vtInteger
  then l_Max := High(Int64)
  else l_Max := Infinity;
                
 if NewValue < l_Min then
  Result := l_Min
 else
 if NewValue > l_Max then
  Result := l_Max
 else
  Result := NewValue;
end;

end.
