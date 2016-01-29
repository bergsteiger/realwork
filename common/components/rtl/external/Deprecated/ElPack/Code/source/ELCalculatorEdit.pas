{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$INCLUDE elpack2.inc}
{$IFDEF ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$ELSE}
{$IFDEF LINUX}
{$I ../ElPack.inc}
{$ELSE}
{$I ..\ElPack.inc}
{$ENDIF}
{$ENDIF}

(*

Version History

10/11/2002
  - default ButtonGlyph isn't stored to DFM
  - properties from agregated component CalculatorDialog are published now

10/10/2002

  Initially created.

*)

unit ElCalculatorEdit;

interface

uses SysUtils,
  Classes,
{$IFDEF VCL_6_USED}
  Types,
{$ELSE}
  windows,
{$ENDIF}
  Controls,
  Forms,
  Graphics,
  ElStrUtils,
  ElBtnEdit,
  ElVCLUtils,
  ElCalc,
  ElEdits;

type

  TElCalculatorDialogPos = class(TElCalculatorDialog)
  protected
    FSaveValue: TELFString;
    FModalResult: integer;
    FOnDeactivate: TElCalcDeactivateEvent;
    procedure InitCalculatorForm(ElCalculatorForm: TElCalculatorForm); override;
    procedure CalcDlg_OnFormClose(Sender: TObject; var Action: TCloseAction);
    procedure CalcDlg_OnFormDestroy(Sender: TObject);
    procedure CalcDlg_bCancelClick(Sender: TObject);
    procedure CalcDlg_bOKClick(Sender: TObject);
    procedure SetEditor(Value: TCustomElEdit);
  public
    procedure ExecuteNoModal; virtual;
  published
    property Editor write SetEditor stored False;
    property OnDeactivate: TElCalcDeactivateEvent read FOnDeactivate write
    FOnDeactivate;
  end;

  TCustomElCalculatorEdit = class(TCustomElButtonEdit)
  private
    FOnButtonClick: TNotifyEvent;
    FButtonGlyphDefault: Boolean;
    FButtonGlyphOnChange: TNotifyEvent;
    FCalcDlg: TElCalculatorDialog;
    FCalcDlgDefZeroValue:Boolean;
    procedure CalcDlg_OnDeactivate(Sender: TObject; var ModalResult: Integer);
    procedure ButtonGlyph_OnChanged(Sender: TObject);
    procedure SetButtonGlyphDefault(Value: Boolean);
    function GetCalcDlgMemoryButtonFont: TFont;
    procedure SetCalcDlgMemoryButtonFont(const Value: TFont);
    function GetCalcDlgCaption: TCaption;
    function GetCalcDlgDigitButtonFont: TFont;
    function GetCalcDlgOperatorButtonFont: TFont;
    function GetCalcDlgServiceButtonFont: TFont;
    function GetCalcDlgShowControlButtons: Boolean;
    procedure SetCalcDlgCaption(const Value: TCaption);
    procedure SetCalcDlgDigitButtonFont(const Value: TFont);
    procedure SetCalcDlgOperatorButtonFont(const Value: TFont);
    procedure SetCalcDlgServiceButtonFont(const Value: TFont);
    procedure SetCalcDlgShowControlButtons(const Value: Boolean);
    function GetOnCalcDlgClose: TNotifyEvent;
    function GetOnCalcDlgDeactivate: TElCalcDeactivateEvent;
    function GetOnCalcDlgError: TElMathErrorEvent;
    function GetOnCalcDlgShow: TNotifyEvent;
    procedure SetOnCalcDlgClose(const Value: TNotifyEvent);
    procedure SetOnCalcDlgDeactivate(const Value: TElCalcDeactivateEvent);
    procedure SetOnCalcDlgError(const Value: TElMathErrorEvent);
    procedure SetOnCalcDlgShow(const Value: TNotifyEvent);
  protected
    FElCalculatorForm: TElCalculatorForm;
    FCalcDlgModal: Boolean;
    procedure CalcButtonClick(Sender: TObject); virtual;
    procedure LoadButtonGlyphDefault;
    procedure CreateParams(var Params: TCreateParams); override;
    function NeedStroredButtonGlyph: Boolean;
    property OnButtonClick: TNotifyEvent read FOnButtonClick write
    FOnButtonClick;
    property ButtonGlyph stored NeedStroredButtonGlyph;
    property ButtonGlyphDefault: Boolean read FButtonGlyphDefault write
    SetButtonGlyphDefault default True;
    property CalcDlgModal: Boolean read FCalcDlgModal write FCalcDlgModal default
    False;

    property CalcDlgMemoryButtonFont: TFont read GetCalcDlgMemoryButtonFont write
    SetCalcDlgMemoryButtonFont;
    property CalcDlgDigitButtonFont: TFont read GetCalcDlgDigitButtonFont write
    SetCalcDlgDigitButtonFont;
    property CalcDlgOperatorButtonFont: TFont read GetCalcDlgOperatorButtonFont
    write SetCalcDlgOperatorButtonFont;
    property CalcDlgServiceButtonFont: TFont read GetCalcDlgServiceButtonFont
    write SetCalcDlgServiceButtonFont;
    property CalcDlgCaption: TCaption read GetCalcDlgCaption write
    SetCalcDlgCaption;
    property CalcDlgShowControlButtons: Boolean read GetCalcDlgShowControlButtons
    write SetCalcDlgShowControlButtons;
    property CalcDlgDefZeroValue: Boolean read FCalcDlgDefZeroValue write
    FCalcDlgDefZeroValue default True;

    property OnCalcDlgError: TElMathErrorEvent read GetOnCalcDlgError write
    SetOnCalcDlgError;
    property OnCalcDlgShow: TNotifyEvent read GetOnCalcDlgShow write
    SetOnCalcDlgShow;
    property OnCalcDlgClose: TNotifyEvent read GetOnCalcDlgClose write
    SetOnCalcDlgClose;
    property OnCalcDlgDeactivate: TElCalcDeactivateEvent read
    GetOnCalcDlgDeactivate write SetOnCalcDlgDeactivate;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  end;

  TElCalculatorEdit = class(TCustomElCalculatorEdit)
  published
    property CalcDlgModal;
    property ButtonGlyphDefault;

    property CalcDlgMemoryButtonFont;
    property CalcDlgDigitButtonFont;
    property CalcDlgOperatorButtonFont;
    property CalcDlgServiceButtonFont;
    property CalcDlgCaption;
    property CalcDlgShowControlButtons;
    property CalcDlgDefZeroValue;

    property OnCalcDlgError;
    property OnCalcDlgShow;
    property OnCalcDlgClose;
    property OnCalcDlgDeactivate;

    // inherited from TCustomElButtonEdit
    property AlignBottom;
    property CharCase;
    property TopMargin;
    property LeftMargin;
    property RightMargin;
    property AutoSize;
    property BorderSides;
    property Transparent;
    property HandleDialogKeys;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;

{$IFDEF ELPACK_USE_IMAGEFORM}
    property ImageForm;
{$ENDIF}

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;
    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;

    property Text;

    // inherited from TCustomElEdit
    property Flat;
    property ActiveBorderType;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property UseBackground;
    property UseSystemMenu;

    property Alignment;
    property AutoSelect;

    property Background;
    property ButtonCaption;
{$IFDEF USE_SOUND_MAP}
    property ButtonClickSound;
    property ButtonDownSound;
    property ButtonUpSound;
    property ButtonSoundMap;
{$ENDIF}
    property ButtonColor;
    property ButtonDown;
    property ButtonEnabled;
    property ButtonFlat;
    property ButtonGlyph;
    property ButtonHint;
    property ButtonIcon;
    property ButtonIsSwitch;
    property ButtonNumGlyphs;
    property ButtonPopupPlace;
    property ButtonPullDownMenu;
    property ButtonShortcut;
    property ButtonTransparent;
    property ButtonThinFrame;
    property ButtonUseIcon;
    property ButtonVisible;
    property ButtonWidth;
    property OnButtonClick;

    property AltButtonCaption;
{$IFDEF USE_SOUND_MAP}
    property AltButtonClickSound;
    property AltButtonDownSound;
    property AltButtonUpSound;
    property AltButtonSoundMap;
{$ENDIF}
    property AltButtonColor;
    property AltButtonDown;
    property AltButtonEnabled;
    property AltButtonFlat;
    property AltButtonGlyph;
    property AltButtonHint;
    property AltButtonIsSwitch;
    property AltButtonIcon;
    property AltButtonNumGlyphs;
    property AltButtonPopupPlace;
    property AltButtonPosition;
    property AltButtonPullDownMenu;
    property AltButtonShortcut;
    property AltButtonThinFrame;
    property AltButtonTransparent;
    property AltButtonUseIcon;
    property AltButtonVisible;
    property AltButtonWidth;
    property OnAltButtonClick;

    // VCL properties
    property BorderStyle;
    property Ctl3D;
    property ParentCtl3D;
    property Enabled;
    property TabStop default True;
    property TabOrder;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property ReadOnly;

    property OnEnter;
    property OnExit;
    property OnClick;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;
{$IFDEF VCL_4_USED}
    property OnEndDock;
{$ENDIF}
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF VCL_4_USED}
    property OnStartDock;
{$ENDIF}

{$IFDEF VCL_4_USED}
    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DoubleBuffered;
    property DragKind;
{$ENDIF}
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('EldoS Dialogs', [TElCalculatorEdit]);
end;

{ TElCalculatorDialogPos }

procedure TElCalculatorDialogPos.CalcDlg_bCancelClick(Sender: TObject);
begin
  (Editor as TCustomElCalculatorEdit).FElCalculatorForm.Close;
end;

procedure TElCalculatorDialogPos.CalcDlg_bOKClick(Sender: TObject);
begin
  FModalResult := mrOK;
  (Editor as TCustomElCalculatorEdit).FElCalculatorForm.Close;
end;

procedure TElCalculatorDialogPos.CalcDlg_OnFormClose(Sender: TObject; var
  Action: TCloseAction);
begin
  Action := caFree;
  if FModalResult <> mrOK then // restore old value
    Editor.Text := FSaveValue;
  DoClose;
end;

procedure TElCalculatorDialogPos.CalcDlg_OnFormDestroy(Sender: TObject);
begin
  (Editor as TCustomElCalculatorEdit).FElCalculatorForm := nil;
end;

procedure TElCalculatorDialogPos.InitCalculatorForm(ElCalculatorForm:
  TElCalculatorForm);
var
  P: TPoint;
  ElCalcForm_Height: Integer;
begin
  inherited InitCalculatorForm(ElCalculatorForm);

  // calculate position of calculator window

  ElCalcForm_Height := ElCalculatorForm.Height;

  ElCalculatorForm.Position := poDesigned;

  P := Editor.Parent.ClientToScreen(Point(Editor.Left, Editor.Top));

  // calculate dialog height
  if P.Y + ElCalcForm_Height < ElVCLUtils.GetDesktopBottom then
  begin // bottom
    ElCalculatorForm.Top := P.Y + Editor.Height;
  end
  else
  begin // top
    ElCalculatorForm.Top := P.Y - ElCalcForm_Height;
  end;

  // calculate dialog width
  if P.X + ElCalculatorForm.Width < ElVCLUtils.GetDesktopRight then
  begin
    ElCalculatorForm.Left := P.X;
    // correct horizontal position
    if ElCalculatorForm.Left < ElVCLUtils.GetDesktopLeft then
      ElCalculatorForm.Left := ElVCLUtils.GetDesktopLeft;
  end
  else
  begin
    ElCalculatorForm.Left := ElVCLUtils.GetDesktopRight - ElCalculatorForm.Width;
  end;
  if ElCalculatorForm.Caption = '' then
    ElCalculatorForm.DialogStyle := edsPopup;
end;

procedure TElCalculatorDialogPos.ExecuteNoModal;
begin
{$IFDEF D_5_UP}
  FreeAndNil((Editor as TCustomElCalculatorEdit).FElCalculatorForm);
{$ELSE}
  try
    (Editor as TCustomElCalculatorEdit).FElCalculatorForm.Free;
  finally
    (Editor as TCustomElCalculatorEdit).FElCalculatorForm := nil;
  end;
{$ENDIF}

  with (Editor as TCustomElCalculatorEdit) do
  begin
    FElCalculatorForm := TElCalculatorForm.Create(Self);
    FElCalculatorForm.OnDestroy := CalcDlg_OnFormDestroy;
    FElCalculatorForm.OnClose := CalcDlg_OnFormClose;
    FElCalculatorForm.bCancel.OnClick := CalcDlg_bCancelClick;
    FElCalculatorForm.bOK.OnClick := CalcDlg_bOKClick;

    InitCalculatorForm(FElCalculatorForm);

    FSaveValue := Editor.Text;
    FModalResult := mrNone;
    DoShow;

    FElCalculatorForm.Show;
  end;
end;

procedure TElCalculatorDialogPos.SetEditor(Value: TCustomElEdit);
begin
   // read only
end;

{ TCustomElCalculatorEdit }

procedure TCustomElCalculatorEdit.ButtonGlyph_OnChanged(Sender: TObject);
begin
  FButtonGlyphDefault := False;
  if Assigned(FButtonGlyphOnChange) then FButtonGlyphOnChange(Sender);
end;

procedure TCustomElCalculatorEdit.CalcButtonClick(Sender: TObject);
begin
  if Assigned(FOnButtonClick) then FOnButtonClick(Sender);

  if FCalcDlg.Editor = nil then // restore Editor
    FCalcDlg.Editor := Self;

  with FCalcDlg as TElCalculatorDialogPos do
  begin
    if FCalcDlgDefZeroValue or
       ( not TextToFloat(PChar(string(Text)), FInitialValue, fvExtended) )
    then
      FInitialValue := 0;

    if not CalcDlgModal then
      ExecuteNoModal
    else
    begin
      FSaveValue := Text;
      if not FCalcDlg.Execute then Text := FSaveValue;
      // restore saved value
    end;
  end;
end;

procedure TCustomElCalculatorEdit.CalcDlg_OnDeactivate(Sender: TObject; var
  ModalResult: Integer);
begin
  with FCalcDlg as TElCalculatorDialogPos do
  begin
    if Assigned(OnDeactivate) then OnDeactivate(Sender, ModalResult);
  end;
  if not CalcDlgModal then
  begin
    ModalResult := mrOk;
    if Assigned(FElCalculatorForm) then FElCalculatorForm.Close;
  end;
end;

constructor TCustomElCalculatorEdit.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csSetCaption];
  Text := '0' + DecimalSeparator;
  FCalcDlg := TElCalculatorDialogPos.Create(Self);
  FCalcDlg.OnDeactivate := CalcDlg_OnDeactivate;
  FCalcDlg.Editor := Self;
  inherited OnButtonClick := CalcButtonClick;
  FButtonGlyphOnChange := ButtonGlyph.OnChange;
  ButtonGlyph.OnChange := ButtonGlyph_OnChanged;
  FButtonGlyphDefault := True;
  FCalcDlgDefZeroValue := True;
end;

procedure TCustomElCalculatorEdit.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if FButtonGlyphDefault and ButtonGlyph.Empty then LoadButtonGlyphDefault;
end;

destructor TCustomElCalculatorEdit.Destroy;
begin
  ButtonGlyph.OnChange := FButtonGlyphOnChange;
  inherited;
end;

function TCustomElCalculatorEdit.GetCalcDlgCaption: TCaption;
begin
  Result := FCalcDlg.Caption;
end;

function TCustomElCalculatorEdit.GetCalcDlgDigitButtonFont: TFont;
begin
  Result := FCalcDlg.DigitButtonFont;
end;

function TCustomElCalculatorEdit.GetCalcDlgMemoryButtonFont: TFont;
begin
  Result := FCalcDlg.MemoryButtonFont;
end;

function TCustomElCalculatorEdit.GetCalcDlgOperatorButtonFont: TFont;
begin
  Result := FCalcDlg.OperatorButtonFont;
end;

function TCustomElCalculatorEdit.GetCalcDlgServiceButtonFont: TFont;
begin
  Result := FCalcDlg.ServiceButtonFont;
end;

function TCustomElCalculatorEdit.GetCalcDlgShowControlButtons: Boolean;
begin
  Result := FCalcDlg.ShowControlButtons;
end;

function TCustomElCalculatorEdit.GetOnCalcDlgClose: TNotifyEvent;
begin
  Result := (FCalcDlg as TElCalculatorDialogPos).OnClose;
end;

function TCustomElCalculatorEdit.GetOnCalcDlgDeactivate: TElCalcDeactivateEvent;
begin
  Result := (FCalcDlg as TElCalculatorDialogPos).OnDeactivate;
end;

function TCustomElCalculatorEdit.GetOnCalcDlgError: TElMathErrorEvent;
begin
  Result := (FCalcDlg as TElCalculatorDialogPos).OnError;
end;

function TCustomElCalculatorEdit.GetOnCalcDlgShow: TNotifyEvent;
begin
  Result := (FCalcDlg as TElCalculatorDialogPos).OnShow;
end;

procedure TCustomElCalculatorEdit.LoadButtonGlyphDefault;
begin
  ElCalc.LoadCalculatorDefaultGlyph(ButtonGlyph);
  FButtonGlyphDefault := True;
end;

function TCustomElCalculatorEdit.NeedStroredButtonGlyph: Boolean;
begin
  Result := not FButtonGlyphDefault;
end;

procedure TCustomElCalculatorEdit.SetButtonGlyphDefault(Value: Boolean);
begin
  if FButtonGlyphDefault <> Value then
  begin
    if Value then
    begin
      LoadButtonGlyphDefault;
    end
    else
    begin
      ButtonGlyph := nil;
    end;
    FButtonGlyphDefault := Value;
    if (not (csLoading in Componentstate)) then Invalidate;
  end;
end;

procedure TCustomElCalculatorEdit.SetCalcDlgCaption(const Value: TCaption);
begin
  FCalcDlg.Caption := Value;
end;

procedure TCustomElCalculatorEdit.SetCalcDlgDigitButtonFont(
  const Value: TFont);
begin
  FCalcDlg.DigitButtonFont := Value;
end;

procedure TCustomElCalculatorEdit.SetCalcDlgMemoryButtonFont(
  const Value: TFont);
begin
  FCalcDlg.MemoryButtonFont := Value;
end;

procedure TCustomElCalculatorEdit.SetCalcDlgOperatorButtonFont(
  const Value: TFont);
begin
  FCalcDlg.OperatorButtonFont := Value;
end;

procedure TCustomElCalculatorEdit.SetCalcDlgServiceButtonFont(
  const Value: TFont);
begin
  FCalcDlg.ServiceButtonFont := Value;
end;

procedure TCustomElCalculatorEdit.SetCalcDlgShowControlButtons(
  const Value: Boolean);
begin
  FCalcDlg.ShowControlButtons := Value;
end;

procedure TCustomElCalculatorEdit.SetOnCalcDlgClose(
  const Value: TNotifyEvent);
begin
  (FCalcDlg as TElCalculatorDialogPos).OnClose := Value;
end;

procedure TCustomElCalculatorEdit.SetOnCalcDlgDeactivate(
  const Value: TElCalcDeactivateEvent);
begin
  (FCalcDlg as TElCalculatorDialogPos).OnDeactivate := Value;
end;

procedure TCustomElCalculatorEdit.SetOnCalcDlgError(
  const Value: TElMathErrorEvent);
begin
  (FCalcDlg as TElCalculatorDialogPos).OnError := Value;
end;

procedure TCustomElCalculatorEdit.SetOnCalcDlgShow(
  const Value: TNotifyEvent);
begin
  (FCalcDlg as TElCalculatorDialogPos).OnShow := Value;
end;

end.
