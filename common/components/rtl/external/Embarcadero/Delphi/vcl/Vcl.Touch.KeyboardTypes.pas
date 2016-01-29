{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.Touch.KeyboardTypes;

interface

uses
  System.Generics.Collections, System.Classes;

type
  TKeyState = (ksDown, ksUp);
  TModifierState = set of (msShift, msCtrl, msAlt, msDiacritic);
  TKeyImage = (kiOverride = -2, kiText = -1, kiTab = 0, kiShift = 1, kiEnter = 2,
    kiBackspace = 3, kiUp = 4, kiDown = 5, kiLeft = 6, kiRight = 7, kiTallEnter = 8);
  TVirtualKeyFlag = (kfStretch, kfToggle, kfRepeat);
  TVirtualKeyFlags = set of TVirtualKeyFlag;

  // For internal use only.
  TKeyData = record
    Vk: SmallInt;
    ScanCode: SmallInt;

    class function Create: TKeyData; static;
  end;

  TKeyDataArray = array of TKeyData;

  // For internal use only.
  TKey = record
    Vk: SmallInt;
    ScanCode: SmallInt;
    Caption: string;
    KeyImage: TKeyImage;
    ComboKeys: TKeyDataArray;

    class function Create: TKey; static;
    function ToString(State: TModifierState = []): string;
    function IsDeadKey: Boolean;
    class operator Implicit(const AKey: TKey): TKeyData;
  end;

  // For internal use only.
  TKeyLanguage = record
    Vk: SmallInt;
    ScanCode: SmallInt;
    Caption: string;
    KeyImage: TKeyImage;
    ComboKeys: TKeyDataArray;
    Language: string;

    class function Create: TKeyLanguage; static;
  end;

  TKeyLanguages = array of TKeyLanguage;

  // For internal use only.
  TKeyModifier = record
    Vk: SmallInt;
    ScanCode: SmallInt;
    Caption: string;
    KeyImage: TKeyImage;
    ModifierName: string;
    Languages: TKeyLanguages;
    FontSize: Word;
    Language: string;

    class function Create: TKeyModifier; static;
    class operator Implicit(const AModifierKey: TKeyModifier): TKey;
  end;

  TKeyModifiers = array of TKeyModifier;

  // For internal use only.
  TVirtualKey = record
    Vk: SmallInt;
    ScanCode: SmallInt;
    Caption: string;
    KeyImage: TKeyImage;
    ComboKeys: TKeyDataArray;
    FontSize: Word;
    Width: Word;
    Height: Word;
    Flags: TVirtualKeyFlags;
    LeftMargin: Word;
    RightMargin: Word;
    Modifiers: TKeyModifiers;
    ModifierName: string;
    Languages: TKeyLanguages;
    GroupIndex: Word;
    PublishedName: string;

    class function Create: TVirtualKey; static;
    function Equals(const AVirtualKey: TVirtualKey): Boolean;
    class operator Implicit(const AVirtualKey: TVirtualKey): TKey;
  end;

  TVirtualKeys = class
  private
    FKeys: TList<TVirtualKey>;
    FTopMargin: Integer;
    FBottomMargin: Integer;

    function GetItem(Index: Integer): TVirtualKey;
    procedure SetItem(Index: Integer; const Value: TVirtualKey);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Add(var AKey: TVirtualKey);
    function Count: Integer;
    property Items[Index: Integer]: TVirtualKey read GetItem write SetItem; default;

    property TopMargin: Integer read FTopMargin write FTopMargin;
    property BottomMargin: Integer read FBottomMargin write FBottomMargin;
  end;

  // For internal use only.
  TKeyboardLanguage = record
    Language: string;
    Name: string;

    class function Create: TKeyboardLanguage; static;
  end;

  TVirtualKeyLayout = class
  private
    type
      TVirtualKeyboard = class(TList<TVirtualKeys>);
      TKeyboardLanguages = class(TList<TKeyboardLanguage>);

  private
    FLanguages: TKeyboardLanguages;
    FKeyboardName: string;
    FKeyboardType: string;
    FMinHeight: Integer;
    FWidth: Integer;
    FMinWidth: Integer;
    FHeight: Integer;
    FMaxWidth: Integer;
    FMaxHeight: Integer;
    FRowHeight: Integer;
    FKeys: TVirtualKeyboard;
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);

    property Languages: TKeyboardLanguages read FLanguages;
    property KeyboardName: string read FKeyboardName write FKeyboardName;
    property KeyboardType: string read FKeyboardType write FKeyboardType;
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
    property MinWidth: Integer read FMinWidth write FMinWidth;
    property MinHeight: Integer read FMinHeight write FMinHeight;
    property MaxWidth: Integer read FMaxWidth write FMaxWidth;
    property MaxHeight: Integer read FMaxHeight write FMaxHeight;
    property RowHeight: Integer read FRowHeight write FRowHeight;
    property Keys: TVirtualKeyboard read FKeys;
  end;

  TVirtualKeyLayouts = class(TList<TVirtualKeyLayout>)
  public
    destructor Destroy; override;
  end;

  TKeyboardLayout = type string;

function VKey(Vk, ScanCode: Integer): TKeyData;
function GetVirtualKey(const Key: TKeyData): TKeyData;
procedure StringToComboKeys(const Value: string; var Keys: TKeyDataArray);
function ComboKeysToString(const Keys: TKeyDataArray): string;

implementation

uses
  Winapi.Windows, System.SysUtils;

function VKey(Vk, ScanCode: Integer): TKeyData;
begin
  Result.Vk := Vk;
  Result.ScanCode := ScanCode;
end;

function GetVirtualKey(const Key: TKeyData): TKeyData;
begin
  if (Key.Vk = -1) and (Key.ScanCode >= 0) then
  begin
    Result.Vk := MapVirtualKey(Key.ScanCode, MAPVK_VSC_TO_VK);
    Result.ScanCode := Key.ScanCode;
  end
  else if (Key.Vk >= 0) and (Key.ScanCode = -1) then
  begin
    Result.Vk := Key.Vk;
    Result.ScanCode := MapVirtualKey(Key.Vk, MAPVK_VK_TO_VSC);
  end
  else if (Key.Vk >= 0) and (Key.ScanCode >= 0) then
  begin
    Result.Vk := Key.Vk;
    Result.ScanCode := Key.ScanCode;
  end
  else
    Result := TKeyData.Create;
end;

function InternalToUnicode(const Key: TKeyData; const KeyboardState: TKeyboardState;
  var DeadKey: Boolean): string; overload;
const
  TempSize = 64;
var
  TempStr: string;
  Size: Integer;
begin
  DeadKey := False;
  SetLength(TempStr, TempSize);
  ZeroMemory(@TempStr[1], TempSize * SizeOf(Char));
  Size := ToUnicode(Key.Vk, Key.ScanCode, KeyboardState, @TempStr[1], TempSize, 0);

  case Size of
    -1:
    begin
      DeadKey := True;

      // Fix painting on Windows XP.
      if not(CheckWin32Version(6, 0)) and (TempStr <> '') then
        Result := TempStr[1]
      else
        Result := TempStr;
      // Call ToUnicode again to clear the dead key from the internal buffer.
      ToUnicode(Key.Vk, Key.ScanCode, KeyboardState, @TempStr[1], TempSize, 0);
    end;
    0: ; // Do nothing when the size is zero.
    else
    begin
      ZeroMemory(@TempStr[1], TempSize * SizeOf(Char));
      // Call ToUnicode again to clear the dead key from the internal buffer.
      Size := ToUnicode(Key.Vk, Key.ScanCode, KeyboardState, @TempStr[1], TempSize, 0);
      begin
        Result := TempStr;
        SetLength(Result, Size);
      end;
    end;
  end;
end;

function InternalToUnicode(const Key: TKeyData; const KeyboardState: TKeyboardState): string; overload;
var
  DeadKey: Boolean;
begin
  Result := InternalToUnicode(Key, KeyboardState, DeadKey);
end;

procedure StringToComboKeys(const Value: string; var Keys: TKeyDataArray);

  function GetValue(const S, Name: string; var Value: string): Boolean;
  var
    P: PChar;
    LName, LValue: string;
  begin
    Result := False;
    P := @S[1];

    while P^ <> #0 do
    begin
      if P^ = '=' then
      begin
        Inc(P);
        Break;
      end;

      LName := LName + P^;
      Inc(P);
    end;

    if LName = Name then
    begin
      while P^ <> #0 do
      begin
        LValue := LValue + P^;
        Inc(P)
      end;

      Value := LValue;
      Result := True;
    end;
  end;

const
  cVK = 'vk';
  cScanCode = 'sc';
var
  Strings: TStrings;
  Index, StringsIndex: Integer;
  LValue: string;
begin
  Strings := TStringList.Create;
  try
    Strings.Delimiter := ';';
    Strings.DelimitedText := Value;
    Index := 0;
    StringsIndex := 0;
    SetLength(Keys, Strings.Count div 2);
    while Index < Length(Keys) do
    begin
      if GetValue(Strings[StringsIndex], cVk, LValue) then
        Keys[Index].Vk := StrToInt(LValue);
      if GetValue(Strings[StringsIndex + 1], cScanCode, LValue) then
        Keys[Index].ScanCode := StrToInt(LValue);
      Inc(Index);
      Inc(StringsIndex, 2);
    end;
  finally
    Strings.Free;
  end;
end;

function ComboKeysToString(const Keys: TKeyDataArray): string;
var
  Index: Integer;
begin
  for Index := 0 to Length(Keys) - 1 do
  begin
    if Index > 0 then
      Result := Result + ';';

    Result := Result + Format('vk=%d;sc=%d', [Keys[Index].Vk, Keys[Index].ScanCode]);
  end;
end;

{ TKeyModifier }

class function TKeyModifier.Create: TKeyModifier;
begin
  with Result do
  begin
    Caption := '';
    ModifierName := '';
    Vk := -1;
    ScanCode := -1;
    KeyImage := kiText;
    FontSize := 14;
    Language := '';
  end;
end;

class operator TKeyModifier.Implicit(const AModifierKey: TKeyModifier): TKey;
begin
  Result.Caption := AModifierKey.Caption;
  Result.KeyImage := AModifierKey.KeyImage;
  Result.Vk := AModifierKey.Vk;
  Result.ScanCode := AModifierKey.ScanCode;
  SetLength(Result.ComboKeys, 0);
end;

{ TVirtualKey }

class function TVirtualKey.Create: TVirtualKey;
begin
  with Result do
  begin
    Caption := '';
    KeyImage := kiText;
    Vk := -1;
    ScanCode := -1;
    SetLength(ComboKeys, 0);
    Width := 48;
    Height := 48;
    LeftMargin := 2;
    RightMargin := 2;
    Flags := [];
    SetLength(Modifiers, 0);
    ModifierName := '';
    GroupIndex := 0;
    SetLength(Languages, 0);
    PublishedName := '';
    FontSize := 14;
  end;
end;

function TVirtualKey.Equals(const AVirtualKey: TVirtualKey): Boolean;
begin
  Result := False;

  if (Length(ComboKeys) = 0) and (Length(AVirtualKey.ComboKeys) = 0) then
  begin
    if ((ScanCode <> -1) or (AVirtualKey.ScanCode = -1)) and
      ((Vk <> -1) or (AVirtualKey.Vk <> -1)) then
    begin
      Result := (ScanCode = AVirtualKey.ScanCode) and (Vk = AVirtualKey.Vk);
    end
    else if ((ScanCode = -1) or (AVirtualKey.ScanCode = -1)) then
      Result := Vk = AVirtualKey.Vk
    else if ((Vk = -1) or (AVirtualKey.Vk = -1)) then
      Result := ScanCode = AVirtualKey.ScanCode
  end;
end;

class operator TVirtualKey.Implicit(const AVirtualKey: TVirtualKey): TKey;
begin
  Result.Caption := AVirtualKey.Caption;
  Result.KeyImage := AVirtualKey.KeyImage;
  Result.Vk := AVirtualKey.Vk;
  Result.ScanCode := AVirtualKey.ScanCode;
  Result.ComboKeys := AVirtualKey.ComboKeys;
  if Length(Result.ComboKeys) > 0 then
  begin
    Result.ScanCode := -1;
    Result.Vk := -1;
  end;
end;

{ TKeyLanguage }

class function TKeyLanguage.Create: TKeyLanguage;
begin
  with Result do
  begin
    Caption := '';
    Vk := -1;
    ScanCode := -1;
    SetLength(ComboKeys, 0);
    Language := '';
    KeyImage := kiText;
  end;
end;

{ TKey }

class function TKey.Create: TKey;
begin
  with Result do
  begin
    Caption := '';
    KeyImage := kiText;
    Vk := -1;
    ScanCode := -1;
    SetLength(ComboKeys, 0);
  end;
end;

class operator TKey.Implicit(const AKey: TKey): TKeyData;
begin
  Result.Vk := AKey.Vk;
  Result.ScanCode := AKey.ScanCode;
end;

function TKey.IsDeadKey: Boolean;
var
  KeyboardState: TKeyboardState;
begin
  GetKeyboardState(KeyboardState);
  InternalToUnicode(GetVirtualKey(VKey(Vk, ScanCode)), KeyboardState, Result);
end;

function TKey.ToString(State: TModifierState = []): string;
var
  KeyboardState: TKeyboardState;
begin
  ZeroMemory(@KeyboardState[0], Length(KeyboardState));

  if msShift in State then
    KeyboardState[VK_SHIFT] := $81;

  Result := InternalToUnicode(GetVirtualKey(VKey(Vk, ScanCode)), KeyboardState);
end;

{ TVirtualKeyLayout }

constructor TVirtualKeyLayout.Create;
begin
  inherited;
  FLanguages := TKeyboardLanguages.Create;
  FMinWidth := 0;
  FMinHeight := 0;
  FMaxWidth := 0;
  FMaxHeight := 0;
  FRowHeight := 48;
  FKeys := TVirtualKeyboard.Create;
end;

destructor TVirtualKeyLayout.Destroy;
var
  Index: Integer;
begin
  for Index := 0 to FKeys.Count - 1 do
    FKeys[Index].Free;
  FKeys.Free;
  FLanguages.Free;
  inherited;
end;

procedure TVirtualKeyLayout.LoadFromStream(Stream: TStream);

  function ReadSmallInt: SmallInt;
  begin
    Stream.Read(Result, SizeOf(Result));
  end;

  function ReadBool: Boolean;
  begin
    Stream.Read(Result, SizeOf(Result));
  end;

  function ReadByte: Byte;
  begin
    Stream.Read(Result, SizeOf(Byte))
  end;

  function ReadWord: Word;
  begin
    Stream.Read(Result, SizeOf(Word));
  end;

  function ReadString: string;
  var
    Count: Byte;
    Bytes: TBytes;
  begin
    Stream.Read(Count, SizeOf(Count));
    if Count > 0 then
    begin
      SetLength(Bytes, Count);
      ZeroMemory(@Bytes[0], Length(Bytes));
      Stream.Read(Bytes[0], Count);
      Result := TEncoding.Unicode.GetString(Bytes);
    end
    else
      Result := '';
  end;

var
  Index, RowIndex, KeyIndex, ModifierIndex, ComboKeysIndex, ModifierLangIndex: Integer;
  ModifierCount, ComboKeysCount, ModifierLangCount: Integer;
  Key: TVirtualKey;
  KeyModifier: TKeyModifier;
  KeyLanguage: TKeyLanguage;
  Row: TVirtualKeys;
  Version: Integer;
  KeyboardLanguage: TKeyboardLanguage;
begin
  Version := ReadByte;

  if Version = 1 then
  begin
    KeyboardName := ReadString;
    KeyboardType := ReadString;
    Width := ReadWord;
    Height := ReadWord;
    MinWidth := ReadWord;
    MinHeight := ReadWord;
    MaxWidth := ReadWord;
    MaxHeight := ReadWord;
    RowHeight := ReadWord;

    for Index := ReadWord - 1 downto 0 do
    begin
      KeyboardLanguage := TKeyboardLanguage.Create;
      KeyboardLanguage.Language := ReadString;
      KeyboardLanguage.Name := ReadString;
      Languages.Add(KeyboardLanguage);
    end;

    for RowIndex := ReadWord - 1 downto 0 do
    begin
      Row := TVirtualKeys.Create;
      Keys.Add(Row);
      Row.TopMargin := ReadByte;
      Row.BottomMargin := ReadByte;

      for KeyIndex := ReadWord - 1 downto 0 do
      begin
        Key := TVirtualKey.Create;
        Key.Caption := ReadString;
        Key.KeyImage := TKeyImage(ReadByte);
        Key.Vk := ReadSmallInt;
        Key.ScanCode := ReadSmallInt;

        ComboKeysCount := ReadWord;
        SetLength(Key.ComboKeys, ComboKeysCount);

        for ComboKeysIndex := 0 to ComboKeysCount - 1 do
        begin
          Key.ComboKeys[ComboKeysIndex].Vk := ReadSmallInt;
          Key.ComboKeys[ComboKeysIndex].ScanCode := ReadSmallInt;
        end;

        Key.Width := ReadWord;
        Key.Height := ReadWord;
        Key.LeftMargin := ReadByte;
        Key.RightMargin := ReadByte;
        Key.Flags := TVirtualKeyFlags(Byte(ReadByte));
        Key.GroupIndex := ReadWord;
        Key.ModifierName := ReadString;
        Key.PublishedName := ReadString;
        Key.FontSize := ReadWord;

        ModifierCount := ReadWord;
        SetLength(Key.Modifiers, ModifierCount);

        for ModifierIndex := ModifierCount - 1 downto 0 do
        begin
          KeyModifier := TKeyModifier.Create;
          KeyModifier.Caption := ReadString;
          KeyModifier.Vk := ReadSmallInt;
          KeyModifier.ScanCode := ReadSmallInt;
          KeyModifier.KeyImage := TKeyImage(ReadByte);
          KeyModifier.ModifierName := ReadString;
          KeyModifier.FontSize := ReadWord;
          KeyModifier.Language := ReadString;

          ModifierLangCount := ReadWord;
          SetLength(KeyModifier.Languages, ModifierLangCount);

          for ModifierLangIndex := ModifierLangCount - 1 downto 0 do
          begin
            KeyLanguage := TKeyLanguage.Create;
            KeyLanguage.Caption := ReadString;
            KeyLanguage.Vk := ReadSmallInt;
            KeyLanguage.ScanCode := ReadSmallInt;
            KeyLanguage.KeyImage := TKeyImage(ReadByte);
            KeyLanguage.Language := ReadString;

            KeyModifier.Languages[ModifierLangIndex] := KeyLanguage;
          end;

          Key.Modifiers[ModifierIndex] := KeyModifier;
        end;

        ModifierLangCount := ReadWord;
        SetLength(Key.Languages, ModifierLangCount);

        for ModifierLangIndex := ModifierLangCount - 1 downto 0 do
        begin
          KeyLanguage := TKeyLanguage.Create;
          KeyLanguage.Caption := ReadString;
          KeyLanguage.Vk := ReadSmallInt;
          KeyLanguage.ScanCode := ReadSmallInt;

          ComboKeysCount := ReadWord;
          SetLength(KeyLanguage.ComboKeys, ComboKeysCount);

          for ComboKeysIndex := 0 to ComboKeysCount - 1 do
          begin
            KeyLanguage.ComboKeys[ComboKeysIndex].Vk := ReadSmallInt;
            KeyLanguage.ComboKeys[ComboKeysIndex].ScanCode := ReadSmallInt;
          end;

          KeyLanguage.KeyImage := TKeyImage(ReadByte);
          KeyLanguage.Language := ReadString;

          Key.Languages[ModifierLangIndex] := KeyLanguage;
        end;

        Row.Add(Key);
      end;
    end;
  end;
end;

procedure TVirtualKeyLayout.SaveToStream(Stream: TStream);

  procedure WriteSmallInt(Value: SmallInt);
  begin
    Stream.Write(Value, SizeOf(Value));
  end;

  procedure WriteWord(Value: Word);
  begin
    Stream.Write(Value, SizeOf(Value));
  end;

  procedure WriteByte(Value: Byte);
  begin
    Stream.Write(Value, SizeOf(Value));
  end;

  procedure WriteBool(Value: Boolean);
  begin
    Stream.Write(Value, SizeOf(Value));
  end;

  procedure WriteString(const Value: string);
  var
    Bytes: TBytes;
    Count: Byte;
  begin
    Bytes := TEncoding.Unicode.GetBytes(Value);
    Count := Length(Bytes);
    Stream.Write(Count, SizeOf(Count));
    if Count > 0 then
      Stream.Write(Bytes[0], Count);
  end;

var
  Index, RowIndex, KeyIndex, ModifierIndex, ComboKeysIndex, ModifierLangIndex: Integer;
  Key: TVirtualKey;
  KeyModifier: TKeyModifier;
  KeyLanguage: TKeyLanguage;
  KeyboardLanguage: TKeyboardLanguage;
begin
  // Write version
  WriteByte(1);

  WriteString(Self.KeyboardName);
  WriteString(Self.KeyboardType);
  WriteWord(Self.Width);
  WriteWord(Self.Height);
  WriteWord(Self.MinWidth);
  WriteWord(Self.MinHeight);
  WriteWord(Self.MaxWidth);
  WriteWord(Self.MaxHeight);
  WriteWord(Self.RowHeight);

  WriteWord(Self.Languages.Count);

  for Index := 0 to Self.Languages.Count - 1 do
  begin
    KeyboardLanguage := Self.Languages[Index];
    WriteString(KeyboardLanguage.Language);
    WriteString(KeyboardLanguage.Name);
  end;

  WriteWord(Keys.Count); // write rows

  for RowIndex := 0 to Keys.Count - 1 do
  begin
    WriteByte(Keys[RowIndex].TopMargin);
    WriteByte(Keys[RowIndex].BottomMargin);
    WriteWord(Keys[RowIndex].Count);

    for KeyIndex := 0 to Keys[RowIndex].Count - 1 do
    begin
      Key := Keys[RowIndex][KeyIndex];
      WriteString(Key.Caption);
      WriteByte(Byte(Key.KeyImage));
      WriteSmallInt(Key.Vk);
      WriteSmallInt(Key.ScanCode);

      WriteWord(Length(Key.ComboKeys));

      for ComboKeysIndex := 0 to Length(Key.ComboKeys) - 1 do
      begin
        WriteSmallInt(Key.ComboKeys[ComboKeysIndex].Vk);
        WriteSmallInt(Key.ComboKeys[ComboKeysIndex].ScanCode);
      end;

      WriteWord(Key.Width);
      WriteWord(Key.Height);
      WriteByte(Key.LeftMargin);
      WriteByte(Key.RightMargin);
      WriteByte(Byte(Key.Flags));
      WriteWord(Key.GroupIndex);
      WriteString(Key.ModifierName);
      WriteString(Key.PublishedName);
      WriteWord(Key.FontSize);

      WriteWord(Length(Key.Modifiers));

      for ModifierIndex := 0 to Length(Key.Modifiers) - 1 do
      begin
        KeyModifier := Key.Modifiers[ModifierIndex];
        WriteString(KeyModifier.Caption);
        WriteSmallInt(KeyModifier.Vk);
        WriteSmallInt(KeyModifier.ScanCode);
        WriteByte(Byte(KeyModifier.KeyImage));
        WriteString(KeyModifier.ModifierName);
        WriteWord(KeyModifier.FontSize);
        WriteString(KeyModifier.Language);

        WriteWord(Length(KeyModifier.Languages));

        for ModifierLangIndex := 0 to Length(KeyModifier.Languages) - 1 do
        begin
          KeyLanguage := KeyModifier.Languages[ModifierLangIndex];
          WriteString(KeyLanguage.Caption);
          WriteSmallInt(KeyLanguage.Vk);
          WriteSmallInt(KeyLanguage.ScanCode);
          WriteByte(Byte(KeyLanguage.KeyImage));
          WriteString(KeyLanguage.Language);
        end;
      end;

      WriteWord(Length(Key.Languages));

      for ModifierLangIndex := 0 to Length(Key.Languages) - 1 do
      begin
        KeyLanguage := Key.Languages[ModifierLangIndex];
        WriteString(KeyLanguage.Caption);
        WriteSmallInt(KeyLanguage.Vk);
        WriteSmallInt(KeyLanguage.ScanCode);

        WriteWord(Length(KeyLanguage.ComboKeys));

        for ComboKeysIndex := 0 to Length(KeyLanguage.ComboKeys) - 1 do
        begin
          WriteSmallInt(KeyLanguage.ComboKeys[ComboKeysIndex].Vk);
          WriteSmallInt(KeyLanguage.ComboKeys[ComboKeysIndex].ScanCode);
        end;

        WriteByte(Byte(KeyLanguage.KeyImage));
        WriteString(KeyLanguage.Language);
      end;
    end;
  end;
end;

{ TVirtualKeyLayouts }

destructor TVirtualKeyLayouts.Destroy;
var
  Index: Integer;
begin
  for Index := 0 to Count - 1 do
    Items[Index].Free;
  inherited;
end;

{ TVirtualKeys }

procedure TVirtualKeys.Add(var AKey: TVirtualKey);
begin
  FKeys.Add(AKey);
end;

function TVirtualKeys.Count: Integer;
begin
  Result := FKeys.Count;
end;

constructor TVirtualKeys.Create;
begin
  FKeys := TList<TVirtualKey>.Create;
  FTopMargin := 0;
  FBottomMargin := 0;
end;

destructor TVirtualKeys.Destroy;
begin
  FKeys.Free;
  inherited;
end;

function TVirtualKeys.GetItem(Index: Integer): TVirtualKey;
begin
  Result := FKeys[Index];
end;

procedure TVirtualKeys.SetItem(Index: Integer; const Value: TVirtualKey);
begin
  FKeys[Index] := Value;
end;

{ TKeyboardLanguage }

class function TKeyboardLanguage.Create: TKeyboardLanguage;
begin
  Result.Language := '';
  Result.Name := '';
end;

{ TKeyData }

class function TKeyData.Create: TKeyData;
begin
  Result.Vk := 0;
  Result.ScanCode := 0;
end;

end.
