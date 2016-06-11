{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.JSON.Builders;

interface

{$SCOPEDENUMS ON}

uses
  System.JSON, System.SysUtils, System.JSON.Writers, System.Classes,
  System.Generics.Collections, System.Rtti, System.JSON.Types,
  System.JSON.Readers;

type
  /// <summary>Wrapper around TJSONWriter to build a JSON array or object, with support for nested arrays and nested objects</summary>
  TJSONCollectionBuilder = class abstract
  public type

    TElements = class;
    TPairs = class;
    TParentCollection = class;

    TBaseCollection = class
    strict private
      FRootDepth: Integer;
      [weak] FOwner: TJSONCollectionBuilder;
      FWriter: TJSONWriter;
    private
      procedure AddingElement;
      procedure AddingPair;
      procedure ErrorInvalidSetOfItems;
      procedure WriteVarRec(const AValue: TVarRec);
      procedure WriteVariant(const AValue: Variant);
      procedure WriteOpenArray(const AItems: array of const);
      function WriteReader(const AReader: TJsonReader; AOnlyEnclosed: Boolean): Boolean;
      procedure WriteBuilder(const ABuilder: TJSONCollectionBuilder);
      procedure WriteJSON(const AJSON: string);

      function Add(const AValue: string): TElements; overload;
      function Add(const AValue: Int32): TElements; overload;
      function Add(const AValue: UInt32): TElements; overload;
      function Add(const AValue: Int64): TElements; overload;
      function Add(const AValue: UInt64): TElements; overload;
      function Add(const AValue: Single): TElements; overload;
      function Add(const AValue: Double): TElements; overload;
      function Add(const AValue: Extended): TElements; overload;
      function Add(const AValue: Boolean): TElements; overload;
      function Add(const AValue: Char): TElements; overload;
      function Add(const AValue: Byte): TElements; overload;
      function Add(const AValue: TDateTime): TElements; overload;
      function Add(const AValue: TGUID): TElements; overload;
      function Add(const AValue: TBytes;
        ABinaryType: TJsonBinaryType = TJsonBinaryType.Generic): TElements; overload;
      function Add(const AValue: TJsonOid): TElements; overload;
      function Add(const AValue: TJsonRegEx): TElements; overload;
      function Add(const AValue: TJsonDBRef): TElements; overload;
      function Add(const AValue: TJsonCodeWScope): TElements; overload;
      function Add(const AValue: TValue): TElements; overload;
      function Add(const AValue: TVarRec): TElements; overload;
      function Add(const AValue: Variant): TElements; overload;
      function AddElements(const AElements: array of const): TElements; overload;
      function AddElements(const ABuilder: TJSONCollectionBuilder): TElements; overload;
      function AddElements(const AJSON: string): TElements; overload;
      function AddNull: TElements; overload;
      function AddUndefined: TElements; overload;
      function AddMinKey: TElements; overload;
      function AddMaxKey: TElements; overload;

      function Add(const AKey: string; const AValue: string): TPairs; overload;
      function Add(const AKey: string; const AValue: Int32): TPairs; overload;
      function Add(const AKey: string; const AValue: UInt32): TPairs; overload;
      function Add(const AKey: string; const AValue: Int64): TPairs; overload;
      function Add(const AKey: string; const AValue: UInt64): TPairs; overload;
      function Add(const AKey: string; const AValue: Single): TPairs; overload;
      function Add(const AKey: string; const AValue: Double): TPairs; overload;
      function Add(const AKey: string; const AValue: Extended): TPairs; overload;
      function Add(const AKey: string; const AValue: Boolean): TPairs; overload;
      function Add(const AKey: string; const AValue: Char): TPairs; overload;
      function Add(const AKey: string; const AValue: Byte): TPairs; overload;
      function Add(const AKey: string; const AValue: TDateTime): TPairs; overload;
      function Add(const AKey: string; const AValue: TGUID): TPairs; overload;
      function Add(const AKey: string; const AValue: TBytes;
        ABinaryType: TJsonBinaryType = TJsonBinaryType.Generic): TPairs; overload;
      function Add(const AKey: string; const AValue: TJsonOid): TPairs; overload;
      function Add(const AKey: string; const AValue: TJsonRegEx): TPairs; overload;
      function Add(const AKey: string; const AValue: TJsonDBRef): TPairs; overload;
      function Add(const AKey: string; const AValue: TJsonCodeWScope): TPairs; overload;
      function Add(const AKey: string; const AValue: TValue): TPairs; overload;
      function Add(const AKey: string; const AValue: TVarRec): TPairs; overload;
      function Add(const AKey: string; const AValue: Variant): TPairs; overload;
      function AddPairs(const APairs: array of const): TPairs; overload;
      function AddPairs(const ABuilder: TJSONCollectionBuilder): TPairs; overload;
      function AddPairs(const AJSON: string): TPairs; overload;
      function AddNull(const AKey: string): TPairs; overload;
      function AddUndefined(const AKey: string): TPairs; overload;
      function AddMinKey(const AKey: string): TPairs; overload;
      function AddMaxKey(const AKey: string): TPairs; overload;

      /// <summary>End this array and return the parent collection, if any.</summary>
      function EndArray: TParentCollection;  // Can return nil
      function EndObject: TParentCollection;  // Can return nil

      function BeginObject: TPairs; overload;
      function BeginArray: TElements; overload;
      function BeginObject(const AKey: string): TPairs; overload;
      function BeginArray(const AKey: string): TElements; overload;

      property Owner: TJSONCollectionBuilder read FOwner;
      property Writer: TJSONWriter read FWriter;
      property RootDepth: Integer read FRootDepth;
    public
      constructor Create(const AOwner: TJSONCollectionBuilder; const ARootDepth: Integer);
      procedure EndAll;
      function Ended: Boolean;
    end;

    /// <summary>Provide methods to add elements to a JSON array</summary>
    TElements = class(TBaseCollection)
    public
      function Add(const AValue: string): TElements; overload; inline;
      function Add(const AValue: Int32): TElements; overload; inline;
      function Add(const AValue: UInt32): TElements; overload; inline;
      function Add(const AValue: Int64): TElements; overload; inline;
      function Add(const AValue: UInt64): TElements; overload; inline;
      function Add(const AValue: Single): TElements; overload; inline;
      function Add(const AValue: Double): TElements; overload; inline;
      function Add(const AValue: Extended): TElements; overload; inline;
      function Add(const AValue: Boolean): TElements; overload; inline;
      function Add(const AValue: Char): TElements; overload; inline;
      function Add(const AValue: Byte): TElements; overload; inline;
      function Add(const AValue: TDateTime): TElements; overload; inline;
      function Add(const AValue: TGUID): TElements; overload; inline;
      function Add(const AValue: TBytes;
        ABinaryType: TJsonBinaryType = TJsonBinaryType.Generic): TElements; overload; inline;
      function Add(const AValue: TJsonOid): TElements; overload; inline;
      function Add(const AValue: TJsonRegEx): TElements; overload; inline;
      function Add(const AValue: TJsonDBRef): TElements; overload; inline;
      function Add(const AValue: TJsonCodeWScope): TElements; overload; inline;
      function Add(const AValue: TValue): TElements; overload; inline;
      function Add(const AValue: TVarRec): TElements; overload; inline;
      function Add(const AValue: Variant): TElements; overload; inline;
      function AddNull: TElements; inline;
      function AddUndefined: TElements; inline;
      function AddMinKey: TElements; inline;
      function AddMaxKey: TElements; inline;
      function AddElements(const AElements: array of const): TElements; overload;
      function AddElements(const ABuilder: TJSONCollectionBuilder): TElements; overload; inline;
      function AddElements(const AJSON: string): TElements; overload; inline;

      function BeginObject: TPairs; overload; inline;
      function BeginArray: TElements; overload; inline;
      function EndArray: TParentCollection; inline; // Does not return nil.

      /// <summary>Encapsulate this array so that there is no access to the parent array or object</summary>
      function AsRoot: TElements;
    end;

    /// <summary>Provide methods to add pairs to a JSON object</summary>
    TPairs = class(TBaseCollection)
    public
      function Add(const AKey: string; const AValue: string): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: Int32): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: UInt32): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: Int64): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: UInt64): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: Single): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: Double): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: Extended): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: Boolean): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: Char): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: Byte): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TDateTime): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TGUID): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TBytes;
        ABinaryType: TJsonBinaryType = TJsonBinaryType.Generic): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TJsonOid): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TJsonRegEx): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TJsonDBRef): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TJsonCodeWScope): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TValue): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TVarRec): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: Variant): TPairs; overload; inline;
      function AddNull(const AKey: string): TPairs; inline;
      function AddUndefined(const AKey: string): TPairs; inline;
      function AddMinKey(const AKey: string): TPairs; inline;
      function AddMaxKey(const AKey: string): TPairs; inline;
      function AddPairs(const APairs: array of const): TPairs; overload;
      function AddPairs(const ABuilder: TJSONCollectionBuilder): TPairs; overload; inline;
      function AddPairs(const AJSON: string): TPairs; overload; inline;

      function BeginObject(const AKey: string): TPairs; overload; inline;
      function BeginArray(const AKey: string): TElements; overload; inline;
      function EndObject: TParentCollection; inline; // Does not return nil.

      /// <summary>Encapsulate this JSON object so that there is no access to the parent array or object</summary>
      function AsRoot: TPairs;
    end;

    /// <summary>Provide methods to add pairs to a JSON object and to add elements to a JSON array.
    ///  This type is used when ending an object or array, because the parent could be a JSON object,
    ///  a JSON array, or neither.
    /// </summary>
    TParentCollection = class(TBaseCollection)
    public
      function Add(const AValue: string): TElements; overload; inline;
      function Add(const AValue: Int32): TElements; overload; inline;
      function Add(const AValue: UInt32): TElements; overload; inline;
      function Add(const AValue: Int64): TElements; overload; inline;
      function Add(const AValue: UInt64): TElements; overload; inline;
      function Add(const AValue: Single): TElements; overload; inline;
      function Add(const AValue: Double): TElements; overload; inline;
      function Add(const AValue: Extended): TElements; overload; inline;
      function Add(const AValue: Boolean): TElements; overload; inline;
      function Add(const AValue: Char): TElements; overload; inline;
      function Add(const AValue: Byte): TElements; overload; inline;
      function Add(const AValue: TDateTime): TElements; overload; inline;
      function Add(const AValue: TGUID): TElements; overload; inline;
      function Add(const AValue: TBytes;
        ABinaryType: TJsonBinaryType = TJsonBinaryType.Generic): TElements; overload; inline;
      function Add(const AValue: TJsonOid): TElements; overload; inline;
      function Add(const AValue: TJsonRegEx): TElements; overload; inline;
      function Add(const AValue: TJsonDBRef): TElements; overload;
      function Add(const AValue: TJsonCodeWScope): TElements; overload;
      function Add(const AValue: TValue): TElements; overload; inline;
      function Add(const AValue: TVarRec): TElements; overload; inline;
      function Add(const AValue: Variant): TElements; overload; inline;
      function AddNull: TElements; overload; inline;
      function AddUndefined: TElements; overload; inline;
      function AddMinKey: TElements; overload; inline;
      function AddMaxKey: TElements; overload; inline;
      function AddElements(const AElements: array of const): TElements; overload;
      function AddElements(const ABuilder: TJSONCollectionBuilder): TElements; overload; inline;
      function AddElements(const AJSON: string): TElements; overload; inline;

      function Add(const AKey: string; const AValue: string): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: Int32): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: UInt32): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: Int64): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: UInt64): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: Single): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: Double): TPairs; overload; inline;
      function Add(const AKey: string; AValue: Extended): TPairs; overload; inline;
      function Add(const AKey: string; AValue: Boolean): TPairs; overload; inline;
      function Add(const AKey: string; AValue: Char): TPairs; overload; inline;
      function Add(const AKey: string; AValue: Byte): TPairs; overload; inline;
      function Add(const AKey: string; AValue: TDateTime): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TGUID): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TBytes;
        ABinaryType: TJsonBinaryType = TJsonBinaryType.Generic): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TJsonOid): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TJsonRegEx): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TJsonDBRef): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TJsonCodeWScope): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TValue): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: TVarRec): TPairs; overload; inline;
      function Add(const AKey: string; const AValue: Variant): TPairs; overload; inline;
      function AddNull(const AKey: string): TPairs; overload; inline;
      function AddUndefined(const AKey: string): TPairs; overload; inline;
      function AddMinKey(const AKey: string): TPairs; overload; inline;
      function AddMaxKey(const AKey: string): TPairs; overload; inline;
      function AddPairs(const APairs: array of const): TPairs; overload;
      function AddPairs(const ABuilder: TJSONCollectionBuilder): TPairs; overload; inline;
      function AddPairs(const AJSON: string): TPairs; overload; inline;

      function BeginObject: TPairs; overload; inline;
      function BeginArray: TElements; overload; inline;
      function BeginObject(const AKey: string): TPairs; overload; inline;
      function BeginArray(const AKey: string): TElements; overload; inline;
      function EndArray: TParentCollection; inline;  // Does not return nil
      function EndObject: TParentCollection; inline;  // Does not return nil

      /// <summary>Cast to an array.  Raises exception if not an array</summary>
      function AsArray: TElements;
      /// <summary>Cast to an object.  Raises exception if not an object</summary>
      function AsObject: TPairs;
    end;

    TParentType = (None, Elements, Pairs);
    TGetReaderProc = reference to function (AWriter: TJsonWriter): TJsonReader;
    TReleaseReaderProc = reference to procedure (AWriter: TJsonWriter; AReader: TJsonReader);
    TResetWriterProc = reference to procedure (AWriter: TJsonWriter);

  strict private
    FEmpty: Boolean;
    FPairs: TDictionary<Integer, TPairs>;
    FElements: TDictionary<Integer, TElements>;
    FParentCollections: TDictionary<Integer, TParentCollection>;
    FParentTypes: TStack<TParentType>;
    FJSONWriter: TJSONWriter;
    FGetReader: TGetReaderProc;
    FReleaseReader: TReleaseReaderProc;
    FResetWriter: TResetWriterProc;
  private
    procedure CheckParentType(ARootDepth: Integer; AParentType: TParentType);
    procedure CheckEmpty;
    function EndArray(ARootDepth: Integer): TParentCollection;
    function EndObject(ARootDepth: Integer): TParentCollection;
    procedure Complete(const ARootDepth: Integer);
    function GetPairs(ARootDepth: Integer): TPairs;
    function GetElements(ARootDepth: Integer): TElements;
    function GetParentCollection(ARootDepth: Integer): TParentCollection;
    function BeginObject(ARootDepth: Integer): TPairs; overload;
    function BeginArray(ARootDepth: Integer): TElements; overload;
    function PairsAsRoot: TPairs;
    function ElementsAsRoot: TElements;
    function AsArray(ARootDepth: Integer): TElements;
    function AsObject(ARootDepth: Integer): TPairs;
    function Ended(ARootDepth: Integer): Boolean;
    function GetAsJSON: string;
    procedure ClearContent;
    function GetParentType: TParentType;
    function GetParentArray: TElements;
    function GetParentObject: TPairs;
  protected
    /// <summary> Override DoResetWriter method to reset underlying builder
    ///  stream as part of Clear method call. </summary>
    procedure DoResetWriter(AWriter: TJsonWriter); virtual;
    /// <summary> Override DoGetReader method to provide a JSON reader for current
    ///  builder JSON writer as part of AsJSON, AddPairs, AddElements method calls. </summary>
    function DoGetReader(AWriter: TJsonWriter): TJsonReader; virtual;
    /// <summary> Override DoReleaseReader method to release a JSON reader provided
    ///  from DoGetReader method. </summary>
    procedure DoReleaseReader(AWriter: TJsonWriter; AReader: TJsonReader); virtual;
    /// <summary> Override DoWriteCustomVariant method to implement custom variant
    ///  data types writing. Default implementation will write a custom variant
    ///  value as a string. </summary>
    procedure DoWriteCustomVariant(AWriter: TJsonWriter; const AValue: Variant); virtual;

    /// <summary>Start a JSON array. DoBeginArray and DoBeginObject are mutually exclusive</summary>
    function DoBeginArray: TElements;
    /// <summary>Start a JSON object. DoBeginArray and DoBeginObject are mutually exclusive</summary>
    function DoBeginObject: TPairs;
  public
    constructor Create(const AJSONWriter: TJSONWriter); overload;
    constructor Create(const AJSONWriter: TJSONWriter;
      AGetReader: TGetReaderProc; AReleaseReader: TReleaseReaderProc;
      AResetWriter: TResetWriterProc); overload;
    destructor Destroy; override;
    /// <summary> Returns builder content as a JSON string. </summary>
    property AsJSON: string read GetAsJSON;
    /// <summary> Returns current parent item type. </summary>
    property ParentType: TParentType read GetParentType;
    /// <summary> Returns reference to current parent array builder. </summary>
    property ParentArray: TElements read GetParentArray;
    /// <summary> Returns reference to current parent object builder. </summary>
    property ParentObject: TPairs read GetParentObject;
  end;

  /// <summary>Call TJSONWriter to build a JSON array, with support for nested arrays and JSON objects</summary>
  TJSONArrayBuilder = class(TJSONCollectionBuilder)
  public
    /// <summary>Start a JSON array.</summary>
    function BeginArray: TJSONCollectionBuilder.TElements;
    /// <summary>Erases builder content. AResetWriter must be specified at
    ///  builder constructur call, which will reset underlying builder stream. </summary>
    function Clear: TJSONArrayBuilder;
  end;

  /// <summary>Call TJSONWriter to build a JSON object, with support for nested arrays and JSON objects</summary>
  TJSONObjectBuilder = class(TJSONCollectionBuilder)
  public
    /// <summary>Start a JSON object.</summary>
    function BeginObject: TJSONCollectionBuilder.TPairs;
    /// <summary>Erases builder content. AResetWriter must be specified at
    ///  builder constructur call, which will reset underlying builder stream. </summary>
    function Clear: TJSONObjectBuilder;
  end;

  /// <summary>Wrapper around TJSONReader to iterate through and read values of JSON items.
  ///  TJSONIterator supports forward only navigation through JSON with ability to rewind
  ///  iterator to JSON begin and to find specific place in JSON by a path. </summary>
  TJSONIterator = class
  private type
    TContext = class(TObject)
      FToken: TJsonToken;
      FIndex: Integer;
      constructor Create(AToken: TJsonToken);
    end;
  public type
    TRewindReaderProc = reference to procedure (AReader: TJsonReader);
    TIterateFunc = reference to function(AIter: TJSONIterator): Boolean;
  private
    FReader: TJsonReader;
    FStack: TStack<TContext>;
    FKey: String;
    FPath: String;
    FType: TJsonToken;
    FStarting: Boolean;
    FFinished: Boolean;
    FRecursion: Boolean;
    FRewindReader: TRewindReaderProc;
    function GetAsBoolean: Boolean; inline;
    function GetAsBytes: TBytes;
    function GetAsDateTime: TDateTime;
    function GetAsDBRef: TJsonDBRef;
    function GetAsExtended: Extended; inline;
    function GetAsDouble: Double; inline;
    function GetAsGUID: TGUID;
    function GetAsInteger: Int32; inline;
    function GetAsInt64: Int64; inline;
    function GetAsOid: TJsonOid;
    function GetAsRegEx: TJsonRegEx;
    function GetAsString: String; inline;
    function GetAsValue: TValue; inline;
    function GetAsVariant: Variant; inline;
    function GetDepth: Integer; inline;
    function GetInRecurse: Boolean; inline;
    function GetIsMaxKey: Boolean; inline;
    function GetIsMinKey: Boolean; inline;
    function GetIsNull: Boolean; inline;
    function GetIsUndefined: Boolean; inline;
    function GetAsCodeWScope: TJsonCodeWScope;
    function GetIndex: Integer;
    function GetParentType: TJsonToken;
    function GetPath: String;
  protected
    /// <summary> Override this method to rewind specified reader and underlying
    ///  stream to begining </summary>
    procedure DoRewindReader(AReader: TJsonReader); virtual;
  public
    constructor Create(AReader: TJsonReader); overload;
    constructor Create(AReader: TJsonReader; ARewindReader: TRewindReaderProc); overload;
    destructor Destroy; override;
    /// <summary> Rewinds iterator to JSON begining </summary>
    procedure Rewind;
    /// <summary> Forwards iterator to next JSON item at current array or object.
    ///  This method does not:
    ///  * enter into array or object items, use Recurse for that;
    ///  * return to parent array or object items, use Return for that;
    ///  When AKey is specified, then Next will find a pair with specified name.
    ///  It returns True if a pair is found, False - otherwise.
    ///  When AKey is not specified, then Next will forward to next item.
    ///  It returns True if an item exists, False - otherwise. </summary>
    function Next(const AKey: String = ''): Boolean;
    /// <summary> Enters iterator into current array or object and sets the
    ///  iterator position before first item. It returns True, if current item
    ///  was an array or object. </summary>
    function Recurse: Boolean;
    /// <summary> Returns iterator to parrent array or object. </summary>
    procedure Return;
    /// <summary> Searches for JSON item by specified JSON path. A JSON path is
    ///  a string consisting of pair names and array indexes, separated by dots.
    ///  For example: 'name', '[0]', 'entities.urls[0].indices[1]'
    ///  Find returns True when path is found and forwards iterator to the
    ///  corresponding item. </summary>
    function Find(const APath: String): Boolean;
    /// <summary> Iterates through all JSON items and calls AFunc for each
    ///  item. As argument AFunc receives reference to this iterator, pointing
    ///  to current JSON item. When AFunc returns True, then the method continues
    ///  iterating, otherwise stops immediately. </summary>
    procedure Iterate(AFunc: TIterateFunc);
    // current item attributes
    /// <summary> Current item name. </summary>
    property Key: String read FKey;
    /// <summary> Current item full name or path. </summary>
    property Path: String read GetPath;
    /// <summary> Current item JSON type. </summary>
    property &Type: TJsonToken read FType;
    /// <summary> Parent item JSON type. </summary>
    property ParentType: TJsonToken read GetParentType;
    /// <summary> Current element index when parent item is TJsonToken.StartArray. </summary>
    property &Index: Integer read GetIndex;
    /// <summary> Returns True, when there is a parent item. </summary>
    property InRecurse: Boolean read GetInRecurse;
    /// <summary> Returns current depth. </summary>
    property Depth: Integer read GetDepth;
    // current item value
    /// <summary> Returns current item string value. </summary>
    property AsString: String read GetAsString;
    /// <summary> Returns current item Int32 value. </summary>
    property AsInteger: Int32 read GetAsInteger;
    /// <summary> Returns current item Int64 value. </summary>
    property AsInt64: Int64 read GetAsInt64;
    /// <summary> Returns current item Double value. </summary>
    property AsDouble: Double read GetAsDouble;
    /// <summary> Returns current item Extended value. </summary>
    property AsExtended: Extended read GetAsExtended;
    /// <summary> Returns current item Boolean value. </summary>
    property AsBoolean: Boolean read GetAsBoolean;
    /// <summary> Returns current item TDateTime value. </summary>
    property AsDateTime: TDateTime read GetAsDateTime;
    /// <summary> Returns current item TGUID value. </summary>
    property AsGUID: TGUID read GetAsGUID;
    /// <summary> Returns current item TBytes value. </summary>
    property AsBytes: TBytes read GetAsBytes;
    /// <summary> Returns current item TJsonOid value. </summary>
    property AsOid: TJsonOid read GetAsOid;
    /// <summary> Returns current item TJsonRegEx value. </summary>
    property AsRegEx: TJsonRegEx read GetAsRegEx;
    /// <summary> Returns current item TJsonDBRef value. </summary>
    property AsDBRef: TJsonDBRef read GetAsDBRef;
    /// <summary> Returns current item TJsonCodeWScope value. </summary>
    property AsCodeWScope: TJsonCodeWScope read GetAsCodeWScope;
    /// <summary> Returns current item value as Variant. </summary>
    property AsVariant: Variant read GetAsVariant;
    /// <summary> Returns current item value as TValue. </summary>
    property AsValue: TValue read GetAsValue;
    /// <summary> Returns True when current item is Null. </summary>
    property IsNull: Boolean read GetIsNull;
    /// <summary> Returns True when current item is Undefined. </summary>
    property IsUndefined: Boolean read GetIsUndefined;
    /// <summary> Returns True when current item is MinKey. </summary>
    property IsMinKey: Boolean read GetIsMinKey;
    /// <summary> Returns True when current item is MaxKey. </summary>
    property IsMaxKey: Boolean read GetIsMaxKey;
  end;

  // Aliases

  TJSONObjectBuilderPairs = TJSONObjectBuilder.TPairs;
  TJSONArrayBuilderElements = TJSONArrayBuilder.TElements;

  /// <summary> Exception class used by TJSONCollectionBuilder. </summary>
  EJSONCollectionBuilderError = class(Exception);
  /// <summary> Exception class used by TJSONIterator. </summary>
  EJSONIteratorError = class(Exception);

implementation

uses
  System.Variants, System.JSONConsts;

{ TJSONCollectionBuilder }

function TJSONCollectionBuilder.BeginArray(ARootDepth: Integer): TElements;
begin
  FParentTypes.Push(TParentType.Elements);
  FJSONWriter.WriteStartArray;
  Result := GetElements(ARootDepth);
end;

function TJSONCollectionBuilder.ElementsAsRoot: TElements;
begin
  Result := GetElements(FParentTypes.Count);
end;

function TJSONCollectionBuilder.AsArray(ARootDepth: Integer): TElements;
begin
  Result := nil;
  if FParentTypes.Count > 0 then
    if FParentTypes.Peek = TJSONCollectionBuilder.TParentType.Elements then
      Result := GetElements(ARootDepth);
  if Result = nil then
    raise EJSONCollectionBuilderError.Create(sJSONBuilderNotParentType);
end;

function TJSONCollectionBuilder.AsObject(ARootDepth: Integer): TPairs;
begin
  Result := nil;
  if FParentTypes.Count > 0 then
    if FParentTypes.Peek = TJSONCollectionBuilder.TParentType.Pairs then
      Result := GetPairs(ARootDepth);
  if Result = nil then
    raise EJSONCollectionBuilderError.Create(sJSONBuilderNotParentType);
end;

function TJSONCollectionBuilder.DoBeginArray: TElements;
begin
  CheckEmpty;
  FEmpty := False;
  Result := BeginArray(0);
end;

procedure TJSONCollectionBuilder.Complete(const ARootDepth: Integer);
var
  LType: TParentType;
begin
  while FParentTypes.Count > ARootDepth do
  begin
    LType := FParentTypes.Pop;
    case LType of
      TParentType.Elements:
        FJSONWriter.WriteEndArray;
      TParentType.Pairs:
        FJSONWriter.WriteEndObject;
    end;
  end;
end;

constructor TJSONCollectionBuilder.Create(const AJSONWriter: TJSONWriter);
begin
  inherited Create;
  FEmpty := True;
  FJSONWriter := AJSONWriter;
  FParentTypes := TStack<TParentType>.Create;
end;

constructor TJSONCollectionBuilder.Create(const AJSONWriter: TJSONWriter;
  AGetReader: TGetReaderProc; AReleaseReader: TReleaseReaderProc;
  AResetWriter: TResetWriterProc);
begin
  Create(AJSONWriter);
  FGetReader := AGetReader;
  FReleaseReader := AReleaseReader;
  FResetWriter := AResetWriter;
end;

destructor TJSONCollectionBuilder.Destroy;
begin
  FElements.Free;
  FPairs.Free;
  FParentTypes.Free;
  FParentCollections.Free;
  inherited Destroy;
end;

function TJSONCollectionBuilder.BeginObject(ARootDepth: Integer): TPairs;
begin
  FParentTypes.Push(TParentType.Pairs);
  FJSONWriter.WriteStartObject;
  Result := GetPairs(ARootDepth);
end;

function TJSONCollectionBuilder.DoBeginObject: TPairs;
begin
  CheckEmpty;
  FEmpty := False;
  Result := BeginObject(0);
end;

function TJSONCollectionBuilder.EndObject(ARootDepth: Integer): TParentCollection;
begin
  if FParentTypes.Count > ARootDepth then
  begin
    case FParentTypes.Peek of
      TJSONCollectionBuilder.TParentType.Pairs:
      begin
        FParentTypes.Pop;
        FJSONWriter.WriteEndObject;
        if FParentTypes.Count > ARootDepth then
          Result := GetParentCollection(ARootDepth)
        else
          Result := GetParentCollection(MaxInt) // Ended
      end;
    else
      raise EJSONCollectionBuilderError.Create(sJSONBuilderNotParentType);
    end;
  end
  else
    Result := GetParentCollection(MaxInt); // Ended object
end;

function TJSONCollectionBuilder.EndArray(ARootDepth: Integer): TParentCollection;
begin
  if FParentTypes.Count > ARootDepth then
  begin
    case FParentTypes.Peek of
      TJSONCollectionBuilder.TParentType.Elements:
      begin
        FParentTypes.Pop;
        FJSONWriter.WriteEndArray;
        if FParentTypes.Count > ARootDepth then
          Result := GetParentCollection(ARootDepth)
        else
          Result := GetParentCollection(MaxInt); // Ended object
      end;
    else
      raise EJSONCollectionBuilderError.Create(sJSONBuilderNotParentType);
    end;
  end
  else
    Result := GetParentCollection(MaxInt); // Ended object
end;

function TJSONCollectionBuilder.PairsAsRoot: TPairs;
begin
  Result := GetPairs(FParentTypes.Count);
end;

function TJSONCollectionBuilder.GetElements(ARootDepth: Integer): TElements;
begin
  if FElements = nil then
    FElements := TObjectDictionary<Integer, TElements>.Create([doOwnsValues]);
  if not FElements.TryGetValue(ARootDepth, Result) then
  begin
    Result := TElements.Create(Self, ARootDepth);
    FElements.Add(ARootDepth, Result);
  end;
end;

function TJSONCollectionBuilder.GetParentCollection(ARootDepth: Integer): TParentCollection;
begin
  if FParentCollections = nil then
    FParentCollections := TObjectDictionary<Integer, TParentCollection>.Create([doOwnsValues]);
  if not FParentCollections.TryGetValue(ARootDepth, Result) then
  begin
    Result := TParentCollection.Create(Self, ARootDepth);
    FParentCollections.Add(ARootDepth, Result);
  end;
end;

function TJSONCollectionBuilder.GetPairs(ARootDepth: Integer): TPairs;
begin
  if FPairs = nil then
    FPairs := TObjectDictionary<Integer, TPairs>.Create([doOwnsValues]);
  if not FPairs.TryGetValue(ARootDepth, Result) then
  begin
    Result := TPairs.Create(Self, ARootDepth);
    FPairs.Add(ARootDepth, Result);
  end;
end;

function TJSONCollectionBuilder.Ended(ARootDepth: Integer): Boolean;
begin
  Result := ARootDepth = MaxInt;
end;

procedure TJSONCollectionBuilder.CheckEmpty;
begin
  if not FEmpty then
    raise EJSONCollectionBuilderError.Create(sJSONBuilderNotEmpty);
end;

procedure TJSONCollectionBuilder.CheckParentType(ARootDepth: Integer; AParentType: TParentType);
begin
  if (FParentTypes.Count = 0) or Ended(ARootDepth) or (FParentTypes.Peek <> AParentType) then
    raise EJSONCollectionBuilderError.Create(sJSONBuilderNotParentType);
end;

procedure TJSONCollectionBuilder.DoResetWriter(AWriter: TJsonWriter);
begin
  if not Assigned(FResetWriter) then
    raise EJSONCollectionBuilderError.Create(sJSONBuilderNoReaderCallback);
  FResetWriter(AWriter);
end;

function TJSONCollectionBuilder.DoGetReader(AWriter: TJsonWriter): TJsonReader;
begin
  if not Assigned(FGetReader) then
    raise EJSONCollectionBuilderError.Create(sJSONBuilderNoReaderCallback);
  Result := FGetReader(AWriter);
end;

procedure TJSONCollectionBuilder.DoReleaseReader(AWriter: TJsonWriter; AReader: TJsonReader);
begin
  if not Assigned(FReleaseReader) then
    raise EJSONCollectionBuilderError.Create(sJSONBuilderNoReaderCallback);
  FReleaseReader(AWriter, AReader);
end;

procedure TJSONCollectionBuilder.DoWriteCustomVariant(AWriter: TJsonWriter; const AValue: Variant);
var
  S: string;
begin
  try
    S := AValue;
  except
    raise EJSONCollectionBuilderError.CreateFmt(sJSONBuilderUnsupVariantType, [VarType(AValue)]);
  end;
  AWriter.WriteValue(S);
end;

procedure TJSONCollectionBuilder.ClearContent;
begin
  FreeAndNil(FElements);
  FreeAndNil(FPairs);
  FreeAndNil(FParentCollections);
  FParentTypes.Clear;
  FEmpty := True;
  FJSONWriter.Rewind;
  DoResetWriter(FJSONWriter);
end;

function TJSONCollectionBuilder.GetAsJSON: string;
var
  LText: TTextWriter;
  LJson: TJsonTextWriter;
  LRdr: TJsonReader;
begin
  FJSONWriter.Flush;
  LText := TStringWriter.Create;
  try
    LJson := TJsonTextWriter.Create(LText);
    try
      LRdr := DoGetReader(FJSONWriter);
      try
        LJson.ExtendedJsonMode := TJsonExtendedJsonMode.StrictMode;
        LJson.WriteToken(LRdr, True);
        Result := LText.ToString;
      finally
        DoReleaseReader(FJSONWriter, LRdr);
      end;
    finally
      LJson.Free;
    end;
  finally
    LText.Free;
  end;
end;

function TJSONCollectionBuilder.GetParentType: TParentType;
begin
  if FParentTypes.Count > 0 then
    Result := FParentTypes.Peek
  else
    Result := TParentType.None;
end;

function TJSONCollectionBuilder.GetParentArray: TElements;
begin
  if (FParentTypes.Count > 0) and (FParentTypes.Peek = TJSONCollectionBuilder.TParentType.Elements) then
    Result := GetElements(0)
  else
    raise EJSONCollectionBuilderError.Create(sJSONBuilderNotParentType);
end;

function TJSONCollectionBuilder.GetParentObject: TPairs;
begin
  if (FParentTypes.Count > 0) and (FParentTypes.Peek = TJSONCollectionBuilder.TParentType.Pairs) then
    Result := GetPairs(0)
  else
    raise EJSONCollectionBuilderError.Create(sJSONBuilderNotParentType);
end;

{ TJSONCollectionBuilder.TBaseCollection }

procedure TJSONCollectionBuilder.TBaseCollection.EndAll;
begin
  Owner.Complete(FRootDepth);
end;

constructor TJSONCollectionBuilder.TBaseCollection.Create(
  const AOwner: TJSONCollectionBuilder; const ARootDepth: Integer);
begin
  FRootDepth := ARootDepth;
  FOwner := AOwner;
  FWriter := AOwner.FJSONWriter;
end;

procedure TJSONCollectionBuilder.TBaseCollection.WriteVarRec(const AValue: TVarRec);

  procedure Error;
  begin
    raise EJSONCollectionBuilderError.CreateFmt(sJSONBuilderUnsupVarRecType, [AValue.VType]);
  end;

begin
  case AValue.VType of
    vtInteger:
      Writer.WriteValue(AValue.VInteger);
    vtBoolean:
      Writer.WriteValue(AValue.VBoolean);
{$IFNDEF NEXTGEN}
    vtChar:
      Writer.WriteValue(string(AValue.VChar));
{$ENDIF}
    vtWideChar:
      Writer.WriteValue(AValue.VWideChar);
    vtExtended:
      Writer.WriteValue(AValue.VExtended^);
{$IFNDEF NEXTGEN}
    vtString:
      Writer.WriteValue(string(AValue.VString^));
{$ENDIF}
{$IFNDEF NEXTGEN}
    vtPChar:
      Writer.WriteValue(string(AValue.VPChar));
{$ENDIF}
    vtPWideChar:
      Writer.WriteValue(string(AValue.VPWideChar));
    vtPointer:
      if AValue.VPointer = nil then
        Writer.WriteNull
      else
        Error;
    vtObject:
      if AValue.VObject = nil then
        Writer.WriteNull
      else
        Error;
{$IFNDEF NEXTGEN}
    vtAnsiString:
      Writer.WriteValue(string(AnsiString(AValue.VAnsiString)));
{$ENDIF}
    vtCurrency:
      Writer.WriteValue(AValue.VCurrency^);
    vtVariant:
      WriteVariant(AValue.VVariant^);
    vtWideString:
{$IFNDEF NEXTGEN}
      Writer.WriteValue(WideString(AValue.VWideString));
{$ELSE}
      Writer.WriteValue(string(AValue.VWideString));
{$ENDIF}
    vtInt64:
      Writer.WriteValue(AValue.VInt64^);
    vtUnicodeString:
      Writer.WriteValue(string(AValue.VUnicodeString));
  else
    Error;
  end;
end;

procedure TJSONCollectionBuilder.TBaseCollection.WriteVariant(const AValue: Variant);

  procedure Error;
  begin
    raise EJSONCollectionBuilderError.CreateFmt(sJSONBuilderUnsupVariantType, [VarType(AValue)]);
  end;

  procedure AddBytes;
  var
    pData: Pointer;
  begin
    pData := VarArrayLock(AValue);
    try
      Writer.WriteValue(BytesOf(pData, VarArrayHighBound(AValue, 1) - VarArrayLowBound(AValue, 1) + 1));
    finally
      VarArrayUnlock(AValue);
    end;
  end;

  procedure AddArray;
  var
    I: Integer;
    LElems: TElements;
  begin
    LElems := BeginArray;
    for I := 0 to VarArrayHighBound(AValue, 1) do
      LElems.Add(AValue[I]);
    LElems.EndArray;
  end;

begin
  if VarIsArray(AValue) then
    if not ((VarArrayDimCount(AValue) = 1) and (VarArrayLowBound(AValue, 1) = 0)) then
      Error
    else if (VarType(AValue) and VarTypeMask) = varByte then
      AddBytes
    else
      AddArray
  else
    case VarType(AValue) and varTypeMask of
      varEmpty:
        Writer.WriteUndefined;
      varNull:
        Writer.WriteNull;
      varSmallint,
      varShortInt,
      varInteger:
        Writer.WriteValue(Integer(AValue));
      varByte,
      varWord,
      varLongWord:
        Writer.WriteValue(Cardinal(AValue));
      varInt64:
        Writer.WriteValue(Int64(AValue));
      varUInt64:
        Writer.WriteValue(UInt64(AValue));
      varSingle,
      varDouble:
        Writer.WriteValue(Double(AValue));
      varCurrency:
        Writer.WriteValue(Extended(AValue));
      varDate:
        Writer.WriteValue(TDateTime(AValue));
      varOleStr,
      varStrArg,
      varUStrArg,
      varString,
      varUString:
        Writer.WriteValue(string(AValue));
      varBoolean:
        Writer.WriteValue(Boolean(AValue));
      varObject,
      varDispatch,
      varError,
      varVariant,
      varUnknown,
      varRecord,
      varAny:
        Error;
      else
        Owner.DoWriteCustomVariant(Writer, AValue);
    end;
end;

procedure TJSONCollectionBuilder.TBaseCollection.ErrorInvalidSetOfItems;
begin
  raise EJSONCollectionBuilderError.Create(sJSONBuilderInvalidSetOfItems);
end;

procedure TJSONCollectionBuilder.TBaseCollection.WriteOpenArray(const AItems: array of const);
var
  iItem: Integer;
  sKey: string;
  LPriorLevel: Integer;
  LPriorType: TParentType;

  procedure Error;
  begin
    raise EJSONCollectionBuilderError.CreateFmt(sJSONBuilderInvalidOpenArrayItem, [iItem]);
  end;

  function GetStr(AIndex: Integer; out AValue: string): Boolean;
  var
    pRec: PVarRec;
  begin
    pRec := @TVarRec(AItems[AIndex]);
    Result := True;
    case pRec^.VType of
{$IFNDEF NEXTGEN}
    vtChar:
      AValue := string(pRec^.VChar);
{$ENDIF}
    vtWideChar:
      AValue := pRec^.VWideChar;
{$IFNDEF NEXTGEN}
    vtString:
      AValue := string(pRec^.VString^);
    vtAnsiString:
      AValue := string(AnsiString(pRec^.VAnsiString));
{$ENDIF}
    vtWideString:
{$IFNDEF NEXTGEN}
      AValue := WideString(pRec^.VWideString);
{$ELSE}
      AValue := string(pRec^.VWideString);
{$ENDIF}
    vtUnicodeString:
      AValue := string(pRec^.VUnicodeString);
    else
      Result := False;
    end;
  end;

  procedure ProcessPair(ACollection: TBaseCollection);
  var
    LAddPair: Boolean;
    s: string;
    LElems: TElements;
    LPairs: TPairs;
  begin
    LAddPair := False;
    if GetStr(iItem, s) then
      if s = '[' then
      begin
        if ACollection is TElements then
          LElems := ACollection.BeginArray
        else
          LElems := ACollection.BeginArray(sKey);
        repeat
          sKey := '';
          Inc(iItem);
          if iItem > High(AItems) then
            Break
          else if GetStr(iItem, sKey) and (sKey = ']') then
          begin
            LElems.EndArray;
            Break;
          end
          else
            ProcessPair(LElems);
        until iItem >= High(AItems);
      end
      else if s = '{' then
      begin
        if ACollection is TElements then
          LPairs := ACollection.BeginObject
        else
          LPairs := ACollection.BeginObject(sKey);
        repeat
          sKey := '';
          Inc(iItem);
          if iItem > High(AItems) then
            Break
          else if GetStr(iItem, sKey) and (sKey = '}') then
          begin
            LPairs.EndObject;
            Break;
          end
          else
          begin
            Inc(iItem);
            ProcessPair(LPairs);
          end;
        until iItem >= High(AItems);
      end
      else
        LAddPair := True
    else
      LAddPair := True;
    if LAddPair then
      if ACollection is TElements then
        ACollection.Add(AItems[iItem])
      else
        ACollection.Add(sKey, AItems[iItem]);
  end;

begin
  LPriorLevel := Owner.FParentTypes.Count;
  if LPriorLevel > 0 then
    LPriorType := Owner.FParentTypes.Peek
  else
    LPriorType := TParentType.Elements;

  iItem := Low(AItems);
  while iItem <= High(AItems) do
  begin
    if Self is TElements then
      sKey := ''
    else
    begin
      if not GetStr(iItem, sKey) then
        Error;
      Inc(iItem);
    end;
    ProcessPair(Self);
    Inc(iItem);
  end;

  if not ((LPriorLevel = Owner.FParentTypes.Count) and
          ((LPriorLevel = 0) or (LPriorType = Owner.FParentTypes.Peek))) then
    ErrorInvalidSetOfItems;
end;

function TJSONCollectionBuilder.TBaseCollection.WriteReader(const AReader: TJsonReader;
  AOnlyEnclosed: Boolean): Boolean;
var
  LSkipRead: Boolean;
  iCurDepth: Integer;
  LPriorLevel: Integer;
  LPriorCont: TJsonContainerType;
begin
  LPriorLevel := Writer.Top;
  LPriorCont := Writer.TopContainer;

  Result := True;
  iCurDepth := AReader.Depth;
  AReader.Read;
  LSkipRead := not TJsonReader.IsStartToken(AReader.TokenType);
  if LSkipRead then
  begin
    if AOnlyEnclosed then
      Exit(False);
    Dec(iCurDepth);
  end;
  while (LSkipRead or AReader.Read) and (AReader.Depth > iCurDepth) do
  begin
    Writer.WriteToken(AReader, True);
    LSkipRead := False;
  end;

  if not ((LPriorLevel = Writer.Top) and
          (LPriorCont = Writer.TopContainer)) then
    ErrorInvalidSetOfItems;
end;

procedure TJSONCollectionBuilder.TBaseCollection.WriteBuilder(const ABuilder: TJSONCollectionBuilder);
var
  LRdr: TJsonReader;
begin
  ABuilder.FJSONWriter.Flush;
  LRdr := Owner.DoGetReader(ABuilder.FJSONWriter);
  try
    WriteReader(LRdr, False);
  finally
    Owner.DoReleaseReader(ABuilder.FJSONWriter, LRdr);
  end;
end;

procedure TJSONCollectionBuilder.TBaseCollection.WriteJSON(const AJSON: string);
var
  LStr: TStringReader;
  LRdr: TJsonTextReader;
begin
  if AJSON <> '' then
  begin
    LStr := TStringReader.Create(AJSON);
    try
      LRdr := TJsonTextReader.Create(LStr);
      try
        LRdr.ExtendedJsonMode := TJsonExtendedJsonMode.StrictMode;
        if not WriteReader(LRdr, True) then
          WriteJSON('{' + AJSON + '}');
      finally
        LRdr.Free;
      end;
    finally
      LStr.Free;
    end;
  end;
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: Extended): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth)
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: Boolean): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth)
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: Int64): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth)
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: TDateTime): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth)
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: string): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.AddNull: TElements;
begin
  AddingElement;
  Writer.WriteNull;
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.AddUndefined: TElements;
begin
  AddingElement;
  Writer.WriteUndefined;
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.BeginArray: TElements;
begin
  AddingElement;
  Result := Owner.BeginArray(RootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.BeginObject: TPairs;
begin
  AddingElement;
  Result := Owner.BeginObject(RootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.BeginArray(const AKey: string): TElements;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Result := Owner.BeginArray(RootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.BeginObject(const AKey: string): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Result := Owner.BeginObject(RootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.EndArray: TParentCollection;
begin
  Result := Owner.EndArray(RootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.EndObject: TParentCollection;
begin
  Result := Owner.EndObject(RootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Ended: Boolean;
begin
  Result := Owner.Ended(RootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: Double): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: Char): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: Single): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: Int32): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: UInt32): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: UInt64): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: TBytes;
  ABinaryType: TJsonBinaryType = TJsonBinaryType.Generic): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue, ABinaryType);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: TValue): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: TVarRec): TElements;
begin
  AddingElement;
  WriteVarRec(AValue);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: Variant): TElements;
begin
  AddingElement;
  WriteVariant(AValue);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: Byte): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: TGUID): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: TJsonDBRef): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: TJsonCodeWScope): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: TJsonOid): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AValue: TJsonRegEx): TElements;
begin
  AddingElement;
  Writer.WriteValue(AValue);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.AddMaxKey: TElements;
begin
  AddingElement;
  Writer.WriteMaxKey;
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.AddMinKey: TElements;
begin
  AddingElement;
  Writer.WriteMinKey;
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.AddElements(const AElements: array of const): TElements;
begin
  AddingElement;
  WriteOpenArray(AElements);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.AddElements(const ABuilder: TJSONCollectionBuilder): TElements;
begin
  AddingElement;
  WriteBuilder(ABuilder);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.AddElements(const AJSON: string): TElements;
begin
  AddingElement;
  WriteJSON(AJSON);
  Result := Owner.GetElements(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: Single): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: Double): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: Int32): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: UInt32): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: UInt64): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: TBytes; ABinaryType: TJsonBinaryType = TJsonBinaryType.Generic): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue, ABinaryType);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: TValue): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: TVarRec): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  WriteVarRec(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: Variant): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  WriteVariant(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: TGUID): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: Char): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: Byte): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.AddUndefined(const AKey: string): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteUndefined;
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: Int64): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: Boolean): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: Extended): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: string): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: TDateTime): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: TJsonDBRef): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: TJsonCodeWScope): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: TJsonOid): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.Add(const AKey: string;
  const AValue: TJsonRegEx): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteValue(AValue);
  Result := Owner.GetPairs(FRootDepth);
end;

procedure TJSONCollectionBuilder.TBaseCollection.AddingElement;
begin
  Owner.CheckParentType(RootDepth, TParentType.Elements);
end;

procedure TJSONCollectionBuilder.TBaseCollection.AddingPair;
begin
  Owner.CheckParentType(RootDepth, TParentType.Pairs);
end;

function TJSONCollectionBuilder.TBaseCollection.AddNull(const AKey: string): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteNull;
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.AddMaxKey(const AKey: string): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteMaxKey;
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.AddMinKey(const AKey: string): TPairs;
begin
  AddingPair;
  Writer.WritePropertyName(AKey);
  Writer.WriteMinKey;
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.AddPairs(const APairs: array of const): TPairs;
begin
  AddingPair;
  WriteOpenArray(APairs);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.AddPairs(const ABuilder: TJSONCollectionBuilder): TPairs;
begin
  AddingPair;
  WriteBuilder(ABuilder);
  Result := Owner.GetPairs(FRootDepth);
end;

function TJSONCollectionBuilder.TBaseCollection.AddPairs(const AJSON: string): TPairs;
begin
  AddingPair;
  WriteJSON(AJSON);
  Result := Owner.GetPairs(FRootDepth);
end;

{ TJSONArrayBuilder }

function TJSONArrayBuilder.BeginArray: TJSONCollectionBuilder.TElements;
begin
  Result := DoBeginArray;
end;

function TJSONArrayBuilder.Clear: TJSONArrayBuilder;
begin
  ClearContent;
  Result := Self;
end;

{ TJSONObjectBuilder }

function TJSONObjectBuilder.BeginObject: TJSONCollectionBuilder.TPairs;
begin
  Result := DoBeginObject;
end;

function TJSONObjectBuilder.Clear: TJSONObjectBuilder;
begin
  ClearContent;
  Result := Self;
end;

{ TJSONCollectionBuilder.TElements }

function TJSONCollectionBuilder.TElements.Add(const AValue: Single): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: Double): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: Extended): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: UInt64): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: string): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: Int32): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: UInt32): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: Int64): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: TGUID): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: TBytes;
  ABinaryType: TJsonBinaryType = TJsonBinaryType.Generic): TElements;
begin
  Result := inherited Add(AValue, ABinaryType);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: TValue): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: TVarRec): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: Variant): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: TDateTime): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: Boolean): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: Char): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: Byte): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: TJsonRegEx): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: TJsonOid): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: TJsonCodeWScope): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.Add(const AValue: TJsonDBRef): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TElements.AddNull: TElements;
begin
  Result := inherited AddNull;
end;

function TJSONCollectionBuilder.TElements.AddUndefined: TElements;
begin
  Result := inherited AddUndefined;
end;

function TJSONCollectionBuilder.TElements.AddMaxKey: TElements;
begin
  Result := inherited AddMaxKey;
end;

function TJSONCollectionBuilder.TElements.AddMinKey: TElements;
begin
  Result := inherited AddMinKey;
end;

function TJSONCollectionBuilder.TElements.AddElements(const AElements: array of const): TElements;
begin
  Result := inherited AddElements(AElements);
end;

function TJSONCollectionBuilder.TElements.AddElements(const ABuilder: TJSONCollectionBuilder): TElements;
begin
  Result := inherited AddElements(ABuilder);
end;

function TJSONCollectionBuilder.TElements.AddElements(const AJSON: string): TElements;
begin
  Result := inherited AddElements(AJSON);
end;

function TJSONCollectionBuilder.TElements.AsRoot: TElements;
begin
  AddingElement;
  Result := Owner.ElementsAsRoot;
end;

function TJSONCollectionBuilder.TElements.BeginArray: TElements;
begin
  Result := inherited BeginArray;
end;

function TJSONCollectionBuilder.TElements.BeginObject: TPairs;
begin
  Result := inherited BeginObject;
end;

function TJSONCollectionBuilder.TElements.EndArray: TParentCollection;
begin
  Result := inherited EndArray;
end;

{ TJSONCollectionBuilder.TPairs }

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: Single): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: Double): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: Extended): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: UInt64): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey,
  AValue: string): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: Int32): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: UInt32): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: Int64): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: TGUID): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: TBytes; ABinaryType: TJsonBinaryType = TJsonBinaryType.Generic): TPairs;
begin
  Result := inherited Add(AKey, AValue, ABinaryType);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: TValue): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: TVarRec): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: Variant): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: TDateTime): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: Boolean): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: Char): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: Byte): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: TJsonRegEx): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: TJsonOid): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: TJsonCodeWScope): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.Add(const AKey: string;
  const AValue: TJsonDBRef): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TPairs.AddNull(const AKey: string): TPairs;
begin
  Result := inherited AddNull(AKey);
end;

function TJSONCollectionBuilder.TPairs.AddUndefined(const AKey: string): TPairs;
begin
  Result := inherited AddUndefined(AKey);
end;

function TJSONCollectionBuilder.TPairs.AddMaxKey(const AKey: string): TPairs;
begin
  Result := inherited AddMaxKey(AKey);
end;

function TJSONCollectionBuilder.TPairs.AddMinKey(const AKey: string): TPairs;
begin
  Result := inherited AddMinKey(AKey);
end;

function TJSONCollectionBuilder.TPairs.AddPairs(const APairs: array of const): TPairs;
begin
  Result := inherited AddPairs(APairs);
end;

function TJSONCollectionBuilder.TPairs.AddPairs(const ABuilder: TJSONCollectionBuilder): TPairs;
begin
  Result := inherited AddPairs(ABuilder);
end;

function TJSONCollectionBuilder.TPairs.AddPairs(const AJSON: string): TPairs;
begin
  Result := inherited AddPairs(AJSON);
end;

function TJSONCollectionBuilder.TPairs.AsRoot: TPairs;
begin
  AddingPair;
  Result := Owner.PairsAsRoot;
end;

function TJSONCollectionBuilder.TPairs.BeginArray(const AKey: string): TElements;
begin
  Result := inherited BeginArray(AKey);
end;

function TJSONCollectionBuilder.TPairs.BeginObject(const AKey: string): TPairs;
begin
  Result := inherited BeginObject(AKey);
end;

function TJSONCollectionBuilder.TPairs.EndObject: TParentCollection;
begin
  Result := inherited EndObject;
end;

{ TJSONCollectionBuilder.TParentCollection }

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: Byte): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: Char): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: Boolean): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: TDateTime): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: TValue): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: TVarRec): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: Variant): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: TBytes;
  ABinaryType: TJsonBinaryType = TJsonBinaryType.Generic): TElements;
begin
  Result := inherited Add(AValue, ABinaryType);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: TGUID): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: Int64): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: Int32): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: UInt32): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: string): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: UInt64): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: Extended): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: Double): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: Single): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: TJsonDBRef): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: TJsonCodeWScope): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: TJsonOid): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AValue: TJsonRegEx): TElements;
begin
  Result := inherited Add(AValue);
end;

function TJSONCollectionBuilder.TParentCollection.AddNull: TElements;
begin
  Result := inherited AddNull;
end;

function TJSONCollectionBuilder.TParentCollection.AddUndefined: TElements;
begin
  Result := inherited AddUndefined;
end;

function TJSONCollectionBuilder.TParentCollection.AddMaxKey: TElements;
begin
  Result := inherited AddMaxKey;
end;

function TJSONCollectionBuilder.TParentCollection.AddMinKey: TElements;
begin
  Result := inherited AddMinKey;
end;

function TJSONCollectionBuilder.TParentCollection.AddElements(const AElements: array of const): TElements;
begin
  Result := inherited AddElements(AElements);
end;

function TJSONCollectionBuilder.TParentCollection.AddElements(const ABuilder: TJSONCollectionBuilder): TElements;
begin
  Result := inherited AddElements(ABuilder);
end;

function TJSONCollectionBuilder.TParentCollection.AddElements(const AJSON: string): TElements;
begin
  Result := inherited AddElements(AJSON);
end;

function TJSONCollectionBuilder.TParentCollection.BeginArray: TElements;
begin
  Result := inherited BeginArray;
end;

function TJSONCollectionBuilder.TParentCollection.BeginObject: TPairs;
begin
  Result := inherited BeginObject;
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey, AValue: string): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  AValue: TDateTime): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  AValue: Byte): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  AValue: Char): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  const AValue: TValue): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  const AValue: TVarRec): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  const AValue: Variant): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  const AValue: TBytes; ABinaryType: TJsonBinaryType = TJsonBinaryType.Generic): TPairs;
begin
  Result := inherited Add(AKey, AValue, ABinaryType);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  const AValue: TGUID): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  AValue: Boolean): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  const AValue: UInt64): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  const AValue: Int64): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  const AValue: Int32): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  const AValue: UInt32): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  AValue: Extended): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  const AValue: Double): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  const AValue: Single): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  const AValue: TJsonDBRef): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  const AValue: TJsonCodeWScope): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  const AValue: TJsonOid): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.Add(const AKey: string;
  const AValue: TJsonRegEx): TPairs;
begin
  Result := inherited Add(AKey, AValue);
end;

function TJSONCollectionBuilder.TParentCollection.AddNull(const AKey: string): TPairs;
begin
  Result := inherited AddNull(AKey);
end;

function TJSONCollectionBuilder.TParentCollection.AddUndefined(const AKey: string): TPairs;
begin
  Result := inherited AddUndefined(AKey);
end;

function TJSONCollectionBuilder.TParentCollection.AddMaxKey(const AKey: string): TPairs;
begin
  Result := inherited AddMaxKey(AKey);
end;

function TJSONCollectionBuilder.TParentCollection.AddMinKey(const AKey: string): TPairs;
begin
  Result := inherited AddMinKey(AKey);
end;

function TJSONCollectionBuilder.TParentCollection.AddPairs(const APairs: array of const): TPairs;
begin
  Result := inherited AddPairs(APairs);
end;

function TJSONCollectionBuilder.TParentCollection.AddPairs(const ABuilder: TJSONCollectionBuilder): TPairs;
begin
  Result := inherited AddPairs(ABuilder);
end;

function TJSONCollectionBuilder.TParentCollection.AddPairs(const AJSON: string): TPairs;
begin
  Result := inherited AddPairs(AJSON);
end;

function TJSONCollectionBuilder.TParentCollection.EndArray: TParentCollection;
begin
  Result := inherited EndArray;
end;

function TJSONCollectionBuilder.TParentCollection.EndObject: TParentCollection;
begin
  Result := inherited EndObject;
end;

function TJSONCollectionBuilder.TParentCollection.AsArray: TElements;
begin
  Result := Owner.AsArray(RootDepth);
end;

function TJSONCollectionBuilder.TParentCollection.AsObject: TPairs;
begin
  Result := Owner.AsObject(RootDepth);
end;

function TJSONCollectionBuilder.TParentCollection.BeginArray(const AKey: string): TElements;
begin
  Result := inherited BeginArray(AKey);
end;

function TJSONCollectionBuilder.TParentCollection.BeginObject(const AKey: string): TPairs;
begin
  Result := inherited BeginObject(AKey);
end;

{ TJSONIterator }

constructor TJSONIterator.Create(AReader: TJsonReader);
begin
  inherited Create;
  FReader := AReader;
  FStack := TObjectStack<TContext>.Create(True);
  FStarting := True;
end;

constructor TJSONIterator.Create(AReader: TJsonReader; ARewindReader: TRewindReaderProc);
begin
  Create(AReader);
  FRewindReader := ARewindReader;
end;

destructor TJSONIterator.Destroy;
begin
  FStack.Free;
  inherited Destroy;
end;

function TJSONIterator.GetInRecurse: Boolean;
begin
  Result := Depth > 0;
end;

function TJSONIterator.GetDepth: Integer;
begin
  Result := FStack.Count;
end;

function TJSONIterator.GetIndex: Integer;
begin
  if (FStack.Count > 0) and (FStack.Peek.FToken = TJsonToken.StartArray) then
    Result := FStack.Peek.FIndex - 1
  else
    Result := -1;
end;

function TJSONIterator.GetParentType: TJsonToken;
begin
  if FStack.Count > 0 then
    Result := FStack.Peek.FToken
  else
    Result := TJsonToken.None;
end;

function TJSONIterator.GetPath: String;
begin
  if FPath = '' then
    FPath := FReader.Path;
  Result := FPath;
end;

procedure TJSONIterator.DoRewindReader(AReader: TJsonReader);
begin
  if not Assigned(FRewindReader) then
    raise EJSONIteratorError.Create(sJSONIteratorNoReaderCallback);
  FRewindReader(AReader);
end;

procedure TJSONIterator.Rewind;
begin
  if FStarting then
    Exit;
  FReader.Rewind;
  DoRewindReader(FReader);
  FStack.Clear;
  FStarting := True;
  FFinished := False;
  FRecursion := False;
  FPath := '';
end;

function TJSONIterator.Next(const AKey: String): Boolean;

  procedure Error;
  begin
    raise EJSONIteratorError.Create(sJSONIteratorInvalidState);
  end;

begin
  FPath := '';
  repeat
    Result := False;
    if FFinished then
      Exit;

    if FReader.IsStartToken(FReader.TokenType) then
      if not FRecursion then
        FReader.Skip
      else
        FStack.Push(TContext.Create(FReader.TokenType));
    FRecursion := False;

    if FReader.Read then
      if FReader.IsEndToken(FReader.TokenType) then
      begin
        if FStack.Count = 0 then
          Error;
        FStack.Pop;
        FFinished := True;
        Result := False;
      end
      else if (FStack.Count > 0) and (FStack.Peek.FToken = TJsonToken.StartArray) then
      begin
        FKey := IntToStr(FStack.Peek.FIndex);
        Inc(FStack.Peek.FIndex);
        FType := FReader.TokenType;
        Result := True;
      end
      else if FReader.IsStartToken(FReader.TokenType) then
      begin
        if FStarting then
        begin
          FStarting := False;
          FRecursion := True;
          Result := Next(AKey);
        end;
      end
      else if FReader.TokenType = TJsonToken.PropertyName then
      begin
        FKey := FReader.Value.AsString;
        FReader.Read;
        FType := FReader.TokenType;
        Result := True;
      end
      else
        Error
    else
      FFinished := True;
  until not Result or FFinished or (AKey = '') or AnsiSameText(AKey, FKey);
end;

function TJSONIterator.Recurse: Boolean;
begin
  if FReader.IsStartToken(FReader.TokenType) then
  begin
    Result := True;
    FRecursion := True;
  end
  else
    Result := False;
end;

procedure TJSONIterator.Return;
var
  LLevel: Integer;
begin
  if not FReader.IsEndToken(FReader.TokenType) then
  begin
    LLevel := FStack.Count;
    if FReader.IsStartToken(FReader.TokenType) and FRecursion then
      Inc(LLevel);
    repeat
      if FReader.IsStartToken(FReader.TokenType) then
        FStack.Push(TContext.Create(FReader.TokenType))
      else if FReader.IsEndToken(FReader.TokenType) then
        FStack.Pop;
    until (FStack.Count < LLevel) or not FReader.Read;
  end;
  FFinished := False;
  FRecursion := False;
end;

function TJSONIterator.Find(const APath: String): Boolean;
var
  LParser: TJSONPathParser;
  LError: Boolean;
  LIndex: Integer;
begin
  Rewind;
  LParser := TJSONPathParser.Create(APath);
  try
    LError := False;
    while (not LParser.IsEof) and (not LError) do
    begin
      case LParser.NextToken of
        TJSONPathParser.TToken.Name:
        begin
          if ParentType <> TJsonToken.None then
            if not ((&Type = TJsonToken.StartObject) and Recurse()) then
              LError := True;
          if not LError then
            LError := not Next(LParser.TokenName);
        end;
        TJSONPathParser.TToken.ArrayIndex:
        begin
          if ParentType <> TJsonToken.None then
            if not ((&Type = TJsonToken.StartArray) and Recurse()) then
              LError := True;
          if not LError then
          begin
            LIndex := 0;
            while (LIndex <= LParser.TokenArrayIndex) and Next() do
              Inc(LIndex);
            LError := LIndex <= LParser.TokenArrayIndex;
          end;
        end;
        TJSONPathParser.TToken.Error:
          LError := True;
      else
        Assert(LParser.Token = TJSONPathParser.TToken.EOF); // case statement is not complete
      end;
    end;

    Result := LParser.IsEof and not LError;
  finally
    LParser.Free;
  end;
end;

procedure TJSONIterator.Iterate(AFunc: TIterateFunc);
begin
  while True do begin
    while Next do
      if &Type in [TJsonToken.StartObject, TJsonToken.StartArray] then
        Recurse
      else if not AFunc(Self) then
        Exit;
    if InRecurse then
      Return
    else
      Break;
  end;
end;

function TJSONIterator.GetAsBoolean: Boolean;
begin
  Result := FReader.Value.AsBoolean;
end;

function TJSONIterator.GetAsBytes: TBytes;
begin
  Result := FReader.Value.AsType<TBytes>;
end;

function TJSONIterator.GetAsCodeWScope: TJsonCodeWScope;
begin
  Result := FReader.Value.AsType<TJsonCodeWScope>;
end;

function TJSONIterator.GetAsDateTime: TDateTime;
begin
  Result := FReader.Value.AsType<TDateTime>;
end;

function TJSONIterator.GetAsDBRef: TJsonDBRef;
begin
  Result := FReader.Value.AsType<TJsonDBRef>;
end;

function TJSONIterator.GetAsExtended: Extended;
begin
  Result := FReader.Value.AsExtended;
end;

function TJSONIterator.GetAsDouble: Double;
begin
  Result := FReader.Value.AsExtended;
end;

function TJSONIterator.GetAsGUID: TGUID;
begin
  Result := FReader.Value.AsType<TGUID>;
end;

function TJSONIterator.GetAsInteger: Int32;
begin
  Result := FReader.Value.AsInteger;
end;

function TJSONIterator.GetAsInt64: Int64;
begin
  Result := FReader.Value.AsInt64;
end;

function TJSONIterator.GetAsOid: TJsonOid;
begin
  if FReader.Value.IsType<TJsonOid> then
    Result := FReader.Value.AsType<TJsonOid>
  else
    Result.AsBytes := FReader.Value.AsType<TBytes>;
end;

function TJSONIterator.GetAsRegEx: TJsonRegEx;
begin
  Result := FReader.Value.AsType<TJsonRegEx>;
end;

function TJSONIterator.GetAsString: String;
begin
  Result := FReader.Value.AsString;
end;

function TJSONIterator.GetAsValue: TValue;
begin
  Result := FReader.Value;
end;

function TJSONIterator.GetAsVariant: Variant;
begin
  Result := FReader.Value.AsVariant;
end;

function TJSONIterator.GetIsMaxKey: Boolean;
begin
  Result := FReader.TokenType = TJsonToken.MaxKey;
end;

function TJSONIterator.GetIsMinKey: Boolean;
begin
  Result := FReader.TokenType = TJsonToken.MinKey;
end;

function TJSONIterator.GetIsNull: Boolean;
begin
  Result := FReader.TokenType = TJsonToken.Null;
end;

function TJSONIterator.GetIsUndefined: Boolean;
begin
  Result := FReader.TokenType = TJsonToken.Undefined;
end;

{ TJSONIterator.TContext }

constructor TJSONIterator.TContext.Create(AToken: TJsonToken);
begin
  inherited Create;
  FToken := AToken;
end;

end.

