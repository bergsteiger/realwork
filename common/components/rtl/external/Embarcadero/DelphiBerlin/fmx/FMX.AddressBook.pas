{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.AddressBook;

interface

{$SCOPEDENUMS ON}

uses
  System.Generics.Collections, System.Classes, FMX.AddressBook.Types, FMX.Surfaces;

type

  TAddressBookContact = class;
  TAddressBookContacts = class;
  TAddressBookGroup = class;
  TAddressBookGroups = class;
  TAddressBookSource = class;
  TAddressBookSources = class;
  IFMXAddressBookService = interface;
  IFMXAddressBookFactory = interface;

{ Address Book }

  /// <summary>Base class of none visual component for working with Address Book, works with <c>IFMXAddressBookService</c> service</summary>
  TCustomAddressBook = class(TComponent)
  private
    FService: IFMXAddressBookService;
    FAuthorizationStatus: array [TAddressBookAccessType] of TAuthorizationStatus;
    FOnExternalChange: TExternalChangeEvent;
    FOnPermissionRequest: TPermissionRequestEvent;
    procedure CheckAuthorization(const AAccessType: TAddressBookAccessType);
    function GetOnExternalChange: TExternalChangeEvent;
    function GetOnPermissionRequest: TPermissionRequestEvent;
    procedure SetOnExternalChange(const AValue: TExternalChangeEvent);
    procedure SetOnPermissionRequest(const AValue: TPermissionRequestEvent);
  protected
    /// <summary>Returns access to AddressBook service</summary>
    property Service: IFMXAddressBookService read FService;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// <summary>Checks If AddressBook is currently available on current platform</summary>
    function Supported: Boolean;

    {$REGION 'Changes'}
    /// <summary>Reverts all current changes and updates AddressBook</summary>
    /// <remarks>If somebody else made changes in AddressBook, you should invoke this method for up to date your
    /// instance of AddressBook.  The best place for invoking is in <c>TAddressBook.OnExternalChange</c></remarks>
    procedure RevertCurrentChangesAndUpdate;
    {$ENDREGION}

    {$REGION 'Sources'}
    /// <summary>Returns list of available sources on current device</summary>
    procedure AllSources(var ASources: TAddressBookSources);
    /// <summary>Returns source with specified ID</summary>
    function SourceByID(const AID: string): TAddressBookSource;
    /// <summary>Returns default source</summary>
    function DefaultSource: TAddressBookSource;
    {$ENDREGION}

    {$REGION 'Permissions'}
    /// <summary>Requests permission on reading and changing AddressBook</summary>
    procedure RequestPermission;
    /// <summary>Returns authorization status </summary>
    function AuthorizationStatus(const AAccessType: TAddressBookAccessType): TAuthorizationStatus;
    {$ENDREGION}

    {$REGION 'Groups'}
    /// <summary>Returns list of available groups</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure AllGroups(var AGroups: TAddressBookGroups); overload;
    /// <summary>Returns list of available groups</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure AllGroups(const ASource: TAddressBookSource; var AGroups: TAddressBookGroups); overload;
    /// <summary>Returns group with specified ID</summary>
    /// <remarks>If group is not found, it will return nil</remarks>
    function GroupByID(const AID: Int32): TAddressBookGroup;
    /// <summary>Creates group record. Use <c>SaveGroup</c> for adding group record in Address Book.</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    function CreateGroup(const ASource: TAddressBookSource = nil): TAddressBookGroup;
    /// <summary>Adds or modifies Group information. If it's a new group record, it will add new record to Address Book,
    /// otherwise - update</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure SaveGroup(const AGroup: TAddressBookGroup);
    /// <summary>Removes group and all contacts in this group.</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure RemoveGroup(const AGroup: TAddressBookGroup); overload;
    /// <summary>Removes group and all contacts in this group.</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure RemoveGroup(const AID: Integer); overload;
    /// <summary>Removes contact from sepcified Group</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure AddContactIntoGroup(const AGroup: TAddressBookGroup; const AContact: TAddressBookContact);
    /// <summary>Removes contact from sepcified Group</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure RemoveContactFromGroup(const AGroup: TAddressBookGroup; const AContact: TAddressBookContact);
    {$ENDREGION}

    {$REGION 'Contacts'}
    /// <summary>Returns list of all contacts</summary>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure AllContacts(var AContacts: TAddressBookContacts); overload;
    /// <summary>Returns list of all contacts</summary>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure AllContacts(const ASource: TAddressBookSource; var AContacts: TAddressBookContacts); overload;
    /// <summary>Returns list of contacts in specified groups</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure AllContactsInGroups(const AGroups: TAddressBookGroups; var AContacts: TAddressBookContacts);
    /// <summary>Returns list of contacts in a one specified group</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure AllContactsInGroup(const AGroup: TAddressBookGroup; var AContacts: TAddressBookContacts);
    /// <summary>Returns contact with specified ID</summary>
    /// <remarks>If contact is not found, it will return nil</remarks>
    function ContactByID(const AID: Int32): TAddressBookContact;
    /// <summary>Creates contact record. Doesn't add it into AddressBook. Use <c>SaveContact</c> for adding contact to
    /// AddressBook</summary>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    function CreateContact(const ASource: TAddressBookSource = nil): TAddressBookContact;
    /// <summary>Adds or modifies Contact information. If it's a new contact, it will add new record to Address Book,
    /// otherwise - update</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure SaveContact(const AContact: TAddressBookContact);
    /// <summary>Removes contact record from Address Book.</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure RemoveContact(const AContact: TAddressBookContact); overload;
    /// <summary>Removes contact record from Address Book.</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure RemoveContact(const AID: Integer); overload;
    {$ENDREGION}

    /// <summary>Event handler for receiving results of requesting access to Address Book</summary>
    /// <remarks>Actual only for iOS platform</remarks>
    property OnPermissionRequest: TPermissionRequestEvent read GetOnPermissionRequest write SetOnPermissionRequest;
    /// <summary>Notifies about changes of AddressBook.</summary>
    property OnExternalChange: TExternalChangeEvent read GetOnExternalChange write SetOnExternalChange;
  end;

  /// <summary>Address Book, It provides access and working with persons contacts on Android and iOS</summary>
  [ComponentPlatformsAttribute(pidiOSSimulator or pidiOSDevice or pidiOSDevice32 or pidiOSDevice64 or pidAndroid)]
  TAddressBook = class(TCustomAddressBook)
  published
    property OnPermissionRequest;
    property OnExternalChange;
  end;

{ Address Book Source }

  /// <summary>Represents source of address book store. Device can save contacts in several accounts (Cloud, Google,
  /// Exchange, iCloud and etc).</summary>
  TAddressBookSource = class abstract
  protected
    /// <summary>Returns id of source, has to be implemented in successors</summary>
    function GetID: string; virtual; abstract;
    /// <summary>Returns source name, has to be implemented in successors</summary>
    function GetSourceName: string; virtual; abstract;
    /// <summary>Returns source type, has to be implemented in successors</summary>
    function GetSourceType: string; virtual; abstract;
  public
    constructor Create;
    /// <summary>String representation of unique identifier of source</summary>
    property ID: string read GetID;
    /// <summary>Name of source account</summary>
    property SourceName: string read GetSourceName;
    /// <summary>Type of address book source (Google, Exchange, LDAP, Local and etc)</summary>
    property SourceType: string read GetSourceType;
  end;
  /// <summary>List of all supported sources</summary>
  TAddressBookSources = class(TList<TAddressBookSource>);

{ Contacts group }

  /// <summary>Represents full information about Group record</summary>
  TAddressBookGroup = class abstract
  protected
    /// <summary>Returns display name of group, has to be implemented in successors</summary>
    function GetName: string; virtual; abstract;
    /// <summary>Sets display name for group, has to be implemented in successors</summary>
    procedure SetName(const Value: string); virtual; abstract;
    /// <summary>Returns unique identifier of group</summary>
    function GetID: Integer; virtual; abstract;
    /// <summary>Returns source of group</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    function GetSource: TAddressBookSource; virtual; abstract;
  public
    constructor Create;
    /// <summary>Display name of group. If you change name of group, you should invoke <c>TAddressBook.SaveGroup</c> for
    /// saving group information in Address Book.</summary>
    /// <remarks>If you changed name and after it another application changed name of current group too, you will
    /// not be able to get updated name.</remarks>
    property Name: string read GetName write SetName;
    /// <summary>Unique identifier of group</summary>
    property ID: Integer read GetID;
    /// <summary>Source of contact</summary>
    property Source: TAddressBookSource read GetSource;
  end;
  /// <summary>List of groups</summary>
  TAddressBookGroups = class(TList<TAddressBookGroup>);

{ Contact }

  /// <summary>Represents full information about contact</summary>
  TAddressBookContact = class abstract
  protected
    { Ordinary types }
    /// <summary>Returns string value of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    function GetStringValue(const AIndex: TContactField): string; virtual; abstract;
    /// <summary>Sets string value of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    procedure SetStringValue(const AIndex: TContactField; const AValue: string); virtual; abstract;
    /// <summary>Returns bitmap value of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    function GetBitmapValue(const AIndex: TContactField): TBitmapSurface; virtual; abstract;
    /// <summary>Sets bitmap value of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    procedure SetBitmapValue(const AIndex: TContactField; const AValue: TBitmapSurface); virtual; abstract;
    /// <summary>Returns date time value of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    function GetDateTimeValue(const AIndex: TContactField): TDateTime; virtual; abstract;
    /// <summary>Sets birthday date value of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    procedure SetDateTimeValue(const AIndex: TContactField; const AValue: TDateTime); virtual; abstract;
    { Lists }
    /// <summary>Returns list of dates of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    function GetDates(const AIndex: TContactField): TContactDates; virtual; abstract;
    /// <summary>Sets list of dates of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    procedure SetDates(const AIndex: TContactField; const AValue: TContactDates); virtual; abstract;
    { Custom fields }
    /// <summary>Returns list of addresses of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not bitmap type</exception>
    function GetAddresses(const AIndex: TContactField): TContactAddresses; virtual; abstract;
    /// <summary>Sets list of addresses of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not bitmap type</exception>
    procedure SetAddresses(const AIndex: TContactField; const AValue: TContactAddresses); virtual; abstract;
    /// <summary>Returns list of messaging services of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not bitmap type</exception>
    function GetMessagingServices(const AIndex: TContactField): TContactMessagingServices; virtual; abstract;
    /// <summary>Sets list of messaging services of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not bitmap type</exception>
    procedure SetMessagingServices(const AIndex: TContactField; const AValue: TContactMessagingServices); virtual; abstract;
    /// <summary>Returns list of social profiles of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not bitmap type</exception>
    function GetSocialProfiles(const AIndex: TContactField): TContactSocialProfiles; virtual; abstract;
    /// <summary>Sets list of social profiles of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not bitmap type</exception>
    procedure SetSocialProfiles(const AIndex: TContactField; const AValue: TContactSocialProfiles); virtual; abstract;
    /// <summary>Returns list of phone numbers values of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    function GetPhones(const Index: TContactField): TContactPhones; virtual; abstract;
    /// <summary>Sets list of phone numbers of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    procedure SetPhones(const Index: TContactField; const Value: TContactPhones); virtual; abstract;
    /// <summary>Returns list of emails values of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    function GetEmails(const AIndex: TContactField): TContactEmails; virtual; abstract;
    /// <summary>Sets list of emails of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    procedure SetEmails(const AIndex: TContactField; const AValue: TContactEmails); virtual; abstract;
    /// <summary>Returns list of related names values of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    function GetRelatedNames(const AIndex: TContactField): TContactRelatedNames; virtual; abstract;
    /// <summary>Sets list of related names of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    procedure SetRelatedNames(const AIndex: TContactField; const AValue: TContactRelatedNames); virtual; abstract;
    /// <summary>Returns list of URLs of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    function GetURLs(const AIndex: TContactField): TContactURLs; virtual; abstract;
    /// <summary>Sets list of URLs of <c>AIndex</c> field</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    procedure SetURLs(const AIndex: TContactField; const AValue: TContactURLs); virtual; abstract;
    /// <summary>Returns source of contact</summary>
    /// <exception cref="EAddressBookException">Platform doesn't support this field or field is not required type</exception>
    function GetSource: TAddressBookSource; virtual; abstract;
    /// <summary>Returns kind of contact record (Organization or Person)</summary>
    function GetContactKind: TContactKind; virtual; abstract;
    /// <summary>Returns user friendly display name</summary>
    function GetDisplayName: string; virtual; abstract;
    /// <summary>Returns unique identifier of contact</summary>
    function GetID: Int32; virtual; abstract;
  public
    constructor Create;
    /// <summary>Unique identifier of contact</summary>
    property ID: Int32 read GetID;
    /// <summary>Kind of contact record (Organization or Person)</summary>
    property Kind: TContactKind read GetContactKind;
    /// <summary>Source of contact</summary>
    property Source: TAddressBookSource read GetSource;

    {$REGION 'Personal Information'}
    /// <summary>User friendly name. For example: If user doesn't have a name, it will return email.</summary>
    property DisplayName: string read GetDisplayName;
    /// <summary>First name of contact</summary>
    property FirstName: string index TContactField.FirstName read GetStringValue write SetStringValue;
    /// <summary>Last name of contact</summary>
    property LastName: string index TContactField.LastName read GetStringValue write SetStringValue;
    /// <summary>Middle name of contact</summary>
    property MiddleName: string index TContactField.MiddleName read GetStringValue write SetStringValue;
    /// <summary>Prefix full contact name</summary>
    property Prefix: string index TContactField.Prefix read GetStringValue write SetStringValue;
    /// <summary>Suffix of first name</summary>
    property Suffix: string index TContactField.Suffix read GetStringValue write SetStringValue;
    /// <summary>Nick name</summary>
    property NickName: string index TContactField.NickName read GetStringValue write SetStringValue;
    /// <summary>First Name Phonetic</summary>
    property FirstNamePhonetic: string index TContactField.FirstNamePhonetic read GetStringValue write SetStringValue;
    /// <summary>Last Name Phonetic</summary>
    property LastNamePhonetic: string index TContactField.LastNamePhonetic read GetStringValue write SetStringValue;
    /// <summary>Middle Name Phonetic</summary>
    property MiddleNamePhonetic: string index TContactField.MiddleNamePhonetic read GetStringValue write SetStringValue;
    /// <summary>Company name</summary>
    property Organization: string index TContactField.Organization read GetStringValue write SetStringValue;
    /// <summary>Job title</summary>
    property JobTitle: string index TContactField.JobTitle read GetStringValue write SetStringValue;
    /// <summary>Department</summary>
    property Department: string index TContactField.Department read GetStringValue write SetStringValue;
    /// <summary>Contact photo</summary>
    property Photo: TBitmapSurface index TContactField.Photo read GetBitmapValue write SetBitmapValue;
    /// <summary>Contact thumbnail photo</summary>
    property PhotoThumbnail: TBitmapSurface index TContactField.PhotoThumbnail read GetBitmapValue;
    /// <summary>List of contact emails</summary>
    property EMails: TContactEmails index TContactField.EMails read GetEmails write SetEmails;
    /// <summary>Birthday</summary>
    property Birthday: TDateTime index TContactField.Birthday read GetDateTimeValue write SetDateTimeValue;
    /// <summary>Text note</summary>
    property Note: string index TContactField.Note read GetStringValue write SetStringValue;
    {$ENDREGION}

    {$REGION 'Other Contact Data'}
    /// <summary>List of dates</summary>
    property Dates: TContactDates index TContactField.Dates read GetDates write SetDates;
    /// <summary>Date of contact creation</summary>
    /// <remarks>Supported only on iOS</remarks>
    property CreationDate: TDateTime index TContactField.CreationDate read GetDateTimeValue;
    /// <summary>Date of contact modification</summary>
    /// <remarks>Supported only on iOS</remarks>
    property ModificationDate: TDateTime index TContactField.ModificationDate read GetDateTimeValue;
    /// <summary>List of contact addresses</summary>
    property Addresses: TContactAddresses index TContactField.Addresses read GetAddresses write SetAddresses;
    /// <summary>List of phone numbers and labels</summary>
    property Phones: TContactPhones index TContactField.Phones read GetPhones write SetPhones;
    /// <summary>List of messaging services</summary>
    property MessagingServices: TContactMessagingServices index TContactField.MessagingServices read GetMessagingServices
      write SetMessagingServices;
    /// <summary>List of social profiles</summary>
    /// <remarks>Supported only on iOS</remarks>
    property SocialProfiles: TContactSocialProfiles index TContactField.SocialProfiles read GetSocialProfiles
      write SetSocialProfiles;
    /// <summary>List of related persons. Each record contains name of person and name of link</summary>
    property RelatedNames: TContactRelatedNames index TContactField.RelatedNames read GetRelatedNames write SetRelatedNames;
    /// <summary>List of contact URLs</summary>
    property URLs: TContactURLs index TContactField.URLs read GetURLs write SetURLs;
    {$ENDREGION}
  end;
  /// <summary>List of contacts</summary>
  TAddressBookContacts = class(TObjectList<TAddressBookContact>);

{ Services }

  /// <summary>Interface for working with Address Book, provides set of methods for working with address book</summary>
  IFMXAddressBookService = interface
  ['{C9B83925-6A0E-464D-8CFE-7CD11DB366CA}']
    {$REGION 'Permissions'}
    /// <summary>Requests permission on reading and changing AddressBook</summary>
    procedure RequestPermission;
    /// <summary>Returns authorization status </summary>
    function AuthorizationStatus(const AAccessType: TAddressBookAccessType): TAuthorizationStatus;
    {$ENDREGION}

    {$REGION 'Sources'}
    /// <summary>Returns list of available sources on current device</summary>
    procedure AllSources(var ASources: TAddressBookSources);
    /// <summary>Returns source with specified ID</summary>
    function SourceByID(const AID: string): TAddressBookSource;
    /// <summary>Returns default source</summary>
    function DefaultSource: TAddressBookSource;
    {$ENDREGION}

    {$REGION 'Changes'}
    /// <summary>Reverts all current changes and updates AddressBook</summary>
    /// <remarks>If somebody else made changes in AddressBook, you should invoke this method for up to date your
    /// instance of AddressBook. The best place for invoking is in <c>TAddressBook.OnExternalChange</c></remarks>
    procedure RevertCurrentChangesAndUpdate;
    {$ENDREGION}

    {$REGION 'Groups'}
    /// <summary>Returns list of available groups</summary>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure AllGroups(const ASource: TAddressBookSource; var AGroups: TAddressBookGroups);
    /// <summary>Returns group with specified ID</summary>
    /// <remarks>If group is not found, it will return nil</remarks>
    function GroupByID(const AID: Int32): TAddressBookGroup;
    /// <summary>Creates group record. Use <c>SaveGroup</c> for adding group record in Address Book.</summary>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    function CreateGroup(const ASource: TAddressBookSource = nil): TAddressBookGroup;
    /// <summary>Adds or modifies Group information. If it's a new group record, it will add new record to Address Book,
    /// otherwise - update</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure SaveGroup(const AGroup: TAddressBookGroup);
    /// <summary>Removes group and all contacts in this group.</summary>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure RemoveGroup(const AGroup: TAddressBookGroup); overload;
    /// <summary>Removes group and all contacts in this group.</summary>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure RemoveGroup(const AID: Integer); overload;
    /// <summary>Removes contact from sepcified Group</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure AddContactIntoGroup(const AGroup: TAddressBookGroup; const AContact: TAddressBookContact);
    /// <summary>Removes contact from sepcified Group</summary>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure RemoveContactFromGroup(const AGroup: TAddressBookGroup; const AContact: TAddressBookContact);
    {$ENDREGION}

    {$REGION 'Contacts'}
    /// <summary>Returns list of all contacts</summary>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure AllContacts(const ASource: TAddressBookSource; var AContacts: TAddressBookContacts);
    /// <summary>Returns list of contacts in specified groups</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure AllContactsInGroups(const AGroups: TAddressBookGroups; var AContacts: TAddressBookContacts);
    /// <summary>Returns contact with specified ID</summary>
    /// <remarks>If contact is not found, it will return nil</remarks>
    function ContactByID(const AID: Int32): TAddressBookContact;
    /// <summary>Creates contact record. Doesn't add it into AddressBook. Use <c>SaveContact</c> for adding contact to
    /// AddressBook</summary>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    function CreateContact(const ASource: TAddressBookSource = nil): TAddressBookContact;
    /// <summary>Adds or modifies Contact information. If it's a new contact, it will add new record to Address Book,
    /// otherwise - update</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure SaveContact(const AContact: TAddressBookContact);
    /// <summary>Removes contact record from Address Book.</summary>
    /// <exception cref="EAddressBookWrongArgs">Input parameters is wrong</exception>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure RemoveContact(const AContact: TAddressBookContact); overload;
    /// <summary>Removes contact record from Address Book.</summary>
    /// <exception cref="EAddressBookAccess">Application doesn't have access to work with AddressBook</exception>
    /// <exception cref="EAddressBookExecute">Exceptional situation in the course of execution of request</exception>
    procedure RemoveContact(const AID: Integer); overload;
    {$ENDREGION}

    {$REGION 'Events'}
    /// <summary>Returns <c>OnPermissionRequest</c> handler</summary>
    function GetOnPermissionRequest: TPermissionRequestEvent;
    /// <summary>Sets <c>GetOnPermissionRequest</c> handler</summary>
    procedure SetOnPermissionRequest(const AHandler: TPermissionRequestEvent);
    /// <summary>Returns <c>OnExternalChange</c> handler</summary>
    function GetOnExternalChange: TExternalChangeEvent;
    /// <summary>Sets <c>OnExternalChange</c> handler</summary>
    procedure SetOnExternalChange(const AHandler: TExternalChangeEvent);
    /// <summary>Event handler for receiving results of requesting access to Address Book</summary>
    /// <remarks>Actual only for iOS platform</remarks>
    property OnPermissionRequest: TPermissionRequestEvent read GetOnPermissionRequest write SetOnPermissionRequest;
    /// <summary>Event handler for notification about changes in AddressBook</summary>
    property OnExternalChange: TExternalChangeEvent read GetOnExternalChange write SetOnExternalChange;
    {$ENDREGION}
  end;

  /// <summary>Interface of service factory for creating instance of AddressBook</summary>
  IFMXAddressBookFactory = interface
  ['{1FA4587B-9C13-42FE-B251-CBD9D8AC5D68}']
    /// <summary>Creates platform depended instance of AddressBook.</summary>
    /// <remarks>Should be removed manually after using</remarks>
    function CreateAddressBook: IFMXAddressBookService;
  end;

implementation

uses
  FMX.Types, FMX.Platform,
{$IFDEF IOS}
  FMX.AddressBook.iOS,
{$ENDIF}
{$IFDEF ANDROID}
  FMX.AddressBook.Android,
{$ENDIF}
  FMX.Consts;

{ TAddressBook }

procedure TCustomAddressBook.CheckAuthorization(const AAccessType: TAddressBookAccessType);
begin
  if AuthorizationStatus(AAccessType) = TAuthorizationStatus.NotDetermined then
    raise EAddressBookAccess.Create(SCannotPerformOperation)
  else if AuthorizationStatus(AAccessType) = TAuthorizationStatus.Denied then
    raise EAddressBookAccess.Create(SCannotPerformOperationRejectedAccess);
end;

function TCustomAddressBook.ContactByID(const AID: Int32): TAddressBookContact;
begin
  if Supported then
    Result := Service.ContactByID(AID)
  else
    Result := nil;
end;

function TCustomAddressBook.GetOnExternalChange: TExternalChangeEvent;
begin
  if Supported then
    Result := Service.OnExternalChange
  else
    Result := FOnExternalChange;
end;

function TCustomAddressBook.GetOnPermissionRequest: TPermissionRequestEvent;
begin
  if Supported then
    Result := Service.OnPermissionRequest
  else
    Result := FOnPermissionRequest;
end;

function TCustomAddressBook.GroupByID(const AID: Int32): TAddressBookGroup;
begin
  if Supported then
    Result := Service.GroupByID(AID)
  else
    Result := nil;
end;

procedure TCustomAddressBook.SetOnExternalChange(const AValue: TExternalChangeEvent);
begin
  if Supported then
    Service.OnExternalChange := AValue
  else
    FOnExternalChange := AValue;
end;

procedure TCustomAddressBook.SetOnPermissionRequest(const AValue: TPermissionRequestEvent);
begin
  if Supported then
    Service.OnPermissionRequest := AValue
  else
    FOnPermissionRequest := AValue;
end;

function TCustomAddressBook.SourceByID(const AID: string): TAddressBookSource;
begin
  if Supported then
    Result := Service.SourceByID(AID)
  else
    Result := nil;
end;

constructor TCustomAddressBook.Create(AOwner: TComponent);
var
  Factory: IFMXAddressBookFactory;
begin
  inherited;
  if TPlatformServices.Current.SupportsPlatformService(IFMXAddressBookFactory, Factory) then
    FService := Factory.CreateAddressBook;
  FAuthorizationStatus[TAddressBookAccessType.Read] := TAuthorizationStatus.NotDetermined;
  FAuthorizationStatus[TAddressBookAccessType.Write] := TAuthorizationStatus.NotDetermined;
end;

function TCustomAddressBook.DefaultSource: TAddressBookSource;
begin
  if Supported then
    Result := Service.DefaultSource
  else
    Result := nil;
end;

destructor TCustomAddressBook.Destroy;
begin
  FService := nil;
  inherited;
end;

function TCustomAddressBook.Supported: Boolean;
begin
  Result := FService <> nil;
end;

procedure TCustomAddressBook.RequestPermission;
begin
  if Supported then
    Service.RequestPermission;
end;

procedure TCustomAddressBook.RevertCurrentChangesAndUpdate;
begin
  if Supported then
    Service.RevertCurrentChangesAndUpdate;
end;

function TCustomAddressBook.AuthorizationStatus(const AAccessType: TAddressBookAccessType): TAuthorizationStatus;
begin
  if (FAuthorizationStatus[AAccessType] = TAuthorizationStatus.NotDetermined) and Supported then
    FAuthorizationStatus[AAccessType] := Service.AuthorizationStatus(AAccessType);
  Result := FAuthorizationStatus[AAccessType];
end;

procedure TCustomAddressBook.AllGroups(const ASource: TAddressBookSource; var AGroups: TAddressBookGroups);
begin
  if AGroups = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotFetchAllGroupsNilArg, ['AGroups'])
  else
    CheckAuthorization(TAddressBookAccessType.Read);

  if Supported then
    Service.AllGroups(ASource, AGroups);
end;

procedure TCustomAddressBook.AllSources(var ASources: TAddressBookSources);
begin
  if ASources = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotFetchAllSourcesNilArg, ['ASources'])
  else
    CheckAuthorization(TAddressBookAccessType.Read);

  if Supported then
    Service.AllSources(ASources);
end;

function TCustomAddressBook.CreateGroup(const ASource: TAddressBookSource = nil): TAddressBookGroup;
begin
  CheckAuthorization(TAddressBookAccessType.Write);

  if Supported then
    Result := Service.CreateGroup(ASource)
  else
    Result := nil;
end;

procedure TCustomAddressBook.SaveGroup(const AGroup: TAddressBookGroup);
begin
  if AGroup = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotSaveGroupNilArg, ['AGroup'])
  else
    CheckAuthorization(TAddressBookAccessType.Write);

  if Supported then
    Service.SaveGroup(AGroup);
end;

procedure TCustomAddressBook.RemoveGroup(const AGroup: TAddressBookGroup);
begin
  if AGroup = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotRemoveGroupNilArg, ['AGroup'])
  else
    CheckAuthorization(TAddressBookAccessType.Write);

  if Supported then
    Service.RemoveGroup(AGroup);
end;

procedure TCustomAddressBook.AddContactIntoGroup(const AGroup: TAddressBookGroup; const AContact: TAddressBookContact);
begin
  if AGroup = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotAddContactIntoGroupNilArg, ['AGroup'])
  else if AContact = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotAddContactIntoGroupNilArg, ['AContact'])
  else
    CheckAuthorization(TAddressBookAccessType.Write);

  if Supported then
    Service.AddContactIntoGroup(AGroup, AContact);
end;

procedure TCustomAddressBook.RemoveContact(const AID: Integer);
begin
  CheckAuthorization(TAddressBookAccessType.Write);

  if Supported then
    Service.RemoveContact(AID);
end;

procedure TCustomAddressBook.RemoveContactFromGroup(const AGroup: TAddressBookGroup; const AContact: TAddressBookContact);
begin
  if AGroup = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotRemoveContactFromGroupNilArg, ['AGroup'])
  else if AContact = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotRemoveContactFromGroupNilArg, ['AContact'])
  else
    CheckAuthorization(TAddressBookAccessType.Write);

  if Supported then
    Service.RemoveContactFromGroup(AGroup, AContact);
end;

procedure TCustomAddressBook.RemoveGroup(const AID: Integer);
begin
  CheckAuthorization(TAddressBookAccessType.Write);

  if Supported then
    Service.RemoveGroup(AID);
end;

procedure TCustomAddressBook.AllContacts(const ASource: TAddressBookSource; var AContacts: TAddressBookContacts);
begin
  if AContacts = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotFetchAllContactNilArg, ['AContacts'])
  else
    CheckAuthorization(TAddressBookAccessType.Read);

  if Supported then
    Service.AllContacts(ASource, AContacts);
end;

procedure TCustomAddressBook.AllContacts(var AContacts: TAddressBookContacts);
begin
  AllContacts(nil, AContacts);
end;

procedure TCustomAddressBook.AllContactsInGroups(const AGroups: TAddressBookGroups; var AContacts: TAddressBookContacts);
begin
  if AGroups = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotFetchContactsInGroupNilArg, ['AGroups'])
  else if AContacts = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotFetchContactsInGroupNilArg, ['AContacts'])
  else
    CheckAuthorization(TAddressBookAccessType.Read);

  if Supported then
    Service.AllContactsInGroups(AGroups, AContacts);
end;

procedure TCustomAddressBook.AllGroups(var AGroups: TAddressBookGroups);
begin
  AllGroups(nil, AGroups);
end;

procedure TCustomAddressBook.AllContactsInGroup(const AGroup: TAddressBookGroup; var AContacts: TAddressBookContacts);
var
  Groups: TAddressBookGroups;
begin
  if AGroup = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotFetchContactsInGroupNilArg, ['AGroup'])
  else if AContacts = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotFetchContactsInGroupNilArg, ['AContacts'])
  else
    CheckAuthorization(TAddressBookAccessType.Read);

  if Supported then
  begin
    Groups := TAddressBookGroups.Create;
    try
      Groups.Add(AGroup);
      Service.AllContactsInGroups(Groups, AContacts);
    finally
      Groups.Free;
    end;
  end;
end;

function TCustomAddressBook.CreateContact(const ASource: TAddressBookSource = nil): TAddressBookContact;
begin
  CheckAuthorization(TAddressBookAccessType.Write);

  if Supported then
    Result := Service.CreateContact(ASource)
  else
    Result := nil;
end;

procedure TCustomAddressBook.SaveContact(const AContact: TAddressBookContact);
begin
  if AContact = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotSaveContactNilArg, ['AContact'])
  else
    CheckAuthorization(TAddressBookAccessType.Write);

  if Supported then
    Service.SaveContact(AContact);
end;

procedure TCustomAddressBook.RemoveContact(const AContact: TAddressBookContact);
begin
  if AContact = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotRemoveContactNilArg, ['AContact'])
  else
    CheckAuthorization(TAddressBookAccessType.Write);

  if Supported then
    Service.RemoveContact(AContact);
end;

{ TAddressBookGroup }

constructor TAddressBookGroup.Create;
begin
  raise EAddressBookException.Create(SCannotCreateGroupUseFactoryMethod);
end;

{ TAddressBookContact }

constructor TAddressBookContact.Create;
begin
  raise EAddressBookException.Create(SCannotCreateContactUseFactoryMethod);
end;

{ TAddressBookSource }

constructor TAddressBookSource.Create;
begin
  raise EAddressBookException.Create(SCannotCreateSource);
end;

initialization
  RegisterFmxClasses([TAddressBook]);
  GroupDescendentsWith(TAddressBook, TFmxObject);
{$IF Defined(IOS) OR Defined(ANDROID)}
  RegisterService;
{$ENDIF}
end.
