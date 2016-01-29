unit Xml.Internal.WideStringUtils;

// WideStringUtils 1.0.9
// Delphi 4 to 2009 and Kylix 3 Implementation
// January 2012
//
//
// LICENSE
//
// The contents of this file are subject to the Mozilla Public License Version
// 1.1 (the "License"); you may not use this file except in compliance with
// the License. You may obtain a copy of the License at
// "http://www.mozilla.org/MPL/"
//
// Software distributed under the License is distributed on an "AS IS" basis,
// WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
// the specific language governing rights and limitations under the License.
//
// The Original Code is "WideStringUtils.pas".
//
// The Initial Developer of the Original Code is Dieter Köhler (Heidelberg,
// Germany, "http://www.philo.de/"). Portions created by the Initial Developer
// are Copyright (C) 2003-2009 Dieter Köhler. All Rights Reserved.
//
// Alternatively, the contents of this file may be used under the terms of the
// GNU General Public License Version 2 or later (the "GPL"), in which case the
// provisions of the GPL are applicable instead of those above. If you wish to
// allow use of your version of this file only under the terms of the GPL, and
// not to allow others to use your version of this file under the terms of the
// MPL, indicate your decision by deleting the provisions above and replace them
// with the notice and other provisions required by the GPL. If you do not delete
// the provisions above, a recipient may use your version of this file under the
// terms of any one of the MPL or the GPL.

// HISTORY
//
// 2012-01-21 1.0.9 Small revisions.
// 2009-02-23 1.0.8 UTF-16 surrogate functions added.
// 2009-09-28 1.0.7 Small revisions.
// 2007-12-03 1.0.6 Made .NET compliant.
// 2005-09-11 1.0.5 TrimSpace function added.
// 2005-07-23 1.0.4 EndsWideStr and StartsWideStr functions added.
// 2005-04-09 1.0.3 Bug fixes.
// 2004-12-11 1.0.2 Small additions.
// 2003-09-20 1.0.1 TranslateWideString function added.
// 2003-08-03 1.0.0

interface

uses
{$IFDEF CLR}
  System.Text,
{$ENDIF}
  System.SysUtils, System.Classes;

type
  TUtilsWideStringItem = record
{$IFDEF NEXTGEN}
    FString: string;
{$ELSE !NEXTGEN}
    FString: WideString;
{$ENDIF NEXTGEN}
    FObject: TObject;
  end;

  PUtilsWideStringItemList = ^TUtilsWideStringItemList;
  TUtilsWideStringItemList = array of TUtilsWideStringItem;

{$IFDEF CLR}

  // Since on the .NET platform the string type maps to the WideString class,
  // the TStringList class maintains a list of WideStrings, we can inherit
  // TUtilsWideStringList from TStringList.

  TUtilsWideStringList = class(TStringList)
  public
    procedure AddWideStrings(Strings: TUtilsWideStringList); virtual;
    function IndexOfLast(const S: WideString): Integer; virtual;
    property WideStrings[Index: Integer]: WideString read Get write Put; default;
  end;

{$ELSE}
  TUtilsWideStringList = class(TPersistent)
  private
    FCapacity: Integer;
    FCount: Integer;
    FDuplicates: TDuplicates;
    FList: TUtilsWideStringItemList;
    FSorted: Boolean;
    FUpdateCount: Integer;
    FOnChange: TNotifyEvent;
    FOnChanging: TNotifyEvent;
    procedure ExchangeItems(Index1,
      Index2: Integer);
    procedure Grow;
{$IFDEF NEXTGEN}
    procedure InsertItem(Index: Integer;
      const S: string;
      AObject: TObject);
{$ELSE !NEXTGEN}
    procedure InsertItem(Index: Integer;
      const S: WideString;
      AObject: TObject);
{$ENDIF NEXTGEN}
    procedure QuickSort(L,
      R: Integer);
    procedure SetSorted(const Value: Boolean);
  protected
    procedure Changed; virtual;
    procedure Changing; virtual;
{$IFDEF NEXTGEN}
    function Get(Index: Integer): string; virtual;
{$ELSE !NEXTGEN}
    function Get(Index: Integer): WideString; virtual;
{$ENDIF NEXTGEN}
    function GetCapacity: Integer; virtual;
    function GetCount: Integer; virtual;
    function GetObject(Index: Integer): TObject; virtual;
{$IFDEF NEXTGEN}
    procedure Put(Index: Integer;
      const S: string); virtual;
{$ELSE !NEXTGEN}
    procedure Put(Index: Integer;
      const S: WideString); virtual;
{$ENDIF NEXTGEN}
    procedure PutObject(Index: Integer;
      AObject: TObject); virtual;
    procedure SetCapacity(NewCapacity: Integer); virtual;
    procedure SetUpdateState(Updating: Boolean); virtual;
  public
    destructor Destroy; override;
{$IFDEF NEXTGEN}
    function Add(S: string): Integer; virtual;
    function AddObject(S: string; AObject: TObject): Integer; virtual;
{$ELSE !NEXTGEN}
    function Add(S: WideString): Integer; virtual;
    function AddObject(S: WideString; AObject: TObject): Integer; virtual;
{$ENDIF NEXTGEN}
    procedure AddWideStrings(Strings: TUtilsWideStringList); virtual;
{$IFDEF NEXTGEN}
    procedure Append(S: string); virtual;
{$ELSE !NEXTGEN}
    procedure Append(S: WideString); virtual;
{$ENDIF NEXTGEN}
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate; virtual;
    procedure Clear; virtual;
    procedure Delete(Index: Integer); virtual;
    procedure EndUpdate; virtual;
    procedure Exchange(Index1, Index2: Integer); virtual;
{$IFDEF NEXTGEN}
    function Find(const S: string;
      var Index: Integer): Boolean; virtual;
    function IndexOf(const S: string): Integer; virtual;
    function IndexOfLast(const S: string): Integer; virtual;
    procedure Insert(Index: Integer; const S: string); virtual;
    procedure InsertObject(Index: Integer; const S: string; AObject:
      TObject); virtual;
{$ELSE !NEXTGEN}
    function Find(const S: WideString;
      var Index: Integer): Boolean; virtual;
    function IndexOf(const S: WideString): Integer; virtual;
    function IndexOfLast(const S: WideString): Integer; virtual;
    procedure Insert(Index: Integer; const S: WideString); virtual;
    procedure InsertObject(Index: Integer; const S: WideString; AObject:
      TObject); virtual;
{$ENDIF NEXTGEN}
    procedure Sort; virtual;

    property Capacity: Integer read GetCapacity write SetCapacity;
    property Count: Integer read GetCount;
    property Duplicates: TDuplicates read FDuplicates write FDuplicates default
      dupIgnore;
    property Objects[Index: Integer]: TObject read GetObject write PutObject;
    property Sorted: Boolean read FSorted write SetSorted default False;
{$IFDEF NEXTGEN}
    property WideStrings[Index: Integer]: string read Get write Put; default;
{$ELSE !NEXTGEN}
    property WideStrings[Index: Integer]: WideString read Get write Put; default;
{$ENDIF NEXTGEN}

    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChanging: TNotifyEvent read FOnChanging write FOnChanging;
  end;
{$ENDIF}

{$IFDEF NEXTGEN}
  TUtilsNameValueList = class(TPersistent)
  private
    FNames: TUtilsWideStringList;
    FValues: TUtilsWideStringList;
    function GetLength: Integer; virtual;
    function GetCapacity: Integer; virtual;
    function GetDuplicates: TDuplicates;
    function GetName(Index: Integer): string; virtual;
    function GetObject(Index: Integer): TObject; virtual;
    function GetValue(Index: Integer): string; virtual;
    procedure PutObject(Index: Integer;
      AObject: TObject); virtual;
    procedure SetCapacity(const Value: Integer); virtual;
    procedure SetDuplicates(const Value: TDuplicates);
    procedure SetSorted(const Value: Boolean);
    function GetSorted: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(const Name, Value: string): Integer; virtual;
    function AddObject(const Name, Value: string;
      AObject: TObject): Integer; virtual;
    procedure AddNameValueList(const Nvl: TUtilsNameValueList); virtual;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; virtual;
    procedure Delete(const Index: Integer); virtual;
    procedure Exchange(const Index1, Index2: Integer); virtual;
    function IndexOf(const Name, Value: string): Integer; virtual;
    function IndexOfLast(const Name, Value: string): Integer; virtual;
    function IndexOfLastName(const Name: string): Integer; virtual;
    function IndexOfName(const Name: string): Integer; virtual;
    procedure Insert(const Index: Integer; const Name, Value: string); virtual;
    function Find(const Name, Value: string; var Index: Integer): Boolean; virtual;
    function FindOfName(const Name: string; var Index: Integer): Boolean; virtual;
    procedure Sort; virtual;
    property Capacity: Integer read GetCapacity write SetCapacity;
    property Duplicates: TDuplicates read GetDuplicates write SetDuplicates
      default dupIgnore;
    property Length: Integer read GetLength;
    property Names[Index: Integer]: string read GetName;
    property Objects[Index: Integer]: TObject read GetObject write PutObject;
    property Sorted: Boolean read GetSorted write SetSorted default False;
    property Values[Index: Integer]: string read GetValue;
  end;
{$ELSE !NEXTGEN}
  TUtilsNameValueList = class(TPersistent)
  private
    FNames: TUtilsWideStringList;
    FValues: TUtilsWideStringList;
    function GetLength: Integer; virtual;
    function GetCapacity: Integer; virtual;
    function GetDuplicates: TDuplicates;
    function GetName(Index: Integer): WideString; virtual;
    function GetObject(Index: Integer): TObject; virtual;
    function GetValue(Index: Integer): WideString; virtual;
    procedure PutObject(Index: Integer;
      AObject: TObject); virtual;
    procedure SetCapacity(const Value: Integer); virtual;
    procedure SetDuplicates(const Value: TDuplicates);
    procedure SetSorted(const Value: Boolean);
    function GetSorted: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(const Name,
      Value: WideString): Integer; virtual;
    function AddObject(const Name,
      Value: WideString;
      AObject: TObject): Integer; virtual;
    procedure AddNameValueList(const Nvl: TUtilsNameValueList); virtual;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; virtual;
    procedure Delete(const Index: Integer); virtual;
    procedure Exchange(const Index1,
      Index2: Integer); virtual;
    function IndexOf(const Name,
      Value: WideString): Integer; virtual;
    function IndexOfLast(const Name,
      Value: WideString): Integer; virtual;
    function IndexOfLastName(const Name: WideString): Integer; virtual;
    function IndexOfName(const Name: WideString): Integer; virtual;
    procedure Insert(const Index: Integer;
      const Name,
      Value: WideString); virtual;
    function Find(const Name,
      Value: WideString;
      var Index: Integer): Boolean; virtual;
    function FindOfName(const Name: WideString;
      var Index: Integer): Boolean; virtual;
    procedure Sort; virtual;
    property Capacity: Integer read GetCapacity write SetCapacity;
    property Duplicates: TDuplicates read GetDuplicates write SetDuplicates
      default dupIgnore;
    property Length: Integer read GetLength;
    property Names[Index: Integer]: WideString read GetName;
    property Objects[Index: Integer]: TObject read GetObject write PutObject;
    property Sorted: Boolean read GetSorted write SetSorted default False;
    property Values[Index: Integer]: WideString read GetValue;
  end;
{$ENDIF NEXTGEN}

{$IFDEF NEXTGEN}
  TUtilsNameValueTree = class(TUtilsNameValueList)
  private
    FParentTree: TUtilsNameValueTree;
    function GetChild(Index: Integer): TUtilsNameValueTree;
  public
    destructor Destroy; override;
    function AddChild(const Name, Value: string;
      const child: TUtilsNameValueTree): Integer; virtual;
    function AddChildObject(const Name, Value: string;
      const Child: TUtilsNameValueTree;
      const AObject: TObject): Integer; virtual;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; override;
    procedure Delete(const Index: Integer); override;
    function HasChild(const Index: Integer): Boolean; virtual;
    function IndexOfChild(const Child: TUtilsNameValueTree): Integer; virtual;
    procedure InsertChild(const Index: Integer; const Name, Value: string;
      const Child: TUtilsNameValueTree); virtual;
    function IsDescendantOf(const Nvtree: TUtilsNameValueTree): Boolean;
      virtual;
    function ReplaceChild(const Index: Integer;
      const NewChild: TUtilsNameValueTree): TUtilsNameValueTree; virtual;
    property Children[Index: Integer]: TUtilsNameValueTree read GetChild;
    property ParentTree: TUtilsNameValueTree read FParentTree;
  end;
{$ELSE !NEXTGEN}
  TUtilsNameValueTree = class(TUtilsNameValueList)
  private
    FParentTree: TUtilsNameValueTree;
    function GetChild(Index: Integer): TUtilsNameValueTree;
  public
    destructor Destroy; override;
    function AddChild(const Name, Value: WideString;
      const child: TUtilsNameValueTree): Integer; virtual;
    function AddChildObject(const Name, Value: WideString;
      const Child: TUtilsNameValueTree;
      const AObject: TObject): Integer; virtual;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; override;
    procedure Delete(const Index: Integer); override;
    function HasChild(const Index: Integer): Boolean; virtual;
    function IndexOfChild(const Child: TUtilsNameValueTree): Integer; virtual;
    procedure InsertChild(const Index: Integer;
      const Name,
      Value: WideString;
      const Child: TUtilsNameValueTree); virtual;
    function IsDescendantOf(const Nvtree: TUtilsNameValueTree): Boolean;
      virtual;
    function ReplaceChild(const Index: Integer;
      const NewChild: TUtilsNameValueTree): TUtilsNameValueTree; virtual;
    property Children[Index: Integer]: TUtilsNameValueTree read GetChild;
    property ParentTree: TUtilsNameValueTree read FParentTree;
  end;
{$ENDIF NEXTGEN}

  TUtilsCustomWideStr = class
  private
{$IFDEF CLR}
    FInternalStringBuilder: StringBuilder;
    function GetLength: Integer;
{$ELSE}
    FActualLen: Integer;
    FCapacity: Integer;
{$IFNDEF NEXTGEN}
    FContent: WideString;
{$ELSE NEXTGEN}
    FContent: TCharArray;
{$ENDIF !NEXTGEN}
{$ENDIF}
  protected
    function GetWideChars(Index: Integer): WideChar; virtual;
    procedure SetWideChars(Index: Integer;
      C: WideChar); virtual;
  public
    constructor Create;
    procedure AddUCS4Char(const CodePoint: Longint); virtual;
    // We use Longint instead of UCS4Char, because UCS4Char is not supported by
    // Delphi 5 and Delphi for .NET.
    procedure AddWideChar(const C: WideChar); virtual;
    procedure Clear; virtual;
{$IFDEF NEXTGEN}
    procedure AddWideString(const S: string); virtual;
    function EndsWith(const S: string): Boolean; virtual;
    function IsEqual(const S: string): Boolean; virtual;
    function StartsWith(const S: string): Boolean; virtual;
    function Value: string; virtual;
{$ELSE !NEXTGEN}
    procedure AddWideString(const S: WideString); virtual;
    function EndsWith(const S: WideString): Boolean; virtual;
    function IsEqual(const S: WideString): Boolean; virtual;
    function StartsWith(const S: WideString): Boolean; virtual;
    function Value: WideString; virtual;
{$ENDIF NEXTGEN}
    // Since calling the Value function involves time
    // consuming WideString copying, always use one of the
    // other TUtilsCustomWideStr access functions, if possible,
    // e.g. WideChars[Index] instead of Value[Index],
    // IsEqual[S] instead of (Value = S), or
    // Length instead of Length(Value).
{$IFDEF CLR}
    property Length: Integer read GetLength;
{$ELSE}
    property Length: Integer read FActualLen;
{$ENDIF}
    property WideChars[Index: Integer]: WideChar read GetWideChars write
      SetWideChars; default;
  end;

{$IFDEF CLR}
  TUtilsWideStringStream = class(TMemoryStream)
  protected
    procedure SetStringPosition(Value: Longint);
    function GetStringPosition: Longint;
    procedure SetStringLength(Value: Longint);
    function GetStringLength: Longint;
    function GetDataString: WideString;
  public
    constructor Create; overload;
    constructor Create(const AString: string); overload;

    function ReadString(Count: Longint): WideString;
    procedure WriteString(const AString: WideString);
    procedure SetSize(NewSize: Int64); override;

    property StringLength: Longint read GetStringLength write SetStringLength;
    property StringPosition: Longint read GetStringPosition write
      SetStringPosition;
    property DataString: WideString read GetDataString;
  end;

{$ELSE CLR}
  TUtilsWideStringStream = class(TStream)
  private
{$IFDEF NEXTGEN}
    FDataStringP: MarshaledAString;
{$ELSE !NEXTGEN}
    FDataStringP: PAnsiChar;
{$ENDIF NEXTGEN}
    FSize: Longint;
    FCapacity: Longint;
    FPosition: Longint;
  protected
    procedure SetCapacity(NewCapacity: Longint); virtual;
    procedure SetSize(NewSize: Longint); override;
    procedure SetStringPosition(Value: Longint);
    function GetStringPosition: Longint;
    procedure SetStringLength(Value: Longint);
    function GetStringLength: Longint;
{$IFDEF NEXTGEN}
    function GetDataString: string;
  public
    constructor Create(const AString: string);
{$ELSE !NEXTGEN}
    function GetDataString: WideString;
  public
    constructor Create(const AString: WideString);
{$ENDIF NEXTGEN}
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Seek(offset: Longint; Origin: Word): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
{$IFDEF NEXTGEN}
    function ReadString(Count: Longint): string;
    procedure WriteString(const AString: string);
{$ELSE !NEXTGEN}
    function ReadString(Count: Longint): WideString;
    procedure WriteString(const AString: WideString);
{$ENDIF NEXTGEN}

    property Capacity: Longint read FCapacity write SetCapacity;
    property StringLength: Longint read GetStringLength write SetStringLength;
    property StringPosition: Longint read GetStringPosition write
      SetStringPosition;
{$IFDEF NEXTGEN}
    property DataString: string read GetDataString;
{$ELSE !NEXTGEN}
    property DataString: WideString read GetDataString;
{$ENDIF NEXTGEN}
  end;
{$ENDIF CLR}

{ Helper functions }

{$IFDEF NEXTGEN}
function CompareWideStr(const S1, S2: string): Integer;
function EndsWideStr(const SubString, S: string): Boolean;
function StartsWideStr(const SubString, S: string): Boolean;
function TranslateWideString(const S, Pattern_1, Pattern_2: string): string;
function TrimSpace(const S: string): string;
{$ELSE !NEXTGEN}
function CompareWideStr(const S1, S2: WideString): Integer;
function EndsWideStr(const SubString, S: WideString): Boolean;
function StartsWideStr(const SubString, S: WideString): Boolean;
function TranslateWideString(const S, Pattern_1, Pattern_2: WideString): WideString;
function TrimSpace(const S: WideString): WideString;
{$ENDIF NEXTGEN}

{ UTF-16 surrogate functions }

function ExtractUTF16HighSurrogate(const Value: Integer): Word;
function ExtractUTF16LowSurrogate(const Value: Integer): Word;
function UTF16SurrogateToInt(const HighSurrogate, LowSurrogate: Word): Integer;
function IsUTF16HighSurrogate(const Value: Word): Boolean;
function IsUTF16LowSurrogate(const Value: Word): Boolean;

implementation

const
  FirstIndex = Low(string);
  AdjustIndex= 1-Low(string);

resourcestring

  // TUtilsWideStringStream error reports
  SCannotReadOddPos = 'Cannot Read WideString from odd byte position';
  SCannotWriteOddPos = 'Cannot Write WideString to odd byte position';
  SCapacityLessSize = 'Capacity cannot be less than size';
  SOddSizeInvalid = 'Odd size not valid for WideString';
  SNegativeSizeInvalid = 'Negative stream size invalid';
  SOddPosInvalid = 'Odd byte position not valid for WideString';

  // TUtilsNameValueTree error reports
  SInuse = 'Child name-value tree is in use elsewhere';
  SCircularReference = 'Circular references are not allowed';

  // TUtilsCustomWideStr error reports
  SInvalidCodePoint = '%d is not a valid ISO-10646-UCS4 code point';

  // TUtilsWideStringList error reports
  SNoDuplicatesAllowed = 'String list does not allow duplicates';
  SIndexOutOfBounds = 'List Index out of bounds (%d)';
  SOnlyWhenSorted = 'Operation not allowed on Sorted string list';

  { Helper functions }

{$IFDEF CLR}

function CompareWideStr(const S1, S2: WideString): Integer;
var
  Dif, I, Len, Len2: Integer;
begin
  Len := Length(S1);
  Len2 := Length(S2);
  Dif := Len - Len2;
  if Dif > 0 then
    Len := Len2;

  for I := FirstIndex to Len-AdjustIndex do
  begin
    Result := Ord(S1[I]) - Ord(S2[I]);
    if Result <> 0 then
      Exit;
  end;
  Result := Dif;
end;

function EndsWideStr(const SubString, S: WideString): Boolean;
var
  I, J, Len1, Len2: Integer;
begin
  Result := False;
  Len1 := Length(SubString);
  Len2 := Length(S);
  if Len1 <= Len2 then begin
    J := Len2-AdjustIndex;
    for I := Len1-AdjustIndex downto FirstIndex do
    begin
      if S[I] <> SubString[J] then
        Exit;
      Dec(J);
    end;
    Result := True;
  end;
end;

function StartsWideStr(const SubString, S: WideString): Boolean;
var
  I, J, Len: Integer;
begin
  Result := False;
  Len := Length(SubString);
  if Len <= Length(S) then begin
    J := FirstIndex;
    for I := FirstIndex to Len-AdjustIndex do
    begin
      if S[I] <> SubString[J] then
        Exit;
      Inc(J);
    end;
    Result := True;
  end;
end;

{$ELSE}

{$IFDEF NEXTGEN}
function CompareWideStr(const S1, S2: string): Integer;
var
  Dif, I, Len, Len2: Integer;
  P1, P2: PChar;
begin
  Len := Length(S1);
  Len2 := Length(S2);
  Dif := Len - Len2;
  if Dif > 0 then
    Len := Len2;

  P1 := PChar(S1);
  P2 := PChar(S2);
  for I := 1 to Len do
  begin
    Result := Ord(P1^) - Ord(P2^);
    if Result <> 0 then
      Exit;
    Inc(P1);
    Inc(P2);
  end;
  Result := Dif;
end;

function EndsWideStr(const SubString, S: string): Boolean;
var
  I, Len1, Len2: Integer;
  P1, P2: PChar;
begin
  Result := False;
  Len1 := Length(SubString);
  Len2 := Length(S);
  if Len1 <= Len2 then begin
    P1 := PChar(SubString) + Len1;
    P2 := PChar(S) + Len2;
    for I := 1 to Len1 do
    begin
      Dec(P1);
      Dec(P2);
      if Ord(P1^) - Ord(P2^) <> 0 then
        Exit;
    end;
    Result := True;
  end;
end;

function StartsWideStr(const SubString, S: string): Boolean;
var
  I, Len: Integer;
  P1, P2: PChar;
begin
  Result := False;
  Len := Length(SubString);
  if Len <= Length(S) then begin
    P1 := PWideChar(SubString);
    P2 := PWideChar(S);
    for I := 1 to Len do
    begin
      if Ord(P1^) - Ord(P2^) <> 0 then
        Exit;
      Inc(P1);
      Inc(P2);
    end;
    Result := True;
  end;
end;
{$ELSE !NEXTGEN}
function CompareWideStr(const S1, S2: WideString): Integer;
var
  Dif, I, Len, Len2: Integer;
  P1, P2: PWideChar;
begin
  Len := Length(S1);
  Len2 := Length(S2);
  Dif := Len - Len2;
  if Dif > 0 then
    Len := Len2;

  P1 := PWideChar(S1);
  P2 := PWideChar(S2);
  for I := 1 to Len do
  begin
    Result := Ord(P1^) - Ord(P2^);
    if Result <> 0 then
      Exit;
    Inc(P1);
    Inc(P2);
  end;
  Result := Dif;
end;

function EndsWideStr(const SubString, S: WideString): Boolean;
var
  I, Len1, Len2: Integer;
  P1, P2: PWideChar;
begin
  Result := False;
  Len1 := Length(SubString);
  Len2 := Length(S);
  if Len1 <= Len2 then begin
    P1 := PWideChar(SubString) + Len1;
    P2 := PWideChar(S) + Len2;
    for I := 1 to Len1 do
    begin
      Dec(P1);
      Dec(P2);
      if Ord(P1^) - Ord(P2^) <> 0 then
        Exit;
    end;
    Result := True;
  end;
end;

function StartsWideStr(const SubString, S: WideString): Boolean;
var
  I, Len: Integer;
  P1, P2: PWideChar;
begin
  Result := False;
  Len := Length(SubString);
  if Len <= Length(S) then begin
    P1 := PWideChar(SubString);
    P2 := PWideChar(S);
    for I := 1 to Len do
    begin
      if Ord(P1^) - Ord(P2^) <> 0 then
        Exit;
      Inc(P1);
      Inc(P2);
    end;
    Result := True;
  end;
end;
{$ENDIF NEXTGEN}

{$ENDIF}

{$IFDEF NEXTGEN}
function TranslateWideString(const S, Pattern_1, Pattern_2: string): string;
var
  I, J, K, L: Integer;
  tempResult: TCharArray;
begin
  SetLength(tempResult, S.Length);
//  SetLength(Result, Length(S));
  L := Pattern_2.Length;

  if Pattern_1.Length > L then
  begin
    // Character removal is possible:
    K := 0;
    for I := FirstIndex to S.Length-AdjustIndex do
    begin
      J := Pos(S[I], Pattern_1);
      if J > 0 then
      begin
        if J <= L then
        begin
          tempResult[K] := Pattern_2[J-AdjustIndex];
          Inc(K);
        end;
      end
      else
      begin
        tempResult[K] := S[I];
        Inc(K);
      end;
    end;
    SetLength(tempResult, K);
  end
  else
    // Character removal is not possible:
    for I := FirstIndex to S.Length-AdjustIndex do
    begin
      J := Pos(S[I], Pattern_1);
      if J > 0 then
        tempResult[I] := Pattern_2[J-AdjustIndex]
      else
        tempResult[I] := S[I];
    end;
  Result := string.Create(tempResult);
end;

function TrimSpace(const S: string): string;
// This function removes all spaces (#$20) at the beginning
// or end of 'S'.
const
  SPACE: Char = #$20;
var
  I, L: Integer;
begin
//  L := Length(S)-AdjustIndex;
//  I := FirstIndex;
//  while (I <= L) and (S[I] = SPACE) do Inc(I);
//  if I > L then
//    Result := ''
//  else begin
//    while (S[L] = SPACE) do Dec(L);
//    Result := Copy(S, I+AdjustIndex, L - I + 1);
//  end;
  L := High(S);
  I := Low(S);
  while (I <= L) and (S[I] = SPACE) do Inc(I);
  if I > L then
    Result := ''
  else begin
    while (S[L] = SPACE) do Dec(L);
    //Result := Copy(S, I+AdjustIndex, L - I + 1);
    Result := S.Substring( I, L - I + 1);
  end;
end;
{$ELSE !NEXTGEN}
function TranslateWideString(const S, Pattern_1, Pattern_2: WideString):
  WideString;
var
  I, J, K, L: Integer;
  tempResult: TCharArray;
begin
  SetLength(tempResult, Length(S));
//  SetLength(Result, Length(S));
  L := Length(Pattern_2);

  if Length(Pattern_1) > L then
  begin
    // Character removal is possible:
    K := 0;
    for I := FirstIndex to Length(S)-AdjustIndex do
    begin
      J := Pos(S[I], Pattern_1);
      if J > 0 then
      begin
        if J <= L then
        begin
          tempResult[K] := Pattern_2[J-AdjustIndex];
          Inc(K);
        end;
      end
      else
      begin
        tempResult[K] := S[I];
        Inc(K);
      end;
    end;
    SetLength(tempResult, K);
  end
  else
    // Character removal is not possible:
    for I := FirstIndex to Length(S)-AdjustIndex do
    begin
      J := Pos(S[I], Pattern_1);
      if J > 0 then
        tempResult[I] := Pattern_2[J-AdjustIndex]
      else
        tempResult[I] := S[I];
    end;
  Result := string.Create(tempResult);
end;

function TrimSpace(const S: WideString): WideString;
// This function removes all spaces (#$20) at the beginning
// or end of 'S'.
const
  SPACE: WideChar = #$20;
var
  I, L: Integer;
begin
  L := Length(S)-AdjustIndex;
  I := FirstIndex;
  while (I <= L) and (S[I] = SPACE) do Inc(I);
  if I > L then
    Result := ''
  else begin
    while (S[L] = SPACE) do Dec(L);
    Result := Copy(S, I+AdjustIndex, L - I + 1);
  end;
end;
{$ENDIF NEXTGEN}

{ UTF-16 surrogate functions }

// Extracts the high surrogate of a number out of the interval [$10000;$10FFFF].
function ExtractUtf16HighSurrogate(const Value: Integer): Word;
begin
  Result := $D7C0 + (Value shr 10);
end;

// Extracts the low surrogate of a number out of the interval [$10000;$10FFFF].
function ExtractUtf16LowSurrogate(const Value: Integer): Word;
begin
  Result := $DC00 xor (Value and $3FF);
end;

// Transforms a high surrogate plus a low surrogate into an integer.
function Utf16SurrogateToInt(const HighSurrogate, LowSurrogate: Word): Integer;
begin
  Result := ((HighSurrogate - $D7C0) shl 10) + (LowSurrogate xor $DC00);
end;

// Checks whether the specified value is a UTF-16 high surrogate.
function IsUtf16HighSurrogate(const Value: Word): Boolean;
begin
  case Value of
    $D800..$DBFF: Result := True;
  else
    Result := False;
  end;
end;

// Checks whether the specified value is a UTF-16 low surrogate.
function IsUtf16LowSurrogate(const Value: Word): Boolean;
begin
  case Value of
    $DC00..$DFFF: Result := True;
  else
    Result := False;
  end;
end;


{ TUtilsNameValueList }

constructor TUtilsNameValueList.Create;
begin
  inherited Create;
  FNames := TUtilsWideStringList.Create;
  FValues := TUtilsWideStringList.Create;
end;

destructor TUtilsNameValueList.Destroy;
begin
  FNames.free;
  FValues.free;
  inherited Destroy;
end;

function TUtilsNameValueList.GetLength: Integer;
begin
  Result := FNames.Count;
end;

function TUtilsNameValueList.GetCapacity: Integer;
begin
  Result := FNames.Capacity;
end;

function TUtilsNameValueList.GetDuplicates: TDuplicates;
begin
  Result := FNames.Duplicates;
end;

{$IFDEF NEXTGEN}
function TUtilsNameValueList.GetName(Index: Integer): string;
{$ELSE !NEXTGEN}
function TUtilsNameValueList.GetName(Index: Integer): WideString;
{$ENDIF NEXTGEN}
begin
  Result := FNames[Index];
end;

function TUtilsNameValueList.GetSorted: Boolean;
begin
  Result := FNames.Sorted;
end;

function TUtilsNameValueList.GetObject(Index: Integer): TObject;
begin
  Result := FValues.Objects[Integer(FNames.Objects[Index])];
end;

{$IFDEF NEXTGEN}
function TUtilsNameValueList.GetValue(Index: Integer): string;
{$ELSE !NEXTGEN}
function TUtilsNameValueList.GetValue(Index: Integer): WideString;
{$ENDIF NEXTGEN}
begin
  Result := FValues[Integer(FNames.Objects[Index])];
end;

procedure TUtilsNameValueList.PutObject(Index: Integer; AObject: TObject);
begin
  FValues.Objects[Integer(FNames.Objects[Index])] := AObject;
end;

procedure TUtilsNameValueList.SetCapacity(const Value: Integer);
begin
  FNames.Capacity := Value;
  FValues.Capacity := Value;
end;

procedure TUtilsNameValueList.SetDuplicates(const Value: TDuplicates);
begin
  FNames.Duplicates := Value;
end;

procedure TUtilsNameValueList.SetSorted(const Value: Boolean);
begin
  FNames.Sorted := Value;
end;

{$IFDEF NEXTGEN}
function TUtilsNameValueList.Add(const Name, Value: string): Integer;
{$ELSE !NEXTGEN}
function TUtilsNameValueList.Add(const Name, Value: WideString): Integer;
{$ENDIF NEXTGEN}
var
  VIndex: Integer;
begin
  VIndex := FValues.Add(Value);
  Result := FNames.AddObject(Name, TObject(VIndex));
end;

procedure TUtilsNameValueList.AddNameValueList(const Nvl: TUtilsNameValueList);
var
  I: Integer;
begin
  Capacity := Capacity + Nvl.Length;
  for I := 0 to Pred(Nvl.Length) do
    Self.AddObject(NVl.Names[I], Nvl.Values[I], Nvl.Objects[I]);
end;

{$IFDEF NEXTGEN}
function TUtilsNameValueList.AddObject(const Name, Value: string;
  AObject: TObject): Integer;
{$ELSE !NEXTGEN}
function TUtilsNameValueList.AddObject(const Name, Value: WideString;
  AObject: TObject): Integer;
{$ENDIF NEXTGEN}
var
  VIndex: Integer;
begin
  VIndex := FValues.AddObject(Value, AObject);
  Result := FNames.AddObject(Name, TObject(VIndex));
end;

procedure TUtilsNameValueList.Assign(Source: TPersistent);
begin
  if Source is TUtilsNameValueList then
  begin
    if Source = Self then
      Exit;
    Clear;
    AddNameValueList(TUtilsNameValueList(Source));
    Exit;
  end;
  inherited Assign(Source);
end;

procedure TUtilsNameValueList.Clear;
begin
  FNames.Clear;
  FValues.Clear;
end;

procedure TUtilsNameValueList.Delete(const Index: Integer);
begin
  FNames.Delete(Index);
end;

procedure TUtilsNameValueList.Exchange(const Index1,
  Index2: Integer);
begin
  FNames.Exchange(Index1, Index2);
end;

{$IFDEF NEXTGEN}
function TUtilsNameValueList.IndexOf(const Name, Value: string): Integer;
{$ELSE !NEXTGEN}
function TUtilsNameValueList.IndexOf(const Name, Value: WideString): Integer;
{$ENDIF NEXTGEN}
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Pred(FNames.Count) do
  begin
    if FNames[I] = Name then
      if FValues[Integer(FNames.Objects[I])] = Value then
      begin
        Result := I;
        Exit;
      end;
  end;
end;

{$IFDEF NEXTGEN}
function TUtilsNameValueList.IndexOfLast(const Name, Value: string): Integer;
{$ELSE !NEXTGEN}
function TUtilsNameValueList.IndexOfLast(const Name, Value: WideString): Integer;
{$ENDIF NEXTGEN}
var
  I: Integer;
begin
  Result := -1;
  for I := Pred(FNames.Count) downto 0 do
  begin
    if FNames[I] = Name then
      if FValues[Integer(FNames.Objects[I])] = Value then
      begin
        Result := I;
        Exit;
      end;
  end;
end;

{$IFDEF NEXTGEN}
function TUtilsNameValueList.IndexOfLastName(const Name: string): Integer;
{$ELSE !NEXTGEN}
function TUtilsNameValueList.IndexOfLastName(const Name: WideString): Integer;
{$ENDIF NEXTGEN}
begin
  Result := FNames.IndexOfLast(Name);
end;

{$IFDEF NEXTGEN}
function TUtilsNameValueList.IndexOfName(const Name: string): Integer;
{$ELSE !NEXTGEN}
function TUtilsNameValueList.IndexOfName(const Name: WideString): Integer;
{$ENDIF NEXTGEN}
begin
  Result := FNames.IndexOf(Name);
end;

{$IFDEF NEXTGEN}
procedure TUtilsNameValueList.Insert(const Index: Integer;
  const Name, Value: string);
{$ELSE !NEXTGEN}
procedure TUtilsNameValueList.Insert(const Index: Integer;
  const Name, Value: WideString);
{$ENDIF NEXTGEN}
var
  VIndex: Integer;
begin
  VIndex := FValues.Add(Value);
  FNames.insertObject(Index, Name, TObject(VIndex));
end;

{$IFDEF NEXTGEN}
function TUtilsNameValueList.Find(const Name, Value: string;
  var Index: Integer): Boolean;
{$ELSE !NEXTGEN}
function TUtilsNameValueList.Find(const Name, Value: WideString;
  var Index: Integer): Boolean;
{$ENDIF NEXTGEN}
begin
  if FNames.Duplicates = dupAccept then
  begin
    Index := IndexOf(Name, Value);
    Result := (Index > -1);
  end
  else
  begin
    Result := FNames.Find(Name, Index);
    if Result then
    begin
      if FValues[Integer(FNames.Objects[Index])] <> Value then
      begin
        Index := -1;
        Result := False;
      end;
    end;
  end;
end;

{$IFDEF NEXTGEN}
function TUtilsNameValueList.FindOfName(const Name: string;
  var Index: Integer): Boolean;
{$ELSE !NEXTGEN}
function TUtilsNameValueList.FindOfName(const Name: WideString;
  var Index: Integer): Boolean;
{$ENDIF NEXTGEN}
begin
  Result := FNames.Find(Name, Index);
end;

procedure TUtilsNameValueList.Sort;
begin
  FNames.Sort;
end;

{ TUtilsNameValueTree }

destructor TUtilsNameValueTree.Destroy;
{$IFDEF AUTOREF_COUNT}
var
  Index: Integer;
{$ENDIF AUTOREF_COUNT}
begin
  if Assigned(FParentTree) then
    FParentTree.ReplaceChild(FParentTree.IndexOfChild(Self), nil);
                                                                                 
{$IFDEF AUTOREF_COUNT}
  for Index := 0 to Pred(FNames.Count) do
    Children[Index].Free;
{$ENDIF AUTOREF_COUNT}
  inherited;
end;

{$IFDEF NEXTGEN}
function TUtilsNameValueTree.AddChild(const Name, Value: string;
  const Child: TUtilsNameValueTree): Integer;
{$ELSE !NEXTGEN}
function TUtilsNameValueTree.AddChild(const Name, Value: WideString;
  const Child: TUtilsNameValueTree): Integer;
{$ENDIF NEXTGEN}
begin
  Result := AddChildObject(Name, Value, Child, nil);
end;

{$IFDEF NEXTGEN}
function TUtilsNameValueTree.AddChildObject(const Name, Value: string;
  const Child: TUtilsNameValueTree; const AObject: TObject): Integer;
{$ELSE !NEXTGEN}
function TUtilsNameValueTree.AddChildObject(const Name, Value: WideString;
  const Child: TUtilsNameValueTree; const AObject: TObject): Integer;
{$ENDIF NEXTGEN}
begin
  if Assigned(Child) then
  begin
    if Assigned(Child.FParentTree) then
      raise EStringListError.Create(SInuse);
    if IsDescendantOf(Child) then
      raise EStringListError.Create(SCircularReference);
    Result := Self.AddObject(Name, Value, AObject);
    FValues.Objects[Integer(FNames.Objects[Result])] := Child;
    Child.FParentTree := Self;
  end
  else
    Result := AddObject(Name, Value, AObject);
end;

procedure TUtilsNameValueTree.Assign(Source: TPersistent);
var
  I: Integer;
  NewNameValueTree: TUtilsNameValueTree;
begin
  if Source is TUtilsNameValueTree then
  begin
    if Source = Self then
      Exit;
    Clear;
    for I := 0 to Pred(TUtilsNameValueTree(Source).Length) do
    begin
      if TUtilsNameValueTree(Source).HasChild(I) then
      begin
        newNameValueTree := TUtilsNameValueTree.Create;
        Self.AddChildObject(TUtilsNameValueTree(Source).Names[I],
          TUtilsNameValueTree(Source).Values[I], NewNameValueTree,
          TUtilsNameValueTree(Source).Objects[I]);
        NewNameValueTree.Assign(TUtilsNameValueTree(Source).Children[I]);
      end
      else
        Self.AddObject(TUtilsNameValueTree(Source).Names[I],
          TUtilsNameValueTree(Source).Values[I],
          TUtilsNameValueTree(Source).Objects[I]);
    end;
    Exit;
  end;
  inherited Assign(Source);
end;

procedure TUtilsNameValueTree.Clear;
var
  Index: Integer;
  Subtree: TUtilsNameValueTree;
begin
  for Index := 0 to Pred(FNames.Count) do
  begin
    Subtree := Children[Index];
    if Assigned(Subtree) then
    begin
      Subtree.FParentTree := nil;
      Subtree.Free;
    end;
  end;
  inherited;
end;

procedure TUtilsNameValueTree.Delete(const Index: Integer);
var
  Subtree: TUtilsNameValueTree;
begin
  Subtree := Children[Index];
  if Assigned(Subtree) then
  begin
    Subtree.FParentTree := nil;
    Subtree.Free;
  end;
  inherited;
end;

function TUtilsNameValueTree.GetChild(Index: Integer): TUtilsNameValueTree;
begin
  Result :=
    TUtilsNameValueTree(FValues.Objects[Integer(FNames.Objects[Index])]);
end;

function TUtilsNameValueTree.HasChild(const Index: Integer): Boolean;
begin
  Result := Assigned(FValues.Objects[Integer(FNames.Objects[Index])]);
end;

function TUtilsNameValueTree.IndexOfChild(const Child: TUtilsNameValueTree):
  Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Pred(FNames.Count) do
  begin
    if FValues.Objects[Integer(FNames.Objects[I])] = Child then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

{$IFDEF NEXTGEN}
procedure TUtilsNameValueTree.InsertChild(const Index: Integer;
  const Name, Value: string; const Child: TUtilsNameValueTree);
{$ELSE !NEXTGEN}
procedure TUtilsNameValueTree.InsertChild(const Index: Integer;
  const Name, Value: WideString; const Child: TUtilsNameValueTree);
{$ENDIF NEXTGEN}
begin
  if Assigned(Child) then
  begin
    if Assigned(Child.FParentTree) then
      raise EStringListError.Create(SInuse);
    if IsDescendantOf(Child) then
      raise EStringListError.Create(SCircularReference);
    Insert(Index, Name, Value);
    FValues.Objects[Integer(FNames.Objects[Index])] := Child;
    Child.FParentTree := Self;
  end
  else
    Insert(Index, Name, Value);
end;

function TUtilsNameValueTree.IsDescendantOf(const Nvtree: TUtilsNameValueTree):
  Boolean;
var
  Tree: TUtilsNameValueTree;
begin
  Tree := Self;
  Result := False;
  while Assigned(Tree) do
  begin
    Tree := Tree.ParentTree;
    if Tree = Nvtree then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TUtilsNameValueTree.ReplaceChild(const Index: Integer;
  const NewChild: TUtilsNameValueTree): TUtilsNameValueTree;
begin
  if Assigned(NewChild) then
  begin
    if Assigned(NewChild.FParentTree) then
      raise EStringListError.Create(SInuse);
    if IsDescendantOf(NewChild) then
      raise EStringListError.Create(SCircularReference);
    Result := Children[Index];
    if Assigned(Result) then
      Result.FParentTree := nil;
    FValues.Objects[Integer(FNames.Objects[Index])] := NewChild;
    NewChild.FParentTree := Self;
  end
  else
  begin
    Result := Children[Index];
    if Assigned(Result) then
      Result.FParentTree := nil;
    FValues.Objects[Integer(FNames.Objects[Index])] := nil;
  end;
end;

{ TUtilsCustomWideStr }

{$IFDEF CLR}

constructor TUtilsCustomWideStr.Create;
begin
  inherited;
  FInternalStringBuilder := StringBuilder.Create;
end;

function TUtilsCustomWideStr.GetLength: Integer;
begin
  Result := FInternalStringBuilder.Length;
end;

function TUtilsCustomWideStr.GetWideChars(Index: Integer): WideChar;
begin
  Result := FInternalStringBuilder[Index - 1];
end;

procedure TUtilsCustomWideStr.SetWideChars(Index: Integer;
  C: WideChar);
begin
  FInternalStringBuilder[Index + 1] := C;
end;

procedure TUtilsCustomWideStr.AddUCS4Char(const CodePoint: Longint);
var
  HighSurrogat, LowSurrogat: Word;
begin
  // Remark: For typical XML documents the following nested if statements
  //         appear to be a little faster in Delphi 7 than an equivalent
  //         case statement.
  if CodePoint <= $D7FF then
    AddWideChar(WideChar(CodePoint))
  else if CodePoint <= $DFFF then // Do not accept surrogates
    raise EConvertError.CreateFmt(SInvalidCodePoint, [CodePoint])
  else if CodePoint <= $FFFF then
    AddWideChar(WideChar(CodePoint))
  else
  begin
    HighSurrogat := ExtractUtf16HighSurrogate(CodePoint);
    LowSurrogat := ExtractUtf16LowSurrogate(CodePoint);
    AddWideChar(WideChar(HighSurrogat));
    AddWideChar(WideChar(LowSurrogat));
  end;
end;

procedure TUtilsCustomWideStr.AddWideChar(const C: WideChar);
begin
  FInternalStringBuilder.Append(C);
end;

procedure TUtilsCustomWideStr.AddWideString(const S: WideString);
begin
  FInternalStringBuilder.Append(S);
end;

function TUtilsCustomWideStr.EndsWith(const S: WideString): Boolean;
var
  I, L, Offset: Integer;
begin
  L := Borland.Delphi.System.Length(S);
  Offset := FInternalStringBuilder.Length - L;
  if (Offset < 0) or (L = 0) then
  begin
    Result := False;
    Exit;
  end;
  I := FirstIndex;
  repeat
    Result := FInternalStringBuilder[I + Offset - FirstIndex] = S[I];
    Inc(I);
  until (not Result) or (I > L-AdjustIndex);
end;

function TUtilsCustomWideStr.IsEqual(const S: WideString): Boolean;
var
  I, L: Integer;
begin
  L := Borland.Delphi.System.Length(S);
  if FInternalStringBuilder.Length <> L then
  begin
    Result := False;
    Exit;
  end;
  if L = 0 then
  begin
    Result := True;
    Exit;
  end;
  I := FirstIndex;
  repeat
    Result := FInternalStringBuilder[I - FirstIndex] = S[I];
    Inc(I);
  until (not Result) or (I > L-AdjustIndex);
end;

procedure TUtilsCustomWideStr.Clear;
begin
  FInternalStringBuilder.Length := 0;
end;

function TUtilsCustomWideStr.StartsWith(const S: WideString): Boolean;
var
  I, L: Integer;
begin
  L := Borland.Delphi.System.Length(S);
  if (FInternalStringBuilder.Length < L) or (L = 0) then
  begin
    Result := False;
    Exit;
  end;
  I := FirstIndex;
  repeat
    Result := FInternalStringBuilder[I - FirstIndex] = S[I];
    Inc(I);
  until (not Result) or (I > L-AdjustIndex);
end;

function TUtilsCustomWideStr.Value: WideString;
begin
  Result := FInternalStringBuilder.ToString;
end;

{$ELSE}

constructor TUtilsCustomWideStr.Create;
begin
  inherited;
  Clear;
end;

function TUtilsCustomWideStr.GetWideChars(Index: Integer): WideChar;
begin
{$IFNDEF NEXTGEN}
  Result := FContent[Index-AdjustIndex];
{$ELSE NEXTGEN}
  Result := FContent[Index-1];
{$ENDIF !NEXTGEN}
end;

procedure TUtilsCustomWideStr.SetWideChars(Index: Integer;
  C: WideChar);
begin
{$IFNDEF NEXTGEN}
  FContent[Index-AdjustIndex] := C;
{$ELSE}
  FContent[Index-1] := C;
{$ENDIF}
end;

procedure TUtilsCustomWideStr.AddUCS4Char(const CodePoint: Longint);
var
  HighSurrogat, LowSurrogat: Word;
begin
  // Remark: For typical XML documents the following nested if statements
  //         appear to be a little faster in Delphi 7 than an equivalent
  //         case statement.
  if CodePoint <= $D7FF then
    AddWideChar(WideChar(CodePoint))
  else if CodePoint <= $DFFF then // Do not accept surrogates
    raise EConvertError.CreateFmt(SInvalidCodePoint, [CodePoint])
  else if CodePoint <= $FFFF then
    AddWideChar(WideChar(CodePoint))
  else
  begin
    HighSurrogat := ExtractUtf16HighSurrogate(CodePoint);
    LowSurrogat := ExtractUtf16LowSurrogate(CodePoint);
    AddWideChar(WideChar(HighSurrogat));
    AddWideChar(WideChar(LowSurrogat));
  end;
end;

procedure TUtilsCustomWideStr.AddWideChar(const C: WideChar);
begin
  if FActualLen = FCapacity then
  begin // Grow
    FCapacity := FCapacity + FCapacity div 4;
    SetLength(FContent, FCapacity);
  end;
{$IFNDEF NEXTGEN}
  Inc(FActualLen);
  FContent[FActualLen-AdjustIndex] := C;
{$ELSE NEXTGEN}
  FContent[FActualLen] := C;
  Inc(FActualLen);
{$ENDIF !NEXTGEN}
end;

{$IFDEF NEXTGEN}
procedure TUtilsCustomWideStr.AddWideString(const S: string);
{$ELSE !NEXTGEN}
procedure TUtilsCustomWideStr.AddWideString(const S: WideString);
{$ENDIF NEXTGEN}
var
  I, L: Integer;
begin
  L := System.Length(S);
  while FActualLen + L > FCapacity do
  begin // Grow
    FCapacity := FCapacity + FCapacity div 4;
    SetLength(FContent, FCapacity);
  end;
  Inc(FActualLen, L);
  for I := FirstIndex to L-AdjustIndex do
    FContent[FActualLen - L + I] := WideChar(S[I]);
end;

{$IFDEF NEXTGEN}
function TUtilsCustomWideStr.EndsWith(const S: string): Boolean;
{$ELSE !NEXTGEN}
function TUtilsCustomWideStr.EndsWith(const S: WideString): Boolean;
{$ENDIF NEXTGEN}
var
  I, Offset, SLength: Integer;
begin
  SLength := System.Length(S);
  Offset := FActualLen - SLength;
  if (Offset < 0) or (SLength = 0) then
  begin
    Result := False;
    Exit;
  end;
  I := FirstIndex;
  repeat
    Result := FContent[I + Offset - FirstIndex] = S[I];
    Inc(I);
  until (not Result) or (I > SLength-AdjustIndex);
end;

{$IFDEF NEXTGEN}
function TUtilsCustomWideStr.IsEqual(const S: string): Boolean;
{$ELSE !NEXTGEN}
function TUtilsCustomWideStr.IsEqual(const S: WideString): Boolean;
{$ENDIF NEXTGEN}
var
  I, SLength: Integer;
begin
  SLength := System.Length(S);
  if FActualLen <> SLength then
  begin
    Result := False;
    Exit;
  end;
  if SLength = 0 then
  begin
    Result := True;
    Exit;
  end;
  I := FirstIndex;
  repeat
    Result := FContent[I] = S[I];
    Inc(I);
  until (not Result) or (I > SLength-AdjustIndex);
end;

procedure TUtilsCustomWideStr.Clear;
begin
  FCapacity := 64;
  SetLength(FContent, FCapacity);
  FActualLen := 0;
end;

{$IFDEF NEXTGEN}
function TUtilsCustomWideStr.StartsWith(const S: string): Boolean;
{$ELSE !NEXTGEN}
function TUtilsCustomWideStr.StartsWith(const S: WideString): Boolean;
{$ENDIF NEXTGEN}
var
  I, SLength: Integer;
begin
  SLength := System.Length(S);
  if (FActualLen < SLength) or (SLength = 0) then
  begin
    Result := False;
    Exit;
  end;
  I := FirstIndex;
  repeat
    Result := FContent[I] = S[I];
    Inc(I);
  until (not Result) or (I > SLength-AdjustIndex);
end;

{$IFDEF NEXTGEN}
function TUtilsCustomWideStr.Value: string;
{$ELSE !NEXTGEN}
function TUtilsCustomWideStr.Value: WideString;
{$ENDIF NEXTGEN}
begin
  SetLength(Result, FActualLen);
  Move(Pointer(FContent)^, Pointer(Result)^, FActualLen shl 1);
end;

{$ENDIF}


{ TUtilsWideStringList }

{$IFDEF CLR}

procedure TUtilsWideStringList.AddWideStrings(Strings: TUtilsWideStringList);
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Pred(Strings.Count) do
      AddObject(Strings[I], Strings.Objects[I]);
  finally
    EndUpdate;
  end;
end;

function TUtilsWideStringList.IndexOfLast(const S: WideString): Integer;
// To-do: Add a faster algorithm for sorted lists!
var
  I: Integer;
begin
  for I := GetCount - 1 downto 0 do
    if CompareWideStr(Get(I), S) = 0 then begin
      Result := I;
      Exit;
    end;
  Result := -1;
end;

{$ELSE}

// The code of this class is based on Delphi's TStringList class

destructor TUtilsWideStringList.Destroy;
begin
  FOnChange := nil;
  FOnChanging := nil;
  inherited Destroy;
  FCount := 0;
  SetCapacity(0);
end;

{$IFDEF NEXTGEN}
function TUtilsWideStringList.Add(S: string): Integer;
{$ELSE !NEXTGEN}
function TUtilsWideStringList.Add(S: WideString): Integer;
{$ENDIF NEXTGEN}
begin
  Result := AddObject(S, nil);
end;

{$IFDEF NEXTGEN}
function TUtilsWideStringList.AddObject(S: string; AObject: TObject): Integer;
{$ELSE !NEXTGEN}
function TUtilsWideStringList.AddObject(S: WideString;
  AObject: TObject): Integer;
{$ENDIF NEXTGEN}
begin
  if not Sorted then
    Result := FCount
  else if Find(S, Result) then
    case Duplicates of
      dupIgnore: Exit;
      dupError: raise EStringListError.Create(SNoDuplicatesAllowed);
    end;
  InsertItem(Result, S, AObject);
end;

procedure TUtilsWideStringList.AddWideStrings(Strings: TUtilsWideStringList);
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Pred(Strings.Count) do
      AddObject(Strings[I], Strings.Objects[I]);
  finally
    EndUpdate;
  end;
end;

{$IFDEF NEXTGEN}
procedure TUtilsWideStringList.Append(S: string);
{$ELSE !NEXTGEN}
procedure TUtilsWideStringList.Append(S: WideString);
{$ENDIF NEXTGEN}
begin
  Add(S);
end;

procedure TUtilsWideStringList.Assign(Source: TPersistent);
begin
  if Source is TUtilsWideStringList then
  begin
    if Source = Self then
      Exit;
    BeginUpdate;
    try
      Clear;
      AddWideStrings(TUtilsWideStringList(Source));
    finally
      EndUpdate;
    end;
    Exit;
  end;
  inherited Assign(Source);
end;

procedure TUtilsWideStringList.BeginUpdate;

begin
  if FUpdateCount = 0 then
    SetUpdateState(True);
  Inc(FUpdateCount);
end;

procedure TUtilsWideStringList.Changed;
begin
  if (FUpdateCount = 0) and Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TUtilsWideStringList.Changing;
begin
  if (FUpdateCount = 0) and Assigned(FOnChanging) then
    FOnChanging(Self);
end;

procedure TUtilsWideStringList.Clear;
begin
  if FCount <> 0 then
  begin
    Changing;
    FCount := 0;
    SetCapacity(0);
    Changed;
  end;
end;

procedure TUtilsWideStringList.Delete(Index: Integer);
begin
  if (Index < 0) or (Index >= FCount) then
    raise EStringListError.CreateFmt(SIndexOutOfBounds, [Index]);
  Changing;
  Finalize(FList[Index]);
  Dec(FCount);
  if Index < FCount then
  begin
    System.Move(FList[Index + 1], FList[Index],
      (FCount - Index) * SizeOf(TUtilsWideStringItem));
    PPointer(@FList[FCount])^ := nil;
  end;
  Changed;
end;

procedure TUtilsWideStringList.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
    SetUpdateState(False);
end;

procedure TUtilsWideStringList.Exchange(Index1,
  Index2: Integer);
begin
  if (Index1 < 0) or (Index1 >= FCount) then
    raise EStringListError.CreateFmt(SIndexOutOfBounds, [Index1]);
  if (Index2 < 0) or (Index2 >= FCount) then
    raise EStringListError.CreateFmt(SIndexOutOfBounds, [Index2]);
  Changing;
  ExchangeItems(Index1, Index2);
  Changed;
end;

procedure TUtilsWideStringList.ExchangeItems(Index1,
  Index2: Integer);
var
  Temp: IntPtr;
  Item1, Item2: ^TUtilsWideStringItem;
begin
  Item1 := @FList[Index1];
  Item2 := @FList[Index2];
  Temp := IntPtr(Item1^.FString);
  IntPtr(Item1^.FString) := IntPtr(Item2^.FString);
  IntPtr(Item2^.FString) := Temp;
  Temp := IntPtr(Item1^.FObject);
  IntPtr(Item1^.FObject) := IntPtr(Item2^.FObject);
  IntPtr(Item2^.FObject) := Temp;
end;

{$IFDEF NEXTGEN}
function TUtilsWideStringList.Find(const S: string; var Index: Integer): Boolean;
{$ELSE !NEXTGEN}
function TUtilsWideStringList.Find(const S: WideString;
  var Index: Integer): Boolean;
{$ENDIF NEXTGEN}
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := FCount - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := CompareWideStr(FList[I].FString, S);
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        if Duplicates <> dupAccept then
          L := I;
      end;
    end;
  end;
  Index := L;
end;

{$IFDEF NEXTGEN}
function TUtilsWideStringList.Get(Index: Integer): string;
{$ELSE !NEXTGEN}
function TUtilsWideStringList.Get(Index: Integer): WideString;
{$ENDIF NEXTGEN}
begin
  if (Index < 0) or (Index >= FCount) then
    raise EStringListError.CreateFmt(SIndexOutOfBounds, [Index]);
  Result := FList[Index].FString;
end;

function TUtilsWideStringList.GetCapacity: Integer;
begin
  Result := FCapacity;
end;

function TUtilsWideStringList.GetCount: Integer;
begin
  Result := FCount;
end;

function TUtilsWideStringList.GetObject(Index: Integer): TObject;
begin
  if (Index < 0) or (Index >= FCount) then
    raise EStringListError.CreateFmt(SIndexOutOfBounds, [Index]);
  Result := FList[Index].FObject;
end;

procedure TUtilsWideStringList.Grow;
var
  Delta: Integer;
begin
  if FCapacity > 64 then
    Delta := FCapacity div 4
  else if FCapacity > 8 then
    Delta := 16
  else
    Delta := 4;
  SetCapacity(FCapacity + Delta);
end;

{$IFDEF NEXTGEN}
function TUtilsWideStringList.IndexOf(const S: string): Integer;
{$ELSE !NEXTGEN}
function TUtilsWideStringList.IndexOf(const S: WideString): Integer;
{$ENDIF NEXTGEN}
var
  I: Integer;
begin
  if not Sorted then
  begin
    for I := 0 to GetCount - 1 do
      if CompareWideStr(FList[I].FString, S) = 0 then begin
        Result := I;
        Exit;
      end;
    Result := -1;
  end
  else if not Find(S, Result) then
    Result := -1;
end;

{$IFDEF NEXTGEN}
function TUtilsWideStringList.IndexOfLast(const S: string): Integer;
{$ELSE !NEXTGEN}
function TUtilsWideStringList.IndexOfLast(const S: WideString): Integer;
{$ENDIF NEXTGEN}
// To-do: Add a faster algorithm for sorted lists!
var
  I: Integer;
begin
  for I := GetCount - 1 downto 0 do
    if CompareWideStr(FList[I].FString, S) = 0 then begin
      Result := I;
      Exit;
    end;
  Result := -1;
end;

{$IFDEF NEXTGEN}
procedure TUtilsWideStringList.Insert(Index: Integer; const S: string);
{$ELSE !NEXTGEN}
procedure TUtilsWideStringList.Insert(Index: Integer; const S: WideString);
{$ENDIF NEXTGEN}
begin
  InsertObject(Index, S, nil);
end;

{$IFDEF NEXTGEN}
procedure TUtilsWideStringList.insertObject(Index: Integer;
  const S: string; AObject: TObject);
{$ELSE !NEXTGEN}
procedure TUtilsWideStringList.insertObject(Index: Integer;
  const S: WideString; AObject: TObject);
{$ENDIF NEXTGEN}
begin
  if Sorted then
    raise EStringListError.Create(SOnlyWhenSorted);
  if (Index < 0) or (Index > FCount) then
    raise EStringListError.CreateFmt(SIndexOutOfBounds, [Index]);
  InsertItem(Index, S, AObject);
end;

{$IFDEF NEXTGEN}
procedure TUtilsWideStringList.InsertItem(Index: Integer;
  const S: string; AObject: TObject);
{$ELSE !NEXTGEN}
procedure TUtilsWideStringList.InsertItem(Index: Integer;
  const S: WideString; AObject: TObject);
{$ENDIF NEXTGEN}
begin
  Changing;
  if FCount = FCapacity then
    Grow;
  if Index < FCount then
    System.Move(FList[Index], FList[Index + 1],
      (FCount - Index) * SizeOf(TUtilsWideStringItem));

  Pointer(FList[Index].FString) := nil;
  FList[Index].FObject := AObject;
  FList[Index].FString := S;

  Inc(FCount);
  Changed;
end;

{$IFDEF NEXTGEN}
procedure TUtilsWideStringList.Put(Index: Integer; const S: string);
{$ELSE !NEXTGEN}
procedure TUtilsWideStringList.Put(Index: Integer; const S: WideString);
{$ENDIF NEXTGEN}
begin
  if Sorted then
    raise EStringListError.Create(SOnlyWhenSorted);
  if (Index < 0) or (Index >= FCount) then
    raise EStringListError.CreateFmt(SIndexOutOfBounds, [Index]);
  Changing;
  FList[Index].FString := S;
  Changed;
end;

procedure TUtilsWideStringList.PutObject(Index: Integer;
  AObject: TObject);
begin
  if (Index < 0) or (Index >= FCount) then
    raise EStringListError.CreateFmt(SIndexOutOfBounds, [Index]);
  Changing;
  FList[Index].FObject := AObject;
  Changed;
end;

procedure TUtilsWideStringList.QuickSort(L,
  R: Integer);
var
  I, J: Integer;
{$IFDEF NEXTGEN}
  P: string;
{$ELSE !NEXTGEN}
  P: WideString;
{$ENDIF NEXTGEN}
begin
  repeat
    I := L;
    J := R;
    P := FList[(L + R) shr 1].FString;
    repeat
      while CompareWideStr(FList[I].FString, P) < 0 do
        Inc(I);
      while CompareWideStr(FList[J].FString, P) > 0 do
        Dec(J);
      if I <= J then
      begin
        ExchangeItems(I, J);
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(L, J);
    L := I;
  until I >= R;
end;

procedure TUtilsWideStringList.SetCapacity(NewCapacity: Integer);
begin
  //ReallocMem(FList, NewCapacity * SizeOf(TUtilsWideStringItem));
  SetLength(FList, NewCapacity);
  FCapacity := NewCapacity;
end;

procedure TUtilsWideStringList.SetSorted(const Value: Boolean);
begin
  if FSorted <> Value then
  begin
    if Value then
      Sort;
    FSorted := Value;
  end;
end;

procedure TUtilsWideStringList.SetUpdateState(updating: Boolean);
begin
  if Updating then
    Changing
  else
    Changed;
end;

procedure TUtilsWideStringList.Sort;
begin
  if not Sorted and (FCount > 1) then
  begin
    Changing;
    QuickSort(0, FCount - 1);
    Changed;
  end;
end;
{$ENDIF}


{ TUtilsWideStringStream }

{$IFDEF CLR}

constructor TUtilsWideStringStream.Create;
begin
  Create('');
end;

constructor TUtilsWideStringStream.Create(const AString: WideString);
begin
  inherited Create;
  WriteString(AString);
  Position := 0;
end;

function TUtilsWideStringStream.GetDataString: string;
begin
  if Assigned(Memory) then
    Result := System.Text.Encoding.Unicode.GetString(Memory, Low(Memory), Size)
  else
    Result := '';
end;

function TUtilsWideStringStream.ReadString(Count: Longint): WideString;
// Reads Count WideChars from stream and returns them as WideString.
var
  Bytes: TBytes;
  Len: Longint;
begin
  if Odd(Position) then
    raise EReadError.Create(SCannotReadOddPos);
  Len := (Size - Position) shr 1;
  if Len > Count then
    Len := Count;
  SetLength(Bytes, Len shl 1);
  Read(Bytes, 0, Length(Bytes));
  Result := WideStringOf(Bytes);
end;

procedure TUtilsWideStringStream.WriteString(const AString: WideString);
// Writes AString into stream, starting at StringPosition, overwriting
// existing characters and extending the stream if necessary.
var
  Bytes: TBytes;
begin
  if Odd(Position) then
    raise EWriteError.Create(SCannotWriteOddPos);
  Bytes := System.Text.Encoding.Unicode.GetBytes(AString);
  Write(Bytes, Length(Bytes));
end;

procedure TUtilsWideStringStream.SetSize(NewSize: Int64);
// Sets stream size in bytes.
begin
  if Odd(NewSize) then
    raise EStreamError.Create(SOddSizeInvalid);
  if NewSize < 0 then
    raise EStreamError.Create(SNegativeSizeInvalid);

  inherited SetSize(NewSize);
end;

procedure TUtilsWideStringStream.SetStringPosition(Value: Longint);
// Sets string position in terms of WideChars.
begin
  Position := (Value - 1) shl 1;
end;

function TUtilsWideStringStream.GetStringPosition: Longint;
// Sets string position in terms of WideChars.
begin
  if Odd(Position) then
    raise EStreamError.Create(SOddPosInvalid);
  Result := (Position shr 1) + 1;
end;

procedure TUtilsWideStringStream.SetStringLength(Value: Longint);
// Sets string Length in terms of WideChars.
begin
  SetSize(Value shl 1);
end;

function TUtilsWideStringStream.GetStringLength: Longint;
// Gets string Length in terms of WideChars.
begin
  Result := Size shr 1;
end;

{$ELSE}

// Provided by Karl Waclawek.
//
// This is a stream interface for WideStrings.
// Purpose: Avoid excessive memory re-allocations that occur with
//          WideStrings because they are not reference counted.
//  Note: When the DataString property is accessed, the complete
//        WideString will be copied out.

{$IFDEF NEXTGEN}
constructor TUtilsWideStringStream.Create(const AString: string);
{$ELSE !NEXTGEN}
constructor TUtilsWideStringStream.Create(const AString: WideString);
{$ENDIF NEXTGEN}
begin
  inherited Create;
  SetSize(Length(AString) shl 1);
  Move(Pointer(AString)^, FDataStringP^, FSize); // Make a copy of AString.
end;

destructor TUtilsWideStringStream.Destroy;
begin
  FreeMem(FDataStringP);
  inherited Destroy;
end;

{$IFDEF NEXTGEN}
function TUtilsWideStringStream.GetDataString: string;
{$ELSE !NEXTGEN}
function TUtilsWideStringStream.GetDataString: WideString;
{$ENDIF NEXTGEN}
begin
  SetLength(Result, StringLength);
  Move(FDataStringP^, Pointer(Result)^, FSize);
end;

function TUtilsWideStringStream.Read(var Buffer; Count: Longint): Longint;
begin
  Result := FSize - FPosition;
  if Result > Count then
    Result := Count;
  Move((FDataStringP + FPosition)^, Buffer, Result);
  Inc(FPosition, Result);
end;

function TUtilsWideStringStream.Write(const Buffer; Count: Longint): Longint;
var
  NewPos: Longint;
begin
  Result := Count;
  NewPos := FPosition + Result;
  if NewPos > FSize then
    SetSize(((NewPos + 1) shr 1) shl 1); // Next larger even Value
  Move(Buffer, (FDataStringP + FPosition)^, Result);
  FPosition := NewPos;
end;

function TUtilsWideStringStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
  case Origin of
    soFromBeginning: FPosition := Offset;
    soFromCurrent: FPosition := FPosition + Offset;
    soFromEnd: FPosition := FSize - Offset;
  end;
  if FPosition > FSize then
    FPosition := FSize
  else if FPosition < 0 then
    FPosition := 0;
  Result := FPosition;
end;

{$IFDEF NEXTGEN}
function TUtilsWideStringStream.ReadString(Count: Longint): string;
{$ELSE !NEXTGEN}
function TUtilsWideStringStream.ReadString(Count: Longint): WideString;
{$ENDIF NEXTGEN}
// Reads Count WideChars from stream and returns them as WideString.
var
  Len: Longint;
begin
  if Odd(FPosition) then
    raise EReadError.Create(SCannotReadOddPos);
  Len := (FSize - FPosition) shr 1;
  if Len > Count then
    Len := Count;
  SetLength(Result, Len);
  Read(Pointer(Result)^, Len shl 1);
end;

{$IFDEF NEXTGEN}
procedure TUtilsWideStringStream.WriteString(const AString: string);
{$ELSE !NEXTGEN}
procedure TUtilsWideStringStream.WriteString(const AString: WideString);
{$ENDIF NEXTGEN}
// Writes AString into stream, starting at StringPosition, overwriting
// existing characters and extending the stream if necessary.
begin
  if Odd(FPosition) then
    raise EWriteError.Create(SCannotWriteOddPos);
  Write(Pointer(AString)^, Length(AString) shl 1);
end;

procedure TUtilsWideStringStream.SetCapacity(NewCapacity: Longint);
// Sets stream Capacity in bytes.
begin
  if NewCapacity < FSize then
    raise EStreamError.Create(SCapacityLessSize);
  ReallocMem(FDataStringP, NewCapacity);
  FCapacity := NewCapacity;
end;

procedure TUtilsWideStringStream.SetSize(NewSize: Longint);
// Sets stream size in bytes.
var
  Delta: Longint;
begin
  if Odd(NewSize) then
    raise EStreamError.Create(SOddSizeInvalid);
  if NewSize > Capacity then
  begin
    Delta := NewSize shr 2;
    if Delta < 8 then
      Delta := 8;
    SetCapacity(((NewSize + Delta) shr 2) shl 2); // Make it a multiple of 4
  end
  else if NewSize < 0 then
    raise EStreamError.Create(SNegativeSizeInvalid);
  FSize := NewSize;
  if FPosition > FSize then
    FPosition := FSize;
end;

procedure TUtilsWideStringStream.SetStringPosition(Value: Longint);
// Sets string position in terms of WideChars.
begin
  Position := (Value - 1) shl 1;
end;

function TUtilsWideStringStream.GetStringPosition: Longint;
// Sets string position in terms of WideChars.
begin
  if Odd(Position) then
    raise EStreamError.Create(SOddPosInvalid);
  Result := (Position shr 1) + 1;
end;

procedure TUtilsWideStringStream.SetStringLength(Value: Longint);
// Sets string Length in terms of WideChars.
begin
  SetSize(Value shl 1);
end;

function TUtilsWideStringStream.GetStringLength: Longint;
// Gets string Length in terms of WideChars.
begin
  Result := FSize shr 1;
end;
{$ENDIF}

end.

