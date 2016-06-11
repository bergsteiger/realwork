{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{             FireDAC SQLite Call Interface             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.SQLiteCli;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  FireDAC.Stan.Intf, FireDAC.Stan.Consts;

{$IFNDEF FireDAC_SQLITE_STATIC}
const
  {$IFDEF MSWINDOWS}
  C_SQLiteDll: String = 'sqlite3' + C_FD_DLLExt;
  C_BDBDll: String = 'libdb_sql51' + C_FD_DLLExt;
  {$ENDIF}
  {$IFDEF ANDROID}
  C_SQLiteDll: String = 'libsqlite' + C_FD_DLLExt;
  C_BDBDll: String = 'libdb_sql' + C_FD_DLLExt;
  {$ELSE}
    {$IFDEF POSIX}
  C_CGSQLiteDll: String = 'libcgsqlite3' + C_FD_DLLExt;
  C_SQLiteDll: String = 'libsqlite3' + C_FD_DLLExt;
  C_BDBDll: String = 'libdb_sql' + C_FD_DLLExt;
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

type
  PUtf8 = PFDAnsiString;
  PPUtf8 = ^PUtf8;
  sqlite3_int64 = Int64;
  sqlite3_uint64 = UInt64;
  sqlite3_rtree_dbl = Double;
  psqlite3_rtree_dbl = ^sqlite3_rtree_dbl;

  // -------------------------------------------------------------------------
  // Handles

  psqlite3 = Pointer;
  psqlite3_blob = Pointer;
  psqlite3_context = Pointer;
  psqlite3_stmt = Pointer;
  psqlite3_value = Pointer;
  ppsqlite3_value = ^psqlite3_value;
  psqlite3_backup = Pointer;

  psqlite3_index_info = ^sqlite3_index_info;
  psqlite3_index_constraint = ^sqlite3_index_constraint;
  psqlite3_index_orderby = ^sqlite3_index_orderby;
  psqlite3_index_constraint_usage = ^sqlite3_index_constraint_usage;
  psqlite3_module = ^sqlite3_module;
  psqlite3_vtab = ^sqlite3_vtab;
  psqlite3_vtab_cursor = ^sqlite3_vtab_cursor;

  psqlite3_mem_methods = ^sqlite3_mem_methods;
  psqlite3_file = ^sqlite3_file;
  psqlite3_io_methods = ^sqlite3_io_methods;
  psqlite3_vfs = ^sqlite3_vfs;

  psqlite3_rtree_geometry = ^sqlite3_rtree_geometry;
  psqlite3_rtree_query_info = ^sqlite3_rtree_query_info;

  // -------------------------------------------------------------------------
  // Callbacks

  Tsqlite3_busy_callback = function (userdata: Pointer; times: Integer): Integer; cdecl;
  Tsqlite3_func_callback = procedure (context: psqlite3_context; nargs: Integer;
    args: ppsqlite3_value); cdecl;
  Tsqlite3_step_callback = procedure (context: psqlite3_context; nargs: Integer;
    args: ppsqlite3_value); cdecl;
  Tsqlite3_final_callback = procedure (context: psqlite3_context); cdecl;
  Tsqlite3_destroy_callback = procedure (value: Pointer); cdecl;
  Tsqlite3_commit_callback = function (userdata: Pointer): Integer; cdecl;
  Tsqlite3_rollback_callback = procedure (userdata: Pointer); cdecl;
  Tsqlite3_trace_callback = procedure (userdata: Pointer; zSql: PUtf8); cdecl;
  Tsqlite3_profile_callback = procedure (userdata: Pointer; zSql: PUtf8;
    time: sqlite3_uint64); cdecl;
  Tsqlite3_auth_callback = function (userdata: Pointer; code: Integer;
    zArg1, zArg2, zArg3, zArg4: PUtf8): Integer; cdecl;
  Tsqlite3_update_callback = procedure (userdata: Pointer; oper: Integer;
    zDb, zTable: PUtf8; rowid: sqlite3_int64); cdecl;
  Tsqlite3_collation_callback = procedure (userdata: Pointer; db: psqlite3;
    eTextRep: Integer; name: Pointer {utf8/utf16}); cdecl;
  Tsqlite3_compare_callback = function (userdata: Pointer; len1: Integer;
    str1: Pointer {utf8/utf16}; len2: Integer; str2: Pointer {utf8/utf16}): Integer; cdecl;
  Tsqlite3_progress_callback = function (userdata: Pointer): Integer; cdecl;
  Tsqlite3_wal_callback = function (userdata: Pointer; db: psqlite3;
    name: PByte; nPages: Integer): Integer; cdecl;
  Tsqlite3_rtree_xGeom_callback = function (geom: psqlite3_rtree_geometry; nCoord: Integer;
    aCoord: psqlite3_rtree_dbl; var pRes: Integer): Integer; cdecl;
  Tsqlite3_rtree_xQuery_callback = function (info: psqlite3_rtree_query_info): Integer; cdecl;
  Tsqlite3_rtree_xDelUser_callback = procedure (userdata: Pointer); cdecl;

  // -------------------------------------------------------------------------
  // Virtual Table Object

  // Virtual Table Indexing Information
  sqlite3_index_constraint = record
    iColumn: Integer;     // Column on left-hand side of constraint
    op: Byte;             // Constraint operator
    usable: Byte;         // True if this constraint is usable
    iTermOffset: Integer; // Used internally - xBestIndex should ignore
  end;

  sqlite3_index_orderby = record
    iColumn: Integer;     // Column number
    desc: Byte;           // True for DESC.  False for ASC.
  end;

  sqlite3_index_constraint_usage = record
    argvIndex: Integer;   // if >0, constraint is part of argv to xFilter
    omit: Byte;           // Do not code a test for this constraint
  end;

  sqlite3_index_info = record
    // Inputs
    nConstraint: Integer;                   // Number of entries in aConstraint
    aConstraint: psqlite3_index_constraint; // Table of WHERE clause constraints
    nOrderBy: Integer;                      // Number of terms in the ORDER BY clause
    aOrderBy: psqlite3_index_orderby;       // The ORDER BY clause
    // Outputs
    aConstraintUsage: psqlite3_index_constraint_usage;
    idxNum: Integer;                        // Number used to identify the index
    idxStr: PUtf8;                          // String, possibly obtained from sqlite3_malloc
    needToFreeIdxStr: Integer;              // Free idxStr using sqlite3_free() if true
    orderByConsumed: Integer;               // True if output is already ordered
    estimatedCost: Double;                  // Estimated cost of using this index
    // Fields below are only available in SQLite 3.8.2 and later
    estimatedRows: sqlite3_int64;           // Estimated number of rows returned
    // Fields below are only available in SQLite 3.9.0 and later
    idxFlags: Integer;                      // Mask of SQLITE_INDEX_SCAN_* flags
  end;

  sqlite3_module = record
    iVersion: Integer;
    xCreate: function(db: psqlite3; pAux: Pointer; argc: Integer; argv: PPUtf8;
      var ppVTab: psqlite3_vtab; var pzErr: PUtf8): Integer; cdecl;
    xConnect: function (db: psqlite3; pAux: Pointer; argc: Integer; argv: PPUtf8;
      var ppVTab: psqlite3_vtab; var pzErr: PUtf8): Integer; cdecl;
    xBestIndex: function (pVTab: psqlite3_vtab; info: psqlite3_index_info): Integer; cdecl;
    xDisconnect: function (pVTab: psqlite3_vtab): Integer; cdecl;
    xDestroy: function (pVTab: psqlite3_vtab): Integer; cdecl;
    xOpen: function (pVTab: psqlite3_vtab; var ppCursor: psqlite3_vtab_cursor): Integer; cdecl;
    xClose: function (cursor: psqlite3_vtab_cursor): Integer; cdecl;
    xFilter: function (cursor: psqlite3_vtab_cursor; idxNum: Integer; idxStr: PUtf8;
      argc: Integer; argv: ppsqlite3_value): Integer; cdecl;
    xNext: function (cursor: psqlite3_vtab_cursor): Integer; cdecl;
    xEof: function (cursor: psqlite3_vtab_cursor): Integer; cdecl;
    xColumn: function (cursor: psqlite3_vtab_cursor; context: psqlite3_context;
      index: Integer): Integer; cdecl;
    xRowid: function (cursor: psqlite3_vtab_cursor; var pRowid: sqlite3_int64): Integer; cdecl;
    xUpdate: function (pVTab: psqlite3_vtab; nArg: Integer; apArgs: ppsqlite3_value;
      var rowid: sqlite3_int64): Integer; cdecl;
    xBegin: function (pVTab: psqlite3_vtab): Integer; cdecl;
    xSync: function (pVTab: psqlite3_vtab): Integer; cdecl;
    xCommit: function (pVTab: psqlite3_vtab): Integer; cdecl;
    xRollback: function (pVTab: psqlite3_vtab): Integer; cdecl;
    xFindFunction: function (pVTab: psqlite3_vtab; nArg: Integer; zName: PUtf8;
      var pxFunc: Tsqlite3_func_callback; var ppArg: Pointer): Integer; cdecl;
    xRename: function (pVTab: psqlite3_vtab; zNew: PUtf8): Integer; cdecl;
    // The methods above are in version 1 of the sqlite_module object. Those
    // below are for version 2 and greater.
    // SQLite 3.7.7
    xSavepoint: function (pVTab: psqlite3_vtab; p: Integer): Integer; cdecl;
    xRelease: function (pVTab: psqlite3_vtab; p: Integer): Integer; cdecl;
    xRollbackTo: function (pVTab: psqlite3_vtab; p: Integer): Integer; cdecl;
  end;

  // Virtual Table Instance Object
  sqlite3_vtab = record
    pModule: psqlite3_module; // The module for this virtual table
    nRef: Integer;            // Used internally
    zErrMsg: PUtf8;           // Error message from sqlite3_mprintf()
    // Virtual table implementations will typically add additional fields
  end;

  // Virtual Table Cursor Object
  sqlite3_vtab_cursor = record
    pVtab: psqlite3_vtab;     // Virtual table of this cursor
    // Virtual table implementations will typically add additional fields
  end;

  // -------------------------------------------------------------------------
  // OS abstraction layer

  // Memory Allocation Routines
  sqlite3_mem_methods = record
    xMalloc: function (size: Integer): Pointer; cdecl;  // Memory allocation function
    xFree: procedure (ptr: Pointer); cdecl;             // Free a prior allocation
    xRealloc: function (ptr: Pointer; size: Integer): Pointer; cdecl; // Resize an allocation
    xSize: function (ptr: Pointer): Integer; cdecl;     // Return the size of an allocation
    xRoundup: function (size: Integer): Integer; cdecl; // Round up request size to allocation size
    xInit: function (data: Pointer): Integer; cdecl;    // Initialize the memory allocator
    xShutdown: procedure (data: Pointer); cdecl;        // Deinitialize the memory allocator
    pAppData: Pointer;                                  // Argument to xInit() and xShutdown()
  end;

  // OS Interface Open File Handle
  sqlite3_file = record
    pMethods: psqlite3_io_methods; // Methods for an open file
  end;

  // OS Interface File Virtual Methods Object
  sqlite3_io_methods = record
    iVersion: Integer;
    xClose: function (pFile: psqlite3_file): Integer; cdecl;
    xRead: function (pFile: psqlite3_file; buf: Pointer; iAmt: Integer; iOfst: sqlite3_int64): Integer; cdecl;
    xWrite: function (pFile: psqlite3_file; bug: Pointer; iAmt: Integer; iOfst: sqlite3_int64): Integer; cdecl;
    xTruncate: function (pFile: psqlite3_file; size: sqlite3_int64): Integer; cdecl;
    xSync: function (pFile: psqlite3_file; flags: Integer): Integer; cdecl;
    xFileSize: function (pFile: psqlite3_file; var pSize: sqlite3_int64): Integer; cdecl;
    xLock: function (pFile: psqlite3_file; mode: Integer): Integer; cdecl;
    xUnlock: function (pFile: psqlite3_file; mode: Integer): Integer; cdecl;
    xCheckReservedLock: function (pFile: psqlite3_file; var pResOut: Integer): Integer; cdecl;
    xFileControl: function (pFile: psqlite3_file; op: Integer; pArg: Pointer): Integer; cdecl;
    xSectorSize: function (pFile: psqlite3_file): Integer; cdecl;
    xDeviceCharacteristics: function (pFile: psqlite3_file): Integer; cdecl;
    // Methods above are valid for version 1
    xShmMap: function (pFile: psqlite3_file; iPg: Integer; pgsz: Integer; i: Integer; p: PPointer): Integer; cdecl;
    xShmLock: function (pFile: psqlite3_file; offset: Integer; n: Integer; flags: Integer): Integer; cdecl;
    xShmBarrier: procedure (pFile: psqlite3_file); cdecl;
    xShmUnmap: function (pFile: psqlite3_file; deleteFlag: Integer): Integer; cdecl;
    // Methods above are valid for version 2
    xFetch: function (pFile: sqlite3_file; iOfst: sqlite3_int64; iAmt: Integer; pp: PPointer): Integer; cdecl;
    xUnfetch: function (pFile: sqlite3_file; iOfst: sqlite3_int64; p: Pointer): Integer; cdecl;
    // Methods above are valid for version 3
    // Additional methods may be added in future releases
  end;

  // OS Interface Object
  Tsqlite3_vfs_xOpen = function (pVfs: psqlite3_vfs; zName: PFDAnsiString; pFile: psqlite3_file;
      flags: Integer; var pOutFlags: Integer): Integer; cdecl;
  Tsqlite3_syscall_ptr = procedure (); cdecl;

  sqlite3_vfs = record
    iVersion: Integer;     // Structure version number
    szOsFile: Integer;     // Size of subclassed sqlite3_file
    mxPathname: Integer;   // Maximum file pathname length
    pNext: psqlite3_vfs;   // Next registered VFS
    zName: PFDAnsiString;      // Name of this virtual file system
    pAppData: Pointer;     // Pointer to application-specific data
    xOpen: Tsqlite3_vfs_xOpen;
    xDelete: function (pVfs: psqlite3_vfs; zName: PFDAnsiString; syncDir: Integer): Integer; cdecl;
    xAccess: function (pVfs: psqlite3_vfs; zName: PFDAnsiString; flags: Integer; var pResOut: Integer): Integer; cdecl;
    xFullPathname: function (pVfs: psqlite3_vfs; zName: PFDAnsiString; nOut: Integer; zOut: PFDAnsiString): Integer; cdecl;
    xDlOpen: function (pVfs: psqlite3_vfs; zFilename: PFDAnsiString): Pointer; cdecl;
    xDlError: procedure (pVfs: psqlite3_vfs; nByte: Integer; zErrMsg: PFDAnsiString); cdecl;
    xDlSym: function (pVfs: psqlite3_vfs; ptr: Pointer; zSymbol: PFDAnsiString): Pointer; cdecl;
    xDlClose: procedure (pVfs: psqlite3_vfs; ptr: Pointer); cdecl;
    xRandomness: function (pVfs: psqlite3_vfs; nByte: Integer; zOut: PFDAnsiString): Integer; cdecl;
    xSleep: function (pVfs: psqlite3_vfs; microseconds: Integer): Integer; cdecl;
    xCurrentTime: function (pVfs: psqlite3_vfs; var tm: double): Integer; cdecl;
    xGetLastError: function (pVfs: psqlite3_vfs; l: Integer; v: PFDAnsiString): Integer; cdecl;
    //
    // The methods above are in version 1 of the sqlite_vfs object
    // definition.  Those that follow are added in version 2 or later
    //
    xCurrentTimeInt64: function (pVfs: psqlite3_vfs; var tm: sqlite3_int64): Integer; cdecl;
    //
    // The methods above are in versions 1 and 2 of the sqlite_vfs object.
    // New fields may be appended in figure versions.  The iVersion
    // value will increment whenever this happens.
    xSetSystemCall: function (pVfs: psqlite3_vfs; zName: PFDAnsiString; p: Tsqlite3_syscall_ptr): Integer; cdecl;
    xGetSystemCall: function (pVfs: psqlite3_vfs; zName: PFDAnsiString): Tsqlite3_syscall_ptr; cdecl;
    xNextSystemCall: function (pVfs: psqlite3_vfs; zName: PFDAnsiString): PFDAnsiString; cdecl;
    //
    // The methods above are in versions 1 through 3 of the sqlite_vfs object.
    // New fields may be appended in figure versions.  The iVersion
    // value will increment whenever this happens.
    //
  end;

  // -------------------------------------------------------------------------
  // RTree support

  sqlite3_rtree_geometry = record
    pContext: Pointer;                  // Copy of pContext passed to s_r_g_c()
    nParam: Integer;                    // Size of array aParam[]
    aParam: psqlite3_rtree_dbl;         // Parameters passed to SQL geom function
    pUser: Pointer;                     // Callback implementation user data
    xDelUser: Tsqlite3_rtree_xDelUser_callback; // Called by SQLite to clean up pUser
  end;

  sqlite3_rtree_query_info = record
    pContext: Pointer;                  // pContext from when function registered
    nParam: Integer;                    // Number of function parameters
    aParam: psqlite3_rtree_dbl;         // value of function parameters
    pUser: Pointer;                     // callback can use this, if desired
    xDelUser: Tsqlite3_rtree_xDelUser_callback; // function to free pUser
    aCoord: psqlite3_rtree_dbl;         // Coordinates of node or entry to check
    anQueue: PCardinal;                 // Number of pending entries in the queue
    nCoord: Integer;                    // Number of coordinates
    iLevel: Integer;                    // Level of current node or entry
    mxLevel: Integer;                   // The largest iLevel value in the tree
    iRowid: sqlite3_int64;              // Rowid for current entry
    rParentScore: sqlite3_rtree_dbl;    // Score of parent node
    eParentWithin: Integer;             // Visibility of parent node
    eWithin: Integer;                   // OUT: Visiblity
    rScore: sqlite3_rtree_dbl;          // OUT: Write the score here
  end;

const
  // Allowed values for sqlite3_rtree_query.eWithin and .eParentWithin.
  NOT_WITHIN      = 0;   // Object completely outside of query region
  PARTLY_WITHIN   = 1;   // Object partially overlaps query region
  FULLY_WITHIN    = 2;   // Object fully contained within query region

const
  // -------------------------------------------------------------------------
  // Flags For File Open Operations
  SQLITE_OPEN_READONLY         = $00000001;  // Ok for sqlite3_open_v2()
  SQLITE_OPEN_READWRITE        = $00000002;  // Ok for sqlite3_open_v2()
  SQLITE_OPEN_CREATE           = $00000004;  // Ok for sqlite3_open_v2()
  SQLITE_OPEN_DELETEONCLOSE    = $00000008;  // VFS only
  SQLITE_OPEN_EXCLUSIVE        = $00000010;  // VFS only
  SQLITE_OPEN_MAIN_DB          = $00000100;  // VFS only
  SQLITE_OPEN_TEMP_DB          = $00000200;  // VFS only
  SQLITE_OPEN_TRANSIENT_DB     = $00000400;  // VFS only
  SQLITE_OPEN_MAIN_JOURNAL     = $00000800;  // VFS only
  SQLITE_OPEN_TEMP_JOURNAL     = $00001000;  // VFS only
  SQLITE_OPEN_SUBJOURNAL       = $00002000;  // VFS only
  SQLITE_OPEN_MASTER_JOURNAL   = $00004000;  // VFS only
  SQLITE_OPEN_NOMUTEX          = $00008000;  // Ok for sqlite3_open_v2()
  SQLITE_OPEN_FULLMUTEX        = $00010000;  // Ok for sqlite3_open_v2()
  // SQLite 3.7
  SQLITE_OPEN_SHAREDCACHE      = $00020000;  // Ok for sqlite3_open_v2()
  SQLITE_OPEN_PRIVATECACHE     = $00040000;  // Ok for sqlite3_open_v2()
  SQLITE_OPEN_WAL              = $00080000;  // VFS only

  // Authorizer Return Codes
  SQLITE_DENY   = 1;   // Abort the SQL statement with an error
  SQLITE_IGNORE = 2;   // Don't allow access, but don't generate an error

  // Status Parameters
  SQLITE_STATUS_MEMORY_USED          = 0;
  SQLITE_STATUS_PAGECACHE_USED       = 1;
  SQLITE_STATUS_PAGECACHE_OVERFLOW   = 2;
  SQLITE_STATUS_SCRATCH_USED         = 3;
  SQLITE_STATUS_SCRATCH_OVERFLOW     = 4;
  SQLITE_STATUS_MALLOC_SIZE          = 5;
  SQLITE_STATUS_PARSER_STACK         = 6;
  SQLITE_STATUS_PAGECACHE_SIZE       = 7;
  SQLITE_STATUS_SCRATCH_SIZE         = 8;
  SQLITE_STATUS_MALLOC_COUNT         = 9;

  // Status Parameters for database connections
  SQLITE_DBSTATUS_LOOKASIDE_USED      = 0;
  SQLITE_DBSTATUS_CACHE_USED          = 1;
  SQLITE_DBSTATUS_SCHEMA_USED         = 2;
  SQLITE_DBSTATUS_STMT_USED           = 3;
  SQLITE_DBSTATUS_LOOKASIDE_HIT       = 4;
  SQLITE_DBSTATUS_LOOKASIDE_MISS_SIZE = 5;
  SQLITE_DBSTATUS_LOOKASIDE_MISS_FULL = 6;
  SQLITE_DBSTATUS_CACHE_HIT           = 7;
  SQLITE_DBSTATUS_CACHE_MISS          = 8;
  SQLITE_DBSTATUS_CACHE_WRITE         = 9;
  SQLITE_DBSTATUS_DEFERRED_FKS        = 10;
  SQLITE_DBSTATUS_MAX                 = 10;   // Largest defined DBSTATUS

  // Status Parameters for prepared statements
  SQLITE_STMTSTATUS_FULLSCAN_STEP     = 1;
  SQLITE_STMTSTATUS_SORT              = 2;
  SQLITE_STMTSTATUS_AUTOINDEX         = 3;
  SQLITE_STMTSTATUS_VM_STEP           = 4;

  // Result Codes
  SQLITE_OK           = 0;   // Successful result
  // beginning-of-error-codes
  SQLITE_ERROR        = 1;   // SQL error or missing database
  SQLITE_INTERNAL     = 2;   // Internal logic error in SQLite
  SQLITE_PERM         = 3;   // Access permission denied
  SQLITE_ABORT        = 4;   // Callback routine requested an abort
  SQLITE_BUSY         = 5;   // The database file is locked
  SQLITE_LOCKED       = 6;   // A table in the database is locked
  SQLITE_NOMEM        = 7;   // A malloc() failed
  SQLITE_READONLY     = 8;   // Attempt to write a readonly database
  SQLITE_INTERRUPT    = 9;   // Operation terminated by sqlite3_interrupt()
  SQLITE_IOERR       = 10;   // Some kind of disk I/O error occurred
  SQLITE_CORRUPT     = 11;   // The database disk image is malformed
  SQLITE_NOTFOUND    = 12;   // Unknown opcode in sqlite3_file_control()
  SQLITE_FULL        = 13;   // Insertion failed because database is full
  SQLITE_CANTOPEN    = 14;   // Unable to open the database file
  SQLITE_PROTOCOL    = 15;   // Database lock protocol error
  SQLITE_EMPTY       = 16;   // Database is empty
  SQLITE_SCHEMA      = 17;   // The database schema changed
  SQLITE_TOOBIG      = 18;   // String or BLOB exceeds size limit
  SQLITE_CONSTRAINT  = 19;   // Abort due to constraint violation
  SQLITE_MISMATCH    = 20;   // Data type mismatch
  SQLITE_MISUSE      = 21;   // Library used incorrectly
  SQLITE_NOLFS       = 22;   // Uses OS features not supported on host
  SQLITE_AUTH        = 23;   // Authorization denied
  SQLITE_FORMAT      = 24;   // Auxiliary database format error
  SQLITE_RANGE       = 25;   // 2nd parameter to sqlite3_bind out of range
  SQLITE_NOTADB      = 26;   // File opened that is not a database file
  SQLITE_NOTICE      = 27;   // Notifications from sqlite3_log()
  SQLITE_WARNING     = 28;   // Warnings from sqlite3_log()
  SQLITE_ROW         = 100;  // sqlite3_step() has another row ready
  SQLITE_DONE        = 101;  // sqlite3_step() has finished executing

  // Extended Result Codes
  SQLITE_IOERR_READ              = (SQLITE_IOERR or (1 shl 8));
  SQLITE_IOERR_SHORT_READ        = (SQLITE_IOERR or (2 shl 8));
  SQLITE_IOERR_WRITE             = (SQLITE_IOERR or (3 shl 8));
  SQLITE_IOERR_FSYNC             = (SQLITE_IOERR or (4 shl 8));
  SQLITE_IOERR_DIR_FSYNC         = (SQLITE_IOERR or (5 shl 8));
  SQLITE_IOERR_TRUNCATE          = (SQLITE_IOERR or (6 shl 8));
  SQLITE_IOERR_FSTAT             = (SQLITE_IOERR or (7 shl 8));
  SQLITE_IOERR_UNLOCK            = (SQLITE_IOERR or (8 shl 8));
  SQLITE_IOERR_RDLOCK            = (SQLITE_IOERR or (9 shl 8));
  SQLITE_IOERR_DELETE            = (SQLITE_IOERR or (10 shl 8));
  SQLITE_IOERR_BLOCKED           = (SQLITE_IOERR or (11 shl 8));
  SQLITE_IOERR_NOMEM             = (SQLITE_IOERR or (12 shl 8));
  SQLITE_IOERR_ACCESS            = (SQLITE_IOERR or (13 shl 8));
  SQLITE_IOERR_CHECKRESERVEDLOCK = (SQLITE_IOERR or (14 shl 8));
  SQLITE_IOERR_LOCK              = (SQLITE_IOERR or (15 shl 8));
  SQLITE_IOERR_CLOSE             = (SQLITE_IOERR or (16 shl 8));
  SQLITE_IOERR_DIR_CLOSE         = (SQLITE_IOERR or (17 shl 8));
  SQLITE_IOERR_SHMOPEN           = (SQLITE_IOERR or (18 shl 8));
  SQLITE_IOERR_SHMSIZE           = (SQLITE_IOERR or (19 shl 8));
  SQLITE_IOERR_SHMLOCK           = (SQLITE_IOERR or (20 shl 8));
  SQLITE_IOERR_SHMMAP            = (SQLITE_IOERR or (21 shl 8));
  SQLITE_IOERR_SEEK              = (SQLITE_IOERR or (22 shl 8));
  SQLITE_IOERR_DELETE_NOENT      = (SQLITE_IOERR or (23 shl 8));
  SQLITE_IOERR_MMAP              = (SQLITE_IOERR or (24 shl 8));
  SQLITE_IOERR_GETTEMPPATH       = (SQLITE_IOERR or (25 shl 8));
  SQLITE_IOERR_CONVPATH          = (SQLITE_IOERR or (26 shl 8));
  SQLITE_IOERR_VNODE             = (SQLITE_IOERR or (27 shl 8));
  SQLITE_LOCKED_SHAREDCACHE      = (SQLITE_LOCKED or (1 shl 8));
  SQLITE_BUSY_RECOVERY           = (SQLITE_BUSY or (1 shl 8));
  SQLITE_BUSY_SNAPSHOT           = (SQLITE_BUSY or (2 shl 8));
  SQLITE_CANTOPEN_NOTEMPDIR      = (SQLITE_CANTOPEN or (1 shl 8));
  SQLITE_CANTOPEN_ISDIR          = (SQLITE_CANTOPEN or (2 shl 8));
  SQLITE_CANTOPEN_FULLPATH       = (SQLITE_CANTOPEN or (3 shl 8));
  SQLITE_CANTOPEN_CONVPATH       = (SQLITE_CANTOPEN or (4 shl 8));
  SQLITE_CORRUPT_VTAB            = (SQLITE_CORRUPT or (1 shl 8));
  SQLITE_READONLY_RECOVERY       = (SQLITE_READONLY or (1 shl 8));
  SQLITE_READONLY_CANTLOCK       = (SQLITE_READONLY or (2 shl 8));
  SQLITE_READONLY_ROLLBACK       = (SQLITE_READONLY or (3 shl 8));
  SQLITE_READONLY_DBMOVED        = (SQLITE_READONLY or (4 shl 8));
  SQLITE_ABORT_ROLLBACK          = (SQLITE_ABORT or (2 shl 8));
  SQLITE_CONSTRAINT_CHECK        = (SQLITE_CONSTRAINT or (1 shl 8));
  SQLITE_CONSTRAINT_COMMITHOOK   = (SQLITE_CONSTRAINT or (2 shl 8));
  SQLITE_CONSTRAINT_FOREIGNKEY   = (SQLITE_CONSTRAINT or (3 shl 8));
  SQLITE_CONSTRAINT_FUNCTION     = (SQLITE_CONSTRAINT or (4 shl 8));
  SQLITE_CONSTRAINT_NOTNULL      = (SQLITE_CONSTRAINT or (5 shl 8));
  SQLITE_CONSTRAINT_PRIMARYKEY   = (SQLITE_CONSTRAINT or (6 shl 8));
  SQLITE_CONSTRAINT_TRIGGER      = (SQLITE_CONSTRAINT or (7 shl 8));
  SQLITE_CONSTRAINT_UNIQUE       = (SQLITE_CONSTRAINT or (8 shl 8));
  SQLITE_CONSTRAINT_VTAB         = (SQLITE_CONSTRAINT or (9 shl 8));
  SQLITE_CONSTRAINT_ROWID        = (SQLITE_CONSTRAINT or(10 shl 8));
  SQLITE_NOTICE_RECOVER_WAL      = (SQLITE_NOTICE or (1 shl 8));
  SQLITE_NOTICE_RECOVER_ROLLBACK = (SQLITE_NOTICE or (2 shl 8));
  SQLITE_WARNING_AUTOINDEX       = (SQLITE_WARNING or (1 shl 8));
  SQLITE_AUTH_USER               = (SQLITE_AUTH or (1 shl 8));

  // Boolean results
  SQLITE_FALSE = 0;
  SQLITE_TRUE  = 1;

  // Fundamental Datatypes
  SQLITE_INTEGER  = 1;
  SQLITE_FLOAT    = 2;
  SQLITE_TEXT     = 3;
  SQLITE_BLOB     = 4;
  SQLITE_NULL     = 5;

  // Authorizer Action Codes
  // *********************************** 3rd *********** 4th ***********
  SQLITE_CREATE_INDEX          = 1;   // Index Name      Table Name
  SQLITE_CREATE_TABLE          = 2;   // Table Name      NULL
  SQLITE_CREATE_TEMP_INDEX     = 3;   // Index Name      Table Name
  SQLITE_CREATE_TEMP_TABLE     = 4;   // Table Name      NULL
  SQLITE_CREATE_TEMP_TRIGGER   = 5;   // Trigger Name    Table Name
  SQLITE_CREATE_TEMP_VIEW      = 6;   // View Name       NULL
  SQLITE_CREATE_TRIGGER        = 7;   // Trigger Name    Table Name
  SQLITE_CREATE_VIEW           = 8;   // View Name       NULL
  SQLITE_DELETE                = 9;   // Table Name      NULL
  SQLITE_DROP_INDEX           = 10;   // Index Name      Table Name
  SQLITE_DROP_TABLE           = 11;   // Table Name      NULL
  SQLITE_DROP_TEMP_INDEX      = 12;   // Index Name      Table Name
  SQLITE_DROP_TEMP_TABLE      = 13;   // Table Name      NULL
  SQLITE_DROP_TEMP_TRIGGER    = 14;   // Trigger Name    Table Name
  SQLITE_DROP_TEMP_VIEW       = 15;   // View Name       NULL
  SQLITE_DROP_TRIGGER         = 16;   // Trigger Name    Table Name
  SQLITE_DROP_VIEW            = 17;   // View Name       NULL
  SQLITE_INSERT               = 18;   // Table Name      NULL
  SQLITE_PRAGMA               = 19;   // Pragma Name     1st arg or NULL
  SQLITE_READ                 = 20;   // Table Name      Column Name
  SQLITE_SELECT               = 21;   // NULL            NULL
  SQLITE_TRANSACTION          = 22;   // NULL            NULL
  SQLITE_UPDATE               = 23;   // Table Name      Column Name
  SQLITE_ATTACH               = 24;   // Filename        NULL
  SQLITE_DETACH               = 25;   // Database Name   NULL
  SQLITE_ALTER_TABLE          = 26;   // Database Name   Table Name
  SQLITE_REINDEX              = 27;   // Index Name      NULL
  SQLITE_ANALYZE              = 28;   // Table Name      NULL
  SQLITE_CREATE_VTABLE        = 29;   // Table Name      Module Name
  SQLITE_DROP_VTABLE          = 30;   // Table Name      Module Name
  SQLITE_FUNCTION             = 31;   // Function Name   NULL
  SQLITE_SAVEPOINT            = 32;   // Operation       Savepoint Name
  SQLITE_COPY                 = 0;    // No longer used
  SQLITE_RECURSIVE            = 33;   // NULL            NULL

  // Configuration Options
  SQLITE_CONFIG_SINGLETHREAD  = 1;  // nil
  SQLITE_CONFIG_MULTITHREAD   = 2;  // nil
  SQLITE_CONFIG_SERIALIZED    = 3;  // nil
  SQLITE_CONFIG_MALLOC        = 4;  // sqlite3_mem_methods*
  SQLITE_CONFIG_GETMALLOC     = 5;  // sqlite3_mem_methods*
  SQLITE_CONFIG_SCRATCH       = 6;  // void*, int sz, int N
  SQLITE_CONFIG_PAGECACHE     = 7;  // void*, int sz, int N
  SQLITE_CONFIG_HEAP          = 8;  // void*, int nByte, int min
  SQLITE_CONFIG_MEMSTATUS     = 9;  // boolean
  SQLITE_CONFIG_MUTEX        = 10;  // sqlite3_mutex_methods*
  SQLITE_CONFIG_GETMUTEX     = 11;  // sqlite3_mutex_methods*
  SQLITE_CONFIG_CHUNKALLOC   = 12;  // int threshold
  // previously SQLITE_CONFIG_LOOKASIDE = 13 which is now unused.
  SQLITE_CONFIG_PCACHE       = 14;  // sqlite3_pcache_methods*
  SQLITE_CONFIG_GETPCACHE    = 15;  // sqlite3_pcache_methods*
  SQLITE_CONFIG_LOG          = 16;  // xFunc, void*
  SQLITE_CONFIG_URI          = 17;  // int
  SQLITE_CONFIG_PCACHE2      = 18;  // sqlite3_pcache_methods2*
  SQLITE_CONFIG_GETPCACHE2   = 19;  // sqlite3_pcache_methods2*
  SQLITE_CONFIG_COVERING_INDEX_SCAN = 20; // int
  SQLITE_CONFIG_SQLLOG       = 21;  // xSqllog, void*
  SQLITE_CONFIG_MMAP_SIZE    = 22;  // sqlite3_int64, sqlite3_int64
  SQLITE_CONFIG_WIN32_HEAPSIZE = 23;  // int nByte
  SQLITE_CONFIG_PCACHE_HDRSZ   = 24;  // int *psz
  SQLITE_CONFIG_PMASZ          = 25;  // unsigned int szPma

  // Configuration Options
  SQLITE_DBCONFIG_LOOKASIDE      = 1001;  // void* int int
  SQLITE_DBCONFIG_ENABLE_FKEY    = 1002;  // int int*
  SQLITE_DBCONFIG_ENABLE_TRIGGER = 1003;  // int int*

  // Virtual Table Indexing Information
  SQLITE_INDEX_CONSTRAINT_EQ    = 2;
  SQLITE_INDEX_CONSTRAINT_GT    = 4;
  SQLITE_INDEX_CONSTRAINT_LE    = 8;
  SQLITE_INDEX_CONSTRAINT_LT    = 16;
  SQLITE_INDEX_CONSTRAINT_GE    = 32;
  SQLITE_INDEX_CONSTRAINT_MATCH = 64;

  // Virtual Table Scan Flags
  SQLITE_INDEX_SCAN_UNIQUE      = 1; // Scan visits at most 1 row

  // Virtual Table Safecall result
  E_SQLITE_VTAB_RES = HRESULT($8000);

  // Run-Time Limit Categories
  SQLITE_LIMIT_LENGTH                    = 0;
  SQLITE_LIMIT_SQL_LENGTH                = 1;
  SQLITE_LIMIT_COLUMN                    = 2;
  SQLITE_LIMIT_EXPR_DEPTH                = 3;
  SQLITE_LIMIT_COMPOUND_SELECT           = 4;
  SQLITE_LIMIT_VDBE_OP                   = 5;
  SQLITE_LIMIT_FUNCTION_ARG              = 6;
  SQLITE_LIMIT_ATTACHED                  = 7;
  SQLITE_LIMIT_LIKE_PATTERN_LENGTH       = 8;
  SQLITE_LIMIT_VARIABLE_NUMBER           = 9;
  SQLITE_LIMIT_TRIGGER_DEPTH             = 10;
  SQLITE_LIMIT_WORKER_THREADS            = 11;

  // Constants Defining Special Destructor Behavior
var
  SQLITE_STATIC: Tsqlite3_destroy_callback;
  SQLITE_TRANSIENT: Tsqlite3_destroy_callback;

const
  // Text Encodings
  SQLITE_UTF16NATIVE    = 0;
  SQLITE_UTF8           = 1;
  SQLITE_UTF16LE        = 2;
  SQLITE_UTF16BE        = 3;
  SQLITE_UTF16          = 4;    // Use native byte order
  SQLITE_ANY            = 5;    // sqlite3_create_function only
  SQLITE_UTF16_ALIGNED  = 8;    // sqlite3_create_collation only

  // Function flags
  SQLITE_DETERMINISTIC  = $800;

  // VTab index modes
  SQLITE_VTAB_DS_ROWID_IDX = 1;
  SQLITE_VTAB_DS_KEY_IDX   = 2;
  SQLITE_VTAB_DS_ORD_IDX   = 4;

  // VTab configuration options
  SQLITE_VTAB_CONSTRAINT_SUPPORT = 1;

  // VTab conflict resolution modes
  SQLITE_ROLLBACK = 1;
  // SQLITE_IGNORE = 2; // Also used by sqlite3_authorizer() callback */
  SQLITE_FAIL = 3;
  // SQLITE_ABORT = 4;  // Also an error code */
  SQLITE_REPLACE = 5;

{$IFDEF FireDAC_SQLITE_STATIC}

const
  {$IFDEF FireDAC_SQLITE_EXTERNAL}
    {$IFDEF UNDERSCOREIMPORTNAME}
      _SLU = '_';
    {$ELSE}
      _SLU = '';
    {$ENDIF}
    {$IF DEFINED(MACOS) and not DEFINED(IOS)}
      C_FD_SQLiteLib = 'libcgsqlite3.dylib';
    {$ELSE}
      C_FD_SQLiteLib = 'libsqlite.a';
    {$ENDIF}
  {$ELSE}
    {$IFDEF FireDAC_32}
      C_FD_SQLiteLib = 'sqlite3_x86.obj';
      {$L sqlite3_x86.obj}
    {$ENDIF}
    {$IFDEF FireDAC_64}
      C_FD_SQLiteLib = 'sqlite3_x64.obj';
      {$L sqlite3_x64.obj}
    {$ENDIF}
  {$ENDIF}

  function sqlite3_libversion(): PFDAnsiString; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_libversion' {$ENDIF};
  function sqlite3_libversion_number(): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_libversion_number' {$ENDIF};
  function sqlite3_compileoption_used(zOptName: PFDAnsiString): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_compileoption_used' {$ENDIF};
  function sqlite3_compileoption_get(N: Integer): PFDAnsiString; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_compileoption_get' {$ENDIF};
  function sqlite3_enable_shared_cache(onoff: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_enable_shared_cache' {$ENDIF};
  function sqlite3_release_memory(amount: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_release_memory' {$ENDIF};
  procedure sqlite3_soft_heap_limit(amount: Integer); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_soft_heap_limit' {$ENDIF};
  function sqlite3_status(op: Integer; var pCurrent: Integer; var pHighwater: Integer; resetFlag: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_status' {$ENDIF};
  function sqlite3_initialize(): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_initialize' {$ENDIF};
  function sqlite3_shutdown(): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_shutdown' {$ENDIF};
  function sqlite3_malloc(n: Integer): Pointer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_malloc' {$ENDIF};
  function sqlite3_memory_used(): sqlite3_int64; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_memory_used' {$ENDIF};
  function sqlite3_memory_highwater(resetFlag: Integer): sqlite3_int64; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_memory_highwater' {$ENDIF};
  procedure sqlite3_free(APtr: Pointer); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_free' {$ENDIF};
  function sqlite3_config(option: Integer): Integer; cdecl varargs; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_config' {$ENDIF};

  function sqlite3_open(filename: PByte; var ppDb: psqlite3): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_open' {$ENDIF};
  function sqlite3_open16(filename: PByte; var ppDb: psqlite3): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_open16' {$ENDIF};
  function sqlite3_open_v2(filename: PUtf8; var ppDb: psqlite3; flags: Integer; zVfs: PFDAnsiString): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_open_v2' {$ENDIF};
  function sqlite3_close(db: psqlite3): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_close' {$ENDIF};
  function sqlite3_busy_timeout(db: psqlite3; ms: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_busy_timeout' {$ENDIF};
  function sqlite3_busy_handler(db: psqlite3; callback: Tsqlite3_busy_callback; userdata: Pointer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_busy_handler' {$ENDIF};
  function sqlite3_trace(db: psqlite3; xTrace: Tsqlite3_trace_callback; userdata: Pointer): Pointer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_trace' {$ENDIF};
  function sqlite3_profile(db: psqlite3; xProfile: Tsqlite3_profile_callback; userdata: Pointer): Pointer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_profile' {$ENDIF};
  function sqlite3_set_authorizer(db: psqlite3; xAuth: Tsqlite3_auth_callback; userdata: Pointer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_set_authorizer' {$ENDIF};
  function sqlite3_get_autocommit(db: psqlite3): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_get_autocommit' {$ENDIF};
  function sqlite3_commit_hook(db: psqlite3; callback: Tsqlite3_commit_callback; userdata: Pointer): Pointer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_commit_hook' {$ENDIF};
  function sqlite3_rollback_hook(db: psqlite3; callback: Tsqlite3_rollback_callback; userdata: Pointer): Pointer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_rollback_hook' {$ENDIF};
  function sqlite3_table_column_metadata(db: psqlite3; zDbName: PUtf8; zTableName: PUtf8; zColumnName: PUtf8; var pzDataType: PUtf8; var pzCollSeq: PUtf8; var pNotNull: Integer; var pPrimaryKey: Integer; var pAutoinc: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_table_column_metadata' {$ENDIF};
  function sqlite3_update_hook(db: psqlite3; callback: Tsqlite3_update_callback; userdata: Pointer): Pointer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_update_hook' {$ENDIF};
  function sqlite3_limit(db: psqlite3; id: Integer; newVal: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_limit' {$ENDIF};
  function sqlite3_collation_needed(db: psqlite3; userdata: Pointer; callback: Tsqlite3_collation_callback): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_collation_needed' {$ENDIF};
  function sqlite3_create_collation(db: psqlite3; zName: PByte; eTextRep: Integer; userdata: Pointer; callback: Tsqlite3_compare_callback): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_create_collation' {$ENDIF};
  function sqlite3_collation_needed16(db: psqlite3; userdata: Pointer; callback: Tsqlite3_collation_callback): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_collation_needed16' {$ENDIF};
  function sqlite3_create_collation16(db: psqlite3; zName: PByte; eTextRep: Integer; userdata: Pointer; callback: Tsqlite3_compare_callback): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_create_collation16' {$ENDIF};
  procedure sqlite3_progress_handler(db: psqlite3; nOpers: Integer; callback: Tsqlite3_progress_callback; userdata: Pointer); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_progress_handler' {$ENDIF};

  function sqlite3_errcode(db: psqlite3): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_errcode' {$ENDIF};
  function sqlite3_errmsg(db: psqlite3): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_errmsg' {$ENDIF};
  function sqlite3_errmsg16(db: psqlite3): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_errmsg16' {$ENDIF};
  function sqlite3_extended_result_codes(db: psqlite3; onoff: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_extended_result_codes' {$ENDIF};
  function sqlite3_errstr(code: Integer): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_errstr' {$ENDIF};

  function sqlite3_changes(db: psqlite3): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_changes' {$ENDIF};
  function sqlite3_total_changes(db: psqlite3): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_total_changes' {$ENDIF};
  procedure sqlite3_interrupt(db: psqlite3); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_interrupt' {$ENDIF};
  function sqlite3_last_insert_rowid(db: psqlite3): sqlite3_int64; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_last_insert_rowid' {$ENDIF};
  function sqlite3_db_filename(db: psqlite3; zDbName: PUtf8): PUtf8; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_db_filename' {$ENDIF};
  function sqlite3_db_readonly(db: psqlite3; zDbName: PUtf8): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_db_readonly' {$ENDIF};
  function sqlite3_db_status(db: psqlite3; op: Integer; var pCurrent: Integer; var pHighwater: Integer; resetFlag: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_db_status' {$ENDIF};
  function sqlite3_exec(db: psqlite3; zSql: PByte; callback: Pointer; data: Pointer; errmsg: PPByte): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_exec' {$ENDIF};

  function sqlite3_prepare(db: psqlite3; zSql: PByte; nByte: Integer; var ppStmt: psqlite3_stmt; var pzTail: PByte): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_prepare' {$ENDIF};
  function sqlite3_prepare16(db: psqlite3; zSql: PByte; nByte: Integer; var ppStmt: psqlite3_stmt; var pzTail: PByte): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_prepare16' {$ENDIF};
  function sqlite3_prepare_v2(db: psqlite3; zSql: PByte; nByte: Integer; var ppStmt: psqlite3_stmt; var pzTail: PByte): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_prepare_v2' {$ENDIF};
  function sqlite3_prepare16_v2(db: psqlite3; zSql: PByte; nByte: Integer; var ppStmt: psqlite3_stmt; var pzTail: PByte): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_prepare16_v2' {$ENDIF};
  function sqlite3_step(stmt: psqlite3_stmt): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_step' {$ENDIF};
  function sqlite3_reset(stmt: psqlite3_stmt): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_reset' {$ENDIF};
  function sqlite3_finalize(stmt: psqlite3_stmt): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_finalize' {$ENDIF};
  function sqlite3_stmt_readonly(stmt: psqlite3_stmt): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_stmt_readonly' {$ENDIF};
  function sqlite3_stmt_busy(stmt: psqlite3_stmt): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_stmt_busy' {$ENDIF};
  function sqlite3_stmt_status(stmt: psqlite3_stmt; op: Integer; resetFlg: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_stmt_status' {$ENDIF};

  function sqlite3_clear_bindings(stmt: psqlite3_stmt): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_clear_bindings' {$ENDIF};
  function sqlite3_bind_parameter_count(stmt: psqlite3_stmt): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_bind_parameter_count' {$ENDIF};
  function sqlite3_bind_parameter_index(stmt: psqlite3_stmt; zName: PUtf8): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_bind_parameter_index' {$ENDIF};
  function sqlite3_bind_parameter_name(stmt: psqlite3_stmt; index: Integer): PUtf8; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_bind_parameter_name' {$ENDIF};
  function sqlite3_bind_blob(stmt: psqlite3_stmt; index: Integer; value: Pointer; nBytes: Integer; destr: Tsqlite3_destroy_callback): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_bind_blob' {$ENDIF};
  function sqlite3_bind_blob64(stmt: psqlite3_stmt; index: Integer; value: Pointer; nBytes: sqlite3_uint64; destr: Tsqlite3_destroy_callback): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_bind_blob64' {$ENDIF};
  function sqlite3_bind_double(stmt: psqlite3_stmt; index: Integer; value: double): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_bind_double' {$ENDIF};
  function sqlite3_bind_int(stmt: psqlite3_stmt; index: Integer; value: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_bind_int' {$ENDIF};
  function sqlite3_bind_int64(stmt: psqlite3_stmt; index: Integer; value: sqlite3_int64): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_bind_int64' {$ENDIF};
  function sqlite3_bind_null(stmt: psqlite3_stmt; index: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_bind_null' {$ENDIF};
  function sqlite3_bind_text(stmt: psqlite3_stmt; index: Integer; value: PByte; nBytes: Integer; destr: Tsqlite3_destroy_callback): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_bind_text' {$ENDIF};
  function sqlite3_bind_text16(stmt: psqlite3_stmt; index: Integer; value: PByte; nBytes: Integer; destr: Tsqlite3_destroy_callback): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_bind_text16' {$ENDIF};
  function sqlite3_bind_text64(stmt: psqlite3_stmt; index: Integer; value: PByte; nBytes: sqlite3_uint64; destr: Tsqlite3_destroy_callback; encoding: Byte): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_bind_text64' {$ENDIF};
  function sqlite3_bind_value(stmt: psqlite3_stmt; index: Integer; value: psqlite3_value): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_bind_value' {$ENDIF};
  function sqlite3_bind_zeroblob(stmt: psqlite3_stmt; index: Integer; nBytes: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_bind_zeroblob' {$ENDIF};

  function sqlite3_column_count(stmt: psqlite3_stmt): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_count' {$ENDIF};
  function sqlite3_column_type(stmt: psqlite3_stmt; iCol: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_type' {$ENDIF};
  function sqlite3_column_name(stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_name' {$ENDIF};
  function sqlite3_column_name16(stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_name16' {$ENDIF};
  function sqlite3_column_database_name(stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_database_name' {$ENDIF};
  function sqlite3_column_database_name16(stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_database_name16' {$ENDIF};
  function sqlite3_column_table_name(stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_table_name' {$ENDIF};
  function sqlite3_column_table_name16(stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_table_name16' {$ENDIF};
  function sqlite3_column_origin_name(stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_origin_name' {$ENDIF};
  function sqlite3_column_origin_name16(stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_origin_name16' {$ENDIF};
  function sqlite3_column_decltype(stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_decltype' {$ENDIF};
  function sqlite3_column_decltype16(stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_decltype16' {$ENDIF};
  function sqlite3_column_blob(stmt: psqlite3_stmt; iCol: Integer): Pointer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_blob' {$ENDIF};
  function sqlite3_column_bytes(stmt: psqlite3_stmt; iCol: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_bytes' {$ENDIF};
  function sqlite3_column_bytes16(stmt: psqlite3_stmt; iCol: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_bytes16' {$ENDIF};
  function sqlite3_column_double(stmt: psqlite3_stmt; iCol: Integer): Double; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_double' {$ENDIF};
  function sqlite3_column_int(stmt: psqlite3_stmt; iCol: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_int' {$ENDIF};
  function sqlite3_column_int64(stmt: psqlite3_stmt; iCol: Integer): sqlite3_int64; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_int64' {$ENDIF};
  function sqlite3_column_text(stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_text' {$ENDIF};
  function sqlite3_column_text16(stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_text16' {$ENDIF};
  function sqlite3_column_value(stmt: psqlite3_stmt; iCol: Integer): psqlite3_value; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_column_value' {$ENDIF};

  function sqlite3_blob_open(db: psqlite3; zDb: PUtf8; zTable: PUtf8; zColumn: PUtf8; iRow: sqlite3_int64; flags: Integer; var ppBlob: psqlite3_blob): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_blob_open' {$ENDIF};
  function sqlite3_blob_close(blob: psqlite3_blob): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_blob_close' {$ENDIF};
  function sqlite3_blob_bytes(blob: psqlite3_blob): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_blob_bytes' {$ENDIF};
  function sqlite3_blob_read(blob: psqlite3_blob; Z: Pointer; N: Integer; iOffset: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_blob_read' {$ENDIF};
  function sqlite3_blob_write(blob: psqlite3_blob; Z: Pointer; N: Integer; iOffset: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_blob_write' {$ENDIF};

  function sqlite3_create_function(db: psqlite3; zFunctionName: PByte; nArg: Integer; eTextRep: Integer; pApp: Pointer; xFunc: Tsqlite3_func_callback; xStep: Tsqlite3_step_callback; xFinal: Tsqlite3_final_callback): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_create_function' {$ENDIF};
  function sqlite3_create_function16(db: psqlite3; zFunctionName: PByte; nArg: Integer; eTextRep: Integer; pApp: Pointer; xFunc: Tsqlite3_func_callback; xStep: Tsqlite3_step_callback; xFinal: Tsqlite3_final_callback): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_create_function16' {$ENDIF};
  function sqlite3_user_data(context: psqlite3_context): Pointer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_user_data' {$ENDIF};
  function sqlite3_aggregate_context(context: psqlite3_context; nBytes: Integer): Pointer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_aggregate_context' {$ENDIF};
  function sqlite3_context_db_handle(context: psqlite3_context): psqlite3; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_context_db_handle' {$ENDIF};
  function sqlite3_get_auxdata(context: psqlite3_context; N: Integer): Pointer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_get_auxdata' {$ENDIF};
  procedure sqlite3_set_auxdata(context: psqlite3_context; N: Integer; data: Pointer; destr: Tsqlite3_destroy_callback); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_set_auxdata' {$ENDIF};

  function sqlite3_auto_extension(xEntryPoint: Pointer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_auto_extension' {$ENDIF};
  procedure sqlite3_reset_auto_extension(); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_reset_auto_extension' {$ENDIF};
  function sqlite3_enable_load_extension(db: psqlite3; onoff: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_enable_load_extension' {$ENDIF};
  function sqlite3_load_extension(db: psqlite3; zFile, zProc: PByte; var pzErrMsg: PByte): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_load_extension' {$ENDIF};

  function sqlite3_create_module(db: psqlite3; zName: PUtf8; module: psqlite3_module; userdata: Pointer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_create_module' {$ENDIF};
  function sqlite3_create_module_v2(db: psqlite3; zName: PUtf8; module: psqlite3_module; userdata: Pointer; destr: Tsqlite3_destroy_callback): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_create_module_v2' {$ENDIF};
  function sqlite3_declare_vtab(db: psqlite3; zCreateTable: PUtf8): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_declare_vtab' {$ENDIF};
  function sqlite3_overload_function(db: psqlite3; zFuncName: PUtf8; nArg: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_overload_function' {$ENDIF};

  function sqlite3_value_blob(value: psqlite3_value): Pointer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_value_blob' {$ENDIF};
  function sqlite3_value_bytes(value: psqlite3_value): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_value_bytes' {$ENDIF};
  function sqlite3_value_bytes16(value: psqlite3_value): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_value_bytes16' {$ENDIF};
  function sqlite3_value_double(value: psqlite3_value): Double; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_value_double' {$ENDIF};
  function sqlite3_value_int(value: psqlite3_value): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_value_int' {$ENDIF};
  function sqlite3_value_int64(value: psqlite3_value): sqlite3_int64; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_value_int64' {$ENDIF};
  function sqlite3_value_text(value: psqlite3_value): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_value_text' {$ENDIF};
  function sqlite3_value_text16(value: psqlite3_value): PByte; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_value_text16' {$ENDIF};
  function sqlite3_value_type(value: psqlite3_value): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_value_type' {$ENDIF};
  function sqlite3_value_numeric_type(value: psqlite3_value): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_value_numeric_type' {$ENDIF};

  procedure sqlite3_result_blob(context: psqlite3_context; value: Pointer; nBytes: Integer; destr: Tsqlite3_destroy_callback); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_result_blob' {$ENDIF};
  procedure sqlite3_result_blob64(context: psqlite3_context; value: Pointer; nBytes: sqlite3_uint64; destr: Tsqlite3_destroy_callback); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_result_blob64' {$ENDIF};
  procedure sqlite3_result_double(context: psqlite3_context; value: Double); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_result_double' {$ENDIF};
  procedure sqlite3_result_int(context: psqlite3_context; value: Integer); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_result_int' {$ENDIF};
  procedure sqlite3_result_int64(context: psqlite3_context; value: sqlite3_int64); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_result_int64' {$ENDIF};
  procedure sqlite3_result_null(context: psqlite3_context); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_result_null' {$ENDIF};
  procedure sqlite3_result_text(context: psqlite3_context; value: PByte; nBytes: Integer; destr: Tsqlite3_destroy_callback); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_result_text' {$ENDIF};
  procedure sqlite3_result_text16(context: psqlite3_context; value: PByte; nBytes: Integer; destr: Tsqlite3_destroy_callback); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_result_text16' {$ENDIF};
  procedure sqlite3_result_text64(context: psqlite3_context; value: PByte; nBytes: sqlite3_uint64; destr: Tsqlite3_destroy_callback; encoding: Byte); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_result_text64' {$ENDIF};
  procedure sqlite3_result_value(context: psqlite3_context; value: psqlite3_value); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_result_value' {$ENDIF};
  procedure sqlite3_result_zeroblob(context: psqlite3_context; n: Integer); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_result_zeroblob' {$ENDIF};
  procedure sqlite3_result_error(context: psqlite3_context; msg: PByte; nBytes: Integer); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_result_error' {$ENDIF};
  procedure sqlite3_result_error16(context: psqlite3_context; msg: PByte; nBytes: Integer); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_result_error16' {$ENDIF};
  procedure sqlite3_result_error_toobig(context: psqlite3_context); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_result_error_toobig' {$ENDIF};
  procedure sqlite3_result_error_nomem(context: psqlite3_context); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_result_error_nomem' {$ENDIF};
  procedure sqlite3_result_error_code(context: psqlite3_context; code: Integer); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_result_error_code' {$ENDIF};

  function sqlite3_vfs_find(zVfsName: PFDAnsiString): psqlite3_vfs; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_vfs_find' {$ENDIF};
  function sqlite3_vfs_register(pVfs: psqlite3_vfs; makeDflt: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_vfs_register' {$ENDIF};
  function sqlite3_vfs_unregister(pVfs: psqlite3_vfs): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_vfs_unregister' {$ENDIF};

  function sqlite3_key(db: psqlite3; zKey: PByte; nKey: Integer): Integer; cdecl;
  function sqlite3_rekey(db: psqlite3; zKey: PByte; nKey: Integer): Integer; cdecl;
  function sqlite3_key_v2(db: psqlite3; zDbName: PByte; zKey: PByte; nKey: Integer): Integer; cdecl;
  function sqlite3_rekey_v2(db: psqlite3; zDbName: PByte; zKey: PByte; nKey: Integer): Integer; cdecl;
  procedure sqlite3_activate_see(see: PFDAnsiString); cdecl;
  procedure sqlite3CodecGetKey(db: psqlite3; nDb: Integer; zKey: PPointer; nKey: PInteger); cdecl;
  function sqlite3CodecAttach(db: psqlite3; nDb: Integer; zKey: Pointer; nKey: Integer): Integer; cdecl;

  function ad_sqlite3GetCacheSize(db: psqlite3): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3GetCacheSize' {$ENDIF};
  function ad_sqlite3GetEncoding(db: psqlite3): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3GetEncoding' {$ENDIF};
  function ad_sqlite3GetEncryptionMode(db: psqlite3; var name: PFDAnsiString; var len: Integer): Integer;
  function ad_sqlite3GetEncryptionError(db: psqlite3; var error: PFDAnsiString; var len: Integer; var error_code: Integer): Integer;
  procedure ad_sqlite3Error(db: psqlite3; err_code: Integer; zMessage: PByte); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3Error' {$ENDIF};

  function sqlite3_backup_init(pDest: psqlite3; zDestName: PByte; pSource: psqlite3; zSourceName: PByte): psqlite3_backup; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_backup_init' {$ENDIF};
  function sqlite3_backup_step(p: psqlite3_backup; nPage: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_backup_step' {$ENDIF};
  function sqlite3_backup_finish(p: psqlite3_backup): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_backup_finish' {$ENDIF};
  function sqlite3_backup_remaining(p: psqlite3_backup): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_backup_remaining' {$ENDIF};
  function sqlite3_backup_pagecount(p: psqlite3_backup): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_backup_pagecount' {$ENDIF};

  function sqlite3_wal_hook(db: psqlite3; callback: Tsqlite3_wal_callback; userdata: Pointer): Pointer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_wal_hook' {$ENDIF};
  function sqlite3_wal_autocheckpoint(db: psqlite3; N: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_wal_autocheckpoint' {$ENDIF};
  function sqlite3_wal_checkpoint(db: psqlite3; zDb: PFDAnsiString): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_wal_checkpoint' {$ENDIF};

  function sqlite3_rtree_geometry_callback(db: psqlite3; zGeom: PByte; xGeom: Tsqlite3_rtree_xGeom_callback; pContext: Pointer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_rtree_geometry_callback' {$ENDIF};
  function sqlite3_rtree_query_callback(db: psqlite3; zQueryFunc: PByte; xQueryFunc: Tsqlite3_rtree_xQuery_callback; pContext: Pointer; xDestructor: Tsqlite3_rtree_xDelUser_callback): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_rtree_query_callback' {$ENDIF};

  function sqlite3_vtab_config(db: psqlite3; op: Integer): Integer; cdecl varargs; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_vtab_config' {$ENDIF};
  function sqlite3_vtab_on_conflict(db: psqlite3): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_vtab_on_conflict' {$ENDIF};

{$ENDIF}

type
  Tsqlite3_libversion = function (): PFDAnsiString; cdecl;
  Tsqlite3_libversion_number = function (): Integer; cdecl;
  Tsqlite3_compileoption_used = function (zOptName: PFDAnsiString): Integer; cdecl;
  Tsqlite3_compileoption_get = function (N: Integer): PFDAnsiString; cdecl;
  Tsqlite3_enable_shared_cache = function (onoff: Integer): Integer; cdecl;
  Tsqlite3_release_memory = function (amount: Integer): Integer; cdecl;
  Tsqlite3_soft_heap_limit = procedure (amount: Integer); cdecl;
  Tsqlite3_status = function (op: Integer; var pCurrent: Integer;
    var pHighwater: Integer; resetFlag: Integer): Integer; cdecl;
  Tsqlite3_initialize = function (): Integer; cdecl;
  Tsqlite3_shutdown = function (): Integer; cdecl;
  Tsqlite3_malloc = function (n: Integer): Pointer; cdecl;
  Tsqlite3_memory_used = function (): sqlite3_int64; cdecl;
  Tsqlite3_memory_highwater = function (resetFlag: Integer): sqlite3_int64; cdecl;
  Tsqlite3_free = procedure (APtr: Pointer); cdecl;
  Tsqlite3_config = function (option: Integer): Integer; cdecl varargs;

  Tsqlite3_open {.|16} = function (filename: PByte; var ppDb: psqlite3): Integer; cdecl;
  Tsqlite3_open_v2 = function (filename: PUtf8; var ppDb: psqlite3;
    flags: Integer; zVfs: PFDAnsiString): Integer; cdecl;
  Tsqlite3_key = function (db: psqlite3; key: PByte; nKey: Integer): Integer; cdecl;
  Tsqlite3_rekey = function (db: psqlite3; key: PByte; nKey: Integer): Integer; cdecl;
  Tsqlite3_key_v2 = function (db: psqlite3; zDbName: PByte; zKey: PByte; nKey: Integer): Integer; cdecl;
  Tsqlite3_rekey_v2 = function (db: psqlite3; zDbName: PByte; zKey: PByte; nKey: Integer): Integer; cdecl;
  Tsqlite3_close = function (db: psqlite3): Integer; cdecl;
  Tsqlite3_busy_timeout = function (db: psqlite3; ms: Integer): Integer; cdecl;
  Tsqlite3_busy_handler = function (db: psqlite3;
    callback: Tsqlite3_busy_callback; userdata: Pointer): Integer; cdecl;
  Tsqlite3_trace = function (db: psqlite3; xTrace: Tsqlite3_trace_callback;
    userdata: Pointer): Pointer; cdecl;
  Tsqlite3_profile = function (db: psqlite3; xProfile: Tsqlite3_profile_callback;
    userdata: Pointer): Pointer; cdecl;
  Tsqlite3_set_authorizer = function (db: psqlite3; xAuth: Tsqlite3_auth_callback;
    userdata: Pointer): Integer; cdecl;
  Tsqlite3_get_autocommit = function (db: psqlite3): Integer; cdecl;
  Tsqlite3_commit_hook = function (db: psqlite3; callback: Tsqlite3_commit_callback;
    userdata: Pointer): Pointer; cdecl;
  Tsqlite3_rollback_hook = function (db: psqlite3; callback: Tsqlite3_rollback_callback;
    userdata: Pointer): Pointer; cdecl;
  Tsqlite3_table_column_metadata = function (db: psqlite3; zDbName: PUtf8;
    zTableName: PUtf8; zColumnName: PUtf8; var pzDataType: PUtf8;
    var pzCollSeq: PUtf8; var pNotNull: Integer; var pPrimaryKey: Integer;
    var pAutoinc: Integer): Integer; cdecl;
  Tsqlite3_update_hook = function (db: psqlite3; callback: Tsqlite3_update_callback;
    userdata: Pointer): Pointer; cdecl;
  Tsqlite3_limit = function (db: psqlite3; id: Integer; newVal: Integer): Integer; cdecl;
  Tsqlite3_collation_needed {.|16} = function (db: psqlite3; userdata: Pointer;
    callback: Tsqlite3_collation_callback): Integer; cdecl;
  Tsqlite3_create_collation {.|16} = function (db: psqlite3; zName: PByte;
    eTextRep: Integer; userdata: Pointer; callback: Tsqlite3_compare_callback): Integer; cdecl;
  Tsqlite3_progress_handler = procedure (db: psqlite3; nOpers: Integer;
    callback: Tsqlite3_progress_callback; userdata: Pointer); cdecl;

  Tsqlite3_errcode = function (db: psqlite3): Integer; cdecl;
  Tsqlite3_errmsg {.|16} = function (db: psqlite3): PByte; cdecl;
  Tsqlite3_extended_result_codes = function (db: psqlite3; onoff: Integer): Integer; cdecl;
  Tsqlite3_errstr = function (code: Integer): PByte; cdecl;

  Tsqlite3_changes = function (db: psqlite3): Integer; cdecl;
  Tsqlite3_total_changes = function (db: psqlite3): Integer; cdecl;
  Tsqlite3_interrupt = procedure (db: psqlite3); cdecl;
  Tsqlite3_last_insert_rowid = function (db: psqlite3): sqlite3_int64; cdecl;
  Tsqlite3_db_filename = function (db: psqlite3; zDbName: PUtf8): PUtf8; cdecl;
  Tsqlite3_db_readonly = function (db: psqlite3; zDbName: PUtf8): Integer; cdecl;
  Tsqlite3_db_status = function (db: psqlite3; op: Integer; var pCurrent: Integer;
    var pHighwater: Integer; resetFlag: Integer): Integer; cdecl;
  Tsqlite3_exec = function (db: psqlite3; zSql: PByte; callback: Pointer;
    data: Pointer; errmsg: PPByte): Integer; cdecl;

  Tsqlite3_prepare {.|16} {.|_v2} = function (db: psqlite3; zSql: PByte;
    nByte: Integer; var ppStmt: psqlite3_stmt; var pzTail: PByte): Integer; cdecl;
  Tsqlite3_step = function (stmt: psqlite3_stmt): Integer; cdecl;
  Tsqlite3_reset = function (stmt: psqlite3_stmt): Integer; cdecl;
  Tsqlite3_finalize = function (stmt: psqlite3_stmt): Integer; cdecl;
  Tsqlite3_stmt_readonly = function (stmt: psqlite3_stmt): Integer; cdecl;
  Tsqlite3_stmt_busy = function (stmt: psqlite3_stmt): Integer; cdecl;
  Tsqlite3_stmt_status = function (stmt: psqlite3_stmt; op: Integer;
    resetFlg: Integer): Integer; cdecl;

  Tsqlite3_clear_bindings = function (stmt: psqlite3_stmt): Integer; cdecl;
  Tsqlite3_bind_parameter_count = function (stmt: psqlite3_stmt): Integer; cdecl;
  Tsqlite3_bind_parameter_index = function (stmt: psqlite3_stmt; zName: PUtf8): Integer; cdecl;
  Tsqlite3_bind_parameter_name = function (stmt: psqlite3_stmt; index: Integer): PUtf8; cdecl;
  Tsqlite3_bind_blob = function (stmt: psqlite3_stmt; index: Integer; value: Pointer;
    nBytes: Integer; destr: Tsqlite3_destroy_callback): Integer; cdecl;
  Tsqlite3_bind_blob64 = function (stmt: psqlite3_stmt; index: Integer; value: Pointer;
    nBytes: sqlite3_uint64; destr: Tsqlite3_destroy_callback): Integer; cdecl;
  Tsqlite3_bind_double = function (stmt: psqlite3_stmt; index: Integer;
    value: double): Integer; cdecl;
  Tsqlite3_bind_int = function (stmt: psqlite3_stmt; index: Integer;
    value: Integer): Integer; cdecl;
  Tsqlite3_bind_int64 = function (stmt: psqlite3_stmt; index: Integer;
    value: sqlite3_int64): Integer; cdecl;
  Tsqlite3_bind_null = function (stmt: psqlite3_stmt; index: Integer): Integer; cdecl;
  Tsqlite3_bind_text {.|16} = function (stmt: psqlite3_stmt; index: Integer;
    value: PByte; nBytes: Integer; destr: Tsqlite3_destroy_callback): Integer; cdecl;
  Tsqlite3_bind_text64 = function (stmt: psqlite3_stmt; index: Integer;
    value: PByte; nBytes: sqlite3_uint64; destr: Tsqlite3_destroy_callback; encoding: Byte): Integer; cdecl;
  Tsqlite3_bind_value = function (stmt: psqlite3_stmt; index: Integer;
    value: psqlite3_value): Integer; cdecl;
  Tsqlite3_bind_zeroblob = function (stmt: psqlite3_stmt; index: Integer;
    nBytes: Integer): Integer; cdecl;

  Tsqlite3_column_count = function (stmt: psqlite3_stmt): Integer; cdecl;
  Tsqlite3_column_type = function (stmt: psqlite3_stmt; iCol: Integer): Integer; cdecl;
  Tsqlite3_column_name {.|16} = function (stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl;
  Tsqlite3_column_database_name {.|16} = function (stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl;
  Tsqlite3_column_table_name {.|16} = function (stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl;
  Tsqlite3_column_origin_name {.|16} = function (stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl;
  Tsqlite3_column_decltype {.|16} = function (stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl;
  Tsqlite3_column_blob = function (stmt: psqlite3_stmt; iCol: Integer): Pointer; cdecl;
  Tsqlite3_column_bytes {.|16} = function (stmt: psqlite3_stmt; iCol: Integer): Integer; cdecl;
  Tsqlite3_column_double = function (stmt: psqlite3_stmt; iCol: Integer): Double; cdecl;
  Tsqlite3_column_int = function (stmt: psqlite3_stmt; iCol: Integer): Integer; cdecl;
  Tsqlite3_column_int64 = function (stmt: psqlite3_stmt; iCol: Integer): sqlite3_int64; cdecl;
  Tsqlite3_column_text {.|16} = function (stmt: psqlite3_stmt; iCol: Integer): PByte; cdecl;
  Tsqlite3_column_value = function (stmt: psqlite3_stmt; iCol: Integer): psqlite3_value; cdecl;

  Tsqlite3_blob_open = function (db: psqlite3; zDb: PUtf8; zTable: PUtf8;
    zColumn: PUtf8; iRow: sqlite3_int64; flags: Integer;
    var ppBlob: psqlite3_blob): Integer; cdecl;
  Tsqlite3_blob_close = function (blob: psqlite3_blob): Integer; cdecl;
  Tsqlite3_blob_bytes = function (blob: psqlite3_blob): Integer; cdecl;
  Tsqlite3_blob_read = function (blob: psqlite3_blob; Z: Pointer; N: Integer;
    iOffset: Integer): Integer; cdecl;
  Tsqlite3_blob_write = function (blob: psqlite3_blob; Z: Pointer; N: Integer;
    iOffset: Integer): Integer; cdecl;

  Tsqlite3_create_function {.|16} = function (db: psqlite3; zFunctionName: PByte;
    nArg: Integer; eTextRep: Integer; pApp: Pointer; xFunc: Tsqlite3_func_callback;
    xStep: Tsqlite3_step_callback; xFinal: Tsqlite3_final_callback): Integer; cdecl;
  Tsqlite3_user_data = function (context: psqlite3_context): Pointer; cdecl;
  Tsqlite3_aggregate_context = function (context: psqlite3_context;
    nBytes: Integer): Pointer; cdecl;
  Tsqlite3_context_db_handle = function (context: psqlite3_context): psqlite3; cdecl;
  Tsqlite3_get_auxdata = function (context: psqlite3_context; N: Integer): Pointer; cdecl;
  Tsqlite3_set_auxdata = procedure (context: psqlite3_context; N: Integer; data: Pointer;
    destr: Tsqlite3_destroy_callback); cdecl;

  Tsqlite3_auto_extension = function (xEntryPoint: Pointer): Integer; cdecl;
  Tsqlite3_reset_auto_extension = procedure (); cdecl;
  Tsqlite3_enable_load_extension = function (db: psqlite3; onoff: Integer): Integer; cdecl;
  Tsqlite3_load_extension = function (db: psqlite3; zFile, zProc: PByte;
    var pzErrMsg: PByte): Integer; cdecl;

  Tsqlite3_create_module = function (db: psqlite3; zName: PUtf8; module: psqlite3_module;
    userdata: Pointer): Integer; cdecl;
  Tsqlite3_create_module_v2 = function (db: psqlite3; zName: PUtf8; module: psqlite3_module;
    userdata: Pointer; destr: Tsqlite3_destroy_callback): Integer; cdecl;
  Tsqlite3_declare_vtab = function (db: psqlite3; zCreateTable: PUtf8): Integer; cdecl;
  Tsqlite3_overload_function = function (db: psqlite3; zFuncName: PUtf8;
    nArg: Integer): Integer; cdecl;

  Tsqlite3_value_blob = function (value: psqlite3_value): Pointer; cdecl;
  Tsqlite3_value_bytes {.|16} = function (value: psqlite3_value): Integer; cdecl;
  Tsqlite3_value_double = function (value: psqlite3_value): Double; cdecl;
  Tsqlite3_value_int = function (value: psqlite3_value): Integer; cdecl;
  Tsqlite3_value_int64 = function (value: psqlite3_value): sqlite3_int64; cdecl;
  Tsqlite3_value_text {.|16} = function (value: psqlite3_value): PByte; cdecl;
  Tsqlite3_value_type = function (value: psqlite3_value): Integer; cdecl;
  Tsqlite3_value_numeric_type = function (value: psqlite3_value): Integer; cdecl;

  Tsqlite3_result_blob = procedure (context: psqlite3_context; value: Pointer;
    nBytes: Integer; destr: Tsqlite3_destroy_callback); cdecl;
  Tsqlite3_result_blob64 = procedure (context: psqlite3_context; value: Pointer;
    nBytes: sqlite3_uint64; destr: Tsqlite3_destroy_callback); cdecl;
  Tsqlite3_result_double = procedure (context: psqlite3_context; value: Double); cdecl;
  Tsqlite3_result_int = procedure (context: psqlite3_context; value: Integer); cdecl;
  Tsqlite3_result_int64 = procedure (context: psqlite3_context; value: sqlite3_int64); cdecl;
  Tsqlite3_result_null = procedure (context: psqlite3_context); cdecl;
  Tsqlite3_result_text {.|16} = procedure (context: psqlite3_context; value: PByte;
    nBytes: Integer; destr: Tsqlite3_destroy_callback); cdecl;
  Tsqlite3_result_text64 = procedure (context: psqlite3_context; value: PByte;
    nBytes: sqlite3_uint64; destr: Tsqlite3_destroy_callback; encoding: Byte); cdecl;
  Tsqlite3_result_value = procedure (context: psqlite3_context; value: psqlite3_value); cdecl;
  Tsqlite3_result_zeroblob = procedure (context: psqlite3_context; n: Integer); cdecl;
  Tsqlite3_result_error {.|16} = procedure (context: psqlite3_context; msg: PByte;
    nBytes: Integer); cdecl;
  Tsqlite3_result_error_toobig = procedure (context: psqlite3_context); cdecl;
  Tsqlite3_result_error_nomem = procedure (context: psqlite3_context); cdecl;
  Tsqlite3_result_error_code = procedure (context: psqlite3_context; code: Integer); cdecl;

  Tsqlite3_vfs_find = function(zVfsName: PFDAnsiString): psqlite3_vfs; cdecl;
  Tsqlite3_vfs_register = function(pVfs: psqlite3_vfs; makeDflt: Integer): Integer; cdecl;
  Tsqlite3_vfs_unregister = function(pVfs: psqlite3_vfs): Integer; cdecl;

  Tsqlite3_backup_init = function (pDest: psqlite3; zDestName: PByte; pSource: psqlite3;
    zSourceName: PByte): psqlite3_backup; cdecl;
  Tsqlite3_backup_step = function (p: psqlite3_backup; nPage: Integer): Integer; cdecl;
  Tsqlite3_backup_finish = function (p: psqlite3_backup): Integer; cdecl;
  Tsqlite3_backup_remaining = function (p: psqlite3_backup): Integer; cdecl;
  Tsqlite3_backup_pagecount = function (p: psqlite3_backup): Integer; cdecl;

  Tsqlite3_wal_hook = function (db: psqlite3; callback: Tsqlite3_wal_callback; userdata: Pointer): Pointer; cdecl;
  Tsqlite3_wal_autocheckpoint = function (db: psqlite3; N: Integer): Integer; cdecl;
  Tsqlite3_wal_checkpoint = function (db: psqlite3; zDb: PFDAnsiString): Integer; cdecl;

  Tsqlite3_rtree_geometry_callback = function (db: psqlite3; zGeom: PByte;
    xGeom: Tsqlite3_rtree_xGeom_callback; pContext: Pointer): Integer; cdecl;
  Tsqlite3_rtree_query_callback = function (db: psqlite3; zQueryFunc: PByte;
    xQueryFunc: Tsqlite3_rtree_xQuery_callback; pContext: Pointer;
    xDestructor: Tsqlite3_rtree_xDelUser_callback): Integer; cdecl;

  Tsqlite3_vtab_config = function(db: psqlite3; op: Integer): Integer; cdecl varargs;
  Tsqlite3_vtab_on_conflict = function(db: psqlite3): Integer; cdecl;
  Tsqlite3_activate_see = procedure(see: PFDAnsiString); cdecl;
  Tsqlite3CodecGetKey = procedure(db: psqlite3; nDb: Integer; zKey: PPointer; nKey: PInteger); cdecl;
  Tsqlite3CodecAttach = function(db: psqlite3; nDb: Integer; zKey: Pointer; nKey: Integer): Integer; cdecl;

                 
                                
                       
                   
                     
                     
                
                     
                   

                   
  

                                    
                                           

                       
                
                 
                 
                
                    
                                          
                                                        
                                     
                                
                                               
                                           
                          
                                                     
                                                      
                                                      
                                                    
                                                 
                                 
                                      
                                      
                            
                                   
                                 
                                     
                                     
                                        
 

implementation

{$IFDEF FireDAC_SQLITE_STATIC}
uses
  System.SysUtils, System.Classes, System.SyncObjs,
  {$IFDEF MSWINDOWS}
  System.Win.Crtl,
  {$ENDIF}
  FireDAC.Stan.Util, FireDAC.Stan.Cipher;

// FireDAC SQLite driver encryption feature is derived from the following work:
(*
** SQLCipher
** crypto.c developed by Stephen Lombardo (Zetetic LLC)
** sjlombardo at zetetic dot net
** http://zetetic.net
**
** Copyright (c) 2009, ZETETIC LLC
** All rights reserved.
**
** Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**     * Redistributions of source code must retain the above copyright
**       notice, this list of conditions and the following disclaimer.
**     * Redistributions in binary form must reproduce the above copyright
**       notice, this list of conditions and the following disclaimer in the
**       documentation and/or other materials provided with the distribution.
**     * Neither the name of the ZETETIC LLC nor the
**       names of its contributors may be used to endorse or promote products
**       derived from this software without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY ZETETIC LLC ''AS IS'' AND ANY
** EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
** DISCLAIMED. IN NO EVENT SHALL ZETETIC LLC BE LIABLE FOR ANY
** DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
** SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
*)
type
  // Internal structures
  _pPgHdr = Pointer;
  _pPager = Pointer;
  _pBtree = Pointer;
  _pDb = ^_Db;
  _Pgno = Cardinal;

  _Db = record
    zName: PFDAnsiString;
    pBt: _pBtree;
    // .................
  end;

  {-----------------------------------------------------------------------------}
  // Codec private structures
  PSQLiteCipherCtx = ^TSQLiteCipherCtx;
  TSQLiteCipherCtx = record
    derive_key: Boolean;
    evp_cipher_class: TFDCipherClass;
    evp_cipher: TFDCipher;
    key_sz: Integer;
    pass_sz: Integer;
    iv_sz: Integer;
    name_sz: Integer;
    pass: PFDAnsiString;
  end;

  PSQLiteCodecCtx = ^TSQLiteCodecCtx;
  TSQLiteCodecCtx = record
    page_size: Integer;
    kdf_salt_sz: Integer;
    buffer_sz: Integer;
    kdf_salt: PByte;
    buffer: PByte;
    read_ctx: PSQLiteCipherCtx;
    write_ctx: PSQLiteCipherCtx;
    mode_rekey: Boolean;
    error: PFDAnsiString;
    error_sz: Integer;
    error_code: Integer;
  end;

  TSQLiteCodecProc = function (iCtx: Pointer; data: Pointer; pgn: _Pgno; mode: Integer): Pointer; cdecl;
  TSQLiteCodecSizeChngProc = procedure (iCtx: Pointer; pageSize: Integer; nReserve: Integer); cdecl;
  TSQLiteCodecFreeProc = procedure (iCtx: Pointer); cdecl;

const
  // Adjust SQLite file header size to make the payload size equal to factor
  // of C_FD_AESBlockSize. SQLite is using only <= 70 bytes in the header.
  C_SQLiteFileHeaderSize = 100 - 100 mod C_FD_AESBlockSize;
  C_SQLiteWellKnownSize = 16;
  C_SQLiteMaxKeyLength = 32;
  C_SQLiteDefaultKeyLength = 32;
  C_SQLiteDefaultCipherClass: TFDCipherClass = TFDCipherAES;
  C_SQLiteReservedSpace = 32;

var
  GCodecAttachLock: TCriticalSection;

// sqlite3.obj must export these entries
procedure sqlite3_randomness(N: Integer; P: Pointer); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'sqlite3_randomness' {$ENDIF};
procedure ad_sqlite3PagerSetCodec(pPager: _pPager; xCodec: TSQLiteCodecProc; xCodecSizeChng: TSQLiteCodecSizeChngProc; xCodecFree: TSQLiteCodecFreeProc; pCodec: Pointer); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3PagerSetCodec' {$ENDIF};
function ad_sqlite3BtreeGetPageSize(p: _pBtree): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3BtreeGetPageSize' {$ENDIF};
function ad_sqlite3BtreeSetPageSize(p: _pBtree; pageSize: Integer; nReserve: Integer; iFix: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3BtreeSetPageSize' {$ENDIF};
function ad_sqlite3BtreeGetPager(p: _pBtree): _pPager; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3BtreeGetPager' {$ENDIF};
function ad_sqlite3BtreeBeginTrans(p: _pBtree; wrflag: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3BtreeBeginTrans' {$ENDIF};
function ad_sqlite3BtreeCommit(p: _pBtree): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3BtreeCommit' {$ENDIF};
function ad_sqlite3BtreeRollback(p: _pBtree): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3BtreeRollback' {$ENDIF};
function ad_sqlite3PagerGetFd(pPager: _pPager): psqlite3_file; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3PagerGetFd' {$ENDIF};
function ad_sqlite3PagerGetCodec(pPager: _pPager): Pointer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3PagerGetCodec' {$ENDIF};
procedure ad_sqlite3PagerPagecount(pPager: _pPager; var pnPage: Integer); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3PagerPagecount' {$ENDIF};
function ad_sqlite3PagerIsMjPgno(pPager: _pPager; pgn: _Pgno): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3PagerIsMjPgno' {$ENDIF};
function ad_sqlite3PagerGet(pPager: _pPager; pgn: _Pgno; var ppPage: _pPgHdr): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3PagerGet' {$ENDIF};
function ad_sqlite3PagerWrite(pPage: _pPgHdr): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3PagerWrite' {$ENDIF};
procedure ad_sqlite3PagerUnref(pPage: _pPgHdr); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3PagerUnref' {$ENDIF};
function ad_sqlite3GetBackend(db: psqlite3; nDb: Integer): _pDb; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3GetBackend' {$ENDIF};
procedure ad_sqlite3SetNextPagesize(db: psqlite3; size: Integer); cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3SetNextPagesize' {$ENDIF};
function ad_sqlite3GetFileHeader(): PFDAnsiString; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3GetFileHeader' {$ENDIF};
function ad_sqlite3RunVacuum(db: psqlite3; pDb: _pDb; nReserved: Integer): Integer; cdecl; external {$IFDEF FireDAC_SQLITE_EXTERNAL} C_FD_SQLiteLib name _SLU + 'ad_sqlite3RunVacuum' {$ENDIF};
  {$IFDEF FireDAC_SQLITE_EXTERNAL}
// sqlite3_fd_glue.obj must export this entry
procedure ad_sqlite3SetEncryptionCallbacks(cb_activate_see: Tsqlite3_activate_see; cb_key_v2: Tsqlite3_key_v2; cb_rekey_v2: Tsqlite3_rekey_v2; cb_CodecGetKey: Tsqlite3CodecGetKey; cb_CodecAttach: Tsqlite3CodecAttach); cdecl; external C_FD_SQLiteLib name _SLU + 'ad_sqlite3SetEncryptionCallbacks';
  {$ENDIF}

{-------------------------------------------------------------------------------}
procedure SetCodecError(ctx: PSQLiteCodecCtx; const AMsg: String; AErrorCode: Integer);
var
  sMsg: TFDByteString;
begin
  if ctx^.error <> nil then begin
    FreeMem(ctx^.error, ctx^.error_sz);
    ctx^.error := nil;
    ctx^.error_sz := 0;
    ctx^.error_code := 0;
  end;
  if AMsg <> '' then begin
    sMsg := TFDEncoder.Enco('Cipher: ' + AMsg, ecANSI);
    ctx^.error_sz := TFDEncoder.EncoLength(sMsg, ecANSI);
    GetMem(ctx^.error, ctx^.error_sz);
    Move(PByte(sMsg)^, ctx^.error^, ctx^.error_sz);
    ctx^.error_code := AErrorCode;
  end;
end;

{-------------------------------------------------------------------------------}
function sqlite3Codec(iCtx: Pointer; data: Pointer; pgn: _Pgno; mode: Integer): Pointer; cdecl;
var
  pCtx: PSQLiteCodecCtx;
  iPageSize: Integer;
  iOffset: Integer;
  pData: PByte;

  function KeyDerive(ctx: PSQLiteCodecCtx; c_ctx: PSQLiteCipherCtx): Integer;
  begin
    // if pass is not null
    if (c_ctx^.pass <> nil) and (c_ctx^.pass_sz <> 0) then begin
      if c_ctx^.evp_cipher = nil then
        c_ctx^.evp_cipher := c_ctx^.evp_cipher_class.Create;
      c_ctx^.evp_cipher.Initialize(PByte(c_ctx^.pass), c_ctx^.pass_sz,
        PAESBlock(ctx^.kdf_salt)^, ctx^.kdf_salt_sz, c_ctx^.key_sz * 8);
      Result := SQLITE_OK;
    end
    else begin
      SetCodecError(ctx, 'Password must be not empty', er_FD_SQLitePwdInvalid);
      Result := SQLITE_ERROR;
    end;
  end;

  function Cipher(ctx: PSQLiteCodecCtx; c_ctx: PSQLiteCipherCtx; AEncrypt: Boolean;
    ASize: Integer; ASrc, ADest: Pointer; APageNum: Cardinal): Integer;
  begin
    Result := SQLITE_OK;
    if c_ctx^.key_sz = 0 then
      Move(ASrc^, ADest^, ASize)
    else if not Assigned(c_ctx^.evp_cipher) then begin
      SetCodecError(ctx, 'Algorythm is not assigned', er_FD_SQLiteAlgFailure);
      Result := SQLITE_ERROR;
    end
    else if (ASize mod C_FD_AESBlockSize) <> 0 then begin
      SetCodecError(ctx, 'Invalid block size', er_FD_SQLiteAlgFailure);
      Result := SQLITE_ERROR;
    end
    else
      case c_ctx^.evp_cipher.Process(PAESBlock(ASrc), PAESBlock(ADest),
        ASize div C_FD_AESBlockSize, APageNum, AEncrypt) of
      1:
        begin
          if (pgn = 1) and (mode in [0, 2, 3]) and
             CompareMem(ad_sqlite3GetFileHeader(), data, C_SQLiteWellKnownSize) then
            SetCodecError(ctx, 'DB is not encrypted', er_FD_SQLiteDBUnencrypted)
          else
            SetCodecError(ctx, 'Invalid password is specified or DB is corrupted', er_FD_SQLitePwdInvalid);
          Result := SQLITE_ERROR;
        end;
      2:
        begin
          SetCodecError(ctx, 'Failed to initialize algorythm', er_FD_SQLiteAlgFailure);
          Result := SQLITE_ERROR;
        end;
      3:
        if (pgn = 1) and (mode in [0, 2, 3]) and
           CompareMem(ad_sqlite3GetFileHeader(), data, C_SQLiteWellKnownSize) then begin
          SetCodecError(ctx, 'DB is not encrypted', er_FD_SQLiteDBUnencrypted);
          Result := SQLITE_ERROR;
        end;
      end;
  end;

begin
  pCtx := PSQLiteCodecCtx(iCtx);
  try
    iPageSize := pCtx^.page_size;
    pData := PByte(data);

    // derive key on first use if necessary
    if pCtx^.read_ctx^.derive_key then begin
      KeyDerive(pCtx, pCtx^.read_ctx);
      pCtx^.read_ctx^.derive_key := False;
    end;

    if pCtx^.write_ctx^.derive_key then begin
      KeyDerive(pCtx, pCtx^.write_ctx);
      pCtx^.write_ctx^.derive_key := False;
    end;

    // adjust buffer size is a page size is changed
    if iPageSize > pCtx^.buffer_sz then begin
      pCtx^.buffer_sz := iPageSize;
      ReallocMem(pCtx^.buffer, iPageSize);
    end;

    // adjust starting pointers in data page for header iOffset on first page
    if pgn = 1 then
      iOffset := C_SQLiteFileHeaderSize
    else
      iOffset := 0;

    case mode of
    // decrypt
    0, 2, 3:
      begin
        if Cipher(pCtx, pCtx^.read_ctx, False, iPageSize - iOffset,
                  PFDAnsiString(pData) + iOffset, PFDAnsiString(pCtx^.buffer) + iOffset, pgn) = SQLITE_OK then begin
          // copy file header to the first 16 bytes of the page
          if pgn = 1 then begin
            Move(ad_sqlite3GetFileHeader()^, pCtx^.buffer^, C_SQLiteWellKnownSize);
            Move((PFDAnsiString(pData) + C_SQLiteWellKnownSize)^,
                 (PFDAnsiString(pCtx^.buffer) + C_SQLiteWellKnownSize)^,
                 C_SQLiteFileHeaderSize - C_SQLiteWellKnownSize);
          end;
          // copy buffer data back to pData and return
          Move(pCtx^.buffer^, pData^, iPageSize);
          Result := pData;
        end
        else
          Result := nil;
      end;
    // encrypt
    6, 7:
      begin
        if Cipher(pCtx, pCtx^.write_ctx, True, iPageSize - iOffset,
                  PFDAnsiString(pData) + iOffset, PFDAnsiString(pCtx^.buffer) + iOffset, pgn) = SQLITE_OK then begin
          // copy salt to output buffer
          if pgn = 1 then begin
            if pCtx^.write_ctx^.key_sz = 0 then
              Move(pData^, pCtx^.buffer^, iOffset)
            else begin
              Move(pCtx^.kdf_salt^, pCtx^.buffer^, C_SQLiteWellKnownSize);
              Move((PFDAnsiString(pData) + C_SQLiteWellKnownSize)^,
                   (PFDAnsiString(pCtx^.buffer) + C_SQLiteWellKnownSize)^,
                   C_SQLiteFileHeaderSize - C_SQLiteWellKnownSize);
            end;
          end;
          // return persistent buffer data, pData remains intact
          Result := pCtx^.buffer;
        end
        else
          Result := nil;
      end;
    else
      Result := pData;
    end;
    if Result <> nil then
      SetCodecError(pCtx, '', 0);
  except
    on E: Exception do begin
      SetCodecError(pCtx, E.Message, er_FD_SQLiteAlgFailure);
      Result := nil;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure sqlite3CodecFree(iCtx: Pointer); cdecl;

  procedure FreeCiperCtx(var ApCtx: PSQLiteCipherCtx);
  begin
    if ApCtx = nil then
      Exit;
    if ApCtx^.pass <> nil then
      FreeMem(ApCtx^.pass);
    FDFreeAndNil(ApCtx^.evp_cipher);
    FreeMem(ApCtx);
    ApCtx := nil;
  end;

var
  pCtx: PSQLiteCodecCtx;
begin
  pCtx := PSQLiteCodecCtx(iCtx);
  if pCtx = nil then
    Exit;
  FreeMem(pCtx^.kdf_salt, 0);
  FreeMem(pCtx^.buffer, 0);
  FreeCiperCtx(pCtx^.read_ctx);
  FreeCiperCtx(pCtx^.write_ctx);
  SetCodecError(pCtx, '', 0);
  FreeMem(pCtx);
end;

{-------------------------------------------------------------------------------}
procedure sqlite3CodecSizeChng(iCtx: Pointer; pageSize, nReserve: Integer); cdecl;
var
  pCtx: PSQLiteCodecCtx;
begin
  pCtx := PSQLiteCodecCtx(iCtx);
  if pCtx = nil then
    Exit;
  pCtx^.page_size := pageSize;
end;

{-------------------------------------------------------------------------------}
procedure SetPasswordCtx(ApCtx: PSQLiteCipherCtx; zKey: Pointer; nKey: Integer);
begin
  ApCtx^.pass_sz := nKey;
  ApCtx^.key_sz := 0;
  ApCtx^.iv_sz := 0;
  if ApCtx^.pass <> nil then begin
    FreeMem(ApCtx^.pass, ApCtx^.pass_sz);
    ApCtx^.pass := nil;
  end;
  if nKey <> 0 then begin
    GetMem(ApCtx^.pass, nKey);
    Move(zKey^, ApCtx^.pass^, nKey);
    if not FDCipherParsePassword(zKey, nKey, ApCtx^.evp_cipher_class,
                                 ApCtx^.key_sz, ApCtx^.name_sz) then begin
      ApCtx^.evp_cipher_class := C_SQLiteDefaultCipherClass;
      ApCtx^.key_sz := C_SQLiteDefaultKeyLength;
    end;
    ApCtx^.iv_sz := ApCtx^.evp_cipher_class.ReserveLength;
  end;
  ApCtx^.derive_key := True;
end;

{-------------------------------------------------------------------------------}
function ComparePasswordCtx(ApCtx: PSQLiteCipherCtx; zKey: Pointer; nKey: Integer): Integer;
begin
  Result := FDCompareByteStr(PByte(ApCtx^.pass), PByte(zKey),
    ApCtx^.pass_sz, nKey);
end;

{-------------------------------------------------------------------------------}
function sqlite3CodecAttach(db: psqlite3; nDb: Integer; zKey: Pointer;
  nKey: Integer): Integer; cdecl;

  procedure NewCipherCtx(var ApCtx: PSQLiteCipherCtx);
  begin
    GetMem(ApCtx, SizeOf(TSQLiteCipherCtx));
    FillChar(ApCtx^, SizeOf(TSQLiteCipherCtx), 0);
  end;

var
  pDb: _pDb;
  pCtx: PSQLiteCodecCtx;
  pPager: _pPager;
  fd: psqlite3_file;
  iPageSize: Integer;
begin
  GCodecAttachLock.Acquire;
  try
    try
      pDb := ad_sqlite3GetBackend(db, nDb);
      if pDb^.pBt <> nil then begin
        pPager := ad_sqlite3BtreeGetPager(pDb^.pBt);
        iPageSize := ad_sqlite3BtreeGetPageSize(pDb^.pBt);
        pCtx := ad_sqlite3PagerGetCodec(pPager);

        if pCtx <> nil then
          pCtx^.page_size := iPageSize;
        if (pCtx <> nil) and (pCtx^.read_ctx <> nil) and (pCtx.read_ctx^.key_sz <> 0) then begin
          if ComparePasswordCtx(pCtx.read_ctx, zKey, nKey) <> 0 then begin
            SetCodecError(pCtx, 'Invalid password is specified', er_FD_SQLitePwdInvalid);
            Result := SQLITE_ERROR;
          end
          else
            Result := SQLITE_OK;
          Exit;
        end;
        if (nKey = 0) or (zKey = nil) then begin
          Result := SQLITE_OK;
          Exit;
        end;

        GetMem(pCtx, SizeOf(TSQLiteCodecCtx));
        FillChar(pCtx^, SizeOf(TSQLiteCodecCtx), 0);
        pCtx^.page_size := iPageSize;
        NewCipherCtx(pCtx^.read_ctx);
        NewCipherCtx(pCtx^.write_ctx);

        // pre-allocate a page buffer of PageSize bytes. This will
        // be used as a persistent buffer for encryption and decryption
        // operations to avoid overhead of multiple memory allocations
        pCtx^.buffer_sz := iPageSize;
        GetMem(pCtx^.buffer, iPageSize);

        // allocate space for salt data. Then read the first 16 bytes
        // directly off the database file. This is the salt for the
        // key derivation function. If we get a short read allocate
        // a new random salt value
        pCtx^.kdf_salt_sz := C_SQLiteWellKnownSize;
        GetMem(pCtx^.kdf_salt, pCtx^.kdf_salt_sz);

        // if unable to read the bytes, generate random salt
        fd := ad_sqlite3PagerGetFd(pPager);
        if (fd = nil) or
           (fd^.pMethods^.xRead(fd, pCtx^.kdf_salt, C_SQLiteWellKnownSize, 0) <> SQLITE_OK) then
          sqlite3_randomness(C_SQLiteWellKnownSize, PFDAnsiString(pCtx^.kdf_salt));

        ad_sqlite3PagerSetCodec(pPager, sqlite3Codec, sqlite3CodecSizeChng, sqlite3CodecFree, pCtx);
        SetPasswordCtx(pCtx^.read_ctx, zKey, nKey);
        SetPasswordCtx(pCtx^.write_ctx, zKey, nKey);
        // Do not check result - it will be SQLITE_READONLY for not empty DB
        ad_sqlite3BtreeSetPageSize(pDb^.pBt, iPageSize, pCtx^.read_ctx^.iv_sz, 0);
      end;
      Result := SQLITE_OK;
    except
      on E: Exception do begin
        ad_sqlite3Error(db, SQLITE_ERROR,
          PByte(TFDEncoder.Enco('Cipher: ' + E.Message, ecANSI)));
        Result := SQLITE_ERROR;
      end;
    end;
  finally
    GCodecAttachLock.Release;
  end;
end;

{-------------------------------------------------------------------------------}
function sqlite3_key(db: psqlite3; zKey: PByte; nKey: Integer): Integer; cdecl;
begin
  // attach key if db and zKey are not null and nKey is > 0
  if (db <> nil) and (zKey <> nil) and (nKey > 0) then begin
    // operate only on the main db
    sqlite3CodecAttach(db, 0, zKey, nKey);
    Result := SQLITE_OK;
  end
  else begin
    if db <> nil then
      ad_sqlite3Error(db, SQLITE_ERROR,
        PByte(TFDEncoder.Enco('Cipher: Password must be not empty', ecANSI)));
    Result := SQLITE_ERROR;
  end;
end;

{-------------------------------------------------------------------------------}
function sqlite3_key_v2(db: psqlite3; zDbName: PByte; zKey: PByte; nKey: Integer): Integer; cdecl;
begin
  ad_sqlite3Error(db, SQLITE_ERROR,
    PByte(TFDEncoder.Enco('Cipher: sqlite3_key_v2 is not supported', ecANSI)));
  Result := SQLITE_ERROR;
end;

{-------------------------------------------------------------------------------}
function sqlite3_rekey(db: psqlite3; zKey: PByte; nKey: Integer): Integer; cdecl;
var
  pDb: _pDb;
  pCtx: PSQLiteCodecCtx;
  rc: Integer;
  page_count, pgn: _Pgno;
  pPage: _pPgHdr;
  pPager: _pPager;
begin
  try
    if db <> nil then begin
      pDb := ad_sqlite3GetBackend(db, 0);
      rc := SQLITE_OK;
      if pDb^.pBt <> nil then begin
        pPager := ad_sqlite3BtreeGetPager(pDb^.pBt);
        pCtx := ad_sqlite3PagerGetCodec(pPager);

        // no codec and no encryption requested
        if (pCtx = nil) and ((nKey = 0) or (zKey = nil)) then begin
          Result := SQLITE_OK;
          Exit;
        end;

        if pCtx = nil then begin
          // there was no codec attached to this database, so attach one now with a null password
          sqlite3CodecAttach(db, 0, zKey, nKey);
          pCtx := ad_sqlite3PagerGetCodec(pPager);

          // prepare this setup as if it had already been initialized
          sqlite3_randomness(pCtx^.kdf_salt_sz, pCtx^.kdf_salt);
          pCtx^.read_ctx^.key_sz := 0;
          pCtx^.read_ctx^.pass_sz := 0;
          pCtx^.read_ctx^.iv_sz := 0;
        end;

        SetPasswordCtx(pCtx^.write_ctx, zKey, nKey);
        pCtx^.mode_rekey := True;

        if pCtx^.read_ctx^.iv_sz <> pCtx^.write_ctx^.iv_sz then begin
          rc := ad_sqlite3RunVacuum(db, pDb, pCtx^.write_ctx^.iv_sz);
          if rc <> SQLITE_OK then begin
            ad_sqlite3Error(db, SQLITE_ERROR,
              PByte(TFDEncoder.Enco('Cipher: failed to reserve an envelope space', ecANSI)));
            Result := rc;
            Exit;
          end;
        end;

        // do stuff here to rewrite the database
        // 1. Create a transaction on the database
        // 2. Iterate through each page, reading it and then writing it.
        // 3. If that goes ok then commit and put zKey into read_ctx

        // begin write transaction
        rc := ad_sqlite3BtreeBeginTrans(pDb^.pBt, 1);
        if rc = SQLITE_OK then begin

          ad_sqlite3PagerPagecount(pPager, Integer(page_count));
          // pgno's start at 1 see pager.c:pagerAcquire
          pgn := 1;
          while (rc = SQLITE_OK) and (pgn <= page_count) do begin
            // skip this page (see pager.c:pagerAcquire for reasoning)
            if ad_sqlite3PagerIsMjPgno(pPager, pgn) = 0 then begin
              rc := ad_sqlite3PagerGet(pPager, pgn, pPage);
              // write page see pager_incr_changecounter for example
              if rc = SQLITE_OK then begin
                rc := ad_sqlite3PagerWrite(pPage);
                if rc = SQLITE_OK then
                  ad_sqlite3PagerUnref(pPage);
              end;
            end;
            Inc(pgn);
          end;

          // if commit was successful commit and copy the rekey data to
          // current key, else rollback to release locks
          if rc = SQLITE_OK then begin
            ad_sqlite3SetNextPagesize(db, ad_sqlite3BtreeGetPageSize(pDb^.pBt));
            rc := ad_sqlite3BtreeCommit(pDb^.pBt);
            if rc = SQLITE_OK then
              SetPasswordCtx(pCtx^.read_ctx, zKey, nKey);
          end
          else
            rc := ad_sqlite3BtreeRollback(pDb^.pBt);
        end;

        if rc <> SQLITE_OK then
          ad_sqlite3Error(db, SQLITE_ERROR,
            PByte(TFDEncoder.Enco('Cipher: failed to change the DB password', ecANSI)));

        pCtx^.mode_rekey := False;
      end;
      Result := rc;
    end
    else
      Result := SQLITE_ERROR;
  except
    on E: Exception do begin
      ad_sqlite3Error(db, SQLITE_ERROR,
        PByte(TFDEncoder.Enco('Cipher: ' + E.Message, ecANSI)));
      Result := SQLITE_ERROR;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function sqlite3_rekey_v2(db: psqlite3; zDbName: PByte; zKey: PByte; nKey: Integer): Integer; cdecl;
begin
  ad_sqlite3Error(db, SQLITE_ERROR,
    PByte(TFDEncoder.Enco('Cipher: sqlite3_rekey_v2 is not supported', ecANSI)));
  Result := SQLITE_ERROR;
end;

{-------------------------------------------------------------------------------}
procedure sqlite3_activate_see(see: PFDAnsiString); cdecl;
begin
  // do nothing, security enhancements are always active
end;

{-------------------------------------------------------------------------------}
procedure sqlite3CodecGetKey(db: psqlite3; nDb: Integer; zKey: PPointer;
  nKey: PInteger); cdecl;
var
  pDb: _pDb;
  pPager: _pPager;
  pCtx: PSQLiteCodecCtx;
begin
  pDb := ad_sqlite3GetBackend(db, nDb);
  if pDb^.pBt <> nil then begin
    pPager := ad_sqlite3BtreeGetPager(pDb^.pBt);
    pCtx := ad_sqlite3PagerGetCodec(pPager);
    // if the codec has an attached codec_context user the raw key data
    if pCtx <> nil then begin
      zKey^ := pCtx^.read_ctx^.pass;
      nKey^ := pCtx^.read_ctx^.pass_sz;
    end
    else begin
      zKey^ := nil;
      nKey^ := 0;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function ad_sqlite3GetEncryptionMode(db: psqlite3; var name: PFDAnsiString;
  var len: Integer): Integer;
var
  pDb: _pDb;
  pCtx: PSQLiteCodecCtx;
  pPager: _pPager;
begin
  name := nil;
  len := 0;
  Result := SQLITE_ERROR;
  pDb := ad_sqlite3GetBackend(db, 0);
  if pDb^.pBt <> nil then begin
    pPager := ad_sqlite3BtreeGetPager(pDb^.pBt);
    pCtx := ad_sqlite3PagerGetCodec(pPager);
    if (pCtx <> nil) and (pCtx^.write_ctx <> nil) then begin
      name := FDCipherGetName(pCtx^.write_ctx^.evp_cipher_class, pCtx^.write_ctx^.key_sz);
      if name <> nil then begin
        len := FDAnsiStrLen(name);
        Result := SQLITE_OK;
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function ad_sqlite3GetEncryptionError(db: psqlite3; var error: PFDAnsiString;
  var len: Integer; var error_code: Integer): Integer;
var
  pDb: _pDb;
  pCtx: PSQLiteCodecCtx;
  pPager: _pPager;
begin
  error := nil;
  len := 0;
  error_code := 0;
  Result := SQLITE_OK;
  pDb := ad_sqlite3GetBackend(db, 0);
  if pDb^.pBt <> nil then begin
    pPager := ad_sqlite3BtreeGetPager(pDb^.pBt);
    pCtx := ad_sqlite3PagerGetCodec(pPager);
    if (pCtx <> nil) and (pCtx^.error <> nil) then begin
      error := pCtx^.error;
      len := pCtx^.error_sz;
      error_code := pCtx^.error_code;
      Result := SQLITE_ERROR;
    end;
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
initialization
  SQLITE_STATIC := nil;
  SQLITE_TRANSIENT := Tsqlite3_destroy_callback(Pointer({$IFDEF FireDAC_32} $FFFFFFFF {$ENDIF}
                                                        {$IFDEF FireDAC_64} $FFFFFFFFFFFFFFFF {$ENDIF}));
{$IFDEF FireDAC_SQLITE_STATIC}
  GCodecAttachLock := TCriticalSection.Create;

  {$IFDEF FireDAC_SQLITE_EXTERNAL}
  ad_sqlite3SetEncryptionCallbacks(@sqlite3_activate_see, @sqlite3_key_v2,
    @sqlite3_rekey_v2, @sqlite3CodecGetKey, @sqlite3CodecAttach);
  {$ENDIF}

finalization
  FDFreeAndNil(GCodecAttachLock);
{$ENDIF}

end.
