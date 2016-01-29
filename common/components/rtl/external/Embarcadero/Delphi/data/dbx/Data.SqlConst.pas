{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.SqlConst;

interface

const
  DRIVERS_KEY = 'Installed Drivers'; //TDBXPropertyNames.InstalledDrivers; { Do not localize }
  CONNECTIONS_KEY = 'Installed Connections';    { Do not localize }
  DRIVERNAME_KEY = 'DriverName';                { Do not localize }
  HOSTNAME_KEY = 'HostName';                    { Do not localize }
  ROLENAME_KEY = 'RoleName';                    { Do not localize }
  DATABASENAME_KEY = 'Database'; //TDBXPropertyNames.Database; { Do not localize }
  MAXBLOBSIZE_KEY = 'BlobSize';                 { Do not localize }
  VENDORLIB_KEY = 'VendorLib'; //TDBXPropertyNames.VendorLib; { Do not localize }
  DLLLIB_KEY = 'LibraryName'; //TDBXPropertyNames.LibraryName;  { Do not localize }
  GETDRIVERFUNC_KEY = 'GetDriverFunc'; //TDBXPropertyNames.GetDriverFunc;{ Do not localize }
  AUTOCOMMIT_KEY = 'AutoCommit';                { Do not localize }
  BLOCKINGMODE_KEY = 'BlockingMode';            { Do not localize }
  WAITONLOCKS_KEY= 'WaitOnLocks';               { Do not localize }
  COMMITRETAIN_KEY = 'CommitRetain';            { Do not localize }
  TRANSISOLATION_KEY = '%s TransIsolation';     { Do not localize }
  SQLDIALECT_KEY = 'SqlDialect';                { Do not localize }
  SQLLOCALE_CODE_KEY = 'LocaleCode';            { Do not localize }
  ERROR_RESOURCE_KEY = 'ErrorResourceFile';     { Do not localize }
  SQLSERVER_CHARSET_KEY = 'ServerCharSet';      { Do not localize }
  CONNECTION_STRING = 'ConnectionString';       { Do not localize }
  SREADCOMMITTED = 'readcommitted';              { Do not localize }
  SREPEATREAD = 'repeatableread';               { Do not localize }
  SDIRTYREAD = 'dirtyread';                     { Do not localize }
  {$EXTERNALSYM szUSERNAME}
  szUSERNAME         = 'USER_NAME';             { Do not localize }
  szPASSWORD         = 'PASSWORD';              { Do not localize }
  SLocaleCode        = 'LCID';                  { Do not localize }
  ROWSETSIZE_KEY     = 'RowsetSize';            { Do not localize }
  OSAUTHENTICATION   = 'OS Authentication';     { Do not localize }
  SERVERPORT         = 'Server Port';           { Do not localize }
  MULTITRANSENABLED  = 'Multiple Transaction';  { Do not localize }
  TRIMCHAR           = 'Trim Char';             { Do not localize }
  CUSTOM_INFO        = 'Custom String';         { Do not localize }
  CONN_TIMEOUT       = 'Connection Timeout';    { Do not localize }
  TDSPACKETSIZE      = 'TDS Packet Size';       { Do not localize }
  CLIENTHOSTNAME     = 'Client HostName';       { Do not localize }
  CLIENTAPPNAME      = 'Client AppName';        { Do not localize }
  COMPRESSED         = 'Compressed';            { Do not localize }
  ENCRYPTED          = 'Encrypted';             { Do not localize }
  PREPARESQL         = 'Prepare SQL';           { Do not localize }
//  DECIMALSEPARATOR   = 'Decimal Separator';     { Do not localize }

resourcestring
  SLoginError = 'Cannot connect to database ''%s''';
  SMonitorActive = 'Cannot change connection on Active Monitor';
  SMissingConnection = 'Missing SQLConnection property';
  SDatabaseOpen = 'Cannot perform this operation on an open connection';
  SDatabaseClosed = 'Cannot perform this operation on a closed connection';
  SMissingSQLConnection = 'SQLConnection property required for this operation';
  SConnectionNameMissing = 'Connection name missing';
  SEmptySQLStatement = 'No SQL statement available';
  SNoParameterValue = 'No value for parameter ''%s''';
  SNoParameterType = 'No parameter type for parameter ''%s''';
  SParameterTypes = ';Input;Output;Input/Output;Result';
  SDataTypes = ';String;SmallInt;Integer;Word;Boolean;Float;Currency;BCD;Date;Time;DateTime;;;;Blob;Memo;Graphic;;;;;Cursor;';
  SResultName = 'Result';
  SNoTableName = 'Missing TableName property';
  SNoSqlStatement = 'Missing query, table name or procedure name';
  SNoDataSetField = 'Missing DataSetField property';
  SNoCachedUpdates = 'Not in cached update mode';
  SMissingDataBaseName = 'Missing Database property';
  SMissingDataSet = 'Missing DataSet property';
  SMissingDriverName = 'Missing DriverName property';
  SPrepareError = 'Unable to execute Query';
  SObjectNameError = 'Table/Procedure not found';
  SSQLDataSetOpen = 'Unable to determine field names for %s';
  SNoActiveTrans = 'There is no active transaction';
  SActiveTrans = 'A transaction is already active';
  SDllLoadError = 'Unable to Load %s';
  SDllProcLoadError = 'Unable to Find Procedure %s';
  SConnectionEditor = '&Edit Connection Properties';
  SAddConnectionString = '&Add ConnectionString Param';
  SRefreshConnectionString = 'R&efresh ConnectionString Param';
  SRemoveConnectionString = '&Remove ConnectionString Param';
  SCommandTextEditor = '&Edit CommandText';
  SMissingDLLName = 'DLL/Shared Library Name not Set';
  SMissingDriverRegFile = 'Driver/Connection Registry File ''%s'' not found';
  STableNameNotFound = 'Cannot find TableName in CommandText';
  SNoCursor = 'Cursor not returned from Query';
  SMetaDataOpenError = 'Unable to Open Metadata';
  SErrorMappingError = 'SQL Error: Error mapping failed';
  SStoredProcsNotSupported = 'Stored Procedures not supported by ''%s'' Server';
  SPackagesNotSupported = 'Packages are not supported by ''%s'' Server';
  STooManyActualParam = '%s: Actual number of parameters (%d) exceeds the current number of stored procedure parameters (%d). Either uncheck the ParamCheck component property or review the parameter list content';
  SDBXUNKNOWNERROR = 'dbExpress Error: Unknown Error Code ''%s''';

//#define DBXERR_NOTSUPPORTED            0x0005
  SNOTSUPPORTED = '[0x0005]: Operation Not Supported';

  SDBXError = 'dbExpress Error: %s';
  SSQLServerError = 'Database Server Error: %s';

  SConfFileMoveError = 'Unable to move %s to %s';
  SMissingConfFile = 'Configuration file %s not found';
  SObjectViewNotTrue = 'ObjectView must be True for Table with Object fields';
  SObjectTypenameRequired = 'Object type name required as parameter value';
  SCannotCreateFile = 'Cannot create file %s';
// used in SqlReg.pas
  SDlgOpenCaption = 'Open trace log file';
  SDlgFilterTxt = 'Text files (*.txt)|*.txt|All files (*.*)|*.*';
  SLogFileFilter = 'Log files (*.log)';
  SCircularProvider = 'Circular provider references not allowed.';
  SUnknownDataType = 'Unknown data type:  %s for %s parameter';
  SSaveConnectionParams = 'Save connection parameters';
  SReloadConnectionParams = 'Reload connection parameters';
  SGenerateClientClasses = 'Generate DataSnap client classes';

implementation

end.
