{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{    FireDAC InterBase/Firebird API wrapping classes    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.IBWrapper;

interface

uses
  System.Classes, System.SyncObjs, Data.SqlTimSt,
  FireDAC.Stan.Intf, FireDAC.Stan.Error, FireDAC.Stan.Option, FireDAC.Stan.Util,
    FireDAC.Stan.Consts,
  FireDAC.DatS,
  FireDAC.Phys.IBCli, FireDAC.Phys.IBMeta;

type
  TIBLib = class;
  TIBObject = class;
  TFDIBError = class;
  EIBNativeException = class;
  TIBError = class;
  TIBPBWriter = class;
  TIBPBReader = class;
  TIBEnv = class;
  TIBDatabase = class;
  TIBTransaction = class;
  TIBEvents = class;
  TIBVariable = class;
  TIBVariables = class;
  TIBBlob = class;
  TIBBlobStream = class;
  TIBArray = class;
  TIBStatement = class;
  TIBService = class;
  TIBBackup = class;
  TIBRestore = class;
  TFBNBackup = class;
  TIBSDump = class;
  TFBNRestore = class;
  TIBRepair = class;
  TIBTrace = class;
  TIBSecurity = class;
  TIBConfig = class;
  TIBInfo = class;

  TIBProtocol = (ipLocal, ipTCPIP, ipNetBEUI, ipSPX);
  TIBCharacterSet = (csNONE, csASCII, csBIG_5, csCYRL, csDOS437, csDOS850, csDOS852, csDOS857, csDOS860, csDOS861, csDOS863, csDOS865, csEUCJ_0208, csGB_2312, csISO8859_1, csISO8859_2, csKSC_5601, csNEXT, csOCTETS, csSJIS_0208, csUNICODE_FSS, csWIN1250, csWIN1251, csWIN1252, csWIN1253, csWIN1254, csDOS737, csDOS775, csDOS858, csDOS862, csDOS864, csDOS866, csDOS869, csWIN1255, csWIN1256, csWIN1257, csISO8859_3, csISO8859_4, csISO8859_5, csISO8859_6, csISO8859_7, csISO8859_8, csISO8859_9, csISO8859_13, csISO8859_15, csKOI8R, csKOI8U, csUTF8, csUNICODE_LE, csUNICODE_BE);
  TIBOpenMode = (omOpen, omCreate, omOpenOrCreate);
  TIBPageSize = (ps1024, ps2048, ps4096, ps8192, ps16384);
  TIBUpdateStatus = set of (iuModified, iuUpdated, iuInserted, iuDeleted);

  TIBLib = class(TFDLibrary)
  private
    FLock: TCriticalSection;
    function GetIDUTF8: Integer;
    procedure LoadBase(const AVendorHome, AVendorLib: String
      {$IFNDEF FireDAC_IB_STATIC} ; const ALibNames: array of String {$ENDIF});

  protected
    procedure LoadEntries; override;
    procedure GetLibraryInfo; override;

  public
    FBrand: TFDPhysIBBrand;
    FEmbedded: Boolean;

    FBLOB_get: TBLOB_get;
    FBLOB_put: TBLOB_put;
    Fisc_add_user: Tisc_add_user;
    Fisc_array_gen_sdl: Tisc_array_gen_sdl;
    Fisc_array_get_slice: Tisc_array_get_slice;
    Fisc_array_lookup_bounds: Tisc_array_lookup_bounds;
    Fisc_array_lookup_desc: Tisc_array_lookup_desc;
    Fisc_array_put_slice: Tisc_array_put_slice;
    Fisc_array_set_desc: Tisc_array_set_desc;
    Fisc_array_gen_sdl2: Tisc_array_gen_sdl2;
    Fisc_array_get_slice2: Tisc_array_get_slice2;
    Fisc_array_lookup_bounds2: Tisc_array_lookup_bounds2;
    Fisc_array_lookup_desc2: Tisc_array_lookup_desc2;
    Fisc_array_put_slice2: Tisc_array_put_slice2;
    Fisc_array_set_desc2: Tisc_array_set_desc2;
    Fisc_attach_database: Tisc_attach_database;
    Fisc_blob_default_desc: Tisc_blob_default_desc;
    Fisc_blob_gen_bpb: Tisc_blob_gen_bpb;
    Fisc_blob_info: Tisc_blob_info;
    Fisc_blob_lookup_desc: Tisc_blob_lookup_desc;
    Fisc_blob_set_desc: Tisc_blob_set_desc;
    Fisc_cancel_blob: Tisc_cancel_blob;
    Fisc_cancel_events: Tisc_cancel_events;
    Fisc_close: Tisc_close;
    Fisc_close_blob: Tisc_close_blob;
    Fisc_commit_retaining: Tisc_commit_retaining;
    Fisc_commit_transaction: Tisc_commit_transaction;
    Fisc_compile_request: Tisc_compile_request;
    Fisc_compile_request2: Tisc_compile_request2;
    Fisc_create_blob: Tisc_create_blob;
    Fisc_create_blob2: Tisc_create_blob2;
    Fisc_create_database: Tisc_create_database;
    Fisc_database_info: Tisc_database_info;
    Fisc_ddl: Tisc_ddl;
    Fisc_declare: Tisc_declare;
    Fisc_decode_date: Tisc_decode_date;
    Fisc_decode_sql_date: Tisc_decode_sql_date;
    Fisc_decode_sql_time: Tisc_decode_sql_time;
    Fisc_decode_timestamp: Tisc_decode_timestamp;
    Fisc_delete_user: Tisc_delete_user;
    Fisc_describe: Tisc_describe;
    Fisc_describe_bind: Tisc_describe_bind;
    Fisc_detach_database: Tisc_detach_database;
    Fisc_drop_database: Tisc_drop_database;
    Fisc_dsql_alloc_statement2: Tisc_dsql_alloc_statement2;
    Fisc_dsql_allocate_statement: Tisc_dsql_allocate_statement;
    Fisc_dsql_describe: Tisc_dsql_describe;
    Fisc_dsql_describe_bind: Tisc_dsql_describe_bind;
    Fisc_dsql_exec_immed2: Tisc_dsql_exec_immed2;
    Fisc_dsql_exec_immed3_m: Tisc_dsql_exec_immed3_m;
    Fisc_dsql_execute: Tisc_dsql_execute;
    Fisc_dsql_execute_immediate: Tisc_dsql_execute_immediate;
    Fisc_dsql_execute_immediate_m: Tisc_dsql_execute_immediate_m;
    Fisc_dsql_execute_m: Tisc_dsql_execute_m;
    Fisc_dsql_execute2: Tisc_dsql_execute2;
    Fisc_dsql_execute2_m: Tisc_dsql_execute2_m;
    Fisc_dsql_fetch: Tisc_dsql_fetch;
    Fisc_dsql_fetch_m: Tisc_dsql_fetch_m;
    Fisc_dsql_finish: Tisc_dsql_finish;
    Fisc_dsql_free_statement: Tisc_dsql_free_statement;
    Fisc_dsql_insert: Tisc_dsql_insert;
    Fisc_dsql_insert_m: Tisc_dsql_insert_m;
    Fisc_dsql_prepare: Tisc_dsql_prepare;
    Fisc_dsql_prepare_m: Tisc_dsql_prepare_m;
    Fisc_dsql_release: Tisc_dsql_release;
    Fisc_dsql_set_cursor_name: Tisc_dsql_set_cursor_name;
    Fisc_dsql_sql_info: Tisc_dsql_sql_info;
    Fisc_embed_dsql_close: Tisc_embed_dsql_close;
    Fisc_embed_dsql_declare: Tisc_embed_dsql_declare;
    Fisc_embed_dsql_describe: Tisc_embed_dsql_describe;
    Fisc_embed_dsql_describe_bind: Tisc_embed_dsql_describe_bind;
    Fisc_embed_dsql_execute: Tisc_embed_dsql_execute;
    Fisc_embed_dsql_execute_immed: Tisc_embed_dsql_execute_immed;
    Fisc_embed_dsql_execute2: Tisc_embed_dsql_execute2;
    Fisc_embed_dsql_fetch: Tisc_embed_dsql_fetch;
    Fisc_embed_dsql_insert: Tisc_embed_dsql_insert;
    Fisc_embed_dsql_open: Tisc_embed_dsql_open;
    Fisc_embed_dsql_open2: Tisc_embed_dsql_open2;
    Fisc_embed_dsql_prepare: Tisc_embed_dsql_prepare;
    Fisc_embed_dsql_release: Tisc_embed_dsql_release;
    Fisc_encode_date: Tisc_encode_date;
    Fisc_encode_sql_date: Tisc_encode_sql_date;
    Fisc_encode_sql_time: Tisc_encode_sql_time;
    Fisc_encode_timestamp: Tisc_encode_timestamp;
    Fisc_event_block: Tisc_event_block;
    Fisc_event_counts: Tisc_event_counts;
    Fisc_execute: Tisc_execute;
    Fisc_execute_immediate: Tisc_execute_immediate;
    Fisc_expand_dpb: Tisc_expand_dpb;
    Fisc_fetch: Tisc_fetch;
    Fisc_free: Tisc_free;
    Fisc_ftof: Tisc_ftof;
    Fisc_get_segment: Tisc_get_segment;
    Fisc_get_slice: Tisc_get_slice;
    Fisc_interprete: Tisc_interprete;
    Fisc_modify_dpb: Tisc_modify_dpb;
    Fisc_modify_user: Tisc_modify_user;
    Fisc_open: Tisc_open;
    Fisc_open_blob: Tisc_open_blob;
    Fisc_open_blob2: Tisc_open_blob2;
    Fisc_portable_integer: Tisc_portable_integer;
    Fisc_prepare: Tisc_prepare;
    Fisc_prepare_transaction: Tisc_prepare_transaction;
    Fisc_prepare_transaction2: Tisc_prepare_transaction2;
    Fisc_print_blr: Tisc_print_blr;
    Fisc_print_sqlerror: Tisc_print_sqlerror;
    Fisc_print_status: Tisc_print_status;
    Fisc_put_segment: Tisc_put_segment;
    Fisc_put_slice: Tisc_put_slice;
    Fisc_qtoq: Tisc_qtoq;
    Fisc_que_events: Tisc_que_events;
    Fisc_receive: Tisc_receive;
    Fisc_reconnect_transaction: Tisc_reconnect_transaction;
    Fisc_release_request: Tisc_release_request;
    Fisc_request_info: Tisc_request_info;
    Fisc_rollback_retaining: Tisc_rollback_retaining;
    Fisc_rollback_transaction: Tisc_rollback_transaction;
    Fisc_seek_blob: Tisc_seek_blob;
    Fisc_send: Tisc_send;
    Fisc_service_attach: Tisc_service_attach;
    Fisc_service_detach: Tisc_service_detach;
    Fisc_service_query: Tisc_service_query;
    Fisc_service_start: Tisc_service_start;
    Fisc_set_debug: Tisc_set_debug;
    Fisc_sql_interprete: Tisc_sql_interprete;
    Fisc_sqlcode: Tisc_sqlcode;
    Fisc_start_and_send: Tisc_start_and_send;
    Fisc_start_multiple: Tisc_start_multiple;
    Fisc_start_request: Tisc_start_request;
    Fisc_start_transaction: Tisc_start_transaction;
    Fisc_transact_request: Tisc_transact_request;
    Fisc_transaction_info: Tisc_transaction_info;
    Fisc_unwind_request: Tisc_unwind_request;
    Fisc_vax_integer: Tisc_vax_integer;
    Fisc_version: Tisc_version;
    Fisc_vtof: Tisc_vtof;
    Fisc_vtov: Tisc_vtov;
    Fisc_wait_for_event: Tisc_wait_for_event;
    Fisc_reset_fpe: Tisc_reset_fpe;
    Fisc_get_client_version: Tisc_get_client_version;
    Fisc_get_client_major_version: Tisc_get_client_major_version;
    Fisc_get_client_minor_version: Tisc_get_client_minor_version;
    Fisc_release_savepoint: Tisc_release_savepoint;
    Fisc_rollback_savepoint: Tisc_rollback_savepoint;
    Fisc_start_savepoint: Tisc_start_savepoint;
    Ffb_interpret: Tfb_interpret;
    Fisc_dsql_batch_execute: Tisc_dsql_batch_execute;
    Ffb_sqlstate: Tfb_sqlstate;
    Ffb_cancel_operation: Tfb_cancel_operation;
    Ffb_shutdown: Tfb_shutdown;
    Ffb_shutdown_callback: Tfb_shutdown_callback;
    Ffb_ping: Tfb_ping;

    constructor Create(const ADriverID: String = S_FD_IBId; AOwningObj: TObject = nil);
    destructor Destroy; override;
    procedure LoadFB(const AVendorHome, AVendorLib: String; AEmbedded: Boolean);
    procedure LoadIB(const AVendorHome, AVendorLib: String; AEmbedded: Boolean);
    procedure Unload; override;
    procedure Lock;
    procedure Unlock;
    function getb(p: PBStream): ISC_SCHAR;
    function putb(x: ISC_SCHAR; p: PBStream): Integer;
    function putbx(x: ISC_SCHAR; p: PBStream): Integer;
    function IsUTF8(ACSID: Integer): Boolean;
    function GetUTF8CSName(ACSID: Integer): String;
    function GetBytesPerChar(ACSID: Integer): Integer;
    procedure ISCTmSt2DlpTmSt(const AISCTmSt: ISC_TIMESTAMP; var ASQLTmSt: TSQLTimeStamp);
    procedure DlpTmSt2ISCTmSt(const ASQLTmSt: TSQLTimeStamp; var AISCTmSt: ISC_TIMESTAMP);
    procedure ISCDt2DlpDt(const AISCDt: ISC_DATE; var ADt: Integer);
    procedure DlpDt2ISCDt(const ADt: Integer; var AISCDt: ISC_DATE);
    procedure ISCTm2DlpTm(const AISCTm: ISC_TIME; var ATm: Integer);
    procedure DlpTm2ISCTm(const ATm: Integer; var AISCTm: ISC_TIME);
    property Brand: TFDPhysIBBrand read FBrand;
    property IDUTF8: Integer read GetIDUTF8;
  end;

  TIBObject = class(TObject)
  private
    FEnv: TIBEnv;
    [Weak] FOwningObj: TObject;
    function GetError: TIBError; inline;
    function GetLib: TIBLib; inline;
  public
    constructor Create(AEnv: TIBEnv; AOwningObj: TObject);
    procedure Check(AStatus: ISC_STATUS; AInitiator: TObject = nil);
    property Env: TIBEnv read FEnv;
    property Lib: TIBLib read GetLib;
    property Error: TIBError read GetError;
    property OwningObj: TObject read FOwningObj;
  end;

  TFDIBError = class(TFDDBError)
  private
    FExceptionCode: Integer;
    FSQLCode: Integer;
    FLineNo: Integer;
    FColNo: Integer;
    FSQLState: String;
    function GetErrClass: Integer;
    function GetErrCode: Integer;
    function GetFacility: Integer;
  protected
    procedure Assign(ASrc: TFDDBError); override;
    procedure LoadFromStorage(const AStorage: IFDStanStorage); override;
    procedure SaveToStorage(const AStorage: IFDStanStorage); override;
  public
    property ExceptionCode: Integer read FExceptionCode;
    property SQLCode: Integer read FSQLCode;
    property LineNo: Integer read FLineNo;
    property ColNo: Integer read FColNo;
    property Facility: Integer read GetFacility;
    property ErrClass: Integer read GetErrClass;
    property ErrCode: Integer read GetErrCode;
    property SQLState: String read FSQLState;
  end;

  EIBNativeException = class(EFDDBEngineException)
  private
    function GetErrors(AIndex: Integer): TFDIBError; inline;
  protected
    function GetErrorClass: TFDDBErrorClass; override;
  public
    constructor Create(AError: TIBError); overload;
    property Errors[AIndex: Integer]: TFDIBError read GetErrors; default;
  end;

  TIBError = class(TIBObject)
  private
    FStatusVector: TISCStatusVector;
    FStatus: ISC_STATUS;
    FInfo: EFDDBEngineException;
  public
    destructor Destroy; override;
    procedure Check(AStatus: ISC_STATUS; AInitiator: TObject = nil);
    procedure ClearInfo;
    procedure CheckAllocateInfo;
    property Info: EFDDBEngineException read FInfo;
    property Status: ISC_STATUS read FStatus;
  end;

  TIBPBParamType = (
    prNone,     // no param
    prNoneNoZ,  // no param and no zero length byte
    prCard,     // Cardinal Param
    prByte,     // Byte Param
    prStrg,     // String Param
    prIgno      // Ignore Command
  );
  TIBPBInfo = record
    Name: String;
    ParamType: TIBPBParamType;
    Code: Byte;
  end;
  PIBPBInfo = ^TIBPBInfo;
  TIBPBInfoArr = array[1..255] of TIBPBInfo;
  PIBPBInfoArr = ^TIBPBInfoArr;
  TIBPBInfoFilterFunc = function (const AInfo: TIBPBInfo): TIBPBParamType of object;

  TIBPBWriter = class(TObject)
  private
    FLib: TIBLib;
    FEncoder: TFDEncoder;
    FFinalSize,
    FBufferSize: Integer;
    FBuffer: TFDByteString;
    function CheckBufferSize(ABytesToAdd: Integer): PByte;
    function GetAsBlock: TFDByteString;
    function GetAsPByte: PISC_SCHAR;
    function GetLen: SmallInt;
  public
    constructor Create(ALib: TIBLib; AEncoder: TFDEncoder);
    procedure Reset;
    procedure AddByte(AByte: Byte);
    procedure AddCard(ACard: Cardinal);
    procedure AddDWord(ADWord: Cardinal);
    procedure AddShortString(const AString: String);
    procedure AddLongString(const AString: String);
    procedure AddWord(AWord: Word);
    procedure AddParams(AParams: TStrings; ApInfos: PIBPBInfoArr;
      AMaxCode: Byte; AFilter: TIBPBInfoFilterFunc);
    property AsBlock: TFDByteString read GetAsBlock;
    property AsPByte: PISC_SCHAR read GetAsPByte;
    property Len: SmallInt read GetLen;
  end;

  TIBPBReader = class(TObject)
  private
    FLib: TIBLib;
    FEncoder: TFDEncoder;
    FBuffer: TFDByteString;
    FPos: Integer;
    function GetEof: Boolean;
    function GetAsBlock: TFDByteString;
    function GetAsPByte: PISC_SCHAR;
    function GetLen: SmallInt;
  public
    constructor Create(ALib: TIBLib; AEncoder: TFDEncoder);
    procedure Reset(const ABuffer: TFDByteString); overload;
    procedure Reset(ALen: SmallInt); overload;
    function GetByte: Byte;
    function GetWord: Word;
    function GetInteger: Integer;
    function GetLongString: String;
    property Eof: Boolean read GetEof;
    property AsBlock: TFDByteString read GetAsBlock;
    property AsPByte: PISC_SCHAR read GetAsPByte;
    property Len: SmallInt read GetLen;
  end;

  TIBEnv = class(TObject)
  private
    FLib: TIBLib;
    FError: TIBError;
    [Weak] FOwningObj: TObject;
{$IFDEF FireDAC_MONITOR}
    FMonitor: IFDMoniClient;
    FTracing: Boolean;
    function GetTracing: Boolean;
{$ENDIF}
  public
    constructor Create(ALib: TIBLib; AOwningObj: TObject);
    destructor Destroy; override;
    function BuildPB(AEncoder: TFDEncoder; AParams: TStrings; ATypeInfo, AVersion: Byte;
      ApInfos: PIBPBInfoArr; AMaxCode: Byte; AFilter: TIBPBInfoFilterFunc): TFDByteString;
{$IFDEF FireDAC_MONITOR}
    procedure Trace(const AMsg: String; const AArgs: array of const); overload;
    procedure Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
      const AMsg: String; const AArgs: array of const); overload;
    property Tracing: Boolean read GetTracing write FTracing;
    property Monitor: IFDMoniClient read FMonitor write FMonitor;
{$ENDIF}
    property Lib: TIBLib read FLib;
    property Error: TIBError read FError;
    property OwningObj: TObject read FOwningObj;
  end;

  TIBDatabase = class(TIBObject)
  private
    FList: TStrings;
    FOwnHandle: Boolean;
    FBuffer: TFDBuffer;
    FEncoder: TFDEncoder;
    function FilterDBParam(const AInfo: TIBPBInfo): TIBPBParamType;
    procedure GetDatabaseInfo(AInfo: Integer; ABuff: PByte; ASize: Integer);
    function GetDatabaseInfoInt(AInfo: Integer): Integer;
    function GetDatabaseInfoStr(AInfo: Integer): String;
    function GetDatabaseInfoBool(AInfo: Integer): Boolean;
    function GetDatabaseInfoUserNames(AInfo: Integer): TStrings;
    function GetDatabaseInfoOpers(AInfo: Integer): TStrings;
    function GetDatabaseInfoInts(AInfo: Integer): TStrings;
    function GetDatabaseInfoStrsCnt(AInfo: Integer): TStrings;
  public
    FDBHandle: isc_db_handle;
    constructor Create(AEnv: TIBEnv; AOwningObj: TObject);
    constructor CreateUsingHandle(AEnv: TIBEnv; AHandle: isc_db_handle;
      AOwningObj: TObject);
    destructor Destroy; override;
    function Attach(const ADBName: String; AParams: TStrings;
      ARetExists: Boolean): Boolean;
    procedure CreateDatabase(const ADBName: String; AParams: TStrings);
    procedure Detach;
    procedure Cancel;
    procedure Drop;
    procedure Ping;

    property Buffer: TFDBuffer read FBuffer;
    property Encoder: TFDEncoder read FEncoder;

    property db_id: TStrings index isc_info_db_id read GetDatabaseInfoStrsCnt;
    property reads: Integer index isc_info_reads read GetDatabaseInfoInt;
    property writes: Integer index isc_info_writes read GetDatabaseInfoInt;
    property fetches: Integer index isc_info_fetches read GetDatabaseInfoInt;
    property marks: Integer index isc_info_marks read GetDatabaseInfoInt;

    property implementation_: Integer index isc_info_implementation read GetDatabaseInfoInt;
    property isc_version: TStrings index isc_info_isc_version read GetDatabaseInfoStrsCnt;
    property base_level: Integer index isc_info_base_level read GetDatabaseInfoInt;

    property page_size: Integer index isc_info_page_size read GetDatabaseInfoInt;
    property num_buffers: Integer index isc_info_num_buffers read GetDatabaseInfoInt;
    property limbo: TStrings index isc_info_limbo read GetDatabaseInfoInts;
    property current_memory: Integer index isc_info_current_memory read GetDatabaseInfoInt;
    property max_memory: Integer index isc_info_max_memory read GetDatabaseInfoInt;
    property window_turns: Integer index isc_info_window_turns read GetDatabaseInfoInt;
    property license: Integer index isc_info_license read GetDatabaseInfoInt;

    property allocation: Integer index isc_info_allocation read GetDatabaseInfoInt;
    property attachment_id: Integer index isc_info_attachment_id read GetDatabaseInfoInt;
    property read_seq_count: TStrings index isc_info_read_seq_count read GetDatabaseInfoOpers;
    property read_idx_count: TStrings index isc_info_read_idx_count read GetDatabaseInfoOpers;
    property insert_count: TStrings index isc_info_insert_count read GetDatabaseInfoOpers;
    property update_count: TStrings index isc_info_update_count read GetDatabaseInfoOpers;
    property delete_count: TStrings index isc_info_delete_count read GetDatabaseInfoOpers;
    property backout_count: TStrings index isc_info_backout_count read GetDatabaseInfoOpers;
    property purge_count: TStrings index isc_info_purge_count read GetDatabaseInfoOpers;
    property expunge_count: TStrings index isc_info_expunge_count read GetDatabaseInfoOpers;

    property sweep_interval: Integer index isc_info_sweep_interval read GetDatabaseInfoInt;
    property ods_version: Integer index isc_info_ods_version read GetDatabaseInfoInt;
    property ods_minor_version: Integer index isc_info_ods_minor_version read GetDatabaseInfoInt;
    property no_reserve: Boolean index isc_info_no_reserve read GetDatabaseInfoBool;
    property logfile: String index isc_info_logfile read GetDatabaseInfoStr;
    property cur_logfile_name: String index isc_info_cur_logfile_name read GetDatabaseInfoStr;
    property cur_log_part_offset: Integer index isc_info_cur_log_part_offset read GetDatabaseInfoInt;
    property num_wal_buffers: Integer index isc_info_num_wal_buffers read GetDatabaseInfoInt;
    property wal_buffer_size: Integer index isc_info_wal_buffer_size read GetDatabaseInfoInt;
    property wal_ckpt_length: Integer index isc_info_wal_ckpt_length read GetDatabaseInfoInt;

    property wal_cur_ckpt_interval: Integer index isc_info_wal_cur_ckpt_interval read GetDatabaseInfoInt;
    property wal_prv_ckpt_fname: Integer index isc_info_wal_prv_ckpt_fname read GetDatabaseInfoInt;
    property wal_prv_ckpt_poffset: Integer index isc_info_wal_prv_ckpt_poffset read GetDatabaseInfoInt;
    property wal_recv_ckpt_fname: String index isc_info_wal_recv_ckpt_fname read GetDatabaseInfoStr;
    property wal_recv_ckpt_poffset: Integer index isc_info_wal_recv_ckpt_poffset read GetDatabaseInfoInt;
    property wal_grpc_wait_usecs: Integer index isc_info_wal_grpc_wait_usecs read GetDatabaseInfoInt;
    property wal_num_io: Integer index isc_info_wal_num_io read GetDatabaseInfoInt;
    property wal_avg_io_size: Integer index isc_info_wal_avg_io_size read GetDatabaseInfoInt;
    property wal_num_commits: Integer index isc_info_wal_num_commits read GetDatabaseInfoInt;

    property wal_avg_grpc_size: Integer index isc_info_wal_avg_grpc_size read GetDatabaseInfoInt;
    property forced_writes: Boolean index isc_info_forced_writes read GetDatabaseInfoBool;
    property user_names: TStrings index isc_info_user_names read GetDatabaseInfoUserNames;
    property page_errors: Integer index isc_info_page_errors read GetDatabaseInfoInt;
    property record_errors: Integer index isc_info_record_errors read GetDatabaseInfoInt;
    property bpage_errors: Integer index isc_info_bpage_errors read GetDatabaseInfoInt;
    property dpage_errors: Integer index isc_info_dpage_errors read GetDatabaseInfoInt;
    property ipage_errors: Integer index isc_info_ipage_errors read GetDatabaseInfoInt;
    property ppage_errors: Integer index isc_info_ppage_errors read GetDatabaseInfoInt;
    property tpage_errors: Integer index isc_info_tpage_errors read GetDatabaseInfoInt;

    property set_page_buffers: Integer index isc_info_set_page_buffers read GetDatabaseInfoInt;
    property db_sql_dialect: Integer index isc_info_db_sql_dialect read GetDatabaseInfoInt;
    property db_read_only: Boolean index isc_info_db_read_only read GetDatabaseInfoBool;
    property db_size_in_pages: Integer index isc_info_db_size_in_pages read GetDatabaseInfoInt;
    // IB70
    property db_reads: Integer index isc_info_db_reads read GetDatabaseInfoInt;
    property db_writes: Integer index isc_info_db_writes read GetDatabaseInfoInt;
    property db_fetches: Integer index isc_info_db_fetches read GetDatabaseInfoInt;
    property db_marks: Integer index isc_info_db_marks read GetDatabaseInfoInt;
    property db_group_commit: Boolean index isc_info_db_group_commit read GetDatabaseInfoBool;
    // IB71
    property att_charset: Integer index isc_info_att_charset read GetDatabaseInfoInt;
    property svr_min_ver: Integer index isc_info_svr_min_ver read GetDatabaseInfoInt;
    // IB75
    property ib_env_var: Integer index isc_info_ib_env_var read GetDatabaseInfoInt;
    property server_tcp_port: Integer index isc_info_server_tcp_port read GetDatabaseInfoInt;
    // IBXE
    property db_encrypted: Integer index isc_info_db_encrypted read GetDatabaseInfoInt;
    // IBXE3
    property db_eua_active: Integer index isc_info_db_eua_active read GetDatabaseInfoInt;
    // FB102 OR YF867
    property att_charset2: Integer index frb_info_att_charset read GetDatabaseInfoInt;
    property db_class: Integer index isc_info_db_class read GetDatabaseInfoInt;
    property firebird_version: TStrings index isc_info_firebird_version read GetDatabaseInfoStrsCnt;
    property oldest_transaction: Integer index isc_info_oldest_transaction read GetDatabaseInfoInt;
    property oldest_active: Integer index isc_info_oldest_active read GetDatabaseInfoInt;
    property oldest_snapshot: Integer index isc_info_oldest_snapshot read GetDatabaseInfoInt;
    property next_transaction: Integer index isc_info_next_transaction read GetDatabaseInfoInt;
    property db_provider: Integer index isc_info_db_provider read GetDatabaseInfoInt;
    property active_transactions: TStrings index isc_info_active_transactions read GetDatabaseInfoInts;
  end;

  TIBTransaction = class(TIBObject)
  private
    FEncoder: TFDEncoder;
    FDatabases: TFDObjList;
    FTPB: TFDByteString;
    FTEBs: array of TISCTEB;
    FParams: TStrings;
    FChanged: Boolean;
    FOwnHandle: Boolean;
    function FilterTRParam(const AInfo: TIBPBInfo): TIBPBParamType;
    procedure Update;
    procedure SetParams(const AValue: TStrings);
    procedure DoParamsChanged(ASender: TObject);
    function GetTransactionID: Int64;
  public
    FTRHandle: isc_tr_handle;
    constructor Create(AEnv: TIBEnv; AOwningObj: TObject);
    constructor CreateUsingHandle(AEnv: TIBEnv; AHandle: isc_tr_handle;
      AOwningObj: TObject);
    destructor Destroy; override;
    procedure AddDatabase(ADB: TIBDatabase);
    procedure RemoveDatabase(ADB: TIBDatabase);
    procedure StartTransaction();
    procedure Commit();
    procedure Rollback();
    procedure CommitRetaining();
    procedure RollbackRetaining();
    procedure Prepare(const AMsg: String);
    property Params: TStrings read FParams write SetParams;
    property TransactionID: Int64 read GetTransactionID;
  end;

  TIBEventSlice = class(TObject)
  private
    FEvents: TIBEvents;
    FEventBuffer,
    FResultBuffer: PISC_UCHAR;
    FBufferLength: ISC_LONG;
    FEventsID: ISC_LONG;
    FSysAlert: Boolean;
    FStatusVector: TISCEventCounts;
    FBaseIndex: Integer;
    FEvent: TEvent;
    FThread: TThread;
  end;

  TIBEventsOnFired = procedure (AEvents: TIBEvents; ABaseIndex: Integer;
    const ACounts: TISCEventCounts) of Object;
  TIBEvents = class(TIBObject)
  private
    FDatabase: TIBDatabase;
    FNames: TStrings;
    FOnFired: TIBEventsOnFired;
    FSlices: TFDObjList;
    procedure QueueEvents(ASlice: TIBEventSlice);
    procedure HandleEvents(ASlice: TIBEventSlice);
  public
    constructor Create(ADatabase: TIBDatabase; AOwningObj: TObject);
    destructor Destroy; override;
    procedure Start;
    procedure Stop;
    property Names: TStrings read FNames;
    property OnFired: TIBEventsOnFired read FOnFired write FOnFired;
  end;

  TIBVariable = class(TIBObject)
  private
    FVars: TIBVariables;
    FDataSize: LongWord;
    FIndex: LongWord;
    FDumpLabel: String;
    FFDDataType: TFDDataType;
    function GetIsNulls(ARowIndex: LongWord): Boolean;
    function GetSQLDataType: Smallint;
    procedure SetSQLDataType(const AValue: Smallint);
    function GetAsString: String;
    function GetDumpLabel: String;
    function Getaliasname: String;
    function Getownname: String;
    function Getrelname: String;
    function Getsqllen: Smallint;
    function Getsqlname: String;
    function Getsqlscale: Smallint;
    function Getsqlsubtype: Smallint;
    function Getsqltype: Smallint;
    procedure Setsqllen(const AValue: Smallint);
    procedure Setsqlscale(const AValue: Smallint);
    procedure Setsqlsubtype(const AValue: Smallint);
    procedure Setsqltype(const AValue: Smallint);
    function Getsqlprecision: Smallint;
    procedure Setsqlprecision(const AValue: Smallint);
    function GetBaseXSQLVarV1: PXSQLVAR_V1;
    function GetBaseXSQLVarV2: PXSQLVAR_V2;
    function GetBindSize: LongWord;
    function GetDataXSQLVarV1(ARowIndex: LongWord): PXSQLVAR_V1;
    function GetDataXSQLVarV2(ARowIndex: LongWord): PXSQLVAR_V2;
    function GetIsNullable: Boolean;
    procedure SetIsNullable(const AValue: Boolean);
    function GetDataSize: LongWord;
    procedure LayoutChanged;
    function GetNational: Boolean;
    function Decode(const ASrc: Pointer; ASrcLen: Integer): String; inline;
    function GetUpdates(ARowIndex: LongWord): TIBUpdateStatus;
  protected
    property BaseXSQLVarV2: PXSQLVAR_V2 read GetBaseXSQLVarV2;
    property BaseXSQLVarV1: PXSQLVAR_V1 read GetBaseXSQLVarV1;
    property DataXSQLVarV2[ARowIndex: LongWord]: PXSQLVAR_V2 read GetDataXSQLVarV2;
    property DataXSQLVarV1[ARowIndex: LongWord]: PXSQLVAR_V1 read GetDataXSQLVarV1;
  public
    constructor Create(AVars: TIBVariables);
    destructor Destroy; override;
    // base
    function GetData(ARowIndex: LongWord; var ApData: Pointer; out ALen: LongWord;
      AByRef: Boolean = False): Boolean; overload;
    procedure SetData(ARowIndex: LongWord; ApData: Pointer; ALen: LongWord); overload;
    // helpers
    class function GetDataTypeSize(AType: Smallint; ASize: LongWord): LongWord;
    function GetData(var AData; out ALen: LongWord): Boolean; overload; inline;
    function GetData(var AData): Boolean; overload; inline;
    procedure SetData(const AData; ALen: LongWord = 0); overload; inline;
{$IFDEF FireDAC_MONITOR}
    function DumpValue(ARowIndex: LongWord): String;
    function DumpSQLDataType: String;
{$ENDIF}
    // properties
    // RO
    property IsNulls[ARowIndex: LongWord]: Boolean read GetIsNulls;
    property Updates[ARowIndex: LongWord]: TIBUpdateStatus read GetUpdates;
    property BindSize: LongWord read GetBindSize;
    property sqlname: String read Getsqlname;
    property relname: String read Getrelname;
    property ownname: String read Getownname;
    property aliasname: String read Getaliasname;
    property Vars: TIBVariables read FVars;
    property Index: LongWord read FIndex;
    property AsString: String read GetAsString;
    property National: Boolean read GetNational;
    // RW
    property DumpLabel: String read GetDumpLabel write FDumpLabel;
    property DataSize: LongWord read GetDataSize write FDataSize;
    property SQLDataType: Smallint read GetSQLDataType write SetSQLDataType;
    property FDDataType: TFDDataType read FFDDataType write FFDDataType;
    property IsNullable: Boolean read GetIsNullable write SetIsNullable;
    property sqltype: Smallint read Getsqltype write Setsqltype;
    property sqlscale: Smallint read Getsqlscale write Setsqlscale;
    property sqlsubtype: Smallint read Getsqlsubtype write Setsqlsubtype;
    property sqllen: Smallint read Getsqllen write Setsqllen;
    property sqlprecision: Smallint read Getsqlprecision write Setsqlprecision;
  end;

  TIBVariables = class(TIBObject)
  private
    FList: TFDObjList;
    FStatement: TIBStatement;
    FBuff: PByte;
    FBuffSize: Cardinal;
    FRowCount: Word;
    FV2: Boolean;
    function GetVarCount: Smallint; inline;
    procedure SetVarCount(ACount: Smallint);
    function GetItems(AIndex: Cardinal): TIBVariable; inline;
    procedure SetRowCount(AValue: Word);
    function GetBuffSize: Cardinal;
  protected
    procedure AllocateBuff;
    procedure ReleaseBuff;
  public
    FXSQLDA: PXSQLDA_V2;
    FXSQLVAR: PXSQLVAR_V2;
    FRowsAffected: array of ISC_ULONG;
    constructor Create(AStatement: TIBStatement);
    destructor Destroy; override;
    function AdjustCount: Boolean;
    procedure CheckBuff; inline;
    property V2: Boolean read FV2;
    property Statement: TIBStatement read FStatement;
    property BuffSize: Cardinal read GetBuffSize;
    property VarCount: Smallint read GetVarCount write SetVarCount;
    property RowCount: Word read FRowCount write SetRowCount;
    property Items[AIndex: Cardinal]: TIBVariable read GetItems; default;
  end;

                                                    
  TIBBlob = class(TIBObject)
  private
    FDatabase: TIBDatabase;
    FTransaction: TIBTransaction;
    F_type: ISC_USHORT;
    Fnum_segments: ISC_ULONG;
    Fmax_segment: ISC_ULONG;
    Ftotal_length: ISC_ULONG;
    Fsqlsubtype: Smallint;
    procedure GetInfo;
    function GetNational: Boolean;
    function GetIsOpen: Boolean; inline;
  public
    FBLHandle: isc_blob_handle;
    FBlobID: ISC_QUAD;
    constructor Create(ADatabase: TIBDatabase; ATransaction: TIBTransaction;
      AOwningObj: TObject);
    destructor Destroy; override;
    procedure Open;
    procedure Add;
    procedure Close;
    function Read(ABuff: PByte; ABuffLen: LongWord): LongWord;
    procedure Write(ABuff: PByte; ABuffLen: LongWord);

    property num_segments: ISC_ULONG read Fnum_segments;
    property max_segment: ISC_ULONG read Fmax_segment;
    property total_length: ISC_ULONG read Ftotal_length;
    property _type: ISC_USHORT read F_type;

    property sqlsubtype: Smallint read Fsqlsubtype write Fsqlsubtype;

    property IsOpen: Boolean read GetIsOpen;
    property Database: TIBDatabase read FDatabase;
    property Transaction: TIBTransaction read FTransaction;
    property BlobID: ISC_QUAD read FBlobID write FBlobID;
    property National: Boolean read GetNational;
  end;

  TIBBlobStream = class(TStream)
  private
    FBlob: TIBBlob;
    FPosition: Int64;
    function Bytes2Chars(ABytes: LongWord): LongWord;
    function Chars2Bytes(AChars: LongWord): LongWord;
    procedure CheckOpen;
  protected
    function GetSize: Int64; override;
  public
    constructor Create(ABlob: TIBBlob);
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
    property Blob: TIBBlob read FBlob;
  end;

  TIBArray = class(TIBObject)
  private
    FDatabase: TIBDatabase;
    FTransaction: TIBTransaction;
    FVer: ISC_SHORT;
    FV1_sqlsubtype: ISC_UCHAR;
    FpDesc: PISC_ARRAY_DESC;
    FRelationName: String;
    FFieldName: String;
    FData: Pointer;
    FDataLen: ISC_LONG;
    function Getsqldtype: ISC_UCHAR;
    function Getsqltype: Smallint;
    function Getsqldimensions: ISC_SHORT;
    function Getsqllen: ISC_USHORT;
    function Getsqlscale: ISC_SCHAR;
    function Getsqlsubtype: ISC_UCHAR;
    function Getsqlbounds: PISC_ARRAY_BOUNDs;
    procedure Setsqldtype(const AValue: ISC_UCHAR);
    procedure Setsqltype(const AValue: Smallint);
    procedure Setsqllen(const AValue: ISC_USHORT);
    procedure Setsqlscale(const AValue: ISC_SCHAR);
    procedure Setsqlsubtype(const AValue: ISC_UCHAR);
    procedure Alloc;
    procedure Release;
    function GetTotalCount: Integer;
  public
    FArrayID: ISC_QUAD;
    constructor Create(ADatabase: TIBDatabase; ATransaction: TIBTransaction;
      AOwningObj: TObject);
    destructor Destroy; override;
    procedure Lookup;
    procedure Init(AType, ALen, ADims: Smallint; ABounds: array of ISC_SHORT);
    procedure Read;
    procedure Write;

    function GetDataPtr(AIndexes: array of ISC_SHORT; AFlat: Boolean): Pointer;
    procedure GetData(ASrc: Pointer; var ApData: Pointer; out ALen: LongWord);
    procedure SetData(ADest, ApData: Pointer; ALen: LongWord);

    property Database: TIBDatabase read FDatabase;
    property Transaction: TIBTransaction read FTransaction;
    property RelationName: String read FRelationName write FRelationName;
    property FieldName: String read FFieldName write FFieldName;

    property ArrayID: ISC_QUAD read FArrayID write FArrayID;

    property sqldtype: ISC_UCHAR read Getsqldtype write Setsqldtype;
    property sqltype: Smallint read Getsqltype write Setsqltype;
    property sqlsubtype: ISC_UCHAR read Getsqlsubtype write Setsqlsubtype;
    property sqlscale: ISC_SCHAR read Getsqlscale write Setsqlscale;
    property sqllen: ISC_USHORT read Getsqllen write Setsqllen;
    property sqldimensions: ISC_SHORT read Getsqldimensions;
    property sqlbounds: PISC_ARRAY_BOUNDs read Getsqlbounds;
    property TotalCount: Integer read GetTotalCount;
  end;

  TIBStatement = class(TIBObject)
  private
    FStrsTrim: Boolean;
    FStrsEmpty2Null: Boolean;
    FDatabase: TIBDatabase;
    FTransaction: TIBTransaction;
    FInVars: TIBVariables;
    FOutVars: TIBVariables;
    FDialect: Word;
    FRowsDeleted: Int64;
    FRowsUpdated: Int64;
    FRowsSelected: Int64;
    FRowsInserted: Int64;
    FEOF: Boolean;
    FClosed: Boolean;
    FSingleRecord: Boolean;
    Fsql_stmt_type: Integer;
    procedure GetSQLInfo(AInfo: Integer; ABuff: PByte; ASize: Integer);
    function GetSQLInfoInt(AInfo: Integer): Integer;
    function GetSQLInfoStr(AInfo: Integer): String;
    procedure GetRowCounts(AForceGetCounts: Boolean);
    procedure Reset(ACheckBuff: Boolean);
{$IFDEF FireDAC_MONITOR}
    procedure DumpOutVars(AEof: Boolean);
    procedure DumpInVars;
{$ENDIF}
    function GetMaximumBatchSize: LongWord;
    function GetRowsAffected: Int64;
  public
    FSTHandle: isc_stmt_handle;
    constructor Create(ADatabase: TIBDatabase; ATransaction: TIBTransaction;
      AOwningObj: TObject);
    destructor Destroy; override;
    procedure Prepare(const ASQL: String);
    procedure DescribeSelect;
    procedure DescribeBind;
    procedure Execute(AForceGetCounts: Boolean);
    procedure ExecuteImmediate(const ASQL: String);
    procedure ExecuteBatch;
    procedure Open(ASingleRecord: Boolean);
    function Fetch: Boolean;
    procedure Unprepare;
    procedure Cancel;
    procedure Close;

    property StrsTrim: Boolean read FStrsTrim write FStrsTrim;
    property StrsEmpty2Null: Boolean read FStrsEmpty2Null write FStrsEmpty2Null;
    property Dialect: Word read FDialect write FDialect;

    property Database: TIBDatabase read FDatabase;
    property Transaction: TIBTransaction read FTransaction;
    property OutVars: TIBVariables read FOutVars;
    property InVars: TIBVariables read FInVars;
    property MaximumBatchSize: LongWord read GetMaximumBatchSize;

    property RowsInserted: Int64 read FRowsInserted;
    property RowsUpdated: Int64 read FRowsUpdated;
    property RowsDeleted: Int64 read FRowsDeleted;
    property RowsSelected: Int64 read FRowsSelected;
    property RowsAffected: Int64 read GetRowsAffected;
    property Eof: Boolean read FEOF;
    property Closed: Boolean read FClosed;

(*
    property sql_select
    property sql_bind
    property sql_num_variables
    property sql_describe_vars
    property sql_describe_end
    property sql_sqlda_seq
    property sql_message_seq
    property sql_type
    property sql_sub_type
    property sql_scale
    property sql_length
    property sql_null_ind
    property sql_field
    property sql_relation
    property sql_owner
    property sql_alias
    property sql_sqlda_start
*)
    property sql_stmt_type: Integer read Fsql_stmt_type;
    property sql_get_plan: String index isc_info_sql_get_plan read GetSQLInfoStr;
(*
    property sql_records             // see RowsXXXX properties
    property sql_batch_fetch

    // FB20
    property sql_relation_alias

    // IB71
    property sql_precision
*)
  end;

  TIBService = class (TIBObject)
  private
    FConnectTimeout: Cardinal;
    FQueryTimeout: Cardinal;
    FProtocol: TIBProtocol;
    FPassword: String;
    FHost: String;
    FInstanceName: String;
    FUserName: String;
    FSqlRoleName: String;
    FEncoder: TFDEncoder;
    FSEPassword: String;
  protected
    procedure GetAttachParams(ABld: TIBPBWriter); virtual;
    procedure GetServiceParams(ABld: TIBPBWriter); virtual;
    property Encoder: TFDEncoder read FEncoder;
  public
    FSvcHandle: isc_svc_handle;
    constructor Create(AEnv: TIBEnv; AOwningObj: TObject);
    destructor Destroy; override;
    procedure Attach;
    procedure Detach;
    procedure Start; virtual;
    function QueryString(out AMessage: String): Boolean; virtual;
    property Protocol: TIBProtocol read FProtocol write FProtocol default ipLocal;
    property Host: String read FHost write FHost;
    property InstanceName: String read FInstanceName write FInstanceName;
    property UserName: String read FUserName write FUserName;
    property Password: String read FPassword write FPassword;
    property SEPassword: String read FSEPassword write FSEPassword;
    property SqlRoleName: String read FSqlRoleName write FSqlRoleName;
    property ConnectTimeout: Cardinal read FConnectTimeout write FConnectTimeout default 0;
    property QueryTimeout: Cardinal read FQueryTimeout write FQueryTimeout default 0;
  end;

  TIBBackupOptions = set of (boIgnoreChecksum, boIgnoreLimbo, boMetadataOnly,
    boNoGarbageCollect, boOldDescriptions, boNonTransportable, boConvert, boExpand);
  TIBBackupMode = (bmBackup, bmArchiveDatabase, bmArchiveJournals);
  TIBBackup = class (TIBService)
  private
    FMode: TIBBackupMode;
    FBackupFiles: TStrings;
    FVerbose: Boolean;
    FDatabaseName: String;
    FOptions: TIBBackupOptions;
    FEncryptKeyName: String;
    procedure SetBackupFiles(const AValue: TStrings);
  protected
    procedure GetServiceParams(ABld: TIBPBWriter); override;
  public
    constructor Create(AEnv: TIBEnv; AOwningObj: TObject);
    destructor Destroy; override;
    property Mode: TIBBackupMode read FMode write FMode default bmBackup;
    property DatabaseName: String read FDatabaseName write FDatabaseName;
    property BackupFiles: TStrings read FBackupFiles write SetBackupFiles;
    property Verbose: Boolean read FVerbose write FVerbose default False;
    property Options: TIBBackupOptions read FOptions write FOptions default [];
    property EncryptKeyName: String read FEncryptKeyName write FEncryptKeyName;
  end;

  TFBNBackupOptions = set of (noNoTriggers);
  TFBNBackup = class (TIBService)
  private
    FBackupFile: String;
    FDatabaseName: String;
    FLevel: Integer;
    FOptions: TFBNBackupOptions;
  protected
    procedure GetServiceParams(ABld: TIBPBWriter); override;
  public
    property DatabaseName: String read FDatabaseName write FDatabaseName;
    property BackupFile: String read FBackupFile write FBackupFile;
    property Level: Integer read FLevel write FLevel default 0;
    property Options: TFBNBackupOptions read FOptions write FOptions default [];
  end;

  TIBSDumpOptions = set of (doOnline);
  TIBSDump = class (TIBService)
  private
    FDatabaseName: String;
    FBackupFiles: TStrings;
    FOverwrite: Boolean;
    FOptions: TIBSDumpOptions;
    procedure SetBackupFiles(const AValue: TStrings);
  protected
    procedure GetServiceParams(ABld: TIBPBWriter); override;
  public
    constructor Create(AEnv: TIBEnv; AOwningObj: TObject);
    destructor Destroy; override;
    property DatabaseName: String read FDatabaseName write FDatabaseName;
    property BackupFiles: TStrings read FBackupFiles write SetBackupFiles;
    property Overwrite: Boolean read FOverwrite write FOverwrite;
    property Options: TIBSDumpOptions read FOptions write FOptions;
  end;

  TIBRestoreOptions = set of (roDeactivateIdx, roNoShadow, roNoValidity,
    roOneAtATime, roReplace, roUseAllSpace, roValidate, roFixFSSData,
    roFixFSSMetaData, roMetaDataOnly);
  TIBRestoreMode = (rmRestore, rmArchiveRecover);
  TIBRestore = class (TIBService)
  private
    FMode: TIBRestoreMode;
    FBackupFiles: TStrings;
    FVerbose: Boolean;
    FDatabaseName: String;
    FOptions: TIBRestoreOptions;
    FPageSize: Cardinal;
    FPageBuffers: Cardinal;
    FEUAPassword: String;
    FEUAUserName: String;
    FFixCharSet: String;
    FDecryptPassword: String;
    FUntilTimestamp: TDateTime;
    procedure SetBackupFiles(const AValue: TStrings);
  protected
    procedure GetServiceParams(ABld: TIBPBWriter); override;
  public
    constructor Create(AEnv: TIBEnv; AOwningObj: TObject);
    destructor Destroy; override;
    property Mode: TIBRestoreMode read FMode write FMode default rmRestore;
    property DatabaseName: String read FDatabaseName write FDatabaseName;
    property BackupFiles: TStrings read FBackupFiles write SetBackupFiles;
    property Verbose: Boolean read FVerbose write FVerbose default False;
    property Options: TIBRestoreOptions read FOptions write FOptions default [];
    property PageSize: Cardinal read FPageSize write FPageSize default 0;
    property PageBuffers: Cardinal read FPageBuffers write FPageBuffers default 0;
    property FixCharSet: String read FFixCharSet write FFixCharSet;
    property EUAUserName: String read FEUAUserName write FEUAUserName;
    property EUAPassword: String read FEUAPassword write FEUAPassword;
    property DecryptPassword: String read FDecryptPassword write FDecryptPassword;
    property UntilTimestamp: TDateTime read FUntilTimestamp write FUntilTimestamp;
  end;

  TFBNRestore = class (TIBService)
  private
    FBackupFiles: TStrings;
    FDatabaseName: String;
    FOptions: TFBNBackupOptions;
    procedure SetBackupFile(const AValue: TStrings);
  protected
    procedure GetServiceParams(ABld: TIBPBWriter); override;
  public
    constructor Create(AEnv: TIBEnv; AOwningObj: TObject);
    destructor Destroy; override;
    property DatabaseName: String read FDatabaseName write FDatabaseName;
    property BackupFiles: TStrings read FBackupFiles write SetBackupFile;
    property Options: TFBNBackupOptions read FOptions write FOptions default [];
  end;

  TIBRepairOptions = set of (roValidateFull, roValidatePages, roMendRecords,
    roIgnoreChecksum, roKillShadows);
  TIBRepairMode = (rmCheckOnly, rmRepair, rmSweep);
  TIBRepair = class (TIBService)
  private
    FDatabaseName: String;
    FOptions: TIBRepairOptions;
    FMode: TIBRepairMode;
  protected
    procedure GetServiceParams(ABld: TIBPBWriter); override;
  public
    property DatabaseName: String read FDatabaseName write FDatabaseName;
    property Mode: TIBRepairMode read FMode write FMode default rmCheckOnly;
    property Options: TIBRepairOptions read FOptions write FOptions default [];
  end;

  TIBTraceAction = (taStart, taStop, taSuspend, taResume, taList);
  TIBTrace = class (TIBService)
  private
    FSessionName: String;
    FConfig: TStrings;
    FSessionID: Integer;
    FAction: TIBTraceAction;
    procedure SetConfig(const AValue: TStrings);
  protected
    procedure GetServiceParams(ABld: TIBPBWriter); override;
  public
    constructor Create(AEnv: TIBEnv; AOwningObj: TObject);
    destructor Destroy; override;
    function QueryString(out AMessage: String): Boolean; override;
  public
    property Action: TIBTraceAction read FAction write FAction default taStart;
    property SessionName: String read FSessionName write FSessionName;
    property SessionID: Integer read FSessionID write FSessionID default 0;
    property Config: TStrings read FConfig write SetConfig;
  end;

  TIBSecurityValue = (svUserName, svPassword, svFirstName, svMiddleName,
    svLastName, svUserID, svGroupID, svGroupName, svRoleName);
  TIBSecurityValues = set of TIBSecurityValue;
  TIBSecurityAction = (saAddUser, saDeleteUser, saModifyUser,
    saDisplayUser, saDisplayUsers);
  TIBSecurity = class (TIBService)
  private
    FValues: array [Low(TIBSecurityValue) .. High(TIBSecurityValue)] of String;
    FModified: TIBSecurityValues;
    FAction: TIBSecurityAction;
    FUsers: TFDDatSTable;
    FEUADatabase: String;
  protected
    procedure GetAttachParams(ABld: TIBPBWriter); override;
    procedure GetServiceParams(ABld: TIBPBWriter); override;
  public
    destructor Destroy; override;
    function GetInt(const AIndex: Integer): Integer;
    function GetStr(const AIndex: Integer): String;
    procedure SetInt(const AIndex, AValue: Integer);
    procedure SetStr(const AIndex: Integer; const AValue: String);
    procedure QuerySecurity;
  public
    // RO
    property Users: TFDDatSTable read FUsers;
    // RW
    property Action: TIBSecurityAction read FAction write FAction;
    property Modified: TIBSecurityValues read FModified write FModified default [];
    property AUserName: String index ord(svUserName) read GetStr write SetStr;
    property APassword: String index ord(svPassword) read GetStr write SetStr;
    property AFirstName: String index ord(svFirstName) read GetStr write SetStr;
    property AMiddleName: String index ord(svMiddleName) read GetStr write SetStr;
    property ALastName: String index ord(svLastName) read GetStr write SetStr;
    property AUserID: Integer index ord(svUserID) read GetInt write SetInt;
    property AGroupID: Integer index ord(svGroupID) read GetInt write SetInt;
    property AGroupName: String index ord(svGroupName) read GetStr write SetStr;
    property ARoleName: String index ord(svRoleName) read GetStr write SetStr;
    property EUADatabase: String read FEUADatabase write FEUADatabase;
  end;

  TIBReserveSpace = (rsUseFull, rsReserve);
  TIBWriteMode = (wmAsync, wmSync, wmDirect);
  TIBAccessMode = (amReadOnly, amReadWrite);
  TIBShutdownMode = (smForce, smDenyTransactions, smDenyAttachements);
  TIBConfig = class (TIBService)
  private
    FDatabaseName: String;
    FProperty: Integer;
    FValue: Cardinal;
  protected
    procedure GetServiceParams(ABld: TIBPBWriter); override;
  public
    property DatabaseName: String read FDatabaseName write FDatabaseName;
    // properties
    procedure SetPageBuffers(const AValue: Cardinal);
    procedure SetSQLDialect(const AValue: Cardinal);
    procedure SetSweepInterval(const AValue: Cardinal);
    procedure SetReserveSpace(const AValue: TIBReserveSpace);
    procedure SetWriteMode(const AValue: TIBWriteMode);
    procedure SetAccessMode(const AValue: TIBAccessMode);
    procedure SetArchiveDumps(const AValue: Cardinal);
    procedure SetArchiveSweep(const AValue: Cardinal);
    // actions
    procedure ShutdownDB(AMode: TIBShutdownMode; ATimeout: Cardinal);
    procedure OnlineDB;
    procedure ActivateShadow;
  end;

  /// <summary> This class is responsible for querying InterBase / Firebird
  ///  service manager. It provides access to server version, license,
  ///  configuration and usage information. </summary>
  TIBInfo = class(TIBService)
  public type
    /// <summary> TVersion record provides database server version information. </summary>
    TVersion = record
    public
      /// <summary> Service manager version. </summary>
      FService: Integer;
      /// <summary> Server version string. </summary>
      FServerStr: String;
      /// <summary> Server version integer value. </summary>
      FServer: TFDVersion;
      /// <summary> Server implementation. </summary>
      FImplementation: String;
    end;

    /// <summary> TLicense record provides database server license information. </summary>
    TLicense = record
    public type
      /// <summary> License certificate. </summary>
      TCertificate = record
        /// <summary> Certificate ID. </summary>
        FID: String;
        /// <summary> Certificate key. </summary>
        FKey: String;
        /// <summary> Certificate description. </summary>
        FDesc: String;
      end;
    public
      /// <summary> List of license certificates. </summary>
      FCertificates: TArray<TCertificate>;
      /// <summary> License mask. </summary>
      FLicenseMask: Integer;
      /// <summary> Licensed capabilities mask. </summary>
      FCapabilities: Integer;
      /// <summary> Licensed number of users. </summary>
      FUsers: Integer;
      /// <summary> Licensed embedding product name. </summary>
      FProduct: String;
    end;

    /// <summary> TConfig record provides database server configuration information. </summary>
    TConfig = record
    public type
      /// <summary> Configuration file entry. </summary>
      TEntry = record
        /// <summary> Entry ID. </summary>
        FID: Integer;
        /// <summary> Entry value. </summary>
        FValue: Integer;
      end;
    public
      /// <summary> List of configuration file entries. </summary>
      FConfig: TArray<TEntry>;
      /// <summary> Database server installation root path. </summary>
      FServerPath: String;
      /// <summary> Database server lock file path. </summary>
      FLockPath: String;
      /// <summary> Database server message file path. </summary>
      FMessagePath: String;
      /// <summary> Database server security database file path. </summary>
      FSecurityDBFile: String;
    end;

    /// <summary> TUsage record provides database server usage information. </summary>
    TUsage = record
    public
      /// <summary> Number of database server attachments. </summary>
      FAttachments: Integer;
      /// <summary> Number of used databases. </summary>
      FDatabases: Integer;
      /// <summary> Names of used databases. </summary>
      FDBNames: TArray<String>;
    end;

  protected type
    TRequestProc = reference to procedure (AReqWrt: TIBPBWriter);
    TParseFunc = reference to function (AOutRdr: TIBPBReader): Boolean;

  protected
    /// <summary> Low level method to query service manager. </summary>
    procedure QueryInfo(ARequest: TRequestProc; AParse: TParseFunc);
  public
    procedure Start; override;
    /// <summary> Returns database server version information. </summary>
    procedure GetVersion(out AVersion: TVersion);
    /// <summary> Returns database server license information. </summary>
    procedure GetLicense(out ALicense: TLicense);
    /// <summary> Returns database server configuration information. </summary>
    procedure GetConfig(out AConfig: TConfig);
    /// <summary> Returns database server usage information. </summary>
    procedure GetUsage(out AUsage: TUsage);
  end;

implementation

uses
  System.Generics.Collections, System.Types, System.Math,
{$IFDEF ANDROID}
  System.IOUtils,
{$ENDIF}
{$IFNDEF NEXTGEN}
  System.AnsiStrings,
{$ENDIF}
  System.SysUtils, Data.FmtBCD;

{-------------------------------------------------------------------------------}
const
  sBLOB_get: String = 'BLOB_get';
  sBLOB_put: String = 'BLOB_put';
  sisc_add_user: String = 'isc_add_user';
  sisc_array_gen_sdl: String = 'isc_array_gen_sdl';
  sisc_array_get_slice: String = 'isc_array_get_slice';
  sisc_array_lookup_bounds: String = 'isc_array_lookup_bounds';
  sisc_array_lookup_desc: String = 'isc_array_lookup_desc';
  sisc_array_put_slice: String = 'isc_array_put_slice';
  sisc_array_set_desc: String = 'isc_array_set_desc';
  sisc_array_gen_sdl2: String = 'isc_array_gen_sdl2';
  sisc_array_get_slice2: String = 'isc_array_get_slice2';
  sisc_array_lookup_bounds2: String = 'isc_array_lookup_bounds2';
  sisc_array_lookup_desc2: String = 'isc_array_lookup_desc2';
  sisc_array_put_slice2: String = 'isc_array_put_slice2';
  sisc_array_set_desc2: String = 'isc_array_set_desc2';
  sisc_attach_database: String = 'isc_attach_database';
  sisc_blob_default_desc: String = 'isc_blob_default_desc';
  sisc_blob_gen_bpb: String = 'isc_blob_gen_bpb';
  sisc_blob_info: String = 'isc_blob_info';
  sisc_blob_lookup_desc: String = 'isc_blob_lookup_desc';
  sisc_blob_set_desc: String = 'isc_blob_set_desc';
  sisc_cancel_blob: String = 'isc_cancel_blob';
  sisc_cancel_events: String = 'isc_cancel_events';
  sisc_close: String = 'isc_close';
  sisc_close_blob: String = 'isc_close_blob';
  sisc_commit_retaining: String = 'isc_commit_retaining';
  sisc_commit_transaction: String = 'isc_commit_transaction';
  sisc_compile_request: String = 'isc_compile_request';
  sisc_compile_request2: String = 'isc_compile_request2';
  sisc_create_blob: String = 'isc_create_blob';
  sisc_create_blob2: String = 'isc_create_blob2';
  sisc_create_database: String = 'isc_create_database';
  sisc_database_info: String = 'isc_database_info';
  sisc_ddl: String = 'isc_ddl';
  sisc_declare: String = 'isc_declare';
  sisc_decode_date: String = 'isc_decode_date';
  sisc_decode_sql_date: String = 'isc_decode_sql_date';
  sisc_decode_sql_time: String = 'isc_decode_sql_time';
  sisc_decode_timestamp: String = 'isc_decode_timestamp';
  sisc_delete_user: String = 'isc_delete_user';
  sisc_describe: String = 'isc_describe';
  sisc_describe_bind: String = 'isc_describe_bind';
  sisc_detach_database: String = 'isc_detach_database';
  sisc_drop_database: String = 'isc_drop_database';
  sisc_dsql_alloc_statement2: String = 'isc_dsql_alloc_statement2';
  sisc_dsql_allocate_statement: String = 'isc_dsql_allocate_statement';
  sisc_dsql_describe: String = 'isc_dsql_describe';
  sisc_dsql_describe_bind: String = 'isc_dsql_describe_bind';
  sisc_dsql_exec_immed2: String = 'isc_dsql_exec_immed2';
  sisc_dsql_exec_immed3_m: String = 'isc_dsql_exec_immed3_m';
  sisc_dsql_execute: String = 'isc_dsql_execute';
  sisc_dsql_execute_immediate: String = 'isc_dsql_execute_immediate';
  sisc_dsql_execute_immediate_m: String = 'isc_dsql_execute_immediate_m';
  sisc_dsql_execute_m: String = 'isc_dsql_execute_m';
  sisc_dsql_execute2: String = 'isc_dsql_execute2';
  sisc_dsql_execute2_m: String = 'isc_dsql_execute2_m';
  sisc_dsql_fetch: String = 'isc_dsql_fetch';
  sisc_dsql_fetch_m: String = 'isc_dsql_fetch_m';
  sisc_dsql_finish: String = 'isc_dsql_finish';
  sisc_dsql_free_statement: String = 'isc_dsql_free_statement';
  sisc_dsql_insert: String = 'isc_dsql_insert';
  sisc_dsql_insert_m: String = 'isc_dsql_insert_m';
  sisc_dsql_prepare: String = 'isc_dsql_prepare';
  sisc_dsql_prepare_m: String = 'isc_dsql_prepare_m';
  sisc_dsql_release: String = 'isc_dsql_release';
  sisc_dsql_set_cursor_name: String = 'isc_dsql_set_cursor_name';
  sisc_dsql_sql_info: String = 'isc_dsql_sql_info';
  sisc_embed_dsql_close: String = 'isc_embed_dsql_close';
  sisc_embed_dsql_declare: String = 'isc_embed_dsql_declare';
  sisc_embed_dsql_describe: String = 'isc_embed_dsql_describe';
  sisc_embed_dsql_describe_bind: String = 'isc_embed_dsql_describe_bind';
  sisc_embed_dsql_execute: String = 'isc_embed_dsql_execute';
  sisc_embed_dsql_execute_immed: String = 'isc_embed_dsql_execute_immed';
  sisc_embed_dsql_execute2: String = 'isc_embed_dsql_execute2';
  sisc_embed_dsql_fetch: String = 'isc_embed_dsql_fetch';
  sisc_embed_dsql_insert: String = 'isc_embed_dsql_insert';
  sisc_embed_dsql_open: String = 'isc_embed_dsql_open';
  sisc_embed_dsql_open2: String = 'isc_embed_dsql_open2';
  sisc_embed_dsql_prepare: String = 'isc_embed_dsql_prepare';
  sisc_embed_dsql_release: String = 'isc_embed_dsql_release';
  sisc_encode_date: String = 'isc_encode_date';
  sisc_encode_sql_date: String = 'isc_encode_sql_date';
  sisc_encode_sql_time: String = 'isc_encode_sql_time';
  sisc_encode_timestamp: String = 'isc_encode_timestamp';
  sisc_event_block: String = 'isc_event_block';
  sisc_event_counts: String = 'isc_event_counts';
  sisc_execute: String = 'isc_execute';
  sisc_execute_immediate: String = 'isc_execute_immediate';
  sisc_expand_dpb: String = 'isc_expand_dpb';
  sisc_fetch: String = 'isc_fetch';
  sisc_free: String = 'isc_free';
  sisc_ftof: String = 'isc_ftof';
  sisc_get_segment: String = 'isc_get_segment';
  sisc_get_slice: String = 'isc_get_slice';
  sisc_interprete: String = 'isc_interprete';
  sisc_modify_dpb: String = 'isc_modify_dpb';
  sisc_modify_user: String = 'isc_modify_user';
  sisc_open: String = 'isc_open';
  sisc_open_blob: String = 'isc_open_blob';
  sisc_open_blob2: String = 'isc_open_blob2';
  sisc_portable_integer: String = 'isc_portable_integer';
  sisc_prepare: String = 'isc_prepare';
  sisc_prepare_transaction: String = 'isc_prepare_transaction';
  sisc_prepare_transaction2: String = 'isc_prepare_transaction2';
  sisc_print_blr: String = 'isc_print_blr';
  sisc_print_sqlerror: String = 'isc_print_sqlerror';
  sisc_print_status: String = 'isc_print_status';
  sisc_put_segment: String = 'isc_put_segment';
  sisc_put_slice: String = 'isc_put_slice';
  sisc_qtoq: String = 'isc_qtoq';
  sisc_que_events: String = 'isc_que_events';
  sisc_receive: String = 'isc_receive';
  sisc_reconnect_transaction: String = 'isc_reconnect_transaction';
  sisc_release_request: String = 'isc_release_request';
  sisc_request_info: String = 'isc_request_info';
  sisc_rollback_retaining: String = 'isc_rollback_retaining';
  sisc_rollback_transaction: String = 'isc_rollback_transaction';
  sisc_seek_blob: String = 'isc_seek_blob';
  sisc_send: String = 'isc_send';
  sisc_service_attach: String = 'isc_service_attach';
  sisc_service_detach: String = 'isc_service_detach';
  sisc_service_query: String = 'isc_service_query';
  sisc_service_start: String = 'isc_service_start';
  sisc_set_debug: String = 'isc_set_debug';
  sisc_sql_interprete: String = 'isc_sql_interprete';
  sisc_sqlcode: String = 'isc_sqlcode';
  sisc_start_and_send: String = 'isc_start_and_send';
  sisc_start_multiple: String = 'isc_start_multiple';
  sisc_start_request: String = 'isc_start_request';
  sisc_start_transaction: String = 'isc_start_transaction';
  sisc_transact_request: String = 'isc_transact_request';
  sisc_transaction_info: String = 'isc_transaction_info';
  sisc_unwind_request: String = 'isc_unwind_request';
  sisc_vax_integer: String = 'isc_vax_integer';
  sisc_version: String = 'isc_version';
  sisc_vtof: String = 'isc_vtof';
  sisc_vtov: String = 'isc_vtov';
  sisc_wait_for_event: String = 'isc_wait_for_event';
  sisc_reset_fpe: String = 'isc_reset_fpe';
  sisc_get_client_version: String = 'isc_get_client_version';
  sisc_get_client_major_version: String = 'isc_get_client_major_version';
  sisc_get_client_minor_version: String = 'isc_get_client_minor_version';
  sisc_release_savepoint: String = 'isc_release_savepoint';
  sisc_rollback_savepoint: String = 'isc_rollback_savepoint';
  sisc_start_savepoint: String = 'isc_start_savepoint';
  sfb_interpret: String = 'fb_interpret';
  sisc_dsql_batch_execute: String = 'isc_dsql_batch_execute';
  sfb_sqlstate: String = 'fb_sqlstate';
  sfb_cancel_operation: String = 'fb_cancel_operation';
  sfb_shutdown: String = 'fb_shutdown';
  sfb_shutdown_callback: String = 'fb_shutdown_callback';
  sfb_ping: String = 'fb_ping';

  C_VarAlignment = 4 - 1;
  C_VarIndSize = (SizeOf(SmallInt) + C_VarAlignment) and not C_VarAlignment;

{-------------------------------------------------------------------------------}
{ TIBLib                                                                        }
{-------------------------------------------------------------------------------}
constructor TIBLib.Create(const ADriverID: String = S_FD_IBId; AOwningObj: TObject = nil);
begin
  inherited Create(ADriverID, AOwningObj);
  FLock := TCriticalSection.Create;
end;

{-------------------------------------------------------------------------------}
destructor TIBLib.Destroy;
begin
  FDFreeAndNil(FLock);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TIBLib.LoadBase(const AVendorHome, AVendorLib: String
  {$IFNDEF FireDAC_IB_STATIC} ; const ALibNames: array of String {$ENDIF});
{$IFNDEF FireDAC_IB_STATIC}
var
  sDLLName: String;
  aDLLNames: array of String;
  i: Integer;
{$ENDIF}
begin
{$IFNDEF FireDAC_IB_STATIC}
  sDLLName := AVendorHome;
  if sDLLName <> '' then
    sDLLName := FDNormPath(FDNormPath(sDLLName) + C_FD_DLLFolder);
  if AVendorLib <> '' then begin
    SetLength(aDLLNames, 1);
    aDLLNames[0] := sDLLName + AVendorLib;
  end
  else begin
    SetLength(aDLLNames, Length(ALibNames));
    for i := 0 to Length(ALibNames) - 1 do
      aDLLNames[i] := sDLLName + ALibNames[i];
  end;
  inherited Load(aDLLNames, True);
{$ELSE}
  LoadEntries;
  GetLibraryInfo;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TIBLib.LoadIB(const AVendorHome, AVendorLib: String; AEmbedded: Boolean);
{$IFNDEF FireDAC_IB_STATIC}
const
  C_GDS:      String = {$IFDEF MSWINDOWS} {$IFDEF FireDAC_64} 'ibclient64' {$ELSE} 'gds32' {$ENDIF} {$ENDIF}
                       {$IFDEF POSIX} 'libgds' {$ENDIF} + C_FD_DLLExt;
  C_TOGO:     String = {$IFDEF MSWINDOWS} {$IFDEF FireDAC_64} 'ibtogo64' {$ELSE} 'ibtogo' {$ENDIF} {$ENDIF}
                       {$IFDEF POSIX} 'libibtogo' {$ENDIF} + C_FD_DLLExt;
{$ENDIF}
begin
{$IFDEF ANDROID}
  FDSetEnv('INTERBASE', TPath.GetDocumentsPath + PathDelim + 'interbase');
{$ENDIF}
  if AEmbedded then
    // Force ToGo
    LoadBase(AVendorHome, AVendorLib
{$IFNDEF FireDAC_IB_STATIC},
      [C_TOGO]
{$ENDIF}
    )
  else
    LoadBase(AVendorHome, AVendorLib
{$IFNDEF FireDAC_IB_STATIC},
  {$IF DEFINED(MACOS) and not DEFINED(IOS)}
      // MacOSX: InterBase ToGo is preferred, and thus LIBIBTOGO has a higher priority
      [C_TOGO, C_GDS]
  {$ELSEIF DEFINED(IOS) or DEFINED(ANDROID)}
      // iOS, iOSSim, Android: no client/server, and thus no LIBGDS
      [C_TOGO]
  {$ELSE}
      // Windows: client/server is preferred over ToGo
      [C_GDS, C_TOGO]
  {$ENDIF}
{$ENDIF}
  );
end;

{-------------------------------------------------------------------------------}
procedure TIBLib.LoadFB(const AVendorHome, AVendorLib: String; AEmbedded: Boolean);
{$IFNDEF FireDAC_IB_STATIC}
const
  C_FBClient: String = {$IFDEF MSWINDOWS} 'fbclient' {$ENDIF}
                       {$IFDEF POSIX} 'libfbclient' {$ENDIF} + C_FD_DLLExt;
  C_FBEmbed:  String = {$IFDEF MSWINDOWS} 'fbembed' {$ENDIF}
                       {$IFDEF POSIX} 'libfbembed' {$ENDIF} + C_FD_DLLExt;
{$ENDIF}
begin
  if AEmbedded then
    LoadBase(AVendorHome, AVendorLib {$IFNDEF FireDAC_IB_STATIC}, [C_FBEmbed] {$ENDIF})
  else
    LoadBase(AVendorHome, AVendorLib {$IFNDEF FireDAC_IB_STATIC}, [C_FBClient, C_FBEmbed] {$ENDIF});
end;

{-------------------------------------------------------------------------------}
procedure TIBLib.Unload;
begin
  if (FhDLL <> 0) and
     (FBrand = ibFirebird) and FEmbedded and
     Assigned(Ffb_shutdown) then
    Ffb_shutdown(C_FD_PhysManagerShutdownTimeout, 1);
  inherited Unload;
end;

{-------------------------------------------------------------------------------}
procedure TIBLib.Lock;
begin
  FLock.Enter;
end;

{-------------------------------------------------------------------------------}
procedure TIBLib.Unlock;
begin
  FLock.Leave;
end;

{-------------------------------------------------------------------------------}
{$IFDEF POSIX}
  {$DEFINE USE_API}
{$ENDIF}
{$IFDEF FireDAC_IB_STATIC}
  {$DEFINE USE_API}
{$ENDIF}
procedure TIBLib.GetLibraryInfo;
var
  sLib: String;
{$IFDEF USE_API}
  sVer: TFDByteString;
  sVer2: String;
  aStr: TArray<String>;
{$ELSE}
  sProd: String;
{$ENDIF}
begin
  inherited GetLibraryInfo;
  FEmbedded := False;
  sLib := LowerCase(ExtractFileName(DLLName));
{$IFDEF USE_API}
  {$IFNDEF FireDAC_IB_STATIC}
  if Pos('fb', sLib) <> 0 then begin
    FBrand := ibFirebird;
    FEmbedded := Pos('embed', sLib) > 0;
  end
  else if (Pos('gds', sLib) <> 0) or (Pos('togo', sLib) <> 0) then begin
    FBrand := ibInterbase;
    FEmbedded := Pos('togo', sLib) > 0;
  end
  else
    FBrand := ibYaffil;
  Fisc_get_client_version := GetProc(sisc_get_client_version, False);
  {$ELSE}
    {$IFDEF FireDAC_IB_STATIC_IBBRAND}
  FBrand := ibInterbase;
    {$ENDIF}
    {$IFDEF FireDAC_IB_STATIC_FBBRAND}
  FBrand := ibFirebird;
    {$ENDIF}
  FEmbedded := True;
  {$ENDIF}
  if Assigned(Fisc_get_client_version) then begin
    SetLength(sVer, 4000);
    Fisc_get_client_version(PISC_SCHAR(PByte(sVer)));
    sVer2 := TFDEncoder.Deco(PByte(sVer), -1, ecANSI);
    if Brand <> ibInterbase then begin
      aStr := sVer2.Split([' ', '-', '.'], ExcludeEmpty);
      if Length(aStr) >= 8 then
        FVersion := FDVerStr2Int(aStr[6] + '.' + aStr[7] + '.' + aStr[3] + '.' + aStr[4])
      else
        FVersion := ivFB010003;
    end
    else
      FVersion := FDVerStr2Int(sVer2);
  end
  else
    case Brand of
    ibFirebird:  FVersion := ivFB010003;
    ibInterbase: FVersion := ivIB060500;
    ibYaffil:    FVersion := ivYF080607;
    end;
{$ELSE}
  sProd := UpperCase(Product);
  if Pos('FIREBIRD', sProd) <> 0 then begin
    FBrand := ibFirebird;
    FEmbedded := Pos('embed', sLib) > 0;
  end
  else if Pos('INTERBASE', sProd) <> 0 then begin
    FBrand := ibInterbase;
    FEmbedded := Pos('togo', sLib) > 0;
  end
  else
    FBrand := ibYaffil;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TIBLib.LoadEntries;
begin
                                                                                  
{$IFDEF FireDAC_IB_STATIC}
  @FBLOB_get := @BLOB_get;
  @FBLOB_put := @BLOB_put;
  @Fisc_add_user := @isc_add_user;
  @Fisc_attach_database := @isc_attach_database;
  @Fisc_blob_info := @isc_blob_info;
  @Fisc_cancel_blob := @isc_cancel_blob;
  @Fisc_cancel_events := @isc_cancel_events;
  @Fisc_close := @isc_close;
  @Fisc_close_blob := @isc_close_blob;
  @Fisc_commit_retaining := @isc_commit_retaining;
  @Fisc_commit_transaction := @isc_commit_transaction;
  @Fisc_compile_request := @isc_compile_request;
  @Fisc_compile_request2 := @isc_compile_request2;
  @Fisc_create_blob := @isc_create_blob;
  @Fisc_create_blob2 := @isc_create_blob2;
  @Fisc_create_database := @isc_create_database;
  @Fisc_database_info := @isc_database_info;
  @Fisc_ddl := @isc_ddl;
  @Fisc_declare := @isc_declare;
  @Fisc_decode_date := @isc_decode_date;
  @Fisc_decode_sql_date := @isc_decode_sql_date;
  @Fisc_decode_sql_time := @isc_decode_sql_time;
  @Fisc_decode_timestamp := @isc_decode_timestamp;
  @Fisc_delete_user := @isc_delete_user;
  @Fisc_detach_database := @isc_detach_database;
  @Fisc_drop_database := @isc_drop_database;
  @Fisc_dsql_alloc_statement2 := @isc_dsql_alloc_statement2;
  @Fisc_dsql_allocate_statement := @isc_dsql_allocate_statement;
  @Fisc_dsql_exec_immed3_m := @isc_dsql_exec_immed3_m;
  @Fisc_dsql_execute_immediate_m := @isc_dsql_execute_immediate_m;
  @Fisc_dsql_execute_m := @isc_dsql_execute_m;
  @Fisc_dsql_execute2_m := @isc_dsql_execute2_m;
  @Fisc_dsql_fetch_m := @isc_dsql_fetch_m;
  @Fisc_dsql_finish := @isc_dsql_finish;
  @Fisc_dsql_free_statement := @isc_dsql_free_statement;
  @Fisc_dsql_insert_m := @isc_dsql_insert_m;
  @Fisc_dsql_prepare_m := @isc_dsql_prepare_m;
  @Fisc_dsql_release := @isc_dsql_release;
  @Fisc_dsql_set_cursor_name := @isc_dsql_set_cursor_name;
  @Fisc_dsql_sql_info := @isc_dsql_sql_info;
  @Fisc_embed_dsql_close := @isc_embed_dsql_close;
  @Fisc_embed_dsql_declare := @isc_embed_dsql_declare;
  @Fisc_embed_dsql_release := @isc_embed_dsql_release;
  @Fisc_encode_date := @isc_encode_date;
  @Fisc_encode_sql_date := @isc_encode_sql_date;
  @Fisc_encode_sql_time := @isc_encode_sql_time;
  @Fisc_encode_timestamp := @isc_encode_timestamp;
  @Fisc_event_block := @isc_event_block;
  @Fisc_event_counts := @isc_event_counts;
  @Fisc_execute_immediate := @isc_execute_immediate;
  @Fisc_expand_dpb := @isc_expand_dpb;
  @Fisc_free := @isc_free;
  @Fisc_ftof := @isc_ftof;
  @Fisc_get_segment := @isc_get_segment;
  @Fisc_get_slice := @isc_get_slice;
  @Fisc_interprete := @isc_interprete;
  @Fisc_modify_dpb := @isc_modify_dpb;
  @Fisc_modify_user := @isc_modify_user;
  @Fisc_open_blob := @isc_open_blob;
  @Fisc_open_blob2 := @isc_open_blob2;
  @Fisc_portable_integer := @isc_portable_integer;
  @Fisc_array_gen_sdl := @isc_array_gen_sdl;
  @Fisc_array_get_slice := @isc_array_get_slice;
  @Fisc_array_lookup_bounds := @isc_array_lookup_bounds;
  @Fisc_array_lookup_desc := @isc_array_lookup_desc;
  @Fisc_array_put_slice := @isc_array_put_slice;
  @Fisc_array_set_desc := @isc_array_set_desc;
  @Fisc_array_gen_sdl2 := @isc_array_gen_sdl2;
  @Fisc_array_get_slice2 := @isc_array_get_slice2;
  @Fisc_array_lookup_bounds2 := @isc_array_lookup_bounds2;
  @Fisc_array_lookup_desc2 := @isc_array_lookup_desc2;
  @Fisc_array_put_slice2 := @isc_array_put_slice2;
  @Fisc_array_set_desc2 := @isc_array_set_desc2;
  @Fisc_blob_default_desc := @isc_blob_default_desc;
  @Fisc_blob_gen_bpb := @isc_blob_gen_bpb;
  @Fisc_blob_lookup_desc := @isc_blob_lookup_desc;
  @Fisc_blob_set_desc := @isc_blob_set_desc;
  @Fisc_describe := @isc_describe;
  @Fisc_describe_bind := @isc_describe_bind;
  @Fisc_dsql_describe := @isc_dsql_describe;
  @Fisc_dsql_describe_bind := @isc_dsql_describe_bind;
  @Fisc_dsql_exec_immed2 := @isc_dsql_exec_immed2;
  @Fisc_dsql_execute := @isc_dsql_execute;
  @Fisc_dsql_execute_immediate := @isc_dsql_execute_immediate;
  @Fisc_dsql_execute2 := @isc_dsql_execute2;
  @Fisc_dsql_fetch := @isc_dsql_fetch;
  @Fisc_dsql_insert := @isc_dsql_insert;
  @Fisc_dsql_prepare := @isc_dsql_prepare;
  @Fisc_embed_dsql_describe := @isc_embed_dsql_describe;
  @Fisc_embed_dsql_describe_bind := @isc_embed_dsql_describe_bind;
  @Fisc_embed_dsql_execute := @isc_embed_dsql_execute;
  @Fisc_embed_dsql_execute_immed := @isc_embed_dsql_execute_immed;
  @Fisc_embed_dsql_execute2 := @isc_embed_dsql_execute2;
  @Fisc_embed_dsql_fetch := @isc_embed_dsql_fetch;
  @Fisc_embed_dsql_insert := @isc_embed_dsql_insert;
  @Fisc_embed_dsql_open := @isc_embed_dsql_open;
  @Fisc_embed_dsql_open2 := @isc_embed_dsql_open2;
  @Fisc_embed_dsql_prepare := @isc_embed_dsql_prepare;
  @Fisc_execute := @isc_execute;
  @Fisc_fetch := @isc_fetch;
  @Fisc_open := @isc_open;
  @Fisc_prepare := @isc_prepare;
  @Fisc_prepare_transaction := @isc_prepare_transaction;
  @Fisc_prepare_transaction2 := @isc_prepare_transaction2;
  @Fisc_print_blr := @isc_print_blr;
  @Fisc_print_sqlerror := @isc_print_sqlerror;
  @Fisc_print_status := @isc_print_status;
  @Fisc_put_segment := @isc_put_segment;
  @Fisc_put_slice := @isc_put_slice;
  @Fisc_qtoq := @isc_qtoq;
  @Fisc_que_events := @isc_que_events;
  @Fisc_receive := @isc_receive;
  @Fisc_reconnect_transaction := @isc_reconnect_transaction;
  @Fisc_release_request := @isc_release_request;
  @Fisc_request_info := @isc_request_info;
  @Fisc_rollback_retaining := @isc_rollback_retaining;
  @Fisc_rollback_transaction := @isc_rollback_transaction;
  @Fisc_seek_blob := @isc_seek_blob;
  @Fisc_send := @isc_send;
  @Fisc_service_attach := @isc_service_attach;
  @Fisc_service_detach := @isc_service_detach;
  @Fisc_service_query := @isc_service_query;
  @Fisc_service_start := @isc_service_start;
  @Fisc_set_debug := @isc_set_debug;
  @Fisc_sql_interprete := @isc_sql_interprete;
  @Fisc_sqlcode := @isc_sqlcode;
  @Fisc_start_and_send := @isc_start_and_send;
  @Fisc_start_multiple := @isc_start_multiple;
  @Fisc_start_request := @isc_start_request;
  @Fisc_start_transaction := @isc_start_transaction;
  @Fisc_transact_request := @isc_transact_request;
  @Fisc_transaction_info := @isc_transaction_info;
  @Fisc_unwind_request := @isc_unwind_request;
  @Fisc_vax_integer := @isc_vax_integer;
  @Fisc_version := @isc_version;
  @Fisc_vtof := @isc_vtof;
  @Fisc_vtov := @isc_vtov;
  @Fisc_wait_for_event := @isc_wait_for_event;
  @Fisc_reset_fpe := @isc_reset_fpe;
  @Fisc_get_client_version := @isc_get_client_version;
  @Fisc_get_client_major_version := @isc_get_client_major_version;
  @Fisc_get_client_minor_version := @isc_get_client_minor_version;
  @Fisc_release_savepoint := @isc_release_savepoint;
  @Fisc_rollback_savepoint := @isc_rollback_savepoint;
  @Fisc_start_savepoint := @isc_start_savepoint;
  @Fisc_dsql_batch_execute := @isc_dsql_batch_execute;
  {$IFDEF FireDAC_IB_STATIC_FBBRAND}
  @Ffb_interpret := @fb_interpret;
  @Ffb_sqlstate := @fb_sqlstate;
  @Ffb_cancel_operation := @fb_cancel_operation;
  @Ffb_shutdown := @fb_shutdown;
  @Ffb_shutdown_callback := @fb_shutdown_callback;
  @Ffb_ping := @fb_ping;
  {$ELSE}
  @Ffb_interpret := nil;
  @Ffb_sqlstate := nil;
  @Ffb_cancel_operation := nil;
  @Ffb_shutdown := nil;
  @Ffb_shutdown_callback := nil;
  @Ffb_ping := nil;
  {$ENDIF}

{$ELSE}

  @FBLOB_get := GetProc(sBLOB_get);
  @FBLOB_put := GetProc(sBLOB_put);
  @Fisc_add_user := GetProc(sisc_add_user);
  @Fisc_attach_database := GetProc(sisc_attach_database);
  @Fisc_blob_info := GetProc(sisc_blob_info);
  @Fisc_cancel_blob := GetProc(sisc_cancel_blob);
  @Fisc_cancel_events := GetProc(sisc_cancel_events);
  @Fisc_close := GetProc(sisc_close);
  @Fisc_close_blob := GetProc(sisc_close_blob);
  @Fisc_commit_retaining := GetProc(sisc_commit_retaining);
  @Fisc_commit_transaction := GetProc(sisc_commit_transaction);
  @Fisc_compile_request := GetProc(sisc_compile_request);
  @Fisc_compile_request2 := GetProc(sisc_compile_request2);
  @Fisc_create_blob := GetProc(sisc_create_blob);
  @Fisc_create_blob2 := GetProc(sisc_create_blob2);
  @Fisc_create_database := GetProc(sisc_create_database);
  @Fisc_database_info := GetProc(sisc_database_info);
  @Fisc_ddl := GetProc(sisc_ddl);
  @Fisc_declare := GetProc(sisc_declare);
  @Fisc_decode_date := GetProc(sisc_decode_date);
  @Fisc_decode_sql_date := GetProc(sisc_decode_sql_date);
  @Fisc_decode_sql_time := GetProc(sisc_decode_sql_time);
  @Fisc_decode_timestamp := GetProc(sisc_decode_timestamp);
  @Fisc_delete_user := GetProc(sisc_delete_user);
  @Fisc_detach_database := GetProc(sisc_detach_database);
  @Fisc_drop_database := GetProc(sisc_drop_database);
  @Fisc_dsql_alloc_statement2 := GetProc(sisc_dsql_alloc_statement2);
  @Fisc_dsql_allocate_statement := GetProc(sisc_dsql_allocate_statement);
  @Fisc_dsql_exec_immed3_m := GetProc(sisc_dsql_exec_immed3_m);
  @Fisc_dsql_execute_immediate_m := GetProc(sisc_dsql_execute_immediate_m);
  @Fisc_dsql_execute_m := GetProc(sisc_dsql_execute_m);
  @Fisc_dsql_execute2_m := GetProc(sisc_dsql_execute2_m);
  @Fisc_dsql_fetch_m := GetProc(sisc_dsql_fetch_m);
  @Fisc_dsql_finish := GetProc(sisc_dsql_finish);
  @Fisc_dsql_free_statement := GetProc(sisc_dsql_free_statement);
  @Fisc_dsql_insert_m := GetProc(sisc_dsql_insert_m);
  @Fisc_dsql_prepare_m := GetProc(sisc_dsql_prepare_m);
  @Fisc_dsql_release := GetProc(sisc_dsql_release);
  @Fisc_dsql_set_cursor_name := GetProc(sisc_dsql_set_cursor_name);
  @Fisc_dsql_sql_info := GetProc(sisc_dsql_sql_info);
  @Fisc_embed_dsql_close := GetProc(sisc_embed_dsql_close);
  @Fisc_embed_dsql_declare := GetProc(sisc_embed_dsql_declare);
  @Fisc_embed_dsql_release := GetProc(sisc_embed_dsql_release);
  @Fisc_encode_date := GetProc(sisc_encode_date);
  @Fisc_encode_sql_date := GetProc(sisc_encode_sql_date);
  @Fisc_encode_sql_time := GetProc(sisc_encode_sql_time);
  @Fisc_encode_timestamp := GetProc(sisc_encode_timestamp);
  @Fisc_event_block := GetProc(sisc_event_block);
  @Fisc_event_counts := GetProc(sisc_event_counts);
  @Fisc_execute_immediate := GetProc(sisc_execute_immediate);
  @Fisc_expand_dpb := GetProc(sisc_expand_dpb);
  @Fisc_free := GetProc(sisc_free);
  @Fisc_ftof := GetProc(sisc_ftof);
  @Fisc_get_segment := GetProc(sisc_get_segment);
  @Fisc_get_slice := GetProc(sisc_get_slice);
  @Fisc_interprete := GetProc(sisc_interprete);
  @Fisc_modify_dpb := GetProc(sisc_modify_dpb);
  @Fisc_modify_user := GetProc(sisc_modify_user);
  @Fisc_open_blob := GetProc(sisc_open_blob);
  @Fisc_open_blob2 := GetProc(sisc_open_blob2);
  @Fisc_portable_integer := GetProc(sisc_portable_integer);
  @Fisc_array_gen_sdl := GetProc(sisc_array_gen_sdl);
  @Fisc_array_get_slice := GetProc(sisc_array_get_slice);
  @Fisc_array_lookup_bounds := GetProc(sisc_array_lookup_bounds);
  @Fisc_array_lookup_desc := GetProc(sisc_array_lookup_desc);
  @Fisc_array_put_slice := GetProc(sisc_array_put_slice);
  @Fisc_array_set_desc := GetProc(sisc_array_set_desc);
  @Fisc_array_gen_sdl2 := GetProc(sisc_array_gen_sdl2, False);
  @Fisc_array_get_slice2 := GetProc(sisc_array_get_slice2, False);
  @Fisc_array_lookup_bounds2 := GetProc(sisc_array_lookup_bounds2, False);
  @Fisc_array_lookup_desc2 := GetProc(sisc_array_lookup_desc2, False);
  @Fisc_array_put_slice2 := GetProc(sisc_array_put_slice2, False);
  @Fisc_array_set_desc2 := GetProc(sisc_array_set_desc2, False);
  @Fisc_blob_default_desc := GetProc(sisc_blob_default_desc);
  @Fisc_blob_gen_bpb := GetProc(sisc_blob_gen_bpb);
  @Fisc_blob_lookup_desc := GetProc(sisc_blob_lookup_desc);
  @Fisc_blob_set_desc := GetProc(sisc_blob_set_desc);
  @Fisc_describe := GetProc(sisc_describe);
  @Fisc_describe_bind := GetProc(sisc_describe_bind);
  @Fisc_dsql_describe := GetProc(sisc_dsql_describe);
  @Fisc_dsql_describe_bind := GetProc(sisc_dsql_describe_bind);
  @Fisc_dsql_exec_immed2 := GetProc(sisc_dsql_exec_immed2);
  @Fisc_dsql_execute := GetProc(sisc_dsql_execute);
  @Fisc_dsql_execute_immediate := GetProc(sisc_dsql_execute_immediate);
  @Fisc_dsql_execute2 := GetProc(sisc_dsql_execute2);
  @Fisc_dsql_fetch := GetProc(sisc_dsql_fetch);
  @Fisc_dsql_insert := GetProc(sisc_dsql_insert);
  @Fisc_dsql_prepare := GetProc(sisc_dsql_prepare);
  @Fisc_embed_dsql_describe := GetProc(sisc_embed_dsql_describe);
  @Fisc_embed_dsql_describe_bind := GetProc(sisc_embed_dsql_describe_bind);
  @Fisc_embed_dsql_execute := GetProc(sisc_embed_dsql_execute);
  @Fisc_embed_dsql_execute_immed := GetProc(sisc_embed_dsql_execute_immed);
  @Fisc_embed_dsql_execute2 := GetProc(sisc_embed_dsql_execute2);
  @Fisc_embed_dsql_fetch := GetProc(sisc_embed_dsql_fetch);
  @Fisc_embed_dsql_insert := GetProc(sisc_embed_dsql_insert);
  @Fisc_embed_dsql_open := GetProc(sisc_embed_dsql_open);
  @Fisc_embed_dsql_open2 := GetProc(sisc_embed_dsql_open2);
  @Fisc_embed_dsql_prepare := GetProc(sisc_embed_dsql_prepare);
  @Fisc_execute := GetProc(sisc_execute);
  @Fisc_fetch := GetProc(sisc_fetch);
  @Fisc_open := GetProc(sisc_open);
  @Fisc_prepare := GetProc(sisc_prepare);
  @Fisc_prepare_transaction := GetProc(sisc_prepare_transaction);
  @Fisc_prepare_transaction2 := GetProc(sisc_prepare_transaction2);
  @Fisc_print_blr := GetProc(sisc_print_blr);
  @Fisc_print_sqlerror := GetProc(sisc_print_sqlerror);
  @Fisc_print_status := GetProc(sisc_print_status);
  @Fisc_put_segment := GetProc(sisc_put_segment);
  @Fisc_put_slice := GetProc(sisc_put_slice);
  @Fisc_qtoq := GetProc(sisc_qtoq);
  @Fisc_que_events := GetProc(sisc_que_events);
  @Fisc_receive := GetProc(sisc_receive);
  @Fisc_reconnect_transaction := GetProc(sisc_reconnect_transaction);
  @Fisc_release_request := GetProc(sisc_release_request);
  @Fisc_request_info := GetProc(sisc_request_info);
  @Fisc_rollback_retaining := GetProc(sisc_rollback_retaining);
  @Fisc_rollback_transaction := GetProc(sisc_rollback_transaction);
  @Fisc_seek_blob := GetProc(sisc_seek_blob);
  @Fisc_send := GetProc(sisc_send);
  @Fisc_service_attach := GetProc(sisc_service_attach);
  @Fisc_service_detach := GetProc(sisc_service_detach);
  @Fisc_service_query := GetProc(sisc_service_query);
  @Fisc_service_start := GetProc(sisc_service_start);
  @Fisc_set_debug := GetProc(sisc_set_debug, False);
  @Fisc_sql_interprete := GetProc(sisc_sql_interprete);
  @Fisc_sqlcode := GetProc(sisc_sqlcode);
  @Fisc_start_and_send := GetProc(sisc_start_and_send);
  @Fisc_start_multiple := GetProc(sisc_start_multiple);
  @Fisc_start_request := GetProc(sisc_start_request);
  @Fisc_start_transaction := GetProc(sisc_start_transaction);
  @Fisc_transact_request := GetProc(sisc_transact_request);
  @Fisc_transaction_info := GetProc(sisc_transaction_info);
  @Fisc_unwind_request := GetProc(sisc_unwind_request);
  @Fisc_vax_integer := GetProc(sisc_vax_integer);
  @Fisc_version := GetProc(sisc_version);
  @Fisc_vtof := GetProc(sisc_vtof);
  @Fisc_vtov := GetProc(sisc_vtov);
  @Fisc_wait_for_event := GetProc(sisc_wait_for_event);
  @Fisc_reset_fpe := GetProc(sisc_reset_fpe, False);
  @Fisc_get_client_version := GetProc(sisc_get_client_version, False);
  @Fisc_get_client_major_version := GetProc(sisc_get_client_major_version, False);
  @Fisc_get_client_minor_version := GetProc(sisc_get_client_minor_version, False);
  @Fisc_release_savepoint := GetProc(sisc_release_savepoint, False);
  @Fisc_rollback_savepoint := GetProc(sisc_rollback_savepoint, False);
  @Fisc_start_savepoint := GetProc(sisc_start_savepoint, False);
  @Ffb_interpret := GetProc(sfb_interpret, False);
  @Fisc_dsql_batch_execute := GetProc(sisc_dsql_batch_execute, False);
  @Ffb_sqlstate := GetProc(sfb_sqlstate, False);
  @Ffb_cancel_operation := GetProc(sfb_cancel_operation, False);
  @Ffb_shutdown := GetProc(sfb_shutdown, False);
  @Ffb_shutdown_callback := GetProc(sfb_shutdown_callback, False);
  @Ffb_ping := GetProc(sfb_ping, False);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TIBLib.getb(p: PBStream): ISC_SCHAR;
begin
  Dec(p^.bstr_cnt);
  if p^.bstr_cnt >= 0 then begin
    Result := ISC_SCHAR(Integer(p^.bstr_ptr^) and $FF);
    Inc(p^.bstr_ptr);
  end
  else
    Result := ISC_SCHAR(FBLOB_get(p));
end;

{-------------------------------------------------------------------------------}
function TIBLib.putb(x: ISC_SCHAR; p: PBStream): Integer;
begin
  Dec(p^.bstr_cnt);
  if (x = ISC_SCHAR(#10)) or (p^.bstr_cnt = 0) then
    Result := FBLOB_put(x, p)
  else begin
    p^.bstr_ptr^ := x;
    Inc(p^.bstr_ptr);
    Result := Cardinal(x);
  end;
end;

{-------------------------------------------------------------------------------}
function TIBLib.putbx(x: ISC_SCHAR; p: PBStream): Integer;
begin
  Dec(p^.bstr_cnt);
  if p^.bstr_cnt = 0 then
    Result := FBLOB_put(x, p)
  else begin
    p^.bstr_ptr^ := x;
    Inc(p^.bstr_ptr);
    Result := Cardinal(x);
  end;
end;

{-------------------------------------------------------------------------------}
function TIBLib.GetIDUTF8: Integer;
begin
  if Brand = ibInterbase then
    Result := csIDIBUtf8
  else
    Result := csIDFBUtf8;
end;

{-------------------------------------------------------------------------------}
function TIBLib.IsUTF8(ACSID: Integer): Boolean;
begin
  case Byte(ACSID mod 256) of
  csIDUnicodeFSS: Result := True;
  csIDIBUtf8,
  csIDUnicodeBE,
  csIDUnicodeLE:  Result := Brand = ibInterbase;
  csIDFBUtf8:     Result := Brand in [ibFirebird, ibYaffil];
  else            Result := False;
  end;
end;

{-------------------------------------------------------------------------------}
function TIBLib.GetUTF8CSName(ACSID: Integer): String;
var
  iID: Integer;
begin
  iID := ACSID mod 256;
  if iID = csIDUnicodeFSS then
    Result := 'UNICODE_FSS'
  else if iID = IDUTF8 then
    Result := 'UTF8'
  else if (FBrand = ibInterbase) and (iID = csIDUnicodeBE) then
    Result := 'UNICODE_BE'
  else if (FBrand = ibInterbase) and (iID = csIDUnicodeLE) then
    Result := 'UNICODE_LE'
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
function TIBLib.GetBytesPerChar(ACSID: Integer): Integer;
var
  iID: Integer;
begin
  iID := ACSID mod 256;
  if iID = csIDUnicodeFSS then
    Result := 3
  else if iID = IDUTF8 then
    Result := 4
  else if (FBrand = ibInterbase) and ((iID = csIDUnicodeBE) or (iID = csIDUnicodeLE)) then
    Result := 2
  else
    Result := 1;
end;

{-------------------------------------------------------------------------------}
procedure TIBLib.ISCTmSt2DlpTmSt(const AISCTmSt: ISC_TIMESTAMP; var ASQLTmSt: TSQLTimeStamp);
var
  rCTimeStamp: TCTimeStructure;
begin
  Fisc_decode_timestamp(@AISCTmSt, @rCTimeStamp);
  ASQLTmSt.Year := Smallint(rCTimeStamp.tm_year + 1900);
  ASQLTmSt.Month := Smallint(rCTimeStamp.tm_mon + 1);
  ASQLTmSt.Day := Smallint(rCTimeStamp.tm_mday);
  ASQLTmSt.Hour := Smallint(rCTimeStamp.tm_hour);
  ASQLTmSt.Minute := Smallint(rCTimeStamp.tm_min);
  ASQLTmSt.Second := Smallint(rCTimeStamp.tm_sec);
  ASQLTmSt.Fractions := AISCTmSt.timestamp_time mod ISC_TIME_SECONDS_PRECISION div 10;
end;

{-------------------------------------------------------------------------------}
procedure TIBLib.DlpTmSt2ISCTmSt(const ASQLTmSt: TSQLTimeStamp; var AISCTmSt: ISC_TIMESTAMP);
var
  rCTimeStamp: TCTimeStructure;
begin
  FillChar(rCTimeStamp, SizeOf(rCTimeStamp), 0);
  rCTimeStamp.tm_year := ASQLTmSt.Year - 1900;
  rCTimeStamp.tm_mon := ASQLTmSt.Month - 1;
  rCTimeStamp.tm_mday := ASQLTmSt.Day;
  rCTimeStamp.tm_hour := ASQLTmSt.Hour;
  rCTimeStamp.tm_min := ASQLTmSt.Minute;
  rCTimeStamp.tm_sec := ASQLTmSt.Second;
  Fisc_encode_timestamp(@rCTimeStamp, @AISCTmSt);
  AISCTmSt.timestamp_time := AISCTmSt.timestamp_time + ASQLTmSt.Fractions * 10;
end;

{-------------------------------------------------------------------------------}
procedure TIBLib.ISCDt2DlpDt(const AISCDt: ISC_DATE; var ADt: Integer);
var
  rCTimeStamp: TCTimeStructure;
begin
  Fisc_decode_sql_date(@AISCDt, @rCTimeStamp);
  ADt := Integer(Trunc(EncodeDate(Word(rCTimeStamp.tm_year + 1900),
    Word(rCTimeStamp.tm_mon + 1), Word(rCTimeStamp.tm_mday)) + DateDelta));
end;

{-------------------------------------------------------------------------------}
procedure TIBLib.DlpDt2ISCDt(const ADt: Integer; var AISCDt: ISC_DATE);
var
  rCTimeStamp: TCTimeStructure;
  iYear, iMonth, iDay: Word;
begin
  iYear := 0;
  iMonth := 0;
  iDay := 0;
  DecodeDate(ADt - DateDelta, iYear, iMonth, iDay);
  FillChar(rCTimeStamp, SizeOf(rCTimeStamp), 0);
  rCTimeStamp.tm_year := iYear - 1900;
  rCTimeStamp.tm_mon := iMonth - 1;
  rCTimeStamp.tm_mday := iDay;
  Fisc_encode_sql_date(@rCTimeStamp, @AISCDt);
end;

{-------------------------------------------------------------------------------}
procedure TIBLib.ISCTm2DlpTm(const AISCTm: ISC_TIME; var ATm: Integer);
var
  rCTimeStamp: TCTimeStructure;
begin
  Fisc_decode_sql_time(@AISCTm, @rCTimeStamp);
  ATm := Integer(rCTimeStamp.tm_sec + rCTimeStamp.tm_min * 60 +
    rCTimeStamp.tm_hour * 3600) * 1000 +
    Integer(AISCTm mod ISC_TIME_SECONDS_PRECISION div 10);
end;

{-------------------------------------------------------------------------------}
procedure TIBLib.DlpTm2ISCTm(const ATm: Integer; var AISCTm: ISC_TIME);
var
  rCTimeStamp: TCTimeStructure;
  iSeconds: Cardinal;
begin
  iSeconds := Cardinal(ATm div 1000);
  FillChar(rCTimeStamp, SizeOf(rCTimeStamp), 0);
  rCTimeStamp.tm_hour := Integer(iSeconds div 3600);
  rCTimeStamp.tm_min := Integer((iSeconds div 60) mod 60);
  rCTimeStamp.tm_sec := Integer(iSeconds mod 60);
  Fisc_encode_sql_time(@rCTimeStamp, @AISCTm);
  AISCTm := AISCTm + Cardinal(ATm mod 1000 * 10);
end;

{-------------------------------------------------------------------------------}
{ TIBObject                                                                     }
{-------------------------------------------------------------------------------}
constructor TIBObject.Create(AEnv: TIBEnv; AOwningObj: TObject);
begin
  inherited Create;
  FEnv := AEnv;
  FOwningObj := AOwningObj;
end;

{-------------------------------------------------------------------------------}
procedure TIBObject.Check(AStatus: ISC_STATUS; AInitiator: TObject);
begin
  if AStatus = 0 then
    Exit;
  if AInitiator = nil then
    AInitiator := FOwningObj;
  Error.Check(AStatus, AInitiator);
end;

{-------------------------------------------------------------------------------}
function TIBObject.GetError: TIBError;
begin
  Result := FEnv.Error;
end;

{-------------------------------------------------------------------------------}
function TIBObject.GetLib: TIBLib;
begin
  Result := FEnv.Lib;
end;

{-------------------------------------------------------------------------------}
{ TFDIBError                                                                    }
{-------------------------------------------------------------------------------}
procedure TFDIBError.Assign(ASrc: TFDDBError);
begin
  inherited Assign(ASrc);
  if ASrc is TFDIBError then begin
    FExceptionCode := TFDIBError(ASrc).FExceptionCode;
    FSQLCode := TFDIBError(ASrc).FSQLCode;
    FLineNo := TFDIBError(ASrc).FLineNo;
    FColNo := TFDIBError(ASrc).FColNo;
    FSQLState := TFDIBError(ASrc).FSQLState;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDIBError.GetErrClass: Integer;
begin
  Result := (ErrorCode and CLASS_MASK) shr 30;
end;

{-------------------------------------------------------------------------------}
function TFDIBError.GetErrCode: Integer;
begin
  Result := (ErrorCode and CODE_MASK) shr 0;
end;

{-------------------------------------------------------------------------------}
function TFDIBError.GetFacility: Integer;
begin
  Result := (ErrorCode and FAC_MASK) shr 16;
end;

{-------------------------------------------------------------------------------}
procedure TFDIBError.LoadFromStorage(const AStorage: IFDStanStorage);
begin
  inherited LoadFromStorage(AStorage);
  FExceptionCode := AStorage.ReadInteger('ExceptionCode', 0);
  FSQLCode := AStorage.ReadInteger('SQLCode', 0);
  FLineNo := AStorage.ReadInteger('LineNo', 0);
  FColNo := AStorage.ReadInteger('ColNo', 0);
  FSQLState := AStorage.ReadString('SQLState', '');
end;

{-------------------------------------------------------------------------------}
procedure TFDIBError.SaveToStorage(const AStorage: IFDStanStorage);
begin
  inherited SaveToStorage(AStorage);
  AStorage.WriteInteger('ExceptionCode', ExceptionCode, 0);
  AStorage.WriteInteger('SQLCode', SQLCode, 0);
  AStorage.WriteInteger('LineNo', LineNo, 0);
  AStorage.WriteInteger('ColNo', ColNo, 0);
  AStorage.WriteString('SQLState', SQLState, '');
end;

{-------------------------------------------------------------------------------}
{ EIBNativeException                                                            }
{-------------------------------------------------------------------------------}
constructor EIBNativeException.Create(AError: TIBError);
var
  i, iLen, iExcCode, iSQLCode, iStatusLen, iTakeObjName, i1, i2: Integer;
  eKind: TFDCommandExceptionKind;
  pStatusVector: PISC_STATUS;
  buff: array[0..512] of ISC_SCHAR;
  sMsg, sItem, sObjName: String;
  lObjName: Boolean;
  sSQLState: String;
  oErr: TFDIBError;
begin
                                       
                                 
  AError.FEnv.Lib.Lock;
  try
    inherited Create(er_FD_IBGeneral, FDExceptionLayers([S_FD_LPhys,
      AError.FEnv.Lib.DriverID]));

    sMsg := '';
    sObjName := '';
    lObjName := False;
    eKind := ekOther;
    iExcCode := 0;
    iStatusLen := 0;
    iTakeObjName := 0;

    for i := 0 to 19 do
      if AError.FStatusVector[i] = isc_arg_end then begin
        iStatusLen := i;
        Break;
      end;

    case AError.Status of
    isc_except:
      if (AError.FStatusVector[0] = isc_arg_gds) and
         (AError.FStatusVector[1] = isc_except) and
         (AError.FStatusVector[2] = isc_arg_number) then
        iExcCode := AError.FStatusVector[3];
    isc_lost_db_connection,
    isc_conn_lost,
    isc_network_error,
    isc_net_connect_err,
    isc_net_connect_listen_err,
    isc_net_event_connect_err,
    isc_net_event_listen_err,
    isc_net_read_err,
    isc_net_write_err,
    isc_shutdown,
    isc_att_shutdown,
    isc_unavailable:
      eKind := ekServerGone;
                                                                                   
                                                                
                  
                                                    
                                                      
                                                        
                            
 
    isc_lock_conflict,
    isc_record_lock,
    isc_deadlock:
      eKind := ekRecordLocked;
    isc_foreign_key:
      begin
        if (AError.FStatusVector[0] = isc_arg_gds) and
           (AError.FStatusVector[1] = isc_foreign_key) then
          lObjName := True;
        eKind := ekFKViolated;
      end;
    isc_unique_key_violation:
      begin
        if (AError.FStatusVector[0] = isc_arg_gds) and
           (AError.FStatusVector[1] = isc_unique_key_violation) then
          lObjName := True;
        if AError.FStatusVector[2] in [isc_arg_string, isc_arg_cstring] then
          iTakeObjName := -1;
        eKind := ekUKViolated;
      end;
    isc_cancelled:
      eKind := ekCmdAborted;
    100,
    isc_stream_eof,
    isc_from_no_match:
      eKind := ekNoDataFound;
    isc_sing_select_err:
      eKind := ekTooManyRows;
    isc_dsql_error:
      if (AError.FStatusVector[0] = isc_arg_gds) and
         (AError.FStatusVector[1] = isc_dsql_error) and
         (AError.FStatusVector[2] = isc_arg_gds) and
         (AError.FStatusVector[3] = isc_sqlerr) and
         ((iStatusLen >= 8) and
            (AError.FStatusVector[6] = isc_arg_gds) and
            (AError.FStatusVector[7] = isc_dsql_relation_err) or
          (iStatusLen >= 8) and
            (AError.FStatusVector[6] = isc_arg_gds) and
            (AError.FStatusVector[7] = isc_dsql_procedure_err) or
          // FB15
          (iStatusLen >= 8) and
            (AError.FStatusVector[6] = isc_arg_gds) and
            (AError.FStatusVector[7] = isc_dsql_tableview_not_found) or
          // FB20
          (iStatusLen >= 10) and
            (AError.FStatusVector[8] = isc_arg_gds) and
            (AError.FStatusVector[9] = isc_dsql_table_not_found) or
          (iStatusLen >= 10) and
            (AError.FStatusVector[8] = isc_arg_gds) and
            (AError.FStatusVector[9] = isc_dsql_view_not_found)) then begin
        lObjName := True;
        eKind := ekObjNotExists;
      end
      else if (AError.FStatusVector[0] = isc_arg_gds) and
         (AError.FStatusVector[1] = isc_dsql_error) and
         (AError.FStatusVector[2] = isc_arg_gds) and
         (AError.FStatusVector[3] = isc_prcmismat) and
         (iStatusLen = 6) then
        eKind := ekInvalidParams;
    isc_no_meta_update:
      if (iStatusLen in [6, 8]) and
           (AError.FStatusVector[0] = isc_arg_gds) and
           (AError.FStatusVector[1] = isc_no_meta_update) and
           (AError.FStatusVector[2] = isc_arg_gds) and
           (AError.FStatusVector[3] = isc_random) or
         // FB30
         (iStatusLen >= 10) and
           (AError.FStatusVector[0] = isc_arg_gds) and
           (AError.FStatusVector[1] = isc_no_meta_update) and
           (AError.FStatusVector[6] = isc_arg_gds) and
            ((AError.FStatusVector[7] = isc_dyn_filter_not_found) or
             (AError.FStatusVector[7] = isc_dyn_func_not_found) or
             (AError.FStatusVector[7] = isc_dyn_index_not_found) or
             (AError.FStatusVector[7] = isc_dyn_domain_not_found) or
             (AError.FStatusVector[7] = isc_dyn_proc_not_found) or
             (AError.FStatusVector[7] = isc_dyn_exception_not_found) or
             (AError.FStatusVector[7] = isc_dyn_proc_param_not_found) or
             (AError.FStatusVector[7] = isc_dyn_trig_not_found) or
             (AError.FStatusVector[7] = isc_dyn_charset_not_found) or
             (AError.FStatusVector[7] = isc_dyn_collation_not_found) or
             (AError.FStatusVector[7] = isc_dyn_role_not_found) or
             (AError.FStatusVector[7] = isc_dyn_gen_not_found) or
             (AError.FStatusVector[7] = isc_dyn_package_not_found) or
             (AError.FStatusVector[7] = isc_dyn_schema_not_found)) or
         (iStatusLen >= 16) and
           (AError.FStatusVector[0] = isc_arg_gds) and
           (AError.FStatusVector[1] = isc_no_meta_update) and
           (AError.FStatusVector[12] = isc_arg_gds) and
             ((AError.FStatusVector[13] = isc_dyn_table_not_found) or
              (AError.FStatusVector[13] = isc_dsql_table_not_found) or
              (AError.FStatusVector[13] = isc_dyn_view_not_found) or
              (AError.FStatusVector[13] = isc_dsql_view_not_found)) then begin
        lObjName := True;
        eKind := ekObjNotExists;
      end;
    isc_login:
      eKind := ekUserPwdInvalid;
                                  
    end;

    pStatusVector := @(AError.FStatusVector[0]);
    repeat
      if lObjName and (pStatusVector^ = isc_arg_gds) then
        if (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_random) and
           (PISC_STATUS(NativeUInt(pStatusVector) + 2 * SizeOf(ISC_STATUS))^ in [isc_arg_string, isc_arg_cstring]) then
          iTakeObjName := 1
        else if (AError.FEnv.Lib.Brand = ibFirebird) and (AError.FEnv.Lib.Version >= ivFB020000) and
                ((PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dyn_filter_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dyn_func_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dyn_index_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dyn_view_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dsql_view_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dyn_domain_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dyn_proc_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dyn_exception_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dyn_proc_param_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dyn_trig_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dyn_charset_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dyn_collation_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dyn_role_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dyn_gen_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dyn_table_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dsql_table_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dyn_package_not_found) or
                 (PISC_STATUS(NativeUInt(pStatusVector) + 1 * SizeOf(ISC_STATUS))^ = isc_dyn_schema_not_found)) and
                (PISC_STATUS(NativeUInt(pStatusVector) + 2 * SizeOf(ISC_STATUS))^ in [isc_arg_string, isc_arg_cstring]) then
          iTakeObjName := 2;

      if (AError.FEnv.Lib.Brand = ibFirebird) and (AError.FEnv.Lib.Version >= ivFB020000) then
        iLen := AError.FEnv.Lib.Ffb_interpret(@buff, SizeOf(buff), pStatusVector)
      else
        iLen := AError.FEnv.Lib.Fisc_interprete(@buff, pStatusVector);
      if iLen > 0 then begin
        sItem := TFDEncoder.Deco(@buff, iLen, ecANSI);
        if iTakeObjName = 1 then begin
          // IB does not return standalone object name, so just ignore name.
          // Probably, some old FB versions may return similar messages, so
          // the code is brand unspecific.
          if (Length(sItem) > 8) and (Pos('not found', sItem) = Length(sItem) - 8) then
            sObjName := ''
          else if (Length(sItem) > 13) and (Pos('already exists', sItem) = Length(sItem) - 13) then begin
            sObjName := '';
            eKind := ekOther;
          end
          else
            sObjName := sItem;
          lObjName := False;
        end
        else if iTakeObjName = 2 then begin
          i1 := Pos(' ', sItem);
          i2 := Pos(' not found', sItem);
          if i2 = 0 then
            i2 := Pos(' does not exist', sItem);
          if (i1 <> 0) and (i2 <> 0) then
            sObjName := Copy(sItem, i1 + 1, i2 - i1 - 1);
          lObjName := False;
        end
        else if iTakeObjName = -1 then begin
          i1 := Pos('"', sItem);
          if i1 > 0 then begin
            i2 := Pos('"', sItem, i1 + 1);
            if i2 > 0 then
              sObjName := Copy(sItem, i1 + 1, i2 - i1 - 1);
          end;
        end;
        if sMsg <> '' then
          sMsg := sMsg + C_FD_EOL;
        sMsg := sMsg + sItem;
      end;
      iTakeObjName := 0;
    until iLen = 0;

    iSQLCode := AError.FEnv.Lib.Fisc_sqlcode(pStatusVector);
    if (iSQLCode <> 0) and (iSQLCode <> -999) then begin
      AError.FEnv.Lib.Fisc_sql_interprete(Smallint(iSQLCode), @buff,
        Smallint(SizeOf(buff)));
      sItem := TFDEncoder.Deco(@buff, -1, ecANSI);
      if sMsg <> '' then
        sMsg := sMsg + C_FD_EOL;
      sMsg := sMsg + sItem;
    end;

    if Assigned(AError.FEnv.Lib.Ffb_sqlstate) then begin
      AError.FEnv.Lib.Ffb_sqlstate(@buff, pStatusVector);
      sSQLState := TFDEncoder.Deco(@buff, FB_SQLSTATE_SIZE - 1, ecANSI);
    end
    else
      sSQLState := '';

    oErr := TFDIBError(AppendError(1, AError.Status, sMsg, sObjName, eKind, -1, -1));
    oErr.FExceptionCode := iExcCode;
    oErr.FSQLCode := iSQLCode;
    oErr.FSQLState := String(sSQLState);
{$IFDEF FireDAC_MONITOR}
    if AError.FEnv.Tracing then
      AError.FEnv.Trace(ekError, esProgress, 'ERROR: ' + sMsg,
        ['ErrorCode', AError.Status, 'ObjName', sObjName]);
{$ENDIF}
    Message := Message + sMsg;

  finally
    AError.FEnv.Lib.Unlock;
  end;
end;

{-------------------------------------------------------------------------------}
function EIBNativeException.GetErrorClass: TFDDBErrorClass;
begin
  Result := TFDIBError;
end;

{-------------------------------------------------------------------------------}
function EIBNativeException.GetErrors(AIndex: Integer): TFDIBError;
begin
  Result := TFDIBError(inherited Errors[AIndex]);
end;

{-------------------------------------------------------------------------------}
{ TIBError                                                                      }
{-------------------------------------------------------------------------------}
destructor TIBError.Destroy;
begin
  ClearInfo;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TIBError.Check(AStatus: ISC_STATUS; AInitiator: TObject = nil);
begin
  if AStatus = 0 then
    Exit;
  FStatus := AStatus;
  case (Status and CLASS_MASK) shr 30 of
  CLASS_ERROR:
    FDException(AInitiator, EIBNativeException.Create(Self)
      {$IFDEF FireDAC_Monitor}, Env.Tracing {$ENDIF});
  CLASS_WARNING,
  CLASS_INFO:
    begin
      ClearInfo;
      FInfo := EIBNativeException.Create(Self);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBError.ClearInfo;
begin
  FDFreeAndNil(FInfo);
end;

{-------------------------------------------------------------------------------}
procedure TIBError.CheckAllocateInfo;
begin
  if FInfo = nil then
    FInfo := EFDDBEngineException.Create(er_FD_IBGeneral,
      FDExceptionLayers([S_FD_LPhys, S_FD_IBId, 'GDS']));
end;

{-------------------------------------------------------------------------------}
{ TIBPBWriter                                                                   }
{-------------------------------------------------------------------------------}
constructor TIBPBWriter.Create(ALib: TIBLib; AEncoder: TFDEncoder);
begin
  inherited Create;
  FLib := ALib;
  FEncoder := AEncoder;
  Reset;
end;

{-------------------------------------------------------------------------------}
procedure TIBPBWriter.Reset;
begin
  FBufferSize := 32;
  SetLength(FBuffer, FBufferSize);
  FFinalSize := 0;
end;

{-------------------------------------------------------------------------------}
function TIBPBWriter.CheckBufferSize(ABytesToAdd: Integer): PByte;
begin
  Inc(FFinalSize, ABytesToAdd);
  while (FFinalSize > FBufferSize) do begin
    Inc(FBufferSize, 32);
    SetLength(FBuffer, FBufferSize);
  end;
  Result := PByte(PByte(FBuffer) + FFinalSize - ABytesToAdd);
end;

{-------------------------------------------------------------------------------}
procedure TIBPBWriter.AddByte(AByte: Byte);
begin
  CheckBufferSize(1)^ := AByte;
end;

{-------------------------------------------------------------------------------}
procedure TIBPBWriter.AddWord(AWord: Word);
var
  p: PByte;
begin
  p := CheckBufferSize(2);
  PWord(p)^ := Word(FLib.Fisc_portable_integer(PISC_UCHAR(@AWord), 2));
end;

{-------------------------------------------------------------------------------}
procedure TIBPBWriter.AddDWord(ADWord: Cardinal);
var
  p: PByte;
begin
  p := CheckBufferSize(4);
  PCardinal(p)^ := Cardinal(FLib.Fisc_portable_integer(PISC_UCHAR(@ADWord), 4));
end;

{-------------------------------------------------------------------------------}
procedure TIBPBWriter.AddCard(ACard: Cardinal);
begin
  case ACard of
  0 .. 255:
    begin
      AddByte(1);
      AddByte(Byte(ACard))
    end;
  256 .. 65535:
    begin
      AddByte(2);
      AddWord(Word(ACard))
    end;
  else
    AddByte(4);
    AddDWord(ACard);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBPBWriter.AddShortString(const AString: String);
var
  l: Integer;
  sb: TFDByteString;
begin
  l := Length(AString);
  if l > 255 then
    l := 255;
  CheckBufferSize(l + SizeOf(Byte));
  PByte(PByte(FBuffer) + FFinalSize - l - SizeOf(Byte))^ := Byte(l);
  sb := FEncoder.Encode(AString, ecANSI);
  Move(PByte(sb)^, (PByte(FBuffer) + FFinalSize - l)^, l * SizeOf(TFDAnsiChar));
end;

{-------------------------------------------------------------------------------}
procedure TIBPBWriter.AddLongString(const AString: String);
var
  l: Integer;
  sb: TFDByteString;
begin
  l := Length(AString);
  if l > 65535 then
    l := 65535;
  CheckBufferSize(l + SizeOf(Word));
  PByte(PByte(FBuffer) + FFinalSize - l - SizeOf(Word))^ := Byte(l);
  PByte(PByte(FBuffer) + FFinalSize - l - SizeOf(Word) + 1)^ := Byte(l shr 8);
  sb := FEncoder.Encode(AString, ecANSI);
  Move(PByte(sb)^, (PByte(FBuffer) + FFinalSize - l)^, l * SizeOf(TFDAnsiChar));
end;

{-------------------------------------------------------------------------------}
function TIBPBWriter.GetAsBlock: TFDByteString;
begin
  SetLength(FBuffer, FFinalSize);
  FBufferSize := FFinalSize;
  Result := FBuffer;
end;

{-------------------------------------------------------------------------------}
function TIBPBWriter.GetAsPByte: PISC_SCHAR;
begin
  Result := PISC_SCHAR(PByte(AsBlock));
end;

{-------------------------------------------------------------------------------}
function TIBPBWriter.GetLen: SmallInt;
begin
  Result := SmallInt(FFinalSize);
end;

{-------------------------------------------------------------------------------}
procedure TIBPBWriter.AddParams(AParams: TStrings; ApInfos: PIBPBInfoArr;
  AMaxCode: Byte; AFilter: TIBPBInfoFilterFunc);
var
  j: Integer;
  sCurStr, sCurValue: String;
  i: Byte;
  pInfo: PIBPBInfo;
begin
  for j := 0 to AParams.Count - 1 do begin
    sCurStr := Trim(LowerCase(AParams.KeyNames[j]));
    sCurValue := Trim(AParams.ValueFromIndex[j]);
    for i := 1 to AMaxCode do begin
      pInfo := @ApInfos^[i];
      if pInfo^.Name = sCurStr then begin
        case AFilter(ApInfos^[i]) of
          prNone:
            begin
              AddByte(pInfo^.Code);
              AddByte(0);
            end;
          prNoneNoZ:
            AddByte(pInfo^.Code);
          prCard:
            begin
              AddByte(pInfo^.Code);
              AddCard(StrToInt(sCurValue));
            end;
          prByte:
            begin
              AddByte(pInfo^.Code);
              AddByte(Byte(StrToInt(sCurValue)));
            end;
          prStrg:
            begin
              AddByte(pInfo^.Code);
              AddShortString(sCurValue);
            end;
        end;
        Break;
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
{ TIBPBReader                                                                   }
{-------------------------------------------------------------------------------}
constructor TIBPBReader.Create(ALib: TIBLib; AEncoder: TFDEncoder);
begin
  inherited Create;
  FLib := ALib;
  FEncoder := AEncoder;
end;

{-------------------------------------------------------------------------------}
procedure TIBPBReader.Reset(const ABuffer: TFDByteString);
begin
  FBuffer := ABuffer;
  FPos := 0;
end;

{-------------------------------------------------------------------------------}
procedure TIBPBReader.Reset(ALen: SmallInt);
begin
  SetLength(FBuffer, ALen);
  FPos := 0;
end;

{-------------------------------------------------------------------------------}
function TIBPBReader.GetEof: Boolean;
begin
  Result := FPos >= Length(FBuffer);
end;

{-------------------------------------------------------------------------------}
function TIBPBReader.GetAsBlock: TFDByteString;
begin
  Result := FBuffer;
end;

{-------------------------------------------------------------------------------}
function TIBPBReader.GetAsPByte: PISC_SCHAR;
begin
  Result := PISC_SCHAR(PByte(AsBlock));
end;

{-------------------------------------------------------------------------------}
function TIBPBReader.GetLen: SmallInt;
begin
  Result := SmallInt(Length(FBuffer));
end;

{-------------------------------------------------------------------------------}
function TIBPBReader.GetByte: Byte;
begin
  Result := PByte(PByte(FBuffer) + FPos)^;
  Inc(FPos);
end;

{-------------------------------------------------------------------------------}
function TIBPBReader.GetWord: Word;
begin
  Result := Word(FLib.Fisc_portable_integer(PISC_UCHAR(PByte(FBuffer) + FPos),
    SizeOf(Word)));
  Inc(FPos, SizeOf(Word));
end;

{-------------------------------------------------------------------------------}
function TIBPBReader.GetInteger: Integer;
begin
  Result := Integer(FLib.Fisc_portable_integer(PISC_UCHAR(PByte(FBuffer) + FPos),
    SizeOf(Integer)));
  Inc(FPos, SizeOf(Integer));
end;

{-------------------------------------------------------------------------------}
function TIBPBReader.GetLongString: String;
var
  iLen: Integer;
begin
  iLen := GetWord;
  if iLen > 0 then begin
    Result := FEncoder.Decode(PByte(FBuffer) + FPos, iLen, ecANSI);
    Inc(FPos, iLen);
  end
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
{ TIBEnv                                                                        }
{-------------------------------------------------------------------------------}
constructor TIBEnv.Create(ALib: TIBLib; AOwningObj: TObject);
begin
  inherited Create;
  FLib := ALib;
  FOwningObj := AOwningObj;
  FError := TIBError.Create(Self, AOwningObj);
end;

{-------------------------------------------------------------------------------}
destructor TIBEnv.Destroy;
begin
  FDFreeAndNil(FError);
{$IFDEF FireDAC_MONITOR}
  FMonitor := nil;
{$ENDIF}
  FOwningObj := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TIBEnv.BuildPB(AEncoder: TFDEncoder; AParams: TStrings; ATypeInfo, AVersion: Byte;
  ApInfos: PIBPBInfoArr; AMaxCode: Byte; AFilter: TIBPBInfoFilterFunc): TFDByteString;
var
  oWrt: TIBPBWriter;
begin
  oWrt := TIBPBWriter.Create(Lib, AEncoder);
  try
    if ATypeInfo <> 0 then begin
      oWrt.AddByte(ATypeInfo);
      if AVersion <> 0 then
        oWrt.AddByte(AVersion);
    end;
    oWrt.AddParams(AParams, ApInfos, AMaxcode, AFilter);
    Result := oWrt.AsBlock;
  finally
    FDFree(oWrt);
  end;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TIBEnv.GetTracing: Boolean;
begin
  Result := (FMonitor <> nil) and FMonitor.Tracing and FTracing;
end;

{-------------------------------------------------------------------------------}
procedure TIBEnv.Trace(const AMsg: String; const AArgs: array of const);
begin
  if GetTracing then
    FMonitor.Notify(ekVendor, esProgress, OwningObj, AMsg, AArgs);
end;

{-------------------------------------------------------------------------------}
procedure TIBEnv.Trace(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
  const AMsg: String; const AArgs: array of const);
begin
  if GetTracing then
    FMonitor.Notify(AKind, AStep, OwningObj, AMsg, AArgs);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TIBDatabase                                                                   }
{-------------------------------------------------------------------------------}
const
  DPBInfo_Items = 89;
  DPBInfos: array[1 .. DPBInfo_Items] of TIBPBInfo = (
    (Name: 'user_name';              ParamType: prStrg; Code: isc_dpb_user_name),       // ok
    (Name: 'password';               ParamType: prStrg; Code: isc_dpb_password),        // ok
    (Name: 'password_enc';           ParamType: prStrg; Code: isc_dpb_password_enc),    // ok
    (Name: 'sys_user_name';          ParamType: prStrg; Code: isc_dpb_sys_user_name),   // ok
    (Name: 'sys_user_name_enc';      ParamType: prNone; Code: isc_dpb_sys_user_name_enc),
    (Name: 'license';                ParamType: prStrg; Code: isc_dpb_license),
    (Name: 'encrypt_key';            ParamType: prStrg; Code: isc_dpb_encrypt_key),     // ok
    (Name: 'sql_role_name';          ParamType: prStrg; Code: isc_dpb_sql_role_name),   // ok rolename
    (Name: 'sql_dialect';            ParamType: prCard; Code: isc_dpb_sql_dialect),     // ok Set SQL Dialect for this connection (1,2,3)

    (Name: 'num_buffers';            ParamType: prCard; Code: isc_dpb_num_buffers),     // ok
    (Name: 'buffer_length';          ParamType: prIgno; Code: isc_dpb_buffer_length),   // not implemented
    (Name: 'dbkey_scope';            ParamType: prCard; Code: isc_dpb_dbkey_scope),     // ok
    (Name: 'page_size';              ParamType: prCard; Code: isc_dpb_page_size),       // ok

    (Name: 'force_write';            ParamType: prCard; Code: isc_dpb_force_write),     // ok
    (Name: 'no_reserve';             ParamType: prCard; Code: isc_dpb_no_reserve),      // ok
    (Name: 'damaged';                ParamType: prNone; Code: isc_dpb_damaged),         // ok
    (Name: 'verify';                 ParamType: prCard; Code: isc_dpb_verify),          // ok

    (Name: 'activate_shadow';        ParamType: prNone; Code: isc_dpb_activate_shadow), // ok deprecated
    (Name: 'delete_shadow';          ParamType: prNone; Code: isc_dpb_delete_shadow),   // ok

    (Name: 'begin_log';              ParamType: prStrg; Code: isc_dpb_begin_log),       // ok
    (Name: 'quit_log';               ParamType: prNone; Code: isc_dpb_quit_log),        // ok

    (Name: 'lc_messages';            ParamType: prStrg; Code: isc_dpb_lc_messages),     // ok
    (Name: 'lc_ctype';               ParamType: prStrg; Code: isc_dpb_lc_ctype),        // ok

    (Name: 'sweep';                  ParamType: prCard; Code: isc_dpb_sweep),           // ok
    (Name: 'sweep_interval';         ParamType: prCard; Code: isc_dpb_sweep_interval),  // ok

    (Name: 'journal';                ParamType: prIgno; Code: isc_dpb_journal),         // not implemented
    (Name: 'enable_journal';         ParamType: prStrg; Code: isc_dpb_enable_journal),  // ok
    (Name: 'disable_journal';        ParamType: prNone; Code: isc_dpb_disable_journal), // ok

    (Name: 'cdd_pathname';           ParamType: prIgno; Code: isc_dpb_cdd_pathname),    // not implemented
    (Name: 'allocation';             ParamType: prIgno; Code: isc_dpb_allocation),      // not implemented
    (Name: 'debug';                  ParamType: prCard; Code: isc_dpb_debug),           // ok
    (Name: 'garbage_collect';        ParamType: prNone; Code: isc_dpb_garbage_collect), // ok
    (Name: 'number_of_users';        ParamType: prIgno; Code: isc_dpb_number_of_users), // not implemented
    (Name: 'trace';                  ParamType: prNone; Code: isc_dpb_trace),           // ok
    (Name: 'no_garbage_collect';     ParamType: prNone; Code: isc_dpb_no_garbage_collect),// ok
    (Name: 'interp';                 ParamType: prCard; Code: isc_dpb_interp),          // ok
    (Name: 'online_dump';            ParamType: prCard; Code: isc_dpb_online_dump),     // ok
    (Name: 'old_file_size';          ParamType: prCard; Code: isc_dpb_old_file_size),   // ok
    (Name: 'old_num_files';          ParamType: prCard; Code: isc_dpb_old_num_files),   // ok
    (Name: 'old_file';               ParamType: prStrg; Code: isc_dpb_old_file),        // ok
    (Name: 'old_start_page';         ParamType: prCard; Code: isc_dpb_old_start_page),  // ok
    (Name: 'old_start_seqno';        ParamType: prCard; Code: isc_dpb_old_start_seqno), // ok
    (Name: 'old_start_file';         ParamType: prCard; Code: isc_dpb_old_start_file),  // ok
    (Name: 'drop_walfile';           ParamType: prCard; Code: isc_dpb_drop_walfile),    // ok
    (Name: 'old_dump_id';            ParamType: prCard; Code: isc_dpb_old_dump_id),     // ok
    (Name: 'wal_backup_dir';         ParamType: prStrg; Code: isc_dpb_wal_backup_dir),  // ok
    (Name: 'wal_chkptlen';           ParamType: prCard; Code: isc_dpb_wal_chkptlen),    // ok
    (Name: 'wal_numbufs';            ParamType: prCard; Code: isc_dpb_wal_numbufs),     // ok
    (Name: 'wal_bufsize';            ParamType: prCard; Code: isc_dpb_wal_bufsize),     // ok
    (Name: 'wal_grp_cmt_wait';       ParamType: prCard; Code: isc_dpb_wal_grp_cmt_wait),// ok
    (Name: 'cache_manager';          ParamType: prIgno; Code: isc_dpb_cache_manager),   // not used in fb1.5
    (Name: 'shutdown';               ParamType: prCard; Code: isc_dpb_shutdown),        // ok
    (Name: 'online';                 ParamType: prNone; Code: isc_dpb_online),            // ok
    (Name: 'shutdown_delay';         ParamType: prCard; Code: isc_dpb_shutdown_delay),    // ok
    (Name: 'reserved';               ParamType: prStrg; Code: isc_dpb_reserved),          // ok
    (Name: 'overwrite';              ParamType: prCard; Code: isc_dpb_overwrite),         // ok
    (Name: 'sec_attach';             ParamType: prCard; Code: isc_dpb_sec_attach),        // ok
    (Name: 'disable_wal';            ParamType: prNone; Code: isc_dpb_disable_wal),       // ok
    (Name: 'connect_timeout';        ParamType: prCard; Code: isc_dpb_connect_timeout),   // ok
    (Name: 'dummy_packet_interval';  ParamType: prCard; Code: isc_dpb_dummy_packet_interval),// ok
    (Name: 'gbak_attach';            ParamType: prStrg; Code: isc_dpb_gbak_attach),       // ok
    (Name: 'set_page_buffers';       ParamType: prCard; Code: isc_dpb_set_page_buffers),  // ok Change age buffer 50 >= buf >= 65535 (default 2048)
    (Name: 'working_directory';      ParamType: prStrg; Code: isc_dpb_working_directory), // ok
    (Name: 'gfix_attach';            ParamType: prNone; Code: isc_dpb_gfix_attach),       // ok FB15: don't work
    (Name: 'set_db_readonly';        ParamType: prCard; Code: isc_dpb_set_db_readonly),   // ok
    (Name: 'set_db_sql_dialect';     ParamType: prCard; Code: isc_dpb_set_db_sql_dialect),// ok Change sqldialect (1,2,3))
    (Name: 'gstat_attach';           ParamType: prNone; Code: isc_dpb_gstat_attach),      // ok FB15: don't work
    // IB65 OR YF867
    (Name: 'gbak_ods_version';       ParamType: prCard; Code: isc_dpb_gbak_ods_version),      // ??
    (Name: 'gbak_ods_minor_version'; ParamType: prCard; Code: isc_dpb_gbak_ods_minor_version),// ??
    // YF867
    (Name: 'numeric_scale_reduction';ParamType: prNone; Code: isc_dpb_numeric_scale_reduction),// ?? DA
    // IB7
    (Name: 'set_group_commit';       ParamType: prNone; Code: isc_dpb_set_group_commit),      // ??
    // IB71
    (Name: 'gbak_validate';          ParamType: prNone; Code: isc_dpb_gbak_validate),         // ??
    // IB75
    (Name: 'client_interbase_var';   ParamType: prCard; Code: isc_dpb_client_interbase_var),  // ?? DA
    (Name: 'admin_option';           ParamType: prCard; Code: isc_dpb_admin_option),          // ?? DA
    (Name: 'flush_interval';         ParamType: prCard; Code: isc_dpb_flush_interval),        // ?? DA
    // IB2007
    (Name: 'instance_name';          ParamType: prStrg; Code: isc_dpb_instance_name),         // ok
                                               
                         
                            
                            
                         
                         
                           
                         
                 
 
    // IBXE
    (Name: 'preallocate';            ParamType: prStrg; Code: isc_dpb_preallocate),           // ok
    (Name: 'sys_encrypt_password';   ParamType: prStrg; Code: isc_dpb_sys_encrypt_password),  // ok
    // IBXE3
    (Name: 'eua_user_name';          ParamType: prStrg; Code: isc_dpb_eua_user_name),         // ok
    // FB103
    (Name: 'set_db_charset';         ParamType: prStrg; Code: isc_dpb_set_db_charset),        // ok
    // FB20
    (Name: 'gsec_attach';            ParamType: prNone; Code: isc_dpb_gsec_attach),           // ?? DA
    (Name: 'address_path';           ParamType: prStrg; Code: isc_dpb_address_path),          // ?? DA
    // FB21
    (Name: 'process_id';             ParamType: prCard; Code: isc_dpb_process_id),            // ok
    (Name: 'no_db_triggers';         ParamType: prCard; Code: isc_dpb_no_db_triggers),        // ok
    (Name: 'trusted_auth';           ParamType: prNone; Code: isc_dpb_trusted_auth),          // ok
    (Name: 'process_name';           ParamType: prStrg; Code: isc_dpb_process_name),          // ok
    // FB25
    (Name: 'trusted_role';           ParamType: prStrg; Code: isc_dpb_trusted_role),          // ok
    (Name: 'org_filename';           ParamType: prStrg; Code: isc_dpb_org_filename),          // ok
    (Name: 'utf8_filename';          ParamType: prNone; Code: isc_dpb_utf8_filename));        // ok

{-------------------------------------------------------------------------------}
constructor TIBDatabase.Create(AEnv: TIBEnv; AOwningObj: TObject);
begin
  inherited Create(AEnv, AOwningObj);
  FList := TFDStringList.Create;
  FOwnHandle := True;
  FBuffer := TFDBuffer.Create;
  FEncoder := TFDEncoder.Create(FBuffer);
end;

{-------------------------------------------------------------------------------}
constructor TIBDatabase.CreateUsingHandle(AEnv: TIBEnv;
  AHandle: isc_db_handle; AOwningObj: TObject);
begin
  Create(AEnv, AOwningObj);
  FDBHandle := AHandle;
  FOwnHandle := False;
  FBuffer := TFDBuffer.Create;
  FEncoder := TFDEncoder.Create(FBuffer);
end;

{-------------------------------------------------------------------------------}
destructor TIBDatabase.Destroy;
begin
  if FDBHandle <> nil then
    Detach;
  FDFreeAndNil(FList);
  FDFreeAndNil(FEncoder);
  FDFreeAndNil(FBuffer);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TIBDatabase.FilterDBParam(const AInfo: TIBPBInfo): TIBPBParamType;
var
 iBrand: TFDPhysIBBrand;
 iVersion: TFDVersion;
 iCode: Byte;
 sName: String;
begin
  iBrand := Env.Lib.Brand;
  iVersion := Env.Lib.Version;
  iCode := AInfo.Code;
  sName := AInfo.Name;
  Result := AInfo.ParamType;
  // isc_dpb_gbak_ods_version, isc_dpb_gbak_ods_minor_version clash with
  // the isc_dpb_set_db_charset, isc_dpb_gsec_attach. So, use names to
  // distinguish parameters.
  if (iCode in [isc_dpb_gbak_ods_version, isc_dpb_gbak_ods_minor_version]) and
     ((sName = 'gbak_ods_version') or (sName = 'gbak_ods_minor_version')) then
    if not ((iBrand = ibInterbase) and (iVersion >= ivIB060500) or
            (iBrand = ibYaffil) and (iVersion >= ivYF080607)) then
      Result := prIgno;
  if (iCode = isc_dpb_numeric_scale_reduction) and
     (sName = 'numeric_scale_reduction') then
    if not ((iBrand = ibYaffil) and (iVersion >= ivYF080607)) then
      Result := prIgno;
  if (iCode = isc_dpb_set_group_commit) and
     (sName = 'set_group_commit') then
    if not ((iBrand = ibInterbase) and (iVersion >= ivIB070000)) then
      Result := prIgno;
  if (iCode = isc_dpb_gbak_validate) and
     (sName = 'gbak_validate') then
    if not ((iBrand = ibInterbase) and (iVersion >= ivIB070100)) then
      Result := prIgno;
  if (iCode in [isc_dpb_client_interbase_var, isc_dpb_admin_option,
                isc_dpb_flush_interval]) and
     ((sName = 'client_interbase_var') or (sName = 'admin_option') or
      (sName = 'flush_interval')) then
    if not ((iBrand = ibInterbase) and (iVersion >= ivIB070500)) then
      Result := prIgno;
  if (iCode = isc_dpb_set_db_charset) and
     (sName = 'set_db_charset') then
    if not ((iBrand = ibFirebird) and (iVersion >= ivFB010003)) then
      Result := prIgno;
  if (iCode in [isc_dpb_gsec_attach, isc_dpb_address_path]) and
     ((sName = 'gsec_attach') or (sName = 'address_path')) then
    if not ((iBrand = ibFirebird) and (iVersion >= ivFB020000)) then
      Result := prIgno;
  if (iCode = isc_dpb_instance_name) and
     (sName = 'instance_name') then
    if not ((iBrand = ibInterbase) and (iVersion >= ivIB080000)) then
      Result := prIgno;
  if (iCode in [isc_dpb_preallocate, isc_dpb_sys_encrypt_password]) and
     ((sName = 'preallocate') or (sName = 'sys_encrypt_password')) then
    if not ((iBrand = ibInterbase) and (iVersion >= ivIB100000)) then
      Result := prIgno;
  if (iCode = isc_dpb_eua_user_name) and
     (sName = 'eua_user_name') then
    if not ((iBrand = ibInterbase) and (iVersion >= ivIB110000)) then
      Result := prIgno;
  if (iCode in [isc_dpb_process_id, isc_dpb_no_db_triggers,
                isc_dpb_trusted_auth, isc_dpb_process_name]) and
     ((sName = 'process_id') or (sName = 'no_db_triggers') or
      (sName = 'trusted_auth') or (sName = 'process_name')) then
    if not ((iBrand = ibFirebird) and (iVersion >= ivFB020100)) then
      Result := prIgno;
  if (iCode in [isc_dpb_trusted_role, isc_dpb_org_filename,
                isc_dpb_utf8_filename]) and
     ((sName = 'trusted_role') or (sName = 'org_filename') or
      (sName = 'utf8_filename')) then
    if not ((iBrand = ibFirebird) and (iVersion >= ivFB020500)) then
      Result := prIgno;
end;

{-------------------------------------------------------------------------------}
function TIBDatabase.Attach(const ADBName: String; AParams: TStrings;
  ARetExists: Boolean): Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  var
    s: String;
    i1, i2: Integer;
  begin
    s := AParams.CommaText;
    i1 := Pos('PASSWORD=', UpperCase(s));
    if i1 <> 0 then begin
      i2 := Pos(',', s, i1);
      if i2 = 0 then
        i2 := Length(s) + 1;
      Inc(i1, 9);
      while i1 < i2 do begin
        s[i1] := '*';
        Inc(i1);
      end;
    end;
    Env.Trace(sisc_attach_database, ['dbname', ADBName, 'params', s]);
  end;
{$ENDIF}

var
  sDBName: TFDByteString;
  iDBNameLen: Integer;
  sDBParams: TFDByteString;
  iStatus: ISC_STATUS;
begin
  Lib.Lock;
  try
    if (Lib.Brand = ibFirebird) and (Lib.Version >= ivFB020500) then begin
      sDBName := Encoder.Encode(ADBName, ecUTF8);
      iDBNameLen := Encoder.EncodedLength(sDBName, ecUTF8);
      AParams.Add('utf8_filename');
    end
    else begin
      sDBName := Encoder.Encode(ADBName, ecANSI);
      iDBNameLen := Encoder.EncodedLength(sDBName, ecANSI);
    end;
    sDBParams := Env.BuildPB(Encoder, AParams, isc_tpb_version1, 0,
      PIBPBInfoArr(@DPBInfos), DPBInfo_Items, FilterDBParam);
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    iStatus := Lib.Fisc_attach_database(@Error.FStatusVector, Smallint(iDBNameLen),
      PISC_SCHAR(PByte(sDBName)), @FDBHandle, Smallint(Length(sDBParams)),
      PISC_SCHAR(PByte(sDBParams)));
    if not ARetExists or not ((iStatus = isc_io_error) or (iStatus = isc_unavailable)) then begin
      Check(iStatus);
      Result := True;
    end
    else
      Result := False;
  finally
    Lib.Unlock;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBDatabase.CreateDatabase(const ADBName: String; AParams: TStrings);
var
  sCreateDB: String;
  sSQL: TFDByteString;
  iSQLLen: Integer;
  hTr: isc_tr_handle;
  sDBName: TFDByteString;
  iDBNameLen: Integer;
  sDBParams: TFDByteString;
  i: Integer;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_create_database, ['file_name', ADBName]);
  end;

  procedure Trace2;
  begin
    Env.Trace(sisc_dsql_execute_immediate, ['sql', sCreateDB]);
  end;
{$ENDIF}

  procedure AddParam(const AParName, ASQL: String; AQuote: Boolean);
  var
    s: String;
  begin
    s := AParams.Values[AParName];
    if s <> '' then begin
      sCreateDB := sCreateDB + ' ' + ASQL + ' ';
      if AQuote then
        sCreateDB := sCreateDB + '''';
      sCreateDB := sCreateDB + s;
      if AQuote then
        sCreateDB := sCreateDB + '''';
    end;
  end;

begin
  FDBHandle := nil;
  Lib.Lock;
  try
    // About isc_create_database vs CREATE DATABASE read the link:
    // http://sourceforge.net/mailarchive/forum.php?thread_name=4595CA2E.
    //  3000605%40uol.com.br&forum_name=firebird-devel
    if (Lib.Brand = ibFirebird) and (Lib.Version >= ivFB020500) then begin
      sDBName := Encoder.Encode(ADBName, ecUTF8);
      iDBNameLen := Encoder.EncodedLength(sDBName, ecUTF8);
      AParams.Add('utf8_filename');
      i := AParams.IndexOfName('lc_ctype');
      if i <> -1 then
        AParams.Add('set_db_charset=' + AParams.ValueFromIndex[i]);
      sDBParams := Env.BuildPB(Encoder, AParams, isc_tpb_version1, 0,
        PIBPBInfoArr(@DPBInfos), DPBInfo_Items, FilterDBParam);
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then Trace1;
{$ENDIF}
      Check(Lib.Fisc_create_database(@Error.FStatusVector, Smallint(iDBNameLen),
        PISC_SCHAR(PByte(sDBName)), @FDBHandle, Smallint(Length(sDBParams)),
        PISC_SCHAR(PByte(sDBParams)), 0));
    end
    else begin
      sCreateDB := 'CREATE DATABASE ''' + ADBName + '''';
      AddParam('user_name', 'USER', True);
      AddParam('password', 'PASSWORD', True);
      AddParam('page_size', 'PAGE_SIZE', False);
      AddParam('lc_ctype', 'DEFAULT CHARACTER SET', False);
      sSQL := Encoder.Encode(sCreateDB);
      iSQLLen := Encoder.EncodedLength(sSQL);
      hTr := nil;
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then Trace2;
{$ENDIF}
      Check(Lib.Fisc_dsql_execute_immediate(@Error.FStatusVector, @FDBHandle,
        @hTr, Smallint(iSQLLen), PISC_SCHAR(PByte(sSQL)),
        StrToIntDef(AParams.Values['sql_dialect'], 3), nil));
    end;
  finally
    Lib.Unlock;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBDatabase.Detach;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_detach_database, ['db_handle', FDBHandle]);
  end;
{$ENDIF}

begin
  if (FDBHandle = nil) or not FOwnHandle then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Lib.Lock;
  try
    try
      Check(Lib.Fisc_detach_database(@Error.FStatusVector, @FDBHandle));
    except
      on E: EIBNativeException do
        if E.Kind <> ekServerGone then
          raise;
    end;
  finally
    FDBHandle := nil;
    Lib.Unlock;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBDatabase.Cancel;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sfb_cancel_operation, ['db_handle', FDBHandle, 'option', '@fb_cancel_raise']);
  end;
{$ENDIF}

begin
  if (FDBHandle = nil) or not Assigned(Lib.Ffb_cancel_operation) then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Check(Lib.Ffb_cancel_operation(@Error.FStatusVector, @FDBHandle, fb_cancel_raise));
end;

{-------------------------------------------------------------------------------}
procedure TIBDatabase.Drop;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_drop_database, ['db_handle', FDBHandle]);
  end;
{$ENDIF}

begin
  if FDBHandle = nil then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Lib.Lock;
  try
    Check(Lib.Fisc_drop_database(@Error.FStatusVector, @FDBHandle));
  finally
    FDBHandle := nil;
    Lib.Unlock;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBDatabase.Ping;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sfb_ping, ['db_handle', FDBHandle]);
  end;
{$ENDIF}

begin
  if FDBHandle = nil then
    Exit;
  if Assigned(Lib.Ffb_ping) then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    Check(Lib.Ffb_ping(@Error.FStatusVector, @FDBHandle));
  end
  else
    // it is simplest server request
    no_reserve;
end;

{-------------------------------------------------------------------------------}
procedure TIBDatabase.GetDatabaseInfo(AInfo: Integer; ABuff: PByte; ASize: Integer);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_database_info, ['db_handle', FDBHandle, 'info', AInfo]);
  end;
{$ENDIF}

var
  cInfo: Byte;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  cInfo := AInfo;
  Check(Lib.Fisc_database_info(@Error.FStatusVector, @FDBHandle, 1, @cInfo,
    SmallInt(ASize), PISC_SCHAR(ABuff)));
  ASSERT(ABuff^ <> isc_info_truncated);
end;

{-------------------------------------------------------------------------------}
function TIBDatabase.GetDatabaseInfoInt(AInfo: Integer): Integer;
var
  buff: array [0..63] of Byte;
  iLen: Integer;
begin
  GetDatabaseInfo(AInfo, @buff, SizeOf(buff));
  iLen := Integer(Env.Lib.Fisc_portable_integer(@buff[1], 2));
  Result := Integer(Env.Lib.Fisc_portable_integer(@buff[3], Smallint(iLen)));
  ASSERT(buff[3 + iLen] = isc_info_end);
end;

{-------------------------------------------------------------------------------}
function TIBDatabase.GetDatabaseInfoStr(AInfo: Integer): String;
var
  buff: array [0..1024] of Byte;
  iLen1, iLen2: Integer;
begin
  GetDatabaseInfo(AInfo, @buff, SizeOf(buff));
  iLen1 := Integer(Env.Lib.Fisc_portable_integer(@buff[1], 2));
  iLen2 := Integer(Env.Lib.Fisc_portable_integer(@buff[3], Smallint(iLen1)));
  Result := FEncoder.Decode(@buff[3 + iLen1], iLen2);
  ASSERT(buff[3 + iLen1 + iLen2] = isc_info_end);
end;

{-------------------------------------------------------------------------------}
function TIBDatabase.GetDatabaseInfoBool(AInfo: Integer): Boolean;
begin
  Result := GetDatabaseInfoInt(AInfo) <> 0;
end;

{-------------------------------------------------------------------------------}
function TIBDatabase.GetDatabaseInfoOpers(AInfo: Integer): TStrings;
var
  buff: array [0..32760] of Byte;
  iTabs, i, iTabId, iOpers: Integer;
begin
  GetDatabaseInfo(AInfo, @buff, SizeOf(buff));
  Result := FList;
  Result.Clear;
  iTabs := Integer(Env.Lib.Fisc_portable_integer(@buff[1], 2)) div 6;
  for i := 0 to iTabs - 1 do begin
    iTabId := Integer(Env.Lib.Fisc_portable_integer(@buff[3 + (i * 6)], 2));
    iOpers := Integer(Env.Lib.Fisc_portable_integer(@buff[5 + (i * 6)], 4));
    Result.Add(Format('%d=%d', [iTabId, iOpers]));
  end;
end;

{-------------------------------------------------------------------------------}
function TIBDatabase.GetDatabaseInfoInts(AInfo: Integer): TStrings;
begin
                                   
                                    
                        
   
  Result := FList;
  Result.Clear;
end;

{-------------------------------------------------------------------------------}
function TIBDatabase.GetDatabaseInfoUserNames(AInfo: Integer): TStrings;
var
  buff: array [0..32760] of Byte;
  i, iLen: Integer;
  s: String;
begin
  GetDatabaseInfo(AInfo, @buff, SizeOf(buff));
  Result := FList;
  Result.Clear;
  i := 0;
  while buff[i] = AInfo do begin
    Inc(i, 3);
    iLen := Integer(buff[i]);
    Inc(i);
    s := FEncoder.Decode(@buff[i], iLen);
    Inc(i, iLen);
    Result.Add(s);
  end;
  ASSERT(buff[i] = isc_info_end);
end;

{-------------------------------------------------------------------------------}
function TIBDatabase.GetDatabaseInfoStrsCnt(AInfo: Integer): TStrings;
var
  buff: array [0..32760] of Byte;
  i, iTotal, iCnt, iLen: Integer;
  s: String;
begin
  GetDatabaseInfo(AInfo, @buff, SizeOf(buff));
  Result := FList;
  Result.Clear;
  iTotal := Integer(Env.Lib.Fisc_portable_integer(@buff[1], 2));
  i := 3;
  iCnt := buff[i];
  Inc(i);
  while (iCnt > 0) and (i < iTotal + 3) do begin
    iLen := buff[i];
    Inc(i);
    s := FEncoder.Decode(@buff[i], iLen);
    Inc(i, iLen);
    Result.Add(s);
    Dec(iCnt);
  end;
  ASSERT(buff[i] = isc_info_end);
end;

{-------------------------------------------------------------------------------}
{ TIBTransaction                                                                }
{-------------------------------------------------------------------------------}
const
  TRPBInfo_Items = 22;
  TRPBInfos: array[1 .. TRPBInfo_Items] of TIBPBInfo = (
    (Name: 'consistency';      ParamType: prNoneNoZ; Code: isc_tpb_consistency),
    (Name: 'concurrency';      ParamType: prNoneNoZ; Code: isc_tpb_concurrency),
    (Name: 'shared';           ParamType: prNoneNoZ; Code: isc_tpb_shared),
    (Name: 'protected';        ParamType: prNoneNoZ; Code: isc_tpb_protected),
    (Name: 'exclusive';        ParamType: prNoneNoZ; Code: isc_tpb_exclusive),
    (Name: 'wait';             ParamType: prNoneNoZ; Code: isc_tpb_wait),
    (Name: 'nowait';           ParamType: prNoneNoZ; Code: isc_tpb_nowait),
    (Name: 'read';             ParamType: prNoneNoZ; Code: isc_tpb_read),
    (Name: 'write';            ParamType: prNoneNoZ; Code: isc_tpb_write),
    (Name: 'lock_read';        ParamType: prStrg;    Code: isc_tpb_lock_read),
    (Name: 'lock_write';       ParamType: prStrg;    Code: isc_tpb_lock_write),
    (Name: 'verb_time';        ParamType: prNoneNoZ; Code: isc_tpb_verb_time),
    (Name: 'commit_time';      ParamType: prNoneNoZ; Code: isc_tpb_commit_time),
    (Name: 'ignore_limbo';     ParamType: prNoneNoZ; Code: isc_tpb_ignore_limbo),
    (Name: 'read_committed';   ParamType: prNoneNoZ; Code: isc_tpb_read_committed),
    (Name: 'autocommit';       ParamType: prNoneNoZ; Code: isc_tpb_autocommit),
    (Name: 'rec_version';      ParamType: prNoneNoZ; Code: isc_tpb_rec_version),
    (Name: 'no_rec_version';   ParamType: prNoneNoZ; Code: isc_tpb_no_rec_version),
    (Name: 'restart_requests'; ParamType: prNoneNoZ; Code: isc_tpb_restart_requests),
    (Name: 'no_auto_undo';     ParamType: prNoneNoZ; Code: isc_tpb_no_auto_undo),
    // IB75
    (Name: 'no_savepoint';     ParamType: prNoneNoZ; Code: isc_tpb_no_savepoint),
    // FB20
    (Name: 'lock_timeout';     ParamType: prCard;    Code: isc_tpb_lock_timeout)
   );

{-------------------------------------------------------------------------------}
constructor TIBTransaction.Create(AEnv: TIBEnv; AOwningObj: TObject);
begin
  inherited Create(AEnv, AOwningObj);
  FEncoder := TFDEncoder.Create(nil);
  FEncoder.Encoding := ecANSI;
  FParams := TFDStringList.Create;
  TFDStringList(FParams).OnChange := DoParamsChanged;
  FDatabases := TFDObjList.Create;
  FOwnHandle := True;
end;

{-------------------------------------------------------------------------------}
constructor TIBTransaction.CreateUsingHandle(AEnv: TIBEnv;
  AHandle: isc_tr_handle; AOwningObj: TObject);
begin
  Create(AEnv, AOwningObj);
  FTRHandle := AHandle;
  FOwnHandle := False;
end;

{-------------------------------------------------------------------------------}
destructor TIBTransaction.Destroy;
begin
  FDFreeAndNil(FParams);
  FDFreeAndNil(FDatabases);
  FDFreeAndNil(FEncoder);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TIBTransaction.SetParams(const AValue: TStrings);
begin
  FParams.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TIBTransaction.DoParamsChanged(ASender: TObject);
begin
  FChanged := True;
end;

{-------------------------------------------------------------------------------}
procedure TIBTransaction.AddDatabase(ADB: TIBDatabase);
begin
  Env.Lib.Lock;
  try
    FDatabases.Add(ADB);
    FChanged := True;
  finally
    Env.Lib.Unlock;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBTransaction.RemoveDatabase(ADB: TIBDatabase);
begin
  Env.Lib.Lock;
  try
    FDatabases.Remove(ADB);
    FChanged := True;
  finally
    Env.Lib.Unlock;
  end;
end;

{-------------------------------------------------------------------------------}
function TIBTransaction.FilterTRParam(const AInfo: TIBPBInfo): TIBPBParamType;
begin
  Result := AInfo.ParamType;
  if (AInfo.Name = 'no_savepoint') and (AInfo.Code = isc_tpb_lock_timeout) then
    if not ((Env.Lib.Brand = ibFirebird) and (Env.Lib.Version >= ivFB020000)) then
      Result := prIgno;
  if (AInfo.Name = 'lock_timeout') and (AInfo.Code = isc_tpb_no_savepoint) then
    if not ((Env.Lib.Brand = ibInterbase) and (Env.Lib.Version >= ivIB070500)) then
      Result := prIgno;
end;

{-------------------------------------------------------------------------------}
procedure TIBTransaction.Update;
var
  i: Integer;
  pTEB: PISCTEB;
begin
  FTPB := Env.BuildPB(FEncoder, FParams, isc_tpb_version3, 0,
    PIBPBInfoArr(@TRPBInfos), TRPBInfo_Items, FilterTRParam);
  SetLength(FTEBs, FDataBases.Count);
  for i := 0 to FDataBases.Count - 1 do begin
    pTEB := @FTEBs[i];
    pTEB^.Handle  := @TIBDatabase(FDataBases[i]).FDbHandle;
    pTEB^.Len     := Length(FTPB);
    pTEB^.Address := PByte(PByte(FTPB));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBTransaction.StartTransaction;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_start_multiple, ['count', FDataBases.Count, 'params', FParams.CommaText]);
  end;
{$ENDIF}

begin
  if not FOwnHandle then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if FChanged then begin
    FChanged := False;
    Update;
  end;
  ASSERT(Length(FTEBs) > 0);
  Check(Lib.Fisc_start_multiple(@Error.FStatusVector, @FTrHandle,
    Smallint(FDataBases.Count), @FTEBs[0]));
end;

{-------------------------------------------------------------------------------}
procedure TIBTransaction.Commit;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_commit_transaction, ['tra_handle', FTRHandle]);
  end;
{$ENDIF}

begin
  if not FOwnHandle then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  try
    Check(Lib.Fisc_commit_transaction(@Error.FStatusVector, @FTrHandle));
  except
    on E: EIBNativeException do
      if E.Kind = ekServerGone then
        FTrHandle := nil
      else
        raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBTransaction.CommitRetaining;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_commit_retaining, ['tra_handle', FTRHandle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  try
    Check(Lib.Fisc_commit_retaining(@Error.FStatusVector, @FTrHandle));
  except
    on E: EIBNativeException do
      if E.Kind = ekServerGone then
        FTrHandle := nil
      else
        raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBTransaction.Rollback;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_rollback_transaction, ['tra_handle', FTRHandle]);
  end;
{$ENDIF}

begin
  if not FOwnHandle then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  try
    Check(Lib.Fisc_rollback_transaction(@Error.FStatusVector, @FTrHandle));
  except
    on E: EIBNativeException do
      if E.Kind = ekServerGone then
        FTrHandle := nil
      else
        raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBTransaction.RollbackRetaining;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_rollback_retaining, ['tra_handle', FTRHandle]);
  end;
{$ENDIF}

begin
  if not FOwnHandle then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  try
    Check(Lib.Fisc_rollback_retaining(@Error.FStatusVector, @FTrHandle));
  except
    on E: EIBNativeException do
      if E.Kind = ekServerGone then
        FTrHandle := nil
      else
        raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBTransaction.Prepare(const AMsg: String);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    if AMsg = '' then
      Env.Trace(sisc_prepare_transaction, ['tra_handle', FTRHandle])
    else
      Env.Trace(sisc_prepare_transaction2, ['tra_handle', FTRHandle, 'msg', AMsg]);
  end;
{$ENDIF}

var
  sb: TFDByteString;
begin
  if not FOwnHandle then
    Exit;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if AMsg = '' then
    Check(Lib.Fisc_prepare_transaction(@Error.FStatusVector, @FTrHandle))
  else begin
    sb := TFDEncoder.Enco(AMsg, ecANSI);
    Check(Lib.Fisc_prepare_transaction2(@Error.FStatusVector, @FTrHandle,
      Smallint(TFDEncoder.EncoLength(sb, ecANSI)), PISC_UCHAR(PByte(sb))));
  end;
end;

{-------------------------------------------------------------------------------}
function TIBTransaction.GetTransactionID: Int64;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_transaction_info, ['tra_handle', FTRHandle,
      'item_list_buffer', isc_info_tra_id]);
  end;
{$ENDIF}

var
 lb: array [0..0] of Byte;
 rb: array [0..31] of Byte;
 iLen: Integer;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  lb[0] := isc_info_tra_id;
  Check(Lib.Fisc_transaction_info(@Error.FStatusVector, @FTRHandle,
    Smallint(SizeOf(lb)), PISC_SCHAR(@lb), Smallint(SizeOf(rb)), PISC_SCHAR(@rb)));
  iLen := Integer(Lib.Fisc_portable_integer(@rb[1], 2));
  Result := Lib.Fisc_portable_integer(@rb[3], iLen);
end;

{-------------------------------------------------------------------------------}
{ TIBEventThread                                                                }
{-------------------------------------------------------------------------------}
type
  TIBEventThread = class(TThread)
  private
    FSlice: TIBEventSlice;
  protected
    procedure Execute; override;
  end;

{-------------------------------------------------------------------------------}
procedure TIBEventThread.Execute;
begin
  FSlice.FEvents.QueueEvents(FSlice);
  while not Terminated do begin
    if FSlice.FEvent.WaitFor($FFFFFFFF) <> wrSignaled then
      Terminate;
    if not Terminated then
      try
        FSlice.FEvents.HandleEvents(FSlice);
        FSlice.FEvents.QueueEvents(FSlice);
      finally
        FSlice.FSysAlert := False;
      end;
  end;
end;

{-------------------------------------------------------------------------------}
{ TIBEvents                                                                     }
{-------------------------------------------------------------------------------}
constructor TIBEvents.Create(ADatabase: TIBDatabase; AOwningObj: TObject);
begin
  inherited Create(ADatabase.Env, AOwningObj);
  FDatabase := ADatabase;
  FNames := TFDStringList.Create;
  FSlices := TFDObjList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TIBEvents.Destroy;
begin
  Stop;
  FDatabase := nil;
  FDFreeAndNil(FNames);
  FDFreeAndNil(FSlices);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure EventCallback(AUserData: Pointer; ALength: Smallint; AUpdated: PByte); cdecl;
var
  oSlice: TIBEventSlice;
begin
  ASSERT(AUserData <> nil);
  oSlice := TIBEventSlice(AUserData);
  if (AUpdated <> nil) and (ALength <> 0) then begin
    Move(AUpdated^, oSlice.FResultBuffer^, ALength);
    oSlice.FEvent.SetEvent;
  end
  else
    oSlice.FSysAlert := False;
end;

{-------------------------------------------------------------------------------}
procedure TIBEvents.QueueEvents(ASlice: TIBEventSlice);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_que_events, ['db_handle', FDatabase.FDBHandle]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  ASlice.FSysAlert := True;
  Check(Lib.Fisc_que_events(@Error.FStatusVector, @FDatabase.FDBHandle,
    @ASlice.FEventsID, ASlice.FBufferLength, ASlice.FEventBuffer,
    @EventCallback, ASlice));
end;

{-------------------------------------------------------------------------------}
procedure TIBEvents.HandleEvents(ASlice: TIBEventSlice);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_event_counts, ['id', ASlice.FEventsID]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Lib.Fisc_event_counts(@ASlice.FStatusVector, ASlice.FBufferLength,
    ASlice.FEventBuffer, ASlice.FResultBuffer);
  if not ASlice.FSysAlert and Assigned(FOnFired) then
    FOnFired(Self, ASlice.FBaseIndex, ASlice.FStatusVector);
end;

{-------------------------------------------------------------------------------}
{$WARNINGS OFF}
procedure TIBEvents.Start;
var
  aNames: array [0 .. 14] of TFDByteString;
  iDone, n, i: Integer;
  oSlice: TIBEventSlice;

  function E(AIndex: Integer): PISC_UCHAR;
  begin
    if AIndex >= n then
      Result := nil
    else
      Result := PISC_UCHAR(PByte(aNames[AIndex]));
  end;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_event_block, ['count', n, 'n0', aNames[0], 'n1', aNames[1],
      'n2', aNames[2], 'n3', aNames[3], 'n4', aNames[4], 'n5', aNames[5],
      'n6', aNames[6], 'n7', aNames[7], 'n8', aNames[8], 'n9', aNames[9],
      'n10', aNames[10], 'n11', aNames[11], 'n12', aNames[12], 'n13', aNames[13],
      'n14', aNames[14]]);
  end;

  procedure Trace2;
  begin
    Env.Trace(sisc_que_events, ['db_handle', FDatabase.FDBHandle]);
  end;
{$ENDIF}

begin
  iDone := 0;
  while iDone < FNames.Count do begin
    oSlice := TIBEventSlice.Create;
    oSlice.FEvent := TEvent.Create(nil, False, False, '');
    oSlice.FThread := TIBEventThread.Create(True);
    oSlice.FThread.FreeOnTerminate := False;
    TIBEventThread(oSlice.FThread).FSlice := oSlice;

    FSlices.Add(oSlice);
    oSlice.FEvents := Self;
    oSlice.FBaseIndex := iDone;

    n := FNames.Count - iDone;
    if n > 15 then
      n := 15;
    for i := 0 to n - 1 do
      aNames[i] := FDatabase.Encoder.Encode(FNames[iDone + i]);
    for i := n to 14 do
      SetLength(aNames[i], 0);
    Inc(iDone, n);

{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
{$IFDEF FireDAC_IB_STATIC}
    oSlice.FBufferLength := isc_event_block(oSlice.FEventBuffer,
      oSlice.FResultBuffer, SmallInt(n), E(0), E(1), E(2), E(3), E(4),
      E(5), E(6), E(7), E(8), E(9), E(10), E(11), E(12), E(13), E(14));
{$ELSE}
    oSlice.FBufferLength := Lib.Fisc_event_block(oSlice.FEventBuffer,
      oSlice.FResultBuffer, SmallInt(n), E(0), E(1), E(2), E(3), E(4),
      E(5), E(6), E(7), E(8), E(9), E(10), E(11), E(12), E(13), E(14));
{$ENDIF}

    oSlice.FThread.Resume;
  end;
end;
{$WARNINGS ON}

{-------------------------------------------------------------------------------}
procedure TIBEvents.Stop;
var
  i: Integer;
  oSlice: TIBEventSlice;
  iId: ISC_LONG;
  t: Cardinal;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_cancel_events, ['db_handle', FDatabase.FDBHandle,
      'id', oSlice.FEventsID]);
  end;
{$ENDIF}

  procedure WaitForSysAlert;
  var
    t: Cardinal;
  begin
    t := TThread.GetTickCount;
    while oSlice.FSysAlert and not FDTimeout(t, C_FD_ThreadStartupTimeout) do
      Sleep(1);
  end;

begin
  for i := 0 to FSlices.Count - 1 do begin
    oSlice := TIBEventSlice(FSlices[i]);
    WaitForSysAlert;

    if oSlice.FEventsID <> 0 then begin
{$IFDEF FireDAC_MONITOR}
      if Env.Tracing then Trace1;
{$ENDIF}
      iId := oSlice.FEventsID;
      oSlice.FEventsID := 0;
      oSlice.FSysAlert := True;
      Check(Lib.Fisc_cancel_events(@Error.FStatusVector, @FDatabase.FDBHandle, @iId));
      WaitForSysAlert;
    end;

    oSlice.FThread.Terminate;
    oSlice.FEvent.SetEvent;
    t := TThread.GetTickCount;
    while not oSlice.FThread.Finished and not FDTimeout(t, C_FD_ThreadStartupTimeout) do
      Sleep(1);

    if oSlice.FEventBuffer <> nil then begin
      Lib.Fisc_free(oSlice.FEventBuffer);
      oSlice.FEventBuffer := nil;
    end;
    if oSlice.FResultBuffer <> nil then begin
      Lib.Fisc_free(oSlice.FResultBuffer);
      oSlice.FResultBuffer := nil;
    end;

    FDFreeAndNil(oSlice.FThread);
    FDFreeAndNil(oSlice.FEvent);
    FDFree(oSlice);
  end;
  FSlices.Clear;
end;

{-------------------------------------------------------------------------------}
{ TIBVariables                                                                  }
{-------------------------------------------------------------------------------}
constructor TIBVariables.Create(AStatement: TIBStatement);
begin
  inherited Create(AStatement.Env, AStatement.OwningObj);
  FList := TFDObjList.Create;
  FStatement := AStatement;
  FV2 := (FStatement.Env.Lib.Brand = ibInterbase) and
    (FStatement.Env.Lib.Version >= ivIB070000);
  FRowCount := 1;
end;

{-------------------------------------------------------------------------------}
destructor TIBVariables.Destroy;
begin
  VarCount := 0;
  RowCount := 0;
  ReleaseBuff;
  FDFreeAndNil(FList);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TIBVariables.GetItems(AIndex: Cardinal): TIBVariable;
begin
  Result := TIBVariable(FList[AIndex]);
end;

{-------------------------------------------------------------------------------}
function TIBVariables.GetVarCount: Smallint;
begin
  Result := Smallint(FList.Count);
end;

{-------------------------------------------------------------------------------}
procedure TIBVariables.SetVarCount(ACount: Smallint);
begin
  if ACount = VarCount then
    Exit;
  ReleaseBuff;
  while VarCount > ACount do
    FDFree(TIBVariable(FList[VarCount - 1]));
  while VarCount < ACount do
    TIBVariable.Create(Self);
  if VarCount = 0 then begin
    FreeMem(FXSQLDA);
    FXSQLDA := nil;
  end
  else if V2 then begin
    ReallocMem(FXSQLDA, XSQLDA_LENGTH_V2(VarCount));
    FillChar(FXSQLDA^, XSQLDA_LENGTH_V2(VarCount), 0);
    FXSQLDA^.version := SQLDA_VERSION2;
    FXSQLDA^.sqln := VarCount;
    FXSQLDA^.sqld := VarCount;
  end
  else begin
    ReallocMem(FXSQLDA, XSQLDA_LENGTH_V1(VarCount));
    FillChar(FXSQLDA^, XSQLDA_LENGTH_V1(VarCount), 0);
    FXSQLDA^.version := SQLDA_VERSION1;
    FXSQLDA^.sqln := VarCount;
    FXSQLDA^.sqld := VarCount;
  end;
end;

{-------------------------------------------------------------------------------}
function TIBVariables.AdjustCount: Boolean;
begin
  if (FXSQLDA <> nil) and (VarCount <> FXSQLDA^.sqld) then begin
    VarCount := FXSQLDA^.sqld;
    Result := True;
  end
  else
    Result := False;
end;

{-------------------------------------------------------------------------------}
procedure TIBVariables.SetRowCount(AValue: Word);
begin
  if FRowCount = AValue then
    Exit;
  ReleaseBuff;
  FRowCount := AValue;
  if RowCount <= 1 then begin
    FreeMem(FXSQLVAR);
    FXSQLVAR := nil;
    SetLength(FRowsAffected, 0);
  end
  else begin
    ReallocMem(FXSQLVAR, XSQLVAR_LENGTH(RowCount, VarCount));
    FillChar(FXSQLVAR^, XSQLVAR_LENGTH(RowCount, VarCount), 0);
    SetLength(FRowsAffected, RowCount);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBVariables.AllocateBuff;
var
  i, j: Integer;
  pVar: PXSQLVar;
  pBaseVar: PXSQLVAR_V2;
  oVar: TIBVariable;
  pBuff: PByte;
  lMultyRows: Boolean;
begin
  if VarCount = 0 then
    Exit;

  FBuffSize := 0;
  for i := 0 to VarCount - 1 do begin
    oVar := TIBVariable(FList[i]);
    if oVar.FDataSize = 0 then
      oVar.FDataSize := oVar.sqllen;
    Inc(FBuffSize, oVar.BindSize * RowCount);
  end;

  GetMem(FBuff, FBuffSize);
  FillChar(FBuff^, FBuffSize, 0);
  pBuff := FBuff;

  lMultyRows := RowCount > 1;
  if lMultyRows then begin
    ASSERT(V2);
    pVar := FXSQLVAR;
    pBaseVar := PXSQLVAR_V2(@FXSQLDA^.sqlvar);
  end
  else begin
    pBaseVar := nil;
    if V2 then
      pVar := PXSQLVAR_V2(@FXSQLDA^.sqlvar)
    else
      pVar := PXSQLVAR_V1(@FXSQLDA^.sqlvar);
  end;

  for j := 0 to RowCount - 1 do
    if V2 then begin
      if lMultyRows then
        pBaseVar := PXSQLVAR_V2(@FXSQLDA^.sqlvar);
      for i := 0 to VarCount - 1 do begin
        oVar := TIBVariable(FList[i]);
        PXSQLVAR_V2(pVar)^.sqlind := PSmallInt(pBuff);
        PSmallInt(pBuff)^ := -1;
        if oVar.SQLDataType = SQL_NULL then
          PXSQLVAR_V2(pVar)^.sqldata := nil
        else
          PXSQLVAR_V2(pVar)^.sqldata := PByte(PByte(pBuff) + C_VarIndSize);
        PXSQLVAR_V2(pVar)^.sqllen := Smallint(oVar.DataSize);
        if oVar.SQLDataType = SQL_VARYING then
          PVary(PXSQLVAR_V2(pVar)^.sqldata).vary_length := Smallint(oVar.DataSize);
        if lMultyRows then begin
          PXSQLVAR_V2(pVar)^.sqltype := pBaseVar^.sqltype;
          PXSQLVAR_V2(pVar)^.sqlscale := pBaseVar^.sqlscale;
          PXSQLVAR_V2(pVar)^.sqlprecision := pBaseVar^.sqlprecision;
          PXSQLVAR_V2(pVar)^.sqlsubtype := pBaseVar^.sqlsubtype;
          pBaseVar := PXSQLVar(NativeUInt(pBaseVar) + SizeOf(XSQLVAR_V2));
        end;
        pVar := PXSQLVar(NativeUInt(pVar) + SizeOf(XSQLVAR_V2));
        pBuff := PByte(PByte(pBuff) + oVar.BindSize);
      end;
    end
    else begin
      for i := 0 to VarCount - 1 do begin
        oVar := TIBVariable(FList[i]);
        PXSQLVAR_V1(pVar)^.sqlind := PISC_SHORT(pBuff);
        PSmallInt(pBuff)^ := -1;
        if oVar.SQLDataType = SQL_NULL then
          PXSQLVAR_V1(pVar)^.sqldata := nil
        else
          PXSQLVAR_V1(pVar)^.sqldata := PISC_SCHAR(PByte(pBuff) + C_VarIndSize);
        PXSQLVAR_V1(pVar)^.sqllen := Smallint(oVar.DataSize);
        if oVar.SQLDataType = SQL_VARYING then
          PVary(PXSQLVAR_V1(pVar)^.sqldata).vary_length := Smallint(oVar.DataSize);
        pVar := PXSQLVar(NativeUInt(pVar) + SizeOf(XSQLVAR_V1));
        pBuff := PByte(PByte(pBuff) + oVar.BindSize);
      end;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TIBVariables.ReleaseBuff;
begin
  if FBuff <> nil then begin
    FreeMem(FBuff);
    FBuff := nil;
    FBuffSize := 0;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBVariables.CheckBuff;
begin
  if FBuff = nil then
    AllocateBuff;
end;

{-------------------------------------------------------------------------------}
function TIBVariables.GetBuffSize: Cardinal;
begin
  CheckBuff;
  Result := FBuffSize;
end;

{-------------------------------------------------------------------------------}
{ TIBVariable                                                                   }
{-------------------------------------------------------------------------------}
constructor TIBVariable.Create(AVars: TIBVariables);
begin
  inherited Create(AVars.Env, AVars.OwningObj);
  FVars := AVars;
  FIndex := AVars.FList.Add(Self);
end;

{-------------------------------------------------------------------------------}
destructor TIBVariable.Destroy;
begin
  FVars.FList.Remove(Self);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TIBVariable.LayoutChanged;
begin
  FVars.ReleaseBuff;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.Decode(const ASrc: Pointer; ASrcLen: Integer): String;
begin
  Result := FVars.Statement.Database.Encoder.Decode(ASrc, ASrcLen);
end;

{-------------------------------------------------------------------------------}
function TIBVariable.GetNational: Boolean;
var
  iType: SmallInt;
begin
  iType := SQLDataType;
  Result := ((iType = SQL_TEXT) or (iType = SQL_VARYING)) and
    ((Vars.Statement.Database.Encoder.Encoding = ecUTF8) or Lib.IsUTF8(sqlsubtype));
end;

{-------------------------------------------------------------------------------}
function TIBVariable.GetBaseXSQLVarV1: PXSQLVAR_V1;
begin
  ASSERT(not FVars.V2);
  Result := PXSQLVAR_V1(NativeUInt(@FVars.FXSQLDA.sqlvar) + SizeOf(XSQLVAR_V1) * FIndex);
end;

{-------------------------------------------------------------------------------}
function TIBVariable.GetBaseXSQLVarV2: PXSQLVAR_V2;
begin
  ASSERT(FVars.V2);
  Result := PXSQLVAR_V2(NativeUInt(@FVars.FXSQLDA.sqlvar) + SizeOf(XSQLVAR_V2) * FIndex);
end;

{-------------------------------------------------------------------------------}
function TIBVariable.GetDataXSQLVarV1(ARowIndex: LongWord): PXSQLVAR_V1;
begin
  ASSERT(not FVars.V2 and (ARowIndex = 0) and (FVars.RowCount <= 1));
  Result := BaseXSQLVarV1;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.GetDataXSQLVarV2(ARowIndex: LongWord): PXSQLVAR_V2;
begin
  ASSERT(FVars.V2 and (ARowIndex <= $7FFFFFFF) and (ARowIndex < FVars.RowCount));
  if FVars.RowCount <= 1 then
    Result := BaseXSQLVarV2
  else
    Result := PXSQLVAR_V2(NativeUInt(FVars.FXSQLVAR) +
      Word(SizeOf(XSQLVAR_V2)) * Word(FVars.VarCount) * ARowIndex +
      Word(SizeOf(XSQLVAR_V2)) * FIndex);
end;

{-------------------------------------------------------------------------------}
function TIBVariable.GetIsNulls(ARowIndex: LongWord): Boolean;
var
  pVarV2: PXSQLVAR_V2;
  pVarV1: PXSQLVAR_V1;
begin
  if FVars.V2 then begin
    pVarV2 := DataXSQLVarV2[ARowIndex];
    Result := (pVarV2^.sqlind^ < 0) or (pVarV2^.sqldata = nil);
  end
  else begin
    pVarV1 := DataXSQLVarV1[ARowIndex];
    Result := (pVarV1^.sqlind^ < 0) or (pVarV1^.sqldata = nil);
  end;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.GetUpdates(ARowIndex: LongWord): TIBUpdateStatus;
var
  pVarV2: PXSQLVAR_V2;
begin
  ASSERT(FVars.V2);
  Result := [];
  pVarV2 := DataXSQLVarV2[ARowIndex];
  if (pVarV2^.sqlind^ <> -1) and
     (pVarV2^.sqlind^ and SQLIND_CHANGE_VIEW = SQLIND_CHANGE_VIEW) then begin
    if pVarV2^.sqlind^ and SQLIND_INSERT = SQLIND_INSERT then
      Include(Result, iuInserted);
    if pVarV2^.sqlind^ and SQLIND_UPDATE = SQLIND_UPDATE then
      Include(Result, iuUpdated);
    if pVarV2^.sqlind^ and SQLIND_DELETE = SQLIND_DELETE then
      Include(Result, iuDeleted);
    if pVarV2^.sqlind^ and SQLIND_CHANGE = SQLIND_CHANGE then
      Result := [iuModified];
  end;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.GetIsNullable: Boolean;
begin
  Result := sqltype and 1 <> 0;
end;

{-------------------------------------------------------------------------------}
procedure TIBVariable.SetIsNullable(const AValue: Boolean);
begin
  if AValue then
    sqltype := sqltype or 1
  else
    sqltype := sqltype and not 1;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.GetSQLDataType: Smallint;
begin
  Result := sqltype and not 1;
end;

{-------------------------------------------------------------------------------}
procedure TIBVariable.SetSQLDataType(const AValue: Smallint);
begin
  sqltype := AValue or sqltype and 1;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.Getaliasname: String;
var
  pVarV2: PXSQLVAR_V2;
  pVarV1: PXSQLVAR_V1;
begin
  if FVars.V2 then begin
    pVarV2 := BaseXSQLVarV2;
    Result := Decode(@pVarV2^.aliasname, pVarV2^.aliasname_length);
  end
  else begin
    pVarV1 := BaseXSQLVarV1;
    Result := Decode(@pVarV1^.aliasname, pVarV1^.aliasname_length);
  end;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.Getownname: String;
var
  pVarV2: PXSQLVAR_V2;
  pVarV1: PXSQLVAR_V1;
begin
  if FVars.V2 then begin
    pVarV2 := BaseXSQLVarV2;
    Result := Decode(@pVarV2^.ownname, pVarV2^.ownname_length);
  end
  else begin
    pVarV1 := BaseXSQLVarV1;
    Result := Decode(@pVarV1^.ownname, pVarV1^.ownname_length);
  end;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.Getrelname: String;
var
  pVarV2: PXSQLVAR_V2;
  pVarV1: PXSQLVAR_V1;
begin
  if FVars.V2 then begin
    pVarV2 := BaseXSQLVarV2;
    Result := Decode(@pVarV2^.relname, pVarV2^.relname_length);
  end
  else begin
    pVarV1 := BaseXSQLVarV1;
    Result := Decode(@pVarV1^.relname, pVarV1^.relname_length);
  end;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.Getsqlname: String;
var
  pVarV2: PXSQLVAR_V2;
  pVarV1: PXSQLVAR_V1;
begin
  if FVars.V2 then begin
    pVarV2 := BaseXSQLVarV2;
    Result := Decode(@pVarV2^.sqlname, pVarV2^.sqlname_length);
  end
  else begin
    pVarV1 := BaseXSQLVarV1;
    Result := Decode(@pVarV1^.sqlname, pVarV1^.sqlname_length);
  end;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.Getsqllen: Smallint;
begin
  if FVars.V2 then
    Result := BaseXSQLVarV2^.sqllen
  else
    Result := BaseXSQLVarV1^.sqllen;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.Getsqlscale: Smallint;
begin
  if FVars.V2 then
    Result := BaseXSQLVarV2^.sqlscale
  else
    Result := BaseXSQLVarV1^.sqlscale;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.Getsqlsubtype: Smallint;
begin
  if FVars.V2 then
    Result := BaseXSQLVarV2^.sqlsubtype
  else
    Result := BaseXSQLVarV1^.sqlsubtype;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.Getsqltype: Smallint;
begin
  if FVars.V2 then
    Result := BaseXSQLVarV2^.sqltype
  else
    Result := BaseXSQLVarV1^.sqltype;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.Getsqlprecision: Smallint;
begin
  if FVars.V2 then
    Result := BaseXSQLVarV2^.sqlprecision
  else
    Result := 0;
end;

{-------------------------------------------------------------------------------}
procedure TIBVariable.Setsqllen(const AValue: Smallint);
begin
  if FVars.V2 then
    BaseXSQLVarV2^.sqllen := AValue
  else
    BaseXSQLVarV1^.sqllen := AValue;
  LayoutChanged;
end;

{-------------------------------------------------------------------------------}
procedure TIBVariable.Setsqlscale(const AValue: Smallint);
begin
  if FVars.V2 then
    BaseXSQLVarV2^.sqlscale := AValue
  else
    BaseXSQLVarV1^.sqlscale := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TIBVariable.Setsqlsubtype(const AValue: Smallint);
begin
  if FVars.V2 then
    BaseXSQLVarV2^.sqlsubtype := AValue
  else
    BaseXSQLVarV1^.sqlsubtype := AValue;
  LayoutChanged;
end;

{-------------------------------------------------------------------------------}
procedure TIBVariable.Setsqltype(const AValue: Smallint);
begin
  if FVars.V2 then
    BaseXSQLVarV2^.sqltype := AValue
  else
    BaseXSQLVarV1^.sqltype := AValue;
  LayoutChanged;
end;

{-------------------------------------------------------------------------------}
procedure TIBVariable.Setsqlprecision(const AValue: Smallint);
begin
  if FVars.V2 then
    BaseXSQLVarV2^.sqlprecision := AValue;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.GetDataSize: LongWord;
begin
  if FDataSize = 0 then
    Result := sqllen
  else
    Result := FDataSize;
end;

{-------------------------------------------------------------------------------}
class function TIBVariable.GetDataTypeSize(AType: Smallint; ASize: LongWord): LongWord;
begin
  case AType of
  SQL_VARYING:    Result := SizeOf(ISC_USHORT) + ASize;
  SQL_TEXT:       Result := ASize;
  SQL_SHORT:      Result := SizeOf(ISC_SHORT);
  SQL_LONG:       Result := SizeOf(ISC_LONG);
  SQL_QUAD:       Result := SizeOf(ISC_QUAD);
  SQL_INT64:      Result := SizeOf(ISC_INT64);
  SQL_FLOAT:      Result := SizeOf(Single);
  SQL_D_FLOAT,
  SQL_DOUBLE:     Result := SizeOf(Double);
  SQL_BOOLEAN_IB: Result := SizeOf(ISC_BOOLEAN);
  SQL_BOOLEAN_FB: Result := SizeOf(Boolean);
  SQL_TIMESTAMP:  Result := SizeOf(ISC_TIMESTAMP);
  SQL_TYPE_TIME:  Result := SizeOf(ISC_TIME);
  SQL_TYPE_DATE:  Result := SizeOf(ISC_DATE);
  SQL_BLOB,
  SQL_ARRAY:      Result := SizeOf(ISC_QUAD);
  SQL_NULL:       Result := 0;
  else            Result := 0;
  end;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.GetBindSize: LongWord;
begin
  Result := (C_VarIndSize + GetDataTypeSize(SQLDataType, DataSize) +
    C_VarAlignment) and not C_VarAlignment;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.GetData(ARowIndex: LongWord; var ApData: Pointer;
  out ALen: LongWord; AByRef: Boolean = False): Boolean;
var
  pData, pWC: Pointer;
  iScale: Smallint;
  iSubType: Smallint;
  pVarV2: PXSQLVAR_V2;
  pVarV1: PXSQLVAR_V1;

  procedure Int2BCD(AIntSize: Integer);
  var
    aBuff: array[0..63] of Char;
    pBuff: PChar;
    iLen: Integer;
  begin
    pBuff := @aBuff[0];
    iLen := SizeOf(aBuff) div SizeOf(Char);
    FDInt2Str(pData, AIntSize, pBuff, iLen, False, -iScale);
    FDStr2BCD(pBuff, iLen, PBcd(ApData)^, FormatSettings.DecimalSeparator);
  end;

begin
  FVars.CheckBuff;
  if FVars.V2 then begin
    pVarV2 := DataXSQLVarV2[ARowIndex];
    Result := (pVarV2^.sqltype and 1 = 0) or (pVarV2^.sqlind^ >= 0);
    if not Result then begin
      ApData := nil;
      ALen := 0;
      Exit;
    end;
    ALen := pVarV2^.sqllen;
    pData := pVarV2^.sqldata;
    iScale := pVarV2^.sqlscale;
    iSubType := pVarV2^.sqlsubtype mod 256;
  end
  else begin
    pVarV1 := DataXSQLVarV1[ARowIndex];
    Result := (pVarV1^.sqltype and 1 = 0) or (pVarV1^.sqlind^ >= 0);
    if not Result then begin
      ApData := nil;
      ALen := 0;
      Exit;
    end;
    ALen := pVarV1^.sqllen;
    pData := pVarV1^.sqldata;
    iScale := pVarV1^.sqlscale;
    iSubType := pVarV1^.sqlsubtype mod 256;
  end;

  case SQLDataType of
  SQL_VARYING,
  SQL_TEXT:
    begin
      if SQLDataType = SQL_VARYING then begin
        ALen := PVary(pData)^.vary_length;
        pData := @PVary(pData)^.vary_string[0];
      end;
      if iSubType = csIDOctets then begin
        if (SQLDataType = SQL_TEXT) and FVars.Statement.StrsTrim and (FDDataType <> dtGUID) then
          while (ALen > 0) and (PByte(pData)[ALen - 1] = 0) do
            Dec(ALen);
        if (ALen = 0) and FVars.Statement.StrsEmpty2Null then begin
          Result := False;
          ALen := 0;
          if AByRef then
            ApData := nil;
        end
        else if AByRef then
          ApData := pData
        else if ApData <> nil then
          Move(PByte(pData)^, PByte(ApData)^, ALen * SizeOf(Byte));
      end
      else if Lib.IsUTF8(iSubType) then begin
        pWC := nil;
        ALen := FVars.Statement.Database.Encoder.Decode(pData, ALen, pWC, ecUTF16);
        pData := pWC;
        if (SQLDataType = SQL_TEXT) and FVars.Statement.StrsTrim then
          while (ALen > 0) and (PWideChar(pData)[ALen - 1] = ' ') do
            Dec(ALen);
        if (ALen = 0) and FVars.Statement.StrsEmpty2Null then begin
          Result := False;
          ALen := 0;
          if AByRef then
            ApData := nil;
        end
        else if AByRef then
          ApData := pData
        else if ApData <> nil then
          Move(PWideChar(pData)^, PWideChar(ApData)^, ALen * SizeOf(WideChar));
      end
      else begin
        if (SQLDataType = SQL_TEXT) and FVars.Statement.StrsTrim then
          while (ALen > 0) and (PFDAnsiString(pData)[ALen - 1] = TFDAnsiChar(' ')) do
            Dec(ALen);
        if (ALen = 0) and FVars.Statement.StrsEmpty2Null then begin
          Result := False;
          ALen := 0;
          if AByRef then
            ApData := nil;
        end
        else if AByRef then
          ApData := pData
        else if ApData <> nil then
          Move(PFDAnsiString(pData)^, PFDAnsiString(ApData)^, ALen * SizeOf(TFDAnsiChar));
      end;
    end;
  SQL_SHORT:
    if AByRef then
      ApData := pData
    else if ApData <> nil then
      if iScale < -4 then begin
        Int2BCD(SizeOf(SmallInt));
        ALen := SizeOf(TBcd);
      end
      else if iScale < 0 then begin
        PCurrency(ApData)^ := PSmallint(pData)^ / C_FD_ScaleFactor[- iScale];
        ALen := SizeOf(Currency);
      end
      else
        PSmallint(ApData)^ := PSmallint(pData)^;
  SQL_LONG:
    if AByRef then
      ApData := pData
    else if ApData <> nil then
      if iScale < -4 then begin
        Int2BCD(SizeOf(Integer));
        ALen := SizeOf(TBcd);
      end
      else if iScale < 0 then begin
        PCurrency(ApData)^ := PInteger(pData)^ / C_FD_ScaleFactor[- iScale];
        ALen := SizeOf(Currency);
      end
      else
        PInteger(ApData)^ := PInteger(pData)^;
  SQL_QUAD,
  SQL_INT64:
    if AByRef then
      ApData := pData
    else if ApData <> nil then
      if iScale <> 0 then begin
        Int2BCD(SizeOf(Int64));
        ALen := SizeOf(TBcd);
      end
      else
        PInt64(ApData)^ := PInt64(pData)^;
  SQL_FLOAT:
    if AByRef then
      ApData := pData
    else if ApData <> nil then begin
      ALen := SizeOf(Single);
      PSingle(ApData)^ := PSingle(pData)^;
    end;
  SQL_D_FLOAT,
  SQL_DOUBLE:
    if AByRef then
      ApData := pData
    else if ApData <> nil then
      PDouble(ApData)^ := PDouble(pData)^;
  SQL_BOOLEAN_IB:
    if AByRef then
      ApData := pData
    else if ApData <> nil then begin
      PWordBool(ApData)^ := PWordBool(pData)^;
      ALen := SizeOf(WordBool);
    end;
  SQL_BOOLEAN_FB:
    if AByRef then
      ApData := pData
    else if ApData <> nil then begin
      PWordBool(ApData)^ := PBoolean(pData)^;
      ALen := SizeOf(WordBool);
    end;
  SQL_TIMESTAMP:
    if AByRef then
      ApData := pData
    else if ApData <> nil then begin
      ALen := SizeOf(TSQLTimeStamp);
      FVars.Statement.Env.Lib.ISCTmSt2DlpTmSt(PISC_TIMESTAMP(pData)^, PSQLTimeStamp(ApData)^);
    end;
  SQL_TYPE_TIME:
    if AByRef then
      ApData := pData
    else if ApData <> nil then begin
      ALen := SizeOf(Integer);
      FVars.Statement.Env.Lib.ISCTm2DlpTm(PISC_TIME(pData)^, PInteger(ApData)^);
    end;
  SQL_TYPE_DATE:
    if AByRef then
      ApData := pData
    else if ApData <> nil then begin
      ALen := SizeOf(Integer);
      FVars.Statement.Env.Lib.ISCDt2DlpDt(PISC_DATE(pData)^, PInteger(ApData)^);
    end;
  SQL_BLOB,
  SQL_ARRAY:
    if AByRef then
      ApData := pData
    else if ApData <> nil then
      PISC_QUAD(ApData)^ := PISC_QUAD(pData)^;
  SQL_NULL:
    begin
      Result := False;
      ApData := nil;
      ALen := 0;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBVariable.SetData(ARowIndex: LongWord; ApData: Pointer;
  ALen: LongWord);
var
  lIsNull: Boolean;
  pData: Pointer;
  pInd: PSmallint;
  pLen: PSmallint;
  pUTF8: Pointer;
  iScale: Smallint;
  iSubType: Smallint;
  iByteLen: LongWord;
  pVarV2: PXSQLVAR_V2;
  pVarV1: PXSQLVAR_V1;

  procedure ErrorDataTooLarge(AMax, AActual: LongWord);
  begin
    FDException(FVars.Statement.OwningObj, [S_FD_LPhys, Lib.DriverID],
      er_FD_AccDataToLarge, [DumpLabel, AMax, AActual]);
  end;

  procedure GetIntDataType(ADefType: TFDDataType);
  begin
    if FDDataType = dtUnknown then
      if iScale < -4 then
        FDDataType := dtBCD
      else if iScale < 0 then
        FDDataType := dtCurrency
      else
        FDDataType := ADefType;
  end;

  procedure BCD2Int(AIntSize: Integer);
  var
    aBuff: array[0..63] of Char;
    iLen: Integer;
  begin
    FDBCD2Str(aBuff, iLen, PBcd(ApData)^, FormatSettings.DecimalSeparator);
    FDStr2Int(aBuff, iLen, pData, AIntSize, False, -iScale);
  end;

begin
  FVars.CheckBuff;
  if FVars.V2 then begin
    pVarV2 := DataXSQLVarV2[ARowIndex];
    pData := pVarV2^.sqldata;
    pInd := pVarV2^.sqlind;
    pLen := @pVarV2^.sqllen;
    iScale := pVarV2^.sqlscale;
    iSubType := pVarV2^.sqlsubtype mod 256;
  end
  else begin
    pVarV1 := DataXSQLVarV1[ARowIndex];
    pData := pVarV1^.sqldata;
    pInd := PSmallInt(pVarV1^.sqlind);
    pLen := @pVarV1^.sqllen;
    iScale := pVarV1^.sqlscale;
    iSubType := pVarV1^.sqlsubtype mod 256;
  end;

  lIsNull := ApData = nil;
  case SQLDataType of
  SQL_VARYING,
  SQL_TEXT:
    if iSubType = csIDOctets then begin
      if not lIsNull then begin
        if (SQLDataType = SQL_TEXT) and FVars.Statement.StrsTrim and (FDDataType <> dtGUID) then
          while (ALen > 0) and (PByte(ApData)[ALen - 1] = 0) do
            Dec(ALen);
        if FVars.Statement.StrsEmpty2Null and (ALen = 0) then
          lIsNull := True;
      end;
      if not lIsNull then begin
        if ALen > DataSize then
          ErrorDataTooLarge(DataSize, ALen);
        if SQLDataType = SQL_VARYING then begin
          PVary(pData)^.vary_length := Smallint(ALen);
          pData := @PVary(pData)^.vary_string[0];
        end
        else
          pLen^ := Smallint(ALen);
      end;
      if not lIsNull then
        Move(PByte(ApData)^, PByte(pData)^, ALen * SizeOf(Byte));
    end
    else if Lib.IsUTF8(iSubType) then begin
      if not lIsNull then begin
        if (SQLDataType = SQL_TEXT) and FVars.Statement.StrsTrim then
          while (ALen > 0) and (PWideChar(ApData)[ALen - 1] = ' ') do
            Dec(ALen);
        if FVars.Statement.StrsEmpty2Null and (ALen = 0) then
          lIsNull := True;
      end;
      if not lIsNull then begin
        pUTF8 := nil;
        iByteLen := FVars.Statement.Database.Encoder.Encode(ApData, ALen,
          pUTF8, ecUTF16);
        if iByteLen > DataSize then
          ErrorDataTooLarge(DataSize, iByteLen);
        if SQLDataType = SQL_VARYING then begin
          PVary(pData)^.vary_length := Smallint(iByteLen);
          pData := @PVary(pData)^.vary_string[0];
        end
        else
          pLen^ := Smallint(iByteLen);
        Move(PFDAnsiString(pUTF8)^, PFDAnsiString(pData)^, iByteLen * SizeOf(TFDAnsiChar));
      end;
    end
    else begin
      if not lIsNull then begin
        if (SQLDataType = SQL_TEXT) and FVars.Statement.StrsTrim then
          while (ALen > 0) and (PFDAnsiString(ApData)[ALen - 1] = TFDAnsiChar(' ')) do
            Dec(ALen);
        if FVars.Statement.StrsEmpty2Null and (ALen = 0) then
          lIsNull := True;
      end;
      if not lIsNull then begin
        iByteLen := ALen * SizeOf(TFDAnsiChar);
        if iByteLen > DataSize then
          ErrorDataTooLarge(DataSize, iByteLen);
        if SQLDataType = SQL_VARYING then begin
          PVary(pData)^.vary_length := Smallint(iByteLen);
          pData := @PVary(pData)^.vary_string[0];
        end
        else
          pLen^ := Smallint(iByteLen);
        Move(PFDAnsiString(ApData)^, PFDAnsiString(pData)^, iByteLen * SizeOf(TFDAnsiChar));
      end;
    end;
  SQL_SHORT:
    if lIsNull then
      PSmallint(pData)^ := 0
    else begin
      GetIntDataType(dtInt16);
      case FDDataType of
      dtInt16:
        PSmallint(pData)^ := PSmallint(ApData)^;
      dtCurrency:
                                                                     
        PSmallint(pData)^ := Smallint(Trunc(PCurrency(ApData)^ * C_FD_ScaleFactor[- iScale]));
      dtBCD,
      dtFmtBCD:
        BCD2Int(SizeOf(SmallInt));
      end;
    end;
  SQL_LONG:
    if lIsNull then
      PInteger(pData)^ := 0
    else begin
      GetIntDataType(dtInt32);
      case FDDataType of
      dtInt32:
        PInteger(pData)^ := PInteger(ApData)^;
      dtCurrency:
                                                                     
        PInteger(pData)^ := Integer(Trunc(PCurrency(ApData)^ * C_FD_ScaleFactor[- iScale]));
      dtBCD,
      dtFmtBCD:
        BCD2Int(SizeOf(Integer));
      end;
    end;
  SQL_QUAD,
  SQL_INT64:
    if lIsNull then
      PInt64(pData)^ := 0
    else begin
      GetIntDataType(dtInt64);
      case FDDataType of
      dtInt64:
        PInt64(pData)^ := PInt64(ApData)^;
      dtCurrency:
                                                                     
        PInt64(pData)^ := Int64(Trunc(PCurrency(ApData)^ * C_FD_ScaleFactor[- iScale]));
      dtBCD,
      dtFmtBCD:
        BCD2Int(SizeOf(Int64));
      end;
    end;
  SQL_FLOAT:
    if lIsNull then
      PSingle(pData)^ := 0.0
    else
      PSingle(pData)^ := PSingle(ApData)^;
  SQL_D_FLOAT,
  SQL_DOUBLE:
    if lIsNull then
      PDouble(pData)^ := 0.0
    else
      PDouble(pData)^ := PDouble(ApData)^;
  SQL_BOOLEAN_IB:
    if lIsNull then
      PWordBool(pData)^ := False
    else
      PWordBool(pData)^ := PWordBool(ApData)^;
  SQL_BOOLEAN_FB:
    if lIsNull then
      PBoolean(pData)^ := False
    else
      PBoolean(pData)^ := PWordBool(ApData)^;
  SQL_TIMESTAMP:
    if lIsNull then begin
      PISC_TIMESTAMP(pData)^.timestamp_date := 0;
      PISC_TIMESTAMP(pData)^.timestamp_time := 0;
    end
    else
      FVars.Statement.Env.Lib.DlpTmSt2ISCTmSt(PSQLTimeStamp(ApData)^, PISC_TIMESTAMP(pData)^);
  SQL_TYPE_TIME:
    if lIsNull then
      PISC_TIME(pData)^ := 0
    else
      FVars.Statement.Env.Lib.DlpTm2ISCTm(PInteger(ApData)^, PISC_TIME(pData)^);
  SQL_TYPE_DATE:
    if lIsNull then
      PISC_DATE(pData)^ := 0
    else
      FVars.Statement.Env.Lib.DlpDt2ISCDt(PInteger(ApData)^, PISC_DATE(pData)^);
  SQL_BLOB,
  SQL_ARRAY:
    if lIsNull then begin
      PISC_QUAD(pData)^.gds_quad_high := 0;
      PISC_QUAD(pData)^.gds_quad_low := 0;
    end
    else
      PISC_QUAD(pData)^ := PISC_QUAD(ApData)^;
  SQL_NULL:
    ;
  end;
  if lIsNull then
    pInd^ := -1
  else
    pInd^ := 0;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.GetData(var AData; out ALen: LongWord): Boolean;
var
  p: Pointer;
begin
  p := @AData;
  Result := GetData(0, p, ALen, False);
end;

{-------------------------------------------------------------------------------}
function TIBVariable.GetData(var AData): Boolean;
var
  iLen: LongWord;
begin
  Result := GetData(AData, iLen);
end;

{-------------------------------------------------------------------------------}
procedure TIBVariable.SetData(const AData; ALen: LongWord);
begin
  SetData(0, @AData, ALen);
end;

{-------------------------------------------------------------------------------}
function TIBVariable.GetAsString: String;
var
  pData: Pointer;
  uiLen: LongWord;
  iSubType: Smallint;
begin
  Result := '';
  pData := nil;
  uiLen := 0;

  if GetData(0, pData, uiLen, True) then begin
    if FVars.V2 then
      iSubType := DataXSQLVarV2[0]^.sqlsubtype mod 256
    else
      iSubType := DataXSQLVarV1[0]^.sqlsubtype mod 256;

    if Lib.IsUTF8(iSubType) then
      Result := FVars.Statement.Database.Encoder.Decode(pData, uiLen, ecUTF16)
    else
      Result := FVars.Statement.Database.Encoder.Decode(pData, uiLen, ecANSI);
  end;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.GetDumpLabel: String;
begin
  Result := '';
  if FDumpLabel <> '' then
    Result := FDumpLabel
  else if aliasname <> '' then
    Result := aliasname
  else begin
    if ownname <> '' then
      Result := ownname;
    if relname <> '' then begin
      if Result <> '' then
        Result := Result + '.';
      Result := Result + relname;
    end;
    if sqlname <> '' then begin
      if Result <> '' then
        Result := Result + '.';
      Result := Result + sqlname;
    end;
  end;
  if Result = '' then
    Result := Format('#%d', [FIndex + 1]);
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
function TIBVariable.DumpSQLDataType: String;
begin
  case SQLDataType of
  SQL_VARYING:    Result := 'SQL_VARYING';
  SQL_TEXT:       Result := 'SQL_TEXT';
  SQL_SHORT:      Result := 'SQL_SHORT';
  SQL_LONG:       Result := 'SQL_LONG';
  SQL_QUAD:       Result := 'SQL_QUAD';
  SQL_INT64:      Result := 'SQL_INT64';
  SQL_D_FLOAT:    Result := 'SQL_D_FLOAT';
  SQL_FLOAT:      Result := 'SQL_FLOAT';
  SQL_DOUBLE:     Result := 'SQL_DOUBLE';
  SQL_BOOLEAN_IB,
  SQL_BOOLEAN_FB: Result := 'SQL_BOOLEAN';
  SQL_TIMESTAMP:  Result := 'SQL_TIMESTAMP';
  SQL_TYPE_TIME:  Result := 'SQL_TYPE_TIME';
  SQL_TYPE_DATE:  Result := 'SQL_TYPE_DATE';
  SQL_BLOB:       Result := 'SQL_BLOB';
  SQL_ARRAY:      Result := 'SQL_ARRAY';
  SQL_NULL:       Result := 'SQL_NULL';
  else            Result := '#' + IntToStr(SQLDataType);
  end;
end;

{-------------------------------------------------------------------------------}
function TIBVariable.DumpValue(ARowIndex: LongWord): String;
var
  pData: Pointer;
  iLen: LongWord;
  s: String;
  aBuff: array[0..127] of Byte;
  aBuff2: array [0..64] of Char;
  iScale: Smallint;
  i: Integer;
begin
  Result := '';
  if (SQLDataType = SQL_VARYING) or (SQLDataType = SQL_TEXT) then begin
    if not GetData(ARowIndex, pData, iLen, True) then
      Result := 'NULL'
    else if Lib.IsUTF8(sqlsubtype) then
      if iLen > 1024 then begin
        SetString(s, PWideChar(pData), 1024);
        Result := '(truncated at 1024) ''' + s + ' ...''';
      end
      else begin
        SetString(s, PWideChar(pData), iLen);
        Result := '''' + s + '''';
      end
    else
      if iLen > 1024 then begin
        s := FVars.Statement.Database.Encoder.Decode(pData, 1024, ecANSI);
        Result := '(truncated at 1024) ''' + s + ' ...''';
      end
      else begin
        s := FVars.Statement.Database.Encoder.Decode(pData, iLen, ecANSI);
        Result := '''' + s + '''';
      end;
  end
  else if SQLDataType = SQL_NULL then
    Result := 'NULL'
  else begin
    pData := @aBuff[0];
    if not GetData(ARowIndex, pData, iLen, False) then
      Result := 'NULL'
    else begin
      if FVars.V2 then
        iScale := DataXSQLVarV2[ARowIndex]^.sqlscale
      else
        iScale := DataXSQLVarV1[ARowIndex]^.sqlscale;
      case SQLDataType of
      SQL_SHORT:
        if iScale < -4 then begin
          FDBCD2Str(aBuff2, i, PBcd(pData)^, FormatSettings.DecimalSeparator);
          SetString(Result, ABuff2, i);
        end
        else if iScale < 0 then
          Result := FDCurr2Str(PCurrency(pData)^, FormatSettings.DecimalSeparator)
        else
          Result := IntToStr(PSmallInt(pData)^);
      SQL_LONG:
        if iScale < -4 then begin
          FDBCD2Str(aBuff2, i, PBcd(pData)^, FormatSettings.DecimalSeparator);
          SetString(Result, ABuff2, i);
        end
        else if iScale < 0 then
          Result := FDCurr2Str(PCurrency(pData)^, FormatSettings.DecimalSeparator)
        else
          Result := IntToStr(PInteger(pData)^);
      SQL_QUAD,
      SQL_INT64:
        if iScale <> 0 then begin
          FDBCD2Str(aBuff2, i, PBcd(pData)^, FormatSettings.DecimalSeparator);
          SetString(Result, ABuff2, i);
        end
        else
          Result := IntToStr(PInt64(pData)^);
      SQL_FLOAT:
        Result := FDFloat2Str(PSingle(pData)^, FormatSettings.DecimalSeparator);
      SQL_D_FLOAT,
      SQL_DOUBLE:
        Result := FDFloat2Str(PDouble(pData)^, FormatSettings.DecimalSeparator);
      SQL_BOOLEAN_IB,
      SQL_BOOLEAN_FB:
        Result := S_FD_Bools[PWordBool(pData)^];
      SQL_TIMESTAMP:
        Result := DateTimetoStr(SQLTimeStampToDateTime(PSQLTimeStamp(pData)^));
      SQL_TYPE_TIME:
        Result := TimeToStr(FDTime2DateTime(PInteger(pData)^));
      SQL_TYPE_DATE:
        Result := DateToStr(FDDate2DateTime(PInteger(pData)^));
      SQL_BLOB:
        Result := Format('<BLOB> (%d,%d)', [PISC_QUAD(pData)^.gds_quad_high,
                                            PISC_QUAD(pData)^.gds_quad_low]);
      SQL_ARRAY:
        Result := Format('<ARRAY> (%d,%d)', [PISC_QUAD(pData)^.gds_quad_high,
                                             PISC_QUAD(pData)^.gds_quad_low]);
      end;
    end;
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TIBBlob                                                                       }
{-------------------------------------------------------------------------------}
const
  BPBInfos : array[1..isc_bpb_Max_Value] of TIBPBInfo =
   ((Name: 'source_type';      ParamType: prCard; Code: isc_bpb_source_type),
    (Name: 'target_type';      ParamType: prCard; Code: isc_bpb_target_type),
    (Name: 'type';             ParamType: prCard; Code: isc_bpb_type),
    (Name: 'source_interp';    ParamType: prCard; Code: isc_bpb_source_interp),
    (Name: 'target_interp';    ParamType: prCard; Code: isc_bpb_target_interp),
    (Name: 'filter_parameter'; ParamType: prIgno; Code: isc_bpb_filter_parameter) // not implemented (FB 2.0)
   );

{-------------------------------------------------------------------------------}
constructor TIBBlob.Create(ADatabase: TIBDatabase; ATransaction: TIBTransaction;
  AOwningObj: TObject);
begin
  inherited Create(ADatabase.Env, AOwningObj);
  FDatabase := ADatabase;
  FTransaction := ATransaction;
  Fsqlsubtype := isc_blob_untyped;
end;

{-------------------------------------------------------------------------------}
destructor TIBBlob.Destroy;
begin
  if IsOpen then
    Close;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TIBBlob.GetNational: Boolean;
begin
  Result := (sqlsubtype = isc_blob_text) and
    ((Database.Encoder.Encoding = ecUTF8) or Lib.IsUTF8(sqlsubtype));
end;

{-------------------------------------------------------------------------------}
function TIBBlob.GetIsOpen: Boolean;
begin
  Result := FBLHandle <> nil;
end;

{-------------------------------------------------------------------------------}
procedure TIBBlob.GetInfo;
{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_blob_info, ['blob_handle', FBLHandle,
      'items', 'num_segments;max_segment;total_length;type']);
  end;
{$ENDIF}

const
  aInfos: array[0..3] of Byte = (
    isc_info_blob_num_segments,
    isc_info_blob_max_segment,
    isc_info_blob_total_length,
    isc_info_blob_type
  );
var
  buff: array [0..63] of Byte;
  pBuff: PISC_UCHAR;
  iLen: Integer;
  cType: Byte;
  iVal: Integer;
begin
  FillChar(buff[0], SizeOf(buff), 0);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Check(Lib.Fisc_blob_info(@Error.FStatusVector, @FBLHandle, Smallint(SizeOf(aInfos)),
    @aInfos[0], Smallint(SizeOf(buff)), @buff));
  ASSERT(buff[SizeOf(buff) - 1] <> isc_info_truncated);
  pBuff := @buff;
  while pBuff^ <> isc_info_end do begin
    cType := pBuff^;
    Inc(pBuff);
    iLen := Integer(Env.Lib.Fisc_portable_integer(pBuff, 2));
    Inc(pBuff, 2);
    iVal := Integer(Env.Lib.Fisc_portable_integer(pBuff, Smallint(iLen)));
    Inc(pBuff, iLen);
    case cType of
      isc_info_blob_num_segments: Fnum_segments := iVal;
      isc_info_blob_max_segment:  Fmax_segment := iVal;
      isc_info_blob_total_length: Ftotal_length := iVal;
      isc_info_blob_type:         F_type := iVal;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBBlob.Open;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_open_blob2, ['db_handle', FDatabase.FDBHandle,
      'tra_handle', FTransaction.FTRHandle, 'blob_id.high', FBlobID.gds_quad_high,
      'blob_id.low', FBlobID.gds_quad_low]);
  end;
{$ENDIF}

begin
  ASSERT(not IsOpen);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Check(Lib.Fisc_open_blob2(@Error.FStatusVector, @FDatabase.FDBHandle,
    @FTransaction.FTRHandle, @FBLHandle, @FBlobID, 0, nil));
  GetInfo;
end;

{-------------------------------------------------------------------------------}
procedure TIBBlob.Add;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_create_blob2, ['db_handle', FDatabase.FDBHandle, 'tra_handle',
      FTransaction.FTRHandle]);
  end;
{$ENDIF}

begin
  ASSERT(not IsOpen);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Check(Lib.Fisc_create_blob2(@Error.FStatusVector, @FDatabase.FDBHandle,
    @FTransaction.FTRHandle, @FBLHandle, @FBlobID, 0, nil));
  GetInfo;
end;

{-------------------------------------------------------------------------------}
procedure TIBBlob.Close;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_close_blob, ['blob_handle', FBLHandle]);
  end;
{$ENDIF}

begin
  ASSERT(IsOpen);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Check(Lib.Fisc_close_blob(@Error.FStatusVector, @FBLHandle));
  FBLHandle := nil;
end;

{-------------------------------------------------------------------------------}
function TIBBlob.Read(ABuff: PByte; ABuffLen: LongWord): LongWord;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_get_segment, ['blob_handle', FBLHandle]);
  end;
{$ENDIF}

var
  iStatus: ISC_STATUS;
  iSeg, iRead: Word;
  pOrigBuff: Pointer;
begin
  ASSERT(IsOpen);
  Result := 0;
  pOrigBuff := ABuff;

  if National and (ABuffLen > 0) then begin
    ABuffLen := ABuffLen * SizeOf(WideChar);
    ABuff := FDatabase.Buffer.Check(ABuffLen);
  end;

  while ABuffLen > 0 do begin
    if ABuffLen > High(Word) then
      iSeg := High(Word)
    else
      iSeg := Word(ABuffLen);
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    iStatus := Lib.Fisc_get_segment(@Error.FStatusVector, @FBLHandle, iRead,
      iSeg, PISC_SCHAR(ABuff));
    if (iStatus <> 0) and (Error.FStatusVector[1] <> isc_segment) and
       (Error.FStatusVector[1] <> isc_segstr_eof) then
      Check(iStatus);
    ABuffLen := ABuffLen - iRead;
    ABuff := PByte(PByte(ABuff) + iRead);
    Result := Result + iRead;
    if Error.FStatusVector[1] = isc_segstr_eof then
      Break;
  end;

  if National and (Result > 0) then
    Result := FDatabase.Encoder.Decode(FDatabase.Buffer.Ptr, Result,
      pOrigBuff, ecUTF16);
end;

{-------------------------------------------------------------------------------}
procedure TIBBlob.Write(ABuff: PByte; ABuffLen: LongWord);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_put_segment, ['blob_handle', FBLHandle]);
  end;
{$ENDIF}

var
  pUTF8: Pointer;
  iSeg: Word;
begin
  ASSERT(IsOpen);

  if National and (ABuffLen > 0) then begin
    pUTF8 := nil;
    ABuffLen := FDatabase.Encoder.Encode(ABuff, ABuffLen, pUTF8, ecUTF16);
    ABuff := pUTF8;
  end;

  while ABuffLen > 0 do begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    if ABuffLen > High(Word) then
      iSeg := High(Word)
    else
      iSeg := Word(ABuffLen);
    Check(Lib.Fisc_put_segment(@Error.FStatusVector, @FBLHandle, iSeg, PISC_SCHAR(ABuff)));
    ABuffLen := ABuffLen - iSeg;
    ABuff := PByte(PByte(ABuff) + iSeg);
  end;
end;

{-------------------------------------------------------------------------------}
{ TIBBlobStream                                                                 }
{-------------------------------------------------------------------------------}
constructor TIBBlobStream.Create(ABlob: TIBBlob);
begin
  inherited Create;
  FBlob := ABlob;
end;

{-------------------------------------------------------------------------------}
destructor TIBBlobStream.Destroy;
begin
  FDFreeAndNil(FBlob);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TIBBlobStream.Bytes2Chars(ABytes: LongWord): LongWord;
begin
  if FBlob.National then
    Result := ABytes div SizeOf(WideChar)
  else
    Result := ABytes div SizeOf(TFDAnsiChar);
end;

{-------------------------------------------------------------------------------}
function TIBBlobStream.Chars2Bytes(AChars: LongWord): LongWord;
begin
  if FBlob.National then
    Result := AChars * SizeOf(WideChar)
  else
    Result := AChars * SizeOf(TFDAnsiChar);
end;

{-------------------------------------------------------------------------------}
procedure TIBBlobStream.CheckOpen;
begin
  if not FBlob.IsOpen then begin
    FBlob.Open;
    FPosition := 0;
  end;
end;

{-------------------------------------------------------------------------------}
function TIBBlobStream.Read(var Buffer; Count: Longint): Longint;
begin
  CheckOpen;
  Result := Chars2Bytes(FBlob.Read(PByte(@Buffer), Bytes2Chars(Count)));
  Inc(FPosition, Result);
end;

{-------------------------------------------------------------------------------}
function TIBBlobStream.Write(const Buffer; Count: Longint): Longint;
begin
  CheckOpen;
  FBlob.Write(PByte(@Buffer), Bytes2Chars(Count));
  Result := Count;
  Inc(FPosition, Result);
end;

{-------------------------------------------------------------------------------}
function TIBBlobStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
const
  C_Len = $FFFF;
var
  aBuff: array [0 .. C_Len] of Byte;
  iChunks: LongWord;
begin
  CheckOpen;
  case Origin of
  soBeginning:
    begin
      if FPosition <> Offset then begin
        if Offset < FPosition then begin
          FBlob.Close;
          FBlob.Open;
          FPosition := 0;
        end;
        iChunks := ((Offset + C_Len - 1) div C_Len) * C_Len;
        while (FPosition <= iChunks) and (Read(aBuff[0], C_Len) > 0) do
          ;
        if (Offset - FPosition > 0) and (Offset - FPosition < C_Len) then
          Read(aBuff[0], Offset - FPosition);
      end;
      Result := FPosition;
    end;
  soCurrent: Result := Seek(FPosition + Offset, soBeginning);
  soEnd:     Result := Seek(FBlob.total_length - Offset - 1, soBeginning);
  else       Result := 0;
  end;
end;

{-------------------------------------------------------------------------------}
function TIBBlobStream.GetSize: Int64;
begin
  CheckOpen;
  Result := FBlob.total_length;
end;

{-------------------------------------------------------------------------------}
{ TIBArray                                                                      }
{-------------------------------------------------------------------------------}
constructor TIBArray.Create(ADatabase: TIBDatabase; ATransaction: TIBTransaction;
  AOwningObj: TObject);
begin
  inherited Create(ADatabase.Env, AOwningObj);
  FDatabase := ADatabase;
  FTransaction := ATransaction;
  if Database.Env.Lib.Brand = ibInterbase then begin
    FVer := ARR_DESC_VERSION2;
    GetMem(FpDesc, SizeOf(ISC_ARRAY_DESC_V2));
    FillChar(FpDesc^, SizeOf(ISC_ARRAY_DESC_V2), 0);
    PISC_ARRAY_DESC_V2(FpDesc)^.array_desc_version := ARR_DESC_VERSION2;
  end
  else begin
    FVer := ARR_DESC_VERSION1;
    GetMem(FpDesc, SizeOf(ISC_ARRAY_DESC_V1));
    FillChar(FpDesc^, SizeOf(ISC_ARRAY_DESC_V1), 0);
  end;
end;

{-------------------------------------------------------------------------------}
destructor TIBArray.Destroy;
begin
  Release;
  FreeMem(FpDesc);
  FpDesc := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TIBArray.Getsqldtype: ISC_UCHAR;
begin
  if FVer = ARR_DESC_VERSION1 then
    Result := PISC_ARRAY_DESC_V1(FpDesc)^.array_desc_dtype
  else
    Result := PISC_ARRAY_DESC_V2(FpDesc)^.array_desc_dtype;
end;

{-------------------------------------------------------------------------------}
function TIBArray.Getsqltype: Smallint;
begin
  case sqldtype of
  blr_text,
  blr_text2:     Result := SQL_TEXT;
  blr_short:     Result := SQL_SHORT;
  blr_long:      Result := SQL_LONG;
  blr_quad:      Result := SQL_QUAD;
  blr_int64:     Result := SQL_INT64;
  blr_float:     Result := SQL_FLOAT;
  blr_double:    Result := SQL_D_FLOAT;
  blr_d_float:   Result := SQL_DOUBLE;
  blr_timestamp: Result := SQL_TIMESTAMP;
  blr_varying,
  blr_varying2,
  blr_cstring,
  blr_cstring2:  Result := SQL_VARYING;
  blr_blob_id:   Result := SQL_BLOB;
  blr_sql_date:  Result := SQL_TYPE_DATE;
  blr_sql_time:  Result := SQL_TYPE_TIME;
  blr_boolean_dtype_ib:
                 Result := SQL_BOOLEAN_IB;
  blr_bool_fb:   Result := SQL_BOOLEAN_FB;
  else           Result := 0; ASSERT(False);
  end;
end;

{-------------------------------------------------------------------------------}
function TIBArray.Getsqlsubtype: ISC_UCHAR;
begin
  if FVer = ARR_DESC_VERSION1 then
    Result := FV1_sqlsubtype
  else
    Result := PISC_ARRAY_DESC_V2(FpDesc)^.array_desc_subtype;
end;

{-------------------------------------------------------------------------------}
function TIBArray.Getsqlscale: ISC_SCHAR;
begin
  if FVer = ARR_DESC_VERSION1 then
    Result := PISC_ARRAY_DESC_V1(FpDesc)^.array_desc_scale
  else
    Result := PISC_ARRAY_DESC_V2(FpDesc)^.array_desc_scale;
end;

{-------------------------------------------------------------------------------}
function TIBArray.Getsqllen: ISC_USHORT;
begin
  if FVer = ARR_DESC_VERSION1 then
    Result := PISC_ARRAY_DESC_V1(FpDesc)^.array_desc_length
  else
    Result := PISC_ARRAY_DESC_V2(FpDesc)^.array_desc_length;
end;

{-------------------------------------------------------------------------------}
function TIBArray.Getsqldimensions: ISC_SHORT;
begin
  if FVer = ARR_DESC_VERSION1 then
    Result := PISC_ARRAY_DESC_V1(FpDesc)^.array_desc_dimensions
  else
    Result := PISC_ARRAY_DESC_V2(FpDesc)^.array_desc_dimensions;
end;

{-------------------------------------------------------------------------------}
function TIBArray.Getsqlbounds: PISC_ARRAY_BOUNDs;
begin
  if FVer = ARR_DESC_VERSION1 then
    Result := @PISC_ARRAY_DESC_V1(FpDesc)^.array_desc_bounds
  else
    Result := @PISC_ARRAY_DESC_V2(FpDesc)^.array_desc_bounds
end;

{-------------------------------------------------------------------------------}
procedure TIBArray.Setsqldtype(const AValue: ISC_UCHAR);
begin
  if FVer = ARR_DESC_VERSION1 then
    PISC_ARRAY_DESC_V1(FpDesc)^.array_desc_dtype := AValue
  else
    PISC_ARRAY_DESC_V2(FpDesc)^.array_desc_dtype := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TIBArray.Setsqltype(const AValue: Smallint);
var
  iDType: ISC_UCHAR;
begin
  case AValue and not 1 of
  SQL_TEXT:       iDType := blr_text2;
  SQL_SHORT:      iDType := blr_short;
  SQL_LONG:       iDType := blr_long;
  SQL_QUAD:       iDType := blr_quad;
  SQL_INT64:      iDType := blr_int64;
  SQL_FLOAT:      iDType := blr_float;
  SQL_DOUBLE:     iDType := blr_double;
  SQL_TIMESTAMP:  iDType := blr_timestamp;
  SQL_VARYING:    iDType := blr_varying2;
  SQL_BLOB:       iDType := blr_blob_id;
  SQL_TYPE_DATE:  iDType := blr_sql_date;
  SQL_TYPE_TIME:  iDType := blr_sql_time;
  SQL_BOOLEAN_IB: iDType := blr_boolean_dtype_ib;
  SQL_BOOLEAN_FB: iDType := blr_bool_fb;
  else            begin iDType := 0; ASSERT(False); end;
  end;
  sqldtype := iDType;
end;

{-------------------------------------------------------------------------------}
procedure TIBArray.Setsqlsubtype(const AValue: ISC_UCHAR);
begin
  if FVer = ARR_DESC_VERSION1 then
    FV1_sqlsubtype := AValue
  else
    PISC_ARRAY_DESC_V2(FpDesc)^.array_desc_subtype := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TIBArray.Setsqlscale(const AValue: ISC_SCHAR);
begin
  if FVer = ARR_DESC_VERSION1 then
    PISC_ARRAY_DESC_V1(FpDesc)^.array_desc_scale := AValue
  else
    PISC_ARRAY_DESC_V2(FpDesc)^.array_desc_scale := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TIBArray.Setsqllen(const AValue: ISC_USHORT);
begin
  if FVer = ARR_DESC_VERSION1 then
    PISC_ARRAY_DESC_V1(FpDesc)^.array_desc_length := AValue
  else
    PISC_ARRAY_DESC_V2(FpDesc)^.array_desc_length := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TIBArray.Lookup;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_array_lookup_bounds, ['db_handle', FDatabase.FDBHandle,
      'trans_handle', FTransaction.FTRHandle, 'relation_name', RelationName,
      'field_name', FieldName]);
  end;
{$ENDIF}

var
  sbRelName, sbFldName: TFDByteString;
begin
  Release;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  // IB ARRAY supports only names in upper case
  sbRelName := Database.Encoder.Encode(RelationName);
  sbFldName := Database.Encoder.Encode(FieldName);
  if FVer = ARR_DESC_VERSION1 then
    Check(Lib.Fisc_array_lookup_bounds(@Error.FStatusVector, @FDatabase.FDBHandle,
      @FTransaction.FTRHandle, PISC_SCHAR(PByte(sbRelName)), PISC_SCHAR(PByte(sbFldName)),
      PISC_ARRAY_DESC_V1(FpDesc)))
  else
    Check(Lib.Fisc_array_lookup_bounds2(@Error.FStatusVector, @FDatabase.FDBHandle,
      @FTransaction.FTRHandle, PISC_SCHAR(PByte(sbRelName)), PISC_SCHAR(PByte(sbFldName)),
      PISC_ARRAY_DESC_V2(FpDesc)));
  Alloc;
end;

{-------------------------------------------------------------------------------}
procedure TIBArray.Init(AType, ALen, ADims: Smallint; ABounds: array of ISC_SHORT);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_array_set_desc, ['relation_name', RelationName,
      'field_name', FieldName, 'sql_dtype', AType, 'sql_length', ALen,
      'dimensions', ADims]);
  end;
{$ENDIF}

var
  sbRelName, sbFldName: TFDByteString;
  i: Integer;
begin
  Release;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  // IB ARRAY supports only names in upper case
  sbRelName := Database.Encoder.Encode(RelationName);
  sbFldName := Database.Encoder.Encode(FieldName);
  if FVer = ARR_DESC_VERSION1 then
    Check(Lib.Fisc_array_set_desc(@Error.FStatusVector,
      PISC_SCHAR(PByte(sbRelName)), PISC_SCHAR(PByte(sbFldName)),
      @AType, @ALen, @ADims, PISC_ARRAY_DESC_V1(FpDesc)))
  else
    Check(Lib.Fisc_array_set_desc2(@Error.FStatusVector,
      PISC_SCHAR(PByte(sbRelName)), PISC_SCHAR(PByte(sbFldName)),
      @AType, @ALen, @ADims, PISC_ARRAY_DESC_V2(FpDesc)));
  for i := 0 to sqldimensions - 1 do begin
    sqlbounds^[i].array_bound_lower := ABounds[2 * i];
    sqlbounds^[i].array_bound_upper := ABounds[2 * i + 1];
  end;
  FArrayID.gds_quad_high := 0;
  FArrayID.gds_quad_low := 0;
  Alloc;
end;

{-------------------------------------------------------------------------------}
procedure TIBArray.Alloc;
begin
  FDataLen := Integer(TIBVariable.GetDataTypeSize(sqltype, sqllen)) * TotalCount;
  GetMem(FData, FDataLen);
end;

{-------------------------------------------------------------------------------}
procedure TIBArray.Release;
begin
  if FData <> nil then begin
    FDataLen := 0;
    FreeMem(FData);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBArray.Read;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_array_get_slice, ['db_handle', FDatabase.FDBHandle,
      'trans_handle', FTransaction.FTRHandle, 'array_id.high', FArrayID.gds_quad_high,
      'array_id.low', FArrayID.gds_quad_low]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if FVer = ARR_DESC_VERSION1 then
    Check(Lib.Fisc_array_get_slice(@Error.FStatusVector, @FDatabase.FDBHandle,
      @FTransaction.FTRHandle, @FArrayID, PISC_ARRAY_DESC_V1(FpDesc), FData, @FDataLen))
  else
    Check(Lib.Fisc_array_get_slice2(@Error.FStatusVector, @FDatabase.FDBHandle,
      @FTransaction.FTRHandle, @FArrayID, PISC_ARRAY_DESC_V2(FpDesc), FData, @FDataLen));
end;

{-------------------------------------------------------------------------------}
procedure TIBArray.Write;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_array_put_slice, ['db_handle', FDatabase.FDBHandle,
      'trans_handle', FTransaction.FTRHandle, 'array_id.high', FArrayID.gds_quad_high,
      'array_id.low', FArrayID.gds_quad_low]);
  end;
{$ENDIF}

begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  if FVer = ARR_DESC_VERSION1 then
    Check(Lib.Fisc_array_put_slice(@Error.FStatusVector, @FDatabase.FDBHandle,
      @FTransaction.FTRHandle, @FArrayID, PISC_ARRAY_DESC_V1(FpDesc), FData, @FDataLen))
  else
    Check(Lib.Fisc_array_put_slice2(@Error.FStatusVector, @FDatabase.FDBHandle,
      @FTransaction.FTRHandle, @FArrayID, PISC_ARRAY_DESC_V2(FpDesc), FData, @FDataLen));
end;

{-------------------------------------------------------------------------------}
function TIBArray.GetTotalCount: Integer;
var
  i: Integer;
begin
  Result := 1;
  for i := 0 to sqldimensions - 1 do
    Result := Result * (sqlbounds^[i].array_bound_upper - sqlbounds^[i].array_bound_lower + 1);
end;

{-------------------------------------------------------------------------------}
function TIBArray.GetDataPtr(AIndexes: array of ISC_SHORT; AFlat: Boolean): Pointer;
var
  iSize: Integer;
  iPower: Integer;
  iElement: Integer;
  i: Integer;
begin
  iSize := Integer(TIBVariable.GetDataTypeSize(sqltype, sqllen));
  if AFlat then begin
    ASSERT((AIndexes[0] >= 0) and (AIndexes[0] < TotalCount));
    Result := PByte(FData) + iSize * AIndexes[0];
  end
  else begin
    iPower := 1;
    iElement := 0;
    ASSERT(High(AIndexes) - Low(AIndexes) + 1 = sqldimensions);
    for i := High(AIndexes) downto Low(AIndexes) do begin
      ASSERT((AIndexes[i] >= sqlbounds^[i].array_bound_lower) and
             (AIndexes[i] <= sqlbounds^[i].array_bound_upper));
      if i < High(AIndexes) then
        iPower := iPower * (
          sqlbounds^[i + 1].array_bound_upper -
          sqlbounds^[i + 1].array_bound_lower + 1);
      iElement := iElement + iPower * (
        AIndexes[i] -
        sqlbounds^[i].array_bound_lower);
    end;
    Result := PByte(FData) + iSize * iElement;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBArray.GetData(ASrc: Pointer; var ApData: Pointer; out ALen: LongWord);
begin
  case sqldtype of
  blr_text,
  blr_text2:
    begin
      // IB ARRAY supports only ANSI encoding. Here always sqlsubtype = 0.
      ApData := ASrc;
      ALen := sqllen;
    end;
  blr_cstring,
  blr_cstring2,
  blr_varying,
  blr_varying2:
    begin
      // IB ARRAY supports only ANSI encoding. Here always sqlsubtype = 0.
      ApData := ASrc;
      ALen := FDAnsiStrLen(ASrc);
    end;
  blr_short:
    begin
      PSmallint(ApData)^ := PSmallint(ASrc)^;
      ALen := SizeOf(Smallint);
    end;
  blr_long:
    begin
      PInteger(ApData)^ := PInteger(ASrc)^;
      ALen := SizeOf(Integer);
    end;
  blr_quad,
  blr_int64:
    begin
      PInt64(ApData)^ := PInt64(ASrc)^;
      ALen := SizeOf(Int64);
    end;
  blr_float:
    begin
      PSingle(ApData)^ := PSingle(ASrc)^;
      ALen := SizeOf(Single);
    end;
  blr_double,
  blr_d_float:
    begin
      PDouble(ApData)^ := PDouble(ASrc)^;
      ALen := SizeOf(Double);
    end;
  blr_timestamp:
    begin
      Env.Lib.ISCTmSt2DlpTmSt(PISC_TIMESTAMP(ASrc)^, PSQLTimeStamp(ApData)^);
      ALen := SizeOf(TSQLTimeStamp);
    end;
  blr_blob_id:
    begin
      PISC_QUAD(ApData)^ := PISC_QUAD(ASrc)^;
      ALen := SizeOf(ISC_QUAD);
    end;
  blr_sql_date:
    begin
      Env.Lib.ISCDt2DlpDt(PISC_DATE(ASrc)^, PInteger(ApData)^);
      ALen := SizeOf(Integer);
    end;
  blr_sql_time:
    begin
      Env.Lib.ISCTm2DlpTm(PISC_TIME(ASrc)^, PInteger(ApData)^);
      ALen := SizeOf(Integer);
    end;
  blr_boolean_dtype_ib:
    begin
      PWordBool(ApData)^ := PWordBool(ASrc)^;
      ALen := SizeOf(WordBool);
    end;
  blr_bool_fb:
    begin
      PWordBool(ApData)^ := PBoolean(ASrc)^;
      ALen := SizeOf(WordBool);
    end;
  else
    ASSERT(False);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBArray.SetData(ADest, ApData: Pointer; ALen: LongWord);
var
  iLen: Integer;
  pAnsi: Pointer;
begin
  case sqldtype of
  blr_text,
  blr_text2:
    begin
      // IB ARRAY supports only ANSI encoding
      if sqlsubtype = csIDUnicodeFSS then begin
        pAnsi := nil;
        ALen := Database.Encoder.Encode(ApData, ALen, pAnsi, ecUTF16, ecANSI);
        ApData := pAnsi;
      end;
      iLen := Min(ALen, sqllen);
      if iLen < sqllen then
        FillChar((PByte(ADest) + iLen)^, sqllen - iLen, Ord(' '));
      if iLen > 0 then
        Move(ApData^, ADest^, iLen);
    end;
  blr_cstring,
  blr_cstring2,
  blr_varying,
  blr_varying2:
    begin
      // IB ARRAY supports only ANSI encoding
      if sqlsubtype = csIDUnicodeFSS then begin
        pAnsi := nil;
        ALen := Database.Encoder.Encode(ApData, ALen, pAnsi, ecUTF16, ecANSI);
        ApData := pAnsi;
      end;
      iLen := Min(ALen, sqllen - 1);
      if iLen > 0 then
        Move(ApData^, ADest^, iLen);
      (PByte(ADest) + iLen)^ := 0;
    end;
  blr_short:
    PSmallint(ADest)^ := PSmallint(ApData)^;
  blr_long:
    PInteger(ADest)^ := PInteger(ApData)^;
  blr_quad,
  blr_int64:
    PInt64(ADest)^ := PInt64(ApData)^;
  blr_float:
    PSingle(ADest)^ := PSingle(ApData)^;
  blr_double,
  blr_d_float:
    PDouble(ADest)^ := PDouble(ApData)^;
  blr_timestamp:
    Env.Lib.DlpTmSt2ISCTmSt(PSQLTimeStamp(ApData)^, PISC_TIMESTAMP(ADest)^);
  blr_blob_id:
    PISC_QUAD(ADest)^ := PISC_QUAD(ApData)^;
  blr_sql_date:
    Env.Lib.DlpDt2ISCDt(PInteger(ApData)^, PISC_DATE(ADest)^);
  blr_sql_time:
    Env.Lib.DlpTm2ISCTm(PInteger(ApData)^, PISC_TIME(ADest)^);
  blr_boolean_dtype_ib:
    PWordBool(ADest)^ := PWordBool(ApData)^;
  blr_bool_fb:
    PBoolean(ADest)^ := PWordBool(ApData)^;
  else
    ASSERT(False);
  end;
end;

{-------------------------------------------------------------------------------}
{ TIBStatement                                                                  }
{-------------------------------------------------------------------------------}
constructor TIBStatement.Create(ADatabase: TIBDatabase;
  ATransaction: TIBTransaction; AOwningObj: TObject);
begin
  inherited Create(ADatabase.Env, AOwningObj);
  FDatabase := ADatabase;
  FTransaction := ATransaction;
  FOutVars := TIBVariables.Create(Self);
  FInVars := TIBVariables.Create(Self);
  FDialect := 3;
end;

{-------------------------------------------------------------------------------}
destructor TIBStatement.Destroy;
begin
  if FSTHandle <> nil then begin
    Close;
    Unprepare;
  end;
  FDFreeAndNil(FOutVars);
  FDFreeAndNil(FInVars);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TIBStatement.GetSQLInfo(AInfo: Integer; ABuff: PByte; ASize: Integer);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_dsql_sql_info, ['stmt_handle', FSTHandle, 'info', AInfo]);
  end;
{$ENDIF}

var
  cInfo: Byte;
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  cInfo := AInfo;
  Check(Lib.Fisc_dsql_sql_info(@Error.FStatusVector, @FSTHandle, 1, @cInfo,
    SmallInt(ASize), PISC_SCHAR(ABuff)));
end;

{-------------------------------------------------------------------------------}
function TIBStatement.GetSQLInfoInt(AInfo: Integer): Integer;
var
  buff: array [0..63] of Byte;
  iLen: Integer;
begin
  GetSQLInfo(AInfo, @buff, SizeOf(buff));
  iLen := Integer(Env.Lib.Fisc_portable_integer(@buff[1], 2));
  Result := Integer(Env.Lib.Fisc_portable_integer(@buff[3], SmallInt(iLen)));
end;

{-------------------------------------------------------------------------------}
function TIBStatement.GetSQLInfoStr(AInfo: Integer): String;
var
  buff: array [0..16384] of Byte;
  iLen1: Integer;
begin
  GetSQLInfo(AInfo, @buff, SizeOf(buff));
  if (buff[0] <> AInfo) or (buff[SizeOf(buff) - 1] = isc_info_truncated) then
    Result := ''
  else begin
    iLen1 := Integer(Env.Lib.Fisc_portable_integer(@buff[1], 2));
    Result := Database.Encoder.Decode(@buff[3], iLen1);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBStatement.GetRowCounts(AForceGetCounts: Boolean);
var
  buff: array [0..1024] of Byte;
  pBuff: PISC_UCHAR;
  iLen: Integer;
  cType: Byte;
  iCount: Int64;
begin
  case sql_stmt_type of
  0,
  isc_info_sql_stmt_ddl,
  isc_info_sql_stmt_get_segment,
  isc_info_sql_stmt_put_segment,
  isc_info_sql_stmt_start_trans,
  isc_info_sql_stmt_commit,
  isc_info_sql_stmt_rollback,
  isc_info_sql_stmt_set_generator,
  isc_info_sql_stmt_savepoint,
  isc_info_sql_stmt_select,
  isc_info_sql_stmt_select_for_upd:
    Exit;
  isc_info_sql_stmt_exec_procedure:
    if not AForceGetCounts then
      Exit;
  isc_info_sql_stmt_insert:
    begin
      // That is optimization. Because INSERT does not have WHERE
      // and operation is finished successfully, then one record is
      // inserted.
      FRowsInserted := 1;
      FRowsDeleted := 0;
      FRowsUpdated := 0;
      FRowsSelected := 0;
      Exit;
    end;
  end;

  FillChar(buff[0], SizeOf(buff), 0);
  GetSQLInfo(isc_info_sql_records, @buff, SizeOf(buff));
  pBuff := @buff;
  if pBuff^ = isc_info_sql_records then begin
    Inc(pBuff);
    if Env.Lib.Fisc_portable_integer(pBuff, 2) > 255 then
      Exit;
    Inc(pBuff, 2);
    FRowsInserted := 0;
    FRowsDeleted := 0;
    FRowsUpdated := 0;
    FRowsSelected := 0;
    while pBuff^ <> isc_info_end do begin
      cType := pBuff^;
      Inc(pBuff);
      iLen := Integer(Env.Lib.Fisc_portable_integer(pBuff, 2));
      Inc(pBuff, 2);
      iCount := Env.Lib.Fisc_portable_integer(pBuff, Smallint(iLen));
      Inc(pBuff, iLen);
      case cType of
        isc_info_req_update_count: FRowsUpdated := iCount;
        isc_info_req_delete_count: FRowsDeleted := iCount;
        isc_info_req_select_count: FRowsSelected := iCount;
        isc_info_req_insert_count: FRowsInserted := iCount;
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TIBStatement.GetRowsAffected: Int64;
begin
  Result := 0;
  if RowsInserted > 0 then
    Inc(Result, RowsInserted);
  if RowsUpdated > 0 then
    Inc(Result, RowsUpdated);
  if RowsDeleted > 0 then
    Inc(Result, RowsDeleted);
end;

{-------------------------------------------------------------------------------}
procedure TIBStatement.Prepare(const ASQL: String);
var
  sb: TFDByteString;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_dsql_allocate_statement, ['db_handle', FDatabase.FDBHandle]);
  end;
  procedure Trace2;
  begin
    Env.Trace(sisc_dsql_prepare, ['tra_handle', FTransaction.FTRHandle,
      'stmt_handle', FSTHandle, 'sql', ASQL, 'dialect', Dialect]);
  end;
{$ENDIF}

begin
  OutVars.RowCount := 1;
  OutVars.VarCount := 1;
  InVars.RowCount := 1;
  InVars.VarCount := 1;
  Reset(False);

{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  Check(Lib.Fisc_dsql_allocate_statement(@Error.FStatusVector, @FDatabase.FDBHandle,
    @FSTHandle));
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace2;
{$ENDIF}
  sb := Database.Encoder.Encode(ASQL);
  Check(Lib.Fisc_dsql_prepare(@Error.FStatusVector, @FTransaction.FTRHandle,
    @FSTHandle, Database.Encoder.EncodedLength(sb), PISC_SCHAR(PByte(sb)),
    Dialect, OutVars.FXSQLDA));
  Fsql_stmt_type := GetSQLInfoInt(isc_info_sql_stmt_type);
end;

{-------------------------------------------------------------------------------}
procedure TIBStatement.DescribeSelect;
{$IFDEF FireDAC_MONITOR}
  procedure Trace3;
  begin
    Env.Trace(sisc_dsql_describe, ['stmt_handle', FSTHandle, 'dialect', Dialect]);
  end;
{$ENDIF}
begin
  if OutVars.AdjustCount and (OutVars.VarCount > 0) then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace3;
{$ENDIF}
    Check(Lib.Fisc_dsql_describe(@Error.FStatusVector, @FSTHandle,
      Dialect, OutVars.FXSQLDA));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBStatement.DescribeBind;
{$IFDEF FireDAC_MONITOR}
  procedure Trace4;
  begin
    Env.Trace(sisc_dsql_describe_bind, ['stmt_handle', FSTHandle, 'dialect', Dialect]);
  end;
{$ENDIF}
begin
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace4;
{$ENDIF}
  Check(Lib.Fisc_dsql_describe_bind(@Error.FStatusVector, @FSTHandle,
    Dialect, InVars.FXSQLDA));
  if InVars.AdjustCount and (InVars.VarCount > 0) then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace4;
{$ENDIF}
    Check(Lib.Fisc_dsql_describe_bind(@Error.FStatusVector, @FSTHandle,
      Dialect, InVars.FXSQLDA));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBStatement.Reset(ACheckBuff: Boolean);
begin
  FRowsInserted := -1;
  FRowsDeleted := -1;
  FRowsUpdated := -1;
  FRowsSelected := -1;
  FEOF := True;
  FClosed := True;
  FSingleRecord := False;
  if ACheckBuff then begin
    InVars.CheckBuff;
    OutVars.CheckBuff;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBStatement.Execute(AForceGetCounts: Boolean);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_dsql_execute2, ['tra_handle', FTransaction.FTRHandle,
      'stmt_handle', FSTHandle, 'dialect', Dialect]);
  end;
{$ENDIF}

begin
  Reset(True);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then begin
    DumpInVars;
    Trace1;
  end;
{$ENDIF}
  Check(Lib.Fisc_dsql_execute2(@Error.FStatusVector, @FTransaction.FTRHandle,
    @FSTHandle, Dialect, InVars.FXSQLDA, OutVars.FXSQLDA));
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then DumpOutVars(False);
{$ENDIF}
  GetRowCounts(AForceGetCounts);
end;

{-------------------------------------------------------------------------------}
procedure TIBStatement.Open(ASingleRecord: Boolean);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_dsql_execute2, ['tra_handle', FTransaction.FTRHandle,
      'stmt_handle', FSTHandle, 'dialect', Dialect]);
  end;
{$ENDIF}

begin
  Reset(True);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then begin
    DumpInVars;
    Trace1;
  end;
{$ENDIF}
  if ASingleRecord then begin
    Check(Lib.Fisc_dsql_execute2(@Error.FStatusVector, @FTransaction.FTRHandle,
      @FSTHandle, Dialect, InVars.FXSQLDA, OutVars.FXSQLDA));
    FSingleRecord := True;
    FClosed := False;
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then DumpOutVars(False);
{$ENDIF}
  end
  else begin
    Check(Lib.Fisc_dsql_execute2(@Error.FStatusVector, @FTransaction.FTRHandle,
      @FSTHandle, Dialect, InVars.FXSQLDA, nil));
    FEOF := False;
    FClosed := False;
  end;
  GetRowCounts(False);
end;

{-------------------------------------------------------------------------------}
procedure TIBStatement.ExecuteImmediate(const ASQL: String);
var
  sb: TFDByteString;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_dsql_execute_immediate, ['db_handle', FDatabase.FDBHandle,
      'tra_handle', FTransaction.FTRHandle, 'sql', ASQL, 'dialect', Dialect]);
  end;
{$ENDIF}

begin
  Reset(True);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then begin
    DumpInVars;
    Trace1;
  end;
{$ENDIF}
  sb := Database.Encoder.Encode(ASQL);
  Check(Lib.Fisc_dsql_execute_immediate(@Error.FStatusVector,
    @FDatabase.FDBHandle, @FTransaction.FTRHandle,
    Smallint(Database.Encoder.EncodedLength(sb)),
    PISC_SCHAR(PByte(sb)), Dialect, InVars.FXSQLDA));
end;

{-------------------------------------------------------------------------------}
function TIBStatement.GetMaximumBatchSize: LongWord;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to InVars.VarCount - 1 do
    Inc(Result, 28 + InVars[i].BindSize);
  Result := 32768 div Result;
  if Result = 0 then
    Result := 1;
end;

{-------------------------------------------------------------------------------}
procedure TIBStatement.ExecuteBatch;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_dsql_batch_execute, ['tra_handle', FTransaction.FTRHandle,
      'stmt_handle', FSTHandle, 'dialect', Dialect, 'number_of_rows', InVars.RowCount]);
  end;
{$ENDIF}

begin
  Reset(True);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then begin
    DumpInVars;
    Trace1;
  end;
{$ENDIF}
  try
    Check(Lib.Fisc_dsql_batch_execute(@Error.FStatusVector, @FTransaction.FTRHandle,
      @FSTHandle, Dialect, InVars.FXSQLDA, InVars.RowCount, InVars.FXSQLVAR,
      @InVars.FRowsAffected[0]));
  finally
                                                                               
                                                                   
    InVars.FXSQLDA^.sqln := InVars.FXSQLDA^.sqld;
    DescribeBind;
  end;
end;

{-------------------------------------------------------------------------------}
function TIBStatement.Fetch: Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_dsql_fetch, ['stmt_handle', FSTHandle,
      'dialect', Dialect]);
  end;
{$ENDIF}

var
  iStatus: ISC_STATUS;
begin
  if FEOF then begin
    if FSingleRecord then begin
      Result := FSingleRecord;
      // DSQL_close on InterBase after isc_dsql_execute2 will give error
      //            on Firebird -> OK
      // Probably, we should not close statement at all in case
      // of Open(ASingleRecord => True)
      FClosed := True;
      FSingleRecord := False;
    end
    else
      Result := False;
    Exit;
  end;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  iStatus := Lib.Fisc_dsql_fetch(@Error.FStatusVector, @FSTHandle,
    Dialect, OutVars.FXSQLDA);
  FEOF := (iStatus = 100) or (iStatus = isc_stream_eof);
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then DumpOutVars(FEOF);
{$ENDIF}
  Result := not FEOF;
  if FEOF then
    Close
  else if iStatus <> 0 then
    Check(iStatus);
end;

{-------------------------------------------------------------------------------}
procedure TIBStatement.Unprepare;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_dsql_free_statement, ['stmt_handle', FSTHandle,
      'option', 'DSQL_drop']);
  end;
{$ENDIF}

begin
  Database.Buffer.Release;
  OutVars.RowCount := 0;
  OutVars.VarCount := 0;
  InVars.RowCount := 0;
  InVars.VarCount := 0;
  if FSTHandle <> nil then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    try
      Check(Lib.Fisc_dsql_free_statement(@Error.FStatusVector, @FSTHandle, DSQL_drop));
    except
      on E: EIBNativeException do
        if E.Kind = ekServerGone then
          FSTHandle := nil
        else
          raise;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBStatement.Close;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_dsql_free_statement, ['stmt_handle', FSTHandle,
      'option', 'DSQL_close']);
  end;
{$ENDIF}

begin
  if FClosed then
    Exit;
  FClosed := True;
  FEOF := True;
  FSingleRecord := False;
{$IFDEF FireDAC_MONITOR}
  if Env.Tracing then Trace1;
{$ENDIF}
  try
    Check(Lib.Fisc_dsql_free_statement(@Error.FStatusVector, @FSTHandle, DSQL_close));
  except
    on E: EIBNativeException do
      if E.Kind = ekServerGone then
        FSTHandle := nil
      else
        raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBStatement.Cancel;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_dsql_free_statement, ['stmt_handle', FSTHandle,
      'option', 'DSQL_cancel']);
  end;
{$ENDIF}

var
  aTempStatVec: TISCStatusVector;
  iTempStatus: ISC_STATUS;
begin
  if (Lib.Brand = ibInterbase) and (Lib.Version >= ivIB070000) then begin
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    iTempStatus := Lib.Fisc_dsql_free_statement(@aTempStatVec, @FSTHandle, DSQL_cancel);
    if iTempStatus <> 0 then begin
      Move(aTempStatVec[0], Error.FStatusVector[0], SizeOf(aTempStatVec));
      Check(iTempStatus);
    end;
  end
  else if (Lib.Brand = ibFirebird) and (Lib.Version >= ivFB020500) then
    Database.Cancel;
end;

{$IFDEF FireDAC_MONITOR}
{-------------------------------------------------------------------------------}
procedure TIBStatement.DumpOutVars(AEof: Boolean);
var
  i: Integer;
  oVar: TIBVariable;
begin
  if Env.Tracing and (OutVars.VarCount > 0) and not AEof then begin
    Env.Trace(ekCmdDataOut, esStart, 'Fetched', []);
    for i := 0 to OutVars.VarCount - 1 do begin
      oVar := OutVars[i];
      Env.Trace(ekCmdDataOut, esProgress, 'Var',
        [String('N'), i, '@Type', oVar.DumpSQLDataType(), 'Prec', oVar.sqlprecision,
         'Scale', oVar.sqlscale, 'Size', oVar.DataSize, '@Data', oVar.DumpValue(0)]);
    end;
    Env.Trace(ekCmdDataOut, esEnd, 'Fetched', []);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBStatement.DumpInVars;
var
  i, j: Integer;
  oVar: TIBVariable;
begin
  if Env.Tracing and (InVars.VarCount > 0) then begin
    Env.Trace(ekCmdDataIn, esStart, 'Sent', []);
    for i := 0 to InVars.VarCount - 1 do begin
      oVar := InVars[i];
      Env.Trace(ekCmdDataIn, esProgress, 'Var',
        [String('N'), i, 'Name', oVar.DumpLabel, '@Type', oVar.DumpSQLDataType(),
         'Prec', oVar.sqlprecision, 'Scale', oVar.sqlscale, 'Size', oVar.DataSize,
         '@Data(0)', oVar.DumpValue(0)]);
      for j := 1 to InVars.RowCount - 1 do
        Env.Trace(ekCmdDataIn, esProgress, '  ... Data', ['I', j,
          '@V', oVar.DumpValue(j)]);
    end;
    Env.Trace(ekCmdDataIn, esEnd, 'Sent', []);
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TIBService                                                                    }
{-------------------------------------------------------------------------------}
constructor TIBService.Create(AEnv: TIBEnv; AOwningObj: TObject);
begin
  inherited Create(AEnv, AOwningObj);
  FEncoder := TFDEncoder.Create(nil);
  FEncoder.Encoding := ecANSI;
end;

{-------------------------------------------------------------------------------}
destructor TIBService.Destroy;
begin
  FDFreeAndNil(FEncoder);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TIBService.GetAttachParams(ABld: TIBPBWriter);
begin
  ABld.AddByte(isc_spb_version);
  ABld.AddByte(isc_spb_current_version);
  if UserName <> '' then begin
    ABld.AddByte(isc_spb_user_name);
    ABld.AddShortString(UserName);
  end;
  if Password <> '' then begin
    ABld.AddByte(isc_spb_password);
    ABld.AddShortString(Password);
  end;
  if SqlRoleName <> '' then begin
    ABld.AddByte(isc_spb_sql_role_name);
    ABld.AddShortString(SqlRoleName);
  end;
  if ConnectTimeout <> 0 then begin
    ABld.AddByte(isc_spb_connect_timeout);
    ABld.AddDWord(ConnectTimeout);
  end;
  if InstanceName <> '' then begin
    ABld.AddByte(isc_spb_instance_name);
    ABld.AddShortString(InstanceName);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBService.Attach;
var
  sSvcName: TFDByteString;
  oWrt: TIBPBWriter;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_service_attach, ['service_name', sSvcName, 'user_name',
      UserName, 'password', '*****']);
  end;
{$ENDIF}

begin
  Lib.Lock;
  oWrt := TIBPBWriter.Create(Lib, FEncoder);
  try
    case FProtocol of
    ipLocal:   sSvcName := Encoder.Encode('service_mgr');
    ipTCPIP:   sSvcName := Encoder.Encode(Host + ':service_mgr');
    ipNetBEUI: sSvcName := Encoder.Encode('\\'+ Host + '\service_mgr');
    else       SetLength(sSvcName, 0);
    end;
    GetAttachParams(oWrt);

{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    Check(Lib.Fisc_service_attach(@Error.FStatusVector,
      Smallint(Encoder.EncodedLength(sSvcName)), PISC_SCHAR(PByte(sSvcName)),
      @FSvcHandle, oWrt.Len, oWrt.AsPByte));
  finally
    FDFree(oWrt);
    Lib.Unlock;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBService.Detach;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_service_detach, ['svc_handle', FSvcHandle]);
  end;
{$ENDIF}

begin
  if FSvcHandle = nil then
    Exit;
  Lib.Lock;
  try
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    Check(Lib.Fisc_service_detach(@Error.FStatusVector, @FSvcHandle));
  finally
    FSvcHandle := nil;
    Lib.Unlock;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBService.GetServiceParams(ABld: TIBPBWriter);
begin
  if SEPassword <> '' then begin
    ABld.AddByte(isc_spb_sys_encrypt_password);
    ABld.AddLongString(SEPassword);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBService.Start;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_service_start, ['svc_handle', FSvcHandle]);
  end;
{$ENDIF}

var
  oWrt: TIBPBWriter;
begin
  oWrt := TIBPBWriter.Create(Lib, FEncoder);
  try
    GetServiceParams(oWrt);
{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    Check(Lib.Fisc_service_start(@Error.FStatusVector, @FSvcHandle, nil,
      oWrt.Len, oWrt.AsPByte));
  finally
    FDFree(oWrt);
  end;
end;

{-------------------------------------------------------------------------------}
function TIBService.QueryString(out AMessage: String): Boolean;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_service_query, ['svc_handle', FSvcHandle]);
  end;
{$ENDIF}

var
  oSendWrt: TIBPBWriter;
  oReqWrt: TIBPBWriter;
  oOutRdr: TIBPBReader;
begin
  Result := True;
  AMessage := '';
  oSendWrt := TIBPBWriter.Create(Lib, FEncoder);
  oReqWrt := TIBPBWriter.Create(Lib, FEncoder);
  oOutRdr := TIBPBReader.Create(Lib, FEncoder);
  try
    if QueryTimeout > 0 then begin
      oSendWrt.AddByte(isc_info_svc_timeout);
      oSendWrt.AddDWord(QueryTimeout);
    end;

    oReqWrt.AddByte(isc_info_svc_line);

    oOutRdr.Reset(1024);

{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    Check(Lib.Fisc_service_query(@Error.FStatusVector, @FSvcHandle, nil,
      oSendWrt.Len, oSendWrt.AsPByte, oReqWrt.Len, oReqWrt.AsPByte,
      oOutRdr.Len, oOutRdr.AsPByte));

    case oOutRdr.GetByte of
    isc_info_svc_line:
      begin
        AMessage := oOutRdr.GetLongString;
        Result := Length(AMessage) = 0;
      end;
    isc_info_svc_running:
      Result := False;
    end;

  finally
    FDFree(oSendWrt);
    FDFree(oReqWrt);
    FDFree(oOutRdr);
  end;
end;

{-------------------------------------------------------------------------------}
{ TIBBackup                                                                     }
{-------------------------------------------------------------------------------}
constructor TIBBackup.Create(AEnv: TIBEnv; AOwningObj: TObject);
begin
  inherited Create(AEnv, AOwningObj);
  FBackupFiles := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TIBBackup.Destroy;
begin
  FDFreeAndNil(FBackupFiles);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TIBBackup.SetBackupFiles(const AValue: TStrings);
begin
  FBackupFiles.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TIBBackup.GetServiceParams(ABld: TIBPBWriter);
var
  i: Integer;
  s: String;
  iOpts: Cardinal;
begin
  ABld.AddByte(isc_action_svc_backup);

  ABld.AddByte(isc_spb_dbname);
  ABld.AddLongString(DatabaseName);

  if Verbose then
    ABld.AddByte(isc_spb_verbose);

  case Mode of
  bmBackup:
    begin
      for i := 0 to BackupFiles.Count - 1 do
        if Trim(BackupFiles[i]) <> '' then begin
          ABld.AddByte(isc_spb_bkp_file);
          ABld.AddLongString(BackupFiles.KeyNames[i]);

          s := BackupFiles.ValueFromIndex[i];
          if s <> '' then begin
            ABld.AddByte(isc_spb_bkp_length);
            ABld.AddDWord(StrToInt(s));
          end;
        end;

      if Options <> [] then begin
        ABld.AddByte(isc_spb_options);
        iOpts := 0;
        if boIgnoreChecksum in Options then
          iOpts := iOpts or isc_spb_bkp_ignore_checksums;
        if boIgnoreLimbo in Options then
          iOpts := iOpts or isc_spb_bkp_ignore_limbo;
        if boMetadataOnly in Options then
          iOpts := iOpts or isc_spb_bkp_metadata_only;
        if boNoGarbageCollect in Options then
          iOpts := iOpts or isc_spb_bkp_no_garbage_collect;
        if boOldDescriptions in Options then
          iOpts := iOpts or isc_spb_bkp_old_descriptions;
        if boNonTransportable in Options then
          iOpts := iOpts or isc_spb_bkp_non_transportable;
        if boConvert in Options then
          iOpts := iOpts or isc_spb_bkp_convert;
        if boExpand in Options then
          iOpts := iOpts or isc_spb_bkp_expand;
        ABld.AddDWord(iOpts);
      end;

      if EncryptKeyName <> '' then begin
        ABld.AddByte(isc_spb_bkp_encrypt_name);
        ABld.AddLongString(EncryptKeyName);
      end;
    end;

  bmArchiveDatabase:
    begin
      ABld.AddByte(isc_spb_options);
      ABld.AddDWord(isc_spb_bkp_archive_database);
    end;

  bmArchiveJournals:
    begin
      ABld.AddByte(isc_spb_options);
      ABld.AddDWord(isc_spb_bkp_archive_journals);
    end;
  end;

  inherited GetServiceParams(ABld);
end;

{-------------------------------------------------------------------------------}
{ TFBNBackup                                                                    }
{-------------------------------------------------------------------------------}
procedure TFBNBackup.GetServiceParams(ABld: TIBPBWriter);
var
  iOpts: Cardinal;
begin
  ABld.AddByte(isc_action_svc_nbak);

  ABld.AddByte(isc_spb_dbname);
  ABld.AddLongString(DatabaseName);

  ABld.AddByte(isc_spb_nbk_file);
  ABld.AddLongString(BackupFile);

  ABld.AddByte(isc_spb_nbk_level);
  ABld.AddDWord(Level);

  if Options <> [] then begin
    ABld.AddByte(isc_spb_options);
    iOpts := 0;
    if noNoTriggers in Options then
      iOpts := iOpts or isc_spb_nbk_no_triggers;
    ABld.AddDWord(iOpts);
  end;

  inherited GetServiceParams(ABld);
end;

{-------------------------------------------------------------------------------}
{ TIBSDump                                                                      }
{-------------------------------------------------------------------------------}
constructor TIBSDump.Create(AEnv: TIBEnv; AOwningObj: TObject);
begin
  inherited Create(AEnv, AOwningObj);
  FBackupFiles := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TIBSDump.Destroy;
begin
  FDFreeAndNil(FBackupFiles);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TIBSDump.SetBackupFiles(const AValue: TStrings);
begin
  FBackupFiles.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TIBSDump.GetServiceParams(ABld: TIBPBWriter);
var
  i: Integer;
  s: String;
  iOpts: Cardinal;
begin
  ABld.AddByte(isc_action_svc_dump);

  ABld.AddByte(isc_spb_dbname);
  ABld.AddLongString(DatabaseName);

  for i := 0 to BackupFiles.Count - 1 do
    if Trim(BackupFiles[i]) <> '' then begin
      ABld.AddByte(isc_spb_dmp_file);
      ABld.AddLongString(BackupFiles.KeyNames[i]);

      s := BackupFiles.ValueFromIndex[i];
      if s <> '' then begin
        ABld.AddByte(isc_spb_dmp_length);
        ABld.AddDWord(StrToInt(s));
      end;
    end;

  if Overwrite then
    ABld.AddByte(isc_spb_dmp_overwrite);

  if Options <> [] then begin
    ABld.AddByte(isc_spb_options);
    iOpts := 0;
    if doOnline in Options then
      iOpts := iOpts or isc_spb_dmp_create;
    ABld.AddDWord(iOpts);
  end;

  inherited GetServiceParams(ABld);
end;

{-------------------------------------------------------------------------------}
{ TIBRestore                                                                    }
{-------------------------------------------------------------------------------}
constructor TIBRestore.Create(AEnv: TIBEnv; AOwningObj: TObject);
begin
  inherited Create(AEnv, AOwningObj);
  FBackupFiles := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TIBRestore.Destroy;
begin
  FDFreeAndNil(FBackupFiles);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TIBRestore.SetBackupFiles(const AValue: TStrings);
begin
  FBackupFiles.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TIBRestore.GetServiceParams(ABld: TIBPBWriter);
var
  i: Integer;
  iOpts: Cardinal;
begin
  ABld.AddByte(isc_action_svc_restore);

  for i := 0 to BackupFiles.Count - 1 do
    if Trim(BackupFiles[i]) <> '' then begin
      ABld.AddByte(isc_spb_bkp_file);
      ABld.AddLongString(BackupFiles[i]);
    end;

  ABld.AddByte(isc_spb_dbname);
  ABld.AddLongString(DatabaseName);

  if Verbose then
    ABld.AddByte(isc_spb_verbose);

  case Mode of
  rmRestore:
    begin
      ABld.AddByte(isc_spb_options);
      if roReplace in Options then
        iOpts := isc_spb_res_replace
      else
        iOpts := isc_spb_res_create;
      if roDeactivateIdx in Options then
        iOpts := iOpts or isc_spb_res_deactivate_idx;
      if roNoShadow in Options then
        iOpts := iOpts or isc_spb_res_no_shadow;
      if roNoValidity in Options then
        iOpts := iOpts or isc_spb_res_no_validity;
      if roOneAtATime in Options then
        iOpts := iOpts or isc_spb_res_one_at_a_time;
      if roUseAllSpace in Options then
        iOpts := iOpts or isc_spb_res_use_all_space;
      if roValidate in Options then
        iOpts := iOpts or isc_spb_res_validate;
      if roMetaDataOnly in Options then
        iOpts := iOpts or isc_spb_res_metadata_only;
      ABld.AddDWord(iOpts);
      if roFixFSSData in Options then begin
        ABld.AddByte(isc_spb_res_fix_fss_data);
        ABld.AddLongString(FixCharSet);
      end;
      if roFixFSSMetaData in Options then begin
        ABld.AddByte(isc_spb_res_fix_fss_metadata);
        ABld.AddLongString(FixCharSet);
      end;

      if PageSize <> 0 then begin
        ABld.AddByte(isc_spb_res_page_size);
        ABld.AddDWord(PageSize);
      end;

      if PageBuffers <> 0 then begin
        ABld.AddByte(isc_spb_res_buffers);
        ABld.AddDWord(PageBuffers);
      end;

      if EUAUserName <> '' then begin
        ABld.AddByte(isc_spb_res_eua_user_name);
        ABld.AddLongString(EUAUserName);
      end;
      if EUAPassword <> '' then begin
        ABld.AddByte(isc_spb_res_eua_password);
        ABld.AddLongString(EUAPassword);
      end;

      if DecryptPassword <> '' then begin
        ABld.AddByte(isc_spb_res_decrypt_password);
        ABld.AddLongString(DecryptPassword);
      end;
    end;

  rmArchiveRecover:
    begin
      ABld.AddByte(isc_spb_options);
      ABld.AddDWord(isc_spb_res_archive_recover);

      if UntilTimestamp <> 0 then begin
        ABld.AddByte(isc_spb_res_archive_recover_until);
        ABld.AddLongString(FormatDateTime('YYYY-MM-DD HH:NN:SS', UntilTimestamp));
      end;
    end;
  end;

  inherited GetServiceParams(ABld);
end;

{-------------------------------------------------------------------------------}
{ TFBNRestore                                                                   }
{-------------------------------------------------------------------------------}
constructor TFBNRestore.Create(AEnv: TIBEnv; AOwningObj: TObject);
begin
  inherited Create(AEnv, AOwningObj);
  FBackupFiles := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFBNRestore.Destroy;
begin
  FDFreeAndNil(FBackupFiles);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFBNRestore.SetBackupFile(const AValue: TStrings);
begin
  FBackupFiles.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFBNRestore.GetServiceParams(ABld: TIBPBWriter);
var
  i: Integer;
  iOpts: Cardinal;
begin
  ABld.AddByte(isc_action_svc_nrest);

  ABld.AddByte(isc_spb_dbname);
  ABld.AddLongString(DatabaseName);

  for i := 0 to BackupFiles.Count - 1 do
    if Trim(BackupFiles[i]) <> '' then begin
      ABld.AddByte(isc_spb_nbk_file);
      ABld.AddLongString(BackupFiles[i]);
    end;

  if Options <> [] then begin
    ABld.AddByte(isc_spb_options);
    iOpts := 0;
    if noNoTriggers in Options then
      iOpts := iOpts or isc_spb_nbk_no_triggers;
    ABld.AddDWord(iOpts);
  end;

  inherited GetServiceParams(ABld);
end;

{-------------------------------------------------------------------------------}
{ TIBRepair                                                                     }
{-------------------------------------------------------------------------------}
procedure TIBRepair.GetServiceParams(ABld: TIBPBWriter);
var
  iOpts: Integer;
begin
  ABld.AddByte(isc_action_svc_repair);

  ABld.AddByte(isc_spb_dbname);
  ABld.AddLongString(DatabaseName);

  case Mode of
  rmCheckOnly,
  rmRepair:
    begin
      iOpts := 0;
      if Mode = rmCheckOnly then
        iOpts := iOpts or isc_spb_rpr_check_db;
      if roValidateFull in Options then
        iOpts := iOpts or isc_spb_rpr_full or isc_spb_rpr_validate_db
      else if roValidatePages in Options then
        iOpts := iOpts or isc_spb_rpr_validate_db
      else if roMendRecords in Options then
        iOpts := iOpts or isc_spb_rpr_mend_db
      else
        iOpts := iOpts or isc_spb_rpr_validate_db;
      if roIgnoreChecksum in Options then
        iOpts := iOpts or isc_spb_rpr_ignore_checksum;
      if roKillShadows in Options then
        iOpts := iOpts or isc_spb_rpr_kill_shadows;
      ABld.AddByte(isc_spb_options);
      ABld.AddDWord(iOpts);
    end;
  rmSweep:
    begin
      ABld.AddByte(isc_spb_options);
      ABld.AddDWord(isc_spb_rpr_sweep_db);
    end;
  end;

  inherited GetServiceParams(ABld);
end;

{-------------------------------------------------------------------------------}
{ TIBTrace                                                                      }
{-------------------------------------------------------------------------------}
constructor TIBTrace.Create(AEnv: TIBEnv; AOwningObj: TObject);
begin
  inherited Create(AEnv, AOwningObj);
  FConfig := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TIBTrace.Destroy;
begin
  FDFreeAndNil(FConfig);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TIBTrace.SetConfig(const AValue: TStrings);
begin
  FConfig.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TIBTrace.GetServiceParams(ABld: TIBPBWriter);
begin
  case Action of
  taStart:
    begin
      ABld.AddByte(isc_action_svc_trace_start);
      if SessionName <> '' then begin
        ABld.AddByte(isc_spb_trc_name);
        ABld.AddLongString(SessionName);
      end;
      ABld.AddByte(isc_spb_trc_cfg);
      ABld.AddLongString(Config.Text);
    end;
  taStop:
    begin
      ABld.AddByte(isc_action_svc_trace_stop);
      ABld.AddByte(isc_spb_trc_id);
      ABld.AddDWord(SessionID);
    end;
  taSuspend:
    begin
      ABld.AddByte(isc_action_svc_trace_suspend);
      ABld.AddByte(isc_spb_trc_id);
      ABld.AddDWord(SessionID);
    end;
  taResume:
    begin
      ABld.AddByte(isc_action_svc_trace_resume);
      ABld.AddByte(isc_spb_trc_id);
      ABld.AddDWord(SessionID);
    end;
  taList:
    begin
      ABld.AddByte(isc_action_svc_trace_list);
    end;
  end;

  inherited GetServiceParams(ABld);
end;

{-------------------------------------------------------------------------------}
function TIBTrace.QueryString(out AMessage: String): Boolean;
const
  C_Template: String = 'Trace session ID ';
var
  iCode: Integer;
begin
  Result := inherited QueryString(AMessage);
  if (Action = taStart) and (Pos(C_Template, AMessage) = 1) then
    Val(Copy(AMessage, Length(C_Template) + 1, MAXINT), FSessionID, iCode);
end;

{-------------------------------------------------------------------------------}
{ TIBSecurity                                                                   }
{-------------------------------------------------------------------------------}
const
  C_Action2IB: array [TIBSecurityAction] of Byte = (
    isc_action_svc_add_user, isc_action_svc_delete_user,
    isc_action_svc_modify_user, isc_action_svc_display_user,
    isc_action_svc_display_user);
  C_Value2IB: array [TIBSecurityValue] of Byte = (
    isc_spb_sec_username, isc_spb_sec_password, isc_spb_sec_firstname,
    isc_spb_sec_middlename, isc_spb_sec_lastname, isc_spb_sec_userid,
    isc_spb_sec_groupid, isc_spb_sec_groupname, isc_spb_sql_role_name);

{-------------------------------------------------------------------------------}
destructor TIBSecurity.Destroy;
begin
  if FUsers <> nil then
    FUsers.RemRef;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TIBSecurity.GetInt(const AIndex: Integer): Integer;
begin
  Result := StrToInt(GetStr(AIndex));
end;

{-------------------------------------------------------------------------------}
procedure TIBSecurity.SetInt(const AIndex, AValue: Integer);
begin
  SetStr(AIndex, IntToStr(AValue));
end;

{-------------------------------------------------------------------------------}
function TIBSecurity.GetStr(const AIndex: Integer): String;
begin
  Result := FValues[TIBSecurityValue(AIndex)];
end;

{-------------------------------------------------------------------------------}
procedure TIBSecurity.SetStr(const AIndex: Integer; const AValue: String);
begin
  Include(FModified, TIBSecurityValue(AIndex));
  FValues[TIBSecurityValue(AIndex)] := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TIBSecurity.GetAttachParams(ABld: TIBPBWriter);
begin
  inherited GetAttachParams(ABld);
  if EUADatabase <> '' then begin
    ABld.AddByte(isc_spb_user_dbname);
    ABld.AddShortString(EUADatabase);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBSecurity.GetServiceParams(ABld: TIBPBWriter);
var
  i: TIBSecurityValue;
begin
  ABld.AddByte(C_Action2IB[Action]);
  if Action = saDisplayUsers then
    Exit;

  ABld.AddByte(isc_spb_sec_username);
  ABld.AddLongString(AUserName);
  if Action in [saDeleteUser, saDisplayUser] then
    Exit;

  for i := Succ(Low(TIBSecurityValue)) to High(TIBSecurityValue) do
    if i in Modified then begin
      ABld.AddByte(C_Value2IB[i]);
      if i in [svUserID, svGroupID] then
        ABld.AddDWord(GetInt(Integer(i)))
      else
        ABld.AddLongString(GetStr(Integer(i)));
    end;

  inherited GetServiceParams(ABld);
end;

{-------------------------------------------------------------------------------}
procedure TIBSecurity.QuerySecurity;

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_service_query, ['svc_handle', FSvcHandle]);
  end;
{$ENDIF}

var
  oSendWrt: TIBPBWriter;
  oReqWrt: TIBPBWriter;
  oOutRdr: TIBPBReader;
  iVal: Byte;
  i, i1, i2: TIBSecurityValue;
  oRow: TFDDatSRow;
begin
  if not (Action in [saDisplayUser, saDisplayUsers]) then
    Exit;

  FModified := [];
  for i := Low(TIBSecurityValue) to High(TIBSecurityValue) do
    FValues[i] := '';

  if FUsers = nil then begin
    FUsers := TFDDatSTable.Create;
    FUsers.CountRef;
    FUsers.Columns.Add('username', dtAnsiString).Size := 50;
    FUsers.Columns.Add('password', dtAnsiString).Size := 50;
    FUsers.Columns.Add('firstname', dtAnsiString).Size := 50;
    FUsers.Columns.Add('middlename', dtAnsiString).Size := 50;
    FUsers.Columns.Add('lastname', dtAnsiString).Size := 50;
    FUsers.Columns.Add('userid', dtInt32);
    FUsers.Columns.Add('groupid', dtInt32);
    FUsers.Columns.Add('groupname', dtAnsiString).Size := 50;
    FUsers.Columns.Add('rolename', dtAnsiString).Size := 50;
  end;
  FUsers.Rows.Clear;
  oRow := nil;

  oSendWrt := TIBPBWriter.Create(Lib, FEncoder);
  oReqWrt := TIBPBWriter.Create(Lib, FEncoder);
  oOutRdr := TIBPBReader.Create(Lib, FEncoder);
  try
    if QueryTimeout > 0 then begin
      oSendWrt.AddByte(isc_info_svc_timeout);
      oSendWrt.AddDWord(QueryTimeout);
    end;

    oReqWrt.AddByte(isc_info_svc_get_users);

    oOutRdr.Reset(32000);

{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    Check(Lib.Fisc_service_query(@Error.FStatusVector, @FSvcHandle, nil,
      oSendWrt.Len, oSendWrt.AsPByte, oReqWrt.Len, oReqWrt.AsPByte,
      oOutRdr.Len, oOutRdr.AsPByte));

    if oOutRdr.GetByte <> isc_info_svc_get_users then
      Exit;

    oOutRdr.GetWord;
    while True do begin
      iVal := oOutRdr.GetByte;
      if iVal = isc_info_end then
        Break;
      case Action of
      saDisplayUser:
        for i1 := Low(TIBSecurityValue) to High(TIBSecurityValue) do
          if C_Value2IB[i1] = iVal then begin
            if i1 in [svUserID, svGroupID] then
              SetInt(Integer(i1), oOutRdr.GetInteger)
            else
              SetStr(Integer(i1), oOutRdr.GetLongString);
            Break;
          end;
      saDisplayUsers:
        begin
          if (oRow = nil) or (iVal = isc_spb_sec_username) then begin
            if oRow <> nil then
              FUsers.Rows.Add(oRow);
            oRow := FUsers.NewRow(False);
          end;
          for i2 := Low(TIBSecurityValue) to High(TIBSecurityValue) do
            if C_Value2IB[i2] = iVal then begin
              if i2 in [svUserID, svGroupID] then
                oRow.SetData(Integer(i2), oOutRdr.GetInteger)
              else
                oRow.SetData(Integer(i2), oOutRdr.GetLongString);
              Break;
            end;
        end;
      end;
    end;
  finally
    if oRow <> nil then
      FUsers.Rows.Add(oRow);
    FModified := [];
    FDFree(oSendWrt);
    FDFree(oReqWrt);
    FDFree(oOutRdr);
  end;
end;

{-------------------------------------------------------------------------------}
{ TIBConfig                                                                     }
{-------------------------------------------------------------------------------}
procedure TIBConfig.SetPageBuffers(const AValue: Cardinal);
begin
  FProperty := isc_spb_prp_page_buffers;
  FValue := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TIBConfig.SetSQLDialect(const AValue: Cardinal);
begin
  FProperty := isc_spb_prp_set_sql_dialect;
  FValue := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TIBConfig.SetSweepInterval(const AValue: Cardinal);
begin
  FProperty := isc_spb_prp_sweep_interval;
  FValue := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TIBConfig.SetReserveSpace(const AValue: TIBReserveSpace);
begin
  FProperty := isc_spb_prp_reserve_space;
  case AValue of
  rsUseFull: FValue := isc_spb_prp_res_use_full;
  rsReserve: FValue := isc_spb_prp_res;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBConfig.SetWriteMode(const AValue: TIBWriteMode);
begin
  FProperty := isc_spb_prp_write_mode;
  case AValue of
  wmAsync:  FValue := isc_spb_prp_wm_async;
  wmSync:   FValue := isc_spb_prp_wm_sync;
  wmDirect: FValue := isc_spb_prp_wm_direct;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBConfig.SetAccessMode(const AValue: TIBAccessMode);
begin
  FProperty := isc_spb_prp_access_mode;
  case AValue of
  amReadOnly:  FValue := isc_spb_prp_am_readonly;
  amReadWrite: FValue := isc_spb_prp_am_readwrite;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBConfig.ShutdownDB(AMode: TIBShutdownMode; ATimeout: Cardinal);
begin
  case AMode of
  smForce:            FProperty := isc_spb_prp_shutdown_db;
  smDenyTransactions: FProperty := isc_spb_prp_deny_new_transactions;
  smDenyAttachements: FProperty := isc_spb_prp_deny_new_attachments;
  end;
  FValue := ATimeout;
end;

{-------------------------------------------------------------------------------}
procedure TIBConfig.SetArchiveDumps(const AValue: Cardinal);
begin
  FProperty := isc_spb_prp_archive_dumps;
  FValue := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TIBConfig.SetArchiveSweep(const AValue: Cardinal);
begin
  FProperty := isc_spb_prp_archive_sweep;
  FValue := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TIBConfig.OnlineDB;
begin
  FProperty := isc_spb_options;
  FValue := isc_spb_prp_db_online;
end;

{-------------------------------------------------------------------------------}
procedure TIBConfig.ActivateShadow;
begin
  FProperty := isc_spb_options;
  FValue := isc_spb_prp_activate;
end;

             
                                       
                                       
                                     
                                   
                                   
                                     
                                 
                                   

                               
                                      
                             
                                    
                                       

                                  
                                  
                                
                                
                                   
                                   
                                    
                                    
                                  

                               
                              
                                 
                              
                               
 

{-------------------------------------------------------------------------------}
procedure TIBConfig.GetServiceParams(ABld: TIBPBWriter);
begin
  ABld.AddByte(isc_action_svc_properties);

  ABld.AddByte(isc_spb_dbname);
  ABld.AddLongString(DatabaseName);

  ABld.AddByte(FProperty);
  if (FProperty = isc_spb_prp_reserve_space) or
     (FProperty = isc_spb_prp_write_mode) or
     (FProperty = isc_spb_prp_access_mode) then
    ABld.AddByte(FValue)
  else
    ABld.AddDWord(FValue);

  inherited GetServiceParams(ABld);
end;

{-------------------------------------------------------------------------------}
{ TIBInfo                                                                       }
{-------------------------------------------------------------------------------}
procedure TIBInfo.QueryInfo(ARequest: TRequestProc; AParse: TParseFunc);

{$IFDEF FireDAC_MONITOR}
  procedure Trace1;
  begin
    Env.Trace(sisc_service_query, ['svc_handle', FSvcHandle]);
  end;
{$ENDIF}

var
  oSendWrt: TIBPBWriter;
  oReqWrt: TIBPBWriter;
  oOutRdr: TIBPBReader;
begin
  oSendWrt := TIBPBWriter.Create(Lib, FEncoder);
  oReqWrt := TIBPBWriter.Create(Lib, FEncoder);
  oOutRdr := TIBPBReader.Create(Lib, FEncoder);
  try
    if QueryTimeout > 0 then begin
      oSendWrt.AddByte(isc_info_svc_timeout);
      oSendWrt.AddDWord(QueryTimeout);
    end;

    ARequest(oReqWrt);

    oOutRdr.Reset(32000);

{$IFDEF FireDAC_MONITOR}
    if Env.Tracing then Trace1;
{$ENDIF}
    Check(Lib.Fisc_service_query(@Error.FStatusVector, @FSvcHandle, nil,
      oSendWrt.Len, oSendWrt.AsPByte, oReqWrt.Len, oReqWrt.AsPByte,
      oOutRdr.Len, oOutRdr.AsPByte));

    while not oOutRdr.Eof and AParse(oOutRdr) do
      ;
  finally
    FDFree(oSendWrt);
    FDFree(oReqWrt);
    FDFree(oOutRdr);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TIBInfo.Start;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TIBInfo.GetVersion(out AVersion: TVersion);
var
  pVer: ^TVersion;
begin
  AVersion.FService := 0;
  AVersion.FServerStr := '';
  AVersion.FServer := 0;
  AVersion.FImplementation := '';
  pVer := @AVersion;

  QueryInfo(
    procedure (AReqWrt: TIBPBWriter)
    begin
      AReqWrt.AddByte(isc_info_svc_version);
      AReqWrt.AddByte(isc_info_svc_server_version);
      AReqWrt.AddByte(isc_info_svc_implementation);
    end,

    function (AOutRdr: TIBPBReader): Boolean
    begin
      Result := True;
      case AOutRdr.GetByte of
      isc_info_svc_version:
        pVer^.FService := AOutRdr.GetInteger;
      isc_info_svc_server_version:
        begin
          pVer^.FServerStr := AOutRdr.GetLongString;
          pVer^.FServer := FDVerStr2Int(pVer^.FServerStr);
        end;
      isc_info_svc_implementation:
        pVer^.FImplementation := AOutRdr.GetLongString;
      else
        Result := False;
      end;
    end
  );
end;

{-------------------------------------------------------------------------------}
procedure TIBInfo.GetLicense(out ALicense: TLicense);
var
  pLic: ^TLicense;
begin
  SetLength(ALicense.FCertificates, 0);
  ALicense.FLicenseMask := 0;
  ALicense.FCapabilities := 0;
  ALicense.FUsers := 0;
  ALicense.FProduct := '';
  pLic := @ALicense;

  QueryInfo(
    procedure (AReqWrt: TIBPBWriter)
    begin
      AReqWrt.AddByte(isc_info_svc_get_license);
      AReqWrt.AddByte(isc_info_svc_get_license_mask);
      AReqWrt.AddByte(isc_info_svc_capabilities);
      AReqWrt.AddByte(isc_info_svc_get_licensed_users);
      AReqWrt.AddByte(isc_info_svc_product_identifier);
    end,

    function (AOutRdr: TIBPBReader): Boolean
    var
      iCluster: Byte;
      i: Integer;
    begin
      Result := True;
      case AOutRdr.GetByte of
      isc_info_svc_get_license:
        begin
          i := 0;
          while not AOutRdr.Eof do begin
            iCluster := AOutRdr.GetByte;
            if iCluster = isc_info_flag_end then
              Break;
            if i = Length(pLic^.FCertificates) then
              SetLength(pLic^.FCertificates, Length(pLic^.FCertificates) + 1);
            if iCluster = isc_spb_lic_id then
              pLic^.FCertificates[i].FID := AOutRdr.GetLongString;
            if AOutRdr.GetByte = isc_spb_lic_key then
              pLic^.FCertificates[i].FKey := AOutRdr.GetLongString;
            if AOutRdr.GetByte = isc_spb_lic_desc then
              pLic^.FCertificates[i].FDesc := AOutRdr.GetLongString;
            Inc(i);
          end;
        end;
      isc_info_svc_get_license_mask:
        pLic^.FLicenseMask := AOutRdr.GetInteger;
      isc_info_svc_capabilities:
        pLic^.FCapabilities := AOutRdr.GetInteger;
      isc_info_svc_get_licensed_users:
        pLic^.FUsers := AOutRdr.GetInteger;
      isc_info_svc_product_identifier:
        pLic^.FProduct := AOutRdr.GetLongString;
      else
        Result := False;
      end;
    end
  );
end;

{-------------------------------------------------------------------------------}
procedure TIBInfo.GetConfig(out AConfig: TConfig);
var
  pConf: ^TConfig;
begin
  SetLength(AConfig.FConfig, 0);
  AConfig.FServerPath := '';
  AConfig.FLockPath := '';
  AConfig.FMessagePath := '';
  AConfig.FSecurityDBFile := '';
  pConf := @AConfig;

  QueryInfo(
    procedure (AReqWrt: TIBPBWriter)
    begin
      AReqWrt.AddByte(isc_info_svc_get_config);
      AReqWrt.AddByte(isc_info_svc_get_env);
      AReqWrt.AddByte(isc_info_svc_get_env_lock);
      AReqWrt.AddByte(isc_info_svc_get_env_msg);
      AReqWrt.AddByte(isc_info_svc_user_dbpath);
    end,

    function (AOutRdr: TIBPBReader): Boolean
    var
      iCluster: Byte;
      i: Integer;
    begin
      Result := True;
      case AOutRdr.GetByte of
      isc_info_svc_get_config:
        begin
          i := 0;
          while not AOutRdr.Eof do begin
            iCluster := AOutRdr.GetByte;
            if iCluster = isc_info_flag_end then
              Break;
            if i = Length(pConf^.FConfig) then
              SetLength(pConf^.FConfig, Length(pConf^.FConfig) + 1);
            pConf^.FConfig[i].FID := iCluster;
            pConf^.FConfig[i].FValue := AOutRdr.GetInteger;
            Inc(i);
          end;
        end;
      isc_info_svc_get_env:
        pConf^.FServerPath := AOutRdr.GetLongString;
      isc_info_svc_get_env_lock:
        pConf^.FLockPath := AOutRdr.GetLongString;
      isc_info_svc_get_env_msg:
        pConf^.FMessagePath := AOutRdr.GetLongString;
      isc_info_svc_user_dbpath:
        pConf^.FSecurityDBFile := AOutRdr.GetLongString;
      else
        Result := False;
      end;
    end
  );
end;

{-------------------------------------------------------------------------------}
procedure TIBInfo.GetUsage(out AUsage: TUsage);
var
  pUsg: ^TUsage;
begin
  SetLength(AUsage.FDBNames, 0);
  AUsage.FAttachments := 0;
  AUsage.FDatabases := 0;
  pUsg := @AUsage;

  QueryInfo(
    procedure (AReqWrt: TIBPBWriter)
    begin
      AReqWrt.AddByte(isc_info_svc_svr_db_info);
    end,

    function (AOutRdr: TIBPBReader): Boolean
    var
      iCluster: Byte;
      i: Integer;
    begin
      Result := True;
      case AOutRdr.GetByte of
      isc_info_svc_svr_db_info:
        begin
          if AOutRdr.GetByte = isc_spb_num_att then
            pUsg^.FAttachments := AOutRdr.GetInteger;
          if AOutRdr.GetByte = isc_spb_num_db then
            pUsg^.FDatabases := AOutRdr.GetInteger;
          SetLength(pUsg^.FDBNames, pUsg^.FDatabases);
          i := 0;
          while not AOutRdr.Eof do begin
            iCluster := AOutRdr.GetByte;
            if iCluster = isc_info_flag_end then
              Break;
            if iCluster = isc_spb_dbname then begin
              pUsg^.FDBNames[i] := AOutRdr.GetLongString;
              Inc(i);
            end;
          end;
        end;
      else
        Result := False;
      end;
    end
  );
end;

{-------------------------------------------------------------------------------}
function IBNativeExceptionLoad(const AStorage: IFDStanStorage): TObject;
begin
  Result := EIBNativeException.Create;
  EIBNativeException(Result).LoadFromStorage(AStorage);
end;

{-------------------------------------------------------------------------------}
initialization
  FDStorageManager().RegisterClass(EIBNativeException, 'IBNativeException',
    @IBNativeExceptionLoad, @FDExceptionSave);

end.
