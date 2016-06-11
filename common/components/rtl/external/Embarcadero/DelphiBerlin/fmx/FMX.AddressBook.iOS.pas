{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.AddressBook.iOS;

interface

{$SCOPEDENUMS ON}

uses
  System.Generics.Collections, iOSapi.AddressBook, iOSapi.Foundation, Macapi.CoreFoundation, FMX.AddressBook,
  FMX.AddressBook.Types, FMX.Surfaces;

type

{ TiOSAddressBook }

  TiOSAddressBook = class(TInterfacedObject, IFMXAddressBookService)
  private
    FAddressBookRef: ABAddressBookRef;
    FOnExternalChange: TExternalChangeEvent;
    FOnPermissionRequest: TPermissionRequestEvent;
    procedure AddressBookRequestAccessCompletionHandler(granted: Boolean; error: CFErrorRef);
    class procedure AddressBookExternalChange(addressBook: ABAddressBookRef; info: CFDictionaryRef; context: Pointer); cdecl; static;
  protected
    { IFMXAddressBookService }
    /// <summary>Invokes user <c>OnPermissionRequest</c> event handler</summary>
    procedure DoPermissionRequest(const AMessage: string; const AAccessGranted: Boolean);
    /// <summary>Invokes user <c>OnContactChange</c> event handler</summary>
    procedure DoExternalChange;
    { Changes }
    procedure RevertCurrentChangesAndUpdate;
    { Permissions }
    procedure RequestPermission;
    function AuthorizationStatus(const AAccessType: TAddressBookAccessType): TAuthorizationStatus;
    { Sources }
    procedure AllSources(var ASources: TAddressBookSources);
    function SourceByID(const AID: string): TAddressBookSource;
    function DefaultSource: TAddressBookSource;
    { Contacts }
    procedure AllContacts(const ASource: TAddressBookSource; var AContacts: TAddressBookContacts);
    function ContactByID(const AID: Int32): TAddressBookContact;
    function CreateContact(const ASource: TAddressBookSource = nil): TAddressBookContact;
    procedure SaveContact(const AContact: TAddressBookContact);
    procedure RemoveContact(const AContact: TAddressBookContact); overload;
    procedure RemoveContact(const AID: Integer); overload;
    { Groups }
    procedure AllGroups(const ASource: TAddressBookSource; var AGroups: TAddressBookGroups);
    function GroupByID(const AID: Int32): TAddressBookGroup;
    procedure SaveGroup(const AGroup: TAddressBookGroup);
    procedure RemoveGroup(const AGroup: TAddressBookGroup); overload;
    procedure RemoveGroup(const AID: Integer); overload;
    function CreateGroup(const ASource: TAddressBookSource = nil): TAddressBookGroup;
    { Contacts in Group }
    procedure AllContactsInGroups(const AGroups: TAddressBookGroups; var AContacts: TAddressBookContacts);
    procedure AddContactIntoGroup(const AGroup: TAddressBookGroup; const AContact: TAddressBookContact);
    procedure RemoveContactFromGroup(const AGroup: TAddressBookGroup; const AContact: TAddressBookContact);
    { Handlers }
    function GetOnPermissionRequest: TPermissionRequestEvent;
    procedure SetOnPermissionRequest(const AHandler: TPermissionRequestEvent);
    function GetOnExternalChange: TExternalChangeEvent;
    procedure SetOnExternalChange(const AHandler: TExternalChangeEvent);
  public
    constructor Create;
    destructor Destroy; override;
  public
    property AddressBookRef: ABAddressBookRef read FAddressBookRef;
  end;

{ TiOSAddressBookSource }

  TiOSAddressBookSource = class(TAddressBookSource)
  private
    [Weak] FAddressBook: TiOSAddressBook;
     FSourceRef: ABRecordRef;
  protected
    function GetID: string; override;
    function GetSourceName: string; override;
    function GetSourceType: string; override;
  public
    constructor Create(const AAddressBook: TiOSAddressBook; const ASourceRef: ABRecordRef);
    destructor Destroy; override;
    property AddressBook: TiOSAddressBook read FAddressBook;
    property SourceRef: ABRecordRef read FSourceRef;
  end;

{ TiOSAddressBookGroup }

  TiOSAddressBookGroup = class(TAddressBookGroup)
  private
    [Weak] FAddressBook: TiOSAddressBook;
    FGroupRef: ABRecordRef;
  protected
    function GetName: string; override;
    procedure SetName(const AValue: string); override;
    function GetID: Integer; override;
    function GetSource: TAddressBookSource; override;
  public
    constructor CreateNew(const AAddressBook: TiOSAddressBook; const ASource: TAddressBookSource = nil);
    constructor CreateExisted(const AAddressBook: TiOSAddressBook; const AGroupRef: ABRecordRef);
    destructor Destroy; override;
    property AddressBook: TiOSAddressBook read FAddressBook;
    property GroupRef: ABRecordRef read FGroupRef;
  end;

{ TiOSAddressBookContact }

  TiOSAddressBookContact = class(TAddressBookContact)
  private
    [Weak] FAddressBook: TiOSAddressBook;
    FPersonRef: ABRecordRef;
    procedure SetPropertyValue(const AProperty: ABPropertyID; const AValue: string); overload;
    procedure SetPropertyValue(const AProperty: ABPropertyID; const AValue: TDateTime); overload;
    procedure SetPropertyValue(const AValue: TContactDates); overload;
    procedure SetPropertyValue(const AValue: TContactAddresses); overload;
    procedure SetPropertyValue(const AValue: TContactMessagingServices); overload;
    procedure SetPropertyValue(const AValue: TContactSocialProfiles); overload;
    procedure SetPropertyValue(const AValue: TContactPhones); overload;
    procedure SetPropertyValue(const AValue: TContactEmails); overload;
    procedure SetPropertyValue(const AValue: TContactRelatedNames); overload;
    procedure SetPropertyValue(const AValue: TContactURLs); overload;
    procedure SetPropertyValue(const AFormat: ABPersonImageFormat; const AValue: TBitmapSurface); overload;
    function GetStringPropertyValue(const AProperty: ABPropertyID): string; overload;
    function GetDateTimePropertyValue(const AProperty: ABPropertyID): TDateTime; overload;
    function GetDatePropertyValue(const AProperty: ABPropertyID): TDateTime;
    function GetPhotoPropertyValue(const AFormat: ABPersonImageFormat): TBitmapSurface; overload;
    function GetAddressesPropertyValue(const AProperty: ABPropertyID): TContactAddresses; overload;
    function GetSocialProfilesPropertyValue(const AProperty: ABPropertyID): TContactSocialProfiles; overload;
  protected
    { Ordinary types }
    function GetStringValue(const AIndex: TContactField): string; override;
    procedure SetStringValue(const AIndex: TContactField; const AValue: string); override;
    function GetBitmapValue(const AIndex: TContactField): TBitmapSurface; override;
    procedure SetBitmapValue(const AIndex: TContactField; const AValue: TBitmapSurface); override;
    function GetDateTimeValue(const AIndex: TContactField): TDateTime; override;
    procedure SetDateTimeValue(const AIndex: TContactField; const AValue: TDateTime); override;
    { Lists }
    function GetDates(const AIndex: TContactField): TContactDates; override;
    procedure SetDates(const AIndex: TContactField; const AValue: TContactDates); override;
    { Custom fields }
    function GetAddresses(const AIndex: TContactField): TContactAddresses; override;
    procedure SetAddresses(const AIndex: TContactField; const AValue: TContactAddresses); override;
    function GetMessagingServices(const AIndex: TContactField): TContactMessagingServices; override;
    procedure SetMessagingServices(const AIndex: TContactField; const AValue: TContactMessagingServices); override;
    function GetSocialProfiles(const AIndex: TContactField): TContactSocialProfiles; override;
    procedure SetSocialProfiles(const AIndex: TContactField; const AValue: TContactSocialProfiles); override;
    function GetPhones(const AIndex: TContactField): TContactPhones; override;
    procedure SetPhones(const AIndex: TContactField; const AValue: TContactPhones); override;
    function GetEmails(const AIndex: TContactField): TContactEmails; override;
    procedure SetEmails(const AIndex: TContactField; const AValue: TContactEmails); override;
    function GetRelatedNames(const AIndex: TContactField): TContactRelatedNames; override;
    procedure SetRelatedNames(const AIndex: TContactField; const AValue: TContactRelatedNames); override;
    function GetURLs(const AIndex: TContactField): TContactURLs; override;
    procedure SetURLs(const AIndex: TContactField; const AValue: TContactURLs); override;
    function GetSource: TAddressBookSource; override;
    function GetID: Int32; override;
    function GetContactKind: TContactKind; override;
    function GetDisplayName: string; override;
  public
    constructor CreateNew(const AAddressBook: TiOSAddressBook; const ASource: TAddressBookSource = nil);
    constructor CreateFromExisting(const AAddressBook: TiOSAddressBook; const APersonRef: ABRecordRef);
    property PersonRef: ABRecordRef read FPersonRef;
  end;

  TiOSAddressBookHelpers = class
  public
    class function LabelToPhoneKind(const AKind: CFStringRef): TContactPhone.TLabelKind; static;
    class function PhoneKindToLabel(const APhone: TContactPhone): CFStringRef; static;
    class function LabelToEmailKind(const AKind: CFStringRef): TContactEmail.TLabelKind; static;
    class function EmailKindToLabel(const AEmail: TContactEmail): CFStringRef; static;
    class function LabelToRelationShipKind(const AKind: CFStringRef): TContactRelatedName.TLabelKind; static;
    class function RelationShipKindToLabel(const ARelationship: TContactRelatedName): CFStringRef; static;
    class function LabelToURLKind(const AKind: CFStringRef): TContactURL.TLabelKind; static;
    class function URLKindToLabel(const AUrl: TContactURL): CFStringRef; static;
    class function LabelToDateKind(const AKind: CFStringRef): TContactDate.TLabelKind; static;
    class function DateKindToLabel(const ADate: TContactDate): CFStringRef; static;
    class function LabelToAddressKind(const AKind: CFStringRef): TContactAddress.TLabelKind; static;
    class function AddressKindToLabel(const AAddress: TContactAddress): CFStringRef; static;
    class function LabelToMessagingServiceLabelKind(const AKind: CFStringRef): TContactMessagingService.TLabelKind; static;
    class function MessagingServiceLabelKindToLabel(const AProfile: TContactMessagingService): CFStringRef; static;
    class function LabelToMessagingServiceKind(const AKind: string): TContactMessagingService.TServiceKind; static;
    class function MessagingServiceKindToLabel(const AProfile: TContactMessagingService): CFStringRef; static;
    class function LabelToSocialProfileKind(const AKind: CFStringRef): TContactSocialProfile.TLabelKind; static;
    class function SocialProfileKindToLabel(const AProfile: TContactSocialProfile): CFStringRef; static;
    class function LabelToSocialProfileServiceKind(const AKind: string): TContactSocialProfile.TServiceKind; static;
    class function SocialProfileServiceKindToLabel(const AProfile: TContactSocialProfile): CFStringRef; static;
  end;

{ TiOSAddressBookServices }

  TiOSAddressBookServices = class(TInterfacedObject, IFMXAddressBookFactory, IFMXAddressBookSupportedLabelKinds)
  public
    { IFMXAddressBookFactory }
    function CreateAddressBook: IFMXAddressBookService;
    { IFMXAddressBookSupportedLabelKinds }
    function AddressesLabelKinds: TContactAddress.TLabelKinds;
    function SocialProfilesLabelKinds: TContactSocialProfile.TLabelKinds;
    function SocialProfilesServiceKinds: TContactSocialProfile.TServiceKinds;
    function MessagingServicesLabelKinds: TContactMessagingService.TLabelKinds;
    function MessagingServicesKinds: TContactMessagingService.TServiceKinds;
    function DatesLabelKinds: TContactDate.TLabelKinds;
    function PhonesLabelKinds: TContactPhone.TLabelKinds;
    function EmailsLabelKinds: TContactEmail.TLabelKinds;
    function RelatedNamesLabelKinds: TContactRelatedName.TLabelKinds;
    function URLsLabelKinds: TContactURL.TLabelKinds;
  end;

procedure RegisterService;

implementation

uses
  System.SysUtils, System.Types, System.Math, System.Classes, Macapi.Helpers, Macapi.ObjCRuntime, Macapi.ObjectiveC,
  Macapi.OCBlocks, iOSapi.UIKit, iOSapi.Helpers, FMX.Helpers.iOS, FMX.Types, FMX.Consts, FMX.Platform;

procedure RegisterService;
var
  AddressBookServices: TiOSAddressBookServices;
begin
  AddressBookServices := TiOSAddressBookServices.Create;
  TPlatformServices.Current.AddPlatformService(IFMXAddressBookFactory, AddressBookServices);
  TPlatformServices.Current.AddPlatformService(IFMXAddressBookSupportedLabelKinds, AddressBookServices);
end;

function ExtractString(const ASource: CFDictionaryRef; const AKey: NSString): string;
begin
  if (ASource <> nil) and CFDictionaryContainsKey(ASource, NSStringToID(AKey)) then
    Result := CFStringRefToStr(CFDictionaryGetValue(ASource, NSStringToID(AKey)))
  else
    Result := string.Empty;
end;

{ TiOSAddressBookContact }

constructor TiOSAddressBookContact.CreateNew(const AAddressBook: TiOSAddressBook; const ASource: TAddressBookSource);
begin
  if AAddressBook = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotCreateContactNilArg, ['AAddressBook']);
  if (ASource <> nil) and not (ASource is TiOSAddressBookSource) then
    raise EAddressBookWrongArgs.CreateFmt(SCannotCreateContactWrongClassArg, ['ASource', 'TAddressBookSource']);

  FAddressBook := AAddressBook;
  if ASource = nil then
    FPersonRef := ABPersonCreate
  else
    FPersonRef := ABPersonCreateInSource(TiOSAddressBookSource(ASource).SourceRef);
end;

function TiOSAddressBookContact.GetPhones(const AIndex: TContactField): TContactPhones;
var
  MultiValue: ABMutableMultiValueRef;
  ValuesCount: Integer;
  LabelRef: CFStringRef;
  ValueRef: CFStringRef;
  I: Integer;
  PhoneKind: TContactPhone.TLabelKind;
  PhoneNumber: string;
  PhoneLabel: string;
begin
  if AIndex = TContactField.Phones then
  begin
    Result := TContactPhones.Create;
    MultiValue := ABRecordCopyValue(FPersonRef, kABPersonPhoneProperty);
    if MultiValue <> nil then
      try
        ValuesCount := ABMultiValueGetCount(MultiValue);
        for I := 0 to ValuesCount - 1 do
        begin
          LabelRef := ABMultiValueCopyLabelAtIndex(MultiValue, I);
          ValueRef := ABMultiValueCopyValueAtIndex(MultiValue, I);
          try
            PhoneNumber := CFStringRefToStr(ValueRef);
            PhoneKind := TiOSAddressBookHelpers.LabelToPhoneKind(LabelRef);
            if LabelRef <> nil then
              PhoneLabel := CFStringRefToStr(ABAddressBookCopyLocalizedLabel(LabelRef))
            else
              PhoneLabel := string.Empty;
            
            if PhoneKind = TContactPhone.TLabelKind.Custom then
              Result.AddPhone(PhoneLabel, PhoneNumber)
            else
              Result.AddPhone(PhoneKind, PhoneNumber);
          finally
            if LabelRef <> nil then
              CFRelease(LabelRef);
            CFRelease(ValueRef);
          end;
        end;
      finally
        CFRelease(MultiValue);
      end;
  end
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

function TiOSAddressBookContact.GetPhotoPropertyValue(const AFormat: ABPersonImageFormat): TBitmapSurface;

  procedure NormalizeOrientation(var ASurface: TBitmapSurface; const AImage: UIImage);
  begin
    case AImage.imageOrientation of
      UIImageOrientationDown,
      UIImageOrientationDownMirrored:
        ASurface.Rotate180;
      UIImageOrientationLeft,
      UIImageOrientationLeftMirrored:
        ASurface.Rotate270;
      UIImageOrientationRight,
      UIImageOrientationRightMirrored:
        ASurface.Rotate90;
    end;
  end;

var
  Value: CFTypeRef;
  ImageData: NSData;
  Image: UIImage;
begin
  Result := nil;
  if ABPersonHasImageData(FPersonRef) > 0 then
  begin
    Value := ABPersonCopyImageData(PersonRef);
    // iOS device can return nil, even if ABPersonHasImageData returns true.
    if Value <> nil then
      try
        ImageData := TNSData.Wrap(Value);
        Image := TUIImage.Wrap(TUIImage.OCClass.imageWithData(ImageData));
        Result := UIImageToBitmapSurface(Image);
        NormalizeOrientation(Result, Image);
      finally
        CFRelease(Value);
      end;
  end;
end;

function TiOSAddressBookContact.GetRelatedNames(const AIndex: TContactField): TContactRelatedNames;
var
  MultiValue: ABMutableMultiValueRef;
  ValuesCount: Integer;
  LabelRef: CFStringRef;
  ValueRef: CFStringRef;
  I: Integer;
  RelationKind: TContactRelatedName.TLabelKind;
  Name: string;
  RelationLabel: string;
begin
  if AIndex = TContactField.RelatedNames then
  begin
    Result := TContactRelatedNames.Create;
    MultiValue := ABRecordCopyValue(FPersonRef, kABPersonRelatedNamesProperty);
    if MultiValue <> nil then
      try
        ValuesCount := ABMultiValueGetCount(MultiValue);
        for I := 0 to ValuesCount - 1 do
        begin
          LabelRef := ABMultiValueCopyLabelAtIndex(MultiValue, I);
          ValueRef := ABMultiValueCopyValueAtIndex(MultiValue, I);
          try
            Name := CFStringRefToStr(ValueRef);
            RelationKind := TiOSAddressBookHelpers.LabelToRelationShipKind(LabelRef);
            if LabelRef <> nil then
              RelationLabel := CFStringRefToStr(ABAddressBookCopyLocalizedLabel(LabelRef))
            else
              RelationLabel := string.Empty;

            if RelationKind = TContactRelatedName.TLabelKind.Custom then
              Result.AddRelatedName(RelationLabel, Name)
            else
              Result.AddRelatedName(RelationKind, Name);
          finally
            if LabelRef <> nil then
              CFRelease(LabelRef);
            CFRelease(ValueRef);
          end;
        end;
      finally
        CFRelease(MultiValue);
      end;
  end
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

function TiOSAddressBookContact.GetAddresses(const AIndex: TContactField): TContactAddresses;
begin
  if AIndex = TContactField.Addresses then
    Result := GetAddressesPropertyValue(kABPersonAddressProperty)
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

constructor TiOSAddressBookContact.CreateFromExisting(const AAddressBook: TiOSAddressBook; const APersonRef: ABRecordRef);
begin
  if AAddressBook = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotCreateContactNilArg, ['AAddressBook']);

  if APersonRef = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotCreateContactNilArg, ['APersonRef']);

  CFRetain(APersonRef);
  FAddressBook := AAddressBook;
  FPersonRef := APersonRef;
end;

function TiOSAddressBookContact.GetAddressesPropertyValue(const AProperty: ABPropertyID): TContactAddresses;
var
  AddressesRef: CFTypeRef;
  AddressRef: CFTypeRef;
  Address: TContactAddress;
  AddressesCount: Integer;
  I: Integer;
  LabelRef: CFStringRef;
  AddressKind: TContactAddress.TLabelKind;
  AddressLabel: string;
begin
  Result := TContactAddresses.Create;
  AddressesRef := ABRecordCopyValue(FPersonRef, AProperty);
  if AddressesRef <> nil then
    try
      AddressesCount := ABMultiValueGetCount(AddressesRef);
      for I := 0 to AddressesCount - 1 do
      begin
        AddressRef := ABMultiValueCopyValueAtIndex(AddressesRef, I);
        LabelRef := ABMultiValueCopyLabelAtIndex(AddressesRef, I);
        try
          AddressKind := TiOSAddressBookHelpers.LabelToAddressKind(LabelRef);
          if LabelRef <> nil then
            AddressLabel := CFStringRefToStr(ABAddressBookCopyLocalizedLabel(LabelRef))
          else
            AddressLabel := string.Empty;

          Address := TContactAddress.Create;
          if AddressKind = TContactAddress.TLabelKind.Custom then
            Address.LabelText := AddressLabel
          else
            Address.LabelKind := AddressKind;

          Address.Street := ExtractString(AddressRef, kABPersonAddressStreetKey);
          Address.City := ExtractString(AddressRef, kABPersonAddressCityKey);
          Address.State := ExtractString(AddressRef, kABPersonAddressStateKey);
          Address.ZIP := ExtractString(AddressRef, kABPersonAddressZIPKey);
          Address.Country := ExtractString(AddressRef, kABPersonAddressCountryKey);

          Result.Add(Address);
        finally
          if LabelRef <> nil then
            CFRelease(LabelRef);
          CFRelease(AddressRef);
        end;
      end;
    finally
      CFRelease(AddressesRef);
    end;
end;

function TiOSAddressBookContact.GetBitmapValue(const AIndex: TContactField): TBitmapSurface;
begin
  case AIndex of
    TContactField.Photo:
      Result := GetPhotoPropertyValue(kABPersonImageFormatOriginalSize);
    TContactField.PhotoThumbnail:
      Result := GetPhotoPropertyValue(kABPersonImageFormatThumbnail);
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
  end;
end;

function TiOSAddressBookContact.GetContactKind: TContactKind;
const
  PersonKindOrganization = 0;
var
  ValueRef: CFNumberRef;
begin
  Result := TContactKind.Person;
  ValueRef := ABRecordCopyValue(PersonRef, kABPersonKindProperty);
  if ValueRef <> nil then
    try
      if TNSNumber.Wrap(ValueRef).intValue <> PersonKindOrganization then
        Result := TContactKind.Organization;
    finally
      CFRelease(ValueRef);
    end;
end;

function TiOSAddressBookContact.GetDatePropertyValue(const AProperty: ABPropertyID): TDateTime;
var
  Value: CFTypeRef;
begin
  Result := NaN;
  Value := ABRecordCopyValue(FPersonRef, AProperty);
  if Value <> nil then
    try
      Result := NSDateToDate(TNSDate.Wrap(Value));
    finally
      CFRelease(Value);
    end;
end;

function TiOSAddressBookContact.GetDateTimePropertyValue(const AProperty: ABPropertyID): TDateTime;
var
  Value: CFTypeRef;
begin
  Result := NaN;
  Value := ABRecordCopyValue(FPersonRef, AProperty);
  if Value <> nil then
    try
      Result := NSDateToDateTime(TNSDate.Wrap(Value));
    finally
      CFRelease(Value);
    end;
end;

function TiOSAddressBookContact.GetSocialProfiles(const AIndex: TContactField): TContactSocialProfiles;
begin
  if AIndex = TContactField.SocialProfiles then
    Result := GetSocialProfilesPropertyValue(kABPersonSocialProfileProperty)
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

function TiOSAddressBookContact.GetSocialProfilesPropertyValue(const AProperty: ABPropertyID): TContactSocialProfiles;
var
  ProfilesRef: CFTypeRef;
  ProfileRef: CFTypeRef;
  Profile: TContactSocialProfile;
  ProfilesCount: Integer;
  I: Integer;
  LabelRef: CFStringRef;
  LabelKind: TContactSocialProfile.TLabelKind;
  ProfileLabel: string;
  ServiceKind: TContactSocialProfile.TServiceKind;
  ServiceName: string;
begin
  Result := TContactSocialProfiles.Create;
  ProfilesRef := ABRecordCopyValue(FPersonRef, AProperty);
  if ProfilesRef <> nil then
    try
      ProfilesCount := ABMultiValueGetCount(ProfilesRef);
      for I := 0 to ProfilesCount - 1 do
      begin
        ProfileRef := ABMultiValueCopyValueAtIndex(ProfilesRef, I);
        LabelRef := ABMultiValueCopyLabelAtIndex(ProfilesRef, I);
        Profile := TContactSocialProfile.Create;
        try
          LabelKind := TiOSAddressBookHelpers.LabelToSocialProfileKind(LabelRef);
          if LabelRef <> nil then
            ProfileLabel :=  CFStringRefToStr(ABAddressBookCopyLocalizedLabel(LabelRef))
          else
            ProfileLabel := string.Empty;
          if LabelKind = TContactSocialProfile.TLabelKind.Custom then
            Profile.LabelText := ProfileLabel
          else
            Profile.LabelKind := LabelKind;

          ServiceName := ExtractString(ProfileRef, kABPersonSocialProfileServiceKey);
          ServiceKind := TiOSAddressBookHelpers.LabelToSocialProfileServiceKind(ServiceName);
          if ServiceKind = TContactSocialProfile.TServiceKind.Custom then
            Profile.ServiceName := ServiceName
          else
            Profile.ServiceKind := ServiceKind;

          Profile.URL := ExtractString(ProfileRef, kABPersonSocialProfileURLKey);
          Profile.UserName := ExtractString(ProfileRef, kABPersonSocialProfileUsernameKey);
          Profile.UserIdentifier := ExtractString(ProfileRef, kABPersonSocialProfileUserIdentifierKey);

          Result.Add(Profile);
        finally
          CFRelease(ProfileRef);
          if LabelRef <> nil then
            CFRelease(LabelRef);
        end;
      end;
    finally
      CFRelease(ProfilesRef);
    end;
end;

function TiOSAddressBookContact.GetSource: TAddressBookSource;
var
  SourceRef: ABRecordRef;
begin
  SourceRef := ABPersonCopySource(PersonRef);
  if SourceRef <> nil then
    Result := TiOSAddressBookSource.Create(FAddressBook, SourceRef)
  else
    Result := nil;
end;

function TiOSAddressBookContact.GetStringValue(const AIndex: TContactField): string;
begin
  case AIndex of
    TContactField.FirstName:
      Result := GetStringPropertyValue(kABPersonFirstNameProperty);
    TContactField.LastName:
      Result := GetStringPropertyValue(kABPersonLastNameProperty);
    TContactField.MiddleName:
      Result := GetStringPropertyValue(kABPersonMiddleNameProperty);
    TContactField.Prefix:
      Result := GetStringPropertyValue(kABPersonPrefixProperty);
    TContactField.Suffix:
      Result := GetStringPropertyValue(kABPersonSuffixProperty);
    TContactField.NickName:
      Result := GetStringPropertyValue(kABPersonNicknameProperty);
    TContactField.FirstNamePhonetic:
      Result := GetStringPropertyValue(kABPersonFirstNamePhoneticProperty);
    TContactField.LastNamePhonetic:
      Result := GetStringPropertyValue(kABPersonLastNamePhoneticProperty);
    TContactField.MiddleNamePhonetic:
      Result := GetStringPropertyValue(kABPersonMiddleNamePhoneticProperty);
    TContactField.Organization:
      Result := GetStringPropertyValue(kABPersonOrganizationProperty);
    TContactField.JobTitle:
      Result := GetStringPropertyValue(kABPersonJobTitleProperty);
    TContactField.Department:
      Result := GetStringPropertyValue(kABPersonDepartmentProperty);
    TContactField.Note:
      Result := GetStringPropertyValue(kABPersonNoteProperty);
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
  end;
end;

function TiOSAddressBookContact.GetURLs(const AIndex: TContactField): TContactURLs;
var
  MultiValue: ABMutableMultiValueRef;
  ValuesCount: Integer;
  LabelRef: CFStringRef;
  ValueRef: CFStringRef;
  I: Integer;
  URLKind: TContactURL.TLabelKind;
  URL: string;
  URLLabel: string;
begin
  if AIndex = TContactField.URLs then
  begin
    Result := TContactURLs.Create;
    MultiValue := ABRecordCopyValue(FPersonRef, kABPersonURLProperty);
    if MultiValue <> nil then
      try
        ValuesCount := ABMultiValueGetCount(MultiValue);
        for I := 0 to ValuesCount - 1 do
        begin
          LabelRef := ABMultiValueCopyLabelAtIndex(MultiValue, I);
          ValueRef := ABMultiValueCopyValueAtIndex(MultiValue, I);
          try
            URL := CFStringRefToStr(ValueRef);
            URLKind := TiOSAddressBookHelpers.LabelToURLKind(LabelRef);
            if LabelRef <> nil then
              URLLabel := CFStringRefToStr(ABAddressBookCopyLocalizedLabel(LabelRef))
            else
              URLLabel := string.Empty;

            if URLKind = TContactURL.TLabelKind.Custom then
              Result.AddURL(URLLabel, URL)
            else
              Result.AddURL(URLKind, URL);
          finally
            if LabelRef <> nil then
              CFRelease(LabelRef);
            CFRelease(ValueRef);
          end;
        end;
      finally
        CFRelease(MultiValue);
      end;
  end
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

procedure TiOSAddressBookContact.SetAddresses(const AIndex: TContactField; const AValue: TContactAddresses);
begin
  if AIndex = TContactField.Addresses then
    SetPropertyValue(AValue)
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

procedure TiOSAddressBookContact.SetPropertyValue(const AValue: TContactAddresses);

  procedure AddAddress(const AAddresses: ABMutableMultiValueRef; const AAddress: TContactAddress);
  var
    AddressDictionary: NSMutableDictionary;
    AddressLabel: CFStringRef;
  begin
    AddressDictionary := TNSMutableDictionary.Create;
    AddressDictionary.setValue(StringToID(AAddress.Street), kABPersonAddressStreetKey);
    AddressDictionary.setValue(StringToID(AAddress.City), kABPersonAddressCityKey);
    AddressDictionary.setValue(StringToID(AAddress.State), kABPersonAddressStateKey);
    AddressDictionary.setValue(StringToID(AAddress.ZIP), kABPersonAddressZIPKey);
    AddressDictionary.setValue(StringToID(AAddress.Country), kABPersonAddressCountryKey);
    AddressLabel := TiOSAddressBookHelpers.AddressKindToLabel(AAddress);

    if not ABMultiValueAddValueAndLabel(AAddresses, NSObjectToID(AddressDictionary), AddressLabel, 0) then
      raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, [TContactField.Addresses.ToString]);
  end;

var
  Error: CFErrorRef;
  I: Integer;
  AddressesRef: ABMutableMultiValueRef;
begin
  AddressesRef := ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
  try
    for I := 0 to AValue.Count - 1 do
      AddAddress(AddressesRef, AValue[I]);

    Error := nil;
    if not ABRecordSetValue(PersonRef, kABPersonAddressProperty, AddressesRef, Error) then
      raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, [TContactField.Addresses.ToString, CFErrorRefToDescription(Error)]);
  finally
    CFRelease(AddressesRef);
  end;
end;

procedure TiOSAddressBookContact.SetBitmapValue(const AIndex: TContactField; const AValue: TBitmapSurface);
begin
  if AIndex = TContactField.Photo then
    SetPropertyValue(kABPersonImageFormatOriginalSize, AValue)
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

procedure TiOSAddressBookContact.SetDateTimeValue(const AIndex: TContactField; const AValue: TDateTime);
begin
  if AIndex = TContactField.Birthday then
    SetPropertyValue(kABPersonBirthdayProperty, AValue)
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

procedure TiOSAddressBookContact.SetEmails(const AIndex: TContactField; const AValue: TContactEmails);
begin
  if AIndex = TContactField.EMails then
    SetPropertyValue(AValue)
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

procedure TiOSAddressBookContact.SetDates(const AIndex: TContactField; const AValue: TContactDates);
begin
  if AIndex = TContactField.Dates then
    SetPropertyValue(AValue)
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

procedure TiOSAddressBookContact.SetPropertyValue(const AValue: TContactDates);
var
  MultiValue: ABMutableMultiValueRef;
  I: Integer;
  Value: TContactDate;
  Error: CFErrorRef;
  Date: NSDate;
  EventLabelRef: CFStringRef;
begin
  MultiValue := ABMultiValueCreateMutable(kABMultiDateTimePropertyType);
  try
    for I := 0 to AValue.Count - 1 do
    begin
      Value := AValue.Items[I];
      Date := DateTimeToNSDate(Value.Date);
      EventLabelRef := TiOSAddressBookHelpers.DateKindToLabel(Value);

      if not ABMultiValueAddValueAndLabel(MultiValue, NSObjectToID(Date), EventLabelRef, 0) then
        raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, [TContactField.Dates.ToString]);
    end;

    Error := nil;
    if not ABRecordSetValue(PersonRef, kABPersonDateProperty, MultiValue, Error) then
      raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, [TContactField.Dates.ToString, CFErrorRefToDescription(Error)]);
  finally
    CFRelease(MultiValue)
  end;
end;

procedure TiOSAddressBookContact.SetMessagingServices(const AIndex: TContactField; const AValue: TContactMessagingServices);
begin
  if AIndex = TContactField.MessagingServices then
    SetPropertyValue(AValue)
  else
    raise EAddressBookException.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

procedure TiOSAddressBookContact.SetPropertyValue(const AFormat: ABPersonImageFormat; const AValue: TBitmapSurface);
var
  Image: UIImage;
  Error: CFErrorRef;
  DataRef: CFDataRef;
begin
  if (AValue = nil) or (AValue.Width = 0) or (AValue.Height = 0) then
  begin
    Error := nil;
    if not ABPersonRemoveImageData(PersonRef, Error) then
      raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, [TContactField.Photo.ToString, CFErrorRefToDescription(Error)]);
  end
  else
  begin
    Image := BitmapSurfaceToUIImage(AValue);
    DataRef := UIImagePNGRepresentation(NSObjectToID(Image));
    Error := nil;
    if not ABPersonSetImageData(PersonRef, DataRef, Error) then
      raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, [TContactField.Photo.ToString, CFErrorRefToDescription(Error)]);
  end;
end;

procedure TiOSAddressBookContact.SetSocialProfiles(const AIndex: TContactField; const AValue: TContactSocialProfiles);
begin
  if AIndex = TContactField.SocialProfiles then
    SetPropertyValue(AValue)
  else
    raise EAddressBookException.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

procedure TiOSAddressBookContact.SetStringValue(const AIndex: TContactField; const AValue: string);
begin
  case AIndex of
    TContactField.FirstName:
      SetPropertyValue(kABPersonFirstNameProperty, AValue);
    TContactField.LastName:
      SetPropertyValue(kABPersonLastNameProperty, AValue);
    TContactField.MiddleName:
      SetPropertyValue(kABPersonMiddleNameProperty, AValue);
    TContactField.Prefix:
      SetPropertyValue(kABPersonPrefixProperty, AValue);
    TContactField.Suffix:
      SetPropertyValue(kABPersonSuffixProperty, AValue);
    TContactField.NickName:
      SetPropertyValue(kABPersonNicknameProperty, AValue);
    TContactField.FirstNamePhonetic:
      SetPropertyValue(kABPersonFirstNamePhoneticProperty, AValue);
    TContactField.LastNamePhonetic:
      SetPropertyValue(kABPersonLastNamePhoneticProperty, AValue);
    TContactField.MiddleNamePhonetic:
      SetPropertyValue(kABPersonMiddleNamePhoneticProperty, AValue);
    TContactField.Organization:
      SetPropertyValue(kABPersonOrganizationProperty, AValue);
    TContactField.JobTitle:
      SetPropertyValue(kABPersonJobTitleProperty, AValue);
    TContactField.Department:
      SetPropertyValue(kABPersonDepartmentProperty, AValue);
    TContactField.Note:
      SetPropertyValue(kABPersonNoteProperty, AValue);
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
  end;
end;

procedure TiOSAddressBookContact.SetURLs(const AIndex: TContactField; const AValue: TContactURLs);
begin
  if AIndex = TContactField.URLs then
    SetPropertyValue(AValue)
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

function TiOSAddressBookContact.GetStringPropertyValue(const AProperty: ABPropertyID): string;
var
  Value: CFTypeRef;
begin
  Result := string.Empty;
  Value := ABRecordCopyValue(FPersonRef, AProperty);
  if Value <> nil then
    try
      Result := CFStringRefToStr(Value);
    finally
      CFRelease(Value);
    end;
end;

procedure TiOSAddressBookContact.SetPropertyValue(const AProperty: ABPropertyID; const AValue: string);
var
  Error: CFErrorRef;
  StringRef: CFStringRef;
begin
  Error := nil;
  StringRef := StringToID(AValue);
  if not ABRecordSetValue(PersonRef, AProperty, StringRef, Error) then
    raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, ['StringValue', CFErrorRefToDescription(Error)]);
end;

function TiOSAddressBookContact.GetDateTimeValue(const AIndex: TContactField): TDateTime;
begin
  case AIndex of
    TContactField.Birthday:
      Result := GetDatePropertyValue(kABPersonBirthdayProperty);
    TContactField.CreationDate:
      Result := GetDateTimePropertyValue(kABPersonCreationDateProperty);
    TContactField.ModificationDate:
      Result := GetDateTimePropertyValue(kABPersonModificationDateProperty);
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
  end;
end;

function TiOSAddressBookContact.GetDisplayName: string;
var
  LFirstName: string;
  LLastName: string;
begin
  LFirstName := FirstName.Trim;
  LLastName := LastName.Trim;
  if not LFirstName.IsEmpty and not LLastName.IsEmpty then
    Result := Format('%s %s', [FirstName, LastName])
  else if not LFirstName.IsEmpty then
    Result := LFirstName
  else if not LLastName.IsEmpty then
    Result := LLastName
  else
    Result := Organization;
end;

function TiOSAddressBookContact.GetEmails(const AIndex: TContactField): TContactEmails;
var
  MultiValue: ABMutableMultiValueRef;
  ValuesCount: Integer;
  LabelRef: CFStringRef;
  ValueRef: CFStringRef;
  I: Integer;
  EmailKind: TContactEmail.TLabelKind;
  Email: string;
  EmailLabel: string;
begin
  if AIndex = TContactField.EMails then
  begin
    Result := TContactEmails.Create;
    MultiValue := ABRecordCopyValue(FPersonRef, kABPersonEmailProperty);
    if MultiValue <> nil then
      try
        ValuesCount := ABMultiValueGetCount(MultiValue);
        for I := 0 to ValuesCount - 1 do
        begin
          LabelRef := ABMultiValueCopyLabelAtIndex(MultiValue, I);
          ValueRef := ABMultiValueCopyValueAtIndex(MultiValue, I);
          try
            Email := CFStringRefToStr(ValueRef);
            EmailKind := TiOSAddressBookHelpers.LabelToEmailKind(LabelRef);
            if LabelRef <> nil then
              EmailLabel := CFStringRefToStr(ABAddressBookCopyLocalizedLabel(LabelRef))
            else
              EmailLabel := string.Empty;

            if EmailKind = TContactEmail.TLabelKind.Custom then
              Result.AddEmail(EmailLabel, Email)
            else
              Result.AddEmail(EmailKind, Email);
          finally
            if LabelRef <> nil then
              CFRelease(LabelRef);
            CFRelease(ValueRef);
          end;
        end;
      finally
        CFRelease(MultiValue);
      end;
  end
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

function TiOSAddressBookContact.GetID: Int32;
begin
  Result := ABRecordGetRecordID(PersonRef);
end;

function TiOSAddressBookContact.GetMessagingServices(const AIndex: TContactField): TContactMessagingServices;
var
  ProfilesRef: CFTypeRef;
  ProfileRef: CFTypeRef;
  LabelRef: CFTypeRef;
  Profile: TContactMessagingService;
  ProfilesCount: Integer;
  I: Integer;
  ServiceLabel: string;
  ServiceKind: TContactMessagingService.TLabelKind;
  ProtocolKind: TContactMessagingService.TServiceKind;
  ServiceName: string;
begin
  if AIndex = TContactField.MessagingServices then
  begin
    Result := TContactMessagingServices.Create;
    ProfilesRef := ABRecordCopyValue(FPersonRef, kABPersonInstantMessageProperty);
    if ProfilesRef <> nil then
      try
        ProfilesCount := ABMultiValueGetCount(ProfilesRef);
        for I := 0 to ProfilesCount - 1 do
        begin
          ProfileRef := ABMultiValueCopyValueAtIndex(ProfilesRef, I);
          LabelRef := ABMultiValueCopyLabelAtIndex(ProfilesRef, I);
          try
            Profile := TContactMessagingService.Create;

            ServiceKind := TiOSAddressBookHelpers.LabelToMessagingServiceLabelKind(LabelRef);
            if LabelRef <> nil then
              ServiceLabel := CFStringRefToStr(ABAddressBookCopyLocalizedLabel(LabelRef))
            else
              ServiceLabel := string.Empty;

            if ServiceKind = TContactMessagingService.TLabelKind.Custom then
              Profile.LabelText := ServiceLabel
            else
              Profile.LabelKind := ServiceKind;

            ServiceName := ExtractString(ProfileRef, kABPersonInstantMessageServiceKey);
            ProtocolKind := TiOSAddressBookHelpers.LabelToMessagingServiceKind(ServiceName);
            if ProtocolKind = TContactMessagingService.TServiceKind.Custom then
              Profile.ServiceName := ServiceName
            else
              Profile.ServiceKind := ProtocolKind;
            Profile.UserName := ExtractString(ProfileRef, kABPersonInstantMessageUsernameKey);

            Result.Add(Profile);
          finally
            if LabelRef <> nil then
              CFRelease(LabelRef);
            CFRelease(ProfileRef);
          end;
        end;
      finally
        CFRelease(ProfilesRef);
      end;
  end
  else
    EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

function TiOSAddressBookContact.GetDates(const AIndex: TContactField): TContactDates;
var
  MultiValue: ABMutableMultiValueRef;
  ValuesCount: Integer;
  LabelRef: CFStringRef;
  ValueRef: CFStringRef;
  I: Integer;
  DateEvent: TDate;
  DateKind: TContactDate.TLabelKind;
  DateLabel: string;
begin
  if AIndex = TContactField.Dates then
  begin
    Result := TContactDates.Create;
    MultiValue := ABRecordCopyValue(FPersonRef, kABPersonDateProperty);
    if MultiValue <> nil then
      try
        ValuesCount := ABMultiValueGetCount(MultiValue);
        for I := 0 to ValuesCount - 1 do
        begin
          LabelRef := ABMultiValueCopyLabelAtIndex(MultiValue, I);
          ValueRef := ABMultiValueCopyValueAtIndex(MultiValue, I);
          try
            DateKind := TiOSAddressBookHelpers.LabelToDateKind(LabelRef);
            DateEvent := NSDateToDate(TNSDate.Wrap(ValueRef));
            if LabelRef <> nil then
              DateLabel := CFStringRefToStr(ABAddressBookCopyLocalizedLabel(LabelRef))
            else
              DateLabel := string.Empty;

            if DateKind = TContactDate.TLabelKind.Custom then
              Result.AddDate(DateLabel, DateEvent)
            else
              Result.AddDate(DateKind, DateEvent);
          finally
            if LabelRef <> nil then
              CFRelease(LabelRef);
            CFRelease(ValueRef);
          end;
        end;
      finally
        CFRelease(MultiValue);
      end;
  end
  else
    EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

procedure TiOSAddressBookContact.SetPhones(const AIndex: TContactField; const AValue: TContactPhones);
begin
  if AIndex = TContactField.Phones then
    SetPropertyValue(AValue)
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

procedure TiOSAddressBookContact.SetPropertyValue(const AValue: TContactEmails);
var
  MultiValue: ABMutableMultiValueRef;
  I: Integer;
  Value: TContactEmail;
  Error: CFErrorRef;
  EmailLabel: CFStringRef;
begin
  MultiValue := ABMultiValueCreateMutable(kABMultiStringPropertyType);
  try
    for I := 0 to AValue.Count - 1 do
    begin
      Value := AValue.Items[I];
      EmailLabel := TiOSAddressBookHelpers.EmailKindToLabel(Value);

      if not ABMultiValueAddValueAndLabel(MultiValue, StringToID(Value.Email), EmailLabel, 0) then
        raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, ['EmailsProperty']);
    end;

    Error := nil;
    if not ABRecordSetValue(PersonRef, kABPersonEmailProperty, MultiValue, Error) then
      raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, ['EmailsProperty', CFErrorRefToDescription(Error)]);
  finally
    CFRelease(MultiValue)
  end;
end;

procedure TiOSAddressBookContact.SetPropertyValue(const AValue: TContactRelatedNames);
var
  MultiValue: ABMutableMultiValueRef;
  I: Integer;
  Value: TContactRelatedName;
  Error: CFErrorRef;
  RelationLabel: CFStringRef;
begin
  MultiValue := ABMultiValueCreateMutable(kABMultiStringPropertyType);
  try
    for I := 0 to AValue.Count - 1 do
    begin
      Value := AValue.Items[I];
      RelationLabel := TiOSAddressBookHelpers.RelationshipKindToLabel(Value);

      if not ABMultiValueAddValueAndLabel(MultiValue, StringToID(Value.Name), RelationLabel, 0) then
        raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, ['EmailsProperty']);
    end;

    Error := nil;
    if not ABRecordSetValue(PersonRef, kABPersonRelatedNamesProperty, MultiValue, Error) then
      raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, ['EmailsProperty', CFErrorRefToDescription(Error)]);
  finally
    CFRelease(MultiValue)
  end;
end;

procedure TiOSAddressBookContact.SetPropertyValue(const AValue: TContactURLs);
var
  MultiValue: ABMutableMultiValueRef;
  I: Integer;
  Value: TContactURL;
  Error: CFErrorRef;
  URLLabel: CFStringRef;
begin
  MultiValue := ABMultiValueCreateMutable(kABMultiStringPropertyType);
  try
    for I := 0 to AValue.Count - 1 do
    begin
      Value := AValue.Items[I];
      URLLabel := TiOSAddressBookHelpers.URLKindToLabel(Value);

      if not ABMultiValueAddValueAndLabel(MultiValue, StringToID(Value.URL), URLLabel, 0) then
        raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, ['URLProperty']);
    end;

    Error := nil;
    if not ABRecordSetValue(PersonRef, kABPersonURLProperty, MultiValue, Error) then
      raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, ['URLProperty', CFErrorRefToDescription(Error)]);
  finally
    CFRelease(MultiValue)
  end;
end;

procedure TiOSAddressBookContact.SetPropertyValue(const AProperty: ABPropertyID; const AValue: TDateTime);
var
  Error: CFErrorRef;
  OCDate: NSDate;
begin
  Error := nil;
  OCDate := DateTimeToNSDate(AValue);
  if not ABRecordSetValue(PersonRef, AProperty, NSObjectToID(OCDate), Error) then
    raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, ['DateValue', CFErrorRefToDescription(Error)]);
end;

procedure TiOSAddressBookContact.SetRelatedNames(const AIndex: TContactField; const AValue: TContactRelatedNames);
begin
  if AIndex = TContactField.RelatedNames then
    SetPropertyValue(AValue)
  else
    raise EAddressBookWrongArgs.CreateFmt(SFieldTypeIsNotSupportedOnCurrentPlatform, [AIndex.ToString]);
end;

procedure TiOSAddressBookContact.SetPropertyValue(const AValue: TContactMessagingServices);

  procedure AddService(const AServices: ABMutableMultiValueRef; const AService: TContactMessagingService);
  var
    ServiceDictionary: NSMutableDictionary;
    ServiceLabel: CFStringRef;
    ProtocolLabel: CFStringRef;
  begin
    ProtocolLabel := TiOSAddressBookHelpers.MessagingServiceKindToLabel(AService);
    ServiceDictionary := TNSMutableDictionary.Create;
    ServiceDictionary.setValue(ProtocolLabel, kABPersonInstantMessageServiceKey);
    ServiceDictionary.setValue(StringToID(AService.UserName), kABPersonInstantMessageUsernameKey);
    ServiceLabel := TiOSAddressBookHelpers.MessagingServiceLabelKindToLabel(AService);

    if not ABMultiValueAddValueAndLabel(AServices, NSObjectToID(ServiceDictionary), ServiceLabel, 0) then
      raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, [TContactField.MessagingServices.ToString]);
  end;

var
  Error: CFErrorRef;
  I: Integer;
  ServicesRef: ABMutableMultiValueRef;
begin
  ServicesRef := ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
  try
    for I := 0 to AValue.Count - 1 do
      AddService(ServicesRef, AValue[I]);

    Error := nil;
    if not ABRecordSetValue(PersonRef, kABPersonInstantMessageProperty, ServicesRef, Error) then
      raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, [TContactField.MessagingServices.ToString,
        CFErrorRefToDescription(Error)]);
  finally
    CFRelease(ServicesRef);
  end;
end;

procedure TiOSAddressBookContact.SetPropertyValue(const AValue: TContactSocialProfiles);

  procedure AddProfile(const AProfiles: ABMutableMultiValueRef; const AProfile: TContactSocialProfile);
  var
    ProfileDictionary: NSMutableDictionary;
    LabelRef: CFStringRef;
    ServiceLabelRef: CFStringRef;
  begin
    ProfileDictionary := TNSMutableDictionary.Create;
    ServiceLabelRef := TiOSAddressBookHelpers.SocialProfileServiceKindToLabel(AProfile);
    ProfileDictionary.setValue(ServiceLabelRef, kABPersonSocialProfileServiceKey);
    ProfileDictionary.setValue(StringToID(AProfile.URL), kABPersonSocialProfileURLKey);
    ProfileDictionary.setValue(StringToID(AProfile.UserName), kABPersonSocialProfileUsernameKey);
    ProfileDictionary.setValue(StringToID(AProfile.UserIdentifier), kABPersonSocialProfileUserIdentifierKey);
    LabelRef := TiOSAddressBookHelpers.SocialProfileKindToLabel(AProfile);

    if not ABMultiValueAddValueAndLabel(AProfiles, NSObjectToID(ProfileDictionary), LabelRef, 0) then
      raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, [TContactField.SocialProfiles.ToString]);
  end;

var
  Error: CFErrorRef;
  I: Integer;
  ProfileRef: ABMutableMultiValueRef;
begin
  ProfileRef := ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
  try
    for I := 0 to AValue.Count - 1 do
      AddProfile(ProfileRef, AValue[I]);

    Error := nil;
    if not ABRecordSetValue(PersonRef, kABPersonSocialProfileProperty, ProfileRef, Error) then
      raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, [TContactField.SocialProfiles.ToString,
        CFErrorRefToDescription(Error)]);
  finally
    CFRelease(ProfileRef);
  end;
end;

procedure TiOSAddressBookContact.SetPropertyValue(const AValue: TContactPhones);
var
  MultiValue: ABMutableMultiValueRef;
  I: Integer;
  Value: TContactPhone;
  Error: CFErrorRef;
  PhoneLabel: CFStringRef;
begin
  MultiValue := ABMultiValueCreateMutable(kABMultiStringPropertyType);
  try
    for I := 0 to AValue.Count - 1 do
    begin
      Value := AValue.Items[I];
      PhoneLabel := TiOSAddressBookHelpers.PhoneKindToLabel(Value);

      if not ABMultiValueAddValueAndLabel(MultiValue, StringToID(Value.Number), PhoneLabel, 0) then
        raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, ['PhonesProperty']);
    end;

    Error := nil;
    if not ABRecordSetValue(PersonRef, kABPersonPhoneProperty, MultiValue, Error) then
      raise EAddressBookExecute.CreateFmt(SCannotSaveFieldValue, ['PhonesProperty', CFErrorRefToDescription(Error)]);
  finally
    CFRelease(MultiValue)
  end;
end;

{ TiOSAddressBook }

class procedure TiOSAddressBook.AddressBookExternalChange(addressBook: ABAddressBookRef; info: CFDictionaryRef;
  context: Pointer);
begin
  // We passed AddressBook instance as context in ABAddressBookRegisterExternalChangeCallback
  if (Context <> nil) and (TObject(Context) is TiOSAddressBook) then
    TiOSAddressBook(Context).DoExternalChange;
end;

procedure TiOSAddressBook.AddressBookRequestAccessCompletionHandler(granted: Boolean; error: CFErrorRef);
var
  Message: string;
begin
  if error <> nil then
    Message := CFErrorRefToDescription(error)
  else
    Message := '';
  DoPermissionRequest(Message, granted);
end;

function TiOSAddressBook.ContactByID(const AID: Int32): TAddressBookContact;
var
  PersonRef: Pointer;
begin
  PersonRef := ABAddressBookGetPersonWithRecordID(AddressBookRef, AID);
  if PersonRef <> nil then
    Result := TiOSAddressBookContact.CreateFromExisting(Self, PersonRef)
  else
    Result := nil;
end;

constructor TiOSAddressBook.Create;
begin
  inherited;
  FAddressBookRef := ABAddressBookCreateWithOptions(nil, nil);
  ABAddressBookRegisterExternalChangeCallback(AddressBookRef, AddressBookExternalChange, Self);
end;

function TiOSAddressBook.DefaultSource: TAddressBookSource;
var
  SourceRef: ABRecordRef;
begin
  SourceRef := ABAddressBookCopyDefaultSource(AddressBookRef);
  if SourceRef <> nil then
    Result := TiOSAddressBookSource.Create(Self, SourceRef)
  else
    Result := nil;
end;

destructor TiOSAddressBook.Destroy;
begin
  ABAddressBookUnregisterExternalChangeCallback(AddressBookRef, AddressBookExternalChange, nil);
  CFRelease(FAddressBookRef);
  inherited;
end;

procedure TiOSAddressBook.AddContactIntoGroup(const AGroup: TAddressBookGroup; const AContact: TAddressBookContact);
var
  Error: CFErrorRef;
begin
  if not (AGroup is TiOSAddressBookGroup) then
    raise EAddressBookWrongArgs.CreateFmt(SCannotAddContactIntoGroupWrongClassArg, ['AGroup', 'TiOSAddressBookGroup']);

  if not (AContact is TiOSAddressBookContact) then
    raise EAddressBookWrongArgs.CreateFmt(SCannotAddContactIntoGroupWrongClassArg , ['AContact', 'TiOSAddressBookContact']);

  Error := nil;
  if not ABGroupAddMember(TiOSAddressBookGroup(AGroup).GroupRef, TiOSAddressBookContact(AContact).PersonRef, Error) then
    raise EAddressBookExecute.CreateFmt(SCannotAddContactIntoGroup, [CFErrorRefToDescription(Error)]);

  Error := nil;
  if ABAddressBookHasUnsavedChanges(AddressBookRef) and not ABAddressBookSave(AddressBookRef, Error) then
    raise EAddressBookExecute.CreateFmt(SCannotAddContactIntoGroup, [CFErrorRefToDescription(Error)]);
end;

function TiOSAddressBook.AuthorizationStatus(const AAccessType: TAddressBookAccessType): TAuthorizationStatus;
var
  Status: ABAuthorizationStatus;
begin
  Status := ABAddressBookGetAuthorizationStatus;
  case Status of
    kABAuthorizationStatusNotDetermined:
      Result := TAuthorizationStatus.NotDetermined;
    kABAuthorizationStatusRestricted:
      Result := TAuthorizationStatus.Restricted;
    kABAuthorizationStatusDenied:
      Result := TAuthorizationStatus.Denied;
    kABAuthorizationStatusAuthorized:
      Result := TAuthorizationStatus.Authorized;
  else
    Result := TAuthorizationStatus.NotDetermined;
  end;
end;

function TiOSAddressBook.CreateContact(const ASource: TAddressBookSource = nil): TAddressBookContact;
begin
  Result := TiOSAddressBookContact.CreateNew(Self, ASource);
end;

function TiOSAddressBook.CreateGroup(const ASource: TAddressBookSource = nil): TAddressBookGroup;
begin
  Result := TiOSAddressBookGroup.CreateNew(Self, ASource);
end;

procedure TiOSAddressBook.DoExternalChange;
begin
  if Assigned(FOnExternalChange) then
    FOnExternalChange(Self);
end;

procedure TiOSAddressBook.AllContacts(const ASource: TAddressBookSource; var AContacts: TAddressBookContacts);
var
  LAllPeople: CFArrayRef;
  PeopleCount: Integer;
  I: Integer;
  Person: TiOSAddressBookContact;
begin
  if (ASource <> nil) and not (ASource is TiOSAddressBookSource) then
    raise EAddressBookWrongArgs.CreateFmt(SCannotFetchAllContactsWrongClassArg, ['ASource', 'TiOSAddressBookSource'])
  else if AContacts = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotFetchAllContactNilArg, ['AContacts']);

  if ASource <> nil then
    LAllPeople := ABAddressBookCopyArrayOfAllPeopleInSource(AddressBookRef, TiOSAddressBookSource(ASource).SourceRef)
  else
    LAllPeople := ABAddressBookCopyArrayOfAllPeople(AddressBookRef);
  try
    PeopleCount := CFArrayGetCount(LAllPeople);
    if PeopleCount > 0 then
    begin
      AContacts.Capacity := PeopleCount;
      for I := 0 to PeopleCount - 1 do
      begin
        Person := TiOSAddressBookContact.CreateFromExisting(Self, CFArrayGetValueAtIndex(LAllPeople, I));
        AContacts.Add(Person);
      end;
    end;
  finally
    CFRelease(LAllPeople);
  end;
end;

procedure TiOSAddressBook.AllContactsInGroups(const AGroups: TAddressBookGroups; var AContacts: TAddressBookContacts);
var
  AllPeople: CFArrayRef;
  I, J: Integer;
  Person: TiOSAddressBookContact;
  Group: TiOSAddressBookGroup;
begin
  if AGroups = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotFetchContactsInGroupNilArg, ['AGroups'])
  else if AContacts = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotFetchContactsInGroupNilArg, ['AContacts']);

  for I := 0 to AGroups.Count - 1 do
    if AGroups[I] is TiOSAddressBookGroup then
    begin
      Group := TiOSAddressBookGroup(AGroups[I]);
      AllPeople := ABGroupCopyArrayOfAllMembers(Group.GroupRef);
      // If group doesn't have contacts, AllPeople will be nil
      if AllPeople <> nil then
        try
          for J := 0 to CFArrayGetCount(AllPeople) - 1 do
          begin
            Person := TiOSAddressBookContact.CreateFromExisting(Self, CFArrayGetValueAtIndex(AllPeople, J));
            AContacts.Add(Person);
          end;
        finally
          CFRelease(AllPeople);
        end;
    end;
end;

procedure TiOSAddressBook.AllGroups(const ASource: TAddressBookSource; var AGroups: TAddressBookGroups);
var
  GroupCount: CFIndex;
  LAllGroups: CFArrayRef;
  I: Integer;
  Group: TiOSAddressBookGroup;
begin
  if (ASource <> nil) and not (ASource is TiOSAddressBookSource) then
    raise EAddressBookWrongArgs.CreateFmt(SCannotFetchAllGroupsWrongClassArg, ['ASource', 'TiOSAddressBookSource'])
  else if AGroups = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotFetchAllGroupsNilArg, ['AGroups']);

  if ASource = nil then
    LAllGroups := ABAddressBookCopyArrayOfAllGroups(AddressBookRef)
  else
    LAllGroups := ABAddressBookCopyArrayOfAllGroupsInSource(AddressBookRef, TiOSAddressBookSource(ASource).SourceRef);
  if LAllGroups <> nil then
    try
      GroupCount := CFArrayGetCount(LAllGroups);
      if GroupCount > 0 then
      begin
        AGroups.Capacity := GroupCount;
        for I := 0 to GroupCount - 1 do
        begin
          Group := TiOSAddressBookGroup.CreateExisted(Self, CFArrayGetValueAtIndex(LAllGroups, I));
          AGroups.Add(Group);
        end;
      end;
    finally
      CFRelease(LAllGroups);
    end;
end;

procedure TiOSAddressBook.AllSources(var ASources: TAddressBookSources);
var
  LAllSources: CFArrayRef;
  SourcesCount: Integer;
  I: Integer;
  Source: TiOSAddressBookSource;
begin
  if ASources = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotFetchAllSourcesNilArg, ['ASources']);

 LAllSources := ABAddressBookCopyArrayOfAllSources(AddressBookRef);
  if LAllSources <> nil then
    try
      SourcesCount := CFArrayGetCount(LAllSources);
      if SourcesCount > 0 then
      begin
        ASources.Capacity := SourcesCount;
        for I := 0 to SourcesCount - 1 do
        begin
          Source := TiOSAddressBookSource.Create(Self, CFArrayGetValueAtIndex(LAllSources, I));
          ASources.Add(Source);
        end;
      end;
    finally
      CFRelease(LAllSources);
    end;
end;

procedure TiOSAddressBook.DoPermissionRequest(const AMessage: string; const AAccessGranted: Boolean);
begin
  TThread.Queue(nil, procedure begin
    if Assigned(FOnPermissionRequest) then
      FOnPermissionRequest(Self, AMessage, AAccessGranted);
  end);
end;

function TiOSAddressBook.GetOnExternalChange: TExternalChangeEvent;
begin
  Result := FOnExternalChange;
end;

function TiOSAddressBook.GetOnPermissionRequest: TPermissionRequestEvent;
begin
  Result := FOnPermissionRequest;
end;

function TiOSAddressBook.GroupByID(const AID: Int32): TAddressBookGroup;
var
  GroupRef: Pointer;
begin
  GroupRef := ABAddressBookGetGroupWithRecordID(AddressBookRef, AID);
  if GroupRef <> nil then
    Result := TiOSAddressBookGroup.CreateExisted(Self, GroupRef)
  else
    Result := nil;
end;

procedure TiOSAddressBook.RemoveContact(const AContact: TAddressBookContact);
var
  Error: CFErrorRef;
begin
  if not (AContact is TiOSAddressBookContact) then
    raise EAddressBookWrongArgs.CreateFmt(SCannotRemoveContactWrongClassArg, ['AContact', 'TiOSAddressBookContact']);

  Error := nil;
  if not ABAddressBookRemoveRecord(AddressBookRef, TiOSAddressBookContact(AContact).PersonRef, Error) then
    raise EAddressBookExecute.CreateFmt(SCannotRemoveContact, [CFErrorRefToDescription(Error)]);

  Error := nil;
  if ABAddressBookHasUnsavedChanges(AddressBookRef) and not ABAddressBookSave(AddressBookRef, Error) then
      raise EAddressBookExecute.CreateFmt(SCannotRemoveContact, [CFErrorRefToDescription(Error)]);
end;

procedure TiOSAddressBook.RemoveContact(const AID: Integer);
var
  Contact: TAddressBookContact;
begin
  Contact := ContactByID(AID);
  if Contact <> nil then
    RemoveContact(Contact);
end;

procedure TiOSAddressBook.RemoveContactFromGroup(const AGroup: TAddressBookGroup; const AContact: TAddressBookContact);
var
  Error: CFErrorRef;
begin
  if not (AGroup is TiOSAddressBookGroup) then
    raise EAddressBookWrongArgs.CreateFmt(SCannotRemoveContactFromGroupWrongClassArg, ['AGroup', 'TiOSAddressBookGroup']);

  if not (AContact is TiOSAddressBookContact) then
    raise EAddressBookWrongArgs.CreateFmt(SCannotRemoveContactFromGroupWrongClassArg, ['AContact', 'TiOSAddressBookContact']);

  Error := nil;
  if not ABGroupRemoveMember(TiOSAddressBookGroup(AGroup).GroupRef, TiOSAddressBookContact(AContact).PersonRef, Error) then
    raise EAddressBookExecute.CreateFmt(SCannotRemoveContactFromGroup, [CFErrorRefToDescription(Error)]);

  Error := nil;
  if ABAddressBookHasUnsavedChanges(AddressBookRef) and not ABAddressBookSave(AddressBookRef, Error) then
    raise EAddressBookExecute.CreateFmt(SCannotRemoveContactFromGroup, [CFErrorRefToDescription(Error)]);
end;

procedure TiOSAddressBook.RemoveGroup(const AID: Integer);
var
  Group: TAddressBookGroup;
begin
  Group := GroupByID(AID);
  if Group <> nil then
    RemoveGroup(Group);
end;

procedure TiOSAddressBook.RemoveGroup(const AGroup: TAddressBookGroup);
var
  Error: CFErrorRef;
begin
  if not (AGroup is TiOSAddressBookGroup) then
    raise EAddressBookWrongArgs.CreateFmt(SCannotRemoveGroupWrongClassArg, ['AGroup', 'TiOSAddressBookGroup']);

  Error := nil;
  if not ABAddressBookRemoveRecord(AddressBookRef, TiOSAddressBookGroup(AGroup).GroupRef, Error) then
    raise EAddressBookWrongArgs.CreateFmt(SCannotRemoveGroupWrongClassArg, [CFErrorRefToDescription(Error)]);

  Error := nil;
  if ABAddressBookHasUnsavedChanges(AddressBookRef) and not ABAddressBookSave(AddressBookRef, Error) then
    raise EAddressBookExecute.CreateFmt(SCannotRemoveGroup, [CFErrorRefToDescription(Error)]);
end;

procedure TiOSAddressBook.RequestPermission;
var
  LTypeInfo: Pointer;
  LMethod: TMethod;
  AccessGranted: Boolean;
  LMessage: string;
begin
  inherited;
  // iOS doesn't invoke AddressBookRequestAccessCompletionHandler, so we need to notify user about results
  if ABAddressBookGetAuthorizationStatus = kABAuthorizationStatusNotDetermined then
  begin
    LTypeInfo := TypeInfo(ABAddressBookRequestAccessCompletionHandler);
    LMethod.Data := Self;
    LMethod.Code := @TiOSAddressBook.AddressBookRequestAccessCompletionHandler;
    ABAddressBookRequestAccessWithCompletion(FAddressBookRef, TObjCBlocks.SetEvent(LMethod, LTypeInfo))
  end
  else
  begin
    AccessGranted := ABAddressBookGetAuthorizationStatus = kABAuthorizationStatusAuthorized;
    // User already made permission request and we just notify user about it
    if AccessGranted then
      LMessage := string.Empty
    else
      LMessage := SUserRejectedAddressBookPermission;
    DoPermissionRequest(LMessage, AccessGranted);
  end;
end;

procedure TiOSAddressBook.RevertCurrentChangesAndUpdate;
begin
  ABAddressBookRevert(AddressBookRef);
end;

procedure TiOSAddressBook.SaveContact(const AContact: TAddressBookContact);
var
  Error: CFErrorRef;
begin
  if not (AContact is TiOSAddressBookContact) then
    raise EAddressBookWrongArgs.CreateFmt(SCannotSaveContactWrongClassArg, ['AContact', 'TiOSAddressBookContact']);

  Error := nil;
  if not ABAddressBookAddRecord(AddressBookRef, TiOSAddressBookContact(AContact).PersonRef, Error) then
    raise EAddressBookExecute.CreateFmt(SCannotSaveContact, [CFErrorRefToDescription(Error)]);

  Error := nil;
  if ABAddressBookHasUnsavedChanges(AddressBookRef) then
    if not ABAddressBookSave(AddressBookRef, Error) then
      raise EAddressBookExecute.CreateFmt(SCannotSaveContact, [CFErrorRefToDescription(Error)]);
end;

procedure TiOSAddressBook.SaveGroup(const AGroup: TAddressBookGroup);
var
  Error: CFErrorRef;
begin
  if not (AGroup is TiOSAddressBookGroup) then
    raise EAddressBookWrongArgs.CreateFmt(SCannotSaveGroupWrongClassArg, ['AGroup', 'TiOSAddressBookGroup']);

  Error := nil;
  if not ABAddressBookAddRecord(AddressBookRef, TiOSAddressBookGroup(AGroup).GroupRef, Error) then
    raise EAddressBookExecute.CreateFmt(SCannotSaveGroup, [CFErrorRefToDescription(Error)]);

  Error := nil;
  if ABAddressBookHasUnsavedChanges(AddressBookRef) then
    if not ABAddressBookSave(AddressBookRef, Error) then
      raise EAddressBookExecute.CreateFmt(SCannotSaveGroup, [CFErrorRefToDescription(Error)]);
end;

procedure TiOSAddressBook.SetOnExternalChange(const AHandler: TExternalChangeEvent);
begin
  FOnExternalChange := AHandler;
end;

procedure TiOSAddressBook.SetOnPermissionRequest(const AHandler: TPermissionRequestEvent);
begin
  FOnPermissionRequest := AHandler;
end;

function TiOSAddressBook.SourceByID(const AID: string): TAddressBookSource;
var
  SourceRef: ABRecordRef;
  SourceID: Integer;
begin
  Result := nil;
  if TryStrToInt(AID, SourceID) then
  begin
    SourceRef := ABAddressBookGetSourceWithRecordID(AddressBookRef, SourceID);
    if SourceRef <> nil then
      Result := TiOSAddressBookSource.Create(Self, SourceRef);
  end;
end;

{ TiOSAddressBookGroup }

function TiOSAddressBookGroup.GetName: string;
var
  ValueRef: CFStringRef;
begin
  Result := string.Empty;
  if GroupRef = nil then
    raise EAddressBookExecute.Create(SCannotGetGroupNameGroupRefNil);

  ValueRef := ABRecordCopyValue(GroupRef, kABGroupNameProperty);
  if ValueRef <> nil then
    try
      Result := CFStringRefToStr(ValueRef);
    finally
      CFRelease(ValueRef);
    end;
end;

function TiOSAddressBookGroup.GetSource: TAddressBookSource;
var
  SourceRef: ABRecordRef;
begin
  SourceRef := ABGroupCopySource(GroupRef);
  if SourceRef <> nil then
    Result := TiOSAddressBookSource.Create(FAddressBook, SourceRef)
  else
    Result := nil;
end;

procedure TiOSAddressBookGroup.SetName(const AValue: string);
var
  ErrorRef: CFErrorRef;
begin
  if GroupRef = nil then
    raise EAddressBookExecute.Create(SCannotSetGroupNameGroupRefNil);

  ErrorRef := nil;
  if not ABRecordSetValue(GroupRef, kABGroupNameProperty, StringToID(AValue), ErrorRef) then
    raise EAddressBookExecute.CreateFmt(SCannotSetGroupName, [CFErrorRefToDescription(ErrorRef)]);
end;

function TiOSAddressBookGroup.GetID: Integer;
begin
  Result := ABRecordGetRecordID(GroupRef);
end;

constructor TiOSAddressBookGroup.CreateNew(const AAddressBook: TiOSAddressBook; const ASource: TAddressBookSource = nil);
begin
  if AAddressBook = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotCreateGroupNilArg, ['AAddressBook']);
  if (ASource <> nil) and not (ASource is TiOSAddressBookSource) then
    raise EAddressBookWrongArgs.CreateFmt(SCannotCreateGroupWrongClassArg, ['ASource', 'TAddressBookSource']);

  FAddressBook := AAddressBook;
  if ASource = nil then
    FGroupRef := ABGroupCreate
  else
    FGroupRef := ABGroupCreateInSource(TiOSAddressBookSource(ASource).SourceRef);
end;

constructor TiOSAddressBookGroup.CreateExisted(const AAddressBook: TiOSAddressBook; const AGroupRef: ABRecordRef);
begin
  if AAddressBook  = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotCreateGroupNilArg, ['AAddressBook']);

  if AGroupRef = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotCreateGroupNilArg, ['AGroupRef']);

  CFRetain(AGroupRef);
  FAddressBook := AAddressBook;
  FGroupRef := AGroupRef;
end;

destructor TiOSAddressBookGroup.Destroy;
begin
  CFRelease(GroupRef);
  inherited;
end;

{ TiOSAddressBookServices }

function TiOSAddressBookServices.CreateAddressBook: IFMXAddressBookService;
begin
  Result := TiOSAddressBook.Create;
end;

function TiOSAddressBookServices.AddressesLabelKinds: TContactAddress.TLabelKinds;
begin
  Result := [TContactAddress.TLabelKind.Custom, TContactAddress.TLabelKind.Home, TContactAddress.TLabelKind.Work,
    TContactAddress.TLabelKind.Other];
end;

function TiOSAddressBookServices.DatesLabelKinds: TContactDate.TLabelKinds;
begin
  Result :=  [TContactDate.TLabelKind.Custom, TContactDate.TLabelKind.Anniversary];
end;

function TiOSAddressBookServices.EmailsLabelKinds: TContactEmail.TLabelKinds;
begin
  Result := [TContactEmail.TLabelKind.Custom, TContactEmail.TLabelKind.Home, TContactEmail.TLabelKind.Work,
    TContactEmail.TLabelKind.Other];
end;

function TiOSAddressBookServices.MessagingServicesLabelKinds: TContactMessagingService.TLabelKinds;
begin
  Result := [TContactMessagingService.TLabelKind.Custom, TContactMessagingService.TLabelKind.Home,
    TContactMessagingService.TLabelKind.Work, TContactMessagingService.TLabelKind.Other];
end;

function TiOSAddressBookServices.MessagingServicesKinds: TContactMessagingService.TServiceKinds;
begin
  Result := [TContactMessagingService.TServiceKind.Custom, TContactMessagingService.TServiceKind.Yahoo,
    TContactMessagingService.TServiceKind.Jabber, TContactMessagingService.TServiceKind.MSN,
    TContactMessagingService.TServiceKind.MSN, TContactMessagingService.TServiceKind.ICQ,
    TContactMessagingService.TServiceKind.ICQ, TContactMessagingService.TServiceKind.AIM,
    TContactMessagingService.TServiceKind.QQ, TContactMessagingService.TServiceKind.GoogleTalk,
    TContactMessagingService.TServiceKind.Skype, TContactMessagingService.TServiceKind.Facebook,
    TContactMessagingService.TServiceKind.GaduGadu];
end;

function TiOSAddressBookServices.PhonesLabelKinds: TContactPhone.TLabelKinds;
begin
  Result := [TContactPhone.TLabelKind.Custom, TContactPhone.TLabelKind.Home, TContactPhone.TLabelKind.Work,
    TContactPhone.TLabelKind.Other, TContactPhone.TLabelKind.Mobile, TContactPhone.TLabelKind.iPhone,
    TContactPhone.TLabelKind.Main, TContactPhone.TLabelKind.FaxHome, TContactPhone.TLabelKind.FaxWork,
    TContactPhone.TLabelKind.FaxOther, TContactPhone.TLabelKind.Pager];
end;

function TiOSAddressBookServices.RelatedNamesLabelKinds: TContactRelatedName.TLabelKinds;
begin
  Result := [TContactRelatedName.TLabelKind.Custom, TContactRelatedName.TLabelKind.Mother,
    TContactRelatedName.TLabelKind.Father, TContactRelatedName.TLabelKind.Parent, TContactRelatedName.TLabelKind.Sister,
    TContactRelatedName.TLabelKind.Brother, TContactRelatedName.TLabelKind.Child, TContactRelatedName.TLabelKind.Friend,
    TContactRelatedName.TLabelKind.Spouse, TContactRelatedName.TLabelKind.Partner, TContactRelatedName.TLabelKind.Manager,
    TContactRelatedName.TLabelKind.Assistant];
end;

function TiOSAddressBookServices.SocialProfilesLabelKinds: TContactSocialProfile.TLabelKinds;
begin
  Result := [TContactSocialProfile.TLabelKind.Custom, TContactSocialProfile.TLabelKind.Home,
    TContactSocialProfile.TLabelKind.Work, TContactSocialProfile.TLabelKind.Other];
end;

function TiOSAddressBookServices.SocialProfilesServiceKinds: TContactSocialProfile.TServiceKinds;
begin
  Result := [TContactSocialProfile.TServiceKind.Custom, TContactSocialProfile.TServiceKind.Twitter,
    TContactSocialProfile.TServiceKind.GameCenter, TContactSocialProfile.TServiceKind.SinaWeibo,
    TContactSocialProfile.TServiceKind.Facebook, TContactSocialProfile.TServiceKind.Myspace,
    TContactSocialProfile.TServiceKind.LinkedIn, TContactSocialProfile.TServiceKind.Flickr];
end;

function TiOSAddressBookServices.URLsLabelKinds: TContactURL.TLabelKinds;
begin
  Result := [TContactURL.TLabelKind.Custom, TContactURL.TLabelKind.HomePage, TContactURL.TLabelKind.Home,
     TContactURL.TLabelKind.Work, TContactURL.TLabelKind.Other];
end;

{ TiOSAddressBookTranslator }

class function TiOSAddressBookHelpers.PhoneKindToLabel(const APhone: TContactPhone): CFStringRef;
var
  PhoneLabel: NSString;
begin
  case APhone.LabelKind of
    TContactPhone.TLabelKind.Home:
      PhoneLabel := kABHomeLabel;
    TContactPhone.TLabelKind.Work:
      PhoneLabel := kABWorkLabel;
    TContactPhone.TLabelKind.Other:
      PhoneLabel := kABOtherLabel;
    TContactPhone.TLabelKind.Mobile:
      PhoneLabel := kABPersonPhoneMobileLabel;
    TContactPhone.TLabelKind.iPhone:
      PhoneLabel := kABPersonPhoneIPhoneLabel;
    TContactPhone.TLabelKind.FaxWork:
      PhoneLabel := kABPersonPhoneWorkFAXLabel;
    TContactPhone.TLabelKind.FaxHome:
      PhoneLabel := kABPersonPhoneHomeFAXLabel;
    TContactPhone.TLabelKind.FaxOther:
      PhoneLabel := kABPersonPhoneOtherFAXLabel;
    TContactPhone.TLabelKind.Pager:
      PhoneLabel := kABPersonPhonePagerLabel;
  else
    PhoneLabel := StrToNSStr(APhone.LabelText);
  end;
  Result := NSStringToID(PhoneLabel);
end;

class function TiOSAddressBookHelpers.AddressKindToLabel(const AAddress: TContactAddress): CFStringRef;
var
  AddressLabel: NSString;
begin
  case AAddress.LabelKind of
    TContactAddress.TLabelKind.Home:
      AddressLabel := kABHomeLabel;
    TContactAddress.TLabelKind.Work:
      AddressLabel := kABWorkLabel;
    TContactAddress.TLabelKind.Other:
      AddressLabel := kABOtherLabel;
  else
    AddressLabel := StrToNSStr(AAddress.LabelText);
  end;
  Result := NSStringToID(AddressLabel);
end;

class function TiOSAddressBookHelpers.DateKindToLabel(const ADate: TContactDate): CFStringRef;
begin
  if ADate.LabelKind = TContactDate.TLabelKind.Anniversary then
    Result := NSStringToID(kABPersonAnniversaryLabel)
  else
    Result := StringToID(ADate.LabelText);
end;

class function TiOSAddressBookHelpers.EmailKindToLabel(const AEmail: TContactEmail): CFStringRef;
var
  EmailLabel: NSString;
begin
  case AEmail.LabelKind of
    TContactEmail.TLabelKind.Home:
      EmailLabel := kABHomeLabel;
    TContactEmail.TLabelKind.Work:
      EmailLabel := kABWorkLabel;
    TContactEmail.TLabelKind.Other:
      EmailLabel := kABOtherLabel;
  else
    EmailLabel := StrToNSStr(AEmail.LabelText);
  end;
  Result := NSStringToID(EmailLabel);
end;

class function TiOSAddressBookHelpers.LabelToAddressKind(const AKind: CFStringRef): TContactAddress.TLabelKind;
var
  AddressLabel: string;
begin
  AddressLabel := CFStringRefToStr(AKind);
  if AddressLabel = NSStrToStr(kABHomeLabel) then
    Result := TContactAddress.TLabelKind.Home
  else if AddressLabel = NSStrToStr(kABWorkLabel) then
    Result := TContactAddress.TLabelKind.Work
  else if AddressLabel = NSStrToStr(kABOtherLabel) then
    Result := TContactAddress.TLabelKind.Other
  else
    Result := TContactAddress.TLabelKind.Custom;
end;

class function TiOSAddressBookHelpers.LabelToDateKind(const AKind: CFStringRef): TContactDate.TLabelKind;
begin
  if CFStringRefToStr(AKind) = NSStrToStr(kABPersonAnniversaryLabel) then
    Result := TContactDate.TLabelKind.Anniversary
  else
    Result := TContactDate.TLabelKind.Custom;
end;

class function TiOSAddressBookHelpers.LabelToEmailKind(const AKind: CFStringRef): TContactEmail.TLabelKind;
var
  EMailLabel: string;
begin
  EMailLabel := CFStringRefToStr(AKind);
  if EMailLabel = NSStrToStr(kABHomeLabel) then
    Result := TContactEmail.TLabelKind.Home
  else if EMailLabel = NSStrToStr(kABWorkLabel) then
    Result := TContactEmail.TLabelKind.Work
  else if EMailLabel = NSStrToStr(kABOtherLabel) then
    Result := TContactEmail.TLabelKind.Other
  else
    Result := TContactEmail.TLabelKind.Custom;
end;

class function TiOSAddressBookHelpers.LabelToMessagingServiceKind(const AKind: string): TContactMessagingService.TServiceKind;
begin
  if AKind = NSStrToStr(kABPersonInstantMessageServiceYahoo) then
    Result := TContactMessagingService.TServiceKind.Yahoo
  else if AKind = NSStrToStr(kABPersonInstantMessageServiceJabber) then
    Result := TContactMessagingService.TServiceKind.Jabber
  else if AKind = NSStrToStr(kABPersonInstantMessageServiceMSN) then
    Result := TContactMessagingService.TServiceKind.MSN
  else if AKind = NSStrToStr(kABPersonInstantMessageServiceICQ) then
    Result := TContactMessagingService.TServiceKind.ICQ
  else if AKind = NSStrToStr(kABPersonInstantMessageServiceAIM) then
    Result := TContactMessagingService.TServiceKind.AIM
  else if AKind = NSStrToStr(kABPersonInstantMessageServiceQQ) then
    Result := TContactMessagingService.TServiceKind.QQ
  else if AKind = NSStrToStr(kABPersonInstantMessageServiceGoogleTalk) then
    Result := TContactMessagingService.TServiceKind.GoogleTalk
  else if AKind = NSStrToStr(kABPersonInstantMessageServiceSkype) then
    Result := TContactMessagingService.TServiceKind.Skype
  else if AKind = NSStrToStr(kABPersonInstantMessageServiceFacebook) then
    Result := TContactMessagingService.TServiceKind.Facebook
  else if AKind = NSStrToStr(kABPersonInstantMessageServiceGaduGadu) then
    Result := TContactMessagingService.TServiceKind.GaduGadu
  else
    Result := TContactMessagingService.TServiceKind.Custom;
end;

class function TiOSAddressBookHelpers.LabelToMessagingServiceLabelKind(const AKind: CFStringRef): TContactMessagingService.TLabelKind;
var
  ServiceLabel: string;
begin
  ServiceLabel := CFStringRefToStr(AKind);
  if ServiceLabel = NSStrToStr(kABHomeLabel) then
    Result := TContactMessagingService.TLabelKind.Home
  else if ServiceLabel = NSStrToStr(kABWorkLabel) then
    Result := TContactMessagingService.TLabelKind.Work
  else if ServiceLabel = NSStrToStr(kABOtherLabel) then
    Result := TContactMessagingService.TLabelKind.Other
  else
    Result := TContactMessagingService.TLabelKind.Custom;
end;

class function TiOSAddressBookHelpers.LabelToPhoneKind(const AKind: CFStringRef): TContactPhone.TLabelKind;
var
  PhoneLabel: string;
begin
  PhoneLabel := CFStringRefToStr(AKind);
  if PhoneLabel = NSStrToStr(kABHomeLabel) then
    Result := TContactPhone.TLabelKind.Home
  else if PhoneLabel = NSStrToStr(kABWorkLabel) then
    Result := TContactPhone.TLabelKind.Work
  else if PhoneLabel = NSStrToStr(kABOtherLabel) then
    Result := TContactPhone.TLabelKind.Other
  else if PhoneLabel = NSStrToStr(kABPersonPhoneMobileLabel) then
    Result := TContactPhone.TLabelKind.Mobile
  else if PhoneLabel = NSStrToStr(kABPersonPhoneIPhoneLabel) then
    Result := TContactPhone.TLabelKind.iPhone
  else if PhoneLabel = NSStrToStr(kABPersonPhoneMainLabel) then
    Result := TContactPhone.TLabelKind.Main
  else if PhoneLabel = NSStrToStr(kABPersonPhoneHomeFAXLabel) then
    Result := TContactPhone.TLabelKind.FaxHome
  else if PhoneLabel = NSStrToStr(kABPersonPhoneWorkFAXLabel) then
    Result := TContactPhone.TLabelKind.FaxWork
  else if PhoneLabel = NSStrToStr(kABPersonPhoneOtherFAXLabel) then
    Result := TContactPhone.TLabelKind.FaxOther
  else if PhoneLabel = NSStrToStr(kABPersonPhonePagerLabel) then
    Result := TContactPhone.TLabelKind.Pager
  else
    Result := TContactPhone.TLabelKind.Custom;
end;

class function TiOSAddressBookHelpers.RelationShipKindToLabel(const ARelationship: TContactRelatedName): CFStringRef;
var
  RelationshipLabel: NSString;
begin
  case ARelationship.LabelKind of
    TContactRelatedName.TLabelKind.Mother:
      RelationshipLabel := kABPersonMotherLabel;
    TContactRelatedName.TLabelKind.Father:
      RelationshipLabel := kABPersonFatherLabel;
    TContactRelatedName.TLabelKind.Parent:
      RelationshipLabel := kABPersonParentLabel;
    TContactRelatedName.TLabelKind.Sister:
      RelationshipLabel := kABPersonSisterLabel;
    TContactRelatedName.TLabelKind.Brother:
      RelationshipLabel := kABPersonBrotherLabel;
    TContactRelatedName.TLabelKind.Child:
      RelationshipLabel := kABPersonChildLabel;
    TContactRelatedName.TLabelKind.Friend:
      RelationshipLabel := kABPersonFriendLabel;
    TContactRelatedName.TLabelKind.Spouse:
      RelationshipLabel := kABPersonSpouseLabel;
    TContactRelatedName.TLabelKind.Partner:
      RelationshipLabel := kABPersonPartnerLabel;
    TContactRelatedName.TLabelKind.Manager:
      RelationshipLabel := kABPersonManagerLabel;
    TContactRelatedName.TLabelKind.Assistant:
      RelationshipLabel := kABPersonAssistantLabel;
  else
    RelationshipLabel := StrToNSStr(ARelationship.LabelText);
  end;
  Result := NSStringToID(RelationshipLabel);
end;

class function TiOSAddressBookHelpers.SocialProfileKindToLabel(const AProfile: TContactSocialProfile): CFStringRef;
var
  ServiceLabel: NSString;
begin
  case AProfile.LabelKind of
    TContactSocialProfile.TLabelKind.Home:
      ServiceLabel := kABHomeLabel;
    TContactSocialProfile.TLabelKind.Work:
      ServiceLabel := kABWorkLabel;
    TContactSocialProfile.TLabelKind.Other:
      ServiceLabel := kABOtherLabel;
  else
    ServiceLabel := StrToNSStr(AProfile.ServiceName);
  end;
  Result := NSStringToID(ServiceLabel);
end;

class function TiOSAddressBookHelpers.SocialProfileServiceKindToLabel(const AProfile: TContactSocialProfile): CFStringRef;
var
  ServiceLabel: NSString;
begin
  case AProfile.ServiceKind of
    TContactSocialProfile.TServiceKind.Twitter:
      ServiceLabel := kABPersonSocialProfileServiceTwitter;
    TContactSocialProfile.TServiceKind.GameCenter:
      ServiceLabel := kABPersonSocialProfileServiceGameCenter;
    TContactSocialProfile.TServiceKind.SinaWeibo:
      ServiceLabel := kABPersonSocialProfileServiceSinaWeibo;
    TContactSocialProfile.TServiceKind.Facebook:
      ServiceLabel := kABPersonSocialProfileServiceFacebook;
    TContactSocialProfile.TServiceKind.Myspace:
      ServiceLabel := kABPersonSocialProfileServiceMyspace;
    TContactSocialProfile.TServiceKind.LinkedIn:
      ServiceLabel := kABPersonSocialProfileServiceLinkedIn;
    TContactSocialProfile.TServiceKind.Flickr:
      ServiceLabel := kABPersonSocialProfileServiceFlickr;
  else
    ServiceLabel := StrToNSStr(AProfile.ServiceName);
  end;
  Result := NSStringToID(ServiceLabel);
end;

class function TiOSAddressBookHelpers.LabelToRelationShipKind(const AKind: CFStringRef): TContactRelatedName.TLabelKind;
var
  RelationshipLabel: string;
begin
  RelationshipLabel := CFStringRefToStr(AKind);
  if RelationshipLabel = NSStrToStr(kABPersonMotherLabel) then
    Result := TContactRelatedName.TLabelKind.Mother
  else if RelationshipLabel = NSStrToStr(kABPersonFatherLabel) then
    Result := TContactRelatedName.TLabelKind.Father
  else if RelationshipLabel = NSStrToStr(kABPersonParentLabel) then
    Result := TContactRelatedName.TLabelKind.Parent
  else if RelationshipLabel = NSStrToStr(kABPersonSisterLabel) then
    Result := TContactRelatedName.TLabelKind.Sister
  else if RelationshipLabel = NSStrToStr(kABPersonBrotherLabel) then
    Result := TContactRelatedName.TLabelKind.Brother
  else if RelationshipLabel = NSStrToStr(kABPersonChildLabel) then
    Result := TContactRelatedName.TLabelKind.Child
  else if RelationshipLabel = NSStrToStr(kABPersonFriendLabel) then
    Result := TContactRelatedName.TLabelKind.Friend
  else if RelationshipLabel = NSStrToStr(kABPersonSpouseLabel) then
    Result := TContactRelatedName.TLabelKind.Spouse
  else if RelationshipLabel = NSStrToStr(kABPersonPartnerLabel) then
    Result := TContactRelatedName.TLabelKind.Partner
  else if RelationshipLabel = NSStrToStr(kABPersonManagerLabel) then
    Result := TContactRelatedName.TLabelKind.Manager
  else if RelationshipLabel = NSStrToStr(kABPersonAssistantLabel) then
    Result := TContactRelatedName.TLabelKind.Assistant
  else
    Result := TContactRelatedName.TLabelKind.Custom;
end;

class function TiOSAddressBookHelpers.LabelToSocialProfileKind(const AKind: CFStringRef): TContactSocialProfile.TLabelKind;
var
  ServiceLabel: string;
begin
  ServiceLabel := CFStringRefToStr(AKind);
  if ServiceLabel = NSStrToStr(kABHomeLabel) then
    Result := TContactSocialProfile.TLabelKind.Home
  else if ServiceLabel = NSStrToStr(kABWorkLabel) then
    Result := TContactSocialProfile.TLabelKind.Work
  else if ServiceLabel = NSStrToStr(kABOtherLabel) then
    Result := TContactSocialProfile.TLabelKind.Other
  else
    Result := TContactSocialProfile.TLabelKind.Custom;
end;

class function TiOSAddressBookHelpers.LabelToSocialProfileServiceKind(const AKind: string): TContactSocialProfile.TServiceKind;
begin
  if AKind = NSStrToStr(kABPersonSocialProfileServiceTwitter) then
    Result := TContactSocialProfile.TServiceKind.Twitter
  else if AKind = NSStrToStr(kABPersonSocialProfileServiceGameCenter) then
    Result := TContactSocialProfile.TServiceKind.GameCenter
  else if AKind = NSStrToStr(kABPersonSocialProfileServiceSinaWeibo) then
    Result := TContactSocialProfile.TServiceKind.SinaWeibo
  else if AKind = NSStrToStr(kABPersonSocialProfileServiceFacebook) then
    Result := TContactSocialProfile.TServiceKind.Facebook
  else if AKind = NSStrToStr(kABPersonSocialProfileServiceMyspace) then
    Result := TContactSocialProfile.TServiceKind.Myspace
  else if AKind = NSStrToStr(kABPersonSocialProfileServiceLinkedIn) then
    Result := TContactSocialProfile.TServiceKind.LinkedIn
  else if AKind = NSStrToStr(kABPersonSocialProfileServiceFlickr) then
    Result := TContactSocialProfile.TServiceKind.Flickr
  else
    Result := TContactSocialProfile.TServiceKind.Custom;
end;

class function TiOSAddressBookHelpers.URLKindToLabel(const AUrl: TContactURL): CFStringRef;
var
  URLLabel: NSString;
begin
  case AUrl.LabelKind of
    TContactURL.TLabelKind.HomePage:
      URLLabel := kABPersonHomePageLabel;
    TContactURL.TLabelKind.Home:
      URLLabel := kABHomeLabel;
    TContactURL.TLabelKind.Work:
      URLLabel := kABWorkLabel;
    TContactURL.TLabelKind.Other:
      URLLabel := kABOtherLabel;
  else
    URLLabel := StrToNSStr(AUrl.LabelText);
  end;
  Result := NSStringToID(URLLabel);
end;

class function TiOSAddressBookHelpers.LabelToURLKind(const AKind: CFStringRef): TContactURL.TLabelKind;
var
  URLLabel: string;
begin
  URLLabel := CFStringRefToStr(AKind);
  if URLLabel = NSStrToStr(kABPersonHomePageLabel) then
    Result := TContactURL.TLabelKind.HomePage
  else if URLLabel = NSStrToStr(kABHomeLabel) then
    Result := TContactURL.TLabelKind.Home
  else if URLLabel = NSStrToStr(kABWorkLabel) then
    Result := TContactURL.TLabelKind.Work
  else if URLLabel = NSStrToStr(kABOtherLabel) then
    Result := TContactURL.TLabelKind.Other
  else
    Result := TContactURL.TLabelKind.Custom;
end;

class function TiOSAddressBookHelpers.MessagingServiceKindToLabel(const AProfile: TContactMessagingService): CFStringRef;
var
  ProtocolLabel: NSString;
begin
  case AProfile.ServiceKind of
    TContactMessagingService.TServiceKind.Yahoo:
      ProtocolLabel := kABPersonInstantMessageServiceYahoo;
    TContactMessagingService.TServiceKind.Jabber:
      ProtocolLabel := kABPersonInstantMessageServiceJabber;
    TContactMessagingService.TServiceKind.MSN:
      ProtocolLabel := kABPersonInstantMessageServiceMSN;
    TContactMessagingService.TServiceKind.ICQ:
      ProtocolLabel := kABPersonInstantMessageServiceICQ;
    TContactMessagingService.TServiceKind.AIM:
      ProtocolLabel := kABPersonInstantMessageServiceAIM;
    TContactMessagingService.TServiceKind.QQ:
      ProtocolLabel := kABPersonInstantMessageServiceQQ;
    TContactMessagingService.TServiceKind.GoogleTalk:
      ProtocolLabel := kABPersonInstantMessageServiceGoogleTalk;
    TContactMessagingService.TServiceKind.Skype:
      ProtocolLabel := kABPersonInstantMessageServiceSkype;
    TContactMessagingService.TServiceKind.Facebook:
      ProtocolLabel := kABPersonInstantMessageServiceFacebook;
    TContactMessagingService.TServiceKind.GaduGadu:
      ProtocolLabel := kABPersonInstantMessageServiceGaduGadu;
  else
    ProtocolLabel := StrToNSStr(AProfile.ServiceName);
  end;
  Result := NSStringToID(ProtocolLabel);
end;

class function TiOSAddressBookHelpers.MessagingServiceLabelKindToLabel(const AProfile: TContactMessagingService): CFStringRef;
var
  ServiceLabel: NSString;
begin
  case AProfile.LabelKind of
    TContactMessagingService.TLabelKind.Home:
      ServiceLabel := kABHomeLabel;
    TContactMessagingService.TLabelKind.Work:
      ServiceLabel := kABWorkLabel;
    TContactMessagingService.TLabelKind.Other:
      ServiceLabel := kABOtherLabel;
  else
    ServiceLabel := StrToNSStr(AProfile.LabelText);
  end;
  Result := NSStringToID(ServiceLabel);
end;

{ TiOSAddressBookSource }

constructor TiOSAddressBookSource.Create(const AAddressBook: TiOSAddressBook; const ASourceRef: ABRecordRef);
begin
  if AAddressBook = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotCreateSourceNilArg, ['AAddressBook']);

  if ASourceRef = nil then
    raise EAddressBookWrongArgs.CreateFmt(SCannotCreateSourceNilArg, ['ASourceRef']);

  CFRetain(ASourceRef);
  FAddressBook := AAddressBook;
  FSourceRef := ASourceRef;
end;

destructor TiOSAddressBookSource.Destroy;
begin
  CFRelease(SourceRef);
  inherited;
end;

function TiOSAddressBookSource.GetID: string;
begin
  Result := ABRecordGetRecordID(SourceRef).ToString;
end;

function TiOSAddressBookSource.GetSourceName: string;
var
  ValueRef: CFStringRef;
begin
  Result := string.Empty;
  ValueRef := ABRecordCopyValue(SourceRef, kABSourceNameProperty);
  if ValueRef <> nil then
    try
      Result := CFStringRefToStr(ValueRef);
    finally
      CFRelease(ValueRef);
    end;
end;

function TiOSAddressBookSource.GetSourceType: string;
var
  ValueRef: CFStringRef;
  LAccountType: Integer;
begin
  Result := string.Empty;
  if SourceRef = nil then
    raise EAddressBookExecute.Create(SCannotGetSourceTypeSourceRefRefNil);

  ValueRef := ABRecordCopyValue(SourceRef, kABSourceTypeProperty);
  if ValueRef <> nil then
    try
      LAccountType := TNSNumber.Wrap(ValueRef).intValue;
      case LAccountType of
        kABSourceTypeLocal:
          Result := SSourceLocal;
        kABSourceTypeExchange:
          Result := SSourceExchange;
        kABSourceTypeExchangeGAL:
          Result := SSourceExchangeGAL;
        kABSourceTypeMobileMe:
          Result := SSourceMobileMe;
        kABSourceTypeLDAP:
          Result := SSourceLDAP;
        kABSourceTypeCardDAV:
          Result := SSourceCardDAV;
        kABSourceTypeCardDAVSearch:
          Result := SSourceCardDAVSearch;
      end;
    finally
      CFRelease(ValueRef);
    end;
end;

end.
