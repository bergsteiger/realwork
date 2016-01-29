{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{             Sqlite API Interface Unit                 }
{                                                       }
{*******************************************************}

{ Files: sqlite.h }

unit System.Sqlite;

{$WEAKPACKAGEUNIT}

interface

const
{$IFDEF MSWINDOWS}
  sqlite3dll = 'sqlite3.dll';
  _PU = '';
{$ENDIF}
{$IFDEF MACOS}
  {$IFDEF IOS}
    sqlite3dll = '/usr/lib/libsqlite3.dylib';
  {$ELSE}
    sqlite3dll = 'libsqlite3.dylib';
  {$ENDIF}
  {$IFDEF UNDERSCOREIMPORTNAME}
  _PU = '_';
  {$ELSE}
  _PU = '';
  {$ENDIF}
{$ENDIF}
  {$EXTERNALSYM sqlite3dll}

  SQLITE_VERSION = '3.7.8';
  {$EXTERNALSYM SQLITE_VERSION}
  SQLITE_VERSION_NUMBER = 3007008;
  {$EXTERNALSYM SQLITE_VERSION_NUMBER}
  SQLITE_SOURCE_ID = '2011-09-19 14:49:19 3e0da808d2f5b4d12046e05980ca04578f581177';
  {$EXTERNALSYM SQLITE_SOURCE_ID}

function sqlite3_libversion: MarshaledAString; cdecl;
{$EXTERNALSYM sqlite3_libversion}
function sqlite3_sourceid: MarshaledAString; cdecl;
{$EXTERNALSYM sqlite3_sourceid}
function sqlite3_libversion_number: Integer; cdecl;
{$EXTERNALSYM sqlite3_libversion_number}

function sqlite3_compileoption_used(zOptName: MarshaledAString): Integer; cdecl;
{$EXTERNALSYM sqlite3_compileoption_used}

function sqlite3_compileoption_get(N: Integer): MarshaledAString; cdecl;
{$EXTERNALSYM sqlite3_compileoption_get}

function sqlite3_threadsafe: Integer; cdecl;
{$EXTERNALSYM sqlite3_threadsafe}

type
  sqlite3 = Pointer;
  {$EXTERNALSYM sqlite3}
  sqlite_int64 = Int64;
  {$EXTERNALSYM sqlite_int64}
  sqlite_uint64 = UInt64;
  {$EXTERNALSYM sqlite_uint64}
  sqlite3_int64 = sqlite_int64;
  {$EXTERNALSYM sqlite3_int64}
  sqlite3_uint64 = sqlite_uint64;
  {$EXTERNALSYM sqlite3_uint64}

function sqlite3_close(DbConnection: sqlite3): Integer; cdecl;
{$EXTERNALSYM sqlite3_close}

type
  TSqlite3ExecCallback = function(Param: Pointer; NumCols: Integer; ColTextStrs: PPChar;
                                  ColNameStrs: PPChar): Integer; cdecl;

function sqlite3_exec(DbConnection: sqlite3; sql: PChar; Callback: TSqlite3ExecCallback;
                      CallbackArg: Pointer; ErrMsg: PPChar): Integer; cdecl;
{$EXTERNALSYM sqlite3_exec}

const
  SQLITE_OK = 0;   // Successful result
  {$EXTERNALSYM SQLITE_OK}
// beginning-of-error-codes
  SQLITE_ERROR = 1; // SQL error or missing database
  {$EXTERNALSYM SQLITE_ERROR}
  SQLITE_INTERNAL = 2; // Internal logic error in SQLite
  {$EXTERNALSYM SQLITE_INTERNAL}
  SQLITE_PERM = 3; // Access permission denied
  {$EXTERNALSYM SQLITE_PERM}
  SQLITE_ABORT = 4; // Callback routine requested an abort
  {$EXTERNALSYM SQLITE_ABORT}
  SQLITE_BUSY = 5; // The database file is locked
  {$EXTERNALSYM SQLITE_BUSY}
  SQLITE_LOCKED = 6; // A table in the database is locked
  {$EXTERNALSYM SQLITE_LOCKED}
  SQLITE_NOMEM = 7; // A malloc() failed
  {$EXTERNALSYM SQLITE_NOMEM}
  SQLITE_READONLY = 8; // Attempt to write a readonly database
  {$EXTERNALSYM SQLITE_READONLY}
  SQLITE_INTERRUPT = 9; // Operation terminated by sqlite3_interrupt()
  {$EXTERNALSYM SQLITE_INTERRUPT}
  SQLITE_IOERR = 10; // Some kind of disk I/O error occurred
  {$EXTERNALSYM SQLITE_IOERR}
  SQLITE_CORRUPT = 11; // The database disk image is malformed
  {$EXTERNALSYM SQLITE_CORRUPT}
  SQLITE_NOTFOUND = 12; // Unknown opcode in sqlite3_file_control()
  {$EXTERNALSYM SQLITE_NOTFOUND}
  SQLITE_FULL = 13; // Insertion failed because database is full
  {$EXTERNALSYM SQLITE_FULL}
  SQLITE_CANTOPEN = 14; // Unable to open the database file
  {$EXTERNALSYM SQLITE_CANTOPEN}
  SQLITE_PROTOCOL = 15; // Database lock protocol error
  {$EXTERNALSYM SQLITE_PROTOCOL}
  SQLITE_EMPTY = 16; // Database is empty
  {$EXTERNALSYM SQLITE_EMPTY}
  SQLITE_SCHEMA = 17; // The database schema changed
  {$EXTERNALSYM SQLITE_SCHEMA}
  SQLITE_TOOBIG = 18; // String or BLOB exceeds size limit
  {$EXTERNALSYM SQLITE_TOOBIG}
  SQLITE_CONSTRAINT = 19; // Abort due to constraint violation
  {$EXTERNALSYM SQLITE_CONSTRAINT}
  SQLITE_MISMATCH = 20; // Data type mismatch
  {$EXTERNALSYM SQLITE_MISMATCH}
  SQLITE_MISUSE = 21; // Library used incorrectly
  {$EXTERNALSYM SQLITE_MISUSE}
  SQLITE_NOLFS = 22; // Uses OS features not supported on host
  {$EXTERNALSYM SQLITE_NOLFS}
  SQLITE_AUTH = 23; // Authorization denied
  {$EXTERNALSYM SQLITE_AUTH}
  SQLITE_FORMAT = 24; // Auxiliary database format error
  {$EXTERNALSYM SQLITE_FORMAT}
  SQLITE_RANGE = 25; // 2nd parameter to sqlite3_bind out of range
  {$EXTERNALSYM SQLITE_RANGE}
  SQLITE_NOTADB = 26; // File opened that is not a database file
  {$EXTERNALSYM SQLITE_NOTADB}
  SQLITE_ROW = 100; // sqlite3_step() has another row ready
  {$EXTERNALSYM SQLITE_ROW}
  SQLITE_DONE = 101; // sqlite3_step() has finished executing
  {$EXTERNALSYM SQLITE_DONE}
// end-of-error-codes

  SQLITE_IOERR_READ = (SQLITE_IOERR or (1 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_READ}
  SQLITE_IOERR_SHORT_READ = (SQLITE_IOERR or (2 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_SHORT_READ}
  SQLITE_IOERR_WRITE = (SQLITE_IOERR or (3 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_WRITE}
  SQLITE_IOERR_FSYNC = (SQLITE_IOERR or (4 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_FSYNC}
  SQLITE_IOERR_DIR_FSYNC = (SQLITE_IOERR or (5 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_DIR_FSYNC}
  SQLITE_IOERR_TRUNCATE = (SQLITE_IOERR or (6 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_TRUNCATE}
  SQLITE_IOERR_FSTAT = (SQLITE_IOERR or (7 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_FSTAT}
  SQLITE_IOERR_UNLOCK = (SQLITE_IOERR or (8 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_UNLOCK}
  SQLITE_IOERR_RDLOCK = (SQLITE_IOERR or (9 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_RDLOCK}
  SQLITE_IOERR_DELETE = (SQLITE_IOERR or (10 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_DELETE}
  SQLITE_IOERR_BLOCKED = (SQLITE_IOERR or (11 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_BLOCKED}
  SQLITE_IOERR_NOMEM = (SQLITE_IOERR or (12 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_NOMEM}
  SQLITE_IOERR_ACCESS = (SQLITE_IOERR or (13 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_ACCESS}
  SQLITE_IOERR_CHECKRESERVEDLOCK = (SQLITE_IOERR or (14 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_CHECKRESERVEDLOCK}
  SQLITE_IOERR_LOCK = (SQLITE_IOERR or (15 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_LOCK}
  SQLITE_IOERR_CLOSE = (SQLITE_IOERR or (16 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_CLOSE}
  SQLITE_IOERR_DIR_CLOSE = (SQLITE_IOERR or (17 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_DIR_CLOSE}
  SQLITE_IOERR_SHMOPEN = (SQLITE_IOERR or (18 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_SHMOPEN}
  SQLITE_IOERR_SHMSIZE = (SQLITE_IOERR or (19 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_SHMSIZE}
  SQLITE_IOERR_SHMLOCK = (SQLITE_IOERR or (20 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_SHMLOCK}
  SQLITE_IOERR_SHMMAP = (SQLITE_IOERR or (21 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_SHMMAP}
  SQLITE_IOERR_SEEK = (SQLITE_IOERR or (22 shl 8));
  {$EXTERNALSYM SQLITE_IOERR_SEEK}
  SQLITE_LOCKED_SHAREDCACHE = (SQLITE_LOCKED or  (1 shl 8));
  {$EXTERNALSYM SQLITE_LOCKED_SHAREDCACHE}
  SQLITE_BUSY_RECOVERY = (SQLITE_BUSY   or  (1 shl 8));
  {$EXTERNALSYM SQLITE_BUSY_RECOVERY}
  SQLITE_CANTOPEN_NOTEMPDIR = (SQLITE_CANTOPEN or (1 shl 8));
  {$EXTERNALSYM SQLITE_CANTOPEN_NOTEMPDIR}
  SQLITE_CORRUPT_VTAB = (SQLITE_CORRUPT or (1 shl 8));
  {$EXTERNALSYM SQLITE_CORRUPT_VTAB}
  SQLITE_READONLY_RECOVERY = (SQLITE_READONLY or (1 shl 8));
  {$EXTERNALSYM SQLITE_READONLY_RECOVERY}
  SQLITE_READONLY_CANTLOCK = (SQLITE_READONLY or (2 shl 8));
  {$EXTERNALSYM SQLITE_READONLY_CANTLOCK}

  SQLITE_OPEN_READONLY = $00000001;  // Ok for sqlite3_open_v2()
  {$EXTERNALSYM SQLITE_OPEN_READONLY}
  SQLITE_OPEN_READWRITE = $00000002;  // Ok for sqlite3_open_v2()
  {$EXTERNALSYM SQLITE_OPEN_READWRITE}
  SQLITE_OPEN_CREATE = $00000004;  // Ok for sqlite3_open_v2()
  {$EXTERNALSYM SQLITE_OPEN_CREATE}
  SQLITE_OPEN_DELETEONCLOSE = $00000008;  // VFS only
  {$EXTERNALSYM SQLITE_OPEN_DELETEONCLOSE}
  SQLITE_OPEN_EXCLUSIVE = $00000010;  // VFS only
  {$EXTERNALSYM SQLITE_OPEN_EXCLUSIVE}
  SQLITE_OPEN_AUTOPROXY = $00000020;  // VFS only
  {$EXTERNALSYM SQLITE_OPEN_AUTOPROXY}
  SQLITE_OPEN_URI = $00000040;  // Ok for sqlite3_open_v2()
  {$EXTERNALSYM SQLITE_OPEN_URI}
  SQLITE_OPEN_MAIN_DB = $00000100;  // VFS only
  {$EXTERNALSYM SQLITE_OPEN_MAIN_DB}
  SQLITE_OPEN_TEMP_DB = $00000200;  // VFS only
  {$EXTERNALSYM SQLITE_OPEN_TEMP_DB}
  SQLITE_OPEN_TRANSIENT_DB = $00000400;  // VFS only
  {$EXTERNALSYM SQLITE_OPEN_TRANSIENT_DB}
  SQLITE_OPEN_MAIN_JOURNAL = $00000800;  // VFS only
  {$EXTERNALSYM SQLITE_OPEN_MAIN_JOURNAL}
  SQLITE_OPEN_TEMP_JOURNAL = $00001000;  // VFS only
  {$EXTERNALSYM SQLITE_OPEN_TEMP_JOURNAL}
  SQLITE_OPEN_SUBJOURNAL = $00002000;  // VFS only
  {$EXTERNALSYM SQLITE_OPEN_SUBJOURNAL}
  SQLITE_OPEN_MASTER_JOURNAL = $00004000;  // VFS only
  {$EXTERNALSYM SQLITE_OPEN_MASTER_JOURNAL}
  SQLITE_OPEN_NOMUTEX = $00008000;  // Ok for sqlite3_open_v2()
  {$EXTERNALSYM SQLITE_OPEN_NOMUTEX}
  SQLITE_OPEN_FULLMUTEX = $00010000;  // Ok for sqlite3_open_v2()
  {$EXTERNALSYM SQLITE_OPEN_FULLMUTEX}
  SQLITE_OPEN_SHAREDCACHE = $00020000;  // Ok for sqlite3_open_v2()
  {$EXTERNALSYM SQLITE_OPEN_SHAREDCACHE}
  SQLITE_OPEN_PRIVATECACHE = $00040000;  // Ok for sqlite3_open_v2()
  {$EXTERNALSYM SQLITE_OPEN_PRIVATECACHE}
  SQLITE_OPEN_WAL = $00080000;  // VFS only
  {$EXTERNALSYM SQLITE_OPEN_WAL}

// Reserved:                         $00F00000

  SQLITE_IOCAP_ATOMIC = $00000001;
  {$EXTERNALSYM SQLITE_IOCAP_ATOMIC}
  SQLITE_IOCAP_ATOMIC512 = $00000002;
  {$EXTERNALSYM SQLITE_IOCAP_ATOMIC512}
  SQLITE_IOCAP_ATOMIC1K = $00000004;
  {$EXTERNALSYM SQLITE_IOCAP_ATOMIC1K}
  SQLITE_IOCAP_ATOMIC2K = $00000008;
  {$EXTERNALSYM SQLITE_IOCAP_ATOMIC2K}
  SQLITE_IOCAP_ATOMIC4K = $00000010;
  {$EXTERNALSYM SQLITE_IOCAP_ATOMIC4K}
  SQLITE_IOCAP_ATOMIC8K = $00000020;
  {$EXTERNALSYM SQLITE_IOCAP_ATOMIC8K}
  SQLITE_IOCAP_ATOMIC16K = $00000040;
  {$EXTERNALSYM SQLITE_IOCAP_ATOMIC16K}
  SQLITE_IOCAP_ATOMIC32K = $00000080;
  {$EXTERNALSYM SQLITE_IOCAP_ATOMIC32K}
  SQLITE_IOCAP_ATOMIC64K = $00000100;
  {$EXTERNALSYM SQLITE_IOCAP_ATOMIC64K}
  SQLITE_IOCAP_SAFE_APPEND = $00000200;
  {$EXTERNALSYM SQLITE_IOCAP_SAFE_APPEND}
  SQLITE_IOCAP_SEQUENTIAL = $00000400;
  {$EXTERNALSYM SQLITE_IOCAP_SEQUENTIAL}
  SQLITE_IOCAP_UNDELETABLE_WHEN_OPEN = $00000800;
  {$EXTERNALSYM SQLITE_IOCAP_UNDELETABLE_WHEN_OPEN}

  SQLITE_LOCK_NONE = 0;
  {$EXTERNALSYM SQLITE_LOCK_NONE}
  SQLITE_LOCK_SHARED = 1;
  {$EXTERNALSYM SQLITE_LOCK_SHARED}
  SQLITE_LOCK_RESERVED = 2;
  {$EXTERNALSYM SQLITE_LOCK_RESERVED}
  SQLITE_LOCK_PENDING = 3;
  {$EXTERNALSYM SQLITE_LOCK_PENDING}
  SQLITE_LOCK_EXCLUSIVE = 4;
  {$EXTERNALSYM SQLITE_LOCK_EXCLUSIVE}

  SQLITE_SYNC_NORMAL = $00002;
  {$EXTERNALSYM SQLITE_SYNC_NORMAL}
  SQLITE_SYNC_FULL = $00003;
  {$EXTERNALSYM SQLITE_SYNC_FULL}
  SQLITE_SYNC_DATAONLY = $00010;
  {$EXTERNALSYM SQLITE_SYNC_DATAONLY}

//typedef struct sqlite3_file sqlite3_file;
type
  PSqlite3_IO_Methods = ^sqlite3_io_methods;
  {$EXTERNALSYM PSqlite3_IO_Methods}

  sqlite3_file = record
    pMethods: PSqlite3_IO_Methods;
  end;
  {$EXTERNALSYM sqlite3_file}

  PSqlite3_file = ^sqlite3_file;
  {$EXTERNALSYM PSqlite3_file}

  sqlite3_io_methods = record
    iVersion: Integer;
    xClose: function(aFile: PSqlite3_file): Integer; cdecl;
    xRead: function(aFile: PSqlite3_file; Buffer: Pointer; iAmt: Integer; iOfst: sqlite3_int64): Integer; cdecl;
    xWrite: function(aFile: PSqlite3_file; Buffer: Pointer; iAmt: Integer; iOfst: sqlite3_int64): Integer; cdecl;
    xTruncate: function(aFile: PSqlite3_file; size: sqlite3_int64): Integer; cdecl;
    xSync: function(aFile: PSqlite3_file; flags: Integer): Integer; cdecl;
    xFileSize: function(aFile: PSqlite3_file; var Size: sqlite3_int64): Integer; cdecl;
    xLock: function(aFile: PSqlite3_file; Lock: Integer): Integer; cdecl;
    xUnlock: function(aFile: PSqlite3_file; Lock: Integer): Integer; cdecl;
    xCheckReservedLock: function(aFile: PSqlite3_file; var ResOut: Integer): Integer; cdecl;
    xFileControl: function(aFile: PSqlite3_file; op: Integer; pArg: Pointer): Integer; cdecl;
    xSectorSize: function(aFile: PSqlite3_file): Integer; cdecl;
    xDeviceCharacteristics: function(aFile: PSqlite3_file): Integer; cdecl;
    xShmMap: function(aFile: PSqlite3_file; iPg, pgsz, param: Integer; volatile: Pointer): Integer; cdecl;
    xShmLock: function(aFile: PSqlite3_file; offset, n, flags: Integer): Integer; cdecl;
    xShmBarrier: procedure(aFile: PSqlite3_file); cdecl;
    xShmUnmap: function(aFile: PSqlite3_file; deleteFlag: Integer): Integer; cdecl;
  end;
  {$EXTERNALSYM sqlite3_io_methods}

const
  SQLITE_FCNTL_LOCKSTATE = 1;
  {$EXTERNALSYM SQLITE_FCNTL_LOCKSTATE}
  SQLITE_GET_LOCKPROXYFILE = 2;
  {$EXTERNALSYM SQLITE_GET_LOCKPROXYFILE}
  SQLITE_SET_LOCKPROXYFILE = 3;
  {$EXTERNALSYM SQLITE_SET_LOCKPROXYFILE}
  SQLITE_LAST_ERRNO = 4;
  {$EXTERNALSYM SQLITE_LAST_ERRNO}
  SQLITE_FCNTL_SIZE_HINT = 5;
  {$EXTERNALSYM SQLITE_FCNTL_SIZE_HINT}
  SQLITE_FCNTL_CHUNK_SIZE = 6;
  {$EXTERNALSYM SQLITE_FCNTL_CHUNK_SIZE}
  SQLITE_FCNTL_FILE_POINTER = 7;
  {$EXTERNALSYM SQLITE_FCNTL_FILE_POINTER}
  SQLITE_FCNTL_SYNC_OMITTED = 8;
  {$EXTERNALSYM SQLITE_FCNTL_SYNC_OMITTED}
  SQLITE_FCNTL_WIN32_AV_RETRY = 9;
  {$EXTERNALSYM SQLITE_FCNTL_WIN32_AV_RETRY}
  SQLITE_FCNTL_PERSIST_WAL = 10;
  {$EXTERNALSYM SQLITE_FCNTL_PERSIST_WAL}

type
  sqlite3_syscall_ptr = procedure(); cdecl;
  {$EXTERNALSYM sqlite3_syscall_ptr}

  PSqlite3_vfs = ^sqlite3_vfs;
  {$EXTERNALSYM PSqlite3_vfs}

  TxDlSym2 = procedure(); cdecl;

  sqlite3_vfs = record
    iVersion: Integer;
    szOsFile: Integer;
    mxPathname: Integer;
    pNext: PSqlite3_vfs;
    zName: MarshaledAString;
    pAppData: Pointer;
    xOpen: function(Vfs: PSqlite3_vfs; zName: MarshaledAString; aFile: PSqlite3_file; flags: Integer;
                    var OutFlags: Integer): Integer; cdecl;
    xDelete: function(Vfs: PSqlite3_vfs; zName: MarshaledAString; syncDir: Integer): Integer; cdecl;
    xAccess: function(Vfs: PSqlite3_vfs; zName: MarshaledAString; flags: Integer; var ResOut: Integer): Integer; cdecl;
    xFullPathname: function(Vfs: PSqlite3_vfs; zName: MarshaledAString; nOut: Integer; zOut: MarshaledAString): Integer; cdecl;
    xDlOpen: function(Vfs: PSqlite3_vfs; zFilename: MarshaledAString): Pointer; cdecl;
    xDlError: procedure(Vfs: PSqlite3_vfs; nByte: Integer; zErrMsg: MarshaledAString); cdecl;
    xDlSym: function(Vfs: PSqlite3_vfs; Ptr: Pointer; zSymbol: MarshaledAString): TxDlSym2; cdecl;
    xDlClose: procedure(Vfs: PSqlite3_vfs; Ptr: Pointer); cdecl;
    xRandomness: function(Vfs: PSqlite3_vfs; nByte: Integer; zOut: MarshaledAString): Integer; cdecl;
    xSleep: function(Vfs: PSqlite3_vfs; microseconds: Integer): Integer; cdecl;
    xCurrentTime: function(Vfs: PSqlite3_vfs; var Time: Double): Integer; cdecl;
    xGetLastError: function(Vfs: PSqlite3_vfs; ErrorCode: Integer; ErrorMsg: MarshaledAString): Integer; cdecl;
    xCurrentTimeInt64: function(Vfs: PSqlite3_vfs; var Time: sqlite3_int64): Integer; cdecl;
    xSetSystemCall: function(Vfs: PSqlite3_vfs; zName: MarshaledAString; Ptr: sqlite3_syscall_ptr): Integer; cdecl;
    xGetSystemCall: function(Vfs: PSqlite3_vfs; zName: MarshaledAString): sqlite3_syscall_ptr; cdecl;
    xNextSystemCall: function(Vfs: PSqlite3_vfs; zName: MarshaledAString): MarshaledAString; cdecl;
  end;
  {$EXTERNALSYM sqlite3_vfs}

const
  SQLITE_ACCESS_EXISTS = 0;
  {$EXTERNALSYM SQLITE_ACCESS_EXISTS}
  SQLITE_ACCESS_READWRITE = 1;   // Used by PRAGMA temp_store_directory
  {$EXTERNALSYM SQLITE_ACCESS_READWRITE}
  SQLITE_ACCESS_READ = 2;   // Unused
  {$EXTERNALSYM SQLITE_ACCESS_READ}

  SQLITE_SHM_UNLOCK = 1;
  {$EXTERNALSYM SQLITE_SHM_UNLOCK}
  SQLITE_SHM_LOCK = 2;
  {$EXTERNALSYM SQLITE_SHM_LOCK}
  SQLITE_SHM_SHARED = 4;
  {$EXTERNALSYM SQLITE_SHM_SHARED}
  SQLITE_SHM_EXCLUSIVE = 8;
  {$EXTERNALSYM SQLITE_SHM_EXCLUSIVE}

  SQLITE_SHM_NLOCK = 8;
  {$EXTERNALSYM SQLITE_SHM_NLOCK}

function sqlite3_initialize: Integer; cdecl;
{$EXTERNALSYM sqlite3_initialize}
function sqlite3_shutdown: Integer; cdecl;
{$EXTERNALSYM sqlite3_shutdown}
function sqlite3_os_init: Integer; cdecl;
{$EXTERNALSYM sqlite3_os_init}
function sqlite3_os_end: Integer; cdecl;
{$EXTERNALSYM sqlite3_os_end}

function sqlite3_config(Option: Integer): Integer; cdecl; varargs;
{$EXTERNALSYM sqlite3_config}

function sqlite3_db_config(DbConnection: sqlite3; op: Integer): Integer; cdecl; varargs;
{$EXTERNALSYM sqlite3_db_config}

type
  sqlite3_mem_methods = record
    xMalloc: function(Size: Integer): Pointer; cdecl;
    xFree: procedure(Obj: Pointer); cdecl;
    xRealloc: function(Obj: Pointer; Size: Integer): Pointer; cdecl;
    xSize: function(Obj: Pointer): Integer; cdecl;
    xRoundup: function(Size: Integer): Integer; cdecl;
    xInit: function(Obj: Pointer): Integer; cdecl;
    xShutdown: procedure(Obj: Pointer); cdecl;
    pAppData: Pointer;
  end;
  {$EXTERNALSYM sqlite3_mem_methods}

const
  SQLITE_CONFIG_SINGLETHREAD = 1;  // nil
  {$EXTERNALSYM SQLITE_CONFIG_SINGLETHREAD}
  SQLITE_CONFIG_MULTITHREAD =  2;  // nil
  {$EXTERNALSYM SQLITE_CONFIG_MULTITHREAD}
  SQLITE_CONFIG_SERIALIZED =   3;  // nil
  {$EXTERNALSYM SQLITE_CONFIG_SERIALIZED}
  SQLITE_CONFIG_MALLOC =       4;  // sqlite3_mem_methods*
  {$EXTERNALSYM SQLITE_CONFIG_MALLOC}
  SQLITE_CONFIG_GETMALLOC =    5;  // sqlite3_mem_methods*
  {$EXTERNALSYM SQLITE_CONFIG_GETMALLOC}
  SQLITE_CONFIG_SCRATCH =      6;  // void*, int sz, int N
  {$EXTERNALSYM SQLITE_CONFIG_SCRATCH}
  SQLITE_CONFIG_PAGECACHE =    7;  // void*, int sz, int N
  {$EXTERNALSYM SQLITE_CONFIG_PAGECACHE}
  SQLITE_CONFIG_HEAP =         8;  // void*, int nByte, int min
  {$EXTERNALSYM SQLITE_CONFIG_HEAP}
  SQLITE_CONFIG_MEMSTATUS =    9;  // boolean
  {$EXTERNALSYM SQLITE_CONFIG_MEMSTATUS}
  SQLITE_CONFIG_MUTEX =       10;  // sqlite3_mutex_methods*
  {$EXTERNALSYM SQLITE_CONFIG_MUTEX}
  SQLITE_CONFIG_GETMUTEX =    11;  // sqlite3_mutex_methods*
  {$EXTERNALSYM SQLITE_CONFIG_GETMUTEX}
// previously SQLITE_CONFIG_CHUNKALLOC 12 which is now unused.
  SQLITE_CONFIG_LOOKASIDE =   13;  // int int
  {$EXTERNALSYM SQLITE_CONFIG_LOOKASIDE}
  SQLITE_CONFIG_PCACHE =      14;  // sqlite3_pcache_methods*
  {$EXTERNALSYM SQLITE_CONFIG_PCACHE}
  SQLITE_CONFIG_GETPCACHE =   15;  // sqlite3_pcache_methods*
  {$EXTERNALSYM SQLITE_CONFIG_GETPCACHE}
  SQLITE_CONFIG_LOG =         16;  // xFunc, void*
  {$EXTERNALSYM SQLITE_CONFIG_LOG}
  SQLITE_CONFIG_URI =         17;  // int
  {$EXTERNALSYM SQLITE_CONFIG_URI}

  SQLITE_DBCONFIG_LOOKASIDE =      1001;  // void* int int
  {$EXTERNALSYM SQLITE_DBCONFIG_LOOKASIDE}
  SQLITE_DBCONFIG_ENABLE_FKEY =    1002;  // int int*
  {$EXTERNALSYM SQLITE_DBCONFIG_ENABLE_FKEY}
  SQLITE_DBCONFIG_ENABLE_TRIGGER = 1003;  // int int*
  {$EXTERNALSYM SQLITE_DBCONFIG_ENABLE_TRIGGER}

function sqlite3_extended_result_codes(DbConnection: sqlite3; onoff: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_extended_result_codes}

function sqlite3_last_insert_rowid(DbConnection: sqlite3): sqlite3_int64; cdecl;
{$EXTERNALSYM sqlite3_last_insert_rowid}

function sqlite3_changes(DbConnection: sqlite3): Integer; cdecl;
{$EXTERNALSYM sqlite3_changes}

function sqlite3_total_changes(DbConnection: sqlite3): Integer; cdecl;
{$EXTERNALSYM sqlite3_total_changes}

procedure sqlite3_interrupt(DbConnection: sqlite3); cdecl;
{$EXTERNALSYM sqlite3_interrupt}

function sqlite3_complete(sql: MarshaledAString): Integer; cdecl;
{$EXTERNALSYM sqlite3_complete}
function sqlite3_complete16(sql: PChar): Integer; cdecl;
{$EXTERNALSYM sqlite3_complete16}

type
  TSqlite3BusyHandlerCallback = function(Ptr: Pointer; NumberOfInvocations: Integer): Integer; cdecl;

function sqlite3_busy_handler(DbConnection: sqlite3; Callback: TSqlite3BusyHandlerCallback;
                              Ptr: Pointer): Integer; cdecl;
{$EXTERNALSYM sqlite3_busy_handler}

function sqlite3_busy_timeout(DbConnection: sqlite3; ms: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_busy_timeout}

type
  PPPAnsiChar = ^PMarshaledAString;

function sqlite3_get_table(db: sqlite3; zSql: MarshaledAString; pazResult: PPPAnsiChar;
                           var pnRow, pnColumn: Integer; pzErrmsg: PMarshaledAString): Integer; cdecl;
{$EXTERNALSYM sqlite3_get_table}
procedure sqlite3_free_table(result: PMarshaledAString); cdecl;
{$EXTERNALSYM sqlite3_free_table}

function sqlite3_mprintf(Str: MarshaledAString): MarshaledAString; cdecl; varargs;
{$EXTERNALSYM sqlite3_mprintf}
function sqlite3_vmprintf(Str: MarshaledAString): MarshaledAString; cdecl; varargs;
{$EXTERNALSYM sqlite3_vmprintf}
function sqlite3_snprintf(Size: Integer; Str: MarshaledAString; Format: MarshaledAString): MarshaledAString; cdecl; varargs;
{$EXTERNALSYM sqlite3_snprintf}
function sqlite3_vsnprintf(Size: Integer; Str: MarshaledAString; Format: MarshaledAString): MarshaledAString; cdecl; varargs;
{$EXTERNALSYM sqlite3_vsnprintf}

function sqlite3_malloc(Size: Integer): Pointer; cdecl;
{$EXTERNALSYM sqlite3_malloc}
function sqlite3_realloc(Ptr: Pointer; Size: Integer): Pointer; cdecl;
{$EXTERNALSYM sqlite3_realloc}
procedure sqlite3_free(Ptr: Pointer); cdecl;
{$EXTERNALSYM sqlite3_free}

function sqlite3_memory_used: sqlite3_int64; cdecl;
{$EXTERNALSYM sqlite3_memory_used}
function sqlite3_memory_highwater(resetFlag: Integer): sqlite3_int64; cdecl;
{$EXTERNALSYM sqlite3_memory_highwater}

procedure sqlite3_randomness(N: Integer; P: Pointer); cdecl;
{$EXTERNALSYM sqlite3_randomness}

type
  TxAuth = function(UserData: Pointer; ActionCode: Integer; Str1, Str2, Str3, Str4: MarshaledAString): Integer; cdecl;

function sqlite3_set_authorizer(DbConnection: sqlite3; xAuth: TxAuth; UserData: Pointer): Integer; cdecl;
{$EXTERNALSYM sqlite3_set_authorizer}

const
  SQLITE_DENY = 1;   // Abort the SQL statement with an error
  {$EXTERNALSYM SQLITE_DENY}
  SQLITE_IGNORE = 2;   // Don't allow access, but don't generate an error
  {$EXTERNALSYM SQLITE_IGNORE}

  SQLITE_CREATE_INDEX = 1;   // Index Name      Table Name
  {$EXTERNALSYM SQLITE_CREATE_INDEX}
  SQLITE_CREATE_TABLE = 2;   // Table Name      NULL
  {$EXTERNALSYM SQLITE_CREATE_TABLE}
  SQLITE_CREATE_TEMP_INDEX = 3;   // Index Name      Table Name
  {$EXTERNALSYM SQLITE_CREATE_TEMP_INDEX}
  SQLITE_CREATE_TEMP_TABLE = 4;   // Table Name      NULL
  {$EXTERNALSYM SQLITE_CREATE_TEMP_TABLE}
  SQLITE_CREATE_TEMP_TRIGGER = 5;   // Trigger Name    Table Name
  {$EXTERNALSYM SQLITE_CREATE_TEMP_TRIGGER}
  SQLITE_CREATE_TEMP_VIEW = 6;   // View Name       NULL
  {$EXTERNALSYM SQLITE_CREATE_TEMP_VIEW}
  SQLITE_CREATE_TRIGGER = 7;   // Trigger Name    Table Name
  {$EXTERNALSYM SQLITE_CREATE_TRIGGER}
  SQLITE_CREATE_VIEW = 8;   // View Name       NULL
  {$EXTERNALSYM SQLITE_CREATE_VIEW}
  SQLITE_DELETE = 9;   // Table Name      NULL
  {$EXTERNALSYM SQLITE_DELETE}
  SQLITE_DROP_INDEX = 10;   // Index Name      Table Name
  {$EXTERNALSYM SQLITE_DROP_INDEX}
  SQLITE_DROP_TABLE = 11;   // Table Name      NULL
  {$EXTERNALSYM SQLITE_DROP_TABLE}
  SQLITE_DROP_TEMP_INDEX = 12;   // Index Name      Table Name
  {$EXTERNALSYM SQLITE_DROP_TEMP_INDEX}
  SQLITE_DROP_TEMP_TABLE = 13;   // Table Name      NULL
  {$EXTERNALSYM SQLITE_DROP_TEMP_TABLE}
  SQLITE_DROP_TEMP_TRIGGER = 14;   // Trigger Name    Table Name
  {$EXTERNALSYM SQLITE_DROP_TEMP_TRIGGER}
  SQLITE_DROP_TEMP_VIEW = 15;   // View Name       NULL
  {$EXTERNALSYM SQLITE_DROP_TEMP_VIEW}
  SQLITE_DROP_TRIGGER = 16;   // Trigger Name    Table Name
  {$EXTERNALSYM SQLITE_DROP_TRIGGER}
  SQLITE_DROP_VIEW = 17;   // View Name       NULL
  {$EXTERNALSYM SQLITE_DROP_VIEW}
  SQLITE_INSERT = 18;   // Table Name      NULL
  {$EXTERNALSYM SQLITE_INSERT}
  SQLITE_PRAGMA = 19;   // Pragma Name     1st arg or NULL
  {$EXTERNALSYM SQLITE_PRAGMA}
  SQLITE_READ = 20;   // Table Name      Column Name
  {$EXTERNALSYM SQLITE_READ}
  SQLITE_SELECT = 21;   // NULL            NULL
  {$EXTERNALSYM SQLITE_SELECT}
  SQLITE_TRANSACTION = 22;   // Operation       NULL
  {$EXTERNALSYM SQLITE_TRANSACTION}
  SQLITE_UPDATE = 23;   // Table Name      Column Name
  {$EXTERNALSYM SQLITE_UPDATE}
  SQLITE_ATTACH = 24;   // Filename        NULL
  {$EXTERNALSYM SQLITE_ATTACH}
  SQLITE_DETACH = 25;   // Database Name   NULL
  {$EXTERNALSYM SQLITE_DETACH}
  SQLITE_ALTER_TABLE = 26;   // Database Name   Table Name
  {$EXTERNALSYM SQLITE_ALTER_TABLE}
  SQLITE_REINDEX = 27;   // Index Name      NULL
  {$EXTERNALSYM SQLITE_REINDEX}
  SQLITE_ANALYZE = 28;   // Table Name      NULL
  {$EXTERNALSYM SQLITE_ANALYZE}
  SQLITE_CREATE_VTABLE = 29;   // Table Name      Module Name
  {$EXTERNALSYM SQLITE_CREATE_VTABLE}
  SQLITE_DROP_VTABLE = 30;   // Table Name      Module Name
  {$EXTERNALSYM SQLITE_DROP_VTABLE}
  SQLITE_FUNCTION = 31;   // NULL            Function Name
  {$EXTERNALSYM SQLITE_FUNCTION}
  SQLITE_SAVEPOINT = 32;   // Operation       Savepoint Name
  {$EXTERNALSYM SQLITE_SAVEPOINT}
  SQLITE_COPY = 0;   // No longer used
  {$EXTERNALSYM SQLITE_COPY}

type
  TxTrace = procedure(Ptr: Pointer; Text: MarshaledAString); cdecl;
  TxProfile = procedure(Ptr: Pointer; Text: MarshaledAString; Time: sqlite3_uint64); cdecl;

function sqlite3_trace(DbConnection: sqlite3; xTrace: TxTrace; Ptr: Pointer): Pointer; cdecl;
{$EXTERNALSYM sqlite3_trace}
function sqlite3_profile(DbConnection: sqlite3; xProfile: TxProfile; Ptr: Pointer): Pointer; cdecl;
{$EXTERNALSYM sqlite3_profile}

type
  TSqlite3ProgressHandlerCallback = function(P: Pointer): Integer; cdecl;

procedure sqlite3_progress_handler(DbConnection: sqlite3; N: Integer; Callback: TSqlite3ProgressHandlerCallback;
                                   P: Pointer); cdecl;
{$EXTERNALSYM sqlite3_progress_handler}

function sqlite3_open(filename: MarshaledAString; out ppDb: sqlite3): Integer; cdecl;
{$EXTERNALSYM sqlite3_open}
function sqlite3_open16(filename: PChar; out ppDb: sqlite3): Integer; cdecl;
{$EXTERNALSYM sqlite3_open16}
function sqlite3_open_v2(filename: MarshaledAString; out ppDb: sqlite3; flags: Integer; zVfs: MarshaledAString): Integer; cdecl;
{$EXTERNALSYM sqlite3_open_v2}

function sqlite3_uri_parameter(zFilename, zParam: MarshaledAString): MarshaledAString; cdecl;
{$EXTERNALSYM sqlite3_uri_parameter}

function sqlite3_errcode(db: sqlite3): Integer; cdecl;
{$EXTERNALSYM sqlite3_errcode}
function sqlite3_extended_errcode(db: sqlite3): Integer; cdecl;
{$EXTERNALSYM sqlite3_extended_errcode}
function sqlite3_errmsg(db: sqlite3): MarshaledAString; cdecl;
{$EXTERNALSYM sqlite3_errmsg}
function sqlite3_errmsg16(db: sqlite3): PChar; cdecl;
{$EXTERNALSYM sqlite3_errmsg16}

function sqlite3_limit(DbConnection: sqlite3; id: Integer; newVal: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_limit}

const
  SQLITE_LIMIT_LENGTH = 0;
  {$EXTERNALSYM SQLITE_LIMIT_LENGTH}
  SQLITE_LIMIT_SQL_LENGTH = 1;
  {$EXTERNALSYM SQLITE_LIMIT_SQL_LENGTH}
  SQLITE_LIMIT_COLUMN = 2;
  {$EXTERNALSYM SQLITE_LIMIT_COLUMN}
  SQLITE_LIMIT_EXPR_DEPTH = 3;
  {$EXTERNALSYM SQLITE_LIMIT_EXPR_DEPTH}
  SQLITE_LIMIT_COMPOUND_SELECT = 4;
  {$EXTERNALSYM SQLITE_LIMIT_COMPOUND_SELECT}
  SQLITE_LIMIT_VDBE_OP = 5;
  {$EXTERNALSYM SQLITE_LIMIT_VDBE_OP}
  SQLITE_LIMIT_FUNCTION_ARG = 6;
  {$EXTERNALSYM SQLITE_LIMIT_FUNCTION_ARG}
  SQLITE_LIMIT_ATTACHED = 7;
  {$EXTERNALSYM SQLITE_LIMIT_ATTACHED}
  SQLITE_LIMIT_LIKE_PATTERN_LENGTH = 8;
  {$EXTERNALSYM SQLITE_LIMIT_LIKE_PATTERN_LENGTH}
  SQLITE_LIMIT_VARIABLE_NUMBER = 9;
  {$EXTERNALSYM SQLITE_LIMIT_VARIABLE_NUMBER}
  SQLITE_LIMIT_TRIGGER_DEPTH = 10;
  {$EXTERNALSYM SQLITE_LIMIT_TRIGGER_DEPTH}

type
  sqlite3_stmt = Pointer;
  {$EXTERNALSYM sqlite3_stmt}

function sqlite3_prepare(db: sqlite3; zSql: MarshaledAString; nByte: Integer; out ppStmt: sqlite3_stmt;
                         out pzTail: MarshaledAString): Integer; cdecl;
{$EXTERNALSYM sqlite3_prepare}
function sqlite3_prepare_v2(db: sqlite3; zSql: MarshaledAString; nByte: Integer; out ppStmt: sqlite3_stmt;
                            out pzTail: MarshaledAString): Integer; cdecl;
{$EXTERNALSYM sqlite3_prepare_v2}
function sqlite3_prepare16(db: sqlite3; zSql: PChar; nByte: Integer; out ppStmt: sqlite3_stmt;
                           out pzTail: PChar): Integer; cdecl;
{$EXTERNALSYM sqlite3_prepare16}
function sqlite3_prepare16_v2(db: sqlite3; zSql: PChar; nByte: Integer; out ppStmt: sqlite3_stmt;
                              out pzTail: PChar): Integer; cdecl;
{$EXTERNALSYM sqlite3_prepare16_v2}

function sqlite3_sql(pStmt: sqlite3_stmt): MarshaledAString; cdecl;
{$EXTERNALSYM sqlite3_sql}

function sqlite3_stmt_readonly(pStmt: sqlite3_stmt): Integer; cdecl;
{$EXTERNALSYM sqlite3_stmt_readonly}

type
  sqlite3_value = Pointer;
  {$EXTERNALSYM sqlite3_value}
  PSqlite3_value = ^sqlite3_value;
  TBindDestructor = procedure(Ptr: Pointer); cdecl;

function sqlite3_bind_blob(Statement: sqlite3_stmt; Index: Integer; Value: Pointer;
                           n: Integer; Proc: TBindDestructor): Integer; cdecl;
{$EXTERNALSYM sqlite3_bind_blob}
function sqlite3_bind_double(Statement: sqlite3_stmt; Index: Integer; Value: Double): Integer; cdecl;
{$EXTERNALSYM sqlite3_bind_double}
function sqlite3_bind_int(Statement: sqlite3_stmt; Index: Integer; Value: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_bind_int}
function sqlite3_bind_int64(Statement: sqlite3_stmt; Index: Integer; Value: sqlite3_int64): Integer; cdecl;
{$EXTERNALSYM sqlite3_bind_int64}
function sqlite3_bind_null(Statement: sqlite3_stmt; Index: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_bind_null}
function sqlite3_bind_text(Statement: sqlite3_stmt; Index: Integer; Value: MarshaledAString;
                           n: Integer; Proc: TBindDestructor): Integer; cdecl;
{$EXTERNALSYM sqlite3_bind_text}
function sqlite3_bind_text16(Statement: sqlite3_stmt; Index: Integer; Value: PChar;
                             n: Integer; Proc: TBindDestructor): Integer; cdecl;
{$EXTERNALSYM sqlite3_bind_text16}
function sqlite3_bind_value(Statement: sqlite3_stmt; Index: Integer; Value: sqlite3_value): Integer; cdecl;
{$EXTERNALSYM sqlite3_bind_value}
function sqlite3_bind_zeroblob(Statement: sqlite3_stmt; Index, n: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_bind_zeroblob}

function sqlite3_bind_parameter_count(Statement: sqlite3_stmt): Integer; cdecl;
{$EXTERNALSYM sqlite3_bind_parameter_count}

function sqlite3_bind_parameter_name(Statement: sqlite3_stmt; ParamNum: Integer): MarshaledAString; cdecl;
{$EXTERNALSYM sqlite3_bind_parameter_name}

function sqlite3_bind_parameter_index(Statement: sqlite3_stmt; zName: MarshaledAString): Integer; cdecl;
{$EXTERNALSYM sqlite3_bind_parameter_index}

function sqlite3_clear_bindings(Statement: sqlite3_stmt): Integer; cdecl;
{$EXTERNALSYM sqlite3_clear_bindings}

function sqlite3_column_count(Statement: sqlite3_stmt): Integer; cdecl;
{$EXTERNALSYM sqlite3_column_count}

function sqlite3_column_name(Statement: sqlite3_stmt; N: Integer): MarshaledAString; cdecl;
{$EXTERNALSYM sqlite3_column_name}
function sqlite3_column_name16(Statement: sqlite3_stmt; N: Integer): PChar; cdecl;
{$EXTERNALSYM sqlite3_column_name16}

{$IFDEF MSWINDOWS}
function sqlite3_column_database_name(Statement: sqlite3_stmt; ColumnNum: Integer): MarshaledAString; cdecl;
{$EXTERNALSYM sqlite3_column_database_name}
function sqlite3_column_database_name16(Statement: sqlite3_stmt; ColumnNum: Integer): PChar; cdecl;
{$EXTERNALSYM sqlite3_column_database_name16}
function sqlite3_column_table_name(Statement: sqlite3_stmt; ColumnNum: Integer): MarshaledAString; cdecl;
{$EXTERNALSYM sqlite3_column_table_name}
function sqlite3_column_table_name16(Statement: sqlite3_stmt; ColumnNum: Integer): PChar; cdecl;
{$EXTERNALSYM sqlite3_column_table_name16}
function sqlite3_column_origin_name(Statement: sqlite3_stmt; ColumnNum: Integer): MarshaledAString; cdecl;
{$EXTERNALSYM sqlite3_column_origin_name}
function sqlite3_column_origin_name16(Statement: sqlite3_stmt; ColumnNum: Integer): PChar; cdecl;
{$EXTERNALSYM sqlite3_column_origin_name16}
{$ENDIF MSWINDOWS}

function sqlite3_column_decltype(Statement: sqlite3_stmt; ColumnNum: Integer): MarshaledAString; cdecl;
{$EXTERNALSYM sqlite3_column_decltype}
function sqlite3_column_decltype16(Statement: sqlite3_stmt; ColumnNum: Integer): PChar; cdecl;
{$EXTERNALSYM sqlite3_column_decltype16}

function sqlite3_step(Statement: sqlite3_stmt): Integer; cdecl;
{$EXTERNALSYM sqlite3_step}

function sqlite3_data_count(pStmt: sqlite3_stmt): Integer; cdecl;
{$EXTERNALSYM sqlite3_data_count}

const
  SQLITE_INTEGER = 1;
  {$EXTERNALSYM SQLITE_INTEGER}
  SQLITE_FLOAT = 2;
  {$EXTERNALSYM SQLITE_FLOAT}
  SQLITE_BLOB = 4;
  {$EXTERNALSYM SQLITE_BLOB}
  SQLITE_NULL = 5;
  {$EXTERNALSYM SQLITE_NULL}
  SQLITE_TEXT = 3;
  {$EXTERNALSYM SQLITE_TEXT}
  SQLITE3_TEXT = 3;
  {$EXTERNALSYM SQLITE3_TEXT}

function sqlite3_column_blob(Statement: sqlite3_stmt; iCol: Integer): Pointer; cdecl;
{$EXTERNALSYM sqlite3_column_blob}
function sqlite3_column_bytes(Statement: sqlite3_stmt; iCol: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_column_bytes}
function sqlite3_column_bytes16(Statement: sqlite3_stmt; iCol: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_column_bytes16}
function sqlite3_column_double(Statement: sqlite3_stmt; iCol: Integer): Double; cdecl;
{$EXTERNALSYM sqlite3_column_double}
function sqlite3_column_int(Statement: sqlite3_stmt; iCol: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_column_int}
function sqlite3_column_int64(Statement: sqlite3_stmt; iCol: Integer): sqlite3_int64; cdecl;
{$EXTERNALSYM sqlite3_column_int64}
function sqlite3_column_text(Statement: sqlite3_stmt; iCol: Integer): MarshaledAString; cdecl;
{$EXTERNALSYM sqlite3_column_text}
function sqlite3_column_text16(Statement: sqlite3_stmt; iCol: Integer): PChar; cdecl;
{$EXTERNALSYM sqlite3_column_text16}
function sqlite3_column_type(Statement: sqlite3_stmt; iCol: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_column_type}
function sqlite3_column_value(Statement: sqlite3_stmt; iCol: Integer): sqlite3_value; cdecl;
{$EXTERNALSYM sqlite3_column_value}

function sqlite3_finalize(pStmt: sqlite3_stmt): Integer; cdecl;
{$EXTERNALSYM sqlite3_finalize}

function sqlite3_reset(pStmt: sqlite3_stmt): Integer; cdecl;
{$EXTERNALSYM sqlite3_reset}

type
  sqlite3_context = Pointer;
  {$EXTERNALSYM sqlite3_context}
  PSqlite3_context = ^sqlite3_context;
  TxFunc = procedure(Context: sqlite3_context; Num: Integer; out Value: sqlite3_value); cdecl;
  TxStep = procedure(Context: sqlite3_context; Num: Integer; out Value: sqlite3_value); cdecl;
  TxFinal = procedure(Context: sqlite3_context); cdecl;
  TxDestroy = procedure(Ptr: Pointer); cdecl;

function sqlite3_create_function(db: sqlite3; zFunctionName: MarshaledAString; nArg, eTextRep: Integer;
                                 pApp: Pointer; xFunc: TxFunc; xStep: TxStep; xFinal: TxFinal): Integer; cdecl;
{$EXTERNALSYM sqlite3_create_function}
function sqlite3_create_function16(db: sqlite3; zFunctionName: PChar; nArg, eTextRep: Integer;
                                   pApp: Pointer; xFunc: TxFunc; xStep: TxStep; xFinal: TxFinal): Integer; cdecl;
{$EXTERNALSYM sqlite3_create_function16}
function sqlite3_create_function_v2(db: sqlite3; zFunctionName: MarshaledAString; nArg, eTextRep: Integer;
                                    pApp: Pointer; xFunc: TxFunc; xStep: TxStep; xFinal: TxFinal;
                                    xDestroy: TxDestroy): Integer; cdecl;
{$EXTERNALSYM sqlite3_create_function_v2}

const
  SQLITE_UTF8 = 1;
  {$EXTERNALSYM SQLITE_UTF8}
  SQLITE_UTF16LE = 2;
  {$EXTERNALSYM SQLITE_UTF16LE}
  SQLITE_UTF16BE = 3;
  {$EXTERNALSYM SQLITE_UTF16BE}
  SQLITE_UTF16 = 4;    // Use native byte order
  {$EXTERNALSYM SQLITE_UTF16}
  SQLITE_ANY = 5;    // sqlite3_create_function only
  {$EXTERNALSYM SQLITE_ANY}
  SQLITE_UTF16_ALIGNED = 8;    // sqlite3_create_collation only
  {$EXTERNALSYM SQLITE_UTF16_ALIGNED}

function sqlite3_value_blob(Value: sqlite3_value): Pointer; cdecl;
{$EXTERNALSYM sqlite3_value_blob}
function sqlite3_value_bytes(Value: sqlite3_value): Integer; cdecl;
{$EXTERNALSYM sqlite3_value_bytes}
function sqlite3_value_bytes16(Value: sqlite3_value): Integer; cdecl;
{$EXTERNALSYM sqlite3_value_bytes16}
function sqlite3_value_double(Value: sqlite3_value): Double; cdecl;
{$EXTERNALSYM sqlite3_value_double}
function sqlite3_value_int(Value: sqlite3_value): Integer; cdecl;
{$EXTERNALSYM sqlite3_value_int}
function sqlite3_value_int64(Value: sqlite3_value): sqlite3_int64; cdecl;
{$EXTERNALSYM sqlite3_value_int64}
function sqlite3_value_text(Value: sqlite3_value): MarshaledAString; cdecl;
{$EXTERNALSYM sqlite3_value_text}
function sqlite3_value_text16(Value: sqlite3_value): PChar; cdecl;
{$EXTERNALSYM sqlite3_value_text16}
function sqlite3_value_text16le(Value: sqlite3_value): PChar; cdecl;
{$EXTERNALSYM sqlite3_value_text16le}
function sqlite3_value_text16be(Value: sqlite3_value): PChar; cdecl;
{$EXTERNALSYM sqlite3_value_text16be}
function sqlite3_value_type(Value: sqlite3_value): Integer; cdecl;
{$EXTERNALSYM sqlite3_value_type}
function sqlite3_value_numeric_type(Value: sqlite3_value): Integer; cdecl;
{$EXTERNALSYM sqlite3_value_numeric_type}

function sqlite3_aggregate_context(Context: sqlite3_context; nBytes: Integer): Pointer; cdecl;
{$EXTERNALSYM sqlite3_aggregate_context}

function sqlite3_user_data(Context: sqlite3_context): Pointer; cdecl;
{$EXTERNALSYM sqlite3_user_data}

function sqlite3_context_db_handle(Context: sqlite3_context): sqlite3; cdecl;
{$EXTERNALSYM sqlite3_context_db_handle}

type
  TSetAuxDataProc = procedure(Ptr: Pointer); cdecl;

function sqlite3_get_auxdata(Context: sqlite3_context; N: Integer): Pointer; cdecl;
{$EXTERNALSYM sqlite3_get_auxdata}
procedure sqlite3_set_auxdata(Context: sqlite3_context; N: Integer; Metadata: Pointer; Proc: TSetAuxDataProc); cdecl;
{$EXTERNALSYM sqlite3_set_auxdata}

const
  SQLITE_STATIC = (0);
  {$EXTERNALSYM SQLITE_STATIC}
  SQLITE_TRANSIENT = (-1);
  {$EXTERNALSYM SQLITE_TRANSIENT}

type
  TResultDestructor = procedure(Ptr: Pointer); cdecl;

procedure sqlite3_result_blob(Context: sqlite3_context; Data: Pointer; Size: Integer; Proc: TResultDestructor); cdecl;
{$EXTERNALSYM sqlite3_result_blob}
procedure sqlite3_result_double(Context: sqlite3_context; Data: Double); cdecl;
{$EXTERNALSYM sqlite3_result_double}
procedure sqlite3_result_error(Context: sqlite3_context; ErrorString: MarshaledAString; Size: Integer); cdecl;
{$EXTERNALSYM sqlite3_result_error}
procedure sqlite3_result_error16(Context: sqlite3_context; ErrorString: PChar; Size: Integer); cdecl;
{$EXTERNALSYM sqlite3_result_error16}
procedure sqlite3_result_error_toobig(Context: sqlite3_context); cdecl;
{$EXTERNALSYM sqlite3_result_error_toobig}
procedure sqlite3_result_error_nomem(Context: sqlite3_context); cdecl;
{$EXTERNALSYM sqlite3_result_error_nomem}
procedure sqlite3_result_error_code(Context: sqlite3_context; Code: Integer); cdecl;
{$EXTERNALSYM sqlite3_result_error_code}
procedure sqlite3_result_int(Context: sqlite3_context; Data: Integer); cdecl;
{$EXTERNALSYM sqlite3_result_int}
procedure sqlite3_result_int64(Context: sqlite3_context; Data: sqlite3_int64); cdecl;
{$EXTERNALSYM sqlite3_result_int64}
procedure sqlite3_result_null(Context: sqlite3_context); cdecl;
{$EXTERNALSYM sqlite3_result_null}
procedure sqlite3_result_text(Context: sqlite3_context; Data: MarshaledAString; Size: Integer; Proc: TResultDestructor); cdecl;
{$EXTERNALSYM sqlite3_result_text}
procedure sqlite3_result_text16(Context: sqlite3_context; Data: PChar; Size: Integer; Proc: TResultDestructor); cdecl;
{$EXTERNALSYM sqlite3_result_text16}
procedure sqlite3_result_text16le(Context: sqlite3_context; Data: PChar; Size: Integer; Proc: TResultDestructor); cdecl;
{$EXTERNALSYM sqlite3_result_text16le}
procedure sqlite3_result_text16be(Context: sqlite3_context; Data: PChar; Size: Integer; Proc: TResultDestructor); cdecl;
{$EXTERNALSYM sqlite3_result_text16be}
procedure sqlite3_result_value(Context: sqlite3_context; Data: sqlite3_value); cdecl;
{$EXTERNALSYM sqlite3_result_value}
procedure sqlite3_result_zeroblob(Context: sqlite3_context; n: Integer); cdecl;
{$EXTERNALSYM sqlite3_result_zeroblob}

type
  TxCompare = function(pArg: Pointer; Size1: Integer; Str1: Pointer; Size2: Integer; Str2: Pointer): Integer; cdecl;

function sqlite3_create_collation(DbConnection: sqlite3; zName: MarshaledAString; eTextRep: Integer;
                                  pArg: Pointer; xCompare: TxCompare): Integer; cdecl;
{$EXTERNALSYM sqlite3_create_collation}
function sqlite3_create_collation_v2(DbConnection: sqlite3; zName: MarshaledAString; eTextRep: Integer;
                                     pArg: Pointer; xCompare: TxCompare; xDestroy: TxDestroy): Integer; cdecl;
{$EXTERNALSYM sqlite3_create_collation_v2}
function sqlite3_create_collation16(DbConnection: sqlite3; zName: PChar; eTextRep: Integer;
                                    pArg: Pointer; xCompare: TxCompare): Integer; cdecl;
{$EXTERNALSYM sqlite3_create_collation16}

type
  TCollationNeededCallback = procedure(Ptr: Pointer; DbConnection: sqlite3; eTextRep: Integer; SequenceName: MarshaledAString); cdecl;
  TCollationNeededCallback16 = procedure(Ptr: Pointer; DbConnection: sqlite3; eTextRep: Integer; SequenceName: PChar); cdecl;

function sqlite3_collation_needed(DbConnection: sqlite3; Ptr: Pointer; Proc: TCollationNeededCallback): Integer; cdecl;
{$EXTERNALSYM sqlite3_collation_needed}
function sqlite3_collation_needed16(DbConnection: sqlite3; Ptr: Pointer; Proc: TCollationNeededCallback16): Integer; cdecl;
{$EXTERNALSYM sqlite3_collation_needed16}

function sqlite3_sleep(ms: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_sleep}

function sqlite3_get_autocommit(DbConnection: sqlite3): Integer; cdecl;
{$EXTERNALSYM sqlite3_get_autocommit}

function sqlite3_db_handle(Statement: sqlite3_stmt): sqlite3; cdecl;
{$EXTERNALSYM sqlite3_db_handle}

function sqlite3_next_stmt(pDb: sqlite3; pStmt: sqlite3_stmt): sqlite3_stmt; cdecl;
{$EXTERNALSYM sqlite3_next_stmt}

type
  TCommitHook = function(Ptr: Pointer): Integer; cdecl;
  TRollbackHook = procedure(Ptr: Pointer); cdecl;
  TUpdateHook = procedure(Ptr: Pointer; Operation: Integer; DbName, TableName: MarshaledAString; RowId: sqlite3_int64); cdecl;

function sqlite3_commit_hook(DbConnection: sqlite3; Callback: TCommitHook; Ptr: Pointer): Pointer; cdecl;
{$EXTERNALSYM sqlite3_commit_hook}
function sqlite3_rollback_hook(DbConnection: sqlite3; Callback: TRollbackHook; Ptr: Pointer): Pointer; cdecl;
{$EXTERNALSYM sqlite3_rollback_hook}

function sqlite3_update_hook(DbConnection: sqlite3; Callback: TUpdateHook; Ptr: Pointer): Pointer; cdecl;
{$EXTERNALSYM sqlite3_update_hook}

function sqlite3_enable_shared_cache(Enable: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_enable_shared_cache}

function sqlite3_release_memory(Size: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_release_memory}

function sqlite3_soft_heap_limit64(N: sqlite3_int64): sqlite3_int64; cdecl;
{$EXTERNALSYM sqlite3_soft_heap_limit64}

{$IFDEF MSWINDOWS}
function sqlite3_table_column_metadata(db: sqlite3; zDbName, zTableName, zColumnName: MarshaledAString;
                                       out pzDataType, pzCollSeq: MarshaledAString; out pNotNull,
                                       pPrimaryKey, pAutoinc: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_table_column_metadata}
{$ENDIF MSWINDOWS}

function sqlite3_load_extension(db: sqlite3; zFile, zProc: MarshaledAString; pzErrMsg: PMarshaledAString): Integer; cdecl;
{$EXTERNALSYM sqlite3_load_extension}

function sqlite3_enable_load_extension(db: sqlite3; onoff: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_enable_load_extension}

type
  TxEntryPoint = function(db: sqlite3; pzErrMsg: PMarshaledAString; pThunk: Pointer): Integer; cdecl;

function sqlite3_auto_extension(xEntryPoint: TxEntryPoint): Integer; cdecl;
{$EXTERNALSYM sqlite3_auto_extension}

procedure sqlite3_reset_auto_extension; cdecl;
{$EXTERNALSYM sqlite3_reset_auto_extension}

type
  PSqlite3_module = Pointer;
  sqlite3_vtab = record
    pModule: PSqlite3_module;
    nRef: Integer;
    zErrMsg: MarshaledAString;
  end;
  {$EXTERNALSYM sqlite3_vtab}
  PSqlite3_vtab = ^sqlite3_vtab;
  {$EXTERNALSYM PSqlite3_vtab}
  PPSqlite3_vtab = ^PSqlite3_vtab;
  {$EXTERNALSYM PPSqlite3_vtab}

  sqlite3_index_info = record
    nConstraint: Integer;
    constraint_iColumn: Integer;
    op: Byte;
    usable: Byte;
    iTermOffset: Integer;
    nOrderBy: Integer;
    orderby_iColumn: Integer;
    desc: Byte;
    argvIndex: Integer;
    omit: Byte;
    idxNum: Integer;
    idxStr: MarshaledAString;
    needToFreeIdxStr: Integer;
    orderByConsumed: Integer;
    estimatedCost: Double;
  end;
  {$EXTERNALSYM sqlite3_index_info}
  PSqlite3_index_info = ^sqlite3_index_info;
  {$EXTERNALSYM PSqlite3_index_info}

  sqlite3_vtab_cursor = record
    pVtab: PSqlite3_vtab;
  end;
  {$EXTERNALSYM sqlite3_vtab_cursor}
  PSqlite3_vtab_cursor = ^sqlite3_vtab_cursor;
  {$EXTERNALSYM PSqlite3_vtab_cursor}
  PPSqlite3_vtab_cursor = ^PSqlite3_vtab_cursor;
  {$EXTERNALSYM PPSqlite3_vtab_cursor}

  TModulexFunc = procedure(Context: sqlite3_context; Num: Integer; var Value: sqlite3_value); cdecl;

  sqlite3_module = record
    iVersion: Integer;
    xCreate: function(DbConnection: sqlite3; pAux: Pointer; argc: Integer; argv: Pointer;
                      ppVTab: PPSqlite3_vtab; Str: PMarshaledAString): Integer; cdecl;
    xConnect: function(DbConnection: sqlite3; pAux: Pointer; argc: Integer; argv: Pointer;
                       ppVTab: PPSqlite3_vtab; Str: PMarshaledAString): Integer; cdecl;
    xBestIndex: function(pVTab: PSqlite3_vtab; IndexInfo: PSqlite3_index_info): Integer; cdecl;
    xDisconnect: function(pVTab: PSqlite3_vtab): Integer; cdecl;
    xDestroy: function(pVTab: PSqlite3_vtab): Integer; cdecl;
    xOpen: function(pVTab: PSqlite3_vtab; ppCursor: PPSqlite3_vtab_cursor): Integer; cdecl;
    xClose: function(Cursor: PSqlite3_vtab_cursor): Integer; cdecl;
    xFilter: function(Cursor: PSqlite3_vtab_cursor; idxNum: Integer; idxStr: MarshaledAString;
                      argc: Integer; argv: PSqlite3_value): Integer; cdecl;
    xNext: function(Cursor: PSqlite3_vtab_cursor): Integer; cdecl;
    xEof: function(Cursor: PSqlite3_vtab_cursor): Integer; cdecl;
    xColumn: function(Cursor: PSqlite3_vtab_cursor; Context: PSqlite3_context; Column: Integer): Integer; cdecl;
    xRowid: function(Cursor: PSqlite3_vtab_cursor; var pRowid: sqlite3_int64): Integer; cdecl;
    xUpdate: function(pVTab: PSqlite3_vtab; Num: Integer; Val: Pointer; var Num2: sqlite3_int64): Integer; cdecl;
    xBegin: function(pVTab: PSqlite3_vtab): Integer; cdecl;
    xSync: function(pVTab: PSqlite3_vtab): Integer; cdecl;
    xCommit: function(pVTab: PSqlite3_vtab): Integer; cdecl;
    xRollback: function(pVTab: PSqlite3_vtab): Integer; cdecl;
    xFindFunction: function(pVTab: PSqlite3_vtab; nArg: Integer; zName: MarshaledAString;
                            var xFunc: TModulexFunc; ppArg: Pointer): Integer; cdecl;
    xRename: function(pVtab: sqlite3_vtab; zNew: MarshaledAString): Integer; cdecl;
    xSavepoint: function(pVTab: PSqlite3_vtab; Value: Integer): Integer; cdecl;
    xRelease: function(pVTab: PSqlite3_vtab; Value: Integer): Integer; cdecl;
    xRollbackTo: function(pVTab: PSqlite3_vtab; Value: Integer): Integer; cdecl;
  end;
  {$EXTERNALSYM sqlite3_module}

const
  SQLITE_INDEX_CONSTRAINT_EQ = 2;
  {$EXTERNALSYM SQLITE_INDEX_CONSTRAINT_EQ}
  SQLITE_INDEX_CONSTRAINT_GT = 4;
  {$EXTERNALSYM SQLITE_INDEX_CONSTRAINT_GT}
  SQLITE_INDEX_CONSTRAINT_LE = 8;
  {$EXTERNALSYM SQLITE_INDEX_CONSTRAINT_LE}
  SQLITE_INDEX_CONSTRAINT_LT = 16;
  {$EXTERNALSYM SQLITE_INDEX_CONSTRAINT_LT}
  SQLITE_INDEX_CONSTRAINT_GE = 32;
  {$EXTERNALSYM SQLITE_INDEX_CONSTRAINT_GE}
  SQLITE_INDEX_CONSTRAINT_MATCH = 64;
  {$EXTERNALSYM SQLITE_INDEX_CONSTRAINT_MATCH}

function sqlite3_create_module(db: sqlite3; zName: MarshaledAString; p: PSqlite3_module; pClientData: Pointer): Integer; cdecl;
{$EXTERNALSYM sqlite3_create_module}
function sqlite3_create_module_v2(db: sqlite3; zName: MarshaledAString; p: PSqlite3_module;
                                  pClientData: Pointer; Proc: TxDestroy): Integer; cdecl;
{$EXTERNALSYM sqlite3_create_module_v2}

function sqlite3_declare_vtab(DbConnection: sqlite3; zSQL: MarshaledAString): Integer; cdecl;
{$EXTERNALSYM sqlite3_declare_vtab}

function sqlite3_overload_function(DbConnection: sqlite3; zFuncName: MarshaledAString; nArg: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_overload_function}

function sqlite3_blob_open(DbConnection: sqlite3; zDb, zTable, zColumn: MarshaledAString;
                           iRow: sqlite3_int64; flags: Integer; ppBlob: Pointer): Integer; cdecl;
{$EXTERNALSYM sqlite3_blob_open}

function sqlite3_blob_reopen(Blob: Pointer; Rowid: sqlite3_int64): Integer; cdecl;
{$EXTERNALSYM sqlite3_blob_reopen}

function sqlite3_blob_close(Blob: Pointer): Integer; cdecl;
{$EXTERNALSYM sqlite3_blob_close}

function sqlite3_blob_bytes(Blob: Pointer): Integer; cdecl;
{$EXTERNALSYM sqlite3_blob_bytes}

function sqlite3_blob_read(Blob, Z: Pointer; N, iOffset: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_blob_bytes}

function sqlite3_blob_write(Blob, z: Pointer; n, iOffset: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_blob_write}

function sqlite3_vfs_find(zVfsName: MarshaledAString): PSqlite3_vfs; cdecl;
{$EXTERNALSYM sqlite3_vfs_find}
function sqlite3_vfs_register(Vfs: PSqlite3_vfs; makeDflt: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_vfs_register}
function sqlite3_vfs_unregister(Vfs: PSqlite3_vfs): Integer; cdecl;
{$EXTERNALSYM sqlite3_vfs_unregister}

function sqlite3_mutex_alloc(Value: Integer): Pointer; cdecl;
{$EXTERNALSYM sqlite3_mutex_alloc}
procedure sqlite3_mutex_free(Mutex: Pointer); cdecl;
{$EXTERNALSYM sqlite3_mutex_free}
procedure sqlite3_mutex_enter(Mutex: Pointer); cdecl;
{$EXTERNALSYM sqlite3_mutex_enter}
function sqlite3_mutex_try(Mutex: Pointer): Integer; cdecl;
{$EXTERNALSYM sqlite3_mutex_try}
procedure sqlite3_mutex_leave(Mutex: Pointer); cdecl;
{$EXTERNALSYM sqlite3_mutex_leave}

type
  sqlite3_mutex_methods = record
    xMutexInit: function: Integer; cdecl;
    xMutexEnd: function: Integer; cdecl;
    xMutexAlloc: function(Value: Integer): Pointer; cdecl;
    xMutexFree: procedure(Mutex: Pointer); cdecl;
    xMutexTry: function(Mutex: Pointer): Integer; cdecl;
    xMutexLeave: procedure(Mutex: Pointer); cdecl;
    xMutexHeld: function(Mutex: Pointer): Integer; cdecl;
    xMutexNotheld: function(Mutex: Pointer): Integer; cdecl;
  end;
  {$EXTERNALSYM sqlite3_mutex_leave}

function sqlite3_mutex_held(Mutex: Pointer): Integer; cdecl;
{$EXTERNALSYM sqlite3_mutex_held}
function sqlite3_mutex_notheld(Mutex: Pointer): Integer; cdecl;
{$EXTERNALSYM sqlite3_mutex_notheld}

const
  SQLITE_MUTEX_FAST = 0;
  {$EXTERNALSYM SQLITE_MUTEX_FAST}
  SQLITE_MUTEX_RECURSIVE = 1;
  {$EXTERNALSYM SQLITE_MUTEX_RECURSIVE}
  SQLITE_MUTEX_STATIC_MASTER = 2;
  {$EXTERNALSYM SQLITE_MUTEX_STATIC_MASTER}
  SQLITE_MUTEX_STATIC_MEM = 3;  // sqlite3_malloc()
  {$EXTERNALSYM SQLITE_MUTEX_STATIC_MEM}
  SQLITE_MUTEX_STATIC_MEM2 = 4;  // NOT USED
  {$EXTERNALSYM SQLITE_MUTEX_STATIC_MEM2}
  SQLITE_MUTEX_STATIC_OPEN = 4;  // sqlite3BtreeOpen()
  {$EXTERNALSYM SQLITE_MUTEX_STATIC_OPEN}
  SQLITE_MUTEX_STATIC_PRNG = 5;  // sqlite3_random()
  {$EXTERNALSYM SQLITE_MUTEX_STATIC_PRNG}
  SQLITE_MUTEX_STATIC_LRU = 6;  // lru page list
  {$EXTERNALSYM SQLITE_MUTEX_STATIC_LRU}
  SQLITE_MUTEX_STATIC_LRU2 = 7;  // NOT USED
  {$EXTERNALSYM SQLITE_MUTEX_STATIC_LRU2}
  SQLITE_MUTEX_STATIC_PMEM = 7;  // sqlite3PageMalloc()
  {$EXTERNALSYM SQLITE_MUTEX_STATIC_PMEM}

function sqlite3_db_mutex(DbConnection: sqlite3): Pointer; cdecl;
{$EXTERNALSYM sqlite3_db_mutex}

function sqlite3_file_control(DbConnection: sqlite3; zDbName: MarshaledAString; op: Integer; Ptr: Pointer): Integer; cdecl;
{$EXTERNALSYM sqlite3_file_control}

function sqlite3_test_control(op: Integer): Integer; cdecl; varargs;
{$EXTERNALSYM sqlite3_test_control}

const
  SQLITE_TESTCTRL_FIRST = 5;
  {$EXTERNALSYM SQLITE_TESTCTRL_FIRST}
  SQLITE_TESTCTRL_PRNG_SAVE = 5;
  {$EXTERNALSYM SQLITE_TESTCTRL_PRNG_SAVE}
  SQLITE_TESTCTRL_PRNG_RESTORE = 6;
  {$EXTERNALSYM SQLITE_TESTCTRL_PRNG_RESTORE}
  SQLITE_TESTCTRL_PRNG_RESET = 7;
  {$EXTERNALSYM SQLITE_TESTCTRL_PRNG_RESET}
  SQLITE_TESTCTRL_BITVEC_TEST = 8;
  {$EXTERNALSYM SQLITE_TESTCTRL_BITVEC_TEST}
  SQLITE_TESTCTRL_FAULT_INSTALL = 9;
  {$EXTERNALSYM SQLITE_TESTCTRL_FAULT_INSTALL}
  SQLITE_TESTCTRL_BENIGN_MALLOC_HOOKS = 10;
  {$EXTERNALSYM SQLITE_TESTCTRL_BENIGN_MALLOC_HOOKS}
  SQLITE_TESTCTRL_PENDING_BYTE = 11;
  {$EXTERNALSYM SQLITE_TESTCTRL_PENDING_BYTE}
  SQLITE_TESTCTRL_ASSERT = 12;
  {$EXTERNALSYM SQLITE_TESTCTRL_ASSERT}
  SQLITE_TESTCTRL_ALWAYS = 13;
  {$EXTERNALSYM SQLITE_TESTCTRL_ALWAYS}
  SQLITE_TESTCTRL_RESERVE = 14;
  {$EXTERNALSYM SQLITE_TESTCTRL_RESERVE}
  SQLITE_TESTCTRL_OPTIMIZATIONS = 15;
  {$EXTERNALSYM SQLITE_TESTCTRL_OPTIMIZATIONS}
  SQLITE_TESTCTRL_ISKEYWORD = 16;
  {$EXTERNALSYM SQLITE_TESTCTRL_ISKEYWORD}
  SQLITE_TESTCTRL_PGHDRSZ = 17;
  {$EXTERNALSYM SQLITE_TESTCTRL_PGHDRSZ}
  SQLITE_TESTCTRL_SCRATCHMALLOC = 18;
  {$EXTERNALSYM SQLITE_TESTCTRL_SCRATCHMALLOC}
  SQLITE_TESTCTRL_LOCALTIME_FAULT = 19;
  {$EXTERNALSYM SQLITE_TESTCTRL_LOCALTIME_FAULT}
  SQLITE_TESTCTRL_LAST = 19;
  {$EXTERNALSYM SQLITE_TESTCTRL_LAST}

function sqlite3_status(op: Integer; var pCurrent, pHighwater: Integer; resetFlag: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_status}

const
  SQLITE_STATUS_MEMORY_USED = 0;
  {$EXTERNALSYM SQLITE_STATUS_MEMORY_USED}
  SQLITE_STATUS_PAGECACHE_USED = 1;
  {$EXTERNALSYM SQLITE_STATUS_PAGECACHE_USED}
  SQLITE_STATUS_PAGECACHE_OVERFLOW = 2;
  {$EXTERNALSYM SQLITE_STATUS_PAGECACHE_OVERFLOW}
  SQLITE_STATUS_SCRATCH_USED = 3;
  {$EXTERNALSYM SQLITE_STATUS_SCRATCH_USED}
  SQLITE_STATUS_SCRATCH_OVERFLOW = 4;
  {$EXTERNALSYM SQLITE_STATUS_SCRATCH_OVERFLOW}
  SQLITE_STATUS_MALLOC_SIZE = 5;
  {$EXTERNALSYM SQLITE_STATUS_MALLOC_SIZE}
  SQLITE_STATUS_PARSER_STACK = 6;
  {$EXTERNALSYM SQLITE_STATUS_PARSER_STACK}
  SQLITE_STATUS_PAGECACHE_SIZE = 7;
  {$EXTERNALSYM SQLITE_STATUS_PARSER_STACK}
  SQLITE_STATUS_SCRATCH_SIZE = 8;
  {$EXTERNALSYM SQLITE_STATUS_SCRATCH_SIZE}
  SQLITE_STATUS_MALLOC_COUNT = 9;
  {$EXTERNALSYM SQLITE_STATUS_MALLOC_COUNT}

function sqlite3_db_status(DbConnection: sqlite3; op: Integer; var pCur, pHiwtr: Integer; resetFlg: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_db_status}

const
  SQLITE_DBSTATUS_LOOKASIDE_USED = 0;
  {$EXTERNALSYM SQLITE_DBSTATUS_LOOKASIDE_USED}
  SQLITE_DBSTATUS_CACHE_USED = 1;
  {$EXTERNALSYM SQLITE_DBSTATUS_CACHE_USED}
  SQLITE_DBSTATUS_SCHEMA_USED = 2;
  {$EXTERNALSYM SQLITE_DBSTATUS_SCHEMA_USED}
  SQLITE_DBSTATUS_STMT_USED = 3;
  {$EXTERNALSYM SQLITE_DBSTATUS_STMT_USED}
  SQLITE_DBSTATUS_LOOKASIDE_HIT = 4;
  {$EXTERNALSYM SQLITE_DBSTATUS_LOOKASIDE_HIT}
  SQLITE_DBSTATUS_LOOKASIDE_MISS_SIZE = 5;
  {$EXTERNALSYM SQLITE_DBSTATUS_LOOKASIDE_MISS_SIZE}
  SQLITE_DBSTATUS_LOOKASIDE_MISS_FULL = 6;
  {$EXTERNALSYM SQLITE_DBSTATUS_LOOKASIDE_MISS_FULL}
  SQLITE_DBSTATUS_MAX = 6;   // Largest defined DBSTATUS
  {$EXTERNALSYM SQLITE_DBSTATUS_MAX}

function sqlite3_stmt_status(Statement: sqlite3_stmt; op, resetFlg: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_stmt_status}

const
  SQLITE_STMTSTATUS_FULLSCAN_STEP = 1;
  {$EXTERNALSYM SQLITE_STMTSTATUS_FULLSCAN_STEP}
  SQLITE_STMTSTATUS_SORT = 2;
  {$EXTERNALSYM SQLITE_STMTSTATUS_SORT}
  SQLITE_STMTSTATUS_AUTOINDEX = 3;
  {$EXTERNALSYM SQLITE_STMTSTATUS_AUTOINDEX}

type
  sqlite3_pcache_methods = record
    pArg: Pointer;
    xInit: function(Ptr: Pointer): Integer; cdecl;
    xShutdown: procedure(Ptr: Pointer); cdecl;
    xCreate: function(szPage, bPurgeable: Integer): Pointer; cdecl;
    xCachesize: procedure(Cache: Pointer; nCacheSize: Integer); cdecl;
    xPagecount: function(Cache: Pointer): Integer; cdecl;
    xFetch: function(Cache: Pointer; key: LongInt; createFlag: Integer): Pointer; cdecl;
    xUnpin: procedure(Cache: Pointer; Ptr: Pointer; discard: Integer); cdecl;
    xRekey: procedure(Cache: Pointer; Ptr: Pointer; oldKey, newKey: LongInt); cdecl;
    xTruncate: procedure(Cache: Pointer; iLimit: LongInt); cdecl;
    xDestroy: procedure(Cache: Pointer); cdecl;
  end;
  {$EXTERNALSYM sqlite3_pcache_methods}

function sqlite3_backup_init(pDest: sqlite3; zDestName: MarshaledAString; pSource: sqlite3; zSourceName: MarshaledAString): Pointer; cdecl;
{$EXTERNALSYM sqlite3_backup_init}
function sqlite3_backup_step(p: Pointer; nPage: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_backup_step}
function sqlite3_backup_finish(p: Pointer): Integer; cdecl;
{$EXTERNALSYM sqlite3_backup_finish}
function sqlite3_backup_remaining(p: Pointer): Integer; cdecl;
{$EXTERNALSYM sqlite3_backup_remaining}
function sqlite3_backup_pagecount(p: Pointer): Integer; cdecl;
{$EXTERNALSYM sqlite3_backup_pagecount}

type
  TUnlockxNotify = procedure(apArg: Pointer; nArg: Integer); cdecl;

function sqlite3_unlock_notify(pBlocked: sqlite3; Callback: TUnlockxNotify; pNotifyArg: Pointer): Integer; cdecl;
{$EXTERNALSYM sqlite3_unlock_notify}

function sqlite3_strnicmp(Str1: MarshaledAString; Str2: MarshaledAString; MaxLen: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_strnicmp}

procedure sqlite3_log(iErrCode: Integer; zFormat: MarshaledAString); cdecl; varargs;
{$EXTERNALSYM sqlite3_log}

type
  TWalHookCallback = function(Ptr: Pointer; DbConnection: sqlite3; DbName: MarshaledAString; NumPages: Integer): Integer; cdecl;

function sqlite3_wal_hook(DbConnection: sqlite3; Callback: TWalHookCallback; Ptr: Pointer): Pointer; cdecl;
{$EXTERNALSYM sqlite3_wal_hook}

function sqlite3_wal_autocheckpoint(db: sqlite3; N: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_wal_autocheckpoint}

function sqlite3_wal_checkpoint(db: sqlite3; zDb: MarshaledAString): Integer; cdecl;
{$EXTERNALSYM sqlite3_wal_checkpoint}

function sqlite3_wal_checkpoint_v2(db: sqlite3; zDb: MarshaledAString; eMode: Integer;
                                   out pnLog, pnCkpt: Integer): Integer; cdecl;
{$EXTERNALSYM sqlite3_wal_checkpoint_v2}

const
  SQLITE_CHECKPOINT_PASSIVE = 0;
  {$EXTERNALSYM SQLITE_CHECKPOINT_PASSIVE}
  SQLITE_CHECKPOINT_FULL = 1;
  {$EXTERNALSYM SQLITE_CHECKPOINT_FULL}
  SQLITE_CHECKPOINT_RESTART = 2;
  {$EXTERNALSYM SQLITE_CHECKPOINT_RESTART}

function sqlite3_vtab_config(DbConnection: sqlite3; op: Integer): Integer; cdecl; varargs;
{$EXTERNALSYM sqlite3_vtab_config}

const
  SQLITE_VTAB_CONSTRAINT_SUPPORT = 1;
  {$EXTERNALSYM SQLITE_VTAB_CONSTRAINT_SUPPORT}

function sqlite3_vtab_on_conflict(DbConnection: sqlite3): Integer; cdecl;
{$EXTERNALSYM sqlite3_vtab_on_conflict}

const
  SQLITE_ROLLBACK = 1;
  {$EXTERNALSYM SQLITE_ROLLBACK}
  SQLITE_FAIL = 3;
  {$EXTERNALSYM SQLITE_FAIL}
  SQLITE_REPLACE = 5;
  {$EXTERNALSYM SQLITE_REPLACE}

type
  TRTreexGeom = function(Geometry: Pointer; nCoord: Integer; var aCoord: double; var pRes: Integer): Integer; cdecl;

function sqlite3_rtree_geometry_callback(db: sqlite3; zGeom: MarshaledAString; Callback: TRTreexGeom; pContext: Pointer): Integer; cdecl;
{$EXTERNALSYM sqlite3_rtree_geometry_callback}

type
  sqlite3_rtree_geometry = record
    pContext: Pointer;
    nParam: Integer;
    aParam: PDouble;
    pUser: Pointer;
    xDelUser: procedure(Ptr: Pointer); cdecl;
  end;
  {$EXTERNALSYM sqlite3_rtree_geometry}

implementation

{$WARN SYMBOL_PLATFORM OFF}

function sqlite3_libversion; external sqlite3dll name _PU + 'sqlite3_libversion' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_sourceid; external sqlite3dll name _PU + 'sqlite3_sourceid' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_libversion_number; external sqlite3dll name _PU + 'sqlite3_libversion_number' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_compileoption_used; external sqlite3dll name _PU + 'sqlite3_compileoption_used' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_compileoption_get; external sqlite3dll name _PU + 'sqlite3_compileoption_get' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_threadsafe; external sqlite3dll name _PU + 'sqlite3_threadsafe' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_close; external sqlite3dll name _PU + 'sqlite3_close' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_exec; external sqlite3dll name _PU + 'sqlite3_exec' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_initialize; external sqlite3dll name _PU + 'sqlite3_initialize' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_shutdown; external sqlite3dll name _PU + 'sqlite3_shutdown' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_os_init; external sqlite3dll name _PU + 'sqlite3_os_init' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_os_end; external sqlite3dll name _PU + 'sqlite3_os_end' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_config; external sqlite3dll name _PU + 'sqlite3_config' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_db_config; external sqlite3dll name _PU + 'sqlite3_db_config' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_extended_result_codes; external sqlite3dll name _PU + 'sqlite3_extended_result_codes' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_last_insert_rowid; external sqlite3dll name _PU + 'sqlite3_last_insert_rowid' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_changes; external sqlite3dll name _PU + 'sqlite3_changes' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_total_changes; external sqlite3dll name _PU + 'sqlite3_total_changes' {$IFNDEF POSIX}delayed{$ENDIF};

procedure sqlite3_interrupt; external sqlite3dll name _PU + 'sqlite3_interrupt' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_complete; external sqlite3dll name _PU + 'sqlite3_complete' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_complete16; external sqlite3dll name _PU + 'sqlite3_complete16' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_busy_handler; external sqlite3dll name _PU + 'sqlite3_busy_handler' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_busy_timeout; external sqlite3dll name _PU + 'sqlite3_busy_timeout' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_get_table; external sqlite3dll name _PU + 'sqlite3_get_table' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_free_table; external sqlite3dll name _PU + 'sqlite3_free_table' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_mprintf; external sqlite3dll name _PU + 'sqlite3_mprintf' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_vmprintf; external sqlite3dll name _PU + 'sqlite3_vmprintf' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_snprintf; external sqlite3dll name _PU + 'sqlite3_snprintf' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_vsnprintf; external sqlite3dll name _PU + 'sqlite3_vsnprintf' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_malloc; external sqlite3dll name _PU + 'sqlite3_malloc' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_realloc; external sqlite3dll name _PU + 'sqlite3_realloc' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_free; external sqlite3dll name _PU + 'sqlite3_free' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_memory_used; external sqlite3dll name _PU + 'sqlite3_memory_used' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_memory_highwater; external sqlite3dll name _PU + 'sqlite3_memory_highwater' {$IFNDEF POSIX}delayed{$ENDIF};

procedure sqlite3_randomness; external sqlite3dll name _PU + 'sqlite3_randomness' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_set_authorizer; external sqlite3dll name _PU + 'sqlite3_set_authorizer' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_trace; external sqlite3dll name _PU + 'sqlite3_trace' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_profile; external sqlite3dll name _PU + 'sqlite3_profile' {$IFNDEF POSIX}delayed{$ENDIF};

procedure sqlite3_progress_handler; external sqlite3dll name _PU + 'sqlite3_progress_handler' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_open; external sqlite3dll name _PU + 'sqlite3_open' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_open16; external sqlite3dll name _PU + 'sqlite3_open16' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_open_v2; external sqlite3dll name _PU + 'sqlite3_open_v2' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_uri_parameter; external sqlite3dll name _PU + 'sqlite3_uri_parameter' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_errcode; external sqlite3dll name _PU + 'sqlite3_errcode' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_extended_errcode; external sqlite3dll name _PU + 'sqlite3_extended_errcode' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_errmsg; external sqlite3dll name _PU + 'sqlite3_errmsg' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_errmsg16; external sqlite3dll name _PU + 'sqlite3_errmsg16' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_limit; external sqlite3dll name _PU + 'sqlite3_limit' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_prepare; external sqlite3dll name _PU + 'sqlite3_prepare' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_prepare_v2; external sqlite3dll name _PU + 'sqlite3_prepare_v2' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_prepare16; external sqlite3dll name _PU + 'sqlite3_prepare16' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_prepare16_v2; external sqlite3dll name _PU + 'sqlite3_prepare16_v2' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_sql; external sqlite3dll name _PU + 'sqlite3_sql' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_stmt_readonly; external sqlite3dll name _PU + 'sqlite3_stmt_readonly' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_bind_blob; external sqlite3dll name _PU + 'sqlite3_bind_blob' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_bind_double; external sqlite3dll name _PU + 'sqlite3_bind_double' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_bind_int; external sqlite3dll name _PU + 'sqlite3_bind_int' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_bind_int64; external sqlite3dll name _PU + 'sqlite3_bind_int64' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_bind_null; external sqlite3dll name _PU + 'sqlite3_bind_null' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_bind_text; external sqlite3dll name _PU + 'sqlite3_bind_text' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_bind_text16; external sqlite3dll name _PU + 'sqlite3_bind_text16' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_bind_value; external sqlite3dll name _PU + 'sqlite3_bind_value' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_bind_zeroblob; external sqlite3dll name _PU + 'sqlite3_bind_zeroblob' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_bind_parameter_count; external sqlite3dll name _PU + 'sqlite3_bind_parameter_count' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_bind_parameter_name; external sqlite3dll name _PU + 'sqlite3_bind_parameter_name' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_bind_parameter_index; external sqlite3dll name _PU + 'sqlite3_bind_parameter_index' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_clear_bindings; external sqlite3dll name _PU + 'sqlite3_clear_bindings' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_column_count; external sqlite3dll name _PU + 'sqlite3_column_count' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_column_name; external sqlite3dll name _PU + 'sqlite3_column_name' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_column_name16; external sqlite3dll name _PU + 'sqlite3_column_name16' {$IFNDEF POSIX}delayed{$ENDIF};

{$IFDEF MSWINDOWS}
function sqlite3_column_database_name; external sqlite3dll name _PU + 'sqlite3_column_database_name' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_column_database_name16; external sqlite3dll name _PU + 'sqlite3_column_database_name16' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_column_table_name; external sqlite3dll name _PU + 'sqlite3_column_table_name' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_column_table_name16; external sqlite3dll name _PU + 'sqlite3_column_table_name16' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_column_origin_name; external sqlite3dll name _PU + 'sqlite3_column_origin_name' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_column_origin_name16; external sqlite3dll name _PU + 'sqlite3_column_origin_name16' {$IFNDEF POSIX}delayed{$ENDIF};
{$ENDIF MSWINDOWS}

function sqlite3_column_decltype; external sqlite3dll name _PU + 'sqlite3_column_decltype' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_column_decltype16; external sqlite3dll name _PU + 'sqlite3_column_decltype16' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_step; external sqlite3dll name _PU + 'sqlite3_step' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_data_count; external sqlite3dll name _PU + 'sqlite3_data_count' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_column_blob; external sqlite3dll name _PU + 'sqlite3_column_blob' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_column_bytes; external sqlite3dll name _PU + 'sqlite3_column_bytes' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_column_bytes16; external sqlite3dll name _PU + 'sqlite3_column_bytes16' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_column_double; external sqlite3dll name _PU + 'sqlite3_column_double' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_column_int; external sqlite3dll name _PU + 'sqlite3_column_int' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_column_int64; external sqlite3dll name _PU + 'sqlite3_column_int64' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_column_text; external sqlite3dll name _PU + 'sqlite3_column_text' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_column_text16; external sqlite3dll name _PU + 'sqlite3_column_text16' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_column_type; external sqlite3dll name _PU + 'sqlite3_column_type' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_column_value; external sqlite3dll name _PU + 'sqlite3_column_value' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_finalize; external sqlite3dll name _PU + 'sqlite3_finalize' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_reset; external sqlite3dll name _PU + 'sqlite3_reset' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_create_function; external sqlite3dll name _PU + 'sqlite3_create_function' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_create_function16; external sqlite3dll name _PU + 'sqlite3_create_function16' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_create_function_v2; external sqlite3dll name _PU + 'sqlite3_create_function_v2' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_value_blob; external sqlite3dll name _PU + 'sqlite3_value_blob' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_value_bytes; external sqlite3dll name _PU + 'sqlite3_value_bytes' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_value_bytes16; external sqlite3dll name _PU + 'sqlite3_value_bytes16' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_value_double; external sqlite3dll name _PU + 'sqlite3_value_double' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_value_int; external sqlite3dll name _PU + 'sqlite3_value_int' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_value_int64; external sqlite3dll name _PU + 'sqlite3_value_int64' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_value_text; external sqlite3dll name _PU + 'sqlite3_value_text' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_value_text16; external sqlite3dll name _PU + 'sqlite3_value_text16' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_value_text16le; external sqlite3dll name _PU + 'sqlite3_value_text16le' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_value_text16be; external sqlite3dll name _PU + 'sqlite3_value_text16be' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_value_type; external sqlite3dll name _PU + 'sqlite3_value_type' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_value_numeric_type; external sqlite3dll name _PU + 'sqlite3_value_numeric_type' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_aggregate_context; external sqlite3dll name _PU + 'sqlite3_aggregate_context' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_user_data; external sqlite3dll name _PU + 'sqlite3_user_data' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_context_db_handle; external sqlite3dll name _PU + 'sqlite3_context_db_handle' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_get_auxdata; external sqlite3dll name _PU + 'sqlite3_get_auxdata' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_set_auxdata; external sqlite3dll name _PU + 'sqlite3_set_auxdata' {$IFNDEF POSIX}delayed{$ENDIF};

procedure sqlite3_result_blob; external sqlite3dll name _PU + 'sqlite3_result_blob' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_result_double; external sqlite3dll name _PU + 'sqlite3_result_double' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_result_error; external sqlite3dll name _PU + 'sqlite3_result_error' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_result_error16; external sqlite3dll name _PU + 'sqlite3_result_error16' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_result_error_toobig; external sqlite3dll name _PU + 'sqlite3_result_error_toobig' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_result_error_nomem; external sqlite3dll name _PU + 'sqlite3_result_error_nomem' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_result_error_code; external sqlite3dll name _PU + 'sqlite3_result_error_code' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_result_int; external sqlite3dll name _PU + 'sqlite3_result_int' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_result_int64; external sqlite3dll name _PU + 'sqlite3_result_int64' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_result_null; external sqlite3dll name _PU + 'sqlite3_result_null' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_result_text; external sqlite3dll name _PU + 'sqlite3_result_text' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_result_text16; external sqlite3dll name _PU + 'sqlite3_result_text16' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_result_text16le; external sqlite3dll name _PU + 'sqlite3_result_text16le' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_result_text16be; external sqlite3dll name _PU + 'sqlite3_result_text16be' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_result_value; external sqlite3dll name _PU + 'sqlite3_result_value' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_result_zeroblob; external sqlite3dll name _PU + 'sqlite3_result_zeroblob' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_create_collation; external sqlite3dll name _PU + 'sqlite3_create_collation' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_create_collation_v2; external sqlite3dll name _PU + 'sqlite3_create_collation_v2' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_create_collation16; external sqlite3dll name _PU + 'sqlite3_create_collation16' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_collation_needed; external sqlite3dll name _PU + 'sqlite3_collation_needed' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_collation_needed16; external sqlite3dll name _PU + 'sqlite3_collation_needed16' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_sleep; external sqlite3dll name _PU + 'sqlite3_sleep' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_get_autocommit; external sqlite3dll name _PU + 'sqlite3_get_autocommit' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_db_handle; external sqlite3dll name _PU + 'sqlite3_db_handle' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_next_stmt; external sqlite3dll name _PU + 'sqlite3_next_stmt' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_commit_hook; external sqlite3dll name _PU + 'sqlite3_commit_hook' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_rollback_hook; external sqlite3dll name _PU + 'sqlite3_rollback_hook' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_update_hook; external sqlite3dll name _PU + 'sqlite3_update_hook' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_enable_shared_cache; external sqlite3dll name _PU + 'sqlite3_enable_shared_cache' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_release_memory; external sqlite3dll name _PU + 'sqlite3_release_memory' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_soft_heap_limit64; external sqlite3dll name _PU + 'sqlite3_soft_heap_limit64' {$IFNDEF POSIX}delayed{$ENDIF};

{$IFDEF MSWINDOWS}
function sqlite3_table_column_metadata; external sqlite3dll name _PU + 'sqlite3_table_column_metadata' {$IFNDEF POSIX}delayed{$ENDIF};
{$ENDIF MSWINDOWS}

function sqlite3_load_extension; external sqlite3dll name _PU + 'sqlite3_load_extension' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_enable_load_extension; external sqlite3dll name _PU + 'sqlite3_enable_load_extension' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_auto_extension; external sqlite3dll name _PU + 'sqlite3_auto_extension' {$IFNDEF POSIX}delayed{$ENDIF};

procedure sqlite3_reset_auto_extension; external sqlite3dll name _PU + 'sqlite3_reset_auto_extension' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_create_module; external sqlite3dll name _PU + 'sqlite3_create_module' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_create_module_v2; external sqlite3dll name _PU + 'sqlite3_create_module_v2' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_declare_vtab; external sqlite3dll name _PU + 'sqlite3_declare_vtab' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_overload_function; external sqlite3dll name _PU + 'sqlite3_overload_function' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_blob_open; external sqlite3dll name _PU + 'sqlite3_blob_open' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_blob_reopen; external sqlite3dll name _PU + 'sqlite3_blob_reopen' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_blob_close; external sqlite3dll name _PU + 'sqlite3_blob_close' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_blob_bytes; external sqlite3dll name _PU + 'sqlite3_blob_bytes' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_blob_read; external sqlite3dll name _PU + 'sqlite3_blob_read' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_blob_write; external sqlite3dll name _PU + 'sqlite3_blob_write' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_vfs_find; external sqlite3dll name _PU + 'sqlite3_vfs_find' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_vfs_register; external sqlite3dll name _PU + 'sqlite3_vfs_register' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_vfs_unregister; external sqlite3dll name _PU + 'sqlite3_vfs_unregister' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_mutex_alloc; external sqlite3dll name _PU + 'sqlite3_mutex_alloc' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_mutex_free; external sqlite3dll name _PU + 'sqlite3_mutex_free' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_mutex_enter; external sqlite3dll name _PU + 'sqlite3_mutex_enter' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_mutex_try; external sqlite3dll name _PU + 'sqlite3_mutex_try' {$IFNDEF POSIX}delayed{$ENDIF};
procedure sqlite3_mutex_leave; external sqlite3dll name _PU + 'sqlite3_mutex_leave' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_mutex_held; external sqlite3dll name _PU + 'sqlite3_mutex_held' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_mutex_notheld; external sqlite3dll name _PU + 'sqlite3_mutex_notheld' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_db_mutex; external sqlite3dll name _PU + 'sqlite3_db_mutex' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_file_control; external sqlite3dll name _PU + 'sqlite3_file_control' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_test_control; external sqlite3dll name _PU + 'sqlite3_test_control' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_status; external sqlite3dll name _PU + 'sqlite3_status' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_db_status; external sqlite3dll name _PU + 'sqlite3_db_status' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_stmt_status; external sqlite3dll name _PU + 'sqlite3_stmt_status' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_backup_init; external sqlite3dll name _PU + 'sqlite3_backup_init' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_backup_step; external sqlite3dll name _PU + 'sqlite3_backup_step' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_backup_finish; external sqlite3dll name _PU + 'sqlite3_backup_finish' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_backup_remaining; external sqlite3dll name _PU + 'sqlite3_backup_remaining' {$IFNDEF POSIX}delayed{$ENDIF};
function sqlite3_backup_pagecount; external sqlite3dll name _PU + 'sqlite3_backup_pagecount' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_unlock_notify; external sqlite3dll name _PU + 'sqlite3_unlock_notify' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_strnicmp; external sqlite3dll name _PU + 'sqlite3_strnicmp' {$IFNDEF POSIX}delayed{$ENDIF};

procedure sqlite3_log; external sqlite3dll name _PU + 'sqlite3_log' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_wal_hook; external sqlite3dll name _PU + 'sqlite3_wal_hook' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_wal_autocheckpoint; external sqlite3dll name _PU + 'sqlite3_wal_autocheckpoint' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_wal_checkpoint; external sqlite3dll name _PU + 'sqlite3_wal_checkpoint' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_wal_checkpoint_v2; external sqlite3dll name _PU + 'sqlite3_wal_checkpoint_v2' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_vtab_config; external sqlite3dll name _PU + 'sqlite3_vtab_config' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_vtab_on_conflict; external sqlite3dll name _PU + 'sqlite3_vtab_on_conflict' {$IFNDEF POSIX}delayed{$ENDIF};

function sqlite3_rtree_geometry_callback; external sqlite3dll name _PU + 'sqlite3_rtree_geometry_callback' {$IFNDEF POSIX}delayed{$ENDIF};

end.

