{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.SpinBox;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.UITypes, FMX.EditBox, FMX.Controls, FMX.Types, FMX.Presentation.Messages,
  FMX.Controls.Presentation, FMX.Controls.Model;

const
  MM_SPINBOX_REPEATCLICK_CHANGED = MM_EDITBOX_USER + 1;
  MM_SPINBOX_USER = MM_EDITBOX_USER + 2;

type

{ TSpinBox }

  TSpinBoxModel = class(TEditBoxModel)
  public const
    DefaultHorzAlign = TTextAlign.Center;
    DefaultRepeatClick = False;
  private
    FRepeatClick: Boolean;
    procedure SetRepeatClick(const Value: Boolean);
  protected
    function GetTextSettingsClass: TTextSettingsInfo.TCustomTextSettingsClass; override;
  public
    constructor Create; override;
    /// <summary>Need makes several clicks until the user didn't raise a finger from the screen.</summary>
    property RepeatClick: Boolean read FRepeatClick write SetRepeatClick;
  end;

  TSpinBox = class(TCustomEditBox)
  private
    function GetIncrement: Single; inline;
    procedure SetIncrement(const Value: Single); inline;
    function GetRepeatClick: Boolean;
    procedure SetRepeatClick(const Value: Boolean);
    function GetModel: TSpinBoxModel; overload;
  protected
    function DefineModelClass: TDataModelClass; override;
    function DefinePresentationName: string; override;
    /// <summary>Return model of <c>TSpinBox</c></summary>
    property Model: TSpinBoxModel read GetModel;
  public
    property TextAlign default TTextAlign.Center;
  published
    property Action;
    property CanFocus default True;
    property CanParentFocus;
    property Cursor default crDefault;
    property DisableFocusEffect;
    property Increment: Single read GetIncrement write SetIncrement stored HorzIncrementStored nodefault;
    property ReadOnly;
    /// <summary>Need makes several clicks until the user didn't raise a finger from the screen.</summary>
    property RepeatClick: Boolean read GetRepeatClick write SetRepeatClick default False;
    property KeyboardType default TVirtualKeyboardType.NumberPad;
    property Position;
    property Width;
    property Height;
    property TextSettings;
    property ClipChildren default False;
    property ClipParent default False;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Hint;
    property HitTest default True;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property StyleLookup;
    property StyledSettings;
    property TouchTargetExpansion;
    property Visible default True;
    property Caret;
    property KillFocusByReturn;
    property ParentShowHint;
    property ShowHint;
    { events }
    property OnChange;
    property OnChangeTracking;
    property OnTyping;
    property OnApplyStyleLookup;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Keyboard events }
    property OnKeyDown;
    property OnKeyUp;
    { Mouse events }
    property OnCanFocus;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnPainting;
    property OnPaint;
    property OnResize;
    property OnPresentationNameChoosing;
  end;

implementation

uses
  FMX.SpinBox.Style;

{ TSpinBox }

type

  TSpinBoxSettings = class (TTextSettingsInfo.TCustomTextSettings)
  public
    constructor Create(const AOwner: TPersistent); override;
  published
    property Font;
    property FontColor;
    property HorzAlign default TTextAlign.Center;
    property VertAlign default TTextAlign.Center;
  end;

{ TSpinBoxSettings }

constructor TSpinBoxSettings.Create(const AOwner: TPersistent);
begin
  inherited;
  WordWrap := False;
  HorzAlign := TTextAlign.Center;
  VertAlign := TTextAlign.Center;
end;

function TSpinBox.DefineModelClass: TDataModelClass;
begin
  Result := TSpinBoxModel;
end;

function TSpinBox.DefinePresentationName: string;
begin
  Result := 'SpinBox-' + GetPresentationSuffix;
end;

function TSpinBox.GetIncrement: Single;
begin
  Result := inherited HorzIncrement;
end;

function TSpinBox.GetModel: TSpinBoxModel;
begin
  Result := GetModel<TSpinBoxModel>;
end;

function TSpinBox.GetRepeatClick: Boolean;
begin
  Result := Model.RepeatClick;
end;

procedure TSpinBox.SetIncrement(const Value: Single);
begin
  inherited HorzIncrement := Value;
end;

procedure TSpinBox.SetRepeatClick(const Value: Boolean);
begin
  Model.RepeatClick := Value;
end;

{ TSpinBoxModel }

constructor TSpinBoxModel.Create;
begin
  inherited;
  FRepeatClick := DefaultRepeatClick;
  TextSettingsInfo.DefaultTextSettings.HorzAlign := DefaultHorzAlign;
  TextSettingsInfo.TextSettings.HorzAlign := DefaultHorzAlign;
end;

function TSpinBoxModel.GetTextSettingsClass: TTextSettingsInfo.TCustomTextSettingsClass;
begin
  Result := TSpinBoxSettings;
end;

procedure TSpinBoxModel.SetRepeatClick(const Value: Boolean);
begin
  if RepeatClick <> Value then
  begin
    FRepeatClick := Value;
    SendMessage(MM_SPINBOX_REPEATCLICK_CHANGED);
  end;
end;

initialization
  RegisterFmxClasses([TSpinBox]);
end.
