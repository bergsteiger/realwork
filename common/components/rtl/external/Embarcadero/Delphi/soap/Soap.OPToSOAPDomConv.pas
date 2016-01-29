{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                 SOAP Support                          }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{ Converts a SOAP RPC request to/from an internal Delphi format using a DOM }

unit Soap.OPToSOAPDomConv;

{$IFNDEF VER150}
{$INCLUDE 'CompVer.inc'}
{$ENDIF}

{$DEFINE FIX_ELEM_NODE_NS}
{$IF CompilerVersion >= 24.0}
{$LEGACYIFEND ON}
{$IFEND}

interface

uses
  System.SysUtils, System.Classes, System.Types, System.TypInfo,
  Soap.IntfInfo, Soap.InvokeRegistry, Soap.OPConvert, Soap.OpConvertOptions,
  Soap.SOAPAttachIntf, Soap.SOAPDomConv, Soap.SOAPEnv, Soap.WSDLNode,
  Xml.XMLIntf, Xml.xmldom;

const
  SVarArrayType = 'VarArrayType';     { do not localize }

type

  ESOAPDomConvertError = class(Exception);

  TNativeIntDynArray = array of NativeInt;

  TSOAPArrayElemDesc = record
    MultiDim: Boolean;
    Dims: TNativeIntDynArray;
  end;
  TSOAPArrayDesc = array of TSOAPArrayElemDesc;

  TMultiRefNodeMapElem = record
    Instance: Pointer;
    ID: string;
  end;
  TMultiRefNodeMap = array of TMultiRefNodeMapElem;

  TRefCache = class(TObject)
  private
    FNodes: IInterfaceList;
    FHREFs: TStringList;
    FMHREFs: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TXMLNodeArray  = array of IXMLNode;
  TMultiRefNodeElem = record
    Node: IXMLNode;
    MultiRefChildren: TXMLNodeArray;
  end;
  TMultiRefNodes = array of TMultiRefNodeElem;

  ConvNodeState = (nsClientSend, nsServerReceive, nsServerSend, nsClientReceive);

  TMemberDataNotReceivedEvent = procedure(const ClassName: string; const Member: string) of object;
  TUnhandledNodeEvent  = procedure(const Name: string; NodeXML: InvString) of object;

  TSOAPDomConv = class(TSOAPDOMProcessor, IObjConverter)
  private
    FIDs: Integer;
    FAttachments: TSoapDataList;
{ The code for TRefCache was kindly provided in QC-26063. It greatly improves
  performance when serializing multiref objects and arrays. }
    FRefCache: TRefCache;
    MultiRefNodes: TMultiRefNodes;
    FOptions: TSOAPConvertOptions;
    ObjsWriting: array of TObject;
    FOnMemberDataNotReceived: TMemberDataNotReceivedEvent;
    FOnUnhandledNode: TUnhandledNodeEvent;
  protected
    procedure AddAttachment(Attachment: TSOAPAttachment; const AContentId: string);
    function  FindAttachment(const AContentId: string): TSOAPAttachment;

    procedure ReadHeader(const EnvNode, HdrNode: IXMLNode; Headers: THeaderList);
    procedure WriteHeader(const Header: TObject; RootNode, ParentNode: IXMLNode);

    function  NodeIsNULL(Node: IXMLNode): Boolean;
    function  ChildNodesAreNull(Node: IXMLNode): Boolean;
    function  CreateNULLNode(RootNode, ParentNode: IXMLNode; const Name: InvString; UseParentNode: Boolean = False): IXMLNode;
    function  GetNewID: string;
    function  FindPrefixForURI(RootNode, Node: IXMLNode; const URI: InvString; DeclIfNone: Boolean = False): InvString;
    function  AddNamespaceDecl(Node: IXMLNode; const URI: InvString): InvString;
    function  GetElementType(Node: IXMLNode; var TypeURI, TypeName: InvString): Boolean;
    function  CreateScalarNodeXS(RootNode, ParentNode: IXMLNode; const NodeName, NodeNamespace, TypeName, Value: InvString; GenPre: Boolean = False): IXMLNode;
    function  GetTypeBySchemaNS(Node: IXMLNode; const URI: InvString): Variant;
    function  CreateTypedNode(RootNode, ParentNode: IXMLNode; const NodeName, NodeNamespace, TypeName: InvString; GenPre: Boolean = False): IXMLNode;
    procedure SetNodeType(RootNode, InstNode: IXMLNode; const ElemURI, TypeName: InvString);
    function  GetNodeAsText(Node: IXMLNode): InvString;
    function  GetDataNode(RootNode, Node: IXMLNode; var ID: InvString): IXMLNode;
    procedure CheckEncodingStyle(Node: IXMLNode);
    { Methods to handle mutli-referenced nodes }
    procedure AddMultiRefNode(const ID: string; Instance: Pointer);
    function  FindMultiRefNodeByInstance(Instance: Pointer): string;
    function  FindMultiRefNodeByID(const ID: string): Pointer;
    function  CreateMultiRefNode(RootNode: IXMLNode; const Name, ID: InvString): IXMLNode;
    procedure FinalizeMultiRefNodes;
    function  FindNodeByHREF(RootNode: IXMLNode; const HREF: InvString): IXMLNode;
    procedure AddObjectAsWriting(Instance: TObject);
    procedure RemoveObjectAsWriting(Instance: TObject);
    function  IsObjectWriting(Instance: TObject): Boolean;
    procedure ResetMultiRef;
    { Methods to handle Variants }
    procedure ConvertVariantToSoap(RootNode, Node: IXMLNode; const Name, NodeNamespace: InvString;
                                   Info: PTypeInfo; P: PVarData; V: Variant; UseVariant: Boolean);
    procedure ConvertSoapToVariant(Node: IXMLNode; InvData: Pointer);
    function  IsNodeAVarArray(const Node: IXMLNode; var VT: TVarType): Boolean;
    procedure WriteVarArray(RootNode, Node: IXMLNode; const Name, NodeNamespace: InvString; V: Variant);
    procedure WriteVariant(RootNode, Node: IXMLNode; const Name, NodeNamespace: InvString; V: Variant);
    procedure ReadVariant(Node: IXMLNode; P: Pointer);
    function  ReadVarArrayDim(Node: IXMLNode; IsVarVArray: Boolean = False; VT: TVarType = 0): Variant;
    procedure WriteVarArrayAsB64(RootNode, Node: IXMLNode; const Name: InvString; V: Variant);
    { Methods to handle native delphi array types }
    function  MakeArrayNode(RootNode, Node: IXMLNode; const Name, URI, TypeName: InvString;
                            Indices: array of NativeInt): IXMLNode; overload;
    function  MakeArrayNode(RootNode, Node: IXMLNode; const Name, URI, TypeName: InvString;
                            Dim, Len: Integer): IXMLNode; overload;
    procedure ConvertNativeArrayToSoap(RootNode, Node: IXMLNode; const NodeName, NodeNamespace, ChildNamespace: InvString;
                                       Info: PTypeInfo; P: Pointer; InlineElements: Boolean = False);
    procedure WriteNonRectDynArray(RootNode, Node: IXMLNode; const Name: InvString; Info: PTypeInfo; const URI, TypeName: InvString; P: Pointer; Dim: Integer);
    function  WriteNonRectDynArrayElem(RootNode, Node: IXMLNode;  Info: PTypeInfo; const URI, TypeName: InvString; P: Pointer; Dim: Integer): Integer;
    function  ConvertSoapToNativeArray(DataP: Pointer;  TypeInfo: PTypeInfo;
                                       RootNode, Node: IXMLNode; const ElementName: InvString = ''): Pointer;
    function  ConvertSoapToNativeArrayElem(ArrayInfo, ElemInfo: PTypeInfo;
                                           RootNode, Node: IXMLNode; ArrayDesc: TSOAPArrayDesc;
                                           Dims, CurDim: Integer; DataP: Pointer;
                                           const ElementName: InvString = ''): Pointer;
    procedure ConvertByteArrayToSoap(RootNode, Node: IXMLNode; const Name, NodeNamespace: InvString;
                                     Info: PTypeInfo; P: Pointer);
    procedure WriteRectDynArrayElem(RootNode, Node: IXMLNode; Info: PTypeInfo; Size, Dim: Integer; P: Pointer; const NodeName: InvString; const Namespace: InvString = '');
    procedure WriteRectDynArray(RootNode, Node: IXMLNode; Info: PTypeInfo; Dims: Integer; P: Pointer; const NodeName: InvString); deprecated;
    procedure ReadRectDynArray(RootNode, Node: IXMLNode; Info: PTypeInfo; Dims: Integer; P: Pointer; CurElem: Integer);
    procedure ReadRectDynArrayElem(RootNode, Node: IXMLNode; Info: PTypeInfo; Size, Dim: Integer; P: Pointer; var CurElem: Integer);
    procedure ReadRow(RootNode, Node: IXMLNode; var CurElem: Integer; Size: Integer; P: Pointer; Info: PTypeInfo; const ElementName: InvString = '');
    { Enums }
    function  ConvertEnumToSoap(Info: PTypeInfo; P: Pointer): InvString;
    function  ConvertSoapToEnum(Info: PTypeInfo; const S: InvString; IsNull: Boolean): Integer;

    { Methods that handle TObjects with RTTI }
    function  MultiRefObject(Cls: TClass): Boolean;
    function  SerializationOptions(Cls: TClass): TSerializationOptions; overload;
    function  SerializationOptions(ATypeInfo: PTypeInfo): TSerializationOptions; overload;
    function  SerializationOptions(Obj: TObject): TSerializationOptions; overload;
    procedure ConvertObjectToSOAP(const NodeName, NodeNamespace, ChildNamespace: InvString; ObjP: Pointer; RootNode, Node: IXMLNOde);
    function  ConvertSOAPToObject(RootNode, Node: IXMLNode;
              AClass: TClass; const URI, TypeName: InvString; ObjP: Pointer): TObject;

    function  CreateObjectNode(Instance: TObject; RootNode, ParentNode: IXMLNode;
                               const NodeName, NodeNamespace, ChildNamespace: InvString; ObjConvOpts: TObjectConvertOptions): InvString;
    function  ObjInstanceToSOAP(Instance: TObject; RootNode, ParentNode: IXMLNode;
                               const NodeName, NodeNamespace, ChildNamespace: InvString; ObjConvOpts: TObjectConvertOptions;
                               out RefID: InvString): IXMLNode;
    procedure LoadObject(Instance: TObject; RootNode, Node: IXMLNode);
    procedure InitObjectFromSOAP(Instance: TObject; RootNode, Node: IXMLNode);
    procedure ObjectMemberNoShow(const ClassName: string; const MemberName: string);
    procedure UnhandledNode(const Name: string; NodeXML: InvString);

    procedure SetObjectPropFromText(Instance: TObject; PropInfo: PPropInfo; const SoapData: InvString);
    function  GetObjectPropAsText(Instance: TObject; PropInfo: PPropInfo): InvString;

    function  GetOptions: TSOAPConvertOptions;
    procedure SetOptions(const Value: TSOAPConvertOptions);

    procedure SetNodeTypeEx(RootNode, InstNode: IXMLNode; const ElemURI, TypeName: InvString; Forced: Boolean);
    class function  HasMultipleElemNamespaces(const ClsType: TClass;
                                              out PropNamespaces: InvStringDynArray;
                                              out PropNamespaceIndex: TIntegerDynArray): Boolean; static;

 public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ConvertNativeDataToSoap(RootNode, Node: IXMLNode; const NodeName, NodeNamespace: InvString;
                                      Info: PTypeInfo; P: Pointer; XMLOptions: Integer); dynamic;
    procedure ConvertSoapToNativeData(DataP: Pointer; TypeInfo: PTypeInfo;
                 RootNode, Node: IXMLNode; Translate: Boolean); dynamic;
  published
    property Options: TSOAPConvertOptions read FOptions write FOptions default [soSendMultiRefObj, soTryAllSchema];
    property OnMemberDataNotReceived: TMemberDataNotReceivedEvent read FOnMemberDataNotReceived write FOnMemberDataNotReceived;
    property OnUnhandledNode: TUnhandledNodeEvent read FOnUnhandledNode write FOnUnhandledNode;
  end;

  TOPToSoapDomConvert = class(TSOAPDomConv, IOPConvert)
  private
    FWSDLView: TWSDLView;
    FTempDir:  string;
    Envelope:  TSoapEnvelope;
    FEncoding: InvString;
    function   GetSoapNS(MD: TIntfMetaData): InvString;
    procedure  DOMToStream(const XMLDoc: IXMLDocument; Stream: TStream);
    procedure  ProcessFault(FaultNode: IXMLNode);
    procedure  ProcessSuccess(RespNode: IXMLNode; const IntfMD: TIntfMetaData;
                              const MD: TIntfMethEntry; InvContext: TInvContext);
    function   GetPartName(MethMD: TIntfMetaData; const ParamName: InvString): InvString;
    procedure  CheckWSDL;
    function   GetBinding: InvString;
    procedure  SetWSDLView(const WSDLView: TWSDLView);
    function   GetAttachments: TSoapDataList; virtual;
    procedure  SetAttachments(Value: TSoapDataList); virtual;
    function   GetTempDir: string; virtual;
    procedure  SetTempDir(const Value: string); virtual;
    function   GetEncoding: DOMString;
    procedure  SetEncoding(const Encoding: DOMString);
  protected
    function   NewXMLDocument: IXMLDocument;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    property    Attachments: TSOAPDataList read GetAttachments write SetAttachments;
    { IOPConvert }
    procedure MsgToInvContext(const Request: InvString; const IntfMD: TIntfMetaData;
                              var MethNum: Integer; Context: TInvContext); overload; virtual;
    procedure MsgToInvContext(const Request: TStream; const IntfMD: TIntfMetaData;
                              var MethNum: Integer; Context: TInvContext;
                              Headers: THeaderList); overload; virtual;
    function  InvContextToMsg(const IntfMD: TIntfMetaData;
                              MethNum: Integer;
                              Con: TInvContext;
                              Headers: THeaderList): TStream; virtual;
    procedure MakeResponse(const IntfMD: TIntfMetaData;
                              const MethNum: Integer;
                              Context: TInvContext;
                              Response: TStream;
                              Headers: THeaderLIst); virtual;
    procedure MakeFault(const Ex: Exception; EStream: TStream); virtual;
    procedure ProcessResponse(const Resp: InvString;
                              const IntfMD: TIntfMetaData;
                              const MD: TIntfMethEntry;
                              Context: TInvContext); overload; virtual;
    procedure ProcessResponse(const Resp: TStream;
                              const IntfMD: TIntfMetaData;
                              const MD: TIntfMethEntry;
                              Context: TInvContext;
                              Headers: THeaderList); overload; virtual;

    { Helper routine }
    procedure ProcessResponse(const XMLDoc: IXMLDocument;
                              const IntfMD: TIntfMetaData;
                              const MD: TIntfMethEntry;
                              Context: TInvContext;
                              Headers: THeaderList); overload; virtual;
  published
    property WSDLView: TWSDLView read FWSDLView write SetWSDLView;
    property TempDir: string read GetTempDir write SetTempDir;
    property Encoding: DOMString read GetEncoding write SetEncoding;
  end;

var
  DefArrayElemName: string = 'item';    { do not localize }

implementation

uses
{$IFDEF MSWINDOWS}
//  Winapi.Windows,
//  System.Win.ComObj,
//  Xml.Win.msxmldom,
{$ENDIF}
  System.Character, System.Rtti, System.Variants,
  Xml.XMLDoc,
  Soap.XSBuiltIns,
  Soap.EncdDecd, Soap.HTTPUtil, Soap.SOAPConst,
  Soap.SOAPAttach, Soap.TypeTrans, Soap.WSDLBind, Soap.WSDLItems, Soap.WSDLIntf;

type

  { Add access to CacheFile : no data members! }

  TConvertAttachment = class(TSOAPAttachment)
    procedure SetCacheFile(const Value: string);
  end;

  { This is a hack allowing us to store additional data
    in the SOAPDomConverter without making an interface change. }
  TSoapDataListEx = class(TSoapDataList)
    FObjectMetaclass: TClass;
    FObjectInstance: TObject;
  end;

  ArrayOfInteger = array of Integer;

{$IFDEF FIX_ELEM_NODE_NS}
  { Helper to access element node namespace property }
  TSOAPDomConvHelper = class helper for TSOAPDomConv
  protected
    function  GetObjectMetaclass: TClass;
    procedure SetObjectMetaclass(const Cls: TClass);
    function  GetObjectInstance: TObject;
    procedure SetObjectInstance(const Obj: TObject);
    function  IsRPC: Boolean; inline;
    function  UsingLiteralEncoding: Boolean; inline;
    function  IsBareLiteral: Boolean; inline;
    function  IsWrappedLiteral: Boolean; inline;
    procedure ConvertNativeDataToSoap2(RootNode, Node: IXMLNode;
                                       const NodeName, NodeNamespace, ChildNamespace: InvString;
                                       Info: PTypeInfo; P: Pointer; XMLOptions: Integer);
{$IFNDEF XE_PATCH2}
    procedure WriteRectDynArrayElem2(RootNode, Node: IXMLNode; Info: PTypeInfo;
                                     Size, Dim: Integer; P: Pointer;
                                     const NodeName, NodeNamespace, ChildNamespace: InvString);
{$ELSE}
    procedure WriteRectDynArrayElem2(RootNode, Node: IXMLNode; Info: PTypeInfo;
                                     Size, Dim: Integer; P: Pointer;
                                     const NodeName, NodeNamespace: InvString);
{$ENDIF}

    property ObjectMetaclass: TClass read GetObjectMetaclass write SetObjectMetaclass;
    property ObjectInstance: TObject read GetObjectInstance write SetObjectInstance;
  end;
{$ENDIF}

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_NLBL = $0004;
  IS_UNQL = $0008;
  IS_ATTR = $0010;
  IS_TEXT = $0020;
  IS_ANY  = $0040;
  IS_REF  = $0080;
  IS_QUAL = $0100;
  IS_OUT  = $0200;

type

  {$SCOPEDENUMS ON}
  InfoAttribute = (iaExternalName,
                   iaMethReturnName,
                   iaMethRequestNamespace,
                   iaMethResponseNamespace,
                   iaMethSOAPAction,
                   iaNamespace,
                   iaArrayItemName,
                   iaArrayItemNamespace,
                   iaIgnoreItem);
  {$SCOPEDENUMS OFF}
const
  InfoAttributeStr: array[InfoAttribute] of string =
                      ('ExtName',
                       'ReturnName',
                       'RequestNS',
                       'ResponseNS',
                       'SOAPAction',
                       'Namespace',
                       'ArrayItemName',
                       'ArrayItemNS',
                       'Ignore'
                      );
  INFOATTR_BEG_CHAR: Char = '[';
  INFOATTR_END_CHAR: Char = ']';


  { WideString constant '1' given quirky behaviour of Variant with
    '1' constant as UnicodeString }
{$IFDEF NEXTGEN}
  sOneAsWide: string = '1';
{$ELSE !NEXTGEN}
  sOneAsWide: WideString = '1';
{$ENDIF NEXTGEN}

function GetTypeSize(Info: PTypeInfo): Cardinal;
var
	Context: TRttiContext;
	Typ: TRttiType;
begin
  if Info = TypeInfo(Variant) then
    Exit(SizeOf(TVarData));                                                
  Result := SizeOf(Pointer);
  Typ := Context.GetType(Info);
  if Assigned(Typ) then 
    Result := Typ.TypeSize;
end;

function GetRegInfo(const InfoStr: string;
                    const Key: string;
                    var Value: string): Boolean; overload;

  function Match(P1: PChar; P2: PChar): Boolean; inline;
  begin
    while (P1^ = P2^) and (P2^ <> #0) do
    begin
      Inc(P1);
      Inc(P2);
    end;
    Result := (P2^ = #0) and ((P1^ <= ' ') or (P1^ = '='));
  end;

//const
//  Alpha = ['A'..'Z', 'a'..'z'];
var
  Len: Integer;
  P1, P2, P3, PEnd: PChar;
  Quote: Char;
  HaveMatch: Boolean;
begin
  Result := False;
  Len := High(InfoStr);
  if (Len < 3) or
     (InfoStr[Low(string)] <> INFOATTR_BEG_CHAR) or
     (InfoStr[Len] <> INFOATTR_END_CHAR) then
    Exit;
  P1 := @InfoStr[1+Low(string)];
  P2 := @Key[Low(string)];
  P3 := nil;
  PEnd := @InfoStr[Len];
  repeat
    while P1^ <= ' ' do
      Inc(P1);
    HaveMatch := Match(P1, P2);
    if HaveMatch then
      Inc(P1, Length(P2))
    else
    begin
      //while (CharInSet(P1^, Alpha)) do
      while (P1^.IsLetter) do
        Inc(P1);
    end;
    while (P1^ <= ' ') do
      Inc(P1);
    if (P1^ <> '=') then
      Exit;
    Inc(P1);
    while (P1^ <= ' ') do
      Inc(P1);
    Quote := P1^;
    if (Quote <> '''') and (Quote <> '"') and (Quote <> '`') then
      Exit;
    Inc(P1);
    if HaveMatch then
      P3 := P1;
    while (P1 < PEnd) and (P1^ <> Quote) do
      Inc(P1);
    if P1^ <> Quote then
      Exit;
    if HaveMatch then
    begin
      Value := WideCharLenToString(P3, P1-P3);
      Result := True;
      Exit;
    end;
    Inc(P1);
    while (P1^ <= ' ') or (P1^ = ',') do
      Inc(P1);
  until (P1 = PEnd);
end;

function GetRegInfo(const InfoStr: string;
                    const KeyAttr: InfoAttribute;
                    var Value: string): Boolean; overload;
begin
  Result := GetRegInfo(InfoStr, InfoAttributeStr[KeyAttr], Value);
end;

{$IFDEF NEXTGEN}
function TypeInfoName(const b: Array of Byte): InvString;
begin
  Result := UTF8ToString(b);
end;
{$ELSE !NEXTGEN}
function TypeInfoName(const s: ShortString): InvString; inline;
begin
  Result := UTF8ToString(s);
end;
{$ENDIF NEXTGEN}

function GetDynArrayLength(P: Pointer): Integer;
begin
  // TByteDynArray is arbitrary. This tells the compiler to invoke
  // the magic function System._DynArrayLength the untyped dynamic
  // array pointed to by P.
  Result := Length(TByteDynArray(P));
end;


{$IF defined(FIX_ELEM_NODE_NS)}

function  TSOAPDomConvHelper.GetObjectMetaclass: TClass;
begin
  Result := TSoapDataListEx(FAttachments).FObjectMetaclass;
end;

procedure TSOAPDomConvHelper.SetObjectMetaclass(const Cls: TClass);
begin
  TSoapDataListEx(FAttachments).FObjectMetaclass := Cls;
end;

function  TSOAPDomConvHelper.GetObjectInstance: TObject;
begin
  Result := TSoapDataListEx(FAttachments).FObjectInstance;
end;

procedure TSOAPDomConvHelper.SetObjectInstance(const Obj: TObject);
begin
  TSoapDataListEx(FAttachments).FObjectInstance := Obj;
end;

function TSOAPDomConvHelper.IsRPC: Boolean;
begin
  Result := not (soDocument in Options);
end;

function TSOAPDomConvHelper.UsingLiteralEncoding: Boolean;
begin
  Result := Options * [soDocument, soLiteralParams] <> [];
end;

function TSOAPDomConvHelper.IsBareLiteral: Boolean;
begin
  Result := Options * [soDocument, soLiteralParams] = [soDocument, soLiteralParams];
end;

function TSOAPDomConvHelper.IsWrappedLiteral: Boolean;
begin
  Result := Options * [soDocument, soLiteralParams] = [soDocument];
end;

procedure TSOAPDomConvHelper.ConvertNativeDataToSoap2(RootNode, Node: IXMLNode;
  const NodeName, NodeNamespace, ChildNamespace: InvString;
  Info: PTypeInfo; P: Pointer; XMLOptions: Integer);
var
  ElemNode: IXMLNode;
  IsNull, InlineElements: Boolean;
  TypeName, TypeNamespace, S: InvString;
{$IFDEF FIX_ELEM_NODE_NS}
  PrevObjectMetaClass: TClass;
  PrevInstance: TObject;
{$ENDIF}
begin
  if not RemTypeRegistry.TypeInfoToXSD(Info, TypeNamespace, TypeName) then
    raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [Info.Name]);

  case Info.Kind of
    tkClass:
    begin
{$IFDEF FIX_ELEM_NODE_NS}
      PrevObjectMetaclass := ObjectMetaclass;
      PrevInstance := ObjectInstance;
      try
        ObjectMetaclass := GetTypeData(Info).ClassType;
        ObjectInstance := TObject(P^);
{$ENDIF}
        ConvertObjectToSOAP(NodeName, NodeNamespace, ChildNamespace, P, RootNode, Node)
{$IFDEF FIX_ELEM_NODE_NS}
      finally
        ObjectMetaclass := PrevObjectMetaclass;
        ObjectInstance := PrevInstance;
      end;
{$ENDIF}
    end;

    tkDynArray:
    begin
      InlineElements := ((IS_UNBD and XMLOptions) = IS_UNBD) or (xoInlineArrays in RemClassRegistry.SerializeOptions(Info));
      ConvertNativeArrayToSoap(RootNode, Node, NodeName, NodeNamespace, ChildNamespace, Info, P, InlineElements)
    end;

    tkSet,
    tkMethod,
    tkArray,
    tkRecord,
    tkInterface:
    // tkClassRef, tkPointer, tkProcedure ?
      raise ESOAPDomConvertError.CreateFmt(SDataTypeNotSupported, [KindNameArray[Info.Kind]]);

    tkVariant:
    begin
      ConvertVariantToSoap(RootNode, Node, NodeName, NodeNamespace, Info, P, NULL, False)
    end;
    tkEnumeration:
    begin
      S := ConvertEnumToSoap(Info, P);
      ElemNode := CreateScalarNodeXS(RootNode, Node, NodeName, NodeNamespace, TypeName, S)
    end;
    else
    begin
      TypeTranslator.CastNativeToSoap(Info, S, P, IsNull);
      if IsNull then
        ElemNode := CreateNULLNode(RootNode, Node, NodeName)
      else
        ElemNode := CreateScalarNodeXS(RootNode, Node, NodeName, NodeNamespace, TypeName, S);
    end;
  end;
end;

{$IFNDEF XE_PATCH2}
procedure TSOAPDomConvHelper.WriteRectDynArrayElem2(RootNode, Node: IXMLNode;
                                                    Info: PTypeInfo;
                                                    Size, Dim: Integer; P: Pointer;
                                                    const NodeName, NodeNamespace,
                                                    ChildNamespace: InvString);
{$ELSE}
procedure TSOAPDomConvHelper.WriteRectDynArrayElem2(RootNode, Node: IXMLNode;
                                                    Info: PTypeInfo;
                                                    Size, Dim: Integer; P: Pointer;
                                                    const NodeName, NodeNamespace: InvString);
{$ENDIF}
var
  I: Integer;
  S: InvString;
  IsNull: Boolean;
  ArNode: IXMLNode;
  ElemSize: Integer;
  ElemNodeName, ElemTypeNamespace, ElemTypeName: InvString;
  PrevObjectMetaclass: TClass;
  PrevInstance: TObject;
begin
  { Declare the namespace, but not when it is unqualified }
{$IFNDEF XE_PATCH2}
  {$IF FALSE}
  if NodeNamespace <> '' then
    FindPrefixForURI(RootNode, Node, NodeNamespace, True);
  {$IFEND}
{$ENDIF}

  if Dim > 1 then
  begin
    Dec(Dim);
    for I := 0 to Size-1 do
    begin
      ElemSize := GetDynArrayLength(Pointer(P^));
      WriteRectDynArrayElem(RootNode, Node, Info, ElemSize, Dim,
                            Pointer(P^), NodeName, NodeNamespace);
      P := Pointer(NativeUInt(P) + sizeof(Pointer));
    end;
  end
  else
  begin
    if UsingLiteralEncoding then
      ElemNodeName := NodeName
    else
      ElemNodeName := DefArrayElemName;

    { Write out data }
    for I := 0 to Size-1 do
    begin
      if Info.Kind = tkClass then
      begin
        { Here we want to pass the typeinfo of the elem type so that if its
          a derived type that we're streaming, we can also set the xsi:type
          attribute }
{$IFDEF FIX_ELEM_NODE_NS}
        PrevObjectMetaclass := ObjectMetaclass;
        PrevInstance := ObjectInstance;
        try
          ObjectMetaclass := GetTypeData(Info).ClassType;
          ObjectInstance := TObject(P^);
{$ENDIF}
          if UsingLiteralEncoding then
          begin
            if not RemTypeRegistry.TypeInfoToXSD(Info, ElemTypeNamespace, ElemTypeName) then
              raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [Info.Name]);
{$IFNDEF XE_PATCH2}
            ConvertObjectToSOAP(ElemNodeName, NodeNamespace, ChildNamespace, P, RootNode,  Node);
{$ELSE}
            ConvertObjectToSOAP(ElemNodeName, NodeNamespace, ElemTypeNamespace, P, RootNode,  Node);
{$ENDIF}
          end
          else
            ConvertObjectToSOAP(ElemNodeName, NodeNamespace, '', P, RootNode,  Node)
{$IFDEF FIX_ELEM_NODE_NS}
        finally
          ObjectMetaclass := PrevObjectMetaclass;
          ObjectInstance := PrevInstance;
        end;
{$ENDIF}
      end
      else if Info.Kind = tkVariant then
      begin
        ConvertVariantToSoap(RootNode, Node, ElemNodeName, NodeNamespace, Info, P, NULL, False)
      end
      else
      begin
        if Info.Kind = tkEnumeration then
          S := ConvertEnumToSoap(Info, P)
        else
          TypeTranslator.CastNativeToSoap(Info, S, P, IsNull);

        { Create node }
        if UsingLiteralEncoding then
          ArNode := Node.AddChild(ElemNodeName, NodeNamespace)
        else
          ArNode := Node.AddChild(ElemNodeName, ''); { No namespace prefix }
        { Set Value }
        ArNode.Text := S;
      end;
      P := Pointer( NativeUInt(P) + GetTypeSize(Info));
    end;
  end;
end;

{$IFEND}


procedure TConvertAttachment.SetCacheFile(const Value: string);
begin
  SetSourceFile('');
  InternalSetCacheFile(Value);
end;

constructor TRefCache.Create;
begin
  FNodes := TInterfaceList.Create;
  FHREFs := TStringList.Create;
  FHREFs.Sorted := True;

  FMHREFs := TStringList.Create;
  FMHREFs.Sorted := True;
end;

destructor TRefCache.Destroy;
begin
  FHREFs.Free;
  FMHREFs.Free;
  FNodes := nil;
end;

{ util function }

function ntElementChildCount(const Node: IXMLNode; const NodeName: InvString = ''): Integer; overload;
var
  I: Integer;
  CurrNode: IXMLNode;
begin
  Result := 0;
  if (Node = nil) or (Node.ChildNodes = nil) then
    Exit;
  for I := 0 to Node.ChildNodes.Count-1 do
  begin
    CurrNode := Node.ChildNodes[I];
    if (CurrNode.NodeType = ntElement) and
       ((NodeName = '') or (ExtractLocalName(CurrNode.NodeName) = NodeName)) then
      Inc(Result);
  end;
end;

function ntElementChild(const Node: IXMLNode;
    Index: Integer; var IndexPrev, IndexNodePrev: Integer; const NodeName: InvString = ''): IXMLNode; overload;
var
  I, J: Integer;
  CurrNode: IXMLNode;
begin
  Result := nil;
  if (Node = nil) or (Node.ChildNodes = nil) then
    Exit;
  J := succ(IndexPrev);
  for I := succ(IndexNodePrev) to Node.ChildNodes.Count-1 do
  begin
    CurrNode := Node.ChildNodes[I];
    if (CurrNode.NodeType = ntElement) and
       ((NodeName = '') or (ExtractLocalName(CurrNode.NodeName) = NodeName)) then
    begin
      if (J = Index) then
      begin
        Result := Node.ChildNodes[I];
        IndexPrev := J;
        IndexNodePrev := I;
        Exit;
      end
      else
        Inc(J);
    end;
  end;
end;

function ntElementChild(const Node: IXMLNode; Index: Integer): IXMLNode; overload;
var
  I, J: Integer;
begin
  Result := nil;
  if (Node = nil) or (Node.ChildNodes = nil) then
    Exit;
  J := 0;
  for I := 0 to Node.ChildNodes.Count-1 do
    if Node.ChildNodes[I].NodeType = ntElement then
    begin
      if (J = Index) then
      begin
        Result := Node.ChildNodes[I];
        Exit;
      end else
        Inc(J);
    end;
end;


procedure ParseDims(DimString: InvString; var Dims: TSOAPArrayDesc);
var
  I, J: Integer;
  CurDim, NumDims, SubDims, SubDim: Integer;
  StrLen: Integer;
  DimSize: InvString;
begin
  CurDim := 0;
  NumDims := 0;
  StrLen := High(DimString);
  for I := Low(string) to StrLen do
    if DimString[I] = '[' then      { do not localize }
      Inc(NumDims);
  SetLength(Dims, NumDims);
  I := Low(string);
  while I < StrLen do
  begin
    if DimString[I] = '[' then       { do not localize }
    begin
      DimSize := '';
      Inc(I);
      SubDims := 1;
      SubDim := 0;
      if DimString[I] = ']' then               { do not localize }
        SetLength(Dims[CurDim].Dims, 1);
      while (DimString[I] <> ']') and (I < StrLen) do     { do not localize }
      begin
        J := I;
        while (DimString[J] <> ']') and (J < StrLen) do       { do not localize }
        begin
          if DimString[J] = ',' then
            Inc(SubDims);
          Inc(J);
        end;
        SetLength(Dims[CurDim].Dims, SubDims);
        if SubDims > 1 then
        begin
          Dims[CurDim].MultiDim := True;
          while (DimString[I] <> ']') and (I < StrLen) do     { do not localize }
          begin
            DimSize := '';
            while (DimString[I] <> ',') and (DimString[I] <> ']') and (I < StrLen) do   { do not localize }
            begin
              DimSize := DimSize + DimString[I];
              Inc(I);
            end;
            if DimString[I] = ',' then
              Inc(I);
            if Trim(DimSize) <> '' then
              Dims[CurDim].Dims[SubDim] := StrToInt(trim(DimSize))
            else
              Dims[CurDim].Dims[SubDim] := 0;
            Inc(SubDim);
          end
        end else
        begin
          while (DimString[I] <> ']') and (I < StrLen) do      { do not localize }
          begin
            DimSize := DimSize + DimString[I];
            Inc(I);
          end;
          if Trim(DimSize) <> '' then
            Dims[CurDim].Dims[SubDim] := StrToInt(trim(DimSize))
          else
            Dims[CurDim].Dims[SubDim] := 0;
        end;
      end;
      Inc(I);
      Inc(CurDim);
    end else
      Inc(I);
  end;
end;

{ TOPToSoapDomConvert }

type
  PTObject = ^TObject;


{ Server Receives Message }
procedure TOPToSoapDomConvert.MsgToInvContext(const Request: InvString;
  const IntfMD: TIntfMetaData; var MethNum: Integer; Context: TInvContext);
var
  Stream: TStream;
begin
  Stream := TMemoryStream.Create;
  try
    Stream.Write(Request[Low(string)], Length(Request) * 2);
    Stream.Position := 0;
    MsgToInvContext(Stream, IntfMD, MethNum, Context, nil);
  finally
    Stream.Free;
  end;
end;

procedure TSoapDomConv.ReadHeader(const EnvNode, HdrNode: IXMLNode; Headers: THeaderList);
var
  HeaderName, HeaderNamespace: InvString;
  HeaderProcessor: IDOMHeaderProcessor;
  HeaderHandled, AbortRequest: Boolean;
  HeaderClsType: TClass;
  HeaderObject: TObject;
  HeaderNode: IXMLNode;
  ID: InvString;
begin
  HeaderNode := GetDataNode(EnvNode, HdrNode, ID);

  { Find out if we have something into which we can serialize this node }
  HeaderName := ExtractLocalName(HeaderNode.NodeName);
  HeaderNamespace := HeaderNode.NamespaceURI;

  HeaderClsType := InvRegistry.GetHeaderClass(HeaderName, HeaderNamespace);
  if HeaderClsType <> nil then
  begin
    if HeaderClsType.InheritsFrom(TRemotable) then
      HeaderObject := TRemotableClass(HeaderClsType).Create
    else
      HeaderObject := HeaderClsType.Create;
    ConvertSoapToNativeData(@HeaderObject, HeaderClsType.ClassInfo, EnvNode, HeaderNode, False);
    Headers.Add(HeaderObject);
  end else
  begin
    { Old -D6- Header processing logic - left here simply because....}
    AbortRequest := False;
    HeaderProcessor := FindHeaderProcessor(HeaderNamespace, HeaderName, '');
    if HeaderProcessor <> nil then
      HeaderProcessor.ProcessHeader(HeaderNode, HeaderHandled, AbortRequest)
    else
    begin
      UnhandledNode(Format('%s:%s', [HeaderNamespace, HeaderName]), HeaderNode.XML);
      DefaultProcessHeader(HeaderNode, HeaderHandled, AbortRequest);
    end;
    if AbortRequest then
      raise ESOAPDomConvertError.CreateFmt(SHeaderError, [HeaderNamespace, HeaderName]);
  end;
end;

procedure TSoapDomConv.WriteHeader(const Header: TObject; RootNode, ParentNode: IXMLNode);
var
  TypeNamespace, TypeName: InvString;
begin
  Options := Options + [soXXXXHdr];
  try
    if not RemTypeRegistry.TypeInfoToXSD(Header.ClassInfo, TypeNamespace, TypeName) then
      raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [Header.ClassInfo]);
    ConvertNativeDataToSoap(RootNode, ParentNode, Header.ClassName, TypeNamespace, Header.ClassInfo, @Header, 0);
  finally
    Options := Options - [soXXXXHdr];
  end;
end;

procedure BuildHREFList(Converter: TSOAPDomConv; Node: IXMLNode);
var
  I: Integer;
  V: Variant;
  RefCache: TRefCache;
begin
  if Node.NodeType = ntElement then
  begin
    V := Null;

    RefCache := Converter.FRefCache;
    if not (soSOAP12 in Converter.Options) then
      V := Node.Attributes[SXMLID]
    else
      V := Node.GetAttributeNS(SXMLID, SSoap12EncodingNamespace);

    if not VarIsNull(V) then
    begin
      I := RefCache.FNodes.Add(Node);
      RefCache.FHREFs.AddObject(SSOAPHREFPres[soSOAP12 in Converter.Options] + V, TObject(I));
    end;
  end;

  if Node.HasChildNodes then
    for I := 0 to Node.ChildNodes.Count - 1 do
      BuildHREFList(Converter, Node.ChildNodes[I]);
end;

procedure CreateHREFList(Converter: TSOAPDomConv; Node: IXMLNode);
var
  RefCache: TRefCache;
begin
  RefCache := Converter.FRefCache;
  RefCache.FHREFs.Clear;
  RefCache.FNodes.Clear;
  BuildHREFList(Converter, Node);
end;

procedure TOPToSoapDomConvert.MsgToInvContext(const Request: TStream;
  const IntfMD: TIntfMetaData; var MethNum: Integer; Context: TInvContext;
  Headers: THeaderList);
var
  XmlDoc: IXMLDocument;
  I, J, K, L, ParamCount: Integer;
  MethodName, InternalMethodName, ExtParamName: InvString;
  EnvNode, MethNode, ParamNode, Node, HdrNode: IXMLNode;
  ProcessedBody: Boolean;
  MD: TIntfMethEntry;
  Translate: Boolean;
  ParamSerialOpts: TSerializationOptions;
begin
  XmlDoc := NewXMLDocument;
  Request.Position := 0;
  XmlDoc.LoadFromStream(Request);
  CreateHREFList(Self, XmlDoc.Node);
  EnvNode := XmlDoc.DocumentElement;
  if EnvNode = nil then
    raise ESOAPDomConvertError.Create(SInvalidSOAPRequest);
  if (ExtractLocalName(EnvNode.NodeName) <> SSoapEnvelope) or
     ((EnvNode.NamespaceURI <> SoapEnvelopeNamespaces[soSOAP12 in Options]) and
      (EnvNode.NamespaceURI <> SoapEnvelopeNamespaces[not (soSOAP12 in Options)])) then
    raise ESOAPDomConvertError.Create(SInvalidSOAPRequest);

  ProcessedBody := False;
  try
    if EnvNode.hasChildNodes then
    begin
      for I := 0 to EnvNode.childNodes.Count -1 do
      begin
        Node := EnvNode.childNodes[I];
        if Node.NodeType <> ntElement then
          continue;
        if ExtractLocalName(Node.NodeName) = SSoapHeader then
        begin
          if Node.hasChildNodes then
          begin
            for L := 0 to Node.childNodes.Count-1 do
            begin
              HdrNode := Node.childNodes[L];
              if HdrNode.NodeType <> ntElement then
                Continue;
              ReadHeader(EnvNode, HdrNode, Headers);
            end;
          end;
        end
        else if ExtractLocalName(Node.NodeName) = SSoapBody then
        begin
          if ProcessedBody then
            raise ESOAPDomConvertError.Create(SMultiBodyNotSupported);
          CheckEncodingStyle(EnvNode);
          ProcessedBody := True;
          if Node.ChildNodes.Count > 0 then
          begin
            { Rather than assume that the first childNode is the method's
              node, it would be safer to use the 'root' attribute. However,
              SOAPBuilder can't seem to agree on 'root' currently. So for
              now, we'll stay with this approach }
            MethNode := ntElementChild(Node, 0);
            CheckEncodingStyle(MethNode);
            MethodName := ExtractLocalName(MethNode.NodeName);
            InternalMethodName := InvRegistry.GetMethInternalName(IntfMD.Info, MethodName);
            MethNum := GetMethNum(IntfMD, InternalMethodName, ntElementChildCount(MethNode));
            { Here know if there's a method for the request sent }
            if MethNum = -1 then
                raise ESOAPDomConvertError.CreateFmt(SNoSuchMethod, [MethodName, IntfMD.Name]);

            MD := IntfMD.MDA[MethNum];
            Context.SetMethodInfo(MD);
            Context.AllocServerData(MD);

            { Get native parameters }
            ParamCount := 0;
            for K := 0 to Length(MD.Params)-1 do
              if MD.Params[K].Name <> '' then
                Inc(ParamCount);

            for K := 0 to Length(MD.Params)-1 do
            begin
              { Skip non-parameters }
              if MD.Params[K].Name = '' then
                Continue;
              { Was parameter renamed ? }
              ExtParamName := InvRegistry.GetParamExternalName(IntfMD.Info, InternalMethodName, MD.Params[K].Name);
              ParamSerialOpts := SerializationOptions(MD.Params[K].Info);
              for J := 0 to MethNode.childNodes.Count -1 do
              begin
                ParamNode := MethNode.childNodes[J];
                if ParamNode.NodeType <> ntElement then
                  continue;
                { Warning: In case sensitive contexts, it's possible to have parameters
                           that differ only in case - C++ }
                if SameText(ExtParamName, ExtractLocalName(ParamNode.NodeName)) then
                begin
                  CheckEncodingStyle(ParamNode);
                  Translate := (pfVar in MD.Params[K].Flags)
                    or (pfConst in  MD.Params[K].Flags)
                    or ([] =  MD.Params[K].Flags)
                    or ((pfReference in MD.Params[K].Flags) and (MD.Params[K].Info.Kind = tkVariant))
                    or ((pfReference in MD.Params[K].Flags) and (MD.Params[K].Info.Kind = tkString))
                    or ((pfReference in MD.Params[K].Flags) and (MD.Params[K].Info.Kind = tkUString));
                  ConvertSoapToNativeData(Context.GetParamPointer(K), MD.Params[K].Info, MethNode,
                    ParamNode, Translate);
                  Break;
                end
                  { Here we have an unhandled parameter node }
                  { Check if the name mismatches were due to wrapper classes }
                else if (xoHolderClass in ParamSerialOpts) and (ParamCount = 1) then
                begin
                  Translate := (pfVar in MD.Params[K].Flags)
                    or (pfConst in  MD.Params[K].Flags)
                    or ([] =  MD.Params[K].Flags)
                    or ((pfReference in MD.Params[K].Flags) and (MD.Params[K].Info.Kind = tkVariant))
                    or ((pfReference in MD.Params[K].Flags) and (MD.Params[K].Info.Kind = tkString))
                    or ((pfReference in MD.Params[K].Flags) and (MD.Params[K].Info.Kind = tkUString));
                  ConvertSoapToNativeData(Context.GetParamPointer(K), MD.Params[K].Info, MethNode,
                                          Node, Translate);
                  Break;
                end else
                begin
                  { Could not deserialize node... }
                  UnhandledNode(MethodName, ParamNode.XML);
                end;
              end;
            end;
          end;
        end;
      end;
    end else
      raise ESOAPDomConvertError.Create(SInvalidSOAPRequest);
  finally
    ResetMultiRef;
  end;
end;

procedure TOPToSoapDomConvert.DOMToStream(const XMLDoc: IXMLDocument; Stream: TStream);
begin
  XMLDoc.SaveToStream(Stream);
end;

procedure TOPToSoapDomConvert.MakeResponse(const IntfMD: TIntfMetaData; const MethNum: Integer;
                                           Context: TInvContext; Response: TStream;
                                           Headers: THeaderList);
var
  I: Integer;
  XmlDoc: IXMLDocument;
  EnvNode, HeaderNode, BodyNode, MethNode, RootNode: IXMLNode;
  MD: TIntfMethEntry;
  SoapNS, TypeNamespace, TypeName, Pre: InvString;
  ArgName: InvString;
  P: Pointer;
  Header: TObject;
  IsScalar: Boolean;
begin
  MD := IntfMD.MDA[MethNum];
  XMLDoc := NewXMLDocument;
  XMLDoc.Encoding := FEncoding;
  EnvNode := Envelope.MakeEnvelope(XMLDoc, Options);
  XmlDoc.DocumentElement := EnvNode;

  { Result the MultiRef IDs as we're about to create a new Response }
  FIDS := 1;
  FAttachments.Clear;

  if (Headers <> nil) and (Headers.Count > 0) then
  begin
    HeaderNode := Envelope.MakeHeader(EnvNode, Options);
    if not UsingLiteralEncoding then
      HeaderNode.SetAttributeNS(SSoapEncodingAttr, SoapEnvelopeNamespaces[soSOAP12 in Options],
                                SoapEncodingNamespaces[soSOAP12 in Options]);
    for I := 0 to Headers.Count-1 do
    begin
      Header := Headers[I];
      WriteHeader(Header, HeaderNode, HeaderNode);
    end;
  end;

  BodyNode := Envelope.MakeBody(EnvNode, Options);
  if not UsingLiteralEncoding then
    BodyNode.SetAttributeNS(SSoapEncodingAttr, SoapEnvelopeNamespaces[soSOAP12 in Options],
                            SoapEncodingNamespaces[soSOAP12 in Options]);

//  if not (soLiteralParams in Options) then
  if not IsBareLiteral then
  begin
    SoapNS := GetSoapNS(IntfMD);
    if not UsingLiteralEncoding then
    begin
      Pre := FindPrefixForURI(BodyNode, BodyNode, SoapNS, True);
      MethNode := BodyNode.AddChild(MakeNodeName(Pre, MD.Name + SSoapResponseSuff));
    end
    else
      MethNode := BodyNode.AddChild(MD.Name + SSoapResponseSuff, SoapNS)
  end
  else
  begin
    { If Wrapper elements were not unwrapped, we don't need a method node }
    MethNode := BodyNode;
  end;

  { Compute Root Node }
  { NOTE: It's incorrect to root ref nodes to the method node - however, this was
          the way D6 originally shipped; therefore we offer it as an option in
          case you still have a D6 [unpatched] Service or Client that you need
          to support }
  if (soRootRefNodesToBody in Options) then
    RootNode := BodyNode
  else
    RootNode := MethNode;

  try
    if MD.ResultInfo <> nil  then
    begin
      ArgName := GetPartName(IntfMD, '');
      if not RemClassRegistry.InfoToURI(MD.ResultInfo, TypeNamespace, TypeName, IsScalar) then
        raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [MD.ResultInfo.Name]);
      ConvertNativeDataToSoap(RootNode, MethNode, ArgName, TypeNamespace, MD.ResultInfo, Context.GetResultPointer, 0);
    end;
    for I := 0 to MD.ParamCount - 1  do
    begin
      if (pfVar in MD.Params[I].Flags) or (pfOut in MD.Params[I].Flags)
      then
      begin
        P := Context.GetParamPointer(I);
{$IF CompilerVersion < 23.0}
        if IsParamByRef(MD.Params[I].Flags, MD.Params[I].Info, MD.CC) then
          P := Pointer(P^);
{$IFEND}
        if not RemClassRegistry.InfoToURI(MD.Params[I].Info, TypeNamespace, TypeName, IsScalar) then
          raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [MD.Params[I].Info.Name]);
        ConvertNativeDataToSoap(RootNode, MethNode, MD.Params[I].Name, TypeNamespace, MD.Params[I].Info, P, 0);
      end;
    end;
  finally
    FinalizeMultiRefNodes;
    ResetMultiRef;
  end;

  { Let DOM write to stream - DOM handles Encoding }
  DOMToStream(XMLDoc, Response);
end;

function TOPToSoapDomConvert.GetSoapNS(MD: TIntfMetaData): InvString;
var
  ExtName: InvString;
  SOAPVersion: TSOAPVersion;
begin
  if Assigned(WSDLView) then
  begin
    ExtName :=  InvRegistry.GetMethExternalName(MD.Info, WSDLVIew.Operation);

    if ioSOAP12 in InvRegistry.GetIntfInvokeOptions(MD.Info) then
      SOAPVersion := svSOAP12
    else
      SOAPVersion := svSOAP11;

    Result := WSDLView.WSDL.GetSoapBodyAttribute(GetBinding, ExtName, Soap.WSDLBind.SInput,
                                                 Soap.WSDLBind.SNameSpace, 0, SOAPVersion);
    { NOTE: Document Style WSDL don't have a namespace on the input/ouput nodes }
    if (Result = '') then
      Result := InvRegistry.GetNamespaceByGUID(MD.IID);
  end
  else
    Result := InvRegistry.GetNamespaceByGUID(MD.IID);
end;

procedure TOPToSoapDomConvert.MakeFault(const Ex: Exception; EStream: TStream);
var
  XmlDoc: IXMLDocument;
  EnvNode, BodyNode, FaultNode, FA, FC, FS, FD, CustNode: IXMLNode;
  I, Count: Integer;
  PropList: PPropList;
  TypeNamespace, TypeName: InvString;
  IsScalar: Boolean;
  RemException: ERemotableException;
begin
  XMLDoc := NewXMLDocument;
  XMLDoc.Encoding := FEncoding;
  EnvNode := Envelope.MakeEnvelope(XMLDoc, Options);
  BodyNode := Envelope.MakeBody(EnvNode, Options);
  FaultNode := Envelope.MakeFault(BodyNode, Options);
  FC := FaultNode.AddChild(SSoapFaultCode, '');
  { NOTE: We map the FaultString to Exception's Message }
  FS := FaultNode.AddChild(SSoapFaultString, '');
  FS.Text := Ex.Message;
  FA := FaultNode.AddChild(SSoapFaultActor, '');
  if Ex.InheritsFrom(ERemotableException) then
  begin
    RemException := ERemotableException(Ex);
    FA.Text := RemException.FaultActor;
    FC.Text := MakeNodeName(SSoapNameSpacePre, RemException.FaultCode);

    if Ex.ClassType <> ERemotableException then
    begin
      RemClassRegistry.ClassToURI(Ex.ClassType, TypeNamespace, TypeName, IsScalar);

      { The follow logic is *NOT* as per the SOAP spec. The spec wants
        specific information under the details node - not *AT* the details
        node !!!! But we offer it as an option given that Delphi6, which
        had limited (Delphi<->Delphi) Fault support followed that approach }
      if (soCustomFaultAtDetailsNode in Options) then
      begin
        FD := FaultNode.AddChild(SSoapFaultDetails, TypeNamespace, True);
        CustNode := FD;
      end
      else
      begin
        FD := FaultNode.AddChild(SSoapFaultDetails, '');
        CustNode := FD.AddChild(TypeName, TypeNamespace, True);
      end;

      { Set the type }
      CustNode.SetAttributeNS(SSoapType, XMLSchemaInstNameSpace, MakeNodeName(CustNode.Prefix, TypeName));

      Count := GetTypeData(Ex.ClassInfo)^.PropCount;
      if Count > 0 then
      begin
        GetMem(PropList, Count * SizeOf(Pointer));
        try
          GetPropInfos(Ex.ClassInfo, PropList);
          for I := 0 to Count - 1 do
          begin
            if not RemTypeRegistry.TypeInfoToXSD((PropList[I].PropType)^, TypeNamespace, TypeName) then
              raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [(PropList[I].PropType)^.Name]);
            CreateScalarNodeXS(CustNode, CustNode, TypeInfoName(PropList[I].Name), TypeNamespace, TypeName, GetObjectPropAsText(Ex, PropList[I]));
          end;
        finally
          FreeMem(PropList, Count * SizeOf(Pointer));
        end;
      end;
    end;
  end else
  begin
    { Fault Code }
    FC.Text := MakeNodeName(SSoapNameSpacePre, 'Server');   { Do not localize }
  end;
  DOMToStream(XmlDoc, EStream);
end;

function TOPToSoapDomConvert.InvContextToMsg(const IntfMD: TIntfMetaData; MethNum: Integer;
                                             Con: TInvContext; Headers: THeaderList): TStream;
var
  XMLDoc: IXMLDocument;
  EnvNode, HeaderNode, BodyNode, MethNode: IXMLNode;
  I, XMLOptions: Integer;
  SoapMethNS, Pre: InvString;
  MethMD: TIntfMethEntry;
  P: Pointer;
  ExtMethName: InvString;
  ExtParamName, ParamNamespace, ParamChildNamespace, TypeName: InvString;
  RegInfoStr: InvString;
  Header: TObject;
begin
  MethMD := IntfMD.MDA[MethNum];

  { Here we update the WSDLView to inform it of
    the Operation we're about to execute }
  if Assigned(WSDLView) then
  begin
    WSDLView.Operation := MethMD.Name;
    WSDLView.IntfInfo := IntfMD.Info;
  end;

  XMLDoc := NewXMLDocument;
  XMLDoc.Encoding := FEncoding;
  EnvNode := Envelope.MakeEnvelope(XMLDoc, Options);

  { Result MultiRef IDs are we're about to create new request }
  FIDS := 1;
  FAttachments.Clear;

  { Any headers }
  if (Headers <> nil) and (Headers.Count > 0) then
  begin
    HeaderNode := Envelope.MakeHeader(EnvNode, Options);
    if not UsingLiteralEncoding then
      HeaderNode.SetAttributeNS(SSoapEncodingAttr, SoapEnvelopeNamespaces[soSOAP12 in Options],
                                SoapEncodingNamespaces[soSOAP12 in Options]);
    for I := 0 to Headers.Count-1 do
    begin
      Header := Headers[I];
      WriteHeader(Header, HeaderNode, HeaderNode);
    end;
  end;

  BodyNode := Envelope.MakeBody(EnvNode, Options);

  { Add Method node with appropriate namespace }
  SoapMethNS := GetSoapNS(IntfMD);
  ExtMethName := InvRegistry.GetMethExternalName(IntfMD.Info, MethMD.Name);

  if not UsingLiteralEncoding then
  begin
    if SoapMethNS <> '' then
    begin
      Pre := FindPrefixForURI(BodyNode, BodyNode, SoapMethNS, True);
      MethNode := BodyNode.AddChild(MakeNodeName(Pre, ExtMethName));
    end
    else
      MethNode := BodyNode.AddChild(ExtMethName, SoapMethNS, False);

    { Use encoding style defined by SOAP 1.1 section 5 }
    { NOTE: We used to put this on the method node; it seems more intuitive on
            the body node; Keep this in mind when investigating interop issues }
    BodyNode.SetAttributeNS(SSoapEncodingAttr,
                            SoapEnvelopeNamespaces[soSOAP12 in Options],
                            SoapEncodingNamespaces[soSOAP12 in Options]);
  end
  else
  begin
    { In Literal mode, SoapMethNS is the default namespace unless one
      was registered for this method }
    InvRegistry.GetMethodInfo(IntfMD.Info, MethMD.Name, ExtMethName,
                              RegInfoStr, XMLOptions);
    if RegInfoStr <> '' then
    begin
      if (RegInfoStr[Low(string)] = INFOATTR_BEG_CHAR) and
          GetRegInfo(RegInfoStr, InfoAttribute.iaMethRequestNamespace,
                     RegInfoStr) then
        SoapMethNS := RegInfoStr;
    end;

    if not IsBareLiteral then
      MethNode := BodyNode.AddChild(ExtMethName, SoapMethNS)
    else
      MethNode := BodyNode;
  end;

  try
    { Add each parameter to the method node }
    for I := 0 to MethMD.ParamCount - 1  do
    begin
      InvRegistry.GetParamInfo(IntfMD.Info, MethMD.Name, MethMD.Params[I].Name,
                               ExtParamName, ParamNamespace, XMLOptions);
      if not ((pfOut in MethMD.Params[I].Flags) or ((XMLOptions and IS_OUT) = IS_OUT)) then
      begin
        if not IsRPC then
        begin
          if IsBareLiteral then
          begin
            if not RemTypeRegistry.TypeInfoToXSD(MethMD.Params[I].Info, ParamNamespace, ExtParamName) then
              raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [MethMD.Params[I].Info.Name]);
          end
          else
          begin
            // IsWrappedLiteral !
            ParamChildNamespace := ParamNamespace;
            if (XMLOptions and IS_UNQL) = IS_UNQL then
              ParamNamespace := ''
            else if (XMLOptions and IS_REF) <> IS_REF then
              ParamNamespace := SoapMethNS
            else
              GetRegInfo(ParamNamespace, InfoAttribute.iaNamespace, ParamNamespace);
            if (ParamChildNamespace = '') and ((XMLOptions and IS_UNQL) = 0) then
              ParamChildNamespace := ParamNamespace
          end;
        end
        else
        begin
          // rpc|literal ??
          if UsingLiteralEncoding then
          begin
            ParamChildNamespace := ParamNamespace;
            ParamNamespace := '';
          end
          else
          begin
            // rpc|encoded
            if not RemTypeRegistry.TypeInfoToXSD(MethMD.Params[I].Info, ParamNamespace, TypeName) then
              raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [MethMD.Params[I].Info.Name]);
            ParamChildNamespace := '';
          end;
        end;

        P := Con.GetParamPointer(I);
{$IF CompilerVersion < 23.0}
        if IsParamByRef(MethMD.Params[I].Flags, MethMD.Params[I].Info, MethMD.CC) then
          P := Pointer(P^);
{$IFEND}
        ConvertNativeDataToSoap2(BodyNode, MethNode,
                                 ExtParamName, ParamNamespace, ParamChildNamespace,
                                 MethMD.Params[I].Info, P, XMLOptions);
      end;
    end;
    FinalizeMultiRefNodes;
  finally
    ResetMultiRef;
  end;
  Result := TMemoryStream.Create();
  DOMToStream(XMLDoc, Result);
end;

procedure TOPToSoapDomConvert.ProcessSuccess(RespNode: IXMLNode;
                                             const IntfMD: TIntfMetaData;
                                             const MD: TIntfMethEntry;
                                             InvContext: TInvContext);

{$IFNDEF UNICODE}
  function WideStringAsArray(const Params: WideString): TWideStringDynArray;
  var
    I, Prev: Integer;
  begin
    SetLength(Result, 0);
    Prev := 1;
    for I := 1 to Length(Params)+1 do
    begin
      if (I > Length(Params)) or (Params[I] = ',') or (Params[I] = ';') then
      begin
        SetLength(Result, Length(Result)+1);
        Result[Length(Result)-1] := Copy(Params, Prev, I-Prev);
        Prev := I+1;
      end;
    end;
  end;
{$ENDIF}

  function FindNodeByName(Node: IXMLNode; const Name: string): Integer;
  var
    I: Integer;
  begin
    Result := -1;
    for I := 0 to RespNode.ChildNodes.Count-1 do
    begin
      Node := RespNode.ChildNodes[I];
      if SameText(ExtractLocalName(Node.NodeName), Name) then
      begin
        Result := I;
        Break;
      end;
    end;
  end;

  { This is the tricky part of deserializing; How to determine the return index;
    This function should only be used if we're processing a function - IOW, this
    function should only be called if the method we're processing has
    MD.ResultInfo <> nil }

  { EXACT_MATCH_RETURN_PARAM is a safer way to match the return elements with what
    might have been registered for this interface. However, there are couple of issues:
    1. It will only work for interfaces that derived directly from IUnknown/IInvokable.
       That's because we cannot compute the index of the method within the interface
       from its position in the vtable otherwise. When the interface derives from
       IInvokable we know that there are only 3 methods in the base interface.
    2. In previous versions we used all names registered on each method.
      Of course this latter behaviour (#2) is what's error prone for cases where a wacky
      service has the name of an out element of an operation match that of the
      the out of another element of another operation and we made only one of the
      two the return element

      Of course the 'parameterOrder' attribute was meant to help with fuzzy detection
      of the return value part but hardly anyone uses it - including Delphi :( }

  { SOAP 1.2 and RPC encoded now tell you which node is the result node
    Example: (xxx is the result node)
      <e:Body>
        <m:GetTradePriceResponse>
          <rpc:result>xxx</rpc:result>
          <xxx>34.5</xxx>
        </m:GetTradePriceResponse>
      </e:Body> }

  function FindReturnNodeIndex(const ReturnName: string): Integer;
  var
    X, First, Ret, Count: Integer;
    Node: IXMLNode;
{$IFNDEF UNICODE}
    ReturnParams: TWideStringDynArray;
{$ELSE}
    ReturnParams: TStringDynArray;
{$ENDIF}
    ResultNodeName: InvString;
{$IFDEF EXACT_MATCH_RETURN_PARAM}
    ReturnParam: InvString;
{$ELSE}
    Y: Integer;
{$ENDIF}
  begin
    Result := -1;

    // Check SOAP 1.2 default name in rpc|enc
    if (soSOAP12 in Options) and (not UsingLiteralEncoding) then
    begin
      // Find the name of the result node
      for X := 0 to RespNode.ChildNodes.Count-1 do
      begin
        Node := RespNode.ChildNodes[X];
        if SameText(ExtractLocalName(Node.NodeName), SDefaultResultName) and
           SameText(Node.NamespaceURI, SSOAP12RPCNamespace) then
        begin
          ResultNodeName := Node.Text;
          Break;
        end;
      end;

      Result := FindNodeByName(RespNode, ResultNodeName);
    end;

    if Result = -1 then
    begin
      //Check for registered return name
      if ReturnName <> '' then
      begin
        Result := FindNodeByName(RespNode, ReturnName);
      end;

      // If nothing has worked fall back on previous logic...
      if Result = -1 then
      begin
        First := -1;
        Ret := -1;
        Count := 0;

        { Get array of return parameter names }
{$IFNDEF UNICODE}
        ReturnParams := WideStringAsArray(InvRegistry.GetReturnParamNames(IntfMD.Info));
{$ELSE}
        ReturnParams := StringToStringArray(InvRegistry.GetReturnParamNames(IntfMD.Info), ';,');
{$ENDIF}
  {$IFDEF EXACT_MATCH_RETURN_PARAM}
        if (Length(ReturnParams) > (MD.Pos-3)) then
          ReturnParam := ReturnParams[MD.Pos-3]
        else
          ReturnParam := '';
  {$ENDIF}
        for X := 0 to RespNode.ChildNodes.Count-1 do
        begin
          Node := RespNode.ChildNodes[X];
          if Node.NodeType <> ntElement then
            Continue;
          { Save first valid node }
          if First = -1 then
            First := X;
          { Save Return param name(s) matches }
  {$IFDEF EXACT_MATCH_RETURN_PARAM}
          if (Ret = -1) and (Length(ReturnParam) > 0)  then
            if SameText(ExtractLocalName(Node.NodeName), ReturnParam) then
              Ret := X;
  {$ELSE}
          if (Ret = -1) and (Length(ReturnParams) > 0)  then
          begin
            for Y := 0 to Length(ReturnParams)-1 do
            begin
              if SameText(ExtractLocalName(Node.NodeName), ReturnParams[Y]) then
                Ret := X;
            end;
          end;
  {$ENDIF}
          Inc(Count);
        end;

        if Count = 1 then
          Result := First
        else
          Result := Ret;
      end;
    end;
  end;

  function IsNillable(TypeInfo: PTypeInfo): Boolean;
  begin
    Result := (TypeInfo.Kind = tkClass) or
              (TypeInfo.Kind = tkVariant);
  end;

var
  I, J, RetIndex: Integer;
  InvData: Pointer;
  Node: IXMLNode;
  XMLOptions: Integer;
  ParamProcessed: TBooleanDynArray;
  UnboundedArrayRet: Boolean;
  ParamName, ExtMethodName, ReturnName: InvString;
begin
  SetLength(ParamProcessed, MD.ParamCount);
  for J := 0 to Length(ParamProcessed) - 1 do
    ParamProcessed[J] := False;

  InvRegistry.GetMethodInfo(IntfMD.Info, MD.Name, ExtMethodName, ReturnName, XMLOptions);
  if ReturnName <> '' then
  begin
    if (ReturnName[Low(string)] = INFOATTR_BEG_CHAR) then
      if not GetRegInfo(ReturnName, InfoAttribute.iaMethReturnName,
                        ReturnName) then
        ReturnName := '';
  end;

  { Are we expecting an unbounded array }
  UnboundedArrayRet := (MD.ResultInfo <> nil) and (MD.ResultInfo.Kind = tkDynArray) and
                       (((IS_UNBD and XMLOptions) = IS_UNBD) or
                        (xoInlineArrays in RemClassRegistry.SerializeOptions(MD.ResultInfo)));
  if UnboundedArrayRet then
  begin
    InvData := InvContext.GetResultPointer;
    ConvertSoapToNativeData(InvData, MD.ResultInfo, RespNode, RespNode, True);
    RetIndex := -1;
  end
  else
  begin
    { Find index of return node - if we're expecting one }
    if (MD.ResultInfo <> nil) then
    begin
      RetIndex := FindReturnNodeIndex(ReturnName);
      { We'll be lenient about nillable types }
      if (RetIndex = -1) and not IsNillable(MD.ResultInfo) then
        raise ESOAPDomConvertError.CreateFmt(SMissingSoapReturn, [RespNode.XML]);
    end
    else
      RetIndex := -1;
  end;

  { Process returned nodes }
  if RespNode.HasChildNodes then
  begin
    if (RetIndex <> -1) or (MD.ParamCount > 0) then
    begin
      for I := 0 to RespNode.ChildNodes.Count - 1 do
      begin
        Node := RespNode.ChildNodes[I];
        { Skip non-valid nodes and previously found result node if in RPC and SOAP 1.2 }
        if (Node.NodeType <> ntElement) or
           ((soSOAP12 in Options) and (not UsingLiteralEncoding) and
            SameText(ExtractLocalName(Node.NodeName), SDefaultResultName) and
            SameText(Node.NamespaceURI, SSOAP12RPCNamespace)) then
          Continue;
        { Process Return value, if we're expecting one }
        if I = RetIndex then
        begin
          InvData := InvContext.GetResultPointer;
          ConvertSoapToNativeData(InvData, MD.ResultInfo, RespNode, Node, True);
        end
        else
        begin
          J := 0;
          while J < MD.ParamCount do
          begin
            ParamName := InvRegistry.GetParamExternalName(IntfMD.Info, MD.Name, MD.Params[J].Name);
            if ParamName = ExtractLocalName(Node.NodeName) then
              break;
            Inc(J);
          end;
          if (J < MD.ParamCount) and not ParamProcessed[J]  then
          begin
            ParamProcessed[J] := True;
            InvData := InvContext.GetParamPointer(J);
{$IF CompilerVersion < 23.0}
            if IsParamByRef(MD.Params[J].Flags, MD.Params[J].Info, MD.CC) then
              InvData := Pointer(InvData^);
{$IFEND}
            ConvertSoapToNativeData(InvData, MD.Params[J].Info, RespNode, Node, True);
          end;
        end;
      end;
    end;
  end else if (MD.ResultInfo <> nil) and IsNillable(MD.ResultInfo) and (not UnboundedArrayRet) then
  begin
    InvData := InvContext.GetResultPointer;
    ConvertSoapToNativeData(InvData, MD.ResultInfo, RespNode, nil, True);
  end;
end;


{$DEFINE LOAD_FAULT_VIA_LOADOBJECT}
procedure TOPToSoapDomConvert.ProcessFault(FaultNode: IXMLNode);

  function GetNodeURIAndName(const Node: IXMLNode; var TypeURI, ElemName: InvString): boolean;
  var
    Pre: InvString;
  begin
    ElemName := Node.NodeName;
    if IsPrefixed(ElemName) then
    begin
      Pre := ExtractPrefix(ElemName);
      ElemName := ExtractLocalName(ElemName);
      TypeURI := Node.FindNamespaceURI(Pre);
    end
    else
      TypeURI := Node.NamespaceURI;
    Result := True;
  end;

var
  CustNode, CurrNode: IXMLNode;
  FaultActorNode, FaultCodeNode, FaultDetailNode, FaultStringNode: IXMLNode;
  FaultReasonNode, FaultNodeNode, FaultRoleNode: IXMLNode;
  I: Integer;
  AMessage: InvString;
  AClass: TClass;
  URI, TypeName, LocalName, ReasonLang: InvString;
{$IFNDEF LOAD_FAULT_VIA_LOADOBJECT}
  J, Count: Integer;
  PropList: PPropList;
{$ENDIF}
  Ex: ERemotableException;
begin
  FaultActorNode := nil;
  FaultCodeNode := nil;
  FaultDetailNode := nil;
  FaultStringNode := nil;
  FaultReasonNode := nil;
  FaultNodeNode := nil;
  FaultRoleNode := nil;
  Ex := nil;

  if soSOAP12 in Options then
  begin
    for I := 0 to FaultNode.ChildNodes.Count - 1 do
    begin
      CurrNode := FaultNode.ChildNodes[I];
      LocalName := ExtractLocalName(CurrNode.NodeName);

      if SameText(LocalName, SSOAP12FaultCode) then
        FaultCodeNode := CurrNode
      else if SameText(LocalName, SSOAP12FaultReason) then
      begin
        CurrNode := CurrNode.ChildNodes.FindNode(SSOAP12FaultText);
        if CurrNode <> nil then
          FaultReasonNode := CurrNode;
      end
      else if SameText(LocalName, SSOAP12FaultNode) then
        FaultNodeNode := CurrNode
      else if SameText(LocalName, SSOAP12FaultRole) then
        FaultRoleNode := CurrNode
      else if SameText(LocalName, SSOAP12FaultDetail) then
        FaultDetailNode := CurrNode;
    end;

    if FaultReasonNode <> nil then
    begin
      AMessage := FaultReasonNode.Text;
      for I := 0 to FaultReasonNode.AttributeNodes.Count - 1 do
      begin
        CurrNode := FaultReasonNode.AttributeNodes[i];
        if SameText(ExtractLocalName(CurrNode.NodeName), SSOAP12FaultReasonLang) then
          ReasonLang := CurrNode.Text;
      end;
    end;
  end
  else
  begin
    for I := 0 to FaultNode.ChildNodes.Count - 1 do
    begin
      CurrNode := FaultNode.ChildNodes[I];
      LocalName := ExtractLocalName(CurrNode.NodeName);

      if SameText(LocalName, SSoapFaultCode) then
        FaultCodeNode := CurrNode
      else if SameText(LocalName, SSoapFaultString) then
        FaultStringNode := CurrNode
      else if SameText(LocalName, SSoapFaultDetails) then
        FaultDetailNode := CurrNode
      else if SameText(LocalName, SSoapFaultActor) then
        FaultActorNode := CurrNode;
    end;

    { Retrieve message from FaultString node }
    if FaultStringNode <> nil then
      AMessage := FaultStringNode.Text;
  end;

  { Fallback on detail node if exception fault is empty, then fallback on whole xml node }
  if (AMessage = '') then
  begin
    if Assigned(FaultDetailNode) then
      AMessage := FaultDetailNode.XML
    else
      AMessage := FaultNode.XML;
  end;

  { If there's a <detail> node, try to map it to a registered type }
  if FaultDetailNode <> nil then
  begin
    { Some SOAP stacks, including Delphi6 and others (see
      http://softwaredev.earthweb.com/script/article/0,,12063_641361_2,00.html)
      use the approach of putting custom fault info right at the <detail> node:

      Listing 4 - Application Fault Details
      <SOAP-ENV:Fault>
        <faultcode>300</faultcode>
        <faultstring>Invalid Request</faultstring>
        <runcode>1</runcode>
        <detail xmlns:e="GetTemperatureErr-URI"
                xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance"
                xsi:type="e:GetTemperatureFault">
            <number>5575910</number>
            <description>Sensor Failure</description>
            <file>GetTemperatureClass.cpp</file>
            <line>481</line>
        </detail>
      </SOAP-ENV:Fault>

      However, much more common is the approach where the type and namespace
      are on the childnode of the <detail> node. Apache, MS and the SOAP spec.
      seem to lean towards that approach:

      Example 10 from the SOAP 1.1 Spec:

      <SOAP-ENV:Envelope
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
         <SOAP-ENV:Body>
             <SOAP-ENV:Fault>
                 <faultcode>SOAP-ENV:Server</faultcode>
                 <faultstring>Server Error</faultstring>
                 <detail>
                     <e:myfaultdetails xmlns:e="Some-URI">
                       <message>
                         My application didn't work
                       </message>
                       <errorcode>
                         1001
                       </errorcode>
                     </e:myfaultdetails>
                 </detail>
             </SOAP-ENV:Fault>
         </SOAP-ENV:Body>
      </SOAP-ENV:Envelope>

      For interop reasons we favor the later approach but we'll support both here!!
    }
    CustNode := nil;
    if GetElementType(FaultDetailNode, URI, TypeName) then
      CustNode := FaultDetailNode
    else
    begin
      if ntElementChildCount(FaultDetailNode) > 0 then
      begin
        CustNode := ntElementChild(FaultDetailNode, 0);
        if not GetElementType(CustNode, URI, TypeName) and
           not GetNodeURIAndName(CustNode, URI, TypeName) then
          CustNode := nil;
      end;
    end;

    if (CustNode <> nil) then
    begin
      AClass := RemClassRegistry.URIToClass(URI, TypeName);
      if AClass <> nil then
      begin
        if AClass.InheritsFrom(ERemotableException) then
        begin
          Ex := ERemotableExceptionClass(AClass).Create(AMessage);
{$IFDEF LOAD_FAULT_VIA_LOADOBJECT}
          LoadObject(Ex, FaultNode, CustNode);
{$ELSE}
          Count := GetTypeData(Ex.ClassInfo)^.PropCount;
          if (Count > 0) and Assigned(CustNode.ChildNodes) then
          begin
            GetMem(PropList, Count * SizeOf(Pointer));
            try
              GetPropInfos(Ex.ClassInfo, PropList);
              for I := 0 to Count - 1 do
              begin
                for J := 0 to CustNode.ChildNodes.Count - 1 do
                begin
                  CurrNode := CustNode.ChildNodes[J];
                  LocalName := ExtractLocalName(CurrNode.NodeName);

                  if CurrNode.NodeType <> ntElement then
                    continue;
                  if LocalName = PropList[I].Name then
                    SetObjectPropFromText(Ex, PropList[I], GetNodeAsText(CurrNode));
                end;
              end;
            finally
              FreeMem(PropList, Count * SizeOf(Pointer));
            end;
          end;
{$ENDIF}
        end;
      end;
    end;
  end;

  { Create default SOAP invocation exception if no suitable class was found }
  if Ex = nil then
    Ex := ERemotableException.Create(AMessage);

  { Fill all found exception info }
  if FaultActorNode <> nil then
    Ex.FaultActor := FaultActorNode.Text;
  if FaultCodeNode <> nil then
  begin
    if soSOAP12 in Options then
      Ex.FaultCode := FaultCodeNode.XML
    else
      Ex.FaultCode := FaultCodeNode.Text;
  end;
  if FaultDetailNode <> nil then
    Ex.FaultDetail := FaultDetailNode.XML;
  if FaultNodeNode <> nil then
    Ex.FaultNode := FaultNodeNode.Text;
  if FaultRoleNode <> nil then
    Ex.FaultRole := FaultRoleNode.Text;
  if ReasonLang <> '' then
    Ex.FaultReasonLang := ReasonLang;

  raise Ex;
end;


procedure TOPToSoapDomConvert.ProcessResponse(const Resp: InvString;
                                              const IntfMD: TIntfMetaData;
                                              const MD: TIntfMethEntry;
                                              Context: TInvContext);
var
 Stream: TMemoryStream;
begin
   Stream := TMemoryStream.Create;
  try
    Stream.Write(Resp[Low(string)], Length(Resp)*2);
    ProcessResponse(Stream, IntfMD, MD, Context, nil);
  finally
    Stream.Free;
  end
end;

procedure TOPToSoapDomConvert.ProcessResponse(const XMLDoc: IXMLDocument;
                                              const IntfMD: TIntfMetaData;
                                              const MD: TIntfMethEntry;
                                              Context: TInvContext;
                                              Headers: THeaderList);
var
  I, J, RespNodeIndex: Integer;
  EnvNode, RespNode, Node, HdrNode, FaultNode: IXMLNode;
  ProcessedHeader, ProcessedBody: Boolean;
begin
  CreateHREFList(Self, XMLDoc.Node);
  EnvNode := XMLDoc.DocumentElement;
  if EnvNode = nil then
    raise ESOAPDomConvertError.Create(SInvalidResponse);
  if (ExtractLocalName(EnvNode.NodeName) <> SSoapEnvelope) or
     ((EnvNode.NamespaceURI <> SoapEnvelopeNamespaces[soSOAP12 in Options]) and
      (EnvNode.NamespaceURI <> SoapEnvelopeNamespaces[not (soSOAP12 in Options)])) then
    raise ESOAPDomConvertError.CreateFmt(SWrongDocElem, [SoapEnvelopeNamespaces[soSOAP12 in Options],
                                                        SSoapEnvelope, EnvNode.NamespaceURI,
                                                        ExtractLocalName(EnvNode.NodeName)]);
  ProcessedHeader := False;
  ProcessedBody := False;
  if EnvNode.hasChildNodes then
  begin
    for I := 0 to EnvNode.childNodes.Count -1 do
    begin
      { Skip to first ntElement node }
      Node := EnvNode.childNodes[I];
      if Node.NodeType <> ntElement then
        continue;

      { Is node a Header Node }
      if ExtractLocalName(Node.NodeName) = SSoapHeader then
      begin
        { If we've already processed header, we have an invalid Response }
        if ProcessedHeader then
          raise ESOAPDomConvertError.Create(SInvalidSOAPResponse);

        ProcessedHeader := True;
        if Node.hasChildNodes then
        begin
          for J := 0 to Node.childNodes.Count-1 do
          begin
            HdrNode := Node.childNodes[J];
            if HdrNode.NodeType <> ntElement then
              continue;
            ReadHeader(EnvNode, HdrNode, Headers);
          end;
        end;
      end
      else if ExtractLocalName(Node.NodeName) = SSoapBody then
      begin
        if ProcessedBody then
          raise ESOAPDomConvertError.Create(SInvalidSOAPResponse);
        ProcessedBody := True;

        { Find the response node -- }
        { In literal mode, the body node is the response node for processing Success... }
//        if (soLiteralParams in Options) then
        if IsBareLiteral then
        begin
          RespNode := Node;
          { Unless there's a fault }
          if RespNode.HasChildNodes then
          begin
            if (ntElementChildCount(RespNode) > 0) then
            begin
              FaultNode := ntElementChild(RespNode, 0);
              if ExtractLocalName(FaultNode.NodeName) = SSoapFault then
                RespNode := FaultNode;
            end;
          end;
        end
        else
        begin
          if Node.HasChildNodes then
          begin
            RespNode := nil;
            { Skip non-ntElement nodes }
            RespNodeIndex := 0;
            while (Node.childNodes[RespNodeIndex].NodeType <> ntElement) and
                  (RespNodeIndex < Node.ChildNodes.Count) do
              Inc(RespNodeIndex);
            if RespNodeIndex < Node.ChildNodes.Count then
              { Response Node found - NOTE: Much better would be to use root attribute!! }
              RespNode := Node.childNodes[RespNodeIndex];
          end;
        end;

        if RespNode <> nil then
        begin
          try
            if ExtractLocalName(RespNode.NodeName) = SSoapFault then
              ProcessFault(RespNode)
            else
              ProcessSuccess(RespNode, IntfMD, MD, Context);
          finally
            ResetMultiRef;
          end;
        end;
      end;
    end
  end else
    raise ESOAPDomConvertError.Create(SInvalidSOAPRequest);
end;

procedure TOPToSoapDomConvert.ProcessResponse(const Resp: TStream;
                                              const IntfMD: TIntfMetaData;
                                              const MD: TIntfMethEntry;
                                              Context: TInvContext;
                                              Headers: THeaderList);
var
  XMLDoc: IXMLDocument;
begin
  XMLDoc := NewXMLDocument;
  XMLDoc.Encoding := FEncoding;
  Resp.Position := 0;
  XMLDoc.LoadFromStream(Resp);
  ProcessResponse(XMLDoc, IntfMD, MD, Context, Headers);
end;

constructor TOPToSoapDomConvert.Create(AOwner: TComponent);
begin
  inherited;
  Envelope := TSoapEnvelope.Create;
  FIDs := 1;
  Options := Options + [soSendMultiRefObj,
                        soRootRefNodesToBody,
                        soTryAllSchema,
                        soCacheMimeResponse,
                        soUTF8EncodeXML ];
end;

destructor TOPToSoapDomConvert.Destroy;
begin
  Envelope.Free;
  inherited;
end;

function TOPToSoapDomConvert.GetAttachments: TSoapDataList;
begin
  Result := FAttachments;
end;

procedure TOPToSoapDomConvert.SetAttachments(Value: TSoapDataList);
begin
  FAttachments := Value;
end;

function TOPToSoapDomConvert.GetTempDir: string;
begin
  Result := FTempDir;
end;

procedure TOPToSoapDomConvert.SetTempDir(const Value: string);
begin
  FTempDir := Value;
  if (Value <> '') and (Value[High(Value)] <> PathDelim) then
    FTempDir := FTempDir + PathDelim;
end;

function TOPToSoapDomConvert.GetEncoding: DOMString;
begin
  Result := FEncoding;
end;

function TOPToSoapDomConvert.NewXMLDocument: IXMLDocument;
begin
  Result := Xml.XMLDoc.NewXMLDocument;
{$IFDEF MSWINDOWS}
{$IFDEF DEVELOPERS}
  { For testing purposes - make sure we handle WhiteSpace properly }
  Result.Options := Result.Options - [doNodeAutoIndent];
  Result.ParseOptions := Result.ParseOptions - [poPreserveWhiteSpace];
{$ENDIF}
{$ENDIF}
end;

procedure TOPToSoapDomConvert.SetEncoding(const Encoding: DOMString);
begin
  FEncoding := Encoding;
end;

procedure TOPToSoapDomConvert.CheckWSDL;
begin
  if Assigned(WSDLView.WSDL) then
  begin
    WSDLView.Activate;
  end
  else
    raise ESOAPDomConvertError.Create(SNoWSDL);
end;

function TOPToSoapDomConvert.GetBinding: InvString;
var
  QName: IQualifiedName;
begin
  CheckWSDL;
  QName := WSDLView.WSDL.GetBindingForServicePort(WSDLView.Service, WSDLView.Port);
  if QName <> nil then
    Result := QName.Name;
end;

procedure TOPToSoapDomConvert.SetWSDLView(const WSDLView: TWSDLView);
begin
  FWSDLView := WSDLView;
end;

{ ParamName = '' implies function return value }
function TOPToSoapDomConvert.GetPartName(MethMD: TIntfMetaData; const ParamName: InvString): InvString;
begin
  if ParamName = '' then
    Result := SDefaultReturnName
  else
    Result := InvRegistry.GetNamespaceByGUID(MethMD.IID);
end;


{ TSOAPDomConv }
constructor TSOAPDomConv.Create(AOwner: TComponent);
begin
  inherited;
  FAttachments := TSoapDataListEx.Create;
  FRefCache := TRefCache.Create();
end;

destructor TSOAPDomConv.Destroy;
begin
  FRefCache.Free;
  FAttachments.Free;
  inherited;
end;

procedure TSOAPDomConv.AddAttachment(Attachment: TSOAPAttachment; const AContentId: string);
var
  Attach: TSOAPAttachmentData;
begin
  Attach := TSOAPAttachmentData.Create;
  with Attach do
  begin
    Id := AContentId;
    Headers.Add(Format(SContentId + ': <%s>', [AContentId]));
    if Attachment.CacheFile <> '' then
      SetCacheFile(Attachment.CacheFile)
    else if Assigned(Attachment.SourceStream) then
    begin
      SetSourceStream(Attachment.SourceStream, Attachment.Ownership);
      Attachment.Ownership := soReference;
    end else SourceString := Attachment.SourceString;
    DataContext := Nil;
  end;
  Attach.ContentType := Attachment.ContentType;
  Attach.Encoding := Attachment.Encoding;
  FAttachments.Add(Attach);
end;


function TSOAPDomConv.FindAttachment(const AContentId: string): TSOAPAttachment;

  function SameId(Id1, Id2: string): Boolean;
  begin
    { if by ContentId, extract Id by removing 'cid:' and compare }
    if AnsiSameText(SAttachmentIdPrefix, Copy(Id2, 2, Length(SAttachmentIdPrefix))) then
      Result := AnsiSameText(Id1, '<' + Copy(Id2, Pos(':', Id2) + 1, MaxInt))
    { GLUE uses http:// to identify ContentId }
    else if AnsiSameText(sHTTPPrefix, Copy(Id2, 2, Length(SHTTPPrefix))) then
      Result := AnsiSameText(Id1, Id2)
    else  { if by location, extract Location by removing DefaultBaseURI }
    begin
      if Pos(SDefaultBaseURI, Id2) = 1 then
        Result := AnsiSameText(Id1, Copy(Id2, Length(SDefaultBaseURI) + 1, MaxInt))
      else  { extract Location by removing name space }
        Result := AnsiSameText(Id1, '<' + Copy(Id2, Pos(':', Id2) + 1, MaxInt));
    end;
  end;

var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FAttachments.Count -1 do
  begin
    if SameId(TSOAPAttachmentData(FAttachments[I]).ID, AContentId) then
    begin
      Result := FAttachments[I];
      Break;
    end;
  end;
end;


procedure TSOAPDomConv.ConvertVariantToSoap(RootNode, Node: IXMLNode; const Name, NodeNamespace: InvString;
  Info: PTypeInfo; P: PVarData; V: Variant; UseVariant: Boolean);
var
  DataP: Pointer;
begin
  if UseVariant then
  begin
    if VarIsNull(V) then
      CreateNULLNode(RootNode, Node, Name)
    else
      WriteVariant(RootNode, Node, Name, NodeNamespace, V);
  end else
  begin
    DataP := P;
    if (DataP = nil) or VarIsNull(Variant(DataP^)) then
      CreateNULLNode(RootNode, Node, Name)
    else
      WriteVariant(RootNode, Node, Name, NodeNamespace, Variant(DataP^));
  end;
end;

function IsXMLDateTimeTypeInfo(const Info: PTypeInfo): Boolean;
begin
  Result := ((Info.Kind = tkClass) and (GetTypeData(Info).ClassType = TXSDateTime)) or
            ((Info.Kind = tkFloat) and (Info = TypeInfo(TDateTime)));
end;


procedure TSOAPDomConv.WriteVariant(RootNode, Node: IXMLNode; const Name, NodeNamespace: InvString; V: Variant);
const
  sBoolean: array[Boolean] of string = ('0', '1');
var
  S, TypeNamespace, TypeName: InvString;
  Info: PTypeInfo;
  IsScalar: Boolean;
begin
  if VarIsArray(V) then
  begin
    if VarIsType(V, varByte or varArray) then
      WriteVarArrayAsB64(RootNode, Node, Name, V)
    else
      WriteVarArray(RootNode, Node, Name, NodeNamespace, V);
  end
  else
  begin
    if VarIsNull(V) or VarIsEmpty(V) then
       CreateNULLNode(RootNode, Node, Name)
    else
    begin
      Info :=  RemTypeRegistry.VariantToInfo(V, soTryAllSchema in Options);
      if Info = nil then
         raise ESOAPDomConvertError.Create(SUnsupportedVariant);
      if IsXMLDateTimeTypeInfo(Info) then
        S := DateTimeToXMLTime(V)
      else if Info = TypeInfo(System.Boolean) then
        S := sBoolean[Boolean(V)]
      else
        S := V;

      RemTypeRegistry.InfoToURI(Info, TypeNamespace, TypeName, IsScalar);
      if UsingLiteralEncoding then
        CreateScalarNodeXS(RootNode, Node, Name, NodeNamespace, TypeName, S)
      else
        CreateScalarNodeXS(RootNode, Node, Name, TypeNamespace, TypeName, S);
    end;
  end;
end;

function TSOAPDomConv.MakeArrayNode(RootNode, Node: IXMLNode; const Name, URI, TypeName: InvString;
                                    Indices: array of NativeInt): IXMLNode;
var
  ArraySpec, Dims: InvString;
  I: Integer;
  First: Boolean;
  SoapPre, Pre, TypeNs: InvString;
  ID: string;
  MultiRefNode: IXMLNode;
begin
  if UsingLiteralEncoding then
    Result := Node.AddChild(Name, URI)
  else
  begin
    if (soSendMultiRefArray in Options) and not UsingLiteralEncoding then
    begin
      ID := GetNewID;
      Pre := FindPrefixForURI(RootNode, Node,  URI, True);
      Result := Node.AddChild(MakeNodeName(Pre, Name));

      if not (soSOAP12 in Options) then
        Result.Attributes[SXMLHREF] := SHREFPre + ID
      else
        Result.SetAttributeNS(SSOAP12XMLHREF, SSoap12EncodingNamespace, ID);

      Pre := FindPrefixForURI(RootNode, Node, SoapEncodingNamespaces[soSOAP12 in Options], True);
      MultiRefNode := CreateMultiRefNode(RootNode, MakeNodeName(Pre, SSoapEncodingArray), ID);   { do not localize }
      SetNodeType(RootNode, MultiRefNode, SoapEncodingNamespaces[soSOAP12 in Options], SSoapEncodingArray);
      Result := MultiRefNode;
    end else
    begin
      MultiRefNode := nil;
      if UsingLiteralEncoding then
        TypeNS := URI
      else
        TypeNS := SoapEncodingNamespaces[soSOAP12 in Options];

      Result := CreateTypedNode(RootNode, Node, Name, TypeNS, SSoapEncodingArray);
    end;

    if not (soSendUntyped in Options) and not UsingLiteralEncoding then
    begin
      I := 0;
      if Indices[I] = 0 then
      begin
        while (I < Length(Indices) - 1) and (Indices[I] = 0) do
        begin
          Dims := Dims + '[]';    { do not localize }
          Inc(I);
        end;
      end;

      First := True;
      if I < Length(Indices)  then
      begin
        if not (soSOAP12 in Options) then
          Dims := Dims + '[';          { do not localize }
        while I < Length(Indices)  do
        begin
          if not First then
          begin
            Dims := Dims + ',';      { do not localize }
          end;
          First := False;
          Dims := Dims + IntToStr(Indices[I]);
          Inc(I);
        end;
        if not (soSOAP12 in Options) then
          Dims := Dims +  ']';       { do not localize }
      end;

      if soSOAP12 in Options then
      begin
        { SOAP 1.2 - <node SOAP-ENC:itemType="Pre:Typename" arraySize="Dims"> }
        SoapPre := FindPrefixForURI(RootNode, Node, SoapEncodingNamespaces[soSOAP12 in Options], True);
        Pre := FindPrefixForURI(RootNode, Node, URI, True);
        ArraySpec := Pre + ':' + TypeName;     { do not localize }
        Result.SetAttributeNS(SSoapEncodingArrayTypes[soSOAP12 in Options], SoapEncodingNamespaces[soSOAP12 in Options], ArraySpec);
        Result.SetAttributeNS(SSoap12EncodingArraySize, SoapEncodingNamespaces[soSOAP12 in Options], Dims);
      end
      else
      begin
        { SOAP 1.1 - <node SOAP-ENC:arrayType="Pre:Typename[Dims]"> }
        SoapPre := FindPrefixForURI(RootNode, Node, SoapEncodingNamespaces[soSOAP12 in Options], True);
        Pre := FindPrefixForURI(RootNode, Node, URI, True);
        ArraySpec := Pre + ':' + TypeName + Dims;     { do not localize }
        Result.SetAttributeNS(SSoapEncodingArrayType, SoapEncodingNamespaces[soSOAP12 in Options], ArraySpec);
      end;
    end;
  end;
end;

function TSOAPDomConv.MakeArrayNode(RootNode, Node: IXMLNode; const Name, URI, TypeName: InvString;
                                    Dim, Len: Integer): IXMLNode;
var
  ArrayDims: TNativeIntDynArray;
  I: Integer;
begin
  SetLength(ArrayDims, Dim);
  for I := 0 to Dim - 2 do
    ArrayDims[I] := 0;
  ArrayDims[Dim-1] := Len;
  Result := MakeArrayNode(RootNode, Node,
                          Name, URI, TypeName, ArrayDims);
end;

procedure TSOAPDomConv.WriteVarArrayAsB64(RootNode, Node: IXMLNode; const Name: InvString; V: Variant);
var
  I, DimCount, VSize: Integer;
  LoDim, HiDim: array of Integer;
  P: Pointer;
  Encd: InvString;
  ElemNode: IXMLNode;
  BorlPrefix: DOMString;
begin
  DimCount := VarArrayDimCount(V);
  SetLength(LoDim, DimCount);
  SetLength(HiDim, DimCount);
  for I := 1 to DimCount do
  begin
    LoDim[I - 1] := VarArrayLowBound(V, I);
    HiDim[I - 1] := VarArrayHighBound(V, I);
  end;
  VSize := 0;
  for i := 0 to DimCount - 1 do
    VSize := VSize + (HiDim[i] - LoDim[i] + 1);
  P := VarArrayLock(V);
  try
    Encd := InvString(EncodeBase64(P, VSize));
  finally
    VarArrayUnlock(V);
  end;
  ElemNode := CreateScalarNodeXS(RootNode, Node, Name, XMLSchemaNamespace, 'base64Binary', Encd);   { do not localize }
  if not (soDontSendVarArrayType in Options) then
  begin
    BorlPrefix := FindPrefixForURI(RootNode, ElemNode, SBorlandTypeNamespace, True);
    ElemNode.SetAttributeNS(MakeNodeName(BorlPrefix, SVarArrayType),
                            SBorlandTypeNamespace,
                            VarType(V));
  end;
end;

procedure TSOAPDomConv.WriteVarArray(RootNode, Node: IXMLNode; const Name, NodeNamespace: InvString; V: Variant);
var
  I, DimCount: Integer;
  LoDim, HiDim, Indices: array of integer;
  V1: Variant;
  ElemNode: IXMLNode;
  VAPropSet: Boolean;
  BorlPrefix: DOMString;
begin
  if  not VarIsArray(V) then
  begin
    WriteVariant(RootNode, Node, Name, NodeNamespace, V);
  end
  else
  begin
    ElemNode := Node.AddChild(Name);
    DimCount := VarArrayDimCount(V);
    SetLength(LoDim, DimCount);
    SetLength(HiDim, DimCount);
    for I := 1 to DimCount do
    begin
      LoDim[I - 1] := VarArrayLowBound(V, I);
      HiDim[I - 1] := VarArrayHighBound(V, I);
    end;
    SetLength(Indices, DimCount);
    for I := 0 to DimCount - 1 do
      Indices[I] := LoDim[I];
    VAPropSet := False;
    while True do
    begin
      V1 := VarArrayGet(V, Indices);
      if VarIsArray(V1) and not VarIsType(V1, varArray or varByte) then
      begin
        WriteVarArray(RootNode, ElemNode, SDefVariantElemName, NodeNamespace, V1);
        if not (soDontSendVarArrayType in Options) then
        begin
          BorlPrefix := FindPrefixForURI(RootNode, ElemNode, SBorlandTypeNamespace, True);
          ElemNode.SetAttributeNS(MakeNodeName(BorlPrefix, SVarArrayType),
                                  SBorlandTypeNamespace,
                                  VarType(V));
        end;
      end
      else
      begin
        WriteVariant(RootNode, ElemNode, SDefVariantElemName, NodeNamespace, V1);
        if not (soDontSendVarArrayType in Options) then
        begin
          if not VAPropSet then
          begin
            BorlPrefix := FindPrefixForURI(RootNode, ElemNode, SBorlandTypeNamespace, True);
            ElemNode.SetAttributeNS(MakeNodeName(BorlPrefix, SVarArrayType),
                                    SBorlandTypeNamespace,
                                    VarType(V));
            VAPropSet := True;
          end;
        end;
      end;
      Inc(Indices[DimCount - 1]);
      if Indices[DimCount - 1] > HiDim[DimCount - 1] then
        for i := DimCount - 1 downto 0 do
          if Indices[i] > HiDim[i] then
          begin
            if i = 0 then Exit;
            Inc(Indices[i - 1]);
            Indices[i] := LoDim[i];
          end;
    end;
  end;
end;

function  TSOAPDomConv.ReadVarArrayDim(Node: IXMLNode; IsVarVArray: Boolean; VT: TVarType): Variant;
var
  Count, I, VarIndex: Integer;
  SoapTypeInfo: PTypeInfo;
  ChildNode: IXMLNode;
  TypeURI, TypeName: InvString;
begin
  { Get count of ntElement children node }
  Count := ntElementChildCount(Node);
  if Count = 0 then
  begin
    { varArray|varByte don't have child nodes as the data is base64 encoded.
      So handle this here }
    if VT = (varArray or varByte) then
    begin
      TypeTranslator.CastSoapToVariant(TypeInfo(TByteDynArray), GetNodeAsText(Node), @Result);
      Exit;
    end
    else
    begin
      { Something is potentially wrong here. It might be better to look at the
        node some more before assuming it's NULL }
      Result := NULL;
      Exit;
    end;
  end;

  {
    Also, we could use the TVarType to (re)create a Variant of the
    original array type; Using VarVariant, however, is more
    resilient; and as long as no one cracks the Variant open - i.e.
    casts to TVarData and starts accessing members directly - we're safe.
    Sure hopes no one does that!!
  }
  VarIndex := 0;
  Result := VarArrayCreate([0, Count -1], VarVariant);
  for I := 0 to Node.ChildNodes.Count -1 do
  begin
    ChildNode := Node.ChildNodes[I];
    { Skip non-valid nodes }
    if ChildNode.NodeType <> ntElement then
      continue;

    IsVarVArray := IsNodeAVarArray(ChildNode, VT);
    if IsVarVarray or (ntElementChildCount(ChildNode) > 1) then
    begin
      Result[VarIndex] := ReadVarArrayDim(ChildNode, IsVarVArray, VT);
    end else
    begin
      if not NodeIsNULL(ChildNode) then
      begin
        GetElementType(ChildNode, TypeURI, TypeName);
        SoapTypeInfo := RemTypeRegistry.XSDToTypeInfo(TypeURI, TypeName);
        if SoapTypeInfo = nil then
          SoapTypeInfo := TypeInfo(System.string);
        { Handle 'dateTime' }
        if IsXMLDateTimeTypeInfo(SoapTypeInfo) and ChildNode.IsTextElement then
        begin
          Result[VarIndex] := XMLTimeToDateTime(ChildNode.Text);
        end else
                                                                                                        
          Result[VarIndex] := TypeTranslator.CastSoapToVariant(SoapTypeInfo, ChildNode.Text);
      end else
        Result[VarIndex] := NULL;
    end;
    Inc(VarIndex);
  end;
end;

function TSOAPDomConv.IsNodeAVarArray(const Node: IXMLNode; var VT: TVarType): Boolean;
begin
  if not VarIsNull(Node.GetAttributeNS(SVarArrayType, SBorlandTypeNamespace)) then
  begin
    VT := StrToInt(Node.GetAttributeNS(SVarArrayType, SBorlandTypeNamespace));
    Result := True;
  end else if not VarIsNull(Node.GetAttribute(SVarArrayType)) then
  begin
    VT := StrToInt(Node.GetAttribute(SVarArrayType));
    Result := True;
  end else
    Result := False;
end;


procedure TSOAPDomConv.ConvertSoapToVariant(Node: IXMLNode; InvData: Pointer);
var
  Info: PTypeInfo;
  TypeURI, TypeName: InvString;
  IsVarray: Boolean;
  VT: TVarType;
  Count: Integer;
begin
  { No children ?? }
  if not Assigned(Node.ChildNodes) then
    Exit;
  { Zero children }
  Count := ntElementChildCount(Node);
  if Count = 0 then
    Variant(PVarData(InvData)^) := NULL;
  IsVarray := IsNodeAVarArray(Node, VT);
  { First handle base64 encoded data }
  if (Count = 0) and (VT = (varArray or varByte)) then
  begin
    TypeTranslator.CastSoapToVariant(TypeInfo(System.Types.TByteDynArray), GetNodeAsText(Node), InvData);
  end
  { Next arrays with children node }
  else if (Count > 1) or IsVarray then
    Variant(PVarData(InvData)^) := ReadVarArrayDim(Node, IsVarray, VT)
  else
  begin
    GetElementType(Node, TypeURI, TypeName);
    Info := RemTypeRegistry.XSDToTypeInfo(TypeURI, TypeName);
    { If we can't figure out the type, map to a WideString }
    if Info = nil then
      Info := TypeInfo(System.string);
    { Handle dates }
    if IsXMLDateTimeTypeInfo(Info) and Node.IsTextElement then
    begin
      Variant(PVarData(InvData)^) := XMLTimeToDateTime(Node.Text);
    end else
                                                     
      TypeTranslator.CastSoapToVariant(Info, GetNodeAsText(Node), InvData);
  end;
end;

function TSOAPDomConv.FindNodeByHREF(RootNode: IXMLNode; const HREF: InvString): IXMLNode;
var
  I: Integer;
begin
  Result := nil;
  I := FRefCache.FHREFs.IndexOf(HREF);
  if I <> -1 then
    Result := FRefCache.FNodes[Integer(FRefCache.FHREFs.Objects[I])] as IXMLNode;
end;

function RecurseArray(P: Pointer; var Dims: Integer): Boolean;
var
  I, Len, Size: Integer;
  ElemDataP: Pointer;
  Size2: Integer;
begin
  Result := True;
  if Dims > 1 then
  begin
    if not Assigned(P) then
      Exit;
    Len := GetDynArrayLength(P);
    ElemDataP := Pointer(P^);
    Size := GetDynArrayLength(ElemDataP);
    for I := 0 to Len - 1 do
    begin
      Size2 :=  GetDynArrayLength(ElemDataP);
      if Size <> Size2 { GetDynArrayLength(ElemDataP) } then
      begin
        Result := False;
        Exit;
      end;
      if Dims > 1 then
      begin
        Dec(Dims);
        Result := RecurseArray(ElemDataP, Dims);
        if not Result then
          Exit;
      end;
      ElemDataP := PPointer(NativeUInt(P) + SizeOf(Pointer))^;
    end;
  end;
end;

function IsArrayRect(P: Pointer; Dims: Integer): Boolean;
var
  D: Integer;
begin
  D := Dims;
  Result := RecurseArray(P, D);
end;

procedure GetDims(ArrP: Pointer; DimAr: TNativeIntDynArray; Dims: Integer);
var
  I: Integer;
begin
  for I := 0 to Dims - 1 do
  begin
    DimAr[I] := GetDynArrayLength(ArrP);
    if I < Dims - 1 then
    begin
      if Assigned(ArrP) then
        ArrP := Pointer(ArrP^);
    end;
  end;
end;

procedure TSOAPDomConv.WriteRectDynArrayElem(RootNode, Node: IXMLNode;
                                             Info: PTypeInfo;
                                             Size, Dim: Integer;
                                             P: Pointer;
                                             const NodeName: InvString;
                                             const Namespace: InvString = '');
var
  I: Integer;
  S: InvString;
  IsNull: Boolean;
  ArNode: IXMLNode;
  ElemSize: Integer;
  ElemNodeName, ElemTypeNamespace, ElemTypeName: InvString;
  PrevObjectMetaclass: TClass;
  PrevInstance: TObject;
begin
  { Declare the namespace, but not when it is unqualified }
  if Namespace <> '' then
    FindPrefixForURI(RootNode, Node, Namespace, True);

  if Dim > 1 then
  begin
    Dec(Dim);
    for I := 0 to Size-1 do
    begin
      ElemSize := GetDynArrayLength(Pointer(P^));
      WriteRectDynArrayElem(RootNode, Node, Info, ElemSize, Dim, Pointer(P^), NodeName, Namespace);
      P := Pointer(NativeUInt(P) + sizeof(Pointer));
    end;
  end
  else
  begin
    { Determine name of node }
    { NOTE: The way we compute the node name is problematic. We don't have a way
            (place) to store away the name of an element when a pure collection
            is converted into an array:

      The following two cases both translate to the same language binding

          <complexType name="IdCollection1">
            <sequence>
              <element name="count" type="xsd:integer"/>
              <element name="ids" type="xsd:string" maxOccurs="unbounded"/>
            </sequence>
          </complexType>

          <complexType name="IdCollection2">
            <sequence>
              <element name="count" type="xsd:integer"/>
              <element name="ids">
                <complexType>
                  <sequence>
                    <element name="id" type="xsd:string" maxOccurs="unbounded"/>
                  </sequence>
                </complexType>
              </element>
            </sequence>
          </complexType>

          IdCollection1 = class(TRemotable)
            property count: Integer;
            property ids: array of integer;
          end;

          IdCollection2 = class(TRemotable)
            property count: Integer;
            property ids: array of integer;
          end;

      Note that for the 'IdCollection2' we no longer have the 'id' name,
      i.e. the node name of the array element. Oops!!!

      So what are the workarounds:
        1) Enable the 'MapArrayToClasses' option on the importer. This is the easy
           fix. However, the binding no longer has a array. Hence it's a little more
           inconvenient to use the model exposed by the binding.

        2) Encode the name of the element in the type name. IOW.

          type
            id = type Integer;

            IdCollection2 = class(TRemotable)
              property count: Integer;
              property ids: array of id;
            end;

        It's for that second case above that the code below uses the 'TypeName'.
    }
    if UsingLiteralEncoding then
      ElemNodeName := NodeName
    else
      ElemNodeName := DefArrayElemName;

    { Write out data }
    for I := 0 to Size-1 do
    begin
      if Info.Kind = tkClass then
      begin
        { Here we want to pass the typeinfo of the elem type so that if its
          a derived type that we're streaming, we can also set the xsi:type
          attribute }
{$IFDEF FIX_ELEM_NODE_NS}
        PrevObjectMetaclass := ObjectMetaclass;
        PrevInstance := ObjectInstance;
        try
          ObjectMetaclass := GetTypeData(Info).ClassType;
          ObjectInstance := TObject(P^);
{$ENDIF}
          if UsingLiteralEncoding then
          begin
            if not RemTypeRegistry.TypeInfoToXSD(Info, ElemTypeNamespace, ElemTypeName) then
              raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [Info.Name]);
            ConvertObjectToSOAP(ElemNodeName, Namespace, ElemTypeNamespace, P, RootNode,  Node);
          end
          else
            ConvertObjectToSOAP(ElemNodeName, Namespace, '', P, RootNode,  Node)
{$IFDEF FIX_ELEM_NODE_NS}
        finally
          ObjectMetaclass := PrevObjectMetaclass;
          ObjectInstance := PrevInstance;
        end;
{$ENDIF}
      end
      else if Info.Kind = tkVariant then
      begin
        ConvertVariantToSoap(RootNode, Node, ElemNodeName, Namespace, Info, P, NULL, False)
      end
      else
      begin
        if Info.Kind = tkEnumeration then
          S := ConvertEnumToSoap(Info, P)
        else
          TypeTranslator.CastNativeToSoap(Info, S, P, IsNull);

        { Create node }
        if UsingLiteralEncoding then
          ArNode := Node.AddChild(ElemNodeName, Namespace)
        else
          ArNode := Node.AddChild(ElemNodeName, ''); { No namespace prefix }
        { Set Value }
        ArNode.Text := S;
      end;
      P := Pointer( NativeUInt(P) + GetTypeSize(Info));
    end;
  end;
end;

procedure  TSOAPDomConv.WriteRectDynArray(RootNode, Node: IXMLNode; Info: PTypeInfo; Dims: Integer; P: Pointer; const NodeName: InvString);
begin
  WriteRectDynArrayElem(RootNode, Node, Info, GetDynArrayLength(P), Dims, P, NodeName);
end;

function ArrayIsNull(PObj: Pointer): Boolean;
var
  P: Pointer;
begin
  Result := not Assigned(PObj);
  if not Result then
  begin
    P := Pointer(PObj^);
    Result := P = nil;
  end;
end;

function ByteArrayInfo(ElemInfo: PTypeInfo): Boolean;
begin
  { The C++ and Delphi compiler don't agree on the typekind of
    unsigned char/byte:
       Delphi opts for tkInteger(1) while C++ picks tkChar(2)

            ****** Vive la différence!! ***** }
  Result := ((ElemInfo.Kind = tkInteger{Pascal}) or (ElemInfo.Kind = tkChar{C++})) and
             (GetTypeData(ElemInfo).OrdType = otUByte);
end;

procedure TSOAPDomConv.WriteNonRectDynArray(RootNode, Node: IXMLNode;
                                            const Name: InvString;
                                            Info: PTypeInfo;
                                            const URI, TypeName: InvString;
                                            P: Pointer; Dim: Integer);
var
  I, Len: Integer;
  ArrayNode: IXMLNode;
  ElemInfo: PTypeInfo;
  ElemURI, ElemName: InvString;
  PData: Pointer;
begin
  { Retrieve Array Element information }
  ElemInfo := GetDynArrayNextInfo(Info);

  { Handle array of bytes }
  if (Dim = 1) and ByteArrayInfo(ElemInfo) then
  begin
    ConvertByteArrayToSoap(RootNode, Node, Name, URI, Info, P);
    Exit;
  end;

  { Null Array }
  if ArrayIsNull(P) then
  begin
    CreateNullNode(RootNode, Node, Name);
    Exit;
  end;

  Len := GetDynArrayLength(P);
  ArrayNode := MakeArrayNode(RootNode, Node, Name, URI, TypeName, Dim, Len);

  { Write elements }
  for I := 0 to Len-1 do
  begin
    { If underlying element is array, pass pointer to data }
    if ElemInfo.Kind = tkDynArray then
      PData := Pointer(P^)
    else
      PData := P;

    RemClassRegistry.TypeInfoToXSD(ElemInfo, ElemURI, ElemName);
    if UsingLiteralEncoding then
      WriteNonRectDynArrayElem(RootNode, ArrayNode, ElemInfo, URI, ElemName, PData, Dim-1)
    else
      WriteNonRectDynArrayElem(RootNode, ArrayNode, ElemInfo, ElemURI, ElemName, PData, Dim-1);
    P := Pointer(NativeUInt(P) + GetTypeSize(ElemInfo));
  end;
end;

function TSOAPDomConv.WriteNonRectDynArrayElem(RootNode, Node: IXMLNode; Info: PTypeInfo;
                                               const URI, TypeName: InvString; P: Pointer;
                                               Dim: Integer): Integer;
var
  NodeName : InvString;
begin
  Result := 0;
  { Compute NodeName }
  if UsingLiteralEncoding then
    NodeName := TypeName
  else
    NodeName := DefArrayElemName;

  { MultiD?? Recurse }
  if (Dim > 0)  or (Info.Kind = tkDynArray) then
    WriteNonRectDynArray(RootNode, Node, NodeName, Info, URI, TypeName, P, Dim)
  else
  begin
    if UsingLiteralEncoding then
      WriteRectDynArrayElem(RootNode, Node, Info, 1, 1, P, TypeName, URI)
    else
      WriteRectDynArrayElem(RootNode, Node, Info, 1, 1, P, TypeName);
  end;
end;

procedure TSOAPDomConv.ReadVariant(Node: IXMLNode; P: Pointer);
var
  SoapTypeInfo: PTypeInfo;
  URI, TypeName: InvString;
begin
  Variant(PVarData(P)^) := NULL;
  if  Node.ChildNodes.Count > 1 then
    Variant(PVarData(P)^) := ReadVarArrayDim(Node)
  else
  begin
    { If that a nil node, we're done, the Variant is Null }
    if NodeIsNull(Node) then
      Exit;
    GetElementType(Node, URI, TypeName);
    SoapTypeInfo := RemTypeRegistry.XSDToTypeInfo(URI, TypeName);
    if SoapTypeInfo = nil then
      SoapTypeInfo := TypeInfo(System.string);
   if IsXMLDateTimeTypeInfo(SoapTypeInfo) and Node.IsTextElement then
   begin
     Variant(PVarData(P)^) := XMLTimeToDateTime(Node.Text);
   end else
                                                            
     Variant(PVarData(P)^) :=  TypeTranslator.CastSoapToVariant(SoapTypeInfo, GetNodeAsText(Node));
 end;
end;

procedure TSOAPDomConv.ReadRow(RootNode, Node: IXMLNode; var CurElem: Integer; Size: Integer; P: Pointer; Info: PTypeInfo; const ElementName: InvString = '');
var
  I: Integer;
  URI, TypeName, ID: InvString;
  IsNull, IsScalar: Boolean;
  ChildNode: IXMLNode;
  IndexPrev, IndexNodePrev: integer;
begin
  { Make sure we're not trying to deserialize past the size
    of data we received }
  if CurElem > ntElementChildCount(Node, ElementName) then
     raise ESOAPDomConvertError.CreateFmt(SArrayTooManyElem, [Node.xml]);
  if Info.Kind = tkClass then
  begin
    IndexNodePrev := -1;
    IndexPrev := -1;
    for I := 0 to Size-1 do
    begin
      RemClassRegistry.ClassToURI(GetTypeData(Info).ClassType, URI, TypeName, IsScalar);
      ChildNode := ntElementChild(Node, CurElem, IndexPrev, IndexNodePrev, ElementName);
      PTObject(P)^ := ConvertSOAPToObject(RootNode, ChildNode,
                        GetTypeData(Info).ClassType, URI, TypeName, P);
     P := Pointer(NativeUInt(P) + sizeof(Pointer));
     Inc(CurElem);
    end;
  end else if Info.Kind = tkVariant then
  begin
    IndexNodePrev := -1;
    IndexPrev := -1;
    for I := 0 to Size-1 do
    begin
      ChildNode := ntElementChild(Node, CurElem, IndexPrev, IndexNodePrev, ElementName);
      ReadVariant(ChildNode, P);
      P := Pointer(NativeUInt(P) + GetTypeSize(Info));
      Inc(CurElem);
    end;
  end else
  begin
    IsNull := False;
    IndexNodePrev := -1;
    IndexPrev := -1;
    for I := 0 to Size-1 do
    begin
      ChildNode := ntElementChild(Node, CurElem, IndexPrev, IndexNodePrev, ElementName);
      ChildNode := GetDataNode(RootNode, ChildNode, ID);
      TypeTranslator.CastSoapToNative(Info,  ChildNode.Text, P, IsNull);
      P := Pointer(NativeUInt(P) + GetTypeSize(Info));
      Inc(CurElem);
    end;
  end;
end;


procedure TSOAPDomConv.ReadRectDynArrayElem(RootNode, Node: IXMLNode; Info: PTypeInfo; Size, Dim: Integer; P: Pointer;
  var CurElem: Integer);
var
  I: Integer;
  ElemSize: Integer;
  ID: InvString;
begin
  Node := GetDataNode(RootNode, Node, ID);
  if Dim > 1 then
  begin
    Dec(Dim);
    for I := 0 to Size - 1 do
    begin
      ElemSize := GetDynArrayLength(Pointer(P^));
      ReadRectDynArrayElem(RootNode, Node, Info, ElemSize, Dim, Pointer(P^), CurElem);
      P := Pointer(NativeUInt(P) + sizeof(Pointer));
    end;
  end
  else
  begin
     if CurElem > ntElementChildCount(Node) then
       raise ESOAPDomConvertError.Create(SArrayTooManyElem);

     ReadRow(RootNode, Node, CurElem, Size, P, Info);
  end;
end;


procedure TSOAPDomConv.ReadRectDynArray(RootNode, Node: IXMLNode; Info: PTypeInfo; Dims: Integer; P: Pointer; CurElem: Integer);
begin
  ReadRectDynArrayElem(RootNode, Node, Info, GetDynArrayLength(P), Dims, P, CurElem);
end;

function TSOAPDomConv.ConvertSoapToNativeArrayElem(ArrayInfo, ElemInfo: PTypeInfo;
  RootNode, Node: IXMLNode; ArrayDesc: TSOAPArrayDesc; Dims, CurDim: Integer; DataP: Pointer;
  const ElementName: InvString = ''): Pointer;
                                                                       
var
  PElem, ChildP, DynP: Pointer;
  Size, I: Integer;
  ID: InvString;
  ChildNode, N: IXMLNode;
  NodeOffset: Integer;
  CurElem: Integer;
  IntVec: TNativeIntDynArray;
  DimCnt: Integer;
begin
  Result := nil;
  Node := GetDataNode(RootNode, Node, ID);
  if Dims > 1 then
  begin
    if (Length(ArrayDesc) > 0 ) and ArrayDesc[CurDim].MultiDim then
    begin
      DynP := Pointer(DataP^);
      DynArraySetLength(DynP, ArrayInfo, Length(ArrayDesc[CurDim].Dims), @ArrayDesc[CurDim].Dims[0]);
      Result := DynP;
      Size :=  Length(ArrayDesc[CurDim].Dims);
      NodeOffset := 0;
      ReadRectDynArray(RootNode,  Node, ElemInfo, Size, DynP, NodeOffset);
    end else
    begin
      {Size := ntElementChildCount(Node);}
      DynP := Pointer(DataP^);
      if Length(ArrayDesc) = 0 then
      begin
        SetLength(IntVec, 1);
        DimCnt := 1;
      end else
      begin
        SetLength(IntVec, Length(ArrayDesc[CurDim].Dims));
        DimCnt := Length(ArrayDesc[CurDim].Dims);
      end;
      for I := 0 to Length(IntVec) -1 do
        IntVec[I] := ntElementChildCount(Node);
      DynArraySetLength(DynP, ArrayInfo, DimCnt, @IntVec[0]);
      PElem := DynP;
      Result := DynP;
      Dec(Dims);
      Inc(CurDim);
      for I := 0 to Node.ChildNodes.Count - 1 do
      begin
        N := Node.ChildNodes[I];
        { Skip non element nodes }
        if N.NodeType <> ntElement then
          continue;

        ChildNode := GetDataNode(RootNode, N, ID);
        ChildP :=  ConvertSoapToNativeArrayElem(GetDynArrayNextInfo(ArrayInfo), ElemInfo, RootNode,
                     ChildNode, ArrayDesc, Dims, CurDim, PElem);
        Pointer(PElem^) := ChildP;
        PElem := Pointer(NativeUInt(PElem) + sizeof(Pointer));
      end;
    end;
  end else if Dims = 1 then
  begin
    begin
      Size := ntElementChildCount(Node, ElementName);
      if DataP <> nil then
      begin
        DynP := Pointer(DataP^);
        if Length(ArrayDesc) = 0 then
        begin
          SetLength(IntVec, 1);
          DimCnt := 1;
        end else
        begin
          SetLength(IntVec, Length(ArrayDesc[CurDim].Dims));
          DimCnt := Length(ArrayDesc[CurDim].Dims);
        end;
        for I := 0 to Length(IntVec) -1 do
          IntVec[I] := ntElementChildCount(Node, ElementName);
        DynArraySetLength(DynP, ArrayInfo, DimCnt,  @IntVec[0] );
        PElem := DynP;
        Result := DynP;
        CurElem := 0;
        if Size > 0 then
          ReadRow(RootNode, Node, CurElem,  Size, PElem, ElemInfo, ElementName);
      end;
    end;
  end;
end;

{$DEFINE COPY_ARRAY}
function TSOAPDomConv.ConvertSoapToNativeArray(DataP: Pointer;  TypeInfo: PTypeInfo;
                                               RootNode, Node: IXMLNode; const ElementName: InvString = ''): Pointer;
var
  Dims: Integer;
  ElemInfo: PTypeInfo;
  ArrayDesc: TSOAPArrayDesc;
  ArrayType: InvString;
  V : Variant;
  TypeURI, TypeName: InvString;
{$IFNDEF UNICODE}
  S: String;
  ArrayLen: Integer;
  DynP: Pointer;
{$ELSE}
  Bytes: TBytes;
{$IFDEF COPY_ARRAY}
  ArrayLen: NativeInt;
  DynP: Pointer;
{$ENDIF}
{$ENDIF}
begin
  GetElementType(Node, TypeURI, TypeName);
  GetDynArrayElTypeInfo(TypeInfo, ElemInfo, Dims);
  if ElemInfo = nil then
    raise  ESOAPDomConvertError.CreateFmt(SNoArrayElemRTTI, [TypeInfo.Name]);
  if (Dims = 1) and ByteArrayInfo(ElemInfo) then
  begin
{$IFNDEF UNICODE}
    S := DecodeString(Node.Text);
    ArrayLen := Length(S);
    DynP := Pointer(DataP^);
    DynArraySetLength(DynP, TypeInfo, 1, @ArrayLen);
    Move(S[Low(string)], DynP^, Length(S));
    Result := DynP;
{$ELSE}
{$IFDEF NEXTGEN}
    Bytes := DecodeBase64(Node.Text);
{$ELSE !NEXTGEN}
    Bytes := DecodeBase64(AnsiString(Node.Text));
{$ENDIF NEXTGEN}
{$IFDEF COPY_ARRAY}
    ArrayLen := Length(Bytes);
    DynP := Pointer(DataP^);
    DynArraySetLength(DynP, TypeInfo, 1, @ArrayLen);
    if ArrayLen > 0 then
      Move(Bytes[0], DynP^, ArrayLen);
    Result := DynP;
{$ELSE}
    { Highjack array and bump ref. count artificially }
    Result := Pointer(Bytes);
    if Result <> nil then
      Inc(PInteger(PByte(Result)-(Sizeof(NativeInt) + Sizeof(LongInt)))^);                            
{$ENDIF}
{$ENDIF}
  end else
  begin
    V := Node.GetAttributeNS(SSoapEncodingArrayType, SoapEncodingNamespaces[soSOAP12 in Options]);
    if not VarIsNull(V) then
    begin
      ArrayType := V;
      ArrayType := Copy(ArrayType, Pos('[',ArrayType), High(Integer));     { do not localize }
    end;

    (* -- Allow array of variants to be MultiD --
    if ElemnInfo.Kind = tkVariant then
    begin
      SetLength(ArrayDesc, Dims);
      SetLength(ArrayDesc[0].Dims, 1);
    end;
    *)
    ParseDims(ArrayType, ArrayDesc);
    Result := ConvertSoapToNativeArrayElem(TypeInfo, ElemInfo, RootNode, Node, ArrayDesc, Dims, 0, DataP, ElementName);
  end;
end;

function TSOAPDomConv.GetNewID: string;
begin
  Result := IntToStr(FIDs);
  Inc(FIDs);
end;

function TSOAPDomConv.CreateMultiRefNode(RootNode: IXMLNode; const Name, ID: InvString): IXMLNode;
var
  I, J: Integer;
begin
  Result := RootNode.AddChild(Name);
  if soSOAP12 in Options then
    Result.SetAttributeNS(SXMLID, SSoap12EncodingNamespace, ID)
  else
    Result.Attributes[SXMLID] := ID;

  I := 0;
  while I < Length(MultiRefNodes) do
  begin
    if MultiRefNodes[I].Node = RootNode then
      break;
    Inc(I);
  end;
  if I = Length(MultiRefNodes) then
  begin
    SetLength(MultiRefNodes, I + 1);
    MultiRefNodes[I].Node := RootNode;
  end;

  { Store children with rootnode }
  J := Length(MultiRefNodes[I].MultiRefChildren);
  SetLength(MultiRefNodes[I].MultiRefChildren, J + 1);
  MultiRefNodes[I].MultiRefChildren[J] := Result;
end;

procedure TSOAPDomConv.FinalizeMultiRefNodes;
var
  I, J: Integer;
  RootNode: IXMLNode;
  RefNode: IXMLNode;
begin
  for I := 0 to Length(MultiRefNodes) - 1 do
  begin
    for J := 0 to Length(MultiRefNodes[I].MultiRefChildren) - 1 do
    begin
      RootNode := MultiRefNodes[I].Node;

      { Get Ref node and add }
      RefNode :=  MultiRefNodes[I].MultiRefChildren[J];

      { Parent if not already }
      if RefNode.ParentNode <> RootNode then
        RootNode.ChildNodes.Add(RefNode);
    end;
  end;
  for I := 0 to Length(MultiRefNodes) - 1 do
  begin
    SetLength(MultiRefNodes[I].MultiRefChildren, 0);
  end;
  SetLength(MultiRefNodes, 0);
end;

function TSOAPDomConv.SerializationOptions(ATypeInfo: PTypeInfo): TSerializationOptions;
begin
  if ATypeInfo.Kind = tkClass then
    Result := SerializationOptions(GetTypeData(ATypeInfo).ClassType)
  else
    Result := [];
end;

function TSOAPDomConv.SerializationOptions(Obj: TObject): TSerializationOptions;
begin
  Result := SerializationOptions(Obj.ClassType);
  if Obj.InheritsFrom(TRemotable) then
    Result := Result + TRemotable(Obj).SerializationOptions;
end;

function TSOAPDomConv.SerializationOptions(Cls: TClass): TSerializationOptions;
begin
  Result := RemTypeRegistry.SerializeOptions(Cls);
end;

function TSOAPDomConv.MultiRefObject(Cls: TClass): Boolean;
var
  MultiRefOpt: TObjMultiOptions;
  SerialOpts: TSerializationOptions;
begin
  if (soXXXXHdr in Options) then
  begin
    Result := False;
    Exit;
  end;

  SerialOpts := SerializationOptions(Cls);
  if (xoSimpleTypeWrapper in SerialOpts) then
  begin
    Result := False;
    Exit;
  end;

  { Retrieve registered options of this type }
  MultiRefOpt :=  RemTypeRegistry.ClassOptions(Cls);
  { Are we multiref'in the node }
  { NOTE: We opt to not allow Scalars to be multirefed?? }
  Result := (soSendMultiRefObj in Options)
        and (MultiRefOpt <> ocNoMultiRef)
        and (not UsingLiteralEncoding)
        and (not RemTypeRegistry.IsClassScalar(Cls));
end;


function TSOAPDomConv.CreateObjectNode(Instance: TObject; RootNode, ParentNode: IXMLNode;
                                       const NodeName, NodeNamespace, ChildNamespace: InvString;
                                       ObjConvOpts: TObjectConvertOptions): InvString;
begin
  { Allow TRemotable_xxxx classes to perform custom serialization }
  if Assigned(Instance) and Instance.InheritsFrom(TRemotable) then
    TRemotable(Instance).ObjectToSOAP(RootNode, ParentNode, Self, NodeName, NodeNamespace, ChildNamespace, ObjConvOpts, Result)
  else
    ObjInstanceToSOAP(Instance, RootNode, ParentNode, NodeName, NodeNamespace, ChildNamespace, ObjConvOpts, Result);
end;

function HasFlagOnIndex(const PropInfo: PPropInfo; Flag: Integer): Boolean;
begin
  Result := (PropInfo.Index and Flag) = Flag;
end;

{ Determines if a property can be handled as XML attribute }
function IsAttributeProperty(Kind: TTypeKind; const PropInfo: PPropInfo): Boolean;
begin
  Result := (HasFlagOnIndex(PropInfo, IS_ATTR) or (not IsStoredPropConst(nil, PropInfo)))
            { - We have to allow dynamic arrays as byte arrays can be used
                as the value of a property
            and (Kind <> tkDynArray)
            }
            and (Kind <> tkVariant)
            and ((Kind <> tkClass) or
                  GetTypeData(PropInfo.PropType^).ClassType.InheritsFrom(TRemotableXS));
end;

function IsUnboundedProperty(const PropInfo: PPropInfo): Boolean;
begin
  Result := HasFlagOnIndex(PropInfo, IS_UNBD) or (not IsStoredPropConst(nil, PropInfo));
end;

function IsOptionalProperty(const PropInfo: PPropInfo): Boolean;
begin
  Result := HasFlagOnIndex(PropInfo, IS_OPTN);
end;

function IsTextProperty(const PropInfo: PPropInfo): Boolean;
begin
  Result := HasFlagOnIndex(PropInfo, IS_TEXT);
end;

function IsUnqualifiedProperty(const PropInfo: PPropInfo): Boolean;
begin
  Result := HasFlagOnIndex(PropInfo, IS_UNQL);
end;

function IsQualifiedProperty(const PropInfo: PPropInfo): Boolean;
begin
  Result := HasFlagOnIndex(PropInfo, IS_QUAL);
end;

function IsRefProperty(const PropInfo: PPropInfo): Boolean;
begin
  Result := HasFlagOnIndex(PropInfo, IS_REF);
end;

function CreateNilNode(ParentNode: IXMLNode; const Name: InvString; const Namespace: InvString): IXMLNode;
begin
  Result := ParentNode.AddChild(Name, Namespace);
  Result.SetAttributeNS(SSoapNil, XMLSchemaInstNameSpace, STrue);
end;

function IsNilNode(const Node: IXMLNode): Boolean;
var
  V: Variant;
begin
  Result := Node = nil;
  if (not Result) then
  begin
    V := Node.GetAttributeNS(SSoapNIL, XMLSchemaInstNamespace);
    if not VarIsNull(V) and ((V = sOneAsWide) or SameText(V, STrue)) then   { do not localize }
      Result := True;
  end;
end;

class function TSOAPDomConv.HasMultipleElemNamespaces(const ClsType: TClass;
                                                      out PropNamespaces: InvStringDynArray;
                                                      out PropNamespaceIndex: TIntegerDynArray): Boolean;

  function FindIndex(const PropList: PPropList; Count: Integer; const Info: PPropInfo): Integer;
  var
    I: Integer;
  begin
    for I:= 0 to Count-1 do
    begin
      if PropList[I] = Info then
      begin
        Result := I;
        Exit;
      end;
    end;
    Result := -1;
  end;

var
  ClassHierarchy: array of TClass;
  TempCls: TClass;
  Len, I, J, K, Count: Integer;
  PropCount: TIntegerDynArray;
  PropList: PPropList;
  BasePropList: PPropList;
  Dummy: InvString;
begin
  Result := False;
  PropNamespaces := nil;
  PropNamespaceIndex := nil;
  SetLength(ClassHierarchy, 0);
  Len := 0;

  { Find out how deep is the hierarchy }
  TempCls := ClsType;
  while (TempCls <> TRemotable) and TempCls.InheritsFrom(TRemotable) do
  begin
    SetLength(ClassHierarchy, Len+1);
    ClassHierarchy[Len] := TempCls;
    Inc(Len);
    TempCls := TempCls.ClassParent;
  end;
  if Length(ClassHierarchy) < 2 then
    Exit;

  { Reverse: Base -> Derived }
  I := 0;
  J := Len-1;
  while (I < J) do
  begin
    TempCls := ClassHierarchy[J];
    ClassHierarchy[J] := ClassHierarchy[I];
    ClassHierarchy[I] := TempCls;
    Inc(I);
    Dec(J);
  end;

  { Get Namespace of each type in the hierarchy }
  SetLength(PropNamespaces, Len);
  for I:=0 to Len-1 do
    RemClassRegistry.ClassToURI(ClassHierarchy[I], PropNamespaces[I], Dummy);

  { Are all the types in the same namespace? }
  J := 0;
  Dummy := PropNamespaces[0];
  for I:= 1 to Len-1 do
  begin
    if Dummy <> PropNamespaces[I] then
    begin
      Inc(J);
      break;
    end;
  end;

  { If yes, don't bother any further }
  if (J = 0) then
  begin
    SetLength(PropNamespaces, 0);
    Exit;
  end;

  { Do any of the base types have published PropInfos }
  SetLength(PropCount, Len);
  for I:=0 to Len-1 do
    PropCount[I] := GetTypeData(ClassHierarchy[I].ClassInfo)^.PropCount;
  J := 0;
  for I:=0 to Len-2 do
    J := J + PropCount[I];
  if (J = 0) then
  begin
    SetLength(PropNamespaces, 0);
    Exit;
  end;

  { Map each Property to their base classes }
  Count := GetTypeData(ClsType.ClassInfo)^.PropCount;
  SetLength(PropNamespaceIndex, Count);
  for I:=0 to Count-1 do
    PropNamespaceIndex[I] := -1;
  GetMem(PropList, Count * SizeOf(Pointer));
  try
    GetPropInfos(ClsType.ClassInfo, PropList);
    for I:=0 to Len-2 do
    begin
      GetMem(BasePropList, PropCount[I] * Sizeof(Pointer));
      try
        GetPropInfos(ClassHierarchy[I].ClassInfo, BasePropList);
        for J:=0 to PropCount[I]-1 do
        begin
          K := FindIndex(PropList, Count, BasePropList[J]);
          if (K <> -1) then
          begin
            if PropNamespaceIndex[K] = -1 then
              PropNamespaceIndex[K] := I;
          end;
        end;
      finally
        FreeMem(BasePropList, PropCount[I] * Sizeof(Pointer));
      end;
    end;
  finally
    FreeMem(PropList, Count * SizeOf(Pointer));
  end;

  { All remaining items in  most-derived type }
  for I:=0 to Count-1 do
    if PropNamespaceIndex[I] = -1 then
      PropNamespaceIndex[I] := (Len-1);

  Result := True;
end;

function TSOAPDomConv.ObjInstanceToSOAP(Instance: TObject; RootNode, ParentNode: IXMLNode;
                                        const NodeName, NodeNamespace, ChildNamespace: InvString; ObjConvOpts: TObjectConvertOptions;
                                        out RefID: InvString): IXMLNode;
const
  NoYes: array[Boolean] of string = ('No', 'Yes');
var
  ID, Pre: InvString;
  I, Count: Integer;
  PropList: PPropList;
  Kind: TTypeKind;
  V: Variant;
  Obj: TObject;
  TypeName, TypeNamespace, PropTypeName, PropTypeNamespace, PropNamespace, NodeVal: InvString;
  PrefixNode, InstNode, ElemNode, AttrNode: IXMLNode;
  P: Pointer;
  ExtPropName: InvString;
  MultiRef, UsePrefix, SerializeProps, CanHaveType: Boolean;
  HolderClass, LitParam, IsAttribute, IsSimpleClass : Boolean;
  SerialOpts: TSerializationOptions;
  ClsType: TClass;
  InlineProp: Boolean;
  IsRefProp: Boolean;
  SendingDerivedType: Boolean;
  PrevMetaClass: TClass;
  PrevObjectInstance: TObject;
  PropNamespaceIndex: TIntegerDynArray;
  PropNamespaces: InvStringDynArray;
  CheckedElemURI, HaveElemURI, HasPropNamespace: Boolean;
  PropRegInfo: InvString;
begin
  { Get a new ID for this node - in case we're MultiRefing... }
  RefID := GetNewID;

  { Retrieve the Serializatin options of this class }
  SerialOpts := SerializationOptions(Instance);

  { Type attribute }
  HolderClass := (xoHolderClass in SerialOpts);
  LitParam    := (xoLiteralParam in SerialOpts);

  { Object Custom Serialization flags }
  UsePrefix      := not (ocoDontPrefixNode in ObjConvOpts);
  SerializeProps := not (ocoDontSerializeProps in ObjConvOpts);
  CanHaveType    := not (ocoDontPutTypeAttr in ObjConvOpts) and (not LitParam);

  { Get namespace prefix }
  PrefixNode := RootNode;

  { Are we multiref'in the node }
  MultiRef := MultiRefObject(Instance.ClassType);

  { No prefix in document style - or if flag set to false }
  if not (UsingLiteralEncoding) and UsePrefix then
    Pre := FindPrefixForURI(PrefixNode, ParentNode,  NodeNamespace, True)
  else
    Pre := '';

  { Create the Node, if necessary }
  if not HolderClass then
  begin
    if MultiRef and (not (soSOAP12 in Options)) then
      InstNode := CreateMultiRefNode(RootNode, MakeNodeName(Pre, NodeName), RefID)
    else
    begin
      if (UsingLiteralEncoding) then
      begin
        if NodeNamespace = '' then
          InstNode := ParentNode.AddChild(NodeName, '', False)
        else
          InstNode := ParentNode.AddChild(NodeName, NodeNamespace, UsePrefix);
      end
      else
      begin
        if UsePrefix or (Pre <> '') then
          InstNode := ParentNode.AddChild(MakeNodeName(Pre, NodeName))
        else
          { Create a node without any prefix }
          InstNode := ParentNode.AddChild(NodeName, '');
      end;

      if MultiRef and (soSOAP12 in Options) then
        InstNode.SetAttributeNS(SXMLID, SSoap12EncodingNamespace, RefID);
    end;
  end
  else
    { Here this class was simply a holder - only its members are serialized!
      the class itself is stealth }
    InstNode := ParentNode;

  { Set Result Node }
  Result := InstNode;

{$IFDEF FIX_ELEM_NODE_NS}
  SendingDerivedType := (UsingLiteralEncoding) and
                        Assigned(ObjectMetaClass) and
                        (ObjectInstance =  Instance) and
                        (Instance.ClassType <> ObjectMetaClass) and
                        Instance.ClassType.InheritsFrom(ObjectMetaClass);
{$ENDIF}

  { Can this type generate xsi:type attributes?? }
  if CanHaveType then
  begin
    { Retrieve Type Namespace }
    RemClassRegistry.ClassToURI(Instance.ClassType, TypeNamespace, TypeName);
    { xsi:type=?? }
    { In cases where a derived type is sent, the  xsi:type attribute must be specified. }
    SetNodeTypeEx(PrefixNode, InstNode, TypeNameSpace, TypeName, SendingDerivedType);
  end;

  { Store info that we multi refed' }
  if MultiRef then
    AddMultiRefNode(RefID, Instance);

  { Serialize Published Properties ?? }
  if SerializeProps then
  begin
    { Serialized published properties }
    Count := GetTypeData(Instance.ClassInfo)^.PropCount;
    if Count > 0 then
    begin
      CheckedElemURI := False;
      GetMem(PropList, Count * SizeOf(Pointer));
      try
        GetPropInfos(Instance.ClassInfo, PropList);

        { Complex type as wrapper of a simple type }
        if (xoSimpleTypeWrapper in SerialOpts) and (Count = 1) then
        begin
          NodeVal := GetObjectPropAsText(Instance, PropList[0]);
          InstNode.Text := NodeVal;
        end else
        begin
          for I := 0 to Count - 1 do
          begin
            { Short-circuit optional properties whose value were not set. }
            { This logic is crucial for communicating with services such as
              eBay or Amazon. Several of their complex types have optional enumerations.
              There's no way to tell whether the value of '0' is an enumeration that
              was not set or one where it was set to the first member of the enumeration.
              Several services workaround this issue by making sure that the first
              member of an enumeration is something like 'unused' or 'unspecified'.
              But plenty of services don't use this approach.

              However, the short-circuiting of unspecified optional properties
              might be undesirable for cases where someone relied on the previous behaviour
              when we always serialize all properties of a class. }
{$IFNDEF NO_OPTIONAL_ELEMENT_SUPPORT}
            if IsOptionalProperty(PropList[I]) and (not IsStoredProp(Instance, PropList[I])) then
              Continue;
{$ENDIF}
            { Text Property }
            if IsTextProperty(PropList[I]) then
            begin
              NodeVal := GetObjectPropAsText(Instance, PropList[I]);
              InstNode.Text := NodeVal;
              Continue;
            end;

            PropRegInfo := '';
            PropNamespace := '';
            HasPropNamespace := False;
            ExtPropName := RemTypeRegistry.GetExternalPropName(Instance.ClassInfo, TypeInfoName(PropList[I].Name));
            if ExtPropName[Low(string)] = INFOATTR_BEG_CHAR then
            begin
              PropRegInfo := ExtPropName;
              if not GetRegInfo(PropRegInfo, InfoAttribute.iaExternalName, ExtPropName) then
                ExtPropName := TypeInfoName(PropList[I].Name);
              if GetRegInfo(PropRegInfo, InfoAttribute.iaNamespace, PropNamespace) then
                HasPropNamespace := True;
            end;

            Kind := (PropList[I].PropType)^.Kind;
            IsRefProp := IsRefProperty(PropList[I]);
            IsAttribute := IsAttributeProperty(Kind, PropList[I]);

            { Figure out the namespace of the property }
            if not RemTypeRegistry.TypeInfoToXSD((PropList[I].PropType)^, PropTypeNamespace, PropTypeName) then
              raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [(PropList[I].PropType)^.Name]);

            if not IsUnqualifiedProperty(PropList[I]) and (not HasPropNamespace) then
            begin
              if UsingLiteralEncoding then
              begin
                if IsRefProp then
                  PropNamespace := PropTypeNamespace
                else
                begin
                  HaveElemURI := False;
                  if not CheckedElemURI then
                    HaveElemURI := HasMultipleElemNamespaces(Instance.ClassType, PropNamespaces, PropNamespaceIndex);
                  if HaveElemURI then
                    PropNamespace := PropNamespaces[PropNamespaceIndex[I]]
                  else
                    PropNamespace := ChildNamespace;
                end;
              end
              else
                PropNamespace := PropTypeNamespace;
            end;

            { Class Property }
            if Kind = tkClass then
            begin
              Obj := GetObjectProp(Instance, PropList[I]);
              if IsAttribute then
              begin
                if Obj <> nil then
                begin
                  NodeVal := TRemotableXS(Obj).NativeToXS;

                  AttrNode := InstNode;
                  if (xoAttributeOnLastMember in SerialOpts) then
                  begin
                    if ntElementChildCount(InstNode) > 0 then
                      AttrNode := ntElementChild(InstNode, ntElementChildCount(InstNode)-1);
                  end;
                  NodeVal := GetObjectPropAsText(Instance, PropList[I]);
                  { Check if user does not want to send empty nodes }
                  if (not (soDontSendEmptyNodes in Options)) or (NodeVal <> '') then
                  begin
                    if IsQualifiedProperty(PropList[I]) or HasPropNamespace then
                    begin
                      Pre := FindPrefixForURI(RootNode, AttrNode, PropNamespace, True);
                      if Pre = '' then
                        Pre := AddNamespaceDecl(AttrNode, PropNamespace);
                      AttrNode.Attributes[MakeNodeName(Pre, ExtPropName)] := NodeVal;
                    end
                    else
                      AttrNode.Attributes[ExtPropName] := NodeVal;
                  end;
                end;
              end
              else
              begin
                if Obj = nil then
                begin
                  if not (soDontSendEmptyNodes in Options) then
                  begin
                    if (UsingLiteralEncoding) and not IsRefProp then
                      CreateNilNode(InstNode, ExtPropName, PropNamespace)
                    else
                      CreateNULLNode(RootNode, InstNode, ExtPropName);
                  end;
                end
                else
                begin
                  ClsType := GetTypeData((PropList[I].PropType)^).ClassType;
                  IsSimpleClass := ClsType.InheritsFrom(TRemotableXS);

                  MultiRef := MultiRefObject(ClsType);
                  if not MultiRef then
                  begin
                    if IsObjectWriting(Obj) then
                      raise ESOAPDomConvertError.CreateFmt(SNoSerializeGraphs, [Obj.ClassName]);
{$IFDEF FIX_ELEM_NODE_NS}
                    PrevMetaClass := ObjectMetaclass;
                    PrevObjectInstance := ObjectInstance;
                    try
                      ObjectInstance := Obj;
                      ObjectMetaClass:= ClsType;
{$ENDIF}
                                                                        
                      AddObjectAsWriting(Obj);
                      try
                        { NOTE: Don't prefix for simple types }
                        if (IsSimpleClass) then
                          ObjConvOpts := ObjConvOpts + [ocoDontPrefixNode];

                        CreateObjectNode(Obj, RootNode, InstNode, ExtPropName, PropNamespace, PropTypeNamespace, ObjConvOpts)
                      finally
                        RemoveObjectAsWriting(Obj);
                      end;
{$IFDEF FIX_ELEM_NODE_NS}
                    finally
                      ObjectMetaClass := PrevMetaClass;
                      ObjectInstance := PrevObjectInstance;
                    end;
{$ENDIF}
                  end
                  else
                  begin
                    if not (soSOAP12 in Options) then
                    begin
                      ElemNode := InstNode.AddChild(ExtPropName, '');

                      ID := FindMultiRefNodeByInstance(Obj);
                      { NOTE: prefix for nested types ?? }
                      if ID = '' then
                        ID := CreateObjectNode(Obj, RootNode, InstNode, ExtPropName, PropTypeNamespace, '', ObjConvOpts);

                      ElemNode.Attributes[SXMLHREF] := SHREFPre + ID;
                    end
                    else
                    begin
                      ID := FindMultiRefNodeByInstance(Obj);
                      if ID <> '' then
                      begin
                        ElemNode := InstNode.AddChild(ExtPropName, '');
                        ElemNode.SetAttributeNS(SSOAP12XMLHREF, SSoap12EncodingNamespace, ID);
                      end
                      else
                        CreateObjectNode(Obj, RootNode, InstNode, ExtPropName, PropTypeNamespace, '', ObjConvOpts);
                    end;
                  end;
                end;
              end;
            { Array property }
            end else if Kind = tkDynArray then
            begin
              P := Pointer(GetDynArrayProp(Instance, PropList[I]));
              InlineProp := (xoInlineArrays in SerialOpts) or IsUnboundedProperty(PropList[I]);
              if (not InlineProp) and (PropRegInfo <> '') then
              begin
                PropTypeNamespace := PropRegInfo;
              end;
              ConvertNativeArrayToSoap(RootNode, InstNode, ExtPropName,
                                       PropNamespace, PropTypeNamespace,
                                       (PropList[I].PropType)^, @P, 
                                       InlineProp);
            { Variant property }
            end else if Kind = tkVariant then
            begin
              V := GetVariantProp(Instance, PropList[I]);
              if UsingLiteralEncoding then
                ConvertVariantToSoap(RootNode, InstNode, ExtPropName, PropNamespace, nil, nil, V, True)
              else
                ConvertVariantToSoap(RootNode, InstNode, ExtPropName, '', nil, nil, V, True);
            end else
            { Simple type property ?? }
            begin
              if IsAttribute then
              begin
                { Typically attributes go on the root/instance node. However, in some
                  cases the class serializes members and then the attribute goes on
                  the last member; this option allows attributes on specific members }
                AttrNode := InstNode;
                if (xoAttributeOnLastMember in SerialOpts) then
                begin
                  if ntElementChildCount(InstNode) > 0 then
                    AttrNode := ntElementChild(InstNode, ntElementChildCount(InstNode)-1);
                end;
                NodeVal := GetObjectPropAsText(Instance, PropList[I]);
                { Check if user does not want to send empty nodes }
                if (not (soDontSendEmptyNodes in Options)) or (NodeVal <> '') then
                begin
                  if IsQualifiedProperty(PropList[I]) or HasPropNamespace then
                  begin
                    Pre := FindPrefixForURI(RootNode, AttrNode, PropNamespace, True);
                    if Pre = '' then
                      Pre := AddNamespaceDecl(AttrNode, PropNamespace);
                    AttrNode.Attributes[MakeNodeName(Pre, ExtPropName)] := NodeVal;
                  end
                  else
                    AttrNode.Attributes[ExtPropName] := NodeVal;
                end;
              end
              else
              begin
                NodeVal := GetObjectPropAsText(Instance, PropList[I]);
                { Check if user does not want to send empty nodes }
                if (not (soDontSendEmptyNodes in Options)) or (NodeVal <> '') then
                  ElemNode := CreateScalarNodeXS(RootNode, InstNode, ExtPropName, PropNamespace, PropTypeName, NodeVal)
              end;
            end;
          end;
        end;
      finally
        FreeMem(PropList, Count * SizeOf(Pointer));
      end;
    end;
  end;
end;


procedure TSOAPDomConv.ConvertObjectToSOAP(const NodeName, NodeNamespace, ChildNamespace: InvString;
  ObjP: Pointer; RootNode, Node: IXMLNode);
var
  ElemNode: IXMLNode;
  ID: string;
  TypeNamespace, TypeName: InvString;
  Instance: TObject;
  MultiRef: Boolean;
begin
  Instance := TObject(ObjP^);

  if Assigned(Instance) and not Instance.InheritsFrom(TRemotable) then
    raise ESOAPDomConvertError.CreateFmt(SUnsuportedClassType, [Instance.ClassName]);

  if not Assigned(Instance) then
    CreateNULLNode(RootNode, Node, NodeName)
  else
  begin
    if not RemClassRegistry.ClassToURI(Instance.ClassType, TypeNamespace, TypeName) then
      raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [Instance.ClassName]);

    MultiRef := MultiRefObject(Instance.ClassType);
    { NOTE: SOAP Attachments will enter this path as they are never multirefed }
    if not MultiRef then
    begin
      if IsObjectWriting(Instance) then
        raise ESOAPDomConvertError.CreateFmt(SNoSerializeGraphs, [Instance.ClassName]);
      AddObjectAsWriting(Instance);
      try
        { NOTE: Prefixing nodes can cause problems with some
                SOAP implementations. However, not doing so causes problems
                too ?? }
        if UsingLiteralEncoding then
          CreateObjectNode(Instance, RootNode, Node, NodeName, NodeNamespace, TypeNamespace, [ocoDontPrefixNode])
        else
          CreateObjectNode(Instance, RootNode, Node, NodeName, TypeNamespace, '', [ocoDontPrefixNode]);
      finally
        RemoveObjectAsWriting(Instance);
      end;
    end
    else
    begin
      ID := FindMultiRefNodeByInstance(Instance);
      { NOTE: Passing 'True' to prefix here can cause problems with some
              SOAP implementations. However, removing it can cause problems
              too ?? }
      if ID = '' then
      begin
        if not (soSOAP12 in Options) then
        begin
          { NOTE: SOAP 1.1 - The ref'ed node must be of the TypeName - not the referring node name }
          ID := CreateObjectNode(Instance, RootNode, Node, TypeName, TypeNamespace, '', []);
        end
        else
        begin
          { NOTE: SOAP 1.2 - The node keeps the refering node name }
          ID := CreateObjectNode(Instance, RootNode, Node, NodeName, TypeNamespace, '', [ocoDontPrefixNode]);
        end;
      end;

      if not (soSOAP12 in Options) then
      begin
        ElemNode := Node.AddChild(NodeName, '' {No Namespace prefix});
        ElemNode.Attributes[SXMLHREF] := SHREFPre + ID;
      end;
    end;
  end;
end;


function IsBooleanTypeInfo(TypInfo: PTypeInfo): Boolean;
begin
  Assert(TypInfo^.Kind = tkEnumeration);
  Result := GetTypeData(TypInfo)^.MinValue < 0;
  if not Result then
    Result := GetTypeData(TypInfo)^.BaseType^ = TypeInfo(System.Boolean);
end;

function TSOAPDomConv.GetObjectPropAsText(Instance: TObject; PropInfo: PPropInfo): InvString;
const
  SimpleFmt = '%s:(%s) ';
var
 I: LongInt;
 E: Extended;
 I64: Int64;
 DT: TDateTime;
 Obj: TObject;
 P: Pointer;
 ElemInfo: PTypeInfo;
 Dims, Len: Integer;
{$IFNDEF UNICODE}
 S: string;
{$ENDIF}
begin
  case (PropInfo.PropType)^.Kind of
    tkInteger:
      begin
        I := GetOrdProp(Instance, PropInfo);
        Result := IntToStr(I);
      end;
    tkFloat:
      begin
        E := GetFloatProp(Instance, PropInfo);
        if PropInfo.PropType^ = TypeInfo(TDateTime) then
        begin
          DT := E;
          Result := DateTimeToXMLTime(DT);
        end
        else
          Result := FloatToStrEx(E);
      end;
{$IFNDEF NEXTGEN}
    tkWString:
      Result := GetWideStrProp(Instance, PropInfo);
{$ENDIF !NEXTGEN}
{$IFDEF UNICODE}
 {$IFNDEF NEXTGEN}
    tkString,
    tkLString:
      Result := InvString(GetAnsiStrProp(Instance, PropInfo));
 {$ENDIF !NEXTGEN}
{$ELSE}
    tkString,
    tkLString:
      Result := GetStrProp(Instance, PropInfo);
{$ENDIF}
{$IFDEF TIBURON_UP}
    tkUString:
      Result := GetStrProp(Instance, PropInfo);
{$ENDIF}
    tkInt64:
      begin
        I64 := GetInt64Prop(Instance, PropInfo);
        Result := IntToStr(I64);
      end;
    tkEnumeration:
      begin
        Result := GetEnumProp(Instance, PropInfo);
        if IsBooleanTypeInfo(PropInfo.PropType^) then
          Result := Lowercase(Result)
        else
          { Enumeration members could have been renamed }
          Result := RemTypeRegistry.GetExternalPropName(PropInfo.PropType^, Result);
      end;
    tkChar:
      begin
        I := GetOrdProp(Instance, PropInfo);
        Result :=  InvString(Char(I));
      end;
    tkWChar:
      begin
        I := GetOrdProp(Instance, PropInfo);
        Result :=  InvString(WideChar(I));
      end;
    tkClass:
      { Here we handle TXSxxxx types as they represent Simple Types }
      if (GetTypeData(PropInfo.PropType^).ClassType.InheritsFrom(TRemotableXS)) then
      begin
        Obj := GetObjectProp(Instance, PropInfo);
        if Obj <> nil then
          Result := TRemotableXS(Obj).NativeToXS;
      end;

      { Byte array is the only type that we support converting to text }
    tkDynArray:
      begin
        P := Pointer(GetDynArrayProp(Instance, PropInfo));
        if not Assigned(P) then
        begin
          Result := '';
        end else
        begin
          GetDynArrayElTypeInfo((PropInfo.PropType)^, ElemInfo, Dims);
          if (Dims <> 1) or not ByteArrayInfo(ElemInfo) then
            raise ESOAPDomConvertError.CreateFmt(SUnexpectedDataType,
                                                 [Format(SimpleFmt, [KindNameArray[(PropInfo.PropType)^.Kind],
                                                                     (PropInfo.PropType)^.Name])]);
          { Here we have a byte array }
          Len := GetDynArrayLength(P);
{$IFNDEF UNICODE}
          SetLength(S, Len);
          Move(P^, S[Low(string)], Length(S));
          Result := EncodeString(S);
{$ELSE}
          Result := InvString(EncodeBase64(P, Len));
{$ENDIF}
        end;
      end;

    tkSet,
    tkMethod,

    tkArray,
    tkRecord,
    tkInterface,

    tkVariant:
      raise ESOAPDomConvertError.CreateFmt(SUnexpectedDataType,
                                           [Format(SimpleFmt, [KindNameArray[(PropInfo.PropType)^.Kind],
                                                               (PropInfo.PropType)^.Name])]);
  else
    raise ESOAPDomConvertError.CreateFmt(SUnexpectedDataType,
                                         [Format(SimpleFmt, [KindNameArray[(PropInfo.PropType)^.Kind],
                                                               (PropInfo.PropType)^.Name])]);
  end;
end;

function TSOAPDomConv.GetTypeBySchemaNS(Node: IXMLNode; const URI: InvString): Variant;
var
  I: Integer;
begin
  Result := Node.GetAttributeNS(SSoapType, URI);
  if VarIsNull(Result) and (soTryAllSchema in Options) then
  begin
    for I := Low(XMLSchemaInstNamespaces) to High(XMLSchemaInstNamespaces) do
    begin
      Result := Node.GetAttributeNS(SSoapType, XMLSchemaInstNamespaces[I]);
      if not VarIsNull(Result) then
        break;
    end;
  end;
end;

function TSOAPDomConv.GetElementType(Node: IXMLNode; var TypeURI, TypeName: InvString): Boolean;
var
  S : InvString;
  V: Variant;
  Pre: InvString;
begin
  TypeURI := '';
  TypeName := '';
  Result := False;
  if (Node.NamespaceURI = SoapEncodingNamespaces[soSOAP12 in Options]) and
     (ExtractLocalName(Node.NodeName) = SSoapEncodingArray) then
  begin
    TypeURI := SoapEncodingNamespaces[soSOAP12 in Options];
    TypeName := SSoapEncodingArray;
    Result := True;
  end else
  begin
    V := GetTypeBySchemaNS(Node, XMLSchemaInstNameSpace);
    if VarIsNull(V) then
      V := Node.GetAttribute(SSoapType);
    if not VarIsNull(V) then
    begin
      S := V;
      if IsPrefixed(S) then
      begin
        TypeName := ExtractLocalName(S);
        Pre := ExtractPrefix(S);
        TypeURI := Node.FindNamespaceURI(Pre);
      end
      else
      begin
        TypeName := S;
        TypeURI := Node.NamespaceURI;
      end;
      Result := True;
    end;
  end
end;

procedure TSOAPDomConv.SetObjectPropFromText(Instance: TObject; PropInfo: PPropInfo; const SoapData: InvString);
const
  SimpleFmt = '%s:(%s) ';
var
 I: LongInt;
 E: Extended;
 I64: Int64;
 Obj: TObject;
 ElemInfo: PTypeInfo;
 Dims: Integer;
{$IFNDEF UNICODE}
 S: string;
 {$ENDIF}
 ByteArray: TBytes;
begin
  case (PropInfo.PropType)^.Kind of
    tkInteger:
      begin
        I := StrToInt(SoapData);
        SetOrdProp(Instance, PropInfo, I);
      end;
    tkFloat:
      begin
        if PropInfo.PropType^ = TypeInfo(TDateTime) then
        begin
          E := XMLTimeToDateTime(SoapData);
        end
        else
          E := StrToFloatEx(SoapData);
        SetFloatProp(Instance, PropInfo, E);
      end;
{$IFNDEF NEXTGEN}
    tkWString:
      SetWideStrProp(Instance, PropInfo, SoapData);
{$ENDIF !NEXTGEN}
{$IFDEF UNICODE}
{$IFNDEF NEXTGEN}
    tkString,
    tkLString:
      SetAnsiStrProp(Instance, PropInfo, AnsiString(SoapData));
{$ENDIF !NEXTGEN}
{$ELSE}
    tkString,
    tkLString:
      SetStrProp(Instance, PropInfo, SoapData);
{$ENDIF}
{$IFDEF TIBURON_UP}
    tkUString:
      SetStrProp(Instance, PropInfo, SoapData);
{$ENDIF}
    tkInt64:
      begin
        I64 := StrToInt64(SoapData);
        SetInt64Prop(Instance, PropInfo, I64);
      end;
    tkEnumeration:
      SetEnumPropExW(Instance, PropInfo, SoapData);
    tkChar,
    tkWChar:
      if SoapData <> '' then
        SetOrdProp(Instance, PropInfo, Integer(SoapData[1]));

    tkClass:
      { Here we handle TXSxxxx types as they represent Simple Types }
      if (GetTypeData(PropInfo.PropType^).ClassType.InheritsFrom(TRemotableXS)) then
      begin
        Obj := GetObjectProp(Instance, PropInfo);
        if Obj = nil then
        begin
          Obj := TRemotableXSClass(GetTypeData(PropInfo.PropType^).ClassType).Create;
          SetObjectProp(Instance, PropInfo, Obj);
        end;
        TRemotableXS(Obj).XSToNative(SoapData);
      end;

      { Byte array is the only type that we support converting from text }
    tkDynArray:
      begin
        GetDynArrayElTypeInfo((PropInfo.PropType)^, ElemInfo, Dims);
        if (Dims <> 1) or not ByteArrayInfo(ElemInfo) then
          raise ESOAPDomConvertError.CreateFmt(SUnexpectedDataType,
                                               [Format(SimpleFmt, [KindNameArray[(PropInfo.PropType)^.Kind],
                                                                   (PropInfo.PropType)^.Name])]);
{$IFNDEF UNICODE}
        S := DecodeString(SoapData);
        SetLength(ByteArray, Length(S));
        Move(S[1], Pointer(ByteArray)^, Length(S));
{$ELSE}
{$IFDEF NEXTGEN}
        ByteArray := DecodeBase64(SoapData);
{$ELSE !NEXTGEN}
        ByteArray := DecodeBase64(AnsiString(SoapData));
{$ENDIF NEXTGEN}
{$ENDIF}
        SetDynArrayProp(Instance, PropInfo, Pointer(ByteArray));
      end;

    tkSet,
    tkMethod,
    tkArray,
    tkRecord,
    tkInterface,
    tkVariant:
      raise ESOAPDomConvertError.CreateFmt(SUnexpectedDataType, [KindNameArray[(PropInfo.PropType)^.Kind]]);
  else
    raise ESOAPDomConvertError.CreateFmt(SUnexpectedDataType, [KindNameArray[(PropInfo.PropType)^.Kind]]);
  end;
end;

{ This event is a convenient way to find out if a particular
  member of a class was not deserialized off the wire }
procedure TSOAPDomConv.ObjectMemberNoShow(const ClassName: string; const MemberName: string);
begin
  if Assigned(FOnMemberDataNotReceived) then
    FOnMemberDataNotReceived(ClassName, MemberName);
end;

procedure TSOAPDomConv.UnhandledNode(const Name: string; NodeXML: InvString);
begin
  if Assigned(FOnUnhandledNode) then
    FOnUnhandledNode(Name, NodeXML);
end;

procedure TSOAPDomConv.LoadObject(Instance: TObject; RootNode, Node: IXMLNode);
begin
  if Instance.InheritsFrom(TRemotable) then
    TRemotable(Instance).SOAPToObject(RootNode, Node, Self)
  else
    InitObjectFromSOAP(Instance, RootNode, Node);
end;

procedure TSOAPDomConv.InitObjectFromSOAP(Instance: TObject; RootNode, Node: IXMLNode);
var
  ProcessedNodes: TBooleanDynArray;

  { Returns the Index of the first child node whose name matches that of the Property name
    specified and that has not been processed already }
{$IFDEF NEXTGEN}
  function FindPropNodeIndex(const Node: IXMLNode; const PropName: string): Integer;
{$ELSE !NEXTGEN}
  function FindPropNodeIndex(const Node: IXMLNode; const PropName: WideString): Integer;
{$ENDIF NEXTGEN}
  var
    Index: Integer;
    ChildNode: IXMLNode;
  begin
    Result := -1;
    for Index := 0 to Node.ChildNodes.Count-1 do
    begin
      if ProcessedNodes[Index] = False then
      begin
        ChildNode := Node.ChildNodes[Index];
        if ExtractLocalName(ChildNode.NodeName) = PropName then
        begin
          Result := Index;
          Exit
        end;
      end;
    end;
  end;

  { Returns the Index of the first child node(s) whose name matche(s) that of the Property name
    specified and that has not been processed already }
{$IFDEF NEXTGEN}
  function FindPropNodeIndices(const Node: IXMLNode; const PropName: string): ArrayOfInteger;
{$ELSE !NEXTGEN}
  function FindPropNodeIndices(const Node: IXMLNode; const PropName: WideString): ArrayOfInteger;
{$ENDIF NEXTGEN}
  var
    Index, Len: Integer;
    ChildNode: IXMLNode;
  begin
    Len := 0;
    SetLength(Result, 0);
    for Index := 0 to Node.ChildNodes.Count-1 do
    begin
      if ProcessedNodes[Index] = False then
      begin
        ChildNode := Node.ChildNodes[Index];
        if ExtractLocalName(ChildNode.NodeName) = PropName then
        begin
          SetLength(Result, Len+1);
          Result[Len] := Index;
          Inc(Len);
        end;
      end;
    end;
  end;

  function GetAttributeText(PropInfo: PPropInfo;
                            AttrNode: IXMLNode;
                            const ExtPropName: InvString;
                            const PropNamespace: InvString;
                            out AttrValue: InvString): Boolean;
  var
    Attrs: IXMLNodeList;
    AttrName: string;
    I: Integer;
  begin
    Result := False;
    if AttrNode.HasAttribute(ExtPropName) then
    begin
      AttrValue := AttrNode.Attributes[ExtPropName];
      Result := True;
    end
    else if (PropNamespace <> '') and
            (AttrNode.HasAttribute(ExtPropName, PropNamespace)) then
    begin
      AttrValue := AttrNode.GetAttributeNS(ExtPropName, PropNamespace);
      Result := True;
    end
    else if IsQualifiedProperty(PropInfo) then
    begin
      Attrs := AttrNode.AttributeNodes;
      for I := 0 to Attrs.Count-1 do
      begin
        AttrName := Attrs[I].NodeName;
        if IsPrefixed(AttrName) and
           (ExtractLocalName(AttrName)= ExtPropName) then
        begin
          AttrValue := Attrs[I].Text;
          Result := True;
          Exit;
        end;
      end;
    end;
  end;


const
{$IFDEF NEXTGEN}
  sDefaultValues: array[TTypeKind] of string = (
{$ELSE !NEXTGEN}
  sDefaultValues: array[TTypeKind] of WideString = (
{$ENDIF NEXTGEN}
    {tkUnknown}'', {tkInteger}'0', {tkChar}#0, {tkEnumeration}'',
    {tkFloat}'0', {tkString}'', {tkSet}'', {tkClass}'', {tkMethod}'',
    {tkWChar}#0, {tkLString}'', {tkWString}'', {tkVariant}'',
    {tkArray}'', {tkRecord}'', {tkInterface}'', {tkInt64}'0',
    {tkDynArray}''
{$IFDEF TIBURON_UP}
    ,{tkUString}''
{$ENDIF}
    ,{tkClassRef}''
    ,{tkPointer}''
    ,{tkProcedure}''
  );

var
  PropList: PPropList;
  Count, NodeCount: Integer;
  Kind: TTypeKind;
  I, J, K, L: Integer;
  Obj: TObject;
  IsNull, FoundStartOfArray: Boolean;
  URI, TypeName, ElementName, ExtPropName, TextData: InvString;
  AttrValue: InvString;
  PropRegInfo: InvString;
  ArrayPtr: Pointer;
  V: Variant;
  SoapTypeInfo: PTypeInfo;
  SerialOpts: TSerializationOptions;
  ID: InvString;
  HolderNode, AttrNode, CurrNode, ChildNode: IXMLNode;
  SimpleHolder, IsAttribute, InliningArrays: Boolean;
  PropNamespace: InvString;
begin
  HolderNode := nil;
  SimpleHolder := False;

  SerialOpts := SerializationOptions(Instance);

  { If we have a holder class, it's to pick up properties [unless we're
    in literal mode or inlining arrays ] }
  if (xoHolderClass in SerialOpts) then
  begin
    if not (xoInlineArrays in SerialOpts) or (xoLiteralParam in SerialOpts) then
    begin
      { Store the data node that was destined for this class }
      { And move up to pick up other attribute/members... }
      HolderNode := Node;
      Node := Node.ParentNode;
    end;
    { SimpleHolder - implies we're interested in only one node }
    SimpleHolder := (xoAttributeOnLastMember in SerialOpts);
  end;

  Count := GetTypeData(Instance.ClassInfo)^.PropCount;
  if Count > 0 then
  begin
    GetMem(PropList, Count * SizeOf(Pointer));
    try
      { Iterate through properties matching them to nodes or attributes }
      { NOTE: This is a total disregard for XML's notion of <sequence>
              and order. By trying to match properties to XML elements,
              we can run into problems of types that have <any> or who
              have more than one element of a given <name..>, etc. }
      GetPropInfos(Instance.ClassInfo, PropList);

      { Complex type as simple type wrapper }
      if (xoSimpleTypeWrapper in SerialOpts) and (Count = 1) then
      begin
        SetObjectPropFromText(Instance, PropList[0], GetNodeAsText(Node));
      end
      else
      begin
        { If we're not handling a holder, keep track of nodes we process }
        { A simple holder is only interested in it's data node           }
        if not SimpleHolder then
        begin
          NodeCount := Node.ChildNodes.Count;
          SetLength(ProcessedNodes, NodeCount);
          for I := 0 to NodeCount-1 do
            ProcessedNodes[I] := False;
        end else
          SetLength(ProcessedNodes, 0);

        for I := 0 to Count-1 do
        begin
          PropRegInfo := '';

          { Text Property ? }
          if IsTextProperty(PropList[I]) then
          begin
            SetObjectPropFromText(Instance, PropList[I], GetNodeAsText(Node));
            { A Text node has just one child node }
            if Length(ProcessedNodes) = 1 then
              ProcessedNodes[0] := True;
            continue;
          end;

          Kind := (PropList[I].PropType)^.Kind;
          IsAttribute := IsAttributeProperty(Kind, PropList[I]);

          PropNamespace := '';
          ExtPropName := RemTypeRegistry.GetExternalPropName(Instance.ClassInfo, TypeInfoName(PropList[I].Name));
          if ExtPropName[Low(string)] = INFOATTR_BEG_CHAR then
          begin
            PropRegInfo := ExtPropName;
            if not GetRegInfo(PropRegInfo, InfoAttribute.iaExternalName, ExtPropName) then
              ExtPropName := TypeInfoName(PropList[I].Name);
            GetRegInfo(PropRegInfo, InfoAttribute.iaNamespace, PropNamespace);
          end;

          { Is the property coming down as an attribute }
          if IsAttribute then
          begin
            { Get the potential attribute Node }
            if SimpleHolder then
              AttrNode := HolderNode
            else
              AttrNode := Node;

            if GetAttributeText(PropList[I], AttrNode,
                                ExtPropName, PropNamespace,
                                AttrValue) then
            begin
              if (Kind <> tkClass) then
                SetObjectPropFromText(Instance, PropList[I], AttrValue)
              else
              begin
                if GetTypeData(PropList[I].PropType^).ClassType.InheritsFrom(TRemotableXS) then
                begin
                  Obj := GetObjectProp(Instance, PropList[I]);
                  if (Obj = nil) then
                    Obj := GetTypeData((PropList[I].PropType)^).ClassType.Create;
                  SetObjectProp(Instance, PropList[I], Obj);
                  TRemotableXS(Obj).XSToNative(AttrValue);
                end;
              end;
            end
            else
              { Here something we were expecting did *NOT* come down the wire ?? }
              if not IsOptionalProperty(PropList[I]) then
                ObjectMemberNoShow(Instance.ClassName, TypeInfoName(PropList[I].Name));
            continue;
          end
          else
          begin
            if not SimpleHolder then
              K := FindPropNodeIndex(Node, ExtPropName)
            else
              K := Node.ChildNodes.IndexOf(HolderNode);

            { If we have a node to deserialize }
            if K <> -1 then
            begin
              { Mark node as processed }
              if Length(ProcessedNodes) > K then
                ProcessedNodes[K] := True;

              { Get Child with data we want node }
              ChildNode := Node.ChildNodes[K];

              { Here we match the property to a Child Node }
              { Class property }
              if Kind = tkClass then
              begin
                Obj := ConvertSOAPToObject(RootNode, ChildNode, GetTypeData((PropList[I].PropType)^).ClassType,
                                           '', '', nil);
                if Obj <> nil then
                  SetObjectProp(Instance, PropList[I], Obj);
              { Array properties }
              end else if Kind = tkDynArray then
              begin
                IsNull := NodeIsNull(ChildNode);
                { In document mode, the node could have attributes that we want to retrieve }
                if (not IsNull) or (UsingLiteralEncoding) then
                begin
                  GetElementType(ChildNode, URI, TypeName);
                  ArrayPtr := nil;
                  { Here if the object we're writing to inlines array members [i.e. it's array
                    members had 'maxOccurs="unbounded"', then we send in the Parent node as the array "holder"
                    node and only process the nodes that have the wanted node name }
                  InliningArrays := (xoInlineArrays in SerialOpts) or (IsUnboundedProperty(PropList[I]));
                  if InliningArrays then
                  begin
                    ChildNode := ChildNode.ParentNode;
                    ElementName := ExtPropName;
                  end
                  else
                    ElementName := '';

                  ArrayPtr := ConvertSoapToNativeArray(@ArrayPtr, (PropList[I].PropType)^,
                                                         RootNode, ChildNode, ElementName);

                  if InliningArrays then
                  begin
                    FoundStartOfArray := False;
                    for J := 0 to Node.ChildNodes.Count - 1 do
                    begin
                      if ProcessedNodes[J] then
                        Continue;
                      CurrNode := Node.ChildNodes[J];
                      if CurrNode.NodeType <> ntElement then
                        Continue;

                      if ExtractLocalName(CurrNode.NodeName) = ElementName then
                      begin
                        FoundStartOfArray := True;
                        ProcessedNodes[J] := True;
                      end
                      else if FoundStartOfArray then
                        Break;
                    end;
                  end;

                  { Since we handle dynamic arrays as pointers, we don't benefit from
                    cleanup code generated by the compiler. The above returns the array
                    with ref-count of 1; Setting the property will bump it up.
                    We need to adjust for the one release that would have happened here
                    had 'ArrayPtr' been exposed as an array }
                  if Assigned(ArrayPtr) then
                    L := PInteger(PByte(ArrayPtr)-(Sizeof(NativeInt) + Sizeof(LongInt)))^
                  else
                    L := 0;
                  SetDynArrayProp(Instance, PropList[I], ArrayPtr);
                  if (L > 0) and ((PInteger(PByte(ArrayPtr)-(Sizeof(NativeInt) + Sizeof(LongInt)))^) > L) then
                    Dec(PInteger(PByte(ArrayPtr)-(Sizeof(NativeInt) + Sizeof(LongInt)))^);
                end;
              end else if Kind = tkVariant then
              begin
                if ChildNode.ChildNodes.Count > 1 then
                  V := ReadVarArrayDim(ChildNode)
                else
                begin
                  if NodeIsNull(ChildNode) then
                    V := NULL
                  else
                  begin
                    GetElementType(ChildNode, URI, TypeName);
                    SoapTypeInfo := RemTypeRegistry.XSDToTypeInfo(URI, TypeName);
                    if SoapTypeInfo = nil then
                      SoapTypeInfo := TypeInfo(System.string);
                    if IsXMLDateTimeTypeInfo(SoapTypeInfo) and ChildNode.IsTextElement then
                    begin
                      V := XMLTimeToDateTime(ChildNode.Text);
                    end else if ChildNode.IsTextElement then
                      V := TypeTranslator.CastSoapToVariant(SoapTypeInfo, ChildNode.Text)
                    else
                      { Case of anyType mapping to a complex type; TXMLData would be better than Variant }
                      V := TypeTranslator.CastSoapToVariant(TypeInfo(System.string), ChildNode.XML)
                  end;
                end;
                SetVariantProp(Instance, PropList[I], V);
              end else
              begin
                { Some SOAP implementations use multiref nodes even for simple types }
                ChildNode := GetDataNode(RootNode, ChildNode, ID);
                IsNull := NodeIsNull(ChildNode);
                if IsNull then
                  TextData := sDefaultValues[Kind]
                else
                  TextData := GetNodeAsText(ChildNode);
                SetObjectPropFromText(Instance, PropList[I], TextData);
              end;
            end else
            begin
              if not IsOptionalProperty(PropList[I]) then
                ObjectMemberNoShow(Instance.ClassName, TypeInfoName(PropList[I].Name));
            end;
          end;
        end;

        { Here we report on Nodes that we did not deserialize }
        for I := 0 to Length(ProcessedNodes)-1 do
        begin
          if not ProcessedNodes[I] then
            UnhandledNode(Instance.ClassName, Node.ChildNodes[I].XML);
        end;
      end;
    finally
      FreeMem(PropList, Count * SizeOf(Pointer));
    end;
  end;
end;


function  TSOAPDomConv.ConvertSOAPToObject(RootNode, Node: IXMLNode; AClass: TClass;
  const URI, TypeName: InvString; ObjP: Pointer): TObject;
var
  ID: InvString;
  ObjNode: IXMLNode;
  IsScalar: Boolean;
  Obj, LoadedObj: TObject;
  NodeClass: TClass;
  NodeURI, NodeTypeName: InvString;
  LegalRef: Boolean;
  S: string;
begin
  if (UsingLiteralEncoding) and IsNilNode(Node) then
  begin
    Result := nil;
    Exit;
  end;

  if NodeIsNULL(Node) then
  begin
    Result := nil;
    { The following comment is very very suspicious - INVESTIGATE }
    { NOTE: In document mode a node could contain attributes that we want to retrieve }
    if (Node = nil) or not (UsingLiteralEncoding) then
      Exit;
  end;

  if ObjP = nil then 
    Obj := nil
  else
    Obj := TObject(ObjP^);

  S := ExtractLocalName(Node.NodeName);
  ObjNode := GetDataNode(RootNode, Node, ID);
  if (ID <> '') and (not AClass.InheritsFrom(TSOAPAttachment)) then
    LoadedObj := FindMultiRefNodeByID(ID)
  else
    LoadedObj := nil;

  if Assigned(LoadedObj) then
    Result := LoadedObj
  else
  begin
    GetElementType(ObjNode, NodeURI, NodeTypeName);
    NodeClass := RemTypeRegistry.URIToClass(NodeURI, NodeTypeName, IsScalar);
    LegalRef := True;

    if Assigned(Obj) then
    begin
      try
        if Obj.ClassType <> nil then
          LegalRef := True;
      except
        LegalRef := False;
      end;
    end;

    if Assigned(Obj) and LegalRef then
    begin
      if (NodeClass <> nil) and (NodeClass <> Obj.ClassType) then
        Obj := NodeClass.Create;
    end
    else
    begin
      if (NodeClass <> nil) and NodeClass.InheritsFrom(AClass) then
        Obj := TRemotableClass(NodeClass).Create
      else
        Obj := TRemotableClass(AClass).Create;
    end;

    Result := Obj;

    if ID <> '' then
      AddMultiRefNode(ID, Obj);

    LoadObject(Obj, RootNode, ObjNode);
  end;
end;

procedure TSOAPDomConv.ConvertByteArrayToSoap(RootNode, Node: IXMLNode; const Name, NodeNamespace: InvString;
                                              Info: PTypeInfo; P: Pointer);
var
  Len: Integer;
{$IFDEF NEXTGEN}
  S1: string;
{$ELSE !NEXTGEN}
  S1: AnsiString;
{$ENDIF NEXTGEN}
begin
  if (Assigned(P)) then
  begin
    Len := GetDynArrayLength(P);
    S1 := EncodeBase64(P, Len);
    CreateScalarNodeXS(RootNode, Node, Name, NodeNamespace, 'base64Binary', InvString(S1)); { do not localize }
  end
  else
    CreateNullNode(RootNode, Node, Name);
end;

procedure TSOAPDomConv.ConvertNativeArrayToSoap(RootNode, Node: IXMLNode;
    const NodeName, NodeNamespace, ChildNamespace: InvString; Info: PTypeInfo;
    P: Pointer; InlineElements: Boolean);
var
  Dims: Integer;
  DimAr: TNativeIntDynArray;
  ElementTypeNamespace, ElementTypeName: InvString;
{$IFNDEF XE_PATCH2}
  ElementNodeName, ElementNodeNamespace, ElemChildNamespace: InvString;
{$ELSE}
  ElementNodeName, ElementNodeNamespace: InvString;
{$ENDIF}
  ElemNode: IXMLNode;
  ElemInfo: PTypeInfo;
  UseNonRect: Boolean;
begin
  P := Pointer(P^);

  { Retrieve dimensions and most-underlying element }
  Dims := 0;
  GetDynArrayElTypeInfo(Info, ElemInfo, Dims);

  { Make sure we have RTTI for element}
  if not RemTypeRegistry.TypeInfoToXSD(ElemInfo, ElementTypeNamespace, ElementTypeName) then
    raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [ElemInfo.Name]);

  { Rectangular vs. Non-rectangular writers?? }
  UseNonRect := Assigned(P) and ((IsArrayRect(P, Dims)=False) or
                                 ((UsingLiteralEncoding) and (Dims > 1)) or
                                 ByteArrayInfo(ElemInfo) or
                                 (soSendUntyped in Options));

  if UseNonRect then
  begin
    WriteNonRectDynArray(RootNode, Node, NodeName, Info, NodeNamespace, ElementTypeName, P, Dims)
    { NOTE: For now I'm not putting the snip empty node code in non rectangular
            arrays as there has not been a need for this here yet }
  end
  else
  begin
    SetLength(DimAr, Dims);
    if Assigned(P) then
      GetDims(P, DimAr, Dims);

    { Array of bytes is handled separately - serialized as base64 }
    if (Dims = 1) and ByteArrayInfo(ElemInfo) then
      ConvertByteArrayToSoap(RootNode, Node, NodeName, NodeNamespace, Info, P)
    else
    begin
      if InlineElements then
        WriteRectDynArrayElem(RootNode, Node, ElemInfo, GetDynArrayLength(P), Dims, P, NodeName, NodeNamespace)
      else
      begin
        if UsingLiteralEncoding then
        begin
          ElemNode := MakeArrayNode(RootNode, Node, NodeName, NodeNamespace, ElementTypeName, DimAr);
          if not GetRegInfo(ChildNamespace, InfoAttribute.iaArrayItemName, ElementNodeName) then
            ElementNodeName := ElementTypeName;
{$IFNDEF XE_PATCH2}
          if not GetRegInfo(ChildNamespace, InfoAttribute.iaNamespace, ElementNodeNamespace) then
            ElementNodeNameSpace := NodeNamespace;
          if (not GetRegInfo(ChildNamespace, InfoAttribute.iaArrayItemNamespace, ElemChildNamespace)) then
            ElemChildNamespace := ElementNodeNamespace;
          WriteRectDynArrayElem2(RootNode, ElemNode, ElemInfo, GetDynArrayLength(P),
                                 Dims, P, ElementNodeName, ElementNodeNamespace,
                                 ElemChildNamespace);
{$ELSE}
          if not GetRegInfo(ChildNamespace, InfoAttribute.iaArrayItemNamespace, ElementNodeNamespace) then
            if not GetRegInfo(ChildNamespace, InfoAttribute.iaNamespace, ElementNodeNamespace) then
              ElementNodeNameSpace := NodeNamespace;
          WriteRectDynArrayElem2(RootNode, ElemNode, ElemInfo, GetDynArrayLength(P),
                                 Dims, P, ElementNodeName, ElementNodeNamespace);
{$ENDIF}
        end
        else
        begin
          ElemNode := MakeArrayNode(RootNode, Node, NodeName, ElementTypeNamespace, ElementTypeName, DimAr);
          WriteRectDynArrayElem(RootNode, ElemNode, ElemInfo, GetDynArrayLength(P), Dims, P, ElementTypeName, ElementTypeNamespace);
        end;

        { Very non optimal - but works for now -
          Check if user does not want to send empty nodes and snip
          this node if it has no child nodes - another approach would
          be not to parent the array node and wait until we know but... ?? }
        if (soDontSendEmptyNodes in Options) and (not ElemNode.HasChildNodes) then
          Node.ChildNodes.Delete(Node.ChildNodes.IndexOf(ElemNode));
      end;
    end;
  end;
end;


procedure TSOAPDomConv.ConvertNativeDataToSoap(RootNode, Node: IXMLNode;
                 const NodeName, NodeNamespace: InvString; Info: PTypeInfo; P: Pointer; XMLOptions: Integer);
var
  ElemNode: IXMLNode;
  IsNull, InlineElements: Boolean;
  TypeNamespace, TypeName, ChildNamespace, S: InvString;
{$IFDEF FIX_ELEM_NODE_NS}
  PrevObjectMetaClass: TClass;
  PrevInstance: TObject;
{$ENDIF}
begin
  if not RemTypeRegistry.TypeInfoToXSD(Info, TypeNamespace, TypeName) then
    raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [Info.Name]);

  if UsingLiteralEncoding then
    ChildNamespace := TypeNamespace;

  case Info.Kind of
    tkClass:
    begin
{$IFDEF FIX_ELEM_NODE_NS}
      PrevObjectMetaclass := ObjectMetaclass;
      PrevInstance := ObjectInstance;
      try
        ObjectMetaclass := GetTypeData(Info).ClassType;
        ObjectInstance := TObject(P^);
{$ENDIF}
        ConvertObjectToSOAP(NodeName, NodeNamespace, ChildNamespace, P, RootNode, Node)
{$IFDEF FIX_ELEM_NODE_NS}
      finally
        ObjectMetaclass := PrevObjectMetaclass;
        ObjectInstance := PrevInstance;
      end;
{$ENDIF}
    end;

    tkDynArray:
    begin
      InlineElements := ((IS_UNBD and XMLOptions) = IS_UNBD) or (xoInlineArrays in RemClassRegistry.SerializeOptions(Info));
      ConvertNativeArrayToSoap(RootNode, Node, NodeName, NodeNamespace, ChildNamespace, Info, P, InlineElements)
    end;

    tkSet,
    tkMethod,
    tkArray,
    tkRecord,
    tkInterface:
      raise ESOAPDomConvertError.CreateFmt(SDataTypeNotSupported, [KindNameArray[Info.Kind]]);

    tkVariant:
    begin
      ConvertVariantToSoap(RootNode, Node, NodeName, NodeNamespace, Info, P, NULL, False)
    end;
    else
    begin
      if Info.Kind = tkEnumeration then
      begin
        S := ConvertEnumToSoap(Info, P);
        ElemNode := CreateScalarNodeXS(RootNode, Node, NodeName, NodeNamespace, TypeName, S)
      end
      else
      begin
        TypeTranslator.CastNativeToSoap(Info, S, P, IsNull);
        if IsNull then
          ElemNode := CreateNULLNode(RootNode, Node, NodeName)
        else
          ElemNode := CreateScalarNodeXS(RootNode, Node, NodeName, NodeNamespace, TypeName, S);
      end
    end;
  end;
end;

procedure TSOAPDomConv.AddMultiRefNode(const ID: string; Instance: Pointer);
var
  I: Integer;
  ObjIndex: Integer;
begin
  I := FRefcache.FMHREFs.IndexOf(ID);
  { New ID }
  if (I = -1) then
    FRefCache.FMHREFs.AddObject(ID, Instance)
  else
  begin
    ObjIndex := FRefCache.FMHREFs.IndexOfObject(Instance);
    { Same object added with new ID?? }
    if (ObjIndex <> I) then
      FRefCache.FMHREFs.AddObject(ID, Instance);
  end;
end;

function  TSOAPDomConv.FindMultiRefNodeByInstance(Instance: Pointer): string;
var
  I: Integer;
begin
  Result := '';
  I := FRefCache.FMHREFs.IndexOfObject(Instance);
  if I <> -1 then
    Result := FRefCache.FMHREFs[I];
end;

function  TSOAPDomConv.FindMultiRefNodeByID(const ID: string): Pointer;
var
  I: Integer;
begin
  Result := nil;
  I := FRefCache.FMHREFs.IndexOf(ID);
  if I <> -1 then
    Result := FRefCache.FMHREFs.Objects[I];
end;

procedure TSOAPDomConv.ConvertSoapToNativeData(DataP: Pointer; TypeInfo: PTypeInfo;
  RootNode, Node: IXMLNode; Translate: Boolean);
var
  TypeUri, TypeName: InvString;
  IsNull: Boolean;
  Obj: TObject;
  P: Pointer;
  ID: InvString;
begin
  Node := GetDataNode(RootNode, Node, ID);
  IsNull := NodeIsNull(Node);
  if TypeInfo.Kind = tkVariant then
  begin
    if IsNull then
    begin
      Variant(PVarData(DataP)^) := NULL;
    end else
      ConvertSoapToVariant(Node, DataP);
  end
  else if TypeInfo.Kind = tkDynArray then
  begin
    P := DataP;
    P := ConvertSoapToNativeArray(P, TypeInfo, RootNode, Node);
    Pointer(DataP^) := P
  end
  else if TypeInfo.Kind = tkClass then
  begin
    Obj := ConvertSOAPToObject(RootNode, Node, GetTypeData(TypeInfo).ClassType, TypeURI, TypeName, DataP);
    PTObject(DataP)^ := Obj
  end
  else
  begin
    if Translate then
    begin
      if not TypeTranslator.CastSoapToNative(TypeInfo, GetNodeAsText(Node), DataP, IsNull) then
        raise ESOAPDomConvertError.CreateFmt(STypeMismatchInParam, [node.nodeName]);
    end;
  end;
end;


function TSOAPDomConv.ConvertEnumToSoap(Info: PTypeInfo; P: Pointer): InvString;
var
  Value: Pointer;
begin
  Value := P;
  Result := GetEnumName(Info, PByte(Value)^);
  { NOTE: Lower case 'True/False' for boolean typeinfos }
  if IsBooleanTypeInfo(Info) then
    Result := Lowercase(Result)
  else
  { Here check if enumeration was renamed }
    Result := RemTypeRegistry.GetExternalPropName(Info, Result);
end;

function TSOAPDomConv.ConvertSoapToEnum(Info: PTypeInfo; const S: InvString; IsNull: Boolean): Integer;
begin
  Result := GetEnumValueExW(Info, S);
end;

function TSOAPDomConv.CreateNULLNode(RootNode, ParentNode: IXMLNode; const Name: InvString; UseParentNode: Boolean): IXMLNode;
begin
  if not UseParentNode then
    Result := ParentNode.AddChild(Name, '')
  else
    Result := ParentNode;
  Result.SetAttributeNS(SSoapNIL, XMLSchemaInstNameSpace, STrue);
end;


function TSOAPDomConv.NodeIsNULL(Node: IXMLNode): Boolean;
var
  V: Variant;
begin
  Result := IsNilNode(Node);
  if (not Result) then
  begin
    V := Node.GetAttributeNS(SSoapNull, XMLSchemaInstNameSpace);
    if not VarIsNull(V) and ((V = sOneAsWide) or SameText(V, STrue)) then
      Result := True;
  end;
end;

function TSOAPDomConv.ChildNodesAreNull(Node: IXMLNode): Boolean;
var
  I: Integer;
  Child: IXMLNode;
begin
  Result := True;
  if Node.ChildNodes.Count > 0 then
  begin
    for I := 0 to Node.ChildNodes.Count-1 do
    begin
      Child := Node.ChildNodes[I];
      if Child.NodeType <> ntElement then
        continue;
      if not NodeIsNull(Node.ChildNodes[I]) then
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;

function TSOAPDomConv.FindPrefixForURI(RootNode, Node: IXMLNode;
                                       const URI: InvString;
                                       DeclIfNone: Boolean = False): InvString;
var
  DeclNode: IXMLNode;
begin
  DeclNode := Node.FindNamespaceDecl(URI);
  if DeclNode = nil then
    DeclNode := RootNode.FindNamespaceDecl(URI);
  if DeclNode <> nil then
    Result := ExtractLocalName(DeclNode.NodeName);
  if (Result = '') and DeclIfNone then
    Result := AddNamespaceDecl(RootNode, URI);
  if Result = sXMLNS then
    Result := '';
end;

function TSOAPDomConv.AddNamespaceDecl(Node: IXMLNode; const URI: InvString): InvString;
begin
  Result := Node.OwnerDocument.GeneratePrefix(Node);
  Node.DeclareNamespace(Result, URI);
end;

function TSOAPDomConv.CreateTypedNode(RootNode, ParentNode: IXMLNode;
   const NodeName, NodeNamespace, TypeName: InvString; GenPre: Boolean = False): IXMLNode;
begin
  if GenPre then
    Result := ParentNode.AddChild(NodeName, NodeNamespace, True)
  else
  begin
    if UsingLiteralEncoding then
      Result := ParentNode.AddChild(NodeName, NodeNamespace)
    else
      Result := ParentNode.AddChild(NodeName, '');
  end;

  // Set xsi:type attribute
  SetNodeType(RootNode, Result, NodeNamespace, TypeName);
end;

function TSOAPDomConv.CreateScalarNodeXS(RootNode, ParentNode: IXMLNode;
   const NodeName, NodeNamespace, TypeName, Value: InvString; GenPre: Boolean = False): IXMLNode;
begin
  Result := CreateTypedNode(RootNode, ParentNode, NodeName, NodeNamespace, TypeName);
  Result.Text := Value;
end;

procedure TSOAPDomConv.SetNodeType(RootNode, InstNode: IXMLNode; const ElemURI,
  TypeName: InvString);
var
  Pre: InvString;
begin
  if not (soSendUntyped in Options) and not (UsingLiteralEncoding) then
  begin
    { Namespace prefix of Typename }
    if ElemURI <> '' then
      Pre := FindPrefixForURI(RootNode, InstNode, ElemURI, True)
    else
      Pre := '';

    InstNode.SetAttributeNS(SSoapType, XMLSchemaInstNameSpace, MakeNodeName(Pre, TypeName));
  end;
end;

procedure TSOAPDomConv.SetNodeTypeEx(RootNode, InstNode: IXMLNode; const ElemURI, TypeName: InvString; Forced: Boolean);
var
  Pre: InvString;
begin
  if (not (soSendUntyped in Options) and not (UsingLiteralEncoding)) or Forced then
  begin
    { Namespace prefix of Typename }
    if ElemURI <> '' then
      Pre := FindPrefixForURI(RootNode, InstNode, ElemURI, True)
    else
      Pre := '';

    InstNode.SetAttributeNS(SSoapType, XMLSchemaInstNameSpace, MakeNodeName(Pre, TypeName));
  end;
end;

function TSOAPDomConv.GetOptions: TSOAPConvertOptions;
begin
  Result := FOptions;
end;

procedure TSOAPDomConv.SetOptions(const Value: TSOAPConvertOptions);
begin
  { NOTE: Some options are mutually exclusive - for example, soDocument
          does not jive well with others. We could provide logic to handle
          this here or we can rely on the caller to know how to set options }
  FOptions := Value;
end;

function TSOAPDomConv.GetNodeAsText(Node: IXMLNode): InvString;
var
  I: Integer;
begin
  Result := '';
  if Node.IsTextElement then
    Result := Node.Text
  else
    for I := 0 to Node.ChildNodes.Count - 1 do
      Result := Result + Node.ChildNodes[I].XML;
end;

function TSOAPDomConv.GetDataNode(RootNode, Node: IXMLNode; var ID: InvString): IXMLNode;
var
  V: Variant;
  REF: InvString;
  RefNode: IXMLNode;
begin
  ID := '';
  Result := Node;
  if Result = nil then
    Exit;

  if not (soSOAP12 in Options) then
    V := Node.Attributes[SXMLHREF]
  else
    V := Node.GetAttributeNS(SSOAP12XMLHREF, SSoap12EncodingNamespace);

  if not VarIsNull(V) then
  begin
    REF := V;
    if REF <> '' then
    begin
      RefNode := FindNodeByHREF(RootNode, REF);
      { See if RefNode is one level up }
      if not Assigned(RefNode) and Assigned(RootNode.ParentNode) then
        RefNode := GetDataNode(RootNode.ParentNode, Node, REF);
      if Assigned(RefNode) then
      begin
        Result := RefNode;
        if not (soSOAP12 in Options) then
          {SOAP 1.1 - Trim off the '#' in front of the multi-ref ID}
          ID := Copy(REF, 2, High(Integer))
        else
          {SOAP 1.2 - Don't trim off the '#' because it's not there}
          ID := REF;
      end;
    end;
  end
  else
  begin
    if not (soSOAP12 in Options) then
      V := Node.Attributes[SXMLID]
    else
      V := Node.GetAttributeNS(SXMLID, SSoap12EncodingNamespace);

    if not VarIsNull(V) then
      ID := V;
  end;
end;

procedure TSOAPDomConv.CheckEncodingStyle(Node: IXMLNode);
var
  V: Variant;
begin
  V := Node.GetAttributeNS(SSoapEncodingAttr, SoapEnvelopeNamespaces[soSOAP12 in Options]);
  if not VarIsNull(V) then
  begin
    if V <> SoapEncodingNamespaces[soSOAP12 in Options] then
      raise ESOAPDomConvertError.CreateFmt(SUnsupportedEncodingSyle, [V]);
  end;
end;

procedure TSOAPDomConv.AddObjectAsWriting(Instance: TObject);
var
  I: Integer;
begin
{
  for I := 0 to Length(ObjsWriting) - 1 do
    if ObjsWriting[I] = Instance then
      Exit;
}
  I :=  Length(ObjsWriting);
  SetLength(ObjsWriting, I + 1);
  ObjsWriting[I] := Instance;
end;

function TSOAPDomConv.IsObjectWriting(Instance: TObject): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Length(ObjsWriting) -1 do
    if ObjsWriting[I] = Instance then
    begin
      Result := True;
      break;
    end;
end;

procedure TSOAPDomConv.RemoveObjectAsWriting(Instance: TObject);
var
  I, J: Integer;
begin
  I := 0;
  while I < Length(ObjsWriting) do
  begin
    if ObjsWriting[I] = Instance then
      break;
    Inc(I);
  end;
  if I <  Length(ObjsWriting) then
  begin
    for J := I to Length(ObjsWriting)  - 2 do
      ObjsWriting[J] := ObjsWriting[J+1];
    SetLength(ObjsWriting, Length(ObjsWriting) -1);
  end;
end;

procedure TSOAPDomConv.ResetMultiRef;
begin
  FRefCache.FHREFS.Clear;
  FRefCache.FMHREFS.Clear;
  FRefCache.FNodes.Clear;
  SetLength(ObjsWriting, 0);
end;

end.
