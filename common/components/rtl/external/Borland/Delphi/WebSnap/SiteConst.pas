{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{   Copyright (c) 2001 Borland Software Corporation     }
{                                                       }
{*******************************************************}

unit SiteConst;

interface

resourcestring

  // Adapter errors
  sFieldRequiresAValue = 'Field %s requires a value';
  sFieldDoesNotAllowMultipleValues = '%s does not allow multiple values';
  sFieldDoesNotAllowMultipleFiles = '%s does not allow multiple files';
  sFieldRequiresAFile = '%s requires a file';
  sFieldModificationNotPermitted = 'Modification of %s is not permitted';
  sActionExecutionNotPermitted = 'Execution of action %s is not permitted';
  sFieldViewNotPermitted = 'Field view not permitted';
  sAdapterModificationNotPermitted = 'Data Modification is not permitted';
  sFileUploadNotSupported = '%s does not support file upload';
  sNoLoginPage = 'Login page is not defined';
  sPageNotFound = 'Web Page not found: %s';
  sPageContentNotProvided = 'Web Page does not provide content';
  sImageNotProvided = 'Field %s did not provide an image';

  // DataSetAdapter errors
  sUnknownAdapterMode = 'Unknown Adapter mode: %s';
  sNilAdapterDataSet = 'DataSet is nil';
  sAdapterRowNotFound = 'Row not found in %s';
  sFieldChangedByAnotherUser = 'Field %s changed by another user';
  sAdapterFieldNotFound = 'Field not found: %s';
  sDataSetPropertyIsNil = '%s: DataSet property is nil';
  sDataSetUnknownKeyFields = '%0:s: Dataset %1:s unknown keyfields';
  sDataSetNotActive = '%0:s: Dataset %1:s not active';
  sValueFieldIsBlank = '%0:s: ValueField property value is blank';

  // XSLPageProducer errors
  SNoXMLData = 'Missing XML Data Component';
  SNoXMLDocument = 'Could not create XMLDocument';

  // Add Adapter Fields Editor
  sAddAdapterData = 'Add Fields...';
  sAddAllAdapterData = 'Add All Fields';
  sAddAdapterDataDlgCaption = 'Add Fields';
  sAddAdapterActions = 'Add Actions...';
  sAddAllAdapterActions = 'Add All Actions';
  sAddAdapterActionsDlgCaption = 'Add Actions';
  sAdapterActionsPrefix = 'Action'; // Do not location
  sAddCommands = 'Add Commands...';
  sAddAllCommands = 'Add All Commands';
  sAddCommandsDlgCaption = 'Add Commands';
  sAddColumns = 'Add Columns...';
  sAddAllColumns = 'Add All Columns';
  sAddColumnsDlgCaption = 'Add Columns';
  sAddFieldItems = 'Add Fields...';
  sAddAllFieldItems = 'Add All Fields';
  sAddFieldItemsDlgCaption = 'Add Fields';


  // SitePageProducer errors
  sAdapterPropertyIsNil =  '%s: Adapter property is nil';
  sAdapterFieldNameIsBlank = '%s: Fieldname is blank';
  sCantFindAdapterField = '%0:s: Field %1:s not found in associated Adapter';    // 0 - Component name, 1 - Adapter Field name
  sAdapterActionNameIsBlank = '%s: Action name is blank';
  sCantFindAdapterAction = '%0:s: Action %1:s not found in associated Adapter';   // 0 - Component name, 1 - Adapter Action name
  sDisplayComponentPropertyIsNil = '%s: DisplayComponent property is nil';


  sNoHandler = 'No request handlers handled this request. ' +
    'The WebAppComponents PageDispatcher, AdapterDispatcher or DispatchActions property may not be set.';


  // LoginAdapter validation
  sBlankPassword = 'Password must not be blank';
  sBlankUserName = 'Username must not be blank';

  // Dispatcher errors
  sAdapterRequestNotHandled = 'Adapter Request not handled: %0:s, %1:s';    // 0 - Request identifier, 1 - object identifier
  sDispatchBlankPageName = 'Dispatching blank page name';
  sPageAccessDenied = 'Page access denied';
  sPageDoesNotSupportRedirect = 'Web Page does not support redirect';

  // Include errors
  sCantFindIncludePage = 'Can''t find included page: %s';
  sInclusionNotSupported = 'Page %s does not support inclusion';
  sRecursiveIncludeFile = 'Include file %s includes itself';

  // DB Image errors
  sIncorrectImageFormat = 'Incorrect image format (%0:s) for field %1:s';
  sFileExpected = 'Uploaded file expected for field %s';

  // WebUserList names - must be valid identifiers
  sWebUserName = 'UserName';
  sWebUserPassword = 'Password';
  sWebUserAccessRights = 'AccessRights';

  // WebUserList errors
  sUserIDNotFound = 'UserID not found';
  sInvalidPassword = 'Invalid password';
  sMissingPassword = 'Missing password';
  sUnknownUserName = 'Unknown user name';
  sMissingUserName = 'Missing user name';


  // Script errors
  sCannotCreateScriptEngine = 'Cannot create script engine: %s.  Error: %x'; 
  sCannotInitializeScriptEngine = 'Cannot initialize script engine';
  sScriptEngineNotFound = 'Script engine not found: %s.';
  sObjectParameterExpected = 'Script Object expected';
  sIntegerParameterExpected = 'Integer parameter expected';
  sUnexpectedParameterType = 'Unexpected parameter type';
  sUnexpectedResultType = 'Unexpected return type';
  sDuplicatePrototypeName = 'Duplication prototype name';
  sBooleanParameterExpected = 'Boolean parameter expected';
  sDoubleParameterExpected = 'Double parameter expected';
  sUnexpectedScriptError = 'Unexpected script error';


  // 0 - Error index number
  // 1 - Error description
  // 2 - Line number
  // 3 - character position number
  // 4 - source line text
  sScriptErrorTemplate =
      '<table width="95%%" border="1" cellspacing="0" bordercolor="#C0C0C0">' + SLineBreak +
        '<tr>' + SLineBreak +
          '<td colspan=2>' + SLineBreak +
            '<font color="#727272"><b>Error[' +  '%0:d' + ']:</b> ' + SLineBreak +
            '%1:s' + SLineBreak +
            '</font>' + SLineBreak +
          '</td>' + SLineBreak +
        '</tr>' + SLineBreak +
        '<tr>' + SLineBreak +
          '<td>' + SLineBreak +
            '<font color="#727272"><b>Line:</b> ' + SLineBreak +
            '%2:d' + SLineBreak +
            '</font>' + SLineBreak +
          '</td>' + SLineBreak +
          '<td>' + SLineBreak +
            '<font color="#727272"><b>Position:</b> ' + SLineBreak +
            '%3:d' + SLineBreak +
            '</font>' + SLineBreak +
          '</td>' + SLineBreak +
        '</tr>' + SLineBreak +
        (* Don't display source text 
        '<tr>' + SLineBreak +
          '<td colspan=2>' + SLineBreak +
            '<font color="#727272"><b>Source Text:</b> ' + SLineBreak +
        '%4:s' + SLineBreak +
            '</font>' + SLineBreak +
          '</td>' + SLineBreak +
        '</tr>' + SLineBreak +
        *)
        '</table>' + SLineBreak;

  sMaximumSessionsExceeded = 'Maximum sessions exceeded';
  sVariableNotFound = 'Variable not found: %s';
  sComponentDoesNotSupportScripting = 'Component does not support scripting. Class: %0:s, Name: %1:s';
  sClassDoesNotSupportScripting = 'Object does not support scripting. Class: %0:s';
  sParameterExpected = 'Parameter expected';
  sStringParameterExpected = 'String parameter expected';
  sInvalidImageSize = 'Invalid image (the size is less than 4 bytes long).';


  // File include errors 
  sIncDblQuoteError = 'File include error on line %d: expecting "';
  sIncEqualsError = 'File include error on line %d: expecting =';
  sIncTypeError = 'File include error on line %d: expecting virtual, file, or page, but found %s.';

  sUnknownImageType = 'unknown';

  // WebSnapObjs.pas scripting errors
  sComponentNotFound = 'Component %s not found';
  sCountFromComponentsNotSupported = 'Getting the Count of a TComponentsEnumerator object is not supported';
  sInterfaceCompRefExpected = 'Component was expected to implement IInterfaceComponentReference for ValuesList support';
  sErrorsObjectNeedsIntf = 'Errors object must support the interface IIterateIntfSupport';

  
implementation

end.
