{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.JSON.BSON;

interface

{$SCOPEDENUMS ON}

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.Rtti,
  System.JSON.Types, System.JSON.Writers, System.JSON.Readers;

type
  /// <summary>
  /// Code of each bson type. See http://bsonspec.org/spec.html
  /// </summary>
  TBsonType = (
    BsonDocument = 0,
    Float = 1,
    &String = 2,
    &Object = 3,
    &Array = 4,
    Binary = 5,
    Undefined = 6,
    Oid = 7,
    Boolean = 8,
    DateTime = 9,
    Null = 10,
    Regex = 11,
    Reference = 12,
    Code = 13,
    Symbol = 14,
    CodeWScope = 15,
    Integer = 16,
    TimeStamp = 17,
    Long = 18,
    MinKey = 255,
    MaxKey = 127
  );

  /// <summary>
  /// Writer to serialize data into Bson. See http://bsonspec.org/
  /// </summary>
  TBsonWriter = class(TJsonWriter)
  private
    type
      TBsonContainer = class abstract
      private
        [Weak] FParent: TBsonContainer;
        FPosition: Integer;
        FValuesSize: Integer;
        FChildren: TObjectList<TBsonContainer>;
      public
        constructor Create(AParent: TBsonContainer; SizePos: Integer);
        destructor Destroy; override;
        property Children: TObjectList<TBsonContainer> read FChildren;
        property ValuesSize: Integer read FValuesSize write FValuesSize;
        property Position: Integer read FPosition write FPosition;
        property Parent: TBsonContainer read FParent write FParent;
      end;

      TBsonObject = class(TBsonContainer)
      end;

      TBsonArray = class(TBsonContainer)
      private
        FIndex: Integer;
      public
        property &Index: Integer read FIndex write FIndex;
      end;
  private
    FEncoding: TEncoding;
    FWriter: TBinaryWriter;
    FWriterOwner: Boolean;
    FRoot: TBsonContainer;
    FParent: TBsonContainer;
    FPropertyName: string;
    procedure AddContainer(const Token: TBsonContainer);
    procedure AddSize(Size: Integer); inline;
    function WriteContainerSize(Container: TBsonContainer): Integer;
    procedure WriteType(BsonType: TBsonType);
    procedure WriteKey;
    procedure WriteInteger(const Value: Integer);
    procedure WriteInt64(const Value: Int64);
    procedure WriteDouble(const Value: Double);
    procedure WriteString(const Value: string);
    procedure WriteCString(const Value: string);
    procedure WriteBytes(const Value: TBytes; BinaryType: TJsonBinaryType);
    procedure WriteBoolean(const Value: Boolean);
    procedure WriteOid(const Value: TJsonOid);
    procedure InternalWriteStartObject(Inlined: Boolean);
  protected
    /// <summary> Write the end token based on the token, this method does not updates the internal state </summary>
    /// <remarks> When the token to be written is the last end token, the document it will be flushed. See <see cref="Flush"> </remarks>
    procedure WriteEnd(const Token: TJsonToken); override;
  public
    constructor Create(const ABinaryWriter: TBinaryWriter); overload;
    constructor Create(const Stream: TStream); overload;
    destructor Destroy; override;
    /// <sumary> Resets the internal state allowing write from the begining </sumary>
    procedure Rewind; override;
    /// <summary> Close the writer and flushes the document. See <see cref="Flush"> </summary>
    procedure Close; override;
    /// <summary>
    /// Calculates and writes the preceding size of each object/array written in the underliying stream/BinaryWriter.
    /// If the document is not finished (the last end token is not written yet) the containers will be closed by written
    /// the end token but without updating the internal writer state
    /// </summary>
    procedure Flush; override;
    /// <summary> Writes a comment</summary>
    procedure WriteComment(const Comment: string); override;
    /// <summary> Writes the start of a json object </summary>
    procedure WriteStartObject; override;
    /// <summary> Writes the end of a json object </summary>
    procedure WriteEndObject; override;
    /// <summary> Writes the start of a json array </summary>
    procedure WriteStartArray; override;
    /// <summary> Writes the end of a json array </summary>
    procedure WriteEndArray; override;
    /// <summary> Writes the start of a javascript constructor </summary>
    procedure WriteStartConstructor(const Name: string); override;
    /// <summary> Writes a property name </summary>
    procedure WritePropertyName(const Name: string); override;
    /// <summary> Writes a null value </summary>
    procedure WriteNull; override;
    /// <summary> Writes a raw json, it does not update the internal state </summary>
    procedure WriteRaw(const Json: string); override;
    /// <summary> Writes a raw json, it updates the internal state </summary>
    procedure WriteRawValue(const Json: string); override;
    /// <summary> Writes an undefined value </summary>
    procedure WriteUndefined; override;
    /// <summary> Writes an string value </summary>
    procedure WriteValue(const Value: string); override;
    /// <summary> Writes an Integer value </summary>
    procedure WriteValue(Value: Integer); override;
    /// <summary> Writes an UInt32 value </summary>
    procedure WriteValue(Value: UInt32); override;
    /// <summary> Writes an Int64 value </summary>
    procedure WriteValue(Value: Int64); override;
    /// <summary> Writes an UInt64 value value </summary>
    procedure WriteValue(Value: UInt64); override;
    /// <summary> Writes a Single value </summary>
    procedure WriteValue(Value: Single); override;
    /// <summary> Writes a Double value </summary>
    procedure WriteValue(Value: Double); override;
    /// <summary> Writes an Extended value </summary>
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
    /// <summary> Writes a MinKey value. See http://bsonspec.org/spec.html </summary>
    procedure WriteMaxKey; override;
    // BSON specific extensions
    procedure WriteCode(const Code: string);
    /// <summary> Gets the underliying binary Writer </summary>
    /// <remarks> When the TStream overload constructor is used the returned Writer is owned by this class </remarks>
    property Writer: TBinaryWriter read FWriter;
  end;

  /// <summary>
  ///  Reader to access Bson data. See http://bsonspec.org/
  /// </summary>
  TBsonReader = class(TJsonReader)
  private
    const
      MaxCharBytesSize = 128;
      CodeWScopeKey = '$code'; // do not localize
    type
      TContainerContext = class
      public
        &Type: TBsonType;
        Length: Integer;
        Position: Integer;
        constructor Create(AType: TBsonType);
      end;
  private
    FEncoding: TEncoding;
    FCurrentElementType: TBsonType;
    FReadRootValueAsArray: Boolean;
    FReader: TBinaryReader;
    FStack: TObjectStack<TContainerContext>;
    FCurrentContext: TContainerContext;
    FByteBuffer: TBytes;
    FCharBuffer: TCharArray;
    function ReadElement: string;
    function ReadCodeWScope: TJsonCodeWScope;
    function ReadRegEx: TJsonRegEx;
    function ReadDBRef: TJsonDBRef;
    function ReadDouble: Double;
    function ReadInteger: Integer;
    function ReadInt64: Int64;
    function ReadByte: Byte;
    function ReadString: string; overload;
    function ReadString(ALength: Integer): string; overload;
    function ReadCString: string;
    function ReadType: TBsonType;
    procedure ReadByType(AType: TBsonType);
    function ReadBinary(out BinaryType: TJsonBinaryType): TBytes;
    function ReadBytes(Count: Integer): TBytes;
    procedure MovePosition(Count: Integer); inline;
    procedure PopContext(FreeContext: Boolean);
    procedure PushContext(const Context: TContainerContext);
  protected
    function ReadInternal: Boolean; override;
  public
    constructor Create(const AStream: TStream; AReadAsRootValuesArray: Boolean = False);
    destructor Destroy; override;
    /// <summary> Changes the <see cref="TJsonReader.TState"/> to Closed. </summary>
    procedure Close; override;
    /// <summary> Skips the children of the current token </summary>
    procedure Skip; override;
    /// <summary> Resets the reader state to start read again </summary>
    procedure Rewind; override;
    /// <summary> Indicating whether the root object will be read as JSON array </summary>
    property ReadRootValueAsArray: Boolean read FReadRootValueAsArray write FReadRootValueAsArray;
    /// <summary> Gets the current bson type element </summary>
    property CurrentElementType: TBsonType read FCurrentElementType;
    /// <summary> Gets the underlying reader </summary>
    property Reader: TBinaryReader read FReader;
  end;

implementation

uses
  System.TypInfo, System.DateUtils, System.Math, System.JSONConsts, System.JSON.Utils;

{ Helpers }

function GetName(Value: TJsonToken): string; overload;
begin
  Result := GetEnumName(TypeInfo(TJsonToken), Integer(Value));
end;

{ TBsonWriter }

constructor TBsonWriter.Create(const ABinaryWriter: TBinaryWriter);
begin
  inherited Create;
  FEncoding := TEncoding.UTF8;
  FWriter := ABinaryWriter;
end;

constructor TBsonWriter.Create(const Stream: TStream);
begin
  Create(TBinaryWriter.Create(Stream));
  FWriterOwner := True;
end;

procedure TBsonWriter.AddSize(Size: Integer);
begin
  FParent.ValuesSize := FParent.ValuesSize + Size;
end;

procedure TBsonWriter.AddContainer(const Token: TBsonContainer);
begin
  if FParent <> nil then
    FParent.Children.Add(Token)
  else
    FRoot := Token;
  FParent := Token;
end;

destructor TBsonWriter.Destroy;
begin
  if FCurrentState <> TState.Closed then
    Close;
  if FRoot <> nil then
    FreeAndNil(FRoot);
  if FWriterOwner then
    FWriter.Free;
  inherited Destroy;
end;

function TBsonWriter.WriteContainerSize(Container: TBsonContainer): Integer;
var
  ChildContainer: TBsonContainer;
begin
  // Size + ValuesSize + EndSize
  Result := SizeOf(Integer) + Container.ValuesSize + SizeOf(Byte);
  for ChildContainer in Container.Children do
    Result :=  Result + WriteContainerSize(ChildContainer) ;

  FWriter.BaseStream.Position := Container.Position;
  FWriter.Write(Result);
end;

procedure TBsonWriter.Close;
begin
  inherited Close;
  FreeAndNil(FRoot);
end;

procedure TBsonWriter.Flush;
var
  LastPosition, I, ValuesSize: Integer;
begin
  if FCurrentState = TState.Start then
    Exit;

  LastPosition := FWriter.BaseStream.Position;

  // if we are in a property write it as null
  if FCurrentState = TState.Property then
  begin
    ValuesSize := FParent.ValuesSize;
    WriteType(TBsonType.Null);
    WriteKey;
  end
  else
    ValuesSize := 0;

  // close all opened containers
  for I := 1 to Top do
    FWriter.Write(Byte(0));
  WriteContainerSize(FRoot);
  // restore the property size
  if FCurrentState = TState.Property then
    FParent.ValuesSize := ValuesSize;

  FWriter.BaseStream.Position := LastPosition;
end;

procedure TBsonWriter.Rewind;
begin
  inherited Rewind;
  FParent := nil;
  FPropertyName := '';
  FreeAndNil(FRoot);
end;

procedure TBsonWriter.WriteBoolean(const Value: Boolean);
begin
  FWriter.Write(Value);
  AddSize(SizeOf(Boolean));
end;

procedure TBsonWriter.WriteBytes(const Value: TBytes; BinaryType: TJsonBinaryType);
begin
  FWriter.Write(Integer(Length(Value)));
  FWriter.Write(Byte(BinaryType));
  FWriter.Write(Value);
  AddSize(SizeOf(Integer) + SizeOf(Byte) + Length(Value));
end;

procedure TBsonWriter.WriteString(const Value: string);
var
  Bytes: TBytes;
begin
  Bytes := FEncoding.GetBytes(Value);
  FWriter.Write(Integer(Length(Bytes) + SizeOf(Byte))); // string byte size + null termination
  FWriter.Write(Bytes);
  FWriter.Write(Byte(0));
  AddSize(SizeOf(Integer) + Length(Bytes) + SizeOf(Byte));
end;

procedure TBsonWriter.WriteCString(const Value: string);
var
  Bytes: TBytes;
begin
  Bytes := FEncoding.GetBytes(Value);
  FWriter.Write(Bytes);
  FWriter.Write(Byte(0));
  AddSize(Length(Bytes) + SizeOf(Byte));
end;

procedure TBsonWriter.WriteDouble(const Value: Double);
begin
  FWriter.Write(Value);
  AddSize(SizeOf(Double));
end;

procedure TBsonWriter.WriteOid(const Value: TJsonOid);
var
  Bytes: TBytes;
begin
  Bytes := BytesOf(@Value.bytes[0], SizeOf(Value.bytes));
  FWriter.Write(Bytes);
  AddSize(Length(Bytes));
end;

procedure TBsonWriter.WriteEnd(const Token: TJsonToken);
begin
  inherited WriteEnd(Token);
  if Top = 0 then
    Flush;
end;

procedure TBsonWriter.WriteInt64(const Value: Int64);
begin
  FWriter.Write(Value);
  AddSize(SizeOf(Int64));
end;

procedure TBsonWriter.WriteInteger(const Value: Integer);
begin
  FWriter.Write(Value);
  AddSize(SizeOf(Integer));
end;

procedure TBsonWriter.WriteKey;
begin
  if FParent is TBsonObject then
    WriteCString(FPropertyName)
  else if FParent is TBsonArray then
  begin
    WriteCString(TBsonArray(FParent).Index.ToString);
    TBsonArray(FParent).Index := TBsonArray(FParent).Index + 1;
  end;
end;

procedure TBsonWriter.WriteType(BsonType: TBsonType);
begin
  FWriter.Write(Byte(BsonType));
  AddSize(SizeOf(Byte));
end;

procedure TBsonWriter.WriteComment(const Comment: string);
begin
  raise EJsonWriterException.Create(SUnsupportedCommentBson);
end;

procedure TBsonWriter.WriteNull;
begin
  inherited WriteNull;
  WriteType(TBsonType.Null);
  WriteKey;
end;

procedure TBsonWriter.WriteStartConstructor(const Name: string);
begin
  raise EJsonWriterException.Create(SUnsupportedBsonConstructor);
end;

procedure TBsonWriter.WriteRaw(const Json: string);
begin
  raise EJsonWriterException.Create(SUnsupportedBsonRaw);
end;

procedure TBsonWriter.WriteRawValue(const Json: string);
begin
  raise EJsonWriterException.Create(SUnsupportedBsonRaw);
end;

procedure TBsonWriter.WriteStartArray;
begin
  inherited WriteStartArray;
  if FParent <> nil then
  begin
    WriteType(TBsonType.Array);
    WriteKey;
  end;
  // the size is only knowed after end it (WriteEndArray) so the position is saved to fill it at the end
  AddContainer(TBsonArray.Create(FParent, FWriter.BaseStream.Position));
  FWriter.Write(Integer(0));
end;

procedure TBsonWriter.InternalWriteStartObject(Inlined: Boolean);
begin
  inherited WriteStartObject;
  if (FParent <> nil) and not Inlined then
  begin
    WriteType(TBsonType.Object);
    WriteKey;
  end;
  // the size is only knowed after end it (WriteEndObject) so the position is saved to fill it at the end
  AddContainer(TBsonObject.Create(FParent, FWriter.BaseStream.Position));
  FWriter.Write(Integer(0));
end;

procedure TBsonWriter.WriteStartObject;
begin
  InternalWriteStartObject(False);
end;

procedure TBsonWriter.WriteEndArray;
begin
  inherited WriteEndArray;
  FWriter.Write(Byte(0));
  FParent := FParent.Parent;
end;

procedure TBsonWriter.WriteEndObject;
begin
  inherited WriteEndObject;
  FWriter.Write(Byte(0));
  FParent := FParent.Parent;
end;

procedure TBsonWriter.WriteUndefined;
begin
  inherited WriteUndefined;
  WriteType(TBsonType.Undefined);
  WriteKey;
end;

procedure TBsonWriter.WriteValue(Value: UInt64);
begin
  inherited WriteValue(Value);
  WriteType(TBsonType.Long);
  WriteKey;
  WriteInt64(PInt64(@Value)^);
end;

procedure TBsonWriter.WriteValue(Value: Single);
begin
  inherited WriteValue(Value);
  WriteType(TBsonType.Float);
  WriteKey;
  WriteDouble(Value);
end;

procedure TBsonWriter.WriteValue(Value: Double);
begin
  inherited WriteValue(Value);
  WriteType(TBsonType.Float);
  WriteKey;
  WriteDouble(Value);
end;

procedure TBsonWriter.WriteValue(Value: Int64);
begin
  inherited WriteValue(Value);
  WriteType(TBsonType.Long);
  WriteKey;
  WriteInt64(Value);
end;

procedure TBsonWriter.WriteValue(const Value: string);
begin
  inherited WriteValue(Value);
  if (Length(Value) = 0) and (EmptyValueHandling = TJsonEmptyValueHandling.Null) then
    Exit;
  WriteType(TBsonType.String);
  WriteKey;
  WriteString(Value);
end;

procedure TBsonWriter.WriteValue(Value: Integer);
begin
  inherited WriteValue(Value);
  WriteType(TBsonType.Integer);
  WriteKey;
  WriteInteger(Value);
end;

procedure TBsonWriter.WriteValue(Value: UInt32);
begin
  inherited WriteValue(Value);
  WriteType(TBsonType.Integer);
  WriteKey;
  WriteInteger(PInteger(@Value)^);
end;

procedure TBsonWriter.WriteValue(Value: Extended);
begin
  inherited WriteValue(Value);
  WriteType(TBsonType.Float);
  WriteKey;
  WriteDouble(Value);
end;

procedure TBsonWriter.WriteValue(const Value: TGUID);
begin
  inherited WriteValue(Value);
  WriteValue(Value.ToByteArray, TJsonBinaryType.Uuid);
end;

procedure TBsonWriter.WriteValue(const Value: TBytes;
  BinaryType: TJsonBinaryType = TJsonBinaryType.Generic);
begin
  inherited WriteValue(Value);
  if (Length(Value) = 0) and (EmptyValueHandling = TJsonEmptyValueHandling.Null) then
    Exit;
  WriteType(TBsonType.Binary);
  WriteKey;
  WriteBytes(Value, BinaryType);
end;

procedure TBsonWriter.WriteValue(const Value: TJsonOid);
begin
  inherited WriteValue(Value);
  WriteType(TBsonType.Oid);
  WriteKey;
  WriteOid(Value);
end;

procedure TBsonWriter.WriteValue(Value: TDateTime);
begin
  inherited WriteValue(Value);
  WriteType(TBsonType.DateTime);
  WriteKey;
  WriteInt64(DateTimeToUnix(Value) * 1000);
end;

procedure TBsonWriter.WriteValue(Value: Boolean);
begin
  inherited WriteValue(Value);
  WriteType(TBsonType.Boolean);
  WriteKey;
  WriteBoolean(Value);
end;

procedure TBsonWriter.WriteValue(Value: Char);
begin
  inherited WriteValue(Value);
  WriteType(TBsonType.String);
  WriteKey;
  WriteString(Value);
end;

procedure TBsonWriter.WriteValue(Value: Byte);
begin
  inherited WriteValue(Value);
  WriteType(TBsonType.Integer);
  WriteKey;
  WriteInteger(Value);
end;

procedure TBsonWriter.WriteValue(const Value: TJsonRegEx);
begin
  inherited WriteValue(Value);
  WriteType(TBsonType.Regex);
  WriteKey;
  WriteCString(Value.RegEx);
  WriteCString(Value.Options);
end;

procedure TBsonWriter.WriteValue(const Value: TJsonDBRef);
begin
  inherited WriteValue(Value);
  WriteType(TBsonType.Reference);
  WriteKey;
  WriteString(Value.Ref);
  WriteOid(Value.Id);
end;

procedure TBsonWriter.WriteValue(const Value: TJsonCodeWScope);
var
  LPrevPos: Int64;
  I: Integer;
  LCurPos: Int64;
begin
  inherited WriteValue(Value);
  WriteType(TBsonType.CodeWScope);
  WriteKey;

  LPrevPos := FWriter.BaseStream.Position;
  WriteInteger(0);

  WriteString(Value.Code);
  WritePropertyName('');
  InternalWriteStartObject(True);
  for I := 0 to Length(Value.Scope) - 1 do
  begin
    WritePropertyName(Value.Scope[I].Ident);
    WriteValue(Value.Scope[I].value);
  end;
  WriteEndObject;

  LCurPos := FWriter.BaseStream.Position;
  FWriter.BaseStream.Position := LPrevPos;
  FWriter.Write(Integer(LCurPos - LPrevPos));
  FWriter.BaseStream.Position := LCurPos;
end;

procedure TBsonWriter.WriteMinKey;
begin
  inherited WriteMaxKey;
  WriteType(TBsonType.MinKey);
  WriteKey;
end;

procedure TBsonWriter.WriteMaxKey;
begin
  inherited WriteMaxKey;
  WriteType(TBsonType.MaxKey);
  WriteKey;
end;

procedure TBsonWriter.WriteCode(const Code: string);
begin
  inherited WriteValue(Code);
  WriteType(TBsonType.Code);
  WriteKey;
  WriteString(Code);
end;

procedure TBsonWriter.WritePropertyName(const Name: string);
begin
  inherited WritePropertyName(Name);
  FPropertyName := Name;
end;

{ TBsonReader.TContainerContext }

constructor TBsonReader.TContainerContext.Create(AType: TBsonType);
begin
  &Type := AType;
end;

{ TBsonReader }

procedure TBsonReader.Close;
begin
  inherited Close;
  FStack.Clear;
end;

constructor TBsonReader.Create(const AStream: TStream; AReadAsRootValuesArray: Boolean);
begin
  inherited Create;
  FEncoding := TEncoding.UTF8;
  FReader := TBinaryReader.Create(AStream);
  FStack := TObjectStack<TContainerContext>.Create;
  FReadRootValueAsArray := AReadAsRootValuesArray;
  SetLength(FByteBuffer, MaxCharBytesSize);
  SetLength(FCharBuffer, FEncoding.GetMaxCharCount(MaxCharBytesSize));
end;

destructor TBsonReader.Destroy;
begin
  inherited Destroy;
  FReader.Free;
  FStack.Free;
end;

procedure TBsonReader.MovePosition(Count: Integer);
begin
  Inc(FCurrentContext.Position, Count);
end;

procedure TBsonReader.PopContext(FreeContext: Boolean);
var
  LOwnsObjects: Boolean;
begin
  LOwnsObjects := FStack.OwnsObjects;
  try
    FStack.OwnsObjects := FreeContext;
    FStack.Pop;
    if FStack.Count > 0 then
      FCurrentContext := FStack.Peek
    else
      FCurrentContext := nil;
  finally
    FStack.OwnsObjects := LOwnsObjects;
  end;
end;

procedure TBsonReader.PushContext(const Context: TContainerContext);
begin
  FStack.Push(Context);
  FCurrentContext := Context;
end;

function TBsonReader.ReadBinary(out BinaryType: TJsonBinaryType): TBytes;
var
  LLength: Integer;
begin
  LLength := ReadInteger;
  BinaryType := TJsonBinaryType(ReadByte);

  // the old binary has been obsolte, this is only for compatibility (and it has the length repeated in the data)
  if BinaryType = TJsonBinaryType.BinaryOld then
    LLength := ReadInteger;

  Result := ReadBytes(LLength);
end;

function TBsonReader.ReadByte: Byte;
begin
  Result := FReader.ReadByte;
  MovePosition(1);
end;

function TBsonReader.ReadBytes(Count: Integer): TBytes;
begin
  Result := FReader.ReadBytes(Count);
  MovePosition(Count);
end;

procedure TBsonReader.ReadByType(AType: TBsonType);
var
  Context: TContainerContext;
  BinaryType: TJsonBinaryType;
begin
  case AType of
//    TBsonType.BsonDocument: ;
    TBsonType.Float:
      SetToken(TJsonToken.Float, ReadDouble);
    TBsonType.String,
    TBsonType.Symbol:
      SetToken(TJsonToken.String, ReadString);
    TBsonType.Object:
    begin
      SetToken(TJsonToken.StartObject);
      Context := TContainerContext.Create(TBsonType.Object);
      PushContext(Context);
      Context.Length := ReadInteger;
    end;
    TBsonType.Array:
    begin
      SetToken(TJsonToken.StartArray);
      Context := TContainerContext.Create(TBsonType.Array);
      PushContext(Context);
      Context.Length := ReadInteger;
    end;
    TBsonType.Binary:
      SetToken(TJsonToken.Bytes, TValue.From<TBytes>(ReadBinary(BinaryType)));
    TBsonType.Undefined:
      SetToken(TJsonToken.Undefined);
    TBsonType.Oid:
      SetToken(TJsonToken.Oid, TValue.From<TJsonOid>(TJsonOid.Create(ReadBytes(12))));
    TBsonType.Boolean:
      SetToken(TJsonToken.Boolean, ReadByte <> 0);
    TBsonType.DateTime:
      SetToken(TJsonToken.Date, UnixToDateTime(ReadInt64 div 1000));
    TBsonType.Null:
      SetToken(TJsonToken.Null);
    TBsonType.Regex:
      SetToken(TJsonToken.RegEx, TValue.From<TJsonRegEx>(ReadRegEx));
    TBsonType.Reference:
      SetToken(TJsonToken.DBRef, TValue.From<TJsonDBRef>(ReadDBRef));
    TBsonType.Code:
      SetToken(TJsonToken.String, ReadString);
    TBsonType.CodeWScope:
      SetToken(TJsonToken.CodeWScope, TValue.From<TJsonCodeWScope>(ReadCodeWScope));
    TBsonType.Integer:
      SetToken(TJsonToken.Integer, ReadInteger);
    TBsonType.TimeStamp,
    TBsonType.Long:
      SetToken(TJsonToken.Integer, ReadInt64);
    TBsonType.MinKey:
      SetToken(TJsonToken.MinKey);
    TBsonType.MaxKey:
      SetToken(TJsonToken.MaxKey);
  end;
end;

function TBsonReader.ReadCodeWScope: TJsonCodeWScope;

  procedure Error;
  begin
    raise EJsonReaderException.Create(Self, Format(SUnexpectedTokenCodeWScope, [GetName(TokenType)]));
  end;

var
  I: Integer;
begin
  ReadInteger;
  Result.Code := ReadString;

  ReadByType(TBsonType.Object);
  while ReadInternal and (TokenType <> TJsonToken.EndObject) do begin
    I := Length(Result.Scope);
    SetLength(Result.Scope, I + 1);
    if TokenType <> TJsonToken.PropertyName then
      Error;
    Result.Scope[I].ident := Value.AsString;
    ReadInternal;
    if not IsPrimitiveToken(TokenType) then
      Error;
    Result.Scope[I].value := Value.AsString;
  end;
end;

function TBsonReader.ReadDouble: Double;
begin
  Result := FReader.ReadDouble;
  MovePosition(8);
end;

function TBsonReader.ReadElement: string;
begin
  FCurrentElementType := ReadType;
  Result := ReadCString;
end;

function TBsonReader.ReadInt64: Int64;
begin
  Result := FReader.ReadInt64;
  MovePosition(8);
end;

function TBsonReader.ReadInteger: Integer;
begin
  Result := FReader.ReadInteger;
  MovePosition(4);
end;

function TBsonReader.ReadInternal: Boolean;
var
  JsonToken: TJsonToken;
  BsonType: TBsonType;
  Context: TContainerContext;
  LengthMinusEnd: Integer;
begin
  try
    case CurrentState of
      TState.Start:
      begin
        if FReadRootValueAsArray then
        begin
          JsonToken := TJsonToken.StartArray;
          BsonType := TBsonType.&Array;
        end
        else
        begin
          JsonToken := TJsonToken.StartObject;
          BsonType := TBsonType.&Object;
        end;

        SetToken(JsonToken);
        Context := TContainerContext.Create(BsonType);
        PushContext(Context);
        Context.Length := ReadInteger;
        Result := True;
      end;
      TState.Property:
      begin
        ReadByType(FCurrentElementType);
        Result := True;
      end;
      TState.ObjectStart,
      TState.ArrayStart,
      TState.PostValue:
      begin
        if FCurrentContext <> nil then
        begin
          Context := FCurrentContext;
          LengthMinusEnd := Context.Length - 1;
          if Context.Position < LengthMinusEnd then
          begin
            if Context.&Type = TBsonType.&Array then
            begin
              ReadElement;
              ReadByType(FCurrentElementType);
            end
            else
              SetToken(TJsonToken.PropertyName, ReadElement);
          end
          else if Context.Position = LengthMinusEnd then
          begin
            if ReadByte <> 0 then
              raise EJsonReaderException.Create(Self, SUnexpectedObjectByteEnd);

            PopContext(False);
            try
              if FCurrentContext <> nil then
                MovePosition(Context.Length);

              if Context.&Type = TBsonType.&Object then
                SetToken(TJsonToken.EndObject)
              else
                SetToken(TJsonToken.EndArray);
            finally
              Context.Free;
            end;
          end
          else
            raise EJsonReaderException.Create(SReadErrorContainerEnd);

          Result := True;
        end
        else
          Result := False;
      end;
      TState.Complete,
      TState.Closed,
      TState.ConstructorStart,
      TState.Constructor,
      TState.Error,
      TState.Finished:
        Result := False;
      else
        raise EArgumentOutOfRangeException.Create('');                          
    end;
    if not Result then
      SetToken(TJsonToken.None);
  except
    on E: EStreamError do
      begin
        SetToken(TJsonToken.None);
        Result := False;
      end;
  end;
end;

function TBsonReader.ReadRegEx: TJsonRegEx;
begin
  Result.RegEx := ReadCString;
  Result.Options := ReadCString;
end;

function TBsonReader.ReadDBRef: TJsonDBRef;
begin
  Result.DB := '';
  Result.Ref := ReadString;
  Result.Id.AsBytes := ReadBytes(12);
end;

function TBsonReader.ReadString: string;
var
  LLength: Integer;
begin
  LLength := ReadInteger;
  Result := ReadString(LLength - 1);
  FReader.ReadByte;
  MovePosition(LLength);
end;

function TBsonReader.ReadString(ALength: Integer): string;
begin
  // Ensure the buffer size by the next power of 2 that greater than ALength
  if ALength > Length(FByteBuffer) then
    SetLength(FByteBuffer, Trunc(Power(2, Ceil(Log2(ALength + 0.0000001)))));

  if FReader.Read(FByteBuffer, 0, ALength) = ALength then
    Result := FEncoding.GetString(FByteBuffer, 0, ALength)
  else
    raise EJsonReaderException.Create('');                                           
end;

function TBsonReader.ReadCString: string;
var
  I: Integer;
begin
  I := -1;
  repeat
    Inc(I);

    // Ensure the buffer size
    if Length(FByteBuffer) < I then
      SetLength(FByteBuffer, Length(FByteBuffer) * 2);

    if FReader.Read(FByteBuffer, I, 1) = 0 then
      raise EJsonReaderException.Create('');                         

  until FByteBuffer[I] = 0;

  Result := FEncoding.GetString(FByteBuffer, 0, I);
  MovePosition(I + 1);
end;

function TBsonReader.ReadType: TBsonType;
begin
  Result := TBsonType(FReader.ReadSByte);
  MovePosition(1);
end;

procedure TBsonReader.Rewind;
begin
  inherited Rewind;
  FStack.Clear;
  FCurrentContext := nil;
end;

procedure TBsonReader.Skip;

  // skip string, binary or code_w_s
  function SkipValue: string;
  var
    LOffset: Integer;
  begin
    LOffset := ReadInteger;
    FReader.BaseStream.Position := FReader.BaseStream.Position + LOffset;
    MovePosition(LOffset);
  end;

var
  LOffset: Integer;
begin
  if TokenType = TJsonToken.PropertyName then
  begin
    // optimized for string and binary data
    case FCurrentElementType of
      TBsonType.String,
      TBsonType.Symbol,
      TBsonType.Code:
      begin
        SkipValue;
        SetToken(TJsonToken.String, '');
      end;
      TBsonType.Binary:
      begin
        SkipValue;
        SetToken(TJsonToken.Bytes, '');
      end;
      TBsonType.CodeWScope:
      begin
        SkipValue;
        SetToken(TJsonToken.CodeWScope, '');
      end;
      else
        Read;
    end;
  end;
  if IsStartToken(TokenType) then
  begin
    LOffset := FStack.Peek.Length - SizeOf(Integer) - 1;
    FReader.BaseStream.Position := FReader.BaseStream.Position + LOffset;
    MovePosition(LOffset);

    // Read the final byte to autoset the state to EndToken
    Read;
  end
end;

{ TBsonContainer }

constructor TBsonWriter.TBsonContainer.Create(AParent: TBsonContainer; SizePos: Integer);
begin
  FParent := AParent;
  FPosition := SizePos;
  FChildren := TObjectList<TBsonContainer>.Create;
end;

destructor TBsonWriter.TBsonContainer.Destroy;
begin
  FChildren.Free;
  inherited Destroy;
end;

end.
