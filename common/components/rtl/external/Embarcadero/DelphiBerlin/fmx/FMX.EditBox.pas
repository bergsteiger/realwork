{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.EditBox;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Rtti, System.UITypes, FMX.Controls, FMX.Edit, FMX.StdActns, FMX.ActnList,
  FMX.Presentation.Messages, FMX.Text, FMX.Types, FMX.Controls.Model;

const
  MM_DECIMALDIGITS_CHANGED = MM_EDIT_USER + 1;
  MM_VALUETYPE_CHANGED = MM_EDIT_USER + 2;
  MM_VALUERANGE_CHANGED = MM_EDIT_USER + 3;
  MM_HORZ_INCREMENT_CHANGED = MM_EDIT_USER + 4;
  MM_EDITBOX_USER = MM_EDIT_USER + 5;

type

{ TCustomEditBox }

  TEditBoxModel = class(TCustomEditModel)
  public const
    DefaultDecimalDigits = 2;
    DefaultHorzIncrement = 1;
    DefaultValueType = TNumValueType.Integer;
    DefaultKeyboardType = TVirtualKeyboardType.NumberPad;
  private
    FValueRange: TValueRange;
    FValueType: TNumValueType;
    FDecimalDigits: Integer;
    FHorzIncrement: Single;
    FDefaultValueRange: TBaseValueRange;
    procedure SetDecimalDigits(const Value: Integer);
    procedure SetValueType(const Value: TNumValueType);
    function GetValue: Single;
    procedure SetValue(const Value: Single);
    function GetCurrentIncrement: Single;
    procedure SetHorzIncrement(const Value: Single);
  protected
    function DoValidating(const Value: string): string; override;
    function DoValidate(const Value: string): string; override;
    function GetTextSettingsClass: TTextSettingsInfo.TCustomTextSettingsClass; override;
    function ConvertToText(const AValue: Single; const Source: string = ''): string;
  public
    constructor Create; override;
    destructor Destroy; override;
    function ConvertValueToText: string;
    function ConvertTextToValue(const AText: string): Single;
    property CurrentIncrement: Single read GetCurrentIncrement;
    property DefaultValueRange: TBaseValueRange read FDefaultValueRange;
    property DecimalDigits: Integer read FDecimalDigits write SetDecimalDigits;
    property HorzIncrement: Single read FHorzIncrement write SetHorzIncrement;
    property Value: Single read GetValue write SetValue;
    property ValueType: TNumValueType read FValueType write SetValueType;
    property ValueRange: TValueRange read FValueRange;
  end;

  TCustomEditBox = class(TCustomEdit, IValueRange)
  private
    procedure SetMax(const AValue: Single);
    function GetMax: Single;
    function MaxStored: Boolean;
    procedure SetMin(const AValue: Single);
    function GetMin: Single;
    function MinStored: Boolean;
    function GetValue: Single;
    function ValueStored: Boolean;
    procedure SetDecimalDigits(const ADecimalDigits: Integer);
    function GetDecimalDigits: Integer;
    procedure SetValueType(const AValueType: TNumValueType);
    function GetValueType: TNumValueType;
    procedure SetValueRange(const AValue: TCustomValueRange);
    function GetValueRange: TCustomValueRange;
    procedure SetValueRange_(const Value: TValueRange);
    function GetValueRange_: TValueRange;
    procedure SetHorzIncrement(const Value: Single);
    function GetHorzIncrement: Single;
    function DefStored: Boolean;
    function GetDefaultValueRange: TBaseValueRange;
  private
    function GetModel: TEditBoxModel; overload;
  protected
    function HorzIncrementStored: Boolean; virtual;
    procedure Loaded; override;
    procedure SetValue(const AValue: Single); virtual;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    { Actions }
    function GetActionLinkClass: TActionLinkClass; override;
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); override;
    property DefaultValueRange: TBaseValueRange read GetDefaultValueRange;
  protected
    function DefineModelClass: TDataModelClass; override;
    function DefinePresentationName: string; override;
    property Model: TEditBoxModel read GetModel;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AfterConstruction; override;
    procedure ValueInc;
    procedure ValueDec;
    property HorzIncrement: Single read GetHorzIncrement write SetHorzIncrement stored HorzIncrementStored nodefault;
    property ValueRange: TValueRange read GetValueRange_ write SetValueRange_ stored ValueStored;
    property Font;
    property FontColor;
    property TextSettings;
  published
    property Cursor default crIBeam;
    property DecimalDigits: Integer read GetDecimalDigits write SetDecimalDigits default 2;
    property Min: Single read GetMin write SetMin stored MinStored nodefault;
    property Max: Single read GetMax write SetMax stored MaxStored nodefault;
    property Value: Single read GetValue write SetValue stored ValueStored nodefault;
    property ValueType: TNumValueType read GetValueType write SetValueType default TNumValueType.Integer;
    property Text stored False;
  end;

implementation

uses
  System.Actions, System.Math, System.SysUtils, System.Character, FMX.Consts, FMX.EditBox.Style;

type
  TValueRangeCustomEditBox = class(TValueRange)
  private
    [Weak] FCustomEditBox: TCustomEditBox;
    FValueChanged: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoBeforeChange; override;
    procedure DoAfterChange; override;
    function NeedActionChange: Boolean;
    property CustomEditBox: TCustomEditBox read FCustomEditBox;
  end;

{ TValueRangeCustomEditBox }

constructor TValueRangeCustomEditBox.Create(AOwner: TComponent);
begin
  if not (AOwner is TCustomEditBox) then
    raise EActionError.CreateFMT(SEUseHeirs, [TCustomEditBox.ClassName]);
  inherited;
  FCustomEditBox := TCustomEditBox(AOwner);
end;

function TValueRangeCustomEditBox.NeedActionChange: Boolean;
begin
  Result := CustomEditBox.ActionClient and
           (not CustomEditBox.DefStored) and
           (not TValueRangeAction(CustomEditBox.Action).ValueRange.Changing);
end;

procedure TValueRangeCustomEditBox.DoAfterChange;
begin
  if FValueChanged then
  try
    if not CustomEditBox.Model.Validating then
    begin
      CustomEditBox.Model.Text := CustomEditBox.Model.ConvertValueToText;
      CustomEditBox.Model.DoChange;
    end;
  finally
    FValueChanged := False;
  end;
end;

procedure TValueRangeCustomEditBox.DoBeforeChange;
var
  Sigma: Single;
begin
  Sigma := Power(10, -CustomEditBox.DecimalDigits)/2;
  if not SameValue(New.Value, Value, Sigma) then
    FValueChanged := True;
  if NeedActionChange then
    TValueRangeAction(CustomEditBox.Action).ValueRange.Assign(New);
  inherited;
end;

{ TCustomEditBox }

constructor TCustomEditBox.Create(AOwner: TComponent);
begin
  inherited;
  Text := '0';
end;

type
  TCustomEditBoxSettings = class (TTextSettingsInfo.TCustomTextSettings)
  public
    constructor Create(const AOwner: TPersistent); override;
  published
    property Font;
    property FontColor;
    property HorzAlign default TTextAlign.Leading;
    property VertAlign default TTextAlign.Center;
  end;

{ TCustomEditBoxSettings }

constructor TCustomEditBoxSettings.Create(const AOwner: TPersistent);
begin
  inherited;
  WordWrap := False;
  HorzAlign := TTextAlign.Leading;
  VertAlign := TTextAlign.Center;
end;

procedure TCustomEditBox.AfterConstruction;
begin
  inherited;
  DefaultValueRange.Assign(Model.ValueRange.New);
end;

function TCustomEditBox.GetData: TValue;
begin
  if ValueType = TNumValueType.Integer then
    Result := TValue.From<Integer>(Round(Value))
  else
    Result := TValue.From<Single>(Value);
end;

function TCustomEditBox.GetDecimalDigits: Integer;
begin
  Result := Model.DecimalDigits;
end;

function TCustomEditBox.GetDefaultValueRange: TBaseValueRange;
begin
  Result := Model.DefaultValueRange;
end;

function TCustomEditBox.GetHorzIncrement: Single;
begin
  Result := Model.HorzIncrement;
end;

function TCustomEditBox.DefineModelClass: TDataModelClass;
begin
  Result := TEditBoxModel;
end;

function TCustomEditBox.DefinePresentationName: string;
begin
  Result := 'EditBox-' + GetPresentationSuffix;
end;

function TCustomEditBox.DefStored: boolean;
begin
  Result := not (ActionClient and (Action is TCustomValueRangeAction));
end;

function TCustomEditBox.MaxStored: Boolean;
begin
  Result := DefStored and (not SameValue(Max, DefaultValueRange.Max));
end;

function TCustomEditBox.MinStored: Boolean;
begin
  Result := DefStored and (not SameValue(Min, DefaultValueRange.Min));
end;

function TCustomEditBox.ValueStored: Boolean;
begin
  Result := DefStored and (not SameValue(Value, DefaultValueRange.Value));
end;

function TCustomEditBox.GetValueRange: TCustomValueRange;
begin
  Result := Model.ValueRange;
end;

function TCustomEditBox.GetValueRange_: TValueRange;
begin
  Result := Model.ValueRange
end;

function TCustomEditBox.GetValueType: TNumValueType;
begin
  Result := Model.ValueType;
end;

procedure TCustomEditBox.SetValueRange(const AValue: TCustomValueRange);
begin
  Model.ValueRange.Assign(AValue);
end;

procedure TCustomEditBox.SetValueRange_(const Value: TValueRange);
begin
  Model.ValueRange.Assign(Value);
end;

function TCustomEditBox.GetActionLinkClass: TActionLinkClass;
begin
  Result := TValueRangeActionLink;
end;

procedure TCustomEditBox.ActionChange(Sender: TBasicAction; CheckDefaults: Boolean);
begin
  if Sender is TValueRangeAction then
  begin
    if (not CheckDefaults) or (Model.ValueRange.IsEmpty) then
      Model.ValueRange.Assign(TValueRangeAction(Sender).ValueRange);
  end;
  inherited;
end;

function TCustomEditBox.HorzIncrementStored: Boolean;
begin
  Result := not SameValue(Model.HorzIncrement, 1);
end;

procedure TCustomEditBox.SetData(const Value: TValue);
begin
  if Value.IsType<TNotifyEvent> then
    OnChange := Value.AsType<TNotifyEvent>()
  else if Value.IsOrdinal then
    Self.Value := Value.AsInteger
  else
    Self.Value := Value.AsType<Single>;
end;

procedure TCustomEditBox.ValueDec;
begin
  ValueRange.Value := Model.ConvertTextToValue(Text);
  ValueRange.Increment := Model.CurrentIncrement;
  ValueRange.Dec;
end;

procedure TCustomEditBox.ValueInc;
begin
  ValueRange.Value := Model.ConvertTextToValue(Text);
  ValueRange.Increment := Model.CurrentIncrement;
  ValueRange.Inc;
end;

procedure TCustomEditBox.Loaded;
begin
  if Model.ValueRange.IsChanged then
    Model.ValueRange.Changed(True);
  inherited;
end;

procedure TCustomEditBox.SetDecimalDigits(const ADecimalDigits: Integer);
begin
  Model.DecimalDigits := ADecimalDigits;
end;

procedure TCustomEditBox.SetHorzIncrement(const Value: Single);
begin
  Model.HorzIncrement := Value;
end;

function TCustomEditBox.GetMax: Single;
begin
  Result := Model.ValueRange.Max;
end;

procedure TCustomEditBox.SetMax(const AValue: Single);
begin
  Model.ValueRange.Max := AValue;
end;

function TCustomEditBox.GetMin: Single;
begin
  Result := Model.ValueRange.Min;
end;

function TCustomEditBox.GetModel: TEditBoxModel;
begin
  Result := GetModel<TEditBoxModel>;
end;

procedure TCustomEditBox.SetMin(const AValue: Single);
begin
  Model.ValueRange.Min := AValue;
end;

function TCustomEditBox.GetValue: Single;
begin
  Result := Model.ValueRange.Value;
end;

procedure TCustomEditBox.SetValue(const AValue: Single);
begin
  Model.ValueRange.Value := AValue;
 // Model.Change this should not be here
end;

procedure TCustomEditBox.SetValueType(const AValueType: TNumValueType);
begin
  Model.ValueType := AValueType;
end;

{ TEditBoxModel }

function FilterCharByValueType(const AValueType: TNumValueType): string;
begin
  if AValueType = TNumValueType.Integer then
    Result := '0123456789-+'
  else
  begin
    Result := '0123456789.,-+';
    if Pos(FormatSettings.DecimalSeparator, Result) = 0 then
      Result := Result + FormatSettings.DecimalSeparator;
  end;
end;

function TEditBoxModel.ConvertTextToValue(const AText: string): Single;
var
  TempValue: Single;
begin
  if TryTextToValue(AText, TempValue, Value) then
  begin
    if (Frac(TempValue) = 0) or (ValueType = TNumValueType.Integer) then
      Result := Round(TempValue)
    else
      Result := TempValue;
  end
  else
    Result := Value;
end;

function TEditBoxModel.ConvertToText(const AValue: Single; const Source: string): string;
begin
  if (Frac(AValue) = 0) or (ValueType = TNumValueType.Integer) then
    Result := IntToStr(Round(AValue))
  else
    Result := FloatToStrF(AValue, ffFixed, 7 + DecimalDigits, DecimalDigits);
  if (ValueType = TNumValueType.Float) and not Source.IsEmpty and (Source.EndsWith('.') or Source.EndsWith(',')) then
    Result := Result + FormatSettings.DecimalSeparator;
end;

function TEditBoxModel.ConvertValueToText: string;
begin
  Result := ConvertToText(Self.Value);
end;

constructor TEditBoxModel.Create;
begin
  inherited;
  FValueRange := TValueRangeCustomEditBox.Create(Owner);
  FDefaultValueRange := TBaseValueRange.Create;
  FDecimalDigits := DefaultDecimalDigits;
  FHorzIncrement := DefaultHorzIncrement;
  FValueType := DefaultValueType;
  KeyboardType := DefaultKeyboardType;
  FilterChar := FilterCharByValueType(ValueType);
  Text := '0';
end;

destructor TEditBoxModel.Destroy;
begin
  FreeAndNil(FDefaultValueRange);
  FreeAndNil(FValueRange);
  inherited;
end;

function TEditBoxModel.DoValidate(const Value: string): string;
var
  TempValue: Single;
begin
  if TryTextToValue(Value, TempValue, ValueRange.Value) then
  begin
    if ValueType = TNumValueType.Integer then
      TempValue := Round(TempValue);
  end;
  Result := inherited DoValidate(ConvertToText(TempValue, Value));
  if TryTextToValue(Result, TempValue, ValueRange.Value) then
  begin
    if ValueType = TNumValueType.Integer then
      TempValue := Round(TempValue);
    ValueRange.Value := TempValue;
  end;
  Result := ConvertToText(ValueRange.Value, Value);
end;

function TEditBoxModel.DoValidating(const Value: string): string;
const
  NonBreakingSpace = #160;
var
  S: string;
  I: Integer;
  SpaceAware: TArray<Char>;
begin
  S := '';
  SpaceAware := [NonBreakingSpace];
  if not FormatSettings.ThousandSeparator.IsInArray([',', '.']) then
    SpaceAware := SpaceAware + [FormatSettings.ThousandSeparator];
  for I := 0 to Value.Length - 1 do
    if (Value.Chars[I] > ' ') and (not Char.IsInArray(Value, I, SpaceAware)) then
      S := S + Value.Chars[I];
  Result := inherited DoValidating(S);
end;

function TEditBoxModel.GetCurrentIncrement: Single;
begin
  Result := System.Math.Max(HorzIncrement, ValueRange.Frequency);
end;

function TEditBoxModel.GetTextSettingsClass: TTextSettingsInfo.TCustomTextSettingsClass;
begin
  Result := TCustomEditBoxSettings;
end;

function TEditBoxModel.GetValue: Single;
begin
  Result := ValueRange.Value;
end;

procedure TEditBoxModel.SetDecimalDigits(const Value: Integer);
begin
  if (FDecimalDigits <> Value) and (Value >= 0) then
  begin
    FDecimalDigits := Value;
    SendMessage(MM_DECIMALDIGITS_CHANGED);
  end;
end;

procedure TEditBoxModel.SetHorzIncrement(const Value: Single);
begin
  if not SameValue(FHorzIncrement, Value) then
  begin
    FHorzIncrement := Value;
    SendMessage<Single>(MM_HORZ_INCREMENT_CHANGED, FHorzIncrement);
  end;
end;

procedure TEditBoxModel.SetValue(const Value: Single);
begin
  ValueRange.Value := Value;
end;

procedure TEditBoxModel.SetValueType(const Value: TNumValueType);
begin
  if FValueType <> Value then
  begin
    FValueType := Value;
    FilterChar := FilterCharByValueType(FValueType);
    SendMessage(MM_VALUETYPE_CHANGED);
  end;
end;

end.
