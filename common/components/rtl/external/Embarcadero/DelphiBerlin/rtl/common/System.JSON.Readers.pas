{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.JSON.Readers;

interface

{$SCOPEDENUMS ON}

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.Rtti,
  System.JSON.Types, System.JSON.Utils;

type
  /// <summary>
  /// Base class that provides logic to access to serialized JSON data.
  /// </summary>
  TJsonReader = class(TJsonLineInfo)
  public type
    /// <summary> State of the reader.  </summary>
    TState = (Start, Complete, &Property, ObjectStart, &Object, ArrayStart,
      &Array, Closed, PostValue, ConstructorStart, &Constructor, Error, Finished);
  public type
    /// <summary> State of the reader.  </summary>
    TReadType = (Read, ReadAsInteger, ReadAsBytes, ReadAsString, ReadAsDouble,
      ReadAsDateTime, ReadAsOid);
  const
    DefIntegerVal: Integer = 0;
    DefDateTimeVal: TDateTime = 0;
    DefDoubleVal: Double = 0;
    DefStringVal: string = '';
    DefBytesVal = nil;
    DefBooleanVal: Boolean = False;
  private
    FTokenType: TJsonToken;
    FValue: TValue;
    FQuoteChar: Char;
    FReadType: TReadType;
    FCurrentPosition: TJsonPosition;
    FFormatSettings: TFormatSettings;
    FDateTimeZoneHandling: TJsonDateTimeZoneHandling;
    FMaxDepth: Integer;
    FHasExceededMaxDepth: Boolean;
    FStack: TList<TJsonPosition>;
    FCloseInput: Boolean;
    FSupportMultipleContent: Boolean;
    function GetTypeForCloseToken(Token: TJsonToken): TJsonContainerType;
    procedure Push(AValue: TJsonContainerType);
    function Pop: TJsonContainerType;
    function Peek: TJsonContainerType; inline;
    procedure SetFinished;
    procedure UpdateScopeWithFinishedValue;
    procedure ValidateEnd(EndToken: TJsonToken);
    procedure ReaderError(const Msg: string); overload;
    procedure ReaderError(const Msg, Param1: string); overload;
    procedure ReaderError(const Msg, Param1, Param2: string); overload;
  protected
    /// <summary> Variable for CurrentState </summary>
    FCurrentState: TState;
    /// <summary>
    /// Sets the state based on current token type.
    /// </summary>
    procedure SetStateBasedOnCurrent;
    function GetPath: string; virtual;
    function GetQuotedChar: Char; virtual;
    procedure SetQuotedChar(Value: Char); virtual;
    procedure SetMaxDepth(Value: Integer);
    function GetDepth: Integer; virtual;
    /// <summary> Implementation for ReadAsBytes function </summary>
    function ReadAsBytesInternal: TBytes;
    /// <summary> Implementation for ReadAsDateTime function </summary>
    function ReadAsDateTimeInternal: TDateTime;
    /// <summary> Implementation for ReadAsDouble function </summary>
    function ReadAsDoubleInternal: Double;
    /// <summary> Implementation for ReadAsInteger function </summary>
    function ReadAsIntegerInternal: Integer;
    /// <summary> Implementation for ReadAsInt64 function </summary>
    function ReadAsInt64Internal: Int64;
    /// <summary> Implementation for ReadAsString function </summary>
    function ReadAsStringInternal: string;
    /// <summary> Implementation for Read function </summary>
    function ReadInternal: Boolean; virtual; abstract;
    /// <summary> Updates the current state to PostValue </summary>
    /// <param name='AUpdateIndex'> Indicates whether the index of the current TJsonPosition should be updated </param>
    procedure SetPostValueState(AUpdateIndex: Boolean);
    /// <summary> Sets the current token </summary>
    /// <param name='ANewToken'> The new token type </param>
    procedure SetToken(ANewToken: TJsonToken); overload;
    /// <summary> Sets the current token </summary>
    /// <param name='ANewToken'> The new token type </param>
    /// <param name='AValue'> The new value associated to the new token type </param>
    procedure SetToken(ANewToken: TJsonToken; const AValue: TValue); overload;
    /// <summary> Sets the current token </summary>
    /// <param name='ANewToken'> The new token type </param>
    /// <param name='AValue'> The new value associated to the new token type </param>
    /// <param name='AUpdateIndex'> Indicates whether the index of the current TJsonPosition should be updated </param>
    procedure SetToken(ANewToken: TJsonToken; const AValue: TValue; AUpdateIndex: Boolean); overload;
    /// <summary> Gets the position info based on depth </summary>
    function GetPosition(ADepth: Integer): TJsonPosition;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    ///  Gets the current line number.
    /// </summary>
    function GetLineNumber: Integer; override;
    /// <summary>
    ///  Gets the current line position.
    /// </summary>
    function GetLinePosition: Integer; override;
    /// <summary>
    /// Changes the <see cref="TJsonReader.TState"/> to Closed.
    /// </summary>
    procedure Close; virtual;
    /// <summary>
    ///  Resets the reader state to start read again
    /// </summary>
    procedure Rewind; virtual;
    /// <summary>
    ///  Gets a value indicating whether the class can return line information
    /// </summary>
    function HasLineInfo: Boolean; override;
    /// <summary>
    ///  Reads the next JSON token. If
    /// </summary>
    /// <returns> True if the next token was read successfully; False if there are no more tokens to read. </returns>
    function Read: Boolean; virtual;
    /// <summary>
    ///  Reads the next JSON token as <see cref="Integer"/>.
    /// </summary>
    function ReadAsInteger: Integer; virtual;
    /// <summary>
    ///  Reads the next JSON token as <see cref="Int64"/>.
    /// </summary>
    function ReadAsInt64: Int64; virtual;
    /// <summary>
    ///  Reads the next JSON token as <see cref="string"/>.
    /// </summary>
    function ReadAsString: string; virtual;
    /// <summary>
    ///  Reads the next JSON token as <see cref="TBytes"/>.
    /// </summary>
    function ReadAsBytes: TBytes; virtual;
    /// <summary>
    ///  Reads the next JSON token as <see cref="Double"/>.
    /// </summary>
    function ReadAsDouble: Double; virtual;
    /// <summary>
    ///  Reads the next JSON token as <see cref="TDateTime"/>.
    /// </summary>
    function ReadAsDateTime: TDateTime; virtual;
    /// <summary>
    ///  Skips the children of the current token
    /// </summary>
    procedure Skip; virtual;
    /// <summary>
    ///  Check whether the Token is a StartToken or not
    /// </summary>
    class function IsStartToken(Token: TJsonToken): Boolean;
    /// <summary>
    ///  Check whether the Token is an EndToken or not
    /// </summary>
    class function IsEndToken(Token: TJsonToken): Boolean;
    /// <summary>
    ///  Check whether the Token is an primitive or not
    /// </summary>
    class function IsPrimitiveToken(Token: TJsonToken): Boolean;
    /// <summary>
    ///  Gets or sets a value indicating whether the underlying stream or
    ///  <see cref="TTextReader"/> should be closed when the reader is closed.
    /// </summary>
    property CloseInput: Boolean read FCloseInput write FCloseInput;
    /// <summary>
    ///  Gets the current reader state.
    /// </summary>
    property CurrentState: TState read FCurrentState;
    /// <summary>
    ///  Gets the depth of the current token in the JSON document.
    /// </summary>
    property Depth: Integer read GetDepth;
    /// <summary>
    ///  Gets the type of the current JSON token.
    /// </summary>
    property TokenType: TJsonToken read FTokenType;
    /// <summary>
    ///  Gets or sets the maximum depth allowed when reading JSON. Reading past this depth will throw a <see cref="EJsonReaderException"/>
    ///  Negative value specifies not MaxDepth
    /// </summary>
    property MaxDepth: Integer read FMaxDepth write SetMaxDepth;
    /// <summary>
    ///  Gets the path of the current JSON token.
    /// </summary>
    property Path: string read GetPath;
    /// <summary>
    ///  Gets the quotation mark character used to enclose the value of a string.
    /// </summary>
    property QuoteChar: Char read GetQuotedChar write SetQuotedChar;
    /// <summary>
    ///  Gets or sets a value indicating whether multiple pieces of JSON content can be read from a continuous stream without erroring.
    /// </summary>
    property SupportMultipleContent: Boolean read FSupportMultipleContent write FSupportMultipleContent;
    /// <summary>
    ///  Indicates how TDateTime zones are handling when reading JSON.
    /// </summary>
    property DateTimeZoneHandling: TJsonDateTimeZoneHandling read FDateTimeZoneHandling write FDateTimeZoneHandling;

    property FormatSettings: TFormatSettings read FFormatSettings write FFormatSettings;
    /// <summary>
    ///  Gets the value of the current JSON token.
    /// </summary>
    property Value: TValue read FValue;
  end;

  /// <summary>
  ///  Exception type for the <see cref="TJsonReader"/>
  /// </summary>
  EJsonReaderException = class (EJsonException)
  private
    FLineNumber: Integer;
    FLinePosition: Integer;
    FPath: string;
  public
    constructor Create(const Msg: string; const InnerException: Exception; const APath: string; ALineNumber: Integer;
      ALinePosition: Integer); overload;
    constructor Create(const Reader: TJsonReader; const Msg: string; const Ex: Exception = nil); overload;
    constructor Create(const LineInfo: TJsonLineInfo; const Path, Msg: string; const Ex: Exception = nil); overload;
    constructor CreateFmt(const Reader: TJsonReader; const Msg: string; const Args: array of const;
      const Ex: Exception = nil); overload;
    constructor CreateFmt(const LineInfo: TJsonLineInfo; const Path, Msg: string; const Args: array of const;
      const Ex: Exception = nil); overload;
    /// <summary>
    ///  Gets the current line number.
    /// </summary>
    property LineNumber: Integer read FLineNumber;
    /// <summary>
    ///  Gets the current line position.
    /// </summary>
    property LinePosition: Integer read FLinePosition;
    /// <summary>
    ///  Path where the exception has ocurred
    /// </summary>
    property Path: string read FPath;
  end;

  /// <summary>
  /// Reader to read access serialized JSON data.
  /// </summary>
  TJsonTextReader = class(TJsonReader)
  private type
    TStringBuffer = class(TStringBuilder)
    public
      property InternalBuffer: TCharArray read FData;
    end;
    TCharsReference = record
    private
      FReference: PChar;
      FCount: Integer;
    public
      procedure SetReference(P: PChar; ACount: Integer); inline;
      function ToString: string;
    end;
  private const
    UnicodeReplacementChar: Char = Char($FFFD);
    MaximumJavascriptIntegerCharacterLength: Integer = 380;
    kBufferSize: Integer = 1025;
  private
    FReader: TTextReader;
    FChars: array of Char;
    FCharsReference: TCharsReference;
    FCharsUsed: Integer;
    FCharPos: Integer;
    FLineStartPos: Integer;
    FLineNumber: Integer;
    FIsEndOfFile: Boolean;
    FBuffer: TStringBuffer;
    FDateParseHandling: TJsonDateParseHandling;
    FExtendedJsonMode: TJsonExtendedJsonMode;
    procedure ClearRecentString;
    function EatWhiteSpace(OneOrMore: Boolean): Boolean;
    function EnsureChars(RelativePosition: Integer; Append: Boolean): Boolean;
    function IsSeparator(C: Char): Boolean;
    function MatchValueWithTrailingSeparator(const Value: string): Boolean;
    function MatchValue(const Value: string): Boolean;
    function ReadChars(RelativePosition: Integer; Append: Boolean): Boolean;
    function ReadData(Append: Boolean): Integer; overload;
    function ReadData(Append: Boolean; CharsRequired: Integer): Integer; overload;
    procedure OnNewLine(Pos: Integer);
    procedure ParseString(Quote: Char);
    procedure ParseTrue;
    procedure ParseFalse;
    procedure ParseComment;
    procedure ParseNumber;
    procedure ParseNumberNaN;
    procedure ParseNull;
    procedure ParseUndefined;
    procedure ParseNumberNegativeInfinity;
    procedure ParseNumberPositiveInfinity;
    function ParseObject: Boolean;
    function ParseProperty: Boolean;
    procedure ParseUnquotedProperty;
    procedure ParseConstructor;
    function ParseUnicode: Char;
    function ParseValue: Boolean;
    function ParsePostValue: Boolean;
    function ParseExtendedStrictModeValue: Boolean;
    procedure ProcessCarriageReturn(Append: Boolean);
    procedure ProcessLineFeed;
    procedure ReadStringIntoBuffer(Quote: Char);
    procedure ReadNumberIntoBuffer;
    procedure ShiftBufferIfNeeded;
    procedure WriteCharToBuffer(const Buffer: TStringBuffer; WriteChar: Char; LastWritePosition, WriteToPosition: Integer);
    function ValidIdentifierChar(AValue: Char): Boolean;
  protected
    /// <summary> Implementation for Read function </summary>
    function ReadInternal: Boolean; override;
  public
    constructor Create(const Reader: TTextReader);
    destructor Destroy; override;
    /// <summary>
    ///  Changes the <see cref="TJsonReader.TState"/> to Closed.
    /// </summary>
    procedure Close; override;
    /// <summary>
    ///  Resets the reader state to start read again
    /// </summary>
    /// <remarks> This will not reset the state of the underlying <see cref="TTextReader"/> </remarks>
    procedure Rewind; override;
    /// <summary>
    ///  Gets the current line number.
    /// </summary>
    function GetLineNumber: Integer; override;
    /// <summary>
    ///  Gets the current line position.
    /// </summary>
    function GetLinePosition: Integer; override;
    /// <summary>
    ///  Gets a value indicating whether the class can return line information
    /// </summary>
    function HasLineInfo: Boolean; override;
    /// <summary>
    ///  Gets the underlying .
    /// </summary>
    property Reader: TTextReader read FReader;
    /// <summary>
    ///  Gets the current line position.
    /// </summary>
    property LineNumber: Integer read GetLineNumber;
    /// <summary>
    ///  Gets the current line position.
    /// </summary>
    property LinePosition: Integer read GetLinePosition;
    /// <summary>
    ///  Indicates whether the strings with a datetime format should be parsed as TDateTime or not when reading JSON.
    /// </summary>
    property DateParseHandling: TJsonDateParseHandling read FDateParseHandling write FDateParseHandling;
    /// <summary>
    ///  Get or sets the mode to parse
    /// </summary>
    property ExtendedJsonMode: TJsonExtendedJsonMode read FExtendedJsonMode write FExtendedJsonMode;
  end;

implementation

uses
  System.DateUtils, System.Math, System.Character, System.TypInfo,
  System.NetEncoding, System.JSONConsts;

const
  kUndefined = 'undefined';
  kNull = 'null';
  kTrue = 'true';
  kFalse = 'false';
  kNew = 'new';
  kPositiveInfinity = 'Infinity';
  kNegativeInfinity = '-Infinity';
  kNan = 'NaN';

var
  EmptyValue,
  FalseValue,
  TrueValue: TValue;

{ Helpers }

function GetName(Value: TJsonToken): string; overload;
begin
  Result := GetEnumName(TypeInfo(TJsonToken), Integer(Value));
end;

function GetName(Value: TJsonContainerType): string; overload;
begin
  Result := GetEnumName(TypeInfo(TJsonContainerType), Integer(Value));
end;

function GetName(Value: TJsonReader.TState): string; overload;
begin
  Result := GetEnumName(TypeInfo(TJsonReader.TState), Integer(Value));
end;

{ TJsonReader }

procedure TJsonReader.Close;
begin
  FCurrentState := TState.Closed;
  FTokenType := TJsonToken.None;
  FValue := nil;
end;

constructor TJsonReader.Create;
begin
  FCurrentState := TState.Start;
  FStack := TList<TJsonPosition>.Create;
  FStack.Capacity := 4;
  FFormatSettings := JSONFormatSettings;
  FDateTimeZoneHandling := TJsonDateTimeZoneHandling.Local;
  CloseInput := True;
  FMaxDepth := -1; // Indicates the value is not setted yet
end;

destructor TJsonReader.Destroy;
begin
  Close;
  FStack.Free;
  inherited Destroy;
end;

function TJsonReader.GetDepth: Integer;
var
  LDepth: Integer;
begin
  LDepth := FStack.Count;
  if IsStartToken(TokenType) or (FCurrentPosition.ContainerType = TJsonContainerType.None) then
    Result := LDepth
  else
    Result := LDepth + 1;
end;

function TJsonReader.GetLineNumber: Integer;
begin
  Result := 0; // implement in child classes
end;

function TJsonReader.GetLinePosition: Integer;
begin
  Result := 0; // implement in child classes
end;

function TJsonReader.GetPath: string;
var
  InsideContainer: Boolean;
  Positions: TList<TJsonPosition>;
begin
  if FCurrentPosition.ContainerType = TJsonContainerType.None then
    Result := ''
  else
  begin
    InsideContainer := (FCurrentState <> TState.ArrayStart) and (FCurrentState <> TState.ConstructorStart)
      and (FCurrentState <> TState.ObjectStart);

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

function TJsonReader.GetPosition(ADepth: Integer): TJsonPosition;
begin
  if ADepth < FStack.Count then
    Result := FStack[ADepth]
  else
    Result := FCurrentPosition;
end;

function TJsonReader.GetQuotedChar: Char;
begin
  Result := FQuoteChar;
end;

function TJsonReader.GetTypeForCloseToken(Token: TJsonToken): TJsonContainerType;
begin
  Result := TJsonContainerType.None;
  case Token of
    TJsonToken.EndObject:
      Result := TJsonContainerType.Object;
    TJsonToken.EndArray:
      Result := TJsonContainerType.Array;
    TJsonToken.EndConstructor:
      Result := TJsonContainerType.Constructor;
  else
    ReaderError(SInvalidCloseToken, GetName(Token));
  end;
end;

function TJsonReader.HasLineInfo: Boolean;
begin
  Result := False;
end;

class function TJsonReader.IsPrimitiveToken(Token: TJsonToken): Boolean;
begin
  case Token of
    TJsonToken.Integer,
    TJsonToken.Float,
    TJsonToken.String,
    TJsonToken.Boolean,
    TJsonToken.Undefined,
    TJsonToken.Null,
    TJsonToken.Date,
    TJsonToken.Bytes,
    TJsonToken.Oid,
    TJsonToken.RegEx,
    TJsonToken.DBRef,
    TJsonToken.CodeWScope,
    TJsonToken.MinKey,
    TJsonToken.MaxKey:
      Result := True;
  else
    Result := False;
  end;
end;

class function TJsonReader.IsStartToken(Token: TJsonToken): Boolean;
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

class function TJsonReader.IsEndToken(Token: TJsonToken): Boolean;
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

function TJsonReader.Peek: TJsonContainerType;
begin
  Result := FCurrentPosition.ContainerType;
end;

function TJsonReader.Pop: TJsonContainerType;
var
  OldPosition: TJsonPosition;
begin
  if FStack.Count > 0 then
  begin
    OldPosition := FCurrentPosition;
    FCurrentPosition := FStack[FStack.Count - 1];
    FStack.Delete(FStack.Count - 1);
  end
  else
  begin
    OldPosition := FCurrentPosition;
    FCurrentPosition := TJsonPosition.Create
  end;

  if (FMaxDepth > -1) and (Depth <= FMaxDepth) then
    FHasExceededMaxDepth := False;

  Result := OldPosition.ContainerType;
end;

procedure TJsonReader.Push(AValue: TJsonContainerType);
begin
  UpdateScopeWithFinishedValue;
  if FCurrentPosition.ContainerType = TJsonContainerType.None then
    FCurrentPosition := TJsonPosition.Create(AValue)
  else
  begin
    FStack.Add(FCurrentPosition);
    FCurrentPosition := TJsonPosition.Create(AValue);

    // this is a little hacky because Depth increases when first property/value is written but only testing here is faster/simpler
    if (FMaxDepth > -1) and (Depth + 1 > FMaxDepth) and not FHasExceededMaxDepth then
    begin
      FHasExceededMaxDepth := True;
      ReaderError(SReaderMaxDepthExceeded, FMaxDepth.ToString);
    end
  end;
end;

function TJsonReader.Read: Boolean;
begin
  FReadType := TReadType.Read;
  if not ReadInternal then
  begin
    SetToken(TJsonToken.None);
    Result := False
  end
  else
    Result := True;
end;

function TJsonReader.ReadAsBytes: TBytes;
begin
  Result := ReadAsBytesInternal;
end;

function TJsonReader.ReadAsBytesInternal: TBytes;
var
  LTokenType: TJsonToken;
  S: string;
  List: TList<Byte>;
  Oid: TJsonOid;
  LValue: TValue;
begin
  FReadType := TReadType.ReadAsBytes;
  LTokenType := TJsonToken.None;

  repeat
    if not ReadInternal then
    begin
      SetToken(TJsonToken.None);
      Exit(nil)
    end
    else
      LTokenType := TokenType;
  until LTokenType <> TJsonToken.Comment;

  case LTokenType of
    TJsonToken.String:
    begin
      S := Value.AsString;
      if Length(S) = 0 then
      begin
        LValue := 0;
        SetLength(Result, 0)
      end
      else
      begin
        try
          Result := TGUID.Create(S).ToByteArray;
        except
          Result := TNetEncoding.Base64.DecodeStringToBytes(S)
        end;
      end;
      LValue := TValue.From<TBytes>(Result);
      SetToken(TJsonToken.Bytes, LValue, False);
      Exit(Result);
    end;
    TJsonToken.Null:
      Exit(nil);
    TJsonToken.Bytes:
    begin
      if Value.TypeInfo = System.TypeInfo(TGUID) then
      begin
        Result := PGUID(Value.GetReferenceToRawData)^.ToByteArray;
        LValue := TValue.From<TBytes>(Result);
        SetToken(TJsonToken.Bytes, LValue, False);
      end
      else
        Result := Value.AsType<TBytes>;
    end;
    TJsonToken.Oid:
    begin
      Oid := Value.AsType<TJsonOid>;
      Result := Oid.AsBytes;
      LValue := TValue.From<TBytes>(Result);
      SetToken(TJsonToken.Oid, LValue, False);
      Exit(Result);
    end;
    TJsonToken.StartArray:
    begin
      List := TList<Byte>.Create;
      try
        while ReadInternal do
        begin
          LTokenType := TokenType;
          case LTokenType of
            TJsonToken.Integer:
              List.Add(Value.AsInteger);
            TJsonToken.EndArray:
            begin
              Result := List.ToArray;
              LValue := TValue.From<TBytes>(Result);
              SetToken(TJsonToken.Bytes, LValue, False);
              Exit(Result);
            end;
            TJsonToken.Comment:
              ; // skip
          else
            ReaderError(SUnexpectedTokenReadBytes, GetName(LTokenType));
          end;
        end;
        ReaderError(SUnexpectedBytesEnd);
      finally
        List.Free;
      end;
    end;
    TJsonToken.EndArray:
      Exit(nil)
  else
    ReaderError(SUnexpectedBytesEnd, GetName(LTokenType));
  end;
end;

function TJsonReader.ReadAsDateTime: TDateTime;
begin
  Result := ReadAsDateTimeInternal;
end;

function TJsonReader.ReadAsDateTimeInternal: TDateTime;
var
  LTokenType: TJsonToken;
  S: string;
  DateTime: TDateTime;
  DateConverted: Boolean;
  I: Int64;
begin
  Result := 0;
  FReadType := TReadType.ReadAsDateTime;
  LTokenType := TJsonToken.None;

  repeat
    if not ReadInternal then
    begin
      SetToken(TJsonToken.None);
      Exit(DefDateTimeVal);
    end
    else
      LTokenType := TokenType;
  until LTokenType <> TJsonToken.Comment;

  case LTokenType of
    TJsonToken.Date:
      Result := Value.AsExtended;
    TJsonToken.Null,
    TJsonToken.EndArray:
      Result := DefDateTimeVal;
    TJsonToken.String:
    begin
      S := Value.AsString;
      if S = '' then
      begin
        SetToken(TJsonToken.Null);
        Result := DefDateTimeVal
      end
      else
      begin
        // try to parse to some format
        DateConverted := TryStrToDateTime(S, DateTime, FFormatSettings);

        if not DateConverted then
          DateConverted:= TryISO8601ToDate(S, DateTime, True);

        if not DateConverted then
        begin
          if TryStrToInt64(S, I) then
          begin
            DateTime := UnixToDateTime(I, True);
            DateConverted := True;
          end;
        end;

        if not DateConverted then
          ReaderError(SErrorConvertStringToDatetime, S);

        if DateTimeZoneHandling = TJsonDateTimeZoneHandling.Local then
          DateTime := TTimeZone.Local.ToLocalTime(DateTime);

        Result := DateTime;
        SetToken(TJsonToken.Date, DateTime, False);
      end;
    end;
    TJsonToken.Integer:
    begin
      DateTime := UnixToDateTime(Value.AsInt64 div 1000, True) +
        (Value.AsInt64 mod 1000) / 1000;

      if DateTimeZoneHandling = TJsonDateTimeZoneHandling.Local then
        DateTime := TTimeZone.Local.ToLocalTime(DateTime);

      Result := DateTime;
      SetToken(TJsonToken.Date, DateTime, False);
    end;
    else
      ReaderError(SUnexpectedTokenDate, GetName(LTokenType));
  end;
end;

function TJsonReader.ReadAsDouble: Double;
begin
  Result := ReadAsDoubleInternal;
end;

function TJsonReader.ReadAsDoubleInternal: Double;
var
  LTokenType: TJsonToken;
  D: Double;
  S: string;
begin
  Result := 0;
  FReadType := TReadType.ReadAsDouble;
  LTokenType := TJsonToken.None;

  repeat
    if not ReadInternal then
    begin
      SetToken(TJsonToken.None);
      Exit(DefDoubleVal);
    end
    else
      LTokenType := TokenType;
  until LTokenType <> TJsonToken.Comment;

  case LTokenType of
    TJsonToken.Integer,
    TJsonToken.Float:
    begin
      Result := Value.AsExtended;
      if not (Value.TypeInfo^.Kind = TTypeKind.tkFloat) then
        SetToken(TJsonToken.Float, Result, False);
    end;
    TJsonToken.Null,
    TJsonToken.EndArray:
      Result := DefDoubleVal;
    TJsonToken.String:
    begin
      S := Value.AsString;
      if S = '' then
      begin
        SetToken(TJsonToken.Null);
        Result := DefDoubleVal
      end
      else
      begin
        if not TryStrToFloat(S, D, FFormatSettings) then
          ReaderError(SErrorConvertStringToDouble, S);
        Result := D;
        SetToken(TJsonToken.Float, Result, False);
      end;
    end;
    else
      ReaderError(SUnexpectedTokenDouble, GetName(LTokenType));
  end;
end;

function TJsonReader.ReadAsInteger: Integer;
begin
  Result := ReadAsIntegerInternal;
end;

function TJsonReader.ReadAsIntegerInternal: Integer;
var
  LTokenType: TJsonToken;
  I: Integer;
  S: string;
begin
  Result := 0;
  FReadType := TReadType.ReadAsInteger;
  LTokenType := TJsonToken.None;

  repeat
    if not ReadInternal then
    begin
      SetToken(TJsonToken.None);
      Exit(DefIntegerVal);
    end
    else
      LTokenType := TokenType;
  until LTokenType <> TJsonToken.Comment;

  case LTokenType of
    TJsonToken.Integer,
    TJsonToken.Float:
    begin
      Result := Value.AsInteger;
      if not (Value.TypeInfo^.Kind = TTypeKind.tkInteger) then
        SetToken(TJsonToken.Integer, Result, False);
    end;
    TJsonToken.Null,
    TJsonToken.EndArray:
      Result := DefIntegerVal;
    TJsonToken.String:
    begin
      S := Value.AsString;
      if S = '' then
      begin
        SetToken(TJsonToken.Null);
        Result := DefIntegerVal
      end
      else
      begin
        if not TryStrToInt(S, I) then
          ReaderError(SErrorConvertStringToInteger, S);
        Result := I;
        SetToken(TJsonToken.Integer, Result, False);
      end;
    end;
    else
      ReaderError(SUnexpectedTokenInteger, GetName(LTokenType));
  end;
end;

function TJsonReader.ReadAsInt64: Int64;
begin
  Result := ReadAsInt64Internal;
end;

function TJsonReader.ReadAsInt64Internal: Int64;
var
  LTokenType: TJsonToken;
  I: Int64;
  S: string;
begin
  Result := 0;
  FReadType := TReadType.ReadAsInteger;
  LTokenType := TJsonToken.None;

  repeat
    if not ReadInternal then
    begin
      SetToken(TJsonToken.None);
      Exit(DefIntegerVal);
    end
    else
      LTokenType := TokenType;
  until LTokenType <> TJsonToken.Comment;

  case LTokenType of
    TJsonToken.Integer,
    TJsonToken.Float:
    begin
      Result := Value.AsInt64;
      if not (Value.TypeInfo^.Kind = TTypeKind.tkInt64) then
        SetToken(TJsonToken.Integer, Result, False);
    end;
    TJsonToken.Null,
    TJsonToken.EndArray:
      Result := DefIntegerVal;
    TJsonToken.String:
    begin
      S := Value.AsString;
      if S = '' then
      begin
        SetToken(TJsonToken.Null);
        Result := DefIntegerVal
      end
      else
      begin
        if not TryStrToInt64(S, I) then
          ReaderError(SErrorConvertStringToInteger, S);
        Result := I;
        SetToken(TJsonToken.Integer, Result, False);
      end;
    end;
    else
      ReaderError(SUnexpectedTokenInteger, GetName(LTokenType));
  end;
end;

function TJsonReader.ReadAsString: string;
begin
  Result := ReadAsStringInternal;
end;

function TJsonReader.ReadAsStringInternal: string;
var
  LTokenType: TJsonToken;
begin
  Result := '';
  FReadType := TReadType.ReadAsString;
  LTokenType := TJsonToken.None;

  repeat
    if not ReadInternal then
    begin
      SetToken(TJsonToken.None);
      Exit(DefStringVal);
    end
    else
      LTokenType := TokenType;
  until LTokenType <> TJsonToken.Comment;

  case LTokenType of
    TJsonToken.String:
      Result := Value.AsString;
    TJsonToken.Null,
    TJsonToken.EndArray:
      Result := DefStringVal;
    else
    begin
      if IsPrimitiveToken(LTokenType) and not Value.IsEmpty then
      begin
        Result := Value.AsString;
        SetToken(TJsonToken.String, Result, False);
      end
      else
        ReaderError(SUnexpectedTokenString, GetName(LTokenType));
    end;
  end;
end;

procedure TJsonReader.Rewind;
begin
  FCurrentState := TState.Start;
  FTokenType := TJsonToken.None;
  FValue := nil;
  FStack.Clear;
end;

{ TJsonReaderException }

constructor EJsonReaderException.Create(const Msg: string; const InnerException: Exception; const APath: string; ALineNumber,
  ALinePosition: Integer);
begin
  inherited Create(Msg, InnerException);
  FPath := APath;
  FLineNumber := ALineNumber;
  FLinePosition := ALinePosition;
  Create(Msg, InnerException);
end;

constructor EJsonReaderException.Create(const Reader: TJsonReader; const Msg: string; const Ex: Exception);
begin
  Create(Reader, Reader.path, Msg, Ex);
end;

constructor EJsonReaderException.Create(const LineInfo: TJsonLineInfo; const Path, Msg: string; const Ex: Exception);
var
  LMsg: string;
  LineNumber, LinePosition: Integer;
begin
  LMsg := TJsonPosition.FormatMessage(LineInfo, Path, Msg);
  if (LineInfo <> nil) and LineInfo.HasLineInfo then
  begin
    LineNumber := LineInfo.LineNumber;
    LinePosition := LineInfo.LinePosition;
  end
  else
  begin
    LineNumber := 0;
    LinePosition := 0;
  end;
//
  Create(LMsg, Ex, Path, LineNumber, linePosition);
end;

constructor EJsonReaderException.CreateFmt(const Reader: TJsonReader; const Msg: string; const Args: array of const;
  const Ex: Exception);
begin
  Create(Reader, Format(Msg, Args), Ex);
end;

constructor EJsonReaderException.CreateFmt(const LineInfo: TJsonLineInfo; const Path, Msg: string;
  const Args: array of const; const Ex: Exception);
begin
  Create(LineInfo, Path, Format(Msg, Args), Ex);
end;

procedure TJsonTextReader.ReadStringIntoBuffer(Quote: Char);
var
  LCharPos, LInitialPosition, LLastWritePosition, LEscapeStartPos: Integer;
  LWriteChar, LCurrentChar, LHighSurrogate, C: Char;
  LAnotherHighSurrogate: Boolean;
  LBuffer: TStringBuffer;
begin
  LBuffer := nil;
  LCharPos := FCharPos;
  LLastWritePosition := FCharPos;
  LInitialPosition := FCharPos;
  while True do
  begin
    C := FChars[LCharPos];
    Inc(LCharPos);
    case C of
      Char($0):
      begin
        if FCharsUsed = LCharPos - 1 then
        begin
          Dec(LCharPos);
          if ReadData(True) = 0 then
          begin
            FCharPos := LCharPos;
            ReaderError(SUnterminatedString, Quote);
          end;
        end;
      end;
      Char('\'):
      begin
        FCharPos := LCharPos;
        if not EnsureChars(0, True) then
        begin
          FCharPos := LCharPos;
          ReaderError(SUnterminatedString, Quote);
        end;

        // start of escape sequence
        LEscapeStartPos := LCharPos - 1;
        LCurrentChar := Char(FChars[LCharPos]);

        case LCurrentChar of
          'b':
          begin
            Inc(LCharPos);
            LWriteChar := #$8;
          end;
          't':
          begin
            Inc(LCharPos);
            LWriteChar := #$9;
          end;
          'n':
          begin
            Inc(LCharPos);
            LWriteChar := #$a;
          end;
          'f':
          begin
            Inc(LCharPos);
            LWriteChar := #$c;
          end;
          'r':
          begin
            Inc(LCharPos);
            LWriteChar := #$d;
          end;
          '\':
          begin
            Inc(LCharPos);
            LWriteChar := '\';
          end;
          '"',
          '''',
          '/':
          begin
            Inc(LCharPos);
            LWriteChar := LCurrentChar;
          end;
          'u':
          begin
            Inc(LCharPos);
            FCharPos := LCharPos;
            LWriteChar := ParseUnicode;

            if LWriteChar.IsLowSurrogate then
                // low surrogate with no preceding high surrogate; this char is replaced
              LWriteChar := UnicodeReplacementChar
            else if LWriteChar.IsHighSurrogate then
            begin

              // loop for handling situations where there are multiple consecutive high surrogates
              repeat
                LAnotherHighSurrogate := false;

                // potential start of a surrogate pair
                if EnsureChars(2, True) and (FChars[FCharPos] = '\') and (FChars[LCharPos + 1] = 'u') then
                begin
                  LHighSurrogate := LWriteChar;

                  Inc(FCharPos, 2);
                  LWriteChar := ParseUnicode;

                  if LWriteChar.IsLowSurrogate then
                  begin
                    // a valid surrogate pair!
                  end
                  else if (LWriteChar.IsHighSurrogate) then
                  begin
                    // another high surrogate; replace current and start check over
                    LHighSurrogate := UnicodeReplacementChar;
                    LAnotherHighSurrogate := True;
                  end
                  else
                    // high surrogate not followed by low surrogate; original char is replaced
                    LHighSurrogate := UnicodeReplacementChar;

                  if LBuffer = nil then
                  begin
                    FBuffer.Length := 0;
                    LBuffer := FBuffer;
                  end;

                  WriteCharToBuffer(LBuffer, LHighSurrogate, LLastWritePosition, LEscapeStartPos);
                  LLastWritePosition := FCharPos;
                end
                else
                  // there are not enough remaining chars for the low surrogate or is not follow by unicode sequence
                  // replace high surrogate and continue on as usual
                  LWriteChar := UnicodeReplacementChar;
              until not LAnotherHighSurrogate;
            end;
            LCharPos := FCharPos;
          end;
          else
          begin
            Inc(LCharPos);
            FCharPos := LCharPos;
            ReaderError(SBadEscapeSequence, LCurrentChar);
          end;
        end;
        if LBuffer = nil then
        begin
          FBuffer.Length := 0;
          LBuffer := FBuffer;
        end;
        WriteCharToBuffer(LBuffer, LWriteChar, LLastWritePosition, LEscapeStartPos);
        LLastWritePosition := LCharPos;
      end;
      #13: // \r
      begin
        FCharPos := LCharPos - 1;
        ProcessCarriageReturn(True);
        LCharPos := FCharPos;
      end;
      #10: // \n:
      begin
        FCharPos := LCharPos - 1;
        ProcessLineFeed;
        LCharPos := FCharPos;
      end;
      '"',
      '''':
      begin
        if FChars[LCharPos - 1] = Quote then
        begin
          Dec(LCharPos);
          if LInitialPosition = LLastWritePosition then
            FCharsReference.SetReference(@FChars[LInitialPosition], LCharPos - LInitialPosition)
          else
          begin
            if LBuffer = nil then
            begin
              FBuffer.Length := 0;
              LBuffer := FBuffer;
            end;
            if LCharPos > LLastWritePosition then
              LBuffer.Append(TCharArray(FChars), LLastWritePosition, LCharPos - LLastWritePosition);
            FCharsReference.SetReference(@LBuffer.InternalBuffer[0], LBuffer.Length);
          end;

          Inc(LCharPos);
          FCharPos := LCharPos;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TJsonReader.SetFinished;
begin
  if SupportMultipleContent then
    FCurrentState := TState.Start
  else
    FCurrentState := TState.Finished
end;

procedure TJsonReader.SetMaxDepth(Value: Integer);
begin
  FMaxDepth := Value;
end;

procedure TJsonReader.SetPostValueState(AUpdateIndex: Boolean);
begin
  if (Peek <> TJsonContainerType.None) then
    FCurrentState := TState.PostValue
  else
    SetFinished;

  if (AUpdateIndex) then
    UpdateScopeWithFinishedValue;
end;

procedure TJsonReader.SetQuotedChar(Value: Char);
begin
  FQuoteChar := Value;
end;

procedure TJsonReader.SetStateBasedOnCurrent;
begin
  case Peek of
    TJsonContainerType.Object:
      FCurrentState := TState.Object;
    TJsonContainerType.Array:
      FCurrentState := TState.Array;
    TJsonContainerType.Constructor:
      FCurrentState := TState.Constructor;
    TJsonContainerType.None:
      SetFinished;
  end;
end;

procedure TJsonReader.SetToken(ANewToken: TJsonToken; const AValue: TValue);
begin
  SetToken(ANewToken, AValue, True);
end;

procedure TJsonReader.SetToken(ANewToken: TJsonToken);
begin
  SetToken(ANewToken, EmptyValue, True);
end;

procedure TJsonReader.SetToken(ANewToken: TJsonToken; const AValue: TValue; AUpdateIndex: Boolean);
begin
  FTokenType := ANewToken;
  FValue := AValue;

  case ANewToken of
    TJsonToken.StartObject:
    begin
      FCurrentState := TState.ObjectStart;
      Push(TJsonContainerType.Object);
    end;
    TJsonToken.StartArray:
    begin
      FCurrentState := TState.ArrayStart;
      Push(TJsonContainerType.Array)
    end;
    TJsonToken.StartConstructor:
    begin
      FCurrentState := TState.ConstructorStart;
      Push(TJsonContainerType.Constructor)
    end;
    TJsonToken.EndObject:
      ValidateEnd(TJsonToken.EndObject);
    TJsonToken.EndArray:
      ValidateEnd(TJsonToken.EndArray);
    TJsonToken.EndConstructor:
      ValidateEnd(TJsonToken.EndConstructor);
    TJsonToken.PropertyName:
    begin
      FCurrentState := TState.Property;
      FCurrentPosition.PropertyName := Value.AsString
    end;
    TJsonToken.Undefined,
    TJsonToken.Integer,
    TJsonToken.Float,
    TJsonToken.Boolean,
    TJsonToken.Null,
    TJsonToken.Date,
    TJsonToken.String,
    TJsonToken.Raw,
    TJsonToken.Bytes,
    TJsonToken.Oid,
    TJsonToken.RegEx,
    TJsonToken.DBRef,
    TJsonToken.CodeWScope,
    TJsonToken.MinKey,
    TJsonToken.MaxKey:
      SetPostValueState(AUpdateIndex);
  end;
end;

procedure TJsonReader.Skip;
var
  LDepth: Integer;
begin
  if TokenType = TJsonToken.PropertyName then
    Read;

  if IsStartToken(TokenType) then
  begin
    LDepth := Depth;
    while Read and (LDepth < Depth) do
    ;
  end;
end;

procedure TJsonReader.UpdateScopeWithFinishedValue;
begin
  if FCurrentPosition.HasIndex then
    Inc(FCurrentPosition.Position);
end;

procedure TJsonReader.ValidateEnd(EndToken: TJsonToken);
var
  CurrentObject: TJsonContainerType;
begin
  CurrentObject := Pop;

  if GetTypeForCloseToken(EndToken) <> CurrentObject then
    ReaderError(SInvalidTokenForContainer, GetName(EndToken), GetName(CurrentObject));

  if Peek <> TJsonContainerType.None then
    FCurrentState := TState.PostValue
  else
    SetFinished;
end;

procedure TJsonReader.ReaderError(const Msg: string);
begin
  raise EJsonReaderException.Create(Self, Msg);
end;

procedure TJsonReader.ReaderError(const Msg, Param1: string);
begin
  raise EJsonReaderException.CreateFmt(Self, Msg, [Param1]);
end;

procedure TJsonReader.ReaderError(const Msg, Param1, Param2: string);
begin
  raise EJsonReaderException.CreateFmt(Self, Msg, [Param1, Param2]);
end;

{ TJsonTextReader }

procedure TJsonTextReader.TCharsReference.SetReference(P: PChar; ACount: Integer);
begin
  FReference := P;
  FCount := ACount;
end;

function TJsonTextReader.TCharsReference.ToString: string;
begin
  if FCount = 0 then
    Result := ''
  else
  begin
    SetLength(Result, FCount);
    Move(FReference^, Result[Low(string)], FCount * SizeOf(Char));
  end;
end;

procedure TJsonTextReader.ClearRecentString;
begin
  FBuffer.Length := 0;
end;

procedure TJsonTextReader.Close;
begin
  inherited Close;
  if CloseInput and (FReader <> nil) then
    FReader.Close;

  if FBuffer <> nil then
    FBuffer.Clear;
end;

constructor TJsonTextReader.Create(const Reader: TTextReader);
begin
  inherited Create;
  FReader := Reader;
  FLineNumber := 1;
  SetLength(FChars, kBufferSize);
  FExtendedJsonMode := TJsonExtendedJsonMode.None;
  FBuffer := TStringBuffer.Create(kBufferSize);
end;

destructor TJsonTextReader.Destroy;
begin
  FreeAndNil(FBuffer);
  inherited Destroy;
end;

function TJsonTextReader.EatWhiteSpace(OneOrMore: Boolean): Boolean;
var
  Finished, AteWhiteSpace: Boolean;
  CurrentChar: Char;
begin
  Finished := False;
  AteWhiteSpace := False;
  while not Finished do
  begin
    CurrentChar := FChars[FCharPos];
    case CurrentChar of
      #0:
      begin
        if FCharsUsed = FCharPos then
        begin
          if ReadData(False) = 0 then
            Finished := True;
        end
        else
          Inc(FCharPos);
      end;
      #13: // \r
        ProcessCarriageReturn(False);
      #10: // \n
        ProcessLineFeed;
      else
      begin
        if (CurrentChar = ' ') or CurrentChar.IsWhiteSpace then
        begin
          AteWhiteSpace := True;
          Inc(FCharPos);
        end
        else
          Finished := True;
      end;
    end;
  end;

  Result := not OneOrMore or AteWhiteSpace;
end;

function TJsonTextReader.EnsureChars(RelativePosition: Integer; Append: Boolean): Boolean;
begin
  if FCharPos + RelativePosition >= FCharsUsed then
    Result := ReadChars(RelativePosition, Append)
  else
    Result := True;
end;

function TJsonTextReader.GetLineNumber: Integer;
begin
  if (CurrentState = TState.Start) and (LinePosition = 0) then
    Result := 0
  else
    Result := FLineNumber;
end;

function TJsonTextReader.GetLinePosition: Integer;
begin
  Result := FCharPos - FLineStartPos;
end;

function TJsonTextReader.HasLineInfo: Boolean;
begin
  Result := True;
end;

function TJsonTextReader.IsSeparator(C: Char): Boolean;
begin
  case C of
    '}',
    ']',
    ',',
    ' ',
    #9, // \t
    #10, // \n
    #13: // \r
      Result := True;
    '/':
      // check next character to see if start of a comment
      Result := EnsureChars(1, False) and ((FChars[FCharPos + 1] = '*') or (FChars[FCharPos + 1] = '/'));
    ')':
      Result := (CurrentState = TState.Constructor) or (CurrentState = TState.ConstructorStart);
    else
      Result := C.IsWhiteSpace
    end;
end;

function TJsonTextReader.MatchValue(const Value: string): Boolean;
var
  I: Integer;
begin
  if not EnsureChars(Length(Value) - 1, True) then
    Exit(False);

  for I := Low(Value) to High(Value) do
    if FChars[FCharPos + I - Low(Value)] <> Value[I] then
      Exit(False);

  FCharPos := FCharPos + Length(Value);

  Result := True;
end;

function TJsonTextReader.MatchValueWithTrailingSeparator(const Value: string): Boolean;
var
  Match: Boolean;
begin
  Match := MatchValue(Value);
  if not Match then
    Exit(False);

  if not EnsureChars(0, False) then
    Exit(True);

  Result := IsSeparator(FChars[FCharPos]) or (FChars[FCharPos] = #0);
end;

procedure TJsonTextReader.OnNewLine(Pos: Integer);
begin
  Inc(FLineNumber);
  FLineStartPos := Pos - 1;
end;

procedure TJsonTextReader.ParseComment;
var
  SingleLineComment, CommentFinished: Boolean;
  InitialPos: Integer;
begin
  Inc(FCharPos);
  if not EnsureChars(1, False) then
    raise EJsonReaderException.Create(Self, SUnexpectedCommentEnd);

  SingleLineComment := False;
  case FChars[FCharPos] of
    '*': SingleLineComment := False;
    '/': SingleLineComment := True;
    else
      ReaderError(SParseErrorComment, FChars[FCharPos]);
  end;

  Inc(FCharPos);
  InitialPos := FCharPos;
  CommentFinished := False;

  while not CommentFinished do
  begin
    case FChars[FCharPos] of
      #0:
      begin
        if FCharsUsed = FCharPos then
        begin
          if ReadData(True) = 0 then
          begin
            if not SingleLineComment then
              raise EJsonReaderException.Create(Self, SUnexpectedCommentEnd);

            FCharsReference.SetReference(@FChars[InitialPos], FCharPos - InitialPos);
            CommentFinished := True;
          end;
        end
        else
          Inc(FCharPos);
      end;
      '*':
      begin
        Inc(FCharPos);
        if not SingleLineComment and EnsureChars(0, True) and (FChars[FCharPos] = '/') then
        begin
          FCharsReference.SetReference(@FChars[InitialPos], FCharPos - InitialPos - 1);
          Inc(FCharPos);
          CommentFinished := True;
        end;
      end;
      #13: // \r
      begin
        if SingleLineComment then
        begin
          FCharsReference.SetReference(@FChars[InitialPos], FCharPos - InitialPos);
          CommentFinished := True;
        end;
        ProcessCarriageReturn(True);
      end;
      #10: // \n
      begin
        if SingleLineComment then
        begin
          FCharsReference.SetReference(@FChars[InitialPos], FCharPos - InitialPos);
          CommentFinished := True;
        end;
        ProcessLineFeed;
      end;
      else
        Inc(FCharPos);
    end;
  end;
  SetToken(TJsonToken.Comment, FCharsReference.ToString);
  ClearRecentString;
end;

procedure TJsonTextReader.ParseConstructor;
var
  InitialPos, EndPos: Integer;
  CurrentChar: Char;
  ConstructorName: string;
begin
  EndPos := 0;
  if MatchValueWithTrailingSeparator(kNew) then
  begin
    EatWhiteSpace(False);
    InitialPos := FCharPos;
    while True do
    begin
      CurrentChar := FChars[FCharPos];
      if CurrentChar = #0 then
      begin
        if FCharsUsed = FCharPos then
        begin
          if ReadData(True) = 0 then
            raise EJsonReaderException.Create(Self, SUnexpectedConstructorEnd);
        end
        else
        begin
          EndPos := FCharPos;
          Inc(FCharPos);
          Break;
        end;
      end
      else if CurrentChar.IsLetterOrDigit then
        Inc(FCharPos)
      else if CurrentChar = #13 then
      begin
        EndPos := FCharPos;
        ProcessCarriageReturn(True);
        Break;
      end
      else if CurrentChar = #10 then
      begin
        EndPos := FCharPos;
        ProcessLineFeed;
        Break;
      end
      else if CurrentChar.IsWhiteSpace then
      begin
        EndPos := FCharPos;
        Inc(FCharPos);
        Break;
      end
      else if CurrentChar = '(' then
      begin
        EndPos := FCharPos;
        Break;
      end
      else
        ReaderError(SUnexpectedCharConstructor, CurrentChar);
    end;

    FCharsReference.SetReference(@FChars[InitialPos], EndPos - InitialPos);
    ConstructorName := FCharsReference.ToString;

    EatWhiteSpace(False);

    if FChars[FCharPos] <> '(' then
      ReaderError(SUnexpectedCharConstructor, FChars[FCharPos]);

    Inc(FCharPos);

    ClearRecentString;

    SetToken(TJsonToken.StartConstructor, ConstructorName);
  end
  else
    ReaderError(SUnexpectedJsonContent);
end;

procedure TJsonTextReader.ParseFalse;
begin
  if MatchValueWithTrailingSeparator(kFalse) then
    SetToken(TJsonToken.Boolean, FalseValue)
  else
    raise EJsonReaderException.Create(Self, SParseErrorBoolean);
end;

procedure TJsonTextReader.ParseNull;
begin
  if MatchValueWithTrailingSeparator(kNull) then
    SetToken(TJsonToken.Null)
  else
    raise EJsonReaderException.Create(Self, SParseErrorNull);
end;

procedure TJsonTextReader.ParseNumber;

 function TryReadAsInt(const AValue: string): Boolean;
  var
    I: Integer;
    L: Int64;
    LValue: TValue;
  begin
    Result := TryStrToInt(AValue, I);
    if Result then
    begin
      LValue := I;
      SetToken(TJsonToken.Integer, LValue, False)
    end
    else
    begin
      Result := TryStrToInt64(AValue, L);
      if Result then
      begin
        LValue := L;
        SetToken(TJsonToken.Integer, LValue, False);
      end;
    end;
  end;

  function TryReadAsFloat(const AValue: string): Boolean;
  var
    D: Double;
  begin
    Result := TryStrToFloat(AValue, D, FFormatSettings);
    if Result then
      SetToken(TJsonToken.Float, D, False);
  end;

var
  InitialPos: Integer;
  NumberStr: string;
begin
  ShiftBufferIfNeeded;
  InitialPos := FCharPos;

  ReadNumberIntoBuffer;

  SetPostValueState(True);

  FCharsReference.SetReference(@FChars[InitialPos], FCharPos - InitialPos);
  NumberStr := FCharsReference.ToString;

  case FReadType of
    TReadType.ReadAsInteger:
      begin
        if not TryReadAsInt(NumberStr) then
          ReaderError(SInputInvalidInteger, NumberStr);
      end;
    TReadType.ReadAsDouble:
      begin
        if not TryReadAsFloat(NumberStr) then
          ReaderError(SInputInvalidDouble, NumberStr);
      end;
    else
      begin
        if not TryReadAsInt(NumberStr) then
          if not TryReadAsFloat(NumberStr) then
            ReaderError(SInputInvalidNumber, NumberStr);
      end;
  end;
  ClearRecentString;
end;

procedure TJsonTextReader.ParseNumberNaN;
begin
  if MatchValueWithTrailingSeparator(kNan) then
    SetToken(TJsonToken.Float, Double.NaN)
  else
    raise EJsonReaderException.Create(Self, SParseErrorNan);
end;

procedure TJsonTextReader.ParseNumberNegativeInfinity;
begin
  if MatchValueWithTrailingSeparator(kNegativeInfinity) then
    SetToken(TJsonToken.Float, Double.NegativeInfinity)
  else
    raise EJsonReaderException.Create(Self, SParseErrorPositiveInfinity);
end;

procedure TJsonTextReader.ParseNumberPositiveInfinity;
begin
  if MatchValueWithTrailingSeparator(kPositiveInfinity) then
    SetToken(TJsonToken.Float, Double.PositiveInfinity)
  else
    raise EJsonReaderException.Create(Self, SParseErrorNegativeInfinity);
end;

function TJsonTextReader.ParseObject: Boolean;
var
  LCurrentChar: Char;
begin
  while True do
  begin
    LCurrentChar := FChars[FCharPos];
    case LCurrentChar of
      #0:
      begin
        if FCharsUsed = FCharPos then
        begin
          if ReadData(False) = 0 then
            Exit(False);
        end
        else
          Inc(FCharPos);
      end;
      '}':
      begin
        SetToken(TJsonToken.EndObject);
        Inc(FCharPos);
        Exit(True);
      end;
      '/':
      begin
        ParseComment;
        Exit(True);
      end;
      #13: // \r
        ProcessCarriageReturn(False);
      #10: // \n
        ProcessLineFeed;
      ' ',
      #9: // \t
        Inc(FCharPos);
      else
      begin
        if LCurrentChar.IsWhiteSpace then
          Inc(FCharPos)
        else
          Exit(ParseProperty);
      end;
    end;
  end;
end;

function TJsonTextReader.ParsePostValue: Boolean;
var
  LCurrentChar: Char;
begin
  while True do
  begin
    LCurrentChar := FChars[FCharPos];
    case LCurrentChar of
      #0:
      begin
        if FCharsUsed = FCharPos then
        begin
          if ReadData(False) = 0 then
          begin
            FCurrentState := TState.Finished;
            Exit(False)
          end;
        end
        else
          Inc(FCharPos);
      end;
      '}':
      begin
        Inc(FCharPos);
        SetToken(TJsonToken.EndObject);
        Exit(True);
      end;
      ']':
      begin
        Inc(FCharPos);
        SetToken(TJsonToken.EndArray);
        Exit(True);
      end;
      ')':
      begin
        Inc(FCharPos);
        SetToken(TJsonToken.EndConstructor);
        Exit(True);
      end;
      '/':
      begin
        ParseComment;
        Exit(True);
      end;
      ',':
      begin
        Inc(FCharPos);
        // finished parsing
        SetStateBasedOnCurrent;
        Exit(False);
      end;
      ' ',
      #9: // \t
        Inc(FCharPos);
      #13: // \r
        ProcessCarriageReturn(False);
      #10: // \r
        ProcessLineFeed;
    else
      if LCurrentChar.IsWhiteSpace then
        Inc(FCharPos)
      else
        raise EJsonReaderException.Create(Self, SUnexpecteCharAfterValue);
    end;
  end;
end;

function TJsonTextReader.ParseProperty: Boolean;
var
  LQuoteChar: Char;
  PropertyName: string;
begin
  LQuoteChar := FChars[FCharPos];

  if (LQuoteChar = '"') or (LQuoteChar = '''') then
  begin
    Inc(FCharPos);
    ShiftBufferIfNeeded;
    ReadStringIntoBuffer(LQuoteChar);
  end
  else if ValidIdentifierChar(LQuoteChar) then
  begin
    LQuoteChar := #0;
    ShiftBufferIfNeeded;
    ParseUnquotedProperty;
  end
  else
    ReaderError(SInvalidPropertyCharacter, FChars[FCharPos]);

  PropertyName := FCharsReference.ToString;
  EatWhiteSpace(False);

  if FChars[FCharPos] <> ':' then
    ReaderError(SInvalidCharacterAfterProperty, FChars[FCharPos]);
  Inc(FCharPos);

  SetToken(TJsonToken.PropertyName, PropertyName);
  FQuoteChar := LQuoteChar;
  ClearRecentString;

  Result := True;
end;

procedure TJsonTextReader.ParseString(Quote: Char);
var
  Data: TBytes;
  LString: string;
  LDateTime: TDateTime;
  Oid: TJsonOid;
  LValue: TValue;
begin
  Inc(FCharPos);
  ShiftBufferIfNeeded;
  ReadStringIntoBuffer(Quote);
  SetPostValueState(True);
  LString := FCharsReference.ToString;
  case FReadType of

    TReadType.ReadAsBytes:
    begin
      if LString = '' then
        SetLength(Data, 0)
      else
        Data := TNetEncoding.Base64.DecodeStringToBytes(LString);
      LValue := TValue.From<TBytes>(Data);
      SetToken(TJsonToken.Bytes, LValue, False);
    end;

    TReadType.ReadAsOid:
    begin
      Oid.AsString := LString;
      LValue := TValue.From<TJsonOid>(Oid);
      SetToken(TJsonToken.Oid, LValue, False);
    end;

    TReadType.ReadAsString:
    begin
      LValue := TValue.From<string>(LString);
      SetToken(TJsonToken.String, LValue, False);
      FQuoteChar := Quote;
    end;

  else
    if (FDateParseHandling = TJsonDateParseHandling.DateTime) and TryISO8601ToDate(LString, LDateTime, True) then
    begin
      LValue := TValue.From<TDateTime>(LDateTime);
      SetToken(TJsonToken.Date, LValue, False);
    end
    else
    begin
      LValue := TValue.From<string>(LString);
      SetToken(TJsonToken.String, LValue, False);
      FQuoteChar := Quote;
    end;
  end;
end;

procedure TJsonTextReader.ParseTrue;
begin
  if MatchValueWithTrailingSeparator(kTrue) then
    SetToken(TJsonToken.Boolean, TrueValue)
  else
    raise EJsonReaderException.Create(Self, SParseErrorBoolean);
end;

procedure TJsonTextReader.ParseUndefined;
begin
  if MatchValueWithTrailingSeparator(kUndefined) then
    SetToken(TJsonToken.Undefined)
  else
    raise EJsonReaderException.Create(Self, SParseErrorUndefined);
end;

function TJsonTextReader.ParseUnicode: Char;

  function HexToDec(const AValue: Char): Integer;
  begin
    if AValue > '9' then
      if AValue > 'F' then
        Exit(Ord(AValue) - Ord('a') + 10)
      else
        Exit(Ord(AValue) - Ord('A') + 10)
    else
      Exit(Ord(AValue) - Ord('0'));
  end;

begin
  if EnsureChars(4, true) then
  begin
    Result := Char(HexToDec(FChars[FCharPos]) shl 12);
    Result := Char(Ord(Result) or (HexToDec(FChars[FCharPos + 1]) shl 8));
    Result := Char(Ord(Result) or (HexToDec(FChars[FCharPos + 2]) shl 4));
    Result := Char(Ord(Result) or HexToDec(FChars[FCharPos + 3]));
    Inc(FCharPos, 4);
  end
  else
    raise EJsonReaderException.Create(Self, SUnexpectedUnicodeCharEnd);
end;

procedure TJsonTextReader.ParseUnquotedProperty;
var
  InitialPos: Integer;
  LCurrentChar: Char;
begin
  InitialPos := FCharPos;

  while True do
  begin
    case FChars[FCharPos] of
      #0:
      begin
        if FCharsUsed = FCharPos then
        begin
          if ReadData(True) = 0 then
            raise EJsonReaderException.Create(Self, SUnexpectedUnquotedPropertyEnd);
        end;
        FCharsReference.SetReference(@FChars[InitialPos], FCharPos - InitialPos);
      end;
      else
      begin
        LCurrentChar := FChars[FCharPos];
        if ValidIdentifierChar(LCurrentChar) then
          Inc(FCharPos)
        else if LCurrentChar.IsWhiteSpace or (LCurrentChar = ':') then
        begin
          FCharsReference.SetReference(@FChars[InitialPos], FCharPos - InitialPos);
          Exit;
        end
        else
          ReaderError(SInvalidJavascriptProperty, LCurrentChar);
      end;
    end;
  end;
end;

function TJsonTextReader.ParseExtendedStrictModeValue: Boolean;
var
  LPropName: string;
  Re: TJsonRegEx;
  Ref: TJsonDBRef;
  Cws: TJsonCodeWScope;
  I: Integer;

  function IsNextChar(const AChar: Char): Boolean;
  begin
    EatWhitespace(False);
    Result := EnsureChars(1, True) and (FChars[FCharPos] = AChar);
  end;

  function IsNextKey(const AKey: String): Boolean;
  begin
    Inc(FCharPos);
    EatWhiteSpace(False);
    ParseProperty;
    Result := LowerCase(FCurrentPosition.PropertyName) = AKey;
  end;

  procedure Error(const AProp, AExp: String);
  begin
    raise EJsonReaderException.CreateFmt(Self, SUnexpectedExtJSONToken, [AProp, AExp]);
  end;

begin
  Result := False;
  ParseProperty;
  LPropName := LowerCase(FCurrentPosition.PropertyName);
  if LPropName = JsonExtOidPropertyName then
  begin
    FReadType := TReadType.ReadAsOid;
    ParseValue;
    Exit(True);
  end
  else if LPropName = JsonExtBinaryPropertyName then
  begin
    FReadType := TReadType.ReadAsBytes;
    ParseValue;
    if IsNextChar(',') then
                                                           
      while EnsureChars(1, True) and (FChars[FCharPos] <> '}') do
        Inc(FCharPos);
    Exit(True);
  end
  else if LPropName = JsonExtDatePropertyName then
  begin
    ReadAsDateTime;
    Exit(True);
  end
  else if LPropName = JsonExtRegexPropertyName then
  begin
    Re.RegEx := ReadAsString;
    if (IsNextChar(',') and IsNextKey(JsonExtOptionsPropertyName)) then
      Re.Options := ReadAsString;
    SetToken(TJsonToken.RegEx, TValue.From<TJsonRegEx>(Re), False);
    Exit(True);
  end
  else if LPropName = JsonExtRefPropertyName then
  begin
                                                                             
                                              
    Ref.Ref := ReadAsString;
    if not (IsNextChar(',') and IsNextKey(JsonExtIdPropertyName)) then
      Error(JsonExtRefPropertyName, JsonExtIdPropertyName);
    FReadType := TReadType.ReadAsOid;
    ParseValue;
    Ref.Id := Value.AsType<TJsonOid>;
    if IsNextChar(',') then
    begin
      if not IsNextKey(JsonExtDbPropertyName) then
        Error(JsonExtRefPropertyName, JsonExtDbPropertyName);
      Ref.DB := ReadAsString;
    end
    else
      Ref.DB := '';
    SetToken(TJsonToken.DBRef, TValue.From<TJsonDBRef>(Ref), False);
    Exit(True);
  end
  else if LPropName = JsonExtCodePropertyName then
  begin
    Cws.Code := ReadAsString;
    SetLength(Cws.Scope, 0);
    if IsNextChar(',') then
    begin
      if not (IsNextKey(JsonExtScopePropertyName) and IsNextChar('{')) then
        Error(JsonExtCodePropertyName, JsonExtScopePropertyName);
      Inc(FCharPos);
      repeat
        I := Length(Cws.Scope);
        SetLength(Cws.Scope, I + 1);
        ParseProperty;
        Cws.Scope[I].ident := FCurrentPosition.PropertyName;
        Cws.Scope[I].value := ReadAsString;
      until not IsNextChar(',');
      if not IsNextChar('}') then
        Error(JsonExtCodePropertyName, '}');
    end;
    SetToken(TJsonToken.CodeWScope, TValue.From<TJsonCodeWScope>(Cws), False);
    Exit(True);
  end
  else if LPropName = JsonExtUndefinedPropertyName then
  begin
    ParseTrue;
    Exit(True);
  end
  else if LPropName = JsonExtMinKeyPropertyName then
  begin
    if ReadAsInteger <> 1 then
      Error(JsonExtMinKeyPropertyName, '1');
    SetToken(TJsonToken.MinKey);
    Exit(True);
  end
  else if LPropName = JsonExtMaxKeyPropertyName then
  begin
    if ReadAsInteger <> 1 then
      Error(JsonExtMaxKeyPropertyName, '1');
    SetToken(TJsonToken.MaxKey);
    Exit(True);
  end
  else if LPropName = JsonExtNumberLongPropertyName then
  begin
    ReadAsInt64;
    Exit(True);
  end;
end;

function TJsonTextReader.ParseValue: Boolean;
var
  LCurrentChar: Char;
  LStartObject: Boolean;
  LPrevCharPos: Integer;
begin
  while True do
  begin
    LCurrentChar := FChars[FCharPos];
    case LCurrentChar of
      #0:
      begin
        if FCharsUsed = FCharPos then
        begin
          if ReadData(False) = 0 then
            Exit(False)
        end
        else
          Inc(FCharPos);
      end;
      '"',
      '''':
      begin
        ParseString(LCurrentChar);
        Exit(True);
      end;
      't':
      begin
        ParseTrue;
        Exit(True);
      end;
      'f':
      begin
        ParseFalse;
        Exit(True);
      end;
      'n':
      begin
        if EnsureChars(1, True) then
        begin
          case FChars[FCharPos + 1] of
            'u': ParseNull;
            'e': ParseConstructor;
            else
              raise EJsonReaderException.Create(Self, SUnexpectedCharValue);
          end;
        end
        else
          raise EJsonReaderException.Create(Self, SUnexpectedEnd);
        Exit(True);
      end;
      'N':
      begin
        ParseNumberNaN;
        Exit(True);
      end;
      'I':
      begin
        ParseNumberPositiveInfinity;
        Exit(True);
      end;
      '-':
      begin
        if EnsureChars(1, True) and (FChars[FCharPos + 1] = 'I') then
          ParseNumberNegativeInfinity
        else
          ParseNumber;
        Exit(True);
      end;
      '/':
      begin
        ParseComment;
        Exit(True);
      end;
      'u':
      begin
        ParseUndefined;
        Exit(True);
      end;
      '{':
      begin
        Inc(FCharPos);
        LStartObject := True;
        if ExtendedJsonMode = TJsonExtendedJsonMode.StrictMode then
        begin
          EatWhitespace(False);
          if EnsureChars(2, True) and
             ((FChars[FCharPos] = '"') or (FChars[FCharPos] = '''')) and
             (FChars[FCharPos + 1] = '$') then
          begin
            EnsureChars(JsonExtMaxPropertyNameLen + 2, True);
            LPrevCharPos := FCharPos;
            if ParseExtendedStrictModeValue then
            begin
              LStartObject := False;
              EatWhitespace(False);
              if EnsureChars(1, True) and (FChars[FCharPos] = '}') then
                Inc(FCharPos);
            end
            else
              FCharPos := LPrevCharPos;
          end;
        end;
        if LStartObject then
          SetToken(TJsonToken.StartObject);
        Exit(True);
      end;
      '[':
      begin
        Inc(FCharPos);
        SetToken(TJsonToken.StartArray);
        Exit(True);
      end;
      ']':
      begin
        Inc(FCharPos);
        SetToken(TJsonToken.EndArray);
        Exit(True);
      end;
      ',':
      begin
        // don't increment position, the next call to read will handle comma
        // this is done to handle multiple empty comma values
        SetToken(TJsonToken.Undefined);
        Exit(True);
      end;
      ')':
      begin
        Inc(FCharPos);
        SetToken(TJsonToken.EndConstructor);
        Exit(True);
      end;
      #13: // \r
        ProcessCarriageReturn(False);
      #10: // \n
        ProcessLineFeed;
      ' ',
      #9:  // \t
        Inc(FCharPos);
      else
        if LCurrentChar.IsWhiteSpace then
          Inc(FCharPos)
        else if LCurrentChar.IsNumber or (LCurrentChar = '-') or (LCurrentChar = '.') then
        begin
          ParseNumber;
          Exit(True);
        end
        else
          ReaderError(SUnexpectedCharValue, LCurrentChar);
    end;
  end;
end;

procedure TJsonTextReader.ProcessCarriageReturn(Append: Boolean);
begin
  Inc(FCharPos);
  if EnsureChars(1, Append) and (FChars[FCharPos] = #10) then
    Inc(FCharPos);
  OnNewLine(FCharPos);
end;

procedure TJsonTextReader.ProcessLineFeed;
begin
  Inc(FCharPos);
  OnNewLine(FCharPos);
end;

function TJsonTextReader.ReadData(Append: Boolean): Integer;
begin
  Result := ReadData(Append, 0);
end;

function TJsonTextReader.ReadChars(RelativePosition: Integer; Append: Boolean): Boolean;
var
  CharsRequired, TotalCharsRead, charsRead: Integer;
begin
  if FIsEndOfFile then
    Exit(False);

  CharsRequired := FCharPos + RelativePosition - FCharsUsed + 1;
  TotalCharsRead := 0;

  // it is possible that the TextReader doesn't return all data at once
  // repeat read until the required text is returned or the reader is out of content
  repeat
    CharsRead := ReadData(Append, CharsRequired - TotalCharsRead);
    // no more content
    if CharsRead = 0 then
      Break;
    TotalCharsRead := TotalCharsRead + CharsRead;
  until TotalCharsRead >= CharsRequired;

  if TotalCharsRead < CharsRequired then
    Result := False
  else
    Result := True;
end;

function TJsonTextReader.ReadData(Append: Boolean; CharsRequired: Integer): Integer;
var
  RemainingCharsCount,
  RequiredSize,
  AttemptCharReadCount,
  CharsRead: Integer;
begin
  if FIsEndOfFile then
    Exit(0);

  if FCharsUsed + CharsRequired >= Length(FChars) - 1 then
  begin
    if Append then
      SetLength(FChars, Max(Length(FChars) * 2, FCharsUsed + CharsRequired + 1))
    else
    begin
      RemainingCharsCount := FCharsUsed - FCharPos;
      RequiredSize := RemainingCharsCount + CharsRequired + 1;
      if RequiredSize >= Length(FChars) then
        SetLength(FChars, RequiredSize)
      else if RemainingCharsCount > 0 then
        Move(FChars[FCharPos], FChars[0], RemainingCharsCount * SizeOf(Char));

      FLineStartPos := FLineStartPos - FCharPos;
      FCharPos := 0;
      FCharsUsed := RemainingCharsCount;
    end
  end;
  AttemptCharReadCount := Length(FChars) - FCharsUsed - 1;
  CharsRead := FReader.Read(TCharArray(FChars), FCharsUsed, AttemptCharReadCount);
  if CharsRead = -1 then
    CharsRead := 0;
  FCharsUsed := FCharsUsed + CharsRead;

  if CharsRead = 0 then
    FIsEndOfFile := True;

  FChars[FCharsUsed] := Char(#0);
  Result := CharsRead;
end;

function TJsonTextReader.ReadInternal: Boolean;
begin
  while True do
    case FCurrentState of
      TJsonReader.TState.Start,
      TJsonReader.TState.Property,
      TJsonReader.TState.Array,
      TJsonReader.TState.ArrayStart,
      TJsonReader.TState.Constructor,
      TJsonReader.TState.ConstructorStart:
        Exit(ParseValue);
      TJsonReader.TState.Object,
      TJsonReader.TState.ObjectStart:
        Exit(ParseObject);
      TJsonReader.TState.PostValue:
        if ParsePostValue then
          Exit(True);
      TJsonReader.TState.Finished:
      begin
        if EnsureChars(0, False) then
        begin
          EatWhitespace(False);
          if FIsEndOfFile then
            Exit(False);
          if FChars[FCharPos] = '/' then
          begin
            ParseComment;
            Exit(True);
          end;
          ReaderError(SReaderAdditionalText, FChars[FCharPos]);
        end;
        Exit(False);
      end;
      else
        ReaderError(SUnexpectedState, GetName(CurrentState));
    end;
end;

procedure TJsonTextReader.ReadNumberIntoBuffer;
var
  LCharPos: Integer;
  LCurrentChar: Char;
begin
  LCharPos := FCharPos;
  while True do
    case FChars[LCharPos] of
      #0:
      begin
        FCharPos := LCharPos;
        if FCharsUsed = LCharPos then
        begin
          if ReadData(True) = 0 then
            Exit;
        end
        else
          Exit;
      end;
      '-',
      '+',
      'a',
      'A',
      'b',
      'B',
      'c',
      'C',
      'd',
      'D',
      'e',
      'E',
      'f',
      'F',
      'x',
      'X',
      '.',
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9':
        Inc(LCharPos);
      else
      begin
        FCharPos := LCharPos;
        LCurrentChar := FChars[FCharPos];
        if LCurrentChar.IsWhiteSpace
          or (LCurrentChar = ',')
          or (LCurrentChar = '}')
          or (LCurrentChar = ']')
          or (LCurrentChar = ')')
          or (LCurrentChar = '/') then
          Exit
        else
          ReaderError(SUnexpectedCharNumber, LCurrentChar);
      end;
    end;
end;

procedure TJsonTextReader.Rewind;
begin
  inherited Rewind;
  FCharsUsed := 0;
  FCharPos := 0;
  FLineStartPos := 0;
  FLineNumber := 1;
  FIsEndOfFile := False;
end;

procedure TJsonTextReader.ShiftBufferIfNeeded;
var
  Len, LCount: Integer;
begin
  Len := Length(FChars);

  if Len - FCharPos <= Len * 0.1 then
  begin
    LCount := FCharsUsed - FCharPos;
    if LCount > 0 then
      Move(FChars[FCharPos], FChars[0], LCount* SizeOf(Char));

    FLineStartPos := FLineStartPos - FCharPos;
    FCharPos := 0;
    FCharsUsed := LCount;
    FChars[FCharsUsed] := Char(#0);
  end;
end;

function TJsonTextReader.ValidIdentifierChar(AValue: Char): Boolean;
begin
  Result := AValue.IsLetterOrDigit or (AValue = '_') or (AValue = '$');
end;

procedure TJsonTextReader.WriteCharToBuffer(const Buffer: TStringBuffer; WriteChar: Char; LastWritePosition,
  WriteToPosition: Integer);
begin
  if WriteToPosition > LastWritePosition then
    Buffer.Append(TCharArray(FChars), LastWritePosition, WriteToPosition - LastWritePosition);
 Buffer.Append(WriteChar);
end;

initialization
  EmptyValue := TValue.Empty;
  FalseValue := TValue.From<Boolean>(False);
  TrueValue := TValue.From<Boolean>(True);
end.

