{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                FireDAC GUIx Forms memo                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.VCLUI.Memo;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows, Winapi.Messages, System.Win.Registry,
{$ENDIF}
  System.Classes, Vcl.Controls, Vcl.Graphics, Vcl.StdCtrls
{$IFDEF FireDAC_SynEdit}
  , synedit, synmemo, synhighlightersql, synedithighlighter
{$ENDIF}
  , FireDAC.Stan.Intf;

type
  {----------------------------------------------------------------------------}
  { TFDGUIxFormsMemo                                                           }
  {----------------------------------------------------------------------------}
{$IFDEF FireDAC_SynEdit}
  TFDGUIxFormsMemo = class(TSynMemo)
  private
    function GetCaretPos: TPoint;
    procedure SetCaretPos(const AValue: TPoint);
    function GetRDBMSKind: TFDRDBMSKind;
    procedure SetRDBMSKind(const AValue: TFDRDBMSKind);
  public
    constructor Create(AOwner: TComponent); override;
    property CaretPos: TPoint read GetCaretPos write SetCaretPos;
    property RDBMSKind: TFDRDBMSKind read GetRDBMSKind write SetRDBMSKind;
  end;
{$ELSE}
  TFDGUIxFormsMemo = class(TMemo)
  private
    FRDBMSKind: TFDRDBMSKind;
  public
    constructor Create(AOwner: TComponent); override;
    property RDBMSKind: TFDRDBMSKind read FRDBMSKind write FRDBMSKind;
  end;
{$ENDIF}

implementation

uses
  System.SysUtils, System.TypInfo,
  FireDAC.Stan.Util;

{$IFDEF FireDAC_SynEdit}
{------------------------------------------------------------------------------}
{ TFDGUIxFormsHilighter                                                        }
{------------------------------------------------------------------------------}
type
  TFDGUIxFormsHilighter = class(TSynSQLSyn)
  private
  {$IFDEF MSWINDOWS}
    FReg: TRegistry;
  {$ENDIF}
    FFontName: String;
    FFontSize: Integer;
  {$IFDEF MSWINDOWS}
    function GetEditorKey: String;
    procedure LoadAttr(AAttrs: TSynHighlighterAttributes; const AKind: String);
    procedure LoadSettings;
    function ReadBool(const AIdent: string): Boolean;
  {$ENDIF}
    function GetRDBMSKind: TFDRDBMSKind;
    procedure SetRDBMSKind(const AValue: TFDRDBMSKind);
  public
    constructor Create(AOwner: TComponent); override;
    property RDBMSKind: TFDRDBMSKind read GetRDBMSKind write SetRDBMSKind;
  end;

{------------------------------------------------------------------------------}
constructor TFDGUIxFormsHilighter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF MSWINDOWS}
  FReg := TRegistry.Create;
  try
    FReg.RootKey := HKEY_CURRENT_USER;
    LoadSettings;
  finally
    FDFree(FReg);
  end;
  {$ENDIF}
end;

  {$IFDEF MSWINDOWS}
{------------------------------------------------------------------------------}
function TFDGUIxFormsHilighter.GetEditorKey: String;
begin
  Result := '\SOFTWARE\Embarcadero\BDS\12.0\Editor';
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFormsHilighter.ReadBool(const AIdent: string): Boolean;
const
  C_BoolArr: array [Boolean] of String = ('False', 'True');
begin
  Result := FReg.ReadString(AIdent) = C_BoolArr[True];
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsHilighter.LoadAttr(AAttrs: TSynHighlighterAttributes;
  const AKind: String);
var
  eStyles: TFontStyles;
  s: String;
begin
  if not FReg.OpenKeyReadOnly(GetEditorKey + '\Highlight\' + AKind) then
    Exit;

  if not ReadBool('Default Foreground') then begin
    s := FReg.ReadString('Foreground Color New');
    if s <> '' then
      AAttrs.Foreground := StringToColor(s);
  end;

  if not ReadBool('Default Background') then begin
    s := FReg.ReadString('Background Color New');
    if s <> '' then
      AAttrs.Background := StringToColor(s);
  end;

  eStyles := [];
  if ReadBool('Bold') then
    Include(eStyles, fsBold)
  else
    Exclude(eStyles, fsBold);
  if ReadBool('Italic') then
    Include(eStyles, fsItalic)
  else
    Exclude(eStyles, fsItalic);
  if ReadBool('Underline') then
    Include(eStyles, fsUnderline)
  else
    Exclude(eStyles, fsUnderline);
  AAttrs.Style := eStyles;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsHilighter.LoadSettings;
begin
  if not FReg.OpenKeyReadOnly(GetEditorKey + '\Options') then
    Exit;
  if FReg.ValueExists('Editor Font') then
    FFontName := FReg.ReadString('Editor Font')
  else
    FFontName := 'Courier New';
  if FReg.ValueExists('Font Size') then
    FFontSize := FReg.ReadInteger('Font Size')
  else
    FFontSize := 10;
  LoadAttr(SpaceAttri, 'Whitespace');
  LoadAttr(CommentAttribute, 'Comment');
  LoadAttr(CommentAttri, 'Comment');
  LoadAttr(ConditionalCommentAttri, 'Preprocessor');
  LoadAttr(KeywordAttribute, 'Reserved word');
  LoadAttr(KeyAttri, 'Reserved word');
  LoadAttr(PLSQLAttri, 'Reserved word');
  LoadAttr(SQLPlusAttri, 'Reserved word');
  LoadAttr(FunctionAttri, 'Reserved word');
  LoadAttr(DataTypeAttri, 'Reserved word');
  LoadAttr(NumberAttri, 'Number');
  LoadAttr(StringAttribute, 'String');
  LoadAttr(StringAttri, 'String');
  LoadAttr(SymbolAttribute, 'Symbol');
  LoadAttr(SymbolAttri, 'Symbol');
  LoadAttr(IdentifierAttribute, 'Identifier');
  LoadAttr(IdentifierAttri, 'Identifier');
  LoadAttr(DelimitedIdentifierAttri, 'Identifier');
  LoadAttr(VariableAttri, 'Identifier');
end;
  {$ENDIF}

{------------------------------------------------------------------------------}
function TFDGUIxFormsHilighter.GetRDBMSKind: TFDRDBMSKind;
var
  sSQLDialect: string;
begin
  sSQLDialect := GetEnumName(TypeInfo(TSQLDialect), Ord(SQLDialect));
  if SameText(sSQLDialect, 'sqlInterbase6') then Result := TFDRDBMSKinds.Interbase
  else if SameText(sSQLDialect, 'sqlInterbase6') then Result := TFDRDBMSKinds.Interbase
  else if SameText(sSQLDialect, 'sqlMSSQL7') then Result := TFDRDBMSKinds.MSSQL
  else if SameText(sSQLDialect, 'sqlMySQL') then Result := TFDRDBMSKinds.MySQL
  else if SameText(sSQLDialect, 'sqlOracle') then Result := TFDRDBMSKinds.Oracle
  else if SameText(sSQLDialect, 'sqlSybase') then Result := TFDRDBMSKinds.MSSQL
  else if SameText(sSQLDialect, 'sqlMSSQL2K') then Result := TFDRDBMSKinds.MSSQL
  else if SameText(sSQLDialect, 'sqlPostgres') then Result := TFDRDBMSKinds.PostgreSQL
  else Result := TFDRDBMSKinds.Other;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsHilighter.SetRDBMSKind(const AValue: TFDRDBMSKind);
begin
  case AValue of
    TFDRDBMSKinds.Oracle:      SQLDialect := sqlOracle;
    TFDRDBMSKinds.MSSQL:       SQLDialect := sqlMSSQL2K;
    TFDRDBMSKinds.MySQL:       SQLDialect := sqlMySQL;
    TFDRDBMSKinds.SQLAnywhere: SQLDialect := sqlSybase;
    TFDRDBMSKinds.Interbase:   SQLDialect := sqlInterbase6;
    TFDRDBMSKinds.Firebird:    SQLDialect := sqlInterbase6;
    TFDRDBMSKinds.PostgreSQL:  SQLDialect := sqlPostgres;
    TFDRDBMSKinds.SybaseASE:   SQLDialect := sqlSybase;
    else                       SQLDialect := sqlStandard;
  end;
end;

{------------------------------------------------------------------------------}
{ TFDGUIxFormsMemo                                                             }
{------------------------------------------------------------------------------}
constructor TFDGUIxFormsMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Highlighter := TFDGUIxFormsHilighter.Create(Self);
  if TFDGUIxFormsHilighter(Highlighter).FFontName <> '' then
    Font.Name := TFDGUIxFormsHilighter(Highlighter).FFontName;
  if TFDGUIxFormsHilighter(Highlighter).FFontSize <> 0 then
    Font.Size := TFDGUIxFormsHilighter(Highlighter).FFontSize;
  WordWrap := False;
end;

{------------------------------------------------------------------------------}
function TFDGUIxFormsMemo.GetCaretPos: TPoint;
begin
  Result := Point(CaretX - 1, CaretY - 1);
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsMemo.SetCaretPos(const AValue: TPoint);
begin
  CaretX := AValue.X + 1;
  CaretY := AValue.Y + 1;
end;

{------------------------------------------------------------------------------}
function TFDGUIxFormsMemo.GetRDBMSKind: TFDRDBMSKind;
begin
  Result := TFDGUIxFormsHilighter(Highlighter).RDBMSKind;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsMemo.SetRDBMSKind(const AValue: TFDRDBMSKind);
begin
  TFDGUIxFormsHilighter(Highlighter).RDBMSKind := AValue;
end;

{$ELSE}

{------------------------------------------------------------------------------}
constructor TFDGUIxFormsMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Font.Name := 'Courier New';
  WordWrap := False;
  ScrollBars := ssBoth;
end;

{$ENDIF}

end.
