{-----------------------------------------------------------------------------
 Unit Name: adomxmldom/gtcAdomxmldom
 Author:    Tor Helland (reworked from Borland's 2.4 wrapper, which also had
            contributions from Keith Wood)
 Purpose:   IDom... interface wrapper for ADOM 4.3 (formerly OpenXML)
 History:   20110810 me/th Missing namespace declaration when doNamespaceDecl is not set in
                        TXMLDocument.Options, by Mark Edington.
                        Also made to work in older Delphi versions.
                        And also fixed similar problem with namespaced attributes.
            20100808 th Various changes around RefCount, most notably no longer touching
                        Tox4DomDocument's RefCount from Tox4DomElement._AddRef/_Release.
            20100528 th A non-namespaced element as a child of an element with a
                        default namespace, now gets an empty xmlns attribute.
            20100525 cw Updates for compiling on Mac OSX.
            20100321 th Support for ADOM v4.3 and v5 renamed to exist
                        alongside ADOM and adomxmldom bundled with Delphi 2010++.
            20090809 th Fixed some serious flaws in selectNode/selectNodes (now
                        makes a copy of the nodes returned from TXpathExpression).
            20090727 me Update to work with ADOM 4.3. Renamed to adomxmldom.
            20080910 th Avoiding error when doing xpath on tree with
                        PreserveWhitespace in effect.
            20080902 th SelectNode and SelectNodes now return literal xpath query
                        results (boolean, number, string) as TDomText/IDomText/IXmlNode.
            20080815 th The document element's Tox4DomElement._AddRef/_Release now
                        also access the document's _AddRef/_Release. This is to avoid
                        RefCount trouble when using IDomNodeSelect.
                        Added license text for MPL 1.1.
            20080808 th Changes for working in Delphi 2009 Tiburon.
                        Renamed ox31 to ox4.
                        Uses TXmlInputSource for Xdom v4 in loadxml and loadFromStream.
            20060707 th Using Thomas Mueller's tweaking for Xdom 3.2 and D2006.
                        Renaming for Xdom 3.2, and package for both D6 and D2006.
            20051120 th Support for OnLookupNamespaceURI, giving the context node
                        back as a parameter in our wrapper event.
            20051004 th Simply replaced all TdomDocumentType with TdomDocumentTypeDecl.
                        ntDocument_Type_Decl_Node now gives a Tox31DOMDocumentType.
                        Removed Tox31DOMNotation and Tox31DOMEntity.
                        Setting Tox31DOMDocument.FDocIsOwned to True.
                        Replaced CreateDoc with TdomDocument.Create.
                        Always creates TdomDocumentXpath.
                        Creates the DocumentElement manually on createDocument.
                        FBuilder.DocTypeDeclTreatment := dtCheckWellformedness;
                        Uses TXmlNamespaceSignalGenerator when reading xml.
                        Returns dummy Tox31DOMDocumentType.get_entities.
                        Returns dummy Tox31DOMDocumentType.get_notations.

 In understanding with CodeGear, this code is released under the Mozilla
 Public License Version 1.1.

 LICENSE:
 The contents of this file are subject to the Mozilla Public License
 Version 1.1 (the "License"); you may not use this file except in
 compliance with the License. You may obtain a copy of the License at
 http://www.mozilla.org/MPL/

 Software distributed under the License is distributed on an "AS IS"
 basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 License for the specific language governing rights and limitations
 under the License.

 The Original Code is oxmldom.pas.

 The Initial Developer of the Original Code is CodeGear,
 with contributions from Keith Wood. Portions created by CodeGear are
 Copyright (C) 1995-2008 CodeGear. All Rights Reserved.
 Portions created by Tor Helland are Copyright (C) 2005-2008 Tor Helland.
 All Rights Reserved.

 Alternatively, the contents of this file may be used under the terms
 of the GNU General Public License Version 2 or later (the "GPL"), in which case the
 provisions of GPL are applicable instead of those
 above. If you wish to allow use of your version of this file only
 under the terms of the GPL and not to allow others to use
 your version of this file under the MPL, indicate your decision by
 deleting the provisions above and replace them with the notice and
 other provisions required by the GPL. If you do not delete
 the provisions above, a recipient may use your version of this file
 under either the MPL or the GPL.
-----------------------------------------------------------------------------}
{$define UseADomV4_3} // Bundled with Delphi 2010 and onward, adomxmldom.pas.
{.$define UseADomV4_3_Custom} // Units prefixed with dk to coexist with the RTL bundled version.
{.$define UseADomV5_Custom} // Units prefixed with dk.
{.$define UseADomV3_2_Custom} // Not tested.

{.$define _RefCountLog} // Remove . to log _AddRef/_Release using OutputDebugString()
unit Xml.adomxmldom;

interface
{$HPPEMIT LEGACYHPP}

uses
  System.Types,
  System.Generics.Collections,
  System.Classes,
  System.Variants,
{$IFDEF MSWINDOWS}
{$IFNDEF NEXTGEN}
  Winapi.ActiveX,
  System.Win.ComObj,
{$ENDIF !NEXTGEN}
{$ENDIF}
  System.SysUtils,
  {$ifdef UseADomV4_3}
  Xml.Internal.TreeUtils,
  Xml.Internal.AdomCore_4_3,
  {$endif}
  {$ifdef UseADomV4_3_Custom}
  dkAdomCore_4_3,
  {$endif}
  {$ifdef UseADomV5_Custom}
  dkAdomCore,
  {$endif}
  {$ifdef UseADomV3_2_Custom}
  Xdom_3_2,
  {$endif}
  Xml.xmldom;

{$IF CompilerVersion >= 24.0}
{$LEGACYIFEND ON}
{$IFEND}

{$IF DOMWrapperVersion > 1.0}
// Testing for the version of xmldom.pas (safecalls on interfaces).
{$DEFINE WRAPVER1.1}
{$IFEND}

(*$HPPEMIT END '#pragma startup ADOMUnitInitialization 65' *)
procedure ADOMUnitInitialization;

const
  {$ifdef UseADomV4_3}
  sAdom4XmlVendor = 'ADOM XML v4';                    { Do not localize }
  {$endif}
  {$ifdef UseADomV4_3_Custom}
  sAdom4XmlVendor = 'ADOM XML v4 (custom)'; { Do not localize }
  {$endif}
  {$ifdef UseADomV5_Custom}
  sAdom4XmlVendor = 'ADOM XML v5 (custom)';  { Do not localize }
  {$endif}
  {$ifdef UseADomV3_2_Custom}
  sAdom4XmlVendor = 'Open XML v3 (custom)'; { Do not localize }
  {$endif}

type
// Type alias for IDOMPersist.loadxml method which changed signatures in Delphi 2010
{$if (CompilerVersion >= 21.0) or (DOMWrapperVersion > 1.3)}
  TXMLFileName = DOMString;// WideString;
{$else}
  TXMLFileName = DOMString;
{$ifend}

type

{ Iox4DOMNodeRef }

  Iox4DOMNodeRef = interface
    ['{4D898FD5-1F65-44E9-9E27-A28026311F94}']
    function GetNativeNode: TdomNode;
  end;

{ Tox4DOMInterface }

  Tox4DOMInterface = class(TInterfacedObject)
  protected
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    function SafeCallException(ExceptObject: TObject; ExceptAddr: Pointer): HRESULT; override;
  end;

{ Tox4DOMImplementation }


   PParseErrorInfo = ^TParseErrorInfo;
   TParseErrorInfo = record
     errorCode: Integer;
     errorCodeStr: string;
{$IFDEF NEXTGEN}
     url: string;
     reason: string;
     srcText: string;
{$ELSE !NEXTGEN}
     url: WideString;
     reason: WideString;
     srcText: WideString;
{$ENDIF NEXTGEN}
     line: Integer;
     linePos: Integer;
     filePos: Integer;
   end;

  Tox4DOMDocument = class;

  Tox4DOMImplementation = class(Tox4DOMInterface, IDOMImplementation)
  private
    FNativeDOMImpl: TDomImplementation;
    FParser            : TXmlToDomParser;
    FBuilder           : TXmlDomBuilder;
    FReader            : TXmlStandardDomReader;
    FNSGen             : TXmlNamespaceSignalGenerator;
    FXpath             : TXPathExpression;
    FParseError        : PParseErrorInfo;
    function GetNativeDOMImpl: TdomImplementation;
  protected
    { IDOMImplementation }
    function hasFeature(const feature, version: DOMString): WordBool;
    function createDocumentType(const qualifiedName, publicId,
      systemId: DOMString): IDOMDocumentType; safecall;
    function createDocument(const namespaceURI, qualifiedName: DOMString;
      doctype: IDOMDocumentType): IDOMDocument; safecall;

    // XPath NS event.
{$IFDEF NEXTGEN}
    procedure xpathLookupNamespaceURI(const Sender: TXPathExpression;
      const APrefix: string; var ANamespaceURI: string);
{$ELSE !NEXTGEN}
    procedure xpathLookupNamespaceURI(const Sender: TXPathExpression;
      const APrefix: WideString; var ANamespaceURI: WideString);
{$ENDIF NEXTGEN}
  public
    constructor Create;
    destructor Destroy; override;
    { Parsing Helpers for IDOMPersist }
    procedure FreeDocument(var Doc: TDomDocument);
    procedure InitParserAgent;
    function loadFromStream(const stream: TStream; const WrapperDoc: Tox4DOMDocument;
      var ParseError: TParseErrorInfo): WordBool;
    function loadxml(const Value: TXMLFileName; const WrapperDoc: Tox4DOMDocument;
      var ParseError: TParseErrorInfo): WordBool;
    procedure ParseErrorHandler(sender: TObject; error: TdomError; var Go: Boolean);
    property NativeDOMImpl: TdomImplementation read GetNativeDOMImpl;
  end;

{ Tox4DOMNode }

  Tox4DOMNodeClass = class of Tox4DOMNode;

  Tox4DOMNode = class(Tox4DOMInterface, Iox4DOMNodeRef,
    IDOMNode, IDOMNodeEx, IDOMNodeSelect)
  private
    FNativeNode: TdomNode;
    [Weak]FWrapperDocument: Tox4DOMDocument;
    FChildNodes: IDOMNodeList;
    FAttributes: IDOMNamedNodeMap;
    FOwnerDocument: IDOMDocument;
    FOwnAndLaterFreeNativeNode: Boolean;
    FXpathNodeListCopy: IDomNodeList;
  protected
    function AllocParser: TDomToXmlParser; // Must be freed by the calling routine.
    procedure CheckNamespaceDeclaration(xdnChild: TDomNode);

    { Iox4DOMNodeRef }
    function GetNativeNode: TDomNode;
    { IDOMNode }
    function get_nodeName: DOMString; virtual; safecall;
    function get_nodeValue: DOMString; virtual; safecall;
    procedure set_nodeValue(value: DOMString); virtual; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function get_nodeType: DOMNodeType; safecall;
    function get_parentNode: IDOMNode; safecall;
    function get_childNodes: IDOMNodeList; virtual; safecall;
    function get_firstChild: IDOMNode; safecall;
    function get_lastChild: IDOMNode; safecall;
    function get_previousSibling: IDOMNode; safecall;
    function get_nextSibling: IDOMNode; safecall;
    function get_attributes: IDOMNamedNodeMap; safecall;
    function get_ownerDocument: IDOMDocument; safecall;
    function get_namespaceURI: DOMString; virtual; safecall;
    function get_prefix: DOMString; virtual; safecall;
    function get_localName: DOMString; virtual; safecall;
    function insertBefore(const newChild, refChild: IDOMNode): IDOMNode; safecall;
    function replaceChild(const newChild, oldChild: IDOMNode): IDOMNode; safecall;
    function removeChild(const childNode: IDOMNode): IDOMNode; safecall;
    function appendChild(const newChild: IDOMNode): IDOMNode; safecall;
    function hasChildNodes: WordBool; virtual; safecall;
    function cloneNode(deep: WordBool): IDOMNode; safecall;
    procedure normalize; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function supports(const feature, version: DOMString): WordBool;
    { IDOMNodeEx }
    function get_text: DOMString; safecall;
    function get_xml: DOMString; safecall;
    procedure set_text(const Value: DOMString); safecall;
    procedure TransformNode(const stylesheet: IDOMNode; var output: XmlDomString); overload; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    procedure TransformNode(const stylesheet: IDOMNode; const output: IDOMDocument); overload; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    { IDOMNodeSelect }
    function selectNode(const nodePath: XmlDomString): IDOMNode; safecall;
    function selectNodes(const nodePath: XmlDomString): IDOMNodeList; safecall;
  public
    constructor Create(ANativeNode: TdomNode; AWrapperDocument: Tox4DOMDocument); virtual;
    destructor Destroy; override;
    property NativeNode: TdomNode read FNativeNode;
    property WrapperDocument: Tox4DOMDocument read FWrapperDocument;
  end;

{ Tox4DOMNodeList }

  Tox4DOMNodeList = class(Tox4DOMInterface, IDOMNodeList)
  private
     FNativeNodeList: TDomNodeList;
     FNativeXpathNodeSet: TDomXPathCustomResult;
     [Weak] FWrapperOwnerNode: Tox4DOMNode;
  protected
    { IDOMNodeList }
    function get_item(index: Integer): IDOMNode; safecall;
    function get_length: Integer; safecall;
  public
    constructor Create(ANativeNodeList: TDomNodeList; AWrapperOwnerNode: Tox4DOMNode); overload;
    constructor Create(AnXpath: TXpathExpression; AWrapperOwnerNode: Tox4DOMNode); overload;
    destructor Destroy; override;
    property NativeNodeList: TDomNodeList read FNativeNodeList;
  end;

{ Tox4DOMNamedNodeMap }

  Tox4DOMNamedNodeMap = class(Tox4DOMInterface, IDOMNamedNodeMap)
  private
    FNativeNamedNodeMap: TDomNamedNodeMap;
    [Weak] FWrapperOwnerNode: Tox4DOMNode;
    procedure CheckNamespaceAware;
  protected
    { IDOMNamedNodeMap }
    function get_item(index: Integer): IDOMNode; safecall;
    function get_length: Integer; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function getNamedItem(const name: DOMString): IDOMNode; safecall;
    function setNamedItem(const arg: IDOMNode): IDOMNode; safecall;
    function removeNamedItem(const name: DOMString): IDOMNode; safecall;
    function getNamedItemNS(const namespaceURI, localName: DOMString): IDOMNode; safecall;
    function setNamedItemNS(const arg: IDOMNode): IDOMNode; safecall;
    function removeNamedItemNS(const namespaceURI, localName: DOMString): IDOMNode; safecall;
  public
    constructor Create(ANativeNamedNodeMap: TDomNamedNodeMap; AWrapperOwnerNode: Tox4DOMNode);
    property NativeNamedNodeMap: TDomNamedNodeMap read FNativeNamedNodeMap;
  end;

{ Tox4DOMCharacterData }

  Tox4DOMCharacterData = class(Tox4DOMNode, IDOMCharacterData)
  private
    function GetNativeCharacterData: TdomCharacterData;
  protected
    { IDOMCharacterData }
    function get_data: DOMString; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    procedure set_data(const data: DOMString); {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function get_length: Integer; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function substringData(offset, count: Integer): DOMString; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    procedure appendData(const data: DOMString); {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    procedure insertData(offset: Integer; const data: DOMString); {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    procedure deleteData(offset, count: Integer); {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    procedure replaceData(offset, count: Integer; const data: DOMString); {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
  public
    property NativeCharacterData: TDomCharacterData read GetNativeCharacterData;
  end;

{ Tox4DOMAttr }

  Tox4DOMAttr = class(Tox4DOMNode, IDOMAttr)
  private
    function GetNativeAttribute: TdomAttr;
  protected
    { Property Get/Set }
    function get_name: DOMString; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function get_specified: WordBool; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function get_value: DOMString; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    procedure set_value(const attributeValue: DOMString); {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function get_ownerElement: IDOMElement; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    { Properties }
    property name: DOMString read get_name;
    property specified: WordBool read get_specified;
    property value: DOMString read get_value write set_value;
    property ownerElement: IDOMElement read get_ownerElement;
  public
    property NativeAttribute: TDomAttr read GetNativeAttribute;
  end;

{ Tox4DOMElement }

  Tox4DOMElement = class(Tox4DOMNode, IDOMElement)
  private
    function GetNativeElement: TDomElement;
    procedure CheckNamespaceAware;
  protected
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    { IDOMElement }
    function get_tagName: DOMString; safecall;
    function getAttribute(const name: DOMString): DOMString; safecall;
    procedure setAttribute(const name, value: DOMString); {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    procedure removeAttribute(const name: DOMString); {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function getAttributeNode(const name: DOMString): IDOMAttr; safecall;
    function setAttributeNode(const newAttr: IDOMAttr): IDOMAttr; safecall;
    function removeAttributeNode(const oldAttr: IDOMAttr): IDOMAttr; safecall;
    function getElementsByTagName(const name: DOMString): IDOMNodeList;
      safecall;
    function getAttributeNS(const namespaceURI, localName: DOMString):
      DOMString; safecall;
    procedure setAttributeNS(const namespaceURI, qualifiedName,
      value: DOMString); {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    procedure removeAttributeNS(const namespaceURI, localName: DOMString); {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function getAttributeNodeNS(const namespaceURI, localName: DOMString):
      IDOMAttr; safecall;
    function setAttributeNodeNS(const newAttr: IDOMAttr): IDOMAttr; safecall;
    function getElementsByTagNameNS(const namespaceURI,
      localName: DOMString): IDOMNodeList; safecall;
    function hasAttribute(const name: DOMString): WordBool; safecall;
    function hasAttributeNS(const namespaceURI, localName: DOMString): WordBool; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    procedure normalize; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
  public
    property NativeElement: TdomElement read GetNativeElement;
  end;

{ Tox4DOMText }

  Tox4DOMText = class(Tox4DOMCharacterData, IDOMText)
  protected
    function splitText(offset: Integer): IDOMText; safecall;
  end;

{ Tox4DOMComment }

  Tox4DOMComment = class(Tox4DOMCharacterData, IDOMComment)
  end;

{ Tox4DOMCDATASection }

  Tox4DOMCDATASection = class(Tox4DOMText, IDOMCDATASection)
  end;

{ Tox4DOMDocumentType }

  Tox4DOMDocumentTypeChildren = class;

  Tox4DOMDocumentType = class(Tox4DOMNode, IDOMDocumentType)
  private
    FWrapperDocumentTypeChildren: Tox4DOMDocumentTypeChildren;
    FEntities: IDOMNamedNodeMap;
    FNotations: IDOMNamedNodeMap;
    FDummyEntitiesList: TList<TCustomOwnedNode>;
    FDummyEntities: TdomNamedNodeMap;
    FDummyNotationsList: TList<TCustomOwnedNode>;
    FDummyNotations: TdomNamedNodeMap;

    function GetNativeDocumentType: TDomDocumentTypeDecl;
  protected
    function get_childNodes: IDOMNodeList; override; safecall;
    function hasChildNodes: WordBool; override; safecall;
    { IDOMDocumentType }
    function get_name: DOMString; safecall;
    function get_entities: IDOMNamedNodeMap; safecall;
    function get_notations: IDOMNamedNodeMap; safecall;
    function get_publicId: DOMString; safecall;
    function get_systemId: DOMString; safecall;
    function get_internalSubset: DOMString; safecall;
  public
    constructor Create(ANativeNode: TdomNode; WrapperDocument: Tox4DOMDocument); override;
    destructor Destroy; override;
    property NativeDocumentType: TDomDocumentTypeDecl read GetNativeDocumentType;
  end;

  Tox4DOMDocumentTypeChildren = class(TInterfacedObject, IDOMNodeList)
  private
    FWrapperOwnerDocumentType: Tox4DOMDocumentType;
  protected
    { IDOMNodeList }
    function get_item(index: Integer): IDOMNode; safecall;
    function get_length: Integer; safecall;
  public
    constructor Create(NativeDocumentType: Tox4DOMDocumentType);
  end;

{ Tox4DOMEntityReference }

  Tox4DOMEntityReference = class(Tox4DOMNode, IDOMEntityReference)
  end;

{ Tox4DOMProcessingInstruction }

  Tox4DOMProcessingInstruction = class(Tox4DOMNode, IDOMProcessingInstruction)
  private
    function GetNativeProcessingInstruction: TDomProcessingInstruction;
  protected
    { IDOMProcessingInstruction }
    function get_target: DOMString; safecall;
    function get_data: DOMString; safecall;
    procedure set_data(const value: DOMString); {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
  public
    property NativeProcessingInstruction: TDomProcessingInstruction
      read GetNativeProcessingInstruction;
  end;

{ Tox4DOMXPathNamespace }

  Tox4DOMXPathNamespace = class(Tox4DOMNode, IDOMNode)
  private
    FNativeXPathNamespaceNode: TDomXPathNamespace;
    function GetNativeXPathNamespace: TDomXPathNamespace;
  protected
    // IDomNode
    function get_nodeName: DOMString; override; safecall;
    function get_nodeValue: DOMString; override; safecall;
    procedure set_nodeValue(value: DOMString); override; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function get_namespaceURI: DOMString; override; safecall;
    function get_prefix: DOMString; override; safecall;
    function get_localName: DOMString; override; safecall;
  public
    constructor Create(ANativeNode: TDomNode; AWrapperDocument: Tox4DOMDocument); override;
    destructor Destroy; override;
    property NativeXPathNamespace: TDomXPathNamespace read GetNativeXPathNamespace;
  end;

{ Tox4DOMDocumentFragment }

  Tox4DOMDocumentFragment = class(Tox4DOMNode, IDOMDocumentFragment)
  end;

{ Tox4DOMDocument }

  Tox4DOMDocument = class(Tox4DOMNode, IDOMDocument, IDOMParseOptions,
    IDOMPersist, IDOMParseError, IDOMXMLProlog)
  private
    FWrapperDOMImpl: Tox4DOMImplementation;
    FDocIsOwned: Boolean;
    FParseError: TParseErrorInfo;
    FDeclareNamespaces: Boolean;
    FPreserveWhitespace: Boolean;
    FDocumentElement: IDOMElement;
    FNativeDocumentElement: TdomElement;
  protected
    function GetNativeDocument: TDomDocumentXpath;
    procedure RemoveWhiteSpaceNodes;
    { IDOMDocument }
    function get_doctype: IDOMDocumentType; safecall;
    function get_domImplementation: IDOMImplementation; safecall;
    function get_documentElement: IDOMElement; safecall;
    procedure set_documentElement(const DOMElement: IDOMElement); {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function createElement(const tagName: DOMString): IDOMElement; safecall;
    function createDocumentFragment: IDOMDocumentFragment; safecall;
    function createTextNode(const data: DOMString): IDOMText; safecall;
    function createComment(const data: DOMString): IDOMComment; safecall;
    function createCDATASection(const data: DOMString): IDOMCDATASection;
      safecall;
    function createProcessingInstruction(const target,
      data: DOMString): IDOMProcessingInstruction; safecall;
    function createAttribute(const name: DOMString): IDOMAttr; safecall;
    function createEntityReference(const name: DOMString): IDOMEntityReference;
      safecall;
    function getElementsByTagName(const tagName: DOMString): IDOMNodeList;
      safecall;
    function importNode(importedNode: IDOMNode; deep: WordBool): IDOMNode;
      safecall;
    function createElementNS(const namespaceURI,
      qualifiedName: DOMString): IDOMElement; safecall;
    function createAttributeNS(const namespaceURI,
      qualifiedName: DOMString): IDOMAttr; safecall;
    function getElementsByTagNameNS(const namespaceURI,
      localName: DOMString): IDOMNodeList; safecall;
    function getElementById(const elementId: DOMString): IDOMElement; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    { IDOMParseOptions }
    function get_async: Boolean; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function get_preserveWhiteSpace: Boolean; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function get_resolveExternals: Boolean; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function get_validate: Boolean; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    procedure set_async(Value: Boolean); {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    procedure set_preserveWhiteSpace(Value: Boolean); {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    procedure set_resolveExternals(Value: Boolean); {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    procedure set_validate(Value: Boolean); {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    { IDOMPersist }
    function get_xml: DOMString; safecall;
    function asyncLoadState: Integer; safecall;
    function load(source: OleVariant): WordBool; safecall;
    function loadFromStream(const stream: TStream): WordBool; {$IFDEF WRAPVER1.1} overload; {$ENDIF} safecall;
    function loadxml(const Value: TXMLFileName): WordBool; safecall;
    procedure save(destination: OleVariant); safecall;
    procedure saveToStream(const stream: TStream); {$IFDEF WRAPVER1.1} overload; {$ENDIF} safecall;
    procedure set_OnAsyncLoad(const Sender: TObject;
      EventHandler: TAsyncEventHandler); safecall;
{$IFDEF WRAPVER1.1}
    function loadFromStream(const stream: IStream): WordBool; overload; safecall;
    procedure saveToStream(const stream: IStream); overload; safecall;
{$ENDIF}
    { IDOMParseError }
    function get_errorCode: Integer; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function get_url: DOMString; safecall;
    function get_reason: DOMString; safecall;
    function get_srcText: DOMString; safecall;
    function get_line: Integer; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function get_linepos: Integer; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    function get_filepos: Integer; {$IFDEF WRAPVER1.1} safecall; {$ENDIF}
    { IDOMXMLProlog }
    function get_Encoding: DOMString; safecall;
    function get_Standalone: DOMString; safecall;
    function get_Version: DOMString; safecall;
    procedure set_Encoding(const Value: DOMString); safecall;
    procedure set_Standalone(const Value: DOMString); safecall;
    procedure set_Version(const Value: DOMString); safecall;
  public
    constructor Create(AWrapperDOMImpl: Tox4DOMImplementation; ANativeDoc: TDomDocumentXpath;
      DocIsOwned: Boolean); reintroduce;
    destructor Destroy; override;
    property NativeDocument: TDomDocumentXpath read GetNativeDocument;
    property DeclareNamespaces: Boolean read FDeclareNamespaces write FDeclareNamespaces;
    property PreserveWhitespace: Boolean read FPreserveWhitespace;
    property WrapperDOMImpl: Tox4DOMImplementation read FWrapperDOMImpl;
  end;

{ Tox4DOMImplementationFactory }

  Tox4DOMImplementationFactory = class(TDOMVendor)
  private
    FGlobalDOMImpl: IDOMImplementation;
  public
    function DOMImplementation: IDOMImplementation; override;
    function Description: String; override;
  end;

  // OnLookupNamespaceURI
{$IFDEF NEXTGEN}
  Tox4OnXPathLookupNamespaceURI = procedure (const AContextNode: IDomNode;
    const APrefix: string; var ANamespaceURI: string) of object;
{$ELSE !NEXTGEN}
  Tox4OnXPathLookupNamespaceURI = procedure (const AContextNode: IDomNode;
    const APrefix: WideString; var ANamespaceURI: WideString) of object;
{$ENDIF NEXTGEN}

var
  OpenXML4Factory: Tox4DOMImplementationFactory;

  OnOx4XPathLookupNamespaceURI: Tox4OnXPathLookupNamespaceURI = nil;

implementation

uses
  System.TypInfo,
  System.SyncObjs
{$IFDEF USE_INDY}
  , IdHttp
{$ENDIF}
{$IFDEF MSWINDOWS}
  , Winapi.Windows
{$ENDIF};

type
  THackXPathExpression = class(TXPathExpression);
var
  GlobalOx4DOM: Tox4DOMImplementation;

resourcestring
{$IFDEF MSWINDOWS}
  SErrorDownloadingURL = 'Error downloading URL: %s';
  SUrlMonDllMissing = 'Unable to load %s';
{$ENDIF}
  SNodeExpected   = 'NativeNode cannot be null';
  SNotImplemented =
    'This property or method is not implemented in the Open XML Parser';

// List of XPath context nodes, for OnLookupNamespaceURI.

var
  lstContextNodes: TList<Tox4DOMNode>;
  criContextNodes: TCriticalSection;

procedure ADOMUnitInitialization;
begin
end;

procedure AddContextNode(WrapperNode: Tox4DOMNode);
begin
  criContextNodes.Enter;
  try
    lstContextNodes.Add(WrapperNode);
  finally
    criContextNodes.Leave;
  end;
end;

function FindContextNode(dnNative: TdomNode): Tox4DOMNode;
var
  i: Integer;
begin
  criContextNodes.Enter;
  try

    for i := 0 to lstContextNodes.Count - 1 do
    begin
      Result := Tox4DOMNode(lstContextNodes[i]);
      if Result.NativeNode = dnNative then
        Exit;
    end;

    // Found nothing.
    Result := nil;

  finally
    criContextNodes.Leave;
  end;
end;

procedure FreeContextNodes;
begin
  FreeAndNil(lstContextNodes);
  FreeAndNil(criContextNodes);
end;

procedure InitContextNodes;
begin
  lstContextNodes := TList<Tox4DOMNode>.Create;
  criContextNodes := TCriticalSection.Create;
end;

procedure RemoveContextNode(WrapperNode: Tox4DOMNode);
begin
  criContextNodes.Enter;
  try
    lstContextNodes.Remove(WrapperNode);
  finally
    criContextNodes.Leave;
  end;
end;

{ Utility Functions }

function GetNativeNodeOfIntfNode(const Node: IDOMNode): TdomNode;
begin
  if not Assigned(Node) then
    raise DOMException.Create(SNodeExpected);
  Result := (Node as Iox4DOMNodeRef).GetNativeNode;
end;

function MakeNode(NativeNode: TdomNode; WrapperDocument: Tox4DOMDocument;
  bOwnAndLaterFreeNativeNode: Boolean = False): IDOMNode;
var
  dnWrapper: Tox4DOMNode;
begin
  if NativeNode = nil then
    Result := nil

  else begin
    // Possible change for later, having a pointer to the wrapper node:
    // dnWrapper := Tox4DomNode(NativeNode.GetUserData('WrapperNode'));
    // if Assigned(dnWrapper) then
    //   Result := dnWrapper
    // else begin
    // ...
    // NativeNode.SetUserData('WrapperNode', dnWrapper, nil);

    dnWrapper := nil;
    case NativeNode.NodeType of
      ntUnknown: dnWrapper := Tox4DOMNode.Create(NativeNode, WrapperDocument);
      ntElement_Node: dnWrapper := Tox4DOMElement.Create(NativeNode, WrapperDocument);
      ntAttribute_Node: dnWrapper := Tox4DOMAttr.Create(NativeNode, WrapperDocument);
      ntText_Node: dnWrapper := Tox4DOMText.Create(NativeNode, WrapperDocument);
      ntCDATA_Section_Node: dnWrapper := Tox4DOMCDATASection.Create(NativeNode, WrapperDocument);
      ntEntity_Reference_Node: dnWrapper := Tox4DOMEntityReference.Create(NativeNode, WrapperDocument);
      ntProcessing_Instruction_Node: dnWrapper := Tox4DOMProcessingInstruction.Create(NativeNode, WrapperDocument);
      ntComment_Node: dnWrapper := Tox4DOMComment.Create(NativeNode, WrapperDocument);
      ntDocument_Node: dnWrapper := Tox4DOMDocument.Create(GlobalOx4DOM, NativeNode as TDomDocumentXpath, False);
      ntDocument_Fragment_Node: dnWrapper := Tox4DOMDocumentFragment.Create(NativeNode, WrapperDocument);
      ntDocument_Type_Decl_Node: dnWrapper := Tox4DOMDocumentType.Create(NativeNode, WrapperDocument);
      ntXPath_Namespace_Node: dnWrapper := Tox4DOMXPathNamespace.Create(NativeNode, WrapperDocument);
    end;

    dnWrapper.FOwnAndLaterFreeNativeNode := bOwnAndLaterFreeNativeNode;
    Result := dnWrapper;
  end;
end;

function MakeNodeList(const NativeNodeList: TdomNodeList;
  WrapperDocument: Tox4DOMNode): IDOMNodeList; overload;
begin
  Result := Tox4DOMNodeList.Create(NativeNodeList, WrapperDocument);
end;

function MakeNodeList(const NativeXpath: TXpathExpression;
  WrapperDocument: Tox4DOMNode): IDOMNodeList; overload;
begin
  Result := Tox4DOMNodeList.Create(NativeXpath, WrapperDocument);
end;

function MakeNamedNodeMap(const NativeNamedNodeMap: TdomNamedNodeMap; WrapperDocument: Tox4DOMNode):
  IDOMNamedNodeMap;
begin
  Result := Tox4DOMNamedNodeMap.Create(NativeNamedNodeMap, WrapperDocument);
end;

procedure Log(sText: string);
begin
{$ifdef MSWINDOWS}
  OutputDebugString(PChar(sText));
{$endif}
end;

{ Tox4DOMInterface }

function Tox4DOMInterface._AddRef: Integer;
begin
  Result := inherited _AddRef;
  {$ifdef _RefCountLog}
  Log(Format('%s._AddRef: %d (%x)', [self.ClassName, Result, Integer(self)]));
  {$endif}
end;

function Tox4DOMInterface._Release: Integer;
{$ifdef _RefCountLog}
var
  nSelf: Integer;
  sClass: string;
begin
  sClass := self.ClassName;
  nSelf := Integer(self);
  Result := inherited _Release;
  Log(Format('%s._Release: %d (%x)', [sClass, Result, nSelf]));
end;
{$else}
begin
  Result := inherited _Release;
end;
{$endif}

function Tox4DOMInterface.SafeCallException(ExceptObject: TObject;
  ExceptAddr: Pointer): HRESULT;
var
  HelpFile: string;
begin
{$IF defined(MSWINDOWS) and not defined(NEXTGEN)}
  if ExceptObject is EOleException then
    HelpFile := (ExceptObject as EOleException).HelpFile;
{$IFEND}
  Result := HandleSafeCallException(ExceptObject, ExceptAddr, IDOMNode, '', Helpfile);
end;

{ TDOMIStreamAdapter }

type
  TDOMIStreamAdapter = class(TStream)
  private
    FStream: IStream;
  public
    constructor Create(const Stream: IStream);
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
  end;

constructor TDOMIStreamAdapter.Create(const Stream: IStream);
begin
  inherited Create;
  FStream := Stream;
end;

function TDOMIStreamAdapter.Read(var Buffer; Count: Longint): Longint;
begin
  FStream.Read(@Buffer, Count, @Result)
end;

function TDOMIStreamAdapter.Write(const Buffer; Count: Longint): Longint;
begin
  FStream.Write(@Buffer, Count, @Result);
end;

function TDOMIStreamAdapter.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
var
  Pos: LargeUInt;
  {$IF (Ord(soBeginning) <> STREAM_SEEK_SET) or (Ord(soCurrent) <> STREAM_SEEK_CUR) or (Ord(soEnd) <> STREAM_SEEK_END)}
  FSOrigin: LongInt;
  {$IFEND}
begin
  {$IF (Ord(soBeginning) = STREAM_SEEK_SET) and (Ord(soCurrent) = STREAM_SEEK_CUR) and (Ord(soEnd) = STREAM_SEEK_END)}
  FStream.Seek(Offset, LongInt(Origin), Pos);
  {$ELSE}
  case Origin of
    soBeginning: FSOrigin := STREAM_SEEK_SET;
    soCurrent:   FSOrigin := STREAM_SEEK_CUR;
    soEnd:       FSOrigin := STREAM_SEEK_END;
  end;
  FStream.Seek(Offset, FSOrigin, Pos);
  {$IFEND}
  Result := Int64(Pos);
end;

{ Tox4DOMImplementation }

constructor Tox4DOMImplementation.Create;
begin
  inherited;
  FParser            := nil;
  FBuilder           := nil;
  FReader            := nil;
  FNSGen             := nil;
  FXpath             := nil;
  FParseError        := nil;

  FNativeDOMImpl := TDomImplementation.Create(nil);
  // Error handling.
  FNativeDOMImpl.OnError := ParseErrorHandler;
end;

function Tox4DOMImplementation.createDocument(const namespaceURI,
  qualifiedName: DOMString; doctype: IDOMDocumentType): IDOMDocument;
var
  domDoc: TDomDocumentXpath;
  intf: Iox4DOMNodeRef;
  domDocType: TDomDocumentTypeDecl;
begin
  if Supports(doctype, Iox4DOMNodeRef, intf) then
    domDocType := intf.GetNativeNode as TDomDocumentTypeDecl
  else
    domDocType := nil;

  // Create native document object.
  domDoc := TDomDocumentXpath.Create(NativeDOMImpl);

  // Set DocType.
  if Assigned(domDocType) then
    domDoc.AppendChild(domDocType);

  // Create DocumentElement.
  if qualifiedName <> '' then
    domDoc.AppendChild(TdomElement.CreateNS(domDoc, namespaceURI, qualifiedName));

  // Create wrapper document object.
  Result := Tox4DOMDocument.Create(self, domDoc, True);
end;

function Tox4DOMImplementation.createDocumentType(const qualifiedName,
  publicId, systemId: DOMString): IDOMDocumentType;
var
  domDocType: TDomDocumentTypeDecl;
begin
  domDocType := TDomDocumentTypeDecl.Create(nil, qualifiedName, publicId, systemId, '');
  Result := Tox4DOMDocumentType.Create(domDocType, nil);
end;

destructor Tox4DOMImplementation.Destroy;
begin
  FParser.DisposeOf;
  FBuilder.Free;
  FReader.Free;
  FNSGen.Free;
  FXpath.Free;

  FNativeDOMImpl.Free;

  inherited;
end;

procedure Tox4DOMImplementation.FreeDocument(var Doc: TDomDocument);
begin
  Doc.Free;
end;

function Tox4DOMImplementation.GetNativeDOMImpl: TdomImplementation;
begin
  Result := FNativeDOMImpl;
end;

function Tox4DOMImplementation.hasFeature(const feature, version: DOMString): WordBool;
begin
  // No longer supported in Adom.
  Result := False;
end;

procedure Tox4DOMImplementation.InitParserAgent;
begin
  if not Assigned(FParser) then
  begin
    FParser := TXmlToDomParser.Create(nil);
    FReader := TXmlStandardDomReader.Create(nil);
    FNSGen := TXmlNamespaceSignalGenerator.Create(nil);
    FBuilder := TXmlDomBuilder.Create(nil);
    FXpath := TXPathExpression.Create(nil);

    // Setup first step, parsing from file.
    FParser.DOMImpl := NativeDOMImpl;
    FParser.KeepCDATASections := True;
    FParser.KeepComments := True;
    FParser.KeepEntityRefs := True;

    // Setup link for second step, parsing to namespace-aware document.
    FReader.NextHandler := FNSGen;
    FReader.IgnoreUnspecified := False;
    FNSGen.NextHandler := FBuilder;
    FNSGen.PrefixMapping := True;
    FNSGen.SuppressXmlns := False;
    FBuilder.BuildIDList := True;
    FBuilder.DocTypeDeclTreatment := dtCheckWellformedness;
    FBuilder.KeepCDATASections := True;
    FBuilder.KeepComments := True;
    FBuilder.KeepEntityRefs := False;

    // XPath namespace handling.
    FXpath.OnLookupNamespaceURI := xpathLookupNamespaceURI;
  end;
end;

function Tox4DOMImplementation.loadFromStream(const stream: TStream;
  const WrapperDoc: Tox4DOMDocument; var ParseError: TParseErrorInfo): WordBool;
var
  docTemp: TDomDocument;
  {$ifndef UseADomV3_2_Custom}
  srcTemp: TXmlInputSource;
  {$endif}
begin
  FParseError := @ParseError;
  ParseError.errorCode := 0;

  InitParserAgent;

  WrapperDoc.NativeDocument.clear;
  FBuilder.referenceNode := WrapperDoc.NativeDocument;
  docTemp := nil;
  try

    try
      {$ifndef UseADomV3_2_Custom}
      srcTemp := TXmlInputSource.Create(stream, '', '', 0, '', False, 0, 0, 0, 0, 0);
      try
        docTemp := FParser.Parse(srcTemp);
      finally
        srcTemp.Free;
      end;
      {$else}
      docTemp := FParser.StreamToDom(stream, '', nil, True);
      {$endif}
      if ParseError.errorCode = 0 then
        FReader.parse(docTemp);
      Result := (ParseError.errorCode = 0);

      if Result then
      begin
        // In order to prevent dangling pointer when doing XPath "/" on a PreserveWhitespace document.
        WrapperDoc.get_documentElement;

        if not WrapperDoc.PreserveWhitespace then
          WrapperDoc.RemoveWhiteSpaceNodes;
      end;
    except
      on e: Exception do
      begin
        WrapperDoc.NativeDocument.clear;
        if ParseError.errorCodeStr <> '' then
          ParseError.reason :=  ParseError.errorCodeStr
        else
          ParseError.reason := e.Message;
        Result := False;
      end;
    end;

  finally
    docTemp.Free;
  end;

end;

function Tox4DOMImplementation.loadxml(const Value: TXMLFileName;
  const WrapperDoc: Tox4DOMDocument; var ParseError: TParseErrorInfo): WordBool;
var
  docTemp: TDomDocument;
  {$ifndef UseADomV3_2_Custom}
  srcTemp: TXmlInputSource;
  {$endif}
begin
  FParseError := @ParseError;
  ParseError.errorCode := 0;

  InitParserAgent;

  WrapperDoc.NativeDocument.clear;
  FBuilder.referenceNode := WrapperDoc.NativeDocument;
  docTemp := nil;
  try

    try
      {$ifndef UseADomV3_2_Custom}
      srcTemp := TXmlInputSource.Create(Value, '', '', 0, False, 0, 0, 0, 0, 0);
      try
        docTemp := FParser.Parse(srcTemp);
      finally
        srcTemp.Free;
      end;
      {$else}
      docTemp := FParser.WideStringToDom(Value, '', nil, True);
      {$endif}
      if ParseError.errorCode = 0 then
        FReader.parse(docTemp);
      Result := (ParseError.errorCode = 0);
      if Result then
      begin
        // In order to prevent dangling pointer when doing XPath "/" on a PreserveWhitespace document.
        WrapperDoc.get_documentElement;

        if not WrapperDoc.PreserveWhitespace then
          WrapperDoc.RemoveWhiteSpaceNodes;
      end;
    except
      on e: Exception do
      begin
        WrapperDoc.NativeDocument.clear;
        if ParseError.errorCodeStr <> '' then
          ParseError.reason :=  ParseError.errorCodeStr
        else
          ParseError.reason := e.Message;
        Result := False;
      end;
    end;

  finally
    docTemp.Free;
  end;

end;

procedure Tox4DOMImplementation.ParseErrorHandler(sender: TObject; error: TdomError; var Go: Boolean);
begin
  if (error.Severity = DOM_SEVERITY_FATAL_ERROR) or (FParseError.errorCode = 0) then
  begin
    FParseError^.errorCode := Integer(error.RelatedException);
    FParseError^.errorCodeStr := GetEnumName(TypeInfo(TXmlErrorType), Integer(error.RelatedException));
                                                                                       
    FParseError^.srcText := error.code;
    FParseError^.line := error.startLineNumber;
    FParseError^.linePos := error.startColumnNumber;
    FParseError^.filePos := error.StartByteNumber;
    FParseError^.url := error.Uri;
    Go := False;
  end;
end;

{$IFDEF NEXTGEN}
procedure Tox4DOMImplementation.xpathLookupNamespaceURI(
  const Sender: TXPathExpression; const APrefix: string;
  var ANamespaceURI: string);
{$ELSE !NEXTGEN}
procedure Tox4DOMImplementation.xpathLookupNamespaceURI(
  const Sender: TXPathExpression; const APrefix: WideString;
  var ANamespaceURI: WideString);
{$ENDIF NEXTGEN}
var
  dnWrapper: Tox4DOMNode;
  dnIntf: IDomNode;
begin
  dnWrapper := FindContextNode(Sender.ContextNode);
  if Assigned(dnWrapper) then
    dnIntf := dnWrapper
  else
    dnIntf := nil;

  if Assigned(OnOx4XPathLookupNamespaceURI) then
    OnOx4XPathLookupNamespaceURI(dnIntf, APrefix, ANamespaceURI);
end;

{ Tox4DOMNode }

function Tox4DOMNode.AllocParser: TDomToXmlParser;
begin
  Result := nil;
  if not Assigned(WrapperDocument)
    or not Assigned(WrapperDocument.WrapperDomImpl)
    or not Assigned(WrapperDocument.WrapperDomImpl.NativeDomImpl) then
    Exit;

  Result := TDomToXmlParser.create(nil);
  Result.DOMImpl := WrapperDocument.WrapperDomImpl.NativeDomImpl;

  // Must be freed by the calling routine.
end;

constructor Tox4DOMNode.Create(ANativeNode: TdomNode; AWrapperDocument: Tox4DOMDocument);
begin
  FNativeNode := ANativeNode;
  FWrapperDocument := AWrapperDocument;
  inherited Create;

  FOwnAndLaterFreeNativeNode := False;
  FXpathNodeListCopy := nil;
end;

destructor Tox4DOMNode.Destroy;
begin
  if FOwnAndLaterFreeNativeNode then
    FNativeNode.Free;
  FXpathNodeListCopy := nil;

  FNativeNode := nil;
  FWrapperDocument := nil;

  inherited;
end;

function Tox4DOMNode.appendChild(const newChild: IDOMNode): IDOMNode;
var
  xdnNewChild,
  xdnReturnedChild: TdomNode;
begin
  xdnNewChild := GetNativeNodeOfIntfNode(newChild);
  xdnReturnedChild := NativeNode.appendChild(xdnNewChild);
  if xdnReturnedChild = xdnNewChild then
    Result := newChild else
    Result := MakeNode(xdnReturnedChild, FWrapperDocument);

  CheckNamespaceDeclaration(xdnReturnedChild);
end;

function Tox4DOMNode.cloneNode(deep: WordBool): IDOMNode;
begin
  Result := MakeNode(NativeNode.CloneNode(deep), FWrapperDocument);
end;

procedure Tox4DOMNode.CheckNamespaceDeclaration(xdnChild: TDomNode);

  function LookupCurrentNS(const node: TDomNode): string;
  begin
    if node.Prefix = '' then
      Result := node.NamespaceURI
    else if Assigned(node.ParentNode) then
      Result := LookupCurrentNS(node.ParentNode)
    else
      Result := '';
  end;

var
  CurrentNS: DOMString;
  ChildNS: DOMString;
  ChildPrefix: DOMString;
  NSAttrName: DOMString;
  PrefixedNS: DOMString;
begin
  if FWrapperDocument.DeclareNamespaces then
  begin
    if xdnChild.NodeType = ntElement_Node then
    begin
      ChildNS := xdnChild.NamespaceURI;
      ChildPrefix :=  xdnChild.Prefix;
      CurrentNS := LookupCurrentNS(NativeNode);
      // If the namespace of the child is different than what is current
      // then add a namespace declaration.  If a prefix is specified
      // make sure that it's been declared.
      if (ChildNS <> CurrentNS) or (ChildPrefix <> '') then
      begin
        if ChildPrefix = '' then
          NSAttrName := SXMLNS
        else
        begin
          if NativeNode.LookupNamespaceURI(ChildPrefix) = '' then
            NSAttrName := SXMLNS+NSDelim+ChildPrefix;
        end;
        if NSAttrName <> '' then
          (xdnChild as TDomElement).SetAttributeNS(SXMLNamespaceURI, NSAttrName, ChildNS);
      end;
    end

    else if xdnChild.NodeType = ntAttribute_Node then
    begin
      ChildNS := xdnChild.NamespaceURI;
      ChildPrefix := xdnChild.Prefix;
      if ChildNS <> '' then
      begin
        if ChildPrefix = '' then
          // Attributes cannot have default namespace.
          raise ENamespace_Err.Create('Namespace error.');

        PrefixedNS := xdnChild.LookupNamespaceURI(ChildPrefix);
        if PrefixedNS <> ChildNS then
        begin
          // Namespace not defined, or must be redefined.
          NSAttrName := SXMLNS+NSDelim+ChildPrefix;
          (NativeNode as TDomElement).SetAttributeNS(SXMLNamespaceURI, NSAttrName, ChildNS);
        end;
      end;
    end;
  end;
end;

function Tox4DOMNode.get_attributes: IDOMNamedNodeMap;
begin
  if not Assigned(FAttributes) and Assigned(NativeNode.Attributes) then
    FAttributes := MakeNamedNodeMap(NativeNode.Attributes, Self);
  Result := FAttributes;
end;

function Tox4DOMNode.get_childNodes: IDOMNodeList;
begin
  if not Assigned(FChildNodes) then
    FChildNodes := MakeNodeList(NativeNode.ChildNodes, Self);
  Result := FChildNodes;
end;

function Tox4DOMNode.get_firstChild: IDOMNode;
begin
  Result := MakeNode(NativeNode.FirstChild, FWrapperDocument);
end;

function Tox4DOMNode.get_lastChild: IDOMNode;
begin
  Result := MakeNode(NativeNode.LastChild, FWrapperDocument);
end;

function Tox4DOMNode.get_localName: DOMString;
begin
  Result := NativeNode.LocalName;
end;

function Tox4DOMNode.get_namespaceURI: DOMString;
begin
  Result := NativeNode.NamespaceURI;
end;

function Tox4DOMNode.get_nextSibling: IDOMNode;
begin
  Result := MakeNode(NativeNode.NextSibling, FWrapperDocument);
end;

function Tox4DOMNode.get_nodeName: DOMString;
begin
  Result := NativeNode.NodeName;
end;

function Tox4DOMNode.get_nodeType: DOMNodeType;
begin
  case NativeNode.NodeType of
    ntUnknown: Result := 0;
    ntElement_Node: Result := ELEMENT_NODE;
    ntAttribute_Node: Result := ATTRIBUTE_NODE;
    ntText_Node: Result := TEXT_NODE;
    ntCDATA_Section_Node: Result := CDATA_SECTION_NODE;
    ntEntity_Reference_Node: Result := ENTITY_REFERENCE_NODE;
    ntProcessing_Instruction_Node: Result := PROCESSING_INSTRUCTION_NODE;
    ntComment_Node: Result := COMMENT_NODE;
    ntDocument_Node: Result := DOCUMENT_NODE;
    ntDocument_Fragment_Node: Result := DOCUMENT_FRAGMENT_NODE;
    ntDocument_Type_Decl_Node: Result := DOCUMENT_TYPE_NODE;
    ntXPath_Namespace_Node: Result := ATTRIBUTE_NODE;
  end;
end;

function Tox4DOMNode.get_nodeValue: DOMString;
begin
  Result := NativeNode.NodeValue;
end;

function Tox4DOMNode.get_ownerDocument: IDOMDocument;
begin
  if not Assigned(FOwnerDocument) then
    FOwnerDocument := Tox4DOMDocument.Create(GlobalOx4DOM,
      NativeNode.OwnerDocument as TDomDocumentXpath, False);
  Result := FOwnerDocument;
end;

function Tox4DOMNode.get_parentNode: IDOMNode;
begin
  Result := MakeNode(NativeNode.ParentNode, FWrapperDocument);
end;

function Tox4DOMNode.get_prefix: DOMString;
begin
  Result := NativeNode.Prefix;
end;

function Tox4DOMNode.get_previousSibling: IDOMNode;
begin
  Result := MakeNode(NativeNode.PreviousSibling, FWrapperDocument);
end;

function Tox4DOMNode.GetNativeNode: TdomNode;
begin
  Result := NativeNode;
end;

function Tox4DOMNode.hasChildNodes: WordBool;
begin
  Result := NativeNode.HasChildNodes;
end;

function Tox4DOMNode.insertBefore(const newChild, refChild: IDOMNode): IDOMNode;
var
  xdnNewChild: TDomNode;
begin
  xdnNewChild := GetNativeNodeOfIntfNode(newChild);
  Result := MakeNode(NativeNode.InsertBefore(xdnNewChild,
    GetNativeNodeOfIntfNode(refChild)), FWrapperDocument);

  CheckNamespaceDeclaration(xdnNewChild);
end;

procedure Tox4DOMNode.normalize;
begin
  NativeNode.normalize;
end;

function Tox4DOMNode.removeChild(const childNode: IDOMNode): IDOMNode;
begin
  Result := MakeNode(NativeNode.RemoveChild(GetNativeNodeOfIntfNode(childNode)), FWrapperDocument);
end;

function Tox4DOMNode.replaceChild(const newChild, oldChild: IDOMNode): IDOMNode;
var
  xdnNewChild: TDomNode;
begin
  xdnNewChild := GetNativeNodeOfIntfNode(newChild);
  Result := MakeNode(NativeNode.ReplaceChild(xdnNewChild,
    GetNativeNodeOfIntfNode(oldChild)), FWrapperDocument);

  CheckNamespaceDeclaration(xdnNewChild);
end;

procedure Tox4DOMNode.set_nodeValue(value: DOMString);
begin
  NativeNode.NodeValue := value;
end;

function Tox4DOMNode.supports(const feature, version: DOMString): WordBool;
begin
  {$ifndef UseADomV3_2_Custom}
  // Duplicating what was previously in Xdom v3.
  Result := SameText(feature, 'xml')
    and ((version = '') or (version = '1.0') or (version = '2.0'));
  {$else}
  Result := NativeNode.supports(feature, version);
  {$endif}
end;

{ IDOMNodeSelect }

{$IFDEF NEXTGEN}
function Tox4DOMNode.selectNode(const nodePath: XmlDomString): IDOMNode;
{$ELSE !NEXTGEN}
function Tox4DOMNode.selectNode(const nodePath: XmlDomString): IDOMNode;
{$ENDIF NEXTGEN}
var
  xpath: TXpathExpression;
  xdomText: TDomText;
begin
  Result := nil;
  if not Assigned(WrapperDocument) or not Assigned(WrapperDocument.WrapperDOMImpl) then
    Exit;

  xpath := WrapperDocument.WrapperDOMImpl.FXpath;

  xpath.ContextNode := NativeNode;
  xpath.Expression := nodePath;

  // Storing the context node for OnLookupNamespaceURI.
  AddContextNode(self);
  try

    if xpath.evaluate then
    begin
      if xpath.hasNodeSetResult then
      begin
        // Nodeset.
        FXpathNodeListCopy := MakeNodeList(xpath, WrapperDocument);
        Result := FXpathNodeListCopy[0];
      end
      else if THackXPathExpression(xpath).FXPathResult is TDomXPathNodeSetResult then
        // Nodeset, and no nodes.
        Result := nil
      else
      begin
        // Boolean, number, or string value.
        xdomText := TDomText.Create(nil);
        xdomText.Data := xpath.ResultAsWideString;
        Result := MakeNode(xdomText, nil, True);
      end;
    end;

  finally
    RemoveContextNode(self);
  end;
end;

function Tox4DOMNode.selectNodes(const nodePath: XmlDomString): IDOMNodeList;
var
  xpath: TXpathExpression;
begin
  Result := nil;
  if not Assigned(WrapperDocument) or not Assigned(WrapperDocument.WrapperDOMImpl) then
    Exit;

  xpath := WrapperDocument.WrapperDOMImpl.FXpath;

  xpath.ContextNode := NativeNode;
  xpath.Expression := nodePath;

  // Storing the context node for OnLookupNamespaceURI.
  AddContextNode(self);
  try

    if xpath.evaluate then
      Result := MakeNodeList(xpath, WrapperDocument);

  finally
    RemoveContextNode(self);
  end;
end;

{ IDOMNodeEx Interface }

function Tox4DOMNode.get_text: DOMString;
begin
  Result := NativeNode.TextContent;
end;

procedure Tox4DOMNode.set_text(const Value: DOMString);
var
  Index: Integer;
  txn: TdomText;
begin
  for Index := 0 to NativeNode.ChildNodes.Length - 1 do
    NativeNode.RemoveChild(NativeNode.ChildNodes.Item(Index));

  txn := TdomText.Create(NativeNode.OwnerDocument);
  txn.Data := Value;
  NativeNode.AppendChild(txn);
end;

function Tox4DOMNode.get_xml: DOMString;
var
  parser: TDomToXmlParser;
{$IFDEF NEXTGEN}
  wsResult: string;
{$ELSE !NEXTGEN}
  wsResult: WideString;
{$ENDIF NEXTGEN}
begin
  Result := '';
  parser := AllocParser;
  if not Assigned(parser) then
    Exit;
  try
    if parser.writeToWideString(NativeNode, wsResult) then
      Result := wsResult
    else
      Result := '';
  finally
    parser.DisposeOf;
  end;
end;


procedure Tox4DOMNode.transformNode(const stylesheet: IDOMNode; var output: XmlDomString);
begin
  DOMVendorNotSupported('transformNode', sAdom4XmlVendor); { Do not localize }
end;

procedure Tox4DOMNode.transformNode(const stylesheet: IDOMNode;
  const output: IDOMDocument);
begin
  DOMVendorNotSupported('transformNode', sAdom4XmlVendor); { Do not localize }
end;

{ Tox4DOMNodeList }

constructor Tox4DOMNodeList.Create(ANativeNodeList: TdomNodeList;
  AWrapperOwnerNode: Tox4DOMNode);
begin
  inherited Create;
  FNativeNodeList := ANativeNodeList;
  FNativeXpathNodeSet := nil;
  FWrapperOwnerNode := AWrapperOwnerNode;
end;

constructor Tox4DOMNodeList.Create(AnXpath: TXpathExpression;
  AWrapperOwnerNode: Tox4DOMNode);
begin
  FNativeNodeList := nil;

{$ifndef UseADomV3_2_Custom}
  if THackXPathExpression(AnXpath).FXPathResult.ResultType = XPATH_NODE_SET_TYPE then
  begin
    // Nodeset, but maybe empty.
    FNativeXpathNodeSet := TDomXPathNodeSetResult.Create;
    FNativeXpathNodeSet.Assign(THackXPathExpression(AnXpath).FXPathResult);
  end
  else
    // Boolean, number or string;
    FNativeXpathNodeSet := TDomXPathStringResult.Create(AnXpath.ResultAsWideString);
{$else}
  if THackXPathExpression(AnXpath).FXPathResult.ResultType = XPATH_NODE_SET_TYPE then
    // Nodeset, but maybe empty.
    FNativeXpathNodeSet := AnXpath.acquireXPathResult(TdomXPathNodeSetResult)
  else
    // Boolean, number or string;
    FNativeXpathNodeSet := AnXpath.acquireXPathResult(TDomXPathStringResult);
{$endif}
  FWrapperOwnerNode := AWrapperOwnerNode;
end;

destructor Tox4DOMNodeList.Destroy;
begin
  FNativeXpathNodeSet.Free;
  inherited;
end;

function Tox4DOMNodeList.get_item(index: Integer): IDOMNode;
var
  xdomNode: TDomNode;
  xdomText: TDomText;
begin
  if Assigned(NativeNodeList) then
    Result := MakeNode(NativeNodeList.Item(index), FWrapperOwnerNode.WrapperDocument)
  else if Assigned(FNativeXpathNodeSet) then
  begin
    if FNativeXpathNodeSet.ResultType = XPATH_NODE_SET_TYPE then
    begin
      xdomNode := FNativeXpathNodeSet.item(index);
      if Assigned(FWrapperOwnerNode.WrapperDocument)
        and (xdomNode = FWrapperOwnerNode.WrapperDocument.NativeDocument) then
        Result := FWrapperOwnerNode.WrapperDocument // Xpath '/' case.
      else
        Result := MakeNode(xdomNode, FWrapperOwnerNode.WrapperDocument);
    end
    else
    begin
      // Single value (number/boolean/string)
      xdomText := TDomText.Create(nil);
      xdomText.Data := FNativeXpathNodeSet.AsWideString;
      Result := MakeNode(xdomText, nil, True);
    end;
  end
  else
    Result := nil;
end;

function Tox4DOMNodeList.get_length: Integer;
begin
  if Assigned(NativeNodeList) then
    Result := NativeNodeList.Length
  else if Assigned(FNativeXpathNodeSet) then
  begin
    if FNativeXpathNodeSet.ResultType = XPATH_NODE_SET_TYPE then
      Result := FNativeXpathNodeSet.length
    else
      // Single value (number/boolean/string)
      Result := 1;
  end
  else
    Result := 0;
end;

{ Tox4DOMNamedNodeMap }

constructor Tox4DOMNamedNodeMap.Create(ANativeNamedNodeMap: TdomNamedNodeMap;
  AWrapperOwnerNode: Tox4DOMNode);
begin
  inherited Create;
  FNativeNamedNodeMap := ANativeNamedNodeMap;
  FWrapperOwnerNode := AWrapperOwnerNode;
end;

procedure Tox4DOMNamedNodeMap.CheckNamespaceAware;
begin
  if not NativeNamedNodeMap.namespaceAware then
    raise Exception.Create('NamedNodeMap must be namespace-aware.');
end;

function Tox4DOMNamedNodeMap.get_item(index: Integer): IDOMNode;
begin
  Result := MakeNode(NativeNamedNodeMap.Item(index), FWrapperOwnerNode.WrapperDocument);
end;

function Tox4DOMNamedNodeMap.get_length: Integer;
begin
  Result := NativeNamedNodeMap.Length;
end;

function Tox4DOMNamedNodeMap.getNamedItem(const name: DOMString): IDOMNode;
begin
  CheckNamespaceAware;
  Result := MakeNode(NativeNamedNodeMap.GetNamedItemNS('', name), FWrapperOwnerNode.WrapperDocument);
end;

function Tox4DOMNamedNodeMap.getNamedItemNS(const namespaceURI,
  localName: DOMString): IDOMNode;
begin
  CheckNamespaceAware;
  Result := MakeNode(NativeNamedNodeMap.GetNamedItemNS(namespaceURI, localName), FWrapperOwnerNode.WrapperDocument);
end;

function Tox4DOMNamedNodeMap.removeNamedItem(const name: DOMString): IDOMNode;
begin
  CheckNamespaceAware;
  Result := MakeNode(NativeNamedNodeMap.RemoveNamedItemNS('', name), FWrapperOwnerNode.WrapperDocument);
end;

function Tox4DOMNamedNodeMap.removeNamedItemNS(const namespaceURI,
  localName: DOMString): IDOMNode;
begin
  CheckNamespaceAware;
  Result := MakeNode(NativeNamedNodeMap.RemoveNamedItemNS(namespaceURI, localName), FWrapperOwnerNode.WrapperDocument);
end;

function Tox4DOMNamedNodeMap.setNamedItem(const arg: IDOMNode): IDOMNode;
begin
  CheckNamespaceAware;
  Result := MakeNode(NativeNamedNodeMap.SetNamedItemNS(
    GetNativeNodeOfIntfNode(arg)), FWrapperOwnerNode.WrapperDocument);
end;

function Tox4DOMNamedNodeMap.setNamedItemNS(const arg: IDOMNode): IDOMNode;
begin
  CheckNamespaceAware;
  Result := MakeNode(NativeNamedNodeMap.SetNamedItemNS(
    GetNativeNodeOfIntfNode(arg)), FWrapperOwnerNode.WrapperDocument);
end;

{ Tox4DOMCharacterData }

function Tox4DOMCharacterData.GetNativeCharacterData: TdomCharacterData;
begin
  Result := NativeNode as TdomCharacterData;
end;

procedure Tox4DOMCharacterData.appendData(const data: DOMString);
begin
  NativeCharacterData.AppendData(data);
end;

procedure Tox4DOMCharacterData.deleteData(offset, count: Integer);
begin
  NativeCharacterData.DeleteData(offset, count);
end;

function Tox4DOMCharacterData.get_data: DOMString;
begin
  Result := NativeCharacterData.Data;
end;

function Tox4DOMCharacterData.get_length: Integer;
begin
  Result := NativeCharacterData.length;
end;

procedure Tox4DOMCharacterData.insertData(offset: Integer;
  const data: DOMString);
begin
  NativeCharacterData.InsertData(offset, data);
end;

procedure Tox4DOMCharacterData.replaceData(offset, count: Integer;
  const data: DOMString);
begin
  NativeCharacterData.ReplaceData(offset, count, data);
end;

procedure Tox4DOMCharacterData.set_data(const data: DOMString);
begin
  NativeCharacterData.Data := data;
end;

function Tox4DOMCharacterData.substringData(offset, count: Integer): DOMString;
begin
  Result := NativeCharacterData.SubstringData(offset, count);
end;

{ Tox4DOMAttr }

function Tox4DOMAttr.GetNativeAttribute: TdomAttr;
begin
  Result := NativeNode as TdomAttr;
end;

function Tox4DOMAttr.get_name: DOMString;
begin
  Result := NativeAttribute.Name;
end;

function Tox4DOMAttr.get_ownerElement: IDOMElement;
begin
  Result := MakeNode(NativeAttribute.OwnerElement, Self.WrapperDocument) as IDOMElement;
end;

function Tox4DOMAttr.get_specified: WordBool;
begin
  Result := NativeAttribute.Specified;
end;

function Tox4DOMAttr.get_value: DOMString;
begin
  Result := NativeAttribute.Value;
end;

procedure Tox4DOMAttr.set_value(const attributeValue: DOMString);
begin
  NativeAttribute.nodeValue := attributeValue;
end;

{ Tox4DOMElement }

procedure Tox4DOMElement.CheckNamespaceAware;
begin
  if not NativeElement.attributes.namespaceAware then
    raise Exception.Create('Element must be namespace-aware.');
end;

function Tox4DOMElement.GetNativeElement: TdomElement;
begin
  Result := NativeNode as TdomElement;
end;

function Tox4DOMElement.get_tagName: DOMString;
begin
  Result := NativeElement.TagName;
end;

function Tox4DOMElement.getAttribute(const name: DOMString): DOMString;
begin
  Result := NativeElement.getAttributeNSLiteralValue('', name);
end;

function Tox4DOMElement.getAttributeNode(const name: DOMString): IDOMAttr;
begin
  Result := MakeNode(NativeElement.GetAttributeNodeNS('', name), Self.WrapperDocument) as IDOMAttr;
end;

function Tox4DOMElement.getAttributeNodeNS(const namespaceURI,
  localName: DOMString): IDOMAttr;
begin
  Result := MakeNode(NativeElement.GetAttributeNodeNS(namespaceURI, localName), Self.WrapperDocument)
    as IDOMAttr;
end;

function Tox4DOMElement.getAttributeNS(const namespaceURI,
  localName: DOMString): DOMString;
begin
  Result := NativeElement.getAttributeNSLiteralValue(namespaceURI, localName);
end;

function Tox4DOMElement.getElementsByTagName(const name: DOMString):
  IDOMNodeList;
begin
  Result := MakeNodeList(NativeElement.GetElementsByTagName(name), Self.WrapperDocument);
end;

function Tox4DOMElement.getElementsByTagNameNS(const namespaceURI,
  localName: DOMString): IDOMNodeList;
begin
  Result := MakeNodeList(NativeElement.GetElementsByTagNameNS(
    namespaceURI, localName), Self);
end;

function Tox4DOMElement.hasAttribute(const name: DOMString): WordBool;
begin
  Result := NativeElement.hasAttributeNS('', name);
end;

function Tox4DOMElement.hasAttributeNS(const namespaceURI,
  localName: DOMString): WordBool;
begin
  Result := NativeElement.hasAttributeNS(namespaceURI, localName);
end;

procedure Tox4DOMElement.removeAttribute(const name: DOMString);
begin
  NativeElement.RemoveAttributeNS('', name);
end;

function Tox4DOMElement.removeAttributeNode(const oldAttr: IDOMAttr): IDOMAttr;
begin
  Result := MakeNode(NativeElement.RemoveAttributeNode(
    GetNativeNodeOfIntfNode(oldAttr) as TdomAttr), Self.WrapperDocument) as IDOMAttr;
end;

procedure Tox4DOMElement.removeAttributeNS(const namespaceURI,
  localName: DOMString);
begin
  NativeElement.RemoveAttributeNS(namespaceURI, localName);
end;

procedure Tox4DOMElement.setAttribute(const name, value: DOMString);
begin
  CheckNamespaceAware;
  NativeElement.setAttributeNS('', name, value);
end;

function Tox4DOMElement.setAttributeNode(const newAttr: IDOMAttr): IDOMAttr;
begin
  CheckNamespaceAware;
  Result := MakeNode(NativeElement.SetAttributeNodeNS(
    GetNativeNodeOfIntfNode(newAttr) as TdomAttr), Self.WrapperDocument) as IDOMAttr;
end;

function Tox4DOMElement.setAttributeNodeNS(const newAttr: IDOMAttr): IDOMAttr;
begin
  CheckNamespaceAware;
  Result := MakeNode(NativeElement.SetAttributeNodeNS(
    GetNativeNodeOfIntfNode(newAttr) as TdomAttr), Self.WrapperDocument) as IDOMAttr;
end;

procedure Tox4DOMElement.setAttributeNS(const namespaceURI, qualifiedName,
  value: DOMString);
var
  Attr: TDomAttr;
{$IFDEF NEXTGEN}
  Prfx, Localname: string;
{$ELSE !NEXTGEN}
  Prfx, Localname: WideString;
{$ENDIF NEXTGEN}
begin
  CheckNamespaceAware;

  Attr := nil;
  if XmlExtractPrefixAndLocalName(qualifiedName, Prfx, LocalName) then
    Attr := NativeElement.GetAttributeNodeNS(namespaceURI, LocalName);
  if Assigned(Attr) and (namespaceURI = SXMLNamespaceURI) then
  begin
    if (Attr.Prefix = Prfx) and (Attr.LocalName = LocalName) and (Attr.value = value) then
      // The exact same xmlns node already exists: Skip setting it.
      Exit;
  end;

  if Assigned(Attr) then
    Attr.NodeValue := value
  else
    Attr := NativeElement.SetAttributeNS(namespaceURI, qualifiedName, value);
  CheckNamespaceDeclaration(Attr);
end;

function Tox4DOMElement._AddRef: Integer;
begin
  Result := inherited _AddRef;
end;

function Tox4DOMElement._Release: Integer;
begin
  Result := inherited _Release;
end;

procedure Tox4DOMElement.normalize;
begin
  NativeElement.normalize;
end;

{ Tox4DOMText }

function Tox4DOMText.splitText(offset: Integer): IDOMText;
begin
  Result := MakeNode((NativeNode as TdomText).SplitText(offset), Self.WrapperDocument) as IDOMText;
end;

{ Tox4DOMDocumentType }

constructor Tox4DOMDocumentType.Create(ANativeNode: TdomNode; WrapperDocument: Tox4DOMDocument);
begin
  inherited Create(ANativeNode, WrapperDocument);
  FWrapperDocumentTypeChildren := Tox4DOMDocumentTypeChildren.Create(Self);
  FWrapperDocumentTypeChildren._AddRef;
end;

destructor Tox4DOMDocumentType.Destroy;
begin
  FWrapperDocumentTypeChildren._Release;
  inherited Destroy;
end;

function Tox4DOMDocumentType.GetNativeDocumentType: TDomDocumentTypeDecl;
begin
  Result := NativeNode as TDomDocumentTypeDecl;
end;

function Tox4DOMDocumentType.get_childNodes: IDOMNodeList;
begin
  Result := FWrapperDocumentTypeChildren;
end;

function Tox4DOMDocumentType.get_entities: IDOMNamedNodeMap;
begin
  // Empty list. Can't grab entities from here, only from TDomDocument.ValidationAgent.
  if not Assigned(FEntities) then
  begin
    FDummyEntitiesList := TList<XML.Internal.TreeUtils.TCustomOwnedNode>.Create;
    FDummyEntities := TdomNamedNodeMap.Create(NativeNode, FDummyEntitiesList, [], False);
    FEntities := MakeNamedNodeMap(FDummyEntities, Self);
  end;

  Result := FEntities;
end;

function Tox4DOMDocumentType.get_internalSubset: DOMString;
begin
  Result := NativeDocumentType.InternalSubset;
end;

function Tox4DOMDocumentType.get_name: DOMString;
begin
  Result := NativeDocumentType.Name;
end;

function Tox4DOMDocumentType.get_notations: IDOMNamedNodeMap;
begin
  // Notations no longer supported.
  if not Assigned(FNotations) then
  begin
    FDummyNotationsList := TList<TCustomOwnedNode>.Create;
    FDummyNotations := TdomNamedNodeMap.Create(NativeNode, FDummyNotationsList, [], False);
    FNotations := MakeNamedNodeMap(FDummyNotations, Self);
  end;

  Result := FNotations;
end;

function Tox4DOMDocumentType.get_publicId: DOMString;
begin
  Result := NativeDocumentType.PublicId;
end;

function Tox4DOMDocumentType.get_systemId: DOMString;
begin
  Result := NativeDocumentType.SystemId;
end;

function Tox4DOMDocumentType.hasChildNodes: WordBool;
begin
  Result := (get_childNodes.Length > 0);
end;

{ Tox4DOMDocumentTypeChildren }

constructor Tox4DOMDocumentTypeChildren.Create(NativeDocumentType: Tox4DOMDocumentType);
begin
  inherited Create;
  FWrapperOwnerDocumentType := NativeDocumentType;
end;

function Tox4DOMDocumentTypeChildren.get_item(index: Integer): IDOMNode;
var
  Len: Integer;
begin
  Len := FWrapperOwnerDocumentType.get_entities.length;
  if index < Len then
    Result := FWrapperOwnerDocumentType.get_entities.item[index]
  else if index < Len + FWrapperOwnerDocumentType.get_notations.length then
    Result := FWrapperOwnerDocumentType.get_notations.item[index - len]
  else
    Result := nil;
end;

function Tox4DOMDocumentTypeChildren.get_length: Integer;
begin
  Result :=
    FWrapperOwnerDocumentType.get_entities.length + FWrapperOwnerDocumentType.get_notations.length;
end;

{ Tox4DOMProcessingInstruction }

function Tox4DOMProcessingInstruction.GetNativeProcessingInstruction:
  TdomProcessingInstruction;
begin
  Result := NativeNode as TdomProcessingInstruction;
end;

function Tox4DOMProcessingInstruction.get_data: DOMString;
begin
  Result := NativeProcessingInstruction.Data;
end;

function Tox4DOMProcessingInstruction.get_target: DOMString;
begin
  Result := NativeProcessingInstruction.Target;
end;

procedure Tox4DOMProcessingInstruction.set_data(const value: DOMString);
begin
  NativeProcessingInstruction.Data := value;
end;

{ Tox4DOMXPathNamespace }

constructor Tox4DOMXPathNamespace.Create(ANativeNode: TdomNode;
  AWrapperDocument: Tox4DOMDocument);
begin
  FNativeXPathNamespaceNode := TdomXPathNamespace.Create(nil,
        (ANativeNode as TdomXPathNamespace).OwnerElement,
        (ANativeNode as TdomXPathNamespace).NamespaceURI,
        (ANativeNode as TdomXPathNamespace).Prefix);
  inherited Create(FNativeXPathNamespaceNode, AWrapperDocument);
end;

destructor Tox4DOMXPathNamespace.Destroy;
begin
  inherited;
  FNativeXPathNamespaceNode.Free;
end;

function Tox4DOMXPathNamespace.GetNativeXPathNamespace: TdomXPathNamespace;
begin
  Result := NativeNode as TdomXPathNamespace;
end;

function Tox4DOMXPathNamespace.get_localName: DOMString;
begin
  Result := NativeXPathNamespace.prefix;
end;

function Tox4DOMXPathNamespace.get_namespaceURI: DOMString;
begin
  Result := NativeXPathNamespace.namespaceURI;
end;

function Tox4DOMXPathNamespace.get_nodeName: DOMString;
begin
  Result := 'xmlns:' + NativeXPathNamespace.namespaceURI;
end;

function Tox4DOMXPathNamespace.get_nodeValue: DOMString;
begin
  Result := NativeXPathNamespace.namespaceURI;
end;

function Tox4DOMXPathNamespace.get_prefix: DOMString;
begin
  Result := NativeXPathNamespace.prefix;
end;

procedure Tox4DOMXPathNamespace.set_nodeValue(value: DOMString);
begin
  // Cannot set the value of this Xpath result node.
end;

{ Tox4DOMDocument }

constructor Tox4DOMDocument.Create(AWrapperDOMImpl: Tox4DOMImplementation;
  ANativeDoc: TDomDocumentXpath; DocIsOwned: Boolean);
begin
  FDocIsOwned := DocIsOwned;
  FWrapperDOMImpl := AWrapperDOMImpl;
  FPreserveWhitespace := True;
  FDeclareNamespaces := True;
  inherited Create(ANativeDoc, Self);
end;

destructor Tox4DOMDocument.Destroy;
begin
  if FDocIsOwned and Assigned(FWrapperDOMImpl) and Assigned(FNativeNode) then
    FWrapperDOMImpl.FreeDocument(TDomDocument(FNativeNode));
  inherited Destroy;
end;

function Tox4DOMDocument.GetNativeDocument: TDomDocumentXpath;
begin
  Result := NativeNode as TDomDocumentXpath;
end;

function Tox4DOMDocument.createAttribute(const name: DOMString): IDOMAttr;
begin
  Result := Tox4DOMAttr.Create(TdomAttr.CreateNS(NativeDocument, '', name, True), self);
end;

function Tox4DOMDocument.createAttributeNS(const namespaceURI,
  qualifiedName: DOMString): IDOMAttr;
begin
  Result := Tox4DOMAttr.Create(
    TdomAttr.CreateNS(NativeDocument, namespaceURI, qualifiedName, True), self);
end;

function Tox4DOMDocument.createCDATASection(const data: DOMString):
  IDOMCDATASection;
begin
  Result := Tox4DOMCDATASection.Create(TdomCDATASection.Create(NativeDocument), self);
  Result.data := data;
end;

function Tox4DOMDocument.createComment(const data: DOMString): IDOMComment;
var
  comm: TdomComment;
begin
  comm := TdomComment.Create(NativeDocument);
  comm.Data := data;
  Result := Tox4DOMComment.Create(comm, self);
end;

function Tox4DOMDocument.createDocumentFragment: IDOMDocumentFragment;
begin
  Result := Tox4DOMDocumentFragment.Create(TDomDocumentFragment.Create(NativeDocument), self);
end;

function Tox4DOMDocument.createElement(const tagName: DOMString): IDOMElement;
begin
  Result := Tox4DOMElement.Create(TdomElement.CreateNS(NativeDocument, '', tagName), self);
end;

function Tox4DOMDocument.createElementNS(const namespaceURI,
  qualifiedName: DOMString): IDOMElement;
begin
  Result := Tox4DOMElement.Create(
    TdomElement.CreateNS(NativeDocument, namespaceURI, qualifiedName), self);
end;

function Tox4DOMDocument.createEntityReference(const name: DOMString):
  IDOMEntityReference;
begin
  Result := Tox4DOMEntityReference.Create(
    TdomEntityReference.Create(NativeDocument, name), self);
end;

function Tox4DOMDocument.createProcessingInstruction(const target,
  data: DOMString): IDOMProcessingInstruction;
var
  pi: TdomProcessingInstruction;
begin
  pi := TdomProcessingInstruction.Create(NativeDocument, target);
  pi.Data := data;
  Result := Tox4DOMProcessingInstruction.Create(pi, self);
end;

function Tox4DOMDocument.createTextNode(const data: DOMString): IDOMText;
var
  text: TdomText;
begin
  text := TdomText.Create(NativeDocument);
  text.Data := data;
  Result := Tox4DOMText.Create(text, self);
end;

function Tox4DOMDocument.get_doctype: IDOMDocumentType;
begin
  Result := Tox4DOMDocumentType.Create(NativeDocument.DoctypeDecl, Self);
end;

function Tox4DOMDocument.get_documentElement: IDOMElement;
begin
  if not Assigned(FDocumentElement) or
    (FNativeDocumentElement <> NativeDocument.documentElement) then { Test if underlying document NativeElement changed }
  begin
    FNativeDocumentElement := NativeDocument.documentElement;
    FDocumentElement := MakeNode(FNativeDocumentElement, Self) as IDOMElement;
  end;
  Result := FDocumentElement;
end;

function Tox4DOMDocument.get_domImplementation: IDOMImplementation;
begin
  Result := FWrapperDOMImpl;
end;

function Tox4DOMDocument.getElementById(const elementId: DOMString): IDOMElement;
begin
  Result := Tox4DOMElement.Create(NativeDocument.GetElementById(elementId), Self);
end;

function Tox4DOMDocument.getElementsByTagName(const tagName: DOMString): IDOMNodeList;
begin
  Result := MakeNodeList(NativeDocument.GetElementsByTagNameNS('', tagName), Self);
end;

function Tox4DOMDocument.getElementsByTagNameNS(const namespaceURI,
  localName: DOMString): IDOMNodeList;
begin
  Result := MakeNodeList(NativeDocument.GetElementsByTagNameNS(
    namespaceURI, localName), Self);
end;

function Tox4DOMDocument.importNode(importedNode: IDOMNode; deep: WordBool):
  IDOMNode;
begin
  Result := MakeNode(NativeDocument.ImportNode(
    GetNativeNodeOfIntfNode(importedNode), deep), Self);
end;

procedure Tox4DOMDocument.set_documentElement(const DOMElement: IDOMElement);
begin
  if Assigned(DOMElement) then
  begin
    if Assigned(NativeDocument.documentElement) then
      NativeDocument.replaceChild(GetNativeNodeOfIntfNode(DOMElement),
        NativeDocument.documentElement)
    else
      NativeDocument.appendChild(GetNativeNodeOfIntfNode(DOMElement));
  end
  else if Assigned(NativeDocument.documentElement) then
      NativeDocument.removeChild(NativeDocument.documentElement);
  FDocumentElement := nil;
end;

{ IDOMParseOptions Interface }

function Tox4DOMDocument.get_async: Boolean;
begin
  Result := False;
end;

function Tox4DOMDocument.get_preserveWhiteSpace: Boolean;
begin
  Result := True;
end;

function Tox4DOMDocument.get_resolveExternals: Boolean;
begin
  Result := False;
end;

function Tox4DOMDocument.get_validate: Boolean;
begin
  Result := False;
end;

procedure Tox4DOMDocument.set_async(Value: Boolean);
begin
  if Value then
    DOMVendorNotSupported('set_async(True)', sAdom4XmlVendor); { Do not localize }
end;

procedure Tox4DOMDocument.set_preserveWhiteSpace(Value: Boolean);
begin
  FPreserveWhitespace := Value;
end;

procedure Tox4DOMDocument.set_resolveExternals(Value: Boolean);
begin
  if Value then
    DOMVendorNotSupported('set_resolveExternals(True)', sAdom4XmlVendor); { Do not localize }
end;

procedure Tox4DOMDocument.set_validate(Value: Boolean);
begin
  if Value then
    DOMVendorNotSupported('set_validate(True)', sAdom4XmlVendor); { Do not localize }
end;

{ IDOMPersist interface }

function Tox4DOMDocument.get_xml: DOMString;
var
  parser: TDomToXmlParser;
{$IFDEF NEXTGEN}
  wsResult: string;
{$ELSE !NEXTGEN}
  wsResult: WideString;
{$ENDIF NEXTGEN}
begin
  Result := '';
  parser := AllocParser;
  if Assigned(parser) then
  try
    parser.IncludeXmlDecl := false;
    parser.UseByteOrderMark := [];
    if parser.writeToWideString(NativeDocument, wsResult) then
      Result := wsResult;
  finally
    parser.Free;
  end;
end;

{$IFNDEF MSWINDOWS}
procedure LoadFromURL(URL: string; Stream: TStream);
{$IFDEF USE_INDY}
var
  IndyHTTP: TIDHttp;
begin
  IndyHTTP := TIDHttp.Create(Nil);
  try
    IndyHttp.Request.Accept := 'text/xml, text/html, application/octet-stream'; { Do not localize }
    IndyHttp.Request.UserAgent := 'Mozilla/3.0 (compatible; Indy Library)'; { Do not localize }
    IndyHttp.Request.ContentType := 'text/xml';   { Do not localize }
    IndyHttp.Request.URL := URL;
    IndyHttp.Request.Connection := URL;
    IndyHttp.Intercept := Nil;
    IndyHTTP.Get(Url, Stream);
  finally
    IndyHTTP.Free;
  end;
end;
{$ELSE}
begin
                                                  
  raise DOMException.Create('LoadFromURL not enable for non-windows platforms currently');
end;
{$ENDIF}
{$ENDIF}

{$IFDEF MSWINDOWS}
var
  UrlMonHandle: HMODULE;
  URLDownloadToCacheFile: function(Caller: IUnknown; URL: PChar;
    FileName: PChar; FileNameBufLen: DWORD; Reserved: DWORD;
    StatusCB: IInterface {IBindStatusCallback}): HResult; stdcall = nil;

procedure LoadFromURL(URL: string; Stream: TMemoryStream);

  procedure InitURLMon;
  const
    UrlMonLib = 'URLMON.DLL';                             { Do not localize }
    {$IFDEF UNICODE}
    sURLDownloadToCacheFile = 'URLDownloadToCacheFileW';  { Do not localize }
    {$ELSE}
    sURLDownloadToCacheFile = 'URLDownloadToCacheFileA';  { Do not localize }
    {$ENDIF}
  begin
    if not Assigned(URLDownloadToCacheFile) then
    begin
      UrlMonHandle := LoadLibrary(UrlMonLib);
      if UrlMonHandle = 0 then
        raise Exception.CreateResFmt(@SUrlMonDllMissing, [UrlMonLib]);
      URLDownloadToCacheFile := GetProcAddress(UrlMonHandle, sURLDownloadToCacheFile);
    end;
  end;

var
  FileName: array[0..MAX_PATH] of Char;
begin
  InitURLMon;
  if URLDownloadToCacheFile(nil, PChar(URL), FileName, Length(FileName), 0, nil) <> S_OK then
    raise Exception.CreateResFmt(@SErrorDownloadingURL, [URL]);
  Stream.LoadFromFile(FileName);
end;
{$ENDIF}

function Tox4DOMDocument.load(source: OleVariant): WordBool;
var
  Stream: TMemoryStream;
begin
  if VarType(source) = varOleStr then
  begin
    Stream:= TMemoryStream.create;
    try
{$IFDEF NEXTGEN}
      if string(Source).StartsWith('http://', True) then   { do not localize }
{$ELSE !NEXTGEN}
      if LowerCase(Copy(Source, 1, 7)) = 'http://' then   { do not localize }
{$ENDIF NEXTGEN}
        LoadFromURL(Source, Stream)
      else
        Stream.LoadFromFile(Source);
      result:= loadFromStream(Stream);
    finally
      Stream.free;
    end;
  end
  else
    DOMVendorNotSupported('load(object)', sAdom4XmlVendor); { Do Not Localize }
end;

function Tox4DOMDocument.loadxml(const Value: TXMLFileName): WordBool;
begin
  Result := WrapperDOMImpl.loadxml(Value, self, FParseError);
end;

function Tox4DOMDocument.loadFromStream(const stream: TStream): WordBool;
begin
  Result := WrapperDOMImpl.loadFromStream(stream, Self, FParseError);
end;

procedure Tox4DOMDocument.save(destination: OleVariant);
var
  FStream: TFileStream;
begin
  if VarType(destination) = varOleStr then
  begin
    FStream := TFileStream.Create(destination, fmCreate);
    try
      saveToStream(FStream);
    finally
      FStream.Free;
    end;
  end
  else
    DOMVendorNotSupported('save(object)', sAdom4XmlVendor); { Do Not Localize }
end;

procedure Tox4DOMDocument.saveToStream(const stream: TStream);
var
  parser: TDomToXmlParser;
begin
  parser := AllocParser;
  if not Assigned(parser) then
    Exit;
  try

    if NativeDocument.xmlEncoding = '' then
      parser.writeToStream(NativeDocument, 'UTF-8', stream)
    else
      parser.writeToStream(NativeDocument, NativeDocument.xmlEncoding, stream);

  finally
    parser.Free;
  end;
end;

{$IFDEF WRAPVER1.1}
function Tox4DOMDocument.loadFromStream(const stream: IStream): WordBool;
var
  LStream: TStream;
begin
  LStream := TDOMIStreamAdapter.Create(stream);
  try
    Result := loadFromStream(LStream);
  finally
    LStream.Free;
  end;
end;

procedure Tox4DOMDocument.saveToStream(const stream: IStream);
var
  LStream: TStream;
begin
  LStream := TDOMIStreamAdapter.Create(stream);
  try
    SaveToStream(LStream);
  finally
    LStream.Free;
  end;
end;
{$ENDIF}

{ IDOMParseError }

function Tox4DOMDocument.get_errorCode: Integer;
begin
  Result := FParseError.errorCode;
end;

function Tox4DOMDocument.get_filepos: Integer;
begin
  Result := FParseError.filePos;
end;

function Tox4DOMDocument.get_line: Integer;
begin
  Result := FParseError.line;
end;

function Tox4DOMDocument.get_linepos: Integer;
begin
  Result := FParseError.linePos;
end;

function Tox4DOMDocument.get_reason: DOMString;
begin
  Result := FParseError.reason;
end;

function Tox4DOMDocument.get_srcText: DOMString;
begin
  Result := FParseError.srcText;
end;

function Tox4DOMDocument.get_url: DOMString;
begin
  Result := FParseError.url;
end;

function Tox4DOMDocument.asyncLoadState: Integer;
begin
  result := 0; { Not Supported }
end;

procedure Tox4DOMDocument.set_OnAsyncLoad(const Sender: TObject;
  EventHandler: TAsyncEventHandler);
begin
  DOMVendorNotSupported('set_OnAsyncLoad', sAdom4XmlVendor); { Do Not Localize }
end;

{ IDOMXMLProlog }

function Tox4DOMDocument.get_Encoding: DOMString;
begin
  Result := NativeDocument.xmlEncoding;
end;

procedure Tox4DOMDocument.set_Encoding(const Value: DOMString);
begin
  NativeDocument.xmlEncoding := Value;
end;

function Tox4DOMDocument.get_Standalone: DOMString;
begin
  case NativeDocument.xmlStandalone of
    STANDALONE_YES: Result := 'yes';
    STANDALONE_NO: Result := 'no';
    STANDALONE_UNSPECIFIED: Result := '';
  end;
end;

procedure Tox4DOMDocument.set_Standalone(const Value: DOMString);
begin
  if Value = 'yes' then
    NativeDocument.xmlStandalone := STANDALONE_YES
  else if Value = 'no' then
    NativeDocument.xmlStandalone := STANDALONE_NO
  else
    NativeDocument.xmlStandalone := STANDALONE_UNSPECIFIED;
end;

function Tox4DOMDocument.get_Version: DOMString;
begin
  Result := NativeDocument.xmlVersion;
end;

procedure Tox4DOMDocument.set_Version(const Value: DOMString);
begin
  NativeDocument.xmlVersion := Value;
end;

procedure Tox4DOMDocument.RemoveWhiteSpaceNodes;

  procedure PossiblyDeleteWhiteSpaceNode(dn: TdomNode);
  begin
    if Assigned(dn)
      and (NormalizeWhiteSpace(dn.nodeValue) = '') then
      dn.DisposeOf;
  end;

var
  nit: TdomNodeIterator;
  dnPrev, dnCurr: TdomNode;
begin
  get_DocumentElement;
  nit := TdomNodeIterator.create(FNativeDocumentElement, [ntText_Node], nil, True);
  dnPrev := nil;
  try

    repeat
      dnCurr := nit.nextNode;
      if not Assigned(dnCurr) then
        break;

      PossiblyDeleteWhiteSpaceNode(dnPrev);
      dnPrev := dnCurr;
    until False;

    PossiblyDeleteWhiteSpaceNode(dnPrev);

  finally
    nit.Free;
  end;
end;

{ Tox4DOMImplementationFactory }

function Tox4DOMImplementationFactory.DOMImplementation: IDOMImplementation;
begin
  if not Assigned(GlobalOx4DOM) then
  begin
    GlobalOx4DOM := Tox4DOMImplementation.Create;
    FGlobalDOMImpl := GlobalOx4DOM;
  end;
  Result := FGlobalDOMImpl;
end;

function Tox4DOMImplementationFactory.Description: String;
begin
  Result := sAdom4XmlVendor;
end;

initialization
  InitContextNodes;

  OpenXML4Factory := Tox4DOMImplementationFactory.Create;
  RegisterDOMVendor(OpenXML4Factory);
finalization
{$IFDEF MSWINDOWS}
  URLDownloadToCacheFile := nil;
  if UrlMonHandle <> 0 then
    FreeLibrary(UrlMonHandle);
{$ENDIF}
  UnRegisterDOMVendor(OpenXML4Factory);
  OpenXML4Factory.Free;

  FreeContextNodes;
end.
