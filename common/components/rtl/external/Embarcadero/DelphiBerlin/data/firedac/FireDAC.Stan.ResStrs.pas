{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{               FireDAC resource strings                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FireDAC.Stan.ResStrs;

interface

uses
  FireDAC.Stan.Consts;

resourcestring
  {-------------------------------------------------------------------------------}
  // Product links

  S_FD_Docu_ExplorerLink =  'http://docwiki.embarcadero.com/RADStudio/en/FDExplorer';
  S_FD_Docu_ConnectToLink = 'http://docwiki.embarcadero.com/RADStudio/en/Connect_to_%s_(FireDAC)';
  S_FD_Docu_FAQLink = 'http://docwiki.embarcadero.com/RADStudio/en/FAQ_(FireDAC)';
  S_FD_Prod_Link = 'http://www.embarcadero.com/products/rad-studio/firedac';
  S_FD_Forums_Link = 'https://forums.embarcadero.com/forum.jspa?forumID=503';

  {-------------------------------------------------------------------------------}
  // Dialog captions

  S_FD_ErrorDialogDefCaption = 'FireDAC Error';
  S_FD_LoginDialogDefCaption = 'FireDAC Login';
  S_FD_AsyncDialogDefCaption = 'FireDAC Working';
  S_FD_ScriptDialogDefCaption = 'FireDAC Processing';
  S_FD_LoginDialogTestOk = 'Connection established successfully.';
  S_FD_WizardNotAccessible = 'The wizard is not implemented for this driver.';
  S_FD_LoginCredentials = 'Enter your credentials';
  S_FD_LoginNewPassword = 'Enter your new password';
  S_FD_AsyncDialogDefPrompt = 'Please wait, application is busy ...';

  {-------------------------------------------------------------------------------}
  // Error messages

  S_FD_DuplicatedName = 'Name [%s] is duplicated in the list';
  S_FD_NameNotFound = 'Object [%s] is not found';
  S_FD_ColTypeUndefined = 'Column [%s] type is unknown or undefined';
  S_FD_NoColsDefined = 'No columns defined for table';
  S_FD_CheckViolated = 'Check condition violated. Constraint [%s]';
  S_FD_CantBeginEdit = 'Cannot begin edit row';
  S_FD_CantCreateChildView = 'Cannot create child view. Relation [%s]';
  S_FD_RowCantBeDeleted = 'Cannot delete row';
  S_FD_ColMBBLob = 'Column [%s] must have blob value';
  S_FD_FixedLenDataMismatch = 'Fixed length column [%s] data length mismatch. Value length - [%d], column fixed length - [%d]';
  S_FD_RowNotInEditableState = 'Row is not in editable state';
  S_FD_ColIsReadOnly = 'Column [%s] is read only';
  S_FD_RowCantBeInserted = 'Cannot insert row into table';
  S_FD_RowColMBNotNull = 'Column [%s] value must be not null';
  S_FD_DuplicateRows = 'Duplicate row found on unique index. Constraint [%s]';
  S_FD_NoMasterRow = 'Cannot process - no parent row. Constraint [%s]';
  S_FD_HasChildRows = 'Cannot process - child rows found. Constraint [%s]';
  S_FD_CantCompareRows = 'Cannot compare rows';
  S_FD_ConvIsNotSupported = 'Data type conversion is not supported';
  S_FD_ColIsNotSearchable = 'Column [%s] is not searchable';
  S_FD_RowMayHaveSingleParent = 'Row may have only single column of [dtParentRowRef] data type';
  S_FD_CantOperateInvObj = 'Cannot read data from or write data to the invariant column [%s]. Hint: use properties and methods, like a NestedTable';
  S_FD_CantSetParentRow = 'Cannot set parent row';
  S_FD_RowIsNotNested = 'Row is not nested';
  S_FD_ColumnIsNotRef = 'Column [%s] is not reference to other row';
  S_FD_ColumnIsNotSetRef = 'Column [%s] is not reference to row set';
  S_FD_OperCNBPerfInState = 'Cannot perform operation for row state';
  S_FD_CantSetUpdReg = 'Cannot change updates registry for DatS manager [%s]';
  S_FD_TooManyAggs = 'Too many aggregate values per view';
  S_FD_GrpLvlExceeds = 'Grouping level exceeds maximum allowed for aggregate [%s]';
  S_FD_VarLenDataMismatch = 'Variable length column [%s] overflow. Value length - [%d], column maximum length - [%d]';
  S_FD_BadForeignKey = 'Invalid foreign key [%s]';
  S_FD_BadUniqueKey = 'Invalid unique key [%s]';
  S_FD_CantChngColType = 'Cannot change column [%s] data type';
  S_FD_BadRelation = 'Invalid relation [%s]';
  S_FD_CantCreateParentView = 'Cannot create parent view. Relation [%s]';
  S_FD_CantChangeTableStruct = 'Cannot change table [%s] structure, when table has rows';
  S_FD_FoundCascadeLoop = 'Found a cascading actions loop at checking foreign key [%s]';
  S_FD_RecLocked = 'Record already locked';
  S_FD_RecNotLocked = 'Record is not locked';
  S_FD_TypeIncompat = 'Assigning value [%s] is not compatible with column [%s] data type. %s';
  S_FD_ValueOutOfRange = 'Value [%s] is out of [%s] data type range';
  S_FD_CantMerge = 'Cannot merge because [%s] %s';

  S_FD_ColumnDoesnotFound = 'Column or function [%s] is not found. Hint: if the name is a function name, then add FireDAC.Stan.ExprFuncs to uses clause';
  S_FD_ExprTermination = 'Expression unexpectedly terminated';
  S_FD_ExprMBAgg = 'Expression must be aggregated';
  S_FD_ExprCantAgg = 'Expression cannot be aggregated';
  S_FD_ExprTypeMis = 'Type mismatch in expression';
  S_FD_ExprIncorrect = 'Expression is incorrect';
  S_FD_InvalidKeywordUse = 'Invalid use of keyword';
  S_FD_ExprInvalidChar = 'Invalid character found [%s]';
  S_FD_ExprNameError = 'Name is not terminated properly';
  S_FD_ExprStringError = 'String constant is not terminated properly or is too long';
  S_FD_ExprNoLParen = '''('' expected but [%s] found';
  S_FD_ExprNoRParenOrComma = ''')'' or '','' expected but [%s] found';
  S_FD_ExprNoRParen = ''')'' expected but [%s] found';
  S_FD_ExprEmptyInList = 'IN predicate list may not be empty';
  S_FD_ExprExpected = 'Expected [%s]';
  S_FD_ExprNoArith = 'Arithmetic in filter expressions not supported';
  S_FD_ExprBadScope = 'Operation cannot mix aggregate value with record-varying value';
  S_FD_ExprEmpty = 'Empty expression';
  S_FD_ExprEvalError = 'Error evaluating expression. %s';

  S_FD_DSNoBookmark = 'Bookmark is not found for dataset [%s]';
  S_FD_DSViewNotSorted = 'View [%s] is not a sorted view';
  S_FD_DSNoAdapter = 'Adapter interface must be supplied';
  S_FD_DSNoNestedMasterSource = 'Cannot set MasterSource for dataset [%s]. Nested datasets cannot have a MasterSource';
  S_FD_DSCircularDataLink = 'Cannot set MasterSource for dataset [%s]. Circular datalinks are not allowed';
  S_FD_DSRefreshError = 'Cannot refresh dataset [%s]. Cached updates must be commited or canceled and batch mode terminated before refreshing';
  S_FD_DSNoDataTable = 'Cannot open dataset [%s]. A DataTable or a DataView must be supplied. Hint: if that is TFDMemTable, use CreateDataSet or CloneCursor to open dataset';
  S_FD_DSIndNotFound = 'Index [%s] is not found for dataset [%s]';
  S_FD_DSAggNotFound = 'Aggregate [%s] is not found for dataset [%s]';
  S_FD_DSIndNotComplete = 'Index [%s] definition is not complete for dataset [%s]';
  S_FD_DSAggNotComplete = 'Aggregate [%s] definition is not complete for dataset [%s]';
  S_FD_DSCantUnidir = 'Cannot perform operation on unidirectional dataset [%s]';
  S_FD_DSIncompatBmkFields = 'Bookmark key fields [%s] are incompatible with dataset [%s] key fields [%s]';
  S_FD_DSCantEdit = 'Record editing for dataset [%s] is disabled';
  S_FD_DSCantInsert = 'Record inserting for dataset [%s] is disabled';
  S_FD_DSCantDelete = 'Record deleting for dataset [%s] is disabled';
  S_FD_DSFieldNotFound = 'Field [%s] specified within %s of DataSet [%s] does not exist';
  S_FD_DSCantOffline = 'Cannot set dataset [%s] to offline mode. Hint: check that FetchOptions.AutoFetchAll is not afDisable';
  S_FD_DSCantOffCachedUpdates = 'Cannot turn off cached updates mode for DataSet [%s]. Hint: dataset has updated rows, cancel or apply updates before action';

  S_FD_DefCircular = 'Cannot make definition [%s] circular reference';
  S_FD_DefRO = 'Cannot %s definition [%s]. It has associated connection';
  S_FD_DefCantMakePers = 'Cannot make definition persistent';
  S_FD_DefAlreadyLoaded = 'Cannot load definition list, because it is already loaded';
  S_FD_DefNotExists = 'Definition [%s] is not found in [%s]';
  S_FD_DefDupName = 'Definition name [%s] is duplicated';

  S_FD_AccSrvNotFound = 'Driver [%s] is not registered. %s';
  S_FD_AccCannotReleaseDrv = 'Driver [%s] cannot be released. Hint: Close all TFDConnection objects and release pools';
  S_FD_AccSrcNotFoundExists =
    'To register it, you can drop component [TFDPhys%sDriverLink] into your project';
  S_FD_AccSrcNotFoundNotExists =
    'Correct driver ID or define [%s] virtual driver in %s';
  S_FD_AccSrvNotDefined = 'Driver ID is not defined. Set TFDConnection.DriverName or add DriverID to your connection definition';
  S_FD_AccSrvMBConnected = 'Connection must be active';
  S_FD_AccCapabilityNotSup = 'Capability is not supported';
  S_FD_AccTxMBActive = 'Transaction [%s] must be active';
  S_FD_AccTxMBInActive = 'Transaction [%s] must be inactive. Nested transactions are disabled';
  S_FD_AccCantChngCommandState = 'Cannot change command state';
  S_FD_AccCommandMBFilled = 'Command text must not be empty';
  S_FD_AccEscapeEmptyName = 'Escape function name must not be empty';
  S_FD_AccCmdMHRowSet = 'Cannot open / define command, which does not return result sets. Hint: use Execute / ExecSQL method for non-SELECT commands';
  S_FD_AccCmdMBPrepared = 'Command must be is prepared state';
  S_FD_AccCantExecCmdWithRowSet = 'Cannot execute command returning result sets. Hint: use Open method for SELECT-like commands';
  S_FD_AccCmdMBOpen4Fetch = 'Command must be open for fetching';
  S_FD_AccExactMismatch = 'Exact %s [%d] rows, while [%d] was requested';
  S_FD_AccMetaInfoMismatch = 'Meta information mismatch';
  S_FD_AccCantLoadLibrary = 'Cannot load vendor library [%s]. %s';
  S_FD_AccCantLoadLibraryHint = 'Hint: check it is in the PATH or application EXE directories, and has %s bitness.';

  S_FD_AccCantGetLibraryEntry = 'Cannot get vendor library entry point[s]. [%s]';
  S_FD_AccSrvMBDisConnected = 'Connection must be inactive';
  S_FD_AccToManyLogins = 'Too many login retries. Allowed [%d] times';
  S_FD_AccDrvMngrMB = 'To perform operation driver manager, must be [%s]';
  S_FD_AccPrepMissed = 'Character [%s] is missed';
  S_FD_AccPrepTooLongIdent = 'Too long identifier (> 255)';
  S_FD_AccParamArrayMismatch = 'Parameter [%s] ArraySize [%d] is less than ATimes [%d]';
  S_FD_AccAsyncOperInProgress = 'Cannot perform the action, because the previous action is in progress';
  S_FD_AccEscapeIsnotSupported = 'Escape function [%s] is not supported';
  S_FD_AccMetaInfoReset = 'Define(mmReset) is only supported for metainfo retrieval';
  S_FD_AccWhereIsEmpty = 'Cannot generate update query. WHERE condition is empty';
  S_FD_AccUpdateTabUndefined = 'Cannot generate update query. Update table undefined';
  S_FD_AccNameHasErrors = 'Cannot parse object name - [%s]';
  S_FD_AccEscapeBadSyntax = 'Syntax error in escape function [%s]. %s';
  S_FD_AccShutdownTO = 'FDPhysManager shutdown timeout. Possible reason: application has not released all connection interfaces';
  S_FD_AccParTypeUnknown = 'Parameter [%s] data type is unknown. Hint: specify TFDParam.DataType or assign TFDParam value before Prepare/Execute call';
  S_FD_AccParDataMapNotSup = 'Parameter [%s] data type is not supported';
  S_FD_AccColDataMapNotSup = 'Column [%s] data type is not supported';
  S_FD_AccParDefChanged = 'Param [%s] type changed from [ft%s] to [ft%s]. Query must be reprepared. Possible reason: an assignment to a TFDParam.AsXXX property implicitly changed the parameter data type. Hint: use the TFDParam.Value or appropriate TFDParam.AsXXX property';
  S_FD_AccMetaInfoNotDefined = 'A meta data argument [%s] value must be specified';
  S_FD_AccCantAssignTxIntf = 'Cannot set default transaction';
  S_FD_AccParSetChanged = 'The set of parameters is changed. Query must be reprepared. Expected number of parameters is [%d], but actual number is [%d]. Possible reason: a parameter was added or deleted';
  S_FD_AccDataToLarge = 'Data too large for variable [%s]. Max len = [%d], actual len = [%d] Hint: set the TFDParam.Size to a greater value';
  S_FD_AccDbNotExists = 'Database [%s] does not exist';
  S_FD_AccClassNotRegistered = 'Required OLEDB provider is missing on client machine. Hint: set exact DBVersion value or install respective MS Access Database Engine: ' +
      'Access 2003 or earlier: http://support.microsoft.com/kb/239114 Access 2007: http://www.microsoft.com/download/en/details.aspx?displaylang=en&id=23734 Access 2010: http://www.microsoft.com/download/en/details.aspx?id=13255';
  S_FD_AccSysClassNotRegistered = 'JRO.JetEngine class is missing on client machine. Hint: install latest engine from: http://support.microsoft.com/kb/239114';
  S_FD_AccUnrecognizedDbFormat = 'Database format is not recognized. Possible reason: DBVersion value mismatches database version.';
  S_FD_AccNotValidPassword = 'Specified database password is invalid';
  S_FD_AccUnknownOleError = 'Unknown OLE error';
  S_FD_AccUnsupParamObjValue = 'Object value for [%s] parameter of [ft%s] type is not supported';
  S_FD_AccUnsupColumnType = 'Column [%s] is of unsupported data type [dt%s]';

  S_FD_SvcLinkMBSet = 'To perform operation DriverLink must be specified';
  S_FD_SvcMBActive = 'To perform operation service must be active';
  S_FD_SvcCannotUninstall = 'Cannot deinstall a SQLite collation, while there are active connections';

  S_FD_DAptRecordIsDeleted = '%s command %s [%d] instead of [1] record. Possible reasons: %s';
  S_FD_DAptRecordIsDeletedReasons = 'update table does not have PK or row identifier, record has been changed/deleted by another user';
  S_FD_DAptNoSelectCmd = 'Operation cannot be performed without assigned SelectCommand';
  S_FD_DAptApplyUpdateFailed = 'Update post failed';
  S_FD_DAptCantEdit = 'Row editing disabled';
  S_FD_DAptCantInsert = 'Row inserting disabled';
  S_FD_DAptCantDelete = 'Row deleting disabled';

  S_FD_ClntSessMBSingle = 'Application must have only single FDManager';
  S_FD_ClntSessMBInactive = 'FDManager must be inactive';
  S_FD_ClntSessMBActive = 'FDManager must be active';
  S_FD_ClntDbDupName = 'Connection name [%s] must be unique';
  S_FD_ClntDbMBInactive = 'Connection [%s] must be inactive';
  S_FD_ClntDbMBActive = 'Connection [%s] must be active';
  S_FD_ClntDbLoginAborted = 'Connection [%s] establishment is canceled';
  S_FD_ClntDbCantConnPooled = 'Connection [%s] cannot be pooled. Possible reason: connection definition is not in the FDManager.ConnectionDefs list or TFDConnection.Params has additional parameters';
  S_FD_ClntDBNotFound = 'Connection [%s] is not found Possible reason: [%s] ConnectionName property is misspelled or references to nonexistent connection';
  S_FD_ClntAdaptMBActive = 'Command [%s] must be in active state';
  S_FD_ClntAdaptMBInactive = 'Command [%s] must be in inactive state';
  S_FD_ClntNotCachedUpdates = 'Dataset [%s] must be in cached update mode';
  S_FD_ClntDbNotDefined = 'Connection is not defined for [%s]. Possible reason: Connection and ConnectionName property values are both empty';
  S_FD_ClntDbMBOnline = 'Connection [%s] must be online';
  S_FD_ClntCantShareAdapt = 'Table adapter [%s] cannot be assigned to [%s], because it is already assigned to [%s] and cannot be shared across few datasets';
  S_FD_ClntConnNotMatch = 'Dataset connection does not match to called connection';
  S_FD_ClntPKNotFound = 'Table [%s] must have primary key';
  S_FD_ClntLocalSQLMisuse = 'Local SQL engine misusage by [%s]. Hint: activate connection before activating dataset';
  S_FD_ClntWrongIndex = 'Table [%s] index [%s] must be existing non-expressional index';
  S_FD_ClntDSNameEmpty = 'Dataset name must be not empty';
  S_FD_ClntDSNameNotUnique = 'Dataset name [%s] must be unique across Local SQL [%s] datasets';
  S_FD_ClntDataSetParamIncompat = 'Dataset parameter value must be of TFDDataSet or TFDDatSTable type';

  S_FD_DPNoTxtFld = 'Text field [%s] is not found';
  S_FD_DPNoSrcDS = 'Source dataset not set';
  S_FD_DPNoDestDS = 'Destination dataset not set';
  S_FD_DPNoTxtDest = 'Destination text data file name or stream must be specified';
  S_FD_DPNoTxtSrc = 'Source text data file name or stream must be specified';
  S_FD_DPBadFixedSize = 'Text field [%s] size is undefined in Fixed Size Record format';
  S_FD_DPTxtFldDup = 'Text field [%s] name is Duplicated';
  S_FD_DPBadTextFmt = 'Bad text value [%s] format for mapping item [%s]. %s';
  S_FD_DPSrcUndefined = 'Undefined source field or expression for destination field [%s]';
  S_FD_DPDestNoKeyFields = 'Key fields are not defined';
  S_FD_DPNoSQLTab = 'SQL table is not defined';
  S_FD_DPNoSQLBatch = 'CommitCount must be greater than zero';
  S_FD_DPNoTxtFlds = 'Text fields are not defined. Hint: Use TFDBatchMove.Analyze';

  S_FD_StanTimeout = 'Timeout expired';
  S_FD_StanCantGetBlob = 'Cannot get access to BLOB raw data';
  S_FD_StanParamOverflow = 'Variable length data parameter [%s] overflow. Value length - [%d], parameter data maximum length - [%d]';
  S_FD_StanCantNonblocking = 'Cannot perform nonblocking action, while other nonblocking action is in progress';
  S_FD_StanMacroNotFound = 'Macro [%s] is not found';
  S_FD_StanBadParRowIndex = 'Parameter [%s] value index [%d] is out of range [0..%d]';
  S_FD_StanPoolTooManyItems = 'Cannot acquire item (connection) from pool. Maximal number [%d] of simultaneous items (connections) reached.';
  S_FD_StanHowToReg = 'To register it, you can drop component [%s] into your project';
  S_FD_StanHowToInc = 'To register it, you can include unit [%s] into your project';
  S_FD_StanStrgInvBinFmt = 'Invalid binary storage format';
  S_FD_StanStrgCantReadProp = 'Cannot read [%s] property';
  S_FD_StanStrgCantReadObj = 'Cannot read [%s] object';
  S_FD_StanStrgCantReadCDATA = 'Cannot read RAW data of [%s] object';
  S_FD_StanStrgDictOverflow = 'Dictionary overflow';
  S_FD_StanStrgClassUnknown = 'Class [%s] is not registered';
  S_FD_StanStrgUnknownFmt = 'Unknown storage format [%s]. Hint: To register it, you can drop component [TFDStanStorageXxxLink] into your project';
  S_FD_StanStrgFileError = 'Cannot move file [%s] to [%s]. %s';
  S_FD_StanStrgInvDIntFmt = 'Invalid date interval format [%s]';
  S_FD_StanStrgInvJSONFmt = 'Invalid JSON storage format. Position [%d]';

  S_FD_ScrCantExecHostCmd = 'Cannot execute host command [%s]. %s';
  S_FD_ScrStrSize1 = 'String size must be of 1 character length';
  S_FD_ScrStrNotAlphaNum = 'Character cannot be alphanumeric or whitespace';
  S_FD_ScrSetArgInvalid = 'Invalid SET command argument';
  S_FD_ScrInvalidSyntax = 'Invalid command [%s] syntax';
  S_FD_ScrAccMustSpecVar = 'ACCEPT statement must specify a variable name';
  S_FD_ScrDefReqValue = 'DEFINE requires a value following equal sign';
  S_FD_ScrVarMissedCloseBrace = 'VARIABLE has missed right brace';
  S_FD_ScrVarUnsupType = 'VARIABLE has unsupported data type';
  S_FD_ScrNotLogged = 'Cannot execute command. Not logged on';
  S_FD_ScrNoCmds = 'No script commands registered. Possible reason: FireDAC.Comp.ScriptCommands unit is not linked to the application';
  S_FD_ScrNoScript = 'No script to execute for [%s]. Possible reason: SQLScriptFileName and SQLScripts both are empty';

  S_FD_DBXParMBNotEmpty = 'Connection parameter [%s] must be not empty';
  S_FD_DBXNoDriverCfg = 'DbExpress driver configuration file [%s] is not found. Possible reason: dbExpress is not properly installed on this machine';

  S_FD_MySQLBadVersion = 'Unsupported MySQL version [%d]. Supported are client and server from v 3.20 to v 6.2';
  S_FD_MySQLCantSetPort = 'Port number cannot be changed';
  S_FD_MySQLBadParams = 'Error in parameter [%s] definition. %s';
  S_FD_MySQLCantInitEmbeddedServer = 'Failed to initialize embedded server. See MySQL log files for details';

  S_FD_OdbcLongDataStream = 'Cannot %s stream for variable [%s]';
  S_FD_OdbcVarDataTypeUnsup = 'Variable [%s] C data type [%d] is not supported';

  S_FD_OraNoCursor = 'No cursors available';
  S_FD_OraCantSetCharset = 'Cannot initialize OCI with character set [%s]. Possible reason: %s';
  S_FD_OraCantAssFILE = 'Cannot assign value to BFILE/CFILE parameter [%s]';
  S_FD_OraNoCursorParams = 'No cursor parameters are defined. Include fiMeta into FetchOptions.Items';
  S_FD_OraNotInstalled = 'OCI is not properly installed on this machine (NOE1/INIT)';
  S_FD_OraBadVersion = 'Unsupported OCI library [%s] version [%s]. At least version 8.0.3 is required (NOE2/INIT)';
  S_FD_OraBadVarType = 'Bad or undefined variable param type (NOE12/VAR)';
  S_FD_OraTooLongGTRID = 'Maximum length (%d) of GTRID exceeded - %d (NOE18/TX)';
  S_FD_OraTooLongBQUAL = 'Maximum length (%d) of BQUAL exceeded - %d (NOE19/TX)';
  S_FD_OraTooLongTXName = 'Maximum length (%d) of transaction name exceeded - %d (NOE20/TX)';
  S_FD_OraDBTNManyClBraces = 'Too many close braces in names file after alias [%s] (NOE105/DB)';
  S_FD_OraNotPLSQLObj = '[%s] is not a callable PL/SQL object (NOE130/SP)';
  S_FD_OraNotPackageProc = '[%s, #%d] is not found in [%s] package (NOE134/SP)';
  S_FD_OraBadTableType = 'Parameter with type TABLE OF BOOLEAN/RECORD not supported (use TFDQuery) (NOE135/SP)';
  S_FD_OraUnNamedRecParam = 'Parameter with type RECORD must be of named type (use TFDQuery) (NOE142/SP)';
  S_FD_OraCantUTF16 = 'To initialize OCI in UTF16 mode, OCI must be of version 8.1 or higher';
  S_FD_OraCantSetCharsetInUT16 = 'To set character set in UTF16 mode, OCI must be of version 9.2 or higher';
  S_FD_OraCantSetDiffCharset = 'Character set must be the same for all sessions';
  S_FD_OraCantConvNum = 'Cannot convert Oracle Number [%s] to TBcd';
  S_FD_OraPipeAlertToMany = 'DBMS_PIPE event alerter supports only single event name';

  S_FD_IBTraceIsActive = 'Cannot start a trace session, when there is an active one';
  S_FD_IBArrayDMLWithIntStr = 'Internal streams cannot be used in Array DML';

  S_FD_PgProcNotFound = 'Stored procedure [%s] is not found';
  S_FD_PgMultiDimArrNotSup = 'Array-typed variable [%s] dimensions [%d] are not supported. Only sigle dimensional simple type arrays are supported';
  S_FD_PgUnsupArrValueTypeNotSup = 'Array-typed variable [%s] unsupported element type [%d]. Only sigle dimensional simple type arrays are supported';
  S_FD_PgArrIndexOutOfBound = 'Array-typed variable [%s] item index [%d] is out of bounds [%d, %d]';
  S_FD_PgCannotDescribeType = 'Cannot describe type [%s]. %s';
  S_FD_PgIsNotArray = 'Variable [%s] is not array';

  S_FD_SQLiteInitFailed = 'SQLite library initialization failed. Main code [%d], extended code [%d]';
  S_FD_SQLiteDBNotFound = 'Database specified by [%p] handle was not found';
  S_FD_SQLitePwdInvalid = 'Invalid password specified';
  S_FD_SQLiteVTabInvalidArgs = 'VTab: Invalid number of arguments at VTabCreate. Expected [%d], got [%d]';
  S_FD_SQLiteVTabDSNotFoundOrEmpty = 'VTab: Dataset [%s] is not found';
  S_FD_SQLiteVTabDSNotSupported = 'VTab: Operation is not supported';
  S_FD_SQLiteVTabDSSPNotFound = 'VTab: Savepoint [%d] is not found';
  S_FD_SQLiteVTabDSDataModFailed = 'VTab: Dataset modification failed';
  S_FD_SQLiteVTabDSRowidInvalid = 'VTab: Explicit ROWID at INSERT is not supported';
  S_FD_SQLiteVTabDSChangedOrFreed = 'VTab: Dataset state was changed. Cannot perform operation';
  S_FD_SQLiteVTabDSNoRowExists = 'VTab: Specified row does not exist';
  S_FD_SQLiteVTabDSCursorInvalid = 'VTab: Invalid cursor';
  S_FD_SQLiteVTabCannotAttach = 'TFDLocalSQL must be attached to an active SQLite connection';
  S_FD_SQLiteVTabDataSetBusy = 'VTab: DataSet [%s] is busy by another result set';

  S_FD_ASADBToolNotFound = 'Cannot perform action. DBTOOLn.DLL is not found';

  S_FD_NexusQueryPrepareFailed = 'Query preparation failed: %s%s';
  S_FD_NexusQuerySetParamsFailed = 'Query set parameters failed: %s%s';
  S_FD_NexusQueryGetParamsFailed = 'Query get parameters failed: %s%s';
  S_FD_NexusQueryExecFailed = 'Query execution failed: %s%s';

  S_FD_MSSQLFSNoTx = 'Cannot open a FileStream without a transaction';
  S_FD_MSSQLFSNoPath = 'Cannot open a FileStream using empty path';
  S_FD_MSSQLFSIOError = 'FileStream access error. %s';
  S_FD_MSSQLQNSubError = 'Query Notification subscription error. Info [%s]';

  S_FD_MongoError = '[%s] method failed';
  S_FD_MongoBadURI = 'Failed to parse URI';
  S_FD_MongoDocReadOnly = 'Cannot modify read-only document';
  S_FD_MongoFailedInitBSON = 'Failed to get BSON for the document';
  S_FD_MongoBulkError = 'Failed to manage bulk operation';
  S_FD_MongoCursorError = 'Cannot get cursor from this object. Use other [%s] overloaded method';
  S_FD_MongoExecuteError = 'Cannot execute this object. Use other [%s] overloaded method';
  S_FD_MongoDBRefInvalid = 'DBRef [%s] is invalid';
  S_FD_MongoDBRefNotFound = 'DBRef [%s] is not found';
  S_FD_MongoCannotOpenDataSet = 'Cannot open dataset [%s]. %s must be assigned';
  S_FD_MongoFieldTypeMismatch = 'Data type mismatch of [%s] item. Current type [%s], new type [%s]';
  S_FD_MongoFieldIsNotFound = 'Field [%s] is not found';
  S_FD_MongoAlertToMany = 'Tail event alerter supports only single event name';

  {-------------------------------------------------------------------------------}
  // FireDAC.BDE.Import

  S_FD_CantMakeConnDefBDEComp = 'Cannot make connection definition compatible with BDE. Reason - driver and RDBMS kind pair is unsupported';

  {-------------------------------------------------------------------------------}
  // FireDAC.Comp.Client

  S_FD_ClntNotAccessible = 'Not accessible.';
  S_FD_ClntConnDefParams = 'Connection definition parameters';
  S_FD_ClntClientInfo = 'Client info';
  S_FD_ClntSessionInfo = 'Session info';
  S_FD_ClntFailedToLoad = 'Failed to load DBMS client !';
  S_FD_ClntFailedToConnect = 'Failed to connect to DBMS !';
  S_FD_ClntNotConnected = 'Not connected to DBMS.';
  S_FD_ClntCheckingSession = 'Checking session ...';
  S_FD_RegBinDefExt = 'fds';
  S_FD_RegFDSFilter = 'XML Files (*.xml)|*.xml|Binary Files (*.fds, *.fdb, *.adb)|*.fds;*.fdb;*.adb|JSON Files (*.json)|*.json|All files (*.*)|*.*';

  {-------------------------------------------------------------------------------}
  // FireDAC.Comp.BatchMove

  S_FD_StartLog = 'Start Log';
  S_FD_NoErrorsLogged = 'No Errors Logged';
  S_FD_EndLog = 'End Log';

  {-------------------------------------------------------------------------------}
  // FireDAC.DatS

  S_FD_NotFound = '<not found>';
  S_FD_Unnamed = 'Unnamed';

  {-------------------------------------------------------------------------------}
  // FireDAC.VCLUI.About

  S_FD_ProductAbout = '%s About';

  {-------------------------------------------------------------------------------}
  // FireDAC.VCLUI.ConnEdit

  S_FD_ParParameter = 'Parameter';
  S_FD_ParValue = 'Value';
  S_FD_ParDefault = 'Default';
  S_FD_ConnEditCaption = 'FireDAC Connection Editor - [%s]';
  S_FD_ConnEditNoDrv = 'Information for the [%s] driver is not accessible';
  S_FD_ConnEditPressOk = 'Press OK to continue script execution';
  S_FD_ConnEditEnterVal = 'Enter value';

  {-------------------------------------------------------------------------------}
  // FireDAC.VCLUI.QEdit

  S_FD_QEditCaption = 'FireDAC Query Editor - [%s]';

  {-------------------------------------------------------------------------------}
  // FireDAC.VCLUI.ResourceOptions

  S_FD_ResOptsStorageFolder = 'Select storage files folder';
  S_FD_ResOptsBackupFolder = 'Select backup files folder';

  {-------------------------------------------------------------------------------}
  // FireDAC.VCLUI.USEdit

  S_FD_USEditCaption = 'FireDAC Update SQL Editor - [%s]';
  S_FD_USEditCantEdit = 'Cannot edit TFDUpdateSQL - connection is undefined';
  S_FD_USEditOpenDS = 'To get columns information would you like to execute the query ?';

  {-------------------------------------------------------------------------------}
  // FireDAC.Moni.RemoteBase

  S_FD_MonNoConnection = 'No connection';
  S_FD_MonEncounterType = 'Encounter unexpected parameter type';
  S_FD_MonEncounterParamName = 'Encounter unexpected parameter name';
  S_FD_MonEncounterBlock = 'Encounter unexpected block of parameters';
  S_FD_MonEncounterEOF = 'Encounter EOF';


  {-------------------------------------------------------------------------------}
  // FireDAC.Stan.Tracer

  sMb_TracerPropertyChangeOnlyActiveFalse = 'Tracer has to be Active=false to change the properties';
  sMb_TracerTraceFileHasToBeOpen = 'Trace file has to be open for this action';
  sMb_TracerTraceFileHasToBeClosed = 'Trace file has to be closed for this action';
  sMb_TracerTraceFileNameNotAssigned = 'Trace file name has to be assigned';

  {-------------------------------------------------------------------------------}
  // keep S_FD_Warning and S_FD_Error in sync with below errors and warnings

  S_FD_Warning = 'Warning:';
  S_FD_Error = 'Error:';

  {-------------------------------------------------------------------------------}
  // FireDAC.Phys.ADS

  S_FD_ADSWarnMinAdvantageVer = 'Warning: invalid Advantage version [%s]. Minimal version is [10.0]';
  S_FD_ADSWarnMinACEVer = 'Warning: invalid ACE version [%s]. Minimal version is [10.0]';

  {-------------------------------------------------------------------------------}
  // FireDAC.Phys.FB

  S_FD_FBWarnNotFBSrv = 'Warning: Use Firebird driver to connect to Firebird server';
  S_FD_FBWarnNotFBClnt = 'Warning: Use fbclient.dll with Firebird driver ';

  {-------------------------------------------------------------------------------}
  // FireDAC.Phys.IB

  S_FD_IBWarnNotIBSrv = 'Warning: Use InterBase driver to connect to InterBase';
  S_FD_IBWarnNotIBClnt = 'Warning: Use gds32.dll with InterBase driver';

  {-------------------------------------------------------------------------------}
  // FireDAC.Phys.IBBase

  S_FD_IBBWarnGDSFB = 'Warning: For Firebird use the fbclient.dll';
  S_FD_IBBWarnFBCIB = 'Warning: For InterBase use the gds32.dll';
  S_FD_IBBIndexProg = 'Processed index [%s]';

  {-------------------------------------------------------------------------------}
  // FireDAC.Phys.MSSQL

  S_FD_MSSQLWarnNC2008 = 'Warning: SQL NC 2008 is not full compatible with SQL Server 2000.';
  S_FD_MSSQLWarnODBC11 = 'Warning: MS ODBC 11 does not support SQL_VARIANT data type.';
  S_FD_MSSQLWarnNC2012 = 'Warning: SQL NC 2012 and MS ODBC 11 fail to work with TVP.';

  {-------------------------------------------------------------------------------}
  // FireDAC.Phys.MySQL

  S_FD_MySQLWarnNoFK = 'Warning: The server [%s] version does not support Foreign ' +
                       'Key/Foreign Key Columns metadata retrieval.';

  {-------------------------------------------------------------------------------}
  // FireDAC.Phys.ODBCBase

  S_FD_ODBCLoadingManager = 'Loading %s driver manager';
  S_FD_ODBCCreatingEnv = 'Creating ODBC environment handle';
  S_FD_ODBCSearchingDrv = 'Searching for ODBC driver';
  S_FD_ODBCCheckingDrv = 'Checking for ODBC driver [%s]';
  S_FD_ODBCWarnDrvNotFound = 'Error: specified ODBC drivers are not found';
  S_FD_ODBCWillBeUsed = 'Will be used [%s]';
  S_FD_ODBCFound = 'Found [%s]';

  {-------------------------------------------------------------------------------}
  // FireDAC.Phys.Oracle

  S_FD_OracleWarnLowMinVer = 'Warning: The client version [%s] with low minor version may be unstable.';
  S_FD_OracleWarnUnicode = 'Warning: The client version [%s] does not support Unicode in full.';
  S_FD_OracleWarnSrvClntVer = 'Warning: The client [%s] and server [%s] versions may lead to various issues.';
  S_FD_OracleWarnASCII = 'Warning: The US7ASCII for Western Europa languages may lead to conversion losts.';

  {-------------------------------------------------------------------------------}
  // FireDAC.Phys.OracleWrapper

  S_FD_OracleWarnLibNotInHome = 'Warning: [%s] does not exists in Oracle Home [%s]';
  S_FD_OracleWarnArchNotSup = 'Warning: not supported architecture [%s]. Required [%s]';
  S_FD_OracleWarnBinNotInPath = 'Warning: bin folder [%s] is not in PATH';
  S_FD_OracleWarnInvOCIVer = 'Warning: invalid OIC version [%s]. Minimal version [10.0]';

  S_FD_OracleMsgLibFound = 'Found [%s], position [%d], in [%s]';
  S_FD_OracleMsgChckHome = 'Checking Oracle Home at key [%s]';
  S_FD_OracleMsgSkipHome = 'Skipping, position [%d] is after [%d]';
  S_FD_OracleMsgSrchHome = 'Searching for Oracle Home';
  S_FD_OracleMsgNoHome = 'Not found !';
  S_FD_OracleMsgSrchOIC = 'Searching for Instant Client';

  {-------------------------------------------------------------------------------}
  // FireDAC.Phys

  S_FD_PhysWarnMajVerDiff = 'Warning: The client [%s] and server [%s] major versions difference > 1.';

implementation

end.
