{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXStream;

{$R-}

interface

uses
  Data.DBXCommon,
  Data.DBXJSON,
  Data.DBXPlatform,
  Data.DBXTransport,
  System.SysUtils;

type
  TDBXStringDecoder = class;
  TDBXStringEncoder = class;

  TDBXBcdFormat = class
  public
    const TextReadWrite = 0;
    const BinaryRead = 1;
    const BinaryWrite = 2;
    const BinaryReadWrite = BinaryRead or BinaryWrite;
  end;

  TDBXBinaryStream = class
  public
    constructor Create;
    destructor Destroy; override;
    procedure Growbuf(const BytesNeeded: Integer);
    function Skip(const Length: Integer): Integer;
    function ReadBoolean: Boolean;
    function ReadByte: Byte;
    function ReadInt8: SmallInt;
    function ReadInt32: Integer;
    function ReadInt16: SmallInt;
    function ReadUInt16: Word;
    function ReadInt64: Int64;
    function ReadSingle: Single;
    function ReadDoubleAsInt64: Int64;
    function ReadDouble: Double;
    function ReadTimestamp: Int64;
    function ReadTimestampNanos: Integer;
    procedure ReadBigDecimalBuffer;
    function BigDecimalFitsInInt64: Boolean;
  protected
    procedure SetMinBufferSize(const Size: Integer);
    function SkipNullTermString: Integer;
    
    /// <summary> Byte field crawler: changes current row byte offset to the next field based on the field signature 
    /// </summary>
    procedure SkipField;
    function GetBigDecimalBufferAsInt64: Int64;
    function GetBigDecimalLength: Integer;
  protected
    FTwoByteStringTerminator: Boolean;
    FBuf: TArray<Byte>;
    FBufLength: Integer;
    FOff: Integer;
    FCurrentOrdinal: Integer;
    FBigDecimalBuffer: TArray<Byte>;
    FBigDecimalLength: TDBXInt32s;
    FBigDecimalScale: Integer;
    FBigDecimalSignum: Integer;
  private
    FNanos: Integer;
    FMinBufSize: Integer;
  public
    property MinBufferSize: Integer read FMinBufSize write SetMinBufferSize;
    property Buffer: TArray<Byte> read FBuf;
    property BufferOffset: Integer read FOff;
    property BigDecimalBuffer: TArray<Byte> read FBigDecimalBuffer;
    property BigDecimalBufferAsInt64: Int64 read GetBigDecimalBufferAsInt64;
    property BigDecimalLength: Integer read GetBigDecimalLength;
    property BigDecimalSignum: Integer read FBigDecimalSignum;
    property BigDecimalScale: Integer read FBigDecimalScale;
    property CurrentOrdinal: Integer read FCurrentOrdinal;
  end;

  TDBXCharDecoder = class abstract
  public
    procedure InitDecoder;
    function GrowDecodeBufTo(const InNewSize: Integer): Boolean;
    function Decode(const Buf: TArray<Byte>; const InBufOff: Integer; const MaxBytes: Integer): Boolean;
    procedure AddNullChar;
    destructor Destroy; override;
  private
    function DecodeChars(const Buf: TArray<Byte>; const InBufOff: Integer; const InMaxOff: Integer): Boolean;
  protected
    FHitChar: Boolean;
    FHasHalfChar: Boolean;
    FHalfChar: Byte;
    FDecodeLength: Integer;
    FNullTerminated: Boolean;
    FDecodeOff: Integer;
    FDecodeBuf: TDBXWideChars;
    FAddQuotes: Boolean;
  private
    FPreventGrowth: Boolean;
  public
    property DecodeOff: Integer read FDecodeOff;
    property DecodeBuf: TDBXWideChars read FDecodeBuf;
    property PreventGrowth: Boolean write FPreventGrowth;
  end;

  TDBXColumnFlags = class
  end;

  TDBXFieldHeader = class
  public
    const FNullValue = 128;
    const FAssignedNull = (FNullValue or 64);
    const FNullMask = (FNullValue or FAssignedNull);
    const FPositive = Byte(64);
    const FNullTermStringField = Byte(0);
    const FTinyField = Byte(32);
    const FBigField = Byte(16);
    const FJSONField = Byte(64);
    const FCallbackField = Byte(2);
    const FBlobHeader = Byte(8);
    const FBlobRefHeader = Byte((FBlobHeader or 4));
    const FBlobMask = Byte((FPositive or FTinyField or FBigField or FBlobHeader));
    const FTinyHeaderLength = 1;
    const FNullTermLength = 4;
    const FOldNullTermLength = 2;
    const FJSONBlockLength = 5;
    const FNullTermOverHead = FNullTermLength + FTinyHeaderLength;
    const FOldNullTermOverHead = FOldNullTermLength + FTinyHeaderLength;
    const FTinyHeaderLengthMask = 31;
    const FBigHeaderLength = 3;
    const FSmallBlobHeaderLength = 5;
    const FMaxHeaderLength = FSmallBlobHeaderLength + 9;
  end;

  TDBXFieldPacker = class
  public
    class function UnpackInt(const Buf: TArray<Byte>; const InOffset: Integer): Integer; static;
    class procedure PackInt(const Buf: TArray<Byte>; const InOffset: Integer; const IVal: Integer); static;
    class function RepackRealForIndex(const SourceBuf: TArray<Byte>; const InSourceOff: Integer; const DestBuf: TArray<Byte>; const InDestOff: Integer; const aType: Integer): Integer; static;
    class function UnpackDoubleAsInt64(const Buf: TArray<Byte>; const InOffset: Integer): Int64; static;
    class function UnpackDouble(const Buf: TArray<Byte>; const Offset: Integer): Double; static;
    class function PackDouble(const Buf: TArray<Byte>; const InOffset: Integer; const DValue: Double; const ForIndex: Boolean): Integer; static;
    class function UnpackFloat(const Buf: TArray<Byte>; const InOffset: Integer): Single; static;
    class function PackFloat(const Buf: TArray<Byte>; const InOffset: Integer; const FValue: Single; const ForIndex: Boolean): Integer; static;
    class function PackAsciiShort(const Buf: TArray<Byte>; const InOffset: Integer; const InSVal: Integer; const Compact: Boolean): Integer; static;
    class function PackAsciiInt(const Buf: TArray<Byte>; const InOffset: Integer; const InIVal: Integer; const Compact: Boolean): Integer; static;
    class function PackAsciiLong(const Buf: TArray<Byte>; const InOffset: Integer; const InLVal: Int64; const Compact: Boolean): Integer; static;
    class function PackStringHeader(const Buffer: TArray<Byte>; const InOff: Integer; const Count: Integer): Integer; static;
    class function UnpackAsciiShort(const Buf: TArray<Byte>; const InOffset: Integer): SmallInt; static;
    class function UnpackAsciiInt(const Buf: TArray<Byte>; const InOffset: Integer): Integer; static;
    class function UnpackAsciiLong(const Buf: TArray<Byte>; const InOffset: Integer): Int64; static;
    class function GetBlobHeaderLength(const Buffer: TArray<Byte>; const Off: Integer): Integer; static;
    class function GetBlobLength(const Buffer: TArray<Byte>; const Off: Integer): Integer; static;
    class function PackBigDecimal(const Buf: TArray<Byte>; const InOffset: Integer; const Bytes: TArray<Byte>; const InScale: Integer; const Signum: Integer; const InMaxWidth: Integer; const Precision: Integer; const Compact: Boolean): Integer; static;
    class function UnpackBigDecimal(const Buf: TArray<Byte>; const InOffset: Integer; const InDest: TArray<Byte>; const ReturnLength: TDBXInt32s): TArray<Byte>; static;
  protected
    class procedure ComplementIntValue(const Buf: TArray<Byte>); static;
  end;

  TDBXJSonError = class(TDBXError)
  public
    constructor Create(const ErrorCode: Integer; const Message: string; const Ex: Exception);
  private
    FJSonErrorCode: Integer;
  public
    property JSonErrorCode: Integer read FJSonErrorCode;
  private
    
    /// <summary> 
    /// </summary>
    const FSerialVersionUID = 1;
  end;

  TDBXJSonErrorCodes = class
  public
    
    /// <summary> A general error occurred on the server prior to procedure invocation on the service.
    /// </summary>
    const ServerError = 1;
    
    /// <summary> An error occurred on the server while parsing the JSON text comprising the procedure call.
    /// </summary>
    const ParseError = 2;
    
    /// <summary> The procedure call is not valid.
    /// </summary>
    const BadCall = 3;
    
    /// <summary> The server refuses to process the call because a member is not in the required sequence.
    /// </summary>
    /// <remarks> For example, the params member of the Procedure Call object appeared before version or method members.
    /// </remarks>
    const MemberOutOfSequence = 4;
    
    /// <summary> The call is valid, but a general error occurred during the procedure invocation.
    /// </summary>
    const ServiceError = 5;
    
    /// <summary> The call is valid but the procedure identified by the call could not be located on the service.
    /// </summary>
    const ProcedureNotFound = 7;
  end;

  
  /// <summary> Goal is to be fast, not concise.
  /// </summary>
  /// <remarks>
  /// </remarks>
  TDBXJSonStreamReader = class sealed
  public
    function HasMoreBytes: Boolean;
    function Next: Integer; overload;
    procedure SkipToEndOfObject;
    procedure SkipToEndOfArray;
    function ReadParams: Integer;
    procedure UnexpectedToken(const ExpectedToken: Integer);
    function Next(const ExpectedToken: Integer): Integer; overload;
    function NextValueSeparator: Integer;
    function ReadIntResultObject: Integer;
    procedure NextResultObjectStart;
    procedure ReadErrorBody;
    function ReadMethod: Integer;
    procedure FillBuffer(const Bytes: TArray<Byte>); overload;
    procedure ReadDataBytes(const Buffer: TArray<Byte>; const InReadOff: Integer; const InCount: Integer);
    function ReadBoolean: Boolean;
    function ReadInt: Integer;
    function GetBytes(const Buffer: TArray<Byte>; const Offset: Int64; const Count: Int64): Int64;
    function ReadByte: Byte;
    function ReadShort: SmallInt;
    function ReadLong: Int64;
    function ReadFloat: Single;
    function ReadDouble: Double;
    procedure Open;
    procedure Close;
    function ReadString: string;
    function ReadStringCode: Integer;
    function GetBooleanValue: Boolean;
    destructor Destroy; override;
  protected
    function NextNumber: Integer;
    function NextString: Integer; overload;
    function GetByteLength: Int64;
    function GetStringValue: string;
    function IsConnectionLost: Boolean;
    procedure GrowCharBuffer;
    procedure GrowByteBuffer;
    procedure CreateBuffers;
  private
    procedure SkipString;
    function ReadBinaryInt: Integer;
    procedure NextDataStoreHeader;
    procedure UnexpectedByte(const UnexpectedByte: Byte);
    function TokenToString(const Token: Integer): string;
    procedure UnexpectedString(const ExpectedString: string);
    function NextMethod: Integer;
    procedure ParseStringCode;
    procedure ParseMetadataValue;
    function NextColon: Integer;
    function NextVersion: Integer;
    function NextString(const ExpectedString: string; const Offset: Integer; const Count: Integer): Integer; overload;
    function HexToDecimal(const Value: Byte): Integer;
    function NextString(const StartPosition: Integer): Integer; overload;
    function BytesToString(const Count: Integer; const Offset: Integer = 0): string;
    procedure TraceRead;
    procedure ReadError;
    procedure FillBuffer; overload;
  protected
    FToken: Integer;
    FStringCode: Integer;
    FStringValue: string;
    FLongValue: Int64;
    FDoubleValue: Double;
    FBooleanValue: Boolean;
    FCharBuffer: TDBXWideChars;
    FCharBufferSize: Integer;
    FCharBufferCount: Integer;
    FByteBuffer: TArray<Byte>;
    FByteBufferSize: Integer;
    FByteBufferCount: Integer;
    FReadBuffer: TArray<Byte>;
    FReadPosition: Integer;
    FReadLastPosition: Integer;
    [Weak]FChannel: TDbxChannel;
  private
    [Weak]FContext: TDBXContext;
    FReadBufferSize: Integer;
  public
    property ByteLength: Int64 read GetByteLength;
    property DbxChannel: TDbxChannel read FChannel write FChannel;
    property StringCode: Integer read FStringCode;
    property Token: Integer read FToken;
    property StringValue: string read GetStringValue;
    property LongValue: Int64 read FLongValue;
    property DoubleValue: Double read FDoubleValue;
    property ReadBufferSize: Integer read FReadBufferSize write FReadBufferSize;
    property Context: TDBXContext read FContext;
    property DbxContext: TDBXContext read FContext write FContext;
    property ConnectionLost: Boolean read IsConnectionLost;
  private
    const TrueString = 'true';
    const FalseString = 'false';
    const NullString = 'null';
    const MethodString = '"method"';
    const MetadataString = '"metadata"';
    const ParamsString = '"params"';
    const ResultString = '"result"';
    const ErrorString = '"error"';
  end;

  TDBXJSonStreamWriter = class
  public
    constructor Create;
    procedure WriteConnectObjectStart;
    procedure WriteHandleObject(const Handle: Integer);
    procedure WriteDisconnectObject(const ConnectionHandle: Integer);
    procedure WriteTxBegin(const Isolation: Integer);
    procedure WriteTxEnd(const Commit: Boolean; const Txid: Integer);
    procedure WriteClientMoreBlobObject(const CommandHandle: Integer; const RowHandle: Integer; const BlobHandle: Integer; const Row: Int64; const Ordinal: Integer; const IsOutParameter: Boolean);
    procedure WriteServerMoreBlobObject(const CommandHandle: Integer; const RowHandle: Integer; const IBlobHandle: Integer; const Row: Int64; const Ordinal: Integer);
    procedure WriteCommandCloseObject(const CommandHandle: Integer);
    procedure WriteReaderCloseObject(const ReaderHandle: Integer; const CommandHandle: Integer);
    procedure WriteTableObjectStart;
    procedure WriteColumnsObjectStart;
    procedure WriteParameterMetadataStart;
    procedure WritePrepareStart(const CommandHandle: Integer; const Updateable: Boolean; const CommandType: string; const Command: string);
    procedure WriteExecuteStart;
    procedure WriteExecuteFieldsObject(const CommandHandle: Integer; const Updateable: Boolean; const CommandType: string; const Command: string);
    procedure WriteParametersObjectStart(const Count: Integer);
    procedure WriteParameter(const DataType: Integer; const SubType: Integer; const ParameterDirection: Integer; const Precision: Integer; const Scale: Integer; const Name: string; const ChildPosition: Integer; const Size: Integer);
    procedure WriteFieldsObjectStart;
    procedure WriteExecute(const CommandHandle: Integer);
    procedure WriteResultVoidObject;
    procedure WriteResultObjectStart;
    procedure WriteSessionObjectStart;
    procedure WriteRowsObjectStart;
    procedure WriteDataObjectStart;
    procedure WriteDataObject(const Data: TArray<Byte>; const Count: Integer); overload;
    function CalcRowBufferSize: Integer;
    function WriteDataObject(const Reader: TDBXStreamReader): Boolean; overload;
    procedure WriteClientNextObject(const RowHandle: Integer; const Position: Int64; const CommandHandle: Integer);
    procedure WriteServerNextObject(const RowHandle: Integer; const Position: Int64; const CommandHandle: Integer);
    procedure WriteNextResultObject(const Handle: Integer);
    procedure WriteVendorProperty(const PropertyName: string);
    procedure WriteResultEnd;
    procedure WriteResultObject(const Value: Int64);
    procedure WriteRpcError(const Name: string; const ErrorCode: Integer; const Message: string; const NameValuePairs: TDBXStringArray);
    procedure WriteNamedString(const Name: string; const Value: string);
    procedure WriteObjectStart;
    procedure WriteObjectEnd;
    procedure WriteArrayStart;
    procedure WriteArrayEnd;
    procedure WriteParamsStart;
    procedure WriteValueSeparator;
    procedure WriteNameSeparator;
    procedure WriteDataBytes(const SourceBytes: TArray<Byte>; const InSourceOffset: Integer; const InCount: Integer);
    procedure WriteString(const Chars: string);
    procedure Flush;
    procedure FlushFullBuffer;
    procedure WriteInt(const InData: Integer);
    procedure WriteByte(const Data: Byte);
    procedure WriteSpace;
    procedure WriteShort(const Data: SmallInt);
    procedure WriteLong(const InData: Int64);
    procedure WriteFloat(const Data: Single);
    procedure WriteDouble(const Data: Double);
    procedure WriteBoolean(const Data: Boolean);
    procedure WriteNull;
    
    /// <summary> Sends over transport: {"metadata":[LEN,DATA]}
    ///  where: 
    ///  LEN  = byte size of DATA
    ///  DATA = key/value pairs of metadata values, such as response code and response message
    ///  
    /// </summary>
    /// <param name="data">- the metadata to write</param>
    procedure WriteMetadata(const Data: TJSONObject);
    
    /// <summary> Sends over transport: {"callback":[LEN,[PAR,VAL]]}
    ///  where: 
    ///  LEN = byte size of [PAR,VAL]
    ///  PAR = parameter ordinal
    ///  VAL = input callback value
    ///  
    /// </summary>
    /// <param name="data">- [PAR,VAL]</param>
    procedure WriteCallback(const Data: TJSONValue);
    
    /// <summary> {"data":[LEN,DATA]}
    ///  
    /// </summary>
    /// <param name="data">= JSON output value</param>
    procedure WriteCallbackResponse(const Data: TJSONValue);
    procedure WriteSignature;
    procedure Open;
    procedure Close;
    procedure Skip(const Count: Integer);
    destructor Destroy; override;
  protected
    function IsClosed: Boolean;
    function IsConnectionLost: Boolean;
    procedure CreateBuffers; virtual;
  private
    procedure WriteCommandFields(const CommandHandle: Integer; const Updateable: Boolean; const CommandType: string; const Command: string);
    procedure WriteBytes(const Bytes: TArray<Byte>);
    procedure TraceWrite(const Count: Integer);
  public
    class var ProtocolVersion2: Integer;
    class var ProtocolVersion: Integer;
  protected
    FWriteBufferSize: Integer;
    FWriteBuffer: TArray<Byte>;
    FDecimalBuffer: TArray<Byte>;
    FWriteBufferPosition: Integer;
    FWriteCount: Integer;
    [Weak]FChannel: TDbxChannel;
  private
    class var Hex: TArray<Byte>;
    class var MethodStart: TArray<Byte>;
    class var ParamsStart: TArray<Byte>;
    class var Connect: TArray<Byte>;
    class var Disconnect: TArray<Byte>;
    class var Prepare: TArray<Byte>;
    class var Parameters: TArray<Byte>;
    class var ParameterMetadataStart: TArray<Byte>;
    class var Execute: TArray<Byte>;
    class var CommandClose: TArray<Byte>;
    class var ReaderClose: TArray<Byte>;
    class var ResultStart: TArray<Byte>;
    class var ErrorStart: TArray<Byte>;
    class var CodeLabel: TArray<Byte>;
    class var MessageLabel: TArray<Byte>;
    class var NullValue: TArray<Byte>;
    class var TrueValue: TArray<Byte>;
    class var FalseValue: TArray<Byte>;
    class var ColumnsStart: TArray<Byte>;
    class var TableStart: TArray<Byte>;
    class var SessionStart: TArray<Byte>;
    class var RowsStart: TArray<Byte>;
    class var DataStart: TArray<Byte>;
    class var Next: TArray<Byte>;
    class var NextStart: TArray<Byte>;
    class var HandleStart: TArray<Byte>;
    class var FieldsStart: TArray<Byte>;
    class var Txbegin: TArray<Byte>;
    class var Txend: TArray<Byte>;
    class var MoreBlob: TArray<Byte>;
    class var MoreBlobStart: TArray<Byte>;
    class var NextResult: TArray<Byte>;
    class var VendorProperty: TArray<Byte>;
    class var CallbackStart: TArray<Byte>;
    class var MetadataStart: TArray<Byte>;
  public
    property Closed: Boolean read IsClosed;
    property DbxChannel: TDbxChannel write FChannel;
    property WriteBufferSize: Integer read FWriteBufferSize write FWriteBufferSize;
    property Buffer: TArray<Byte> read FWriteBuffer;
    property BufferPosition: Integer read FWriteBufferPosition;
    property ConnectionLost: Boolean read IsConnectionLost;
  end;

  TDBXRowBlobStreamReader = class(TDBXStreamReader)
  public
    procedure Init(const IsBlobHeader: Boolean; const Size: Int64; const BufferSize: Integer);
    procedure Store(const InBuffer: TArray<Byte>; const InOffset: Integer; const Count: Integer); overload;
    function Read(const Buf: TArray<Byte>; const InOffset: Integer; const InSize: Integer): Integer; override;
    function Eos: Boolean; override;
    function Size: Int64; override;
    procedure Close; override;
    destructor Destroy; override;
  private
    procedure InitBufferTo(const BufferSize: Integer);
    procedure Store(const Count: Integer); overload;
  private
    [Weak]FDbxStreamReader: TDBXJSonStreamReader;
    [Weak]FDbxStreamWriter: TDBXJSonStreamWriter;
    FCommandHandle: TDBXInt32s;
    FRowHandle: Integer;
    FBlobHandle: Integer;
    FOrdinal: Integer;
    FRow: Int64;
    FClient: Boolean;
    FParameterBuffer: Boolean;
    FBuffer: TArray<Byte>;
    FBufferBytes: Integer;
    FBufferOffset: Integer;
    FHasMoreData: Boolean;
    FEos: Boolean;
    FKnownSize: Int64;
  public
    property Buffer: TArray<Byte> read FBuffer;
    property StreamReader: TDBXJSonStreamReader write FDbxStreamReader;
    property StreamWriter: TDBXJSonStreamWriter write FDbxStreamWriter;
    property BlobHandle: Integer write FBlobHandle;
    property Ordinal: Integer write FOrdinal;
    property Row: Int64 write FRow;
    property Client: Boolean write FClient;
    property ParameterBuffer: Boolean read FParameterBuffer write FParameterBuffer;
    property CommandHandle: TDBXInt32s read FCommandHandle write FCommandHandle;
  protected
    property RowHandle: Integer read FRowHandle write FRowHandle;
  end;

  TDBXRowBuffer = class(TDBXBinaryStream)
  public
    constructor Create;
    destructor Destroy; override;
    function NextRow: Boolean;
    function GoToRow(const Row: Integer): Boolean;
    procedure GoToField(const Ordinal: Integer);
    function ReadParameterBlobSize: Integer;
    function ReadReaderBlobSize: Integer;
    procedure ReadBytes(const DestBuf: TArray<Byte>; const DestOff: Integer; const Count: Integer);
    function ReadNull: Boolean;
    procedure ReadCallback;
    function ReadEncodedStringLength: Integer;
    function ReadChars(const RowHandle: Integer; const CharBuf: TDBXWideChars; const MaxChars: Integer): Integer;
    function ReadInlineAnsiChars(const RowHandle: Integer; const ByteBuf: TArray<Byte>; const MaxChars: Integer): Integer;
    function ReadString(const RowHandle: Integer): string;
    function ReadStringBytes(const RowHandle: Integer; const ByteBuf: TArray<Byte>; const Offset: Integer): Integer; overload;
    function ReadAnsiStringBytes(const RowHandle: Integer; const ByteBuf: TArray<Byte>; const Offset: Integer): Integer;
    function ReadStringBytes(const RowHandle: Integer): TArray<Byte>; overload;
    procedure WriteBoolean(const Data: Boolean);
    procedure WriteByte(const Data: Byte);
    procedure WriteShort(const Data: SmallInt);
    procedure WriteInt32(const Data: Integer);
    procedure WriteNull;
    procedure WriteCallback;
    function WriteBytes(const Reader: TDBXStreamReader): Integer;
    
    /// <summary> Stores a byte block into the row.
    /// </summary>
    /// <remarks> 
    ///  Works for up to 2^32 byte size. Method added to accommodate JSON objects.
    ///  It is expected the JSON block will be written using getoffset() and getbuf() methods.
    ///  
    /// </remarks>
    /// <param name="estimatedSize">- byte block size, never zero</param>
    function PrepareJSONByteBlock(const EstimatedSize: Integer): Integer;
    
    /// <summary> Records the actual JSON block length.
    /// </summary>
    /// <remarks> 
    /// </remarks>
    /// <param name="size">- block length, 0 for NULL (as in unknown value)</param>
    procedure EncodeJSONByteBlockSize(const Size: Integer);
    
    /// <summary> Returns the length of the JSON byte block
    ///  
    /// </summary>
    /// <returns>integer - JSON value byte block length</returns>
    function DecodeJSONByteBlockSize: Integer;
    
    /// <summary> Returns the index where the JSON data block starts
    ///  
    /// </summary>
    /// <returns>integer - JSON index</returns>
    function JsonByteBlockOffset: Integer;
    procedure WriteInt64(const Data: Int64);
    procedure WriteDouble(const Data: Double);
    procedure WriteSingle(const Data: Single);
    procedure WriteTimestamp(const TimeValue: Int64; const Nanos: Integer);
    function WriteString(const Data: string): Boolean;
    procedure Post;
    procedure Cancel;
    
    /// <summary> Reads a data block from JSON input stream, in format SIZE,DATA
    /// </summary>
    procedure ReadDataBytes;
    function ReadBlobStreamReader(const RowHandle: Integer): TDBXStreamReader;
  protected
    procedure SetPreventDecoderGrowth(const PreventGrowth: Boolean);
    
    /// <summary> If off points inside a field, i.e. the field info wasn't consumed
    /// </summary>
    /// <remarks> the field info wasn't consumed
    ///  consistently, then reset off to a valid field offset
    /// </remarks>
    procedure MakePositionValid; virtual;
    function IsNull: Boolean;
    function IsCallback: Boolean;
    function IsLastParameterBlobSegment: Boolean;
    function IsBlobHeader: Boolean;
    function GetEncodedStringLength: Integer;
    function GetStringBytesLength: Integer;
    function GetOverflowStringBytes: TArray<Byte>;
    procedure SetReadSize(const Size: Integer);
    procedure SetDbxStreamReader(const DbxStreamReader: TDBXJSonStreamReader); virtual;
    procedure SetDbxStreamWriter(const DbxStreamWriter: TDBXJSonStreamWriter); virtual;
  private
    procedure GrowRowOffsets;
    function AvailableInline: Integer;
    procedure InitRowBlobStreamReader(const Reader: TDBXRowBlobStreamReader; const RowHandle: Integer);
    function GetRowBlobStreamReader(const RowHandle: Integer): TDBXRowBlobStreamReader;
  private
    FBlobStreamReader: TDBXRowBlobStreamReader;
    FClient: Boolean;
    FCommandHandle: TDBXInt32s;
    FBlobId: Integer;
    [Weak]FDbxStreamReader: TDBXJSonStreamReader;
    [Weak]FDbxStreamWriter: TDBXJSonStreamWriter;
    FBytesOverflowBuffer, FBlobStringBuffer: TArray<Byte>;
    FEncoder: TDBXStringEncoder;
    FDecoder: TDBXStringDecoder;
    [Weak]FDbxContext: TDBXContext;
    FCurrentTotalRow: Int64;
    FCurrentRow: Integer;
    FColumnCount: Integer;
    FRowCount: Integer;
    FRowOffsets: TDBXInt32s;
    FReadSize: Integer;
    FMaxInline: Integer;
    FParameterBuffer: Boolean;
    FLastInlinByteCount: Integer;
    
    /// <summary> True if the header information (such as length) was consumed and off moved.
    /// </summary>
    /// <remarks> lastHeaderOffset saves the off and lastOrdinal saves currentOrdinal values.
    /// </remarks>
    FHeaderConsumed: Boolean;
    FLastHeaderOffset: Integer;
    FLastOrdinal: Integer;
  public
    property PreventDecoderGrowth: Boolean write SetPreventDecoderGrowth;
    property Null: Boolean read IsNull;
    property Callback: Boolean read IsCallback;
    property LastParameterBlobSegment: Boolean read IsLastParameterBlobSegment;
    property BlobHeader: Boolean read IsBlobHeader;
    property EncodedStringLength: Integer read GetEncodedStringLength;
    property StringBytesLength: Integer read GetStringBytesLength;
    property BcdBuffer: TArray<Byte> read FBigDecimalBuffer;
    property OverflowStringBytes: TArray<Byte> read GetOverflowStringBytes;
    property buf: TArray<Byte> read FBuf;
    property offset: Integer read FOff;
    property ReadSize: Integer read FReadSize write SetReadSize;
    property ColumnCount: Integer write FColumnCount;
    property Client: Boolean read FClient write FClient;
    property DbxStreamReader: TDBXJSonStreamReader write SetDbxStreamReader;
    property DbxStreamWriter: TDBXJSonStreamWriter write SetDbxStreamWriter;
    property Encoder: TDBXStringEncoder read FEncoder;
    property MaxInline: Integer read FMaxInline;
    property Decoder: TDBXStringDecoder read FDecoder;
    property ParameterBuffer: Boolean read FParameterBuffer write FParameterBuffer;
    property CommandHandle: TDBXInt32s read FCommandHandle write FCommandHandle;
  end;

  TDBXStringCodes = class
  public
    const Unknown = 1;
    const Result = 2;
    const Error = 3;
    const Connect = 4;
    const Disconnect = 5;
    const Prepare = 7;
    const Execute = 8;
    const CommandClose = 9;
    const ReaderClose = 10;
    const Rows = 11;
    const Table = 12;
    const Columns = 13;
    const Session = 14;
    const Data = 15;
    const Next = 16;
    const Handle = 17;
    const Fields = 18;
    const Parameters = 19;
    const Txbegin = 20;
    const Txend = 21;
    const MoreBlob = 22;
    const NextResult = 23;
    const VendorProperty = 24;
    const Callback = 25;
    const Metadata = 26;
  end;

  TDBXStringDecoder = class(TDBXCharDecoder)
  public
    procedure InitWideCharsDecoder(const OutBuf: TDBXWideChars);
    procedure InitByteDecoder; overload;
    procedure InitByteDecoder(const ExpectedSize: Integer); overload;
    function DecodeToWideBytes(const InBuf: TArray<Byte>; const InOff: Integer; const OutBuf: TArray<Byte>; const MaxBytes: Integer): Boolean;
    function DecodeBytes(const InBuf: TArray<Byte>; const InOff: Integer; const MaxBytes: Integer): Boolean;
    function ExtractDecodeByteBuffer: TArray<Byte>;
    destructor Destroy; override;
  private
    procedure GrowDecodeByteBuf;
    function DecodeCharsToBytes(const InBuf: TArray<Byte>; const InOff: Integer; const DecodeByteBuf: TArray<Byte>; const InOutOff: Integer; const InMaxOff: Integer): Boolean;
  private
    FMaxOff: Integer;
    FDecodeByteBuf: TArray<Byte>;
    FDecodeByteOff: Integer;
    FDecodeByteLength: Integer;
  public
    property DecodeLength: Integer read FDecodeLength;
    property DecodeByteOff: Integer read FDecodeByteOff;
  end;

  TDBXStringEncoder = class
  public
    constructor Create;
    function ExtractEncodeBuffer: TArray<Byte>;
    function Encode(const Source: string; const InDest: TArray<Byte>; const DestOff: Integer; const InMaxBytes: Integer; const NullTerm: Boolean): Boolean;
    destructor Destroy; override;
  private
    procedure GrowEncodeBufTo(const OldBuf: TArray<Byte>; const NewLength: Integer);
  protected
    FEncodeLength: Integer;
    FEncodeBuf: TArray<Byte>;
    FEncodeOff: Integer;
    FReadOff: Integer;
  public
    property EncodeBuf: TArray<Byte> read FEncodeBuf;
    property EncodeOff: Integer read FEncodeOff;
  end;

  TDBXTokens = class
  public
    const ErrorToken = 1;
    const ObjectStartToken = 2;
    const ObjectEndToken = 3;
    const ArrayStartToken = 4;
    const ArrayEndToken = 5;
    const TrueToken = 6;
    const FalseToken = 7;
    const NullToken = 8;
    const NumberStartToken = 9;
    const NumberEndToken = 9;
    const StringStartToken = 10;
    const StringEndToken = 11;
    const NameSeparatorToken = 12;
    const ValueSeparatorToken = 13;
  end;

implementation

uses
  System.Math,
  Data.DBXClientResStrs
{$IFNDEF J2CS}
  , Data.DBXMetadataCommon
{$ENDIF}
;

constructor TDBXBinaryStream.Create;
begin
  inherited Create;
  SetLength(FBigDecimalBuffer, TDBXFieldHeader.FTinyHeaderLengthMask + TDBXFieldHeader.FTinyHeaderLength);
  SetLength(FBigDecimalLength, 1);
end;

destructor TDBXBinaryStream.Destroy;
begin
  FBigDecimalBuffer := nil;
  FBigDecimalLength := nil;
  FBuf := nil;
  inherited Destroy;
end;

procedure TDBXBinaryStream.SetMinBufferSize(const Size: Integer);
begin
  if FBufLength < Size then
  begin
    SetLength(FBuf, Size);
    FBufLength := Size;
    FMinBufSize := Size;
  end;
end;

procedure TDBXBinaryStream.Growbuf(const BytesNeeded: Integer);
var
  Newbuf: TArray<Byte>;
begin
  SetLength(Newbuf, FBufLength + BytesNeeded);
  TDBXPlatform.CopyByteArray(FBuf, 0, Newbuf, 0, FBufLength);
  FBuf := Newbuf;
  FBufLength := Length(Newbuf);
end;

function TDBXBinaryStream.SkipNullTermString: Integer;
var
  Temp: Integer;
begin
  Temp := FOff;
  if FTwoByteStringTerminator then
  begin
    Inc(Temp);
    while (FBuf[Temp] <> 0) or (FBuf[Temp+1] <> 0) do
      Inc(Temp, 2);
  end
  else 
  begin
    Inc(Temp);
    while (FBuf[Temp] <> 0) or (FBuf[Temp+1] <> 0) or (FBuf[Temp+2] <> 0) do
      Inc(Temp, 3);
  end;
  Inc(Temp);
  Result := Temp - FOff;
end;

function TDBXBinaryStream.Skip(const Length: Integer): Integer;
begin
  FOff := FOff + Length;
  Result := Length;
end;

procedure TDBXBinaryStream.SkipField;
var
  Header: Byte;
  Size: Integer;
begin
  Header := FBuf[FOff];
  if (Header and TDBXFieldHeader.FNullValue) <> 0 then
    Size := 1
  else if (Header and TDBXFieldHeader.FTinyField) = TDBXFieldHeader.FTinyField then
    Size := (Header and TDBXFieldHeader.FTinyHeaderLengthMask) + TDBXFieldHeader.FTinyHeaderLength
  else if Header = TDBXFieldHeader.FCallbackField then
    Size := 1
  else if (Header and TDBXFieldHeader.FBigField) = TDBXFieldHeader.FBigField then
    Size := (((FBuf[FOff + 1] and 255) shl 8) or (FBuf[FOff + 2] and 255)) + TDBXFieldHeader.FBigHeaderLength
  else if (Header and TDBXFieldHeader.FJSONField) = TDBXFieldHeader.FJSONField then
    Size := (((FBuf[FOff + 1] and 255) shl 24) or ((FBuf[FOff + 2] and 255) shl 16) or ((FBuf[FOff + 3] and 255) shl 8) or (FBuf[FOff + 4] and 255)) + TDBXFieldHeader.FJSONBlockLength
  else if (Header and TDBXFieldHeader.FBlobHeader) = TDBXFieldHeader.FBlobHeader then
    Size := TDBXFieldPacker.GetBlobHeaderLength(FBuf, FOff)
  else if Header = TDBXFieldHeader.FNullTermStringField then
    Size := SkipNullTermString
  else
    Size := 0;
  FOff := FOff + Size;
  Inc(FCurrentOrdinal);
end;

function TDBXBinaryStream.ReadBoolean: Boolean;
var
  Data: Boolean;
begin
  Data := ((FBuf[IncrAfter(FOff)] and TDBXFieldHeader.FPositive) <> 0);
  Inc(FCurrentOrdinal);
  Result := Data;
end;

function TDBXBinaryStream.ReadByte: Byte;
var
  Len: Integer;
  Data: SmallInt;
begin
  Len := (FBuf[FOff] and TDBXFieldHeader.FTinyHeaderLengthMask);
  Data := TDBXFieldPacker.UnpackAsciiShort(FBuf, FOff);
  FOff := FOff + TDBXFieldHeader.FTinyHeaderLength + Len;
  Inc(FCurrentOrdinal);
  Result := Byte(Data);
end;

function TDBXBinaryStream.ReadInt8: SmallInt;
var
  Len: Integer;
  Data: SmallInt;
begin
  Len := (FBuf[FOff] and TDBXFieldHeader.FTinyHeaderLengthMask);
  Data := TDBXFieldPacker.UnpackAsciiShort(FBuf, FOff);
  FOff := FOff + TDBXFieldHeader.FTinyHeaderLength + Len;
  Inc(FCurrentOrdinal);
  Result := Data;
end;

function TDBXBinaryStream.ReadInt32: Integer;
var
  Len: Integer;
  Data: Integer;
begin
  Len := (FBuf[FOff] and TDBXFieldHeader.FTinyHeaderLengthMask);
  Data := TDBXFieldPacker.UnpackAsciiInt(FBuf, FOff);
  FOff := FOff + TDBXFieldHeader.FTinyHeaderLength + Len;
  Inc(FCurrentOrdinal);
  Result := Data;
end;

function TDBXBinaryStream.ReadInt16: SmallInt;
var
  Len: Integer;
  Data: SmallInt;
begin
  Len := (FBuf[FOff] and TDBXFieldHeader.FTinyHeaderLengthMask);
  Data := TDBXFieldPacker.UnpackAsciiShort(FBuf, FOff);
  FOff := FOff + TDBXFieldHeader.FTinyHeaderLength + Len;
  Inc(FCurrentOrdinal);
  Result := Data;
end;

function TDBXBinaryStream.ReadUInt16: Word;
var
  Len: Integer;
  Data: SmallInt;
begin
  Len := (FBuf[FOff] and TDBXFieldHeader.FTinyHeaderLengthMask);
  Data := TDBXFieldPacker.UnpackAsciiShort(FBuf, FOff);
  FOff := FOff + TDBXFieldHeader.FTinyHeaderLength + Len;
  Inc(FCurrentOrdinal);
  Result := Word(Data);
end;

function TDBXBinaryStream.ReadInt64: Int64;
var
  Len: Integer;
  Data: Int64;
begin
  Len := (FBuf[FOff] and TDBXFieldHeader.FTinyHeaderLengthMask);
  Data := TDBXFieldPacker.UnpackAsciiLong(FBuf, FOff);
  FOff := FOff + TDBXFieldHeader.FTinyHeaderLength + Len;
  Inc(FCurrentOrdinal);
  Result := Data;
end;

function TDBXBinaryStream.ReadSingle: Single;
var
  Len: Integer;
  Data: Single;
begin
  Len := (FBuf[FOff] and TDBXFieldHeader.FTinyHeaderLengthMask);
  Data := TDBXFieldPacker.UnpackFloat(FBuf, FOff);
  FOff := FOff + TDBXFieldHeader.FTinyHeaderLength + Len;
  Inc(FCurrentOrdinal);
  Result := Data;
end;

function TDBXBinaryStream.ReadDoubleAsInt64: Int64;
var
  Len: Integer;
  Data: Int64;
begin
  Len := (FBuf[FOff] and TDBXFieldHeader.FTinyHeaderLengthMask);
  Data := TDBXFieldPacker.UnpackDoubleAsInt64(FBuf, FOff);
  FOff := FOff + TDBXFieldHeader.FTinyHeaderLength + Len;
  Inc(FCurrentOrdinal);
  Result := Data;
end;

function TDBXBinaryStream.ReadDouble: Double;
var
  Len: Integer;
  Data: Double;
begin
  Len := (FBuf[FOff] and TDBXFieldHeader.FTinyHeaderLengthMask);
  Data := TDBXFieldPacker.UnpackDouble(FBuf, FOff);
  FOff := FOff + TDBXFieldHeader.FTinyHeaderLength + Len;
  Inc(FCurrentOrdinal);
  Result := Data;
end;

function TDBXBinaryStream.ReadTimestamp: Int64;
var
  StartPos: Integer;
  Length: Integer;
  TimeValue: Int64;
  MillisLength: Integer;
begin
  StartPos := FOff;
  Length := (FBuf[IncrAfter(FOff)] and TDBXFieldHeader.FTinyHeaderLengthMask);
  MillisLength := (FBuf[FOff] and TDBXFieldHeader.FTinyHeaderLengthMask);
  TimeValue := TDBXFieldPacker.UnpackAsciiLong(FBuf, FOff);
  FOff := FOff + TDBXFieldHeader.FTinyHeaderLength + MillisLength;
  FNanos := 0;
  if StartPos + Length > FOff then
  begin
    FNanos := TDBXFieldPacker.UnpackInt(FBuf, FOff);
    FOff := FOff + 4;
  end;
  Inc(FCurrentOrdinal);
  Result := TimeValue;
end;

function TDBXBinaryStream.ReadTimestampNanos: Integer;
begin
  Result := FNanos;
end;

procedure TDBXBinaryStream.ReadBigDecimalBuffer;
var
  Header: Integer;
  Len: Integer;
begin
  Header := Integer(FBuf[FOff]);
  Len := (Header and TDBXFieldHeader.FTinyHeaderLengthMask) - 1;
  FBigDecimalScale := FBuf[FOff + 1] and 127;
  if (Header and TDBXFieldHeader.FPositive) = 0 then
    FBigDecimalSignum := -1
  else if Len > 0 then
    FBigDecimalSignum := 1
  else 
    FBigDecimalSignum := 0;
  TDBXFieldPacker.UnpackBigDecimal(FBuf, FOff, FBigDecimalBuffer, FBigDecimalLength);
  FOff := FOff + TDBXFieldHeader.FTinyHeaderLength + Len + 1;
  Inc(FCurrentOrdinal);
end;

function TDBXBinaryStream.BigDecimalFitsInInt64: Boolean;
begin
  Result := (FBigDecimalLength[0] < 8) or ((FBigDecimalLength[0] = 8) and ((FBigDecimalBuffer[0] and 128) = 0));
end;

function TDBXBinaryStream.GetBigDecimalBufferAsInt64: Int64;
var
  Value: Int64;
  ByteCount: Integer;
  Index: Integer;
begin
  if FBigDecimalLength[0] < 8 then
    ByteCount := FBigDecimalLength[0]
  else 
    ByteCount := 8;
  Value := 0;
  for index := 0 to ByteCount - 1 do
  begin
    Value := Value shl 8;
    Value := Value or FBigDecimalBuffer[Index];
  end;
  Result := Value;
end;

function TDBXBinaryStream.GetBigDecimalLength: Integer;
begin
  Result := FBigDecimalLength[0];
end;

procedure TDBXCharDecoder.InitDecoder;
begin
  FDecodeOff := -1;
  FHitChar := False;
  FHasHalfChar := False;
  FAddQuotes := False;
end;

function TDBXCharDecoder.GrowDecodeBufTo(const InNewSize: Integer): Boolean;
var
  NewSize: Integer;
  NewDecodeBuf: TDBXWideChars;
begin
  NewSize := InNewSize;
  if FPreventGrowth then
    raise Exception.Create('Unexpected growth');
  if NewSize < 1 then
    NewSize := 16;
  if FDecodeLength < NewSize then
  begin
    FDecodeLength := NewSize;
    SetLength(NewDecodeBuf,NewSize);
    if FDecodeBuf <> nil then
      TDBXPlatform.CopyCharArray(FDecodeBuf, 0, NewDecodeBuf, 0, FDecodeOff);
    FDecodeBuf := NewDecodeBuf;
  end;
  Result := True;
end;

function TDBXCharDecoder.Decode(const Buf: TArray<Byte>; const InBufOff: Integer; const MaxBytes: Integer): Boolean;
var
  BufOff: Integer;
  MaxOff: Integer;
  B: Byte;
begin
  BufOff := InBufOff;
  MaxOff := BufOff + MaxBytes;

  if FHitChar then
    Exit(DecodeChars(Buf, BufOff, MaxOff));

  while BufOff < MaxOff do
  begin
    B := Buf[BufOff];
    if (B = Ord(#$0)) and FNullTerminated then
      Exit(True)
    else if B = Byte(255) then
    begin
      FHitChar := True;
      Inc(BufOff);
      Exit(DecodeChars(Buf, BufOff, MaxOff));
    end;
    if Incr(FDecodeOff) >= FDecodeLength then
      if not GrowDecodeBufTo(FDecodeLength * 2) then
        Exit(False);
    FDecodeBuf[FDecodeOff] := WideChar((B and 255));
    Inc(BufOff);
  end;
  Result := True;
end;

function TDBXCharDecoder.DecodeChars(const Buf: TArray<Byte>; const InBufOff: Integer; const InMaxOff: Integer): Boolean;
var
  BufOff: Integer;
  MaxOff: Integer;
  Ch: WideChar;
begin
  BufOff := InBufOff;
  MaxOff := InMaxOff;
  ;
  DecrAfter(BufOff);
  MaxOff := MaxOff - 2;
  if FHasHalfChar then
  begin
    Inc(BufOff);
    Ch := WideChar(((Integer((FHalfChar)) shl 8) or ((Buf[BufOff] and 255))));
    Inc(FDecodeOff);
    if FDecodeOff >= FDecodeLength then
      if not GrowDecodeBufTo(FDecodeLength * 2) then
        Exit(False);
    FDecodeBuf[FDecodeOff] := Ch;
    FHasHalfChar := False;
  end;
  while BufOff < MaxOff do
  begin
    Ch := WideChar((((Integer((Buf[Incr(BufOff)] and 255))) shl 8) or (Integer(Buf[Incr(BufOff)]) and 255)));
    if (Ch = #$0) and FNullTerminated then
      Exit(True);
    Inc(FDecodeOff);
    if FDecodeOff >= FDecodeLength then
      if not GrowDecodeBufTo(FDecodeLength * 2) then
        Exit(False);
    FDecodeBuf[FDecodeOff] := Ch;
  end;
  if BufOff = MaxOff then
  begin
    Inc(BufOff);
    FHalfChar := Buf[BufOff];
    FHasHalfChar := True;
  end;
  Result := True;
end;

procedure TDBXCharDecoder.AddNullChar;
begin
  Inc(FDecodeOff);
  if FDecodeOff >= FDecodeLength then
    GrowDecodeBufTo(FDecodeLength + 1);
  FDecodeBuf[FDecodeOff] := WideChar(0);
end;

destructor TDBXCharDecoder.Destroy;
begin
  FDecodeBuf := nil;
  inherited Destroy;
end;

class function TDBXFieldPacker.UnpackInt(const Buf: TArray<Byte>; const InOffset: Integer): Integer;
var
  IVal: Integer;
  Offset: Integer;
begin
  Offset := InOffset;
  IVal := Buf[Offset] shl 24;
  IVal := IVal or (Buf[Incr(Offset)] and 255) shl 16;
  IVal := IVal or (Buf[Incr(Offset)] and 255) shl 8;
  IVal := IVal or (Buf[Incr(Offset)] and 255);
  Result := IVal;
end;

class procedure TDBXFieldPacker.PackInt(const Buf: TArray<Byte>; const InOffset: Integer; const IVal: Integer);
var
  Offset: Integer;
begin
  Offset := InOffset;
  Buf[Offset] := Byte((IVal shr 24));
  Buf[Incr(Offset)] := Byte((IVal shr 16));
  Buf[Incr(Offset)] := Byte((IVal shr 8));
  Buf[Incr(Offset)] := Byte((IVal));
end;

class function TDBXFieldPacker.RepackRealForIndex(const SourceBuf: TArray<Byte>; const InSourceOff: Integer; const DestBuf: TArray<Byte>; const InDestOff: Integer; const aType: Integer): Integer;
var
  DestOff: Integer;
  SourceOff: Integer;
  Header: Integer;
  Len: Integer;
  I: Integer;
begin
  DestOff := InDestOff;
  SourceOff := InSourceOff;
  Header := Integer(SourceBuf[SourceOff]);
  Len := Header and TDBXFieldHeader.FTinyHeaderLengthMask;
  ;
  if (Header and TDBXFieldHeader.FNullValue) <> 0 then
  begin
    DestBuf[DestOff] := Byte(Header);
    Exit(TDBXFieldHeader.FTinyHeaderLength);
  end;
  DestBuf[DestOff] := Byte((Header + (aType - Len)));
  if (Header and TDBXFieldHeader.FPositive) <> 0 then
  begin
    for i := 0 to Len - 1 do
    begin
      Inc(DestOff);
      Inc(SourceOff);
      DestBuf[DestOff] := SourceBuf[SourceOff];
    end;
    while I < aType do
    begin
      Inc(DestOff);
      DestBuf[DestOff] := Byte(0);
      IncrAfter(I);
    end;
  end
  else 
  begin
    for i := 0 to Len - 1 do
    begin
      Inc(DestOff);
      Inc(SourceOff);
      DestBuf[DestOff] := Byte(not SourceBuf[SourceOff]);
    end;
    while I < aType do
    begin
      Inc(DestOff);
      DestBuf[DestOff] := 255;
      IncrAfter(I);
    end;
  end;
  Result := TDBXFieldHeader.FTinyHeaderLength + aType;
end;

class function TDBXFieldPacker.UnpackDoubleAsInt64(const Buf: TArray<Byte>; const InOffset: Integer): Int64;
var
  Offset: Integer;
  Header: Integer;
  Len: Integer;
  LValue: Int64;
  I: Integer;
begin
  Offset := InOffset;
  Header := Integer(Buf[Offset]);
  Len := Header and TDBXFieldHeader.FTinyHeaderLengthMask;
  LValue := 0;
  for I := 0 to Len - 1 do
  begin
    LValue := LValue shl 8;
    Inc(Offset);
    LValue := LValue or (Buf[Offset] and 255);
  end;
  while I < 8 do
  begin
    LValue := LValue shl 8;
    IncrAfter(I);
  end;
  if ((Header and TDBXFieldHeader.FPositive) = 0) and (LValue >= 0) then
    LValue := not LValue;
  Result := LValue;
end;

class function TDBXFieldPacker.UnpackDouble(const Buf: TArray<Byte>; const Offset: Integer): Double;
begin
  Result := TDBXPlatform.Int64BitsToDouble(UnpackDoubleAsInt64(Buf, Offset));
end;

class function TDBXFieldPacker.PackDouble(const Buf: TArray<Byte>; const InOffset: Integer; const DValue: Double; const ForIndex: Boolean): Integer;
var
  Offset: Integer;
  LValue: Int64;
  LInt: Integer;
  RInt: Integer;
begin
  Offset := InOffset;
  LValue := TDBXPlatform.DoubleToInt64Bits(DValue);
  LInt := Integer((LValue shr 32));
  RInt := Integer((LValue));
  if LInt < 0 then
    Buf[Offset] := TDBXFieldHeader.FTinyField
  else 
    Buf[Offset] := Byte((TDBXFieldHeader.FTinyField or TDBXFieldHeader.FPositive));
  if RInt = 0 then
  begin
    while LInt <> 0 do
    begin
      Inc(Offset);
      Buf[Offset] := Byte((LInt shr 24));
      LInt := LInt shl 8;
    end;
  end
  else 
  begin
    Buf[Incr(Offset)] := Byte((LInt shr 24));
    Buf[Incr(Offset)] := Byte((LInt shr 16));
    Buf[Incr(Offset)] := Byte((LInt shr 8));
    Buf[Incr(Offset)] := Byte(LInt);
    while RInt <> 0 do
    begin
      Inc(Offset);
      Buf[Offset] := Byte((RInt shr 24));
      RInt := RInt shl 8;
    end;
  end;
  Buf[InOffset] := Buf[InOffset] or Byte((Offset - InOffset));
  if ForIndex then
    Result := RepackRealForIndex(Buf, InOffset, Buf, InOffset, 8)
  else 
    Result := Offset - InOffset + TDBXFieldHeader.FTinyHeaderLength;
end;

class function TDBXFieldPacker.UnpackFloat(const Buf: TArray<Byte>; const InOffset: Integer): Single;
var
  Offset: Integer;
  Header: Integer;
  Len: Integer;
  IValue: Integer;
  I: Integer;
begin
  Offset := InOffset;
  Header := Integer(Buf[Offset]);
  Len := Header and TDBXFieldHeader.FTinyHeaderLengthMask;
  IValue := 0;
  for i := 0 to Len - 1 do
  begin
    IValue := IValue shl 8;
    Inc(Offset);
    IValue := IValue or (Buf[Offset] and 255);
  end;
  while I < 4 do
  begin
    IValue := IValue shl 8;
    IncrAfter(I);
  end;
  if ((Header and TDBXFieldHeader.FPositive) = 0) and (IValue >= 0) then
    IValue := not IValue;
  Result := TDBXPlatform.Int32BitsToSingle(IValue);
end;

class function TDBXFieldPacker.PackFloat(const Buf: TArray<Byte>; const InOffset: Integer; const FValue: Single; const ForIndex: Boolean): Integer;
var
  Offset: Integer;
  IValue: Integer;
begin
  Offset := InOffset;
  IValue := TDBXPlatform.SingleToInt32Bits(FValue);
  if IValue < 0 then
    Buf[Offset] := TDBXFieldHeader.FTinyField
  else 
    Buf[Offset] := Byte((TDBXFieldHeader.FTinyField or TDBXFieldHeader.FPositive));
  while IValue <> 0 do
  begin
    Inc(Offset);
    Buf[Offset] := Byte((IValue shr 24));
    IValue := IValue shl 8;
  end;
  Buf[InOffset] := Buf[InOffset] or Byte((Offset - InOffset));
  if ForIndex then
    Result := RepackRealForIndex(Buf, InOffset, Buf, InOffset, 4)
  else 
    Result := Offset - InOffset + TDBXFieldHeader.FTinyHeaderLength;
end;

class function TDBXFieldPacker.PackAsciiShort(const Buf: TArray<Byte>; const InOffset: Integer; const InSVal: Integer; const Compact: Boolean): Integer;
var
  Offset: Integer;
  SVal: Integer;
  Digit: Byte;
begin
  Offset := InOffset;
  SVal := InSVal;
  if SVal < 0 then
  begin
    Buf[Offset] := TDBXFieldHeader.FTinyField;
    if Compact then
      SVal := -SVal;
  end
  else 
    Buf[Offset] := Byte((TDBXFieldHeader.FPositive or TDBXFieldHeader.FTinyField));
  if SVal <> 0 then
  begin
    Digit := Byte((SVal shr 8));
    if Digit <> 0 then
    begin
      Inc(Offset);
      Buf[Offset] := Digit;
    end;
    Inc(Offset);
    Buf[Offset] := Byte(SVal);
    Buf[InOffset] := Buf[InOffset] or Byte((Offset - InOffset));
  end;
  Result := Offset - InOffset + TDBXFieldHeader.FTinyHeaderLength;
end;

class function TDBXFieldPacker.PackAsciiInt(const Buf: TArray<Byte>; const InOffset: Integer; const InIVal: Integer; const Compact: Boolean): Integer;
var
  Offset: Integer;
  IVal: Integer;
  Digit: Byte;
begin
  Offset := InOffset;
  IVal := InIVal;
  if IVal < 0 then
  begin
    Buf[Offset] := TDBXFieldHeader.FTinyField;
    if Compact then
      IVal := -IVal;
  end
  else 
    Buf[Offset] := Byte((TDBXFieldHeader.FPositive or TDBXFieldHeader.FTinyField));
  if IVal <> 0 then
  begin
    Digit := Byte((IVal shr 24));
    if Digit <> 0 then
    begin
      Inc(Offset);
      Buf[Offset] := Digit;
    end;
    Digit := Byte((IVal shr 16));
    if (Digit <> 0) or (Offset > InOffset) then
    begin
      Inc(Offset);
      Buf[Offset] := Digit;
    end;
    Digit := Byte((IVal shr 8));
    if (Digit <> 0) or (Offset > InOffset) then
    begin
      Inc(Offset);
      Buf[Offset] := Digit;
    end;
    Inc(Offset);
    Buf[Offset] := Byte(IVal);
    Buf[InOffset] := Buf[InOffset] or Byte((Offset - InOffset));
  end;
//Diagnostic.println("Packing "+iVal);
//if (Diag.CHECK) BlockLog.dump("packAsciiInt ", buf, inOffset, asciiNumberLength(buf[inOffset]));
  Result := Offset - InOffset + TDBXFieldHeader.FTinyHeaderLength;
end;

class function TDBXFieldPacker.PackAsciiLong(const Buf: TArray<Byte>; const InOffset: Integer; const InLVal: Int64; const Compact: Boolean): Integer;
var
  Offset: Integer;
  LVal: Int64;
  Digit: Integer;
  IVal: Integer;
begin
  Offset := InOffset;
  LVal := InLVal;
  if LVal < 0 then
  begin
    Buf[Offset] := TDBXFieldHeader.FTinyField;
    if Compact then
      LVal := -LVal;
  end
  else 
    Buf[Offset] := Byte((TDBXFieldHeader.FPositive or TDBXFieldHeader.FTinyField));
  if LVal <> 0 then
  begin
    IVal := Integer((LVal shr 32));
    if IVal <> 0 then
    begin
      Digit := (IVal shr 24);
      if Digit <> 0 then
      begin
        Inc(Offset);
        Buf[Offset] := Byte(Digit);
      end;
      Digit := (IVal shr 16);
      if (Digit <> 0) or (Offset > InOffset) then
      begin
        Inc(Offset);
        Buf[Offset] := Byte(Digit);
      end;
      Digit := (IVal shr 8) and 255;
      if (Digit <> 0) or (Offset > InOffset) then
      begin
        Inc(Offset);
        Buf[Offset] := Byte(Digit);
      end;
      Inc(Offset);
      Buf[Offset] := Byte(IVal);
    end;
    IVal := Integer((LVal and 4294967295));
    Digit := (IVal shr 24);
    if (Digit <> 0) or (Offset > InOffset) then
    begin
      Inc(Offset);
      Buf[Offset] := Byte(Digit);
    end;
    Digit := (IVal shr 16);
    if (Digit <> 0) or (Offset > InOffset) then
    begin
      Inc(Offset);
      Buf[Offset] := Byte(Digit);
    end;
    Digit := (IVal shr 8);
    if (Digit <> 0) or (Offset > InOffset) then
    begin
      Inc(Offset);
      Buf[Offset] := Byte(Digit);
    end;
    Inc(Offset);
    Buf[Offset] := Byte(IVal);
    Buf[InOffset] := Buf[InOffset] or Byte((Offset - InOffset));
  end;
//Diagnostic.println("Packing "+iVal);
//if (Diag.CHECK) BlockLog.dump("packAsciiLong ", buf, inOffset, asciiNumberLength(buf[inOffset]));
  Result := Offset - InOffset + TDBXFieldHeader.FTinyHeaderLength;
end;

class function TDBXFieldPacker.PackStringHeader(const Buffer: TArray<Byte>; const InOff: Integer; const Count: Integer): Integer;
var
  Off: Integer;
begin
  Off := InOff;
  if TDBXFieldHeader.FTinyHeaderLengthMask >= Count then
    Buffer[IncrAfter(Off)] := Byte((TDBXFieldHeader.FTinyField + Count))
  else 
  begin
    Buffer[IncrAfter(Off)] := TDBXFieldHeader.FBigField;
    Buffer[IncrAfter(Off)] := Byte(((Count shr 8) and 255));
    Buffer[IncrAfter(Off)] := Byte(((Count) and 255));
  end;
  Result := Off;
end;

class function TDBXFieldPacker.UnpackAsciiShort(const Buf: TArray<Byte>; const InOffset: Integer): SmallInt;
var
  Offset: Integer;
  Flags: Byte;
  ShortValue: SmallInt;
  IDigit: Integer;
begin
  Offset := InOffset;
  Flags := Buf[Offset];
  ShortValue := SmallInt(0);
//if (Diag.CHECK) BlockLog.dump("unpackAsciiInt ", buf, offset, 16);
//Diagnostic.println("Mask "+flags);
  for iDigit := Flags and TDBXFieldHeader.FTinyHeaderLengthMask downto 1 do
  begin
    ShortValue := ShortValue shl 8;
    Inc(Offset);
    ShortValue := ShortValue or (Buf[Offset] and 255);
  end;
  if ((Flags and TDBXFieldHeader.FPositive) = 0) and (ShortValue > 0) then
    ShortValue := SmallInt(-ShortValue);
  Result := ShortValue;
end;

class function TDBXFieldPacker.UnpackAsciiInt(const Buf: TArray<Byte>; const InOffset: Integer): Integer;
var
  Offset: Integer;
  Flags: Byte;
  IntValue: Integer;
  IDigit: Integer;
begin
  Offset := InOffset;
  Flags := Buf[Offset];
  IntValue := 0;
//if (Diag.CHECK) BlockLog.dump("unpackAsciiInt ", buf, offset, 16);
//Diagnostic.println("Mask "+flags);
  for iDigit := Flags and TDBXFieldHeader.FTinyHeaderLengthMask downto 1 do
  begin
    IntValue := IntValue shl 8;
    Inc(Offset);
    IntValue := IntValue or (Buf[Offset] and 255);
  end;
  if ((Flags and TDBXFieldHeader.FPositive) = 0) and (IntValue > 0) then
    IntValue := -IntValue;
  Result := IntValue;
end;

class function TDBXFieldPacker.UnpackAsciiLong(const Buf: TArray<Byte>; const InOffset: Integer): Int64;
var
  Offset: Integer;
  Flags: Byte;
  LongValue: Int64;
  IDigit: Integer;
begin
  Offset := InOffset;
  Flags := Buf[Offset];
  LongValue := 0;
//if (Diag.CHECK) BlockLog.dump("unpackAsciiLong ", buf, offset, 16);
//Diagnostic.println("Mask "+flags);
  for iDigit := Flags and TDBXFieldHeader.FTinyHeaderLengthMask downto 1 do
  begin
    LongValue := LongValue shl 8;
    Inc(Offset);
    LongValue := LongValue or (Buf[Offset] and 255);
  end;
  if ((Flags and TDBXFieldHeader.FPositive) = 0) and (LongValue > 0) then
    LongValue := -LongValue;
  Result := LongValue;
end;

class function TDBXFieldPacker.GetBlobHeaderLength(const Buffer: TArray<Byte>; const Off: Integer): Integer;
begin
  if Buffer[Off] = TDBXFieldHeader.FBlobHeader then
    Exit(5);
//    Diagnostic.check(buffer[off] == DBXFieldHeader.BlobRefHeader?null:""+BlockLog.dump("not a blob header off:  "+off,buffer, 0, buffer.length));
  Result := TDBXFieldHeader.FSmallBlobHeaderLength + TDBXFieldHeader.FTinyHeaderLength + (Buffer[Off + TDBXFieldHeader.FSmallBlobHeaderLength] and TDBXFieldHeader.FTinyHeaderLengthMask);
end;

class function TDBXFieldPacker.GetBlobLength(const Buffer: TArray<Byte>; const Off: Integer): Integer;
begin
  Result := ((Buffer[Off + 1]) shl 24) or ((Buffer[Off + 2] and 255) shl 16) or ((Buffer[Off + 3] and 255) shl 8) or ((Buffer[Off + 4] and 255));
end;

class procedure TDBXFieldPacker.ComplementIntValue(const Buf: TArray<Byte>);
var
  Carry: Boolean;
  I: Integer;
begin
  Carry := True;
  for I := Length(Buf) - 1 downto 0 do
  begin
    Buf[I] := Byte((not Buf[I]));
    if Carry then
    begin
      Inc(Buf[I]);
      Carry := (Buf[I] = 0);
    end;
  end;
end;

class function TDBXFieldPacker.PackBigDecimal(const Buf: TArray<Byte>; const InOffset: Integer; const Bytes: TArray<Byte>; const InScale: Integer; const Signum: Integer; const InMaxWidth: Integer; const Precision: Integer; const Compact: Boolean): Integer;
var
  I, J, K, Len, MaxWidth, Nzeroes, Offset, Scale, Sign_header, Size: Integer;
begin
  MaxWidth := InMaxWidth;
  Scale := InScale;
  MaxWidth := MaxWidth - 2;
  Offset := InOffset;
  Len := Length(Bytes);
  if (Len > 0) and (Bytes[0] = 0) then
    Nzeroes := 1
  else 
    Nzeroes := 0;
  Size := Len - Nzeroes;
  if not Compact and (Signum <> 0) then
  begin
    Size := MaxWidth;
    Scale := Scale + 128;
    if Signum < 0 then
      ComplementIntValue(Bytes);
  end;
  if Signum >= 0 then
    Sign_header := Integer(TDBXFieldHeader.FPositive)
  else 
    Sign_header := 0;
  if Len - Nzeroes > MaxWidth then
    Exit(-1);
  Buf[IncrAfter(Offset)] := Byte((TDBXFieldHeader.FTinyField + Sign_header + 1 + Size));
  Buf[IncrAfter(Offset)] := Byte((Scale));
  if not Compact then
  begin
    if Signum < 0 then
      for I := Len - Nzeroes to MaxWidth - 1 do
        Buf[IncrAfter(Offset)] := 255
    else if Signum > 0 then
      for j := Len - Nzeroes to MaxWidth - 1 do
        Buf[IncrAfter(Offset)] := Byte(0);
  end;
  for k := Nzeroes to Len - 1 do
    Buf[IncrAfter(Offset)] := Bytes[K];
  Result := Offset - InOffset;
end;

class function TDBXFieldPacker.UnpackBigDecimal(const Buf: TArray<Byte>; const InOffset: Integer; const InDest: TArray<Byte>; const ReturnLength: TDBXInt32s): TArray<Byte>;
var
  Header, Len, Offset, Scale, Signum: Integer;
  Dest: TArray<Byte>;
  Compact: Boolean;
  Limiter: Byte;
begin
  Offset := InOffset;
  Dest := InDest;
  Header := Integer(Buf[IncrAfter(Offset)]);
  Len := (Header and TDBXFieldHeader.FTinyHeaderLengthMask) - 1;
  Scale := Integer(Buf[IncrAfter(Offset)]);
  Compact := ((Scale and 128) = 0);
  if (Header and TDBXFieldHeader.FPositive) = 0 then
    Signum := -1
  else if Len > 0 then
    Signum := 1
  else 
    Signum := 0;
  if not Compact then
  begin
    if Signum < 0 then
      Limiter := 255
    else 
      Limiter := Byte(0);
    while (Len > 1) and (Buf[Offset] = Limiter) do
    begin
      Inc(Offset);
      Dec(Len);
    end;
  end;

  if Dest = nil then
    SetLength(Dest,Len)
  else 
    ReturnLength[0] := Len;
  TDBXPlatform.CopyByteArray(Buf, Offset, Dest, 0, Len);
  if not Compact and (Signum < 0) then
    ComplementIntValue(Dest);
  Result := Dest;
end;

constructor TDBXJSonError.Create(const ErrorCode: Integer; const Message: string; const Ex: Exception);
begin
  inherited Create(TDBXErrorCodes.InvalidOperation, Message, Ex);
  FJSonErrorCode := ErrorCode;
end;

//  private static final String VERSION_STRING  = "\"version\"";
function TDBXJSonStreamReader.HasMoreBytes: Boolean;
begin
  Result := FReadPosition < FReadLastPosition;
end;

function TDBXJSonStreamReader.Next: Integer;
var
  LocalBuffer: TArray<Byte>;
  ReadByte: Byte;
begin
  LocalBuffer := FReadBuffer;
  while True do
  begin
    Inc(FReadPosition);
    if FReadPosition > FReadLastPosition then
      FillBuffer;
    ReadByte := LocalBuffer[FReadPosition];
    case ReadByte of
      Ord('{'):
        begin
          FToken := TDBXTokens.ObjectStartToken;
          Exit(FToken);
        end;
      Ord('}'):
        begin
          FToken := TDBXTokens.ObjectEndToken;
          Exit(FToken);
        end;
      Ord('"'):
        begin
          FToken := TDBXTokens.StringStartToken;
          Exit(FToken);
        end;
      Ord(':'):
        begin
          FToken := TDBXTokens.NameSeparatorToken;
          Exit(FToken);
        end;
      Ord(','):
        begin
          FToken := TDBXTokens.ValueSeparatorToken;
          Exit(FToken);
        end;
      Ord('['):
        begin
          FToken := TDBXTokens.ArrayStartToken;
          Exit(FToken);
        end;
      Ord(']'):
        begin
          FToken := TDBXTokens.ArrayEndToken;
          Exit(FToken);
        end;
      Ord('t'):
        begin
          Inc(FReadPosition);
          if FReadPosition > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('r') then
            UnexpectedString(TrueString);
          Inc(FReadPosition);
          if FReadPosition > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('u') then
            UnexpectedString(TrueString);
          Inc(FReadPosition);
          if FReadPosition > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('e') then
            UnexpectedString(TrueString);
          FBooleanValue := True;
          FToken := TDBXTokens.TrueToken;
          Exit(FToken);
        end;
      Ord('f'):
        begin
          Inc(FReadPosition);
          if FReadPosition > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('a') then
            UnexpectedString(FalseString);
          Inc(FReadPosition);
          if FReadPosition > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('l') then
            UnexpectedString(FalseString);
          Inc(FReadPosition);
          if FReadPosition > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('s') then
            UnexpectedString(FalseString);
          Inc(FReadPosition);
          if FReadPosition > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('e') then
            UnexpectedString(FalseString);
          FBooleanValue := False;
          FToken := TDBXTokens.FalseToken;
          Exit(FToken);
        end;
      Ord('n'):
        begin
          Inc(FReadPosition);
          if FReadPosition > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('u') then
            UnexpectedString(NullString);
          Inc(FReadPosition);
          if FReadPosition > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('l') then
            UnexpectedString(NullString);
          Inc(FReadPosition);
          if FReadPosition > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('l') then
            UnexpectedString(NullString);
          FToken := TDBXTokens.NullToken;
          Exit(FToken);
        end;
      Ord(' '),
      Ord(#$9),
      Ord(#$a),
      Ord(#$d):;
      else
        begin
          FToken := TDBXTokens.NumberStartToken;
          Exit(FToken);
        end;
    end;
  end;
end;

procedure TDBXJSonStreamReader.SkipString;
var
  LocalBuffer: TArray<Byte>;
begin
  LocalBuffer := FReadBuffer;
  while True do
  begin
    Inc(FReadPosition);
    if FReadPosition > FReadLastPosition then
      FillBuffer;
    case LocalBuffer[FReadPosition] of
      Ord('"'):
        Exit;
    end;
  end;
end;

procedure TDBXJSonStreamReader.SkipToEndOfObject;
var
  ObjectEndTokens: Integer;
begin
  ObjectEndTokens := 1;
  while ObjectEndTokens > 0 do
    case Next of
      TDBXTokens.StringStartToken:
        SkipString;
      TDBXTokens.ObjectEndToken:
        Dec(ObjectEndTokens);
      TDBXTokens.ObjectStartToken:
        Inc(ObjectEndTokens);
    end;
end;

procedure TDBXJSonStreamReader.SkipToEndOfArray;
var
  ArrayEndTokens: Integer;
begin
  ArrayEndTokens := 1;
  while ArrayEndTokens > 0 do
    case Next of
      TDBXTokens.StringStartToken:
        SkipString;
      TDBXTokens.ArrayEndToken:
        Dec(ArrayEndTokens);
      TDBXTokens.ArrayStartToken:
        Inc(ArrayEndTokens);
    end;
end;

function TDBXJSonStreamReader.ReadBinaryInt: Integer;
var
  Count: Integer;
begin
  Count := 0;
  Inc(FReadPosition);
  if FReadPosition > FReadLastPosition then
    FillBuffer;
  Count := Count + (Integer(FReadBuffer[FReadPosition])) shl 24;
  Inc(FReadPosition);
  if FReadPosition > FReadLastPosition then
    FillBuffer;
  Count := Count + (Integer(FReadBuffer[FReadPosition])) shl 16;
  Inc(FReadPosition);
  if FReadPosition > FReadLastPosition then
    FillBuffer;
  Count := Count + (Integer(FReadBuffer[FReadPosition])) shl 8;
  Inc(FReadPosition);
  if FReadPosition > FReadLastPosition then
    FillBuffer;
  Count := Count + Integer(FReadBuffer[FReadPosition]);
  Result := Count;
end;

procedure TDBXJSonStreamReader.NextDataStoreHeader;
var
  Count: Integer;
  MinorVersion: Integer;
begin
  Count := ReadBinaryInt;
  MinorVersion := ReadBinaryInt;
  Count := Count - 8;
  while Decr(Count) > 0 do
  begin
    Inc(FReadPosition);
    if FReadPosition > FReadLastPosition then
      FillBuffer;
  end;
  if MinorVersion = 0 then
    raise Exception.Create('Server uses unsupported streaming protocol');
end;

function TDBXJSonStreamReader.ReadParams: Integer;
var
  LocalBuffer: TArray<Byte>;
  ReadByte: Byte;
begin
  LocalBuffer := FReadBuffer;
  while True do
  begin
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    ReadByte := LocalBuffer[FReadPosition];
    case ReadByte of
      Ord('"'):
        begin
          if Incr(FReadPosition) > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('p') then
            Exit(NextString(ParamsString, 0, 0));
          if Incr(FReadPosition) > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('a') then
            Exit(NextString(ParamsString, 0, 1));
          if Incr(FReadPosition) > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('r') then
            Exit(NextString(ParamsString, 0, 2));
          if Incr(FReadPosition) > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('a') then
            Exit(NextString(ParamsString, 0, 3));
          if Incr(FReadPosition) > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('m') then
            Exit(NextString(ParamsString, 0, 4));
          if Incr(FReadPosition) > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('s') then
            Exit(NextString(ParamsString, 0, 5));
          if Incr(FReadPosition) > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] <> Ord('"') then
            Exit(NextString(ParamsString, 0, 6));
          if Next = TDBXTokens.NameSeparatorToken then
            Exit(Next);
          Exit(FToken);
        end;
      Ord(','):;
      Ord(' '),
      Ord(#$9),
      Ord(#$a),
      Ord(#$d):;
      else
        Exit(Next);
    end;
  end;
end;

procedure TDBXJSonStreamReader.UnexpectedByte(const UnexpectedByte: Byte);
var
  Buffer: string;
begin
  Buffer := 'Unexpected byte at position:  ' + IntToStr(FReadPosition) + #$a + BytesToString(FReadLastPosition);
  FReadPosition := FReadLastPosition;
  FContext.Error(TDBXJSonErrorCodes.ParseError, Buffer, nil);
end;

procedure TDBXJSonStreamReader.UnexpectedToken(const ExpectedToken: Integer);
var
  Buffer: string;
begin
  Buffer := 'Expected:  ''' + TokenToString(ExpectedToken) + ''' found:  ''' + TokenToString(FToken) + ''' at position:  ' + IntToStr(FReadPosition) + #$a + BytesToString(FReadLastPosition);
  FReadPosition := FReadLastPosition;
  FContext.Error(TDBXJSonErrorCodes.ParseError, Buffer, nil);
end;

function TDBXJSonStreamReader.TokenToString(const Token: Integer): string;
begin
  case Token of
    TDBXTokens.ObjectStartToken:
      Result := '{';
    TDBXTokens.ObjectEndToken:
      Result := '}';
    TDBXTokens.ArrayStartToken:
      Result := '[';
    TDBXTokens.ArrayEndToken:
      Result := ']';
    TDBXTokens.TrueToken:
      Result := 'true';
    TDBXTokens.FalseToken:
      Result := 'false';
    TDBXTokens.NullToken:
      Result := 'null';
    TDBXTokens.NumberStartToken:
      Result := '-+0-9.';
    TDBXTokens.StringStartToken:
      Result := '"';
    TDBXTokens.StringEndToken:
      Result := '"';
    TDBXTokens.NameSeparatorToken:
      Result := ':';
    TDBXTokens.ValueSeparatorToken:
      Result := ',';
    else
      Result := 'Unknown';
  end;
end;

procedure TDBXJSonStreamReader.UnexpectedString(const ExpectedString: string);
var
  Buffer: string;
begin
  Buffer := 'Expected:  ''' + ExpectedString + ' at position:  ' + IntToStr(FReadPosition) + #$a + BytesToString(FReadLastPosition);
  FReadPosition := FReadLastPosition;
  FContext.Error(TDBXJSonErrorCodes.ParseError, Buffer, nil);
end;

function TDBXJSonStreamReader.Next(const ExpectedToken: Integer): Integer;
begin
  if Next <> ExpectedToken then
    UnexpectedToken(ExpectedToken);
  Result := FToken;
end;

function TDBXJSonStreamReader.NextValueSeparator: Integer;
begin
  if Next <> TDBXTokens.ValueSeparatorToken then
    UnexpectedToken(TDBXTokens.ValueSeparatorToken);
  Result := FToken;
end;

function TDBXJSonStreamReader.ReadIntResultObject: Integer;
var
  Value: Integer;
begin
  NextResultObjectStart;
  Next(TDBXTokens.ArrayStartToken);
  Value := ReadInt;
  SkipToEndOfObject;
  Result := Value;
end;

procedure TDBXJSonStreamReader.NextResultObjectStart;
var
  ResultFound: Boolean;
  LocalBuffer: TArray<Byte>;
  ReadByte: Byte;
begin
  LocalBuffer := FReadBuffer;
  ReadByte := Byte(0);
  while ReadByte <> Ord('{') do
  begin
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    ReadByte := LocalBuffer[FReadPosition];
    case ReadByte of
      Ord(' '),
      Ord(#$9),
      Ord(#$a),
      Ord(#$d):;
      Byte(183):
        NextDataStoreHeader;
      Ord('{'):;
      else
        UnexpectedToken(TDBXTokens.ObjectStartToken);
    end;
  end;
  ResultFound := False;
  while not ResultFound do
  begin
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    ReadByte := LocalBuffer[FReadPosition];
    case ReadByte of
      Ord('"'):
        begin
          if Incr(FReadPosition) > FReadLastPosition then
            FillBuffer;
          if LocalBuffer[FReadPosition] = Ord('r') then
          begin
            if Incr(FReadPosition) > FReadLastPosition then
              FillBuffer;
            if LocalBuffer[FReadPosition] <> Ord('e') then
              UnexpectedString(ResultString);
            if Incr(FReadPosition) > FReadLastPosition then
              FillBuffer;
            if LocalBuffer[FReadPosition] <> Ord('s') then
              UnexpectedString(ResultString);
            if Incr(FReadPosition) > FReadLastPosition then
              FillBuffer;
            if LocalBuffer[FReadPosition] <> Ord('u') then
              UnexpectedString(ResultString);
            if Incr(FReadPosition) > FReadLastPosition then
              FillBuffer;
            if LocalBuffer[FReadPosition] <> Ord('l') then
              UnexpectedString(ResultString);
            if Incr(FReadPosition) > FReadLastPosition then
              FillBuffer;
            if LocalBuffer[FReadPosition] <> Ord('t') then
              UnexpectedString(ResultString);
            if Incr(FReadPosition) > FReadLastPosition then
              FillBuffer;
            if LocalBuffer[FReadPosition] <> Ord('"') then
              UnexpectedString(ResultString);
            ResultFound := True;
          end
          else if LocalBuffer[FReadPosition] = Ord('e') then
          begin
            if Incr(FReadPosition) > FReadLastPosition then
              FillBuffer;
            if LocalBuffer[FReadPosition] <> Ord('r') then
              UnexpectedString(ErrorString);
            if Incr(FReadPosition) > FReadLastPosition then
              FillBuffer;
            if LocalBuffer[FReadPosition] <> Ord('r') then
              UnexpectedString(ErrorString);
            if Incr(FReadPosition) > FReadLastPosition then
              FillBuffer;
            if LocalBuffer[FReadPosition] <> Ord('o') then
              UnexpectedString(ErrorString);
            if Incr(FReadPosition) > FReadLastPosition then
              FillBuffer;
            if LocalBuffer[FReadPosition] <> Ord('r') then
              UnexpectedString(ErrorString);
            if Incr(FReadPosition) > FReadLastPosition then
              FillBuffer;
            if LocalBuffer[FReadPosition] <> Ord('"') then
              UnexpectedString(ErrorString);
            ReadErrorBody;
          end
          else 
            UnexpectedString(ResultString);
        end;
      Ord(' '),
      Ord(#$9),
      Ord(#$a),
      Ord(#$d):;
      else
        UnexpectedByte(ReadByte);
    end;
  end;
  Next(TDBXTokens.NameSeparatorToken);
end;

procedure TDBXJSonStreamReader.ReadErrorBody;
var
  Name: string;
  Value: string;
  Message: string;
  Code: Integer;
begin
  Message := 'unknown error';
  Code := TDBXJSonErrorCodes.ParseError;
  Next(TDBXTokens.NameSeparatorToken);
  Next(TDBXTokens.ObjectStartToken);
  Next(TDBXTokens.StringStartToken);
  while FToken <> TDBXTokens.ObjectEndToken do
  begin
    Name := ReadString;
    Next(TDBXTokens.NameSeparatorToken);
    if (Name = 'code') then
      Code := ReadInt
    else if (Name = 'error') then
    begin
      Next(TDBXTokens.ObjectStartToken);
      SkipToEndOfObject;
    end
    else 
    begin
      Value := ReadString;
      if (Name = 'message') then
        Message := Value;
    end;
    Next;
    if FToken = TDBXTokens.ObjectEndToken then
      break;
    if FToken = TDBXTokens.ValueSeparatorToken then
      Next(TDBXTokens.StringStartToken);
  end;
  FContext.Error(Code, Message, nil);
end;

function TDBXJSonStreamReader.ReadMethod: Integer;
var
  LocalBuffer: TArray<Byte>;
  ReadByte: Byte;
begin
  FStringCode := TDBXStringCodes.Unknown;
  Next;
  LocalBuffer := FReadBuffer;
  while True do
  begin
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    ReadByte := LocalBuffer[FReadPosition];
    case ReadByte of
      Ord('"'):
        begin
          if Incr(FReadPosition) > FReadLastPosition then
            FillBuffer;
          case LocalBuffer[FReadPosition] of
            Ord('m'):
            begin
              NextMethod;
              Exit(FStringCode);
            end;
            Ord('v'):
              NextVersion;
            else
              begin
                UnexpectedString(MethodString);
                Exit(TDBXStringCodes.Unknown);
              end;
          end;
        end;
      Ord(' '),
      Ord(#$9),
      Ord(#$a),
      Ord(#$d):;
      else
        begin
          UnexpectedString(MethodString);
          Exit(TDBXStringCodes.Unknown);
        end;
    end;
  end;
end;

function TDBXJSonStreamReader.NextMethod: Integer;
var
  LocalBuffer: TArray<Byte>;
begin
  LocalBuffer := FReadBuffer;
  if Incr(FReadPosition) > FReadLastPosition then
    FillBuffer;
  if LocalBuffer[FReadPosition] <> Ord('e') then
    UnexpectedString(MethodString);
  if Incr(FReadPosition) > FReadLastPosition then
    FillBuffer;
  if LocalBuffer[FReadPosition] <> Ord('t') then
    UnexpectedString(MethodString);
  if Incr(FReadPosition) > FReadLastPosition then
    FillBuffer;
  //method
  if LocalBuffer[FReadPosition] = Ord('h') then
  begin
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    if LocalBuffer[FReadPosition] <> Ord('o') then
      UnexpectedString(MethodString);
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    if LocalBuffer[FReadPosition] <> Ord('d') then
      UnexpectedString(MethodString);
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    if LocalBuffer[FReadPosition] <> Ord('"') then
      UnexpectedString(MethodString);
    if NextColon <> TDBXTokens.NameSeparatorToken then
      Exit(FToken);
    while True do
    begin
      if Incr(FReadPosition) > FReadLastPosition then
        FillBuffer;
      case LocalBuffer[FReadPosition] of
        Ord('"'):
          begin
            NextString(0);
            ParseStringCode;
            Exit(FToken);
          end;
        Ord(' '),
        Ord(#$9),
        Ord(#$a),
        Ord(#$d):;
        else
          UnexpectedString('"');
      end;
    end;
  end
  //metadata
  else if LocalBuffer[FReadPosition] = Ord('a') then
  begin
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    if LocalBuffer[FReadPosition] <> Ord('d') then
      UnexpectedString(MetadataString);
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    if LocalBuffer[FReadPosition] <> Ord('a') then
      UnexpectedString(MetadataString);
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    if LocalBuffer[FReadPosition] <> Ord('t') then
      UnexpectedString(MetadataString);
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    if LocalBuffer[FReadPosition] <> Ord('a') then
      UnexpectedString(MetadataString);
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    if LocalBuffer[FReadPosition] <> Ord('"') then
      UnexpectedString(MetadataString);

    FStringCode := TDBXStringCodes.Metadata;
    if NextColon <> TDBXTokens.NameSeparatorToken then
      Exit(FToken);
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;

    ParseMetadataValue;

    Exit(FToken);
  end
  else
    UnexpectedString(MethodString);

  Exit(TDBXStringCodes.Unknown);
end;

procedure TDBXJSonStreamReader.ParseMetadataValue;
var
  LocalBuffer: TArray<Byte>;
  Len: Integer;
  MetaStr: string;
  MetaJSON: TJSONObject;
begin
  LocalBuffer := FReadBuffer;
  //In format: [X,{...}], where X is the length in bytes of the JSON Object that follows.
  if LocalBuffer[FReadPosition] <> Ord('[') then
    UnexpectedString(MetadataString);

  Len := ReadInt;

  if Len > 0 then
  begin
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    if LocalBuffer[FReadPosition] <> Ord(',') then
      UnexpectedString(',');
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;

    if (FReadPosition + Len) <= Length(LocalBuffer) then
    begin
      MetaStr := BytesToString(Len, FReadPosition);

      FReadPosition := FReadPosition + Len;

{$IFNDEF J2CS}
      MetaJSON := TJSONObject(TJSONObject.ParseJSONValue(MetaStr));
      TInvocationMetadataDelegate.StoreMetadata(MetaJSON);
{$ENDIF}
    end
    else
      UnexpectedString(MetadataString);
  end;
end;

procedure TDBXJSonStreamReader.ParseStringCode;
var
  Position: Integer;
  Count: Integer;
  Buffer: TDBXWideChars;
begin
  Position := 0;
  Count := FCharBufferCount;
  Buffer := FCharBuffer;
  FStringCode := TDBXStringCodes.Unknown;
  case Buffer[Position] of
    'c':
      case Buffer[Incr(Position)] of
        'a':
          begin
            if Buffer[Incr(Position)] <> 'l' then
              Exit;
            if Buffer[Incr(Position)] <> 'l' then
              Exit;
            if Buffer[Incr(Position)] <> 'b' then
              Exit;
            if Buffer[Incr(Position)] <> 'a' then
              Exit;
            if Buffer[Incr(Position)] <> 'c' then
              Exit;
            if Buffer[Incr(Position)] <> 'k' then
              Exit;
            if Count = 8 then
              FStringCode := TDBXStringCodes.Callback;
            
          end;
        'o':
          case Buffer[Incr(Position)] of
            'l':
              begin
                if Buffer[Incr(Position)] <> 'u' then
                  Exit;
                if Buffer[Incr(Position)] <> 'm' then
                  Exit;
                if Buffer[Incr(Position)] <> 'n' then
                  Exit;
                if Buffer[Incr(Position)] <> 's' then
                  Exit;
                if Count = 7 then
                  FStringCode := TDBXStringCodes.Columns;
                
              end;
            'm':
              begin
                if Buffer[Incr(Position)] <> 'm' then
                  Exit;
                if Buffer[Incr(Position)] <> 'a' then
                  Exit;
                if Buffer[Incr(Position)] <> 'n' then
                  Exit;
                if Buffer[Incr(Position)] <> 'd' then
                  Exit;
                if Buffer[Incr(Position)] <> '_' then
                  Exit;
                if Buffer[Incr(Position)] <> 'c' then
                  Exit;
                case Buffer[Incr(Position)] of
                  'l':
                    begin
                      if Buffer[Incr(Position)] <> 'o' then
                        Exit;
                      if Buffer[Incr(Position)] <> 's' then
                        Exit;
                      if Buffer[Incr(Position)] <> 'e' then
                        Exit;
                      if Count = 13 then
                        FStringCode := TDBXStringCodes.CommandClose;
                      
                    end;
                end;
              end;
            'n':
              begin
                if Buffer[Incr(Position)] <> 'n' then
                  Exit;
                if Buffer[Incr(Position)] <> 'e' then
                  Exit;
                if Buffer[Incr(Position)] <> 'c' then
                  Exit;
                if Buffer[Incr(Position)] <> 't' then
                  Exit;
                if Count = 7 then
                  FStringCode := TDBXStringCodes.Connect;
                
              end;
          end;
      end;
    'd':
      begin
        if Buffer[Incr(Position)] = 'a' then
        begin
          if Buffer[Incr(Position)] <> 't' then
            Exit;
          if Buffer[Incr(Position)] <> 'a' then
            Exit;
          if Count = 4 then
            FStringCode := TDBXStringCodes.Data;
          Exit;
        end;
        if Buffer[Position] <> 'i' then
          Exit;
        if Buffer[Incr(Position)] <> 's' then
          Exit;
        if Buffer[Incr(Position)] <> 'c' then
          Exit;
        if Buffer[Incr(Position)] <> 'o' then
          Exit;
        if Buffer[Incr(Position)] <> 'n' then
          Exit;
        if Buffer[Incr(Position)] <> 'n' then
          Exit;
        if Buffer[Incr(Position)] <> 'e' then
          Exit;
        if Buffer[Incr(Position)] <> 'c' then
          Exit;
        if Buffer[Incr(Position)] <> 't' then
          Exit;
        if Count = 10 then
          FStringCode := TDBXStringCodes.Disconnect;
        
      end;
    'e':
      begin
        if Buffer[Incr(Position)] <> 'x' then
        begin
          if Buffer[Position] <> 'r' then
            Exit;
          if Buffer[Incr(Position)] <> 'r' then
            Exit;
          if Buffer[Incr(Position)] <> 'o' then
            Exit;
          if Buffer[Incr(Position)] <> 'r' then
            Exit;
          if Count = 5 then
            FStringCode := TDBXStringCodes.Error;
        end;
        if Buffer[Incr(Position)] <> 'e' then
          Exit;
        if Buffer[Incr(Position)] <> 'c' then
          Exit;
        if Buffer[Incr(Position)] <> 'u' then
          Exit;
        if Buffer[Incr(Position)] <> 't' then
          Exit;
        if Buffer[Incr(Position)] <> 'e' then
          Exit;
        if Count = 7 then
          FStringCode := TDBXStringCodes.Execute;
        
      end;
    'f':
      begin
        if Buffer[Incr(Position)] <> 'i' then
          Exit;
        if Buffer[Incr(Position)] <> 'e' then
          Exit;
        if Buffer[Incr(Position)] <> 'l' then
          Exit;
        if Buffer[Incr(Position)] <> 'd' then
          Exit;
        if Buffer[Incr(Position)] <> 's' then
          Exit;
        if Count = 6 then
          FStringCode := TDBXStringCodes.Fields;
        
      end;
    'h':
      begin
        if Buffer[Incr(Position)] <> 'a' then
          Exit;
        if Buffer[Incr(Position)] <> 'n' then
          Exit;
        if Buffer[Incr(Position)] <> 'd' then
          Exit;
        if Buffer[Incr(Position)] <> 'l' then
          Exit;
        if Buffer[Incr(Position)] <> 'e' then
          Exit;
        if Count = 6 then
          FStringCode := TDBXStringCodes.Handle;
        
      end;
    'm':
      case Buffer[Incr(Position)] of
        'e':
          begin
            if Buffer[Incr(Position)] <> 't' then
              Exit;
            if Buffer[Incr(Position)] <> 'a' then
              Exit;
            if Buffer[Incr(Position)] <> 'd' then
              Exit;
            if Buffer[Incr(Position)] <> 'a' then
              Exit;
            if Buffer[Incr(Position)] <> 't' then
              Exit;
            if Buffer[Incr(Position)] <> 'a' then
              Exit;
            if Count = 8 then
              FStringCode := TDBXStringCodes.Metadata;

          end;
        'o':
          begin
            if Buffer[Incr(Position)] <> 'r' then
              Exit;
            if Buffer[Incr(Position)] <> 'e' then
              Exit;
            if Buffer[Incr(Position)] <> '_' then
              Exit;
            if Buffer[Incr(Position)] <> 'b' then
              Exit;
            if Buffer[Incr(Position)] <> 'l' then
              Exit;
            if Buffer[Incr(Position)] <> 'o' then
              Exit;
            if Buffer[Incr(Position)] <> 'b' then
              Exit;
            if Count = 9 then
              FStringCode := TDBXStringCodes.MoreBlob;
            
          end;
        else
          
      end;
    'n':
      begin
        if Buffer[Incr(Position)] <> 'e' then
          Exit;
        if Buffer[Incr(Position)] <> 'x' then
          Exit;
        if Buffer[Incr(Position)] <> 't' then
          Exit;
        if Count = 4 then
          FStringCode := TDBXStringCodes.Next;
        if Buffer[Incr(Position)] <> '_' then
          Exit;
        if Buffer[Incr(Position)] <> 'r' then
          Exit;
        if Buffer[Incr(Position)] <> 'e' then
          Exit;
        if Buffer[Incr(Position)] <> 's' then
          Exit;
        if Buffer[Incr(Position)] <> 'u' then
          Exit;
        if Buffer[Incr(Position)] <> 'l' then
          Exit;
        if Buffer[Incr(Position)] <> 't' then
          Exit;
        if Count = 11 then
          FStringCode := TDBXStringCodes.NextResult;
        
      end;
    'p':
      begin
        if Buffer[Incr(Position)] = 'r' then
        begin
          if Buffer[Incr(Position)] <> 'e' then
            Exit;
          if Buffer[Incr(Position)] <> 'p' then
            Exit;
          if Buffer[Incr(Position)] <> 'a' then
            Exit;
          if Buffer[Incr(Position)] <> 'r' then
            Exit;
          if Buffer[Incr(Position)] <> 'e' then
            Exit;
          if Count = 7 then
            FStringCode := TDBXStringCodes.Prepare;
          Exit;
        end;
        if Buffer[Position] <> 'a' then
          Exit;
        if Buffer[Incr(Position)] <> 'r' then
          Exit;
        if Buffer[Incr(Position)] <> 'a' then
          Exit;
        if Buffer[Incr(Position)] <> 'm' then
          Exit;
        if Buffer[Incr(Position)] <> 'e' then
          Exit;
        if Buffer[Incr(Position)] <> 't' then
          Exit;
        if Buffer[Incr(Position)] <> 'e' then
          Exit;
        if Buffer[Incr(Position)] <> 'r' then
          Exit;
        if Buffer[Incr(Position)] <> 's' then
          Exit;
        if Count = 10 then
          FStringCode := TDBXStringCodes.Parameters;
        
      end;
    'r':
      begin
        if Buffer[Incr(Position)] = 'o' then
        begin
          if Buffer[Incr(Position)] <> 'w' then
            Exit;
          if Buffer[Incr(Position)] <> 's' then
            Exit;
          if Count = 4 then
            FStringCode := TDBXStringCodes.Rows;
          Exit;
        end;
        if Buffer[Position] <> 'e' then
          Exit;
        if Buffer[Incr(Position)] <> 'a' then
        begin
          if Buffer[Position] <> 's' then
            Exit;
          if Buffer[Incr(Position)] <> 'u' then
            Exit;
          if Buffer[Incr(Position)] <> 'l' then
            Exit;
          if Buffer[Incr(Position)] <> 't' then
            Exit;
          if Count = 6 then
            FStringCode := TDBXStringCodes.Result;
          Exit;
        end;
        if Buffer[Incr(Position)] <> 'd' then
          Exit;
        if Buffer[Incr(Position)] <> 'e' then
          Exit;
        if Buffer[Incr(Position)] <> 'r' then
          Exit;
        if Buffer[Incr(Position)] <> '_' then
          Exit;
        if Buffer[Incr(Position)] <> 'c' then
          Exit;
        if Buffer[Incr(Position)] <> 'l' then
          Exit;
        if Buffer[Incr(Position)] <> 'o' then
          Exit;
        if Buffer[Incr(Position)] <> 's' then
          Exit;
        if Buffer[Incr(Position)] <> 'e' then
          Exit;
        if Count = 12 then
          FStringCode := TDBXStringCodes.ReaderClose;
        
      end;
    's':
      begin
        if Buffer[Incr(Position)] <> 'e' then
          Exit;
        if Buffer[Incr(Position)] <> 's' then
          Exit;
        if Buffer[Incr(Position)] <> 's' then
          Exit;
        if Buffer[Incr(Position)] <> 'i' then
          Exit;
        if Buffer[Incr(Position)] <> 'o' then
          Exit;
        if Buffer[Incr(Position)] <> 'n' then
          Exit;
        if Count = 7 then
          FStringCode := TDBXStringCodes.Session;
        
      end;
    't':
      begin
        if Buffer[Incr(Position)] = 'x' then
        begin
          if Buffer[Incr(Position)] = 'b' then
          begin
            if Buffer[Incr(Position)] <> 'e' then
              Exit;
            if Buffer[Incr(Position)] <> 'g' then
              Exit;
            if Buffer[Incr(Position)] <> 'i' then
              Exit;
            if Buffer[Incr(Position)] <> 'n' then
              Exit;
            if Count = 7 then
              FStringCode := TDBXStringCodes.Txbegin;
            Exit;
          end;
          if Buffer[Position] <> 'e' then
            Exit;
          if Buffer[Incr(Position)] <> 'n' then
            Exit;
          if Buffer[Incr(Position)] <> 'd' then
            Exit;
          if Count = 5 then
            FStringCode := TDBXStringCodes.Txend;
          Exit;
        end;
        if Buffer[Position] <> 'a' then
          Exit;
        if Buffer[Incr(Position)] <> 'b' then
          Exit;
        if Buffer[Incr(Position)] <> 'l' then
          Exit;
        if Buffer[Incr(Position)] <> 'e' then
          Exit;
        if Count = 5 then
          FStringCode := TDBXStringCodes.Table;
        
      end;
    'v':
      begin
        if Buffer[Incr(Position)] <> 'e' then
          Exit;
        if Buffer[Incr(Position)] <> 'n' then
          Exit;
        if Buffer[Incr(Position)] <> 'd' then
          Exit;
        if Buffer[Incr(Position)] <> 'o' then
          Exit;
        if Buffer[Incr(Position)] <> 'r' then
          Exit;
        if Buffer[Incr(Position)] <> '_' then
          Exit;
        if Buffer[Incr(Position)] <> 'p' then
          Exit;
        if Buffer[Incr(Position)] <> 'r' then
          Exit;
        if Buffer[Incr(Position)] <> 'o' then
          Exit;
        if Buffer[Incr(Position)] <> 'p' then
          Exit;
        if Buffer[Incr(Position)] <> 'e' then
          Exit;
        if Buffer[Incr(Position)] <> 'r' then
          Exit;
        if Buffer[Incr(Position)] <> 't' then
          Exit;
        if Buffer[Incr(Position)] <> 'y' then
          Exit;
        if Count = 15 then
          FStringCode := TDBXStringCodes.VendorProperty;
        
      end;
    else
      
  end;
end;

function TDBXJSonStreamReader.NextColon: Integer;
var
  LocalBuffer: TArray<Byte>;
  ReadByte: Byte;
begin
  LocalBuffer := FReadBuffer;
  while True do
  begin
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    ReadByte := LocalBuffer[FReadPosition];
    case ReadByte of
      Ord(':'):
        Exit(TDBXTokens.NameSeparatorToken);
      Ord(' '),
      Ord(#$9),
      Ord(#$a),
      Ord(#$d):;
      else
        UnexpectedString(':');
    end;
  end;
end;

function TDBXJSonStreamReader.NextVersion: Integer;
begin
  Result := TDBXTokens.ErrorToken;
end;

function TDBXJSonStreamReader.NextNumber: Integer;
var
  BytePosition: Integer;
  ReadByte: Byte;
  LocalBuffer: TArray<Byte>;
  LocalByteBuffer: TArray<Byte>;
begin
  LocalBuffer := FReadBuffer;
  LocalByteBuffer := FByteBuffer;
  BytePosition := -1;
  while True do
  begin
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    ReadByte := LocalBuffer[FReadPosition];
    case ReadByte of
      Ord('-'),
      Ord('+'),
      Ord('e'),
      Ord('E'),
      Ord('0'),
      Ord('1'),
      Ord('2'),
      Ord('3'),
      Ord('4'),
      Ord('5'),
      Ord('6'),
      Ord('7'),
      Ord('8'),
      Ord('9'),
      Ord('.'):
        begin
          Inc(BytePosition);
          if BytePosition = FByteBufferSize then
            GrowByteBuffer;
          LocalByteBuffer[BytePosition] := ReadByte;
        end;
      else
        begin
          FByteBufferCount := BytePosition + 1;
          Dec(FReadPosition);
          if (FByteBufferCount < 1) and (ReadByte <> Ord(']')) then
            UnexpectedByte(ReadByte);
          Exit(TDBXTokens.NumberEndToken);
        end;
    end;
  end;
end;

function TDBXJSonStreamReader.NextString(const ExpectedString: string; const Offset: Integer; const Count: Integer): Integer;
var
  Index: Integer;
begin
  Index := 0;
    while Index < Count do
  begin
    FCharBuffer[Index] := ExpectedString[1+Offset + Index];
    Inc(Index);
  end;
  Result := NextString(Index);
end;

function TDBXJSonStreamReader.HexToDecimal(const Value: Byte): Integer;
begin
  if Value > Ord('9') then
  begin
    if Value > Ord('F') then
    begin
      ;
      Exit(Value - Ord('a') + 10);
    end
    else 
    begin
      ;
      Exit(Value - Ord('A') + 10);
    end;
  end;
  ;
  Result := Value - Ord('0');
end;

function TDBXJSonStreamReader.IsConnectionLost: Boolean;
begin
  Result := Assigned(FChannel) and FChannel.ConnectionLost;
end;

function TDBXJSonStreamReader.NextString(const StartPosition: Integer): Integer;
var
  LocalBuffer: TArray<Byte>;
  LocalCharBuffer: TDBXWideChars;
  CharPosition: Integer;
  ReadByte: Byte;
  UnicodeValue: Integer;
begin
  LocalBuffer := FReadBuffer;
  CharPosition := StartPosition - 1;
  LocalCharBuffer := FCharBuffer;
  while True do
  begin
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    ReadByte := LocalBuffer[FReadPosition];
    case ReadByte of
      Ord('"'):
        begin
          FCharBufferCount := CharPosition + 1;
          Exit(TDBXTokens.StringEndToken);
        end;
      Ord('\'):
        begin
          Inc(CharPosition);
          if CharPosition = FCharBufferSize then
          begin
            GrowCharBuffer;
            LocalCharBuffer := FCharBuffer;
          end;
          if Incr(FReadPosition) > FReadLastPosition then
            FillBuffer;
          ReadByte := LocalBuffer[FReadPosition];
          if ReadByte = Ord('u') then
          begin
            if Incr(FReadPosition) > FReadLastPosition then
              FillBuffer;
            UnicodeValue := HexToDecimal(LocalBuffer[FReadPosition]) shl 12;
            if Incr(FReadPosition) > FReadLastPosition then
              FillBuffer;
            UnicodeValue := UnicodeValue or (HexToDecimal(LocalBuffer[FReadPosition]) shl 8);
            if Incr(FReadPosition) > FReadLastPosition then
              FillBuffer;
            UnicodeValue := UnicodeValue or (HexToDecimal(LocalBuffer[FReadPosition]) shl 4);
            if Incr(FReadPosition) > FReadLastPosition then
              FillBuffer;
            UnicodeValue := UnicodeValue or (HexToDecimal(LocalBuffer[FReadPosition]));
            LocalCharBuffer[CharPosition] := WideChar(UnicodeValue);
          end
          else 
            case ReadByte of
              Ord('"'):
                LocalCharBuffer[CharPosition] := '"';
              Ord('\'):
                LocalCharBuffer[CharPosition] := '\';
              Ord('b'):
                LocalCharBuffer[CharPosition] := #$8;
              Ord('f'):
                LocalCharBuffer[CharPosition] := #$c;
              Ord('n'):
                LocalCharBuffer[CharPosition] := #$a;
              Ord('r'):
                LocalCharBuffer[CharPosition] := #$d;
              Ord('t'):
                LocalCharBuffer[CharPosition] := #$9;
              else
                LocalCharBuffer[CharPosition] := WideChar(ReadByte);
            end;
        end;
      else
        begin
          Inc(CharPosition);
          if CharPosition = FCharBufferSize then
          begin
            GrowCharBuffer;
            LocalCharBuffer := FCharBuffer;
          end;
          LocalCharBuffer[CharPosition] := WideChar(ReadByte);
        end;
    end;
  end;
end;

function TDBXJSonStreamReader.NextString: Integer;
var
  LocalBuffer: TArray<Byte>;
begin
  if FToken = TDBXTokens.StringStartToken then
    Exit(NextString(0));
  LocalBuffer := FReadBuffer;
  while True do
  begin
    if Incr(FReadPosition) > FReadLastPosition then
      FillBuffer;
    case LocalBuffer[FReadPosition] of
      Ord('"'):
        Exit(NextString(0));
    end;
  end;
end;

procedure TDBXJSonStreamReader.FillBuffer(const Bytes: TArray<Byte>);
begin
  TDBXPlatform.CopyByteArray(Bytes, 0, FReadBuffer, 0, Length(Bytes));
  FReadLastPosition := Length(Bytes) - 1;
  TDBXPlatform.WriteAsciiBytes('fillBuffer', FReadBuffer, 0, FReadLastPosition);
end;

function TDBXJSonStreamReader.BytesToString(const Count: Integer; const Offset: Integer): string;
var
  Buffer: string;
  CurChar: WideChar;
  Position: Integer;
  COff: Integer;
begin
  COff := Count + Offset;
  Buffer := '';
  Position := Offset;
  while Position < COff do
  begin
    CurChar := WideChar(FReadBuffer[Position]);
    if (CurChar < ' ') or (CurChar > '~') then
    begin
      Buffer := Buffer + '#';
      Buffer := Buffer + IntToStr(Ord(CurChar));
    end
    else
      Buffer := Buffer + CurChar;
    Inc(Position);
  end;
  Result := Buffer;
end;

procedure TDBXJSonStreamReader.TraceRead;
var
  Buffer: string;
begin
  Buffer := 'read ' + IntToStr(FReadLastPosition) + ' bytes:' + BytesToString(FReadLastPosition);
  FContext.Trace(TDBXTraceLevels.Debug, '', Buffer);
end;

procedure TDBXJSonStreamReader.ReadError;
begin
  FContext.Error(TDBXJSonErrorCodes.ServerError, SReadError, nil);
end;

procedure TDBXJSonStreamReader.FillBuffer;
begin
  FReadLastPosition := FChannel.Read(FReadBuffer, 0, Length(FReadBuffer));
  if FContext.IsTracingLevel(TDBXTraceLevels.Debug) or FContext.IsTracing(TDBXTraceFlags.Vendor) then
    TraceRead;
  if FReadLastPosition < 1 then
    ReadError;
  FReadLastPosition := FReadLastPosition - 1;
  FReadPosition := 0;
end;

procedure TDBXJSonStreamReader.ReadDataBytes(const Buffer: TArray<Byte>; const InReadOff: Integer; const InCount: Integer);
var
  MaxCopy: Integer;
  ReadOff: Integer;
  Count: Integer;
begin
  ReadOff := InReadOff;
  Count := InCount;
  Inc(FReadPosition);
  while Count > 0 do
  begin
    if FReadPosition <= FReadLastPosition then
    begin
      MaxCopy := FReadLastPosition - FReadPosition + 1;
      if Count < MaxCopy then
        MaxCopy := Count;
      TDBXPlatform.CopyByteArray(FReadBuffer, FReadPosition, Buffer, ReadOff, MaxCopy);
      ReadOff := ReadOff + MaxCopy;
      FReadPosition := FReadPosition + MaxCopy;
      Count := Count - MaxCopy;
    end;
    if Count > 0 then
      FillBuffer;
  end;
  Dec(FReadPosition);
end;

function TDBXJSonStreamReader.ReadBoolean: Boolean;
begin
  Next;
  if FToken = TDBXTokens.TrueToken then
    Exit(True);
  if FToken = TDBXTokens.FalseToken then
    Exit(False);
  UnexpectedToken(TDBXTokens.TrueToken);
  Result := False;
end;

function TDBXJSonStreamReader.ReadInt: Integer;
var
  Negative: Boolean;
  Position: Integer;
  Value: Integer;
begin
  Value := 0;
  NextNumber;
  if FByteBufferCount > 0 then
  begin
    Position := 0;
    Negative := False;
    if FByteBuffer[0] = Ord('-') then
    begin
      Negative := True;
      Inc(Position);
    end
    else if FByteBuffer[0] = Ord('+') then
      Inc(Position);
    while Position < FByteBufferCount do
    begin
      Value := Value * 10;
      Value := Value + FByteBuffer[Position] - Ord('0');
      Inc(Position);
    end;
    if Negative then
      Value := -Value;
  end;
  Result := Value;
end;

function TDBXJSonStreamReader.GetByteLength: Int64;
begin
  Result := 0;
end;

function TDBXJSonStreamReader.GetBytes(const Buffer: TArray<Byte>; const Offset: Int64; const Count: Int64): Int64;
begin
  Result := 0;
end;

function TDBXJSonStreamReader.ReadByte: Byte;
begin
  Result := Byte(0);
end;

function TDBXJSonStreamReader.ReadShort: SmallInt;
begin
  Result := SmallInt(ReadInt);
end;

function TDBXJSonStreamReader.ReadLong: Int64;
var
  Negative: Boolean;
  Position: Integer;
  Value: Int64;
begin
  Value := 0;
  NextNumber;
  if FByteBufferCount > 0 then
  begin
    Position := 0;
    Negative := False;
    if FByteBuffer[0] = Ord('-') then
    begin
      Negative := True;
      Inc(Position);
    end
    else if FByteBuffer[0] = Ord('+') then
      Inc(Position);
    while Position < FByteBufferCount do
    begin
      Value := Value * 10;
      Value := Value + FByteBuffer[Position] - Ord('0');
      Inc(Position);
    end;
    if Negative then
      Value := -Value;
  end;
  Result := Value;
end;

function TDBXJSonStreamReader.ReadFloat: Single;
begin
  Result := 0.0;
end;

function TDBXJSonStreamReader.ReadDouble: Double;
begin
  Result := 0.0;
end;

procedure TDBXJSonStreamReader.Open;
begin
  CreateBuffers;
end;

procedure TDBXJSonStreamReader.Close;
begin
end;

function TDBXJSonStreamReader.ReadString: string;
begin
  NextString;
  FStringValue := TDBXPlatform.CreateWideString(FCharBuffer, FCharBufferCount);
  Result := FStringValue;
end;

function TDBXJSonStreamReader.ReadStringCode: Integer;
begin
  NextString;
  ParseStringCode;
  FStringValue := NullString;
  Result := FStringCode;
end;

function TDBXJSonStreamReader.GetStringValue: string;
begin
  if FStringValue.IsEmpty then
    FStringValue := TDBXPlatform.CreateWideString(FCharBuffer, FCharBufferCount);
  Result := FStringValue;
end;

function TDBXJSonStreamReader.GetBooleanValue: Boolean;
begin
  Result := FBooleanValue;
end;

procedure TDBXJSonStreamReader.GrowCharBuffer;
var
  NewCharBuffer: TDBXWideChars;
  NewCharBufferSize: Integer;
begin
  NewCharBufferSize := FCharBufferSize + 128;
  SetLength(NewCharBuffer,NewCharBufferSize);
  TDBXPlatform.CopyCharArray(FCharBuffer, 0, NewCharBuffer, 0, FCharBufferSize);
  FCharBuffer := nil;
  FCharBuffer := NewCharBuffer;
  FCharBufferSize := NewCharBufferSize;
end;

procedure TDBXJSonStreamReader.GrowByteBuffer;
var
  NewByteBuffer: TArray<Byte>;
  NewByteBufferSize: Integer;
begin
  NewByteBufferSize := FByteBufferSize + 128;
  SetLength(NewByteBuffer,NewByteBufferSize);
  TDBXPlatform.CopyByteArray(FByteBuffer, 0, NewByteBuffer, 0, FByteBufferSize);
  FByteBuffer := nil;
  FByteBuffer := NewByteBuffer;
  FByteBufferSize := NewByteBufferSize;
end;

procedure TDBXJSonStreamReader.CreateBuffers;
begin
  FCharBufferSize := 128;
  SetLength(FCharBuffer,FCharBufferSize);
  FByteBufferSize := 64;
  SetLength(FByteBuffer,FByteBufferSize);
  if FReadBufferSize = 0 then
    FReadBufferSize := 1024 * 8;
  SetLength(FReadBuffer,FReadBufferSize);
  FReadPosition := -1;
  FReadLastPosition := -1;
end;

destructor TDBXJSonStreamReader.Destroy;
begin
  FCharBuffer := nil;
  FByteBuffer := nil;
  FReadBuffer := nil;
  inherited Destroy;
end;

//  private static byte[] COMMAND_CREATE;
constructor TDBXJSonStreamWriter.Create;
begin
  ProtocolVersion2 := 2;
  ProtocolVersion := ProtocolVersion2;
  inherited Create;
  if Hex = nil then
  begin
    SetLength(Hex,16);
    Hex[0] := Ord('0');
    Hex[1] := Ord('1');
    Hex[2] := Ord('2');
    Hex[3] := Ord('3');
    Hex[4] := Ord('4');
    Hex[5] := Ord('5');
    Hex[6] := Ord('6');
    Hex[7] := Ord('7');
    Hex[8] := Ord('8');
    Hex[9] := Ord('9');
    Hex[10] := Ord('A');
    Hex[11] := Ord('B');
    Hex[12] := Ord('C');
    Hex[13] := Ord('D');
    Hex[14] := Ord('E');
    Hex[15] := Ord('F');
    SetLength(MethodStart,10);
    MethodStart[0] := Ord('{');
    MethodStart[1] := Ord('"');
    MethodStart[2] := Ord('m');
    MethodStart[3] := Ord('e');
    MethodStart[4] := Ord('t');
    MethodStart[5] := Ord('h');
    MethodStart[6] := Ord('o');
    MethodStart[7] := Ord('d');
    MethodStart[8] := Ord('"');
    MethodStart[9] := Ord(':');
    SetLength(ParamsStart,10);
    ParamsStart[0] := Ord('"');
    ParamsStart[1] := Ord('p');
    ParamsStart[2] := Ord('a');
    ParamsStart[3] := Ord('r');
    ParamsStart[4] := Ord('a');
    ParamsStart[5] := Ord('m');
    ParamsStart[6] := Ord('s');
    ParamsStart[7] := Ord('"');
    ParamsStart[8] := Ord(':');
    ParamsStart[9] := Ord('[');
    SetLength(Connect,10);
    Connect[0] := Ord('"');
    Connect[1] := Ord('c');
    Connect[2] := Ord('o');
    Connect[3] := Ord('n');
    Connect[4] := Ord('n');
    Connect[5] := Ord('e');
    Connect[6] := Ord('c');
    Connect[7] := Ord('t');
    Connect[8] := Ord('"');
    Connect[9] := Ord(',');
    SetLength(Disconnect,13);
    Disconnect[0] := Ord('"');
    Disconnect[1] := Ord('d');
    Disconnect[2] := Ord('i');
    Disconnect[3] := Ord('s');
    Disconnect[4] := Ord('c');
    Disconnect[5] := Ord('o');
    Disconnect[6] := Ord('n');
    Disconnect[7] := Ord('n');
    Disconnect[8] := Ord('e');
    Disconnect[9] := Ord('c');
    Disconnect[10] := Ord('t');
    Disconnect[11] := Ord('"');
    Disconnect[12] := Ord(',');
    SetLength(Prepare,10);
    Prepare[0] := Ord('"');
    Prepare[1] := Ord('p');
    Prepare[2] := Ord('r');
    Prepare[3] := Ord('e');
    Prepare[4] := Ord('p');
    Prepare[5] := Ord('a');
    Prepare[6] := Ord('r');
    Prepare[7] := Ord('e');
    Prepare[8] := Ord('"');
    Prepare[9] := Ord(',');
    SetLength(Parameters,15);
    Parameters[0] := Ord('{');
    Parameters[1] := Ord('"');
    Parameters[2] := Ord('p');
    Parameters[3] := Ord('a');
    Parameters[4] := Ord('r');
    Parameters[5] := Ord('a');
    Parameters[6] := Ord('m');
    Parameters[7] := Ord('e');
    Parameters[8] := Ord('t');
    Parameters[9] := Ord('e');
    Parameters[10] := Ord('r');
    Parameters[11] := Ord('s');
    Parameters[12] := Ord('"');
    Parameters[13] := Ord(':');
    Parameters[14] := Ord('[');
    SetLength(Execute,10);
    Execute[0] := Ord('"');
    Execute[1] := Ord('e');
    Execute[2] := Ord('x');
    Execute[3] := Ord('e');
    Execute[4] := Ord('c');
    Execute[5] := Ord('u');
    Execute[6] := Ord('t');
    Execute[7] := Ord('e');
    Execute[8] := Ord('"');
    Execute[9] := Ord(',');
    SetLength(CommandClose,16);
    CommandClose[0] := Ord('"');
    CommandClose[1] := Ord('c');
    CommandClose[2] := Ord('o');
    CommandClose[3] := Ord('m');
    CommandClose[4] := Ord('m');
    CommandClose[5] := Ord('a');
    CommandClose[6] := Ord('n');
    CommandClose[7] := Ord('d');
    CommandClose[8] := Ord('_');
    CommandClose[9] := Ord('c');
    CommandClose[10] := Ord('l');
    CommandClose[11] := Ord('o');
    CommandClose[12] := Ord('s');
    CommandClose[13] := Ord('e');
    CommandClose[14] := Ord('"');
    CommandClose[15] := Ord(',');
    SetLength(ReaderClose,15);
    ReaderClose[0] := Ord('"');
    ReaderClose[1] := Ord('r');
    ReaderClose[2] := Ord('e');
    ReaderClose[3] := Ord('a');
    ReaderClose[4] := Ord('d');
    ReaderClose[5] := Ord('e');
    ReaderClose[6] := Ord('r');
    ReaderClose[7] := Ord('_');
    ReaderClose[8] := Ord('c');
    ReaderClose[9] := Ord('l');
    ReaderClose[10] := Ord('o');
    ReaderClose[11] := Ord('s');
    ReaderClose[12] := Ord('e');
    ReaderClose[13] := Ord('"');
    ReaderClose[14] := Ord(',');
    SetLength(ResultStart,11);
    ResultStart[0] := Ord('{');
    ResultStart[1] := Ord('"');
    ResultStart[2] := Ord('r');
    ResultStart[3] := Ord('e');
    ResultStart[4] := Ord('s');
    ResultStart[5] := Ord('u');
    ResultStart[6] := Ord('l');
    ResultStart[7] := Ord('t');
    ResultStart[8] := Ord('"');
    ResultStart[9] := Ord(':');
    ResultStart[10] := Ord('[');
    SetLength(ErrorStart,17);
    ErrorStart[0] := Ord('{');
    ErrorStart[1] := Ord('"');
    ErrorStart[2] := Ord('e');
    ErrorStart[3] := Ord('r');
    ErrorStart[4] := Ord('r');
    ErrorStart[5] := Ord('o');
    ErrorStart[6] := Ord('r');
    ErrorStart[7] := Ord('"');
    ErrorStart[8] := Ord(':');
    ErrorStart[9] := Ord('{');
    ErrorStart[10] := Ord('"');
    ErrorStart[11] := Ord('n');
    ErrorStart[12] := Ord('a');
    ErrorStart[13] := Ord('m');
    ErrorStart[14] := Ord('e');
    ErrorStart[15] := Ord('"');
    ErrorStart[16] := Ord(':');
    SetLength(CodeLabel,7);
    CodeLabel[0] := Ord('"');
    CodeLabel[1] := Ord('c');
    CodeLabel[2] := Ord('o');
    CodeLabel[3] := Ord('d');
    CodeLabel[4] := Ord('e');
    CodeLabel[5] := Ord('"');
    CodeLabel[6] := Ord(':');
    SetLength(MessageLabel,10);
    MessageLabel[0] := Ord('"');
    MessageLabel[1] := Ord('m');
    MessageLabel[2] := Ord('e');
    MessageLabel[3] := Ord('s');
    MessageLabel[4] := Ord('s');
    MessageLabel[5] := Ord('a');
    MessageLabel[6] := Ord('g');
    MessageLabel[7] := Ord('e');
    MessageLabel[8] := Ord('"');
    MessageLabel[9] := Ord(':');
    SetLength(NullValue,4);
    NullValue[0] := Ord('n');
    NullValue[1] := Ord('u');
    NullValue[2] := Ord('l');
    NullValue[3] := Ord('l');
    SetLength(TrueValue,4);
    TrueValue[0] := Ord('t');
    TrueValue[1] := Ord('r');
    TrueValue[2] := Ord('u');
    TrueValue[3] := Ord('e');
    SetLength(FalseValue,5);
    FalseValue[0] := Ord('f');
    FalseValue[1] := Ord('a');
    FalseValue[2] := Ord('l');
    FalseValue[3] := Ord('s');
    FalseValue[4] := Ord('e');
    SetLength(ColumnsStart,12);
    ColumnsStart[0] := Ord('{');
    ColumnsStart[1] := Ord('"');
    ColumnsStart[2] := Ord('c');
    ColumnsStart[3] := Ord('o');
    ColumnsStart[4] := Ord('l');
    ColumnsStart[5] := Ord('u');
    ColumnsStart[6] := Ord('m');
    ColumnsStart[7] := Ord('n');
    ColumnsStart[8] := Ord('s');
    ColumnsStart[9] := Ord('"');
    ColumnsStart[10] := Ord(':');
    ColumnsStart[11] := Ord('[');
    SetLength(TableStart,10);
    TableStart[0] := Ord('{');
    TableStart[1] := Ord('"');
    TableStart[2] := Ord('t');
    TableStart[3] := Ord('a');
    TableStart[4] := Ord('b');
    TableStart[5] := Ord('l');
    TableStart[6] := Ord('e');
    TableStart[7] := Ord('"');
    TableStart[8] := Ord(':');
    TableStart[9] := Ord('[');
    SetLength(SessionStart,12);
    SessionStart[0] := Ord('{');
    SessionStart[1] := Ord('"');
    SessionStart[2] := Ord('s');
    SessionStart[3] := Ord('e');
    SessionStart[4] := Ord('s');
    SessionStart[5] := Ord('s');
    SessionStart[6] := Ord('i');
    SessionStart[7] := Ord('o');
    SessionStart[8] := Ord('n');
    SessionStart[9] := Ord('"');
    SessionStart[10] := Ord(':');
    SessionStart[11] := Ord('[');
    SetLength(RowsStart,9);
    RowsStart[0] := Ord('{');
    RowsStart[1] := Ord('"');
    RowsStart[2] := Ord('r');
    RowsStart[3] := Ord('o');
    RowsStart[4] := Ord('w');
    RowsStart[5] := Ord('s');
    RowsStart[6] := Ord('"');
    RowsStart[7] := Ord(':');
    RowsStart[8] := Ord('[');
    SetLength(DataStart,9);
    DataStart[0] := Ord('{');
    DataStart[1] := Ord('"');
    DataStart[2] := Ord('d');
    DataStart[3] := Ord('a');
    DataStart[4] := Ord('t');
    DataStart[5] := Ord('a');
    DataStart[6] := Ord('"');
    DataStart[7] := Ord(':');
    DataStart[8] := Ord('[');
    SetLength(Next,7);
    Next[0] := Ord('"');
    Next[1] := Ord('n');
    Next[2] := Ord('e');
    Next[3] := Ord('x');
    Next[4] := Ord('t');
    Next[5] := Ord('"');
    Next[6] := Ord(',');
    SetLength(NextStart,8);
    NextStart[0] := Ord('"');
    NextStart[1] := Ord('n');
    NextStart[2] := Ord('e');
    NextStart[3] := Ord('x');
    NextStart[4] := Ord('t');
    NextStart[5] := Ord('"');
    NextStart[6] := Ord(':');
    NextStart[7] := Ord('[');
    SetLength(HandleStart,11);
    HandleStart[0] := Ord('{');
    HandleStart[1] := Ord('"');
    HandleStart[2] := Ord('h');
    HandleStart[3] := Ord('a');
    HandleStart[4] := Ord('n');
    HandleStart[5] := Ord('d');
    HandleStart[6] := Ord('l');
    HandleStart[7] := Ord('e');
    HandleStart[8] := Ord('"');
    HandleStart[9] := Ord(':');
    HandleStart[10] := Ord('[');
    SetLength(FieldsStart,11);
    FieldsStart[0] := Ord('{');
    FieldsStart[1] := Ord('"');
    FieldsStart[2] := Ord('f');
    FieldsStart[3] := Ord('i');
    FieldsStart[4] := Ord('e');
    FieldsStart[5] := Ord('l');
    FieldsStart[6] := Ord('d');
    FieldsStart[7] := Ord('s');
    FieldsStart[8] := Ord('"');
    FieldsStart[9] := Ord(':');
    FieldsStart[10] := Ord('[');
    SetLength(Txbegin,10);
    Txbegin[0] := Ord('"');
    Txbegin[1] := Ord('t');
    Txbegin[2] := Ord('x');
    Txbegin[3] := Ord('b');
    Txbegin[4] := Ord('e');
    Txbegin[5] := Ord('g');
    Txbegin[6] := Ord('i');
    Txbegin[7] := Ord('n');
    Txbegin[8] := Ord('"');
    Txbegin[9] := Ord(',');
    SetLength(Txend,8);
    Txend[0] := Ord('"');
    Txend[1] := Ord('t');
    Txend[2] := Ord('x');
    Txend[3] := Ord('e');
    Txend[4] := Ord('n');
    Txend[5] := Ord('d');
    Txend[6] := Ord('"');
    Txend[7] := Ord(',');
    SetLength(MoreBlob,12);
    MoreBlob[0] := Ord('"');
    MoreBlob[1] := Ord('m');
    MoreBlob[2] := Ord('o');
    MoreBlob[3] := Ord('r');
    MoreBlob[4] := Ord('e');
    MoreBlob[5] := Ord('_');
    MoreBlob[6] := Ord('b');
    MoreBlob[7] := Ord('l');
    MoreBlob[8] := Ord('o');
    MoreBlob[9] := Ord('b');
    MoreBlob[10] := Ord('"');
    MoreBlob[11] := Ord(',');
    SetLength(MoreBlobStart,13);
    MoreBlobStart[0] := Ord('"');
    MoreBlobStart[1] := Ord('m');
    MoreBlobStart[2] := Ord('o');
    MoreBlobStart[3] := Ord('r');
    MoreBlobStart[4] := Ord('e');
    MoreBlobStart[5] := Ord('_');
    MoreBlobStart[6] := Ord('b');
    MoreBlobStart[7] := Ord('l');
    MoreBlobStart[8] := Ord('o');
    MoreBlobStart[9] := Ord('b');
    MoreBlobStart[10] := Ord('"');
    MoreBlobStart[11] := Ord(':');
    MoreBlobStart[12] := Ord('[');
    SetLength(NextResult,14);
    NextResult[0] := Ord('"');
    NextResult[1] := Ord('n');
    NextResult[2] := Ord('e');
    NextResult[3] := Ord('x');
    NextResult[4] := Ord('t');
    NextResult[5] := Ord('_');
    NextResult[6] := Ord('r');
    NextResult[7] := Ord('e');
    NextResult[8] := Ord('s');
    NextResult[9] := Ord('u');
    NextResult[10] := Ord('l');
    NextResult[11] := Ord('t');
    NextResult[12] := Ord('"');
    NextResult[13] := Ord(',');
    SetLength(VendorProperty,18);
    VendorProperty[0] := Ord('"');
    VendorProperty[1] := Ord('v');
    VendorProperty[2] := Ord('e');
    VendorProperty[3] := Ord('n');
    VendorProperty[4] := Ord('d');
    VendorProperty[5] := Ord('o');
    VendorProperty[6] := Ord('r');
    VendorProperty[7] := Ord('_');
    VendorProperty[8] := Ord('p');
    VendorProperty[9] := Ord('r');
    VendorProperty[10] := Ord('o');
    VendorProperty[11] := Ord('p');
    VendorProperty[12] := Ord('e');
    VendorProperty[13] := Ord('r');
    VendorProperty[14] := Ord('t');
    VendorProperty[15] := Ord('y');
    VendorProperty[16] := Ord('"');
    VendorProperty[17] := Ord(',');
    SetLength(CallbackStart,12);
    CallbackStart[0] := Ord('"');
    CallbackStart[1] := Ord('c');
    CallbackStart[2] := Ord('a');
    CallbackStart[3] := Ord('l');
    CallbackStart[4] := Ord('l');
    CallbackStart[5] := Ord('b');
    CallbackStart[6] := Ord('a');
    CallbackStart[7] := Ord('c');
    CallbackStart[8] := Ord('k');
    CallbackStart[9] := Ord('"');
    CallbackStart[10] := Ord(':');
    CallbackStart[11] := Ord('[');
    SetLength(MetadataStart,12);
    MetadataStart[0] := Ord('"');
    MetadataStart[1] := Ord('m');
    MetadataStart[2] := Ord('e');
    MetadataStart[3] := Ord('t');
    MetadataStart[4] := Ord('a');
    MetadataStart[5] := Ord('d');
    MetadataStart[6] := Ord('a');
    MetadataStart[7] := Ord('t');
    MetadataStart[8] := Ord('a');
    MetadataStart[9] := Ord('"');
    MetadataStart[10] := Ord(':');
    MetadataStart[11] := Ord('[');
  end;
end;

procedure TDBXJSonStreamWriter.WriteConnectObjectStart;
begin
  WriteBytes(MethodStart);
  WriteBytes(Connect);
end;

procedure TDBXJSonStreamWriter.WriteHandleObject(const Handle: Integer);
begin
  WriteBytes(HandleStart);
  WriteInt(Handle);
  WriteArrayEnd;
  WriteObjectEnd;
end;

procedure TDBXJSonStreamWriter.WriteDisconnectObject(const ConnectionHandle: Integer);
begin
  WriteBytes(MethodStart);
  WriteBytes(Disconnect);
  WriteParamsStart;
  WriteInt(ConnectionHandle);
  WriteArrayEnd;
  WriteObjectEnd;
  Flush;
end;

procedure TDBXJSonStreamWriter.WriteTxBegin(const Isolation: Integer);
begin
  WriteBytes(MethodStart);
  WriteBytes(Txbegin);
  WriteParamsStart;
  WriteInt(Isolation);
  WriteArrayEnd;
  WriteObjectEnd;
  Flush;
end;

procedure TDBXJSonStreamWriter.WriteTxEnd(const Commit: Boolean; const Txid: Integer);
begin
  WriteBytes(MethodStart);
  WriteBytes(Txend);
  WriteParamsStart;
  WriteBoolean(Commit);
  WriteValueSeparator;
  WriteInt(Txid);
  WriteArrayEnd;
  WriteObjectEnd;
  Flush;
end;

procedure TDBXJSonStreamWriter.WriteClientMoreBlobObject(const CommandHandle: Integer; const RowHandle: Integer; const BlobHandle: Integer; const Row: Int64; const Ordinal: Integer; const IsOutParameter: Boolean);
begin
  WriteBytes(MethodStart);
  WriteBytes(MoreBlob);
  WriteParamsStart;
  WriteInt(CommandHandle);
  WriteValueSeparator;
  WriteInt(BlobHandle);
  WriteValueSeparator;
  WriteLong(Row);
  WriteValueSeparator;
  WriteInt(Ordinal);
  WriteValueSeparator;
  WriteBoolean(IsOutParameter);
  WriteValueSeparator;
  WriteInt(RowHandle);
  WriteArrayEnd;
  WriteObjectEnd;
  Flush;
end;

procedure TDBXJSonStreamWriter.WriteServerMoreBlobObject(const CommandHandle: Integer; const RowHandle: Integer; const IBlobHandle: Integer; const Row: Int64; const Ordinal: Integer);
begin
  WriteObjectStart;
  WriteBytes(MoreBlobStart);
  WriteInt(CommandHandle);
  WriteValueSeparator;
  WriteInt(IblobHandle);
  WriteValueSeparator;
  WriteLong(Row);
  WriteValueSeparator;
  WriteInt(Ordinal);
  WriteValueSeparator;
  WriteInt(RowHandle);
  WriteArrayEnd;
  WriteObjectEnd;
  Flush;
end;

procedure TDBXJSonStreamWriter.WriteCommandCloseObject(const CommandHandle: Integer);
begin
  WriteBytes(MethodStart);
  WriteBytes(CommandClose);
  WriteParamsStart;
  WriteInt(CommandHandle);
  WriteArrayEnd;
  WriteObjectEnd;
  Flush;
end;

procedure TDBXJSonStreamWriter.WriteReaderCloseObject(const ReaderHandle: Integer; const CommandHandle: Integer);
begin
  WriteBytes(MethodStart);
  WriteBytes(ReaderClose);
  WriteParamsStart;
  WriteInt(ReaderHandle);
  WriteValueSeparator;
  WriteInt(CommandHandle);
  WriteArrayEnd;
  WriteObjectEnd;
  Flush;
end;

procedure TDBXJSonStreamWriter.WriteTableObjectStart;
begin
  WriteBytes(TableStart);
end;

procedure TDBXJSonStreamWriter.WriteColumnsObjectStart;
begin
  WriteBytes(ColumnsStart);
end;

procedure TDBXJSonStreamWriter.WriteParameterMetadataStart;
begin
  WriteBytes(ParameterMetadataStart);
end;

procedure TDBXJSonStreamWriter.WriteCommandFields(const CommandHandle: Integer; const Updateable: Boolean; const CommandType: string; const Command: string);
begin
  WriteInt(CommandHandle);
  WriteValueSeparator;
  WriteBoolean(Updateable);
  WriteValueSeparator;
  WriteString(CommandType);
  WriteValueSeparator;
  WriteString(Command);
end;

procedure TDBXJSonStreamWriter.WritePrepareStart(const CommandHandle: Integer; const Updateable: Boolean; const CommandType: string; const Command: string);
begin
  WriteBytes(MethodStart);
  WriteBytes(Prepare);
  WriteParamsStart;
  WriteCommandFields(CommandHandle, Updateable, CommandType, Command);
end;

procedure TDBXJSonStreamWriter.WriteExecuteStart;
begin
  WriteBytes(MethodStart);
  WriteBytes(Execute);
  WriteParamsStart;
end;

procedure TDBXJSonStreamWriter.WriteExecuteFieldsObject(const CommandHandle: Integer; const Updateable: Boolean; const CommandType: string; const Command: string);
begin
  WriteBytes(FieldsStart);
  WriteCommandFields(CommandHandle, Updateable, CommandType, Command);
  WriteArrayEnd;
  WriteObjectEnd;
end;

procedure TDBXJSonStreamWriter.WriteParametersObjectStart(const Count: Integer);
begin
  WriteBytes(Parameters);
  WriteInt(Count);
end;

procedure TDBXJSonStreamWriter.WriteParameter(const DataType: Integer; const SubType: Integer; const ParameterDirection: Integer; const Precision: Integer; const Scale: Integer; const Name: string; const ChildPosition: Integer; const Size: Integer);
begin
  WriteValueSeparator;
  WriteArrayStart;
  WriteInt(DataType);
  WriteValueSeparator;
  WriteInt(SubType);
  WriteValueSeparator;
  WriteInt(ParameterDirection);
  WriteValueSeparator;
  WriteLong(Precision);
  WriteValueSeparator;
  WriteInt(Scale);
  WriteValueSeparator;
  WriteString(Name);
  WriteValueSeparator;
  WriteInt(ChildPosition);
  WriteValueSeparator;
  WriteInt(Size);
  WriteArrayEnd;
end;

procedure TDBXJSonStreamWriter.WriteFieldsObjectStart;
begin
  WriteBytes(FieldsStart);
end;

procedure TDBXJSonStreamWriter.WriteExecute(const CommandHandle: Integer);
begin
  WriteBytes(MethodStart);
  WriteBytes(Execute);
  WriteParamsStart;
  WriteInt(CommandHandle);
  WriteArrayEnd;
  WriteObjectEnd;
  Flush;
end;

procedure TDBXJSonStreamWriter.WriteResultVoidObject;
begin
  WriteBytes(ResultStart);
  if Incr(FWriteBufferPosition) = FWriteBufferSize then
    FlushFullBuffer;
  FWriteBuffer[FWriteBufferPosition] := Ord(']');
  if Incr(FWriteBufferPosition) = FWriteBufferSize then
    FlushFullBuffer;
  FWriteBuffer[FWriteBufferPosition] := Ord('}');
  Flush;
end;

procedure TDBXJSonStreamWriter.WriteResultObjectStart;
begin
  WriteBytes(ResultStart);
end;

procedure TDBXJSonStreamWriter.WriteSessionObjectStart;
begin
  WriteBytes(SessionStart);
end;

procedure TDBXJSonStreamWriter.WriteRowsObjectStart;
begin
  WriteBytes(RowsStart);
end;

procedure TDBXJSonStreamWriter.WriteDataObjectStart;
begin
  WriteBytes(DataStart);
end;

procedure TDBXJSonStreamWriter.WriteDataObject(const Data: TArray<Byte>; const Count: Integer);
begin
  WriteBytes(DataStart);
  WriteInt(Count);
  WriteValueSeparator;
  WriteDataBytes(Data, 0, Count);
  WriteArrayEnd;
  WriteObjectEnd;
end;

function TDBXJSonStreamWriter.CalcRowBufferSize: Integer;
begin
  if FWriteBufferSize < (2 * 1024) then
    Result := FWriteBufferSize
  else 
    Result := FWriteBufferSize - (2 * 1024);
end;

function TDBXJSonStreamWriter.WriteDataObject(const Reader: TDBXStreamReader): Boolean;
var
  Eos: Boolean;
  GapSize: Integer;
  ReadBytes: Integer;
  MaxBytes: Integer;
  SeparatorPosition: Integer;
  DataPosition: Integer;
begin
  WriteBytes(DataStart);
  GapSize := 9 + 1;
  SeparatorPosition := FWriteBufferPosition + GapSize;
  DataPosition := SeparatorPosition + 1;
  MaxBytes := FWriteBufferSize - (DataPosition) - 2;
  ReadBytes := Reader.Read(FWriteBuffer, DataPosition, MaxBytes);
  Eos := False;
  if (ReadBytes < MaxBytes) or Reader.Eos then
  begin
    if Reader.Eos and (ReadBytes = -1) then
      ReadBytes := 0;
    WriteInt(-ReadBytes);
    Eos := True;
  end
  else 
    WriteInt(ReadBytes);
  while FWriteBufferPosition < (SeparatorPosition - 1) do
    WriteSpace;
  WriteValueSeparator;
  FWriteBufferPosition := FWriteBufferPosition + ReadBytes;
  ;
  WriteArrayEnd;
  WriteObjectEnd;
  Flush;
  Result := Eos;
end;

procedure TDBXJSonStreamWriter.WriteClientNextObject(const RowHandle: Integer; const Position: Int64; const CommandHandle: Integer);
begin
  WriteBytes(MethodStart);
  WriteBytes(Next);
  WriteParamsStart;
  WriteInt(RowHandle);
  WriteValueSeparator;
  WriteLong(Position);
  WriteValueSeparator;
  WriteInt(CommandHandle);
  WriteArrayEnd;
  WriteObjectEnd;
end;

procedure TDBXJSonStreamWriter.WriteServerNextObject(const RowHandle: Integer; const Position: Int64; const CommandHandle: Integer);
begin
  WriteObjectStart;
  WriteBytes(NextStart);
  WriteInt(RowHandle);
  WriteValueSeparator;
  WriteLong(Position);
  WriteValueSeparator;
  WriteInt(CommandHandle);
  WriteArrayEnd;
  WriteObjectEnd;
end;

procedure TDBXJSonStreamWriter.WriteNextResultObject(const Handle: Integer);
begin
  WriteBytes(MethodStart);
  WriteBytes(NextResult);
  WriteParamsStart;
  WriteInt(Handle);
  WriteArrayEnd;
  WriteObjectEnd;
end;

procedure TDBXJSonStreamWriter.WriteVendorProperty(const PropertyName: string);
begin
  WriteBytes(MethodStart);
  WriteBytes(VendorProperty);
  WriteParamsStart;
  WriteString(PropertyName);
  WriteArrayEnd;
  WriteObjectEnd;
  Flush;
end;

procedure TDBXJSonStreamWriter.WriteResultEnd;
begin
  if Incr(FWriteBufferPosition) = FWriteBufferSize then
    FlushFullBuffer;
  FWriteBuffer[FWriteBufferPosition] := Ord('}');
end;

procedure TDBXJSonStreamWriter.WriteResultObject(const Value: Int64);
begin
  WriteBytes(ResultStart);
  WriteLong(Value);
  if Incr(FWriteBufferPosition) = FWriteBufferSize then
    FlushFullBuffer;
  FWriteBuffer[FWriteBufferPosition] := Ord(']');
  if Incr(FWriteBufferPosition) = FWriteBufferSize then
    FlushFullBuffer;
  FWriteBuffer[FWriteBufferPosition] := Ord('}');
  Flush;
end;

procedure TDBXJSonStreamWriter.WriteRpcError(const Name: string; const ErrorCode: Integer; const Message: string; const NameValuePairs: TDBXStringArray);
begin
  WriteBytes(ErrorStart);
  WriteString(Name);
  WriteValueSeparator;
  WriteBytes(CodeLabel);
  WriteInt(ErrorCode);
  WriteValueSeparator;
  WriteBytes(MessageLabel);
  WriteString(Message);
  if (NameValuePairs <> nil) and (Length(NameValuePairs) > 0) then
  begin
    WriteValueSeparator;
    WriteString('error');
    WriteNameSeparator;
    WriteObjectStart;
    WriteObjectEnd;
  end;
  WriteObjectEnd;
end;

procedure TDBXJSonStreamWriter.WriteNamedString(const Name: string; const Value: string);
begin
  WriteString(Name);
  WriteNameSeparator;
  WriteString(Value);
end;

procedure TDBXJSonStreamWriter.WriteObjectStart;
begin
  if Incr(FWriteBufferPosition) = FWriteBufferSize then
    FlushFullBuffer;
  FWriteBuffer[FWriteBufferPosition] := Ord('{');
end;

procedure TDBXJSonStreamWriter.WriteObjectEnd;
begin
  if Incr(FWriteBufferPosition) = FWriteBufferSize then
    FlushFullBuffer;
  FWriteBuffer[FWriteBufferPosition] := Ord('}');
end;

procedure TDBXJSonStreamWriter.WriteArrayStart;
begin
  if Incr(FWriteBufferPosition) = FWriteBufferSize then
    FlushFullBuffer;
  FWriteBuffer[FWriteBufferPosition] := Ord('[');
end;

procedure TDBXJSonStreamWriter.WriteArrayEnd;
begin
  if Incr(FWriteBufferPosition) = FWriteBufferSize then
    FlushFullBuffer;
  FWriteBuffer[FWriteBufferPosition] := Ord(']');
end;

procedure TDBXJSonStreamWriter.WriteParamsStart;
begin
  WriteBytes(ParamsStart);
end;

procedure TDBXJSonStreamWriter.WriteValueSeparator;
begin
  if Incr(FWriteBufferPosition) = FWriteBufferSize then
    FlushFullBuffer;
  FWriteBuffer[FWriteBufferPosition] := Ord(',');
end;

procedure TDBXJSonStreamWriter.WriteNameSeparator;
begin
  if Incr(FWriteBufferPosition) = FWriteBufferSize then
    FlushFullBuffer;
  FWriteBuffer[FWriteBufferPosition] := Ord(':');
end;

procedure TDBXJSonStreamWriter.WriteBytes(const Bytes: TArray<Byte>);
var
  Count, Index: Integer;
begin
  Count := Length(Bytes);
  Index := -1;
  while Incr(Index) < Count do
  begin
    if Incr(FWriteBufferPosition) = FWriteBufferSize then
      FlushFullBuffer;
    FWriteBuffer[FWriteBufferPosition] := Bytes[Index];
  end;
end;

procedure TDBXJSonStreamWriter.WriteDataBytes(const SourceBytes: TArray<Byte>; const InSourceOffset: Integer; const InCount: Integer);
var
  Available: Integer;
  Count: Integer;
  SourceOffset: Integer;
begin
  Count := InCount;
  SourceOffset := InSourceOffset;
  while Count > 0 do
  begin
    Available := FWriteBufferSize - (FWriteBufferPosition + 1);
    if Available < 1 then
    begin
      Flush;
      Available := FWriteBufferSize - (FWriteBufferPosition + 1);
    end;
    if Available > Count then
      FWriteCount := Count
    else 
      FWriteCount := Available;
    TDBXPlatform.CopyByteArray(SourceBytes, SourceOffset, FWriteBuffer, FWriteBufferPosition + 1, FWriteCount);
    Count := Count - FWriteCount;
    SourceOffset := SourceOffset + FWriteCount;
    FWriteBufferPosition := FWriteBufferPosition + FWriteCount;
  end;
end;

procedure TDBXJSonStreamWriter.WriteString(const Chars: string);
var
  CurrentChar: WideChar;
  UnicodeValue: Integer;
begin
  if Incr(FWriteBufferPosition) = FWriteBufferSize then
    FlushFullBuffer;
  FWriteBuffer[FWriteBufferPosition] := Ord('"');
  for CurrentChar in Chars do
  begin
    if Incr(FWriteBufferPosition) = FWriteBufferSize then
      FlushFullBuffer;
    case CurrentChar of
      '"':
        begin
          FWriteBuffer[FWriteBufferPosition] := Ord('\');
          if Incr(FWriteBufferPosition) = FWriteBufferSize then
            FlushFullBuffer;
          FWriteBuffer[FWriteBufferPosition] := Ord(CurrentChar);
        end;
      '\':
        begin
          FWriteBuffer[FWriteBufferPosition] := Ord(CurrentChar);
          if Incr(FWriteBufferPosition) = FWriteBufferSize then
            FlushFullBuffer;
          FWriteBuffer[FWriteBufferPosition] := Ord(CurrentChar);
        end;
      #$8:
        begin
          FWriteBuffer[FWriteBufferPosition] := Ord('\');
          if Incr(FWriteBufferPosition) = FWriteBufferSize then
            FlushFullBuffer;
          FWriteBuffer[FWriteBufferPosition] := Ord('b');
        end;
      #$c:
        begin
          FWriteBuffer[FWriteBufferPosition] := Ord('\');
          if Incr(FWriteBufferPosition) = FWriteBufferSize then
            FlushFullBuffer;
          FWriteBuffer[FWriteBufferPosition] := Ord('f');
        end;
      #$a:
        begin
          FWriteBuffer[FWriteBufferPosition] := Ord('\');
          if Incr(FWriteBufferPosition) = FWriteBufferSize then
            FlushFullBuffer;
          FWriteBuffer[FWriteBufferPosition] := Ord('n');
        end;
      #$d:
        begin
          FWriteBuffer[FWriteBufferPosition] := Ord('\');
          if Incr(FWriteBufferPosition) = FWriteBufferSize then
            FlushFullBuffer;
          FWriteBuffer[FWriteBufferPosition] := Ord('r');
        end;
      #$9:
        begin
          FWriteBuffer[FWriteBufferPosition] := Ord('\');
          if Incr(FWriteBufferPosition) = FWriteBufferSize then
            FlushFullBuffer;
          FWriteBuffer[FWriteBufferPosition] := Ord('t');
        end;
      else
        if (CurrentChar < WideChar(32)) or (CurrentChar > WideChar(255)) then
        begin
          FWriteBuffer[FWriteBufferPosition] := Ord('\');
          if Incr(FWriteBufferPosition) = FWriteBufferSize then
            FlushFullBuffer;
          FWriteBuffer[FWriteBufferPosition] := Ord('u');
          if Incr(FWriteBufferPosition) = FWriteBufferSize then
            FlushFullBuffer;
          UnicodeValue := Ord(CurrentChar);
          FWriteBuffer[FWriteBufferPosition] := Hex[(UnicodeValue and 61440) shr 12];
          if Incr(FWriteBufferPosition) = FWriteBufferSize then
            FlushFullBuffer;
          FWriteBuffer[FWriteBufferPosition] := Hex[(UnicodeValue and 3840) shr 8];
          if Incr(FWriteBufferPosition) = FWriteBufferSize then
            FlushFullBuffer;
          FWriteBuffer[FWriteBufferPosition] := Hex[(UnicodeValue and 240) shr 4];
          if Incr(FWriteBufferPosition) = FWriteBufferSize then
            FlushFullBuffer;
          FWriteBuffer[FWriteBufferPosition] := Hex[(UnicodeValue and 15)];
        end
        else 
          FWriteBuffer[FWriteBufferPosition] := Ord(CurrentChar);
    end;
  end;
  if Incr(FWriteBufferPosition) = FWriteBufferSize then
    FlushFullBuffer;
  FWriteBuffer[FWriteBufferPosition] := Ord('"');
end;

procedure TDBXJSonStreamWriter.TraceWrite(const Count: Integer);
begin
end;

procedure TDBXJSonStreamWriter.Flush;
begin
  FChannel.Write(FWriteBuffer, 0, FWriteBufferPosition + 1);
  TraceWrite(FWriteBufferPosition + 1);
  FWriteBufferPosition := -1;
end;

procedure TDBXJSonStreamWriter.FlushFullBuffer;
begin
  FChannel.Write(FWriteBuffer, 0, FWriteBufferPosition);
  TraceWrite(FWriteBufferPosition);
  FWriteBufferPosition := 0;
end;

procedure TDBXJSonStreamWriter.WriteInt(const InData: Integer);
var
  Data, DecimalBufferLength, DecimalPosition: Integer;
  LocalDecimalBuffer: TArray<Byte>;
begin
  Data := InData;
  LocalDecimalBuffer := FDecimalBuffer;
  DecimalBufferLength := Length(LocalDecimalBuffer);
  DecimalPosition := DecimalBufferLength;
  if Data < 0 then
  begin
    if Incr(FWriteBufferPosition) = FWriteBufferSize then
      FlushFullBuffer;
    FWriteBuffer[FWriteBufferPosition] := Ord('-');
    Data := -Data;
  end;
  if Data < 10 then
  begin
    if Incr(FWriteBufferPosition) = FWriteBufferSize then
      FlushFullBuffer;
    FWriteBuffer[FWriteBufferPosition] := Byte((Ord('0') + Byte(Data)));
    Exit;
  end;
  while Data <> 0 do
  begin
    LocalDecimalBuffer[Decr(DecimalPosition)] := Byte((Ord('0') + Byte((Data mod 10))));
    Data := Data div 10;
  end;
  Dec(DecimalPosition);
  while Incr(DecimalPosition) < DecimalBufferLength do
  begin
    if Incr(FWriteBufferPosition) = FWriteBufferSize then
      FlushFullBuffer;
    FWriteBuffer[FWriteBufferPosition] := LocalDecimalBuffer[DecimalPosition];
  end;
end;

procedure TDBXJSonStreamWriter.WriteByte(const Data: Byte);
begin
  WriteInt(Data);
end;

procedure TDBXJSonStreamWriter.WriteSpace;
begin
  if Incr(FWriteBufferPosition) = FWriteBufferSize then
    FlushFullBuffer;
  FWriteBuffer[FWriteBufferPosition] := Ord(' ');
end;

procedure TDBXJSonStreamWriter.WriteShort(const Data: SmallInt);
begin
  WriteInt(Data);
end;

procedure TDBXJSonStreamWriter.WriteLong(const InData: Int64);
var
  Data: Int64;
  LocalDecimalBuffer: TArray<Byte>;
  DecimalBufferLength, DecimalPosition: Integer;
begin
  Data := InData;
  LocalDecimalBuffer := FDecimalBuffer;
  DecimalBufferLength := Length(LocalDecimalBuffer);
  DecimalPosition := DecimalBufferLength;
  if Data < 0 then
  begin
    if Incr(FWriteBufferPosition) = FWriteBufferSize then
      FlushFullBuffer;
    FWriteBuffer[FWriteBufferPosition] := Ord('-');
    Data := -Data;
  end;
  if Data < 10 then
  begin
    if Incr(FWriteBufferPosition) = FWriteBufferSize then
      FlushFullBuffer;
    FWriteBuffer[FWriteBufferPosition] := Byte((Ord('0') + Byte(Data)));
    Exit;
  end;
  while Data <> 0 do
  begin
    LocalDecimalBuffer[Decr(DecimalPosition)] := Byte((Ord('0') + Byte((Data mod 10))));
    Data := Data div 10;
  end;
  Dec(DecimalPosition);
  while Incr(DecimalPosition) < DecimalBufferLength do
  begin
    if Incr(FWriteBufferPosition) = FWriteBufferSize then
      FlushFullBuffer;
    FWriteBuffer[FWriteBufferPosition] := LocalDecimalBuffer[DecimalPosition];
  end;
end;

procedure TDBXJSonStreamWriter.WriteFloat(const Data: Single);
begin
end;

procedure TDBXJSonStreamWriter.WriteDouble(const Data: Double);
begin
end;

procedure TDBXJSonStreamWriter.WriteBoolean(const Data: Boolean);
begin
  if Data then
    WriteBytes(TrueValue)
  else 
    WriteBytes(FalseValue);
end;

procedure TDBXJSonStreamWriter.WriteNull;
begin
  WriteBytes(NullValue);
end;

procedure TDBXJSonStreamWriter.WriteMetadata(const Data: TJSONObject);
var
  Buffer: TArray<Byte>;
  MessageLen: Integer;
begin
  SetLength(Buffer,Data.EstimatedByteSize);
  MessageLen := Data.ToBytes(Buffer, 0);
  WriteObjectStart;
  WriteBytes(MetadataStart);
  WriteInt(MessageLen);
  WriteValueSeparator;
  WriteDataBytes(Buffer, 0, MessageLen);
  WriteArrayEnd;
  WriteObjectEnd;
end;

procedure TDBXJSonStreamWriter.WriteCallback(const Data: TJSONValue);
var
  Buffer: TArray<Byte>;
  MessageLen: Integer;
begin
  SetLength(Buffer,Data.EstimatedByteSize);
  MessageLen := Data.ToBytes(Buffer, 0);
  WriteObjectStart;
  WriteBytes(CallbackStart);
  WriteInt(MessageLen);
  WriteValueSeparator;
  WriteDataBytes(Buffer, 0, MessageLen);
  WriteArrayEnd;
  WriteObjectEnd;
end;

procedure TDBXJSonStreamWriter.WriteCallbackResponse(const Data: TJSONValue);
var
  Buffer: TArray<Byte>;
  MessageLen: Integer;
begin
  SetLength(Buffer,Data.EstimatedByteSize);
  MessageLen := Data.ToBytes(Buffer, 0);
  WriteBytes(DataStart);
  WriteInt(MessageLen);
  WriteValueSeparator;
  WriteDataBytes(Buffer, 0, MessageLen);
  WriteArrayEnd;
  WriteObjectEnd;
end;

procedure TDBXJSonStreamWriter.WriteSignature;
begin
end;

procedure TDBXJSonStreamWriter.Open;
begin
  CreateBuffers;
end;

procedure TDBXJSonStreamWriter.Close;
begin
end;

function TDBXJSonStreamWriter.IsClosed: Boolean;
begin
  Result := False;
end;

function TDBXJSonStreamWriter.IsConnectionLost: Boolean;
begin
  Result := Assigned(FChannel) and FChannel.ConnectionLost;
end;

procedure TDBXJSonStreamWriter.CreateBuffers;
begin
  FWriteBufferPosition := -1;
  if FWriteBufferSize = 0 then
    FWriteBufferSize := 1024 * 8;
  SetLength(FWriteBuffer,FWriteBufferSize);
  SetLength(FDecimalBuffer,20);
end;

procedure TDBXJSonStreamWriter.Skip(const Count: Integer);
begin
  FWriteBufferPosition := FWriteBufferPosition + Count;
end;

destructor TDBXJSonStreamWriter.Destroy;
begin
  FWriteBuffer := nil;
  FDecimalBuffer := nil;
  inherited Destroy;
end;

procedure TDBXRowBlobStreamReader.Init(const IsBlobHeader: Boolean; const Size: Int64; const BufferSize: Integer);
begin
  InitBufferTo(BufferSize);
  FEos := False;
  FHasMoreData := True;
  if IsBlobHeader then
    self.FKnownSize := Size
  else 
  begin
    FKnownSize := -1;
    FBufferBytes := BufferSize;
    FBufferOffset := 0;
  end;
end;

procedure TDBXRowBlobStreamReader.InitBufferTo(const BufferSize: Integer);
begin
  if (FBuffer = nil) or (Length(FBuffer) < BufferSize) then
    SetLength(FBuffer,BufferSize);
end;

procedure TDBXRowBlobStreamReader.Store(const InBuffer: TArray<Byte>; const InOffset: Integer; const Count: Integer);
begin
  InitBufferTo(Count);
  TDBXPlatform.CopyByteArray(InBuffer, InOffset, self.FBuffer, 0, Count);
  FBufferBytes := Count;
  FBufferOffset := 0;
end;

procedure TDBXRowBlobStreamReader.Store(const Count: Integer);
begin
  InitBufferTo(Count);
  FDbxStreamReader.ReadDataBytes(FBuffer, 0, Count);
  FBufferBytes := Count;
  FBufferOffset := 0;
end;

function TDBXRowBlobStreamReader.Read(const Buf: TArray<Byte>; const InOffset: Integer; const InSize: Integer): Integer;
var
  Offset: Integer;
  Size: Integer;
  ReturnBytes: Integer;
  TransferBytes: Integer;
  AvailableBytes: Integer;
begin
  Offset := InOffset;
  Size := InSize;
  ReturnBytes := 0;
  if FClient and (FCommandHandle[0] < 0) then
    raise TDBXError.Create(TDBXErrorCodes.InvalidHandle, SCommandClosed);
  if FBufferBytes > 0 then
  begin
    TransferBytes := FBufferBytes;
    if Size < TransferBytes then
      TransferBytes := Size;
    TDBXPlatform.CopyByteArray(FBuffer, FBufferOffset, Buf, Offset, TransferBytes);
    Offset := Offset + TransferBytes;
    FBufferOffset := FBufferOffset + TransferBytes;
    FBufferBytes := FBufferBytes - TransferBytes;
    ReturnBytes := ReturnBytes + TransferBytes;
    Size := Size - TransferBytes;
    if Size < 1 then
      Exit(ReturnBytes);
  end;
  if not FHasMoreData then
  begin
    FEos := True;
    Exit(ReturnBytes);
  end;
  if FClient then
  begin
    FDbxStreamWriter.WriteClientMoreBlobObject(FCommandHandle[0], FRowHandle, FBlobHandle, FRow, FOrdinal, FParameterBuffer);
    FDbxStreamReader.NextResultObjectStart;
    FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
  end
  else 
    FDbxStreamWriter.WriteServerMoreBlobObject(FCommandHandle[0], FRowHandle, FBlobHandle, FRow, FOrdinal);
  FDbxStreamReader.Next(TDBXTokens.ObjectStartToken);
  FDbxStreamReader.Next(TDBXTokens.StringStartToken);
  FDbxStreamReader.ReadStringCode;
  FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
  FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
  AvailableBytes := FDbxStreamReader.ReadInt;
  FDbxStreamReader.Next(TDBXTokens.ValueSeparatorToken);
  if AvailableBytes <= 0 then
  begin
    FHasMoreData := False;
    AvailableBytes := -AvailableBytes;
  end;
  TransferBytes := AvailableBytes;
  if Size < TransferBytes then
    TransferBytes := Size;
  ;
  FDbxStreamReader.ReadDataBytes(Buf, Offset, TransferBytes);
  AvailableBytes := AvailableBytes - TransferBytes;
  if AvailableBytes > 0 then
    Store(AvailableBytes);
  FDbxStreamReader.SkipToEndOfObject;
  if FClient then
    FDbxStreamReader.SkipToEndOfObject;
  ReturnBytes := ReturnBytes + TransferBytes;
  Result := ReturnBytes;
end;

function TDBXRowBlobStreamReader.Eos: Boolean;
begin
  Result := FEos;
end;

function TDBXRowBlobStreamReader.Size: Int64;
begin
  Result := FKnownSize;
end;

procedure TDBXRowBlobStreamReader.Close;
begin
end;

destructor TDBXRowBlobStreamReader.Destroy;
begin
  FBuffer := nil;
  FCommandHandle := nil;
  inherited Destroy;
end;
//    Diagnostic.freeAndNullout(dbxStreamReader);
//    Diagnostic.freeAndNullout(dbxStreamWriter);

constructor TDBXRowBuffer.Create;
begin
  inherited Create;
  SetLength(FCommandHandle,1);
  SetLength(FRowOffsets,16);
  FDecoder := TDBXStringDecoder.Create;
  FEncoder := TDBXStringEncoder.Create;
  FMaxInline := 1024;
  FCommandHandle[0] := -1;
  FLastHeaderOffset := 0;
  FHeaderConsumed := False;
  FLastOrdinal := 0;
end;

destructor TDBXRowBuffer.Destroy;
begin
  FreeAndNil(FDecoder);
  FreeAndNil(FEncoder);
  FreeAndNil(FBlobStreamReader);
  FCommandHandle[0] := -1;
  FCommandHandle := nil;
  FRowOffsets := nil;
  inherited Destroy;
end;

procedure TDBXRowBuffer.SetPreventDecoderGrowth(const PreventGrowth: Boolean);
begin
  FDecoder.PreventGrowth := PreventGrowth;
end;

procedure TDBXRowBuffer.GrowRowOffsets;
var
  Temp: TDBXInt32s;
begin
  SetLength(Temp,FRowCount + 16);
  TDBXPlatform.CopyInt32Array(FRowOffsets, 0, Temp, 0, Length(FRowOffsets));
  FRowOffsets := Temp;
end;

procedure TDBXRowBuffer.MakePositionValid;
begin
  if FHeaderConsumed then
  begin
    FOff := FLastHeaderOffset;
    FHeaderConsumed := False;
    FCurrentOrdinal := FLastOrdinal;
  end;
end;

function TDBXRowBuffer.NextRow: Boolean;
var
  Index: Integer;
begin
  MakePositionValid;
  if FOff < FReadSize then
  begin
//      off = rowOffsets[currentRow];
//      for (int index = 0; index < columnCount; ++index) {
    for Index := FCurrentOrdinal to FColumnCount - 1 do
      SkipField;
    FCurrentOrdinal := 0;
    if FOff < FReadSize then
    begin
      FCurrentTotalRow := FCurrentTotalRow + 1;
      if Incr(FCurrentRow) > FRowCount then
      begin
        FRowCount := FCurrentRow;
        if FRowCount >= Length(FRowOffsets) then
          GrowRowOffsets;
        FRowOffsets[FCurrentRow] := FOff;
      end;
      Exit(True);
    end;
    Result := False;
  end
  else 
    Result := False;
end;

function TDBXRowBuffer.GoToRow(const Row: Integer): Boolean;
begin
  if Row > FRowCount then
    while NextRow do
    begin
      if FCurrentRow = Row then
        Exit(True);
    end;
  Result := False;
end;

procedure TDBXRowBuffer.GoToField(const Ordinal: Integer);
begin
  MakePositionValid;
  if FCurrentOrdinal > Ordinal then
  begin
    FCurrentOrdinal := 0;
    FOff := FRowOffsets[FCurrentRow];
  end;
  while Ordinal > FCurrentOrdinal do
    SkipField;
end;

function TDBXRowBuffer.IsNull: Boolean;
begin
  Result := ((Integer(FBuf[FOff])) and TDBXFieldHeader.FNullValue) <> 0;
end;

function TDBXRowBuffer.IsCallback: Boolean;
begin
  Result := FBuf[FOff] = TDBXFieldHeader.FCallbackField;
end;

function TDBXRowBuffer.IsLastParameterBlobSegment: Boolean;
var
  Header: Integer;
begin
  Header := (Integer(FBuf[FOff]));
//    return ((header & DBXFieldHeader.Positive) == 0) && (header != DBXFieldHeader.BlobHeader);
//    return (header & DBXFieldHeader.BlobMask) != DBXFieldHeader.BlobHeader;
  Result := ((Header and TDBXFieldHeader.FPositive) = 0) and (Header <> TDBXFieldHeader.FBlobHeader) and (Header <> TDBXFieldHeader.FBlobRefHeader);
end;

function TDBXRowBuffer.ReadParameterBlobSize: Integer;
var
  Header: Integer;
  Size: Integer;
begin
  Header := (Integer(FBuf[FOff]));
  FLastHeaderOffset := FOff;
  FHeaderConsumed := True;
  FLastOrdinal := FCurrentOrdinal;
  if (Header and TDBXFieldHeader.FTinyField) <> 0 then
    Size := Header and TDBXFieldHeader.FTinyHeaderLengthMask
  else 
    Size := ((FBuf[Incr(FOff)] and 255) shl 8) or (FBuf[Incr(FOff)] and 255);
  Inc(FOff);
  Inc(FCurrentOrdinal);
  Result := Size;
end;

function TDBXRowBuffer.ReadReaderBlobSize: Integer;
var
  Header, Size: Integer;
begin
  Size := 0;
  FLastHeaderOffset := FOff;
  FHeaderConsumed := True;
  FLastOrdinal := FCurrentOrdinal;
  Header := Integer(FBuf[IncrAfter(FOff)]);
  if (Header and TDBXFieldHeader.FTinyField) <> 0 then
    Size := Header and TDBXFieldHeader.FTinyHeaderLengthMask
  else if (Header and TDBXFieldHeader.FBigField) = TDBXFieldHeader.FBigField then
    Size := ((FBuf[IncrAfter(FOff)] and 255) shl 8) or (FBuf[IncrAfter(FOff)] and 255)
  else if (Header and TDBXFieldHeader.FBlobHeader) <> 0 then
  begin
    Dec(FOff);
    Size := TDBXFieldPacker.GetBlobLength(FBuf, FOff);
    FOff := FOff + TDBXFieldPacker.GetBlobHeaderLength(FBuf, FOff);
  end;
  Inc(FCurrentOrdinal);
  Result := Size;
end;

function TDBXRowBuffer.IsBlobHeader: Boolean;
begin
  Result := (((Integer(FBuf[FOff])) and TDBXFieldHeader.FBlobMask) or TDBXFieldHeader.FPositive) = (TDBXFieldHeader.FBlobHeader or TDBXFieldHeader.FPositive);
end;

procedure TDBXRowBuffer.ReadBytes(const DestBuf: TArray<Byte>; const DestOff: Integer; const Count: Integer);
begin
  TDBXPlatform.CopyByteArray(FBuf, FOff, DestBuf, DestOff, Count);
  FOff := FOff + Count;
end;

function TDBXRowBuffer.ReadNull: Boolean;
begin
  Inc(FOff);
  Inc(FCurrentOrdinal);
  FHeaderConsumed := False;
  FLastHeaderOffset := FOff;
  FLastOrdinal := FCurrentOrdinal;
  if (FBuf[FOff - 1] and TDBXFieldHeader.FAssignedNull) <> 0 then
    Exit(True);
  Result := False;
end;

procedure TDBXRowBuffer.ReadCallback;
begin
  Inc(FOff);
  Inc(FCurrentOrdinal);
  FHeaderConsumed := False;
  FLastHeaderOffset := FOff;
  FLastOrdinal := FCurrentOrdinal;
end;

function TDBXRowBuffer.GetEncodedStringLength: Integer;
var
  SaveOff: Integer;
  Size: Integer;
begin
  SaveOff := FOff;
  Size := ReadEncodedStringLength;
  FOff := SaveOff;
  Result := Size;
end;

function TDBXRowBuffer.ReadEncodedStringLength: Integer;
var
  Size: Integer;
  Header: Integer;
begin
  FLastHeaderOffset := FOff;
  Header := Integer(FBuf[IncrAfter(FOff)]);
  if (Header and TDBXFieldHeader.FTinyField) <> 0 then
  begin
    Size := Header and TDBXFieldHeader.FTinyHeaderLengthMask;
    ;
  end
  else if (Header and TDBXFieldHeader.FBigField) = TDBXFieldHeader.FBigField then
  begin
    Size := ((FBuf[IncrAfter(FOff)] and 255) shl 8) or (FBuf[IncrAfter(FOff)] and 255);
    ;
  end
  else if Header = TDBXFieldHeader.FNullTermStringField then
  begin
    Dec(FOff);
    if FTwoByteStringTerminator then
    begin
      Size := SkipNullTermString - TDBXFieldHeader.FTinyHeaderLength - TDBXFieldHeader.FOldNullTermLength;
      ;
    end
    else 
    begin
      Size := SkipNullTermString - TDBXFieldHeader.FTinyHeaderLength - TDBXFieldHeader.FNullTermLength;
      ;
    end;
    Inc(FOff);
  end
  else if (Header and TDBXFieldHeader.FBlobHeader) <> 0 then
  begin
    Dec(FOff);
    Size := TDBXFieldPacker.GetBlobLength(FBuf, FOff);
    ;
    FOff := FOff + TDBXFieldPacker.GetBlobHeaderLength(FBuf, FOff);
  end
  else 
  begin
    FDbxContext.Error(0, SUnexpectedHeader, nil);
    Size := 0;
  end;
  FHeaderConsumed := True;
  Result := Size;
end;

function TDBXRowBuffer.ReadChars(const RowHandle: Integer; const CharBuf: TDBXWideChars; const MaxChars: Integer): Integer;
var
  Count, EncodedSize, Size: Integer;
  Reader: TDBXStreamReader;
  FreeReader: Boolean;
begin
  FDecoder.InitWideCharsDecoder(CharBuf);
  if LastParameterBlobSegment then
  begin
    EncodedSize := ReadEncodedStringLength;
    FDecoder.Decode(FBuf, FOff, MaxChars);
    FOff := FOff + EncodedSize;
    Inc(FCurrentOrdinal);
    FHeaderConsumed := False;
    FLastHeaderOffset := FOff;
    FLastOrdinal := FCurrentOrdinal;
  end
  else 
  begin
    if FClient or BlobHeader then
    begin
      Reader := GetRowBlobStreamReader(RowHandle);
      FreeReader := False;
    end
    else 
    begin
      Reader := ReadBlobStreamReader(RowHandle);
      FreeReader := True;
    end;
    try
      if FBlobStringBuffer = nil then
        SetLength(FBlobStringBuffer,32 * 1024);
      while not Reader.Eos do
      begin
        Count := Reader.Read(FBlobStringBuffer, 0, Length(FBlobStringBuffer));
        FDecoder.Decode(FBlobStringBuffer, 0, Count);
      end;
    finally
      if FreeReader then
        FreeAndNil(Reader);
    end;
  end;
  Size := FDecoder.DecodeOff + 1;
  FDecoder.AddNullChar;
  Result := Size;
end;

function TDBXRowBuffer.ReadInlineAnsiChars(const RowHandle: Integer; const ByteBuf: TArray<Byte>; const MaxChars: Integer): Integer;
var
  EncodedSize: Integer;
  Size: Integer;
begin
  Size := 0;
  if LastParameterBlobSegment then
  begin
    EncodedSize := ReadEncodedStringLength;
    TDBXPlatform.CopyByteArray(FBuf, FOff, ByteBuf, 0, EncodedSize);
    Size := EncodedSize;
    FOff := FOff + EncodedSize;
    Inc(FCurrentOrdinal);
    FHeaderConsumed := False;
    FLastHeaderOffset := FOff;
    FLastOrdinal := FCurrentOrdinal;
  end
  else 
    ;
  Result := Size;
end;

function TDBXRowBuffer.ReadString(const RowHandle: Integer): string;
var
  Count, Size: Integer;
  Reader: TDBXStreamReader;
  FreeReader: Boolean;
begin
  FDecoder.InitDecoder;
  if LastParameterBlobSegment then
  begin
    Size := ReadEncodedStringLength;
    FDecoder.Decode(FBuf, FOff, Size);
    Inc(FCurrentOrdinal);
    FOff := FOff + Size;
    FHeaderConsumed := False;
    FLastHeaderOffset := FOff;
    FLastOrdinal := FCurrentOrdinal;
  end
  else 
  begin
    if BlobHeader then
    begin
      Reader := GetRowBlobStreamReader(RowHandle);
      FreeReader := False;
    end
    else 
    begin
      Reader := ReadBlobStreamReader(RowHandle);
      FreeReader := True;
    end;
    try
      if FBlobStringBuffer = nil then
        SetLength(FBlobStringBuffer,256);
      while not Reader.Eos do
      begin
        Count := Reader.Read(FBlobStringBuffer, 0, Length(FBlobStringBuffer));
        FDecoder.Decode(FBlobStringBuffer, 0, Count);
      end;
    finally
      if FreeReader then
        FreeAndNil(Reader);
    end;
  end;
  Result := TDBXPlatform.CreateWideString(FDecoder.DecodeBuf, FDecoder.DecodeOff + 1);
end;

function TDBXRowBuffer.ReadStringBytes(const RowHandle: Integer; const ByteBuf: TArray<Byte>; const Offset: Integer): Integer;
var
  Reader: TDBXStreamReader;
  Count, EncodedSize, Size: Integer;
  FreeReader: Boolean;
begin
  if LastParameterBlobSegment then
  begin
    Inc(FCurrentOrdinal);
    EncodedSize := ReadEncodedStringLength;
    FDecoder.DecodeToWideBytes(FBuf, FOff, ByteBuf, EncodedSize);
    FOff := FOff + EncodedSize;
    FHeaderConsumed := False;
    FLastHeaderOffset := FOff;
    FLastOrdinal := FCurrentOrdinal;
  end
  else 
  begin
    if BlobHeader then
    begin
      Reader := GetRowBlobStreamReader(RowHandle);
      FreeReader := False;
    end
    else 
    begin
      Reader := ReadBlobStreamReader(RowHandle);
      FreeReader := True;
    end;
    if FBlobStringBuffer = nil then
      SetLength(FBlobStringBuffer,256);
    try
      if not Reader.Eos then
      begin
        Count := Reader.Read(FBlobStringBuffer, 0, Length(FBlobStringBuffer));
        FDecoder.DecodeToWideBytes(FBlobStringBuffer, 0, ByteBuf, Count);
        while not Reader.Eos do
        begin
          Count := Reader.Read(FBlobStringBuffer, 0, Length(FBlobStringBuffer));
          FDecoder.DecodeBytes(FBlobStringBuffer, 0, Count);
        end;
      end;
    finally
      if FreeReader then
        FreeAndNil(Reader);
    end;
  end;
  Size := FDecoder.DecodeByteOff - Offset;
  ByteBuf[Size + 1] := Ord(#$0);
  ByteBuf[Size + 2] := Ord(#$0);
  Result := Size + 2;
end;

function TDBXRowBuffer.ReadAnsiStringBytes(const RowHandle: Integer; const ByteBuf: TArray<Byte>; const Offset: Integer): Integer;
var
  Reader: TDBXStreamReader;
  Count, Size: Integer;
  FreeReader: Boolean;
begin
  Size := 0;
  if LastParameterBlobSegment then
  begin
    Inc(FCurrentOrdinal);
    Size := ReadEncodedStringLength;
    TDBXPlatform.CopyByteArray(FBuf, FOff, ByteBuf, Offset, Size);
    FOff := FOff + Size;
    FHeaderConsumed := False;
    FLastHeaderOffset := FOff;
    FLastOrdinal := FCurrentOrdinal;
  end
  else
  begin
    if BlobHeader then
    begin
      Reader := GetRowBlobStreamReader(RowHandle);
      FreeReader := False;
    end
    else
    begin
      Reader := ReadBlobStreamReader(RowHandle);
      FreeReader := True;
    end;
    if FBlobStringBuffer = nil then
      SetLength(FBlobStringBuffer,256);
    try
      if not Reader.Eos then
      begin
        Count := Reader.Read(FBlobStringBuffer, 0, Length(FBlobStringBuffer));
        TDBXPlatform.CopyByteArray(FBlobStringBuffer, 0, ByteBuf, Offset+Size, Count);
        Size := Size + Count;
        while not Reader.Eos do
        begin
          Count := Reader.Read(FBlobStringBuffer, 0, Length(FBlobStringBuffer));
          TDBXPlatform.CopyByteArray(FBlobStringBuffer, 0, ByteBuf, Offset+Size, Count);
          Size := Size + Count;
        end;
      end;
    finally
      if FreeReader then
        FreeAndNil(Reader);
    end;
  end;
  ByteBuf[Size] := Ord(#$0);
  Result := Size + 1;
end;

function TDBXRowBuffer.ReadStringBytes(const RowHandle: Integer): TArray<Byte>;
var
  Count, Size: Integer;
  FreeReader: Boolean;
  Reader: TDBXStreamReader;
begin
  if LastParameterBlobSegment then
  begin
    Size := ReadEncodedStringLength;
    FDecoder.InitByteDecoder((Size + 1) * 2);
    FDecoder.DecodeBytes(FBuf, FOff, Size);
    Inc(FCurrentOrdinal);
    FOff := FOff + Size;
    FHeaderConsumed := False;
    FLastHeaderOffset := FOff;
    FLastOrdinal := FCurrentOrdinal;
  end
  else 
  begin
    if BlobHeader then
    begin
      Reader := GetRowBlobStreamReader(RowHandle);
      FreeReader := False;
    end
    else 
    begin
      Reader := ReadBlobStreamReader(RowHandle);
      FreeReader := True;
    end;
    Size := ReadReaderBlobSize;
    Reader := GetRowBlobStreamReader(RowHandle);
    try
      if FBlobStringBuffer = nil then
        SetLength(FBlobStringBuffer,256);
      FDecoder.InitByteDecoder((Size + 1) * 2);
      while not Reader.Eos do
      begin
        Count := Reader.Read(FBlobStringBuffer, 0, Length(FBlobStringBuffer));
        FDecoder.DecodeBytes(FBlobStringBuffer, 0, Count);
      end;
      FOff := FOff + Size;
    finally
      if FreeReader then
        FreeAndNil(Reader);
    end;
  end;
  Result := FDecoder.ExtractDecodeByteBuffer;
end;

function TDBXRowBuffer.GetStringBytesLength: Integer;
begin
  Result := FDecoder.DecodeByteOff + 1;
end;

procedure TDBXRowBuffer.WriteBoolean(const Data: Boolean);
begin
  if FOff >= FBufLength then
    Growbuf(1);
  if Data then
    FBuf[IncrAfter(FOff)] := Byte((TDBXFieldHeader.FTinyField + TDBXFieldHeader.FPositive))
  else 
    FBuf[IncrAfter(FOff)] := Byte((TDBXFieldHeader.FTinyField));
end;

procedure TDBXRowBuffer.WriteByte(const Data: Byte);
begin
  WriteShort(Data);
end;

procedure TDBXRowBuffer.WriteShort(const Data: SmallInt);
begin
  if FOff + 3 > FBufLength then
    Growbuf(3);
  FOff := FOff + TDBXFieldPacker.PackAsciiShort(FBuf, FOff, Data, True);
end;

procedure TDBXRowBuffer.WriteInt32(const Data: Integer);
begin
  if FOff + 5 > FBufLength then
    Growbuf(5);
  FOff := FOff + TDBXFieldPacker.PackAsciiInt(FBuf, FOff, Data, True);
end;

procedure TDBXRowBuffer.WriteNull;
begin
  if FOff + 1 > FBufLength then
    Growbuf(1);
  FBuf[IncrAfter(FOff)] := Byte(TDBXFieldHeader.FAssignedNull);
end;

procedure TDBXRowBuffer.WriteCallback;
begin
  if FOff + 1 > FBufLength then
    Growbuf(1);
  FBuf[IncrAfter(FOff)] := Byte(TDBXFieldHeader.FCallbackField);
end;

function TDBXRowBuffer.AvailableInline: Integer;
begin
  if (FOff + FMaxInline + TDBXFieldHeader.FBigHeaderLength) > MinBufferSize then
    FLastInlinByteCount := FMaxInline
  else 
    FLastInlinByteCount := (FBufLength - FOff - TDBXFieldHeader.FBigHeaderLength);
  FLastInlinByteCount := Min(FLastInlinByteCount,(1 shl 16) - 1);
  Result := FLastInlinByteCount;
end;

function TDBXRowBuffer.WriteBytes(const Reader: TDBXStreamReader): Integer;
var
  TmpOff, TmpRead, Count: Integer;
const
  sReadSize = 8196;
begin
  if (FOff + TDBXFieldHeader.FBigHeaderLength + FMaxInline) > FBufLength then
    Growbuf(TDBXFieldHeader.FBigHeaderLength + FMaxInline);
  Count := Reader.Read(FBuf, FOff + TDBXFieldHeader.FBigHeaderLength, AvailableInline);
  if Count < 1 then
    FBuf[IncrAfter(FOff)] := Byte((TDBXFieldHeader.FTinyField))
  else
  begin
    if Reader.Eos then
      FBuf[FOff] := Byte((TDBXFieldHeader.FBigField))
    else
    begin
      // Make sure the size is known before attempting to read into overflow buffer
      //  This is a workaround as the TDBXLookAheadStreamReader (with size -1) will
      //  use this code path and handles overflow differently
      if Reader.Size <> -1 then
      begin
        //store off extra bytes into overflow buffer
        TmpOff := 0;
        repeat
          SetLength(FBytesOverFlowBuffer, TmpOff + sReadSize);
          TmpRead := Reader.Read(FBytesOverflowBuffer, TmpOff, sReadSize);
          if TmpRead < sReadSize then
            SetLength(FBytesOverFlowBuffer, TmpOff + TmpRead)
          else
            TmpOff := TmpOff + TmpRead;
        until (Reader.Eos) or (TmpRead < sReadSize);
      end;
      FBuf[FOff] := Byte((TDBXFieldHeader.FBigField + TDBXFieldHeader.FPositive));
    end;
    FBuf[FOff + 1] := Byte(((Count shr 8) and 255));
    FBuf[FOff + 2] := Byte(((Count) and 255));
    FOff := FOff + Count + TDBXFieldHeader.FBigHeaderLength;
  end;
  Result := Count;
end;

function TDBXRowBuffer.PrepareJSONByteBlock(const EstimatedSize: Integer): Integer;
begin
  if FOff + EstimatedSize + TDBXFieldHeader.FJSONBlockLength > FBufLength then
    Growbuf(EstimatedSize + TDBXFieldHeader.FJSONBlockLength);
  FBuf[FOff] := Byte(TDBXFieldHeader.FJSONField);
  FBuf[FOff + 1] := Byte(((EstimatedSize shr 24) and 255));
  FBuf[FOff + 2] := Byte(((EstimatedSize shr 16) and 255));
  FBuf[FOff + 3] := Byte(((EstimatedSize shr 8) and 255));
  FBuf[FOff + 4] := Byte(((EstimatedSize) and 255));
  Result := FOff + TDBXFieldHeader.FJSONBlockLength;
end;

procedure TDBXRowBuffer.EncodeJSONByteBlockSize(const Size: Integer);
begin
  FBuf[FOff] := TDBXFieldHeader.FJSONField;
  FBuf[FOff + 1] := Byte(((Size shr 24) and 255));
  FBuf[FOff + 2] := Byte(((Size shr 16) and 255));
  FBuf[FOff + 3] := Byte(((Size shr 8) and 255));
  FBuf[FOff + 4] := Byte(((Size) and 255));
  FOff := FOff + Size + TDBXFieldHeader.FJSONBlockLength;
end;

function TDBXRowBuffer.DecodeJSONByteBlockSize: Integer;
begin
  if FBuf[FOff] = TDBXFieldHeader.FJSONField then
    Result := ((FBuf[FOff + 1] shl 24) or (FBuf[FOff + 2] shl 16) or (FBuf[FOff + 3] shl 8) or (FBuf[FOff + 4]))
  else if Null then
    Result := 0
  else 
    raise TDBXError.Create(0, SInvalidJSONHeaderByte);
end;

function TDBXRowBuffer.JsonByteBlockOffset: Integer;
begin
  if FBuf[FOff] = TDBXFieldHeader.FJSONField then
    Result := FOff + TDBXFieldHeader.FJSONBlockLength
  else if Null then
    Result := -1
  else 
    raise TDBXError.Create(0, SInvalidJSONHeaderByte);
end;

procedure TDBXRowBuffer.WriteInt64(const Data: Int64);
begin
  if FOff + 9 > FBufLength then
    Growbuf(9);
  FOff := FOff + TDBXFieldPacker.PackAsciiLong(FBuf, FOff, Data, True);
end;

procedure TDBXRowBuffer.WriteDouble(const Data: Double);
begin
  if FOff + 9 > FBufLength then
    Growbuf(9);
  FOff := FOff + TDBXFieldPacker.PackDouble(FBuf, FOff, Data, False);
end;

procedure TDBXRowBuffer.WriteSingle(const Data: Single);
begin
  if FOff + 5 > FBufLength then
    Growbuf(5);
  FOff := FOff + TDBXFieldPacker.PackFloat(FBuf, FOff, Data, False);
end;

procedure TDBXRowBuffer.WriteTimestamp(const TimeValue: Int64; const Nanos: Integer);
var
  StartPos: Integer;
begin
  if FOff + 14 > FBufLength then
    Growbuf(14);
  StartPos := IncrAfter(FOff);
  WriteInt64(TimeValue);
  if Nanos <> 0 then
  begin
    TDBXFieldPacker.PackInt(FBuf, FOff, Nanos);
    FOff := FOff + 4;
  end;
  FBuf[StartPos] := Byte((TDBXFieldHeader.FTinyField + (FOff - StartPos) - TDBXFieldHeader.FTinyHeaderLength));
end;

function TDBXRowBuffer.WriteString(const Data: string): Boolean;
var
  AvailableBytes, DataLength, EncodeEndOff, EncodeLength, EncodeStartOff, SaveOff: Integer;
  Fits: Boolean;
begin
  DataLength := Data.Length;
  if (FOff + FMaxInline + TDBXFieldHeader.FMaxHeaderLength) > FBufLength then
    Growbuf(TDBXFieldHeader.FMaxHeaderLength + FMaxInline);
  AvailableBytes := AvailableInline;
  if DataLength <= TDBXFieldHeader.FTinyHeaderLengthMask then
    EncodeStartOff := FOff + TDBXFieldHeader.FTinyHeaderLength
  else
    EncodeStartOff := FOff + TDBXFieldHeader.FBigHeaderLength;
  Fits := not FEncoder.Encode(Data, FBuf, EncodeStartOff, AvailableBytes, False);
  EncodeEndOff := FEncoder.EncodeOff;
  EncodeLength := EncodeEndOff - EncodeStartOff;
  if Fits then
  begin
    if (EncodeLength > TDBXFieldHeader.FTinyHeaderLengthMask) and (EncodeStartOff = (FOff + TDBXFieldHeader.FTinyHeaderLength)) then
    begin
      TDBXPlatform.CopyByteArray(FBuf, EncodeStartOff, FBuf, EncodeStartOff + (TDBXFieldHeader.FBigHeaderLength - TDBXFieldHeader.FTinyHeaderLength), EncodeLength);
      EncodeEndOff := EncodeEndOff + (TDBXFieldHeader.FBigHeaderLength - TDBXFieldHeader.FTinyHeaderLength);
    end;
    TDBXFieldPacker.PackStringHeader(FBuf, FOff, EncodeLength);
    FOff := EncodeEndOff;
  end
  else 
  begin
    TDBXPlatform.CopyByteArray(FEncoder.EncodeBuf, 0, FBuf, EncodeStartOff, AvailableBytes);
    SaveOff := FOff;
    FOff := TDBXFieldPacker.PackStringHeader(FBuf, FOff, AvailableBytes);
    FBuf[SaveOff] := FBuf[SaveOff] or TDBXFieldHeader.FPositive;
    FOff := FOff + AvailableBytes;
  end;
  Result := Fits;
end;

function TDBXRowBuffer.GetOverflowStringBytes: TArray<Byte>;
var
  Overflow: TArray<Byte>;
  LCount: Integer;
begin
  LCount := Length(FBytesOverflowBuffer);
  if FEncoder.EncodeOff > 0 then
  begin
    SetLength(Overflow,FEncoder.EncodeOff - FLastInlinByteCount);
    TDBXPlatform.CopyByteArray(FEncoder.EncodeBuf, FLastInlinByteCount, Overflow, 0, FEncoder.EncodeOff - FLastInlinByteCount);
  end
  else if LCount > 0 then
  begin
    SetLength(Overflow, LCount);
    TDBXPlatform.CopyByteArray(FBytesOverflowBuffer, 0, Overflow, 0, LCount);
  end
  else
    SetLength(Overflow, 0);
  Result := Overflow;
end;

procedure TDBXRowBuffer.Post;
begin
  FOff := 0;
  FHeaderConsumed := False;
  FLastHeaderOffset := FOff;
  FLastOrdinal := 0;
end;

procedure TDBXRowBuffer.Cancel;
begin
  FOff := 0;
  FHeaderConsumed := False;
  FLastHeaderOffset := FOff;
  FLastOrdinal := 0;
end;

procedure TDBXRowBuffer.SetReadSize(const Size: Integer);
begin
  FReadSize := Size;
  FCurrentOrdinal := 0;
  FCurrentRow := 0;
  FOff := 0;
  FRowCount := 0;
  FHeaderConsumed := False;
  FLastHeaderOffset := FOff;
  FLastOrdinal := FCurrentOrdinal;
end;

procedure TDBXRowBuffer.InitRowBlobStreamReader(const Reader: TDBXRowBlobStreamReader; const RowHandle: Integer);
var
  IsBlobHeader: Boolean;
  Size: Integer;
  BufferSize: Integer;
begin
  Reader.Row := FCurrentTotalRow;
  Reader.Ordinal := FCurrentOrdinal;
  Reader.BlobHandle := Incr(FBlobId);
  Reader.ParameterBuffer := FParameterBuffer;
  Reader.RowHandle := RowHandle;
  IsBlobHeader := BlobHeader;
  Size := ReadReaderBlobSize;
  BufferSize := 1 * 1024;
  if BufferSize < Size then
    BufferSize := Size;
  Reader.Init(IsBlobHeader, Size, BufferSize);
  if not IsBlobHeader then
  begin
    Reader.Store(FBuf, FOff, Size);
    FOff := FOff + Size;
  end;
end;

procedure TDBXRowBuffer.ReadDataBytes;
var
  ParameterBytes: Integer;
begin
  ParameterBytes := FDbxStreamReader.ReadInt;
  MinBufferSize := ParameterBytes;
  FDbxStreamReader.NextValueSeparator;
  ReadSize := 0;
  FDbxStreamReader.ReadDataBytes(Buffer, 0, ParameterBytes);
end;

function TDBXRowBuffer.ReadBlobStreamReader(const RowHandle: Integer): TDBXStreamReader;
var
  Reader: TDBXRowBlobStreamReader;
begin
  Reader := TDBXRowBlobStreamReader.Create;
  Reader.Client := FClient;
  Reader.CommandHandle := FCommandHandle;
  Reader.StreamReader := FDbxStreamReader;
  Reader.StreamWriter := FDbxStreamWriter;
  InitRowBlobStreamReader(Reader, RowHandle);
  Result := Reader;
end;

function TDBXRowBuffer.GetRowBlobStreamReader(const RowHandle: Integer): TDBXRowBlobStreamReader;
begin
  if (FBlobStreamReader = nil) or (FBlobStreamReader.CommandHandle[0] < 0) then
  begin
    FreeAndNil(FBlobStreamReader);
    FBlobStreamReader := TDBXRowBlobStreamReader.Create;
    FBlobStreamReader.Client := FClient;
    FBlobStreamReader.CommandHandle := FCommandHandle;
    FBlobStreamReader.StreamReader := FDbxStreamReader;
    FBlobStreamReader.StreamWriter := FDbxStreamWriter;
  end;
  InitRowBlobStreamReader(FBlobStreamReader, RowHandle);
  Result := FBlobStreamReader;
end;

procedure TDBXRowBuffer.SetDbxStreamReader(const DbxStreamReader: TDBXJSonStreamReader);
begin
  FDbxStreamReader := DbxStreamReader;
end;

procedure TDBXRowBuffer.SetDbxStreamWriter(const DbxStreamWriter: TDBXJSonStreamWriter);
begin
  FDbxStreamWriter := DbxStreamWriter;
end;

procedure TDBXStringDecoder.InitWideCharsDecoder(const OutBuf: TDBXWideChars);
begin
  FDecodeBuf := OutBuf;
  FDecodeLength := Length(OutBuf);
  InitDecoder;
end;

procedure TDBXStringDecoder.InitByteDecoder;
begin
  if FDecodeByteOff > FMaxOff then
    FMaxOff := FDecodeByteOff;
  FDecodeByteOff := -1;
  FHitChar := False;
  FHasHalfChar := False;
  FAddQuotes := False;
end;

procedure TDBXStringDecoder.GrowDecodeByteBuf;
var
  NewSize: Integer;
  NewDecodeByteBuf: TArray<Byte>;
begin
  NewSize := FDecodeLength * 2;
  if NewSize < 1 then
    NewSize := 16;
  if FDecodeByteLength < NewSize then
  begin
    FDecodeLength := NewSize;
    SetLength(NewDecodeByteBuf,NewSize);
    if FDecodeBuf <> nil then
      TDBXPlatform.CopyByteArray(FDecodeByteBuf, 0, NewDecodeByteBuf, 0, FDecodeOff);
    FDecodeByteBuf := NewDecodeByteBuf;
  end;
end;

procedure TDBXStringDecoder.InitByteDecoder(const ExpectedSize: Integer);
begin
  SetLength(FDecodeByteBuf,ExpectedSize);
  FDecodeByteLength := ExpectedSize;
  InitByteDecoder;
end;

function TDBXStringDecoder.DecodeToWideBytes(const InBuf: TArray<Byte>; const InOff: Integer; const OutBuf: TArray<Byte>; const MaxBytes: Integer): Boolean;
begin
  FDecodeByteBuf := OutBuf;
  FDecodeByteLength := Length(OutBuf);
  InitByteDecoder;
  Result := DecodeBytes(InBuf, InOff, MaxBytes);
end;

function TDBXStringDecoder.DecodeBytes(const InBuf: TArray<Byte>; const InOff: Integer; const MaxBytes: Integer): Boolean;
var
  Off: Integer;
  Complete: Boolean;
  MaxOff: Integer;
  OutOff: Integer;
  B: Byte;
begin
  Off := InOff;
  MaxOff := Off + MaxBytes;
  OutOff := FDecodeByteOff;
  ;
  if FHitChar then
    Exit(DecodeCharsToBytes(InBuf, Off, FDecodeByteBuf, OutOff, MaxOff));
  Dec(Off);
  while Incr(Off) < MaxOff do
  begin
    B := InBuf[Off];
    if (B = Ord(#$0)) and FNullTerminated then
    begin
      FDecodeByteOff := OutOff;
      Exit(True);
    end
    else if B = Byte(255) then
    begin
      FHitChar := True;
      Inc(Off);
      Complete := DecodeCharsToBytes(InBuf, Off, FDecodeByteBuf, OutOff, MaxOff);
      Exit(Complete);
    end;
    if (OutOff + 2) >= FDecodeByteLength then
      GrowDecodeByteBuf;
    FDecodeByteBuf[Incr(OutOff)] := Byte((B and 255));
    FDecodeByteBuf[Incr(OutOff)] := Byte(0);
  end;
  if (OutOff + 2) >= FDecodeByteLength then
    GrowDecodeByteBuf;
//    decodeByteBuf[++outOff] =  (byte)'\0';
//    decodeByteBuf[++outOff] =  (byte)'\0';
  FDecodeByteOff := OutOff;
  Result := True;
end;

function TDBXStringDecoder.DecodeCharsToBytes(const InBuf: TArray<Byte>; const InOff: Integer; const DecodeByteBuf: TArray<Byte>; const InOutOff: Integer; const InMaxOff: Integer): Boolean;
var
  Off: Integer;
  OutOff: Integer;
  MaxOff: Integer;
  Ch: WideChar;
begin
  Off := InOff;
  OutOff := InOutOff;
  MaxOff := InMaxOff;
  ;
  DecrAfter(Off);
  MaxOff := MaxOff - 2;
  if FHasHalfChar then
  begin
    if Incr(FDecodeByteOff) >= FDecodeByteLength then
    begin
      FDecodeByteOff := OutOff;
      Exit(False);
    end;
    if (OutOff + 2) >= FDecodeByteLength then
      GrowDecodeByteBuf;
    DecodeByteBuf[Incr(OutOff)] := Byte(FHalfChar);
    DecodeByteBuf[Incr(OutOff)] := Byte((InBuf[Incr(Off)] and 255));
    FHasHalfChar := False;
  end;
  while Off < MaxOff do
  begin
    Ch := WideChar(((Integer((InBuf[Incr(Off)] and 255))) shl 8 or (Integer(InBuf[Incr(Off)]) and 255)));
    if (Ch = #$0) and FNullTerminated then
    begin
      FDecodeByteOff := OutOff;
      Exit(True);
    end;
    if (OutOff + 2) >= FDecodeByteLength then
      GrowDecodeByteBuf;
    DecodeByteBuf[Incr(OutOff)] := Byte((Ord(Ch) and 255));
    DecodeByteBuf[Incr(OutOff)] := Byte((Ord(Ch) shr 8));
  end;
  if Off = MaxOff then
  begin
    FHalfChar := InBuf[Incr(Off)];
    FHasHalfChar := True;
  end;
  if (OutOff + 2) >= FDecodeByteLength then
    GrowDecodeByteBuf;
//    decodeByteBuf[++outOff] =  (byte)'\0';
//    decodeByteBuf[++outOff] =  (byte)'\0';
  FDecodeByteOff := OutOff;
  Result := True;
end;

function TDBXStringDecoder.ExtractDecodeByteBuffer: TArray<Byte>;
var
  RetBuffer: TArray<Byte>;
begin
  RetBuffer := FDecodeByteBuf;
  FDecodeBuf := nil;
  Result := RetBuffer;
end;

destructor TDBXStringDecoder.Destroy;
begin
  FDecodeBuf := nil;
  inherited Destroy;
end;

constructor TDBXStringEncoder.Create;
begin
  inherited Create;
  FEncodeLength := -1;
end;

procedure TDBXStringEncoder.GrowEncodeBufTo(const OldBuf: TArray<Byte>; const NewLength: Integer);
begin
  if FEncodeLength < NewLength then
  begin
    FEncodeLength := NewLength;
    SetLength(FEncodeBuf,NewLength + 2);
  end;
  if OldBuf <> nil then
    TDBXPlatform.CopyByteArray(OldBuf, FReadOff, FEncodeBuf, 0, FEncodeOff + 1 - FReadOff);
  FEncodeOff := FEncodeOff - FReadOff;
  FReadOff := 0;
end;

function TDBXStringEncoder.ExtractEncodeBuffer: TArray<Byte>;
var
  Buffer: TArray<Byte>;
begin
  ;
  ;
  FEncodeLength := -1;
  FEncodeOff := 0;
  FReadOff := 0;
  Buffer := FEncodeBuf;
  FEncodeBuf := nil;
  Result := Buffer;
end;

function TDBXStringEncoder.Encode(const Source: string; const InDest: TArray<Byte>;
  const DestOff: Integer; const InMaxBytes: Integer; const NullTerm: Boolean): Boolean;
var
  Dest: TArray<Byte>;
  Len, MaxBytes, NewSize, Off, OrgLen: Integer;
  Ch: Char;
begin
  Dest := InDest;
  MaxBytes := InMaxBytes;
  FReadOff := DestOff;
  FEncodeOff := DestOff;
  Len := Source.Length;
  OrgLen := Len;
  if Len > MaxBytes then
  begin
    GrowEncodeBufTo(nil, Len);
    Dest := FEncodeBuf;
    MaxBytes := FEncodeLength;
  end;
  Dec(FEncodeOff);
  Inc(Len);
  Off := -1;
  while Decr(Len) > 0 do
  begin
    Inc(Off);
    Ch := Source.Chars[Off];
    if Ch > Char(254) then
    begin
//vs        int newSize = (length*2) + 1 + encodeOff;
      NewSize := OrgLen + Len + 1;
      if NewSize > MaxBytes then
      begin
        GrowEncodeBufTo(Dest, NewSize);
        Dest := FEncodeBuf;
      end;
      Dest[Incr(FEncodeOff)] := Byte(255);
      Inc(Len);
      Dec(Off);
      while Decr(Len) > 0 do
      begin
        Ch := Source.Chars[Incr(Off)];
        Dest[Incr(FEncodeOff)] := Byte((Ord(Ch) shr 8));
        Dest[Incr(FEncodeOff)] := Byte((Ord(Ch) and 255));
      end;
      if NullTerm then
      begin
        Dest[Incr(FEncodeOff)] := Byte(0);
        Dest[Incr(FEncodeOff)] := Byte(0);
      end;
      Inc(FEncodeOff);
      Exit(Dest = FEncodeBuf);
    end;
    Inc(FEncodeOff);
    Dest[FEncodeOff] := Ord(Ch);
  end;
  if NullTerm then
    Dest[Incr(FEncodeOff)] := Byte(0);
  Inc(FEncodeOff);
  Result := Dest = FEncodeBuf;
end;

destructor TDBXStringEncoder.Destroy;
begin
  FEncodeBuf := nil;
  inherited Destroy;
end;

end.
