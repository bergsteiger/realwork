{***********************************************************}
{                                                           }
{             CodeGear Delphi Runtime Library               }
{                                                           }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.          }
{              All rights reserved                          }
{                                                           }
{***********************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for Cocoa framework AddressBook
//

unit iOSapi.AddressBook;

interface

uses
  Macapi.CoreFoundation,
  Macapi.ObjectiveC,
  iOSapi.Foundation;

const
  kABPersonType = 0;
  kABGroupType = 1;
  kABSourceType = 2;
  kABInvalidPropertyType = 0;
  kABStringPropertyType = 1;
  kABIntegerPropertyType = 2;
  kABRealPropertyType = 3;
  kABDateTimePropertyType = 4;
  kABDictionaryPropertyType = 5;
  kABMultiStringPropertyType = (1 shl 8) or kABStringPropertyType;
  kABMultiIntegerPropertyType = (1 shl 8) or kABIntegerPropertyType;
  kABMultiRealPropertyType = (1 shl 8) or kABRealPropertyType;
  kABMultiDateTimePropertyType = (1 shl 8) or kABDateTimePropertyType;
  kABMultiDictionaryPropertyType = (1 shl 8) or kABDictionaryPropertyType;
  kABOperationNotPermittedByStoreError = 0;
  kABOperationNotPermittedByUserError = 1;
  kABAuthorizationStatusNotDetermined = 0;
  kABAuthorizationStatusRestricted = 1;
  kABAuthorizationStatusDenied = 2;
  kABAuthorizationStatusAuthorized = 3;
  kABSourceTypeLocal = 0;
  kABSourceTypeExchange = 1;
  kABSourceTypeExchangeGAL = kABSourceTypeExchange or 16777216;
  kABSourceTypeMobileMe = 2;
  kABSourceTypeLDAP = 3 or 16777216;
  kABSourceTypeCardDAV = 4;
  kABSourceTypeCardDAVSearch = kABSourceTypeCardDAV or 16777216;
  kABPersonSortByFirstName = 0;
  kABPersonSortByLastName = 1;
  kABPersonCompositeNameFormatFirstNameFirst = 0;
  kABPersonCompositeNameFormatLastNameFirst = 1;
  kABPersonImageFormatThumbnail = 0;
  kABPersonImageFormatOriginalSize = 2;

type
  // ===== Framework typedefs =====
  {$M+}
  ABRecordRef = CFTypeRef;
  ABRecordID = Int32;
  ABPropertyID = Int32;
  ABRecordType = LongWord;
  ABPropertyType = LongWord;
  ABAddressBookRef = CFTypeRef;
  ABAuthorizationStatus = CFIndex;
  ABAddressBookRequestAccessCompletionHandler = procedure(param1: Boolean; param2: CFErrorRef) of object;
  ABExternalChangeCallback = procedure(param1: ABAddressBookRef; param2: CFDictionaryRef; param3: Pointer); cdecl;
  ABSourceType = Integer;
  ABPersonSortOrdering = LongWord;
  ABPersonCompositeNameFormat = LongWord;
  ABPersonImageFormat = Cardinal;
  ABMultiValueRef = CFTypeRef;
  ABMultiValueIdentifier = Int32;
  ABMutableMultiValueRef = CFTypeRef;
  // ===== Exported string consts =====

function ABAddressBookErrorDomain: Pointer;
function kABSourceNameProperty: Integer;
function kABSourceTypeProperty: Integer;
function kABWorkLabel: NSString;
function kABHomeLabel: NSString;
function kABOtherLabel: NSString;
function kABPersonFirstNameProperty: Integer;
function kABPersonLastNameProperty: Integer;
function kABPersonMiddleNameProperty: Integer;
function kABPersonPrefixProperty: Integer;
function kABPersonSuffixProperty: Integer;
function kABPersonNicknameProperty: Integer;
function kABPersonFirstNamePhoneticProperty: Integer;
function kABPersonLastNamePhoneticProperty: Integer;
function kABPersonMiddleNamePhoneticProperty: Integer;
function kABPersonOrganizationProperty: Integer;
function kABPersonJobTitleProperty: Integer;
function kABPersonDepartmentProperty: Integer;
function kABPersonEmailProperty: Integer;
function kABPersonBirthdayProperty: Integer;
function kABPersonNoteProperty: Integer;
function kABPersonCreationDateProperty: Integer;
function kABPersonModificationDateProperty: Integer;
function kABPersonAddressProperty: Integer;
function kABPersonAddressStreetKey: NSString;
function kABPersonAddressCityKey: NSString;
function kABPersonAddressStateKey: NSString;
function kABPersonAddressZIPKey: NSString;
function kABPersonAddressCountryKey: NSString;
function kABPersonAddressCountryCodeKey: NSString;
function kABPersonDateProperty: Integer;
function kABPersonAnniversaryLabel: NSString;
function kABPersonKindProperty: Integer;
function kABPersonKindPerson: Pointer;
function kABPersonKindOrganization: Pointer;
function kABPersonPhoneProperty: Integer;
function kABPersonPhoneMobileLabel: NSString;
function kABPersonPhoneIPhoneLabel: NSString;
function kABPersonPhoneMainLabel: NSString;
function kABPersonPhoneHomeFAXLabel: NSString;
function kABPersonPhoneWorkFAXLabel: NSString;
function kABPersonPhoneOtherFAXLabel: NSString;
function kABPersonPhonePagerLabel: NSString;
function kABPersonInstantMessageProperty: Integer;
function kABPersonInstantMessageServiceKey: NSString;
function kABPersonInstantMessageServiceYahoo: NSString;
function kABPersonInstantMessageServiceJabber: NSString;
function kABPersonInstantMessageServiceMSN: NSString;
function kABPersonInstantMessageServiceICQ: NSString;
function kABPersonInstantMessageServiceAIM: NSString;
function kABPersonInstantMessageServiceQQ: NSString;
function kABPersonInstantMessageServiceGoogleTalk: NSString;
function kABPersonInstantMessageServiceSkype: NSString;
function kABPersonInstantMessageServiceFacebook: NSString;
function kABPersonInstantMessageServiceGaduGadu: NSString;
function kABPersonInstantMessageUsernameKey: NSString;
function kABPersonURLProperty: Integer;
function kABPersonHomePageLabel: NSString;
function kABPersonRelatedNamesProperty: Integer;
function kABPersonFatherLabel: NSString;
function kABPersonMotherLabel: NSString;
function kABPersonParentLabel: NSString;
function kABPersonBrotherLabel: NSString;
function kABPersonSisterLabel: NSString;
function kABPersonChildLabel: NSString;
function kABPersonFriendLabel: NSString;
function kABPersonSpouseLabel: NSString;
function kABPersonPartnerLabel: NSString;
function kABPersonAssistantLabel: NSString;
function kABPersonManagerLabel: NSString;
function kABPersonSocialProfileProperty: Integer;
function kABPersonSocialProfileURLKey: NSString;
function kABPersonSocialProfileServiceKey: NSString;
function kABPersonSocialProfileUsernameKey: NSString;
function kABPersonSocialProfileUserIdentifierKey: NSString;
function kABPersonSocialProfileServiceTwitter: NSString;
function kABPersonSocialProfileServiceSinaWeibo: NSString;
function kABPersonSocialProfileServiceGameCenter: NSString;
function kABPersonSocialProfileServiceFacebook: NSString;
function kABPersonSocialProfileServiceMyspace: NSString;
function kABPersonSocialProfileServiceLinkedIn: NSString;
function kABPersonSocialProfileServiceFlickr: NSString;
function kABPersonAlternateBirthdayProperty: Integer;
function kABPersonAlternateBirthdayCalendarIdentifierKey: NSString;
function kABPersonAlternateBirthdayEraKey: NSString;
function kABPersonAlternateBirthdayYearKey: NSString;
function kABPersonAlternateBirthdayMonthKey: NSString;
function kABPersonAlternateBirthdayIsLeapMonthKey: NSString;
function kABPersonAlternateBirthdayDayKey: NSString;
function kABGroupNameProperty: Integer;


// ===== External functions =====

const
  libAddressBook = '/System/Library/Frameworks/AddressBook.framework/AddressBook';
function ABRecordGetRecordID(&record: ABRecordRef): ABRecordID; cdecl;
  external libAddressBook name _PU + 'ABRecordGetRecordID';
function ABRecordGetRecordType(&record: ABRecordRef): ABRecordType; cdecl;
  external libAddressBook name _PU + 'ABRecordGetRecordType';
function ABRecordCopyValue(&record: ABRecordRef; &property: ABPropertyID): CFTypeRef; cdecl;
  external libAddressBook name _PU + 'ABRecordCopyValue';
function ABRecordSetValue(&record: ABRecordRef; &property: ABPropertyID; value: CFTypeRef; error: CFErrorRef): Boolean;
  cdecl; external libAddressBook name _PU + 'ABRecordSetValue';
function ABRecordRemoveValue(&record: ABRecordRef; &property: ABPropertyID; error: CFErrorRef): Integer; cdecl;
  external libAddressBook name _PU + 'ABRecordRemoveValue';
function ABRecordCopyCompositeName(&record: ABRecordRef): CFStringRef; cdecl;
  external libAddressBook name _PU + 'ABRecordCopyCompositeName';
function ABAddressBookGetAuthorizationStatus: ABAuthorizationStatus; cdecl;
  external libAddressBook name _PU + 'ABAddressBookGetAuthorizationStatus';
function ABAddressBookCreateWithOptions(options: CFDictionaryRef; error: CFErrorRef): ABAddressBookRef; cdecl;
  external libAddressBook name _PU + 'ABAddressBookCreateWithOptions';
function ABAddressBookCreate: ABAddressBookRef; cdecl; external libAddressBook name _PU + 'ABAddressBookCreate';
procedure ABAddressBookRequestAccessWithCompletion(AddressBook: ABAddressBookRef;
  completion: Pointer {ABAddressBookRequestAccessCompletionHandler}); cdecl;
  external libAddressBook name _PU + 'ABAddressBookRequestAccessWithCompletion';
function ABAddressBookSave(AddressBook: ABAddressBookRef; error: CFErrorRef): Boolean; cdecl;
  external libAddressBook name _PU + 'ABAddressBookSave';
function ABAddressBookHasUnsavedChanges(AddressBook: ABAddressBookRef): Boolean; cdecl;
  external libAddressBook name _PU + 'ABAddressBookHasUnsavedChanges';
function ABAddressBookAddRecord(AddressBook: ABAddressBookRef; &record: ABRecordRef; error: CFErrorRef): Boolean; cdecl;
  external libAddressBook name _PU + 'ABAddressBookAddRecord';
function ABAddressBookRemoveRecord(AddressBook: ABAddressBookRef; &record: ABRecordRef; error: CFErrorRef): Boolean;
  cdecl; external libAddressBook name _PU + 'ABAddressBookRemoveRecord';
function ABAddressBookCopyLocalizedLabel(&label: CFStringRef): CFStringRef; cdecl;
  external libAddressBook name _PU + 'ABAddressBookCopyLocalizedLabel';
procedure ABAddressBookRegisterExternalChangeCallback(AddressBook: ABAddressBookRef; callback: ABExternalChangeCallback;
  context: Pointer); cdecl; external libAddressBook name _PU + 'ABAddressBookRegisterExternalChangeCallback';
procedure ABAddressBookUnregisterExternalChangeCallback(AddressBook: ABAddressBookRef;
  callback: ABExternalChangeCallback; context: Pointer); cdecl;
  external libAddressBook name _PU + 'ABAddressBookUnregisterExternalChangeCallback';
procedure ABAddressBookRevert(AddressBook: ABAddressBookRef); cdecl;
  external libAddressBook name _PU + 'ABAddressBookRevert';
function ABAddressBookCopyDefaultSource(AddressBook: ABAddressBookRef): ABRecordRef; cdecl;
  external libAddressBook name _PU + 'ABAddressBookCopyDefaultSource';
function ABAddressBookGetSourceWithRecordID(AddressBook: ABAddressBookRef; sourceID: ABRecordID): ABRecordRef; cdecl;
  external libAddressBook name _PU + 'ABAddressBookGetSourceWithRecordID';
function ABAddressBookCopyArrayOfAllSources(AddressBook: ABAddressBookRef): CFArrayRef; cdecl;
  external libAddressBook name _PU + 'ABAddressBookCopyArrayOfAllSources';
function ABPersonCreate: ABRecordRef; cdecl; external libAddressBook name _PU + 'ABPersonCreate';
function ABPersonCreateInSource(source: ABRecordRef): ABRecordRef; cdecl;
  external libAddressBook name _PU + 'ABPersonCreateInSource';
function ABPersonCopySource(person: ABRecordRef): ABRecordRef; cdecl;
  external libAddressBook name _PU + 'ABPersonCopySource';
function ABPersonCopyArrayOfAllLinkedPeople(person: ABRecordRef): CFArrayRef; cdecl;
  external libAddressBook name _PU + 'ABPersonCopyArrayOfAllLinkedPeople';
function ABPersonGetTypeOfProperty(&property: ABPropertyID): ABPropertyType; cdecl;
  external libAddressBook name _PU + 'ABPersonGetTypeOfProperty';
function ABPersonCopyLocalizedPropertyName(&property: ABPropertyID): CFStringRef; cdecl;
  external libAddressBook name _PU + 'ABPersonCopyLocalizedPropertyName';
function ABPersonGetSortOrdering: ABPersonSortOrdering; cdecl;
  external libAddressBook name _PU + 'ABPersonGetSortOrdering';
function ABPersonGetCompositeNameFormat: ABPersonCompositeNameFormat; cdecl;
  external libAddressBook name _PU + 'ABPersonGetCompositeNameFormat';
function ABPersonGetCompositeNameFormatForRecord(&record: ABRecordRef): ABPersonCompositeNameFormat; cdecl;
  external libAddressBook name _PU + 'ABPersonGetCompositeNameFormatForRecord';
function ABPersonCopyCompositeNameDelimiterForRecord(&record: ABRecordRef): CFStringRef; cdecl;
  external libAddressBook name _PU + 'ABPersonCopyCompositeNameDelimiterForRecord';
function ABPersonSetImageData(person: ABRecordRef; imageData: CFDataRef; error: CFErrorRef): Boolean; cdecl;
  external libAddressBook name _PU + 'ABPersonSetImageData';
function ABPersonCopyImageData(person: ABRecordRef): CFDataRef; cdecl;
  external libAddressBook name _PU + 'ABPersonCopyImageData';
function ABPersonCopyImageDataWithFormat(person: ABRecordRef; format: ABPersonImageFormat): CFDataRef; cdecl;
  external libAddressBook name _PU + 'ABPersonCopyImageDataWithFormat';
function ABPersonHasImageData(person: ABRecordRef): Integer; cdecl;
  external libAddressBook name _PU + 'ABPersonHasImageData';
function ABPersonRemoveImageData(person: ABRecordRef; error: CFErrorRef): Boolean; cdecl;
  external libAddressBook name _PU + 'ABPersonRemoveImageData';
function ABPersonComparePeopleByName(person1: ABRecordRef; person2: ABRecordRef; ordering: ABPersonSortOrdering)
  : CFComparisonResult; cdecl; external libAddressBook name _PU + 'ABPersonComparePeopleByName';
function ABAddressBookGetPersonCount(AddressBook: ABAddressBookRef): CFIndex; cdecl;
  external libAddressBook name _PU + 'ABAddressBookGetPersonCount';
function ABAddressBookGetPersonWithRecordID(AddressBook: ABAddressBookRef; recordID: ABRecordID): ABRecordRef; cdecl;
  external libAddressBook name _PU + 'ABAddressBookGetPersonWithRecordID';
function ABAddressBookCopyArrayOfAllPeople(AddressBook: ABAddressBookRef): CFArrayRef; cdecl;
  external libAddressBook name _PU + 'ABAddressBookCopyArrayOfAllPeople';
function ABAddressBookCopyArrayOfAllPeopleInSource(AddressBook: ABAddressBookRef; source: ABRecordRef): CFArrayRef;
  cdecl; external libAddressBook name _PU + 'ABAddressBookCopyArrayOfAllPeopleInSource';
function ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(AddressBook: ABAddressBookRef; source: ABRecordRef;
  sortOrdering: ABPersonSortOrdering): CFArrayRef; cdecl;
  external libAddressBook name _PU + 'ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering';
function ABAddressBookCopyPeopleWithName(AddressBook: ABAddressBookRef; name: CFStringRef): CFArrayRef; cdecl;
  external libAddressBook name _PU + 'ABAddressBookCopyPeopleWithName';
function ABPersonCreatePeopleInSourceWithVCardRepresentation(source: ABRecordRef; vCardData: CFDataRef): CFArrayRef;
  cdecl; external libAddressBook name _PU + 'ABPersonCreatePeopleInSourceWithVCardRepresentation';
function ABPersonCreateVCardRepresentationWithPeople(people: CFArrayRef): CFDataRef; cdecl;
  external libAddressBook name _PU + 'ABPersonCreateVCardRepresentationWithPeople';
function ABGroupCreate: ABRecordRef; cdecl; external libAddressBook name _PU + 'ABGroupCreate';
function ABGroupCreateInSource(source: ABRecordRef): ABRecordRef; cdecl;
  external libAddressBook name _PU + 'ABGroupCreateInSource';
function ABGroupCopySource(group: ABRecordRef): ABRecordRef; cdecl;
  external libAddressBook name _PU + 'ABGroupCopySource';
function ABGroupCopyArrayOfAllMembers(group: ABRecordRef): CFArrayRef; cdecl;
  external libAddressBook name _PU + 'ABGroupCopyArrayOfAllMembers';
function ABGroupCopyArrayOfAllMembersWithSortOrdering(group: ABRecordRef; sortOrdering: ABPersonSortOrdering)
  : CFArrayRef; cdecl; external libAddressBook name _PU + 'ABGroupCopyArrayOfAllMembersWithSortOrdering';
function ABGroupAddMember(group: ABRecordRef; person: ABRecordRef; error: CFErrorRef): Boolean; cdecl;
  external libAddressBook name _PU + 'ABGroupAddMember';
function ABGroupRemoveMember(group: ABRecordRef; member: ABRecordRef; error: CFErrorRef): Boolean; cdecl;
  external libAddressBook name _PU + 'ABGroupRemoveMember';
function ABAddressBookGetGroupWithRecordID(AddressBook: ABAddressBookRef; recordID: ABRecordID): ABRecordRef; cdecl;
  external libAddressBook name _PU + 'ABAddressBookGetGroupWithRecordID';
function ABAddressBookGetGroupCount(AddressBook: ABAddressBookRef): CFIndex; cdecl;
  external libAddressBook name _PU + 'ABAddressBookGetGroupCount';
function ABAddressBookCopyArrayOfAllGroups(AddressBook: ABAddressBookRef): CFArrayRef; cdecl;
  external libAddressBook name _PU + 'ABAddressBookCopyArrayOfAllGroups';
function ABAddressBookCopyArrayOfAllGroupsInSource(AddressBook: ABAddressBookRef; source: ABRecordRef): CFArrayRef;
  cdecl; external libAddressBook name _PU + 'ABAddressBookCopyArrayOfAllGroupsInSource';
function ABMultiValueGetPropertyType(multiValue: ABMultiValueRef): ABPropertyType; cdecl;
  external libAddressBook name _PU + 'ABMultiValueGetPropertyType';
function ABMultiValueGetCount(multiValue: ABMultiValueRef): CFIndex; cdecl;
  external libAddressBook name _PU + 'ABMultiValueGetCount';
function ABMultiValueCopyValueAtIndex(multiValue: ABMultiValueRef; index: CFIndex): CFTypeRef; cdecl;
  external libAddressBook name _PU + 'ABMultiValueCopyValueAtIndex';
function ABMultiValueCopyArrayOfAllValues(multiValue: ABMultiValueRef): CFArrayRef; cdecl;
  external libAddressBook name _PU + 'ABMultiValueCopyArrayOfAllValues';
function ABMultiValueCopyLabelAtIndex(multiValue: ABMultiValueRef; index: CFIndex): CFStringRef; cdecl;
  external libAddressBook name _PU + 'ABMultiValueCopyLabelAtIndex';
function ABMultiValueGetIndexForIdentifier(multiValue: ABMultiValueRef; identifier: ABMultiValueIdentifier): CFIndex;
  cdecl; external libAddressBook name _PU + 'ABMultiValueGetIndexForIdentifier';
function ABMultiValueGetIdentifierAtIndex(multiValue: ABMultiValueRef; index: CFIndex): ABMultiValueIdentifier; cdecl;
  external libAddressBook name _PU + 'ABMultiValueGetIdentifierAtIndex';
function ABMultiValueGetFirstIndexOfValue(multiValue: ABMultiValueRef; value: CFTypeRef): CFIndex; cdecl;
  external libAddressBook name _PU + 'ABMultiValueGetFirstIndexOfValue';
function ABMultiValueCreateMutable(&type: ABPropertyType): ABMutableMultiValueRef; cdecl;
  external libAddressBook name _PU + 'ABMultiValueCreateMutable';
function ABMultiValueCreateMutableCopy(multiValue: ABMultiValueRef): ABMutableMultiValueRef; cdecl;
  external libAddressBook name _PU + 'ABMultiValueCreateMutableCopy';
function ABMultiValueAddValueAndLabel(multiValue: ABMutableMultiValueRef; value: CFTypeRef; &label: CFStringRef;
  outIdentifier: ABMultiValueIdentifier): Boolean; cdecl;
  external libAddressBook name _PU + 'ABMultiValueAddValueAndLabel';
function ABMultiValueInsertValueAndLabelAtIndex(multiValue: ABMutableMultiValueRef; value: CFTypeRef;
  &label: CFStringRef; index: CFIndex; outIdentifier: ABMultiValueIdentifier): Integer; cdecl;
  external libAddressBook name _PU + 'ABMultiValueInsertValueAndLabelAtIndex';
function ABMultiValueRemoveValueAndLabelAtIndex(multiValue: ABMutableMultiValueRef; index: CFIndex): Integer; cdecl;
  external libAddressBook name _PU + 'ABMultiValueRemoveValueAndLabelAtIndex';
function ABMultiValueReplaceValueAtIndex(multiValue: ABMutableMultiValueRef; value: CFTypeRef; index: CFIndex): Integer;
  cdecl; external libAddressBook name _PU + 'ABMultiValueReplaceValueAtIndex';
function ABMultiValueReplaceLabelAtIndex(multiValue: ABMutableMultiValueRef; &label: CFStringRef; index: CFIndex)
  : Integer; cdecl; external libAddressBook name _PU + 'ABMultiValueReplaceLabelAtIndex';

implementation

{$IF defined(IOS) and NOT defined(CPUARM)}

uses
  Posix.Dlfcn;

var
  AddressBookModule: THandle;

{$ENDIF IOS}

function ABAddressBookErrorDomain: Pointer;
begin
  Result := CocoaPointerConst(libAddressBook, 'ABAddressBookErrorDomain');
end;

function kABSourceNameProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABSourceNameProperty');
end;

function kABSourceTypeProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABSourceTypeProperty');
end;

function kABWorkLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABWorkLabel');
end;

function kABHomeLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABHomeLabel');
end;

function kABOtherLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABOtherLabel');
end;

function kABPersonFirstNameProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonFirstNameProperty');
end;

function kABPersonLastNameProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonLastNameProperty');
end;

function kABPersonMiddleNameProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonMiddleNameProperty');
end;

function kABPersonPrefixProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonPrefixProperty');
end;

function kABPersonSuffixProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonSuffixProperty');
end;

function kABPersonNicknameProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonNicknameProperty');
end;

function kABPersonFirstNamePhoneticProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonFirstNamePhoneticProperty');
end;

function kABPersonLastNamePhoneticProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonLastNamePhoneticProperty');
end;

function kABPersonMiddleNamePhoneticProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonMiddleNamePhoneticProperty');
end;

function kABPersonOrganizationProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonOrganizationProperty');
end;

function kABPersonJobTitleProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonJobTitleProperty');
end;

function kABPersonDepartmentProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonDepartmentProperty');
end;

function kABPersonEmailProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonEmailProperty');
end;

function kABPersonBirthdayProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonBirthdayProperty');
end;

function kABPersonNoteProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonNoteProperty');
end;

function kABPersonCreationDateProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonCreationDateProperty');
end;

function kABPersonModificationDateProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonModificationDateProperty');
end;

function kABPersonAddressProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonAddressProperty');
end;

function kABPersonAddressStreetKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonAddressStreetKey');
end;

function kABPersonAddressCityKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonAddressCityKey');
end;

function kABPersonAddressStateKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonAddressStateKey');
end;

function kABPersonAddressZIPKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonAddressZIPKey');
end;

function kABPersonAddressCountryKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonAddressCountryKey');
end;

function kABPersonAddressCountryCodeKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonAddressCountryCodeKey');
end;

function kABPersonDateProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonDateProperty');
end;

function kABPersonAnniversaryLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonAnniversaryLabel');
end;

function kABPersonKindProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonKindProperty');
end;

function kABPersonKindPerson: Pointer;
begin
  Result := CocoaPointerConst(libAddressBook, 'kABPersonKindPerson');
end;

function kABPersonKindOrganization: Pointer;
begin
  Result := CocoaPointerConst(libAddressBook, 'kABPersonKindOrganization');
end;

function kABPersonPhoneProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonPhoneProperty');
end;

function kABPersonPhoneMobileLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonPhoneMobileLabel');
end;

function kABPersonPhoneIPhoneLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonPhoneIPhoneLabel');
end;

function kABPersonPhoneMainLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonPhoneMainLabel');
end;

function kABPersonPhoneHomeFAXLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonPhoneHomeFAXLabel');
end;

function kABPersonPhoneWorkFAXLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonPhoneWorkFAXLabel');
end;

function kABPersonPhoneOtherFAXLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonPhoneOtherFAXLabel');
end;

function kABPersonPhonePagerLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonPhonePagerLabel');
end;

function kABPersonInstantMessageProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonInstantMessageProperty');
end;

function kABPersonInstantMessageServiceKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonInstantMessageServiceKey');
end;

function kABPersonInstantMessageServiceYahoo: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonInstantMessageServiceYahoo');
end;

function kABPersonInstantMessageServiceJabber: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonInstantMessageServiceJabber');
end;

function kABPersonInstantMessageServiceMSN: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonInstantMessageServiceMSN');
end;

function kABPersonInstantMessageServiceICQ: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonInstantMessageServiceICQ');
end;

function kABPersonInstantMessageServiceAIM: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonInstantMessageServiceAIM');
end;

function kABPersonInstantMessageServiceQQ: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonInstantMessageServiceQQ');
end;

function kABPersonInstantMessageServiceGoogleTalk: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonInstantMessageServiceGoogleTalk');
end;

function kABPersonInstantMessageServiceSkype: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonInstantMessageServiceSkype');
end;

function kABPersonInstantMessageServiceFacebook: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonInstantMessageServiceFacebook');
end;

function kABPersonInstantMessageServiceGaduGadu: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonInstantMessageServiceGaduGadu');
end;

function kABPersonInstantMessageUsernameKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonInstantMessageUsernameKey');
end;

function kABPersonURLProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonURLProperty');
end;

function kABPersonHomePageLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonHomePageLabel');
end;

function kABPersonRelatedNamesProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonRelatedNamesProperty');
end;

function kABPersonFatherLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonFatherLabel');
end;

function kABPersonMotherLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonMotherLabel');
end;

function kABPersonParentLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonParentLabel');
end;

function kABPersonBrotherLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonBrotherLabel');
end;

function kABPersonSisterLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonSisterLabel');
end;

function kABPersonChildLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonChildLabel');
end;

function kABPersonFriendLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonFriendLabel');
end;

function kABPersonSpouseLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonSpouseLabel');
end;

function kABPersonPartnerLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonPartnerLabel');
end;

function kABPersonAssistantLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonAssistantLabel');
end;

function kABPersonManagerLabel: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonManagerLabel');
end;

function kABPersonSocialProfileProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonSocialProfileProperty');
end;

function kABPersonSocialProfileURLKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonSocialProfileURLKey');
end;

function kABPersonSocialProfileServiceKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonSocialProfileServiceKey');
end;

function kABPersonSocialProfileUsernameKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonSocialProfileUsernameKey');
end;

function kABPersonSocialProfileUserIdentifierKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonSocialProfileUserIdentifierKey');
end;

function kABPersonSocialProfileServiceTwitter: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonSocialProfileServiceTwitter');
end;

function kABPersonSocialProfileServiceSinaWeibo: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonSocialProfileServiceSinaWeibo');
end;

function kABPersonSocialProfileServiceGameCenter: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonSocialProfileServiceGameCenter');
end;

function kABPersonSocialProfileServiceFacebook: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonSocialProfileServiceFacebook');
end;

function kABPersonSocialProfileServiceMyspace: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonSocialProfileServiceMyspace');
end;

function kABPersonSocialProfileServiceLinkedIn: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonSocialProfileServiceLinkedIn');
end;

function kABPersonSocialProfileServiceFlickr: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonSocialProfileServiceFlickr');
end;

function kABPersonAlternateBirthdayProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABPersonAlternateBirthdayProperty');
end;

function kABPersonAlternateBirthdayCalendarIdentifierKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonAlternateBirthdayCalendarIdentifierKey');
end;

function kABPersonAlternateBirthdayEraKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonAlternateBirthdayEraKey');
end;

function kABPersonAlternateBirthdayYearKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonAlternateBirthdayYearKey');
end;

function kABPersonAlternateBirthdayMonthKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonAlternateBirthdayMonthKey');
end;

function kABPersonAlternateBirthdayIsLeapMonthKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonAlternateBirthdayIsLeapMonthKey');
end;

function kABPersonAlternateBirthdayDayKey: NSString;
begin
  Result := CocoaNSStringConst(libAddressBook, 'kABPersonAlternateBirthdayDayKey');
end;

function kABGroupNameProperty: Integer;
begin
  Result := CocoaIntegerConst(libAddressBook, 'kABGroupNameProperty');
end;

{$IF defined(IOS) and NOT defined(CPUARM)}

initialization

AddressBookModule := dlopen(MarshaledAString(libAddressBook), RTLD_LAZY);

finalization

dlclose(AddressBookModule);
{$ENDIF IOS}

end.
