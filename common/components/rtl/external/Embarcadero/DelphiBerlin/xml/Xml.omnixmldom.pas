{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{*******************************************************}
{          Interface wrapper for OmniXML                }
{*******************************************************}
unit Xml.omnixmldom;

interface

uses
  System.Classes, System.SysUtils, System.Types,
{$IF defined(MSWINDOWS) and not defined(NEXTGEN)}
  Winapi.ActiveX, System.Win.ComObj,
{$ENDIF}
  Xml.xmldom, Xml.Internal.OmniXML;

(*$HPPEMIT END '#pragma startup OmniUnitInitialization 65' *)
procedure OmniUnitInitialization;

const
  sOmniXmlVendor = 'Omni XML';

type

{ IOXMLDOMNodeRef }

  IOXMLDOMNodeRef = interface
    ['{D278AAEE-0F97-446A-BBF6-69470F5F188C}']
    function GetXMLNode: OmniIXMLNode;
  end;

                  

  TODOMInterface = class(TInterfacedObject)
  public
    function SafeCallException(ExceptObject: TObject; ExceptAddr: Pointer): HRESULT; override;
  end;

                       

 TODOMImplementation = class(TODOMInterface, IDOMImplementation)
  protected
     { IDOMImplementation }
    function hasFeature(const feature, version: DOMString): WordBool;
    function createDocumentType(const qualifiedName, publicId,
      systemId: DOMString): IDOMDocumentType; safecall;
    function createDocument(const namespaceURI, qualifiedName: DOMString;
      doctype: IDOMDocumentType): IDOMDocument; safecall;
  public
    constructor Create;
  end;

              

 TODOMDocument = class;

 TODOMNode = class(TODOMInterface, IOXMLDOMNodeRef, IDOMNode, IDOMNodeEx, IDOMNodeSelect)
  private
    FNativeNode: OmniIXMLNode;
    FOwnerDocument: IDOMDocument;
    FChildNodes: IDOMNodeList;
    FAttributes: IDOMNamedNodeMap;
  protected
    { IOXMLDOMNodeRef }
    function GetXMLNode: OmniIXMLNode;
    { IDOMNode }
    function get_nodeName: DOMString; safecall;
    function get_nodeValue: DOMString; safecall;
    procedure set_nodeValue(value: DOMString); overload; safecall;
    function get_nodeType: DOMNodeType; safecall;
    function get_parentNode: IDOMNode; safecall;
    function get_childNodes: IDOMNodeList; virtual; safecall;
    function get_firstChild: IDOMNode; safecall;
    function get_lastChild: IDOMNode; safecall;
    function get_previousSibling: IDOMNode; safecall;
    function get_nextSibling: IDOMNode; safecall;
    function get_attributes: IDOMNamedNodeMap; safecall;
    function get_ownerDocument: IDOMDocument; safecall;
    function get_namespaceURI: DOMString; safecall;
    function get_prefix: DOMString; safecall;
    function get_localName: DOMString; safecall;
    function insertBefore(const newChild, refChild: IDOMNode): IDOMNode; safecall;
    function replaceChild(const newChild, oldChild: IDOMNode): IDOMNode; safecall;
    function removeChild(const childNode: IDOMNode): IDOMNode; safecall;
    function appendChild(const newChild: IDOMNode): IDOMNode; safecall;
    function hasChildNodes: WordBool; virtual; safecall;
    function cloneNode(deep: WordBool): IDOMNode; safecall;
    procedure normalize; safecall;
    function supports(const feature, version: DOMString): WordBool;
    { IDOMNodeEx }
    function get_text: DOMString; safecall;
    function get_xml: DOMString; safecall;
    procedure set_text(const Value: DOMString); safecall;
    procedure transformNode(const stylesheet: IDOMNode; var output: XmlDomString); overload; safecall;
    procedure transformNode(const stylesheet: IDOMNode; const output: IDOMDocument); overload; safecall;
    { IDOMNodeSelect }
    function selectNode(const nodePath: XmlDomString): IDOMNode; safecall;
    function selectNodes(const nodePath: XmlDomString): IDOMNodeList; safecall;
  public
    constructor Create(ANativeNode: OmniIXMLNode); virtual;
    destructor Destroy; override;
    property NativeNode: OmniIXMLNode read FNativeNode;
  end;

                 

  TODOMNodeClass = class of TODOMNode;

  TODOMNodeList = class(TODOMInterface, IDOMNodeList)
  private
     FNativeNodeList: OmniIXMLNodeList;
  protected
    { IDOMNodeList }
    function get_item(index: Integer): IDOMNode; safecall;
    function get_length: Integer; safecall;
  public
    constructor Create(const ANativeNodeList: OmniIXMLNodeList); overload;
    constructor Create(const AnXpath: DomString; const AWrapperOwnerNode: TODOMNode); overload;
    destructor Destroy; override;
    property NativeNodeList: OmniIXMLNodeList read FNativeNodeList;
  end;

                     

  TODOMNamedNodeMap = class(TODOMInterface, IDOMNamedNodeMap)
  private
    FNativeNamedNodeMap: OmniIXMLNamedNodeMap;
  protected
    { IDOMNamedNodeMap }
    function get_item(index: Integer): IDOMNode; safecall;
    function get_length: Integer; safecall;
    function getNamedItem(const name: DOMString): IDOMNode; safecall;
    function setNamedItem(const arg: IDOMNode): IDOMNode; safecall;
    function removeNamedItem(const name: DOMString): IDOMNode; safecall;
    function getNamedItemNS(const namespaceURI, localName: DOMString): IDOMNode; safecall;
    function setNamedItemNS(const arg: IDOMNode): IDOMNode; safecall;
    function removeNamedItemNS(const namespaceURI, localName: DOMString): IDOMNode; safecall;
  public
    constructor Create(const ANativeNamedNodeMap: OmniIXMLNamedNodeMap);
    property NativeNamedNodeMap: OmniIXMLNamedNodeMap read FNativeNamedNodeMap;
  end;

                      

  TODOMCharacterData = class(TODOMNode, IDOMCharacterData)
  private
    function GetNativeCharacterData: OmniIXMLCharacterData;
  protected
    { IDOMCharacterData }
    function get_data: DOMString; safecall;
    procedure set_data(const data: DOMString); safecall;
    function get_length: Integer; safecall;
    function substringData(offset, count: Integer): DOMString;  safecall;
    procedure appendData(const data: DOMString);  safecall;
    procedure insertData(offset: Integer; const data: DOMString);  safecall;
    procedure deleteData(offset, count: Integer);  safecall;
    procedure replaceData(offset, count: Integer; const data: DOMString);  safecall;
  public
    property NativeCharacterData: OmniIXMLCharacterData read GetNativeCharacterData;
  end;

             

  TODOMAttr = class(TODOMNode, IDOMAttr)
  private
    function GetNativeAttribute: OmniIXMLAttr;
  protected
    { Property Get/Set }
    function get_name: DOMString;  safecall;
    function get_specified: WordBool;  safecall;
    function get_value: DOMString;  safecall;
    procedure set_value(const attributeValue: DOMString);  safecall;
    function get_ownerElement: IDOMElement;  safecall;
    { Properties }
    property name: DOMString read get_name;
    property specified: WordBool read get_specified;
    property value: DOMString read get_value write set_value;
    property ownerElement: IDOMElement read get_ownerElement;
  public
    property NativeAttribute: OmniIXMLAttr read GetNativeAttribute;
  end;

                

  TODOMElement = class(TODOMNode, IDOMElement)
  private
    function GetNativeElement: OmniIXMLElement;
  protected
    { IDOMElement }
    function get_tagName: DOMString; safecall;
    function getAttribute(const name: DOMString): DOMString; safecall;
    procedure setAttribute(const name, value: DOMString);  safecall;
    procedure removeAttribute(const name: DOMString);  safecall;
    function getAttributeNode(const name: DOMString): IDOMAttr; safecall;
    function setAttributeNode(const newAttr: IDOMAttr): IDOMAttr; safecall;
    function removeAttributeNode(const oldAttr: IDOMAttr): IDOMAttr; safecall;
    function getElementsByTagName(const name: DOMString): IDOMNodeList; safecall;
    function getAttributeNS(const namespaceURI, localName: DOMString): DOMString; safecall;
    procedure setAttributeNS(const namespaceURI, qualifiedName, value: DOMString);  safecall;
    procedure removeAttributeNS(const namespaceURI, localName: DOMString);  safecall;
    function getAttributeNodeNS(const namespaceURI, localName: DOMString): IDOMAttr; safecall;
    function setAttributeNodeNS(const newAttr: IDOMAttr): IDOMAttr; safecall;
    function getElementsByTagNameNS(const namespaceURI, localName: DOMString): IDOMNodeList; safecall;
    function hasAttribute(const name: DOMString): WordBool; safecall;
    function hasAttributeNS(const namespaceURI, localName: DOMString): WordBool;  safecall;
    procedure normalize;  safecall;
  public
    property NativeElement: OmniIXMLElement read GetNativeElement;
  end;

             

  TODOMText = class(TODOMCharacterData, IDOMText)
  protected
    function splitText(offset: Integer): IDOMText; safecall;
  end;

                

  TODOMComment = class(TODOMCharacterData, IDOMComment)
  end;

                     

  TODOMCDATASection = class(TODOMText, IDOMCDATASection)
  end;

                     

  TODOMDocumentType = class(TODOMNode, IDOMDocumentType)
  private
    function GetNativeDocumentType: OmniIXMLDocumentType;
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
    constructor Create(ANativeNode: OmniIXMLNode); override;
    destructor Destroy; override;
    property NativeDocumentType: OmniIXMLDocumentType read GetNativeDocumentType;
  end;

                        

  TODOMEntityReference = class(TODOMNode, IDOMEntityReference)
  end;

                              

  TODOMProcessingInstruction = class(TODOMNode, IDOMProcessingInstruction)
  private
    function GetNativeProcessingInstruction: OmniIXMLProcessingInstruction;
  protected
    { IDOMProcessingInstruction }
    function get_target: DOMString; safecall;
    function get_data: DOMString; safecall;
    procedure set_data(const value: DOMString);  safecall;
  public
    property NativeProcessingInstruction: OmniIXMLProcessingInstruction read GetNativeProcessingInstruction;
  end;

                         

  TODOMDocumentFragment = class(TODOMNode, IDOMDocumentFragment)
  end;

                 

  TODOMDocument = class(TODOMNode, IDOMDocument, IDOMParseOptions, IDOMPersist, IDOMParseError)
  private
    FWrapperDOMImpl: TODOMImplementation;
    FDocumentElement: IDOMElement;
    FNativeDocumentElement: OmniIXMLElement;
    FNativeDocument: OmniIXMLDocument;
  protected
    function GetNativeDocument: OmniIXMLDocument;
    procedure RemoveWhiteSpaceNodes;
    { IDOMDocument }
    function get_doctype: IDOMDocumentType; safecall;
    function get_domImplementation: IDOMImplementation; safecall;
    function get_documentElement: IDOMElement; safecall;
    procedure set_documentElement(const DOMElement: IDOMElement);  safecall;
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
    function getElementById(const elementId: DOMString): IDOMElement;  safecall;
    { IDOMParseOptions }
    function get_async: Boolean;  safecall;
    function get_preserveWhiteSpace: Boolean;  safecall;
    function get_resolveExternals: Boolean;  safecall;
    function get_validate: Boolean;  safecall;
    procedure set_async(Value: Boolean);  safecall;
    procedure set_preserveWhiteSpace(Value: Boolean);  safecall;
    procedure set_resolveExternals(Value: Boolean);  safecall;
    procedure set_validate(Value: Boolean);  safecall;
    { IDOMPersist }
    function get_xml: DOMString; safecall;
    function asyncLoadState: Integer; safecall;
    function load(source: OleVariant): WordBool; safecall;
    function loadFromStream(const stream: TStream): WordBool; overload; safecall;
    function loadxml(const Value: DOMString): WordBool; safecall;
    procedure save(destination: OleVariant); safecall;
    procedure saveToStream(const stream: TStream); overload; safecall;
    procedure set_OnAsyncLoad(const Sender: TObject;
      EventHandler: TAsyncEventHandler); safecall;
    function loadFromStream(const stream: IStream): WordBool; overload; safecall;
    procedure saveToStream(const stream: IStream); overload; safecall;
    { IDOMParseError }
    function get_errorCode: Integer;  safecall;
    function get_url: DOMString; safecall;
    function get_reason: DOMString; safecall;
    function get_srcText: DOMString; safecall;
    function get_line: Integer;  safecall;
    function get_linepos: Integer;  safecall;
    function get_filepos: Integer;  safecall;
  public
    constructor Create(AWrapperDOMImpl: TODOMImplementation; ANativeDoc: OmniIXMLDocument;
      DocIsOwned: Boolean); reintroduce;
    destructor Destroy; override;
    property NativeDocument: OmniIXMLDocument read GetNativeDocument;
    property PreserveWhitespace: Boolean read get_preserveWhiteSpace;
    property WrapperDOMImpl: TODOMImplementation read FWrapperDOMImpl;
  end;

                              

  TODOMImplementationFactory = class(TDOMVendor)
  private
    FGlobalDOMImpl: IDOMImplementation;
  public
    function DOMImplementation: IDOMImplementation; override;
    function Description: String; override;
  end;

var
  OmniXML4Factory: TODOMImplementationFactory;

implementation

uses Xml.Internal.XmlRulesUtils;

resourcestring
  SNodeExpected   = 'NativeNode cannot be null';

var
 GlobalODOM: TODOMImplementation;

procedure OmniUnitInitialization;
begin
end;

{ Utility Functions }

function GetNativeNodeOfIntfNode(const Node: IDOMNode): OmniIXMLNode;
begin
  if not Assigned(Node) then
    raise DOMException.Create(SNodeExpected);
  Result := (Node as IOXMLDOMNodeRef).GetXMLNode;
end;

function MakeNode(const NativeNode: OmniIXMLNode; bOwnAndLaterFreeNativeNode: Boolean = False): IDOMNode;
var
  DnWrapper: TODOMNode;
begin
  if NativeNode = nil then
    Result := nil
  else
  begin
    case NativeNode.NodeType of
      ELEMENT_NODE: DnWrapper := TODOMElement.Create(NativeNode);
      ATTRIBUTE_NODE: DnWrapper := TODOMAttr.Create(NativeNode);
      TEXT_NODE: DnWrapper := TODOMText.Create(NativeNode);
      CDATA_SECTION_NODE: DnWrapper := TODOMCDATASection.Create(NativeNode);
      ENTITY_REFERENCE_NODE: DnWrapper := TODOMEntityReference.Create(NativeNode);
      ENTITY_NODE: dnWrapper := TODOMEntityReference.Create(NativeNode);
      PROCESSING_INSTRUCTION_NODE: dnWrapper :=  TODOMProcessingInstruction.Create(NativeNode);
      COMMENT_NODE: DnWrapper := TODOMComment.Create(NativeNode);
      DOCUMENT_NODE: DnWrapper := TODOMDocument.Create(GlobalODOM, CreateXMLDoc, False);
      DOCUMENT_TYPE_NODE: DnWrapper := TODOMDocumentType.Create(NativeNode);
      DOCUMENT_FRAGMENT_NODE: DnWrapper := TODOMDocumentFragment.Create(NativeNode);
      NOTATION_NODE: raise EXMLException.Create('Invalid operation: cannot clone Notation node');
      else
        DnWrapper := TODOMNode.Create(NativeNode);
    end;
    Result := DnWrapper;
  end;
end;

function MakeNodeList(const NativeNodeList: OmniIXMLNodeList): IDOMNodeList; overload;
begin
  Result := TODOMNodeList.Create(NativeNodeList);
end;

                       

constructor TODOMImplementation.Create;
begin
  inherited;
end;

function TODOMImplementation.hasFeature(const feature, version: DOMString): WordBool;
begin
// Not supported in OmniXML
  Result := False;
end;

function TODOMImplementation.createDocumentType(const qualifiedName, publicId, systemId: DOMString): IDOMDocumentType;
var
  DomDocType: OmniIXMLDocumentType;
begin
  DomDocType := OmniTXMLDocumentType.Create(nil, qualifiedName);
  Result := TODOMDocumentType.Create(DomDocType);
end;

function TODOMImplementation.createDocument(const namespaceURI, qualifiedName: DOMString;
  doctype: IDOMDocumentType): IDOMDocument;
var
  DomDoc: OmniTXMLDocument;
  DomDocType :OmniIXMLDocumentType;
  Intf: IOXMLDOMNodeRef;

begin
  DomDoc := OmniTXMLDocument.Create; // Native Class

  if Supports(doctype, IOXMLDOMNodeRef, Intf) then
    DomDocType := GetNativeNodeOfIntfNode(doctype) as OmniIXMLDocumentType
  else
    DomDocType := nil;

  if Assigned(DomDocType) then
    domDoc.AppendChild(DomDocType);

  Result := TODOMDocument.Create(self, DomDoc, True);
end;

             

function TODOMNode.appendChild(const newChild: IDOMNode): IDOMNode;
var
  XdnNewChild,
  XdnReturnedChild: OmniIXMLNode;
begin
  XdnNewChild := GetNativeNodeOfIntfNode(newChild);
  XdnReturnedChild := NativeNode.appendChild(xdnNewChild);

  if XdnReturnedChild = XdnNewChild then
    Result := newChild
  else
    Result := MakeNode(XdnReturnedChild);
end;

function TODOMNode.cloneNode(deep: WordBool): IDOMNode;
begin
  Result := MakeNode(NativeNode.CloneNode(deep));
end;

constructor TODOMNode.Create(ANativeNode: OmniIXMLNode);
begin
  Assert(Assigned(ANativeNode));
  FNativeNode := ANativeNode;
  FAttributes := nil; //Assigned in get_attributes
  FChildNodes := nil;
  inherited Create;
end;

destructor TODOMNode.Destroy;
begin
  FAttributes := nil;
  FChildNodes := nil;
  FOwnerDocument := nil;
  FNativeNode := nil;
  inherited;
end;

function TODOMNode.GetXMLNode: OmniIXMLNode;
begin
  Result := NativeNode;
end;

function TODOMNode.get_attributes: IDOMNamedNodeMap;
begin
  if not Assigned(FAttributes) then
    FAttributes := TODOMNamedNodeMap.Create(FNativeNode.Attributes);
  Result := FAttributes;
end;

function TODOMNode.get_childNodes: IDOMNodeList;
begin
  if not Assigned(FChildNodes) then
    FChildNodes := MakeNodeList(FNativeNode.ChildNodes);
  Result := FChildNodes;
end;

function TODOMNode.get_firstChild: IDOMNode;
begin
  Result := MakeNode(FNativeNode.FirstChild);
end;

function TODOMNode.get_lastChild: IDOMNode;
begin
  Result := MakeNode(FNativeNode.LastChild);
end;

function TODOMNode.get_localName: DOMString;
begin
  Result := FNativeNode.LocalName;
end;

function TODOMNode.get_namespaceURI: DOMString;
begin
  Result := FNativeNode.NamespaceURI;
end;

function TODOMNode.get_nextSibling: IDOMNode;
begin
  Result := MakeNode(FNativeNode.NextSibling);
end;

function TODOMNode.get_nodeName: DOMString;
begin
  if FNativeNode.NodeType = PROCESSING_INSTRUCTION_NODE then
    Result := (FNativeNode as OmniIXMLProcessingInstruction).Target
  else
    Result := FNativeNode.NodeName;
end;

function TODOMNode.get_nodeType: DOMNodeType;
begin
  case NativeNode.NodeType of
    ELEMENT_NODE: Result := ELEMENT_NODE;
    ATTRIBUTE_NODE: Result := ATTRIBUTE_NODE;
    TEXT_NODE: Result := TEXT_NODE;
    CDATA_SECTION_NODE: Result := CDATA_SECTION_NODE;
    ENTITY_REFERENCE_NODE: Result := ENTITY_REFERENCE_NODE;
    PROCESSING_INSTRUCTION_NODE: Result := PROCESSING_INSTRUCTION_NODE;
    COMMENT_NODE: Result := COMMENT_NODE;
    DOCUMENT_NODE: Result := DOCUMENT_NODE;
    DOCUMENT_TYPE_NODE: Result := DOCUMENT_TYPE_NODE;
    DOCUMENT_FRAGMENT_NODE: Result := DOCUMENT_FRAGMENT_NODE;
  else
    Result := 0;
  end;
end;

function TODOMNode.get_nodeValue: DOMString;
begin
  if FNativeNode.NodeType = PROCESSING_INSTRUCTION_NODE then
    Result := (FNativeNode as OmniIXMLProcessingInstruction).Data
  else
    Result := FNativeNode.NodeValue;
end;

function TODOMNode.get_ownerDocument: IDOMDocument;
begin
  if not Assigned(FOwnerDocument) then
    FOwnerDocument := TODOMDocument.Create(GlobalODOM, NativeNode.OwnerDocument, False);
  Result := FOwnerDocument;
end;

function TODOMNode.get_parentNode: IDOMNode;
begin
  Result := MakeNode(FNativeNode.ParentNode);
end;

function TODOMNode.get_prefix: DOMString;
begin
  Result := FNativeNode.Prefix;
end;

function TODOMNode.get_previousSibling: IDOMNode;
begin
  Result := MakeNode(FNativeNode.PreviousSibling);
end;

function TODOMNode.get_text: DOMString;
begin
  Result := FNativeNode.Text;
end;

function TODOMNode.get_xml: DOMString;
begin
  Result := FNativeNode.XML;
end;

function TODOMNode.hasChildNodes: WordBool;
begin
  Result := FNativeNode.HasChildNodes
end;

function TODOMNode.insertBefore(const newChild, refChild: IDOMNode): IDOMNode;
var
  XdnNewChild: OmniIXMLNode;
begin
  XdnNewChild := GetNativeNodeOfIntfNode(newChild);
  Result := MakeNode(FNativeNode.InsertBefore(XdnNewChild, GetNativeNodeOfIntfNode(refChild)));
end;

procedure TODOMNode.normalize;
begin
// NYI in OmniXML
  DOMVendorNotSupported('normalize', sOmniXmlVendor); { Do not localize }
end;

function TODOMNode.removeChild(const childNode: IDOMNode): IDOMNode;
begin
  Result := MakeNode(FNativeNode.RemoveChild(GetNativeNodeOfIntfNode(childNode)));
end;

function TODOMNode.replaceChild(const newChild, oldChild: IDOMNode): IDOMNode;
var
  XdnNewChild: OmniIXMLNode;
begin
  XdnNewChild := GetNativeNodeOfIntfNode(newChild);
  Result := MakeNode(NativeNode.ReplaceChild(XdnNewChild, GetNativeNodeOfIntfNode(oldChild)));
end;

function TODOMNode.selectNode(const nodePath: XmlDomString): IDOMNode;
begin
  Result := MakeNode(NativeNode.SelectSingleNode(nodePath));
end;

function TODOMNode.selectNodes(const nodePath: XmlDomString): IDOMNodeList;
begin
  Result := MakeNodeList(NativeNode.SelectNodes(nodePath));
end;

procedure TODOMNode.set_nodeValue(value: DOMString);
begin
  FNativeNode.NodeValue := value;
end;

procedure TODOMNode.set_text(const Value: DOMString);
begin
   FNativeNode.Text := Value;
end;

function TODOMNode.supports(const feature, version: DOMString): WordBool;
begin
  Result := SameText(feature, 'xml')
    and ((version = '') or (version = '1.0'));// or (version = '2.0'));
end;

procedure TODOMNode.transformNode(const stylesheet: IDOMNode; const output: IDOMDocument);
begin
  DOMVendorNotSupported('transformNode', sOmniXmlVendor); { Do not localize }
end;


procedure TODOMNode.transformNode(const stylesheet: IDOMNode; var output: XmlDomString);
begin
  DOMVendorNotSupported('transformNode', sOmniXmlVendor); { Do not localize }
end;

                     

constructor TODOMNamedNodeMap.Create(const ANativeNamedNodeMap: OmniIXMLNamedNodeMap);
begin
  inherited Create;
  FNativeNamedNodeMap := ANativeNamedNodeMap;
end;

function TODOMNamedNodeMap.getNamedItem(const name: DOMString): IDOMNode;
begin
  Result := MakeNode(FNativeNamedNodeMap.GetNamedItem(name));
end;

function TODOMNamedNodeMap.getNamedItemNS(const namespaceURI, localName: DOMString): IDOMNode;
begin
  Result := MakeNode(FNativeNamedNodeMap.GetNamedItemNS(namespaceURI, localName));
end;

function TODOMNamedNodeMap.get_item(index: Integer): IDOMNode;
begin
  Result := MakeNode(FNativeNamedNodeMap.Item[index]);
end;

function TODOMNamedNodeMap.get_length: Integer;
begin
  Result := FNativeNamedNodeMap.Length;
end;

function TODOMNamedNodeMap.removeNamedItem(const name: DOMString): IDOMNode;
begin
  Result := MakeNode(FNativeNamedNodeMap.RemoveNamedItem(name));
end;

function TODOMNamedNodeMap.removeNamedItemNS(const namespaceURI, localName: DOMString): IDOMNode;
begin
  Result := MakeNode(FNativeNamedNodeMap.RemoveNamedItemNS(namespaceURI, localName));
end;

function TODOMNamedNodeMap.setNamedItem(const arg: IDOMNode): IDOMNode;
begin
  Result := MakeNode(FNativeNamedNodeMap.SetNamedItem(GetNativeNodeOfIntfNode(arg)));
end;

function TODOMNamedNodeMap.setNamedItemNS(const arg: IDOMNode): IDOMNode;
begin
  Result := MakeNode(FNativeNamedNodeMap.SetNamedItemNS(GetNativeNodeOfIntfNode(arg)));
end;

                 

constructor TODOMNodeList.Create(const ANativeNodeList: OmniIXMLNodeList);
begin
  inherited Create;
  FNativeNodeList := ANativeNodeList;
end;

constructor TODOMNodeList.Create(const AnXpath: DomString; const AWrapperOwnerNode: TODOMNode);
begin
  inherited Create;
  FNativeNodeList := AWrapperOwnerNode.NativeNode.selectNodes(AnXpath);
end;

destructor TODOMNodeList.Destroy;
begin
  FNativeNodeList := nil;
  inherited;
end;

function TODOMNodeList.get_item(index: Integer): IDOMNode;
begin
  Result := MakeNode(FNativeNodeList.Item[index]);
end;

function TODOMNodeList.get_length: Integer;
begin
  Result := FNativeNodeList.Length;
end;

function TODOMInterface.SafeCallException(ExceptObject: TObject;
  ExceptAddr: Pointer): HRESULT;
var
  HelpFile: string;
begin
{$IF defined(MSWINDOWS) and not defined(NEXTGEN)}
  if ExceptObject is EOleException then
    HelpFile := (ExceptObject as EOleException).HelpFile;
{$ENDIF}
  Result := HandleSafeCallException(ExceptObject, ExceptAddr, IDOMNode, '', Helpfile);
end;

                     

constructor TODOMDocumentType.Create(ANativeNode: OmniIXMLNode);
begin
  inherited Create(ANativeNode);
end;

destructor TODOMDocumentType.Destroy;
begin
  inherited Destroy;
end;

function TODOMDocumentType.GetNativeDocumentType: OmniIXMLDocumentType;
begin
  Result := NativeNode as OmniIXMLDocumentType;
end;

function TODOMDocumentType.get_childNodes: IDOMNodeList;
begin
   Result := MakeNodeList(NativeDocumentType.ChildNodes);
end;

function TODOMDocumentType.get_entities: IDOMNamedNodeMap;
begin
// NYI in OmniXML
  DOMVendorNotSupported('get_entities', sOmniXmlVendor); { Do not localize }
end;

function TODOMDocumentType.get_internalSubset: DOMString;
begin
// NYI in OmniXML
  DOMVendorNotSupported('get_internalSubset', sOmniXmlVendor); { Do not localize }
end;

function TODOMDocumentType.get_name: DOMString;
begin
  Result := NativeDocumentType.NodeName;
end;

function TODOMDocumentType.get_notations: IDOMNamedNodeMap;
begin
// NYI in OmniXML
  DOMVendorNotSupported('get_notations', sOmniXmlVendor); { Do not localize }
end;

function TODOMDocumentType.get_publicId: DOMString;
begin
// NYI in OmniXML
  DOMVendorNotSupported('get_publicId', sOmniXmlVendor); { Do not localize }
end;

function TODOMDocumentType.get_systemId: DOMString;
begin
// NYI in OmniXML
  DOMVendorNotSupported('get_systemId', sOmniXmlVendor); { Do not localize }
end;

function TODOMDocumentType.hasChildNodes: WordBool;
begin
  Result := (NativeDocumentType.ChildNodes.Length > 0);
end;

                 

constructor TODOMDocument.Create(AWrapperDOMImpl: TODOMImplementation;
  ANativeDoc: OmniIXMLDocument; DocIsOwned: Boolean);
begin
  Assert(Assigned(ANativeDoc));
  FNativeDocument := ANativeDoc;
  FWrapperDOMImpl := AWrapperDOMImpl;
  inherited Create(ANativeDoc);
end;

destructor TODOMDocument.Destroy;
begin
  inherited Destroy;
end;

function TODOMDocument.GetNativeDocument: OmniIXMLDocument;
begin
  Result := FNativeDocument;
end;

function TODOMDocument.createAttribute(const name: DOMString): IDOMAttr;
begin
  Result := TODOMAttr.Create(NativeDocument.CreateAttribute(name));
end;

function TODOMDocument.createAttributeNS(const namespaceURI, qualifiedName: DOMString): IDOMAttr;
begin
  Result := TODOMAttr.Create(NativeDocument.CreateAttributeNS(namespaceURI, qualifiedName));
end;

function TODOMDocument.createCDATASection(const data: DOMString): IDOMCDATASection;
begin
 Result := TODOMCDATASection.Create(NativeDocument.CreateCDATASection(data));
end;

function TODOMDocument.createComment(const data: DOMString): IDOMComment;
begin
 Result := TODOMComment.Create(NativeDocument.CreateComment(data));
end;

function TODOMDocument.createDocumentFragment: IDOMDocumentFragment;
begin
  Result := TODOMDocumentFragment.Create(NativeDocument.CreateDocumentFragment);
end;

function TODOMDocument.createElement(const tagName: DOMString): IDOMElement;
begin
  Result := makenode(NativeDocument.CreateElement(tagName))  as IDOMElement;
end;

function TODOMDocument.createElementNS(const namespaceURI, qualifiedName: DOMString): IDOMElement;
begin
  Result := makenode(NativeDocument.CreateElementNS(namespaceURI, qualifiedName))  as IDOMElement;
end;

function TODOMDocument.createEntityReference(const name: DOMString): IDOMEntityReference;
begin
  Result := TODOMEntityReference.Create(NativeDocument.CreateEntityReference(name));
end;

function TODOMDocument.createProcessingInstruction(const target, data: DOMString): IDOMProcessingInstruction;
var
  NatProcessingInstruction: OmniIXMLProcessingInstruction;
begin
  NatProcessingInstruction := NativeDocument.CreateProcessingInstruction(target, data);
  Result := TODOMProcessingInstruction.Create(NatProcessingInstruction);
end;

function TODOMDocument.createTextNode(const data: DOMString): IDOMText;
begin
 Result := TODOMText.Create(NativeDocument.CreateTextNode(data));
end;

function TODOMDocument.get_doctype: IDOMDocumentType;
begin
  Result := TODOMDocumentType.Create(NativeDocument.DocType);
end;

function TODOMDocument.get_documentElement: IDOMElement;
begin
  if not Assigned(FDocumentElement) or
    (FNativeDocumentElement <> NativeDocument.documentElement) then { Test if underlying document NativeElement changed }
  begin
    FNativeDocumentElement := NativeDocument.documentElement;
    FDocumentElement := MakeNode(FNativeDocumentElement) as IDOMElement;
  end;
  Result := FDocumentElement;
end;

function TODOMDocument.get_domImplementation: IDOMImplementation;
begin
  Result := FWrapperDOMImpl;
end;

function TODOMDocument.getElementById(const elementId: DOMString): IDOMElement;
begin
  DOMVendorNotSupported('getElementById', sOmniXmlVendor); { Do not localize }
end;

function TODOMDocument.getElementsByTagName(const tagName: DOMString): IDOMNodeList;
begin
  Result := MakeNodeList(NativeDocument.GetElementsByTagName(tagName));
end;

function TODOMDocument.getElementsByTagNameNS(const namespaceURI, localName: DOMString): IDOMNodeList;
begin
  Result := MakeNodeList(NativeDocument.GetElementsByTagNameNS(namespaceURI, localName));
end;

function TODOMDocument.importNode(importedNode: IDOMNode; deep: WordBool):
  IDOMNode;
begin
  DOMVendorNotSupported('importNode', sOmniXmlVendor); { Do not localize }
end;

procedure TODOMDocument.set_documentElement(const DOMElement: IDOMElement);
begin
  if Assigned(DOMElement) then
  begin
    if Assigned(NativeDocument.documentElement) then
      NativeDocument.replaceChild(GetNativeNodeOfIntfNode(DOMElement),
        NativeDocument.documentElement)
    else
      NativeDocument.appendChild(GetNativeNodeOfIntfNode(DOMElement));
  end
  else
    if Assigned(NativeDocument.documentElement) then
      NativeDocument.removeChild(NativeDocument.documentElement);
  FDocumentElement := nil;
end;

{ IDOMParseOptions Interface }

function TODOMDocument.get_async: Boolean;
begin
  Result := False;
end;

function TODOMDocument.get_preserveWhiteSpace: Boolean;
begin
  Result := NativeDocument.PreserveWhiteSpace;
end;

function TODOMDocument.get_resolveExternals: Boolean;
begin
  Result := False;
end;

function TODOMDocument.get_validate: Boolean;
begin
  Result := False;
end;

procedure TODOMDocument.set_async(Value: Boolean);
begin
  if Value then
    DOMVendorNotSupported('set_async(True)', sOmniXmlVendor); { Do not localize }
end;

procedure TODOMDocument.set_preserveWhiteSpace(Value: Boolean);
begin
  NativeDocument.PreserveWhitespace := Value;
end;

procedure TODOMDocument.set_resolveExternals(Value: Boolean);
begin
  if Value then
    DOMVendorNotSupported('set_resolveExternals(True)', sOmniXmlVendor); { Do not localize }
end;

procedure TODOMDocument.set_validate(Value: Boolean);
begin
  if Value then
    DOMVendorNotSupported('set_validate(True)', sOmniXmlVendor); { Do not localize }
end;

{ IDOMPersist interface }

function TODOMDocument.get_xml: DOMString;
begin
  Result := FNativeDocument.XML;
end;

function TODOMDocument.load(source: OleVariant): WordBool;
begin
    Result := FNativeDocument.Load(source);
end;

function TODOMDocument.loadxml(const Value: DOMString): WordBool;
begin
  Result := FNativeDocument.LoadXML(Value);
end;

function TODOMDocument.loadFromStream(const stream: TStream): WordBool;
begin
  Result := FNativeDocument.LoadFromStream(stream);
end;

function TODOMDocument.loadFromStream(const stream: IStream): WordBool;
begin
  DOMVendorNotSupported('loadFromStream(IStream)', sOmniXmlVendor); { Do not localize }
end;

procedure TODOMDocument.save(destination: OleVariant);
begin
   FNativeDocument.Save(destination);
end;

procedure TODOMDocument.saveToStream(const stream: TStream);
begin
  FNativeDocument.SaveToStream(stream,ofNone);
end;

procedure TODOMDocument.saveToStream(const stream: IStream);
begin
  DOMVendorNotSupported('saveToStream(IStream)', sOmniXmlVendor); { Do not localize }
end;

{ IDOMParseError }

function TODOMDocument.get_errorCode: Integer;
begin
  Result := FNativeDocument.ParseError.errorCode;
end;

function TODOMDocument.get_filepos: Integer;
begin
  Result := FNativeDocument.ParseError.filePos;
end;

function TODOMDocument.get_line: Integer;
begin
  Result := FNativeDocument.ParseError.line;
end;

function TODOMDocument.get_linepos: Integer;
begin
  Result := FNativeDocument.ParseError.linePos;
end;

function TODOMDocument.get_reason: DOMString;
begin
  Result := FNativeDocument.ParseError.reason;
end;

function TODOMDocument.get_srcText: DOMString;
begin
  Result := FNativeDocument.ParseError.srcText;
end;

function TODOMDocument.get_url: DOMString;
begin
  Result := FNativeDocument.ParseError.url;
end;

function TODOMDocument.asyncLoadState: Integer;
begin
  result := 0; { Not Supported }
end;

procedure TODOMDocument.set_OnAsyncLoad(const Sender: TObject;
  EventHandler: TAsyncEventHandler);
begin
  DOMVendorNotSupported('set_OnAsyncLoad', sOmniXmlVendor); { Do not Localize }
end;

procedure TODOMDocument.RemoveWhiteSpaceNodes;
begin
  DOMVendorNotSupported('RemoveWhiteSpaceNodes', sOmniXmlVendor); { Do not Localize }
end;

                

function TODOMElement.GetNativeElement: OmniIXMLElement;
begin
  Result := NativeNode as OmniIXMLElement;
end;

function TODOMElement.get_tagName: DOMString;
begin
  Result := NativeElement.TagName;
end;

function TODOMElement.getAttribute(const name: DOMString): DOMString;
begin
  Result := NativeElement.GetAttribute(name);
end;

function TODOMElement.getAttributeNode(const name: DOMString): IDOMAttr;
begin
  Result := MakeNode(NativeElement.GetAttributeNode(name)) as IDOMAttr;
end;

function TODOMElement.getAttributeNodeNS(const namespaceURI, localName: DOMString): IDOMAttr;
begin
  Result := MakeNode(NativeElement.GetAttributeNodeNS(namespaceURI, localName)) as IDOMAttr;
end;

function TODOMElement.getAttributeNS(const namespaceURI, localName: DOMString): DOMString;
begin
  Result := NativeElement.GetAttributeNS(namespaceURI, localName);
end;

function TODOMElement.getElementsByTagName(const name: DOMString):
  IDOMNodeList;
begin
  Result := MakeNodeList(NativeElement.GetElementsByTagName(name));
end;

function TODOMElement.getElementsByTagNameNS(const namespaceURI, localName: DOMString): IDOMNodeList;
begin
  Result := MakeNodeList(NativeElement.GetElementsByTagNameNS(namespaceURI, localName));
end;

function TODOMElement.hasAttribute(const name: DOMString): WordBool;
begin
   Result := Assigned(NativeElement.Attributes.GetNamedItem(name));
end;

function TODOMElement.hasAttributeNS(const namespaceURI, localName: DOMString): WordBool;
begin
  Result := Assigned(NativeElement.Attributes.GetNamedItemNS(namespaceURI, localName));
end;

procedure TODOMElement.removeAttribute(const name: DOMString);
var
  NatOldAttr: OmniIXMLNode;
begin
  NatOldAttr := NativeElement.GetAttributeNode(name);
  NativeElement.Attributes.Remove(NatOldAttr);
end;

function TODOMElement.removeAttributeNode(const oldAttr: IDOMAttr): IDOMAttr;
var
  NatOldAttr: OmniIXMLNode;
begin
  Result := nil;
  NatOldAttr := GetNativeNodeOfIntfNode(OldAttr);
  if NativeElement.Attributes.Remove(NatOldAttr) >= 0 then
    Result := OldAttr;
end;

procedure TODOMElement.removeAttributeNS(const namespaceURI, localName: DOMString);
var
  NatOldAttr: OmniIXMLNode;
begin
  NatOldAttr := NativeElement.GetAttributeNodeNS(namespaceURI, localName);
  NativeElement.Attributes.Remove(NatOldAttr);
end;

procedure TODOMElement.setAttribute(const name, value: DOMString);
begin
  NativeElement.SetAttribute(name, value);
end;

function TODOMElement.setAttributeNode(const newAttr: IDOMAttr): IDOMAttr;
begin
  Result := MakeNode(NativeElement.SetAttributeNode(GetNativeNodeOfIntfNode(newAttr) as OmniIXMLAttr)) as IDOMAttr;
end;

procedure TODOMElement.setAttributeNS(const namespaceURI, qualifiedName, value: DOMString);
begin
  NativeElement.SetAttributeNS(qualifiedName, value);
end;

function TODOMElement.setAttributeNodeNS(const newAttr: IDOMAttr): IDOMAttr;
begin
  Result := (NativeElement.SetAttributeNodeNS(newAttr as OmniIXMLAttr))as IDOMAttr;
end;

procedure TODOMElement.normalize;
begin
  NativeElement.normalize;
end;

                      

function TODOMCharacterData.GetNativeCharacterData: OmniIXMLCharacterData;
begin
  Result := NativeNode as OmniIXMLCharacterData;
end;

procedure TODOMCharacterData.appendData(const data: DOMString);
begin
  NativeCharacterData.AppendData(data);
end;

procedure TODOMCharacterData.deleteData(offset, count: Integer);
begin
  NativeCharacterData.DeleteData(offset, count);
end;

function TODOMCharacterData.get_data: DOMString;
begin
  Result := NativeCharacterData.Data;
end;

function TODOMCharacterData.get_length: Integer;
begin
  Result := NativeCharacterData.length;
end;

procedure TODOMCharacterData.insertData(offset: Integer; const data: DOMString);
begin
  NativeCharacterData.InsertData(offset, data);
end;

procedure TODOMCharacterData.replaceData(offset, count: Integer; const data: DOMString);
begin
  NativeCharacterData.ReplaceData(offset, count, data);
end;

procedure TODOMCharacterData.set_data(const data: DOMString);
begin
  NativeCharacterData.Data := data;
end;

function TODOMCharacterData.substringData(offset, count: Integer): DOMString;
begin
  Result := NativeCharacterData.SubstringData(offset, count);
end;

             

function TODOMAttr.GetNativeAttribute: OmniIXMLAttr;
begin
  Result := NativeNode as OmniIXMLAttr;
end;

function TODOMAttr.get_name: DOMString;
begin
  Result := NativeAttribute.Name;
end;

function TODOMAttr.get_ownerElement: IDOMElement;
begin
  Result := MakeNode(NativeAttribute.OwnerElement) as IDOMElement;
end;

function TODOMAttr.get_specified: WordBool;
begin
  Result := NativeAttribute.Specified;
end;

function TODOMAttr.get_value: DOMString;
begin
  Result := NativeAttribute.Value;
end;

procedure TODOMAttr.set_value(const attributeValue: DOMString);
begin
  NativeAttribute.nodeValue := attributeValue;
end;

             

function TODOMText.splitText(offset: Integer): IDOMText;
begin
  Result := MakeNode((NativeNode as OmniIXMLText).SplitText(offset)) as IDOMText;
end;

                              

function TODOMProcessingInstruction.GetNativeProcessingInstruction: OmniIXMLProcessingInstruction;
begin
  Result := NativeNode as OmniIXMLProcessingInstruction;
end;

function TODOMProcessingInstruction.get_data: DOMString;
begin
  Result := NativeProcessingInstruction.Data;
end;

function TODOMProcessingInstruction.get_target: DOMString;
begin
  Result := NativeProcessingInstruction.Target;
end;

procedure TODOMProcessingInstruction.set_data(const value: DOMString);
begin
// Acces to Data protected, setted in the constructor.
  DOMVendorNotSupported('set_data', sOmniXmlVendor); { Do not localize }
end;

                              

function TODOMImplementationFactory.DOMImplementation: IDOMImplementation;
begin
  if not Assigned(GlobalODOM) then
  begin
    GlobalODOM := TODOMImplementation.Create;
    FGlobalDOMImpl := GlobalODOM;
  end;
  Result := FGlobalDOMImpl;
end;

function TODOMImplementationFactory.Description: String;
begin
  Result := sOmniXmlVendor;
end;

initialization
  OmniXML4Factory := TODOMImplementationFactory.Create;
  RegisterDOMVendor(OmniXML4Factory);

finalization
  UnRegisterDOMVendor(OmniXML4Factory);
  OmniXML4Factory.Free;

end.
