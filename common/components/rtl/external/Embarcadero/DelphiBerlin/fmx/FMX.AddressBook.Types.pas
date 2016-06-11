{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.AddressBook.Types;

{$SCOPEDENUMS ON}

interface

uses
  System.SysUtils, System.Generics.Collections;

type

  /// <summary>Base exception class for Address Book</summary>
  EAddressBookException = class(Exception);
  /// <summary>Used, when input arguments is wrong</summary>
  EAddressBookWrongArgs = class(EAddressBookException);
  /// <summary>Used, as result of performing request</summary>
  EAddressBookExecute = class(EAddressBookException);
  /// <summary>Exception of accessing to perform operation or to fetch data</summary>
  EAddressBookAccess = class(EAddressBookException);

  /// <summary>Event handler for receiving results of requesting access to Address Book</summary>
  TPermissionRequestEvent = procedure (ASender: TObject; const AMessage: string; const AAccessGranted: Boolean) of object;

  /// <summary>Event handler for receiving notification about changing of contact info.</summary>
  TExternalChangeEvent = procedure (ASender: TObject) of object;

  /// <summary>Types of accessing for working with Address Book</summary>
  TAddressBookAccessType = (Read, Write);

  /// <summary>Different possible values for the authorization status of an app</summary>
  TAuthorizationStatus = (NotDetermined, Restricted, Denied, Authorized);

  /// <summary>Kinds of contact data</summary>
  TContactField = (FirstName, LastName, MiddleName, Prefix, Suffix, NickName, FirstNamePhonetic, LastNamePhonetic,
    MiddleNamePhonetic, Organization, JobTitle, Department, Photo, PhotoThumbnail, Note, URLs, EMails, Addresses,
    Phones, Dates, RelatedNames, MessagingServices, Birthday, {iOS only} SocialProfiles, CreationDate, ModificationDate);

  /// <summary>Set of contact data kinds</summary>
  TContactFields = set of TContactField;

  /// <summary>Helper for <c>TPersonField</c> type for returning string presentation of type's values</summary>
  TContactFieldHelper = record helper for TContactField
    /// <summary>Returns string presentation of enumeration type value</summary>
    function ToString: string;
  end;

  /// <summary>Kind of contact</summary>
  TContactKind = (Person, Organization);

{ Address }

  /// <summary>Address information</summary>
  TContactAddress = class
  public type
    /// <summary>Address label kind</summary>
    TLabelKind = (Custom, Home, Work, Other);
    /// <summary>Address label kinds</summary>
    TLabelKinds = set of TLabelKind;
  private
    FLabelKind: TLabelKind;
    FLabelText: string;
    FCountry: string;
    FState: string;
    FCity: string;
    FZIP: string;
    FStreet: string;
    procedure SetLabelKind(const AValue: TLabelKind);
    procedure SetLabelText(const AValue: string);
    function GetLabelText: string;
  public
    /// <summary>Creates instance of address with kind = <c>Custom</c></summary>
    constructor Create; overload;
    /// <summary>Creates instance of address with spicified kind</summary>
    constructor Create(const AKind: TLabelKind; const ACountry, AState, ACity, AZIP, AStreet: string); overload;
    /// <summary>Creates instance of address with spicified label</summary>
    constructor Create(const ALabel: string; const ACountry, AState, ACity, AZIP, AStreet: string); overload;
    /// <summary>Returns set of supported kinds on current platform.</summary>
    class function SupportedLabelKinds: TLabelKinds;
    /// <summary>Returns true if specified kind is supported on current platform.</summary>
    function IsLabelKindSupported: Boolean;
    { Debug }
    /// <summary>String presentation of address</summary>
    function ToString: string; override;
  public
    /// <summary>Kind of Address label. Resets label.</summary>
    /// <remarks>If current platform doesn't support specified kind (see <c>SupportedKinds</c>), AddressBook will use
    /// <c>Custom</c> instead and will automatically convert kind to label.</remarks>
    property LabelKind: TLabelKind read FLabelKind write SetLabelKind;
    /// <summary>Address label</summary>
    /// <remarks>Returns label for specified kind. If you set custom label it will reset <c>Kind</c> to
    /// <c>Custom</c></remarks>
    property LabelText: string read GetLabelText write SetLabelText;
    /// <summary>Country</summary>
    property Country: string read FCountry write FCountry;
    /// <summary>State or Region</summary>
    property State: string read FState write FState;
    /// <summary>City</summary>
    property City: string read FCity write FCity;
    /// <summary>ZIP code</summary>
    property ZIP: string read FZIP write FZIP;
    /// <summary>Street</summary>
    property Street: string read FStreet write FStreet;
  end;

  /// <summary>List of addresses</summary>
  TContactAddresses = class(TObjectList<TContactAddress>)
  public
    /// <summary>Add instance of address with specified address label</summary>
    function AddAddress(const ALabel, ACountry, AState, ACity, AZIP, AStreet: string): TContactAddress; overload;
    /// <summary>Add instance of address with specified kind of address label</summary>
    function AddAddress(const AKind: TContactAddress.TLabelKind; const ACountry, AState, ACity, AZIP, AStreet: string): TContactAddress; overload;
  end;

{ Social Profile }

  /// <summary>Information about social profile</summary>
  TContactSocialProfile = class
  public type
    /// <summary>Social profile label kind</summary>
    TLabelKind = (Custom, Home, Work, Other);
    /// <summary>Social profile label kinds</summary>
    TLabelKinds = set of TLabelKind;
    /// <summary>Service kind</summary>
    TServiceKind = (Custom, Twitter, GameCenter, SinaWeibo, Facebook, Myspace, LinkedIn, Flickr);
    /// <summary>Service kinds</summary>
    TServiceKinds = set of TServiceKind;
  private
    FLabelKind: TLabelKind;
    FLabelText: string;
    FServiceKind: TServiceKind;
    FServiceName: string;
    FURL: string;
    FUserName: string;
    FUserIdentifier: string;
    procedure SetLabelKind(const AValue: TLabelKind);
    procedure SetLabelText(const AValue: string);
    function GetLabelText: string;
    procedure SetServiceKind(const AValue: TServiceKind);
    procedure SetServiceName(const AValue: string);
    function GetServiceName: string;
  public
    /// <summary>Creates instance of social profile with kind = <c>Custom</c></summary>
    constructor Create; overload;
    /// <summary>Creates instance of social profile with specified label</summary>
    constructor Create(const ALabel: string; const AServiceName, AUrl, AUserName, AUserIdentifier: string); overload;
    /// <summary>Creates instance of social profile with specified label kind and service name</summary>
    constructor Create(const ALabelKind: TLabelKind; const AServiceName, AUrl, AUserName, AUserIdentifier: string); overload;
    /// <summary>Creates instance of social profile with specified label and service kind</summary>
    constructor Create(const ALabel: string; const AServiceKind: TServiceKind; const AUrl, AUserName,
      AUserIdentifier: string); overload;
    /// <summary>Creates instance of social profile with specified label kind and service kind</summary>
    constructor Create(const ALabelKind: TLabelKind; const AServiceKind: TServiceKind; const AUrl, AUserName,
      AUserIdentifier: string); overload;
    /// <summary>Returns set of supported social profile label kinds</summary>
    class function SupportedLabelKinds: TLabelKinds;
    /// <summary>Returns set of supported service kinds on current platform.</summary>
    class function SupportedServiceKinds: TServiceKinds;
    /// <summary>Returns true if specified label kind is supported on current platform.</summary>
    function IsLabelKindSupported: Boolean;
    /// <summary>Returns true if specified service kind is supported on current platform.</summary>
    function IsServiceKindSupported: Boolean;
    { Debug }
    /// <summary>String presentation of all profile data</summary>
    function ToString: string; override;
  public
    /// <summary>Service name</summary>
    property ServiceName: string read GetServiceName write SetServiceName;
    /// <summary>Kind of service. Resets label.</summary>
    /// <remarks>If current platform doesn't support specified service kind (see <c>SupportedServiceKinds</c>), AddressBook
    /// will use <c>Custom</c> instead and will automatically convert kind to ServiceName.</remarks>
    property ServiceKind: TServiceKind read FServiceKind write SetServiceKind;
    /// <summary>User name</summary>
    property UserName: string read FUserName write FUserName;
    /// <summary>User identifier</summary>
    property UserIdentifier: string read FUserIdentifier write FUserIdentifier;
    /// <summary>Social profile URL</summary>
    property URL: string read FURL write FURL;
    /// <summary>Kind of label. Resets label.</summary>
    /// <remarks>If current platform doesn't support specified label kind (see <c>SupportedLabelKinds</c>), AddressBook
    /// will use <c>Custom</c> instead and will automatically convert kind to label.</remarks>
    property LabelKind: TLabelKind read FLabelKind write SetLabelKind;
    /// <summary>Label of service</summary>
    /// <remarks>Returns label for specified LabelKind. If you set custom label it will reset <c>LabelKind</c> to
    /// <c>Custom</c></remarks>
    property LabelText: string read GetLabelText write SetLabelText;
  end;

  /// <summary>List of social profiles</summary>
  TContactSocialProfiles = class(TObjectList<TContactSocialProfile>)
  public
    /// <summary>Adds instance of social profile with specified label</summary>
    function AddProfile(const ALabel: string; const AServiceName, AUrl, AUserName,
      AUserIdentifier: string): TContactSocialProfile; overload;
    /// <summary>Adds instance of social profile with specified label kind and service name</summary>
    function AddProfile(const ALabelKind: TContactSocialProfile.TLabelKind; const AServiceName, AUrl, AUserName,
      AUserIdentifier: string): TContactSocialProfile; overload;
    /// <summary>Adds instance of social profile with specified label and service kind</summary>
    function AddProfile(const ALabel: string; const AServiceKind: TContactSocialProfile.TServiceKind; const AUrl,
      AUserName, AUserIdentifier: string): TContactSocialProfile; overload;
    /// <summary>Adds instance of social profile with specified label kind and service kind</summary>
    function AddProfile(const ALabelKind: TContactSocialProfile.TLabelKind;
      const AServiceKind: TContactSocialProfile.TServiceKind; const AUrl, AUserName,
      AUserIdentifier: string): TContactSocialProfile; overload;
  end;

{ Messaging Service }

  /// <summary>Information about messaging service</summary>
  TContactMessagingService = class
  public type
    /// <summary>Messaging service label kind</summary>
    TLabelKind = (Custom, Home, Work, Other);
    /// <summary>Messaging service label kinds</summary>
    TLabelKinds = set of TLabelKind;
    /// <summary>Service kind</summary>
    TServiceKind = (Custom, Yahoo, Jabber, MSN, ICQ, AIM, QQ, GoogleTalk, Skype, Facebook, GaduGadu, NetMeeting);
    /// <summary>Service kinds</summary>
    TServiceKinds = set of TServiceKind;
  private
    FLabelKind: TLabelKind;
    FLabel: string;
    FServiceKind: TServiceKind;
    FServiceName: string;
    FUserName: string;
    procedure SetLabelKind(const AValue: TLabelKind);
    procedure SetLabelText(const AValue: string);
    function GetLabelText: string;
    procedure SetServiceKind(const AValue: TServiceKind);
    procedure SetServiceName(const AValue: string);
    function GetServiceName: string;
  public
    /// <summary>Creates instance of messaging service profile with kind = <c>Custom</c></summary>
    constructor Create; overload;
    /// <summary>Creates instance of messaging service profile with specified label</summary>
    constructor Create(const ALabel: string; const AServiceName, AUserName: string); overload;
    /// <summary>Creates instance of messaging service profile with specified label kind and service name</summary>
    constructor Create(const ALabelKind: TLabelKind; const AServiceName, AUserName: string); overload;
    /// <summary>Creates instance of messaging service profile with specified label and service kind</summary>
    constructor Create(const ALabel: string; const AServiceKind: TServiceKind; const AUserName: string); overload;
    /// <summary>Creates instance of messaging service profile with specified label kind and service kind</summary>
    constructor Create(const ALabelKind: TLabelKind; const AServiceKind: TServiceKind; const AUserName: string); overload;
    /// <summary>Returns set of supported label kinds on current platform.</summary>
    class function SupportedLabelKinds: TLabelKinds;
    /// <summary>Returns set of supported service kinds on current platform.</summary>
    class function SupportedServiceKinds: TServiceKinds;
    /// <summary>Returns true if specified label kind is supported on current platform.</summary>
    function IsLabelKindSupported: Boolean;
    /// <summary>Returns true if specified kind is supported on current platform.</summary>
    function IsServiceKindSupported: Boolean;
    { Debug }
    /// <summary>String presentation of all profile data</summary>
    function ToString: string; override;
  public
    /// <summary>Service name</summary>
    property ServiceName: string read GetServiceName write SetServiceName;
    /// <summary>Kind of service. Resets label.</summary>
    /// <remarks>If current platform doesn't support specified service kind (see <c>SupportedServiceKinds</c>),
    /// AddressBook will use <c>Custom</c> instead and will automatically convert kind to service name.</remarks>
    property ServiceKind: TServiceKind read FServiceKind write SetServiceKind;
    /// <summary>User name</summary>
    property UserName: string read FUserName write FUserName;
    /// <summary>Kind of label. Resets label.</summary>
    /// <remarks>If current platform doesn't support specified label kind (see <c>SupportedLabelKinds</c>),
    /// AddressBook will use <c>Custom</c> instead and will automatically convert kind to label.</remarks>
    property LabelKind: TLabelKind read FLabelKind write SetLabelKind;
    /// <summary>Label of service</summary>
    /// <remarks>Returns label for specified label kind. If you set custom label it will reset <c>KindLabel</c> to
    /// <c>Custom</c></remarks>
    property LabelText: string read GetLabelText write SetLabelText;
  end;

  /// <summary>List of messaging services</summary>
  TContactMessagingServices = class(TObjectList<TContactMessagingService>)
  public
    /// <summary>Adds instance of messaging service profile with specified label</summary>
    function AddProfile(const ALabel: string; const AServiceName, AUserName: string): TContactMessagingService; overload;
    /// <summary>Adds instance of messaging service profile with specified label kind and service name</summary>
    function AddProfile(const ALabelKind: TContactMessagingService.TLabelKind; const AServiceName,
      AUserName: string): TContactMessagingService; overload;
    /// <summary>Adds instance of messaging service profile with specified label and service kind</summary>
    function AddProfile(const ALabel: string; const AServiceKind: TContactMessagingService.TServiceKind;
      const AUserName: string): TContactMessagingService; overload;
    /// <summary>Adds instance of messaging service profile with specified label kind and service kind</summary>
    function AddProfile(const ALabelKind: TContactMessagingService.TLabelKind;
      const AServiceKind: TContactMessagingService.TServiceKind; const AUserName: string): TContactMessagingService; overload;
  end;

{ Dates }

  /// <summary>Information about date event</summary>
  TContactDate = class
  public type
    /// <summary>Event date kind</summary>
    TLabelKind = (Custom, Birthday, Anniversary, Other);
    /// <summary>Event date kinds</summary>
    TLabelKinds = set of TLabelKind;
  private
    FLabelKind: TLabelKind;
    FLabelText: string;
    FDate: TDate;
    procedure SetLabelKind(const AValue: TLabelKind);
    procedure SetLabelText(const AValue: string);
    function GetLabelText: string;
  public
    /// <summary>Creates instance of event date information with kind = <c>Custom</c></summary>
    constructor Create; overload;
    /// <summary>Creates instance of event date information with spicified date</summary>
    constructor Create(const ADate: TDate); overload;
    /// <summary>Creates instance of event date information with spicified date and kind</summary>
    constructor Create(const AKind: TLabelKind; const ADate: TDate); overload;
    /// <summary>Creates instance of event date information with spicified date and label</summary>
    constructor Create(const ALabel: string; const ADate: TDate); overload;
    /// <summary>Returns set of supported event date label kinds on current platform.</summary>
    class function SupportedLabelKinds: TLabelKinds;
    /// <summary>Returns true if specified kind is supported on current platform.</summary>
    function IsLabelKindSupported: Boolean;
  public
    /// <summary>Date</summary>
    property Date: TDate read FDate write FDate;
    /// <summary>Kind of date. Resets label.</summary>
    /// <remarks>If current platform doesn't support specified date kind (see <c>SupportedKinds</c>), AddressBook will
    /// use <c>Custom</c> instead and will automatically convert kind to label.</remarks>
    property LabelKind: TLabelKind read FLabelKind write SetLabelKind;
    /// <summary>Label of date</summary>
    /// <remarks>Returns label for specified kind. If you set custom label it will reset <c>Kind</c> to <c>Custom</c></remarks>
    property LabelText: string read GetLabelText write SetLabelText;
  end;

  /// <summary>List of events dates</summary>
  TContactDates = class(TObjectList<TContactDate>)
  public
    /// <summary>Add phone number of specified kind</summary>
    function AddDate(const AKind: TContactDate.TLabelKind; const ADate: TDate): TContactDate; overload;
    /// <summary>Add phone number with specified label</summary>
    function AddDate(const ALabel: string; const ADate: TDate): TContactDate; overload;
  end;

{ Phones }

  /// <summary>Contact phone information</summary>
  TContactPhone = class
  public type
    /// <summary>Phone kind</summary>
    TLabelKind = (Custom, Home, Mobile, Work, iPhone, FaxWork, FaxHome, FaxOther, Pager, Other, Callback, Car, CompanyMain,
      ISDN, Main, Radio, Telex, TTYTDD, WorkMobile, WorkPager, Assistant);
    /// <summary>Phone kinds</summary>
    TLabelKinds = set of TLabelKind;
  private
    FLabelKind: TLabelKind;
    FLabel: string;
    FNumber: string;
    procedure SetLabelKind(const AValue: TLabelKind);
    procedure SetLabelText(const AValue: string);
    function GetLabelText: string;
  public
    /// <summary>Creates instance of phone information with kind = <c>TPhoneKind.Custom</c></summary>
    constructor Create; overload;
    /// <summary>Creates instance of phone information with spicified phone number and kind</summary>
    constructor Create(const AKind: TLabelKind; const ANumber: string); overload;
    /// <summary>Creates instance of phone information with spicified phone number and label</summary>
    constructor Create(const ALabel: string; const ANumber: string); overload;
    /// <summary>Returns set of supported phone kinds on current platform.</summary>
    class function SupportedLabelKinds: TLabelKinds;
    /// <summary>Returns true if specified kind is supported on current platform.</summary>
    function IsLabelKindSupported: Boolean;
  public
    /// <summary>Phone number</summary>
    property Number: string read FNumber write FNumber;
    /// <summary>Kind of phone. Resets label.</summary>
    /// <remarks>If current platform doesn't support specified phone kind (see <c>SupportedKinds</c>),
    /// AddressBook will use <c>Custom</c> instead and will automatically convert kind to label.</remarks>
    property LabelKind: TLabelKind read FLabelKind write SetLabelKind;
    /// <summary>Caption of number</summary>
    /// <remarks>Returns label for specified kind. If you set custom label it will reset <c>Kind</c> to <c>Custom</c></remarks>
    property LabelText: string read GetLabelText write SetLabelText;
  end;

  /// <summary>List of contact phones</summary>
  TContactPhones = class(TObjectList<TContactPhone>)
  public
    /// <summary>Add phone number of specified kind</summary>
    function AddPhone(const AKind: TContactPhone.TLabelKind; const ANumber: string): TContactPhone; overload;
    /// <summary>Add phone number with specified label</summary>
    function AddPhone(const ALabel: string; const ANumber: string): TContactPhone; overload;
  end;

{ Emails }

  /// <summary>Contact email information</summary>
  TContactEmail = class
  public type
    /// <summary>Email label kind</summary>
    TLabelKind = (Custom, Home, Mobile, Work, Other);
    /// <summary>Email label kinds</summary>
    TLabelKinds = set of TLabelKind;
  private
    FLabelKind: TLabelKind;
    FLabelText: string;
    FEmail: string;
    procedure SetLabelKind(const AValue: TLabelKind);
    procedure SetLabelText(const AValue: string);
    function GetLabelText: string;
  public
    /// <summary>Creates instance of email information with kind = <c>TEmailKind.Custom</c></summary>
    constructor Create; overload;
    /// <summary>Creates instance of email information with spicified email and kind</summary>
    constructor Create(const AKind: TLabelKind; const AEmail: string); overload;
    /// <summary>Creates instance of email information with spicified email and label</summary>
    constructor Create(const ALabel: string; const AEmail: string); overload;
    /// <summary>Returns set of supported emails kinds on current platform.</summary>
    class function SupportedLabelKinds: TLabelKinds;
    /// <summary>Returns true if specified kind is supported on current platform.</summary>
    function IsLabelKindSupported: Boolean;
  public
    /// <summary>Email</summary>
    property Email: string read FEmail write FEmail;
    /// <summary>Kind of email. Resets label.</summary>
    /// <remarks>If current platform doesn't support specified email kind (see <c>SupportedKinds</c>), AddressBook
    /// will use <c>Custom</c> instead and will automatically convert kind to label.</remarks>
    property LabelKind: TLabelKind read FLabelKind write SetLabelKind;
    /// <summary>Caption of email</summary>
    /// <remarks>Returns label for specified kind. If you set custom label it will reset <c>Kind</c> to <c>Custom</c></remarks>
    property LabelText: string read GetLabelText write SetLabelText;
  end;

  /// <summary>List of contact emails</summary>
  TContactEmails = class(TObjectList<TContactEmail>)
  public
    /// <summary>Add email of specified kind</summary>
    function AddEmail(const AKind: TContactEmail.TLabelKind; const AEmail: string): TContactEmail; overload;
    /// <summary>Add email with specified label</summary>
    function AddEmail(const ALabel: string; const AEmail: string): TContactEmail; overload;
  end;

{ Related Names }

  /// <summary>Contact relationship information</summary>
  TContactRelatedName = class
  public type
    /// <summary>Relationship kind</summary>
    TLabelKind = (Custom, Mother, Father, Parent, Sister, Brother, Child, Friend, Spouse, Partner, Manager, Assistant,
      DomesticPartner, ReferredBy, Relative);
    /// <summary>Relationship kinds</summary>
    TLabelKinds = set of TLabelKind;
  private
    FLabelKind: TLabelKind;
    FLabelText: string;
    FName: string;
    procedure SetLabelKind(const AValue: TLabelKind);
    procedure SetLabelText(const AValue: string);
    function GetLabelText: string;
  public
    /// <summary>Creates instance of relationship information with kind = <c>TRelationshipKind.Custom</c></summary>
    constructor Create; overload;
    /// <summary>Creates instance of relationship information with specified name of person and kind</summary>
    constructor Create(const AKind: TLabelKind; const AName: string); overload;
    /// <summary>Creates instance of relationship information with specified name of person and label</summary>
    constructor Create(const ALabel: string; const AName: string); overload;
    /// <summary>Returns set of supported relationships kinds on current platform.</summary>
    class function SupportedLabelKinds: TLabelKinds;
    /// <summary>Returns true if specified kind is supported on current platform.</summary>
    function IsLabelKindSupported: Boolean;
    /// <summary>Name of person</summary>
    property Name: string read FName write FName;
    /// <summary>Kind of relationship. Resets label.</summary>
    /// <remarks>If current platform doesn't support specified kind (see <c>SupportedKinds</c>), AddressBook will use
    /// <c>Custom</c> instead and will automatically convert kind to label.</remarks>
    property LabelKind: TLabelKind read FLabelKind write SetLabelKind;
    /// <summary>Caption of relationship</summary>
    /// <remarks>Returns label for specified kind. If you set custom label it will reset <c>Kind</c> to <c>Custom</c></remarks>
    property LabelText: string read GetLabelText write SetLabelText;
  end;

  /// <summary>List of contact related names</summary>
  TContactRelatedNames = class(TObjectList<TContactRelatedName>)
  public
    /// <summary>Add related name of specified kind</summary>
    function AddRelatedName(const AKind: TContactRelatedName.TLabelKind; const AName: string): TContactRelatedName; overload;
    /// <summary>Add related name with specified label</summary>
    function AddRelatedName(const ALabel: string; const AName: string): TContactRelatedName; overload;
  end;

{ URLs }

  /// <summary>Contact URL information</summary>
  TContactURL = class
  public type
    /// <summary>URL label kind</summary>
    TLabelKind = (Custom, HomePage, Blog, Profile, Home, Work, FTP, Other);
    /// <summary>URL label kinds</summary>
    TLabelKinds = set of TLabelKind;
  private
    FLabelKind: TLabelKind;
    FLabelText: string;
    FURL: string;
    procedure SetLabelKind(const AValue: TLabelKind);
    procedure SetLabelText(const AValue: string);
    function GetLabelText: string;
  public
    /// <summary>Creates instance of URL information with kind = <c>Custom</c></summary>
    constructor Create; overload;
    /// <summary>Creates instance of URL information with spicified email and kind</summary>
    constructor Create(const AKind: TLabelKind; const AURL: string); overload;
    /// <summary>Creates instance of URL information with spicified email and label</summary>
    constructor Create(const ALabel: string; const AURL: string); overload;
    /// <summary>Returns set of supported kinds of URLs on current platform.</summary>
    class function SupportedLabelKinds: TLabelKinds;
    /// <summary>Returns true if specified kind is supported on current platform.</summary>
    function IsLabelKindSupported: Boolean;
  public
    /// <summary>URL</summary>
    property URL: string read FURL write FURL;
    /// <summary>Kind of email. Resets label.</summary>
    /// <remarks>If current platform doesn't support specified URL kind (see <c>SupportedKinds</c>),
    /// AddressBook will use <c>TURLKind.Custom</c> instead and will automatically convert kind to label.</remarks>
    property LabelKind: TLabelKind read FLabelKind write SetLabelKind;
    /// <summary>Caption of URL</summary>
    /// <remarks>Returns label for specified kind. If you set custom label it will reset <c>Kind</c> to
    /// <c>TURLKind.Custom</c></remarks>
    property LabelText: string read GetLabelText write SetLabelText;
  end;

  /// <summary>List of contact URLs</summary>
  TContactURLs = class(TObjectList<TContactURL>)
  public
    /// <summary>Add url of specified kind</summary>
    function AddURL(const AKind: TContactURL.TLabelKind; const AURL: string): TContactURL; overload;
    /// <summary>Add url with specified label</summary>
    function AddURL(const ALabel: string; const AURL: string): TContactURL; overload;
  end;

  /// <summary>Interface for knowing which label kinds are supported</summary>
  IFMXAddressBookSupportedLabelKinds = interface
  ['{842B17FF-8059-4904-A8BF-AD520B4FC0A5}']
    /// <summary>Returns set of supported label kinds of address on current platform.</summary>
    function AddressesLabelKinds: TContactAddress.TLabelKinds;
    /// <summary>Returns set of supported label kinds of social profiles on current platform.</summary>
    function SocialProfilesLabelKinds: TContactSocialProfile.TLabelKinds;
    /// <summary>Returns set of supported service kinds of social profiles on current platform.</summary>
    function SocialProfilesServiceKinds: TContactSocialProfile.TServiceKinds;
    /// <summary>Returns set of supported label kinds of messaging services on current platform.</summary>
    function MessagingServicesLabelKinds: TContactMessagingService.TLabelKinds;
    /// <summary>Returns set of supported service kinds of messaging services on current platform.</summary>
    function MessagingServicesKinds: TContactMessagingService.TServiceKinds;
    /// <summary>Returns set of supported label kinds of dates on current platform.</summary>
    function DatesLabelKinds: TContactDate.TLabelKinds;
    /// <summary>Returns set of supported label kinds of phones on current platform.</summary>
    function PhonesLabelKinds: TContactPhone.TLabelKinds;
    /// <summary>Returns set of supported label kinds of emails on current platform.</summary>
    function EmailsLabelKinds: TContactEmail.TLabelKinds;
    /// <summary>Returns set of supported label kinds of related names on current platform.</summary>
    function RelatedNamesLabelKinds: TContactRelatedName.TLabelKinds;
    /// <summary>Returns set of supported label kinds of URLs on current platform.</summary>
    function URLsLabelKinds: TContactURL.TLabelKinds;
  end;

const
  /// <summary>Set of contact data kinds, which describes the structured name.</summary>
  StructuredNameFields: TContactFields = [TContactField.FirstName, TContactField.LastName, TContactField.MiddleName,
    TContactField.Prefix, TContactField.Suffix, TContactField.FirstNamePhonetic, TContactField.LastNamePhonetic,
    TContactField.MiddleNamePhonetic];
  /// <summary>Set of contact data kinds, which describes company information</summary>
  CompanyFields: TContactFields = [TContactField.Organization, TContactField.JobTitle, TContactField.JobTitle];

implementation

uses
  FMX.Platform, FMX.Consts;

{ TContactMessagingService }

constructor TContactMessagingService.Create;
begin
  inherited Create;
  FServiceKind := TServiceKind.Custom;
  FLabelKind := TLabelKind.Custom;
end;

constructor TContactMessagingService.Create(const ALabel, AServiceName, AUserName: string);
begin
  inherited Create;
  LabelText := ALabel;
  ServiceName := AServiceName;
  FUserName := AUserName;
end;

constructor TContactMessagingService.Create(const ALabelKind: TLabelKind; const AServiceName, AUserName: string);
begin
  inherited Create;
  LabelKind := ALabelKind;
  ServiceName := AServiceName;
  FUserName := AUserName;
end;

constructor TContactMessagingService.Create(const ALabel: string; const AServiceKind: TServiceKind;
  const AUserName: string);
begin
  inherited Create;
  LabelText := ALabel;
  ServiceKind := AServiceKind;
  FUserName := AUserName;
end;

constructor TContactMessagingService.Create(const ALabelKind: TLabelKind; const AServiceKind: TServiceKind;
  const AUserName: string);
begin
  inherited Create;
  LabelKind := ALabelKind;
  ServiceKind := AServiceKind;
  FUserName := AUserName;
end;

function TContactMessagingService.GetLabelText: string;
begin
  case FLabelKind of
    TLabelKind.Custom:
      Result := FLabel;
    TLabelKind.Home:
      Result := SAddressBookHomeLabel;
    TLabelKind.Work:
      Result := SAddressBookWorkLabel;
    TLabelKind.Other:
      Result := SAddressBookOtherLabel;
  else
    Result := FLabel;
  end;
end;

procedure TContactMessagingService.SetServiceName(const AValue: string);
begin
  if FServiceName <> AValue then
  begin
    FServiceName := AValue;
    FServiceKind := TServiceKind.Custom;
  end;
end;

function TContactMessagingService.IsLabelKindSupported: Boolean;
begin
  Result := LabelKind in SupportedLabelKinds;
end;

function TContactMessagingService.IsServiceKindSupported: Boolean;
begin
  Result := ServiceKind in SupportedServiceKinds;
end;

procedure TContactMessagingService.SetLabelKind(const AValue: TLabelKind);
begin
  if FLabelKind <> AValue then
  begin
    FLabelKind := AValue;
    FLabel := string.Empty;
  end;
end;

procedure TContactMessagingService.SetLabelText(const AValue: string);
begin
  if FLabel <> AValue then
  begin
    FLabel := AValue;
    FLabelKind := TLabelKind.Custom;
  end;
end;

function TContactMessagingService.GetServiceName: string;
begin
  case FServiceKind of
    TServiceKind.Custom:
      Result := FServiceName;
    TServiceKind.Yahoo:
      Result := SProtocolYahoo;
    TServiceKind.Jabber:
      Result := SProtocolJabber;
    TServiceKind.MSN:
      Result := SProtocolMSN;
    TServiceKind.ICQ:
      Result := SProtocolICQ;
    TServiceKind.AIM:
      Result := SProtocolAIM;
    TServiceKind.QQ:
      Result := SProtocolQQ;
    TServiceKind.GoogleTalk:
      Result := SProtocolGoogleTalk;
    TServiceKind.Skype:
      Result := SProtocolSkype;
    TServiceKind.Facebook:
      Result := SProtocolFacebook;
    TServiceKind.GaduGadu:
      Result := SProtocolGaduGadu;
    TServiceKind.NetMeeting:
      Result := SProtocolNetMeeting;
  else
    Result := FServiceName;
  end;
end;

procedure TContactMessagingService.SetServiceKind(const AValue: TServiceKind);
begin
  if FServiceKind <> AValue then
  begin
    FServiceKind := AValue;
    FServiceName := string.Empty;
  end;
end;

class function TContactMessagingService.SupportedLabelKinds: TLabelKinds;
var
  SupportedLabelKindsService: IFMXAddressBookSupportedLabelKinds;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXAddressBookSupportedLabelKinds, SupportedLabelKindsService) then
    Result := SupportedLabelKindsService.MessagingServicesLabelKinds
  else
    Result := [];
end;

class function TContactMessagingService.SupportedServiceKinds: TServiceKinds;
var
  SupportedLabelKindsService: IFMXAddressBookSupportedLabelKinds;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXAddressBookSupportedLabelKinds, SupportedLabelKindsService) then
    Result := SupportedLabelKindsService.MessagingServicesKinds
  else
    Result := [];
end;

function TContactMessagingService.ToString: string;
begin
  Result := Format('%s %s %s', [LabelText, ServiceName, UserName]);
end;

{ TContactFieldHelper }

function TContactFieldHelper.ToString: string;
begin
  case Self of
    TContactField.FirstName:
      Result := SFirstName;
    TContactField.LastName:
      Result := SLastName;
    TContactField.MiddleName:
      Result := SMiddleName;
    TContactField.Prefix:
      Result := SPrefix;
    TContactField.Suffix:
      Result := SSuffix;
    TContactField.NickName:
      Result := SNickName;
    TContactField.FirstNamePhonetic:
      Result := SFirstNamePhonetic;
    TContactField.LastNamePhonetic:
      Result := SLastNamePhonetic;
    TContactField.MiddleNamePhonetic:
      Result := SMiddleNamePhonetic;
    TContactField.Organization:
      Result := SOrganization;
    TContactField.JobTitle:
      Result := SJobTitle;
    TContactField.Department:
      Result := SDepartment;
    TContactField.Photo:
      Result := SPhoto;
    TContactField.PhotoThumbnail:
      Result := SPhotoThumbnail;
    TContactField.Note:
      Result := SNote;
    TContactField.URLs:
      Result := SURLs;
    TContactField.EMails:
      Result := SEmails;
    TContactField.Addresses:
      Result := SAddresses;
    TContactField.Phones:
      Result := SPhones;
    TContactField.Dates:
      Result := SDates;
    TContactField.RelatedNames:
      Result := SRelatedNames;
    TContactField.MessagingServices:
      Result := SMessagingServices;
    TContactField.Birthday:
      Result := SBirthday;
    TContactField.CreationDate:
      Result := SCreationDate;
    TContactField.ModificationDate:
      Result := SModificationDate;
    TContactField.SocialProfiles:
      Result := SSocialProfiles;
  else
    Result := SUnknowType;
  end;
end;

{ TContactTelephone }

constructor TContactPhone.Create;
begin
  inherited Create;
  LabelKind := TLabelKind.Custom;
end;

constructor TContactPhone.Create(const AKind: TLabelKind; const ANumber: string);
begin
  inherited Create;
  LabelKind := AKind;
  FNumber := ANumber;
end;

constructor TContactPhone.Create(const ALabel: string; const ANumber: string);
begin
  inherited Create;
  LabelText := ALabel;
  FNumber := ANumber;
end;

function TContactPhone.GetLabelText: string;
begin
  case FLabelKind of
    TLabelKind.Custom:
      Result := FLabel;
    TLabelKind.Home:
      Result := SPhoneHome;
    TLabelKind.Mobile:
      Result := SPhoneMobile;
    TLabelKind.Work:
      Result := SPhoneWork;
    TLabelKind.iPhone:
      Result := SPhoneIPhone;
    TLabelKind.FaxWork:
      Result := SPhoneFaxWork;
    TLabelKind.FaxHome:
      Result := SPhoneFaxHome;
    TLabelKind.FaxOther:
      Result := SPhoneFaxOther;
    TLabelKind.Pager:
      Result := SPhonePager;
    TLabelKind.Other:
      Result := SPhoneOther;
    TLabelKind.Callback:
      Result := SPhoneCallback;
    TLabelKind.Car:
      Result := SPhoneCar;
    TLabelKind.CompanyMain:
      Result := SPhoneCompanyMain;
    TLabelKind.ISDN:
      Result := SPhoneISDN;
    TLabelKind.Main:
      Result := SPhoneMain;
    TLabelKind.Radio:
      Result := SPhoneRadio;
    TLabelKind.Telex:
      Result := SPhoneTelex;
    TLabelKind.TTYTDD:
      Result := SPhoneTTYTDD;
    TLabelKind.WorkMobile:
      Result := SPhoneWorkMobile;
    TLabelKind.WorkPager:
      Result := SPhoneWorkPager;
    TLabelKind.Assistant:
      Result := SPhoneAssistant;
  else
    Result := FLabel;
  end;
end;

function TContactPhone.IsLabelKindSupported: Boolean;
begin
  Result := LabelKind in SupportedLabelKinds;
end;

procedure TContactPhone.SetLabelKind(const AValue: TLabelKind);
begin
  if FLabelKind <> AValue then
  begin
    FLabelKind := AValue;
    FLabel := string.Empty;
  end;
end;

procedure TContactPhone.SetLabelText(const AValue: string);
begin
  if FLabel <> AValue then
  begin
    FLabelKind := TLabelKind.Custom;
    FLabel := AValue;
  end;
end;

class function TContactPhone.SupportedLabelKinds: TLabelKinds;
var
  SupportedLabelKindsService: IFMXAddressBookSupportedLabelKinds;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXAddressBookSupportedLabelKinds, SupportedLabelKindsService) then
    Result := SupportedLabelKindsService.PhonesLabelKinds
  else
    Result := [];
end;

{ TContactTelephones }

function TContactPhones.AddPhone(const AKind: TContactPhone.TLabelKind; const ANumber: string): TContactPhone;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactPhone.Create(AKind, ANumber));
  Result := Items[ItemIdx];
end;

function TContactPhones.AddPhone(const ALabel: string; const ANumber: string): TContactPhone;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactPhone.Create(ALabel, ANumber));
  Result := Items[ItemIdx];
end;

{ TContactEmail }

constructor TContactEmail.Create;
begin
  inherited Create;
  LabelKind := TLabelKind.Custom;
end;

constructor TContactEmail.Create(const AKind: TLabelKind; const AEmail: string);
begin
  inherited Create;
  LabelKind := AKind;
  FEmail := AEmail;
end;

constructor TContactEmail.Create(const ALabel: string; const AEmail: string);
begin
  inherited Create;
  LabelText := ALabel;
  FEmail := AEmail;
end;

function TContactEmail.GetLabelText: string;
begin
  case FLabelKind of
    TLabelKind.Custom:
      Result := FLabelText;
    TLabelKind.Home:
      Result := SAddressBookHomeLabel;
    TLabelKind.Mobile:
      Result := SEmailsMobile;
    TLabelKind.Work:
      Result := SAddressBookWorkLabel;
    TLabelKind.Other:
      Result := SAddressBookOtherLabel;
  else
    Result := FLabelText;
  end;
end;

function TContactEmail.IsLabelKindSupported: Boolean;
begin
  Result := LabelKind in SupportedLabelKinds;
end;

procedure TContactEmail.SetLabelKind(const AValue: TLabelKind);
begin
  if FLabelKind <> AValue then
  begin
    FLabelKind := AValue;
    FLabelText := string.Empty;
  end;
end;

procedure TContactEmail.SetLabelText(const AValue: string);
begin
  if FLabelText <> AValue then
  begin
    FLabelKind := TLabelKind.Custom;
    FLabelText := AValue;
  end;
end;

class function TContactEmail.SupportedLabelKinds: TLabelKinds;
var
  SupportedLabelKindsService: IFMXAddressBookSupportedLabelKinds;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXAddressBookSupportedLabelKinds, SupportedLabelKindsService) then
    Result := SupportedLabelKindsService.EmailsLabelKinds
  else
    Result := [];
end;

{ TContactEmails }

function TContactEmails.AddEmail(const AKind: TContactEmail.TLabelKind; const AEmail: string): TContactEmail;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactEmail.Create(AKind, AEmail));
  Result := Items[ItemIdx];
end;

function TContactEmails.AddEmail(const ALabel: string; const AEmail: string): TContactEmail;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactEmail.Create(ALabel, AEmail));
  Result := Items[ItemIdx];
end;

{ TContactRelationship }

constructor TContactRelatedName.Create;
begin
  inherited Create;
  LabelKind := TLabelKind.Custom;
end;

constructor TContactRelatedName.Create(const AKind: TLabelKind; const AName: string);
begin
  inherited Create;
  LabelKind := AKind;
  FName := AName;
end;

constructor TContactRelatedName.Create(const ALabel: string; const AName: string);
begin
  inherited Create;
  LabelText := ALabel;
  FName := AName;
end;

function TContactRelatedName.GetLabelText: string;
begin
  case LabelKind of
    TLabelKind.Custom:
      Result := FLabelText;
    TLabelKind.Mother:
      Result := SRelationMother;
    TLabelKind.Father:
      Result := SRelationFather;
    TLabelKind.Parent:
      Result := SRelationParent;
    TLabelKind.Sister:
      Result := SRelationSister;
    TLabelKind.Brother:
      Result := SRelationBrother;
    TLabelKind.Child:
      Result := SRelationChild;
    TLabelKind.Friend:
      Result := SRelationFriend;
    TLabelKind.Spouse:
      Result := SRelationSpouse;
    TLabelKind.Partner:
      Result := SRelationPartner;
    TLabelKind.Manager:
      Result := SRelationManager;
    TLabelKind.Assistant:
      Result := SRelationAssistant;
    TLabelKind.DomesticPartner:
      Result := SRelationDomesticPartner;
    TLabelKind.ReferredBy:
      Result := SRelationReferredBy;
    TLabelKind.Relative:
      Result := SRelationRelative;
  else
    Result := FLabelText;
  end;
end;

function TContactRelatedName.IsLabelKindSupported: Boolean;
begin
  Result := LabelKind in SupportedLabelKinds;
end;

procedure TContactRelatedName.SetLabelKind(const AValue: TLabelKind);
begin
  if FLabelKind <> AValue then
  begin
    FLabelKind := AValue;
    FLabelText := string.Empty;
  end;
end;

procedure TContactRelatedName.SetLabelText(const AValue: string);
begin
  if FLabelText <> AValue then
  begin
    FLabelKind := TLabelKind.Custom;
    FLabelText := AValue;
  end;
end;

class function TContactRelatedName.SupportedLabelKinds: TLabelKinds;
var
  SupportedLabelKindsService: IFMXAddressBookSupportedLabelKinds;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXAddressBookSupportedLabelKinds, SupportedLabelKindsService) then
    Result := SupportedLabelKindsService.RelatedNamesLabelKinds
  else
    Result := [];
end;

{ TContactRelationships }

function TContactRelatedNames.AddRelatedName(const AKind: TContactRelatedName.TLabelKind; const AName: string): TContactRelatedName;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactRelatedName.Create(AKind, AName));
  Result := Items[ItemIdx];
end;

function TContactRelatedNames.AddRelatedName(const ALabel: string; const AName: string): TContactRelatedName;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactRelatedName.Create(ALabel, AName));
  Result := Items[ItemIdx];
end;

{ TContactURL }

constructor TContactURL.Create;
begin
  inherited Create;
  LabelKind := TLabelKind.Custom;
end;

constructor TContactURL.Create(const AKind: TLabelKind; const AURL: string);
begin
  inherited Create;
  LabelKind := AKind;
  FURL := AURL;
end;

constructor TContactURL.Create(const ALabel: string; const AURL: string);
begin
  inherited Create;
  LabelText := ALabel;
  FURL := AURL;
end;

function TContactURL.GetLabelText: string;
begin
  case FLabelKind of
    TLabelKind.Custom:
      Result := FLabelText;
    TLabelKind.HomePage:
      Result := SURLHomePage;
    TLabelKind.Blog:
      Result := SURLBlog;
    TLabelKind.Profile:
      Result := SURLProfile;
    TLabelKind.Home:
      Result := SAddressBookHomeLabel;
    TLabelKind.Work:
      Result := SAddressBookWorkLabel;
    TLabelKind.FTP:
      Result := SURLFTP;
    TLabelKind.Other:
      Result := SAddressBookOtherLabel;
  else
    Result := FLabelText;
  end;
end;

function TContactURL.IsLabelKindSupported: Boolean;
begin
  Result := LabelKind in SupportedLabelKinds;
end;

procedure TContactURL.SetLabelKind(const AValue: TLabelKind);
begin
  if FLabelKind <> AValue then
  begin
    FLabelKind := AValue;
    FLabelText := string.Empty;
  end;
end;

procedure TContactURL.SetLabelText(const AValue: string);
begin
  if FLabelText <> AValue then
  begin
    FLabelKind := TLabelKind.Custom;
    FLabelText := AValue;
  end;
end;

class function TContactURL.SupportedLabelKinds: TLabelKinds;
var
  SupportedLabelKindsService: IFMXAddressBookSupportedLabelKinds;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXAddressBookSupportedLabelKinds, SupportedLabelKindsService) then
    Result := SupportedLabelKindsService.URLsLabelKinds
  else
    Result := [];
end;

{ TContactURLs }

function TContactURLs.AddURL(const AKind: TContactURL.TLabelKind; const AURL: string): TContactURL;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactURL.Create(AKind, AURL));
  Result := Items[ItemIdx];
end;

function TContactURLs.AddURL(const ALabel: string; const AURL: string): TContactURL;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactURL.Create(ALabel, AURL));
  Result := Items[ItemIdx];
end;

{ TContactDate }

constructor TContactDate.Create;
begin
  inherited Create;
  FLabelKind := TLabelKind.Custom;
end;

constructor TContactDate.Create(const AKind: TLabelKind; const ADate: TDate);
begin
  inherited Create;
  LabelKind := AKind;
  FDate := ADate;
end;

constructor TContactDate.Create(const ALabel: string; const ADate: TDate);
begin
  inherited Create;
  LabelText := ALabel;
  FDate := ADate;
end;

constructor TContactDate.Create(const ADate: TDate);
begin
  inherited Create;
  FLabelKind := TLabelKind.Custom;
  FDate := ADate;
end;

function TContactDate.GetLabelText: string;
begin
  case FLabelKind of
    TLabelKind.Custom:
      Result := FLabelText;
    TLabelKind.Birthday:
      Result := SDateBirthday;
    TLabelKind.Anniversary:
      Result := SDateAnniversary;
  else
    Result := FLabelText;
  end;
end;

function TContactDate.IsLabelKindSupported: Boolean;
begin
  Result := LabelKind in SupportedLabelKinds;
end;

procedure TContactDate.SetLabelKind(const AValue: TLabelKind);
begin
  if FLabelKind <> AValue then
  begin
    FLabelKind := AValue;
    FLabelText := string.Empty;
  end;
end;

procedure TContactDate.SetLabelText(const AValue: string);
begin
  if FLabelText <> AValue then
  begin
    FLabelKind := TLabelKind.Custom;
    FLabelText := AValue;
  end;
end;

class function TContactDate.SupportedLabelKinds: TLabelKinds;
var
  SupportedLabelKindsService: IFMXAddressBookSupportedLabelKinds;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXAddressBookSupportedLabelKinds, SupportedLabelKindsService) then
    Result := SupportedLabelKindsService.DatesLabelKinds
  else
    Result := [];
end;

{ TContactDates }

function TContactDates.AddDate(const AKind: TContactDate.TLabelKind; const ADate: TDate): TContactDate;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactDate.Create(AKind, ADate));
  Result := Items[ItemIdx];
end;

function TContactDates.AddDate(const ALabel: string; const ADate: TDate): TContactDate;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactDate.Create(ALabel, ADate));
  Result := Items[ItemIdx];
end;

{ TContactAddress }

constructor TContactAddress.Create;
begin
  inherited;
  LabelKind := TLabelKind.Custom;
end;

constructor TContactAddress.Create(const AKind: TLabelKind; const ACountry, AState, ACity, AZIP, AStreet: string);
begin
  inherited Create;
  LabelKind := AKind;
  FCountry := ACountry;
  FState := AState;
  FCity := ACity;
  FZIP := AZIP;
  FStreet := AStreet;
end;

constructor TContactAddress.Create(const ALabel: string; const ACountry, AState, ACity, AZIP, AStreet: string);
begin
  inherited Create;
  LabelText := ALabel;
  FCountry := ACountry;
  FState := AState;
  FCity := ACity;
  FZIP := AZIP;
  FStreet := AStreet;
end;

function TContactAddress.GetLabelText: string;
begin
  case FLabelKind of
    TLabelKind.Custom:
      Result := FLabelText;
    TLabelKind.Home:
      Result := SAddressBookHomeLabel;
    TLabelKind.Work:
      Result := SAddressBookWorkLabel;
    TLabelKind.Other:
      Result := SAddressBookOtherLabel;
  else
    Result := FLabelText;
  end;
end;

function TContactAddress.IsLabelKindSupported: Boolean;
begin
  Result := LabelKind in SupportedLabelKinds;
end;

procedure TContactAddress.SetLabelKind(const AValue: TLabelKind);
begin
  if FLabelKind <> AValue then
  begin
    FLabelKind := AValue;
    FLabelText := string.Empty;
  end;
end;

procedure TContactAddress.SetLabelText(const AValue: string);
begin
  if FLabelText <> AValue then
  begin
    FLabelKind := TLabelKind.Custom;
    FLabelText := AValue;
  end;
end;

class function TContactAddress.SupportedLabelKinds: TLabelKinds;
var
  SupportedLabelKindsService: IFMXAddressBookSupportedLabelKinds;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXAddressBookSupportedLabelKinds, SupportedLabelKindsService) then
    Result := SupportedLabelKindsService.AddressesLabelKinds
  else
    Result := [];
end;

function TContactAddress.ToString: string;
begin
  Result := Format('Label="%s" Country="%s" State="%s" City="%s" ZIP="%s" Street="%s"', [LabelText, Country, State, City, ZIP, Street]);
  Result := Result.Trim;
end;

{ TContactAddresses }

function TContactAddresses.AddAddress(const ALabel, ACountry, AState, ACity, AZIP, AStreet: string): TContactAddress;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactAddress.Create(ALabel, ACountry, AState, ACity, AZIP, AStreet));
  Result := Items[ItemIdx];
end;

function TContactAddresses.AddAddress(const AKind: TContactAddress.TLabelKind; const ACountry, AState, ACity, AZIP, AStreet: string): TContactAddress;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactAddress.Create(AKind, ACountry, AState, ACity, AZIP, AStreet));
  Result := Items[ItemIdx];
end;

{ TContactSocialProfile }

constructor TContactSocialProfile.Create;
begin
  inherited;
  LabelKind := TLabelKind.Custom;
  ServiceKind := TServiceKind.Custom;
end;

constructor TContactSocialProfile.Create(const ALabel, AServiceName, AUrl, AUserName, AUserIdentifier: string);
begin
  inherited Create;
  LabelText := ALabel;
  ServiceName := AServiceName;
  URL := AUrl;
  UserName := AUserName;
  UserIdentifier := AUserIdentifier;
end;

constructor TContactSocialProfile.Create(const ALabelKind: TLabelKind; const AServiceName, AUrl, AUserName,
  AUserIdentifier: string);
begin
  inherited Create;
  LabelKind := ALabelKind;
  ServiceName := AServiceName;
  URL := AUrl;
  UserName := AUserName;
  UserIdentifier := AUserIdentifier;
end;

constructor TContactSocialProfile.Create(const ALabel: string; const AServiceKind: TServiceKind; const AUrl, AUserName,
  AUserIdentifier: string);
begin
  inherited Create;
  LabelText := ALabel;
  ServiceKind := AServiceKind;
  URL := AUrl;
  UserName := AUserName;
  UserIdentifier := AUserIdentifier;
end;

constructor TContactSocialProfile.Create(const ALabelKind: TLabelKind; const AServiceKind: TServiceKind; const AUrl,
  AUserName, AUserIdentifier: string);
begin
  inherited Create;
  LabelKind := ALabelKind;
  ServiceKind := AServiceKind;
  URL := AUrl;
  UserName := AUserName;
  UserIdentifier := AUserIdentifier;
end;

function TContactSocialProfile.GetLabelText: string;
begin
  case FLabelKind of
    TLabelKind.Custom:
      Result := FLabelText;
    TLabelKind.Home:
      Result := SAddressBookHomeLabel;
    TLabelKind.Work:
      Result := SAddressBookWorkLabel;
    TLabelKind.Other:
      Result := SAddressBookOtherLabel;
  else
    Result := FLabelText;
  end;
end;

function TContactSocialProfile.GetServiceName: string;
begin
  case ServiceKind of
    TServiceKind.Custom:
      Result := FLabelText;
    TServiceKind.Twitter:
      Result := SSocialProfileTwitter;
    TServiceKind.GameCenter:
      Result := SSocialProfileGameCenter;
    TServiceKind.SinaWeibo:
      Result := SSocialProfileSinaWeibo;
    TServiceKind.Facebook:
     Result := SSocialProfileFacebook;
    TServiceKind.Myspace:
      Result := SSocialProfileMySpace;
    TServiceKind.LinkedIn:
      Result := SSocialProfileLinkedIn;
    TServiceKind.Flickr:
      Result := SSocialProfileFlickr;
  else
    Result := FLabelText;
  end;
end;

function TContactSocialProfile.IsLabelKindSupported: Boolean;
begin
  Result := LabelKind in SupportedLabelKinds;
end;

function TContactSocialProfile.IsServiceKindSupported: Boolean;
begin
  Result := ServiceKind in SupportedServiceKinds;
end;

procedure TContactSocialProfile.SetLabelKind(const AValue: TLabelKind);
begin
  if FLabelKind <> AValue then
  begin
    FLabelKind := AValue;
    FLabelText := string.Empty;
  end;
end;

procedure TContactSocialProfile.SetLabelText(const AValue: string);
begin
  if FLabelText <> AValue then
  begin
    FLabelKind := TLabelKind.Custom;
    FLabelText := AValue;
  end;
end;

procedure TContactSocialProfile.SetServiceName(const AValue: string);
begin
  if FServiceName <> AValue then
  begin
    FServiceKind := TServiceKind.Custom;
    FServiceName := AValue;
  end;
end;

procedure TContactSocialProfile.SetServiceKind(const AValue: TServiceKind);
begin
  if FServiceKind <> AValue then
  begin
    FServiceKind := AValue;
    FServiceName := string.Empty;
  end;
end;

class function TContactSocialProfile.SupportedLabelKinds: TLabelKinds;
var
  SupportedLabelKindsService: IFMXAddressBookSupportedLabelKinds;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXAddressBookSupportedLabelKinds, SupportedLabelKindsService) then
    Result := SupportedLabelKindsService.SocialProfilesLabelKinds
  else
    Result := [];
end;

class function TContactSocialProfile.SupportedServiceKinds: TServiceKinds;
var
  SupportedLabelKindsService: IFMXAddressBookSupportedLabelKinds;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXAddressBookSupportedLabelKinds, SupportedLabelKindsService) then
    Result := SupportedLabelKindsService.SocialProfilesServiceKinds
  else
    Result := [];
end;

function TContactSocialProfile.ToString: string;
begin
  Result := Format('%s - %s : %s (%s)', [ServiceName, UserName, UserIdentifier, Url]);
end;

{ TContactSocialProfiles }

function TContactSocialProfiles.AddProfile(const ALabel, AServiceName, AUrl, AUserName,
  AUserIdentifier: string): TContactSocialProfile;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactSocialProfile.Create(ALabel, AServiceName, AUrl, AUserName, AUserIdentifier));
  Result := Items[ItemIdx];
end;

function TContactSocialProfiles.AddProfile(const ALabelKind: TContactSocialProfile.TLabelKind; const AServiceName, AUrl,
  AUserName, AUserIdentifier: string): TContactSocialProfile;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactSocialProfile.Create(ALabelKind, AServiceName, AUrl, AUserName, AUserIdentifier));
  Result := Items[ItemIdx];
end;

function TContactSocialProfiles.AddProfile(const ALabel: string; const AServiceKind: TContactSocialProfile.TServiceKind;
  const AUrl, AUserName, AUserIdentifier: string): TContactSocialProfile;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactSocialProfile.Create(ALabel, AServiceKind, AUrl, AUserName, AUserIdentifier));
  Result := Items[ItemIdx];
end;

function TContactSocialProfiles.AddProfile(const ALabelKind: TContactSocialProfile.TLabelKind;
  const AServiceKind: TContactSocialProfile.TServiceKind; const AUrl, AUserName,
  AUserIdentifier: string): TContactSocialProfile;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactSocialProfile.Create(ALabelKind, AServiceKind, AUrl, AUserName, AUserIdentifier));
  Result := Items[ItemIdx];
end;

{ TContactMessagingServices }

function TContactMessagingServices.AddProfile(const ALabel, AServiceName, AUserName: string): TContactMessagingService;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactMessagingService.Create(ALabel, AServiceName, AUserName));
  Result := Items[ItemIdx];
end;

function TContactMessagingServices.AddProfile(const ALabelKind: TContactMessagingService.TLabelKind; const AServiceName,
  AUserName: string): TContactMessagingService;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactMessagingService.Create(ALabelKind, AServiceName, AUserName));
  Result := Items[ItemIdx];
end;

function TContactMessagingServices.AddProfile(const ALabel: string;
  const AServiceKind: TContactMessagingService.TServiceKind; const AUserName: string): TContactMessagingService;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactMessagingService.Create(ALabel, AServiceKind, AUserName));
  Result := Items[ItemIdx];
end;

function TContactMessagingServices.AddProfile(const ALabelKind: TContactMessagingService.TLabelKind;
  const AServiceKind: TContactMessagingService.TServiceKind; const AUserName: string): TContactMessagingService;
var
  ItemIdx: Integer;
begin
  ItemIdx := Add(TContactMessagingService.Create(ALabelKind, AServiceKind, AUserName));
  Result := Items[ItemIdx];
end;

end.
