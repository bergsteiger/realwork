{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.EditBox.Style;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, FMX.Edit.Style, FMX.EditBox, FMX.Controls.Presentation, FMX.Controls.Model;

type

{ TStyledEditBox }

  TStyledEditBox = class(TStyledEdit)
  private
    function GetModel: TEditBoxModel; overload;
    function GetEditBox: TCustomEditBox;
  protected
    { Messages From Model}
    procedure MMValueTypeChanged(var AMessage: TDispatchMessage); message MM_VALUETYPE_CHANGED;
    procedure MMDecimalDigitsChanged(var AMessage: TDispatchMessage); message MM_DECIMALDIGITS_CHANGED;
    procedure MMValueRangeChanged(var AMessage: TDispatchMessage); message MM_VALUERANGE_CHANGED;
  protected
    procedure KeyDown(var Key: Word; var KeyChar: Char; Shift: TShiftState); override;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;
    /// <summary>Defines <c>TEditBox</c> model class</summary>
    function DefineModelClass: TDataModelClass; override;
  public
    property Model: TEditBoxModel read GetModel;
    property EditBox: TCustomEditBox read GetEditBox;
  end;

implementation

uses
  System.SysUtils, System.UITypes, System.Character, FMX.Presentation.Factory, FMX.Controls, FMX.Presentation.Style;

{ TStyledEditBox }

function TStyledEditBox.DefineModelClass: TDataModelClass;
begin
  Result := TEditBoxModel;
end;

function TStyledEditBox.GetEditBox: TCustomEditBox;
begin
  Result := PresentedControl as TCustomEditBox;
end;

function TStyledEditBox.GetModel: TEditBoxModel;
begin
  Result := inherited GetModel<TEditBoxModel>;
end;

procedure TStyledEditBox.KeyDown(var Key: Word; var KeyChar: Char; Shift: TShiftState);

  function PerformDublicate(const AChars: array of Char): Boolean;
  var
    S: string;
    I: Integer;
  begin
    Result := False;
    if KeyChar.IsInArray(AChars) and (Model.SelLength = 0) then
    begin
      I := Model.SelStart;
      Result := (I > 0) and Text.Chars[I - 1].IsInArray(AChars);
      if not Result and (I < Length(Text)) and Text.Chars[I].IsInArray(AChars) then
      begin
        S := Model.Text;
        S := S.Remove(I, 1);
        S := S.Insert(I, KeyChar);
        Model.Text := S;
        Model.CaretPosition := I + 1;
        Model.SelStart := Model.CaretPosition;
        Result := True;
      end;
    end;
  end;

var
  Handled: Boolean;

begin
  Handled := True;
  case Key of
    vkUp:
      EditBox.ValueInc;
    vkDown:
      EditBox.ValueDec;
    vkEscape:
    begin
      Model.Text := Model.ConvertValueToText;
      Model.CaretPosition := 0;
      Model.SelStart := 0;
      Model.SelLength := Length(Text);
    end;
    vkReturn:
      inherited;
  else
    Handled := PerformDublicate([',', '.', FormatSettings.DecimalSeparator]) or PerformDublicate(['+', '-']);
  end;
  if Handled then
  begin
    KeyChar := #0;
    Key := 0;
  end
  else inherited;
end;

procedure TStyledEditBox.MMDecimalDigitsChanged(var AMessage: TDispatchMessage);
begin
  if TextService <> nil then
  begin
    TextService.Text := Model.ConvertValueToText;
    RepaintEdit;
  end;
end;

procedure TStyledEditBox.MMValueRangeChanged(var AMessage: TDispatchMessage);
begin

end;

procedure TStyledEditBox.MMValueTypeChanged(var AMessage: TDispatchMessage);
begin
  if TextService <> nil then
  begin
    TextService.Text := Model.ConvertValueToText;
    RepaintEdit;
  end;
end;

procedure TStyledEditBox.MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  inherited;
  if WheelDelta > 0 then
    EditBox.ValueInc
  else
    if WheelDelta < 0 then
      EditBox.ValueDec;
  Handled := True;
end;

initialization
  TPresentationProxyFactory.Current.Register(TCustomEditBox, TControlType.Styled, TStyledPresentationProxy<TStyledEditBox>);
finalization
  TPresentationProxyFactory.Current.Unregister(TCustomEditBox, TControlType.Styled, TStyledPresentationProxy<TStyledEditBox>);
end.
