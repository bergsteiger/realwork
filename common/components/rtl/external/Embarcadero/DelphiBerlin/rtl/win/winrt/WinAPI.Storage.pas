{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Storage;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
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
  // Windows.Storage Class Names
  // Windows.Storage.FileProperties.GeotagHelper
  // DualAPI
  SFileProperties_GeotagHelper = 'Windows.Storage.FileProperties.GeotagHelper';
  // Windows.Storage.StorageFile
  // WinRT Only
  // WhiteListed
  SStorageFile = 'Windows.Storage.StorageFile';
  // Windows.Storage.ApplicationData
  // DualAPI
  SApplicationData = 'Windows.Storage.ApplicationData';
  // Windows.Storage.SetVersionRequest
  // DualAPI
  SSetVersionRequest = 'Windows.Storage.SetVersionRequest';
  // Windows.Storage.ApplicationDataContainer
  // DualAPI
  SApplicationDataContainer = 'Windows.Storage.ApplicationDataContainer';
  // Windows.Storage.SetVersionDeferral
  // DualAPI
  SSetVersionDeferral = 'Windows.Storage.SetVersionDeferral';
  // Windows.Storage.ApplicationDataContainerSettings
  // DualAPI
  SApplicationDataContainerSettings = 'Windows.Storage.ApplicationDataContainerSettings';
  // Windows.Storage.ApplicationDataCompositeValue
  // DualAPI
  SApplicationDataCompositeValue = 'Windows.Storage.ApplicationDataCompositeValue';
  // Windows.Storage.Compression.Compressor
  // DualAPI
  SCompression_Compressor = 'Windows.Storage.Compression.Compressor';
  // Windows.Storage.Compression.Decompressor
  // DualAPI
  SCompression_Decompressor = 'Windows.Storage.Compression.Decompressor';


type
  // Forward declare interfaces
  // Windows.Storage.FileProperties.IBasicProperties
  FileProperties_IBasicProperties = interface;
  PFileProperties_IBasicProperties = ^FileProperties_IBasicProperties;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.FileProperties.IBasicProperties>
  AsyncOperationCompletedHandler_1__FileProperties_IBasicProperties = interface;
  PAsyncOperationCompletedHandler_1__FileProperties_IBasicProperties = ^AsyncOperationCompletedHandler_1__FileProperties_IBasicProperties;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.FileProperties.IBasicProperties>
  IAsyncOperation_1__FileProperties_IBasicProperties = interface;
  PIAsyncOperation_1__FileProperties_IBasicProperties = ^IAsyncOperation_1__FileProperties_IBasicProperties;

  // Windows.Storage.IStorageItem
  IStorageItem = interface;
  PIStorageItem = ^IStorageItem;

  // Windows.Storage.IStorageStreamTransaction
  IStorageStreamTransaction = interface;
  PIStorageStreamTransaction = ^IStorageStreamTransaction;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.IStorageStreamTransaction>
  AsyncOperationCompletedHandler_1__IStorageStreamTransaction = interface;
  PAsyncOperationCompletedHandler_1__IStorageStreamTransaction = ^AsyncOperationCompletedHandler_1__IStorageStreamTransaction;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.IStorageStreamTransaction>
  IAsyncOperation_1__IStorageStreamTransaction = interface;
  PIAsyncOperation_1__IStorageStreamTransaction = ^IAsyncOperation_1__IStorageStreamTransaction;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.IStorageFolder>
  AsyncOperationCompletedHandler_1__IStorageFolder = interface;
  PAsyncOperationCompletedHandler_1__IStorageFolder = ^AsyncOperationCompletedHandler_1__IStorageFolder;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.IStorageFolder>
  IAsyncOperation_1__IStorageFolder = interface;
  PIAsyncOperation_1__IStorageFolder = ^IAsyncOperation_1__IStorageFolder;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.IStorageItem>
  AsyncOperationCompletedHandler_1__IStorageItem = interface;
  PAsyncOperationCompletedHandler_1__IStorageItem = ^AsyncOperationCompletedHandler_1__IStorageItem;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.IStorageItem>
  IAsyncOperation_1__IStorageItem = interface;
  PIAsyncOperation_1__IStorageItem = ^IAsyncOperation_1__IStorageItem;

  // Windows.Foundation.Collections.IIterator`1<Windows.Storage.IStorageFile>
  IIterator_1__IStorageFile = interface;
  PIIterator_1__IStorageFile = ^IIterator_1__IStorageFile;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageFile>
  IVectorView_1__IStorageFile = interface;
  PIVectorView_1__IStorageFile = ^IVectorView_1__IStorageFile;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageFile>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IStorageFile = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__IStorageFile = ^AsyncOperationCompletedHandler_1__IVectorView_1__IStorageFile;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageFile>>
  IAsyncOperation_1__IVectorView_1__IStorageFile = interface;
  PIAsyncOperation_1__IVectorView_1__IStorageFile = ^IAsyncOperation_1__IVectorView_1__IStorageFile;

  // Windows.Foundation.Collections.IIterator`1<Windows.Storage.IStorageFolder>
  IIterator_1__IStorageFolder = interface;
  PIIterator_1__IStorageFolder = ^IIterator_1__IStorageFolder;

  // Windows.Foundation.Collections.IIterable`1<Windows.Storage.IStorageFolder>
  IIterable_1__IStorageFolder = interface;
  PIIterable_1__IStorageFolder = ^IIterable_1__IStorageFolder;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageFolder>
  IVectorView_1__IStorageFolder = interface;
  PIVectorView_1__IStorageFolder = ^IVectorView_1__IStorageFolder;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageFolder>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IStorageFolder = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__IStorageFolder = ^AsyncOperationCompletedHandler_1__IVectorView_1__IStorageFolder;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageFolder>>
  IAsyncOperation_1__IVectorView_1__IStorageFolder = interface;
  PIAsyncOperation_1__IVectorView_1__IStorageFolder = ^IAsyncOperation_1__IVectorView_1__IStorageFolder;

  // Windows.Foundation.Collections.IIterator`1<Windows.Storage.IStorageItem>
  IIterator_1__IStorageItem = interface;
  PIIterator_1__IStorageItem = ^IIterator_1__IStorageItem;

  // Windows.Foundation.Collections.IIterable`1<Windows.Storage.IStorageItem>
  IIterable_1__IStorageItem = interface;
  PIIterable_1__IStorageItem = ^IIterable_1__IStorageItem;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageItem>
  IVectorView_1__IStorageItem = interface;
  PIVectorView_1__IStorageItem = ^IVectorView_1__IStorageItem;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageItem>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IStorageItem = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__IStorageItem = ^AsyncOperationCompletedHandler_1__IVectorView_1__IStorageItem;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageItem>>
  IAsyncOperation_1__IVectorView_1__IStorageItem = interface;
  PIAsyncOperation_1__IVectorView_1__IStorageItem = ^IAsyncOperation_1__IVectorView_1__IStorageItem;

  // Windows.Storage.IStorageFolder
  IStorageFolder = interface;
  PIStorageFolder = ^IStorageFolder;

  // Windows.Storage.IStorageFile
  IStorageFile = interface;
  PIStorageFile = ^IStorageFile;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.IStorageFile>
  AsyncOperationCompletedHandler_1__IStorageFile = interface;
  PAsyncOperationCompletedHandler_1__IStorageFile = ^AsyncOperationCompletedHandler_1__IStorageFile;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.IStorageFile>
  IAsyncOperation_1__IStorageFile = interface;
  PIAsyncOperation_1__IStorageFile = ^IAsyncOperation_1__IStorageFile;

  // Windows.Foundation.Collections.IVector`1<Windows.Storage.IStorageFolder>
  IVector_1__IStorageFolder = interface;
  PIVector_1__IStorageFolder = ^IVector_1__IStorageFolder;

  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.Storage.IStorageFolder>
  VectorChangedEventHandler_1__IStorageFolder = interface;
  PVectorChangedEventHandler_1__IStorageFolder = ^VectorChangedEventHandler_1__IStorageFolder;

  // Windows.Foundation.Collections.IObservableVector`1<Windows.Storage.IStorageFolder>
  IObservableVector_1__IStorageFolder = interface;
  PIObservableVector_1__IStorageFolder = ^IObservableVector_1__IStorageFolder;

  // Windows.Foundation.Collections.IIterator`1<Windows.Storage.Search.SortEntry>
  IIterator_1__Search_SortEntry = interface;
  PIIterator_1__Search_SortEntry = ^IIterator_1__Search_SortEntry;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Storage.Search.SortEntry>
  IVectorView_1__Search_SortEntry = interface;
  PIVectorView_1__Search_SortEntry = ^IVectorView_1__Search_SortEntry;

  // Windows.Storage.ISetVersionDeferral
  ISetVersionDeferral = interface;
  PISetVersionDeferral = ^ISetVersionDeferral;

  // Windows.Storage.ISetVersionRequest
  ISetVersionRequest = interface;
  PISetVersionRequest = ^ISetVersionRequest;

  // Windows.Storage.ApplicationDataSetVersionHandler
  ApplicationDataSetVersionHandler = interface;
  PApplicationDataSetVersionHandler = ^ApplicationDataSetVersionHandler;

  // Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.IApplicationDataContainer>
  IKeyValuePair_2__HSTRING__IApplicationDataContainer = interface;
  PIKeyValuePair_2__HSTRING__IApplicationDataContainer = ^IKeyValuePair_2__HSTRING__IApplicationDataContainer;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.IApplicationDataContainer>>
  IIterator_1__IKeyValuePair_2__HSTRING__IApplicationDataContainer = interface;
  PIIterator_1__IKeyValuePair_2__HSTRING__IApplicationDataContainer = ^IIterator_1__IKeyValuePair_2__HSTRING__IApplicationDataContainer;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.IApplicationDataContainer>>
  IIterable_1__IKeyValuePair_2__HSTRING__IApplicationDataContainer = interface;
  PIIterable_1__IKeyValuePair_2__HSTRING__IApplicationDataContainer = ^IIterable_1__IKeyValuePair_2__HSTRING__IApplicationDataContainer;

  // Windows.Foundation.Collections.IMapView`2<String,Windows.Storage.IApplicationDataContainer>
  IMapView_2__HSTRING__IApplicationDataContainer = interface;
  PIMapView_2__HSTRING__IApplicationDataContainer = ^IMapView_2__HSTRING__IApplicationDataContainer;

  // Windows.Storage.IApplicationDataContainer
  IApplicationDataContainer = interface;
  PIApplicationDataContainer = ^IApplicationDataContainer;

  // Windows.Foundation.TypedEventHandler`2<Windows.Storage.IApplicationData,Object>
  TypedEventHandler_2__IApplicationData__IInspectable = interface;
  PTypedEventHandler_2__IApplicationData__IInspectable = ^TypedEventHandler_2__IApplicationData__IInspectable;

  // Windows.Storage.IApplicationData
  IApplicationData = interface;
  PIApplicationData = ^IApplicationData;

  // Windows.Storage.FileProperties.IMusicProperties
  FileProperties_IMusicProperties = interface;
  PFileProperties_IMusicProperties = ^FileProperties_IMusicProperties;

  // Windows.Storage.FileProperties.IVideoProperties
  FileProperties_IVideoProperties = interface;
  PFileProperties_IVideoProperties = ^FileProperties_IVideoProperties;

  // Windows.Foundation.Collections.IVector`1<Windows.Storage.IStorageFile>
  IVector_1__IStorageFile = interface;
  PIVector_1__IStorageFile = ^IVector_1__IStorageFile;

  // Windows.Storage.FileProperties.IGeotagHelperStatics
  FileProperties_IGeotagHelperStatics = interface;
  PFileProperties_IGeotagHelperStatics = ^FileProperties_IGeotagHelperStatics;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.FileProperties.IMusicProperties>
  AsyncOperationCompletedHandler_1__FileProperties_IMusicProperties = interface;
  PAsyncOperationCompletedHandler_1__FileProperties_IMusicProperties = ^AsyncOperationCompletedHandler_1__FileProperties_IMusicProperties;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.FileProperties.IMusicProperties>
  IAsyncOperation_1__FileProperties_IMusicProperties = interface;
  PIAsyncOperation_1__FileProperties_IMusicProperties = ^IAsyncOperation_1__FileProperties_IMusicProperties;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.FileProperties.IVideoProperties>
  AsyncOperationCompletedHandler_1__FileProperties_IVideoProperties = interface;
  PAsyncOperationCompletedHandler_1__FileProperties_IVideoProperties = ^AsyncOperationCompletedHandler_1__FileProperties_IVideoProperties;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.FileProperties.IVideoProperties>
  IAsyncOperation_1__FileProperties_IVideoProperties = interface;
  PIAsyncOperation_1__FileProperties_IVideoProperties = ^IAsyncOperation_1__FileProperties_IVideoProperties;

  // Windows.Storage.FileProperties.IImageProperties
  FileProperties_IImageProperties = interface;
  PFileProperties_IImageProperties = ^FileProperties_IImageProperties;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.FileProperties.IImageProperties>
  AsyncOperationCompletedHandler_1__FileProperties_IImageProperties = interface;
  PAsyncOperationCompletedHandler_1__FileProperties_IImageProperties = ^AsyncOperationCompletedHandler_1__FileProperties_IImageProperties;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.FileProperties.IImageProperties>
  IAsyncOperation_1__FileProperties_IImageProperties = interface;
  PIAsyncOperation_1__FileProperties_IImageProperties = ^IAsyncOperation_1__FileProperties_IImageProperties;

  // Windows.Storage.FileProperties.IDocumentProperties
  FileProperties_IDocumentProperties = interface;
  PFileProperties_IDocumentProperties = ^FileProperties_IDocumentProperties;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.FileProperties.IDocumentProperties>
  AsyncOperationCompletedHandler_1__FileProperties_IDocumentProperties = interface;
  PAsyncOperationCompletedHandler_1__FileProperties_IDocumentProperties = ^AsyncOperationCompletedHandler_1__FileProperties_IDocumentProperties;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.FileProperties.IDocumentProperties>
  IAsyncOperation_1__FileProperties_IDocumentProperties = interface;
  PIAsyncOperation_1__FileProperties_IDocumentProperties = ^IAsyncOperation_1__FileProperties_IDocumentProperties;

  // Windows.Storage.FileProperties.IStorageItemContentProperties
  FileProperties_IStorageItemContentProperties = interface;
  PFileProperties_IStorageItemContentProperties = ^FileProperties_IStorageItemContentProperties;

  // Windows.Storage.StreamedFileDataRequestedHandler
  StreamedFileDataRequestedHandler = interface;
  PStreamedFileDataRequestedHandler = ^StreamedFileDataRequestedHandler;

  // Windows.Storage.IStorageFileStatics
  IStorageFileStatics = interface;
  PIStorageFileStatics = ^IStorageFileStatics;

  // Windows.Storage.IStorageItem2
  IStorageItem2 = interface;
  PIStorageItem2 = ^IStorageItem2;

  // Windows.Storage.IStorageItemProperties
  IStorageItemProperties = interface;
  PIStorageItemProperties = ^IStorageItemProperties;

  // Windows.Storage.IStorageItemProperties2
  IStorageItemProperties2 = interface;
  PIStorageItemProperties2 = ^IStorageItemProperties2;

  // Windows.Storage.IStorageProvider
  IStorageProvider = interface;
  PIStorageProvider = ^IStorageProvider;

  // Windows.Storage.IStorageItemPropertiesWithProvider
  IStorageItemPropertiesWithProvider = interface;
  PIStorageItemPropertiesWithProvider = ^IStorageItemPropertiesWithProvider;

  // Windows.Storage.IStorageFilePropertiesWithAvailability
  IStorageFilePropertiesWithAvailability = interface;
  PIStorageFilePropertiesWithAvailability = ^IStorageFilePropertiesWithAvailability;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Search.IndexedState>
  AsyncOperationCompletedHandler_1__Search_IndexedState = interface;
  PAsyncOperationCompletedHandler_1__Search_IndexedState = ^AsyncOperationCompletedHandler_1__Search_IndexedState;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Search.IndexedState>
  IAsyncOperation_1__Search_IndexedState = interface;
  PIAsyncOperation_1__Search_IndexedState = ^IAsyncOperation_1__Search_IndexedState;

  // Windows.Storage.IStorageFile2
  IStorageFile2 = interface;
  PIStorageFile2 = ^IStorageFile2;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Provider.FileUpdateStatus>
  AsyncOperationCompletedHandler_1__Provider_FileUpdateStatus = interface;
  PAsyncOperationCompletedHandler_1__Provider_FileUpdateStatus = ^AsyncOperationCompletedHandler_1__Provider_FileUpdateStatus;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Provider.FileUpdateStatus>
  IAsyncOperation_1__Provider_FileUpdateStatus = interface;
  PIAsyncOperation_1__Provider_FileUpdateStatus = ^IAsyncOperation_1__Provider_FileUpdateStatus;

  // Windows.Foundation.Collections.IIterator`1<Windows.Storage.AccessCache.AccessListEntry>
  IIterator_1__AccessCache_AccessListEntry = interface;
  PIIterator_1__AccessCache_AccessListEntry = ^IIterator_1__AccessCache_AccessListEntry;

  // Windows.Storage.IApplicationDataStatics
  IApplicationDataStatics = interface;
  PIApplicationDataStatics = ^IApplicationDataStatics;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.IApplicationData>
  AsyncOperationCompletedHandler_1__IApplicationData = interface;
  PAsyncOperationCompletedHandler_1__IApplicationData = ^AsyncOperationCompletedHandler_1__IApplicationData;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.IApplicationData>
  IAsyncOperation_1__IApplicationData = interface;
  PIAsyncOperation_1__IApplicationData = ^IAsyncOperation_1__IApplicationData;

  // Windows.Storage.IApplicationDataStatics2
  IApplicationDataStatics2 = interface;
  PIApplicationDataStatics2 = ^IApplicationDataStatics2;

  // Windows.Storage.IApplicationData2
  IApplicationData2 = interface;
  PIApplicationData2 = ^IApplicationData2;

  // Windows.Storage.IApplicationData3
  IApplicationData3 = interface;
  PIApplicationData3 = ^IApplicationData3;

  // Windows.Storage.Compression.ICompressor
  Compression_ICompressor = interface;
  PCompression_ICompressor = ^Compression_ICompressor;

  // Windows.Storage.Compression.IDecompressor
  Compression_IDecompressor = interface;
  PCompression_IDecompressor = ^Compression_IDecompressor;

  // Windows.Storage.Compression.ICompressorFactory
  Compression_ICompressorFactory = interface;
  PCompression_ICompressorFactory = ^Compression_ICompressorFactory;

  // Windows.Storage.Compression.IDecompressorFactory
  Compression_IDecompressorFactory = interface;
  PCompression_IDecompressorFactory = ^Compression_IDecompressorFactory;

  // Windows.Foundation.Collections.IVector`1<Windows.Storage.IStorageItem>
  IVector_1__IStorageItem = interface;
  PIVector_1__IStorageItem = ^IVector_1__IStorageItem;


  // Emit Forwarded interfaces
  // Windows.Storage Interfaces
  // Windows.Storage.FileProperties.IBasicProperties
  FileProperties_IBasicProperties = interface(IInspectable)
  ['{D05D55DB-785E-4A66-BE02-9BEEC58AEA81}']
    function get_Size: UInt64; safecall;
    function get_DateModified: DateTime; safecall;
    function get_ItemDate: DateTime; safecall;
    property DateModified: DateTime read get_DateModified;
    property ItemDate: DateTime read get_ItemDate;
    property Size: UInt64 read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.FileProperties.IBasicProperties>
  AsyncOperationCompletedHandler_1__FileProperties_IBasicProperties_Delegate_Base = interface(IUnknown)
  ['{C8659AAE-4926-52AD-8F60-D89FE5A8DF5F}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.FileProperties.IBasicProperties>
  AsyncOperationCompletedHandler_1__FileProperties_IBasicProperties = interface(AsyncOperationCompletedHandler_1__FileProperties_IBasicProperties_Delegate_Base)
  ['{129B0F62-E176-5FB1-A3B9-69FEEE1BFB29}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__FileProperties_IBasicProperties; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.FileProperties.IBasicProperties>
  IAsyncOperation_1__FileProperties_IBasicProperties_Base = interface(IInspectable)
  ['{5186131A-4467-504B-977A-0785A8230485}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.FileProperties.IBasicProperties>
  IAsyncOperation_1__FileProperties_IBasicProperties = interface(IAsyncOperation_1__FileProperties_IBasicProperties_Base)
  ['{ADA07FD2-C777-5490-BD12-C0E6D722EAD7}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__FileProperties_IBasicProperties); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__FileProperties_IBasicProperties; safecall;
    function GetResults: FileProperties_IBasicProperties; safecall;
    property Completed: AsyncOperationCompletedHandler_1__FileProperties_IBasicProperties read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Storage.IStorageItem
  IStorageItem = interface(IInspectable)
  ['{4207A996-CA2F-42F7-BDE8-8B10457A7F30}']
    function RenameAsync(desiredName: HSTRING): IAsyncAction; overload; safecall;
    function RenameAsync(desiredName: HSTRING; option: NameCollisionOption): IAsyncAction; overload; safecall;
    function DeleteAsync: IAsyncAction; overload; safecall;
    function DeleteAsync(option: StorageDeleteOption): IAsyncAction; overload; safecall;
    function GetBasicPropertiesAsync: IAsyncOperation_1__FileProperties_IBasicProperties; safecall;
    function get_Name: HSTRING; safecall;
    function get_Path: HSTRING; safecall;
    function get_Attributes: FileAttributes; safecall;
    function get_DateCreated: DateTime; safecall;
    function IsOfType(&type: StorageItemTypes): Boolean; safecall;
    property Attributes: FileAttributes read get_Attributes;
    property DateCreated: DateTime read get_DateCreated;
    property Name: HSTRING read get_Name;
    property Path: HSTRING read get_Path;
  end;

  // Windows.Storage.IStorageStreamTransaction
  IStorageStreamTransaction = interface(IInspectable)
  ['{F67CF363-A53D-4D94-AE2C-67232D93ACDD}']
    function get_Stream: IRandomAccessStream; safecall;
    function CommitAsync: IAsyncAction; safecall;
    property Stream: IRandomAccessStream read get_Stream;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.IStorageStreamTransaction>
  AsyncOperationCompletedHandler_1__IStorageStreamTransaction_Delegate_Base = interface(IUnknown)
  ['{D11739E6-2995-5D33-BFFF-51B6041F68C1}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.IStorageStreamTransaction>
  AsyncOperationCompletedHandler_1__IStorageStreamTransaction = interface(AsyncOperationCompletedHandler_1__IStorageStreamTransaction_Delegate_Base)
  ['{4F03213E-DFDA-5E67-98AC-0D139B467B19}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IStorageStreamTransaction; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.IStorageStreamTransaction>
  IAsyncOperation_1__IStorageStreamTransaction_Base = interface(IInspectable)
  ['{0D81405A-9BD3-5E87-82F4-9B4128A887EB}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.IStorageStreamTransaction>
  IAsyncOperation_1__IStorageStreamTransaction = interface(IAsyncOperation_1__IStorageStreamTransaction_Base)
  ['{C5926392-4ECC-526D-BBC1-725AE3F7C449}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IStorageStreamTransaction); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IStorageStreamTransaction; safecall;
    function GetResults: IStorageStreamTransaction; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IStorageStreamTransaction read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.IStorageFolder>
  AsyncOperationCompletedHandler_1__IStorageFolder_Delegate_Base = interface(IUnknown)
  ['{C211026E-9E63-5452-BA54-3A07D6A96874}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.IStorageFolder>
  AsyncOperationCompletedHandler_1__IStorageFolder = interface(AsyncOperationCompletedHandler_1__IStorageFolder_Delegate_Base)
  ['{8254DF53-F8CD-570A-AEB9-F2C0AD5368AC}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IStorageFolder; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.IStorageFolder>
  IAsyncOperation_1__IStorageFolder_Base = interface(IInspectable)
  ['{6BE9E7D7-E83A-5CBC-802C-1768960B52C3}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.IStorageFolder>
  IAsyncOperation_1__IStorageFolder = interface(IAsyncOperation_1__IStorageFolder_Base)
  ['{68EA25EA-D88C-5DB0-A24A-BBCBDFCD3ECC}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IStorageFolder); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IStorageFolder; safecall;
    function GetResults: IStorageFolder; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IStorageFolder read get_Completed write put_Completed;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.IStorageItem>
  AsyncOperationCompletedHandler_1__IStorageItem = interface(IUnknown)
  ['{92C3102F-A327-5318-A6C1-76F6B2A0ABFB}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IStorageItem; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.IStorageItem>
  IAsyncOperation_1__IStorageItem = interface(IInspectable)
  ['{5FC9C137-EBB7-5E6C-9CBA-686F2EC2B0BB}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IStorageItem); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IStorageItem; safecall;
    function GetResults: IStorageItem; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IStorageItem read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Storage.IStorageFile>
  IIterator_1__IStorageFile = interface(IInspectable)
  ['{314D2318-74EE-535C-B361-2144DBC573A0}']
    function get_Current: IStorageFile; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIStorageFile): Cardinal; safecall;
    property Current: IStorageFile read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageFile>
  IVectorView_1__IStorageFile = interface(IInspectable)
  ['{4296B6E8-E219-5E74-8DDE-196F57200A82}']
    function GetAt(index: Cardinal): IStorageFile; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IStorageFile; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIStorageFile): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageFile>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IStorageFile_Delegate_Base = interface(IUnknown)
  ['{CB4206C5-0988-5104-AFA9-253C298F86FD}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageFile>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IStorageFile = interface(AsyncOperationCompletedHandler_1__IVectorView_1__IStorageFile_Delegate_Base)
  ['{3B203E3A-6A0E-5FA3-A300-EAF350152625}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__IStorageFile; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageFile>>
  IAsyncOperation_1__IVectorView_1__IStorageFile_Base = interface(IInspectable)
  ['{03362E33-E413-5F29-97D0-48A4780935F9}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageFile>>
  IAsyncOperation_1__IVectorView_1__IStorageFile = interface(IAsyncOperation_1__IVectorView_1__IStorageFile_Base)
  ['{9751F304-CBA2-5A44-890D-0DBD9F173C43}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__IStorageFile); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IStorageFile; safecall;
    function GetResults: IVectorView_1__IStorageFile; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IStorageFile read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Storage.IStorageFolder>
  IIterator_1__IStorageFolder = interface(IInspectable)
  ['{73E42360-10FC-513C-9C38-D7FB007ABBC4}']
    function get_Current: IStorageFolder; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIStorageFolder): Cardinal; safecall;
    property Current: IStorageFolder read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Storage.IStorageFolder>
  IIterable_1__IStorageFolder_Base = interface(IInspectable)
  ['{4669BEFC-AE5C-52B1-8A97-5466CE61E94E}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Storage.IStorageFolder>
  IIterable_1__IStorageFolder = interface(IIterable_1__IStorageFolder_Base)
  ['{D09B688F-402A-5B3F-B552-1FFA23116952}']
    function First: IIterator_1__IStorageFolder; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageFolder>
  IVectorView_1__IStorageFolder = interface(IInspectable)
  ['{6A8C9209-6392-5B08-AEE9-F2ADD7DECC49}']
    function GetAt(index: Cardinal): IStorageFolder; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IStorageFolder; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIStorageFolder): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageFolder>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IStorageFolder_Delegate_Base = interface(IUnknown)
  ['{ED2D1D9B-26EC-5BE7-A8A3-56458933D25F}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageFolder>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IStorageFolder = interface(AsyncOperationCompletedHandler_1__IVectorView_1__IStorageFolder_Delegate_Base)
  ['{AEF07EE0-9203-543D-90C9-088DE0DF94E4}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__IStorageFolder; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageFolder>>
  IAsyncOperation_1__IVectorView_1__IStorageFolder_Base = interface(IInspectable)
  ['{CA40B21B-AEB1-5A61-9E08-3BD5D9594023}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageFolder>>
  IAsyncOperation_1__IVectorView_1__IStorageFolder = interface(IAsyncOperation_1__IVectorView_1__IStorageFolder_Base)
  ['{A4D504A3-0D7B-5497-B35F-0889A2AF16FD}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__IStorageFolder); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IStorageFolder; safecall;
    function GetResults: IVectorView_1__IStorageFolder; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IStorageFolder read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Storage.IStorageItem>
  IIterator_1__IStorageItem = interface(IInspectable)
  ['{05B487C2-3830-5D3C-98DA-25FA11542DBD}']
    function get_Current: IStorageItem; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIStorageItem): Cardinal; safecall;
    property Current: IStorageItem read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Storage.IStorageItem>
  IIterable_1__IStorageItem = interface(IInspectable)
  ['{BB8B8418-65D1-544B-B083-6D172F568C73}']
    function First: IIterator_1__IStorageItem; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageItem>
  IVectorView_1__IStorageItem = interface(IInspectable)
  ['{85575A41-06CB-58D0-B98A-7C8F06E6E9D7}']
    function GetAt(index: Cardinal): IStorageItem; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IStorageItem; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIStorageItem): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageItem>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IStorageItem = interface(IUnknown)
  ['{51436E75-ACE1-5A68-B260-F843B846F0DB}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__IStorageItem; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.IStorageItem>>
  IAsyncOperation_1__IVectorView_1__IStorageItem = interface(IInspectable)
  ['{4B1C0FD7-7A01-5E7A-A6FE-BE4500283F23}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__IStorageItem); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IStorageItem; safecall;
    function GetResults: IVectorView_1__IStorageItem; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IStorageItem read get_Completed write put_Completed;
  end;

  // Windows.Storage.IStorageFolder
  IStorageFolder = interface(IInspectable)
  ['{72D1CB78-B3EF-4F75-A80B-6FD9DAE2944B}']
    function CreateFileAsync(desiredName: HSTRING): IAsyncOperation_1__IStorageFile; overload; safecall;
    function CreateFileAsync(desiredName: HSTRING; options: CreationCollisionOption): IAsyncOperation_1__IStorageFile; overload; safecall;
    function CreateFolderAsync(desiredName: HSTRING): IAsyncOperation_1__IStorageFolder; overload; safecall;
    function CreateFolderAsync(desiredName: HSTRING; options: CreationCollisionOption): IAsyncOperation_1__IStorageFolder; overload; safecall;
    function GetFileAsync(name: HSTRING): IAsyncOperation_1__IStorageFile; safecall;
    function GetFolderAsync(name: HSTRING): IAsyncOperation_1__IStorageFolder; safecall;
    function GetItemAsync(name: HSTRING): IAsyncOperation_1__IStorageItem; safecall;
    function GetFilesAsync: IAsyncOperation_1__IVectorView_1__IStorageFile; safecall;
    function GetFoldersAsync: IAsyncOperation_1__IVectorView_1__IStorageFolder; safecall;
    function GetItemsAsync: IAsyncOperation_1__IVectorView_1__IStorageItem; safecall;
  end;

  // DualAPI Interface
  // Windows.Storage.IStorageFile
  [WinRTClassNameAttribute(SStorageFile)]
  IStorageFile = interface(IInspectable)
  ['{FA3F6186-4214-428C-A64C-14C9AC7315EA}']
    function get_FileType: HSTRING; safecall;
    function get_ContentType: HSTRING; safecall;
    function OpenAsync(accessMode: FileAccessMode): IAsyncOperation_1__IRandomAccessStream; safecall;
    function OpenTransactedWriteAsync: IAsyncOperation_1__IStorageStreamTransaction; safecall;
    function CopyAsync(destinationFolder: IStorageFolder): IAsyncOperation_1__IStorageFile; overload; safecall;
    function CopyAsync(destinationFolder: IStorageFolder; desiredNewName: HSTRING): IAsyncOperation_1__IStorageFile; overload; safecall;
    function CopyAsync(destinationFolder: IStorageFolder; desiredNewName: HSTRING; option: NameCollisionOption): IAsyncOperation_1__IStorageFile; overload; safecall;
    function CopyAndReplaceAsync(fileToReplace: IStorageFile): IAsyncAction; safecall;
    function MoveAsync(destinationFolder: IStorageFolder): IAsyncAction; overload; safecall;
    function MoveAsync(destinationFolder: IStorageFolder; desiredNewName: HSTRING): IAsyncAction; overload; safecall;
    function MoveAsync(destinationFolder: IStorageFolder; desiredNewName: HSTRING; option: NameCollisionOption): IAsyncAction; overload; safecall;
    function MoveAndReplaceAsync(fileToReplace: IStorageFile): IAsyncAction; safecall;
    property ContentType: HSTRING read get_ContentType;
    property FileType: HSTRING read get_FileType;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.IStorageFile>
  AsyncOperationCompletedHandler_1__IStorageFile_Delegate_Base = interface(IUnknown)
  ['{E521C894-2C26-5946-9E61-2B5E188D01ED}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.IStorageFile>
  AsyncOperationCompletedHandler_1__IStorageFile = interface(AsyncOperationCompletedHandler_1__IStorageFile_Delegate_Base)
  ['{1247300D-7973-53D5-889F-5279D9322114}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IStorageFile; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.IStorageFile>
  IAsyncOperation_1__IStorageFile_Base = interface(IInspectable)
  ['{5E52F8CE-ACED-5A42-95B4-F674DD84885E}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.IStorageFile>
  IAsyncOperation_1__IStorageFile = interface(IAsyncOperation_1__IStorageFile_Base)
  ['{31C5C3AB-4BF6-51D1-B590-C6EFC00E9FF2}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IStorageFile); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IStorageFile; safecall;
    function GetResults: IStorageFile; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IStorageFile read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Storage.IStorageFolder>
  IVector_1__IStorageFolder = interface(IInspectable)
  ['{AD736464-7886-5872-88E3-395643C94759}']
    function GetAt(index: Cardinal): IStorageFolder; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__IStorageFolder; safecall;
    function IndexOf(value: IStorageFolder; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: IStorageFolder); safecall;
    procedure InsertAt(index: Cardinal; value: IStorageFolder); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: IStorageFolder); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIStorageFolder): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PIStorageFolder); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.Storage.IStorageFolder>
  VectorChangedEventHandler_1__IStorageFolder_Delegate_Base = interface(IUnknown)
  ['{2057B641-4B9B-5338-A19A-E9A951916775}']
  end;
  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.Storage.IStorageFolder>
  VectorChangedEventHandler_1__IStorageFolder = interface(VectorChangedEventHandler_1__IStorageFolder_Delegate_Base)
  ['{02B1C206-D4FA-5E88-BD76-9C158F6CFAFF}']
    procedure Invoke(sender: IObservableVector_1__IStorageFolder; event: IVectorChangedEventArgs); safecall;
  end;

  // Windows.Foundation.Collections.IObservableVector`1<Windows.Storage.IStorageFolder>
  IObservableVector_1__IStorageFolder = interface(IInspectable)
  ['{772A1791-7293-589A-A10E-5F888E78FA05}']
    function add_VectorChanged(vhnd: VectorChangedEventHandler_1__IStorageFolder): EventRegistrationToken; safecall;
    procedure remove_VectorChanged(token: EventRegistrationToken); safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Storage.Search.SortEntry>
  IIterator_1__Search_SortEntry = interface(IInspectable)
  ['{752850B9-5ED2-5655-8DE2-262EFC26CF39}']
    function get_Current: Search_SortEntry; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PSearch_SortEntry): Cardinal; safecall;
    property Current: Search_SortEntry read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Storage.Search.SortEntry>
  IVectorView_1__Search_SortEntry = interface(IInspectable)
  ['{86D0B56E-CB4E-58F0-B9A2-1528619DCD26}']
    function GetAt(index: Cardinal): Search_SortEntry; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Search_SortEntry; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PSearch_SortEntry): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Storage.ISetVersionDeferral
  [WinRTClassNameAttribute(SSetVersionDeferral)]
  ISetVersionDeferral = interface(IInspectable)
  ['{033508A2-781A-437A-B078-3F32BADCFE47}']
    procedure Complete; safecall;
  end;

  // DualAPI Interface
  // Windows.Storage.ISetVersionRequest
  [WinRTClassNameAttribute(SSetVersionRequest)]
  ISetVersionRequest = interface(IInspectable)
  ['{B9C76B9B-1056-4E69-8330-162619956F9B}']
    function get_CurrentVersion: Cardinal; safecall;
    function get_DesiredVersion: Cardinal; safecall;
    function GetDeferral: ISetVersionDeferral; safecall;
    property CurrentVersion: Cardinal read get_CurrentVersion;
    property DesiredVersion: Cardinal read get_DesiredVersion;
  end;

  // Windows.Storage.ApplicationDataSetVersionHandler
  ApplicationDataSetVersionHandler = interface(IUnknown)
  ['{A05791E6-CC9F-4687-ACAB-A364FD785463}']
    procedure Invoke(setVersionRequest: ISetVersionRequest); safecall;
  end;

  // Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.IApplicationDataContainer>
  IKeyValuePair_2__HSTRING__IApplicationDataContainer = interface(IInspectable)
  ['{9C29CDD1-F5FA-5E4B-BC39-A1FDB2E48959}']
    function get_Key: HSTRING; safecall;
    function get_Value: IApplicationDataContainer; safecall;
    property Key: HSTRING read get_Key;
    property Value: IApplicationDataContainer read get_Value;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.IApplicationDataContainer>>
  IIterator_1__IKeyValuePair_2__HSTRING__IApplicationDataContainer = interface(IInspectable)
  ['{C00495D1-304D-5005-8F60-35610C7A70A1}']
    function get_Current: IKeyValuePair_2__HSTRING__IApplicationDataContainer; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIKeyValuePair_2__HSTRING__IApplicationDataContainer): Cardinal; safecall;
    property Current: IKeyValuePair_2__HSTRING__IApplicationDataContainer read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.IApplicationDataContainer>>
  IIterable_1__IKeyValuePair_2__HSTRING__IApplicationDataContainer = interface(IInspectable)
  ['{BE784D1D-41C6-557E-8776-DFDEF79D733E}']
    function First: IIterator_1__IKeyValuePair_2__HSTRING__IApplicationDataContainer; safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IMapView`2<String,Windows.Storage.IApplicationDataContainer>
  IMapView_2__HSTRING__IApplicationDataContainer_Base = interface(IInspectable)
  ['{13624F8D-85CC-5780-A78D-64DBA58F2C3C}']
  end;
  // Windows.Foundation.Collections.IMapView`2<String,Windows.Storage.IApplicationDataContainer>
  IMapView_2__HSTRING__IApplicationDataContainer = interface(IMapView_2__HSTRING__IApplicationDataContainer_Base)
  ['{EB2E8596-3B90-592B-83DE-3A1AFD8B48A7}']
    function Lookup(key: HSTRING): IApplicationDataContainer; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: HSTRING): Boolean; safecall;
    procedure Split(out first: IMapView_2__HSTRING__IApplicationDataContainer; out second: IMapView_2__HSTRING__IApplicationDataContainer); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Storage.IApplicationDataContainer
  [WinRTClassNameAttribute(SApplicationDataContainer)]
  IApplicationDataContainer = interface(IInspectable)
  ['{C5AEFD1E-F467-40BA-8566-AB640A441E1D}']
    function get_Name: HSTRING; safecall;
    function get_Locality: ApplicationDataLocality; safecall;
    function get_Values: IPropertySet; safecall;
    function get_Containers: IMapView_2__HSTRING__IApplicationDataContainer; safecall;
    function CreateContainer(name: HSTRING; disposition: ApplicationDataCreateDisposition): IApplicationDataContainer; safecall;
    procedure DeleteContainer(name: HSTRING); safecall;
    property Containers: IMapView_2__HSTRING__IApplicationDataContainer read get_Containers;
    property Locality: ApplicationDataLocality read get_Locality;
    property Name: HSTRING read get_Name;
    property Values: IPropertySet read get_Values;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Storage.IApplicationData,Object>
  TypedEventHandler_2__IApplicationData__IInspectable_Delegate_Base = interface(IUnknown)
  ['{B5348B3B-5081-5AE9-8FA3-4D22D68FB0EA}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Storage.IApplicationData,Object>
  TypedEventHandler_2__IApplicationData__IInspectable = interface(TypedEventHandler_2__IApplicationData__IInspectable_Delegate_Base)
  ['{4E72D889-3D9A-5E3B-AA8A-3B37D17226DC}']
    procedure Invoke(sender: IApplicationData; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Storage.IApplicationData
  [WinRTClassNameAttribute(SApplicationData)]
  IApplicationData = interface(IInspectable)
  ['{C3DA6FB7-B744-4B45-B0B8-223A0938D0DC}']
    function get_Version: Cardinal; safecall;
    function SetVersionAsync(desiredVersion: Cardinal; handler: ApplicationDataSetVersionHandler): IAsyncAction; safecall;
    function ClearAsync: IAsyncAction; overload; safecall;
    function ClearAsync(locality: ApplicationDataLocality): IAsyncAction; overload; safecall;
    function get_LocalSettings: IApplicationDataContainer; safecall;
    function get_RoamingSettings: IApplicationDataContainer; safecall;
    function get_LocalFolder: IStorageFolder; safecall;
    function get_RoamingFolder: IStorageFolder; safecall;
    function get_TemporaryFolder: IStorageFolder; safecall;
    function add_DataChanged(handler: TypedEventHandler_2__IApplicationData__IInspectable): EventRegistrationToken; safecall;
    procedure remove_DataChanged(token: EventRegistrationToken); safecall;
    procedure SignalDataChanged; safecall;
    function get_RoamingStorageQuota: UInt64; safecall;
    property LocalFolder: IStorageFolder read get_LocalFolder;
    property LocalSettings: IApplicationDataContainer read get_LocalSettings;
    property RoamingFolder: IStorageFolder read get_RoamingFolder;
    property RoamingSettings: IApplicationDataContainer read get_RoamingSettings;
    property RoamingStorageQuota: UInt64 read get_RoamingStorageQuota;
    property TemporaryFolder: IStorageFolder read get_TemporaryFolder;
    property Version: Cardinal read get_Version;
  end;

  // Windows.Storage.FileProperties.IMusicProperties
  FileProperties_IMusicProperties = interface(IInspectable)
  ['{BC8AAB62-66EC-419A-BC5D-CA65A4CB46DA}']
    function get_Album: HSTRING; safecall;
    procedure put_Album(value: HSTRING); safecall;
    function get_Artist: HSTRING; safecall;
    procedure put_Artist(value: HSTRING); safecall;
    function get_Genre: IVector_1__HSTRING; safecall;
    function get_TrackNumber: Cardinal; safecall;
    procedure put_TrackNumber(value: Cardinal); safecall;
    function get_Title: HSTRING; safecall;
    procedure put_Title(value: HSTRING); safecall;
    function get_Rating: Cardinal; safecall;
    procedure put_Rating(value: Cardinal); safecall;
    function get_Duration: TimeSpan; safecall;
    function get_Bitrate: Cardinal; safecall;
    function get_AlbumArtist: HSTRING; safecall;
    procedure put_AlbumArtist(value: HSTRING); safecall;
    function get_Composers: IVector_1__HSTRING; safecall;
    function get_Conductors: IVector_1__HSTRING; safecall;
    function get_Subtitle: HSTRING; safecall;
    procedure put_Subtitle(value: HSTRING); safecall;
    function get_Producers: IVector_1__HSTRING; safecall;
    function get_Publisher: HSTRING; safecall;
    procedure put_Publisher(value: HSTRING); safecall;
    function get_Writers: IVector_1__HSTRING; safecall;
    function get_Year: Cardinal; safecall;
    procedure put_Year(value: Cardinal); safecall;
    property Album: HSTRING read get_Album write put_Album;
    property AlbumArtist: HSTRING read get_AlbumArtist write put_AlbumArtist;
    property Artist: HSTRING read get_Artist write put_Artist;
    property Bitrate: Cardinal read get_Bitrate;
    property Composers: IVector_1__HSTRING read get_Composers;
    property Conductors: IVector_1__HSTRING read get_Conductors;
    property Duration: TimeSpan read get_Duration;
    property Genre: IVector_1__HSTRING read get_Genre;
    property Producers: IVector_1__HSTRING read get_Producers;
    property Publisher: HSTRING read get_Publisher write put_Publisher;
    property Rating: Cardinal read get_Rating write put_Rating;
    property Subtitle: HSTRING read get_Subtitle write put_Subtitle;
    property Title: HSTRING read get_Title write put_Title;
    property TrackNumber: Cardinal read get_TrackNumber write put_TrackNumber;
    property Writers: IVector_1__HSTRING read get_Writers;
    property Year: Cardinal read get_Year write put_Year;
  end;

  // Windows.Storage.FileProperties.IVideoProperties
  FileProperties_IVideoProperties = interface(IInspectable)
  ['{719AE507-68DE-4DB8-97DE-49998C059F2F}']
    function get_Rating: Cardinal; safecall;
    procedure put_Rating(value: Cardinal); safecall;
    function get_Keywords: IVector_1__HSTRING; safecall;
    function get_Width: Cardinal; safecall;
    function get_Height: Cardinal; safecall;
    function get_Duration: TimeSpan; safecall;
    function get_Latitude: IReference_1__Double; safecall;
    function get_Longitude: IReference_1__Double; safecall;
    function get_Title: HSTRING; safecall;
    procedure put_Title(value: HSTRING); safecall;
    function get_Subtitle: HSTRING; safecall;
    procedure put_Subtitle(value: HSTRING); safecall;
    function get_Producers: IVector_1__HSTRING; safecall;
    function get_Publisher: HSTRING; safecall;
    procedure put_Publisher(value: HSTRING); safecall;
    function get_Writers: IVector_1__HSTRING; safecall;
    function get_Year: Cardinal; safecall;
    procedure put_Year(value: Cardinal); safecall;
    function get_Bitrate: Cardinal; safecall;
    function get_Directors: IVector_1__HSTRING; safecall;
    function get_Orientation: FileProperties_VideoOrientation; safecall;
    property Bitrate: Cardinal read get_Bitrate;
    property Directors: IVector_1__HSTRING read get_Directors;
    property Duration: TimeSpan read get_Duration;
    property Height: Cardinal read get_Height;
    property Keywords: IVector_1__HSTRING read get_Keywords;
    property Latitude: IReference_1__Double read get_Latitude;
    property Longitude: IReference_1__Double read get_Longitude;
    property Orientation: FileProperties_VideoOrientation read get_Orientation;
    property Producers: IVector_1__HSTRING read get_Producers;
    property Publisher: HSTRING read get_Publisher write put_Publisher;
    property Rating: Cardinal read get_Rating write put_Rating;
    property Subtitle: HSTRING read get_Subtitle write put_Subtitle;
    property Title: HSTRING read get_Title write put_Title;
    property Width: Cardinal read get_Width;
    property Writers: IVector_1__HSTRING read get_Writers;
    property Year: Cardinal read get_Year write put_Year;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Storage.IStorageFile>
  IVector_1__IStorageFile = interface(IInspectable)
  ['{021A3F69-AD1E-5FB9-978A-056984AE2B2D}']
    function GetAt(index: Cardinal): IStorageFile; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__IStorageFile; safecall;
    function IndexOf(value: IStorageFile; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: IStorageFile); safecall;
    procedure InsertAt(index: Cardinal; value: IStorageFile); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: IStorageFile); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIStorageFile): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PIStorageFile); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Storage.FileProperties.IGeotagHelperStatics
  [WinRTClassNameAttribute(SFileProperties_GeotagHelper)]
  FileProperties_IGeotagHelperStatics = interface(IInspectable)
  ['{41493244-2524-4655-86A6-ED16F5FC716B}']
    function GetGeotagAsync(&file: IStorageFile): IAsyncOperation_1__IInspectable{Geolocation_IGeopoint}; safecall;
    function SetGeotagFromGeolocatorAsync(&file: IStorageFile; geolocator: IInspectable{Geolocation_IGeolocator}): IAsyncAction; safecall;
    function SetGeotagAsync(&file: IStorageFile; geopoint: IInspectable{Geolocation_IGeopoint}): IAsyncAction; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.FileProperties.IMusicProperties>
  AsyncOperationCompletedHandler_1__FileProperties_IMusicProperties_Delegate_Base = interface(IUnknown)
  ['{D84E1312-D661-5B7F-9566-7421BDEDC1EA}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.FileProperties.IMusicProperties>
  AsyncOperationCompletedHandler_1__FileProperties_IMusicProperties = interface(AsyncOperationCompletedHandler_1__FileProperties_IMusicProperties_Delegate_Base)
  ['{AE688CD9-E302-5657-82B5-1B974D1FA81F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__FileProperties_IMusicProperties; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.FileProperties.IMusicProperties>
  IAsyncOperation_1__FileProperties_IMusicProperties_Base = interface(IInspectable)
  ['{0D023B76-20A7-56F3-84AB-CE31E6544B71}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.FileProperties.IMusicProperties>
  IAsyncOperation_1__FileProperties_IMusicProperties = interface(IAsyncOperation_1__FileProperties_IMusicProperties_Base)
  ['{D3A7B974-3A90-55E8-82D0-D22F2A7B4856}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__FileProperties_IMusicProperties); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__FileProperties_IMusicProperties; safecall;
    function GetResults: FileProperties_IMusicProperties; safecall;
    property Completed: AsyncOperationCompletedHandler_1__FileProperties_IMusicProperties read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.FileProperties.IVideoProperties>
  AsyncOperationCompletedHandler_1__FileProperties_IVideoProperties_Delegate_Base = interface(IUnknown)
  ['{43401D34-61AB-5CF2-921F-55B616631D1D}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.FileProperties.IVideoProperties>
  AsyncOperationCompletedHandler_1__FileProperties_IVideoProperties = interface(AsyncOperationCompletedHandler_1__FileProperties_IVideoProperties_Delegate_Base)
  ['{75953071-FA00-5044-9240-B48C6CEF57B0}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__FileProperties_IVideoProperties; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.FileProperties.IVideoProperties>
  IAsyncOperation_1__FileProperties_IVideoProperties_Base = interface(IInspectable)
  ['{447D4590-D3F9-58BF-AC58-6F9A50839EFE}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.FileProperties.IVideoProperties>
  IAsyncOperation_1__FileProperties_IVideoProperties = interface(IAsyncOperation_1__FileProperties_IVideoProperties_Base)
  ['{C5B61E97-459B-5AA8-B350-2CF55E7C7D47}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__FileProperties_IVideoProperties); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__FileProperties_IVideoProperties; safecall;
    function GetResults: FileProperties_IVideoProperties; safecall;
    property Completed: AsyncOperationCompletedHandler_1__FileProperties_IVideoProperties read get_Completed write put_Completed;
  end;

  // Windows.Storage.FileProperties.IImageProperties
  FileProperties_IImageProperties = interface(IInspectable)
  ['{523C9424-FCFF-4275-AFEE-ECDB9AB47973}']
    function get_Rating: Cardinal; safecall;
    procedure put_Rating(value: Cardinal); safecall;
    function get_Keywords: IVector_1__HSTRING; safecall;
    function get_DateTaken: DateTime; safecall;
    procedure put_DateTaken(value: DateTime); safecall;
    function get_Width: Cardinal; safecall;
    function get_Height: Cardinal; safecall;
    function get_Title: HSTRING; safecall;
    procedure put_Title(value: HSTRING); safecall;
    function get_Latitude: IReference_1__Double; safecall;
    function get_Longitude: IReference_1__Double; safecall;
    function get_CameraManufacturer: HSTRING; safecall;
    procedure put_CameraManufacturer(value: HSTRING); safecall;
    function get_CameraModel: HSTRING; safecall;
    procedure put_CameraModel(value: HSTRING); safecall;
    function get_Orientation: FileProperties_PhotoOrientation; safecall;
    function get_PeopleNames: IVectorView_1__HSTRING; safecall;
    property CameraManufacturer: HSTRING read get_CameraManufacturer write put_CameraManufacturer;
    property CameraModel: HSTRING read get_CameraModel write put_CameraModel;
    property DateTaken: DateTime read get_DateTaken write put_DateTaken;
    property Height: Cardinal read get_Height;
    property Keywords: IVector_1__HSTRING read get_Keywords;
    property Latitude: IReference_1__Double read get_Latitude;
    property Longitude: IReference_1__Double read get_Longitude;
    property Orientation: FileProperties_PhotoOrientation read get_Orientation;
    property PeopleNames: IVectorView_1__HSTRING read get_PeopleNames;
    property Rating: Cardinal read get_Rating write put_Rating;
    property Title: HSTRING read get_Title write put_Title;
    property Width: Cardinal read get_Width;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.FileProperties.IImageProperties>
  AsyncOperationCompletedHandler_1__FileProperties_IImageProperties_Delegate_Base = interface(IUnknown)
  ['{C63729BC-E4C3-564C-B137-2CB4F5966A83}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.FileProperties.IImageProperties>
  AsyncOperationCompletedHandler_1__FileProperties_IImageProperties = interface(AsyncOperationCompletedHandler_1__FileProperties_IImageProperties_Delegate_Base)
  ['{3E47A7AF-FC5E-5D68-A93B-98CEA696089D}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__FileProperties_IImageProperties; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.FileProperties.IImageProperties>
  IAsyncOperation_1__FileProperties_IImageProperties_Base = interface(IInspectable)
  ['{FCD07511-E7F8-5BDA-8C04-795A639DAE8F}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.FileProperties.IImageProperties>
  IAsyncOperation_1__FileProperties_IImageProperties = interface(IAsyncOperation_1__FileProperties_IImageProperties_Base)
  ['{6248A622-38DA-5FC3-AA6B-374D26DAC6BA}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__FileProperties_IImageProperties); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__FileProperties_IImageProperties; safecall;
    function GetResults: FileProperties_IImageProperties; safecall;
    property Completed: AsyncOperationCompletedHandler_1__FileProperties_IImageProperties read get_Completed write put_Completed;
  end;

  // Windows.Storage.FileProperties.IDocumentProperties
  FileProperties_IDocumentProperties = interface(IInspectable)
  ['{7EAB19BC-1821-4923-B4A9-0AEA404D0070}']
    function get_Author: IVector_1__HSTRING; safecall;
    function get_Title: HSTRING; safecall;
    procedure put_Title(value: HSTRING); safecall;
    function get_Keywords: IVector_1__HSTRING; safecall;
    function get_Comment: HSTRING; safecall;
    procedure put_Comment(value: HSTRING); safecall;
    property Author: IVector_1__HSTRING read get_Author;
    property Comment: HSTRING read get_Comment write put_Comment;
    property Keywords: IVector_1__HSTRING read get_Keywords;
    property Title: HSTRING read get_Title write put_Title;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.FileProperties.IDocumentProperties>
  AsyncOperationCompletedHandler_1__FileProperties_IDocumentProperties_Delegate_Base = interface(IUnknown)
  ['{4452ED4C-642B-501B-9617-7D68B4AC3C66}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.FileProperties.IDocumentProperties>
  AsyncOperationCompletedHandler_1__FileProperties_IDocumentProperties = interface(AsyncOperationCompletedHandler_1__FileProperties_IDocumentProperties_Delegate_Base)
  ['{E4B7DD5B-B84A-5EF6-884A-5383529B637B}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__FileProperties_IDocumentProperties; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.FileProperties.IDocumentProperties>
  IAsyncOperation_1__FileProperties_IDocumentProperties_Base = interface(IInspectable)
  ['{6C86E97C-5699-5700-8D35-D350AD3E4DF2}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.FileProperties.IDocumentProperties>
  IAsyncOperation_1__FileProperties_IDocumentProperties = interface(IAsyncOperation_1__FileProperties_IDocumentProperties_Base)
  ['{A861F227-13B9-5FA3-A62E-01F9C918BA48}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__FileProperties_IDocumentProperties); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__FileProperties_IDocumentProperties; safecall;
    function GetResults: FileProperties_IDocumentProperties; safecall;
    property Completed: AsyncOperationCompletedHandler_1__FileProperties_IDocumentProperties read get_Completed write put_Completed;
  end;

  // Windows.Storage.FileProperties.IStorageItemContentProperties
  FileProperties_IStorageItemContentProperties = interface(IInspectable)
  ['{05294BAD-BC38-48BF-85D7-770E0E2AE0BA}']
    function GetMusicPropertiesAsync: IAsyncOperation_1__FileProperties_IMusicProperties; safecall;
    function GetVideoPropertiesAsync: IAsyncOperation_1__FileProperties_IVideoProperties; safecall;
    function GetImagePropertiesAsync: IAsyncOperation_1__FileProperties_IImageProperties; safecall;
    function GetDocumentPropertiesAsync: IAsyncOperation_1__FileProperties_IDocumentProperties; safecall;
  end;

  // Windows.Storage.StreamedFileDataRequestedHandler
  StreamedFileDataRequestedHandler = interface(IUnknown)
  ['{FEF6A824-2FE1-4D07-A35B-B77C50B5F4CC}']
    procedure Invoke(stream: IOutputStream); safecall;
  end;

  // DualAPI Interface
  // Windows.Storage.IStorageFileStatics
  [WinRTClassNameAttribute(SStorageFile)]
  IStorageFileStatics = interface(IInspectable)
  ['{5984C710-DAF2-43C8-8BB4-A4D3EACFD03F}']
    function GetFileFromPathAsync(path: HSTRING): IAsyncOperation_1__IStorageFile; safecall;
    function GetFileFromApplicationUriAsync(uri: IUriRuntimeClass): IAsyncOperation_1__IStorageFile; safecall;
    function CreateStreamedFileAsync(displayNameWithExtension: HSTRING; dataRequested: StreamedFileDataRequestedHandler; thumbnail: IRandomAccessStreamReference): IAsyncOperation_1__IStorageFile; safecall;
    function ReplaceWithStreamedFileAsync(fileToReplace: IStorageFile; dataRequested: StreamedFileDataRequestedHandler; thumbnail: IRandomAccessStreamReference): IAsyncOperation_1__IStorageFile; safecall;
    function CreateStreamedFileFromUriAsync(displayNameWithExtension: HSTRING; uri: IUriRuntimeClass; thumbnail: IRandomAccessStreamReference): IAsyncOperation_1__IStorageFile; safecall;
    function ReplaceWithStreamedFileFromUriAsync(fileToReplace: IStorageFile; uri: IUriRuntimeClass; thumbnail: IRandomAccessStreamReference): IAsyncOperation_1__IStorageFile; safecall;
  end;

  // DualAPI Interface
  // Windows.Storage.IStorageItem2
  IStorageItem2 = interface(IInspectable)
  ['{53F926D2-083C-4283-B45B-81C007237E44}']
    function GetParentAsync: IAsyncOperation_1__IStorageFolder; safecall;
    function IsEqual(item: IStorageItem): Boolean; safecall;
  end;

  // DualAPI Interface
  // Windows.Storage.IStorageItemProperties
  IStorageItemProperties = interface(IInspectable)
  ['{86664478-8029-46FE-A789-1C2F3E2FFB5C}']
    function GetThumbnailAsync(mode: FileProperties_ThumbnailMode): IAsyncOperation_1__IRandomAccessStreamWithContentType; overload; safecall;
    function GetThumbnailAsync(mode: FileProperties_ThumbnailMode; requestedSize: Cardinal): IAsyncOperation_1__IRandomAccessStreamWithContentType; overload; safecall;
    function GetThumbnailAsync(mode: FileProperties_ThumbnailMode; requestedSize: Cardinal; options: FileProperties_ThumbnailOptions): IAsyncOperation_1__IRandomAccessStreamWithContentType; overload; safecall;
    function get_DisplayName: HSTRING; safecall;
    function get_DisplayType: HSTRING; safecall;
    function get_FolderRelativeId: HSTRING; safecall;
    function get_Properties: FileProperties_IStorageItemContentProperties; safecall;
    property DisplayName: HSTRING read get_DisplayName;
    property DisplayType: HSTRING read get_DisplayType;
    property FolderRelativeId: HSTRING read get_FolderRelativeId;
    property Properties: FileProperties_IStorageItemContentProperties read get_Properties;
  end;

  // DualAPI Interface
  // Windows.Storage.IStorageItemProperties2
  IStorageItemProperties2 = interface(IInspectable)
  ['{8E86A951-04B9-4BD2-929D-FEF3F71621D0}']
    function GetScaledImageAsThumbnailAsync(mode: FileProperties_ThumbnailMode): IAsyncOperation_1__IRandomAccessStreamWithContentType; overload; safecall;
    function GetScaledImageAsThumbnailAsync(mode: FileProperties_ThumbnailMode; requestedSize: Cardinal): IAsyncOperation_1__IRandomAccessStreamWithContentType; overload; safecall;
    function GetScaledImageAsThumbnailAsync(mode: FileProperties_ThumbnailMode; requestedSize: Cardinal; options: FileProperties_ThumbnailOptions): IAsyncOperation_1__IRandomAccessStreamWithContentType; overload; safecall;
  end;

  // Windows.Storage.IStorageProvider
  IStorageProvider = interface(IInspectable)
  ['{E705EED4-D478-47D6-BA46-1A8EBE114A20}']
    function get_Id: HSTRING; safecall;
    function get_DisplayName: HSTRING; safecall;
    property DisplayName: HSTRING read get_DisplayName;
    property Id: HSTRING read get_Id;
  end;

  // DualAPI Interface
  // Windows.Storage.IStorageItemPropertiesWithProvider
  IStorageItemPropertiesWithProvider = interface(IInspectable)
  ['{861BF39B-6368-4DEE-B40E-74684A5CE714}']
    function get_Provider: IStorageProvider; safecall;
    property Provider: IStorageProvider read get_Provider;
  end;

  // DualAPI Interface
  // Windows.Storage.IStorageFilePropertiesWithAvailability
  IStorageFilePropertiesWithAvailability = interface(IInspectable)
  ['{AFCBBE9B-582B-4133-9648-E44CA46EE491}']
    function get_IsAvailable: Boolean; safecall;
    property IsAvailable: Boolean read get_IsAvailable;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Search.IndexedState>
  AsyncOperationCompletedHandler_1__Search_IndexedState_Delegate_Base = interface(IUnknown)
  ['{B67A3CBA-F5F7-5E51-968A-385126D1F918}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Search.IndexedState>
  AsyncOperationCompletedHandler_1__Search_IndexedState = interface(AsyncOperationCompletedHandler_1__Search_IndexedState_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Search_IndexedState; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Search.IndexedState>
  IAsyncOperation_1__Search_IndexedState_Base = interface(IInspectable)
  ['{88694B1F-F380-574D-8A05-4F67BD52CD11}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Search.IndexedState>
  IAsyncOperation_1__Search_IndexedState = interface(IAsyncOperation_1__Search_IndexedState_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Search_IndexedState); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Search_IndexedState; safecall;
    function GetResults: Search_IndexedState; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Search_IndexedState read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Storage.IStorageFile2
  IStorageFile2 = interface(IInspectable)
  ['{954E4BCF-0A77-42FB-B777-C2ED58A52E44}']
    function OpenAsync(accessMode: FileAccessMode; options: StorageOpenOptions): IAsyncOperation_1__IRandomAccessStream; safecall;
    function OpenTransactedWriteAsync(options: StorageOpenOptions): IAsyncOperation_1__IStorageStreamTransaction; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Provider.FileUpdateStatus>
  AsyncOperationCompletedHandler_1__Provider_FileUpdateStatus_Delegate_Base = interface(IUnknown)
  ['{BB185A07-0285-5F37-9C7D-2FC6A3E0E6E5}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Provider.FileUpdateStatus>
  AsyncOperationCompletedHandler_1__Provider_FileUpdateStatus = interface(AsyncOperationCompletedHandler_1__Provider_FileUpdateStatus_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Provider_FileUpdateStatus; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Provider.FileUpdateStatus>
  IAsyncOperation_1__Provider_FileUpdateStatus_Base = interface(IInspectable)
  ['{8F0F439E-87D0-531F-85B1-54F4528F29C3}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Provider.FileUpdateStatus>
  IAsyncOperation_1__Provider_FileUpdateStatus = interface(IAsyncOperation_1__Provider_FileUpdateStatus_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Provider_FileUpdateStatus); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Provider_FileUpdateStatus; safecall;
    function GetResults: Provider_FileUpdateStatus; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Provider_FileUpdateStatus read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Storage.AccessCache.AccessListEntry>
  IIterator_1__AccessCache_AccessListEntry = interface(IInspectable)
  ['{752850B9-5ED2-5655-8DE2-262EFC26CF39}']
    function get_Current: AccessCache_AccessListEntry; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PAccessCache_AccessListEntry): Cardinal; safecall;
    property Current: AccessCache_AccessListEntry read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // DualAPI Interface
  // Windows.Storage.IApplicationDataStatics
  [WinRTClassNameAttribute(SApplicationData)]
  IApplicationDataStatics = interface(IInspectable)
  ['{5612147B-E843-45E3-94D8-06169E3C8E17}']
    function get_Current: IApplicationData; safecall;
    property Current: IApplicationData read get_Current;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.IApplicationData>
  AsyncOperationCompletedHandler_1__IApplicationData_Delegate_Base = interface(IUnknown)
  ['{ABAFE590-65FE-520A-9D7C-6AB5F1882237}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.IApplicationData>
  AsyncOperationCompletedHandler_1__IApplicationData = interface(AsyncOperationCompletedHandler_1__IApplicationData_Delegate_Base)
  ['{C30AEE19-A1A1-5CBD-9B91-DCC5DB72F16B}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IApplicationData; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.IApplicationData>
  IAsyncOperation_1__IApplicationData_Base = interface(IInspectable)
  ['{31456B58-A5CB-5C5B-BD6E-CCCE3A7BF4B4}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.IApplicationData>
  IAsyncOperation_1__IApplicationData = interface(IAsyncOperation_1__IApplicationData_Base)
  ['{141FA633-8D79-53C8-991A-60A5DA990CAE}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IApplicationData); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IApplicationData; safecall;
    function GetResults: IApplicationData; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IApplicationData read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Storage.IApplicationDataStatics2
  [WinRTClassNameAttribute(SApplicationData)]
  IApplicationDataStatics2 = interface(IInspectable)
  ['{CD606211-CF49-40A4-A47C-C7F0DBBA8107}']
    function GetForUserAsync(user: IInspectable{IUser}): IAsyncOperation_1__IApplicationData; safecall;
  end;

  // DualAPI Interface
  // Windows.Storage.IApplicationData2
  IApplicationData2 = interface(IInspectable)
  ['{9E65CD69-0BA3-4E32-BE29-B02DE6607638}']
    function get_LocalCacheFolder: IStorageFolder; safecall;
    property LocalCacheFolder: IStorageFolder read get_LocalCacheFolder;
  end;

  // DualAPI Interface
  // Windows.Storage.IApplicationData3
  IApplicationData3 = interface(IInspectable)
  ['{DC222CF4-2772-4C1D-AA2C-C9F743ADE8D1}']
    function GetPublisherCacheFolder(folderName: HSTRING): IStorageFolder; safecall;
    function ClearPublisherCacheFolderAsync(folderName: HSTRING): IAsyncAction; safecall;
    function get_SharedLocalFolder: IStorageFolder; safecall;
    property SharedLocalFolder: IStorageFolder read get_SharedLocalFolder;
  end;

  // DualAPI Interface
  // Windows.Storage.Compression.ICompressor
  [WinRTClassNameAttribute(SCompression_Compressor)]
  Compression_ICompressor = interface(IInspectable)
  ['{0AC3645A-57AC-4EE1-B702-84D39D5424E0}']
    function FinishAsync: IAsyncOperation_1__Boolean; safecall;
    function DetachStream: IOutputStream; safecall;
  end;

  // DualAPI Interface
  // Windows.Storage.Compression.IDecompressor
  [WinRTClassNameAttribute(SCompression_Decompressor)]
  Compression_IDecompressor = interface(IInspectable)
  ['{B883FE46-D68A-4C8B-ADA0-4EE813FC5283}']
    function DetachStream: IInputStream; safecall;
  end;

  // DualAPI Interface
  // Windows.Storage.Compression.ICompressorFactory
  [WinRTClassNameAttribute(SCompression_Compressor)]
  Compression_ICompressorFactory = interface(IInspectable)
  ['{5F3D96A4-2CFB-442C-A8BA-D7D11B039DA0}']
    function CreateCompressor(underlyingStream: IOutputStream): Compression_ICompressor; safecall;
    function CreateCompressorEx(underlyingStream: IOutputStream; algorithm: Compression_CompressAlgorithm; blockSize: Cardinal): Compression_ICompressor; safecall;
  end;

  // DualAPI Interface
  // Windows.Storage.Compression.IDecompressorFactory
  [WinRTClassNameAttribute(SCompression_Decompressor)]
  Compression_IDecompressorFactory = interface(IInspectable)
  ['{5337E252-1DA2-42E1-8834-0379D28D742F}']
    function CreateDecompressor(underlyingStream: IInputStream): Compression_IDecompressor; safecall;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Storage.IStorageItem>
  IVector_1__IStorageItem = interface(IInspectable)
  ['{802508E2-9C2C-5B91-89A8-39BCF7223344}']
    function GetAt(index: Cardinal): IStorageItem; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__IStorageItem; safecall;
    function IndexOf(value: IStorageItem; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: IStorageItem); safecall;
    procedure InsertAt(index: Cardinal; value: IStorageItem); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: IStorageItem); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIStorageItem): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PIStorageItem); safecall;
    property Size: Cardinal read get_Size;
  end;


  // Emit Forwarded classes
  // Windows.Storage.FileProperties.GeotagHelper
  // DualAPI
  TFileProperties_GeotagHelper = class(TWinRTGenericImportS<FileProperties_IGeotagHelperStatics>)
  public
    // -> FileProperties_IGeotagHelperStatics
    class function GetGeotagAsync(&file: IStorageFile): IAsyncOperation_1__IInspectable{Geolocation_IGeopoint}; static; inline;
    class function SetGeotagFromGeolocatorAsync(&file: IStorageFile; geolocator: IInspectable{Geolocation_IGeolocator}): IAsyncAction; static; inline;
    class function SetGeotagAsync(&file: IStorageFile; geopoint: IInspectable{Geolocation_IGeopoint}): IAsyncAction; static; inline;
  end;

  // Windows.Storage.StorageFile
  // WinRT Only
  // WhiteListed
  TStorageFile = class(TWinRTGenericImportS<IStorageFileStatics>)
  public
    // -> IStorageFileStatics
    class function GetFileFromPathAsync(path: HSTRING): IAsyncOperation_1__IStorageFile; static; inline;
    class function GetFileFromApplicationUriAsync(uri: IUriRuntimeClass): IAsyncOperation_1__IStorageFile; static; inline;
    class function CreateStreamedFileAsync(displayNameWithExtension: HSTRING; dataRequested: StreamedFileDataRequestedHandler; thumbnail: IRandomAccessStreamReference): IAsyncOperation_1__IStorageFile; static; inline;
    class function ReplaceWithStreamedFileAsync(fileToReplace: IStorageFile; dataRequested: StreamedFileDataRequestedHandler; thumbnail: IRandomAccessStreamReference): IAsyncOperation_1__IStorageFile; static; inline;
    class function CreateStreamedFileFromUriAsync(displayNameWithExtension: HSTRING; uri: IUriRuntimeClass; thumbnail: IRandomAccessStreamReference): IAsyncOperation_1__IStorageFile; static; inline;
    class function ReplaceWithStreamedFileFromUriAsync(fileToReplace: IStorageFile; uri: IUriRuntimeClass; thumbnail: IRandomAccessStreamReference): IAsyncOperation_1__IStorageFile; static; inline;
  end;

  // Windows.Storage.ApplicationData
  // DualAPI
  TApplicationData = class(TWinRTGenericImportS2<IApplicationDataStatics, IApplicationDataStatics2>)
  public
    // -> IApplicationDataStatics2
    class function GetForUserAsync(user: IInspectable{IUser}): IAsyncOperation_1__IApplicationData; static; inline;

    // -> IApplicationDataStatics
    class function get_Current: IApplicationData; static; inline;
    class property Current: IApplicationData read get_Current;
  end;

  // Windows.Storage.SetVersionRequest
  // DualAPI

  // Windows.Storage.ApplicationDataContainer
  // DualAPI

  // Windows.Storage.SetVersionDeferral
  // DualAPI

  // Windows.Storage.ApplicationDataContainerSettings
  // DualAPI

  // Windows.Storage.ApplicationDataCompositeValue
  // DualAPI
  TApplicationDataCompositeValue = class(TWinRTGenericImportI<IPropertySet>) end;

  // Windows.Storage.Compression.Compressor
  // DualAPI
  TCompression_Compressor = class(TWinRTGenericImportF<Compression_ICompressorFactory>)
  public
    // -> Compression_ICompressorFactory
    class function CreateCompressor(underlyingStream: IOutputStream): Compression_ICompressor; static; inline;
    class function CreateCompressorEx(underlyingStream: IOutputStream; algorithm: Compression_CompressAlgorithm; blockSize: Cardinal): Compression_ICompressor; static; inline;
  end;

  // Windows.Storage.Compression.Decompressor
  // DualAPI
  TCompression_Decompressor = class(TWinRTGenericImportF<Compression_IDecompressorFactory>)
  public
    // -> Compression_IDecompressorFactory
    class function CreateDecompressor(underlyingStream: IInputStream): Compression_IDecompressor; static; inline;
  end;


implementation

  // Emit Classes Implementation
 { TFileProperties_GeotagHelper }

class function TFileProperties_GeotagHelper.GetGeotagAsync(&file: IStorageFile): IAsyncOperation_1__IInspectable{Geolocation_IGeopoint};
begin
  Result := Statics.GetGeotagAsync(&file);
end;

class function TFileProperties_GeotagHelper.SetGeotagFromGeolocatorAsync(&file: IStorageFile; geolocator: IInspectable{Geolocation_IGeolocator}): IAsyncAction;
begin
  Result := Statics.SetGeotagFromGeolocatorAsync(&file, geolocator);
end;

class function TFileProperties_GeotagHelper.SetGeotagAsync(&file: IStorageFile; geopoint: IInspectable{Geolocation_IGeopoint}): IAsyncAction;
begin
  Result := Statics.SetGeotagAsync(&file, geopoint);
end;


 { TStorageFile }

class function TStorageFile.GetFileFromPathAsync(path: HSTRING): IAsyncOperation_1__IStorageFile;
begin
  Result := Statics.GetFileFromPathAsync(path);
end;

class function TStorageFile.GetFileFromApplicationUriAsync(uri: IUriRuntimeClass): IAsyncOperation_1__IStorageFile;
begin
  Result := Statics.GetFileFromApplicationUriAsync(uri);
end;

class function TStorageFile.CreateStreamedFileAsync(displayNameWithExtension: HSTRING; dataRequested: StreamedFileDataRequestedHandler; thumbnail: IRandomAccessStreamReference): IAsyncOperation_1__IStorageFile;
begin
  Result := Statics.CreateStreamedFileAsync(displayNameWithExtension, dataRequested, thumbnail);
end;

class function TStorageFile.ReplaceWithStreamedFileAsync(fileToReplace: IStorageFile; dataRequested: StreamedFileDataRequestedHandler; thumbnail: IRandomAccessStreamReference): IAsyncOperation_1__IStorageFile;
begin
  Result := Statics.ReplaceWithStreamedFileAsync(fileToReplace, dataRequested, thumbnail);
end;

class function TStorageFile.CreateStreamedFileFromUriAsync(displayNameWithExtension: HSTRING; uri: IUriRuntimeClass; thumbnail: IRandomAccessStreamReference): IAsyncOperation_1__IStorageFile;
begin
  Result := Statics.CreateStreamedFileFromUriAsync(displayNameWithExtension, uri, thumbnail);
end;

class function TStorageFile.ReplaceWithStreamedFileFromUriAsync(fileToReplace: IStorageFile; uri: IUriRuntimeClass; thumbnail: IRandomAccessStreamReference): IAsyncOperation_1__IStorageFile;
begin
  Result := Statics.ReplaceWithStreamedFileFromUriAsync(fileToReplace, uri, thumbnail);
end;


 { TApplicationData }

class function TApplicationData.get_Current: IApplicationData;
begin
  Result := Statics.get_Current;
end;


class function TApplicationData.GetForUserAsync(user: IInspectable{IUser}): IAsyncOperation_1__IApplicationData;
begin
  Result := Statics2.GetForUserAsync(user);
end;


 { TApplicationDataCompositeValue }

 { TCompression_Compressor }
// Factories for : "Compression_Compressor"
// Factory: "Windows.Storage.Compression.ICompressorFactory"
// -> Compression_ICompressorFactory

class function TCompression_Compressor.CreateCompressor(underlyingStream: IOutputStream): Compression_ICompressor;
begin
  Result := Factory.CreateCompressor(underlyingStream);
end;

class function TCompression_Compressor.CreateCompressorEx(underlyingStream: IOutputStream; algorithm: Compression_CompressAlgorithm; blockSize: Cardinal): Compression_ICompressor;
begin
  Result := Factory.CreateCompressorEx(underlyingStream, algorithm, blockSize);
end;


 { TCompression_Decompressor }
// Factories for : "Compression_Decompressor"
// Factory: "Windows.Storage.Compression.IDecompressorFactory"
// -> Compression_IDecompressorFactory

class function TCompression_Decompressor.CreateDecompressor(underlyingStream: IInputStream): Compression_IDecompressor;
begin
  Result := Factory.CreateDecompressor(underlyingStream);
end;



end.
