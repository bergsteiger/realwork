{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.JSON.Types;

interface

{$SCOPEDENUMS ON}

uses
  System.SysUtils, System.Generics.Collections, System.Classes;

const
  JsonExtOidPropertyName = '$oid';
  JsonExtBinaryPropertyName = '$binary';
  JsonExtTypePropertyName = '$type';
  JsonExtDatePropertyName = '$date';
  JsonExtRegexPropertyName = '$regex';
  JsonExtOptionsPropertyName = '$options';
  JsonExtRefPropertyName = '$ref';
  JsonExtIdPropertyName = '$id';
  JsonExtDbPropertyName = '$db';
  JsonExtCodePropertyName = '$code';
  JsonExtScopePropertyName = '$scope';
  JsonExtUndefinedPropertyName = '$undefined';
  JsonExtMinKeyPropertyName = '$minkey';
  JsonExtMaxKeyPropertyName = '$maxkey';
  JsonExtNumberLongPropertyName = '$numberlong';
  JsonExtMaxPropertyNameLen = Length(JsonExtNumberLongPropertyName);

type
  /// <summary> Json and Json extended / BSON token types </summary>
  TJsonToken = (
    None,
    StartObject,
    StartArray,
    StartConstructor,
    PropertyName,
    Comment,
    Raw,
    Integer,
    Float,
    &String,
    Boolean,
    Null,
    Undefined,
    EndObject,
    EndArray,
    EndConstructor,
    Date,
    Bytes,
    // Only in Extended JSON, BSON
    Oid,
    RegEx,
    DBRef,
    CodeWScope,
    MinKey,
    MaxKey
  );

  /// <summary> Specifies the handling for empty values in managed types like array and string([], '') </summary>
  TJsonEmptyValueHandling = (Empty, Null);

  /// <summary> Specifies the handling for empty values in managed types like array and string([], '') </summary>
  TJsonDateFormatHandling = (Iso, Unix, FormatSettings);

  /// <summary> Specifies the handling for TDateTime values </summary>
  TJsonDateTimeZoneHandling = (Local, Utc);

  /// <summary> Indicates whether tokens should be parsed as TDatetime or not </summary>
  TJsonDateParseHandling = (None, DateTime);

  /// <summary> 
  ///  Specifies how strings are escaped when writing JSON text:
  ///   - Default: Only control characters (e.g. newline) are escaped
  ///   - EscapeNonAscii: All non-ASCII and control characters (e.g. newline) are escaped.
  ///   - EscapeHtml: HTML (&lt;, &gt;, &amp;, &apos;, &quot;) and control characters (e.g. newline) are escaped.
  /// </summary>
  TJsonStringEscapeHandling = (Default, EscapeNonAscii, EscapeHtml);

  /// <summary>
  ///  Specifies float format handling options when writing special floating point numbers:
  ///   - String: Write special floating point values as strings in JSON, e.g. "NaN", "Infinity", "-Infinity".
  ///   - Symbol: Write special floating point values as symbols in JSON, e.g. NaN, Infinity, -Infinity. Note that this will produce non-valid JSON.
  ///   - DefaultValue: Write special floating point values as the property's default value in JSON.
  /// </summary>
  TJsonFloatFormatHandling = (&String, Symbol, DefaultValue);

  /// <summary>
  ///  Specifies formatting options for the TJsonTextWriter.
  ///   - None: No special formatting is applied. This is the default.
  ///   - Indented: Causes child objects to be indented according to the TJsonTextWriter.Indentation and TJsonTextWriter.IndentChar settings.
  /// </summary>
  TJsonFormatting = (None, Indented);

  /// <summary> Container types for JSON </summary>
  TJsonContainerType = (None, &Object, &Array, &Constructor);
  
                                                                        
  TJsonNullValueHandling = (Include, Ignore);

                                                                        
  TJsonDefaultValueHandling = (Include, Ignore, Populate, IgnoreAndPopulate);
  
                                                                        
  TJsonReferenceLoopHandling = (Error, Ignore, Serialize);
  
                                                                        
  TJsonObjectCreationHandling = (Auto, Reuse, Replace);
  
                                                                        
  TJsonTypeNameHandling = (None, Objects, Arrays, All, Auto);


  TJsonLineInfo = class
  public
    /// <summary>
    ///  Gets the current line number.
    /// </summary>
    function GetLineNumber: Integer; virtual; abstract;
    /// <summary>
    ///  Gets the current line position.
    /// </summary>
    function GetLinePosition: Integer; virtual; abstract;
    /// <summary>
    ///  Gets a value indicating whether the class can return line information
    /// </summary>
    function HasLineInfo: Boolean; virtual; abstract;
    /// <summary>
    ///  Gets the current line number.
    /// </summary>
    property LineNumber: Integer read GetLineNumber;
    /// <summary>
    ///  Gets the current line position.
    /// </summary>
    property LinePosition: Integer read GetLinePosition;
  end;

  /// <summary>
  ///  Specifies the modes in which JSON text should be written/readed. See http://mongodb.github.io/mongo-java-driver/3.0/bson/extended-json/
  ///   - None: The reader doesn't try to parse tokens as extended JSON types, is treated 
  ///   - StrictMode: Extended json is written/readed as representations of BSON types that conform to the JSON RFC.
  ///   - MongoShell: Extended json is written/readed as a superset of JSON that the MongoDB shell can parse
  /// </summary>
  TJsonExtendedJsonMode = (None, StrictMode, MongoShell);

  /// <summary> Binary subtypes that represents Extended JSON / BSON binary data type.
  ///   See http://docs.mongodb.org/manual/reference/mongodb-extended-json/#binary
  ///   See http://bsonspec.org/spec.html
  /// </summary>
  TJsonBinaryType = (Generic = $00, &Function = $01, BinaryOld = $02,
    UUIDOld = $03, UUID = $04, MD5 = $05, UserDefined = $80);

  /// <summary> Represents a path position within a JSON </summary>
  TJsonPosition = record
  private
    class function TypeHasIndex(Atype: TJsonContainerType): Boolean; static;
  public
    /// <summary> Container type where the position resides </summary>
    ContainerType: TJsonContainerType;
    /// <summary> Position itself </summary>
    Position: Integer;
    /// <summary> Property Name </summary>
    PropertyName: string;
    /// <summary> Tells if the container has index info </summary>
    HasIndex: Boolean;
    constructor Create(AType: TJsonContainerType); overload;
    /// <summary> Helper to write the info to an TStringBuilder </summary>
    procedure WriteTo(const Sb: TStringBuilder);
    class function Create: TJsonPosition; overload; static;
    /// <summary> Builds a formatted path from a collection of <see cref="TJsonPosition"/> </summary>
    class function BuildPath(const Positions: TEnumerable<TJsonPosition>): string; static;
    /// <summary> Helper to format LineInfo + Path + Msg </summary>
    class function FormatMessage(const LineInfo: TJsonLineInfo; const Path, Msg: string): string; static;
  end;

  /// <summary>
  ///  Generic Exception type for Json
  /// </summary>
  EJsonException = class(Exception)
  private
    FInnerException: Exception;
  public
    constructor Create(const Msg: string; const InnerException: Exception); overload;
    /// <summary>
    ///  Gets the underlying exception
    /// </summary>
    property InnerException: Exception read FInnerException;
  end;

  /// <summary> TJsonOid class represents Extended JSON OID / BSON data type.
  ///  See http://docs.mongodb.org/manual/reference/mongodb-extended-json/#oid
  ///      http://bsonspec.org/spec.html 
  /// </summary>
  TJsonOid = record
  private
    function GetAsString: String;
    procedure SetAsString(const Value: String);
    function GetAsBytes: TBytes;
    procedure SetAsBytes(const Value: TBytes);
  public
    /// <summary> Oid value. </summary>
    Bytes: array [0 .. 12-1] of Byte;
    constructor Create(const AOid: TBytes); overload;
    constructor Create(const AOid: String); overload;
    /// <summary> Provides access to Oid value as a hexadecimal string. </summary>
    property AsString: String read GetAsString write SetAsString;
    /// <summary> Provides access to Oid value as a TBytes. </summary>
    property AsBytes: TBytes read GetAsBytes write SetAsBytes;
  end;

  /// <summary> TJsonRegEx class represents Extended JSON / BSON Regular Expression data type.
  ///  See http://docs.mongodb.org/manual/reference/mongodb-extended-json/#regular-expression
  ///      http://bsonspec.org/spec.html 
  /// </summary>
  TJsonRegEx = record
  private
    function GetAsString: String;
    procedure SetAsString(const AValue: String);
  public
    /// <summary> Regular expression pattern value. </summary>
    RegEx: String;
    /// <summary> Regular expression options value. </summary>
    Options: String;
    constructor Create(const ARegEx, AOptions: String);
    /// <summary> Provides access to RegEx value as a string of '/regex/options' format. </summary>
    property AsString: String read GetAsString write SetAsString;
  end;

  /// <summary> TJsonDBRef class represents Extended JSON  / BSON DB Reference data type.
  ///  See http://docs.mongodb.org/manual/reference/mongodb-extended-json/#db-reference
  ///      http://bsonspec.org/spec.html 
  /// </summary>
  TJsonDBRef = record
  private
    function GetAsString: String;
    procedure SetAsString(const AValue: String);
  public
    /// <summary> DB reference optional database name. </summary>
    DB: String;
    /// <summary> DB reference mandatory collection name. </summary>
    Ref: String;
    /// <summary> DB reference mandatory document ID. </summary>
    Id: TJsonOid;
    constructor Create(const ADb, ARef, AId: String); overload;
    constructor Create(const ARef, AId: String); overload;
    constructor Create(const ADb, ARef: String; const AId: TJsonOid); overload;
    constructor Create(const ARef: String; const AId: TJsonOid); overload;
    /// <summary> Provides access to DBRef value as a string of 'db.ref.id' format. </summary>
    property AsString: String read GetAsString write SetAsString;
  end;

  /// <summary> TJsonCodeWScope class represents BSON Code With Scope data type.
  ///  See http://bsonspec.org/spec.html </summary>
  TJsonCodeWScope = record
  public type
    TScopeItem = record
      Ident: String;
      Value: String;
    end;
  public
    /// <summary> CodeWScope code value. </summary>
    Code: String;
    /// <summary> CodeWScope array of scope items. </summary>
    Scope: array of TScopeItem;
    constructor Create(const ACode: String; AScope: TStrings);
  end;

var
  /// <summary> General JSON format settings. </summary>
  JSONFormatSettings: TFormatSettings;

implementation

uses
  System.JSONConsts;

{ TJsonPosition }

class function TJsonPosition.BuildPath(const Positions: TEnumerable<TJsonPosition>): string;
var
  Sb: TStringBuilder;
  State: TJsonPosition;
begin
  Sb := TStringBuilder.Create;
  try
    for State in Positions do
      State.WriteTo(Sb);

    Result := Sb.ToString;
  finally
    Sb.Free;
  end;
end;

constructor TJsonPosition.Create(AType: TJsonContainerType);
begin
  ContainerType := Atype;
  HasIndex := TypeHasIndex(Atype);
  Position := -1;
  PropertyName := '';
end;

class function TJsonPosition.Create: TJsonPosition;
begin
  Result := TJsonPosition.Create(TJsonContainerType.None);
end;

class function TJsonPosition.FormatMessage(const LineInfo: TJsonLineInfo; const Path, Msg: string): string;
begin
  Result := Msg;
  if not Result.EndsWith(sLineBreak) then
  begin
    Result := Result.Trim;
    if not Result.EndsWith('.') then
      Result := Result + '.';
    Result := Result + ' ';
  end;

  Result := Result + Format(SFormatMessagePath, [Path], JSONFormatSettings);

  if (LineInfo <> nil) and (LineInfo.HasLineInfo) then
    Result := Result + Format(SFormatMessageLinePos, [LineInfo.LineNumber, LineInfo.LinePosition], JSONFormatSettings);
end;

class function TJsonPosition.TypeHasIndex(Atype: TJsonContainerType): Boolean;
begin
  Result := (Atype = TJsonContainerType.Array) or (Atype = TJsonContainerType.Constructor);
end;

procedure TJsonPosition.WriteTo(const Sb: TStringBuilder);
begin
  case ContainerType of
    TJsonContainerType.Object:
    begin
      if Sb.Length > 0 then
        Sb.Append('.');
      Sb.Append(PropertyName);
    end;
    TJsonContainerType.Array,
    TJsonContainerType.Constructor:
    begin
      Sb.Append('[');
      Sb.Append(Position);
      Sb.Append(']');
    end;
  end;
end;

{ EJsonException }

constructor EJsonException.Create(const Msg: string; const InnerException: Exception);
begin
  Create(Msg);
  FInnerException := InnerException;
end;

{ TJsonOid }

constructor TJsonOid.Create(const AOid: TBytes);
begin
  AsBytes := AOid;
end;

constructor TJsonOid.Create(const AOid: String);
begin
  AsString := AOid;
end;

function TJsonOid.GetAsBytes: TBytes;
begin
  SetLength(Result, SizeOf(bytes));
  Move(bytes[0], Result[0], SizeOf(bytes));
end;

procedure TJsonOid.SetAsBytes(const Value: TBytes);
begin
  if Length(Value) = 0 then
    FillChar(bytes[0], SizeOf(bytes), 0)
  else
  begin
    if Length(Value) <> SizeOf(bytes) then
      EJsonException.Create(SInvalidObjectId);
    Move(Value[0], bytes[0], SizeOf(bytes));
  end;
end;

function TJsonOid.GetAsString: String;
var
  LBytes, LText: TBytes;
begin
  LBytes := AsBytes;
  SetLength(LText, Length(LBytes) * 2);
  BinToHex(LBytes, 0, LText, 0, SizeOf(bytes));
  Result := TEncoding.ANSI.GetString(LText);
end;

procedure TJsonOid.SetAsString(const Value: String);
var
  LText, LBytes: TBytes;
begin
  LText := BytesOf(Value);
  SetLength(LBytes, Length(LText) div 2);
  HexToBin(LText, 0, LBytes, 0, Length(LBytes));
  SetAsBytes(LBytes);
end;

{ TJsonRegEx }

constructor TJsonRegEx.Create(const ARegEx, AOptions: String);
begin
  RegEx := ARegEx;
  Options := AOptions;
end;

function TJsonRegEx.GetAsString: String;
begin
  Result := '/' + RegEx + '/' + Options;
end;

procedure TJsonRegEx.SetAsString(const AValue: String);
var
  LVals: TArray<string>;
begin
  RegEx := '';
  Options := '';
  LVals := AValue.Split(['/']);
  if Length(LVals) = 1 then
    RegEx := LVals[0]
  else if Length(LVals) = 2 then
    RegEx := LVals[1]
  else if Length(LVals) = 3 then
  begin
    RegEx := LVals[1];
    Options := LVals[2];
  end;
end;

{ TJsonDBRef }

constructor TJsonDBRef.Create(const ADb, ARef, AId: String);
begin
  DB := ADb;
  Ref := ARef;
  Id.AsString := AId;
end;

constructor TJsonDBRef.Create(const ARef, AId: String);
begin
  Create('', ARef, AId);
end;

constructor TJsonDBRef.Create(const ADb, ARef: String; const AId: TJsonOid);
begin
  DB := ADb;
  Ref := ARef;
  Id := AId;
end;

constructor TJsonDBRef.Create(const ARef: String; const AId: TJsonOid);
begin
  Create('', ARef, AId);
end;

function TJsonDBRef.GetAsString: String;
begin
  Result := DB;
  if Result <> '' then
    Result := Result + '.';
  Result := Result + Ref + '.' + Id.AsString;
end;

procedure TJsonDBRef.SetAsString(const AValue: String);
var
  LVals: TArray<string>;
begin
  LVals := AValue.Split(['.']);
  if Length(LVals) = 2 then
  begin
    DB := '';
    Ref := LVals[0];
    Id.AsString := LVals[1];
  end
  else
  begin
    DB := LVals[0];
    Ref := LVals[1];
    Id.AsString := LVals[2];
  end;
end;

{ TJsonCodeWScope }

constructor TJsonCodeWScope.Create(const ACode: String; AScope: TStrings);
var
  I: Integer;
begin
  Code := ACode;
  if (AScope = nil) or (AScope.Count = 0) then
    SetLength(Scope, 0)
  else
  begin
    SetLength(Scope, AScope.Count);
    for I := 0 to AScope.Count - 1 do
    begin
      Scope[I].Ident := AScope.Names[I];
      Scope[I].Value := AScope.ValueFromIndex[I];
    end;
  end;
end;

initialization
  JSONFormatSettings := TFormatSettings.Invariant;
end.
