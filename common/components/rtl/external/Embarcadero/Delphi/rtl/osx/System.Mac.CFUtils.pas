{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Mac.CFUtils;

// This unit provides helper records for dealing with Core Foundation's
// CFPropertyList types, including CFArray, CFBoolean, CFDate, CFData,
// CFDictionary, CFNumber, and CFString.
// Primarily, these helpers are intended to help reading .plist files,
// and to assist in converting between basic Delphi types and their
// equivalent Core Foundation types and vice versa.

// NOTE: Using these helpers requires familiarity with Core Foundation's
// memory management routines. These helpers aim to reduce the necessity of
// CFRetain and CFRelease calls by the user, it may still be necessary to call
// them directly.
// Constructors and Class Create functions follow Core Foundation's
// Create Rule.
// Operators from Delphi types requiring Explicit casts call Core Foundation
// Create routines and should be treated as though they follow the Create Rule
// as well.
// Accessors follow the Get Rule unless otherwise noted.
// Accessor functions that have a Release parameter call CFRelease on exit
// if Release = True.

// Each of these helper records is a thin wrapper around a
// reference to a CFType. Each record has only one field, Value, which is the
// CoreFoundation reference. They also have several helper methods and
// type casting operators.


interface

uses
  Macapi.CoreFoundation,
  System.RTLConsts,
  System.SysUtils,
  System.Classes,
  System.RTTI,
  System.TypInfo,
  System.Generics.Collections;

type

  ECFPropertyListException = class(Exception);

  TCFArray = record
    Value: CFArrayRef;

  private
    function DoAsArray<T>(Release: Boolean): TArray<T>; overload;
  public
                                                                                                                    
    // Constructors: Create CFArray from Delphi arrays
    /// Create an array with a Delphi array of CFPropertyListRefs. Useful
    /// for creating arrays of arrays, or arrays of dictionaries.
    constructor Create(const AValue: TArray<CFPropertyListRef>); overload;
    /// Create a CFArray from an array of type T.
    /// T may be Boolean, TBytes, TDateTime, a string type, or a numeric type.
    /// other types will raise an exception
    class function Create<T>(const AValue: TArray<T>): TCFArray; overload; static;

                                                                            
    // Accessor functions: Convert CFArray to Delphi array
    function AsArray(Release: Boolean = False): TArray<CFPropertyListRef>; overload; inline;
    function AsArray<T>(Release: Boolean = False): TArray<T>; overload;
    function TryAsArray(out AResult: TArray<CFPropertyListRef>; Release: Boolean = False): Boolean; overload; inline;
    function TryAsArray<T>(out AResult: TArray<T>; Release: Boolean = False): Boolean; overload;

    /// Determine if all elements of array are the same type. If so, return TypeInfo. Otherwise, nil.
    function GetTypeInfo: PTypeInfo;
    /// Determine if all elements of array are type T.
    function IsArrayOf<T>: Boolean;

    /// Length of the array.
    function Count: CFIndex;
    /// Count of occurrences in of Val in the array.
    function CountOfValue(Val: CFPropertyListRef): CFIndex;

                                                              
    class operator Implicit(AValue: CFArrayRef): TCFArray;
  end;

  TCFBoolean = record
    Value: CFBooleanRef;

  private
    function DoAsBoolean: Boolean;
  public
    //NOTE: TCFBoolean has no Create rountes. Core Foundation
    // simply uses references to two constants
    // kCFBooleanTrue and kCFBooleanFalse, thus Retain/Release needn't
    // be called

    // CFBoolean to Boolean
    function AsBoolean: Boolean;
    function TryAsBoolean(out AResult: Boolean): Boolean;

    // Boolean to CFBoolean
    class operator Implicit(AValue: Boolean): TCFBoolean;
    // CFBoolean to Boolean
    class operator Implicit(AValue: TCFBoolean): Boolean;

    class operator Implicit(AValue: CFBooleanRef): TCFBoolean;
  end;

  TCFData = record
    Value: CFDataRef;

  private
    function DoAsArray<T>(Release: Boolean): TArray<T>; overload;
    function DoAsType<T>(Release: Boolean): T; overload;
  public
    // Convert Delphi TBytes to CFData
    constructor Create(const AValue: TBytes);
    // Serialize an array of T into byte sequence as CFData
    class function CreateFromArray<T>(const AValue: TArray<T>): TCFData; static;
    // Serialize a single object T into a byte sequence as CFData
    class function CreateFromType<T>(const AValue: T): TCFData; static;

    function AsTBytes(Release: Boolean = False): TBytes;
    // Convert CFData to an array of objects of type T
    function AsArray<T>(Release: Boolean = False): TArray<T>; overload;
    function TryAsArray<T>(out AResult: TArray<T>; Release: Boolean = False): Boolean; overload;

    // Convert CFData to single object of type T
    function AsType<T>(Release: Boolean = False): T; overload;
    function TryAsType<T>(out AResult: T; Release: Boolean = False): Boolean; overload;

    // NOTE: Explicit operator follows Create Rule.
    class operator Explicit(const AValue: TBytes): TCFData;
    class operator Implicit(const AValue: TCFData): TBytes;

    class operator Implicit(AValue: CFDataRef): TCFData;
  end;

  TCFDate = record
    Value: CFDateRef;

  private
    function DoAsTDateTime(Release: Boolean; UTC: Boolean): TDateTime;
  public
    // Create CFDate from TDateTime in current locale timezone, or UTC
    constructor Create(AValue: TDateTime; UTC: Boolean = False); overload;

    // Convert to TDateTime in current locale timezone
    function AsTDateTime(Release: Boolean = False): TDateTime;
    function TryAsTDateTime(out AResult: TDateTime; Release: Boolean = False): Boolean;
    // Convert to TDateTime in UTC timezone
    function AsTDateTimeUTC(Release: Boolean = False): TDateTime;
    function TryAsTDateTimeUTC(out AResult: TDateTime; Release: Boolean = False): Boolean;

    // NOTE: Explicit operator follows Create Rule.
    class operator Explicit(AValue: TDateTime): TCFDate;
    class operator Implicit(AValue: TCFDate): TDateTime;

    class operator Implicit(AValue: CFDateRef): TCFDate;
  end;

  TCFDictionary = record
    Value: CFDictionaryRef;

  private type
    TCFKeyValueEnumerator = class
    private
      FIndex: Integer;
      FKeys: array of string;
      FValues: array of CFPropertyListRef;
    public
      constructor Create(DictRef: CFDictionaryRef);
      function GetCurrent: TPair<string, CFPropertyListRef>; inline;
      function MoveNext: Boolean;
      property Current: TPair<string, CFPropertyListRef> read GetCurrent;
    end;

  private
    function DoGetKeys: TArray<string>;
    function DoGetValues: TArray<CFPropertyListRef>;

  public
    // Get a value from the dictionary. NOTE: CFDictionary supports keys of
    // any pointer sized type, but for streaming purposes, it must be a string
    function GetValue(const Key: string): CFPropertyListRef;
    // Allow setting a key-value pair, if the dictionary is a CFMutableDictionary.
    // Note: if Value = nil, the Key is removed from the dictionary.
    procedure SetValue(const Key: string; Value: CFPropertyListRef);
    // Get all the keys as a string array
    function GetKeys: TArray<string>;
    function TryGetKeys(out AResult: TArray<string>): Boolean;
    // Get all the values as an array. NOTE: CFDictionary may also contain
    // values that are any Pointer sized type, but for streaming purposes
    // it must be a CFPropertyList type.
    function GetValues: TArray<CFPropertyListRef>;
    function TryGetValues(out AResult: TArray<CFPropertyListRef>): Boolean;
    // Enumerate over all keys and values as a TPair<string, CFPropertyListRef>
    function GetEnumerator: TCFKeyValueEnumerator;

    // determine if a key is in the dictionary
    function ContainsKey(const Key: string): Boolean;
    // determine if a value is in the dictionary
    function ContainsValue(Val: CFPropertyListRef): Boolean;

    // The length of the dictionary
    function Count: CFIndex;
    // Gets the number of times a value is repeated in the dictionary
    function CountOfValue(Val: CFPropertyListRef): CFIndex;

    // allows accessing values with Dictionary[Key]
    property Items[const Key: string] : CFPropertyListRef read GetValue write SetValue; default;
    property Keys: TArray<string> read GetKeys;
    property Values: TArray<CFPropertyListRef> read GetValues;

    class operator Implicit(AValue: CFDictionaryRef): TCFDictionary;
  end;

  TCFNumber = record
    Value: CFNumberRef;

  private
    procedure DoAsType(ATypeInfo: PTypeInfo; ABuffer: Pointer; Release: Boolean);
  public
    // Conversion from Delphi Type to CoreFoundation type
    class function CreateFromType<T>(AValue: T): TCFNumber; static;
    // Gets the TypeInfo for the best Dephi type for this value
    // possible values: ShortInt, SmallInt, Integer, Int64,
    //   Single, Double, CFIndex, NativeInt
    function GetTypeInfo: PTypeInfo;
    // Conversion from CoreFoundation type to Delphi type
    function AsType<T>(Release: Boolean = False): T; overload;
    function TryAsType<T>(out AResult: T; Release: Boolean = False): Boolean; overload;
    // Returns the value without having to know what type is apropriate
    function AsTValue(Release: Boolean = False): TValue; overload;
    function TryAsTValue(out AResult: TValue; Release: Boolean = False): Boolean; overload;

    class operator Implicit(AValue: CFNumberRef): TCFNumber;
  end;

  TCFString = record
    Value: CFStringRef;

  private
    function DoAsChar(Release: Boolean = False): Char;
    function DoAsString(Release: Boolean): string;
  public
    // Conversion from Delphi string to CoreFoundation CFString
    constructor Create(const AValue: string);
    // Conversion from CoreFoundation string to Delphi types
    function AsChar(Release: Boolean = False): Char;
    function AsString(Release: Boolean = False): string;
    function TryAsChar(out AResult: Char; Release: Boolean = False): Boolean;
    function TryAsString(out AResult: string; Release: Boolean = False): Boolean;

    // NOTE: Explicit operator follows Create Rule.
    class operator Explicit(const AValue: string): TCFString;
    class operator Implicit(AValue: TCFString): string;

    class operator Implicit(AValue: CFStringRef): TCFString;
  end;

  TCFPropertyListKind = (vkUnknown, vkArray, vkBoolean, vkData, vkDate,
    vkDictionary, vkNumber, vkString);

  // TCFPropertyList aids in converting reading and writing Property Lists
  // from files and streams. It also does type checking when casting a
  // CFPropertyList to the other CFTypes (such as CFString or CFNumber).
  TCFPropertyList = record
    Value: CFPropertyListRef;

  strict private
    class var FTypeIDs: array[TCFPropertyListKind] of CFTypeID;
    class constructor Create;
  public
    // Load from a .plist file
    constructor CreateFromFile(const FileName: string;
      Mutable: CFPropertyListMutabilityOptions = kCFPropertyListImmutable;
      Format: PCFPropertyListFormat = nil);
    // Load a plist from a stream
    constructor CreateFromStream(AStream: TStream;
      Mutable: CFPropertyListMutabilityOptions = kCFPropertyListImmutable;
      Format: PCFPropertyListFormat = nil);
    // Save to a .plist file
    procedure SaveToFile(const FileName: string; Format: CFPropertyListFormat = kCFPropertyListXMLFormat_v1_0);
    // Save a plist to a stream
    procedure SaveToStream(AStream: TStream;  Format: CFPropertyListFormat = kCFPropertyListXMLFormat_v1_0);
    // Get the CFTypeID of this PropertyList
    function TypeID: CFTypeID;
    // Get the Type as a delphi enumeration for use in case statements. CFTypeIDs
    // shouldn't be used directly as they may change from release to release of
    // the CoreFoundation framework.
    function PropertyListKind: TCFPropertyListKind;

    // Create a PropertyList from a delphi type. This Creates a
    // CFBoolean, CFDate, CFData, CFString, or CFNumber depending on
    // the type of T.
    class function Create<T>(AValue: T): TCFPropertyList; static;
    // Conversion from PropertyList to TValue. Uses CFTypeID to
    // determine which helper above to do the actual convesion
    function AsTValue: TValue;

    // Explict casts from CFPropertyList to other types.
    // These casts do type checking, and raise an
    // ECFPropertyListException if the requested type doesn't match.
    class operator Explicit(PList: TCFPropertyList): TCFArray;
    class operator Explicit(PList: TCFPropertyList): TCFBoolean;
    class operator Explicit(PList: TCFPropertyList): TCFData;
    class operator Explicit(PList: TCFPropertyList): TCFDate;
    class operator Explicit(PList: TCFPropertyList): TCFDictionary;
    class operator Explicit(PList: TCFPropertyList): TCFNumber;
    class operator Explicit(PList: TCFPropertyList): TCFString;

    // Conversion from a CFType back to a CFPropertyList.
    // Useful to allow SaveToFile or SaveToStream after doing some
    // processing.
    class operator Explicit(PList: TCFArray): TCFPropertyList;
    class operator Explicit(PList: TCFBoolean): TCFPropertyList;
    class operator Explicit(PList: TCFData): TCFPropertyList;
    class operator Explicit(PList: TCFDate): TCFPropertyList;
    class operator Explicit(PList: TCFDictionary): TCFPropertyList;
    class operator Explicit(PList: TCFNumber): TCFPropertyList;
    class operator Explicit(PList: TCFString): TCFPropertyList;

    class operator Implicit(AValue: CFPropertyListRef): TCFPropertyList;
  end;

  CFGregorianDateHelper = record helper for CFGregorianDate
  public
    class function Create(AValue: TDateTime): CFGregorianDate; static;
    function ToDateTime: TDateTime;
  end;

implementation

uses
  System.DateUtils;

{ TCFArray }

function TCFArray.DoAsArray<T>(Release: Boolean): TArray<T>;
var
  Info: PTypeInfo;
  LItems: TArray<CFPropertyListRef>;
  I: Integer;
begin
  Info := TypeInfo(T);
  SetLength(Result, Count);

  if Info.Kind = tkPointer then // assume CFPropertyListRef type
    CFArrayGetValues(Value, CFRangeMake(0, Count), @Result[0])
  else
  begin
    SetLength(LItems, Count);
    CFArrayGetValues(Value, CFRangeMake(0, Count), @LItems[0]);
    for I := 0 to Count - 1 do
    case TCFPropertyList(LItems[I]).PropertyListKind of
      vkBoolean:
        if Info = TypeInfo(Boolean) then
          PBoolean(@Result[I])^ := TCFBoolean(LItems[I]).AsBoolean
        else
          raise ECFPropertyListException.CreateResFmt(@sInvalidConversion, ['CFBoolean', string(Info.NameFld.ToString)]); //DO NOT TRANSLATE
      vkData:
        if Info = TypeInfo(TBytes) then
          Result[I] := TCFData(LItems[I]).AsType<T>
        else
          raise ECFPropertyListException.CreateResFmt(@sInvalidConversion, ['CFData', string(Info.NameFld.ToString)]); //DO NOT TRANSLATE
      vkDate:
        if Info = TypeInfo(TDateTime) then
          PDateTime(@Result[I])^ := TCFDate(LItems[I]).AsTDateTime
        else
          raise ECFPropertyListException.CreateResFmt(@sInvalidConversion, ['CFDate', string(Info.NameFld.ToString)]); //DO NOT TRANSLATE
      vkNumber:
        if Info = TCFNumber(LItems[I]).GetTypeInfo then
          Result[I] := TCFNumber(LItems[I]).AsType<T>
        else
          raise ECFPropertyListException.CreateResFmt(@sInvalidConversion, ['CFNumber', string(Info.NameFld.ToString)]); //DO NOT TRANSLATE //TODO: more specific exception message
      vkString:
        if Info = TypeInfo(string) then
          PString(@Result[I])^ := TCFString(LItems[I]).AsString
        else
          raise ECFPropertyListException.CreateResFmt(@sInvalidConversion, ['CFString', string(Info.NameFld.ToString)]); //DO NOT TRANSLATE
      else
        raise ECFPropertyListException.CreateRes(@sInvalidPListType);
    end;
  end;

  if Release then
    CFRelease(Value);
end;

constructor TCFArray.Create(const AValue: TArray<CFPropertyListRef>);
begin
  Self := TCFArray.Create<CFPropertyListRef>(AValue);
end;

class function TCFArray.Create<T>(const AValue: TArray<T>): TCFArray;
var
  Info: PTypeInfo;
  LArray: TArray<CFPropertyListRef>;
  I: Integer;
  LItem: TValue;
  callback: CFArrayCallBacks;
begin
  Info := TypeInfo(T);
  callback := kCFTypeArrayCallBacks;
  if Info.Kind = tkPointer then // Assume TCFPropertyListRefs
  begin
                                                            
    Result.Value := CFArrayCreate(kCFAllocatorDefault, @AValue[Low(AValue)],
      Length(AValue), @callback);
    Exit;
  end;
  SetLength(LArray, Length(AValue));
  try
    for I := Low(AValue) to High(AValue) do
      LArray[I - Low(AValue)] := TCFPropertyList.Create<T>(AValue[I]).Value;
    Result.Value := CFArrayCreate(kCFAllocatorDefault, @LArray[0], Length(LArray), @callback);
  except
    for I := 0 to Length(LArray) - 1 do
      if LArray[I] <> nil then
        CFRelease(LArray[I]);
    raise;
  end;
end;

function TCFArray.AsArray(Release: Boolean): TArray<CFPropertyListRef>;
begin
  Result := DoAsArray<CFPropertyListRef>(Release);
end;

function TCFArray.AsArray<T>(Release: Boolean): TArray<T>;
begin
  Result := DoAsArray<T>(Release);
end;

function TCFArray.TryAsArray(out AResult: TArray<CFPropertyListRef>;
  Release: Boolean): Boolean;
begin
  Result := True;
  try
    AResult := DoAsArray<CFPropertyListRef>(Release);
  except
    Result := False;
  end;
end;

function TCFArray.TryAsArray<T>(out AResult: TArray<T>;
  Release: Boolean): Boolean;
begin
  Result := True;
  try
    AResult := DoAsArray<T>(Release);
  except
    Result := False;
  end;
end;

function TCFArray.GetTypeInfo: PTypeInfo;
var
  LValues: TArray<CFPropertyListRef>;
  I: Integer;
begin
  Result := nil;
  SetLength(LValues, Count);
  CFArrayGetValues(Value, CFRangeMake(0, Count), @LValues[0]);
  for I := 0 to Length(LValues) -1 do
  begin
    case TCFPropertyList(LValues[I]).PropertyListKind of
      vkUnknown: raise ECFPropertyListException.CreateRes(@sInvalidPListType);
      vkArray: raise ECFPropertyListException.CreateRes(@sConvertArrayArray);
      vkDictionary: raise ECFPropertyListException.CreateRes(@sConvertArrayDictionary);
      vkBoolean:
        if Result = nil then
          Result := TypeInfo(Boolean)
        else if Result <> TypeInfo(Boolean) then
          Exit(nil); // Types don't match
      vkData:
        if Result = nil then
          Result := TypeInfo(TBytes)
        else if Result <> TypeInfo(TBytes) then
          Exit(nil); // Types don't match
      vkDate:
        if Result = nil then
          Result := TypeInfo(TDateTime)
        else if Result <> TypeInfo(TDateTime) then
          Exit(nil); // Types don't match
      vkNumber:
        if Result = nil then
          Result := TCFNumber(LValues[I]).GetTypeInfo
        else if Result <> TCFNumber(LValues[I]).GetTypeInfo then
          Exit(nil); // Types don't match
      vkString:
        if Result = nil then
          Result := TypeInfo(string)
        else if Result <> TypeInfo(string) then
          Exit(nil); // Types don't match
    end;

  end;
end;

function TCFArray.IsArrayOf<T>: Boolean;
begin
  Result := GetTypeInfo = TypeInfo(T);
end;

function TCFArray.Count: CFIndex;
begin
  Result := CFArrayGetCount(Value);
end;

function TCFArray.CountOfValue(Val: CFPropertyListRef): CFIndex;
begin
  Result := CFArrayGetCountOfValue(Value, CFRangeMake(0, Count), Val);
end;

class operator TCFArray.Implicit(AValue: CFArrayRef): TCFArray;
begin
  Result.Value := AValue;
end;

{ TCFBoolean }

function TCFBoolean.DoAsBoolean: Boolean;
begin
  Result := CFBooleanGetValue(Value)
end;

function TCFBoolean.AsBoolean: Boolean;
begin
  Result := DoAsBoolean;
end;

function TCFBoolean.TryAsBoolean(out AResult: Boolean): Boolean;
begin
  Result := True;
  try
    AResult := DoAsBoolean;
  except
    Result := False;
  end;
end;

class operator TCFBoolean.Implicit(AValue: Boolean): TCFBoolean;
begin
  if AValue then
    Result.Value := kCFBooleanTrue
  else
    Result.Value := kCFBooleanFalse;
end;

class operator TCFBoolean.Implicit(AValue: TCFBoolean): Boolean;
begin
  Result := AValue.DoAsBoolean;
end;

class operator TCFBoolean.Implicit(AValue: CFBooleanRef): TCFBoolean;
begin
  Result.Value := AValue;
end;

{ TCFData }

function TCFData.DoAsArray<T>(Release: Boolean): TArray<T>;
var
  Len: CFIndex;
begin
  try
    Len := CFDataGetLength(Value);
    SetLength(Result, Len div SizeOf(T));
    CFDataGetBytes(Value, CFRangeMake(0, Len), @Result[0]);
  finally
    if Release then
      CFRelease(Value);
  end;
end;

function TCFData.DoAsType<T>(Release: Boolean): T;
var
  Len: CFIndex;
begin
  try
    Len := CFDataGetLength(Value);
                                           
    CFDataGetBytes(Value, CFRangeMake(0, Len), @Result);
  finally
    if Release then
      CFRelease(Value);
  end;
end;

constructor TCFData.Create(const AValue: TBytes);
begin
  Value := CFDataCreate(kCFAllocatorDefault, @AValue[Low(AValue)],
    Length(AValue) * SizeOf(Byte) );
end;

class function TCFData.CreateFromArray<T>(const AValue: TArray<T>): TCFData;
begin
  Result.Value := CFDataCreate(kCFAllocatorDefault, @AValue[Low(AValue)],
    Length(AValue) * SizeOf(T) );
end;

class function TCFData.CreateFromType<T>(const AValue: T): TCFData;
begin
  Result.Value := CFDataCreate(kCFAllocatorDefault, @AValue, SizeOf(T));
end;

function TCFData.AsArray<T>(Release: Boolean): TArray<T>;
begin
  Result := DoAsArray<T>(Release);
end;

function TCFData.TryAsArray<T>(out AResult: TArray<T>;
  Release: Boolean): Boolean;
begin
  Result := True;
  try
    AResult := DoAsArray<T>(Release);
  except
    Result := False;
  end;
end;

function TCFData.AsTBytes(Release: Boolean): TBytes;
begin
  Result := DoAsArray<Byte>(Release);
end;

function TCFData.AsType<T>(Release: Boolean): T;
begin
  Result := DoAsType<T>(Release);
end;

function TCFData.TryAsType<T>(out AResult: T; Release: Boolean): Boolean;
begin
  Result := True;
  try
    AResult := DoAsType<T>(Release);
  except
    Result := False;
  end;
end;

class operator TCFData.Explicit(const AValue: TBytes): TCFData;
begin
  Result := TCFData.CreateFromArray<Byte>(AValue);
end;

class operator TCFData.Implicit(const AValue: TCFData): TBytes;
begin
  Result := AValue.AsArray<Byte>;
end;

class operator TCFData.Implicit(AValue: CFDataRef): TCFData;
begin
  Result.Value := AValue;
end;

{ TCFDate }

function TCFDate.DoAsTDateTime(Release, UTC: Boolean): TDateTime;
var
  LTimeZone: CFTimeZoneRef;
begin
  try
    if UTC then
      Result := CFAbsoluteTimeGetGregorianDate(CFDateGetAbsoluteTime(Value), nil).ToDateTime
    else
    begin
      LTimeZone := CFTimeZoneCopyDefault;
      try
        Result := CFAbsoluteTimeGetGregorianDate(CFDateGetAbsoluteTime(Value), LTimeZone).ToDateTime;
      finally
        CFRelease(LTimeZone);
      end;
    end;
  finally
    if Release then
      CFRelease(Value);
  end;
end;

constructor TCFDate.Create(AValue: TDateTime; UTC: Boolean);
var
  LTimeZone: CFTimeZoneRef;
begin
  if UTC then
    Value := CFDateCreate(kCFAllocatorDefault,
      CFGregorianDateGetAbsoluteTime(CFGregorianDate.Create(AValue), nil))
  else
  begin
    LTimeZone := CFTimeZoneCopyDefault;
    try
      Value := CFDateCreate(kCFAllocatorDefault,
        CFGregorianDateGetAbsoluteTime(CFGregorianDate.Create(AValue), LTimeZone));
    finally
      CFRelease(LTimeZone);
    end;
  end;
end;

function TCFDate.AsTDateTime(Release: Boolean): TDateTime;
begin
  Result := DoAsTDateTime(Release, False);
end;

function TCFDate.AsTDateTimeUTC(Release: Boolean): TDateTime;
begin
  Result := DoAsTDateTime(Release, True);
end;

function TCFDate.TryAsTDateTime(out AResult: TDateTime;
  Release: Boolean): Boolean;
begin
  Result := True;
  try
    AResult := DoAsTDateTime(Release, False);
  except
    Result := False;
  end;
end;

function TCFDate.TryAsTDateTimeUTC(out AResult: TDateTime;
  Release: Boolean): Boolean;
begin
  Result := True;
  try
    AResult := DoAsTDateTime(Release, True);
  except
    Result := False;
  end;
end;

class operator TCFDate.Explicit(AValue: TDateTime): TCFDate;
begin
  Result := TCFDate.Create(AValue);
end;

class operator TCFDate.Implicit(AValue: TCFDate): TDateTime;
begin
  Result := AValue.AsTDateTime;
end;

class operator TCFDate.Implicit(AValue: CFDateRef): TCFDate;
begin
  Result.Value := AValue;
end;

{ TCFDictionary.TCFKeyValueEnumerator }

constructor TCFDictionary.TCFKeyValueEnumerator.Create(
  DictRef: CFDictionaryRef);
var
  I: Integer;
  LCount: CFIndex;
  LKeys: TArray<CFStringRef>;
begin
  inherited Create;

  FIndex := -1;
  LCount := CFDictionaryGetCount(DictRef);
  if LCount <= 0 then Exit;

  SetLength(FKeys, LCount);
  SetLength(LKeys, LCount);
  SetLength(FValues, LCount);

  CFDictionaryGetKeysAndValues(DictRef, @LKeys[0], @FValues[0]);
  for I := 0 to LCount - 1 do
    FKeys[I] := TCFString(LKeys[I]).AsString;
end;

function TCFDictionary.TCFKeyValueEnumerator.GetCurrent: TPair<string, CFPropertyListRef>;
begin
  Result := TPair<string, CFPropertyListRef>.Create(FKeys[FIndex], FValues[FIndex]);
end;

function TCFDictionary.TCFKeyValueEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < Length(FKeys) - 1;
  if Result then
    Inc(FIndex);
end;

{ TCFDictionary }

function TCFDictionary.DoGetKeys: TArray<string>;
var
  I: Integer;
  LCount: CFIndex;
  LKeys: TArray<CFStringRef>;
begin
  LCount := CFDictionaryGetCount(Value);
  SetLength(Result, LCount);
  SetLength(LKeys, LCount);
  CFDictionaryGetKeysAndValues(Value, @LKeys[0], nil);
  for I := 0 to LCount -1 do
    Result[I] := TCFString(LKeys[I]).AsString;
end;

function TCFDictionary.DoGetValues: TArray<CFPropertyListRef>;
var
  LCount: CFIndex;
begin
  LCount := CFDictionaryGetCount(Value);
  SetLength(Result, LCount);
  CFDictionaryGetKeysAndValues(Value, nil, @Result[0]);
end;

function TCFDictionary.GetValue(const Key: string): CFPropertyListRef;
var
  LKey: TCFString;
begin
  LKey := TCFString.Create(Key);
  try
    if not CFDictionaryGetValueIfPresent(Value, LKey.Value, @Result) then
      raise ECFPropertyListException.CreateRes(@sKeyNotPresent);
  finally
    CFRelease(LKey.Value);
  end;
end;

procedure TCFDictionary.SetValue(const Key: string; Value: Pointer);
var
  LKey: TCFString;
begin
  LKey := TCFString.Create(Key);
  try
    if Value = nil then
      CFDictionaryRemoveValue(CFMutableDictionaryRef(Self.Value), LKey.Value)
    else
      CFDictionarySetValue(CFMutableDictionaryRef(Self.Value), LKey.Value, Value);
  finally
    if LKey.Value <> nil then
      CFRelease(LKey.Value);
  end;
end;

function TCFDictionary.GetKeys: TArray<string>;
begin
  Result := DoGetKeys;
end;

function TCFDictionary.GetValues: TArray<CFPropertyListRef>;
begin
  Result := DoGetValues;
end;

function TCFDictionary.TryGetKeys(out AResult: TArray<string>): Boolean;
begin
  Result := True;
  try
    AResult := DoGetKeys;
  except
    Result := False;
  end;
end;

function TCFDictionary.TryGetValues(
  out AResult: TArray<CFPropertyListRef>): Boolean;
begin
  Result := True;
  try
    AResult := DoGetValues;
  except
    Result := False;
  end;
end;

function TCFDictionary.GetEnumerator: TCFKeyValueEnumerator;
begin
  Result := TCFKeyValueEnumerator.Create(Value);
end;

function TCFDictionary.ContainsKey(const Key: string): Boolean;
var
  LKey: TCFString;
begin
  LKey := TCFString.Create(Key);
  try
    Result := CFDictionaryContainsKey(Value, LKey.Value);
  finally
    CFRelease(LKey.Value);
  end;
end;

function TCFDictionary.ContainsValue(Val: CFPropertyListRef): Boolean;
begin
  Result := CFDictionaryContainsValue(Value, Val);
end;

function TCFDictionary.Count: CFIndex;
begin
  Result := CFDictionaryGetCount(Value);
end;

function TCFDictionary.CountOfValue(Val: CFPropertyListRef): CFIndex;
begin
  Result := CFDictionaryGetCountOfValue(Value, Val);
end;

class operator TCFDictionary.Implicit(AValue: CFDictionaryRef): TCFDictionary;
begin
  Result.Value := AValue;
end;

{ TCFNumber }

procedure TCFNumber.DoAsType(ATypeInfo: PTypeInfo; ABuffer: Pointer;
  Release: Boolean);
var
  LResult: Boolean;
begin
  try
    LResult := False;
    case ATypeInfo.Kind of
      tkInt64: LResult := CFNumberGetValue(Value, kCFNumberLongLongType, ABuffer);
      tkInteger:
        case GetTypeData(ATypeInfo).OrdType of
          otSByte, otUByte: LResult := CFNumberGetValue(Value, kCFNumberSInt8Type, ABuffer);
          otSWord, otUWord: LResult := CFNumberGetValue(Value, kCFNumberSInt16Type, ABuffer);
          otSLong, otULong: LResult := CFNumberGetValue(Value, kCFNumberLongType, ABuffer);
        end;
      tkFloat:
        case GetTypeData(ATypeInfo).FloatType of
          ftSingle: LResult := CFNumberGetValue(Value, kCFNumberFloat32Type, ABuffer);
          ftDouble: LResult := CFNumberGetValue(Value, kCFNumberFloat64Type, ABuffer);
        else
          raise ECFPropertyListException.CreateResFmt(@sInvalidConversion, ['CFNumber', string(ATypeInfo.NameFld.ToString)]); //DO NOT TRANSLATE
        end;
    else
      raise ECFPropertyListException.CreateResFmt(@sInvalidConversion, ['CFNumber', string(ATypeInfo.NameFld.ToString)]); //DO NOT TRANSLATE
    end;
    if LResult = False then
      raise ECFPropertyListException.CreateResFmt(@sInvalidConversion, ['CFNumber', string(ATypeInfo.NameFld.ToString)]); //DO NOT TRANSLATE
  finally
    if Release then
      CFRelease(Value);
  end;
end;

class function TCFNumber.CreateFromType<T>(AValue: T): TCFNumber;
var
  LValue: T;
  Info: PTypeInfo;
begin
  LValue := AValue;
  Info := TypeInfo(T);
  case Info.Kind of
    tkInt64: Result.Value := CFNumberCreate(kCFAllocatorDefault, kCFNumberLongLongType, @LValue);
    tkInteger:
      case GetTypeData(Info).OrdType of
        otSByte, otUByte: Result.Value := CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, @LValue);
        otSWord, otUWord: Result.Value := CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt16Type, @LValue);
        otSLong, otULong: Result.Value := CFNumberCreate(kCFAllocatorDefault, kCFNumberLongType, @LValue);
      end;
    tkFloat:
      case GetTypeData(Info).FloatType of
        ftSingle: Result.Value := CFNumberCreate(kCFAllocatorDefault, kCFNumberFloat32Type, @LValue);
        ftDouble: Result.Value := CFNumberCreate(kCFAllocatorDefault, kCFNumberFloat64Type, @LValue);
      else
        raise ECFPropertyListException.CreateResFmt(@sInvalidConversion, [string(Info.NameFld.ToString), 'CFNumber']); //DO NOT TRANSLATE
      end;
  else
    raise ECFPropertyListException.CreateResFmt(@sInvalidConversion, [string(Info.NameFld.ToString), 'CFNumber']); //DO NOT TRANSLATE
  end;
end;

function TCFNumber.GetTypeInfo: PTypeInfo;
begin
  Result := nil;
  case CFNumberGetType(Value) of
    kCFNumberSInt8Type,
    kCFNumberCharType: Result := TypeInfo(ShortInt);
    kCFNumberSInt16Type,
    kCFNumberShortType: Result := TypeInfo(SmallInt);
    kCFNumberSInt32Type,
    kCFNumberIntType,
    kCFNumberLongType: Result := TypeInfo(Integer);
    kCFNumberSInt64Type,
    kCFNumberLongLongType: Result := TypeInfo(Int64);
    kCFNumberFloat32Type,
{$IFDEF CPUX86}
    kCFNumberCGFloatType,
{$ENDIF}
    kCFNumberFloatType: Result := TypeInfo(Single);
    kCFNumberFloat64Type,
{$IFDEF CPUX64}
    kCFNumberCGFloatType,
{$ENDIF}
    kCFNumberDoubleType: Result := TypeInfo(Double);
    kCFNumberCFIndexType: Result := TypeInfo(CFIndex);
    kCFNumberNSIntegerType: Result := TypeInfo(NativeInt);
  end;
end;

function TCFNumber.AsType<T>(Release: Boolean): T;
var
  Info: PTypeInfo;
begin
  Info := TypeInfo(T);
  case Info^.Kind of
  tkInteger, tkInt64, tkFloat:
    DoAsType(TypeInfo(T), @Result, Release)
  else
    raise ECFPropertyListException.CreateResFmt(@sInvalidConversion, ['CFNumber', string(Info^.NameFld.ToString)]); //DO NOT TRANSLATE
  end;
end;

function TCFNumber.AsTValue(Release: Boolean): TValue;
var
  LValue: Int64;
  Info: PTypeInfo;
begin
  Info := GetTypeInfo;
  DoAsType(Info, @LValue, Release);
  TValue.Make(@LValue, Info, Result);
end;

function TCFNumber.TryAsTValue(out AResult: TValue; Release: Boolean): Boolean;
var
  LValue: Int64;
  Info: PTypeInfo;
begin
  Info := nil;
  Result := True;
  try
    Info := GetTypeInfo;
    DoAsType(Info, @LValue, Release);
  except
    Result := False;
  end;
  if Result then
    TValue.Make(@LValue, Info, AResult);
end;

function TCFNumber.TryAsType<T>(out AResult: T; Release: Boolean): Boolean;
begin
  Result := True;
  try
    DoAsType(TypeInfo(T), @AResult, Release);
  except
    Result := False;
  end;
end;

class operator TCFNumber.Implicit(AValue: CFNumberRef): TCFNumber;
begin
  Result.Value := AValue;
end;

{ TCFString }

function TCFString.DoAsChar(Release: Boolean): Char;
begin
  try
    if CFStringGetLength(Value) > 0 then
      Result := CFStringGetCharacterAtIndex(Value, 0)
    else
      Result := #0;
  finally
    if Release then
      CFRelease(Value);
  end;
end;

function TCFString.DoAsString(Release: Boolean): string;
var
  Range: CFRange;
  Tmp: TCharArray;
begin
  try
    Range := CFRangeMake(0, CFStringGetLength(Value));
    if Range.Length > 0 then
    begin
      SetLength(Tmp, Range.Length);
      CFStringGetCharacters(Value, Range, MarshaledString(Tmp));
      Result := string.Create(Tmp);
    end
    else
      Result := EmptyStr;
  finally
    if Release then
      CFRelease(Value);
  end;
end;

constructor TCFString.Create(const AValue: string);
begin
  Value := CFStringCreateWithCharacters(kCFAllocatorDefault, PChar(AValue), Length(AValue));
end;

function TCFString.AsChar(Release: Boolean): Char;
begin
  Result := DoAsChar(Release);
end;

function TCFString.AsString(Release: Boolean): string;
begin
  Result := DoAsString(Release);
end;

function TCFString.TryAsChar(out AResult: Char; Release: Boolean): Boolean;
begin
  Result := True;
  try
    AResult := DoAsChar(Release);
  except
    Result := False;
  end;
end;

function TCFString.TryAsString(out AResult: string; Release: Boolean): Boolean;
begin
  Result := True;
  try
    AResult := DoAsString(Release);
  except
    Result := False;
  end;
end;

class operator TCFString.Explicit(const AValue: string): TCFString;
begin
  Result := TCFString.Create(AValue);
end;

class operator TCFString.Implicit(AValue: TCFString): string;
begin
  Result := AValue.AsString;
end;

class operator TCFString.Implicit(AValue: CFStringRef): TCFString;
begin
  Result.Value := AValue;
end;

{ TCFPropertyList }

class constructor TCFPropertyList.Create;
begin
  FTypeIDs[vkUnknown] := 0; // Is this safe?
  FTypeIDs[vkArray] := CFArrayGetTypeID;
  FTypeIDs[vkBoolean] := CFBooleanGetTypeID;
  FTypeIDs[vkData] := CFDataGetTypeID;
  FTypeIDs[vkDate] := CFDateGetTypeID;
  FTypeIDs[vkDictionary] := CFDictionaryGetTypeID;
  FTypeIDs[vkNumber] := CFNumberGetTypeID;
  FTypeIDs[vkString] := CFStringGetTypeID;
end;

constructor TCFPropertyList.CreateFromFile(const FileName: string;
  Mutable: CFPropertyListMutabilityOptions; Format: PCFPropertyListFormat);
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmOpenRead);
  try
    CreateFromStream(FileStream, Mutable, Format);
  finally
    FileStream.Free;
  end;
end;

constructor TCFPropertyList.CreateFromStream(AStream: TStream;
  Mutable: CFPropertyListMutabilityOptions; Format: PCFPropertyListFormat);
var
  LData: TBytes;
  LCFData: CFDataRef;
  LError: CFErrorRef;
begin
  SetLength(LData, AStream.Size);
  AStream.Read(LData[0], AStream.Size);
  LCFData := CFDataCreateWithBytesNoCopy(kCFAllocatorDefault, @LData[0],
    AStream.Size, kCFAllocatorNull);
  try
    Value := CFPropertyListCreateWithData(KCFAllocatorDefault, LCFData,
      Mutable, Format, @LError);
  finally
    CFRelease(LCFData);
  end;
end;

procedure TCFPropertyList.SaveToFile(const FileName: string;
  Format: CFPropertyListFormat);
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(FileStream, Format);
  finally
    FileStream.Free;
  end;
end;

procedure TCFPropertyList.SaveToStream(AStream: TStream;
  Format: CFPropertyListFormat);
var
  LData: TBytes;
  LCFData: CFDataRef;
  LError: CFErrorRef;
begin
  LCFData := CFPropertyListCreateData(kCFAllocatorDefault, Value, Format, 0, @LError);
  try
    LData := TCFData(LCFData).AsArray<Byte>;
    AStream.Write(LData[0], Length(LData));
  finally
    CFRelease(LCFData);
  end;
end;

function TCFPropertyList.TypeID: CFTypeID;
begin
  Result := CFGetTypeID(Value);
end;

function TCFPropertyList.PropertyListKind: TCFPropertyListKind;
var
  LTypeID: CFTypeID;
  LValueKind: TCFPropertyListKind;
begin
  Result := vkUnknown;
  try
  LTypeID := CFGetTypeID(Value);
  for LValueKind := Low(FTypeIDs) to High(FTypeIDs) do
    if LTypeID = FTypeIDs[LValueKind] then
      Exit(LValueKind);
  except
    Result := vkUnknown;
  end;
end;

class function TCFPropertyList.Create<T>(AValue: T): TCFPropertyList;
var
  Info: PTypeInfo;
begin
  Info := TypeInfo(T);

  if Info = TypeInfo(Boolean) then
    Result.Value := TCFBoolean( PBoolean(@AValue)^ ).Value
  else if Info = TypeInfo(TDateTime) then
    Result.Value := TCFDate.Create( PDateTime(@AValue)^ ).Value
  else if Info = TypeInfo(TBytes) then
    Result.Value := TCFData.CreateFromType<T>(AValue).Value
  else
  case Info.Kind of
{$IFNDEF NEXTGEN}
    tkString: Result.Value := TCFString.Create( string(PShortString(@AValue)^) ).Value;
    tkLString: Result.Value := TCFString.Create( string(PAnsiString(@AValue)^) ).Value;
    tkWString: Result.Value := TCFString.Create( PWideString(@AValue)^ ).Value;
{$ENDIF}	
    tkUString: Result.Value := TCFString.Create( PUnicodeString(@AValue)^ ).Value;
    tkInteger, tkInt64, tkFloat: Result.Value := TCFNumber.CreateFromType<T>(AValue).Value;
  end;
end;

function TCFPropertyList.AsTValue: TValue;
begin
  case PropertyListKind of
                                                                                                             
  //vkArray: Result := TCFArray(Self).AsArray<>;
    vkBoolean: Result := TCFBoolean(Self).AsBoolean;
    vkData: Result := TValue.From<TBytes>(TCFData(Self).AsArray<Byte>);
    vkDate: Result := TCFDate(Self).AsTDateTime;
    vkNumber: Result := TCFNumber(Self).AsTValue;
    vkString: Result := TCFString(Self).AsString;
    vkUnknown: raise ECFPropertyListException.CreateRes(@sInvalidPListType);
    vkDictionary: raise ECFPropertyListException.CreateRes(@sConvertDictionary);
  end;
end;

class operator TCFPropertyList.Explicit(PList: TCFPropertyList): TCFArray;
var
  ID: CFTypeID;
begin
  ID:= CFGetTypeID(PList.Value);
  if ID <> FTypeIDs[vkArray] then
    raise ECFPropertyListException.CreateResFmt(@sInvalidConversion,
      [TCFString(CFCopyTypeIDDescription(ID)).AsString(True), 'CFArray']); //DO NOT TRANSLATE
  Result.Value := PList.Value;
end;

class operator TCFPropertyList.Explicit(PList: TCFPropertyList): TCFBoolean;
var
  ID: CFTypeID;
begin
  ID := CFGetTypeID(PList.Value);
  if ID <> FTypeIDs[vkBoolean] then
    raise ECFPropertyListException.CreateResFmt(@sInvalidConversion,
      [TCFString(CFCopyTypeIDDescription(ID)).AsString(True), 'CFBoolean']); //DO NOT TRANSLATE
  Result.Value := PList.Value;
end;

class operator TCFPropertyList.Explicit(PList: TCFPropertyList): TCFDate;
var
  ID: CFTypeID;
begin
  ID := CFGetTypeID(PList.Value);
  if ID <> FTypeIDs[vkDate] then
    raise ECFPropertyListException.CreateResFmt(@sInvalidConversion,
      [TCFString(CFCopyTypeIDDescription(ID)).AsString(True), 'CFDate']); //DO NOT TRANSLATE
  Result.Value := PList.Value;
end;

class operator TCFPropertyList.Explicit(PList: TCFPropertyList): TCFData;
var
  ID: CFTypeID;
begin
  ID := CFGetTypeID(PList.Value);
  if ID <> FTypeIDs[vkData] then
    raise ECFPropertyListException.CreateResFmt(@sInvalidConversion,
      [TCFString(CFCopyTypeIDDescription(ID)).AsString(True), 'CFData']); //DO NOT TRANSLATE
  Result.Value := PList.Value;
end;

class operator TCFPropertyList.Explicit(PList: TCFPropertyList): TCFDictionary;
var
  ID: CFTypeID;
begin
  ID := CFGetTypeID(PList.Value);
  if ID <> FTypeIDs[vkDictionary] then
    raise ECFPropertyListException.CreateResFmt(@sInvalidConversion,
      [TCFString(CFCopyTypeIDDescription(ID)).AsString(True), 'CFDictionary']); //DO NOT TRANSLATE
  Result.Value := PList.Value;
end;

class operator TCFPropertyList.Explicit(PList: TCFPropertyList): TCFNumber;
var
  ID: CFTypeID;
begin
  ID := CFGetTypeID(PList.Value);
  if ID <> FTypeIDs[vkNumber] then
    raise ECFPropertyListException.CreateResFmt(@sInvalidConversion,
      [TCFString(CFCopyTypeIDDescription(ID)).AsString(True), 'CFNumber']); //DO NOT TRANSLATE
  Result.Value := PList.Value;
end;

class operator TCFPropertyList.Explicit(PList: TCFPropertyList): TCFString;
var
  ID: CFTypeID;
begin
  ID := CFGetTypeID(PList.Value);
  if ID <> FTypeIDs[vkString] then
    raise ECFPropertyListException.CreateResFmt(@sInvalidConversion,
      [TCFString(CFCopyTypeIDDescription(ID)).AsString(True), 'CFString']); //DO NOT TRANSLATE
  Result.Value := PList.Value;
end;

class operator TCFPropertyList.Explicit(PList: TCFArray): TCFPropertyList;
begin
  Result.Value := PList.Value;
end;

class operator TCFPropertyList.Explicit(PList: TCFBoolean): TCFPropertyList;
begin
  Result.Value := PList.Value;
end;

class operator TCFPropertyList.Explicit(PList: TCFData): TCFPropertyList;
begin
  Result.Value := PList.Value;
end;

class operator TCFPropertyList.Explicit(PList: TCFDate): TCFPropertyList;
begin
  Result.Value := PList.Value;
end;

class operator TCFPropertyList.Explicit(PList: TCFDictionary): TCFPropertyList;
begin
  Result.Value := PList.Value;
end;

class operator TCFPropertyList.Explicit(PList: TCFNumber): TCFPropertyList;
begin
  Result.Value := PList.Value;
end;

class operator TCFPropertyList.Explicit(PList: TCFString): TCFPropertyList;
begin
  Result.Value := PList.Value;
end;

class operator TCFPropertyList.Implicit(AValue: CFPropertyListRef): TCFPropertyList;
begin
  Result.Value := AValue;
end;

{ CFGregorianDateHelper }

class function CFGregorianDateHelper.Create(AValue: TDateTime): CFGregorianDate;
var
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin
  DecodeDateTime(AValue, Year, Month, Day, Hour, Min, Sec, MSec);
  Result.year := Year;
  Result.month := Month;
  Result.day := Day;
  Result.hour := Hour;
  Result.minute := Min;
  Result.second := (MSec / MSecsPerSec) + Sec;
end;

function CFGregorianDateHelper.ToDateTime: TDateTime;
begin
  Result := EncodeDateTime(year, month, day, hour, minute, Trunc(second), Round((second - Trunc(second)) * MSecsPerSec));
end;

end.
