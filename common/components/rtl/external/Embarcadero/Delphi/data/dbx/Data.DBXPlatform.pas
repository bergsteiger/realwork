{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXPlatform;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  Data.FMTBcd,
  Data.SqlTimSt,
  System.Classes,
  System.SyncObjs
;

type
  TInt32                   = LongInt;
{$IFNDEF NEXTGEN}
  TDBXAnsiChars            = array of AnsiChar;
  TDBXWideChars            = array of WideChar;
{$ELSE}
  TDBXAnsiChars            = array of Char;
  TDBXWideChars            = array of Char;
{$ENDIF !NEXTGEN}
  TDBXAnsiString           = MarshaledAString;
  TDBXAnsiStringBuilder    = MarshaledAString;
  TDBXWideString           = MarshaledString;
  TDBXWideStringBuilder    = MarshaledString;
  TDBXInt32s               = array of Integer;
  TDBXBooleans             = array of Boolean;
  TDBXStringArray          = array of string;
  TDBXObjectArray          = array of TObject;
  TDBXStringList           = TStringList;


  /// <summary> Used to keep pass metadata back from a server function execution, other than any
  ///  output or return parameters in the function's signature.
  /// </summary>
  /// <remarks> Useful, for example, if
  ///  you wish to specify a custom HTTP status code and/or message.
  /// </remarks>
  TDSInvocationMetadata = class
  private
    FResponseCode: Integer;
    FResponseMessage: string;
    FResponseContent: string;
    FResponseContentType: string;
    FCloseSession: Boolean;
    FQueryParams: TStrings;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    property ResponseCode: Integer read FResponseCode write FResponseCode;
    property ResponseMessage: string read FResponseMessage write FResponseMessage;
    property ResponseContent: string read FResponseContent write FResponseContent;
    property ResponseContentType: string read FResponseContentType write FResponseContentType;
    property CloseSession: Boolean read FCloseSession write FCloseSession;

    /// <summary>The query parameters from the URL of the request.</summary>
    property QueryParams: TStrings read FQueryParams;
  end;

  TDBXInt32Object = class
  public
    constructor Create(const Value: Integer);
    destructor Destroy; override;
    function IntValue: Integer;
  private
    FValue: Integer;
  end;

  TDBXTokenizer = class
  private
    FOriginal: string;
    FDelimiters: string;
    FNextPos: Integer;
  public
    constructor Create(const Original: string; const Delimiters: string);
    function HasMoreTokens: Boolean;
    function NextToken: string;
  end;

type
  ///<summary>
  ///  Base Class for DataSnap Filter Collection
  ///</summary>
  TBaseTransportFilterCollection = class(TCollection)
  private
    FEvent: TNotifyEvent;
  protected
    procedure NotifyChange;
  public
    destructor Destroy; override;
    function GetItem(Index: Integer): TCollectionItem;
    property OnChange: TNotifyEvent read FEvent write FEvent;
  end;

  {$MethodInfo on}
  TFactoryObject = class
  public
    constructor Create; virtual;
  end;
  {$MethodInfo off}

  TObjectClass = class of TFactoryObject;

  TBaseTransportFactoryTools = class
  public
    class function InvokeStringFunction(objClass: TObjectClass; methodName: string): string;
  end;

  ///<summary>
  ///  Base Class for DataSnap Filter
  ///</summary>
  TBaseTransportFilter = TFactoryObject;

  TBaseTransportFilterItem = class(TCollectionItem)
  private
    FEvent: TNotifyEvent;
  protected
    procedure NotifyChange;
  public
    constructor Create(Collection: TCollection); override;
    procedure OnChangeNotify(filter: TBaseTransportFilterCollection);
    property OnChange: TNotifyEvent read FEvent write FEvent;
  end;

  TBaseFilterProperties = class(TStringList)
  public
    function GetName(Index: Integer): string;
    function GetValue(Index: Integer): string;
    procedure Add(const Name, Value: string); reintroduce;
  end;

  TTransportFilterClass = class of TBaseTransportFilter;

function Incr(var Arg: Integer): Integer; inline;
function Decr(var Arg: Integer): Integer; inline;
function IncrAfter(var Arg: Integer): Integer; inline;
function DecrAfter(var Arg: Integer): Integer; inline;
function C_Conditional(const Condition: Boolean; const TruePart, FalsePart: string): string;
function CompareTimeStamp(const ATimeStamp: TSQLTimeStamp; const BTimeStamp: TSQLTimeStamp): Integer;
function CompareTimeStampOffset(const ATimeStamp: TSQLTimeStampOffset; const BTimeStamp: TSQLTimeStampOffset): Integer;

const
  NullString = '';
  {$EXTERNALSYM NullString}

type
  TDBXFreeArray = TDBXObjectArray;

  TDBXArrayList = class
  private
    FList: TList<TObject>;
  private
    function GetValue(Index: Integer): TObject;
    procedure SetValue(Index: Integer; Value: TObject);
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(Element: TObject);
    procedure RemoveAt(Index: Integer);
    procedure Remove(Index: Integer); overload;
    procedure Remove(Element: TObject); overload;
  public
    property Count: Integer read GetCount;
    property Values[Index: Integer]: TObject read GetValue write SetValue; default;
  end;

procedure FreeObjectArray(var ArrayObject: TDBXFreeArray);
function IsIdentifierStart(const Ch: Char): Boolean;
function IsIdentifierPart(const Ch: Char): Boolean;
function FormatMessage(const FormatString: string; const Parameters: TDBXStringArray): string;

type
  TDBXObjectStore = class
  strict private
    FOwnsObjects: Boolean;
  private
    FDictionary: TDictionary<string,TObject>;
    function GetObjectFromName(const Name: string): TObject;
    procedure SetObjectByName(const Name: string; const Value: TObject);
    function GetOwnsObjects: Boolean;
  public
    constructor Create; overload;
    constructor Create(const AOwnsObjects: Boolean); overload;
    destructor Destroy; override;
    function ContainsKey(const Name: string): Boolean;
    procedure Delete(const Name: string);
    function Extract(const Name: string): TObject;
    property Objects[const Name: string]: TObject read GetObjectFromName write SetObjectByName; default;
    property OwnsObjects: Boolean read GetOwnsObjects;
    function Keys: TArray<string>;
  end;

  TDBXPlatform = class
{$IFNDEF NEXTGEN}
    class function AnsiStrToBytes(const Value: AnsiString): TArray<Byte>; static;
    class function BytesToAnsiStr(const Value: TArray<Byte>): AnsiString; static; inline;
    class procedure CopyStringBuilder(const Value: TDBXAnsiStringBuilder; var Dest: AnsiString); static; inline;
    class procedure CopyStringToBuilder(const Source: AnsiString; AnsiStringBuilderSize: Integer; var Value: TDBXAnsiStringBuilder); static;
    class function  CreateAnsiString(const Source: TDBXAnsiChars; Count: Integer): AnsiString; static; inline;
{$ENDIF !NEXTGEN}
    class function WideStrToBytes(const Value: string): TArray<Byte>; static; inline;
    class function BytesToWideStr(const Value: TArray<Byte>): string; static;

    class function GetStringBuilderLength(const Value: TDBXAnsiStringBuilder): TInt32; static;
    class function CreateStringBuilder(Length:  TInt32): TDBXAnsiStringBuilder; static;
    class procedure FreeAndNilStringBuilder(var Value: TDBXAnsiStringBuilder); static;
    class procedure ResizeStringBuilder(var Value: TDBXAnsiStringBuilder; Size: Integer); static;

    class function GetWideStringBuilderLength(const Value: TDBXWideStringBuilder): TInt32; static; inline;
    class function CreateWideStringBuilder(Length:  TInt32): TDBXWideStringBuilder; static; inline;
    class function ToWideString(const Value: TDBXWideStringBuilder): string; static; inline;
    class procedure CopyWideStringBuilder(const Value: TDBXWideStringBuilder; var Dest: string); static; inline;
    class procedure ResizeWideStringBuilder(var Value: TDBXWideStringBuilder; Size: Integer); static; inline;
    class procedure FreeAndNilWideStringBuilder(var Value: TDBXWideStringBuilder); static;
    class procedure CopyWideStringToBuilder(const Source: string; WideStringBuilderSize: Integer; var Value: TDBXWideStringBuilder); static;

    class procedure CopyInt32Array(const Source: TDBXInt32s; SourceOffset: Integer; const Dest: TDBXInt32s; DestOffset: Integer; Count: Integer); static; inline;
    class procedure CopyCharArray(const Source: TDBXWideChars; SourceOffset: Integer; const Dest: TDBXWideChars; DestOffset: Integer; Count: Integer); static; inline;
    class procedure CopyByteArray(const Source: TArray<Byte>; SourceOffset: Integer; const Dest: TArray<Byte>; DestOffset: Integer; Count: Integer); static; inline;
    class function  CreateWideString(const Source: TDBXWideChars; Count: Integer): string; static; inline;
    class procedure WriteAsciiBytes(const Message: string; ByteBuffer: TArray<Byte>; Offset: Integer; Count: Integer);
    class function  Int64BitsToDouble(const Value: Int64): Double;
    class function  DoubleToInt64Bits(const Value: Double): Int64;
    class function Int32BitsToSingle(const Value: TInt32): Single; static;
    class function SingleToInt32Bits(const Value: Single): TInt32; static;
    class procedure CopyBytesToAnsiChars(const Source: TArray<Byte>; SourceOffset: Integer; const Dest: TDBXAnsiChars; DestOffset: Integer; Count: Integer); static; inline;
    class procedure CopyBytesToWideChars(const Source: TArray<Byte>; SourceOffset: Integer; const Dest: TDBXWideChars; DestOffset: Integer; Count: Integer); static; inline;

    class procedure CopyInt32(const Value: Integer; const Dest: TArray<Byte>; const DestOffset: Integer); static; inline;
    class procedure CopyInt16(const Value: SmallInt; const Dest: TArray<Byte>; const DestOffset: Integer); static; inline;
    class procedure CopyUInt16(const Value: Word; const Dest: TArray<Byte>; const DestOffset: Integer); static; inline;
    class procedure CopyInt64(const Value: Int64; const Dest: TArray<Byte>; const DestOffset: Integer); static; inline;
    class procedure CopyInt8(const Value: ShortInt; const Dest: TArray<Byte>; const DestOffset: Integer); static; inline;
    class procedure CopyUInt8(const Value: Byte; const Dest: TArray<Byte>; const DestOffset: Integer); static; inline;
    class procedure CopySqlTimeStamp(const Value: TSQLTimeStamp; const Dest: TArray<Byte>; const DestOffset: Integer); static; inline;
    class procedure CopySqlTimeStampOffset(const Value: TSQLTimeStampOffset; const Dest: TArray<Byte>; const DestOffset: Integer); static; inline;
    class procedure CopyBcd(const Value: TBcd; const Dest: TArray<Byte>; const DestOffset: Integer); static; inline;
    class procedure Sleep(const Duration: Int64);
    class function GetClassName(ObjectValue: TObject): string; static;
    class function GetNestedException(Ex: Exception): Exception; static;
    class function GetPublicKeyToken: string;

    ///  <summary>  Converts a double into a string using dot character
    ///  </summary>
    class function JsonFloat(Value: Double): string; static;
    class function JsonToFloat(DotValue: string): double; static;
    class function TryJsonToFloat(DotValue: string; var Value: Double): Boolean;
    ///  <summary>  Checks to see if the argument represents a valid boolean string representation
    ///  </summary>
    ///  <param name="Value">The string to check for if it is a boolean</param>
    ///  <result>true if the string value is a boolean, false otherwise</result>
    class function IsBoolean(const value: string): Boolean; static;

    class function StringOf(Data: TArray<Byte>; const Size: Integer): string;

  private
    class procedure UnexpectedStringOverflow(const Source: string; WideStringBuilderSize: Integer); overload; static;
{$IFNDEF NEXTGEN}
    class procedure UnexpectedStringOverflow(const Source: AnsiString; AnsiStringBuilderSize: Integer); overload; static;
{$ENDIF !NEXTGEN}
  end;

                                                               
                                                  
  TDBXSemaphore = class(TSemaphore)
  private
    FCount:           Integer;
  public
    constructor Create(Count: Integer);
    function Acquire(Timeout: Int64): Boolean; reintroduce;
  end;

  ///  <summary>  Returns the stored Invocation Metadata for the current thread </summary>
  ///  <param name="CreateIfNil">True if a new instance of TDSInvocationMetadata should
  ///    be created and storedinstead of returning nil</param>
  ///  <result>the metadata stored for the current thread, or nil (if CreateIfNil is False)</result>
  function GetInvocationMetadata(CreateIfNil : Boolean = True): TDSInvocationMetadata;

  ///  <summary>  Stores a new instance of Invocation Metadata for the current thread </summary>
  ///  <param name="MetaData">The new metadata to store</param>
  procedure SetInvocationMetadata(MetaData: TDSInvocationMetadata);

  ///  <summary>  Frees and nils the invocation metadata stored for the current thread, if any </summary>
  procedure ClearInvocationMetadata;

implementation

uses
  Data.DBXCommonResStrs,
  System.Math,
  System.StrUtils,
  System.Rtti,
  System.Generics.Defaults
{$IFNDEF POSIX}
  , Winapi.Windows
{$ENDIF}
;

ThreadVar
  InvokeMetadata: TDSInvocationMetadata;

function GetInvocationMetadata(CreateIfNil : Boolean = True): TDSInvocationMetadata;
begin
  if (InvokeMetadata = nil) and CreateIfNil then
  begin
    InvokeMetadata := TDSInvocationMetadata.Create;
  end;
  Result := InvokeMetadata;
end;

procedure SetInvocationMetadata(MetaData: TDSInvocationMetadata);
begin
  FreeAndNil(InvokeMetadata);
  InvokeMetadata := MetaData;
end;

procedure ClearInvocationMetadata;
begin
  FreeAndNil(InvokeMetadata);
end;

constructor TDBXInt32Object.Create(const Value: Integer);
begin
  inherited Create;
  FValue := Value;
end;

destructor TDBXInt32Object.Destroy;
begin
  inherited Destroy;
end;

function TDBXInt32Object.IntValue: Integer;
begin
  Result := FValue;
end;

constructor TDBXTokenizer.Create(const Original: string; const Delimiters: string);
begin
  inherited Create;
  FOriginal := Original;
  FDelimiters := Delimiters;
  FNextPos := 0;
end;

function TDBXTokenizer.HasMoreTokens: Boolean;
var
  Ch: Char;
begin
  Result := False;
  while FNextPos <= High(FOriginal) do
  begin
    Ch := FOriginal.Chars[FNextPos];
    if FDelimiters.IndexOf(Ch) < 0 then
    begin
      Result := True;
      Exit;
    end;
    Inc(FNextPos);
  end;
end;

function TDBXTokenizer.NextToken: string;
var
  Ch: WideChar;
  StartPos: Integer;
begin
  if not HasMoreTokens then
    Result := ''
  else
  begin
    StartPos := FNextPos;
    while FNextPos <= High(FOriginal) do
    begin
      Ch := FOriginal.Chars[FNextPos];
      if FDelimiters.IndexOf(Ch) < 0 then
        Inc(FNextPos)
      else
        Break;
    end;
    Result := FOriginal.Substring(StartPos, FNextPos - StartPos);
  end;
end;

function Incr(var Arg: Integer): Integer;
begin
  Inc(Arg);
  Result := Arg;
end;

function Decr(var Arg: Integer): Integer;
begin
  Dec(Arg);
  Result := Arg;
end;

function IncrAfter(var Arg: Integer): Integer;
begin
  Result := Arg;
  Inc(Arg);
end;

function DecrAfter(var Arg: Integer): Integer;
begin
  Result := Arg;
  Dec(Arg);
end;

function C_Conditional(const Condition: Boolean; const TruePart, FalsePart: string): string;
begin
  if Condition then
    Result := TruePart
  else
    Result := FalsePart;
end;

function CompareTimeStamp(const ATimeStamp: TSQLTimeStamp; const BTimeStamp: TSQLTimeStamp): Integer;
var
  Status: Integer;
begin
  Status := ATimeStamp.Year - BTimeStamp.Year;
  if Status = 0 then
    Status := ATimeStamp.Month - BTimeStamp.Month;
  if Status = 0 then
    Status := ATimeStamp.Day - BTimeStamp.Day;
  if Status = 0 then
    Status := ATimeStamp.Hour - BTimeStamp.Hour;
  if Status = 0 then
    Status := ATimeStamp.Hour - BTimeStamp.Hour;
  if Status = 0 then
    Status := ATimeStamp.Minute - BTimeStamp.Minute;
  if Status = 0 then
    Status := ATimeStamp.Second - BTimeStamp.Second;
  if Status = 0 then
    Status := ATimeStamp.Fractions - BTimeStamp.Fractions;
  Result := Status;
end;

function CompareTimeStampOffset(const ATimeStamp: TSQLTimeStampOffset; const BTimeStamp: TSQLTimeStampOffset): Integer;
var
  Status: Integer;
begin
  Status := ATimeStamp.Year - BTimeStamp.Year;
  if Status = 0 then
    Status := ATimeStamp.Month - BTimeStamp.Month;
  if Status = 0 then
    Status := ATimeStamp.Day - BTimeStamp.Day;
  if Status = 0 then
    Status := ATimeStamp.Hour - BTimeStamp.Hour;
  if Status = 0 then
    Status := ATimeStamp.Hour - BTimeStamp.Hour;
  if Status = 0 then
    Status := ATimeStamp.Minute - BTimeStamp.Minute;
  if Status = 0 then
    Status := ATimeStamp.Second - BTimeStamp.Second;
  if Status = 0 then
    Status := ATimeStamp.Fractions - BTimeStamp.Fractions;
  if Status = 0 then
    Status := ATimeStamp.TimeZoneHour - BTimeStamp.TimeZoneHour;
  if Status = 0 then
    Status := ATimeStamp.TimeZoneMinute - BTimeStamp.TimeZoneMinute;
  Result := Status;
end;

procedure FreeObjectArray(var ArrayObject: TDBXFreeArray);
var
  Index: Integer;
begin
  if ArrayObject <> nil then
  begin
    for Index := Low(ArrayObject) to High(ArrayObject) do
      ArrayObject[Index].Free;
    ArrayObject := nil;
  end;
end;

function IsIdentifierStart(const Ch: Char): Boolean;
begin
  case Ch of
    'a'..'z',
    'A'..'Z',
    '_':
      Result := True;
    else
      Result := False;
  end;
end;

function IsIdentifierPart(const Ch: Char): Boolean;
begin
  case Ch of
    'a'..'z',
    'A'..'Z',
    '0'..'9',
    '_':
      Result := True;
    else
      Result := False;
  end;
end;

function FormatMessage(const FormatString: string; const Parameters: TDBXStringArray): string;
var
  Buffer: TStringBuilder;
  Ch: Char;
  Index, ParameterIndex, Start: Integer;
  Quoted: Boolean;
begin
  Index := 1;
  Quoted := False;
  Buffer := TStringBuilder.Create;
  try
    while Index <= FormatString.Length do
    begin
      Ch := FormatString.Chars[Index - 1];
      case Ch of
        '{':
          begin
            Start := Index + 1;
            while (Index < FormatString.Length) and (Ch <> '}') do
            begin
              Inc(Index);
              Ch := FormatString.Chars[Index - 1];
            end;
            if Ch <> '}' then
              raise Exception.Create(string.Format(SUnmatchedBrace,[FormatString]));
            ParameterIndex := StrToInt(FormatString.Substring(Start - 1, Index - Start));
            if (ParameterIndex < 0) or (ParameterIndex > Length(Parameters)) then
              raise Exception.Create(string.Format(SParameterIndexOutOfRange,[ParameterIndex]));
            Buffer.Append(Parameters[ParameterIndex]);
            Inc(Index);
          end;

        '''':
          begin
            if (Index = FormatString.Length) or (FormatString.Chars[Index] <> '''') then
              Quoted := not Quoted
            else
            begin
              Buffer.Append(Ch);
              Inc(Index);
            end;
          end;

        else
          Buffer.Append(Ch);
          Inc(Index);
      end;
    end;
    Result := Buffer.ToString;
  finally
    FreeAndNil(Buffer);
  end;
end;

constructor TDBXArrayList.Create;
begin
  inherited;
  FList := TList<TObject>.Create;
end;

destructor TDBXArrayList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TDBXArrayList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TDBXArrayList.GetValue(Index: Integer): TObject;
begin
  Result := FList[Index];
end;

procedure TDBXArrayList.SetValue(Index: Integer; Value: TObject);
begin
  FList[Index] := Value;
end;

procedure TDBXArrayList.Remove(Element: TObject);
begin
  FList.Remove(Element);
end;

procedure TDBXArrayList.Remove(Index: Integer);
begin
  FList.Remove(FList[Index]);
end;

procedure TDBXArrayList.RemoveAt(Index: Integer);
begin
  Remove(Index);
end;

procedure TDBXArrayList.Add(Element: TObject);
begin
  FList.Add(Element);
end;

procedure TDBXArrayList.Clear;
begin
  FList.Clear;
end;

constructor TDBXObjectStore.Create;
begin
  Create(False);
end;

constructor TDBXObjectStore.Create(const AOwnsObjects: Boolean);
begin
  inherited Create;
  FOwnsObjects := AOwnsObjects;
  if FOwnsObjects then
    FDictionary := TObjectDictionary<string,TObject>.Create([doOwnsValues], TIStringComparer.Ordinal)
  else
    FDictionary := TObjectDictionary<string,TObject>.Create([], TIStringComparer.Ordinal)
end;

destructor TDBXObjectStore.Destroy;
begin
  FDictionary.Free;
  inherited Destroy;
end;

function TDBXObjectStore.Extract(const Name: string): TObject;
begin
  Result := FDictionary.ExtractPair(Name).Value;
end;

procedure TDBXObjectStore.Delete(const Name: string);
begin
  FDictionary.Remove(Name);
end;

function TDBXObjectStore.ContainsKey(const Name: string): Boolean;
begin
  Result := FDictionary.ContainsKey(Name);
end;

function TDBXObjectStore.GetObjectFromName(const Name: string): TObject;
begin
  if FDictionary.ContainsKey(Name) then
    Result := FDictionary.Items[Name]
  else 
    Result := nil;
end;

function TDBXObjectStore.GetOwnsObjects: Boolean;
begin
  Result := FOwnsObjects;
end;

function TDBXObjectStore.Keys: TArray<string>;
begin
  Result := FDictionary.Keys.ToArray;
end;

procedure TDBXObjectStore.SetObjectByName(const Name: string; const Value: TObject);
begin
  if FDictionary.ContainsKey(Name) then
    FDictionary.Items[Name] := Value
  else
    FDictionary.Add(Name, Value);
end;

{ TDBXPlatform }

class procedure TDBXPlatform.CopyInt32(const Value: Integer; const Dest: TArray<Byte>; const DestOffset: Integer);
begin
    Dest[DestOffset]    := Byte(Value);
    Dest[DestOffset+1]  := Byte(Value shr 8);
    Dest[DestOffset+2]  := Byte(Value shr 16);
    Dest[DestOffset+3]  := Byte(Value shr 24);
end;

class procedure TDBXPlatform.CopyInt64(const Value: Int64; const Dest: TArray<Byte>; const DestOffset: Integer);
begin
    Dest[DestOffset]    := Byte(Value);
    Dest[DestOffset+1]  := Byte(Value shr 8);
    Dest[DestOffset+2]  := Byte(Value shr 16);
    Dest[DestOffset+3]  := Byte(Value shr 24);

    Dest[DestOffset+4] := Byte(Value shr 32);
    Dest[DestOffset+5] := Byte(Value shr 40);
    Dest[DestOffset+6] := Byte(Value shr 48);
    Dest[DestOffset+7] := Byte(Value shr 56);

end;

class procedure TDBXPlatform.CopyInt8(const Value: ShortInt; const Dest: TArray<Byte>;
  const DestOffset: Integer);
begin
    Dest[DestOffset]    := Byte(Value);
end;

class procedure TDBXPlatform.CopyUInt16(const Value: Word; const Dest: TArray<Byte>;
  const DestOffset: Integer);
begin
    Dest[DestOffset]    := Byte(Value);
    Dest[DestOffset+1]  := Byte(Value shr 8);
end;

class procedure TDBXPlatform.CopyUInt8(const Value: Byte; const Dest: TArray<Byte>;
  const DestOffset: Integer);
begin
  Dest[DestOffset] := Byte(Value);
end;

class procedure TDBXPlatform.CopyInt16(const Value: SmallInt;
  const Dest: TArray<Byte>; const DestOffset: Integer);
begin
    Dest[DestOffset]    := Byte(Value);
    Dest[DestOffset+1]  := Byte(Value shr 8);
end;

class procedure TDBXPlatform.CopySqlTimeStamp(const Value: TSQLTimeStamp;
  const Dest: TArray<Byte>; const DestOffset: Integer);
begin
    TDBXPlatform.CopyInt16(Value.Year, Dest, DestOffset);
    TDBXPlatform.CopyInt16(Value.Month, Dest, DestOffset+2);
    TDBXPlatform.CopyInt16(Value.Day, Dest, DestOffset+4);
    TDBXPlatform.CopyInt16(Value.Hour, Dest, DestOffset+6);
    TDBXPlatform.CopyInt16(Value.Minute, Dest, DestOffset+8);
    TDBXPlatform.CopyInt16(Value.Second, Dest, DestOffset+10);
    TDBXPlatform.CopyInt32(Value.Fractions, Dest, DestOffset+12);
end;

class procedure TDBXPlatform.CopySqlTimeStampOffset(const Value: TSQLTimeStampOffset;
  const Dest: TArray<Byte>; const DestOffset: Integer);
begin
    TDBXPlatform.CopyInt16(Value.Year, Dest, DestOffset);
    TDBXPlatform.CopyInt16(Value.Month, Dest, DestOffset+2);
    TDBXPlatform.CopyInt16(Value.Day, Dest, DestOffset+4);
    TDBXPlatform.CopyInt16(Value.Hour, Dest, DestOffset+6);
    TDBXPlatform.CopyInt16(Value.Minute, Dest, DestOffset+8);
    TDBXPlatform.CopyInt16(Value.Second, Dest, DestOffset+10);
    TDBXPlatform.CopyInt32(Value.Fractions, Dest, DestOffset+12);
    TDBXPlatform.CopyInt16(Value.TimeZoneHour, Dest, DestOffset+16);
    TDBXPlatform.CopyInt16(Value.TimeZoneMinute, Dest, DestOffset+18);
end;

class procedure TDBXPlatform.CopyBcd(const Value: TBcd; const Dest: TArray<Byte>;
  const DestOffset: Integer);
begin
  Dest[DestOffset] := Value.Precision;
  Dest[DestOffset+1] := Value.SignSpecialPlaces;
  Move(Value.Fraction[0], Dest[DestOffset+2], Length(Value.Fraction));
end;

class function TDBXPlatform.CreateStringBuilder(
  Length: TInt32): TDBXAnsiStringBuilder;
begin
  GetMem(Result, Length);
end;

class function TDBXPlatform.GetStringBuilderLength(
  const Value: TDBXAnsiStringBuilder): TInt32;
begin
  Result := Length(Value);
end;

class procedure TDBXPlatform.ResizeStringBuilder(var Value: TDBXAnsiStringBuilder;
  Size: Integer);
begin
  if Value <> nil then
    FreeAndNilStringBuilder(Value);
  GetMem(Value, Size);
end;

class procedure TDBXPlatform.FreeAndNilStringBuilder(
  var Value: TDBXAnsiStringBuilder);
begin
  if Value <> nil then
    FreeMem(Value);
  Value := nil;
end;

class function TDBXPlatform.CreateWideStringBuilder(
  Length: TInt32): TDBXWideStringBuilder;
begin
  GetMem(Result, Length*2);
end;

class function TDBXPlatform.ToWideString(const Value: TDBXWideStringBuilder): string;
begin
  Result := Value;
end;

class function TDBXPlatform.GetWideStringBuilderLength(
  const Value: TDBXWideStringBuilder): TInt32;
begin
  Result := Length(Value);
end;

class procedure TDBXPlatform.CopyWideStringBuilder(const Value: TDBXWideStringBuilder; var Dest: string);
begin
  Dest := string(Value);//Copy(Value, 0, WStrLen(TDBXWideStringVar(Value)));
end;

class procedure TDBXPlatform.ResizeWideStringBuilder(
  var Value: TDBXWideStringBuilder; Size: Integer);
begin
  if Value <> nil then
    FreeAndNilWideStringBuilder(Value);
  GetMem(Value, Size*2);
end;

class procedure TDBXPlatform.FreeAndNilWideStringBuilder(
  var Value: TDBXWideStringBuilder);
begin
  if Value <> nil then
    FreeMem(Value);
  Value := nil;
end;

class procedure TDBXPlatform.CopyWideStringToBuilder(const Source: string;
  WideStringBuilderSize: Integer; var Value: TDBXWideStringBuilder);
begin
  // need room for null terminator.
  if Source.Length >= WideStringBuilderSize then
    UnexpectedStringOverflow(Source, WideStringBuilderSize);
  Move(TDBXWideStringBuilder(Source)^, Value^, (Source.Length+1)*2);
end;

class procedure TDBXPlatform.CopyInt32Array(const Source: TDBXInt32s;
  SourceOffset: Integer; const Dest: TDBXInt32s; DestOffset, Count: Integer);
begin
  Assert(Length(Dest) >= (Count+DestOffset));
  Move(Source[SourceOffset], Dest[DestOffset], Count*4);
end;

class procedure TDBXPlatform.CopyByteArray(const Source: TArray<Byte>;
  SourceOffset: Integer; const Dest: TArray<Byte>; DestOffset, Count: Integer);
begin
  Assert(Length(Dest) >= (Count+DestOffset));
  if Count > 0 then
    Move(Source[SourceOffset], Dest[DestOffset], Count);
end;

class procedure TDBXPlatform.CopyBytesToAnsiChars(const Source: TArray<Byte>;
  SourceOffset: Integer; const Dest: TDBXAnsiChars; DestOffset, Count: Integer);
begin
  Move(Source[SourceOffset], Dest[DestOffset], Count);
end;

class procedure TDBXPlatform.CopyBytesToWideChars(const Source: TArray<Byte>;
  SourceOffset: Integer; const Dest: TDBXWideChars; DestOffset, Count: Integer);
begin
  Assert(Length(Dest) >= (((Count+1) div SizeOf(Char))+DestOffset));
  Move(Source[SourceOffset], Dest[DestOffset], Count);
end;

class procedure TDBXPlatform.CopyCharArray(
  const Source: TDBXWideChars; SourceOffset: Integer; const Dest: TDBXWideChars; DestOffset: Integer; Count: Integer);
begin
  Assert(Length(Dest) >= (Count+DestOffset));
  Move(Source[SourceOffset], Dest[DestOffset], Count*SizeOf(Char));
end;

class function TDBXPlatform.CreateWideString(const Source: TDBXWideChars;
  Count: Integer): string;
begin
  if Count > 0 then
    SetString(Result, PChar(Source), Count);
end;

class procedure TDBXPlatform.UnexpectedStringOverflow(
  const Source: string; WideStringBuilderSize: Integer);
begin
  raise Exception.Create(System.SysUtils.Format(SUnexpectedStringOverflow,[source, IntToStr(WideStringBuilderSize)]));
end;

class function TDBXPlatform.Int64BitsToDouble(const Value: Int64): Double;
begin
  Move(Value, Result, 8);
end;

class function TDBXPlatform.DoubleToInt64Bits(const Value: Double): Int64;
begin
  Move(Value, Result, 8);
end;
class function TDBXPlatform.Int32BitsToSingle(const Value: TInt32): Single;
begin
  Move(Value, Result, 4);
end;

class function TDBXPlatform.SingleToInt32Bits(const Value: Single): TInt32;
begin
  Move(Value, Result, 4);
end;

class function TDBXPlatform.WideStrToBytes(const Value: string): TArray<Byte>;
var
  Count: Integer;
begin
  Count := Value.Length * 2;
  SetLength(Result, Count);
  if Count > 0 then
    Move(Value[Low(Value)], Result[0], Count);
end;

//Assumes UTF-16 data
class function TDBXPlatform.BytesToWideStr(const Value: TArray<Byte>): string;
begin
  Result := TMarshal.ReadStringAsUnicode(TPtrWrapper.Create(Value), (Length(Value)+1) div SizeOf(Char)).TrimRight;
end;

class function TDBXPlatform.IsBoolean(const value: string): Boolean;
begin
  Result := (
              (AnsiIndexText(value,TrueBoolStrs) > -1) or
              (AnsiIndexText(value,FalseBoolStrs) > -1) or
              (AnsiCompareText(value,'true') = 0) or
              (AnsiCompareText(value,'false') = 0) );
end;

class function TDBXPlatform.JsonFloat(Value: Double): string;
var
  FormatSettings: TFormatSettings;
begin
  FormatSettings.DecimalSeparator := '.';
  Result := FloatToStr(Value, FormatSettings);
end;

class function TDBXPlatform.JsonToFloat(DotValue: string): double;
var
  FormatSettings: TFormatSettings;
begin
  FormatSettings.DecimalSeparator := '.';
  Result := StrToFloat(DotValue, FormatSettings);
end;

class function TDBXPlatform.TryJsonToFloat(DotValue: string; var Value: Double): Boolean;
var
  FormatSettings: TFormatSettings;
begin
  FormatSettings.DecimalSeparator := '.';
  Result := TryStrToFloat(DotValue, Value, FormatSettings);
end;

class procedure TDBXPlatform.WriteAsciiBytes(const Message: string;
  ByteBuffer: TArray<Byte>; Offset, Count: Integer);
var
  Index: Integer;
  curChar: char;
begin
  Write(Message+' offset: '+IntToStr(Offset)+' count: '+IntToStr(Count));
  for Index := offset to Count - 1 do
  begin
    curChar := char(ByteBuffer[Index]);
    if (curChar < ' ') or (curChar > '~') then
    begin
      Write('#');
      Write(IntToStr(Integer(curChar)));
    end else
    begin
      Write(curChar);
    end;
  end;
  Writeln;
end;

class procedure TDBXPlatform.Sleep(const Duration: Int64);
begin
  System.SysUtils.Sleep(LongWord(Duration));
end;

class function TDBXPlatform.StringOf(Data: TArray<Byte>;
  const Size: Integer): string;
begin
  SetLength(Data, Size);
  Result := System.SysUtils.StringOf(Data);
end;

class function TDBXPlatform.GetClassName(ObjectValue: TObject): string;
begin
  Result := ObjectValue.ClassName;
end;
class function TDBXPlatform.GetNestedException(Ex: Exception): Exception;
begin
  Result := Ex.InnerException;
end;

class function TDBXPlatform.GetPublicKeyToken: string;
begin
{$IFDEF DEVELOPERS}
  Result := 'a91a7c5705831a4f';
{$ELSE}
  Result := '91d62ebb5b0d1b1b';
{$ENDIF}
end;

{$IFNDEF NEXTGEN}
class procedure TDBXPlatform.CopyStringBuilder(const Value: TDBXAnsiStringBuilder; var Dest: AnsiString);
begin
  Dest := Value; //Copy(Value, 0, StrLen(TDBXAnsiStringVar(Value)));
end;

class procedure TDBXPlatform.CopyStringToBuilder(const Source: AnsiString;
  AnsiStringBuilderSize: Integer; var Value: TDBXAnsiStringBuilder);
begin
  // need room for null terminator.
  if Length(Source) >= AnsiStringBuilderSize then
    UnexpectedStringOverflow(Source, AnsiStringBuilderSize);
  Move(TDBXAnsiStringBuilder(Source)^, Value^, (Length(Source)+1));
end;

class function TDBXPlatform.CreateAnsiString(const Source: TDBXAnsiChars;
  Count: Integer): AnsiString;
begin
  if Count > 0 then
    SetString(Result, PAnsiChar(Source), Count);
end;

class procedure TDBXPlatform.UnexpectedStringOverflow(
  const Source: AnsiString; AnsiStringBuilderSize: Integer);
begin
  raise Exception.Create(System.SysUtils.Format(SUnexpectedStringOverflow,[source, IntToStr(AnsiStringBuilderSize)]));
end;

class function TDBXPlatform.AnsiStrToBytes(const Value: AnsiString): TArray<Byte>;
var
  Count: Integer;
begin
  Count := Length(Value);
  SetLength(Result, Count);
  if Count > 0 then
    Move(Value[Low(Value)], Result[0], Count);
end;

class function TDBXPlatform.BytesToAnsiStr(const Value: TArray<Byte>): AnsiString;
begin
  SetString(Result, PAnsiChar(Value), Length(Value));
end;
{$ENDIF !NEXTGEN}

{ TDBXSemaphore }

constructor TDBXSemaphore.Create(Count: Integer);
begin
  FCount := Count;
  inherited Create(nil, Count, Count, '');
end;

function TDBXSemaphore.Acquire(Timeout: Int64): Boolean;
{$IFNDEF POSIX}
var
  WaitResult: Integer;
{$ENDIF}
begin
{$IFNDEF POSIX}
  WaitResult := WaitForSingleObject(FHandle, TimeOut);
  if WaitResult <> WAIT_OBJECT_0 then
{$ELSE}
  if WaitFor(TimeOut) <> wrSignaled then
{$ENDIF}
    Result := false
  else
    Result := true;
end;

{ TBaseTransportFilterItem }

constructor TBaseTransportFilterItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

procedure TBaseTransportFilterItem.NotifyChange;
begin
  if Assigned(FEvent) then
    FEvent(self);
end;

procedure TBaseTransportFilterItem.OnChangeNotify(filter: TBaseTransportFilterCollection);
begin
  OnChange := filter.OnChange;
end;

{TBaseTransportFactoryTools}

class function TBaseTransportFactoryTools.InvokeStringFunction(objClass: TObjectClass; methodName: string): string;
var
  Instance: TObject;
  LMethod: TRttiMethod;
  LResult: TValue;
  LContext: TRttiContext;
begin
  Instance := objClass.Create;
  try
    LMethod := LContext.GetType(objClass).GetMethod(methodName);
    LResult := LMethod.Invoke(Instance, []);
    Result := LResult.AsString;
  finally
    Instance.Free;
  end;
end;

{ TFactoryObject }

constructor TFactoryObject.Create;
begin
  inherited Create;
end;

{ TBaseTransportFilterCollection }

destructor TBaseTransportFilterCollection.Destroy;
begin
  NotifyChange;
  inherited;
end;

function TBaseTransportFilterCollection.GetItem(
  Index: Integer): TCollectionItem;
begin
  Result := inherited GetItem(Index);
end;

procedure TBaseTransportFilterCollection.NotifyChange;
begin
  if Assigned(FEvent) then
    FEvent(self);
end;

{ TBaseFilterProperties }

procedure TBaseFilterProperties.Add(const Name, Value: string);
begin
  inherited Add(Name+NameValueSeparator+Value);
end;

function TBaseFilterProperties.GetName(Index: Integer): string;
begin
  Result := Names[Index];
end;

function TBaseFilterProperties.GetValue(Index: Integer): string;
begin
  Result := ValueFromIndex[Index];
end;

{ TDSInvocationMetadata }

constructor TDSInvocationMetadata.Create;
begin
  inherited;
  FQueryParams := TStringList.Create;
end;

destructor TDSInvocationMetadata.Destroy;
begin
  FreeAndNil(FQueryParams);
  inherited;
end;

end.
