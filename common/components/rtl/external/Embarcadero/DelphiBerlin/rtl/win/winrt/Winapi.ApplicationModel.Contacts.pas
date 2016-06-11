{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.ApplicationModel.Contacts;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  // Internal Uses...
  Winapi.Storage.Streams,
  Winapi.Foundation,
  Winapi.Foundation.Collections,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}



type
  // Forward declare interfaces
  // Windows.Foundation.Collections.IIterator`1<Windows.ApplicationModel.Contacts.ContactFieldType>
  IIterator_1__ContactFieldType = interface;
  PIIterator_1__ContactFieldType = ^IIterator_1__ContactFieldType;

  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.Contacts.ContactFieldType>
  IIterable_1__ContactFieldType = interface;
  PIIterable_1__ContactFieldType = ^IIterable_1__ContactFieldType;

  // Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Contacts.ContactFieldType>
  IVectorView_1__ContactFieldType = interface;
  PIVectorView_1__ContactFieldType = ^IVectorView_1__ContactFieldType;

  // Windows.Foundation.Collections.IVector`1<Windows.ApplicationModel.Contacts.ContactFieldType>
  IVector_1__ContactFieldType = interface;
  PIVector_1__ContactFieldType = ^IVector_1__ContactFieldType;


  // Emit Forwarded interfaces
  // Windows.ApplicationModel.Contacts Interfaces
  // Windows.Foundation.Collections.IIterator`1<Windows.ApplicationModel.Contacts.ContactFieldType>
  IIterator_1__ContactFieldType = interface(IInspectable)
  ['{752850B9-5ED2-5655-8DE2-262EFC26CF39}']
    function get_Current: ContactFieldType; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PContactFieldType): Cardinal; safecall;
    property Current: ContactFieldType read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.Contacts.ContactFieldType>
  IIterable_1__ContactFieldType_Base = interface(IInspectable)
  ['{384B8B1B-CE8E-5781-B3DC-0776D684F658}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.Contacts.ContactFieldType>
  IIterable_1__ContactFieldType = interface(IIterable_1__ContactFieldType_Base)
  ['{1B6614A1-8FC5-567D-9157-410A9E0ECBC5}']
    function First: IIterator_1__ContactFieldType; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Contacts.ContactFieldType>
  IVectorView_1__ContactFieldType = interface(IInspectable)
  ['{86D0B56E-CB4E-58F0-B9A2-1528619DCD26}']
    function GetAt(index: Cardinal): ContactFieldType; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: ContactFieldType; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PContactFieldType): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.ApplicationModel.Contacts.ContactFieldType>
  IVector_1__ContactFieldType = interface(IInspectable)
  ['{A4739064-B54E-55D4-8012-317E2B6A807B}']
    function GetAt(index: Cardinal): ContactFieldType; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__ContactFieldType; safecall;
    function IndexOf(value: ContactFieldType; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: ContactFieldType); safecall;
    procedure InsertAt(index: Cardinal; value: ContactFieldType); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: ContactFieldType); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PContactFieldType): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PContactFieldType); safecall;
    property Size: Cardinal read get_Size;
  end;


  // Emit Forwarded classes

implementation

  // Emit Classes Implementation

end.
