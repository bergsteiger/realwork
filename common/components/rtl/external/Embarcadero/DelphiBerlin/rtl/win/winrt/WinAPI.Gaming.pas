{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Gaming;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.SystemRT,
  // Internal Uses...
  Winapi.Foundation,
  Winapi.Storage.Streams,
  Winapi.Foundation.Collections,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Gaming Class Names
  // Windows.Gaming.XboxLive.Storage.GameSaveContainer
  // DualAPI
  SXboxLive_Storage_GameSaveContainer = 'Windows.Gaming.XboxLive.Storage.GameSaveContainer';
  // Windows.Gaming.XboxLive.Storage.GameSaveOperationResult
  // DualAPI
  SXboxLive_Storage_GameSaveOperationResult = 'Windows.Gaming.XboxLive.Storage.GameSaveOperationResult';
  // Windows.Gaming.XboxLive.Storage.GameSaveContainerInfoQuery
  // DualAPI
  SXboxLive_Storage_GameSaveContainerInfoQuery = 'Windows.Gaming.XboxLive.Storage.GameSaveContainerInfoQuery';
  // Windows.Gaming.XboxLive.Storage.GameSaveProviderGetResult
  // DualAPI
  SXboxLive_Storage_GameSaveProviderGetResult = 'Windows.Gaming.XboxLive.Storage.GameSaveProviderGetResult';
  // Windows.Gaming.XboxLive.Storage.GameSaveProvider
  // DualAPI
  SXboxLive_Storage_GameSaveProvider = 'Windows.Gaming.XboxLive.Storage.GameSaveProvider';
  // Windows.Gaming.XboxLive.Storage.GameSaveBlobGetResult
  // DualAPI
  SXboxLive_Storage_GameSaveBlobGetResult = 'Windows.Gaming.XboxLive.Storage.GameSaveBlobGetResult';
  // Windows.Gaming.XboxLive.Storage.GameSaveBlobInfoQuery
  // DualAPI
  SXboxLive_Storage_GameSaveBlobInfoQuery = 'Windows.Gaming.XboxLive.Storage.GameSaveBlobInfoQuery';
  // Windows.Gaming.XboxLive.Storage.GameSaveContainerInfo
  // DualAPI
  SXboxLive_Storage_GameSaveContainerInfo = 'Windows.Gaming.XboxLive.Storage.GameSaveContainerInfo';
  // Windows.Gaming.XboxLive.Storage.GameSaveBlobInfo
  // DualAPI
  SXboxLive_Storage_GameSaveBlobInfo = 'Windows.Gaming.XboxLive.Storage.GameSaveBlobInfo';
  // Windows.Gaming.XboxLive.Storage.GameSaveContainerInfoGetResult
  // DualAPI
  SXboxLive_Storage_GameSaveContainerInfoGetResult = 'Windows.Gaming.XboxLive.Storage.GameSaveContainerInfoGetResult';
  // Windows.Gaming.XboxLive.Storage.GameSaveBlobInfoGetResult
  // DualAPI
  SXboxLive_Storage_GameSaveBlobInfoGetResult = 'Windows.Gaming.XboxLive.Storage.GameSaveBlobInfoGetResult';


type
  // Forward declare interfaces
  // Windows.Gaming.XboxLive.Storage.IGameSaveOperationResult
  XboxLive_Storage_IGameSaveOperationResult = interface;
  PXboxLive_Storage_IGameSaveOperationResult = ^XboxLive_Storage_IGameSaveOperationResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Gaming.XboxLive.Storage.IGameSaveOperationResult>
  AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveOperationResult = interface;
  PAsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveOperationResult = ^AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveOperationResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Gaming.XboxLive.Storage.IGameSaveOperationResult>
  IAsyncOperation_1__XboxLive_Storage_IGameSaveOperationResult = interface;
  PIAsyncOperation_1__XboxLive_Storage_IGameSaveOperationResult = ^IAsyncOperation_1__XboxLive_Storage_IGameSaveOperationResult;

  // Windows.Gaming.XboxLive.Storage.IGameSaveBlobGetResult
  XboxLive_Storage_IGameSaveBlobGetResult = interface;
  PXboxLive_Storage_IGameSaveBlobGetResult = ^XboxLive_Storage_IGameSaveBlobGetResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Gaming.XboxLive.Storage.IGameSaveBlobGetResult>
  AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveBlobGetResult = interface;
  PAsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveBlobGetResult = ^AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveBlobGetResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Gaming.XboxLive.Storage.IGameSaveBlobGetResult>
  IAsyncOperation_1__XboxLive_Storage_IGameSaveBlobGetResult = interface;
  PIAsyncOperation_1__XboxLive_Storage_IGameSaveBlobGetResult = ^IAsyncOperation_1__XboxLive_Storage_IGameSaveBlobGetResult;

  // Windows.Gaming.XboxLive.Storage.IGameSaveBlobInfo
  XboxLive_Storage_IGameSaveBlobInfo = interface;
  PXboxLive_Storage_IGameSaveBlobInfo = ^XboxLive_Storage_IGameSaveBlobInfo;

  // Windows.Foundation.Collections.IIterator`1<Windows.Gaming.XboxLive.Storage.IGameSaveBlobInfo>
  IIterator_1__XboxLive_Storage_IGameSaveBlobInfo = interface;
  PIIterator_1__XboxLive_Storage_IGameSaveBlobInfo = ^IIterator_1__XboxLive_Storage_IGameSaveBlobInfo;

  // Windows.Foundation.Collections.IIterable`1<Windows.Gaming.XboxLive.Storage.IGameSaveBlobInfo>
  IIterable_1__XboxLive_Storage_IGameSaveBlobInfo = interface;
  PIIterable_1__XboxLive_Storage_IGameSaveBlobInfo = ^IIterable_1__XboxLive_Storage_IGameSaveBlobInfo;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Gaming.XboxLive.Storage.IGameSaveBlobInfo>
  IVectorView_1__XboxLive_Storage_IGameSaveBlobInfo = interface;
  PIVectorView_1__XboxLive_Storage_IGameSaveBlobInfo = ^IVectorView_1__XboxLive_Storage_IGameSaveBlobInfo;

  // Windows.Gaming.XboxLive.Storage.IGameSaveBlobInfoGetResult
  XboxLive_Storage_IGameSaveBlobInfoGetResult = interface;
  PXboxLive_Storage_IGameSaveBlobInfoGetResult = ^XboxLive_Storage_IGameSaveBlobInfoGetResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Gaming.XboxLive.Storage.IGameSaveBlobInfoGetResult>
  AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveBlobInfoGetResult = interface;
  PAsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveBlobInfoGetResult = ^AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveBlobInfoGetResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Gaming.XboxLive.Storage.IGameSaveBlobInfoGetResult>
  IAsyncOperation_1__XboxLive_Storage_IGameSaveBlobInfoGetResult = interface;
  PIAsyncOperation_1__XboxLive_Storage_IGameSaveBlobInfoGetResult = ^IAsyncOperation_1__XboxLive_Storage_IGameSaveBlobInfoGetResult;

  // Windows.Gaming.XboxLive.Storage.IGameSaveBlobInfoQuery
  XboxLive_Storage_IGameSaveBlobInfoQuery = interface;
  PXboxLive_Storage_IGameSaveBlobInfoQuery = ^XboxLive_Storage_IGameSaveBlobInfoQuery;

  // Windows.Gaming.XboxLive.Storage.IGameSaveContainer
  XboxLive_Storage_IGameSaveContainer = interface;
  PXboxLive_Storage_IGameSaveContainer = ^XboxLive_Storage_IGameSaveContainer;

  // Windows.Gaming.XboxLive.Storage.IGameSaveContainerInfo
  XboxLive_Storage_IGameSaveContainerInfo = interface;
  PXboxLive_Storage_IGameSaveContainerInfo = ^XboxLive_Storage_IGameSaveContainerInfo;

  // Windows.Foundation.Collections.IIterator`1<Windows.Gaming.XboxLive.Storage.IGameSaveContainerInfo>
  IIterator_1__XboxLive_Storage_IGameSaveContainerInfo = interface;
  PIIterator_1__XboxLive_Storage_IGameSaveContainerInfo = ^IIterator_1__XboxLive_Storage_IGameSaveContainerInfo;

  // Windows.Foundation.Collections.IIterable`1<Windows.Gaming.XboxLive.Storage.IGameSaveContainerInfo>
  IIterable_1__XboxLive_Storage_IGameSaveContainerInfo = interface;
  PIIterable_1__XboxLive_Storage_IGameSaveContainerInfo = ^IIterable_1__XboxLive_Storage_IGameSaveContainerInfo;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Gaming.XboxLive.Storage.IGameSaveContainerInfo>
  IVectorView_1__XboxLive_Storage_IGameSaveContainerInfo = interface;
  PIVectorView_1__XboxLive_Storage_IGameSaveContainerInfo = ^IVectorView_1__XboxLive_Storage_IGameSaveContainerInfo;

  // Windows.Gaming.XboxLive.Storage.IGameSaveContainerInfoGetResult
  XboxLive_Storage_IGameSaveContainerInfoGetResult = interface;
  PXboxLive_Storage_IGameSaveContainerInfoGetResult = ^XboxLive_Storage_IGameSaveContainerInfoGetResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Gaming.XboxLive.Storage.IGameSaveContainerInfoGetResult>
  AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveContainerInfoGetResult = interface;
  PAsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveContainerInfoGetResult = ^AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveContainerInfoGetResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Gaming.XboxLive.Storage.IGameSaveContainerInfoGetResult>
  IAsyncOperation_1__XboxLive_Storage_IGameSaveContainerInfoGetResult = interface;
  PIAsyncOperation_1__XboxLive_Storage_IGameSaveContainerInfoGetResult = ^IAsyncOperation_1__XboxLive_Storage_IGameSaveContainerInfoGetResult;

  // Windows.Gaming.XboxLive.Storage.IGameSaveContainerInfoQuery
  XboxLive_Storage_IGameSaveContainerInfoQuery = interface;
  PXboxLive_Storage_IGameSaveContainerInfoQuery = ^XboxLive_Storage_IGameSaveContainerInfoQuery;

  // Windows.Gaming.XboxLive.Storage.IGameSaveProvider
  XboxLive_Storage_IGameSaveProvider = interface;
  PXboxLive_Storage_IGameSaveProvider = ^XboxLive_Storage_IGameSaveProvider;

  // Windows.Gaming.XboxLive.Storage.IGameSaveProviderGetResult
  XboxLive_Storage_IGameSaveProviderGetResult = interface;
  PXboxLive_Storage_IGameSaveProviderGetResult = ^XboxLive_Storage_IGameSaveProviderGetResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Gaming.XboxLive.Storage.IGameSaveProviderGetResult>
  AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveProviderGetResult = interface;
  PAsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveProviderGetResult = ^AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveProviderGetResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Gaming.XboxLive.Storage.IGameSaveProviderGetResult>
  IAsyncOperation_1__XboxLive_Storage_IGameSaveProviderGetResult = interface;
  PIAsyncOperation_1__XboxLive_Storage_IGameSaveProviderGetResult = ^IAsyncOperation_1__XboxLive_Storage_IGameSaveProviderGetResult;

  // Windows.Gaming.XboxLive.Storage.IGameSaveProviderStatics
  XboxLive_Storage_IGameSaveProviderStatics = interface;
  PXboxLive_Storage_IGameSaveProviderStatics = ^XboxLive_Storage_IGameSaveProviderStatics;

  // Windows.Gaming.Preview.GamesEnumeration.GameListRemovedEventHandler
  Preview_GamesEnumeration_GameListRemovedEventHandler = interface;
  PPreview_GamesEnumeration_GameListRemovedEventHandler = ^Preview_GamesEnumeration_GameListRemovedEventHandler;


  // Emit Forwarded interfaces
  // Windows.Gaming Interfaces
  // DualAPI Interface
  // Windows.Gaming.XboxLive.Storage.IGameSaveOperationResult
  [WinRTClassNameAttribute(SXboxLive_Storage_GameSaveOperationResult)]
  XboxLive_Storage_IGameSaveOperationResult = interface(IInspectable)
  ['{CF0F1A05-24A0-4582-9A55-B1BBBB9388D8}']
    function get_Status: XboxLive_Storage_GameSaveErrorStatus; safecall;
    property Status: XboxLive_Storage_GameSaveErrorStatus read get_Status;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Gaming.XboxLive.Storage.IGameSaveOperationResult>
  AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveOperationResult = interface(IUnknown)
  ['{B8E836FA-5951-51E5-97B3-20877A33E797}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__XboxLive_Storage_IGameSaveOperationResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Gaming.XboxLive.Storage.IGameSaveOperationResult>
  IAsyncOperation_1__XboxLive_Storage_IGameSaveOperationResult = interface(IInspectable)
  ['{C35050AC-3B37-5C2F-855B-F7A59172F12E}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveOperationResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveOperationResult; safecall;
    function GetResults: XboxLive_Storage_IGameSaveOperationResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveOperationResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Gaming.XboxLive.Storage.IGameSaveBlobGetResult
  [WinRTClassNameAttribute(SXboxLive_Storage_GameSaveBlobGetResult)]
  XboxLive_Storage_IGameSaveBlobGetResult = interface(IInspectable)
  ['{917281E0-7201-4953-AA2C-4008F03AEF45}']
    function get_Status: XboxLive_Storage_GameSaveErrorStatus; safecall;
    function get_Value: IMapView_2__HSTRING__IBuffer; safecall;
    property Status: XboxLive_Storage_GameSaveErrorStatus read get_Status;
    property Value: IMapView_2__HSTRING__IBuffer read get_Value;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Gaming.XboxLive.Storage.IGameSaveBlobGetResult>
  AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveBlobGetResult = interface(IUnknown)
  ['{5401C820-05B6-52E3-8C90-7CCE3D7448AF}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__XboxLive_Storage_IGameSaveBlobGetResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Gaming.XboxLive.Storage.IGameSaveBlobGetResult>
  IAsyncOperation_1__XboxLive_Storage_IGameSaveBlobGetResult = interface(IInspectable)
  ['{FF5A0BFE-BD7C-5695-8F49-EE175CDFAF0C}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveBlobGetResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveBlobGetResult; safecall;
    function GetResults: XboxLive_Storage_IGameSaveBlobGetResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveBlobGetResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Gaming.XboxLive.Storage.IGameSaveBlobInfo
  [WinRTClassNameAttribute(SXboxLive_Storage_GameSaveBlobInfo)]
  XboxLive_Storage_IGameSaveBlobInfo = interface(IInspectable)
  ['{ADD38034-BAF0-4645-B6D0-46EDAFFB3C2B}']
    function get_Name: HSTRING; safecall;
    function get_Size: Cardinal; safecall;
    property Name: HSTRING read get_Name;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Gaming.XboxLive.Storage.IGameSaveBlobInfo>
  IIterator_1__XboxLive_Storage_IGameSaveBlobInfo = interface(IInspectable)
  ['{A0D56059-EF17-5B74-974D-5F94D12B10EA}']
    function get_Current: XboxLive_Storage_IGameSaveBlobInfo; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PXboxLive_Storage_IGameSaveBlobInfo): Cardinal; safecall;
    property Current: XboxLive_Storage_IGameSaveBlobInfo read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Gaming.XboxLive.Storage.IGameSaveBlobInfo>
  IIterable_1__XboxLive_Storage_IGameSaveBlobInfo = interface(IInspectable)
  ['{43514C9B-BF01-5719-80A3-6D7A4D536D62}']
    function First: IIterator_1__XboxLive_Storage_IGameSaveBlobInfo; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Gaming.XboxLive.Storage.IGameSaveBlobInfo>
  IVectorView_1__XboxLive_Storage_IGameSaveBlobInfo = interface(IInspectable)
  ['{DA049282-6A34-541E-AFC2-DC31D40227D4}']
    function GetAt(index: Cardinal): XboxLive_Storage_IGameSaveBlobInfo; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: XboxLive_Storage_IGameSaveBlobInfo; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PXboxLive_Storage_IGameSaveBlobInfo): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Gaming.XboxLive.Storage.IGameSaveBlobInfoGetResult
  [WinRTClassNameAttribute(SXboxLive_Storage_GameSaveBlobInfoGetResult)]
  XboxLive_Storage_IGameSaveBlobInfoGetResult = interface(IInspectable)
  ['{C7578582-3697-42BF-989C-665D923B5231}']
    function get_Status: XboxLive_Storage_GameSaveErrorStatus; safecall;
    function get_Value: IVectorView_1__XboxLive_Storage_IGameSaveBlobInfo; safecall;
    property Status: XboxLive_Storage_GameSaveErrorStatus read get_Status;
    property Value: IVectorView_1__XboxLive_Storage_IGameSaveBlobInfo read get_Value;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Gaming.XboxLive.Storage.IGameSaveBlobInfoGetResult>
  AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveBlobInfoGetResult = interface(IUnknown)
  ['{F3ABCDCD-1681-59C7-9916-5B862B81716D}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__XboxLive_Storage_IGameSaveBlobInfoGetResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Gaming.XboxLive.Storage.IGameSaveBlobInfoGetResult>
  IAsyncOperation_1__XboxLive_Storage_IGameSaveBlobInfoGetResult = interface(IInspectable)
  ['{C7C52A18-3BB2-59F3-BE9E-23F4A7221782}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveBlobInfoGetResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveBlobInfoGetResult; safecall;
    function GetResults: XboxLive_Storage_IGameSaveBlobInfoGetResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveBlobInfoGetResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Gaming.XboxLive.Storage.IGameSaveBlobInfoQuery
  [WinRTClassNameAttribute(SXboxLive_Storage_GameSaveBlobInfoQuery)]
  XboxLive_Storage_IGameSaveBlobInfoQuery = interface(IInspectable)
  ['{9FDD74B2-EEEE-447B-A9D2-7F96C0F83208}']
    function GetBlobInfoAsync: IAsyncOperation_1__XboxLive_Storage_IGameSaveBlobInfoGetResult; overload; safecall;
    function GetBlobInfoAsync(startIndex: Cardinal; maxNumberOfItems: Cardinal): IAsyncOperation_1__XboxLive_Storage_IGameSaveBlobInfoGetResult; overload; safecall;
    function GetItemCountAsync: IAsyncOperation_1__Cardinal; safecall;
  end;

  // DualAPI Interface
  // Windows.Gaming.XboxLive.Storage.IGameSaveContainer
  [WinRTClassNameAttribute(SXboxLive_Storage_GameSaveContainer)]
  XboxLive_Storage_IGameSaveContainer = interface(IInspectable)
  ['{C3C08F89-563F-4ECD-9C6F-33FD0E323D10}']
    function get_Name: HSTRING; safecall;
    function get_Provider: XboxLive_Storage_IGameSaveProvider; safecall;
    function SubmitUpdatesAsync(blobsToWrite: IMapView_2__HSTRING__IBuffer; blobsToDelete: IIterable_1__HSTRING; displayName: HSTRING): IAsyncOperation_1__XboxLive_Storage_IGameSaveOperationResult; safecall;
    function ReadAsync(blobsToWrite: IMapView_2__HSTRING__IBuffer): IAsyncOperation_1__XboxLive_Storage_IGameSaveOperationResult; safecall;
    function GetAsync(blobsToRead: IIterable_1__HSTRING): IAsyncOperation_1__XboxLive_Storage_IGameSaveBlobGetResult; safecall;
    function SubmitPropertySetUpdatesAsync(blobsToWrite: IPropertySet; blobsToDelete: IIterable_1__HSTRING; displayName: HSTRING): IAsyncOperation_1__XboxLive_Storage_IGameSaveOperationResult; safecall;
    function CreateBlobInfoQuery(blobNamePrefix: HSTRING): XboxLive_Storage_IGameSaveBlobInfoQuery; safecall;
    property Name: HSTRING read get_Name;
    property Provider: XboxLive_Storage_IGameSaveProvider read get_Provider;
  end;

  // DualAPI Interface
  // Windows.Gaming.XboxLive.Storage.IGameSaveContainerInfo
  [WinRTClassNameAttribute(SXboxLive_Storage_GameSaveContainerInfo)]
  XboxLive_Storage_IGameSaveContainerInfo = interface(IInspectable)
  ['{B7E27300-155D-4BB4-B2BA-930306F391B5}']
    function get_Name: HSTRING; safecall;
    function get_TotalSize: UInt64; safecall;
    function get_DisplayName: HSTRING; safecall;
    function get_LastModifiedTime: DateTime; safecall;
    function get_NeedsSync: Boolean; safecall;
    property DisplayName: HSTRING read get_DisplayName;
    property LastModifiedTime: DateTime read get_LastModifiedTime;
    property Name: HSTRING read get_Name;
    property NeedsSync: Boolean read get_NeedsSync;
    property TotalSize: UInt64 read get_TotalSize;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Gaming.XboxLive.Storage.IGameSaveContainerInfo>
  IIterator_1__XboxLive_Storage_IGameSaveContainerInfo = interface(IInspectable)
  ['{AF3513D4-D746-5063-B0D7-41037770DEC4}']
    function get_Current: XboxLive_Storage_IGameSaveContainerInfo; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PXboxLive_Storage_IGameSaveContainerInfo): Cardinal; safecall;
    property Current: XboxLive_Storage_IGameSaveContainerInfo read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Gaming.XboxLive.Storage.IGameSaveContainerInfo>
  IIterable_1__XboxLive_Storage_IGameSaveContainerInfo = interface(IInspectable)
  ['{69260C3E-3765-5A0A-B8DC-5ECAC3E59562}']
    function First: IIterator_1__XboxLive_Storage_IGameSaveContainerInfo; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Gaming.XboxLive.Storage.IGameSaveContainerInfo>
  IVectorView_1__XboxLive_Storage_IGameSaveContainerInfo = interface(IInspectable)
  ['{6F745F09-1B7B-5C89-BB0E-27615D2533B7}']
    function GetAt(index: Cardinal): XboxLive_Storage_IGameSaveContainerInfo; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: XboxLive_Storage_IGameSaveContainerInfo; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PXboxLive_Storage_IGameSaveContainerInfo): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Gaming.XboxLive.Storage.IGameSaveContainerInfoGetResult
  [WinRTClassNameAttribute(SXboxLive_Storage_GameSaveContainerInfoGetResult)]
  XboxLive_Storage_IGameSaveContainerInfoGetResult = interface(IInspectable)
  ['{FFC50D74-C581-4F9D-9E39-30A10C1E4C50}']
    function get_Status: XboxLive_Storage_GameSaveErrorStatus; safecall;
    function get_Value: IVectorView_1__XboxLive_Storage_IGameSaveContainerInfo; safecall;
    property Status: XboxLive_Storage_GameSaveErrorStatus read get_Status;
    property Value: IVectorView_1__XboxLive_Storage_IGameSaveContainerInfo read get_Value;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Gaming.XboxLive.Storage.IGameSaveContainerInfoGetResult>
  AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveContainerInfoGetResult = interface(IUnknown)
  ['{5F16D0D4-91FD-5E75-957F-14C998E2A7F0}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__XboxLive_Storage_IGameSaveContainerInfoGetResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Gaming.XboxLive.Storage.IGameSaveContainerInfoGetResult>
  IAsyncOperation_1__XboxLive_Storage_IGameSaveContainerInfoGetResult = interface(IInspectable)
  ['{EC65EC4B-68E5-5026-B2D7-F94BD7485976}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveContainerInfoGetResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveContainerInfoGetResult; safecall;
    function GetResults: XboxLive_Storage_IGameSaveContainerInfoGetResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveContainerInfoGetResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Gaming.XboxLive.Storage.IGameSaveContainerInfoQuery
  [WinRTClassNameAttribute(SXboxLive_Storage_GameSaveContainerInfoQuery)]
  XboxLive_Storage_IGameSaveContainerInfoQuery = interface(IInspectable)
  ['{3C94E863-6F80-4327-9327-FFC11AFD42B3}']
    function GetContainerInfoAsync: IAsyncOperation_1__XboxLive_Storage_IGameSaveContainerInfoGetResult; overload; safecall;
    function GetContainerInfoAsync(startIndex: Cardinal; maxNumberOfItems: Cardinal): IAsyncOperation_1__XboxLive_Storage_IGameSaveContainerInfoGetResult; overload; safecall;
    function GetItemCountAsync: IAsyncOperation_1__Cardinal; safecall;
  end;

  // DualAPI Interface
  // Windows.Gaming.XboxLive.Storage.IGameSaveProvider
  [WinRTClassNameAttribute(SXboxLive_Storage_GameSaveProvider)]
  XboxLive_Storage_IGameSaveProvider = interface(IInspectable)
  ['{90A60394-80FE-4211-97F8-A5DE14DD95D2}']
    function get_User: IUser; safecall;
    function CreateContainer(name: HSTRING): XboxLive_Storage_IGameSaveContainer; safecall;
    function DeleteContainerAsync(name: HSTRING): IAsyncOperation_1__XboxLive_Storage_IGameSaveOperationResult; safecall;
    function CreateContainerInfoQuery: XboxLive_Storage_IGameSaveContainerInfoQuery; overload; safecall;
    function CreateContainerInfoQuery(containerNamePrefix: HSTRING): XboxLive_Storage_IGameSaveContainerInfoQuery; overload; safecall;
    function GetRemainingBytesInQuotaAsync: IAsyncOperation_1__Int64; safecall;
    function get_ContainersChangedSinceLastSync: IVectorView_1__HSTRING; safecall;
    property ContainersChangedSinceLastSync: IVectorView_1__HSTRING read get_ContainersChangedSinceLastSync;
    property User: IUser read get_User;
  end;

  // DualAPI Interface
  // Windows.Gaming.XboxLive.Storage.IGameSaveProviderGetResult
  [WinRTClassNameAttribute(SXboxLive_Storage_GameSaveProviderGetResult)]
  XboxLive_Storage_IGameSaveProviderGetResult = interface(IInspectable)
  ['{3AB90816-D393-4D65-AC16-41C3E67AB945}']
    function get_Status: XboxLive_Storage_GameSaveErrorStatus; safecall;
    function get_Value: XboxLive_Storage_IGameSaveProvider; safecall;
    property Status: XboxLive_Storage_GameSaveErrorStatus read get_Status;
    property Value: XboxLive_Storage_IGameSaveProvider read get_Value;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Gaming.XboxLive.Storage.IGameSaveProviderGetResult>
  AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveProviderGetResult = interface(IUnknown)
  ['{999C389C-8CF8-502E-BE10-9CA7449B0DAA}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__XboxLive_Storage_IGameSaveProviderGetResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Gaming.XboxLive.Storage.IGameSaveProviderGetResult>
  IAsyncOperation_1__XboxLive_Storage_IGameSaveProviderGetResult = interface(IInspectable)
  ['{8A84D67A-C1B5-5040-AE17-8818BB713E9C}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveProviderGetResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveProviderGetResult; safecall;
    function GetResults: XboxLive_Storage_IGameSaveProviderGetResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__XboxLive_Storage_IGameSaveProviderGetResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Gaming.XboxLive.Storage.IGameSaveProviderStatics
  [WinRTClassNameAttribute(SXboxLive_Storage_GameSaveProvider)]
  XboxLive_Storage_IGameSaveProviderStatics = interface(IInspectable)
  ['{D01D3ED0-7B03-449D-8CBD-3402842A1048}']
    function GetForUserAsync(user: IUser; serviceConfigId: HSTRING): IAsyncOperation_1__XboxLive_Storage_IGameSaveProviderGetResult; safecall;
    function GetSyncOnDemandForUserAsync(user: IUser; serviceConfigId: HSTRING): IAsyncOperation_1__XboxLive_Storage_IGameSaveProviderGetResult; safecall;
  end;

  // Windows.Gaming.Preview.GamesEnumeration.GameListRemovedEventHandler
  Preview_GamesEnumeration_GameListRemovedEventHandler = interface(IUnknown)
  ['{10C5648F-6C8F-4712-9B38-474BC22E76D8}']
    procedure Invoke(identifier: HSTRING); safecall;
  end;


  // Emit Forwarded classes
  // Windows.Gaming.XboxLive.Storage.GameSaveContainer
  // DualAPI

  // Windows.Gaming.XboxLive.Storage.GameSaveOperationResult
  // DualAPI

  // Windows.Gaming.XboxLive.Storage.GameSaveContainerInfoQuery
  // DualAPI

  // Windows.Gaming.XboxLive.Storage.GameSaveProviderGetResult
  // DualAPI

  // Windows.Gaming.XboxLive.Storage.GameSaveProvider
  // DualAPI
  TXboxLive_Storage_GameSaveProvider = class(TWinRTGenericImportS<XboxLive_Storage_IGameSaveProviderStatics>)
  public
    // -> XboxLive_Storage_IGameSaveProviderStatics
    class function GetForUserAsync(user: IUser; serviceConfigId: HSTRING): IAsyncOperation_1__XboxLive_Storage_IGameSaveProviderGetResult; static; inline;
    class function GetSyncOnDemandForUserAsync(user: IUser; serviceConfigId: HSTRING): IAsyncOperation_1__XboxLive_Storage_IGameSaveProviderGetResult; static; inline;
  end;

  // Windows.Gaming.XboxLive.Storage.GameSaveBlobGetResult
  // DualAPI

  // Windows.Gaming.XboxLive.Storage.GameSaveBlobInfoQuery
  // DualAPI

  // Windows.Gaming.XboxLive.Storage.GameSaveContainerInfo
  // DualAPI

  // Windows.Gaming.XboxLive.Storage.GameSaveBlobInfo
  // DualAPI

  // Windows.Gaming.XboxLive.Storage.GameSaveContainerInfoGetResult
  // DualAPI

  // Windows.Gaming.XboxLive.Storage.GameSaveBlobInfoGetResult
  // DualAPI


implementation

  // Emit Classes Implementation
 { TXboxLive_Storage_GameSaveProvider }

class function TXboxLive_Storage_GameSaveProvider.GetForUserAsync(user: IUser; serviceConfigId: HSTRING): IAsyncOperation_1__XboxLive_Storage_IGameSaveProviderGetResult;
begin
  Result := Statics.GetForUserAsync(user, serviceConfigId);
end;

class function TXboxLive_Storage_GameSaveProvider.GetSyncOnDemandForUserAsync(user: IUser; serviceConfigId: HSTRING): IAsyncOperation_1__XboxLive_Storage_IGameSaveProviderGetResult;
begin
  Result := Statics.GetSyncOnDemandForUserAsync(user, serviceConfigId);
end;



end.
