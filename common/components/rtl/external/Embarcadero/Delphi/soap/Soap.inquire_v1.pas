{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://www.uddi.org/wsdl/inquire_v1.wsdl
//  >Import : http://www.uddi.org/schema/2001/uddi_v1.xsd
// Encoding : UTF-8
// Version  : 1.0
// (7/19/2002 5:04:40 PM - 1.33.2.5)
// ************************************************************************ //

// This unit refers to the defunct UDDI standard and
// is not supported by the newer compiler bcc64, etc
{$HPPEMIT     '#ifndef __clang__'}
{$HPPEMIT END '#endif // __clang__'}

unit Soap.inquire_v1;

interface

uses
  Soap.InvokeRegistry;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:int             - "http://www.w3.org/2001/XMLSchema"

  AccessPoint          = class;                 { "urn:uddi-org:api" }
  HostingRedirector    = class;                 { "urn:uddi-org:api" }
  OverviewDoc          = class;                 { "urn:uddi-org:api" }
  InstanceDetails      = class;                 { "urn:uddi-org:api" }
  TModelInstanceInfo   = class;                 { "urn:uddi-org:api" }
  TModelInstanceDetails = class;                { "urn:uddi-org:api"[A] }
  BindingTemplate      = class;                 { "urn:uddi-org:api" }
  BindingDetail        = class;                 { "urn:uddi-org:api"[A] }
  DiscoveryUrl         = class;                 { "urn:uddi-org:api" }
  DiscoveryURLs        = class;                 { "urn:uddi-org:api"[A] }
  Phone2               = class;                 { "urn:uddi-org:api" }
  Email                = class;                 { "urn:uddi-org:api" }
  Address              = class;                 { "urn:uddi-org:api"[A] }
  Contact              = class;                 { "urn:uddi-org:api" }
  Contacts             = class;                 { "urn:uddi-org:api"[A] }
  BindingTemplates     = class;                 { "urn:uddi-org:api"[A] }
  KeyedReference       = class;                 { "urn:uddi-org:api" }
  CategoryBag          = class;                 { "urn:uddi-org:api"[A] }
  BusinessService      = class;                 { "urn:uddi-org:api" }
  ServiceDetail        = class;                 { "urn:uddi-org:api"[A] }
  BusinessServices     = class;                 { "urn:uddi-org:api"[A] }
  IdentifierBag        = class;                 { "urn:uddi-org:api"[A] }
  BusinessEntity       = class;                 { "urn:uddi-org:api" }
  BusinessDetail       = class;                 { "urn:uddi-org:api"[A] }
  BusinessEntityExt    = class;                 { "urn:uddi-org:api" }
  BusinessDetailExt    = class;                 { "urn:uddi-org:api"[A] }
  ServiceInfo          = class;                 { "urn:uddi-org:api" }
  ServiceInfos         = class;                 { "urn:uddi-org:api"[A] }
  ServiceList          = class;                 { "urn:uddi-org:api" }
  BusinessInfo         = class;                 { "urn:uddi-org:api" }
  BusinessInfos        = class;                 { "urn:uddi-org:api"[A] }
  BusinessList         = class;                 { "urn:uddi-org:api" }
  FindQualifiers       = class;                 { "urn:uddi-org:api"[A] }
  FindTModel           = class;                 { "urn:uddi-org:api" }
  TModelBag            = class;                 { "urn:uddi-org:api"[A] }
  FindBinding          = class;                 { "urn:uddi-org:api" }
  FindBusiness         = class;                 { "urn:uddi-org:api" }
  FindService          = class;                 { "urn:uddi-org:api" }
  GetTModelDetail      = class;                 { "urn:uddi-org:api"[A] }
  GetBindingDetail     = class;                 { "urn:uddi-org:api"[A] }
  GetBusinessDetailExt = class;                 { "urn:uddi-org:api"[A] }
  GetBusinessDetail    = class;                 { "urn:uddi-org:api"[A] }
  GetServiceDetail     = class;                 { "urn:uddi-org:api"[A] }
  TModelInfo           = class;                 { "urn:uddi-org:api" }
  TModelInfos          = class;                 { "urn:uddi-org:api"[A] }
  TModelList           = class;                 { "urn:uddi-org:api" }
  TModel               = class;                 { "urn:uddi-org:api" }
  TModelDetail         = class;                 { "urn:uddi-org:api"[A] }

  { "urn:uddi-org:api" }
  { NOTE: I'm reversing the order of this enum as otherwise you get
          false positive when nothing is sent down the wire and
          the default value of the enumeration is at 'true' }
  Truncated = (false, true);
  (*$NODEFINE Truncated*)
  (*$HPPEMIT 'namespace Soap { namespace Inquire_v1 { enum Truncated { False, True }; } }'*)

  { "urn:uddi-org:api" }
  URLType = (mailto, http, https, ftp, fax, phone, other);

{$IFDEF NEXTGEN}
  Description     =  type string;      { "urn:uddi-org:api" }
{$ELSE !NEXTGEN}
  Description     =  type WideString;      { "urn:uddi-org:api" }
{$ENDIF NEXTGEN}


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoHolderClass,xoAttributeOnLastMember]
  // ************************************************************************ //
  AccessPoint = class(TRemotable)
  private
    FAccessPoint: string;
    FURLType: URLType;
  public
    constructor Create; override;
  published
    property AccessPoint: string read FAccessPoint write FAccessPoint;
    property URLType: URLType read FURLType write FURLType stored AS_ATTRIBUTE;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // ************************************************************************ //
  HostingRedirector = class(TRemotable)
  private
    FbindingKey: string;
  published
    property bindingKey: string read FbindingKey write FbindingKey stored AS_ATTRIBUTE;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // ************************************************************************ //
  OverviewDoc = class(TRemotable)
  private
    Fdescription: Description;
    FoverviewURL: string;
  published
    property description: Description read Fdescription write Fdescription;
    property overviewURL: string read FoverviewURL write FoverviewURL;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // ************************************************************************ //
  InstanceDetails = class(TRemotable)
  private
    Fdescription: Description;
    FoverviewDoc: OverviewDoc;
    FinstanceParms: string;
  public
    destructor Destroy; override;
  published
    property description: Description read Fdescription write Fdescription;
    property overviewDoc: OverviewDoc read FoverviewDoc write FoverviewDoc;
    property instanceParms: string read FinstanceParms write FinstanceParms;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // ************************************************************************ //
  TModelInstanceInfo = class(TRemotable)
  private
    Fdescription: Description;
    FinstanceDetails: InstanceDetails;
    FtModelKey: string;
  public
    destructor Destroy; override;
  published
    property description: Description read Fdescription write Fdescription;
    property instanceDetails: InstanceDetails read FinstanceDetails write FinstanceDetails;
    property tModelKey: string read FtModelKey write FtModelKey stored AS_ATTRIBUTE;
  end;

  tModelInstanceInfo2 = array of TModelInstanceInfo;   { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  TModelInstanceDetails = class(TRemotable)
  private
    FtModelInstanceInfo: tModelInstanceInfo2;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetTModelInstanceInfoArray(Index: Integer): TModelInstanceInfo;
    function   GetTModelInstanceInfoArrayLength: Integer;
    property   TModelInstanceInfoArray[Index: Integer]: TModelInstanceInfo read GetTModelInstanceInfoArray; default;
    property   Len: Integer read GetTModelInstanceInfoArrayLength;
  published
    property tModelInstanceInfo: tModelInstanceInfo2 read FtModelInstanceInfo write FtModelInstanceInfo;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // ************************************************************************ //
  BindingTemplate = class(TRemotable)
  private
    Fdescription: Description;
    FaccessPoint: AccessPoint;
    FhostingRedirector: HostingRedirector;
    FtModelInstanceDetails: TModelInstanceDetails;
    FserviceKey: string;
    FbindingKey: string;
  public
    destructor Destroy; override;
  published
    property description: Description read Fdescription write Fdescription;
    property accessPoint: AccessPoint read FaccessPoint write FaccessPoint;
    property hostingRedirector: HostingRedirector read FhostingRedirector write FhostingRedirector;
    property tModelInstanceDetails: TModelInstanceDetails read FtModelInstanceDetails write FtModelInstanceDetails;
    property serviceKey: string read FserviceKey write FserviceKey stored AS_ATTRIBUTE;
    property bindingKey: string read FbindingKey write FbindingKey stored AS_ATTRIBUTE;
  end;

  bindingTemplate2 = array of BindingTemplate;   { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  BindingDetail = class(TRemotable)
  private
    Fgeneric: string;
    Foperator: string;
    Ftruncated: Truncated;
    FbindingTemplate: bindingTemplate2;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetBindingTemplateArray(Index: Integer): BindingTemplate;
    function   GetBindingTemplateArrayLength: Integer;
    property   BindingTemplateArray[Index: Integer]: BindingTemplate read GetBindingTemplateArray; default;
    property   Len: Integer read GetBindingTemplateArrayLength;
  published
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property operator: string read Foperator write Foperator stored AS_ATTRIBUTE;
    property truncated: Truncated read Ftruncated write Ftruncated stored AS_ATTRIBUTE;
    property bindingTemplate: bindingTemplate2 read FbindingTemplate write FbindingTemplate;
  end;

  bindingDetail2  = BindingDetail;      { "urn:uddi-org:api"[L] }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoHolderClass,xoAttributeOnLastMember]
  // ************************************************************************ //
  DiscoveryUrl = class(TRemotable)
  private
    FDiscoveryUrl: string;
    FuseType: string;
  public
    constructor Create; override;
  published
    property DiscoveryUrl: string read FDiscoveryUrl write FDiscoveryUrl;
    property useType: string read FuseType write FuseType stored AS_ATTRIBUTE;
  end;

  discoveryUrl2 = array of DiscoveryUrl;        { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  DiscoveryURLs = class(TRemotable)
  private
    FdiscoveryUrl: discoveryUrl2;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetDiscoveryUrlArray(Index: Integer): DiscoveryUrl;
    function   GetDiscoveryUrlArrayLength: Integer;
    property   DiscoveryUrlArray[Index: Integer]: DiscoveryUrl read GetDiscoveryUrlArray; default;
    property   Len: Integer read GetDiscoveryUrlArrayLength;
  published
    property discoveryUrl: discoveryUrl2 read FdiscoveryUrl write FdiscoveryUrl;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoHolderClass,xoAttributeOnLastMember]
  // ************************************************************************ //
  Phone2 = class(TRemotable)
  private
    FPhone: string;
    FuseType: string;
  public
    constructor Create; override;
  published
    property Phone: string read FPhone write FPhone;
    property useType: string read FuseType write FuseType stored AS_ATTRIBUTE;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoHolderClass,xoAttributeOnLastMember]
  // ************************************************************************ //
  Email = class(TRemotable)
  private
    FEmail: string;
    FuseType: string;
  public
    constructor Create; override;
  published
    property Email: string read FEmail write FEmail;
    property useType: string read FuseType write FuseType stored AS_ATTRIBUTE;
  end;

  addressLine = array of string;            { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  Address = class(TRemotable)
  private
    FsortCode: string;
    FuseType: string;
    FaddressLine: addressLine;
  public
    constructor Create; override;
    function   GetWideStringArray(Index: Integer): string;
    function   GetWideStringArrayLength: Integer;
    property   WideStringArray[Index: Integer]: string read GetWideStringArray; default;
    property   Len: Integer read GetWideStringArrayLength;
  published
    property sortCode: string read FsortCode write FsortCode stored AS_ATTRIBUTE;
    property useType: string read FuseType write FuseType stored AS_ATTRIBUTE;
    property addressLine: addressLine read FaddressLine write FaddressLine;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // ************************************************************************ //
  Contact = class(TRemotable)
  private
    Fdescription: Description;
    FpersonName: string;
    Fphone: Phone2;
    Femail: Email;
    Faddress: Address;
    FuseType: string;
  public
    destructor Destroy; override;
  published
    property description: Description read Fdescription write Fdescription;
    property personName: string read FpersonName write FpersonName;
    property phone: Phone2 read Fphone write Fphone;
    property email: Email read Femail write Femail;
    property address: Address read Faddress write Faddress;
    property useType: string read FuseType write FuseType stored AS_ATTRIBUTE;
  end;

  contact2   = array of Contact;                { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  Contacts = class(TRemotable)
  private
    Fcontact: contact2;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetContactArray(Index: Integer): Contact;
    function   GetContactArrayLength: Integer;
    property   ContactArray[Index: Integer]: Contact read GetContactArray; default;
    property   Len: Integer read GetContactArrayLength;
  published
    property contact: contact2 read Fcontact write Fcontact;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  BindingTemplates = class(TRemotable)
  private
    FbindingTemplate: bindingTemplate2;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetBindingTemplateArray(Index: Integer): BindingTemplate;
    function   GetBindingTemplateArrayLength: Integer;
    property   BindingTemplateArray[Index: Integer]: BindingTemplate read GetBindingTemplateArray; default;
    property   Len: Integer read GetBindingTemplateArrayLength;
  published
    property bindingTemplate: bindingTemplate2 read FbindingTemplate write FbindingTemplate;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // ************************************************************************ //
  KeyedReference = class(TRemotable)
  private
    FtModelKey: string;
    FkeyName: string;
    FkeyValue: string;
  published
    property tModelKey: string read FtModelKey write FtModelKey stored AS_ATTRIBUTE;
    property keyName: string read FkeyName write FkeyName stored AS_ATTRIBUTE;
    property keyValue: string read FkeyValue write FkeyValue stored AS_ATTRIBUTE;
  end;

  keyedReference2 = array of KeyedReference;    { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  CategoryBag = class(TRemotable)
  private
    FkeyedReference: keyedReference2;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetKeyedReferenceArray(Index: Integer): KeyedReference;
    function   GetKeyedReferenceArrayLength: Integer;
    property   KeyedReferenceArray[Index: Integer]: KeyedReference read GetKeyedReferenceArray; default;
    property   Len: Integer read GetKeyedReferenceArrayLength;
  published
    property keyedReference: keyedReference2 read FkeyedReference write FkeyedReference;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // ************************************************************************ //
  BusinessService = class(TRemotable)
  private
    Fname: string;
    Fdescription: Description;
    FbindingTemplates: BindingTemplates;
    FcategoryBag: CategoryBag;
    FserviceKey: string;
    FbusinessKey: string;
  public
    destructor Destroy; override;
  published
    property name: string read Fname write Fname;
    property description: Description read Fdescription write Fdescription;
    property bindingTemplates: BindingTemplates read FbindingTemplates write FbindingTemplates;
    property categoryBag: CategoryBag read FcategoryBag write FcategoryBag;
    property serviceKey: string read FserviceKey write FserviceKey stored AS_ATTRIBUTE;
    property businessKey: string read FbusinessKey write FbusinessKey stored AS_ATTRIBUTE;
  end;

  businessService2 = array of BusinessService;   { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  ServiceDetail = class(TRemotable)
  private
    Fgeneric: string;
    Foperator: string;
    Ftruncated: Truncated;
    FbusinessService: businessService2;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetBusinessServiceArray(Index: Integer): BusinessService;
    function   GetBusinessServiceArrayLength: Integer;
    property   BusinessServiceArray[Index: Integer]: BusinessService read GetBusinessServiceArray; default;
    property   Len: Integer read GetBusinessServiceArrayLength;
  published
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property operator: string read Foperator write Foperator stored AS_ATTRIBUTE;
    property truncated: Truncated read Ftruncated write Ftruncated stored AS_ATTRIBUTE;
    property businessService: businessService2 read FbusinessService write FbusinessService;
  end;

  serviceDetail2  = ServiceDetail;      { "urn:uddi-org:api"[L] }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  BusinessServices = class(TRemotable)
  private
    FbusinessService: businessService2;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetBusinessServiceArray(Index: Integer): BusinessService;
    function   GetBusinessServiceArrayLength: Integer;
    property   BusinessServiceArray[Index: Integer]: BusinessService read GetBusinessServiceArray; default;
    property   Len: Integer read GetBusinessServiceArrayLength;
  published
    property businessService: businessService2 read FbusinessService write FbusinessService;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  IdentifierBag = class(TRemotable)
  private
    FkeyedReference: keyedReference2;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetKeyedReferenceArray(Index: Integer): KeyedReference;
    function   GetKeyedReferenceArrayLength: Integer;
    property   KeyedReferenceArray[Index: Integer]: KeyedReference read GetKeyedReferenceArray; default;
    property   Len: Integer read GetKeyedReferenceArrayLength;
  published
    property keyedReference: keyedReference2 read FkeyedReference write FkeyedReference;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // ************************************************************************ //
  BusinessEntity = class(TRemotable)
  private
    FdiscoveryURLs: DiscoveryURLs;
    Fname: string;
    Fdescription: Description;
    Fcontacts: Contacts;
    FbusinessServices: BusinessServices;
    FidentifierBag: IdentifierBag;
    FcategoryBag: CategoryBag;
    FbusinessKey: string;
    Foperator: string;
    FauthorizedName: string;
  public
    destructor Destroy; override;
  published
    property discoveryURLs: DiscoveryURLs read FdiscoveryURLs write FdiscoveryURLs;
    property name: string read Fname write Fname;
    property description: Description read Fdescription write Fdescription;
    property contacts: Contacts read Fcontacts write Fcontacts;
    property businessServices: BusinessServices read FbusinessServices write FbusinessServices;
    property identifierBag: IdentifierBag read FidentifierBag write FidentifierBag;
    property categoryBag: CategoryBag read FcategoryBag write FcategoryBag;
    property businessKey: string read FbusinessKey write FbusinessKey stored AS_ATTRIBUTE;
    property operator: string read Foperator write Foperator stored AS_ATTRIBUTE;
    property authorizedName: string read FauthorizedName write FauthorizedName stored AS_ATTRIBUTE;
  end;

  businessEntity2 = array of BusinessEntity;    { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  BusinessDetail = class(TRemotable)
  private
    Fgeneric: string;
    Foperator: string;
    Ftruncated: Truncated;
    FbusinessEntity: businessEntity2;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetBusinessEntityArray(Index: Integer): BusinessEntity;
    function   GetBusinessEntityArrayLength: Integer;
    property   BusinessEntityArray[Index: Integer]: BusinessEntity read GetBusinessEntityArray; default;
    property   Len: Integer read GetBusinessEntityArrayLength;
  published
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property operator: string read Foperator write Foperator stored AS_ATTRIBUTE;
    property truncated: Truncated read Ftruncated write Ftruncated stored AS_ATTRIBUTE;
    property businessEntity: businessEntity2 read FbusinessEntity write FbusinessEntity;
  end;

  businessDetail2 = BusinessDetail;      { "urn:uddi-org:api"[L] }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // ************************************************************************ //
  BusinessEntityExt = class(TRemotable)
  private
    FbusinessEntity: BusinessEntity;
  public
    destructor Destroy; override;
  published
    property businessEntity: BusinessEntity read FbusinessEntity write FbusinessEntity;
  end;

  businessEntityExt2 = array of BusinessEntityExt;   { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  BusinessDetailExt = class(TRemotable)
  private
    Fgeneric: string;
    Foperator: string;
    Ftruncated: Truncated;
    FbusinessEntityExt: businessEntityExt2;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetBusinessEntityExtArray(Index: Integer): BusinessEntityExt;
    function   GetBusinessEntityExtArrayLength: Integer;
    property   BusinessEntityExtArray[Index: Integer]: BusinessEntityExt read GetBusinessEntityExtArray; default;
    property   Len: Integer read GetBusinessEntityExtArrayLength;
  published
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property operator: string read Foperator write Foperator stored AS_ATTRIBUTE;
    property truncated: Truncated read Ftruncated write Ftruncated stored AS_ATTRIBUTE;
    property businessEntityExt: businessEntityExt2 read FbusinessEntityExt write FbusinessEntityExt;
  end;

  businessDetailExt2 = BusinessDetailExt;      { "urn:uddi-org:api"[L] }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // ************************************************************************ //
  ServiceInfo = class(TRemotable)
  private
    Fname: string;
    FserviceKey: string;
    FbusinessKey: string;
  published
    property name: string read Fname write Fname;
    property serviceKey: string read FserviceKey write FserviceKey stored AS_ATTRIBUTE;
    property businessKey: string read FbusinessKey write FbusinessKey stored AS_ATTRIBUTE;
  end;

  serviceInfo2 = array of ServiceInfo;          { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  ServiceInfos = class(TRemotable)
  private
    FserviceInfo: serviceInfo2;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetServiceInfoArray(Index: Integer): ServiceInfo;
    function   GetServiceInfoArrayLength: Integer;
    property   ServiceInfoArray[Index: Integer]: ServiceInfo read GetServiceInfoArray; default;
    property   Len: Integer read GetServiceInfoArrayLength;
  published
    property serviceInfo: serviceInfo2 read FserviceInfo write FserviceInfo;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  ServiceList = class(TRemotable)
  private
    FserviceInfos: ServiceInfos;
    Fgeneric: string;
    Foperator: string;
    Ftruncated: Truncated;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property serviceInfos: ServiceInfos read FserviceInfos write FserviceInfos;
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property operator: string read Foperator write Foperator stored AS_ATTRIBUTE;
    property truncated: Truncated read Ftruncated write Ftruncated stored AS_ATTRIBUTE;
  end;

  serviceList2    = ServiceList;      { "urn:uddi-org:api"[L] }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // ************************************************************************ //
  BusinessInfo = class(TRemotable)
  private
    Fname: string;
    Fdescription: Description;
    FserviceInfos: ServiceInfos;
    FbusinessKey: string;
  public
    destructor Destroy; override;
  published
    property name: string read Fname write Fname;
    property description: Description read Fdescription write Fdescription;
    property serviceInfos: ServiceInfos read FserviceInfos write FserviceInfos;
    property businessKey: string read FbusinessKey write FbusinessKey stored AS_ATTRIBUTE;
  end;

  businessInfo2 = array of BusinessInfo;        { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  BusinessInfos = class(TRemotable)
  private
    FbusinessInfo: businessInfo2;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetBusinessInfoArray(Index: Integer): BusinessInfo;
    function   GetBusinessInfoArrayLength: Integer;
    property   BusinessInfoArray[Index: Integer]: BusinessInfo read GetBusinessInfoArray; default;
    property   Len: Integer read GetBusinessInfoArrayLength;
  published
    property businessInfo: businessInfo2 read FbusinessInfo write FbusinessInfo;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  BusinessList = class(TRemotable)
  private
    FbusinessInfos: BusinessInfos;
    Fgeneric: string;
    Foperator: string;
    Ftruncated: Truncated;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property businessInfos: BusinessInfos read FbusinessInfos write FbusinessInfos;
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property operator: string read Foperator write Foperator stored AS_ATTRIBUTE;
    property truncated: Truncated read Ftruncated write Ftruncated stored AS_ATTRIBUTE;
  end;

  businessList2   = BusinessList;      { "urn:uddi-org:api"[L] }
  findQualifier = array of string;          { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  FindQualifiers = class(TRemotable)
  private
    FfindQualifier: findQualifier;
  public
    constructor Create; override;
    function   GetWideStringArray(Index: Integer): string;
    function   GetWideStringArrayLength: Integer;
    property   WideStringArray[Index: Integer]: string read GetWideStringArray; default;
    property   Len: Integer read GetWideStringArrayLength;
  published
    property findQualifier: findQualifier read FfindQualifier write FfindQualifier;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  FindTModel = class(TRemotable)
  private
    FfindQualifiers: FindQualifiers;
    Fname: string;
    FidentifierBag: IdentifierBag;
    FcategoryBag: CategoryBag;
    Fgeneric: string;
    FmaxRows: Integer;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property findQualifiers: FindQualifiers read FfindQualifiers write FfindQualifiers;
    property name: string read Fname write Fname;
    property identifierBag: IdentifierBag read FidentifierBag write FidentifierBag;
    property categoryBag: CategoryBag read FcategoryBag write FcategoryBag;
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property maxRows: Integer read FmaxRows write FmaxRows stored AS_ATTRIBUTE;
  end;

  find_tModel     = FindTModel;      { "urn:uddi-org:api"[L] }
  tModelKey  = array of string;             { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  TModelBag = class(TRemotable)
  private
    FtModelKey: tModelKey;
  public
    constructor Create; override;
    function   GetWideStringArray(Index: Integer): string;
    function   GetWideStringArrayLength: Integer;
    property   WideStringArray[Index: Integer]: string read GetWideStringArray; default;
    property   Len: Integer read GetWideStringArrayLength;
  published
    property tModelKey: tModelKey read FtModelKey write FtModelKey;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  FindBinding = class(TRemotable)
  private
    FfindQualifiers: FindQualifiers;
    FtModelBag: TModelBag;
    Fgeneric: string;
    FmaxRows: Integer;
    FserviceKey: string;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property findQualifiers: FindQualifiers read FfindQualifiers write FfindQualifiers;
    property tModelBag: TModelBag read FtModelBag write FtModelBag;
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property maxRows: Integer read FmaxRows write FmaxRows stored AS_ATTRIBUTE;
    property serviceKey: string read FserviceKey write FserviceKey stored AS_ATTRIBUTE;
  end;

  find_binding    = FindBinding;      { "urn:uddi-org:api"[L] }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  FindBusiness = class(TRemotable)
  private
    FfindQualifiers: FindQualifiers;
    Fname: string;
    FidentifierBag: IdentifierBag;
    FcategoryBag: CategoryBag;
    FtModelBag: TModelBag;
    FdiscoveryURLs: DiscoveryURLs;
    Fgeneric: string;
    FmaxRows: Integer;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property findQualifiers: FindQualifiers read FfindQualifiers write FfindQualifiers;
    property name: string read Fname write Fname;
    property identifierBag: IdentifierBag read FidentifierBag write FidentifierBag;
    property categoryBag: CategoryBag read FcategoryBag write FcategoryBag;
    property tModelBag: TModelBag read FtModelBag write FtModelBag;
    property discoveryURLs: DiscoveryURLs read FdiscoveryURLs write FdiscoveryURLs;
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property maxRows: Integer read FmaxRows write FmaxRows stored AS_ATTRIBUTE;
  end;

  find_business   = FindBusiness;      { "urn:uddi-org:api"[L] }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  FindService = class(TRemotable)
  private
    FfindQualifiers: FindQualifiers;
    Fname: string;
    FcategoryBag: CategoryBag;
    FtModelBag: TModelBag;
    Fgeneric: string;
    FmaxRows: Integer;
    FbusinessKey: string;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property findQualifiers: FindQualifiers read FfindQualifiers write FfindQualifiers;
    property name: string read Fname write Fname;
    property categoryBag: CategoryBag read FcategoryBag write FcategoryBag;
    property tModelBag: TModelBag read FtModelBag write FtModelBag;
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property maxRows: Integer read FmaxRows write FmaxRows stored AS_ATTRIBUTE;
    property businessKey: string read FbusinessKey write FbusinessKey stored AS_ATTRIBUTE;
  end;

  find_service    = FindService;      { "urn:uddi-org:api"[L] }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  GetTModelDetail = class(TRemotable)
  private
    Fgeneric: string;
    FtModelKey: tModelKey;
  public
    constructor Create; override;
    function   GetWideStringArray(Index: Integer): string;
    function   GetWideStringArrayLength: Integer;
    property   WideStringArray[Index: Integer]: string read GetWideStringArray; default;
    property   Len: Integer read GetWideStringArrayLength;
  published
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property tModelKey: tModelKey read FtModelKey write FtModelKey;
  end;

  get_tModelDetail = GetTModelDetail;      { "urn:uddi-org:api"[L] }
  bindingKey = array of string;             { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  GetBindingDetail = class(TRemotable)
  private
    Fgeneric: string;
    FbindingKey: bindingKey;
  public
    constructor Create; override;
    function   GetWideStringArray(Index: Integer): string;
    function   GetWideStringArrayLength: Integer;
    property   WideStringArray[Index: Integer]: string read GetWideStringArray; default;
    property   Len: Integer read GetWideStringArrayLength;
  published
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property bindingKey: bindingKey read FbindingKey write FbindingKey;
  end;

  get_bindingDetail = GetBindingDetail;      { "urn:uddi-org:api"[L] }
  businessKey = array of string;            { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  GetBusinessDetailExt = class(TRemotable)
  private
    Fgeneric: string;
    FbusinessKey: businessKey;
  public
    constructor Create; override;
    function   GetWideStringArray(Index: Integer): string;
    function   GetWideStringArrayLength: Integer;
    property   WideStringArray[Index: Integer]: string read GetWideStringArray; default;
    property   Len: Integer read GetWideStringArrayLength;
  published
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property businessKey: businessKey read FbusinessKey write FbusinessKey;
  end;

  get_businessDetailExt = GetBusinessDetailExt;      { "urn:uddi-org:api"[L] }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  GetBusinessDetail = class(TRemotable)
  private
    Fgeneric: string;
    FbusinessKey: businessKey;
  public
    constructor Create; override;
    function   GetWideStringArray(Index: Integer): string;
    function   GetWideStringArrayLength: Integer;
    property   WideStringArray[Index: Integer]: string read GetWideStringArray; default;
    property   Len: Integer read GetWideStringArrayLength;
  published
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property businessKey: businessKey read FbusinessKey write FbusinessKey;
  end;

  get_businessDetail = GetBusinessDetail;      { "urn:uddi-org:api"[L] }
  serviceKey = array of string;             { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  GetServiceDetail = class(TRemotable)
  private
    Fgeneric: string;
    FserviceKey: serviceKey;
  public
    constructor Create; override;
    function   GetWideStringArray(Index: Integer): string;
    function   GetWideStringArrayLength: Integer;
    property   WideStringArray[Index: Integer]: string read GetWideStringArray; default;
    property   Len: Integer read GetWideStringArrayLength;
  published
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property serviceKey: serviceKey read FserviceKey write FserviceKey;
  end;

  get_serviceDetail = GetServiceDetail;      { "urn:uddi-org:api"[L] }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // ************************************************************************ //
  TModelInfo = class(TRemotable)
  private
    Fname: string;
    FtModelKey: string;
  published
    property name: string read Fname write Fname;
    property tModelKey: string read FtModelKey write FtModelKey stored AS_ATTRIBUTE;
  end;

  tModelInfo2 = array of TModelInfo;            { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  TModelInfos = class(TRemotable)
  private
    FtModelInfo: tModelInfo2;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetTModelInfoArray(Index: Integer): TModelInfo;
    function   GetTModelInfoArrayLength: Integer;
    property   TModelInfoArray[Index: Integer]: TModelInfo read GetTModelInfoArray; default;
    property   Len: Integer read GetTModelInfoArrayLength;
  published
    property tModelInfo: tModelInfo2 read FtModelInfo write FtModelInfo;
  end;



  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  TModelList = class(TRemotable)
  private
    FtModelInfos: TModelInfos;
    Fgeneric: string;
    Foperator: string;
    Ftruncated: Truncated;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property tModelInfos: TModelInfos read FtModelInfos write FtModelInfos;
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property operator: string read Foperator write Foperator stored AS_ATTRIBUTE;
    property truncated: Truncated read Ftruncated write Ftruncated stored AS_ATTRIBUTE;
  end;

  tModelList2     = TModelList;      { "urn:uddi-org:api"[L] }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // ************************************************************************ //
  TModel = class(TRemotable)
  private
    Fname: string;
    Fdescription: Description;
    FoverviewDoc: OverviewDoc;
    FidentifierBag: IdentifierBag;
    FcategoryBag: CategoryBag;
    FtModelKey: string;
    Foperator: string;
    FauthorizedName: string;
  public
    destructor Destroy; override;
  published
    property name: string read Fname write Fname;
    property description: Description read Fdescription write Fdescription;
    property overviewDoc: OverviewDoc read FoverviewDoc write FoverviewDoc;
    property identifierBag: IdentifierBag read FidentifierBag write FidentifierBag;
    property categoryBag: CategoryBag read FcategoryBag write FcategoryBag;
    property tModelKey: string read FtModelKey write FtModelKey stored AS_ATTRIBUTE;
    property operator: string read Foperator write Foperator stored AS_ATTRIBUTE;
    property authorizedName: string read FauthorizedName write FauthorizedName stored AS_ATTRIBUTE;
  end;

  tModel2    = array of TModel;                 { "urn:uddi-org:api" }


  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // Serializtn: [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  TModelDetail = class(TRemotable)
  private
    Fgeneric: string;
    Foperator: string;
    Ftruncated: Truncated;
    FtModel: tModel2;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetTModelArray(Index: Integer): TModel;
    function   GetTModelArrayLength: Integer;
    property   TModelArray[Index: Integer]: TModel read GetTModelArray; default;
    property   Len: Integer read GetTModelArrayLength;
  published
    property generic: string read Fgeneric write Fgeneric stored AS_ATTRIBUTE;
    property operator: string read Foperator write Foperator stored AS_ATTRIBUTE;
    property truncated: Truncated read Ftruncated write Ftruncated stored AS_ATTRIBUTE;
    property tModel: tModel2 read FtModel write FtModel;
  end;

  tModelDetail2   = TModelDetail;      { "urn:uddi-org:api"[L] }

  // ************************************************************************ //
  // Namespace : urn:uddi-org:api
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : InquireSoap
  // ************************************************************************ //
  InquireSoap = interface(IInvokable)
  ['{C2AD6D0F-0875-EF31-4035-8D59DF59CBFA}']
    function  find_binding(const body: find_binding): bindingDetail2; stdcall;
    function  find_business(const body: find_business): businessList2; stdcall;
    function  find_service(const body: find_service): serviceList2; stdcall;
    function  find_tModel(const body: find_tModel): tModelList2; stdcall;
    function  get_bindingDetail(const body: get_bindingDetail): bindingDetail2; stdcall;
    function  get_businessDetail(const body: get_businessDetail): businessDetail2; stdcall;
    function  get_businessDetailExt(const body: get_businessDetailExt): businessDetailExt2; stdcall;
    function  get_serviceDetail(const body: get_serviceDetail): serviceDetail2; stdcall;
    function  get_tModelDetail(const body: get_tModelDetail): tModelDetail2; stdcall;
  end;


procedure InitInquireV1Types;


implementation

constructor AccessPoint.Create;
begin
  inherited Create;
  FSerializationOptions := [xoHolderClass,xoAttributeOnLastMember];
end;

destructor InstanceDetails.Destroy;
begin
  if Assigned(FoverviewDoc) then
    FoverviewDoc.Free;
  inherited Destroy;
end;

destructor TModelInstanceInfo.Destroy;
begin
  if Assigned(FinstanceDetails) then
    FinstanceDetails.Free;
  inherited Destroy;
end;

constructor TModelInstanceDetails.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

destructor TModelInstanceDetails.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FtModelInstanceInfo)-1 do
    if Assigned(FtModelInstanceInfo[I]) then
      FtModelInstanceInfo[I].Free;
  SetLength(FtModelInstanceInfo, 0);
  inherited Destroy;
end;

function TModelInstanceDetails.GetTModelInstanceInfoArray(Index: Integer): TModelInstanceInfo;
begin
  Result := FtModelInstanceInfo[Index];
end;

function TModelInstanceDetails.GetTModelInstanceInfoArrayLength: Integer;
begin
  if Assigned(FtModelInstanceInfo) then
    Result := Length(FtModelInstanceInfo)
  else
  Result := 0;
end;

destructor BindingTemplate.Destroy;
begin
  if Assigned(FaccessPoint) then
    FaccessPoint.Free;
  if Assigned(FhostingRedirector) then
    FhostingRedirector.Free;
  if Assigned(FtModelInstanceDetails) then
    FtModelInstanceDetails.Free;
  inherited Destroy;
end;

constructor BindingDetail.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor BindingDetail.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FbindingTemplate)-1 do
    if Assigned(FbindingTemplate[I]) then
      FbindingTemplate[I].Free;
  SetLength(FbindingTemplate, 0);
  inherited Destroy;
end;

function BindingDetail.GetBindingTemplateArray(Index: Integer): BindingTemplate;
begin
  Result := FbindingTemplate[Index];
end;

function BindingDetail.GetBindingTemplateArrayLength: Integer;
begin
  if Assigned(FbindingTemplate) then
    Result := Length(FbindingTemplate)
  else
  Result := 0;
end;

constructor DiscoveryUrl.Create;
begin
  inherited Create;
  FSerializationOptions := [xoHolderClass,xoAttributeOnLastMember];
end;

constructor DiscoveryURLs.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

destructor DiscoveryURLs.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FdiscoveryUrl)-1 do
    if Assigned(FdiscoveryUrl[I]) then
      FdiscoveryUrl[I].Free;
  SetLength(FdiscoveryUrl, 0);
  inherited Destroy;
end;

function DiscoveryURLs.GetDiscoveryUrlArray(Index: Integer): DiscoveryUrl;
begin
  Result := FdiscoveryUrl[Index];
end;

function DiscoveryURLs.GetDiscoveryUrlArrayLength: Integer;
begin
  if Assigned(FdiscoveryUrl) then
    Result := Length(FdiscoveryUrl)
  else
  Result := 0;
end;

constructor Phone2.Create;
begin
  inherited Create;
  FSerializationOptions := [xoHolderClass,xoAttributeOnLastMember];
end;

constructor Email.Create;
begin
  inherited Create;
  FSerializationOptions := [xoHolderClass,xoAttributeOnLastMember];
end;

constructor Address.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

function Address.GetWideStringArray(Index: Integer): string;
begin
  Result := FaddressLine[Index];
end;

function Address.GetWideStringArrayLength: Integer;
begin
  if Assigned(FaddressLine) then
    Result := Length(FaddressLine)
  else
  Result := 0;
end;

destructor Contact.Destroy;
begin
  if Assigned(Fphone) then
    Fphone.Free;
  if Assigned(Femail) then
    Femail.Free;
  if Assigned(Faddress) then
    Faddress.Free;
  inherited Destroy;
end;

constructor Contacts.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

destructor Contacts.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Fcontact)-1 do
    if Assigned(Fcontact[I]) then
      Fcontact[I].Free;
  SetLength(Fcontact, 0);
  inherited Destroy;
end;

function Contacts.GetContactArray(Index: Integer): Contact;
begin
  Result := Fcontact[Index];
end;

function Contacts.GetContactArrayLength: Integer;
begin
  if Assigned(Fcontact) then
    Result := Length(Fcontact)
  else
  Result := 0;
end;

constructor BindingTemplates.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

destructor BindingTemplates.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FbindingTemplate)-1 do
    if Assigned(FbindingTemplate[I]) then
      FbindingTemplate[I].Free;
  SetLength(FbindingTemplate, 0);
  inherited Destroy;
end;

function BindingTemplates.GetBindingTemplateArray(Index: Integer): BindingTemplate;
begin
  Result := FbindingTemplate[Index];
end;

function BindingTemplates.GetBindingTemplateArrayLength: Integer;
begin
  if Assigned(FbindingTemplate) then
    Result := Length(FbindingTemplate)
  else
  Result := 0;
end;

constructor CategoryBag.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

destructor CategoryBag.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FkeyedReference)-1 do
    if Assigned(FkeyedReference[I]) then
      FkeyedReference[I].Free;
  SetLength(FkeyedReference, 0);
  inherited Destroy;
end;

function CategoryBag.GetKeyedReferenceArray(Index: Integer): KeyedReference;
begin
  Result := FkeyedReference[Index];
end;

function CategoryBag.GetKeyedReferenceArrayLength: Integer;
begin
  if Assigned(FkeyedReference) then
    Result := Length(FkeyedReference)
  else
  Result := 0;
end;

destructor BusinessService.Destroy;
begin
  if Assigned(FbindingTemplates) then
    FbindingTemplates.Free;
  if Assigned(FcategoryBag) then
    FcategoryBag.Free;
  inherited Destroy;
end;

constructor ServiceDetail.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor ServiceDetail.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FbusinessService)-1 do
    if Assigned(FbusinessService[I]) then
      FbusinessService[I].Free;
  SetLength(FbusinessService, 0);
  inherited Destroy;
end;

function ServiceDetail.GetBusinessServiceArray(Index: Integer): BusinessService;
begin
  Result := FbusinessService[Index];
end;

function ServiceDetail.GetBusinessServiceArrayLength: Integer;
begin
  if Assigned(FbusinessService) then
    Result := Length(FbusinessService)
  else
  Result := 0;
end;

constructor BusinessServices.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

destructor BusinessServices.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FbusinessService)-1 do
    if Assigned(FbusinessService[I]) then
      FbusinessService[I].Free;
  SetLength(FbusinessService, 0);
  inherited Destroy;
end;

function BusinessServices.GetBusinessServiceArray(Index: Integer): BusinessService;
begin
  Result := FbusinessService[Index];
end;

function BusinessServices.GetBusinessServiceArrayLength: Integer;
begin
  if Assigned(FbusinessService) then
    Result := Length(FbusinessService)
  else
  Result := 0;
end;

constructor IdentifierBag.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

destructor IdentifierBag.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FkeyedReference)-1 do
    if Assigned(FkeyedReference[I]) then
      FkeyedReference[I].Free;
  SetLength(FkeyedReference, 0);
  inherited Destroy;
end;

function IdentifierBag.GetKeyedReferenceArray(Index: Integer): KeyedReference;
begin
  Result := FkeyedReference[Index];
end;

function IdentifierBag.GetKeyedReferenceArrayLength: Integer;
begin
  if Assigned(FkeyedReference) then
    Result := Length(FkeyedReference)
  else
  Result := 0;
end;

destructor BusinessEntity.Destroy;
begin
  if Assigned(FdiscoveryURLs) then
    FdiscoveryURLs.Free;
  if Assigned(Fcontacts) then
    Fcontacts.Free;
  if Assigned(FbusinessServices) then
    FbusinessServices.Free;
  if Assigned(FidentifierBag) then
    FidentifierBag.Free;
  if Assigned(FcategoryBag) then
    FcategoryBag.Free;
  inherited Destroy;
end;

constructor BusinessDetail.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor BusinessDetail.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FbusinessEntity)-1 do
    if Assigned(FbusinessEntity[I]) then
      FbusinessEntity[I].Free;
  SetLength(FbusinessEntity, 0);
  inherited Destroy;
end;

function BusinessDetail.GetBusinessEntityArray(Index: Integer): BusinessEntity;
begin
  Result := FbusinessEntity[Index];
end;

function BusinessDetail.GetBusinessEntityArrayLength: Integer;
begin
  if Assigned(FbusinessEntity) then
    Result := Length(FbusinessEntity)
  else
  Result := 0;
end;

destructor BusinessEntityExt.Destroy;
begin
  if Assigned(FbusinessEntity) then
    FbusinessEntity.Free;
  inherited Destroy;
end;

constructor BusinessDetailExt.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor BusinessDetailExt.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FbusinessEntityExt)-1 do
    if Assigned(FbusinessEntityExt[I]) then
      FbusinessEntityExt[I].Free;
  SetLength(FbusinessEntityExt, 0);
  inherited Destroy;
end;

function BusinessDetailExt.GetBusinessEntityExtArray(Index: Integer): BusinessEntityExt;
begin
  Result := FbusinessEntityExt[Index];
end;

function BusinessDetailExt.GetBusinessEntityExtArrayLength: Integer;
begin
  if Assigned(FbusinessEntityExt) then
    Result := Length(FbusinessEntityExt)
  else
  Result := 0;
end;

constructor ServiceInfos.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

destructor ServiceInfos.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FserviceInfo)-1 do
    if Assigned(FserviceInfo[I]) then
      FserviceInfo[I].Free;
  SetLength(FserviceInfo, 0);
  inherited Destroy;
end;

function ServiceInfos.GetServiceInfoArray(Index: Integer): ServiceInfo;
begin
  Result := FserviceInfo[Index];
end;

function ServiceInfos.GetServiceInfoArrayLength: Integer;
begin
  if Assigned(FserviceInfo) then
    Result := Length(FserviceInfo)
  else
  Result := 0;
end;

constructor ServiceList.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor ServiceList.Destroy;
begin
  if Assigned(FserviceInfos) then
    FserviceInfos.Free;
  inherited Destroy;
end;

destructor BusinessInfo.Destroy;
begin
  if Assigned(FserviceInfos) then
    FserviceInfos.Free;
  inherited Destroy;
end;

constructor BusinessInfos.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

destructor BusinessInfos.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FbusinessInfo)-1 do
    if Assigned(FbusinessInfo[I]) then
      FbusinessInfo[I].Free;
  SetLength(FbusinessInfo, 0);
  inherited Destroy;
end;

function BusinessInfos.GetBusinessInfoArray(Index: Integer): BusinessInfo;
begin
  Result := FbusinessInfo[Index];
end;

function BusinessInfos.GetBusinessInfoArrayLength: Integer;
begin
  if Assigned(FbusinessInfo) then
    Result := Length(FbusinessInfo)
  else
  Result := 0;
end;

constructor BusinessList.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor BusinessList.Destroy;
begin
  if Assigned(FbusinessInfos) then
    FbusinessInfos.Free;
  inherited Destroy;
end;

constructor FindQualifiers.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

function FindQualifiers.GetWideStringArray(Index: Integer): string;
begin
  Result := FfindQualifier[Index];
end;

function FindQualifiers.GetWideStringArrayLength: Integer;
begin
  if Assigned(FfindQualifier) then
    Result := Length(FfindQualifier)
  else
  Result := 0;
end;

constructor FindTModel.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor FindTModel.Destroy;
begin
  if Assigned(FfindQualifiers) then
    FfindQualifiers.Free;
  if Assigned(FidentifierBag) then
    FidentifierBag.Free;
  if Assigned(FcategoryBag) then
    FcategoryBag.Free;
  inherited Destroy;
end;

constructor TModelBag.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

function TModelBag.GetWideStringArray(Index: Integer): string;
begin
  Result := FtModelKey[Index];
end;

function TModelBag.GetWideStringArrayLength: Integer;
begin
  if Assigned(FtModelKey) then
    Result := Length(FtModelKey)
  else
  Result := 0;
end;

constructor FindBinding.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor FindBinding.Destroy;
begin
  if Assigned(FfindQualifiers) then
    FfindQualifiers.Free;
  if Assigned(FtModelBag) then
    FtModelBag.Free;
  inherited Destroy;
end;

constructor FindBusiness.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor FindBusiness.Destroy;
begin
  if Assigned(FfindQualifiers) then
    FfindQualifiers.Free;
  if Assigned(FidentifierBag) then
    FidentifierBag.Free;
  if Assigned(FcategoryBag) then
    FcategoryBag.Free;
  if Assigned(FtModelBag) then
    FtModelBag.Free;
  if Assigned(FdiscoveryURLs) then
    FdiscoveryURLs.Free;
  inherited Destroy;
end;

constructor FindService.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor FindService.Destroy;
begin
  if Assigned(FfindQualifiers) then
    FfindQualifiers.Free;
  if Assigned(FcategoryBag) then
    FcategoryBag.Free;
  if Assigned(FtModelBag) then
    FtModelBag.Free;
  inherited Destroy;
end;

constructor GetTModelDetail.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

function GetTModelDetail.GetWideStringArray(Index: Integer): string;
begin
  Result := FtModelKey[Index];
end;

function GetTModelDetail.GetWideStringArrayLength: Integer;
begin
  if Assigned(FtModelKey) then
    Result := Length(FtModelKey)
  else
  Result := 0;
end;

constructor GetBindingDetail.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

function GetBindingDetail.GetWideStringArray(Index: Integer): string;
begin
  Result := FbindingKey[Index];
end;

function GetBindingDetail.GetWideStringArrayLength: Integer;
begin
  if Assigned(FbindingKey) then
    Result := Length(FbindingKey)
  else
  Result := 0;
end;

constructor GetBusinessDetailExt.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

function GetBusinessDetailExt.GetWideStringArray(Index: Integer): string;
begin
  Result := FbusinessKey[Index];
end;

function GetBusinessDetailExt.GetWideStringArrayLength: Integer;
begin
  if Assigned(FbusinessKey) then
    Result := Length(FbusinessKey)
  else
  Result := 0;
end;

constructor GetBusinessDetail.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

function GetBusinessDetail.GetWideStringArray(Index: Integer): string;
begin
  Result := FbusinessKey[Index];
end;

function GetBusinessDetail.GetWideStringArrayLength: Integer;
begin
  if Assigned(FbusinessKey) then
    Result := Length(FbusinessKey)
  else
  Result := 0;
end;

constructor GetServiceDetail.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

function GetServiceDetail.GetWideStringArray(Index: Integer): string;
begin
  Result := FserviceKey[Index];
end;

function GetServiceDetail.GetWideStringArrayLength: Integer;
begin
  if Assigned(FserviceKey) then
    Result := Length(FserviceKey)
  else
  Result := 0;
end;

constructor TModelInfos.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

destructor TModelInfos.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FtModelInfo)-1 do
    if Assigned(FtModelInfo[I]) then
      FtModelInfo[I].Free;
  SetLength(FtModelInfo, 0);
  inherited Destroy;
end;

function TModelInfos.GetTModelInfoArray(Index: Integer): TModelInfo;
begin
  Result := FtModelInfo[Index];
end;

function TModelInfos.GetTModelInfoArrayLength: Integer;
begin
  if Assigned(FtModelInfo) then
    Result := Length(FtModelInfo)
  else
  Result := 0;
end;

constructor TModelList.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor TModelList.Destroy;
begin
  if Assigned(FtModelInfos) then
    FtModelInfos.Free;
  inherited Destroy;
end;

destructor TModel.Destroy;
begin
  if Assigned(FoverviewDoc) then
    FoverviewDoc.Free;
  if Assigned(FidentifierBag) then
    FidentifierBag.Free;
  if Assigned(FcategoryBag) then
    FcategoryBag.Free;
  inherited Destroy;
end;

constructor TModelDetail.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor TModelDetail.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FtModel)-1 do
    if Assigned(FtModel[I]) then
      FtModel[I].Free;
  SetLength(FtModel, 0);
  inherited Destroy;
end;

function TModelDetail.GetTModelArray(Index: Integer): TModel;
begin
  Result := FtModel[Index];
end;

function TModelDetail.GetTModelArrayLength: Integer;
begin
  if Assigned(FtModel) then
    Result := Length(FtModel)
  else
  Result := 0;
end;


procedure InitInquireV1Types;
begin
  InvRegistry.RegisterInterface(TypeInfo(InquireSoap), 'urn:uddi-org:api', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(InquireSoap), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(InquireSoap), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(InquireSoap), ioLiteral);
  RemClassRegistry.RegisterXSInfo(TypeInfo(bindingDetail2), 'urn:uddi-org:api', 'bindingDetail2', 'bindingDetail');
  RemClassRegistry.RegisterXSInfo(TypeInfo(serviceDetail2), 'urn:uddi-org:api', 'serviceDetail2', 'serviceDetail');
  RemClassRegistry.RegisterXSInfo(TypeInfo(businessDetail2), 'urn:uddi-org:api', 'businessDetail2', 'businessDetail');
  RemClassRegistry.RegisterXSInfo(TypeInfo(businessDetailExt2), 'urn:uddi-org:api', 'businessDetailExt2', 'businessDetailExt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(serviceList2), 'urn:uddi-org:api', 'serviceList2', 'serviceList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(businessList2), 'urn:uddi-org:api', 'businessList2', 'businessList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(find_tModel), 'urn:uddi-org:api', 'find_tModel');
  RemClassRegistry.RegisterXSInfo(TypeInfo(find_binding), 'urn:uddi-org:api', 'find_binding');
  RemClassRegistry.RegisterXSInfo(TypeInfo(find_business), 'urn:uddi-org:api', 'find_business');
  RemClassRegistry.RegisterXSInfo(TypeInfo(find_service), 'urn:uddi-org:api', 'find_service');
  RemClassRegistry.RegisterXSInfo(TypeInfo(get_tModelDetail), 'urn:uddi-org:api', 'get_tModelDetail');
  RemClassRegistry.RegisterXSInfo(TypeInfo(get_bindingDetail), 'urn:uddi-org:api', 'get_bindingDetail');
  RemClassRegistry.RegisterXSInfo(TypeInfo(get_businessDetailExt), 'urn:uddi-org:api', 'get_businessDetailExt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(get_businessDetail), 'urn:uddi-org:api', 'get_businessDetail');
  RemClassRegistry.RegisterXSInfo(TypeInfo(get_serviceDetail), 'urn:uddi-org:api', 'get_serviceDetail');
  RemClassRegistry.RegisterXSInfo(TypeInfo(tModelList2), 'urn:uddi-org:api', 'tModelList2', 'tModelList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(tModelDetail2), 'urn:uddi-org:api', 'tModelDetail2', 'tModelDetail');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Truncated), 'urn:uddi-org:api', 'Truncated');
  RemClassRegistry.RegisterXSInfo(TypeInfo(URLType), 'urn:uddi-org:api', 'URLType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Description), 'urn:uddi-org:api', 'Description');
  RemClassRegistry.RegisterXSClass(AccessPoint, 'urn:uddi-org:api', 'AccessPoint');
  RemClassRegistry.RegisterSerializeOptions(AccessPoint, [xoHolderClass,xoAttributeOnLastMember]);
  RemClassRegistry.RegisterXSClass(HostingRedirector, 'urn:uddi-org:api', 'HostingRedirector');
  RemClassRegistry.RegisterXSClass(OverviewDoc, 'urn:uddi-org:api', 'OverviewDoc');
  RemClassRegistry.RegisterXSClass(InstanceDetails, 'urn:uddi-org:api', 'InstanceDetails');
  RemClassRegistry.RegisterXSClass(TModelInstanceInfo, 'urn:uddi-org:api', 'TModelInstanceInfo');
  RemClassRegistry.RegisterXSInfo(TypeInfo(tModelInstanceInfo2), 'urn:uddi-org:api', 'tModelInstanceInfo2', 'tModelInstanceInfo');
  RemClassRegistry.RegisterXSClass(TModelInstanceDetails, 'urn:uddi-org:api', 'TModelInstanceDetails');
  RemClassRegistry.RegisterSerializeOptions(TModelInstanceDetails, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(BindingTemplate, 'urn:uddi-org:api', 'BindingTemplate');
  RemClassRegistry.RegisterXSInfo(TypeInfo(bindingTemplate2), 'urn:uddi-org:api', 'bindingTemplate2', 'bindingTemplate');
  RemClassRegistry.RegisterXSClass(BindingDetail, 'urn:uddi-org:api', 'BindingDetail');
  RemClassRegistry.RegisterSerializeOptions(BindingDetail, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(DiscoveryUrl, 'urn:uddi-org:api', 'DiscoveryUrl');
  RemClassRegistry.RegisterSerializeOptions(DiscoveryUrl, [xoHolderClass,xoAttributeOnLastMember]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(discoveryUrl2), 'urn:uddi-org:api', 'discoveryUrl2', 'discoveryUrl');
  RemClassRegistry.RegisterXSClass(DiscoveryURLs, 'urn:uddi-org:api', 'DiscoveryURLs');
  RemClassRegistry.RegisterSerializeOptions(DiscoveryURLs, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(Phone2, 'urn:uddi-org:api', 'Phone2', 'Phone');
  RemClassRegistry.RegisterSerializeOptions(Phone2, [xoHolderClass,xoAttributeOnLastMember]);
  RemClassRegistry.RegisterXSClass(Email, 'urn:uddi-org:api', 'Email');
  RemClassRegistry.RegisterSerializeOptions(Email, [xoHolderClass,xoAttributeOnLastMember]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(addressLine), 'urn:uddi-org:api', 'addressLine');
  RemClassRegistry.RegisterXSClass(Address, 'urn:uddi-org:api', 'Address');
  RemClassRegistry.RegisterSerializeOptions(Address, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(Contact, 'urn:uddi-org:api', 'Contact');
  RemClassRegistry.RegisterXSInfo(TypeInfo(contact2), 'urn:uddi-org:api', 'contact2', 'contact');
  RemClassRegistry.RegisterXSClass(Contacts, 'urn:uddi-org:api', 'Contacts');
  RemClassRegistry.RegisterSerializeOptions(Contacts, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(BindingTemplates, 'urn:uddi-org:api', 'BindingTemplates');
  RemClassRegistry.RegisterSerializeOptions(BindingTemplates, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(KeyedReference, 'urn:uddi-org:api', 'KeyedReference');
  RemClassRegistry.RegisterXSInfo(TypeInfo(keyedReference2), 'urn:uddi-org:api', 'keyedReference2', 'keyedReference');
  RemClassRegistry.RegisterXSClass(CategoryBag, 'urn:uddi-org:api', 'CategoryBag');
  RemClassRegistry.RegisterSerializeOptions(CategoryBag, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(BusinessService, 'urn:uddi-org:api', 'BusinessService');
  RemClassRegistry.RegisterXSInfo(TypeInfo(businessService2), 'urn:uddi-org:api', 'businessService2', 'businessService');
  RemClassRegistry.RegisterXSClass(ServiceDetail, 'urn:uddi-org:api', 'ServiceDetail');
  RemClassRegistry.RegisterSerializeOptions(ServiceDetail, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(BusinessServices, 'urn:uddi-org:api', 'BusinessServices');
  RemClassRegistry.RegisterSerializeOptions(BusinessServices, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(IdentifierBag, 'urn:uddi-org:api', 'IdentifierBag');
  RemClassRegistry.RegisterSerializeOptions(IdentifierBag, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(BusinessEntity, 'urn:uddi-org:api', 'BusinessEntity');
  RemClassRegistry.RegisterXSInfo(TypeInfo(businessEntity2), 'urn:uddi-org:api', 'businessEntity2', 'businessEntity');
  RemClassRegistry.RegisterXSClass(BusinessDetail, 'urn:uddi-org:api', 'BusinessDetail');
  RemClassRegistry.RegisterSerializeOptions(BusinessDetail, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(BusinessEntityExt, 'urn:uddi-org:api', 'BusinessEntityExt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(businessEntityExt2), 'urn:uddi-org:api', 'businessEntityExt2', 'businessEntityExt');
  RemClassRegistry.RegisterXSClass(BusinessDetailExt, 'urn:uddi-org:api', 'BusinessDetailExt');
  RemClassRegistry.RegisterSerializeOptions(BusinessDetailExt, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(ServiceInfo, 'urn:uddi-org:api', 'ServiceInfo');
  RemClassRegistry.RegisterXSInfo(TypeInfo(serviceInfo2), 'urn:uddi-org:api', 'serviceInfo2', 'serviceInfo');
  RemClassRegistry.RegisterXSClass(ServiceInfos, 'urn:uddi-org:api', 'ServiceInfos');
  RemClassRegistry.RegisterSerializeOptions(ServiceInfos, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(ServiceList, 'urn:uddi-org:api', 'ServiceList');
  RemClassRegistry.RegisterSerializeOptions(ServiceList, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(BusinessInfo, 'urn:uddi-org:api', 'BusinessInfo');
  RemClassRegistry.RegisterXSInfo(TypeInfo(businessInfo2), 'urn:uddi-org:api', 'businessInfo2', 'businessInfo');
  RemClassRegistry.RegisterXSClass(BusinessInfos, 'urn:uddi-org:api', 'BusinessInfos');
  RemClassRegistry.RegisterSerializeOptions(BusinessInfos, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(BusinessList, 'urn:uddi-org:api', 'BusinessList');
  RemClassRegistry.RegisterSerializeOptions(BusinessList, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(findQualifier), 'urn:uddi-org:api', 'findQualifier');
  RemClassRegistry.RegisterXSClass(FindQualifiers, 'urn:uddi-org:api', 'FindQualifiers');
  RemClassRegistry.RegisterSerializeOptions(FindQualifiers, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(FindTModel, 'urn:uddi-org:api', 'FindTModel');
  RemClassRegistry.RegisterSerializeOptions(FindTModel, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(tModelKey), 'urn:uddi-org:api', 'tModelKey');
  RemClassRegistry.RegisterXSClass(TModelBag, 'urn:uddi-org:api', 'TModelBag');
  RemClassRegistry.RegisterSerializeOptions(TModelBag, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(FindBinding, 'urn:uddi-org:api', 'FindBinding');
  RemClassRegistry.RegisterSerializeOptions(FindBinding, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(FindBusiness, 'urn:uddi-org:api', 'FindBusiness');
  RemClassRegistry.RegisterSerializeOptions(FindBusiness, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(FindService, 'urn:uddi-org:api', 'FindService');
  RemClassRegistry.RegisterSerializeOptions(FindService, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(GetTModelDetail, 'urn:uddi-org:api', 'GetTModelDetail');
  RemClassRegistry.RegisterSerializeOptions(GetTModelDetail, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(bindingKey), 'urn:uddi-org:api', 'bindingKey');
  RemClassRegistry.RegisterXSClass(GetBindingDetail, 'urn:uddi-org:api', 'GetBindingDetail');
  RemClassRegistry.RegisterSerializeOptions(GetBindingDetail, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(businessKey), 'urn:uddi-org:api', 'businessKey');
  RemClassRegistry.RegisterXSClass(GetBusinessDetailExt, 'urn:uddi-org:api', 'GetBusinessDetailExt');
  RemClassRegistry.RegisterSerializeOptions(GetBusinessDetailExt, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(GetBusinessDetail, 'urn:uddi-org:api', 'GetBusinessDetail');
  RemClassRegistry.RegisterSerializeOptions(GetBusinessDetail, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(serviceKey), 'urn:uddi-org:api', 'serviceKey');
  RemClassRegistry.RegisterXSClass(GetServiceDetail, 'urn:uddi-org:api', 'GetServiceDetail');
  RemClassRegistry.RegisterSerializeOptions(GetServiceDetail, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(TModelInfo, 'urn:uddi-org:api', 'TModelInfo');
  RemClassRegistry.RegisterXSInfo(TypeInfo(tModelInfo2), 'urn:uddi-org:api', 'tModelInfo2', 'tModelInfo');
  RemClassRegistry.RegisterXSClass(TModelInfos, 'urn:uddi-org:api', 'TModelInfos');
  RemClassRegistry.RegisterSerializeOptions(TModelInfos, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(TModelList, 'urn:uddi-org:api', 'TModelList');
  RemClassRegistry.RegisterSerializeOptions(TModelList, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(TModel, 'urn:uddi-org:api', 'TModel');
  RemClassRegistry.RegisterXSInfo(TypeInfo(tModel2), 'urn:uddi-org:api', 'tModel2', 'tModel');
  RemClassRegistry.RegisterXSClass(TModelDetail, 'urn:uddi-org:api', 'TModelDetail');
  RemClassRegistry.RegisterSerializeOptions(TModelDetail, [xoInlineArrays,xoLiteralParam]);
end;

end.
