{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Text;

{$MINENUMSIZE 4}

interface

uses
  System.Types, FMX.Types;

{$SCOPEDENUMS ON}

type

{ TTextService }

  TTextService = class
  protected
    FOwner: IControl;
    FMultiLine: Boolean;
    function GetText: string; virtual; abstract;
    procedure SetText(const Value: string); virtual; abstract;
    function GetCaretPostion: TPoint; virtual; abstract;
    procedure SetCaretPosition(const Value: TPoint); virtual; abstract;
  public
    constructor Create(const Owner: IControl; SupportMultiLine: Boolean); virtual;
    destructor Destroy; override;
    { Text support }
    procedure InternalSetMarkedText( const AMarkedText: string ); virtual; abstract;
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
      const AVTextAlign: TTextAlign = TTextAlign.taCenter;
      const AWordWrap: Boolean = False); overload; virtual; abstract;
    procedure DrawSingleLine(const Canvas: TCanvas; const S: string;
      const ARect: TRectF; const Font: TFont;
      const AOpacity: Single; const Flags: TFillTextFlags; const ATextAlign: TTextAlign;
      const AVTextAlign: TTextAlign = TTextAlign.taCenter;
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
  end;

  TTextServiceClass = class of TTextService;

{ ITextInput }

  ITextInput = interface
    ['{56D79E74-58D6-4c1e-B832-F133D669B952}']
    function GetTextService: TTextService;
    procedure UpdateCaretPoint;
    { IMEI }
    function GetTargetClausePointF: TPointF;
    procedure StartIMEInput;
    procedure EndIMEInput;
    { Selection }
    function GetSelection: string;
    function GetSelectionRect: TRectF;
    { Text }
    function HasText: Boolean;
  end;

{ ITextActions }

  /// <summary>
  ///   Standard actions for operation with the text. Objects which want to get
  ///   support of actions in a shortcut menu shall implement this interface
  /// </summary>
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

  /// <summary>
  ///    Search of boundaries of the word in the text since <paramref name="Index"/>
  /// </summary>
  /// <returns>Returns an index of the left <paramref name="BeginPos"/>
  ///    and right <paramref name="EndPos"/> boundary of the found word
  /// </returns>
  /// <param name="Text">Source text</param>
  /// <param name="Index">Index of carriage position</param>
  /// <remarks>
  ///    Position of the carriage begins with 0. 0 specifies position of the carriage to the first character
  /// </remarks>
  function FindWordBound(const Text: string; Index: Integer; out BeginPos, EndPos: Integer): Boolean;
  function GetLexemeBegin(const Text: string; Index: Integer): Integer;
  function GetLexemeEnd(const Text: string; Index: Integer): Integer;
  function GetNextLexemeBegin(const Text: string; Index: Integer): Integer;
  function GetPrevLexemeBegin(const Text: string; Index: Integer): Integer;

implementation

uses
  System.SysUtils, System.Math, System.Character;

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
  Result := Ch.IsLetterOrDigit or (Ch.GetUnicodeCategory in
    [TUnicodeCategory.ucOtherPunctuation,
     TUnicodeCategory.ucMathSymbol]);
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

end.
