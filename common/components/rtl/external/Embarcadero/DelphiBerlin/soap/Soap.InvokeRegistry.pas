{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                  SOAP Support                         }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{
  Central registry for interfaces with RTTI and the classes that implement them.
  Classes that are used as parameter types in methods of interfaces are registered
  in a separate registry.
}
unit Soap.InvokeRegistry;

{$IFNDEF VER150}
{$INCLUDE 'CompVer.inc'}
{$ENDIF}

{$IFDEF DIAMONDBACK_UP}
  {$DEFINE CLEANUP_SOAP_HEADERS}
{$ENDIF}

{$DEFINE EXPOSE_RESETMULTIREF}


{$IFDEF NO_SOAP_RUNTIME}
{ If SOAP components are not packaged }
(*$HPPEMIT '#pragma link "dclsoap.lib"' *)
{$ENDIF}

{$IFDEF MSWINDOWS}
{ SOAP/Windows is currently implemented with WININET }
 {$IFDEF WIN32}
  (*$HPPEMIT '#pragma link "wininet.lib"' *)
 {$ENDIF}
{$ENDIF}

(*$HPPEMIT '#if !defined(SOAP_REMOTABLE_CLASS)'                   *)
(*$HPPEMIT '#define SOAP_REMOTABLE_CLASS __declspec(delphiclass)' *)
(*$HPPEMIT '#endif'                                               *)
(*$HPPEMIT '                                                     '*)

interface

uses
  {$IFDEF POSIX}Posix.SysTypes,{$ENDIF}
  System.SysUtils, System.TypInfo, System.Classes, System.Generics.Collections,
  System.SyncObjs, Soap.IntfInfo, Soap.OpConvertOptions,
  XML.XMLSchema, XML.XmlIntf, XML.xmldom;

type

//{$DEFINE INVSTRING_AS_WIDESTRING}
{$IFDEF INVSTRING_AS_WIDESTRING}
  InvString = WideString;
{$ELSE}
  InvString = xml.xmldom.DOMString;
{$ENDIF}
  InvStringDynArray = array of InvString;

  TDataContext = class;

  ObjectConvertOptions = (ocoDontPrefixNode,
                          ocoDontSerializeProps,
                          ocoDontPutTypeAttr);
  TObjectConvertOptions= set of ObjectConvertOptions;

  TSOAPAttachment = class;

  IObjConverter = interface
  ['{7F67EA52-A3D1-429B-B54D-49F692B6131A}']
    function  ObjInstanceToSOAP(Instance: TObject; RootNode, ParentNode: IXMLNode;
                                const NodeName, NodeNamespace, ChildNamespace: InvString; ObjConvOpts: TObjectConvertOptions;
                                out RefID: InvString): IXMLNode;
    procedure InitObjectFromSOAP(Instance: TObject; RootNode, Node: IXMLNode);
    procedure AddAttachment(Attachment: TSOAPAttachment; const AContentId: string);
    function  FindAttachment(const AContentId: string): TSOAPAttachment;
{$IFDEF EXPOSE_RESETMULTIREF}
    procedure ResetMultiRef;
{$ENDIF}
    function GetOptions: TSOAPConvertOptions;
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
  SerializationOptions  = (xoHolderClass,
                           xoAttributeOnLastMember,
                           xoInlineArrays,
                           xoLiteralParam,
                           xoSimpleTypeWrapper,
                           xoOption6, xoOption7,
                           xoOption8, xoOption9,
                           xoOptionA, xoOptionB,
                           xoOptionC, xoOptionD,
                           xoOptionE, xoOptionF,
                           xoOptionG, xoOptionH, xoOptionI);
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
                            const NodeName, NodeNamespace, ChildNamespace: InvString; ObjConvOpts: TObjectConvertOptions;
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
    function  NativeToXS: InvString; virtual; abstract;
    procedure XSToNative(const Data: InvString); virtual; abstract;
    function  ObjectToSOAP(RootNode, ParentNode: IXMLNode;
                           const ObjConverter: IObjConverter;
                           const NodeName, NodeNamespace, ChildNamespace: InvString; ObjConvOpts: TObjectConvertOptions;
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
    FActor: InvString;
  public
    { Serialization routines }
    function   ObjectToSOAP(RootNode, ParentNode: IXMLNode;
                            const ObjConverter: IObjConverter;
                            const NodeName, NodeNamespace, ChildNamespace: InvString; ObjConvOpts: TObjectConvertOptions;
                            out RefID: InvString): IXMLNode; override;
    procedure  SOAPToObject(const RootNode, Node: IXMLNode; const ObjConverter: IObjConverter); override;

    property MustUnderstand: Boolean read FMustUnderstand write FMustUnderstand;
    property Actor: InvString read FActor write FActor;
  end;
  TSOAPHeaderClass = class of TSOAPHeader;

{$M+}
  { ERemotableException is the base class for handling fault packets with
    information in the <detail> nodes. It's also the base exception thrown
    when no suitable (registered) ERemotableException-derived class is found
    for a particular fault or when there is no <detail> node sent. }
  ERemotableException = class(Exception)
  private
    FFaultActor: InvString;
    FFaultCode: InvString;
    FFaultDetail: InvString;
    FFaultReasonLang: InvString;
    FFaultNode: InvString;
    FFaultRole: InvString;
    procedure SetFaultReason(const Value: InvString);
    function GetFaultReason: InvString;
  public
    constructor Create; overload;  virtual;
    constructor Create(const Msg: string;
                       const AFaultCode: InvString = '';
                       const AFaultActor: InvString = '';
                       const AFaultReasonLang: InvString = '';
                       const AFaultNode: InvString = '';
                       const AFaultRole: InvString = ''); overload; virtual;
    property FaultActor:      InvString read FFaultActor write FFaultActor;
    property FaultCode:       InvString read FFaultCode  write FFaultCode;
    property FaultDetail:     InvString read FFaultDetail write FFaultDetail;
    property FaultReason:     InvString read GetFaultReason write SetFaultReason;
    property FaultReasonLang: InvString read FFaultReasonLang write FFaultReasonLang;
    property FaultNode:       InvString read FFaultNode write FFaultNode;
    property FaultRole:       InvString read FFaultRole write FFaultRole;
  end;
{$M-}

  ERemotableExceptionClass = class of ERemotableException;

{ sender can specify FileName or TStream as source }
  TSOAPAttachment = class(TRemotable)
  private
    FCacheFile: string;            { used by attachment receiver to store data }
    FCacheFilePersist: Boolean;    { if true, don't delete cacehfile on close }
    FContentType: string;
    FEncoding: InvString;
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
                   AEncoding: InvString);

    { Serialization routines - Handle MIME Part I/O }
    function   ObjectToSOAP(RootNode, ParentNode: IXMLNode;
                            const ObjConverter: IObjConverter;
                            const NodeName, NodeNamespace, ChildNamespace: InvString; ObjConvOpts: TObjectConvertOptions;
                            out RefID: InvString): IXMLNode; override;
    procedure  SOAPToObject(const RootNode, Node: IXMLNode; const ObjConverter: IObjConverter); override;

    property CacheFile: string read FCacheFile;
    property CacheFilePersist: Boolean read FCacheFilePersist write FCacheFilePersist default False;
    property ContentType: string read FContentType write FContentType;
    property Encoding: InvString read FEncoding write FEncoding;
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
    FObjectList: TObjectList<TObject>;
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
    function  Get(const Name, URI: InvString): TSOAPHeader; overload;

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
    function  Get(const Name, URI: InvString): TSOAPHeader; overload;

    function  GetOwnsSentHeaders: Boolean;
    procedure SetOwnsSentHeaders(Flag: Boolean);
  end;

  TInvokableClass = class(TInterfacedObject, IInterface)
  protected
    FSOAPHeaders: TSOAPHeaders;
{$IFNDEF AUTOREFCOUNT}
    FRefCount: Integer;
{$ENDIF !AUTOREFCOUNT}
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
{$IFNDEF AUTOREFCOUNT}
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
{$ENDIF !AUTOREFCOUNT}
  public
    constructor Create; virtual;
{$IFDEF CLEANUP_SOAP_HEADERS}
    destructor Destroy; override;
{$ENDIF}
{$IFNDEF AUTOREFCOUNT}
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    property RefCount: Integer read FRefCount;
{$ENDIF !AUTOREFCOUNT}
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
    ExtName: InvString;    { Can use [key="value"] format }
  end;

  eHeaderMethodType = (hmtAll, hmtRequest, hmtResponse);

  THeaderMethodTypeArray = array of eHeaderMethodType;

  TRequiredArray = array of Boolean;

  IntfHeaderItem = record
    Info: PTypeInfo;
    ClassType: TClass;
    Namespace: InvString;                   { Header namespace }
    Name: InvString;                        { Header name }
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
                       ioDocument,              { Don't use section 5 encoding; use xml encoding }
                       ioLiteral,               { We have no wrapper elements }
                       ioHasDefaultSOAPAction,  { We have a default SOAP Action }
                       ioHasReturnParamNames,   { We have specific return parameter names }
                       ioHasNamespace,          { We have a namespace }
                       ioIsAppServerSOAP,       { The interface derives from IAppServerSOAP }
                       ioHasUDDIInfo,           { We have UDDI info, for fail-over lookup }
                       ioHasAllSOAPActions,     { Have all operation SOAPActions }
                       ioSOAP12                 { Use SOAP 1.2 for this interface }
                      );
  TIntfInvokeOptions= set of TIntfInvokeOption;

  ParameterMapItem = record
    Name: string;
    ExtName: InvString;
    Namespace: InvString;   { Can use [key="value"] format }
    XMLOptions: Integer;
  end;

  MethodMapItem = record
    Name: string;
    ExtName: InvString;
    ReturnName: InvString;  { Can use [key="value"] format }
    XMLOptions: Integer;
    Parameters: array of ParameterMapItem;
  end;

  InterfaceMapItem = record
    Name: string;                             { Native name of interface    }
    ExtName: InvString;                       { PortTypeName                }
    UnitName: string;                         { Filename of interface       }
    GUID: TGUID;                              { GUID of interface           }
    Info: PTypeInfo;                          { Typeinfo of interface       }
    DefImpl: TClass;                          { Metaclass of implementation }
    Namespace: InvString;                     { XML Namespace of type       }
    WSDLEncoding: InvString;                  { Encoding                    }
    Documentation: string;                    { Description of interface    }
    SOAPAction: string;                       { SOAPAction of interface     }
{$IFDEF WIDE_RETURN_NAMES}
    ReturnParamNames: InvString;              { Return Parameter names      }
{$ELSE}
    ReturnParamNames: string;                 { Return Parameter names      }
{$ENDIF}
    InvokeOptions: TIntfInvokeOptions;        { Invoke Options              }
    Methods: array of MethodMapItem;           { Method Info                }
    IntfHeaders: array of IntfHeaderItem;      { Headers                    }
    IntfExceptions: array of IntfExceptionItem;{ Exceptions                 }
    UDDIOperator: String;                      { UDDI Registry of this porttype }
    UDDIBindingKey: String;                    { UDDI Binding key           }
  end;
  TInterfaceMapItemArray = array of InterfaceMapItem;

  TInvokableClassRegistry = class
  private
    FCriticalSection: TCriticalSection;
    FRegClasses: array of InvRegClassEntry;
    FRegIntfs: array of InterfaceMapItem;
    procedure DeleteFromReg(AClass: TClass; Info: PTypeInfo);
    procedure InternalRegisterHeaderClass(Info: PTypeInfo; AClass: TClass;
              const HeaderName: InvString; const HeaderNamespace: InvString;
              DefaultMethodType: eHeaderMethodType; const MethodName: string = '';
              MethodType: eHeaderMethodType = hmtAll; Required: Boolean = False);
    procedure InternalRegisterException(Info: PTypeInfo; AClass: TClass; const MethodName: string);
    function  InternalGetHeaderName(const Item: IntfHeaderItem): InvString;
    function  InternalGetHeaderNamespace(const Item: IntfHeaderItem): InvString;
  public
    constructor Create;
    destructor Destroy; override;

    { Basic Invokable Interface Registration Routine }
    procedure RegisterInterface(Info: PTypeInfo; const Namespace: InvString = ''; const WSDLEncoding: InvString = ''; const Doc: string = ''; const ExtName: InvString = '');

    { Header registration }
    procedure RegisterHeaderClass(Info: PTypeInfo; AClass: TClass;
              const HeaderName: InvString; const HeaderNamespace: InvString;
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
    function GetHeaderName(Info: PTypeInfo; AClass: TClass): InvString;
    function GetHeaderNamespace(Info: PTypeInfo; AClass: TClass): InvString; overload;
    function GetHeaderNamespace(AClass: TClass): InvString; overload;
    function GetHeaderClass(Name, Namespace: InvString): TClass;

    { Exception Class registration }
    procedure RegisterException(Info: PTypeInfo; AClass: TClass);
    procedure RegisterExceptionMethod(Info: PTypeInfo; AClass: TClass; const MethodName: string);

    { Exception Access }
    function  GetExceptionInfoForInterface(Info: PTypeInfo): TExceptionItemArray;

    procedure RegisterInvokableClass(AClass: TClass; CreateProc: TCreateInstanceProc); overload;
    procedure RegisterInvokableClass(AClass: TClass); overload;

    { Parameter functions }
    procedure RegisterExternalParamName(Info: PTypeInfo; const MethodName, InternalName: string; const ExternalName: InvString);
    procedure RegisterParamInfo(Info: PTypeInfo; const MethodName, InternalParamName: string; const ExternalParamName, Namespace: InvString; XMLOptions: Integer = 0);
    procedure GetParamInfo(Info: PTypeInfo; const MethodName, InternalParamName: string; var ExternalParamName, Namespace: InvString; var XMLOptions: Integer);

    { Method functions }
    procedure RegisterExternalMethName(Info: PTypeInfo; const InternalName: string; const ExternalName: InvString);
    procedure RegisterMethodInfo(Info: PTypeInfo; const InternalName, ExternalName, ReturnName: string; XMLOptions: Integer = 0);
    procedure GetMethodInfo(Info: PTypeInfo; const InternalName: string; var ExternalName, ReturnName: string; var XMLOptions: Integer);

    { SOAPAction - related API }
    procedure RegisterDefaultSOAPAction(Info: PTypeInfo; const DefSOAPAction: InvString);
    procedure RegisterAllSOAPActions(Info: PTypeInfo; const AllSOAPActions: InvString);
    function  GetActionURIOfInfo(const IntfInfo: PTypeInfo; const MethodName: InvString; MethodIndex: Integer): string;
    function  GetActionURIOfIID(const AGUID: TGUID): string;

    { UDDI - related API }
    procedure RegisterUDDIInfo(Info: PTypeInfo; const Operator: String; const BindingKey: string);
    function  GetUDDIInfo(const IntfInfo: PTypeInfo; var Operator, BindingKey: string): Boolean; overload;
    function  GetUDDIInfo(const AGUID: TGUID; var Operator, BindingKey: string): Boolean; overload;

    procedure RegisterReturnParamNames(Info: PTypeInfo; const RetParamNames: InvString);
    function  GetReturnParamNames(const IntfInfo: PTypeInfo): InvString;

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
    function  GetRegInterfaceEntry(Index: Integer): InterfaceMapItem;
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
    Name: InvString;
    ExtName: InvString;
    URI: InvString;
  end;

  TObjMultiOptions = (ocDefault, ocMultiRef, ocNoMultiRef);
  TRemRegEntry = record
    ClassType: TClass;
    Info: PTypeInfo;
    URI: InvString;
    Name: InvString;
    ExtName: InvString;
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
    FCriticalSection: TCriticalSection;
    URIMAP:   array of TRemRegEntry;
    function  GetEntry(Info: PTypeInfo; var Found: Boolean; const Name: InvString=''): Integer;
    function  FindEntry(Info: PTypeInfo; var Found: Boolean; const Name: InvString=''): Integer;
    procedure DeleteEntryFromURIMap(Info: PTypeInfo);
    function  GetSimpleBuiltInXSDType(const URI, TypeName: InvString): PTypeInfo;
    function  GetRegisteredClassForBuiltInXSD(const TypeName: InvString): TClass;
  protected
    procedure Lock; virtual;
    procedure UnLock; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    { Remotable class registration }
    procedure RegisterXSClass(AClass: TClass; const URI: InvString = ''; const Name: InvString = '';
                              const ExtName: InvString = ''; IsScalar: Boolean = False;
                              MultiRefOpt: TObjMultiOptions = ocDefault);
    { TypeInfo registration }
    procedure RegisterXSInfo(Info: PTypeInfo; const URI: InvString = ''; const Name: InvString = ''; const ExtName: InvString = '');

    { TypeInfo registration via a Holder class }
    procedure RegisterHolderClsMember(ClsTypeInfo: PTypeInfo; const URI: InvString = ''; const Name: InvString = ''; const ExtName: InvString = '');

    { Query routines to conver Native Type to XML name and namespace }
    function  ClassToURI(AClass: TClass; var URI, Name: InvString; var IsScalar: Boolean; tryToRegister: Boolean = True): Boolean; overload;
    function  ClassToURI(AClass: TClass; var URI, Name: InvString): Boolean; overload;
    function  InfoToURI(Info: PTypeInfo; var URI, Name: InvString; var IsScalar: Boolean; tryToRegister: Boolean = True): Boolean;
    function  TypeInfoToXSD(Info: PTypeInfo; var URI, TypeName: InvString): Boolean;
    procedure GetXSDInfoForClass(Info: PTypeInfo; var URI, TypeName: InvString);

    { Query routines to convert XML name/namespace to Native TypeInfo }
    function  URIToClass(const URI, Name: InvString; var IsScalar: Boolean): TClass; overload;
    function  URIToClass(const URI, Name: InvString): TClass; overload;
    function  XSDToTypeInfo(const URI, TypeName: InvString): PTypeInfo;
    function  URIToInfo(const URI, Name: InvString): PTypeInfo;

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
    function  GetInternalPropName(Info: PTypeInfo; const ExternalName: InvString): string;

    { Flag to automatically register types }
    property AutoRegisterNativeTypes: Boolean read FAutoRegister write FAutoRegister;
  end;

  TRemotableClassRegistry       = TRemotableTypeRegistry;
  TPascalRemotableTypeRegistry  = TRemotableTypeRegistry;
  TPascalRemotableClassRegistry = TRemotableTypeRegistry;

{ Forward ref. structure to satisfy DynamicArray<Type>        }
{ encountered before declaration of Type itself in .HPP file  }
(*$HPPEMIT 'namespace Soap {'                                *)
(*$HPPEMIT ' namespace Invokeregistry {'                     *)
(*$HPPEMIT '  struct TDynToClear;'                           *)
(*$HPPEMIT ' };'                                             *)
(*$HPPEMIT '};'                                              *)
(*$HPPEMIT 'using Soap::Invokeregistry::TDynToClear;'        *)

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
{$IFNDEF NEXTGEN}
    StrToClear: array of Pointer;
    WStrToClear: array of Pointer;
{$ENDIF !NEXTGEN}
{$IFDEF UNICODE}
    UStrToClear: array of Pointer;
{$ENDIF}
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
{$IFNDEF NEXTGEN}
    procedure AddStrToClear(P: Pointer);
    procedure AddWStrToClear(P: Pointer);
{$ENDIF !NEXTGEN}
{$IFDEF UNICODE}
    procedure AddUStrToClear(P: Pointer);
{$ENDIF}
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

{$IFDEF NEXTGEN}
function  SubstituteStrings(const InputString: string;
                            const SubString: string;
                            const Replacement: string): string;
{$ELSE !NEXTGEN}
function  SubstituteStrings(const InputString: WideString;
                            const SubString: WideString;
                            const Replacement: WideString): WideString;
{$ENDIF NEXTGEN}
var
  AppNameSpacePrefix: string;

const
  XMLSchemaInstNamespaces: array[0..2] of InvString =
    (SXMLSchemaInstURI_1999, SXMLSchemaInstURI_2000_10, SXMLSchemaInstURI);

  XMLSchemaNamespaces: array[0..2] of InvString =
    (SXMLSchemaURI_1999, SXMLSchemaURI_2000_10, SXMLSchemaURI_2001);

  XMLBase64Types: array[0..1] of InvString = ('base64Binary', 'bin.base64');

  {
    'AS_ATTRIBUTE' is deprecated. The WSDL importer now uses the 'Index' value of
    property declarations instead of the 'stored' value to tag properties that map
    to XML attributes.
  }
  AS_ATTRIBUTE = False;

implementation

uses
  {$IFDEF MSWINDOWS}Winapi.Windows,{$ENDIF}
  {$IFDEF POSIX}Posix.Unistd,{$ENDIF}
  System.RTTI, System.Types, System.Variants,
  Soap.HTTPUtil, Soap.SOAPConst, Soap.XSBuiltIns;

var
  InvRegistryV: TInvokableClassRegistry;
  RemClassRegistryV: TRemotableClassRegistry;
  RemTypeRegistryV: TRemotableTypeRegistry;

threadvar
  RemotableDataContext: Pointer;

{$IFDEF NEXTGEN}
function  SubstituteStrings(const InputString: string; const SubString: string;
                            const Replacement: string): string;
{$ELSE !NEXTGEN}
function  SubstituteStrings(const InputString: WideString; const SubString: WideString;
                            const Replacement: WideString): WideString;
{$ENDIF NEXTGEN}
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

function TInvokableClassRegistry.GetRegInterfaceEntry(Index: Integer): InterfaceMapItem;
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
  FCriticalSection := TCriticalSection.Create;
end;

destructor TInvokableClassRegistry.Destroy;
begin
  FreeAndNil(FCriticalSection);
  inherited Destroy;
end;

procedure TInvokableClassRegistry.Lock;
begin
  FCriticalSection.Enter;
end;

procedure TInvokableClassRegistry.UnLock;
begin
  FCriticalSection.Leave;
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
          { NOTE: Don't replace an existing implementation           }
          {       This approach allows for better control over what  }
          {       class implements a particular interface            }
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
              const HeaderName: InvString; const HeaderNamespace: InvString;
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
              const HeaderName: InvString; const HeaderNamespace: InvString;
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
          Break;
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
          Break;
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

function TInvokableClassRegistry.InternalGetHeaderName(const Item:IntfHeaderItem): InvString;
var
  URI: InvString;
begin
  Result := Item.Name;
  if Result = '' then
  begin
    RemClassRegistry.ClassToURI(Item.ClassType, URI, Result);
  end;
end;

function TInvokableClassRegistry.InternalGetHeaderNamespace(const Item: IntfHeaderItem): InvString;
var
  Name: InvString;
begin
  Result := Item.Namespace;
  if Result = '' then
  begin
    RemClassRegistry.ClassToURI(Item.ClassType, Result, Name);
  end;
end;

function TInvokableClassRegistry.GetHeaderName(Info: PTypeInfo; AClass: TClass): InvString;
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

function TInvokableClassRegistry.GetHeaderNamespace(Info: PTypeInfo; AClass: TClass): InvString;
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

function TInvokableClassRegistry.GetHeaderNamespace(AClass: TClass): InvString;
var
  I, J: Integer;
  Name: InvString;
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

function TInvokableClassRegistry.GetHeaderClass(Name, Namespace: InvString): TClass;
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
        Break;
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
        Break;
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
var
  I: Integer;
begin
  { Remove class from any interfaces it was registered as default class }
  for I := 0 to Length(FRegIntfs) - 1 do
    if FRegIntfs[I].DefImpl = AClass then
      FRegIntfs[I].DefImpl := nil;

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

    GetIntfMetaData(Info, IntfMD, True);

    Index := Length(FRegIntfs);
    SetLength(FRegIntfs, Index + 1);
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

procedure TInvokableClassRegistry.RegisterReturnParamNames(Info: PTypeInfo; const RetParamNames: InvString);
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

{ calls to this method need to be within a Lock/try <here> finally/unlock block }
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
          Break;
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
          Break;
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
  I, J, Len: Integer;
begin
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
      if FRegIntfs[I].Info = Info then
      begin
        Len := Length(FRegIntfs[I].Methods);
        J := 0;
        while J < Len do
        begin
          if SameText(FRegIntfs[I].Methods[J].Name, InternalName) then
            Break;
          Inc(J);
        end;

        if J = Len then
        begin
          SetLength(FRegIntfs[I].Methods, J + 1);
          FRegIntfs[I].Methods[J].Name := InternalName;
        end;

        FRegIntfs[I].Methods[J].ExtName := ExternalName;
      end;
  finally
    Unlock;
  end;
end;

procedure TInvokableClassRegistry.RegisterMethodInfo(Info: PTypeInfo; const InternalName, ExternalName, ReturnName: string; XMLOptions: Integer = 0);
var
  I, J, Len: Integer;
begin
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
      if FRegIntfs[I].Info = Info then
      begin
        Len := Length(FRegIntfs[I].Methods);
        J := 0;
        while J < Len do
        begin
          if SameText(FRegIntfs[I].Methods[J].Name, InternalName) then
            Break;
          Inc(J);
        end;

        if J = Len then
        begin
          SetLength(FRegIntfs[I].Methods, J + 1);
          FRegIntfs[I].Methods[J].Name := InternalName;
        end;

        FRegIntfs[I].Methods[J].ExtName := ExternalName;
        FRegIntfs[I].Methods[J].ReturnName := ReturnName;
        FRegIntfs[I].Methods[J].XMLOptions := XMLOptions;
      end;
  finally
    Unlock;
  end;
end;

procedure TInvokableClassRegistry.GetMethodInfo(Info: PTypeInfo; const InternalName: string; var ExternalName, ReturnName: string; var XMLOptions: Integer);
var
  I, J: Integer;
begin
  ExternalName := InternalName;
  ReturnName := '';
  XMLOptions := 0;

  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
    begin
      if FRegIntfs[I].Info = Info then
      begin
        for J := 0 to Length(FRegIntfs[I].Methods) -1 do
        begin
          if SameText(FRegIntfs[I].Methods[J].Name, InternalName) then
          begin
            if FRegIntfs[I].Methods[J].ExtName <> '' then
              ExternalName := FRegIntfs[I].Methods[J].ExtName;
            ReturnName := FRegIntfs[I].Methods[J].ReturnName;
            XMLOptions := FRegIntfs[I].Methods[J].XMLOptions;
            Exit;
          end;
        end;
      end;
    end;
  finally
    Unlock;
  end;
end;

procedure TInvokableClassRegistry.RegisterExternalParamName(Info: PTypeInfo; const MethodName, InternalName: string; const ExternalName: InvString);
var
  I, J, K, Len: Integer;
begin
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
      if FRegIntfs[I].Info = Info then
      begin
        Len := Length(FRegIntfs[I].Methods);
        J := 0;
        while J < Len do
        begin
          if SameText(FRegIntfs[I].Methods[J].Name, MethodName) then
            Break;
          Inc(J);
        end;

        if J = Len then
        begin
          SetLength(FRegIntfs[I].Methods, J + 1);
          FRegIntfs[I].Methods[J].Name := MethodName;
        end;

        Len := Length(FRegIntfs[I].Methods[J].Parameters);
        K := 0;
        while K < Len do
        begin
          if SameText(FRegIntfs[I].Methods[J].Parameters[K].Name, InternalName) then
            Break;
          Inc(K);
        end;

        if K = Len then
        begin
          SetLength(FRegIntfs[I].Methods[J].Parameters, K + 1);
          FRegIntfs[I].Methods[J].Parameters[K].Name := InternalName;
        end;

        FRegIntfs[I].Methods[J].Parameters[K].ExtName := ExternalName;
        Break;
      end;
  finally
    Unlock;
  end;
end;

procedure TInvokableClassRegistry.RegisterParamInfo(Info: PTypeInfo; const MethodName, InternalParamName: string;
                                                    const ExternalParamName, Namespace: InvString; XMLOptions: Integer);
var
  I, J, K, Len: Integer;
begin
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
      if FRegIntfs[I].Info = Info then
      begin
        Len := Length(FRegIntfs[I].Methods);
        J := 0;
        while J < Len do
        begin
          if SameText(FRegIntfs[I].Methods[J].Name, MethodName) then
            Break;
          Inc(J);
        end;

        if J = Len then
        begin
          SetLength(FRegIntfs[I].Methods, J + 1);
          FRegIntfs[I].Methods[J].Name := MethodName;
        end;

        Len := Length(FRegIntfs[I].Methods[J].Parameters);
        K := 0;
        while K < Len do
        begin
          if SameText(FRegIntfs[I].Methods[J].Parameters[K].Name, InternalParamName) then
            Break;
          Inc(K);
        end;

        if K = Len then
        begin
          SetLength(FRegIntfs[I].Methods[J].Parameters, K + 1);
          FRegIntfs[I].Methods[J].Parameters[K].Name := InternalParamName;
        end;

        FRegIntfs[I].Methods[J].Parameters[K].ExtName := ExternalParamName;
        FRegIntfs[I].Methods[J].Parameters[K].Namespace := Namespace;
        FRegIntfs[I].Methods[J].Parameters[K].XMLOptions := FRegIntfs[I].Methods[J].Parameters[K].XMLOptions or XMLOptions;
        Break;
      end;
  finally
    Unlock;
  end;
end;

procedure TInvokableClassRegistry.GetParamInfo(Info: PTypeInfo; const MethodName, InternalParamName: string;
                                               var ExternalParamName, Namespace: InvString; var XMLOptions: Integer);
var
  I, J, K: Integer;
begin
  ExternalParamName := InternalParamName;
  Namespace := '';
  XMLOptions := 0;
  Lock;
  try
    for I := 0 to Length(FRegIntfs) - 1 do
    begin
      if FRegIntfs[I].Info = Info then
      begin
        for J := 0 to Length(FRegIntfs[I].Methods) -1 do
        begin
          if SameText(FRegIntfs[I].Methods[J].Name, MethodName) then
          begin
            for K := 0 to Length(FRegIntfs[I].Methods[J].Parameters) -1 do
            begin
              if SameText(FRegIntfs[I].Methods[J].Parameters[K].Name, InternalParamName) then
              begin
                if FRegIntfs[I].Methods[J].Parameters[K].ExtName <> '' then
                  ExternalParamName := FRegIntfs[I].Methods[J].Parameters[K].ExtName;
                Namespace := FRegIntfs[I].Methods[J].Parameters[K].Namespace;
                XMLOptions := FRegIntfs[I].Methods[J].Parameters[K].XMLOptions;
                Exit;
              end;
            end;
          end;
        end;
      end;
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
        for J := 0 to Length(FRegIntfs[I].Methods) -1 do
          if SameText(FRegIntfs[I].Methods[J].Name, MethodName) then
          begin
            for K := 0 to Length(FRegIntfs[I].Methods[J].Parameters) -1 do
              if SameText(FRegIntfs[I].Methods[J].Parameters[K].Name, InternalParamName) then
              begin
                if FRegIntfs[I].Methods[J].Parameters[K].ExtName <> '' then
                  Result := FRegIntfs[I].Methods[J].Parameters[K].ExtName;
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
        for J := 0 to Length(FRegIntfs[I].Methods) -1 do
          if SameText(FRegIntfs[I].Methods[J].Name, MethodName) then
          begin
            for K := 0 to Length(FRegIntfs[I].Methods[J].Parameters) -1 do
              if SameText(FRegIntfs[I].Methods[J].Parameters[K].ExtName, ExternalParamName) then
              begin
                if FRegIntfs[I].Methods[J].Parameters[K].Name <> '' then
                  Result := FRegIntfs[I].Methods[J].Parameters[K].Name;
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
        for J := 0 to Length(FRegIntfs[I].Methods) - 1 do
          if SameText(FRegIntfs[I].Methods[J].Name, MethodIntName) then
          begin
            if FRegIntfs[I].Methods[J].ExtName <> '' then
              Result := FRegIntfs[I].Methods[J].ExtName;
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
        for J := 0 to Length(FRegIntfs[I].Methods) -1 do
          if SameText(FRegIntfs[I].Methods[J].ExtName, MethodExtName) then
          begin
            if FRegIntfs[I].Methods[J].Name <> '' then
              Result := FRegIntfs[I].Methods[J].Name;
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

function TInvokableClassRegistry.GetActionURIOfInfo(const IntfInfo: PTypeInfo; const MethodName: InvString; MethodIndex: Integer): string;
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
          SOAPActions := StringToStringArray(FRegIntfs[I].SOAPAction, FRegIntfs[I].SOAPAction[Low(string)]);
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

function TInvokableClassRegistry.GetReturnParamNames(const IntfInfo: PTypeInfo): InvString;
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

  function MatchActionWithOpName(const ActionPrefix, SAPrefix: string): Boolean;
  var
    OpNamePos: Integer;
  begin
    OpNamePos := Pos('%operationName%', SAPrefix);
    Result := (OpNamePos > 1) and
              (Copy(SAPrefix, 1, OpNamePos-1) = Copy(ActionPrefix, 1, OpNamePos-1)) and
              IsValidIdent(Copy(ActionPrefix, OpNamePos, MaxInt));
  end;

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
      { Default SOAPAction has #%operationName% }
      Delete(SAPrefix, Pos('#', SAPrefix), Length(SAPrefix));           { Do not localize }

      { Get the Prefix of the SOAPAction passed in }
      ActionPrefix := ActionURI;
      if ActionPrefix[Low(string)] = '"' then
        Delete(ActionPrefix, 1, 1);
      if ActionPrefix[Length(ActionPrefix)]='"' then
        Delete(ActionPrefix, Length(ActionPrefix), 1);
      Delete(ActionPrefix, Pos('#', ActionPrefix), Length(ActionPrefix));

      if (ActionPrefix = SAPrefix) or
          MatchActionWithOpName(ActionPrefix, SAPrefix) then
      begin
        IntfInfo := FRegIntfs[I].Info;
        AClass := FRegIntfs[I].DefImpl;
        Result := True;
        Break;
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
        Break;
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
        Break;
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
        Break;
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

function TSOAPHeaders.Get(const Name, URI: InvString): TSOAPHeader;
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

{$IFDEF CLEANUP_SOAP_HEADERS}
destructor TInvokableClass.Destroy;
begin
  FSOAPHeaders.Free;
  inherited;
end;
{$ENDIF}

{$IFNDEF AUTOREFCOUNT}
procedure TInvokableClass.AfterConstruction;
begin
  { Release the constructor's implicit refcount }
  TInterlocked.Decrement(FRefCount);
end;

procedure TInvokableClass.BeforeDestruction;
begin
  if RefCount <> 0 then
    System.Error(reInvalidPtr);
end;
{$ENDIF !AUTOREFCOUNT}

{ Set an implicit refcount so that refcounting  }
{ during construction won't destroy the object. }
{$IFNDEF AUTOREFCOUNT}
class function TInvokableClass.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TInvokableClass(Result).FRefCount := 1;
end;
{$ENDIF !AUTOREFCOUNT}

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

{$IFNDEF AUTOREFCOUNT}
function TInvokableClass._AddRef: Integer;
begin
  Result := TInterlocked.Increment(FRefCount);
end;

function TInvokableClass._Release: Integer;
begin
  Result := TInterlocked.Decrement(FRefCount);
  if Result = 0 then
    Destroy;
end;
{$ENDIF !AUTOREFCOUNT}

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
                                 const NodeName, NodeNamespace, ChildNamespace: InvString; ObjConvOpts: TObjectConvertOptions;
                                 out RefID: InvString): IXMLNode;
begin
  Result := ObjConverter.ObjInstanceToSOAP(Self, RootNode, ParentNode, NodeName, NodeNamespace, ChildNamespace,
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
                                   const NodeName, NodeNamespace, ChildNamespace: InvString; ObjConvOpts: TObjectConvertOptions;
                                   out RefID: InvString): IXMLNode;
begin
  ObjConvOpts := ObjConvOpts + [ocoDontSerializeProps];
  Result := inherited ObjectToSOAP(RootNode, ParentNode, ObjConverter, NodeName, NodeNamespace, ChildNamespace, ObjConvOpts, RefID); ;
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
                                  const NodeName, NodeNamespace, ChildNamespace: InvString;
                                  ObjConvOpts: TObjectConvertOptions;
                                  out RefID: InvString): IXMLNode;
const
  BoolDigit: array[Boolean] of string = ('0', '1');
var
  HeaderNamespace: InvString;
begin
  ObjConvOpts := ObjConvOpts - [ocoDontPrefixNode];
  HeaderNamespace := InvRegistry.GetHeaderNamespace(Self.ClassType);
  Result := ObjConverter.ObjInstanceToSOAP(Self, RootNode, ParentNode, NodeName, HeaderNamespace, ChildNamespace,
                                           ObjConvOpts, RefID);
  if FMustUnderstand then
    Result.SetAttributeNS(SHeaderMustUnderstand, SoapEnvelopeNamespaces[soSOAP12 in ObjConverter.GetOptions], BoolDigit[FMustUnderstand]);
  if FActor <> '' then
    Result.SetAttributeNS(SHeaderActor, SoapEnvelopeNamespaces[soSOAP12 in ObjConverter.GetOptions], FActor);
end;

procedure TSOAPHeader.SOAPToObject(const RootNode, Node: IXMLNode;
                                  const ObjConverter: IObjConverter);
var
  AttrVal: string;
begin
  inherited SOAPToObject(RootNode, Node, ObjConverter);
  if Node.HasAttribute(SHeaderMustUnderstand, SoapEnvelopeNamespaces[soSOAP12 in ObjConverter.GetOptions]) then
  begin
    AttrVal := Node.GetAttributeNS(SHeaderMustUnderstand, SoapEnvelopeNamespaces[soSOAP12 in ObjConverter.GetOptions]);
    FMustUnderstand := SameText(AttrVal, '1') or  { Do not localize }
                       SameText(AttrVal, 'true'); { Do not localize }
  end;
  if Node.HasAttribute(SHeaderActor, SoapEnvelopeNamespaces[soSOAP12 in ObjConverter.GetOptions]) then
    FActor := Node.GetAttributeNS(SHeaderActor, SoapEnvelopeNamespaces[soSOAP12 in ObjConverter.GetOptions]);
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
  FObjectList := TObjectList<TObject>.Create;
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
                               AContentType: string; AEncoding: InvString);
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
    System.SysUtils.DeleteFile(FCacheFile);
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
    if SourceFile = '' then
      Exit;
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
    FSourceStream.Seek(Longint(0), 0);
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
const
  ContentTypeTextUTF8 = 'text/plain; charset="utf-8"';           { Do not localize }
{$IFDEF UNICODE}
var
  ABytes: TBytes;
{$ENDIF}
begin
  if Value <> '' then
  begin
    ClearStream;
    FFileName := '';
    FCacheFile := '';
  end;
  FSourceStream := TMemoryStream.Create;
{$IFNDEF UNICODE}
  TMemoryStream(FSourceStream).SetSize(Length(Value)*Sizeof(Char));
  FSourceStream.Write(Value[1], Length(Value)*Sizeof(Char));
  FContentType := ContentTypeTextPlain;
{$ELSE}
  ABytes := TEncoding.UTF8.GetBytes(Value);
  TMemoryStream(FSourceStream).SetSize(Longint(Length(ABytes)));
  FSourceStream.Write(ABytes, 0, Length(ABytes));
  FContentType := ContentTypeTextUTF8;
{$ENDIF}
  FSourceStream.Position := 0;
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
  const ObjConverter: IObjConverter; const NodeName, NodeNamespace, ChildNamespace: InvString;
  ObjConvOpts: TObjectConvertOptions; out RefID: InvString): IXMLNode;
var
  GUID: TGUID;
  GUIDString: string;
begin
  { For attachments, we skip the type and the published properties }
  Result := inherited ObjectToSOAP(RootNode, ParentNode, ObjConverter, NodeName, NodeNamespace, ChildNamespace,
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
  FCriticalSection := TCriticalSection.Create;
end;

destructor TRemotableTypeRegistry.Destroy;
begin
  FreeAndNil(FCriticalSection);
  inherited Destroy;
end;

procedure TRemotableTypeRegistry.Lock;
begin
  FCriticalSection.Enter;
end;

procedure TRemotableTypeRegistry.UnLock;
begin
  FCriticalSection.Leave;
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

procedure TRemotableTypeRegistry.RegisterXSClass(AClass: TClass; const URI: InvString = '';
                                                 const Name: InvString = '';
                                                 const ExtName: InvString = '';
                                                 IsScalar: Boolean = False;
                                                 MultiRefOpt: TObjMultiOptions = ocDefault);
var
  Index: Integer;
  Found: Boolean;
  AppURI: string;
begin
  Lock;
  try
    Index := GetEntry(AClass.ClassInfo, Found, Name);
    if not Found then
    begin
      if AppNameSpacePrefix <> '' then
        AppURI := AppNameSpacePrefix + '-';
      if URI = '' then
        URIMap[Index].URI := 'urn:' + AppURI + GetTypeData(AClass.ClassInfo).UnitNameFld.ToString { do not localize }
      else
        URIMap[Index].URI := URI;
      if Name <> '' then
        URIMap[Index].Name := Name
      else
        URIMap[Index].Name := AClass.ClassName;
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

procedure TRemotableTypeRegistry.RegisterXSInfo(Info: PTypeInfo; const URI: InvString = '';
                                                const Name: InvString = '';
                                                const ExtName: InvString = '');
var
  Index: Integer;
  Found: Boolean;
  AppURI: string;

  function GetEnumUnitName(Info: PTypeInfo): string;
  var
    R : TTypeInfoFieldAccessor;
    T: PTypeData;
    Size: Integer;
  begin
    T := GetTypeData(GetTypeData(Info)^.BaseType^);
    R.SetData(@T.NameList);
    Size := T.MaxValue - T.MinValue;
    while Size >= 0  do
      begin
        R.SetData( R.Tail );
        Dec(Size);
      end;
    Result := R.ToString;
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
      case Info.Kind of
        tkDynArray:
          URIMap[Index].URI := 'urn:' + AppURI + GetTypeData(Info).DynUnitNameFld.ToString;
        tkEnumeration:
          URIMap[Index].URI := 'urn:' + AppURI + GetEnumUnitName(Info);
        tkClass:
          URIMap[Index].URI := 'urn:' + AppURI + GetTypeData(Info).UnitNameFld.ToString;
        else
          URIMap[Index].URI := 'urn:' + AppURI;
      end
    else
      URIMap[Index].URI := URI;
    if Name <> '' then
      URIMap[Index].Name := Name
    else
      URIMap[Index].Name := Info.NameFld.ToString;
    URIMap[Index].ExtName := ExtName;
    URIMap[Index].Info := Info;
    if Info.Kind = tkClass then
      URIMap[Index].ClassType := GetTypeData(Info).ClassType;
  finally
    UnLock;
  end;
end;

procedure TRemotableTypeRegistry.RegisterHolderClsMember(ClsTypeInfo: PTypeInfo; const URI: InvString = ''; const Name: InvString = ''; const ExtName: InvString = '');
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
        Break;
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
        Break;
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
        Break;
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
        Break;
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
    if (Info.Kind = tkClass) and Assigned(GetTypeData(info).ParentInfo) then
    begin
      Info := GetTypeData(Info).ParentInfo^;
      if Assigned(Info) and (Info <> TRemotable.ClassInfo) and (Info <> TObject.ClassInfo) then
        Result := GetExternalPropName(Info, InternalName);
    end;
                                                                                                                                         
  finally
    UnLock;
  end;
end;

function TRemotableTypeRegistry.GetInternalPropName(Info: PTypeInfo; const ExternalName: InvString): string;
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

function TRemotableTypeRegistry.URIToInfo(const URI, Name: InvString): PTypeInfo;
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
        Break;
      end;
    end;
  finally
    UnLock;
  end;
end;

procedure TRemotableTypeRegistry.GetXSDInfoForClass(Info: PTypeInfo; var URI, TypeName: InvString);
var
  AClass: TClass;
begin
  AClass := GetTypeData(Info).ClassType;
  ClassToURI(AClass, URI, TypeName);
end;

function TRemotableTypeRegistry.GetRegisteredClassForBuiltInXSD(const TypeName: InvString): TClass;
var
  IsScalar: Boolean;
begin
  Result := RemClassRegistry.URIToClass(XMLSchemaNameSpace, TypeName, IsScalar);
end;

function  TRemotableTypeRegistry.GetSimpleBuiltInXSDType(const URI, TypeName: InvString): PTypeInfo;
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
        Break;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TRemotableTypeRegistry.XSDToTypeInfo(const URI, TypeName: InvString): PTypeInfo;
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
        Break;
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
            Break;
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
          for I := Low(XMLSchemaNamespaces) to High(XMLSchemaNamespaces) do
          begin
            Result := RemClassRegistry.URIToInfo(XMLSchemaNamespaces[I], 'dateTime');
            if Result <> nil then
              Break;
          end;
        end;
      end;
    varOleStr:
{$IFDEF NEXTGEN}
                             
      Result := TypeInfo(System.string);
{$ELSE !NEXTGEN}
      Result := TypeInfo(System.WideString);
{$ENDIF NEXTGEN}
    varDispatch:
      raise ETypeRegistryException.Create(SNoVarDispatch);
    varError:
      raise ETypeRegistryException.Create(SNoErrorDispatch);
    varBoolean:
      Result := TypeInfo(System.Boolean);
    varVariant:
      Result := TypeInfo(System.Variant);
    varUnknown:
      raise ETypeRegistryException.CreateFmt(SUnsupportedVariant, [VarType(V)]);
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
{$IFDEF NEXTGEN}
                             
      Result := TypeInfo(System.string);
{$ELSE !NEXTGEN}
      Result := TypeInfo(System.WideString);
{$ENDIF NEXTGEN}
    varUString:
      Result := TypeInfo(System.UnicodeString);
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
    tkLString,
    tkUString:
      Result := varOleStr;
  end;
end;

function TRemotableClassRegistry.GetEntry(Info: PTypeInfo; var Found: Boolean; const Name: InvString): Integer;
begin
  Result := FindEntry(Info, Found, Name);
  if not Found then
    SetLength(URIMap, Result + 1);
end;

function TRemotableClassRegistry.FindEntry(Info: PTypeInfo; var Found: Boolean; const Name: InvString): Integer;
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

function TRemotableTypeRegistry.URIToClass(const URI, Name: InvString): TClass;
var
  IsScalar: Boolean;
begin
  Result := URIToClass(URI, Name, IsScalar);
end;

function TRemotableTypeRegistry.URIToClass(const URI, Name: InvString; var IsScalar: Boolean): TClass;
var
  I: Integer;
begin
  Result := nil;
  Lock;
  try
    for I := 0 to Length(URIMap) - 1 do
    begin
      if (URIMap[I].URI = URI) then
      begin
        if (URIMap[I].ExtName <> '') then
        begin
          if (URIMap[I].ExtName = Name) then
          begin
            Result := URIMap[I].ClassType;
            IsScalar := URIMap[I].IsScalar;
            Break;
          end;
        end
        else if (URIMap[I].Name = Name) then
        begin
          Result := URIMap[I].ClassType;
          IsScalar := URIMap[I].IsScalar;
          Break;
        end;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TRemotableClassRegistry.InfoToURI(Info: PTypeInfo; var URI,
  Name: InvString; var IsScalar: Boolean; tryToRegister: Boolean): Boolean;
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
          if (URIMap[I].ExtName = '') then
            Name := URIMap[I].Name
          else
            Name := URIMap[I].ExtName;
          IsScalar := URIMap[I].IsScalar;
          Result := True;
          Break;
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
            if (URIMap[I].ExtName = '') then
              Name := URIMap[I].Name
            else
              Name := URIMap[I].ExtName;
            IsScalar := URIMap[I].IsScalar;
            Result := True;
            Break;
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

function TRemotableTypeRegistry.ClassToURI(AClass: TClass; var URI,  Name: InvString): Boolean;
var
  IsScalar: Boolean;
begin
  Result := ClassToURI(AClass, URI, Name, IsScalar);
end;

function TRemotableTypeRegistry.ClassToURI(AClass: TClass; var URI,
  Name: InvString; var IsScalar: Boolean; tryToRegister: Boolean): Boolean;
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
        Break;
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
  TypeName: InvString): Boolean;
var
  IsScalar: Boolean;
begin
  if Info.Kind = tkClass then
    Result := ClassToURI(GetTypeData(Info).ClassType, URI, TypeName, IsScalar)
  else
    Result := InfoToURI(Info, URI, TypeName, IsScalar);
end;

{ ERemotableException }

procedure ERemotableException.SetFaultReason(const Value: InvString);
begin
  Message := Value;
end;

function ERemotableException.GetFaultReason: InvString;
begin
  Result := Message;
end;

constructor ERemotableException.Create;
begin
  inherited Create('');
end;

constructor ERemotableException.Create(const Msg: string;
                                       const AFaultCode: InvString;
                                       const AFaultActor: InvString;
                                       const AFaultReasonLang: InvString;
                                       const AFaultNode: InvString;
                                       const AFaultRole: InvString);
begin
  inherited Create(Msg);
  FFaultCode := AFaultCode;
  FFaultActor := AFaultActor;
  FFaultReasonLang := AFaultReasonLang;
  FFaultNode := AFaultNode;
  FFaultRole := AFaultRole;
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

{$IFNDEF NEXTGEN}
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
{$ENDIF !NEXTGEN}

{$IFDEF UNICODE}
procedure TDataContext.AddUStrToClear(P: Pointer);
var
  I: Integer;
begin
  { If this UnicodeString is in the list already, we're set }
  for I := 0 to Length(UStrToClear) -1 do
    if UStrToClear[I] = P then
      Exit;
  I := Length(UStrToClear);
  SetLength(UStrToClear, I + 1);
  UStrToClear[I] := P;
end;
{$ENDIF}

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
      P := PPointer(DynArrayToClear[I].P)^;
      DynArrayClear(P, DynArrayToClear[I].Info)
    end;
  end;
  SetLength(DynArrayToClear, 0);

{$IFNDEF NEXTGEN}
  { Clean up strings we allocated }
  for I := 0 to Length(StrToClear) - 1 do
  begin
    if Assigned(StrToClear[I]) then
      PAnsiString(StrToClear[I])^ := '';
  end;
  SetLength(StrToClear, 0);
{$ENDIF !NEXTGEN}

{$IFDEF UNICODE}
  { Cleanup unicode strings we allocated }
  for I := 0 to Length(UStrToClear) - 1 do
  begin
    if Assigned(UStrToClear[I]) then
      PUnicodeString(UStrToClear[I])^ := '';
  end;
  SetLength(UStrToClear, 0);
{$ENDIF}

{$IFNDEF NEXTGEN}
  { Clean up WideStrings we allocated }
  for I := 0 to Length(WStrToClear) - 1 do
  begin
    if Assigned(WStrToClear[I]) then
      PWideString(WStrToClear[I])^ := '';
  end;
  SetLength(WStrToClear, 0);
{$ENDIF !NEXTGEN}

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
      Break;
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
  function GetTypeSize(Info: PTypeInfo): Integer;
  var
    Context: TRttiContext;
    Typ: TRttiType;
  begin
    if (Info = TypeInfo(Variant)) or (Info = TypeInfo(OleVariant)) then
      Exit(SizeOf(TVarData));                                                
    Result := SizeOf(Pointer);
    Typ := Context.GetType(Info);
    if Assigned(Typ) then
      Result := Typ.TypeSize;
  end;
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
{$IFNDEF NEXTGEN}
    end else if MD.Params[I].Info.Kind = tkLString then
    begin
      PAnsiString(P)^ := '';
      AddStrToClear(P);
{$ENDIF !NEXTGEN}
{$IFDEF UNICODE}
    end else if MD.Params[I].Info.Kind = tkUString then
    begin
      PUnicodeString(P)^ := '';
      AddUStrToClear(P);
{$ENDIF}
{$IFNDEF NEXTGEN}
    end else if MD.Params[I].Info.kind = tkWString then
    begin
      PWideString(P)^ := '';
      AddWStrToClear(P);
{$ENDIF !NEXTGEN}
    end;
  end;
  if MD.ResultInfo <> nil then
  begin
    Info := MD.ResultInfo;
    case Info^.Kind of
{$IFNDEF NEXTGEN}
      tkLString:
        begin
          P := AllocData(sizeof(PAnsiString));
          PAnsiString(P)^ := '';
          AddStrToClear(P);
        end;
      tkWString:
        begin
          P := AllocData(sizeof(PWideString));
          PWideString(P)^ := '';
          AddWStrToClear(P);
        end;
{$ENDIF !NEXTGEN}
{$IFDEF UNICODE}
      tkUString:
        begin
          P := AllocData(sizeof(PUnicodeString));
          PUnicodeString(P)^ := '';
          AddUStrToClear(P);
        end;
{$ENDIF}
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
  { 'integer' could also be TXSDecimal; however, the change will likely break code }
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Int64), XMLSchemaNameSpace, 'integer');

  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Single), XMLSchemaNameSpace, 'float');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Double), XMLSchemaNameSpace, 'double');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Extended), XMLSchemaNameSpace, 'double');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Currency), XMLSchemaNameSpace, 'double');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Comp), XMLSchemaNameSpace, 'double');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Real), XMLSchemaNameSpace, 'double');

{$IFNDEF NEXTGEN}
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'string');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.WideString), XMLSchemaNameSpace, 'string');
{$ENDIF !NEXTGEN}
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.UnicodeString), XMLSchemaNameSpace, 'string');


{$IFNDEF NEXTGEN}
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
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiString), XMLSchemaNameSpace, 'lang');
{$ENDIF !NEXTGEN}

  { Native Types that map to XML string }
{$IFNDEF NEXTGEN}
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.ShortString), XMLSchemaNameSpace, 'string');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.AnsiChar), XMLSchemaNameSpace, 'string');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.WideChar), XMLSchemaNameSpace, 'string');
{$ENDIF !NEXTGEN}
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Char), XMLSchemaNameSpace, 'string');

  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Types.TByteDynArray), XMLSchemaNameSpace, 'base64Binary');

  { Whether we register 'anyType' or 'anySimpleType first determines how we expose Variants -
    we'll opt for anyType as it seems to be the most interoperable although anySimpleType
    is the better semantic match }
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Variant), XMLSchemaNameSpace, 'anyType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Variant), XMLSchemaNameSpace, 'anySimpleType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Variant), XMLSchemaNameSpace, 'ur-type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.OleVariant), XMLSchemaNameSpace, 'anyType');

  { Used by .NET Services where a schema is expected - better would be.... ?? }
{$IFDEF XSD_SCHEMA_AS_STRING}
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.WideString), XMLSchemaNameSpace, 'schema');
{$ELSE}
  RemClassRegistry.RegisterXSClass(TXMLData, XMLSchemaNameSpace, 'schema', '', False, ocNoMultiRef);
{$ENDIF}

                                                                            
  RemClassRegistry.RegisterXSInfo(TypeInfo(System.Types.TByteDynArray), SoapEncodingNamespaces[False], 'base64');

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
{$IFNDEF NEXTGEN}
  RemClassRegistry.RegisterXSInfo(TypeInfo(TWideStringDynArray), SBorlandTypeNamespace);
{$ENDIF !NEXTGEN}

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
  if not Assigned(InvRegistryV) then
    InitIR;
finalization
  InvRegistryV.Free;
  RemClassRegistryV.Free;
end.


