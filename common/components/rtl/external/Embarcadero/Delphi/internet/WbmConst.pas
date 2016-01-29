{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit WbmConst;

interface

resourcestring
  sDataSetFieldBlank = 'Data set field is blank';
  sDataSetFieldNotFound = 'Data set field not found: %s';
  sNotDataSetField = 'Field is not a dataset field: %s';
  ScriptTableName = '%s_Table';
  sNoXMLBroker = '%s: missing XMLBroker';
  sFieldNotFound = '%0:s: Field "%1:s" not found';
  sXMLBrokerNotDefined = '%s.XMLBroker = nil';
  sSubmitQuery = 'Submit';
  sResetQuery = 'Reset';
  sApplyUpdates = 'Apply Updates';
  sFieldNameBlank = '%s.FieldName = ''''';
  sXMLComponentNotDefined = '%s.XMLComponent = nil';
  ScriptNamesVar = '%s_Names';
  ScriptIDsVar = '%s_IDs';
  ScriptXMLDisplayName = '%s_Disp';
  sInvalidParent = 'Invalid parent';
  sInvalidParentClass = 'Invalid parent class: %s';
  sDuplicateStatusField = 'Field %s ignored, only one status field allowed';
  sFirstButton = '|<';
  sLastButton = '>|';
  sPriorButton = '<';
  sNextButton = '>';
  sPriorPageButton = '<<';
  sNextPageButton = '>>';
  sDeleteButton = ' - ';
  sInsertButton = ' + ';
  sUndoButton = 'Undo';
  sPostButton = 'Post';
  sWarningsBody = '<TABLE BORDER=1 CELLPADDING=4>'#13#10 +
                '<TR><TD><P ALIGN=CENTER>Design-time Warnings<P>'#13#10 +
                '%s'#13#10 +
                '</TD></TD>'#13#10 +
                '</TABLE>'#13#10;
  ScriptDocumentVarName = '%s_Doc';
  ScriptXMLVarName = '%s_XML';
  sInvalidWebComponentsCreation =  'Invalid Web component creation';
  ScriptRowSetVarName = '%s_RS';
  sApplyUpdatesError = 'ApplyUpdates error.  Error count: %d.';
  sDeltaNotFound = 'Missing Delta Packet';
  sXMLBrokerNotConnected = 'XMLBroker: %s is not connected';
  sDataSetNotActive = 'DataSet: %s is not active';

  SMissingSourceFile = 'XMLDataFile must be specified';
  SMissingTransform = 'TransformationFile must be specified';
  SOldVersion = 'Version of Transformation File not supported';
  sFileSaveError = 'Error saving file';
  sFileOpenError = 'Error opening file';
  sXMLFileOpenError = 'Could not open file ';
  sXMLLoadError = 'Error Loading XML';
  sLinePosError = 'Error on line %d, position %d';
  sReason = 'Reason: %s'#10#13;
  sParseError = 'XML Parse Error:'#10#13;

implementation

end.

