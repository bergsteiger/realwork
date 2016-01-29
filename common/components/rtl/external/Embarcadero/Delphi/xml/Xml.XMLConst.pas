{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{                 XML RTL Constants                     }
{*******************************************************}

unit Xml.XMLConst;

interface

const
  CRLF = #13#10;

resourcestring
  { xmldom.pas }
  SDuplicateRegistration = '"%s" DOMImplementation already registered';
  SNoMatchingDOMVendor = 'No matching DOM Vendor: "%s"';
  SNoDOMNodeEx = 'Selected DOM Vendor does not support this property or method';
  SDOMNotSupported = 'Property or Method "%s" is not supported by DOM Vendor "%s"';

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

  
implementation

end.
