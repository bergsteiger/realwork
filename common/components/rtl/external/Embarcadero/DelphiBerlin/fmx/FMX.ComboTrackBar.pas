{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.ComboTrackBar;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.UITypes, FMX.ComboEdit, FMX.Controls, FMX.StdActns, FMX.ActnList, FMX.Presentation.Messages,
  FMX.Text, FMX.Controls.Presentation, FMX.Controls.Model;

const
  MM_DECIMALDIGITS_CHANGED = MM_COMBOEDIT_USER + 1;
  MM_VALUETYPE_CHANGED = MM_COMBOEDIT_USER + 2;
  MM_VALUERANGE_CHANGED = MM_COMBOEDIT_USER + 3;

type

{ TComboTrackBar }

  TComboTrackBarModel = class(TComboEditModel)
  public const
    DefaultValueType = TNumValueType.Integer;
    DefaultDecimalDigits = 3;
  private
    FDecimalDigits: Byte;
    FValueType: TNumValueType;
    FPlacement: TPlacement;
    FValueRange: TCustomValueRange;
    FDefaultValueRange: TBaseValueRange;
    procedure SetDecimalDigits(const Value: Byte);
    procedure SetValueType(const Value: TNumValueType);
    function GetValue: Single;
  protected
    procedure DoValueRangeChanged(Sender: TObject);
    function DoValidate(const AValue: string): string; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    function ConvertValueToText(const Value: Single): string;
    function GetValueAsString: string;
    property DefaultValueRange: TBaseValueRange read FDefaultValueRange;
    property DecimalDigits: Byte read FDecimalDigits write SetDecimalDigits;
    property Placement: TPlacement read FPlacement write FPlacement;
    property Value: Single read GetValue;
    property ValueRange: TCustomValueRange read FValueRange;
    property ValueType: TNumValueType read FValueType write SetValueType;
  end;

  TComboTrackBar = class(TComboEditBase)
  private
    function GetFrequency: Single;
    function GetMax: Single;
    function GetMin: Single;
    function GetValue: Single;
    procedure SetFrequency(const Value: Single);
    procedure SetMax(const Value: Single);
    procedure SetMin(const Value: Single);
    procedure SetValue(const AValue: Single);
    function DefStored: Boolean;
    procedure SetValueType(const AValueType: TNumValueType);
    procedure SetDecimalDigits(const AValue: Byte);
    function MaxStored: Boolean;
    function MinStored: Boolean;
    function ValueStored: Boolean;
    function GetModel: TComboTrackBarModel; overload;
    function GetDecimalDigits: Byte;
    function GetValueType: TNumValueType;
  protected
    procedure Loaded; override;
    function GetDefaultStyleLookupName: string; override;
  protected
    function DefinePresentationName: string; override;
    function DefineModelClass: TDataModelClass; override;
    property Model: TComboTrackBarModel read GetModel;
  public
    constructor Create(AOwner: TComponent); override;
    property TextAlign;
    property Font;
  published
    property Action;
    property CanFocus default True;
    property CanParentFocus;
    property Cursor default crDefault;
    property DisableFocusEffect;
    property KeyboardType;
    property ReadOnly;
    property Min: Single read GetMin write SetMin stored MinStored nodefault;
    property Max: Single read GetMax write SetMax stored MaxStored nodefault;
    property Value: Single read GetValue write SetValue stored ValueStored nodefault;
    property ValueType: TNumValueType read GetValueType write SetValueType default TNumValueType.Integer;
    property Frequency: Single read GetFrequency write SetFrequency stored ValueStored nodefault;
    property DecimalDigits: Byte read GetDecimalDigits write SetDecimalDigits;
    property Text stored False;
    property TextSettings;
    property Position;
    property Width;
    property Height;
    property ClipChildren default False;
    property ClipParent default False;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property HitTest default True;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property StyledSettings;
    property StyleLookup;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
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
  System.SysUtils, System.Math, FMX.Types, FMX.ComboTrackBar.Style;

{ TComboTrackBar }

constructor TComboTrackBar.Create(AOwner: TComponent);
begin
  inherited;
  Width := 100;
  Height := 22;
end;

function TComboTrackBar.DefineModelClass: TDataModelClass;
begin
  Result := TComboTrackBarModel;
end;

function TComboTrackBar.DefinePresentationName: string;
begin
  Result := 'ComboTrackBar-' + GetPresentationSuffix;
end;

function TComboTrackBar.DefStored: Boolean;
begin
  Result := not (ActionClient and (Action is TCustomValueRangeAction));
end;

function TComboTrackBar.MaxStored: Boolean;
begin
  Result := DefStored and not SameValue(Max, Model.DefaultValueRange.Max);
end;

function TComboTrackBar.MinStored: Boolean;
begin
  Result := DefStored and not SameValue(Min, Model.DefaultValueRange.Min);
end;

function TComboTrackBar.ValueStored: Boolean;
begin
  Result := DefStored and not SameValue(Value, Model.DefaultValueRange.Value);
end;

function TComboTrackBar.GetDecimalDigits: Byte;
begin
  Result := Model.DecimalDigits;
end;

function TComboTrackBar.GetDefaultStyleLookupName: string;
begin
  Result := 'comboeditstyle'; // do not localize
end;

function TComboTrackBar.GetValueType: TNumValueType;
begin
  Result := Model.ValueType;
end;

procedure TComboTrackBar.Loaded;
begin
  inherited;
  if Model.ValueRange.IsChanged then
    Model.ValueRange.Changed(True);
end;

function TComboTrackBar.GetFrequency: Single;
begin
  Result := Model.ValueRange.Frequency;
end;

function TComboTrackBar.GetMax: Single;
begin
  Result := Model.ValueRange.Max;
end;

function TComboTrackBar.GetMin: Single;
begin
  Result := Model.ValueRange.Min;
end;

function TComboTrackBar.GetModel: TComboTrackBarModel;
begin
  Result := GetModel<TComboTrackBarModel>;
end;

function TComboTrackBar.GetValue: Single;
begin
  Result := Model.Value;
end;

procedure TComboTrackBar.SetDecimalDigits(const AValue: Byte);
begin
  Model.DecimalDigits := AValue;
end;

procedure TComboTrackBar.SetFrequency(const Value: Single);
begin
  Model.ValueRange.Frequency := Value;
end;

procedure TComboTrackBar.SetMax(const Value: Single);
begin
  Model.ValueRange.Max := Value;
end;

procedure TComboTrackBar.SetMin(const Value: Single);
begin
  Model.ValueRange.Min := Value;
end;

procedure TComboTrackBar.SetValue(const AValue: Single);
begin
  Model.ValueRange.Value := AValue;
end;

procedure TComboTrackBar.SetValueType(const AValueType: TNumValueType);
begin
  Model.ValueType := AValueType;
end;

{ TComboTrackBarModel }

function TComboTrackBarModel.ConvertValueToText(const Value: Single): string;
begin
  if ValueType = TNumValueType.Integer then
    Result := IntToStr(Round(Value))
  else
    Result := FloatToStrF(Value, ffFixed, 7 + DecimalDigits, DecimalDigits);
end;

constructor TComboTrackBarModel.Create;
begin
  inherited;
  FValueRange := TValueRange.Create(Owner);
  FDefaultValueRange := TBaseValueRange.Create;
  FDecimalDigits := DefaultDecimalDigits;
  FValueType := DefaultValueType;
  FilterChar := FilterCharByValueType(FValueType);
  if Pos(FormatSettings.DecimalSeparator, FilterChar) = 0 then
    FilterChar := FilterChar + FormatSettings.DecimalSeparator;
  FValueRange.OnChanged := DoValueRangeChanged;
  Text := ConvertValueToText(Value);
end;

destructor TComboTrackBarModel.Destroy;
begin
  FreeAndNil(FValueRange);
  FreeAndNil(FDefaultValueRange);
  inherited;
end;

function TComboTrackBarModel.DoValidate(const AValue: string): string;
var
  TempValue: Single;
  NewString: string;
begin
  NewString := inherited;
  if TryTextToValue(NewString, TempValue, Value) then
  begin
    if TempValue > ValueRange.Max then
      TempValue := ValueRange.Max
    else
      if TempValue < ValueRange.Min then
        TempValue := ValueRange.Min;

    Result := TempValue.ToString
  end
  else
    Result := NewString;
end;

procedure TComboTrackBarModel.DoValueRangeChanged(Sender: TObject);
begin
  SendMessage(MM_VALUERANGE_CHANGED);
end;

function TComboTrackBarModel.GetValue: Single;
begin
  if ValueType = TNumValueType.Integer then
    Result := Round(ValueRange.Value)
  else
    Result := ValueRange.Value;
end;

function TComboTrackBarModel.GetValueAsString: string;
begin
  Result := ConvertValueToText(ValueRange.Value);
end;

procedure TComboTrackBarModel.SetDecimalDigits(const Value: Byte);
var
  TmpValue: Byte;
begin
  TmpValue := System.Math.Max(Value, 1);
  if TmpValue <> FDecimalDigits then
  begin
    FDecimalDigits := TmpValue;
    SendMessage(MM_DECIMALDIGITS_CHANGED);
  end;
end;

procedure TComboTrackBarModel.SetValueType(const Value: TNumValueType);
begin
  if FValueType <> Value then
  begin
    FValueType := Value;
    FilterChar := FilterCharByValueType(FValueType);
    SendMessage(MM_VALUETYPE_CHANGED);
  end;
end;

initialization
  RegisterFmxClasses([TComboTrackBar]);
end.
