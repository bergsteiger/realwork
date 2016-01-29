{*******************************************************}
{                                                       }
{ Borland Delphi Visual Component Library               }
{                 SOAP Support                          }
{                                                       }
{ Copyright (c) 2001 Borland Software Corporation       }
{                                                       }
{*******************************************************}

{ Converts a SOAP RPC request to/from an internal Delphi format using a DOM }

unit OPToSOAPDomConv;

interface

uses SysUtils, Variants, TypInfo, Classes, xmldom, XMLDoc, IntfInfo, InvokeRegistry,
     XMLIntf, OPConvert, WSDLNode, SOAPEnv, SOAPDomConv, Types, XSBuiltIns, SOAPAttachIntf,
     Contnrs;

const
  SVarArrayType = 'VarArrayType';     { do not localize }

type

  ESOAPDomConvertError = class(Exception);

  TSOAPArrayElemDesc = record
    MultiDim: Boolean;
    Dims: TIntegerDynArray;
  end;
  TSOAPArrayDesc = array of TSOAPArrayElemDesc;

  TMultiRefNodeMapElem = record
    Instance: Pointer;
    ID: string;
  end;
  TMultiRefNodeMap = array of TMultiRefNodeMapElem;

  TXMLNodeArray  = array of IXMLNode;
  TMultiRefNodeElem = record
    Node: IXMLNode;
    MultiRefChildren: TXMLNodeArray;
  end;
  TMultiRefNodes = array of TMultiRefNodeElem;

  ConvNodeState = (nsClientSend, nsServerReceive, nsServerSend, nsClientReceive);

  TMemberDataNotReceivedEvent = procedure(const ClassName: string; const Member: string) of object;
  TUnhandledNodeEvent  = procedure(const Name: string; NodeXML: WideString) of object;

  TSOAPDomConv = class(TSOAPDOMProcessor, IObjConverter)
  private
    FIDs: Integer;
    FAttachments: TSoapDataList;
    RefMap: TMultiRefNodeMap;
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
    function  CreateScalarNodeXS(RootNode, ParentNode: IXMLNode;  const NodeName, URI, TypeName: WideString; const Value: WideString; GenPre: Boolean = False): IXMLNode;
    function  GetTypeBySchemaNS(Node: IXMLNode; const URI: InvString): Variant;
    function  CreateTypedNode(RootNode, ParentNode: IXMLNode; const NodeName, URI: WideString; TypeName: WideString; GenPre: Boolean = False): IXMLNode;
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
    procedure ConvertVariantToSoap(RootNode, Node: IXMLNode;
              const Name: InvString; Info: PTypeInfo; P: PVarData; NumIndirect: Integer; V: Variant; UseVariant: Boolean);
    procedure ConvertSoapToVariant(Node: IXMLNode; InvData: Pointer);
    function  IsNodeAVarArray(const Node: IXMLNode; var VT: TVarType): Boolean;
    procedure WriteVarArray(RootNode, Node: IXMLNode; const Name: InvString; V: Variant);
    procedure WriteVariant(RootNode, Node: IXMLNode; const Name: InvString; V: Variant);
    procedure ReadVariant(Node: IXMLNode; P: Pointer);
    function  ReadVarArrayDim(Node: IXMLNode; IsVarVArray: Boolean = False; VT: TVarType = 0): Variant;
    procedure WriteVarArrayAsB64(RootNode, Node: IXMLNode; const Name: InvString; V: Variant);
    { Methods to handle native delphi array types }
    function  MakeArrayNode(RootNode, Node: IXMLNode;  const Name, URI,  TypeName: InvString;
                            Indices: array of Integer): IXMLNode; overload;
    function  MakeArrayNode(RootNode, Node: IXMLNode;  const Name, URI,  TypeName: InvString;
                            Dim, Len: Integer): IXMLNode; overload;
    procedure ConvertNativeArrayToSoap(RootNode, Node: IXMLNode;
               const Name: InvString; Info: PTypeInfo; P: Pointer; NumIndirect: Integer; InlineElements: Boolean = False);
    procedure WriteNonRectDynArray(RootNode, Node: IXMLNode; const Name: InvString; Info: PTypeInfo; const URI, TypeName: InvString; P: Pointer; Dim: Integer);
    function  WriteNonRectDynArrayElem(RootNode, Node: IXMLNode;  Info: PTypeInfo; const URI, TypeName: InvString; P: Pointer; Dim: Integer): Integer;
    function  ConvertSoapToNativeArray(DataP: Pointer;  TypeInfo: PTypeInfo;
                                       RootNode, Node: IXMLNode): Pointer;
    function  ConvertSoapToNativeArrayElem(ArrayInfo, ElemInfo: PTypeInfo;
                                           RootNode, Node: IXMLNode; ArrayDesc: TSOAPArrayDesc;
                                           Dims, CurDim: Integer; DataP: Pointer): Pointer;
    procedure ConvertByteArrayToSoap(RootNode, Node: IXMLNode; const Name: InvString;
                                     Info: PTypeInfo; P: Pointer);
    procedure WriteRectDynArrayElem(RootNode, Node: IXMLNode; Info: PTypeInfo; Size, Dim: Integer; P: Pointer; const TypeName: InvString);
    procedure WriteRectDynArray(RootNode, Node: IXMLNode; Info: PTypeInfo; Dims: Integer; P: Pointer; const TypeName: InvString);
    procedure ReadRectDynArray(RootNode, Node: IXMLNode; Info: PTypeInfo; Dims: Integer; P: Pointer; CurElem: Integer);
    procedure ReadRectDynArrayElem(RootNode, Node: IXMLNode; Info: PTypeInfo; Size, Dim: Integer; P: Pointer; var CurElem: Integer);
    procedure ReadRow(RootNode, Node: IXMLNode; var CurElem: Integer; Size: Integer; P: Pointer; Info: PTypeInfo);
    { Enums }
    function  ConvertEnumToSoap(Info: PTypeInfo; P: Pointer; NumIndirect: Integer): InvString;
    function  ConvertSoapToEnum(Info: PTypeInfo; S: InvString; IsNull: Boolean): Integer;

    { Methods that handle TObjects with RTTI }
    function  MultiRefObject(Cls: TClass): Boolean;
    function  SerializationOptions(Cls: TClass): TSerializationOptions; overload;
    function  SerializationOptions(ATypeInfo: PTypeInfo): TSerializationOptions; overload;
    function  SerializationOptions(Obj: TObject): TSerializationOptions; overload;
    procedure ConvertObjectToSOAP(const Name: InvString; ObjP: Pointer; RootNode, Node: IXMLNOde; NumIndirect: Integer);
    function  ConvertSOAPToObject(RootNode, Node: IXMLNode;
              AClass: TClass; const URI, TypeName: WideString; ObjP: Pointer; NumIndirect: Integer): TObject;

    function  CreateObjectNode(Instance: TObject; RootNode, ParentNode: IXMLNode;
                               const Name, URI: InvString; ObjConvOpts: TObjectConvertOptions): InvString;
    function  ObjInstanceToSOAP(Instance: TObject; RootNode, ParentNode: IXMLNode;
                               const NodeName, NodeNamespace: InvString; ObjConvOpts: TObjectConvertOptions;
                               out RefID: InvString): IXMLNode;
    procedure LoadObject(Instance: TObject; RootNode, Node: IXMLNode);
    procedure InitObjectFromSOAP(Instance: TObject; RootNode, Node: IXMLNode);
    procedure ObjectMemberNoShow(const ClassName: string; const MemberName: string);
    procedure UnhandledNode(const Name: string; NodeXML: WideString);

    procedure SetObjectPropFromText(Instance: TObject; PropInfo: PPropInfo; const SoapData: WideString);
    function  GetObjectPropAsText(Instance: TObject; PropInfo: PPropInfo): WideString;

    function  GetOptions: TSOAPConvertOptions;
    procedure SetOptions(const Value: TSOAPConvertOptions);
 public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ConvertNativeDataToSoap(RootNode, Node: IXMLNode;
                 const Name: InvString; Info: PTypeInfo; P: Pointer; NumIndirect: Integer); dynamic;
    procedure ConvertSoapToNativeData(DataP: Pointer; TypeInfo: PTypeInfo;
                 Context: TDataContext; RootNode, Node: IXMLNode; Translate, ByRef: Boolean; NumIndirect: Integer); dynamic;
  published
    property Options: TSOAPConvertOptions read FOptions write FOptions;
    property OnMemberDataNotReceived: TMemberDataNotReceivedEvent read FOnMemberDataNotReceived write FOnMemberDataNotReceived;
    property OnUnhandledNode: TUnhandledNodeEvent read FOnUnhandledNode write FOnUnhandledNode;
  end;

  TOPToSoapDomConvert = class(TSOAPDomConv, IOPConvert)
  private
    FWSDLView: TWSDLView;
    FTempDir:  string;
    Envelope:  TSoapEnvelope;
    FEncoding: WideString;
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
    function   GetEncoding: WideString;
    procedure  SetEncoding(const Encoding: WideString);
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
                              Headers: THeaderList): TStream;
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
    property Encoding: WideString read GetEncoding write SetEncoding;
  end;

function GetOrdPropEx(Instance: TObject; PropInfo: PPropInfo): Longint;

var
  DefArrayElemName: string = 'item';    { do not lcoalize }

implementation

uses
{$IFDEF MSWINDOWS}
  Windows, ComObj,
{$ENDIF}
EncdDecd, SOAPConst, InvRules, TypeTrans, OPToSOAPDomCustom, VarUtils, StrUtils,
  WSDLBind, XMLSchema, HTTPUtil, WSDLItems, SOAPAttach,
  oxmldom{$IFDEF MSWINDOWS}, msxmldom{$ENDIF}, xercesxmldom;

type

  { Add access to CacheFile : no data members! }

TConvertAttachment = class(TSOAPAttachment)
  procedure SetCacheFile(const Value: string);
end;

  procedure TConvertAttachment.SetCacheFile(const Value: string);
    begin
    SetSourceFile('');
    InternalSetCacheFile(Value);
  end;

{ util function }

function ntElementChildCount(const Node: IXMLNode): Integer;
var
  I: Integer;
begin
  Result := 0;
  if (Node = nil) or (Node.ChildNodes = nil) then
    Exit;
  for I := 0 to Node.ChildNodes.Count-1 do
    if Node.ChildNodes[I].NodeType = ntElement then
      Inc(Result);
end;

function ntElementChild(const Node: IXMLNode; Index: Integer): IXMLNode;
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
  StrLen := Length(DimString);
  for I := 1 to StrLen do
    if DimString[I] = '[' then      { do not localize }
      Inc(NumDims);
  SetLength(Dims, NumDims);
  I := 1;
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
            if trim(DimSize) <> '' then
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
          if trim(DimSize) <> '' then
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
    Stream.Write(Request[1], Length(Request) * 2);
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
    ConvertSoapToNativeData(HeaderObject, HeaderClsType.ClassInfo, nil, EnvNode, HeaderNode, False, True, 0);
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
begin
  Options := Options + [soXXXXHdr];
  try
    ConvertNativeDataToSoap(RootNode, ParentNode,
                            Header.ClassName,
                            Header.ClassInfo,
                            Header, 0);
  finally
    Options := Options - [soXXXXHdr];
  end;
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
  EnvNode := XmlDoc.DocumentElement;
  if EnvNode = nil then
    raise ESOAPDomConvertError.Create(SInvalidSOAPRequest);
  if (ExtractLocalName(EnvNode.NodeName) <> SSoapEnvelope) or (EnvNode.NamespaceURI <> SSoapNameSpace) then
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
                continue;
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
            MethNum := GetMethNum(IntfMD, InternalMethodName, NtElementChildCount(MethNode));
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
                continue;
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
                    or ((pfReference in MD.Params[K].Flags) and (MD.Params[K].Info.Kind = tkString));
                  ConvertSoapToNativeData(Context.GetParamPointer(K), MD.Params[K].Info, Context, MethNode,
                    ParamNode, Translate, False,  1);
                  break;
                end
                  { Here we have an unhandled parameter node }
                  { Check if the name mismatches were due to wrapper classes }
                else if (xoHolderClass in ParamSerialOpts) and (ParamCount = 1) then
                begin
                  Translate := (pfVar in MD.Params[K].Flags)
                    or (pfConst in  MD.Params[K].Flags)
                    or ([] =  MD.Params[K].Flags)
                    or ((pfReference in MD.Params[K].Flags) and (MD.Params[K].Info.Kind = tkVariant))
                    or ((pfReference in MD.Params[K].Flags) and (MD.Params[K].Info.Kind = tkString));
                  ConvertSoapToNativeData(Context.GetParamPointer(K), MD.Params[K].Info, Context, MethNode,
                                          Node, Translate, False,  1);
                  break;
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
var
  XMLWString: WideString;
  StrStr: TStringStream;
begin

  { NOTE: Typically you don't want us to UTF8 Encode if you've requested
          the DOM to encode; however, some implementations seem to
          indiscriminately UTF8Decode - so you can force UTF8 encoding, which
          will make us make the DOM ignore any encoding set
     *********************************************************************
       Remember to keep the Transport in sync. with any DOM encodings -
       namely the 'UseUTF8InHeader' property of the transport components     }

  if (FEncoding = '') or (soUTF8EncodeXML in Options) then
  begin
    XMLDoc.SaveToXML(XMLWString);
    StrStr := TStringStream.Create(UTF8Encode(XMLWString));
    try
      Stream.CopyFrom(StrStr, 0);
    finally
      StrStr.Free;
    end;
  end else
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
  SoapNS: InvString;
  ArgName: InvString;
  P: Pointer;
  Header: TObject;
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
    HeaderNode := Envelope.MakeHeader(EnvNode);
    if not (soDocument in Options) then
      HeaderNode.SetAttributeNS(SSoapEncodingAttr, SSoapNameSpace, SSoap11EncodingS5);
    for I := 0 to Headers.Count-1 do
    begin
      Header := Headers[I];
      WriteHeader(Header, HeaderNode, HeaderNode);
    end;
  end;

  BodyNode := Envelope.MakeBody(EnvNode);
  if not (soDocument in Options) then
    BodyNode.SetAttributeNS(SSoapEncodingAttr, SSoap11EncodingS5, SSoapNameSpace);

  if not (soLiteralParams in Options) then
  begin
    SoapNS := GetSoapNS(IntfMD);
    if not (soDocument in Options) then
      MethNode := BodyNode.AddChild(MD.Name + SSoapResponseSuff, SoapNS, True)
    else
      MethNode := BodyNode.AddChild(MD.Name + SSoapResponseSuff, SoapNS)
  end else
  begin
    { If Literal params were not unwound, we don't need a method node }
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
      ConvertNativeDataToSoap(RootNode, MethNode, ArgName, MD.ResultInfo, Context.GetResultPointer, 1);
    end;
    for I := 0 to MD.ParamCount - 1  do
    begin
      if (pfVar in MD.Params[I].Flags) or (pfOut in MD.Params[I].Flags)
      then
      begin
        P := Context.GetParamPointer(I);
        ConvertNativeDataToSoap(RootNode, MethNode, MD.Params[I].Name, MD.Params[I].Info, P, 1);
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
  ExtName: WideString;
begin
  if Assigned(WSDLView) then
  begin
    ExtName :=  InvRegistry.GetMethExternalName(MD.Info, WSDLVIew.Operation);
    Result := WSDLView.WSDL.GetSoapBodyAttribute(GetBinding, ExtName, WSDLBind.SInput, WSDLBind.SNameSpace, 0);
    { NOTE: Document Style WSDL don't have a namespace on the input/ouput nodes }
    if (Result = '') then
      Result := InvRegistry.GetNamespaceByGUID(MD.IID);
  end else
    Result := InvRegistry.GetNamespaceByGUID(MD.IID);
end;

procedure TOPToSoapDomConvert.MakeFault(const Ex: Exception; EStream: TStream);
var
  XmlDoc: IXMLDocument;
  EnvNode, BodyNode, FaultNode, FA, FC, FS, FD, CustNode: IXMLNode;
  I, Count: Integer;
  PropList: PPropList;
  URI, TypeName: WideString;
  IsScalar: Boolean;
  RemException: ERemotableException;
begin
  XMLDoc := NewXMLDocument;
  XMLDoc.Encoding := FEncoding;
  EnvNode := Envelope.MakeEnvelope(XMLDoc, Options);
  BodyNode := Envelope.MakeBody(EnvNode);
  FaultNode := Envelope.MakeFault(BodyNode);
  FA := FaultNode.AddChild(SSoapFaultActor, '');
  FC := FaultNode.AddChild(SSoapFaultCode, '');
  { NOTE: We map the FaultString to Exception's Message }
  FS := FaultNode.AddChild(SSoapFaultString, '');
  FS.Text := Ex.Message;
  if Ex.InheritsFrom(ERemotableException) then
  begin
    RemException := ERemotableException(Ex);
    FA.Text := RemException.FaultActor;
    FC.Text := MakeNodeName(SSoapNameSpacePre, RemException.FaultCode);

    RemClassRegistry.ClassToURI(Ex.ClassType, URI, TypeName, IsScalar);

    { The follow logic is *NOT* as per the SOAP spec. The spec wants
      specific information under the details node - not *AT* the details
      node !!!! But we offer it as an option given that Delphi6, which
      had limited (Delphi<->Delphi) Fault support followed that approach }
    if (soCustomFaultAtDetailsNode in Options) then
    begin
      FD := FaultNode.AddChild(SSoapFaultDetails, URI, True);
      CustNode := FD;
    end
    else
    begin
      FD := FaultNode.AddChild(SSoapFaultDetails, '');
      CustNode := FD.AddChild(TypeName, URI, True);
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
          if not RemTypeRegistry.TypeInfoToXSD( (PropList[I].PropType)^, URI, TypeName) then
            raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [(PropList[I].PropType)^.Name]);
          CreateScalarNodeXS(CustNode, CustNode, PropList[I].Name, URI, TypeName, GetObjectPropAsText(Ex, PropList[I]));
        end;
      finally
        FreeMem(PropList, Count * SizeOf(Pointer));
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
  I: Integer;
  SoapMethNS: InvString;
  MethMD: TIntfMethEntry;
  P: Pointer;
  Indir: Integer;
  URI, ExtMethName, ExtParamName: InvString;
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
    HeaderNode := Envelope.MakeHeader(EnvNode);
    if not (soDocument in Options) then
      HeaderNode.SetAttributeNS(SSoapEncodingAttr, SSoapNameSpace, SSoap11EncodingS5);
    for I := 0 to Headers.Count-1 do
    begin
      Header := Headers[I];
      WriteHeader(Header, HeaderNode, HeaderNode);
    end;
  end;

  BodyNode := Envelope.MakeBody(EnvNode);

  { If we're sending literal params, then skip the method node }
  if not (soLiteralParams in Options) then
  begin
    SoapMethNS := GetSoapNS(IntfMD);
    { Add Method node with appropriate namespace }
    ExtMethName := InvRegistry.GetMethExternalName(IntfMD.Info, MethMD.Name);
    if not (soDocument in Options) then
    begin
      MethNode := BodyNode.AddChild(ExtMethName, SoapMethNS, (SoapMethNS <> ''));
      { Use encoding style defined by SOAP 1.1 section 5 }
      { NOTE: We used to put this on the method node; it seems more intuitive on
              the body node; Keep this in mind when investigating interop issues }
      BodyNode.SetAttributeNS(SSoapEncodingAttr, SSoapNameSpace, SSoap11EncodingS5);
    end
    else
    begin
      { In document mode, SoapMethNS is the default namespace }
      MethNode := BodyNode.AddChild(ExtMethName, SoapMethNS);
    end;
  end
  else
  begin
    MethNode := BodyNode;
  end;

  try
    { Add each parameter to the method node }
    for I := 0 to MethMD.ParamCount - 1  do
    begin
      if not (pfOut in MethMD.Params[I].Flags) then
      begin
        { In doc|lit mode, we use the typename for the node }
        if (soDocument in Options) and (soLiteralParams in Options) then
          RemTypeRegistry.TypeInfoToXSD(MethMD.Params[I].Info, URI, ExtParamName)
        else
          ExtParamName := InvRegistry.GetParamExternalName(IntfMD.Info, MethMD.Name, MethMD.Params[I].Name);
        P := Con.GetParamPointer(I);
        Indir := 1;
        if IsParamByRef(MethMd.Params[I].Flags, MethMD.Params[I].Info, MethMD.CC) then
          Inc(Indir);
        ConvertNativeDataToSoap(BodyNode, MethNode, ExtParamName,
                                MethMD.Params[I].Info, P, Indir);
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

  { This is the tricky part of deserializing; How to determine the return index;
    This function should only be used if we're processing a function - IOW, this
    function should only be called if the method we're processing has
    MD.ResultInfo <> nil }
  function FindReturnNodeIndex: integer;
  var
    X, Y, First, Ret, Count: Integer;
    Node: IXMLNode;
    ReturnParams: TStringDynArray;
  begin
    First := -1;
    Ret := -1;
    Count := 0;
    { Get array of return parameter names }
    ReturnParams := StringToStringArray(InvRegistry.GetReturnParamNames(IntfMD.Info),
                                        sReturnParamDelimiters);
    for X := 0 to RespNode.ChildNodes.Count-1 do
    begin
      Node := RespNode.ChildNodes[X];
      if Node.NodeType <> ntElement then
        continue;
      { Save first valid node }
      if First = -1 then
        First := X;
      { Save Return param name(s) matches }
      if (Ret = -1) and (Length(ReturnParams) > 0) then
      begin
        for Y := 0 to Length(ReturnParams)-1 do
        begin
          if SameText(ExtractLocalName(Node.NodeName), ReturnParams[Y]) then
            Ret := X;
        end;
      end;
      Inc(Count);
    end;
    if Count = 1 then
      Result := First
    else
      Result := Ret;
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
  ByRef: Boolean;
  Indir: Integer;
  ParamProcessed: TBooleanDynArray;
begin
  SetLength(ParamProcessed, MD.ParamCount);
  for J := 0 to Length(ParamProcessed) - 1 do
    ParamProcessed[J] := False;

  { Find index of return node - if we're expecting one }
  if (MD.ResultInfo <> nil) then
  begin
    RetIndex := FindReturnNodeIndex;
    { We'll be lenient about nillable types }
    if (RetIndex = -1) and not IsNillable(MD.ResultInfo) then
      raise ESOAPDomConvertError.CreateFmt(SMissingSoapReturn, [RespNode.XML]);
  end
  else
    RetIndex := -1;

  { Process returned nodes }
  if RespNode.HasChildNodes then
  begin
    for I := 0 to RespNode.childNodes.Count - 1 do
    begin
      Node := RespNode.childNodes[I];
      { Skip non-valid nodes }
      if Node.NodeType <> ntElement then
        continue;
      { Process Return value, if we're expecting one }
      if I = RetIndex then
      begin
        InvData := InvContext.GetResultPointer;
        ByRef := IsParamByRef([pfOut], MD.ResultInfo, MD.CC);
        ConvertSoapToNativeData(InvData, MD.ResultInfo, InvContext, RespNode, Node, True, ByRef, 1);
      end
      else
      begin
        J := 0;
        while J < MD.ParamCount do
        begin
          if MD.Params[J].Name = ExtractLocalName(Node.NodeName) then
            break;
          Inc(J);
        end;
        if (J < MD.ParamCount) and not ParamProcessed[J]  then
        begin
          ParamProcessed[J] := True;
          InvData := InvContext.GetParamPointer(J);
          ByRef := IsParamByRef(MD.Params[J].Flags, MD.Params[J].Info, MD.CC);
          Indir := 1;
          if IsParamByRef(MD.Params[J].Flags, MD.Params[J].Info, MD.CC) then
            Inc(Indir);
          ConvertSoapToNativeData(InvData, MD.Params[J].Info, InvContext, RespNode, Node, True, ByRef,  Indir);
        end;
      end;
    end;
  end else if (MD.ResultInfo <> nil) and IsNillable(MD.ResultInfo) then
  begin
    InvData := InvContext.GetResultPointer;
    ByRef := IsParamByRef([pfOut], MD.ResultInfo, MD.CC);
    ConvertSoapToNativeData(InvData, MD.ResultInfo, InvContext, RespNode, nil, True, ByRef, 1);
  end;
end;


procedure TOPToSoapDomConvert.ProcessFault(FaultNode: IXMLNode);
var
  FA, FC, FD, FS, CustNode: IXMLNode;
  I, J: Integer;
  AMessage: WideString;
  AClass: TClass;
  URI, TypeName: WideString;
  Count: Integer;
  PropList: PPropList;
  Ex: ERemotableException;
begin
  FA := nil;
  FC := nil;
  FD := nil;
  FS := nil;
  Ex := nil;
  for I := 0 to FaultNode.ChildNodes.Count - 1 do
  begin
    if      SameText(ExtractLocalName(FaultNode.ChildNodes[I].NodeName), SSoapFaultCode) then
      FC := FaultNode.ChildNodes[I]
    else if SameText(ExtractLocalName(FaultNode.ChildNodes[I].NodeName), SSoapFaultString) then
      FS := FaultNode.ChildNodes[I]
    else if SameText(ExtractLocalName(FaultNode.ChildNodes[I].NodeName), SSoapFaultDetails) then
      FD := FaultNode.ChildNodes[I]
    else if SameText(ExtractLocalName(FaultNode.ChildNodes[I].NodeName), SSoapFaultActor) then
      FA := FaultNode.ChildNodes[I];
  end;

  { Retrieve message from FaultString node }
  if FS <> nil then
    AMessage := FS.Text;

  { If there's a <detail> node, try to map it to a registered type }
  if FD <> nil then
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
    if GetElementType(FD, URI, TypeName) then
      CustNode := FD
    else
    begin
      if ntElementChildCount(FD) > 0 then
      begin
        if GetElementType(ntElementChild(FD, 0), URI, TypeName) then
          CustNode := ntElementChild(FD, 0);
      end;
    end;

    AClass := RemClassRegistry.URIToClass(URI, TypeName);
    if AClass <> nil then
    begin
      if AClass.InheritsFrom(ERemotableException) then
      begin
        Ex := ERemotableExceptionClass(AClass).Create(AMessage);
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
                if CustNode.ChildNodes[J].NodeType <> ntElement then
                  continue;
                if ExtractLocalName(CustNode.ChildNodes[J].NodeName) = PropList[I].Name then
                  SetObjectPropFromText(Ex, PropList[I], GetNodeAsText(CustNode.ChildNodes[J]));
              end;
            end;
          finally
            FreeMem(PropList, Count * SizeOf(Pointer));
          end;
        end;
      end;
    end;
  end;

  { Create default SOAP invocation exception if no suitable on was found }
  if Ex = nil then
    Ex := ERemotableException.Create(AMessage);
  if FA <> nil then
    Ex.FaultActor := FA.Text;
  if FC <> nil then
    Ex.FaultCode := FC.Text;
  if FD <> nil then
    Ex.FaultDetail := FD.XML;
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
    Stream.Write(Resp[1], Length(Resp));
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
  EnvNode, RespNode, Node, HdrNode: IXMLNode;
  ProcessedHeader, ProcessedBody: Boolean;
begin
  EnvNode := XMLDoc.DocumentElement;
  if EnvNode = nil then
    raise ESOAPDomConvertError.Create(SInvalidResponse);
  if (ExtractLocalName(EnvNode.NodeName) <> SSoapEnvelope) or
     (EnvNode.NamespaceURI <>  SSoapNameSpace) then
    raise ESOAPDomConvertError.CreateFmt(SWrongDocElem, [SSoapNameSpace, SSoapEnvelope, EnvNode.NamespaceURI,
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
        if (soLiteralParams in Options) then
        begin
          RespNode := Node;
          { Unless there's a fault }
          if RespNode.HasChildNodes then
            if ExtractLocalName(RespNode.ChildNodes[0].NodeName) = SSoapFault then
              RespNode := RespNode.ChildNodes[0];
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
  if (Value <> '') and (Value[Length(Value)] <> PathDelim) then
    FTempDir := FTempDir + PathDelim;
end;

function TOPToSoapDomConvert.GetEncoding: WideString;
begin
  Result := FEncoding;
end;

function TOPToSoapDomConvert.NewXMLDocument: IXMLDocument;
begin
  Result := XMLDoc.NewXMLDocument;
{$IFDEF MSWINDOWS}
{$IFDEF DEVELOPERS}
  { For testing purposes - make sure we handle WhiteSpace properly }
  Result.Options := Result.Options + [doNodeAutoIndent];
  Result.ParseOptions := Result.ParseOptions + [poPreserveWhiteSpace];
{$ENDIF}
{$ENDIF}
end;

procedure TOPToSoapDomConvert.SetEncoding(const Encoding: WideString);
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
  FAttachments := TSoapDataList.Create;
end;

destructor TSOAPDomConv.Destroy;
begin
  FAttachments.Destroy;
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
      break;
    end;
  end;
end;


procedure TSOAPDomConv.ConvertVariantToSoap(RootNode, Node: IXMLNode;
  const Name: InvString; Info: PTypeInfo; P: PVarData; NumIndirect: Integer; V: Variant; UseVariant: Boolean);
var
  DataP: Pointer;
begin
  if UseVariant then
  begin
    if VarIsNull(V) then
      CreateNULLNode(RootNode, Node, Name)
    else
      WriteVariant(RootNode, Node, Name, V);
  end else
  begin
    DataP := P;
    if NumIndirect > 1 then
      DataP := Pointer(PInteger(DataP)^);
    if (DataP = nil) or VarIsNull(Variant(DataP^)) then
      CreateNULLNode(RootNode,Node, Name)
    else
      WriteVariant(RootNode, Node, Name, Variant(DataP^));
  end;
end;

function IsXMLDateTimeTypeInfo(const Info: PTypeInfo): Boolean;
begin
  Result := ((Info.Kind = tkClass) and (GetTypeData(Info).ClassType = TXSDateTime)) or
            ((Info.Kind = tkFloat) and (Info = TypeInfo(TDateTime)));
end;


procedure TSOAPDomConv.WriteVariant(RootNode, Node: IXMLNode; const Name: InvString; V: Variant);
var
  S, URI, TypeName: InvString;
  Info: PTypeInfo;
  IsScalar: Boolean;
begin
  if VarIsArray(V) then
  begin
    if VarIsType(V, varByte or varArray) then
    begin
      WriteVarArrayAsB64(RootNode, Node, Name, V);
    end
    else
    WriteVarArray(RootNode, Node, Name, V);
  end
  else
  begin
    if VarIsNull(V) or VarIsEmpty(V) then
       CreateNULLNode(RootNode,Node, Name)
    else
    begin
      Info :=  RemTypeRegistry.VariantToInfo(V, soTryAllSchema in Options);
      if Info = nil then
         raise ESOAPDomConvertError.Create(SUnsupportedVariant);
      RemTypeRegistry.InfoToURI(Info, URI, TypeName, IsScalar);
      if IsXMLDateTimeTypeInfo(Info)
      {(Info.Kind = tkClass) and (GetTypeData(Info).ClassType = TXSDateTime)} then
      begin
        S := DateTimeToXMLTime(V);
      end else
        S := V;
      CreateScalarNodeXS(RootNode, Node, Name, URI, TypeName, S);
    end;
  end;
end;

function TSOAPDomConv.MakeArrayNode(RootNode, Node: IXMLNode; const Name, URI, TypeName: InvString;
                                    Indices: array of Integer): IXMLNode;
var
  ArraySpec, Dims: InvString;
  I: Integer;
  First: Boolean;
  SoapPre, Pre, TypeNs: InvString;
  ID: string;
  MultiRefNode: IXMLNode;
begin
  { Assume we have a variant type and don't create an array node }
  if (URI = '') or (TypeName = '') then
  begin
    Result := Node.AddChild(Name);
  end else
  begin
    if (soSendMultiRefArray in Options) and not (soDocument in Options) then
    begin
      ID := GetNewID;
      Pre := FindPrefixForURI(RootNode, Node,  URI, True);
      Result := Node.AddChild(MakeNodeName(Pre, Name));
      Result.Attributes[SXMLHREF] := SHREFPre + ID;
      Pre := FindPrefixForURI(RootNode, Node, SSoap11EncodingS5, True);
      MultiRefNode := CreateMultiRefNode(RootNode, MakeNodeName(Pre, SSoapEncodingArray), ID);   { do not localize }
      SetNodeType(RootNode, MultiRefNode, SSoap11EncodingS5, SSoapEncodingArray);
      Result := MultiRefNode;
    end else
    begin
      MultiRefNode := nil;
      if (soDocument in Options) then
      begin
        TypeNS := ''
      end
      else
      begin
        TypeNS := SSoap11EncodingS5;
      end;
      Result := CreateTypedNode(RootNode, Node, Name, TypeNS, SSoapEncodingArray);
    end;

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
        Dims := Dims +  ']';       { do not localize }
      end;
    end;
    if not (soSendUntyped in Options) and not (soDocument in Options) then
    begin
      SoapPre := FindPrefixForURI(RootNode, Node, SSoap11EncodingS5, True);
      Pre := FindPrefixForURI(RootNode, Node, URI, True);
      ArraySpec := Pre + ':' + TypeName + Dims;     { do not localize }
      Result.SetAttributeNS(SSoapEncodingArrayType, SSoap11EncodingS5, ArraySpec);
    end;
  end;
end;

function TSOAPDomConv.MakeArrayNode(RootNode, Node: IXMLNode; const Name, URI, TypeName: InvString;
                                    Dim, Len: Integer): IXMLNode;
var
  ArrayDims: TIntegerDynArray;
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
  LoDim, HiDim: array of integer;
  P: Pointer;
  S, Encd: String;
  ElemNode: IXMLNode;
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
    VSize := (HiDim[i] - LoDim[i] + 1);
  P := VarArrayLock(V);
  try
    SetString(S, PChar(P), VSize);
  finally
    VarArrayUnlock(V);
  end;
  Encd :=  EncodeString(S);
  ElemNode := CreateScalarNodeXS(RootNode, Node, Name, XMLSchemaNamespace, 'base64Binary', Encd);   { do not localize }
end;

procedure TSOAPDomConv.WriteVarArray(RootNode, Node: IXMLNode; const Name: InvString; V: Variant);
var
  I, DimCount: Integer;
  LoDim, HiDim, Indices: array of integer;
  V1: Variant;
  ElemNode: IXMLNode;
  VAPropSet: Boolean;
begin
  if  not VarIsArray(V) then
  begin
    WriteVariant(RootNode, Node, Name, V);
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
        WriteVarArray(RootNode, ElemNode, SDefVariantElemName, V1);
        ElemNode.SetAttributeNS(SVarArrayType, SBorlandTypeNamespace, VarType(V));
      end else
      begin
        WriteVariant(RootNode, ElemNode, SDefVariantElemName, V1);
        if not VAPropSet then
        begin
          ElemNode.SetAttributeNS(SVarArrayType, SBorlandTypeNamespace, VarType(V));
          VAPropSet := True;
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
  Count, I: Integer;
  SoapTypeInfo: PTypeInfo;
  ChildNode: IXMLNode;
  TypeURI, TypeName: InvString;
begin
  { Get count of ntElement children node }
  Count := ntElementChildCount(Node);
  if Count = 0 then
  begin
    Result := NULL;
    Exit;
  end;

  {
    Also, we could use the TVarType to (re)create a Variant of the
    original array type; Using VarVariant, however, is more
    resilient; and as long as no one cracks the Variant open - i.e.
    casts to TVarData and starts accessing members directly - we're safe.
    Sure hopes no one does that!!
  }
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
      Result[I] := ReadVarArrayDim(ChildNode, IsVarVArray, VT);
    end else
    begin
      if not NodeIsNULL(ChildNode) then
      begin
        GetElementType(ChildNode, TypeURI, TypeName);
        SoapTypeInfo := RemTypeRegistry.XSDToTypeInfo(TypeURI, TypeName);
        if SoapTypeInfo = nil then
          SoapTypeInfo := TypeInfo(System.WideString);
        { Handle 'dateTime' }
        if IsXMLDateTimeTypeInfo(SoapTypeInfo)
        {(SoapTypeInfo.Kind = tkClass) and (GetTypeData(SoapTypeInfo).ClassType = TXSDateTime)} then
        begin
          Result[I] := XMLTimeToDateTime(ChildNode.Text);
        end else
          Result[I] := TypeTranslator.CastSoapToVariant(SoapTypeInfo, ChildNode.Text);
      end else
        Result[I] := NULL;
    end;
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
  { TODO -oBB -cInvestigation : Why is IsTextElement relevant here? }
  if (Count > 1) or Node.ChildNodes[0].IsTextElement or IsVarray then
    Variant(PVarData(InvData)^) := ReadVarArrayDim(Node, IsVarray, VT)
  else
  begin
    GetElementType(Node, TypeURI, TypeName);
    Info := RemTypeRegistry.XSDToTypeInfo(TypeURI, TypeName);
    { If we can't figure out the type, map to a WideString }
    if Info = nil then
      Info := TypeInfo(System.WideString);
    { Handle dates }
    if IsXMLDateTimeTypeInfo(Info)
      {(Info.Kind = tkClass) and (GetTypeData(Info).ClassType = TXSDateTime)} then
    begin
      Variant(PVarData(InvData)^) := XMLTimeToDateTime(Node.Text);
    end else
      TypeTranslator.CastSoapToVariant(Info, GetNodeAsText(Node), InvData);
  end;
end;

function TSOAPDomConv.FindNodeByHREF(RootNode: IXMLNode; const HREF: InvString): IXMLNode;

  function findNode(root: IXMLNode): IXMLNode;
  var
    I: Integer;
    V: Variant;
  begin
    for I := 0 to root.ChildNodes.Count -1 do
    begin
      V := root.ChildNodes[I].Attributes[SXMLID];
      if not VarIsNull(V) and (SHREFPre + V = HREF) then
      begin
        Result := root.ChildNodes[I];
        Exit;
      end;
    end;
  end;

begin
  Result := nil;
  { First look at the root node }
  Result := findNode(RootNode);

  {If we could not find it, move up one level }
  if (Result = nil) and (RootNode.ParentNode <> nil) then
    Result := findNode(RootNode.ParentNode);
end;


function GetDynArrayLength(P: Pointer): Integer;
begin
  asm
    MOV  EAX, DWORD PTR P
    CALL System.@DynArrayLength
    MOV DWORD PTR [Result], EAX
  end;
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
    ElemDataP := Pointer(PInteger(P)^);
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
      ElemDataP := Pointer(PInteger(Pointer(Integer(P) + 4))^);
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

procedure GetDims(ArrP: Pointer; DimAr: TIntegerDynArray; Dims: Integer);
var
  I: Integer;
begin
  for I := 0 to Dims - 1 do
  begin
    DimAr[I] := GetDynArrayLength(ArrP);
    if I < Dims - 1 then
    begin
      if Assigned(ArrP) then
        ArrP := Pointer(PInteger(ArrP)^);
    end;
  end;
end;

procedure TSOAPDomConv.WriteRectDynArrayElem(RootNode, Node: IXMLNode;
                                             Info: PTypeInfo;
                                             Size, Dim: Integer;
                                             P: Pointer;
                                             const TypeName: InvString);
var
  I: Integer;
  S: InvString;
  IsNull: Boolean;
  ArNode: IXMLNode;
  ElemSize: Integer;
  NodeName: InvString;
begin
  if Dim > 1 then
  begin
    Dec(Dim);
    for I := 0 to Size-1 do
    begin
      ElemSize := GetDynArrayLength(Pointer(PInteger(P)^));
      WriteRectDynArrayElem(RootNode, Node, Info, ElemSize, Dim, Pointer(PInteger(P)^), TypeName);
      P := Pointer(Integer(P) + sizeof(Pointer));
    end;
  end
  else
  begin
    { Determine name of node }
    if (soDocument in options) then
      NodeName := TypeName
    else
      NodeName := DefArrayElemName;

    { Write out data }
    for I := 0 to Size-1 do
    begin
      if Info.Kind = tkClass then
      begin
        ConvertObjectToSOAP(NodeName, P, RootNode,  Node, 1);
      end else
      if Info.Kind = tkVariant then
      begin
        ConvertVariantToSoap(RootNode, Node, NodeName, Info, P, 1, NULL, False);
      end else
      begin
        if Info.Kind = tkEnumeration then
          S := ConvertEnumToSoap(Info, P, 1)
        else
          TypeTranslator.CastNativeToSoap(Info, S, P, IsNull);

        { Create node }
        if (soDocument in Options) then
          ArNode := Node.AddChild(NodeName)
        else
          ArNode := Node.AddChild(NodeName, ''); { No namespace prefix }
        { Set Value }
        ArNode.Text := S;
      end;
      P := Pointer( Integer(P) + GetTypeSize(Info));
    end;
  end;
end;

procedure  TSOAPDomConv.WriteRectDynArray(RootNode, Node: IXMLNode; Info: PTypeInfo; Dims: Integer; P: Pointer; const TypeName: InvString);
begin
  WriteRectDynArrayElem(RootNode, Node, Info, GetDynArrayLength(P), Dims, P, TypeName);
end;

function ArrayIsNull(PObj: Pointer): Boolean;
var
  P: Pointer;
begin
  Result := not Assigned(PObj);
  if not Result then
  begin
    P := Pointer(PInteger(PObj)^);
    Result := (P = Pointer($0000));
  end;
end;

function ByteArrayInfo(ElemInfo: PTypeInfo): Boolean;
begin
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
  ElemURI, ElemName: WideString;
  PData: Pointer;
begin
  { Null Array }
  if ArrayIsNull(P) then
  begin
    CreateNullNode(RootNode, Node, Name);
    Exit;
  end;

  { Retrieve Array Element information }
  ElemInfo := GetDynArrayNextInfo(Info);
  RemClassRegistry.TypeInfoToXSD(ElemInfo, ElemURI, ElemName);

  { Handle array of bytes }
  if (Dim = 1) and ByteArrayInfo(ElemInfo) then
  begin
    ConvertByteArrayToSoap(RootNode, Node, Name, Info, P);
    Exit;
  end;

  Len := GetDynArrayLength(P);
  ArrayNode := MakeArrayNode(RootNode, Node, Name, URI, TypeName, Dim, Len);

  { Write elements }
  for I := 0 to Len-1 do
  begin
    { If underlying element is array, pass pointer to data }
    if ElemInfo.Kind = tkDynArray then
      PData := Pointer(PInteger(P)^)
    else
      PData := P;
    WriteNonRectDynArrayElem(RootNode, ArrayNode, ElemInfo, ElemURI, ElemName, PData, Dim-1);
    P := Pointer(Integer(P) + GetTypeSize(ElemInfo));
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
  if soDocument in Options then
    NodeName := TypeName
  else
    NodeName := DefArrayElemName;

  { MultiD?? Recurse }
  if (Dim > 0)  or (Info.Kind = tkDynArray) then
  begin
    WriteNonRectDynArray(RootNode, Node, NodeName, Info, URI, TypeName, P, Dim);
  end
  else
  begin
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
    GetElementType(Node, URI, TypeName);
    SoapTypeInfo := RemTypeRegistry.XSDToTypeInfo(URI, TypeName);
    if SoapTypeInfo = nil then
      SoapTypeInfo := TypeInfo(System.WideString);
   if IsXMLDateTimeTypeInfo(SoapTypeInfo)
   {(SoapTypeInfo.Kind = tkClass) and (GetTypeData(SoapTypeInfo).ClassType = TXSDateTime)} then
   begin
     Variant(PVarData(P)^) := XMLTimeToDateTime(Node.Text);
   end else
     Variant(PVarData(P)^) :=  TypeTranslator.CastSoapToVariant(SoapTypeInfo, GetNodeAsText(Node));
 end;
end;

procedure TSOAPDomConv.ReadRow(RootNode, Node: IXMLNode; var CurElem: Integer; Size: Integer; P: Pointer; Info: PTypeInfo);
var
  I: Integer;
  URI, TypeName, ID: InvString;
  IsNull, IsScalar: Boolean;
  ChildNode: IXMLNode;
begin
  { Make sure we're not trying to deserialize past the size
    of data we received }
  if CurElem > ntElementChildCount(Node) then
     raise ESOAPDomConvertError.CreateFmt(SArrayTooManyElem, [Node.xml]);
  if Info.Kind = tkClass then
  begin
    for I := 0 to Size-1 do
    begin
      RemClassRegistry.ClassToURI(GetTypeData(Info).ClassType, URI, TypeName, IsScalar);
      ChildNode := ntElementChild(Node, CurElem);
      PTObject(P)^ := ConvertSOAPToObject(RootNode, ChildNode,
                        GetTypeData(Info).ClassType, URI, TypeName, P, 1);
     P := Pointer(Integer(P) + sizeof(Pointer));
     Inc(CurElem);
    end;
  end else if Info.Kind = tkVariant then
  begin
    for I := 0 to Size-1 do
    begin
      ChildNode := ntElementChild(Node, CurElem);
      ReadVariant(ChildNode, P);
      P := Pointer(Integer(P) + GetTypeSize(Info));
      Inc(CurElem);
    end;
  end else
  begin
    IsNull := False;
    for I := 0 to Size-1 do
    begin
      ChildNode := ntElementChild(Node, CurElem);
      ChildNode := GetDataNode(RootNode, ChildNode, ID);
      TypeTranslator.CastSoapToNative(Info,  ChildNode.Text, P, IsNull);
      P := Pointer(Integer(P) + GetTypeSize(Info));
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
      ElemSize := GetDynArrayLength(Pointer(PInteger(P)^));
      ReadRectDynArrayElem(RootNode, Node, Info, ElemSize, Dim, Pointer(PInteger(P)^), CurElem);
      P := Pointer(Integer(P) + sizeof(Pointer));
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
  RootNode, Node: IXMLNode; ArrayDesc: TSOAPArrayDesc; Dims, CurDim: Integer; DataP: Pointer): Pointer;
var
  PElem, ChildP, DynP: Pointer;
  Size, I: Integer;
  ID: InvString;
  ChildNode: IXMLNode;
  NodeOffset: Integer;
  CurElem: Integer;
  IntVec: TIntegerDynArray;
  DimCnt: Integer;
begin
  Result := nil;
  Node := GetDataNode(RootNode, Node, ID);
  if Dims > 1 then
  begin
    if (Length(ArrayDesc) > 0 ) and ArrayDesc[CurDim].MultiDim then
    begin
      DynP := Pointer(PInteger(DataP)^);
      DynArraySetLength(DynP, ArrayInfo, Length(ArrayDesc[CurDim].Dims), PLongInt(ArrayDesc[CurDim].Dims));
      Result := DynP;
      Size :=  Length(ArrayDesc[CurDim].Dims);
      NodeOffset := 0;
      ReadRectDynArray(RootNode,  Node, ElemInfo, Size, DynP, NodeOffset);
    end else
    begin
      Size := ntElementChildCount(Node);
      DynP := Pointer(PInteger(DataP)^);
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
      DynArraySetLength(DynP, ArrayInfo, DimCnt, PLongInt(IntVec));
      PElem := DynP;
      Result := DynP;
      Dec(Dims);
      Inc(CurDim);
      for I := 0 to Size - 1 do
      begin
        ChildNode := GetDataNode(RootNode, Node.ChildNodes[I], ID);
        ChildP :=  ConvertSoapToNativeArrayElem(GetDynArrayNextInfo(ArrayInfo), ElemInfo, RootNode,
                     ChildNode, ArrayDesc, Dims, CurDim, PElem);
        PInteger(PElem)^ := Integer(ChildP);
        PElem := Pointer(Integer(PElem) + sizeof(Pointer));
      end;
    end;
  end else if Dims = 1 then
  begin
    begin
      Size := ntElementChildCount(Node);
      if DataP <> nil then
      begin
        DynP := Pointer(PInteger(DataP)^);
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
        DynArraySetLength(DynP, ArrayInfo, DimCnt,  PLongInt(IntVec) );
        PElem := DynP;
        Result := DynP;
        CurElem := 0;
        if Size > 0 then
          ReadRow(RootNode, Node, CurElem,  Size, PElem, ElemInfo);
      end;
    end;
  end;
end;

function TSOAPDomConv.ConvertSoapToNativeArray(DataP: Pointer;  TypeInfo: PTypeInfo;
                                               RootNode, Node: IXMLNode): Pointer;
var
  Dims: Integer;
  ElemInfo: PTypeInfo;
  ArrayDesc: TSOAPArrayDesc;
  ArrayType: InvString;
  V : Variant;
  TypeURI, TypeName: InvString;
  S: String;
  ArrayLen: Integer;
  DynP: Pointer;
begin
  GetElementType(Node, TypeURI, TypeName);
  GetDynArrayElTypeInfo(TypeInfo, ElemInfo, Dims);
  if ElemInfo = nil then
    raise  ESOAPDomConvertError.CreateFmt(SNoArrayElemRTTI, [TypeInfo.Name]);
  if (Dims = 1) and
     ((ElemInfo.Kind = tkInteger) or (ElemInfo.Kind = tkChar)) and
     (GetTypeData(ElemInfo).OrdType = otUByte) and
     { Some SOAP implementations don't send the XML Namespace!! }
     (({(TypeURI = SXMLSchemaURI_2001) and }(TypeName = 'base64Binary')) or
      ((TypeURI = SSoap11EncodingS5) and (TypeName = 'base64')) or
      { Some SOAP implementations don't send the type!! }
      (TypeName = '' )) then
  begin
    S := DecodeString(Node.Text);
    ArrayLen := Length(S);
    DynP := Pointer(PInteger(DataP)^);
    DynArraySetLength(DynP, TypeInfo, 1, @ArrayLen);
    Move(S[1], DynP^, Length(S));
    Result := DynP;
  end else
  begin
    V := Node.GetAttributeNS(SSoapEncodingArrayType, SSoap11EncodingS5);
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
    Result := ConvertSoapToNativeArrayElem(TypeInfo, ElemInfo, RootNode, Node, ArrayDesc, Dims, 0, DataP);
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
  Result := RootNode.OwnerDocument.CreateNode(Name);
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
  { Parent Multi Ref right away }
  RootNode.ChildNodes.Add(Result);

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

function GetOrdPropEx(Instance: TObject; PropInfo: PPropInfo): Longint;
asm
        { ->    EAX Pointer to instance         }
        {       EDX Pointer to property info    }
        { <-    EAX Longint result              }

        PUSH    EBX
        PUSH    EDI
        MOV     EDI,[EDX].TPropInfo.PropType
        MOV     EDI,[EDI]
        MOV     BL,otSLong
        CMP     [EDI].TTypeInfo.Kind,tkClass
        JE      @@isClass
        CMP     [EDI].TTypeInfo.Kind,tkDynArray
        JE      @@isDynArray
        CMP     [EDI].TTypeInfo.Kind,tkInterface
        JE      @@isInterface
        XOR     ECX,ECX
        MOV     CL,[EDI].TTypeInfo.Name.Byte[0]
        MOV     BL,[EDI].TTypeInfo.Name[ECX+1].TTypeData.OrdType
@@isDynArray:
@@isInterface:
@@isClass:
        MOV     ECX,[EDX].TPropInfo.GetProc
        CMP     [EDX].TPropInfo.GetProc.Byte[3],$FE
        MOV     EDX,[EDX].TPropInfo.Index
        JB      @@isStaticMethod
        JA      @@isField

        {       the GetProc is a virtual method }
        MOVSX   ECX,CX                  { sign extend slot offs }
        ADD     ECX,[EAX]               { vmt   + slotoffs      }
        CALL    dword ptr [ECX]         { call vmt[slot]        }
        JMP     @@final

@@isStaticMethod:
        CALL    ECX
        JMP     @@final

@@isField:
        AND     ECX,$00FFFFFF
        ADD     ECX,EAX
        MOV     AL,[ECX]
        CMP     BL,otSWord
        JB      @@final
        MOV     AX,[ECX]
        CMP     BL,otSLong
        JB      @@final
        MOV     EAX,[ECX]
@@final:
        CMP     BL,otSLong
        JAE     @@exit
        CMP     BL,otSWord
        JAE     @@word
        CMP     BL,otSByte
        MOVSX   EAX,AL
        JE      @@exit
        AND     EAX,$FF
        JMP     @@exit
@@word:
        MOVSX   EAX,AX
        JE      @@exit
        AND     EAX,$FFFF
@@exit:
        POP     EDI
        POP     EBX
end;


procedure SetOrdPropEx(Instance: TObject; PropInfo: PPropInfo;
  Value: Longint); assembler;
asm
        { ->    EAX Pointer to instance         }
        {       EDX Pointer to property info    }
        {       ECX Value                       }

        PUSH    EBX
        PUSH    ESI
        PUSH    EDI
        MOV     EDI,EDX

        MOV     ESI,[EDI].TPropInfo.PropType
        MOV     ESI,[ESI]
        MOV     BL,otSLong
        CMP     [ESI].TTypeInfo.Kind,tkClass
        JE      @@isClass
        CMP     [ESI].TTypeInfo.Kind,tkDynArray
        JE      @@isDynArray
        CMP     [ESI].TTypeInfo.Kind,tkInterface
        JE      @@isInterface
        XOR     EBX,EBX
        MOV     BL,[ESI].TTypeInfo.Name.Byte[0]
        MOV     BL,[ESI].TTypeInfo.Name[EBX+1].TTypeData.OrdType
@@isDynArray:
@@isInterface:
@@isClass:
        MOV     EDX,[EDI].TPropInfo.Index       { pass Index in DX      }
        CMP     EDX,$80000000
        JNE     @@hasIndex
        MOV     EDX,ECX                         { pass value in EDX     }
@@hasIndex:
        MOV     ESI,[EDI].TPropInfo.SetProc
        CMP     [EDI].TPropInfo.SetProc.Byte[3],$FE
        JA      @@isField
        JB      @@isStaticMethod

        {       SetProc turned out to be a virtual method. call it      }
        MOVSX   ESI,SI                          { sign extend slot offset }
        ADD     ESI,[EAX]                       { vmt   + slot offset   }
        CALL    dword ptr [ESI]
        JMP     @@exit

@@isStaticMethod:
        CALL    ESI
        JMP     @@exit

@@isField:
        AND     ESI,$00FFFFFF
        ADD     EAX,ESI
        MOV     [EAX],CL
        CMP     BL,otSWord
        JB      @@exit
        MOV     [EAX],CX
        CMP     BL,otSLong
        JB      @@exit
        MOV     [EAX],ECX
@@exit:
        POP     EDI
        POP     ESI
        POP     EBX
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
        and (not (soDocument in Options))
        and (not RemTypeRegistry.IsClassScalar(Cls));
end;


function TSOAPDomConv.CreateObjectNode(Instance: TObject; RootNode, ParentNode: IXMLNode;
                                       const Name, URI: InvString;
                                       ObjConvOpts: TObjectConvertOptions): InvString;
begin
  { Allow TRemotable_xxxx classes to perform custom serialization }
  if Assigned(Instance) and Instance.InheritsFrom(TRemotable) then
    TRemotable(Instance).ObjectToSOAP(RootNode, ParentNode, Self, Name, URI, ObjConvOpts, Result)
  else
    ObjInstanceToSOAP(Instance, RootNode, ParentNode, Name,
                      URI, ObjConvOpts, Result);
end;

function TSOAPDomConv.ObjInstanceToSOAP(Instance: TObject; RootNode, ParentNode: IXMLNode;
                                        const NodeName, NodeNamespace: InvString; ObjConvOpts: TObjectConvertOptions;
                                        out RefID: InvString): IXMLNode;
var
  ID, Pre: InvString;
  I, Count: Integer;
  PropList: PPropList;
  Kind: TTypeKind;
  V: Variant;
  Obj: TObject;
  ElemURI, TypeName, TypeNamespace, NodeVal: InvString;
  PrefixNode, InstNode, ElemNode, AttrNode: IXMLNode;
  P: Pointer;
  ExtPropName: InvString;
  MultiRef, UsePrefix, SerializeProps, CanHaveType, HolderClass, LitParam : Boolean;
  SerialOpts: TSerializationOptions;
  ClsType: TClass;
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
  if not (soDocument in Options) and UsePrefix then
    Pre := FindPrefixForURI(PrefixNode, ParentNode,  NodeNamespace, True)
  else
    Pre := '';

  { Create the Node, if necessary }
  if not HolderClass then
  begin
    if not MultiRef then
    begin
      if (soDocument in Options) then
      begin
        RemClassRegistry.ClassToURI(Instance.ClassType, TypeNamespace, TypeName);
        if TypeNamespace = XMLSchemaNamespace then
          InstNode := ParentNode.AddChild(NodeName)
        else
          InstNode := ParentNode.AddChild(NodeName, TypeNamespace);
      end
      else
      begin
        if UsePrefix or (Pre <> '') then
          InstNode := ParentNode.AddChild(MakeNodeName(Pre, NodeName))
        else
          { Create a node without any prefix }
          InstNode := ParentNode.AddChild(NodeName, '');
      end;
    end
    else
      InstNode := CreateMultiRefNode(RootNode, MakeNodeName(Pre, NodeName), RefID);
  end
  else
    { Here this class was simply a holder - only its members are serialized!
      the class itself is stealth }
    InstNode := ParentNode;

  { Set Result Node }
  Result := InstNode;

  { Can this type generate xsi:type attributes?? }
  if CanHaveType then
  begin
    { Retrieve Type Namespace }
    RemClassRegistry.ClassToURI(Instance.ClassType, TypeNamespace, TypeName);
    { xsi:type=?? }
    SetNodeType(PrefixNode, InstNode, TypeNamespace, TypeName);
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
            ExtPropName := RemTypeRegistry.GetExternalPropName(Instance.ClassInfo, PropList[I].Name);
            Kind := (PropList[I].PropType)^.Kind;
            { Class Property }
            if Kind = tkClass then
            begin
              Obj := GetObjectProp(Instance, PropList[I]);
              if Obj = nil then
              begin
                if not (soDontSendEmptyNodes in Options) then
                  CreateNULLNode(RootNode, InstNode, ExtPropName)
              end
              else
              begin
                ClsType := GetTypeData((PropList[I].PropType)^).ClassType;
                RemClassRegistry.ClassToURI(ClsType, ElemURI, TypeName);

                MultiRef := MultiRefObject(ClsType);

                if not MultiRef then
                begin
                  if IsObjectWriting(Obj) then
                    raise ESOAPDomConvertError.CreateFmt(SNoSerializeGraphs, [Obj.ClassName]);
                  AddObjectAsWriting(Instance);
                  { NOTE: prefix for nested types ?? }
                  CreateObjectNode(Obj, RootNode, InstNode, ExtPropName, ElemURI, ObjConvOpts);
                  RemoveObjectAsWriting(Obj);
                end else
                begin
                  ElemNode := InstNode.AddChild(ExtPropName, '');
                  ID := FindMultiRefNodeByInstance(Obj);
                  { NOTE: prefix for nested types ?? }
                  if ID = '' then
                    ID := CreateObjectNode(Obj, RootNode, InstNode, ExtPropName, ElemURI, ObjConvOpts);
                  ElemNode.Attributes[SXMLHREF] := SHREFPre + ID;
                end;
              end;
            { Array property }
            end else if Kind = tkDynArray then
            begin
              P := Pointer(GetOrdPropEx(Instance, PropList[I]));
              ConvertNativeArrayToSoap(RootNode, InstNode, ExtPropName,
                                       (PropList[I].PropType)^, P, 0,
                                       (xoInlineArrays in SerialOpts));
            { Variant property }
            end else if Kind = tkVariant then
            begin
               V := GetVariantProp(Instance, PropList[I]);
               ConvertVariantToSoap(RootNode, InstNode, ExtPropName, nil, nil, 0, V, True);
            end else
            { Simple type property ?? }
            begin
              if not RemTypeRegistry.TypeInfoToXSD((PropList[I].PropType)^, ElemURI, TypeName) then
                raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [(PropList[I].PropType)^.Name]);
              { Here we check the stored property flag - that's the flag to use an
                attribute instead of a separate node - if the property is marked
                stored False, we'll use an attribute instead }
              if not IsStoredProp(Instance, PropList[I]) then
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
                  AttrNode.Attributes[ExtPropName] := NodeVal;
              end
              else
              begin
                NodeVal := GetObjectPropAsText(Instance, PropList[I]);
                { Check if user does not want to send empty nodes }
                if (not (soDontSendEmptyNodes in Options)) or (NodeVal <> '') then
                  ElemNode := CreateScalarNodeXS(RootNode, InstNode, ExtPropName, ElemURI, TypeName, NodeVal);
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


procedure TSOAPDomConv.ConvertObjectToSOAP(const Name: InvString;
  ObjP: Pointer; RootNode, Node: IXMLNOde; NumIndirect: Integer);
var
  ElemNode: IXMLNOde;
  I: Integer;
  ID: string;
  URI, TypeName: WideString;
  P: Pointer;
  Instance: TObject;
  MultiRef: Boolean;
begin
  P := ObjP;
  for I := 0 to NumIndirect - 1 do
    P := Pointer(PInteger(P)^);
  Instance := P;

  if Assigned(Instance) and not Instance.InheritsFrom(TRemotable) then
    raise ESOAPDomConvertError.CreateFmt(SUnsuportedClassType, [Instance.ClassName]);

  if not Assigned(Instance) then
    CreateNULLNode(RootNode, Node, Name)
  else
  begin
    { Retrieve URI of Type }
    if not RemClassRegistry.ClassToURI(Instance.ClassType, URI, TypeName) then
      raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [Instance.ClassName]);
    MultiRef := MultiRefObject(Instance.ClassType);
    { NOTE: SOAP Attachments will enter this path as they are never multirefed }
    if not MultiRef then
    begin
      if IsObjectWriting(Instance) then
        raise ESOAPDomConvertError.CreateFmt(SNoSerializeGraphs, [Instance.ClassName]);
      AddObjectAsWriting(Instance);
      { NOTE: Prefixing nodes can cause problems with some
              SOAP implementations. However, not doing so causes problems
              too ?? }
      CreateObjectNode(Instance, RootNode, Node, Name, URI, [ocoDontPrefixNode]);
      RemoveObjectAsWriting(Instance);
    end
    else
    begin
      ID := FindMultiRefNodeByInstance(Instance);
      { NOTE: Passing 'True' to prefix here can cause problems with some
              SOAP implementations. However, removing it can cause problems
              too ?? }
      if ID = '' then
        { NOTE: The ref'ed node must be of the TypeName - not the referring node name }
        ID := CreateObjectNode(Instance, RootNode, Node, TypeName, URI, []);
      ElemNode := Node.AddChild(Name, '' {No Namespace prefix});
      ElemNode.Attributes[SXMLHREF] := SHREFPre + ID;
    end;
  end;
end;


function TSOAPDomConv.GetObjectPropAsText(Instance: TObject;
  PropInfo: PPropInfo): WideString;
var
 I: LongInt;
 E: Extended;
 I64: Int64;
 DT: TDateTime;
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
    tkWString:
      Result := GetWideStrProp(Instance, PropInfo);
    tkString,
    tkLString:
      Result := GetStrProp(Instance, PropInfo);
    tkInt64:
      begin
        I64 := GetInt64Prop(Instance, PropInfo);
        Result := IntToStr(I64);
      end;
    tkEnumeration:
      begin
        Result := GetEnumProp(Instance, PropInfo);
        if PropInfo.PropType^ = TypeInfo(System.Boolean) then
          Result := Lowercase(Result);
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
      ;
    tkSet,
    tkMethod,

    tkArray,
    tkRecord,
    tkInterface,


    tkDynArray,
    tkVariant:
      raise ESOAPDomConvertError.CreateFmt(SUnexpectedDataType, [KindNameArray[(PropInfo.PropType)^.Kind]]);

  end;

end;

function TSOAPDomConv.GetTypeBySchemaNS(Node: IXMLNode; const URI: InvString): Variant;
var
  I: Integer;
begin
  Result := Node.GetAttributeNS(SSoapType, URI);
  if VarIsNull(Result) and (soTryAllSchema in Options) then
  begin
    for I := Low(XMLSchemaInstNamepspaces) to High(XMLSchemaInstNamepspaces) do
    begin
      Result := Node.GetAttributeNS(SSoapType, XMLSchemaInstNamepspaces[I]);
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
  if (Node.NamespaceURI = SSoap11EncodingS5) and
     (ExtractLocalName(Node.NodeName) = SSoapEncodingArray) then
  begin
    TypeURI := SSoap11EncodingS5;
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
        TypeURI := '';
      end;
      Result := True;
    end;
  end
end;

procedure TSOAPDomConv.SetObjectPropFromText(Instance: TObject; PropInfo: PPropInfo; const SoapData: WideString);
var
 I: LongInt;
 E: Extended;
 I64: Int64;
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
    tkWString:
      SetWideStrProp(Instance, PropInfo, SoapData);
    tkString,
    tkLString:
       SetStrProp(Instance, PropInfo, SoapData);

    tkInt64:
      begin
        I64 := StrToInt64(SoapData);
        SetInt64Prop(Instance, PropInfo, I64);
      end;
    tkEnumeration:
      SetEnumPropEx(Instance, PropInfo, SoapData);
    tkChar,
    tkWChar:
      if SoapData <> '' then
        SetOrdProp(Instance, PropInfo, Integer(SoapData[1]));
    tkClass:
      ;
    tkSet,
    tkMethod,
    tkArray,
    tkRecord,
    tkInterface,
    tkDynArray,
    tkVariant:
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

procedure TSOAPDomConv.UnhandledNode(const Name: string; NodeXML: WideString);
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
  ChildNode: IXMLNode;

  function FindPropNodeIndex(const Node: IXMLNode; const PropName: WideString): Integer;
  var
    Index: Integer;
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

var
  PropList: PPropList;
  Count, NodeCount: Integer;
  Kind: TTypeKind;
  I, K: Integer;
  Obj: TObject;
  IsNull: Boolean;
  URI, TypeName: InvString;
  ArrayPtr: Pointer;
  V: Variant;
  SoapTypeInfo: PTypeInfo;
  ExternalPropName: WideString;
  SerialOpts: TSerializationOptions;
  ID: InvString;
  HolderNode, AttrNode: IXMLNode;
  SimpleHolder, IsAttribute: Boolean;
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
          Kind := (PropList[I].PropType)^.Kind;
          IsAttribute := not IsStoredPropConst(nil, PropList[I])
                         and (Kind <> tkClass)
                         and (Kind <> tkDynArray)
                         and (Kind <> tkVariant);
          ExternalPropName := RemTypeRegistry.GetExternalPropName(Instance.ClassInfo, PropList[I].Name);

          { Is the property coming down as an attribute }
          if IsAttribute then
          begin
            { Get the potential attribute Node }
            if SimpleHolder then
              AttrNode := HolderNode
            else
              AttrNode := Node;

            if AttrNode.HasAttribute(ExternalPropName) then
              SetObjectPropFromText(Instance, PropList[I], AttrNode.Attributes[ExternalPropName])
            else
              { Here something we were expecting did *NOT* come down the wire ?? }
              ObjectMemberNoShow(Instance.ClassName, PropList[I].Name);
            continue;
          end
          else
          begin
            if not SimpleHolder then
              K := FindPropNodeIndex(Node, ExternalPropName)
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
              if Kind = tkClass then
              begin
                Obj := ConvertSOAPToObject(RootNode, ChildNode, GetTypeData((PropList[I].PropType)^).ClassType,
                  '', '', nil, 0);
                if Obj <> nil then
                  SetObjectProp(Instance, PropList[I], Obj);
              end else if Kind = tkDynArray then
              begin
                IsNull := NodeIsNull(ChildNode);
                { In document mode, the node could have attributes that we want to retrieve }
                if (not IsNull) or (soDocument in Options) then
                begin
                  GetElementType(ChildNode, URI, TypeName);
                  ArrayPtr := nil;
                  { Here if the object we're writing to inlines members, then here we pass a parent node }
                  if (xoinlineArrays in SerialOpts) then
                    ChildNode := ChildNode.ParentNode;
                  ArrayPtr := ConvertSoapToNativeArray(@ArrayPtr, (PropList[I].PropType)^,
                                                       RootNode,  ChildNode);
                  SetOrdPropEx(Instance, PropList[I], Integer(ArrayPtr));
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
                      SoapTypeInfo := TypeInfo(System.WideString);
                    if IsXMLDateTimeTypeInfo(SoapTypeInfo)
                      {(SoapTypeInfo.Kind = tkClass) and (GetTypeData(SoapTypeInfo).ClassType = TXSDateTime)} then
                    begin
                      V := XMLTimeToDateTime(ChildNode.Text);
                    end else
                      V := TypeTranslator.CastSoapToVariant(SoapTypeInfo, ChildNode.Text);
                  end;
                end;
                SetVariantProp(Instance, PropList[I], V);
              end else
              begin
                { Some SOAP implementations use multiref nodes even for simple types }
                ChildNode := GetDataNode(RootNode, ChildNode, ID);
                SetObjectPropFromText(Instance, PropList[I], GetNodeAsText(ChildNode));
              end;
            end else
            begin
              ObjectMemberNoShow(Instance.ClassName, PropList[I].Name);
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
  const URI, TypeName: WideString; ObjP: Pointer; NumIndirect: Integer): TObject;
var
  ID: InvString;
  ObjNode: IXMLNode;
  IsScalar: Boolean;
  Obj, LoadedObj: TObject;
  P: Pointer;
  I: Integer;
  NodeClass: TClass;
  NodeURI, NodeTypeName: InvString;
  LegalRef: Boolean;
  S: string;
begin
  if NodeIsNULL(Node) then
  begin
    Result := nil;
    { NOTE: In document mode a node could contain attributes that we want to retrieve }
    { TODO: Clean up this logic - not good enough for cases where we don't have attrs }
    if (Node = nil) or not (soDocument in Options) then
      Exit;
  end;

  P := ObjP;
  for I := 0 to NumIndirect - 1 do
    P := Pointer(PInteger(P)^);
  Obj := TObject(P);

  S := ExtractLocalName(Node.NodeName);
  ObjNode := GetDataNode(RootNode, Node, ID);
  if (ID <> '') and (not AClass.InheritsFrom(TSOAPAttachment)) then
    LoadedObj :=  FindMultiRefNodeByID(ID)
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
    if Assigned(Obj) and  LegalRef then
    begin
      if (NodeClass <> nil) and (NodeClass <> Obj.ClassType) then
        Obj := NodeClass.Create;
    end else
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

procedure TSOAPDomConv.ConvertByteArrayToSoap(RootNode, Node: IXMLNode; const Name: InvString;
                                              Info: PTypeInfo; P: Pointer);
var
  S, S1: String;
begin
  SetLength(S, GetDynArrayLength(P));
  Move(P^, S[1], Length(S));
  S1 :=  EncodeString(S);
  CreateScalarNodeXS(RootNode, Node, Name, XMLSchemaNamespace, 'base64Binary', S1); { do not localize }
end;

procedure TSOAPDomConv.ConvertNativeArrayToSoap(RootNode, Node: IXMLNode;
    const Name: InvString; Info: PTypeInfo; P: Pointer; NumIndirect: Integer; InlineElements: Boolean);
var
  Dims, I: Integer;
  DimAr: TIntegerDynArray;
  URI, TypeName: InvString;
  ElemNode: IXMLNode;
  ElemInfo: PTypeInfo;
  UseNonRect: Boolean;
begin
  for I := 0 to NumIndirect - 1 do
    P := Pointer(PInteger(P)^);

  { Retrieve dimensions and most-underlying element }
  Dims := 0;
  GetDynArrayElTypeInfo(Info, ElemInfo, Dims);
  { Make sure we have RTTI for element }
  if not RemTypeRegistry.TypeInfoToXSD(ElemInfo, URI, TypeName) then
    raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [ElemInfo.Name]);

  { Rectangular vs. Non-rectangular writers?? }
  UseNonRect := Assigned(P) and ((IsArrayRect(P, Dims)=False) or
                                 ((soDocument in Options) and (Dims > 1)) or
                                 ByteArrayInfo(ElemInfo) or
                                 (soSendUntyped in Options)
                                 );
  if not UseNonRect then
  begin
    SetLength(DimAr, Dims);
    if Assigned(P) then
      GetDims(P, DimAr, Dims);
    GetDynArrayElTypeInfo(Info, ElemInfo, Dims);
    { Array of bytes is handled separately - serialized as base64 }
    if (Dims = 1) and ByteArrayInfo(ElemInfo) then
    begin
      ConvertByteArrayToSoap(RootNode, Node, Name, Info, P);
    end else
    begin
      if not InlineElements then
      begin
        ElemNode := MakeArrayNode(RootNode, Node,  Name, URI, TypeName, DimAr);
      end
      else
      begin
        { Here we're inlining the array members }
        ElemNode := Node;
        { The array elements get the typename }
        TypeName := Name;
      end;
      WriteRectDynArray(RootNode, ElemNode, ElemInfo, Dims, P, TypeName);
      { Not exactly optimal approach - but works for now -
        Check if user does not want to send empty nodes and snip
        this node if it has no child nodes - another approach would
        be not to parent the array node and wait until we know but... ?? }
      if (soDontSendEmptyNodes in Options) and
         (ElemNode.ChildNodes.Count < 1) then
      begin
        Node.ChildNodes.Delete(Node.ChildNodes.IndexOf(ElemNode));
      end;
    end;
  end else
  begin
    WriteNonRectDynArray(RootNode, Node, Name, Info, URI, TypeName, P, Dims);
    { NOTE: For now I'm not putting the snip empty node code in non rectangular
            arrays as there has not been a need for this here yet }
  end;
end;


procedure TSOAPDomConv.ConvertNativeDataToSoap(RootNode, Node: IXMLNode;
                const Name: InvString; Info: PTypeInfo; P: Pointer; NumIndirect: Integer);
var
  ElemNode: IXMLNode;
  TypeName: InvString;
  URI, S: InvString;
  IsNull: Boolean;
  I: Integer;
  IsScalar: Boolean;
begin
  case Info.Kind of
    tkClass:
      ConvertObjectToSOAP(Name, P, RootNode, Node, NumIndirect);
    tkDynArray:
      ConvertNativeArrayToSoap(RootNode, Node, Name, Info, P, NumIndirect);
    tkSet,
    tkMethod,
    tkArray,
    tkRecord,
    tkInterface:
      raise ESOAPDomConvertError.CreateFmt(SDataTypeNotSupported, [KindNameArray[Info.Kind]]);

    tkVariant:
    begin
      ConvertVariantToSoap(RootNode, Node, Name, Info, P, NumIndirect, NULL, False);
    end;
    else
    begin
      if Info.Kind = tkEnumeration then
      begin
        if not RemClassRegistry.InfoToURI(Info, URI, TypeName, IsScalar) then
          raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [Info.Name]);
        S := ConvertEnumToSoap(Info, P, NumIndirect);
        ElemNode := CreateScalarNodeXS(RootNode, Node, Name, URI, TypeName, S);
      end else
      begin
        if NumIndirect > 1 then
          for I := 0 to NumIndirect - 2 do
            P := Pointer(PInteger(P)^);
        TypeTranslator.CastNativeToSoap(Info, S, P, IsNull);
        if IsNull then
          CreateNULLNode(RootNode,ElemNode, Name)
        else
        begin
          if not RemTypeRegistry.TypeInfoToXSD(Info, URI, TypeName) then
            raise ESOAPDomConvertError.CreateFmt(SRemTypeNotRegistered, [Info.Name]);
          ElemNode := CreateScalarNodeXS(RootNode, Node, Name, URI, TypeName, S);
        end;
      end
    end;
  end;
end;


procedure TSOAPDomConv.AddMultiRefNode(const ID: string; Instance: Pointer);
var
  I: Integer;
begin
  for I := 0 to Length(RefMap) -1  do
    if (RefMap[I].ID = ID) and ( RefMap[I].Instance = Instance) then
      Exit;
  I := Length(RefMap);
  SetLength(RefMap, I + 1);
  RefMap[I].ID := ID;
  RefMap[I].Instance :=Instance;
end;

function  TSOAPDomConv.FindMultiRefNodeByInstance(Instance: Pointer): string;
var
  I: Integer;
begin
  for I := 0 to Length(RefMap) - 1 do
    if RefMap[I].Instance = Instance then
      Result := RefMap[I].ID;
end;


function  TSOAPDomConv.FindMultiRefNodeByID(const ID: string): Pointer;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Length(RefMap) - 1 do
    if RefMap[I].ID = ID then
    begin
      Result := RefMap[I].Instance;
      break;
    end;
end;


procedure TSOAPDomConv.ConvertSoapToNativeData(DataP: Pointer; TypeInfo: PTypeInfo;
  Context: TDataContext; RootNode, Node: IXMLNode; Translate, ByRef: Boolean;
  NumIndirect: Integer);
var
  TypeUri, TypeName: InvString;
  IsNull: Boolean;
  Obj: TObject;
  P: Pointer;
  I: Integer;
  ID: InvString;
begin
  Node := GetDataNode(RootNode, Node, ID);
  IsNull := NodeIsNull(Node);
  if TypeInfo.Kind = tkVariant then
  begin
    if NumIndirect > 1 then
      DataP := Pointer(PInteger(DataP)^);
    if IsNull then
    begin
      Variant(PVarData(DataP)^) := NULL;
    end else
      ConvertSoapToVariant(Node, DataP);
  end else
  if TypeInfo.Kind = tkDynArray then
  begin
    P := DataP;
    for I := 0 to NumIndirect - 2 do
      P := Pointer(PInteger(P)^);
    P := ConvertSoapToNativeArray(P, TypeInfo, RootNode, Node);
    if NumIndirect = 1 then
      PInteger(DataP)^ := Integer(P)
    else if NumIndirect = 2 then
    begin
      DataP := Pointer(PInteger(DataP)^);
      PInteger(DataP)^ := Integer(P);
    end;
  end else
  if TypeInfo.Kind = tkClass then
  begin
    Obj := ConvertSOAPToObject(RootNode, Node, GetTypeData(TypeInfo).ClassType, TypeURI, TypeName, DataP, NumIndirect);
    if NumIndirect = 1 then
      PTObject(DataP)^ := Obj
    else if NumIndirect = 2 then
    begin
      DataP := Pointer(PInteger(DataP)^);
      PTObject(DataP)^ := Obj;
    end;
  end else
  begin
    if Translate then
    begin
      if NumIndirect > 1 then
        DataP := Pointer(PInteger(DataP)^);
      if not TypeTranslator.CastSoapToNative(TypeInfo, GetNodeAsText(Node), DataP, IsNull) then
        raise ESOAPDomConvertError.CreateFmt(STypeMismatchInParam, [node.nodeName]);
    end;
  end;
end;


function TSOAPDomConv.ConvertEnumToSoap(Info: PTypeInfo;
  P: Pointer; NumIndirect: Integer): InvString;
var
  Value: Pointer;
  I: Integer;
begin
  Value := P;
  for I := 0 to NumIndirect - 2 do
    Value := Pointer(PInteger(Value)^);
  if NumIndirect = 0 then
    Result := GetEnumName(Info, Byte(Value))
  else
    Result := GetEnumName(Info, PByte(Value)^);
  { NOTE: No need to use SameTypeInfo here since C++ has proper case }
  if Info = TypeInfo(System.Boolean) then
    Result := Lowercase(Result);
end;


function TSOAPDomConv.ConvertSoapToEnum(Info: PTypeInfo; S: InvString;
  IsNull: Boolean): Integer;
begin
  Result := GetEnumValueEx(Info, S);
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
  if Node = nil then
  begin
    Result := True;
    Exit;
  end;
  
  Result := False;
  V := Node.GetAttributeNS(SSoapNull, XMLSchemaInstNameSpace);
  if VarIsNull(V) then
    V := Node.GetAttributeNS(SSoapNIL, XMLSchemaInstNamespace);
  if not VarIsNull(V) and ((V = '1') or SameText(V, STrue)) then   { do not localize }
    Result := True;
  if Node.ChildNodes.Count = 0 then
  begin
    V := Node.Attributes[SXMLHREF];
    if  VarIsNull(V) then
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

function TSOAPDomConv.FindPrefixForURI(RootNode, Node: IXMLNode; const URI: InvString; DeclIfNone: Boolean = False): InvString;
var
  DeclNode: IXMLNode;
begin
  DeclNode := RootNode.FindNamespaceDecl(URI);
  if DeclNode <> nil then
    Result := ExtractLocalName(DeclNode.NodeName);
  if (Result = '') and DeclIfNone then
    Result := AddNamespaceDecl(RootNode, URI);
end;

function TSOAPDomConv.AddNamespaceDecl(Node: IXMLNode; const URI: InvString): InvString;
begin
  Result := Node.OwnerDocument.GeneratePrefix(Node);
  Node.DeclareNamespace(Result, URI);
end;

function TSOAPDomConv.CreateTypedNode(RootNode, ParentNode: IXMLNode;
   const NodeName, URI: WideString; TypeName: WideString; GenPre: Boolean = False): IXMLNode;
begin
  if GenPre then
    Result := ParentNode.AddChild(NodeName, URI, True)
  else
  begin
    { Send no namespace for nested nodes }
    if (soDocument in Options) then
      Result := ParentNode.AddChild(NodeName)
    else
      Result := ParentNode.AddChild(NodeName, '');
  end;

  SetNodeType(RootNode, Result, URI, TypeName);
end;

function TSOAPDomConv.CreateScalarNodeXS(RootNode, ParentNode: IXMLNode;
   const NodeName, URI, TypeName: WideString; const Value: WideString; GenPre: Boolean = False): IXMLNode;
begin
  Result := CreateTypedNode(RootNode, ParentNode, NodeName, URI, TypeName);
  Result.Text := Value;
end;

procedure TSOAPDomConv.SetNodeType(RootNode, InstNode: IXMLNode; const ElemURI,
  TypeName: InvString);
var
  Pre: InvString;
begin
  if not (soSendUntyped in Options) and not (soDocument in Options) then
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
  V := Node.Attributes[SXMLHREF];
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
        ID := Copy(REF, 2, High(Integer));
      end;
    end;
  end else
  begin
    V := Node.Attributes[SXMLID];
    if not VarIsNull(V) then
      ID := V;
  end;
end;

procedure TSOAPDomConv.CheckEncodingStyle(Node: IXMLNode);
var
  V: Variant;
begin
  V := Node.GetAttributeNS(SSoapEncodingAttr, SSoapNameSpace);
  if not VarIsNull(V) then
  begin
    if V <> SSoap11EncodingS5 then
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
  SetLength(RefMap, 0);
  SetLength(ObjsWriting, 0);
end;

end.
