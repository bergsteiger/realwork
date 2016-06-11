{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{         FireDAC MongoDB API wrapping classes          }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$SCOPEDENUMS ON}

                  
                                                                           
                                         
                                                        
                              
                                              
                                                                  
                                                      
                                            
                                                                                 
                                                           
                                                                       
                                                                                   
                           
                                                                      
                                                             
                        
                                 
                                              
                                                 
                                                     
                
                                             
 

unit FireDAC.Phys.MongoDBWrapper;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.Rtti,
    System.JSON.Types, System.JSON.Readers, System.JSON.Writers,
    System.JSON.BSON, System.JSON.Builders,
  FireDAC.Stan.Intf, FireDAC.Stan.Error, FireDAC.Stan.Util,
  FireDAC.Phys.MongoDBCli;

type
  TMongoClientLib = class;
  TMongoBSONLib = class;
  TMongoObject = class;
  TFDMongoError = class;
  EMongoNativeException = class;
  TMongoError = class;
  TMongoEnv = class;
  TMongoOID = class;
  TMongoDocument = class;
  TMongoReadPreference = class;
  TMongoWriteConcern = class;
  TMongoExpression<T: class> = class;
  IMongoCursor = interface;
  TMongoPipeline = class;
  TMongoQuery = class;
  TMongoCommand = class;
  TMongoUpdate = class;
  TMongoSelector = class;
  TMongoInsert = class;
  TMongoIndex = class;
  TMongoCursor = class;
  TMongoConnection = class;
  TMongoDatabase = class;
  TMongoCollection = class;

  /// <summary> The MongoDB query flags. </summary>
  TMongoQueryFlag = (TailableCursors, SlaveOk, NoCursorTimeout, AwaitData, Exhaust, Partial);
  TMongoQueryFlags = set of TMongoQueryFlag;

  /// <summary> Loads the libmongoc-xxx dynamic library and obtains MongoDB API
  ///  entry points. </summary>
  TMongoClientLib = class(TFDLibrary)
  protected
    procedure LoadEntries; override;

  public
    // mongoc.h
    Fmongoc_client_new: Tmongoc_client_new;
    Fmongoc_client_destroy: Tmongoc_client_destroy;
    Fmongoc_client_command: Tmongoc_client_command;
    Fmongoc_client_command_simple: Tmongoc_client_command_simple;
    Fmongoc_client_kill_cursor: Tmongoc_client_kill_cursor;
    Fmongoc_client_get_database: Tmongoc_client_get_database;
    Fmongoc_client_get_collection: Tmongoc_client_get_collection;
    Fmongoc_client_find_databases: Tmongoc_client_find_databases;
    Fmongoc_client_get_server_status: Tmongoc_client_get_server_status;
    Fmongoc_client_get_max_message_size: Tmongoc_client_get_max_message_size;
    Fmongoc_client_get_max_bson_size: Tmongoc_client_get_max_bson_size;
    Fmongoc_client_get_write_concern: Tmongoc_client_get_write_concern;
    Fmongoc_client_set_write_concern: Tmongoc_client_set_write_concern;
    Fmongoc_client_get_read_prefs: Tmongoc_client_get_read_prefs;
    Fmongoc_client_set_read_prefs: Tmongoc_client_set_read_prefs;
    Fmongoc_client_set_ssl_opts: Tmongoc_client_set_ssl_opts;
    Fmongoc_client_get_uri: Tmongoc_client_get_uri;

    // mongoc-uri.h
    Fmongoc_uri_get_string: Tmongoc_uri_get_string;

    // mongoc-bulk-operation.h
    Fmongoc_bulk_operation_new: Tmongoc_bulk_operation_new;
    Fmongoc_bulk_operation_destroy: Tmongoc_bulk_operation_destroy;
    Fmongoc_bulk_operation_execute: Tmongoc_bulk_operation_execute;
    Fmongoc_bulk_operation_insert: Tmongoc_bulk_operation_insert;
    Fmongoc_bulk_operation_remove: Tmongoc_bulk_operation_remove;
    Fmongoc_bulk_operation_remove_one: Tmongoc_bulk_operation_remove_one;
    Fmongoc_bulk_operation_replace_one: Tmongoc_bulk_operation_replace_one;
    Fmongoc_bulk_operation_update: Tmongoc_bulk_operation_update;
    Fmongoc_bulk_operation_update_one: Tmongoc_bulk_operation_update_one;

    // mongoc-collection.h
    Fmongoc_collection_aggregate: Tmongoc_collection_aggregate;
    Fmongoc_collection_destroy: Tmongoc_collection_destroy;
    Fmongoc_collection_command: Tmongoc_collection_command;
    Fmongoc_collection_command_simple: Tmongoc_collection_command_simple;
    Fmongoc_collection_count: Tmongoc_collection_count;
    Fmongoc_collection_count_with_opts: Tmongoc_collection_count_with_opts;
    Fmongoc_collection_drop: Tmongoc_collection_drop;
    Fmongoc_collection_drop_index: Tmongoc_collection_drop_index;
    Fmongoc_collection_create_index: Tmongoc_collection_create_index;
    Fmongoc_collection_find_indexes: Tmongoc_collection_find_indexes;
    Fmongoc_collection_find: Tmongoc_collection_find;
    Fmongoc_collection_insert: Tmongoc_collection_insert;
    Fmongoc_collection_update: Tmongoc_collection_update;
    Fmongoc_collection_save: Tmongoc_collection_save;
    Fmongoc_collection_remove: Tmongoc_collection_remove;
    Fmongoc_collection_rename: Tmongoc_collection_rename;
    Fmongoc_collection_find_and_modify: Tmongoc_collection_find_and_modify;
    Fmongoc_collection_stats: Tmongoc_collection_stats;
    Fmongoc_collection_create_bulk_operation: Tmongoc_collection_create_bulk_operation;
    Fmongoc_collection_get_read_prefs: Tmongoc_collection_get_read_prefs;
    Fmongoc_collection_set_read_prefs: Tmongoc_collection_set_read_prefs;
    Fmongoc_collection_get_write_concern: Tmongoc_collection_get_write_concern;
    Fmongoc_collection_set_write_concern: Tmongoc_collection_set_write_concern;
    Fmongoc_collection_get_name: Tmongoc_collection_get_name;
    Fmongoc_collection_get_last_error: Tmongoc_collection_get_last_error;
    Fmongoc_collection_validate: Tmongoc_collection_validate;

    // mongoc-cursor.h
    Fmongoc_cursor_destroy: Tmongoc_cursor_destroy;
    Fmongoc_cursor_more: Tmongoc_cursor_more;
    Fmongoc_cursor_next: Tmongoc_cursor_next;
    Fmongoc_cursor_error: Tmongoc_cursor_error;
    Fmongoc_cursor_current: Tmongoc_cursor_current;
    Fmongoc_cursor_is_alive: Tmongoc_cursor_is_alive;

    // mongoc-database.h
    Fmongoc_database_get_name: Tmongoc_database_get_name;
    Fmongoc_database_remove_user: Tmongoc_database_remove_user;
    Fmongoc_database_remove_all_users: Tmongoc_database_remove_all_users;
    Fmongoc_database_add_user: Tmongoc_database_add_user;
    Fmongoc_database_destroy: Tmongoc_database_destroy;
    Fmongoc_database_command: Tmongoc_database_command;
    Fmongoc_database_command_simple: Tmongoc_database_command_simple;
    Fmongoc_database_drop: Tmongoc_database_drop;
    Fmongoc_database_has_collection: Tmongoc_database_has_collection;
    Fmongoc_database_create_collection: Tmongoc_database_create_collection;
    Fmongoc_database_get_read_prefs: Tmongoc_database_get_read_prefs;
    Fmongoc_database_set_read_prefs: Tmongoc_database_set_read_prefs;
    Fmongoc_database_get_write_concern: Tmongoc_database_get_write_concern;
    Fmongoc_database_set_write_concern: Tmongoc_database_set_write_concern;
    Fmongoc_database_find_collections: Tmongoc_database_find_collections;
    Fmongoc_database_get_collection: Tmongoc_database_get_collection;

    // mongoc-index.h
    Fmongoc_index_opt_get_default: Tmongoc_index_opt_get_default;
    Fmongoc_index_opt_init: Tmongoc_index_opt_init;

    // mongoc-init.h
    Fmongoc_init: Tmongoc_init;
    Fmongoc_cleanup: Tmongoc_cleanup;

    // mongoc-log.h
    Fmongoc_log_set_handler: Tmongoc_log_set_handler;
    Fmongoc_log_default_handler: Tmongoc_log_default_handler;
    Fmongoc_log_level_str: Tmongoc_log_level_str;

    // mongoc-matcher.h
    Fmongoc_matcher_new: Tmongoc_matcher_new;
    Fmongoc_matcher_match: Tmongoc_matcher_match;
    Fmongoc_matcher_destroy: Tmongoc_matcher_destroy;

    // mongoc-read-prefs.h
    Fmongoc_read_prefs_new: Tmongoc_read_prefs_new;
    Fmongoc_read_prefs_destroy: Tmongoc_read_prefs_destroy;
    Fmongoc_read_prefs_copy: Tmongoc_read_prefs_copy;
    Fmongoc_read_prefs_get_mode: Tmongoc_read_prefs_get_mode;
    Fmongoc_read_prefs_set_mode: Tmongoc_read_prefs_set_mode;
    Fmongoc_read_prefs_get_tags: Tmongoc_read_prefs_get_tags;
    Fmongoc_read_prefs_set_tags: Tmongoc_read_prefs_set_tags;
    Fmongoc_read_prefs_add_tag: Tmongoc_read_prefs_add_tag;
    Fmongoc_read_prefs_is_valid: Tmongoc_read_prefs_is_valid;

    // mongoc-write-concern.h
    Fmongoc_write_concern_new: Tmongoc_write_concern_new;
    Fmongoc_write_concern_destroy: Tmongoc_write_concern_destroy;
    Fmongoc_write_concern_copy: Tmongoc_write_concern_copy;
    Fmongoc_write_concern_get_fsync: Tmongoc_write_concern_get_fsync;
    Fmongoc_write_concern_set_fsync: Tmongoc_write_concern_set_fsync;
    Fmongoc_write_concern_get_journal: Tmongoc_write_concern_get_journal;
    Fmongoc_write_concern_set_journal: Tmongoc_write_concern_set_journal;
    Fmongoc_write_concern_get_w: Tmongoc_write_concern_get_w;
    Fmongoc_write_concern_set_w: Tmongoc_write_concern_set_w;
    Fmongoc_write_concern_get_wtag: Tmongoc_write_concern_get_wtag;
    Fmongoc_write_concern_set_wtag: Tmongoc_write_concern_set_wtag;
    Fmongoc_write_concern_get_wtimeout: Tmongoc_write_concern_get_wtimeout;
    Fmongoc_write_concern_set_wtimeout: Tmongoc_write_concern_set_wtimeout;
    Fmongoc_write_concern_get_wmajority: Tmongoc_write_concern_get_wmajority;
    Fmongoc_write_concern_set_wmajority: Tmongoc_write_concern_set_wmajority;

    constructor Create(AOwningObj: TObject = nil);
    /// <summary> Loads libmongoc-xxx dynamic library. Arguments are optional
    ///  and mutually exclusive:
    ///  * AVendorHome - specifies vendor home, which is parent MongoDB
    ///    installation folder;
    ///  * AVendorLib - path and name to the libmongoc-xxx dynamic library. </summary>
    procedure Load(const AVendorHome, AVendorLib: String);
  end;

  /// <summary> Loads the libbson-xxx dynamic library and obtains BSON API entry
  /// points. libbson-xxx must be loaded before libmongoc-xxx. </summary>
  TMongoBSONLib = class(TFDLibrary)
  private
    [weak] FCLib: TMongoClientLib;
  protected
    procedure LoadEntries; override;

  public
    // bson-context.h
    Fbson_context_new: Tbson_context_new;
    Fbson_context_destroy: Tbson_context_destroy;
    Fbson_context_get_default: Tbson_context_get_default;

    // bson-oid.h
    Fbson_oid_compare: Tbson_oid_compare;
    Fbson_oid_copy: Tbson_oid_copy;
    Fbson_oid_init: Tbson_oid_init;
    Fbson_oid_init_from_string: Tbson_oid_init_from_string;
    Fbson_oid_to_string: Tbson_oid_to_string;
    Fbson_oid_get_time_t: Tbson_oid_get_time_t;

    // bson.h
    Fbson_mem_set_vtable: Tbson_mem_set_vtable;
    Fbson_init: Tbson_init;
    Fbson_init_static: Tbson_init_static;
    Fbson_reinit: Tbson_reinit;
    Fbson_new: Tbson_new;
    Fbson_destroy: Tbson_destroy;
    Fbson_get_data: Tbson_get_data;
    Fbson_free: Tbson_free;
    Fbson_init_from_json: Tbson_init_from_json;
    Fbson_as_json: Tbson_as_json;
    Fbson_copy_to: Tbson_copy_to;
    Fbson_concat: Tbson_concat;
    Fbson_append_array: Tbson_append_array;
    Fbson_append_document: Tbson_append_document;
    Fbson_append_bool: Tbson_append_bool;
    Fbson_append_code: Tbson_append_code;
    Fbson_append_code_with_scope: Tbson_append_code_with_scope;
    Fbson_append_double: Tbson_append_double;
    Fbson_append_int32: Tbson_append_int32;
    Fbson_append_int64: Tbson_append_int64;
    Fbson_append_null: Tbson_append_null;
    Fbson_append_oid: Tbson_append_oid;
    Fbson_append_regex: Tbson_append_regex;
    Fbson_append_utf8: Tbson_append_utf8;
    Fbson_append_time_t: Tbson_append_time_t;
    Fbson_append_timeval: Tbson_append_timeval;
    Fbson_append_date_time: Tbson_append_date_time;
    Fbson_append_binary: Tbson_append_binary;

    // bson-iter.h
    Fbson_iter_init: Tbson_iter_init;
    Fbson_iter_find: Tbson_iter_find;
    Fbson_iter_find_descendant: Tbson_iter_find_descendant;
    Fbson_iter_next: Tbson_iter_next;
    Fbson_iter_recurse: Tbson_iter_recurse;
    Fbson_iter_key: Tbson_iter_key;
    Fbson_iter_type: Tbson_iter_type;
    Fbson_iter_binary: Tbson_iter_binary;
    Fbson_iter_bool: Tbson_iter_bool;
    Fbson_iter_code: Tbson_iter_code;
    Fbson_iter_double: Tbson_iter_double;
    Fbson_iter_int32: Tbson_iter_int32;
    Fbson_iter_int64: Tbson_iter_int64;
    Fbson_iter_oid: Tbson_iter_oid;
    Fbson_iter_regex: Tbson_iter_regex;
    Fbson_iter_utf8: Tbson_iter_utf8;
    Fbson_iter_time_t: Tbson_iter_time_t;
    Fbson_iter_date_time: Tbson_iter_date_time;

    constructor Create(ACLib: TMongoClientLib);
    /// <summary> Loads libbson-xxx dynamic library. It will be loaded from the
    ///  same folder where libmongoc-xxx resides. </summary>
    procedure Load;
    /// <summary> Unloads libbson-xxx dynamic library. </summary>
    procedure Unload; override;
    /// <summary> Returns a reference to assocciated libmongoc-xxx dynamic library. </summary>
    property CLib: TMongoClientLib read FCLib;
  end;

  /// <summary> A base class for all MongoDB API wrapping classes. This is an
  ///  abstract class, responsible for live cycle of an API handle. And it
  ///  provides references to client libraries, environment and error objects. </summary>
  TMongoObject = class abstract(TObject)
  private
    FEnv: TMongoEnv;
    FHandle: Pmongoc_handle_t;
    FOwnHandle: Boolean;
    [weak] FOwningObj: TObject;
    function GetHandle: Pmongoc_handle_t;
    procedure SetHandle(const AValue: Pmongoc_handle_t);
    function GetError: TMongoError; inline;
    function GetCLib: TMongoClientLib; inline;
    function GetBLib: TMongoBSONLib; inline;
  protected
    /// <summary> Descendant classes override this method to release MongoDB API handle. </summary>
    procedure InternalFreeHandle; virtual;
    /// <summary> FreeHandle method clears existing handle, optionally releasing
    ///  API handle, when it is owned by this object. </summary>
    procedure FreeHandle; virtual;
    /// <summary> Descendant classes override this method to provide additional
    ///  API handle setup. It is called right after the API handle is allocated. </summary>
    procedure HandleAllocated; virtual;
    /// <summary> Creates new object and assigns references to environment and
    ///  owning objects. </summary>
    constructor Create(AEnv: TMongoEnv; AOwningObj: TObject); overload;
    /// <summary> Creates new object, assigns references to environment and
    ///  owning objects, and sets the MongoDB API handle which will be owned
    ///  by this object. </summary>
    constructor Create(AEnv: TMongoEnv; AOwningObj: TObject; AHandle: Pmongoc_handle_t); overload;
  public
    destructor Destroy; override;
    /// <summary> Returns reference to environment object. </summary>
    property Env: TMongoEnv read FEnv;
    /// <summary> Returns reference to MongoDB C driver library object. Shortcut to Env.CLib. </summary>
    property CLib: TMongoClientLib read GetCLib;
    /// <summary> Returns reference to BSON library object. Shortcut to Env.BLib. </summary>
    property BLib: TMongoBSONLib read GetBLib;
    /// <summary> Returns reference to error handling object. Shortcut to Env.Error. </summary>
    property Error: TMongoError read GetError;
    /// <summary> Returns reference to an object owning this object. </summary>
    property OwningObj: TObject read FOwningObj;
    /// <summary> Allows to get / set MongoDB API handle. Descendant classes
    ///  assign FHandle private variable directly. When Handle is set to
    ///  a not nil value, then the handle must be released by the setter. </summary>
    property Handle: Pmongoc_handle_t read GetHandle write SetHandle;
  end;

  /// <summary> An error item, keeping specific MongoDB error information. At
  ///  moment it is only Domain property. </summary>
  TFDMongoError = class(TFDDBError)
  private
    FDomain: Cardinal;
  protected
    procedure Assign(ASrc: TFDDBError); override;
    procedure LoadFromStorage(const AStorage: IFDStanStorage); override;
    procedure SaveToStorage(const AStorage: IFDStanStorage); override;
  public
    /// <summary> Returns MongoDB error domain code. </summary>
    property Domain: Cardinal read FDomain;
  end;

  /// <summary> An exception object, specific to MongoDB. The EMongoNativeException
  ///  constructor knows how to get required information from the TMongoError. </summary>
  EMongoNativeException = class(EFDDBEngineException)
  private
    function GetErrors(AIndex: Integer): TFDMongoError; inline;
  protected
    function GetErrorClass: TFDDBErrorClass; override;
    function AppendError(ALevel, AErrorCode: Integer; ADomain: Cardinal;
      const AMessage: String; ARowIndex: Integer): TFDMongoError; overload;
  public
    constructor Create(AError: TMongoError); overload;
    /// <summary> Returns MongoDB error item by index. </summary>
    property Errors[AIndex: Integer]: TFDMongoError read GetErrors; default;
  end;

  /// <summary> Incapsulates MongoDB bson_error_t structure, required to handle
  ///  server errors. The CheckError method verifies the structure state and
  ///  if required raises EMongoNativeException exception. </summary>
  TMongoError = class(TMongoObject)
  private
    FBError: bson_error_t;
  public
    /// <summary> When AMethod value is specified, then raises EMongoNativeException
    ///  exception unconditionally with AMethod name in exception message. When
    ///  AMethod is not specified, then checks bson_error_t structure and if it has
    ///  an error, then corresponding EMongoNativeException is raised. </summary>
    procedure CheckError(AInitiator: TObject = nil; const AMethod: String = '');
    /// <summary> Returns MongoDB API error structure. </summary>
    property BError: bson_error_t read FBError;
  end;

  /// <summary> The service object grouping together references to the client
  ///  libraries, error handling object, character set encoders, tracer, etc.
  ///  Application should create at least one TMongoEnv object. A single
  ///  TMongoEnv object and all other objects sharing the same TMongoEnv object
  ///  must be used by a single thread in each moment of time. </summary>
  TMongoEnv = class(TObject)
  private
    FCLib: TMongoClientLib;
    FBLib: TMongoBSONLib;
    FError: TMongoError;
    FBuffer: TFDBuffer;
    FANSI: TFDEncoder;
    FUTF8: TFDEncoder;
    [weak] FOwningObj: TObject;
{$IFDEF FireDAC_MONITOR}
    FMonitor: IFDMoniClient;
    FTracing: Boolean;
    function GetTracing: Boolean;
{$ENDIF}
  public
    /// <summary> Creates MongoDB environment object. The ACLib and ABLib parameters
    ///  are mandatory. </summary>
    constructor Create(ACLib: TMongoClientLib; ABLib: TMongoBSONLib; AOwningObj: TObject);
    destructor Destroy; override;
    /// <summary> Creates new instance of MongoDB document. </summary>
    function NewDoc: TMongoDocument;
{$IFDEF FireDAC_MONITOR}
    procedure Trace(const AMsg: String; const AArgs: array of const); overload;
    procedure Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
      const AMsg: String; const AArgs: array of const); overload;
    property Tracing: Boolean read GetTracing write FTracing;
    property Monitor: IFDMoniClient read FMonitor write FMonitor;
{$ENDIF}
    /// <summary> Returns reference to MongoDB C driver library object. </summary>
    property CLib: TMongoClientLib read FCLib;
    /// <summary> Returns reference to BSON library object. </summary>
    property BLib: TMongoBSONLib read FBLib;
    /// <summary> Returns reference to error handling object. </summary>
    property Error: TMongoError read FError;
    /// <summary> Returns reference to ANSI to UCS2 encoder. </summary>
    property ANSI: TFDEncoder read FANSI;
    /// <summary> Returns reference to UTF8 to UCS2 encoder. </summary>
    property UTF8: TFDEncoder read FUTF8;
    /// <summary> Returns reference to dynamic buffer. </summary>
    property Buffer: TFDBuffer read FBuffer;
    /// <summary> Returns reference to owning object. </summary>
    property OwningObj: TObject read FOwningObj;
  end;

  /// <summary> Incapsulates MongoDB bson_oid_t structure, representing OID,
  ///  which is equivalent to TJsonOid. </summary>
  TMongoOID = class(TMongoObject)
  private
    function GetAsDateTime: TDateTime;
    function GetAsString: String;
    procedure SetAsString(const AValue: String);
    function GetAsOid: TJsonOid; inline;
    procedure SetAsOid(const AValue: TJsonOid); inline;
  protected
    procedure InternalFreeHandle; override;
  public
    /// <summary> Creates new MongoDB API OID wrapping object. </summary>
    constructor Create(AEnv: TMongoEnv; AOwningObj: TObject);
    /// <summary> Initialize by new semi-random value. </summary>
    procedure Init;
    /// <summary> Erases the OID by setting it to sequence of zero bytes. </summary>
    procedure Clear;
    /// <summary> Assigns another OID object to this object. </summary>
    procedure Assign(ASource: TMongoOID);
    /// <summary> Returns date part of OID value. </summary>
    property AsDateTime: TDateTime read GetAsDateTime;
    /// <summary> Gets / sets OID value using hexadecimal representation. </summary>
    property AsString: String read GetAsString write SetAsString;
    /// <summary> Gets / set OID value using TJsonOID representation. </summary>
    property AsOid: TJsonOid read GetAsOid write SetAsOid;
  end;

  /// <summary> Incapsulates MongoDB bson_t structure. This is the key entity in
  ///  MongoDB API, responsible for data exchange, building queries, processing
  ///  errors, etc. The MongoDB API is all around bson_t. TMongoDocument provides
  ///  several sub-API's:
  ///  * Builder property returns reference to TJSONObjectBuilder BSON builder;
  ///  * Iterator function returns reference to TJSONIterator BSON iterator;
  ///  * several Add, Append, etc methods provide simplified access to the builder. </summary>
  TMongoDocument = class(TMongoObject)
  private type
    THandleType = (ReadInternal, ReadExternal, WriteExternal, RTL);

    TBuilder = class sealed(TJSONObjectBuilder)
    private
      [weak] FDoc: TMongoDocument;
    protected
      procedure DoResetWriter(AWriter: TJsonWriter); override;
      function DoGetReader(AWriter: TJsonWriter): TJsonReader; override;
      procedure DoReleaseReader(AWriter: TJsonWriter; AReader: TJsonReader); override;
      procedure DoWriteCustomVariant(AWriter: TJsonWriter; const AValue: Variant); override;
    public
      constructor Create(const AJSONWriter: TJSONWriter; ADoc: TMongoDocument);
    end;

    TIterator = class sealed(TJSONIterator)
    private
      FStream: TMemoryStream;
      FReader: TBsonReader;
    protected
      procedure DoRewindReader(AReader: TJsonReader); override;
    public
      constructor Create(ADoc: TMongoDocument);
      destructor Destroy; override;
    end;

  private
    [weak] FParentObj: TObject;
    FStream: TMemoryStream;
    FWriter: TBsonWriter;
    FBuilder: TJSONObjectBuilder;
    FHandleType: THandleType;
    procedure ErrorReadOnly;
    procedure Cleanup(AClearBuilder: Boolean);
    procedure AttachToImpl(const AValue: Pbson_t);
    procedure CheckClosed;
    function GetAsReadHandle: Pbson_t;
    procedure SetAsReadHandle(const AValue: Pbson_t);
    function GetAsWriteHandle: Pbson_t;
    function GetAsJSON: String;
    procedure SetAsJSON(const AValue: String);
    function GetInObject: Boolean; inline;
    function GetPairs: TJSONCollectionBuilder.TPairs; inline;
    function GetInArray: Boolean; inline;
    function GetElements: TJSONCollectionBuilder.TElements; inline;
    function GetBuilder: TJSONObjectBuilder;
  protected
    /// <summary> Release handle and other resource of this document. </summary>
    procedure InternalFreeHandle; override;
    /// <summary> Creates new empty MongoDB BSON document. Used internaly. </summary>
    constructor Create(AEnv: TMongoEnv; AOwningObj, AParentObj: TObject); overload;
    /// <summary> Returns reference to the current document builder object pairs object. </summary>
    property Pairs: TJSONCollectionBuilder.TPairs read GetPairs;
    /// <summary> Returns reference to the current document builder array elements object. </summary>
    property Elements: TJSONCollectionBuilder.TElements read GetElements;
  public
    /// <summary> Creates new empty MongoDB BSON document. AEnv specifies MongoDB
    ///  API environment object, which is mandatory argument. </summary>
    constructor Create(AEnv: TMongoEnv); overload;
    destructor Destroy; override;
    // writing
    /// <summary> Assigns content of ASource document to this document. </summary>
    procedure Assign(ASource: TMongoDocument);
    /// <summary> Clears content of this document and returns reference to
    ///  this object. </summary>
    function Clear: TMongoDocument;
    /// <summary> Closes open and unclosed nested objects and arrays. </summary>
    procedure Close;
    /// <summary> Adds an object key-value pair or array item of String type.
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function Add(const AKey: String; const AValue: String): TMongoDocument; overload;
    /// <summary> Adds an object key-value pair or array item of Int32 type.
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function Add(const AKey: String; const AValue: Int32): TMongoDocument; overload;
    /// <summary> Adds an object key-value pair or array item of Int64 type.
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function Add(const AKey: String; const AValue: Int64): TMongoDocument; overload;
    /// <summary> Adds an object key-value pair or array item of Extended type.
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function Add(const AKey: String; const AValue: Extended): TMongoDocument; overload;
    /// <summary> Adds an object key-value pair or array item of Boolean type.
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function Add(const AKey: String; const AValue: Boolean): TMongoDocument; overload;
    /// <summary> Adds an object key-value pair or array item of TDateTime type.
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function Add(const AKey: String; const AValue: TDateTime): TMongoDocument; overload;
    /// <summary> Adds an object key-value pair or array item of TBytes type.
    ///  Optionally ABinaryType may be specified, which corresponds to BSON
    ///  binary subtypes. For arrays the AKey value is ignored. Returns reference
    ///  to this object. </summary>
    function Add(const AKey: String; const AValue: TBytes;
      ABinaryType: TJsonBinaryType = TJsonBinaryType.Generic): TMongoDocument; overload;
    /// <summary> Adds an object key-value pair or array item of TMongoOID type.
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function Add(const AKey: String; const AValue: TMongoOID): TMongoDocument; overload;
    /// <summary> Adds an object key-value pair or array item of TJsonOid type.
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function Add(const AKey: String; const AValue: TJsonOid): TMongoDocument; overload;
    /// <summary> Adds an object key-value pair or array item of TJsonRegEx type.
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function Add(const AKey: string; const AValue: TJsonRegEx): TMongoDocument; overload;
    /// <summary> Adds an object key-value pair or array item of TJsonDBRef type.
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function Add(const AKey: string; const AValue: TJsonDBRef): TMongoDocument; overload;
    /// <summary> Adds an object key-value pair or array item of TJsonCodeWScope type.
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function Add(const AKey: string; const AValue: TJsonCodeWScope): TMongoDocument; overload;
    /// <summary> Adds an object key-value pair or array item of TVarRec type.
    ///  This method is usefull when processing open array values.
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function Add(const AKey: String; const AValue: TVarRec): TMongoDocument; overload;
    /// <summary> Adds a nested array using AValues open array as the array items.
    ///  The open array represents a "parsed" JSON. To add:
    ///  * a key value pair, first must be specified key name, followed by value;
    ///  * an array item, just a value must be specified;
    ///  * a nested object, its key-value pairs must be surrounded by '{' and '};
    ///  * a nested array, its key-value pairs must be surrounded by '[' and ']'.
    /// For example:
    ///  * Add('coords', [123.45, 80.90])
    ///     -> "coords": [123.45, 80.90]
    ///  * Add('grades', ['{', 'grade', 'A', 'score', 11, '}', '{', 'grade', 'B', 'score', 17, '}'])
    ///     -> "grades": [{"grade": "A", "score": 11}, {"grade": "B", "score": 17}]
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function Add(const AKey: String; const AValues: array of const): TMongoDocument; overload;
    /// <summary> Adds an object key-value pair or array item of a type represented
    ///  by the Variant data type. For arrays the AKey value is ignored. Returns
    ///  reference to this object. </summary>
    function Add(const AKey: String; const AValue: Variant): TMongoDocument; overload;
    /// <summary> Adds an object key-value pair or array item of Null type.
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function AddNull(const AKey: String): TMongoDocument;
    /// <summary> Adds an object key-value pair or array item of Undefined type.
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function AddUndefined(const AKey: String): TMongoDocument;
    /// <summary> Adds an object key-value pair or array item of MinKey type.
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function AddMinKey(const AKey: String): TMongoDocument;
    /// <summary> Adds an object key-value pair or array item of MaxKey type.
    ///  For arrays the AKey value is ignored. Returns reference to this object. </summary>
    function AddMaxKey(const AKey: String): TMongoDocument;
    /// <summary> Open a new nested array. For parent arrays the AKey value is
    ///  ignored. Returns reference to this object. </summary>
    function BeginArray(const AKey: String): TMongoDocument;
    /// <summary> Closes a nested array. Returns reference to this object. </summary>
    function EndArray: TMongoDocument;
    /// <summary> Open a new nested object. For parent arrays the AKey value is
    ///  ignored. Returns reference to this object. </summary>
    function BeginObject(const AKey: String): TMongoDocument;
    /// <summary> Closes a nested object. Returns reference to this object. </summary>
    function EndObject: TMongoDocument;
    /// <summary> Appends the content of ADoc document to the end of this document.
    ///  Returns reference to this object. </summary>
    function Append(const ADoc: TMongoDocument): TMongoDocument; overload;
    /// <summary> Appends the content of AJSON document to the end of this document.
    ///  Returns reference to this object. </summary>
    function Append(const AJSON: String): TMongoDocument; overload;
    /// <summary> Appends an open array representing a "parsed" JSON to the end
    ///  of this document. To add:
    ///  * a key value pair, first must be specified key name, followed by value;
    ///  * an array item, just a value must be specified;
    ///  * a nested object, its key-value pairs must be surrounded by '{' and '};
    ///  * a nested array, its key-value pairs must be surrounded by '[' and ']'.
    ///  For example:
    ///  * Append(['coords', '[', 123.45, 80.90, ']'])
    ///     -> appends: "coords": [123.45, 80.90]
    ///  * Append(['grades', '[', '{', 'grade', 'A', 'score', 11, '}', '{', 'grade', 'B', 'score', 17, '}', ']'])
    ///     -> appends: "grades": [{"grade": "A", "score": 11}, {"grade": "B", "score": 17}]
    ///  Returns reference to this object. </summary>
    function Append(const AItems: array of const): TMongoDocument; overload;
    // R/O
    /// <summary> Returns True when the current document level belongs to
    ///  opened nested array. </summary>
    property InArray: Boolean read GetInArray;
    /// <summary> Returns True when the current document level belongs to
    ///  opened nested object. </summary>
    property InObject: Boolean read GetInObject;
    /// <summary> Returns reference to JSON builder. The builder object is
    ///  owned by this document object. </summary>
    property Builder: TJSONObjectBuilder read GetBuilder;
    /// <summary> Creates and returns reference to JSON iterator. The caller
    ///  should free the iterator object after usage. </summary>
    function Iterator: TJSONIterator;
    /// <summary> Iterates through all document elements and calls AFunc
    ///  for each element. As argument AFunc receives reference to iterator,
    ///  pointing to current document element. When AFunc returns True, then
    ///  the method continues iterating. When False, then stops immediately. </summary>
    procedure Iterate(AFunc: TJSONIterator.TIterateFunc);
    // R/W
    /// <summary> Gets/sets the content of this document as an JSON string. </summary>
    property AsJSON: String read GetAsJSON write SetAsJSON;
    /// <summary> Gets BSON API document handle, which will be read only
    ///  by MongoDB/BSON API. Or set BSON API document handle, which will
    ///  be read only by this object interface. </summary>
    property AsReadHandle: Pbson_t read GetAsReadHandle write SetAsReadHandle;
    /// <summary> Gets BSON API document handle, which will be filled by
    ///  MongoDB/BSON API. After that this document may be read using this
    ///  object interface. </summary>
    property AsWriteHandle: Pbson_t read GetAsWriteHandle;
  end;

  /// <summary> Incapsulates MongoDB mongoc_read_prefs_t structure, representing
  ///  MongoDB API read preferences. All other MongoDB API wrapping classes provide
  ///  access to objects representing default read preferences.
  ///  More: http://docs.mongodb.org/master/core/read-preference/ </summary>
  TMongoReadPreference = class(TMongoObject)
  public type
    /// <summary> See http://docs.mongodb.org/master/core/read-preference/#read-preference-modes. </summary>
    TReadMode = (Primary, Secondary, PrimaryPreferred, SecondaryPreferred, Nearest);
  private
    FTags: TMongoDocument;
    function GetMode: TReadMode;
    procedure SetMode(const AValue: TReadMode);
    function GetTags: TMongoDocument;
    procedure SetTags(const AValue: TMongoDocument);
  protected
    /// <summary> Release handle of this read preference object. </summary>
    procedure InternalFreeHandle; override;
  public
    /// <summary> Creates new read preference object. </summary>
    constructor Create(AEnv: TMongoEnv; AOwningObj: TObject;
      AHandle: Pmongoc_read_prefs_t = nil);
    destructor Destroy; override;
    /// <summary> Assigns settings of existing read preference object to this object. </summary>
    procedure Assign(ASource: TMongoReadPreference);
    /// <summary> See http://docs.mongodb.org/master/core/read-preference/#tag-sets. </summary>
    procedure AddTag(ATag: TMongoDocument);
    /// <summary> Gets/sets current read mode of this read preference object. </summary>
    property Mode: TReadMode read GetMode write SetMode default TReadMode.Primary;
    /// <summary> Gets/sets current tags of this read preference object. </summary>
    property Tags: TMongoDocument read GetTags write SetTags;
  end;

  /// <summary> Incapsulates MongoDB mongoc_write_concern_t structure, representing
  ///  MongoDB API write concerns. All other MongoDB API wrapping classes provide
  ///  access to objects representing default write concerns.
  ///  More: http://docs.mongodb.org/master/core/write-concern/ </summary>
  TMongoWriteConcern = class(TMongoObject)
  public type
    /// <summary> See http://api.mongodb.org/c/current/mongoc_write_concern_t.html. </summary>
    TWriteLevel = (Default, ErrorsIgnored, Unacknowledged, Majority);
  private
    function GetFsync: Boolean;
    procedure SetFsync(const AValue: Boolean);
    function GetJournal: Boolean;
    procedure SetJournal(const AValue: Boolean);
    function GetLevel: TWriteLevel;
    procedure SetLevel(const AValue: TWriteLevel);
    function GetMajority: Integer;
    procedure SetMajority(const AValue: Integer);
    function GetTag: String;
    procedure SetTag(const AValue: String);
    function GetTimeout: Integer;
    procedure SetTimeout(const AValue: Integer);
  protected
    /// <summary> Release handle of this write concern object. </summary>
    procedure InternalFreeHandle; override;
  public
    /// <summary> Creates new write concern object. </summary>
    constructor Create(AEnv: TMongoEnv; AOwningObj: TObject;
      AHandle: Pmongoc_write_concern_t = nil);
    /// <summary> Assigns settings of existing write concern object to this object. </summary>
    procedure Assign(ASource: TMongoWriteConcern);
    /// <summary> Gets/sets current write concern level of this write concern object. </summary>
    property Level: TWriteLevel read GetLevel write SetLevel default TWriteLevel.Default;
    /// <summary> Gets/sets if a fsync must be performed before indicating write success. </summary>
    property Fsync: Boolean read GetFsync write SetFsync;
    /// <summary> Gets/sets if the write must have been journaled before indicating success. </summary>
    property Journal: Boolean read GetJournal write SetJournal;
    /// <summary> Gets/sets if the write must have been propagated to a majority
    ///  of nodes before indicating write success. Assignment to this property will
    ///  set Level to Majority. The value is a timeout in msecs to propogate the
    ///  changes before considering the write request failed. </summary>
    property Majority: Integer read GetMajority write SetMajority;
    /// <summary> Gets/sets the write tag that must be satistified for the write to indicate
    ///  success. Write tags are preset write concerns configured on your MongoDB server. </summary>
    property Tag: String read GetTag write SetTag;
    /// <summary> Gets/sets the timeout in milliseconds that the server should wait before
    ///  idicating that the write has failed. This is not the same as a socket timeout. </summary>
    property Timeout: Integer read GetTimeout write SetTimeout;
  end;

  /// <summary> Represents "fluent" style MongoDB expression builder. This class
  ///  is a generic base class and should not be used directly by an application.
  ///  The API replicates TMongoDocument API and adds Exp and End methods. The
  ///  End method finishes an expression and forwards control to a parent builder. </summary>
  TMongoExpression<T: class> = class abstract(TObject)
  private
    FDoc: TMongoDocument;
    function GetAsJSON: String; inline;
    function GetInArray: Boolean; inline;
    function GetInObject: Boolean; inline;
    procedure SetAsJSON(const AValue: String); inline;
  protected
    constructor Create(AEnv: TMongoEnv; AOwningObj: TObject; AParentObj: T); overload;
  public
    constructor Create(AEnv: TMongoEnv); overload;
    destructor Destroy; override;
    procedure Assign(ASource: TMongoExpression<T>); inline;
    function Clear: TMongoExpression<T>; inline;
    procedure Close; inline;
    // General writing methods
    function Add(const AKey: String; const AValue: String): TMongoExpression<T>; overload; inline;
    function Add(const AKey: String; const AValue: Int32): TMongoExpression<T>; overload; inline;
    function Add(const AKey: String; const AValue: Int64): TMongoExpression<T>; overload; inline;
    function Add(const AKey: String; const AValue: Extended): TMongoExpression<T>; overload; inline;
    function Add(const AKey: String; const AValue: Boolean): TMongoExpression<T>; overload; inline;
    function Add(const AKey: String; const AValue: TDateTime): TMongoExpression<T>; overload; inline;
    function Add(const AKey: String; const AValue: TBytes;
      ABinaryType: TJsonBinaryType = TJsonBinaryType.Generic): TMongoExpression<T>; overload; inline;
    function Add(const AKey: String; const AValue: TMongoOID): TMongoExpression<T>; overload; inline;
    function Add(const AKey: String; const AValue: TJsonOid): TMongoExpression<T>; overload;
    function Add(const AKey: string; const AValue: TJsonRegEx): TMongoExpression<T>; overload;
    function Add(const AKey: string; const AValue: TJsonDBRef): TMongoExpression<T>; overload;
    function Add(const AKey: string; const AValue: TJsonCodeWScope): TMongoExpression<T>; overload;
    function Add(const AKey: String; const AValue: TVarRec): TMongoExpression<T>; overload; inline;
    function Add(const AKey: String; const AValues: array of const): TMongoExpression<T>; overload;
    function Add(const AKey: String; const AValue: Variant): TMongoExpression<T>; overload; inline;
    function AddNull(const AKey: String): TMongoExpression<T>; overload; inline;
    function AddUndefined(const AKey: String): TMongoExpression<T>; overload; inline;
    function AddMinKey(const AKey: String): TMongoExpression<T>; overload; inline;
    function AddMaxKey(const AKey: String): TMongoExpression<T>; overload; inline;
    function BeginArray(const AKey: String): TMongoExpression<T>; inline;
    function EndArray: TMongoExpression<T>; inline;
    function BeginObject(const AKey: String): TMongoExpression<T>; inline;
    function EndObject: TMongoExpression<T>; inline;
    function Append(const ADoc: TMongoDocument): TMongoExpression<T>; overload; inline;
    function Append(const AJSON: String): TMongoExpression<T>; overload; inline;
    function Append(const AItems: array of const): TMongoExpression<T>; overload;
    // Expression specific methods
    /// <summary> Appends "AField": AExpression to current expression.
    ///  Returns reference to this object. </summary>
    function Exp(const AField, AExpression: String): TMongoExpression<T>;
    /// <summary> Finishes this command stage and returns reference to
    ///  parent command object. </summary>
    function &End: T; inline;
    // R/O
    property InArray: Boolean read GetInArray;
    property InObject: Boolean read GetInObject;
    property Doc: TMongoDocument read FDoc;
    function Builder: TJSONObjectBuilder; inline;
    function Iterator: TJSONIterator; inline;
    // R/W
    property AsJSON: String read GetAsJSON write SetAsJSON;
  end;

  /// <summary> Represents result set cursor interface. The interface is
  ///  implemented by:
  ///  * "fluent" style command builders, where a command returns a result set.
  ///    So, casting a builder to the interface will execute the command and
  ///    provide a cursor.
  ///  * TMongoCursor.TDefault class, which is the default interface
  ///    implementation.
  /// </summary>
  IMongoCursor = interface(IInterface)
    ['{7D8AF712-3FA8-459B-BF9B-4EC7E55B7359}']
    // private
    function GetDoc: TMongoDocument;
    function GetIsAlive: Boolean;
    // public
    /// <summary> Moves the cursor to the next document. Right after execution
    ///  of a command, cursor stays before a first document. So, first Next call
    ///  positions the cursor on first document. If document is found, then
    ///  new document is loaded into Doc document and method returns True,
    ///  otherwise - False. </summary>
    function Next: Boolean; overload;
    /// <summary> Similar to above Next method, but loads the document into
    ///  specified ADoc document. </summary>
    function Next(ADoc: TMongoDocument): Boolean; overload;
    /// <summary> Returns reference to last fetched document using Next method. </summary>
    property Doc: TMongoDocument read GetDoc;
    /// <summary> Returns True if the cursor is alive. </summary>
    property IsAlive: Boolean read GetIsAlive;
  end;

  /// <summary> Represents "fluent" style MongoDB Pipeline builder.
  ///  For more details see:
  ///  * http://docs.mongodb.org/manual/core/aggregation-pipeline/
  ///  * http://docs.mongodb.org/manual/reference/operator/aggregation/
  ///  The builder key methods, like Project, Match, Group, return subbuilders
  ///  for corresponding pipeline stages. A TMongoPipeline object may be:
  ///  * created explicitly and submit to TMongoCollection.Aggregate method.
  ///    This allows to reuse the pipeline object.
  ///  * obtained from overloaded TMongoCollection.Aggregate method, then
  ///    casted to IMongoCursor to execute pipeline and get a result set cursor.
  /// </summary>
  TMongoPipeline = class(TInterfacedObject, IMongoCursor)
  protected type
    TGetCursor = reference to function(APipeline: TMongoPipeline): IMongoCursor;

    /// <summary> Base class for pipeline stage and operation classes. </summary>
    TOperation = class abstract(TObject)
    protected
      [weak] FPipeline: TMongoPipeline;
      FWriter: TMongoDocument;
      constructor Create(APipeline: TMongoPipeline);
      class function GetOperator: String; virtual; abstract;
      class function GetInline: Boolean; virtual;
    public
      destructor Destroy; override;
      /// <summary> Finishes this stage and returns reference to parent
      ///  pipeline object. </summary>
      function &End: TMongoPipeline; inline;
      /// <summary> Returns reference to stage containing document. </summary>
      property Writer: TMongoDocument read FWriter;
    end;
    TOperationClass = class of TOperation;

    TInlineOperation = class abstract(TOperation)
    protected
      class function GetInline: Boolean; override;
      procedure SetValue(const AValue: Variant);
    end;

    /// <summary> Implements pipeline Limit stage. </summary>
    TLimit = class sealed(TInlineOperation)
    protected
      class function GetOperator: String; override;
    end;

    /// <summary> Implements pipeline Skip stage. </summary>
    TSkip = class sealed(TInlineOperation)
    protected
      class function GetOperator: String; override;
    end;

    /// <summary> Implements pipeline Unwind stage. </summary>
    TUnwind = class sealed(TInlineOperation)
    protected
      class function GetOperator: String; override;
    end;

    /// <summary> Implements pipeline Out stage. </summary>
    TOut = class sealed(TInlineOperation)
    protected
      class function GetOperator: String; override;
    end;

  public type
    TExpression = class sealed(TMongoExpression<TMongoPipeline>)
    end;

    /// <summary> Implements pipeline Projection stage. </summary>
    TProjection = class sealed(TOperation)
    protected
      class function GetOperator: String; override;
    public
      /// <summary> Clears content of projection stage. </summary>
      function Clear: TProjection; inline;
      /// <summary> Appends JSON construction to projection stage. </summary>
      function Append(const AJSON: String): TProjection; inline;
      /// <summary> Excludes _ID attribute from result of projection stage. </summary>
      function NoID: TProjection; inline;
      /// <summary> Includes AField attribute into result of projection stage. </summary>
      function Field(const AField: String): TProjection; inline;
      /// <summary> Starts inclusion of new AField attribute into result of
      ///  projection stage, which will be of nested document type. </summary>
      function FieldBegin(const AField: String): TProjection; inline;
      /// <summary> Finishes inclusion of attribute started by previous
      ///  FieldBegin call. </summary>
      function FieldEnd: TProjection; inline;
      /// <summary> Includes AField calculated attribute into result of
      ///  projection stage. </summary>
      function Exp(const AField, AExpression: String): TProjection;
    end;

    /// <summary> Implements pipeline Sort stage. </summary>
    TSort = class sealed(TOperation)
    protected
      class function GetOperator: String; override;
    public
      /// <summary> Clears content of sort stage. </summary>
      function Clear: TSort; inline;
      /// <summary> Appends JSON construction to sort stage. </summary>
      function Append(const AJSON: String): TSort; inline;
      /// <summary> Includes AName attribute into sort stage. </summary>
      function Field(const AName: String; AAscending: Boolean = True): TSort;
      /// <summary> Applies special sorting by "$meta: textScore" for
      ///  AName attribute. </summary>
      function TextScore(const AName: String): TSort;
    end;

    /// <summary> Implements pipeline options. </summary>
    TOptions = class sealed(TObject)
    private
      FExplain: Boolean;
      FBatchSize: Integer;
      FUseCursor: Boolean;
      FAllowDiskUse: Boolean;
      FMaxTimeMS: Integer;
      procedure Save(AWriter: TMongoDocument);
    public
      /// <summary> Assigns content of other AOptions object to this one. </summary>
      procedure Assign(AOptions: TOptions);
      /// <summary> Specifies to return the information on the processing of
      ///  the pipeline. For more details see:
      ///  * https://docs.mongodb.org/manual/reference/method/db.collection.aggregate/#example-aggregate-method-explain-option
      /// </summary>
      property Explain: Boolean read FExplain write FExplain default False;
      /// <summary> Enables writing to temporary files. For more details see:
      ///  * https://docs.mongodb.org/manual/reference/method/db.collection.aggregate/#example-aggregate-method-external-sort
      /// </summary>
      property AllowDiskUse: Boolean read FAllowDiskUse write FAllowDiskUse default False;
      /// <summary> Enables cursor usage. Used together with BatchSize. For more details see:
      ///  * https://docs.mongodb.org/manual/reference/method/db.collection.aggregate/#example-aggregate-method-initial-batch-size
      /// </summary>
      property UseCursor: Boolean read FUseCursor write FUseCursor default False;
      /// <summary> Specifies the initial batch size for the cursor. Used together with UseCursor. For more details see:
      ///  * https://docs.mongodb.org/manual/reference/method/db.collection.aggregate/#example-aggregate-method-initial-batch-size
      /// </summary>
      property BatchSize: Integer read FBatchSize write FBatchSize default 0;
      /// <summary> Specifies the maximum time to execute the pipeline. </summary>
      property MaxTimeMS: Integer read FMaxTimeMS write FMaxTimeMS default 0;
    end;

  private
    FEnv: TMongoEnv;
    [weak] FOwningObj: TObject;
    FGetCursor: TGetCursor;
    FOperations: TStringList;
    FOptions: TOptions;
    FPWriter: TMongoDocument;
    FOWriter: TMongoDocument;
    function GetCursor: IMongoCursor;
    function GetOperation(AType: TOperationClass; const ATypeName: String;
      const AJSON: String): TObject;
    function GetOptions: TOptions;
    function GetFinalPipelineBSON: TMongoDocument;
    function GetFinalOptionsBSON: TMongoDocument;
  protected
    /// <summary> Creates new TMongoPipeline instance. This constructor is used
    ///  internally by TMongoCollection.Aggregate(TMongoQueryFlags) overloaded method.
    /// </summary>
    constructor Create(AEnv: TMongoEnv; AOwningObj: TObject; AGetCursor: TGetCursor); overload;
    /// <summary> Returns reference to IMongoCursor. </summary>
    property Cursor: IMongoCursor read GetCursor implements IMongoCursor;
  public
    /// <summary> Creates new TMongoPipeline instance. This instance may be executed
    ///  using TMongoCollection.Aggregate(TMongoPipeline) overloaded method.
    /// </summary>
    constructor Create(AEnv: TMongoEnv); overload;
    destructor Destroy; override;
    /// <summary> Returns reference to $project stage builder, which passes only
    ///  specified fields to the next stage. Optionally may be specified JSON
    ///  string representing this stage. For more details see:
    ///  * https://docs.mongodb.org/manual/reference/operator/aggregation/project/
    /// </summary>
    function Project(const AJSON: String = ''): TProjection;
    /// <summary> Returns reference to $match stage builder, which filters the
    ///  documents. Optionally may be specified JSON string representing this
    ///  stage. For more details see:
    ///  * https://docs.mongodb.org/manual/reference/operator/aggregation/match/
    /// </summary>
    function Match(const AJSON: String = ''): TExpression;
    /// <summary> Returns reference to $redact stage builder, which restricts the
    ///  content of documents. Optionally may be specified JSON string representing
    ///  this stage. For more details see:
    ///  * https://docs.mongodb.org/manual/reference/operator/aggregation/redact/
    /// </summary>
    function Redact(const AJSON: String = ''): TExpression;
    /// <summary> Limits the number of documents passed to the next stage.
    ///  For more details see:
    ///  * https://docs.mongodb.org/manual/reference/operator/aggregation/limit/
    /// </summary>
    function Limit(const AValue: Integer): TMongoPipeline;
    /// <summary> Skips over the specified number of documents.
    ///  For more details see:
    ///  * https://docs.mongodb.org/manual/reference/operator/aggregation/skip/
    /// </summary>
    function Skip(const AValue: Integer): TMongoPipeline;
    /// <summary> Deconstructs an array field from the input documents to output
    ///  a document for each element. APath specifies array field path.
    ///  For more details see:
    ///  * https://docs.mongodb.org/manual/reference/operator/aggregation/unwind/
    /// </summary>
    function Unwind(const APath: String): TMongoPipeline;
    /// <summary> Returns reference to $group stage builder, which groups
    ///  documents by some specified expression. Optionally may be specified
    ///  JSON string representing this stage. For more details see:
    ///  * https://docs.mongodb.org/manual/reference/operator/aggregation/group/
    /// </summary>
    function Group(const AJSON: String = ''): TExpression;
    /// <summary> Returns reference to $sort stage builder, which sorts documents
    ///  by some specified document atributes. Optionally may be specified
    ///  JSON string representing this stage. For more details see:
    ///  * https://docs.mongodb.org/manual/reference/operator/aggregation/sort/
    /// </summary>
    function Sort(const AJSON: String = ''): TSort;
    /// <summary> Writes documents to a specified collection. ACollectionName
    ///  specifies collection name. For more details see:
    ///  * https://docs.mongodb.org/manual/reference/operator/aggregation/out/
    /// </summary>
    function &Out(const ACollectionName: String): TMongoPipeline;
    /// <summary> Explicitly executes pipeline and returns cursor. Note, that
    ///  casting TMongoPipeline object to IMongoCursor will implicitly execute
    ///  pipeline. Note, this method may be used only when pipeline object
    ///  was created by TMongoCollection.Aggregate(TMongoQueryFlags) method. </summary>
    function Open: IMongoCursor;
    /// <summary> Returns reference to pipeline options. </summary>
    property Options: TOptions read GetOptions;
    /// <summary> Returns MongoDB document representing pipeline with
    ///  all provided stages. </summary>
    property FinalPipelineBSON: TMongoDocument read GetFinalPipelineBSON;
    /// <summary> Returns MongoDB document representing pipeline options. </summary>
    property FinalOptionsBSON: TMongoDocument read GetFinalOptionsBSON;
  end;

  /// <summary> Represents "fluent" style MongoDB Query builder.
  ///  For more details see:
  ///  * http://docs.mongodb.org/manual/tutorial/query-documents/
  ///  * http://docs.mongodb.org/manual/reference/method/db.collection.find/
  ///  The builder key methods, like Project, Match, Sort, return subbuilders
  ///  for corresponding query parts. A TMongoQuery object may be:
  ///  * created explicitly and submit to TMongoCollection.Find or Count method.
  ///    This allows to reuse the query object.
  ///  * obtained from overloaded TMongoCollection.Find or Count method, then
  ///    casted to IMongoCursor to execute query and get a result set cursor.
  /// </summary>
  TMongoQuery = class(TInterfacedObject, IMongoCursor)
  protected type
    TGetCursor = reference to function(AQuery: TMongoQuery): IMongoCursor;
    TGetCount = reference to function(AQuery: TMongoQuery): Int64;

    /// <summary> Base class for query operation classes. </summary>
    TOperation = class abstract(TObject)
    private
      [weak] FQuery: TMongoQuery;
      FWriter: TMongoDocument;
      constructor Create(AQuery: TMongoQuery);
    public
      destructor Destroy; override;
      /// <summary> Finishes this operation and returns reference to parent
      ///  query object. </summary>
      function &End: TMongoQuery; inline;
      /// <summary> Returns reference to operation containing document. </summary>
      property Writer: TMongoDocument read FWriter;
    end;

  public type
    TExpression = class sealed(TMongoExpression<TMongoQuery>)
    end;

    /// <summary> Implements query projection. </summary>
    TProjection = class sealed(TOperation)
    public
      /// <summary> Clears content of query projection. </summary>
      function Clear: TProjection; inline;
      /// <summary> Appends JSON construction to query projection. </summary>
      function Append(const AJSON: String): TProjection; inline;
      /// <summary> Excludes _ID attribute from result of query. </summary>
      function NoID: TProjection; inline;
      /// <summary> Includes or excludes AField attribute from result of query. </summary>
      function Field(const AField: String; AInclude: Boolean = True): TProjection; inline;
      /// <summary> Includes several AFields fields into result of query. </summary>
      function Include(const AFields: array of String): TProjection;
      /// <summary> Excludes several AFields fields from result of query. </summary>
      function Exclude(const AFields: array of String): TProjection;
      /// <summary> Includes special "$meta: textScore" atribute into result of query. </summary>
      function TextScore(const AField: String): TProjection;
      /// <summary> Includes AField array slice of ACount length into result of query. </summary>
      function Slice(const AField: String; ACount: Integer): TProjection; overload;
      /// <summary> Includes AField array slice of ACount length starting from ASkip
      ///  item into result of query. </summary>
      function Slice(const AField: String; ASkip, ACount: Integer): TProjection; overload;
    end;

    /// <summary> Implements query sorting. </summary>
    TSort = class sealed(TOperation)
    public
      /// <summary> Clears content of query sorting. </summary>
      function Clear: TSort; inline;
      /// <summary> Appends JSON construction to query sorting. </summary>
      function Append(const AJSON: String): TSort; inline;
      /// <summary> Includes AName attribute into query sorting. </summary>
      function Field(const AName: String; AAscending: Boolean = True): TSort;
      /// <summary> Includes several AFields attributes into query sorting
      ///  by ascending order. </summary>
      function Ascending(const AFields: array of String): TSort;
      /// <summary> Includes several AFields attributes into query sorting
      ///  by descending order. </summary>
      function Descending(const AFields: array of String): TSort;
      /// <summary> Applies special sorting by "$meta: textScore" for
      ///  AName attribute. </summary>
      function TextScore(const AName: String): TSort;
    end;

    /// <summary> Implements query options. </summary>
    TOptions = class sealed(TObject)
    private
      FComment: String;
      FExplain: Boolean;
      FHint: String;
      FMaxScan: Integer;
      FMaxTimeMS: Integer;
      FReturnKey: Boolean;
      FSnapshot: Boolean;
      FBatchSize: Integer;
      procedure Save(AWriter: TMongoDocument);
    public
      /// <summary> Assigns content of other AOptions object to this one. </summary>
      procedure Assign(AOptions: TOptions);
      /// <summary> Adds a comment to the query to identify queries in the
      ///  database profiler output. For more details see:
      ///  * https://docs.mongodb.org/manual/reference/operator/meta/comment/ </summary>
      property Comment: String read FComment write FComment;
      /// <summary> Forces MongoDB to report on query execution plans.
      ///  For more details see:
      ///  * https://docs.mongodb.org/manual/reference/operator/meta/explain/ </summary>
      property Explain: Boolean read FExplain write FExplain default False;
      /// <summary> Forces MongoDB to use a specific index.
      ///  For more details see:
      ///  * https://docs.mongodb.org/manual/reference/operator/meta/hint/ </summary>
      property Hint: String read FHint write FHint;
      /// <summary> Limits the number of documents scanned.
      ///  For more details see:
      ///  * https://docs.mongodb.org/manual/reference/operator/meta/maxScan/ </summary>
      property MaxScan: Integer read FMaxScan write FMaxScan default 0;
      /// <summary> Specifies a cumulative time limit in milliseconds for processing operations on a cursor.
      ///  For more details see:
      ///  * https://docs.mongodb.org/manual/reference/operator/meta/maxTimeMS/ </summary>
      property MaxTimeMS: Integer read FMaxTimeMS write FMaxTimeMS default 0;
      /// <summary> Forces the cursor to only return fields included in the index.
      ///  For more details see:
      ///  * https://docs.mongodb.org/manual/reference/operator/meta/returnKey/ </summary>
      property ReturnKey: Boolean read FReturnKey write FReturnKey default False;
      /// <summary> Forces the query to use the index on the _id field.
      ///  For more details see:
      ///  * https://docs.mongodb.org/manual/reference/operator/meta/snapshot/ </summary>
      property Snapshot: Boolean read FSnapshot write FSnapshot default False;
      /// <summary> Specifies the number of documents to return in each batch of
      ///  the response from the MongoDB instance. For more details see:
      ///  * https://docs.mongodb.org/manual/reference/method/cursor.batchSize/ </summary>
      property BatchSize: Integer read FBatchSize write FBatchSize default 0;
    end;

  private
    FEnv: TMongoEnv;
    [weak] FOwningObj: TObject;
    FGetCursor: TGetCursor;
    FGetCount: TGetCount;
    FProject: TProjection;
    FMatch: TExpression;
    FSort: TSort;
    FOptions: TOptions;
    FLimit: Integer;
    FSkip: Integer;
    FQWriter: TMongoDocument;
    FPWriter: TMongoDocument;
    function GetCursor: IMongoCursor;
    function GetFinalQueryBSON: TMongoDocument;
    function GetFinalCountBSON: TMongoDocument;
    function GetFinalProjectBSON: TMongoDocument;
  protected
    /// <summary> Creates new TMongoQuery instance. This constructor is used
    ///  internally by TMongoCollection.Find(TMongoQueryFlags) overloaded method.
    /// </summary>
    constructor Create(AEnv: TMongoEnv; AOwningObj: TObject; AGetCursor: TGetCursor); overload;
    /// <summary> Creates new TMongoQuery instance. This constructor is used
    ///  internally by TMongoCollection.Count(TMongoQueryFlags) overloaded method.
    /// </summary>
    constructor Create(AEnv: TMongoEnv; AOwningObj: TObject; AGetCount: TGetCount); overload;
    procedure DoGetFinalQueryBSON(AWriter: TMongoDocument); virtual;
    procedure DoGetFinalProjectBSON(AWriter: TMongoDocument); virtual;
    /// <summary> Returns reference to IMongoCursor. </summary>
    property Cursor: IMongoCursor read GetCursor implements IMongoCursor;
  public
    /// <summary> Creates new TMongoQuery instance. This instance may be executed
    ///  using TMongoCollection.Find(TMongoQuery), Count(TMongoQuery) overloaded methods.
    /// </summary>
    constructor Create(AEnv: TMongoEnv); overload;
    destructor Destroy; override;
    /// <summary> Returns reference to projection builder, which specifies
    ///  the fields to return using projection operators. Optionally may be
    ///  specified JSON string representing projection. For more details see:
    ///  * https://docs.mongodb.org/manual/reference/method/db.collection.find/
    /// </summary>
    function Project(const AJSON: String = ''): TProjection;
    /// <summary> Returns reference to match builder, which specifies
    ///  selection criteria using query operators. Optionally may be
    ///  specified JSON string representing match criteria. For more details see:
    ///  * https://docs.mongodb.org/manual/reference/method/db.collection.find/
    /// </summary>
    function Match(const AJSON: String = ''): TExpression;
    /// <summary> Returns reference to sort builder, which specifies
    ///  the order in which the query returns matching documents. Optionally
    ///  may be specified JSON string representing this stage. For more details see:
    ///  * https://docs.mongodb.org/manual/reference/method/cursor.sort/
    /// </summary>
    function Sort(const AJSON: String = ''): TSort;
    /// <summary> Returns reference to query options. </summary>
    function Options: TOptions;
    /// <summary> Specifies the maximum number of documents the cursor will return.
    ///  For more details see:
    ///  * https://docs.mongodb.org/manual/reference/method/cursor.limit/
    /// </summary>
    function Limit(const AValue: Integer): TMongoQuery;
    /// <summary> Specifies where MongoDB begins returning results.
    ///  For more details see:
    ///  * https://docs.mongodb.org/manual/reference/method/cursor.skip/
    /// </summary>
    function Skip(const AValue: Integer): TMongoQuery;
    /// <summary> Explicitly executes query and returns cursor. Note, that
    ///  casting TMongoQuery object to IMongoCursor will implicitly execute
    ///  query. Note, this method may be used only when query object was
    ///  created by TMongoCollection.Find(TMongoQueryFlags) overloaded method. </summary>
    function Open: IMongoCursor;
    /// <summary> Executes cound query and returns the records count. Note,
    ///  this method may be used only when count query object was created
    ///  by TMongoCollection.Count(TMongoQueryFlags) overloaded method. </summary>
    function Value: Int64;
    /// <summary> Returns MongoDB document representing Find command query. </summary>
    property FinalQueryBSON: TMongoDocument read GetFinalQueryBSON;
    /// <summary> Returns MongoDB document representing Count command query. </summary>
    property FinalCountBSON: TMongoDocument read GetFinalCountBSON;
    /// <summary> Returns MongoDB document representing projection. </summary>
    property FinalProjectBSON: TMongoDocument read GetFinalProjectBSON;
  end;

  /// <summary> Represents "fluent" style MongoDB Command builder. It mostly
  ///  repeats TMongoQuery API, but adds Command method allowing to specify
  ///  MongoDB command verb. A TMongoCommand object may be:
  ///  * created explicitly and submit to TMongoCollection.Command method.
  ///    This allows to reuse the command object.
  ///  * obtained from overloaded TMongoCollection.Command method, then
  ///    casted to IMongoCursor to execute command and get a result set cursor.
  /// </summary>
  TMongoCommand = class(TMongoQuery)
  private
    FCommand: TMongoDocument;
  protected
    /// <summary> Creates new TMongoCommand instance. This constructor is used
    ///  internally by TMongoCollection methods. </summary>
    constructor Create(AEnv: TMongoEnv; AOwningObj: TObject); overload;
    procedure DoGetFinalQueryBSON(AWriter: TMongoDocument); override;
  public
    /// <summary> Creates new TMongoCommand instance. This instance may be executed
    ///  using TMongoCollection.Command(TMongoCommand) overloaded method.
    /// </summary>
    constructor Create(AEnv: TMongoEnv); overload;
    destructor Destroy; override;
    /// <summary> Appends AArgs arguments to the command. </summary>
    function Command(const AArgs: array of const): TMongoCommand; overload;
    /// <summary> Appends AJSON arguments to the command. </summary>
    function Command(const AJSON: String): TMongoCommand; overload;
  end;

  /// <summary> Represents "fluent" style MongoDB Update builder.
  ///  For more details see:
  ///  * http://docs.mongodb.org/manual/tutorial/modify-documents/
  ///  * https://docs.mongodb.org/manual/reference/operator/update/
  ///  The builder key methods, like Inc, Mul, Set, return subbuilders
  ///  for corresponding update command parts. A TMongoUpdate object may be:
  ///  * created explicitly and submit to TMongoCollection.Update method.
  ///    This allows to reuse the update object.
  ///  * obtained from overloaded TMongoCollection.Update method, then
  ///    call Exec method to execute update command.
  ///  If update command fails, then exception will be raised. Otherwise
  ///  the number of updated documents may be get from TMongoCollection
  ///  DocsModified and DocsUpserted properties.
  /// </summary>
  TMongoUpdate = class(TObject)
  protected type
    TRunUpdate = reference to procedure(AUpdate: TMongoUpdate);

  public type
    TExpression = class sealed (TMongoExpression<TMongoUpdate>)
    end;

    TModifier = class(TObject)
    protected type
      TOperation = class abstract(TObject)
      private
        [weak] FModifier: TModifier;
        FWriter: TMongoDocument;
      protected
        constructor Create(AModifier: TModifier);
        function Field(const AName: String; const AValue: Variant): TOperation;
        class function GetOperator: String; virtual; abstract;
      public
        destructor Destroy; override;
        function &End: TModifier; inline;
        property Writer: TMongoDocument read FWriter;
      end;
      TOperationClass = class of TOperation;

    public type
      TInc = class sealed(TOperation)
      protected
        class function GetOperator: String; override;
      public
        function Field(const AName: String; const AValue: Variant): TInc; inline;
      end;

      TMul = class sealed(TOperation)
      protected
        class function GetOperator: String; override;
      public
        function Field(const AName: String; const AValue: Variant): TMul; inline;
      end;

      TRename = class sealed(TOperation)
      protected
        class function GetOperator: String; override;
      public
        function Field(const AOldName, ANewName: String): TRename; inline;
      end;

      TSetOnInsert = class sealed(TOperation)
      protected
        class function GetOperator: String; override;
      public
        function Field(const AName: String; const AValue: Variant): TSetOnInsert; inline;
      end;

      TSet = class sealed(TOperation)
      protected
        class function GetOperator: String; override;
      public
        function Field(const AName: String; const AValue: Variant): TSet; inline;
      end;

      TUnset = class sealed(TOperation)
      protected
        class function GetOperator: String; override;
      public
        function Field(const AName: String): TUnset; inline;
      end;

      TMin = class sealed(TOperation)
      protected
        class function GetOperator: String; override;
      public
        function Field(const AName: String; const AValue: Variant): TMin; inline;
      end;

      TMax = class sealed(TOperation)
      protected
        class function GetOperator: String; override;
      public
        function Field(const AName: String; const AValue: Variant): TMax; inline;
      end;

      TCurrentDate = class sealed(TOperation)
      protected
        class function GetOperator: String; override;
      public
        function AsDate(const AName: String): TCurrentDate;
        function AsTimestamp(const AName: String): TCurrentDate;
      end;

      TArrayOperation = class abstract(TOperation)
      protected
        function Field(const AName: String; const AValues: Variant;
          AEach, AClose: Boolean): TArrayOperation; overload;
        function Field(const AName: String; const AValues: array of const;
          AEach, AClose: Boolean): TArrayOperation; overload;
      end;

      TAddToSet = class sealed(TArrayOperation)
      protected
        class function GetOperator: String; override;
      public
        function Field(const AName: String; const AValues: Variant;
          AEach: Boolean = True): TAddToSet; overload;
        function Field(const AName: String; const AValues: array of const;
          AEach: Boolean = True): TAddToSet; overload;
      end;

      TPop = class sealed(TArrayOperation)
      protected
        class function GetOperator: String; override;
      public
        function First(const AName: String): TPop;
        function Last(const AName: String): TPop;
      end;

      TPull = class sealed(TArrayOperation)
      protected
        class function GetOperator: String; override;
      public
        function Field(const AName: String; const AValue: Variant): TPull;
        function Where(const AName: String; const AValue: String): TPull;
      end;

      TPullAll = class sealed(TArrayOperation)
      protected
        class function GetOperator: String; override;
      public
        function Field(const AName: String; const AValues: Variant): TPullAll; overload;
        function Field(const AName: String; const AValues: array of const): TPullAll; overload;
      end;

      TPush = class sealed(TArrayOperation)
      protected
        class function GetOperator: String; override;
      public
        function Field(const AName: String; const AValues: Variant;
          AEach: Boolean = True; ASlice: Integer = MaxInt;
          const ASort: String = ''): TPush; overload;
        function Field(const AName: String; const AValues: array of const;
          AEach: Boolean = True; ASlice: Integer = MaxInt;
          const ASort: String = ''): TPush; overload;
      end;

      TPushAll = class sealed(TArrayOperation)
      protected
        class function GetOperator: String; override;
      public
        function Field(const AName: String; const AValues: Variant): TPushAll; overload;
        function Field(const AName: String; const AValues: array of const): TPushAll; overload;
      end;

    private
      [weak] FUpdate: TMongoUpdate;
      FOperations: TStringList;
      FWriter: TMongoDocument;
      FCustomJSON: String;
      constructor Create(AUpdate: TMongoUpdate);
      function GetOperation(AType: TOperationClass; const AJSON: String): TOperation;
      function GetFinalBSON: TMongoDocument;
    public
      destructor Destroy; override;
      function Clear: TModifier;
      function Inc(const AJSON: String = ''): TInc; inline;
      function Mul(const AJSON: String = ''): TMul; inline;
      function Rename(const AJSON: String = ''): TRename; inline;
      function SetOnInsert(const AJSON: String = ''): TSetOnInsert; inline;
      function &Set(const AJSON: String = ''): TSet; inline;
      function Unset(const AJSON: String = ''): TUnset; inline;
      function Min(const AJSON: String = ''): TMin; inline;
      function Max(const AJSON: String = ''): TMax; inline;
      function CurrentDate(const AJSON: String = ''): TCurrentDate; inline;
      function AddToSet(const AJSON: String = ''): TAddToSet; inline;
      function Pop(const AJSON: String = ''): TPop; inline;
      function Pull(const AJSON: String = ''): TPull; inline;
      function PullAll(const AJSON: String = ''): TPullAll; inline;
      function Push(const AJSON: String = ''): TPush; inline;
      function PushAll(const AJSON: String = ''): TPushAll; inline;
      function &End: TMongoUpdate; inline;
    end;

  private
    FEnv: TMongoEnv;
    [weak] FOwningObj: TObject;
    FRunUpdate: TRunUpdate;
    FModifier: TModifier;
    FMatcher: TExpression;
    function GetFinalModifyBSON: TMongoDocument;
    function GetFinalMatchBSON: TMongoDocument;
  protected
    constructor Create(AEnv: TMongoEnv; AOwningObj: TObject; ARunUpdate: TRunUpdate); overload;
    procedure DoGetFinalModifyBSON(AWriter: TMongoDocument); virtual;
    procedure DoGetFinalMatchBSON(AWriter: TMongoDocument); virtual;
  public
    constructor Create(AEnv: TMongoEnv); overload;
    destructor Destroy; override;
    function Match(const AJSON: String = ''): TExpression;
    function Modify(const AJSON: String = ''): TModifier;
    procedure Exec;
    // property RO
    property FinalModifyBSON: TMongoDocument read GetFinalModifyBSON;
    property FinalMatchBSON: TMongoDocument read GetFinalMatchBSON;
  end;

  /// <summary> Represents "fluent" style MongoDB Selector builder.
  ///  For more details see:
  ///  * http://docs.mongodb.org/manual/reference/method/db.collection.remove/
  ///  * http://docs.mongodb.org/manual/reference/operator/query/
  ///  The builder Match method return subbuilder for selector. An object
  ///  of this class may be:
  ///  * created explicitly and submit to TMongoCollection.Remove method.
  ///    This allows to reuse the selector object.
  ///  * obtained from overloaded TMongoCollection.Remove method, then
  ///    call Exec method to execute remove command.
  /// </summary>
  TMongoSelector = class(TObject)
  protected type
    TRunOper = reference to procedure(ASelector: TMongoSelector);

  public type
    TExpression = class sealed(TMongoExpression<TMongoSelector>)
    end;

  private
    FEnv: TMongoEnv;
    [weak] FOwningObj: TObject;
    FMatcher: TExpression;
    FRunOper: TRunOper;
    function GetFinalMatchBSON: TMongoDocument;
  protected
    constructor Create(AEnv: TMongoEnv; AOwningObj: TObject; ARunOper: TRunOper); overload;
    procedure DoGetFinalMatchBSON(AWriter: TMongoDocument); virtual;
  public
    constructor Create(AEnv: TMongoEnv); overload;
    destructor Destroy; override;
    function Match(const AJSON: String = ''): TExpression;
    procedure Exec;
    // property RO
    property FinalMatchBSON: TMongoDocument read GetFinalMatchBSON;
  end;

  /// <summary> Represents "fluent" style MongoDB Insert builder.
  ///  For more details see:
  ///  * http://docs.mongodb.org/manual/tutorial/insert-documents/
  ///  * http://docs.mongodb.org/manual/reference/method/db.collection.insert/
  ///  The builder Values method returns document subbuilder. A TMongoInsert
  ///  object may be:
  ///  * created explicitly and submit to TMongoCollection.Insert method.
  ///    This allows to reuse the builder.
  ///  * obtained from overloaded TMongoCollection.Insert method, then
  ///    call Exec method to execute insert command.
  ///  If insert command fails, then exception will be raised. Otherwise
  ///  the number of inserted documents may be get from TMongoCollection
  ///  DocsInserted property.
  ///  Although MongoDB Insert command allows to insert an array of documents,
  ///  the TMongoCollection.Insert and this builder are limited to a single
  ///  document. To insert multiple documents use TMongoCollection.BeginBulk,
  ///  EndBulk API. </summary>
  TMongoInsert = class(TObject)
  protected type
    TRunOper = reference to procedure(ASelector: TMongoInsert);

  public type
    TExpression = class sealed(TMongoExpression<TMongoInsert>)
    end;

  private
    FEnv: TMongoEnv;
    [weak] FOwningObj: TObject;
    FValues: TExpression;
    FRunOper: TRunOper;
    function GetFinalValuesBSON: TMongoDocument;
  protected
    constructor Create(AEnv: TMongoEnv; AOwningObj: TObject; ARunOper: TRunOper); overload;
    procedure DoGetFinalValuesBSON(AWriter: TMongoDocument); virtual;
  public
    constructor Create(AEnv: TMongoEnv); overload;
    destructor Destroy; override;
    function Values(const AJSON: String = ''): TExpression;
    procedure Exec;
    // property RO
    property FinalValuesBSON: TMongoDocument read GetFinalValuesBSON;
  end;

  /// <summary> Represents "fluent" style MongoDB Index definition builder.
  ///  For more details see:
  ///  * http://docs.mongodb.org/manual/tutorial/create-an-index/
  ///  * http://docs.mongodb.org/manual/reference/method/db.collection.createIndex/
  ///  The Keys method returns index keys subbuilder. The Options property
  ///  allows specify index name and other attributes. A TMongoIndex object
  ///  may be created explicitly and submit to TMongoCollection.CreateIndex
  ///  method. </summary>
  TMongoIndex = class(TObject)
  public type
    TKeys = class sealed(TObject)
    private
      FWriter: TMongoDocument;
      constructor Create(AIndex: TMongoIndex);
    public
      destructor Destroy; override;
      function Field(const AName: String; AAscending: Boolean = True): TKeys;
      function Ascending(const AFields: array of String): TKeys;
      function Descending(const AFields: array of String): TKeys;
    end;

    TOptions = class sealed(TObject)
    private
      [weak] FIndex: TMongoIndex;
      FOpts: mongoc_index_opt_t;
      FName: String;
      FBName: TFDByteString;
      procedure SetName(const AValue: String);
      constructor Create(AIndex: TMongoIndex);
    public
      property Name: String read FName write SetName;
      property Background: Boolean read FOpts.background write FOpts.background default False;
      property Unique: Boolean read FOpts.unique write FOpts.unique default False;
      property DropDups: Boolean read FOpts.drop_dups write FOpts.drop_dups default False;
      property Sparse: Boolean read FOpts.sparse write FOpts.sparse default False;
      property ExpireAfter: Integer read FOpts.expire_after_seconds write FOpts.expire_after_seconds default 0;
    end;

  private
    FEnv: TMongoEnv;
    [weak] FOwningObj: TObject;
    FKeys: TKeys;
    FOptions: TOptions;
  public
    constructor Create(AEnv: TMongoEnv); overload;
    destructor Destroy; override;
    function Keys(const AJSON: String = ''): TKeys;
    property Options: TOptions read FOptions;
  end;

  /// <summary> Incapsulates MongoDB mongoc_cursor_t structure. This class is
  ///  responsible for fetching result set documents from a cursor returned
  ///  by a command. Application should not create objects of this class
  ///  directly. </summary>
  TMongoCursor = class(TMongoObject)
  protected type
    TDefault = class(TInterfacedObject, IMongoCursor)
    private
      FCursor: TMongoCursor;
      FReleaseObj: TObject;
    protected
      // IMongoCursor
      function GetDoc: TMongoDocument;
      function GetIsAlive: Boolean;
      function Next: Boolean; overload;
      function Next(ADoc: TMongoDocument): Boolean; overload;
      // other
      constructor Create(AEnv: TMongoEnv; AOwningObj: TObject;
        AReleaseObj: TObject; AHandle: Pmongoc_handle_t);
    public
      destructor Destroy; override;
    end;

  private
    FDoc: TMongoDocument;
    FEof: Boolean;
    function GetDoc: TMongoDocument;
    function GetIsAlive: Boolean;
  protected
    procedure InternalFreeHandle; override;
  public
    destructor Destroy; override;
    function Next: Boolean; overload;
    function Next(ADoc: TMongoDocument): Boolean; overload;
    property Doc: TMongoDocument read GetDoc;
    property IsAlive: Boolean read GetIsAlive;
  end;

  /// <summary> Incapsulates MongoDB mongoc_client_t structure. This class is
  ///  responsible for managing connection to a MongoDB server. Also it provides
  ///  access to database and collection objects. </summary>
  TMongoConnection = class(TMongoObject)
  private
    FReadPreference: TMongoReadPreference;
    FWriteConcern: TMongoWriteConcern;
    FPEMFile, FPEMPwd, FCAFile, FCADir, FCRLFile: TFDByteString;
    Fmongoc_ssl_opt: mongoc_ssl_opt_t;
    FDatabase: TMongoDatabase;
    FCollection: TMongoCollection;
    function Getmax_bson_size: Integer;
    function Getmax_message_size: Integer;
    function InternalGetDatabase(const ADBName: String; ANew: Boolean): TMongoDatabase;
    function InternalGetCollection(const ADBName, AColName: String; ANew: Boolean): TMongoCollection;
    function GetCollectionsProp(const ADBName, AColName: String): TMongoCollection;
    function GetDatabasesProp(const ADBName: String): TMongoDatabase;
    function GetServerVersion: TFDVersion;
    function GetURI: String;
  protected
    procedure InternalFreeHandle; override;
    procedure FreeHandle; override;
    procedure HandleAllocated; override;
  public
    constructor Create(AEnv: TMongoEnv; AOwningObj: TObject);
    constructor CreateUsingHandle(AEnv: TMongoEnv; AHandle: Pmongoc_handle_t; AOwningObj: TObject);
    destructor Destroy; override;
    // handle connection
    procedure Open(const AUri: String);
    procedure SSLInit(const APEMFile, APEMPwd, ACAFile, ACADir, ACRLFile: String;
      AWeakValid: Boolean);
    procedure Close; inline;
    procedure Ping;
    function GetServerStatus: TMongoDocument;
    // databases and collections
    function ListDatabases: IMongoCursor;
    function GetDatabase(const ADBName: String): TMongoDatabase;
    function GetCollection(const ADBName, AColName: String): TMongoCollection;
    // execute commands
    function Command(const ADBName: String; ACommand: TMongoCommand; AFlags: TMongoQueryFlags = []): IMongoCursor; overload;
    function Command(const ADBName: String; const AJSON: String; AFlags: TMongoQueryFlags = []): IMongoCursor; overload;
    function CommandSimple(const ADBName: String; ACommand: TMongoDocument): TMongoDocument; overload;
    function CommandSimple(const ADBName: String; const AJSON: String): TMongoDocument; overload;
    // DBRef lookup
    function Dereference(const ADBRef: TJsonDBRef): TMongoDocument;
    // props
    property URI: String read GetURI;
    property max_message_size: Integer read Getmax_message_size;
    property max_bson_size: Integer read Getmax_bson_size;
    property ServerVersion: TFDVersion read GetServerVersion;
    property ReadPreference: TMongoReadPreference read FReadPreference;
    property WriteConcern: TMongoWriteConcern read FWriteConcern;
    property Databases[const ADBName: String]: TMongoDatabase read GetDatabasesProp; default;
    property Collections[const ADBName, AColName: String]: TMongoCollection read GetCollectionsProp;
  end;

  /// <summary> Incapsulates MongoDB mongoc_database_t structure. This class
  ///  represents a single MongoDB database. It allows to manage database,
  ///  collections and users inside of this database. Also it provides access
  ///  to collection objects. Application cannot create instance of this class
  ///  directly. Instead it should use TMongoConnection:
  ///  * TMongoConnection.GetDatabase to get new instance of TMongoDatabase
  ///  * TMongoConnection.Databases to get a shared instance of TMongoDatabase
  /// </summary>
  TMongoDatabase = class(TMongoObject)
  private
    FCollection: TMongoCollection;
    FReadPreference: TMongoReadPreference;
    FWriteConcern: TMongoWriteConcern;
    function GetName: String;
    function InternalGetCollection(const AColName: String; ANew: Boolean): TMongoCollection;
    function GetCollectionsProp(const AColName: String): TMongoCollection;
  protected
    procedure InternalFreeHandle; override;
    procedure FreeHandle; override;
    procedure HandleAllocated; override;
    constructor Create(AEnv: TMongoEnv; AOwningObj: TObject; AHandle: Pmongoc_database_t);
  public
    destructor Destroy; override;
    // manage DB users
    procedure Drop;
    procedure AddUser(const AUserName, APassword: String; ARoles, ACustomData: TMongoDocument);
    procedure DropUser(const AUserName: String);
    procedure DropAllUsers;
    // manage DB collections
    function ListCollections(ASelector: TMongoSelector = nil): IMongoCursor;
    function HasCollection(const AName: String): Boolean;
    procedure CreateCollection(const AName: String; AOptions: TMongoDocument);
    procedure DropCollection(const AName: String; AIgnoreObjNotExists: Boolean = False);
    function GetCollection(const AColName: String): TMongoCollection;
    // execute commands
    function Command(ACommand: TMongoCommand; AFlags: TMongoQueryFlags = []): IMongoCursor; overload;
    function Command(const AJSON: String; AFlags: TMongoQueryFlags = []): IMongoCursor; overload;
    function CommandSimple(ACommand: TMongoDocument): TMongoDocument; overload;
    function CommandSimple(const AJSON: String): TMongoDocument; overload;
    // DBRef lookup
    function Dereference(const ADBRef: TJsonDBRef): TMongoDocument;
    // props
    property Name: String read GetName;
    property ReadPreference: TMongoReadPreference read FReadPreference;
    property WriteConcern: TMongoWriteConcern read FWriteConcern;
    property Collections[const AColName: String]: TMongoCollection read GetCollectionsProp; default;
  end;

  /// <summary> Incapsulates MongoDB mongoc_collection_t structure. This class
  ///  represents a single MongoDB collection and provides methods to manage
  ///  collection, modify and query it data. Application cannot create instance
  ///  of this class directly. Instead it should use TMongoConnection or TMongoDatabase:
  ///  * TMongoConnection.GetCollection to get new instance of TMongoCollection
  ///  * TMongoConnection.Collections to get a shared instance of TMongoCollection
  ///  * TMongoDatabase.GetCollection to get new instance of TMongoCollection
  ///  * TMongoDatabase.Collections to get a shared instance of TMongoCollection
  /// </summary>
  TMongoCollection = class(TMongoObject)
  public type
    TInsertFlag = (ContinueOnError, NoValidate);
    TInsertFlags = set of TInsertFlag;

    TRemoveFlag = (SingleRemove);
    TRemoveFlags = set of TRemoveFlag;

    TUpdateFlag = (Upsert, MultiUpdate);
    TUpdateFlags = set of TUpdateFlag;
  private
    FReadPreference: TMongoReadPreference;
    FWriteConcern: TMongoWriteConcern;
    FLastError: TMongoDocument;
    FBulkHandle: Pmongoc_bulk_operation_t;
    FDocsInserted: Int64;
    FDocsMatched: Int64;
    FDocsModified: Int64;
    FDocsRemoved: Int64;
    FDocsUpserted: Int64;
    FLastOID: TMongoOID;
    FLastID: Variant;
    function GetName: String;
    function GetDB: String;
    function GetNS: String;
    procedure ResetCounts;
    procedure ProcessWriteResult(AReply: TMongoDocument; ABulk: Boolean);
    function GetLastError: TMongoDocument;
    function GetIsBulk: Boolean;
    procedure EnsureID(ADocument: TMongoDocument);
    function AggregateBase(APipeline: TMongoPipeline; AReleasePipeline: Boolean;
      AFlags: TMongoQueryFlags): IMongoCursor;
    function FindBase(AQuery: TMongoQuery; AReleaseQuery: Boolean;
      AFlags: TMongoQueryFlags): IMongoCursor;
  protected
    procedure InternalFreeHandle; override;
    procedure FreeHandle; override;
    procedure HandleAllocated; override;
    constructor Create(AEnv: TMongoEnv; AOwningObj: TObject; AHandle: Pmongoc_collection_t);
  public
    destructor Destroy; override;
    // manage collection
    procedure Drop(AIgnoreObjNotExists: Boolean = False);
    procedure Rename(const ANewDB, ANewName: String; ADropTarget: Boolean = True);
    function Validate(AOptions: TMongoDocument): TMongoDocument;
    function Statistics(AOptions: TMongoDocument): TMongoDocument;
    // manage collection indexes
    function ListIndexes: IMongoCursor;
    procedure CreateIndex(AIndex: TMongoIndex);
    procedure DropIndex(const AName: String);
    // collection updating
    procedure BeginBulk(AOrdered: Boolean = True);
    procedure EndBulk;
    procedure CancelBulk;
    procedure Insert(ADocument: TMongoDocument; AFlags: TInsertFlags = []); overload;
    procedure Insert(AInsert: TMongoInsert; AFlags: TInsertFlags = []); overload;
    function Insert(AFlags: TInsertFlags = []): TMongoInsert; overload;
    procedure Remove(ASelector: TMongoSelector; AFlags: TRemoveFlags = []); overload;
    function Remove(AFlags: TRemoveFlags = []): TMongoSelector; overload;
    procedure RemoveAll;
    procedure Update(AUpdate: TMongoUpdate; AFlags: TUpdateFlags = [TUpdateFlag.MultiUpdate]); overload;
    function Update(AFlags: TUpdateFlags = [TUpdateFlag.MultiUpdate]): TMongoUpdate; overload;
    // collection querying
    function Count(AQuery: TMongoQuery; AFlags: TMongoQueryFlags = []): Int64; overload;
    function Count(AFlags: TMongoQueryFlags = []): TMongoQuery; overload;
    function Aggregate(APipeline: TMongoPipeline; AFlags: TMongoQueryFlags = []): IMongoCursor; overload;
    function Aggregate(AFlags: TMongoQueryFlags = []): TMongoPipeline; overload;
    function Find(AQuery: TMongoQuery; AFlags: TMongoQueryFlags = []): IMongoCursor; overload;
    function Find(AFlags: TMongoQueryFlags = []): TMongoQuery; overload;
    // execute commands
    function Command(ACommand: TMongoCommand; AFlags: TMongoQueryFlags = []): IMongoCursor; overload;
    function Command(const AJSON: String; AFlags: TMongoQueryFlags = []): IMongoCursor; overload;
    function CommandSimple(ACommand: TMongoDocument): TMongoDocument; overload;
    function CommandSimple(const AJSON: String): TMongoDocument; overload;
    // DBRef lookup
    function Dereference(const AOid: TJsonOid): TMongoDocument;
    // props / state
    property Name: String read GetName;
    property DB: String read GetDB;
    property NS: String read GetNS;
    property IsBulk: Boolean read GetIsBulk;
    property LastError: TMongoDocument read GetLastError;
    property LastID: Variant read FLastID;
    property DocsInserted: Int64 read FDocsInserted;
    property DocsMatched: Int64 read FDocsMatched;
    property DocsModified: Int64 read FDocsModified;
    property DocsRemoved: Int64 read FDocsRemoved;
    property DocsUpserted: Int64 read FDocsRemoved;
    // props / options
    property ReadPreference: TMongoReadPreference read FReadPreference;
    property WriteConcern: TMongoWriteConcern read FWriteConcern;
  end;

implementation

uses
  System.Variants, System.DateUtils, Data.SqlTimSt, Data.FmtBcd,
  FireDAC.Stan.Consts;

{-------------------------------------------------------------------------------}
const
  // mongoc.h
  smongoc_client_new: String = 'mongoc_client_new';
  smongoc_client_destroy: String = 'mongoc_client_destroy';
  smongoc_client_command: String = 'mongoc_client_command';
  smongoc_client_command_simple: String = 'mongoc_client_command_simple';
  smongoc_client_kill_cursor: String = 'mongoc_client_kill_cursor';
  smongoc_client_get_database: String = 'mongoc_client_get_database';
  smongoc_client_get_collection: String = 'mongoc_client_get_collection';
  smongoc_client_find_databases: String = 'mongoc_client_find_databases';
  smongoc_client_get_server_status: String = 'mongoc_client_get_server_status';
  smongoc_client_get_max_message_size: String = 'mongoc_client_get_max_message_size';
  smongoc_client_get_max_bson_size: String = 'mongoc_client_get_max_bson_size';
  smongoc_client_get_write_concern: String = 'mongoc_client_get_write_concern';
  smongoc_client_set_write_concern: String = 'mongoc_client_set_write_concern';
  smongoc_client_get_read_prefs: String = 'mongoc_client_get_read_prefs';
  smongoc_client_set_read_prefs: String = 'mongoc_client_set_read_prefs';
  smongoc_client_set_ssl_opts: String = 'mongoc_client_set_ssl_opts';
  smongoc_client_get_uri: String = 'mongoc_client_get_uri';

  // mongoc-uri.h
  smongoc_uri_get_string: String = 'mongoc_uri_get_string';

  // mongoc-bulk-operation.h
  smongoc_bulk_operation_new: String = 'mongoc_bulk_operation_new';
  smongoc_bulk_operation_destroy: String = 'mongoc_bulk_operation_destroy';
  smongoc_bulk_operation_execute: String = 'mongoc_bulk_operation_execute';
  smongoc_bulk_operation_insert: String = 'mongoc_bulk_operation_insert';
  smongoc_bulk_operation_remove: String = 'mongoc_bulk_operation_remove';
  smongoc_bulk_operation_remove_one: String = 'mongoc_bulk_operation_remove_one';
  smongoc_bulk_operation_replace_one: String = 'mongoc_bulk_operation_replace_one';
  smongoc_bulk_operation_update: String = 'mongoc_bulk_operation_update';
  smongoc_bulk_operation_update_one: String = 'mongoc_bulk_operation_update_one';

  // mongoc-collection.h
  smongoc_collection_aggregate: String = 'mongoc_collection_aggregate';
  smongoc_collection_destroy: String = 'mongoc_collection_destroy';
  smongoc_collection_command: String = 'mongoc_collection_command';
  smongoc_collection_command_simple: String = 'mongoc_collection_command_simple';
  smongoc_collection_count: String = 'mongoc_collection_count';
  smongoc_collection_count_with_opts: String = 'mongoc_collection_count_with_opts';
  smongoc_collection_drop: String = 'mongoc_collection_drop';
  smongoc_collection_drop_index: String = 'mongoc_collection_drop_index';
  smongoc_collection_create_index: String = 'mongoc_collection_create_index';
  smongoc_collection_find_indexes: String = 'mongoc_collection_find_indexes';
  smongoc_collection_find: String = 'mongoc_collection_find';
  smongoc_collection_insert: String = 'mongoc_collection_insert';
  smongoc_collection_update: String = 'mongoc_collection_update';
  smongoc_collection_save: String = 'mongoc_collection_save';
  smongoc_collection_remove: String = 'mongoc_collection_remove';
  smongoc_collection_rename: String = 'mongoc_collection_rename';
  smongoc_collection_find_and_modify: String = 'mongoc_collection_find_and_modify';
  smongoc_collection_stats: String = 'mongoc_collection_stats';
  smongoc_collection_create_bulk_operation: String = 'mongoc_collection_create_bulk_operation';
  smongoc_collection_get_read_prefs: String = 'mongoc_collection_get_read_prefs';
  smongoc_collection_set_read_prefs: String = 'mongoc_collection_set_read_prefs';
  smongoc_collection_get_write_concern: String = 'mongoc_collection_get_write_concern';
  smongoc_collection_set_write_concern: String = 'mongoc_collection_set_write_concern';
  smongoc_collection_get_name: String = 'mongoc_collection_get_name';
  smongoc_collection_get_last_error: String = 'mongoc_collection_get_last_error';
  smongoc_collection_validate: String = 'mongoc_collection_validate';

  // mongoc-cursor.h
  smongoc_cursor_destroy: String = 'mongoc_cursor_destroy';
  smongoc_cursor_more: String = 'mongoc_cursor_more';
  smongoc_cursor_next: String = 'mongoc_cursor_next';
  smongoc_cursor_error: String = 'mongoc_cursor_error';
  smongoc_cursor_current: String = 'mongoc_cursor_current';
  smongoc_cursor_is_alive: String = 'mongoc_cursor_is_alive';

  // mongoc-database.h
  smongoc_database_get_name: String = 'mongoc_database_get_name';
  smongoc_database_remove_user: String = 'mongoc_database_remove_user';
  smongoc_database_remove_all_users: String = 'mongoc_database_remove_all_users';
  smongoc_database_add_user: String = 'mongoc_database_add_user';
  smongoc_database_destroy: String = 'mongoc_database_destroy';
  smongoc_database_command: String = 'mongoc_database_command';
  smongoc_database_command_simple: String = 'mongoc_database_command_simple';
  smongoc_database_drop: String = 'mongoc_database_drop';
  smongoc_database_has_collection: String = 'mongoc_database_has_collection';
  smongoc_database_create_collection: String = 'mongoc_database_create_collection';
  smongoc_database_get_read_prefs: String = 'mongoc_database_get_read_prefs';
  smongoc_database_set_read_prefs: String = 'mongoc_database_set_read_prefs';
  smongoc_database_get_write_concern: String = 'mongoc_database_get_write_concern';
  smongoc_database_set_write_concern: String = 'mongoc_database_set_write_concern';
  smongoc_database_find_collections: String = 'mongoc_database_find_collections';
  smongoc_database_get_collection: String = 'mongoc_database_get_collection';

  // mongoc-index.h
  smongoc_index_opt_get_default: String = 'mongoc_index_opt_get_default';
  smongoc_index_opt_init: String = 'mongoc_index_opt_init';

  // mongoc-init.h
  smongoc_init: String = 'mongoc_init';
  smongoc_cleanup: String = 'mongoc_cleanup';

  // mongoc-log.h
  smongoc_log_set_handler: String = 'mongoc_log_set_handler';
  smongoc_log_default_handler: String = 'mongoc_log_default_handler';
  smongoc_log_level_str: String = 'mongoc_log_level_str';

  // mongoc-matcher.h
  smongoc_matcher_new: String = 'mongoc_matcher_new';
  smongoc_matcher_match: String = 'mongoc_matcher_match';
  smongoc_matcher_destroy: String = 'mongoc_matcher_destroy';

  // mongoc-read-prefs.h
  smongoc_read_prefs_new: String = 'mongoc_read_prefs_new';
  smongoc_read_prefs_destroy: String = 'mongoc_read_prefs_destroy';
  smongoc_read_prefs_copy: String = 'mongoc_read_prefs_copy';
  smongoc_read_prefs_get_mode: String = 'mongoc_read_prefs_get_mode';
  smongoc_read_prefs_set_mode: String = 'mongoc_read_prefs_set_mode';
  smongoc_read_prefs_get_tags: String = 'mongoc_read_prefs_get_tags';
  smongoc_read_prefs_set_tags: String = 'mongoc_read_prefs_set_tags';
  smongoc_read_prefs_add_tag: String = 'mongoc_read_prefs_add_tag';
  smongoc_read_prefs_is_valid: String = 'mongoc_read_prefs_is_valid';

  // mongoc-write-concern.h
  smongoc_write_concern_new: String = 'mongoc_write_concern_new';
  smongoc_write_concern_destroy: String = 'mongoc_write_concern_destroy';
  smongoc_write_concern_copy: String = 'mongoc_write_concern_copy';
  smongoc_write_concern_get_fsync: String = 'mongoc_write_concern_get_fsync';
  smongoc_write_concern_set_fsync: String = 'mongoc_write_concern_set_fsync';
  smongoc_write_concern_get_journal: String = 'mongoc_write_concern_get_journal';
  smongoc_write_concern_set_journal: String = 'mongoc_write_concern_set_journal';
  smongoc_write_concern_get_w: String = 'mongoc_write_concern_get_w';
  smongoc_write_concern_set_w: String = 'mongoc_write_concern_set_w';
  smongoc_write_concern_get_wtag: String = 'mongoc_write_concern_get_wtag';
  smongoc_write_concern_set_wtag: String = 'mongoc_write_concern_set_wtag';
  smongoc_write_concern_get_wtimeout: String = 'mongoc_write_concern_get_wtimeout';
  smongoc_write_concern_set_wtimeout: String = 'mongoc_write_concern_set_wtimeout';
  smongoc_write_concern_get_wmajority: String = 'mongoc_write_concern_get_wmajority';
  smongoc_write_concern_set_wmajority: String = 'mongoc_write_concern_set_wmajority';

  // bson-context.h
  sbson_context_new: String = 'bson_context_new';
  sbson_context_destroy: String = 'bson_context_destroy';
  sbson_context_get_default: String = 'bson_context_get_default';

  // bson-oid.h
  sbson_oid_compare: String = 'bson_oid_compare';
  sbson_oid_copy: String = 'bson_oid_copy';
  sbson_oid_init: String = 'bson_oid_init';
  sbson_oid_init_from_string: String = 'bson_oid_init_from_string';
  sbson_oid_to_string: String = 'bson_oid_to_string';
  sbson_oid_get_time_t: String = 'bson_oid_get_time_t';

  // bson.h
  sbson_mem_set_vtable: String = 'bson_mem_set_vtable';
  sbson_init: String = 'bson_init';
  sbson_init_static: String = 'bson_init_static';
  sbson_reinit: String = 'bson_reinit';
  sbson_new: String = 'bson_new';
  sbson_destroy: String = 'bson_destroy';
  sbson_get_data: String = 'bson_get_data';
  sbson_free: String = 'bson_free';
  sbson_init_from_json: String = 'bson_init_from_json';
  sbson_as_json: String = 'bson_as_json';
  sbson_copy_to: String = 'bson_copy_to';
  sbson_concat: String = 'bson_concat';
  sbson_append_array: String = 'bson_append_array';
  sbson_append_document: String = 'bson_append_document';
  sbson_append_bool: String = 'bson_append_bool';
  sbson_append_code: String = 'bson_append_code';
  sbson_append_code_with_scope: String = 'bson_append_code_with_scope';
  sbson_append_double: String = 'bson_append_double';
  sbson_append_int32: String = 'bson_append_int32';
  sbson_append_int64: String = 'bson_append_int64';
  sbson_append_null: String = 'bson_append_null';
  sbson_append_oid: String = 'bson_append_oid';
  sbson_append_regex: String = 'bson_append_regex';
  sbson_append_utf8: String = 'bson_append_utf8';
  sbson_append_time_t: String = 'bson_append_time_t';
  sbson_append_timeval: String = 'bson_append_timeval';
  sbson_append_date_time: String = 'bson_append_date_time';
  sbson_append_binary: String = 'bson_append_binary';

  // bson-iter.h
  sbson_iter_init: String = 'bson_iter_init';
  sbson_iter_find: String = 'bson_iter_find';
  sbson_iter_find_descendant: String = 'bson_iter_find_descendant';
  sbson_iter_next: String = 'bson_iter_next';
  sbson_iter_recurse: String = 'bson_iter_recurse';
  sbson_iter_key: String = 'bson_iter_key';
  sbson_iter_type: String = 'bson_iter_type';
  sbson_iter_binary: String = 'bson_iter_binary';
  sbson_iter_bool: String = 'bson_iter_bool';
  sbson_iter_code: String = 'bson_iter_code';
  sbson_iter_double: String = 'bson_iter_double';
  sbson_iter_int32: String = 'bson_iter_int32';
  sbson_iter_int64: String = 'bson_iter_int64';
  sbson_iter_oid: String = 'bson_iter_oid';
  sbson_iter_regex: String = 'bson_iter_regex';
  sbson_iter_utf8: String = 'bson_iter_utf8';
  sbson_iter_time_t: String = 'bson_iter_time_t';
  sbson_iter_date_time: String = 'bson_iter_date_time';

{-------------------------------------------------------------------------------}
function QF2mqft(AFlags: TMongoQueryFlags): mongoc_query_flags_t;
begin
  Result := MONGOC_QUERY_NONE;
  if TMongoQueryFlag.TailableCursors in AFlags then
    Result := Result or MONGOC_QUERY_TAILABLE_CURSOR;
  if TMongoQueryFlag.SlaveOk in AFlags then
    Result := Result or MONGOC_QUERY_SLAVE_OK;
  if TMongoQueryFlag.NoCursorTimeout in AFlags then
    Result := Result or MONGOC_QUERY_NO_CURSOR_TIMEOUT;
  if TMongoQueryFlag.AwaitData in AFlags then
    Result := Result or MONGOC_QUERY_AWAIT_DATA;
  if TMongoQueryFlag.Exhaust in AFlags then
    Result := Result or MONGOC_QUERY_EXHAUST;
  if TMongoQueryFlag.Partial in AFlags then
    Result := Result or MONGOC_QUERY_PARTIAL;
end;

{-------------------------------------------------------------------------------}
{ TMongoClientLib                                                               }
{-------------------------------------------------------------------------------}
constructor TMongoClientLib.Create(AOwningObj: TObject);
begin
  inherited Create(S_FD_MongoId, AOwningObj);
end;

{-------------------------------------------------------------------------------}
procedure TMongoClientLib.Load(const AVendorHome, AVendorLib: String);
const
  C_MongoDll: String = 'libmongoc-1.0' + C_FD_DLLExt;
var
  sDLLName: String;
begin
  sDLLName := AVendorHome;
  if sDLLName <> '' then
    sDLLName := FDNormPath(FDNormPath(sDLLName) + C_FD_DLLFolder);
  if AVendorLib <> '' then
    sDLLName := sDLLName + AVendorLib
  else
    sDLLName := sDLLName + C_MongoDll;
  inherited Load([sDLLName], True);
end;

{-------------------------------------------------------------------------------}
procedure TMongoClientLib.LoadEntries;
begin
  // mongoc.h
  Fmongoc_client_new := GetProc(smongoc_client_new);
  Fmongoc_client_destroy := GetProc(smongoc_client_destroy);
  Fmongoc_client_command := GetProc(smongoc_client_command);
  Fmongoc_client_command_simple := GetProc(smongoc_client_command_simple);
  Fmongoc_client_kill_cursor := GetProc(smongoc_client_kill_cursor);
  Fmongoc_client_get_database := GetProc(smongoc_client_get_database);
  Fmongoc_client_get_collection := GetProc(smongoc_client_get_collection);
  Fmongoc_client_find_databases := GetProc(smongoc_client_find_databases);
  Fmongoc_client_get_server_status := GetProc(smongoc_client_get_server_status);
  Fmongoc_client_get_max_message_size := GetProc(smongoc_client_get_max_message_size);
  Fmongoc_client_get_max_bson_size := GetProc(smongoc_client_get_max_bson_size);
  Fmongoc_client_get_write_concern := GetProc(smongoc_client_get_write_concern);
  Fmongoc_client_set_write_concern := GetProc(smongoc_client_set_write_concern);
  Fmongoc_client_get_read_prefs := GetProc(smongoc_client_get_read_prefs);
  Fmongoc_client_set_read_prefs := GetProc(smongoc_client_set_read_prefs);
  Fmongoc_client_set_ssl_opts := GetProc(smongoc_client_set_ssl_opts, False);
  Fmongoc_client_get_uri := GetProc(smongoc_client_get_uri);

  // mongoc-uri.h
  Fmongoc_uri_get_string := GetProc(smongoc_uri_get_string);

  // mongoc-bulk-operation.h
  Fmongoc_bulk_operation_new := GetProc(smongoc_bulk_operation_new);
  Fmongoc_bulk_operation_destroy := GetProc(smongoc_bulk_operation_destroy);
  Fmongoc_bulk_operation_execute := GetProc(smongoc_bulk_operation_execute);
  Fmongoc_bulk_operation_insert := GetProc(smongoc_bulk_operation_insert);
  Fmongoc_bulk_operation_remove := GetProc(smongoc_bulk_operation_remove);
  Fmongoc_bulk_operation_remove_one := GetProc(smongoc_bulk_operation_remove_one);
  Fmongoc_bulk_operation_replace_one := GetProc(smongoc_bulk_operation_replace_one);
  Fmongoc_bulk_operation_update := GetProc(smongoc_bulk_operation_update);
  Fmongoc_bulk_operation_update_one := GetProc(smongoc_bulk_operation_update_one);

  // mongoc-collection.h
  Fmongoc_collection_aggregate := GetProc(smongoc_collection_aggregate);
  Fmongoc_collection_destroy := GetProc(smongoc_collection_destroy);
  Fmongoc_collection_command := GetProc(smongoc_collection_command);
  Fmongoc_collection_command_simple := GetProc(smongoc_collection_command_simple);
  Fmongoc_collection_count := GetProc(smongoc_collection_count);
  Fmongoc_collection_count_with_opts := GetProc(smongoc_collection_count_with_opts);
  Fmongoc_collection_drop := GetProc(smongoc_collection_drop);
  Fmongoc_collection_drop_index := GetProc(smongoc_collection_drop_index);
  Fmongoc_collection_create_index := GetProc(smongoc_collection_create_index);
  Fmongoc_collection_find_indexes := GetProc(smongoc_collection_find_indexes);
  Fmongoc_collection_find := GetProc(smongoc_collection_find);
  Fmongoc_collection_insert := GetProc(smongoc_collection_insert);
  Fmongoc_collection_update := GetProc(smongoc_collection_update);
  Fmongoc_collection_save := GetProc(smongoc_collection_save);
  Fmongoc_collection_remove := GetProc(smongoc_collection_remove);
  Fmongoc_collection_rename := GetProc(smongoc_collection_rename);
  Fmongoc_collection_find_and_modify := GetProc(smongoc_collection_find_and_modify);
  Fmongoc_collection_stats := GetProc(smongoc_collection_stats);
  Fmongoc_collection_create_bulk_operation := GetProc(smongoc_collection_create_bulk_operation);
  Fmongoc_collection_get_read_prefs := GetProc(smongoc_collection_get_read_prefs);
  Fmongoc_collection_set_read_prefs := GetProc(smongoc_collection_set_read_prefs);
  Fmongoc_collection_get_write_concern := GetProc(smongoc_collection_get_write_concern);
  Fmongoc_collection_set_write_concern := GetProc(smongoc_collection_set_write_concern);
  Fmongoc_collection_get_name := GetProc(smongoc_collection_get_name);
  Fmongoc_collection_get_last_error := GetProc(smongoc_collection_get_last_error);
  Fmongoc_collection_validate := GetProc(smongoc_collection_validate);

  // mongoc-cursor.h
  Fmongoc_cursor_destroy := GetProc(smongoc_cursor_destroy);
  Fmongoc_cursor_more := GetProc(smongoc_cursor_more);
  Fmongoc_cursor_next := GetProc(smongoc_cursor_next);
  Fmongoc_cursor_error := GetProc(smongoc_cursor_error);
  Fmongoc_cursor_current := GetProc(smongoc_cursor_current);
  Fmongoc_cursor_is_alive := GetProc(smongoc_cursor_is_alive);

  // mongoc-database.h
  Fmongoc_database_get_name := GetProc(smongoc_database_get_name);
  Fmongoc_database_remove_user := GetProc(smongoc_database_remove_user);
  Fmongoc_database_remove_all_users := GetProc(smongoc_database_remove_all_users);
  Fmongoc_database_add_user := GetProc(smongoc_database_add_user);
  Fmongoc_database_destroy := GetProc(smongoc_database_destroy);
  Fmongoc_database_command := GetProc(smongoc_database_command);
  Fmongoc_database_command_simple := GetProc(smongoc_database_command_simple);
  Fmongoc_database_drop := GetProc(smongoc_database_drop);
  Fmongoc_database_has_collection := GetProc(smongoc_database_has_collection);
  Fmongoc_database_create_collection := GetProc(smongoc_database_create_collection);
  Fmongoc_database_get_read_prefs := GetProc(smongoc_database_get_read_prefs);
  Fmongoc_database_set_read_prefs := GetProc(smongoc_database_set_read_prefs);
  Fmongoc_database_get_write_concern := GetProc(smongoc_database_get_write_concern);
  Fmongoc_database_set_write_concern := GetProc(smongoc_database_set_write_concern);
  Fmongoc_database_find_collections := GetProc(smongoc_database_find_collections);
  Fmongoc_database_get_collection := GetProc(smongoc_database_get_collection);

  // mongoc-index.h
  Fmongoc_index_opt_get_default := GetProc(smongoc_index_opt_get_default);
  Fmongoc_index_opt_init := GetProc(smongoc_index_opt_init);

  // mongoc-init.h
  Fmongoc_init := GetProc(smongoc_init);
  Fmongoc_cleanup := GetProc(smongoc_cleanup);

  // mongoc-log.h
  Fmongoc_log_set_handler := GetProc(smongoc_log_set_handler);
  Fmongoc_log_default_handler := GetProc(smongoc_log_default_handler);
  Fmongoc_log_level_str := GetProc(smongoc_log_level_str);

  // mongoc-matcher.h
  Fmongoc_matcher_new := GetProc(smongoc_matcher_new);
  Fmongoc_matcher_match := GetProc(smongoc_matcher_match);
  Fmongoc_matcher_destroy := GetProc(smongoc_matcher_destroy);

  // mongoc-read-prefs.h
  Fmongoc_read_prefs_new := GetProc(smongoc_read_prefs_new);
  Fmongoc_read_prefs_destroy := GetProc(smongoc_read_prefs_destroy);
  Fmongoc_read_prefs_copy := GetProc(smongoc_read_prefs_copy);
  Fmongoc_read_prefs_get_mode := GetProc(smongoc_read_prefs_get_mode);
  Fmongoc_read_prefs_set_mode := GetProc(smongoc_read_prefs_set_mode);
  Fmongoc_read_prefs_get_tags := GetProc(smongoc_read_prefs_get_tags);
  Fmongoc_read_prefs_set_tags := GetProc(smongoc_read_prefs_set_tags);
  Fmongoc_read_prefs_add_tag := GetProc(smongoc_read_prefs_add_tag);
  Fmongoc_read_prefs_is_valid := GetProc(smongoc_read_prefs_is_valid);

  // mongoc-write-concern.h
  Fmongoc_write_concern_new := GetProc(smongoc_write_concern_new);
  Fmongoc_write_concern_destroy := GetProc(smongoc_write_concern_destroy);
  Fmongoc_write_concern_copy := GetProc(smongoc_write_concern_copy);
  Fmongoc_write_concern_get_fsync := GetProc(smongoc_write_concern_get_fsync);
  Fmongoc_write_concern_set_fsync := GetProc(smongoc_write_concern_set_fsync);
  Fmongoc_write_concern_get_journal := GetProc(smongoc_write_concern_get_journal);
  Fmongoc_write_concern_set_journal := GetProc(smongoc_write_concern_set_journal);
  Fmongoc_write_concern_get_w := GetProc(smongoc_write_concern_get_w);
  Fmongoc_write_concern_set_w := GetProc(smongoc_write_concern_set_w);
  Fmongoc_write_concern_get_wtag := GetProc(smongoc_write_concern_get_wtag);
  Fmongoc_write_concern_set_wtag := GetProc(smongoc_write_concern_set_wtag);
  Fmongoc_write_concern_get_wtimeout := GetProc(smongoc_write_concern_get_wtimeout);
  Fmongoc_write_concern_set_wtimeout := GetProc(smongoc_write_concern_set_wtimeout);
  Fmongoc_write_concern_get_wmajority := GetProc(smongoc_write_concern_get_wmajority);
  Fmongoc_write_concern_set_wmajority := GetProc(smongoc_write_concern_set_wmajority);
end;

{-------------------------------------------------------------------------------}
{ TMongoBSONLib                                                                 }
{-------------------------------------------------------------------------------}
constructor TMongoBSONLib.Create(ACLib: TMongoClientLib);
begin
  inherited Create(ACLib.DriverID, ACLib.OwningObj);
  FCLib := ACLib;
end;

{-------------------------------------------------------------------------------}
{$IFDEF MSWINDOWS}
function _malloc(num_bytes: TFDsize_t): Pointer; cdecl;
begin
  if num_bytes < SizeOf(Pointer) then
    num_bytes := SizeOf(Pointer);
  GetMem(Result, num_bytes);
end;

function _calloc(n_members, num_bytes: TFDsize_t): Pointer; cdecl;
begin
  GetMem(Result, n_members * num_bytes);
  FillChar(Result^, n_members * num_bytes, 0);
end;

function _realloc(mem: Pointer; num_bytes: TFDsize_t): Pointer; cdecl;
begin
  Result := mem;
  if (num_bytes > 0) and (num_bytes < SizeOf(Pointer)) then
    num_bytes := SizeOf(Pointer);
  ReallocMem(Result, num_bytes);
end;

procedure _free(mem: Pointer); cdecl;
begin
  FreeMem(mem);
end;
{$ENDIF}

procedure TMongoBSONLib.Load;
const
  C_BSONDll: String = 'libbson';
var
  i: Integer;
  sPath: String;
{$IFDEF MSWINDOWS}
  rMemTab: bson_mem_vtable_t;
{$ENDIF}
begin
  sPath := ExtractFilePath(FCLib.DLLName) + C_BSONDll;
  i := FCLib.DLLName.LastDelimiter('-');
  if i >= 0 then
    sPath := sPath + FCLib.DLLName.Substring(i)
  else
    sPath := sPath + C_FD_DLLExt;
  inherited Load([sPath], True);

{$IFDEF MSWINDOWS}
  rMemTab.malloc := @_malloc;
  rMemTab.calloc := @_calloc;
  rMemTab.realloc := @_realloc;
  rMemTab.free := @_free;
  Fbson_mem_set_vtable(@rMemTab);
{$ENDIF}
  if FCLib.hDLL <> 0 then
    FCLib.Fmongoc_init();
end;

{-------------------------------------------------------------------------------}
procedure TMongoBSONLib.Unload;
begin
  if FCLib.hDLL <> 0 then
    FCLib.Fmongoc_cleanup();
  inherited Unload;
end;

{-------------------------------------------------------------------------------}
procedure TMongoBSONLib.LoadEntries;
begin
  // bson-context.h
  Fbson_context_new := GetProc(sbson_context_new);
  Fbson_context_destroy := GetProc(sbson_context_destroy);
  Fbson_context_get_default := GetProc(sbson_context_get_default);

  // bson-oid.h
  Fbson_oid_compare := GetProc(sbson_oid_compare);
  Fbson_oid_copy := GetProc(sbson_oid_copy);
  Fbson_oid_init := GetProc(sbson_oid_init);
  Fbson_oid_init_from_string := GetProc(sbson_oid_init_from_string);
  Fbson_oid_to_string := GetProc(sbson_oid_to_string);
  Fbson_oid_get_time_t := GetProc(sbson_oid_get_time_t);

  // bson.h
  Fbson_mem_set_vtable := GetProc(sbson_mem_set_vtable);
  Fbson_init := GetProc(sbson_init);
  Fbson_init_static := GetProc(sbson_init_static);
  fbson_reinit := GetProc(sbson_reinit);
  Fbson_new := GetProc(sbson_new);
  Fbson_destroy := GetProc(sbson_destroy);
  Fbson_get_data := GetProc(sbson_get_data);
  Fbson_free := GetProc(sbson_free);
  Fbson_init_from_json := GetProc(sbson_init_from_json);
  Fbson_as_json := GetProc(sbson_as_json);
  Fbson_copy_to := GetProc(sbson_copy_to);
  Fbson_concat := GetProc(sbson_concat);
  Fbson_append_array := GetProc(sbson_append_array);
  Fbson_append_document := GetProc(sbson_append_document);
  Fbson_append_bool := GetProc(sbson_append_bool);
  Fbson_append_code := GetProc(sbson_append_code);
  Fbson_append_code_with_scope := GetProc(sbson_append_code_with_scope);
  Fbson_append_double := GetProc(sbson_append_double);
  Fbson_append_int32 := GetProc(sbson_append_int32);
  Fbson_append_int64 := GetProc(sbson_append_int64);
  Fbson_append_null := GetProc(sbson_append_null);
  Fbson_append_oid := GetProc(sbson_append_oid);
  Fbson_append_regex := GetProc(sbson_append_regex);
  Fbson_append_utf8 := GetProc(sbson_append_utf8);
  Fbson_append_time_t := GetProc(sbson_append_time_t);
  Fbson_append_timeval := GetProc(sbson_append_timeval);
  Fbson_append_date_time := GetProc(sbson_append_date_time);
  Fbson_append_binary := GetProc(sbson_append_binary);

  // bson-iter.h
  Fbson_iter_init := GetProc(sbson_iter_init);
  Fbson_iter_find := GetProc(sbson_iter_find);
  Fbson_iter_find_descendant := GetProc(sbson_iter_find_descendant);
  Fbson_iter_next := GetProc(sbson_iter_next);
  Fbson_iter_recurse := GetProc(sbson_iter_recurse);
  Fbson_iter_key := GetProc(sbson_iter_key);
  Fbson_iter_type := GetProc(sbson_iter_type);
  Fbson_iter_binary := GetProc(sbson_iter_binary);
  Fbson_iter_bool := GetProc(sbson_iter_bool);
  Fbson_iter_code := GetProc(sbson_iter_code);
  Fbson_iter_double := GetProc(sbson_iter_double);
  Fbson_iter_int32 := GetProc(sbson_iter_int32);
  Fbson_iter_int64 := GetProc(sbson_iter_int64);
  Fbson_iter_oid := GetProc(sbson_iter_oid);
  Fbson_iter_regex := GetProc(sbson_iter_regex);
  Fbson_iter_utf8 := GetProc(sbson_iter_utf8);
  Fbson_iter_time_t := GetProc(sbson_iter_time_t);
  Fbson_iter_date_time := GetProc(sbson_iter_date_time);
end;

{-------------------------------------------------------------------------------}
{ TMongoObject                                                                  }
{-------------------------------------------------------------------------------}
constructor TMongoObject.Create(AEnv: TMongoEnv; AOwningObj: TObject);
begin
  inherited Create;
  FEnv := AEnv;
  FOwningObj := AOwningObj;
  FOwnHandle := True;
end;

{-------------------------------------------------------------------------------}
constructor TMongoObject.Create(AEnv: TMongoEnv; AOwningObj: TObject;
  AHandle: Pmongoc_handle_t);
begin
  Create(AEnv, AOwningObj);
  FHandle := AHandle;
end;

{-------------------------------------------------------------------------------}
destructor TMongoObject.Destroy;
begin
  FreeHandle;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TMongoObject.InternalFreeHandle;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TMongoObject.FreeHandle;
begin
  if FOwnHandle and (Handle <> nil) then
    InternalFreeHandle;
  FHandle := nil;
  FOwnHandle := True;
end;

{-------------------------------------------------------------------------------}
procedure TMongoObject.HandleAllocated;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TMongoObject.GetHandle: Pmongoc_handle_t;
begin
  if Self = nil then
    Result := nil
  else
    Result := FHandle;
end;

{-------------------------------------------------------------------------------}
procedure TMongoObject.SetHandle(const AValue: Pmongoc_handle_t);
begin
  if Handle <> AValue then begin
    if Handle <> nil then
      FreeHandle;
    FHandle := AValue;
    FOwnHandle := FHandle = nil;
    if Handle <> nil then
      HandleAllocated;
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoObject.GetError: TMongoError;
begin
  Result := FEnv.Error;
end;

{-------------------------------------------------------------------------------}
function TMongoObject.GetCLib: TMongoClientLib;
begin
  Result := FEnv.CLib;
end;

{-------------------------------------------------------------------------------}
function TMongoObject.GetBLib: TMongoBSONLib;
begin
  Result := FEnv.BLib;
end;

{-------------------------------------------------------------------------------}
{ TFDMongoError                                                                 }
{-------------------------------------------------------------------------------}
procedure TFDMongoError.Assign(ASrc: TFDDBError);
begin
  inherited Assign(ASrc);
  if ASrc is TFDMongoError then
    FDomain := TFDMongoError(ASrc).FDomain;
end;

{-------------------------------------------------------------------------------}
procedure TFDMongoError.LoadFromStorage(const AStorage: IFDStanStorage);
begin
  inherited LoadFromStorage(AStorage);
  FDomain := AStorage.ReadLongWord('Domain', 0);
end;

{-------------------------------------------------------------------------------}
procedure TFDMongoError.SaveToStorage(const AStorage: IFDStanStorage);
begin
  inherited SaveToStorage(AStorage);
  AStorage.WriteInteger('Domain', Domain, 0);
end;

{-------------------------------------------------------------------------------}
{ EMongoNativeException                                                         }
{-------------------------------------------------------------------------------}
constructor EMongoNativeException.Create(AError: TMongoError);
var
  sMsg: String;
begin
  sMsg := AError.Env.ANSI.Decode(@AError.BError.message[0]);
  inherited Create(er_FD_MongoGeneral, FDExceptionLayers([S_FD_LPhys,
    AError.FEnv.CLib.DriverID]) + sMsg);
  AppendError(1, AError.BError.code, AError.BError.domain, sMsg, -1);
{$IFDEF FireDAC_MONITOR}
  AError.Env.Trace(ekError, esProgress, 'ERROR: ' + Message,
    ['Domain', AError.BError.domain]);
{$ENDIF}
  AError.FBError.domain := 0;
  AError.FBError.code := 0;
  FillChar(AError.FBError.message[0], SizeOf(AError.FBError.message), 0);
end;

{-------------------------------------------------------------------------------}
function EMongoNativeException.AppendError(ALevel, AErrorCode: Integer;
  ADomain: Cardinal; const AMessage: String; ARowIndex: Integer): TFDMongoError;
var
  sObj: String;
  eKind: TFDCommandExceptionKind;
  i1: Integer;
  i2: Integer;
begin
  sObj := '';
  eKind := ekOther;
  case AErrorCode of
  MONGOC_ERROR_STREAM_SOCKET,
  MONGOC_ERROR_STREAM_CONNECT:
    eKind := ekServerGone;
  MONGOC_ERROR_CLIENT_AUTHENTICATE:
    eKind := ekUserPwdInvalid;
  MONGOC_ERROR_QUERY_COMMAND_NOT_FOUND:
    eKind := ekObjNotExists;
  11000:
    begin
      i1 := Pos(': ', AMessage);
      if i1 > 0 then begin
        i2 := Pos(' dup key', AMessage, i1);
        if i2 > 0 then
          sObj := Copy(AMessage, i1 + 2, i2 - i1 - 2);
      end;
      eKind := ekUKViolated;
    end;
  end;
  Result := TFDMongoError(AppendError(ALevel, AErrorCode, AMessage, sObj,
    eKind, -1, ARowIndex));
  Result.FDomain := ADomain;
end;

{-------------------------------------------------------------------------------}
function EMongoNativeException.GetErrorClass: TFDDBErrorClass;
begin
  Result := TFDMongoError;
end;

{-------------------------------------------------------------------------------}
function EMongoNativeException.GetErrors(AIndex: Integer): TFDMongoError;
begin
  Result := TFDMongoError(inherited Errors[AIndex]);
end;

{-------------------------------------------------------------------------------}
{ TMongoError                                                                   }
{-------------------------------------------------------------------------------}
procedure TMongoError.CheckError(AInitiator: TObject = nil; const AMethod: String = '');
var
  oEx: EMongoNativeException;
begin
  if (FBError.domain = 0) and (FBError.code = 0) and (AMethod = '') then
    Exit;
  if AInitiator = nil then
    AInitiator := OwningObj;
  if (FBError.domain = 0) and (FBError.code = 0) then
    FDException(AInitiator, [S_FD_LPhys, Env.CLib.DriverID], er_FD_MongoError, [AMethod])
  else begin
    oEx := EMongoNativeException.Create(Self);
    FDException(AInitiator, oEx {$IFDEF FireDAC_Monitor}, Env.Tracing {$ENDIF});
  end;
end;

{-------------------------------------------------------------------------------}
{ TMongoEnv                                                                     }
{-------------------------------------------------------------------------------}
constructor TMongoEnv.Create(ACLib: TMongoClientLib; ABLib: TMongoBSONLib;
  AOwningObj: TObject);
begin
  inherited Create;
  FCLib := ACLib;
  FBLib := ABLib;
  FError := TMongoError.Create(Self, AOwningObj);
  FOwningObj := AOwningObj;
  FBuffer := TFDBuffer.Create;
  FANSI := TFDEncoder.Create(FBuffer);
  FANSI.Encoding := ecANSI;
  FUTF8 := TFDEncoder.Create(FBuffer);
  FUTF8.Encoding := ecUTF8;
end;

{-------------------------------------------------------------------------------}
destructor TMongoEnv.Destroy;
begin
  FDFreeAndNil(FError);
  FDFreeAndNil(FBuffer);
  FDFreeAndNil(FANSI);
  FDFreeAndNil(FUTF8);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TMongoEnv.NewDoc: TMongoDocument;
begin
  Result := TMongoDocument.Create(Self);
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
function TMongoEnv.GetTracing: Boolean;
begin
  Result := (FMonitor <> nil) and FMonitor.Tracing and FTracing;
end;

{-------------------------------------------------------------------------------}
procedure TMongoEnv.Trace(const AMsg: String; const AArgs: array of const);
begin
  if GetTracing then
    FMonitor.Notify(ekVendor, esProgress, OwningObj, AMsg, AArgs);
end;

{-------------------------------------------------------------------------------}
procedure TMongoEnv.Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
  const AMsg: String; const AArgs: array of const);
begin
  if GetTracing then
    FMonitor.Notify(AKind, AStep, OwningObj, AMsg, AArgs);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TMongoOID                                                                     }
{-------------------------------------------------------------------------------}
constructor TMongoOID.Create(AEnv: TMongoEnv; AOwningObj: TObject);
begin
  inherited Create(AEnv, AOwningObj);
  GetMem(FHandle, SizeOf(bson_oid_t));
end;

{-------------------------------------------------------------------------------}
procedure TMongoOID.InternalFreeHandle;
begin
  FreeMem(FHandle);
  FHandle := nil;
end;

{-------------------------------------------------------------------------------}
procedure TMongoOID.Init;
begin
  BLib.Fbson_oid_init(Handle, nil);
end;

{-------------------------------------------------------------------------------}
procedure TMongoOID.Clear;
begin
  FillChar(Handle^, SizeOf(bson_oid_t), 0);
end;

{-------------------------------------------------------------------------------}
procedure TMongoOID.Assign(ASource: TMongoOID);
begin
  BLib.Fbson_oid_copy(ASource.Handle, Handle);
end;

{-------------------------------------------------------------------------------}
function TMongoOID.GetAsDateTime: TDateTime;
begin
  Result := UnixToDateTime(BLib.Fbson_oid_get_time_t(Handle), False);
end;

{-------------------------------------------------------------------------------}
function TMongoOID.GetAsString: String;
var
  buff: array [0 .. 63] of Byte;
begin
  BLib.Fbson_oid_to_string(Handle, PFDAnsiString(@buff[0]));
  Result := Env.ANSI.Decode(@buff[0]);
end;

{-------------------------------------------------------------------------------}
procedure TMongoOID.SetAsString(const AValue: String);
var
  sb: TFDByteString;
begin
  sb := Env.ANSI.Encode(AValue);
  BLib.Fbson_oid_init_from_string(Handle, PFDAnsiString(PByte(sb)));
end;

{-------------------------------------------------------------------------------}
function TMongoOID.GetAsOid: TJsonOid;
begin
  Result := TJsonOid(Handle^);
end;

{-------------------------------------------------------------------------------}
procedure TMongoOID.SetAsOid(const AValue: TJsonOid);
begin
  TJsonOid(Handle^) := AValue;
end;

{-------------------------------------------------------------------------------}
{ TMongoDocument.TBuilder                                                       }
{-------------------------------------------------------------------------------}
constructor TMongoDocument.TBuilder.Create(const AJSONWriter: TJSONWriter;
  ADoc: TMongoDocument);
begin
  inherited Create(AJSONWriter);
  FDoc := ADoc;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.TBuilder.DoGetReader(AWriter: TJsonWriter): TJsonReader;
var
  oWStr, oRStr: TFDReadSharedMemoryStream;
begin
  oWStr := (AWriter as TBsonWriter).Writer.BaseStream as TFDReadSharedMemoryStream;
  oRStr := TFDReadSharedMemoryStream.Create;
  oRStr.SetData(oWStr.Memory, oWStr.Size);
  Result := TBsonReader.Create(oRStr);
end;

{-------------------------------------------------------------------------------}
procedure TMongoDocument.TBuilder.DoReleaseReader(AWriter: TJsonWriter;
  AReader: TJsonReader);
var
  oRStr: TFDReadSharedMemoryStream;
begin
  oRStr := (AReader as TBsonReader).Reader.BaseStream as TFDReadSharedMemoryStream;
  FDFree(oRStr);
  FDFree(AReader);
end;

{-------------------------------------------------------------------------------}
procedure TMongoDocument.TBuilder.DoResetWriter(AWriter: TJsonWriter);
begin
  FDoc.Cleanup(False);
end;

{-------------------------------------------------------------------------------}
procedure TMongoDocument.TBuilder.DoWriteCustomVariant(AWriter: TJsonWriter;
  const AValue: Variant);
begin
  if VarIsFMTBcd(AValue) then
    AWriter.WriteValue(Extended(AValue))
  else if VarIsSQLTimeStamp(AValue) or VarIsSQLTimeStampOffset(AValue) then
    AWriter.WriteValue(TDateTime(AValue))
  else
    inherited DoWriteCustomVariant(AWriter, AValue);
end;

{-------------------------------------------------------------------------------}
{ TMongoDocument.TIterator                                                      }
{-------------------------------------------------------------------------------}
constructor TMongoDocument.TIterator.Create(ADoc: TMongoDocument);
begin
  ADoc.CheckClosed;
  FStream := TFDReadSharedMemoryStream.Create;
  TFDReadSharedMemoryStream(FStream).SetData(ADoc.FStream.Memory, ADoc.FStream.Size);
  FReader := TBsonReader.Create(FStream);
  inherited Create(FReader);
end;

{-------------------------------------------------------------------------------}
destructor TMongoDocument.TIterator.Destroy;
begin
  FDFreeAndNil(FReader);
  FDFreeAndNil(FStream);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TMongoDocument.TIterator.DoRewindReader(AReader: TJsonReader);
var
  oRStr: TFDReadSharedMemoryStream;
begin
  oRStr := (AReader as TBsonReader).Reader.BaseStream as TFDReadSharedMemoryStream;
  oRStr.Position := 0;
end;

{-------------------------------------------------------------------------------}
{ TMongoDocument                                                                }
{-------------------------------------------------------------------------------}
constructor TMongoDocument.Create(AEnv: TMongoEnv; AOwningObj, AParentObj: TObject);
begin
  inherited Create(AEnv, AOwningObj);
  FParentObj := AParentObj;
  FStream := TFDReadSharedMemoryStream.Create;
  FWriter := TBsonWriter.Create(FStream);
  FBuilder := TBuilder.Create(FWriter, Self);
  FBuilder.BeginObject;
  FHandleType := THandleType.RTL;
end;

{-------------------------------------------------------------------------------}
constructor TMongoDocument.Create(AEnv: TMongoEnv);
begin
  Create(AEnv, AEnv.OwningObj, TObject(nil));
end;

{-------------------------------------------------------------------------------}
destructor TMongoDocument.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FBuilder);
  FDFreeAndNil(FWriter);
  FDFreeAndNil(FStream);
end;

{-------------------------------------------------------------------------------}
procedure TMongoDocument.InternalFreeHandle;
begin
  Cleanup(True);
end;

{-------------------------------------------------------------------------------}
procedure TMongoDocument.ErrorReadOnly;
begin
  FDException(OwningObj, [S_FD_LPhys, S_FD_MongoId], er_FD_MongoDocReadOnly, []);
end;

{-------------------------------------------------------------------------------}
procedure TMongoDocument.Cleanup(AClearBuilder: Boolean);
begin
  if AClearBuilder then
    FBuilder.Clear;
  case FHandleType of
  THandleType.ReadInternal:
    begin
      FStream.Size := 0;
      FreeMem(FHandle, SizeOf(bson_t));
      FHandle := nil;
    end;
  THandleType.ReadExternal:
    TFDReadSharedMemoryStream(FStream).SetData(nil, 0);
  THandleType.WriteExternal:
    begin
      BLib.Fbson_destroy(FHandle);
      FreeMem(FHandle, SizeOf(bson_t));
      FHandle := nil;
    end;
  THandleType.RTL:
    FStream.Size := 0;
  end;
  FHandleType := THandleType.RTL;
end;

{-------------------------------------------------------------------------------}
procedure TMongoDocument.AttachToImpl(const AValue: Pbson_t);
var
  pData: Pointer;
  iLen: Cardinal;
begin
  if AValue = nil then begin
    pData := nil;
    iLen := 0;
  end
  else begin
    iLen := AValue^.len;
    pData := BLib.Fbson_get_data(AValue);
  end;
  TFDReadSharedMemoryStream(FStream).SetData(pData, iLen);
end;

{-------------------------------------------------------------------------------}
procedure TMongoDocument.CheckClosed;
begin
  case FHandleType of
  THandleType.ReadInternal,
  THandleType.RTL:
    FWriter.Flush;
  THandleType.WriteExternal:
    AttachToImpl(FHandle);
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.GetAsReadHandle: Pbson_t;
begin
  if Self = nil then begin
    Result := nil;
    Exit;
  end;
  CheckClosed;
  if FHandleType in [THandleType.RTL, THandleType.ReadExternal] then begin
    if FHandle = nil then
      GetMem(FHandle, SizeOf(bson_t));
    if not BLib.Fbson_init_static(FHandle, FStream.Memory, FStream.Size) then
      FDException(OwningObj, [S_FD_LPhys, S_FD_MongoId], er_FD_MongoFailedInitBSON, []);
    FHandleType := THandleType.ReadInternal;
  end;
  Result := FHandle;
end;

{-------------------------------------------------------------------------------}
procedure TMongoDocument.SetAsReadHandle(const AValue: Pbson_t);
begin
  Cleanup(True);
  AttachToImpl(AValue);
  FHandleType := THandleType.ReadExternal;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.GetAsWriteHandle: Pbson_t;
begin
  if Self = nil then begin
    Result := nil;
    Exit;
  end;
  Cleanup(True);
  if FHandle = nil then
    GetMem(FHandle, SizeOf(bson_t));
  BLib.Fbson_init(FHandle);
  Result := FHandle;
  FHandleType := THandleType.WriteExternal;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.GetAsJSON: String;
begin
  if Self = nil then
    Result := ''
  else begin
    CheckClosed;
    Result := FBuilder.AsJSON;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMongoDocument.SetAsJSON(const AValue: String);
begin
  FBuilder
    .Clear
    .BeginObject
      .AddPairs(AValue);
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.GetInObject: Boolean;
begin
  Result := FBuilder.ParentType = TJSONCollectionBuilder.TParentType.Pairs;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.GetPairs: TJSONCollectionBuilder.TPairs;
begin
  Result := FBuilder.ParentObject;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.GetInArray: Boolean;
begin
  Result := FBuilder.ParentType = TJSONCollectionBuilder.TParentType.Elements;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.GetElements: TJSONCollectionBuilder.TElements;
begin
  Result := FBuilder.ParentArray;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.GetBuilder: TJSONObjectBuilder;
begin
  if FBuilder.ParentType = TJSONCollectionBuilder.TParentType.None then
    ErrorReadOnly;
  Result := FBuilder;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Iterator: TJSONIterator;
begin
  Result := TIterator.Create(Self);
end;

{-------------------------------------------------------------------------------}
procedure TMongoDocument.Iterate(AFunc: TJSONIterator.TIterateFunc);
var
  oIter: TJSONIterator;
begin
  oIter := Iterator;
  try
    oIter.Iterate(AFunc);
  finally
    oIter.Free;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMongoDocument.Assign(ASource: TMongoDocument);
begin
  FBuilder
    .Clear
    .BeginObject
      .AddPairs(ASource.FBuilder);
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Clear: TMongoDocument;
begin
  FBuilder
    .Clear
    .BeginObject;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
procedure TMongoDocument.Close;
begin
  while True do
    case FBuilder.ParentType of
      TJSONCollectionBuilder.TParentType.None:     Break;
      TJSONCollectionBuilder.TParentType.Elements: EndArray;
      TJSONCollectionBuilder.TParentType.Pairs:    EndObject;
    end;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Add(const AKey, AValue: String): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.Add(AValue);
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.Add(AKey, AValue);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Add(const AKey: String; const AValue: Int32): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.Add(AValue);
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.Add(AKey, AValue);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Add(const AKey: String; const AValue: Int64): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.Add(AValue);
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.Add(AKey, AValue);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Add(const AKey: String; const AValue: Extended): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.Add(AValue);
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.Add(AKey, AValue);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Add(const AKey: String; const AValue: Boolean): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.Add(AValue);
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.Add(AKey, AValue);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Add(const AKey: String; const AValue: TDateTime): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.Add(AValue);
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.Add(AKey, AValue);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Add(const AKey: String; const AValue: TBytes;
  ABinaryType: TJsonBinaryType = TJsonBinaryType.Generic): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.Add(AValue, ABinaryType);
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.Add(AKey, AValue, ABinaryType);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Add(const AKey: String; const AValue: TMongoOID): TMongoDocument;
begin
  Result := Add(AKey, TJsonOid(AValue.Handle^));
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Add(const AKey: String; const AValue: TJsonOid): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.Add(AValue);
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.Add(AKey, AValue);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Add(const AKey: String; const AValue: TJsonRegEx): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.Add(AValue);
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.Add(AKey, AValue);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Add(const AKey: String; const AValue: TJsonDBRef): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.Add(AValue);
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.Add(AKey, AValue);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Add(const AKey: String; const AValue: TJsonCodeWScope): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.Add(AValue);
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.Add(AKey, AValue);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Add(const AKey: String; const AValue: TVarRec): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.Add(AValue);
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.Add(AKey, AValue);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Add(const AKey: String; const AValues: array of const): TMongoDocument;
var
  oElems: TJSONCollectionBuilder.TElements;
begin
  oElems := nil;
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: oElems := Elements.BeginArray;
    TJSONCollectionBuilder.TParentType.Pairs:    oElems := Pairs.BeginArray(AKey);
  end;
  oElems.AddElements(AValues);
  oElems.EndArray;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Add(const AKey: String; const AValue: Variant): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.Add(AValue);
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.Add(AKey, AValue);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.AddNull(const AKey: String): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.AddNull;
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.AddNull(AKey);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.AddUndefined(const AKey: String): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.AddUndefined;
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.AddUndefined(AKey);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.AddMinKey(const AKey: String): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.AddMinKey;
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.AddMinKey(AKey);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.AddMaxKey(const AKey: String): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.AddMaxKey;
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.AddMaxKey(AKey);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.BeginArray(const AKey: String): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.BeginArray;
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.BeginArray(AKey);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.EndArray: TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    else                                         Elements.EndArray;
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.BeginObject(const AKey: String): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.BeginObject;
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.BeginObject(AKey);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.EndObject: TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    else                                         Pairs.EndObject;
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Append(const ADoc: TMongoDocument): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.AddElements(ADoc.FBuilder);
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.AddPairs(ADoc.FBuilder);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Append(const AJSON: String): TMongoDocument;
begin
  if AJSON <> '' then
    case FBuilder.ParentType of
      TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
      TJSONCollectionBuilder.TParentType.Elements: Elements.AddElements(AJSON);
      TJSONCollectionBuilder.TParentType.Pairs:    Pairs.AddPairs(AJSON);
    end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoDocument.Append(const AItems: array of const): TMongoDocument;
begin
  case FBuilder.ParentType of
    TJSONCollectionBuilder.TParentType.None:     ErrorReadOnly;
    TJSONCollectionBuilder.TParentType.Elements: Elements.AddElements(AItems);
    TJSONCollectionBuilder.TParentType.Pairs:    Pairs.AddPairs(AItems);
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
{ TMongoReadPreference                                                          }
{-------------------------------------------------------------------------------}
constructor TMongoReadPreference.Create(AEnv: TMongoEnv; AOwningObj: TObject;
  AHandle: Pmongoc_read_prefs_t);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_read_prefs_new, ['read_mode', MONGOC_READ_PRIMARY]);
  end;
{$ENDIF}

begin
  inherited Create(AEnv, AOwningObj);
  if AHandle = nil then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    FHandle := CLib.Fmongoc_read_prefs_new(MONGOC_READ_PRIMARY);
  end
  else begin
    FHandle := AHandle;
    FOwnHandle := False;
  end;
  FTags := TMongoDocument.Create(AEnv, AOwningObj, Self);
end;

{-------------------------------------------------------------------------------}
destructor TMongoReadPreference.Destroy;
begin
  FDFreeAndNil(FTags);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TMongoReadPreference.InternalFreeHandle;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_read_prefs_destroy, ['read_prefs', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  CLib.Fmongoc_read_prefs_destroy(Handle);
end;

{-------------------------------------------------------------------------------}
procedure TMongoReadPreference.Assign(ASource: TMongoReadPreference);
begin
  Mode := ASource.Mode;
  Tags := ASource.Tags;
end;

{-------------------------------------------------------------------------------}
function TMongoReadPreference.GetMode: TReadMode;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_read_prefs_get_mode, ['read_prefs', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  case CLib.Fmongoc_read_prefs_get_mode(Handle) of
  MONGOC_READ_PRIMARY:             Result := TReadMode.Primary;
  MONGOC_READ_SECONDARY:           Result := TReadMode.Secondary;
  MONGOC_READ_PRIMARY_PREFERRED:   Result := TReadMode.PrimaryPreferred;
  MONGOC_READ_SECONDARY_PREFERRED: Result := TReadMode.SecondaryPreferred;
  MONGOC_READ_NEAREST:             Result := TReadMode.Nearest;
  else                             Result := TReadMode.Primary;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMongoReadPreference.SetMode(const AValue: TReadMode);
var
  iMode: Cardinal;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_read_prefs_set_mode, ['read_prefs', Handle, 'mode', iMode]);
  end;
{$ENDIF}

begin
  case AValue of
  TReadMode.Primary:            iMode := MONGOC_READ_PRIMARY;
  TReadMode.Secondary:          iMode := MONGOC_READ_SECONDARY;
  TReadMode.PrimaryPreferred:   iMode := MONGOC_READ_PRIMARY_PREFERRED;
  TReadMode.SecondaryPreferred: iMode := MONGOC_READ_SECONDARY_PREFERRED;
  TReadMode.Nearest:            iMode := MONGOC_READ_NEAREST;
  else                          iMode := MONGOC_READ_PRIMARY;
  end;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  CLib.Fmongoc_read_prefs_set_mode(Handle, iMode);
end;

{-------------------------------------------------------------------------------}
function TMongoReadPreference.GetTags: TMongoDocument;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_read_prefs_get_tags, ['read_prefs', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  FTags.AsReadHandle := CLib.Fmongoc_read_prefs_get_tags(Handle);
  Result := FTags;
end;

{-------------------------------------------------------------------------------}
procedure TMongoReadPreference.SetTags(const AValue: TMongoDocument);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_read_prefs_set_tags, ['read_prefs', Handle, 'tags', AValue.AsJSON]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  CLib.Fmongoc_read_prefs_set_tags(Handle, AValue.AsReadHandle);
end;

{-------------------------------------------------------------------------------}
procedure TMongoReadPreference.AddTag(ATag: TMongoDocument);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_read_prefs_add_tag, ['read_prefs', Handle, 'tags', ATag.AsJSON]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  CLib.Fmongoc_read_prefs_add_tag(Handle, ATag.AsReadHandle);
end;

{-------------------------------------------------------------------------------}
{ TMongoWriteConcern                                                            }
{-------------------------------------------------------------------------------}
constructor TMongoWriteConcern.Create(AEnv: TMongoEnv; AOwningObj: TObject;
  AHandle: Pmongoc_write_concern_t);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_write_concern_new, []);
  end;
{$ENDIF}

begin
  inherited Create(AEnv, AOwningObj);
  if AHandle = nil then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    FHandle := CLib.Fmongoc_write_concern_new();
  end
  else begin
    FHandle := AHandle;
    FOwnHandle := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMongoWriteConcern.InternalFreeHandle;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_write_concern_destroy, ['write_concern', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  CLib.Fmongoc_write_concern_destroy(Handle);
end;

{-------------------------------------------------------------------------------}
procedure TMongoWriteConcern.Assign(ASource: TMongoWriteConcern);
begin
  Level := ASource.Level;
  Fsync := ASource.Fsync;
  Journal := ASource.Journal;
  Majority := ASource.Majority;
  Tag := ASource.Tag;
  Timeout := ASource.Timeout;
end;

{-------------------------------------------------------------------------------}
function TMongoWriteConcern.GetLevel: TWriteLevel;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_write_concern_get_w, ['write_concern', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  case CLib.Fmongoc_write_concern_get_w(Handle) of
  MONGOC_WRITE_CONCERN_W_UNACKNOWLEDGED: Result := TWriteLevel.Unacknowledged;
  MONGOC_WRITE_CONCERN_W_ERRORS_IGNORED: Result := TWriteLevel.ErrorsIgnored;
  MONGOC_WRITE_CONCERN_W_DEFAULT:        Result := TWriteLevel.Default;
  MONGOC_WRITE_CONCERN_W_MAJORITY:       Result := TWriteLevel.Majority;
  else                                   Result := TWriteLevel.Default;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMongoWriteConcern.SetLevel(const AValue: TWriteLevel);
var
  iMode: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_write_concern_set_w, ['write_concern', Handle, 'w', iMode]);
  end;
{$ENDIF}

begin
  case AValue of
  TWriteLevel.Default:        iMode := MONGOC_WRITE_CONCERN_W_DEFAULT;
  TWriteLevel.ErrorsIgnored:  iMode := MONGOC_WRITE_CONCERN_W_ERRORS_IGNORED;
  TWriteLevel.Unacknowledged: iMode := MONGOC_WRITE_CONCERN_W_UNACKNOWLEDGED;
  TWriteLevel.Majority:       iMode := MONGOC_WRITE_CONCERN_W_MAJORITY;
  else                        iMode := MONGOC_WRITE_CONCERN_W_DEFAULT;
  end;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  CLib.Fmongoc_write_concern_set_w(Handle, iMode);
end;

{-------------------------------------------------------------------------------}
function TMongoWriteConcern.GetFsync: Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_write_concern_get_fsync, ['write_concern', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Result := CLib.Fmongoc_write_concern_get_fsync(Handle);
end;

{-------------------------------------------------------------------------------}
procedure TMongoWriteConcern.SetFsync(const AValue: Boolean);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_write_concern_set_fsync, ['write_concern', Handle, 'fsync_', AValue]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  CLib.Fmongoc_write_concern_set_fsync(Handle, AValue);
end;

{-------------------------------------------------------------------------------}
function TMongoWriteConcern.GetJournal: Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_write_concern_get_journal, ['write_concern', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Result := CLib.Fmongoc_write_concern_get_journal(Handle);
end;

{-------------------------------------------------------------------------------}
procedure TMongoWriteConcern.SetJournal(const AValue: Boolean);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_write_concern_set_journal, ['write_concern', Handle, 'journal', AValue]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  CLib.Fmongoc_write_concern_set_journal(Handle, AValue);
end;

{-------------------------------------------------------------------------------}
function TMongoWriteConcern.GetMajority: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_write_concern_get_wmajority, ['write_concern', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Result := CLib.Fmongoc_write_concern_get_wmajority(Handle);
end;

{-------------------------------------------------------------------------------}
procedure TMongoWriteConcern.SetMajority(const AValue: Integer);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_write_concern_set_wmajority, ['write_concern', Handle,
      'wtimeout_msec', AValue]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  CLib.Fmongoc_write_concern_set_wmajority(Handle, AValue);
end;

{-------------------------------------------------------------------------------}
function TMongoWriteConcern.GetTag: String;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_write_concern_get_wtag, ['write_concern', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Result := Env.UTF8.Decode(Pointer(CLib.Fmongoc_write_concern_get_wtag(Handle)));
end;

{-------------------------------------------------------------------------------}
procedure TMongoWriteConcern.SetTag(const AValue: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_write_concern_set_wtag, ['write_concern', Handle, 'tag', AValue]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  CLib.Fmongoc_write_concern_set_wtag(Handle, PFDAnsiString(PByte(Env.UTF8.Encode(AValue))));
end;

{-------------------------------------------------------------------------------}
function TMongoWriteConcern.GetTimeout: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_write_concern_get_wtimeout, ['write_concern', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Result := CLib.Fmongoc_write_concern_get_wtimeout(Handle);
end;

{-------------------------------------------------------------------------------}
procedure TMongoWriteConcern.SetTimeout(const AValue: Integer);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_write_concern_set_wtimeout, ['write_concern', Handle,
      'wtimeout_msec', AValue]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  CLib.Fmongoc_write_concern_set_wtimeout(Handle, AValue);
end;

{-------------------------------------------------------------------------------}
{ TMongoExpression                                                              }
{-------------------------------------------------------------------------------}
constructor TMongoExpression<T>.Create(AEnv: TMongoEnv; AOwningObj: TObject; AParentObj: T);
begin
  inherited Create;
  FDoc := TMongoDocument.Create(AEnv, AOwningObj, AParentObj);
end;

{-------------------------------------------------------------------------------}
constructor TMongoExpression<T>.Create(AEnv: TMongoEnv);
begin
  Create(AEnv, nil, nil);
end;

{-------------------------------------------------------------------------------}
destructor TMongoExpression<T>.Destroy;
begin
  FDFreeAndNil(FDoc);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.GetAsJSON: String;
begin
  Result := FDoc.AsJSON;
end;

{-------------------------------------------------------------------------------}
procedure TMongoExpression<T>.SetAsJSON(const AValue: String);
begin
  FDoc.AsJSON := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TMongoExpression<T>.Assign(ASource: TMongoExpression<T>);
begin
  FDoc.Assign(ASource.FDoc);
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Clear: TMongoExpression<T>;
begin
  FDoc.Clear;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
procedure TMongoExpression<T>.Close;
begin
  FDoc.Close;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Exp(const AField, AExpression: String): TMongoExpression<T>;
begin
  Result := Append('{"' + AField + '":' + AExpression + '}');
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Builder: TJSONObjectBuilder;
begin
  Result := FDoc.Builder;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Iterator: TJSONIterator;
begin
  Result := FDoc.Iterator;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Add(const AKey, AValue: String): TMongoExpression<T>;
begin
  FDoc.Add(AKey, AValue);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Add(const AKey: String; const AValue: Int32): TMongoExpression<T>;
begin
  FDoc.Add(AKey, AValue);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Add(const AKey: String; const AValue: Int64): TMongoExpression<T>;
begin
  FDoc.Add(AKey, AValue);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Add(const AKey: String; const AValue: Extended): TMongoExpression<T>;
begin
  FDoc.Add(AKey, AValue);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Add(const AKey: String; const AValue: Boolean): TMongoExpression<T>;
begin
  FDoc.Add(AKey, AValue);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Add(const AKey: String; const AValue: TDateTime): TMongoExpression<T>;
begin
  FDoc.Add(AKey, AValue);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Add(const AKey: String; const AValue: TBytes;
  ABinaryType: TJsonBinaryType = TJsonBinaryType.Generic): TMongoExpression<T>;
begin
  FDoc.Add(AKey, AValue, ABinaryType);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Add(const AKey: String; const AValue: TMongoOID): TMongoExpression<T>;
begin
  FDoc.Add(AKey, AValue);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Add(const AKey: String; const AValue: TJsonOid): TMongoExpression<T>;
begin
  FDoc.Add(AKey, AValue);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Add(const AKey: String; const AValue: TJsonRegEx): TMongoExpression<T>;
begin
  FDoc.Add(AKey, AValue);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Add(const AKey: String; const AValue: TJsonDBRef): TMongoExpression<T>;
begin
  FDoc.Add(AKey, AValue);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Add(const AKey: String; const AValue: TJsonCodeWScope): TMongoExpression<T>;
begin
  FDoc.Add(AKey, AValue);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Add(const AKey: String; const AValues: array of const): TMongoExpression<T>;
begin
  FDoc.Add(AKey, AValues);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Add(const AKey: String; const AValue: Variant): TMongoExpression<T>;
begin
  FDoc.Add(AKey, AValue);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Add(const AKey: String; const AValue: TVarRec): TMongoExpression<T>;
begin
  FDoc.Add(AKey, AValue);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.AddNull(const AKey: String): TMongoExpression<T>;
begin
  FDoc.AddNull(AKey);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.AddUndefined(const AKey: String): TMongoExpression<T>;
begin
  FDoc.AddUndefined(AKey);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.AddMaxKey(const AKey: String): TMongoExpression<T>;
begin
  FDoc.AddMaxKey(AKey);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.AddMinKey(const AKey: String): TMongoExpression<T>;
begin
  FDoc.AddMinKey(AKey);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Append(const AItems: array of const): TMongoExpression<T>;
begin
  FDoc.Append(AItems);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Append(const AJSON: String): TMongoExpression<T>;
begin
  FDoc.Append(AJSON);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.Append(const ADoc: TMongoDocument): TMongoExpression<T>;
begin
  FDoc.Append(ADoc);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.GetInArray: Boolean;
begin
  Result := FDoc.InArray;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.BeginArray(const AKey: String): TMongoExpression<T>;
begin
  FDoc.BeginArray(AKey);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.EndArray: TMongoExpression<T>;
begin
  FDoc.EndArray;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.GetInObject: Boolean;
begin
  Result := FDoc.InObject;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.BeginObject(const AKey: String): TMongoExpression<T>;
begin
  FDoc.BeginObject(AKey);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.EndObject: TMongoExpression<T>;
begin
  FDoc.EndObject;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoExpression<T>.&End: T;
begin
  Result := FDoc.FParentObj as T;
end;

{-------------------------------------------------------------------------------}
{ TMongoPipeline.TOperation                                                     }
{-------------------------------------------------------------------------------}
constructor TMongoPipeline.TOperation.Create(APipeline: TMongoPipeline);
begin
  inherited Create;
  FPipeline := APipeline;
  FWriter := TMongoDocument.Create(APipeline.FEnv, APipeline.FOwningObj, APipeline);
end;

{-------------------------------------------------------------------------------}
destructor TMongoPipeline.TOperation.Destroy;
begin
  FDFreeAndNil(FWriter);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
class function TMongoPipeline.TOperation.GetInline: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.TOperation.&End: TMongoPipeline;
begin
  Result := FPipeline;
end;

{-------------------------------------------------------------------------------}
{ TMongoPipeline.TInlineOperation                                               }
{-------------------------------------------------------------------------------}
class function TMongoPipeline.TInlineOperation.GetInline: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TMongoPipeline.TInlineOperation.SetValue(const AValue: Variant);
begin
  Writer.Clear;
  Writer.Add(GetOperator, AValue);
end;

{-------------------------------------------------------------------------------}
{ TMongoPipeline.TLimit                                                         }
{-------------------------------------------------------------------------------}
class function TMongoPipeline.TLimit.GetOperator: String;
begin
  Result := '$limit';
end;

{-------------------------------------------------------------------------------}
{ TMongoPipeline.TSkip                                                          }
{-------------------------------------------------------------------------------}
class function TMongoPipeline.TSkip.GetOperator: String;
begin
  Result := '$skip';
end;

{-------------------------------------------------------------------------------}
{ TMongoPipeline.TUnwind                                                        }
{-------------------------------------------------------------------------------}
class function TMongoPipeline.TUnwind.GetOperator: String;
begin
  Result := '$unwind';
end;

{-------------------------------------------------------------------------------}
{ TMongoPipeline.TOut                                                           }
{-------------------------------------------------------------------------------}
class function TMongoPipeline.TOut.GetOperator: String;
begin
  Result := '$out';
end;

{-------------------------------------------------------------------------------}
{ TMongoPipeline.TProjection                                                    }
{-------------------------------------------------------------------------------}
class function TMongoPipeline.TProjection.GetOperator: String;
begin
  Result := '$project';
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.TProjection.Clear: TProjection;
begin
  FWriter.Clear;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.TProjection.Append(const AJSON: String): TProjection;
begin
  FWriter.Append(AJSON);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.TProjection.NoID: TProjection;
begin
  FWriter.Add('_id', False);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.TProjection.Field(const AField: String): TProjection;
begin
  FWriter.Add(AField, True);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.TProjection.FieldBegin(const AField: String): TProjection;
begin
  FWriter.BeginObject(AField);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.TProjection.FieldEnd: TProjection;
begin
  FWriter.EndObject;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.TProjection.Exp(const AField, AExpression: String): TProjection;
begin
  FWriter.Append('{"' + AField + '":' + AExpression + '}');
  Result := Self;
end;

{-------------------------------------------------------------------------------}
{ TMongoPipeline.TSort                                                          }
{-------------------------------------------------------------------------------}
class function TMongoPipeline.TSort.GetOperator: String;
begin
  Result := '$sort';
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.TSort.Clear: TSort;
begin
  FWriter.Clear;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.TSort.Append(const AJSON: String): TSort;
begin
  FWriter.Append(AJSON);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.TSort.Field(const AName: String; AAscending: Boolean = True): TSort;
var
  iVal: Integer;
begin
  if AAscending then
    iVal := 1
  else
    iVal := -1;
  FWriter.Add(AName, iVal);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.TSort.TextScore(const AName: String): TSort;
begin
  FWriter.BeginObject(AName);
  FWriter.Add('$meta', 'textScore');
  FWriter.EndObject;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
{ TMongoPipeline.TOptions                                                       }
{-------------------------------------------------------------------------------}
procedure TMongoPipeline.TOptions.Save(AWriter: TMongoDocument);
begin
  AWriter.Clear;
  if Explain then
    AWriter.Add('explain', True);
  if AllowDiskUse then
    AWriter.Add('allowDiskUse', True);
  if UseCursor then begin
    AWriter.BeginObject('cursor');
    AWriter.Add('batchSize', BatchSize);
    AWriter.EndObject;
  end;
  if MaxTimeMS > 0 then
    AWriter.Add('maxTimeMS', MaxTimeMS);
end;

{-------------------------------------------------------------------------------}
procedure TMongoPipeline.TOptions.Assign(AOptions: TOptions);
begin
  Explain := AOptions.Explain;
  AllowDiskUse := AOptions.AllowDiskUse;
  UseCursor := AOptions.UseCursor;
  BatchSize := AOptions.BatchSize;
  MaxTimeMS := AOptions.MaxTimeMS;
end;

{-------------------------------------------------------------------------------}
{ TMongoPipeline                                                                }
{-------------------------------------------------------------------------------}
constructor TMongoPipeline.Create(AEnv: TMongoEnv);
begin
  inherited Create;
  FEnv := AEnv;
  FOwningObj := AEnv.OwningObj;
  FOperations := TFDStringList.Create(True);
end;

{-------------------------------------------------------------------------------}
constructor TMongoPipeline.Create(AEnv: TMongoEnv; AOwningObj: TObject;
  AGetCursor: TMongoPipeline.TGetCursor);
begin
  Create(AEnv);
  FOwningObj := AOwningObj;
  FGetCursor := AGetCursor;
end;

{-------------------------------------------------------------------------------}
destructor TMongoPipeline.Destroy;
begin
  FDFreeAndNil(FPWriter);
  FDFreeAndNil(FOWriter);
  FDFreeAndNil(FOptions);
  FDFreeAndNil(FOperations);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.GetOperation(AType: TOperationClass;
  const ATypeName: String; const AJSON: String): TObject;
var
  i: Integer;
  sName: String;
begin
  if AType <> nil then
    sName := AType.GetOperator
  else
    sName := ATypeName;
  i := FOperations.IndexOf(sName);
  if i = -1 then begin
    if AType <> nil then
      Result := TOperationClass(AType).Create(Self)
    else
      Result := TExpression.Create(FEnv, FOwningObj, Self);
    FOperations.AddObject(sName, Result);
  end
  else
    Result := FOperations.Objects[i];
  if AJSON <> '' then
    if Result is TExpression then
      TExpression(Result).Append(AJSON)
    else if Result is TOperation then
      TOperation(Result).Writer.Append(AJSON);
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.GetFinalPipelineBSON: TMongoDocument;
var
  i: Integer;
  oOper: TOperation;
  oWrt: TMongoDocument;
begin
  if FPWriter = nil then
    FPWriter := TMongoDocument.Create(FEnv, FOwningObj, Self);
  FPWriter.Clear;
  FPWriter.BeginArray('pipeline');
  for i := 0 to FOperations.Count - 1 do begin
    if FOperations.Objects[i] is TOperation then begin
      oOper := TOperation(FOperations.Objects[i]);
      oWrt := oOper.Writer;
    end
    else begin
      oOper := nil;
      oWrt := TExpression(FOperations.Objects[i]).FDoc;
    end;
    FPWriter.BeginObject(IntToStr(i));
    if (oOper = nil) or not oOper.GetInline then
      FPWriter.BeginObject(FOperations[i]);
    FPWriter.Append(oWrt);
    if (oOper = nil) or not oOper.GetInline then
      FPWriter.EndObject;
    FPWriter.EndObject;
  end;
  FPWriter.EndArray;
  Result := FPWriter;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.GetFinalOptionsBSON: TMongoDocument;
begin
  if FOptions <> nil then begin
    if FOWriter = nil then
      FOWriter := TMongoDocument.Create(FEnv, FOwningObj, Self);
    FOWriter.Clear;
    FOptions.Save(FOWriter);
  end;
  Result := FOWriter;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.Project(const AJSON: String = ''): TProjection;
begin
  Result := TProjection(GetOperation(TProjection, '', AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.Match(const AJSON: String = ''): TExpression;
begin
  Result := TExpression(GetOperation(nil, '$match', AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.Redact(const AJSON: String = ''): TExpression;
begin
  Result := TExpression(GetOperation(nil, '$redact', AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.Limit(const AValue: Integer): TMongoPipeline;
begin
  TLimit(GetOperation(TLimit, '', '')).SetValue(AValue);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.Skip(const AValue: Integer): TMongoPipeline;
begin
  TSkip(GetOperation(TLimit, '', '')).SetValue(AValue);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.Unwind(const APath: String): TMongoPipeline;
begin
  TUnwind(GetOperation(TUnwind, '', '')).SetValue(APath);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.Group(const AJSON: String = ''): TExpression;
begin
  Result := TExpression(GetOperation(nil, '$group', AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.Sort(const AJSON: String = ''): TSort;
begin
  Result := TSort(GetOperation(TSort, '', AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.&Out(const ACollectionName: String): TMongoPipeline;
begin
  TOut(GetOperation(TOut, '', '')).SetValue(ACollectionName);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.GetOptions: TOptions;
begin
  if FOptions = nil then
    FOptions := TOptions.Create;
  Result := FOptions;
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.GetCursor: IMongoCursor;
begin
  if not Assigned(FGetCursor) then
    FDException(FOwningObj, [S_FD_LPhys, FEnv.CLib.DriverID],
      er_FD_MongoCursorError, ['Aggregate']);
  Result := FGetCursor(Self);
end;

{-------------------------------------------------------------------------------}
function TMongoPipeline.Open: IMongoCursor;
begin
  Result := Self;
end;

{-------------------------------------------------------------------------------}
{ TMongoQuery.TOperation                                                        }
{-------------------------------------------------------------------------------}
constructor TMongoQuery.TOperation.Create(AQuery: TMongoQuery);
begin
  inherited Create;
  FQuery := AQuery;
  FWriter := TMongoDocument.Create(FQuery.FEnv, FQuery.FOwningObj, AQuery);
end;

{-------------------------------------------------------------------------------}
destructor TMongoQuery.TOperation.Destroy;
begin
  FDFreeAndNil(FWriter);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.TOperation.&End: TMongoQuery;
begin
  Result := FQuery;
end;

{-------------------------------------------------------------------------------}
{ TMongoQuery.TProjection                                                       }
{-------------------------------------------------------------------------------}
function TMongoQuery.TProjection.Clear: TProjection;
begin
  FWriter.Clear;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.TProjection.Append(const AJSON: String): TProjection;
begin
  FWriter.Append(AJSON);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.TProjection.NoID: TProjection;
begin
  FWriter.Add('_id', False);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.TProjection.Field(const AField: String; AInclude: Boolean = True): TProjection;
begin
  FWriter.Add(AField, AInclude);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.TProjection.Include(const AFields: array of String): TProjection;
var
  i: Integer;
begin
  for i := Low(AFields) to High(AFields) do
    Field(AFields[i], True);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.TProjection.Exclude(const AFields: array of String): TProjection;
var
  i: Integer;
begin
  for i := Low(AFields) to High(AFields) do
    Field(AFields[i], False);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.TProjection.TextScore(const AField: String): TProjection;
begin
  FWriter.BeginObject(AField);
  FWriter.Add('$meta', 'textScore');
  FWriter.EndObject;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.TProjection.Slice(const AField: String; ACount: Integer): TProjection;
begin
  FWriter.BeginObject(AField);
  FWriter.Add('$slice', ACount);
  FWriter.EndObject;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.TProjection.Slice(const AField: String; ASkip, ACount: Integer): TProjection;
begin
  FWriter.BeginObject(AField);
  FWriter.BeginArray('$slice');
  FWriter.Add('0', ASkip);
  FWriter.Add('1', ACount);
  FWriter.EndArray;
  FWriter.EndObject;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
{ TMongoQuery.TSort                                                             }
{-------------------------------------------------------------------------------}
function TMongoQuery.TSort.Clear: TSort;
begin
  FWriter.Clear;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.TSort.Append(const AJSON: String): TSort;
begin
  FWriter.Append(AJSON);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.TSort.Field(const AName: String; AAscending: Boolean): TSort;
var
  iVal: Integer;
begin
  if AAscending then
    iVal := 1
  else
    iVal := -1;
  FWriter.Add(AName, iVal);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.TSort.Ascending(const AFields: array of String): TSort;
var
  i: Integer;
begin
  for i := Low(AFields) to High(AFields) do
    Field(AFields[i], True);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.TSort.Descending(const AFields: array of String): TSort;
var
  i: Integer;
begin
  for i := Low(AFields) to High(AFields) do
    Field(AFields[i], False);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.TSort.TextScore(const AName: String): TSort;
begin
  FWriter.BeginObject(AName);
  FWriter.Add('$meta', 'textScore');
  FWriter.EndObject;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
{ TMongoQuery.TOptions                                                          }
{-------------------------------------------------------------------------------}
procedure TMongoQuery.TOptions.Save(AWriter: TMongoDocument);
begin
  if Comment <> '' then
    AWriter.Add('$comment', Comment);
  if Explain then
    AWriter.Add('$explain', True);
  if Hint <> '' then
    AWriter.Append('{"$hint":' + Hint + '}');
  if MaxScan <> 0 then
    AWriter.Add('$maxScan', MaxScan);
  if MaxTimeMS <> 0 then
    AWriter.Add('$maxTimeMS', MaxTimeMS);
  if ReturnKey then
    AWriter.Add('$returnKey', True);
  if Snapshot then
    AWriter.Add('$snapshot', True);
end;

{-------------------------------------------------------------------------------}
procedure TMongoQuery.TOptions.Assign(AOptions: TOptions);
begin
  Comment := AOptions.Comment;
  Explain := AOptions.Explain;
  Hint := AOptions.Hint;
  MaxScan := AOptions.MaxScan;
  MaxTimeMS := AOptions.MaxTimeMS;
  ReturnKey := AOptions.ReturnKey;
  Snapshot := AOptions.Snapshot;
  BatchSize := AOptions.BatchSize;
end;

{-------------------------------------------------------------------------------}
{ TMongoQuery                                                                   }
{-------------------------------------------------------------------------------}
constructor TMongoQuery.Create(AEnv: TMongoEnv);
begin
  inherited Create;
  FEnv := AEnv;
  FOwningObj := AEnv.OwningObj;
  FQWriter := TMongoDocument.Create(FEnv, Self, Self);
  FPWriter := TMongoDocument.Create(FEnv, Self, Self);
end;

{-------------------------------------------------------------------------------}
constructor TMongoQuery.Create(AEnv: TMongoEnv; AOwningObj: TObject;
  AGetCursor: TGetCursor);
begin
  Create(AEnv);
  FOwningObj := AOwningObj;
  FQWriter.FOwningObj := AOwningObj;
  FPWriter.FOwningObj := AOwningObj;
  FGetCursor := AGetCursor;
end;

{-------------------------------------------------------------------------------}
constructor TMongoQuery.Create(AEnv: TMongoEnv; AOwningObj: TObject;
  AGetCount: TGetCount);
begin
  Create(AEnv);
  FOwningObj := AOwningObj;
  FQWriter.FOwningObj := AOwningObj;
  FPWriter.FOwningObj := AOwningObj;
  FGetCount := AGetCount;
end;

{-------------------------------------------------------------------------------}
destructor TMongoQuery.Destroy;
begin
  FDFreeAndNil(FProject);
  FDFreeAndNil(FMatch);
  FDFreeAndNil(FSort);
  FDFreeAndNil(FOptions);
  FDFreeAndNil(FPWriter);
  FDFreeAndNil(FQWriter);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.Project(const AJSON: String = ''): TProjection;
begin
  if FProject = nil then
    FProject := TProjection.Create(Self);
  Result := FProject;
  if AJSON <> '' then
    Result.Writer.Append(AJSON);
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.Match(const AJSON: String = ''): TExpression;
begin
  if FMatch = nil then
    FMatch := TExpression.Create(FEnv, FOwningObj, Self);
  Result := FMatch;
  if AJSON <> '' then
    Result.Append(AJSON);
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.Sort(const AJSON: String = ''): TSort;
begin
  if FSort = nil then
    FSort := TSort.Create(Self);
  Result := FSort;
  if AJSON <> '' then
    Result.Writer.Append(AJSON);
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.Options: TOptions;
begin
  if FOptions = nil then
    FOptions := TOptions.Create;
  Result := FOptions;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.Limit(const AValue: Integer): TMongoQuery;
begin
  FLimit := AValue;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.Skip(const AValue: Integer): TMongoQuery;
begin
  FSkip := AValue;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
procedure TMongoQuery.DoGetFinalQueryBSON(AWriter: TMongoDocument);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.GetFinalQueryBSON: TMongoDocument;
begin
  FQWriter.Clear;
  if (FMatch <> nil) or (FSort <> nil) then begin
    FQWriter.BeginObject('$query');
    if FMatch <> nil then
      FQWriter.Append(FMatch.FDoc);
    FQWriter.EndObject;
  end;
  if FSort <> nil then begin
    FQWriter.BeginObject('$orderby');
    FQWriter.Append(FSort.FWriter);
    FQWriter.EndObject;
  end;
  if FOptions <> nil then
    FOptions.Save(FQWriter);
  Result := FQWriter;
  DoGetFinalQueryBSON(Result);
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.GetFinalCountBSON: TMongoDocument;
begin
  FQWriter.Clear;
  if FMatch <> nil then
    FQWriter.Append(FMatch.FDoc);
  if FOptions <> nil then
    FOptions.Save(FQWriter);
  Result := FQWriter;
  DoGetFinalQueryBSON(Result);
end;

{-------------------------------------------------------------------------------}
procedure TMongoQuery.DoGetFinalProjectBSON(AWriter: TMongoDocument);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.GetFinalProjectBSON: TMongoDocument;
begin
  if (Self = nil) or (FProject = nil) then
    Result := nil
  else begin
    Result := FProject.Writer;
    DoGetFinalProjectBSON(Result);
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.GetCursor: IMongoCursor;
begin
  if not Assigned(FGetCursor) then
    FDException(FOwningObj, [S_FD_LPhys, FEnv.CLib.DriverID],
      er_FD_MongoCursorError, ['Find']);
  Result := FGetCursor(Self);
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.Open: IMongoCursor;
begin
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoQuery.Value: Int64;
begin
  if not Assigned(FGetCount) then
    FDException(FOwningObj, [S_FD_LPhys, FEnv.CLib.DriverID],
      er_FD_MongoExecuteError, ['Count']);
  Result := FGetCount(Self);
end;

{-------------------------------------------------------------------------------}
{ TMongoCommand                                                                 }
{-------------------------------------------------------------------------------}
constructor TMongoCommand.Create(AEnv: TMongoEnv);
begin
  inherited Create(AEnv);
  FCommand := TMongoDocument.Create(AEnv, Self, Self);
end;

{-------------------------------------------------------------------------------}
constructor TMongoCommand.Create(AEnv: TMongoEnv; AOwningObj: TObject);
begin
  Create(AEnv);
  FOwningObj := AOwningObj;
  FCommand.FOwningObj := AOwningObj;
end;

{-------------------------------------------------------------------------------}
destructor TMongoCommand.Destroy;
begin
  FDFreeAndNil(FCommand);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TMongoCommand.Command(const AArgs: array of const): TMongoCommand;
begin
  FCommand.Append(AArgs);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoCommand.Command(const AJSON: String): TMongoCommand;
begin
  FCommand.Append(AJSON);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
procedure TMongoCommand.DoGetFinalQueryBSON(AWriter: TMongoDocument);
begin
  AWriter.Append(FCommand);
  inherited DoGetFinalQueryBSON(AWriter);
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TOperation                                             }
{-------------------------------------------------------------------------------}
constructor TMongoUpdate.TModifier.TOperation.Create(AModifier: TModifier);
begin
  inherited Create;
  FModifier := AModifier;
  FWriter := TMongoDocument.Create(FModifier.FUpdate.FEnv, FModifier.FUpdate.FOwningObj,
    FModifier.FUpdate);
end;

{-------------------------------------------------------------------------------}
destructor TMongoUpdate.TModifier.TOperation.Destroy;
begin
  FDFreeAndNil(FWriter);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TOperation.Field(const AName: String;
  const AValue: Variant): TOperation;
begin
  FWriter.Add(AName, AValue);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TOperation.&End: TModifier;
begin
  Result := FModifier;
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TInc                                                   }
{-------------------------------------------------------------------------------}
class function TMongoUpdate.TModifier.TInc.GetOperator: String;
begin
  Result := '$inc';
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TInc.Field(const AName: String;
  const AValue: Variant): TInc;
begin
  Result := TInc(inherited Field(AName, AValue));
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TMul                                                   }
{-------------------------------------------------------------------------------}
class function TMongoUpdate.TModifier.TMul.GetOperator: String;
begin
  Result := '$mul';
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TMul.Field(const AName: String;
  const AValue: Variant): TMul;
begin
  Result := TMul(inherited Field(AName, AValue));
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TRename                                                }
{-------------------------------------------------------------------------------}
class function TMongoUpdate.TModifier.TRename.GetOperator: String;
begin
  Result := '$rename';
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TRename.Field(const AOldName,
  ANewName: String): TRename;
begin
  Result := TRename(inherited Field(AOldName, ANewName));
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TSetOnInsert                                           }
{-------------------------------------------------------------------------------}
class function TMongoUpdate.TModifier.TSetOnInsert.GetOperator: String;
begin
  Result := '$setOnInsert';
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TSetOnInsert.Field(const AName: String;
  const AValue: Variant): TSetOnInsert;
begin
  Result := TSetOnInsert(inherited Field(AName, AValue));
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TSet                                                   }
{-------------------------------------------------------------------------------}
class function TMongoUpdate.TModifier.TSet.GetOperator: String;
begin
  Result := '$set';
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TSet.Field(const AName: String;
  const AValue: Variant): TSet;
begin
  Result := TSet(inherited Field(AName, AValue));
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TUnset                                                 }
{-------------------------------------------------------------------------------}
class function TMongoUpdate.TModifier.TUnset.GetOperator: String;
begin
  Result := '$unset';
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TUnset.Field(const AName: String): TUnset;
begin
  Result := TUnset(inherited Field(AName, ''));
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TMin                                                   }
{-------------------------------------------------------------------------------}
class function TMongoUpdate.TModifier.TMin.GetOperator: String;
begin
  Result := '$min';
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TMin.Field(const AName: String;
  const AValue: Variant): TMin;
begin
  Result := TMin(inherited Field(AName, AValue));
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TMax                                                   }
{-------------------------------------------------------------------------------}
class function TMongoUpdate.TModifier.TMax.GetOperator: String;
begin
  Result := '$max';
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TMax.Field(const AName: String;
  const AValue: Variant): TMax;
begin
  Result := TMax(inherited Field(AName, AValue));
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TCurrentDate                                           }
{-------------------------------------------------------------------------------}
class function TMongoUpdate.TModifier.TCurrentDate.GetOperator: String;
begin
  Result := '$currentDate';
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TCurrentDate.AsDate(const AName: String): TCurrentDate;
begin
  FWriter.BeginObject(AName);
  FWriter.Add('$type', 'date');
  FWriter.EndObject;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TCurrentDate.AsTimestamp(const AName: String): TCurrentDate;
begin
  FWriter.BeginObject(AName);
  FWriter.Add('$type', 'timestamp');
  FWriter.EndObject;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TArrayOperation                                        }
{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TArrayOperation.Field(const AName: String;
  const AValues: Variant; AEach, AClose: Boolean): TArrayOperation;
begin
  if VarIsArray(AValues) then begin
    if AEach then begin
      FWriter.BeginObject(AName);
      FWriter.Add('$each', AValues);
    end
    else
      FWriter.Add(AName, AValues);
    if AEach then
      if AClose then
        FWriter.EndObject;
  end
  else
    inherited Field(AName, AValues);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TArrayOperation.Field(const AName: String;
  const AValues: array of const; AEach, AClose: Boolean): TArrayOperation;
begin
  if High(AValues) - Low(AValues) + 1 > 1 then begin
    if AEach then begin
      FWriter.BeginObject(AName);
      FWriter.Add('$each', AValues);
    end
    else
      FWriter.Add(AName, AValues);
    if AEach then
      if AClose then
        FWriter.EndObject;
  end
  else
    Writer.Add(AName, AValues[Low(AValues)]);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TAddToSet                                              }
{-------------------------------------------------------------------------------}
class function TMongoUpdate.TModifier.TAddToSet.GetOperator: String;
begin
  Result := '$addToSet';
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TAddToSet.Field(const AName: String;
  const AValues: Variant; AEach: Boolean = True): TAddToSet;
begin
  Result := TAddToSet(inherited Field(AName, AValues, AEach, True));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TAddToSet.Field(const AName: String;
  const AValues: array of const; AEach: Boolean = True): TAddToSet;
begin
  Result := TAddToSet(inherited Field(AName, AValues, AEach, True));
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TPop                                                   }
{-------------------------------------------------------------------------------}
class function TMongoUpdate.TModifier.TPop.GetOperator: String;
begin
  Result := '$pop';
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TPop.First(const AName: String): TPop;
begin
  Result := TPop(inherited Field(AName, -1));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TPop.Last(const AName: String): TPop;
begin
  Result := TPop(inherited Field(AName, 1));
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TPull                                                  }
{-------------------------------------------------------------------------------}
class function TMongoUpdate.TModifier.TPull.GetOperator: String;
begin
  Result := '$pull';
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TPull.Field(const AName: String;
  const AValue: Variant): TPull;
begin
  Result := TPull(inherited Field(AName, AValue));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TPull.Where(const AName, AValue: String): TPull;
begin
  FWriter.BeginObject(AName);
  FWriter.Append(AValue);
  FWriter.EndObject;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TPullAll                                               }
{-------------------------------------------------------------------------------}
class function TMongoUpdate.TModifier.TPullAll.GetOperator: String;
begin
  Result := '$pullAll';
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TPullAll.Field(const AName: String;
  const AValues: Variant): TPullAll;
begin
  Result := TPullAll(inherited Field(AName, AValues, False, True));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TPullAll.Field(const AName: String;
  const AValues: array of const): TPullAll;
begin
  Result := TPullAll(inherited Field(AName, AValues, False, True));
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TPush                                                  }
{-------------------------------------------------------------------------------}
class function TMongoUpdate.TModifier.TPush.GetOperator: String;
begin
  Result := '$push';
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TPush.Field(const AName: String;
  const AValues: Variant; AEach: Boolean = True; ASlice: Integer = MaxInt;
  const ASort: String = ''): TPush;
var
  lModifiers: Boolean;
begin
  lModifiers := (ASlice <> MaxInt) or (ASort <> '');
  inherited Field(AName, AValues, AEach, not lModifiers);
  if lModifiers then begin
    if ASlice <> MaxInt then
      FWriter.Add('$slice', ASlice);
    if ASort <> '' then
      FWriter.Append('{"$sort": {' + ASort + '}}');
    FWriter.EndObject;
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TPush.Field(const AName: String;
  const AValues: array of const; AEach: Boolean = True; ASlice: Integer = MaxInt;
  const ASort: String = ''): TPush;
var
  lModifiers: Boolean;
begin
  lModifiers := (ASlice <> MaxInt) or (ASort <> '');
  inherited Field(AName, AValues, AEach, not lModifiers);
  if lModifiers then begin
    if ASlice <> MaxInt then
      FWriter.Add('$slice', ASlice);
    if ASort <> '' then
      FWriter.Append('{"$sort": {' + ASort + '}}');
    FWriter.EndObject;
  end;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier.TPushAll                                               }
{-------------------------------------------------------------------------------}
class function TMongoUpdate.TModifier.TPushAll.GetOperator: String;
begin
  Result := '$pushAll';
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TPushAll.Field(const AName: String;
  const AValues: Variant): TPushAll;
begin
  Result := TPushAll(inherited Field(AName, AValues, False, True));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.TPushAll.Field(const AName: String;
  const AValues: array of const): TPushAll;
begin
  Result := TPushAll(inherited Field(AName, AValues, False, True));
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate.TModifier                                                        }
{-------------------------------------------------------------------------------}
constructor TMongoUpdate.TModifier.Create(AUpdate: TMongoUpdate);
begin
  inherited Create;
  FUpdate := AUpdate;
  FOperations := TFDStringList.Create(True);
end;

{-------------------------------------------------------------------------------}
destructor TMongoUpdate.TModifier.Destroy;
begin
  FDFreeAndNil(FWriter);
  FDFreeAndNil(FOperations);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.Clear: TModifier;
begin
  FOperations.Clear;
  FCustomJSON := '';
  FWriter.Clear;
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.GetOperation(AType: TOperationClass;
  const AJSON: String): TOperation;
var
  i: Integer;
begin
  i := FOperations.IndexOf(AType.GetOperator);
  if i = -1 then begin
    Result := AType.Create(Self);
    FOperations.AddObject(Result.GetOperator, Result);
  end
  else
    Result := TOperation(FOperations.Objects[i]);
  if AJSON <> '' then
    Result.FWriter.Append(AJSON);
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.GetFinalBSON: TMongoDocument;
var
  i: Integer;
  oWrt: TMongoDocument;
begin
  if FWriter = nil then
    FWriter := TMongoDocument.Create(FUpdate.FEnv, FUpdate.FOwningObj, FUpdate);
  FWriter.Clear;
  if FCustomJSON <> '' then
    FWriter.Append(FCustomJSON);
  for i := 0 to FOperations.Count - 1 do begin
    FWriter.BeginObject(FOperations[i]);
    oWrt := TOperation(FOperations.Objects[i]).FWriter;
    FWriter.Append(oWrt);
    FWriter.EndObject;
  end;
  Result := FWriter;
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.Inc(const AJSON: String = ''): TInc;
begin
  Result := TInc(GetOperation(TInc, AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.Mul(const AJSON: String = ''): TMul;
begin
  Result := TMul(GetOperation(TMul, AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.Rename(const AJSON: String = ''): TRename;
begin
  Result := TRename(GetOperation(TRename, AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.SetOnInsert(const AJSON: String = ''): TSetOnInsert;
begin
  Result := TSetOnInsert(GetOperation(TSetOnInsert, AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.&Set(const AJSON: String = ''): TSet;
begin
  Result := TSet(GetOperation(TSet, AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.Unset(const AJSON: String = ''): TUnset;
begin
  Result := TUnset(GetOperation(TUnset, AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.Min(const AJSON: String = ''): TMin;
begin
  Result := TMin(GetOperation(TMin, AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.Max(const AJSON: String = ''): TMax;
begin
  Result := TMax(GetOperation(TMax, AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.CurrentDate(const AJSON: String = ''): TCurrentDate;
begin
  Result := TCurrentDate(GetOperation(TCurrentDate, AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.AddToSet(const AJSON: String): TAddToSet;
begin
  Result := TAddToSet(GetOperation(TAddToSet, AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.Pop(const AJSON: String): TPop;
begin
  Result := TPop(GetOperation(TPop, AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.Pull(const AJSON: String): TPull;
begin
  Result := TPull(GetOperation(TPull, AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.PullAll(const AJSON: String): TPullAll;
begin
  Result := TPullAll(GetOperation(TPullAll, AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.Push(const AJSON: String): TPush;
begin
  Result := TPush(GetOperation(TPush, AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.PushAll(const AJSON: String): TPushAll;
begin
  Result := TPushAll(GetOperation(TPushAll, AJSON));
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.TModifier.&End: TMongoUpdate;
begin
  Result := FUpdate;
end;

{-------------------------------------------------------------------------------}
{ TMongoUpdate                                                                  }
{-------------------------------------------------------------------------------}
constructor TMongoUpdate.Create(AEnv: TMongoEnv);
begin
  inherited Create;
  FEnv := AEnv;
  FOwningObj := AEnv.OwningObj;
end;

{-------------------------------------------------------------------------------}
constructor TMongoUpdate.Create(AEnv: TMongoEnv; AOwningObj: TObject;
  ARunUpdate: TRunUpdate);
begin
  Create(AEnv);
  FOwningObj := AOwningObj;
  FRunUpdate := ARunUpdate;
end;

{-------------------------------------------------------------------------------}
destructor TMongoUpdate.Destroy;
begin
  FDFreeAndNil(FModifier);
  FDFreeAndNil(FMatcher);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.Match(const AJSON: String = ''): TExpression;
begin
  if FMatcher = nil then
    FMatcher := TExpression.Create(FEnv, FOwningObj, Self);
  Result := FMatcher;
  if AJSON <> '' then
    Result.Append(AJSON);
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.Modify(const AJSON: String = ''): TModifier;
begin
  if FModifier = nil then
    FModifier := TModifier.Create(Self);
  Result := FModifier;
  if AJSON <> '' then
    Result.FCustomJSON := AJSON;
end;

{-------------------------------------------------------------------------------}
procedure TMongoUpdate.DoGetFinalModifyBSON(AWriter: TMongoDocument);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.GetFinalModifyBSON: TMongoDocument;
begin
  if (Self = nil) or (FModifier = nil) then
    Result := nil
  else begin
    Result := FModifier.GetFinalBSON;
    DoGetFinalModifyBSON(Result);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMongoUpdate.DoGetFinalMatchBSON(AWriter: TMongoDocument);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TMongoUpdate.GetFinalMatchBSON: TMongoDocument;
begin
  if (Self = nil) or (FMatcher = nil) then
    Result := nil
  else begin
    Result := FMatcher.FDoc;
    DoGetFinalMatchBSON(Result);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMongoUpdate.Exec;
begin
  if not Assigned(FRunUpdate) then
    FDException(FOwningObj, [S_FD_LPhys, FEnv.CLib.DriverID],
      er_FD_MongoExecuteError, ['Update']);
  FRunUpdate(Self);
end;

{-------------------------------------------------------------------------------}
{ TMongoSelector                                                                }
{-------------------------------------------------------------------------------}
constructor TMongoSelector.Create(AEnv: TMongoEnv);
begin
  inherited Create;
  FEnv := AEnv;
  FOwningObj := AEnv.OwningObj;
end;

{-------------------------------------------------------------------------------}
constructor TMongoSelector.Create(AEnv: TMongoEnv; AOwningObj: TObject;
  ARunOper: TRunOper);
begin
  Create(AEnv);
  FOwningObj := AOwningObj;
  FRunOper := ARunOper;
end;

{-------------------------------------------------------------------------------}
destructor TMongoSelector.Destroy;
begin
  FDFreeAndNil(FMatcher);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TMongoSelector.Match(const AJSON: String = ''): TExpression;
begin
  if FMatcher = nil then
    FMatcher := TExpression.Create(FEnv, FOwningObj, Self);
  Result := FMatcher;
  if AJSON <> '' then
    Result.Append(AJSON);
end;

{-------------------------------------------------------------------------------}
procedure TMongoSelector.DoGetFinalMatchBSON(AWriter: TMongoDocument);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TMongoSelector.GetFinalMatchBSON: TMongoDocument;
begin
  if (Self = nil) or (FMatcher = nil) then
    Result := nil
  else begin
    Result := FMatcher.FDoc;
    DoGetFinalMatchBSON(Result);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMongoSelector.Exec;
begin
  if not Assigned(FRunOper) then
    FDException(FOwningObj, [S_FD_LPhys, FEnv.CLib.DriverID],
      er_FD_MongoExecuteError, ['Remove']);
  FRunOper(Self);
end;

{-------------------------------------------------------------------------------}
{ TMongoInsert                                                                  }
{-------------------------------------------------------------------------------}
constructor TMongoInsert.Create(AEnv: TMongoEnv);
begin
  inherited Create;
  FEnv := AEnv;
  FOwningObj := AEnv.OwningObj;
end;

{-------------------------------------------------------------------------------}
constructor TMongoInsert.Create(AEnv: TMongoEnv; AOwningObj: TObject;
  ARunOper: TRunOper);
begin
  Create(AEnv);
  FOwningObj := AOwningObj;
  FRunOper := ARunOper;
end;

{-------------------------------------------------------------------------------}
destructor TMongoInsert.Destroy;
begin
  FDFreeAndNil(FValues);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TMongoInsert.Values(const AJSON: String = ''): TMongoInsert.TExpression;
begin
  if FValues = nil then
    FValues := TExpression.Create(FEnv, FOwningObj, Self);
  Result := FValues;
  if AJSON <> '' then
    Result.Append(AJSON);
end;

{-------------------------------------------------------------------------------}
procedure TMongoInsert.DoGetFinalValuesBSON(AWriter: TMongoDocument);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TMongoInsert.GetFinalValuesBSON: TMongoDocument;
begin
  if (Self = nil) or (FValues = nil) then
    Result := nil
  else begin
    Result := FValues.FDoc;
    DoGetFinalValuesBSON(Result);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMongoInsert.Exec;
begin
  if not Assigned(FRunOper) then
    FDException(FOwningObj, [S_FD_LPhys, FEnv.CLib.DriverID],
      er_FD_MongoExecuteError, ['Insert']);
  FRunOper(Self);
end;

{-------------------------------------------------------------------------------}
{ TMongoIndex.TKeys                                                             }
{-------------------------------------------------------------------------------}
constructor TMongoIndex.TKeys.Create(AIndex: TMongoIndex);
begin
  inherited Create;
  FWriter := TMongoDocument.Create(AIndex.FEnv, AIndex.FOwningObj, AIndex);
end;

{-------------------------------------------------------------------------------}
destructor TMongoIndex.TKeys.Destroy;
begin
  FDFreeAndNil(FWriter);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TMongoIndex.TKeys.Field(const AName: String; AAscending: Boolean = True): TKeys;
var
  iVal: Integer;
begin
  if AAscending then
    iVal := 1
  else
    iVal := -1;
  FWriter.Add(AName, iVal);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoIndex.TKeys.Ascending(const AFields: array of String): TKeys;
var
  i: Integer;
begin
  for i := Low(AFields) to High(AFields) do
    Field(AFields[i], True);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
function TMongoIndex.TKeys.Descending(const AFields: array of String): TKeys;
var
  i: Integer;
begin
  for i := Low(AFields) to High(AFields) do
    Field(AFields[i], False);
  Result := Self;
end;

{-------------------------------------------------------------------------------}
{ TMongoIndex.TOptions                                                          }
{-------------------------------------------------------------------------------}
constructor TMongoIndex.TOptions.Create(AIndex: TMongoIndex);
begin
  inherited Create;
  FIndex := AIndex;
  FIndex.FEnv.CLib.Fmongoc_index_opt_init(@FOpts);
end;

{-------------------------------------------------------------------------------}
procedure TMongoIndex.TOptions.SetName(const AValue: String);
begin
  if FName <> AValue then begin
    FName := AValue;
    if AValue = '' then begin
      SetLength(FBName, 0);
      FOpts.name := nil;
    end
    else begin
      FBName := FIndex.FEnv.UTF8.Encode(AValue);
      FOpts.name := PFDAnsiString(FBName);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
{ TMongoIndex                                                                   }
{-------------------------------------------------------------------------------}
constructor TMongoIndex.Create(AEnv: TMongoEnv);
begin
  inherited Create;
  FEnv := AEnv;
  FOwningObj := AEnv.OwningObj;
  FKeys := TKeys.Create(Self);
  FOptions := TOptions.Create(Self);
end;

{-------------------------------------------------------------------------------}
destructor TMongoIndex.Destroy;
begin
  FDFreeAndNil(FKeys);
  FDFreeAndNil(FOptions);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TMongoIndex.Keys(const AJSON: String = ''): TKeys;
begin
  if AJSON <> '' then
    FKeys.FWriter.Append(AJSON);
  Result := FKeys;
end;

{-------------------------------------------------------------------------------}
{ TMongoCursor                                                                  }
{-------------------------------------------------------------------------------}
destructor TMongoCursor.Destroy;
begin
  FDFreeAndNil(FDoc);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TMongoCursor.InternalFreeHandle;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_cursor_destroy, ['cursor', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  CLib.Fmongoc_cursor_destroy(Handle);
end;

{-------------------------------------------------------------------------------}
function TMongoCursor.Next(ADoc: TMongoDocument): Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_cursor_next, ['cursor', Handle]);
  end;
{$ENDIF}

var
  pBson: Pbson_t;
begin
  if FEof then
    Exit(False);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Result := CLib.Fmongoc_cursor_next(Handle, @pBson);
  FEof := not Result;
  ADoc.AsReadHandle := pBson;
  if not Result and CLib.Fmongoc_cursor_error(Handle, @Env.Error.FBError) then
    Env.Error.CheckError(OwningObj);
end;

{-------------------------------------------------------------------------------}
function TMongoCursor.Next: Boolean;
begin
  Result := Next(Doc);
end;

{-------------------------------------------------------------------------------}
function TMongoCursor.GetDoc: TMongoDocument;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace('TMongoCursor.GetDoc', ['cursor', Handle, 'doc', FDoc.AsJSON]);
  end;
{$ENDIF}

begin
  if FDoc = nil then
    FDoc := TMongoDocument.Create(Env, OwningObj, Self);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Result := FDoc;
end;

{-------------------------------------------------------------------------------}
function TMongoCursor.GetIsAlive: Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_cursor_is_alive, ['cursor', Handle, 'result', Result]);
  end;
{$ENDIF}

begin
  Result := CLib.Fmongoc_cursor_is_alive(Handle);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
end;

                  
                              
                                 
 

{-------------------------------------------------------------------------------}
{ TMongoCursor.TDefault                                                         }
{-------------------------------------------------------------------------------}
constructor TMongoCursor.TDefault.Create(AEnv: TMongoEnv; AOwningObj: TObject;
  AReleaseObj: TObject; AHandle: Pmongoc_handle_t);
begin
  inherited Create;
  FReleaseObj := AReleaseObj;
  FCursor := TMongoCursor.Create(AEnv, AOwningObj, AHandle);
end;

{-------------------------------------------------------------------------------}
destructor TMongoCursor.TDefault.Destroy;
begin
  FDFreeAndNil(FCursor);
  FDFreeAndNil(FReleaseObj);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TMongoCursor.TDefault.GetDoc: TMongoDocument;
begin
  Result := FCursor.Doc;
end;

{-------------------------------------------------------------------------------}
function TMongoCursor.TDefault.GetIsAlive: Boolean;
begin
  Result := FCursor.IsAlive;
end;

{-------------------------------------------------------------------------------}
function TMongoCursor.TDefault.Next: Boolean;
begin
  Result := FCursor.Next;
end;

{-------------------------------------------------------------------------------}
function TMongoCursor.TDefault.Next(ADoc: TMongoDocument): Boolean;
begin
  Result := FCursor.Next(ADoc);
end;

{-------------------------------------------------------------------------------}
{ TMongoConnection                                                              }
{-------------------------------------------------------------------------------}
constructor TMongoConnection.Create(AEnv: TMongoEnv; AOwningObj: TObject);
begin
  inherited Create(AEnv, AOwningObj);
  FReadPreference := TMongoReadPreference.Create(AEnv, AOwningObj, nil);
  FWriteConcern := TMongoWriteConcern.Create(AEnv, AOwningObj, nil);
end;

{-------------------------------------------------------------------------------}
constructor TMongoConnection.CreateUsingHandle(AEnv: TMongoEnv;
  AHandle: Pmongoc_handle_t; AOwningObj: TObject);
begin
  inherited Create(AEnv, AOwningObj, AHandle);
  FOwnHandle := False;
  FReadPreference := TMongoReadPreference.Create(AEnv, AOwningObj, nil);
  FWriteConcern := TMongoWriteConcern.Create(AEnv, AOwningObj, nil);
  if AHandle <> nil then
    HandleAllocated;
end;

{-------------------------------------------------------------------------------}
destructor TMongoConnection.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FReadPreference);
  FDFreeAndNil(FWriteConcern);
end;

{-------------------------------------------------------------------------------}
procedure TMongoConnection.InternalFreeHandle;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_client_destroy, ['client', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  CLib.Fmongoc_client_destroy(Handle);
end;

{-------------------------------------------------------------------------------}
procedure TMongoConnection.FreeHandle;
begin
  FDFreeAndNil(FCollection);
  FDFreeAndNil(FDatabase);
  ReadPreference.Handle := nil;
  WriteConcern.Handle := nil;
  inherited FreeHandle;
end;

{-------------------------------------------------------------------------------}
procedure TMongoConnection.HandleAllocated;
begin
  inherited HandleAllocated;
  ReadPreference.Handle := CLib.Fmongoc_client_get_read_prefs(Handle);
  WriteConcern.Handle := CLib.Fmongoc_client_get_write_concern(Handle);
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.GetURI: String;
begin
  if Handle = nil then
    Result := ''
  else
    Result := Env.ANSI.Decode(Pointer(CLib.Fmongoc_uri_get_string(CLib.Fmongoc_client_get_uri(Handle))));
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.Getmax_bson_size: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_client_get_max_bson_size, ['client', Handle]);
  end;
{$ENDIF}

begin
  if Handle = nil then
    Result := 1024 * 1024 * 16
  else begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    Result := CLib.Fmongoc_client_get_max_bson_size(Handle);
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.Getmax_message_size: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_client_get_max_message_size, ['client', Handle]);
  end;
{$ENDIF}

begin
  if Handle = nil then
    Result := 1024 * 1024 * 48
  else begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    Result := CLib.Fmongoc_client_get_max_message_size(Handle);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMongoConnection.Open(const AUri: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_client_new, ['uri_string', AUri]);
  end;
{$ENDIF}

begin
  Close;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  FHandle := CLib.Fmongoc_client_new(PFDAnsiString(PByte(Env.ANSI.Encode(AUri))));
  FOwnHandle := True;
  if Handle = nil then
    FDException(OwningObj, [S_FD_LPhys, Env.CLib.DriverID], er_FD_MongoBadURI, []);
  HandleAllocated;
end;

{-------------------------------------------------------------------------------}
procedure TMongoConnection.SSLInit(const APEMFile, APEMPwd, ACAFile, ACADir,
  ACRLFile: String; AWeakValid: Boolean);
begin
  if not Assigned(CLib.Fmongoc_client_set_ssl_opts) then
    FDCapabilityNotSupported(OwningObj, [S_FD_LPhys, Env.CLib.DriverID]);
  FPEMFile := Env.ANSI.Encode(APEMFile);
  FPEMPwd := Env.ANSI.Encode(APEMPwd);
  FCAFile := Env.ANSI.Encode(ACAFile);
  FCADir := Env.ANSI.Encode(ACADir);
  FCRLFile := Env.ANSI.Encode(ACRLFile);
  if APEMFile <> '' then
    Fmongoc_ssl_opt.pem_file := PFDAnsiString(PByte(FPEMFile));
  if APEMPwd <> '' then
    Fmongoc_ssl_opt.pem_pwd := PFDAnsiString(PByte(FPEMPwd));
  if ACAFile <> '' then
    Fmongoc_ssl_opt.ca_file := PFDAnsiString(PByte(FCAFile));
  if ACADir <> '' then
    Fmongoc_ssl_opt.ca_dir := PFDAnsiString(PByte(FCADir));
  if ACRLFile <> '' then
    Fmongoc_ssl_opt.crl_file := PFDAnsiString(PByte(FCRLFile));
  Fmongoc_ssl_opt.weak_cert_validation := AWeakValid;
  CLib.Fmongoc_client_set_ssl_opts(Handle, @Fmongoc_ssl_opt);
end;

{-------------------------------------------------------------------------------}
procedure TMongoConnection.Close;
begin
  FreeHandle;
end;

{-------------------------------------------------------------------------------}
procedure TMongoConnection.Ping;
begin
  FDFree(CommandSimple('test', '{"ping": 1}'));
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.GetServerStatus: TMongoDocument;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_client_get_server_status, ['client', Handle]);
  end;
{$ENDIF}

begin
  Result := TMongoDocument.Create(Env, OwningObj, Self);
  try
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    if not CLib.Fmongoc_client_get_server_status(Handle, nil, Result.AsWriteHandle,
        @Env.Error.FBError) then
      Env.Error.CheckError(OwningObj, smongoc_client_get_server_status);
  except
    FDFree(Result);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.GetServerVersion: TFDVersion;
var
  oReply: TMongoDocument;
  oIter: TJSONIterator;
begin
  oReply := CommandSimple('test', '{"buildInfo": 1}');
  oIter := oReply.Iterator;
  try
    if oIter.Next('version') then
      Result := FDVerStr2Int(oIter.AsString)
    else
      Result := 0;
  finally
    FDFree(oIter);
    FDFree(oReply);
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.ListDatabases: IMongoCursor;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_client_find_databases, ['client', Handle]);
  end;
{$ENDIF}

var
  hCrs: Pmongoc_cursor_t;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  hCrs := CLib.Fmongoc_client_find_databases(Handle, @Env.Error.FBError);
  if hCrs = nil then
    Env.Error.CheckError(OwningObj, smongoc_client_find_databases);
  Result := TMongoCursor.TDefault.Create(Env, OwningObj, nil, hCrs);
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.InternalGetDatabase(const ADBName: String;
  ANew: Boolean): TMongoDatabase;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_client_get_database, ['client', Handle, 'name', ADBName]);
  end;
{$ENDIF}

var
  hDB: Pmongoc_database_t;
begin
  if not ANew and (FDatabase <> nil) and
     (AnsiCompareText(ADBName, FDatabase.Name) = 0) then begin
    Result := FDatabase;
    Exit;
  end;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  hDB := CLib.Fmongoc_client_get_database(Handle,
    PFDAnsiString(PByte(Env.ANSI.Encode(ADBName))));
  if hDB = nil then
    Env.Error.CheckError(OwningObj, smongoc_client_get_database);
  if ANew then
    Result := TMongoDatabase.Create(Env, OwningObj, hDB)
  else begin
    if FDatabase = nil then
      FDatabase := TMongoDatabase.Create(Env, OwningObj, hDB)
    else begin
      FDatabase.Handle := hDB;
      FDatabase.FOwnHandle := True;
    end;
    Result := FDatabase;
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.InternalGetCollection(const ADBName, AColName: String;
  ANew: Boolean): TMongoCollection;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_client_get_collection, ['client', Handle, 'db', ADBName,
      'collection', AColName]);
  end;
{$ENDIF}

var
  hCol: Pmongoc_collection_t;
begin
  if not ANew and (FCollection <> nil) and
     (AnsiCompareText(ADBName, FCollection.DB) = 0) and
     (AnsiCompareText(AColName, FCollection.Name) = 0) then begin
    Result := FCollection;
    Exit;
  end;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  hCol := CLib.Fmongoc_client_get_collection(Handle,
    PFDAnsiString(PByte(Env.ANSI.Encode(ADBName))),
    PFDAnsiString(PByte(Env.ANSI.Encode(AColName))));
  if hCol = nil then
    Env.Error.CheckError(OwningObj, smongoc_client_get_collection);
  if ANew then
    Result := TMongoCollection.Create(Env, OwningObj, hCol)
  else begin
    if FCollection = nil then
      FCollection := TMongoCollection.Create(Env, OwningObj, hCol)
    else begin
      FCollection.Handle := hCol;
      FCollection.FOwnHandle := True;
    end;
    Result := FCollection;
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.GetDatabase(const ADBName: String): TMongoDatabase;
begin
  Result := InternalGetDatabase(ADBName, True);
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.GetDatabasesProp(const ADBName: String): TMongoDatabase;
begin
  Result := InternalGetDatabase(ADBName, False);
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.GetCollection(const ADBName, AColName: String): TMongoCollection;
begin
  Result := InternalGetCollection(ADBName, AColName, True);
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.GetCollectionsProp(const ADBName, AColName: String): TMongoCollection;
begin
  Result := InternalGetCollection(ADBName, AColName, False);
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.Command(const ADBName: String; ACommand: TMongoCommand;
  AFlags: TMongoQueryFlags = []): IMongoCursor;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_client_command, ['client', Handle, 'db_name', ADBName,
      'flags', QF2mqft(AFlags), 'skip', ACommand.FSkip, 'limit', ACommand.FLimit,
      'batch_size', ACommand.Options.BatchSize, 'query', ACommand.FinalQueryBSON.AsJSON,
      'fields', ACommand.FinalProjectBSON.AsJSON]);
  end;
{$ENDIF}

var
  hCrs: Pmongoc_cursor_t;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  hCrs := CLib.Fmongoc_client_command(Handle,
    PFDAnsiString(PByte(Env.ANSI.Encode(ADBName))), QF2mqft(AFlags),
      ACommand.FSkip, ACommand.FLimit, ACommand.Options.BatchSize,
      ACommand.FinalQueryBSON.AsReadHandle, ACommand.FinalProjectBSON.AsReadHandle, nil);
  if hCrs = nil then
    Env.Error.CheckError(OwningObj, smongoc_client_command);
  Result := TMongoCursor.TDefault.Create(Env, OwningObj, nil, hCrs);
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.Command(const ADBName: String; const AJSON: String;
  AFlags: TMongoQueryFlags = []): IMongoCursor;
var
  oCmd: TMongoCommand;
begin
  oCmd := TMongoCommand.Create(Env, FOwningObj);
  try
    oCmd.Command(AJSON);
    Result := Command(ADBName, oCmd, AFlags);
  finally
    FDFree(oCmd);
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.CommandSimple(const ADBName: String; ACommand: TMongoDocument): TMongoDocument;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_client_command_simple, ['client', Handle, 'db_name', ADBName,
      'command', ACommand.AsJSON]);
  end;
{$ENDIF}

begin
  Result := TMongoDocument.Create(Env, OwningObj, Self);
  try
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    if not CLib.Fmongoc_client_command_simple(Handle,
        PFDAnsiString(PByte(Env.ANSI.Encode(ADBName))), ACommand.AsReadHandle,
        nil, Result.AsWriteHandle, @Env.Error.FBError) then
      Env.Error.CheckError(OwningObj, smongoc_client_command_simple);
  except
    FDFree(Result);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.CommandSimple(const ADBName: String; const AJSON: String): TMongoDocument;
var
  oCmd: TMongoDocument;
begin
  oCmd := TMongoDocument.Create(Env, OwningObj, Self);
  try
    oCmd.Append(AJSON);
    Result := CommandSimple(ADBName, oCmd);
  finally
    FDFree(oCmd);
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoConnection.Dereference(const ADBRef: TJsonDBRef): TMongoDocument;
begin
  if ADBRef.DB = '' then
    FDException(OwningObj, [S_FD_LPhys, Env.CLib.DriverID],
      er_FD_MongoDBRefInvalid, [ADBRef.AsString]);
  Result := Databases[ADBRef.DB].Dereference(ADBRef);
end;

                  
                                     
                                           
                                        
 

{-------------------------------------------------------------------------------}
{ TMongoDatabase                                                                }
{-------------------------------------------------------------------------------}
constructor TMongoDatabase.Create(AEnv: TMongoEnv; AOwningObj: TObject;
  AHandle: Pmongoc_database_t);
begin
  inherited Create(AEnv, AOwningObj, AHandle);
  FReadPreference := TMongoReadPreference.Create(AEnv, AOwningObj,
    CLib.Fmongoc_database_get_read_prefs(AHandle));
  FWriteConcern := TMongoWriteConcern.Create(AEnv, AOwningObj,
    CLib.Fmongoc_database_get_write_concern(AHandle));
end;

{-------------------------------------------------------------------------------}
destructor TMongoDatabase.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FReadPreference);
  FDFreeAndNil(FWriteConcern);
end;

{-------------------------------------------------------------------------------}
procedure TMongoDatabase.InternalFreeHandle;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_database_destroy, ['database', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  CLib.Fmongoc_database_destroy(Handle);
end;

{-------------------------------------------------------------------------------}
procedure TMongoDatabase.FreeHandle;
begin
  FDFreeAndNil(FCollection);
  FReadPreference.Handle := nil;
  FWriteConcern.Handle := nil;
  inherited FreeHandle;
end;

{-------------------------------------------------------------------------------}
procedure TMongoDatabase.HandleAllocated;
begin
  inherited HandleAllocated;
  FReadPreference.Handle := CLib.Fmongoc_database_get_read_prefs(Handle);
  FWriteConcern.Handle := CLib.Fmongoc_database_get_write_concern(Handle);
end;

{-------------------------------------------------------------------------------}
function TMongoDatabase.GetName: String;
begin
  Result := Env.ANSI.Decode(Pointer(CLib.Fmongoc_database_get_name(Handle)));
end;

{-------------------------------------------------------------------------------}
procedure TMongoDatabase.Drop;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_database_drop, ['database', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if not CLib.Fmongoc_database_drop(Handle, @Env.Error.FBError) then
    Env.Error.CheckError(OwningObj, smongoc_database_drop);
end;

{-------------------------------------------------------------------------------}
procedure TMongoDatabase.AddUser(const AUserName, APassword: String;
  ARoles, ACustomData: TMongoDocument);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_database_add_user, ['database', Handle, 'username', AUserName,
      'password', APassword, 'roles', ARoles.AsJSON, 'custom_data', ACustomData.AsJSON]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if not CLib.Fmongoc_database_add_user(Handle,
      PFDAnsiString(PByte(Env.ANSI.Encode(AUserName))),
      PFDAnsiString(PByte(Env.ANSI.Encode(APassword))),
      ARoles.AsReadHandle, ACustomData.AsReadHandle, @Env.Error.FBError) then
    Env.Error.CheckError(OwningObj, smongoc_database_add_user);
end;

{-------------------------------------------------------------------------------}
procedure TMongoDatabase.DropUser(const AUserName: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_database_remove_user, ['database', Handle, 'username', AUserName]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if not CLib.Fmongoc_database_remove_user(Handle,
      PFDAnsiString(PByte(Env.ANSI.Encode(AUserName))), @Env.Error.FBError) then
    Env.Error.CheckError(OwningObj, smongoc_database_remove_user);
end;

{-------------------------------------------------------------------------------}
procedure TMongoDatabase.DropAllUsers;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_database_remove_all_users, ['database', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if not CLib.Fmongoc_database_remove_all_users(Handle, @Env.Error.FBError) then
    Env.Error.CheckError(OwningObj, smongoc_database_remove_all_users);
end;

{-------------------------------------------------------------------------------}
function TMongoDatabase.ListCollections(ASelector: TMongoSelector = nil): IMongoCursor;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_database_find_collections, ['database', Handle,
      'filter', ASelector.FinalMatchBSON.AsJSON]);
  end;
{$ENDIF}

var
  hCrs: Pmongoc_cursor_t;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  hCrs := CLib.Fmongoc_database_find_collections(Handle,
    ASelector.FinalMatchBSON.AsReadHandle, @Env.Error.FBError);
  if hCrs = nil then
    Env.Error.CheckError(OwningObj, smongoc_database_find_collections);
  Result := TMongoCursor.TDefault.Create(Env, OwningObj, nil, hCrs);
end;

{-------------------------------------------------------------------------------}
function TMongoDatabase.HasCollection(const AName: String): Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_database_has_collection, ['database', Handle, 'name', AName]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Result := CLib.Fmongoc_database_has_collection(Handle,
    PFDAnsiString(PByte(Env.ANSI.Encode(AName))), @Env.Error.FBError);
  if not Result then
    Env.Error.CheckError(OwningObj);
end;

{-------------------------------------------------------------------------------}
procedure TMongoDatabase.CreateCollection(const AName: String; AOptions: TMongoDocument);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_database_create_collection, ['database', Handle,
      'name', AName, 'options', AOptions.AsJSON]);
  end;
{$ENDIF}

var
  hCol: Pmongoc_collection_t;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  hCol := CLib.Fmongoc_database_create_collection(Handle,
    PFDAnsiString(PByte(Env.ANSI.Encode(AName))), AOptions.AsReadHandle,
    @Env.Error.FBError);
  if hCol = nil then
    Env.Error.CheckError(OwningObj, smongoc_database_create_collection);
  if FCollection = nil then
    FCollection := TMongoCollection.Create(Env, OwningObj, hCol)
  else begin
    FCollection.Handle := hCol;
    FCollection.FOwnHandle := True;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMongoDatabase.DropCollection(const AName: String; AIgnoreObjNotExists: Boolean = False);
begin
  Collections[AName].Drop(AIgnoreObjNotExists);
end;

{-------------------------------------------------------------------------------}
function TMongoDatabase.InternalGetCollection(const AColName: String; ANew: Boolean): TMongoCollection;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_database_get_collection, ['database', Handle, 'name', AColName]);
  end;
{$ENDIF}

var
  hCol: Pmongoc_collection_t;
begin
  if not ANew and (FCollection <> nil) and
     (AnsiCompareText(AColName, FCollection.Name) = 0) then begin
    Result := FCollection;
    Exit;
  end;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  hCol := CLib.Fmongoc_database_get_collection(Handle,
    PFDAnsiString(PByte(Env.ANSI.Encode(AColName))));
  if ANew then
    Result := TMongoCollection.Create(Env, OwningObj, hCol)
  else begin
    if FCollection = nil then
      FCollection := TMongoCollection.Create(Env, OwningObj, hCol)
    else begin
      FCollection.Handle := hCol;
      FCollection.FOwnHandle := True;
    end;
    Result := FCollection;
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoDatabase.GetCollection(const AColName: String): TMongoCollection;
begin
  Result := InternalGetCollection(AColName, True);
end;

{-------------------------------------------------------------------------------}
function TMongoDatabase.GetCollectionsProp(const AColName: String): TMongoCollection;
begin
  Result := InternalGetCollection(AColName, False);
end;

{-------------------------------------------------------------------------------}
function TMongoDatabase.Command(ACommand: TMongoCommand; AFlags: TMongoQueryFlags = []): IMongoCursor;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_database_command, ['database', Handle,
      'flags', QF2mqft(AFlags), 'skip', ACommand.FSkip, 'limit', ACommand.FLimit,
      'batch_size', ACommand.Options.BatchSize, 'query', ACommand.FinalQueryBSON.AsJSON,
      'fields', ACommand.FinalProjectBSON.AsJSON]);
  end;
{$ENDIF}

var
  hCrs: Pmongoc_cursor_t;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  hCrs := CLib.Fmongoc_database_command(Handle, QF2mqft(AFlags), ACommand.FSkip,
    ACommand.FLimit, ACommand.Options.BatchSize, ACommand.FinalQueryBSON.AsReadHandle,
    ACommand.FinalProjectBSON.AsReadHandle, nil);
  if hCrs = nil then
    Env.Error.CheckError(OwningObj, smongoc_database_command);
  Result := TMongoCursor.TDefault.Create(Env, OwningObj, nil, hCrs);
end;

{-------------------------------------------------------------------------------}
function TMongoDatabase.Command(const AJSON: String; AFlags: TMongoQueryFlags = []): IMongoCursor;
var
  oCmd: TMongoCommand;
begin
  oCmd := TMongoCommand.Create(Env, FOwningObj);
  try
    oCmd.Command(AJSON);
    Result := Command(oCmd, AFlags);
  finally
    FDFree(oCmd);
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoDatabase.CommandSimple(ACommand: TMongoDocument): TMongoDocument;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_database_command_simple, ['database', Handle,
      'command', ACommand.AsJSON]);
  end;
{$ENDIF}

begin
  Result := TMongoDocument.Create(Env, OwningObj, Self);
  try
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    if not CLib.Fmongoc_database_command_simple(Handle, ACommand.AsReadHandle,
        nil, Result.AsWriteHandle, @Env.Error.FBError) then
      Env.Error.CheckError(OwningObj, smongoc_database_command_simple);
  except
    FDFree(Result);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoDatabase.CommandSimple(const AJSON: String): TMongoDocument;
var
  oCmd: TMongoDocument;
begin
  oCmd := TMongoDocument.Create(Env, OwningObj, Self);
  try
    oCmd.Append(AJSON);
    Result := CommandSimple(oCmd);
  finally
    FDFree(oCmd);
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoDatabase.Dereference(const ADBRef: TJsonDBRef): TMongoDocument;
begin
  Result := nil;
  if not (((ADBRef.DB = '') or AnsiSameText(ADBRef.DB, Name)) and
          (ADBRef.Ref <> '')) then
    FDException(OwningObj, [S_FD_LPhys, Env.CLib.DriverID],
      er_FD_MongoDBRefInvalid, [ADBRef.AsString]);
  try
    Result := Collections[ADBRef.Ref].Dereference(ADBRef.Id);
  except
    on E: EFDException do
      if E.FDCode = er_FD_MongoDBRefNotFound then
        FDException(OwningObj, [S_FD_LPhys, Env.CLib.DriverID],
          er_FD_MongoDBRefNotFound, [ADBRef.AsString])
      else
        raise;
  end;
end;

                  
                                          
                                             
 

{-------------------------------------------------------------------------------}
{ TMongoCollection                                                              }
{-------------------------------------------------------------------------------}
constructor TMongoCollection.Create(AEnv: TMongoEnv; AOwningObj: TObject;
  AHandle: Pmongoc_collection_t);
begin
  inherited Create(AEnv, AOwningObj, AHandle);
  FReadPreference := TMongoReadPreference.Create(AEnv, AOwningObj,
    CLib.Fmongoc_collection_get_read_prefs(AHandle));
  FWriteConcern := TMongoWriteConcern.Create(AEnv, AOwningObj,
    CLib.Fmongoc_collection_get_write_concern(AHandle));
  FLastOID := TMongoOID.Create(AEnv, AOwningObj);
end;

{-------------------------------------------------------------------------------}
destructor TMongoCollection.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FLastError);
  FDFreeAndNil(FReadPreference);
  FDFreeAndNil(FWriteConcern);
  FDFreeAndNil(FLastOID);
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.InternalFreeHandle;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_collection_destroy, ['collection', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  CLib.Fmongoc_collection_destroy(Handle);
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.FreeHandle;
begin
  CancelBulk;
  FReadPreference.Handle := nil;
  FWriteConcern.Handle := nil;
  if FLastError <> nil then
    FLastError.Handle := nil;
  inherited FreeHandle;
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.HandleAllocated;
begin
  inherited HandleAllocated;
  FReadPreference.Handle := CLib.Fmongoc_collection_get_read_prefs(Handle);
  FWriteConcern.Handle := CLib.Fmongoc_collection_get_write_concern(Handle);
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.GetName: String;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_collection_get_name, ['collection', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Result := Env.ANSI.Decode(Pointer(CLib.Fmongoc_collection_get_name(Handle)));
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.GetDB: String;
begin
  Result := Env.ANSI.Decode(Pointer(@P_mongoc_collection_t(Handle)^.db[0]));
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.GetNS: String;
begin
  Result := Env.ANSI.Decode(Pointer(@P_mongoc_collection_t(Handle)^.ns[0]),
    P_mongoc_collection_t(Handle)^.nslen);
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.Drop(AIgnoreObjNotExists: Boolean = False);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_collection_drop, ['collection', Handle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if not CLib.Fmongoc_collection_drop(Handle, @Env.Error.FBError) and
     ((Env.Error.FBError.code <> MONGOC_ERROR_QUERY_COMMAND_NOT_FOUND) or
      not AIgnoreObjNotExists) then
    Env.Error.CheckError(OwningObj, smongoc_collection_drop);
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.Rename(const ANewDB, ANewName: String;
  ADropTarget: Boolean = True);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_collection_rename, ['collection', Handle,
      'new_db', ANewDB, 'new_name', ANewName,
      'drop_target_before_rename', ADropTarget]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if not CLib.Fmongoc_collection_rename(Handle,
      PFDAnsiString(PByte(Env.ANSI.Encode(ANewDB))),
      PFDAnsiString(PByte(Env.ANSI.Encode(ANewName))),
      ADropTarget, @Env.Error.FBError) then
    Env.Error.CheckError(OwningObj, smongoc_collection_rename);
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.Validate(AOptions: TMongoDocument): TMongoDocument;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_collection_validate, ['collection', Handle,
      'options', AOptions.AsJSON]);
  end;
{$ENDIF}

begin
  Result := TMongoDocument.Create(Env, OwningObj, Self);
  try
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    if not CLib.Fmongoc_collection_validate(Handle, AOptions.AsReadHandle,
        Result.AsWriteHandle, @Env.Error.FBError) then
      Env.Error.CheckError(OwningObj, smongoc_collection_validate);
  except
    FDFree(Result);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.Statistics(AOptions: TMongoDocument): TMongoDocument;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_collection_stats, ['collection', Handle,
      'options', AOptions.AsJSON]);
  end;
{$ENDIF}

begin
  Result := TMongoDocument.Create(Env, OwningObj, Self);
  try
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    if not CLib.Fmongoc_collection_stats(Handle, AOptions.AsReadHandle,
        Result.AsWriteHandle, @Env.Error.FBError) then
      Env.Error.CheckError(OwningObj, smongoc_collection_stats);
  except
    FDFree(Result);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.ListIndexes: IMongoCursor;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_collection_find_indexes, ['collection', Handle]);
  end;
{$ENDIF}

var
  hCrs: Pmongoc_cursor_t;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  hCrs := CLib.Fmongoc_collection_find_indexes(Handle, @Env.Error.FBError);
  if hCrs = nil then
    Env.Error.CheckError(OwningObj, smongoc_collection_find_indexes);
  Result := TMongoCursor.TDefault.Create(Env, OwningObj, nil, hCrs);
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.CreateIndex(AIndex: TMongoIndex);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_collection_create_index, ['collection', Handle,
      'keys', AIndex.FKeys.FWriter.AsJSON, 'name', AIndex.FOptions.Name]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if not CLib.Fmongoc_collection_create_index(Handle,
      AIndex.FKeys.FWriter.AsReadHandle,
      @AIndex.FOptions.FOpts, @Env.Error.FBError) then
    Env.Error.CheckError(OwningObj, smongoc_collection_create_index);
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.DropIndex(const AName: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_collection_drop_index, ['collection', Handle,
      'index_name', AName]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if not CLib.Fmongoc_collection_drop_index(Handle,
      PFDAnsiString(PByte(Env.ANSI.Encode(AName))), @Env.Error.FBError) then
    Env.Error.CheckError(OwningObj, smongoc_collection_drop_index);
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.ResetCounts;
begin
  FDocsInserted := -1;
  FDocsMatched := -1;
  FDocsModified := -1;
  FDocsRemoved := -1;
  FDocsUpserted := -1;
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.ProcessWriteResult(AReply: TMongoDocument; ABulk: Boolean);
var
  oIter: TJSONIterator;
  oExc: EMongoNativeException;
  lReset: Boolean;

  procedure ProcessErrors(const AErrorGroup: String;
    AExc: EMongoNativeException; var AReset: Boolean);
  var
    iIndex: Integer;
    iCode: Integer;
    sMsg: string;
  begin
    if oIter.Next(AErrorGroup) then begin
      oIter.Recurse;
      while oIter.Next do begin
        oIter.Recurse;
        iIndex := -1;
        iCode := -1;
        sMsg := '';
        if oIter.Next('index') then
          iIndex := oIter.AsInteger;
        if oIter.Next('code') then
          iCode := oIter.AsInteger;
        if oIter.Next('errmsg') then
          sMsg := oIter.AsString;
        if AReset then begin
          oExc.Clear;
          AReset := False;
        end;
        oExc.AppendError(oExc.ErrorCount + 1, iCode, 0, sMsg, iIndex);
        oIter.Return;
      end;
      oIter.Return;
    end;
  end;

begin
  oIter := AReply.Iterator;
  try
    if oIter.Next('nInserted') then
      FDocsInserted := oIter.AsInteger;
    if oIter.Next('nMatched') then
      FDocsMatched := oIter.AsInteger;
    if oIter.Next('nModified') then
      FDocsModified := oIter.AsInteger;
    if oIter.Next('nRemoved') then
      FDocsRemoved := oIter.AsInteger;
    if oIter.Next('nUpserted') then
      FDocsUpserted := oIter.AsInteger;

    if ABulk and (ExceptObject <> nil) and (ExceptObject is EMongoNativeException) then begin
      oExc := EMongoNativeException(ExceptObject);
      lReset := True;
      ProcessErrors('writeErrors', oExc, lReset);
      ProcessErrors('writeConcernError', oExc, lReset);
    end;
  finally
    FDFree(oIter);
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.GetLastError: TMongoDocument;
begin
  if FLastError = nil then
    FLastError := TMongoDocument.Create(Env, OwningObj, Self);
  FLastError.AsReadHandle := CLib.Fmongoc_collection_get_last_error(Handle);
  Result := FLastError;
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.GetIsBulk: Boolean;
begin
  Result := FBulkHandle <> nil;
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.BeginBulk(AOrdered: Boolean);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_collection_create_bulk_operation, ['collection', Handle,
      'ordered', AOrdered]);
  end;
{$ENDIF}

begin
  if FBulkHandle <> nil then
    FDException(OwningObj, [S_FD_LPhys, Env.CLib.DriverID], er_FD_MongoBulkError, []);
  ResetCounts;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  FBulkHandle := CLib.Fmongoc_collection_create_bulk_operation(Handle, AOrdered,
    WriteConcern.Handle);
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.EndBulk;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_bulk_operation_execute, ['bulk', FBulkHandle]);
  end;
{$ENDIF}

var
  oReply: TMongoDocument;
begin
  if FBulkHandle = nil then
    FDException(OwningObj, [S_FD_LPhys, Env.CLib.DriverID], er_FD_MongoBulkError, []);
  oReply := TMongoDocument.Create(Env, OwningObj, Self);
  try
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    if CLib.Fmongoc_bulk_operation_execute(FBulkHandle, oReply.AsWriteHandle,
        @Env.Error.FBError) = 0 then
      Env.Error.CheckError(OwningObj, smongoc_bulk_operation_execute);
  finally
    ProcessWriteResult(oReply, True);
    CancelBulk;
    FDFree(oReply);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.CancelBulk;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_bulk_operation_destroy, ['bulk', FBulkHandle]);
  end;
{$ENDIF}

begin
  if FBulkHandle <> nil then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    CLib.Fmongoc_bulk_operation_destroy(FBulkHandle);
    FBulkHandle := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.EnsureID(ADocument: TMongoDocument);
var
  oIter: TJSONIterator;
begin
  oIter := ADocument.Iterator;
  try
    if oIter.Next('_id') then
      if oIter.&Type = TJsonToken.Oid then begin
        FLastOID.AsOid := oIter.AsOid;
        FLastID := FLastOID.AsString;
      end
      else
        FLastID := oIter.AsVariant
    else begin
      FLastOID.Init;
      FLastID := FLastOID.AsString;
      ADocument.Add('_id', FLastOID);
    end;
  finally
    FDFree(oIter);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.Insert(ADocument: TMongoDocument; AFlags: TInsertFlags = []);
var
  iFlags: mongoc_insert_flags_t;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_bulk_operation_insert, ['bulk', FBulkHandle, 'document', ADocument.AsJSON]);
  end;

  procedure Trace2;
  begin
    Env.Trace(smongoc_collection_insert, ['collection', Handle, 'flags', iFlags,
      'document', ADocument.AsJSON]);
  end;
{$ENDIF}

begin
  EnsureID(ADocument);

  if IsBulk then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    CLib.Fmongoc_bulk_operation_insert(FBulkHandle, ADocument.AsReadHandle);
  end

  else begin
    ResetCounts;
    try

      iFlags := MONGOC_INSERT_NONE;
      if TInsertFlag.ContinueOnError in AFlags then
        iFlags := iFlags or MONGOC_INSERT_CONTINUE_ON_ERROR;
      if TInsertFlag.NoValidate in AFlags then
        iFlags := iFlags or MONGOC_INSERT_NO_VALIDATE;

{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then Trace2;
{$ENDIF}
      if not CLib.Fmongoc_collection_insert(Handle, iFlags, ADocument.AsReadHandle,
          nil, @Env.Error.FBError) then
        Env.Error.CheckError(OwningObj, smongoc_collection_insert);

    finally
      ProcessWriteResult(LastError, False);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.Insert(AInsert: TMongoInsert; AFlags: TInsertFlags = []);
begin
  Insert(AInsert.FinalValuesBSON, AFlags);
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.Insert(AFlags: TInsertFlags = []): TMongoInsert;
begin
  Result := TMongoInsert.Create(Env, OwningObj,
    procedure(AInsert: TMongoInsert)
    begin
      try
        Insert(AInsert.FinalValuesBSON, AFlags);
      finally
        FDFree(AInsert);
      end;
    end
  );
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.Remove(ASelector: TMongoSelector; AFlags: TRemoveFlags = []);
var
  iFlags: mongoc_remove_flags_t;
  lFreeSel: Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_bulk_operation_remove_one, ['bulk', FBulkHandle,
      'selector', ASelector.FinalMatchBSON.AsJSON]);
  end;

  procedure Trace2;
  begin
    Env.Trace(smongoc_bulk_operation_remove, ['bulk', FBulkHandle,
      'selector', ASelector.FinalMatchBSON.AsJSON]);
  end;

  procedure Trace3;
  begin
    Env.Trace(smongoc_collection_remove, ['collection', Handle,
      'flags', iFlags, 'selector', ASelector.FinalMatchBSON.AsJSON]);
  end;
{$ENDIF}

begin
  lFreeSel := ASelector = nil;
  if lFreeSel then
    ASelector := TMongoSelector.Create(Env);
  // selector handle must be non nil
  if ASelector.FMatcher = nil then
    ASelector.Match();
  try

    if IsBulk then
      if TRemoveFlag.SingleRemove in AFlags then begin
{$IFDEF FireDAC_MONITOR}
        if Env.Tracing then Trace1;
{$ENDIF}
        CLib.Fmongoc_bulk_operation_remove_one(FBulkHandle,
          ASelector.FinalMatchBSON.AsReadHandle);
      end
      else begin
{$IFDEF FireDAC_MONITOR}
        if Env.Tracing then Trace2;
{$ENDIF}
        CLib.Fmongoc_bulk_operation_remove(FBulkHandle,
          ASelector.FinalMatchBSON.AsReadHandle);
      end

    else begin
      ResetCounts;
      try

        iFlags := MONGOC_REMOVE_NONE;
        if TRemoveFlag.SingleRemove in AFlags then
          iFlags := iFlags or MONGOC_REMOVE_SINGLE_REMOVE;

{$IFDEF FireDAC_MONITOR}
        if Env.Tracing then Trace3;
{$ENDIF}
        if not CLib.Fmongoc_collection_remove(Handle, iFlags,
            ASelector.FinalMatchBSON.AsReadHandle, nil, @Env.Error.FBError) then
          Env.Error.CheckError(OwningObj, smongoc_collection_remove);

      finally
        ProcessWriteResult(LastError, False);
      end;
    end;

  finally
    if lFreeSel then
      FDFree(ASelector);
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.Remove(AFlags: TRemoveFlags = []): TMongoSelector;
begin
  Result := TMongoSelector.Create(Env, OwningObj,
    procedure(ASelector: TMongoSelector)
    begin
      try
        Remove(ASelector, AFlags);
      finally
        FDFree(ASelector);
      end;
    end
  );
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.RemoveAll;
begin
  Remove(nil, []);
end;

{-------------------------------------------------------------------------------}
procedure TMongoCollection.Update(AUpdate: TMongoUpdate;
  AFlags: TUpdateFlags = [TUpdateFlag.MultiUpdate]);
var
  iFlags: mongoc_update_flags_t;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_bulk_operation_update_one, ['bulk', FBulkHandle,
      'selector', AUpdate.FinalMatchBSON.AsJSON,
      'document', AUpdate.FinalModifyBSON.AsJSON,
      'upsert', TUpdateFlag.Upsert in AFlags]);
  end;

  procedure Trace2;
  begin
    Env.Trace(smongoc_bulk_operation_update, ['bulk', FBulkHandle,
      'selector', AUpdate.FinalMatchBSON.AsJSON,
      'document', AUpdate.FinalModifyBSON.AsJSON,
      'upsert', TUpdateFlag.Upsert in AFlags]);
  end;

  procedure Trace3;
  begin
    Env.Trace(smongoc_collection_update, ['collection', Handle, 'flags', iFlags,
      'selector', AUpdate.FinalMatchBSON.AsJSON,
      'document', AUpdate.FinalModifyBSON.AsJSON]);
  end;
{$ENDIF}

begin
  if IsBulk then
    if not (TUpdateFlag.MultiUpdate in AFlags) then begin
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then Trace1;
{$ENDIF}
      CLib.Fmongoc_bulk_operation_update_one(FBulkHandle, AUpdate.FinalMatchBSON.AsReadHandle,
        AUpdate.FinalModifyBSON.AsReadHandle, TUpdateFlag.Upsert in AFlags);
    end
    else begin
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then Trace2;
{$ENDIF}
      CLib.Fmongoc_bulk_operation_update(FBulkHandle, AUpdate.FinalMatchBSON.AsReadHandle,
        AUpdate.FinalModifyBSON.AsReadHandle, TUpdateFlag.Upsert in AFlags);
    end

  else begin
    ResetCounts;
    try
      iFlags := MONGOC_UPDATE_NONE;
      if TUpdateFlag.Upsert in AFlags then
        iFlags := iFlags or MONGOC_UPDATE_UPSERT;
      if TUpdateFlag.MultiUpdate in AFlags then
        iFlags := iFlags or MONGOC_UPDATE_MULTI_UPDATE;

{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then Trace3;
{$ENDIF}
      if not CLib.Fmongoc_collection_update(Handle, iFlags, AUpdate.FinalMatchBSON.AsReadHandle,
          AUpdate.FinalModifyBSON.AsReadHandle, nil, @Env.Error.FBError) then
        Env.Error.CheckError(OwningObj, smongoc_collection_update);

    finally
      ProcessWriteResult(LastError, False);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.Update(AFlags: TUpdateFlags = [TUpdateFlag.MultiUpdate]): TMongoUpdate;
begin
  Result := TMongoUpdate.Create(Env, OwningObj,
    procedure(AUpdate: TMongoUpdate)
    begin
      try
        Update(AUpdate, AFlags);
      finally
        FDFree(AUpdate);
      end;
    end
  );
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.Count(AQuery: TMongoQuery; AFlags: TMongoQueryFlags = []): Int64;
var
  lDestroy: Boolean;
  iFlags: mongoc_query_flags_t;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_collection_count, ['collection', Handle,
      'flags', iFlags, 'query', AQuery.FinalCountBSON.AsJSON,
      'skip', AQuery.FSkip, 'limit', AQuery.FLimit]);
  end;
{$ENDIF}

begin
  lDestroy := AQuery = nil;
  if AQuery = nil then
    AQuery := TMongoQuery.Create(Env);
  try
    iFlags := QF2mqft(AFlags);
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    Result := CLib.Fmongoc_collection_count(Handle, iFlags,
      AQuery.FinalCountBSON.AsReadHandle, AQuery.FSkip, AQuery.FLimit,
      nil, @Env.Error.FBError);
    if Result = -1 then
      Env.Error.CheckError(OwningObj);
  finally
    if lDestroy then
      FDFree(AQuery);
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.Count(AFlags: TMongoQueryFlags = []): TMongoQuery;
begin
  Result := TMongoQuery.Create(Env, FOwningObj,
    function(AQuery: TMongoQuery): Int64
    begin
      try
        Result := Count(AQuery, AFlags);
      finally
        FDFree(AQuery);
      end;
    end
  );
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.AggregateBase(APipeline: TMongoPipeline;
  AReleasePipeline: Boolean; AFlags: TMongoQueryFlags): IMongoCursor;
var
  hCrs: Pmongoc_cursor_t;
  oReleaseObj: TObject;
  iFlags: mongoc_query_flags_t;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_collection_aggregate, ['collection', Handle,
      'flags', iFlags, 'pipeline', APipeline.FinalPipelineBSON.AsJSON,
      'options', APipeline.FinalOptionsBSON.AsJSON]);
  end;
{$ENDIF}

begin
  iFlags := QF2mqft(AFlags);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  hCrs := CLib.Fmongoc_collection_aggregate(Handle, iFlags,
    APipeline.FinalPipelineBSON.AsReadHandle, APipeline.FinalOptionsBSON.AsReadHandle, nil);
  if hCrs = nil then
    Env.Error.CheckError(OwningObj, smongoc_collection_aggregate);
  if AReleasePipeline then
    oReleaseObj := APipeline
  else
    oReleaseObj := nil;
  Result := TMongoCursor.TDefault.Create(Env, OwningObj, oReleaseObj, hCrs);
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.Aggregate(APipeline: TMongoPipeline;
  AFlags: TMongoQueryFlags = []): IMongoCursor;
begin
  Result := AggregateBase(APipeline, False, AFlags);
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.Aggregate(AFlags: TMongoQueryFlags = []): TMongoPipeline;
begin
  Result := TMongoPipeline.Create(Env, FOwningObj,
    function(APipeline: TMongoPipeline): IMongoCursor
    begin
      Result := AggregateBase(APipeline, True, AFlags);
    end
  );
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.FindBase(AQuery: TMongoQuery; AReleaseQuery: Boolean;
  AFlags: TMongoQueryFlags): IMongoCursor;
var
  hCrs: Pmongoc_cursor_t;
  oReleaseObj: TObject;
  iFlags: mongoc_query_flags_t;
  lDestroy: Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_collection_find, ['collection', Handle, 'flags', iFlags,
      'skip', AQuery.FSkip, 'limit', AQuery.FLimit, 'batch_size', AQuery.Options.BatchSize,
      'query', AQuery.FinalQueryBSON.AsJSON, 'fields', AQuery.FinalProjectBSON.AsJSON]);
  end;
{$ENDIF}

begin
  lDestroy := AQuery = nil;
  if AQuery = nil then
    AQuery := TMongoQuery.Create(Env);
  try
    iFlags := QF2mqft(AFlags);
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    hCrs := CLib.Fmongoc_collection_find(Handle, iFlags, AQuery.FSkip,
      AQuery.FLimit, AQuery.Options.BatchSize, AQuery.FinalQueryBSON.AsReadHandle,
      AQuery.FinalProjectBSON.AsReadHandle, nil);
    if hCrs = nil then
      Env.Error.CheckError(OwningObj, smongoc_collection_find);
    if AReleaseQuery then
      oReleaseObj := AQuery
    else
      oReleaseObj := nil;
    Result := TMongoCursor.TDefault.Create(Env, OwningObj, oReleaseObj, hCrs);
  finally
    if lDestroy then
      FDFree(AQuery);
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.Find(AQuery: TMongoQuery; AFlags: TMongoQueryFlags = []): IMongoCursor;
begin
  Result := FindBase(AQuery, False, AFlags);
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.Find(AFlags: TMongoQueryFlags = []): TMongoQuery;
begin
  Result := TMongoQuery.Create(Env, FOwningObj,
    function(AQuery: TMongoQuery): IMongoCursor
    begin
      Result := FindBase(AQuery, True, AFlags);
    end
  );
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.Command(ACommand: TMongoCommand; AFlags: TMongoQueryFlags = []): IMongoCursor;
var
  hCrs: Pmongoc_cursor_t;
  iFlags: mongoc_query_flags_t;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_collection_command, ['collection', Handle, 'flags', iFlags,
      'skip', ACommand.FSkip, 'limit', ACommand.FLimit, 'batch_size', ACommand.Options.BatchSize,
      'command', ACommand.FinalQueryBSON.AsJSON, 'fields', ACommand.FinalProjectBSON.AsJSON]);
  end;
{$ENDIF}

begin
  iFlags := QF2mqft(AFlags);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  hCrs := CLib.Fmongoc_collection_command(Handle, iFlags, ACommand.FSkip,
    ACommand.FLimit, ACommand.Options.BatchSize, ACommand.FinalQueryBSON.AsReadHandle,
    ACommand.FinalProjectBSON.AsReadHandle, nil);
  if hCrs = nil then
    Env.Error.CheckError(OwningObj, smongoc_collection_command);
  Result := TMongoCursor.TDefault.Create(Env, OwningObj, nil, hCrs);
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.Command(const AJSON: String; AFlags: TMongoQueryFlags = []): IMongoCursor;
var
  oCmd: TMongoCommand;
begin
  oCmd := TMongoCommand.Create(Env, FOwningObj);
  try
    oCmd.Command(AJSON);
    Result := Command(oCmd, AFlags);
  finally
    FDFree(oCmd);
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.CommandSimple(ACommand: TMongoDocument): TMongoDocument;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(smongoc_collection_command_simple, ['collection', Handle,
      'command', ACommand.AsJSON]);
  end;
{$ENDIF}

begin
  Result := TMongoDocument.Create(Env, OwningObj, Self);
  try
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    if not CLib.Fmongoc_collection_command_simple(Handle, ACommand.AsReadHandle,
        nil, Result.AsWriteHandle, @Env.Error.FBError) then
      Env.Error.CheckError(OwningObj, smongoc_collection_command_simple);
  except
    FDFree(Result);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.CommandSimple(const AJSON: String): TMongoDocument;
var
  oCmd: TMongoDocument;
begin
  oCmd := TMongoDocument.Create(Env, OwningObj, Self);
  try
    oCmd.Append(AJSON);
    Result := CommandSimple(oCmd);
  finally
    FDFree(oCmd);
  end;
end;

{-------------------------------------------------------------------------------}
function TMongoCollection.Dereference(const AOid: TJsonOid): TMongoDocument;
var
  oCrs: IMongoCursor;
begin
  oCrs := Find()
    .Match
      .BeginObject('_id')
        .Add('$eq', AOid)
      .EndObject
    .&End;
  Result := TMongoDocument.Create(Env, OwningObj, TObject(nil));
  try
    if not oCrs.Next(Result) then
      FDException(OwningObj, [S_FD_LPhys, Env.CLib.DriverID],
        er_FD_MongoDBRefNotFound, [AOid.AsString]);
  except
    FDFreeAndNil(Result);
    raise;
  end;
end;

                  
                                                      
                                                      
                                           
                                            
                                               
 

{-------------------------------------------------------------------------------}
function MongoNativeExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := EMongoNativeException.Create;
  EMongoNativeException(Result).LoadFromStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
initialization
  FDStorageManager().RegisterClass(EMongoNativeException, 'MongoNativeException',
    @MongoNativeExceptionLoad, @FDExceptionSave);

end.
