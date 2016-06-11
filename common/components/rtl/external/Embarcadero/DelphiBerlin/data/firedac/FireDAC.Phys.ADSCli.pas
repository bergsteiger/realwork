{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{   FireDAC Advantage Database Server Call Interface    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.ADSCli;

interface

uses
  FireDAC.Stan.Consts, FireDAC.Stan.Intf;

const
{$IFDEF MSWINDOWS}
  {$IFDEF FireDAC_32}
  C_ADSDll: String = 'ACE32' + C_FD_DLLExt;
  {$ELSE}
  C_ADSDll: String = 'ACE64' + C_FD_DLLExt;
  {$ENDIF}
{$ENDIF}
{$IFDEF POSIX}
  C_ADSDll: String = 'libace' + C_FD_DLLExt;
{$ENDIF}

type
  UNSIGNED64 = UInt64;
  SIGNED64 = Int64;
  UNSIGNED32 = Cardinal;
  SIGNED32 = Integer;
  UNSIGNED16 = Word;
  SIGNED16 = SmallInt;
  UNSIGNED8 = Byte;
  SIGNED8 = ShortInt;

  PUNSIGNED64 = ^UNSIGNED64;
  PSIGNED64 = ^SIGNED64;
  PUNSIGNED32 = ^UNSIGNED32;
  PSIGNED32 = ^SIGNED32;
  PUNSIGNED16 = ^UNSIGNED16;
  PSIGNED16 = ^SIGNED16;
  PUNSIGNED8 = ^UNSIGNED8;
  PSIGNED8 = ^SIGNED8;

  PPWideChar = ^PWideChar;
  AceChar = SIGNED8;
  PAceChar = ^AceChar;
  AceBinary = Byte;
  PAceBinary = ^AceBinary;

  ADSHANDLE = NativeUInt;
  PADSHANDLE = ^ADSHANDLE;

  TADSTimeStamp = record
    lDate: SIGNED32;
    lTime: SIGNED32;
  end;

const
  // SQL Timeout value
  ADS_DEFAULT_SQL_TIMEOUT = $0000; // Default client SQL timeout.

  // Logical constants
  ADS_FALSE = 0;
  ADS_TRUE = 1;

  // This is for parameters to routines that accept a default setting
  ADS_DEFAULT = 0;

  // character set types
  ADS_ANSI = 1;
  ADS_OEM = 2;
  CZECH_VFP_CI_AS_1250 = 3;
  GENERAL_VFP_CI_AS_1250 = 4;
  HUNGARY_VFP_CI_AS_1250 = 5;
  MACHINE_VFP_BIN_1250 = 6;
  POLISH_VFP_CI_AS_1250 = 7;
  SLOVAK_VFP_CI_AS_1250 = 8;
  MACHINE_VFP_BIN_1251 = 9;
  RUSSIAN_VFP_CI_AS_1251 = 10;
  DUTCH_VFP_CI_AS_1252 = 11;
  GENERAL_VFP_CI_AS_1252 = 12;
  GERMAN_VFP_CI_AS_1252 = 13;
  ICELAND_VFP_CI_AS_1252 = 14;
  MACHINE_VFP_BIN_1252 = 15;
  NORDAN_VFP_CI_AS_1252 = 16;
  SPANISH_VFP_CI_AS_1252 = 17;
  SWEFIN_VFP_CI_AS_1252 = 18;
  UNIQWT_VFP_CS_AS_1252 = 19;
  GREEK_VFP_CI_AS_1253 = 20;
  MACHINE_VFP_BIN_1253 = 21;
  GENERAL_VFP_CI_AS_1254 = 22;
  MACHINE_VFP_BIN_1254 = 23;
  TURKISH_VFP_CI_AS_1254 = 24;
  DUTCH_VFP_CI_AS_437 = 25;
  GENERAL_VFP_CI_AS_437 = 26;
  GERMAN_VFP_CI_AS_437 = 27;
  ICELAND_VFP_CI_AS_437 = 28;
  MACHINE_VFP_BIN_437 = 29;
  NORDAN_VFP_CI_AS_437 = 30;
  SPANISH_VFP_CI_AS_437 = 31;
  SWEFIN_VFP_CI_AS_437 = 32;
  UNIQWT_VFP_CS_AS_437 = 33;
  GENERAL_VFP_CI_AS_620 = 34;
  MACHINE_VFP_BIN_620 = 35;
  POLISH_VFP_CI_AS_620 = 36;
  GREEK_VFP_CI_AS_737 = 37;
  MACHINE_VFP_BIN_737 = 38;
  DUTCH_VFP_CI_AS_850 = 39;
  GENERAL_VFP_CI_AS_850 = 40;
  ICELAND_VFP_CI_AS_850 = 41;
  MACHINE_VFP_BIN_850 = 42;
  NORDAN_VFP_CI_AS_850 = 43;
  SPANISH_VFP_CI_AS_850 = 44;
  SWEFIN_VFP_CI_AS_850 = 45;
  UNIQWT_VFP_CS_AS_850 = 46;
  CZECH_VFP_CI_AS_852 = 47;
  GENERAL_VFP_CI_AS_852 = 48;
  HUNGARY_VFP_CI_AS_852 = 49;
  MACHINE_VFP_BIN_852 = 50;
  POLISH_VFP_CI_AS_852 = 51;
  SLOVAK_VFP_CI_AS_852 = 52;
  GENERAL_VFP_CI_AS_857 = 53;
  MACHINE_VFP_BIN_857 = 54;
  TURKISH_VFP_CI_AS_857 = 55;
  GENERAL_VFP_CI_AS_861 = 56;
  ICELAND_VFP_CI_AS_861 = 57;
  MACHINE_VFP_BIN_861 = 58;
  GENERAL_VFP_CI_AS_865 = 59;
  MACHINE_VFP_BIN_865 = 60;
  NORDAN_VFP_CI_AS_865 = 61;
  SWEFIN_VFP_CI_AS_865 = 62;
  MACHINE_VFP_BIN_866 = 63;
  RUSSIAN_VFP_CI_AS_866 = 64;
  CZECH_VFP_CI_AS_895 = 65;
  GENERAL_VFP_CI_AS_895 = 66;
  MACHINE_VFP_BIN_895 = 67;
  SLOVAK_VFP_CI_AS_895 = 68;
  DANISH_ADS_CS_AS_1252 = 69;
  DUTCH_ADS_CS_AS_1252 = 70;
  ENGL_AMER_ADS_CS_AS_1252 = 71;
  ENGL_CAN_ADS_CS_AS_1252 = 72;
  ENGL_UK_ADS_CS_AS_1252 = 73;
  FINNISH_ADS_CS_AS_1252 = 74;
  FRENCH_ADS_CS_AS_1252 = 75;
  FRENCH_CAN_ADS_CS_AS_1252 = 76;
  GERMAN_ADS_CS_AS_1252 = 77;
  ICELANDIC_ADS_CS_AS_1252 = 78;
  ITALIAN_ADS_CS_AS_1252 = 79;
  NORWEGIAN_ADS_CS_AS_1252 = 80;
  PORTUGUESE_ADS_CS_AS_1252 = 81;
  SPANISH_ADS_CS_AS_1252 = 82;
  SPAN_MOD_ADS_CS_AS_1252 = 83;
  SWEDISH_ADS_CS_AS_1252 = 84;
  RUSSIAN_ADS_CS_AS_1251 = 85;
  ASCII_ADS_CS_AS_1252 = 86;
  TURKISH_ADS_CS_AS_1254 = 87;
  POLISH_ADS_CS_AS_1250 = 88;
  BALTIC_ADS_CS_AS_1257 = 89;
  UKRAINIAN_ADS_CS_AS_1251 = 90;
  DUDEN_DE_ADS_CS_AS_1252 = 91;
  USA_ADS_CS_AS_437 = 92;
  DANISH_ADS_CS_AS_865 = 93;
  DUTCH_ADS_CS_AS_850 = 94;
  FINNISH_ADS_CS_AS_865 = 95;
  FRENCH_ADS_CS_AS_863 = 96;
  GERMAN_ADS_CS_AS_850 = 97;
  GREEK437_ADS_CS_AS_437 = 98;
  GREEK851_ADS_CS_AS_851 = 99;
  ICELD850_ADS_CS_AS_850 = 100;
  ICELD861_ADS_CS_AS_861 = 101;
  ITALIAN_ADS_CS_AS_850 = 102;
  NORWEGN_ADS_CS_AS_865 = 103;
  PORTUGUE_ADS_CS_AS_860 = 104;
  SPANISH_ADS_CS_AS_852 = 105;
  SWEDISH_ADS_CS_AS_865 = 106;
  MAZOVIA_ADS_CS_AS_852 = 107;
  PC_LATIN_ADS_CS_AS_852 = 108;
  ISOLATIN_ADS_CS_AS_850 = 109;
  RUSSIAN_ADS_CS_AS_866 = 110;
  NTXCZ852_ADS_CS_AS_852 = 111;
  NTXCZ895_ADS_CS_AS_895 = 112;
  NTXSL852_ADS_CS_AS_852 = 113;
  NTXSL895_ADS_CS_AS_895 = 114;
  NTXHU852_ADS_CS_AS_852 = 115;
  NTXPL852_ADS_CS_AS_852 = 116;
  TURKISH_ADS_CS_AS_857 = 117;
  BOSNIAN_ADS_CS_AS_775 = 118;

  ADS_MAX_CHAR_SETS = 118;

  // rights checking options
  ADS_CHECKRIGHTS = 1;
  ADS_IGNORERIGHTS = 2;

  // In version 10, the default behavior is changed to never do the rights
  // checking for performance reasons.  The client side existence checks are very
  // expensive and are unnecessary in almost all situations.  If an application
  // requires the old behavior, it can be restored with AdsSetRightsChecking and
  // passing it the appropriate flag below.
  ADS_RESPECT_RIGHTS_CHECKING = $00000001; // pre v10 behavior
  ADS_IGNORE_RIGHTS_CHECKING = $00000002; // post v10 behavior

  // options for connecting to Advantage servers - can be ORed together
  ADS_INC_USERCOUNT = $00000001;
  ADS_STORED_PROC_CONN = $00000002;
  ADS_COMPRESS_ALWAYS = $00000004;
  ADS_COMPRESS_NEVER = $00000008;
  ADS_COMPRESS_INTERNET = $0000000C;
  ADS_REPLICATION_CONNECTION = $00000010;
  ADS_UDP_IP_CONNECTION = $00000020;
  ADS_IPX_CONNECTION = $00000040;
  ADS_TCP_IP_CONNECTION = $00000080;
  ADS_TCP_IP_V6_CONNECTION = $00000100;
  ADS_NOTIFICATION_CONNECTION = $00000200;
  // Reserved                         0x00000400
  // Reserved                         0x00000800
  ADS_TLS_CONNECTION = $00001000;
  // >= v 11
  ADS_CHECK_FREE_TABLE_ACCESS = $00002000;

  // options for opening/create tables - can be ORed together
  ADS_EXCLUSIVE = $00000001;
  ADS_READONLY = $00000002;
  ADS_SHARED = $00000004;
  ADS_CLIPPER_MEMOS = $00000008;
  ADS_TABLE_PERM_READ = $00000010;
  ADS_TABLE_PERM_UPDATE = $00000020;
  ADS_TABLE_PERM_INSERT = $00000040;
  ADS_TABLE_PERM_DELETE = $00000080;
  ADS_REINDEX_ON_COLLATION_MISMATCH = $00000100;
  ADS_IGNORE_COLLATION_MISMATCH = $00000200;
  ADS_FREE_TABLE = $00001000; // Mutually exclusive with ADS_DICTIONARY_BOUND_TABLE
  ADS_TEMP_TABLE = $00002000; // Mutually exclusive with ADS_DICTIONARY_BOUND_TABLE
  ADS_DICTIONARY_BOUND_TABLE = $00004000; // Mutually exclusive with ADS_FREE_TABLE or ADS_TEMP_TABLE
  ADS_CACHE_READS = $20000000; // Enable caching of reads on the table
  ADS_CACHE_WRITES = $40000000; // Enable caching of reads & writes on the table

  // When adding entry in here, make sure the corresponding
  // entry is added in aceunpub.h and ensure that there is no
  // conflict.

  // Options for creating indexes - can be ORed together
  ADS_ASCENDING = $00000000;
  ADS_UNIQUE = $00000001;
  ADS_COMPOUND = $00000002;
  ADS_CUSTOM = $00000004;
  ADS_DESCENDING = $00000008;
  ADS_USER_DEFINED = $00000010;
  // Options specifically for FTS indexes 0020 - 0200
  ADS_FTS_INDEX = $00000020; // This is implied for AdsCreateFTSIndex
  ADS_FTS_FIXED = $00000040; // Do not maintain the index with record updates
  ADS_FTS_CASE_SENSITIVE = $00000080; // Make the index case sensitive
  ADS_FTS_KEEP_SCORE = $00000100; // Track word counts in the index for faster SCORE()
  ADS_FTS_PROTECT_NUMBERS = $00000200; // Don't break numbers on commas and periods

  ADS_NOT_AUTO_OPEN = $00000400; // Don't make this an auto open index in data dictionary
  ADS_CANDIDATE = $00000800; // true unique CDX index (equivalent to ADS_UNIQUE for FDIs)
  ADS_BINARY_INDEX = $00001000; // logical index with a bitmap for data

  // Options concerning the parameters supplied to the AdsCreateFTSIndex 00002000 - 00004000
  ADS_FTS_ENCODE_UTF8 = $00002000;
  ADS_FTS_ENCODE_UTF16 = $00004000;

  // >= v 12
  ADS_ONLINE = $00200000;     // Perform ONLINE create with table open shared

  // Options concerning Unicode string in the indexes 20000000 - 40000000
  ADS_UCHAR_KEY_SHORT = $20000000;
  ADS_UCHAR_KEY_LONG = $40000000;
  ADS_UCHAR_KEY_XLONG = $60000000;

  // Option to force index version
  ADS_ALLOW_MULTIPLE_COLLATION = $0004000;

  // Options for returning string values
  ADS_NONE = $0000;
  ADS_LTRIM = $0001;
  ADS_RTRIM = $0002;
  ADS_TRIM = $0003;
  ADS_GET_UTF8 = $0004;
  ADS_DONT_CHECK_CONV_ERR = $0008;
  // >= v 11
  ADS_GET_FORMAT_ANSI = $0010;
  ADS_GET_FORMAT_WEB = $0030;
  // >= v 12
  ADS_GET_GUID_MIME = $0100;      // MIME ENCODED
  ADS_GET_GUID_FILE = $0200;      // FILE ENCODED
  ADS_GET_GUID_NUMBERS = $0400;   // ONLY NUMBER
  ADS_GET_GUID_REGISTRY = $0800;  // REGISTRY Format - default

  // locking compatibility
  ADS_COMPATIBLE_LOCKING = 0;
  ADS_PROPRIETARY_LOCKING = 1;

  // settings for seeks
  ADS_SOFTSEEK = $0001;
  ADS_HARDSEEK = $0002;
  ADS_SEEKGT = $0004;

  // data types for seeks (and scopes)
  ADS_RAWKEY = 1; // no conversion performed on given data
  ADS_STRINGKEY = 2; // data given as a string
  ADS_DOUBLEKEY = 4; // data is a pointer to 8 byte double
  ADS_WSTRINGKEY = 8; // data given as a UTF16 string

  // Option for AdsBuildRawKey100
  ADS_GET_DEFAULT_KEY_LENGTH = $00000000;
  ADS_GET_PARTIAL_FULL_KEY_LENGTH = $00000001;
  ADS_GET_FULL_KEY_LENGTH = $00000002;
  ADS_GET_PRIMARY_WEIGHT_LENGTH = $00000004;

  // For retrieving scope settings
  ADS_TOP = 1;
  ADS_BOTTOM = 2;

  // for calls that can optionally use filters
  ADS_RESPECTFILTERS = $0001;
  ADS_IGNOREFILTERS = $0002;
  ADS_RESPECTSCOPES = $0003;
  // This value is only used with GetRecordCount:  It can be ORed in with the
  // ignore filter value to force a read from the table header to get the most
  // current record count.
  ADS_REFRESHCOUNT = $0004;

  // Server type constants
  ADS_LOCAL_SERVER = $0001;
  ADS_REMOTE_SERVER = $0002;
  ADS_AIS_SERVER = $0004;

  // ACE Handle types
  ADS_CONNECTION = 1;
  ADS_TABLE = 2;
  ADS_INDEX_ORDER = 3;
  ADS_STATEMENT = 4;
  ADS_CURSOR = 5;
  ADS_DATABASE_CONNECTION = 6;
  // ADS_SYS_ADMIN_CONNECTION = 7   obsolete
  ADS_FTS_INDEX_ORDER = 8;

  // ACE Cursor ReadOnly settings
  ADS_CURSOR_READONLY = 1;
  ADS_CURSOR_READWRITE = 2;

  // ACE Cursor Constrain settings
  ADS_CONSTRAIN = 1;
  ADS_NO_CONSTRAIN = 2;

  // Select Field Read settings
  ADS_READ_ALL_COLUMNS = 1;
  ADS_READ_SELECT_COLUMNS = 2;

  // Data dictionary new contraint property validation options
  ADS_NO_VALIDATE = 0;            // Do not validate records against the new constraint
  ADS_VALIDATE_NO_SAVE = 1;       // Delete record not meeting the constraint from the table, no save
  ADS_VALIDATE_WRITE_FAIL = 2;    // Validate the records against the new constraint and overwrite
                                  // the fail table with records not meeting the constraint.
  ADS_VALIDATE_APPEND_FAIL = 3;   // Validate the records against the new constraint and append
                                  // the failed records into the fail table
  ADS_VALIDATE_RETURN_ERROR = 4;  // Validate the records against the new constraint and return
                                  // error if there is any record not meeting the constraint

  // Possible result values from AdsCompareBookmarks.
  ADS_CMP_LESS = -1;
  ADS_CMP_EQUAL = 0;
  ADS_CMP_GREATER = 1;

  // Property values for the AdsGetConnectionProperty API
  ADS_CONNECTIONPROP_USERNAME = 0;
  ADS_CONNECTIONPROP_PASSWORD = 1;
  ADS_CONNECTIONPROP_PROTOCOL = 2;
  ADS_CONNECTIONPROP_ENCRYPTION_TYPE = 3;
  ADS_CONNECTIONPROP_FIPS_MODE = 4;
  ADS_CONNECTIONPROP_CERTIFICATE_FILE = 5;
  ADS_CONNECTIONPROP_CIPHER_SUITE = 6;
  ADS_CONNECTIONPROP_COMMON_NAME = 7;

  ADS_CONNECTIONPROP_USING_TCP_IP = 1;
  ADS_CONNECTIONPROP_USING_TLC = 5;

  // Options for the AdsGetRecordCRC API
  ADS_CRC_LOCALLY = 1;
  ADS_CRC_IGNOREMEMOPAGES = 2;

  // Options for notification events
  ADS_EVENT_ASYNC = 1;
  ADS_EVENT_WITH_DATA = 2; // Allow data to be passed with this event

  // Options for the AdsCancelUpdate90 API
  ADS_PRESERVE_ERR = $0001;

  // property for AdsGetIntProperty API
  ADS_CODE_PAGE = 1;

  // Success return code
  AE_SUCCESS = 0;

  // Error codes
  AE_ALLOCATION_FAILED = 5001;
  AE_COMM_MISMATCH = 5002;
  AE_DATA_TOO_LONG = 5003;
  AE_FILE_NOT_FOUND = 5004;
  AE_INSUFFICIENT_BUFFER = 5005;
  AE_INVALID_BOOKMARK = 5006;
  AE_INVALID_CALLBACK = 5007;
  AE_INVALID_CENTURY = 5008;
  AE_INVALID_DATEFORMAT = 5009;
  AE_INVALID_DECIMALS = 5010;
  AE_INVALID_EXPRESSION = 5011;
  AE_INVALID_FIELDDEF = 5012;
  AE_INVALID_FILTER_OPTION = 5013;
  AE_INVALID_INDEX_HANDLE = 5014;
  AE_INVALID_INDEX_NAME = 5015;
  AE_INVALID_INDEX_ORDER_NAME = 5016;
  AE_INVALID_INDEX_TYPE = 5017;
  AE_INVALID_HANDLE = 5018;
  AE_INVALID_OPTION = 5019;
  AE_INVALID_PATH = 5020;
  AE_INVALID_POINTER = 5021;
  AE_INVALID_RECORD_NUMBER = 5022;
  AE_INVALID_TABLE_HANDLE = 5023;
  AE_INVALID_CONNECTION_HANDLE = 5024;
  AE_INVALID_TABLETYPE = 5025;
  AE_INVALID_WORKAREA = 5026;
  AE_INVALID_CHARSETTYPE = 5027;
  AE_INVALID_LOCKTYPE = 5028;
  AE_INVALID_RIGHTSOPTION = 5029;
  AE_INVALID_FIELDNUMBER = 5030;
  AE_INVALID_KEY_LENGTH = 5031;
  AE_INVALID_FIELDNAME = 5032;
  AE_NO_DRIVE_CONNECTION = 5033;
  AE_FILE_NOT_ON_SERVER = 5034;
  AE_LOCK_FAILED = 5035;
  AE_NO_CONNECTION = 5036;
  AE_NO_FILTER = 5037;
  AE_NO_SCOPE = 5038;
  AE_NO_TABLE = 5039;
  AE_NO_WORKAREA = 5040;
  AE_NOT_FOUND = 5041;
  AE_NOT_IMPLEMENTED = 5042;
  AE_MAX_THREADS_EXCEEDED = 5043;
  AE_START_THREAD_FAIL = 5044;
  AE_TOO_MANY_INDEXES = 5045;
  AE_TOO_MANY_TAGS = 5046;
  AE_TRANS_OUT_OF_SEQUENCE = 5047;
  AE_UNKNOWN_ERRCODE = 5048;
  AE_UNSUPPORTED_COLLATION = 5049;
  AE_NAME_TOO_LONG = 5050;
  AE_DUPLICATE_ALIAS = 5051;
  AE_TABLE_CLOSED_IN_TRANSACTION = 5053;
  AE_PERMISSION_DENIED = 5054;
  AE_STRING_NOT_FOUND = 5055;
  AE_UNKNOWN_CHAR_SET = 5056;
  AE_INVALID_OEM_CHAR_FILE = 5057;
  AE_INVALID_MEMO_BLOCK_SIZE = 5058;
  AE_NO_FILE_FOUND = 5059;
  AE_NO_INF_LOCK = 5060;
  AE_INF_FILE_ERROR = 5061;
  AE_RECORD_NOT_LOCKED = 5062;
  AE_ILLEGAL_COMMAND_DURING_TRANS = 5063;
  AE_TABLE_NOT_SHARED = 5064;
  AE_INDEX_ALREADY_OPEN = 5065;
  AE_INVALID_FIELD_TYPE = 5066;
  AE_TABLE_NOT_EXCLUSIVE = 5067;
  AE_NO_CURRENT_RECORD = 5068;
  AE_PRECISION_LOST = 5069;
  AE_INVALID_DATA_TYPE = 5070;
  AE_DATA_TRUNCATED = 5071;
  AE_TABLE_READONLY = 5072;
  AE_INVALID_RECORD_LENGTH = 5073;
  AE_NO_ERROR_MESSAGE = 5074;
  AE_INDEX_SHARED = 5075;
  AE_INDEX_EXISTS = 5076;
  AE_CYCLIC_RELATION = 5077;
  AE_INVALID_RELATION = 5078;
  AE_INVALID_DAY = 5079;
  AE_INVALID_MONTH = 5080;
  AE_CORRUPT_TABLE = 5081;
  AE_INVALID_BINARY_OFFSET = 5082;
  AE_BINARY_FILE_ERROR = 5083;
  AE_INVALID_DELETED_BYTE_VALUE = 5084;
  AE_NO_PENDING_UPDATE = 5085;
  AE_PENDING_UPDATE = 5086;
  AE_TABLE_NOT_LOCKED = 5087;
  AE_CORRUPT_INDEX = 5088;
  AE_AUTOOPEN_INDEX = 5089;
  AE_SAME_TABLE = 5090;
  AE_INVALID_IMAGE = 5091;
  AE_COLLATION_SEQUENCE_MISMATCH = 5092;
  AE_INVALID_INDEX_ORDER = 5093;
  AE_TABLE_CACHED = 5094;
  AE_INVALID_DATE = 5095;
  AE_ENCRYPTION_NOT_ENABLED = 5096;
  AE_INVALID_PASSWORD = 5097;
  AE_TABLE_ENCRYPTED = 5098;
  AE_SERVER_MISMATCH = 5099;
  AE_INVALID_USERNAME = 5100;
  AE_INVALID_VALUE = 5101;
  AE_INVALID_CONTINUE = 5102;
  AE_UNRECOGNIZED_VERSION = 5103;
  AE_RECORD_ENCRYPTED = 5104;
  AE_UNRECOGNIZED_ENCRYPTION = 5105;
  AE_INVALID_SQLSTATEMENT_HANDLE = 5106;
  AE_INVALID_SQLCURSOR_HANDLE = 5107;
  AE_NOT_PREPARED = 5108;
  AE_CURSOR_NOT_CLOSED = 5109;
  AE_INVALID_SQL_PARAM_NUMBER = 5110;
  AE_INVALID_SQL_PARAM_NAME = 5111;
  AE_INVALID_COLUMN_NUMBER = 5112;
  AE_INVALID_COLUMN_NAME = 5113;
  AE_INVALID_READONLY_OPTION = 5114;
  AE_IS_CURSOR_HANDLE = 5115;
  AE_INDEX_EXPR_NOT_FOUND = 5116;
  AE_NOT_DML = 5117;
  AE_INVALID_CONSTRAIN_TYPE = 5118;
  AE_INVALID_CURSORHANDLE = 5119;
  AE_OBSOLETE_FUNCTION = 5120;
  AE_TADSDATASET_GENERAL = 5121;
  AE_UDF_OVERWROTE_BUFFER = 5122;
  AE_INDEX_UDF_NOT_SET = 5123;
  AE_CONCURRENT_PROBLEM = 5124;
  AE_INVALID_DICTIONARY_HANDLE = 5125;
  AE_INVALID_PROPERTY_ID = 5126;
  AE_INVALID_PROPERTY = 5127;
  AE_DICTIONARY_ALREADY_EXISTS = 5128;
  AE_INVALID_FIND_HANDLE = 5129;
  AE_DD_REQUEST_NOT_COMPLETED = 5130;
  AE_INVALID_OBJECT_ID = 5131;
  AE_INVALID_OBJECT_NAME = 5132;
  AE_INVALID_PROPERTY_LENGTH = 5133;
  AE_INVALID_KEY_OPTIONS = 5134;
  AE_CONSTRAINT_VALIDATION_ERROR = 5135;
  AE_INVALID_OBJECT_TYPE = 5136;
  AE_NO_OBJECT_FOUND = 5137;
  AE_PROPERTY_NOT_SET = 5138;
  AE_NO_PRIMARY_KEY_EXISTS = 5139;
  AE_LOCAL_CONN_DISABLED = 5140;
  AE_RI_RESTRICT = 5141;
  AE_RI_CASCADE = 5142;
  AE_RI_FAILED = 5143;
  AE_RI_CORRUPTED = 5144;
  AE_RI_UNDO_FAILED = 5145;
  AE_RI_RULE_EXISTS = 5146;
  AE_COLUMN_CANNOT_BE_NULL = 5147;
  AE_MIN_CONSTRAINT_VIOLATION = 5148;
  AE_MAX_CONSTRAINT_VIOLATION = 5149;
  AE_RECORD_CONSTRAINT_VIOLATION = 5150;
  AE_CANNOT_DELETE_TEMP_INDEX = 5151;
  AE_RESTRUCTURE_FAILED = 5152;
  AE_INVALID_STATEMENT = 5153;
  AE_STORED_PROCEDURE_FAILED = 5154;
  AE_INVALID_DICTIONARY_FILE = 5155;
  AE_NOT_MEMBER_OF_GROUP = 5156;
  AE_ALREADY_MEMBER_OF_GROUP = 5157;
  AE_INVALID_OBJECT_RIGHT = 5158;
  AE_INVALID_OBJECT_PERMISSION = 5158;     // Note that this is same as above. The word
                                           // permission is more commonly used.
  AE_CANNOT_OPEN_DATABASE_TABLE = 5159;
  AE_INVALID_CONSTRAINT = 5160;
  AE_NOT_ADMINISTRATOR = 5161;
  AE_NO_TABLE_ENCRYPTION_PASSWORD = 5162;
  AE_TABLE_NOT_ENCRYPTED = 5163;
  AE_INVALID_ENCRYPTION_VERSION = 5164;
  AE_NO_STORED_PROC_EXEC_RIGHTS = 5165;
  AE_DD_UNSUPPORTED_DEPLOYMENT = 5166;
  AE_INFO_AUTO_CREATION_OCCURRED = 5168;
  AE_INFO_COPY_MADE_BY_CLIENT = 5169;
  AE_DATABASE_REQUIRES_NEW_SERVER = 5170;
  AE_COLUMN_PERMISSION_DENIED = 5171;
  AE_DATABASE_REQUIRES_NEW_CLIENT = 5172;
  AE_INVALID_LINK_NUMBER = 5173;
  AE_LINK_ACTIVATION_FAILED = 5174;
  AE_INDEX_COLLATION_MISMATCH = 5175;
  AE_ILLEGAL_USER_OPERATION = 5176;
  AE_TRIGGER_FAILED = 5177;
  AE_NO_ASA_FUNCTION_FOUND = 5178;
  AE_VALUE_OVERFLOW = 5179;
  AE_UNRECOGNIZED_FTS_VERSION = 5180;
  AE_TRIG_CREATION_FAILED = 5181;
  AE_MEMTABLE_SIZE_EXCEEDED = 5182;
  AE_OUTDATED_CLIENT_VERSION = 5183;
  AE_FREE_TABLE = 5184;
  AE_LOCAL_CONN_RESTRICTED = 5185;
  AE_OLD_RECORD = 5186;
  AE_QUERY_NOT_ACTIVE = 5187;
  AE_KEY_EXCEEDS_PAGE_SIZE = 5188;
  AE_TABLE_FOUND = 5189;
  AE_TABLE_NOT_FOUND = 5190;
  AE_LOCK_OBJECT = 5191;
  AE_INVALID_REPLICATION_IDENT = 5192;
  AE_ILLEGAL_COMMAND_DURING_BACKUP = 5193;
  AE_NO_MEMO_FILE = 5194;
  AE_SUBSCRIPTION_QUEUE_NOT_EMPTY = 5195;
  AE_UNABLE_TO_DISABLE_TRIGGERS = 5196;
  AE_UNABLE_TO_ENABLE_TRIGGERS = 5197;
  AE_BACKUP = 5198;
  AE_FREETABLEFAILED = 5199;
  AE_BLURRY_SNAPSHOT = 5200;
  AE_INVALID_VERTICAL_FILTER = 5201;
  AE_INVALID_USE_OF_HANDLE_IN_AEP = 5202;
  AE_COLLATION_NOT_RECOGNIZED = 5203;
  AE_INVALID_COLLATION = 5204;
  AE_NOT_VFP_NULLABLE_FIELD = 5205;
  AE_NOT_VFP_VARIABLE_FIELD = 5206;
  AE_ILLEGAL_EVENT_COMMAND = 5207;
  AE_KEY_CANNOT_BE_NULL = 5208;
  AE_COLLATIONS_DO_NOT_MATCH = 5209;
  AE_INVALID_APPID = 5210;
  AE_UNICODE_CONVERSION = 5211;
  AE_UNICODE_COLLATION = 5212;
  AE_SERVER_ENUMERATION_ERROR = 5213;
  AE_UNABLE_TO_LOAD_SSL = 5214;
  AE_UNABLE_TO_VERIFY_SIGNATURE = 5215;
  AE_UNABLE_TO_LOAD_SSL_ENTRYPOINT = 5216;
  AE_CRYPTO_ERROR = 5217;
  AE_UNRECOGNIZED_CIPHER = 5218;
  AE_FIPS_MODE_ENCRYPTION = 5219; // FIPS mode encryption violation
  AE_FIPS_REQUIRED = 5220;
  AE_FIPS_NOT_ALLOWED = 5221;
  AE_FIPS_MODE_FAILED = 5222;
  AE_PASSWORD_REQUIRED = 5223; // the additional error info should include details on type of password
  AE_CONNECTION_TIMED_OUT = 5224;
  // >= v 11
  AE_DELTA_SUPPORT_NOT_POSSIBLE = 5225; // Cannot enable web delta functionality
  AE_QUERY_LOGGING_ERROR = 5226;        // the additional error info should include specifics
  // >= v 12
  AE_COMPRESSION_FAILED = 5227;
  AE_INVALID_DATA = 5228;
  AE_ROWVERSION_REQUIRED = 5229;

  // Supported file types
  ADS_DATABASE_TABLE = ADS_DEFAULT;
  ADS_NTX = 1;
  ADS_CDX = 2;
  ADS_ADT = 3;
  ADS_VFP = 4;

  // for retrieving file names of tables
  ADS_BASENAME = 1;
  ADS_BASENAMEANDEXT = 2;
  ADS_FULLPATHNAME = 3;
  ADS_DATADICTIONARY_NAME = 4;
  ADS_TABLE_OPEN_NAME = 5;

  // Advantage Optimized Filter (AOF) optimization levels
  ADS_OPTIMIZED_FULL = 1;
  ADS_OPTIMIZED_PART = 2;
  ADS_OPTIMIZED_NONE = 3;

  // Advantage Optimized Filter (AOF) options
  ADS_DYNAMIC_AOF = $00000000;    // default
  ADS_RESOLVE_IMMEDIATE = $00000001;
  ADS_RESOLVE_DYNAMIC = $00000002;
  ADS_KEYSET_AOF = $00000004;
  ADS_FIXED_AOF = $00000008;
  ADS_KEEP_AOF_PLAN = $00000010;
  ADS_ENCODE_UTF16 = $00002000;   // Used in AdsSetFilter100 options as well
  ADS_ENCODE_UTF8 = $00004000;    // Used in AdsSetFitler100 options as well

  // Advantage Optimized Filter (AOF) customization options
  ADS_AOF_ADD_RECORD = 1;
  ADS_AOF_REMOVE_RECORD = 2;
  ADS_AOF_TOGGLE_RECORD = 3;

  // Stored procedure or trigger type
  ADS_STORED_PROC = $00000001;
  ADS_COMSTORED_PROC = $00000002; // means we know for sure this is a com
                                  // aep. Before 7.1 we couldn't distinguish.
  ADS_SCRIPT_PROC = $00000004;    // Stored procedure written in SQL script

  // Bit mask used by AdsDDAddProcedure to specify that the procedure returns an varying
  // output cursor. Used in the ulInvokeType param.
  // >= v 11
  ADS_PROC_VARYING_OUTPUT = $00001000;  // Stored procedure returns varying output

  // Table (and related file) encryption types when using v10
  ADS_ENCRYPTION_RC4 = 3;         // RC4 Encryption
  ADS_ENCRYPTION_AES128 = 5;      // 128-bit AES in CTR mode, PBKDF2 key derivation
  ADS_ENCRYPTION_AES256 = 6;      // 256-bit AES in CTR mode, PBKDF2 key derivation

  // some maximum values used by the client
  // NOTE:  constants meant for string length exclude space for null terminator
  ADS_MAX_DATEMASK = 12;
  ADS_MAX_ERROR_LEN = 600;
  ADS_MAX_INDEX_EXPR_LEN = 510;   // this is only accurate for index expressions
  ADS_MAX_KEY_LENGTH = 4082;      // maximum key value length.  This is the max key length
                                  // of FDI indexes.  Max CDX key length is 240.  Max
                                  // NTX key length is 256
  ADS_MAX_FIELD_NAME = 128;
  ADS_MAX_DBF_FIELD_NAME = 10;    // maximum length of field name in a DBF
  ADS_MAX_INDEXES = 15;           // physical index files, NOT index orders
  ADS_MAX_PATH = 260;
  ADS_MAX_TABLE_NAME = 255;       // long file name
  ADS_MAX_TAG_NAME = 128;
  ADS_MAX_TAGS = 256;             // maximum for CDX/FDI file
  ADS_MAX_OBJECT_NAME = 200;      // maximum length of DD object name
  ADS_MAX_TABLE_AND_PATH = ADS_MAX_TABLE_NAME + ADS_MAX_PATH;

  // Valid range of page sizes for FDI indexes.  The default page size is 512
  // bytes.  Before using another page size, please read the section titled
  // "Index Page Size" in the Advantage Client Engine help file (ace.hlp)

  ADS_MIN_ADI_PAGESIZE = 512;
  ADS_MAX_ADI_PAGESIZE = 8192;

  // data types
  ADS_TYPE_UNKNOWN = 0;
  ADS_LOGICAL = 1;      // 1 byte logical value
  ADS_NUMERIC = 2;      // DBF character style numeric
  ADS_DATE = 3;         // Date field.  With ADS_NTX, ADS_CDX, and
                        // ADS_VFP< this is an 8 byte field of the form
                        // CCYYMMDD.  With ADS_ADT, it is a 4 byte
                        // Julian date.
  ADS_STRING = 4;       // Character data
  ADS_MEMO = 5;         // Variable length character data

  // the following are extended data types
  ADS_BINARY = 6;       // BLOB - any data
  ADS_IMAGE = 7;        // BLOB - bitmap
  ADS_VARCHAR = 8;      // variable length character field
  ADS_COMPACTDATE = 9;  // DBF date represented with 3 bytes
  ADS_DOUBLE = 10;      // IEEE 8 byte floating point
  ADS_INTEGER = 11;     // IEEE 4 byte signed long integer

  // the following are supported with the FDT format
  ADS_SHORTINT = 12;    // IEEE 2 byte signed short integer
  ADS_TIME = 13;        // 4 byte long integer representing
                        // milliseconds since midnight

  ADS_TIMESTAMP = 14;   // 8 bytes.  High order 4 bytes are a
                        // long integer representing Julian date.
                        // Low order 4 bytes are a long integer
                        // representing milliseconds since
                        // midnight

  ADS_AUTOINC = 15;     // 4 byte auto-increment value
  ADS_RAW = 16;         // Untranslated data
  ADS_CURDOUBLE = 17;   // IEEE 8 byte floating point currency
  ADS_MONEY = 18;       // 8 byte, 4 implied decimal Currency Field
  ADS_LONGINT = 19;     // 8 byte integer. Deprecated. Use ADS_LONGINT instead.
  ADS_LONGLONG = 19;    // 8 byte integer
  ADS_CISTRING = 20;    // CaSe INSensiTIVE character data
  ADS_ROWVERSION = 21;  // 8 byte integer, incremented for every update, unique to entire table
  ADS_MODTIME = 22;     // 8 byte timestamp, updated when record is updated
  ADS_VARCHAR_FOX = 23; // Visual FoxPro varchar field
  ADS_VARBINARY_FOX = 24; // Visual FoxPro varbinary field
  ADS_SYSTEM_FIELD = 25;  // For internal usage
  ADS_NCHAR = 26;       // Unicode Character data
  ADS_NVARCHAR = 27;    // Unpadded Unicode Character data
  ADS_NMEMO = 28;       // Variable Length Unicode Data
  ADS_GUID = 29;        // 16-byte binary data
  ADS_MAX_FIELD_TYPE = 30;

  ADS_FOXGENERAL = 51;  // FoxPro General Field - stores an OLE object
  ADS_FOXPICTURE = 52;  // FoxPro Picture Field

  // supported User Defined Function types to be used with AdsRegisterUDF
  ADS_INDEX_UDF = 1;

  // Constant for AdsMgGetConfigInfo
  ADS_MAX_CFG_PATH = 256;

  // Constants for AdsMgGetServerType
  // Note ADS_MGMT_NETWARE_SERVER remains for backwards compatibility only
  ADS_MGMT_NETWARE_SERVER = 1;
  ADS_MGMT_NETWARE4_OR_OLDER_SERVER = 1;
  ADS_MGMT_NT_SERVER = 2;
  ADS_MGMT_LOCAL_SERVER = 3;
  ADS_MGMT_WIN9X_SERVER = 4;
  ADS_MGMT_NETWARE5_OR_NEWER_SERVER = 5;
  ADS_MGMT_LINUX_SERVER = 6;
  ADS_MGMT_NT_SERVER_64_BIT = 7;
  ADS_MGMT_LINUX_SERVER_64_BIT = 8;

  // Constants for AdsMgGetLockOwner
  ADS_MGMT_NO_LOCK = 1;
  ADS_MGMT_RECORD_LOCK = 2;
  ADS_MGMT_FILE_LOCK = 3;

  // Constants for MgGetInstallInfo
  ADS_REG_OWNER_LEN = 36;
  ADS_REVISION_LEN = 16;
  ADS_INST_DATE_LEN = 16;
  ADS_OEM_CHAR_NAME_LEN = 16;
  ADS_ANSI_CHAR_NAME_LEN = 16;
  ADS_SERIAL_NUM_LEN = 16;

  // Constants for MgGetOpenTables
  ADS_MGMT_MAX_PATH = 260;
  ADS_MGMT_PROPRIETARY_LOCKING = 1;
  ADS_MGMT_CDX_LOCKING = 2;
  ADS_MGMT_NTX_LOCKING = 3;
  ADS_MGMT_ADT_LOCKING = 4;
  ADS_MGMT_COMIX_LOCKING = 5;

  ADS_MAX_USER_NAME = 50;

  ADS_MAX_ADDRESS_SIZE = 30;
  ADS_MAX_MGMT_APPID_SIZE = 70;

  // -------------------------------------------------------------------------
  // Management API structures
const
  // The following Management API values can be freely changed by you to fit
  // your application's needs.
  ADS_LOCK_ARRAY_SIZE = 400;
  ADS_THREAD_ARRAY_SIZE = 50;
  ADS_TABLE_ARRAY_SIZE = 200;
  ADS_INDEX_ARRAY_SIZE = 200;
  ADS_USER_ARRAY_SIZE = 200;

type
  ADS_MGMT_COMM_STATS = packed record
    dPercentCheckSums:   double;     { 0f pkts with checksum failures }
    ulTotalPackets:      UNSIGNED32; { Total packets received }
    ulRcvPktOutOfSeq:    UNSIGNED32; { Receive packets out of sequence }
    ulNotLoggedIn:       UNSIGNED32; { Packet owner not logged in }
    ulRcvReqOutOfSeq:    UNSIGNED32; { Receive requests out of sequence }
    ulCheckSumFailures:  UNSIGNED32; { Checksum failures }
    ulDisconnectedUsers: UNSIGNED32; { Server initiated disconnects }
    ulPartialConnects:   UNSIGNED32; { Removed partial connections }
    ulInvalidPackets:    UNSIGNED32; { Rcvd invalid packets (NT only) }
    ulRecvFromErrors:    UNSIGNED32; { RecvFrom failed (NT only) }
    ulSendToErrors:      UNSIGNED32; { SendTo failed (NT only) }
  end;
  PADS_MGMT_COMM_STATS = ^ADS_MGMT_COMM_STATS;

  ADS_MGMT_CONFIG_PARAMS = packed record
    ulNumConnections:    UNSIGNED32; { number connections }
    ulNumWorkAreas:      UNSIGNED32; { number work areas }
    ulNumTables:         UNSIGNED32; { number tables }
    ulNumIndexes:        UNSIGNED32; { number indexes }
    ulNumLocks:          UNSIGNED32; { number locks }
    ulUserBufferSize:    UNSIGNED32; { user buffer }
    ulStatDumpInterval:  UNSIGNED32; { statistics dump interval }
    ulErrorLogMax:       UNSIGNED32; { max size of error log }
    ulNumTPSHeaderElems: UNSIGNED32; { number TPS header elems }
    ulNumTPSVisibilityElems: UNSIGNED32; { number TPS vis elems }
    ulNumTPSMemoTransElems: UNSIGNED32; { number TPS memo elems }
    usNumRcvECBs:        UNSIGNED16; { number rcv ECBs (NLM only) }
    usNumSendECBs:       UNSIGNED16; { number send ECBs (NLM only) }
    usNumBurstPackets:   UNSIGNED16; { number packets per burst }
    usNumWorkerThreads:  UNSIGNED16; { number worker threads }
    ulSortBuffSize:      UNSIGNED32; { index sort buffer size }
    aucErrorLog:         array[0..ADS_MAX_CFG_PATH - 1] of AceChar; { error log path }
    aucSemaphore:        array[0..ADS_MAX_CFG_PATH - 1] of AceChar; { semaphore file path }
    aucTransaction:      array[0..ADS_MAX_CFG_PATH - 1] of AceChar; { TPS log file path }

    ucReserved3:         UNSIGNED8;  { reserved }
    ucReserved4:         UNSIGNED8;  { reserved }
    usSendIPPort:        UNSIGNED16; { NT Service IP send port # }
    usReceiveIPPort:     UNSIGNED16; { NT Service IP rcv port # }
    ucUseIPProtocol:     UNSIGNED8;  { Win9x only. Which protocol to use }
    ucFlushEveryUpdate:  UNSIGNED8;  { Win9x specific }

    ulGhostTimeout:      UNSIGNED32; { Diconnection time for partial connections }
    ulFlushFrequency:    UNSIGNED32; { For local server only }

    ulKeepAliveTimeOut:  UNSIGNED32; { When not using semaophore files. In milliseconds }
    ucDisplayNWLoginNames: UNSIGNED8;{ Display connections using user names. }
    ucUseSemaphoreFiles: UNSIGNED8;  { Whether or not to use semaphore files }
    ucUseDynamicAOFs:    UNSIGNED8;
    ucUseInternet:       UNSIGNED8;  { 0 if an Internet port is not specified. }

    usInternetPort:      UNSIGNED16; { Internet Port }
    usMaxConnFailures:   UNSIGNED16; { Maximum Internet connection failures allowed. }
    ulInternetKeepAlive: UNSIGNED32; { In Milliseconds }

    usCompressionLevel:  UNSIGNED16; {  Compression option at server.  ADS_COMPRESS_NEVER, }
                                     { ADS_COMPRESS_INTERNET, or ADS_COMPRESS_ALWAYS }
    ulNumQueries:        UNSIGNED32; { number of queries }
    usReceiveSSLPort:    UNSIGNED16; { Port number used for SSL }
  end;
  PADS_MGMT_CONFIG_PARAMS = ^ADS_MGMT_CONFIG_PARAMS;

  ADS_MGMT_CONFIG_MEMORY = packed record
    ulTotalConfigMem:    UNSIGNED32; { Total mem taken by cfg params }
    ulConnectionMem:     UNSIGNED32; { memory taken by connections }
    ulWorkAreaMem:       UNSIGNED32; { memory taken by work areas }
    ulTableMem:          UNSIGNED32; { memory taken by tables }
    ulIndexMem:          UNSIGNED32; { memory taken by indexes }
    ulLockMem:           UNSIGNED32; { memory taken by locks }
    ulUserBufferMem:     UNSIGNED32; { memory taken by user buffer }
    ulTPSHeaderElemMem:  UNSIGNED32; { memory taken by TPS hdr elems }
    ulTPSVisibilityElemMem: UNSIGNED32; { memory taken by TPS vis elems }
    ulTPSMemoTransElemMem: UNSIGNED32; { mem taken by TPS memo elems }
    ulRcvEcbMem:         UNSIGNED32; { mem taken by rcv ECBs (NLM) }
    ulSendEcbMem:        UNSIGNED32; { mem taken by send ECBs (NLM) }
    ulWorkerThreadMem:   UNSIGNED32; { mem taken by worker threads }
    ulQueryMem:          UNSIGNED32; { mem taken by queries }
  end;
  PADS_MGMT_CONFIG_MEMORY = ^ADS_MGMT_CONFIG_MEMORY;

  ADS_MGMT_INSTALL_INFO = packed record
    ulUserOption:        UNSIGNED32; { User option purchased }
    aucRegisteredOwner:  array[0..ADS_REG_OWNER_LEN - 1] of AceChar;     { Registered owner }
    aucVersionStr:       array[0..ADS_REVISION_LEN - 1] of AceChar;      { Advantage version }
    aucInstallDate:      array[0..ADS_INST_DATE_LEN - 1] of AceChar;     { Install date string }
    aucOemCharName:      array[0..ADS_OEM_CHAR_NAME_LEN - 1] of AceChar; { OEM char language }
    aucAnsiCharName:     array[0..ADS_ANSI_CHAR_NAME_LEN - 1] of AceChar;{ ANSI char language }
    aucEvalExpireDate:   array[0..ADS_INST_DATE_LEN - 1] of AceChar;     { Eval expiration date }
    aucSerialNumber:     array[0..ADS_SERIAL_NUM_LEN - 1] of AceChar;    { Serial number string }
    // >= v 11
    ulMaxStatefulUsers:  UNSIGNED32;                                     { How many stateful connections allowed }
    ulMaxStatelessUsers: UNSIGNED32;                                     { How many stateless connections allowed }
  end;
  PADS_MGMT_INSTALL_INFO = ^ADS_MGMT_INSTALL_INFO;

  ADS_MGMT_UPTIME_INFO = packed record
    usDays:    UNSIGNED16; { Number of days server has been up }
    usHours:   UNSIGNED16; { Number of hours server has been up }
    usMinutes: UNSIGNED16; { Number of minutes server has been up }
    usSeconds: UNSIGNED16; { Number of seconds server has been up }
  end;
  PADS_MGMT_UPTIME_INFO = ^ADS_MGMT_UPTIME_INFO;

  ADS_MGMT_USAGE_INFO = packed record
    ulInUse:   UNSIGNED32; { Number of items in use }
    ulMaxUsed: UNSIGNED32; { Max number of items ever used }
    ulRejected:UNSIGNED32; { Number of items rejected }
  end;
  PADS_MGMT_USAGE_INFO = ^ADS_MGMT_USAGE_INFO;

  ADS_MGMT_ACTIVITY_INFO = packed record
    ulOperations:    UNSIGNED32;           { Number operations since started }
    ulLoggedErrors:  UNSIGNED32;           { Number logged errors }
    stUpTime:        ADS_MGMT_UPTIME_INFO; { Length of time ADS has been up }
    stUsers:         ADS_MGMT_USAGE_INFO;  { Users in use, max, rejected }
    stConnections:   ADS_MGMT_USAGE_INFO;  { Conns in use, max, rejected }
    stWorkAreas:     ADS_MGMT_USAGE_INFO;  { WAs in use, max, rejected }
    stTables:        ADS_MGMT_USAGE_INFO;  { Tables in use, max, rejected }
    stIndexes:       ADS_MGMT_USAGE_INFO;  { Indexes in use, max, rejected }
    stLocks:         ADS_MGMT_USAGE_INFO;  { Locks in use, max, rejected }
    stTpsHeaderElems: ADS_MGMT_USAGE_INFO; { TPS header elems in use, max }
    stTpsVisElems:   ADS_MGMT_USAGE_INFO;  { TPS vis elems in use, max }
    stTpsMemoElems:  ADS_MGMT_USAGE_INFO;  { TPS memo elems in use, max }
    stWorkerThreads: ADS_MGMT_USAGE_INFO;  { Worker threads in use, max }
    stQueries:       ADS_MGMT_USAGE_INFO;  { Queries in use, max, rejected }
    // >= v 11
    stStatefulUsers: ADS_MGMT_USAGE_INFO;  { Stateful users in use }
    stStatelessUsers:ADS_MGMT_USAGE_INFO;  { Stateless users in use }
  end;
  PADS_MGMT_ACTIVITY_INFO = ^ADS_MGMT_ACTIVITY_INFO;

  ADS_MGMT_USER_INFO = packed record
    aucUserName:       array[0..ADS_MAX_USER_NAME - 1] of AceChar;   { Name of connected user }
    usConnNumber:      UNSIGNED16;                                   { NetWare conn # (NLM only) }
    aucDictionaryName: array[0..ADS_MAX_USER_NAME - 1] of AceChar;   { Dictionary user name }
    aucAddress:        array[0..ADS_MAX_ADDRESS_SIZE - 1] of AceChar;{ Network address of user }
    aucOSUserLoginName: array[0..ADS_MAX_USER_NAME - 1] of AceChar;  { OS user login name }
    aucTSAddress:      array[0..ADS_MAX_ADDRESS_SIZE - 1] of AceChar;{ Terminal Services client IP Address }
    aucApplicationID:  array[0..ADS_MAX_MGMT_APPID_SIZE - 1] of AceChar; { application id }
    ulAveRequestCost:  UNSIGNED32;                                   { estimated average cost of each server request }
    usReserved1:       UNSIGNED16;                                   { reserved to maintain byte alignment (ace.pas structs are not packed) }
  end;
  PADS_MGMT_USER_INFO = ^ADS_MGMT_USER_INFO;
  ADSMgUserArray = array[0..ADS_USER_ARRAY_SIZE - 1] of ADS_MGMT_USER_INFO;
  PADSMgUserArray = ^ADSMgUserArray;

  ADS_MGMT_TABLE_INFO = packed record
    aucTableName: array[0..ADS_MGMT_MAX_PATH - 1] of AceChar; { Fully qualified table name }
    usLockType:   UNSIGNED16;                                 { Advantage locking mode }
  end;
  PADS_MGMT_TABLE_INFO = ^ADS_MGMT_TABLE_INFO;
  ADSMgTableArray = array[0..ADS_TABLE_ARRAY_SIZE - 1] of ADS_MGMT_TABLE_INFO;
  PADSMgTableArray = ^ADSMgTableArray;

  ADS_MGMT_INDEX_INFO = packed record
    aucIndexName: array[0..ADS_MGMT_MAX_PATH - 1] of AceChar;   { Fully qualified table name }
  end;
  PADS_MGMT_INDEX_INFO = ^ADS_MGMT_INDEX_INFO;
  ADSMgIndexArray = array[0..ADS_INDEX_ARRAY_SIZE - 1] of ADS_MGMT_INDEX_INFO;
  PADSMgIndexArray = ^ADSMgIndexArray;

  ADS_MGMT_RECORD_INFO = packed record
    ulRecordNumber: UNSIGNED32;   { Record number that is locked }
  end;
  PADS_MGMT_RECORD_INFO = ^ADS_MGMT_RECORD_INFO;
  ADSMgLocksArray = array[0..ADS_LOCK_ARRAY_SIZE - 1] of ADS_MGMT_RECORD_INFO;
  PADSMgLocksArray = ^ADSMgLocksArray;

  ADS_MGMT_THREAD_ACTIVITY = packed record
    ulThreadNumber: UNSIGNED32;   { Thread Number }
    usOpCode:       UNSIGNED16;   { Operation in progress }
    aucUserName:    array[0..ADS_MAX_USER_NAME - 1] of AceChar;   { Name of user }
    usConnNumber:   UNSIGNED16;   { NetWare conn num (NLM only) }
    usReserved1:    UNSIGNED16;   { Reserved }
    aucOSUserLoginName: array[0..ADS_MAX_USER_NAME - 1] of AceChar;   { OS user login name }
  end;
  PADS_MGMT_THREAD_ACTIVITY = ^ADS_MGMT_THREAD_ACTIVITY;
  ADSMgThreadsArray = array[0..ADS_THREAD_ARRAY_SIZE - 1] of ADS_MGMT_THREAD_ACTIVITY;
  PADSMgThreadsArray = ^ADSMgThreadsArray;

  // GUID structure
  ADS_GUID_DATA = packed record
    Data1: UNSIGNED32;
    Data2: UNSIGNED16;
    Data3: UNSIGNED16;
    Data4: UNSIGNED64;
  end;

  // -------------------------------------------------------------------------
  // Data dictionary properties related constants and structure
  ADD_FIELD_DESC = packed record
    usFieldType:    UNSIGNED16;
    usFieldLength:  UNSIGNED16;
    usFieldDecimal: UNSIGNED16;
  end;
  PFDD_FIELD_DESC = ^ADD_FIELD_DESC;

const
  ADS_DD_PROPERTY_NOT_AVAIL = $FFFF;
  ADS_DD_MAX_PROPERTY_LEN = $FFFE;
  ADS_DD_MAX_OBJECT_NAME_LEN = 200;
  ADS_DD_MAX_LINK_INFO_SIZE = 2 * ADS_DD_MAX_OBJECT_NAME_LEN + ADS_MAX_PATH + 3;

  ADS_DD_UNKNOWN_OBJECT = 0;
  ADS_DD_TABLE_OBJECT = 1;
  ADS_DD_RELATION_OBJECT = 2;
  ADS_DD_INDEX_FILE_OBJECT = 3;
  ADS_DD_FIELD_OBJECT = 4;
  ADS_DD_COLUMN_OBJECT = 4;
  ADS_DD_INDEX_OBJECT = 5;
  ADS_DD_VIEW_OBJECT = 6;
  ADS_DD_VIEW_OR_TABLE_OBJECT = 7;      // Used in AdsFindFirst/NextTable
  ADS_DD_USER_OBJECT = 8;
  ADS_DD_USER_GROUP_OBJECT = 9;
  ADS_DD_PROCEDURE_OBJECT = 10;
  ADS_DD_DATABASE_OBJECT = 11;
  ADS_DD_LINK_OBJECT = 12;
  ADS_DD_TABLE_VIEW_OR_LINK_OBJECT = 13;// Used in v6.2 AdsFindFirst/NextTable
  ADS_DD_TRIGGER_OBJECT = 14;
  ADS_DD_PUBLICATION_OBJECT = 15;
  ADS_DD_ARTICLE_OBJECT = 16;           // the things (tables) that get published
  ADS_DD_SUBSCRIPTION_OBJECT = 17;      // indicates where a publication goes
  ADS_DD_FUNCTION_OBJECT = 18;          // User defined function
  ADS_DD_PACKAGE_OBJECT = 19;           // function and stored procedure packages
  ADS_DD_QUALIFIED_TRIGGER_OBJ = 20;    // Used in AdsDDFindFirst/NextObject
  ADS_DD_PERMISSION_OBJECT = 21;
  // >= v 12
  ADS_DD_DATABASE_TRIGGER_OBJ = 22;     // Used in AdsDDFindFirst/NextObject

  // Common properties numbers < 100
  ADS_DD_COMMENT = 1;
  ADS_DD_VERSION = 2;
  ADS_DD_USER_DEFINED_PROP = 3;
  ADS_DD_OBJECT_NAME = 4;
  ADS_DD_TRIGGERS_DISABLED = 5;
  ADS_DD_OBJECT_ID = 6;
  ADS_DD_OPTIONS = 7;

  // bit options for ADS_DD_QUERY_VIA_ROOT
  ADS_DD_QVR_OPT_QUERY = $00000001;
  ADS_DD_QVR_OPT_PROCEDURE = $00000002;

  // Database properties between 100 and 199
  ADS_DD_DEFAULT_TABLE_PATH = 100;
  ADS_DD_ADMIN_PASSWORD = 101;
  ADS_DD_TEMP_TABLE_PATH = 102;
  ADS_DD_LOG_IN_REQUIRED = 103;
  ADS_DD_VERIFY_ACCESS_RIGHTS = 104;
  ADS_DD_ENCRYPT_TABLE_PASSWORD = 105;
  ADS_DD_ENCRYPT_NEW_TABLE = 106;
  ADS_DD_ENABLE_INTERNET = 107;
  ADS_DD_INTERNET_SECURITY_LEVEL = 108;
  ADS_DD_MAX_FAILED_ATTEMPTS = 109;
  ADS_DD_ALLOW_ADSSYS_NET_ACCESS = 110;
  ADS_DD_VERSION_MAJOR = 111;           // properties for customer dd version
  ADS_DD_VERSION_MINOR = 112;
  ADS_DD_LOGINS_DISABLED = 113;
  ADS_DD_LOGINS_DISABLED_ERRSTR = 114;
  ADS_DD_FTS_DELIMITERS = 115;
  ADS_DD_FTS_NOISE = 116;
  ADS_DD_FTS_DROP_CHARS = 117;
  ADS_DD_FTS_CONDITIONAL_CHARS = 118;
  ADS_DD_ENCRYPTED = 119;
  ADS_DD_ENCRYPT_INDEXES = 120;
  ADS_DD_QUERY_LOG_TABLE = 121;
  ADS_DD_ENCRYPT_COMMUNICATION = 122;
  ADS_DD_DEFAULT_TABLE_RELATIVE_PATH = 123;
  ADS_DD_TEMP_TABLE_RELATIVE_PATH = 124;
  ADS_DD_DISABLE_DLL_CACHING = 125;
  ADS_DD_DATA_ENCRYPTION_TYPE = 126;
  ADS_DD_FTS_DELIMITERS_W = 127;
  ADS_DD_FTS_NOISE_W = 128;
  ADS_DD_FTS_DROP_CHARS_W = 129;
  ADS_DD_FTS_CONDITIONAL_CHARS_W = 130;
  // >= v 11
  ADS_DD_QUERY_VIA_ROOT = 131;
  // >= v 12
  ADS_DD_ENFORCE_MAX_FAILED_LOGINS = 132;
  ADS_DD_DATABASE_TRIGGER_TYPES = 133;    // for internal use

  // Table properties between 200 and 299
  ADS_DD_TABLE_VALIDATION_EXPR = 200;
  ADS_DD_TABLE_VALIDATION_MSG = 201;
  ADS_DD_TABLE_PRIMARY_KEY = 202;
  ADS_DD_TABLE_AUTO_CREATE = 203;
  ADS_DD_TABLE_TYPE = 204;
  ADS_DD_TABLE_PATH = 205;
  ADS_DD_TABLE_FIELD_COUNT = 206;
  ADS_DD_TABLE_RI_GRAPH = 207;
  ADS_DD_TABLE_OBJ_ID = 208;
  ADS_DD_TABLE_RI_XY = 209;
  ADS_DD_TABLE_IS_RI_PARENT = 210;
  ADS_DD_TABLE_RELATIVE_PATH = 211;
  ADS_DD_TABLE_CHAR_TYPE = 212;
  ADS_DD_TABLE_DEFAULT_INDEX = 213;
  ADS_DD_TABLE_ENCRYPTION = 214;
  ADS_DD_TABLE_MEMO_BLOCK_SIZE = 215;
  ADS_DD_TABLE_PERMISSION_LEVEL = 216;
  ADS_DD_TABLE_TRIGGER_TYPES = 217;
  ADS_DD_TABLE_TRIGGER_OPTIONS = 218;
  ADS_DD_TABLE_CACHING = 219;
  ADS_DD_TABLE_TXN_FREE = 220;
  ADS_DD_TABLE_VALIDATION_EXPR_W = 221;
  // >= v 11
  ADS_DD_TABLE_WEB_DELTA = 222;
  // >= v 12
  ADS_DD_TABLE_CONCURRENCY_ENABLED = 223;   // for OData concurrency control

  // Bit values for the ADS_DD_FIELD_OPTIONS property
  ADS_DD_FIELD_OPT_VFP_BINARY = $00000001;    // field has NOCPTRANS option
  ADS_DD_FIELD_OPT_VFP_NULLABLE = $00000002;  // field can be physicall set to NULL
  // >= v 12
  ADS_DD_FIELD_OPT_COMPRESSED = $00010000;    // Field may be compressed, ADT memo, nmemo and blob

  // Field properties between 300 - 399
  ADS_DD_FIELD_DEFAULT_VALUE = 300;
  ADS_DD_FIELD_CAN_NULL = 301;
  ADS_DD_FIELD_MIN_VALUE = 302;
  ADS_DD_FIELD_MAX_VALUE = 303;
  ADS_DD_FIELD_VALIDATION_MSG = 304;
  ADS_DD_FIELD_DEFINITION = 305;
  ADS_DD_FIELD_TYPE = 306;
  ADS_DD_FIELD_LENGTH = 307;
  ADS_DD_FIELD_DECIMAL = 308;
  ADS_DD_FIELD_NUM = 309;
  ADS_DD_FIELD_OPTIONS = 310;
  ADS_DD_FIELD_DEFAULT_VALUE_W = 311;
  ADS_DD_FIELD_MIN_VALUE_W = 312;
  ADS_DD_FIELD_MAX_VALUE_W = 313;

  // Index tag properties between 400 - 499
  ADS_DD_INDEX_FILE_NAME = 400;
  ADS_DD_INDEX_EXPRESSION = 401;
  ADS_DD_INDEX_CONDITION = 402;
  ADS_DD_INDEX_OPTIONS = 403;
  ADS_DD_INDEX_KEY_LENGTH = 404;
  ADS_DD_INDEX_KEY_TYPE = 405;
  ADS_DD_INDEX_FTS_MIN_LENGTH = 406;
  ADS_DD_INDEX_FTS_DELIMITERS = 407;
  ADS_DD_INDEX_FTS_NOISE = 408;
  ADS_DD_INDEX_FTS_DROP_CHARS = 409;
  ADS_DD_INDEX_FTS_CONDITIONAL_CHARS = 410;
  ADS_DD_INDEX_COLLATION = 411;
  ADS_DD_INDEX_FTS_DELIMITERS_W = 412;
  ADS_DD_INDEX_FTS_NOISE_W = 413;
  ADS_DD_INDEX_FTS_DROP_CHARS_W = 414;
  ADS_DD_INDEX_FTS_CONDITIONAL_CHARS_W = 415;

  // RI properties between 500-599
  ADS_DD_RI_PARENT_GRAPH = 500;
  ADS_DD_RI_PRIMARY_TABLE = 501;
  ADS_DD_RI_PRIMARY_INDEX = 502;
  ADS_DD_RI_FOREIGN_TABLE = 503;
  ADS_DD_RI_FOREIGN_INDEX = 504;
  ADS_DD_RI_UPDATERULE = 505;
  ADS_DD_RI_DELETERULE = 506;
  ADS_DD_RI_NO_PKEY_ERROR = 507;
  ADS_DD_RI_CASCADE_ERROR = 508;

  // User properties between 600-699
  ADS_DD_USER_GROUP_NAME = 600;

  // View properties between 700-749
  ADS_DD_VIEW_STMT = 700;
  ADS_DD_VIEW_STMT_LEN = 701;
  ADS_DD_VIEW_TRIGGER_TYPES = 702;
  ADS_DD_VIEW_TRIGGER_OPTIONS = 703;
  ADS_DD_VIEW_STMT_W = 704;

  // Stored procedure properties 800-899
  ADS_DD_PROC_INPUT = 800;
  ADS_DD_PROC_OUTPUT = 801;
  ADS_DD_PROC_DLL_NAME = 802;
  ADS_DD_PROC_DLL_FUNCTION_NAME = 803;
  ADS_DD_PROC_INVOKE_OPTION = 804;
  ADS_DD_PROC_SCRIPT = 805;
  ADS_DD_PROC_SCRIPT_W = 806;

  // Index file properties 900-999
  ADS_DD_INDEX_FILE_PATH = 900;
  ADS_DD_INDEX_FILE_PAGESIZE = 901;
  ADS_DD_INDEX_FILE_RELATIVE_PATH = 902;
  ADS_DD_INDEX_FILE_TYPE = 903;

  // Object rights properties 1001 - 1099 .  They can be used
  // with either user or user group objects.
  ADS_DD_TABLES_RIGHTS = 1001;
  ADS_DD_VIEWS_RIGHTS = 1002;
  ADS_DD_PROCS_RIGHTS = 1003;
  ADS_DD_OBJECTS_RIGHTS = 1004;
  ADS_DD_FREE_TABLES_RIGHTS = 1005;

  // User Properties 1101 - 1199
  ADS_DD_USER_PASSWORD = 1101;
  ADS_DD_USER_GROUP_MEMBERSHIP = 1102;
  ADS_DD_USER_BAD_LOGINS = 1103;
  // >= v 11
  ADS_DD_CURRENT_USER_PASSWORD = 1104;
  ADS_DD_REQUIRE_OLD_PASSWORD = 1105;

  // User group Properties 1201 - 1299
  // None at this moment.

  // Link properties 1301 - 1399
  ADS_DD_LINK_PATH = 1300;
  ADS_DD_LINK_OPTIONS = 1301;
  ADS_DD_LINK_USERNAME = 1302;
  ADS_DD_LINK_RELATIVE_PATH = 1303;

  // Trigger properties 1400 - 1499
  ADS_DD_TRIG_TABLEID = 1400;
  ADS_DD_TRIG_EVENT_TYPE = 1401;
  ADS_DD_TRIG_TRIGGER_TYPE = 1402;
  ADS_DD_TRIG_CONTAINER_TYPE = 1403;
  ADS_DD_TRIG_CONTAINER = 1404;
  ADS_DD_TRIG_FUNCTION_NAME = 1405;
  ADS_DD_TRIG_PRIORITY = 1406;
  ADS_DD_TRIG_OPTIONS = 1407;
  ADS_DD_TRIG_TABLENAME = 1408;
  ADS_DD_TRIG_CONTAINER_W = 1409;

  // Publication properties 1500 - 1599
  ADS_DD_PUBLICATION_OPTIONS = 1500;

  // Publication article properties 1600 - 1699
  ADS_DD_ARTICLE_FILTER = 1600;             // horizontal filter (optional)
  ADS_DD_ARTICLE_ID_COLUMNS = 1601;         // columns that identify the target row
  ADS_DD_ARTICLE_ID_COLUMN_NUMBERS = 1602;  // array of the field numbers
  ADS_DD_ARTICLE_FILTER_SHORT = 1603;       // short version of the expression
  ADS_DD_ARTICLE_INCLUDE_COLUMNS = 1604;    // Vertical filter (inclusion list)
  ADS_DD_ARTICLE_EXCLUDE_COLUMNS = 1605;    // Vertical filter (exclusion list)
  ADS_DD_ARTICLE_INC_COLUMN_NUMBERS = 1606; // Retrieve column nums to replicate
  ADS_DD_ARTICLE_INSERT_MERGE = 1607;       // Use SQL MERGE with INSERTs
  ADS_DD_ARTICLE_UPDATE_MERGE = 1608;       // Use SQL MERGE with UPDATEs
  ADS_DD_ARTICLE_FILTER_W = 1609;           // horizontal filter (optional)

  // Subscription article properties 1700 - 1799
  ADS_DD_SUBSCR_PUBLICATION_NAME = 1700;    // Name of the publication (for reading)
  ADS_DD_SUBSCR_TARGET = 1701;              // full path of target database
  ADS_DD_SUBSCR_USERNAME = 1702;            // user name to use to connect to target
  ADS_DD_SUBSCR_PASSWORD = 1703;            // password for connecting
  ADS_DD_SUBSCR_FORWARD = 1704;             // boolean flag:  forward updates that came from a replication?
  ADS_DD_SUBSCR_ENABLED = 1705;             // boolean flag:  Replication enabled on this subscription?
  ADS_DD_SUBSCR_QUEUE_NAME = 1706;          // replication queue
  ADS_DD_SUBSCR_OPTIONS = 1707;             // for future use
  ADS_DD_SUBSCR_QUEUE_NAME_RELATIVE = 1708; // replication queue relative to the DD
  ADS_DD_SUBSCR_PAUSED = 1709;              // boolean flag:  Replication paused on this subscription?
  ADS_DD_SUBSCR_COMM_TCP_IP = 1710;         // boolean flag:  TRUE for TCP/IP communications
  ADS_DD_SUBSCR_COMM_TCP_IP_V6 = 1711;      // boolean flag:  TRUE for TCP/IP V6 communications
  ADS_DD_SUBSCR_COMM_UDP_IP = 1712;         // boolean flag:  TRUE for UDP/IP communications
  ADS_DD_SUBSCR_COMM_IPX = 1713;            // boolean flag:  TRUE for IPX communications
  ADS_DD_SUBSCR_OPTIONS_INTERNAL = 1714;    // internal ID to get ALL options incl COMM types
  ADS_DD_SUBSCR_COMM_TLS = 1715;            // boolean flag:  TRUE for TLS communications
  ADS_DD_SUBSCR_CONNECTION_STR = 1716;      // Free form connection string for new AdsConnect101 API

  // AdsMgKillUser90 Constants
  ADS_PROPERTY_UNSPECIFIED = $0000;
  ADS_DONT_KILL_APPID = $0001;

  ADS_DD_LEVEL_0 = 0;
  ADS_DD_LEVEL_1 = 1;
  ADS_DD_LEVEL_2 = 2;

  // Referential Integrity (RI) update and delete rules
  ADS_DD_RI_CASCADE = 1;
  ADS_DD_RI_RESTRICT = 2;
  ADS_DD_RI_SETNULL = 3;
  ADS_DD_RI_SETDEFAULT = 4;

  // Default Field Value Options
  ADS_DD_DFV_UNKNOWN = 1;
  ADS_DD_DFV_NONE = 2;
  ADS_DD_DFV_VALUES_STORED = 3;

  // Supported permissions in the data dictionary
  ADS_PERMISSION_NONE = $00000000;
  ADS_PERMISSION_READ = $00000001;
  ADS_PERMISSION_UPDATE = $00000002;
  ADS_PERMISSION_EXECUTE = $00000004;
  ADS_PERMISSION_INHERIT = $00000008;
  ADS_PERMISSION_INSERT = $00000010;
  ADS_PERMISSION_DELETE = $00000020;
  ADS_PERMISSION_LINK_ACCESS = $00000040;
  ADS_PERMISSION_CREATE = $00000080;
  ADS_PERMISSION_ALTER = $00000100;
  ADS_PERMISSION_DROP = $00000200;
  ADS_PERMISSION_WITH_GRANT = $80000000;
  ADS_PERMISSION_ALL_WITH_GRANT = $8FFFFFFF;
  ADS_PERMISSION_ALL = $FFFFFFFF;

  // special code that can be used as the input to specify
  // which special permission to retrieve.
  ADS_GET_PERMISSIONS_WITH_GRANT = $8000FFFF;
  ADS_GET_PERMISSIONS_CREATE = $FFFF0080;
  ADS_GET_PERMISSIONS_CREATE_WITH_GRANT = $8FFFFF8F;

  // Link DD options
  ADS_LINK_GLOBAL = $00000001;
  ADS_LINK_AUTH_ACTIVE_USER = $00000002;
  ADS_LINK_PATH_IS_STATIC = $00000004;

  // Trigger event types
  ADS_TRIGEVENT_INSERT = 1;
  ADS_TRIGEVENT_UPDATE = 2;
  ADS_TRIGEVENT_DELETE = 3;

  // Dictionary (system) trigger event types
  // >= v 12
  ADS_TRIGEVENT_OPEN_TABLE = 4;
  ADS_TRIGEVENT_CLOSE_TABLE = 5;
  ADS_TRIGEVENT_CONNECT = 6;
  ADS_TRIGEVENT_DISCONNECT = 7;

  // Trigger types
  ADS_TRIGTYPE_BEFORE = $00000001;
  ADS_TRIGTYPE_INSTEADOF = $00000002;
  ADS_TRIGTYPE_AFTER = $00000004;
  ADS_TRIGTYPE_CONFLICTON = $00000008;

  // Trigger container types
  ADS_TRIG_WIN32DLL = 1;
  ADS_TRIG_COM = 2;
  ADS_TRIG_SCRIPT = 3;

  // Trigger options, if changed or adding more please inspect code
  // in RemoveTriggerFromDictionary
  ADS_TRIGOPTIONS_NO_VALUES = $00000000;
  ADS_TRIGOPTIONS_WANT_VALUES = $00000001;
  ADS_TRIGOPTIONS_WANT_MEMOS_AND_BLOBS = $00000002;
  ADS_TRIGOPTIONS_DEFAULT = $00000003;              // default is to include vals and memos
  ADS_TRIGOPTIONS_NO_TRANSACTION = $00000004;       // don't use implicit transactions

  // Table permission verification levels.
  // level 1 is all columns searchable, even those without permission.
  // level 2 is default. Permission to the column is required to search or filter on a column.
  // level 3 is most restricted. Only static SQL cursor is allowed.
  ADS_DD_TABLE_PERMISSION_LEVEL_1 = 1;
  ADS_DD_TABLE_PERMISSION_LEVEL_2 = 2;
  ADS_DD_TABLE_PERMISSION_LEVEL_3 = 3;

  // AdsDDRenameObject options
  ADS_KEEP_TABLE_FILE_NAME = $00000001;

  // AdsDDCreateArticle options
  ADS_IDENTIFY_BY_PRIMARY = $00000001;
  ADS_IDENTIFY_BY_ALL = $00000002;

  // AdsDDCreateSubscription options
  ADS_SUBSCR_QUEUE_IS_STATIC = $00000001;
  ADS_SUBSCR_AIS_TARGET = $00000002;                // use AIS to connect to target
  ADS_SUBSCR_IGNORE_FAILED_REP = $00000004;         // Delete failed replication updates from the queue
  ADS_SUBSCR_LOG_FAILED_REP_DATA = $00000008;       // if set, show data of failed replication updates in
                                                    // the error log.
  //ADS_UDP_IP_CONNECTION = $00000020               // These connection type constants are stored in the
  //ADS_IPX_CONNECTION = $00000040                  // options of the subscription, so don't use these values
  //ADS_TCP_IP_CONNECTION = $00000080               // for other subscription properties.
  //ADS_TCP_IP_V6_CONNECTION = $00000100

  // AdsGetFieldLength10 options
  ADS_CODEUNIT_LENGTH = ADS_DEFAULT;                // length in code units (characters)
  ADS_BYTE_LENGTH = $00000001;                      // length in bytes
  ADS_BYTE_LENGTH_IN_BUFFER = $00000002;            // physical length of data in bytes in the record buffer

  // Options for AdsFindServers
  ADS_FS_MULTICAST_ONLY = $00000001;          // Only perform multicast step
  ADS_FS_CONNECT_ALL = $00000002;             // Attempt to connect to every address returned
                                              // in order to gather server name

  // Table caching property modes, used with AdsDDSetTableProperty etc.
  ADS_TABLE_CACHE_NONE = $0000;
  ADS_TABLE_CACHE_READS = $0001;
  ADS_TABLE_CACHE_WRITES = $0002;

  // Connection string encryption options as strings.
  ADS_ENCRYPT_STRING_RC4 = 'RC4';
  ADS_ENCRYPT_STRING_AES128 = 'AES128';
  ADS_ENCRYPT_STRING_AES256 = 'AES256';

  // Connection string cipher suite options as strings.
  ADS_CIPHER_SUITE_STRING_RC4 = 'RC4-MD5';
  ADS_CIPHER_SUITE_STRING_AES128 = 'AES128-SHA';
  ADS_CIPHER_SUITE_STRING_AES256 = 'AES256-SHA';

  // System alias which always resolves to the root dictionary
  // defined by ADS_ROOT_DICTIONARY server configuration setting
  ADS_ROOT_DD_ALIAS = '__rootdd';

  // Options for the AdsGetKeyFilter
  ADS_FILTER_FORMAT_ODATA = $00000001;
  ADS_FILTER_ENCODE_UTF8 = $00000002;

type
  // stored procedure functions must be of this type
  TSTORED_PROCEDURE_PTR = function (
    ulConnectionID: UNSIGNED32; // (I) value used to associate a user/connection
                                //     and can be used to track the state
    pucUserName: PUNSIGNED8;    // (I) the user name who invoked this procedure
    pucPassword: PUNSIGNED8;    // (I) the user's password in encrypted form
    pucProcName: PUNSIGNED8;    // (I) the stored procedure name
    ulRecNum: PUNSIGNED32;      // (I) reserved for triggers
    pucTable1: PUNSIGNED8;      // (I) table one.  For Stored Proc this table
                                //     contains all input parameters.  For
                                //     triggers, it contains the original field
                                //     values if the trigger is an OnUpdate or
                                //     OnDelete
    pucTable2: PUNSIGNED8       // (I) table two.  For Stored Proc this table
                                //     is empty and the users function will
                                //     optionally add rows to it as output.
                                //     For triggers, it contains the new field
                                //     values if the trigger is an OnUpdate or
                                //     OnInsert
  ): UNSIGNED32; {$IFDEF WIN32} stdcall; {$ENDIF} {$IFDEF POSIX} cdecl; {$ENDIF}

  TSTARTUP_PROCEDURE_PTR = function (
    ulConnectionID: UNSIGNED32; // (I) value used to associate a user/connection
                                //     and can be used to track the state
    pucUserName: PUNSIGNED8;    // (I) the user name who invoked this procedure
    pucPassword: PUNSIGNED8     // (I) the user's password in encrypted form
  ): UNSIGNED32; {$IFDEF WIN32} stdcall; {$ENDIF} {$IFDEF POSIX} cdecl; {$ENDIF}

  TSHUTDOWN_PROCEDURE_PTR = function (
    ulConnectionID: UNSIGNED32; // (I) value used to associate a user/connection
                                //     and can be used to track the state
    pucUserName: PUNSIGNED8;    // (I) the user name who invoked this procedure
    pucPassword: PUNSIGNED8     // (I) the user's password in encrypted form
  ): UNSIGNED32; {$IFDEF WIN32} stdcall; {$ENDIF} {$IFDEF POSIX} cdecl; {$ENDIF}

  TSTORED_PROCEDURE2_PTR = function (
    ulConnectionID: UNSIGNED32;     // (I) value used to associate a user/connection
                                    //     and can be used to track the state
    hConnection: ADSHANDLE;         // (I) active connection to be used by the procedure
    pulNumRowsAffected: PUNSIGNED32 // (O) the number of rows affected
  ): UNSIGNED32; {$IFDEF WIN32} stdcall; {$ENDIF} {$IFDEF POSIX} cdecl; {$ENDIF}

  TSTARTUP_PROCEDURE2_PTR = function (
    ulConnectionID: UNSIGNED32; // (I) value used to associate a user/connection
                                //     and can be used to track the state
    hConnection: ADSHANDLE      // (I) active connection to be used by the procedure
  ): UNSIGNED32; {$IFDEF WIN32} stdcall; {$ENDIF} {$IFDEF POSIX} cdecl; {$ENDIF}

  TSHUTDOWN_PROCEDURE2_PTR = function (
    ulConnectionID: UNSIGNED32; // (I) value used to associate a user/connection
                                //     and can be used to track the state
    hConnection: ADSHANDLE      // (I) active connection to be used by the procedure
  ): UNSIGNED32; {$IFDEF WIN32} stdcall; {$ENDIF} {$IFDEF POSIX} cdecl; {$ENDIF}

  TTRIGGER_FUNCTION_PTR = function (
    ulConnectionID: UNSIGNED32; // (I) Unique ID identifying the user causing this trig
    hConnection: ADSHANDLE;     // (I) Active ACE connection handle user can perform
                                //     operations on
    pucTriggerName: PUNSIGNED8; // (I) Name of trigger in the dictionary
    pucTableName: PUNSIGNED8;   // (I) Name of the base table that caused the trigger
    ulEventType: UNSIGNED32;    // (I) Flag with event type (insert, update, etc.)
    ulTriggerType: UNSIGNED32;  // (I) Flag with trigger type (before, after, etc.)
    ulRecNo: UNSIGNED32         // (I) Record number of the record being modified
  ): UNSIGNED32; {$IFDEF WIN32} stdcall; {$ENDIF} {$IFDEF POSIX} cdecl; {$ENDIF}

  TGET_INTERFACE_VERSION_PTR = function (
  ): UNSIGNED32; {$IFDEF WIN32} stdcall; {$ENDIF} {$IFDEF POSIX} cdecl; {$ENDIF}


  // This data type defines what type of function to pass to
  // AdsRegisterCallbackFunction().
  TCallbackFunction = function(usPercent: UNSIGNED16; ulCallbackID: UNSIGNED32): UNSIGNED32;
    {$IFDEF WIN32} stdcall; {$ENDIF} {$IFDEF POSIX} cdecl; {$ENDIF}

  TCallbackFunction101 = function(usPercent: UNSIGNED16; qCallbackID: SIGNED64): UNSIGNED32;
    {$IFDEF WIN32} stdcall; {$ENDIF} {$IFDEF POSIX} cdecl; {$ENDIF}

  // This data type defines what type of function to pass to
  // AdsRegisterProgressCallback().
  TProgressCallback = function(usPercent: UNSIGNED16): UNSIGNED32;
    {$IFDEF WIN32} stdcall; {$ENDIF} {$IFDEF POSIX} cdecl; {$ENDIF}

  // This data type defines what type of function to pass to
  // AdsRegisterSQLAbortFunc().
  TSQLAbortFunc = function(): UNSIGNED32;
    {$IFDEF WIN32} stdcall; {$ENDIF} {$IFDEF POSIX} cdecl; {$ENDIF}

  // This data type defines the type of function that AdsRegisterUDF() takes
  // as a parameter.  This should be used to cast the real function, which has
  // different parameters.  See the documentation for AdsRegisterUDF for more
  // information
  TUDFFunc = function(): UNSIGNED32;
    {$IFDEF WIN32} stdcall; {$ENDIF} {$IFDEF POSIX} cdecl; {$ENDIF}

  // This type allows a numeric field value to be passed into functions
  // that expect field names.  If the user prefers to use column number,
  // then calls like this can be made:
  // ulRet = AdsGetDouble( hTable, ADSFIELD( 1 ), &dVal );
  // Where the first column is a numeric value to retrieve.
  ADSFIELD = PAceChar;

  // With data dicitonaries it is possible for a table to have more than
  // fifty index tags.  If you need more than fifty tags you will
  // need to declare a new array with a larger size.
  ADSIndexArray  = array[0..ADS_MAX_TAGS - 1] of ADSHANDLE;
  PADSIndexArray = ^ADSIndexArray;

  TAdsAddCustomKey = function( hIndex: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsAppendRecord = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsApplicationExit = function:UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsAtBOF = function( hTable: ADSHANDLE;
                     pbBof: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsAtEOF = function( hTable: ADSHANDLE;
                     pbEof: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsBeginTransaction = function( hConnect: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsBinaryToFile = function( hTable: ADSHANDLE;
                            pucFldName: PAceChar;
                            pucFileName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCacheOpenCursors = function( usOpen: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCacheOpenTables = function( usOpen: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCacheRecords = function( hTable: ADSHANDLE;
                            usNumRecords: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCancelUpdate = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCancelUpdate90 = function( hTable: ADSHANDLE;
                              ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCheckExistence = function( hConnect: ADSHANDLE;
                              pucFileName: PAceChar;
                              pusOnDisk: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsClearAllScopes = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsClearDefault = function:UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsClearFilter = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsClearRelation = function( hTableParent: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsClearScope = function( hIndex: ADSHANDLE;
                          usScopeOption: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCloneTable = function( hTable: ADSHANDLE;
                          phClone: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCloseAllIndexes = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCloseAllTables = function:UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCloseIndex = function( hIndex: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCloseTable = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCloseCachedTables = function( hConnection: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCommitTransaction = function( hConnect: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsConnect = function( pucServerName: PAceChar;
                       phConnect: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsConnect26 = function( pucServerName: PAceChar;
                         usServerTypes: UNSIGNED16;
                         phConnect: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsConnect60 = function( pucServerPath: PAceChar;
                         usServerTypes: UNSIGNED16;
                         pucUserName: PAceChar;
                         pucPassword: PAceChar;
                         ulOptions: UNSIGNED32;
                         phConnect: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsConnect101 = function( pucConnectString: PAceChar;
                          phConnectionOptions: pADSHANDLE;
                          phConnect: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsClearCachePool = function( pucConnectString: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsReapUnusedConnections = function:UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsConnectionAlive = function( hConnect: ADSHANDLE;
                                 pbConnectionIsAlive: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsContinue = function( hTable: ADSHANDLE;
                        pbFound: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsConvertTable = function( hObj: ADSHANDLE;
                            usFilterOption: UNSIGNED16;
                            pucFile: PAceChar;
                            usTableType: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCopyTable = function( hObj: ADSHANDLE;
                         usFilterOption: UNSIGNED16;
                         pucFile: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCopyTableContents = function( hObjFrom: ADSHANDLE;
                                 hTableTo: ADSHANDLE;
                                 usFilterOption: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCopyTableStructure = function( hTable: ADSHANDLE;
                                  pucFile: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCreateIndex = function( hObj: ADSHANDLE;
                           pucFileName: PAceChar;
                           pucTag: PAceChar;
                           pucExpr: PAceChar;
                           pucCondition: PAceChar;
                           pucWhile: PAceChar;
                           ulOptions: UNSIGNED32;
                           phIndex: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCreateIndex61 = function( hObj: ADSHANDLE;
                             pucFileName: PAceChar;
                             pucTag: PAceChar;
                             pucExpr: PAceChar;
                             pucCondition: PAceChar;
                             pucWhile: PAceChar;
                             ulOptions: UNSIGNED32;
                             ulPageSize: UNSIGNED32;
                             phIndex: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCreateIndex90 = function( hObj: ADSHANDLE;
                             pucFileName: PAceChar;
                             pucTag: PAceChar;
                             pucExpr: PAceChar;
                             pucCondition: PAceChar;
                             pucWhile: PAceChar;
                             ulOptions: UNSIGNED32;
                             ulPageSize: UNSIGNED32;
                             pucCollation: PAceChar;
                             phIndex: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCreateFTSIndex = function( hTable: ADSHANDLE;
                              pucFileName: PAceChar;
                              pucTag: PAceChar;
                              pucField: PAceChar;
                              ulPageSize: UNSIGNED32;
                              ulMinWordLen: UNSIGNED32;
                              ulMaxWordLen: UNSIGNED32;
                              usUseDefaultDelim: UNSIGNED16;
                              pvDelimiters: pointer;
                              usUseDefaultNoise: UNSIGNED16;
                              pvNoiseWords: pointer;
                              usUseDefaultDrop: UNSIGNED16;
                              pvDropChars: pointer;
                              usUseDefaultConditionals: UNSIGNED16;
                              pvConditionalChars: pointer;
                              pucCollation: PAceChar;
                              pucReserved1: PAceChar;
                              ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCreateTable = function( hConnection: ADSHANDLE;
                           pucName: PAceChar;
                           pucAlias: PAceChar;
                           usTableType: UNSIGNED16;
                           usCharType: UNSIGNED16;
                           usLockType: UNSIGNED16;
                           usCheckRights: UNSIGNED16;
                           usMemoSize: UNSIGNED16;
                           pucFields: PAceChar;
                           phTable: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCreateTable71 = function( hConnection: ADSHANDLE;
                             pucName: PAceChar;
                             pucDBObjName: PAceChar;
                             usTableType: UNSIGNED16;
                             usCharType: UNSIGNED16;
                             usLockType: UNSIGNED16;
                             usCheckRights: UNSIGNED16;
                             usMemoSize: UNSIGNED16;
                             pucFields: PAceChar;
                             ulOptions: UNSIGNED32;
                             phTable: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCreateTable90 = function( hConnection: ADSHANDLE;
                             pucName: PAceChar;
                             pucDBObjName: PAceChar;
                             usTableType: UNSIGNED16;
                             usCharType: UNSIGNED16;
                             usLockType: UNSIGNED16;
                             usCheckRights: UNSIGNED16;
                             usMemoSize: UNSIGNED16;
                             pucFields: PAceChar;
                             ulOptions: UNSIGNED32;
                             pucCollation: PAceChar;
                             phTable: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDCreate = function( pucDictionaryPath: PAceChar;
                        usEncrypt: UNSIGNED16;
                        pucDescription: PAceChar;
                        phDictionary: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDCreate101 = function( pucConnectString: PAceChar;
                           phConnectOptions: pADSHANDLE;
                           phDictionary: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDCreateRefIntegrity = function( hDictionary: ADSHANDLE;
                                    pucRIName: PAceChar;
                                    pucFailTable: PAceChar;
                                    pucParentTableName: PAceChar;
                                    pucParentTagName: PAceChar;
                                    pucChildTableName: PAceChar;
                                    pucChildTagName: PAceChar;
                                    usUpdateRule: UNSIGNED16;
                                    usDeleteRule: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDCreateRefIntegrity62 = function( hDictionary: ADSHANDLE;
                                      pucRIName: PAceChar;
                                      pucFailTable: PAceChar;
                                      pucParentTableName: PAceChar;
                                      pucParentTagName: PAceChar;
                                      pucChildTableName: PAceChar;
                                      pucChildTagName: PAceChar;
                                      usUpdateRule: UNSIGNED16;
                                      usDeleteRule: UNSIGNED16;
                                      pucNoPrimaryError: PAceChar;
                                      pucCascadeError: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDRemoveRefIntegrity = function( hDictionary: ADSHANDLE;
                                    pucRIName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGetDatabaseProperty = function( hObject: ADSHANDLE;
                                     usPropertyID: UNSIGNED16;
                                     pvProperty: pointer;
                                     pusPropertyLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGetFieldProperty = function( hObject: ADSHANDLE;
                                  pucTableName: PAceChar;
                                  pucFieldName: PAceChar;
                                  usPropertyID: UNSIGNED16;
                                  pvProperty: pointer;
                                  pusPropertyLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGetIndexFileProperty = function( hObject: ADSHANDLE;
                                      pucTableName: PAceChar;
                                      pucIndexFileName: PAceChar;
                                      usPropertyID: UNSIGNED16;
                                      pvProperty: pointer;
                                      pusPropertyLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGetIndexProperty = function( hObject: ADSHANDLE;
                                  pucTableName: PAceChar;
                                  pucIndexName: PAceChar;
                                  usPropertyID: UNSIGNED16;
                                  pvProperty: pointer;
                                  pusPropertyLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGetLinkProperty = function( hConnect: ADSHANDLE;
                                 pucLinkName: PAceChar;
                                 usPropertyID: UNSIGNED16;
                                 pvProperty: pointer;
                                 pusPropertyLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGetTableProperty = function( hObject: ADSHANDLE;
                                  pucTableName: PAceChar;
                                  usPropertyID: UNSIGNED16;
                                  pvProperty: pointer;
                                  pusPropertyLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGetUserGroupProperty = function( hObject: ADSHANDLE;
                                      pucUserGroupName: PAceChar;
                                      usPropertyID: UNSIGNED16;
                                      pvProperty: pointer;
                                      pusPropertyLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGetUserProperty = function( hObject: ADSHANDLE;
                                 pucUserName: PAceChar;
                                 usPropertyID: UNSIGNED16;
                                 pvProperty: pointer;
                                 pusPropertyLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGetViewProperty = function( hObject: ADSHANDLE;
                                 pucViewName: PAceChar;
                                 usPropertyID: UNSIGNED16;
                                 pvProperty: pointer;
                                 pusPropertyLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGetTriggerProperty = function( hObject: ADSHANDLE;
                                    pucTriggerName: PAceChar;
                                    usPropertyID: UNSIGNED16;
                                    pvProperty: pointer;
                                    pusPropertyLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGetProcedureProperty = function( hObject: ADSHANDLE;
                                      pucProcName: PAceChar;
                                      usPropertyID: UNSIGNED16;
                                      pvProperty: pointer;
                                      pusPropertyLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGetRefIntegrityProperty = function( hObject: ADSHANDLE;
                                         pucRIName: PAceChar;
                                         usPropertyID: UNSIGNED16;
                                         pucProperty: PAceChar;
                                         pusPropertyLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGetPermissions = function( hDBConn: ADSHANDLE;
                                pucGrantee: PAceChar;
                                usObjectType: UNSIGNED16;
                                pucObjectName: PAceChar;
                                pucParentName: PAceChar;
                                usGetInherited: UNSIGNED16;
                                pulPermissions: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGrantPermission = function( hAdminConn: ADSHANDLE;
                                 usObjectType: UNSIGNED16;
                                 pucObjectName: PAceChar;
                                 pucParentName: PAceChar;
                                 pucGrantee: PAceChar;
                                 ulPermissions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDRevokePermission = function( hAdminConn: ADSHANDLE;
                                  usObjectType: UNSIGNED16;
                                  pucObjectName: PAceChar;
                                  pucParentName: PAceChar;
                                  pucGrantee: PAceChar;
                                  ulPermissions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDSetDatabaseProperty = function( hDictionary: ADSHANDLE;
                                     usPropertyID: UNSIGNED16;
                                     pvProperty: pointer;
                                     usPropertyLen: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDSetFieldProperty = function( hDictionary: ADSHANDLE;
                                  pucTableName: PAceChar;
                                  pucFieldName: PAceChar;
                                  usPropertyID: UNSIGNED16;
                                  pvProperty: pointer;
                                  usPropertyLen: UNSIGNED16;
                                  usValidateOption: UNSIGNED16;
                                  pucFailTable: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDSetProcedureProperty = function( hDictionary: ADSHANDLE;
                                      pucProcedureName: PAceChar;
                                      usPropertyID: UNSIGNED16;
                                      pvProperty: pointer;
                                      usPropertyLen: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDSetTableProperty = function( hDictionary: ADSHANDLE;
                                  pucTableName: PAceChar;
                                  usPropertyID: UNSIGNED16;
                                  pvProperty: pointer;
                                  usPropertyLen: UNSIGNED16;
                                  usValidateOption: UNSIGNED16;
                                  pucFailTable: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDSetUserGroupProperty = function( hDictionary: ADSHANDLE;
                                      pucUserGroupName: PAceChar;
                                      usPropertyID: UNSIGNED16;
                                      pvProperty: pointer;
                                      usPropertyLen: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDSetUserProperty = function( hDictionary: ADSHANDLE;
                                 pucUserName: PAceChar;
                                 usPropertyID: UNSIGNED16;
                                 pvProperty: pointer;
                                 usPropertyLen: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDSetViewProperty = function( hDictionary: ADSHANDLE;
                                 pucViewName: PAceChar;
                                 usPropertyID: UNSIGNED16;
                                 pvProperty: pointer;
                                 usPropertyLen: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDSetObjectAccessRights = function( hDictionary: ADSHANDLE;
                                       pucObjectName: PAceChar;
                                       pucAccessorName: PAceChar;
                                       pucAllowedAccess: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDAddProcedure = function( hDictionary: ADSHANDLE;
                              pucName: PAceChar;
                              pucContainer: PAceChar;
                              pucProcName: PAceChar;
                              ulInvokeOption: UNSIGNED32;
                              pucInParams: PAceChar;
                              pucOutParams: PAceChar;
                              pucComments: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDAddProcedure100 = function( hDictionary: ADSHANDLE;
                                 pucName: PAceChar;
                                 pwcContainer: PWideChar;
                                 pucProcName: PAceChar;
                                 ulInvokeOption: UNSIGNED32;
                                 pucInParams: PAceChar;
                                 pucOutParams: PAceChar;
                                 pucComments: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDAddTable = function( hDictionary: ADSHANDLE;
                          pucTableName: PAceChar;
                          pucTablePath: PAceChar;
                          usTableType: UNSIGNED16;
                          usCharType: UNSIGNED16;
                          pucIndexFiles: PAceChar;
                          pucComments: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDAddTable90 = function( hDictionary: ADSHANDLE;
                            pucTableName: PAceChar;
                            pucTablePath: PAceChar;
                            usTableType: UNSIGNED16;
                            usCharType: UNSIGNED16;
                            pucIndexFiles: PAceChar;
                            pucComments: PAceChar;
                            pucCollation: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDAddView = function( hDictionary: ADSHANDLE;
                         pucName: PAceChar;
                         pucComments: PAceChar;
                         pucSQL: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDAddView100 = function( hDictionary: ADSHANDLE;
                            pucName: PAceChar;
                            pucComments: PAceChar;
                            pwcSQL: PWideChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDCreateTrigger = function( hDictionary: ADSHANDLE;
                               pucName: PAceChar;
                               pucTableName: PAceChar;
                               ulTriggerType: UNSIGNED32;
                               ulEventTypes: UNSIGNED32;
                               ulContainerType: UNSIGNED32;
                               pucContainer: PAceChar;
                               pucFunctionName: PAceChar;
                               ulPriority: UNSIGNED32;
                               pucComments: PAceChar;
                               ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDCreateTrigger100 = function( hDictionary: ADSHANDLE;
                                  pucName: PAceChar;
                                  pucTableName: PAceChar;
                                  ulTriggerType: UNSIGNED32;
                                  ulEventTypes: UNSIGNED32;
                                  ulContainerType: UNSIGNED32;
                                  pwcContainer: PWideChar;
                                  pucFunctionName: PAceChar;
                                  ulPriority: UNSIGNED32;
                                  pucComments: PAceChar;
                                  ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDRemoveTrigger = function( hDictionary: ADSHANDLE;
                               pucName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDAddIndexFile = function( hDictionary: ADSHANDLE;
                              pucTableName: PAceChar;
                              pucIndexFilePath: PAceChar;
                              pucComment: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDCreateUser = function( hDictionary: ADSHANDLE;
                            pucGroupName: PAceChar;
                            pucUserName: PAceChar;
                            pucPassword: PAceChar;
                            pucDescription: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDAddUserToGroup = function( hDictionary: ADSHANDLE;
                                pucGroupName: PAceChar;
                                pucUserName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDRemoveUserFromGroup = function( hDictionary: ADSHANDLE;
                                     pucGroupName: PAceChar;
                                     pucUserName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDDeleteUser = function( hDictionary: ADSHANDLE;
                            pucUserName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDCreateUserGroup = function( hDictionary: ADSHANDLE;
                                 pucGroupName: PAceChar;
                                 pucDescription: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDDeleteUserGroup = function( hDictionary: ADSHANDLE;
                                 pucGroupName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDDeleteIndex = function( hDictionary: ADSHANDLE;
                             pucTableName: PAceChar;
                             pucIndexName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDRemoveIndexFile = function( hDictionary: ADSHANDLE;
                                 pucTableName: PAceChar;
                                 pucIndexFileName: PAceChar;
                                 usDeleteFile: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDRemoveProcedure = function( hDictionary: ADSHANDLE;
                                 pucName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDRemoveTable = function( hObject: ADSHANDLE;
                             pucTableName: PAceChar;
                             usDeleteFiles: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDRemoveView = function( hDictionary: ADSHANDLE;
                            pucName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDRenameObject = function( hDictionary: ADSHANDLE;
                              pucObjectName: PAceChar;
                              pucNewObjectName: PAceChar;
                              usObjectType: UNSIGNED16;
                              ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDMoveObjectFile = function( hDictionary: ADSHANDLE;
                                usObjectType: UNSIGNED16;
                                pucObjectName: PAceChar;
                                pucNewPath: PAceChar;
                                pucIndexFiles: PAceChar;
                                pucParent: PAceChar;
                                ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDFindFirstObject = function( hObject: ADSHANDLE;
                                 usFindObjectType: UNSIGNED16;
                                 pucParentName: PAceChar;
                                 pucObjectName: PAceChar;
                                 pusObjectNameLen: PUNSIGNED16;
                                 phFindHandle: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDFindNextObject = function( hObject: ADSHANDLE;
                                hFindHandle: ADSHANDLE;
                                pucObjectName: PAceChar;
                                pusObjectNameLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDFindClose = function( hObject: ADSHANDLE;
                           hFindHandle: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDCreateLink = function( hDBConn: ADSHANDLE;
                            pucLinkAlias: PAceChar;
                            pucLinkedDDPath: PAceChar;
                            pucUserName: PAceChar;
                            pucPassword: PAceChar;
                            ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDModifyLink = function( hDBConn: ADSHANDLE;
                            pucLinkAlias: PAceChar;
                            pucLinkedDDPath: PAceChar;
                            pucUserName: PAceChar;
                            pucPassword: PAceChar;
                            ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDDropLink = function( hDBConn: ADSHANDLE;
                          pucLinkedDD: PAceChar;
                          usDropGlobal: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDCreatePublication = function( hDictionary: ADSHANDLE;
                                   pucPublicationName: PAceChar;
                                   pucComments: PAceChar;
                                   ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGetPublicationProperty = function( hObject: ADSHANDLE;
                                        pucPublicationName: PAceChar;
                                        usPropertyID: UNSIGNED16;
                                        pvProperty: pointer;
                                        pusPropertyLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDSetPublicationProperty = function( hDictionary: ADSHANDLE;
                                        pucPublicationName: PAceChar;
                                        usPropertyID: UNSIGNED16;
                                        pvProperty: pointer;
                                        usPropertyLen: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDDeletePublication = function( hDictionary: ADSHANDLE;
                                   pucPublicationName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDCreateArticle = function( hDictionary: ADSHANDLE;
                               pucPublicationName: PAceChar;
                               pucObjectName: PAceChar;
                               pucRowIdentColumns: PAceChar;
                               pucFilter: PAceChar;
                               ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDCreateArticle100 = function( hDictionary: ADSHANDLE;
                                  pucPublicationName: PAceChar;
                                  pucObjectName: PAceChar;
                                  pucRowIdentColumns: PAceChar;
                                  pwcFilter: PWideChar;
                                  ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGetArticleProperty = function( hObject: ADSHANDLE;
                                    pucPublicationName: PAceChar;
                                    pucObjectName: PAceChar;
                                    usPropertyID: UNSIGNED16;
                                    pvProperty: pointer;
                                    pusPropertyLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDSetArticleProperty = function( hDictionary: ADSHANDLE;
                                    pucPublicationName: PAceChar;
                                    pucObjectName: PAceChar;
                                    usPropertyID: UNSIGNED16;
                                    pvProperty: pointer;
                                    usPropertyLen: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDDeleteArticle = function( hDictionary: ADSHANDLE;
                               pucPublicationName: PAceChar;
                               pucObjectName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDCreateSubscription = function( hDictionary: ADSHANDLE;
                                    pucSubscriptionName: PAceChar;
                                    pucPublicationName: PAceChar;
                                    pucTarget: PAceChar;
                                    pucUser: PAceChar;
                                    pucPassword: PAceChar;
                                    pucReplicationQueue: PAceChar;
                                    usForward: UNSIGNED16;
                                    pucComments: PAceChar;
                                    ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDGetSubscriptionProperty = function( hObject: ADSHANDLE;
                                         pucSubscriptionName: PAceChar;
                                         usPropertyID: UNSIGNED16;
                                         pvProperty: pointer;
                                         pusPropertyLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDSetSubscriptionProperty = function( hDictionary: ADSHANDLE;
                                         pucSubscriptionName: PAceChar;
                                         usPropertyID: UNSIGNED16;
                                         pvProperty: pointer;
                                         usPropertyLen: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDDeleteSubscription = function( hDictionary: ADSHANDLE;
                                    pucSubscriptionName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDecryptRecord = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDecryptTable = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDeleteCustomKey = function( hIndex: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDeleteIndex = function( hIndex: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDeleteRecord = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetKeyColumn = function( hCursor: ADSHANDLE;
                            pucKeyColumn: PAceChar;
                            pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetKeyFilter = function( hTable: ADSHANDLE;
                            pucValuesTable: PUNSIGNED8;
                            ulOptions: UNSIGNED32;
                            pucFilter: PUNSIGNED8;
                            pulLength: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDisableEncryption = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDisableLocalConnections = function:UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDisconnect = function( hConnect: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsEnableEncryption = function( hTable: ADSHANDLE;
                                pucPassword: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsEncryptRecord = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsEncryptTable = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsEvalLogicalExpr = function( hTable: ADSHANDLE;
                               pucExpr: PAceChar;
                               pbResult: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsEvalLogicalExprW = function( hTable: ADSHANDLE;
                                pwcExpr: PWideChar;
                                pbResult: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsEvalNumericExpr = function( hTable: ADSHANDLE;
                               pucExpr: PAceChar;
                               pdResult: pDOUBLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsEvalStringExpr = function( hTable: ADSHANDLE;
                              pucExpr: PAceChar;
                              pucResult: PAceChar;
                              pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsEvalTestExpr = function( hTable: ADSHANDLE;
                            pucExpr: PAceChar;
                            pusType: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsExtractKey = function( hIndex: ADSHANDLE;
                          pucKey: PAceChar;
                          pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsFailedTransactionRecovery = function( pucServer: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsFileToBinary = function( hTable: ADSHANDLE;
                            pucFldName: PAceChar;
                            usBinaryType: UNSIGNED16;
                            pucFileName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsFindConnection = function( pucServerName: PAceChar;
                              phConnect: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsFindConnection25 = function( pucFullPath: PAceChar;
                                phConnect: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsFindClose = function( hConnect: ADSHANDLE;
                         lHandle: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsFindFirstTable = function( hConnect: ADSHANDLE;
                              pucFileMask: PAceChar;
                              pucFirstFile: PAceChar;
                              pusFileLen: PUNSIGNED16;
                              plHandle: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsFindNextTable = function( hConnect: ADSHANDLE;
                             lHandle: ADSHANDLE;
                             pucFileName: PAceChar;
                             pusFileLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsFindFirstTable62 = function( hConnect: ADSHANDLE;
                                pucFileMask: PAceChar;
                                pucFirstDD: PAceChar;
                                pusDDLen: PUNSIGNED16;
                                pucFirstFile: PAceChar;
                                pusFileLen: PUNSIGNED16;
                                plHandle: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsFindNextTable62 = function( hConnect: ADSHANDLE;
                               lHandle: ADSHANDLE;
                               pucDDName: PAceChar;
                               pusDDLen: PUNSIGNED16;
                               pucFileName: PAceChar;
                               pusFileLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetAllIndexes = function( hTable: ADSHANDLE;
                             ahIndex: PADSIndexArray;
                             pusArrayLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetFTSIndexes = function( hTable: ADSHANDLE;
                             ahIndex: PADSIndexArray;
                             pusArrayLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetFTSIndexInfo = function( hIndex: ADSHANDLE;
                               pucOutput: PAceChar;
                               pulBufLen: PUNSIGNED32;
                               ppucField: pPChar;
                               pulMinWordLen: PUNSIGNED32;
                               pulMaxWordLen: PUNSIGNED32;
                               ppucDelimiters: pPChar;
                               ppucNoiseWords: pPChar;
                               ppucDropChars: pPChar;
                               ppucConditionalChars: pPChar;
                               ppucReserved1: pPChar;
                               ppucReserved2: pPChar;
                               pulOptions: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetFTSIndexInfoW = function( hIndex: ADSHANDLE;
                                pwcOutput: PWideChar;
                                pulBufLen: PUNSIGNED32;
                                ppwcField: pPWideChar;
                                pulMinWordLen: PUNSIGNED32;
                                pulMaxWordLen: PUNSIGNED32;
                                ppwcDelimiters: pPWideChar;
                                ppwcNoiseWords: pPWideChar;
                                ppwcDropChars: pPWideChar;
                                ppwcConditionalChars: pPWideChar;
                                ppwcReserved1: pPWideChar;
                                ppwcReserved2: pPWideChar;
                                pulOptions: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetAllLocks = function( hTable: ADSHANDLE;
                           aulLocks: pointer;
                           pusArrayLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetAllTables = function( ahTable: pointer;
                            pusArrayLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetBinary = function( hTable: ADSHANDLE;
                         pucFldName: PAceChar;
                         ulOffset: UNSIGNED32;
                         pucBuf: PAceBinary;
                         pulLen: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetBinaryLength = function( hTable: ADSHANDLE;
                               pucFldName: PAceChar;
                               pulLength: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetBookmark = function( hTable: ADSHANDLE;
                           phBookmark: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetBookmark60 = function( hObj: ADSHANDLE;
                             pucBookmark: PAceChar;
                             pulLength: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetBookmarkLength = function( hObj: ADSHANDLE;
                                 pulLength: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCompareBookmarks = function( pucBookmark1: PAceChar;
                                pucBookmark2: PAceChar;
                                plResult: pSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetCollationLang = function( pucLang: PAceChar;
                                pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetCollation = function( hConnect: ADSHANDLE;
                            pucCollation: PAceChar;
                            pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetIntProperty = function( hObj: ADSHANDLE;
                              ulPropertyID: UNSIGNED32;
                              pulProperty: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetConnectionType = function( hConnect: ADSHANDLE;
                                 pusConnectType: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetTransactionCount = function( hConnect: ADSHANDLE;
                                   pulTransactionCount: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetConnectionPath = function( hConnect: ADSHANDLE;
                                 pucConnectionPath: PAceChar;
                                 pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetConnectionProperty = function( hConnect: ADSHANDLE;
                                     usPropertyID: UNSIGNED16;
                                     pvProperty: pointer;
                                     pulPropertyLen: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetDate = function( hTable: ADSHANDLE;
                       pucFldName: PAceChar;
                       pucBuf: PAceChar;
                       pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetDateFormat = function( pucFormat: PAceChar;
                             pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetDateFormat60 = function( hConnect: ADSHANDLE;
                               pucFormat: PAceChar;
                               pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetDecimals = function( pusDecimals: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetDefault = function( pucDefault: PAceChar;
                          pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetDeleted = function( pbUseDeleted: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetDouble = function( hTable: ADSHANDLE;
                         pucFldName: PAceChar;
                         pdValue: pDOUBLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetEpoch = function( pusCentury: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetErrorString = function( ulErrCode: UNSIGNED32;
                              pucBuf: PAceChar;
                              pusBufLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetExact = function( pbExact: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetExact22 = function( hObj: ADSHANDLE;
                          pbExact: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetField = function( hTable: ADSHANDLE;
                        pucFldName: PAceChar;
                        pucBuf: PAceChar;
                        pulLen: PUNSIGNED32;
                        usOption: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetFieldW = function( hObj: ADSHANDLE;
                         pucFldName: PAceChar;
                         pwcBuf: PWideChar;
                         pulLen: PUNSIGNED32;
                         usOption: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetFieldDecimals = function( hTable: ADSHANDLE;
                                pucFldName: PAceChar;
                                pusDecimals: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetFieldLength = function( hTable: ADSHANDLE;
                              pucFldName: PAceChar;
                              pulLength: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetFieldName = function( hTable: ADSHANDLE;
                            usFld: UNSIGNED16;
                            pucName: PAceChar;
                            pusBufLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetFieldNum = function( hTable: ADSHANDLE;
                           pucFldName: PAceChar;
                           pusNum: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetFieldOffset = function( hTable: ADSHANDLE;
                              pucFldName: PAceChar;
                              pulOffset: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetFieldType = function( hTable: ADSHANDLE;
                            pucFldName: PAceChar;
                            pusType: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetFilter = function( hTable: ADSHANDLE;
                         pucFilter: PAceChar;
                         pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetHandleLong = function( hObj: ADSHANDLE;
                             pulVal: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetHandleType = function( hObj: ADSHANDLE;
                             pusType: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetIndexCondition = function( hIndex: ADSHANDLE;
                                 pucExpr: PAceChar;
                                 pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetIndexExpr = function( hIndex: ADSHANDLE;
                            pucExpr: PAceChar;
                            pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetIndexFilename = function( hIndex: ADSHANDLE;
                                usOption: UNSIGNED16;
                                pucName: PAceChar;
                                pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetIndexHandle = function( hTable: ADSHANDLE;
                              pucIndexOrder: PAceChar;
                              phIndex: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetIndexHandleByOrder = function( hTable: ADSHANDLE;
                                     usOrderNum: UNSIGNED16;
                                     phIndex: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetIndexHandleByExpr = function( hTable: ADSHANDLE;
                                    pucExpr: PAceChar;
                                    ulDescending: UNSIGNED32;
                                    phIndex: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetIndexName = function( hIndex: ADSHANDLE;
                            pucName: PAceChar;
                            pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetIndexOrderByHandle = function( hIndex: ADSHANDLE;
                                     pusIndexOrder: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetJulian = function( hTable: ADSHANDLE;
                         pucFldName: PAceChar;
                         plDate: pSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetKeyCount = function( hIndex: ADSHANDLE;
                           usFilterOption: UNSIGNED16;
                           pulCount: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetKeyNum = function( hIndex: ADSHANDLE;
                         usFilterOption: UNSIGNED16;
                         pulKey: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetKeyLength = function( hIndex: ADSHANDLE;
                            pusKeyLength: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetKeyType = function( hIndex: ADSHANDLE;
                          usKeyType: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetLastError = function( pulErrCode: PUNSIGNED32;
                            pucBuf: PAceChar;
                            pusBufLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetLastTableUpdate = function( hTable: ADSHANDLE;
                                  pucDate: PAceChar;
                                  pusDateLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetLogical = function( hTable: ADSHANDLE;
                          pucFldName: PAceChar;
                          pbValue: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetLong = function( hTable: ADSHANDLE;
                       pucFldName: PAceChar;
                       plValue: pSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetLongLong = function( hTable: ADSHANDLE;
                           pucFldName: PAceChar;
                           pqValue: pSIGNED64 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetMemoBlockSize = function( hTable: ADSHANDLE;
                                pusBlockSize: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetMemoLength = function( hTable: ADSHANDLE;
                             pucFldName: PAceChar;
                             pulLength: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetMemoDataType = function( hTable: ADSHANDLE;
                               pucFldName: PAceChar;
                               pusType: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetMilliseconds = function( hTable: ADSHANDLE;
                               pucFldName: PAceChar;
                               plTime: pSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetMoney = function( hTbl: ADSHANDLE;
                        pucFldName: PAceChar;
                        pqValue: pSIGNED64 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetActiveLinkInfo = function( hDBConn: ADSHANDLE;
                                 usLinkNum: UNSIGNED16;
                                 pucLinkInfo: PAceChar;
                                 pusBufferLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetNumActiveLinks = function( hDBConn: ADSHANDLE;
                                 pusNumLinks: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetNumFields = function( hTable: ADSHANDLE;
                            pusCount: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetNumIndexes = function( hTable: ADSHANDLE;
                             pusNum: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetNumFTSIndexes = function( hTable: ADSHANDLE;
                                pusNum: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetNumLocks = function( hTable: ADSHANDLE;
                           pusNum: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetNumOpenTables = function( pusNum: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetRecord = function( hTable: ADSHANDLE;
                         pucRec: PAceChar;
                         pulLen: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetRecordCount = function( hTable: ADSHANDLE;
                              usFilterOption: UNSIGNED16;
                              pulCount: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetRecordNum = function( hTable: ADSHANDLE;
                            usFilterOption: UNSIGNED16;
                            pulRec: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetRecordLength = function( hTable: ADSHANDLE;
                               pulLength: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetRecordCRC = function( hTable: ADSHANDLE;
                            pulCRC: PUNSIGNED32;
                            ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetRelKeyPos = function( hIndex: ADSHANDLE;
                            pdPos: pDOUBLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetScope = function( hIndex: ADSHANDLE;
                        usScopeOption: UNSIGNED16;
                        pucScope: PAceChar;
                        pusBufLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetSearchPath = function( pucPath: PAceChar;
                             pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetServerName = function( hConnect: ADSHANDLE;
                             pucName: PAceChar;
                             pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetServerTime = function( hConnect: ADSHANDLE;
                             pucDateBuf: PAceChar;
                             pusDateBufLen: PUNSIGNED16;
                             plTime: pSIGNED32;
                             pucTimeBuf: PAceChar;
                             pusTimeBufLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetShort = function( hTable: ADSHANDLE;
                        pucFldName: PAceChar;
                        psValue: pSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetString = function( hTable: ADSHANDLE;
                         pucFldName: PAceChar;
                         pucBuf: PAceChar;
                         pulLen: PUNSIGNED32;
                         usOption: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetStringW = function( hObj: ADSHANDLE;
                          pucFldName: PAceChar;
                          pwcBuf: PWideChar;
                          pulLen: PUNSIGNED32;
                          usOption: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetTableAlias = function( hTable: ADSHANDLE;
                             pucAlias: PAceChar;
                             pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetTableCharType = function( hTable: ADSHANDLE;
                                pusCharType: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetTableConnection = function( hTable: ADSHANDLE;
                                  phConnect: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetTableFilename = function( hTable: ADSHANDLE;
                                usOption: UNSIGNED16;
                                pucName: PAceChar;
                                pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetTableHandle = function( pucName: PAceChar;
                              phTable: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetTableHandle25 = function( hConnect: ADSHANDLE;
                                pucName: PAceChar;
                                phTable: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetTableLockType = function( hTable: ADSHANDLE;
                                pusLockType: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetTableMemoSize = function( hTable: ADSHANDLE;
                                pusMemoSize: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetTableOpenOptions = function( hTable: ADSHANDLE;
                                   pulOptions: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetTableRights = function( hTable: ADSHANDLE;
                              pusRights: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetTableType = function( hTable: ADSHANDLE;
                            pusType: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetTime = function( hTable: ADSHANDLE;
                       pucFldName: PAceChar;
                       pucBuf: PAceChar;
                       pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetVersion = function( pulMajor: PUNSIGNED32;
                          pulMinor: PUNSIGNED32;
                          pucLetter: PAceChar;
                          pucDesc: PAceChar;
                          pusDescLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGotoBookmark = function( hTable: ADSHANDLE;
                            hBookmark: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGotoBookmark60 = function( hObj: ADSHANDLE;
                              pucBookmark: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGotoBottom = function( hObj: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGotoRecord = function( hTable: ADSHANDLE;
                          ulRec: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGotoTop = function( hObj: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsImageToClipboard = function( hTable: ADSHANDLE;
                                pucFldName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsInTransaction = function( hConnect: ADSHANDLE;
                             pbInTrans: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsEmpty = function( hTable: ADSHANDLE;
                       pucFldName: PAceChar;
                       pbEmpty: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsExprValid = function( hTable: ADSHANDLE;
                           pucExpr: PAceChar;
                           pbValid: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsFound = function( hObj: ADSHANDLE;
                       pbFound: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsIndexCompound = function( hIndex: ADSHANDLE;
                               pbCompound: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsIndexCandidate = function( hIndex: ADSHANDLE;
                                pbCandidate: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsIndexNullable = function( hIndex: ADSHANDLE;
                               pbNullable: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsIndexCustom = function( hIndex: ADSHANDLE;
                             pbCustom: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsIndexDescending = function( hIndex: ADSHANDLE;
                                 pbDescending: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsIndexPrimaryKey = function( hIndex: ADSHANDLE;
                                 pbPrimaryKey: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsIndexFTS = function( hIndex: ADSHANDLE;
                          pbFTS: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsIndexUnique = function( hIndex: ADSHANDLE;
                             pbUnique: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsRecordDeleted = function( hTable: ADSHANDLE;
                               pbDeleted: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsRecordEncrypted = function( hTable: ADSHANDLE;
                                 pbEncrypted: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsRecordLocked = function( hTable: ADSHANDLE;
                              ulRec: UNSIGNED32;
                              pbLocked: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsRecordVisible = function( hObj: ADSHANDLE;
                               pbVisible: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsServerLoaded = function( pucServer: PAceChar;
                              pbLoaded: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsTableEncrypted = function( hTable: ADSHANDLE;
                                pbEncrypted: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsTableLocked = function( hTable: ADSHANDLE;
                             pbLocked: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsLocate = function( hTable: ADSHANDLE;
                      pucExpr: PAceChar;
                      bForward: UNSIGNED16;
                      pbFound: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsLockRecord = function( hTable: ADSHANDLE;
                          ulRec: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsLockTable = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsLookupKey = function( hIndex: ADSHANDLE;
                         pucKey: PAceChar;
                         usKeyLen: UNSIGNED16;
                         usDataType: UNSIGNED16;
                         pbFound: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgConnect = function( pucServerName: PAceChar;
                         pucUserName: PAceChar;
                         pucPassword: PAceChar;
                         phMgmtHandle: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgDisconnect = function( hMgmtHandle: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgGetCommStats = function( hMgmtHandle: ADSHANDLE;
                              pstCommStats: pADS_MGMT_COMM_STATS;
                              pusStructSize: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgResetCommStats = function( hMgmtHandle: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgDumpInternalTables = function( hMgmtHandle: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgGetConfigInfo = function( hMgmtHandle: ADSHANDLE;
                               pstConfigValues: pADS_MGMT_CONFIG_PARAMS;
                               pusConfigValuesStructSize: PUNSIGNED16;
                               pstConfigMemory: pADS_MGMT_CONFIG_MEMORY;
                               pusConfigMemoryStructSize: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgGetInstallInfo = function( hMgmtHandle: ADSHANDLE;
                                pstInstallInfo: pADS_MGMT_INSTALL_INFO;
                                pusStructSize: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgGetActivityInfo = function( hMgmtHandle: ADSHANDLE;
                                 pstActivityInfo: pADS_MGMT_ACTIVITY_INFO;
                                 pusStructSize: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgGetUserNames = function( hMgmtHandle: ADSHANDLE;
                              pucFileName: PAceChar;
                              astUserInfo: PADSMgUserArray;
                              pusArrayLen: PUNSIGNED16;
                              pusStructSize: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgGetOpenTables = function( hMgmtHandle: ADSHANDLE;
                               pucUserName: PAceChar;
                               usConnNumber: UNSIGNED16;
                               astOpenTableInfo: PADSMgTableArray;
                               pusArrayLen: PUNSIGNED16;
                               pusStructSize: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgGetOpenIndexes = function( hMgmtHandle: ADSHANDLE;
                                pucTableName: PAceChar;
                                pucUserName: PAceChar;
                                usConnNumber: UNSIGNED16;
                                astOpenIndexInfo: PADSMgIndexArray;
                                pusArrayLen: PUNSIGNED16;
                                pusStructSize: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgGetLocks = function( hMgmtHandle: ADSHANDLE;
                          pucTableName: PAceChar;
                          pucUserName: PAceChar;
                          usConnNumber: UNSIGNED16;
                          astRecordInfo: PADSMgLocksArray;
                          pusArrayLen: PUNSIGNED16;
                          pusStructSize: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgGetServerType = function( hMgmtHandle: ADSHANDLE;
                               pusServerType: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgKillUser = function( hMgmtHandle: ADSHANDLE;
                          pucUserName: PAceChar;
                          usConnNumber: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgGetWorkerThreadActivity = function( hMgmtHandle: ADSHANDLE;
                                         astWorkerThreadActivity: PADSMgThreadsArray;
                                         pusArrayLen: PUNSIGNED16;
                                         pusStructSize: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgGetLockOwner = function( hMgmtHandle: ADSHANDLE;
                              pucTableName: PAceChar;
                              ulRecordNumber: UNSIGNED32;
                              pstUserInfo: pADS_MGMT_USER_INFO;
                              pusStructSize: PUNSIGNED16;
                              pusLockType: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsNullTerminateStrings = function( bNullTerminate: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsOpenIndex = function( hTable: ADSHANDLE;
                         pucName: PAceChar;
                         ahIndex: PADSIndexArray;
                         pusArrayLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsOpenTable = function( hConnect: ADSHANDLE;
                         pucName: PAceChar;
                         pucAlias: PAceChar;
                         usTableType: UNSIGNED16;
                         usCharType: UNSIGNED16;
                         usLockType: UNSIGNED16;
                         usCheckRights: UNSIGNED16;
                         ulOptions: UNSIGNED32;
                         phTable: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsOpenTable90 = function( hConnect: ADSHANDLE;
                           pucName: PAceChar;
                           pucAlias: PAceChar;
                           usTableType: UNSIGNED16;
                           usCharType: UNSIGNED16;
                           usLockType: UNSIGNED16;
                           usCheckRights: UNSIGNED16;
                           ulOptions: UNSIGNED32;
                           pucCollation: PAceChar;
                           phTable: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsOpenTable101 = function( hConnect: ADSHANDLE;
                            pucName: PAceChar;
                            phTable: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsPackTable = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsPackTable120 = function( hTable: ADSHANDLE;
                            ulMemoBlockSize: UNSIGNED32;
                            ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsRecallRecord = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsRecallAllRecords = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsRefreshRecord = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsClearProgressCallback = function:UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsRegisterProgressCallback = function( Callback: TProgressCallback ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsRegisterCallbackFunction = function( Callback: TCallbackFunction;
                                        ulCallbackID: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsRegisterCallbackFunction101 = function( Callback: TCallbackFunction101;
                                           qCallbackID: SIGNED64 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsClearCallbackFunction = function:UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetSQLTimeout = function( hObj: ADSHANDLE;
                             ulTimeout: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsReindex = function( hObject: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsReindex61 = function( hObject: ADSHANDLE;
                         ulPageSize: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsReindexFTS = function( hObject: ADSHANDLE;
                          ulPageSize: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsResetConnection = function( hConnect: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsRollbackTransaction = function( hConnect: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSeek = function( hIndex: ADSHANDLE;
                    pucKey: PAceChar;
                    usKeyLen: UNSIGNED16;
                    usDataType: UNSIGNED16;
                    usSeekType: UNSIGNED16;
                    pbFound: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSeekLast = function( hIndex: ADSHANDLE;
                        pucKey: PAceChar;
                        usKeyLen: UNSIGNED16;
                        usDataType: UNSIGNED16;
                        pbFound: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetBinary = function( hTable: ADSHANDLE;
                         pucFldName: PAceChar;
                         usBinaryType: UNSIGNED16;
                         ulTotalLength: UNSIGNED32;
                         ulOffset: UNSIGNED32;
                         pucBuf: PAceBinary;
                         ulLen: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetCollationLang = function( pucLang: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetCollation = function( hConnect: ADSHANDLE;
                            pucCollation: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetDate = function( hObj: ADSHANDLE;
                       pucFldName: PAceChar;
                       pucValue: PAceChar;
                       usLen: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetDateFormat = function( pucFormat: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetDateFormat60 = function( hConnect: ADSHANDLE;
                               pucFormat: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetDecimals = function( usDecimals: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetDefault = function( pucDefault: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsShowDeleted = function( bShowDeleted: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetDouble = function( hObj: ADSHANDLE;
                         pucFldName: PAceChar;
                         dValue: DOUBLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetEmpty = function( hObj: ADSHANDLE;
                        pucFldName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetEpoch = function( usCentury: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetExact = function( bExact: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetExact22 = function( hObj: ADSHANDLE;
                          bExact: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetField = function( hObj: ADSHANDLE;
                        pucFldName: PAceChar;
                        pucBuf: PAceChar;
                        ulLen: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetFieldW = function( hObj: ADSHANDLE;
                         pucFldName: PAceChar;
                         pwcBuf: PWideChar;
                         ulLen: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetFilter = function( hTable: ADSHANDLE;
                         pucFilter: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetFilter100 = function( hTable: ADSHANDLE;
                            pvFilter: pointer;
                            ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetHandleLong = function( hObj: ADSHANDLE;
                             ulVal: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetJulian = function( hObj: ADSHANDLE;
                         pucFldName: PAceChar;
                         lDate: SIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetLogical = function( hObj: ADSHANDLE;
                          pucFldName: PAceChar;
                          bValue: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetLong = function( hObj: ADSHANDLE;
                       pucFldName: PAceChar;
                       lValue: SIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetLongLong = function( hObj: ADSHANDLE;
                           pucFldName: PAceChar;
                           qValue: SIGNED64 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetMilliseconds = function( hObj: ADSHANDLE;
                               pucFldName: PAceChar;
                               lTime: SIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetMoney = function( hObj: ADSHANDLE;
                        pucFldName: PAceChar;
                        qValue: SIGNED64 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetRecord = function( hObj: ADSHANDLE;
                         pucRec: PAceChar;
                         ulLen: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetRelation = function( hTableParent: ADSHANDLE;
                           hIndexChild: ADSHANDLE;
                           pucExpr: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetRelKeyPos = function( hIndex: ADSHANDLE;
                            dPos: DOUBLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetScope = function( hIndex: ADSHANDLE;
                        usScopeOption: UNSIGNED16;
                        pucScope: PAceChar;
                        usScopeLen: UNSIGNED16;
                        usDataType: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetScopedRelation = function( hTableParent: ADSHANDLE;
                                 hIndexChild: ADSHANDLE;
                                 pucExpr: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetSearchPath = function( pucPath: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetServerType = function( usServerOptions: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetShort = function( hObj: ADSHANDLE;
                        pucFldName: PAceChar;
                        sValue: SIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetString = function( hObj: ADSHANDLE;
                         pucFldName: PAceChar;
                         pucBuf: PAceChar;
                         ulLen: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetStringW = function( hObj: ADSHANDLE;
                          pucFldName: PAceChar;
                          pwcBuf: PWideChar;
                          ulLen: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetStringFromCodePage = function( hObj: ADSHANDLE;
                                     ulCodePage: UNSIGNED32;
                                     pucFldName: PAceChar;
                                     pucBuf: PAceChar;
                                     ulLen: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetTime = function( hObj: ADSHANDLE;
                       pucFldName: PAceChar;
                       pucValue: PAceChar;
                       usLen: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsShowError = function( pucTitle: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSkip = function( hObj: ADSHANDLE;
                    lRecs: SIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSkipUnique = function( hIndex: ADSHANDLE;
                          lRecs: SIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsThreadExit = function:UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsUnlockRecord = function( hTable: ADSHANDLE;
                            ulRec: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsUnlockTable = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  {* AdsVerifyPassword is obsolete; retained for backward compatibility.
  * Use AdsIsEncryptionEnabled instead.
  *}
  TAdsVerifyPassword = function( hTable: ADSHANDLE;
                              pusEnabled: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsEncryptionEnabled = function( hTable: ADSHANDLE;
                                   pusEnabled: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsWriteAllRecords = function:UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsWriteRecord = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsZapTable = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetAOF = function( hTable: ADSHANDLE;
                      pucFilter: PAceChar;
                      usOptions: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetAOF100 = function( hTable: ADSHANDLE;
                         pvFilter: pointer;
                         ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsEvalAOF = function( hTable: ADSHANDLE;
                       pucFilter: PAceChar;
                       pusOptLevel: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsEvalAOF100 = function( hTable: ADSHANDLE;
                          pvFilter: pointer;
                          ulOptions: UNSIGNED32;
                          pusOptLevel: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsClearAOF = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsRefreshAOF = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetAOF = function( hTable: ADSHANDLE;
                      pucFilter: PAceChar;
                      pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetAOF100 = function( hTable: ADSHANDLE;
                         ulOptions: UNSIGNED32;
                         pvFilter: pointer;
                         pulLen: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetAOFOptLevel = function( hTable: ADSHANDLE;
                              pusOptLevel: PUNSIGNED16;
                              pucNonOpt: PAceChar;
                              pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetAOFOptLevel100 = function( hTable: ADSHANDLE;
                                 pusOptLevel: PUNSIGNED16;
                                 pvNonOpt: pointer;
                                 pulExprLen: PUNSIGNED32;
                                 ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsRecordInAOF = function( hTable: ADSHANDLE;
                             ulRecordNum: UNSIGNED32;
                             pusIsInAOF: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCustomizeAOF = function( hTable: ADSHANDLE;
                            ulNumRecords: UNSIGNED32;
                            pulRecords: PUNSIGNED32;
                            usOption: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsInitRawKey = function( hIndex: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsBuildRawKey = function( hIndex: ADSHANDLE;
                           pucKey: PAceChar;
                           var pusKeyLen: Word ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsBuildRawKey100 = function( hIndex: ADSHANDLE;
                              pucKey: PAceChar;
                              pusKeyLen: PUNSIGNED16;
                              ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCreateSQLStatement = function( hConnect: ADSHANDLE;
                                  phStatement: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsPrepareSQL = function( hStatement: ADSHANDLE;
                          pucSQL: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsPrepareSQLW = function( hStatement: ADSHANDLE;
                           pwcSQL: PWideChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCachePrepareSQL = function( hConnect: ADSHANDLE;
                               pucSQL: PAceChar;
                               phStatement: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCachePrepareSQLW = function( hConnect: ADSHANDLE;
                                pwcSQL: PWideChar;
                                phStatement: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsExecuteSQL = function( hStatement: ADSHANDLE;
                          phCursor: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsExecuteSQLDirect = function( hStatement: ADSHANDLE;
                                pucSQL: PAceChar;
                                phCursor: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsExecuteSQLDirectW = function( hStatement: ADSHANDLE;
                                 pwcSQL: PWideChar;
                                 phCursor: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCloseSQLStatement = function( hStatement: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsStmtSetTableRights = function( hStatement: ADSHANDLE;
                                  usCheckRights: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsStmtSetTableReadOnly = function( hStatement: ADSHANDLE;
                                    usReadOnly: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsStmtSetTableLockType = function( hStatement: ADSHANDLE;
                                    usLockType: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsStmtSetTableCharType = function( hStatement: ADSHANDLE;
                                    usCharType: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsStmtSetTableType = function( hStatement: ADSHANDLE;
                                usTableType: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsStmtSetTableCollation = function( hStatement: ADSHANDLE;
                                     pucCollation: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsStmtConstrainUpdates = function( hStatement: ADSHANDLE;
                                    usConstrain: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsStmtEnableEncryption = function( hStatement: ADSHANDLE;
                                    pucPassword: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsStmtDisableEncryption = function( hStatement: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsStmtSetTablePassword = function( hStatement: ADSHANDLE;
                                    pucTableName: PAceChar;
                                    pucPassword: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsStmtClearTablePasswords = function( hStatement: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsStmtReadAllColumns = function( hStatement: ADSHANDLE;
                                  usReadColumns: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsClearSQLParams = function( hStatement: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetTimeStamp = function( hObj: ADSHANDLE;
                            pucFldName: PAceChar;
                            pucBuf: PAceChar;
                            ulLen: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsClearSQLAbortFunc = function:UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsRegisterSQLAbortFunc = function( Callback: TSQLAbortFunc ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsRegisterUDF = function( hObj: ADSHANDLE;
                           usType: UNSIGNED16;
                           Callback: TUDFFunc ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetNumParams = function( hStatement: ADSHANDLE;
                            pusNumParams: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetLastAutoinc = function( hObj: ADSHANDLE;
                              pulAutoIncVal: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsIndexUserDefined = function( hIndex: ADSHANDLE;
                                  pbUserDefined: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsRestructureTable = function( hObj: ADSHANDLE;
                                pucName: PAceChar;
                                pucPassword: PAceChar;
                                usTableType: UNSIGNED16;
                                usCharType: UNSIGNED16;
                                usLockType: UNSIGNED16;
                                usCheckRights: UNSIGNED16;
                                pucAddFields: PAceChar;
                                pucDeleteFields: PAceChar;
                                pucChangeFields: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsRestructureTable90 = function( hObj: ADSHANDLE;
                                  pucName: PAceChar;
                                  pucPassword: PAceChar;
                                  usTableType: UNSIGNED16;
                                  usCharType: UNSIGNED16;
                                  usLockType: UNSIGNED16;
                                  usCheckRights: UNSIGNED16;
                                  pucAddFields: PAceChar;
                                  pucDeleteFields: PAceChar;
                                  pucChangeFields: PAceChar;
                                  pucCollation: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsRestructureTable120 = function( hObj: ADSHANDLE;
                                  pucName: PAceChar;
                                  pucPassword: PAceChar;
                                  usTableType: UNSIGNED16;
                                  usCharType: UNSIGNED16;
                                  usLockType: UNSIGNED16;
                                  usCheckRights: UNSIGNED16;
                                  pucAddFields: PAceChar;
                                  pucDeleteFields: PAceChar;
                                  pucChangeFields: PAceChar;
                                  pucCollation: PAceChar;
                                  ulMemoBlockSize: UNSIGNED32;
                                  ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetSQLStatementHandle = function( hCursor: ADSHANDLE;
                                     phStmt: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetSQLStatement = function( hStmt: ADSHANDLE;
                               pucSQL: PAceChar;
                               pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsFlushFileBuffers = function( hTable: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDDeployDatabase = function( pucDestination: PAceChar;
                                pucDestinationPassword: PAceChar;
                                pucSource: PAceChar;
                                pucSourcePassword: PAceChar;
                                usServerTypes: UNSIGNED16;
                                usValidateOption: UNSIGNED16;
                                usBackupFiles: UNSIGNED16;
                                ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsVerifySQL = function( hStatement: ADSHANDLE;
                         pucSQL: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsVerifySQLW = function( hStatement: ADSHANDLE;
                          pwcSQL: PWideChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDisableUniqueEnforcement = function( hConnection: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsEnableUniqueEnforcement = function( hConnection: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDisableRI = function( hConnection: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsEnableRI = function( hConnection: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDisableAutoIncEnforcement = function( hConnection: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsEnableAutoIncEnforcement = function( hConnection: ADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsRollbackTransaction80 = function( hConnect: ADSHANDLE;
                                     pucSavepoint: PAceChar;
                                     ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsCreateSavepoint = function( hConnect: ADSHANDLE;
                               pucSavepoint: PAceChar;
                               ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDFreeTable = function( pucTableName: PAceChar;
                           pucPassword: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDSetIndexProperty = function( hAdminConn: ADSHANDLE;
                                  pucTableName: PAceChar;
                                  pucIndexName: PAceChar;
                                  usPropertyID: UNSIGNED16;
                                  pvProperty: pointer;
                                  usPropertyLen: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsFieldBinary = function( hTable: ADSHANDLE;
                             pucFldName: PAceChar;
                             pbBinary: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsNull = function( hTable: ADSHANDLE;
                      pucFldName: PAceChar;
                      pbNull: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsNullable = function( hTable: ADSHANDLE;
                          pucFldName: PAceChar;
                          pbNullable: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetNull = function( hTable: ADSHANDLE;
                       pucFldName: PAceChar ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetTableCollation = function( hTbl: ADSHANDLE;
                                 pucCollation: PAceChar;
                                 pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetIndexCollation = function( hIndex: ADSHANDLE;
                                 pucCollation: PAceChar;
                                 pusLen: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetDataLength = function( hTable: ADSHANDLE;
                             pucFldName: PAceChar;
                             ulOptions: UNSIGNED32;
                             pulLength: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetIndexDirection = function( hIndex: ADSHANDLE;
                                 usReverseDirection: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsMgKillUser90 = function( hMgmtHandle: ADSHANDLE;
                            pucUserName: PAceChar;
                            usConnNumber: UNSIGNED16;
                            usPropertyID: UNSIGNED16;
                            pvProperty: pointer;
                            usPropertyLen: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsGetFieldLength100 = function( hTable: ADSHANDLE;
                                 pucFldName: PAceChar;
                                 ulOptions: UNSIGNED32;
                                 pulLength: PUNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetRightsChecking = function( ulOptions: UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsSetTableTransactionFree = function( hTable: ADSHANDLE;
                                       usTransFree: UNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsIsTableTransactionFree = function( hTable: ADSHANDLE;
                                      pusTransFree: PUNSIGNED16 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsFindServers = function( ulOptions: UNSIGNED32;
                           phTable: pADSHANDLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsDDSetTriggerProperty = function( hDictionary : ADSHANDLE;
                                    pucTriggerName : PAceChar;
                                    usPropertyID : UNSIGNED16;
                                    pvProperty : pointer;
                                    usPropertyLen : UNSIGNED16 ) : UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsBinaryToFileW = function( hTable: ADSHANDLE;
                             pucFldName: PAceChar;
                             pwcFileName: PWideChar ) : UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  TAdsFileToBinaryW = function( hTable: ADSHANDLE;
                             pucFldName: PAceChar;
                             usBinaryType: UNSIGNED16;
                             pwcFileName: PWideChar ) : UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

  // Undocumented
  TAdsConvertStringToJulian = function(  pucJulian : PAceChar;
                                      usLen : UNSIGNED16;
                                      pdJulian : PDOUBLE ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}
  TAdsSetTimeStampRaw = function( hObj : ADSHANDLE;
                                pucFldName : PAceChar;
                                pucBuf : PAceChar;
                                ulLen : UNSIGNED32 ):UNSIGNED32; {$IFDEF WIN32}stdcall;{$ENDIF}{$IFDEF POSIX}cdecl;{$ENDIF}

implementation

end.
