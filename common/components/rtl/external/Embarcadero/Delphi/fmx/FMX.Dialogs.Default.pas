{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Dialogs.Default;

interface

uses
  System.Types, System.Classes, System.UITypes, System.UIConsts,
  FMX.Forms, FMX.Platform, FMX.Types, FMX.Dialogs;

function DefaultInputQuery(const ACaption: string; const APrompts: array of string; var AValues: array of string;
  CloseQueryFunc: TInputCloseQueryFunc): Boolean;

implementation

uses System.Generics.Collections, System.SysUtils, System.Math,
  FMX.StdCtrls, FMX.Edit, FMX.Consts;

type
  TInputQueryForm = class(TForm)
  public
    FCloseQueryFunc: TFunc<Boolean>;
    function CloseQuery: Boolean; override;
  end;

function TInputQueryForm.CloseQuery: Boolean;
begin
  Result := (ModalResult = mrCancel) or (not Assigned(FCloseQueryFunc)) or FCloseQueryFunc();
end;

function DefaultInputQuery(const ACaption: string; const APrompts: array of string; var AValues: array of string;
  CloseQueryFunc: TInputCloseQueryFunc): Boolean;
var
  I, J: Integer;
  Form: TInputQueryForm;
  Prompt: TLabel;
  Edit: TEdit;
  Button: TButton;
  DialogUnits: TPoint;
  PromptCount: Integer;
  MaxPromptWidth, CurPrompt: Integer;
  ButtonTop, ButtonWidth, ButtonHeight: Single;

  function GetAveCharSize(Canvas: TCanvas): TPoint;
  var
    I: Integer;
    Buffer: string;
  begin
    SetLength(Buffer, 52);
    for I := 1 to 26 do
      Buffer[I] := Chr((I - 1) + Ord('A'));
    for I := 27 to 52 do
      Buffer[I] := Chr((I - 27) + Ord('a'));
    Result := Point(Round(Canvas.TextWidth(Buffer)), Round(Canvas.TextHeight(Buffer)));
    Result.X := Round(Result.X / 52);
  end;

  function GetPromptCaption(const ACaption: string): string;
  begin
    if (Length(ACaption) > 1) and (ACaption[1] < #32) then
      Result := Copy(ACaption, 2, MaxInt)
    else
      Result := ACaption;
  end;

  function GetMaxPromptWidth(Canvas: TCanvas): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := 0 to PromptCount - 1 do
      Result := Round(Max(Result, Canvas.TextWidth(GetPromptCaption(APrompts[I])) + DialogUnits.X));
  end;

  function GetPasswordChar(const ACaption: string): WideChar;
  begin
    if (Length(ACaption) > 1) and (ACaption[1] < #32) then
      Result := '*'
    else
      Result := #0;
  end;

begin
  if Length(AValues) < Length(APrompts) then
    raise EInvalidOperation.Create(SPromptArrayTooShort);
  PromptCount := Length(APrompts);
  if PromptCount < 1 then
    raise EInvalidOperation.Create(SPromptArrayEmpty);
  Result := False;
  Form := TInputQueryForm.CreateNew(Application);
  try
    Form.FCloseQueryFunc :=
      function: Boolean
      var
        I, J: Integer;
        LValues: array of string;
        Control: TFmxObject;
      begin
        Result := True;
        if Assigned(CloseQueryFunc) then
        begin
          SetLength(LValues, PromptCount);
          J := 0;
          for I := 0 to Form.ChildrenCount - 1 do
          begin
            Control := Form.Children[I];
            if Control is TEdit then
            begin
              LValues[J] := TEdit(Control).Text;
              Inc(J);
            end;
          end;
          Result := CloseQueryFunc(LValues);
        end;
      end;
//    Form.Canvas.Font.As := Form.Font;
    DialogUnits := GetAveCharSize(Form.Canvas);
    MaxPromptWidth := GetMaxPromptWidth(Form.Canvas);
    Form.BorderStyle := TFmxFormBorderStyle.bsSingle;
    Form.BorderIcons := [TBorderIcon.biSystemMenu];
    Form.Caption := ACaption;
    Form.ClientWidth := (180 + MaxPromptWidth) * DialogUnits.X div 4;
//    Form.PopupMode := pmAuto;
    Form.Position := TFormPosition.poScreenCenter;
    CurPrompt := 8 * DialogUnits.Y div 8;
    Edit := nil;
    for I := 0 to PromptCount - 1 do
    begin
      Prompt := TLabel.Create(Form);
      Prompt.Parent := Form;
      Prompt.Text := GetPromptCaption(APrompts[I]);
      Prompt.TextAlign := TTextAlign.taLeading;
      Prompt.VertTextAlign := TTextAlign.taLeading;
      Prompt.Position.X := 8 * DialogUnits.X div 4;
      Prompt.Position.Y := CurPrompt;
//      Prompt.Constraints.MaxWidth := MaxPromptWidth;
      Prompt.WordWrap := True;
      Edit := TEdit.Create(Form);
      Edit.Parent := Form;
      Edit.Password := GetPasswordChar(APrompts[I]) <> #0;
      Edit.ApplyStyleLookup;
      Edit.Position.X := Prompt.Position.X + MaxPromptWidth;
      Edit.Position.Y := Prompt.Position.Y - Edit.ContentRect.TopLeft.Y;
      Edit.Width := Form.ClientWidth - Edit.Position.X - (8 * DialogUnits.X / 4);
      Edit.MaxLength := 255;
      Edit.Text := AValues[I];
      Edit.SelectAll;
      Form.ActiveControl := Edit;
      CurPrompt := Round(Prompt.Position.Y + Edit.Height + 5);
    end;
    ButtonTop := Edit.Position.Y + Edit.Height + 15;
    ButtonWidth := 50 * DialogUnits.X div 4;
    ButtonHeight := 14 * DialogUnits.Y div 8;
    Button := TButton.Create(Form);
    Button.Parent := Form;
    Button.Text := SMsgDlgOK;
    Button.ModalResult := mrOk;
    Button.Default := True;
    Button.SetBounds(Form.ClientWidth - (ButtonWidth + (8 * DialogUnits.X div 4)) * 2.0, ButtonTop, ButtonWidth, ButtonHeight);
    Button := TButton.Create(Form);
    Button.Parent := Form;
    Button.Text := SMsgDlgCancel;
    Button.ModalResult := mrCancel;
    Button.Cancel := True;
    Button.SetBounds(Form.ClientWidth - (ButtonWidth + (8 * DialogUnits.X div 4)), ButtonTop, ButtonWidth, ButtonHeight);
    Form.ClientHeight := Trunc(Button.Position.Y + Button.Height + 13);
    if Form.ShowModal = mrOk then
    begin
      J := 0;
      for I := 0 to Form.ChildrenCount - 1 do
        if Form.Children[I] is TEdit then
        begin
          Edit := TEdit(Form.Children[I]);
          AValues[J] := Edit.Text;
          Inc(J);
        end;
      Result := True;
    end;
  finally
    if Assigned(Form) then
      FreeAndNil(Form);
  end;
end;

end.
