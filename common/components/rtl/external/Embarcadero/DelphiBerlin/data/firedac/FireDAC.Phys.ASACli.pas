{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{      FireDAC Sybase SQL Anywhere Call Interface       }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$ALIGN OFF}

unit FireDAC.Phys.ASACli;

interface

uses
  FireDAC.Stan.Consts;

type
  // ---------------------------------------------------------------------------
  // constants for return values of DOS executables
  // ---------------------------------------------------------------------------

  an_exit_code = ShortInt;

const
  EXIT_OKAY                = 0;   // everything is okay
  EXIT_FAIL                = 1;   // general failure
  EXIT_BAD_DATA            = 2;   // invalid file format, etc.
  EXIT_FILE_ERROR          = 3;   // file not found, unable to open, etc.
  EXIT_OUT_OF_MEMORY       = 4;   // out of memory
  EXIT_BREAK               = 5;   // terminated by user
  EXIT_COMMUNICATIONS_FAIL = 6;   // failed communications
  EXIT_MISSING_DATABASE    = 7;   // missing required db name
  EXIT_PROTOCOL_MISMATCH   = 8;   // client/server protocol mismatch
  EXIT_UNABLE_TO_CONNECT   = 9;   // unable to connect to db
  EXIT_ENGINE_NOT_RUNNING  = 10;  // database not running
  EXIT_SERVER_NOT_FOUND    = 11;  // server not running
  EXIT_BAD_ENCRYPT_KEY     = 12;	// missing or bad encryption key
  EXIT_DB_VER_NEWER	       = 13;	// server must be upgraded to run db
  EXIT_FILE_INVALID_DB	   = 14;	// file is not a database
  EXIT_LOG_FILE_ERROR	     = 15;	// log file was missing or
  // other log file error
  EXIT_FILE_IN_USE	       = 16;	// file in use
  EXIT_FATAL_ERROR	       = 17;	// fatal error or assertion occurred
  EXIT_MISSING_LICENSE_FILE    = 18;	// missing server license file
  EXIT_BACKGROUND_SYNC_ABORTED = 19;  // background synchronization aborted
                                      // to let higher priority operations proceed
  EXIT_FILE_ACCESS_DENIED  = 20;  // access to database file denied
  EXIT_USAGE 		           = 255; // invalid parameters on command line

const
{$IFDEF POSIX}
  C_SQLAnywhere16Lib = 'libdbodbc16_r' + C_FD_DLLExt;
  C_DBTool = 'libdbtool%d_r' + C_FD_DLLExt;
{$ENDIF}
{$IFDEF MSWINDOWS}
  C_DBTool = 'DBTOOL%d.DLL';
{$ENDIF}
  DB_TOOLS_VERSION_NUMBER	= 12000;

type
{$IFDEF POSIX}
  a_bit_field = Cardinal;
  a_bit_short = Cardinal;
{$ENDIF}
{$IFDEF MSWINDOWS}
  a_bit_field = Byte;
  a_bit_short = Word;
{$ENDIF}
  a_sql_int32 = Integer;
  a_sql_uint32 = Cardinal;
  a_char = Byte;
  Pa_char = ^a_char;

  P_name = ^a_name;
  a_name = record
    next: P_name;
    name: array [0 .. 0] of a_char;
  end;

  MSG_CALLBACK = function (str: Pa_char): ShortInt; stdcall;
  STATUS_CALLBACK = function (code: a_sql_uint32; data: Pointer; length: a_sql_uint32): ShortInt; stdcall;
  MSG_QUEUE_CALLBACK = function (code: a_sql_uint32): ShortInt; stdcall;
  SET_WINDOW_TITLE_CALLBACK = function (str: Pa_char): ShortInt; stdcall;
  SET_TRAY_MESSAGE_CALLBACK = function (str: Pa_char): ShortInt; stdcall;
  SET_PROGRESS_CALLBACK = function (index: a_sql_uint32; max: a_sql_uint32): ShortInt; stdcall;
  USAGE_CALLBACK = function (str: Pa_char): ShortInt; stdcall;
  SPLASH_CALLBACK = function (title, body: Pa_char): ShortInt; stdcall;

  // ---------------------------------------------------------------------------
  // initialization (DBTools) interface
  // ---------------------------------------------------------------------------

  P_dbtools_info = ^a_dbtools_info;
  a_dbtools_info = record
    errorrtn: MSG_CALLBACK;
  end;

  TDBToolsInit = function (ApInfo: P_dbtools_info): ShortInt; stdcall;
  TDBToolsFini = function (ApInfo: P_dbtools_info): ShortInt; stdcall;

  // ---------------------------------------------------------------------------
  // get shared library version
  // ---------------------------------------------------------------------------

  TDBToolsVersion = function: ShortInt; stdcall;

  // ---------------------------------------------------------------------------
  // backup database (DBBACKUP) interface
  // ---------------------------------------------------------------------------
  {
    Example:
    a_backup_db Structure settings for equivalent of following command:
    dbbackup -c "uid=dba;pwd=sql;dbf=d:\db\demo.db" c:\temp

    version		DB_TOOLS_VERSION_NUMBER
    errorrtn		0x0040.... callback_error(char *)
    msgrtn		0x0040.... callback_usage(char *)
    confirmrtn		0x0040.... callback_confirm(char *)
    statusrtn		0x0040.... callback_status(char *)
    output_dir		"c:\\temp"
    connectparms	"uid=dba;pwd=sql;dbf=d:\\db\\demo.db"
    backup_database	1
    backup_logfile	1
  }

  a_chkpt_log_type = (
    BACKUP_CHKPT_LOG_COPY,
    BACKUP_CHKPT_LOG_NOCOPY,
    BACKUP_CHKPT_LOG_RECOVER,
    BACKUP_CHKPT_LOG_AUTO,
    BACKUP_CHKPT_LOG_DEFAULT
  );

const
  CBDB_F1_backup_database  = $01; // dbbackup -d sets TRUE
  CBDB_F1_backup_logfile	 = $02; // dbbackup -t sets TRUE
  CBDB_F1__unused1	       = $04; // (obsolete)
  CBDB_F1_no_confirm	     = $08; // dbbackup -y sets TRUE
  CBDB_F1_quiet		         = $10; // dbbackup -q sets TRUE
  CBDB_F1_rename_log	     = $20; // dbbackup -r sets TRUE
  CBDB_F1_truncate_log	   = $40; // dbbackup -x sets TRUE
  CBDB_F1_rename_local_log = $80; // dbbackup -n sets TRUE
  CBDB_F2_server_backup	   = $01; // dbbackup -s sets TRUE

  CBDB_F3_backup_database  = $0001; // dbbackup -d sets TRUE
  CBDB_F3_backup_logfile	 = $0002; // dbbackup -t sets TRUE
  CBDB_F3_no_confirm	     = $0004; // dbbackup -y sets TRUE
  CBDB_F3_quiet		         = $0008; // dbbackup -q sets TRUE
  CBDB_F3_rename_log	     = $0010; // dbbackup -r sets TRUE
  CBDB_F3_truncate_log	   = $0020; // dbbackup -x sets TRUE
  CBDB_F3_rename_local_log = $0040; // dbbackup -n sets TRUE
  CBDB_F3_server_backup	   = $0080; // dbbackup -s sets TRUE
  CBDB_F3_progress_messages= $0100; // dbbackup -p sets TRUE

type
  P_backup_db = Pointer;
  a_backup_db_v12 = record
    version: Word;	                  // set this to DB_TOOLS_VERSION_NUMBER
    errorrtn: MSG_CALLBACK;
    msgrtn: MSG_CALLBACK;
    confirmrtn: MSG_CALLBACK;
    statusrtn: MSG_CALLBACK;
    output_dir: Pa_char;	            // set this to folder for backup files
    connectparms: Pa_char;	          // connection parameters
    hotlog_filename: Pa_char;         // dbbackup -l sets name
    page_blocksize: a_sql_uint32;     // dbbackup -b sets
    chkpt_log_type: a_char;	          // dbbackup -k sets
    backup_interrupted: a_char;       // backup interrupted if non-zero
    flags1: a_bit_short;              // -> CBDB_F3
  end;

  a_backup_db_v11 = record
    version: Word;	                  // set this to DB_TOOLS_VERSION_NUMBER
    output_dir: Pa_char;	            // set this to folder for backup files
    connectparms: Pa_char;	          // connection parameters
    confirmrtn: MSG_CALLBACK;
    errorrtn: MSG_CALLBACK;
    msgrtn: MSG_CALLBACK;
    statusrtn: MSG_CALLBACK;
    flags1: a_bit_field;              // -> CBDB_F1
    hotlog_filename: Pa_char;         // dbbackup -l sets name
    backup_interrupted: a_char;       // backup interrupted if non-zero
    flags2: a_bit_field;              // -> CBDB_F2
    // Following fields are new with 10.0
    chkpt_log_type: a_chkpt_log_type;	// dbbackup -k sets
    page_blocksize: a_sql_uint32;     // dbbackup -b sets
  end;

  a_backup_db_v10 = record
    version: Word;	                // set this to DB_TOOLS_VERSION_NUMBER
    output_dir: Pa_char;	          // set this to folder for backup files
    connectparms: Pa_char;	        // connection parameters
    _unused0: Pa_char;	            // (obsolete)
    confirmrtn: MSG_CALLBACK;
    errorrtn: MSG_CALLBACK;
    msgrtn: MSG_CALLBACK;
    statusrtn: MSG_CALLBACK;
    flags1: a_bit_field;              // -> CBDB_F1
    hotlog_filename: Pa_char;         // dbbackup -l sets name
    backup_interrupted: a_char;       // backup interrupted if non-zero
    flags2: a_bit_field;              // -> CBDB_F2
    // Following fields are new with 10.0
    chkpt_log_type: a_chkpt_log_type;	// dbbackup -k sets
    page_blocksize: a_sql_uint32;     // dbbackup -b sets
  end;

  a_backup_db_v9 = record
    version: Word;	                // set this to DB_TOOLS_VERSION_NUMBER
    output_dir: Pa_char;	          // set this to folder for backup files
    connectparms: Pa_char;	        // connection parameters
    startline: Pa_char;	            // (NULL for default start line)
    confirmrtn: MSG_CALLBACK;
    errorrtn: MSG_CALLBACK;
    msgrtn: MSG_CALLBACK;
    statusrtn: MSG_CALLBACK;
    flags1: a_bit_field;            // -> CBDB_F1
    hotlog_filename: Pa_char;       // dbbackup -l sets name
    backup_interrupted: a_char;     // backup interrupted if non-zero
  end;

  TDBBackup = function (ApInfo: P_backup_db): ShortInt; stdcall;

  // ---------------------------------------------------------------------------
  // validate the tables of a database (DBVALID)
  // ---------------------------------------------------------------------------

  a_validate_type = (
    VALIDATE_NORMAL,
    VALIDATE_DATA,
    VALIDATE_INDEX,
    VALIDATE_EXPRESS,
    VALIDATE_FULL,
    VALIDATE_CHECKSUM,
    VALIDATE_DATABASE,
    VALIDATE_COMPLETE
  );

const
  CVDB_F1_quiet = $01;
  CVDB_F1_index = $02;

type
  P_validate_db = Pointer;
  a_validate_db_v12 = record
    version: Word;	        // set this to DB_TOOLS_VERSION_NUMBER
    errorrtn: MSG_CALLBACK;
    msgrtn: MSG_CALLBACK;
    statusrtn: MSG_CALLBACK;
    connectparms: Pa_char;	// connection parameters
    tables: p_name;
    _type: a_validate_type;
    flags1: a_bit_field;
  end;

  a_validate_db_v11 = record
    version: Word;	        // set this to DB_TOOLS_VERSION_NUMBER
    connectparms: Pa_char;	// connection parameters
    tables: p_name;
    errorrtn: MSG_CALLBACK;
    msgrtn: MSG_CALLBACK;
    statusrtn: MSG_CALLBACK;
    flags1: a_bit_field;
    _type: a_validate_type;
  end;

  a_validate_db_v10 = record
    version: Word;	        // set this to DB_TOOLS_VERSION_NUMBER
    connectparms: Pa_char;	// connection parameters
    _unused1: Pa_char;	    // (obsolete)
    tables: p_name;
    errorrtn: MSG_CALLBACK;
    msgrtn: MSG_CALLBACK;
    statusrtn: MSG_CALLBACK;
    flags1: a_bit_field;
    _type: a_validate_type;
  end;

  a_validate_db_v9 = record
    version: Word;	        // set this to DB_TOOLS_VERSION_NUMBER
    connectparms: Pa_char;	// connection parameters
    startline: Pa_char;	    // (NULL for default start line)
    tables: p_name;
    errorrtn: MSG_CALLBACK;
    msgrtn: MSG_CALLBACK;
    statusrtn: MSG_CALLBACK;
    flags1: a_bit_field;
    _type: a_validate_type;
  end;

  a_validate_db_v5 = record
    version: Word;	        // set this to DB_TOOLS_VERSION_NUMBER
    connectparms: Pa_char;	// connection parameters
    startline: Pa_char;	    // (NULL for default start line)
    tables: p_name;
    errorrtn: MSG_CALLBACK;
    msgrtn: MSG_CALLBACK;
    statusrtn: MSG_CALLBACK;
    flags1: a_bit_field;
  end;

  TDBValidate = function (ApInfo: P_validate_db): ShortInt; stdcall;

implementation

end.
