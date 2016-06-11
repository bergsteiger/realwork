{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.ApplicationModel.Core;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.ApplicationModel,
  Winapi.UI.Core,
  // Internal Uses...
  Winapi.Foundation,
  Winapi.Foundation.Collections,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.ApplicationModel.Core Class Names
  // Windows.ApplicationModel.Core.AppListEntry
  // DualAPI
  SAppListEntry = 'Windows.ApplicationModel.Core.AppListEntry';


type
  // Forward declare interfaces
  // Windows.ApplicationModel.Core.IAppListEntry
  IAppListEntry = interface;
  PIAppListEntry = ^IAppListEntry;

  // Windows.Foundation.Collections.IIterator`1<Windows.ApplicationModel.Core.IAppListEntry>
  IIterator_1__IAppListEntry = interface;
  PIIterator_1__IAppListEntry = ^IIterator_1__IAppListEntry;

  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.Core.IAppListEntry>
  IIterable_1__IAppListEntry = interface;
  PIIterable_1__IAppListEntry = ^IIterable_1__IAppListEntry;

  // Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Core.IAppListEntry>
  IVectorView_1__IAppListEntry = interface;
  PIVectorView_1__IAppListEntry = ^IVectorView_1__IAppListEntry;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Core.IAppListEntry>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IAppListEntry = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__IAppListEntry = ^AsyncOperationCompletedHandler_1__IVectorView_1__IAppListEntry;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Core.IAppListEntry>>
  IAsyncOperation_1__IVectorView_1__IAppListEntry = interface;
  PIAsyncOperation_1__IVectorView_1__IAppListEntry = ^IAsyncOperation_1__IVectorView_1__IAppListEntry;


  // Emit Forwarded interfaces
  // Windows.ApplicationModel.Core Interfaces
  // DualAPI Interface
  // Windows.ApplicationModel.Core.IAppListEntry
  [WinRTClassNameAttribute(SAppListEntry)]
  IAppListEntry = interface(IInspectable)
  ['{EF00F07F-2108-490A-877A-8A9F17C25FAD}']
    function get_DisplayInfo: IAppDisplayInfo; safecall;
    function LaunchAsync: IAsyncOperation_1__Boolean; safecall;
    property DisplayInfo: IAppDisplayInfo read get_DisplayInfo;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.ApplicationModel.Core.IAppListEntry>
  IIterator_1__IAppListEntry = interface(IInspectable)
  ['{1E94D34D-7C77-50D7-B65A-CA24954EBAFA}']
    function get_Current: IAppListEntry; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIAppListEntry): Cardinal; safecall;
    property Current: IAppListEntry read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.ApplicationModel.Core.IAppListEntry>
  IIterable_1__IAppListEntry = interface(IInspectable)
  ['{3B58FDB7-ED7D-5B1D-8996-ADED30E93DF9}']
    function First: IIterator_1__IAppListEntry; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Core.IAppListEntry>
  IVectorView_1__IAppListEntry = interface(IInspectable)
  ['{1D8ACCFE-BA75-591F-AF1E-2ACDA21D85C1}']
    function GetAt(index: Cardinal): IAppListEntry; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IAppListEntry; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIAppListEntry): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Core.IAppListEntry>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IAppListEntry = interface(IUnknown)
  ['{4CB461E4-D1B6-5C09-98B4-583C5EE8ACED}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__IAppListEntry; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.ApplicationModel.Core.IAppListEntry>>
  IAsyncOperation_1__IVectorView_1__IAppListEntry = interface(IInspectable)
  ['{A320E67B-2293-546B-B9FE-E80AB59BA643}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__IAppListEntry); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IAppListEntry; safecall;
    function GetResults: IVectorView_1__IAppListEntry; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IAppListEntry read get_Completed write put_Completed;
  end;


  // Emit Forwarded classes
  // Windows.ApplicationModel.Core.AppListEntry
  // DualAPI


implementation

  // Emit Classes Implementation

end.
