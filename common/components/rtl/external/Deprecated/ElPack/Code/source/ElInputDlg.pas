{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

(*

Version History

02/27/2003

  Added PasswordChar property

02/25/2003

  Added UseXPThemes property

12/06/2002

  The dialog was remade to accomodate to prompt size

06/05/2002

  Added Position property.

04/16/2002

  The dialog made Unicode.

*)

unit ElInputDlg;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Consts,
  ElBtnCtl,
  ElCheckCtl,
  ElHTMLLbl,
  ElACtrls,
  ElPanel,
  ElEdits,
  HTMLRender,
  ElVCLUtils,
  ExtCtrls,
  ElStrUtils,
  ElCaption,
{$ifdef VCL_6_USED}
  Types,
{$endif}
{$ifdef ELPACK_USE_STYLEMANAGER}
  ElStyleMan,
{$endif}
  ElPopBtn;

type

  TElInputDialog = class(TComponent)
  private
    FOnImageNeeded: TElHTMLImageNeededEvent;
    FOnLinkClick: TElHTMLLinkClickEvent;
  protected
    FPrompt: TElFString;
    FCaption: TElFString;
    FIsHTML: Boolean;
    FValue: TElFString;
    FFont: TFont;
    FParentFont: Boolean;
    FPosition : TPosition;
    {$IFDEF ELPACK_USE_STYLEMANAGER}
    FStyleManager: TElStyleManager;
    FStyleName: string;
    {$endif}
    FUseXPThemes: Boolean;
    FPasswordChar: TElFString;
    {$ifdef ELPACK_USE_STYLEMANAGER}
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    {$endif}
    procedure SetFont(Value: TFont);
    procedure SetParentFont(Value: Boolean);
    procedure FontChange(Sender : TObject);
  public
    function Execute: Boolean;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    {$ifdef ELPACK_USE_STYLEMANAGER}
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    {$endif}
    property Prompt: TElFString read FPrompt write FPrompt;
    property Caption: TElFString read FCaption write FCaption;
    property IsHTML: Boolean read FIsHTML write FIsHTML;
    property Position : TPosition read FPosition write FPosition;
    property Value: TElFString read FValue write FValue;
    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write
        FOnImageNeeded;
    property OnLinkClick: TElHTMLLinkClickEvent read FOnLinkClick write
        FOnLinkClick;
    property Font: TFont read FFont write SetFont;
    property ParentFont: Boolean read FParentFont write SetParentFont default true;
    property UseXPThemes: Boolean read FUseXPThemes write FUseXPThemes default true;
    property PasswordChar: TElFString read FPasswordChar write FPasswordChar;
  end;

function InputQuery(const ACaption, APrompt: TElFString; var AValue: TElFString;
    AIsHTML : boolean): Boolean;

type TInputDlgClass = class of TForm;

{$ifdef VCL_6_USED}
var
{$else}
const
{$endif}
InputDlgClass : TInputDlgClass = TForm;

implementation

uses ElList, ElTools;

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

function InputQuery(const ACaption, APrompt: TElFString; var AValue: TElFString;
    AIsHTML : boolean): Boolean;
begin
  with TElInputDialog.Create(nil) do
  try
    Caption := ACaption;
    Prompt := APrompt;
    Value := AValue;
    IsHTML := AIsHTML;
    result := Execute;
    if Result then
      AValue := Value;
  finally
    Free;
  end;
end;

function TElInputDialog.Execute: Boolean;
var
  Form: TForm;
  APanel: TElPanel;
  Prompt: TElHTMLLabel;
  Edit: TElEdit;
  DialogUnits: TPoint;
  FFormCaption : TElFormCaption;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := InputDlgClass.Create(Application);
  with Form do
    try
      Font := Self.Font;

      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := FCaption;
      Position := poScreenCenter;

      APanel := TElPanel.Create(Form);
      APanel.Parent := Form;
      APanel.Align := alClient;
      APanel.BevelOuter := bvNone;
      {$ifdef ELPACK_USE_STYLEMANAGER}
      APanel.StyleManager := Self.StyleManager;
      APanel.StyleName := Self.StyleName;
      {$endif}
      APanel.UseXPThemes := Self.UseXPThemes;

      FFormCaption := TElFormCaption.Create(Form);
      FFormCaption.Texts.Add.Caption := FCaption;
      FFormCaption.Active := TRUE;
      FFormCaption.BackgroundType := bgtColorFill;
      FFormCaption.ActiveLeftColor := clActiveCaption;
      FFormCaption.ActiveRightColor := clActiveCaption;
      FFormCaption.InActiveLeftColor := clInActiveCaption;
      FFormCaption.InActiveRightColor := clInActiveCaption;
      {$ifdef ELPACK_USE_STYLEMANAGER}
      FFormCaption.StyleManager := Self.StyleManager;
      FFormCaption.StyleName := Self.StyleName;
      {$endif}
      FFormCaption.UseXPThemes := Self.UseXPThemes;

      Prompt := TElHTMLLabel.Create(Form);
      Prompt.IsHTML := IsHTML;
      Prompt.OnLinkClick := FOnLinkClick;
      Prompt.OnImageNeeded := FOnImageNeeded;
      Prompt.Transparent := true;
      {$ifdef ELPACK_USE_STYLEMANAGER}
      Prompt.StyleManager := Self.StyleManager;
      Prompt.StyleName := Self.StyleName;
      {$endif}
      Prompt.UseXPThemes := Self.UseXPThemes;
      with Prompt do
      begin
        Parent := APanel;
        AutoSize := True;
        WordWrap := false;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(4, DialogUnits.Y, 8);
        Caption := FPrompt;
      end;
      Edit := TElEdit.Create(Form);
      {$ifdef ELPACK_USE_STYLEMANAGER}
      Edit.StyleManager := Self.StyleManager;
      Edit.StyleName := Self.StyleName;
      {$endif}
      Edit.UseXPThemes := Self.UseXPThemes;
      Edit.PasswordChar := PasswordChar;
      with Edit do
      begin
        Parent := APanel;
        Left := Prompt.Left;
        Top := MulDiv(8, DialogUnits.Y, 8) + Prompt.Height;
        Width := Max(MulDiv(164, DialogUnits.X, 4), Prompt.Width);
        MaxLength := 255;
        Text := Value;
        SelectAll;
        InactiveBorderType := fbtSunkenOuter;
        ActiveBorderType := fbtSunken;
        Flat := true;
        TabStop := true;
        TabOrder := 0;
      end;
      ClientWidth := Max(MulDiv(180, DialogUnits.X, 4), Prompt.Width + MulDiv(16, DialogUnits.X, 4));

      ClientHeight := Prompt.Height + MulDiv(8 * 4 + 12, DialogUnits.Y, 8);
      ButtonTop := Prompt.Height + Edit.Height + MulDiv(12, DialogUnits.Y, 8);

      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(16, DialogUnits.Y, 8);
      with TElPopupButton.Create(Form) do
      begin
        Parent := APanel;
        Caption := SMsgDlgOK;
        ModalResult := mrOk;
        Default := True;
        SetBounds((Form.ClientWidth - (ButtonWidth * 2 + MulDiv(4, DialogUnits.X, 4))) div 2, ButtonTop, ButtonWidth,
          ButtonHeight);
        TabStop := true;
        TabOrder := 1;
        {$ifdef ELPACK_USE_STYLEMANAGER}
        StyleManager := Self.StyleManager;
        StyleName := Self.StyleName;
        {$endif}
        UseXPThemes := Self.UseXPThemes;
      end;
      with TElPopupButton.Create(Form) do
      begin
        Parent := APanel;
        Caption := SMsgDlgCancel;
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds((Form.ClientWidth + (ButtonWidth * 2 + MulDiv(4, DialogUnits.X, 4))) div 2 - ButtonWidth, ButtonTop, ButtonWidth,
          ButtonHeight);
        TabStop := true;
        TabOrder := 2;
        {$ifdef ELPACK_USE_STYLEMANAGER}
        StyleManager := Self.StyleManager;
        StyleName := Self.StyleName;
        {$endif}
        UseXPThemes := Self.UseXPThemes;
      end;

      ActiveControl := Edit;
      Position := Self.Position;

      if ShowModal = mrOk then
      begin
        Value := Edit.Text;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;

procedure TElInputDialog.SetFont(Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
    ParentFont := false;
  end;
end;

procedure TElInputDialog.SetParentFont(Value: Boolean);
var AForm : TForm;
begin
  if FParentFont <> Value then
  begin
    if Value then
    begin
      AForm := GetOwnerForm(Self);
      if AForm <> nil then
        Font := AForm.Font;
      FParentFont := true;
    end
    else
      FParentFont := false;
  end;
end;

{$ifdef ELPACK_USE_STYLEMANAGER}
procedure TElInputDialog.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    {$ifdef VCL_5_USED}
    if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
      FStyleManager.RemoveFreeNotification(Self);
    {$endif}
    FStyleManager := Value;
    if FStyleManager <> nil then
      FStyleManager.FreeNotification(Self);
  end;
end;

procedure TElInputDialog.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
    FStyleName := Value;
end;
{$endif}

constructor TElInputDialog.Create(AOwner : TComponent);
begin
  inherited;
  FFont := TFont.Create;
  FFont.OnChange := FontChange;
  Position := poScreenCenter;
  FUseXPThemes := true;
end;

procedure TElInputDialog.FontChange(Sender : TObject);
begin
  ParentFont := false;
  //if FForm <> nil then
  //  FForm.Font := FFont;
end;

destructor TElInputDialog.Destroy;
begin
  inherited;
  FFont.Free;
end;

end.
