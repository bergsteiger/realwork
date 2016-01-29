unit Spellers;

{$I evDefine.inc }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CSAPI, Registry, StdCtrls, ComCtrls, RichEdit, SpellRes, Langs,
  
  l3Types,
  l3Base,
  l3StringList
  ;

type
  TSpellOption = (spoSuggestFromUserDict, spoIgnoreAllCaps, spoIgnoreMixedDigits,
                  spoIgnoreRomanNumerals, spoFindUncappedSentences,
                  spoFindMissingSpaces, spoFindRepeatWord, spoFindExtraSpaces,
                  spoFindSpacesBeforePunc, spoFindSpacesAfterPunc, spoRateSuggestions,
                  spoFindInitialNumerals);

  TSpellOptions = set of TSpellOption;

  TSpellCommand = (scVerifyWord, scVerifyBuffer, scSuggest, scSuggestMore,
                   scHyphInfo, scWildCard, scAnagram);

  TSpellReturnCode = (srNoErrors, srUnknownInputWord, srReturningChangeAlways,
                      srReturningChangeOnce, srInvalidHyphenation,
                      srErrorCapitalization, srWordConsideredAbbreviation,
                      srHyphChangesSpelling, srNoMoreSuggestions,
                      srMoreInfoThanBufferCouldHold, srNoSentenceStartCap,
                      srRepeatWord, srExtraSpaces, srMissingSpace,
                      srInitialNumeral);

  TSpellMode = (smInteractive, smBackground, smParallel);

  TMisspellFontOption = (mfoName, mfoSize, mfoHeight, mfoColor, mfoPitch,
                         mfoStyle);

  TMisspellFontOptions = set of TMisspellFontOption;

  TMisspellFont = class(TFont)
  private
    fOptions: TMisspellFontOptions;
  published
    property MisspellOptions: TMisspellFontOptions read fOptions write fOptions;
  end;

  TMisspellEvent = procedure (Sender: TObject; SRC: TSpellReturnCode;
                              BufPos, Len: Integer) of object;
  TChangeTextEvent = procedure(Sender: TObject; BufPos, Len: Integer;
                               NewWord: AnsiString) of object;

  TSpellerDialog = class;

  TSpellChecker = class(Tl3Base)
  private
    SpellInstance: THandle;
    DLLName: AnsiString;
    LexName: AnsiString;
    UserDict: AnsiString;
    UserExc: AnsiString;
    FCS: Integer;
    FStrings: TStrings;
    FOptions: TSpellOptions;
    FLID: TLanguage;
    FActive: Boolean;
    FFinishMessage: AnsiString;
    FOnMisspell: TMisspellEvent;
    FOnChangeText: TChangeTextEvent;
    FOnOpen: TNotifyEvent;
    FOnClose: TNotifyEvent;
    FShowFinishMessage: Boolean;
    FSpellMode: TSpellMode;
    FCaption: TCaption;
    FMemo: TCustomMemo;
    FThreads: TList;
    FFont: TMisspellFont;
    FIgnoreQuoteLine: Boolean; // add Eugene Bayanov
    FIgnoreLatinWord: Boolean; // add Eugene Bayanov
  protected
    SpecChars: TWSC;
    InputBuffer: TSIB;
    ResultBuffer: TSRB;
    f_Mdrs: TMDRS;
    Udr: TUDR;
    Handle: TSPLID;
    CheckStr: AnsiString;
    CheckTxt: TStrings;
  { Spell functions}
    SpellVer: TSpellVerFunc;
    SpellInit: TSpellInitFunc;
    SpellOptions: TSpellOptionsFunc;
    SpellCheck: TSpellCheckFunc;
    SpellTerminate: TSpellTerminateFunc;
    SpellVerifyMdr: TSpellVerifyMdrFunc;
    SpellOpenMdr: TSpellOpenMdrFunc;
    SpellOpenUdr: TSpellOpenUdrFunc;
    SpellAddUdr: TSpellAddUdrFunc;
    SpellAddChangeUdr: TSpellAddChangeUdrFunc;
    SpellDelUdr: TSpellDelUdrFunc;
    SpellClearUdr: TSpellClearUdrFunc;
    SpellGetSizeUdr: TSpellGetSizeUdrFunc;
    SpellGetListUdr: TSpellGetListUdrFunc;
    SpellCloseMdr: TSpellCloseMdrFunc;
    SpellCloseUdr: TSpellCloseUdrFunc;
    procedure SetOptions(Value: TSpellOptions);
    procedure SetLocale(Value: TLanguage);
    procedure SetActive(Value: Boolean);
    procedure CheckInteractive(Text: TStrings);
    procedure CheckAuto(Text: TStrings);
    procedure CheckParallel(Text: TStrings);
    function CheckBuf: TSpellReturnCode;
    procedure ChangeOnce(Word: AnsiString);
    procedure Change(Word: AnsiString);
    procedure ChangeAlways(Word: AnsiString);
    procedure Delete;
    procedure Add;
    procedure Ignore;
    procedure IgnoreAlways;
    procedure Release;
      override;
      {-}
  public
    constructor Create;
      override;
      {-}
    procedure Open(aDLLName : AnsiString = '';
                   aLexName : AnsiString = '');
      {-}             
    procedure Close;
    procedure CheckText(Text: TStrings);
    procedure CheckMemo(Memo: TCustomMemo);
    function IsKnownWord(Word: AnsiString): Boolean;
      overload;
      {-}
    function IsKnownWord(aWord: PAnsiChar; aLen: Long; aHasDot: Bool = false): Boolean;
      overload;
      {-}
    function  AddWord(aWord: PAnsiChar; aLen: Long): Bool;
      {-}
    procedure GetVariants(Word: AnsiString; Variants: TStrings);
      overload;
      {-}
    procedure GetVariants(aWord       : PAnsiChar;
                          aLen        : Long;
                          theVariants : Tl3StringList);
      overload;
      {-}
    property Active: Boolean read FActive write SetActive;
    function WordIsRus(w: AnsiString; l: Word): boolean;
  published
    property Options: TSpellOptions read FOptions write SetOptions;
    property Language: TLanguage read FLID write SetLocale;
    property FinishMessage: AnsiString read FFinishMessage write FFinishMessage;
    property OnMisspelling: TMisspellEvent read FOnMisspell write FOnMisspell;
    property OnChangeText: TChangeTextEvent read FOnChangeText write FOnChangeText;
    property OnOpen: TNotifyEvent read FOnOpen write FOnOpen;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property ShowFinishMessage: Boolean read FShowFinishMessage write FShowFinishMessage;
    property SpellMode: TSpellMode read FSpellMode write FSpellMode default smInteractive;
    property Caption: TCaption read FCaption write FCaption;
    property MisspellFont: TMisspellFont read FFont write FFont;
    property IgnoreQuoteLine: Boolean read FIgnoreQuoteLine write FIgnoreQuoteLine;
    property IgnoreLatinWord: Boolean read FIgnoreLatinWord write FIgnoreLatinWord;
  end;

  ESpellError = class(Exception);

  TSpellerDialog = class(TForm)
    InfoMsg: TLabel;
    Misspelling: TRichEdit;
    Label2: TLabel;
    Variants: TListBox;
    ChangeButton: TButton;
    ChangeAllButton: TButton;
    SkipButton: TButton;
    SkipAllButton: TButton;
    AddButton: TButton;
    CancelButton: TButton;
    CancelEdit: TButton;
    DelButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure DelButtonClick(Sender: TObject);
    procedure SkipButtonClick(Sender: TObject);
    procedure SkipAllButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure ChangeButtonClick(Sender: TObject);
    procedure ChangeAllButtonClick(Sender: TObject);
    procedure MisspellingProtectChange(Sender: TObject; StartPos,
      EndPos: Integer; var AllowChange: Boolean);
    procedure MisspellingChange(Sender: TObject);
    procedure CancelEditClick(Sender: TObject);
  private
    { Private declarations }
    Checker: TSpellChecker;
    FText: TStrings;
    FShowing: Boolean;
    ErrorKind: TSpellReturnCode;
    procedure ContinueCheck;
    procedure ShowForChange(Msg: TCaption);
    procedure ShowForDelete;
    procedure ShowForEdit(Msg: TCaption);
    procedure ShowMisspelling;
    procedure GetHotArea(var SS, SL: Integer);
  public
    { Public declarations }
    constructor Create(SpellChecker: TSpellChecker; Text: TStrings);
  end;

const
  langAfrikaans = TLanguage(1078);
  langAlbanian = TLanguage(1052);
  langArabic = TLanguage(1025);
  langBasque = TLanguage(1069);
  langBelgianDutch = TLanguage(2067);
  langBelgianFrench = TLanguage(2060);
  langBrazilianPortuguese = TLanguage(1046);
  langBulgarian = TLanguage(1026);
  langByelorussian = TLanguage(1059);
  langCatalan = TLanguage(1027);
  langCroatian = TLanguage(1050);
  langCzech = TLanguage(1029);
  langDanish = TLanguage(1030);
  langDutch = TLanguage(1043);
  langEnglishAUS = TLanguage(3081);
  langEnglishCanadian = TLanguage(4105);
  langEnglishNewZealand = TLanguage(5129);
  langEnglishSouthAfrica = TLanguage(7177);
  langEnglishUK = TLanguage(2057);
  langEnglishUS = TLanguage(1033);
  langEstonian = TLanguage(1061);
  langFaeroese = TLanguage(1080);
  langFarsi = TLanguage(1065);
  langFinnish = TLanguage(1035);
  langFinnishSwedish = TLanguage(2077);
  langFrench = TLanguage(1036);
  langFrenchCanadian = TLanguage(3084);
  langGerman = TLanguage(1031);
  langGreek = TLanguage(1032);
  langHebrew = TLanguage(1037);
  langHungarian = TLanguage(1038);
  langItalian = TLanguage(1040);
  langIcelandic = TLanguage(1039);
  langIndonesian = TLanguage(1057);
  langJapanese = TLanguage(1041);
  langKorean = TLanguage(1042);
  langLatvian = TLanguage(1062);
  langLithuanian = TLanguage(1063);
  langMacedonian = TLanguage(1071);
  langMalaysian = TLanguage(1086);
  langMexicanSpanish = TLanguage(2058);
  langNorwegianBokmol = TLanguage(1044);
  langNorwegianNynorsk = TLanguage(2068);
  langPolish = TLanguage(1045);
  langPortuguese = TLanguage(2070);
  langRomanian = TLanguage(1048);
  langRussian = TLanguage(1049);
  langSerbianCyrillic = TLanguage(3098);
  langSerbianLatin = TLanguage(2074);
  langSesotho = TLanguage(1072);
  langSimplifiedChinese = TLanguage(2052);
  langSlovak = TLanguage(1051);
  langSlovenian = TLanguage(1060);
  langSpanish = TLanguage(1034);
  langSpanishModernSort = TLanguage(3082);
  langSwedish = TLanguage(1053);
  langSwissFrench = TLanguage(4108);
  langSwissGerman = TLanguage(2055);
  langSwissItalian = TLanguage(2064);
  langThai = TLanguage(1054);
  langTraditionalChinese = TLanguage(1028);
  langTsonga = TLanguage(1073);
  langTswana = TLanguage(1074);
  langTurkish = TLanguage(1055);
  langUkrainian = TLanguage(1058);
  langVenda = TLanguage(1075);
  langVietnamese = TLanguage(1066);
  langXhosa = TLanguage(1076);
  langZulu = TLanguage(1077);

function Paragraphs(Memo: TCustomMemo): TStrings;
function UnwrappedText(Memo: TCustomMemo): AnsiString;
function GetSpellLanguages(Languages: TStrings; Option: TLangOption): Integer;

implementation

uses
  l3Chars
  ;

{$R *.DFM}

type
  TSpellThread = class(TThread)
  private
    { Private declarations }
    FSpeller: TSpellChecker;
    FText: TStrings;
    SIB: TSIB;
    SRB: TSRB;
    Pos: Integer;
    FMemo: TCustomMemo;
    procedure CallEvent;
    procedure FirstCall;
    procedure NextCall;
    procedure Finish;
  protected
    constructor Create(Speller: TSpellChecker; Text: TStrings; Memo: TCustomMemo);
    destructor Destroy; override;
    procedure Execute; override;
  end;


function Paragraphs(Memo: TCustomMemo): TStrings;
var
  Buf: PChar;
  Len: Integer;
begin
  Len:= GetWindowTextLength(Memo.Handle);
  Buf:= AllocMem((Len+1) * SizeOf(Char));
  GetWindowText(Memo.Handle, Buf, Len+1);
  Result:= TStringList.Create;
  Result.Text:= Buf;
  FreeMem(Buf);
end;

function UnwrappedText(Memo: TCustomMemo): AnsiString;
var
  Buf: PChar;
  Len: Integer;
begin
  Len:= GetWindowTextLength(Memo.Handle);
  Buf:= AllocMem((Len+1) * SizeOf(Char));
  GetWindowText(Memo.Handle, Buf, Len+1);
  Result:= Buf;
  FreeMem(Buf);
end;

procedure ApplyFont(Memo: TCustomRichEdit; Font: TMisspellFont);
begin
  if mfoName in Font.MisspellOptions then
    Memo.SelAttributes.Name:= Font.Name;
  if mfoSize in Font.MisspellOptions then
    Memo.SelAttributes.Size:= Font.Size;
  if mfoHeight in Font.MisspellOptions then
    Memo.SelAttributes.Height:= Font.Height;
  if mfoColor in Font.MisspellOptions then
    Memo.SelAttributes.Color:= Font.Color;
  if mfoPitch in Font.MisspellOptions then
    Memo.SelAttributes.Pitch:= Font.Pitch;
  if mfoStyle in Font.MisspellOptions then
    Memo.SelAttributes.Style:= Font.Style;
end;

constructor TSpellChecker.Create;
begin
  inherited;
  Language:= GetSystemDefaultLCID;
  FMemo:= nil;
  FActive:= False;
  FOptions:= [spoSuggestFromUserDict, spoIgnoreAllCaps, spoIgnoreMixedDigits,
              spoIgnoreRomanNumerals];
  FCS:= -1;
  FStrings:= nil;
  FShowFinishMessage:= True;
  FThreads:= TList.Create;
  FFinishMessage:= spsFinish;
  FCaption:= spsCaption;
  FFont:= TMisspellFont.Create;
  FFont.fOptions:= [mfoColor];
  FFont.Color:= clRed;
  with SpecChars do
    begin
      bIgnore:= #0;
      bHyphenHard:= #45;
      bHyphenSoft:= #31;
      bHyphenNonBreaking:= #30;
      bEmDash:= #151;
      bEnDash:= #150;
      bEllipsis:= #133;
      rgLineBreak:= #11#10;
      rgParaBreak:= #13#10;
    end;
end;

procedure TSpellChecker.Release;
begin
 if FActive then
   Close;
 FFont.Free;
 FThreads.Free;
 inherited;
end;

procedure CheckSR(SR: TSEC);
begin
  if SR<>secNoErrors then
    raise ESpellError.CreateFmt(spsError, [SR]);
end;

function GetAbbrevLangName2(Language: Word): AnsiString; {## JB}
var
  Buf: array[0..255] of Char;
begin
  GetLocaleInfo(Language, LOCALE_SABBREVLANGNAME, Buf, 255);
  Result:= Copy(StrPas(Buf), 1, 2);
end; {## JB}

procedure TSpellChecker.Open(aDLLName : AnsiString = '';
                             aLexName : AnsiString = '');
  {-}
                             
const ErrorOpen = 'Ошибка инициализации';
      KeySpelling = '\SOFTWARE\Microsoft\Shared Tools\Proofing Tools\Spelling\%d\Normal';
var
  l_Registry : TRegistry;
  UdrRO      : Boolean;
  Lid        : TLID;
  NotSpell,
  NotDic     : Boolean;

procedure OpenKeyCustomDictionary;
const KeyCustomDic='\SOFTWARE\Microsoft\Shared Tools\Proofing Tools\Custom Dictionaries';
begin
  NotDic:= False;
  if l_Registry.OpenKey(KeyCustomDic, False) then
  begin
    UserDict:= l_Registry.ReadString('1');
    if UserDict='' then
    begin
      UserDict:= ExtractFilePath(LexName)+'custom.dic';
      l_Registry.WriteString('1', UserDict);
    end;
  end
  else begin {## JB for Office 2000}
    if l_Registry.CreateKey(KeyCustomDic) then
    begin
      if l_Registry.OpenKey(KeyCustomDic, False) then
      begin
        UserDict:= ExtractFilePath(LexName)+'custom.dic';
        l_Registry.WriteString('1', UserDict);
      end
      else NotDic:= True;
    end
    else NotDic:= True;
  end;
end;

procedure CreateKeyDictionary; {## JB for Office 2000}
begin
  LexName:= ExtractFilePath(DLLName)+'MSSP_'+GetAbbrevLangName2(FLID)+'.LEX';
  l_Registry.WriteString('Dictionary', LexName);
end;

function LoadProc(const aName: AnsiString; const aTail: AnsiString = ''): Pointer;
begin
 Result := GetProcAddress(SpellInstance, PAnsiChar('Spell' + aName));
(* if (Result = nil) then
  Result := GetProcAddress(SpellInstance, PAnsiChar('Speller' + aName + aTail));*)
end;

begin
  if FActive then
    Exit;

  l_Registry := nil;
  
  if (aDLLName = '') then begin
   l_Registry:= TRegistry.Create;
   l_Registry.RootKey:= HKEY_LOCAL_MACHINE;

   NotSpell:= False;
   if l_Registry.OpenKey(Format(KeySpelling, [FLID]), False) then
     begin
       DLLName:= l_Registry.ReadString('Engine');
       LexName:= l_Registry.ReadString('Dictionary');
       if Length(LexName) = 0 then CreateKeyDictionary; {## JB for Office 2000}
     end
     else NotSpell:= True;

   if NotSpell then begin
    l3Free(l_Registry);
    windows.MessageBoxA(0, PAnsiChar(spsNotFoundSpeller), PAnsiChar(ErrorOpen), MB_ICONERROR or MB_OK);
    Exit;
   end;//NotSpell
   //aDLLName = ''
  end else 
   DLLName := aDLLName;

  if (aLexName = '') then begin
   if (l_Registry = nil) then begin
    l_Registry:= TRegistry.Create;
    l_Registry.RootKey:= HKEY_LOCAL_MACHINE;
   end;//l_Registry = nil 
   OpenKeyCustomDictionary;
   l3Free(l_Registry);
   if NotDic then begin
    windows.MessageBoxA(0, PAnsiChar(spsNotFoundDic), PAnsiChar(ErrorOpen), MB_ICONERROR or MB_OK);
    Exit;
   end;//NotDic
   //aLexName = ''
  end else begin
   LexName := aLexName;
   UserDict := ExtractFilePath(LexName)+GetAbbrevLangName2(FLID)+'.dic';
  end;//aLexName = ''
  if (ExtractFilePath(LexName) = '') then
   LexName := ExtractFilePath(Application.ExeName) + LexName;
  if (ExtractFilePath(UserDict) = '') then
   UserDict := ExtractFilePath(Application.ExeName) + UserDict;

  Factive:= True;
  try
   SpellInstance:= LoadLibraryA(PAnsiChar(DllName));
  except
   raise ESpellError.CreateFmt(spsErrorLoad, [DllName]);
  end;//try..except
  try
   @SpellVer := LoadProc('Ver', 'sion');
   @SpellInit := LoadProc('Init');
   @SpellOptions := LoadProc('Options');
   @SpellCheck := LoadProc('Check');
   @SpellTerminate := LoadProc('Terminate');
   @SpellVerifyMdr := LoadProc('VerifyMdr');
   @SpellOpenMdr := LoadProc('OpenMdr');
   @SpellOpenUdr := LoadProc('OpenUdr');
   @SpellAddUdr := LoadProc('AddUdr');
   @SpellAddChangeUdr := LoadProc('AddChangeUdr');
   @SpellDelUdr := LoadProc('DelUdr');
   @SpellClearUdr := LoadProc('ClearUdr');
   @SpellGetSizeUdr := LoadProc('GetSizeUdr');
   @SpellGetListUdr := LoadProc('GetListUdr');
   @SpellCloseMdr := LoadProc('CloseMdr');
   @SpellCloseUdr := LoadProc('CloseUdr');
  except
   FreeLibrary(SpellInstance);
   Factive := false;
   raise ESpellError.CreateFmt(spsErrorLoad, [DLLName]);
  end;//try..except
  if (@SpellInit = nil) then begin
   FreeLibrary(SpellInstance);
   Factive := false;
   Exit;
  end;//@SpellInit = nil
  try
   CheckSR(SpellInit(Handle, SpecChars));
   CheckSR(SpellOptions(Handle, Word(FOptions)));
   if Assigned(FOnOpen) then
     FOnOpen(Self);
   CheckSR(SpellVerifyMdr(PAnsiChar(LexName), FLID, LID));
   CheckSR(SpellOpenMdr(Handle, PAnsiChar(LexName), nil, False, True, FLID, f_Mdrs));
   CheckSR(SpellOpenUdr(Handle, PAnsiChar(UserDict), True, IgnoreAlwaysProp, Udr, UdrRO));
  except
   Close;
   raise;
  end;//try..except
end;

procedure TSpellChecker.Close;
var
  I: Integer;
begin
  if not FActive then
    Exit;
  FActive:= False;
  for I:= FThreads.Count-1 downto 0 do
    TSpellThread(FThreads.Items[I]).Terminate;
  {CheckSR(}SpellCloseUdr(Handle, Udr, true){)};
  CheckSR(SpellCloseMdr(Handle, f_Mdrs));
  CheckSR(SpellTerminate(Handle, True));
  try
   FreeLibrary(SpellInstance);
  except
   raise ESpellError.CreateFmt(spsErrorUnload, [DLLName]);
  end;
  l3FillChar(f_Mdrs, SizeOf(f_Mdrs));  
  l3FillChar(Udr, SizeOf(Udr));  
  if Assigned(FOnClose) then
    FOnClose(Self);
end;

procedure TSpellChecker.SetOptions(Value: TSpellOptions);
begin
  FOptions:= Value;
  if not Active then
    Exit;
  CheckSR(SpellOptions(Handle, Integer(Word(FOptions))));
end;

procedure TSpellChecker.SetLocale(Value: TLanguage);
begin
  if Active or not IsValidLocale(Value, LCID_Installed) then
    Exit;
  FLID:= Value;
end;

procedure TSpellChecker.SetActive(Value: Boolean);
begin
  if Value xor FActive then
    if Value then
      Open
    else
      Close;
end;

procedure TSpellChecker.CheckInteractive(Text: TStrings);
var
  I: Integer;
begin
  CheckTxt:= Text;
  CheckStr:= '';
  for I:= 0 to Text.Count-1 do
    CheckStr:= CheckStr+Text[I]+#13#10;
  with InputBuffer do
    begin
      cch:= Length(CheckStr);
      cMdr:= 1;
      cUdr:= 1;
      wSpellState:= fssNoStateInfo;
      lrgch:= @CheckStr[1];
      lrgMdr:= @f_Mdrs.MDR;
      lrgUdr:= @Udr;
    end;
  with ResultBuffer do
    begin
      cch:= 1024;
      lrgsz:= AllocMem(1024);
      lrgbRating:= AllocMem(255);
      cbRate:= 255;
    end;
  with TSpellerDialog.Create(Self, Text) do
    begin
      ContinueCheck;
      Free;
    end;
  FreeMem(ResultBuffer.lrgsz);
  FreeMem(ResultBuffer.lrgbRating);
  if ShowFinishMessage and (FinishMessage<>'') then
    MessageBoxExA(Application.Handle, PAnsiChar(FinishMessage), PAnsiChar(spsFinishCaption),
               mb_Ok+mb_IconInformation, FLID);
end;

procedure TSpellChecker.CheckAuto(Text: TStrings);
var
  SIB: TSIB;
  SRB: TSRB;
  S: AnsiString;
  I, Pos: Integer;
  UnkWord: AnsiString;
begin
  S:= '';
  for I:= 0 to Text.Count-1 do
    S:= S+Text[I]+#13#10;
  with SIB do
    begin
      cch:= Length(S);
      cMdr:= 1;
      cUdr:= 1;
      wSpellState:= fssStartsSentence;
      lrgch:= @S[1];
      lrgMdr:= @f_Mdrs.MDR;
      lrgUdr:= @Udr;
    end;
  SRB.cch:= 255;
  SRB.lrgsz:= AllocMem(255);
  CheckSR(SpellCheck(Handle, sccVerifyBuffer, SIB, SRB));
  Pos:= 0;
  while SRB.scrs<>scrsNoErrors do
    begin
      Inc(Pos, SRB.ichError);
      if Assigned(FMemo) and (FMemo is TCustomRichEdit) and Assigned(FFont) then
        begin
          FMemo.SelStart:= Pos;
          FMemo.SelLength:= SRB.cchError;
          ApplyFont(TCustomRichEdit(FMemo), FFont);
        end;
      UnkWord:= Copy(SIB.lrgch, SRB.ichError+1, SRB.cchError);

      if (Assigned(FOnMisspell))AND(WordIsRus(UnkWord, SRB.cchError)) then
        FOnMisspell(Self, TSpellReturnCode(SRB.scrs), Pos, SRB.cchError);
      Inc(Pos, SRB.cchError);
      SIB.wSpellState:= fssIsContinued;
      Inc(SIB.lrgch, SRB.ichError+SRB.cchError);
      Dec(SIB.cch, SRB.ichError+SRB.cchError);
      CheckSR(SpellCheck(Handle, sccVerifyBuffer, SIB, SRB));
    end;
  FreeMem(SRB.lrgsz);
end;

function TSpellChecker.WordIsRus(w: AnsiString; l: word): boolean;
var j: Integer;
begin
  Result:= True;
  if FIgnoreLatinWord then
  begin // игнорируем латинские слова
    Result:= False;
    for j:= 1 to l do if w[j] in ['А'..'я'] then
      begin Result:= True; Break; end;
  end;
end;

procedure TSpellChecker.CheckParallel(Text: TStrings);
begin
  FThreads.Add(TSpellThread.Create(Self, Text, FMemo));
end;

procedure TSpellChecker.CheckText(Text: TStrings);
begin
  if not Active then
    Exit;
  case SpellMode of
  smInteractive:
    CheckInteractive(Text);
  smBackground:
    CheckAuto(Text);
  smParallel:
    CheckParallel(Text);
  end;
end;

function TSpellChecker.IsKnownWord(Word: AnsiString): Boolean;
var
  SIB: TSIB;
  SRB: TSRB;
begin
  Result:= True;
  if not Active then
    Exit;
  with SIB do
    begin
      cch:= Length(Word);
      cMdr:= 1;
      cUdr:= 1;
      wSpellState:= fssNoStateInfo;
      lrgch:= @Word[1];
      lrgMdr:= @f_Mdrs.MDR;
      lrgUdr:= @Udr;
    end;
  CheckSR(SpellCheck(Handle, sccVerifyWord, SIB, SRB));
  Result := (SRB.scrs = scrsNoErrors);
end;

function TSpellChecker.IsKnownWord(aWord: PAnsiChar; aLen: Long; aHasDot: Bool = false): Boolean;
  //overload;
  {-}
var
 SIB    : TSIB;
 SRB    : TSRB;
 UdrRO  : Boolean;
 l_Char : AnsiChar;
begin
 Result := true;
 if not Active then
  Exit;
 l3FillChar(SIB, SizeOf(SIB));
 l3FillChar(SRB, SizeOf(SRB));
 with SIB do begin
  cch := aLen;
  cMdr := 1;
  cUdr := 1;
  wSpellState := fssNoStateInfo;
  lrgch := aWord;
  lrgMdr := @f_Mdrs.MDR;
  lrgUdr := @Udr;
 end;//with SIB
 l_Char := aWord[aLen];
 try
  aWord[aLen] := cc_Null;
  CheckSR(SpellCheck(Handle, sccVerifyWord, SIB, SRB));
 finally
  aWord[aLen] := l_Char;
 end;//try..finally
 Result := (SRB.scrs = scrsNoErrors);
 if not Result AND aHasDot then
  Result := IsKnownWord(aWord, Succ(aLen));
end;

function TSpellChecker.AddWord(aWord: PAnsiChar; aLen: Long): Bool;
  {-}
var
 l_Char : AnsiChar;
begin
 if (aWord = nil) then
  Result := true
 else begin
  l_Char := aWord[aLen];
  try
   aWord[aLen] := cc_Null;
   Result := (SpellAddUdr(Handle, Udr, aWord) = scrsNoErrors);
  finally
   aWord[aLen] := l_Char;
  end;//try..finally
 end;//aWord <> nil
end;
  
procedure TSpellChecker.GetVariants(Word: AnsiString; Variants: TStrings);
var
  SIB: TSIB;
  SRB: TSRB;
  Buf: array[0..2047]of AnsiChar;
  Ratings: array[0..255]of Byte;
  P: PAnsiChar;
begin
  if not Active then
    Exit;
  Variants.Clear;
  with SIB do
    begin
      cch:= Length(Word);
      cMdr:= 1;
      cUdr:= 1;
      wSpellState:= fssNoStateInfo;
      lrgch:= @Word[1];
      lrgMdr:= @f_Mdrs.MDR;
      lrgUdr:= @Udr;
    end;
  with SRB do
    begin
      cch:= 1024;
      lrgsz:= @Buf;
      lrgbRating:= @Ratings;
      cbRate:= 255;
    end;
  CheckSR(SpellCheck(Handle, sccSuggest, SIB, SRB));
  while SRB.scrs<>scrsNoMoreSuggestions do
    begin
      P:= SRB.lrgsz;
      while P^<>#0 do
        begin
          if Variants.IndexOf(P)=-1 then
            Variants.Add(P);
          while P^<>#0 do
            Inc(P);
          Inc(P);
        end;
      CheckSR(SpellCheck(Handle, sccSuggestMore, SIB, SRB));
    end;
end;

procedure TSpellChecker.GetVariants(aWord : PAnsiChar;
                                    aLen  : Long;
                                    theVariants : Tl3StringList);
  //overload;
  {-}
var
  SIB     : TSIB;
  SRB     : TSRB;
  Buf     : array [0..2047] of Char;
  Ratings : array [0..255] of Byte;
  P       : PAnsiChar;
begin
  if not Active OR (theVariants = nil) then
    Exit;
  theVariants.Clear;
  with SIB do
    begin
      cch:= aLen;
      cMdr:= 1;
      cUdr:= 1;
      wSpellState:= fssNoStateInfo;
      lrgch:= aWord;
      lrgMdr:= @f_Mdrs.MDR;
      lrgUdr:= @Udr;
    end;
  with SRB do
    begin
      cch:= 1024;
      lrgsz:= @Buf;
      lrgbRating:= @Ratings;
      cbRate:= 255;
    end;
  CheckSR(SpellCheck(Handle, sccSuggest, SIB, SRB));
  while (SRB.scrs <> scrsNoMoreSuggestions) do begin
   P:= SRB.lrgsz;
   while (P^<>#0) do begin
      theVariants.Add(AnsiString(P));
      while P^<>#0 do
       Inc(P);
       Inc(P);
   end;//while (P^<>#0)
   CheckSR(SpellCheck(Handle, sccSuggestMore, SIB, SRB));
  end;//while (SRB.scrs <> scrsNoMoreSuggestions)
end;

function TSpellChecker.CheckBuf: TSpellReturnCode;
begin
  CheckSR(SpellCheck(handle, sccVerifyBuffer, InputBuffer, ResultBuffer));
  Result:= TSpellReturnCode(ResultBuffer.scrs);
  if Assigned(FMemo) and (ResultBuffer.scrs<>scrsNoErrors) then
    begin
      FMemo.SelStart:= InputBuffer.lrgch-@CheckStr[1]+ResultBuffer.ichError;
      FMemo.SelLength:= ResultBuffer.cchError;
    end;
end;

procedure TSpellChecker.ChangeOnce(Word: AnsiString);
var
  P: Integer;
begin
  CheckSR(SpellAddChangeUdr(Handle, udrChangeOnce,
      PAnsiChar(Copy(InputBuffer.lrgch, ResultBuffer.ichError+1, ResultBuffer.cchError)),
      PAnsiChar(Word)));
  P:= InputBuffer.lrgch-@CheckStr[1];
  CheckStr:= Copy(CheckStr, 1, P+ResultBuffer.ichError)+
             Word+
             Copy(CheckStr, P+ResultBuffer.ichError+ResultBuffer.cchError+1, Length(CheckStr));
  if Assigned(FMemo) then
    FMemo.SelText:= Word;
  if Assigned(FOnChangeText) then
    FOnChangeText(Self, P+ResultBuffer.ichError, ResultBuffer.cchError, Word);
  InputBuffer.lrgch:= @CheckStr[1+P+ResultBuffer.ichError];
  InputBuffer.cch:= StrLen(InputBuffer.lrgch);
end;

procedure TSpellChecker.Change(Word: AnsiString);
var
  P: Integer;
begin
  P:= InputBuffer.lrgch-@CheckStr[1];
  CheckStr:= Copy(CheckStr, 1, P+ResultBuffer.ichError)+
             Word+
             Copy(CheckStr, P+ResultBuffer.ichError+ResultBuffer.cchError+1, Length(CheckStr));
  if Assigned(FMemo) then
    FMemo.SelText:= Word;
  if Assigned(FOnChangeText) then
    FOnChangeText(Self, P+ResultBuffer.ichError, ResultBuffer.cchError, Word);
  InputBuffer.lrgch:= @CheckStr[1+P+ResultBuffer.ichError];
  InputBuffer.cch:= StrLen(InputBuffer.lrgch);
end;

procedure TSpellChecker.ChangeAlways(Word: AnsiString);
var
  P: Integer;
begin
  CheckSR(SpellAddChangeUdr(Handle, udrChangeAlways,
      PAnsiChar(Copy(InputBuffer.lrgch, ResultBuffer.ichError+1, ResultBuffer.cchError)),
      PAnsiChar(Word)));
  P:= InputBuffer.lrgch-@CheckStr[1];
  CheckStr:= Copy(CheckStr, 1, P+ResultBuffer.ichError)+
             Word+
             Copy(CheckStr, P+ResultBuffer.ichError+ResultBuffer.cchError+1, Length(CheckStr));
  if Assigned(FMemo) then
    FMemo.SelText:= Word;
  if Assigned(FOnChangeText) then
    FOnChangeText(Self, P+ResultBuffer.ichError, ResultBuffer.cchError, Word);
  InputBuffer.lrgch:= @CheckStr[1+P+ResultBuffer.ichError+Length(Word)];
  InputBuffer.cch:= StrLen(InputBuffer.lrgch);
end;

procedure TSpellChecker.Delete;
var
  P: Integer;
begin
  P:= InputBuffer.lrgch-@CheckStr[1];
  System.Delete(CheckStr, P+ResultBuffer.ichError, ResultBuffer.cchError+1);
  if Assigned(FMemo) then
    begin
      FMemo.SelStart:= P+ResultBuffer.ichError-1;
      FMemo.SelLength:= ResultBuffer.cchError+1;
      FMemo.SelText:= '';
    end;
  if Assigned(FOnChangeText) then
    FOnChangeText(Self, P+ResultBuffer.ichError-1, ResultBuffer.cchError+1, '');
  InputBuffer.lrgch:= @CheckStr[1+P+ResultBuffer.ichError];
  InputBuffer.cch:= StrLen(InputBuffer.lrgch);
end;

procedure TSpellChecker.Add;
begin
  CheckSR(SpellAddUdr(Handle, Udr,
      PAnsiChar(Copy(InputBuffer.lrgch, ResultBuffer.ichError+1, ResultBuffer.cchError))));
  Inc(InputBuffer.lrgch, ResultBuffer.ichError+ResultBuffer.cchError);
  Dec(InputBuffer.cch, ResultBuffer.ichError+ResultBuffer.cchError);
end;

procedure TSpellChecker.Ignore;
begin
  Inc(InputBuffer.lrgch, ResultBuffer.ichError+ResultBuffer.cchError);
  Dec(InputBuffer.cch, ResultBuffer.ichError+ResultBuffer.cchError);
end;

procedure TSpellChecker.IgnoreAlways;
begin
  CheckSR(SpellAddUdr(Handle, udrIgnoreAlways,
      PAnsiChar(Copy(InputBuffer.lrgch, ResultBuffer.ichError+1, ResultBuffer.cchError))));
  Inc(InputBuffer.lrgch, ResultBuffer.ichError+ResultBuffer.cchError);
  Dec(InputBuffer.cch, ResultBuffer.ichError+ResultBuffer.cchError);
end;

procedure TSpellChecker.CheckMemo(Memo: TCustomMemo);
var
  Para: TStrings;
begin
  Para:= Paragraphs(Memo);
  FMemo:= Memo;
  CheckText(Para);
  Para.Free;
  FMemo:= nil;
end;

constructor TSpellThread.Create(Speller: TSpellChecker; Text: TStrings;
                                Memo: TCustomMemo);
begin
  FSpeller:= Speller;
  FText:= TStringList.Create;
  FText.Text:= Text.Text;
  FMemo:= Memo;
  FreeOnTerminate:= True;
  inherited Create(False);
end;

destructor TSpellThread.Destroy;
begin
  if Assigned(FText) then
    FText.Free;
  inherited;
end;

procedure TSpellThread.CallEvent;
begin
  if Assigned(FMemo) and (FMemo is TCustomRichEdit) and Assigned(FSpeller.FFont) then
    begin
      FMemo.SelStart:= Pos;
      FMemo.SelLength:= SRB.cchError;
      ApplyFont(TCustomRichEdit(FMemo), FSpeller.FFont);
    end;
  with FSpeller do
    if Assigned(FOnMisspell) then
      FOnMisspell(FSpeller, TSpellReturnCode(SRB.scrs), Pos, SRB.cchError);
end;

procedure TSpellThread.FirstCall;
begin
  CheckSR(FSpeller.SpellCheck(FSpeller.Handle, sccVerifyBuffer, SIB, SRB));
end;

procedure TSpellThread.NextCall;
begin
  CheckSR(FSpeller.SpellCheck(FSpeller.Handle, sccVerifyBuffer, SIB, SRB));
end;

procedure TSpellThread.Finish;
begin
  FSpeller.FThreads.Delete(FSpeller.FThreads.IndexOf(Self));
end;

procedure TSpellThread.Execute;
var
  S: AnsiString;
  I: Integer;
begin
  S:= FText.Text;
  if Terminated then
    Exit;
  with SIB do
    begin
      cch:= Length(S);
      cMdr:= 1;
      cUdr:= 1;
      wSpellState:= fssStartsSentence;
      lrgch:= @S[1];
      lrgMdr:= @FSpeller.f_Mdrs.MDR;
      lrgUdr:= @FSpeller.Udr;
    end;
  SRB.cch:= 255;
  SRB.lrgsz:= AllocMem(255);
  if Terminated then
    begin
      Synchronize(Finish);
      Exit;
    end;
  Synchronize(FirstCall);
  if Terminated then
    begin
      Synchronize(Finish);
      Exit;
    end;
  Pos:= 0;
  while SRB.scrs<>scrsNoErrors do
    begin
      Inc(Pos, SRB.ichError);
      Synchronize(CallEvent);
      Inc(Pos, SRB.cchError);
      if Terminated then
        Break;
      SIB.wSpellState:= fssIsContinued;
      Inc(SIB.lrgch, SRB.ichError+SRB.cchError);
      Dec(SIB.cch, SRB.ichError+SRB.cchError);
      Synchronize(NextCall);
      if Terminated then
        Break;
    end;
  FreeMem(SRB.lrgsz);
  Synchronize(Finish);
end;

constructor TSpellerDialog.Create(SpellChecker: TSpellChecker; Text: TStrings);
begin
  Checker:= SpellChecker;
  FText:= Text;
  inherited Create(Application);
end;

procedure TSpellerDialog.FormCreate(Sender: TObject);
begin
  //Caption:= Format(Checker.Caption, [LanguageName(Checker.Language)]);
  Label2.Caption:= spsVariants;
  ChangeButton.Caption:= spsChange;
  ChangeAllButton.Caption:= spsChangeAll;
  SkipButton.Caption:= spsSkip;
  SkipAllButton.Caption:= spsSkipAll;
  DelButton.Caption:= spsDelete;
  CancelButton.Caption:= spsCancel;
  CancelEdit.Caption:= spsCancelEdit;
  Variants.Font.Charset:= CharSetFromLocale(Checker.Language);
end;

procedure TSpellerDialog.ContinueCheck;
label 1;
var UnkWord: AnsiString;
begin
1:
  ErrorKind:= Checker.CheckBuf;
  IF Integer(ErrorKind)<>scrsNoErrors THEN // игнорируем квотируемые строки
  BEGIN
    UnkWord:= Copy(Checker.InputBuffer.lrgch, Checker.ResultBuffer.ichError+1,
                   Checker.ResultBuffer.cchError);
    IF not Checker.WordIsRus(UnkWord, Checker.ResultBuffer.cchError) THEN
    BEGIN
      Checker.Ignore;
      goto 1;
    END;

    ShowMisspelling;
    IF (Checker.FIgnoreQuoteLine)AND(Pos('>',Misspelling.Text) in [1..6]) THEN
    BEGIN
      Checker.Ignore;
      goto 1;
    END;
  END;

  case Integer(ErrorKind) of
  scrsNoErrors:
    Close;
  scrsUnknownInputWord:
    ShowForChange(spsNotFound);
  scrsReturningChangeAlways:
    Checker.Change(Checker.ResultBuffer.lrgsz);
  scrsReturningChangeOnce:
    begin
      ShowForChange(spsNotFound);
      if Variants.Items.IndexOf(Checker.ResultBuffer.lrgsz)=-1 then
        Variants.Items.Insert(0, Checker.ResultBuffer.lrgsz);
    end;
  scrsInvalidHyphenation:
    ShowForChange(spsHyphen);
  scrsErrorCapitalization:
    ShowForChange(spsCaps);
  scrsWordConsideredAbbreviation:
    ShowForChange(spsAbbrev);
  scrsNoSentenceStartCap:
    ShowForChange(spsNoSentenceCap);
  scrsRepeatWord:
    ShowForDelete;
  scrsExtraSpaces:
    ShowForChange(spsExtraSpaces);
  scrsMissingSpace:
    ShowForEdit(spsMissingSpace);
  scrsInitialNumeral:
    ShowForEdit(spsInitialNumeral);
  end;
end;

procedure TSpellerDialog.DelButtonClick(Sender: TObject);
begin
  Checker.Delete;
  ContinueCheck;
end;

procedure TSpellerDialog.SkipButtonClick(Sender: TObject);
begin
  Checker.Ignore;
  ContinueCheck;
end;

procedure TSpellerDialog.SkipAllButtonClick(Sender: TObject);
begin
  Checker.IgnoreAlways;
  ContinueCheck;
end;

procedure TSpellerDialog.AddButtonClick(Sender: TObject);
begin
  Checker.Add;
  ContinueCheck;
end;

procedure TSpellerDialog.ChangeButtonClick(Sender: TObject);
var
  SS, SL: Integer;
begin
  if CancelEdit.Visible then
    begin
      GetHotArea(SS, SL);
      with Misspelling do
        begin
          SelStart:= SS;
          SelLength:= SL;
          Checker.Change(SelText);
        end;
      ContinueCheck;
    end
  else
    begin
      if Integer(ErrorKind)=scrsUnknownInputWord then
        Checker.ChangeOnce(Variants.Items[Variants.ItemIndex])
      else
         Checker.Change(Variants.Items[Variants.ItemIndex]);
     ContinueCheck;
    end;
end;

procedure TSpellerDialog.ChangeAllButtonClick(Sender: TObject);
begin
  Checker.ChangeAlways(Variants.Items[Variants.ItemIndex]);
  ContinueCheck;
end;

function DelExtraSpaces(const S: AnsiString): AnsiString;
var
  I: Integer;
begin
  I:= Length(S)-2;
  while S[I]=' ' do
    Dec(I);
  Result:= Copy(S, 1, I)+Copy(S, Length(S)-1, 2);
end;

function SentenceCapitalize(const S: AnsiString; Locale: TLanguage): AnsiString;
begin
  Result:= S;
  LCMapString(Locale, LCMAP_Uppercase, @Result[1], 1, @Result[1], 1);
end;

procedure TSpellerDialog.ShowForChange(Msg: TCaption);
var
  UnkWord: AnsiString;
begin
  //ShowMisspelling;
  InfoMsg.Caption:= Msg;
  CancelEdit.Hide;
  DelButton.Hide;
  ChangeButton.Show;
  SkipButton.Enabled:= True;
  SkipAllButton.Enabled:= Integer(ErrorKind)=scrsUnknownInputWord;
  AddButton.Enabled:= Integer(ErrorKind)=scrsUnknownInputWord;
  UnkWord:= Copy(Checker.InputBuffer.lrgch, Checker.ResultBuffer.ichError+1,
                 Checker.ResultBuffer.cchError);
  case Integer(ErrorKind) of
  scrsUnknownInputWord,
  scrsReturningChangeOnce,
  scrsInvalidHyphenation,
  scrsErrorCapitalization:
    Checker.GetVariants(UnkWord, Variants.Items);
  scrsNoSentenceStartCap:
    begin
      Variants.Items.Clear;
      Variants.Items.Add(SentenceCapitalize(UnkWord, Checker.Language));
    end;
  scrsExtraSpaces:
    begin
      Variants.Items.Clear;
      Variants.Items.Add(DelExtraSpaces(UnkWord));
    end;
  end;
  Variants.ItemIndex:= 0;
  ChangeButton.Enabled:= Variants.ItemIndex=0;
  ChangeAllButton.Enabled:= (Variants.ItemIndex=0) and (Integer(ErrorKind)=scrsUnknownInputWord);
  Variants.Enabled:= Variants.ItemIndex=0;
  if not Visible then
    ShowModal;
end;

procedure TSpellerDialog.ShowForEdit(Msg: TCaption);
var
  UnkWord: AnsiString;
begin
  //ShowMisspelling;
  InfoMsg.Caption:= Msg;
  CancelEdit.Hide;
  DelButton.Hide;
  ChangeButton.Show;
  SkipButton.Enabled:= True;
  SkipAllButton.Enabled:= false;
  AddButton.Enabled:= False;
  UnkWord:= Copy(Checker.InputBuffer.lrgch, Checker.ResultBuffer.ichError+1,
                 Checker.ResultBuffer.cchError);
  Variants.Items.Clear;
  ChangeButton.Enabled:= False;
  ChangeAllButton.Enabled:= False;
  Variants.Enabled:= False;
  if not Visible then
    ShowModal;
end;

procedure TSpellerDialog.ShowForDelete;
begin
  //ShowMisspelling;
  InfoMsg.Caption:= spsRepeatedWord;
  CancelEdit.Hide;
  DelButton.Show;
  ChangeButton.Hide;
  ChangeAllButton.Enabled:= False;
  SkipButton.Show;
  SkipAllButton.Enabled:= False;
  AddButton.Enabled:= False;
  if not Visible then
    ShowModal;
end;

procedure TSpellerDialog.ShowMisspelling;
var
  CurStr: AnsiString;
  I: Integer;
  P, PS, PE: PAnsiChar;
begin
  FShowing:= True;
  P:= Checker.InputBuffer.lrgch+Checker.ResultBuffer.ichError;
  PS:= P;
  PE:= P;
  while (PS>@Checker.CheckStr[1]) and not (PS^ in [#13, #10]) do
    Dec(PS);
  if PS^ in [#13, #10] then
    Inc(PS);
  while not (PE^ in [#0, #13, #10]) do
    Inc(PE);
  with Misspelling do
    begin
      Lines.Clear;
      SelAttributes.Charset:= Variants.Font.CharSet;
      Lines.Add(Copy(PS, 1, PE-PS));
      SelectAll;
      SelAttributes.Color:= clWindowText;
      SelAttributes.Protected:= True;
      SelStart:= P-PS;
      SelLength:= Checker.ResultBuffer.cchError;
      SelAttributes.Protected:= False;
      SelAttributes.Color:= clRed;
      SelLength:= 0;
    end;
  FShowing:= False;
end;

procedure TSpellerDialog.MisspellingProtectChange(Sender: TObject;
  StartPos, EndPos: Integer; var AllowChange: Boolean);
begin
  AllowChange:= FShowing;
end;

procedure TSpellerDialog.MisspellingChange(Sender: TObject);
begin
  if FShowing then
    Exit;
  CancelEdit.Show;
  ChangeButton.Show;
  ChangeButton.Enabled:= True;
  ChangeAllButton.Enabled:= False;
  SkipAllButton.Enabled:= False;
  AddButton.Enabled:= False;
  DelButton.Hide;
  Variants.Enabled:= False;
end;

procedure TSpellerDialog.GetHotArea(var SS, SL: Integer);
var
  I: Integer;
begin
  with Misspelling do
    begin
      SelLength:= 0;
      for I:= 0 to Length(UnwrappedText(Misspelling))-1 do
        begin
          SelStart:= I;
          if not SelAttributes.Protected then
            begin
              SS:= I;
              Break;
            end;
        end;
      for I:= SS to Length(UnwrappedText(Misspelling)) do
        begin
          SelStart:= I;
          if SelAttributes.Protected then
            begin
              SL:= I-SS-1;
              Exit;
            end;
        end;
      SL:= Length(Misspelling.Lines[0])-SS;
    end;
end;

procedure TSpellerDialog.CancelEditClick(Sender: TObject);
var
  SS, SL: Integer;
  UnkWord: AnsiString;
begin
  GetHotArea(SS, SL);
  UnkWord:= Copy(Checker.InputBuffer.lrgch, Checker.ResultBuffer.ichError+1,
                 Checker.ResultBuffer.cchError);
  with Misspelling do
    begin
      SelStart:= SS;
      SelLength:= SL;
      SelText:= UnkWord;
      SelLength:= 0;
    end;
  case Integer(ErrorKind) of
  scrsUnknownInputWord,
  scrsReturningChangeOnce,
  scrsInvalidHyphenation,
  scrsErrorCapitalization,
  scrsNoSentenceStartCap,
  scrsExtraSpaces:
    begin
      DelButton.Hide;
      ChangeButton.Show;
      SkipButton.Enabled:= True;
      SkipAllButton.Enabled:= Integer(ErrorKind)=scrsUnknownInputWord;
      AddButton.Enabled:= Integer(ErrorKind)=scrsUnknownInputWord;
      ChangeAllButton.Enabled:= (Variants.ItemIndex=0) and (Integer(ErrorKind)=scrsUnknownInputWord);
      ChangeAllButton.Enabled:= Variants.ItemIndex=0;
      Variants.Enabled:= Variants.ItemIndex=0;
    end;
  scrsRepeatWord:
    begin
      DelButton.Show;
      ChangeButton.Hide;
      ChangeAllButton.Enabled:= False;
      SkipButton.Show;
      SkipAllButton.Enabled:= False;
      AddButton.Enabled:= False;
    end;
  scrsWordConsideredAbbreviation,
  scrsMissingSpace,
  scrsInitialNumeral:
    begin
      DelButton.Hide;
      ChangeButton.Show;
      SkipButton.Enabled:= True;
      SkipAllButton.Enabled:= false;
      AddButton.Enabled:= False;
      ChangeButton.Enabled:= False;
      ChangeAllButton.Enabled:= False;
      Variants.Enabled:= False;
    end;
  end;
  CancelEdit.Hide;
end;

function GetSpellLanguages(Languages: TStrings; Option: TLangOption): Integer;
var
  Registry: TRegistry;
  N, I: Integer;
  LCType: Integer;
  Buf: array[0..255]of Char;
begin
  Registry:= TRegistry.Create;
  Registry.RootKey:= HKEY_LOCAL_MACHINE;
  Registry.OpenKey('\SOFTWARE\Microsoft\Shared Tools\Proofing Tools\Spelling', False);
  Registry.GetKeyNames(Languages);
  Registry.Free;
  Result:= Languages.Count;
  case Option of
  loLocalized:
    LCType:= LOCALE_SLanguage;
  loEnglish:
    LCType:= LOCALE_SEngLanguage;
  loNative:
    LCType:= LOCALE_SNativeLangName;
  loAbbrev:
    LCType:= LOCALE_SAbbrevLangName;
  end;
  for I:= Languages.Count-1 downto 0 do
    begin
      N:= StrToIntDef(Languages[I], -1);
      if N=-1 then
        Languages.Delete(I)
      else
        begin
          Languages.Objects[I]:= Pointer(N);
          GetLocaleInfo(N, LCType, Buf, 255);
          Languages[I]:= Buf;
        end;
    end;
end;

end.
