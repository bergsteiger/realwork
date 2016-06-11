{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

(*******************************************************************************
* The contents of this file are subject to the Mozilla Public License Version  *
* 1.1 (the "License"); you may not use this file except in compliance with the *
* License. You may obtain a copy of the License at http://www.mozilla.org/MPL/ *
*                                                                              *
* Software distributed under the License is distributed on an "AS IS" basis,   *
* WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for *
* the specific language governing rights and limitations under the License.    *
*                                                                              *
* The Original Code is OmniXML.pas                                             *
*                                                                              *
* The Initial Developer of the Original Code is Miha Remec                     *
*   http://www.MihaRemec.com/                                                  *
*                                                                              *
* Contributor(s):                                                              *
*   Primoz Gabrijelcic (gp)                                                    *
*   Erik Berry (eb)                                                            *
*   Ondrej Pokorny (op)                                                        *
*******************************************************************************)
unit Xml.Internal.OmniXML;

interface

uses
  System.Classes, System.SysUtils, System.Types, Xml.Internal.OTextReadWrite,
  Xml.Internal.XmlRulesUtils, Generics.Collections;

const
  DEFAULT_DECIMALSEPARATOR  = '.';        // don't change!
  DEFAULT_TRUE              = '1';        // don't change!
  DEFAULT_FALSE             = '0';        // don't change!
  DEFAULT_DATETIMESEPARATOR = 'T';        // don't change!
  DEFAULT_DATESEPARATOR     = '-';        // don't change!
  DEFAULT_TIMESEPARATOR     = ':';        // don't change!
  DEFAULT_MSSEPARATOR       = '.';        // don't change!

const
  NSDelim = ':';
  SXML = 'xml';
  SVersion = 'version';
  SEncoding = 'encoding';
  SStandalone = 'standalone';
  SXMLNS = 'xmlns';
  SHttp = 'http:/';
  SXMLNamespaceURI = SHttp+'/www.w3.org/2000/xmlns/';
  SXMLPrefixNamespaceURI = SHttp+'/www.w3.org/XML/1998/namespace';
  CInvalidDicId = High(LongWord);

const
  // element node
  ELEMENT_NODE = 1;
  // attribute node
  ATTRIBUTE_NODE = 2;
  // text node
  TEXT_NODE = 3;
  // CDATA section node
  CDATA_SECTION_NODE = 4;
  // entity reference node
  ENTITY_REFERENCE_NODE = 5;
  // entity node
  ENTITY_NODE = 6;
  // processing instruction node
  PROCESSING_INSTRUCTION_NODE = 7;
  // comment node
  COMMENT_NODE = 8;
  // document node
  DOCUMENT_NODE = 9;
  // document type node
  DOCUMENT_TYPE_NODE = 10;
  // document fragment node
  DOCUMENT_FRAGMENT_NODE = 11;
  // notation node
  NOTATION_NODE = 12;

type
  TNodeType = 1..12;
  TDicId = LongWord;
  TTexPosDic = TDictionary<string, TDicId>;

const
  // these codes are part of Exception codes

  // W3C DOM Level 1
  // index or size is negative, or greater than the allowed value
  INDEX_SIZE_ERR = 1;
  // the specified range of text does not fit into a DOMString
  DOMSTRING_SIZE_ERR = 2;
  // any node is inserted somewhere it doesn't belong
  HIERARCHY_REQUEST_ERR = 3;
  // a node is used in a different document than the one that created it (that doesn't support it)
  WRONG_DOCUMENT_ERR = 4;
  // an invalid character is specified, such as in a name
  INVALID_CHARACTER_ERR = 5;
  // data is specified for a node which does not support data
  NO_DATA_ALLOWED_ERR = 6;
  // an attempt is made to modify an object where modifications are not allowed
  NO_MODIFICATION_ALLOWED_ERR = 7;
  // an attempt was made to reference a node in a context where it does not exist
  NOT_FOUND_ERR = 8;
  // the implementation does not support the type of object requested
  NOT_SUPPORTED_ERR = 9;
  // an attempt is made to add an attribute that is already in use elsewhere
  INUSE_ATTRIBUTE_ERR = 10;

  // W3C DOM Level 2
  // an attempt is made to use an object that is not, or is no longer, usable
  INVALID_STATE_ERR = 11;
  // an invalid or illegal string is specified
  SYNTAX_ERR = 12;
  // an attempt is made to modify the type of the underlying object
  INVALID_MODIFICATION_ERR = 13;
  // an attempt is made to create or change an object in a way which is incorrect with regard to namespaces
  NAMESPACE_ERR = 14;
  // parameter or an operation is not supported by the underlying object
  INVALID_ACCESS_ERR = 15;

const
  MSG_E_NOTEXT = $0000;
  MSG_E_BASE = $0001;
  MSG_E_FORMATINDEX_BADINDEX = MSG_E_BASE + 0;
  MSG_E_FORMATINDEX_BADFORMAT = MSG_E_BASE + 1;
  MSG_E_SYSTEM_ERROR = MSG_E_BASE + 2;
  MSG_E_MISSINGEQUALS = MSG_E_BASE + 3;
  MSG_E_EXPECTED_TOKEN = MSG_E_BASE + 4;
  MSG_E_UNEXPECTED_TOKEN = MSG_E_BASE + 5;
  MSG_E_MISSINGQUOTE = MSG_E_BASE + 6;
  MSG_E_COMMENTSYNTAX = MSG_E_BASE + 7;
  MSG_E_BADSTARTNAMECHAR = MSG_E_BASE + 8;
  MSG_E_BADNAMECHAR = MSG_E_BASE + 9;
  MSG_E_BADCHARINSTRING = MSG_E_BASE + 10;
  MSG_E_XMLDECLSYNTAX = MSG_E_BASE + 11;
  MSG_E_BADCHARDATA = MSG_E_BASE + 12;
  MSG_E_MISSINGWHITESPACE = MSG_E_BASE + 13;
  MSG_E_EXPECTINGTAGEND = MSG_E_BASE + 14;
  MSG_E_BADCHARINDTD = MSG_E_BASE + 15;
  MSG_E_BADCHARINDECL = MSG_E_BASE + 16;
  MSG_E_MISSINGSEMICOLON = MSG_E_BASE + 17;
  MSG_E_BADCHARINENTREF = MSG_E_BASE + 18;
  MSG_E_UNBALANCEDPAREN = MSG_E_BASE + 19;
  MSG_E_EXPECTINGOPENBRACKET = MSG_E_BASE + 20;
  MSG_E_BADENDCONDSECT = MSG_E_BASE + 21;
  MSG_E_INTERNALERROR = MSG_E_BASE + 22;
  MSG_E_UNEXPECTED_WHITESPACE = MSG_E_BASE + 23;
  MSG_E_INCOMPLETE_ENCODING = MSG_E_BASE + 24;
  MSG_E_BADCHARINMIXEDMODEL = MSG_E_BASE + 25;
  MSG_E_MISSING_STAR = MSG_E_BASE + 26;
  MSG_E_BADCHARINMODEL = MSG_E_BASE + 27;
  MSG_E_MISSING_PAREN = MSG_E_BASE + 28;
  MSG_E_BADCHARINENUMERATION = MSG_E_BASE + 29;
  MSG_E_PIDECLSYNTAX = MSG_E_BASE + 30;
  MSG_E_EXPECTINGCLOSEQUOTE = MSG_E_BASE + 31;
  MSG_E_MULTIPLE_COLONS = MSG_E_BASE + 32;
  MSG_E_INVALID_DECIMAL = MSG_E_BASE + 33;
  MSG_E_INVALID_HEXADECIMAL = MSG_E_BASE + 34;
  MSG_E_INVALID_UNICODE = MSG_E_BASE + 35;
  MSG_E_WHITESPACEORQUESTIONMARK = MSG_E_BASE + 36;
  MSG_E_SUSPENDED = MSG_E_BASE + 37;
  MSG_E_STOPPED = MSG_E_BASE + 38;
  MSG_E_UNEXPECTEDENDTAG = MSG_E_BASE + 39;
  MSG_E_UNCLOSEDTAG = MSG_E_BASE + 40;
  MSG_E_DUPLICATEATTRIBUTE = MSG_E_BASE + 41;
  MSG_E_MULTIPLEROOTS = MSG_E_BASE + 42;
  MSG_E_INVALIDATROOTLEVEL = MSG_E_BASE + 43;
  MSG_E_BADXMLDECL = MSG_E_BASE + 44;
  MSG_E_MISSINGROOT = MSG_E_BASE + 45;
  MSG_E_UNEXPECTEDEOF = MSG_E_BASE + 46;
  MSG_E_BADPEREFINSUBSET = MSG_E_BASE + 47;
  MSG_E_PE_NESTING = MSG_E_BASE + 48;
  MSG_E_INVALID_CDATACLOSINGTAG = MSG_E_BASE + 49;
  MSG_E_UNCLOSEDPI = MSG_E_BASE + 50;
  MSG_E_UNCLOSEDSTARTTAG = MSG_E_BASE + 51;
  MSG_E_UNCLOSEDENDTAG = MSG_E_BASE + 52;
  MSG_E_UNCLOSEDSTRING = MSG_E_BASE + 53;
  MSG_E_UNCLOSEDCOMMENT = MSG_E_BASE + 54;
  MSG_E_UNCLOSEDDECL = MSG_E_BASE + 55;
  MSG_E_UNCLOSEDMARKUPDECL = MSG_E_BASE + 56;
  MSG_E_UNCLOSEDCDATA = MSG_E_BASE + 57;
  MSG_E_BADDECLNAME = MSG_E_BASE + 58;
  MSG_E_BADEXTERNALID = MSG_E_BASE + 59;
  MSG_E_BADELEMENTINDTD = MSG_E_BASE + 60;
  MSG_E_RESERVEDNAMESPACE = MSG_E_BASE + 61;
  MSG_E_EXPECTING_VERSION = MSG_E_BASE + 62;
  MSG_E_EXPECTING_ENCODING = MSG_E_BASE + 63;
  MSG_E_EXPECTING_NAME = MSG_E_BASE + 64;
  MSG_E_UNEXPECTED_ATTRIBUTE = MSG_E_BASE + 65;
  MSG_E_ENDTAGMISMATCH = MSG_E_BASE + 66;
  MSG_E_INVALIDENCODING = MSG_E_BASE + 67;
  MSG_E_INVALIDSWITCH = MSG_E_BASE + 68;
  MSG_E_EXPECTING_NDATA = MSG_E_BASE + 69;
  MSG_E_INVALID_MODEL = MSG_E_BASE + 70;
  MSG_E_INVALID_TYPE = MSG_E_BASE + 71;
  MSG_E_INVALIDXMLSPACE = MSG_E_BASE + 72;
  MSG_E_MULTI_ATTR_VALUE = MSG_E_BASE + 73;
  MSG_E_INVALID_PRESENCE = MSG_E_BASE + 74;
  MSG_E_BADXMLCASE = MSG_E_BASE + 75;
  MSG_E_CONDSECTINSUBSET = MSG_E_BASE + 76;
  MSG_E_CDATAINVALID = MSG_E_BASE + 77;
  MSG_E_INVALID_STANDALONE = MSG_E_BASE + 78;
  MSG_E_UNEXPECTED_STANDALONE = MSG_E_BASE + 79;
  MSG_E_DOCTYPE_IN_DTD = MSG_E_BASE + 80;
  MSG_E_MISSING_ENTITY = MSG_E_BASE + 81;
  MSG_E_ENTITYREF_INNAME = MSG_E_BASE + 82;
  MSG_E_DOCTYPE_OUTSIDE_PROLOG = MSG_E_BASE + 83;
  MSG_E_INVALID_VERSION = MSG_E_BASE + 84;
  MSG_E_DTDELEMENT_OUTSIDE_DTD = MSG_E_BASE + 85;
  MSG_E_DUPLICATEDOCTYPE = MSG_E_BASE + 86;
  MSG_E_RESOURCE = MSG_E_BASE + 87;
  MSG_E_INVALID_OPERATION = MSG_E_BASE + 88;
  MSG_E_WRONG_DOCUMENT = MSG_E_BASE + 89;

  XML_BASE = MSG_E_BASE + 90;
  XML_IOERROR = XML_BASE + 0;
  XML_ENTITY_UNDEFINED = XML_BASE + 1;
  XML_INFINITE_ENTITY_LOOP = XML_BASE + 2;
  XML_NDATA_INVALID_PE = XML_BASE + 3;
  XML_REQUIRED_NDATA = XML_BASE + 4;
  XML_NDATA_INVALID_REF = XML_BASE + 5;
  XML_EXTENT_IN_ATTR = XML_BASE + 6;
  XML_STOPPED_BY_USER = XML_BASE + 7;
  XML_PARSING_ENTITY = XML_BASE + 8;
  XML_E_MISSING_PE_ENTITY = XML_BASE + 9;
  XML_E_MIXEDCONTENT_DUP_NAME = XML_BASE + 10;
  XML_NAME_COLON = XML_BASE + 11;
  XML_ELEMENT_UNDECLARED = XML_BASE + 12;
  XML_ELEMENT_ID_NOT_FOUND = XML_BASE + 13;
  XML_DEFAULT_ATTRIBUTE = XML_BASE + 14;
  XML_XMLNS_RESERVED = XML_BASE + 15;
  XML_EMPTY_NOT_ALLOWED = XML_BASE + 16;
  XML_ELEMENT_NOT_COMPLETE = XML_BASE + 17;
  XML_ROOT_NAME_MISMATCH = XML_BASE + 18;
  XML_INVALID_CONTENT = XML_BASE + 19;
  XML_ATTRIBUTE_NOT_DEFINED = XML_BASE + 20;
  XML_ATTRIBUTE_FIXED = XML_BASE + 21;
  XML_ATTRIBUTE_VALUE = XML_BASE + 22;
  XML_ILLEGAL_TEXT = XML_BASE + 23;
  XML_MULTI_FIXED_VALUES = XML_BASE + 24;
  XML_NOTATION_DEFINED = XML_BASE + 25;
  XML_ELEMENT_DEFINED = XML_BASE + 26;
  XML_ELEMENT_UNDEFINED = XML_BASE + 27;
  XML_XMLNS_UNDEFINED = XML_BASE + 28;
  XML_XMLNS_FIXED = XML_BASE + 29;
  XML_E_UNKNOWNERROR = XML_BASE + 30;
  XML_REQUIRED_ATTRIBUTE_MISSING = XML_BASE + 31;
  XML_MISSING_NOTATION = XML_BASE + 32;
  XML_ATTLIST_DUPLICATED_ID = XML_BASE + 33;
  XML_ATTLIST_ID_PRESENCE = XML_BASE + 34;
  XML_XMLLANG_INVALIDID = XML_BASE + 35;
  XML_PUBLICID_INVALID = XML_BASE + 36;
  XML_DTD_EXPECTING = XML_BASE + 37;
  XML_NAMESPACE_URI_EMPTY = XML_BASE + 38;
  XML_LOAD_EXTERNALENTITY = XML_BASE + 39;
  XML_BAD_ENCODING = XML_BASE + 40;

  NS_NS_ERROR = XML_BASE + 41;
  NS_EMPTY_NOT_ALLOWED = XML_BASE + 42;
  NS_E_BADNAMECHAR = XML_BASE + 43;

type
  EXMLException = class(Exception)
  private
    FDOMCode: Integer;
    FXMLCode: Integer;
  public
    property DOMCode: Integer read FDOMCode;
    property XMLCode: Integer read FXMLCode;
    constructor CreateParseError(const DOMCode, XMLCode: Integer; const Args: array of const);
  end;

{ * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * }
{                                                                             }
{         S T A R T   O F   I N T E R F A C E   D E C L A R A T I O N         }
{                                                                             }
{ * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * }


type
  TOutputFormat = (ofNone, ofFlat, ofIndent);
  IUnicodeStream = interface
    ['{F3ECA11F-EA18-491C-B59A-4203D5DC8CCA}']
    // private
    function GetEncoding: TEncoding;
    procedure SetEncoding(const AEncoding: TEncoding);
    function GetBOMFound: Boolean;
    function GetOutputFormat: TOutputFormat;
    procedure SetOutputFormat(const Value: TOutputFormat);
    function GetPreviousOutputBuffer: string;
    // public
    procedure IncreaseIndent;
    procedure DecreaseIndent;
    procedure WriteIndent(const ForceNextLine: Boolean = False);
    property OutputFormat: TOutputFormat read GetOutputFormat write SetOutputFormat;
    property Encoding: TEncoding read GetEncoding write SetEncoding;
    property BOMFound: Boolean read GetBOMFound;
    procedure UndoRead;
    function ProcessChar(var Char: Char): Boolean;
    function GetNextString(var ReadString: string; const Len: Integer): Boolean;
    procedure WriteOutputChar(const OutChar: Char);
    function GetOutputBuffer: string;
    function OutputBufferLen: Integer;
    procedure ClearOutputBuffer;
    procedure WriteString(const Value: string);
  end;

type
  TStreamMode = (smRead, smWrite);

  OmniTXMLTextStream = class(TInterfacedObject, IUnicodeStream)
  private
    FStreamMode: TStreamMode;
    FReader: TOTextReader;
    FWriter: TOTextWriter;
    FPreviousOutBuffer: string;
    FOutBuffer: PChar;
    FOutBufferPos,
    FOutBufferSize: Integer;
    FIndent: Integer;
    FOutputFormat: TOutputFormat;
    fBOMFound: Boolean;
    function GetEncoding: TEncoding;
    procedure SetEncoding(const AEncoding: TEncoding);
    function GetBOMFound: Boolean;
    function GetOutputFormat: TOutputFormat;
    procedure SetOutputFormat(const Value: TOutputFormat);
  protected
    FStream: TStream;
    FEOF: Boolean;
    function ReadChar(var ReadChar: Char): Boolean; virtual;
    function ProcessChar(var ch: Char): Boolean; virtual;
    procedure IncreaseIndent;
    procedure DecreaseIndent;
    procedure WriteIndent(const ForceNextLine: Boolean = False);
    // helper functions
    function GetPreviousOutputBuffer: string;
  public
    property OutputFormat: TOutputFormat read GetOutputFormat write SetOutputFormat;
    property Encoding: TEncoding read GetEncoding write SetEncoding;
    property BOMFound: Boolean read GetBOMFound;
    constructor Create(const Stream: TStream; const Mode: TStreamMode; const Encoding: TEncoding; const WriteBOM: Boolean);
    destructor Destroy; override;
    procedure UndoRead; virtual;
    function GetNextString(var ReadString: string; const Len: Integer): Boolean;
    procedure WriteOutputChar(const OutChar: Char);
    function GetOutputBuffer: string;
    function OutputBufferLen: Integer;
    procedure ClearOutputBuffer;
    procedure WriteString(const Value: string);
  end;

  OmniIXMLParseError = interface
    ['{546E9AE4-4E1E-4014-B0B8-4F024C797544}']
    // private
    function GetErrorCode: Integer;
    function GetFilePos: Integer;
    function GetLine: Integer;
    function GetLinePos: Integer;
    function GetSrcTextPos: Integer;
    function GetReason: string;
    function GetSrcText: string;
    function GetURL: string;
    // public
    property ErrorCode: Integer read GetErrorCode;
    property FilePos: Integer read GetFilePos;
    property Line: Integer read GetLine;//1-based
    property LinePos: Integer read GetLinePos;//1-based
    property Reason: string read GetReason;
    property SrcText: string read GetSrcText;
    property SrcTextPos: Integer read GetSrcTextPos;//1-based, position of error in SrcText
    property URL: string read GetURL;
  end;

  OmniIXMLElement = interface;
  OmniIXMLDocument = interface;
  OmniIXMLNodeList = interface;
  OmniIXMLNamedNodeMap = interface;

  OmniIXMLNode = interface
    ['{F4D7D3DE-C6EC-4191-8E35-F652C2705E81}']
    // private
    function GetAttributes: OmniIXMLNamedNodeMap;
    function GetChildNodes: OmniIXMLNodeList;
    function GetFirstChild: OmniIXMLNode;
    function GetLastChild: OmniIXMLNode;
    function GetNextSibling: OmniIXMLNode;
    function GetNodeName: string;
    function GetNodeType: TNodeType;
    function GetNodeValue: string;
    function GetNSURI: string;
    function GetOwnerDocument: OmniIXMLDocument;
    function GetParentNode: OmniIXMLNode;
    function GetPreviousSibling: OmniIXMLNode;
    procedure SetNodeValue(const Value: string);
    procedure SetParentNode(const Parent: OmniIXMLNode);
    function GetLocalName: string;
    function GetPrefix: string;
    // public
    function InsertBefore(const NewChild, RefChild: OmniIXMLNode): OmniIXMLNode;
    function ReplaceChild(const NewChild, OldChild: OmniIXMLNode): OmniIXMLNode;
    function RemoveChild(const OldChild: OmniIXMLNode): OmniIXMLNode;
    function AppendChild(const NewChild: OmniIXMLNode): OmniIXMLNode;
    function HasChildNodes: Boolean;
    function CloneNode(const Deep: Boolean): OmniIXMLNode;

    property NodeName: string read GetNodeName;
    property NodeValue: string read GetNodeValue write SetNodeValue;
    property NamespaceURI: string read GetNSURI;
    property NodeType: TNodeType read GetNodeType;
    property ParentNode: OmniIXMLNode read GetParentNode;
    property ChildNodes: OmniIXMLNodeList read GetChildNodes;
    property FirstChild: OmniIXMLNode read GetFirstChild;
    property LastChild: OmniIXMLNode read GetLastChild;
    property PreviousSibling: OmniIXMLNode read GetPreviousSibling;
    property NextSibling: OmniIXMLNode read GetNextSibling;
    property Attributes: OmniIXMLNamedNodeMap read GetAttributes;
    property OwnerDocument: OmniIXMLDocument read GetOwnerDocument;
    property LocalName: string read GetLocalName;
    property Prefix: string read GetPrefix;

    // MS (non-standard) extensions
    function GetText: string;
    procedure SetText(const Value: string);
    property Text: string read GetText write SetText;
    procedure WriteToStream(const OutputStream: IUnicodeStream);
    procedure SelectSingleNode(Pattern: string; var Result: OmniIXMLNode); overload;
    function SelectSingleNode(Pattern: string): OmniIXMLNode; overload;
    procedure SelectNodes(Pattern: string; var Result: OmniIXMLNodeList); overload;
    function SelectNodes(Pattern: string): OmniIXMLNodeList; overload;
    function GetXML: string;
    property XML: string read GetXML;
  end;

  OmniIXMLCustomList = interface
    ['{6520A0BC-8738-4E40-8CDB-33713DED32ED}']
    // protected
    function GetLength: Integer;
    function GetItem(const Index: Integer): OmniIXMLNode;
    // public
    property Item[const Index: Integer]: OmniIXMLNode read GetItem;
    property Length: Integer read GetLength;
    function Add(const XMLNode: OmniIXMLNode): Integer;
    function IndexOf(const XMLNode: OmniIXMLNode): Integer;
    procedure Insert(const Index: Integer; const XMLNode: OmniIXMLNode);
    function Remove(const XMLNode: OmniIXMLNode): Integer;
    procedure Delete(const Index: Integer);
    procedure Clear;
  end;

  OmniIXMLNodeList = interface(OmniIXMLCustomList)
    ['{66AF674E-4697-4356-ACCC-4258DA138EA1}']
    // public
    function AddNode(const Arg: OmniIXMLNode): OmniIXMLNode;
    // MS (non-standard) extensions
    procedure Reset;
    function NextNode: OmniIXMLNode;
  end;

  OmniIXMLNamedNodeMap = interface(OmniIXMLCustomList)
    ['{87964B1D-F6CC-46D2-A602-67E198C8BFF5}']
    // public
    function GetNamedItem(const Name: string): OmniIXMLNode;
    function SetNamedItem(const Arg: OmniIXMLNode): OmniIXMLNode;
    function RemoveNamedItem(const Name: string): OmniIXMLNode;
    function GetNamedItemNS(const namespaceURI, localName: string): OmniIXMLNode;
    function SetNamedItemNS(const Arg: OmniIXMLNode): OmniIXMLNode;
    function RemoveNamedItemNS(const namespaceURI, localName: string): OmniIXMLNode;
  end;

                                                                              
(*
  OmniIXMLDocumentType = interface(OmniIXMLNode)
    ['{881517D3-A2F5-4AF0-8A3D-5A57D2C77ED9}']
    // private
    function GetEntities: OmniIXMLNamedNodeMap;
    function GetName: string;
    function GetNotations: OmniIXMLNamedNodeMap;
    // public
    property Name: string read GetName;
    property Entities: OmniIXMLNamedNodeMap read GetEntities;
    property Notations: OmniIXMLNamedNodeMap read GetNotations;
  end;
*)

  OmniIXMLDocumentFragment = interface(OmniIXMLNode)
    ['{A21A11BF-E489-4416-9607-172EFA2CFE45}']
  end;

  OmniIXMLCharacterData = interface(OmniIXMLNode)
    ['{613A6538-A0DC-49BC-AFA6-D8E611176B86}']
    // private
    function GetData: string;
    function GetLength: Integer;
    procedure SetData(const Value: string);
    // public
    property Data: string read GetData write SetData;
    property Length: Integer read GetLength;
    function SubstringData(const Offset, Count: Integer): string;
    procedure AppendData(const Arg: string);
    procedure InsertData(const Offset: Integer; const Arg: string);
    procedure DeleteData(const Offset, Count: Integer);
    procedure ReplaceData(const Offset, Count: Integer; const Arg: string);
  end;

  OmniIXMLText = interface(OmniIXMLCharacterData)
    ['{0EC46ED2-AB58-4DC9-B964-965615248564}']
    // public
    function SplitText(const Offset: Integer): OmniIXMLText;
  end;

  OmniIXMLComment = interface(OmniIXMLCharacterData)
    ['{B094A54C-039F-4ED7-9331-F7CF5A711EDA}']
  end;

  OmniIXMLCDATASection = interface(OmniIXMLText)
    ['{CF58778D-775D-4299-884C-F1DC61925D54}']
  end;

  OmniIXMLDocumentType = interface(OmniIXMLText)
    ['{E956F945-E8F6-4589-BF8D-D4DC23DE1089}']
  end;

  OmniIXMLProcessingInstruction = interface(OmniIXMLNode)
    ['{AF449E32-2615-4EF7-82B6-B2E9DCCE9FC3}']
    // private
    function GetData: string;
    function GetTarget: string;
    // public
    property Target: string read GetTarget;
    property Data: string read GetData;
  end;

  OmniIXMLAttr = interface(OmniIXMLNode)
    ['{10796B8E-FBAC-4ADF-BDD8-E4BBC5A5196F}']
    // private
    function GetName: string;
    function GetSpecified: Boolean;
    function GetValue: string;
    procedure SetValue(const Value: string);
    function GetOwnerElement: OmniIXMLElement;
    // public
    property Name: string read GetName;
    property Specified: Boolean read GetSpecified;
    property Value: string read GetValue write SetValue;
    property OwnerElement: OmniIXMLElement read GetOwnerElement;
  end;

  OmniIXMLEntityReference = interface(OmniIXMLNode)
    ['{4EC18B2B-BD52-464D-BAD1-1FBE2C445989}']
  end;

  OmniIXMLDocument = interface(OmniIXMLNode)
    ['{59A76970-451C-4343-947C-242EFF17413C}']
    // private
    function GetDocType: OmniIXMLDocumentType;
                                                                                
//    procedure SetDocType(const Value: OmniIXMLDocumentType);
    function GetDocumentElement: OmniIXMLElement;
    procedure SetDocumentElement(const Value: OmniIXMLElement);
    function GetPreserveWhiteSpace: Boolean;
    procedure SetPreserveWhiteSpace(const Value: Boolean);
    // public
    property DocType: OmniIXMLDocumentType read GetDocType;
    property DocumentElement: OmniIXMLElement read GetDocumentElement write SetDocumentElement;
    property PreserveWhiteSpace: Boolean read GetPreserveWhiteSpace write SetPreserveWhiteSpace;
    function CreateAttribute(const Name: string): OmniIXMLAttr;
    function CreateCDATASection(const Data: string): OmniIXMLCDATASection;
    function CreateComment(const Data: string): OmniIXMLComment;
    function CreateDocType(const Data: string): OmniIXMLDocumentType;
    function CreateDocumentFragment: OmniIXMLDocumentFragment;
    function CreateElement(const TagName: string): OmniIXMLElement;
    function CreateEntityReference(const Name: string): OmniIXMLEntityReference;
    function CreateProcessingInstruction(const Target, Data: string): OmniIXMLProcessingInstruction;
    function CreateTextNode(const Data: string): OmniIXMLText;
    function GetElementsByTagName(const TagName: string): OmniIXMLNodeList;
    function CreateAttributeNS(const namespaceURI, qualifiedName: string): OmniIXMLAttr;
    function CreateElementNS(const namespaceURI, qualifiedName: string): OmniIXMLElement;
    function GetElementsByTagNameNS(const namespaceURI, localName: string): OmniIXMLNodeList;

    // MS (non-standard) extensions
    function Load(const FileName: string): Boolean;
    function LoadFromStream(const Stream: TStream): Boolean;
    procedure Save(const FileName: string; const OutputFormat: TOutputFormat = ofNone);
    procedure SaveToStream(const OutputStream: TStream; const OutputFormat: TOutputFormat = ofNone);
    function LoadXML(const XML: string): Boolean;
    function GetParseError: OmniIXMLParseError;
    property ParseError: OmniIXMLParseError read GetParseError;
  end;

  OmniIXMLElement = interface(OmniIXMLNode)
    ['{C858C4E1-FB3F-4C98-8BDE-671E060D17B9}']
    // private
    function GetTagName: string;
    // public
    property TagName: string read GetTagName;
    function GetAttribute(const Name: string): string;
    procedure SetAttribute(const Name, Value: string);
    procedure RemoveAttribute(const Name: string);
    function GetAttributeNode(const Name: string): OmniIXMLAttr;
    function SetAttributeNode(const NewAttr: OmniIXMLAttr): OmniIXMLAttr;
    function RemoveAttributeNode(const OldAttr: OmniIXMLAttr): OmniIXMLAttr;
    function GetElementsByTagName(const Name: string): OmniIXMLNodeList;
    procedure Normalize;
    procedure SetAttributeNS(const qualifiedName, Value: string);
    function GetElementsByTagNameNS(const namespaceURI, localName: string): OmniIXMLNodeList;
    function GetAttributeNS(const namespaceURI, localName: string): string;
    function GetAttributeNodeNS(const namespaceURI, localName: string): OmniIXMLAttr;
    function SetAttributeNodeNS(const NewAttr: OmniIXMLAttr): OmniIXMLAttr;
  end;

{ * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * }
{                                                                             }
{          E N D   O F   I N T E R F A C E   D E C L A R A T I O N            }
{                                                                             }
{                                                                             }
{      S T A R T   O F   I N T E R F A C E   I M P L E M E N T A T I O N      }
{                                                                             }
{ * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * }

type
  OmniTXMLParseError = class(TInterfacedObject, OmniIXMLParseError)
  private
    FErrorCode: Integer;
    FFilePos: Integer;
    FLine: Integer;
    FLinePos: Integer;
    FReason: string;
    FSrcText: string;
    FSrcTextPos: Integer;
    FURL: string;
    function GetErrorCode: Integer;
    function GetFilePos: Integer;
    function GetLine: Integer;
    function GetLinePos: Integer;
    function GetSrcTextPos: Integer;
    function GetReason: string;
    function GetSrcText: string;
    function GetURL: string;
  protected
    procedure SetErrorCode(const ErrorCode: Integer);
    procedure SetFilePos(const FilePos: Integer);
    procedure SetLine(const Line: Integer);
    procedure SetLinePos(const LinePos: Integer);
    procedure SetReason(const Reason: string);
    procedure SetSrcText(const SrcTextBefore, SrcTextAfter: string);
    procedure SetURL(const URL: string);
  public
    property ErrorCode: Integer read GetErrorCode;
    property FilePos: Integer read GetFilePos;
    property Line: Integer read GetLine;
    property LinePos: Integer read GetLinePos;
    property Reason: string read GetReason;
    property SrcText: string read GetSrcText;
    property SrcTextPos: Integer read GetSrcTextPos;
    property URL: string read GetURL;
  end;

  OmniTXMLNodeList = class;
  OmniTXMLNamedNodeMap = class;
  OmniTXMLDocument = class;
  OmniTXMLAttr = class;
  OmniTXMLElement = class;
  OmniTXMLText = class;
  OmniTXMLComment = class;
  OmniTXMLCDATASection = class;
  OmniTXMLProcessingInstruction = class;
  //helper Class
  TTexListDic = class;

  OmniTXMLNode = class(TInterfacedObject, OmniIXMLNode)
  protected
    [Weak] FOwnerDocument: OmniTXMLDocument;
    FNodeType: TNodeType;
    FAttributes: OmniIXMLNamedNodeMap;
    FChildNodes: OmniIXMLNodeList;
    FParentNode: OmniIXMLNode;
    FOwnerElement: OmniIXMLNode;
    FNodeValueId: TDicId;
    FNSPrefixScopeDict: TTexPosDic;
    procedure ClearChildNodes;
    function HasAttributes: Boolean;
    function GetAttributes: OmniIXMLNamedNodeMap;
    function GetChildNodes: OmniIXMLNodeList;
    function GetFirstChild: OmniIXMLNode;
    function GetLastChild: OmniIXMLNode;
    function GetNextSibling: OmniIXMLNode;
    function GetNodeName: string; virtual; abstract;
    function GetNodeType: TNodeType;
    function GetNodeValue: string; virtual;
    function GetNSURI: string;
    function GetPrefix: string;
    function GetLocalName: string;
    function GetOwnerDocument: OmniIXMLDocument; virtual;
    function GetParentNode: OmniIXMLNode;
    function GetPreviousSibling: OmniIXMLNode;
    procedure SetNodeValue(const Value: string); virtual;
    procedure InternalWriteToStream(const OutputStream: IUnicodeStream); virtual;
    procedure ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream); virtual;
    procedure SetParentNode(const Parent: OmniIXMLNode);
    function GetText: string; virtual;
    procedure SetText(const Value: string); virtual;
    function GetXML: string;
    procedure SelectNodes(Pattern: string; var Result: OmniIXMLNodeList); overload; virtual;
    procedure SelectSingleNode(Pattern: string; var Result: OmniIXMLNode); overload; virtual;
  public
    TexListDic: TTexListDic;
    property NodeName: string read GetNodeName;
    property Prefix: string read GetPrefix;
    property LocalName: string read GetLocalName;
    property NamespaceURI: string read GetNSURI;
    property NodeValue: string read GetNodeValue write SetNodeValue;
    property NodeType: TNodeType read GetNodeType;
    property ParentNode: OmniIXMLNode read GetParentNode;
    property ChildNodes: OmniIXMLNodeList read GetChildNodes;
    property FirstChild: OmniIXMLNode read GetFirstChild;
    property LastChild: OmniIXMLNode read GetLastChild;
    property PreviousSibling: OmniIXMLNode read GetPreviousSibling;
    property NextSibling: OmniIXMLNode read GetNextSibling;
    property Attributes: OmniIXMLNamedNodeMap read GetAttributes;
    property OwnerDocument: OmniIXMLDocument read GetOwnerDocument;
    property Text: string read GetText write SetText;
    constructor Create(const AOwnerDocument: OmniTXMLDocument);
    destructor Destroy; override;
    function InsertBefore(const NewChild, RefChild: OmniIXMLNode): OmniIXMLNode;
    function ReplaceChild(const NewChild, OldChild: OmniIXMLNode): OmniIXMLNode;
    function RemoveChild(const OldChild: OmniIXMLNode): OmniIXMLNode;
    function AppendChild(const NewChild: OmniIXMLNode): OmniIXMLNode;
    function HasChildNodes: Boolean;
    function CloneNode(const Deep: Boolean): OmniIXMLNode; virtual;
    procedure WriteToStream(const OutputStream: IUnicodeStream);
    function SelectNodes(Pattern: string): OmniIXMLNodeList; overload; virtual;
    function SelectSingleNode(Pattern: string): OmniIXMLNode; overload; virtual;
    property XML: string read GetXML;
  end;

                                                                              
(*
  OmniTXMLDocumentType = class(OmniTXMLNode, OmniIXMLNode)
  private
    function GetEntities: OmniIXMLNamedNodeMap;
    function GetName: string;
    function GetNotations: OmniIXMLNamedNodeMap;
  public
    property Name: string read GetName;
    property Entities: OmniIXMLNamedNodeMap read GetEntities;
    property Notations: OmniIXMLNamedNodeMap read GetNotations;
  end;
*)

  OmniTXMLEntityReference = class(OmniTXMLNode, OmniIXMLEntityReference);

  OmniTXMLDocumentFragment = class(OmniTXMLNode, OmniIXMLDocumentFragment)
  protected
    function GetNodeName: string; override;
    procedure ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream); override;
  public
    constructor Create(const OwnerDocument: OmniTXMLDocument);
  end;

  OmniTXMLCustomList = class(TInterfacedObject, OmniIXMLCustomList)
  private
    FList: TList<OmniIXMLNode>;
  protected
    function GetLength: Integer;
    function GetItem(const Index: Integer): OmniIXMLNode;
    procedure Put(Index: Integer; Item: OmniIXMLNode);
  public
    constructor Create;
    destructor Destroy; override;
    property Item[const Index: Integer]: OmniIXMLNode read GetItem; default;
    property Length: Integer read GetLength;
    function Add(const XMLNode: OmniIXMLNode): Integer;
    function IndexOf(const XMLNode: OmniIXMLNode): Integer;
    procedure Insert(const Index: Integer; const XMLNode: OmniIXMLNode);
    function Remove(const XMLNode: OmniIXMLNode): Integer;
    procedure Delete(const Index: Integer);
    procedure Clear;
  end;

  OmniTXMLNodeList = class(OmniTXMLCustomList, OmniIXMLNodeList)
  protected
    FItemNo: Integer;
  public
    procedure Reset;
    function NextNode: OmniIXMLNode;
    function AddNode(const Arg: OmniIXMLNode): OmniIXMLNode;
  end;

  OmniTXMLNamedNodeMap = class(OmniTXMLCustomList, OmniIXMLNamedNodeMap)
  public
    function GetNamedItem(const Name: string): OmniIXMLNode;
    function SetNamedItem(const Arg: OmniIXMLNode): OmniIXMLNode;
    function RemoveNamedItem(const Name: string): OmniIXMLNode;
    function GetNamedItemNS(const namespaceURI, localName: string): OmniIXMLNode;
    function SetNamedItemNS(const Arg: OmniIXMLNode): OmniIXMLNode;
    function RemoveNamedItemNS(const namespaceURI, localName: string): OmniIXMLNode;
  end;

  OmniTXMLElement = class(OmniTXMLNode, OmniIXMLElement)
  private
    FTagNameId: TDicId;
  protected
    function GetNodeName: string; override;
    function GetTagName: string;
    procedure InternalWriteToStream(const OutputStream: IUnicodeStream); override;
    procedure ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream); override;
    procedure SetTagName(const TagName: string);
  public
    property TagName: string read GetTagName;
    constructor CreateElement(const OwnerDocument: OmniTXMLDocument; const TagName: string);
    function GetAttribute(const Name: string): string;
    procedure SetAttribute(const Name, Value: string);
    procedure RemoveAttribute(const Name: string);
    function GetAttributeNode(const Name: string): OmniIXMLAttr;
    function SetAttributeNode(const NewAttr: OmniIXMLAttr): OmniIXMLAttr;
    function RemoveAttributeNode(const OldAttr: OmniIXMLAttr): OmniIXMLAttr;
    function GetElementsByTagName(const Name: string): OmniIXMLNodeList;
    procedure Normalize;
    //function CloneNode(const Deep: Boolean): OmniIXMLNode; override;
    procedure SetAttributeNS(const qualifiedName, Value: string);
    function SetAttributeNodeNS(const NewAttr: OmniIXMLAttr): OmniIXMLAttr;
    function GetElementsByTagNameNS(const namespaceURI, localName: string): OmniIXMLNodeList;
    function GetAttributeNS(const namespaceURI, localName: string): string;
    function GetAttributeNodeNS(const namespaceURI, localName: string): OmniIXMLAttr;
  end;

  OmniTXMLProcessingInstruction = class(OmniTXMLNode, OmniIXMLProcessingInstruction)
  private
    FTarget: string;
    FData: string;
    function GetData: string;
    function GetTarget: string;
  protected
    function GetNodeName: string; override;
    procedure SetData(Data: string); virtual;
    procedure InternalWriteToStream(const OutputStream: IUnicodeStream); override;
    procedure ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream); override;
  public
    property Target: string read GetTarget;
    property Data: string read GetData;
    constructor CreateProcessingInstruction(const OwnerDocument: OmniTXMLDocument; const Target, Data: string);
  end;

  OmniTXMLAttr = class(OmniTXMLNode, OmniIXMLAttr)
  private
    FNameId: TDicId;
    FSpecified: Boolean;
    function GetName: string;
    function GetSpecified: Boolean;
    function GetValue: string;
    procedure SetValue(const Value: string);
    procedure SetName(const Value: string);
  protected
    function GetNodeName: string; override;
    procedure SetNodeValue(const Value: string); override;
    function GetText: string; override;
    procedure ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream); override;
    procedure InternalWriteToStream(const OutputStream: IUnicodeStream); override;
    function GetOwnerElement: OmniIXMLElement;
  public
    property Name: string read GetName;
    property Specified: Boolean read GetSpecified;
    property Value: string read GetValue write SetValue;
    property OwnerElement: OmniIXMLElement read GetOwnerElement;
    constructor CreateAttr(const OwnerDocument: OmniTXMLDocument; const Name: string);
  end;

  OmniTXMLCharacterData = class(OmniTXMLNode, OmniIXMLCharacterData)
  private
    function GetData: string;
    function GetLength: Integer;
  protected
    FNodeValue: string;
    procedure SetData(const Value: string); virtual;
    function GetNodeValue: string; override;
    procedure SetNodeValue(const Value: string); override;
    procedure InternalWriteToStream(const OutputStream: IUnicodeStream); override;
    procedure ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream); override;
  public
    property Data: string read GetData write SetData;
    property Length: Integer read GetLength;
    constructor Create(const OwnerDocument: OmniTXMLDocument; const Data: string);
    function SubstringData(const Offset, Count: Integer): string;
    procedure AppendData(const Arg: string);
    procedure InsertData(const Offset: Integer; const Arg: string);
    procedure DeleteData(const Offset, Count: Integer);
    procedure ReplaceData(const Offset, Count: Integer; const Arg: string);
  end;

  OmniTXMLText = class(OmniTXMLCharacterData, OmniIXMLText)
  protected
    function GetNodeName: string; override;
    procedure ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream); override;
  public
    constructor Create(const OwnerDocument: OmniTXMLDocument; const Data: string);
    function SplitText(const Offset: Integer): OmniIXMLText;
  end;

  OmniTXMLComment = class(OmniTXMLCharacterData, OmniIXMLComment)
  protected
    function GetNodeName: string; override;
    procedure InternalWriteToStream(const OutputStream: IUnicodeStream); override;
    procedure ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream); override;
  public
    constructor Create(const OwnerDocument: OmniTXMLDocument; const Data: string);
  end;

  OmniTXMLCDATASection = class(OmniTXMLText, OmniIXMLCDATASection)
  private
    procedure CheckValue(const Value: string);
  protected
    function GetNodeName: string; override;
    procedure SetData(const Value: string); override;
    procedure SetNodeValue(const Value: string); override;
    procedure InternalWriteToStream(const OutputStream: IUnicodeStream); override;
    procedure ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream); override;
  public
    constructor Create(const OwnerDocument: OmniTXMLDocument; const Data: string);
  end;

  OmniTXMLDocumentType = class(OmniTXMLText, OmniIXMLDocumentType)
  protected
    function GetNodeName: string; override;
    procedure InternalWriteToStream(const OutputStream: IUnicodeStream); override;
    procedure ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream); override;
  public
    constructor Create(const OwnerDocument: OmniTXMLDocument; const Data: string);
  end;

  OmniTXMLAttrClass = class of OmniTXMLAttr;
  OmniTXMLCDATASectionClass = class of OmniTXMLCDATASection;
  OmniTXMLCommentClass = class of OmniTXMLComment;
  OmniTXMLDocumentTypeClass = class of OmniTXMLDocumentType;
  OmniTXMLElementClass = class of OmniTXMLElement;
  OmniTXMLProcessingInstructionClass = class of OmniTXMLProcessingInstruction;
  OmniTXMLTextClass = class of OmniTXMLText;

  OmniTXMLDocument = class(OmniTXMLNode, OmniIXMLDocument)
  private
    FDocType: OmniIXMLDocumentType;
    FIParseError: OmniIXMLParseError;
    FParseError: OmniTXMLParseError;
    FPreserveWhiteSpace: Boolean;
    FURL: string;
    FNSpace:Boolean;
    StartTag: Boolean;
  protected
    function GetNodeName: string; override;
    function GetParseError: OmniIXMLParseError;
    function GetDocType: OmniIXMLDocumentType;
                                                                                
//    procedure SetDocType(const Value: OmniIXMLDocumentType);
    function GetDocumentElement: OmniIXMLElement;
    procedure SetDocumentElement(const Value: OmniIXMLElement);
    function GetPreserveWhiteSpace: Boolean;
    procedure SetPreserveWhiteSpace(const Value: Boolean);
    function GetText: string; override;
    function GetOwnerDocument: OmniIXMLDocument; override;
  protected
    FXMLAttrClass: OmniTXMLAttrClass;
    FXMLCDATASectionClass: OmniTXMLCDATASectionClass;
    FXMLCommentClass: OmniTXMLCommentClass;
    FXMLDocTypeClass: OmniTXMLDocumentTypeClass;
    FXMLElementClass: OmniTXMLElementClass;
    FXMLProcessingInstructionClass: OmniTXMLProcessingInstructionClass;
    FXMLTextClass: OmniTXMLTextClass;
    // creating new childs
    function InternalCreateAttribute(const Name: string): OmniTXMLAttr;
    function InternalCreateCDATASection(const Data: string): OmniTXMLCDATASection;
    function InternalCreateComment(const Data: string): OmniTXMLComment;
    function InternalCreateDocType(const Data: string): OmniTXMLDocumentType;
    function InternalCreateDocumentFragment: OmniTXMLDocumentFragment;
    function InternalCreateElement(const TagName: string): OmniTXMLElement;
    function InternalCreateEntityReference(const Name: string): OmniTXMLEntityReference;
    function InternalCreateProcessingInstruction(const Target, Data: string): OmniTXMLProcessingInstruction;
    function InternalCreateTextNode(const Data: string): OmniTXMLText;
    // reading / writing support
    procedure ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream); override;
    procedure InternalWriteToStream(const OutputStream: IUnicodeStream); override;
  public
    UnclosedElementList: TInterfaceList;
    property DocType: OmniIXMLDocumentType read GetDocType;
    property DocumentElement: OmniIXMLElement read GetDocumentElement write SetDocumentElement;
    property PreserveWhiteSpace: Boolean read GetPreserveWhiteSpace write SetPreserveWhiteSpace;
    constructor Create; virtual;
    destructor Destroy; override;
    function CreateAttribute(const Name: string): OmniIXMLAttr;
    function CreateCDATASection(const Data: string): OmniIXMLCDATASection;
    function CreateComment(const Data: string): OmniIXMLComment;
    function CreateDocType(const Data: string): OmniIXMLDocumentType;
    function CreateDocumentFragment: OmniIXMLDocumentFragment;
    function CreateElement(const TagName: string): OmniIXMLElement;
    function CreateEntityReference(const Name: string): OmniIXMLEntityReference;
    function CreateProcessingInstruction(const Target, Data: string): OmniIXMLProcessingInstruction;
    function CreateTextNode(const Data: string): OmniIXMLText;
    function GetElementsByTagName(const TagName: string): OmniIXMLNodeList;
    function CreateAttributeNS(const namespaceURI, qualifiedName: string): OmniIXMLAttr;
    function CreateElementNS(const namespaceURI, qualifiedName: string): OmniIXMLElement;
    function GetElementsByTagNameNS(const namespaceURI, localName: string): OmniIXMLNodeList;

    function Load(const FileName: string): Boolean; virtual;
    function LoadFromStream(const Stream: TStream): Boolean;
    procedure Save(const FileName: string; const OutputFormat: TOutputFormat = ofNone); virtual;
    procedure SaveToStream(const OutputStream: TStream; const OutputFormat: TOutputFormat = ofNone);
    function LoadXML(const XML: string): Boolean; virtual;
    property ParseError: OmniIXMLParseError read GetParseError;
  end;

// helper Classes
  TTexListDic = class
  private
    FTexPosDic: TTexPosDic;
    FTextList: TStringList;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    function PositionOf(const Text: string): Integer;
    function Add(const Text: string): TDicId;
    function Get(const Id: TDicId): string;
  end;

// helper functions
function CreateXMLDoc: OmniIXMLDocument;
// Unicode functions
function UniTrim(const Value: string): string;

// XML related helper functions
function CharIs_Letter(const ch: Char): Boolean; inline;
function CharIs_WhiteSpace(const ch: Char): Boolean; inline;
function CharIs_Char(const ch: Char): Boolean; inline;
function CharIs_NameChar(const ch: Char): Boolean;
function CharIs_Name(const ch: Char; const IsFirstChar: Boolean): Boolean;

function EncodeText(const Value: string): string;
function ShrinkEol(const Value: string): string;
function ExpandEol(const Value: string): string;

implementation

{$ZEROBASEDSTRINGS OFF}

uses
  Xml.Internal.OmniXMLXPath, System.Character;

const
  MAX_OUTPUTBUFFERSIZE = 256;  // initial output buffer size (it only stores one tag at once!)
  OUTPUT_INDENT = 2;

type
  TCharRef = record
    Code: Word;
    Name: string;
  end;
  TCharacterReferences = array[1..101] of TCharRef;

var
  DOMErrorInfoList: array[INDEX_SIZE_ERR..INUSE_ATTRIBUTE_ERR] of string = (
    'Index or size is negative, or greater than the allowed value',
    'The specified range of text does not fit into a WideString',
    'Any node is inserted somewhere it doesn''t belong',
    'A node is used in a different document than the one that created it (that doesn''t support it)',
    'An invalid character is specified, such as in a name',
    'Data is specified for a node which does not support data',
    'An attempt is made to modify an object where modifications are not allowed',
    'An attempt was made to reference a node in a context where it does not exist',
    'The implementation does not support the type of object requested',
    'An attempt is made to add an attribute that is already inuse elsewhere');

type
  TErrorInfo = record
    ID: Integer;
    Text: string;
  end;

var
  NodeTypeList: array[TNodeType] of String =
    ('ELEMENT', 'ATTRIBUTE', 'TEXT', 'CDATA_SECTION', 'ENTITY_REFERENCE',
    'ENTITY_NODE', 'PROCESSING_INSTRUCTION', 'COMMENT', 'DOCUMENT',
    'DOCUMENT_TYPE', 'DOCUMENT_FRAGMENT', 'NOTATION');

var
  XMLErrorInfoList: array[MSG_E_NOTEXT..NS_E_BADNAMECHAR] of TErrorInfo =
    ( (ID: MSG_E_NOTEXT; Text: '%s'),
      (ID: MSG_E_FORMATINDEX_BADINDEX; Text: 'The value passed in to formatIndex needs to be greater than zero.'),
      (ID: MSG_E_FORMATINDEX_BADFORMAT; Text: 'Invalid format string.'),
      (ID: MSG_E_SYSTEM_ERROR; Text: 'System error: %s.'),
      (ID: MSG_E_MISSINGEQUALS; Text: 'Missing equals sign between attribute and attribute value.'),
      (ID: MSG_E_EXPECTED_TOKEN; Text: 'Expected token %s found %s.'),
      (ID: MSG_E_UNEXPECTED_TOKEN; Text: 'Unexpected token %s.'),
      (ID: MSG_E_MISSINGQUOTE; Text: 'A string literal was expected, but no opening quote character was found.'),
      (ID: MSG_E_COMMENTSYNTAX; Text: 'Incorrect syntax was used in a comment.'),
      (ID: MSG_E_BADSTARTNAMECHAR; Text: 'A name started with an invalid character.'),
      (ID: MSG_E_BADNAMECHAR; Text: 'A name contained an invalid character.'),
      (ID: MSG_E_BADCHARINSTRING; Text: 'The character "<" cannot be used in an attribute value.'),
      (ID: MSG_E_XMLDECLSYNTAX; Text: 'Invalid syntax for an xml declaration.'),
      (ID: MSG_E_BADCHARDATA; Text: 'An invalid character was found in text content.'),
      (ID: MSG_E_MISSINGWHITESPACE; Text: 'Required white space was missing.'),
      (ID: MSG_E_EXPECTINGTAGEND; Text: 'The character ">" was expected.'),
      (ID: MSG_E_BADCHARINDTD; Text: 'Invalid character found in DTD.'),
      (ID: MSG_E_BADCHARINDECL; Text: 'An invalid character was found inside a DTD declaration.'),
      (ID: MSG_E_MISSINGSEMICOLON; Text: 'A semi colon character was expected.'),
      (ID: MSG_E_BADCHARINENTREF; Text: 'An invalid character was found inside an entity reference.'),
      (ID: MSG_E_UNBALANCEDPAREN; Text: 'Unbalanced parentheses.'),
      (ID: MSG_E_EXPECTINGOPENBRACKET; Text: 'An opening "[" character was expected.'),
      (ID: MSG_E_BADENDCONDSECT; Text: 'Invalid syntax in a conditional section.'),
      (ID: MSG_E_INTERNALERROR; Text: 'Internal error: %s'),
      (ID: MSG_E_UNEXPECTED_WHITESPACE; Text: 'Whitespace is not allowed at this location.'),
      (ID: MSG_E_INCOMPLETE_ENCODING; Text: 'End of file reached in invalid state for current encoding.'),
      (ID: MSG_E_BADCHARINMIXEDMODEL; Text: 'Mixed content model cannot contain this character.'),
      (ID: MSG_E_MISSING_STAR; Text: 'Mixed content model must be defined as zero or more("*").'),
      (ID: MSG_E_BADCHARINMODEL; Text: 'Invalid character in content model.'),
      (ID: MSG_E_MISSING_PAREN; Text: 'Missing parenthesis.'),
      (ID: MSG_E_BADCHARINENUMERATION; Text: 'Invalid character found in ATTLIST enumeration.'),
      (ID: MSG_E_PIDECLSYNTAX; Text: 'Invalid syntax in processing instruction declaration.'),
      (ID: MSG_E_EXPECTINGCLOSEQUOTE; Text: 'A single or double closing quote character ('' or ") is missing.'),
      (ID: MSG_E_MULTIPLE_COLONS; Text: 'Multiple colons are not allowed in a name.'),
      (ID: MSG_E_INVALID_DECIMAL; Text: 'Invalid character for decimal digit.'),
      (ID: MSG_E_INVALID_HEXADECIMAL; Text: 'Invalid character for hexadecimal digit.'),
      (ID: MSG_E_INVALID_UNICODE; Text: 'Invalid Unicode character value for this platform.'),
      (ID: MSG_E_WHITESPACEORQUESTIONMARK; Text: 'Expecting white space or "?".'),
      (ID: MSG_E_SUSPENDED; Text: 'The parser is suspended.'),
      (ID: MSG_E_STOPPED; Text: 'The parser is stopped.'),
      (ID: MSG_E_UNEXPECTEDENDTAG; Text: 'End tag was not expected at this location.'),
      (ID: MSG_E_UNCLOSEDTAG; Text: 'The following tags were not closed: %s.'),
      (ID: MSG_E_DUPLICATEATTRIBUTE; Text: 'Duplicate attribute.'),
      (ID: MSG_E_MULTIPLEROOTS; Text: 'Only one top level element is allowed in an XML document.'),
      (ID: MSG_E_INVALIDATROOTLEVEL; Text: 'Invalid character at the top level of the document.'),
      (ID: MSG_E_BADXMLDECL; Text: 'Invalid XML declaration.'),
      (ID: MSG_E_MISSINGROOT; Text: 'XML document must have a top level element.'),
      (ID: MSG_E_UNEXPECTEDEOF; Text: 'Unexpected end of file.'),
      (ID: MSG_E_BADPEREFINSUBSET; Text: 'Parameter entities cannot be used inside markup declarations in an internal subset.'),
      (ID: MSG_E_PE_NESTING; Text: 'The replacement text for a parameter entity must be properly nested with parenthesized groups.'),
      (ID: MSG_E_INVALID_CDATACLOSINGTAG; Text: 'The literal string "]]>" is not allowed in element content.'),
      (ID: MSG_E_UNCLOSEDPI; Text: 'Processing instruction was not closed.'),
      (ID: MSG_E_UNCLOSEDSTARTTAG; Text: 'Element was not closed.'),
      (ID: MSG_E_UNCLOSEDENDTAG; Text: 'End element was missing the character ">".'),
      (ID: MSG_E_UNCLOSEDSTRING; Text: 'A string literal was not closed.'),
      (ID: MSG_E_UNCLOSEDCOMMENT; Text: 'A comment was not closed.'),
      (ID: MSG_E_UNCLOSEDDECL; Text: 'A declaration was not closed.'),
      (ID: MSG_E_UNCLOSEDMARKUPDECL; Text: 'A markup declaration was not closed.'),
      (ID: MSG_E_UNCLOSEDCDATA; Text: 'A CDATA section was not closed.'),
      (ID: MSG_E_BADDECLNAME; Text: 'Declaration has an invalid name.'),
      (ID: MSG_E_BADEXTERNALID; Text: 'External ID is invalid.'),
      (ID: MSG_E_BADELEMENTINDTD; Text: 'An XML element is not allowed inside a DTD.'),
      (ID: MSG_E_RESERVEDNAMESPACE; Text: 'The namespace prefix is not allowed to start with the reserved string "xml".'),
      (ID: MSG_E_EXPECTING_VERSION; Text: 'The version attribute is required at this location.'),
      (ID: MSG_E_EXPECTING_ENCODING; Text: 'The encoding attribute is required at this location.'),
      (ID: MSG_E_EXPECTING_NAME; Text: 'At least one name is required at this location.'),
      (ID: MSG_E_UNEXPECTED_ATTRIBUTE; Text: 'The specified attribute was not expected at this location. The attribute may be case-sensitive.'),
      (ID: MSG_E_ENDTAGMISMATCH; Text: 'End tag %s does not match the start tag %s.'),
      (ID: MSG_E_INVALIDENCODING; Text: 'System does not support the specified encoding.'),
      (ID: MSG_E_INVALIDSWITCH; Text: 'Switch from current encoding to specified encoding not supported.'),
      (ID: MSG_E_EXPECTING_NDATA; Text: 'NDATA keyword is missing.'),
      (ID: MSG_E_INVALID_MODEL; Text: 'Content model is invalid.'),
      (ID: MSG_E_INVALID_TYPE; Text: 'Invalid type defined in ATTLIST.'),
      (ID: MSG_E_INVALIDXMLSPACE; Text: 'XML space attribute has invalid value. Must specify "default" or "preserve".'),
      (ID: MSG_E_MULTI_ATTR_VALUE; Text: 'Multiple names found in attribute value when only one was expected.'),
      (ID: MSG_E_INVALID_PRESENCE; Text: 'Invalid ATTDEF declaration. Expected #REQUIRED, #IMPLIED, or #FIXED.'),
      (ID: MSG_E_BADXMLCASE; Text: 'The name "xml" is reserved and must be lowercase.'),
      (ID: MSG_E_CONDSECTINSUBSET; Text: 'Conditional sections are not allowed in an internal subset.'),
      (ID: MSG_E_CDATAINVALID; Text: 'CDATA is not allowed in a DTD.'),
      (ID: MSG_E_INVALID_STANDALONE; Text: 'The standalone attribute must have the value "yes" or "no".'),
      (ID: MSG_E_UNEXPECTED_STANDALONE; Text: 'The standalone attribute cannot be used in external entities.'),
      (ID: MSG_E_DOCTYPE_IN_DTD; Text: 'Cannot have a DOCTYPE declaration in a DTD.'),
      (ID: MSG_E_MISSING_ENTITY; Text: 'Reference to an undefined entity.'),
      (ID: MSG_E_ENTITYREF_INNAME; Text: 'Entity reference is resolved to an invalid name character.'),
      (ID: MSG_E_DOCTYPE_OUTSIDE_PROLOG; Text: 'Cannot have a DOCTYPE declaration outside of a prolog.'),
      (ID: MSG_E_INVALID_VERSION; Text: 'Invalid version number.'),
      (ID: MSG_E_DTDELEMENT_OUTSIDE_DTD; Text: 'Cannot have a DTD declaration outside of a DTD.'),
      (ID: MSG_E_DUPLICATEDOCTYPE; Text: 'Cannot have multiple DOCTYPE declarations.'),
      (ID: MSG_E_RESOURCE; Text: 'Error processing resource %s.'),
      (ID: MSG_E_INVALID_OPERATION; Text: 'This operation can not be performed with a Node of type %s.'),
      (ID: MSG_E_WRONG_DOCUMENT; Text: 'NewChild was created from a different document than the one that created this node.'),

      (ID: XML_IOERROR; Text: 'Error opening input file: ''%s''.'),
      (ID: XML_ENTITY_UNDEFINED; Text: 'Reference to undefined entity %s.'),
      (ID: XML_INFINITE_ENTITY_LOOP; Text: 'Entity %s contains an infinite entity reference loop.'),
      (ID: XML_NDATA_INVALID_PE; Text: 'Cannot use the NDATA keyword in a parameter entity declaration.'),
      (ID: XML_REQUIRED_NDATA; Text: 'Cannot use a general parsed entity ''%s'' as the value for attribute ''%s''.'),
      (ID: XML_NDATA_INVALID_REF; Text: 'Cannot use unparsed entity %s in an entity reference.'),
      (ID: XML_EXTENT_IN_ATTR; Text: 'Cannot reference an external general parsed entity %s in an attribute value.'),
      (ID: XML_STOPPED_BY_USER; Text: 'XML parser stopped by user.'),
      (ID: XML_PARSING_ENTITY; Text: 'Error while parsing entity %s. %s.'),
      (ID: XML_E_MISSING_PE_ENTITY; Text: 'Parameter entity must be defined before it is used.'),
      (ID: XML_E_MIXEDCONTENT_DUP_NAME; Text: 'The same name must not appear more than once in a single mixed-content declaration: %s.'),
      (ID: XML_NAME_COLON; Text: 'Entity, EntityRef, PI, Notation names, or NMToken cannot contain a colon.'),
      (ID: XML_ELEMENT_UNDECLARED; Text: 'The element %s is used but not declared in the DTD/Schema.'),
      (ID: XML_ELEMENT_ID_NOT_FOUND; Text: 'The attribute %s references the ID %s, which is not defined anywhere in the document.'),
      (ID: XML_DEFAULT_ATTRIBUTE; Text: 'Error in the default attribute value defined in DTD/Schema.'),
      (ID: XML_XMLNS_RESERVED; Text: 'Reserved namespace "%s" cannot be redeclared.'),
      (ID: XML_EMPTY_NOT_ALLOWED; Text: 'Element cannot be empty according to the DTD/Schema.'),
      (ID: XML_ELEMENT_NOT_COMPLETE; Text: 'Element content is incomplete according to the DTD/Schema.'),
      (ID: XML_ROOT_NAME_MISMATCH; Text: 'The name of the top-most element must match the name of the DOCTYPE declaration.'),
      (ID: XML_INVALID_CONTENT; Text: 'Element content is invalid according to the DTD/Schema.'),
      (ID: XML_ATTRIBUTE_NOT_DEFINED; Text: 'The attribute %s on this element is not defined in the DTD/Schema.'),
      (ID: XML_ATTRIBUTE_FIXED; Text: 'Attribute %s has a value which does not match the fixed value defined in the DTD/Schema.'),
      (ID: XML_ATTRIBUTE_VALUE; Text: 'Attribute %s has an invalid value according to the DTD/Schema.'),
      (ID: XML_ILLEGAL_TEXT; Text: 'Text is not allowed in this element according to the DTD/Schema.'),
      (ID: XML_MULTI_FIXED_VALUES; Text: 'An attribute declaration cannot contain multiple fixed values: "%s".'),
      (ID: XML_NOTATION_DEFINED; Text: 'The notation %s is already declared.'),
      (ID: XML_ELEMENT_DEFINED; Text: 'The element %s is already declared.'),
      (ID: XML_ELEMENT_UNDEFINED; Text: 'Reference to undeclared element: %s.'),
      (ID: XML_XMLNS_UNDEFINED; Text: 'Reference to undeclared namespace prefix: %s.'),
      (ID: XML_XMLNS_FIXED; Text: 'Attribute %s must be a #FIXED attribute.'),
      (ID: XML_E_UNKNOWNERROR; Text: 'Unknown error: %s.'),
      (ID: XML_REQUIRED_ATTRIBUTE_MISSING; Text: 'Required attribute %s is missing.'),
      (ID: XML_MISSING_NOTATION; Text: 'Declaration %s contains a reference to undefined notation %s.'),
      (ID: XML_ATTLIST_DUPLICATED_ID; Text: 'Cannot define multiple ID attributes on the same element.'),
      (ID: XML_ATTLIST_ID_PRESENCE; Text: 'An attribute of type ID must have a declared default of #IMPLIED or #REQUIRED.'),
      (ID: XML_XMLLANG_INVALIDID; Text: 'The language ID %s is invalid.'),
      (ID: XML_PUBLICID_INVALID; Text: 'The public ID %s is invalid.'),
      (ID: XML_DTD_EXPECTING; Text: 'Expecting: %s.'),
      (ID: XML_NAMESPACE_URI_EMPTY; Text: 'Only a default namespace can have an empty URI.'),
      (ID: XML_LOAD_EXTERNALENTITY; Text: 'Could not load %s.'),
      (ID: XML_BAD_ENCODING; Text: 'Unable to save character to %s encoding.'),

      (ID: NS_NS_ERROR; Text: 'Namespace ERROR'),
      (ID: NS_EMPTY_NOT_ALLOWED; Text: 'Element cannot be empty according to the NS definition.'),
      (ID: NS_E_BADNAMECHAR; Text: 'A name contained an invalid character %s.'));


var
  CharacterReferences: TCharacterReferences = (
    (Code:  34; Name: 'quot'),
    (Code:  38; Name: 'amp'),
    (Code:  39; Name: 'apos'),
    (Code:  60; Name: 'lt'),
    (Code:  62; Name: 'gt'),
    (Code: 160; Name: 'nbsp'),
    (Code: 161; Name: 'iexcl'),
    (Code: 162; Name: 'cent'),
    (Code: 163; Name: 'pound'),
    (Code: 164; Name: 'curren'),
    (Code: 165; Name: 'yen'),
    (Code: 166; Name: 'brvbar'),
    (Code: 167; Name: 'sect'),
    (Code: 168; Name: 'uml'),
    (Code: 169; Name: 'copy'),
    (Code: 170; Name: 'ordf'),
    (Code: 171; Name: 'laquo'),
    (Code: 172; Name: 'not'),
    (Code: 173; Name: 'shy'),
    (Code: 174; Name: 'reg'),
    (Code: 175; Name: 'macr'),
    (Code: 176; Name: 'deg'),
    (Code: 177; Name: 'plusm'),
    (Code: 178; Name: 'sup2'),
    (Code: 179; Name: 'sup3'),
    (Code: 180; Name: 'acute'),
    (Code: 181; Name: 'micro'),
    (Code: 182; Name: 'para'),
    (Code: 183; Name: 'middot'),
    (Code: 184; Name: 'cedil'),
    (Code: 185; Name: 'supl'),
    (Code: 186; Name: 'ordm'),
    (Code: 187; Name: 'raquo'),
    (Code: 188; Name: 'frac14'),
    (Code: 189; Name: 'frac12'),
    (Code: 190; Name: 'frac34'),
    (Code: 191; Name: 'iquest'),
    (Code: 192; Name: 'Agrave'),
    (Code: 193; Name: 'Aacute'),
    (Code: 194; Name: 'circ'),
    (Code: 195; Name: 'Atilde'),
    (Code: 196; Name: 'Auml'),
    (Code: 197; Name: 'ring'),
    (Code: 198; Name: 'AElig'),
    (Code: 199; Name: 'Ccedil'),
    (Code: 200; Name: 'Egrave'),
    (Code: 201; Name: 'Eacute'),
    (Code: 202; Name: 'Ecirc'),
    (Code: 203; Name: 'Euml'),
    (Code: 204; Name: 'Igrave'),
    (Code: 205; Name: 'Iacute'),
    (Code: 206; Name: 'Icirc'),
    (Code: 207; Name: 'Iuml'),
    (Code: 208; Name: 'ETH'),
    (Code: 209; Name: 'Ntilde'),
    (Code: 210; Name: 'Ograve'),
    (Code: 211; Name: 'Oacute'),
    (Code: 212; Name: 'Ocirc'),
    (Code: 213; Name: 'Otilde'),
    (Code: 214; Name: 'Ouml'),
    (Code: 215; Name: 'times'),
    (Code: 216; Name: 'Oslash'),
    (Code: 217; Name: 'Ugrave'),
    (Code: 218; Name: 'Uacute'),
    (Code: 219; Name: 'Ucirc'),
    (Code: 220; Name: 'Uuml'),
    (Code: 221; Name: 'Yacute'),
    (Code: 222; Name: 'THORN'),
    (Code: 223; Name: 'szlig'),
    (Code: 224; Name: 'agrave'),
    (Code: 225; Name: 'aacute'),
    (Code: 226; Name: 'acirc'),
    (Code: 227; Name: 'atilde'),
    (Code: 228; Name: 'auml'),
    (Code: 229; Name: 'aring'),
    (Code: 230; Name: 'aelig'),
    (Code: 231; Name: 'ccedil'),
    (Code: 232; Name: 'egrave'),
    (Code: 233; Name: 'eacute'),
    (Code: 234; Name: 'ecirc'),
    (Code: 235; Name: 'euml'),
    (Code: 236; Name: 'igrave'),
    (Code: 237; Name: 'iacute'),
    (Code: 238; Name: 'icirc'),
    (Code: 239; Name: 'iuml'),
    (Code: 240; Name: 'ieth'),
    (Code: 241; Name: 'ntilde'),
    (Code: 242; Name: 'ograve'),
    (Code: 243; Name: 'oacute'),
    (Code: 244; Name: 'ocirc'),
    (Code: 245; Name: 'otilde'),
    (Code: 246; Name: 'ouml'),
    (Code: 247; Name: 'divide'),
    (Code: 248; Name: 'oslash'),
    (Code: 249; Name: 'ugrave'),
    (Code: 250; Name: 'uacute'),
    (Code: 251; Name: 'ucirc'),
    (Code: 252; Name: 'uuml'),
    (Code: 253; Name: 'yacute'),
    (Code: 254; Name: 'thorn'),
    (Code: 255; Name: 'yuml')
  );

const
  BIT_IS_BaseChar = Byte($01);
  BIT_IS_CombiningChar = Byte($02);
  BIT_IS_Digit = Byte($04);
  BIT_IS_Ideographic = Byte($08);
  BIT_IS_Letter = Byte($10);
  BIT_IS_Extender = Byte($20);
  BIT_IS_Char = Byte($40);
  BIT_IS_NameChar = Byte($80);

function CreateXMLDoc: OmniIXMLDocument;
begin
  Result := OmniTXMLDocument.Create;
end;

function FindEncoding(const PI: OmniIXMLProcessingInstruction; var OutEncoding: TEncoding): Boolean;
var
  EncodingStartPos,
  EncodingEndPos: Integer;
  R: string;
  Encoding: string;
  DelimiterChar: Char;
begin
  OutEncoding := nil;
  Result := False;
  if CompareText(PI.Target, 'xml') = 0 then
  begin
    // 2004-02-06 (mr): modified to recognize valid delimiter characters
    EncodingStartPos := Pos(string('encoding='), PI.Data) + 9;

    if EncodingStartPos > 9 then
    begin
      DelimiterChar := PI.Data[EncodingStartPos];

      if (DelimiterChar = '''') or (DelimiterChar = '"') then
      begin
        Inc(EncodingStartPos);
        R := Copy(PI.Data, EncodingStartPos, MaxInt);
        EncodingEndPos := Pos(DelimiterChar, R) + EncodingStartPos;
        if EncodingEndPos > 0 then
        begin
          Encoding := Copy(PI.Data, EncodingStartPos, EncodingEndPos - EncodingStartPos - 1);
          outEncoding := Tencoding.GetEncoding(Encoding);
          if outEncoding <> nil then
            Result := True;
        end;
      end;
    end;
  end;
end;

function FindCharReference(const CharReferenceName: string; var Character: Char): Boolean;
var
  i: Integer;
begin
  Result := False;

  i := Low(CharacterReferences);
  while (not Result) and (i <= High(CharacterReferences)) do
  begin
    Result := CompareStr(CharReferenceName, CharacterReferences[i].Name) = 0;
    if Result then
      Character := Char(CharacterReferences[i].Code)
    else
      Inc(i);
  end;
end;
// [*] --> http://www.w3.org/TR/2000/REC-xml-20001006
function CharIs_Letter(const ch: Char): Boolean;
begin
  // [84] Letter ::= BaseChar | Ideographic
  Result := Ch.IsLetter;
end;

function CharIs_WhiteSpace(const ch: Char): Boolean;
begin
  // [3] WhiteSpace
  Result := Ch.IsWhiteSpace;
end;

function CharIs_Char(const ch: Char): Boolean;
var
  _ch: LongWord;
begin
  // [2] Char - Legal characters are tab, carriage return, line feed, and the legal characters of Unicode and ISO/IEC 10646.
  // excluding the surrogate blocks, FFFE, and FFFF
  _ch := Ord(ch);
  Result := (not Ch.IsControl) or (_ch = $0009) or (_ch = $000A) or (_ch = $000D) ;
end;

function CharIs_NameChar(const ch: Char): Boolean;
var
  _ch: LongWord;
begin
  // [4] NameChar ::= Letter | Digit | '.' | '-' | '_' | ':' | CombiningChar | Extender
  _ch := Ord(ch);
  Result := Ch.IsLetterOrDigit or (_ch = $002E) or (_ch = $002D) or (_ch = $005F) or (_ch = $003A)
end;

function CharIs_Name(const ch: Char; const IsFirstChar: Boolean): Boolean;
var
  _ch: LongWord;
begin
  // [5] Name ::= (Letter | '_' | ':') (NameChar)*
  _ch := Ord(ch);
  if IsFirstChar then
    Result := CharIs_Letter(ch) or (_ch = $005F) or (_ch = $003A)  // '_', ':'
  else
    Result := CharIs_NameChar(ch);
end;

//
//  E N D
// 


function EncodeText(const Value: string): string;
var
  iResult: Integer;
  iValue: Integer;

  procedure ExtendResult(atLeast: Integer = 0);
  begin
    SetLength(Result, Round(1.1 * System.Length(Result) + atLeast));
  end;

  procedure Store(const token: string);
  var
    iToken: Integer;
  begin
    if (iResult + System.Length(token)) >= System.Length(Result) then
      ExtendResult(System.Length(token));
    for iToken := 1 to System.Length(token) do
    begin
      Inc(iResult);
      Result[iResult] := token[iToken];
    end;
  end;
begin
  SetLength(Result, Round(1.1 * System.Length(Value)));  // a wild guess
  iResult := 0;
  iValue := 1;
  while iValue <= System.Length(Value) do
  begin
    case Ord(Value[iValue]) of
      34: Store('&quot;');
      38: Store('&amp;');
      39: Store('&apos;');
      60: Store('&lt;');
      62: Store('&gt;');
    else
      begin
        Inc(iResult);
        if iResult > System.Length(Result) then
          ExtendResult;
        Result[iResult] := Value[iValue];
      end;
    end;
    Inc(iValue);
  end;
  SetLength(Result, iResult);
end;

function Reference2Char(const InputStream: IUnicodeStream): Char;
type
  TParserState = (psReference, psEntityRef, psCharRef, psCharDigitalRef, psCharHexRef);
var
  ReadChar: Char;
  PState: TParserState;
  CharRef: LongWord;
  EntityName: string;
begin
  // [67] Reference ::= EntityRef | CharRef
  // [68] EntityRef ::= '&' Name ';'
  // [66] CharRef ::= '&#' [0-9]+ ';' | '&#x' [0-9a-fA-F]+ ';'
  PState := psReference;
  CharRef := 0;
  Result := ' ';
  // read next available character
  while InputStream.ProcessChar(ReadChar) do
  begin
    case PState of
      psReference:
        if CharIs_WhiteSpace(ReadChar) then
          raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_UNEXPECTED_WHITESPACE, [])
        else if ReadChar = '#' then
          PState := psCharRef
        else
        begin
          if CharIs_Name(ReadChar, True) then
          begin
            PState := psEntityRef;
            EntityName := ReadChar;
          end
          else
            raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_BADSTARTNAMECHAR, []);
        end;
      psCharRef:
        if CharIs_WhiteSpace(ReadChar) then
          raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_UNEXPECTED_WHITESPACE, [])
        else
        begin
          case ReadChar of
            '0'..'9':
              begin
                CharRef := Ord(ReadChar) - 48;
                PState := psCharDigitalRef;
              end;
            'x': PState := psCharHexRef;
          else
            raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_BADCHARINENTREF, []);
          end;
        end;
      psCharDigitalRef:
        if CharIs_WhiteSpace(ReadChar) then
          raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_UNEXPECTED_WHITESPACE, [])
        else
        begin
          case ReadChar of
            '0'..'9': CharRef := LongWord(CharRef * 10) + LongWord(Ord(ReadChar) - 48);
            ';':
              if CharIs_Char(Char(CharRef)) then
              begin
                Result := Char(CharRef);
                Exit;
              end
              else
                raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_INVALID_UNICODE, []);
          else
            raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_INVALID_DECIMAL, []);
          end;
        end;
      psCharHexRef:
        if CharIs_WhiteSpace(ReadChar) then
          raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_UNEXPECTED_WHITESPACE, [])
        else
        begin
          case ReadChar of
            '0'..'9': CharRef := LongWord(CharRef shl 4) + LongWord(Ord(ReadChar) - 48);
            'A'..'F': CharRef := LongWord(CharRef shl 4) + LongWord(Ord(ReadChar) - 65 + 10);
            'a'..'f': CharRef := LongWord(CharRef shl 4) + LongWord(Ord(ReadChar) - 97 + 10);
            ';':
              if CharIs_Char(Char(CharRef)) then
              begin
                Result := Char(CharRef);
                Exit;
              end
              else
                raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_INVALID_UNICODE, []);
          else
            raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_INVALID_HEXADECIMAL, []);
          end;
          // simple "out of range" check
          if CharRef > $10FFFF then
            raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_INVALID_UNICODE, []);
        end;
      psEntityRef:
        case ReadChar of
          ';':
            begin
              if FindCharReference(EntityName, Result) then
                Exit
              else
                raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, XML_ENTITY_UNDEFINED, [EntityName]);
            end;
        else
          if CharIs_NameChar(ReadChar) then
            EntityName := EntityName + ReadChar
          else
            raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_MISSINGSEMICOLON, []);
        end;
    end;
  end;
end;

// Unicode functions

function UniTrim(const Value: string): string;
var
  Start, Stop: Integer;
begin
  Start := 1;
  Stop := Length(Value);

  // trim from start
  while (Start <= Stop) and (Value[Start] = #$0020) do
    Inc(Start);

  // little optimization
  if Start > Stop then
  begin
    Result := '';
    Exit;
  end;

  // trim from end
  while (Value[Stop] = #$0020) and (Stop > Start) do
    Dec(Stop);

  Result := Copy(Value, Start, Stop - Start + 1);
end;

// Eol and Whitespace handling

function ShrinkEol(const Value: string): string;
var
  i: Integer;
  SkipFirstLF: Boolean;
  ResultPos: Integer;
  ValueLength: Integer;
begin
  // 2003-02-22 (mr): speed optimization: skip conversion when Value contains no CR characters
  i := 1;
  while i <= System.Length(Value) do
  begin
    if Value[i] = #$000D then
      Break;
    Inc(i);
  end;
  if i > System.Length(Value) then
  begin
    // indeed, there was no CR so return original text
    Result := Value;
    Exit;
  end;

  // 2003-08-29 (eb): optimized
  // The result string can only shrink or remain the same, not grow
  ValueLength := System.Length(Value);
  SetLength(Result, ValueLength);
  ResultPos := 1;
  SkipFirstLF := False;
  for i := 1 to ValueLength do
  begin
    Assert(ResultPos <= ValueLength);
    if Value[i] = #$000D then
    begin
      SkipFirstLF := True;
      Result[ResultPos] := #$000A;
      Inc(ResultPos);
    end
    else if not ((Value[i] = #$000A) and SkipFirstLF) then
    begin
      SkipFirstLF := False;
      Result[ResultPos] := Value[i];
      Inc(ResultPos);
    end
    else if Value[i] = #$000A then
      SkipFirstLF := False;
  end;
  Assert(ResultPos >= 1);
  SetLength(Result, ResultPos - 1);
end;

function ExpandEol(const Value: string): string;
var
  i: Integer;
  ValueLength: Integer;
  MaxResultLength: Integer;
  ResultPos: Integer;
begin
  // 2003-02-22 (mr): speed optimization: skip conversion when Value contains no LF characters
  i := 1;
  while i <= System.Length(Value) do
  begin
    if Value[i] = #$000A then
      Break;
    Inc(i);
  end;
  if i > System.Length(Value) then
  begin
    // indeed, there was not LF so return original text
    Result := Value;
    Exit;
  end;

  // 2003-08-29 (eb): optimized
  // The result can never be more than twice the length of the input
  // Switch to a growable buffer (see EncodeText for example) if you need to deal with huge values
  ValueLength := Length(Value);
  MaxResultLength := 2 * ValueLength;
  SetLength(Result, MaxResultLength);
  ResultPos := 1;
  for i := 1 to ValueLength do
  begin
    Assert(ResultPos <= MaxResultLength);
    if Value[i] = #$000A then
    begin
      Result[ResultPos] := #$000D;
      Result[ResultPos + 1] := #$000A;
      Inc(ResultPos, 2);
    end
    else
    begin
      Result[ResultPos] := Value[i];
      Inc(ResultPos, 1);
    end;
  end;
  Assert(ResultPos >= 1);
  SetLength(Result, ResultPos - 1);
end;

function ShrinkWhitespace(const Value: string): string;
var
  Start, Stop: Integer;
begin
  Start := 1;
  Stop := Length(Value);

  // trim from start
  while (Start <= Stop) and CharIs_WhiteSpace(Value[Start]) do
    Inc(Start);

  // little optimization
  if Start > Stop then
  begin
    Result := '';
    Exit;
  end;

  // trim from end
  while CharIs_WhiteSpace(Value[Stop]) and (Stop > Start) do
    Dec(Stop);

  Result := Copy(Value, Start, Stop - Start + 1);
end;


{ EXMLException }

constructor EXMLException.CreateParseError(const DOMCode, XMLCode: Integer; const Args: array of const);
begin
  inherited CreateFmt(XMLErrorInfoList[XMLCode].Text, Args);
  FDOMCode := DOMCode;
  FXMLCode := XMLCode;
end;

{ OmniTXMLTextStream }

constructor OmniTXMLTextStream.Create(const Stream: TStream; const Mode: TStreamMode;
  const Encoding: TEncoding; const WriteBOM: Boolean);
begin
  FStreamMode := Mode;
  if FStreamMode = smRead then
  begin
    FReader := TOTextReader.Create(Stream, Encoding);
    fBOMFound := FReader.BOMFound;
  end
  else
  begin
    FWriter := TOTextWriter.Create(Stream, Encoding, WriteBOM);
  end;

  // set defaults
  FIndent := -1;

  // allocate initial output buffer
  FOutBufferSize := MAX_OUTPUTBUFFERSIZE;
  FOutBufferPos := -1;
  GetMem(FOutBuffer, FOutBufferSize * SizeOf(Char));
end;

destructor OmniTXMLTextStream.Destroy;
begin
  FreeMem(FOutBuffer, FOutBufferSize * SizeOf(Char));
  FReader.Free;
  FWriter.Free;
  inherited;
end;

procedure OmniTXMLTextStream.ClearOutputBuffer;
begin
  FOutBufferPos := -1;
end;

function OmniTXMLTextStream.GetOutputFormat: TOutputFormat;
begin
  Result := FOutputFormat;
end;

procedure OmniTXMLTextStream.SetOutputFormat(const Value: TOutputFormat);
begin
  FOutputFormat := Value;
end;

function OmniTXMLTextStream.GetBOMFound: Boolean;
begin
  Result := fBOMFound;
end;

function OmniTXMLTextStream.GetEncoding: TEncoding;
begin
  if FStreamMode = smRead then
    Result := FReader.Encoding
  else
    Result := FWriter.Encoding;
end;

procedure OmniTXMLTextStream.SetEncoding(const AEncoding: TEncoding);
begin
  if FStreamMode = smRead then
    FReader.Encoding := AEncoding
  else
    FWriter.Encoding := AEncoding
end;

function OmniTXMLTextStream.GetNextString(var ReadString: string; const Len: Integer): Boolean;
var
  i: Integer;
  ReadChar: Char;
begin
  SetLength(ReadString, Len);
  i := 0;
  while (i < Len) and ProcessChar(ReadChar) do
  begin
    ReadString[i+1] := ReadChar;
    Inc(i);
  end;
  Result := i = Len;
end;

function OmniTXMLTextStream.GetOutputBuffer: string;
begin
  SetString(Result, FOutBuffer, FOutBufferPos + 1);
  FPreviousOutBuffer := Result;
  ClearOutputBuffer;  // do not remove this call!
end;

function OmniTXMLTextStream.ReadChar(var ReadChar: Char): Boolean;
begin
  Result := FReader.ReadNextChar(ReadChar);
end;

function OmniTXMLTextStream.ProcessChar(var ch: Char): Boolean;
begin
  Result := ReadChar(ch);
end;

procedure OmniTXMLTextStream.UndoRead;
begin
  // next char will be from the undo buffer
  FReader.UndoRead;
end;

procedure OmniTXMLTextStream.WriteOutputChar(const OutChar: Char);
begin
  // FOutBufferPos points to PChar buffer - increment only by 1
  Inc(FOutBufferPos);
  // check for space in output buffer
  if FOutBufferPos = FOutBufferSize then
  begin
    // double the size of the output buffer
    FOutBufferSize := 2 * FOutBufferSize;
    ReallocMem(FOutBuffer, FOutBufferSize * SizeOf(Char));
  end;
  FOutBuffer[FOutBufferPos] := OutChar;
end;

procedure OmniTXMLTextStream.WriteString(const Value: string);
begin
  FWriter.WriteString(Value);
end;

procedure OmniTXMLTextStream.IncreaseIndent;
begin
  if FIndent = MaxInt then
    FIndent := 0;
  Inc(FIndent);
end;

procedure OmniTXMLTextStream.DecreaseIndent;
begin
  Dec(FIndent);
  if FIndent = 0 then
    FIndent := MaxInt;
end;

procedure OmniTXMLTextStream.WriteIndent(const ForceNextLine: Boolean);
begin
  if FOutputFormat = ofNone then
    Exit;

  // 2002-12-17 (mr): added ForceNextLine
  if (FIndent > 0) or ForceNextLine then
    FWriter.WriteString(#13#10);

  if (FOutputFormat = ofIndent) and (FIndent < MaxInt) and (FIndent > 0) then
    FWriter.WriteString(StringOfChar(' ', FIndent * OUTPUT_INDENT));
end;

function OmniTXMLTextStream.OutputBufferLen: Integer;
begin
  Result := FOutBufferPos + 1;
end;

function OmniTXMLTextStream.GetPreviousOutputBuffer: string;
begin
  SetString(Result, FOutBuffer, FOutBufferPos + 1)
end;

{ OmniTXMLParseError }

function OmniTXMLParseError.GetErrorCode: Integer;
begin
  Result := FErrorCode;
end;

function OmniTXMLParseError.GetFilePos: Integer;
begin
  Result := FFilePos;
end;

function OmniTXMLParseError.GetLine: Integer;
begin
  Result := FLine;
end;

function OmniTXMLParseError.GetLinePos: Integer;
begin
  Result := FLinePos;
end;

function OmniTXMLParseError.GetReason: string;
begin
  Result := FReason;
end;

function OmniTXMLParseError.GetSrcText: string;
begin
  Result := FSrcText;
end;

function OmniTXMLParseError.GetSrcTextPos: Integer;
begin
  Result := FSrcTextPos;
end;

function OmniTXMLParseError.GetURL: string;
begin
  Result := FURL;
end;

procedure OmniTXMLParseError.SetErrorCode(const ErrorCode: Integer);
begin
  FErrorCode := ErrorCode;
end;

procedure OmniTXMLParseError.SetFilePos(const FilePos: Integer);
begin
  FFilePos := FilePos;
end;

procedure OmniTXMLParseError.SetLine(const Line: Integer);
begin
  FLine := Line;
end;

procedure OmniTXMLParseError.SetLinePos(const LinePos: Integer);
begin
  FLinePos := LinePos;
end;

procedure OmniTXMLParseError.SetReason(const Reason: string);
begin
  FReason := Reason;
end;

procedure OmniTXMLParseError.SetSrcText(const SrcTextBefore, SrcTextAfter: string);
begin
  FSrcText := SrcTextBefore+SrcTextAfter;
  FSrcTextPos := Length(SrcTextBefore);
end;

procedure OmniTXMLParseError.SetURL(const URL: string);
begin
  FURL := URL;
end;

{ OmniTXMLCustomList }

constructor OmniTXMLCustomList.Create;
begin
  FList := TList<OmniIXMLNode>.Create;
end;

destructor OmniTXMLCustomList.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function OmniTXMLCustomList.GetItem(const Index: Integer): OmniIXMLNode;
begin
  Result := FList.Items[Index];
end;

function OmniTXMLCustomList.GetLength: Integer;
begin
  Result := FList.Count;
end;

function OmniTXMLCustomList.Add(const XMLNode: OmniIXMLNode): Integer;
begin
  Result := FList.Add(XMLNode);
end;

function OmniTXMLCustomList.Remove(const XMLNode: OmniIXMLNode): Integer;
begin
  Result := FList.Remove(XMLNode);
end;

procedure OmniTXMLCustomList.Put(Index: Integer; Item: OmniIXMLNode);
begin
  FList[Index] := Item;
end;

function OmniTXMLCustomList.IndexOf(const XMLNode: OmniIXMLNode): Integer;
begin
  Result := FList.IndexOf(XMLNode);
end;

procedure OmniTXMLCustomList.Insert(const Index: Integer; const XMLNode: OmniIXMLNode);
begin
  FList.Insert(Index, XMLNode);
end;

procedure OmniTXMLCustomList.Delete(const Index: Integer);
begin
  if Index < FList.Count then begin
    FList.Delete(Index);
  end;
end;

procedure OmniTXMLCustomList.Clear;
begin
  FList.Clear;
end;

{ OmniTXMLNodeList }

function OmniTXMLNodeList.NextNode: OmniIXMLNode;
begin
  Result := nil;
  if FItemNo < GetLength then
  begin
    Result := Item[FItemNo];
    Inc(FItemNo);
  end;
end;

procedure OmniTXMLNodeList.Reset;
begin
  FItemNo := 0;
end;

function OmniTXMLNodeList.AddNode(const Arg: OmniIXMLNode): OmniIXMLNode;
begin
  Result := Arg;
  Add(Arg);
end;

{ OmniTXMLNamedNodeMap }

function OmniTXMLNamedNodeMap.GetNamedItem(const Name: string): OmniIXMLNode;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to GetLength-1 do
    if Item[i].NodeName = Name then
    begin
      Result := Item[i];
      break;
    end;
end;

function OmniTXMLNamedNodeMap.GetNamedItemNS(const namespaceURI, localName: string): OmniIXMLNode;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to GetLength-1 do
    if (Item[i].LocalName = localName) and (Item[i].NamespaceURI = namespaceURI) then
    begin
      Result := Item[i];
      break;
    end;
end;


function OmniTXMLNamedNodeMap.RemoveNamedItem(const Name: string): OmniIXMLNode;
begin
  Result := GetNamedItem(Name);
  if Result <> nil then
    Remove(Result);
end;

function OmniTXMLNamedNodeMap.RemoveNamedItemNS(const namespaceURI, localName: string): OmniIXMLNode;
begin
  Result := GetNamedItemNS(namespaceURI, localName);
  if Result <> nil then
    Remove(Result);
end;

function OmniTXMLNamedNodeMap.SetNamedItem(const Arg: OmniIXMLNode): OmniIXMLNode;
var
  Index: Integer;
begin
  Result := GetNamedItem(Arg.NodeName);
  if Result = nil then
    // old node was not found
    Add(Arg)
  else
  begin
    // replace old node with new node
    Index := IndexOf(Result);
    Put(Index, Arg);
  end;
end;

function OmniTXMLNamedNodeMap.SetNamedItemNS(const Arg: OmniIXMLNode): OmniIXMLNode;
var
  Index: Integer;
begin
  Result := GetNamedItemNS(Arg.NamespaceURI, Arg.LocalName);
  if Result = nil then
    Add(Arg)
  else
  begin
    Index := IndexOf(Result);
    Put(Index, Arg);
  end;
end;

{ OmniTXMLNode }

constructor OmniTXMLNode.Create(const AOwnerDocument: OmniTXMLDocument);
begin
  inherited Create;
  FOwnerDocument := AOwnerDocument;
  FChildNodes := nil;
  FAttributes := nil;
  FNodeValueId := CInvalidDicId;
  TexListDic := FOwnerDocument.TexListDic;
  FNSPrefixScopeDict := nil;
end;

destructor OmniTXMLNode.Destroy;
begin
  TexListDic := nil;
  FOwnerDocument := nil;
  Pointer(FParentNode) := nil;  // (gp)
  Pointer(FOwnerElement) := nil;
  FNSPrefixScopeDict.Free;
  inherited;
end;

procedure OmniTXMLNode.ClearChildNodes;
begin
  if HasChildNodes then
    FChildNodes := nil;
end;

function OmniTXMLNode.HasAttributes: Boolean;
begin
  Result := FAttributes <> nil;
end;

function OmniTXMLNode.appendChild(const NewChild: OmniIXMLNode): OmniIXMLNode;
var
  Node: OmniIXMLNode;
  SPrefix: string;
  URIIDCh, URIIDPa: TDicId;
begin
  // NewChild should be created from the same document than the one that created this node
  if (Self.OwnerDocument <> nil) and (NewChild.OwnerDocument <> nil) and (NewChild.OwnerDocument <> Self.OwnerDocument) then
    raise EXMLException.CreateParseError(WRONG_DOCUMENT_ERR, MSG_E_WRONG_DOCUMENT, []);

                                  
  if (NodeType = ELEMENT_NODE) and (newChild.NodeType = ATTRIBUTE_NODE) then
    raise EXMLException.CreateParseError(HIERARCHY_REQUEST_ERR,
      MSG_E_INVALID_OPERATION, [NodeTypeList[newChild.NodeType]]);

  // if the NewChild is already in the tree, it is first removed
  if NewChild.ParentNode <> nil then
    NewChild.ParentNode.ChildNodes.Remove(NewChild);

  // Document NameSpaced
  if FOwnerDocument.FNSpace and (OmniTXMLNode(NewChild).FNSPrefixScopeDict <> nil) then
  begin
    Node := Self;
    SPrefix := NewChild.Prefix;
    if SPrefix = '' then
      SPrefix := SXMLNS;
    if OmniTXMLNode(NewChild).FNSPrefixScopeDict.TryGetValue(SPrefix, URIIDCh) then
      while (Node <> nil) do
      begin
        if (OmniTXMLNode(Node).FNSPrefixScopeDict <> nil) and OmniTXMLNode(Node).FNSPrefixScopeDict.TryGetValue(SPrefix, URIIDPa) then
          if (URIIDPa = URIIDCh) then
          begin // It already exists
            FreeAndNil(OmniTXMLNode(NewChild).FNSPrefixScopeDict);
            Break;
          end
          else
          begin // New URI
            if sametext(SPrefix, SXMLNS) then
              OmniTXMLElement(NewChild).SetAttribute(SXMLNS, TexListDic.Get(URIIDCh))
            else
              if URIIDCh <> 0 then // Empty?
                OmniTXMLElement(NewChild).SetAttribute(SXMLNS+NSDelim+SPrefix, TexListDic.Get(URIIDCh))
              else
                FreeAndNil(OmniTXMLNode(NewChild).FNSPrefixScopeDict);
            Break;
          end;

        Node := Node.ParentNode;
        if Node = nil then
          if sametext(SPrefix, SXMLNS) then
          begin
            if (URIIDCh <> 0) then
              OmniTXMLElement(NewChild).SetAttribute(SXMLNS, TexListDic.Get(URIIDCh));
          end
          else
            if URIIDCh = 0 then
              raise EXMLException.CreateParseError(NAMESPACE_ERR, XML_NAMESPACE_URI_EMPTY, [])
            else
              OmniTXMLElement(NewChild).SetAttribute(SXMLNS+NSDelim+SPrefix, TexListDic.Get(URIIDCh));
      end;
  end;


  Result := ChildNodes.AddNode(NewChild);
  NewChild.SetParentNode(Self);
end;

function OmniTXMLNode.GetParentNode: OmniIXMLNode;
begin
  Result := FParentNode;
end;

procedure OmniTXMLNode.SetParentNode(const Parent: OmniIXMLNode);
begin
  Pointer(FParentNode) := Pointer(Parent);  // (gp)
end;

function OmniTXMLNode.CloneNode(const Deep: Boolean): OmniIXMLNode;
var
  i: Integer;
begin
  case NodeType of
    ELEMENT_NODE: Result := FOwnerDocument.CreateElement(Self.NodeName);
    ATTRIBUTE_NODE: Result := FOwnerDocument.CreateAttribute(Self.NodeName);
    TEXT_NODE: Result := FOwnerDocument.CreateTextNode(Self.NodeValue);
    CDATA_SECTION_NODE: Result := FOwnerDocument.CreateCDATASection(Self.NodeValue);
    ENTITY_REFERENCE_NODE, ENTITY_NODE, DOCUMENT_TYPE_NODE: Assert(False, 'NYI - CloneNode');
    PROCESSING_INSTRUCTION_NODE: Result := FOwnerDocument.CreateProcessingInstruction(Self.NodeName, Self.NodeValue);
    COMMENT_NODE: Result := FOwnerDocument.CreateComment(Self.NodeValue);
    DOCUMENT_NODE: Result := CreateXMLDoc;
    DOCUMENT_FRAGMENT_NODE: Result := FOwnerDocument.CreateDocumentFragment;
    NOTATION_NODE: raise EXMLException.Create('Invalid operation: cannot clone Notation node');
  end;

  if NodeType in [ATTRIBUTE_NODE, CDATA_SECTION_NODE, COMMENT_NODE, PROCESSING_INSTRUCTION_NODE, TEXT_NODE] then
    Result.NodeValue := Self.NodeValue;

  // clone attributes
  if HasAttributes then
    for i := 0 to FAttributes.Length - 1 do
      if Pos(NSDelim, FAttributes.Item[i].NodeName) > 0 then
        OmniTXMLElement(Result).SetAttributeNodeNS(OmniIXMLAttr(FAttributes.Item[i].CloneNode(Deep)))
      else
        OmniTXMLElement(Result).SetAttributeNode(OmniIXMLAttr(FAttributes.Item[i].CloneNode(Deep)));

  if Deep and HasChildNodes then
  begin
    // clone child nodes
    for i := 0 to FChildNodes.Length - 1 do
      Result.ChildNodes.Add(FChildNodes.Item[i].CloneNode(Deep));
  end;
end;

function OmniTXMLNode.GetAttributes: OmniIXMLNamedNodeMap;
begin
  if FAttributes = nil then
    FAttributes := OmniTXMLNamedNodeMap.Create;
  Result := FAttributes;
end;

function OmniTXMLNode.GetChildNodes: OmniIXMLNodeList;
begin
  if FChildNodes = nil then
    FChildNodes := OmniTXMLNodeList.Create;
  Result := FChildNodes;
end;

function OmniTXMLNode.GetFirstChild: OmniIXMLNode;
begin
  if HasChildNodes then
    Result := FChildNodes.Item[0]
  else
    Result := nil;
end;

function OmniTXMLNode.GetLastChild: OmniIXMLNode;
begin
  if HasChildNodes then
    Result := FChildNodes.Item[FChildNodes.Length - 1]
  else
    Result := nil;
end;

function OmniTXMLNode.GetNodeType: TNodeType;
begin
  Result := FNodeType;
end;

function OmniTXMLNode.GetNodeValue: string;
begin
  if FNodeValueId <> CInvalidDicId then
    Result := TexListDic.Get(FNodeValueId)
  else
    Result := '';
end;

function OmniTXMLNode.GetNSURI: string;
var
  SPrefix: string;
  URIIndex: TDicId;
  Node: OmniTXMLNode;
begin
  Result := '';
  Node := nil;
  SPrefix := Prefix;
  if NodeType = ATTRIBUTE_NODE  then
  begin
    if SPrefix <> '' then
      Node := FOwnerElement as OmniTXMLNode;
  end
  else
  begin
    Node := Self;
    if SPrefix = '' then
      SPrefix := SXMLNS;
  end;

  while (Node <> nil) do
    if (Node.FNSPrefixScopeDict <> nil) and Node.FNSPrefixScopeDict.TryGetValue(SPrefix,URIIndex) then // Due to NS scope
    begin
      Result := Node.TexListDic.Get(URIIndex);
      break;
    end
    else
      Node := OmniTXMLNode(Node.GetParentNode);
end;

function OmniTXMLNode.GetPrefix: string;
var
  ColonPos: Integer;
begin
  ColonPos := Pos(NSDelim, NodeName);
  if ColonPos > 0 then
    Result := Copy(NodeName, 1, ColonPos - 1)
  else
    Result := '';
end;

function OmniTXMLNode.GetLocalName: string;
var
  ColonPos: Integer;
begin
  ColonPos := Pos(NSDelim, NodeName);
  if ColonPos > 0 then
    Result := Copy(NodeName, ColonPos + 1, Length(NodeName) - ColonPos)
  else
    Result := NodeName;
end;

procedure OmniTXMLNode.SetNodeValue(const Value: string);
begin
  // 2003-02-22 (mr): exception is now raised as default action
  raise EXMLException.CreateParseError(NO_MODIFICATION_ALLOWED_ERR,
    MSG_E_INVALID_OPERATION, [NodeTypeList[FNodeType]]);
end;

function OmniTXMLNode.GetOwnerDocument: OmniIXMLDocument;
begin
  Result := FOwnerDocument;
end;

function OmniTXMLNode.GetPreviousSibling: OmniIXMLNode;
  function FindPreviousNode(const Self: OmniIXMLNode): OmniIXMLNode;
  var
    Childs: OmniIXMLNodeList;
    Index: Integer;
  begin
    Childs := FParentNode.ChildNodes;
    Index := Childs.IndexOf(Self);
    if (Index >= 0) and ((Index - 1) >= 0) then
      Result := Childs.Item[Index - 1]
    else
      Result := nil;
  end;
begin
  if (FParentNode <> nil) and (FParentNode.HasChildNodes) then
    Result := FindPreviousNode(Self as OmniIXMLNode)
  else
    Result := nil;
end;

function OmniTXMLNode.GetNextSibling: OmniIXMLNode;
  function FindNextNode(const Self: OmniIXMLNode): OmniIXMLNode;
  var
    Childs: OmniIXMLNodeList;
    Index: Integer;
  begin
    Childs := FParentNode.ChildNodes;
    Index := Childs.IndexOf(Self);
    if (Index >= 0) and ((Index + 1) < Childs.Length) then
      Result := Childs.Item[Index + 1]
    else
      Result := nil;
  end;
begin
  if (FParentNode <> nil) and (FParentNode.HasChildNodes) then
    Result := FindNextNode(Self as OmniIXMLNode)
  else
    Result := nil;
end;

function OmniTXMLNode.HasChildNodes: Boolean;
begin
  Result := (FChildNodes <> nil) and (FChildNodes.Length > 0);
end;

function OmniTXMLNode.InsertBefore(const NewChild, RefChild: OmniIXMLNode): OmniIXMLNode;
var
  RefChildIndex: Integer;
  RecalculateRefChildIndex: Boolean;
begin
  // NewChild should be created from the same document than the one that created this node
  if (Self.OwnerDocument <> nil) and (NewChild.OwnerDocument <> nil) and (NewChild.OwnerDocument <> Self.OwnerDocument) then
    raise EXMLException.CreateParseError(WRONG_DOCUMENT_ERR, MSG_E_WRONG_DOCUMENT, []);

  if RefChild <> nil then
  begin
    RefChildIndex := FChildNodes.IndexOf(RefChild);

    // RefChild should be a child of this node
    if RefChildIndex = -1 then
      raise EXMLException.CreateParseError(NOT_FOUND_ERR, MSG_E_NOTEXT, ['RefChild is not a child of this node.']);
  end
  else
    RefChildIndex := -1;

  // if NewChild is RefChild, do nothing
  if (NewChild.ParentNode = (Self as OmniIXMLNode)) and (FChildNodes.IndexOf(NewChild) = RefChildIndex) then
    Exit;

  // if NewChild has same parent as RefChild, we should recalculate RefChildIndex
  RecalculateRefChildIndex := NewChild.ParentNode = (Self as OmniIXMLNode);

  // if the NewChild is already in the tree, it is first removed
  if NewChild.ParentNode <> nil then
    NewChild.ParentNode.ChildNodes.Remove(NewChild);

  if RefChild = nil then
    AppendChild(NewChild)
  else
  begin
    if RecalculateRefChildIndex then
      RefChildIndex := FChildNodes.IndexOf(RefChild);

    FChildNodes.Insert(RefChildIndex, NewChild);
    // note: AppendChild already changes parent, so this should be done only with Insert
    NewChild.SetParentNode(Self);
  end;

  Result := NewChild;
end;

function OmniTXMLNode.RemoveChild(const OldChild: OmniIXMLNode): OmniIXMLNode;
var
  Index: Integer;
begin
  if HasChildNodes then
    Index := FChildNodes.IndexOf(OldChild)
  else
    Index := -1;
    
  if Index > -1 then
  begin
    Result := FChildNodes.Item[Index];
    FChildNodes.Remove(OldChild);
    //if FChildNodes.Length = 0 then
      //FChildNodes := nil;
  end
  else
    raise EXMLException.CreateParseError(NOT_FOUND_ERR, MSG_E_NOTEXT, ['Child not found.']);
end;

function OmniTXMLNode.ReplaceChild(const NewChild, OldChild: OmniIXMLNode): OmniIXMLNode;
var
  Index: Integer;
begin
  if HasChildNodes then
    Index := FChildNodes.IndexOf(OldChild)
  else
    Index := -1;

  if Index > -1 then
  begin
    Result := OldChild;
    FChildNodes.Insert(Index, NewChild);
    FChildNodes.Remove(OldChild);
  end
  else
    raise EXMLException.CreateParseError(NOT_FOUND_ERR, MSG_E_NOTEXT, ['Child not found.']);
end;

procedure OmniTXMLNode.ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream);
begin
  // do nothing
end;

procedure OmniTXMLNode.InternalWriteToStream(const OutputStream: IUnicodeStream);
var
  i: Integer;
begin
  if HasChildNodes then
  begin
    // 2002-12-17 (mr): fixed indentation
    OutputStream.IncreaseIndent;
    for i := 0 to FChildNodes.Length - 1 do
      (FChildNodes.Item[i]).WriteToStream(OutputStream);
    // 2002-12-17 (mr): fixed indentation
    OutputStream.DecreaseIndent;
  end;
end;

procedure OmniTXMLNode.WriteToStream(const OutputStream: IUnicodeStream);
begin
  InternalWriteToStream(OutputStream);
end;

function OmniTXMLNode.GetXML: string;
var
  Stream: TMemoryStream;
  US: IUnicodeStream;
begin
  US := nil;
  Stream := TMemoryStream.Create;
  try
    US := OmniTXMLTextStream.Create(Stream, smWrite, TEncoding.Unicode, False);

    InternalWriteToStream(US);
    US := nil;//(op) MUST BE HERE -> FLUSH BUFFER
    SetLength(Result, Stream.Size div SizeOf(Char));
    if Stream.Size > 0 then
    begin
      Stream.Position := 0;
      Stream.ReadBuffer(PChar(Result)^, Stream.Size);
    end;
  finally
    Stream.Free;
  end;
end;

function OmniTXMLNode.GetText: string;
var
  i: Integer;
begin
  Result := '';

  if HasChildNodes then
  begin
    i := 0;
    while i < FChildNodes.Length do
    begin
      // 2002-12-20 (mr): GetText is now using recursion
      Result := Result + FChildNodes.Item[i].Text;
      Inc(i);
    end;
  end;
  if FOwnerDocument.PreserveWhiteSpace then
    Result := Result + Self.NodeValue
  else
    Result := Result + ShrinkWhitespace(Self.NodeValue);
end;

procedure OmniTXMLNode.SetText(const Value: string);
var
  TextNode: OmniTXMLText;
begin
  ClearChildNodes;

  // adding pure text - no parsing needed
  if Value <> '' then
  begin
    TextNode := OmniTXMLText.Create(FOwnerDocument, Value);
    AppendChild(TextNode);
  end;
end;

procedure OmniTXMLNode.SelectNodes(Pattern: string; var Result: OmniIXMLNodeList);
begin
  Result := XPathSelect(Self, Pattern);
end;

function OmniTXMLNode.SelectNodes(Pattern: string): OmniIXMLNodeList;
begin
  SelectNodes(Pattern, Result);
end;

procedure OmniTXMLNode.SelectSingleNode(Pattern: string; var Result: OmniIXMLNode);
var
  NodeList: OmniIXMLNodeList;
begin
  NodeList := XPathSelect(Self, Pattern);
  if NodeList.Length > 0 then
  begin
    while NodeList.Length > 2 do
      NodeList.Remove(NodeList.Item[NodeList.Length - 1]);
    Result := NodeList.Item[0];
  end
  else
    Result := nil;
end;

function OmniTXMLNode.SelectSingleNode(Pattern: string): OmniIXMLNode;
begin
  SelectSingleNode(Pattern, Result);
end;

                                                                            
(*
{ OmniTXMLDocumentType }

function OmniTXMLDocumentType.GetEntities: OmniIXMLNamedNodeMap;
begin
  Assert(False, 'NYI - getEntities');
end;

function OmniTXMLDocumentType.GetName: string;
begin
  Assert(False, 'NYI - getName');
end;

function OmniTXMLDocumentType.GetNotations: OmniIXMLNamedNodeMap;
begin
  Assert(False, 'NYI - getNotations');
end;
*)

{ OmniTXMLElement }

constructor OmniTXMLElement.CreateElement(const OwnerDocument: OmniTXMLDocument; const tagName: string);
begin
  inherited Create(OwnerDocument);
  SetTagName(tagName);
  FNodeType := ELEMENT_NODE;
end;

function OmniTXMLElement.GetAttribute(const Name: string): string;
var
  Attr: OmniIXMLAttr;
begin
  Attr := GetAttributeNode(Name);
  if Attr <> nil then
    Result := Attr.Value
  else
    Result := '';
end;

function OmniTXMLElement.GetAttributeNS(const namespaceURI, localName: string): string;
var
  Attr: OmniIXMLAttr;
begin
  Attr := GetAttributeNodeNS(namespaceURI, localName);
  if Attr <> nil then
    Result := Attr.Value
  else
    Result := '';
end;

function OmniTXMLElement.GetAttributeNode(const Name: string): OmniIXMLAttr;
var
  i: Integer;
begin
  Result := nil;
  if HasAttributes then
  begin
    i := 0;
    while i < Attributes.Length do
    begin
      if Attributes.Item[i].NodeName = Name then
      begin
        Result := Attributes.Item[i] as OmniIXMLAttr;
        Break;
      end;
      Inc(i);
    end;
  end;
end;

function OmniTXMLElement.GetAttributeNodeNS(const namespaceURI, localName: string): OmniIXMLAttr;
var
  i: Integer;
begin
  Result := nil;
  if HasAttributes then
  begin
    i := 0;
    while i < Attributes.Length do
    begin
      if (Attributes.Item[i].LocalName = LocalName) and (Attributes.Item[i].NamespaceURI = namespaceURI) then
      begin
        Result := Attributes.Item[i] as OmniIXMLAttr;
        Break;
      end;
      Inc(i);
    end;
  end;
end;

function OmniTXMLElement.GetElementsByTagName(const Name: string): OmniIXMLNodeList;
  procedure InternalGetElementsByTagName(const Node: OmniIXMLNode);
  var
    i: Integer;
    ChildNode: OmniIXMLNode;
  begin
    if Node.HasChildNodes then
      for i := 0 to Node.ChildNodes.Length - 1 do
      begin
        ChildNode := Node.ChildNodes.Item[i];
        if (ChildNode.NodeType = ELEMENT_NODE) and ((ChildNode as OmniIXMLElement).NodeName = Name) then
          Result.AddNode(ChildNode);
        InternalGetElementsByTagName(ChildNode);
      end;
  end;
begin
  Result := OmniTXMLNodeList.Create;
  InternalGetElementsByTagName(Self);
end;

function OmniTXMLElement.GetElementsByTagNameNS(const namespaceURI, localName: string): OmniIXMLNodeList;
  procedure InternalGetElementsByTagNameNS(const Node: OmniIXMLNode);
  var
    i: Integer;
    ChildNode: OmniIXMLNode;
  begin
    if Node.HasChildNodes then
      for i := 0 to Node.ChildNodes.Length - 1 do
      begin
       ChildNode := Node.ChildNodes.Item[i];
        if (ChildNode.NodeType = ELEMENT_NODE) and (ChildNode.LocalName = localName) and (ChildNode.NamespaceURI = namespaceURI)then
          Result.AddNode(ChildNode);
        InternalGetElementsByTagNameNS(ChildNode);
      end;
  end;
begin
  Result := OmniTXMLNodeList.Create;
  InternalGetElementsByTagNameNS(Self);
end;

function OmniTXMLElement.GetNodeName: string;
begin
  Result := GetTagName;
end;

function OmniTXMLElement.GetTagName: string;
begin
  Result := TexListDic.Get(FTagNameId);
end;

procedure OmniTXMLElement.SetTagName(const TagName: string);
begin
  FTagNameId := TexListDic.Add(TagName);
end;

procedure OmniTXMLElement.Normalize;
begin
  Assert(False, 'NYI - Normalize');
end;

procedure OmniTXMLElement.RemoveAttribute(const Name: string);
begin
  Assert(False, 'NYI - RemoveAttribute');
end;

function OmniTXMLElement.RemoveAttributeNode(const OldAttr: OmniIXMLAttr): OmniIXMLAttr;
begin
  Assert(False, 'NYI - RemoveAttributeNode');
end;

procedure OmniTXMLElement.InternalWriteToStream(const OutputStream: IUnicodeStream);
var
  i: Integer;
begin
  // 2002-12-17 (mr): fixed indentation
  OutputStream.WriteIndent;
  OutputStream.WriteString('<' + NodeName);

  if HasAttributes then
  begin
    for i := 0 to Attributes.Length - 1 do
      Attributes.Item[i].WriteToStream(OutputStream);
  end;

  if not HasChildNodes then
  begin
    if OutputStream.OutputFormat = ofIndent then
      OutputStream.WriteString(' ');
    OutputStream.WriteString('/>');
    Exit;
  end;

  OutputStream.WriteString('>');
  inherited;

  if HasChildNodes and (not ((ChildNodes.Length = 1) and (ChildNodes.Item[0].NodeType = TEXT_NODE))) then
    OutputStream.WriteIndent;

  OutputStream.WriteString('</' + NodeName + '>');
end;

function OmniTXMLElement.SetAttributeNode(const NewAttr: OmniIXMLAttr): OmniIXMLAttr;
begin
  Attributes.SetNamedItem(NewAttr);
end;

function OmniTXMLElement.SetAttributeNodeNS(const NewAttr: OmniIXMLAttr): OmniIXMLAttr;
var
  NewURIID: Integer;
  URIID: TDicId;
  NewPrefix, QualifiedName, Value: string;

  function SetAttributeVId: OmniIXMLAttr;
  var
    ID: TDicId;
  begin
    Result := Attributes.SetNamedItem(NewAttr) as OmniIXMLAttr;
    ID := OmniTXMLAttr(NewAttr).FNodeValueId;
    FNSPrefixScopeDict.Add(NewPrefix,ID);
  end;

  function Scoped(Node: OmniIXMLNode): Boolean;
  var
    URIID: TDicId;
  begin
    Result := False;
    while (Node <> nil) do
    begin
      if OmniTXMLNode(Node).FNSPrefixScopeDict <> nil then
        if OmniTXMLNode(Node).FNSPrefixScopeDict.TryGetValue(NewPrefix, URIID) and (URIID = TDicId(NewURIID)) then
        begin
          Result := True;
          Break;
        end;
      Node := Node.ParentNode;
    end;
  end;

begin
  Result := nil;
  NewPrefix := '';
  QualifiedName := NewAttr.Name;
  Value := NewAttr.Value;
  FOwnerDocument.FNSpace := True;
  if Pos(SXMLNS+NSDelim, QualifiedName) = 1 then
    NewPrefix := Copy(QualifiedName, Length(SXMLNS)+2, QualifiedName.Length);  //xmlns:

  if FNSPrefixScopeDict <> nil then
  begin
    if FNSPrefixScopeDict.TryGetValue(NewPrefix, URIID) then
    begin
      FNSPrefixScopeDict.Remove(NewPrefix);
      Result := SetAttributeVId;
    end
    else
    begin
      NewURIID := TexListDic.PositionOf(Value);
      if NewURIID >= 0 then
      begin //URI exists in the document
        if not FNSPrefixScopeDict.ContainsValue(NewURIID) and not Scoped(GetParentNode) then
          Result := SetAttributeVId; //URI does not exists in this scope
      end
      else //URI does not exist at all
        Result := SetAttributeVId;
    end;
  end
  else
  begin
    NewURIID := TexListDic.PositionOf(Value);
    if NewURIID >= 0 then
    begin
      if not Scoped(GetParentNode) then
      begin
        FNSPrefixScopeDict := TTexPosDic.Create;
        Result := SetAttributeVId;
      end;
    end
    else
    begin
      FNSPrefixScopeDict := TTexPosDic.Create;
      Result := SetAttributeVId;
    end;
  end;
end;

procedure OmniTXMLElement.SetAttribute(const Name, Value: string);
var
  Attr: OmniIXMLAttr;
begin
  if Name = '' then
    raise EXMLException.CreateParseError(NAMESPACE_ERR, NS_E_BADNAMECHAR, ['']);
  Attr := FOwnerDocument.InternalCreateAttribute(Name);
  Attr.Value := Value;
  Pointer(OmniTXMLNode(Attr).FOwnerElement) := pointer(Self as OmniIXMLNode);
  Attributes.SetNamedItem(Attr);
end;

procedure OmniTXMLElement.SetAttributeNS(const qualifiedName, Value: string);
var
  Attr: OmniIXMLAttr;
begin
  if qualifiedName = '' then
    raise EXMLException.CreateParseError(NAMESPACE_ERR, NS_E_BADNAMECHAR, ['']);
  if Pos(NSDelim, qualifiedName) = qualifiedName.Length then
    raise EXMLException.CreateParseError(NAMESPACE_ERR, NS_E_BADNAMECHAR, [NSDelim]);

  Attr := FOwnerDocument.CreateAttributeNS(Value, qualifiedName);
  Pointer(OmniTXMLNode(Attr).FOwnerElement) := Pointer(Self as OmniIXMLNode);
  SetAttributeNodeNS(Attr);
end;

procedure OmniTXMLElement.ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream);
type
  TParserState = (psName, psAttr, psEndTag);
var
  _nodeAttr: OmniTXMLAttr;
  ReadChar: Char;
  PState: TParserState;
  //NewNS: Boolean;
begin
  //NewNS := False;
  // [40] STag ::= '<' Name (S Attribute)* S? '>'
  PState := psName;
  // read next available character
  while InputStream.ProcessChar(ReadChar) do
  begin
    case PState of
      psName:
        if CharIs_WhiteSpace(ReadChar) then
        begin
          SetTagName(InputStream.GetOutputBuffer);
          PState := psAttr;  // switch to an attribute name
        end
        else
        begin
          case ReadChar of
            '/':
              begin
                SetTagName(InputStream.GetOutputBuffer);
                PState := psEndTag;
              end;
            '>':
              begin
                SetTagName(InputStream.GetOutputBuffer);
                // write to list of unclosed nodes
                FOwnerDocument.UnclosedElementList.Add(Self);
                // recursively read subnodes
                FOwnerDocument.ReadFromStream(Self, InputStream);
                Break;
              end;
//            NSDelim:// ':'
//              begin
//                //NewNS := True;
//                if CharIs_NameChar(ReadChar) then
//                  InputStream.WriteOutputChar(ReadChar)
//                else
//                 raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_BADNAMECHAR, []);
//              end;
          else
            // [4] NameChar
            if CharIs_NameChar(ReadChar) then
              InputStream.WriteOutputChar(ReadChar)
            else
              raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_BADNAMECHAR, []);
          end;
        end;
      psAttr:
        if not CharIs_WhiteSpace(ReadChar) then
        begin
          case ReadChar of
            '/': PState := psEndTag;
            '>':
              begin
                // write to list of unclosed nodes
                FOwnerDocument.UnclosedElementList.Add(Self);
                // recursively read subnodes
                FOwnerDocument.ReadFromStream(Self, InputStream);
                Break;
              end;
          else
            // [41] Attribute
            // [5] Name
            if CharIs_Letter(ReadChar) or (ReadChar = '_') then
            begin
              InputStream.ClearOutputBuffer;
              InputStream.WriteOutputChar(ReadChar);
              _nodeAttr := FOwnerDocument.InternalCreateAttribute('');
              Pointer(OmniTXMLNode(_nodeAttr).FOwnerElement) := Pointer(Self as OmniIXMLNode);
              Attributes.SetNamedItem(_nodeAttr);
              _nodeAttr.ReadFromStream(Self, InputStream);
            end
            else
              raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_BADSTARTNAMECHAR, []);
          end;
        end;
      psEndTag:
        // [44] EmptyElemTag
        begin
          if ReadChar = '>' then
            Break
          else if CharIs_WhiteSpace(ReadChar) then
            raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_UNEXPECTED_WHITESPACE, [])
          else
            raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_EXPECTINGTAGEND, []);
        end;
    end;
  end;

  if ReadChar <> '>' then
    raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_UNCLOSEDSTARTTAG, []);
end;

{ OmniTXMLProcessingInstruction }

constructor OmniTXMLProcessingInstruction.CreateProcessingInstruction(const OwnerDocument: OmniTXMLDocument; const Target, Data: string);
begin
  inherited Create(OwnerDocument);
  FNodeType := PROCESSING_INSTRUCTION_NODE;
  FTarget := Target;
  SetData(Data);
end;

function OmniTXMLProcessingInstruction.GetData: string;
begin
  Result := FData;
end;

function OmniTXMLProcessingInstruction.GetNodeName: string;
begin
  Result := FTarget;
end;

procedure OmniTXMLProcessingInstruction.SetData(Data: string);
begin
  FData := Data;
end;

function OmniTXMLProcessingInstruction.GetTarget: string;
begin
  Result := FTarget;
end;

procedure OmniTXMLProcessingInstruction.InternalWriteToStream(const OutputStream: IUnicodeStream);
begin
  // 2002-12-17 (mr): fixed indentation
  OutputStream.WriteIndent;
  OutputStream.WriteString('<?' + NodeName + ' ' + FData + '?>');
  OutputStream.WriteString(#13#10);
end;

procedure OmniTXMLProcessingInstruction.ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream);
type
  TParserState = (psTarget, psInTarget, psWaitForData, psData, psEndData);
var
  ReadChar: Char;
  PState: TParserState;
  Encoding: TEncoding;
  _xmlDoc: OmniIXMLDocument;
begin
  // [16] PI ::= '<?' PITarget (S (Char* - (Char* '?>' Char*)))? '?>'
  PState := psTarget;
  // read next available character
  while InputStream.ProcessChar(ReadChar) do
  begin
    case PState of
      psTarget:
        begin
          // [17] PITarget ::= Name - (('X' | 'x') ('M' | 'm') ('L' | 'l')) 
          if CharIs_Name(ReadChar, True) then
          begin
            InputStream.WriteOutputChar(ReadChar);
            PState := psInTarget;
          end
          else
            raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_BADSTARTNAMECHAR, []);
        end;
      psInTarget:
        begin
          // [17] PITarget ::= Name - (('X' | 'x') ('M' | 'm') ('L' | 'l'))
          if CharIs_WhiteSpace(ReadChar) then
          begin
            FTarget := InputStream.GetOutputBuffer;
            if SameText(FTarget, 'xml') and (not Supports(Parent as OmniIXMLNode, OmniIXMLDocument, _xmlDoc)) then
              raise EXMLException.CreateParseError(HIERARCHY_REQUEST_ERR, MSG_E_BADXMLDECL, []);
            PState := psWaitForData;
          end
          else if CharIs_NameChar(ReadChar) then
            InputStream.WriteOutputChar(ReadChar)
          else
            raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_BADNAMECHAR, []);
        end;
      psWaitForData:
        if not CharIs_WhiteSpace(ReadChar) then
        begin
          if ReadChar = '?' then
            PState := psEndData
          else
          begin
            InputStream.WriteOutputChar(ReadChar);
            PState := psData;
          end;
        end;
      psData:
        if ReadChar = '?' then
          PState := psEndData
        else if CharIs_Char(ReadChar) then
          InputStream.WriteOutputChar(ReadChar)
        else
          raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_BADNAMECHAR, []);
      psEndData:
        begin
          if ReadChar = '>' then
          begin
            SetData(InputStream.GetOutputBuffer);
            if not InputStream.BOMFound and FindEncoding(Self, Encoding) then//(op): DO NOT CHANGE ENCODING IF BOM WAS FOUND!!!
            begin
              if (InputStream.Encoding.CodePage <> Encoding.CodePage) then
              begin
                InputStream.Encoding := Encoding;
                FOwnerDocument.ClearChildNodes;
              end
              else
              if Assigned(Encoding) and not TEncoding.IsStandardEncoding(Encoding) then
              Encoding.Free;
            end;
            Exit;
          end
          else
          begin
            // it was a false alert - both characters are part of PI
            InputStream.WriteOutputChar('?');
            InputStream.WriteOutputChar(ReadChar);
            // read more
            PState := psData;
          end;
        end;
    end;
  end;
end;

{ OmniTXMLAttr }

constructor OmniTXMLAttr.CreateAttr(const OwnerDocument: OmniTXMLDocument; const Name: string);
begin
  inherited Create(OwnerDocument);
  SetName(Name);
  FNodeType := ATTRIBUTE_NODE;
  FSpecified := True;
end;

procedure OmniTXMLAttr.SetName(const Value: string);
begin
  FNameId := TexListDic.Add(Value);
end;

procedure OmniTXMLAttr.SetNodeValue(const Value: string);
begin
  FNodeValueId := TexListDic.Add(Value);
end;

function OmniTXMLAttr.GetName: string;
begin
  if FNameId <> CInvalidDicId then
    Result := TexListDic.Get(FNameId)
  else
    Result := '';
end;

function OmniTXMLAttr.GetNodeName: string;
begin
  Result := GetName;
end;

function OmniTXMLAttr.GetSpecified: Boolean;
begin
  Result := FSpecified;
end;

function OmniTXMLAttr.GetText: string;
begin
  // same as nodeValue except the leading and trailing white space is trimmed
  // 2002-12-20 (mr): added checking of PreserveWhiteSpace property
  if FOwnerDocument.PreserveWhiteSpace then
    Result := NodeValue
  else
    Result := ShrinkWhitespace(NodeValue);
end;

function OmniTXMLAttr.GetValue: string;
begin
  Result := NodeValue;
end;

procedure OmniTXMLAttr.SetValue(const Value: string);
begin
  NodeValue := Value;
end;

function OmniTXMLAttr.GetOwnerElement: OmniIXMLElement;
begin
  Result := FOwnerElement as OmniIXMLElement;
end;

procedure OmniTXMLAttr.InternalWriteToStream(const OutputStream: IUnicodeStream);
begin
  OutputStream.WriteString(' ' + NodeName + '="' + EncodeText(NodeValue) + '"');
end;

procedure OmniTXMLAttr.ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream);
type
  TParserState = (psName, psBeforeEqual, psValue, psInValue);
  TAttrValueDelimiter = (avdNone, avdSingle, avdDouble);
var
  ReadChar: Char;
  PState: TParserState;
  AttrValueDelimiter: TAttrValueDelimiter;
  SPrefix: string;
  NewNS, Prefixed: Boolean;
begin
  // [41] Attribute ::= Name Eq AttValue
  // [5] Name ::= (Letter | '_' | ':') (NameChar)*
  // [25] Eq ::= S? '=' S?
  // [10] AttValue ::= '"' ([^<&"] | Reference)* '"' | "'" ([^<&'] | Reference)* "'"

  PState := psName;
  AttrValueDelimiter := avdNone;
  NewNS := False;
  Prefixed := False;
  SPrefix := '';
  // read next available character
  while InputStream.ProcessChar(ReadChar) do
  begin
    case PState of
      psName:
        begin
        if CharIs_WhiteSpace(ReadChar) then
        begin
          SetName(InputStream.GetOutputBuffer);
          PState := psBeforeEqual;
        end
        else
          if ReadChar = '=' then
          begin
            SPrefix := InputStream.GetPreviousOutputBuffer;
            SetName(InputStream.GetOutputBuffer);
            PState := psValue;
            if NewNS then
            begin
              SPrefix := Copy(SPrefix, Length(SXMLNS)+2, SPrefix.Length);
              if SPrefix = '' then
                raise EXMLException.CreateParseError(NAMESPACE_ERR, NS_EMPTY_NOT_ALLOWED, []);
              if SPrefix = SXMLNS then
                raise EXMLException.CreateParseError(NAMESPACE_ERR, NS_E_BADNAMECHAR, [SXMLNS]);
            end
            else
              if sametext(SPrefix,SXMLNS) then // Default NS xmlns
              begin
                NewNS := True;
                FOwnerDocument.FNSpace := True;
              end;
          end
          else
          begin
            // [4] NameChar
            if CharIs_NameChar(ReadChar) then
            begin
              if ReadChar = NSDelim then // ':'
              begin
                if Prefixed then
                  raise EXMLException.CreateParseError(NAMESPACE_ERR, NS_E_BADNAMECHAR, [NSDelim])
                else
                  Prefixed := True;
                if sametext(InputStream.GetPreviousOutputBuffer,SXMLNS) then
                begin
                  NewNS := True;
                  FOwnerDocument.FNSpace := True;
                end;
                //else Attrib prefixed ???
              end;
              InputStream.WriteOutputChar(ReadChar);
            end
            else
              raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_BADNAMECHAR, []);
          end;
        end;
      psBeforeEqual:
        if not CharIs_WhiteSpace(ReadChar) then
          if ReadChar = '=' then
            PState := psValue
          else
            raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_MISSINGEQUALS, []);
      psValue:
        if not CharIs_WhiteSpace(ReadChar) then
        begin
          case ReadChar of
            '''', '"':  // [10] AttValue
              begin
                PState := psInValue;
                if ReadChar = '''' then
                  AttrValueDelimiter := avdSingle
                else
                  AttrValueDelimiter := avdDouble;
              end;
          else
            raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_MISSINGQUOTE, []);
          end;
        end;
      psInValue:
        // [10] AttValue
        case ReadChar of
          '''': if AttrValueDelimiter = avdSingle then
            begin
              NodeValue := InputStream.GetOutputBuffer;
              Exit;
            end
            else
              InputStream.WriteOutputChar(ReadChar);
          '"': if AttrValueDelimiter = avdDouble then
            begin
              NodeValue := InputStream.GetOutputBuffer;
              if NewNS then // if NS then NodeValue = URI
              begin
                if (SPrefix = SXML) and (NodeValue <> SXMLPrefixNamespaceURI) then
                  raise EXMLException.CreateParseError(NAMESPACE_ERR,NS_NS_ERROR,[]);
                //if (Parent.FNSPrefixScopeDict <> nil) then   // Good for oasis NS tests, bad for SOAP Unit tests.
                //  if Parent.FNSPrefixScopeDict.ContainsValue(FNodeValueId) and not sametext(SPrefix,SXMLNS) then
                //    raise EXMLException.CreateParseError(NAMESPACE_ERR, MSG_E_DUPLICATEATTRIBUTE, []);
                if (NodeValue = '') and not sametext(SPrefix,SXMLNS) then
                  raise EXMLException.CreateParseError(NAMESPACE_ERR, XML_NAMESPACE_URI_EMPTY, [])
                else
                begin
                  if (Parent.FNSPrefixScopeDict = nil) then
                  begin
                     Parent.FNSPrefixScopeDict := TTexPosDic.Create;
                  end;
                  Parent.FNSPrefixScopeDict.Add(SPrefix, FNodeValueId);
                end;
              end;
              Exit;
            end
            else
              InputStream.WriteOutputChar(ReadChar);
          '<': raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_BADCHARINSTRING, []);
          '&': InputStream.WriteOutputChar(Reference2Char(InputStream));
        else
          InputStream.WriteOutputChar(ReadChar);
        end;
    end;
  end;
end;

{ OmniTXMLCharacterData }

constructor OmniTXMLCharacterData.Create(const OwnerDocument: OmniTXMLDocument; const Data: string);
begin
  inherited Create(OwnerDocument);
  NodeValue := Data;
end;

procedure OmniTXMLCharacterData.SetNodeValue(const Value: string);
begin
  // 2003-02-22 (mr): apply EOL handling when setting NodeValue
  FNodeValue := ShrinkEol(Value);
end;

function OmniTXMLCharacterData.GetNodeValue: string;
begin
  Result := FNodeValue;
end;

procedure OmniTXMLCharacterData.AppendData(const Arg: string);
begin
  Assert(False, 'NYI - AppendData');
end;

procedure OmniTXMLCharacterData.DeleteData(const Offset, Count: Integer);
begin
  Assert(False, 'NYI - DeleteData');
end;

function OmniTXMLCharacterData.GetData: string;
begin
  Result := NodeValue;
end;

function OmniTXMLCharacterData.GetLength: Integer;
begin
  Result := System.Length(NodeValue);
end;

procedure OmniTXMLCharacterData.InsertData(const Offset: Integer; const Arg: string);
begin
  Assert(False, 'NYI - InsertData');
end;

procedure OmniTXMLCharacterData.ReplaceData(const Offset, Count: Integer; const Arg: string);
begin
  Assert(False, 'NYI - ReplaceData');
end;

procedure OmniTXMLCharacterData.SetData(const Value: string);
begin
  NodeValue := Value;
end;

function OmniTXMLCharacterData.substringData(const Offset, Count: Integer): string;
begin
  Assert(False, 'NYI - SubstringData');
end;

procedure OmniTXMLCharacterData.InternalWriteToStream(const OutputStream: IUnicodeStream);
begin
  // 2003-01-13 (mr): call inherited to include any child nodes
  inherited;
  OutputStream.WriteString(EncodeText(ExpandEol(NodeValue)));
end;

procedure OmniTXMLCharacterData.ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream);
begin
  // do nothing
end;

{ OmniTXMLText }

constructor OmniTXMLText.Create(const OwnerDocument: OmniTXMLDocument; const Data: string);
begin
  inherited Create(OwnerDocument, Data);
  FNodeType := TEXT_NODE;
end;

function OmniTXMLText.GetNodeName: string;
begin
  Result := '#text';
end;

procedure OmniTXMLText.ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream);
type
  TParserState = (psText);
var
  ReadChar: Char;
  PState: TParserState;
  EndText: Boolean;
begin
  // [43] content ::= CharData? ((element | Reference | CDSect | PI | Comment) CharData?)* /* */
  // [14] CharData ::= [^<&]* - ([^<&]* ']]>' [^<&]*)
  PState := psText;
  EndText := False;
  // read next available character
  while InputStream.ProcessChar(ReadChar) do
  begin
    case PState of
      psText:
        case ReadChar of
          '<':
            begin
              EndText := True;
              InputStream.UndoRead;
              // 2002-12-20 (mr): speed optimization
              // add #text node only when some text exists
              if InputStream.OutputBufferLen > 0 then
              begin
                if not FOwnerDocument.PreserveWhiteSpace then
                  NodeValue := ShrinkWhitespace(NodeValue + InputStream.GetOutputBuffer)
                else
                  NodeValue := NodeValue + InputStream.GetOutputBuffer;
                if NodeValue = '' then
                  Parent.RemoveChild(Self);
              end
              else
                Parent.RemoveChild(Self);
              Break;
            end;
          '&': InputStream.WriteOutputChar(Reference2Char(InputStream));
        else
          InputStream.WriteOutputChar(ReadChar);
        end;
    end;
  end;
  if not EndText then
    Parent.RemoveChild(Self);
end;

function OmniTXMLText.SplitText(const Offset: Integer): OmniIXMLText;
begin
  Assert(False, 'NYI - SplitText');
end;

{ OmniTXMLCDATASection }

constructor OmniTXMLCDATASection.Create(const OwnerDocument: OmniTXMLDocument; const Data: string);
begin
  CheckValue(Data);
  inherited Create(OwnerDocument, Data);
  FNodeType := CDATA_SECTION_NODE;
end;

function OmniTXMLCDATASection.GetNodeName: string;
begin
  Result := '#cdata-section';
end;

procedure OmniTXMLCDATASection.CheckValue(const Value: string);
begin
  if Pos(string(']]>'), Value) > 0 then
    raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_INVALID_CDATACLOSINGTAG, []);
end;

procedure OmniTXMLCDATASection.SetNodeValue(const Value: string);
begin
  CheckValue(Value);
  // 2003-02-22 (mr): there is no EOL handling for CDATA element
  FNodeValue := Value;
end;

procedure OmniTXMLCDATASection.InternalWriteToStream(const OutputStream: IUnicodeStream);
begin
  // 2002-12-17 (mr): fixed indentation
  OutputStream.WriteIndent(True);
  OutputStream.WriteString('<![CDATA[' + NodeValue + ']]>');
end;

procedure OmniTXMLCDATASection.ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream);
type
  TParserState = (psData, psInEnd, psEnd);
var
  ReadChar: Char;
  PState: TParserState;
begin
  PState := psData;
  // read next available character
  while InputStream.ProcessChar(ReadChar) do
  begin
    case PState of
      psData:
        if ReadChar = ']' then
          PState := psInEnd
        else
          InputStream.WriteOutputChar(ReadChar);
      psInEnd:
        if ReadChar = ']' then
          PState := psEnd
        else
        begin
          InputStream.WriteOutputChar(']');  // 2004-04-07 (mr): fixed bug
          InputStream.WriteOutputChar(ReadChar);
          PState := psData;
        end;
      psEnd:
        if ReadChar = '>' then
        begin
          NodeValue := InputStream.GetOutputBuffer;
          Exit;
        end
        else
        begin
          InputStream.WriteOutputChar(ReadChar);
          if ReadChar = ']' then
            PState := psEnd
          else
            PState := psData;
        end;
    end;
  end;
end;

procedure OmniTXMLCDATASection.SetData(const Value: string);
begin
  CheckValue(Value);
  inherited;
end;

{ OmniTXMLComment }

constructor OmniTXMLComment.Create(const OwnerDocument: OmniTXMLDocument; const Data: string);
begin
  inherited Create(OwnerDocument, Data);
  FNodeType := COMMENT_NODE;
end;

function OmniTXMLComment.GetNodeName: string;
begin
  Result := '#comment';
end;

procedure OmniTXMLComment.InternalWriteToStream(const OutputStream: IUnicodeStream);
begin
  // 2002-12-17 (mr): fixed indentation
  OutputStream.WriteIndent(True);
  OutputStream.WriteString('<!--' + ExpandEol(NodeValue) + '-->');
end;

procedure OmniTXMLComment.ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream);
type
  TParserState = (psData, psInEnd, psEnd);
var
  ReadChar: Char;
  PState: TParserState;
begin
  PState := psData;
  // read next available character
  while InputStream.ProcessChar(ReadChar) do
  begin
    case PState of
      psData:
        if ReadChar = '-' then
          PState := psInEnd
        else
          InputStream.WriteOutputChar(ReadChar);
      psInEnd:
        if ReadChar = '-' then
          PState := psEnd
        else
        begin
          InputStream.WriteOutputChar('-');  // 2004-04-07 (mr): fixed bug
          InputStream.WriteOutputChar(ReadChar);
          PState := psData;
        end;
      psEnd:
        if ReadChar = '>' then
        begin
          NodeValue := InputStream.GetOutputBuffer;
          Exit;
        end;
        else
        begin
          InputStream.WriteOutputChar(ReadChar);
          PState := psData;
        end;
    end;
  end;
end;

{ OmniTXMLDocumentType }

constructor OmniTXMLDocumentType.Create(const OwnerDocument: OmniTXMLDocument;
  const Data: string);
begin
  inherited Create(OwnerDocument, Data);
  FNodeType := DOCUMENT_TYPE_NODE;
end;

function OmniTXMLDocumentType.GetNodeName: string;
begin
  Result := '#doctype';
end;

procedure OmniTXMLDocumentType.InternalWriteToStream(
  const OutputStream: IUnicodeStream);
begin
  OutputStream.WriteIndent;
  OutputStream.WriteString('<!DOCTYPE ' + NodeValue + '>');
end;

procedure OmniTXMLDocumentType.ReadFromStream(const Parent: OmniTXMLNode;
  const InputStream: IUnicodeStream);
type
  TParserState = (psData, psInString);
var
  BracketDepth: Integer;
  EndOfString: Char;
  PState: TParserState;
  ReadChar: Char;
  SkipInitialSpace: Boolean;
begin
  BracketDepth := 0;
  EndOfString := #0; // to keep Delphi happy
  SkipInitialSpace := True;
  PState := psData;
  // read next available character
  while InputStream.ProcessChar(ReadChar) do
  begin
    case PState of
      psData:
        begin
          if SkipInitialSpace then
          begin
            if CharIs_WhiteSpace(ReadChar) then
              continue
            else
              SkipInitialSpace := False;
          end;
          if (ReadChar = '>') and (BracketDepth <= 0) then
          begin
            NodeValue := InputStream.GetOutputBuffer;
            Exit;
          end
          else
          begin
            InputStream.WriteOutputChar(ReadChar);
            if ReadChar = '[' then
              Inc(BracketDepth)
            else if ReadChar = ']' then
              Dec(BracketDepth)
            else if (ReadChar = '"') or (ReadChar = '''') then
            begin
              PState := psInString;
              EndOfString := ReadChar;
            end;
          end;
        end; //psData
      psInString:
        begin
          InputStream.WriteOutputChar(ReadChar);
          if ReadChar = EndOfString then
            PState := psData;
        end; //psInString
    end; //case
  end;
end;

{ OmniTXMLDocumentFragment }

constructor OmniTXMLDocumentFragment.Create(const OwnerDocument: OmniTXMLDocument);
begin
  inherited Create(OwnerDocument);
  FNodeType := DOCUMENT_FRAGMENT_NODE;
end;

function OmniTXMLDocumentFragment.GetNodeName: string;
begin
  Result := '#document-fragment';
end;

procedure OmniTXMLDocumentFragment.ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream);
begin
                                              
  FOwnerDocument.ReadFromStream(Self, InputStream);
end;

{ OmniTXMLDocument }

constructor OmniTXMLDocument.Create;
begin
  inherited Create(Self);

  TexListDic := TTexListDic.Create;
  TexListDic.Add(''); // first element, the empty element (just for xmlns=)
  FNSpace := False;
  StartTag := False;

  FNodeType := DOCUMENT_NODE;
  FParseError := OmniTXMLParseError.Create;
  FIParseError := FParseError as OmniIXMLParseError;

  // unlike MS XML parser, we want all characters preserved
  FPreserveWhiteSpace := True;

  // define XML child classes
  FXMLAttrClass := OmniTXMLAttr;
  FXMLCDATASectionClass := OmniTXMLCDATASection;
  FXMLCommentClass := OmniTXMLComment;
  FXMLDocTypeClass := OmniTXMLDocumentType;
  FXMLElementClass := OmniTXMLElement;
  FXMLProcessingInstructionClass := OmniTXMLProcessingInstruction;
  FXMLTextClass := OmniTXMLText;

  UnclosedElementList := TInterfaceList.Create;
end;

destructor OmniTXMLDocument.Destroy;
begin
  UnclosedElementList.Free;
  FIParseError := nil;
  TexListDic.Free;
  inherited;
end;

function OmniTXMLDocument.GetDocumentElement: OmniIXMLElement;
var
  i: Integer;
begin
  Result := nil;
  if HasChildNodes then
  begin
    i := 0;
    while (Result = nil) and (i < ChildNodes.Length) do
    begin
      if not Supports(ChildNodes.Item[i], OmniIXMLElement, Result) then
        Inc(i);
    end;
  end;
end;

procedure OmniTXMLDocument.SetDocumentElement(const Value: OmniIXMLElement);
var
  i: Integer;
begin
  if HasChildNodes then
  begin
    i := 0;
    while i < ChildNodes.Length do
    begin
      if ChildNodes.Item[i].NodeType = ELEMENT_NODE then
      begin
        // insert new element
        ChildNodes.Insert(i, Value);
        // delete old
        ChildNodes.Delete(i + 1);
        Exit;
      end;
      Inc(i);
    end;
  end;

  // old document element was not found, so add new
  AppendChild(Value);
end;

function OmniTXMLDocument.GetPreserveWhiteSpace: Boolean;
begin
  Result := FPreserveWhiteSpace;
end;

procedure OmniTXMLDocument.SetPreserveWhiteSpace(const Value: Boolean);
begin
  FPreserveWhiteSpace := Value;
end;

function OmniTXMLDocument.GetParseError: OmniIXMLParseError;
begin
  Result := FParseError as OmniIXMLParseError;
end;

function OmniTXMLDocument.GetDocType: OmniIXMLDocumentType;
begin
  Result := FDocType;
end;

                                                                            
(*
procedure OmniTXMLDocument.SetDocType(const Value: OmniIXMLDocumentType);
begin
  FDocType := Value;
end;
*)

function OmniTXMLDocument.InternalCreateAttribute(const Name: string): OmniTXMLAttr;
begin
  Result := FXMLAttrClass.CreateAttr(Self, Name);
end;

function OmniTXMLDocument.CreateAttribute(const Name: string): OmniIXMLAttr;
begin
  Result := InternalCreateAttribute(Name);
end;

function OmniTXMLDocument.CreateAttributeNS(const namespaceURI, qualifiedName: string): OmniIXMLAttr;
begin
  Result := InternalCreateAttribute(qualifiedName);
  Result.Value := namespaceURI;
end;

function OmniTXMLDocument.InternalCreateCDATASection(const Data: string): OmniTXMLCDATASection;
begin
  // 2003-01-13 (mr): calling CreateCDATASection instead CreateCharacterData
  Result := FXMLCDATASectionClass.Create(Self, Data);
end;

function OmniTXMLDocument.CreateCDATASection(const Data: string): OmniIXMLCDATASection;
begin
  Result := InternalCreateCDATASection(Data);
end;

function OmniTXMLDocument.InternalCreateComment(const Data: string): OmniTXMLComment;
begin
  Result := FXMLCommentClass.Create(Self, Data);
end;

function OmniTXMLDocument.CreateComment(const Data: string): OmniIXMLComment;
begin
  Result := InternalCreateComment(Data);
end;

function OmniTXMLDocument.InternalCreateDocType(const Data: string): OmniTXMLDocumentType;
begin
  Result := FXMLDocTypeClass.Create(Self, Data);
end;

function OmniTXMLDocument.CreateDocType(const Data: string): OmniIXMLDocumentType;
begin
  FDocType := InternalCreateDocType(Data);
  Result := FDocType;
end;

function OmniTXMLDocument.InternalCreateDocumentFragment: OmniTXMLDocumentFragment;
begin
  Result := OmniTXMLDocumentFragment.Create(Self);
end;

function OmniTXMLDocument.CreateDocumentFragment: OmniIXMLDocumentFragment;
begin
  Result := InternalCreateDocumentFragment;
end;

function OmniTXMLDocument.InternalCreateElement(const TagName: string): OmniTXMLElement;
begin
  Result := FXMLElementClass.CreateElement(Self, TagName);
end;

function OmniTXMLDocument.CreateElement(const TagName: string): OmniIXMLElement;
begin
  Result := InternalCreateElement(TagName);
  if FNSpace then
  begin
    OmniTXMLNode(Result).FNSPrefixScopeDict := TTexPosDic.Create;
    if Pos(NSDelim, TagName) = 0 then
      OmniTXMLNode(Result).FNSPrefixScopeDict.Add(SXMLNS,0) //default xmlns scope(empty=0)
    else
      OmniTXMLNode(Result).FNSPrefixScopeDict.Add(Copy(TagName, 1, Pos(NSDelim, TagName) - 1),0);
  end;
end;

function OmniTXMLDocument.CreateElementNS(const namespaceURI, qualifiedName: string): OmniIXMLElement;
var
  ColonPos: Integer;
  NewPrefix: string;
  URIID: TDicId;
begin
  FNSpace := True;
  Result := InternalCreateElement(qualifiedName);
  URIID := TexListDic.Add(nameSpaceURI);
  OmniTXMLNode(Result).FNSPrefixScopeDict := TTexPosDic.Create;
  ColonPos := Pos(NSDelim, qualifiedName);
  if ColonPos > 0 then // Prefixed?
  begin
    NewPrefix:= Copy(qualifiedName, 1, ColonPos - 1);
    OmniTXMLNode(Result).FNSPrefixScopeDict.Add(NewPrefix,URIID);
  end
  else // Default xmlns
    OmniTXMLNode(Result).FNSPrefixScopeDict.Add(SXMLNS,URIID);
end;

function OmniTXMLDocument.InternalCreateEntityReference(const Name: string): OmniTXMLEntityReference;
begin
  Assert(False, 'NYI - CreateEntityReference');
  Result := nil;
end;

function OmniTXMLDocument.CreateEntityReference(const Name: string): OmniIXMLEntityReference;
begin
  Result := InternalCreateEntityReference(Name);
end;

function OmniTXMLDocument.InternalCreateProcessingInstruction(const Target, Data: string): OmniTXMLProcessingInstruction;
begin
  Result := FXMLProcessingInstructionClass.CreateProcessingInstruction(Self, Target, Data);
end;

function OmniTXMLDocument.CreateProcessingInstruction(const Target, Data: string): OmniIXMLProcessingInstruction;
begin
  Result := InternalCreateProcessingInstruction(Target, Data);
end;

function OmniTXMLDocument.InternalCreateTextNode(const Data: string): OmniTXMLText;
begin
  Result := FXMLTextClass.Create(Self, Data);
end;

function OmniTXMLDocument.CreateTextNode(const Data: string): OmniIXMLText;
begin
  Result := InternalCreateTextNode(Data);
  FOwnerDocument.UnclosedElementList.Add(Result);
end;

function OmniTXMLDocument.GetText: string;
var
  TempDocElement: OmniIXMLElement;
begin
  TempDocElement := DocumentElement;
  if TempDocElement <> nil then
    Result := TempDocElement.Text
  else
    Result := '';
end;

function OmniTXMLDocument.GetOwnerDocument: OmniIXMLDocument;
begin
  // 2003-01-13 (mr): overriden for DOM compatibility
  Result := nil;
end;

function OmniTXMLDocument.GetElementsByTagName(const TagName: string): OmniIXMLNodeList;
var
  TempDocElement: OmniIXMLElement;
begin
  TempDocElement := DocumentElement;
  if TempDocElement = nil then
    Result := OmniTXMLNodeList.Create
  else
    Result := TempDocElement.GetElementsByTagName(TagName);
end;

function OmniTXMLDocument.GetElementsByTagNameNS(const namespaceURI, localName: string): OmniIXMLNodeList;
var
  TempDocElement: OmniIXMLElement;
begin
  TempDocElement := DocumentElement;
  if TempDocElement = nil then
    Result := OmniTXMLNodeList.Create
  else
    Result := TempDocElement.GetElementsByTagNameNS(namespaceURI, localName);
end;

function OmniTXMLDocument.GetNodeName: string;
begin
  Result := '#document';
end;

function OmniTXMLDocument.LoadXML(const XML: string): Boolean;
var
  Stream: TMemoryStream;
  BOM: TBytes;
begin
  Stream := TMemoryStream.Create;
  try
    BOM := TEncoding.Unicode.GetPreamble;
    Stream.Write(BOM[TEncodingBuffer_FirstElement], Length(BOM));
    Stream.Write(PChar(XML)^, Length(XML) * SizeOf(Char));
    Stream.Position := 0;
    Result := LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

function OmniTXMLDocument.Load(const FileName: string): Boolean;
var
  MS: TMemoryStream;
begin
  FURL := FileName;
  MS := TMemoryStream.Create;
  try
    MS.LoadFromFile(FileName);
    Result := LoadFromStream(MS);
  finally
    MS.Free;
  end;
end;

function OmniTXMLDocument.LoadFromStream(const Stream: TStream): Boolean;
var
  XTS: OmniTXMLTextStream;
  xPreviousText, xNextText: string;

  function GetUnclosedTags: string;
  begin
    Result := '';
    while UnclosedElementList.Count > 0 do
    begin
      Result := Result + (UnclosedElementList[0] as OmniIXMLElement).NodeName;
      UnclosedElementList.Delete(0);
      if UnclosedElementList.Count > 0 then
        Result := Result + ', ';
    end;
  end;
begin
  Result := True;
  ClearChildNodes;

  Stream.Position := 0;
  XTS := OmniTXMLTextStream.Create(Stream, smRead, TEncoding.UTF8, False);
  try
    try
      UnclosedElementList.Clear;

      ReadFromStream(Self, XTS);

      if UnclosedElementList.Count > 0 then
        raise EXMLException.CreateParseError(HIERARCHY_REQUEST_ERR, MSG_E_UNCLOSEDTAG, [GetUnclosedTags]);
    except
      on E: Exception do
      begin
        if E is EXMLException then
        begin
          FParseError.SetErrorCode(EXMLException(E).XMLCode);
          FParseError.SetFilePos(XTS.FReader.FilePosition);
          FParseError.SetLine(XTS.FReader.Line);
          FParseError.SetLinePos(XTS.FReader.LinePosition);
          FParseError.SetReason(E.Message);
          xPreviousText := XTS.FReader.ReadPreviousString(30, True);
          xNextText := XTS.FReader.ReadString(10, True);
          FParseError.SetSrcText(xPreviousText, xNextText);//do not write ReadPreviousStringInLine() and ReadString() directly here because due to some Delphi optimizations, ReadString would be called first
          FParseError.SetURL(Self.FURL);

          ClearChildNodes;
          Result := False;
        end
        else
          raise;
      end;
    end;
  finally
    FreeAndNil(XTS);
    FURL := '';
  end;
end;

procedure OmniTXMLDocument.InternalWriteToStream(const OutputStream: IUnicodeStream);
var
  i: Integer;
begin
  if HasChildNodes then
  begin
    // 2002-12-17 (mr): fixed indentation
    OutputStream.IncreaseIndent;
    for i := 0 to ChildNodes.Length - 1 do
    begin
      (ChildNodes.Item[i]).WriteToStream(OutputStream);
      if i < (ChildNodes.Length - 1) then
        OutputStream.WriteIndent(True);
    end;
    // 2002-12-17 (mr): fixed indentation
    OutputStream.DecreaseIndent;
    OutputStream.WriteString(#13#10);
  end;
end;

procedure OmniTXMLDocument.SaveToStream(const OutputStream: TStream; const OutputFormat: TOutputFormat);
var
  US: OmniTXMLTextStream;

  function InternalFindEncoding: TEncoding;
  var
    i: Integer;
    TempPI, PI: OmniIXMLProcessingInstruction;
    Encoding: TEncoding;
  begin
    Result := TEncoding.UTF8;
    if HasChildNodes then
    begin
      // find last processing instruction
      for i := 0 to ChildNodes.Length - 1 do
      begin
        if Supports(ChildNodes.Item[i], OmniIXMLProcessingInstruction, TempPI) then
          PI := TempPI;
      end;
    end;
    if (PI <> nil) and FindEncoding(PI, Encoding) then
      Result := Encoding;
  end;
begin
  US := OmniTXMLTextStream.Create(OutputStream, smWrite, InternalFindEncoding, True);
  try
    US.OutputFormat := OutputFormat;
    InternalWriteToStream(US);
  finally
    US.Free;
  end;
end;

procedure OmniTXMLDocument.Save(const FileName: string; const OutputFormat: TOutputFormat = ofNone);
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(FileStream, OutputFormat);
  finally
    FileStream.Free;
  end;
end;

procedure OmniTXMLDocument.ReadFromStream(const Parent: OmniTXMLNode; const InputStream: IUnicodeStream);
type
  TParserState = (psTag, psTagName, psEndTagName, psCommentOrCDATAOrDoctype);
var
  _nodeCDATA: OmniTXMLCDATASection;
  _nodeComment: OmniTXMLComment;
  _nodeDocType: OmniTXMLDocumentType;
  _nodeElement: OmniTXMLElement;
  _nodePI: OmniTXMLProcessingInstruction;
  _nodeText: OmniTXMLText;
  EndTagName: string;
  PState: TParserState;
  ReadChar: Char;
  Text: string;
begin
  PState := psTag;
  // read next available character
  while InputStream.ProcessChar(ReadChar) do
  begin
    case PState of
      psTag:
        if ReadChar = '<' then
        begin
          PState := psTagName; // waiting for a tag name
          StartTag := True;
        end
        else
        begin
        //if StartTag then // This filter breaks some XML oasis tests
          if IsXmlCData(ReadChar) then
          begin
            InputStream.UndoRead;
            _nodeText := InternalCreateTextNode('');
            Parent.AppendChild(_nodeText);
            _nodeText.ReadFromStream(Parent, InputStream);
          end
          else
            raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_BADSTARTNAMECHAR, []);
        end;
      psTagName:  // one-time stop
        if not CharIs_WhiteSpace(ReadChar) then
        begin
          case ReadChar of
            '?':
              begin
                _nodePI := InternalCreateProcessingInstruction('', '');
                Parent.AppendChild(_nodePI);
                _nodePI.ReadFromStream(Parent, InputStream);
                PState := psTag;
              end;
            '!': PState := psCommentOrCDATAOrDoctype;  // not enough info, check also next char
            '/': PState := psEndTagName;
          else
            // [40] STag
            // [5] Name
            if CharIs_Letter(ReadChar) or (ReadChar = '_') then
            begin
              // it's an element
              InputStream.WriteOutputChar(ReadChar);
              _nodeElement := InternalCreateElement('');
              Parent.AppendChild(_nodeElement);
              _nodeElement.ReadFromStream(Parent, InputStream);
              PState := psTag;
            end
            else
              raise EXMLException.CreateParseError(INVALID_CHARACTER_ERR, MSG_E_BADSTARTNAMECHAR, []);
          end;
        end;
      psEndTagName:
        // [42] ETag
        begin
          case ReadChar of
            '>':
              begin
                EndTagName := InputStream.GetOutputBuffer;
                if (EndTagName = Parent.NodeName) and (EndTagName = (UnclosedElementList[UnclosedElementList.Count - 1] as OmniIXMLElement).NodeName) then
                begin
                  UnclosedElementList.Delete(UnclosedElementList.Count - 1);
                  Exit;
                end
                else
                  raise EXMLException.CreateParseError(HIERARCHY_REQUEST_ERR, MSG_E_ENDTAGMISMATCH, [EndTagName, Parent.NodeName]);
              end;
          else
            {'A'..'Z', 'a'..'z', '0'..'9':}
            InputStream.WriteOutputChar(ReadChar);
          end;
        end;
      psCommentOrCDATAOrDoctype:
        begin
          case ReadChar of
            '[':
              begin
                InputStream.GetNextString(Text, 6);
                if Text = 'CDATA[' then
                begin
                  InputStream.ClearOutputBuffer;
                  _nodeCDATA := InternalCreateCDATASection('');
                  Parent.AppendChild(_nodeCDATA);
                  _nodeCDATA.ReadFromStream(Parent, InputStream);
                  PState := psTag;
                end;
              end;
            '-':
              begin
                if InputStream.ProcessChar(ReadChar) and (ReadChar = '-') then
                begin
                  _nodeComment := InternalCreateComment('');
                  Parent.AppendChild(_nodeComment);
                  _nodeComment.ReadFromStream(Parent, InputStream);
                  PState := psTag;
                end
                else
                  raise Exception.CreateFmt('Invalid node %s', [InputStream.GetOutputBuffer]);
              end;
            'D':{OCTYPE}
              begin
                InputStream.GetNextString(Text, 6);
                if Text = 'OCTYPE' then
                begin
                  InputStream.ClearOutputBuffer;
                  _nodeDocType := InternalCreateDocType('');
                  Parent.AppendChild(_nodeDocType);
                  _nodeDocType.ReadFromStream(Parent, InputStream);
                  FDocType := _nodeDocType as OmniIXMLDocumentType;
                  PState := psTag;
                end;
              end;
          end;
        end;
    end;
  end;

  if FChildNodes = nil then
    raise EXMLException.CreateParseError(0, MSG_E_MISSINGROOT, [])
end;

{ TTexListDic }

constructor TTexListDic.Create;
begin
  inherited;
  FTextList := TStringList.Create;
  FTexPosDic := TTexPosDic.Create;
end;

destructor TTexListDic.Destroy;
begin
  FTexPosDic.Free;
  FTextList.Free;
  inherited;
end;

function TTexListDic.PositionOf(const Text: string): Integer;
var
  Id: TDicId;
begin
  if FTexPosDic.TryGetValue(Text, Id) then
    Result := Id
  else
    Result := -1;
end;

function TTexListDic.Add(const Text: string): TDicId;
var
  Value: Integer;
begin
  Value := PositionOf(Text);
  if Value >= 0 then
    Result := Value
  else
  begin
    Value := FTextList.Add(Text);
    FTexPosDic.Add(Text, Value);
    Result := Value;
  end;
end;

function TTexListDic.Get(const Id: TDicId): string;
begin
  Result := FTextList[Id];
end;

end.
