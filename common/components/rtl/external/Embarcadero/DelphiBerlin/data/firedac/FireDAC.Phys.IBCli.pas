{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{       FireDAC InterBase/Firebird Call Interface       }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.IBCli;

interface

uses
  System.SysUtils,
  FireDAC.Stan.Intf;

  // ---------------------------------------------------------------------------
  // Basic data types
  // ---------------------------------------------------------------------------
type
  intptr_t = NativeInt;
  uintptr_t = NativeUInt;
  // IB: api_handle_t=Pointer, FB: api_handle_t=Integer
  api_handle_t = Pointer;

  ISC_UCHAR = Byte;
  ISC_SCHAR = ShortInt;

  ISC_SHORT = Smallint;
  ISC_USHORT = Word;
  ISC_SSHORT = Smallint;

  ISC_LONG = Integer;
  ISC_ULONG = Cardinal;
  ISC_SLONG = Integer;

  ISC_INT64 = Int64;
  ISC_UINT64 = UInt64;

  ISC_BOOLEAN = WordBool;

  ISC_STATUS = intptr_t;
  TISCStatusVector = array[0..19] of ISC_STATUS;

  TISCEventCounts = array[0..19] of ISC_ULONG;

  SQUAD = record
    high: ISC_SLONG;
    low: ISC_ULONG;
  end;

  GDS_QUAD = record
    gds_quad_high: ISC_SLONG;
    gds_quad_low: ISC_ULONG;
  end;
  ISC_QUAD = GDS_QUAD;

  vary = record
    vary_length: ISC_USHORT;
    vary_string: array [0..0] of ISC_UCHAR;
  end;

  lstring = record
    lstr_length: ISC_ULONG;
    lstr_allocated: ISC_ULONG;
    lstr_address: ^ISC_UCHAR;
  end;

  PISC_UCHAR = ^ISC_UCHAR;
  PISC_SCHAR = ^ISC_SCHAR;
  PPISC_SCHAR = ^PISC_SCHAR;
  PISC_SHORT = ^ISC_SHORT;
  PISC_LONG = ^ISC_LONG;
  PISC_ULONG = ^ISC_ULONG;
  PISC_BOOLEAN = ^ISC_BOOLEAN;
  PISC_STATUS = ^ISC_STATUS;
  PGDS_QUAD = ^GDS_QUAD;
  PISC_QUAD = ^ISC_QUAD;
  Pvary = ^vary;
  Plstring = ^lstring;

const
  ISC_TRUE = 1;
  ISC_FALSE = 0;

  DSQL_close = 1;
  DSQL_drop = 2;
  DSQL_cancel = 4;
  DSQL_unprepare = 4;

  METADATALENGTH_V2 = 68;
  METADATALENGTH_V1 = 32;

const
  FB_SQLSTATE_SIZE = 6;
type
  FB_SQLSTATE_STRING = array [0 .. FB_SQLSTATE_SIZE-1] of ISC_SCHAR;

  // ---------------------------------------------------------------------------
  // Time & Date Support
  // ---------------------------------------------------------------------------
  ISC_DATE = ISC_LONG;
  PISC_DATE = ^ISC_DATE;

  ISC_TIME = ISC_ULONG;
  PISC_TIME = ^ISC_TIME;

  PISC_TIMESTAMP = ^ISC_TIMESTAMP;
  ISC_TIMESTAMP = record
    timestamp_date: ISC_DATE;
    timestamp_time: ISC_TIME;
  end;

  // C Date/Time Structure
  TCTimeStructure = record
    tm_sec: Integer;   // Seconds
    tm_min: Integer;   // Minutes
    tm_hour: Integer;  // Hour (0--23)
    tm_mday: Integer;  // Day of month (1--31)
    tm_mon: Integer;   // Month (0--11)
    tm_year: Integer;  // Year (calendar year minus 1900)
    tm_wday: Integer;  // Weekday (0--6) Sunday = 0)
    tm_yday: Integer;  // Day of year (0--365)
    tm_isdst: Integer; // 0 if daylight savings time is not in effect)
{$IFNDEF MSWINDOWS}
    tm_gmtoff: LongInt;// Seconds east of UTC
    rm_zone: PByte;    // Timezone abbreviation
{$ENDIF}
  end;
  PCTimeStructure = ^TCTimeStructure;

const
  ISC_TIME_SECONDS_PRECISION = 10000;
  ISC_TIME_SECONDS_PRECISION_SCALE = -4;

  // ---------------------------------------------------------------------------
  // Blob and array structures
  // ---------------------------------------------------------------------------
type
  PISC_ARRAY_BOUND = ^ISC_ARRAY_BOUND;
  ISC_ARRAY_BOUND = record
    array_bound_lower: ISC_SHORT;
    array_bound_upper: ISC_SHORT;
  end;
  PISC_ARRAY_BOUNDs = ^TISC_ARRAY_BOUNDs;
  TISC_ARRAY_BOUNDs = array [0..15] of ISC_ARRAY_BOUND;

  PISC_ARRAY_DESC = Pointer;
  PISC_BLOB_DESC = Pointer;

  PISC_ARRAY_DESC_V1 = ^ISC_ARRAY_DESC_V1;
  ISC_ARRAY_DESC_V1 = record
    array_desc_dtype: ISC_UCHAR;
    array_desc_scale: ISC_SCHAR;
    array_desc_length: ISC_USHORT;
    array_desc_field_name: array [0..METADATALENGTH_V1 - 1] of ISC_SCHAR;
    array_desc_relation_name: array [0..METADATALENGTH_V1 - 1] of ISC_SCHAR;
    array_desc_dimensions: ISC_SHORT;
    array_desc_flags: ISC_SHORT;
    array_desc_bounds: TISC_ARRAY_BOUNDs;
  end;

  PISC_BLOB_DESC_V1 = ^ISC_BLOB_DESC_V1;
  ISC_BLOB_DESC_V1 = record
    blob_desc_subtype: ISC_SHORT;
    blob_desc_charset: ISC_SHORT;
    blob_desc_segment_size: ISC_SHORT;
    blob_desc_field_name: array [0..METADATALENGTH_V1 - 1] of ISC_UCHAR;
    blob_desc_relation_name: array [0..METADATALENGTH_V1 - 1] of ISC_UCHAR;
  end;

  PISC_ARRAY_DESC_V2 = ^ISC_ARRAY_DESC_V2;
  ISC_ARRAY_DESC_V2 = record
    array_desc_version: ISC_SHORT;
    array_desc_dtype: ISC_UCHAR;
    array_desc_subtype: ISC_UCHAR;
    array_desc_scale: ISC_SCHAR;
    array_desc_length: ISC_USHORT;
    array_desc_field_name: array [0..METADATALENGTH_V2 - 1] of ISC_SCHAR;
    array_desc_relation_name: array [0..METADATALENGTH_V2 - 1] of ISC_SCHAR;
    array_desc_dimensions: ISC_SHORT;
    array_desc_flags: ISC_SHORT;
    array_desc_bounds: TISC_ARRAY_BOUNDs;
  end;

  PISC_BLOB_DESC_V2 = ^ISC_BLOB_DESC_V2;
  ISC_BLOB_DESC_V2 = record
    blob_desc_version: ISC_SHORT;
    blob_desc_subtype: ISC_SHORT;
    blob_desc_charset: ISC_SHORT;
    blob_desc_segment_size: ISC_SHORT;
    blob_desc_field_name: array [0..METADATALENGTH_V2 - 1] of ISC_UCHAR;
    blob_desc_relation_name: array [0..METADATALENGTH_V2 - 1] of ISC_UCHAR;
  end;

const
  ARR_DESC_VERSION2 = 2;
  BLB_DESC_VERSION2 = 2;
  ARR_DESC_VERSION1 = 1;
  BLB_DESC_VERSION1 = 1;

  // ---------------------------------------------------------------------------
  // Blob control structure
  // ---------------------------------------------------------------------------
type
  PISC_BLOB_CTL = ^ISC_BLOB_CTL;
  TISCStatusFn = function(Action: Word; Control: PISC_BLOB_CTL): ISC_STATUS; cdecl;
  ISC_BLOB_CTL = record
    ctl_source: TISCStatusFn;          // Source filter
    ctl_source_handle: PISC_BLOB_CTL;  // Argument to pass to source filter
    ctl_to_sub_type: Smallint;         // Target type
    ctl_from_sub_type: Smallint;       // Source type
    ctl_buffer_length: Word;           // Length of buffer
    ctl_segment_length: Word;          // Length of current segment
    ctl_bpb_length: Word;              // Length of blob parameter  block
    ctl_bpb: PISC_SCHAR;               // Address of blob parameter block
    ctl_buffer: PISC_UCHAR;            // Address of segment buffer
    ctl_max_segment: ISC_LONG;         // Length of longest segment
    ctl_number_segments: ISC_LONG;     // Total number of segments
    ctl_total_length: ISC_LONG;        // Total length of blob
    ctl_status: PISC_STATUS;           // Address of status vector
    ctl_data: array [0..7] of NativeInt; // Application specific data
  end;

  // ---------------------------------------------------------------------------
  // Blob stream definitions
  // ---------------------------------------------------------------------------
  PBSTREAM = ^BSTREAM;
  BSTREAM = record
    bstr_blob: api_handle_t;    // Blob handle
    bstr_buffer: PISC_SCHAR;    // Address of buffer
    bstr_ptr: PISC_SCHAR;       // Next character
    bstr_length: Smallint;      // Length of buffer
    bstr_cnt: Smallint;         // Characters in buffer
    bstr_mode: ISC_SCHAR;       // (mode) ? OUTPUT : INPUT
  end;

  // ---------------------------------------------------------------------------
  // CVC: Public blob interface definition held in val.h.
  // For some unknown reason, it was only documented in langRef
  // and being the structure passed by the engine to UDFs it never
  // made its way into this public definitions file.
  // Being its original name "blob", I renamed it blobcallback here.
  // I did the full definition with the proper parameters instead of
  // the weak C declaration with any number and type of parameters.
  // Since the first parameter -BLB- is unknown outside the engine,
  // it's more accurate to use void* than int* as the blob pointer
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  // Blob passing structure
  // ---------------------------------------------------------------------------
const
  // This enum applies to parameter "mode" in blob_lseek
  blb_seek_relative = 1;
  blb_seek_from_tail = 2;

  // This enum applies to the value returned by blob_get_segment
  blb_got_fragment = -1;
  blb_got_eof = 0;
  blb_got_full_segment = 1;

type
  TBlobGetSegmentFn = function(hnd: Pointer; buffer: PISC_UCHAR; buf_size: ISC_USHORT;
    var result_len: ISC_USHORT): Smallint; stdcall;
  TBlobPutSegmentFn = procedure(hnd: Pointer; buffer: PISC_UCHAR; buf_size: ISC_USHORT); stdcall;
  TBlobLSeekFn = function(hnd: Pointer; mode: ISC_USHORT; offset: ISC_LONG): ISC_LONG; stdcall;

  PBLOBCALLBACK = ^BLOBCALLBACK;
  BLOBCALLBACK = record
    blob_get_segment: TBlobGetSegmentFn;
    blob_handle: Pointer;
    blob_number_segments: ISC_LONG;
    blob_max_segment: ISC_LONG;
    blob_total_length: ISC_LONG;
    blob_put_segment: TBlobPutSegmentFn;
    blob_lseek: TBlobLSeekFn;
  end;

  // ---------------------------------------------------------------------------
  // CVC: Public descriptor interface held in dsc.h.
  // We need it documented to be able to recognize NULL in UDFs.
  // Being its original name "dsc", I renamed it paramdsc here.
  // Notice that I adjust to the original definition: contrary to
  // other cases, the typedef is the same struct not the pointer.
  // I included the enumeration of dsc_dtype possible values.
  // Ultimately, dsc.h should be part of the public interface.
  // ---------------------------------------------------------------------------

  // This is the famous internal descriptor that UDFs can use, too.

  PPARAMDSC_V1 = ^PARAMDSC_V1;
  PARAMDSC_V1 = record
    dsc_dtype: ISC_UCHAR;
    dsc_scale: ShortInt;
    dsc_length: ISC_USHORT;
    dsc_sub_type: Smallint;
    dsc_flags: ISC_USHORT;
    dsc_address: PISC_UCHAR;
  end;

  PPARAMDSC_V2 = ^PARAMDSC_V2;
  PARAMDSC_V2 = record
    dsc_version: Byte;
    dsc_dtype: Byte;
    dsc_scale: ShortInt;
    dsc_precision: ShortInt;
    dsc_length: Word;
    dsc_sub_type: SmallInt;
    dsc_flags: Word;
    dsc_address: PByte;
  end;

  // This is a helper struct to work with varchars.
  PPARAMVARY = ^PARAMVARY;
  PARAMVARY = record
    vary_length: ISC_USHORT;
    vary_string: array [0..0] of ISC_UCHAR;
  end;

  // values for dsc_flags
  // Note: DSC_null is only reliably set for local variables (blr_variable)
const
  DSC_null = 1;
  DSC_no_subtype = 2; // dsc has no sub type specified
  DSC_nullable = 4;   // not stored. instead, is derived
                      //     from metadata primarily to flag
                      //     SQLDA (in DSQL) *)

  // ---------------------------------------------------------------------------
  // Note that dtype_null actually means that we do not yet know the
  // dtype for this descriptor.  A nice cleanup item would be to globally
  // change it to dtype_unknown.  --chrisj 1999-02-17
  // ---------------------------------------------------------------------------
  dtype_unknown = 0;
  dtype_null = 0;
  dtype_text = 1;
  dtype_cstring = 2;
  dtype_varying = 3;

  dtype_packed = 6;
  dtype_byte = 7;
  dtype_short = 8;
  dtype_long = 9;
  dtype_quad = 10;
  dtype_real = 11;
  dtype_double = 12;
  dtype_d_float = 13;
  dtype_sql_date = 14;
  dtype_sql_time = 15;
  dtype_timestamp = 16;
  dtype_blob = 17;
  dtype_array = 18;
  dtype_int64 = 19;
  dtype_dbkey	= 20;
  // FB 3.0
  dtype_boolean = 21;

  DTYPE_TYPE_MAX = 22;

  // ---------------------------------------------------------------------------
  // Dynamic SQL definitions
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  // Declare the extended SQLDA
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  // Older and obsolete XSQLVAR, ISC_BLOB_DESC, ISC_ARRAY_DESC strucutres.
  // NOTE:These structure will no longer be available in future releases.
  // This is kept only for backward  compatability.
  // Please refrain from  using these old structures.
  // It is strongly  recomended  to use the newer SQLDA version
  // and related XSQLVAR, ISC_BLOB_DESC, ISC_ARRAY_DESC structures.
  // ---------------------------------------------------------------------------
type
  PXSQLVAR_V1 = ^XSQLVAR_V1;
  XSQLVAR_V1 = record
    sqltype: ISC_SHORT;                                        // datatype of field
    sqlscale: ISC_SHORT;                                       // scale factor
    sqlsubtype: ISC_SHORT;                                     // datatype subtype
    sqllen: ISC_SHORT;                                         // length of data area
    sqldata: PISC_SCHAR;                                       // address of data
    sqlind: PISC_SHORT;                                        // address of indicator variable
    sqlname_length: ISC_SHORT;                                 // length of sqlname field
    sqlname: array [0..METADATALENGTH_V1 - 1] of ISC_SCHAR;    // name of field, name length + space for NULL
    relname_length: ISC_SHORT;                                 // length of relation name
    relname: array [0..METADATALENGTH_V1 - 1] of ISC_SCHAR;    // field's relation name + space for NULL
    ownname_length: ISC_SHORT;                                 // length of owner name
    ownname: array [0..METADATALENGTH_V1 - 1] of ISC_SCHAR;    // relation's owner name + space for NULL
    aliasname_length: ISC_SHORT;                               // length of alias name
    aliasname: array [0..METADATALENGTH_V1 - 1] of ISC_SCHAR;  // relation's alias name + space for  NULL
  end;

  PXSQLDA_V1 = ^XSQLDA_V1;
  XSQLDA_V1 = record
    version: ISC_SHORT;                                // version of this XSQLDA
    sqldaid: array [0..7] of ISC_SCHAR;                // XSQLDA name field          ->  RESERVED
    sqldabc: ISC_LONG;                                 // length in bytes of SQLDA   ->  RESERVED
    sqln: ISC_SHORT;                                   // number of fields allocated
    sqld: ISC_SHORT;                                   // actual number of fields
    sqlvar: array [0..0] of XSQLVAR_V1;                // first field address
  end;

  PXSQLVAR_V2 = ^XSQLVAR_V2;
  PPXSQLVAR_V2 = ^PXSQLVAR_V2;
  XSQLVAR_V2 = record
    sqltype: Smallint;                                       // datatype of field
    sqlscale: Smallint;                                      // scale factor
    sqlprecision: Smallint;                                  // precision : Reserved for future
    sqlsubtype: Smallint;                                    // datatype subtype
    sqllen: Smallint;                                        // length of data area
    sqldata: PByte;                                          // address of data
    sqlind: PSmallint;                                       // address of indicator variable
    sqlname_length: Smallint;                                // length of sqlname field
    sqlname: array [0..METADATALENGTH_V2 - 1] of ISC_SCHAR;  // name of field, name length + space  for NULL
    relname_length: Smallint;                                // length of relation name
    relname: array [0..METADATALENGTH_V2 - 1] of ISC_SCHAR;  // field's relation name + space for NULL
    ownname_length: Smallint;                                // length of owner name
    ownname: array [0..METADATALENGTH_V2 - 1] of ISC_SCHAR;  // relation's owner name + space for  NULL
    aliasname_length: Smallint;                              // length of alias name
    aliasname: array [0..METADATALENGTH_V2 - 1] of ISC_SCHAR;// relation's alias name + space for NULL
  end;

  PXSQLDA_V2 = ^XSQLDA_V2;
  XSQLDA_V2 = record
    version: Smallint;                                // version of this XSQLDA
    sqldaid: array [0..7] of ISC_SCHAR;               // XSQLDA name field          ->  RESERVED
    sqldabc: ISC_LONG;                                // length in bytes of SQLDA   ->  RESERVED
    sqln: Smallint;                                   // number of fields allocated
    sqld: Smallint;                                   // actual number of fields
    sqlvar: array [0..0] of XSQLVAR_V2;               // first field address
  end;

  PXSQLDA = Pointer;
  PXSQLVar = Pointer;

function XSQLDA_LENGTH_V1(n: Integer): Integer;
function XSQLDA_LENGTH_V2(n: Integer): Integer;
function XSQLVAR_LENGTH(num_rows, num_vars: Integer): Integer;

const
  SQLDA_VERSION1 = 1;
  SQLDA_VERSION2 = 2;             // IB7 and higher

  SQL_DIALECT_V5 = 1;             // meaning is same as DIALECT_xsqlda.
  SQL_DIALECT_V6_TRANSITION = 2;  // flagging anything that is delimited
                                  // by double quotes as an error and
                                  // flagging keyword DATE as an error
  SQL_DIALECT_V6 = 3;             // supports SQL delimited identifier,
                                  // SQLDATE/DATE, TIME, TIMESTAMP,
                                  // CURRENT_DATE, CURRENT_TIME,
                                  // CURRENT_TIMESTAMP, and 64-bit exact
                                  // numeric type

  SQLIND_NULL   = 1 shl 15;       // IB XE7
  SQLIND_INSERT = 1 shl 0;
  SQLIND_UPDATE = 1 shl 1;
  SQLIND_DELETE = 1 shl 2;
  SQLIND_CHANGE = 1 shl 3;
  SQLIND_CHANGE_VIEW = 1 shl 5;

  // ---------------------------------------------------------------------------
  // InterBase Handle Definitions
  // ---------------------------------------------------------------------------
type
  isc_att_handle = api_handle_t;
  Pisc_att_handle = ^isc_att_handle;

  isc_blob_handle = api_handle_t;
  Pisc_blob_handle = ^isc_blob_handle;

  isc_db_handle = api_handle_t;
  Pisc_db_handle = ^isc_db_handle;

  isc_form_handle = api_handle_t;
  Pisc_form_handle = ^isc_form_handle;

  isc_req_handle = api_handle_t;
  Pisc_req_handle = ^isc_req_handle;

  isc_stmt_handle = api_handle_t;
  Pisc_stmt_handle = ^isc_stmt_handle;

  isc_svc_handle = api_handle_t;
  Pisc_svc_handle = ^isc_svc_handle;

  isc_tr_handle = api_handle_t;
  Pisc_tr_handle = ^isc_tr_handle;

  isc_callback = procedure;

  isc_resv_handle = ISC_LONG;
  Pisc_resv_handle = ^isc_resv_handle;

  // ---------------------------------------------------------------------------
  // OSRI database functions
  // ---------------------------------------------------------------------------
type
  // Parameter for transaction on multiple Database, see
  PISCTEB = ^TISCTEB;
  TISCTEB = record
    Handle: Pisc_db_handle;
    Len: Integer;
    Address: PByte;
  end;

  // ---------------------------------------------------------------------------
  // Security Functions and structures
  // ---------------------------------------------------------------------------
const
  sec_uid_spec = $01;
  sec_gid_spec = $02;
  sec_server_spec = $04;
  sec_password_spec = $08;
  sec_group_name_spec = $10;
  sec_first_name_spec = $20;
  sec_middle_name_spec = $40;
  sec_last_name_spec = $80;
  sec_dba_user_name_spec = $100;
  sec_dba_password_spec = $200;

  sec_protocol_tcpip = 1;
  sec_protocol_netbeui = 2;
  sec_protocol_spx = 3;
  sec_protocol_local = 4;

type
  USER_SEC_DATA = record
    sec_flags: Smallint;      // which fields are specified
    uid: Integer;             // the user's id
    gid: Integer;             // the user's group id
    protocol: Integer;        // protocol to use for connection
    server: PISC_SCHAR;        // server to administer
    user_name: PISC_SCHAR;     // the user's name
    password: PISC_SCHAR;      // the user's password
    group_name: PISC_SCHAR;    // the group name
    first_name: PISC_SCHAR;    // the user's first name
    middle_name: PISC_SCHAR;   // the user's middle name
    last_name: PISC_SCHAR;     // the user's last name
    dba_user_name: PISC_SCHAR; // the dba user name
    dba_password: PISC_SCHAR;  // the dba password
  end;
  PUSER_SEC_DATA = ^USER_SEC_DATA;

  // ---------------------------------------------------------------------------
  // Service manager functions
  // ---------------------------------------------------------------------------
procedure ADD_SPB_LENGTH(var p: PISC_UCHAR; length: Integer);
procedure ADD_SPB_NUMERIC(var p: PISC_UCHAR; data: Integer);

  // ---------------------------------------------------------------------------
  // Actions to pass to the blob filter (ctl_source)
  // ---------------------------------------------------------------------------
const
  isc_blob_filter_open = 0;
  isc_blob_filter_get_segment = 1;
  isc_blob_filter_close = 2;
  isc_blob_filter_create = 3;
  isc_blob_filter_put_segment = 4;
  isc_blob_filter_alloc = 5;
  isc_blob_filter_free = 6;
  isc_blob_filter_seek = 7;

  // ---------------------------------------------------------------------------
  // Blr definitions
  // ---------------------------------------------------------------------------
  blr_text = 14;
  blr_text2 = 15;
  blr_short = 7;
  blr_long = 8;
  blr_quad = 9;
  blr_int64 = 16;
  blr_float = 10;
  blr_double = 27;
  blr_d_float = 11;
  blr_timestamp = 35;
  blr_varying = 37;
  blr_varying2 = 38;
  blr_blob = 261;
  blr_cstring = 40;
  blr_cstring2 = 41;
  blr_blob_id = 45;
  blr_sql_date = 12;
  blr_sql_time = 13;
  
  // Interbase
  blr_boolean_dtype_ib = 17;

  // Firebird
  blr_blob2 = 17;
  blr_domain_name = 18;
  blr_domain_name2 = 19;
  blr_not_nullable = 20;
  blr_column_name = 21;
  blr_column_name2 = 22;
  blr_bool_fb = 23;

  // Historical alias for pre V6 applications
  blr_date = blr_timestamp;

  blr_inner = 0;
  blr_left = 1;
  blr_right = 2;
  blr_full = 3;

  blr_gds_code = 0;
  blr_sql_code = 1;
  blr_exception = 2;
  blr_trigger_code = 3;
  blr_default_code = 4;
  blr_raise = 5;
  blr_exception_msg = 6;
  blr_exception_params = 7;

  blr_version4 = 4;
  blr_version5 = 5;
  blr_eoc = 76;
  blr_end = 255;        // note: defined as -1 in gds.h

  blr_assignment = 1;
  blr_begin = 2;
  blr_dcl_variable = 3; // added from gds.h
  blr_message = 4;
  blr_erase = 5;
  blr_fetch = 6;
  blr_for = 7;
  blr_if = 8;
  blr_loop = 9;
  blr_modify = 10;
  blr_handler = 11;
  blr_receive = 12;
  blr_select = 13;
  blr_send = 14;
  blr_store = 15;
  blr_label = 17;
  blr_leave = 18;
  blr_store2 = 19;
  blr_post = 20;
  blr_literal = 21;
  blr_dbkey = 22;
  blr_field = 23;
  blr_fid = 24;
  blr_parameter = 25;
  blr_variable = 26;
  blr_average = 27;
  blr_count = 28;
  blr_maximum = 29;
  blr_minimum = 30;
  blr_total = 31;

  // count 2
  // define blr_count2  32
  blr_add = 34;
  blr_subtract = 35;
  blr_multiply = 36;
  blr_divide = 37;
  blr_negate = 38;
  blr_concatenate = 39;
  blr_substring = 40;
  blr_parameter2 = 41;
  blr_from = 42;
  blr_via = 43;
  blr_parameter2_old = 44;  // Confusion
  blr_user_name = 44;       // added from gds.h
  blr_null = 45;

  blr_equiv	= 46;
  blr_eql = 47;
  blr_neq = 48;
  blr_gtr = 49;
  blr_geq = 50;
  blr_lss = 51;
  blr_leq = 52;
  blr_containing = 53;
  blr_matching = 54;
  blr_starting = 55;
  blr_between = 56;
  blr_or = 57;
  blr_and = 58;
  blr_not = 59;
  blr_any = 60;
  blr_missing = 61;
  blr_unique = 62;
  blr_like = 63;

  blr_stream = 65;    // added from gds.h
  blr_set_index = 66; // added from gds.h

  blr_rse = 67;
  blr_first = 68;
  blr_project = 69;
  blr_sort = 70;
  blr_boolean = 71;
  blr_ascending = 72;
  blr_descending = 73;
  blr_relation = 74;
  blr_rid = 75;
  blr_union = 76;
  blr_map = 77;
  blr_group_by = 78;
  blr_aggregate = 79;
  blr_join_type = 80;

  blr_rows = 81;
  // sub parameters for blr_rows
  blr_ties = 0;
  blr_percent = 1;

  blr_agg_count = 83;
  blr_agg_max = 84;
  blr_agg_min = 85;
  blr_agg_total = 86;
  blr_agg_average = 87;
  blr_parameter3 = 88; // same as Rdb definition
  blr_run_max = 89;
  blr_run_min = 90;
  blr_run_total = 91;
  blr_run_average = 92;
  blr_agg_count2 = 93;
  blr_agg_count_distinct = 94;
  blr_agg_total_distinct = 95;
  blr_agg_average_distinct = 96;

  blr_function = 100;
  blr_gen_id = 101;
  blr_prot_mask = 102;
  blr_upcase = 103;
  blr_lock_state = 104;
  blr_value_if = 105;
  blr_matching2 = 106;
  blr_index = 107;
  blr_ansi_like = 108;
  blr_bookmark = 109;
  blr_crack = 110;
  blr_force_crack = 111;
  blr_seek = 112;
  blr_find = 113;
  blr_scrollable = 109;

  // these indicate directions for blr_seek and blr_find

  blr_continue = 0;
  blr_forward = 1;
  blr_backward = 2;
  blr_bof_forward = 3;
  blr_eof_backward = 4;

  blr_lock_relation = 114;
  blr_lock_record = 115;
  blr_set_bookmark = 116;
  blr_get_bookmark = 117;

  blr_run_count = 118; // changed from 88 to avoid conflict with blr_parameter3
  blr_rs_stream = 119;
  blr_exec_proc = 120;
  blr_begin_range = 121;
  blr_end_range = 122;
  blr_delete_range = 123;
  blr_procedure = 124;
  blr_pid = 125;
  blr_exec_pid = 126;
  blr_singular = 127;
  blr_abort = 128;
  blr_block = 129;
  blr_error_handler = 130;

  blr_cast = 131;
  blr_release_lock = 132;
  blr_release_locks = 133;
  blr_start_savepoint = 134;
  blr_end_savepoint = 135;
  blr_find_dbkey = 136;
  blr_range_relation = 137;
  blr_delete_ranges = 138;
  blr_pid2 = 132;
  blr_procedure2 = 133;

  blr_plan = 139; // access plan items
  blr_merge = 140;
  blr_join = 141;
  blr_sequential = 142;
  blr_navigational = 143;
  blr_indices = 144;
  blr_retrieve = 145;

  blr_relation2 = 146;
  blr_rid2 = 147;
  blr_reset_stream = 148;
  blr_release_bookmark = 149;

  blr_set_generator = 150;

  blr_ansi_any = 151;       // required for NULL handling
  blr_exists = 152;         // required for NULL handling
  blr_cardinality = 153;

  blr_record_version = 154; // get tid of record
  blr_stall = 155;          // fake server stall

  blr_seek_no_warn = 156;
  blr_find_dbkey_version = 157; // find dbkey with record version
  blr_ansi_all = 158;           // required for NULL handling

  blr_extract = 159;

  // sub parameters for blr_extract

  blr_extract_year = 0;
  blr_extract_month = 1;
  blr_extract_day = 2;
  blr_extract_hour = 3;
  blr_extract_minute = 4;
  blr_extract_second = 5;
  blr_extract_weekday = 6;
  blr_extract_yearday = 7;

  blr_current_date = 160;
  blr_current_timestamp = 161;
  blr_current_time = 162;

  // FB1 specific BLR
  blr_current_role = 174;
  blr_skip = 175;

  // These verbs were added in 7.0 for BOOLEAN dtype support
  blr_boolean_true = 174;
  blr_boolean_false = 175;

  // These verbs were added in 7.1 for SQL savepoint support
  blr_start_savepoint2 = 176;
  blr_release_savepoint = 177;
  blr_rollback_savepoint = 178;

  // FB 1.5 specific BLR
  blr_exec_sql = 176;
  blr_internal_info = 177;
  blr_nullsfirst = 178;
  blr_writelock = 179;
  blr_nullslast = 180;
  // This codes reuse BLR code space
  blr_post_arg = 163;
  blr_exec_into	= 164;
  blr_user_savepoint = 165;

  // FB 2.0 specific BLR
  blr_lowcase = 181;
  blr_strlen = 182;

  blr_strlen_bit = 0;
  blr_strlen_char = 1;
  blr_strlen_octet = 2;

  blr_trim = 183;

  blr_trim_both = 0;
  blr_trim_leading = 1;
  blr_trim_trailing = 2;

  blr_trim_spaces = 0;
  blr_trim_characters = 1;

  blr_dcl_cursor = 166;
  blr_cursor_stmt	=	167;
  blr_current_timestamp2 = 168;
  blr_current_time2 = 169;
  blr_agg_list = 170;
  blr_agg_list_distinct = 171;
  blr_modify2 = 172;

  // These codes are actions for user-defined savepoints
  // FB 1.5 specific
  blr_savepoint_set = 0;
  blr_savepoint_release = 1;
  blr_savepoint_undo = 2;
  blr_savepoint_release_single = 3;

  // FB 2.0 specific
  blr_cursor_open	 = 0;
  blr_cursor_close = 1;
  blr_cursor_fetch = 2;
  blr_cursor_fetch_scroll = 3;

  // scroll options
  blr_scroll_forward = 0;
  blr_scroll_backward = 1;
  blr_scroll_bof = 2;
  blr_scroll_eof = 3;
  blr_scroll_absolute = 4;
  blr_scroll_relative = 5;

  // FB 3.0 specific BLR
  blr_procedure3 = 192;
  blr_exec_proc2 = 193;
  blr_function2 = 194;
  blr_window = 195;
  blr_partition_by = 196;
  blr_continue_loop = 197;
  blr_procedure4 = 198;
  blr_agg_function = 199;
  blr_substring_similar = 200;
  blr_bool_as_value = 201;
  blr_coalesce = 202;
  blr_decode = 203;

  // ---------------------------------------------------------------------------
  // Database parameter block stuff
  // ---------------------------------------------------------------------------
  isc_dpb_version1 = 1;
  isc_dpb_version2 = 2;

  isc_dpb_cdd_pathname = 1;
  isc_dpb_allocation = 2;
  isc_dpb_journal = 3;
  isc_dpb_page_size = 4;
  isc_dpb_num_buffers = 5;
  isc_dpb_buffer_length = 6;
  isc_dpb_debug = 7;
  isc_dpb_garbage_collect = 8;
  isc_dpb_verify = 9;
  isc_dpb_sweep = 10;
  isc_dpb_enable_journal = 11;
  isc_dpb_disable_journal = 12;
  isc_dpb_dbkey_scope = 13;
  isc_dpb_number_of_users = 14;
  isc_dpb_trace = 15;
  isc_dpb_no_garbage_collect = 16;
  isc_dpb_damaged = 17;
  isc_dpb_license = 18;
  isc_dpb_sys_user_name = 19;
  isc_dpb_encrypt_key = 20;
  isc_dpb_activate_shadow = 21;
  isc_dpb_sweep_interval = 22;
  isc_dpb_delete_shadow = 23;
  isc_dpb_force_write = 24;
  isc_dpb_begin_log = 25;
  isc_dpb_quit_log = 26;
  isc_dpb_no_reserve = 27;
  isc_dpb_user_name = 28;
  isc_dpb_password = 29;
  isc_dpb_password_enc = 30;
  isc_dpb_sys_user_name_enc = 31;
  isc_dpb_interp = 32;
  isc_dpb_online_dump = 33;
  isc_dpb_old_file_size = 34;
  isc_dpb_old_num_files = 35;
  isc_dpb_old_file = 36;
  isc_dpb_old_start_page = 37;
  isc_dpb_old_start_seqno = 38;
  isc_dpb_old_start_file = 39;
  isc_dpb_drop_walfile = 40;
  isc_dpb_old_dump_id = 41;
  isc_dpb_wal_backup_dir = 42;
  isc_dpb_wal_chkptlen = 43;
  isc_dpb_wal_numbufs = 44;
  isc_dpb_wal_bufsize = 45;
  isc_dpb_wal_grp_cmt_wait = 46;
  isc_dpb_lc_messages = 47;
  isc_dpb_lc_ctype = 48;
  isc_dpb_cache_manager = 49;
  isc_dpb_shutdown = 50;
  isc_dpb_online = 51;
  isc_dpb_shutdown_delay = 52;
  isc_dpb_reserved = 53;
  isc_dpb_overwrite = 54;
  isc_dpb_sec_attach = 55;
  isc_dpb_disable_wal = 56;
  isc_dpb_connect_timeout = 57;
  isc_dpb_dummy_packet_interval = 58;
  isc_dpb_gbak_attach = 59;
  isc_dpb_sql_role_name = 60;
  isc_dpb_set_page_buffers = 61;
  isc_dpb_working_directory = 62;
  isc_dpb_sql_dialect = 63;
  isc_dpb_set_db_readonly = 64;
  isc_dpb_set_db_sql_dialect = 65;
  isc_dpb_gfix_attach = 66;
  isc_dpb_gstat_attach = 67;

  // IB65 or YF867
  isc_dpb_gbak_ods_version = 68;
  isc_dpb_gbak_ods_minor_version = 69;

  // YF867
  isc_dpb_numeric_scale_reduction = 70;
  isc_dpb_sec_flags = 91;
  isc_dpb_sec_type = 92;
  isc_dpb_sec_principal = 93;
  isc_dpb_sec_srv_name = 94;

  // IB70
  isc_dpb_set_group_commit = 70;

  // IB71
  isc_dpb_gbak_validate = 71;

  // IB75
  isc_dpb_client_interbase_var	 = 72;
  isc_dpb_admin_option           = 73;
  isc_dpb_flush_interval         = 74;

  // IB2007
  isc_dpb_instance_name	  	     = 75;
  isc_dpb_old_overwrite          = 76;
  isc_dpb_archive_database       = 77;
  isc_dpb_archive_journals       = 78;
  isc_dpb_archive_sweep          = 79;
  isc_dpb_archive_dumps          = 80;
  isc_dpb_archive_recover        = 81;
  isc_dpb_recover_until          = 82;
  isc_dpb_force                  = 83;

  // IBXE
  isc_dpb_preallocate            = 84;
  isc_dpb_sys_encrypt_password   = 85;

  // IBXE3
  isc_dpb_eua_user_name          = 86;

  // IBXE7
  isc_dpb_transaction            = 87; // accepts up to int64 type value

  // FB103
  isc_dpb_set_db_charset = 68;

  // FB20
  isc_dpb_gsec_attach = 69;
  isc_dpb_address_path = 70;

  // FB21
  isc_dpb_process_id     = 71;
  isc_dpb_no_db_triggers = 72;
  isc_dpb_trusted_auth   = 73;
  isc_dpb_process_name   = 74;

  // FB25
  isc_dpb_trusted_role   = 75;
  isc_dpb_org_filename   = 76;
  isc_dpb_utf8_filename  = 77;
  isc_dpb_ext_call_depth = 78;

  // FB30
  isc_dpb_auth_block     = 79;

  isc_dpb_Max_Value_IB650 = 69;
  isc_dpb_Max_Value_IB700 = 70;
  isc_dpb_Max_Value_IB710 = 71;
  isc_dpb_Max_Value_IB750 = 74;
  isc_dpb_Max_Value_IB2007 = 83;
  isc_dpb_Max_Value_IBXE = 85;
  isc_dpb_Max_Value_IBXE3 = 86;
  isc_dpb_Max_Value_FB103 = 68;
  isc_dpb_Max_Value_FB150 = 68;
  isc_dpb_Max_Value_FB200 = 70;
  isc_dpb_Max_Value_FB210 = 74;
  isc_dpb_Max_Value_FB250 = 78;
  isc_dpb_Max_Value_FB300 = 79;
  isc_dpb_Max_Value_YF867 = 70;

  // ---------------------------------------------------------------------------
  // clumplet tags used inside isc_dpb_address_path
  // ---------------------------------------------------------------------------

(* Format of this clumplet is the following:

 <address-path-clumplet> ::=
	isc_dpb_address_path <byte-clumplet-length> <address-stack>

 <address-stack> ::=
	<address-descriptor> |
	<address-stack> <address-descriptor>

 <address-descriptor> ::=
	isc_dpb_address <byte-clumplet-length> <address-elements>

 <address-elements> ::=
	<address-element> |
	<address-elements> <address-element>

 <address-element> ::=
	isc_dpb_addr_protocol <byte-clumplet-length> <protocol-string> |
	isc_dpb_addr_endpoint <byte-clumplet-length> <remote-endpoint-string>

 <protocol-string> ::=
	"TCPv4" |
	"TCPv6" |
	"XNET" |
	"WNET" |
	....

 <remote-endpoint-string> ::=
	<IPv4-address> | // such as "172.20.1.1"
	<IPv6-address> | // such as "2001:0:13FF:09FF::1"
	<xnet-process-id> | // such as "17864"
	...
*)
  isc_dpb_address = 1;

  isc_dpb_addr_protocol = 1;
  isc_dpb_addr_endpoint = 2;

  // ---------------------------------------------------------------------------
  // isc_dpb_verify specific flags
  // ---------------------------------------------------------------------------
  isc_dpb_pages = 1;
  isc_dpb_records = 2;
  isc_dpb_indices = 4;
  isc_dpb_transactions = 8;
  isc_dpb_no_update = 16;
  isc_dpb_repair = 32;
  isc_dpb_ignore = 64;

  // ---------------------------------------------------------------------------
  // isc_dpb_shutdown specific flags
  // ---------------------------------------------------------------------------
  isc_dpb_shut_cache        = $1;
  isc_dpb_shut_attachment   = $2;
  isc_dpb_shut_transaction  = $4;
  isc_dpb_shut_force        = $8;
  // FB20
  isc_dpb_shut_mode_mask    = $70;
  isc_dpb_shut_default      = $00;
  isc_dpb_shut_normal       = $10;
  isc_dpb_shut_multi        = $20;
  isc_dpb_shut_single       = $30;
  isc_dpb_shut_full         = $40;

  // YF867
  // ---------------------------------------------------------------------------
  // isc_dpb_sec_flags specific flags
  // ---------------------------------------------------------------------------
  isc_dpb_sec_delegation = 1;
  isc_dpb_sec_mutual_auth = 2;
  isc_dpb_sec_replay = 4;
  isc_dpb_sec_sequence = 8;
  isc_dpb_sec_confidentiality = 16;
  isc_dpb_sec_integrity = 32;
  isc_dpb_sec_anonymous = 64;
  isc_dpb_sec_transport = $08000000; // use transport security if supported by underlying protocol

  // ---------------------------------------------------------------------------
  // Bit assignments in RDB$SYSTEM_FLAG
  // ---------------------------------------------------------------------------
  RDB_system = 1;
  RDB_id_assigned = 2;

  // ---------------------------------------------------------------------------
  // Transaction parameter block stuff
  // ---------------------------------------------------------------------------
  isc_tpb_version1 = 1;
  isc_tpb_version3 = 3;

  isc_tpb_consistency = 1;
  isc_tpb_concurrency = 2;
  isc_tpb_shared = 3;
  isc_tpb_protected = 4;
  isc_tpb_exclusive = 5;
  isc_tpb_wait = 6;
  isc_tpb_nowait = 7;
  isc_tpb_read = 8;
  isc_tpb_write = 9;
  isc_tpb_lock_read = 10;
  isc_tpb_lock_write = 11;
  isc_tpb_verb_time = 12;
  isc_tpb_commit_time = 13;
  isc_tpb_ignore_limbo = 14;
  isc_tpb_read_committed = 15;
  isc_tpb_autocommit = 16;
  isc_tpb_rec_version = 17;
  isc_tpb_no_rec_version = 18;
  isc_tpb_restart_requests = 19;
  isc_tpb_no_auto_undo = 20;
  // IB75
  isc_tpb_no_savepoint = 21;
  // FB20
  isc_tpb_lock_timeout = 21;

  // ---------------------------------------------------------------------------
  // Blob Parameter Block
  // ---------------------------------------------------------------------------
  isc_bpb_Max_Value = 6;

  isc_bpb_version1 = 1;
  isc_bpb_source_type = 1;
  isc_bpb_target_type = 2;
  isc_bpb_type = 3;
  isc_bpb_source_interp = 4;
  isc_bpb_target_interp = 5;
  isc_bpb_filter_parameter = 6;
  isc_bpb_target_relation_name = 7;
  isc_bpb_target_field_name = 8;

  isc_bpb_type_segmented = 0;
  isc_bpb_type_stream = 1;

  // ---------------------------------------------------------------------------
  // Service parameter block stuff
  // ---------------------------------------------------------------------------
  isc_spb_version1 = 1;
  isc_spb_version3 = 3;

  isc_spb_current_version = 2;
  isc_spb_version = isc_spb_current_version;
  isc_spb_user_name = isc_dpb_user_name;
  isc_spb_sys_user_name = isc_dpb_sys_user_name;
  isc_spb_sys_user_name_enc = isc_dpb_sys_user_name_enc;
  isc_spb_password = isc_dpb_password;
  isc_spb_password_enc = isc_dpb_password_enc;
  isc_spb_connect_timeout = isc_dpb_connect_timeout;
  isc_spb_dummy_packet_interval = isc_dpb_dummy_packet_interval;
  isc_spb_sql_role_name = isc_dpb_sql_role_name;
  isc_spb_instance_name = isc_dpb_instance_name;
  isc_spb_command_line = 105;
  isc_spb_dbname = 106;
  isc_spb_verbose = 107;
  isc_spb_options = 108;
  // IB75
  isc_spb_user_dbname = 109;
  isc_spb_auth_dbname = 110;
  // IBXE
  isc_spb_sys_encrypt_password = isc_dpb_sys_encrypt_password;
  // FB20
  isc_spb_address_path = 109;
  // FB25
  isc_spb_process_id = 110;
  isc_spb_trusted_auth = 111;
  isc_spb_process_name = 112;
  isc_spb_trusted_role = 113;
  // FB30
  isc_spb_verbint = 114;
  isc_spb_auth_block = 115;

  // ---------------------------------------------------------------------------
  // Information call declarations
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  // Common, structural codes
  // ---------------------------------------------------------------------------
  isc_info_end = 1;
  isc_info_truncated = 2;
  isc_info_error = 3;
  isc_info_data_not_ready = 4;
  isc_info_flag_end = 127;

  // ---------------------------------------------------------------------------
  // Database information items
  // ---------------------------------------------------------------------------
  isc_info_db_id = 4;
  isc_info_reads = 5;
  isc_info_writes = 6;
  isc_info_fetches = 7;
  isc_info_marks = 8;

  isc_info_implementation = 11;
  isc_info_isc_version = 12;
  isc_info_base_level = 13;

  // IB71
  isc_info_svr_maj_ver = isc_info_base_level;

  isc_info_page_size = 14;
  isc_info_num_buffers = 15;
  isc_info_limbo = 16;
  isc_info_current_memory = 17;
  isc_info_max_memory = 18;
  isc_info_window_turns = 19;
  isc_info_license = 20;

  isc_info_allocation = 21;
  isc_info_attachment_id = 22;
  isc_info_read_seq_count = 23;
  isc_info_read_idx_count = 24;
  isc_info_insert_count = 25;
  isc_info_update_count = 26;
  isc_info_delete_count = 27;
  isc_info_backout_count = 28;
  isc_info_purge_count = 29;
  isc_info_expunge_count = 30;

  isc_info_sweep_interval = 31;
  isc_info_ods_version = 32;
  isc_info_ods_minor_version = 33;
  isc_info_no_reserve = 34;
  isc_info_logfile = 35;
  isc_info_cur_logfile_name = 36;
  isc_info_cur_log_part_offset = 37;
  isc_info_num_wal_buffers = 38;
  isc_info_wal_buffer_size = 39;
  isc_info_wal_ckpt_length = 40;

  isc_info_wal_cur_ckpt_interval = 41;
  isc_info_wal_prv_ckpt_fname = 42;
  isc_info_wal_prv_ckpt_poffset = 43;
  isc_info_wal_recv_ckpt_fname = 44;
  isc_info_wal_recv_ckpt_poffset = 45;
  isc_info_wal_grpc_wait_usecs = 47;
  isc_info_wal_num_io = 48;
  isc_info_wal_avg_io_size = 49;
  isc_info_wal_num_commits = 50;

  isc_info_wal_avg_grpc_size = 51;
  isc_info_forced_writes = 52;
  isc_info_user_names = 53;
  isc_info_page_errors = 54;
  isc_info_record_errors = 55;
  isc_info_bpage_errors = 56;
  isc_info_dpage_errors = 57;
  isc_info_ipage_errors = 58;
  isc_info_ppage_errors = 59;
  isc_info_tpage_errors = 60;

  isc_info_set_page_buffers = 61;
  isc_info_db_sql_dialect = 62;
  isc_info_db_read_only = 63;
  isc_info_db_size_in_pages = 64;

  // IB70
  isc_info_db_reads = 65;
  isc_info_db_writes = 66;
  isc_info_db_fetches = 67;
  isc_info_db_marks = 68;
  isc_info_db_group_commit = 69;

  // IB71
  isc_info_att_charset = 70;
  isc_info_svr_min_ver = 71;

  // IB75
  isc_info_ib_env_var      = 72;
  isc_info_server_tcp_port = 73;

  // IBXE
  isc_info_db_preallocate  = 74;
  isc_info_db_encrypted    = 75;
  isc_info_db_encryptions  = 76;
  isc_info_db_sep_external = 77;

  // IBXE3
  isc_info_db_eua_active = 78;

  // FB102 OR YF867
  frb_info_att_charset = 101;
  isc_info_db_class = 102;
  isc_info_firebird_version = 103;
  isc_info_oldest_transaction = 104;
  isc_info_oldest_active = 105;
  isc_info_oldest_snapshot = 106;
  isc_info_next_transaction = 107;
  isc_info_db_provider = 108;
  isc_info_active_transactions = 109;

  // FB20
  isc_info_active_tran_count = 110;
	isc_info_creation_date = 111;
	isc_info_db_file_size = 112;
	fb_info_page_contents = 113;

  // FB30
	fb_info_implementation = 114;

  isc_info_version = isc_info_isc_version;

  // ---------------------------------------------------------------------------
  // Database information return values
  // ---------------------------------------------------------------------------
  isc_info_db_impl_rdb_vms = 1;
  isc_info_db_impl_rdb_eln = 2;
  isc_info_db_impl_rdb_eln_dev = 3;
  isc_info_db_impl_rdb_vms_y = 4;
  isc_info_db_impl_rdb_eln_y = 5;
  isc_info_db_impl_jri = 6;
  isc_info_db_impl_jsv = 7;

  isc_info_db_impl_isc_apl_68K = 25;
  isc_info_db_impl_isc_vax_ultr = 26;
  isc_info_db_impl_isc_vms = 27;
  isc_info_db_impl_isc_sun_68k = 28;
  isc_info_db_impl_isc_os2 = 29;
  isc_info_db_impl_isc_sun4 = 30;

  isc_info_db_impl_isc_hp_ux = 31;
  isc_info_db_impl_isc_sun_386i = 32;
  isc_info_db_impl_isc_vms_orcl = 33;
  isc_info_db_impl_isc_mac_aux = 34;
  isc_info_db_impl_isc_rt_aix = 35;
  isc_info_db_impl_isc_mips_ult = 36;
  isc_info_db_impl_isc_xenix = 37;
  isc_info_db_impl_isc_dg = 38;
  isc_info_db_impl_isc_hp_mpexl = 39;
  isc_info_db_impl_isc_hp_ux68K = 40;

  isc_info_db_impl_isc_sgi = 41;
  isc_info_db_impl_isc_sco_unix = 42;
  isc_info_db_impl_isc_cray = 43;
  isc_info_db_impl_isc_imp = 44;
  isc_info_db_impl_isc_delta = 45;
  isc_info_db_impl_isc_next = 46;
  isc_info_db_impl_isc_dos = 47;
  // IB65
  isc_info_db_impl_isc_winnt = 48;
  isc_info_db_impl_isc_epson_IB65 = 49;

  // FB102 OR YF867
  isc_info_db_impl_m88K = 48;
  isc_info_db_impl_unixware = 49;
  isc_info_db_impl_isc_winnt_x86 = 50;
  isc_info_db_impl_isc_epson_FB102 = 51;
  isc_info_db_impl_alpha_osf = 52;
  isc_info_db_impl_alpha_vms = 53;
  isc_info_db_impl_netware_386 = 54;
  isc_info_db_impl_win_only = 55;
  isc_info_db_impl_ncr_3000 = 56;
  isc_info_db_impl_winnt_ppc = 57;
  isc_info_db_impl_dg_x86 = 58;
  isc_info_db_impl_sco_ev = 59;
  isc_info_db_impl_i386 = 60;
  isc_info_db_impl_freebsd = 61;
  isc_info_db_impl_netbsd = 62;
  isc_info_db_impl_darwin = 63;

  // FB102
  isc_info_db_impl_sinixz = 64;

  // FB15
  isc_info_db_impl_linux_sparc = 65;
  isc_info_db_impl_linux_amd64 = 66; // FB151

  // FB20
  isc_info_db_impl_freebsd_amd64 = 67;

  isc_info_db_impl_winnt_amd64 = 68;

  isc_info_db_impl_linux_ppc = 69;
  isc_info_db_impl_darwin_x86 = 70;
  isc_info_db_impl_linux_mipsel = 71;
  isc_info_db_impl_linux_mips = 72;
  isc_info_db_impl_darwin_x64 = 73;
  isc_info_db_impl_sun_amd64 = 74;

  isc_info_db_impl_linux_arm = 75;
  isc_info_db_impl_linux_ia64 = 76;

  isc_info_db_impl_darwin_ppc64 = 77;
  isc_info_db_impl_linux_s390x = 78;
  isc_info_db_impl_linux_s390 = 79;

  isc_info_db_impl_linux_sh = 80;
  isc_info_db_impl_linux_sheb = 81;

  isc_info_db_impl_isc_a = isc_info_db_impl_isc_apl_68K;
  isc_info_db_impl_isc_u = isc_info_db_impl_isc_vax_ultr;
  isc_info_db_impl_isc_v = isc_info_db_impl_isc_vms;
  isc_info_db_impl_isc_s = isc_info_db_impl_isc_sun_68k;

  isc_info_db_class_access = 1;
  isc_info_db_class_y_valve = 2;
  isc_info_db_class_rem_int = 3;
  isc_info_db_class_rem_srvr = 4;
  isc_info_db_class_pipe_int = 7;
  isc_info_db_class_pipe_srvr = 8;
  isc_info_db_class_sam_int = 9;
  isc_info_db_class_sam_srvr = 10;
  isc_info_db_class_gateway = 11;
  isc_info_db_class_cache = 12;
  // FB 102 OR YF867
  isc_info_db_class_classic_access = 13;
  isc_info_db_class_server_access = 14;

  // FB102 OR YF867
  isc_info_db_code_rdb_eln = 1;
  isc_info_db_code_rdb_vms = 2;
  isc_info_db_code_interbase = 3;
  isc_info_db_code_firebird = 4;

  // ---------------------------------------------------------------------------
  // Request information items
  // ---------------------------------------------------------------------------
  isc_info_number_messages = 4;
  isc_info_max_message = 5;
  isc_info_max_send = 6;
  isc_info_max_receive = 7;
  isc_info_state = 8;
  isc_info_message_number = 9;
  isc_info_message_size = 10;
  isc_info_request_cost = 11;
  isc_info_access_path = 12;
  isc_info_req_select_count = 13;
  isc_info_req_insert_count = 14;
  isc_info_req_update_count = 15;
  isc_info_req_delete_count = 16;

  // ---------------------------------------------------------------------------
  // Access path items
  // ---------------------------------------------------------------------------
  isc_info_rsb_end = 0;
  isc_info_rsb_begin = 1;
  isc_info_rsb_type = 2;
  isc_info_rsb_relation = 3;
  isc_info_rsb_plan = 4;

  // ---------------------------------------------------------------------------
  // Rsb types
  // ---------------------------------------------------------------------------
  isc_info_rsb_unknown = 1;
  isc_info_rsb_indexed = 2;
  isc_info_rsb_navigate = 3;
  isc_info_rsb_sequential = 4;
  isc_info_rsb_cross = 5;
  isc_info_rsb_sort = 6;
  isc_info_rsb_first = 7;
  isc_info_rsb_boolean = 8;
  isc_info_rsb_union = 9;
  isc_info_rsb_aggregate = 10;
  isc_info_rsb_merge = 11;
  isc_info_rsb_ext_sequential = 12;
  isc_info_rsb_ext_indexed = 13;
  isc_info_rsb_ext_dbkey = 14;
  isc_info_rsb_left_cross = 15;
  isc_info_rsb_select = 16;
  isc_info_rsb_sql_join = 17;
  isc_info_rsb_simulate = 18;
  isc_info_rsb_sim_cross = 19;
  isc_info_rsb_once = 20;
  isc_info_rsb_procedure = 21;
  // FB20
  isc_info_rsb_skip = 22;
  // FB25
  isc_info_rsb_virt_sequential = 23;
  isc_info_rsb_recursive = 24;
  // FB30
  isc_info_rsb_window = 25;
  isc_info_rsb_singular = 26;
  isc_info_rsb_writelock = 27;
  isc_info_rsb_buffer = 28;
  isc_info_rsb_hash = 29;

  // ---------------------------------------------------------------------------
  // Bitmap expressions
  // ---------------------------------------------------------------------------
  isc_info_rsb_and = 1;
  isc_info_rsb_or = 2;
  isc_info_rsb_dbkey = 3;
  isc_info_rsb_index = 4;

  isc_info_req_active = 2;
  isc_info_req_inactive = 3;
  isc_info_req_send = 4;
  isc_info_req_receive = 5;
  isc_info_req_select = 6;
  isc_info_req_sql_stall = 7;

  // ---------------------------------------------------------------------------
  // Blob information items
  // ---------------------------------------------------------------------------
  isc_info_blob_num_segments = 4;
  isc_info_blob_max_segment = 5;
  isc_info_blob_total_length = 6;
  isc_info_blob_type = 7;

  // ---------------------------------------------------------------------------
  // Transaction information items
  // ---------------------------------------------------------------------------
  isc_info_tra_id = 4;
  // FB
  isc_info_tra_oldest_interesting = 5;
  isc_info_tra_oldest_snapshot = 6;
  isc_info_tra_oldest_active = 7;
  isc_info_tra_isolation = 8;
  isc_info_tra_access = 9;
  isc_info_tra_lock_timeout = 10;
  // FB30
  fb_info_tra_dbpath = 11;

  // ---------------------------------------------------------------------------
  // Service action items
  // ---------------------------------------------------------------------------
  isc_action_svc_backup = 1;           // Starts database backup process on the server
  isc_action_svc_restore = 2;          // Starts database restore process on the server
  isc_action_svc_repair = 3;           // Starts database repair process on the server
  isc_action_svc_add_user = 4;         // Adds a new user to the security database
  isc_action_svc_delete_user = 5;      // Deletes a user record from the security database
  isc_action_svc_modify_user = 6;      // Modifies a user record in the security database
  isc_action_svc_display_user = 7;     // Displays a user record from the security database
  isc_action_svc_properties = 8;       // Sets database properties
  isc_action_svc_add_license = 9;      // Adds a license to the license file
  isc_action_svc_remove_license = 10;  // Removes a license from the license file
  isc_action_svc_db_stats = 11;        // Retrieves database statistics
  isc_action_svc_get_ib_log = 12;      // Retrieves the InterBase log file from the server
  // IB75
  isc_action_svc_add_db_alias = 13;    // Adds a new database alias
  isc_action_svc_delete_db_alias = 14; // Deletes an existing database alias
  isc_action_svc_display_db_alias = 15;// Displays an existing database alias
  // IBXE3
  isc_action_svc_dump = 16;            // Starts database dump process on the server
  // FB20
  isc_action_svc_nbak = 20;            // Incremental nbackup
  isc_action_svc_nrest = 21;
  isc_action_svc_trace_start = 22;
  isc_action_svc_trace_stop = 23;
  isc_action_svc_trace_suspend = 24;
  isc_action_svc_trace_resume = 25;
  isc_action_svc_trace_list = 26;
  // FB25
  isc_action_svc_set_mapping = 27;
  isc_action_svc_drop_mapping = 28;

  // ---------------------------------------------------------------------------
  // Service information items
  // ---------------------------------------------------------------------------
  // Retrieves the number of attachments and databases
  isc_info_svc_svr_db_info = 50;
  // Retrieves all license keys and IDs from the license file
  isc_info_svc_get_license = 51;
  // Retrieves a bitmask representing licensed options on the server
  isc_info_svc_get_license_mask = 52;
  // Retrieves the parameters and values for IB_CONFIG
  isc_info_svc_get_config = 53;
  // Retrieves the version of the services manager
  isc_info_svc_version = 54;
  // Retrieves the version of the InterBase server
  isc_info_svc_server_version = 55;
  // Retrieves the implementation of the InterBase server
  isc_info_svc_implementation = 56;
  // Retrieves a bitmask representing the server's capabilities
  isc_info_svc_capabilities = 57;
  // Retrieves the path to the security database in use by the server
  isc_info_svc_user_dbpath = 58;
  // Retrieves the setting of $INTERBASE
  isc_info_svc_get_env = 59;
  // Retrieves the setting of $INTERBASE_LCK
  isc_info_svc_get_env_lock = 60;
  // Retrieves the setting of $INTERBASE_MSG
  isc_info_svc_get_env_msg = 61;
  // Retrieves 1 line of service output per call
  isc_info_svc_line = 62;
  // Retrieves as much of the server output as will fit in the supplied buffer
  isc_info_svc_to_eof = 63;
  // Sets / signifies a timeout value for reading service information
  isc_info_svc_timeout = 64;
  // Retrieves the number of users licensed for accessing the server
  isc_info_svc_get_licensed_users = 65;
  // Retrieve the limbo transactions
  isc_info_svc_limbo_trans = 66;
  // Checks to see if a service is running on an attachment
  isc_info_svc_running = 67;
  // Returns the user information from isc_action_svc_display_users
  isc_info_svc_get_users = 68;
  // Returns the database alias information from isc_action_svc_display_db_alias
  isc_info_svc_get_db_alias = 69;

  // IBXE3
  // Returns embedding application's product identifier, if present in license
  isc_info_svc_product_identifier = 70;

  // ---------------------------------------------------------------------------
  // Parameters for isc_action_{add|delete|modify)_user
  // ---------------------------------------------------------------------------
  isc_spb_sec_userid = 5;
  isc_spb_sec_groupid = 6;
  isc_spb_sec_username = 7;
  isc_spb_sec_password = 8;
  isc_spb_sec_groupname = 9;
  isc_spb_sec_firstname = 10;
  isc_spb_sec_middlename = 11;
  isc_spb_sec_lastname = 12;

  // ---------------------------------------------------------------------------
  // Parameters for isc_action_{add|delete|display)_db_alias
  // ---------------------------------------------------------------------------
  isc_spb_sec_db_alias_name = 20;
  isc_spb_sec_db_alias_dbpath = 21;

  // ---------------------------------------------------------------------------
  // Parameters for isc_action_svc_(add|remove)_license,
  // isc_info_svc_get_license
  // ---------------------------------------------------------------------------
  isc_spb_lic_key = 5;
  isc_spb_lic_id = 6;
  isc_spb_lic_desc = 7;

  // ---------------------------------------------------------------------------
  // Parameters for isc_action_svc_properties
  // ---------------------------------------------------------------------------
  isc_spb_prp_page_buffers = 5;
  isc_spb_prp_sweep_interval = 6;
  isc_spb_prp_shutdown_db = 7;
  isc_spb_prp_deny_new_attachments = 9;
  isc_spb_prp_deny_new_transactions = 10;
  isc_spb_prp_reserve_space = 11;
  isc_spb_prp_write_mode = 12;
  isc_spb_prp_access_mode = 13;
  isc_spb_prp_set_sql_dialect = 14;
  // IBXE7
  isc_spb_prp_archive_dumps = 42;
  isc_spb_prp_archive_sweep = 43;

  isc_spb_prp_activate = $0100;
  isc_spb_prp_db_online = $0200;

  // ---------------------------------------------------------------------------
  // Parameters for isc_spb_prp_reserve_space
  // ---------------------------------------------------------------------------
  isc_spb_prp_res_use_full = 35;
  isc_spb_prp_res = 36;

  // ---------------------------------------------------------------------------
  // Parameters for isc_spb_prp_write_mode
  // ---------------------------------------------------------------------------
  isc_spb_prp_wm_async = 37;
  isc_spb_prp_wm_sync = 38;
  isc_spb_prp_wm_direct = 41;

  // ---------------------------------------------------------------------------
  // Parameters for isc_spb_prp_access_mode
  // ---------------------------------------------------------------------------
  isc_spb_prp_am_readonly = 39;
  isc_spb_prp_am_readwrite = 40;

  // ---------------------------------------------------------------------------
  // Parameters for isc_action_svc_repair
  // ---------------------------------------------------------------------------
  isc_spb_rpr_commit_trans = 15;
  isc_spb_rpr_rollback_trans = 34;
  isc_spb_rpr_recover_two_phase = 17;
  isc_spb_tra_id = 18;
  isc_spb_single_tra_id = 19;
  isc_spb_multi_tra_id = 20;
  isc_spb_tra_state = 21;
  isc_spb_tra_state_limbo = 22;
  isc_spb_tra_state_commit = 23;
  isc_spb_tra_state_rollback = 24;
  isc_spb_tra_state_unknown = 25;
  isc_spb_tra_host_site = 26;
  isc_spb_tra_remote_site = 27;
  isc_spb_tra_db_path = 28;
  isc_spb_tra_advise = 29;
  isc_spb_tra_advise_commit = 30;
  isc_spb_tra_advise_rollback = 31;
  isc_spb_tra_advise_unknown = 33;

  isc_spb_rpr_validate_db = $01;
  isc_spb_rpr_sweep_db = $02;
  isc_spb_rpr_mend_db = $04;
  isc_spb_rpr_list_limbo_trans = $08;
  isc_spb_rpr_check_db = $10;
  isc_spb_rpr_ignore_checksum = $20;
  isc_spb_rpr_kill_shadows = $40;
  isc_spb_rpr_full = $80;

  // ---------------------------------------------------------------------------
  // Parameters for isc_action_svc_backup
  // ---------------------------------------------------------------------------
  isc_spb_bkp_file = 5;
  isc_spb_bkp_factor = 6;
  isc_spb_bkp_length = 7;
  // IB2009
  isc_spb_bkp_preallocate = 13;
  isc_spb_bkp_encrypt_name = 14;

  // flags
  isc_spb_bkp_ignore_checksums = $01;
  isc_spb_bkp_ignore_limbo = $02;
  isc_spb_bkp_metadata_only = $04;
  isc_spb_bkp_no_garbage_collect = $08;
  isc_spb_bkp_old_descriptions = $10;
  isc_spb_bkp_non_transportable = $20;
  isc_spb_bkp_convert = $40;
  isc_spb_bkp_expand = $80;
  // IBXE7
  // standalone options for Archive backup operation
  isc_spb_bkp_archive_database = $010000;
  isc_spb_bkp_archive_journals = $020000;

  // ---------------------------------------------------------------------------
  // FB20, Parameters for isc_action_svc_nbak
  // ---------------------------------------------------------------------------
  isc_spb_nbk_level = 5;
  isc_spb_nbk_file = 6;

  // Flags
  isc_spb_nbk_no_triggers = $01;

  // ---------------------------------------------------------------------------
  // Parameters for isc_action_svc_restore
  // ---------------------------------------------------------------------------
  isc_spb_res_buffers = 9;
  isc_spb_res_page_size = 10;
  isc_spb_res_length = 11;
  isc_spb_res_access_mode = 12;
  // FB25
  isc_spb_res_fix_fss_data = 13;
  isc_spb_res_fix_fss_metadata = 14;
  isc_spb_res_metadata_only = isc_spb_bkp_metadata_only;
  // IB2009
  isc_spb_res_decrypt_password = 16;
  isc_spb_res_eua_user_name = 17;
  // IBXE3
  isc_spb_res_eua_password = 18;
  isc_spb_res_write_mode = 19;
  isc_spb_res_starting_trans = 21; // requires 64bit integer value
  isc_spb_res_ods_version_major = 22;
  // IBXE7
  isc_spb_res_archive_recover_until = 23;

  isc_spb_res_deactivate_idx = $0100;
  isc_spb_res_no_shadow = $0200;
  isc_spb_res_no_validity = $0400;
  isc_spb_res_one_at_a_time = $0800;
  isc_spb_res_replace = $1000;
  isc_spb_res_create = $2000;
  isc_spb_res_use_all_space = $4000;
  // IB71
  isc_spb_res_validate = $8000;
  // IBXE7
  // standalone options for Archive recover operation
  isc_spb_res_archive_recover = $040000;

  // ---------------------------------------------------------------------------
  // Parameters for isc_action_svc_dump
  // ---------------------------------------------------------------------------
  isc_spb_dmp_file = isc_spb_bkp_file;
  isc_spb_dmp_length = isc_spb_bkp_length;
  isc_spb_dmp_overwrite = 20;
  // IBXE7
  // standalone options for dump operation
  isc_spb_dmp_create = $080000;

  // ---------------------------------------------------------------------------
  // Parameters for isc_spb_res_access_mode
  // ---------------------------------------------------------------------------
  isc_spb_res_am_readonly = isc_spb_prp_am_readonly;
  isc_spb_res_am_readwrite = isc_spb_prp_am_readwrite;

  // ---------------------------------------------------------------------------
  // Parameters for isc_spb_res_write_mode
  // ---------------------------------------------------------------------------
  isc_spb_res_wm_async = isc_spb_prp_wm_async;
  isc_spb_res_wm_sync	=	isc_spb_prp_wm_sync;
  isc_spb_res_wm_direct	=	isc_spb_prp_wm_direct;

  // ---------------------------------------------------------------------------
  // Parameters for isc_info_svc_svr_db_info
  // ---------------------------------------------------------------------------
  isc_spb_num_att = 5;
  isc_spb_num_db = 6;

  // ---------------------------------------------------------------------------
  // Parameters for isc_info_svc_db_stats
  // ---------------------------------------------------------------------------
  isc_spb_sts_data_pages = $01;
  isc_spb_sts_db_log = $02;
  isc_spb_sts_hdr_pages = $04;

  isc_spb_sts_idx_pages = $08;
  isc_spb_sts_sys_relations = $10;

  // IB70
  isc_spb_sts_record_versions_IB70 = $20;
  isc_spb_sts_table_IB70 = $40;

  // IB65 OR YF867
  isc_spb_sts_record_versions_IB65 = $12;
  isc_spb_sts_table_IB65 = $14;

  // FB15
  isc_spb_sts_record_versions_FB15 = $20;
  isc_spb_sts_table_FB15 = $40;

  // FB20
  isc_spb_sts_nocreation= $80;

  // ---------------------------------------------------------------------------
  // FB20, Parameters for isc_action_svc_trace_xxxx
  // ---------------------------------------------------------------------------
  isc_spb_trc_id = 1;
  isc_spb_trc_name = 2;
  isc_spb_trc_cfg = 3;

  // ---------------------------------------------------------------------------
  // SQL information items
  // ---------------------------------------------------------------------------
  isc_info_sql_select = 4;
  isc_info_sql_bind = 5;
  isc_info_sql_num_variables = 6;
  isc_info_sql_describe_vars = 7;
  isc_info_sql_describe_end = 8;
  isc_info_sql_sqlda_seq = 9;
  isc_info_sql_message_seq = 10;
  isc_info_sql_type = 11;
  isc_info_sql_sub_type = 12;
  isc_info_sql_scale = 13;
  isc_info_sql_length = 14;
  isc_info_sql_null_ind = 15;
  isc_info_sql_field = 16;
  isc_info_sql_relation = 17;
  isc_info_sql_owner = 18;
  isc_info_sql_alias = 19;
  isc_info_sql_sqlda_start = 20;
  isc_info_sql_stmt_type = 21;
  isc_info_sql_get_plan = 22;
  isc_info_sql_records = 23;
  isc_info_sql_batch_fetch = 24;

  // FB20
  isc_info_sql_relation_alias = 25;

  // IB71
  isc_info_sql_precision = 25;

  // FB30
  isc_info_sql_explain_plan = 26;

  // ---------------------------------------------------------------------------
  // SQL information return values
  // ---------------------------------------------------------------------------
  isc_info_sql_stmt_select = 1;
  isc_info_sql_stmt_insert = 2;
  isc_info_sql_stmt_update = 3;
  isc_info_sql_stmt_delete = 4;
  isc_info_sql_stmt_ddl = 5;
  isc_info_sql_stmt_get_segment = 6;
  isc_info_sql_stmt_put_segment = 7;
  isc_info_sql_stmt_exec_procedure = 8;
  isc_info_sql_stmt_start_trans = 9;
  isc_info_sql_stmt_commit = 10;
  isc_info_sql_stmt_rollback = 11;
  isc_info_sql_stmt_select_for_upd = 12;
  isc_info_sql_stmt_set_generator = 13;
  // FB15
  isc_info_sql_stmt_savepoint = 14;
  // IBXE3
  isc_info_sql_stmt_set_password = 14;
  // IBXE7
  isc_info_sql_stmt_set_subscription = 15;

  // ---------------------------------------------------------------------------
  // Server configuration key values
  // ---------------------------------------------------------------------------
  // NOT FOR FB15
  ISCCFG_LOCKMEM_KEY = 0;
  ISCCFG_LOCKSEM_KEY = 1;
  ISCCFG_LOCKSIG_KEY = 2;
  ISCCFG_EVNTMEM_KEY = 3;
  ISCCFG_DBCACHE_KEY = 4;
  ISCCFG_PRIORITY_KEY = 5;
  ISCCFG_IPCMAP_KEY = 6;
  ISCCFG_MEMMIN_KEY = 7;
  ISCCFG_MEMMAX_KEY = 8;
  ISCCFG_LOCKORDER_KEY = 9;
  ISCCFG_ANYLOCKMEM_KEY = 10;
  ISCCFG_ANYLOCKSEM_KEY = 11;
  ISCCFG_ANYLOCKSIG_KEY = 12;
  ISCCFG_ANYEVNTMEM_KEY = 13;
  ISCCFG_LOCKHASH_KEY = 14;
  ISCCFG_DEADLOCK_KEY = 15;
  ISCCFG_LOCKSPIN_KEY = 16;
  ISCCFG_CONN_TIMEOUT_KEY = 17;
  ISCCFG_DUMMY_INTRVL_KEY = 18;
  ISCCFG_TRACE_POOLS_KEY = 19; // Internal Use only
  ISCCFG_REMOTE_BUFFER_KEY = 20;

  // FB102
  ISCCFG_CPU_AFFINITY_KEY = 21;

  // IB65
  // ISCCFG_CPU_AFFINITY_KEY = 21;
  ISCCFG_SWEEP_QUANTUM_KEY = 22;
  ISCCFG_USER_QUANTUM_KEY = 23;
  ISCCFG_SLEEP_TIME_KEY = 24;

  // IB70
  ISCCFG_MAX_THREADS_KEY = 25;
  ISCCFG_ADMIN_DB_KEY = 26;

  // IB71
  ISCCFG_USE_SANCTUARY_KEY = 27;
  ISCCFG_ENABLE_HT_KEY = 28;

  // IB75
  ISCCFG_USE_ROUTER_KEY	= 29;
  ISCCFG_SORTMEM_BUFFER_SIZE_KEY	= 30;

  // IBXE3
  ISCCFG_SQL_CMP_RECURSION_KEY = 31;
  ISCCFG_SOL_BOUND_THREADS_KEY = 32;
  ISCCFG_SOL_SYNC_SCOPE_KEY = 33;
  ISCCFG_IDX_RECNUM_MARKER_KEY = 34;
  ISCCFG_IDX_GARBAGE_COLLECTION_KEY = 35;
  ISCCFG_WIN_LOCAL_CONNECT_RETRIES_KEY = 36;
  ISCCFG_EXPAND_MOUNTPOINT_KEY = 37;
  ISCCFG_LOOPBACK_CONNECTION_KEY = 38;
  ISCCFG_THREAD_STACK_SIZE_KEY = 39;
  ISCCFG_MAX_DB_VIRMEM_USE_KEY = 40;
  ISCCFG_MAX_ASSISTANTS_KEY = 41;
  ISCCFG_APPDATA_DIR_KEY = 42;
  ISCCFG_MEMORY_RECLAMATION_KEY = 43;
  ISCCFG_PAGE_CACHE_EXPANSION_KEY = 44;
  ISCCFG_STARTING_TRANSACTION_ID_KEY = 45;  // Used internally to test 64-bit transaction ID
  ISCCFG_DATABASE_ODS_VERSION_KEY = 46;	    // Used internally to test creating databases with older ODS versions

  // YF867
  // ISCCFG_CPU_AFFINITY_KEY = 21;
  // ISCCFG_SWEEP_QUANTUM_KEY = 22;
  // ISCCFG_USER_QUANTUM_KEY = 23;
  ISCCFG_REJECT_AMBIGUITY_KEY = 24;
  ISCCFG_SQZ_BLOCK_KEY = 25;
  ISCCFG_LOCK_TIMEOUT_KEY = 26;
  ISCCFG_YAFFIL_ODS_KEY = 27;
  ISCCFG_CONSTRAINT_INDEX_NAME_KEY = 28;
  ISCCFG_NO_NAGLE_KEY = 29;
  ISCCFG_WIN32_DISABLEFILECACHE_KEY = 30;
  ISCCFG_LOCKMEM_RES_KEY = 31;
  ISCCFG_FORCERESHEDULE_KEY = 32;
  ISCCFG_LEGACY_DIALECT1_KEY = 33;

  // ---------------------------------------------------------------------------
  // Dynamic Data Definition Language operators
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  // Version number
  // ---------------------------------------------------------------------------
  isc_dyn_version_1 = 1;
  isc_dyn_eoc = 255;

  // ---------------------------------------------------------------------------
  // Operations (may be nested)
  // ---------------------------------------------------------------------------
  isc_dyn_begin = 2;
  isc_dyn_end = 3;
  isc_dyn_if = 4;
  isc_dyn_def_database = 5;
  isc_dyn_def_global_fld = 6;
  isc_dyn_def_local_fld = 7;
  isc_dyn_def_idx = 8;
  isc_dyn_def_rel = 9;
  isc_dyn_def_sql_fld = 10;
  isc_dyn_def_view = 12;
  isc_dyn_def_trigger = 15;
  isc_dyn_def_security_class = 120;
  isc_dyn_def_dimension = 140;
  isc_dyn_def_generator = 24;
  isc_dyn_def_function = 25;
  isc_dyn_def_filter = 26;
  isc_dyn_def_function_arg = 27;
  isc_dyn_def_shadow = 34;
  isc_dyn_def_trigger_msg = 17;
  isc_dyn_def_file = 36;
  // IB75
  isc_dyn_def_user = 225;

  isc_dyn_mod_database = 39;
  isc_dyn_mod_rel = 11;
  isc_dyn_mod_global_fld = 13;
  isc_dyn_mod_idx = 102;
  isc_dyn_mod_local_fld = 14;
  isc_dyn_mod_sql_fld = 216;
  isc_dyn_mod_view = 16;
  isc_dyn_mod_security_class = 122;
  isc_dyn_mod_trigger = 113;
  isc_dyn_mod_trigger_msg = 28;
  // IB75
  isc_dyn_mod_user = 226;

  isc_dyn_delete_database = 18;
  isc_dyn_delete_rel = 19;
  isc_dyn_delete_global_fld = 20;
  isc_dyn_delete_local_fld = 21;
  isc_dyn_delete_idx = 22;
  isc_dyn_delete_security_class = 123;
  isc_dyn_delete_dimensions = 143;
  isc_dyn_delete_trigger = 23;
  isc_dyn_delete_trigger_msg = 29;
  isc_dyn_delete_filter = 32;
  isc_dyn_delete_function = 33;

  // ---------------------------------------------------------------------------
  // Generators again
  // ---------------------------------------------------------------------------
  // FB20 or IB71
  isc_dyn_delete_generator = 217;

  // FB20
  // New for comments in objects.
  isc_dyn_mod_function = 224;
  isc_dyn_mod_filter = 225;
  isc_dyn_mod_generator = 226;
  isc_dyn_mod_sql_role = 227;
  isc_dyn_mod_charset = 228;
  isc_dyn_mod_collation = 229;
  isc_dyn_mod_prc_parameter = 230;

  // ---------------------------------------------------------------------------
  // collation values
  // ---------------------------------------------------------------------------
  // FB20
  isc_dyn_def_collation	= 231;
  isc_dyn_coll_for_charset = 232;
  isc_dyn_coll_from =	233;
  isc_dyn_coll_attribute = 234;
  isc_dyn_coll_specific_attributes_charset = 235;
  isc_dyn_coll_specific_attributes = 236;
  isc_dyn_del_collation = 237;

  isc_dyn_delete_shadow = 35;
  // IB75
  isc_dyn_delete_user = 227;

  isc_dyn_grant = 30;
  isc_dyn_revoke = 31;
  isc_dyn_def_primary_key = 37;
  isc_dyn_def_foreign_key = 38;
  isc_dyn_def_unique = 40;
  isc_dyn_def_procedure = 164;
  isc_dyn_delete_procedure = 165;
  isc_dyn_def_parameter = 135;
  isc_dyn_delete_parameter = 136;
  isc_dyn_mod_procedure = 175;
  // not for FB20
  // deprecated
  isc_dyn_def_log_file = 176;
  isc_dyn_def_cache_file = 180;

  isc_dyn_def_exception = 181;
  isc_dyn_mod_exception = 182;
  isc_dyn_del_exception = 183;
  // not for FB20
  // deprecated
  isc_dyn_drop_log = 194;
  isc_dyn_drop_cache = 195;
  isc_dyn_def_default_log = 202;

  // FB20
  isc_dyn_def_difference = 220;
  isc_dyn_drop_difference = 221;
  isc_dyn_begin_backup = 222;
  isc_dyn_end_backup = 223;

  // ---------------------------------------------------------------------------
  // View specific stuff
  // ---------------------------------------------------------------------------
  isc_dyn_view_blr = 43;
  isc_dyn_view_source = 44;
  isc_dyn_view_relation = 45;
  isc_dyn_view_context = 46;
  isc_dyn_view_context_name = 47;

  // ---------------------------------------------------------------------------
  // Generic attributes
  // ---------------------------------------------------------------------------
  isc_dyn_rel_name = 50;
  isc_dyn_fld_name = 51;
  isc_dyn_new_fld_name = 215;
  isc_dyn_idx_name = 52;
  isc_dyn_description = 53;
  isc_dyn_security_class = 54;
  isc_dyn_system_flag = 55;
  isc_dyn_update_flag = 56;
  isc_dyn_prc_name = 166;
  isc_dyn_prm_name = 137;
  isc_dyn_sql_object = 196;
  isc_dyn_fld_character_set_name = 174;
  // IB75
  isc_dyn_restrict_or_cascade = 220;

  // ---------------------------------------------------------------------------
  // Relation specific attributes
  // ---------------------------------------------------------------------------
  isc_dyn_rel_dbkey_length = 61;
  isc_dyn_rel_store_trig = 62;
  isc_dyn_rel_modify_trig = 63;
  isc_dyn_rel_erase_trig = 64;
  isc_dyn_rel_store_trig_source = 65;
  isc_dyn_rel_modify_trig_source = 66;
  isc_dyn_rel_erase_trig_source = 67;
  isc_dyn_rel_ext_file = 68;
  isc_dyn_rel_sql_protection = 69;
  isc_dyn_rel_constraint = 162;
  isc_dyn_delete_rel_constraint = 163;
  // IB75
  isc_dyn_rel_sql_scope = 218;
  isc_dyn_rel_sql_on_commit = 219;

  // ---------------------------------------------------------------------------
  // Global field specific attributes
  // ---------------------------------------------------------------------------
  isc_dyn_fld_type = 70;
  isc_dyn_fld_length = 71;
  isc_dyn_fld_scale = 72;
  isc_dyn_fld_sub_type = 73;
  isc_dyn_fld_segment_length = 74;
  isc_dyn_fld_query_header = 75;
  isc_dyn_fld_edit_string = 76;
  isc_dyn_fld_validation_blr = 77;
  isc_dyn_fld_validation_source = 78;
  isc_dyn_fld_computed_blr = 79;
  isc_dyn_fld_computed_source = 80;
  isc_dyn_fld_missing_value = 81;
  isc_dyn_fld_default_value = 82;
  isc_dyn_fld_query_name = 83;
  isc_dyn_fld_dimensions = 84;
  isc_dyn_fld_not_null = 85;
  isc_dyn_fld_precision = 86;
  isc_dyn_fld_char_length = 172;
  isc_dyn_fld_collation = 173;
  isc_dyn_fld_default_source = 193;
  isc_dyn_del_default = 197;
  isc_dyn_del_validation = 198;
  isc_dyn_single_validation = 199;
  isc_dyn_fld_character_set = 203;

  // ---------------------------------------------------------------------------
  // Local field specific attributes
  // ---------------------------------------------------------------------------
  isc_dyn_fld_source = 90;
  isc_dyn_fld_base_fld = 91;
  isc_dyn_fld_position = 92;
  isc_dyn_fld_update_flag = 93;

  // ---------------------------------------------------------------------------
  // Index specific attributes
  // ---------------------------------------------------------------------------
  isc_dyn_idx_unique = 100;
  isc_dyn_idx_inactive = 101;
  isc_dyn_idx_type = 103;
  isc_dyn_idx_foreign_key = 104;
  isc_dyn_idx_ref_column = 105;
  isc_dyn_idx_statistic = 204;

  // ---------------------------------------------------------------------------
  // Trigger specific attributes
  // ---------------------------------------------------------------------------
  isc_dyn_trg_type = 110;
  isc_dyn_trg_blr = 111;
  isc_dyn_trg_source = 112;
  isc_dyn_trg_name = 114;
  isc_dyn_trg_sequence = 115;
  isc_dyn_trg_inactive = 116;
  isc_dyn_trg_msg_number = 117;
  isc_dyn_trg_msg = 118;

  // ---------------------------------------------------------------------------
  // Security Class specific attributes
  // ---------------------------------------------------------------------------
  isc_dyn_scl_acl = 121;
  isc_dyn_grant_user = 130;
  isc_dyn_grant_proc = 186;
  isc_dyn_grant_trig = 187;
  isc_dyn_grant_view = 188;
  isc_dyn_grant_options = 132;
  isc_dyn_grant_user_group = 205;
  // FB102 OR YF867
  isc_dyn_grant_role = 218;
  isc_dyn_grant_user_explicit = 219;

  // ---------------------------------------------------------------------------
  // Dimension specific information
  // ---------------------------------------------------------------------------
  isc_dyn_dim_lower = 141;
  isc_dyn_dim_upper = 142;

  // ---------------------------------------------------------------------------
  // File specific attributes
  // ---------------------------------------------------------------------------
  isc_dyn_file_name = 125;
  isc_dyn_file_start = 126;
  isc_dyn_file_length = 127;
  isc_dyn_shadow_number = 128;
  isc_dyn_shadow_man_auto = 129;
  isc_dyn_shadow_conditional = 130;

  // ---------------------------------------------------------------------------
  // Log file specific attributes
  // ---------------------------------------------------------------------------
  // not for FB20
  // deprecated
  isc_dyn_log_file_sequence = 177;
  isc_dyn_log_file_partitions = 178;
  isc_dyn_log_file_serial = 179;
  isc_dyn_log_file_overflow = 200;
  isc_dyn_log_file_raw = 201;

  // ---------------------------------------------------------------------------
  // Log specific attributes
  // ---------------------------------------------------------------------------
  // not for FB20
  // deprecated
  isc_dyn_log_group_commit_wait = 189;
  isc_dyn_log_buffer_size = 190;
  isc_dyn_log_check_point_length = 191;
  isc_dyn_log_num_of_buffers = 192;

  // ---------------------------------------------------------------------------
  // Function specific attributes
  // ---------------------------------------------------------------------------
  isc_dyn_function_name = 145;
  isc_dyn_function_type = 146;
  isc_dyn_func_module_name = 147;
  isc_dyn_func_entry_point = 148;
  isc_dyn_func_return_argument = 149;
  isc_dyn_func_arg_position = 150;
  isc_dyn_func_mechanism = 151;
  isc_dyn_filter_in_subtype = 152;
  isc_dyn_filter_out_subtype = 153;

  isc_dyn_description2 = 154;
  isc_dyn_fld_computed_source2 = 155;
  isc_dyn_fld_edit_string2 = 156;
  isc_dyn_fld_query_header2 = 157;
  isc_dyn_fld_validation_source2 = 158;
  isc_dyn_trg_msg2 = 159;
  isc_dyn_trg_source2 = 160;
  isc_dyn_view_source2 = 161;
  isc_dyn_xcp_msg2 = 184;

  // ---------------------------------------------------------------------------
  // Generator specific attributes
  // ---------------------------------------------------------------------------
  isc_dyn_generator_name = 95;
  isc_dyn_generator_id = 96;

  // ---------------------------------------------------------------------------
  // Procedure specific attributes
  // ---------------------------------------------------------------------------
  isc_dyn_prc_inputs = 167;
  isc_dyn_prc_outputs = 168;
  isc_dyn_prc_source = 169;
  isc_dyn_prc_blr = 170;
  isc_dyn_prc_source2 = 171;

  // ---------------------------------------------------------------------------
  // Parameter specific attributes
  // ---------------------------------------------------------------------------
  isc_dyn_prm_number = 138;
  isc_dyn_prm_type = 139;

  // ---------------------------------------------------------------------------
  // Relation specific attributes
  // ---------------------------------------------------------------------------
  isc_dyn_xcp_msg = 185;

  // ---------------------------------------------------------------------------
  // Cascading referential integrity values
  // ---------------------------------------------------------------------------
  isc_dyn_foreign_key_update = 205;
  isc_dyn_foreign_key_delete = 206;
  isc_dyn_foreign_key_cascade = 207;
  isc_dyn_foreign_key_default = 208;
  isc_dyn_foreign_key_null = 209;
  isc_dyn_foreign_key_none = 210;

  // ---------------------------------------------------------------------------
  // SQL role values
  // ---------------------------------------------------------------------------
  isc_dyn_def_sql_role = 211;
  isc_dyn_sql_role_name = 212;
  isc_dyn_grant_admin_options = 213;
  isc_dyn_del_sql_role = 214;
  // 215 & 216 are used some lines above.

  // ---------------------------------------------------------------------------
  // Generators again
  // ---------------------------------------------------------------------------
  // FB15 OR YF867
  gds_dyn_delete_generator = 217;

  // ---------------------------------------------------------------------------
  // ADMIN OPTION values
  // ---------------------------------------------------------------------------
  // IB75
  isc_dyn_add_admin                 = 221;
  isc_dyn_drop_admin                = 222;
  isc_dyn_admin_active              = 223;
  isc_dyn_admin_inactive            = 224;

  // ---------------------------------------------------------------------------
  // User specific attributes
  // ---------------------------------------------------------------------------
  // IB75
  isc_dyn_user_sys_name             = 11;
  isc_dyn_user_grp_name             = 12;
  isc_dyn_user_uid                  = 13;
  isc_dyn_user_gid                  = 14;
  isc_dyn_user_password             = 15;
  isc_dyn_user_active               = 16;
  isc_dyn_user_inactive             = 17;
  isc_dyn_user_description          = 18;
  isc_dyn_user_first_name           = 19;
  isc_dyn_user_middle_name          = 20;
  isc_dyn_user_last_name            = 21;
  isc_dyn_user_default_role         = 22;

  // ---------------------------------------------------------------------------
  // Database specific attributes
  // ---------------------------------------------------------------------------
  // IB75
  isc_dyn_db_page_cache             = 41;
  isc_dyn_db_proc_cache             = 42;
  isc_dyn_db_rel_cache              = 43;
  isc_dyn_db_trig_cache             = 44;
  isc_dyn_db_flush_int              = 45;
  isc_dyn_db_linger_int             = 46;
  isc_dyn_db_reclaim_int            = 47;
  isc_dyn_db_sweep_int              = 48;
  isc_dyn_db_group_commit           = 49;

  // ---------------------------------------------------------------------------
  // Last $dyn value assigned
  // ---------------------------------------------------------------------------
  isc_dyn_last_dyn_value_FB102 = 219;
  isc_dyn_last_dyn_value_FB103 = 219;
  isc_dyn_last_dyn_value_FB150 = 219;
  isc_dyn_last_dyn_value_FB200 = 223;
  isc_dyn_last_dyn_value_IB650 = 216;
  isc_dyn_last_dyn_value_IB710 = 217;
  isc_dyn_last_dyn_value_IB750 = 227;

  // ---------------------------------------------------------------------------
  // Array slice description language (SDL)
  // ---------------------------------------------------------------------------
  isc_sdl_version1 = 1;
  isc_sdl_eoc = 255;
  isc_sdl_relation = 2;
  isc_sdl_rid = 3;
  isc_sdl_field = 4;
  isc_sdl_fid = 5;
  isc_sdl_struct = 6;
  isc_sdl_variable = 7;
  isc_sdl_scalar = 8;
  isc_sdl_tiny_integer = 9;
  isc_sdl_short_integer = 10;
  isc_sdl_long_integer = 11;
  isc_sdl_literal = 12;
  isc_sdl_add = 13;
  isc_sdl_subtract = 14;
  isc_sdl_multiply = 15;
  isc_sdl_divide = 16;
  isc_sdl_negate = 17;
  isc_sdl_eql = 18;
  isc_sdl_neq = 19;
  isc_sdl_gtr = 20;
  isc_sdl_geq = 21;
  isc_sdl_lss = 22;
  isc_sdl_leq = 23;
  isc_sdl_and = 24;
  isc_sdl_or = 25;
  isc_sdl_not = 26;
  isc_sdl_while = 27;
  isc_sdl_assignment = 28;
  isc_sdl_label = 29;
  isc_sdl_leave = 30;
  isc_sdl_begin = 31;
  isc_sdl_end = 32;
  isc_sdl_do3 = 33;
  isc_sdl_do2 = 34;
  isc_sdl_do1 = 35;
  isc_sdl_element = 36;

  // ---------------------------------------------------------------------------
  // International text interpretation values
  // ---------------------------------------------------------------------------
  isc_interp_eng_ascii = 0;
  isc_interp_jpn_sjis = 5;
  isc_interp_jpn_euc = 6;

  // ---------------------------------------------------------------------------
  // SQL definitions
  // ---------------------------------------------------------------------------
  SQL_TEXT = 452; // Array of char
  SQL_VARYING = 448;
  SQL_SHORT = 500;
  SQL_LONG = 496;
  SQL_INT64 = 580;
  SQL_FLOAT = 482;
  SQL_DOUBLE = 480;
  SQL_D_FLOAT = 530;
  SQL_TYPE_TIME = 560;
  SQL_TYPE_DATE = 570;
  SQL_TIMESTAMP = 510;
  SQL_BLOB = 520;
  SQL_ARRAY = 540;
  SQL_QUAD = 550;

  // IB7
  SQL_BOOLEAN_IB = 590;

  // FB25
  SQL_NULL = 32766;

  // FB30
  SQL_BOOLEAN_FB = 32764;

  // Historical alias for pre V6 applications
  SQL_DATE = SQL_TIMESTAMP;

  // ---------------------------------------------------------------------------
  // Blob Subtypes
  // ---------------------------------------------------------------------------

  // types less than zero are reserved for customer use
  isc_blob_untyped = 0;

  // internal subtypes
  isc_blob_text                     = 1;
  isc_blob_blr                      = 2;
  isc_blob_acl                      = 3;
  isc_blob_ranges                   = 4;
  isc_blob_summary                  = 5;
  isc_blob_format                   = 6;
  isc_blob_tra                      = 7;
  isc_blob_extfile                  = 8;
  // FB20
  isc_blob_max_predefined_subtype   = 9;

  // the range 20-30 is reserved for dBASE and Paradox types
  isc_blob_formatted_memo = 20;
  isc_blob_paradox_ole = 21;
  isc_blob_graphic = 22;
  isc_blob_dbase_ole = 23;
  isc_blob_typed_binary = 24;

  // ---------------------------------------------------------------------------
  // FB 2.5
  // ---------------------------------------------------------------------------
  // fb_shutdown reasons
  fb_shutrsn_svc_stopped      = -1;
  fb_shutrsn_no_connection    = -2;
  fb_shutrsn_app_stopped      = -3;
  fb_shutrsn_device_removed   = -4;
  fb_shutrsn_signal           = -5;
  fb_shutrsn_services         = -6;
  fb_shutrsn_exit_called      = -7;

type
  FB_SHUTDOWN_CALLBACK_FUNC = function (reason: Integer; mask: Integer;
    arg: Pointer): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

const
  // fb_cancel_operation options
  fb_cancel_disable = 1;
  fb_cancel_enable  = 2;
  fb_cancel_raise   = 3;
  fb_cancel_abort   = 4;

  // ---------------------------------------------------------------------------
  // ISC Error Codes
  // ---------------------------------------------------------------------------
const
  ISC_MASK   = $14000000; // Defines the code as a valid ISC code
  FAC_MASK   = $00FF0000; // Specifies the facility where the code is located
  CODE_MASK  = $0000FFFF; // Specifies the code in the message file
  CLASS_MASK = $F0000000; // Defines the code as warning, error, info, or other

  // Note: Perhaps a debug level could be interesting !!!
  CLASS_ERROR   = 0; // Code represents an error
  CLASS_WARNING = 1; // Code represents a warning
  CLASS_INFO    = 2; // Code represents an information msg

  FAC_JRD        =  0;  // In Use
  FAC_QLI        =  1;
  FAC_GDEF       =  2;
  FAC_GFIX       =  3;  // In Use
  FAC_GPRE       =  4;
  FAC_GLTJ       =  5;
  FAC_GRST       =  6;
  FAC_DSQL       =  7;  // In Use
  FAC_DYN        =  8;  // In Use
  FAC_FRED       =  9;
  FAC_INSTALL    = 10;
  FAC_TEST       = 11;
  FAC_GBAK       = 12;  // In Use
  FAC_SQLERR     = 13;
  FAC_SQLWARN    = 14;
  FAC_JRD_BUGCHK = 15;
  FAC_GJRN       = 16;
  FAC_ISQL       = 17;
  FAC_GSEC       = 18;  // In Use
  FAC_LICENSE    = 19;  // In Use
  FAC_DOS        = 20;
  FAC_GSTAT      = 21;  // In Use

const
  isc_facility = 20;
  isc_base     = 335544320;
  isc_factor   = 1;

  isc_arg_end          = 0;  // end of argument list
  isc_arg_gds          = 1;  // generic DSRI status value
  isc_arg_string       = 2;  // string argument
  isc_arg_cstring      = 3;  // count & string argument
  isc_arg_number       = 4;  // numeric argument (long)
  isc_arg_interpreted  = 5;  // interpreted status code (string)
  isc_arg_vms          = 6;  // VAX/VMS status code (long)
  isc_arg_unix         = 7;  // UNIX error code
  isc_arg_domain       = 8;  // Apollo/Domain error code
  isc_arg_dos          = 9;  // MSDOS/OS2 error code
  isc_arg_mpexl        = 10; // HP MPE/XL error code
  isc_arg_mpexl_ipc    = 11; // HP MPE/XL IPC error code
  isc_arg_next_mach    = 15; // NeXT/Mach error code
  isc_arg_netware      = 16; // NetWare error code
  isc_arg_win32        = 17; // Win32 error code
  isc_arg_warning      = 18; // warning argument
  isc_arg_sql          = 19;

  isc_arith_except                      = 335544321;
  isc_bad_dbkey                         = 335544322;
  isc_bad_db_format                     = 335544323;
  isc_bad_db_handle                     = 335544324;
  isc_bad_dpb_content                   = 335544325;
  isc_bad_dpb_form                      = 335544326;
  isc_bad_req_handle                    = 335544327;
  isc_bad_segstr_handle                 = 335544328;
  isc_bad_segstr_id                     = 335544329;
  isc_bad_tpb_content                   = 335544330;
  isc_bad_tpb_form                      = 335544331;
  isc_bad_trans_handle                  = 335544332;
  isc_bug_check                         = 335544333;
  isc_convert_error                     = 335544334;
  isc_db_corrupt                        = 335544335;
  isc_deadlock                          = 335544336;
  isc_excess_trans                      = 335544337;
  isc_from_no_match                     = 335544338;
  isc_infinap                           = 335544339;
  isc_infona                            = 335544340;
  isc_infunk                            = 335544341;
  isc_integ_fail                        = 335544342;
  isc_invalid_blr                       = 335544343;
  isc_io_error                          = 335544344;
  isc_lock_conflict                     = 335544345;
  isc_metadata_corrupt                  = 335544346;
  isc_not_valid                         = 335544347;
  isc_no_cur_rec                        = 335544348;
  isc_no_dup                            = 335544349;
  isc_no_finish                         = 335544350;
  isc_no_meta_update                    = 335544351;
  isc_no_priv                           = 335544352;
  isc_no_recon                          = 335544353;
  isc_no_record                         = 335544354;
  isc_no_segstr_close                   = 335544355;
  isc_obsolete_metadata                 = 335544356;
  isc_open_trans                        = 335544357;
  isc_port_len                          = 335544358;
  isc_read_only_field                   = 335544359;
  isc_read_only_rel                     = 335544360;
  isc_read_only_trans                   = 335544361;
  isc_read_only_view                    = 335544362;
  isc_req_no_trans                      = 335544363;
  isc_req_sync                          = 335544364;
  isc_req_wrong_db                      = 335544365;
  isc_segment                           = 335544366;
  isc_segstr_eof                        = 335544367;
  isc_segstr_no_op                      = 335544368;
  isc_segstr_no_read                    = 335544369;
  isc_segstr_no_trans                   = 335544370;
  isc_segstr_no_write                   = 335544371;
  isc_segstr_wrong_db                   = 335544372;
  isc_sys_request                       = 335544373;
  isc_stream_eof                        = 335544374;
  isc_unavailable                       = 335544375;
  isc_unres_rel                         = 335544376;
  isc_uns_ext                           = 335544377;
  isc_wish_list                         = 335544378;
  isc_wrong_ods                         = 335544379;
  isc_wronumarg                         = 335544380;
  isc_imp_exc                           = 335544381;
  isc_random                            = 335544382;
  isc_fatal_conflict                    = 335544383;
  isc_badblk                            = 335544384;
  isc_invpoolcl                         = 335544385;
  isc_nopoolids                         = 335544386;
  isc_relbadblk                         = 335544387;
  isc_blktoobig                         = 335544388;
  isc_bufexh                            = 335544389;
  isc_syntaxerr                         = 335544390;
  isc_bufinuse                          = 335544391;
  isc_bdbincon                          = 335544392;
  isc_reqinuse                          = 335544393;
  isc_badodsver                         = 335544394;
  isc_relnotdef                         = 335544395;
  isc_fldnotdef                         = 335544396;
  isc_dirtypage                         = 335544397;
  isc_waifortra                         = 335544398;
  isc_doubleloc                         = 335544399;
  isc_nodnotfnd                         = 335544400;
  isc_dupnodfnd                         = 335544401;
  isc_locnotmar                         = 335544402;
  isc_badpagtyp                         = 335544403;
  isc_corrupt                           = 335544404;
  isc_badpage                           = 335544405;
  isc_badindex                          = 335544406;
  isc_dbbnotzer                         = 335544407;
  isc_tranotzer                         = 335544408;
  isc_trareqmis                         = 335544409;
  isc_badhndcnt                         = 335544410;
  isc_wrotpbver                         = 335544411;
  isc_wroblrver                         = 335544412;
  isc_wrodpbver                         = 335544413;
  isc_blobnotsup                        = 335544414;
  isc_badrelation                       = 335544415;
  isc_nodetach                          = 335544416;
  isc_notremote                         = 335544417;
  isc_trainlim                          = 335544418;
  isc_notinlim                          = 335544419;
  isc_traoutsta                         = 335544420;
  isc_connect_reject                    = 335544421;
  isc_dbfile                            = 335544422;
  isc_orphan                            = 335544423;
  isc_no_lock_mgr                       = 335544424;
  isc_ctxinuse                          = 335544425;
  isc_ctxnotdef                         = 335544426;
  isc_datnotsup                         = 335544427;
  isc_badmsgnum                         = 335544428;
  isc_badparnum                         = 335544429;
  isc_virmemexh                         = 335544430;
  isc_blocking_signal                   = 335544431;
  isc_lockmanerr                        = 335544432;
  isc_journerr                          = 335544433;
  isc_keytoobig                         = 335544434;
  isc_nullsegkey                        = 335544435;
  isc_sqlerr                            = 335544436;
  isc_wrodynver                         = 335544437;
  isc_funnotdef                         = 335544438;
  isc_funmismat                         = 335544439;
  isc_bad_msg_vec                       = 335544440;
  isc_bad_detach                        = 335544441;
  isc_noargacc_read                     = 335544442;
  isc_noargacc_write                    = 335544443;
  isc_read_only                         = 335544444;
  isc_ext_err                           = 335544445;
  isc_non_updatable                     = 335544446;
  isc_no_rollback                       = 335544447;
  isc_bad_sec_info                      = 335544448;
  isc_invalid_sec_info                  = 335544449;
  isc_misc_interpreted                  = 335544450;
  isc_update_conflict                   = 335544451;
  isc_unlicensed                        = 335544452;
  isc_obj_in_use                        = 335544453;
  isc_nofilter                          = 335544454;
  isc_shadow_accessed                   = 335544455;
  isc_invalid_sdl                       = 335544456;
  isc_out_of_bounds                     = 335544457;
  isc_invalid_dimension                 = 335544458;
  isc_rec_in_limbo                      = 335544459;
  isc_shadow_missing                    = 335544460;
  isc_cant_validate                     = 335544461;
  isc_cant_start_journal                = 335544462;
  isc_gennotdef                         = 335544463;
  isc_cant_start_logging                = 335544464;
  isc_bad_segstr_type                   = 335544465;
  isc_foreign_key                       = 335544466;
  isc_high_minor                        = 335544467;
  isc_tra_state                         = 335544468;
  isc_trans_invalid                     = 335544469;
  isc_buf_invalid                       = 335544470;
  isc_indexnotdefined                   = 335544471;
  isc_login                             = 335544472;
  isc_invalid_bookmark                  = 335544473;
  isc_bad_lock_level                    = 335544474;
  isc_relation_lock                     = 335544475;
  isc_record_lock                       = 335544476;
  isc_max_idx                           = 335544477;
  isc_jrn_enable                        = 335544478;
  isc_old_failure                       = 335544479;
  isc_old_in_progress                   = 335544480;
  isc_old_no_space                      = 335544481;
  isc_no_wal_no_jrn                     = 335544482;
  isc_num_old_files                     = 335544483;
  isc_wal_file_open                     = 335544484;
  isc_bad_stmt_handle                   = 335544485;
  isc_wal_failure                       = 335544486;
  isc_walw_err                          = 335544487;
  isc_logh_small                        = 335544488;
  isc_logh_inv_version                  = 335544489;
  isc_logh_open_flag                    = 335544490;
  isc_logh_open_flag2                   = 335544491;
  isc_logh_diff_dbname                  = 335544492;
  isc_logf_unexpected_eof               = 335544493;
  isc_logr_incomplete                   = 335544494;
  isc_logr_header_small                 = 335544495;
  isc_logb_small                        = 335544496;
  isc_wal_illegal_attach                = 335544497;
  isc_wal_invalid_wpb                   = 335544498;
  isc_wal_err_rollover                  = 335544499;
  isc_no_wal                            = 335544500;
  isc_drop_wal                          = 335544501;
  isc_stream_not_defined                = 335544502;
  isc_wal_subsys_error                  = 335544503;
  isc_wal_subsys_corrupt                = 335544504;
  isc_no_archive                        = 335544505;
  isc_shutinprog                        = 335544506;
  isc_range_in_use                      = 335544507;
  isc_range_not_found                   = 335544508;
  isc_charset_not_found                 = 335544509;
  isc_lock_timeout                      = 335544510;
  isc_prcnotdef                         = 335544511;
  isc_prcmismat                         = 335544512;
  isc_wal_bugcheck                      = 335544513;
  isc_wal_cant_expand                   = 335544514;
  isc_codnotdef                         = 335544515;
  isc_xcpnotdef                         = 335544516;
  isc_except                            = 335544517;
  isc_cache_restart                     = 335544518;
  isc_bad_lock_handle                   = 335544519;
  isc_jrn_present                       = 335544520;
  isc_wal_err_rollover2                 = 335544521;
  isc_wal_err_logwrite                  = 335544522;
  isc_wal_err_jrn_comm                  = 335544523;
  isc_wal_err_expansion                 = 335544524;
  isc_wal_err_setup                     = 335544525;
  isc_wal_err_ww_sync                   = 335544526;
  isc_wal_err_ww_start                  = 335544527;
  isc_shutdown                          = 335544528;
  isc_existing_priv_mod                 = 335544529;
  isc_primary_key_ref                   = 335544530;
  isc_primary_key_notnull               = 335544531;
  isc_ref_cnstrnt_notfound              = 335544532;
  isc_foreign_key_notfound              = 335544533;
  isc_ref_cnstrnt_update                = 335544534;
  isc_check_cnstrnt_update              = 335544535;
  isc_check_cnstrnt_del                 = 335544536;
  isc_integ_index_seg_del               = 335544537;
  isc_integ_index_seg_mod               = 335544538;
  isc_integ_index_del                   = 335544539;
  isc_integ_index_mod                   = 335544540;
  isc_check_trig_del                    = 335544541;
  isc_check_trig_update                 = 335544542;
  isc_cnstrnt_fld_del                   = 335544543;
  isc_cnstrnt_fld_rename                = 335544544;
  isc_rel_cnstrnt_update                = 335544545;
  isc_constaint_on_view                 = 335544546;
  isc_invld_cnstrnt_type                = 335544547;
  isc_primary_key_exists                = 335544548;
  isc_systrig_update                    = 335544549;
  isc_not_rel_owner                     = 335544550;
  isc_grant_obj_notfound                = 335544551;
  isc_grant_fld_notfound                = 335544552;
  isc_grant_nopriv                      = 335544553;
  isc_nonsql_security_rel               = 335544554;
  isc_nonsql_security_fld               = 335544555;
  isc_wal_cache_err                     = 335544556;
  isc_shutfail                          = 335544557;
  isc_check_constraint                  = 335544558;
  isc_bad_svc_handle                    = 335544559;
  isc_shutwarn                          = 335544560;
  isc_wrospbver                         = 335544561;
  isc_bad_spb_form                      = 335544562;
  isc_svcnotdef                         = 335544563;
  isc_no_jrn                            = 335544564;
  isc_transliteration_failed            = 335544565;
  isc_start_cm_for_wal                  = 335544566;
  isc_wal_ovflow_log_required           = 335544567;
  isc_text_subtype                      = 335544568;
  isc_dsql_error                        = 335544569;
  isc_dsql_command_err                  = 335544570;
  isc_dsql_constant_err                 = 335544571;
  isc_dsql_cursor_err                   = 335544572;
  isc_dsql_datatype_err                 = 335544573;
  isc_dsql_decl_err                     = 335544574;
  isc_dsql_cursor_update_err            = 335544575;
  isc_dsql_cursor_open_err              = 335544576;
  isc_dsql_cursor_close_err             = 335544577;
  isc_dsql_field_err                    = 335544578;
  isc_dsql_internal_err                 = 335544579;
  isc_dsql_relation_err                 = 335544580;
  isc_dsql_procedure_err                = 335544581;
  isc_dsql_request_err                  = 335544582;
  isc_dsql_sqlda_err                    = 335544583;
  isc_dsql_var_count_err                = 335544584;
  isc_dsql_stmt_handle                  = 335544585;
  isc_dsql_function_err                 = 335544586;
  isc_dsql_blob_err                     = 335544587;
  isc_collation_not_found               = 335544588;
  isc_collation_not_for_charset         = 335544589;
  isc_dsql_dup_option                   = 335544590;
  isc_dsql_tran_err                     = 335544591;
  isc_dsql_invalid_array                = 335544592;
  isc_dsql_max_arr_dim_exceeded         = 335544593;
  isc_dsql_arr_range_error              = 335544594;
  isc_dsql_trigger_err                  = 335544595;
  isc_dsql_subselect_err                = 335544596;
  isc_dsql_crdb_prepare_err             = 335544597;
  isc_specify_field_err                 = 335544598;
  isc_num_field_err                     = 335544599;
  isc_col_name_err                      = 335544600;
  isc_where_err                         = 335544601;
  isc_table_view_err                    = 335544602;
  isc_distinct_err                      = 335544603;
  isc_key_field_count_err               = 335544604;
  isc_subquery_err                      = 335544605;
  isc_expression_eval_err               = 335544606;
  isc_node_err                          = 335544607;
  isc_command_end_err                   = 335544608;
  isc_index_name                        = 335544609;
  isc_exception_name                    = 335544610;
  isc_field_name                        = 335544611;
  isc_token_err                         = 335544612;
  isc_union_err                         = 335544613;
  isc_dsql_construct_err                = 335544614;
  isc_field_aggregate_err               = 335544615;
  isc_field_ref_err                     = 335544616;
  isc_order_by_err                      = 335544617;
  isc_return_mode_err                   = 335544618;
  isc_extern_func_err                   = 335544619;
  isc_alias_conflict_err                = 335544620;
  isc_procedure_conflict_error          = 335544621;
  isc_relation_conflict_err             = 335544622;
  isc_dsql_domain_err                   = 335544623;
  isc_idx_seg_err                       = 335544624;
  isc_node_name_err                     = 335544625;
  isc_table_name                        = 335544626;
  isc_proc_name                         = 335544627;
  isc_idx_create_err                    = 335544628;
  isc_wal_shadow_err                    = 335544629;
  isc_dependency                        = 335544630;
  isc_idx_key_err                       = 335544631;
  isc_dsql_file_length_err              = 335544632;
  isc_dsql_shadow_number_err            = 335544633;
  isc_dsql_token_unk_err                = 335544634;
  isc_dsql_no_relation_alias            = 335544635;
  isc_indexname                         = 335544636;
  isc_no_stream_plan                    = 335544637;
  isc_stream_twice                      = 335544638;
  isc_stream_not_found                  = 335544639;
  isc_collation_requires_text           = 335544640;
  isc_dsql_domain_not_found             = 335544641;
  isc_index_unused                      = 335544642;
  isc_dsql_self_join                    = 335544643;
  isc_stream_bof                        = 335544644;
  isc_stream_crack                      = 335544645;
  isc_db_or_file_exists                 = 335544646;
  isc_invalid_operator                  = 335544647;
  isc_conn_lost                         = 335544648;
  isc_bad_checksum                      = 335544649;
  isc_page_type_err                     = 335544650;
  isc_ext_readonly_err                  = 335544651;
  isc_sing_select_err                   = 335544652;
  isc_psw_attach                        = 335544653;
  isc_psw_start_trans                   = 335544654;
  isc_invalid_direction                 = 335544655;
  isc_dsql_var_conflict                 = 335544656;
  isc_dsql_no_blob_array                = 335544657;
  isc_dsql_base_table                   = 335544658;
  isc_duplicate_base_table              = 335544659;
  isc_view_alias                        = 335544660;
  isc_index_root_page_full              = 335544661;
  isc_dsql_blob_type_unknown            = 335544662;
  isc_req_max_clones_exceeded           = 335544663;
  isc_dsql_duplicate_spec               = 335544664;
  isc_unique_key_violation              = 335544665;
  isc_srvr_version_too_old              = 335544666;
  isc_drdb_completed_with_errs          = 335544667;
  isc_dsql_procedure_use_err            = 335544668;
  isc_dsql_count_mismatch               = 335544669;
  isc_blob_idx_err                      = 335544670;
  isc_array_idx_err                     = 335544671;
  isc_key_field_err                     = 335544672;
  isc_no_delete                         = 335544673;
  isc_del_last_field                    = 335544674;
  isc_sort_err                          = 335544675;
  isc_sort_mem_err                      = 335544676;
  isc_version_err                       = 335544677;
  isc_inval_key_posn                    = 335544678;
  isc_no_segments_err                   = 335544679;
  isc_crrp_data_err                     = 335544680;
  isc_rec_size_err                      = 335544681;
  isc_dsql_field_ref                    = 335544682;
  isc_req_depth_exceeded                = 335544683;
  isc_no_field_access                   = 335544684;
  isc_no_dbkey                          = 335544685;
  isc_jrn_format_err                    = 335544686;
  isc_jrn_file_full                     = 335544687;
  isc_dsql_open_cursor_request          = 335544688;
  isc_ib_error                          = 335544689;
  isc_cache_redef                       = 335544690;
  isc_cache_too_small                   = 335544691;
  isc_log_redef                         = 335544692;
  isc_log_too_small                     = 335544693;
  isc_partition_too_small               = 335544694;
  isc_partition_not_supp                = 335544695;
  isc_log_length_spec                   = 335544696;
  isc_precision_err                     = 335544697;
  isc_scale_nogt                        = 335544698;
  isc_expec_short                       = 335544699;
  isc_expec_long                        = 335544700;
  isc_expec_ushort                      = 335544701;
  isc_like_escape_invalid               = 335544702;
  isc_svcnoexe                          = 335544703;
  isc_net_lookup_err                    = 335544704;
  isc_service_unknown                   = 335544705;
  isc_host_unknown                      = 335544706;
  isc_grant_nopriv_on_base              = 335544707;
  isc_dyn_fld_ambiguous                 = 335544708;
  isc_dsql_agg_ref_err                  = 335544709;
  isc_complex_view                      = 335544710;
  isc_unprepared_stmt                   = 335544711;
  isc_expec_positive                    = 335544712;
  isc_dsql_sqlda_value_err              = 335544713;
  isc_invalid_array_id                  = 335544714;
  isc_extfile_uns_op                    = 335544715;
  isc_svc_in_use                        = 335544716;
  isc_err_stack_limit                   = 335544717;
  isc_invalid_key                       = 335544718;
  isc_net_init_error                    = 335544719;
  isc_loadlib_failure                   = 335544720;
  isc_network_error                     = 335544721;
  isc_net_connect_err                   = 335544722;
  isc_net_connect_listen_err            = 335544723;
  isc_net_event_connect_err             = 335544724;
  isc_net_event_listen_err              = 335544725;
  isc_net_read_err                      = 335544726;
  isc_net_write_err                     = 335544727;
  isc_integ_index_deactivate            = 335544728;
  isc_integ_deactivate_primary          = 335544729;
  isc_cse_not_supported                 = 335544730;
  isc_tra_must_sweep                    = 335544731;
  isc_unsupported_network_drive         = 335544732;
  isc_io_create_err                     = 335544733;
  isc_io_open_err                       = 335544734;
  isc_io_close_err                      = 335544735;
  isc_io_read_err                       = 335544736;
  isc_io_write_err                      = 335544737;
  isc_io_delete_err                     = 335544738;
  isc_io_access_err                     = 335544739;
  isc_udf_exception                     = 335544740;
  isc_lost_db_connection                = 335544741;
  isc_no_write_user_priv                = 335544742;
  isc_token_too_long                    = 335544743;
  isc_max_att_exceeded                  = 335544744;
  isc_login_same_as_role_name           = 335544745;
  isc_reftable_requires_pk              = 335544746;
  isc_usrname_too_long                  = 335544747;
  isc_password_too_long                 = 335544748;
  isc_usrname_required                  = 335544749;
  isc_password_required                 = 335544750;
  isc_bad_protocol                      = 335544751;
  isc_dup_usrname_found                 = 335544752;
  isc_usrname_not_found                 = 335544753;
  isc_error_adding_sec_record           = 335544754;
  isc_error_modifying_sec_record        = 335544755;
  isc_error_deleting_sec_record         = 335544756;
  isc_error_updating_sec_db             = 335544757;
  isc_sort_rec_size_err                 = 335544758;
  isc_bad_default_value                 = 335544759;
  isc_invalid_clause                    = 335544760;
  isc_too_many_handles                  = 335544761;
  isc_optimizer_blk_exc                 = 335544762;
  isc_invalid_string_constant           = 335544763;
  isc_transitional_date                 = 335544764;
  isc_read_only_database                = 335544765;
  isc_must_be_dialect_2_and_up          = 335544766;
  isc_blob_filter_exception             = 335544767;
  isc_exception_access_violation        = 335544768;
  isc_exception_datatype_missalignment  = 335544769;
  isc_exception_array_bounds_exceeded   = 335544770;
  isc_exception_float_denormal_operand  = 335544771;
  isc_exception_float_divide_by_zero    = 335544772;
  isc_exception_float_inexact_result    = 335544773;
  isc_exception_float_invalid_operand   = 335544774;
  isc_exception_float_overflow          = 335544775;
  isc_exception_float_stack_check       = 335544776;
  isc_exception_float_underflow         = 335544777;
  isc_exception_integer_divide_by_zero  = 335544778;
  isc_exception_integer_overflow        = 335544779;
  isc_exception_unknown                 = 335544780;
  isc_exception_stack_overflow          = 335544781;
  isc_exception_sigsegv                 = 335544782;
  isc_exception_sigill                  = 335544783;
  isc_exception_sigbus                  = 335544784;
  isc_exception_sigfpe                  = 335544785;
  isc_ext_file_delete                   = 335544786;
  isc_ext_file_modify                   = 335544787;
  isc_adm_task_denied                   = 335544788;
  isc_extract_input_mismatch            = 335544789;
  isc_insufficient_svc_privileges       = 335544790;
  isc_file_in_use                       = 335544791;
  isc_service_att_err                   = 335544792;
  isc_ddl_not_allowed_by_db_sql_dial    = 335544793;
  isc_cancelled                         = 335544794;
  isc_unexp_spb_form                    = 335544795;
  isc_sql_dialect_datatype_unsupport    = 335544796;
  isc_svcnouser                         = 335544797;
  isc_depend_on_uncommitted_rel         = 335544798;
  isc_svc_name_missing                  = 335544799;
  isc_too_many_contexts                 = 335544800;
  isc_datype_notsup                     = 335544801;
  isc_dialect_reset_warning             = 335544802;
  isc_dialect_not_changed               = 335544803;
  isc_database_create_failed            = 335544804;
  isc_inv_dialect_specified             = 335544805;
  isc_valid_db_dialects                 = 335544806;
  isc_sqlwarn                           = 335544807;
  isc_dtype_renamed                     = 335544808;
  isc_extern_func_dir_error             = 335544809;
  isc_date_range_exceeded               = 335544810;
  isc_inv_client_dialect_specified      = 335544811;
  isc_valid_client_dialects             = 335544812;
  isc_optimizer_between_err             = 335544813;
  isc_service_not_supported             = 335544814;

  // FB102 OR YF867
  isc_generator_name                    = 335544815;
  isc_udf_name                          = 335544816;
  isc_bad_limit_param                   = 335544817;
  isc_bad_skip_param                    = 335544818;
  isc_io_32bit_exceeded_err             = 335544819;

  // FB15
  isc_invalid_savepoint                 = 335544820;
  isc_dsql_column_pos_err               = 335544821;
  isc_dsql_agg_where_err                = 335544822;
  isc_dsql_agg_group_err                = 335544823;
  isc_dsql_agg_column_err               = 335544824;
  isc_dsql_agg_having_err               = 335544825;
  isc_dsql_agg_nested_err               = 335544826;
  isc_exec_sql_invalid_arg              = 335544827;
  isc_exec_sql_invalid_req              = 335544828;
  isc_exec_sql_invalid_var              = 335544829;
  isc_exec_sql_max_call_exceeded        = 335544830;
  isc_conf_access_denied                = 335544831;

  // FB20
  isc_wrong_backup_state               = 335544832;
  isc_wal_backup_err                   = 335544833;
  isc_cursor_not_open                  = 335544834;
  isc_bad_shutdown_mode                = 335544835;
  isc_concat_overflow                  = 335544836;
  isc_bad_substring_offset             = 335544837;
  isc_foreign_key_target_doesnt_exist  = 335544838;
  isc_foreign_key_references_present   = 335544839;
  isc_no_update                        = 335544840;
  isc_cursor_already_open              = 335544841;
  isc_stack_trace                      = 335544842;
  isc_ctx_var_not_found                = 335544843;
  isc_ctx_namespace_invalid            = 335544844;
  isc_ctx_too_big                      = 335544845;
  isc_ctx_bad_argument                 = 335544846;
  isc_identifier_too_long              = 335544847;
  isc_except2                          = 335544848;
  isc_malformed_string                 = 335544849;
  isc_prc_out_param_mismatch           = 335544850;
  isc_command_end_err2                 = 335544851;
  isc_partner_idx_incompat_type        = 335544852;
  isc_bad_substring_length             = 335544853;
  isc_charset_not_installed            = 335544854;
  isc_collation_not_installed          = 335544855;
  isc_att_shutdown                     = 335544856;
  isc_blobtoobig                       = 335544857;
  isc_must_have_phys_field             = 335544858;
  isc_invalid_time_precision           = 335544859;
  isc_blob_convert_error               = 335544860;
  isc_array_convert_error              = 335544861;
  isc_record_lock_not_supp             = 335544862;
  isc_partner_idx_not_found            = 335544863;

  // IB71
  isc_savepoint_err                     = 335544815;
  isc_generator_name_2                  = 335544816;
  isc_udf_name_2                        = 335544817;

  isc_gfix_db_name                      = 335740929;
  isc_gfix_invalid_sw                   = 335740930;
  isc_gfix_incmp_sw                     = 335740932;
  isc_gfix_replay_req                   = 335740933;
  isc_gfix_pgbuf_req                    = 335740934;
  isc_gfix_val_req                      = 335740935;
  isc_gfix_pval_req                     = 335740936;
  isc_gfix_trn_req                      = 335740937;
  isc_gfix_full_req                     = 335740940;
  isc_gfix_usrname_req                  = 335740941;
  isc_gfix_pass_req                     = 335740942;
  isc_gfix_subs_name                    = 335740943;
  isc_gfix_wal_req                      = 335740944;
  isc_gfix_sec_req                      = 335740945;
  isc_gfix_nval_req                     = 335740946;
  isc_gfix_type_shut                    = 335740947;
  isc_gfix_retry                        = 335740948;
  isc_gfix_retry_db                     = 335740951;
  isc_gfix_exceed_max                   = 335740991;
  isc_gfix_corrupt_pool                 = 335740992;
  isc_gfix_mem_exhausted                = 335740993;
  isc_gfix_bad_pool                     = 335740994;
  isc_gfix_trn_not_valid                = 335740995;
  isc_gfix_unexp_eoi                    = 335741012;
  isc_gfix_recon_fail                   = 335741018;
  isc_gfix_trn_unknown                  = 335741036;
  isc_gfix_mode_req                     = 335741038;
  isc_gfix_opt_SQL_dialect              = 335741039;

  // FB20
  isc_gfix_pzval_req                    = 335741042;

  // IB7
  isc_gfix_commits_opt                  = 335741041;

  isc_dsql_dbkey_from_non_table         = 336003074;
  isc_dsql_transitional_numeric         = 336003075;
  isc_dsql_dialect_warning_expr         = 336003076;
  isc_sql_db_dialect_dtype_unsupport    = 336003077;
  isc_isc_sql_dialect_conflict_num      = 336003079;
  isc_dsql_warning_number_ambiguous     = 336003080;
  isc_dsql_warning_number_ambiguous1    = 336003081;
  isc_dsql_warn_precision_ambiguous     = 336003082;
  isc_dsql_warn_precision_ambiguous1    = 336003083;
  isc_dsql_warn_precision_ambiguous2    = 336003084;

  // FB102 OR YF867
  isc_dsql_ambiguous_field_name         = 336003085;
  isc_dsql_udf_return_pos_err           = 336003086;

  // FB15
  isc_dsql_invalid_label                = 336003087;
  isc_dsql_datatypes_not_comparable     = 336003088;

  // FB20
  isc_dsql_cursor_invalid              = 336003089;
  isc_dsql_cursor_redefined            = 336003090;
  isc_dsql_cursor_not_found            = 336003091;
  isc_dsql_cursor_exists               = 336003092;
  isc_dsql_cursor_rel_ambiguous        = 336003093;
  isc_dsql_cursor_rel_not_found        = 336003094;
  isc_dsql_cursor_not_open             = 336003095;
  isc_dsql_type_not_supp_ext_tab       = 336003096;

  // IB65
  isc_dsql_rows_ties_err                = 336003085;

  // IB75
  isc_dsql_cursor_stmt_err             = 336003086;
  isc_dsql_on_commit_invalid           = 336003087;
  isc_dsql_gen_cnstrnt_ref_temp        = 336003088;
  isc_dsql_persist_cnstrnt_ref_temp    = 336003089;
  isc_dsql_temp_cnstrnt_ref_persist    = 336003090;
  isc_dsql_persist_refs_temp           = 336003091;
  isc_dsql_temp_refs_persist           = 336003092;
  isc_dsql_temp_refs_mismatch          = 336003093;
  isc_dsql_usrname_lower               = 336003094;

  // FB30
  isc_dyn_filter_not_found             = 336068645;
  isc_dyn_func_not_found               = 336068649;
  isc_dyn_index_not_found              = 336068656;
  isc_dyn_view_not_found               = 336068662;
  isc_dyn_domain_not_found             = 336068697;
  isc_dyn_cant_modify_auto_trig        = 336068717;
  isc_dyn_proc_not_found               = 336068748;
  isc_dyn_exception_not_found          = 336068752;
  isc_dyn_proc_param_not_found         = 336068754;
  isc_dyn_trig_not_found               = 336068755;
  isc_dyn_charset_not_found            = 336068759;
  isc_dyn_collation_not_found          = 336068760;
  isc_dyn_role_not_found               = 336068763;
  isc_dyn_name_longer                  = 336068767;
  isc_dyn_gen_not_found                = 336068822;
  isc_dyn_coll_used_table              = 336068843;
  isc_dyn_coll_used_domain             = 336068844;
  isc_dyn_cannot_del_syscoll           = 336068845;
  isc_dyn_cannot_del_def_coll          = 336068846;
  isc_dyn_table_not_found              = 336068849;
  isc_dyn_coll_used_procedure          = 336068851;
  isc_dyn_package_not_found            = 336068864;
  isc_dyn_schema_not_found             = 336068865;
  isc_dyn_cannot_mod_sysproc           = 336068866;
  isc_dyn_cannot_mod_systrig           = 336068867;
  isc_dyn_cannot_mod_sysfunc           = 336068868;
  isc_dyn_invalid_ddl_proc             = 336068869;
  isc_dyn_invalid_ddl_trig             = 336068870;
  isc_dyn_funcnotdef_package           = 336068871;
  isc_dyn_procnotdef_package           = 336068872;
  isc_dyn_funcsignat_package           = 336068873;
  isc_dyn_procsignat_package           = 336068874;
  isc_dyn_defvaldecl_package           = 336068875;
  isc_dyn_package_body_exists          = 336068877;
  isc_dyn_invalid_ddl_func             = 336068878;
  isc_dyn_newfc_oldsyntax              = 336068879;
  isc_dyn_func_param_not_found         = 336068886;
  isc_dyn_routine_param_not_found      = 336068887;
  isc_dyn_routine_param_ambiguous      = 336068888;
  isc_dyn_coll_used_function           = 336068889;
  isc_dyn_domain_used_function         = 336068890;

  isc_dsql_alter_charset_failed        = 336397258;
  isc_dsql_comment_on_failed           = 336397259;
  isc_dsql_create_func_failed          = 336397260;
  isc_dsql_alter_func_failed           = 336397261;
  isc_dsql_create_alter_func_failed    = 336397262;
  isc_dsql_drop_func_failed            = 336397263;
  isc_dsql_recreate_func_failed        = 336397264;
  isc_dsql_create_proc_failed          = 336397265;
  isc_dsql_alter_proc_failed           = 336397266;
  isc_dsql_create_alter_proc_failed    = 336397267;
  isc_dsql_drop_proc_failed            = 336397268;
  isc_dsql_recreate_proc_failed        = 336397269;
  isc_dsql_create_trigger_failed       = 336397270;
  isc_dsql_alter_trigger_failed        = 336397271;
  isc_dsql_create_alter_trigger_failed = 336397272;
  isc_dsql_drop_trigger_failed         = 336397273;
  isc_dsql_recreate_trigger_failed     = 336397274;
  isc_dsql_create_collation_failed     = 336397275;
  isc_dsql_drop_collation_failed       = 336397276;
  isc_dsql_create_domain_failed        = 336397277;
  isc_dsql_alter_domain_failed         = 336397278;
  isc_dsql_drop_domain_failed          = 336397279;
  isc_dsql_create_except_failed        = 336397280;
  isc_dsql_alter_except_failed         = 336397281;
  isc_dsql_create_alter_except_failed  = 336397282;
  isc_dsql_recreate_except_failed      = 336397283;
  isc_dsql_drop_except_failed          = 336397284;
  isc_dsql_create_sequence_failed      = 336397285;
  isc_dsql_create_table_failed         = 336397286;
  isc_dsql_alter_table_failed          = 336397287;
  isc_dsql_drop_table_failed           = 336397288;
  isc_dsql_recreate_table_failed       = 336397289;
  isc_dsql_create_pack_failed          = 336397290;
  isc_dsql_alter_pack_failed           = 336397291;
  isc_dsql_create_alter_pack_failed    = 336397292;
  isc_dsql_drop_pack_failed            = 336397293;
  isc_dsql_recreate_pack_failed        = 336397294;
  isc_dsql_create_pack_body_failed     = 336397295;
  isc_dsql_drop_pack_body_failed       = 336397296;
  isc_dsql_recreate_pack_body_failed   = 336397297;
  isc_dsql_create_view_failed          = 336397298;
  isc_dsql_alter_view_failed           = 336397299;
  isc_dsql_create_alter_view_failed    = 336397300;
  isc_dsql_recreate_view_failed        = 336397301;
  isc_dsql_drop_view_failed            = 336397302;

  isc_dyn_role_does_not_exist           = 336068796;
  isc_dyn_no_grant_admin_opt            = 336068797;
  isc_dyn_user_not_role_member          = 336068798;
  isc_dyn_delete_role_failed            = 336068799;
  isc_dyn_grant_role_to_user            = 336068800;
  isc_dyn_inv_sql_role_name             = 336068801;
  isc_dyn_dup_sql_role                  = 336068802;
  isc_dyn_kywd_spec_for_role            = 336068803;
  isc_dyn_roles_not_supported           = 336068804;
  isc_dyn_domain_name_exists            = 336068812;
  isc_dyn_field_name_exists             = 336068813;
  isc_dyn_dependency_exists             = 336068814;
  isc_dyn_dtype_invalid                 = 336068815;
  isc_dyn_char_fld_too_small            = 336068816;
  isc_dyn_invalid_dtype_conversion      = 336068817;
  isc_dyn_dtype_conv_invalid            = 336068818;

  // FB102 OR YF867
  isc_dyn_zero_len_id                   = 336068820;

  // IB71
  isc_dyn_gen_does_not_exist            = 336068820;
  isc_dyn_delete_generator_failed       = 336068821;

  // IB75
  isc_dyn_drop_db_owner                = 336068836;

  isc_gbak_unknown_switch               = 336330753;
  isc_gbak_page_size_missing            = 336330754;
  isc_gbak_page_size_toobig             = 336330755;
  isc_gbak_redir_ouput_missing          = 336330756;
  isc_gbak_switches_conflict            = 336330757;
  isc_gbak_unknown_device               = 336330758;
  isc_gbak_no_protection                = 336330759;
  isc_gbak_page_size_not_allowed        = 336330760;
  isc_gbak_multi_source_dest            = 336330761;
  isc_gbak_filename_missing             = 336330762;
  isc_gbak_dup_inout_names              = 336330763;
  isc_gbak_inv_page_size                = 336330764;
  isc_gbak_db_specified                 = 336330765;
  isc_gbak_db_exists                    = 336330766;
  isc_gbak_unk_device                   = 336330767;
  isc_gbak_blob_info_failed             = 336330772;
  isc_gbak_unk_blob_item                = 336330773;
  isc_gbak_get_seg_failed               = 336330774;
  isc_gbak_close_blob_failed            = 336330775;
  isc_gbak_open_blob_failed             = 336330776;
  isc_gbak_put_blr_gen_id_failed        = 336330777;
  isc_gbak_unk_type                     = 336330778;
  isc_gbak_comp_req_failed              = 336330779;
  isc_gbak_start_req_failed             = 336330780;
  isc_gbak_rec_failed                   = 336330781;
  isc_gbak_rel_req_failed               = 336330782;
  isc_gbak_db_info_failed               = 336330783;
  isc_gbak_no_db_desc                   = 336330784;
  isc_gbak_db_create_failed             = 336330785;
  isc_gbak_decomp_len_error             = 336330786;
  isc_gbak_tbl_missing                  = 336330787;
  isc_gbak_blob_col_missing             = 336330788;
  isc_gbak_create_blob_failed           = 336330789;
  isc_gbak_put_seg_failed               = 336330790;
  isc_gbak_rec_len_exp                  = 336330791;
  isc_gbak_inv_rec_len                  = 336330792;
  isc_gbak_exp_data_type                = 336330793;
  isc_gbak_gen_id_failed                = 336330794;
  isc_gbak_unk_rec_type                 = 336330795;
  isc_gbak_inv_bkup_ver                 = 336330796;
  isc_gbak_missing_bkup_desc            = 336330797;
  isc_gbak_string_trunc                 = 336330798;
  isc_gbak_cant_rest_record             = 336330799;
  isc_gbak_send_failed                  = 336330800;
  isc_gbak_no_tbl_name                  = 336330801;
  isc_gbak_unexp_eof                    = 336330802;
  isc_gbak_db_format_too_old            = 336330803;
  isc_gbak_inv_array_dim                = 336330804;
  isc_gbak_xdr_len_expected             = 336330807;
  isc_gbak_open_bkup_error              = 336330817;
  isc_gbak_open_error                   = 336330818;
  isc_gbak_missing_block_fac            = 336330934;
  isc_gbak_inv_block_fac                = 336330935;
  isc_gbak_block_fac_specified          = 336330936;
  isc_gbak_missing_username             = 336330940;
  isc_gbak_missing_password             = 336330941;
  isc_gbak_missing_skipped_bytes        = 336330952;
  isc_gbak_inv_skipped_bytes            = 336330953;
  isc_gbak_err_restore_charset          = 336330965;
  isc_gbak_err_restore_collation        = 336330967;
  isc_gbak_read_error                   = 336330972;
  isc_gbak_write_error                  = 336330973;
  isc_gbak_db_in_use                    = 336330985;
  isc_gbak_sysmemex                     = 336330990;
  isc_gbak_restore_role_failed          = 336331002;
  isc_gbak_role_op_missing              = 336331005;
  isc_gbak_page_buffers_missing         = 336331010;
  isc_gbak_page_buffers_wrong_param     = 336331011;
  isc_gbak_page_buffers_restore         = 336331012;
  isc_gbak_inv_size                     = 336331014;
  isc_gbak_file_outof_sequence          = 336331015;
  isc_gbak_join_file_missing            = 336331016;
  isc_gbak_stdin_not_supptd             = 336331017;
  isc_gbak_stdout_not_supptd            = 336331018;
  isc_gbak_bkup_corrupt                 = 336331019;
  isc_gbak_unk_db_file_spec             = 336331020;
  isc_gbak_hdr_write_failed             = 336331021;
  isc_gbak_disk_space_ex                = 336331022;
  isc_gbak_size_lt_min                  = 336331023;
  isc_gbak_svc_name_missing             = 336331025;
  isc_gbak_not_ownr                     = 336331026;
  isc_gbak_mode_req                     = 336331031;

  // FB102 OR YF867
  isc_gbak_just_data                    = 336331033;
  isc_gbak_data_only                    = 336331034;

  // FB150
  isc_dsql_tableview_not_found          = 336068783;

  // FB20
  isc_dsql_too_old_ods                 = 336397205;
  isc_dsql_table_not_found             = 336397206;
  isc_dsql_view_not_found              = 336397207;
  isc_dsql_line_col_error              = 336397208;
  isc_dsql_unknown_pos                 = 336397209;
  isc_dsql_no_dup_name                 = 336397210;
  isc_dsql_too_many_values             = 336397211;

  // IB71
  isc_gbak_validate_restore             = 336331034;

  isc_gsec_cant_open_db                 = 336723983;
  isc_gsec_switches_error               = 336723984;
  isc_gsec_no_op_spec                   = 336723985;
  isc_gsec_no_usr_name                  = 336723986;
  isc_gsec_err_add                      = 336723987;
  isc_gsec_err_modify                   = 336723988;
  isc_gsec_err_find_mod                 = 336723989;
  isc_gsec_err_rec_not_found            = 336723990;
  isc_gsec_err_delete                   = 336723991;
  isc_gsec_err_find_del                 = 336723992;
  isc_gsec_err_find_disp                = 336723996;
  isc_gsec_inv_param                    = 336723997;
  isc_gsec_op_specified                 = 336723998;
  isc_gsec_pw_specified                 = 336723999;
  isc_gsec_uid_specified                = 336724000;
  isc_gsec_gid_specified                = 336724001;
  isc_gsec_proj_specified               = 336724002;
  isc_gsec_org_specified                = 336724003;
  isc_gsec_fname_specified              = 336724004;
  isc_gsec_mname_specified              = 336724005;
  isc_gsec_lname_specified              = 336724006;
  isc_gsec_inv_switch                   = 336724008;
  isc_gsec_amb_switch                   = 336724009;
  isc_gsec_no_op_specified              = 336724010;
  isc_gsec_params_not_allowed           = 336724011;
  isc_gsec_incompat_switch              = 336724012;
  isc_gsec_inv_username                 = 336724044;
  isc_gsec_inv_pw_length                = 336724045;
  isc_gsec_db_specified                 = 336724046;
  isc_gsec_db_admin_specified           = 336724047;
  isc_gsec_db_admin_pw_specified        = 336724048;
  isc_gsec_sql_role_specified           = 336724049;
  isc_license_no_file                   = 336789504;
  isc_license_op_specified              = 336789523;
  isc_license_op_missing                = 336789524;
  isc_license_inv_switch                = 336789525;
  isc_license_inv_switch_combo          = 336789526;
  isc_license_inv_op_combo              = 336789527;
  isc_license_amb_switch                = 336789528;
  isc_license_inv_parameter             = 336789529;
  isc_license_param_specified           = 336789530;
  isc_license_param_req                 = 336789531;
  isc_license_syntx_error               = 336789532;
  isc_license_dup_id                    = 336789534;
  isc_license_inv_id_key                = 336789535;
  isc_license_err_remove                = 336789536;
  isc_license_err_update                = 336789537;
  isc_license_err_convert               = 336789538;
  isc_license_err_unk                   = 336789539;
  isc_license_svc_err_add               = 336789540;
  isc_license_svc_err_remove            = 336789541;
  isc_license_eval_exists               = 336789563;
  // IB7
  isc_smp_cpu_license                   = 336789570;
  isc_node_locked_full_unlimited_serve  = 336789571;
  isc_dev_only_full_server_licenses     = 336789572;

  // IB75
  isc_license_not_registered           = 336789573;
  isc_license_library_unloadable       = 336789574;
  isc_license_registration_file        = 336789575;
  isc_license_expire_limit             = 336789576;
  isc_license_bad_reg_file             = 336789577;
  isc_license_bad_lic_file             = 336789578;

  isc_gstat_unknown_switch              = 336920577;
  isc_gstat_retry                       = 336920578;
  isc_gstat_wrong_ods                   = 336920579;
  isc_gstat_unexpected_eof              = 336920580;
  isc_gstat_open_err                    = 336920605;
  isc_gstat_read_err                    = 336920606;
  isc_gstat_sysmemex                    = 336920607;

  // ---------------------------------------------------------------------------
  // OSRI database functions
  // ---------------------------------------------------------------------------
{$IFDEF FireDAC_IB_STATIC}

const
{$IFDEF FireDAC_IB_STATIC_IBBRAND}
  {$IF DEFINED(IOS) and (DEFINED(CPUARM) or DEFINED(CPUARM64))}
  C_FD_IBLib = 'libibtogo.a';
  C_FD_IBLib_DEP = 'stdc++';
  {$ENDIF}
  {$IF DEFINED(ANDROID)}
  C_FD_IBLib = 'libibtogo.a';
  {$ENDIF}
{$ENDIF}

  function BLOB_close(Stream: PBStream): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function BLOB_display(blob_id: PISC_QUAD; database: isc_db_handle; transaction: isc_tr_handle;
    field_name: PISC_SCHAR): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function BLOB_dump(blob_id: PISC_QUAD; database: isc_db_handle; transaction: isc_tr_handle;
    file_name: PISC_SCHAR): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function BLOB_edit(blob_id: PISC_QUAD; database: isc_db_handle; transaction: isc_tr_handle;
    field_name: PISC_SCHAR): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function BLOB_get(Stream: PBStream): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function BLOB_load(blob_id: PISC_QUAD; database: isc_db_handle; transaction: isc_tr_handle;
    file_name: PISC_SCHAR): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function BLOB_open(blob: isc_blob_handle; buffer: PISC_SCHAR;
    length: Integer): PBStream; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function BLOB_put(x: ISC_SCHAR; Stream: PBStream): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function BLOB_text_dump(blob_id: PISC_QUAD; database: isc_db_handle; transaction: isc_tr_handle;
    file_name: PISC_SCHAR): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function BLOB_text_load(blob_id: PISC_QUAD; database: isc_db_handle; transaction: isc_tr_handle;
    file_name: PISC_SCHAR): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function Bopen(blob_id: PISC_QUAD; database: isc_db_handle; transaction: isc_tr_handle;
    mode: PISC_SCHAR): PBStream; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  // FB >= 2.0 returns ISC_STATUS, others - Integer
  function isc_add_user(status: PISC_STATUS; user_data: PUSER_SEC_DATA): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_array_gen_sdl(status: PISC_STATUS; desc: PISC_ARRAY_DESC_V1; sdl_buffer_length: PISC_SHORT;
    sdl_buffer: PISC_UCHAR; sdl_length: PISC_SHORT): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_array_get_slice(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; array_id: PISC_QUAD; desc: PISC_ARRAY_DESC_V1; array_: Pointer;
    slice_length: PISC_LONG): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_array_lookup_bounds(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; relation_name, field_name: PISC_SCHAR;
    desc: PISC_ARRAY_DESC_V1): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_array_lookup_desc(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; relation_name, field_name: PISC_SCHAR;
    desc: PISC_ARRAY_DESC_V1): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_array_put_slice(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; array_id: PISC_QUAD; desc: PISC_ARRAY_DESC_V1; array_: Pointer;
    slice_length: PISC_LONG): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_array_set_desc(status: PISC_STATUS; relation_name, field_name: PISC_SCHAR;
    sql_dtype, sql_length, dimensions: PSmallint; desc: PISC_ARRAY_DESC_V1):
      ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_array_gen_sdl2(status: PISC_STATUS; desc: PISC_ARRAY_DESC_V2; sdl_buffer_length: PISC_SHORT;
    sdl_buffer: PISC_UCHAR; sdl_length: PISC_SHORT): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_array_get_slice2(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; array_id: PISC_QUAD; desc: PISC_ARRAY_DESC_V2; array_: Pointer;
    slice_length: PISC_LONG): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_array_lookup_bounds2(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; relation_name, field_name: PISC_SCHAR;
    desc: PISC_ARRAY_DESC_V2): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_array_lookup_desc2(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; relation_name, field_name: PISC_SCHAR;
    desc: PISC_ARRAY_DESC_V2): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_array_put_slice2(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; array_id: PISC_QUAD; desc: PISC_ARRAY_DESC_V2; array_: Pointer;
    slice_length: PISC_LONG): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_array_set_desc2(status: PISC_STATUS; relation_name, field_name: PISC_SCHAR;
    sql_dtype, sql_length, dimensions: PSmallint; desc: PISC_ARRAY_DESC_V2):
      ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_attach_database(user_status: PISC_STATUS; file_length: Smallint;
    file_name: PISC_SCHAR; handle: Pisc_db_handle; dpb_length: Smallint;
    dpb: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib
    {$IF DEFINED(CPUARM)} dependency LibCPP {$IF DEFINED(IOS)}, C_FD_IBLib_DEP {$ENDIF} {$ENDIF};
  procedure isc_blob_default_desc(desc: PISC_BLOB_DESC; relation_name,
    field_name: PISC_UCHAR); {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_blob_gen_bpb(status: PISC_STATUS; to_desc, from_desc: PISC_BLOB_DESC;
    bpb_buffer_length: Word; bpb_buffer: PISC_UCHAR; var bpb_length: Word):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_blob_info(user_status: PISC_STATUS; blob_handle: Pisc_blob_handle;
    item_length: Smallint; items: PISC_SCHAR; buffer_length: Smallint; buffer: PISC_SCHAR):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_blob_lookup_desc(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; relation_name, field_name: PISC_UCHAR; desc: PISC_BLOB_DESC;
    global: PISC_UCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_blob_set_desc(status: PISC_STATUS; relation_name, field_name: PISC_UCHAR;
    subtype, charset, segment_size: Smallint; desc: PISC_BLOB_DESC): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_cancel_blob(user_status: PISC_STATUS; blob_handle: Pisc_blob_handle):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_cancel_events(user_status: PISC_STATUS; handle: Pisc_db_handle;
    id: PISC_LONG): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_close(user_status: PISC_STATUS; name: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_close_blob(user_status: PISC_STATUS;
    blob_handle: Pisc_blob_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_commit_retaining(user_status: PISC_STATUS;
    tra_handle: Pisc_tr_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_commit_transaction(user_status: PISC_STATUS;
    tra_handle: Pisc_tr_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_compile_request(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    req_handle: Pisc_req_handle; blr_length: Smallint; blr: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_compile_request2(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    req_handle: Pisc_req_handle; blr_length: Smallint; blr: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_create_blob(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; blob_handle: Pisc_blob_handle; blob_id: PISC_QUAD):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_create_blob2(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; blob_handle: Pisc_blob_handle; blob_id: PISC_QUAD;
    bpb_length: Smallint; bpb: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_create_database(user_status: PISC_STATUS; file_length: Smallint;
    file_name: PISC_SCHAR; handle: Pisc_db_handle; dpb_length: Smallint; dpb: PISC_SCHAR;
    db_type: Smallint): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_database_info(user_status: PISC_STATUS; handle: Pisc_db_handle;
    item_length: Smallint; items: PISC_SCHAR; buffer_length: Smallint;
    buffer: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_ddl(user_status: PISC_STATUS; db_handle: Pisc_db_handle; tra_handle: Pisc_tr_handle;
    length: Smallint; ddl: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_declare(user_status: PISC_STATUS; statement, cursor: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure isc_decode_date(date: PISC_QUAD; times_arg: PCTimeStructure);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure isc_decode_sql_date(date: PISC_DATE; times_arg: PCTimeStructure);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure isc_decode_sql_time(sql_time: PISC_TIME; times_arg: PCTimeStructure);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure isc_decode_timestamp(date: PISC_TIMESTAMP; times_arg: PCTimeStructure);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  // FB >= 2.0 returns ISC_STATUS, others - Integer
  function isc_delete_user(status: PISC_STATUS; user_data: PUSER_SEC_DATA): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_describe(user_status: PISC_STATUS; name: PISC_SCHAR;
    sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_describe_bind(user_status: PISC_STATUS; name: PISC_SCHAR;
    sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_detach_database(user_status: PISC_STATUS;
    handle: Pisc_db_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_drop_database(user_status: PISC_STATUS; handle: Pisc_db_handle):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_alloc_statement2(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    stmt_handle: Pisc_stmt_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_allocate_statement(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    stmt_handle: Pisc_stmt_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_describe(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_describe_bind(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_exec_immed2(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; length: Word; statement: PISC_SCHAR; dialect: Word;
    in_sqlda, out_sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_exec_immed3_m(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; Length: Word; statement: PISC_SCHAR; dialect, in_blr_length: Word;
    in_blr: PISC_SCHAR; in_msg_type, in_msg_length: Word; in_msg: PISC_SCHAR; out_blr_length: Word;
    out_blr: PISC_SCHAR; out_msg_type, out_msg_length: Word; out_msg: PISC_SCHAR):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_execute(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    stmt_handle: Pisc_stmt_handle; dialect: Word; sqlda: PXSQLDA):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_execute_immediate(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; length: Word; statement: PISC_SCHAR; dialect: Word;
    sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_execute_immediate_m(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; length: Word; statement: PISC_SCHAR; dialect, blr_length: Word;
    blr: PISC_SCHAR; msg_type, msg_length: Word; msg: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_execute_m(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    stmt_handle: Pisc_stmt_handle; blr_length: Word; blr: PISC_SCHAR; msg_type, msg_length: Word;
    msg: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_execute2(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    stmt_handle: Pisc_stmt_handle; dialect: Word; in_sqlda, out_sqlda: PXSQLDA):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_execute2_m(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    stmt_handle: Pisc_stmt_handle; in_blr_length: Word; in_blr: PISC_SCHAR; in_msg_type,
    in_msg_length: Word; in_msg: PISC_SCHAR; out_blr_length: Word; out_blr: PISC_SCHAR;
    out_msg_type, out_msg_length: Word; out_msg: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_fetch(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_fetch_m(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    blr_length: Word; blr: PISC_SCHAR; msg_type, msg_length: Word; msg: PISC_SCHAR):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_finish(db_handle: Pisc_db_handle): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_free_statement(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    option: Word): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_insert(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_insert_m(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    blr_length: Word; blr: PISC_SCHAR; msg_type, msg_length: Word; msg: PISC_SCHAR):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_prepare(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    stmt_handle: Pisc_stmt_handle; length: Word; string_: PISC_SCHAR; dialect: Word;
    sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_prepare_m(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    stmt_handle: Pisc_stmt_handle; length: Word; string_: PISC_SCHAR; dialect, item_length: Word;
    items: PISC_SCHAR; buffer_length: Word; buffer: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_release(user_status: PISC_STATUS; name: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_set_cursor_name(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    cursor: PISC_SCHAR; type_: Word): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_sql_info(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    item_length: Smallint; items: PISC_SCHAR; buffer_length: Smallint; buffer: PISC_SCHAR):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_embed_dsql_close(user_status: PISC_STATUS; name: PISC_SCHAR):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_embed_dsql_declare(user_status: PISC_STATUS;
    stmt_name, cursor: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_embed_dsql_describe(user_status: PISC_STATUS; stmt_name: PISC_SCHAR;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_embed_dsql_describe_bind(user_status: PISC_STATUS; stmt_name: PISC_SCHAR;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_embed_dsql_execute(user_status: PISC_STATUS; trans_handle: Pisc_tr_handle;
    stmt_name: PISC_SCHAR; dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_embed_dsql_execute_immed(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; length: Word; string_: PISC_SCHAR; dialect: Word;
    sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_embed_dsql_execute2(user_status: PISC_STATUS; trans_handle: Pisc_tr_handle;
    stmt_name: PISC_SCHAR; dialect: Word; in_sqlda, out_sqlda: PXSQLDA): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_embed_dsql_fetch(user_status: PISC_STATUS; cursor_name: PISC_SCHAR;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_embed_dsql_insert(user_status: PISC_STATUS; cursor_name: PISC_SCHAR;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_embed_dsql_open(user_status: PISC_STATUS; trans_handle: Pisc_tr_handle;
    cursor_name: PISC_SCHAR; dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_embed_dsql_open2(user_status: PISC_STATUS; trans_handle: Pisc_tr_handle;
    cursor_name: PISC_SCHAR; dialect: Word; in_sqlda, out_sqlda: PXSQLDA): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_embed_dsql_prepare(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; stmt_name: PISC_SCHAR; length: Word; string_: PISC_SCHAR;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_embed_dsql_release(user_status: PISC_STATUS;
    stmt_name: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure isc_encode_date(times_arg: PCTimeStructure; date: PISC_QUAD);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure isc_encode_sql_date(times_arg: PCTimeStructure; date: PISC_DATE);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure isc_encode_sql_time(times_arg: PCTimeStructure; time: PISC_TIME);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure isc_encode_timestamp(times_arg: PCTimeStructure;
    timestamp: PISC_TIMESTAMP); {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_event_block(var event_buffer, result_buffer: PISC_UCHAR;
    count: ISC_USHORT): ISC_LONG; varargs; cdecl; external C_FD_IBLib;
  procedure isc_event_counts(event_counts: PISC_ULONG; buffer_length: ISC_SHORT;
    event_buffer, result_buffer: PISC_UCHAR); {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_execute(user_status: PISC_STATUS; trans_handle: Pisc_tr_handle;
    name: PISC_SCHAR; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_execute_immediate(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; length: PSmallint; string_: PISC_SCHAR):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure isc_expand_dpb(dpb: PPISC_SCHAR; dpb_size: PSmallint; name_buffer: PPISC_SCHAR); cdecl; external C_FD_IBLib;
  function isc_fetch(user_status: PISC_STATUS; name: PISC_SCHAR; sqlda: PXSQLDA):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_free(blk: Pointer): ISC_LONG; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_ftof(string_: PISC_SCHAR; length1: Word; field: PISC_SCHAR;
    length2: Word): ISC_LONG; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_get_segment(user_status: PISC_STATUS; blob_handle: Pisc_blob_handle; var length: Word;
    buffer_length: Word; buffer: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_get_slice(user_status: PISC_STATUS; db_handle: Pisc_db_handle; tra_handle: Pisc_tr_handle;
    array_id: PISC_QUAD; sdl_length: Smallint; sdl: PISC_SCHAR; param_length: Smallint; param: PISC_LONG;
    slice_length: ISC_LONG; slice: Pointer; return_length: PISC_LONG): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  // FB >= 2.0 returns ISC_LONG, others - ISC_STATUS
  function isc_interprete(buffer: PISC_SCHAR; var status_vector: PISC_STATUS):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_modify_dpb(dpb: PPISC_SCHAR; dpb_length: PSmallint; type_: Word;
    str: PISC_SCHAR; str_len: Smallint): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  // FB >= 2.0 returns ISC_STATUS, others - Integer
  function isc_modify_user(status: PISC_STATUS;
    user_data: PUSER_SEC_DATA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_open(user_status: PISC_STATUS; trans_handle: Pisc_tr_handle; name: PISC_SCHAR;
    sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_open_blob(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; blob_handle: Pisc_blob_handle;
    blob_id: PISC_QUAD): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_open_blob2(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; blob_handle: Pisc_blob_handle; blob_id: PISC_QUAD; bpb_length: ISC_USHORT;
    bpb: PISC_UCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_portable_integer(ptr: PISC_UCHAR; length: Smallint): ISC_INT64;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_prepare(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; name: PISC_SCHAR; length: PSmallint; string_: PISC_SCHAR;
    sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_prepare_transaction(user_status: PISC_STATUS;
    tra_handle: Pisc_tr_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_prepare_transaction2(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    msg_length: ISC_USHORT; msg: PISC_UCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_print_blr(blr: PISC_SCHAR; callback: isc_callback; callback_argument: Pointer;
    language: Smallint): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure isc_print_sqlerror(sqlcode: ISC_SHORT; status_vector: PISC_STATUS);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_print_status(status_vector: PISC_STATUS): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_put_segment(user_status: PISC_STATUS; blob_handle: Pisc_blob_handle;
    buffer_length: Word; buffer: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_put_slice(user_status: PISC_STATUS; db_handle: Pisc_db_handle; tra_handle: Pisc_tr_handle;
    array_id: PISC_QUAD; sdl_length: Smallint; sdl: PISC_SCHAR; param_length: Smallint; param: PISC_LONG;
    slice_length: ISC_LONG; slice: Pointer): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure isc_qtoq(quad1, quad2: PISC_QUAD); {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_que_events(user_status: PISC_STATUS; handle: Pisc_db_handle; id: PISC_LONG;
    length: Smallint; events: PISC_UCHAR; ast: isc_callback; arg: Pointer):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_receive(user_status: PISC_STATUS; req_handle: Pisc_req_handle; msg_type,
    msg_length: Smallint; msg: Pointer; level: Smallint): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_reconnect_transaction(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; length: Smallint; id: PISC_SHORT): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_release_request(user_status: PISC_STATUS;
    req_handle: Pisc_req_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_request_info(user_status: PISC_STATUS; req_handle: Pisc_req_handle; level,
    item_length: Smallint; items: PISC_SCHAR; buffer_length: Smallint;
    buffer: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_rollback_retaining(status_vector: PISC_STATUS;
    trans_handle: Pisc_tr_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_rollback_transaction(user_status: PISC_STATUS;
    tra_handle: Pisc_tr_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_seek_blob(user_status: PISC_STATUS; blob_handle: Pisc_blob_handle; mode: Smallint;
    offset: ISC_LONG; Result_: PISC_LONG): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_send(user_status: PISC_STATUS; req_handle: Pisc_req_handle; msg_type,
    msg_length: Smallint; msg: Pointer; level: Smallint):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_service_attach(status_vector: PISC_STATUS; service_length: Word;
    service_name: PISC_SCHAR; handle: Pisc_svc_handle; spb_length: Word;
    spb: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib
    {$IF DEFINED(CPUARM)} dependency LibCPP {$IF DEFINED(IOS)}, C_FD_IBLib_DEP {$ENDIF} {$ENDIF};
  function isc_service_detach(status_vector: PISC_STATUS;
    handle: Pisc_svc_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_service_query(status_vector: PISC_STATUS; svc_handle: Pisc_svc_handle;
    reserved: Pisc_resv_handle; send_spb_length: Word; send_spb: PISC_SCHAR; request_spb_length: Word;
    request_spb: PISC_SCHAR; buffer_length: Word; buffer: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_service_start(status_vector: PISC_STATUS; svc_handle: Pisc_svc_handle;
    reserved: Pisc_resv_handle; spb_length: Word; spb: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure isc_set_debug(flag: Integer); {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure isc_sql_interprete(SQLCODE: Smallint; buffer: PISC_SCHAR;
    buffer_length: Smallint); {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_sqlcode(user_status: PISC_STATUS): ISC_LONG; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_start_and_send(user_status: PISC_STATUS; req_handle: Pisc_req_handle;
    tra_handle: Pisc_tr_handle; msg_type, msg_length: Smallint; msg: Pointer;
    level: Smallint): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_start_multiple(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    count: Smallint; vector: PISCTEB): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_start_request(user_status: PISC_STATUS; req_handle: Pisc_req_handle;
    tra_handle: Pisc_tr_handle; level: Smallint): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_start_transaction(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    count: Smallint; db_handle: Pisc_db_handle; tpb_length: ISC_USHORT; tpb_ad: PISC_SCHAR): ISC_STATUS; cdecl; external C_FD_IBLib;
  function isc_transact_request(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; blr_length: Word; blr: PISC_SCHAR; in_msg_length: Word; in_msg: PISC_SCHAR;
    out_msg_length: Word; out_msg: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_transaction_info(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    item_length: Smallint; items: PISC_SCHAR; buffer_length: Smallint;
    buffer: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_unwind_request(user_status: PISC_STATUS; req_handle: Pisc_tr_handle;
    level: Smallint): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_vax_integer(ptr: PISC_SCHAR; length: Smallint): ISC_LONG;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_version(db_handle: Pisc_db_handle; callback: isc_callback;
    callback_argument: Pointer): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure isc_vtof(string1, string2: PISC_SCHAR; length: Word);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure isc_vtov(string1, string2: PISC_SCHAR; length: Smallint);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_wait_for_event(user_status: PISC_STATUS; handle: Pisc_db_handle;
    length: Smallint; events, buffer: PISC_UCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_reset_fpe(fpe_status: ISC_USHORT): ISC_LONG; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure isc_get_client_version(version: PISC_SCHAR); {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_get_client_major_version: Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_get_client_minor_version: Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_release_savepoint(status: PISC_STATUS; TrHandle: Pisc_tr_handle;
    name: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_rollback_savepoint(status: PISC_STATUS; TrHandle: Pisc_tr_handle;
    name: PISC_SCHAR; Option: Word): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_start_savepoint(status: PISC_STATUS; TrHandle: Pisc_tr_handle;
    name: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function isc_dsql_batch_execute(status: PISC_STATUS; TrHandle: Pisc_tr_handle;
    stmt_handle: Pisc_stmt_handle; dialect: Word; insqlda: PXSQLDA; number_of_rows: Word;
    batch_vars: PXSQLVAR_V2; rows_affected: PISC_ULONG): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
{$IFDEF FireDAC_IB_STATIC_FBBRAND}
  function fb_interpret(buffer: PISC_SCHAR; v: Cardinal; var status_vector: PISC_STATUS):
    ISC_LONG; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  procedure fb_sqlstate(sqlstate: PISC_SCHAR; status_vector: PISC_STATUS);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function fb_cancel_operation(status: PISC_STATUS; db_handle: Pisc_db_handle;
    options: ISC_USHORT): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function fb_shutdown(timeout: Cardinal; reason: Integer): Integer;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function fb_shutdown_callback(status: PISC_STATUS; callback_function: FB_SHUTDOWN_CALLBACK_FUNC;
    mask: Integer; arg: Pointer): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function fb_ping(status: PISC_STATUS; db_handle: Pisc_db_handle): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function fb_get_database_handle(status: PISC_STATUS; db_handle: Pisc_db_handle;
    data: Pointer): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
  function fb_get_transaction_handle(status: PISC_STATUS; tr_handle: Pisc_tr_handle;
    data: Pointer): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF}; external C_FD_IBLib;
{$ENDIF}
{$ENDIF}

type
  TBLOB_close = function(Stream: PBStream): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  TBLOB_display = function(blob_id: PISC_QUAD; database: isc_db_handle; transaction: isc_tr_handle;
    field_name: PISC_SCHAR): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  TBLOB_dump = function(blob_id: PISC_QUAD; database: isc_db_handle; transaction: isc_tr_handle;
    file_name: PISC_SCHAR): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  TBLOB_edit = function(blob_id: PISC_QUAD; database: isc_db_handle; transaction: isc_tr_handle;
    field_name: PISC_SCHAR): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  TBLOB_get = function(Stream: PBStream): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  TBLOB_load = function(blob_id: PISC_QUAD; database: isc_db_handle; transaction: isc_tr_handle;
    file_name: PISC_SCHAR): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  TBLOB_open = function(blob: isc_blob_handle; buffer: PISC_SCHAR;
    length: Integer): PBStream; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  TBLOB_put = function(x: ISC_SCHAR; Stream: PBStream): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  TBLOB_text_dump = function(blob_id: PISC_QUAD; database: isc_db_handle; transaction: isc_tr_handle;
    file_name: PISC_SCHAR): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  TBLOB_text_load = function(blob_id: PISC_QUAD; database: isc_db_handle; transaction: isc_tr_handle;
    file_name: PISC_SCHAR): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  TBopen = function(blob_id: PISC_QUAD; database: isc_db_handle; transaction: isc_tr_handle;
    mode: PISC_SCHAR): PBStream; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  // FB >= 2.0 returns ISC_STATUS, others - Integer
  Tisc_add_user = function(status: PISC_STATUS; user_data: PUSER_SEC_DATA): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_array_gen_sdl = function(status: PISC_STATUS; desc: PISC_ARRAY_DESC_V1; sdl_buffer_length: PISC_SHORT;
    sdl_buffer: PISC_UCHAR; sdl_length: PISC_SHORT): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_array_get_slice = function(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; array_id: PISC_QUAD; desc: PISC_ARRAY_DESC_V1; array_: Pointer;
    slice_length: PISC_LONG): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_array_lookup_bounds = function(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; relation_name, field_name: PISC_SCHAR;
    desc: PISC_ARRAY_DESC_V1): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_array_lookup_desc = function(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; relation_name, field_name: PISC_SCHAR;
    desc: PISC_ARRAY_DESC_V1): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_array_put_slice = function(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; array_id: PISC_QUAD; desc: PISC_ARRAY_DESC_V1; array_: Pointer;
    slice_length: PISC_LONG): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_array_set_desc = function(status: PISC_STATUS; relation_name, field_name: PISC_SCHAR;
    sql_dtype, sql_length, dimensions: PSmallint; desc: PISC_ARRAY_DESC_V1):
      ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_array_gen_sdl2 = function(status: PISC_STATUS; desc: PISC_ARRAY_DESC_V2; sdl_buffer_length: PISC_SHORT;
    sdl_buffer: PISC_UCHAR; sdl_length: PISC_SHORT): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_array_get_slice2 = function(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; array_id: PISC_QUAD; desc: PISC_ARRAY_DESC_V2; array_: Pointer;
    slice_length: PISC_LONG): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_array_lookup_bounds2 = function(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; relation_name, field_name: PISC_SCHAR;
    desc: PISC_ARRAY_DESC_V2): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_array_lookup_desc2 = function(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; relation_name, field_name: PISC_SCHAR;
    desc: PISC_ARRAY_DESC_V2): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_array_put_slice2 = function(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; array_id: PISC_QUAD; desc: PISC_ARRAY_DESC_V2; array_: Pointer;
    slice_length: PISC_LONG): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_array_set_desc2 = function(status: PISC_STATUS; relation_name, field_name: PISC_SCHAR;
    sql_dtype, sql_length, dimensions: PSmallint; desc: PISC_ARRAY_DESC_V2):
      ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_attach_database = function(user_status: PISC_STATUS; file_length: Smallint;
    file_name: PISC_SCHAR; handle: Pisc_db_handle; dpb_length: Smallint;
    dpb: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_blob_default_desc = procedure(desc: PISC_BLOB_DESC; relation_name,
    field_name: PISC_UCHAR); {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_blob_gen_bpb = function(status: PISC_STATUS; to_desc, from_desc: PISC_BLOB_DESC;
    bpb_buffer_length: Word; bpb_buffer: PISC_UCHAR; var bpb_length: Word):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_blob_info = function(user_status: PISC_STATUS; blob_handle: Pisc_blob_handle;
    item_length: Smallint; items: PISC_SCHAR; buffer_length: Smallint; buffer: PISC_SCHAR):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_blob_lookup_desc = function(status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; relation_name, field_name: PISC_UCHAR; desc: PISC_BLOB_DESC;
    global: PISC_UCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_blob_set_desc = function(status: PISC_STATUS; relation_name, field_name: PISC_UCHAR;
    subtype, charset, segment_size: Smallint; desc: PISC_BLOB_DESC): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_cancel_blob = function(user_status: PISC_STATUS; blob_handle: Pisc_blob_handle):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_cancel_events = function(user_status: PISC_STATUS; handle: Pisc_db_handle;
    id: PISC_LONG): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_close = function(user_status: PISC_STATUS; name: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_close_blob = function(user_status: PISC_STATUS;
    blob_handle: Pisc_blob_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_commit_retaining = function(user_status: PISC_STATUS;
    tra_handle: Pisc_tr_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_commit_transaction = function(user_status: PISC_STATUS;
    tra_handle: Pisc_tr_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_compile_request = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    req_handle: Pisc_req_handle; blr_length: Smallint; blr: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_compile_request2 = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    req_handle: Pisc_req_handle; blr_length: Smallint; blr: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_create_blob = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; blob_handle: Pisc_blob_handle; blob_id: PISC_QUAD):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_create_blob2 = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; blob_handle: Pisc_blob_handle; blob_id: PISC_QUAD;
    bpb_length: Smallint; bpb: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_create_database = function(user_status: PISC_STATUS; file_length: Smallint;
    file_name: PISC_SCHAR; handle: Pisc_db_handle; dpb_length: Smallint; dpb: PISC_SCHAR;
    db_type: Smallint): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_database_info = function(user_status: PISC_STATUS; handle: Pisc_db_handle;
    item_length: Smallint; items: PISC_SCHAR; buffer_length: Smallint;
    buffer: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_ddl = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle; tra_handle: Pisc_tr_handle;
    length: Smallint; ddl: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_declare = function(user_status: PISC_STATUS; statement, cursor: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_decode_date = procedure(date: PISC_QUAD; times_arg: PCTimeStructure);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_decode_sql_date = procedure(date: PISC_DATE; times_arg: PCTimeStructure);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_decode_sql_time = procedure(sql_time: PISC_TIME; times_arg: PCTimeStructure);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_decode_timestamp = procedure(date: PISC_TIMESTAMP; times_arg: PCTimeStructure);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  // FB >= 2.0 returns ISC_STATUS, others - Integer
  Tisc_delete_user = function(status: PISC_STATUS; user_data: PUSER_SEC_DATA): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_describe = function(user_status: PISC_STATUS; name: PISC_SCHAR;
    sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_describe_bind = function(user_status: PISC_STATUS; name: PISC_SCHAR;
    sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_detach_database = function(user_status: PISC_STATUS;
    handle: Pisc_db_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_drop_database = function(user_status: PISC_STATUS; handle: Pisc_db_handle):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_alloc_statement2 = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    stmt_handle: Pisc_stmt_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_allocate_statement = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    stmt_handle: Pisc_stmt_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_describe = function(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_describe_bind = function(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_exec_immed2 = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; length: Word; statement: PISC_SCHAR; dialect: Word;
    in_sqlda, out_sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_exec_immed3_m = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; Length: Word; statement: PISC_SCHAR; dialect, in_blr_length: Word;
    in_blr: PISC_SCHAR; in_msg_type, in_msg_length: Word; in_msg: PISC_SCHAR; out_blr_length: Word;
    out_blr: PISC_SCHAR; out_msg_type, out_msg_length: Word; out_msg: PISC_SCHAR):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_execute = function(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    stmt_handle: Pisc_stmt_handle; dialect: Word; sqlda: PXSQLDA):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_execute_immediate = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; length: Word; statement: PISC_SCHAR; dialect: Word;
    sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_execute_immediate_m = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; length: Word; statement: PISC_SCHAR; dialect, blr_length: Word;
    blr: PISC_SCHAR; msg_type, msg_length: Word; msg: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_execute_m = function(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    stmt_handle: Pisc_stmt_handle; blr_length: Word; blr: PISC_SCHAR; msg_type, msg_length: Word;
    msg: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_execute2 = function(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    stmt_handle: Pisc_stmt_handle; dialect: Word; in_sqlda, out_sqlda: PXSQLDA):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_execute2_m = function(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    stmt_handle: Pisc_stmt_handle; in_blr_length: Word; in_blr: PISC_SCHAR; in_msg_type,
    in_msg_length: Word; in_msg: PISC_SCHAR; out_blr_length: Word; out_blr: PISC_SCHAR;
    out_msg_type, out_msg_length: Word; out_msg: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_fetch = function(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_fetch_m = function(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    blr_length: Word; blr: PISC_SCHAR; msg_type, msg_length: Word; msg: PISC_SCHAR):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_finish = function(db_handle: Pisc_db_handle): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_free_statement = function(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    option: Word): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_insert = function(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_insert_m = function(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    blr_length: Word; blr: PISC_SCHAR; msg_type, msg_length: Word; msg: PISC_SCHAR):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_prepare = function(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    stmt_handle: Pisc_stmt_handle; length: Word; string_: PISC_SCHAR; dialect: Word;
    sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_prepare_m = function(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    stmt_handle: Pisc_stmt_handle; length: Word; string_: PISC_SCHAR; dialect, item_length: Word;
    items: PISC_SCHAR; buffer_length: Word; buffer: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_release = function(user_status: PISC_STATUS; name: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_set_cursor_name = function(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    cursor: PISC_SCHAR; type_: Word): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_sql_info = function(user_status: PISC_STATUS; stmt_handle: Pisc_stmt_handle;
    item_length: Smallint; items: PISC_SCHAR; buffer_length: Smallint; buffer: PISC_SCHAR):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_embed_dsql_close = function(user_status: PISC_STATUS; name: PISC_SCHAR):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_embed_dsql_declare = function(user_status: PISC_STATUS;
    stmt_name, cursor: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_embed_dsql_describe = function(user_status: PISC_STATUS; stmt_name: PISC_SCHAR;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_embed_dsql_describe_bind = function(user_status: PISC_STATUS; stmt_name: PISC_SCHAR;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_embed_dsql_execute = function(user_status: PISC_STATUS; trans_handle: Pisc_tr_handle;
    stmt_name: PISC_SCHAR; dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_embed_dsql_execute_immed = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; length: Word; string_: PISC_SCHAR; dialect: Word;
    sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_embed_dsql_execute2 = function(user_status: PISC_STATUS; trans_handle: Pisc_tr_handle;
    stmt_name: PISC_SCHAR; dialect: Word; in_sqlda, out_sqlda: PXSQLDA): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_embed_dsql_fetch = function(user_status: PISC_STATUS; cursor_name: PISC_SCHAR;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_embed_dsql_insert = function(user_status: PISC_STATUS; cursor_name: PISC_SCHAR;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_embed_dsql_open = function(user_status: PISC_STATUS; trans_handle: Pisc_tr_handle;
    cursor_name: PISC_SCHAR; dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_embed_dsql_open2 = function(user_status: PISC_STATUS; trans_handle: Pisc_tr_handle;
    cursor_name: PISC_SCHAR; dialect: Word; in_sqlda, out_sqlda: PXSQLDA): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_embed_dsql_prepare = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; stmt_name: PISC_SCHAR; length: Word; string_: PISC_SCHAR;
    dialect: Word; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_embed_dsql_release = function(user_status: PISC_STATUS;
    stmt_name: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_encode_date = procedure(times_arg: PCTimeStructure; date: PISC_QUAD);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_encode_sql_date = procedure(times_arg: PCTimeStructure; date: PISC_DATE);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_encode_sql_time = procedure(times_arg: PCTimeStructure; time: PISC_TIME);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_encode_timestamp = procedure(times_arg: PCTimeStructure;
    timestamp: PISC_TIMESTAMP); {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_event_block = function(var event_buffer, result_buffer: PISC_UCHAR; count: ISC_USHORT;
    v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15: PISC_UCHAR): ISC_LONG; cdecl;
  Tisc_event_counts = procedure(ser_status: PISC_STATUS; buffer_length: ISC_SHORT;
    event_buffer, result_buffer: PISC_UCHAR); {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_execute = function(user_status: PISC_STATUS; trans_handle: Pisc_tr_handle;
    name: PISC_SCHAR; sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_execute_immediate = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; length: PSmallint; string_: PISC_SCHAR):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_expand_dpb = procedure(dpb: PPISC_SCHAR; dpb_size: PSmallint; name_buffer: PPISC_SCHAR); cdecl;
  Tisc_fetch = function(user_status: PISC_STATUS; name: PISC_SCHAR; sqlda: PXSQLDA):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_free = function(blk: Pointer): ISC_LONG; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_ftof = function(string_: PISC_SCHAR; length1: Word; field: PISC_SCHAR;
    length2: Word): ISC_LONG; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_get_segment = function(user_status: PISC_STATUS; blob_handle: Pisc_blob_handle; var length: Word;
    buffer_length: Word; buffer: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_get_slice = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle; tra_handle: Pisc_tr_handle;
    array_id: PISC_QUAD; sdl_length: Smallint; sdl: PISC_SCHAR; param_length: Smallint; param: PISC_LONG;
    slice_length: ISC_LONG; slice: Pointer; return_length: PISC_LONG): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  // FB >= 2.0 returns ISC_LONG, others - ISC_STATUS
  Tisc_interprete = function(buffer: PISC_SCHAR; var status_vector: PISC_STATUS):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tfb_interpret = function(buffer: PISC_SCHAR; v: Cardinal; var status_vector: PISC_STATUS):
    ISC_LONG; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_modify_dpb = function(dpb: PPISC_SCHAR; dpb_length: PSmallint; type_: Word;
    str: PISC_SCHAR; str_len: Smallint): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  // FB >= 2.0 returns ISC_STATUS, others - Integer
  Tisc_modify_user = function(status: PISC_STATUS;
    user_data: PUSER_SEC_DATA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_open = function(user_status: PISC_STATUS; trans_handle: Pisc_tr_handle; name: PISC_SCHAR;
    sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_open_blob = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; blob_handle: Pisc_blob_handle;
    blob_id: PISC_QUAD): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_open_blob2 = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; blob_handle: Pisc_blob_handle; blob_id: PISC_QUAD; bpb_length: ISC_USHORT;
    bpb: PISC_UCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_portable_integer = function(ptr: PISC_UCHAR; length: Smallint): ISC_INT64;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_prepare = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    trans_handle: Pisc_tr_handle; name: PISC_SCHAR; length: PSmallint; string_: PISC_SCHAR;
    sqlda: PXSQLDA): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_prepare_transaction = function(user_status: PISC_STATUS;
    tra_handle: Pisc_tr_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_prepare_transaction2 = function(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    msg_length: ISC_USHORT; msg: PISC_UCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_print_blr = function(blr: PISC_SCHAR; callback: isc_callback; callback_argument: Pointer;
    language: Smallint): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_print_sqlerror = procedure(sqlcode: ISC_SHORT; status_vector: PISC_STATUS);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_print_status = function(status_vector: PISC_STATUS): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_put_segment = function(user_status: PISC_STATUS; blob_handle: Pisc_blob_handle;
    buffer_length: Word; buffer: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_put_slice = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle; tra_handle: Pisc_tr_handle;
    array_id: PISC_QUAD; sdl_length: Smallint; sdl: PISC_SCHAR; param_length: Smallint; param: PISC_LONG;
    slice_length: ISC_LONG; slice: Pointer): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_qtoq = procedure(quad1, quad2: PISC_QUAD); {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_que_events = function(user_status: PISC_STATUS; handle: Pisc_db_handle; id: PISC_LONG;
    length: Smallint; events: PISC_UCHAR; ast: isc_callback; arg: Pointer):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_receive = function(user_status: PISC_STATUS; req_handle: Pisc_req_handle; msg_type,
    msg_length: Smallint; msg: Pointer; level: Smallint): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_reconnect_transaction = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; length: Smallint; id: PISC_SHORT): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_release_request = function(user_status: PISC_STATUS;
    req_handle: Pisc_req_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_request_info = function(user_status: PISC_STATUS; req_handle: Pisc_req_handle; level,
    item_length: Smallint; items: PISC_SCHAR; buffer_length: Smallint;
    buffer: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_rollback_retaining = function(status_vector: PISC_STATUS;
    trans_handle: Pisc_tr_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_rollback_transaction = function(user_status: PISC_STATUS;
    tra_handle: Pisc_tr_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_seek_blob = function(user_status: PISC_STATUS; blob_handle: Pisc_blob_handle; mode: Smallint;
    offset: ISC_LONG; Result_: PISC_LONG): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_send = function(user_status: PISC_STATUS; req_handle: Pisc_req_handle; msg_type,
    msg_length: Smallint; msg: Pointer; level: Smallint):
    ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_service_attach = function(status_vector: PISC_STATUS; service_length: Word;
    service_name: PISC_SCHAR; handle: Pisc_svc_handle; spb_length: Word;
    spb: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_service_detach = function(status_vector: PISC_STATUS;
    handle: Pisc_svc_handle): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_service_query = function(status_vector: PISC_STATUS; svc_handle: Pisc_svc_handle;
    reserved: Pisc_resv_handle; send_spb_length: Word; send_spb: PISC_SCHAR; request_spb_length: Word;
    request_spb: PISC_SCHAR; buffer_length: Word; buffer: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_service_start = function(status_vector: PISC_STATUS; svc_handle: Pisc_svc_handle;
    reserved: Pisc_resv_handle; spb_length: Word; spb: PISC_SCHAR): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_set_debug = procedure(flag: Integer); {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_sql_interprete = procedure(SQLCODE: Smallint; buffer: PISC_SCHAR;
    buffer_length: Smallint); {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_sqlcode = function(user_status: PISC_STATUS): ISC_LONG; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_start_and_send = function(user_status: PISC_STATUS; req_handle: Pisc_req_handle;
    tra_handle: Pisc_tr_handle; msg_type, msg_length: Smallint; msg: Pointer;
    level: Smallint): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_start_multiple = function(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    count: Smallint; vector: PISCTEB): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_start_request = function(user_status: PISC_STATUS; req_handle: Pisc_req_handle;
    tra_handle: Pisc_tr_handle; level: Smallint): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_start_transaction = function(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    count: Smallint; db_handle: Pisc_db_handle; tpb_length: ISC_USHORT; tpb_ad: PISC_SCHAR): ISC_STATUS; cdecl;
  Tisc_transact_request = function(user_status: PISC_STATUS; db_handle: Pisc_db_handle;
    tra_handle: Pisc_tr_handle; blr_length: Word; blr: PISC_SCHAR; in_msg_length: Word; in_msg: PISC_SCHAR;
    out_msg_length: Word; out_msg: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_transaction_info = function(user_status: PISC_STATUS; tra_handle: Pisc_tr_handle;
    item_length: Smallint; items: PISC_SCHAR; buffer_length: Smallint;
    buffer: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_unwind_request = function(user_status: PISC_STATUS; req_handle: Pisc_tr_handle;
    level: Smallint): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_vax_integer = function(ptr: PISC_SCHAR; length: Smallint): ISC_LONG;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_version = function(db_handle: Pisc_db_handle; callback: isc_callback;
    callback_argument: Pointer): Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_vtof = procedure(string1, string2: PISC_SCHAR; length: Word);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_vtov = procedure(string1, string2: PISC_SCHAR; length: Smallint);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_wait_for_event = function(user_status: PISC_STATUS; handle: Pisc_db_handle;
    length: Smallint; events, buffer: PISC_UCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_reset_fpe = function(fpe_status: ISC_USHORT): ISC_LONG; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_get_client_version = procedure(version: PISC_SCHAR); {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_get_client_major_version = function: Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_get_client_minor_version = function: Integer; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_release_savepoint = function(status: PISC_STATUS; TrHandle: Pisc_tr_handle;
    name: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_rollback_savepoint = function(status: PISC_STATUS; TrHandle: Pisc_tr_handle;
    name: PISC_SCHAR; Option: Word): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_start_savepoint = function(status: PISC_STATUS; TrHandle: Pisc_tr_handle;
    name: PISC_SCHAR): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tisc_dsql_batch_execute = function(status: PISC_STATUS; TrHandle: Pisc_tr_handle;
    stmt_handle: Pisc_stmt_handle; dialect: Word; insqlda: PXSQLDA; number_of_rows: Word;
    batch_vars: PXSQLVAR_V2; rows_affected: PISC_ULONG): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tfb_sqlstate = procedure (sqlstate: PISC_SCHAR; status_vector: PISC_STATUS);
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tfb_cancel_operation = function(status: PISC_STATUS; db_handle: Pisc_db_handle;
    options: ISC_USHORT): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tfb_shutdown = function(timeout: Cardinal; reason: Integer): Integer;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tfb_shutdown_callback = function (status: PISC_STATUS; callback_function: FB_SHUTDOWN_CALLBACK_FUNC;
    mask: Integer; arg: Pointer): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tfb_ping = function(status: PISC_STATUS; db_handle: Pisc_db_handle): ISC_STATUS;
    {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tfb_get_database_handle = function (status: PISC_STATUS; db_handle: Pisc_db_handle;
    data: Pointer): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};
  Tfb_get_transaction_handle = function (status: PISC_STATUS; tr_handle: Pisc_tr_handle;
    data: Pointer): ISC_STATUS; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  function GETB(p: PBSTREAM; bg: TBLOB_get): ISC_SCHAR;
  function PUTB(x: ISC_SCHAR; p: PBSTREAM; bp: TBLOB_put): Integer;
  function PUTBX(x: ISC_SCHAR; p: PBSTREAM; bp: TBLOB_put): Integer;

implementation

{$IFDEF FireDAC_IB_STATIC}
  {$IFDEF MSWINDOWS}
uses
  System.Win.Crtl;
  {$ENDIF}
{$ENDIF}

{-------------------------------------------------------------------------------}
function XSQLDA_LENGTH_V1(n: Integer): Integer;
begin
  Result := SizeOf(XSQLDA_V1) + ((n - 1) * SizeOf(XSQLVAR_V1));
end;

{-------------------------------------------------------------------------------}
function XSQLDA_LENGTH_V2(n: Integer): Integer;
begin
  Result := SizeOf(XSQLDA_V2) + ((n - 1) * SizeOf(XSQLVAR_V2));
end;

{-------------------------------------------------------------------------------}
function XSQLVAR_LENGTH(num_rows, num_vars: Integer): Integer;
begin
  Result := SizeOf(XSQLVAR_V2) * num_rows * num_vars;
end;

{-------------------------------------------------------------------------------}
procedure ADD_SPB_LENGTH(var p: PISC_UCHAR; length: Integer);
begin
  p^ := ISC_UCHAR(length);
  Inc(p);
  p^ := ISC_UCHAR(length shr 8);
  Inc(p);
end;

{-------------------------------------------------------------------------------}
procedure ADD_SPB_NUMERIC(var p: PISC_UCHAR; data: Integer);
begin
  p^ := ISC_UCHAR(data);
  Inc(p);
  p^ := ISC_UCHAR(data shr 8);
  Inc(p);
  p^ := ISC_UCHAR(data shr 16);
  Inc(p);
  p^ := ISC_UCHAR(data shr 24);
  Inc(p);
end;

{-------------------------------------------------------------------------------}
function GETB(p: PBSTREAM; bg: TBLOB_get): ISC_SCHAR;
begin
  Dec(p^.bstr_cnt);
  if p^.bstr_cnt >= 0 then begin
    Result := p^.bstr_ptr^ and $FF;
    Inc(p^.bstr_ptr);
  end
  else
    Result := bg(p);
end;

{-------------------------------------------------------------------------------}
function PUTB(x: ISC_SCHAR; p: PBSTREAM; bp: TBLOB_put): Integer;
var
  lBP: Boolean;
begin
  if x = ISC_SCHAR(#10) then
    lBP := True
  else begin
    Dec(p^.bstr_cnt);
    lBP := p^.bstr_cnt = 0;
  end;
  if lBP then
    Result := bp(x, p)
  else begin
    p^.bstr_ptr^ := x;
    Inc(p^.bstr_ptr);
    Result := x;
  end;
end;

{-------------------------------------------------------------------------------}
function PUTBX(x: ISC_SCHAR; p: PBSTREAM; bp: TBLOB_put): Integer;
begin
  Dec(p^.bstr_cnt);
  if p^.bstr_cnt = 0 then
    Result := bp(x, p)
  else begin
    p^.bstr_ptr^ := x;
    Inc(p^.bstr_ptr);
    Result := x;
  end;
end;

end.

