{*******************************************************}
{                                                       }
{         Delphi VCL Extensions (RX)                    }
{                                                       }
{         Copyright (c) 1995, 1996 AO ROSNO             }
{         Copyright (c) 1997, 1998 Master-Bank          }
{                                                       }
{*******************************************************}

unit PickDate1;

{$I RX.INC}
{$S-}

interface

uses {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF} Classes,
  Controls, SysUtils, Graphics, DateUtil;

{ Calendar dialog }

function SelectDate(var Date: TDateTime; const DlgCaption: TCaption;
  AStartOfWeek: TDayOfWeekName; AWeekends: TDaysOfWeek;
  AWeekendColor: TColor; BtnHints: TStrings): Boolean;
function SelectDateStr(var StrDate: string; const DlgCaption: TCaption;
  AStartOfWeek: TDayOfWeekName; AWeekends: TDaysOfWeek;
  AWeekendColor: TColor; BtnHints: TStrings): Boolean;
function PopupDate(var Date: TDateTime; Edit: TWinControl): Boolean;

{ Popup calendar }

function CreatePopupCalendar(AOwner: TComponent
  {$IFDEF RX_D4}; ABiDiMode: TBiDiMode = bdLeftToRight {$ENDIF}): TWinControl;
procedure SetupPopupCalendar(PopupCalendar: TWinControl;
  AStartOfWeek: TDayOfWeekName; AWeekends: TDaysOfWeek;
  AWeekendColor: TColor; BtnHints: TStrings; FourDigitYear: Boolean);

const
  PopupCalendarSize: TPoint = (X: 187; Y: 124);

implementation

uses Messages, Consts, Forms, Buttons, StdCtrls, Grids, ExtCtrls, RXCtrls,
  RXCConst, ToolEdit, VCLUtils, MaxMin, StrUtils, CalPanel, VDate;

{$IFDEF WIN32}
 {$R *.R32}
{$ELSE}
 {$R *.R16}
{$ENDIF}

const
  SBtnGlyphs: array[0..3] of PChar = ('PREV2', 'PREV1', 'NEXT1', 'NEXT2');

procedure FontSetDefault(AFont: TFont);
{$IFDEF WIN32}
var
  NonClientMetrics: TNonClientMetrics;
{$ENDIF}
begin
{$IFDEF WIN32}
  NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    AFont.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont)
  else
{$ENDIF}
  with AFont do begin
    Color := clWindowText;
    Name := 'MS Sans Serif';
    Size := 8;
    Style := [];
  end;
end;

{ TRxTimerSpeedButton }

type
  TRxTimerSpeedButton = class(TRxSpeedButton)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AllowTimer default True;
    property Style default bsWin31;
  end;

constructor TRxTimerSpeedButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := bsWin31;
  AllowTimer := True;
{$IFDEF WIN32}
  ControlStyle := ControlStyle + [csReplicatable];
{$ENDIF}
end;

{ TLocCalendar }

type
  TLocCalendar = class(TCalendarPanel)
  private
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

constructor TLocCalendar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks];
{$IFDEF WIN32}
  ControlStyle := ControlStyle + [csReplicatable];
{$ENDIF}
  Ctl3D := False;
  Enabled := False;
  BorderStyle := bsNone;
  ParentColor := True;
  {CalendarDate := Trunc(Now);}
  {UseCurrentDate := False;
  FixedColor := Self.Color;
  Options := [goFixedHorzLine];}
  TabStop := False;
end;

procedure TLocCalendar.CMParentColorChanged(var Message: TMessage);
begin
  inherited;
  {if ParentColor then FixedColor := Self.Color;}
end;

procedure TLocCalendar.CMEnabledChanged(var Message: TMessage);
begin
  if HandleAllocated and not (csDesigning in ComponentState) then
    EnableWindow(Handle, True);
end;

procedure TLocCalendar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    Style := Style and not (WS_BORDER or WS_TABSTOP or WS_DISABLED);
end;

{ TPopupCalendar }

type
  TPopupCalendar = class(TPopupWindow)
  private
    FCalendar: TCalendarPanel;
    FTitlePanel : TPanel;
    {FTitleLabel: TLabel;}
    FFourDigitYear: Boolean;
    FBtns: array[0..3] of TRxSpeedButton;
    procedure CalendarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PrevMonthBtnClick(Sender: TObject);
    procedure NextMonthBtnClick(Sender: TObject);
    procedure PrevYearBtnClick(Sender: TObject);
    procedure NextYearBtnClick(Sender: TObject);
    procedure CalendarChange(Sender: TObject);
    procedure TopPanelDblClick(Sender: TObject);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
{$IFDEF WIN32}
    function GetValue: Variant; override;
    procedure SetValue(const Value: Variant); override;
{$ELSE}
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
  end;

function CreatePopupCalendar(AOwner: TComponent
  {$IFDEF RX_D4}; ABiDiMode: TBiDiMode = bdLeftToRight {$ENDIF}): TWinControl;
begin
  Result := TPopupCalendar.Create(AOwner);
  if (AOwner <> nil) and not (csDesigning in AOwner.ComponentState) and
    (Screen.PixelsPerInch <> 96) then
  begin { scale to screen res }
    Result.ScaleBy(Screen.PixelsPerInch, 96);
    { The ScaleBy method does not scale the font well, so set the
      font back to the original info. }
    TPopupCalendar(Result).FCalendar.ParentFont := True;
    FontSetDefault(TPopupCalendar(Result).Font);
{$IFDEF RX_D4}
    Result.BiDiMode := ABiDiMode;
{$ENDIF}
  end;
end;

procedure SetupPopupCalendar{(PopupCalendar: TWinControl;
  AStartOfWeek: TDayOfWeekName; AWeekends: TDaysOfWeek;
  AWeekendColor: TColor; BtnHints: TStrings; FourDigitYear: Boolean)};
var
  I: Integer;
begin
  if (PopupCalendar = nil) or not (PopupCalendar is TPopupCalendar) then
    Exit;
  TPopupCalendar(PopupCalendar).FFourDigitYear := FourDigitYear;
  if TPopupCalendar(PopupCalendar).FCalendar <> nil then begin
    with TPopupCalendar(PopupCalendar).FCalendar do begin
      StartOfWeek := TStDayType(AStartOfWeek);
      WeekendColor := AWeekendColor;
      Weekends := TDaysOfWeek(AWeekends);
    end;
    if (BtnHints <> nil) then
      for I := 0 to Min(BtnHints.Count - 1, 3) do begin
        if BtnHints[I] <> '' then
          TPopupCalendar(PopupCalendar).FBtns[I].Hint := BtnHints[I];
      end;
  end;
end;

constructor TPopupCalendar.Create(AOwner: TComponent);   {V}
const
  BtnSide = 21;
var
  Control, BackPanel: TWinControl;
begin
  inherited Create(AOwner);
  FFourDigitYear := FourDigitYear;
  Height := 140;
  Width := 191;
  {Height := Max(PopupCalendarSize.Y, 120);
  Width := Max(PopupCalendarSize.X, 180);}
  Color := clBtnFace;
  FontSetDefault(Font);
  if AOwner is TControl then ShowHint := TControl(AOwner).ShowHint
  else ShowHint := True;
  if (csDesigning in ComponentState) then Exit;

  BackPanel := TPanel.Create(Self);
  with BackPanel as TPanel do begin
    Parent := Self;
    Align := alClient;
    ParentColor := True;
{$IFDEF WIN32}
    ControlStyle := ControlStyle + [csReplicatable];
{$ENDIF}
  end;

  FTitlePanel := TPanel.Create(Self);
  with FTitlePanel do begin
    Parent := BackPanel;
    Align := alTop;
    Width := Self.Width - 4;
    Height := 23;
    BevelOuter := bvNone;
    ParentColor := True;
{$IFDEF WIN32}
    ControlStyle := ControlStyle + [csReplicatable];
{$ENDIF}
  end;

(*  Control := TPanel.Create(Self);
  with Control as TPanel do begin
    Parent := BackPanel;
    Align := alTop;
    Width := Self.Width - 4;
    Height := 18;
    BevelOuter := bvNone;
    ParentColor := True;
{$IFDEF WIN32}
    ControlStyle := ControlStyle + [csReplicatable];
{$ENDIF}
  end;
 *)

  FCalendar := TLocCalendar.Create(Self);
  with TLocCalendar(FCalendar) do begin
    Parent := BackPanel;
    Align := alClient;
    BevelInner := bvNone;
    BevelOuter := bvLowered;
    OnChange := CalendarChange;
    OnMouseUp := CalendarMouseUp;
  end;

  FBtns[0] := TRxTimerSpeedButton.Create(Self);
  with FBtns[0] do begin
    Parent := FTitlePanel;
    SetBounds(1, 1, BtnSide, BtnSide);
    Glyph.Handle := LoadBitmap(hInstance, SBtnGlyphs[0]);
    OnClick := PrevYearBtnClick;
    Hint := LoadStr(SPrevYear);
    Flat:=True;
  end;

  FBtns[1] := TRxTimerSpeedButton.Create(Self);
  with FBtns[1] do begin
    Parent := FTitlePanel;
    SetBounds(BtnSide +1, 1, BtnSide, BtnSide);
    Glyph.Handle := LoadBitmap(hInstance, SBtnGlyphs[1]);
    OnClick := PrevMonthBtnClick;
    Hint := LoadStr(SPrevMonth);
    Flat:=True;
  end;

 (* FTitleLabel := TLabel.Create(Self);
  with FTitleLabel do begin
    Parent := Control;
    AutoSize := False;
    Alignment := taCenter;
    SetBounds(BtnSide * 2 + 1, 1, Control.Width - 4 * BtnSide - 2, 14);
    Transparent := True;
    OnDblClick := TopPanelDblClick;
{$IFDEF WIN32}
    ControlStyle := ControlStyle + [csReplicatable];
{$ENDIF}
  end;
*)

  FBtns[2] := TRxTimerSpeedButton.Create(Self);
  with FBtns[2] do begin
    Parent := FTitlePanel;
    SetBounds(FTitlePanel.Width - 2 * BtnSide - 1 , 1, BtnSide, BtnSide);
    Glyph.Handle := LoadBitmap(hInstance, SBtnGlyphs[2]);
    OnClick := NextMonthBtnClick;
    Hint := LoadStr(SNextMonth);
    Flat:=True;
  end;

  FBtns[3] := TRxTimerSpeedButton.Create(Self);
  with FBtns[3] do begin
    Parent := FTitlePanel;
    SetBounds(FTitlePanel.Width - BtnSide - 1, 1, BtnSide, BtnSide);
    Glyph.Handle := LoadBitmap(hInstance, SBtnGlyphs[3]);
    OnClick := NextYearBtnClick;
    Hint := LoadStr(SNextYear);
    Flat:=True;
  end;
end;

procedure TPopupCalendar.CalendarMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and (Shift = []) then
   begin
    If TLocCalendar(FCalendar).GetDayFromPoint(Point(X,Y)) > 0
     then CloseUp(True);
   end;
end;

procedure TPopupCalendar.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if FCalendar <> nil then TLocCalendar(FCalendar).KeyDown(Key, Shift);
end;

procedure TPopupCalendar.PrevYearBtnClick(Sender: TObject);
begin
  FCalendar.PrevYear;
end;

procedure TPopupCalendar.NextYearBtnClick(Sender: TObject);
begin
  FCalendar.NextYear;
end;

procedure TPopupCalendar.PrevMonthBtnClick(Sender: TObject);
begin
  FCalendar.PrevMonth;
end;

procedure TPopupCalendar.NextMonthBtnClick(Sender: TObject);
begin
  FCalendar.NextMonth;
end;

procedure TPopupCalendar.CalendarChange(Sender: TObject);
begin
  FTitlePanel.Caption := FormatDateTime('MMMM, YYYY', FCalendar.Date);
end;

(*
procedure TPopupCalendar.CalendarMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Col, Row: Longint;
begin
  if (Button = mbLeft) and (Shift = []) then begin
    TLocCalendar(FCalendar).MouseToCell(X, Y, Col, Row);
    if (Row > 0) and (FCalendar.CellText[Col, Row] <> '') then
      CloseUp(True);
  end;
end;

procedure TPopupCalendar.TopPanelDblClick(Sender: TObject);
begin
  FCalendar.CalendarDate := Trunc(Now);
end;

procedure TPopupCalendar.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if FCalendar <> nil then TLocCalendar(FCalendar).KeyDown(Key, Shift); {V}
  {if FCalendar <> nil then
    case Key of
      VK_NEXT:
        begin
          if ssCtrl in Shift then FCalendar.NextYear
          else FCalendar.NextMonth;
        end;
      VK_PRIOR:
        begin
          if ssCtrl in Shift then FCalendar.PrevYear
          else FCalendar.PrevMonth;
        end;
      else TLocCalendar(FCalendar).KeyDown(Key, Shift);
    end;
   }
end;

procedure TPopupCalendar.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (FCalendar <> nil) and (Key <> #0) then
    FCalendar.KeyPress(Key);
end;
*)
{$IFDEF WIN32}

function TPopupCalendar.GetValue: Variant;
begin
  if (csDesigning in ComponentState) then
    Result := VarFromDateTime(SysUtils.Date)
  else
    Result := VarFromDateTime(FCalendar.Date);
end;

procedure TPopupCalendar.SetValue(const Value: Variant);
begin
  if not (csDesigning in ComponentState) then begin
    try
      if (Trim(ReplaceStr(VarToStr(Value), DateSeparator, '')) = '') or
        VarIsNull(Value) or VarIsEmpty(Value) then
        FCalendar.Date := VarToDateTime(SysUtils.Date)
      else FCalendar.Date := VarToDateTime(Value);
      CalendarChange(nil);
    except
      FCalendar.Date := VarToDateTime(SysUtils.Date);
    end;
  end;
end;

{$ELSE}

function TPopupCalendar.GetValue: string;
begin
  if (csDesigning in ComponentState) then
    Result := FormatDateTime(DefDateFormat(FFourDigitYear), SysUtils.Date)
  else
    Result := FormatDateTime(DefDateFormat(FFourDigitYear), FCalendar.CalendarDate);
end;

procedure TPopupCalendar.SetValue(const Value: string);
begin
  if not (csDesigning in ComponentState) then begin
    FCalendar.CalendarDate := StrToDateFmtDef(DefDateFormat(FFourDigitYear),
      Value, SysUtils.Date);
    CalendarChange(nil);
  end;
end;

{$ENDIF}

procedure TPopupCalendar.PrevYearBtnClick(Sender: TObject);
begin
  FCalendar.PrevYear;
end;

procedure TPopupCalendar.NextYearBtnClick(Sender: TObject);
begin
  FCalendar.NextYear;
end;

procedure TPopupCalendar.PrevMonthBtnClick(Sender: TObject);
begin
  FCalendar.PrevMonth;
end;

procedure TPopupCalendar.NextMonthBtnClick(Sender: TObject);
begin
  FCalendar.NextMonth;
end;

procedure TPopupCalendar.CalendarChange(Sender: TObject);
begin
  FTitleLabel.Caption := FormatDateTime('MMMM, YYYY', FCalendar.CalendarDate);
end;

{ TSelectDateDlg }

type
  TSelectDateDlg = class(TForm)
    Calendar: TRxCalendar;
    TitleLabel: TLabel;
    procedure PrevMonthBtnClick(Sender: TObject);
    procedure NextMonthBtnClick(Sender: TObject);
    procedure PrevYearBtnClick(Sender: TObject);
    procedure NextYearBtnClick(Sender: TObject);
    procedure CalendarChange(Sender: TObject);
    procedure CalendarDblClick(Sender: TObject);
    procedure TopPanelDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FBtns: array[0..3] of TRxSpeedButton;
    procedure SetDate(Date: TDateTime);
    function GetDate: TDateTime;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property Date: TDateTime read GetDate write SetDate;
  end;

constructor TSelectDateDlg.Create(AOwner: TComponent);
var
  Control: TWinControl;
begin
{$IFDEF CBUILDER}
  inherited CreateNew(AOwner, 0);
{$ELSE}
  inherited CreateNew(AOwner);
{$ENDIF}
  Caption := LoadStr(SDateDlgTitle);
{$IFDEF WIN32}
  BorderStyle := bsToolWindow;
{$ELSE}
  BorderStyle := bsDialog;
{$ENDIF}
  BorderIcons := [biSystemMenu];
  ClientHeight := 154;
  ClientWidth := 222;
  FontSetDefault(Font);
  Color := clBtnFace;
  Position := poScreenCenter;
  ShowHint := True;
  KeyPreview := True;

  Control := TPanel.Create(Self);
  with Control as TPanel do begin
    Parent := Self;
    SetBounds(0, 0, 222, 22);
    Align := alTop;
    BevelInner := bvLowered;
    ParentColor := True;
    ParentFont := True;
  end;

  TitleLabel := TLabel.Create(Self);
  with TitleLabel do begin
    Parent := Control;
    SetBounds(35, 4, 152, 14);
    Alignment := taCenter;
    AutoSize := False;
    Caption := '';
    ParentFont := True;
    Font.Color := clBlue;
    Font.Style := [fsBold];
    Transparent := True;
    OnDblClick := TopPanelDblClick;
  end;

  FBtns[0] := TRxTimerSpeedButton.Create(Self);
  with FBtns[0] do begin
    Parent := Control;
    SetBounds(3, 3, 16, 16);
    Glyph.Handle := LoadBitmap(hInstance, SBtnGlyphs[0]);
    OnClick := PrevYearBtnClick;
    Hint := LoadStr(SPrevYear);
  end;

  FBtns[1] := TRxTimerSpeedButton.Create(Self);
  with FBtns[1] do begin
    Parent := Control;
    SetBounds(18, 3, 16, 16);
    Glyph.Handle := LoadBitmap(hInstance, SBtnGlyphs[1]);
    OnClick := PrevMonthBtnClick;
    Hint := LoadStr(SPrevMonth);
  end;

  FBtns[2] := TRxTimerSpeedButton.Create(Self);
  with FBtns[2] do begin
    Parent := Control;
    SetBounds(188, 3, 16, 16);
    Glyph.Handle := LoadBitmap(hInstance, SBtnGlyphs[2]);
    OnClick := NextMonthBtnClick;
    Hint := LoadStr(SNextMonth);
  end;

  FBtns[3] := TRxTimerSpeedButton.Create(Self);
  with FBtns[3] do begin
    Parent := Control;
    SetBounds(203, 3, 16, 16);
    Glyph.Handle := LoadBitmap(hInstance, SBtnGlyphs[3]);
    OnClick := NextYearBtnClick;
    Hint := LoadStr(SNextYear);
  end;

  Control := TPanel.Create(Self);
  with Control as TPanel do begin
    Parent := Self;
    SetBounds(0, 133, 222, 21);
    Align := alBottom;
    BevelInner := bvNone;
    BevelOuter := bvNone;
    ParentFont := True;
    ParentColor := True;
  end;

  with TButton.Create(Self) do begin
    Parent := Control;
    SetBounds(0, 0, 112, 21);
    Caption := ResStr(SOKButton);
    ModalResult := mrOk;
  end;

  with TButton.Create(Self) do begin
    Parent := Control;
    SetBounds(111, 0, 111, 21);
    Caption := ResStr(SCancelButton);
    ModalResult := mrCancel;
    Cancel := True;
  end;

  Control := TPanel.Create(Self);
  with Control as TPanel do begin
    Parent := Self;
    SetBounds(0, 22, 222, 111);
    Align := alClient;
    BevelInner := bvLowered;
    ParentFont := True;
    ParentColor := True;
  end;

  Calendar := TRxCalendar.Create(Self);
  with Calendar do begin
    Parent := Control;
    Align := alClient;
    ParentFont := True;
    SetBounds(2, 2, 218, 113);
    Color := clWhite;
    TabOrder := 0;
    UseCurrentDate := False;
    OnChange := CalendarChange;
    OnDblClick := CalendarDblClick;
  end;

  OnKeyDown := FormKeyDown;
  Calendar.CalendarDate := Trunc(Now);
  ActiveControl := Calendar;
end;

procedure TSelectDateDlg.SetDate(Date: TDateTime);
begin
  if Date = NullDate then Date := SysUtils.Date;
  try
    Calendar.CalendarDate := Date;
    CalendarChange(nil);
  except
    Calendar.CalendarDate := SysUtils.Date;
  end;
end;

function TSelectDateDlg.GetDate: TDateTime;
begin
  Result := Calendar.CalendarDate;
end;

procedure TSelectDateDlg.TopPanelDblClick(Sender: TObject);
begin
  SetDate(Trunc(Now));
end;

procedure TSelectDateDlg.PrevYearBtnClick(Sender: TObject);
begin
  Calendar.PrevYear;
end;

procedure TSelectDateDlg.NextYearBtnClick(Sender: TObject);
begin
  Calendar.NextYear;
end;

procedure TSelectDateDlg.PrevMonthBtnClick(Sender: TObject);
begin
  Calendar.PrevMonth;
end;

procedure TSelectDateDlg.NextMonthBtnClick(Sender: TObject);
begin
  Calendar.NextMonth;
end;

procedure TSelectDateDlg.CalendarChange(Sender: TObject);
begin
  TitleLabel.Caption := FormatDateTime('MMMM, YYYY', Calendar.CalendarDate);
end;

procedure TSelectDateDlg.CalendarDblClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TSelectDateDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: ModalResult := mrOK;
    VK_ESCAPE: ModalResult := mrCancel;
    VK_NEXT:
      begin
        if ssCtrl in Shift then Calendar.NextYear
        else Calendar.NextMonth;
        TitleLabel.Update;
      end;
    VK_PRIOR:
      begin
        if ssCtrl in Shift then Calendar.PrevYear
        else Calendar.PrevMonth;
        TitleLabel.Update;
      end;
    VK_TAB:
      begin
        if Shift = [ssShift] then Calendar.PrevMonth
        else Calendar.NextMonth;
        TitleLabel.Update;
      end;
  end; {case}
end;

{ SelectDate routines }

function CreateDateDialog(const DlgCaption: TCaption): TSelectDateDlg;
begin
  Result := TSelectDateDlg.Create(Application);
  try
    if DlgCaption <> '' then Result.Caption := DlgCaption;
    if Screen.PixelsPerInch <> 96 then begin { scale to screen res }
      Result.ScaleBy(Screen.PixelsPerInch, 96);
      { The ScaleBy method does not scale the font well, so set the
        font back to the original info. }
      Result.Calendar.ParentFont := True;
      FontSetDefault(Result.Font);
      Result.Left := (Screen.Width div 2) - (Result.Width div 2);
      Result.Top := (Screen.Height div 2) - (Result.Height div 2);
    end;
  except
    Result.Free;
    raise;
  end;
end;

function PopupDate(var Date: TDateTime; Edit: TWinControl): Boolean;
var
  D: TSelectDateDlg;
  P: TPoint;
  W, H, X, Y: Integer;
begin
  Result := False;
  D := CreateDateDialog('');
  try
    D.BorderStyle := bsSingle;
    D.BorderIcons := [];
    D.HandleNeeded;
    D.Position := poDesigned;
    W := D.Width;
    H := D.Height;
    P := (Edit.ClientOrigin);
    Y := P.Y + Edit.Height - 1;
    if (Y + H) > Screen.Height then Y := P.Y - H + 1;
    if Y < 0 then Y := P.Y + Edit.Height - 1;
    X := (P.X + Edit.Width) - W;
    if X < 0 then X := P.X;
    D.Left := X;
    D.Top := Y;
    D.Date := Date;
    if D.ShowModal = mrOk then begin
      Date := D.Date;
      Result := True;
    end;
  finally
    D.Free;
  end;
end;

function SelectDate{(var Date: TDateTime; const DlgCaption: TCaption;
  AStartOfWeek: TDayOfWeekName; AWeekends: TDaysOfWeek;
  AWeekendColor: TColor; BtnHints: TStrings): Boolean};
var
  D: TSelectDateDlg;
  I: Integer;
begin
  Result := False;
  D := CreateDateDialog(DlgCaption);
  try
    D.Date := Date;
    with D.Calendar do begin
      StartOfWeek := TStDayType(AStartOfWeek);
      Weekends := TDaysOfWeek(AWeekends);
      WeekendColor := AWeekendColor;
    end;
    if (BtnHints <> nil) then
      for I := 0 to Min(BtnHints.Count - 1, 3) do begin
        if BtnHints[I] <> '' then
          D.FBtns[I].Hint := BtnHints[I];
      end;
    if D.ShowModal = mrOk then begin
      Date := D.Date;
      Result := True;
    end;
  finally
    D.Free;
  end;
end;

function SelectDateStr(var StrDate: string; const DlgCaption: TCaption;
  AStartOfWeek: TDayOfWeekName; AWeekends: TDaysOfWeek;
  AWeekendColor: TColor; BtnHints: TStrings): Boolean;
var
  DateValue: TDateTime;
begin
  if StrDate <> '' then begin
    try
      DateValue := StrToDateFmt(ShortDateFormat, StrDate);
    except
      DateValue := Date;
    end;
  end
  else DateValue := Date;
  Result := SelectDate(DateValue, DlgCaption, AStartOfWeek, AWeekends,
    AWeekendColor, BtnHints);
  if Result then StrDate := FormatDateTime(ShortDateFormat, DateValue);
end;

end.
