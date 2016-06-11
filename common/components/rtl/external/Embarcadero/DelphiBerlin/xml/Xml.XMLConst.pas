{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{*******************************************************}
{                 XML RTL Constants                     }
{*******************************************************}

unit Xml.XMLConst;

interface
{$HPPEMIT LEGACYHPP}

const
  CRLF = #13#10;

resourcestring
  { xmldom.pas }
  SDuplicateRegistration = '"%s" DOMImplementation already registered';
  SNoMatchingDOMVendor = 'No matching DOM Vendor: "%s"';
  SNoDOMNodeEx = 'Selected DOM Vendor does not support this property or method';
  SDOMNotSupported = 'Property or Method "%s" is not supported by DOM Vendor "%s"';
  SNoDOMVendorSelected = 'No selected DOM Vendor';

  { msxmldom.pas }
  SNodeExpected = 'Node cannot be null';
  SMSDOMNotInstalled = 'Microsoft MSXML is not installed';

  { oxmldom.pas }
  {$IFDEF MSWINDOWS}
  SErrorDownloadingURL = 'Error downloading URL: %s';
  SUrlMonDllMissing = 'Unable to load %s';
  {$ENDIF}
  SNotImplemented = 'This property or method is not implemented in the Open XML Parser';

  { XMLDoc.pas }
  SNotActive = 'No active document';
  SNodeNotFound = 'Node "%s" not found';
  SMissingNode = 'IDOMNode required';
  SNoAttributes = 'Attributes are not supported on this node type';
  SInvalidNodeType = 'Invalid node type';
  SMismatchedRegItems = 'Mismatched paramaters to RegisterChildNodes';
  SNotSingleTextNode = 'Element "%s" does not contain a single text node';
  SNoDOMParseOptions = 'DOM Implementation does not support IDOMParseOptions';
  SNotOnHostedNode = 'Invalid operation on a hosted node';
  SMissingItemTag = 'ItemTag property is not initialized';
  SNodeReadOnly = 'Node is readonly';
  SUnsupportedEncoding = 'Unsupported character encoding "%s", try using LoadFromFile';
  SNoRefresh = 'Refresh is only supported if the FileName or XML properties are set';
  SMissingFileName = 'FileName cannot be blank';
  SLine = 'Line';
  SUnknown = 'Unknown';

  { XMLSchema.pas }
  SInvalidSchema = 'Invalid or unsupported XML Schema document';
  SNoLocalTypeName = 'Local type declarations cannot have a name.  Element: %s';
  SUnknownDataType = 'Unknown datatype "%s"';
  SInvalidValue = 'Invalid %s value: "%s"';
  SInvalidGroupDecl = 'Invalid group declaration in "%s"';
  SMissingName = 'Missing Type name';
  SInvalidDerivation = 'Invalid complex type derivation: %s';
  SNoNameOnRef = 'Name not allowed on a ref item';
  SNoGlobalRef = 'Global schema items may not contain a ref';
  SNoRefPropSet = '%s cannot be set on a ref item';
  SSetGroupRefProp = 'Set the GroupRef property for the cmGroupRef content model';
  SNoContentModel = 'ContentModel not set';
  SNoFacetsAllowed = 'Facets and Enumeration not allowed on this kind of datatype "%s"';
  SNotBuiltInType = 'Invalid built-in type name "%s"';
  SInvalidTargetNS = 'Included schema file "%s" has an invalid targetNamespace.'+CRLF+CRLF+
                     'Expected: %s'+CRLF+'Found: %s';
  SUndefinedTargetNS = 'No targetNamespace attribute';
  SBuiltInType = 'Built-in Type';

  { XMLDataToSchema.pas }
  SXMLDataTransDesc = 'XMLData to XML Schema Translator (.xml -> .xsd)';

  { XMLSchema99.pas }
  S99TransDesc = '1999 XML Schema Translator (.xsd <-> .xsd)';

  { DTDSchema.pas }
  SDTDTransDesc = 'DTD to XML Schema Translator (.dtd <-> .xsd)';

  { XDRSchema.pas }
  SXDRTransDesc = 'XDR to XML Schema Translator (.xdr <-> .xsd)';

  { Xml.Internal.WideStringUtils }
  // TUtilsWideStringStream error reports
  SCannotReadOddPos = 'Cannot Read WideString from odd byte position';
  SCannotWriteOddPos = 'Cannot Write WideString to odd byte position';
  SCapacityLessSize = 'Capacity cannot be less than size';
  SOddSizeInvalid = 'Odd size not valid for WideString';
  SNegativeSizeInvalid = 'Negative stream size invalid';
  SOddPosInvalid = 'Odd byte position not valid for WideString';

  // TUtilsNameValueTree error reports
  SInuse = 'Child name-value tree is in use elsewhere';
  SCircularReference = 'Circular references are not allowed';

  // TUtilsCustomWideStr error reports
  SInvalidCodePoint = '%d is not a valid ISO-10646-UCS4 code point';

  // TUtilsWideStringList error reports
  SNoDuplicatesAllowed = 'String list does not allow duplicates';
  SIndexOutOfBounds = 'List Index out of bounds (%d)';
  SOnlyWhenSorted = 'Operation not allowed on Sorted string list';

  { Xml.Internal.TreeUtils }
  SHierarchyRequestError = 'Hierarchy Request Error';
  SListIndexError = 'List index out of bounds (%d)';
  SNoModificationAllowedError = 'No Modification Allowed Error';
  SNotAssignedError = 'Parameter Node Not Assigned Error';
  SNotFoundError = 'Node Not Found Error.';
  SWrongOwnerError = 'Wrong Owner Error';

  { Xml.Internal.ParserUtilsWin32 }
  SByteOrderMarkMismatch = 'Specified input encoding does not match byte order mark.';
  SDefaultEncodingNotSpecified = 'Default Encoding not specified.';
  SEncodingNotSupported = 'Character encoding scheme not supported.';
  SInputEncodingNotSpecified = 'Input Encoding not specified.';
  SOutputEncodingNotSpecified = 'Output Encoding not specified.';
  SStreamNotSpecified = 'Stream not specified.';

  { Xml.Internal.EncodingUtils }
  SIndexOutOfRange  = 'Index out of range';

  { Xml.Internal.CodecUtilsWin32 }
  SCannotConvert           = 'Unicode code point $%x has no equivalent in %s';
  SCannotConvertUCS4       = 'Cannot convert $%8.8X to %s';
  SHighSurrogateNotFound   = 'High surrogate not found';
  SInvalidCodePointPar     = '$%x is not a valid %s code point';
  SInvalidEncoding         = 'Invalid %s encoding';
  SLowSurrogateNotFound    = 'Low surrogate not found';
  SSurrogateNotAllowed     = 'Surrogate value $%x found in %s. Values between $D800 and $DFFF are reserved for use with UTF-16';
  SEncodingOutOfRange      = '%s encoding out of range';
  SUTF8Error               = 'UTF-8 error %d';



  sReason = 'Reason: %s'#10#13;
  sLinePosError = 'Error on line %d, position %d';
  sXMLParseError = 'XML Parse Error:'#10#13;
  SMissingSourceFile = 'XMLDataFile must be specified';
  SMissingTransform = 'TransformationFile must be specified';
  SOldVersion = 'Version of Transformation File not supported';

implementation

end.
