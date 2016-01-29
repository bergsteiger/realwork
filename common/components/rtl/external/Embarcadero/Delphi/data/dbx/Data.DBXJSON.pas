{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXJSON;

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses
  Data.DBXPlatform,
  System.SysUtils
;

type

  TInt15 = 0..15;

  TJSONValue = class;
  TJSONString = class;

  /// <summary> Parent class for callback methods.
  /// </summary>
  /// <remarks> A client callback needs to override the
  ///  execute method. The instance is passed as input parameter to the proxy method.
  ///
  /// </remarks>
  TDBXCallback = class abstract
  public

    /// <summary> Holds the client side callback logic.
    /// </summary>
    /// <remarks>
    ///  Function doesn't have argument ownership
    ///
    /// </remarks>
    /// <param name="Arg">- JSON value</param>
    /// <returns>JSON value</returns>
    function Execute(const Arg: TJSONValue): TJSONValue; overload; virtual; abstract;

    /// <summary> Holds the client side callback logic.
    /// </summary>
    /// <remarks>
    ///  Function doesn't have argument ownership
    ///
    /// </remarks>
    /// <param name="Arg">- Object value</param>
    /// <returns>an object instance</returns>
    function Execute(Arg: TObject): TObject; overload; virtual; abstract;

{$IFNDEF AUTOREFCOUNT}
    /// <summary> Manage reference count by increasing with one unit
    ///
    /// </summary>
    /// <returns>new count</returns>
    function AddRef: Integer; virtual;

    /// <summary> Decreases the reference count. If the count is zero (or less)
    /// </summary>
    /// <remarks> If the count is zero (or less)
    ///  the instance self-destructs.
    ///
    /// </remarks>
    /// <returns>current count</returns>
    function Release: Integer; virtual;
{$ENDIF !AUTOREFCOUNT}
  protected
    
    /// <summary> Override the method if you are using the connection handler. 
    /// </summary>
    /// <remarks> 
    ///  
    ///  The information when is provided when known.
    ///
    /// </remarks>
    /// <param name="ConnectionHandler">- connection handler as an Object</param>
    procedure SetConnectionHandler(const ConnectionHandler: TObject); virtual;
    procedure SetDsServer(const DsServer: TObject); virtual;
    
    /// <summary> Override this method if you are using the parameter ordinal (index in the
    ///  parameter list, starting with zero).
    /// </summary>
    /// <remarks> 
    ///  
    ///  The information when is provided when known.
    ///  
    /// </remarks>
    /// <param name="Ordinal">- callback parameter index </param>
    procedure SetOrdinal(const Ordinal: Integer); virtual;

    function IsConnectionLost: Boolean; virtual;
  private
{$IFNDEF AUTOREFCOUNT}
    FFRefCount: Integer;
{$ENDIF !AUTOREFCOUNT}
  public
    
    /// <summary> Override the method if you are using the connection handler. 
    /// </summary>
    /// <remarks> 
    ///  
    ///  The information when is provided when known.
    ///  
    /// </remarks>
    property ConnectionHandler: TObject write SetConnectionHandler;
    property DsServer: TObject write SetDsServer;
    
    /// <summary> Override this method if you are using the parameter ordinal (index in the
    ///  parameter list, starting with zero).
    /// </summary>
    /// <remarks> 
    ///  
    ///  The information when is provided when known.
    ///  
    /// </remarks>
    property Ordinal: Integer write SetOrdinal;

    property ConnectionLost: Boolean read IsConnectionLost;
  public
    
    /// <summary> Constant for JSON based argument remote invocation
    /// </summary>
    const ArgJson = 1;

    /// <summary> Constant for object based argument remote invocation
    /// </summary>
    const ArgObject = 2;
  end;

  
  /// <summary> Callback delegate class is used as an intermediate place holder for an 
  ///  actual instance when that is possible to be created.
  /// </summary>
  /// <remarks> 
  ///  Assumes ownership of the actual delegate.
  /// </remarks>
  TDBXCallbackDelegate = class(TDBXCallback)
  public
    
    /// <summary> Frees the delegate, if any
    /// </summary>
    destructor Destroy; override;
    
    /// <summary> see com.borland.dbx.json.DBXCallback#execute(com.borland.dbx.json.JSONValue)
    /// </summary>
    function Execute(const Arg: TJSONValue): TJSONValue; overload; override;
    
    /// <summary> see <see cref="TDBXCallback.execute(TObject)"/>
    /// </summary>
    function Execute(Arg: TObject): TObject; overload; override;
  protected
    procedure SetDelegate(const Callback: TDBXCallback); virtual;
    function GetDelegate: TDBXCallback; virtual;
    procedure SetConnectionHandler(const ConnectionHandler: TObject); override;
    procedure SetOrdinal(const Ordinal: Integer); override;
    procedure SetDsServer(const DsServer: TObject); override;
    function IsConnectionLost: Boolean; override;
  private
    FDelegate: TDBXCallback;
    [Weak]FConnectionHandler: TObject;
    [Weak]FDsServer: TObject;
    FOrdinal: Integer;
  public
    property Delegate: TDBXCallback read GetDelegate write SetDelegate;
  end;

  
  /// <summary> Extension of DBXCallback which exposes a name property, which can be used to identify the callback.
  /// </summary>
  TDBXNamedCallback = class abstract(TDBXCallback)
  public
    
    /// <summary> constructor for a named callback, which takes in the callback's name
    /// </summary>
    /// <param name="name">the name of the callback</param>
    constructor Create(const Name: string);
  protected
    
    /// <summary> Returns the name of this callback
    /// </summary>
    /// <returns>the callback's name</returns>
    function GetName: string; virtual;
  protected
    FName: string;
  public
    
    /// <summary> Returns the name of this callback
    /// </summary>
    /// <returns>the callback's name</returns>
    property Name: string read GetName;
  end;

  
  /// <summary> JSON top level class. All specific classes are descendant of it.
  /// </summary>
  /// <remarks> All specific classes are descendant of it.
  ///  
  ///  More on JSON can be found on www.json.org
  /// 
  /// </remarks>
  TJSONAncestor = class abstract
  public
    
    /// <summary> Default constructor, sets owned flag to true
    /// </summary>
    constructor Create;
    
    /// <summary> Where appropriate, returns the instance representation as String
    ///  
    /// </summary>
    /// <returns>string representation, can be null</returns>
    function Value: string; virtual;
    
    /// <summary> Returns estimated byte size of current JSON object. The actual size is smaller
    /// </summary>
    /// <remarks> The actual size is smaller
    ///  
    /// </remarks>
    /// <returns>integer - the byte size</returns>
    function EstimatedByteSize: Integer; virtual; abstract;
    
    /// <summary> Serializes the JSON object content into bytes. Returns the actual used size. It assumes the byte container has sufficient capacity to store it.
    /// </summary>
    /// <remarks> Returns the actual used size. It assumes the byte container has sufficient capacity to store it.
    ///  
    ///  It is recommended that the container capacity is given by estimatedByteSize
    ///  
    /// </remarks>
    /// <param name="data">- byte container</param>
    /// <param name="offset">- offset from which the object is serialized</param>
    /// <returns>integer - the actual size used</returns>
    function ToBytes(const Data: TArray<Byte>; const Offset: Integer): Integer; virtual; abstract;
    
    /// <summary> Perform deep clone on current value
    ///  
    /// </summary>
    /// <returns>an exact copy of current instance</returns>
    function Clone: TJSONAncestor; virtual; abstract;
    function GetOwned: Boolean; virtual;
  protected
    
    /// <summary> Returns true if the instance represent JSON null value
    ///  
    /// </summary>
    /// <returns>true if the instance represents JSON null value</returns>
    function IsNull: Boolean; virtual;
    
    /// <summary> Method used by parser to re-constitute the JSON object structure
    ///  
    /// </summary>
    /// <param name="descendent">descendant to be added</param>
    procedure AddDescendant(const Descendent: TJSONAncestor); virtual; abstract;
    procedure SetOwned(const Own: Boolean); virtual;
  private
    
    /// <summary> True if the instance is own by the container
    /// </summary>
    FOwned: Boolean;
  public
    
    /// <summary> Returns true if the instance represent JSON null value
    ///  
    /// </summary>
    /// <returns>true if the instance represents JSON null value</returns>
    property Null: Boolean read IsNull;
    property Owned: Boolean write SetOwned;
  end;

  
  /// <summary> Generalizes byte consumption of JSON parser. It accommodates UTF8, default it
  /// </summary>
  /// <remarks> It accommodates UTF8, default it
  ///  assumes the content is generated by JSON toBytes method.
  ///  
  /// </remarks>
  TJSONByteReader = class
  public
    constructor Create(const Data: TArray<Byte>; const Offset: Integer; const Range: Integer); overload;
    constructor Create(const Data: TArray<Byte>; const Offset: Integer; const Range: Integer; const IsUTF8: Boolean); overload;
    function ConsumeByte: Byte; virtual;
    function PeekByte: Byte; virtual;
    function Empty: Boolean; virtual;
    function HasMore(const Size: Integer): Boolean; virtual;
  protected
    function GetOffset: Integer; virtual;
  private
    
    /// <summary> Consumes byte-order mark if any is present in the byte data
    /// </summary>
    procedure ConsumeBOM;
    procedure MoveOffset;
  private
    FData: TArray<Byte>;
    FOffset: Integer;
    FRange: Integer;
    FIsUTF8: Boolean;
    FUtf8data: TArray<Byte>;
    FUtf8offset: Integer;
    FUtf8length: Integer;
  public
    property Offset: Integer read GetOffset;
  end;

  
  /// <summary> Signals a JSON exception, usually generated by parser code
  /// 
  /// </summary>
  TJSONException = class(Exception)
  public
    constructor Create(const ErrorMessage: string);
  private
    
    /// <summary> 
    /// </summary>
    const FSerialVersionUID = 1964987864664789863;
  end;

  
  /// <summary> Implements JSON string : value
  /// 
  /// </summary>
  TJSONPair = class sealed(TJSONAncestor)
  public
    constructor Create; overload;
    
    /// <summary> Utility constructor providing pair members
    ///
    /// </summary>
    /// <param name="str">- JSONString member, not null</param>
    /// <param name="value">- JSONValue member, never null</param>
    constructor Create(const Str: TJSONString; const Value: TJSONValue); overload;
    
    /// <summary> Convenience constructor. Parameters will be converted into JSON equivalents
    /// </summary>
    /// <remarks> Parameters will be converted into JSON equivalents
    ///
    /// </remarks>
    /// <param name="str">- string member</param>
    /// <param name="value">- JSON value</param>
    constructor Create(const Str: string; const Value: TJSONValue); overload;

    /// <summary> Convenience constructor. Parameters are converted into JSON strings pair
    /// </summary>
    /// <remarks> Parameters are converted into JSON strings pair
    ///
    /// </remarks>
    /// <param name="str">- string member</param>
    /// <param name="value">- converted into a JSON string value</param>
    constructor Create(const Str: string; const Value: string); overload;
    
    /// <summary> Frees string and value
    /// </summary>
    destructor Destroy; override;
    
    /// <summary> see com.borland.dbx.transport.JSONAncestor#estimatedByteSize()
    /// </summary>
    function EstimatedByteSize: Integer; override;
    
    /// <summary> see com.borland.dbx.transport.JSONAncestor#toBytes(byte[], int)
    /// </summary>
    function ToBytes(const Data: TArray<Byte>; const Offset: Integer): Integer; override;
    function ToString: string; override;
    function Clone: TJSONAncestor; override;
  protected

    /// <summary> see com.borland.dbx.transport.JSONAncestor#addDescendent(com.borland.dbx.transport.JSONAncestor)
    /// </summary>
    procedure AddDescendant(const Descendant: TJSONAncestor); override;
    
    /// <summary> Sets the pair's string value
    ///  
    /// </summary>
    /// <param name="descendant">string object cannot be null</param>
    procedure SetJsonString(const Descendant: TJSONString);
    
    /// <summary> Sets the pair's value member
    ///  
    /// </summary>
    /// <param name="val">string object cannot be null</param>
    procedure SetJsonValue(const Val: TJSONValue);
    
    /// <summary> Returns the pair's string.
    /// </summary>
    /// <remarks> 
    /// </remarks>
    /// <returns>JSONString - pair's string</returns>
    function GetJsonString: TJSONString;
    
    /// <summary> Returns the pair value.
    /// </summary>
    /// <remarks> 
    /// </remarks>
    /// <returns>JSONAncestor - pair's value</returns>
    function GetJsonValue: TJSONValue;
  private
    FJsonString: TJSONString;
    FJsonValue: TJSONValue;
  public
    
    /// <summary> Returns the pair's string.
    /// </summary>
    /// <remarks> 
    /// </remarks>
    /// <returns>JSONString - pair's string</returns>
    property JsonString: TJSONString read GetJsonString write SetJsonString;
    
    /// <summary> Returns the pair value.
    /// </summary>
    /// <remarks> 
    /// </remarks>
    /// <returns>JSONAncestor - pair's value</returns>
    property JsonValue: TJSONValue read GetJsonValue write SetJsonValue;
  end;

  
  /// <summary> Groups string, number, object, array, true, false, null
  /// 
  /// </summary>
  TJSONValue = class abstract(TJSONAncestor)
  end;

  
  /// <summary> Implements JSON true value
  /// 
  /// </summary>
  TJSONTrue = class sealed(TJSONValue)
  public
    
    /// <summary> see com.borland.dbx.transport.JSONAncestor#estimatedByteSize()
    /// </summary>
    function EstimatedByteSize: Integer; override;
    
    /// <summary> see com.borland.dbx.transport.JSONAncestor#toBytes(byte[], int)
    /// </summary>
    function ToBytes(const Data: TArray<Byte>; const Offset: Integer): Integer; override;
    function ToString: string; override;
    function Clone: TJSONAncestor; override;
  protected
    
    /// <summary> see com.borland.dbx.transport.JSONAncestor#addDescendent(com.borland.dbx.transport.JSONAncestor)
    /// </summary>
    procedure AddDescendant(const Descendant: TJSONAncestor); override;
  end;

  
  /// <summary> 
  /// 
  /// </summary>
  TJSONString = class(TJSONValue)
  public
    
    /// <summary> Converts 0..15 to the equivalent hex digit
    ///  
    /// </summary>
    /// <param name="digit">0 to 15 number</param>
    /// <returns>byte ASCII hex digit code</returns>
    class function Hex(const Digit: TInt15): Byte; static;

    /// <summary> Constructor for null string. No further changes are supported.
    /// </summary>
    /// <remarks> No further changes are supported. 
    /// </remarks>
    constructor Create; overload;
    
    /// <summary> Constructor for a given string
    /// </summary>
    /// <param name="value">String initial value, cannot be null</param>
    constructor Create(const Value: string); overload;
    destructor Destroy; override;
    
    /// <summary> Adds a character to current content
    ///  
    /// </summary>
    /// <param name="ch">char to be appended</param>
    procedure AddChar(const Ch: WideChar); virtual;
    
    /// <summary> see com.borland.dbx.transport.JSONAncestor#estimatedByteSize()
    /// </summary>
    function EstimatedByteSize: Integer; override;
    
    /// <summary> see com.borland.dbx.transport.JSONAncestor#toBytes(byte[], int)
    /// </summary>
    function ToBytes(const Data: TArray<Byte>; const Idx: Integer): Integer; override;
    
    /// <summary> Returns the quoted string content.
    /// </summary>
    function ToString: string; override;
    
    /// <summary> Returns the string content
    /// </summary>
    function Value: string; override;
    function Clone: TJSONAncestor; override;
  protected
    
    
    /// <seealso cref="TJSONAncestor.addDescendant(TJSONAncestor)"/>
    procedure AddDescendant(const Descendant: TJSONAncestor); override;
    
    /// <summary> see com.borland.dbx.transport.JSONAncestor#isNull()
    /// </summary>
    function IsNull: Boolean; override;
  protected
    FStrBuffer: TStringBuilder;
  end;

  TJSONNumber = class sealed(TJSONString)
  public
    constructor Create; overload;

    /// <summary> Constructor for a double number
    /// </summary>
    /// <param name="value">double to be represented as JSONNumber</param>
    constructor Create(const Value: Double); overload;

    /// <summary> Constructor for integer
    /// </summary>
    /// <param name="value">integer to be represented as JSONNumber</param>
    constructor Create(const Value: Integer); overload;

    /// <summary> Constructor for integer
    /// </summary>
    /// <param name="value">integer to be represented as JSONNumber</param>
    constructor Create(const Value: Int64); overload;

    /// <seealso cref="TJSONString.estimatedByteSize()"/>
    function EstimatedByteSize: Integer; override;
    
    /// <summary> see com.borland.dbx.transport.JSONString#toBytes(byte[], int)
    /// </summary>
    function ToBytes(const Data: TArray<Byte>; const Idx: Integer): Integer; override;
    
    /// <summary> Returns the non-localized string representation
    /// </summary>
    function ToString: string; override;
    
    /// <summary> Returns the localized representation
    /// </summary>
    function Value: string; override;
    function Clone: TJSONAncestor; override;
  protected
    /// <summary> Utility constructor with numerical argument represented as string
    ///
    /// </summary>
    /// <param name="value">- string equivalent of a number</param>
    constructor Create(const Value: string); overload;
    
    /// <summary> Returns the double representation of the number
    /// </summary>
    /// <returns>double</returns>
    function GetAsDouble: Double;
    
    /// <summary> Returns the integer part of the number
    /// </summary>
    /// <returns>int</returns>
    function GetAsInt: Integer;

    /// <summary> Returns the int64 part of the number
    /// </summary>
    /// <returns>int64</returns>
    function GetAsInt64: Int64;
  public
    
    /// <summary> Returns the double representation of the number
    /// </summary>
    /// <returns>double</returns>
    property AsDouble: Double read GetAsDouble;
    
    /// <summary> Returns the integer part of the number
    /// </summary>
    /// <returns>int</returns>
    property AsInt: Integer read GetAsInt;

    /// <summary> Returns the number as an int64
    /// </summary>
    /// <returns>int64</returns>
    property AsInt64: Int64 read GetAsInt64;
  end;

  /// <summary> Enumerator for JSON pairs 
  /// 
  /// </summary>
  TJSONPairEnumerator = class
  private
    FIndex: Integer;
    FDBXArrayList: TDBXArrayList;
  public
    constructor Create(ADBXArrayList: TDBXArrayList);
    function GetCurrent: TJSONPair; inline;
    function MoveNext: Boolean;
    property Current: TJSONPair read GetCurrent;
  end;

  /// <summary> JSON object represents {} or { members }
  /// 
  /// </summary>
  TJSONObject = class sealed(TJSONValue)
  public
    
    /// <summary> Utility function, converts a hex character into hex value [0..15]
    ///  
    /// </summary>
    /// <param name="Value">byte - hex character</param>
    /// <returns>integer - hex value</returns>
    class function HexToDecimal(const Value: Byte): Integer; static;
    
    /// <summary> Parses a byte array and returns the JSON value from it.
    /// </summary>
    /// <remarks> 
    ///  Assumes buffer has only JSON pertinent data.
    ///  
    /// </remarks>
    /// <param name="Data">- byte array, not null</param>
    /// <param name="Offset">- offset from which the parsing starts</param>
    /// <param name="IsUTF8">- true if the Data should be treated as UTF-8. Optional, defaults to true</param>
    /// <returns>JSONValue - null if the parse fails</returns>
    class function ParseJSONValue(const Data: TArray<Byte>; const Offset: Integer; IsUTF8: Boolean = True): TJSONValue; overload; static;
    
    /// <summary> Parses a byte array and returns the JSON value from it.
    /// </summary>
    /// <remarks> 
    /// </remarks>
    /// <param name="Data">- byte array, not null</param>
    /// <param name="Offset">- offset from which the parsing starts</param>
    /// <param name="count">- buffer capacity</param>
    /// <param name="IsUTF8">- true if the Data should be treated as UTF-8. Optional, defaults to true</param>
    /// <returns>JSONValue - null if the parse fails</returns>
    class function ParseJSONValue(const Data: TArray<Byte>; const Offset: Integer; const Count: Integer; IsUTF8: Boolean = True): TJSONValue; overload; static;

    /// <summary> Parses a string and returns the JSON value from it.
    /// </summary>
    /// <param name="Data">- String to parse</param>
    /// <returns>JSONValue - null if the parse fails</returns>
    class function ParseJSONValue(const Data: string): TJSONValue; overload; static;
{$IFNDEF NEXTGEN}
    class function ParseJSONValue(const Data: UTF8String): TJSONValue; overload; static;

    /// <summary> deprecated.  Use ParseJSONValue</summary>
    class function ParseJSONValueUTF8(const Data: TArray<Byte>; const Offset: Integer;
                                      const Count: Integer): TJSONValue; overload; static; deprecated 'Use ParseJSONValue';
    /// <summary> deprecated.  Use ParseJSONValue</summary>
    class function ParseJSONValueUTF8(const Data: TArray<Byte>;
                                      const Offset: Integer): TJSONValue; overload; static; deprecated 'Use ParseJSONValue';
{$ENDIF !NEXTGEN}
    
    /// <summary> Default constructor, initializes the members container
    /// </summary>
    constructor Create; overload;
    
    /// <summary> Convenience constructor - builds an object around a given pair
    /// </summary>
    /// <param name="Pair">first pair in the object definition, must not be null</param>
    constructor Create(const Pair: TJSONPair); overload;
    
    /// <summary> Returns the number of members in its content. May be zero
    /// </summary>
    /// <remarks> May be zero
    ///  
    /// </remarks>
    /// <returns>number of members in its content</returns>
    function Size: Integer;
    
    /// <summary> Returns the i-th pair or null if i is out of range
    ///   
    /// </summary>
    /// <param name="I">- pair index</param>
    /// <returns>the i-th pair or null if index is out of range</returns>
    function Get(const I: Integer): TJSONPair; overload;
    /// <summary> Returns an enumerator for pairs
    ///   
    /// </summary>
    /// <remarks> Allows JSONPairs to be accessed using a for-in loop.  
    ///  
    /// </remarks>
    /// <returns>The enumerator</returns>
    function GetEnumerator: TJSONPairEnumerator;
    /// <summary> Returns a JSON pair based on the pair string part
    ///  
    ///  The search is case sensitive and it returns the fist pair
    ///  with string part matching the argument
    ///
    /// </summary>
    /// <param name="pairName">- string: the  pair string part</param>
    /// <returns>- JSONPair : first pair encountered, null otherwise</returns>
    function Get(const PairName: string): TJSONPair; overload;
    
    /// <summary> Releases the stored members
    /// </summary>
    destructor Destroy; override;

    /// <summary> Adds a new pair
    ///  
    /// </summary>
    /// <param name="Pair">- a new pair, cannot be null</param>
    function AddPair(const Pair: TJSONPair): TJSONObject; overload;
    
    /// <summary> Convenience method for adding a pair (name, value).
    /// </summary>
    /// <remarks> 
    /// </remarks>
    /// <param name="Str">- pair name</param>
    /// <param name="Val">- pair value</param>
    function AddPair(const Str: TJSONString; const Val: TJSONValue): TJSONObject; overload;
    
    /// <summary> Convenience method for adding a pair to current object.
    /// </summary>
    /// <remarks> 
    /// </remarks>
    /// <param name="Str">- string: pair name</param>
    /// <param name="Val">- JSONValue: pair value</param>
    function AddPair(const Str: string; const Val: TJSONValue): TJSONObject; overload;
    function AddPair(const Str: string; const Val: string): TJSONObject; overload;

    function RemovePair(const PairName: string): TJSONPair;

    /// <summary> Returns the number of bytes needed to serialize this object 
    /// </summary>
    function EstimatedByteSize: Integer; override;
    
    /// <summary> see JSONAncestor#toBytes(byte[], int) 
    /// </summary>
    function ToBytes(const Data: TArray<Byte>; const Idx: Integer): Integer; override;
    function Clone: TJSONAncestor; override;
    
    /// <summary> Consumes a JSON object byte representation.
    /// </summary>
    /// <remarks> 
    ///  It is recommended to use static function parseJSONValue, unless you are familiar 
    ///  with parsing technology. It assumes the buffer has only JSON bytes.
    ///  
    /// </remarks>
    /// <param name="Data">byte[] with JSON stream</param>
    /// <param name="Pos">position within the byte array to start from, negative number if
    ///    parser fails. If negative, the absolute value is the offset where the failure happens. </param>
    /// <returns>negative number on parse error, byte buffer length on success.</returns>
    function Parse(const Data: TArray<Byte>; const Pos: Integer): Integer; overload;
    
    /// <summary> Consumes a JSON object byte representation.
    /// </summary>
    /// <remarks> 
    ///  It is recommended to use static function parseJSONValue, unless you are familiar 
    ///  with parsing technology.
    ///
    /// </remarks>
    /// <param name="Data">byte[] with JSON stream</param>
    /// <param name="Pos">position within the byte array to start from</param>
    /// <param name="Count">number of bytes</param>
    /// <returns>negative number on parse error</returns>
    function Parse(const Data: TArray<Byte>; const Pos: Integer; const Count: Integer): Integer; overload;

    procedure SetMemberList(AList: TDBXArrayList);

    function ToString: string; override;
  protected
    
    /// <summary> Adds a new member
    ///  
    /// </summary>
    /// <param name="Descendant">- JSON pair</param>
    procedure AddDescendant(const Descendant: TJSONAncestor); override;
  private
    function Parse(const Br: TJSONByteReader): Integer; overload;
    class procedure ConsumeWhitespaces(const Br: TJSONByteReader); static;
    
    /// <summary> Consumes a JSON object
    ///  
    /// </summary>
    /// <param name="Br">
    ///           raw byte data</param>
    /// <param name="Parent">
    ///           parent JSON entity</param>
    /// <returns>next offset</returns>
    class function ParseObject(const Br: TJSONByteReader; const Parent: TJSONAncestor): Integer; static;
    
    /// <summary> Consumes JSON pair string:value
    ///  
    /// </summary>
    /// <param name="Br">raw byte data</param>
    /// <param name="Parent">parent JSON entity</param>
    /// <returns>next offset</returns>
    class function ParsePair(const Br: TJSONByteReader; const Parent: TJSONObject): Integer; static;
    
    /// <summary> Consumes JSON array [...]
    ///  
    /// </summary>
    /// <param name="Br">
    ///           raw byte data</param>
    /// <param name="Parent">
    ///           parent JSON entity</param>
    /// <returns>next offset</returns>
    class function ParseArray(const Br: TJSONByteReader; const Parent: TJSONAncestor): Integer; static;
    
    /// <summary> Consumes JSON values: string, number, object, array, true, false, null
    ///  
    /// </summary>
    /// <param name="Br">raw byte data</param>
    /// <param name="Parent">parent JSON entity</param>
    /// <returns>next offset</returns>
    class function ParseValue(const Br: TJSONByteReader; const Parent: TJSONAncestor): Integer; static;
    
    /// <summary> Consumes numbers: int | int frac | int exp | int frac exp
    ///   
    /// </summary>
    /// <param name="Br">raw byte data</param>
    /// <param name="Parent">parent JSON entity</param>
    /// <returns>next offset</returns>
    class function ParseNumber(const Br: TJSONByteReader; const Parent: TJSONAncestor): Integer; static;
    
    /// <summary> Consumes a JSON string "..."
    ///  
    /// </summary>
    /// <param name="Br">raw byte data</param>
    /// <param name="Parent">parent JSON entity</param>
    /// <returns>next offset</returns>
    class function ParseString(const Br: TJSONByteReader; const Parent: TJSONAncestor): Integer; static;
  private
    FMembers: TDBXArrayList;
  end;

  
  /// <summary> Implements JSON null value
  /// 
  /// </summary>
  TJSONNull = class sealed(TJSONValue)
  public
    
    /// <summary> see com.borland.dbx.transport.JSONAncestor#estimatedByteSize()
    /// </summary>
    function EstimatedByteSize: Integer; override;
    
    /// <summary> see com.borland.dbx.transport.JSONAncestor#toBytes(byte[], int)
    /// </summary>
    function ToBytes(const Data: TArray<Byte>; const Offset: Integer): Integer; override;
    function ToString: string; override;
    function Clone: TJSONAncestor; override;
  protected
    
    /// <summary> see com.borland.dbx.transport.JSONAncestor#addDescendent(com.borland.dbx.transport.JSONAncestor)
    /// </summary>
    procedure AddDescendant(const Descendant: TJSONAncestor); override;
    
    /// <summary> see com.borland.dbx.transport.JSONAncestor#isNull()
    /// </summary>
    function IsNull: Boolean; override;
  end;

  
  /// <summary> Implements JSON false value
  /// 
  /// </summary>
  TJSONFalse = class sealed(TJSONValue)
  public
    
    /// <summary> see com.borland.dbx.transport.JSONAncestor#estimatedByteSize()
    /// </summary>
    function EstimatedByteSize: Integer; override;
    
    /// <summary> see com.borland.dbx.transport.JSONAncestor#toBytes(byte[], int)
    ///  
    /// </summary>
    function ToBytes(const Data: TArray<Byte>; const Offset: Integer): Integer; override;
    function ToString: string; override;
    function Clone: TJSONAncestor; override;
  protected
    
    /// <summary> see com.borland.dbx.transport.JSONAncestor#addDescendent(com.borland.dbx.transport.JSONAncestor)
    /// </summary>
    procedure AddDescendant(const Descendant: TJSONAncestor); override;
  end;

  TJSONArray = class;

  /// <summary> Support enumeration of values in a JSONArray.
  ///
  /// </summary>
  TJSONArrayEnumerator = class
  private
    FIndex: Integer;
    FArray: TJSONArray;
  public
    constructor Create(AArray: TJSONArray);
    function GetCurrent: TJSONValue; inline;
    function MoveNext: Boolean;
    property Current: TJSONValue read GetCurrent;
  end;

  /// <summary> Implements JSON array [] | [ elements ]
  ///
  /// </summary>
  TJSONArray = class sealed(TJSONValue)
  public
    
    /// <summary> Default constructor, initializes the container
    /// </summary>
    constructor Create; overload;
    
    /// <summary> Convenience constructor, wraps an array around a JSON value
    /// </summary>
    /// <param name="firstElem">JSON value</param>
    constructor Create(const FirstElem: TJSONValue); overload;
    
    /// <summary> Convenience constructor, wraps an array around a JSON value
    /// </summary>
    /// <param name="firstElem">JSON value</param>
    /// <param name="SecondElem">JSON value</param>
    constructor Create(const FirstElem: TJSONValue; const SecondElem: TJSONValue); overload;
    
    constructor Create(const FirstElem: string; const SecondElem: string); overload;
    /// <summary> frees the container elements
    /// </summary>
    destructor Destroy; override;
    
    /// <summary> Returns the array size
    ///   
    /// </summary>
    /// <returns>int - array size</returns>
    function Size: Integer;
    
    /// <summary> Returns the array component, null if index is out of range
    ///  
    /// </summary>
    /// <param name="index">- element index</param>
    /// <returns>JSONValue element, null if index is out of range</returns>
    function Get(const Index: Integer): TJSONValue;

    /// <summary>Removes the item at the given index, returning the removed item (or nil)</summary>
    function Remove(Index: Integer): TJSONValue;

    /// <summary> Adds a non-null value to the current element list
    ///  
    /// </summary>
    /// <param name="element">string object cannot be null</param>
    procedure AddElement(const Element: TJSONValue);
    function Add(const Element: string): TJSONArray; overload;
    function Add(const Element: Integer): TJSONArray; overload;
    function Add(const Element: Double): TJSONArray; overload;
    function Add(const Element: Boolean): TJSONArray; overload;
    function Add(const Element: TJSONObject): TJSONArray; overload;
    function Add(const Element: TJSONArray): TJSONArray; overload;

    /// <summary> see com.borland.dbx.transport.JSONAncestor#estimatedByteSize()
    /// </summary>
    function EstimatedByteSize: Integer; override;
    
    procedure SetElements(AList: TDBXArrayList);

    // / <seealso cref="TJSONAncestor.toBytes(TArray<Byte>,Integer)"/>
    function ToBytes(const Data: TArray<Byte>; const Pos: Integer): Integer; override;
    function ToString: string; override;
    function Clone: TJSONAncestor; override;
    function GetEnumerator: TJSONArrayEnumerator;
  protected

    /// <summary> see com.borland.dbx.transport.JSONAncestor#addDescendent(com.borland.dbx.transport.JSONAncestor)
    /// </summary>
    procedure AddDescendant(const Descendant: TJSONAncestor); override;

    /// <summary> Removes the first element from the element list.
    /// </summary>
    /// <remarks>
    ///  No checks are made, it is the caller responsibility to check if there is at least one element.
    ///
    /// </remarks>
    /// <returns>JSONValue</returns>
    function Pop: TJSONValue;
  private
    FElements: TDBXArrayList;
  end;

function GetUSFormat : TFormatSettings;

implementation

uses
  Data.DBXCommonResStrs, Data.DBXCommon, System.StrUtils
;

const
  HexChars = '0123456789ABCDEF';


function GetUSFormat : TFormatSettings;
begin
  Result := TFormatSettings.Create( 'en-US' );
end;

procedure TDBXCallback.SetConnectionHandler(const ConnectionHandler: TObject);
begin
end;

procedure TDBXCallback.SetDsServer(const DsServer: TObject);
begin
end;

procedure TDBXCallback.SetOrdinal(const Ordinal: Integer);
begin
end;

{$IFNDEF AUTOREFCOUNT}
function TDBXCallback.AddRef: Integer;
begin
  Inc(FFRefCount);
  Result := FFRefCount;
end;

function TDBXCallback.Release: Integer;
var
  Count: Integer;
begin
  Dec(FFRefCount);
  Count := FFRefCount;
  if Count <= 0 then
    self.Free;
  Result := Count;
end;
{$ENDIF !AUTOREFCOUNT}

function TDBXCallback.IsConnectionLost: Boolean;
begin
  Result := False;
end;

destructor TDBXCallbackDelegate.Destroy;
begin
  FreeAndNil(FDelegate);
  inherited Destroy;
end;

function TDBXCallbackDelegate.Execute(const Arg: TJSONValue): TJSONValue;
begin
  Result := FDelegate.Execute(Arg);
end;

function TDBXCallbackDelegate.Execute(Arg: TObject): TObject;
begin
  Result := FDelegate.Execute(Arg);
end;

procedure TDBXCallbackDelegate.SetDelegate(const Callback: TDBXCallback);
begin
  FDelegate := Callback;
  if FDelegate <> nil then
  begin
    FDelegate.Ordinal := FOrdinal;
    FDelegate.ConnectionHandler := FConnectionHandler;
    FDelegate.DsServer := FDsServer;
  end;
end;

function TDBXCallbackDelegate.GetDelegate: TDBXCallback;
begin
  Result := FDelegate;
end;

function TDBXCallbackDelegate.IsConnectionLost: Boolean;
begin
  if Assigned(FDelegate) then
    Exit(FDelegate.ConnectionLost);

  Exit(False);
end;

procedure TDBXCallbackDelegate.SetConnectionHandler(const ConnectionHandler: TObject);
begin
  FConnectionHandler := ConnectionHandler;
  if FDelegate <> nil then
    FDelegate.ConnectionHandler := ConnectionHandler;
end;

procedure TDBXCallbackDelegate.SetOrdinal(const Ordinal: Integer);
begin
  FOrdinal := Ordinal;
  if FDelegate <> nil then
    FDelegate.Ordinal := Ordinal;
end;

procedure TDBXCallbackDelegate.SetDsServer(const DsServer: TObject);
begin
  FDsServer := DsServer;
  if FDelegate <> nil then
    FDelegate.DsServer := DsServer;
end;

constructor TDBXNamedCallback.Create(const Name: string);
begin
  inherited Create;
  FName := Name;
end;

function TDBXNamedCallback.GetName: string;
begin
  Result := FName;
end;

constructor TJSONAncestor.Create;
begin
  inherited Create;
  FOwned := True;
end;

function TJSONAncestor.IsNull: Boolean;
begin
  Result := False;
end;

function TJSONAncestor.Value: string;
begin
  Result := NullString;
end;

procedure TJSONAncestor.SetOwned(const Own: Boolean);
begin
  FOwned := Own;
end;

function TJSONAncestor.GetOwned: Boolean;
begin
  Result := FOwned;
end;

constructor TJSONByteReader.Create(const Data: TArray<Byte>; const Offset: Integer; const Range: Integer);
begin
  inherited Create;
  FData := Data;
  FOffset := Offset;
  FRange := Range;
  ConsumeBOM;
end;

constructor TJSONByteReader.Create(const Data: TArray<Byte>; const Offset: Integer; const Range: Integer; const IsUTF8: Boolean);
begin
  inherited Create;
  FData := Data;
  FOffset := Offset;
  FRange := Range;
  FIsUTF8 := IsUTF8;
  if IsUTF8 then
    ConsumeBOM;
end;

procedure TJSONByteReader.ConsumeBOM;
begin
  if FOffset + 3 < FRange then
  begin
    if (FData[FOffset] = Byte(239)) and (FData[FOffset + 1] = Byte(187)) and (FData[FOffset + 2] = Byte(191)) then
    begin
      FIsUTF8 := True;
      FOffset := FOffset + 3;
    end;
  end;
end;

procedure TJSONByteReader.MoveOffset;
begin
  if FUtf8offset < FUtf8length then
    IncrAfter(FUtf8offset)
  else 
    IncrAfter(FOffset);
end;

function TJSONByteReader.ConsumeByte: Byte;
var
  Data: Byte;
begin
  Data := PeekByte;
  MoveOffset;
  Result := Data;
end;

function TJSONByteReader.PeekByte: Byte;
var
  Bmp: Int64;
  W1: Integer;
  W2: Integer;
begin
  if not FIsUTF8 then
    Exit(FData[FOffset]);
  if FUtf8offset < FUtf8length then
    Exit(FUtf8data[FUtf8offset]);
  if (FData[FOffset] and (Byte(128))) <> 0 then
  begin
    FUtf8offset := 0;
    if (FData[FOffset] and (Byte(224))) = Byte(192) then
    begin
      if FOffset + 1 >= FRange then
        raise TJSONException.Create(Format(SUTF8Start, [TDBXInt32Object.Create(FOffset)]));
      if (FData[FOffset + 1] and (Byte(192))) <> Byte(128) then
        raise TJSONException.Create(Format(SUTF8UnexpectedByte, [TDBXInt32Object.Create(2),TDBXInt32Object.Create(FOffset + 1)]));
      SetLength(FUtf8data,6);
      FUtf8length := 6;
      FUtf8data[0] := Ord('\');
      FUtf8data[1] := Ord('u');
      FUtf8data[2] := TJSONString.Hex(0);
      FUtf8data[3] := TJSONString.Hex((Byte((FData[FOffset] and Byte(28)))) shr 2);
      FUtf8data[4] := TJSONString.Hex((Byte((Byte(FData[FOffset]) and Byte(3))) shl 2) or (Byte((Byte((FData[FOffset + 1] and Byte(48))) shr 4))));
      FUtf8data[5] := TJSONString.Hex(FData[FOffset + 1] and Byte(15));
      FOffset := FOffset + 2;
    end
    else if (FData[FOffset] and (Byte(240))) = Byte(224) then
    begin
      if FOffset + 2 >= FRange then
        raise TJSONException.Create(Format(SUTF8Start, [TDBXInt32Object.Create(FOffset)]));
      if (FData[FOffset + 1] and (Byte(192))) <> Byte(128) then
        raise TJSONException.Create(Format(SUTF8UnexpectedByte, [TDBXInt32Object.Create(3),TDBXInt32Object.Create(FOffset + 1)]));
      if (FData[FOffset + 2] and (Byte(192))) <> Byte(128) then
        raise TJSONException.Create(Format(SUTF8UnexpectedByte, [TDBXInt32Object.Create(3),TDBXInt32Object.Create(FOffset + 2)]));
      SetLength(FUtf8data,6);
      FUtf8length := 6;
      FUtf8data[0] := Ord('\');
      FUtf8data[1] := Ord('u');
      FUtf8data[2] := TJSONString.Hex(FData[FOffset] and Byte(15));
      FUtf8data[3] := TJSONString.Hex((Byte((FData[FOffset + 1] and Byte(60)))) shr 2);
      FUtf8data[4] := TJSONString.Hex((Byte((Byte(FData[FOffset + 1]) and Byte(3))) shl 2) or (Byte((Byte((FData[FOffset + 2] and Byte(48))) shr 4))));
      FUtf8data[5] := TJSONString.Hex(FData[FOffset + 2] and Byte(15));
      FOffset := FOffset + 3;
    end
    else if (FData[FOffset] and (Byte(248))) = Byte(240) then
    begin
      if FOffset + 3 >= FRange then
        raise TJSONException.Create(Format(SUTF8Start, [TDBXInt32Object.Create(FOffset)]));
      if (FData[FOffset + 1] and (Byte(192))) <> Byte(128) then
        raise TJSONException.Create(Format(SUTF8UnexpectedByte, [TDBXInt32Object.Create(4),TDBXInt32Object.Create(FOffset + 1)]));
      if (FData[FOffset + 2] and (Byte(192))) <> Byte(128) then
        raise TJSONException.Create(Format(SUTF8UnexpectedByte, [TDBXInt32Object.Create(4),TDBXInt32Object.Create(FOffset + 2)]));
      if (FData[FOffset + 3] and (Byte(192))) <> Byte(128) then
        raise TJSONException.Create(Format(SUTF8UnexpectedByte, [TDBXInt32Object.Create(4),TDBXInt32Object.Create(FOffset + 3)]));
      Bmp := FData[FOffset] and Byte(7);
      Bmp := (Bmp shl 6) or (FData[FOffset + 1] and Byte(63));
      Bmp := (Bmp shl 6) or (FData[FOffset + 2] and Byte(63));
      Bmp := (Bmp shl 6) or (FData[FOffset + 3] and Byte(63));
      Bmp := Bmp - 65536;
      W1 := 55296;
      W1 := W1 or ((Integer((Bmp shr 10))) and 2047);
      W2 := 56320;
      W2 := W2 or Integer((Bmp and 2047));
      SetLength(FUtf8data,12);
      FUtf8length := 12;
      FUtf8data[0] := Ord('\');
      FUtf8data[1] := Ord('u');
      FUtf8data[2] := TJSONString.Hex((W1 and 61440) shr 12);
      FUtf8data[3] := TJSONString.Hex((W1 and 3840) shr 8);
      FUtf8data[4] := TJSONString.Hex((W1 and 240) shr 4);
      FUtf8data[5] := TJSONString.Hex(W1 and 15);
      FUtf8data[6] := Ord('\');
      FUtf8data[7] := Ord('u');
      FUtf8data[8] := TJSONString.Hex((W2 and 61440) shr 12);
      FUtf8data[9] := TJSONString.Hex((W2 and 3840) shr 8);
      FUtf8data[10] := TJSONString.Hex((W2 and 240) shr 4);
      FUtf8data[11] := TJSONString.Hex(W2 and 15);
      FOffset := FOffset + 4;
    end
    else 
      raise TJSONException.Create(Format(SUTF8InvalidHeaderByte, [TDBXInt32Object.Create(FOffset)]));
    Result := FUtf8data[FUtf8offset];
  end
  else 
    Result := FData[FOffset];
end;

function TJSONByteReader.Empty: Boolean;
begin
  Result := (FOffset >= FRange) and (FUtf8offset >= FUtf8length);
end;

function TJSONByteReader.GetOffset: Integer;
begin
  Result := FOffset;
end;

function TJSONByteReader.HasMore(const Size: Integer): Boolean;
begin
  if FOffset + Size < FRange then
    Result := True
  else if FUtf8offset + Size < FUtf8length then
    Result := True
  else 
    Result := False;
end;

constructor TJSONException.Create(const ErrorMessage: string);
begin
  inherited Create(ErrorMessage);
end;

constructor TJSONPair.Create;
begin
  inherited Create;
end;

constructor TJSONPair.Create(const Str: TJSONString; const Value: TJSONValue);
begin
  inherited Create;
  FJsonString := Str;
  FJsonValue := Value;
end;

constructor TJSONPair.Create(const Str: string; const Value: TJSONValue);
begin
  Create(TJSONString.Create(Str), Value);
end;

constructor TJSONPair.Create(const Str: string; const Value: string);
begin
  Create(TJSONString.Create(Str), TJSONString.Create(Value));
end;

destructor TJSONPair.Destroy;
begin
  if FJsonString <> nil then
    FreeAndNil(FJsonString);
  if (FJsonValue <> nil) and FJsonValue.GetOwned then
    FreeAndNil(FJsonValue);
  inherited Destroy;
end;

procedure TJSONPair.AddDescendant(const Descendant: TJSONAncestor);
begin
  if FJsonString = nil then
    FJsonString := TJSONString(Descendant)
  else 
    FJsonValue := TJSONValue(Descendant);
end;

procedure TJSONPair.SetJsonString(const Descendant: TJSONString);
begin
  if Descendant <> nil then
    FJsonString := Descendant;
end;

procedure TJSONPair.SetJsonValue(const Val: TJSONValue);
begin
  if Val <> nil then
    FJsonValue := Val;
end;

function TJSONPair.EstimatedByteSize: Integer;
begin
  Result := 1 + FJsonString.EstimatedByteSize + FJsonValue.EstimatedByteSize;
end;

function TJSONPair.ToBytes(const Data: TArray<Byte>; const Offset: Integer): Integer;
var
  Idx: Integer;
begin
  Idx := FJsonString.ToBytes(Data, Offset);
  Data[IncrAfter(Idx)] := Ord(':');
  Result := FJsonValue.ToBytes(Data, Idx);
end;

function TJSONPair.GetJsonString: TJSONString;
begin
  Result := FJsonString;
end;

function TJSONPair.GetJsonValue: TJSONValue;
begin
  Result := FJsonValue;
end;

function TJSONPair.ToString: string;
begin
  if (FJsonString <> nil) and (FJsonValue <> nil) then
    Result := FJsonString.ToString + ':' + FJsonValue.ToString
  else 
    Result := NullString;
end;

function TJSONPair.Clone: TJSONAncestor;
begin
  Result := TJSONPair.Create(TJSONString(FJsonString.Clone), TJSONValue(FJsonValue.Clone));
end;

procedure TJSONTrue.AddDescendant(const Descendant: TJSONAncestor);
begin
end;

function TJSONTrue.EstimatedByteSize: Integer;
begin
  Result := 4;
end;

function TJSONTrue.ToBytes(const Data: TArray<Byte>; const Offset: Integer): Integer;
var
  Idx: Integer;
begin
  Idx := Offset;
  Data[IncrAfter(Idx)] := Ord('t');
  Data[IncrAfter(Idx)] := Ord('r');
  Data[IncrAfter(Idx)] := Ord('u');
  Data[IncrAfter(Idx)] := Ord('e');
  Result := Idx;
end;

function TJSONTrue.ToString: string;
begin
  Result := 'true';
end;

function TJSONTrue.Clone: TJSONAncestor;
begin
  Result := TJSONTrue.Create;
end;

class function TJSONString.Hex(const Digit: TInt15): Byte;
begin
  Result := Byte(HexChars.Chars[Digit]);
end;

constructor TJSONString.Create;
begin
  inherited Create;
end;

constructor TJSONString.Create(const Value: string);
begin
  inherited Create;
  FStrBuffer := TStringBuilder.Create(Value);
end;

destructor TJSONString.Destroy;
begin
  FreeAndNil(FStrBuffer);
  inherited Destroy;
end;

procedure TJSONString.AddChar(const Ch: WideChar);
begin
  FStrBuffer.Append(Ch);
end;

procedure TJSONString.AddDescendant(const Descendant: TJSONAncestor);
begin
end;

function TJSONString.IsNull: Boolean;
begin
  if FStrBuffer = nil then
    Exit(True);
  Result := False;
end;

function TJSONString.EstimatedByteSize: Integer;
begin
  if Null then
    Exit(4);
  Result := 2 + 6 * FStrBuffer.Length;
end;

function TJSONString.ToBytes(const Data: TArray<Byte>; const Idx: Integer): Integer;
var
  Offset: Integer;
  Index: Integer;
  Count: Integer;
  CurrentChar: WideChar;
  UnicodeValue: Integer;
begin
  Offset := Idx;
  if Null then
  begin
    Data[IncrAfter(Offset)] := Ord('n');
    Data[IncrAfter(Offset)] := Ord('u');
    Data[IncrAfter(Offset)] := Ord('l');
    Data[IncrAfter(Offset)] := Ord('l');
  end
  else 
  begin
    Data[IncrAfter(Offset)] := Ord('"');
    Index := 0;
    Count := FStrBuffer.Length;
    while Index < Count do
    begin
      CurrentChar := FStrBuffer.Chars[IncrAfter(Index)];
      case CurrentChar of
        '"':
          begin
            Data[IncrAfter(Offset)] := Ord('\');
            Data[IncrAfter(Offset)] := Ord('"');
          end;
        '\':
          begin
            Data[IncrAfter(Offset)] := Ord('\');
            Data[IncrAfter(Offset)] := Ord('\');
          end;
        '/':
          begin
            Data[IncrAfter(Offset)] := Ord('\');
            Data[IncrAfter(Offset)] := Ord('/');
          end;
        #$8:
          begin
            Data[IncrAfter(Offset)] := Ord('\');
            Data[IncrAfter(Offset)] := Ord('b');
          end;
        #$c:
          begin
            Data[IncrAfter(Offset)] := Ord('\');
            Data[IncrAfter(Offset)] := Ord('f');
          end;
        #$a:
          begin
            Data[IncrAfter(Offset)] := Ord('\');
            Data[IncrAfter(Offset)] := Ord('n');
          end;
        #$d:
          begin
            Data[IncrAfter(Offset)] := Ord('\');
            Data[IncrAfter(Offset)] := Ord('r');
          end;
        #$9:
          begin
            Data[IncrAfter(Offset)] := Ord('\');
            Data[IncrAfter(Offset)] := Ord('t');
          end;
        else
          if (CurrentChar < WideChar(32)) or (CurrentChar > WideChar(127)) then
          begin
            Data[IncrAfter(Offset)] := Ord('\');
            Data[IncrAfter(Offset)] := Ord('u');
            UnicodeValue := Ord(CurrentChar);
            Data[IncrAfter(Offset)] := Hex((UnicodeValue and 61440) shr 12);
            Data[IncrAfter(Offset)] := Hex((UnicodeValue and 3840) shr 8);
            Data[IncrAfter(Offset)] := Hex((UnicodeValue and 240) shr 4);
            Data[IncrAfter(Offset)] := Hex((UnicodeValue and 15));
          end
          else 
            Data[IncrAfter(Offset)] := Ord(CurrentChar);
      end;
    end;
    Data[IncrAfter(Offset)] := Ord('"');
  end;
  Result := Offset;
end;

function TJSONString.ToString: string;
begin
  if FStrBuffer <> nil then
    Exit('"' + AnsiReplaceStr(FStrBuffer.ToString, '"', '\"') + '"');
  Result := NullString;
end;

function TJSONString.Value: string;
begin
  if FStrBuffer = nil then
    Result := NullString
  else 
    Result := FStrBuffer.ToString;
end;

function TJSONString.Clone: TJSONAncestor;
begin
  if FStrBuffer = nil then
    Result := TJSONString.Create
  else
    Result := TJSONString.Create(Value);
end;

constructor TJSONNumber.Create;
begin
  inherited Create('');
end;

constructor TJSONNumber.Create(const Value: Double);
begin
  inherited Create(TDBXPlatform.JsonFloat(Value));
end;

constructor TJSONNumber.Create(const Value: string);
begin
  inherited Create(Value);
end;

constructor TJSONNumber.Create(const Value: Int64);
begin
  inherited Create(IntToStr(Value));
end;

constructor TJSONNumber.Create(const Value: Integer);
begin
  inherited Create(IntToStr(Value));
end;

function TJSONNumber.EstimatedByteSize: Integer;
begin
  Result := FStrBuffer.Length;
end;

function TJSONNumber.ToBytes(const Data: TArray<Byte>; const Idx: Integer): Integer;
var
  Offset: Integer;
  Index: Integer;
  Count: Integer;
  CurrentChar: WideChar;
begin
  Offset := Idx;
  Index := 0;
  Count := FStrBuffer.Length;
  while Index < Count do
  begin
    CurrentChar := FStrBuffer.Chars[IncrAfter(Index)];
    Data[IncrAfter(Offset)] := Ord(CurrentChar);
  end;
  Result := Offset;
end;

function TJSONNumber.ToString: string;
begin
  Result := FStrBuffer.ToString;
end;

function TJSONNumber.Value: string;
var
  BuffStr: string;
begin
  BuffStr := FStrBuffer.ToString;
  if (FStrBuffer.Length > 11) and (AnsiPos('.', BuffStr) = 0) then
    Result := IntToStr(GetAsInt64)
  else
    Result := FloatToStr(TDBXPlatform.JsonToFloat(BuffStr));
end;

function TJSONNumber.Clone: TJSONAncestor;
begin
  Result := TJSONNumber.Create(ToString);
end;

function TJSONNumber.GetAsDouble: Double;
begin
  Result := TDBXPlatform.JsonToFloat(FStrBuffer.ToString);
end;

function TJSONNumber.GetAsInt: Integer;
begin
  Result := StrToInt(FStrBuffer.ToString);
end;

function TJSONNumber.GetAsInt64: Int64;
begin
  Result := StrToInt64(FStrBuffer.ToString);
end;

class function TJSONObject.HexToDecimal(const Value: Byte): Integer;
begin
  if Value > Ord('9') then
  begin
    if Value > Ord('F') then
      Exit(Value - Ord('a') + 10)
    else
      Exit(Value - Ord('A') + 10);
  end;

  Result := Value - Ord('0');
end;

class function TJSONObject.ParseJSONValue(const Data: TArray<Byte>; const Offset: Integer; IsUTF8: Boolean): TJSONValue;
begin
  Result := ParseJSONValue(Data, Offset, Length(Data), IsUTF8);
end;

class function TJSONObject.ParseJSONValue(const Data: TArray<Byte>; const Offset: Integer;
                                          const Count: Integer; IsUTF8: Boolean): TJSONValue;
var
  Parent: TJSONArray;
  Answer: TJSONValue;
  Br: TJSONByteReader;
begin
  Parent := TJSONArray.Create;
  Answer := nil;
  Br := TJSONByteReader.Create(Data, Offset, Count, IsUTF8);
  try
    ConsumeWhitespaces(Br);
    if (ParseValue(Br, Parent) = Count) and (Parent.Size = 1) then
      Answer := Parent.Pop;
    Result := Answer;
  finally
    Parent.Free;
    Br.Free;
  end;
end;

class function TJSONObject.ParseJSONValue(const Data: string): TJSONValue;
begin
  Result := ParseJSONValue(TEncoding.UTF8.GetBytes(Data), 0, True);
end;

{$IFNDEF NEXTGEN}
class function TJSONObject.ParseJSONValue(const Data: UTF8String): TJSONValue;
begin
  Result := ParseJSONValue(BytesOf(Data), 0, True);
end;

class function TJSONObject.ParseJSONValueUTF8(const Data: TArray<Byte>; const Offset: Integer; const Count: Integer): TJSONValue;
begin
  Result := ParseJSONValue(Data, Offset, Count, True);
end;

class function TJSONObject.ParseJSONValueUTF8(const Data: TArray<Byte>; const Offset: Integer): TJSONValue;
begin
  Result := ParseJSONValueUTF8(Data, Offset, Length(Data));
end;
{$ENDIF !NEXTGEN}

constructor TJSONObject.Create;
begin
  inherited Create;
  FMembers := TDBXArrayList.Create;
end;

constructor TJSONObject.Create(const Pair: TJSONPair);
begin
  Create;
  if Pair <> nil then
    FMembers.Add(Pair);
end;

procedure TJSONObject.SetMemberList(AList: TDBXArrayList);
begin
  FMembers.Free;
  FMembers := AList;
end;

function TJSONObject.Size: Integer;
begin
  Result := FMembers.Count;
end;

function TJSONObject.Get(const I: Integer): TJSONPair;
begin
//{$IFDEF DEVELOPERS}
//  // JSONObjects are unordered pairs, so do not depend on the index
//  // of a pair.  Here we allow index to be used only in a special case.
//  Assert((I = 0) and (Size <= 1));
//{$ENDIF}
  if (I >= 0) and (I < Size) then
    Result := TJSONPair(FMembers[I])
  else 
    Result := nil;
end;

function TJSONObject.Get(const PairName: string): TJSONPair;
var
  Candidate: TJSONPair;
  I: Integer;
begin
  for i := 0 to Size - 1 do
  begin
    Candidate := TJSONPair(FMembers[I]);
    if (Candidate.JsonString.Value = PairName) then
      Exit(Candidate);
  end;
  Result := nil;
end;

function TJSONObject.GetEnumerator: TJSONPairEnumerator;
begin
  Result := TJSONPairEnumerator.Create(FMembers);
end;

destructor TJSONObject.Destroy;
var
  Member: TJSONAncestor;
  I: Integer;
begin
  if FMembers <> nil then
  begin
    for i := 0 to FMembers.Count - 1 do
    begin
      Member := TJSONAncestor(FMembers[I]);
      if Member.GetOwned then
        Member.Free;
    end;
    FreeAndNil(FMembers);
  end;
  inherited Destroy;
end;

function TJSONObject.AddPair(const Pair: TJSONPair): TJSONObject;
begin
  if Pair <> nil then
    AddDescendant(Pair);
  Result := Self;
end;

function TJSONObject.AddPair(const Str: TJSONString; const Val: TJSONValue): TJSONObject;
begin
  if (Str <> nil) and (Val <> nil) then
    AddPair(TJSONPair.Create(Str, Val));
  Result := Self;
end;

function TJSONObject.AddPair(const Str: string; const Val: TJSONValue): TJSONObject;
begin
  if (not Str.IsEmpty) and (Val <> nil) then
    AddPair(TJSONPair.Create(Str, Val));
  Result := Self;
end;

function TJSONObject.AddPair(const Str: string; const Val: string): TJSONObject;
begin
  if (not Str.IsEmpty) and (not Val.IsEmpty) then
    AddPair(TJSONPair.Create(Str, Val));
  Result := Self;
end;

procedure TJSONObject.AddDescendant(const Descendant: TJSONAncestor);
begin
  FMembers.Add(Descendant);
end;

function TJSONObject.EstimatedByteSize: Integer;
var
  Size: Integer;
  I: Integer;
begin
  Size := 1;
  for i := 0 to FMembers.Count - 1 do
    Size := Size + (TJSONAncestor(FMembers[I])).EstimatedByteSize + 1;
  if Size = 1 then
    Exit(2);
  Result := Size;
end;

function TJSONObject.ToBytes(const Data: TArray<Byte>; const Idx: Integer): Integer;
var
  Offset: Integer;
  Size: Integer;
  I: Integer;
begin
  Offset := Idx;
  Size := FMembers.Count;
  Data[IncrAfter(Offset)] := Ord('{');
  if Size > 0 then
    Offset := (TJSONAncestor(FMembers[0])).ToBytes(Data, Offset);
  for i := 1 to FMembers.Count - 1 do
  begin
    Data[IncrAfter(Offset)] := Ord(',');
    Offset := (TJSONAncestor(FMembers[I])).ToBytes(Data, Offset);
  end;
  Data[IncrAfter(Offset)] := Ord('}');
  Result := Offset;
end;

function TJSONObject.Clone: TJSONAncestor;
var
  Data: TJSONObject;
  I: Integer;
begin
  Data := TJSONObject.Create;
  for I := 0 to FMembers.Count - 1 do
    Data.AddPair(TJSONPair(Get(I).Clone));
  Result := Data;
end;

function TJSONObject.Parse(const Data: TArray<Byte>; const Pos: Integer): Integer;
var
  Offset: Integer;
  Count: Integer;
begin
  Count := Length(Data);
  Offset := Parse(Data, Pos, Count);
  if Offset = Count then
    Result := Count
  else if Offset < 0 then
    Result := Offset
  else 
    Result := -Offset;
end;

function TJSONObject.Parse(const Data: TArray<Byte>; const Pos: Integer; const Count: Integer): Integer;
var
  Br: TJSONByteReader;
begin
  if (Data = nil) or (Pos < 0) or (Pos >= Count) then
    Exit(-1);
  Br := TJSONByteReader.Create(Data, Pos, Count);
  try
    Result := Parse(Br);
  finally
    Br.Free;
  end;
end;

function TJSONObject.Parse(const Br: TJSONByteReader): Integer;
var
  SepPos: Integer;
  PairExpected: Boolean;
begin
  ConsumeWhitespaces(Br);
  if Br.Empty then
    Exit(-Br.Offset);
  if Br.PeekByte <> Ord('{') then
    Exit(-Br.Offset);
  Br.ConsumeByte;
  ConsumeWhitespaces(Br);
  if Br.Empty then
    Exit(-Br.Offset);
  PairExpected := False;
  while PairExpected or (Br.PeekByte <> Ord('}')) do
  begin
    SepPos := ParsePair(Br, self);
    if SepPos <= 0 then
      Exit(SepPos);
    ConsumeWhitespaces(Br);
    if Br.Empty then
      Exit(-Br.Offset);
    PairExpected := False;
    if Br.PeekByte = Ord(',') then
    begin
      Br.ConsumeByte;
      ConsumeWhitespaces(Br);
      PairExpected := True;
      if Br.PeekByte = Ord('}') then
        Exit(-Br.Offset);
    end;
  end;
  Br.ConsumeByte;
  ConsumeWhitespaces(Br);
  Result := Br.Offset;
end;

class procedure TJSONObject.ConsumeWhitespaces(const Br: TJSONByteReader);
var
  Current: Byte;
begin
  while not Br.Empty do
  begin
    Current := Br.PeekByte;
    case Current of
      32,
      9,
      10,
      13:
        Br.ConsumeByte;
      else
        Exit;
    end;
  end;
end;

class function TJSONObject.ParseObject(const Br: TJSONByteReader; const Parent: TJSONAncestor): Integer;
var
  JsonObj: TJSONObject;
begin
  JsonObj := TJSONObject.Create;
  Parent.AddDescendant(JsonObj);
  Result := JsonObj.Parse(Br);
end;

class function TJSONObject.ParsePair(const Br: TJSONByteReader; const Parent: TJSONObject): Integer;
var
  Pair: TJSONPair;
  CommaPos: Integer;
begin
  Pair := TJSONPair.Create;
  Parent.AddDescendant(Pair);
  CommaPos := ParseString(Br, Pair);
  if CommaPos > 0 then
  begin
    ConsumeWhitespaces(Br);
    if Br.Empty then
      Exit(-Br.Offset);
    if Br.PeekByte <> Ord(':') then
      Exit(-Br.Offset);
    Br.ConsumeByte;
    ConsumeWhitespaces(Br);
    CommaPos := ParseValue(Br, Pair);
  end;
  Result := CommaPos;
end;

class function TJSONObject.ParseArray(const Br: TJSONByteReader; const Parent: TJSONAncestor): Integer;
var
  ValueExpected: Boolean;
  JsonArray: TJSONArray;
  Pos: Integer;
begin
  ConsumeWhitespaces(Br);
  if Br.Empty then
    Exit(-Br.Offset);
  if Br.PeekByte <> Ord('[') then
    Exit(-Br.Offset);
  Br.ConsumeByte;
  JsonArray := TJSONArray.Create;
  Parent.AddDescendant(JsonArray);
  ValueExpected := False;
  while ValueExpected or (Br.PeekByte <> Ord(']')) do
  begin
    ConsumeWhitespaces(Br);
    Pos := ParseValue(Br, JsonArray);
    if Pos <= 0 then
      Exit(Pos);
    ConsumeWhitespaces(Br);
    if Br.Empty then
      Exit(-Br.Offset);
    ValueExpected := False;
    if Br.PeekByte = Ord(',') then
    begin
      Br.ConsumeByte;
      ValueExpected := True;
    end
    else if Br.PeekByte <> Ord(']') then
      Exit(-Br.Offset);
  end;
  Br.ConsumeByte;
  ConsumeWhitespaces(Br);
  Result := Br.Offset;
end;

class function TJSONObject.ParseValue(const Br: TJSONByteReader; const Parent: TJSONAncestor): Integer;
var
  Pos: Integer;
begin
  Pos := Br.Offset;
  if Br.Empty then
    Exit(-Pos);
  case Br.PeekByte of
    Ord('"'):
      Exit(ParseString(Br, Parent));
    Ord('-'),
    Ord('0'),
    Ord('1'),
    Ord('2'),
    Ord('3'),
    Ord('4'),
    Ord('5'),
    Ord('6'),
    Ord('7'),
    Ord('8'),
    Ord('9'):
      Exit(ParseNumber(Br, Parent));
    Ord('{'):
      Exit(ParseObject(Br, Parent));
    Ord('['):
      Exit(ParseArray(Br, Parent));
    Ord('t'):
      begin
        if not Br.HasMore(3) then
          Exit(-Pos);
        Br.ConsumeByte;
        if (Br.ConsumeByte <> Ord('r')) or (Br.ConsumeByte <> Ord('u')) or (Br.ConsumeByte <> Ord('e')) then
          Exit(-Pos);
        Parent.AddDescendant(TJSONTrue.Create);
        Exit(Br.Offset);
      end;
    Ord('f'):
      begin
        if not Br.HasMore(4) then
          Exit(-Pos);
        Br.ConsumeByte;
        if (Br.ConsumeByte <> Ord('a')) or (Br.ConsumeByte <> Ord('l')) or (Br.ConsumeByte <> Ord('s')) or (Br.ConsumeByte <> Ord('e')) then
          Exit(-Pos);
        Parent.AddDescendant(TJSONFalse.Create);
        Exit(Br.Offset);
      end;
    Ord('n'):
      begin
        if not Br.HasMore(3) then
          Exit(-Pos);
        Br.ConsumeByte;
        if (Br.ConsumeByte <> Ord('u')) or (Br.ConsumeByte <> Ord('l')) or (Br.ConsumeByte <> Ord('l')) then
          Exit(-Pos);
        Parent.AddDescendant(TJSONNull.Create);
        Exit(Br.Offset);
      end;
  end;
  Result := -Pos;
end;

function TJSONObject.RemovePair(const PairName: string): TJSONPair;
var
  Candidate: TJSONPair;
  I: Integer;
begin
  for I := 0 to Size - 1 do
  begin
    Candidate := TJSONPair(FMembers[I]);
    if (Candidate.JsonString.Value = PairName) then
    begin
      FMembers.RemoveAt(i);
      Exit(Candidate);
    end;
  end;
  Result := nil;
end;

class function TJSONObject.ParseNumber(const Br: TJSONByteReader; const Parent: TJSONAncestor): Integer;
var
  Nb: TJSONNumber;
  Consume: Boolean;
  Exponent: Boolean;
  OneAdded: Boolean;
begin
  Nb := TJSONNumber.Create;
  Parent.AddDescendant(Nb);
  if Br.PeekByte = Ord('-') then
  begin
    Nb.AddChar('-');
    Br.ConsumeByte;
    if Br.Empty then
      Exit(-1);
  end;
  if Br.PeekByte = Ord('0') then
  begin
    Nb.AddChar('0');
    Br.ConsumeByte;
    if Br.Empty then
      Exit(Br.Offset);
    case Br.PeekByte of
      Ord('0'),
      Ord('1'),
      Ord('2'),
      Ord('3'),
      Ord('4'),
      Ord('5'),
      Ord('6'),
      Ord('7'),
      Ord('8'),
      Ord('9'):
        Exit(-Br.Offset);
    end;
  end;
  Consume := True;
  while Consume do
    case Br.PeekByte of
      Ord('0'),
      Ord('1'),
      Ord('2'),
      Ord('3'),
      Ord('4'),
      Ord('5'),
      Ord('6'),
      Ord('7'),
      Ord('8'),
      Ord('9'):
        begin
          Nb.AddChar(WideChar(Br.ConsumeByte));
          if Br.Empty then
            Exit(Br.Offset);
        end;
      else
        Consume := False;
    end;
  Exponent := False;
  if Br.PeekByte = Ord('.') then
  begin
    Nb.AddChar('.');
    Br.ConsumeByte;
    if Br.Empty then
      Exit(-Br.Offset);
  end
  else if (Br.PeekByte = Ord('e')) or (Br.PeekByte = Ord('E')) then
  begin
    Nb.AddChar(WideChar(Br.ConsumeByte));
    Exponent := True;
    if Br.Empty then
      Exit(-Br.Offset);
    if (Br.PeekByte = Ord('-')) or (Br.PeekByte = Ord('+')) then
    begin
      Nb.AddChar(WideChar(Br.ConsumeByte));
      if Br.Empty then
        Exit(-Br.Offset);
    end;
  end
  else 
    Exit(Br.Offset);
  OneAdded := False;
  Consume := True;
  while Consume do
    case Br.PeekByte of
      Ord('0'),
      Ord('1'),
      Ord('2'),
      Ord('3'),
      Ord('4'),
      Ord('5'),
      Ord('6'),
      Ord('7'),
      Ord('8'),
      Ord('9'):
        begin
          Nb.AddChar(WideChar(Br.ConsumeByte));
          OneAdded := True;
          if Br.Empty then
            Exit(Br.Offset);
        end;
      else
        Consume := False;
    end;
  if not OneAdded then
    Exit(-Br.Offset);
  if not Exponent and ((Br.PeekByte = Ord('e')) or (Br.PeekByte = Ord('E'))) then
  begin
    Nb.AddChar(WideChar(Br.ConsumeByte));
    if Br.Empty then
      Exit(-Br.Offset);
    if (Br.PeekByte = Ord('-')) or (Br.PeekByte = Ord('+')) then
    begin
      Nb.AddChar(WideChar(Br.ConsumeByte));
      if Br.Empty then
        Exit(-Br.Offset);
    end;
    OneAdded := False;
    Consume := True;
    while Consume do
      case Br.PeekByte of
        Ord('0'),
        Ord('1'),
        Ord('2'),
        Ord('3'),
        Ord('4'),
        Ord('5'),
        Ord('6'),
        Ord('7'),
        Ord('8'),
        Ord('9'):
          begin
            Nb.AddChar(WideChar(Br.ConsumeByte));
            OneAdded := True;
            if Br.Empty then
              Exit(Br.Offset);
          end;
        else
          Consume := False;
      end;
    if not OneAdded then
      Exit(-Br.Offset);
  end;
  Result := Br.Offset;
end;

class function TJSONObject.ParseString(const Br: TJSONByteReader; const Parent: TJSONAncestor): Integer;
var
  UnicodeCh: Integer;
  Ch: WideChar;
  Str: TJSONString;
begin
  Ch := ' ';
  if Br.PeekByte <> Ord('"') then
    Exit(-Br.Offset);
  Br.ConsumeByte;
  if Br.Empty then
    Exit(-Br.Offset);
  Str := TJSONString.Create('');
  Parent.AddDescendant(Str);
  while Br.PeekByte <> Ord('"') do
  begin
    case Br.PeekByte of
      Ord('\'):
        begin
          Br.ConsumeByte;
          if Br.Empty then
            Exit(-Br.Offset);
          case Br.PeekByte of
            Ord('"'):
              Ch := '"';
            Ord('\'):
              Ch := '\';
            Ord('/'):
              Ch := '/';
            Ord('b'):
              Ch := #$8;
            Ord('f'):
              Ch := #$c;
            Ord('n'):
              Ch := #$a;
            Ord('r'):
              Ch := #$d;
            Ord('t'):
              Ch := #$9;
            Ord('u'):
              begin
                Br.ConsumeByte;
                if not Br.HasMore(3) then
                  Exit(-Br.Offset);
                UnicodeCh := HexToDecimal(Br.ConsumeByte) shl 12;
                UnicodeCh := UnicodeCh or HexToDecimal(Br.ConsumeByte) shl 8;
                UnicodeCh := UnicodeCh or HexToDecimal(Br.ConsumeByte) shl 4;
                UnicodeCh := UnicodeCh or HexToDecimal(Br.PeekByte);
                Ch := WideChar(UnicodeCh);
              end;
            else
              Exit(-Br.Offset);
          end;
        end;
      else
        Ch := WideChar(Br.PeekByte);
    end;
    Str.AddChar(Ch);
    Br.ConsumeByte;
    if Br.Empty then
      Exit(-Br.Offset);
  end;
  Br.ConsumeByte;
  Result := Br.Offset;
end;

function TJSONObject.ToString: string;
var
  Buf: TStringBuilder;
  Size: Integer;
  I: Integer;
begin
  Size := FMembers.Count;
  Buf := TStringBuilder.Create;
  try
    Buf.Append('{');
    if Size > 0 then
      Buf.Append(FMembers[0].ToString);
    for I := 1 to Size - 1 do
    begin
      Buf.Append(',');
      Buf.Append(FMembers[I].ToString);
    end;
    Buf.Append('}');
    Result := Buf.ToString;
  finally
    Buf.Free;
  end;
end;

procedure TJSONNull.AddDescendant(const Descendant: TJSONAncestor);
begin
end;

function TJSONNull.IsNull: Boolean;
begin
  Result := True;
end;

function TJSONNull.EstimatedByteSize: Integer;
begin
  Result := 4;
end;

function TJSONNull.ToBytes(const Data: TArray<Byte>; const Offset: Integer): Integer;
var
  Idx: Integer;
begin
  Idx := Offset;
  Data[IncrAfter(Idx)] := Ord('n');
  Data[IncrAfter(Idx)] := Ord('u');
  Data[IncrAfter(Idx)] := Ord('l');
  Data[IncrAfter(Idx)] := Ord('l');
  Result := Idx;
end;

function TJSONNull.ToString: string;
begin
  Result := 'null';
end;

function TJSONNull.Clone: TJSONAncestor;
begin
  Result := TJSONNull.Create;
end;

procedure TJSONFalse.AddDescendant(const Descendant: TJSONAncestor);
begin
end;

function TJSONFalse.EstimatedByteSize: Integer;
begin
  Result := 5;
end;

function TJSONFalse.ToBytes(const Data: TArray<Byte>; const Offset: Integer): Integer;
var
  Idx: Integer;
begin
  Idx := Offset;
  Data[IncrAfter(Idx)] := Ord('f');
  Data[IncrAfter(Idx)] := Ord('a');
  Data[IncrAfter(Idx)] := Ord('l');
  Data[IncrAfter(Idx)] := Ord('s');
  Data[IncrAfter(Idx)] := Ord('e');
  Result := Idx;
end;

function TJSONFalse.ToString: string;
begin
  Result := 'false';
end;

function TJSONFalse.Clone: TJSONAncestor;
begin
  Result := TJSONFalse.Create;
end;

constructor TJSONArray.Create;
begin
  inherited Create;
  FElements := TDBXArrayList.Create;
end;

constructor TJSONArray.Create(const FirstElem: TJSONValue);
begin
  Create;
  AddElement(FirstElem);
end;

constructor TJSONArray.Create(const FirstElem: TJSONValue; const SecondElem: TJSONValue);
begin
  Create;
  AddElement(FirstElem);
  AddElement(SecondElem);
end;

constructor TJSONArray.Create(const FirstElem: string; const SecondElem: string);
begin
  Create;
  AddElement(TJSONString.Create(FirstElem));
  AddElement(TJSONString.Create(SecondElem));
end;

destructor TJSONArray.Destroy;
var
  Element: TJSONAncestor;
  I: Integer;
begin
  if FElements <> nil then
  begin
    for I := 0 to FElements.Count - 1 do
    begin
      Element := TJSONAncestor(FElements[I]);
      if Element.GetOwned then
        Element.Free;
    end;
    FreeAndNil(FElements);
  end;
  inherited Destroy;
end;

procedure TJSONArray.SetElements(AList: TDBXArrayList);
begin
  FElements.Free;
  FElements := AList;
end;

function TJSONArray.Size: Integer;
begin
  if (FElements = nil) or (FElements.Count = 0) then
    Exit(0);
  Result := FElements.Count;
end;

function TJSONArray.Get(const Index: Integer): TJSONValue;
begin
  if (Index < 0) or (Index >= Size) then
    Exit(nil);
  Result := TJSONValue(FElements[Index]);
end;

procedure TJSONArray.AddDescendant(const Descendant: TJSONAncestor);
begin
  FElements.Add(Descendant);
end;

function TJSONArray.Pop: TJSONValue;
var
  Value: TJSONValue;
begin
  Value := TJSONValue(FElements[0]);
  FElements.RemoveAt(0);
  Result := Value;
end;

function TJSONArray.Remove(Index: Integer): TJSONValue;
begin
  Result := Get(Index);
  if (Index >= 0) and (Index < Size) then
    FElements.RemoveAt(Index);
end;

procedure TJSONArray.AddElement(const Element: TJSONValue);
begin
  if Element <> nil then
    AddDescendant(Element);
end;

function TJSONArray.Add(const Element: string): TJSONArray;
begin
  AddElement(TJSONString.Create(Element));
  Result := self;
end;

function TJSONArray.Add(const Element: Integer): TJSONArray;
begin
  AddElement(TJSONNumber.Create(Element));
  Result := self;
end;

function TJSONArray.Add(const Element: Double): TJSONArray;
begin
  AddElement(TJSONNumber.Create(Element));
  Result := self;
end;

function TJSONArray.Add(const Element: Boolean): TJSONArray;
begin
  if Element then
    AddElement(TJSONTrue.Create)
  else 
    AddElement(TJSONFalse.Create);
  Result := self;
end;

function TJSONArray.Add(const Element: TJSONObject): TJSONArray;
begin
  if Element <> nil then
    AddElement(Element)
  else 
    AddElement(TJSONNull.Create);
  Result := self;
end;

function TJSONArray.Add(const Element: TJSONArray): TJSONArray;
begin
  AddElement(Element);
  Result := self;
end;

function TJSONArray.EstimatedByteSize: Integer;
var
  Size: Integer;
  I: Integer;
begin
  Size := 1;
  for I := 0 to FElements.Count - 1 do
    Size := Size + (TJSONAncestor(FElements[I])).EstimatedByteSize + 1;
  if Size = 1 then
    Exit(2);
  Result := Size;
end;

function TJSONArray.ToBytes(const Data: TArray<Byte>; const Pos: Integer): Integer;
var
  Offset: Integer;
  Size: Integer;
  I: Integer;
begin
  Offset := Pos;
  Size := FElements.Count;
  Data[IncrAfter(Offset)] := Ord('[');
  if Size > 0 then
    Offset := (TJSONAncestor(FElements[0])).ToBytes(Data, Offset);
  for I := 1 to Size - 1 do
  begin
    Data[IncrAfter(Offset)] := Ord(',');
    Offset := (TJSONAncestor(FElements[I])).ToBytes(Data, Offset);
  end;
  Data[IncrAfter(Offset)] := Ord(']');
  Result := Offset;
end;

function TJSONArray.ToString: string;
var
  Buf: TStringBuilder;
  Size: Integer;
  I: Integer;
begin
  Size := FElements.Count;
  Buf := TStringBuilder.Create;
  try
    Buf.Append('[');
    if Size > 0 then
      Buf.Append(FElements[0].ToString);
    for I := 1 to Size - 1 do
    begin
      Buf.Append(',');
      Buf.Append(FElements[I].ToString);
    end;
    Buf.Append(']');
    Result := Buf.ToString;
  finally
    Buf.Free;
  end;
end;

function TJSONArray.Clone: TJSONAncestor;
var
  Data: TJSONArray;
  I: Integer;
begin
  Data := TJSONArray.Create;
  for I := 0 to Size - 1 do
    Data.AddDescendant(Get(I).Clone);
  Result := Data;
end;

function TJSONArray.GetEnumerator: TJSONArrayEnumerator;
begin
  Result := TJSONArrayEnumerator.Create(Self);
end;

{ TDBXArrayListEnumerator }

constructor TJSONPairEnumerator.Create(ADBXArrayList: TDBXArrayList);
begin
  inherited Create;
  FIndex := -1;
  FDBXArrayList := ADBXArrayList;
end;

function TJSONPairEnumerator.GetCurrent: TJSONPair;
begin
  Result := TJSONPair(FDBXArrayList[FIndex]);
end;

function TJSONPairEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FDBXArrayList.Count - 1;
  if Result then
    Inc(FIndex);
end;

{ TJSONArrayEnumerator }

constructor TJSONArrayEnumerator.Create(AArray: TJSONArray);
begin
  inherited Create;
  FIndex := -1;
  FArray := AArray;
end;

function TJSONArrayEnumerator.GetCurrent: TJSONValue;
begin
  Result := FArray.Get(FIndex);
end;

function TJSONArrayEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FArray.Size - 1;
  if Result then
    Inc(FIndex);
end;


end.


