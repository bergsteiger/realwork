{*******************************************************}
{                                                       }
{ Borland Delphi Visual Component Library               }
{       SOAP           Support                          }
{                                                       }
{ Copyright (c) 2001 Borland Software Corporation       }
{                                                       }
{*******************************************************}
{
  Central registry for interfaces with RTTI and the classes that implement them.
  Classes that are used as parameter types in methods of interfaces are registered
  in a separate registry.
}
unit InvokeRegistry;

{$IFDEF NO_SOAP_RUNTIME}
{ If SOAP components are not packaged }
(*$HPPEMIT '#pragma link "dclsoap.lib"' *)
{$ENDIF}

{$IFDEF MSWINDOWS}
{ SOAP/Windows is currently implemented with WININET }
(*$HPPEMIT '#if defined(__WIN32__)'     *)
(*$HPPEMIT '#pragma link "wininet.lib"' *)
(*$HPPEMIT '#endif'                     *)
{$ENDIF}

interface

uses SysUtils, TypInfo, IntfInfo, Classes, Contnrs, {$IFDEF MSWINDOWS}Windows{$ENDIF}
  {$IFDEF LINUX}Libc{$ENDIF}, XMLSchema, XmlIntf, Types;

type

  InvString = WideString;

  TDataContext = class;

  ObjectConvertOptions = (ocoDontPrefixNode,
                          ocoDontSerializeProps,
                          ocoDontPutTypeAttr);
  TObjectConvertOptions= set of ObjectConvertOptions;

  TSOAPAttachment = class;

  IObjConverter = interface
  ['{7F67EA52-A3D1-429B-B54D-49F692B6131A}']
    function  ObjInstanceToSOAP(Instance: TObject; RootNode, ParentNode: IXMLNode;
                                const NodeName, NodeNamespace: InvString; ObjConvOpts: TObjectConvertOptions;
                                out RefID: InvString): IXMLNode;
    procedure InitObjectFromSOAP(Instance: TObject; RootNode, Node: IXMLNode);
    procedure AddAttachment(Attachment: TSOAPAttachment; const AContentId: string);
    function  FindAttachment(const AContentId: string): TSOAPAttachment;
  end;

  { ======================================================================================
    Serialization options apply to remotable classes - i.e. type derived from TRemotable.
    Usually these types simply represent an XML <complextype> with zero or more elements;
    however, the are times when they are really shells for another type.
    For example, if a schema describes a type that returns an array with 'truncated'
    attribute describing whether the data was truncated, you'll need a 'TRemotable-derived'
    type to properly deserialize the data. However, in such a case, the
    'TRemotable-derived' type is really just a shell to house the array and the
    attribute fields. The 'TRemotable-derived' type is not involved in the
    [de]serialization process. It's stealth!

    Serialization options can either be registered for a particular ClassType. Or it can
    be set by an instance of a class itself via TRemotable's FSerializationOptions member.

    NOTE: Currently Serialization options are only for Client usage. i.e. They are used by
    the WSDL importer when creating types from a WSDL. Servers should *NOT* register any
    types with these options as the WSDL publishing logic will ignore all serialization
    options. IOW, these flags are here to adapt the language binding to constructs that don't
    easily map to a native type - like the example of an array with an attribute. Servers,
    don't need to resort to any of these flags since all of a server's needs can be
    mapped to SOAP without use of holder classes.
    ====================================================================================== }
  SerializationOptions  = (xoHolderClass, xoAttributeOnLastMember, xoInlineArrays, xoLiteralParam,
                           xoSimpleTypeWrapper, xoOption6, xoOption7, xoOption8, xoOption9, xoOptionA,
                           xoOptionB, xoOptionC, xoOptionD, xoOptionE, xoOptionF, xoOptionG,
                           xoOptionH, xoOptionI);
  TSerializationOptions = set of SerializationOptions;

  { TRemotable is the base class for remoting complex types - it introduces a virtual
    constructor (to allow the SOAP runtime to properly create the object and derived
    types) and it provides life-time management - via DataContext - so the SOAP
    runtime can properly disposed of complex types received by a Service }
{$M+}
  TRemotable = class
  private
    FDataContext: TDataContext;
    procedure SetDataContext(Value: TDataContext);
  protected
    FSerializationOptions: TSerializationOptions;
  public
    constructor Create; virtual;
    destructor  Destroy; override;

    { Serialization routines }
    function   ObjectToSOAP(RootNode, ParentNode: IXMLNode;
                            const ObjConverter: IObjConverter;
                            const Name, URI: InvString; ObjConvOpts: TObjectConvertOptions;
                            out RefID: InvString): IXMLNode; virtual;
    procedure  SOAPToObject(const RootNode, Node: IXMLNode; const ObjConverter: IObjConverter); virtual;

    property   DataContext: TDataContext read FDataContext write SetDataContext;
    property   SerializationOptions: TSerializationOptions read FSerializationOptions;
  end;
{$M-}

  { TRemotableXS represents Scalar types that are implement via a TRemotable-derived
    type }
  TRemotableXS = class(TRemotable)
  public
    function  NativeToXS: WideString; virtual; abstract;
    procedure XSToNative(Data: WideString); virtual; abstract;
    function  ObjectToSOAP(RootNode, ParentNode: IXMLNode;
                           const ObjConverter: IObjConverter;
                           const Name, URI: InvString; ObjConvOpts: TObjectConvertOptions;
                           out RefID: InvString): IXMLNode; override;
    procedure SOAPToObject(const RootNode, Node: IXMLNode; const ObjConverter: IObjConverter); override;
  end;

  PTRemotable = ^TRemotable;
  TRemotableClass = class of TRemotable;
  TRemotableXSClass = class of TRemotableXS;

  { TSOAPHeader is the base class for SOAP Headers - it introduces the ability to
    handle Header-specific attributes such as 'Must-Understand' and 'Actor' }
  TSOAPHeader = class(TRemotable)
  private
    FMustUnderstand: Boolean;
    FActor: WideString;
  public
    { Serialization routines }
    function   ObjectToSOAP(RootNode, ParentNode: IXMLNode;
                            const ObjConverter: IObjConverter;
                            const Name, URI: InvString; ObjConvOpts: TObjectConvertOptions;
                            out RefID: InvString): IXMLNode; override;
    procedure  SOAPToObject(const RootNode, Node: IXMLNode; const ObjConverter: IObjConverter); override;

    property MustUnderstand: Boolean read FMustUnderstand write FMustUnderstand;
    property Actor: WideString read FActor write FActor;
  end;
  TSOAPHeaderClass = class of TSOAPHeader;

{$M+}
  { ERemotableException is the base class for handling fault packets with
    information in the <detail> nodes. It's also the base exception thrown
    when no suitable (registered) ERemotableException-derived class is found
    for a particular fault or when there is no <detail> node sent. }
  ERemotableException = class(Exception)
  private
    FFaultActor: WideString;
    FFaultCode: WideString;
    FFaultDetail: WideString;
  public
    constructor Create; overload;  virtual;
    constructor Create(const Msg: string;
                       const AFaultCode: WideString = '';
                       const AFaultActor: WideString = '');overload;  virtual;
    property FaultActor:  WideString read FFaultActor write FFaultActor;
    property FaultCode:   WideString read FFaultCode  write FFaultCode;
    property FaultDetail: WideString read FFaultDetail write FFaultDetail;
  end;
{$M-}

  ERemotableExceptionClass = class of ERemotableException;

{ sender can specify FileName or TStream as source }
  TSOAPAttachment = class(TRemotable)
  private
    FCacheFile: string;            { used by attachment receiver to store data }
    FCacheFilePersist: Boolean;    { if true, don't delete cacehfile on close }
    FContentType: string;
    FEncoding: WideString;
    FFileName: string;      { used by attachment sender to specify source of data }
    FSourceStream: TStream; { used by attachment sender to specify stream source of data }
    FSourceString: string;
    FHeaders: TStrings;
    FStreamOwnership: TStreamOwnership;
    procedure ClearStream;
  protected
    function GetSourceStream: TStream; virtual;
    procedure InternalSetCacheFile(const Value: string); virtual;
    procedure InternalSetSourceStream(const Value: TStream; const Ownership: TStreamOwnership = soReference);
    procedure SetSourceString(const Value: string); virtual;
    procedure SetOwnership(const Value: TStreamOwnership); virtual;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Init(ATempLocation: string; AHeaders: TStrings; AContentType: String;
                   AEncoding: WideString);

    { Serialization routines - Handle MIME Part I/O }
    function   ObjectToSOAP(RootNode, ParentNode: IXMLNode;
                            const ObjConverter: IObjConverter;
                            const Name, URI: InvString; ObjConvOpts: TObjectConvertOptions;
                            out RefID: InvString): IXMLNode; override;
    procedure  SOAPToObject(const RootNode, Node: IXMLNode; const ObjConverter: IObjConverter); override;

    property CacheFile: string read FCacheFile;
    property CacheFilePersist: Boolean read FCacheFilePersist write FCacheFilePersist default False;
    property ContentType: string read FContentType write FContentType;
    property Encoding: WideString read FEncoding write FEncoding;
    property Headers: TStrings read FHeaders;
    property Ownership: TStreamOwnership read FStreamOwnerShip write FStreamOwnerShip;
    property SourceStream: TStream read GetSourceStream;
    property SourceString: string read FSourceString write SetSourceString;

    procedure SaveToStream(AStream: TStream);
    procedure SaveToFile(AFileName: string);
    procedure SetSourceFile(const Value: string); virtual;
    procedure SetSourceStream(const Value: TStream; const Ownership: TStreamOwnership = soReference); virtual;
  end;

  TSOAPAttachmentClass = class of TSOAPAttachment;

  THeaderList = class
  private
    FObjectList: TObjectList;
  protected
    function    GetOwnsObjects: Boolean;
    procedure   SetOwnsObjects(Val: Boolean);
    function    GetCount: Integer;
    function    GetHeader(Index: Integer): TObject;
  public
    constructor Create;
    destructor  Destroy; override;

    procedure Add(Header: TSOAPHeader); overload;
    procedure Add(Header: TObject); overload;
    procedure Clear;
    function  Extract(Obj: TObject): TObject;
    function  IndexOf(Obj: TObject): Integer;
    property  Count: Integer read GetCount;
    property  OwnsObjects: Boolean read GetOwnsObjects write SetOwnsObjects;
    property  Headers[Index: Integer]: TObject read GetHeader; default;
  end;

  { Internal interface used by framework to allow ISOAPHeaders to work
    on either Client/RIO or Server/Invoker Headers }
  IHeadersSetter = interface
  ['{FC96447A-94AC-4C88-B724-192284E2DA34}']
    procedure SetHeadersInOut(var InHdrs, OutHdrs: THeaderList);
  end;

  { Client and Server side interface to send and process headers
    received }
  ISOAPHeaders = interface
  ['{E240BE0C-256F-D611-96FA-00C04FA06B45}']
    { Send this header to Service or send this header back to a Client }
    procedure Send(const Hdr: TSOAPHeader);

    { Query list of headers to be sent }
    function  SendCount: Integer;
    function  SendAt(Index: Integer): TSOAPHeader;

    { Retrieve a header sent by a a Client or returned by a Service }
    { NOTE: You have ownership of the header once you retrieve it   }
    procedure Get(Cls: TClass; out Hdr: TSOAPHeader); overload;
    function  Get(Cls: TClass): TSOAPHeader; overload;
    function  Get(const Name, URI: WideString): TSOAPHeader; overload;

    { Outbound header ownership - NOTE: We always own inbound ones until
      you retrieve them; also, ownership on the Server side is handled
      by TRemotable's DataContext!!}
    function  GetOwnsSentHeaders: Boolean;
    procedure SetOwnsSentHeaders(Flag: Boolean);

    property OwnsSentHeaders: Boolean read GetOwnsSentHeaders write SetOwnsSentHeaders;
  end;

  TSOAPHeadersBase = class(TContainedObject, IHeadersSetter)
  protected
    FHeadersInbound: THeaderList;
    FHeadersOutBound: THeaderList;
    procedure SetHeadersInOut(var InHdrs, OutHdrs: THeaderList);
  end;

  TSOAPHeaders = class(TSOAPHeadersBase, ISOAPHeaders, IHeadersSetter)
  public
    procedure Send(const Hdr: TSOAPHeader);

    { Query list of headers to be sent }
    function  SendCount: Integer;
    function  SendAt(Index: Integer): TSOAPHeader;

    { Retrieve a header sent by a a Client or returned by a Service }
    { NOTE: You have ownership of the header once you retrieve it   }
    procedure Get(Cls: TClass; out Hdr: TSOAPHeader); overload;
    function  Get(Cls: TClass): TSOAPHeader; overload;
    function  Get(const Name, URI: WideString): TSOAPHeader; overload;

    function  GetOwnsSentHeaders: Boolean;
    procedure SetOwnsSentHeaders(Flag: Boolean);
  end;

  TInvokableClass = class(TObject, IInterface)
  protected
    FSOAPHeaders: TSOAPHeaders;
    FRefCount: Integer;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    constructor Create; virtual;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    property RefCount: Integer read FRefCount;
  end;
  TInvokableClassClass = class of TInvokableClass;


  { Used when registering a class factory  - Specify a factory callback
    if you need to control the lifetime of the object - otherwise SOAP
    will create the implementation class using the virtual constructor }
  TCreateInstanceProc = procedure(out obj: TObject);

  InvRegClassEntry = record
    ClassType: TClass;
    Proc: TCreateInstanceProc;
    URI: string;
  end;

  ExtNameMapItem = record
    Name: string;
    ExtName: WideString;
  end;

  MethParamNameMapItem = record
    MethName: string;
    ParamNameMap: array of ExtNameMapItem;
  end;

  eHeaderMethodType = (hmtAll, hmtRequest, hmtResponse);

  THeaderMethodTypeArray = array of eHeaderMethodType;

  TRequiredArray = array of Boolean;

  IntfHeaderItem = record
    Info: PTypeInfo;
    ClassType: TClass;
    Namespace: WideString;                  { Header namespace }
    Name: WideString;                       { Header name }
    DefaultMethodType: eHeaderMethodType;   { used if MethodNames = '' }
    DefaultRequired: Boolean;               { used if MethodNames = '' }
    MethodNames: string;                    { comma-delimited list of Method Names }
    MethodTypes: THeaderMethodTypeArray;    { matching array of in/out/inout enums }
    HeaderRequired: TRequiredArray;         { matching array of Required Booleans }
  end;

  THeaderItemArray = array of IntfHeaderItem;

  IntfExceptionItem = record
    ClassType: TClass;
    MethodNames: string;
  end;

  TExceptionItemArray = array of IntfExceptionItem;

  { Options that control invocation & specify items found when
    a porttype was imported }
  TIntfInvokeOption = (ioDefault,               { Nothing special }
                       ioDocument,              { We're passing documents - don't use Sect-5 Encoding }
                       ioLiteral,               { We have literal params - skip method node }
                       ioHasDefaultSOAPAction,  { We have a default SOAP Action }
                       ioHasReturnParamNames,   { We have specific return parameter names }
                       ioHasNamespace,          { We have a namespace }
                       ioIsAppServerSOAP,       { The interface derives from IAppServerSOAP }
                       ioHasUDDIInfo,           { We have UDDI info, for fail-over lookup }
                       ioHasAllSOAPActions      { Have all operation SOAPActions }
                      );
  TIntfInvokeOptions= set of TIntfInvokeOption;

  InvRegIntfEntry = record
    Name: string;                             { Native name of interface    }
    ExtName: Widestring;                      { PortTypeName                }
    UnitName: string;                         { Filename of interface       }
    GUID: TGUID;                              { GUID of interface           }
    Info: PTypeInfo;                          { Typeinfo of interface       }
    DefImpl: TClass;                          { Metaclass of implementation }
    Namespace: Widestring;                    { XML Namespace of type       }
    WSDLEncoding: WideString;                 { Encoding                    }
    Documentation: string;                    { Description of interface    }
    SOAPAction: string;                       { SOAPAction of interface     }
    ReturnParamNames: string;                 { Return Parameter names      }
    InvokeOptions: TIntfInvokeOptions;        { Invoke Options              }
    MethNameMap: array of ExtNameMapItem;             { Renamed methods     }
    MethParamNameMap: array of MethParamNameMapItem;  { Renamed parameters  }
    IntfHeaders: array of IntfHeaderItem;      { Headers                    }
    IntfExceptions: array of IntfExceptionItem;{ Exceptions                 }
    UDDIOperator: String;                      { UDDI Registry of this porttype }
    UDDIBindingKey: String;                    { UDDI Binding key           }
  end;
  TInvRegIntfEntryArray = array of InvRegIntfEntry;

  TInvokableClassRegistry = class(TInterfacedObject)
  private
    FLock: TRTLCriticalSection;
    FRegClasses: array of InvRegClassEntry;
    FRegIntfs: array of InvRegIntfEntry;
    procedure DeleteFromReg(AClass: TClass; Info: PTypeInfo);
    procedure InternalRegisterHeaderClass(Info: PTypeInfo; AClass: TClass;
              const HeaderName: WideString; const HeaderNamespace: WideString;
              DefaultMethodType: eHeaderMethodType; const MethodName: string = '';
              MethodType: eHeaderMethodType = hmtAll; Required: Boolean = False);
    procedure InternalRegisterException(Info: PTypeInfo; AClass: TClass; const MethodName: string);
    function  InternalGetHeaderName(const Item: IntfHeaderItem): WideString;
    function  InternalGetHeaderNamespace(const Item: IntfHeaderItem): WideString;
  public
    constructor Create;
    destructor Destroy; override;

    { Basic Invokable Interface Registration Routine }
    procedure RegisterInterface(Info: PTypeInfo; const Namespace: InvString = ''; const WSDLEncoding: InvString = ''; const Doc: string = ''; const ExtName: InvString = '');

    {
    procedure RegisterInterface(Info: PTypeInfo; const Namespace: InvString; const WSDLEncoding: InvString; const Doc: string); overload;
    procedure RegisterInterface(Info: PTypeInfo; const Namespace: InvString; const WSDLEncoding: InvString); overload;
    procedure RegisterInterface(Info: PTypeInfo; const Namespace: InvString); overload;
    procedure RegisterInterface(Info: PTypeInfo); overload;
    }

    { Header registration }
    procedure RegisterHeaderClass(Info: PTypeInfo; AClass: TClass;
              const HeaderName: WideString; const HeaderNamespace: WideString;
              DefaultMethodType: eHeaderMethodType = hmtAll;
              Required: Boolean = False); overload;
    procedure RegisterHeaderClass(Info: PTypeInfo; AClass: TClass;
              DefaultMethodType: eHeaderMethodType = hmtAll;
              Required: Boolean = False); overload;


    { Limit Header application to specific methods }
    procedure RegisterHeaderMethod(Info: PTypeInfo; AClass: TClass;
              const MethodName: string; MethodType: eHeaderMethodType = hmtAll;
              Required: Boolean = False); overload;

    { Header Access }
    function GetHeaderInfoForInterface(Info: PTypeInfo; MethodType: eHeaderMethodType = hmtAll): THeaderItemArray;
    function GetRequestHeaderInfoForInterface(Info: PTypeInfo): THeaderItemArray;
    function GetResponseHeaderInfoForInterface(Info: PTypeInfo): THeaderItemArray;
    function GetHeaderName(Info: PTypeInfo; AClass: TClass): WideString;
    function GetHeaderNamespace(Info: PTypeInfo; AClass: TClass): WideString; overload;
    function GetHeaderNamespace(AClass: TClass): WideString; overload;
    function GetHeaderClass(Name, Namespace: WideString): TClass;

    { Exception Class registration }
    procedure RegisterException(Info: PTypeInfo; AClass: TClass);
    procedure RegisterExceptionMethod(Info: PTypeInfo; AClass: TClass; const MethodName: string);

    { Exception Access }
    function  GetExceptionInfoForInterface(Info: PTypeInfo): TExceptionItemArray;

    procedure RegisterExternalMethName(Info: PTypeInfo; const InternalName: string; const ExternalName: InvString);
    procedure RegisterExternalParamName(Info: PTypeInfo; const MethodName, InternalName: string; const ExternalName: InvString);
    procedure RegisterInvokableClass(AClass: TClass; CreateProc: TCreateInstanceProc); overload;
    procedure RegisterInvokableClass(AClass: TClass); overload;

    { SOAPAction - related API }
    procedure RegisterDefaultSOAPAction(Info: PTypeInfo; const DefSOAPAction: InvString);
    procedure RegisterAllSOAPActions(Info: PTypeInfo; const AllSOAPActions: InvString);
    function  GetActionURIOfInfo(const IntfInfo: PTypeInfo; const MethodName: WideString; MethodIndex: Integer): string;
    function  GetActionURIOfIID(const AGUID: TGUID): string;

    { UDDI - related API }
    procedure RegisterUDDIInfo(Info: PTypeInfo; const Operator: String; const BindingKey: string);
    function  GetUDDIInfo(const IntfInfo: PTypeInfo; var Operator, BindingKey: string): Boolean; overload;
    function  GetUDDIInfo(const AGUID: TGUID; var Operator, BindingKey: string): Boolean; overload;

    procedure RegisterReturnParamNames(Info: PTypeInfo; const RetParamNames: string);
    function  GetReturnParamNames(const IntfInfo: PTypeInfo): string;

    procedure RegisterInvokeOptions(Info: PTypeInfo; const InvokeOption: TIntfInvokeOption); overload;
    procedure RegisterInvokeOptions(Info: PTypeInfo; const InvokeOptions: TIntfInvokeOptions); overload;

  private
    procedure Lock; virtual;
    procedure UnLock; virtual;
    function  GetIntfIndex(const IntfInfo: PTypeInfo): Integer;
  public
    function  GetNamespaceByGUID(const AGUID: TGUID): string;
    function  GetInfoForURI(const PathURI, ActionURI: string; var ACLass : TClass;  var IntfInfo: PTypeInfo; var AMeth: string): Boolean;
    function  GetIntfInvokeOptions(const IntfInfo: PTypeInfo): TIntfInvokeOptions; overload;
    function  GetIntfInvokeOptions(const AGUID: TGUID): TIntfInvokeOptions; overload;
    procedure GetInterfaceInfoFromName(const UnitName,  IntfName: string; var Info: PTypeInfo; var IID: TGUID);
    function  GetInterfaceTypeInfo(const AGUID: TGUID): Pointer;
    function  GetInvokableObjectFromClass(AClass: TClass): TObject;
    function  GetRegInterfaceEntry(Index: Integer): InvRegIntfEntry;
    function  HasRegInterfaceImpl(Index: Integer): Boolean;
    procedure GetClassFromIntfInfo(Info: PTypeInfo; var AClass: TClass);
    function  GetInterfaceCount: Integer;
    function  GetInterfaceExternalName(Info: PTypeInfo; const Namespace: string; const InternalIntfName: string): InvString; overload;
    function  GetInterfaceExternalName(Info: PTypeInfo; const Namespace: string): InvString; overload;
    function  GetInterfaceExternalName(Info: PTypeInfo): InvString; overload;
    function  GetWSDLEncoding(Info: PTypeInfo; const Namespace: string; const InternalIntfName: string): InvString; overload;
    function  GetWSDLEncoding(Info: PTypeInfo; const Namespace: string): InvString; overload;
    function  GetWSDLEncoding(Info: PTypeInfo): InvString; overload;
    procedure UnRegisterInterface(Info: PTypeInfo);
    procedure UnRegisterInvokableClass(AClass: TClass);
    function  GetParamExternalName(Info: PTypeInfo; const MethodName, InternalParamName: string): InvString;
    function  GetParamInternalName(Info: PTypeInfo; const MethodName: string; const ExternalParamName: InvString): string;
    function  GetMethExternalName(Info: PTypeInfo; const MethodIntName: string): InvString;
    function  GetMethInternalName(Info: PTypeInfo; const MethodExtName: InvString): string;
  end;

  { Classes used to register classes that map from pascal to/from XSD }
  TRemHeaderEntry = record
    Name: WideString;
    ExtName: WideString;
    URI: WideString;
  end;

  TObjMultiOptions = (ocDefault, ocMultiRef, ocNoMultiRef);
  TRemRegEntry = record
    ClassType: TClass;
    Info: PTypeInfo;
    URI: WideString;
    Name: WideString;
    ExtName: WideString;
    IsScalar: Boolean;
    MultiRefOpt: TObjMultiOptions;
    SerializationOpt: TSerializationOptions;
    PropNameMap: array of ExtNameMapItem;             { Renamed properties }
  end;

  TRemRegEntryArray = array of TRemRegEntry;

  ETypeRegistryException = class(Exception);

  TRemotableTypeRegistry = class
  private
    FAutoRegister: Boolean;
    FLock:    TRTLCriticalSection;
    URIMAP:   array of TRemRegEntry;
    function  GetEntry(Info: PTypeInfo; var Found: Boolean; const Name: WideString=''): Integer;
    function  FindEntry(Info: PTypeInfo; var Found: Boolean; const Name: WideString=''): Integer;
    procedure DeleteEntryFromURIMap(Info: PTypeInfo);
    function  GetSimpleBuiltInXSDType(const URI, TypeName: WideString): PTypeInfo;
    function  GetRegisteredClassForBuiltInXSD(const TypeName: WideString): TClass;
  protected
    procedure Lock; virtual;
    procedure UnLock; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    { Remotable class registration }
    procedure RegisterXSClass(AClass: TClass; const URI: WideString = ''; const Name: WideString = '';
                              const ExtName: WideString= ''; IsScalar: Boolean = False;
                              MultiRefOpt: TObjMultiOptions = ocDefault);
    { TypeInfo registration }
    procedure RegisterXSInfo(Info: PTypeInfo; const URI: WideString = ''; const Name: WideString = ''; const ExtName: WideString = '');

    { TypeInfo registration via a Holder class }
    procedure RegisterHolderClsMember(ClsTypeInfo: PTypeInfo; const URI: WideString = ''; const Name: WideString = ''; const ExtName: WideString = '');

    { Query routines to conver Native Type to XML name and namespace }
    function  ClassToURI(AClass: TClass; var URI, Name: WideString; var IsScalar: Boolean; tryToRegister: Boolean = True): Boolean; overload;
    function  ClassToURI(AClass: TClass; var URI, Name: WideString): Boolean; overload;
    function  InfoToURI(Info: PTypeInfo; var URI, Name: WideString; var IsScalar: Boolean; tryToRegister: Boolean = True): Boolean;
    function  TypeInfoToXSD(Info: PTypeInfo; var URI, TypeName: WideString): Boolean;
    procedure GetXSDInfoForClass(Info: PTypeInfo; var URI, TypeName: WideString);

    { Query routines to convert XML name/namespace to Native TypeInfo }
    function  URIToClass(const URI, Name: WideString; var IsScalar: Boolean): TClass; overload;
    function  URIToClass(const URI, Name: WideString): TClass; overload;
    function  XSDToTypeInfo(const URI, TypeName: WideString): PTypeInfo;
    function  URIToInfo(const URI, Name: WideString): PTypeInfo;

    { Query registry information }
    function  GetURICount: Integer;
    function  GetURIMap(Index: Integer): TRemRegEntry; overload;
    function  GetURIMap(Index: Integer; out RegEntry: TRemRegEntry): boolean; overload;

    { Class options }
    function  IsClassScalar(AClass: TClass): Boolean;
    function  ClassOptions(AClass: TClass): TObjMultiOptions;

    { Variant-related conversions }
    function  VariantToInfo(const V: Variant; TryAllSchema: Boolean): PTypeInfo;
    function  GetVarTypeFromXSD(const URI, TypeName: InvString): TVarType;

    { Serialization options }
    procedure RegisterSerializeOptions(Info: PTypeInfo; SerialOpt: TSerializationOptions); overload;
    function  SerializeOptions(Info: PTypeInfo): TSerializationOptions; overload;
    procedure RegisterSerializeOptions(AClass: TClass; SerialOpt: TSerializationOptions); overload;
    function  SerializeOptions(AClass: TClass): TSerializationOptions; overload;

    { Unregister API }
    procedure UnRegisterXSClass(AClass: TClass);
    procedure UnRegisterXSInfo(Info: PTypeInfo);

    { Name mappings: Internal <-> External }
    procedure RegisterExternalPropName(Info: PTypeInfo; const InternalName: string; const ExternalName: InvString);
    function  GetExternalPropName(Info: PTypeInfo; InternalName: string): InvString;
    function  GetInternalPropName(Info: PTypeInfo; ExternalName: InvString): string;

    { Flag to automatically register types }
    property AutoRegisterNativeTypes: Boolean read FAutoRegister write FAutoRegister;
  end;

  TRemotableClassRegistry       = TRemotableTypeRegistry;
  TPascalRemotableTypeRegistry  = TRemotableTypeRegistry;
  TPascalRemotableClassRegistry = TRemotableTypeRegistry;

{ Forward ref. structure to satisfy DynamicArray<Type>        }
{ encountered before declaration of Type itself in .HPP file  }
(*$HPPEMIT 'namespace Invokeregistry {'                      *)
(*$HPPEMIT 'struct TDynToClear;'                             *)
(*$HPPEMIT '};'                                              *)
(*$HPPEMIT 'using Invokeregistry::TDynToClear;'              *)

  TDynToClear = record
    P: Pointer;
    Info: PTypeInfo;
  end;

  TDataContext = class
  protected
    FObjsToDestroy: array of TObject;
    DataOffset: Integer;
    Data: array of Byte;
    DataP: array of Pointer;
    VarToClear: array of Pointer;
    DynArrayToClear: array of TDynToClear;
    StrToClear: array of Pointer;
    WStrToClear: array of Pointer;
  public
    constructor Create;
    destructor Destroy; override;
    function  AllocData(Size: Integer): Pointer;
    procedure SetDataPointer(Index: Integer; P: Pointer);
    function  GetDataPointer(Index: Integer): Pointer;
    procedure AddObjectToDestroy(Obj: TObject);
    procedure RemoveObjectToDestroy(Obj: TObject);
    procedure AddDynArrayToClear(P: Pointer; Info: PTypeInfo);
    procedure AddVariantToClear(P: PVarData);
    procedure AddStrToClear(P: Pointer);
    procedure AddWStrToClear(P: Pointer);
  end;

  TInvContext = class(TDataContext)
  private
    ResultP: Pointer;
  public
    procedure SetMethodInfo(const MD: TIntfMethEntry);
    procedure SetParamPointer(Param: Integer; P: Pointer);
    function  GetParamPointer(Param: Integer): Pointer;
    function  GetResultPointer: Pointer;
    procedure SetResultPointer(P: Pointer);
    procedure AllocServerData(const MD: TIntfMethEntry);
  end;

function  GetRemotableDataContext: Pointer;
procedure SetRemotableDataContext(Value: Pointer);

function  InvRegistry:   TInvokableClassRegistry;
function  RemClassRegistry: TRemotableClassRegistry;
function  RemTypeRegistry: TRemotableTypeRegistry;

function  SubstituteStrings(const InputString: WideString;
                            const SubString: WideString;
                            const Replacement: WideString): WideString;
var
  AppNameSpacePrefix: string;

const
  XMLSchemaInstNamepspaces: array[0..2] of InvString =
    (SXMLSchemaInstURI_1999, SXMLSchemaInstURI_2000_10, SXMLSchemaInstURI);

  XMLSchemaNamepspaces: array[0..2] of InvString =
    (SXMLSchemaURI_1999, SXMLSchemaURI_2000_10, SXMLSchemaURI_2001);

  XMLBase64Types: array[0..1] of InvString = ('base64Binary', 'bin.base64');

  { Use 'AS_ATTRIBUTE' for members TRemotable-derived classes that you want
    sent/received as attributes. For example:

        ClassWithAttribute = class(TRemotable)
        private
          FData: string;
          FAttribute: string;
        published
          property Data: string read FData write FData;
          property Attribute: string read FAttribute write FAttribute stored AS_ATTRIBUTE;
        end;

    The member 'Attribute' above will be streamed as
    an attribute of the class' node
  }
  AS_ATTRIBUTE = False;

implementation

uses Variants, InvRules, SOAPConst, XSBuiltIns, xmldom, OPToSOAPDomConv, HTTPUtil;

var
  InvRegistryV: TInvokableClassRegistry;
  RemClassRegistryV: TRemotableClassRegistry;
  RemTypeRegistryV: TRemotableTypeRegistry;

threadvar
  RemotableDataContext: Pointer;

function SubstituteStrings(const InputString: WideString; const SubString: WideString;
                           const Replacement: WideString): WideString;
var
  I: Integer;
begin
  Result := InputString;
  I := Pos(SubString, InputString);
  if I = 0 then
    Exit
  else
  begin
    Delete(Result, I, Length(SubString));
    Insert(Replacement, Result, I);
  end;
end;

function GetRemotableDataContext: Pointer;
begin
  Result := RemotableDataContext;
end;

procedure SetRemotableDataContext(Value: Pointer);
begin
  RemotableDataContext := Value;
end;

function TInvokableClassRegistry.GetInterfaceCount: Integer;
begin
  Result := 0;
  if FRegIntfs <> nil then
    Result := Length(FRegIntfs);
end;

function TInvokableClassRegistry.GetRegInterfaceEntry(Index: Integer): InvRegIntfEntry;
begin
  if Index < Length(FRegIntfs) then
    Result := FRegIntfs[Index];
end;

function TInvokableClassRegistry.HasRegInterfaceImpl(Index: Integer): Boolean;
begin
  if Index < Length(FRegIntfs) then
    Result := FRegIntfs[Index].DefImpl <> nil
  else
    Result := False;
end;


constructor TInvokableClassRegistry.Create;
begin
  inherited Create;
  InitializeCriticalSection(FLock);
end;

destructor TInvokableClassRegistry.Destroy;
begin
  DeleteCriticalSection(FLock);
  inherited Destroy;
end;

procedure TInvokableClassRegistry.Lock;
begin
  EnterCriticalSection(FLock);
end;

procedure TInvokableClassRegistry.UnLock;
begin
  LeaveCriticalSection(FLock);
end;

procedure TInvokableClassRegistry.RegisterInvokableClass(AClass: TClass);
begin
  RegisterInvokableClass(AClass, nil);
end;

procedure TInvokableClassRegistry.RegisterInvokableClass(AClass: TClass; CreateProc: TCreateInstanceProc);
var
  Index, I, J: Integer;
  Table: PInterfaceTable;

begin
  Lock;
  try
    Table := AClass.GetInterfaceTable;
    { If a class does not implement interfaces, we'll try it's parent }
    if Table = nil then
    begin
      if (AClass.ClassParent <> nil) then
      begin
        Table := AClass.ClassParent.GetInterfaceTable;
        {
        if Table <> nil then
          AClass := AClass.ClassParent;
        }
      end;
    end;
    if Table = nil then
      raise ETypeRegistryException.CreateFmt(SNoInterfacesInClass, [AClass.ClassName]);
    Index := Length(FRegClasses);
    SetLength(FRegClasses, Index + 1);
    FRegClasses[Index].ClassType := AClass;
    FRegClasses[Index].Proc := CreateProc;

    { Find out what Registered invokable interface this class implements }
    for I := 0 to Table.EntryCount - 1 do
    begin
      for J := 0 to Length(FRegIntfs) - 1 do
        if IsEqualGUID(FRegIntfs[J].GUID, Table.Entries[I].IID) then
          { NOTE: Don't replace an existing implementation          }
          {       This approach allows for better control on which  }
          {       class implements a particular interface           }
          if FRegIntfs[J].DefImpl = nil then
            FRegIntfs[J].DefImpl := AClass;
    end;
  finally
    UnLock;
  end;
end;

procedure TInvokableClassRegistry.RegisterHeaderClass(Info: PTypeInfo; AClass: TClass;
              DefaultMethodType: eHeaderMethodType = hmtAll; Required: Boolean = False);
begin
  RegisterHeaderClass(Info, AClass, '', '', DefaultMethodType, Required);
end;

procedure TInvokableClassRegistry.RegisterHeaderClass(Info: PTypeInfo; AClass: TClass;
              const HeaderName: WideString; const HeaderNamespace: WideString;
              DefaultMethodType: eHeaderMethodType = hmtAll; Required: Boolean = False);
begin
  InternalRegisterHeaderClass(Info, AClass, HeaderName, HeaderNamespace, DefaultMethodType, '', hmtAll, Required);
end;

procedure TInvokableClassRegistry.RegisterHeaderMethod(Info: PTypeInfo; AClass: TClass;
              const MethodName: string; MethodType: eHeaderMethodType = hmtAll;
              Required: Boolean = False);
begin
  InternalRegisterHeaderClass(Info, AClass, '', '', hmtAll, MethodName, MethodType, Required);
end;

procedure TInvokableClassRegistry.InternalRegisterHeaderClass(Info: PTypeInfo; AClass: TClass;
              const HeaderName: WideString; const HeaderNamespace: WideString;
              DefaultMethodType: eHeaderMethodType; const MethodName: string = '';
              MethodType: eHeaderMethodType = hmtAll; Required: Boolean = False);

   { adding MethodName info to interface }
   procedure SetMethodInfo(var HeaderItem: IntfHeaderItem);
   var
     Headers: TStrings;
   begin
     Headers := TStringList.Create;
     try
       Headers.CommaText := HeaderItem.MethodNames;
       if Headers.IndexOf(MethodName) = -1 then
       begin
         Headers.Add(MethodName);
         SetLength(HeaderItem.MethodTypes, Headers.Count);
         SetLength(HeaderItem.HeaderRequired, Headers.Count);
         HeaderItem.MethodTypes[Headers.Count-1] := MethodType;
         HeaderItem.HeaderRequired[Headers.Count-1] := Required;
         HeaderItem.MethodNames := Headers.CommaText;
       end;
     finally
       Headers.Free;
     end;
   end;

var
  I, J, HeaderIndex: Integer;
begin
  Lock;
  try
    I := GetIntfIndex(Info);
    if I >= 0 then
    begin
      HeaderIndex := Length(FRegIntfs[I].IntfHeaders);
      for J := 0 to Length(FRegIntfs[I].IntfHeaders) - 1 do
        if FRegIntfs[I].IntfHeaders[J].ClassType = AClass then
        begin
          HeaderIndex := J;
          break;
        end;
      if HeaderIndex = Length(FRegIntfs[I].IntfHeaders) then
      begin
        { registering new Header Class for Interface }
        SetLength(FRegIntfs[I].IntfHeaders, 1 + Length(FRegIntfs[I].IntfHeaders));
        FRegIntfs[I].IntfHeaders[HeaderIndex].ClassType := AClass;
        FRegIntfs[I].IntfHeaders[HeaderIndex].Info := AClass.ClassInfo;
        FRegIntfs[I].IntfHeaders[HeaderIndex].Name := HeaderName;
        FRegIntfs[I].IntfHeaders[HeaderIndex].Namespace := HeaderNamespace;
        FRegIntfs[I].IntfHeaders[HeaderIndex].DefaultRequired := Required;
        FRegIntfs[I].IntfHeaders[HeaderIndex].DefaultMethodType := DefaultMethodType;
      end;
      if MethodName <> '' then
        SetMethodInfo(FRegIntfs[I].IntfHeaders[HeaderIndex]);
    end;
  finally
    Unlock;
  end;
end;

function TInvokableClassRegistry.GetExceptionInfoForInterface(Info: PTypeInfo): TExceptionItemArray;
var
  I, J, Current: Integer;
begin
  SetLength(Result, 0);
  Lock;
  try
    I := GetIntfIndex(Info);
    if I >= 0 then
    begin
      for J := 0 to Length(FRegIntfs[I].IntfExceptions) -1 do
      begin
        Current := Length(Result);
        SetLength(Result, Current + 1);
        Result[Current] := FRegIntfs[I].IntfExceptions[J];
      end;
    end;
  finally
    Unlock;
  end;
end;

function TInvokableClassRegistry.GetHeaderInfoForInterface(Info: PTypeInfo;
         MethodType: eHeaderMethodType = hmtAll): THeaderItemArray;

  function CheckHeaderType(HeaderItem: IntfHeaderItem): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if (not Assigned(HeaderItem.MethodTypes)) then
      Result := HeaderItem.DefaultMethodType in [hmtAll, MethodType]
    else
    begin
      for I := 0 to Length(HeaderItem.MethodTypes) do
        if HeaderItem.MethodTypes[I] in [hmtAll, MethodType] then
        begin
          Result := True;
          break;
        end;
    end;
  end;
var
  I, J, Current: Integer;
begin
  SetLength(Result, 0);
  Lock;
  try
    I := GetIntfIndex(Info);
    if I >= 0 then
    begin
      for J := 0 to Length(FRegIntfs[I].IntfHeaders) - 1 do
      begin
        if (MethodType = hmtAll) or (CheckHeaderType(FRegIntfs[I].IntfHeaders[J])) then
        begin
          Current := Length(Result);
          SetLength(Result, Current + 1);
          Result[Current] := FRegIntfs[I].IntfHeaders[J];
        end;
      end;
    end;
  finally
    Unlock;
  end;
end;

function TInvokableClassRegistry.InternalGetHeaderName(const Item:IntfHeaderItem): WideString;
var
  URI: WideString;
begin
  Result := Item.Name;
  if Result = '' then
  begin
    RemClassRegistry.ClassToURI(Item.ClassType, URI, Result);
  end;
end;

function TInvokableClassRegistry.InternalGetHeaderNamespace(const Item: IntfHeaderItem): WideString;
var
  Name: WideString;
begin
  Result := Item.Namespace;
  if Result = '' then
  begin
    RemClassRegistry.ClassToURI(Item.ClassType, Result, Name);
  end;
end;

function TInvokableClassRegistry.GetHeaderName(Info: PTypeInfo; AClass: TClass): WideString;
var
  I, J: Integer;
begin
  Result := '';
  Lock;
  try
    I := GetIntfIndex(Info);
    if I >= 0 then
    begin
      for J := 0 to Length(FRegIntfs[I].IntfHeaders)-1 do
      begin
        if FRegIntfs[I].IntfHeaders[J].ClassType = AClass then
        begin
          Result := InternalGetHeaderName(FRegIntfs[I].IntfHeaders[J]);
          Exit;
        end;
      end;
    end;
  finally
    Unlock;
  end;
end;

function TInvokableClassRegistry.GetHeaderNamespace(Info: PTypeInfo; AClass: TClass): WideString;
var
  I, J: Integer;
begin
  Result := '';
  Lock;
  try
    I := GetIntfIndex(Info);
    if I >= 0 then
    begin
      for J := 0 to Length(FRegIntfs[I].IntfHeaders)-1 do
      begin
        if FRegIntfs[I].IntfHeaders[J].ClassType = AClass then
        begin
          Result := InternalGetHeaderNamespace(FRegIntfs[I].IntfHeaders[J]);
          Exit;
        end;
      end;
    end;
  finally
    Unlock;
  end;
end;

function TInvokableClassRegistry.GetHeaderNamespace(AClass: TClass): WideString;
var
  I, J: Integer;
  Name: WideString;
begin
  Result := '';
  for I := 0 to Length(FRegIntfs)-1 do
  begin
    for J := 0 to Length(FRegIntfs[I].IntfHeaders)-1 do
    begin
      if FRegIntfs[I].IntfHeaders[J].ClassType = AClass then
      begin
        Result := InternalGetHeaderNamespace(FRegIntfs[I].IntfHeaders[J]);
        Exit;
      end;
    end;
  end;
  RemClassRegistry.ClassToURI(AClass, Result, Name);
end;

function TInvokableClassRegistry.GetHeaderClass(Name, Namespace: WideString): TClass;
var
  I, J: Integer;
begin
  Result := nil;
  for I := 0 to Length(FRegIntfs)-1 do
  begin
    for J := 0 to Length(FRegIntfs[I].IntfHeaders)-1 do
    begin
      if (InternalGetHeaderName(FRegIntfs[I].IntfHeaders[J]) = Name) and
         (InternalGetHeaderNamespace(FRegIntfs[I].IntfHeaders[J]) = Namespace) then
      begin
        Result := FRegIntfs[I].IntfHeaders[J].ClassType;
        Exit;
      end;
    end;
  end;
end;

function TInvokableClassRegistry.GetRequestHeaderInfoForInterface(Info: PTypeInfo): THeaderItemArray;
begin
  Result := GetHeaderInfoForInterface(Info, hmtRequest);
end;

function TInvokableClassRegistry.GetResponseHeaderInfoForInterface(Info: PTypeInfo): THeaderItemArray;
begin
  Result := GetHeaderInfoForInterface(Info, hmtResponse);
end;

procedure TInvokableClassRegistry.RegisterException(Info: PTypeInfo; AClass: TClass);
begin
  InternalRegisterException(Info, AClass, '');
end;

procedure TInvokableClassRegistry.RegisterExceptionMethod(Info: PTypeInfo;
          AClass: TClass; const MethodName: string);
begin
  InternalRegisterException(Info, AClass, MethodName);
end;

procedure TInvokableClassRegistry.InternalRegisterException(Info: PTypeInfo; AClass: TClass; const MethodName: string);

  procedure AddExceptionMethod(var ExceptItem: IntfExceptionItem);
  var
    Methods: TStrings;
  begin
    Methods := TStringList.Create;
    try
      Methods.CommaText := ExceptItem.MethodNames;
      { don't add duplicate method names }
      if Methods.IndexOf(MethodName) = -1 then
      begin
        Methods.Add(MethodName);
        ExceptItem.MethodNames := Methods.CommaText;
      end;
    finally
      Methods.Free;
    end;
  end;

var
  I, J, ExceptionIndex: Integer;
begin
  Lock;
  try
    I := GetIntfIndex(Info);
    if I >= 0 then
    begin
      ExceptionIndex := Length(FRegIntfs[I].IntfExceptions);
      for J := 0 to Length(FRegIntfs[I].IntfExceptions) - 1 do
      if FRegIntfs[I].IntfExceptions[J].ClassType = AClass then
      begin
        ExceptionIndex := J;
        break;
      end;
      { add new Exception class }
      if ExceptionIndex = Length(FRegIntfs[I].IntfExceptions) then
      begin
        SetLength(FRegIntfs[I].IntfExceptions, 1 + Length(FRegIntfs[I].IntfExceptions));
        FRegIntfs[I].IntfExceptions[ExceptionIndex].ClassType := AClass;
      end;
      { add Method Information }
      if MethodName <> '' then
        AddExceptionMethod(FRegIntfs[I].IntfExceptions[ExceptionIndex]);
    end;
  finally
    Unlock;
  end;
end;

procedure TInvokableClassRegistry.DeleteFromReg(AClass: TClass; Info: PTypeInfo);
var
  I, Index, ArrayLen: Integer;
begin
  Lock;
  try
    Index := -1;
    if Assigned(Info) then
      ArrayLen := Length(FRegIntfs)
    else
      ArrayLen := Length(FRegClasses);
    for I := 0 to ArrayLen - 1 do
    begin
      if (Assigned(Info) and (FRegIntfs[I].Info = Info)) or
        (Assigned(AClass) and (FRegClasses[I].ClassType = AClass)) then
      begin
        Index := I;
        break;
      end;
    end;
    if Index <> -1 then
    begin
      if Assigned(Info) then
      begin
        for I := Index to ArrayLen - 2 do
          FRegIntfs[I] := FRegIntfs[I+1];
        SetLength(FRegIntfs, Length(FRegIntfs) -1);
      end else
      begin
        for I := Index to ArrayLen - 2 do
          FRegClasses[I] := FRegClasses[I+1];
        SetLength(FRegClasses, Length(FRegClasses) -1);
      end;
    end;
  finally
    UnLock;
  end;
end;

procedure TInvokableClassRegistry.UnRegisterInvokableClass(AClass: TClass);
begin
  DeleteFromReg(AClass, nil);
end;

{
procedure TInvokableClassRegistry.RegisterInterface(Info: PTypeInfo);
begin
  RegisterInterface(Info, '');
end;

procedure TInvokableClassRegistry.RegisterInterface(Info: PTypeInfo; const Namespace: InvString);
begin
  RegisterInterface(Info, Namespace, '');
end;

procedure TInvokableClassRegistry.RegisterInterface(Info: PTypeInfo; const Namespace: InvString;
                    const WSDLEncoding: InvString);
begin
  RegisterInterface(Info, Namespace, WSDLEncoding, '');
end;

procedure TInvokableClassRegistry.RegisterInterface(Info: PTypeInfo; const Namespace: InvString;
                    const WSDLEncoding: InvString; const Doc: string);
begin
  RegisterInterface(Info, Namespace, WSDLEncoding, Doc, '');
end;
}

procedure TInvokableClassRegistry.RegisterInterface(Info: PTypeInfo; const Namespace: InvString;
                    const WSDLEncoding: InvString; const Doc: string; const ExtName: InvString);
var
  Index: Integer;
  IntfMD: TIntfMetaData;
  I, J: Integer;
  Table: PInterfaceTable;
  URIApp: string;
begin
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
      if FRegIntfs[I].Info = Info then
        Exit;
    Index := Length(FRegIntfs);
    SetLength(FRegIntfs, Index + 1);
    GetIntfMetaData(Info, IntfMD, True);
    FRegIntfs[Index].GUID := IntfMD.IID;
    FRegIntfs[Index].Info := Info;
    FRegIntfs[Index].Name := IntfMD.Name;
    FRegIntfs[Index].UnitName := IntfMD.UnitName;
    FRegIntfs[Index].Documentation := Doc;
    FRegIntfs[Index].ExtName := ExtName;
    FRegIntfs[Index].WSDLEncoding := WSDLEncoding;

    if AppNameSpacePrefix <> '' then
      URIApp := AppNameSpacePrefix +  '-';

    { Auto-generate a namespace from the filename in which the interface was declared and
      the AppNameSpacePrefix }
    if Namespace = '' then
      FRegIntfs[Index].Namespace :=  'urn:' + URIApp + IntfMD.UnitName + '-' + IntfMD.Name
    else
    begin
      FRegIntfs[Index].Namespace := Namespace;
      FRegIntfs[Index].InvokeOptions := FRegIntfs[Index].InvokeOptions + [ioHasNamespace];
    end;

    if FRegIntfs[Index].DefImpl = nil then
    begin
      { NOTE: First class that implements this interface wins!! }
      for I := 0 to Length(FRegClasses) - 1 do
      begin
        { NOTE: We'll allow for a class whose parent implements interfaces }
        Table :=  FRegClasses[I].ClassType.GetInterfaceTable;
        if (Table = nil) then
        begin
          Table := FRegClasses[I].ClassType.ClassParent.GetInterfaceTable;
        end;
        for J := 0 to Table.EntryCount - 1 do
        begin
          if IsEqualGUID(IntfMD.IID, Table.Entries[J].IID) then
          begin
            FRegIntfs[Index].DefImpl := FRegClasses[I].ClassType;
            Exit;
          end;
        end;
      end;
    end;
  finally
    Unlock;
  end;
end;

procedure TInvokableClassRegistry.RegisterDefaultSOAPAction(Info: PTypeInfo; const DefSOAPAction: InvString);
var
  I: Integer;
begin
  Lock;
  try
    I := GetIntfIndex(Info);
    if I >= 0 then
    begin
      FRegIntfs[I].SOAPAction := DefSOAPAction;
      FRegIntfs[I].InvokeOptions := FRegIntfs[I].InvokeOptions + [ioHasDefaultSOAPAction];
      Exit;
    end;
  finally
    Unlock;
  end;
end;

procedure TInvokableClassRegistry.RegisterAllSOAPActions(Info: PTypeInfo; const AllSOAPActions: InvString);
var
  I: Integer;
begin
  Lock;
  try
    I := GetIntfIndex(Info);
    if I >= 0 then
    begin
      FRegIntfs[I].SOAPAction := AllSOAPActions;
      FRegIntfs[I].InvokeOptions := FRegIntfs[I].InvokeOptions + [ioHasAllSOAPActions];
      Exit;
    end;
  finally
    Unlock;
  end;
end;

procedure TInvokableClassRegistry.RegisterUDDIInfo(Info: PTypeInfo; const Operator: String; const BindingKey: string);
var
  I: Integer;
begin
  Lock;
  try
    I := GetIntfIndex(Info);
    if I >= 0 then
    begin
      FRegIntfs[I].UDDIOperator := Operator;
      FRegIntfs[I].UDDIBindingKey := BindingKey;
      FRegIntfs[I].InvokeOptions := FRegIntfs[I].InvokeOptions + [ioHasUDDIInfo];
      Exit;
    end;
  finally
    Unlock;
  end;
end;

procedure TInvokableClassRegistry.RegisterReturnParamNames(Info: PTypeInfo; const RetParamNames: string);
var
  I: Integer;
begin
  Lock;
  try
    I := GetIntfIndex(Info);
    if I >= 0 then
    begin
      FRegIntfs[I].ReturnParamNames := RetParamNames;
      FRegIntfs[I].InvokeOptions := FRegIntfs[I].InvokeOptions + [ioHasReturnParamNames];
    end;
  finally
    Unlock;
  end;
end;

procedure TInvokableClassRegistry.RegisterInvokeOptions(Info: PTypeInfo; const InvokeOption: TIntfInvokeOption);
var
  Options: TIntfInvokeOptions;
begin
  Options := GetIntfInvokeOptions(Info);
  Options := Options + [InvokeOption];
  RegisterInvokeOptions(info, Options);
end;

procedure TInvokableClassRegistry.RegisterInvokeOptions(Info: PTypeInfo; const InvokeOptions: TIntfInvokeOptions);
var
  I: Integer;
begin
  Lock;
  try
    I := GetIntfIndex(Info);
    if I >= 0 then
      FRegIntfs[I].InvokeOptions := InvokeOptions;
  finally
    Unlock;
  end;
end;

{ calls to this method need to be within try/Lock finally/unlock block }
function TInvokableClassRegistry.GetIntfIndex(const IntfInfo: PTypeInfo): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Length(FRegIntfs)-1 do
  begin
    if IntfInfo = FRegIntfs[I].Info then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

function TInvokableClassRegistry.GetIntfInvokeOptions(const IntfInfo: PTypeInfo): TIntfInvokeOptions;
var
  I: Integer;
begin
  Result := [];
  Lock;
  try
    I := GetIntfIndex(IntfInfo);
    if I >= 0 then
      Result := FRegIntfs[I].InvokeOptions;
  finally
    Unlock;
  end;
end;

function TInvokableClassRegistry.GetIntfInvokeOptions(const AGUID: TGUID): TIntfInvokeOptions;
begin
  Result := GetIntfInvokeOptions(GetInterfaceTypeInfo(AGUID));
end;

function TInvokableClassRegistry.GetInterfaceExternalName(Info: PTypeInfo): InvString;
begin
  Result := GetInterfaceExternalName(Info, '');
end;

function TInvokableClassRegistry.GetInterfaceExternalName(Info: PTypeInfo; const Namespace: string): InvString;
begin
  Result := GetInterfaceExternalName(Info, Namespace, '');
end;

function TInvokableClassRegistry.GetInterfaceExternalName(Info: PTypeInfo; const Namespace: string; const InternalIntfName: string): InvString;
var
  Index: Integer;
begin
  Result := InternalIntfName;
  Lock;
  try
    for Index := 0 to Length(FRegIntfs) - 1 do
    begin
      if FRegIntfs[Index].Info = Info then
        if FRegIntfs[Index].Name = InternalIntfName then
        begin
          if FRegIntfs[Index].ExtName <> '' then
            Result := FRegIntfs[Index].ExtName;
          break;
        end;
    end;
  finally
    Unlock;
  end;
end;

function TInvokableClassRegistry.GetWSDLEncoding(Info: PTypeInfo): InvString;
begin
  Result := GetWSDLEncoding(Info, '');
end;

function TInvokableClassRegistry.GetWSDLEncoding(Info: PTypeInfo; const Namespace: string): InvString;
begin
  Result := GetWSDLEncoding(Info, Namespace, '');
end;

function TInvokableClassRegistry.GetWSDLEncoding(Info: PTypeInfo; const Namespace: string; const InternalIntfName: string): InvString;
var
  Index: Integer;
begin
  Result := '';
  Lock;
  try
    for Index := 0 to Length(FRegIntfs) - 1 do
    begin
      if FRegIntfs[Index].Info = Info then
        if FRegIntfs[Index].Name = InternalIntfName then
        begin
          Result := FRegIntfs[Index].WSDLEncoding;
          break;
        end;
    end;
  finally
    Unlock;
  end;
end;

procedure TInvokableClassRegistry.UnRegisterInterface(Info: PTypeInfo);
begin
  DeleteFromReg(nil, Info);
end;

procedure TInvokableClassRegistry.RegisterExternalMethName(Info: PTypeInfo; const InternalName: string; const ExternalName: InvString);
var
  I, J: Integer;
begin
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
      if FRegIntfs[I].Info = Info then
      begin
        J := Length(FRegIntfs[I].MethNameMap);
        SetLength(FRegIntfs[I].MethNameMap, J + 1);
        FRegIntfs[I].MethNameMap[J].Name := InternalName;
        FRegIntfs[I].MethNameMap[J].ExtName := ExternalName;
      end;
  finally
    Unlock;
  end;
end;

procedure TInvokableClassRegistry.RegisterExternalParamName(Info: PTypeInfo; const MethodName, InternalName: string; const ExternalName: InvString);
var
  I, J, K: Integer;
begin
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
      if FRegIntfs[I].Info = Info then
      begin
        J := 0;
        while J <= Length(FRegIntfs[I].MethParamNameMap) -1 do
        begin
          if SameText(FRegIntfs[I].MethParamNameMap[J].MethName, MethodName) then
            break;
          J := J + 1;
        end;

        if J = Length(FRegIntfs[I].MethParamNameMap) then
        begin
          SetLength(FRegIntfs[I].MethParamNameMap, J + 1);
          FRegIntfs[I].MethParamNameMap[J].MethName := MethodName;
        end;
        K := Length(FRegIntfs[I].MethParamNameMap[J].ParamNameMap);
        SetLength(FRegIntfs[I].MethParamNameMap[J].ParamNameMap, K + 1);
        FRegIntfs[I].MethParamNameMap[J].ParamNameMap[K].Name := InternalName;
        FRegIntfs[I].MethParamNameMap[J].ParamNameMap[K].ExtName := ExternalName;
        break;
      end;
  finally
    Unlock;
  end;
end;

function TInvokableClassRegistry.GetParamExternalName(Info: PTypeInfo; const MethodName, InternalParamName: string): InvString;
var
  I, J, K: Integer;
begin
  Result := InternalParamName;
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
      if FRegIntfs[I].Info = Info then
      begin
        for J := 0 to Length(FRegIntfs[I].MethParamNameMap) -1 do
          if SameText(FRegIntfs[I].MethParamNameMap[J].MethName, MethodName) then
          begin
            for K := 0 to Length(FRegIntfs[I].MethParamNameMap[J].ParamNameMap) -1 do
              if SameText(FRegIntfs[I].MethParamNameMap[J].ParamNameMap[K].Name, InternalParamName) then
              begin
                if FRegIntfs[I].MethParamNameMap[J].ParamNameMap[K].ExtName <> '' then
                  Result := FRegIntfs[I].MethParamNameMap[J].ParamNameMap[K].ExtName;
                Exit;
              end;
          end;
      end;
  finally
    Unlock;
  end;
end;

function TInvokableClassRegistry.GetParamInternalName(Info: PTypeInfo; const MethodName: string; const ExternalParamName: InvString): string;
var
  I, J, K: Integer;
begin
  Result := ExternalParamName;
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
      if FRegIntfs[I].Info = Info then
      begin
        for J := 0 to Length(FRegIntfs[I].MethParamNameMap) -1 do
          if SameText(FRegIntfs[I].MethParamNameMap[J].MethName, MethodName) then
          begin
            for K := 0 to Length(FRegIntfs[I].MethParamNameMap[J].ParamNameMap) -1 do
              if SameText(FRegIntfs[I].MethParamNameMap[J].ParamNameMap[K].ExtName, ExternalParamName) then
              begin
                if FRegIntfs[I].MethParamNameMap[J].ParamNameMap[K].Name <> '' then
                  Result := FRegIntfs[I].MethParamNameMap[J].ParamNameMap[K].Name;
                Exit;
              end;
          end;
      end;
  finally
    Unlock;
  end;
end;

function TInvokableClassRegistry.GetMethExternalName(Info: PTypeInfo; const MethodIntName: string): InvString;
var
  I, J: Integer;
begin
  Result := MethodIntName;
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
    begin
      if FRegIntfs[I].Info = Info then
      begin
        for J := 0 to Length(FRegIntfs[I].MethNameMap) -1 do
          if SameText(FRegIntfs[I].MethNameMap[J].Name, MethodIntName) then
          begin
            if FRegIntfs[I].MethNameMap[J].ExtName <> '' then
              Result := FRegIntfs[I].MethNameMap[J].ExtName;
            Exit;
          end;
      end;
    end;
  finally
    Unlock;
  end;
end;

function TInvokableClassRegistry.GetMethInternalName(Info: PTypeInfo; const MethodExtName: InvString): string;
var
  I, J: Integer;
begin
  Result := MethodExtName;
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
    begin
      if FRegIntfs[I].Info = Info then
      begin
        for J := 0 to Length(FRegIntfs[I].MethNameMap) -1 do
          if SameText(FRegIntfs[I].MethNameMap[J].ExtName, MethodExtName) then
          begin
            if FRegIntfs[I].MethNameMap[J].Name <> '' then
              Result := FRegIntfs[I].MethNameMap[J].Name;
            Exit;
          end;
      end;
    end;
  finally
    Unlock;
  end;
end;

function TInvokableClassRegistry.GetInterfaceTypeInfo(const AGUID: TGUID): Pointer;
var
  I: Integer;
begin
  Result := nil;
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
    begin
      if IsEqualGUID(AGUID, FRegIntfs[I].GUID) then
      begin
        Result := FRegIntfs[I].Info;
        Exit;
      end;
    end;
  finally
    UnLock;
  end;
end;

procedure TInvokableClassRegistry.GetInterfaceInfoFromName(
  const UnitName, IntfName: string; var Info: PTypeInfo; var IID: TGUID);
var
  I: Integer;
begin
  Info := nil;
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
    begin
      if SameText(IntfName, FRegIntfs[I].Name)
          and ((UnitName = '') or (SameText(UnitName, FRegIntfs[I].UnitName)))
      then
      begin
        Info := FRegIntfs[I].Info;
        IID := FRegIntfs[I].GUID;
      end;
    end;
  finally
    UnLock;
  end;
end;

function  TInvokableClassRegistry.GetActionURIOfIID(const AGUID: TGUID): string;
begin
  Result := GetActionURIOfInfo(GetInterfaceTypeInfo(AGUID), '', -1);
end;

function TInvokableClassRegistry.GetActionURIOfInfo(const IntfInfo: PTypeInfo; const MethodName: WideString; MethodIndex: Integer): string;
var
  I: Integer;
  SOAPActions: TStringDynArray;
begin
  SetLength(SOAPActions, 0);
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
    begin
      if IntfInfo = FRegIntfs[I].Info then
      begin
        { NOTE: Method name is ignored when an explicit SOAPAction is set unless it
                contains the Operation format specifier }
        if (ioHasDefaultSOAPAction in FRegIntfs[I].InvokeOptions) then
        begin
          Result := FRegIntfs[I].SOAPAction;
          if MethodName <> '' then
            Result := SubstituteStrings(Result, SOperationNameSpecifier, MethodName);
        end
        else if (ioHasAllSOAPActions in FRegIntfs[I].InvokeOptions) then
        begin
          SOAPActions := StringToStringArray(FRegIntfs[I].SOAPAction, FRegIntfs[I].SOAPAction[1]);
          if (MethodIndex >= 0) and (MethodIndex < Length(SOAPActions)) then
            Result := SOAPActions[MethodIndex]
          else
            Result := '';
        end else
        begin
          { NOTE: For backward compatibility reasons, we use the Namespace#MethodName
                  as the default SOAPAction. If you need to customize the SOAPAction,
                  or if you can't use that logic (like when more than one interface
                  uses the same namespace), use RegisterDefaultSOAPAction or
                  RegisterAllSOAPActions to specify another SOAPAction }
          Result := FRegIntfs[I].Namespace + '#' + MethodName;
        end;
        Exit;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TInvokableClassRegistry.GetUDDIInfo(const IntfInfo: PTypeInfo; var Operator, BindingKey: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  Lock;
  try
    I := GetIntfIndex(IntfInfo);
    if I >= 0 then
    begin
      if (ioHasUDDIInfo in FRegIntfs[I].InvokeOptions) then
      begin
        Operator := FRegIntfs[I].UDDIOperator;
        BindingKey := FRegIntfs[I].UDDIBindingKey;
        Result := True;
      end;	
    end;
  finally
    Unlock;
  end;
end;

function TInvokableClassRegistry.GetUDDIInfo(const AGUID: TGUID; var Operator, BindingKey: string): Boolean;
begin
  Result := GetUDDIInfo(GetInterfaceTypeInfo(AGUID), Operator, BindingKey);
end;

function TInvokableClassRegistry.GetReturnParamNames(const IntfInfo: PTypeInfo): string;
var
  I: Integer;
begin
  Result := SDefaultReturnParamNames;
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
    begin
      if IntfInfo = FRegIntfs[I].Info then
      begin
        if (ioHasReturnParamNames in FRegIntfs[I].InvokeOptions) then
          Result := FRegIntfs[I].ReturnParamNames;
        Exit;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TInvokableClassRegistry.GetInfoForURI(const PathURI, ActionURI: string; var AClass: TClass; var IntfInfo: PTypeInfo; var AMeth: string): Boolean;

  function FindViaSOAPAction: Boolean;
  var
    I: integer;
    SAPrefix, ActionPrefix: string;
  begin
    Result := False;
    // Presumes that an action is of the form:
    //    <Namespace>#<MethodName>
    // or
    //    <DefaultSOAPAction><Some other stuff that can be ignored>
    //
    // and that an interface is registered with a <namespace|defaultSOAPAction>
    // so we simply find the first registered interface with a namespace|defaultSOAPAction that
    // is an initial substring of the action
    //
    // NOTE: The method name portion in the first format is ignored!!
    for I := 0 to Length(FRegIntfs) - 1 do
    begin
      { If user specified a SOAPAction use that - otherwise default
        to how we generate SA from namespaces (i.e. GetActionURIOfInfo) }
      if (ioHasDefaultSOAPAction in FRegIntfs[I].InvokeOptions) then
        SAPrefix := FRegIntfs[I].SOAPAction
      else
        SAPrefix := FRegIntfs[I].Namespace;
      { If Default SOAPAction has #%operationName% }
      Delete(SAPrefix, Pos('#', SAPrefix), Length(SAPrefix));           { Do not localize }

      { Get the Prefix of the SOAPAction passed in }
      ActionPrefix := ActionURI;
      if ActionPrefix[1] = '"' then
        Delete(ActionPrefix, 1, 1);
      if ActionPrefix[Length(ActionPrefix)]='"' then
        Delete(ActionPrefix, Length(ActionPrefix), 1);
      Delete(ActionPrefix, Pos('#', ActionPrefix), Length(ActionPrefix));

      if ActionPrefix = SAPrefix then
      begin
        IntfInfo := FRegIntfs[I].Info;
        AClass := FRegIntfs[I].DefImpl;
        Result := True;
        break;
      end;
    end;
  end;

  function FindViaPath: Boolean;
  var
    I: Integer;
  begin
    Result := False;
    { If a URL is used for defining which interface to use
      then find the first interface whose name is a terminal substring of the
      path.
      NOTE: Doesn't consider interfaces with the same name but in different units!! }
    for I := 0 to Length(FRegIntfs) - 1 do
    begin
      if  SameText(Copy(PathURI, LastDelimiter('/', PathURI) + 1, High(Integer)),FRegIntfs[I].Name) then
      begin
        IntfInfo := FRegIntfs[I].Info;
        AClass := FRegIntfs[I].DefImpl;
        Result := True;
        break;
      end;
    end
  end;

begin
  Result := False;
  Lock;
  try
    if ActionURI <> '' then
      Result := FindViaSOAPAction;
    if (Result = False) and (PathURI <> '') then
      Result := FindViaPath;
  finally
    UnLock;
  end;
end;

function TInvokableClassRegistry.GetNamespaceByGUID(const AGUID: TGUID): string;
var
  I: Integer;
begin
  Result := '';
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
    begin
      if IsEqualGUID(FRegIntfs[I].GUID, AGUID) then
      begin
        Result := FRegIntfs[I].Namespace;
        break;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TInvokableClassRegistry.GetInvokableObjectFromClass(
  AClass: TClass): TObject;
var
  I: Integer;
  Found: Boolean;
begin
  Result := nil;
  Lock;
  Found := False;
  try
    for I := 0 to Length(FRegClasses) - 1 do
      if FRegClasses[I].ClassType = AClass then
        if Assigned(FRegClasses[I].Proc) then
        begin
          FRegClasses[I].Proc(Result);
          Found := True;
        end;
    if not Found and  AClass.InheritsFrom(TInvokableClass) then
      Result := TInvokableClassClass(AClass).Create;
  finally
    UnLock;
  end;
end;

procedure TInvokableClassRegistry.GetClassFromIntfInfo(Info: PTypeInfo;
  var AClass: TClass);
var
  I: Integer;
begin
  AClass := nil;
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
      if FRegIntfs[I].Info = Info then
      begin
        AClass := FRegIntfs[I].DefImpl;
        break;
      end;
  finally
    UnLock;
  end;
end;

{ TSOAPHeadersBase }

procedure TSOAPHeadersBase.SetHeadersInOut(var InHdrs, OutHdrs: THeaderList);
begin
  FHeadersInbound := InHdrs;
  FHeadersOutBound := OutHdrs;
end;

{ TSOAPHeaders }

procedure TSOAPHeaders.Send(const Hdr: TSOAPHeader);
begin
  { Don't duplicate headers }
  if FHeadersOutBound.IndexOf(Hdr) = -1 then
    FHeadersOutBound.Add(Hdr);
end;

function TSOAPHeaders.SendCount: Integer;
begin
  Result := FHeadersOutBound.Count;
end;

function TSOAPHeaders.SendAt(Index: Integer): TSOAPHeader;
begin
  Result := TSOAPHeader(FHeadersOutbound[Index]);
end;

procedure TSOAPHeaders.Get(Cls: TClass; out Hdr: TSOAPHeader);
begin
  Hdr := Get(Cls);
end;

function TSOAPHeaders.Get(Cls: TClass): TSOAPHeader;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FHeadersInBound.Count-1 do
  begin
    if FHeadersInBound[I].InheritsFrom(Cls) then
    begin
      Result := TSOAPHeader(FHeadersInBound.Extract(FHeadersInBound[I]));
      Exit;
    end;
  end;
end;

function TSOAPHeaders.Get(const Name, URI: WideString): TSOAPHeader;
var
  Cls: TClass;
begin
  Cls := RemClassRegistry.URIToClass(URI, Name);
  Result := Get(Cls);
end;

function TSOAPHeaders.GetOwnsSentHeaders: Boolean;
begin
  Result := FHeadersOutBound.OwnsObjects;
end;

procedure TSOAPHeaders.SetOwnsSentHeaders(Flag: Boolean);
begin
  FHeadersOutBound.OwnsObjects := Flag;
end;

{ TInvokableClass }

constructor TInvokableClass.Create;
begin
  inherited Create;
  FSOAPHeaders := TSOAPHeaders.Create(Self);
end;

procedure TInvokableClass.AfterConstruction;
begin
  { Release the constructor's implicit refcount }
  InterlockedDecrement(FRefCount);
end;

procedure TInvokableClass.BeforeDestruction;
begin
  if RefCount <> 0 then
    System.Error(reInvalidPtr);
end;

{ Set an implicit refcount so that refcounting  }
{ during construction won't destroy the object. }
class function TInvokableClass.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TInvokableClass(Result).FRefCount := 1;
end;

function TInvokableClass.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if IsEqualGUID(ISOAPHeaders, IID) then
  begin
    Result := FSOAPHeaders.QueryInterface(IID, Obj);
    Exit
  end;
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TInvokableClass._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

function TInvokableClass._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
    Destroy;
end;

{ TRemotable }

constructor TRemotable.Create;
begin
  inherited;
  if RemotableDataContext <> nil then
  begin
    TDataContext(RemotableDataContext).AddObjectToDestroy(Self);
    Self.DataContext := TDataContext(RemotableDataContext);
  end;
end;

destructor TRemotable.Destroy;
begin
  if RemotableDataContext <> nil then
  begin
    TDataContext(RemotableDataContext).RemoveObjectToDestroy(Self);
    Self.DataContext := nil;
  end;
  inherited Destroy;
end;

procedure TRemotable.SetDataContext(Value: TDataContext);
begin
  if (RemotableDataContext <> nil) and (RemotableDataContext = Self.DataContext) then
  begin
    TDataContext(RemotableDataContext).RemoveObjectToDestroy(Self);
  end;
  FDataContext := Value;
end;

function TRemotable.ObjectToSOAP(RootNode, ParentNode: IXMLNode;
                                 const ObjConverter: IObjConverter;
                                 const Name, URI: InvString; ObjConvOpts: TObjectConvertOptions;
                                 out RefID: InvString): IXMLNode;
begin
  Result := ObjConverter.ObjInstanceToSOAP(Self, RootNode, ParentNode, Name, URI,
                                           ObjConvOpts, RefID);
end;

procedure TRemotable.SOAPToObject(const RootNode, Node: IXMLNode;
                                  const ObjConverter: IObjConverter);
begin
  ObjConverter.InitObjectFromSOAP(Self, RootNode, Node);
end;

{ TRemotableXS }

function TRemotableXS.ObjectToSOAP(RootNode, ParentNode: IXMLNode;
                                   const ObjConverter: IObjConverter;
                                   const Name, URI: InvString; ObjConvOpts: TObjectConvertOptions;
                                   out RefID: InvString): IXMLNode;
begin
  ObjConvOpts := ObjConvOpts + [ocoDontSerializeProps];
  Result := inherited ObjectToSOAP(RootNode, ParentNode, ObjConverter, Name, URI, ObjConvOpts, RefID); ;
  { NOTE: In the case where an object is Multiref'ed - currently disabled
          for Scalar types - check the node returned HREF vs ID }
  Result.Text := NativeToXS;
end;

procedure TRemotableXS.SOAPToObject(const RootNode, Node: IXMLNode; const ObjConverter: IObjConverter);
begin
  inherited;
  XSToNative(Node.Text);
end;

{ TSOAPHeader }

function TSOAPHeader.ObjectToSOAP(RootNode, ParentNode: IXMLNode;
                                  const ObjConverter: IObjConverter;
                                  const Name, URI: InvString;
                                  ObjConvOpts: TObjectConvertOptions;
                                  out RefID: InvString): IXMLNode;
const
  BoolDigit: array[Boolean] of string = ('0', '1');
var
  NodeNamespace: WideString;
begin
  ObjConvOpts := ObjConvOpts - [ocoDontPrefixNode];
  NodeNamespace := InvRegistry.GetHeaderNamespace(Self.ClassType);
  Result := ObjConverter.ObjInstanceToSOAP(Self, RootNode, ParentNode, Name, NodeNamespace,
                                           ObjConvOpts, RefID);
  if FMustUnderstand then
    Result.SetAttributeNS(SHeaderMustUnderstand, SSoapNameSpace, BoolDigit[FMustUnderstand]);
  if FActor <> '' then
    Result.SetAttributeNS(SHeaderActor, SSoapNameSpace, FActor);
end;

procedure TSOAPHeader.SOAPToObject(const RootNode, Node: IXMLNode;
                                  const ObjConverter: IObjConverter);
var
  AttrVal: WideString;
begin
  inherited SOAPToObject(RootNode, Node, ObjConverter);
  if Node.HasAttribute(SHeaderMustUnderstand, SSoapNameSpace) then
  begin
    AttrVal := Node.GetAttributeNS(SHeaderMustUnderstand, SSoapNameSpace);
    FMustUnderstand := SameText(AttrVal, '1') or  { Do not localize }
                       SameText(AttrVal, 'true'); { Do not localize }
  end;
  if Node.HasAttribute(SHeaderActor, SSoapNameSpace) then
    FActor := Node.GetAttributeNS(SHeaderActor, SSoapNameSpace);
end;

{ THeaderList }

procedure THeaderList.Add(Header: TObject);
begin
  FObjectList.Add(Header);
end;

procedure THeaderList.Add(Header: TSOAPHeader);
begin
  FObjectList.Add(Header);
end;

procedure THeaderList.Clear;
begin
  FObjectList.Clear;
end;

constructor THeaderList.Create;
begin
  FObjectList := TObjectList.Create;
  inherited Create;
end;

destructor THeaderList.Destroy;
begin
  FObjectList.Free;
  inherited;
end;

function THeaderList.Extract(Obj: TObject): TObject;
begin
  Result := FObjectList.Extract(Obj);
end;

function THeaderList.IndexOf(Obj: TObject): Integer;
begin
  Result := FObjectList.IndexOf(Obj);
end;

function THeaderList.GetCount: Integer;
begin
  Result := FObjectList.Count;
end;

function THeaderList.GetHeader(Index: Integer): TObject;
begin
  Result := FObjectList[Index];
end;

function THeaderList.GetOwnsObjects: Boolean;
begin
  Result := FObjectList.OwnsObjects;
end;

procedure THeaderList.SetOwnsObjects(Val: Boolean);
begin
  FObjectList.OwnsObjects := Val;
end;


{ TSOAPAttachment }

constructor TSOAPAttachment.Create;
begin
  inherited Create;
  FCacheFilePersist := False;
  FHeaders := TStringList.Create;
  FContentType := ContentTypeApplicationBinary;
  FSourceStream := Nil;
  FEncoding := SBinaryEncoding;
end;

procedure TSOAPAttachment.Init(ATempLocation: string; AHeaders: TStrings;
                               AContentType: string; AEncoding: WideString);
begin
  FCacheFile := ATempLocation;
  FHeaders.AddStrings(AHeaders);
  FContentType := AContentType;
  FEncoding := AEncoding
end;

destructor TSOAPAttachment.Destroy;
begin
  ClearStream;
  FHeaders.Free;
  if (not FCacheFilePersist) and FileExists(FCacheFile) then
    SysUtils.DeleteFile(FCacheFile);
  inherited Destroy;
end;

procedure TSOAPAttachment.ClearStream;
begin
  if Assigned(FSourceStream) then
  begin
    if FStreamOwnerShip = soOwned then
      FreeAndNil(FSourceStream)
    else
      FSourceStream := Nil;
  end;
end;

function TSOAPAttachment.GetSourceStream: TStream;
var
  SourceFile: string;
begin
  Result := Nil;
  if Assigned(FSourceStream) then
    Result := FSourceStream
  else
  begin
    if FCacheFile <> '' then
      SourceFile := FCacheFile
    else
      SourceFile := FFileName;
    if SourceFile = '' then exit;
    Result := TFileStream.Create(SourceFile, fmOpenRead);
    FStreamOwnership := soOwned;
    FSourceStream := Result;
  end;
end;

procedure TSOAPAttachment.SetSourceFile(const Value: string);
begin
  FFileName := Value;
  if Value <> '' then
  begin
    if FContentType = '' then
      FContentType := ContentTypeApplicationBinary;
    if FEncoding = '' then
      FEncoding := S8BitEncoding;
    ClearStream;
  end;
end;

procedure TSOAPAttachment.InternalSetCacheFile(const Value: string);
begin
  FCacheFile := Value;
end;

procedure TSOAPAttachment.InternalSetSourceStream(const Value: TStream; const Ownership: TStreamOwnership = soReference);
begin
  if FSourceStream = Value then
  begin
    FStreamOwnership := Ownership;
    exit;
  end;
  ClearStream;
  FStreamOwnership := Ownership;
  FSourceStream := Value;
  if Assigned(Value) then
  begin
    FFileName := '';
    FCacheFile := '';
    FEncoding := '';
    FContentType := ContentTypeApplicationBinary;
    FSourceStream.Seek(0, 0);
  end;
end;

procedure TSOAPAttachment.SetSourceStream(const Value: TStream; const Ownership: TStreamOwnership = soReference);
begin
  InternalSetSourceStream(Value, Ownership);
  if Assigned(Value) then
    FFileName := '';
end;

procedure TSOAPAttachment.SetOwnership(const Value: TStreamOwnership);
begin
  FStreamOwnership := Value;
end;

procedure TSOAPAttachment.SetSourceString(const Value: string);
begin
  if Value <> '' then
  begin
    ClearStream;
    FFileName := '';
    FCacheFile := '';
  end;
  FSourceStream := TMemoryStream.Create;
  TMemoryStream(FSourceStream).SetSize(Length(Value));
  FSourceStream.Write(Value[1], Length(Value));
  FSourceStream.Position := 0;
  FContentType := ContentTypeTextPlain;
  FStreamOwnership := soOwned;
end;

procedure TSOAPAttachment.SaveToFile(AFileName: string);
var
  TempStream: TFileStream;
begin
  TempStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(TempStream);
  finally
    FreeAndNil(TempStream);
  end;
end;

procedure TSOAPAttachment.SaveToStream(AStream: TStream);
var
  Stream: TStream;
  SourceFile: string;
begin
  if Assigned(FSourceStream) then
    Stream := FSourceStream
  else
  begin
    if FCacheFile <> '' then
      SourceFile := FCacheFile
    else
      SourceFile := FFileName;
    if SourceFile <> '' then
      Stream := TFileStream.Create(SourceFile, fmOpenRead)
  end;
  if Assigned(Stream) then
  try
    AStream.Position := 0;
    AStream.CopyFrom(Stream, Stream.Size);
  finally
    if SourceFile <> '' then
      FreeAndNil(Stream);  { don't free FSourceStream }
  end;
end;

function TSOAPAttachment.ObjectToSOAP(RootNode, ParentNode: IXMLNode;
  const ObjConverter: IObjConverter; const Name, URI: InvString;
  ObjConvOpts: TObjectConvertOptions; out RefID: InvString): IXMLNode;
var
  GUID: TGUID;
  GUIDString: string;
begin
  { For attachments, we skip the type and the published properties }
  Result := inherited ObjectToSOAP(RootNode, ParentNode, ObjConverter, Name, URI,
                                   ObjConvOpts + [ocoDontSerializeProps,ocoDontPutTypeAttr],
                                   RefID);

  CreateGuid(GUID);
  GUIDString := GuidToString(GUID);
  GUIDString := Copy(GuidString, 2, Length(GuidString) -2 );
  ObjConverter.AddAttachment(Self, GuidString);
  Result.Attributes[SXMLHREF] := SAttachmentIDPrefix + GuidString;
end;

procedure TSOAPAttachment.SOAPToObject(const RootNode, Node: IXMLNode;
  const ObjConverter: IObjConverter);
var
  AttachFound: TSOAPAttachment;
  CId: string;
begin
  inherited;
  CId := '<' + Node.Attributes[SXMLHREF] + '>';
  AttachFound := ObjConverter.FindAttachment(Cid);

  {OPToSOAPDomConv use to always clear - should we clear if nothing's found?? }
  Headers.Clear;
  SetSourceFile('');
  SetSourceStream(nil);

  if AttachFound <> nil then
  begin
    Init(AttachFound.CacheFile,
         AttachFound.Headers,
         AttachFound.ContentType,
         AttachFound.Encoding);
    { Transfer ownership }
    AttachFound.Ownership := soReference;
    { Make sure SOAP Runtime does not delete this object }
    DataContext := Nil;
  end;
end;

constructor TRemotableTypeRegistry.Create;
begin
  inherited Create;
  FAutoRegister := True;
  InitializeCriticalSection(FLock);
end;

destructor TRemotableTypeRegistry.Destroy;
begin
  inherited Destroy;
  DeleteCriticalSection(FLock);
end;

procedure TRemotableTypeRegistry.Lock;
begin
  EnterCriticalSection(FLock);
end;

procedure TRemotableTypeRegistry.UnLock;
begin
  LeaveCriticalSection(FLock);
end;

function TRemotableTypeRegistry.GetURICount: Integer;
begin
  Lock;
  try
    Result := Length(URIMap);
  finally
    UnLock;
  end;
end;

function TRemotableTypeRegistry.GetURIMap(Index: Integer; out RegEntry: TRemRegEntry): Boolean;
begin
  Result := (Index < Length(URIMap)) and (Index >= 0);
  RegEntry := GetURIMap(Index);
end;

function TRemotableTypeRegistry.GetURIMap(Index: Integer): TRemRegEntry;
begin
  Lock;
  try
    if Index < Length(URIMap) then
      Result := URIMap[Index];
  finally
    UnLock;
  end;
end;

procedure TRemotableTypeRegistry.RegisterXSClass(AClass: TClass; const URI: WideString = '';
                                                 const Name: WideString = '';
                                                 const ExtName: WideString = '';
                                                 IsScalar: Boolean = False;
                                                 MultiRefOpt: TObjMultiOptions = ocDefault);
var
  Index: Integer;
  Found: Boolean;
  AppURI: WideString;
begin
  Lock;
  try
    Index := GetEntry(AClass.ClassInfo, Found, Name);
    if not Found then
    begin
      if AppNameSpacePrefix <> '' then
        AppURI := AppNameSpacePrefix + '-';
      if URI = '' then
        URIMap[Index].URI := 'urn:' + AppURI + GetTypeData(AClass.ClassInfo).UnitName { do not localize }
      else
        URIMap[Index].URI := URI;
      if Name <> '' then
        URIMap[Index].Name := Name
      else
      begin
        URIMap[Index].Name := AClass.ClassName;
      end;
      URIMap[Index].ExtName := ExtName;
      URIMap[Index].ClassType := AClass;
      URIMap[Index].Info := AClass.ClassInfo;
      URIMap[Index].IsScalar := IsScalar;
      URIMap[Index].MultiRefOpt := MultiRefOpt;
    end;
  finally
    UnLock;
  end;
end;

procedure TRemotableTypeRegistry.RegisterXSInfo(Info: PTypeInfo; const URI: WideString = '';
                                                const Name: WideString = '';
                                                const ExtName: WideString = '');
var
  Index: Integer;
  Found: Boolean;
  AppURI: WideString;
  UnitName: string;

  function GetEnumUnitName(Info: PTypeInfo): string;
  var
    P: ^ShortString;
    T: PTypeData;
    Size: Integer;
  begin
    T := GetTypeData(GetTypeData(Info)^.BaseType^);
    P := @T^.NameList;
    Size := T.MaxValue - T.MinValue;
    while Size >= 0  do
    begin
      Inc(Integer(P), Length(P^) + 1);
      Dec(Size);
    end;
    Result := P^;
  end;

begin
  Lock;
  try
    { NOTE: Here we'll allow one (TypeInfo) type to map to many XML Types -
            For example, 'anyType' and 'anySimple' types both map to Variant.
            However, the first one registered will be the one under which
            the native type will be published!! }
    Index := GetEntry(Info, Found, Name);
    if Found then
      Exit;
    if AppNameSpacePrefix <> '' then
      AppURI := AppNameSpacePrefix + '-';
    if URI = '' then
    begin
      if Info.Kind = tkDynArray then
      begin
        UnitName := GetTypeData(Info).DynUnitName;
        URIMap[Index].URI := 'urn:' + AppURI +  UnitName;
      end
      else if Info.Kind = tkEnumeration then
      begin
        UnitName := GetEnumUnitName(Info);
        URIMap[Index].URI := 'urn:' + AppURI +  UnitName;
      end
      else if Info.Kind = tkClass then
        URIMap[Index].URI := 'urn:' + AppURI + GetTypeData(Info).UnitName
      else
        URIMap[Index].URI := 'urn:' + AppURI;
    end
    else
      URIMap[Index].URI := URI;
    if Name <> '' then
      URIMap[Index].Name := Name
    else
    begin
      URIMap[Index].Name := Info.Name;
    end;
    URIMap[Index].ExtName := ExtName;
    URIMap[Index].Info := Info;
    if Info.Kind = tkClass then
      URIMap[Index].ClassType := GetTypeData(Info).ClassType;
  finally
    UnLock;
  end;
end;

procedure TRemotableTypeRegistry.RegisterHolderClsMember(ClsTypeInfo: PTypeInfo; const URI: WideString = ''; const Name: WideString = ''; const ExtName: WideString = '');
var
  MemberInfo: PTypeInfo;
begin
  MemberInfo := GetClsMemberTypeInfo(ClsTypeInfo);
  if MemberInfo <> nil then
    RegisterXSInfo(MemberInfo, URI, Name, ExtName);
end;

procedure TRemotableTypeRegistry.DeleteEntryFromURIMap(Info: PTypeInfo);
var
  I, Index: Integer;
  Found: Boolean;
begin
  Lock;
  try
    Index := GetEntry(Info, Found);
    if Found then
    begin
      for I := Index to Length(URIMap)-2 do
        URIMap[I] := URIMap[I+1];
    end;
    SetLength(URIMap, Length(URIMap) -1);
  finally
    UnLock;
  end;
end;

procedure TRemotableTypeRegistry.UnRegisterXSClass(AClass: TClass);
begin
  DeleteEntryFromURIMap(AClass.ClassInfo);
end;

procedure TRemotableTypeRegistry.UnRegisterXSInfo(Info: PTypeInfo);
begin
  DeleteEntryFromURIMap(Info);
end;

function TRemotableTypeRegistry.IsClassScalar(AClass: TClass): Boolean;
var
  I: Integer;
begin
  Result := False;
  Lock;
  try
    for I := 0 to Length(URIMap) - 1 do
    begin
      if URIMap[I].ClassType = AClass then
      begin
        Result := URIMap[I].IsScalar;
        break;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TRemotableTypeRegistry.ClassOptions(AClass: TClass): TObjMultiOptions;
var
  I: Integer;
begin
  Result := ocDefault;
  Lock;
  try
    for I := 0 to Length(URIMap) - 1 do
    begin
      if URIMap[I].ClassType = AClass then
      begin
        Result := URIMap[I].MultiRefOpt;
        break;
      end;
    end;
  finally
    UnLock;
  end;
end;

procedure TRemotableTypeRegistry.RegisterSerializeOptions(Info: PTypeInfo; SerialOpt: TSerializationOptions);
var
  I: Integer;
begin
  Lock;
  try
    for I := 0 to Length(URIMap) - 1 do
    begin
      if URIMap[I].Info = Info then
      begin
        URIMap[I].SerializationOpt := SerialOpt;
        break;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TRemotableTypeRegistry.SerializeOptions(Info: PTypeInfo): TSerializationOptions;
var
  I: Integer;
begin
  Result := [];
  Lock;
  try
    for I := 0 to Length(URIMap) - 1 do
    begin
      if URIMap[I].Info = Info then
      begin
        Result := URIMap[I].SerializationOpt;
        break;
      end;
    end;
  finally
    UnLock;
  end;
end;

procedure TRemotableTypeRegistry.RegisterSerializeOptions(AClass: TClass; SerialOpt: TSerializationOptions);
begin
  RegisterSerializeOptions(AClass.ClassInfo, SerialOpt);
end;

function TRemotableTypeRegistry.SerializeOptions(AClass: TClass): TSerializationOptions;
begin
  Result := SerializeOptions(AClass.ClassInfo);
end;

procedure TRemotableTypeRegistry.RegisterExternalPropName(Info: PTypeInfo; const InternalName: string; const ExternalName: InvString);
var
  Index: Integer;
  Found: Boolean;
  Len: Integer;
begin
  Lock;
  try
    Index := FindEntry(Info, Found);
    if Found then
    begin
      Len := Length(URIMap[Index].PropNameMap);
      SetLength(URIMap[Index].PropNameMap, Len+1);
      URIMap[Index].PropNameMap[Len].Name := InternalName;
      URIMap[Index].PropNameMap[Len].ExtName := ExternalName;
    end;
  finally
    UnLock;
  end;
end;

function TRemotableTypeRegistry.GetExternalPropName(Info: PTypeInfo; InternalName: string): InvString;
var
  Index: Integer;
  Found: Boolean;
  Len, I: Integer;
begin
  Result := InternalName;
  Lock;
  try
    Index := FindEntry(Info, Found);
    if Found then
    begin
      Len := Length(URIMap[Index].PropNameMap);
      for I := 0 to Len-1 do
      begin
        if URIMap[Index].PropNameMap[I].Name = InternalName then
        begin
          Result := URIMap[Index].PropNameMap[I].ExtName;
          Exit
        end;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TRemotableTypeRegistry.GetInternalPropName(Info: PTypeInfo; ExternalName: InvString): string;
var
  Index: Integer;
  Found: Boolean;
  Len, I: Integer;
begin
  Result := ExternalName;
  Lock;
  try
    Index := FindEntry(Info, Found);
    if Found then
    begin
      Len := Length(URIMap[Index].PropNameMap);
      for I := 0 to Len-1 do
      begin
        if URIMap[Index].PropNameMap[I].ExtName = ExternalName then
        begin
          Result := URIMap[Index].PropNameMap[I].Name;
          Exit
        end;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TRemotableTypeRegistry.URIToInfo(const URI,
  Name: WideString): PTypeInfo;
var
  I: Integer;
begin
  Result := nil;
  Lock;
  try
    for I := 0 to Length(URIMap) - 1 do
    begin
      if (URIMap[I].URI = URI) and (URIMap[I].Name = Name) then
      begin
        Result := URIMap[I].Info;
        break;
      end;
    end;
  finally
    UnLock;
  end;
end;

procedure TRemotableTypeRegistry.GetXSDInfoForClass(Info: PTypeInfo; var URI, TypeName: WideString);
var
  AClass: TClass;
begin
  AClass := GetTypeData(Info).ClassType;
  ClassToURI(AClass, URI, TypeName);
end;

function TRemotableTypeRegistry.GetRegisteredClassForBuiltInXSD(const TypeName: WideString): TClass;
var
  IsScalar: Boolean;
begin
  Result := RemClassRegistry.URIToClass(XMLSchemaNameSpace, TypeName, IsScalar);
end;

function  TRemotableTypeRegistry.GetSimpleBuiltInXSDType(const URI, TypeName: WideString): PTypeInfo;
var
  I: Integer;
begin
  Result := nil;
  Lock;
  try
    for I := 0 to Length(URIMap) -1 do
    begin
      if (URIMap[I].URI = URI) and (URIMap[I].Name = TypeName) then
      begin
        Result := URIMap[I].Info;
        break;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TRemotableTypeRegistry.XSDToTypeInfo(const URI, TypeName: WideString): PTypeInfo;
var
  AClass, BuiltinClass: TClass;
  IsScalar: Boolean;
  I: Integer;

  function IsBase64TypeName(TypeName: InvString): Boolean;
  var
    J: Integer;
  begin
    Result := False;
    for J := Low(XMLBase64Types) to High(XMLBase64Types) do
      if TypeName = XMLBase64Types[J] then
      begin
        Result := True;
        break;
      end;
  end;
begin
  Result := nil;
  if URI = XMLSchemaNameSpace then
  begin
    { First check if a registered class overrides default mapping }
    BuiltinClass := GetRegisteredClassForBuiltInXSD(TypeName);
    if BuiltinClass <> nil then
      Result := BuiltinClass.ClassInfo;
    { If not, check default mapping }
    if Result = nil then
      Result := GetSimpleBuiltInXSDType(URI, TypeName);
      if (Result = nil) and IsBase64TypeName(TypeName) then
        for I := Low(XMLBase64Types) to High(XMLBase64Types) do
        begin
          Result := GetSimpleBuiltInXSDType(URI, XMLBase64Types[I]);
          if Result <> nil then
            break;
        end;
  end else
  begin
    AClass := RemClassRegistry.URIToClass(URI, TypeName, IsScalar);
    if AClass <> nil then
    begin
      Result := AClass.ClassInfo;
      Exit;
    end;
    if AClass = nil then
    begin
      Result := RemClassRegistry.URIToInfo(URI, TypeName);
    end;
  end;
end;

function TRemotableTypeRegistry.VariantToInfo(const V: Variant; TryAllSchema: Boolean): PTypeInfo;
var
 I: Integer;
begin
  case VarType(V) and VarTypeMask of
    varEmpty,
    varNull:
      raise ETypeRegistryException.CreateFmt(SUnsupportedVariant, [VarType(V)]);
    varSmallint:
      Result := TypeInfo(System.SmallInt);
    varInteger:
      Result := TypeInfo(System.Integer);
    varSingle:
      Result := TypeInfo(System.Single);
    varDouble,
    varCurrency:
      Result := TypeInfo(System.Double);
    varDate:
      begin
        Result := RemClassRegistry.URIToInfo(XMLSchemaNameSpace, 'dateTime'); { do not localize }
        if Result = nil then
        begin
          for I := Low(XMLSchemaNamepspaces) to High(XMLSchemaNamepspaces) do
          begin
            Result := RemClassRegistry.URIToInfo(XMLSchemaNamepspaces[I], 'dateTime');
            if Result <> nil then
              break;
          end;
        end;
      end;
    varOleStr:
      Result := TypeInfo(System.WideString);
    varDispatch:
      raise ETypeRegistryException.Create(SNoVarDispatch);
    varError:
      raise ETypeRegistryException.Create(SNoErrorDispatch);
    varBoolean:
      Result := TypeInfo(System.Boolean);
    varVariant:
      Result := TypeInfo(System.Variant);
    varUnknown:
      raise ETypeRegistryException.Create(SUnsupportedVariant);
    varShortInt:
      Result := TypeInfo(System.ShortInt);
    varByte:
      Result := TypeInfo(System.Byte);
    varWord:
      Result := TypeInfo(System.Word);
    varLongWord:
      Result := TypeInfo(System.LongWord);
    varInt64:
      Result := TypeInfo(System.Int64);
    varString:
      Result := TypeInfo(System.WideString);
    else
      raise ETypeRegistryException.CreateFmt(SUnsupportedVariant, [VarType(V)]);
  end;
end;

function TRemotableTypeRegistry.GetVarTypeFromXSD(const URI,
  TypeName: InvString): TVarType;
var
  Info: PTypeInfo;
begin
  Result := varUnknown;
  Info := XSDToTypeInfo(URI, TypeName);
  case Info.Kind of
    tkInteger:
      Result := varInteger;
    tkFloat:
      Result := varDouble;
    tkInt64:
      Result := varInt64;
    tkChar,
    tkWChar,
    tkWString,
    tkString,
    tkLString:
      Result := varOleStr;
  end;
end;

function TRemotableClassRegistry.GetEntry(Info: PTypeInfo; var Found: Boolean; const Name: WideString): Integer;
begin
  Result := FindEntry(Info, Found, Name);
  if not Found then
    SetLength(URIMap, Result + 1);
end;

function TRemotableClassRegistry.FindEntry(Info: PTypeInfo; var Found: Boolean; const Name: WideString): Integer;
begin
  Result := 0;
  Found := False;
  while Result < Length(URIMap) do
  begin
    if (Info <> nil) and (URIMap[Result].Info = Info) then
    begin
      if (Name = '') or (URIMap[Result].Name = Name) then
      begin
        Found := True;
        Exit;
      end;
    end;
    Inc(Result);
  end;
end;

function TRemotableTypeRegistry.URIToClass(const URI, Name: WideString): TClass;
var
  IsScalar: Boolean;
begin
  Result := URIToClass(URI, Name, IsScalar);
end;

function TRemotableTypeRegistry.URIToClass(const URI, Name: WideString; var IsScalar: Boolean): TClass;
var
  I: Integer;
begin
  Result := nil;
  Lock;
  try
    for I := 0 to Length(URIMap) - 1 do
    begin
      if (URIMap[I].URI = URI) and (URIMap[I].Name = Name) then
      begin
        Result := URIMap[I].ClassType;
        IsScalar := URIMap[I].IsScalar;
        break;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TRemotableClassRegistry.InfoToURI(Info: PTypeInfo; var URI,
  Name: WideString; var IsScalar: Boolean; tryToRegister: Boolean): Boolean;
var
  I: Integer;
begin
  Result := False;
  Lock;
  try
    if Info <> nil then
    begin
      { Look for an exact match first  }
      for I := 0 to Length(URIMap)-1 do
      begin
        if (URIMap[I].Info = Info) then
        begin
          URI := URIMap[I].URI;
          Name :=  URIMap[I].Name;
          IsScalar := URIMap[I].IsScalar;
          Result := True;
          break;
        end;
      end;
      { Look for an equivalent match }
      if not Result then
      begin
        for I := 0 to Length(URIMap) - 1 do
        begin
          if SameTypeInfo(URIMap[I].Info, Info) then
          begin
            URI := URIMap[I].URI;
            Name :=  URIMap[I].Name;
            IsScalar := URIMap[I].IsScalar;
            Result := True;
            break;
          end;
        end;
      end;        
    end;
  finally
    UnLock;
  end;
  if (Result = false) and (FAutoRegister) and (tryToRegister) then
  begin
    RegisterXSInfo(Info);
    Result := InfoToURI(Info, URI, Name, IsScalar, False);
  end;
end;

function TRemotableTypeRegistry.ClassToURI(AClass: TClass; var URI,  Name: WideString): Boolean;
var
  IsScalar: Boolean;
begin
  Result := ClassToURI(AClass, URI, Name, IsScalar);
end;

function TRemotableTypeRegistry.ClassToURI(AClass: TClass; var URI,
  Name: WideString; var IsScalar: Boolean; tryToRegister: Boolean): Boolean;
var
  I: Integer;
begin
  Result := False;
  Lock;
  try
    for I := 0 to Length(URIMap)- 1 do
      if URIMap[I].ClassType = AClass  then
      begin
        URI := URIMap[I].URI;
        if URIMap[I].ExtName <> '' then
          Name := URIMap[I].ExtName
        else
          Name := URIMap[I].Name;
        IsScalar := URIMap[I].IsScalar;
        Result := True;
        break;
      end;
  finally
    UnLock;
  end;
  if (Result = False) and (FAutoRegister) and (tryToRegister) then
  begin
    RegisterXSClass(AClass);
    Result := ClassToURI(AClass, URI, Name, IsScalar, False);
  end;
end;

function TRemotableClassRegistry.TypeInfoToXSD(Info: PTypeInfo; var URI,
  TypeName: WideString): Boolean;
var
  IsScalar: Boolean;
begin
  if Info.Kind = tkClass then
    Result := ClassToURI(GetTypeData(Info).ClassType, URI, TypeName, IsScalar)
  else
    Result := InfoToURI(Info, URI, TypeName, IsScalar);
end;

{ ERemotableException }

constructor ERemotableException.Create;
begin
  inherited Create('');
end;

constructor ERemotableException.Create(const Msg: string;
                                       const AFaultCode: WideString;
                                       const AFaultActor: WideString);
begin
  inherited Create(Msg);
  FFaultCode := AFaultCode;
  FFaultActor:= AFaultActor;
end;

{ TDataContext }

procedure TDataContext.SetDataPointer(Index: Integer; P: Pointer);
begin
  DataP[Index] := P;
end;

function TDataContext.GetDataPointer(Index: Integer): Pointer;
begin
  Result := DataP[Index];
end;

procedure TDataContext.AddVariantToClear(P: PVarData);
var
  I: Integer;
begin
  for I := 0 to Length(VarToClear) -1 do
    if VarToClear[I] = P then
      Exit;
  I := Length(VarToClear);
  SetLength(VarToClear, I + 1);
  VarToClear[I] := P;
end;

procedure TDataContext.AddStrToClear(P: Pointer);
var
  I: Integer;
begin
  { If this string is in the list already, we're set }
  for I := 0 to Length(StrToClear) -1 do
    if StrToClear[I] = P then
      Exit;
  I := Length(StrToClear);
  SetLength(StrToClear, I + 1);
  StrToClear[I] := P;
end;

procedure TDataContext.AddWStrToClear(P: Pointer);
var
  I: Integer;
begin
  { If this WideString is in the list already, we're set }
  for I := 0 to Length(WStrToClear) -1 do
    if WStrToClear[I] = P then
      Exit;
  I := Length(WStrToClear);
  SetLength(WStrToClear, I + 1);
  WStrToClear[I] := P;
end;

constructor TDataContext.Create;
begin
  inherited;
end;

destructor TDataContext.Destroy;
var
  I: Integer;
  P: Pointer;
begin
  { Clean up objects we've allocated }
  for I := 0 to Length(FObjsToDestroy) - 1 do
  begin
     if (FObjsToDestroy[I] <> nil) and (FObjsToDestroy[I].InheritsFrom(TRemotable)) then
     begin
       TRemotable(FObjsToDestroy[I]).Free;
     end;
  end;
  SetLength(FObjsToDestroy, 0);

  { Clean Variants we allocated }
  for I := 0 to Length(VarToClear) - 1 do
  begin
    if Assigned(VarToClear[I]) then
      Variant( PVarData(VarToClear[I])^) := NULL;
  end;
  SetLength(VarToClear, 0);

  { Clean up dynamic arrays we allocated }
  for I := 0 to Length(DynArrayToClear) - 1 do
  begin
    if Assigned(DynArrayToClear[I].P) then
    begin
      P := Pointer( PInteger(DynArrayToClear[I].P)^);
      DynArrayClear(P, DynArrayToClear[I].Info)
    end;
  end;
  SetLength(DynArrayToClear, 0);

  { Clean up strings we allocated }
  for I := 0 to Length(StrToClear) - 1 do
  begin
    if Assigned(StrToClear[I]) then
      PString(StrToClear[I])^ := '';
  end;
  SetLength(StrToClear, 0);

  { Clean up WideStrings we allocated }
  for I := 0 to Length(WStrToClear) - 1 do
  begin
    if Assigned(WStrToClear[I]) then
      PWideString(WStrToClear[I])^ := '';
  end;
  SetLength(WStrToClear, 0);

  inherited;
end;

procedure TDataContext.AddDynArrayToClear(P: Pointer; Info: PTypeInfo);
var
  I: Integer;
begin
  for I := 0 to Length(DynArrayToClear) -1 do
    if DynArrayToClear[I].P = P then
      Exit;
  I := Length(DynArrayToClear);
  SetLength(DynArrayToClear, I + 1);
  DynArrayToClear[I].P := P;
  DynArrayToClear[I].Info := Info;
end;

procedure TDataContext.AddObjectToDestroy(Obj: TObject);
var
  Index, EmptySlot: Integer;
begin
  EmptySlot := -1;
  for Index := 0 to Length(FObjsToDestroy) -1 do
  begin
    if FObjsToDestroy[Index] = Obj then
      Exit;
    if FObjsToDestroy[Index] = nil then
      EmptySlot := Index;
  end;
  if EmptySlot <> -1 then
  begin
    FObjsToDestroy[EmptySlot] := Obj;
    Exit;
  end;
  Index := Length(FObjsToDestroy);
  SetLength(FObjsToDestroy, Index + 1);
  FObjsToDestroy[Index] := Obj;
end;

procedure TDataContext.RemoveObjectToDestroy(Obj: TObject);
var
  I: Integer;
begin
  I := 0;
  while I < Length(FObjsToDestroy) do
  begin
    if FObjsToDestroy[I] = Obj then
    begin
      FObjsToDestroy[I] := nil;
      break;
    end;
    Inc(I);
  end;
end;

function TDataContext.AllocData(Size: Integer): Pointer;
begin
  Result := @Data[DataOffset];
  Inc(DataOffset, Size);
end;

{ TInvContext }

const
  MAXINLINESIZE = sizeof(TVarData) + 4;

procedure TInvContext.SetMethodInfo(const MD: TIntfMethEntry);
begin
  SetLength(DataP, MD.ParamCount + 1);
  SetLength(Data, (MD.ParamCount + 1) * MAXINLINESIZE);
end;

procedure TInvContext.SetParamPointer(Param: Integer; P: Pointer);
begin
   SetDataPointer(Param,  P);
end;

function TInvContext.GetParamPointer(Param: Integer): Pointer;
begin
  Result := GetDataPointer(Param);
end;

function TInvContext.GetResultPointer: Pointer;
begin
  Result := ResultP;
end;

procedure TInvContext.SetResultPointer(P: Pointer);
begin
  ResultP := P;
end;

procedure TInvContext.AllocServerData(const MD: TIntfMethEntry);
var
  I: Integer;
  Info: PTypeInfo;
  P: Pointer;
begin
  for I := 0 to MD.ParamCount - 1 do
  begin
    P := AllocData(GetTypeSize(MD.Params[I].Info));
    SetParamPointer(I, P);
    if MD.Params[I].Info.Kind = tkVariant then
    begin
      Variant(PVarData(P)^) := NULL;
      AddVariantToClear(PVarData(P));
    end else if MD.Params[I].Info.Kind = tkDynArray then
    begin
      AddDynArrayToClear(P, MD.Params[I].Info);
    end else if MD.Params[I].Info.Kind = tkLString then
    begin
      PString(P)^ := '';
      AddStrToClear(P);
    end else if MD.Params[I].Info.kind = tkWString then
    begin
      PWideString(P)^ := '';
      AddWStrToClear(P);
    end;
  end;
  if MD.ResultInfo <> nil then
  begin
    Info := MD.ResultInfo;
    case Info^.Kind of
      tkLString:
        begin
          P := AllocData(sizeof(PString));
          PString(P)^ := '';
          AddStrToClear(P);
        end;
      tkWString:
        begin
          P := AllocData(sizeof(PWideString));
          PWideString(P)^ := '';
          AddWStrToClear(P);
        end;
      tkInt64:
        P := AllocData(sizeof(Int64));
      tkVariant:
        begin
          P := AllocData(sizeof(TVarData));
          Variant( PVarData(P)^ ) := NULL;
          AddVariantToClear(PVarData(P));
        end;
      tkDynArray:
        begin
          P := AllocData(GetTypeSize(Info));
          AddDynArrayToClear(P, MD.ResultInfo);
        end;
      else
        P := AllocData(GetTypeSize(Info));
    end;
    SetResultPointer(P);
  end;
end;

procedure InitBuiltIns;
begin
  { DO NOT LOCALIZE }
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Boolean), XMLSchemaNameSpace, 'boolean');

  RemClassRegistry.RegisterXSInfo(TypeInfo(System.ShortInt), XMLSchemaNameSpace, 'byte');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Byte), XMLSchemaNameSpace, 'unsignedByte');

  RemClassRegistry.RegisterXSInfo(TypeInfo(System.SmallInt), XMLSchemaNameSpace, 'short');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Word), XMLSchemaNameSpace, 'unsignedShort');

  RemClassRegistry.RegisterXSInfo(TypeInfo(System.LongWord), XMLSchemaNameSpace, 'unsignedInt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Cardinal), XMLSchemaNameSpace, 'unsignedInt');

  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Integer), XMLSchemaNameSpace, 'int');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.LongInt), XMLSchemaNameSpace, 'int');

  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Int64), XMLSchemaNameSpace, 'long');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Int64), XMLSchemaNameSpace, 'unsignedLong');

  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Single), XMLSchemaNameSpace, 'float');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Double), XMLSchemaNameSpace, 'double');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Extended), XMLSchemaNameSpace, 'double');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Currency), XMLSchemaNameSpace, 'double');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Comp), XMLSchemaNameSpace, 'double');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Real), XMLSchemaNameSpace, 'double');

  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'string');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.WideString), XMLSchemaNameSpace, 'string');

  { Other types that we map to string with no validation }
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'anyURI');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'ENTITY');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'ENTITIES');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'gDay');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'gMonth');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'gMonthDay');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'gYear');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'gYearMonth');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'ID');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'IDREF');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'IDREFS');
   RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace,'language');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'Name');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'NMTOKEN');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'NMTOKENS');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'normalizedString');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'NOTATION');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'NCName');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'QName');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'token');

  { Native Types that map to XML string }
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.ShortString), XMLSchemaNameSpace, 'string');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiChar), XMLSchemaNameSpace, 'string');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.WideChar), XMLSchemaNameSpace, 'string');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Char), XMLSchemaNameSpace, 'string');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.WideChar), XMLSchemaNameSpace, 'string');

  RemClassRegistry.RegisterXSInfo(TypeInfo(Types.TByteDynArray), XMLSchemaNameSpace, 'base64Binary');

  { Whether we register 'anyType' or 'anySimpleType first determines how we expose Variants -
    we'll opt for anyType as it seems to be the most interoperable although anySimpleType
    is the better semantic match }
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Variant), XMLSchemaNameSpace, 'anyType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Variant), XMLSchemaNameSpace, 'anySimpleType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Variant), XMLSchemaNameSpace, 'ur-type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.OleVariant), XMLSchemaNameSpace, 'anyType');

  RemClassRegistry.RegisterXSInfo(TypeInfo(Types.TByteDynArray), SSoap11EncodingS5, 'base64');

  RemClassRegistry.RegisterXSInfo(TypeInfo(TIntegerDynArray), SBorlandTypeNamespace);
  RemClassRegistry.RegisterXSInfo(TypeInfo(TCardinalDynArray), SBorlandTypeNamespace);
  RemClassRegistry.RegisterXSInfo(TypeInfo(TWordDynArray), SBorlandTypeNamespace);
  RemClassRegistry.RegisterXSInfo(TypeInfo(TSmallIntDynArray), SBorlandTypeNamespace);
  RemClassRegistry.RegisterXSInfo(TypeInfo(TByteDynArray), SBorlandTypeNamespace);
  RemClassRegistry.RegisterXSInfo(TypeInfo(TShortIntDynArray), SBorlandTypeNamespace);
  RemClassRegistry.RegisterXSInfo(TypeInfo(TInt64DynArray), SBorlandTypeNamespace);
  RemClassRegistry.RegisterXSInfo(TypeInfo(TLongWordDynArray), SBorlandTypeNamespace);
  RemClassRegistry.RegisterXSInfo(TypeInfo(TSingleDynArray), SBorlandTypeNamespace);
  RemClassRegistry.RegisterXSInfo(TypeInfo(TDoubleDynArray), SBorlandTypeNamespace);
  RemClassRegistry.RegisterXSInfo(TypeInfo(TBooleanDynArray), SBorlandTypeNamespace);
  RemClassRegistry.RegisterXSInfo(TypeInfo(TStringDynArray), SBorlandTypeNamespace);
  RemClassRegistry.RegisterXSInfo(TypeInfo(TWideStringDynArray), SBorlandTypeNamespace);

  { NOTE: TSOAPAttachment is flagged as never Multiref'ed - very important!! }
  RemClassRegistry.RegisterXSClass(TSOAPAttachment, XMLSchemaNamespace, 'base64Binary', '', False, ocNoMultiRef);
  RemClassRegistry.RegisterXSClass(TSOAPAttachment, SBorlandTypeNamespace, 'TSOAPAttachment', '', False, ocNoMultiRef);
end;

procedure InitMoreBuiltIns;
begin
  { DO NOT LOCALIZE }
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.TDateTime), XMLSchemaNameSpace, 'dateTime');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.ByteBool), XMLSchemaNameSpace, 'boolean');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.WordBool), XMLSchemaNameSpace, 'boolean');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.LongBool), XMLSchemaNameSpace, 'boolean');
end;

procedure InitIR;
begin
  InvRegistryV := TInvokableClassRegistry.Create;
  RemTypeRegistryV := TRemotableClassRegistry.Create;
  RemClassRegistryV:= RemTypeRegistry;
  InitBuiltIns;
  InitXSTypes;
  InitMoreBuiltIns;
end;

function InvRegistry: TInvokableClassRegistry;
begin
  if not Assigned(InvRegistryV) then
    InitIR;
  Result :=  InvRegistryV;
end;

function RemClassRegistry: TRemotableClassRegistry;
begin
  if not Assigned(RemTypeRegistryV) then
    InitIR;
  Result := RemTypeRegistryV;
end;

function RemTypeRegistry: TRemotableTypeRegistry;
begin
  if not Assigned(RemTypeRegistryV) then
     InitIR;
  Result := RemTypeRegistryV;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Soap\InvokeRegistry.pas initialization enter'); {$EndIf}
  if not Assigned(InvRegistryV) then
    InitIR;
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Soap\InvokeRegistry.pas initialization leave'); {$EndIf}
finalization
  InvRegistryV.Free;
  RemClassRegistryV.Free;
end.

