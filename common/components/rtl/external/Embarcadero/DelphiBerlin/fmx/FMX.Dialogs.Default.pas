{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Dialogs.Default;

interface

{$SCOPEDENUMS ON}

uses
  FMX.Dialogs;

function DefaultInputQuery(const ACaption: string; const APrompts: array of string; var AValues: array of string;
  CloseQueryFunc: TInputCloseQueryFunc): Boolean;

implementation

uses
  System.Classes, System.Types, System.SysUtils, System.Math, System.UITypes, FMX.Graphics, FMX.Forms, FMX.Types,
  FMX.StdCtrls, FMX.Layouts, FMX.Edit, FMX.Consts, FMX.TextLayout;

type
  TInputQueryForm = class(TForm)
  public
    FCloseQueryFunc: TFunc<Boolean>;
    function CloseQuery: Boolean; override;
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
  end;

function TInputQueryForm.CloseQuery: Boolean;
begin
  Result := (ModalResult = mrCancel) or (not Assigned(FCloseQueryFunc)) or FCloseQueryFunc();
end;

procedure TInputQueryForm.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = vkEscape then
  begin
    ModalResult := mrCancel;
    Close;
  end;
end;

function DefaultInputQuery(const ACaption: string; const APrompts: array of string; var AValues: array of string;
  CloseQueryFunc: TInputCloseQueryFunc): Boolean;
var
  I: Integer;
  Form: TInputQueryForm;
  Prompt: TLabel;
  Edit: TEdit;
  Button: TButton;
  Layout: TLayout;
  Box: TScrollBox;
  DialogUnits, BorderSize: TPoint;
  PromptCount, EditWidth, MaxPromptWidth, TotalHeight, ButtonWidth, ButtonHeight: Integer;
  WorkArea: TRect;
  Edits: TArray<TCustomEdit>;
  TmpLabel: TLabel;

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
    if (Length(ACaption) > 1) and (ACaption.Chars[0] < #32) then
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
      Result := Ceil(Max(Result, Canvas.TextWidth(GetPromptCaption(APrompts[I])) + DialogUnits.X));
  end;

  function GetPasswordChar(const ACaption: string): WideChar;
  begin
    if (Length(ACaption) > 1) and (ACaption[1] < #32) then
      Result := '*'
    else
      Result := #0;
  end;

  function CreateLayout(const AAlign: TAlignLayout; AParent: TFmxObject): TLayout;
  begin
    Result := TLayout.Create(Form);
    Result.Margins.Rect := TRectF.Create(BorderSize.X, BorderSize.Y div 2, BorderSize.X, BorderSize.Y div 2);
    Result.Align := AAlign;
    Result.Position.Y := TTextLayout.MaxLayoutSize.Y;
    Result.Height := ButtonHeight;
    Result.Parent := AParent;
  end;

  function CreateButton(AText: string; AModalResult: TModalResult): TButton;
  begin
    Result := TButton.Create(Form);
    Result.Width := ButtonWidth;
    Result.Margins.Left := BorderSize.X;
    Result.Align := TAlignLayout.Right;
    Result.Parent := Layout;
    Result.Position.X := WorkArea.Width;
    Result.Text := AText;
    Result.ModalResult := AModalResult;
  end;

begin
  if Length(AValues) < Length(APrompts) then
    raise EInvalidOperation.Create(SPromptArrayTooShort);
  PromptCount := Length(APrompts);
  if PromptCount < 1 then
    raise EInvalidOperation.Create(SPromptArrayEmpty);
  if Screen.ActiveForm <> nil then
    WorkArea := Screen.DisplayFromForm(Screen.ActiveForm).WorkArea
  else if Application.MainForm <> nil then
    WorkArea := Screen.DisplayFromForm(Application.MainForm).WorkArea
  else
    WorkArea := Screen.WorkAreaRect;
  Form := TInputQueryForm.CreateNew(Application);
  try
    Form.OnKeyDown := Form.FormKeyDown;
    Form.FCloseQueryFunc :=
      function: Boolean
      var
        I: Integer;
        LValues: array of string;
      begin
        Result := True;
        if Assigned(CloseQueryFunc) then
        begin
          SetLength(LValues, PromptCount);
          for I := Low(Edits) to High(Edits) do
            LValues[I] := Edits[I].Text;
          Result := CloseQueryFunc(LValues);
        end;
      end;

    DialogUnits := GetAveCharSize(Form.Canvas);
    BorderSize.X := DialogUnits.X * 2;
    BorderSize.Y := DialogUnits.Y;
    EditWidth := DialogUnits.X * 20;
    ButtonWidth := DialogUnits.X * 12;
    ButtonHeight := (DialogUnits.Y * 3) div 2;
    TmpLabel := TLabel.Create(nil);
    try
      TmpLabel.Parent := Form;
      TmpLabel.ApplyStyleLookup;
      if Form.Canvas.BeginScene then
      try
        Form.Canvas.Font.Assign(TmpLabel.ResultingTextSettings.Font);
        MaxPromptWidth := GetMaxPromptWidth(Form.Canvas);
      finally
        Form.Canvas.EndScene;
      end
      else
        MaxPromptWidth := GetMaxPromptWidth(Form.Canvas);
    finally
      TmpLabel.Free;
    end;
    Form.BorderStyle := TFmxFormBorderStyle.Single;
    Form.BorderIcons := [TBorderIcon.biSystemMenu];
    Form.Caption := ACaption;
    Form.ClientWidth := Max((ButtonWidth + BorderSize.X) * 2, Min(Round(WorkArea.Width * 3 / 4),
      MaxPromptWidth + EditWidth + 2 * BorderSize.X));
    Form.Position := TFormPosition.Designed;
    Box := TScrollBox.Create(Form);
    Box.Align := TAlignLayout.Client;
    Box.Parent := Form;
    Box.BeginUpdate;
    try
      TotalHeight := 0;
      for I := 0 to PromptCount - 1 do
      begin
        Layout := CreateLayout(TAlignLayout.Top, Box);
        if I = 0 then
          Layout.Margins.Top := BorderSize.Y
        else
          Layout.Margins.Top := 0;
        Edit := TEdit.Create(Form);
        Edit.Parent := Layout;
        Edit.Password := GetPasswordChar(APrompts[I]) <> #0;
        Edit.ApplyStyleLookup;
        Edit.Width := EditWidth;
        Edit.MaxLength := 255;
        Edit.VertTextAlign := TTextAlign.Leading;
        Edit.Text := AValues[I];
        Edit.SelectAll;
        SetLength(Edits, Length(Edits) + 1);
        Edits[Length(Edits) - 1] := Edit;

        Layout.Height := Edit.Height;
        Edit.Align := TAlignLayout.Right;
        Prompt := TLabel.Create(Form);
        Prompt.Margins.Top := Edit.TextContentRect.Top;
        Prompt.Text := GetPromptCaption(APrompts[I]);
        Prompt.TextAlign := TTextAlign.Leading;
        Prompt.VertTextAlign := TTextAlign.Leading;
        Prompt.Align := TAlignLayout.Client;
        Prompt.VertTextAlign := TTextAlign.Leading;
        Prompt.TextSettings.Trimming := TTextTrimming.Character;
        Prompt.WordWrap := False;
        Prompt.Parent := Layout;
        if I = 0 then
          Form.ActiveControl := Edit;
        Inc(TotalHeight, Round(Layout.Margins.MarginRect(Layout.BoundsRect).Height));
      end;
    finally
      Box.EndUpdate;
    end;
    Layout := CreateLayout(TAlignLayout.Bottom, Form);
    Layout.Margins.Bottom := BorderSize.Y;
    Button := CreateButton(SMsgDlgOK, mrOk);
    Button.Default := True;
    Button := CreateButton(SMsgDlgCancel, mrCancel);
    Button.Default := True;
    Form.ClientHeight := Min((WorkArea.Height * 5) div 6, Trunc(TotalHeight +
      Layout.Margins.MarginRect(Layout.BoundsRect).Height));
    Form.Left := WorkArea.Left + (WorkArea.Width - Form.ClientWidth) div 2;
    Form.Top := WorkArea.Top + (WorkArea.Height - Form.ClientHeight) div 2;
    Result := Form.ShowModal = mrOk;
    if Result then
      for I := Low(Edits) to High(Edits) do
        AValues[I] := Edits[I].Text;
  finally
    Form.DisposeOf;
  end;
end;

end.
