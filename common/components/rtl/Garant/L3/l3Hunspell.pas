unit l3Hunspell;

interface

uses
  Types, SysUtils,
  l3Base,
  l3Interfaces,
  l3SpellMisc,
  l3SpellIntf;

type
//{$IF not Declared(PPAnsiCharArray)}
//  TPAnsiCharArray = packed array[0..(MaxLongint div SizeOf(PAnsiChar))-1] of PAnsiChar;
//  PPAnsiCharArray = ^TPAnsiCharArray;
//{$IFEND}

//{$IF Declared(UnicodeString)}
//  TAnsiStringDynArray = array of AnsiString;
//  TUnicodeStringDynArray = TStringDynArray;
//{$ELSE}
//  TAnsiStringDynArray = TStringDynArray;
//  UnicodeString = type WideString;
//  TUnicodeStringDynArray = array of UnicodeString;
//{$IFEND}

  EHunspellError = class(Exception);

  THunHandle = type Pointer;
  THunGetListFunc = function (Handle: THunHandle; var List: PPAnsiCharArray;
    const Word: PAnsiChar): Integer; cdecl;
  TIncompatCharBehaviour = (icUseDefault, icBestFit, icError);

  THunspell = class(Tl3Base, ISpeller)
  private
    class function CheckDLLInitialize(RaiseExceptionIfFail: Boolean; const LibName: string = ''): Boolean;
  private
    fAffixFileName: string;
    fCodePage: Word;
    fDictionaryFileName: string;
    fHandle: THunHandle;
    fHasNativeCodePage: Boolean;

    function GetHandle: THunHandle;
  protected
    procedure Cleanup; override;

    function  AnsiToDLLString(const S: AnsiString; IncompatCharBehaviour: TIncompatCharBehaviour): AnsiString;
    function  DLLStringToAnsiString(const S: PAnsiChar): AnsiString;
    function  DLLToUnicodeString(const S: PAnsiChar): UnicodeString;
    function  UnicodeToDLLString(const S: UnicodeString; IncompatCharBehaviour: TIncompatCharBehaviour): AnsiString;
    procedure CallListFunc(const Word: UnicodeString; const Func: THunGetListFunc; aAddFunc : TllAddUStrProc); overload;
    procedure CallListFunc(const Word: AnsiString;    const Func: THunGetListFunc; aAddFunc : TllAddStrProc);  overload;
    procedure HandleNeeded; {$IF CompilerVersion >= 18}inline;{$IFEND}

  public
    class function IsLibraryInstalled: Boolean;
    class function LibraryName: string;
    class function TryLoadLibrary(const Name: string): Boolean;
  public
    constructor Create;
    //destructor Destroy; override;
    { basic methods - call LoadDictionary before anything else }
    procedure LoadDictionary(const FileName: string); overload;
    procedure LoadDictionary(const aDictionaryFileName, aAffixFileName: string; const aKey: string = ''); overload;

    function CheckSpell(const Word: UnicodeString): Boolean; overload;
    function CheckSpell(const Word: AnsiString): Boolean; overload;
    function CheckSpell(const Word: Tl3PCharLenPrim): Boolean; overload;

    procedure GetSuggestions(const Word: UnicodeString; aAddFunc : TllAddUStrProc); overload;
    procedure GetSuggestions(const Word: AnsiString; aAddFunc : TllAddStrProc); overload;
    procedure GetSuggestions(const Word: Tl3PCharLenPrim; aAddFunc : TllAddStrProc); overload;

    { add/remove custom words; these will be reset when the dictionary is changed }
    procedure AddCustomWord(const Word: UnicodeString; const AffixModel: UnicodeString = '');
    function HasIncompatibleChar(const Word: UnicodeString): LongBool;
    function RemoveCustomWord(const Word: UnicodeString): Boolean;
    function TryAddCustomWord(const Word: UnicodeString; const AffixModel: UnicodeString = ''): Boolean;

    { these methods act on known words }
    //function Analyze(const Word: UnicodeString): TUnicodeStringDynArray; overload;
    //function Analyze(const Word: AnsiString): TAnsiStringDynArray;       overload;
    procedure Stem(const Word: UnicodeString; aAddFunc : TllAddUStrProc); overload;
    procedure Stem(const Word: AnsiString; aAddFunc : TllAddStrProc);     overload;
    procedure Stem(const Word: Tl3PCharLenPrim; aAddFunc : TllAddStrProc); overload;
    //function Generate(const aWord: AnsiString; const aSampleWord: AnsiString) : TAnsiStringDynArray;

    { properties }
    property AffixFileName: string read FAffixFileName;
    property CodePage: Word read FCodePage; //for info only; any needed conversions will be done automatically
    property DictionaryFileName: string read FDictionaryFileName;
    property Handle: THunHandle read GetHandle;
    property HasNativeCodePage: Boolean read FHasNativeCodePage;
  end;

resourcestring
  SCouldNotAddCustomWord = 'Could not add custom word ''%s''';
  SCouldNotAddCustomWordWithAffix = 'Could not add custom word ''%s'' with affix model ''%s''';
  SHunspellDLLAleadyLoaded = 'Hunspell DLL already loaded';
  SHunspellDLLNotFound = 'Hunspell DLL not found';
  SHunspellHandleNeeded = 'Operation requires a dictionary to be loaded first';
  SContainsInvalidChars = 'Invalid word: ''%s'' contains characters that cannot ' +
    'be represented in the loaded dictionary''s codepage';

implementation

uses
  l3String,
  Windows, StrUtils;

{$IF not Declared(WC_NO_BEST_FIT_CHARS)}
const
  WC_NO_BEST_FIT_CHARS = $400;
{$IFEND}

function AsciiLowerCase(const S: AnsiString): AnsiString;
begin
  SetString(Result, PAnsiChar(S), Length(S));
  StrLower(PAnsiChar(Result));
end;

function AsciiStartsStr(const ASubText, AText: AnsiString): Boolean;
begin
  Result := (StrLComp(PAnsiChar(ASubText), PAnsiChar(AText), Length(ASubText)) = 0);
end;

{$IF not Declared(RightBStr)}
function RightBStr(const AText: AnsiString; const AByteCount: Integer): AnsiString;
begin
  Result := Copy(AText, Length(AText) + 1 - AByteCount, AByteCount);
end;
{$IFEND}

var
  HunLib: HMODULE = 0;
  Hunspell_create: function (const affpath, dpath: PAnsiChar): THunHandle; cdecl;
  Hunspell_create_key: function (const affpath, dpath, key: PAnsiChar): THunHandle; cdecl;
  Hunspell_destroy: procedure (Handle: THunHandle); cdecl;
  Hunspell_spell: function (Handle: THunHandle; const Word: PAnsiChar): Integer; cdecl;
  Hunspell_get_dic_encoding: function (Handle: THunHandle): PAnsiChar; cdecl;
  Hunspell_suggest: THunGetListFunc;
  Hunspell_analyze: THunGetListFunc;
  Hunspell_stem: THunGetListFunc;
  Hunspell_generate: function (Handle: THunHandle; var List: PPAnsiCharArray; const aWord: PAnsiChar; const aSampleWord: PAnsiChar): Integer; cdecl;
  Hunspell_generate2: function (Handle: THunHandle; var List: PPAnsiCharArray; const aWord: PAnsiChar; const aAffix: PAnsiChar; aCnt : integer): Integer; cdecl;
  Hunspell_add: function (Handle: THunHandle; const Word: PAnsiChar): Integer; cdecl;
  Hunspell_add_with_affix: function (Handle: THunHandle; const Word, Example: PAnsiChar): Integer; cdecl;
  Hunspell_remove: function (Handle: THunHandle; const Word: PAnsiChar): Integer; cdecl;
  Hunspell_free_list: procedure (Handle: THunHandle; var List: PPAnsiCharArray; Count: Integer); cdecl;

function LoadEntryPoints: Boolean;
begin
  Result := False;
  if HunLib = 0 then Exit;
  @Hunspell_create := GetProcAddress(HunLib, 'Hunspell_create');
  if not Assigned(Hunspell_create) then Exit;
  @Hunspell_create_key := GetProcAddress(HunLib, 'Hunspell_create_key');
  if not Assigned(Hunspell_create_key) then Exit;
  @Hunspell_destroy := GetProcAddress(HunLib, 'Hunspell_destroy');
  if not Assigned(Hunspell_destroy) then Exit;
  @Hunspell_spell := GetProcAddress(HunLib, 'Hunspell_spell');
  if not Assigned(Hunspell_spell) then Exit;
  @Hunspell_get_dic_encoding := GetProcAddress(HunLib, 'Hunspell_get_dic_encoding');
  if not Assigned(Hunspell_get_dic_encoding) then Exit;
  @Hunspell_suggest := GetProcAddress(HunLib, 'Hunspell_suggest');
  if not Assigned(Hunspell_suggest) then Exit;
  @Hunspell_analyze := GetProcAddress(HunLib, 'Hunspell_analyze');
  if not Assigned(Hunspell_analyze) then Exit;
  @Hunspell_stem := GetProcAddress(HunLib, 'Hunspell_stem');
  if not Assigned(Hunspell_stem) then Exit;
  @Hunspell_generate := GetProcAddress(HunLib, 'Hunspell_generate');
  if not Assigned(Hunspell_generate) then Exit;
  @Hunspell_generate2 := GetProcAddress(HunLib, 'Hunspell_generate2');
  if not Assigned(Hunspell_generate2) then Exit;
  @Hunspell_add := GetProcAddress(HunLib, 'Hunspell_add');
  if not Assigned(Hunspell_add) then Exit;
  @Hunspell_add_with_affix := GetProcAddress(HunLib, 'Hunspell_add_with_affix');
  if not Assigned(Hunspell_add_with_affix) then Exit;
  @Hunspell_remove := GetProcAddress(HunLib, 'Hunspell_remove');
  if not Assigned(Hunspell_remove) then Exit;
  @Hunspell_free_list := GetProcAddress(HunLib, 'Hunspell_free_list');
  if Assigned(Hunspell_free_list) then Result := True;
end;

{ class methods }

class function THunspell.CheckDLLInitialize(RaiseExceptionIfFail: Boolean;
  const LibName: string = ''): Boolean;
begin
  Result := True;
  if HunLib <> 0 then
    if (LibName <> '') and not SameFileName(LibName, LibraryName) then
      raise EHunspellError.CreateRes(@SHunspellDLLAleadyLoaded)
    else
      Exit;
  if LibName <> '' then
    HunLib := SafeLoadLibrary(LibName)
  else
  begin
    HunLib := SafeLoadLibrary('hunspell.dll');
    //HunLib := SafeLoadLibrary('hunspell.dll');
    //if HunLib = 0 then HunLib := SafeLoadLibrary('libhunspell.dll');
  end;
  if LoadEntryPoints then Exit;
  if HunLib <> 0 then
  begin
    FreeLibrary(HunLib);
    HunLib := 0;
  end;
  if RaiseExceptionIfFail then
    raise EHunspellError.CreateRes(@SHunspellDLLNotFound)
  else
    Result := False;
end;

class function THunspell.IsLibraryInstalled: Boolean;
begin
  Result := CheckDLLInitialize(False)
end;

class function THunspell.LibraryName: string;
begin
  if IsLibraryInstalled then
    Result := GetModuleName(HunLib)
  else
    Result := '';
end;

class function THunspell.TryLoadLibrary(const Name: string): Boolean;
begin
  Result := CheckDLLInitialize(False, Name);
end;

{ instance mathods }

constructor THunspell.Create;
begin
  CheckDLLInitialize(True);
end;

procedure THunspell.Cleanup;
begin
  if FHandle <> nil then
  begin
   Hunspell_destroy(fHandle);
   fHandle := nil;
  end;
  inherited;
end;

procedure THunspell.HandleNeeded;
begin
  if FHandle = nil then raise EHunspellError.CreateRes(@SHunspellHandleNeeded);
end;

function THunspell.GetHandle: THunHandle;
begin
  HandleNeeded;
  Result := fHandle;
end;

procedure THunspell.LoadDictionary(const FileName: string);
begin
  LoadDictionary(ChangeFileExt(FileName, '.dic'), ChangeFileExt(FileName, '.aff'));
end;

procedure THunspell.LoadDictionary(const aDictionaryFileName, aAffixFileName: string; const aKey: string = '');
 const
  ISOLatin1 = 28591;
  WinLatin1 = 1252;
 var
  IntValue: Integer;
  S: AnsiString;
  SysCodePage: Word;
  lHandle: THunHandle;

 begin
  CheckDLLInitialize(True);
  if aKey <> '' then
   lHandle := Hunspell_create_key(PAnsiChar(AnsiString(aAffixFileName)), PAnsiChar(AnsiString(aDictionaryFileName)), PAnsiChar(AnsiString(aKey)))
  else
   lHandle := Hunspell_create(PAnsiChar(AnsiString(aAffixFileName)), PAnsiChar(AnsiString(aDictionaryFileName)));

  if fHandle <> nil then
   Hunspell_destroy(FHandle);

  Assert(lHandle <> nil);
  fHandle := lHandle;

  fAffixFileName := aAffixFileName;
  fDictionaryFileName := aDictionaryFileName;
  SysCodePage := GetACP;
  S := AsciiLowerCase(Hunspell_get_dic_encoding(fHandle));
  if (S = 'utf8') or (S = 'utf-8') then
    fCodePage := CP_UTF8
  else
  begin
    fCodePage := SysCodePage;
    if AsciiStartsStr('iso', S) then
    begin
      if (S = 'iso-8859-1') or (S = 'iso8859-1') then
        FCodePage := ISOLatin1
      else if (S = 'iso-8859-2') or (S = 'iso8859-2') then
        FCodePage := 28592
      else if (S = 'iso-8859-3') or (S = 'iso8859-3') then
        FCodePage := 28593
      else if (S = 'iso-8859-4') or (S = 'iso8859-4') then
        FCodePage := 28594
      else if (S = 'iso-8859-5') or (S = 'iso8859-5') then
        FCodePage := 28595
      else if (S = 'iso-8859-6') or (S = 'iso8859-6') then
        FCodePage := 28596
      else if (S = 'iso-8859-7') or (S = 'iso8859-7') then
        FCodePage := 28597
      else if (S = 'iso-8859-8') or (S = 'iso8859-8') then
        FCodePage := 28598
      else if (S = 'iso-8859-9') or (S = 'iso8859-9') then
        FCodePage := 28599
      else if (S = 'iso-8859-13') or (S = 'iso8859-13') then
        FCodePage := 28603
      else if (S = 'iso-8859-15') or (S = 'iso8859-15') then
        FCodePage := 28605;
    end
    else if (S = 'koi8-r') or (S = 'koi8-u') then
      fCodePage := 20866
    else if (AsciiStartsStr('windows', S) or AsciiStartsStr('microsoft', S)) and
      TryStrToInt(string(RightBStr(S, 4)), IntValue) then
        fCodePage := Word(IntValue);
  end;
  FHasNativeCodePage := (fCodePage = SysCodePage) or
    ((fCodePage = ISOLatin1) and (SysCodePage = WinLatin1));

end;

procedure THunspell.CallListFunc(const Word: UnicodeString; const Func: THunGetListFunc; aAddFunc : TllAddUStrProc);
var
  List: PPAnsiCharArray;
  ListCount, I: Integer;

  lWideBuffer: array [0..511] of WideChar;
  lWideLen: Integer;

begin
  HandleNeeded;
  ListCount := Func(FHandle, List, PAnsiChar(UnicodeToDLLString(Word, icBestFit)));
  try
   //SetLength(Result, ListCount);
   for I := 0 to ListCount - 1 do
   begin
    lWideLen := MultiByteToWideChar(FCodePage, 0, List[I], -1, lWideBuffer, Length(lWideBuffer)) - 1;
    aAddFunc(lWideBuffer, lWideLen);
   //  Result[I] := DLLToUnicodeString(List[I]);
   end;
  finally
   Hunspell_free_list(FHandle, List, ListCount);
  end;
end;

procedure THunspell.CallListFunc(const Word: AnsiString; const Func: THunGetListFunc; aAddFunc : TllAddStrProc);
var
  List: PPAnsiCharArray;
  ListCount, I: Integer;
  lStr : AnsiString;
begin
  HandleNeeded;
  ListCount := Func(FHandle, List, PAnsiChar(AnsitoDLLString(Word, icBestFit)));
  try
   //SetLength(Result, ListCount);
   for I := 0 to ListCount - 1 do
   begin
    lStr := DLLStringToAnsiString(List[I]);
    aAddFunc(PAnsiChar(lStr), Length(lStr));
   end;
  finally
   Hunspell_free_list(FHandle, List, ListCount);
  end;
end;

function THunspell.DLLToUnicodeString(const S: PAnsiChar): UnicodeString;
var
  WideBuffer: array [0..511] of WideChar;
  WideLen: Integer;
begin
  WideLen := MultiByteToWideChar(FCodePage, 0, S, -1, WideBuffer, Length(WideBuffer)) - 1;
  SetString(Result, WideBuffer, WideLen)
end;

function THunspell.UnicodeToDLLString(const S: UnicodeString; IncompatCharBehaviour: TIncompatCharBehaviour): AnsiString;
const
  Flags: array[TIncompatCharBehaviour] of DWORD = (WC_NO_BEST_FIT_CHARS, 0, WC_NO_BEST_FIT_CHARS);
var
  AnsiBuffer: array[0..1023] of AnsiChar;
  AnsiLen: Integer;
  UsedDefaultChar: BOOL;
begin
  if FCodePage = CP_UTF8 then //MSDN: last two params *must* be nill if converting to UTF-8...
    AnsiLen := WideCharToMultiByte(FCodePage, 0, PWideChar(S),
      Length(S), AnsiBuffer, Length(AnsiBuffer), nil, nil)
  else
  begin
    AnsiLen := WideCharToMultiByte(FCodePage, Flags[IncompatCharBehaviour], PWideChar(S),
      Length(S), AnsiBuffer, Length(AnsiBuffer), nil, @UsedDefaultChar);
    if UsedDefaultChar and (IncompatCharBehaviour = icError) then
      raise EHunspellError.CreateResFmt(@SContainsInvalidChars, [string(S)]);
  end;
  SetString(Result, AnsiBuffer, AnsiLen);
end;

function THunspell.CheckSpell(const Word: UnicodeString): Boolean;
begin
  HandleNeeded;
  Result := (Hunspell_spell(FHandle, PAnsiChar(UnicodeToDLLString(Word, icUseDefault))) <> 0);
end;

procedure THunspell.GetSuggestions(const Word: UnicodeString; aAddFunc : TllAddUStrProc);
begin
  CallListFunc(Word, Hunspell_suggest, aAddFunc);
end;

procedure THunspell.AddCustomWord(const Word, AffixModel: UnicodeString);
var
  S: string;
begin
  if TryAddCustomWord(Word, AffixModel) then Exit;
  if AffixModel <> '' then
    S := SCouldNotAddCustomWordWithAffix
  else
    S := SCouldNotAddCustomWord;
  raise EHunspellError.CreateFmt(S, [Word, AffixModel]);
end;

function THunspell.HasIncompatibleChar(const Word: UnicodeString): LongBool;
var
  AnsiBuffer: array[0..1023] of AnsiChar;
begin
  Result := False;
  WideCharToMultiByte(FCodePage, WC_NO_BEST_FIT_CHARS, PWideChar(Word),
    Length(Word), AnsiBuffer, Length(AnsiBuffer), nil, @Result);
end;

function THunspell.RemoveCustomWord(const Word: UnicodeString): Boolean;
begin
  HandleNeeded;
  Result := (Hunspell_remove(FHandle, PAnsiChar(UnicodeToDLLString(Word, icUseDefault))) = 0);
end;

function THunspell.TryAddCustomWord(const Word, AffixModel: UnicodeString): Boolean;
begin
  HandleNeeded;
  if AffixModel <> '' then
    Result := (Hunspell_add_with_affix(FHandle, PAnsiChar(UnicodeToDLLString(Word,
      icError)), PAnsiChar(UnicodeToDLLString(AffixModel, icError))) = 0)
  else
    Result := (Hunspell_add(FHandle, PAnsiChar(UnicodeToDLLString(Word, icError))) = 0);
end;

//function THunspell.Analyze(const Word: UnicodeString): TUnicodeStringDynArray;
//begin
//  Result := CallListFunc(Word, Hunspell_analyze);
//end;

procedure THunspell.Stem(const Word: UnicodeString; aAddFunc : TllAddUStrProc);
begin
 CallListFunc(Word, Hunspell_stem, aAddFunc);
end;

function THunspell.AnsiToDLLString(const S: AnsiString; IncompatCharBehaviour: TIncompatCharBehaviour): AnsiString;
begin
  if HasNativeCodePage then
    Result := S
  else
    Result := UnicodeToDLLString(UnicodeString(S), IncompatCharBehaviour);
end;

function THunspell.DLLStringToAnsiString(const S: PAnsiChar): AnsiString;
begin
  if HasNativeCodePage then
    Result := S
  else
    Result := AnsiString(DLLToUnicodeString(S));
end;

function THunspell.CheckSpell(const Word: AnsiString): Boolean;
begin
  HandleNeeded;
  Result := (Hunspell_spell(FHandle, PAnsiChar(AnsiToDLLString(Word, icUseDefault))) <> 0);
end;

function THunspell.CheckSpell(const Word: Tl3PCharLenPrim): Boolean;
begin
  HandleNeeded;
  Result := (Hunspell_spell(FHandle, PAnsiChar(l3PCharLen2String(Word, CodePage))) <> 0);
end;

procedure THunspell.GetSuggestions(const Word: AnsiString; aAddFunc : TllAddStrProc);
begin
 CallListFunc(Word, Hunspell_suggest, aAddFunc);
end;

procedure THunspell.GetSuggestions(const Word: Tl3PCharLenPrim; aAddFunc : TllAddStrProc);
begin
 CallListFunc(l3PCharLen2String(Word, CodePage), Hunspell_suggest, aAddFunc);
end;

procedure THunspell.Stem(const Word: AnsiString; aAddFunc : TllAddStrProc);
begin
 CallListFunc(Word, Hunspell_stem, aAddFunc);
end;

procedure THunspell.Stem(const Word: Tl3PCharLenPrim; aAddFunc : TllAddStrProc);
begin
 CallListFunc(l3PCharLen2String(Word, CodePage), Hunspell_stem, aAddFunc);
end;

//function THunspell.Analyze(const Word: AnsiString): TAnsiStringDynArray;
//begin
// Result := CallListFunc(Word, Hunspell_stem);
//end;

(*
function THunspell.Generate(const aWord: AnsiString; const aSampleWord: AnsiString) : TAnsiStringDynArray;
var
  lList: PPAnsiCharArray;
  lListCount : Integer;
  I: Integer;
  //lAffix : PAnsiChar;
begin
  HandleNeeded;
  //lAffix := PAnsiChar(AnsitoDLLString(aSampleWord, icBestFit));
  //lListCount := Hunspell_generate2(FHandle, lList, PAnsiChar(AnsitoDLLString(aWord, icBestFit)), @lAffix, 1);
  lListCount := Hunspell_generate(FHandle, lList, PAnsiChar(AnsitoDLLString(aWord, icBestFit)), PAnsiChar(AnsitoDLLString(aSampleWord, icBestFit)));
  SetLength(Result, lListCount);
  for I := 0 to pred(lListCount) do
   Result[I] := DLLStringToAnsiString(lList[I]);
  Hunspell_free_list(FHandle, lList, lListCount);
end;
*)

initialization
finalization
  if HunLib <> 0 then FreeLibrary(HunLib);
end.

