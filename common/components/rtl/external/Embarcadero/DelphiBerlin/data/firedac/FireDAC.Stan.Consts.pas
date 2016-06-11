{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                   FireDAC constants                   }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Stan.Consts;

interface

{$IFDEF MSWINDOWS}
uses
  Winapi.Messages;
{$ENDIF}

const
  C_FD_Version = '15.0.1 (Build 86746)';
  C_FD_Copyright = Chr($A9) + ' 2016 Embarcadero Technologies, Inc.';
  C_FD_Product = 'FireDAC';
  C_FD_ProductFull = 'Embarcadero' + Chr($AE) + ' ' + C_FD_Product;
  C_FD_ToolName = 'RAD Studio 10.1 Berlin';

  // EOL's
  C_FD_WinEOL = #13#10;
  C_FD_PosixEOL = #10;
{$IFDEF MSWINDOWS}
  C_FD_EOL = C_FD_WinEOL;
  C_FD_PathDelim = '\';
  C_FD_DLLExt = '.dll';
  C_FD_DLLFolder = 'bin';
{$ENDIF}
{$IFDEF LINUX}
  C_FD_EOL = C_FD_PosixEOL;
  C_FD_PathDelim = '/';
  C_FD_DLLExt = '.so';
  C_FD_DLLFolder = 'lib';
{$ENDIF}
{$IFDEF MACOS}
  C_FD_EOL = C_FD_PosixEOL;
  C_FD_PathDelim = '/';
  C_FD_DLLExt = '.dylib';
  C_FD_DLLFolder = 'lib';
{$ENDIF}
{$IFDEF ANDROID}
  C_FD_EOL = C_FD_PosixEOL;
  C_FD_PathDelim = '/';
  C_FD_DLLExt = '.so';
  C_FD_DLLFolder = 'lib';
{$ENDIF}

  // Common
{$IFDEF MSWINDOWS}
  C_FD_WM_Base    = WM_USER + 1000;
{$ENDIF}
  C_FD_GUIDStrLen = 38;
  C_FD_MaxNameLen = 128;
  C_FD_StorageVer = 15;

  // Layer ID's
  S_FD_LStan = 'Stan';
  S_FD_LStan_PEval = 'Eval';
  S_FD_LStan_PDef = 'Def';
  S_FD_LGUIx = 'GUIx';
  S_FD_LGUIx_PForms = 'Forms';
  S_FD_LGUIx_PSrvc = 'Services';
  S_FD_LMoni = 'Moni';
  S_FD_LMoni_PRemote = 'Remote';
  S_FD_LMoni_PFF = 'FlatFile';
  S_FD_LDatS = 'DatS';
  S_FD_LPhys = 'Phys';
  S_FD_LDApt = 'DApt';
  S_FD_LComp = 'Comp';
  S_FD_LComp_PClnt = 'Clnt';
  S_FD_LComp_PDS = 'DS';
  S_FD_LComp_PDM = 'DM';
  S_FD_LComp_PScr = 'Script';
  S_FD_LComp_Design = 'Design';

  // Driver ID's
  S_FD_TDBXId = 'TDBX';
  S_FD_ODBCId = 'ODBC';
  S_FD_MSSQLId = 'MSSQL';
  S_FD_MSAccId = 'MSAcc';
  S_FD_DB2Id = 'DB2';
  S_FD_MySQLId = 'MySQL';
  S_FD_OraId = 'Ora';
  S_FD_ASAId = 'ASA';
  S_FD_ADSId = 'ADS';
  S_FD_IBId = 'IB';
  S_FD_IBLiteId = 'IBLite';
  S_FD_FBId = 'FB';
  S_FD_PGId = 'PG';
  S_FD_SQLiteId = 'SQLite';
  S_FD_NexusId = 'Nexus';
  S_FD_DSId = 'DS';
  S_FD_InfxId = 'Infx';
  S_FD_TDataId = 'TData';
  S_FD_MongoId = 'Mongo';

  // RDBMS names
  S_FD_MSSQL_RDBMS = S_FD_MSSQLId;
  S_FD_MSAcc_RDBMS = 'MSAccess';
  S_FD_DB2_RDBMS = S_FD_DB2Id;
  S_FD_MySQL_RDBMS = S_FD_MySQLId;
  S_FD_Ora_RDBMS = 'Oracle';
  S_FD_ASA_RDBMS = 'SQLAnywhere';
  S_FD_ADS_RDBMS = 'Advantage';
  S_FD_IB_RDBMS = 'InterBase';
  S_FD_FB_RDBMS = 'Firebird';
  S_FD_PG_RDBMS = 'PostgreSQL';
  S_FD_SQLite_RDBMS = S_FD_SQLiteId;
  S_FD_Nexus_RDBMS = 'NexusDB';
  S_FD_DS_RDBMS = 'DataSnap';
  S_FD_Infx_RDBMS = 'Informix';
  S_FD_TData_RDBMS = 'Teradata';
  S_FD_Mongo_NoSQL = 'MongoDB';
  S_FD_Other_RDBMS = 'Other';

  // Definition standard parameters
  S_FD_DefinitionParam_Common_Name = 'Name';
  S_FD_DefinitionParam_Common_Parent = 'Parent';
  S_FD_DefinitionParam_Common_ConnectionDef = 'ConnectionDef';

  // Driver definition parameters
  C_FD_DrvBaseId = 'BaseDriverID';
  S_FD_DrvVendorLib = 'VendorLib';
  S_FD_DrvVendorHome = 'VendorHome';
  S_FD_Win32 = 'Win32';
  S_FD_Win64 = 'Win64';
  S_FD_OSX32 = 'OSX32';
  S_FD_OSX64 = 'OSX64';
  S_FD_UIX32 = 'UIX32';
  S_FD_UIX64 = 'UIX64';
  S_FD_ANDROID = 'ANDROID';

  // Monitor ID names
  S_FD_MoniFlatFile = 'FlatFile';
  S_FD_MoniRemote = 'Remote';
  S_FD_MoniCustom = 'Custom';

  // Connection definition standard parameters
  S_FD_ConnParam_Common_DriverID = 'DriverID';
  S_FD_ConnParam_Common_Database = 'Database';
  S_FD_ConnParam_Common_Server = 'Server';
  S_FD_ConnParam_Common_Port = 'Port';
  S_FD_ConnParam_Common_UserName = 'User_Name';
  S_FD_ConnParam_Common_BDEStyleUserName = 'User name';
  S_FD_ConnParam_Common_Password = 'Password';
  S_FD_ConnParam_Common_NewPassword = 'NewPassword';
  S_FD_ConnParam_Common_OSAuthent = 'OSAuthent';
  S_FD_ConnParam_Common_Pooled = 'Pooled';
  S_FD_ConnParam_Common_Pool_CleanupTimeout = 'POOL_CleanupTimeout';
  S_FD_ConnParam_Common_Pool_ExpireTimeout = 'POOL_ExpireTimeout';
  S_FD_ConnParam_Common_Pool_MaximumItems = 'POOL_MaximumItems';
  S_FD_ConnParam_Common_MetaDefSchema = 'MetaDefSchema';
  S_FD_ConnParam_Common_MetaDefCatalog = 'MetaDefCatalog';
  S_FD_ConnParam_Common_MetaCurSchema = 'MetaCurSchema';
  S_FD_ConnParam_Common_MetaCurCatalog = 'MetaCurCatalog';
  S_FD_ConnParam_Common_MetaCaseIns = 'MetaCaseIns';
  S_FD_ConnParam_Common_RDBMS = 'RDBMS';
  S_FD_ConnParam_Common_MonitorBy = 'MonitorBy';
  S_FD_ConnParam_Common_LoginTimeout = 'LoginTimeout';
  S_FD_ConnParam_Common_CharacterSet = 'CharacterSet';
  S_FD_ConnParam_Common_ExtendedMetadata = 'ExtendedMetadata';
  S_FD_ConnParam_Common_ApplicationName = 'ApplicationName';

  // MySQL parameters
  S_FD_ConnParam_MySQL_Compress = 'Compress';
  S_FD_ConnParam_MySQL_UseSSL = 'UseSSL';
  S_FD_ConnParam_MySQL_SSL_key = 'SSL_key';
  S_FD_ConnParam_MySQL_SSL_cert = 'SSL_cert';
  S_FD_ConnParam_MySQL_SSL_ca = 'SSL_ca';
  S_FD_ConnParam_MySQL_SSL_capath = 'SSL_capath';
  S_FD_ConnParam_MySQL_SSL_cipher = 'SSL_cipher';
  S_FD_ConnParam_MySQL_ResultMode = 'ResultMode';
  S_FD_ConnParam_MySQL_TinyIntFormat = 'TinyIntFormat';
  S_FD_ConnParam_MySQL_EmbeddedArgs = 'EmbeddedArgs';
  S_FD_ConnParam_MySQL_EmbeddedGroups = 'EmbeddedGroups';
  S_FD_ConnParam_MySQL_ReadTimeout = 'ReadTimeout';
  S_FD_ConnParam_MySQL_WriteTimeout = 'WriteTimeout';

  // Base ODBC parameters
  S_FD_ConnParam_ODBC_ODBCAdvanced = 'ODBCAdvanced';
  S_FD_ConnParam_ODBC_ODBCDriver = 'ODBCDriver';
  S_FD_ConnParam_ODBC_DataSource = 'DataSource';
  S_FD_ConnParam_ODBC_DSN = 'DSN';
  S_FD_ConnParam_ODBC_NumericFormat = 'NumericFormat';
  S_FD_ConnParam_ODBC_ODBCVersion = 'ODBCVersion';

  // MSSQL paramaters
  S_FD_ConnParam_MSSQL_Network = 'Network';
  S_FD_ConnParam_MSSQL_Address = 'Address';
  S_FD_ConnParam_MSSQL_MARS = 'MARS';
  S_FD_ConnParam_MSSQL_Workstation = 'Workstation';
  S_FD_ConnParam_MSSQL_Language = 'Language';
  S_FD_ConnParam_MSSQL_Encrypt = 'Encrypt';
  S_FD_ConnParam_MSSQL_VariantFormat = 'VariantFormat';
  S_FD_ConnParam_MSSQL_MetaCaseInsCat = 'MetaCaseInsCat';

  S_FD_EventKind_MSSQL_Events = 'QueryNotifies';

  // MSAccess parameters
  S_FD_ConnParam_MSAcc_SystemDB = 'SystemDB';
  S_FD_ConnParam_MSAcc_ReadOnly = 'ReadOnly';
  S_FD_ConnParam_MSAcc_StringFormat = 'StringFormat';
    S_FD_Choose = 'Choose';
    S_FD_Unicode = 'Unicode';
    S_FD_ANSI = 'ANSI';

  // ASA parameters
  S_FD_ConnParam_ASA_ToolLib = 'ToolLib';

  S_FD_ConnParam_ASA_DatabaseFile = 'DatabaseFile';
  S_FD_ConnParam_ASA_Compress = S_FD_ConnParam_MySQL_Compress;
  S_FD_ConnParam_ASA_Encrypt = S_FD_ConnParam_MSSQL_Encrypt;

  S_FD_EventKind_ASA_Events = 'Message';

  // ADS parameters
  S_FD_ConnParam_ADS_DateFormat = 'DateFormat';
  S_FD_ConnParam_ADS_Decimals = 'Decimals';
  S_FD_ConnParam_ADS_DefaultPath = 'DefaultPath';
  S_FD_ConnParam_ADS_SearchPath = 'SearchPath';
  S_FD_ConnParam_ADS_ShowDeleted = 'ShowDeleted';
  S_FD_ConnParam_ADS_Epoch = 'Epoch';
  S_FD_ConnParam_ADS_Exact = 'Exact';

  S_FD_ConnParam_ADS_Alias = 'Alias';
  S_FD_ConnParam_ADS_Protocol = 'Protocol';
  S_FD_ConnParam_ADS_Compress = S_FD_ConnParam_MySQL_Compress;
  S_FD_ConnParam_ADS_ServerTypes = 'ServerTypes';
  S_FD_ConnParam_ADS_Locking = 'Locking';
  S_FD_ConnParam_ADS_TableType = 'TableType';
  S_FD_ConnParam_ADS_TablePassword = 'TablePassword';
  S_FD_ConnParam_ADS_ADSAdvanced = 'ADSAdvanced';

  S_FD_EventKind_ADS_Events = 'Events';

  // Oracle parameters
  S_FD_ConnParam_Oracle_AuthMode = 'AuthMode';
//  S_FD_ConnParam_Oracle_Distributed = 'Distributed';
//  S_FD_ConnParam_Oracle_SrvIntName = 'Dist_SrvIntName';
  S_FD_ConnParam_Oracle_BooleanFormat = 'BooleanFormat';
  S_FD_ConnParam_Oracle_OracleAdvanced = 'OracleAdvanced';
  S_FD_ConnParam_Oracle_NLS_LANG = 'NLSLang';
  S_FD_ConnParam_Oracle_TNS_ADMIN = 'TNSAdmin';
  S_FD_ConnParam_Oracle_Threaded = 'Threaded';
  S_FD_ConnParam_Oracle_ReadTimeout = S_FD_ConnParam_MySQL_ReadTimeout;
  S_FD_ConnParam_Oracle_WriteTimeout = S_FD_ConnParam_MySQL_WriteTimeout;

  S_FD_EventKind_Oracle_DBMS_ALERT = 'DBMS_ALERT';
  S_FD_EventKind_Oracle_DBMS_PIPE = 'DBMS_PIPE';
  S_FD_EventKind_Oracle_CQN = S_FD_EventKind_MSSQL_Events;

  // IB and FB parameters
  S_FD_ConnParam_IB_Protocol = S_FD_ConnParam_ADS_Protocol;
  S_FD_ConnParam_IB_RoleName = 'RoleName';
  S_FD_ConnParam_IB_SQLDialect = 'SQLDialect';
  S_FD_ConnParam_IB_OpenMode = 'OpenMode';
  S_FD_ConnParam_IB_DropDatabase = 'DropDatabase';
  S_FD_ConnParam_IB_PageSize = 'PageSize';
  S_FD_ConnParam_IB_IBAdvanced = 'IBAdvanced';
  // IB-only parameters
  S_FD_ConnParam_IB_Lite = 'Lite';
  S_FD_ConnParam_IB_InstanceName = 'InstanceName';
  S_FD_ConnParam_IB_SEPassword = 'SEPassword';
  // FB-only parameters
  S_FD_ConnParam_FB_Embedded = 'Embedded';

  S_FD_EventKind_IB_Events = 'Events';

  // DB2 parameters
  S_FD_ConnParam_DB2_Alias = 'Alias';
  S_FD_ConnParam_DB2_Protocol = S_FD_ConnParam_ADS_Protocol;
  S_FD_ConnParam_DB2_StringFormat = S_FD_ConnParam_MSAcc_StringFormat;
  S_FD_ConnParam_DB2_TxSupported = 'TxSupported';

  S_FD_EventKind_DB2_DBMS_ALERT = 'DBMS_ALERT';
  S_FD_EventKind_DB2_DBMS_PIPE = 'DBMS_PIPE';

  // PG parameters
  S_FD_ConnParam_PG_OidAsBlob = 'OidAsBlob';
  S_FD_ConnParam_PG_UnknownFormat = 'UnknownFormat';
  S_FD_ConnParam_PG_ArrayScanSample = 'ArrayScanSample';
  S_FD_ConnParam_PG_PGAdvanced = 'PGAdvanced';

  S_FD_EventKind_PG_Events = 'Notifies';

  // SQLite parameters
  S_FD_ConnParam_SQLite_SharedCache = 'SharedCache';
  S_FD_ConnParam_SQLite_OpenMode = S_FD_ConnParam_IB_OpenMode;
  S_FD_ConnParam_SQLite_Encrypt = S_FD_ConnParam_MSSQL_Encrypt;
  S_FD_ConnParam_SQLite_BusyTimeout = 'BusyTimeout';
  S_FD_ConnParam_SQLite_CacheSize = 'CacheSize';
  S_FD_ConnParam_SQLite_LockingMode = 'LockingMode';
  S_FD_ConnParam_SQLite_Synchronous = 'Synchronous';
  S_FD_ConnParam_SQLite_JournalMode = 'JournalMode';
  S_FD_ConnParam_SQLite_ForeignKeys = 'ForeignKeys';
  S_FD_ConnParam_SQLite_StringFormat = S_FD_ConnParam_MSAcc_StringFormat;
  S_FD_ConnParam_SQLite_GUIDFormat = 'GUIDFormat';
  S_FD_ConnParam_SQLite_DateTimeFormat = 'DateTimeFormat';
  S_FD_ConnParam_SQLite_Extensions = 'Extensions';
  S_FD_ConnParam_SQLite_SQLiteAdvanced = 'SQLiteAdvanced';

  S_FD_EventKind_SQLite_Events = 'Events';

  // Nexus parameters
  S_FD_ConnParam_Nexus_Protocol = S_FD_ConnParam_ADS_Protocol;
  S_FD_ConnParam_Nexus_OpenMode = S_FD_ConnParam_IB_OpenMode;
  S_FD_ConnParam_Nexus_ShareMode = 'ShareMode';

  // dbExpress / DataSnap parameters
  S_FD_ConnParam_TDBX_DBXAdvanced = 'DBXAdvanced';
  S_FD_ConnParam_DS_Protocol = S_FD_ConnParam_ADS_Protocol;

  S_FD_EventKind_DS_Events = 'Callbacks';

  // Informix parameters
  S_FD_ConnParam_Infx_DBCharacterSet = 'DBCharacterSet';
  S_FD_ConnParam_Infx_StringFormat = S_FD_ConnParam_MSAcc_StringFormat;
  S_FD_ConnParam_Infx_ReadTimeout = S_FD_ConnParam_MySQL_ReadTimeout;
  S_FD_ConnParam_Infx_WriteTimeout = S_FD_ConnParam_MySQL_WriteTimeout;
  S_FD_ConnParam_Infx_TxSupported = S_FD_ConnParam_DB2_TxSupported;
  S_FD_ConnParam_Infx_TxRetainLocks = 'TxRetainLocks';
  S_FD_ConnParam_Infx_TxLastCommitted = 'TxLastCommitted';

  S_FD_EventKind_Infx_DBMS_ALERT = 'DBMS_ALERT';

  // Teradata parameters
  S_FD_ConnParam_TData_Encrypt = S_FD_ConnParam_MSSQL_Encrypt;
  S_FD_ConnParam_TData_SessionMode = 'SessionMode';

  // MongoDB parameters
  S_FD_ConnParam_Mongo_UseSSL = S_FD_ConnParam_MySQL_UseSSL;
  S_FD_ConnParam_Mongo_ReadTimeout = S_FD_ConnParam_MySQL_ReadTimeout;
  S_FD_ConnParam_Mongo_MoreHosts = 'MoreHosts';
  S_FD_ConnParam_Mongo_MongoAdvanced = 'MongoAdvanced';

  S_FD_EventKind_Mongo_Tail = 'Tail';

{$IFDEF MSWINDOWS}
  // Async exec messages
  C_FD_WM_ASYNC_DONE = C_FD_WM_Base + 1;
  // Monitor
  C_FD_WM_MoniMainFrmRunning = C_FD_WM_Base + 10;
{$ENDIF}

  // Pool default values
  C_FD_PoolCleanupTimeout = 30000;
  C_FD_PoolExpireTimeout = 90000;
  C_FD_PoolCloseTimeout = 10000;
  C_FD_PoolMaximumItems = 50;

  // Wait default values
  C_FD_HideCursorDelay = 50;
  C_FD_DelayBeforeFWait = 200;

  // Thread default values
  C_FD_ThreadStartupTimeout = 1000;
  C_FD_ThreadIdleTimeout = 1000;

  // Phys manager default timeout values
  C_FD_PhysManagerShutdownTimeout = 10000;

  // Auto reconnect values
  C_FD_PhysConnRetryDelay = 3000;
  C_FD_PhysConnRetryCount = 3;

  // Definition related
{$IFDEF MSWINDOWS}
  S_FD_Main = '';
  S_FD_CfgKeyName = '\Software\Embarcadero\FireDAC';
{$ENDIF}
{$IFDEF POSIX}
  S_FD_Main = 'main';
  // The following is a path in HOME directory
  S_FD_CfgFile = {$IFDEF ANDROID} 'fd.conf' {$ELSE}
                 {$IFDEF IOS}     'fd.conf' {$ELSE}
                                  '.firedac/fd.conf' {$ENDIF} {$ENDIF};
{$ENDIF}
  S_FD_DefCfgFileName = 'FDConnectionDefs.ini';
  S_FD_DefDrvFileName = 'FDDrivers.ini';
  S_FD_CfgValName = 'ConnectionDefFile';
  S_FD_DrvValName = 'DriverFile';
  S_FD_MoniValName = 'MonitorPath';
  S_FD_ExplValName = 'ExplorerPath';
  S_FD_ExecValName = 'ExecutorPath';
  S_FD_HelpValName = 'HelpPath';
  S_FD_Profiles = 'Profiles';
  S_FD_Drivers = 'Drivers';
  S_FD_DesignTime = 'DesignTime';
  S_FD_DTCatalog = 'Catalog';
  S_FD_DTSchema = 'Schema';
  S_FD_DTScope = 'Scope';
  S_FD_DTTableKinds = 'TableKinds';
  S_FD_DTFullName = 'FullName';
  S_FD_DTTracing = 'Tracing';
  S_FD_DTDCFieldsEditor = 'DCFieldsEditor';
  S_FD_DTMask = 'Mask';
  S_FD_True = 'True';
  S_FD_False = 'False';
  S_FD_Yes = 'Yes';
  S_FD_No = 'No';
  S_FD_Bools: array[Boolean] of String = (S_FD_False, S_FD_True);
  S_FD_Local = '<LOCAL>';

  // GUIx
  C_FD_GUIxFormsProvider = 'Forms';
  C_FD_GUIxConsoleProvider = 'Console';
  C_FD_GUIxFMXProvider = 'FMX';

  // DatS
  C_FD_SysNamePrefix = '_FD_';
  C_FD_SysSavepointPrefix = 'SP_';
  C_FD_SysColumnPrefix = 'FD__';
  C_FD_MaxAggsPerView = 64;

  C_FD_CrsPctClose = 80;

  S_FD_Pi = '3.141592653589';
  C_FD_Pi =  3.1415926535897932384626433832795;

  // Command generator
  C_FD_CmdGenRight = 60;
  C_FD_CmdGenAlias = 'A';
  C_FD_CmdGenWindow = C_FD_SysColumnPrefix + 'WN_';
  C_FD_CmdGenRangeStart = C_FD_SysColumnPrefix + 'RS_';
  C_FD_CmdGenRangeFinish = C_FD_SysColumnPrefix + 'RF_';
  C_FD_CmdGenLocate = C_FD_SysColumnPrefix + 'LC_';

  // Some Oracle versions
  cvOracle80000 = 800000000;
  cvOracle80300 = 800030000;
  cvOracle80400 = 800040000;
  cvOracle80500 = 800050000;
  cvOracle80501 = 800050001;
  cvOracle81000 = 801000000;
  cvOracle81500 = 801050000;
  cvOracle81600 = 801060000;
  cvOracle90000 = 900010101;
  cvOracle92000 = 902000000;
  cvOracle100000 = 1000000000;
  cvOracle102000 = 1002000000;
  cvOracle110000 = 1100000000;
  cvOracle111000 = 1101000000;
  cvOracle112000 = 1102000000;
  cvOracle120000 = 1200000000;

  // Some MySQL versions
  mvMySQL032000 = 0320000000;
  mvMySQL032300 = 0323000000;
  mvMySQL032306 = 0323060000;
  mvMySQL032314 = 0323140000;
  mvMySQL032321 = 0323210000;
  mvMySQL040000 = 0400000000;
  mvMySQL040002 = 0400020000;
  mvMySQL040018 = 0400180000;
  mvMySQL040100 = 0401000000;
  mvMySQL040101 = 0401010000;
  mvMySQL041000 = 0410000000;
  mvMySQL050000 = 0500000000;
  mvMySQL050002 = 0500020000;
  mvMySQL050006 = 0500060000;
  mvMySQL050007 = 0500070000;
  mvMySQL050010 = 0500100000;
  mvMySQL050023 = 0500230000;
  mvMySQL050060 = 0500600000;
  mvMySQL050100 = 0501000000;
  mvMySQL050200 = 0502000000;
  mvMySQL050500 = 0505000000;
  mvMySQL050600 = 0506000000;
  mvMySQL060200 = 0602000000;

  // Some MSSQL versions
  svMSSQL6    = 0600000000;
  svMSSQL7    = 0700000000;
  svMSSQL2000 = 0800000000;
  svMSSQL2005 = 0900000000;
  svMSSQL2008 = 1000000000;
  svMSSQL2012 = 1100000000;

  // Some Sybase ASA versions
  cvSybaseASA6 = 0600000000;
  cvSybaseASA8 = 0800000000;
  cvSybaseASA9 = 0900000000;
  cvSybaseASA10 = 1000000000;
  cvSybaseASA11 = 1100000000;
  cvSybaseASA12 = 1200000000;
  cvSybaseASA16 = 1600000000;

  // Some SQLite versions
  svSQLite030000 = 0300000000;
  svSQLite030202 = 0302020000;
  svSQLite030304 = 0303040000;
  svSQLite030313 = 0303130000;
  svSQLite030400 = 0304000000;
  svSQLite030401 = 0304010000;
  svSQLite030500 = 0305000000;
  svSQLite030508 = 0305080000;
  svSQLite030600 = 0306000000;
  svSQLite030601 = 0306010000;
  svSQLite030604 = 0306040000;
  svSQLite030605 = 0306050000;
  svSQLite030608 = 0306080000;
  svSQLite030611 = 0306110000;
  svSQLite030619 = 0306190000;
  svSQLite030623 = 0306230000;
  svSQLite030700 = 0307000000;
  svSQLite030703 = 0307030000;
  svSQLite030707 = 0307070000;
  svSQLite030711 = 0307110000;
  svSQLite030715 = 0307150000;
  svSQLite030803 = 0308030000;
  svSQLite030807 = 0308070000;
  svSQLite030809 = 0308090000;

  // Some PGSQL versions
  svPGSQL070300 = 0703000000;
  svPGSQL080100 = 0801000000;
  svPGSQL080200 = 0802000000;
  svPGSQL080300 = 0803000000;
  svPGSQL090000 = 0900000000;
  svPGSQL090100 = 0901000000;
  svPGSQL090500 = 0905000000;

  // Some IB/FB versions
  ivFB010002 = 100020000;
  ivFB010003 = 100030000;
  ivFB010500 = 105000000;
  ivFB020000 = 200000000;
  ivFB020100 = 201000000;
  ivFB020500 = 205000000;
  ivFB030000 = 300000000;
  ivIB060500 = 605000000;
  ivIB070000 = 700000000;
  ivIB070100 = 701000000;
  ivIB070500 = 705000000;
  ivIB080000 = 800000000;  // IB2007
  ivIB090000 = 900000000;  // IB2009
  ivIB100000 = 1000000000; // IBXE
  ivIB110000 = 1100000000; // IBXE3
  ivIB120000 = 1200000000; // IBXE7
  ivIB120100 = 1201000000; // IBXE7.1 BigBang
  ivYF080607 = 806070000;

  // Some ODBC versions
  ovODBC2 = 200000000;
  ovODBC3 = 300000000;
  ovODBC38 = 380000000;

  // Some Advantage versions
  caADS8 = 800000000;
  caADS9 = 900000000;
  caADS10 = 1000000000;
  caADS12 = 1200000000;

  // Some Informix versions
  ivInfx1110 = 1110000000;

  // Some Teradata versions
  tvTData1300 = 1300000000;
  tvTData1400 = 1400000000;
  tvTData1410 = 1410000000;

  // Some DB2 and DB2/AS400 versions
  avDB2_400_7 = 0700000000;

  // Default data length's
  C_FD_DefLongSize = 0;
  C_FD_MaxPLSQLDataSize = 32767;
  C_FD_DefStrSize = 255;
  C_FD_DefNumericSize = 30;
  C_FD_MaxFixedSize = 134; // BCD -> WIDE STR: 2 * (64 digits + 1 sign + 1 dec.sep. + 1 zero byte)
  C_FD_DefInlineDataSize = 1000;
  C_FD_DefPieceBuffLen = $40000;
  C_FD_DefRowSetSize = 50;
  C_FD_DefMaxStrSize = C_FD_MaxPLSQLDataSize;

  // Default data type mapping
  C_FD_DefMapPrec = -1;
  C_FD_DefMapScale = -1;
  C_FD_DefMapSize = $FFFFFFFF;

  // Error codes
  er_FD_DuplicatedName = 1;
  er_FD_NameNotFound = 2;
  er_FD_ColTypeUndefined = 3;
  er_FD_NoColsDefined = 4;
  er_FD_CheckViolated = 5; // * 1-> cons name, 0-> message
  er_FD_CantBeginEdit = 6;
  er_FD_CantCreateChildView = 7;
  er_FD_RowCantBeDeleted = 8;
  er_FD_ColMBBlob = 9;
  er_FD_FixedLenDataMismatch = 10;
  er_FD_RowNotInEditableState = 11;
  er_FD_ColIsReadOnly = 12;
  er_FD_RowCantBeInserted = 13;
  er_FD_RowColMBNotNull = 14;
  er_FD_DuplicateRows = 15; // * 1-> cons name, 0-> message
  er_FD_NoMasterRow = 16; // * 1-> cons name, 0-> message
  er_FD_HasChildRows = 17; // * 1-> cons name, 0-> message
  er_FD_CantCompareRows = 18;
  er_FD_ConvIsNotSupported = 19;
  er_FD_ColIsNotSearchable = 20;
  er_FD_RowMayHaveSingleParent = 21;
  er_FD_CantOperateInvObj = 22;
  er_FD_CantSetParentRow = 23;
  er_FD_RowIsNotNested = 24;
  er_FD_ColumnIsNotRef = 25;
  er_FD_ColumnIsNotSetRef = 26;
  er_FD_OperCNBPerfInState = 28;
  er_FD_CantSetUpdReg = 29;
  er_FD_TooManyAggs = 30;
  er_FD_GrpLvlExceeds = 31;
  er_FD_VarLenDataMismatch = 32;
  er_FD_BadForeignKey = 33;
  er_FD_BadUniqueKey = 34;
  er_FD_CantChngColType = 35;
  er_FD_BadRelation = 36;
  er_FD_CantCreateParentView = 37;
  er_FD_CantChangeTableStruct = 38;
  er_FD_FoundCascadeLoop = 39;
  er_FD_RecLocked = 40;
  er_FD_RecNotLocked = 41;
  er_FD_TypeIncompat = 42;
  er_FD_ValueOutOfRange = 43;
  er_FD_CantMerge = 44;

  er_FD_ColumnDoesnotFound = 100;
  er_FD_ExprTermination = 101;
  er_FD_ExprMBAgg = 102;
  er_FD_ExprCantAgg = 103;
  er_FD_ExprTypeMis = 104;
  er_FD_ExprIncorrect = 105;
  er_FD_InvalidKeywordUse = 106;
  er_FD_ExprInvalidChar = 107;
  er_FD_ExprNameError = 108;
  er_FD_ExprStringError = 109;
  er_FD_ExprNoLParen = 110;
  er_FD_ExprNoRParenOrComma = 111;
  er_FD_ExprNoRParen = 112;
  er_FD_ExprEmptyInList = 113;
  er_FD_ExprExpected = 114;
  er_FD_ExprNoArith = 115;
  er_FD_ExprBadScope = 116;
  er_FD_ExprEmpty = 117;
  er_FD_ExprEvalError = 118;

  er_FD_DSNoBookmark = 200;
  er_FD_DSViewNotSorted = 201;
  er_FD_DSNoAdapter = 202;
  er_FD_DSNoNestedMasterSource = 203;
  er_FD_DSCircularDataLink = 204;
  er_FD_DSRefreshError = 205;
  er_FD_DSNoDataTable = 206;
  er_FD_DSIndNotFound = 207;
  er_FD_DSAggNotFound = 208;
  er_FD_DSIndNotComplete = 209;
  er_FD_DSAggNotComplete = 210;
  er_FD_DSCantUnidir = 211;
  er_FD_DSIncompatBmkFields = 212;
  er_FD_DSCantEdit = 213;
  er_FD_DSCantInsert = 214;
  er_FD_DSCantDelete = 215;
  er_FD_DSFieldNotFound = 216;
  er_FD_DSCantOffline = 217;
  er_FD_DSCantOffCachedUpdates = 218;

  er_FD_DefCircular = 250;
  er_FD_DefRO = 251;
  er_FD_DefCantMakePers = 252;
  er_FD_DefAlreadyLoaded = 253;
  er_FD_DefNotExists = 254;
  er_FD_DefDupName = 255;

  er_FD_AccSrvNotFound = 300;
  er_FD_AccCannotReleaseDrv = 301;
  er_FD_AccSrvMBConnected = 302;
  er_FD_AccCapabilityNotSup = 303;
  er_FD_AccTxMBActive = 304;
  er_FD_AccCantChngCommandState = 305;
  er_FD_AccCommandMBFilled = 306;
  er_FD_AccEscapeEmptyName = 307;
  er_FD_AccCmdMHRowSet = 308;
  er_FD_AccCmdMBPrepared = 309;
  er_FD_AccCantExecCmdWithRowSet = 310;
  er_FD_AccCmdMBOpen4Fetch = 311;
  er_FD_AccExactMismatch = 312;
  er_FD_AccMetaInfoMismatch = 313;
  er_FD_AccCantLoadLibrary = 314;
  er_FD_AccCantGetLibraryEntry = 315;
  er_FD_AccSrvMBDisConnected = 316;
  er_FD_AccToManyLogins = 317;
  er_FD_AccTxMBInActive = 318;
  er_FD_AccDrvMngrMB = 320;
  er_FD_AccPrepMissed = 321;
  er_FD_AccPrepTooLongIdent = 323;
  er_FD_AccParamArrayMismatch = 325;
  er_FD_AccAsyncOperInProgress = 326;
  er_FD_AccEscapeIsnotSupported = 327;
  er_FD_AccMetaInfoReset = 328;
  er_FD_AccWhereIsEmpty = 329;
  er_FD_AccUpdateTabUndefined = 330;
  er_FD_AccNameHasErrors = 331;
  er_FD_AccEscapeBadSyntax = 332;
  er_FD_AccShutdownTO = 334;
  er_FD_AccParTypeUnknown = 335;
  er_FD_AccParDataMapNotSup = 336;
  er_FD_AccColDataMapNotSup = 337;
  er_FD_AccParDefChanged = 338;
  er_FD_AccMetaInfoNotDefined = 339;
  er_FD_AccSrvNotDefined = 340;
  er_FD_AccArrayExecError = 341;
  er_FD_AccCantAssignTxIntf = 343;
  er_FD_AccParSetChanged = 344;
  er_FD_AccDataToLarge = 345;
  er_FD_AccDbNotExists = 346;
  er_FD_AccClassNotRegistered = 347;
  er_FD_AccSysClassNotRegistered = 348;
  er_FD_AccUnrecognizedDbFormat = 349;
  er_FD_AccNotValidPassword = 350;
  er_FD_AccUnknownOleError = 351;
  er_FD_AccUnsupParamObjValue = 352;
  er_FD_AccUnsupColumnType = 353;

  er_FD_SvcLinkMBSet = 370;
  er_FD_SvcMBActive = 371;
  er_FD_SvcCannotUninstall = 372;

  er_FD_DAptRecordIsDeleted = 400;
  er_FD_DAptNoSelectCmd = 402;
  er_FD_DAptRecordIsChanged = 403;
  er_FD_DAptApplyUpdateFailed = 404;
  er_FD_DAptCantEdit = 405;
  er_FD_DAptCantInsert = 406;
  er_FD_DAptCantDelete = 407;

  er_FD_ClntSessMBSingle = 500;
  er_FD_ClntSessMBInactive = 501;
  er_FD_ClntSessMBActive = 502;
  er_FD_ClntDbDupName = 503;
  er_FD_ClntDbMBInactive = 504;
  er_FD_ClntDbMBActive = 505;
  er_FD_ClntDbLoginAborted = 506;
  er_FD_ClntDbCantConnPooled = 507;
  er_FD_ClntDBNotFound = 508;
  er_FD_ClntAdaptMBActive = 509;
  er_FD_ClntAdaptMBInactive = 510;
  er_FD_ClntNotCachedUpdates = 511;
  er_FD_ClntDbNotDefined = 512;
  er_FD_ClntDbMBOnline = 513;
  er_FD_ClntTxMBActive = 514;
  er_FD_ClntCantShareAdapt = 515;
  er_FD_ClntConnNotMatch = 516;
  er_FD_ClntPKNotFound = 517;
  er_FD_ClntLocalSQLMisuse = 518;
  er_FD_ClntWrongIndex = 519;
  er_FD_ClntDSNameEmpty = 520;
  er_FD_ClntDSNameNotUnique = 521;
  er_FD_ClntDataSetParamIncompat = 522;

  er_FD_DPNoTxtFld = 600;
  er_FD_DPNoSrcDS = 601;
  er_FD_DPNoDestDS = 602;
  er_FD_DPNoTxtDest = 603;
  er_FD_DPNoTxtSrc = 604;
  er_FD_DPBadFixedSize = 605;
  er_FD_DPTxtFldDup = 606;
  er_FD_DPBadTextFmt = 607;
  er_FD_DPSrcUndefined = 608;
  er_FD_DPDestNoKeyFields = 609;
  er_FD_DPNoSQLTab = 610;
  er_FD_DPNoSQLBatch = 611;
  er_FD_DPNoTxtFlds = 612;

  er_FD_StanTimeout = 700;
  er_FD_StanCantGetBlob = 701;
  er_FD_StanParamOverflow = 704;
  er_FD_StanCantNonblocking = 705;
  er_FD_StanMacroNotFound = 706;
  er_FD_StanBadParRowIndex = 707;
  er_FD_StanPoolTooManyItems = 708;
  er_FD_StanStrgInvBinFmt = 710;
  er_FD_StanStrgCantReadProp = 711;
  er_FD_StanStrgCantReadObj = 712;
  er_FD_StanStrgCantReadCDATA = 713;
  er_FD_StanStrgDictOverflow = 714;
  er_FD_StanStrgClassUnknown = 715;
  er_FD_StanStrgUnknownFmt = 716;
  er_FD_StanStrgFileError = 717;
  er_FD_StanStrgInvDIntFmt = 718;
  er_FD_StanStrgInvJSONFmt = 719;

  er_FD_ScrCantExecHostCmd = 800;
  er_FD_ScrStrSize1 = 801;
  er_FD_ScrStrNotAlphaNum = 802;
  er_FD_ScrSetArgInvalid = 803;
  er_FD_ScrInvalidSyntax = 804;
  er_FD_ScrAccMustSpecVar = 805;
  er_FD_ScrDefReqValue = 806;
  er_FD_ScrVarMissedCloseBrace = 807;
  er_FD_ScrVarUnsupType = 808;
  er_FD_ScrNotLogged = 809;
  er_FD_ScrNoCmds = 810;
  er_FD_ScrNoScript = 811;

  er_FD_DBXGeneral = 1000;
  er_FD_DBXParMBNotEmpty = 1001;
  er_FD_DBXNoDriverCfg = 1002;

  er_FD_MySQLGeneral = 1100;
  er_FD_MySQLBadVersion = 1101;
  er_FD_MySQLCantSetPort = 1102;
  er_FD_MySQLBadParams = 1103;
  er_FD_MySQLCantInitEmbeddedServer = 1104;

  er_FD_OdbcGeneral = 1200;
  er_FD_OdbcLongDataStream = 1201;
  er_FD_OdbcVarDataTypeUnsup = 1202;

  er_FD_OraGeneral = 1300;
  er_FD_OraCantSetCharset = 1301;
  er_FD_OraNoCursor = 1305;
  er_FD_OraCantAssFILE = 1307;
  er_FD_OraNoCursorParams = 1308;
  er_FD_OraNotInstalled = 1309;
  er_FD_OraBadVersion = 1310;
  er_FD_OraBadValueType = 1315;
  er_FD_OraBadVarType = 1319;
  er_FD_OraTooLongGTRID = 1323;
  er_FD_OraTooLongBQUAL = 1324;
  er_FD_OraTooLongTXName = 1325;
  er_FD_OraDBTNManyClBraces = 1326;
  er_FD_OraNotPLSQLObj = 1327;
  er_FD_OraNotPackageProc = 1329;
  er_FD_OraBadTableType = 1330;
  er_FD_OraUnNamedRecParam = 1331;
  er_FD_OraCantConvNum = 1332;
  er_FD_OraPipeAlertToMany = 1333;

  er_FD_IBGeneral = 1400;
  er_FD_IBTraceIsActive = 1401;
  er_FD_IBArrayDMLWithIntStr = 1402;

  er_FD_PgGeneral = 1500;
  er_FD_PgProcNotFound = 1501;
  er_FD_PgMultiDimArrNotSup = 1502;
  er_FD_PgUnsupArrValueTypeNotSup = 1503;
  er_FD_PgArrIndexOutOfBound = 1504;
  er_FD_PgCannotDescribeType = 1505;
  er_FD_PgIsNotArray = 1506;

  er_FD_SQLiteGeneral = 1600;
  er_FD_SQLiteInitFailed = 1601;
  er_FD_SQLiteAlgFailure = 1602;
  er_FD_SQLitePwdInvalid = 1603;
  er_FD_SQLiteDBUnencrypted = 1604;
  er_FD_SQLiteDBNotFound = 1605;
  er_FD_SQLiteVTabInvalidArgs = 1650;
  er_FD_SQLiteVTabDSNotFoundOrEmpty = 1651;
  er_FD_SQLiteVTabDSNotSupported = 1652;
  er_FD_SQLiteVTabDSSPNotFound = 1653;
  er_FD_SQLiteVTabDSDataModFailed = 1654;
  er_FD_SQLiteVTabDSRowidInvalid = 1655;
  er_FD_SQLiteVTabDSChangedOrFreed = 1656;
  er_FD_SQLiteVTabDSNoRowExists = 1657;
  er_FD_SQLiteVTabDSCursorInvalid = 1658;
  er_FD_SQLiteVTabCannotAttach = 1659;
  er_FD_SQLiteVTabDataSetBusy = 1660;

  er_FD_ASAGeneral = 1700;
  er_FD_ASADBToolNotFound = 1701;

  er_FD_ADSGeneral = 1800;

  er_FD_NexusGeneral = 1900;

  er_FD_MSSQLGeneral = 2000;
  er_FD_MSSQLFSNoTx = 2001;
  er_FD_MSSQLFSNoPath = 2002;
  er_FD_MSSQLFSIOError = 2003;
  er_FD_MSSQLQNSubError = 2004;

  er_FD_MongoGeneral = 2100;
  er_FD_MongoError = 2101;
  er_FD_MongoBadURI = 2102;
  er_FD_MongoDocReadOnly = 2103;
  er_FD_MongoFailedInitBSON = 2104;
  er_FD_MongoBulkError = 2105;
  er_FD_MongoCursorError = 2106;
  er_FD_MongoExecuteError = 2107;
  er_FD_MongoDBRefInvalid = 2108;
  er_FD_MongoDBRefNotFound = 2109;
  er_FD_MongoCannotOpenDataSet = 2110;
  er_FD_MongoFieldTypeMismatch = 2111;
  er_FD_MongoFieldIsNotFound = 2112;
  er_FD_MongoAlertToMany = 2113;

implementation

end.
