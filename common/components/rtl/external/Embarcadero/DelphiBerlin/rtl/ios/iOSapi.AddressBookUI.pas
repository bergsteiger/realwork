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
// Interfaces for Cocoa framework AddressBookUI
//

unit iOSapi.AddressBookUI;

interface

uses
  Macapi.ObjectiveC,
  iOSapi.AddressBook,
  iOSapi.Foundation,
  iOSapi.UIKit;

type

  // ===== Forward declarations =====
  {$M+}
  ABNewPersonViewControllerDelegate = interface;
  ABNewPersonViewController = interface;
  ABPeoplePickerNavigationControllerDelegate = interface;
  ABPeoplePickerNavigationController = interface;
  ABPersonViewControllerDelegate = interface;
  ABPersonViewController = interface;
  ABUnknownPersonViewControllerDelegate = interface;
  ABUnknownPersonViewController = interface;

  // ===== Interface declarations =====

  ABNewPersonViewControllerClass = interface(UIViewControllerClass)
    ['{02C71C6E-D0C6-4A74-AF14-9557C13AA2B0}']
  end;
  ABNewPersonViewController = interface(UIViewController)
    ['{CE26CA3D-3E36-4C97-92DF-6552B70C500D}']
    procedure setNewPersonViewDelegate(newPersonViewDelegate: Pointer); cdecl;
    function newPersonViewDelegate: Pointer; cdecl;
    procedure setAddressBook(AddressBook: ABAddressBookRef); cdecl;
    function AddressBook: ABAddressBookRef; cdecl;
    procedure setDisplayedPerson(displayedPerson: ABRecordRef); cdecl;
    function displayedPerson: ABRecordRef; cdecl;
    procedure setParentGroup(parentGroup: ABRecordRef); cdecl;
    function parentGroup: ABRecordRef; cdecl;
  end;

  TABNewPersonViewController = class(TOCGenericImport<ABNewPersonViewControllerClass, ABNewPersonViewController>)
  end;
  PABNewPersonViewController = Pointer;

  ABPeoplePickerNavigationControllerClass = interface(UINavigationControllerClass)
    ['{A8111585-06C6-48C2-A4DF-0F7B8D250926}']
  end;
  ABPeoplePickerNavigationController = interface(UINavigationController)
    ['{BB49D6AD-74D0-43FE-9D5D-E6049069CBE1}']
    procedure setPeoplePickerDelegate(peoplePickerDelegate: Pointer); cdecl;
    function peoplePickerDelegate: Pointer; cdecl;
    procedure setDisplayedProperties(displayedProperties: NSArray); cdecl;
    function displayedProperties: NSArray; cdecl;
    procedure setAddressBook(AddressBook: ABAddressBookRef); cdecl;
    function AddressBook: ABAddressBookRef; cdecl;
    procedure setPredicateForEnablingPerson(predicateForEnablingPerson: NSPredicate); cdecl;
    function predicateForEnablingPerson: NSPredicate; cdecl;
    procedure setPredicateForSelectionOfPerson(predicateForSelectionOfPerson: NSPredicate); cdecl;
    function predicateForSelectionOfPerson: NSPredicate; cdecl;
    procedure setPredicateForSelectionOfProperty(predicateForSelectionOfProperty: NSPredicate); cdecl;
    function predicateForSelectionOfProperty: NSPredicate; cdecl;
  end;

  TABPeoplePickerNavigationController = class(TOCGenericImport<ABPeoplePickerNavigationControllerClass,
    ABPeoplePickerNavigationController>)
  end;
  PABPeoplePickerNavigationController = Pointer;

  ABPersonViewControllerClass = interface(UIViewControllerClass)
    ['{5E3F3847-4255-4B49-9915-9800A35AC0AC}']
  end;
  ABPersonViewController = interface(UIViewController)
    ['{F9F2B898-67CC-4064-A041-D78F93A5EA8D}']
    procedure setPersonViewDelegate(personViewDelegate: Pointer); cdecl;
    function personViewDelegate: Pointer; cdecl;
    procedure setAddressBook(AddressBook: ABAddressBookRef); cdecl;
    function AddressBook: ABAddressBookRef; cdecl;
    procedure setDisplayedPerson(displayedPerson: ABRecordRef); cdecl;
    function displayedPerson: ABRecordRef; cdecl;
    procedure setDisplayedProperties(displayedProperties: NSArray); cdecl;
    function displayedProperties: NSArray; cdecl;
    procedure setAllowsEditing(allowsEditing: Boolean); cdecl;
    function allowsEditing: Boolean; cdecl;
    procedure setAllowsActions(allowsActions: Boolean); cdecl;
    function allowsActions: Boolean; cdecl;
    procedure setShouldShowLinkedPeople(shouldShowLinkedPeople: Boolean); cdecl;
    function shouldShowLinkedPeople: Boolean; cdecl;
    procedure setHighlightedItemForProperty(&property: ABPropertyID; withIdentifier: ABMultiValueIdentifier); cdecl;
  end;

  TABPersonViewController = class(TOCGenericImport<ABPersonViewControllerClass, ABPersonViewController>)
  end;
  PABPersonViewController = Pointer;

  ABUnknownPersonViewControllerClass = interface(UIViewControllerClass)
    ['{433E83A3-2B2D-4314-9773-09DA5C28CC29}']
  end;
  ABUnknownPersonViewController = interface(UIViewController)
    ['{59007037-C81A-4FFC-A664-57D0499DC482}']
    procedure setUnknownPersonViewDelegate(unknownPersonViewDelegate: Pointer); cdecl;
    function unknownPersonViewDelegate: Pointer; cdecl;
    procedure setAddressBook(AddressBook: ABAddressBookRef); cdecl;
    function AddressBook: ABAddressBookRef; cdecl;
    procedure setDisplayedPerson(displayedPerson: ABRecordRef); cdecl;
    function displayedPerson: ABRecordRef; cdecl;
    procedure setAlternateName(alternateName: NSString); cdecl;
    function alternateName: NSString; cdecl;
    procedure setMessage(message: NSString); cdecl;
    function message: NSString; cdecl;
    procedure setAllowsActions(allowsActions: Boolean); cdecl;
    function allowsActions: Boolean; cdecl;
    procedure setAllowsAddingToAddressBook(allowsAddingToAddressBook: Boolean); cdecl;
    function allowsAddingToAddressBook: Boolean; cdecl;
  end;

  TABUnknownPersonViewController = class(TOCGenericImport<ABUnknownPersonViewControllerClass,
    ABUnknownPersonViewController>)
  end;
  PABUnknownPersonViewController = Pointer;

  // ===== Protocol declarations =====

  ABNewPersonViewControllerDelegate = interface(IObjectiveC)
    ['{94FAFEC4-530D-4BA3-939D-D93F9A1C5D95}']
    procedure newPersonViewController(newPersonView: ABNewPersonViewController;
      didCompleteWithNewPerson: ABRecordRef); cdecl;
  end;

  ABPeoplePickerNavigationControllerDelegate = interface(IObjectiveC)
    ['{2D9E85E3-3477-4E10-86D4-2A6ED47CC84D}']
    [MethodName('peoplePickerNavigationController:didSelectPerson:')]
    procedure peoplePickerNavigationControllerDidSelectPerson(peoplePicker: ABPeoplePickerNavigationController;
      didSelectPerson: ABRecordRef); cdecl;
    [MethodName('peoplePickerNavigationController:didSelectPerson:property:identifier:')]
    procedure peoplePickerNavigationControllerDidSelectPersonPropertyIdentifier
      (peoplePicker: ABPeoplePickerNavigationController; didSelectPerson: ABRecordRef; &property: ABPropertyID;
      identifier: ABMultiValueIdentifier); cdecl;
    procedure peoplePickerNavigationControllerDidCancel(peoplePicker: ABPeoplePickerNavigationController); cdecl;
    [MethodName('peoplePickerNavigationController:shouldContinueAfterSelectingPerson:')]
    function peoplePickerNavigationControllerShouldContinueAfterSelectingPerson
      (peoplePicker: ABPeoplePickerNavigationController; shouldContinueAfterSelectingPerson: ABRecordRef)
      : Boolean; cdecl;
    [MethodName('peoplePickerNavigationController:shouldContinueAfterSelectingPerson:property:identifier:')]
    function peoplePickerNavigationControllerShouldContinueAfterSelectingPersonPropertyIdentifier
      (peoplePicker: ABPeoplePickerNavigationController; shouldContinueAfterSelectingPerson: ABRecordRef;
      &property: ABPropertyID; identifier: ABMultiValueIdentifier): Boolean; cdecl;
  end;

  ABPersonViewControllerDelegate = interface(IObjectiveC)
    ['{DF6DC352-6DB0-4610-8916-34B7AE1FD9BE}']
    function personViewController(personViewController: ABPersonViewController;
      shouldPerformDefaultActionForPerson: ABRecordRef; &property: ABPropertyID; identifier: ABMultiValueIdentifier)
      : Boolean; cdecl;
  end;

  ABUnknownPersonViewControllerDelegate = interface(IObjectiveC)
    ['{53B8F74F-433E-4074-9F0C-F6C786E2D4AD}']
    [MethodName('unknownPersonViewController:didResolveToPerson:')]
    procedure unknownPersonViewControllerDidResolveToPerson(unknownCardViewController: ABUnknownPersonViewController;
      didResolveToPerson: ABRecordRef); cdecl;
    [MethodName('unknownPersonViewController:shouldPerformDefaultActionForPerson:property:identifier:')]
    function unknownPersonViewControllerShouldPerformDefaultActionForPersonPropertyIdentifier
      (personViewController: ABUnknownPersonViewController; shouldPerformDefaultActionForPerson: ABRecordRef;
      &property: ABPropertyID; identifier: ABMultiValueIdentifier): Boolean; cdecl;
  end;

  // ===== Exported string consts =====

function ABPersonNamePrefixProperty: NSString;
function ABPersonGivenNameProperty: NSString;
function ABPersonMiddleNameProperty: NSString;
function ABPersonFamilyNameProperty: NSString;
function ABPersonNameSuffixProperty: NSString;
function ABPersonPreviousFamilyNameProperty: NSString;
function ABPersonNicknameProperty: NSString;
function ABPersonPhoneticGivenNameProperty: NSString;
function ABPersonPhoneticMiddleNameProperty: NSString;
function ABPersonPhoneticFamilyNameProperty: NSString;
function ABPersonOrganizationNameProperty: NSString;
function ABPersonDepartmentNameProperty: NSString;
function ABPersonJobTitleProperty: NSString;
function ABPersonBirthdayProperty: NSString;
function ABPersonNoteProperty: NSString;
function ABPersonPhoneNumbersProperty: NSString;
function ABPersonEmailAddressesProperty: NSString;
function ABPersonUrlAddressesProperty: NSString;
function ABPersonDatesProperty: NSString;
function ABPersonInstantMessageAddressesProperty: NSString;
function ABPersonRelatedNamesProperty: NSString;
function ABPersonSocialProfilesProperty: NSString;
function ABPersonPostalAddressesProperty: NSString;


// ===== External functions =====

const
  libAddressBookUI = '/System/Library/Frameworks/AddressBookUI.framework/AddressBookUI';

implementation

{$IF defined(IOS) and NOT defined(CPUARM)}

uses
  Posix.Dlfcn;

var
  AddressBookUIModule: THandle;

{$ENDIF IOS}

function ABPersonNamePrefixProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonNamePrefixProperty');
end;

function ABPersonGivenNameProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonGivenNameProperty');
end;

function ABPersonMiddleNameProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonMiddleNameProperty');
end;

function ABPersonFamilyNameProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonFamilyNameProperty');
end;

function ABPersonNameSuffixProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonNameSuffixProperty');
end;

function ABPersonPreviousFamilyNameProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonPreviousFamilyNameProperty');
end;

function ABPersonNicknameProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonNicknameProperty');
end;

function ABPersonPhoneticGivenNameProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonPhoneticGivenNameProperty');
end;

function ABPersonPhoneticMiddleNameProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonPhoneticMiddleNameProperty');
end;

function ABPersonPhoneticFamilyNameProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonPhoneticFamilyNameProperty');
end;

function ABPersonOrganizationNameProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonOrganizationNameProperty');
end;

function ABPersonDepartmentNameProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonDepartmentNameProperty');
end;

function ABPersonJobTitleProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonJobTitleProperty');
end;

function ABPersonBirthdayProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonBirthdayProperty');
end;

function ABPersonNoteProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonNoteProperty');
end;

function ABPersonPhoneNumbersProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonPhoneNumbersProperty');
end;

function ABPersonEmailAddressesProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonEmailAddressesProperty');
end;

function ABPersonUrlAddressesProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonUrlAddressesProperty');
end;

function ABPersonDatesProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonDatesProperty');
end;

function ABPersonInstantMessageAddressesProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonInstantMessageAddressesProperty');
end;

function ABPersonRelatedNamesProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonRelatedNamesProperty');
end;

function ABPersonSocialProfilesProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonSocialProfilesProperty');
end;

function ABPersonPostalAddressesProperty: NSString;
begin
  Result := CocoaNSStringConst(libAddressBookUI, 'ABPersonPostalAddressesProperty');
end;

{$IF defined(IOS) and NOT defined(CPUARM)}

initialization

AddressBookUIModule := dlopen(MarshaledAString(libAddressBookUI), RTLD_LAZY);

finalization

dlclose(AddressBookUIModule);
{$ENDIF IOS}

end.
