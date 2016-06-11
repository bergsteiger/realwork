{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Text;

{$MINENUMSIZE 4}

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FMX.Types, FMX.Graphics;

type

{ TTextService }

  TTextService = class
  private
    FOwner: IControl;
    FMultiLine: Boolean;
    FMaxLength: Integer;
  protected
    function GetText: string; virtual; abstract;
    procedure SetText(const Value: string); virtual; abstract;
    function GetCaretPostion: TPoint; virtual; abstract;
    procedure SetCaretPosition(const Value: TPoint); virtual; abstract;
    ///<summary>Holds a reference to the text input control in UI</summary>
    property Owner: IControl read FOwner;
  public
    constructor Create(const Owner: IControl; SupportMultiLine: Boolean); virtual;
    destructor Destroy; override;
    { Text support }
    procedure InternalSetMarkedText(const AMarkedText: string); virtual; abstract;
    function InternalGetMarkedText: string; virtual; abstract;
    function CombinedText: string; virtual; abstract;
    function TargetClausePosition: TPoint; virtual; abstract;
    function HasMarkedText: boolean; virtual; abstract;
    { Enter/Exit }
    procedure EnterControl(const FormHandle: TWindowHandle); virtual; abstract;
    procedure ExitControl(const FormHandle: TWindowHandle); virtual; abstract;
    { Drawing Lines }
    procedure DrawSingleLine(const Canvas: TCanvas;
      const ARect: TRectF; const FirstVisibleChar: integer; const Font: TFont;
      const AOpacity: Single; const Flags: TFillTextFlags; const ATextAlign: TTextAlign;
      const AVTextAlign: TTextAlign = TTextAlign.Center;
      const AWordWrap: Boolean = False); overload; virtual; abstract;
    procedure DrawSingleLine(const Canvas: TCanvas; const S: string;
      const ARect: TRectF; const Font: TFont;
      const AOpacity: Single; const Flags: TFillTextFlags; const ATextAlign: TTextAlign;
      const AVTextAlign: TTextAlign = TTextAlign.Center;
      const AWordWrap: Boolean = False); overload; virtual; abstract;
    { IME Mode }
    function GetImeMode: TImeMode; virtual; abstract;
    procedure SetImeMode(const Value: TImeMode); virtual; abstract;
    { Selection }
    procedure BeginSelection; virtual;
    procedure EndSelection; virtual;
    property CaretPosition: TPoint read GetCaretPostion write SetCaretPosition;
    property Text: string read GetText write SetText;
    property ImeMode: TImeMode read GetImeMode write SetImeMode default TImeMode.imDontCare;
    ///<summary>Defines the maximum text of the text that could inputed via text service</summary>
    property MaxLength: Integer read FMaxLength write FMaxLength;
    ///<summary>Defines wherever input control allows to input several lines on text or just a single one.</summary>
    property Multiline: Boolean read FMultiLine;
  end;

  TTextServiceClass = class of TTextService;

{ TTextWordWrapping }

  ///<summary>Manage text line counting and line retrieving for a given width in a canvas.</summary>
  TTextWordWrapping = class
  public
    ///<summary>Fills ALinesFound with the text that fits on a certain Width (AMaxWidth). Also fills the real maximum
    ///with found</summary>
    class procedure GetLines(const AText: String; const ACanvas: TCanvas; const AMaxWidth: Integer;
      var ALinesFound: TStringList; var AResWidth: Integer);
    ///<summary>Computes the number of lines needed to draw the text supplied for a certain Width (AMaxWidth). Also
    ///fills the real maximum with found.</summary>
    class function ComputeLineCount(const AText: String; const ACanvas: TCanvas; const AMaxWidth: Integer;
      var AResWidth: Integer): Integer;
  end;

{ ITextInput }

  ITextInput = interface
    ['{56D79E74-58D6-4c1e-B832-F133D669B952}']
    function GetTextService: TTextService;
    { IME }
    function GetTargetClausePointF: TPointF;
    procedure StartIMEInput;
    procedure EndIMEInput;
    ///<summary>Platform using this method to notify control that either text or caret position was changed</summary>
    procedure IMEStateUpdated;
    { Selection }
    function GetSelection: string;
    function GetSelectionRect: TRectF;
    function GetSelectionBounds: TRect;
    { Text }
    function HasText: Boolean;
  end;

{ ITextSpellCheck }

  ITextSpellCheck = interface
    ['{30AA8C32-5ADA-456C-AAC5-B9F0309AE3A8}']
    { common }
    function IsSpellCheckEnabled: Boolean;
    function IsCurrentWordWrong: Boolean;
    function GetListOfPrepositions: TArray<string>;
    { Spell check }
    procedure HighlightSpell;
    procedure HideHighlightSpell;
    { auto correction }
  end;

{ ITextActions }

  { Standard actions for operation with the text. Objects which want to get
    support of actions in a shortcut menu shall implement this interface }
  ITextActions = interface
    ['{9DB49126-36DB-4193-AE96-C0BD27090DCD}']
    procedure DeleteSelection;
    procedure CopyToClipboard;
    procedure CutToClipboard;
    procedure PasteFromClipboard;
    procedure SelectAll;
    procedure SelectWord;
    procedure ResetSelection;
    procedure GoToTextEnd;
    procedure GoToTextBegin;
    procedure Replace(const AStartPos: Integer; const ALength: Integer; const AStr: string);
  end;

{ ITextSpellCheckActions }

  ITextSpellCheckActions = interface
    ['{82A33171-C825-4B7F-B0C4-A56DDD4FF85C}']
    procedure Spell(const AWord: string);
  end;

  { Search of boundaries of the word in the text since |Index|
    Returns an index of the left |BeginPos| and right |EndPos| boundary of the found word
      |Text| - Source text
      |Index| - Index of carriage position
      |BeginPos| - Index of carriage position
      |EndPos| - Index of carriage position
    Position of the carriage begins with 0. 0 specifies position of the carriage to the first character }
  function FindWordBound(const Text: string; Index: Integer; out BeginPos, EndPos: Integer): Boolean;
  function GetLexemeBegin(const Text: string; Index: Integer): Integer;
  function GetLexemeEnd(const Text: string; Index: Integer): Integer;
  function GetNextLexemeBegin(const Text: string; Index: Integer): Integer;
  function GetPrevLexemeBegin(const Text: string; Index: Integer): Integer;
  function TruncateText(const Text: string; const MaxLength: Integer): string;
  /// <summary>Removes from the source string Input all characters that are not
  /// in the Filter string.</summary>
  function FilterText(const Input: string; const Filter: string): string;

type
  TNumValueType = (Integer, Float);

  TNumValueTypeHelper = record helper for TNumValueType
  const
    vtInteger = TNumValueType.Integer deprecated 'Use TNumValueType.Integer';
    vtFloat = TNumValueType.Float deprecated 'Use TNumValueType.Float';
  end;

  TValidateTextEvent = procedure(Sender: TObject; var Text: string) of object;

  function FilterCharByValueType(const AValueType: TNumValueType): string;
  function TryTextToValue(AText: string; var AValue: Single; DefaultValue: Single): Boolean;

implementation

uses
  System.SysUtils, System.Math, System.Character, System.RegularExpressions;

type
  TTextWordWrappingImpl = class
  strict private
    class var FRegExpr: TRegEx;
    class var FRegExprSpace: TRegEx;
  public
    class constructor Create;
    class procedure GetWords(const AText: String; var AWordsFound: TStringList);
    class function GetLines(const AText: String; const ACanvas: TCanvas; const AMaxWidth: Integer;
      var ALinesFound: TStringList; var AResWidth: Single): Integer;
end;

{ TTextService }

constructor TTextService.Create(const Owner: IControl; SupportMultiLine: Boolean);
var
  P : TPoint;
begin
  inherited Create;
  FOwner := Owner;
  FMultiLine := SupportMultiLine;
  P.X := 0; P.Y := 0;
  CaretPosition := P;
end;

destructor TTextService.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

procedure TTextService.EndSelection;
begin
  // Nothing
end;

procedure TTextService.BeginSelection;
begin
  // Nothing
end;

function FindWordBound(const Text: string; Index: Integer; out BeginPos, EndPos: Integer): Boolean;
begin
  Assert((0 <= Index) and (Index <= Text.Length));

  Result := False;
  BeginPos := Index;
  EndPos := Index;

  if Text.Length > 0 then
  begin
    // Check, that word is began from current position (IXXX or _IXXXX)
    // Legends:
    //   X - Letter or Digit
    //   I - Position of Carriage
    //   _ - other symbol
    if (Index < Text.Length) and Text.Chars[Index].IsLetterOrDigit and
       ((Index = 0) or (Index > 0) and not Text.Chars[Index - 1].IsLetterOrDigit) then
    begin
      BeginPos := Index;
      EndPos := Index;
      while (EndPos < Text.Length - 1) and Text.Chars[EndPos + 1].IsLetterOrDigit do
        Inc(EndPos);
      Exit(True);
    end;

    // Check, that word is ended current position (XXXI or XXXI_)
    if (Index <= Text.Length) and (Text.Chars[Index - 1].IsLetterOrDigit and
       (Index = Text.Length) or (Index < Text.Length) and not Text.Chars[Index].IsLetterOrDigit and Text.Chars[Index - 1].IsLetterOrDigit) then
    begin
      BeginPos := Index - 1;
      EndPos := Index - 1;
      while (BeginPos > 0) and Text.Chars[BeginPos - 1].IsLetterOrDigit do
        Dec(BeginPos);
      Exit(True);
    end;

    // Check, that word contains carriage position (XIX)
    if (Index < Text.Length) and (Index > 0) and Text.Chars[Index].IsLetterOrDigit then
    begin
      BeginPos := Index;
      EndPos := Index;
      while (BeginPos > 0) and Text.Chars[BeginPos - 1].IsLetterOrDigit do
        Dec(BeginPos);
      while (EndPos < Text.Length - 1) and Text.Chars[EndPos + 1].IsLetterOrDigit do
        Inc(EndPos);
      Exit(True);
    end;

    // Check, that carriage doesn't bound about the word (I_ or _I or _I_)
    if (Index = 0) and (Index < Text.Length) and not Text.Chars[Index].IsLetterOrDigit or
       (Index > 0) and (Index < Text.Length) and not Text.Chars[Index - 1].IsLetterOrDigit and not Text.Chars[Index].IsLetterOrDigit or
       (Index = Text.Length) and (Text.Length - 1 > 0) and not Text.Chars[Index].IsLetterOrDigit  then
    begin
      // Search of words at the left
      BeginPos := Index;
      EndPos := Index;
      while (EndPos > 0) and not Text.Chars[EndPos].IsLetterOrDigit do
        Dec(EndPos);
      if EndPos > 0 then
      begin
        BeginPos := EndPos;
        while (BeginPos > 0) and Text.Chars[BeginPos - 1].IsLetterOrDigit do
          Dec(BeginPos);
        Exit(True);
      end;

      // Search of words at the right
      BeginPos := Index;
      EndPos := Index;
      while (BeginPos < Text.Length) and not Text.Chars[BeginPos].IsLetterOrDigit do
        Inc(BeginPos);
      if BeginPos < Text.Length then
      begin
        EndPos := BeginPos;
        while (EndPos < Text.Length) and Text.Chars[EndPos + 1].IsLetterOrDigit do
          Inc(EndPos);
        Exit(True);
      end;
    end;
    // Word isn't found
    BeginPos := Index;
    EndPos := Index;
  end;
end;

function IsPartOfLexeme(const Ch: Char): Boolean;
begin
  Result := Ch.IsLetterOrDigit or (Ch.GetUnicodeCategory in [TUnicodeCategory.ucOtherPunctuation,
    TUnicodeCategory.ucMathSymbol, TUnicodeCategory.ucOpenPunctuation, TUnicodeCategory.ucClosePunctuation]);
end;

function GetLexemeBegin(const Text: string; Index: Integer): Integer;
begin
  Result := Index;
  if not Text.IsEmpty and (Result >= 0) then
  begin
    if not IsPartOfLexeme(Text.Chars[Result]) then
      while (Result > 0) and not IsPartOfLexeme(Text.Chars[Result - 1]) do
        Dec(Result);
    while (Result > 0) and IsPartOfLexeme(Text.Chars[Result - 1]) do
      Dec(Result);
  end;
  Result := Max(Result, 0);
end;

function GetLexemeEnd(const Text: string; Index: Integer): Integer;
var
  TextLength: Integer;
begin
  Result := Index;
  TextLength := Text.Length;
  if not Text.IsEmpty and (Result < TextLength) then
  begin
    if not IsPartOfLexeme(Text.Chars[Result]) then
      while (Result < (TextLength - 1)) and not IsPartOfLexeme(Text.Chars[Result + 1]) do
        Inc(Result)
    else
      while (Result < (TextLength - 1)) and IsPartOfLexeme(Text.Chars[Result + 1]) do
        Inc(Result);
  end;
  Result := Min(Result, TextLength);
end;

function GetNextLexemeBegin(const Text: string; Index: Integer): Integer;
var
  TextLength: Integer;
begin
  Result := Index;
  TextLength := Text.Length;
  if not Text.IsEmpty and (Result >= 0) then
    if not IsPartOfLexeme(Text.Chars[Result]) then
      while (Result < TextLength) and not IsPartOfLexeme(Text.Chars[Result]) do
        Inc(Result)
    else
    begin
      while (Result < TextLength) and IsPartOfLexeme(Text.Chars[Result]) do
        Inc(Result);
      while (Result < TextLength) and not IsPartOfLexeme(Text.Chars[Result]) do
        Inc(Result)
    end;
  Result := Max(Result, 0);
end;

function GetPrevLexemeBegin(const Text: string; Index: Integer): Integer;
begin
  Result := Index;
  if not Text.IsEmpty and (Result > 0) then
  begin
    if not IsPartOfLexeme(Text.Chars[Result - 1]) then
      while (Result > 0) and not IsPartOfLexeme(Text.Chars[Result - 1]) do
        Dec(Result);
    while (Result > 0) and IsPartOfLexeme(Text.Chars[Result - 1]) do
      Dec(Result);
  end
  else
    Result := 0;
  Result := Max(Result, 0);
end;

function TryTextToValue(AText: string; var AValue: Single; DefaultValue: Single): boolean;
var
  TempValue: Single;
begin
  AText := StringReplace(AText, ' ', '', [rfReplaceAll]);
  AText := StringReplace(AText, FormatSettings.ThousandSeparator, '', [rfReplaceAll]);
  AText := StringReplace(AText, ',', FormatSettings.DecimalSeparator, [rfReplaceAll]);
  AText := StringReplace(AText, '.', FormatSettings.DecimalSeparator, [rfReplaceAll]);
  Result := TryStrToFloat(AText, TempValue, FormatSettings);
  if Result then
    AValue := TempValue
  else
    AValue := DefaultValue;
end;

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

function TruncateText(const Text: string; const MaxLength: Integer): string;
begin
  if MaxLength > 0 then
    Result := Text.Substring(0, MaxLength)
  else
    Result := Text;
end;

function FilterText(const Input: string; const Filter: string): string;
begin
  Result := Input;
  if not Filter.IsEmpty then
    Result := TRegEx.Replace(Result, Format('[^%s]', [TRegEx.Escape(Filter)]), string.Empty);
end;

{$REGION 'TTextWordWrapping' }

class constructor TTextWordWrappingImpl.Create;
begin
  FRegExpr := TRegEx.Create('\r\n|\r|\n|[^\S\n\r]+|\S+', [roMultiLine, roCompiled]);
  FRegExprSpace := TRegEx.Create('[^\S\n\r]+', [roCompiled]);
end;

class procedure TTextWordWrappingImpl.GetWords(const AText: String; var AWordsFound: TStringList);
var
  Matches: TMatchCollection;
  I: Integer;
begin
  Matches := FRegExpr.Matches(AText);
  for I := 0 to Matches.Count - 1 do
    if Matches[I].Success then
      AWordsFound.Add(Matches[I].Value);
end;

class function TTextWordWrappingImpl.GetLines(const AText: String; const ACanvas: TCanvas; const AMaxWidth: Integer;
  var ALinesFound: TStringList; var AResWidth: Single): Integer;
var
  WordList: TStringList;
  WordStr: String;
  CurrStr: String;
  Width: Single;
  AccWidth: Single;

  procedure IncLine;
  begin
    if ALinesFound <> nil then
      ALinesFound.Add(CurrStr);
    AResWidth := Max(AResWidth, AccWidth);
    CurrStr := String.Empty;
    AccWidth := 0;
    Inc(Result);
  end;

begin
  Result := 0;
  AResWidth := 0;
  WordList := TStringList.Create;
  try
    AccWidth := 0;
    GetWords(AText, WordList);
    for WordStr in WordList do
    begin
      if (WordStr = #13) or (WordStr = #10) or (WordStr = #13#10) then
      begin
        IncLine;
        Continue;
      end
      else
      begin
        Width := ACanvas.TextWidth(WordStr);
        if Width + AccWidth > AMaxWidth then
        begin
          if not CurrStr.IsEmpty then
            IncLine;
          if FRegExprSpace.Match(WordStr).Success then
            Continue;
        end;
      end;
      AccWidth := AccWidth + Width;
      CurrStr := CurrStr + WordStr;
    end;
    AResWidth := Max(AResWidth, AccWidth);
    if ALinesFound <> nil then
      ALinesFound.Add(CurrStr);
    Inc(Result);
  finally
    WordList.Free;
  end;
end;

class procedure TTextWordWrapping.GetLines(const AText: String; const ACanvas: TCanvas; const AMaxWidth: Integer;
  var ALinesFound: TStringList; var AResWidth: Integer);
var
  ResWidth: Single;
begin
  TTextWordWrappingImpl.GetLines(AText, ACanvas, AMaxWidth, ALinesFound, ResWidth);
  AResWidth := Ceil(ResWidth);
end;

class function TTextWordWrapping.ComputeLineCount(const AText: String; const ACanvas: TCanvas; const AMaxWidth: Integer;
  var AResWidth: Integer): Integer;
var
  ResWidth: Single;
  NilList: TStringList;
begin
  NilList := nil;
  Result := TTextWordWrappingImpl.GetLines(AText, ACanvas, AMaxWidth, NilList, ResWidth);
  AResWidth := Ceil(ResWidth);
end;

{$ENDREGION 'TTextWordWrapping' }

end.
