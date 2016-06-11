{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.ComboTrackBar.Style;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.UITypes, FMX.ComboEdit.Style, FMX.Controls, FMX.StdCtrls, FMX.ComboTrackBar,
  FMX.Controls.Presentation, FMX.Controls.Model;

type

{ TStyledComboTrackBar }

  TStyledComboTrackBar = class(TStyledComboEditBase)
  private
    FPopup: TPopup;
    FTrackBar: TTrackBar;
    FValueChanged: Boolean;
    FTextUpdating: Boolean;
    function GetModel: TComboTrackBarModel;
    procedure UpdateText;
    procedure BeforeChangeProc(Sender: TObject);
    procedure AfterChangeProc(Sender: TObject);
    procedure ClosePopupProc(Sender: TObject);
  protected
    { Messages From Model}
    procedure MMDecimalDigitsChanged(var AMessage: TDispatchMessage); message MM_DECIMALDIGITS_CHANGED;
    procedure MMValueRangeChanged(var AMessage: TDispatchMessage); message MM_VALUERANGE_CHANGED;
    procedure MMValueTypeChanged(var AMessage: TDispatchMessage); message MM_VALUETYPE_CHANGED;
    { Messages From Controller }
    /// <summary>Initializes a presentation</summary>
    procedure PMInit(var AMessage: TDispatchMessage); message PM_INIT;
  protected
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    procedure Change; override;
    procedure SetText(const AValue: string); override;
    { Actions }
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); override;
    procedure DoAbsoluteChanged; override;
    procedure DoActionClientChanged; override;
    /// <summary>Defines <c>TComboTrackBar</c> model class</summary>
    function DefineModelClass: TDataModelClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    function CanDropDown(const AButton: TMouseButton; const AShift: TShiftState): Boolean; override;
    procedure DropDown; override;
    procedure CloseDropDown; override;
    property Model: TComboTrackBarModel read GetModel;
    property TrackBar: TTrackBar read FTrackBar write FTrackBar;
  end;

implementation

uses
  System.Types, System.SysUtils, System.Math, FMX.Types, FMX.StdActns, FMX.Presentation.Factory, FMX.Text, FMX.Forms,
  FMX.Presentation.Style;

{ TStyledComboTrackBar }

procedure TStyledComboTrackBar.ActionChange(Sender: TBasicAction; CheckDefaults: Boolean);
begin
  inherited;
  if (Sender is TCustomValueRangeAction) and (FTrackBar <> nil) then
    FTrackBar.Action := TCustomValueRangeAction(Action)
  else
    FTrackBar.Action := nil;
end;

procedure TStyledComboTrackBar.AfterChangeProc(Sender: TObject);
begin
  if FValueChanged then
  begin
    Model.DisableNotify;
    try
      Model.ValueRange.Assign(TrackBar.ValueRange);
      if FTextUpdating then
        Change
      else
      begin
        FTextUpdating := True;
        try
          Text := Model.GetValueAsString;
          Change;
        finally
          FTextUpdating := False;
        end;
        Model.SelStart := 0;
        Model.SelLength := 0;
      end;
    finally
      Model.EnableNotify;
    end;
    FValueChanged := False;
  end;
end;

procedure TStyledComboTrackBar.BeforeChangeProc(Sender: TObject);
var
  Sigma: Single;
begin
  if Sender is TCustomValueRange then
  begin
    Sigma := Power(10, -Model.DecimalDigits) / 2;
    if not SameValue(TCustomValueRange(Sender).New.Value, TCustomValueRange(Sender).Value, Sigma) then
      FValueChanged := True;
  end;
end;

function TStyledComboTrackBar.CanDropDown(const AButton: TMouseButton; const AShift: TShiftState): Boolean;
begin
  Result := inherited and not Model.ReadOnly;
end;

procedure TStyledComboTrackBar.Change;
var
  TempValue: Single;
begin
  if not FTextUpdating then
  begin
    FTextUpdating := True;
    try
      if TryTextToValue(Text, TempValue, Model.Value) then
        Model.ValueRange.Value := TempValue
      else
        Text := Model.ConvertValueToText(TempValue);
    finally
      FTextUpdating := False;
    end;
  end;
  inherited;
end;

constructor TStyledComboTrackBar.Create(AOwner: TComponent);
const
  PopupPadding: TRectF = (Left: 5; Top: 2; Right: 5; Bottom: 2);
begin
  inherited;
  FPopup := TPopup.Create(Self);
  FPopup.StyleLookup := 'combopopupstyle'; // do not localize
  FPopup.PlacementTarget := Self;
  FPopup.Stored := False;
  FPopup.Parent := Self;
  FPopup.Locked := True;
  FPopup.Padding.Rect := PopupPadding;
  FPopup.OnClosePopup := ClosePopupProc;
  FPopup.DragWithParent := True;
  FTrackBar := TTrackBar.Create(Self);
  FTrackBar.Parent := FPopup;
  FTrackBar.Stored := False;
  FTrackBar.DisableFocusEffect := True;
  FTrackBar.Align := TAlignLayout.VertCenter;
  FTrackBar.ValueRange.BeforeChange := BeforeChangeProc;
  FTrackBar.ValueRange.AfterChange := AfterChangeProc;
end;

function TStyledComboTrackBar.DefineModelClass: TDataModelClass;
begin
  Result := TComboTrackBarModel;
end;

procedure TStyledComboTrackBar.DoAbsoluteChanged;
begin
  inherited;
  if FPopup.IsOpen and (not AbsoluteEnabled or not ParentedVisible or AbsoluteClipRect.IsEmpty) then
    CloseDropDown;
end;

procedure TStyledComboTrackBar.DoActionClientChanged;
begin
  inherited;
  if not Edit.ActionClient and (FTrackBar <> nil) then
    FTrackBar.Action := nil;
end;

procedure TStyledComboTrackBar.ClosePopupProc(Sender: TObject);
begin
  Model.Caret.Visible := Model.InputSupport;
  Edit.SelectAll;
end;

procedure TStyledComboTrackBar.DoEnter;
begin
  if FPopup.IsOpen then
    CloseDropDown;
  inherited;
end;

procedure TStyledComboTrackBar.DoExit;
begin
  Change; // Text already has the current value

  inherited;

  Model.DisableNotify;
  try
    Model.SelStart := 0;
    Model.SelLength := 0;
  finally
    Model.EnableNotify;
  end;
end;

procedure TStyledComboTrackBar.DropDown;
const
  MinDropDownWidth = 100;
  PopupHeight = 30;
begin
  if not FPopup.IsOpen then
  begin
    Model.Caret.Visible := False;
    if Pressed or DoubleClick then
      FPopup.PreferedDisplayIndex := Screen.DisplayFromPoint(Screen.MousePos).Index
    else
      FPopup.PreferedDisplayIndex := -1;
    FPopup.Placement := Model.Placement;
    if Width < MinDropDownWidth then
      FPopup.Width := MinDropDownWidth
    else
     FPopup.Width := Width;
    FPopup.Height := PopupHeight;
    FTrackBar.ApplyStyleLookup;
    FTrackBar.Enabled := not Model.ReadOnly;
    FPopup.IsOpen := True;
    Model.DroppedDown := True;
  end
  else
    CloseDropDown;
end;

procedure TStyledComboTrackBar.CloseDropDown;
begin
  if FPopup.IsOpen then
  begin
    FPopup.IsOpen := False;
    Model.DroppedDown := False;
  end;
end;

function TStyledComboTrackBar.GetModel: TComboTrackBarModel;
begin
  Result := inherited GetModel<TComboTrackBarModel>;
end;

procedure TStyledComboTrackBar.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
var
  Delta: Single;
begin
  if Key = vkReturn then
  begin
    Change;
    Text := Model.GetValueAsString;
    Edit.SelectAll;
    Key := 0;
    Exit;
  end;
  inherited;
  Delta := Model.ValueRange.Frequency;
  if Delta <= 0 then
    Delta := 1;
  FTrackBar.ValueRange.Increment := Delta;
  case Key of
    vkUp: FTrackBar.ValueRange.Inc;
    vkDown: FTrackBar.ValueRange.Dec;
  else
    Exit;
  end;
  Key := 0;
end;

procedure TStyledComboTrackBar.MMDecimalDigitsChanged(var AMessage: TDispatchMessage);
begin
  UpdateText;
end;

procedure TStyledComboTrackBar.PMInit(var AMessage: TDispatchMessage);
begin
  FTrackBar.ValueRange.Assign(Model.ValueRange);
  UpdateText;
end;

procedure TStyledComboTrackBar.MMValueRangeChanged(var AMessage: TDispatchMessage);
begin
  FTrackBar.ValueRange.Assign(Model.ValueRange);
  Model.Change; // This model has as delegate the edit control, so if the track triggers, a model notification is needed
end;

procedure TStyledComboTrackBar.MMValueTypeChanged(var AMessage: TDispatchMessage);
begin
  UpdateText;
end;

procedure TStyledComboTrackBar.SetText(const AValue: string);
var
  TempValue: Single;
begin
  if AValue <> Text then
  begin
    if not FTextUpdating then
    begin
      FTextUpdating := True;
      try
        if TryTextToValue(AValue, TempValue, Model.Value) then
          Model.ValueRange.Value := TempValue;
        if csDesigning in ComponentState then
          inherited SetText(Model.ConvertValueToText(Model.Value))
        else
          inherited;
        Repaint;
      finally
        FTextUpdating := False;
      end;
    end
    else
      inherited;
  end;
end;

procedure TStyledComboTrackBar.UpdateText;
begin
  if TextService <> nil then
  begin
    TextService.Text := Model.ConvertValueToText(Model.Value);
    RepaintEdit;
  end;
end;

initialization
  TPresentationProxyFactory.Current.Register(TComboTrackBar, TControlType.Styled, TStyledPresentationProxy<TStyledComboTrackBar>);
finalization
  TPresentationProxyFactory.Current.Unregister(TComboTrackBar, TControlType.Styled, TStyledPresentationProxy<TStyledComboTrackBar>);
end.
