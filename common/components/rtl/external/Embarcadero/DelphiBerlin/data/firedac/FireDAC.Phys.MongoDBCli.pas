{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{             FireDAC MongoDB Call Interface            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$SCOPEDENUMS ON}

unit FireDAC.Phys.MongoDBCli;

interface

uses
  FireDAC.Stan.Intf;

type
  Pmongoc_handle_t = Pointer;
  Pmongoc_client_t = Pmongoc_handle_t;
  Pmongoc_cursor_t = Pmongoc_handle_t;
  Pmongoc_database_t = Pmongoc_handle_t;
  Pmongoc_collection_t = Pmongoc_handle_t;
  Pmongoc_read_prefs_t = Pmongoc_handle_t;
  Pmongoc_write_concern_t = Pmongoc_handle_t;
  Pmongoc_bulk_operation_t = Pmongoc_handle_t;
  Pmongoc_matcher_t = Pmongoc_handle_t;
  Pmongoc_uri_t = Pmongoc_handle_t;
  Pbson_context_t = Pmongoc_handle_t;

  // bson-context.h
  bson_context_flags_t = Cardinal;
const
  BSON_CONTEXT_NONE = 0;
  BSON_CONTEXT_THREAD_SAFE = (1 shl 0);
  BSON_CONTEXT_DISABLE_HOST_CACHE = (1 shl 1);
  BSON_CONTEXT_DISABLE_PID_CACHE = (1 shl 2);
  BSON_CONTEXT_USE_TASK_ID = (1 shl 3);

type
  // bson-memory.h
  Tbson_malloc = function (num_bytes: TFDsize_t): Pointer; cdecl;
  Tbson_calloc = function (n_members, num_bytes: TFDsize_t): Pointer; cdecl;
  Tbson_realloc = function (mem: Pointer; num_bytes: TFDsize_t): Pointer; cdecl;
  Tbson_free = procedure (mem: Pointer); cdecl;

  Pbson_mem_vtable_t = ^bson_mem_vtable_t;
  bson_mem_vtable_t = record
    malloc: Tbson_malloc;
    calloc: Tbson_calloc;
    realloc: Tbson_realloc;
    free: Tbson_free;
    padding: array [0 .. 3] of Pointer;
  end;

  // bson-types.h, bson.h
  bson_type_t = Cardinal;
  bson_subtype_t = Cardinal;
const
  BSON_TYPE_EOD = $00;
  BSON_TYPE_DOUBLE = $01;
  BSON_TYPE_UTF8 = $02;
  BSON_TYPE_DOCUMENT = $03;
  BSON_TYPE_ARRAY = $04;
  BSON_TYPE_BINARY = $05;
  BSON_TYPE_UNDEFINED = $06;
  BSON_TYPE_OID = $07;
  BSON_TYPE_BOOL = $08;
  BSON_TYPE_DATE_TIME = $09;
  BSON_TYPE_NULL = $0A;
  BSON_TYPE_REGEX = $0B;
  BSON_TYPE_DBPOINTER = $0C;
  BSON_TYPE_CODE = $0D;
  BSON_TYPE_SYMBOL = $0E;
  BSON_TYPE_CODEWSCOPE = $0F;
  BSON_TYPE_INT32 = $10;
  BSON_TYPE_TIMESTAMP = $11;
  BSON_TYPE_INT64 = $12;
  BSON_TYPE_MAXKEY = $7F;
  BSON_TYPE_MINKEY = $FF;

  BSON_SUBTYPE_BINARY = $00;
  BSON_SUBTYPE_FUNCTION = $01;
  BSON_SUBTYPE_BINARY_DEPRECATED = $02;
  BSON_SUBTYPE_UUID_DEPRECATED = $03;
  BSON_SUBTYPE_UUID = $04;
  BSON_SUBTYPE_MD5 = $05;
  BSON_SUBTYPE_USER = $80;

type
  time_t = LongInt;
  Ptimeval = ^timeval;
  timeval = record
    tv_sec: time_t;
    tv_usec: LongInt;
  end;

  Pbson_t = ^bson_t;
  PPbson_t = ^Pbson_t;
  bson_t = record
    flags: Cardinal;                  // Internal flags for the bson_t.
    len: Cardinal;                    // Length of BSON data.
                                      // Padding for stack allocation.
    padding: array [0..128 - (SizeOf(Cardinal) + SizeOf(Cardinal)) - 1] of Byte;
  end;

  Pbson_error_t = ^bson_error_t;
  bson_error_t = record
    domain: Cardinal;
    code: Cardinal;
    message: array[0..503] of TFDAnsiChar;
  end;

  Pbson_oid_t = ^bson_oid_t;
  bson_oid_t = record
   bytes: array [0..11] of Byte;
  end;

  Pbson_iter_t = ^bson_iter_t;
  bson_iter_t = record
    raw: PByte;         // The raw buffer being iterated.
    len: Cardinal;      // The length of raw.
    off: Cardinal;      // The offset within the buffer.
    _type: Cardinal;    // The offset of the type byte.
    key: Cardinal;      // The offset of the key byte.
    d1: Cardinal;       // The offset of the first data byte.
    d2: Cardinal;       // The offset of the second data byte.
    d3: Cardinal;       // The offset of the third data byte.
    d4: Cardinal;       // The offset of the fourth data byte.
    next_off: Cardinal; // The offset of the next field.
    err_off: Cardinal;  // The offset of the error.
    padding: array [0 .. 83] of Byte // bson_value_t   value;    // Internal value for various state.
  end;

  // mongoc.h
  Pmongoc_ssl_opt_t = ^mongoc_ssl_opt_t;
  mongoc_ssl_opt_t = record
    pem_file: PFDAnsiString;
    pem_pwd: PFDAnsiString;
    ca_file: PFDAnsiString;
    ca_dir: PFDAnsiString;
    crl_file: PFDAnsiString;
    weak_cert_validation: Boolean;
    padding: array [0..7] of Pointer;
  end;

  mongoc_delete_flags_t = Cardinal;
const
  MONGOC_DELETE_NONE          = 0;
  MONGOC_DELETE_SINGLE_REMOVE = 1 shl 0;

type
  mongoc_remove_flags_t = Cardinal;
const
  MONGOC_REMOVE_NONE          = 0;
  MONGOC_REMOVE_SINGLE_REMOVE = 1 shl 0;

type
  mongoc_insert_flags_t = Cardinal;
const
  MONGOC_INSERT_NONE              = 0;
  MONGOC_INSERT_CONTINUE_ON_ERROR = 1 shl 0;
  MONGOC_INSERT_NO_VALIDATE       = Cardinal(1 shl 31);

type
  mongoc_query_flags_t = Cardinal;
const
  MONGOC_QUERY_NONE              = 0;
  MONGOC_QUERY_TAILABLE_CURSOR   = 1 shl 1;
  MONGOC_QUERY_SLAVE_OK          = 1 shl 2;
  MONGOC_QUERY_OPLOG_REPLAY      = 1 shl 3;
  MONGOC_QUERY_NO_CURSOR_TIMEOUT = 1 shl 4;
  MONGOC_QUERY_AWAIT_DATA        = 1 shl 5;
  MONGOC_QUERY_EXHAUST           = 1 shl 6;
  MONGOC_QUERY_PARTIAL           = 1 shl 7;

type
  mongoc_reply_flags_t = Cardinal;
const
  MONGOC_REPLY_NONE               = 0;
  MONGOC_REPLY_CURSOR_NOT_FOUND   = 1 shl 0;
  MONGOC_REPLY_QUERY_FAILURE      = 1 shl 1;
  MONGOC_REPLY_SHARD_CONFIG_STALE = 1 shl 2;
  MONGOC_REPLY_AWAIT_CAPABLE      = 1 shl 3;

type
  mongoc_update_flags_t = Cardinal;
const
  MONGOC_UPDATE_NONE         = 0;
  MONGOC_UPDATE_UPSERT       = 1 shl 0;
  MONGOC_UPDATE_MULTI_UPDATE = 1 shl 1;

type
  mongoc_error_domain_t = Cardinal;
const
  MONGOC_ERROR_CLIENT = 1;
  MONGOC_ERROR_STREAM = 2;
  MONGOC_ERROR_PROTOCOL = 3;
  MONGOC_ERROR_CURSOR = 4;
  MONGOC_ERROR_QUERY = 5;
  MONGOC_ERROR_INSERT = 6;
  MONGOC_ERROR_SASL = 7;
  MONGOC_ERROR_BSON = 8;
  MONGOC_ERROR_MATCHER = 9;
  MONGOC_ERROR_NAMESPACE = 10;
  MONGOC_ERROR_COMMAND = 11;
  MONGOC_ERROR_COLLECTION = 12;
  MONGOC_ERROR_GRIDFS = 13;
  MONGOC_ERROR_SCRAM = 14;

type
  mongoc_error_code_t = Cardinal;
const
  MONGOC_ERROR_STREAM_INVALID_TYPE = 1;
  MONGOC_ERROR_STREAM_INVALID_STATE = 2;
  MONGOC_ERROR_STREAM_NAME_RESOLUTION = 3;
  MONGOC_ERROR_STREAM_SOCKET = 4;
  MONGOC_ERROR_STREAM_CONNECT = 5;
  MONGOC_ERROR_STREAM_NOT_ESTABLISHED = 6;

  MONGOC_ERROR_CLIENT_NOT_READY = 7;
  MONGOC_ERROR_CLIENT_TOO_BIG = 8;
  MONGOC_ERROR_CLIENT_TOO_SMALL = 9;
  MONGOC_ERROR_CLIENT_GETNONCE = 10;
  MONGOC_ERROR_CLIENT_AUTHENTICATE = 11;
  MONGOC_ERROR_CLIENT_NO_ACCEPTABLE_PEER = 12;
  MONGOC_ERROR_CLIENT_IN_EXHAUST = 13;

  MONGOC_ERROR_PROTOCOL_INVALID_REPLY = 14;
  MONGOC_ERROR_PROTOCOL_BAD_WIRE_VERSION = 15;

  MONGOC_ERROR_CURSOR_INVALID_CURSOR = 16;

  MONGOC_ERROR_QUERY_FAILURE = 17;

  MONGOC_ERROR_BSON_INVALID = 18;

  MONGOC_ERROR_MATCHER_INVALID = 19;

  MONGOC_ERROR_NAMESPACE_INVALID = 20;
  MONGOC_ERROR_NAMESPACE_INVALID_FILTER_TYPE = 21;

  MONGOC_ERROR_COMMAND_INVALID_ARG = 22;

  MONGOC_ERROR_COLLECTION_INSERT_FAILED = 23;
  MONGOC_ERROR_COLLECTION_DOES_NOT_EXIST = 26;

  MONGOC_ERROR_GRIDFS_INVALID_FILENAME = 27;

  MONGOC_ERROR_SCRAM_NOT_DONE = 28;
  MONGOC_ERROR_SCRAM_PROTOCOL_ERROR = 29;

  MONGOC_ERROR_QUERY_COMMAND_NOT_FOUND = 59;
  MONGOC_ERROR_QUERY_NOT_TAILABLE = 13051;

  MONGOC_ERROR_PROTOCOL_ERROR = 17;

type
  Pmongoc_index_opt_geo_t = ^mongoc_index_opt_geo_t;
  mongoc_index_opt_geo_t = record
    twod_sphere_version: Byte;
    twod_bits_precision: Byte;
    twod_location_min: Double;
    twod_location_max: Double;
    haystack_bucket_size: Double;
    padding: array [0..31] of PByte;
  end;

  Pmongoc_index_opt_storage_t = ^mongoc_index_opt_storage_t;
  mongoc_index_opt_storage_t = record
    _type: Integer;
  end;

  Pmongoc_index_opt_t = ^mongoc_index_opt_t;
  mongoc_index_opt_t = record
    is_initialized: Boolean;
    background: Boolean;
    unique: Boolean;
    name: PFDAnsiString;
    drop_dups: Boolean;
    sparse: Boolean;
    expire_after_seconds: Integer;
    v: Integer;
    weights: Pbson_t;
    default_language: PFDAnsiString;
    language_override: PFDAnsiString;
    geo_options: Pmongoc_index_opt_geo_t;
    storage_options: Pmongoc_index_opt_storage_t;
    padding: array [0..5] of Pointer;
  end;

  mongoc_log_level_t = Cardinal;
const
  MONGOC_LOG_LEVEL_ERROR = 0;
  MONGOC_LOG_LEVEL_CRITICAL = 1;
  MONGOC_LOG_LEVEL_WARNING = 2;
  MONGOC_LOG_LEVEL_MESSAGE = 3;
  MONGOC_LOG_LEVEL_INFO = 4;
  MONGOC_LOG_LEVEL_DEBUG = 5;
  MONGOC_LOG_LEVEL_TRACE = 6;
type
  Tmongoc_log_func_t = procedure (log_level: mongoc_log_level_t;
    log_domain, message: PFDAnsiString; user_data: Pointer); cdecl;

  mongoc_read_mode_t = Cardinal;
const
  MONGOC_READ_PRIMARY             = (1 shl 0);
  MONGOC_READ_SECONDARY           = (1 shl 1);
  MONGOC_READ_PRIMARY_PREFERRED   = (1 shl 2) or MONGOC_READ_PRIMARY;
  MONGOC_READ_SECONDARY_PREFERRED = (1 shl 2) or MONGOC_READ_SECONDARY;
  MONGOC_READ_NEAREST             = (1 shl 3) or MONGOC_READ_SECONDARY;

  MONGOC_WRITE_CONCERN_W_UNACKNOWLEDGED = 0;
  MONGOC_WRITE_CONCERN_W_ERRORS_IGNORED = -1;
  MONGOC_WRITE_CONCERN_W_DEFAULT        = -2;
  MONGOC_WRITE_CONCERN_W_MAJORITY       = -3;
  MONGOC_WRITE_CONCERN_W_TAG            = -4;

type
  // There is no API to get DB name or NS for a collection.
  // So, let use internal structure to get them.
  P_mongoc_collection_t = ^_mongoc_collection_t;
  _mongoc_collection_t = record
    client: Pmongoc_client_t;
    ns: array [0 .. 127] of TFDAnsiChar;
    nslen: Cardinal;
    db: array [0 .. 127] of TFDAnsiChar;
    collection: array [0 .. 127] of TFDAnsiChar;
    collectionlen: Cardinal;
    // ....
  end;

type
  // mongoc.h
  Tmongoc_client_new = function (uri_string: PFDAnsiString): Pmongoc_client_t; cdecl;
  Tmongoc_client_destroy = procedure (client: Pmongoc_client_t); cdecl;
  Tmongoc_client_command = function (client: Pmongoc_client_t; db_name: PFDAnsiString;
    flags: mongoc_query_flags_t; skip, limit, batch_size: Cardinal; query, fields: Pbson_t;
    read_prefs: Pmongoc_read_prefs_t): Pmongoc_cursor_t; cdecl;
  Tmongoc_client_command_simple = function (client: Pmongoc_client_t; db_name: PFDAnsiString;
    command: Pbson_t; read_prefs: Pmongoc_read_prefs_t; reply: Pbson_t;
    error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_client_kill_cursor = procedure (client: Pmongoc_client_t; cursor_id: Int64); cdecl;
  Tmongoc_client_get_database = function (client: Pmongoc_client_t;
    name: PFDAnsiString): Pmongoc_database_t; cdecl;
  Tmongoc_client_get_collection = function (client: Pmongoc_client_t;
    db, collection: PFDAnsiString): Pmongoc_collection_t; cdecl;
  Tmongoc_client_find_databases = function (client: Pmongoc_client_t;
    error: Pbson_error_t): Pmongoc_cursor_t; cdecl;
  Tmongoc_client_get_server_status = function (client: Pmongoc_client_t;
    read_prefs: Pmongoc_read_prefs_t; reply: Pbson_t; error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_client_get_max_message_size = function (client: Pmongoc_client_t): Integer; cdecl;
  Tmongoc_client_get_max_bson_size = function (client: Pmongoc_client_t): Integer; cdecl;
  Tmongoc_client_get_write_concern = function (client: Pmongoc_client_t):
    Pmongoc_write_concern_t; cdecl;
  Tmongoc_client_set_write_concern = procedure (client: Pmongoc_client_t;
    write_concern: Pmongoc_write_concern_t); cdecl;
  Tmongoc_client_get_read_prefs = function (client: Pmongoc_client_t):
    Pmongoc_read_prefs_t; cdecl;
  Tmongoc_client_set_read_prefs = procedure (client: Pmongoc_client_t;
    read_prefs: Pmongoc_read_prefs_t); cdecl;
  Tmongoc_client_set_ssl_opts = procedure (client: Pmongoc_client_t;
    opts: Pmongoc_ssl_opt_t); cdecl;
  Tmongoc_client_get_uri = function (client: Pmongoc_client_t): Pmongoc_uri_t; cdecl;

  // mongoc-uri.h
  Tmongoc_uri_get_string = function (uri: Pmongoc_uri_t): PFDAnsiString; cdecl;

  // mongoc-bulk-operation.h
  Tmongoc_bulk_operation_new = function (ordered: Boolean): Pmongoc_bulk_operation_t; cdecl;
  Tmongoc_bulk_operation_destroy = procedure (bulk: Pmongoc_bulk_operation_t); cdecl;
  Tmongoc_bulk_operation_execute = function (bulk: Pmongoc_bulk_operation_t;
    reply: Pbson_t; error: Pbson_error_t): Cardinal; cdecl;
  Tmongoc_bulk_operation_insert = procedure (bulk: Pmongoc_bulk_operation_t;
    document: Pbson_t); cdecl;
  Tmongoc_bulk_operation_remove = procedure (bulk: Pmongoc_bulk_operation_t;
    selector: Pbson_t); cdecl;
  Tmongoc_bulk_operation_remove_one = procedure (bulk: Pmongoc_bulk_operation_t;
    selector: Pbson_t); cdecl;
  Tmongoc_bulk_operation_replace_one = procedure (bulk: Pmongoc_bulk_operation_t;
    selector, document: Pbson_t; upsert: Boolean); cdecl;
  Tmongoc_bulk_operation_update = procedure (bulk: Pmongoc_bulk_operation_t;
    selector, document: Pbson_t; upsert: Boolean); cdecl;
  Tmongoc_bulk_operation_update_one = procedure (bulk: Pmongoc_bulk_operation_t;
    selector, document: Pbson_t; upsert: Boolean); cdecl;

  // mongoc-collection.h
  Tmongoc_collection_aggregate = function (collection: Pmongoc_collection_t;
    flags: mongoc_query_flags_t; pipeline, options: Pbson_t;
    read_prefs: Pmongoc_read_prefs_t): Pmongoc_cursor_t; cdecl;
  Tmongoc_collection_destroy = procedure (collection: Pmongoc_collection_t); cdecl;
  Tmongoc_collection_command = function (collection: Pmongoc_collection_t;
    flags: mongoc_query_flags_t; skip, limit, batch_size: Cardinal;
    command, fields: Pbson_t; read_prefs: Pmongoc_read_prefs_t): Pmongoc_cursor_t; cdecl;
  Tmongoc_collection_command_simple = function (collection: Pmongoc_collection_t;
    command: Pbson_t; read_prefs: Pmongoc_read_prefs_t; reply: Pbson_t;
    error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_collection_count = function (collection: Pmongoc_collection_t;
    flags: mongoc_query_flags_t; query: Pbson_t; skip, limit: Int64;
    read_prefs: Pmongoc_read_prefs_t; error: Pbson_error_t): Int64; cdecl;
  Tmongoc_collection_count_with_opts = function (collection: Pmongoc_collection_t;
    flags: mongoc_query_flags_t; query: Pbson_t; skip, limit: Int64;
    opts: Pbson_t; read_prefs: Pmongoc_read_prefs_t; error: Pbson_error_t): Int64; cdecl;
  Tmongoc_collection_drop = function (collection: Pmongoc_collection_t;
    error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_collection_drop_index = function (collection: Pmongoc_collection_t;
    index_name: PFDAnsiString; error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_collection_create_index = function (collection: Pmongoc_collection_t;
    keys: Pbson_t; opt: Pmongoc_index_opt_t; error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_collection_find_indexes = function (collection: Pmongoc_collection_t;
    error: Pbson_error_t): Pmongoc_cursor_t; cdecl;
  Tmongoc_collection_find = function (collection: Pmongoc_collection_t;
    flags: mongoc_query_flags_t; skip, limit, batch_size: Cardinal;
    query, fields: Pbson_t; read_prefs: Pmongoc_read_prefs_t): Pmongoc_cursor_t; cdecl;
  Tmongoc_collection_insert = function (collection: Pmongoc_collection_t;
    flags: mongoc_insert_flags_t; document: Pbson_t; write_concern: Pmongoc_write_concern_t;
    error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_collection_update = function (collection: Pmongoc_collection_t;
    flags: mongoc_update_flags_t; selector, update: Pbson_t;
    write_concern: Pmongoc_write_concern_t; error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_collection_save = function (collection: Pmongoc_collection_t;
    document: Pbson_t; write_concern: Pmongoc_write_concern_t; error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_collection_remove = function (collection: Pmongoc_collection_t;
    flags: mongoc_remove_flags_t; selector: Pbson_t; write_concern: Pmongoc_write_concern_t;
    error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_collection_rename = function (collection: Pmongoc_collection_t;
    new_db, new_name: PFDAnsiString; drop_target_before_rename: Boolean;
    error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_collection_find_and_modify = function (collection: Pmongoc_collection_t;
    query, sort, update, fields: Pbson_t; _remove, upsert, _new: Boolean;
    reply: Pbson_t; error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_collection_stats = function (collection: Pmongoc_collection_t;
    options, reply: Pbson_t; error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_collection_create_bulk_operation = function (collection: Pmongoc_collection_t;
    ordered: Boolean; write_concern: Pmongoc_write_concern_t): Pmongoc_bulk_operation_t; cdecl;
  Tmongoc_collection_get_read_prefs = function (collection: Pmongoc_collection_t):
    Pmongoc_read_prefs_t; cdecl;
  Tmongoc_collection_set_read_prefs = procedure (collection: Pmongoc_collection_t;
    read_prefs: Pmongoc_read_prefs_t); cdecl;
  Tmongoc_collection_get_write_concern = function (collection: Pmongoc_collection_t):
    Pmongoc_write_concern_t; cdecl;
  Tmongoc_collection_set_write_concern = procedure (collection: Pmongoc_collection_t;
    write_concern: Pmongoc_write_concern_t); cdecl;
  Tmongoc_collection_get_name = function (collection: Pmongoc_collection_t): PFDAnsiString; cdecl;
  Tmongoc_collection_get_last_error = function (collection: Pmongoc_collection_t): Pbson_t; cdecl;
  Tmongoc_collection_validate = function (collection: Pmongoc_collection_t;
    options, reply: Pbson_t; error: Pbson_error_t): Boolean; cdecl;

  // mongoc-cursor.h
  Tmongoc_cursor_destroy = procedure (cursor: Pmongoc_cursor_t); cdecl;
  Tmongoc_cursor_more = function (cursor: Pmongoc_cursor_t): Boolean; cdecl;
  Tmongoc_cursor_next = function (cursor: Pmongoc_cursor_t; bson: PPbson_t): Boolean; cdecl;
  Tmongoc_cursor_error = function (cursor: Pmongoc_cursor_t; error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_cursor_current = function (cursor: Pmongoc_cursor_t): Pbson_t; cdecl;
  Tmongoc_cursor_is_alive = function (cursor: Pmongoc_cursor_t): Boolean; cdecl;

  // mongoc-database.h
  Tmongoc_database_get_name = function (database: Pmongoc_database_t): PFDAnsiString; cdecl;
  Tmongoc_database_remove_user = function (database: Pmongoc_database_t;
    username: PFDAnsiString; error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_database_remove_all_users = function (database: Pmongoc_database_t;
    error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_database_add_user = function (database: Pmongoc_database_t;
    username, password: PFDAnsiString; roles, custom_data: Pbson_t;
    error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_database_destroy = procedure (database: Pmongoc_database_t); cdecl;
  Tmongoc_database_command = function (database: Pmongoc_database_t;
    flags: mongoc_query_flags_t; skip, limit, batch_size: Cardinal;
    command, fields: Pbson_t; read_prefs: Pmongoc_read_prefs_t): Pmongoc_cursor_t; cdecl;
  Tmongoc_database_command_simple = function (database: Pmongoc_database_t;
    command: Pbson_t; read_prefs: Pmongoc_read_prefs_t; reply: Pbson_t;
    error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_database_drop = function (database: Pmongoc_database_t;
    error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_database_has_collection = function (database: Pmongoc_database_t;
    name: PFDAnsiString; error: Pbson_error_t): Boolean; cdecl;
  Tmongoc_database_create_collection = function (database: Pmongoc_database_t;
    name: PFDAnsiString; options: Pbson_t; error: Pbson_error_t): Pmongoc_collection_t; cdecl;
  Tmongoc_database_get_read_prefs = function (database: Pmongoc_database_t):
    Pmongoc_read_prefs_t; cdecl;
  Tmongoc_database_set_read_prefs = procedure (database: Pmongoc_database_t;
    read_prefs: Pmongoc_read_prefs_t); cdecl;
  Tmongoc_database_get_write_concern = function (database: Pmongoc_database_t):
    Pmongoc_write_concern_t; cdecl;
  Tmongoc_database_set_write_concern = procedure (database: Pmongoc_database_t;
    write_concern: Pmongoc_write_concern_t); cdecl;
  Tmongoc_database_find_collections = function (database: Pmongoc_database_t;
    filter: Pbson_t; error: Pbson_error_t): Pmongoc_cursor_t; cdecl;
  Tmongoc_database_get_collection = function (database: Pmongoc_database_t;
    name: PFDAnsiString): Pmongoc_collection_t; cdecl;

  // mongoc-index.h
  Tmongoc_index_opt_get_default = function (): mongoc_index_opt_t; cdecl;
  Tmongoc_index_opt_init = procedure (opt: Pmongoc_index_opt_t); cdecl;

  // mongoc-init.h
  Tmongoc_init = procedure (); cdecl;
  Tmongoc_cleanup = procedure (); cdecl;

  // mongoc-log.h
  Tmongoc_log_set_handler = procedure (log_func: Tmongoc_log_func_t;
    user_data: Pointer); cdecl;
  Tmongoc_log_default_handler = procedure (log_level: mongoc_log_level_t;
    log_doman, message: PFDAnsiString; user_data: Pointer); cdecl;
  Tmongoc_log_level_str = function (log_level: mongoc_log_level_t): PFDAnsiString; cdecl;

  // mongoc-matcher.h
  Tmongoc_matcher_new = function (query: Pbson_t; error: Pbson_error_t): Pmongoc_matcher_t; cdecl;
  Tmongoc_matcher_match = function (matcher: Pmongoc_matcher_t; document: Pbson_t): Boolean; cdecl;
  Tmongoc_matcher_destroy = procedure (matcher: Pmongoc_matcher_t); cdecl;

  // mongoc-read-prefs.h
  Tmongoc_read_prefs_new = function (read_mode: mongoc_read_mode_t): Pmongoc_read_prefs_t; cdecl;
  Tmongoc_read_prefs_destroy = procedure (read_prefs: Pmongoc_read_prefs_t); cdecl;
  Tmongoc_read_prefs_copy = function (read_prefs: Pmongoc_read_prefs_t): Pmongoc_read_prefs_t; cdecl;
  Tmongoc_read_prefs_get_mode = function (read_prefs: Pmongoc_read_prefs_t): mongoc_read_mode_t; cdecl;
  Tmongoc_read_prefs_set_mode = procedure (read_prefs: Pmongoc_read_prefs_t; mode: mongoc_read_mode_t); cdecl;
  Tmongoc_read_prefs_get_tags = function (read_prefs: Pmongoc_read_prefs_t): Pbson_t; cdecl;
  Tmongoc_read_prefs_set_tags = procedure (read_prefs: Pmongoc_read_prefs_t; tags: Pbson_t); cdecl;
  Tmongoc_read_prefs_add_tag = procedure (read_prefs: Pmongoc_read_prefs_t; tag: Pbson_t); cdecl;
  Tmongoc_read_prefs_is_valid = function (read_prefs: Pmongoc_read_prefs_t): Boolean; cdecl;

  // mongoc-write-concern.h
  Tmongoc_write_concern_new = function (): Pmongoc_write_concern_t; cdecl;
  Tmongoc_write_concern_destroy = procedure (write_concern: Pmongoc_write_concern_t); cdecl;
  Tmongoc_write_concern_copy = function (write_concern: Pmongoc_write_concern_t): Pmongoc_write_concern_t; cdecl;
  Tmongoc_write_concern_get_fsync = function (write_concern: Pmongoc_write_concern_t): Boolean; cdecl;
  Tmongoc_write_concern_set_fsync = procedure (write_concern: Pmongoc_write_concern_t; fsync_: Boolean); cdecl;
  Tmongoc_write_concern_get_journal = function (write_concern: Pmongoc_write_concern_t): Boolean; cdecl;
  Tmongoc_write_concern_set_journal = procedure (write_concern: Pmongoc_write_concern_t; journal: Boolean); cdecl;
  Tmongoc_write_concern_get_w = function (write_concern: Pmongoc_write_concern_t): Integer; cdecl;
  Tmongoc_write_concern_set_w = procedure (write_concern: Pmongoc_write_concern_t; w: Integer); cdecl;
  Tmongoc_write_concern_get_wtag = function (write_concern: Pmongoc_write_concern_t): PFDAnsiString; cdecl;
  Tmongoc_write_concern_set_wtag = procedure (write_concern: Pmongoc_write_concern_t; tag: PFDAnsiString); cdecl;
  Tmongoc_write_concern_get_wtimeout = function (write_concern: Pmongoc_write_concern_t): Integer; cdecl;
  Tmongoc_write_concern_set_wtimeout = procedure (write_concern: Pmongoc_write_concern_t; wtimeout_msec: Integer); cdecl;
  Tmongoc_write_concern_get_wmajority = function (write_concern: Pmongoc_write_concern_t): Integer; cdecl;
  Tmongoc_write_concern_set_wmajority = procedure (write_concern: Pmongoc_write_concern_t; wtimeout_msec: Integer); cdecl;

  // bson.h
  Tbson_mem_set_vtable = procedure (vtable: Pbson_mem_vtable_t); cdecl;
  Tbson_init = procedure (bson: Pbson_t); cdecl;
  Tbson_init_static = function (bson: Pbson_t; data: PByte; len: TFDsize_t): Boolean; cdecl;
  Tbson_reinit = Tbson_init;
  Tbson_new = function (): Pbson_t; cdecl;
  Tbson_destroy = procedure (bson: Pbson_t); cdecl;
  Tbson_get_data = function (bson: Pbson_t): PByte; cdecl;
  Tbson_init_from_json = function (bson: Pbson_t; data: PFDAnsiString; len: TFDssize_t;
    error: Pbson_error_t): Boolean; cdecl;
  Tbson_as_json = function (bson: Pbson_t; length: PFDsize_t): PFDAnsiString; cdecl;
  Tbson_copy_to = procedure (src, dst: Pbson_t); cdecl;
  Tbson_concat = function (dst, src: Pbson_t): Boolean; cdecl;
  Tbson_append_array = function (bson: Pbson_t; key: PFDAnsiString; key_length: Integer;
    _array: Pbson_t): Boolean; cdecl;
  Tbson_append_document = function (bson: Pbson_t; key: PFDAnsiString; key_length: Integer;
    value: Pbson_t): Boolean; cdecl;
  Tbson_append_binary = function (bson: Pbson_t; key: PFDAnsiString; key_length: Integer;
    subtype: bson_subtype_t; binary: PByte; length: Cardinal): Boolean; cdecl;
  Tbson_append_bool = function (bson: Pbson_t; key: PFDAnsiString; key_length: Integer;
    value: Boolean): Boolean; cdecl;
  Tbson_append_code = function (bson: Pbson_t; key: PFDAnsiString; key_length: Integer;
    javascript: PFDAnsiString): Boolean; cdecl;
  Tbson_append_code_with_scope = function (bson: Pbson_t; key: PFDAnsiString; key_length: Integer;
    javascript: PFDAnsiString; scope: Pbson_t): Boolean; cdecl;
  Tbson_append_double = function (bson: Pbson_t; key: PFDAnsiString; key_length: Integer;
    value: Double): Boolean; cdecl;
  Tbson_append_int32 = function (bson: Pbson_t; key: PFDAnsiString; key_length: Integer;
    value: Integer): Boolean; cdecl;
  Tbson_append_int64 = function (bson: Pbson_t; key: PFDAnsiString; key_length: Integer;
    value: Int64): Boolean; cdecl;
  Tbson_append_null = function (bson: Pbson_t; key: PFDAnsiString; key_length: Integer): Boolean; cdecl;
  Tbson_append_oid = function (bson: Pbson_t; key: PFDAnsiString; key_length: Integer;
    oid: Pbson_oid_t): Boolean; cdecl;
  Tbson_append_regex = function (bson: Pbson_t; key: PFDAnsiString; key_length: Integer;
    regex, options: PFDAnsiString): Boolean; cdecl;
  Tbson_append_utf8 = function (bson: Pbson_t; key: PFDAnsiString; key_length: Integer;
    value: PFDAnsiString; length: Integer): Boolean; cdecl;
  Tbson_append_time_t = function (bson: Pbson_t; key: PFDAnsiString; key_length: Integer;
    value: time_t): Boolean; cdecl;
  Tbson_append_timeval = function (bson: Pbson_t; key: PFDAnsiString; key_length: Integer;
    value: Ptimeval): Boolean; cdecl;
  Tbson_append_date_time = function (bson: Pbson_t; key: PFDAnsiString; key_length: Integer;
    value: Int64): Boolean; cdecl;

  // bson-context.h
  Tbson_context_new = function (flags: bson_context_flags_t): Pbson_context_t; cdecl;
  Tbson_context_destroy = procedure (context: Pbson_context_t); cdecl;
  Tbson_context_get_default = function (): Pbson_context_t; cdecl;

  // bson-oid.h
  Tbson_oid_compare = function (oid1, oid2: Pbson_oid_t): Integer; cdecl;
  Tbson_oid_copy = procedure (src, dst: Pbson_oid_t); cdecl;
  Tbson_oid_init = procedure (oid: Pbson_oid_t; context: Pbson_context_t); cdecl;
  Tbson_oid_init_from_string = procedure (oid: Pbson_oid_t; str: PFDAnsiString); cdecl;
  Tbson_oid_to_string = procedure (oid: Pbson_oid_t; str: PFDAnsiString); cdecl;
  Tbson_oid_get_time_t = function (oid: Pbson_oid_t): time_t; cdecl;

  // bson-iter.h
  Tbson_iter_init = function (iter: Pbson_iter_t; bson: Pbson_t): Boolean; cdecl;
  Tbson_iter_find = function (iter: Pbson_iter_t; key: PFDAnsiString): Boolean; cdecl;
  Tbson_iter_find_descendant = function (iter: Pbson_iter_t; dotkey: PFDAnsiString;
    descendant: Pbson_iter_t): Boolean; cdecl;
  Tbson_iter_next = function (iter: Pbson_iter_t): Boolean; cdecl;
  Tbson_iter_recurse = function (iter, child: Pbson_iter_t): Boolean; cdecl;
  Tbson_iter_key = function (iter: Pbson_iter_t): PFDAnsiString; cdecl;
  Tbson_iter_type = function (iter: Pbson_iter_t): bson_type_t; cdecl;
  Tbson_iter_binary = procedure (iter: Pbson_iter_t; var subtype: bson_subtype_t;
    var binary_len: Cardinal; var binary: PByte); cdecl;
  Tbson_iter_bool = function (iter: Pbson_iter_t): Boolean; cdecl;
  Tbson_iter_code = function (iter: Pbson_iter_t; var length: Integer): PFDAnsiString; cdecl;
  Tbson_iter_double = function (iter: Pbson_iter_t): Double; cdecl;
  Tbson_iter_int32 = function (iter: Pbson_iter_t): Integer; cdecl;
  Tbson_iter_int64 = function (iter: Pbson_iter_t): Int64; cdecl;
  Tbson_iter_oid = function (iter: Pbson_iter_t): Pbson_oid_t; cdecl;
  Tbson_iter_regex = function (iter: Pbson_iter_t; var options: PFDAnsiString): PFDAnsiString; cdecl;
  Tbson_iter_utf8 = function (iter: Pbson_iter_t; var length: Cardinal): PFDAnsiString; cdecl;
  Tbson_iter_time_t = function (iter: Pbson_iter_t): time_t; cdecl;
  Tbson_iter_date_time = function (iter: Pbson_iter_t): Int64; cdecl;

implementation

end.
