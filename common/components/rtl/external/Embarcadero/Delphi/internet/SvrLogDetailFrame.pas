{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit SvrLogDetailFrame;

interface

uses 
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.StdCtrls, System.IniFiles, Vcl.Menus, Vcl.ActnList, Vcl.StdActns, Vcl.ImgList, System.Win.Registry;

type
  TLogDetailFrame = class(TFrame)
    Memo1: TMemo;
    cbTranslateText: TCheckBox;
    cbWrapText: TCheckBox;
    ActionList1: TActionList;
    ImageList1: TImageList;
    FontEdit1: TFontEdit;
    PopupMenu1: TPopupMenu;
    SelectFont1: TMenuItem;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    N1: TMenuItem;
    Cut1: TMenuItem;
    SelectAll1: TMenuItem;
    procedure cbTranslateTextClick(Sender: TObject);
    procedure cbWrapTextClick(Sender: TObject);
    procedure FontEdit1Accept(Sender: TObject);
  private
    FRawText: string;
    procedure SetText(const Value: string);
    function GetTranslatedText: string;
    procedure UpdateText;
    function GetTranslateText: Boolean;
    procedure SetTranslateText(const Value: Boolean);
    function GetWrapText: Boolean;
    procedure SetWrapText(const Value: Boolean);
    procedure UpdateWrap;
    { Private declarations }
  public
    { Public declarations }
    procedure Load(Reg: TRegIniFile; const Section: string);
    procedure Save(Reg: TRegIniFile; const Section: string);
    procedure Clear;
    property Text: string write SetText;
    property TranslateText: Boolean read GetTranslateText write SetTranslateText;
    property WrapText: Boolean read GetWrapText write SetWrapText;
  end;

implementation

uses SvrHTTPIndy;

{$R *.DFM}

{ TLogDetailFrame }

procedure TLogDetailFrame.Clear;
begin
  Text := '';
end;

function HexToChar(Hi, Lo: Char): Char;
asm
        XOR     ECX,ECX
        CMP     AL,'0'
        JB      @@1
        CMP     AL,'f'
        JA      @@1
        MOV     CL,AL
        MOV     AL,@@0.Byte[ECX-'0']
        CMP     AL,-1
        JE      @@1
        SHL     AL,4
        CMP     DL,'0'
        JB      @@1
        CMP     DL,'f'
        JA      @@1
        MOV     CL,DL
        MOV     AH,@@0.Byte[ECX-'0']
        CMP     AH,-1
        JE      @@1
        OR      AL,AH
        JMP     @@2
@@0:    DB       0, 1, 2, 3, 4, 5, 6, 7, 8, 9,-1,-1,-1,-1,-1,-1
        DB      -1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1
        DB      -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
        DB      -1,10,11,12,13,14,15
@@1:    MOV     AL,20H
@@2:
end;


function TranslateSpecialChars(Value: string): string;
var
  S, P, E: PChar;
begin
  SetString(Result, PChar(Value), Length(Value));
  S := PChar(Result);
  P := S;
  E := P + Length(Value) - 1;
  while P < E do
  begin
    if P^ = '%' then
    begin
      P^ := HexToChar(P[1], P[2]);
      Move(P[3], P[1], E - P - 2);
      Dec(E, 2);
    end;
    if P^ = '+' then
      P^ := ' ';
    Inc(P);
  end;
  SetLength(Result, E - S + 1);
end;

procedure TLogDetailFrame.SetText(const Value: string);
begin
  FRawText := Value;
  UpdateText;
end;

function  TLogDetailFrame.GetTranslatedText: string;
begin
  Result := TranslateSpecialChars(FRawText);
end;

procedure TLogDetailFrame.UpdateText;
begin
  Memo1.WordWrap := WrapText;
  if TranslateText then
    Memo1.Lines.Text := GetTranslatedText
  else
    Memo1.Lines.Text := FRawText;
end;

function TLogDetailFrame.GetTranslateText: Boolean;
begin
  Result := cbTranslateText.Checked;
end;

procedure TLogDetailFrame.SetTranslateText(const Value: Boolean);
begin
  if TranslateText <> Value then
  begin
    cbTranslateText.Checked := Value;
    UpdateText;
  end;
end;

function TLogDetailFrame.GetWrapText: Boolean;
begin
  Result := cbWrapText.Checked;
end;

procedure TLogDetailFrame.SetWrapText(const Value: Boolean);
begin
  if WrapText <> Value then
  begin
    cbWrapText.Checked := Value;
    UpdateWrap;
  end;
end;

procedure TLogDetailFrame.UpdateWrap;
begin
  Memo1.WordWrap := WrapText;
  if WrapText then
    Memo1.ScrollBars := ssVertical
  else
    Memo1.ScrollBars := ssBoth;
end;

procedure TLogDetailFrame.cbTranslateTextClick(Sender: TObject);
begin
  UpdateText;
end;

const
  sTranslateText = 'TranslateText';  // Do not localize
  sWrapText = 'WrapText';            // Do not localize
  sFontName = 'FontName';            // Do not localize
  sFontBold = 'FontBold';            // Do not localize
  sFontItalic = 'FontItalic';        // Do not localize
  sFontStrikeout = 'FontStrikeout';  // Do not localize
  sFontUnderline = 'FontUnderline';  // Do not localize
  sFontPitch = 'FontPitch';          // Do not localize
  sFontColor = 'FontColor';          // Do not localize
  sFontSize = 'FontSize';            // Do not localize

const
  sPitchNames: array[TFontPitch] of string =
    ('Default', 'Variable', 'Fixed');

procedure TLogDetailFrame.Load(Reg: TRegIniFile; const Section: string);
var
  FontName: string;
  FontSize: Integer;
  FontStyle: TFontStyles;
  Font: TFont;
  FontPitch, FP: TFontPitch;
  FontColor: TColor;
  S: string;
begin
  TranslateText := Reg.ReadBool(Section, sTranslateText, TranslateText);
  WrapText := Reg.ReadBool(Section, sWrapText, WrapText);
  FontName := Reg.ReadString(Section, sFontName, '');
  FontStyle := [];
  if FontName <> '' then
  begin
    Font := TFont.Create;
    try
      try
        FontSize := Reg.ReadInteger(Section, sFontSize, Font.Size);
        if Reg.ReadBool(Section, sFontBold, False) then
          Include(FontStyle, fsBold);
        if Reg.ReadBool(Section, sFontItalic, False) then
          Include(FontStyle, fsItalic);
        if Reg.ReadBool(Section, sFontUnderline, False) then
          Include(FontStyle, fsUnderline);
        if Reg.ReadBool(Section, sFontStrikeout, False) then
          Include(FontStyle, fsStrikeout);
        S := Reg.ReadString(Section, sFontPitch, '');
        FontPitch := Font.Pitch;
        for FP := Low(TFontPitch) to High(TFontPitch) do
          if CompareText(S, sPitchNames[FP]) = 0 then
          begin
            FontPitch := FP;
            break;
          end;
        FontColor := TColor(Reg.ReadInteger(Section, sFontColor, Font.Color));

        Font.Name := FontName;
        Font.Style := FontStyle;
        Font.Size := FontSize;
        Font.Pitch := FontPitch;
        Font.Color := FontColor;
      except
        FreeAndNil(Font);
      end;
      if Font <> nil then
        Memo1.Font := Font;
      FontEdit1.Dialog.Font := Memo1.Font;
    finally
      Font.Free;
    end;
  end;
end;

procedure TLogDetailFrame.Save(Reg: TRegIniFile; const Section: string);
var
  Font: TFont;
begin
  Reg.WriteBool(Section, sTranslateText, TranslateText);
  Reg.WriteBool(Section, sWrapText, WrapText);
  Font := Memo1.Font;
  if Font <> nil then
  begin
    Reg.WriteString(Section, sFontName, Font.Name);
    Reg.WriteInteger(Section, sFontSize, Font.Size);
    Reg.WriteBool(Section, sFontBold, fsBold in Font.Style);
    Reg.WriteBool(Section, sFontUnderline, fsUnderline in Font.Style);
    Reg.WriteBool(Section, sFontStrikeout, fsStrikeout in Font.Style);
    Reg.WriteBool(Section, sFontItalic, fsItalic in Font.Style);
    Reg.WriteString(Section, sFontPitch, sPitchNames[Font.Pitch]);
    Reg.WriteInteger(Section, sFontColor, Font.Color);
  end;
end;

procedure TLogDetailFrame.cbWrapTextClick(Sender: TObject);
begin
  UpdateWrap;
end;

procedure TLogDetailFrame.FontEdit1Accept(Sender: TObject);
begin
  Memo1.Font := FontEdit1.Dialog.Font;
end;


end.
