{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.JSON.Writers;

interface

{$SCOPEDENUMS ON}

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.Types,
  System.Rtti, System.JSON, System.JSON.Types, System.JSON.Readers;

type
  /// <summary>
  /// TJsonWriter state
  /// </summary>
  TJsonWriteState = (Error, Closed, &Object, &Array, &Constructor, &Property, Start);

  /// <summary>
  /// Base class that provides logic to serialize JSON data.
  /// </summary>
  TJsonWriter = class
  protected type
    /// <summary> States of the writer </summary>
    TState = (Start, &Property, ObjectStart, &Object, ArrayStart, &Array, ConstructorStart, &Constructor, Closed, Error);
  const
    /// <summary> Template table with all posible states and their transitions for the token being written</summary>
    StateArrayTemplate: array[0..7, 0..9] of TState = (
                        // Start                 // PropertyName          // ObjectStart        // Object          // ArrayStart            // Array                 // ConstructorStart      // Constructor           // Closed       // Error
   {None             } (TState.Error           , TState.Error           , TState.Error        , TState.Error     , TState.Error           , TState.Error           , TState.Error           , TState.Error           , TState.Error  , TState.Error  ),
   {StartObject      } (TState.ObjectStart     , TState.ObjectStart     , TState.Error        , TState.Error     , TState.ObjectStart     , TState.ObjectStart     , TState.ObjectStart     , TState.ObjectStart     , TState.Error  , TState.Error  ),
   {StartArray       } (TState.ArrayStart      , TState.ArrayStart      , TState.Error        , TState.Error     , TState.ArrayStart      , TState.ArrayStart      , TState.ArrayStart      , TState.ArrayStart      , TState.Error  , TState.Error  ),
   {StartConstructor } (TState.ConstructorStart, TState.ConstructorStart, TState.Error        , TState.Error     , TState.ConstructorStart, TState.ConstructorStart, TState.ConstructorStart, TState.ConstructorStart, TState.Error  , TState.Error  ),
   {Property         } (TState.Property        , TState.Error           , TState.Property     , TState.Property  , TState.Error           , TState.Error           , TState.Error           , TState.Error           , TState.Error  , TState.Error  ),
   {Comment          } (TState.Start           , TState.Property        , TState.ObjectStart  , TState.Object    , TState.ArrayStart      , TState.Array           , TState.Constructor     , TState.Constructor     , TState.Error  , TState.Error  ),
   {Raw              } (TState.Start           , TState.Property        , TState.ObjectStart  , TState.Object    , TState.ArrayStart      , TState.Array           , TState.Constructor     , TState.Constructor     , TState.Error  , TState.Error  ),
   {Value            } (TState.Start           , TState.Object          , TState.Error        , TState.Error     , TState.Array           , TState.Array           , TState.Constructor     , TState.Constructor     , TState.Error  , TState.Error  )
    );
  private
    FStack: TList<TJsonPosition>;
    FCloseOutput: Boolean;
    FEmptyValueHandling: TJsonEmptyValueHandling;
    class var StateArray: array of array of TState;
    class var FRttiCtx: TRTTIContext;
    procedure AutoCompleteAll;
    procedure AutoCompleteClose(ContainerType: TJsonContainerType);
    function GetCloseTokenForType(ContainerType: TJsonContainerType): TJsonToken;
    function Peek: TJsonContainerType;
    procedure Push(Value: TJsonContainerType);
    function Pop: TJsonContainerType;
    procedure WriteConstructorDate(const Reader: TJsonReader);
    function GetContainerPath: string;
    function GetPath: string;
    function GetWriteState: TJsonWriteState;
    class procedure BuildStateArray;
 protected
    /// <summary> Current writer state </summary>
    FCurrentState: TState;
    /// <summary> Current Position </summary>
    FCurrentPosition: TJsonPosition;
    /// <summary> Updates the current state with the token begin written </summary>
    procedure AutoComplete(TokenBeginWritten: TJsonToken);
    function GetTop: Integer;
    function GetTopContainer: TJsonContainerType;
    /// <summary> Get the position based on the depth </summary>
    function GetPosition(ADepth: Integer): TJsonPosition;
    /// <summary> Updates the position </summary>
    procedure UpdateScopeWithFinishedValue;
    /// <summary> Write the end token based on container </summary>
    procedure InternalWriteEnd(Container: TJsonContainerType);
    /// <summary> Writes a property name </summary>
    procedure InternalWritePropertyName(const Name: string);
    /// <summary> Writes an start token based on the current container </summary>
    procedure InternalWriteStart(Token: TJsonToken; Container: TJsonContainerType);
    /// <summary> Writes an start token </summary>
    procedure InternalWriteValue(Token: TJsonToken);
    /// <summary> Writes a comment </summary>
    procedure InternalWriteComment;
    /// <summary> Sets the internal state </summary>
    procedure SetWriteState(Token: TJsonToken; const Value: TValue);
    /// <summary> Write the end token based on container </summary>
    procedure WriteEnd(ContainerType: TJsonContainerType); overload;
    /// <summary> Write the end token based on the token, this method does not updates the internal state </summary>
    procedure WriteEnd(const Token: TJsonToken); overload; virtual;
    /// <summary> Implementation for WriteToken </summary>
    procedure WriteToken(const Reader: TJsonReader; WriteChildren, WriteDateConstructorAsDate: Boolean); overload;
    /// <summary> Implementation for WriteToken </summary>
    procedure WriteToken(const Reader: TJsonReader; InitialDepth: Integer;
     WriteChildren, WriteDateConstructorAsDate: Boolean); overload;

    /// <summary> Writes a TValue </summary>
    class procedure WriteValue(const Writer: TJsonWriter; const Value: TValue); overload;

    /// <summary> Checks whether the token is an end token </summary>
    class function IsEndToken(Token: TJsonToken): Boolean;
    /// <summary> Checks whether the token is an start token </summary>
    class function IsStartToken(Token: TJsonToken): Boolean;

    /// <summary> Event called before write a token </summary>
    procedure OnBeforeWriteToken(TokenBeginWriten: TJsonToken); virtual;

    constructor Create;
  public
    class constructor Create;
    destructor Destroy; override;
    /// <summary> Resets the internal state allowing write from the begining </summary>
    procedure Rewind; virtual;
    /// <summary> Closes the Writer </summary>
    procedure Close; virtual;
    /// <summary> Flushes the content if needed </summary>
    procedure Flush; virtual;
    /// <summary> Writes a comment</summary>
    procedure WriteComment(const Comment: string); virtual;
    /// <summary> Writes the start of a json object </summary>
    procedure WriteStartObject; virtual;
    /// <summary> Writes the end of a json object </summary>
    procedure WriteEndObject; virtual;
    /// <summary> Writes the start of a json array </summary>
    procedure WriteStartArray; virtual;
    /// <summary> Writes the end of a json array </summary>
    procedure WriteEndArray; virtual;
    /// <summary> Writes the start of a javascript constructor </summary>
    procedure WriteStartConstructor(const Name: string); virtual;
    /// <summary> Writes the end of a javascript constructor </summary>
    procedure WriteEndConstructor; virtual;
    /// <summary> Writes a property name </summary>
    procedure WritePropertyName(const Name: string); overload; virtual;
    /// <summary> Writes the end token for the current container (object, array or constructor) </summary>
    procedure WriteEnd; overload; virtual;
    /// <summary> Writes a null value </summary>
    procedure WriteNull; virtual;
    /// <summary> Writes a raw json, it does not update the internal state </summary>
    procedure WriteRaw(const Json: string); virtual;
    /// <summary> Writes a raw json, it updates the internal state </summary>
    procedure WriteRawValue(const Json: string); virtual;
    /// <summary> Writes an undefined value </summary>
    procedure WriteUndefined; virtual;
    /// <summary> Writes the token/s given by the Reader </summary>
    procedure WriteToken(const Reader: TJsonReader); overload;
    /// <summary> Writes the token/s given by the Reader </summary>
    procedure WriteToken(const Reader: TJsonReader; WriteChildren: Boolean); overload;
    /// <summary> Writes an string value </summary>
    procedure WriteValue(const Value: string); overload; virtual;
    /// <summary> Writes an Integer value </summary>
    procedure WriteValue(Value: Integer); overload; virtual;
    /// <summary> Writes an UInt32 value </summary>
    procedure WriteValue(Value: UInt32); overload; virtual;
    /// <summary> Writes an Int64 value </summary>
    procedure WriteValue(Value: Int64); overload; virtual;
    /// <summary> Writes an UInt64 value value </summary>
    procedure WriteValue(Value: UInt64); overload; virtual;
    /// <summary> Writes a Single value </summary>
    procedure WriteValue(Value: Single); overload; virtual;
    /// <summary> Writes a Double value </summary>
    procedure WriteValue(Value: Double); overload; virtual;
    /// <summary> Writes an Extended value </summary>
    procedure WriteValue(Value: Extended); overload; virtual;
    /// <summary> Writes a Boolean value </summary>
    procedure WriteValue(Value: Boolean); overload; virtual;
    /// <summary> Writes a Char value </summary>
    procedure WriteValue(Value: Char); overload; virtual;
    /// <summary> Writes a Byte value </summary>
    procedure WriteValue(Value: Byte); overload; virtual;
    /// <summary> Writes a TDateTime value </summary>
    procedure WriteValue(Value: TDateTime); overload; virtual;
    /// <summary> Writes a <see cref="TGUID"> value </summary>
    procedure WriteValue(const Value: TGUID); overload; virtual;
    /// <summary> Writes a Binary value. See http://bsonspec.org/spec.html </summary>
    procedure WriteValue(const Value: TBytes; BinaryType: TJsonBinaryType = TJsonBinaryType.Generic); overload; virtual;
    /// <summary> Writes a <see cref="TJsonOid"> value. See http://bsonspec.org/spec.html </summary>
    procedure WriteValue(const Value: TJsonOid); overload; virtual;
    /// <summary> Writes a <see cref="TJsonRegEx"> value. See http://bsonspec.org/spec.html </summary>
    procedure WriteValue(const Value: TJsonRegEx); overload; virtual;
    /// <summary> Writes a <see cref="TJsonDBRef"> value. See http://bsonspec.org/spec.html </summary>
    procedure WriteValue(const Value: TJsonDBRef); overload; virtual;
    /// <summary> Writes a <see cref="TJsonCodeWScope"> value. See http://bsonspec.org/spec.html </summary>
    procedure WriteValue(const Value: TJsonCodeWScope); overload; virtual;
    /// <summary> Writes a MinKey value. See http://bsonspec.org/spec.html </summary>
    procedure WriteMinKey; overload; virtual;
    /// <summary> Writes a MinKey value. See http://bsonspec.org/spec.html </summary>
    procedure WriteMaxKey; overload; virtual;
    /// <summary> Writes a <see cref="TValue"> value </summary>
    procedure WriteValue(const Value: TValue); overload; virtual;
    /// <summary> Indicates whether the input should be closed when the writer is closed </summary>
    property CloseOutput: Boolean read FCloseOutput write FCloseOutput;
    /// <summary> Gets the path for the current container </summary>
    property ContainerPath: string read GetContainerPath;
    /// <summary> Gets the writer state </summary>
    property Top: Integer read GetTop;
    /// <summary> Gets the writer state </summary>
    property TopContainer: TJsonContainerType read GetTopContainer;
    /// <summary> Gets the writer state </summary>
    property WriteState: TJsonWriteState read GetWriteState;
    /// <summary> Gets the current path </summary>
    property Path: string read GetPath;
    /// <summary> Indicates how the empty values (arrays/strings) should be written </summary>
    property EmptyValueHandling: TJsonEmptyValueHandling read FEmptyValueHandling write FEmptyValueHandling;
  end;

  /// <summary>
  ///  Exception type for the <see cref="TJsonWriter"/>
  /// </summary>
  EJsonWriterException = class (EJsonException)
  private
    FPath: string;
  public
    constructor Create(const Msg: string; const Ex: Exception; const APath: string); overload;
    constructor Create(const Writer: TJsonWriter; const Msg: string; const Ex: Exception = nil); overload;
    constructor Create(const APath, Msg: string; const Ex: Exception); overload;
    /// <summary> Gets the where the exception was raised </summary>
    property Path: string read FPath;
  end;

  /// <summary>
  ///  Writer to serialize JSON data.
  /// </summary>
  TJsonTextWriter = class(TJsonWriter)
  private
    FDateTimeZoneHandling: TJsonDateTimeZoneHandling;
    FDateFormatHandling: TJsonDateFormatHandling;
    FFormatSettings: TFormatSettings;
    FStringEscapeHandling: TJsonStringEscapeHandling;
    FFloatFormatHandling: TJsonFloatFormatHandling;
    FFormatting: TJsonFormatting;
    FWriter: TTextWriter;
    FIndentChar: Char;
    FIndentation: Integer;
    FQuoteChar: Char;
    FQuoteName: Boolean;
    FExtendedJsonMode: TJsonExtendedJsonMode;
    FCharEscapeFlags: TBooleanDynArray;
    FWriterBuffer: array of Char;
    procedure EnsureBufferSize;
    procedure UpdateCharEscapeFlags;
    procedure WriteValueInternal(const Value: string; Token: TJsonToken);
    procedure WriteEscapedString(const Value: string; Quote: Boolean);
    procedure SetIndentation(Value: Integer);
    procedure SetQuoteChar(Value: Char);
    procedure SetStringEscapeHandling(Value: TJsonStringEscapeHandling);
    procedure WriteNumberLong(const ANum: string);
  protected
    /// <summary> Writes indentation </summary>
    procedure WriteIndent;
    /// <summary> Writes a delimiter </summary>
    procedure WriteValueDelimiter;
    /// <summary> Writes an space as indentation </summary>
    procedure WriteIndentSpace;
    /// <summary> Write the end token based on the token, this method does not updates the internal state </summary>
    procedure WriteEnd(const Token: TJsonToken); override;
    /// <summary> Write the needed indents/spaces if required </summary>
    procedure OnBeforeWriteToken(TokenBeginWritten: TJsonToken); override;
  public
    constructor Create(const TextWriter: TTextWriter);
    /// <summary> Closes the underlitying writer </summary>
    procedure Close; override;
    /// <summary> Flushes the underlitying writer </summary>
    procedure Flush; override;
    /// <summary> Writes a comment</summary>
    procedure WriteComment(const Comment: string); override;
    /// <summary> Writes a null value </summary>
    procedure WriteNull; override;
    /// <summary> Writes a property name </summary>
    procedure WritePropertyName(const Name: string); overload; override;
    /// <summary> Writes a property name </summary>
    procedure WritePropertyName(const Name: string; Escape: Boolean); overload;
    /// <summary> Writes a raw json, it does not update the internal state </summary>
    procedure WriteRaw(const Json: string); override;
    /// <summary> Writes the start of a javascript constructor </summary>
    procedure WriteStartConstructor(const Name: string); override;
    /// <summary> Writes the start of a json object </summary>
    procedure WriteStartObject; override;
    /// <summary> Writes the start of a json array </summary>
    procedure WriteStartArray; override;
    /// <summary> Writes an string value </summary>
    procedure WriteValue(const Value: string); override;
    /// <summary> Writes an Integer value </summary>
    procedure WriteValue(Value: Integer); override;
    /// <summary> Writes an UInt32 value </summary>
    procedure WriteValue(Value: UInt32); override;
    /// <summary> Writes an Int64 value </summary>
    procedure WriteValue(Value: Int64); override;
    /// <summary> Writes an UInt64 value </summary>
    procedure WriteValue(Value: UInt64); override;
    /// <summary> Writes a Single value </summary>
    procedure WriteValue(Value: Single); override;
    /// <summary> Writes a Double value </summary>
    procedure WriteValue(Value: Double); override;
    /// <summary> Writes a Extended value </summary>
    procedure WriteValue(Value: Extended); override;
    /// <summary> Writes a Boolean value </summary>
    procedure WriteValue(Value: Boolean); override;
    /// <summary> Writes a Char value </summary>
    procedure WriteValue(Value: Char); override;
    /// <summary> Writes a Byte value </summary>
    procedure WriteValue(Value: Byte); override;
    /// <summary> Writes a TDateTime value </summary>
    procedure WriteValue(Value: TDateTime); override;
    /// <summary> Writes a <see cref="TGUID"> value </summary>
    procedure WriteValue(const Value: TGUID); override;
    /// <summary> Writes a Binary value. See http://bsonspec.org/spec.html </summary>
    procedure WriteValue(const Value: TBytes; BinaryType: TJsonBinaryType = TJsonBinaryType.Generic); override;
    /// <summary> Writes a <see cref="TJsonOid"> value. See http://bsonspec.org/spec.html </summary>
    procedure WriteValue(const Value: TJsonOid); override;
    /// <summary> Writes a <see cref="TJsonRegEx"> value. See http://bsonspec.org/spec.html </summary>
    procedure WriteValue(const Value: TJsonRegEx); override;
    /// <summary> Writes a <see cref="TJsonDBRef"> value. See http://bsonspec.org/spec.html </summary>
    procedure WriteValue(const Value: TJsonDBRef); override;
    /// <summary> Writes a <see cref="TJsonCodeWScope"> value. See http://bsonspec.org/spec.html </summary>
    procedure WriteValue(const Value: TJsonCodeWScope); override;
    /// <summary> Writes a MinKey value. See http://bsonspec.org/spec.html </summary>
    procedure WriteMinKey; override;
    /// <summary> Writes a MaxKey value. See http://bsonspec.org/spec.html </summary>
    procedure WriteMaxKey; override;
    /// <summary> Writes a <see cref="TValue"> value </summary>
    procedure WriteValue(const Value: TValue); override;
    /// <summary> Writes an undefined value </summary>
    procedure WriteUndefined; override;
    /// <summary> Writes an white space </summary>
    procedure WriteWhitespace(const Ws: string);
    /// <summary> Gets the underlying writer </summary>
    property Writer: TTextWriter read FWriter;
    /// <summary> Gets or sets how many IndentChars to write for each level in the hierarchy when <see cref="Formatting"/> is set to TJsonFormatting.Indented </summary>
    property Indentation: Integer read FIndentation write SetIndentation;
    /// <summary> Gets or sets which character to use for indenting when <see cref="Formatting"/> is set to TJsonFormatting.Indented </summary>
    property IndentChar: Char read FIndentChar write FIndentChar;
    /// <summary>Gets or sets which character to use to quote attribute values </summary>
    property QuoteChar: Char read FQuoteChar write SetQuoteChar;
    /// <summary> Gets or sets a value indicating whether object names will be surrounded with quotes </summary>
    property QuoteName: Boolean read FQuoteName write FQuoteName;
    /// <summary> Indicates how JSON text output is formatted </summary>
    property Formatting: TJsonFormatting read FFormatting write FFormatting;
    /// <summary> Gets or sets the format settings used to convert numbers and datetimes. Default value is TFormatSettings.Invariant </summary>
    property FormatSettings: TFormatSettings read FFormatSettings write FFormatSettings;
    /// <summary> Indicates how strings are escaped when writing JSON text </summary>
    property StringEscapeHandling: TJsonStringEscapeHandling read FStringEscapeHandling write SetStringEscapeHandling;
    /// <summary> Indicates how the TDateTime should be treated when are written </summary>
    property DateTimeZoneHandling: TJsonDateTimeZoneHandling read FDateTimeZoneHandling write FDateTimeZoneHandling;
    /// <summary> Indicates the format of TDateTime to be written in </summary>
    property DateFormatHandling: TJsonDateFormatHandling read FDateFormatHandling write FDateFormatHandling;
    /// <summary> Indicates the format of TDateTime to be written in </summary>
    property FloatFormatHandling: TJsonFloatFormatHandling read FFloatFormatHandling write FFloatFormatHandling;
    /// <summary> Indicates the mode in which the writer should operate when writes extended tokens (TJsonOid, TJsonRegEx...) </summary>
    property ExtendedJsonMode: TJsonExtendedJsonMode read FExtendedJsonMode write FExtendedJsonMode;
  end;

  /// <summary>
  ///  Writer to convert JSON data into TJSONValue objects.
  /// </summary>
  TJsonObjectWriter = class(TJsonWriter)
  private
    FDateFormatHandling: TJsonDateFormatHandling;
    FDateTimeZoneHandling: TJsonDateTimeZoneHandling;
    FRoot: TJSONAncestor;
    FContainerStack: TStack<TJSONAncestor>;
    FOwnValue: Boolean;
    procedure AppendContainer(const JSONValue: TJSONValue);
    procedure AppendValue(const JsonValue: TJSONValue);
  protected
    procedure WriteEnd(const Token: TJsonToken); override;
  public
    constructor Create(OwnValue: Boolean = True);
    destructor Destroy; override;
     /// <summary> Resets the internal state allowing write from the begining </summary>
    procedure Rewind; override;
    /// <summary> Writes a null value </summary>
    procedure WriteNull; override;
    /// <summary> Writes a property name </summary>
    procedure WritePropertyName(const Name: string); overload; override;
    /// <summary> Writes the start of a javascript constructor </summary>
    procedure WriteStartConstructor(const Name: string); override;
    /// <summary> Writes the start of a json object </summary>
    procedure WriteStartObject; override;
    /// <summary> Writes the start of a json array </summary>
    procedure WriteStartArray; override;
    /// <summary> Writes a raw json, it does not update the internal state </summary>
    procedure WriteRaw(const Json: string); override;
    /// <summary> Writes a raw json, it updates the internal state </summary>
    procedure WriteRawValue(const Json: string); override;
    /// <summary> Writes an string value </summary>
    procedure WriteValue(const Value: string); override;
    /// <summary> Writes an Integer value </summary>
    procedure WriteValue(Value: Integer); override;
    /// <summary> Writes an UInt32 value </summary>
    procedure WriteValue(Value: UInt32); override;
    /// <summary> Writes an Int64 value </summary>
    procedure WriteValue(Value: Int64); override;
    /// <summary> Writes an UInt64 value </summary>
    procedure WriteValue(Value: UInt64); override;
    /// <summary> Writes a Single value </summary>
    procedure WriteValue(Value: Single); override;
    /// <summary> Writes a Double value </summary>
    procedure WriteValue(Value: Double); override;
    /// <summary> Writes a Extended value </summary>
    procedure WriteValue(Value: Extended); override;
    /// <summary> Writes a Boolean value </summary>
    procedure WriteValue(Value: Boolean); override;
    /// <summary> Writes a Char value </summary>
    procedure WriteValue(Value: Char); override;
    /// <summary> Writes a Byte value </summary>
    procedure WriteValue(Value: Byte); override;
    /// <summary> Writes a TDateTime value </summary>
    procedure WriteValue(Value: TDateTime); override;
    /// <summary> Writes a <see cref="TGUID"> value </summary>
    procedure WriteValue(const Value: TGUID); override;
    /// <summary> Writes a Binary value. See http://bsonspec.org/spec.html </summary>
    procedure WriteValue(const Value: TBytes; BinaryType: TJsonBinaryType = TJsonBinaryType.Generic); override;
    /// <summary> Writes a <see cref="TJsonOid"> value. See http://bsonspec.org/spec.html </summary>
    procedure WriteValue(const Value: TJsonOid); override;
    /// <summary> Writes a <see cref="TJsonRegEx"> value. See http://bsonspec.org/spec.html </summary>
    procedure WriteValue(const Value: TJsonRegEx); override;
    /// <summary> Writes a <see cref="TJsonDBRef"> value. See http://bsonspec.org/spec.html </summary>
    procedure WriteValue(const Value: TJsonDBRef); override;
    /// <summary> Writes a <see cref="TJsonCodeWScope"> value. See http://bsonspec.org/spec.html </summary>
    procedure WriteValue(const Value: TJsonCodeWScope); override;
    /// <summary> Writes a MinKey value. See http://bsonspec.org/spec.html </summary>
    procedure WriteMinKey; override;
    /// <summary> Writes a MaxKey value. See http://bsonspec.org/spec.html </summary>
    procedure WriteMaxKey; override;
    /// <summary> Writes an undefined value </summary>
    procedure WriteUndefined; override;
    /// <summary> Gets the JSON value created </summary>
    /// <remarks> To take the ownership of the returned object, set <see cref="OwnValue"> property to false </remarks>
    property JSON: TJSONAncestor read FRoot;
    /// <summary> Indicates how the TDateTime should be treated when are written </summary>
    property DateFormatHandling: TJsonDateFormatHandling read FDateFormatHandling write FDateFormatHandling;
    /// <summary> Indicates the format of TDateTime to be written in </summary>
    property DateTimeZoneHandling: TJsonDateTimeZoneHandling read FDateTimeZoneHandling write FDateTimeZoneHandling;
    /// <summary> Indicates if the JSON value is owned by the writer or not </summary>
    property OwnValue: Boolean read FOwnValue write FOwnValue;
  end;

implementation

uses
  System.TypInfo, System.DateUtils, System.Math, System.NetEncoding,
  System.JSONConsts, System.JSON.Utils;

const
  kUndefined = 'undefined';
  kNull = 'null';
  kTrue = 'true';
  kFalse = 'false';
  kNew = 'new';
  kPositiveInfinity = 'Infinity';
  kNegativeInfinity = '-Infinity';
  kNan = 'NaN';

{ Helpers }

function GetName(Value: TJsonToken): string; overload;
begin
  Result := GetEnumName(TypeInfo(TJsonToken), Integer(Value));
end;

function GetName(Value: TJsonWriter.TState): string; overload;
begin
  Result := GetEnumName(TypeInfo(TJsonWriter.TState), Integer(Value));
end;

function GetName(Value: TJsonContainerType): string; overload;
begin
  Result := GetEnumName(TypeInfo(TJsonContainerType), Integer(Value));
end;

{ TJsonWriterException }

constructor EJsonWriterException.Create(const Msg: string; const Ex: Exception; const APath: string);
begin
  inherited Create(Msg, Ex);
  FPath := APath;
end;

constructor EJsonWriterException.Create(const Writer: TJsonWriter; const Msg: string; const Ex: Exception);
begin
  Create(Writer.ContainerPath, Msg, Ex);
end;

constructor EJsonWriterException.Create(const APath, Msg: string; const Ex: Exception);
begin
  Create(TJsonPosition.FormatMessage(nil, APath, Msg), Ex, APath);
end;

{ TJsonWriter }

procedure TJsonWriter.AutoComplete(TokenBeginWritten: TJsonToken);
var
  NewState: TState;
begin
  NewState := StateArray[Integer(TokenBeginWritten)][Integer(FCurrentState)];
  if NewState = TState.Error then
    raise EJsonWriterException.Create(Self, Format(STokenInStateInvalid, [GetName(TokenBeginWritten),
      GetName(FCurrentState)]));
  OnBeforeWriteToken(TokenBeginWritten);
  FCurrentState := NewState;
end;

procedure TJsonWriter.AutoCompleteAll;
begin
  while Top > 0 do
    WriteEnd;
end;

procedure TJsonWriter.AutoCompleteClose(ContainerType: TJsonContainerType);
var
  LevelsToComplete, CurrentLevel: Integer;
  CurrentLevelType: TJsonContainerType;
  LTop: Integer;
  Token: TJsonToken;
  I: Integer;
begin
  LevelsToComplete := 0;
  if FCurrentPosition.ContainerType = ContainerType then
    LevelsToComplete := 1
  else
  begin
    LTop := Top - 2;
    for I := LTop downto 0 do
    begin
      CurrentLevel := LTop - I;
      if FStack[CurrentLevel].ContainerType = ContainerType then
      begin
        LevelsToComplete := I + 2;
        Break;
      end;
    end;
  end;

  if LevelsToComplete = 0 then
    raise EJsonWriterException.Create(Self, SNoTokenToClose);

  for I := 0 to LevelsToComplete - 1 do
  begin
    Token := GetCloseTokenForType(Pop);

    if FCurrentState = TState.Property then
      WriteNull;

    OnBeforeWriteToken(Token);

    WriteEnd(Token);

    CurrentLevelType := Peek;

    case CurrentLevelType of
      TJsonContainerType.Object:
        FCurrentState := TState.Object;
      TJsonContainerType.Array:
        FCurrentState := TState.Array;
      TJsonContainerType.Constructor:
        FCurrentState := TState.Array;
      TJsonContainerType.None:
        FCurrentState := TState.Start;
      else
        raise EJsonWriterException.Create(Self, Format(SUnknowContainerType, [GetName(CurrentLevelType)]));
    end;
  end;
end;

procedure TJsonWriter.OnBeforeWriteToken(TokenBeginWriten: TJsonToken);
begin
  // implement in child classes
end;

class procedure TJsonWriter.BuildStateArray;
var
  Token: TJsonToken;
  Len, I: Integer;
  PLine: ^TJsonToken;
begin
  Len := Length(StateArrayTemplate);

  SetLength(StateArray, Len);
  for I := Low(StateArrayTemplate) to High(StateArrayTemplate) do
  begin
    SetLength(StateArray[I], Length(StateArrayTemplate[I]));
    Move(StateArrayTemplate[I][0], StateArray[I][0], Length(StateArrayTemplate[I]));
  end;

  I := 0;
  for Token := Low(TJsonToken) to High(TJsonToken) do
  begin
    if Len <= I then
      case Token of
        TJsonToken.Integer,
        TJsonToken.Float,
        TJsonToken.String,
        TJsonToken.Boolean,
        TJsonToken.Null,
        TJsonToken.Undefined,
        TJsonToken.Date,
        TJsonToken.Bytes,
        TJsonToken.Oid,
        TJsonToken.RegEx,
        TJsonToken.DBRef,
        TJsonToken.CodeWScope,
        TJsonToken.MinKey,
        TJsonToken.MaxKey:
        begin
          Inc(Len);
          SetLength(StateArray, Len);
          SetLength(StateArray[Len - 1], Length(StateArrayTemplate[7]));
          PLine := @StateArray[Len - 1][0];
          Move(StateArray[7][0], PLine^, Length(StateArrayTemplate[7]));
        end;
        else
        begin
          Inc(Len);
          SetLength(StateArray, Len);
          SetLength(StateArray[Len - 1], Length(StateArrayTemplate[0]));
          PLine := @StateArray[Len - 1][0];
          Move(StateArray[0][0], PLine^, Length(StateArrayTemplate[0]));
        end;
      end;
    Inc(I);
  end;
end;

class constructor TJsonWriter.Create;
begin
  BuildStateArray;
end;

procedure TJsonWriter.Close;
begin
  AutoCompleteAll;
end;

constructor TJsonWriter.Create;
begin
  FStack := TList<TJsonPosition>.Create;
  FEmptyValueHandling := TJsonEmptyValueHandling.Empty;
  FStack.Capacity := 4;
  FCurrentState := TState.Start;
  CloseOutput := True;
  FCurrentPosition := TJsonPosition.Create(TJsonContainerType.None);
end;

destructor TJsonWriter.Destroy;
begin
  if FCurrentState <> TState.Closed then
    Close;
  FStack.Free;
  inherited Destroy;
end;

procedure TJsonWriter.Flush;
begin
  // implement in child classes
end;

function TJsonWriter.GetCloseTokenForType(ContainerType: TJsonContainerType): TJsonToken;
begin
  case ContainerType of
    TJsonContainerType.Object:
      Result := TJsonToken.EndObject;
    TJsonContainerType.Array:
      Result := TJsonToken.EndArray;
    TJsonContainerType.Constructor:
      Result := TJsonToken.EndConstructor;
    else
      raise EJsonWriterException.Create(Self, Format(SNoTokenForType, [GetName(ContainerType)]));
  end;
end;

function TJsonWriter.GetContainerPath: string;
begin
  if FCurrentPosition.ContainerType = TJsonContainerType.None then
    Result := ''
  else
    Result := TJsonPosition.BuildPath(FStack)
end;

function TJsonWriter.GetPath: string;
var
  InsideContainer: Boolean;
  Positions: TList<TJsonPosition>;
begin
  if FCurrentPosition.ContainerType = TJsonContainerType.None then
    Result := ''
  else
  begin
    InsideContainer := (FCurrentState <> TState.ArrayStart) and
      (FCurrentState <> TState.ConstructorStart) and (FCurrentState <> TState.ObjectStart);

    if not InsideContainer then
      Positions := FStack
    else
    begin
      Positions := TList<TJsonPosition>.Create(FStack);
      Positions.Add(FCurrentPosition)
    end;
    Result := TJsonPosition.BuildPath(Positions);
  end;
end;

function TJsonWriter.GetPosition(ADepth: Integer): TJsonPosition;
begin
  if ADepth < FStack.Count then
    Result := FStack[ADepth]
  else
    Result := FCurrentPosition;
end;

function TJsonWriter.GetTop: Integer;
begin
  Result := FStack.Count;
  if Peek <> TJsonContainerType.None then
    Inc(Result);
end;

function TJsonWriter.GetTopContainer: TJsonContainerType;
begin
  Result := FCurrentPosition.ContainerType;
end;

function TJsonWriter.GetWriteState: TJsonWriteState;
begin
  case FCurrentState of
    TJsonWriter.TState.Error:
      Result := TJsonWriteState.Error;
    TJsonWriter.TState.Closed:
      Result := TJsonWriteState.Closed;
    TJsonWriter.TState.Object,
    TJsonWriter.TState.ObjectStart:
      Result := TJsonWriteState.Object;
    TJsonWriter.TState.Array,
    TJsonWriter.TState.ArrayStart:
      Result := TJsonWriteState.Array;
    TJsonWriter.TState.Constructor,
    TJsonWriter.TState.ConstructorStart:
      Result := TJsonWriteState.Constructor;
    TJsonWriter.TState.Property:
      Result := TJsonWriteState.Property;
    TJsonWriter.TState.Start:
      Result := TJsonWriteState.Start;
    else
      raise EJsonWriterException.Create(Self, Format(SInvalidState, [GetName(FCurrentState)]));
  end;
end;

procedure TJsonWriter.InternalWriteComment;
begin
  AutoComplete(TJsonToken.Comment);
end;

procedure TJsonWriter.InternalWriteEnd(Container: TJsonContainerType);
begin
  AutoCompleteClose(Container);
end;

procedure TJsonWriter.InternalWritePropertyName(const Name: string);
begin
  FCurrentPosition.PropertyName := Name;
  AutoComplete(TJsonToken.PropertyName);
end;

procedure TJsonWriter.InternalWriteStart(Token: TJsonToken; Container: TJsonContainerType);
begin
  UpdateScopeWithFinishedValue;
  AutoComplete(Token);
  Push(Container);
end;

procedure TJsonWriter.InternalWriteValue(Token: TJsonToken);
begin
  UpdateScopeWithFinishedValue;
  AutoComplete(Token);
end;

class function TJsonWriter.IsEndToken(Token: TJsonToken): Boolean;
begin
  case Token of
    TJsonToken.EndObject,
    TJsonToken.EndArray,
    TJsonToken.EndConstructor:
      Result := True;
    else
      Result := False;
  end;
end;

class function TJsonWriter.IsStartToken(Token: TJsonToken): Boolean;
begin
  case Token of
    TJsonToken.StartObject,
    TJsonToken.StartArray,
    TJsonToken.StartConstructor:
      Result := True;
    else
      Result := False;
  end;
end;

function TJsonWriter.Peek: TJsonContainerType;
begin
  Result := FCurrentPosition.ContainerType;
end;

function TJsonWriter.Pop: TJsonContainerType;
var
  OldPosition: TJsonPosition;
begin
  OldPosition := FCurrentPosition;
  if FStack.Count > 0 then
  begin
    FCurrentPosition := FStack[FStack.Count - 1];
    FStack.Delete(FStack.Count - 1);
  end
  else
    FCurrentPosition := TJsonPosition.Create;

  Result := OldPosition.ContainerType;
end;

procedure TJsonWriter.Push(Value: TJsonContainerType);
begin
  if FCurrentPosition.ContainerType <> TJsonContainerType.None then
    FStack.Add(FCurrentPosition);

  FCurrentPosition := TJsonPosition.Create(Value);
end;

procedure TJsonWriter.Rewind;
begin
  FStack.Clear;
  FStack.Capacity := 4;
  FCurrentState := TState.Start;
  CloseOutput := True;
  FCurrentPosition := TJsonPosition.Create(TJsonContainerType.None);
end;

procedure TJsonWriter.SetWriteState(Token: TJsonToken; const Value: TValue);
begin
  case Token of
    TJsonToken.StartObject:
      InternalWriteStart(Token, TJsonContainerType.Object);
    TJsonToken.StartArray:
      InternalWriteStart(Token, TJsonContainerType.Array);
    TJsonToken.StartConstructor:
      InternalWriteStart(Token, TJsonContainerType.Constructor);
    TJsonToken.PropertyName:
    begin
      if not (Value.TypeInfo^.Kind  in [tkString, tkWChar, tkLString, tkWString, tkUString]) then
        raise EArgumentException.Create(SRequiredPropertyName);
      InternalWritePropertyName(Value.AsString);
    end;
    TJsonToken.Comment:
      InternalWriteComment;
    TJsonToken.Raw:
      // raw does not change the state
    ;
    TJsonToken.Integer,
    TJsonToken.Float,
    TJsonToken.String,
    TJsonToken.Boolean,
    TJsonToken.Date,
    TJsonToken.Bytes,
    TJsonToken.Null,
    TJsonToken.Undefined,
    TJsonToken.Oid,
    TJsonToken.RegEx,
    TJsonToken.DBRef,
    TJsonToken.CodeWScope,
    TJsonToken.MinKey,
    TJsonToken.MaxKey:
      InternalWriteValue(Token);
    TJsonToken.EndObject:
      InternalWriteEnd(TJsonContainerType.Object);
    TJsonToken.EndArray:
      InternalWriteEnd(TJsonContainerType.Array);
    TJsonToken.EndConstructor:
      InternalWriteEnd(TJsonContainerType.Constructor);
    else
      raise EArgumentOutOfRangeException.Create('Token');
  end;
end;

procedure TJsonWriter.UpdateScopeWithFinishedValue;
begin
  if FCurrentPosition.HasIndex then
    Inc(FCurrentPosition.Position);
end;

procedure TJsonWriter.WriteComment(const Comment: string);
begin
  InternalWriteComment;
end;

procedure TJsonWriter.WriteConstructorDate(const Reader: TJsonReader);
var
  Ticks: Int64;
  Date: TDateTime;
begin
  if not Reader.Read then
    raise EJsonWriterException.Create(Self, SUnexpectedEndConstructorDate);
  if Reader.TokenType <> TJsonToken.Integer then
    raise EJsonWriterException.Create(Self, Format(SUnexpectedTokenDateConstructorExpInt, [GetName(Reader.TokenType)]));
  Ticks := Reader.Value.AsInt64;
  Date := IncMilliSecond(621355968000000000 + (Ticks * 1000));

  if not reader.Read then
    raise EJsonWriterException.Create(Self, SUnexpectedEndConstructorDate);
  if reader.TokenType <> TJsonToken.EndConstructor then
    raise EJsonWriterException.Create(Self, Format(SUnexpectedTokenDateConstructorExpEnd, [GetName(Reader.TokenType)]));
  WriteValue(Date);
end;

procedure TJsonWriter.WriteEnd;
begin
  WriteEnd(Peek);
end;

procedure TJsonWriter.WriteEnd(const Token: TJsonToken);
begin
  // implement in child classes
end;

procedure TJsonWriter.WriteEnd(ContainerType: TJsonContainerType);
begin
  case ContainerType of
    TJsonContainerType.Object:
      WriteEndObject;
    TJsonContainerType.Array:
      WriteEndArray;
    TJsonContainerType.Constructor:
      WriteEndConstructor;
    else
      raise EJsonWriterException.Create(Self, Format(SUnexpectedTypeOnEnd, [GetName(ContainerType)]));
  end;
end;

procedure TJsonWriter.WriteEndArray;
begin
  InternalWriteEnd(TJsonContainerType.Array);
end;

procedure TJsonWriter.WriteEndConstructor;
begin
  InternalWriteEnd(TJsonContainerType.Constructor);
end;

procedure TJsonWriter.WriteEndObject;
begin
  InternalWriteEnd(TJsonContainerType.Object);
end;

procedure TJsonWriter.WriteNull;
begin
  InternalWriteValue(TJsonToken.Null);
end;

procedure TJsonWriter.WriteRaw(const Json: string);
begin
  // implement in child class
end;

procedure TJsonWriter.WriteRawValue(const Json: string);
begin
  UpdateScopeWithFinishedValue;
  AutoComplete(TJsonToken.Undefined);
  WriteRaw(Json);
end;

procedure TJsonWriter.WritePropertyName(const Name: string);
begin
  InternalWritePropertyName(Name);
end;

procedure TJsonWriter.WriteStartArray;
begin
  InternalWriteStart(TJsonToken.StartArray, TJsonContainerType.Array);
end;

procedure TJsonWriter.WriteStartConstructor(const Name: string);
begin
  InternalWriteStart(TJsonToken.StartConstructor, TJsonContainerType.Constructor);
end;

procedure TJsonWriter.WriteStartObject;
begin
  InternalWriteStart(TJsonToken.StartObject, TJsonContainerType.Object);
end;

procedure TJsonWriter.WriteToken(const Reader: TJsonReader; InitialDepth: Integer; WriteChildren,
  WriteDateConstructorAsDate: Boolean);
var
  DepthOffset: Integer;
  ConstructorName: string;
  S: Single;
  D: Double;
  E: Extended;
  Date: TDateTime;
begin
  repeat
    case Reader.TokenType of
      TJsonToken.None:
        ;
      TJsonToken.StartObject:
        WriteStartObject;
      TJsonToken.StartArray:
        WriteStartArray;
      TJsonToken.StartConstructor:
      begin
        ConstructorName := Reader.Value.AsString;
        // write a JValue date when the constructor is for a date
        if WriteDateConstructorAsDate and string.Equals(ConstructorName, 'Date') then
          WriteConstructorDate(Reader)
        else
          WriteStartConstructor(ConstructorName);
      end;
      TJsonToken.PropertyName:
        WritePropertyName(Reader.Value.AsString);
      TJsonToken.Comment:
        if Reader.Value.IsEmpty then
          WriteComment('')
        else
          WriteComment(Reader.Value.AsString);
      TJsonToken.Raw:
        WriteRawValue(Reader.Value.AsString);
      TJsonToken.Integer:
        if Reader.Value.TypeInfo^.Kind = tkInteger then
          WriteValue(Reader.Value.AsInteger)
        else
          WriteValue(Reader.Value.AsInt64);
      TJsonToken.Float:
        case TRttiFloatType(FRttiCtx.GetType(Reader.Value.TypeInfo)).FloatType of
          ftSingle:
          begin
            S := Reader.Value.AsExtended;
            WriteValue(S);
          end;
          ftDouble:
          begin
            D := Reader.Value.AsExtended;
            WriteValue(D);
          end;
          ftExtended:
          begin
            E := Reader.Value.AsExtended;
            WriteValue(E);
          end;
        end;
      TJsonToken.String:
        WriteValue(Reader.Value.AsString);
      TJsonToken.Boolean:
        WriteValue(Reader.Value.AsBoolean);
      TJsonToken.Null:
        WriteNull;
      TJsonToken.Undefined:
        WriteUndefined;
      TJsonToken.EndObject:
        WriteEndObject;
      TJsonToken.EndArray:
        WriteEndArray;
      TJsonToken.EndConstructor:
        WriteEndConstructor;
      TJsonToken.Date:
      begin
        Date := Reader.Value.AsExtended;
        WriteValue(Date);
      end;
      TJsonToken.Bytes:
        WriteValue(Reader.Value.AsType<TBytes>);
      TJsonToken.Oid:
        WriteValue(Reader.Value.AsType<TJsonOid>);
      TJsonToken.RegEx:
        WriteValue(Reader.Value.AsType<TJsonRegEx>);
      TJsonToken.DBRef:
        WriteValue(Reader.Value.AsType<TJsonDBRef>);
      TJsonToken.CodeWScope:
        WriteValue(Reader.Value.AsType<TJsonCodeWScope>);
      TJsonToken.MinKey:
        WriteMinKey;
      TJsonToken.MaxKey:
        WriteMaxKey;
    end;
    if IsEndToken(Reader.TokenType) then
      DepthOffset := 1
    else
      DepthOffset := 0;
  until not (((InitialDepth - 1) < (Reader.Depth - DepthOffset)) and WriteChildren and Reader.Read);
end;

procedure TJsonWriter.WriteToken(const Reader: TJsonReader; WriteChildren, WriteDateConstructorAsDate: Boolean);
var
  InitialDepth: Integer;
begin
  if Reader.TokenType = TJsonToken.None then
    InitialDepth := -1
  else if not IsStartToken(Reader.TokenType) then
    InitialDepth := Reader.Depth + 1
  else
    InitialDepth := Reader.Depth;

  WriteToken(Reader, InitialDepth, WriteChildren, WriteDateConstructorAsDate);
end;

procedure TJsonWriter.WriteToken(const Reader: TJsonReader; WriteChildren: Boolean);
begin
  WriteToken(Reader, WriteChildren, True);
end;

procedure TJsonWriter.WriteToken(const Reader: TJsonReader);
begin
  WriteToken(Reader, True, True);
end;

procedure TJsonWriter.WriteUndefined;
begin
  InternalWriteValue(TJsonToken.Undefined);
end;

procedure TJsonWriter.WriteValue(Value: UInt64);
begin
  InternalWriteValue(TJsonToken.Integer);
end;

procedure TJsonWriter.WriteValue(Value: Single);
begin
  InternalWriteValue(TJsonToken.Float);
end;

procedure TJsonWriter.WriteValue(Value: Double);
begin
  InternalWriteValue(TJsonToken.Float);
end;

procedure TJsonWriter.WriteValue(Value: Int64);
begin
  InternalWriteValue(TJsonToken.Integer);
end;

procedure TJsonWriter.WriteValue(const Value: string);
begin
  if (Length(Value) = 0) and (EmptyValueHandling = TJsonEmptyValueHandling.Null) then
    WriteNull
  else
    InternalWriteValue(TJsonToken.String);
end;

procedure TJsonWriter.WriteValue(Value: Integer);
begin
  InternalWriteValue(TJsonToken.Integer);
end;

procedure TJsonWriter.WriteValue(Value: UInt32);
begin
  InternalWriteValue(TJsonToken.Integer);
end;

procedure TJsonWriter.WriteValue(Value: Boolean);
begin
  InternalWriteValue(TJsonToken.Boolean);
end;

procedure TJsonWriter.WriteValue(const Value: TGUID);
begin
  InternalWriteValue(TJsonToken.String);
end;

procedure TJsonWriter.WriteValue(const Value: TBytes;
  BinaryType: TJsonBinaryType = TJsonBinaryType.Generic);
begin
  if (Length(Value) = 0) and (EmptyValueHandling = TJsonEmptyValueHandling.Null) then
    WriteNull
  else
    InternalWriteValue(TJsonToken.Bytes);
end;

procedure TJsonWriter.WriteValue(const Value: TJsonOid);
begin
  InternalWriteValue(TJsonToken.Oid);
end;

procedure TJsonWriter.WriteValue(const Value: TJsonRegEx);
begin
  InternalWriteValue(TJsonToken.RegEx);
end;

procedure TJsonWriter.WriteValue(const Value: TJsonDBRef);
begin
  InternalWriteValue(TJsonToken.DBRef);
end;

procedure TJsonWriter.WriteValue(const Value: TJsonCodeWScope);
begin
  InternalWriteValue(TJsonToken.CodeWSCope);
end;

procedure TJsonWriter.WriteMinKey;
begin
  InternalWriteValue(TJsonToken.MinKey);
end;

procedure TJsonWriter.WriteMaxKey;
begin
  InternalWriteValue(TJsonToken.MaxKey);
end;

class procedure TJsonWriter.WriteValue(const Writer: TJsonWriter; const Value: TValue);
var
  S: Single;
  D: Double;
  E: Extended;
  Date: TDateTime;
begin
  if Value.IsEmpty then
    Writer.WriteNull
  else
    case Value.TypeInfo^.Kind of
      tkFloat:
      if Value.TypeInfo = TypeInfo(TDateTime) then
      begin
        Date := Value.AsExtended;
        Writer.WriteValue(Date);
      end
      else
        case TRttiFloatType(FRttiCtx.GetType(Value.TypeInfo)).FloatType of
          ftSingle:
          begin
            S := Value.AsExtended;
            Writer.WriteValue(S);
          end;
          ftDouble:
          begin
            D := Value.AsExtended;
            Writer.WriteValue(D);
          end;
          ftExtended:
          begin
            E := Value.AsExtended;
            Writer.WriteValue(E);
          end;
        end;
      tkInteger:
        Writer.WriteValue(Value.AsInteger);
      tkInt64:
        Writer.WriteValue(Value.AsInt64);
      tkString, tkWChar, tkChar, tkLString, tkWString, tkUString:
        Writer.WriteValue(Value.AsString);
      tkEnumeration:
        if Value.TypeInfo = TypeInfo(Boolean) then
          Writer.WriteValue(Value.AsBoolean)
        else
          Writer.WriteValue(GetEnumName(Value.TypeInfo, PInteger(Value.GetReferenceToRawData)^));
      tkUnknown, tkSet, tkClass, tkMethod, tkDynArray, tkVariant,
      tkArray, tkRecord, tkInterface, tkClassRef, tkPointer, tkProcedure:
        raise EJsonWriterException.Create(Writer, Format(SUnsupportedType,
          [GetEnumName(TypeInfo(TTypeKind), Integer(Value.TypeInfo^.Kind))]));
    end;
end;

procedure TJsonWriter.WriteValue(Value: Char);
begin
  InternalWriteValue(TJsonToken.String);
end;

procedure TJsonWriter.WriteValue(Value: Byte);
begin
  InternalWriteValue(TJsonToken.Integer);
end;

procedure TJsonWriter.WriteValue(Value: TDateTime);
begin
  InternalWriteValue(TJsonToken.Date);
end;

procedure TJsonWriter.WriteValue(Value: Extended);
begin
  InternalWriteValue(TJsonToken.Float);
end;

procedure TJsonWriter.WriteValue(const Value: TValue);
begin
  WriteValue(Self, Value);
end;

{ TJsonTextWriter }

procedure TJsonTextWriter.OnBeforeWriteToken(TokenBeginWritten: TJsonToken);
begin
  // Delimiter
  case TokenBeginWritten of
    TJsonToken.EndObject,
    TJsonToken.EndArray,
    TJsonToken.EndConstructor,
    TJsonToken.Comment:
      // skip delimiter
    else
      case FCurrentState of
        TState.Object,
        TState.Array,
        TState.Constructor:
          WriteValueDelimiter;
      end;
  end;

  // Formatting if required
  if FFormatting = TJsonFormatting.Indented then
  begin
    // don't indent a property when it is the first token to be written (i.e. at the start)
    if FCurrentState = TState.Property then
      WriteIndentSpace;

    // skip indentation in empty arrays, objects and constructors
    case TokenBeginWritten of
      TJsonToken.EndArray:
        if FCurrentState = TState.ArrayStart then Exit;
      TJsonToken.EndObject:
        if FCurrentState = TState.ObjectStart then Exit;
      TJsonToken.EndConstructor:
        if FCurrentState = TState.ConstructorStart then Exit;
    end;

    case FCurrentState of
      TState.Array,
      TState.ArrayStart,
      TState.ObjectStart,
      TState.Object,
      TState.Constructor,
      TState.ConstructorStart:
        WriteIndent;
      TState.Start:
        if TokenBeginWritten = TJsonToken.PropertyName then
          WriteIndent;
    end;
  end;
end;

procedure TJsonTextWriter.Close;
begin
  inherited Close;
  if CloseOutput and (FWriter <> nil) then
    FWriter.Close;
end;

constructor TJsonTextWriter.Create(const TextWriter: TTextWriter);
begin
  FWriter := TextWriter;
  FQuoteChar := '"';
  FQuoteName := True;
  FIndentChar := ' ';
  FIndentation := 2;
  FFormatting := TJsonFormatting.None;
  UpdateCharEscapeFlags;
  FormatSettings := JSONFormatSettings;
  FFloatFormatHandling := TJsonFloatFormatHandling.Symbol;
  FDateTimeZoneHandling := TJsonDateTimeZoneHandling.Local;
  FDateFormatHandling := TJsonDateFormatHandling.Iso;
  FExtendedJsonMode := TJsonExtendedJsonMode.None;
  inherited Create;
end;

procedure TJsonTextWriter.EnsureBufferSize;
begin
  if Length(FWriterBuffer) = 0 then
    SetLength(FWriterBuffer, 64);
end;

procedure TJsonTextWriter.Flush;
begin
  FWriter.Flush;
end;

procedure TJsonTextWriter.SetIndentation(Value: Integer);
begin
  if Value < 0 then
    raise EArgumentException.Create(SIdentationGreaterThanZero);
  FIndentation := Value;
end;

procedure TJsonTextWriter.SetQuoteChar(Value: Char);
begin
  if (Value <> '"') and (Value <> '''') then
    raise EArgumentException.Create(SInvalidJavascriptQuote);
  FQuoteChar := Value;
  UpdateCharEscapeFlags;
end;

procedure TJsonTextWriter.SetStringEscapeHandling(Value: TJsonStringEscapeHandling);
begin
  FStringEscapeHandling := Value;
  UpdateCharEscapeFlags;
end;

procedure TJsonTextWriter.UpdateCharEscapeFlags;
begin
  if StringEscapeHandling = TJsonStringEscapeHandling.EscapeHtml then
    FCharEscapeFlags := TJsonTextUtils.HtmlCharEscapeFlags
  else if FQuoteChar = '"' then
    FCharEscapeFlags := TJsonTextUtils.DoubleQuoteCharEscapeFlags
  else
    FCharEscapeFlags := TJsonTextUtils.SingleQuoteCharEscapeFlags;
end;

procedure TJsonTextWriter.WriteComment(const Comment: string);
begin
  InternalWriteComment;
  FWriter.Write('/*');
  FWriter.Write(Comment);
  FWriter.Write('*/');
end;

procedure TJsonTextWriter.WriteEnd(const Token: TJsonToken);
begin
  case Token of
    TJsonToken.EndObject:
      FWriter.Write('}');
    TJsonToken.EndArray:
      FWriter.Write(']');
    TJsonToken.EndConstructor:
      FWriter.Write(')');
    else
      raise EJsonWriterException.Create(Self, Format(SInvalidJsonToken, [GetName(Token)]));
  end;
end;

procedure TJsonTextWriter.WriteEscapedString(const Value: string; Quote: Boolean);
begin
  EnsureBufferSize;
  TJsonTextUtils.WriteEscapedString(FWriter, Value, FQuoteChar, Quote,
    FCharEscapeFlags, StringEscapeHandling, TCharArray(FWriterBuffer));
end;

procedure TJsonTextWriter.WriteIndent;
var
  CurrentIndentCount, WriteCount: Integer;
begin
  FWriter.WriteLine;
  CurrentIndentCount := Top * FIndentation;
  while CurrentIndentCount > 0 do
  begin
    WriteCount := Min(CurrentIndentCount, 10);
    FWriter.Write(string.Create(FIndentChar, WriteCount));
    Dec(CurrentIndentCount, WriteCount);
  end;
end;

procedure TJsonTextWriter.WriteIndentSpace;
begin
  FWriter.Write(' ');
end;

procedure TJsonTextWriter.WriteNull;
begin
  InternalWriteValue(TJsonToken.Null);
  WriteValueInternal(kNull, TJsonToken.Null);
end;

procedure TJsonTextWriter.WritePropertyName(const Name: string; Escape: Boolean);
begin
  InternalWritePropertyName(Name);

  if Escape then
    WriteEscapedString(Name, FQuoteName)
  else
  begin
    if FQuoteName then
      FWriter.Write(FQuoteChar);

    FWriter.Write(Name);

    if FQuoteName then
      FWriter.Write(FQuoteChar);
  end;

  FWriter.Write(':');
end;

procedure TJsonTextWriter.WritePropertyName(const Name: string);
begin
  InternalWritePropertyName(Name);
  WriteEscapedString(Name, FQuoteName);
  FWriter.Write(':');
end;

procedure TJsonTextWriter.WriteRaw(const Json: string);
begin
  FWriter.Write(Json);
end;

procedure TJsonTextWriter.WriteStartArray;
begin
  InternalWriteStart(TJsonToken.StartArray, TJsonContainerType.Array);
  FWriter.Write('[');
end;

procedure TJsonTextWriter.WriteStartConstructor(const Name: string);
begin
  InternalWriteStart(TJsonToken.StartConstructor, TJsonContainerType.&Constructor);
  FWriter.Write('new ');
  FWriter.Write(Name);
  FWriter.Write('(');
end;

procedure TJsonTextWriter.WriteStartObject;
begin
  InternalWriteStart(TJsonToken.StartObject, TJsonContainerType.Object);
  FWriter.Write('{');
end;

procedure TJsonTextWriter.WriteUndefined;
begin
  inherited WriteUndefined;
  case ExtendedJsonMode of
    TJsonExtendedJsonMode.None,
    TJsonExtendedJsonMode.MongoShell:
      WriteValueInternal(kUndefined, TJsonToken.Undefined);
    TJsonExtendedJsonMode.StrictMode:
      begin
        FWriter.Write('{');
        FWriter.Write(FQuoteChar);
        FWriter.Write(JsonExtUndefinedPropertyName);
        FWriter.Write(FQuoteChar);
        FWriter.Write(':');
        FWriter.Write(kTrue);
        FWriter.Write('}');
      end;
  end;
end;

procedure TJsonTextWriter.WriteValue(const Value: string);
begin
  inherited WriteValue(Value);
  if (Length(Value) = 0) and (EmptyValueHandling = TJsonEmptyValueHandling.Null) then
    Exit;
  WriteEscapedString(Value, True);
end;

procedure TJsonTextWriter.WriteValue(const Value: TValue);
begin
  WriteValue(Self, Value);
end;

procedure TJsonTextWriter.WriteValue(Value: Extended);
var
  Str: string;
begin
  inherited WriteValue(Value);

  if Value.IsPositiveInfinity then
    Str := kPositiveInfinity
  else if Value.IsNegativeInfinity then
    Str := kNegativeInfinity
  else if Value.IsNan then
    Str := kNaN
  else
    Str := FloatToStr(Value, FFormatSettings);

  if (FloatFormatHandling = TJsonFloatFormatHandling.Symbol) or not (Value.IsInfinity or Value.IsNan) then
    // nothing
  else
    if FloatFormatHandling = TJsonFloatFormatHandling.DefaultValue then
      Str := '0.0'
    else
      Str := QuoteChar + Str + QuoteChar;
  FWriter.Write(Str);
end;

procedure TJsonTextWriter.WriteValue(Value: Single);
var
  Str: string;
begin
  inherited WriteValue(Value);

  if Value.IsPositiveInfinity then
    Str := kPositiveInfinity
  else if Value.IsNegativeInfinity then
    Str := kNegativeInfinity
  else if Value.IsNan then
    Str := kNaN
  else
    Str := FloatToStr(Value, FFormatSettings);

  if (FloatFormatHandling = TJsonFloatFormatHandling.Symbol) or not (Value.IsInfinity or Value.IsNan) then
    // nothing
  else
    if FloatFormatHandling = TJsonFloatFormatHandling.DefaultValue then
      Str := '0.0'
    else
      Str := QuoteChar + Str + QuoteChar;
  FWriter.Write(Str);
end;

procedure TJsonTextWriter.WriteValue(Value: Double);
var
  Str: string;
begin
  inherited WriteValue(Value);

  if Value.IsPositiveInfinity then
    Str := kPositiveInfinity
  else if Value.IsNegativeInfinity then
    Str := kNegativeInfinity
  else if Value.IsNan then
    Str := kNaN
  else
    Str := FloatToStr(Value, FFormatSettings);

  if (FloatFormatHandling = TJsonFloatFormatHandling.Symbol) or not (Value.IsInfinity or Value.IsNan) then
    // nothing
  else
    if FloatFormatHandling = TJsonFloatFormatHandling.DefaultValue then
      Str := '0.0'
    else
      Str := QuoteChar + Str + QuoteChar;
  FWriter.Write(Str);
end;

procedure TJsonTextWriter.WriteValue(Value: Boolean);
begin
  inherited WriteValue(Value);
  if Value then
    FWriter.Write(kTrue)
  else
    FWriter.Write(kFalse);
end;

procedure TJsonTextWriter.WriteValue(Value: UInt32);
begin
  inherited WriteValue(Value);
  FWriter.Write(UIntToStr(Value));
end;

procedure TJsonTextWriter.WriteNumberLong(const ANum: string);
begin
  case ExtendedJsonMode of
    TJsonExtendedJsonMode.None:
      FWriter.Write(ANum);
    TJsonExtendedJsonMode.StrictMode:
      begin
        FWriter.Write('{');
        FWriter.Write(FQuoteChar);
        FWriter.Write(JsonExtNumberLongPropertyName);
        FWriter.Write(FQuoteChar);
        FWriter.Write(':');
        FWriter.Write(FQuoteChar);
        FWriter.Write(ANum);
        FWriter.Write(FQuoteChar);
        FWriter.Write('}');
      end;
    TJsonExtendedJsonMode.MongoShell:
      begin
        FWriter.Write('NumberLong(');
        FWriter.Write(FQuoteChar);
        FWriter.Write(ANum);
        FWriter.Write(FQuoteChar);
        FWriter.Write(')');
      end;
  end;
end;

procedure TJsonTextWriter.WriteValue(Value: Int64);
begin
  inherited WriteValue(Value);
  WriteNumberLong(IntToStr(Value));
end;

procedure TJsonTextWriter.WriteValue(Value: UInt64);
begin
  inherited WriteValue(Value);
  WriteNumberLong(UIntToStr(Value));
end;

procedure TJsonTextWriter.WriteValue(const Value: TGUID);
begin
  inherited WriteValue(Value);
  FWriter.Write(FQuoteChar);
  FWriter.Write(Value.ToString);
  FWriter.Write(FQuoteChar);
end;

procedure TJsonTextWriter.WriteValue(const Value: TBytes;
  BinaryType: TJsonBinaryType = TJsonBinaryType.Generic);
var
  LBase64: string;
begin
  inherited WriteValue(Value);
  if (Length(Value) = 0) and (EmptyValueHandling = TJsonEmptyValueHandling.Null) then
    Exit;
  LBase64 := TNetEncoding.Base64.EncodeBytesToString(Value);
  case ExtendedJsonMode of
    TJsonExtendedJsonMode.None:
      begin
        FWriter.Write(FQuoteChar);
        FWriter.Write(LBase64);
        FWriter.Write(FQuoteChar);
      end;
    TJsonExtendedJsonMode.StrictMode:
      begin
        FWriter.Write('{');
        FWriter.Write(FQuoteChar);
        FWriter.Write(JsonExtBinaryPropertyName);
        FWriter.Write(FQuoteChar);
        FWriter.Write(':');
        FWriter.Write(FQuoteChar);
        FWriter.Write(LBase64);
        FWriter.Write(FQuoteChar);
        FWriter.Write(',');
        FWriter.Write(FQuoteChar);
        FWriter.Write(JsonExtTypePropertyName);
        FWriter.Write(FQuoteChar);
        FWriter.Write(':');
        FWriter.Write(FQuoteChar);
        FWriter.Write(IntToStr(Integer(BinaryType)));
        FWriter.Write(FQuoteChar);
        FWriter.Write('}');
      end;
    TJsonExtendedJsonMode.MongoShell:
      begin
        FWriter.Write('BinData(');
        FWriter.Write(IntToStr(Integer(BinaryType)));
        FWriter.Write(',');
        FWriter.Write(FQuoteChar);
        FWriter.Write(LBase64);
        FWriter.Write(FQuoteChar);
        FWriter.Write(')');
      end;
  end;
end;

procedure TJsonTextWriter.WriteValue(const Value: TJsonOid);
begin
  InternalWriteValue(TJsonToken.Oid);
  case ExtendedJsonMode of
    TJsonExtendedJsonMode.None:
      begin
        FWriter.Write(FQuoteChar);
        FWriter.Write(Value.AsString);
        FWriter.Write(FQuoteChar);
      end;
    TJsonExtendedJsonMode.StrictMode:
      begin
        FWriter.Write('{');
        FWriter.Write(FQuoteChar);
        FWriter.Write(JsonExtOidPropertyName);
        FWriter.Write(FQuoteChar);
        FWriter.Write(':');
        FWriter.Write(FQuoteChar);
        FWriter.Write(Value.AsString);
        FWriter.Write(FQuoteChar);
        FWriter.Write('}');
      end;
    TJsonExtendedJsonMode.MongoShell:
      begin
        FWriter.Write('ObjectId(');
        FWriter.Write(FQuoteChar);
        FWriter.Write(Value.AsString);
        FWriter.Write(FQuoteChar);
        FWriter.Write(')');
      end;
  end;
end;


procedure TJsonTextWriter.WriteValue(Value: Char);
begin
  InternalWriteValue(TJsonToken.String);
  WriteEscapedString(Value, True);
end;

procedure TJsonTextWriter.WriteValue(Value: Byte);
begin
  InternalWriteValue(TJsonToken.Integer);
  FWriter.Write(UIntToStr(Value));
end;

procedure TJsonTextWriter.WriteValue(Value: TDateTime);
begin
  InternalWriteValue(TJsonToken.Date);
  case ExtendedJsonMode of
    TJsonExtendedJsonMode.None:
      begin
        FWriter.Write(QuoteChar);
        case DateFormatHandling of
          TJsonDateFormatHandling.Iso:
            if DateTimeZoneHandling = TJsonDateTimeZoneHandling.Local then
              FWriter.Write(DateToISO8601(Value, False))
            else
              FWriter.Write(DateToISO8601(Value, True));
          TJsonDateFormatHandling.Unix:
            if DateTimeZoneHandling = TJsonDateTimeZoneHandling.Local then
              FWriter.Write(DateTimeToUnix(Value, False))
            else
              FWriter.Write(DateTimeToUnix(Value, True));
          TJsonDateFormatHandling.FormatSettings:
            if DateTimeZoneHandling = TJsonDateTimeZoneHandling.Local then
              FWriter.Write(DateTimeToStr(TTimezone.Local.ToLocalTime(Value), FormatSettings))
            else
              FWriter.Write(DateTimeToStr(Value, FormatSettings));
        end;
        FWriter.Write(QuoteChar);
      end;
    TJsonExtendedJsonMode.StrictMode:
      begin
        FWriter.Write('{');
        FWriter.Write(FQuoteChar);
        FWriter.Write(JsonExtDatePropertyName);
        FWriter.Write(FQuoteChar);
        FWriter.Write(':');
        FWriter.Write(FQuoteChar);
        if DateTimeZoneHandling = TJsonDateTimeZoneHandling.Local then
          FWriter.Write(DateToISO8601(Value, False))
        else
          FWriter.Write(DateToISO8601(Value, True));
        FWriter.Write(FQuoteChar);
        FWriter.Write('}');
      end;
    TJsonExtendedJsonMode.MongoShell:
      begin
        FWriter.Write('ISODate(');
        FWriter.Write(FQuoteChar);
        if DateTimeZoneHandling = TJsonDateTimeZoneHandling.Local then
          FWriter.Write(DateToISO8601(Value, False))
        else
          FWriter.Write(DateToISO8601(Value, True));
        FWriter.Write(FQuoteChar);
        FWriter.Write(')');
      end;
  end;
end;

procedure TJsonTextWriter.WriteValue(Value: Integer);
begin
  InternalWriteValue(TJsonToken.Integer);
  FWriter.Write(IntToStr(Value));
end;

procedure TJsonTextWriter.WriteValue(const Value: TJsonRegEx);
begin
  InternalWriteValue(TJsonToken.RegEx);
  case ExtendedJsonMode of
    TJsonExtendedJsonMode.None,
    TJsonExtendedJsonMode.MongoShell:
      begin
                                                                          
                                                                      
        FWriter.Write(FQuoteChar);
        FWriter.Write('/');
        WriteEscapedString(Value.RegEx, False);
        FWriter.Write('/');
        WriteEscapedString(Value.Options, False);
        FWriter.Write(FQuoteChar);
      end;
    TJsonExtendedJsonMode.StrictMode:
      begin
        FWriter.Write('{');
        FWriter.Write(FQuoteChar);
        FWriter.Write(JsonExtRegexPropertyName);
        FWriter.Write(FQuoteChar);
        FWriter.Write(':');
        WriteEscapedString(Value.RegEx, True);
        FWriter.Write(',');
        FWriter.Write(FQuoteChar);
        FWriter.Write(JsonExtOptionsPropertyName);
        FWriter.Write(FQuoteChar);
        FWriter.Write(':');
        WriteEscapedString(Value.Options, True);
        FWriter.Write('}');
      end;
  end;
end;

procedure TJsonTextWriter.WriteValue(const Value: TJsonDBRef);
begin
  InternalWriteValue(TJsonToken.DBRef);
  case ExtendedJsonMode of
    TJsonExtendedJsonMode.None:
      begin
        FWriter.Write(FQuoteChar);
        if Value.DB <> '' then begin
          FWriter.Write(Value.DB);
          FWriter.Write('.');
        end;
        FWriter.Write(Value.Ref);
        FWriter.Write('.');
        FWriter.Write(Value.Id.AsString);
        FWriter.Write(FQuoteChar);
      end;
    TJsonExtendedJsonMode.StrictMode:
      begin
        FWriter.Write('{');
        FWriter.Write(FQuoteChar);
        FWriter.Write(JsonExtRefPropertyName);
        FWriter.Write(FQuoteChar);
        FWriter.Write(':');
        FWriter.Write(FQuoteChar);
        FWriter.Write(Value.Ref);
        FWriter.Write(FQuoteChar);
        FWriter.Write(',');
        FWriter.Write(FQuoteChar);
        FWriter.Write(JsonExtIdPropertyName);
        FWriter.Write(FQuoteChar);
        FWriter.Write(':');
        FWriter.Write(FQuoteChar);
        FWriter.Write(Value.Id.AsString);
        FWriter.Write(FQuoteChar);
        if Value.DB <> '' then begin
          FWriter.Write(',');
          FWriter.Write(FQuoteChar);
          FWriter.Write(JsonExtDbPropertyName);
          FWriter.Write(FQuoteChar);
          FWriter.Write(':');
          FWriter.Write(FQuoteChar);
          FWriter.Write(Value.DB);
          FWriter.Write(FQuoteChar);
        end;
        FWriter.Write('}');
      end;
    TJsonExtendedJsonMode.MongoShell:
      begin
        FWriter.Write('DBRef(');
        FWriter.Write(FQuoteChar);
        FWriter.Write(Value.Ref);
        FWriter.Write(FQuoteChar);
        FWriter.Write(',');
        FWriter.Write(FQuoteChar);
        FWriter.Write(Value.Id.AsString);
        FWriter.Write(FQuoteChar);
        FWriter.Write(')');
      end;
  end;
end;

procedure TJsonTextWriter.WriteValue(const Value: TJsonCodeWScope);
var
  i: Integer;
begin
  InternalWriteValue(TJsonToken.CodeWScope);
  case ExtendedJsonMode of
    TJsonExtendedJsonMode.None,
    TJsonExtendedJsonMode.MongoShell:
      begin
        FWriter.Write(FQuoteChar);
        FWriter.Write(Value.Code);
        FWriter.Write(FQuoteChar);
      end;
    TJsonExtendedJsonMode.StrictMode:
      begin
        FWriter.Write('{');
        FWriter.Write(FQuoteChar);
        FWriter.Write(JsonExtCodePropertyName);
        FWriter.Write(FQuoteChar);
        FWriter.Write(':');
        FWriter.Write(FQuoteChar);
        FWriter.Write(Value.Code);
        FWriter.Write(FQuoteChar);
        if Length(Value.Scope) > 0 then begin
          FWriter.Write(',');
          FWriter.Write(FQuoteChar);
          FWriter.Write(JsonExtScopePropertyName);
          FWriter.Write(FQuoteChar);
          FWriter.Write(':');
          FWriter.Write('{');
          for i := 0 to Length(Value.Scope) - 1 do begin
            FWriter.Write(FQuoteChar);
            FWriter.Write(Value.Scope[i].ident);
            FWriter.Write(FQuoteChar);
            FWriter.Write(':');
            FWriter.Write(FQuoteChar);
            FWriter.Write(Value.Scope[i].value);
            FWriter.Write(FQuoteChar);
          end;
          FWriter.Write('}');
        end;
        FWriter.Write('}');
      end;
  end;
end;

procedure TJsonTextWriter.WriteMinKey;
begin
  InternalWriteValue(TJsonToken.MinKey);
  case ExtendedJsonMode of
    TJsonExtendedJsonMode.None,
    TJsonExtendedJsonMode.MongoShell:
      FWriter.Write('MinKey');
    TJsonExtendedJsonMode.StrictMode:
      begin
        FWriter.Write('{');
        FWriter.Write(FQuoteChar);
        FWriter.Write(JsonExtMinKeyPropertyName);
        FWriter.Write(FQuoteChar);
        FWriter.Write(':');
        FWriter.Write('1');
        FWriter.Write('}');
      end;
  end;
end;

procedure TJsonTextWriter.WriteMaxKey;
begin
  InternalWriteValue(TJsonToken.MaxKey);
  case ExtendedJsonMode of
    TJsonExtendedJsonMode.None,
    TJsonExtendedJsonMode.MongoShell:
      FWriter.Write('MaxKey');
    TJsonExtendedJsonMode.StrictMode:
      begin
        FWriter.Write('{');
        FWriter.Write(FQuoteChar);
        FWriter.Write(JsonExtMaxKeyPropertyName);
        FWriter.Write(FQuoteChar);
        FWriter.Write(':');
        FWriter.Write('1');
        FWriter.Write('}');
      end;
  end;
end;

procedure TJsonTextWriter.WriteValueDelimiter;
begin
  FWriter.Write(',');
end;

procedure TJsonTextWriter.WriteValueInternal(const Value: string; Token: TJsonToken);
begin
  FWriter.Write(Value);
end;

procedure TJsonTextWriter.WriteWhitespace(const Ws: string);
begin
  if not TJsonTextUtils.IsWhiteSpace(Ws) then
    raise EJsonWriterException.Create(Self, SWhitespaceOnly);
  FWriter.Write(Ws);
end;

{ TJsonObjectWriter }

procedure TJsonObjectWriter.AppendContainer(const JSONValue: TJSONValue);
begin
  AppendValue(JSONValue);
  FContainerStack.Push(JSONValue);
end;

procedure TJsonObjectWriter.AppendValue(const JsonValue: TJSONValue);
var
  LParent: TJSONAncestor;
begin
  if FRoot = nil then
    FRoot := JsonValue
  else
  begin
    if FContainerStack.Count = 0 then
    begin
      if FOwnValue then
        FRoot.Free;
      FRoot := JsonValue;
    end;
  end;

  if FContainerStack.Count > 0 then
  begin
    LParent := FContainerStack.Peek;
    if LParent is TJSONPair then
    begin
      TJSONPair(LParent).JsonValue := JsonValue;
      FContainerStack.Pop;
    end
    else if LParent is TJSONArray then
      TJSONArray(LParent).AddElement(JsonValue)
  end;
end;

constructor TJsonObjectWriter.Create(OwnValue: Boolean);
begin
  inherited Create;
  FOwnValue := OwnValue;
  FContainerStack := TStack<TJSONAncestor>.Create;
  FDateFormatHandling := TJsonDateFormatHandling.Iso;
  FDateTimeZoneHandling := TJsonDateTimeZoneHandling.Local;
end;

destructor TJsonObjectWriter.Destroy;
begin
  if FCurrentState <> TState.Closed then
    Close;
  FContainerStack.Free;
  if FOwnValue and (FRoot <> nil) then
    FRoot.Free;
  inherited Destroy;
end;

procedure TJsonObjectWriter.Rewind;
begin
  inherited;
  FContainerStack.Clear;
  if FOwnValue and (FRoot <> nil) then
    FRoot.Free;
  FRoot := nil;
end;

procedure TJsonObjectWriter.WriteEnd(const Token: TJsonToken);
begin
  case Token of
    TJsonToken.EndObject,
    TJsonToken.EndArray:
      FContainerStack.Pop;
    else
      raise EJsonWriterException.Create(Self, Format(SInvalidJsonToken, [GetName(Token)]));
  end;
end;

procedure TJsonObjectWriter.WriteNull;
begin
  inherited WriteNull;
  AppendValue(TJSONNull.Create);
end;

procedure TJsonObjectWriter.WritePropertyName(const Name: string);
var
  JSONPair: TJSONPair;
begin
  inherited WritePropertyName(Name);
  JSONPair := TJSONPair.Create(Name, nil);
  if FRoot = nil then
    FRoot := JSONPair
  else
    TJSONObject(FContainerStack.Peek).AddPair(JSONPair);
  FContainerStack.Push(JSONPair);
end;

procedure TJsonObjectWriter.WriteRaw(const Json: string);
begin
  raise EJsonWriterException.Create(SUnsupportedJSONValueRaw);
end;

procedure TJsonObjectWriter.WriteRawValue(const Json: string);
begin
  raise EJsonWriterException.Create(SUnsupportedJSONValueRaw);
end;

procedure TJsonObjectWriter.WriteStartArray;
begin
  inherited WriteStartArray;
  AppendContainer(TJSONArray.Create);
end;

procedure TJsonObjectWriter.WriteStartConstructor(const Name: string);
begin
  raise EJsonWriterException.Create(SUnsupportedJSONValueConstructor);
end;

procedure TJsonObjectWriter.WriteStartObject;
begin
  inherited WriteStartObject;
  AppendContainer(TJSONObject.Create);
end;

procedure TJsonObjectWriter.WriteUndefined;
begin
  WriteNull;
end;

procedure TJsonObjectWriter.WriteValue(Value: Int64);
begin
  inherited WriteValue(Value);
  AppendValue(TJSONNumber.Create(Value));
end;

procedure TJsonObjectWriter.WriteValue(Value: UInt64);
begin
  inherited WriteValue(Value);
  AppendValue(TJSONNumber.Create(Value));
end;

procedure TJsonObjectWriter.WriteValue(Value: Single);
begin
  inherited WriteValue(Value);
  AppendValue(TJSONNumber.Create(Value));
end;

procedure TJsonObjectWriter.WriteValue(const Value: string);
begin
  inherited WriteValue(Value);
  if (Length(Value) = 0) and (EmptyValueHandling = TJsonEmptyValueHandling.Null) then
    Exit;
  AppendValue(TJSONString.Create(Value));
end;

procedure TJsonObjectWriter.WriteValue(Value: Integer);
begin
  inherited WriteValue(Value);
  AppendValue(TJSONNumber.Create(Value));
end;

procedure TJsonObjectWriter.WriteValue(Value: UInt32);
begin
  inherited WriteValue(Value);
  AppendValue(TJSONNumber.Create(Value));
end;

procedure TJsonObjectWriter.WriteValue(Value: Double);
begin
  inherited WriteValue(Value);
  AppendValue(TJSONNumber.Create(Value));
end;

procedure TJsonObjectWriter.WriteValue(const Value: TGUID);
begin
  inherited WriteValue(Value);
  AppendValue(TJSONString.Create(Value.ToString));
end;

procedure TJsonObjectWriter.WriteValue(Value: TDateTime);
var
  StrDate: string;
  IntDate: Int64;
begin
  inherited WriteValue(Value);
  StrDate := '';
  case DateFormatHandling of
    TJsonDateFormatHandling.Iso:
    begin
      if DateTimeZoneHandling = TJsonDateTimeZoneHandling.Local then
        StrDate := DateToISO8601(Value, False)
      else
        StrDate := DateToISO8601(Value, True);
      AppendValue(TJSONString.Create(StrDate));
    end;

    TJsonDateFormatHandling.Unix:
    begin
      if DateTimeZoneHandling = TJsonDateTimeZoneHandling.Local then
        IntDate := DateTimeToUnix(Value, False)
      else
        IntDate := DateTimeToUnix(Value, True);
        AppendValue(TJSONNumber.Create(IntDate));
    end;

    TJsonDateFormatHandling.FormatSettings:
    begin
      if DateTimeZoneHandling = TJsonDateTimeZoneHandling.Local then
        StrDate := DateTimeToStr(TTimezone.Local.ToLocalTime(Value), FormatSettings)
      else
        StrDate := DateTimeToStr(Value, FormatSettings);
      AppendValue(TJSONString.Create(StrDate));
    end;
  end;
end;

procedure TJsonObjectWriter.WriteValue(const Value: TBytes; BinaryType: TJsonBinaryType = TJsonBinaryType.Generic);
begin
  inherited WriteValue(Value, BinaryType);
                                                 
  if (Length(Value) = 0) and (EmptyValueHandling = TJsonEmptyValueHandling.Null) then
    Exit;
  AppendValue(TJSONString.Create(TNetEncoding.Base64.EncodeBytesToString(Value)));
end;

procedure TJsonObjectWriter.WriteValue(Value: Boolean);
begin
  inherited WriteValue(Value);
  AppendValue(TJSONBool.Create(Value));
end;

procedure TJsonObjectWriter.WriteValue(Value: Extended);
begin
  inherited WriteValue(Value);
  AppendValue(TJSONNumber.Create(Value));
end;

procedure TJsonObjectWriter.WriteValue(Value: Byte);
begin
  inherited WriteValue(Value);
  AppendValue(TJSONNumber.Create(Value));
end;

procedure TJsonObjectWriter.WriteValue(Value: Char);
begin
  inherited WriteValue(Value);
  AppendValue(TJSONString.Create(Value));
end;

procedure TJsonObjectWriter.WriteValue(const Value: TJsonRegEx);
begin
  inherited WriteValue(Value);
  WriteStartObject;
    WritePropertyName(JsonExtRegexPropertyName);
    WriteValue(Value.RegEx);
    WritePropertyName(JsonExtOptionsPropertyName);
    WriteValue(Value.Options);
  WriteEnd(TJsonToken.EndObject);
end;

procedure TJsonObjectWriter.WriteValue(const Value: TJsonOid);
begin
  inherited WriteValue(Value);
  WriteStartObject;
    WritePropertyName(JsonExtOidPropertyName);
    WriteValue(Value.AsBytes);
  WriteEnd(TJsonToken.EndObject);
end;

procedure TJsonObjectWriter.WriteValue(const Value: TJsonCodeWScope);
var
  I: Integer;
begin
  inherited WriteValue(Value);
  WriteStartObject;
    WritePropertyName(JsonExtCodePropertyName);
    WriteValue(Value.Code);
    if Length(Value.Scope) > 0 then
    begin
      WritePropertyName(JsonExtScopePropertyName);
      WriteStartObject;
        for I := 0 to Length(Value.Scope) do
        begin
          WritePropertyName(Value.Scope[I].Ident);
          WriteValue(Value.Scope[I].Value);
        end;
      WriteEnd(TJsonToken.EndObject);
    end;
  WriteEnd(TJsonToken.EndObject);
end;

procedure TJsonObjectWriter.WriteValue(const Value: TJsonDBRef);
begin
  inherited WriteValue(Value);
  WriteStartObject;
    WritePropertyName(JsonExtRefPropertyName);
    WriteValue(Value.Ref);
    WritePropertyName(JsonExtIdPropertyName);
    WriteValue(Value.Id.AsBytes);
    if Value.DB <> '' then
    begin
      WritePropertyName(JsonExtDbPropertyName);
      WriteValue(Value.DB);
    end;
  WriteEnd(TJsonToken.EndObject);
end;

procedure TJsonObjectWriter.WriteMinKey;
begin
  inherited WriteMinKey;
  WriteStartObject;
    WritePropertyName(JsonExtMinKeyPropertyName);
    WriteValue(1);
  WriteEnd(TJsonToken.EndObject);
end;

procedure TJsonObjectWriter.WriteMaxKey;
begin
  inherited WriteMinKey;
  WriteStartObject;
    WritePropertyName(JsonExtMaxKeyPropertyName);
    WriteValue(1);
  WriteEnd(TJsonToken.EndObject);
end;

end.
