{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Storage.Streams;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  // Internal Uses...
  Winapi.Foundation,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Storage.Streams Class Names
  // Windows.Storage.Streams.DataReader
  // WinRT Only
  // WhiteListed
  SDataReader = 'Windows.Storage.Streams.DataReader';
  // Windows.Storage.Streams.DataWriter
  // WinRT Only
  // WhiteListed
  SDataWriter = 'Windows.Storage.Streams.DataWriter';
  // Windows.Storage.Streams.RandomAccessStreamReference
  // WinRT Only
  // WhiteListed
  SRandomAccessStreamReference = 'Windows.Storage.Streams.RandomAccessStreamReference';


type
  // Forward declare interfaces
  // Windows.Storage.Streams.IBuffer
  IBuffer = interface;
  PIBuffer = ^IBuffer;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Storage.Streams.IBuffer,UInt32>
  AsyncOperationProgressHandler_2__IBuffer__Cardinal = interface;
  PAsyncOperationProgressHandler_2__IBuffer__Cardinal = ^AsyncOperationProgressHandler_2__IBuffer__Cardinal;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Storage.Streams.IBuffer,UInt32>
  AsyncOperationWithProgressCompletedHandler_2__IBuffer__Cardinal = interface;
  PAsyncOperationWithProgressCompletedHandler_2__IBuffer__Cardinal = ^AsyncOperationWithProgressCompletedHandler_2__IBuffer__Cardinal;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Storage.Streams.IBuffer,UInt32>
  IAsyncOperationWithProgress_2__IBuffer__Cardinal = interface;
  PIAsyncOperationWithProgress_2__IBuffer__Cardinal = ^IAsyncOperationWithProgress_2__IBuffer__Cardinal;

  // Windows.Storage.Streams.IInputStream
  IInputStream = interface;
  PIInputStream = ^IInputStream;

  // Windows.Storage.Streams.IOutputStream
  IOutputStream = interface;
  PIOutputStream = ^IOutputStream;

  // Windows.Storage.Streams.IRandomAccessStream
  IRandomAccessStream = interface;
  PIRandomAccessStream = ^IRandomAccessStream;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Streams.IRandomAccessStream>
  AsyncOperationCompletedHandler_1__IRandomAccessStream = interface;
  PAsyncOperationCompletedHandler_1__IRandomAccessStream = ^AsyncOperationCompletedHandler_1__IRandomAccessStream;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Streams.IRandomAccessStream>
  IAsyncOperation_1__IRandomAccessStream = interface;
  PIAsyncOperation_1__IRandomAccessStream = ^IAsyncOperation_1__IRandomAccessStream;

  // Windows.Storage.Streams.IRandomAccessStreamWithContentType
  IRandomAccessStreamWithContentType = interface;
  PIRandomAccessStreamWithContentType = ^IRandomAccessStreamWithContentType;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>
  AsyncOperationCompletedHandler_1__IRandomAccessStreamWithContentType = interface;
  PAsyncOperationCompletedHandler_1__IRandomAccessStreamWithContentType = ^AsyncOperationCompletedHandler_1__IRandomAccessStreamWithContentType;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>
  IAsyncOperation_1__IRandomAccessStreamWithContentType = interface;
  PIAsyncOperation_1__IRandomAccessStreamWithContentType = ^IAsyncOperation_1__IRandomAccessStreamWithContentType;

  // Windows.Storage.Streams.IRandomAccessStreamReference
  IRandomAccessStreamReference = interface;
  PIRandomAccessStreamReference = ^IRandomAccessStreamReference;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Streams.IRandomAccessStreamReference>
  AsyncOperationCompletedHandler_1__IRandomAccessStreamReference = interface;
  PAsyncOperationCompletedHandler_1__IRandomAccessStreamReference = ^AsyncOperationCompletedHandler_1__IRandomAccessStreamReference;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Streams.IRandomAccessStreamReference>
  IAsyncOperation_1__IRandomAccessStreamReference = interface;
  PIAsyncOperation_1__IRandomAccessStreamReference = ^IAsyncOperation_1__IRandomAccessStreamReference;

  // Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.Streams.IRandomAccessStreamReference>
  IKeyValuePair_2__HSTRING__IRandomAccessStreamReference = interface;
  PIKeyValuePair_2__HSTRING__IRandomAccessStreamReference = ^IKeyValuePair_2__HSTRING__IRandomAccessStreamReference;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.Streams.IRandomAccessStreamReference>>
  IIterator_1__IKeyValuePair_2__HSTRING__IRandomAccessStreamReference = interface;
  PIIterator_1__IKeyValuePair_2__HSTRING__IRandomAccessStreamReference = ^IIterator_1__IKeyValuePair_2__HSTRING__IRandomAccessStreamReference;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.Streams.IRandomAccessStreamReference>>
  IIterable_1__IKeyValuePair_2__HSTRING__IRandomAccessStreamReference = interface;
  PIIterable_1__IKeyValuePair_2__HSTRING__IRandomAccessStreamReference = ^IIterable_1__IKeyValuePair_2__HSTRING__IRandomAccessStreamReference;

  // Windows.Foundation.Collections.IMapView`2<String,Windows.Storage.Streams.IRandomAccessStreamReference>
  IMapView_2__HSTRING__IRandomAccessStreamReference = interface;
  PIMapView_2__HSTRING__IRandomAccessStreamReference = ^IMapView_2__HSTRING__IRandomAccessStreamReference;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IMapView`2<String,Windows.Storage.Streams.IRandomAccessStreamReference>>
  AsyncOperationCompletedHandler_1__IMapView_2__HSTRING__IRandomAccessStreamReference = interface;
  PAsyncOperationCompletedHandler_1__IMapView_2__HSTRING__IRandomAccessStreamReference = ^AsyncOperationCompletedHandler_1__IMapView_2__HSTRING__IRandomAccessStreamReference;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IMapView`2<String,Windows.Storage.Streams.IRandomAccessStreamReference>>
  IAsyncOperation_1__IMapView_2__HSTRING__IRandomAccessStreamReference = interface;
  PIAsyncOperation_1__IMapView_2__HSTRING__IRandomAccessStreamReference = ^IAsyncOperation_1__IMapView_2__HSTRING__IRandomAccessStreamReference;

  // Windows.Foundation.Collections.IMap`2<String,Windows.Storage.Streams.IRandomAccessStreamReference>
  IMap_2__HSTRING__IRandomAccessStreamReference = interface;
  PIMap_2__HSTRING__IRandomAccessStreamReference = ^IMap_2__HSTRING__IRandomAccessStreamReference;

  // Windows.Foundation.Collections.IIterator`1<Windows.Storage.Streams.IBuffer>
  IIterator_1__IBuffer = interface;
  PIIterator_1__IBuffer = ^IIterator_1__IBuffer;

  // Windows.Foundation.Collections.IIterable`1<Windows.Storage.Streams.IBuffer>
  IIterable_1__IBuffer = interface;
  PIIterable_1__IBuffer = ^IIterable_1__IBuffer;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Storage.Streams.IBuffer>
  IVectorView_1__IBuffer = interface;
  PIVectorView_1__IBuffer = ^IVectorView_1__IBuffer;

  // Windows.Foundation.Collections.IKeyValuePair`2<UInt32,Windows.Storage.Streams.IBuffer>
  IKeyValuePair_2__Cardinal__IBuffer = interface;
  PIKeyValuePair_2__Cardinal__IBuffer = ^IKeyValuePair_2__Cardinal__IBuffer;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<UInt32,Windows.Storage.Streams.IBuffer>>
  IIterator_1__IKeyValuePair_2__Cardinal__IBuffer = interface;
  PIIterator_1__IKeyValuePair_2__Cardinal__IBuffer = ^IIterator_1__IKeyValuePair_2__Cardinal__IBuffer;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<UInt32,Windows.Storage.Streams.IBuffer>>
  IIterable_1__IKeyValuePair_2__Cardinal__IBuffer = interface;
  PIIterable_1__IKeyValuePair_2__Cardinal__IBuffer = ^IIterable_1__IKeyValuePair_2__Cardinal__IBuffer;

  // Windows.Foundation.Collections.IMapView`2<UInt32,Windows.Storage.Streams.IBuffer>
  IMapView_2__Cardinal__IBuffer = interface;
  PIMapView_2__Cardinal__IBuffer = ^IMapView_2__Cardinal__IBuffer;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IMapView`2<UInt32,Windows.Storage.Streams.IBuffer>>
  AsyncOperationCompletedHandler_1__IMapView_2__Cardinal__IBuffer = interface;
  PAsyncOperationCompletedHandler_1__IMapView_2__Cardinal__IBuffer = ^AsyncOperationCompletedHandler_1__IMapView_2__Cardinal__IBuffer;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IMapView`2<UInt32,Windows.Storage.Streams.IBuffer>>
  IAsyncOperation_1__IMapView_2__Cardinal__IBuffer = interface;
  PIAsyncOperation_1__IMapView_2__Cardinal__IBuffer = ^IAsyncOperation_1__IMapView_2__Cardinal__IBuffer;

  // Windows.Foundation.Collections.IMap`2<UInt32,Windows.Storage.Streams.IBuffer>
  IMap_2__Cardinal__IBuffer = interface;
  PIMap_2__Cardinal__IBuffer = ^IMap_2__Cardinal__IBuffer;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Streams.IBuffer>
  AsyncOperationCompletedHandler_1__IBuffer = interface;
  PAsyncOperationCompletedHandler_1__IBuffer = ^AsyncOperationCompletedHandler_1__IBuffer;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Streams.IBuffer>
  IAsyncOperation_1__IBuffer = interface;
  PIAsyncOperation_1__IBuffer = ^IAsyncOperation_1__IBuffer;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Streams.IOutputStream>
  AsyncOperationCompletedHandler_1__IOutputStream = interface;
  PAsyncOperationCompletedHandler_1__IOutputStream = ^AsyncOperationCompletedHandler_1__IOutputStream;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Streams.IOutputStream>
  IAsyncOperation_1__IOutputStream = interface;
  PIAsyncOperation_1__IOutputStream = ^IAsyncOperation_1__IOutputStream;

  // Windows.Storage.Streams.IDataReader
  IDataReader = interface;
  PIDataReader = ^IDataReader;

  // Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.Streams.IBuffer>
  IKeyValuePair_2__HSTRING__IBuffer = interface;
  PIKeyValuePair_2__HSTRING__IBuffer = ^IKeyValuePair_2__HSTRING__IBuffer;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.Streams.IBuffer>>
  IIterator_1__IKeyValuePair_2__HSTRING__IBuffer = interface;
  PIIterator_1__IKeyValuePair_2__HSTRING__IBuffer = ^IIterator_1__IKeyValuePair_2__HSTRING__IBuffer;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.Streams.IBuffer>>
  IIterable_1__IKeyValuePair_2__HSTRING__IBuffer = interface;
  PIIterable_1__IKeyValuePair_2__HSTRING__IBuffer = ^IIterable_1__IKeyValuePair_2__HSTRING__IBuffer;

  // Windows.Foundation.Collections.IMapView`2<String,Windows.Storage.Streams.IBuffer>
  IMapView_2__HSTRING__IBuffer = interface;
  PIMapView_2__HSTRING__IBuffer = ^IMapView_2__HSTRING__IBuffer;

  // Windows.Foundation.Collections.IIterator`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>
  IIterator_1__IRandomAccessStreamWithContentType = interface;
  PIIterator_1__IRandomAccessStreamWithContentType = ^IIterator_1__IRandomAccessStreamWithContentType;

  // Windows.Foundation.Collections.IIterable`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>
  IIterable_1__IRandomAccessStreamWithContentType = interface;
  PIIterable_1__IRandomAccessStreamWithContentType = ^IIterable_1__IRandomAccessStreamWithContentType;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>
  IVectorView_1__IRandomAccessStreamWithContentType = interface;
  PIVectorView_1__IRandomAccessStreamWithContentType = ^IVectorView_1__IRandomAccessStreamWithContentType;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IRandomAccessStreamWithContentType = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__IRandomAccessStreamWithContentType = ^AsyncOperationCompletedHandler_1__IVectorView_1__IRandomAccessStreamWithContentType;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>>
  IAsyncOperation_1__IVectorView_1__IRandomAccessStreamWithContentType = interface;
  PIAsyncOperation_1__IVectorView_1__IRandomAccessStreamWithContentType = ^IAsyncOperation_1__IVectorView_1__IRandomAccessStreamWithContentType;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Storage.Streams.IBuffer,UInt64>
  AsyncOperationProgressHandler_2__IBuffer__UInt64 = interface;
  PAsyncOperationProgressHandler_2__IBuffer__UInt64 = ^AsyncOperationProgressHandler_2__IBuffer__UInt64;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Storage.Streams.IBuffer,UInt64>
  AsyncOperationWithProgressCompletedHandler_2__IBuffer__UInt64 = interface;
  PAsyncOperationWithProgressCompletedHandler_2__IBuffer__UInt64 = ^AsyncOperationWithProgressCompletedHandler_2__IBuffer__UInt64;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Storage.Streams.IBuffer,UInt64>
  IAsyncOperationWithProgress_2__IBuffer__UInt64 = interface;
  PIAsyncOperationWithProgress_2__IBuffer__UInt64 = ^IAsyncOperationWithProgress_2__IBuffer__UInt64;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Storage.Streams.IInputStream,UInt64>
  AsyncOperationProgressHandler_2__IInputStream__UInt64 = interface;
  PAsyncOperationProgressHandler_2__IInputStream__UInt64 = ^AsyncOperationProgressHandler_2__IInputStream__UInt64;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Storage.Streams.IInputStream,UInt64>
  AsyncOperationWithProgressCompletedHandler_2__IInputStream__UInt64 = interface;
  PAsyncOperationWithProgressCompletedHandler_2__IInputStream__UInt64 = ^AsyncOperationWithProgressCompletedHandler_2__IInputStream__UInt64;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Storage.Streams.IInputStream,UInt64>
  IAsyncOperationWithProgress_2__IInputStream__UInt64 = interface;
  PIAsyncOperationWithProgress_2__IInputStream__UInt64 = ^IAsyncOperationWithProgress_2__IInputStream__UInt64;

  // Windows.Storage.Streams.IDataReaderFactory
  IDataReaderFactory = interface;
  PIDataReaderFactory = ^IDataReaderFactory;

  // Windows.Storage.Streams.IDataReaderStatics
  IDataReaderStatics = interface;
  PIDataReaderStatics = ^IDataReaderStatics;

  // Windows.Storage.Streams.IDataWriter
  IDataWriter = interface;
  PIDataWriter = ^IDataWriter;

  // Windows.Storage.Streams.IDataWriterFactory
  IDataWriterFactory = interface;
  PIDataWriterFactory = ^IDataWriterFactory;

  // Windows.Storage.Streams.IContentTypeProvider
  IContentTypeProvider = interface;
  PIContentTypeProvider = ^IContentTypeProvider;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Streams.IInputStream>
  AsyncOperationCompletedHandler_1__IInputStream = interface;
  PAsyncOperationCompletedHandler_1__IInputStream = ^AsyncOperationCompletedHandler_1__IInputStream;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Streams.IInputStream>
  IAsyncOperation_1__IInputStream = interface;
  PIAsyncOperation_1__IInputStream = ^IAsyncOperation_1__IInputStream;

  // Windows.Storage.Streams.IInputStreamReference
  IInputStreamReference = interface;
  PIInputStreamReference = ^IInputStreamReference;

  // Windows.Storage.Streams.IRandomAccessStreamReferenceStatics
  IRandomAccessStreamReferenceStatics = interface;
  PIRandomAccessStreamReferenceStatics = ^IRandomAccessStreamReferenceStatics;

  // Windows.Foundation.Collections.IIterator`1<Windows.Storage.Streams.IRandomAccessStream>
  IIterator_1__IRandomAccessStream = interface;
  PIIterator_1__IRandomAccessStream = ^IIterator_1__IRandomAccessStream;

  // Windows.Foundation.Collections.IIterable`1<Windows.Storage.Streams.IRandomAccessStream>
  IIterable_1__IRandomAccessStream = interface;
  PIIterable_1__IRandomAccessStream = ^IIterable_1__IRandomAccessStream;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Storage.Streams.IRandomAccessStream>
  IVectorView_1__IRandomAccessStream = interface;
  PIVectorView_1__IRandomAccessStream = ^IVectorView_1__IRandomAccessStream;

  // Windows.Foundation.Collections.IVector`1<Windows.Storage.Streams.IRandomAccessStream>
  IVector_1__IRandomAccessStream = interface;
  PIVector_1__IRandomAccessStream = ^IVector_1__IRandomAccessStream;


  // Emit Forwarded interfaces
  // Windows.Storage.Streams Interfaces
  // Windows.Storage.Streams.IBuffer
  IBuffer = interface(IInspectable)
  ['{905A0FE0-BC53-11DF-8C49-001E4FC686DA}']
    function get_Capacity: Cardinal; safecall;
    function get_Length: Cardinal; safecall;
    procedure put_Length(value: Cardinal); safecall;
    property Capacity: Cardinal read get_Capacity;
    property Length: Cardinal read get_Length write put_Length;
  end;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Storage.Streams.IBuffer,UInt32>
  AsyncOperationProgressHandler_2__IBuffer__Cardinal = interface(IUnknown)
  ['{BF666554-7605-5D9A-B14E-18D8C8472AFE}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__IBuffer__Cardinal; progressInfo: Cardinal); safecall;
  end;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Storage.Streams.IBuffer,UInt32>
  AsyncOperationWithProgressCompletedHandler_2__IBuffer__Cardinal = interface(IUnknown)
  ['{06386A7A-E009-5B0B-AB68-A8E48B516647}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__IBuffer__Cardinal; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Storage.Streams.IBuffer,UInt32>
  IAsyncOperationWithProgress_2__IBuffer__Cardinal = interface(IInspectable)
  ['{D26B2819-897F-5C7D-84D6-56D796561431}']
    procedure put_Progress(handler: AsyncOperationProgressHandler_2__IBuffer__Cardinal); safecall;
    function get_Progress: AsyncOperationProgressHandler_2__IBuffer__Cardinal; safecall;
    procedure put_Completed(handler: AsyncOperationWithProgressCompletedHandler_2__IBuffer__Cardinal); safecall;
    function get_Completed: AsyncOperationWithProgressCompletedHandler_2__IBuffer__Cardinal; safecall;
    function GetResults: IBuffer; safecall;
    property Progress: AsyncOperationProgressHandler_2__IBuffer__Cardinal read get_Progress write put_Progress;
    property Completed: AsyncOperationWithProgressCompletedHandler_2__IBuffer__Cardinal read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Storage.Streams.IInputStream
  IInputStream = interface(IInspectable)
  ['{905A0FE2-BC53-11DF-8C49-001E4FC686DA}']
    function ReadAsync(buffer: IBuffer; count: Cardinal; options: InputStreamOptions): IAsyncOperationWithProgress_2__IBuffer__Cardinal; safecall;
  end;

  // DualAPI Interface
  // Windows.Storage.Streams.IOutputStream
  IOutputStream = interface(IInspectable)
  ['{905A0FE6-BC53-11DF-8C49-001E4FC686DA}']
    function WriteAsync(buffer: IBuffer): IAsyncOperationWithProgress_2__Cardinal__Cardinal; safecall;
    function FlushAsync: IAsyncOperation_1__Boolean; safecall;
  end;

  // DualAPI Interface
  // Windows.Storage.Streams.IRandomAccessStream
  IRandomAccessStream = interface(IInspectable)
  ['{905A0FE1-BC53-11DF-8C49-001E4FC686DA}']
    function get_Size: UInt64; safecall;
    procedure put_Size(value: UInt64); safecall;
    function GetInputStreamAt(position: UInt64): IInputStream; safecall;
    function GetOutputStreamAt(position: UInt64): IOutputStream; safecall;
    function get_Position: UInt64; safecall;
    procedure Seek(position: UInt64); safecall;
    function CloneStream: IRandomAccessStream; safecall;
    function get_CanRead: Boolean; safecall;
    function get_CanWrite: Boolean; safecall;
    property CanRead: Boolean read get_CanRead;
    property CanWrite: Boolean read get_CanWrite;
    property Position: UInt64 read get_Position;
    property Size: UInt64 read get_Size write put_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Streams.IRandomAccessStream>
  AsyncOperationCompletedHandler_1__IRandomAccessStream = interface(IUnknown)
  ['{398C4183-793D-5B00-819B-4AEF92485E94}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IRandomAccessStream; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Streams.IRandomAccessStream>
  IAsyncOperation_1__IRandomAccessStream = interface(IInspectable)
  ['{430ECECE-1418-5D19-81B2-5DDB381603CC}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IRandomAccessStream); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IRandomAccessStream; safecall;
    function GetResults: IRandomAccessStream; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IRandomAccessStream read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Storage.Streams.IRandomAccessStreamWithContentType
  IRandomAccessStreamWithContentType = interface(IInspectable)
  ['{CC254827-4B3D-438F-9232-10C76BC7E038}']
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>
  AsyncOperationCompletedHandler_1__IRandomAccessStreamWithContentType_Delegate_Base = interface(IUnknown)
  ['{86D455B2-D795-554C-9C31-BF6539349C19}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>
  AsyncOperationCompletedHandler_1__IRandomAccessStreamWithContentType = interface(AsyncOperationCompletedHandler_1__IRandomAccessStreamWithContentType_Delegate_Base)
  ['{3DDDECF4-1D39-58E8-83B1-DBED541C7F35}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IRandomAccessStreamWithContentType; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>
  IAsyncOperation_1__IRandomAccessStreamWithContentType_Base = interface(IInspectable)
  ['{11C7CC5E-C04E-50E7-A65E-6F6903690C16}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>
  IAsyncOperation_1__IRandomAccessStreamWithContentType = interface(IAsyncOperation_1__IRandomAccessStreamWithContentType_Base)
  ['{C4A57C5E-32B0-55B3-AD13-CE1C23041ED6}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IRandomAccessStreamWithContentType); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IRandomAccessStreamWithContentType; safecall;
    function GetResults: IRandomAccessStreamWithContentType; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IRandomAccessStreamWithContentType read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Storage.Streams.IRandomAccessStreamReference
  [WinRTClassNameAttribute(SRandomAccessStreamReference)]
  IRandomAccessStreamReference = interface(IInspectable)
  ['{33EE3134-1DD6-4E3A-8067-D1C162E8642B}']
    function OpenReadAsync: IAsyncOperation_1__IRandomAccessStreamWithContentType; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Streams.IRandomAccessStreamReference>
  AsyncOperationCompletedHandler_1__IRandomAccessStreamReference_Delegate_Base = interface(IUnknown)
  ['{3D203732-DED7-5D32-87E6-C179781F791F}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Streams.IRandomAccessStreamReference>
  AsyncOperationCompletedHandler_1__IRandomAccessStreamReference = interface(AsyncOperationCompletedHandler_1__IRandomAccessStreamReference_Delegate_Base)
  ['{60847289-EA0B-5DF6-89DF-F2C62CBA9693}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IRandomAccessStreamReference; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Streams.IRandomAccessStreamReference>
  IAsyncOperation_1__IRandomAccessStreamReference_Base = interface(IInspectable)
  ['{D90442CA-543C-504B-9EB9-294BCAD8A283}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Streams.IRandomAccessStreamReference>
  IAsyncOperation_1__IRandomAccessStreamReference = interface(IAsyncOperation_1__IRandomAccessStreamReference_Base)
  ['{65178D50-E6A2-5D16-B244-65E9725E5A0C}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IRandomAccessStreamReference); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IRandomAccessStreamReference; safecall;
    function GetResults: IRandomAccessStreamReference; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IRandomAccessStreamReference read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.Streams.IRandomAccessStreamReference>
  IKeyValuePair_2__HSTRING__IRandomAccessStreamReference = interface(IInspectable)
  ['{02C75FC1-0806-5B2B-A690-DA0F3E03EF45}']
    function get_Key: HSTRING; safecall;
    function get_Value: IRandomAccessStreamReference; safecall;
    property Key: HSTRING read get_Key;
    property Value: IRandomAccessStreamReference read get_Value;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.Streams.IRandomAccessStreamReference>>
  IIterator_1__IKeyValuePair_2__HSTRING__IRandomAccessStreamReference = interface(IInspectable)
  ['{F68346CB-785C-5C53-A795-4A270766A47A}']
    function get_Current: IKeyValuePair_2__HSTRING__IRandomAccessStreamReference; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIKeyValuePair_2__HSTRING__IRandomAccessStreamReference): Cardinal; safecall;
    property Current: IKeyValuePair_2__HSTRING__IRandomAccessStreamReference read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.Streams.IRandomAccessStreamReference>>
  IIterable_1__IKeyValuePair_2__HSTRING__IRandomAccessStreamReference = interface(IInspectable)
  ['{8D579E1F-0FF6-5010-A14B-6C7DE8433955}']
    function First: IIterator_1__IKeyValuePair_2__HSTRING__IRandomAccessStreamReference; safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IMapView`2<String,Windows.Storage.Streams.IRandomAccessStreamReference>
  IMapView_2__HSTRING__IRandomAccessStreamReference_Base = interface(IInspectable)
  ['{0A4CE7A5-DFE0-5796-A438-EFFDFAA31F1B}']
  end;
  // Windows.Foundation.Collections.IMapView`2<String,Windows.Storage.Streams.IRandomAccessStreamReference>
  IMapView_2__HSTRING__IRandomAccessStreamReference = interface(IMapView_2__HSTRING__IRandomAccessStreamReference_Base)
  ['{20784CBD-B6FB-530A-B732-5375919F30B8}']
    function Lookup(key: HSTRING): IRandomAccessStreamReference; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: HSTRING): Boolean; safecall;
    procedure Split(out first: IMapView_2__HSTRING__IRandomAccessStreamReference; out second: IMapView_2__HSTRING__IRandomAccessStreamReference); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IMapView`2<String,Windows.Storage.Streams.IRandomAccessStreamReference>>
  AsyncOperationCompletedHandler_1__IMapView_2__HSTRING__IRandomAccessStreamReference = interface(IUnknown)
  ['{2D6EFF82-24CB-5680-9184-AD687A705A8C}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IMapView_2__HSTRING__IRandomAccessStreamReference; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IMapView`2<String,Windows.Storage.Streams.IRandomAccessStreamReference>>
  IAsyncOperation_1__IMapView_2__HSTRING__IRandomAccessStreamReference = interface(IInspectable)
  ['{D2D20F27-DBCC-571C-9ADF-DDE7A5AF53CA}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IMapView_2__HSTRING__IRandomAccessStreamReference); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IMapView_2__HSTRING__IRandomAccessStreamReference; safecall;
    function GetResults: IMapView_2__HSTRING__IRandomAccessStreamReference; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IMapView_2__HSTRING__IRandomAccessStreamReference read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IMap`2<String,Windows.Storage.Streams.IRandomAccessStreamReference>
  IMap_2__HSTRING__IRandomAccessStreamReference = interface(IInspectable)
  ['{6C5B38B7-9D17-5B5F-A04F-3730A82FD9B8}']
    function Lookup(key: HSTRING): IRandomAccessStreamReference; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: HSTRING): Boolean; safecall;
    function GetView: IMapView_2__HSTRING__IRandomAccessStreamReference; safecall;
    function Insert(key: HSTRING; value: IRandomAccessStreamReference): Boolean; safecall;
    procedure Remove(key: HSTRING); safecall;
    procedure Clear; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Storage.Streams.IBuffer>
  IIterator_1__IBuffer = interface(IInspectable)
  ['{AFEE38E0-F882-5F10-9655-1FC98CC8CCE5}']
    function get_Current: IBuffer; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIBuffer): Cardinal; safecall;
    property Current: IBuffer read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Storage.Streams.IBuffer>
  IIterable_1__IBuffer = interface(IInspectable)
  ['{902972BF-A984-5443-B1C5-2F04A99E1FCA}']
    function First: IIterator_1__IBuffer; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Storage.Streams.IBuffer>
  IVectorView_1__IBuffer = interface(IInspectable)
  ['{FD944562-11D6-5EAB-BD72-701993B68FAC}']
    function GetAt(index: Cardinal): IBuffer; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IBuffer; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIBuffer): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IKeyValuePair`2<UInt32,Windows.Storage.Streams.IBuffer>
  IKeyValuePair_2__Cardinal__IBuffer = interface(IInspectable)
  ['{82A3A3B7-E04A-5395-8487-7F94F1508CE7}']
    function get_Key: Cardinal; safecall;
    function get_Value: IBuffer; safecall;
    property Key: Cardinal read get_Key;
    property Value: IBuffer read get_Value;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<UInt32,Windows.Storage.Streams.IBuffer>>
  IIterator_1__IKeyValuePair_2__Cardinal__IBuffer = interface(IInspectable)
  ['{A295FA0C-C99F-5109-8AB9-91534BB48C9B}']
    function get_Current: IKeyValuePair_2__Cardinal__IBuffer; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIKeyValuePair_2__Cardinal__IBuffer): Cardinal; safecall;
    property Current: IKeyValuePair_2__Cardinal__IBuffer read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<UInt32,Windows.Storage.Streams.IBuffer>>
  IIterable_1__IKeyValuePair_2__Cardinal__IBuffer = interface(IInspectable)
  ['{4FE7FE23-22B1-528C-881D-A4ECEAEF0F11}']
    function First: IIterator_1__IKeyValuePair_2__Cardinal__IBuffer; safecall;
  end;

  // Windows.Foundation.Collections.IMapView`2<UInt32,Windows.Storage.Streams.IBuffer>
  IMapView_2__Cardinal__IBuffer = interface(IInspectable)
  ['{57DC41E6-8B4D-5910-9703-D7C668436852}']
    function Lookup(key: Cardinal): IBuffer; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: Cardinal): Boolean; safecall;
    procedure Split(out first: IMapView_2__Cardinal__IBuffer; out second: IMapView_2__Cardinal__IBuffer); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IMapView`2<UInt32,Windows.Storage.Streams.IBuffer>>
  AsyncOperationCompletedHandler_1__IMapView_2__Cardinal__IBuffer = interface(IUnknown)
  ['{92C2E4D0-7C25-596B-9135-10D1472E6968}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IMapView_2__Cardinal__IBuffer; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IMapView`2<UInt32,Windows.Storage.Streams.IBuffer>>
  IAsyncOperation_1__IMapView_2__Cardinal__IBuffer = interface(IInspectable)
  ['{D4904DED-BC1D-5933-AECF-E42C5D465BFF}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IMapView_2__Cardinal__IBuffer); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IMapView_2__Cardinal__IBuffer; safecall;
    function GetResults: IMapView_2__Cardinal__IBuffer; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IMapView_2__Cardinal__IBuffer read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IMap`2<UInt32,Windows.Storage.Streams.IBuffer>
  IMap_2__Cardinal__IBuffer = interface(IInspectable)
  ['{5D2591DF-48C5-5734-9EF1-BD639B032007}']
    function Lookup(key: Cardinal): IBuffer; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: Cardinal): Boolean; safecall;
    function GetView: IMapView_2__Cardinal__IBuffer; safecall;
    function Insert(key: Cardinal; value: IBuffer): Boolean; safecall;
    procedure Remove(key: Cardinal); safecall;
    procedure Clear; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Streams.IBuffer>
  AsyncOperationCompletedHandler_1__IBuffer = interface(IUnknown)
  ['{51C3D2FD-B8A1-5620-B746-7EE6D533ACA3}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IBuffer; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Streams.IBuffer>
  IAsyncOperation_1__IBuffer = interface(IInspectable)
  ['{3BEE8834-B9A7-5A80-A746-5EF097227878}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IBuffer); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IBuffer; safecall;
    function GetResults: IBuffer; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IBuffer read get_Completed write put_Completed;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Streams.IOutputStream>
  AsyncOperationCompletedHandler_1__IOutputStream = interface(IUnknown)
  ['{BCB37F4F-3AF4-561C-A9E3-EEF1738494D7}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IOutputStream; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Streams.IOutputStream>
  IAsyncOperation_1__IOutputStream = interface(IInspectable)
  ['{E8736833-D013-5361-977D-C5E99934680E}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IOutputStream); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IOutputStream; safecall;
    function GetResults: IOutputStream; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IOutputStream read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Storage.Streams.IDataReader
  [WinRTClassNameAttribute(SDataReader)]
  IDataReader = interface(IInspectable)
  ['{E2B50029-B4C1-4314-A4B8-FB813A2F275E}']
    function get_UnconsumedBufferLength: Cardinal; safecall;
    function get_UnicodeEncoding: UnicodeEncoding; safecall;
    procedure put_UnicodeEncoding(value: UnicodeEncoding); safecall;
    function get_ByteOrder: ByteOrder; safecall;
    procedure put_ByteOrder(value: ByteOrder); safecall;
    function get_InputStreamOptions: InputStreamOptions; safecall;
    procedure put_InputStreamOptions(value: InputStreamOptions); safecall;
    function ReadByte: Byte; safecall;
    procedure ReadBytes(valueSize: Cardinal; value: PByte); safecall;
    function ReadBuffer(length: Cardinal): IBuffer; safecall;
    function ReadBoolean: Boolean; safecall;
    function ReadGuid: TGuid; safecall;
    function ReadInt16: SmallInt; safecall;
    function ReadInt32: Integer; safecall;
    function ReadInt64: Int64; safecall;
    function ReadUInt16: Word; safecall;
    function ReadUInt32: Cardinal; safecall;
    function ReadUInt64: UInt64; safecall;
    function ReadSingle: Single; safecall;
    function ReadDouble: Double; safecall;
    function ReadString(codeUnitCount: Cardinal): HSTRING; safecall;
    function ReadDateTime: DateTime; safecall;
    function ReadTimeSpan: TimeSpan; safecall;
    function LoadAsync(count: Cardinal): IAsyncOperation_1__Cardinal; safecall;
    function DetachBuffer: IBuffer; safecall;
    function DetachStream: IInputStream; safecall;
    property ByteOrder: ByteOrder read get_ByteOrder write put_ByteOrder;
    property InputStreamOptions: InputStreamOptions read get_InputStreamOptions write put_InputStreamOptions;
    property UnconsumedBufferLength: Cardinal read get_UnconsumedBufferLength;
    property UnicodeEncoding: UnicodeEncoding read get_UnicodeEncoding write put_UnicodeEncoding;
  end;

  // Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.Streams.IBuffer>
  IKeyValuePair_2__HSTRING__IBuffer = interface(IInspectable)
  ['{9114F794-2CEB-5B03-9B22-36884E1F58B3}']
    function get_Key: HSTRING; safecall;
    function get_Value: IBuffer; safecall;
    property Key: HSTRING read get_Key;
    property Value: IBuffer read get_Value;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.Streams.IBuffer>>
  IIterator_1__IKeyValuePair_2__HSTRING__IBuffer = interface(IInspectable)
  ['{790ACB62-C4B3-57EA-A152-9E219371C6DC}']
    function get_Current: IKeyValuePair_2__HSTRING__IBuffer; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIKeyValuePair_2__HSTRING__IBuffer): Cardinal; safecall;
    property Current: IKeyValuePair_2__HSTRING__IBuffer read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Foundation.Collections.IKeyValuePair`2<String,Windows.Storage.Streams.IBuffer>>
  IIterable_1__IKeyValuePair_2__HSTRING__IBuffer = interface(IInspectable)
  ['{3C9FFA92-5123-5AC4-B111-03C215F0C51C}']
    function First: IIterator_1__IKeyValuePair_2__HSTRING__IBuffer; safecall;
  end;

  // Windows.Foundation.Collections.IMapView`2<String,Windows.Storage.Streams.IBuffer>
  IMapView_2__HSTRING__IBuffer = interface(IInspectable)
  ['{2CFEEC4F-E261-5F4C-AEE1-C78518E9D5B9}']
    function Lookup(key: HSTRING): IBuffer; safecall;
    function get_Size: Cardinal; safecall;
    function HasKey(key: HSTRING): Boolean; safecall;
    procedure Split(out first: IMapView_2__HSTRING__IBuffer; out second: IMapView_2__HSTRING__IBuffer); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>
  IIterator_1__IRandomAccessStreamWithContentType = interface(IInspectable)
  ['{F225500A-EE51-56E4-BAC4-C835CF10C316}']
    function get_Current: IRandomAccessStreamWithContentType; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIRandomAccessStreamWithContentType): Cardinal; safecall;
    property Current: IRandomAccessStreamWithContentType read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>
  IIterable_1__IRandomAccessStreamWithContentType_Base = interface(IInspectable)
  ['{034EA0C4-C20E-5C0C-BA31-64212F28E650}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>
  IIterable_1__IRandomAccessStreamWithContentType = interface(IIterable_1__IRandomAccessStreamWithContentType_Base)
  ['{C6B83736-1F57-5E24-9238-702C585CC3BB}']
    function First: IIterator_1__IRandomAccessStreamWithContentType; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>
  IVectorView_1__IRandomAccessStreamWithContentType = interface(IInspectable)
  ['{20A82375-0F34-55AF-AE7E-AE77BC3D542F}']
    function GetAt(index: Cardinal): IRandomAccessStreamWithContentType; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IRandomAccessStreamWithContentType; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIRandomAccessStreamWithContentType): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IRandomAccessStreamWithContentType = interface(IUnknown)
  ['{4572C48A-AAC4-5B60-AB1E-8561D15763BE}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__IRandomAccessStreamWithContentType; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Storage.Streams.IRandomAccessStreamWithContentType>>
  IAsyncOperation_1__IVectorView_1__IRandomAccessStreamWithContentType = interface(IInspectable)
  ['{93177A05-73F1-563E-9CB7-99C2A51D8E63}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__IRandomAccessStreamWithContentType); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IRandomAccessStreamWithContentType; safecall;
    function GetResults: IVectorView_1__IRandomAccessStreamWithContentType; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IRandomAccessStreamWithContentType read get_Completed write put_Completed;
  end;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Storage.Streams.IBuffer,UInt64>
  AsyncOperationProgressHandler_2__IBuffer__UInt64 = interface(IUnknown)
  ['{D17F5EB6-B422-5E26-A817-7E0FD08F75D5}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__IBuffer__UInt64; progressInfo: UInt64); safecall;
  end;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Storage.Streams.IBuffer,UInt64>
  AsyncOperationWithProgressCompletedHandler_2__IBuffer__UInt64 = interface(IUnknown)
  ['{ABC81235-39C7-59BF-9948-2D14A93D40FD}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__IBuffer__UInt64; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Storage.Streams.IBuffer,UInt64>
  IAsyncOperationWithProgress_2__IBuffer__UInt64 = interface(IInspectable)
  ['{AD960E7F-D73B-56E4-A58C-6EC7678CFD88}']
    procedure put_Progress(handler: AsyncOperationProgressHandler_2__IBuffer__UInt64); safecall;
    function get_Progress: AsyncOperationProgressHandler_2__IBuffer__UInt64; safecall;
    procedure put_Completed(handler: AsyncOperationWithProgressCompletedHandler_2__IBuffer__UInt64); safecall;
    function get_Completed: AsyncOperationWithProgressCompletedHandler_2__IBuffer__UInt64; safecall;
    function GetResults: IBuffer; safecall;
    property Progress: AsyncOperationProgressHandler_2__IBuffer__UInt64 read get_Progress write put_Progress;
    property Completed: AsyncOperationWithProgressCompletedHandler_2__IBuffer__UInt64 read get_Completed write put_Completed;
  end;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Storage.Streams.IInputStream,UInt64>
  AsyncOperationProgressHandler_2__IInputStream__UInt64 = interface(IUnknown)
  ['{F9B2E7F6-762F-50DB-95DD-7F6C6EC47090}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__IInputStream__UInt64; progressInfo: UInt64); safecall;
  end;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Storage.Streams.IInputStream,UInt64>
  AsyncOperationWithProgressCompletedHandler_2__IInputStream__UInt64 = interface(IUnknown)
  ['{8DB69706-3DD1-5A28-986A-93BE0776D9C3}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__IInputStream__UInt64; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Storage.Streams.IInputStream,UInt64>
  IAsyncOperationWithProgress_2__IInputStream__UInt64 = interface(IInspectable)
  ['{455AA601-F13E-5DEE-B9CB-16B531996327}']
    procedure put_Progress(handler: AsyncOperationProgressHandler_2__IInputStream__UInt64); safecall;
    function get_Progress: AsyncOperationProgressHandler_2__IInputStream__UInt64; safecall;
    procedure put_Completed(handler: AsyncOperationWithProgressCompletedHandler_2__IInputStream__UInt64); safecall;
    function get_Completed: AsyncOperationWithProgressCompletedHandler_2__IInputStream__UInt64; safecall;
    function GetResults: IInputStream; safecall;
    property Progress: AsyncOperationProgressHandler_2__IInputStream__UInt64 read get_Progress write put_Progress;
    property Completed: AsyncOperationWithProgressCompletedHandler_2__IInputStream__UInt64 read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Storage.Streams.IDataReaderFactory
  [WinRTClassNameAttribute(SDataReader)]
  IDataReaderFactory = interface(IInspectable)
  ['{D7527847-57DA-4E15-914C-06806699A098}']
    function CreateDataReader(inputStream: IInputStream): IDataReader; safecall;
  end;

  // DualAPI Interface
  // Windows.Storage.Streams.IDataReaderStatics
  [WinRTClassNameAttribute(SDataReader)]
  IDataReaderStatics = interface(IInspectable)
  ['{11FCBFC8-F93A-471B-B121-F379E349313C}']
    function FromBuffer(buffer: IBuffer): IDataReader; safecall;
  end;

  // DualAPI Interface
  // Windows.Storage.Streams.IDataWriter
  [WinRTClassNameAttribute(SDataWriter)]
  IDataWriter = interface(IInspectable)
  ['{64B89265-D341-4922-B38A-DD4AF8808C4E}']
    function get_UnstoredBufferLength: Cardinal; safecall;
    function get_UnicodeEncoding: UnicodeEncoding; safecall;
    procedure put_UnicodeEncoding(value: UnicodeEncoding); safecall;
    function get_ByteOrder: ByteOrder; safecall;
    procedure put_ByteOrder(value: ByteOrder); safecall;
    procedure WriteByte(value: Byte); safecall;
    procedure WriteBytes(valueSize: Cardinal; value: PByte); safecall;
    procedure WriteBuffer(buffer: IBuffer); overload; safecall;
    procedure WriteBuffer(buffer: IBuffer; start: Cardinal; count: Cardinal); overload; safecall;
    procedure WriteBoolean(value: Boolean); safecall;
    procedure WriteGuid(value: TGuid); safecall;
    procedure WriteInt16(value: SmallInt); safecall;
    procedure WriteInt32(value: Integer); safecall;
    procedure WriteInt64(value: Int64); safecall;
    procedure WriteUInt16(value: Word); safecall;
    procedure WriteUInt32(value: Cardinal); safecall;
    procedure WriteUInt64(value: UInt64); safecall;
    procedure WriteSingle(value: Single); safecall;
    procedure WriteDouble(value: Double); safecall;
    procedure WriteDateTime(value: DateTime); safecall;
    procedure WriteTimeSpan(value: TimeSpan); safecall;
    function WriteString(value: HSTRING): Cardinal; safecall;
    function MeasureString(value: HSTRING): Cardinal; safecall;
    function StoreAsync: IAsyncOperation_1__Cardinal; safecall;
    function FlushAsync: IAsyncOperation_1__Boolean; safecall;
    function DetachBuffer: IBuffer; safecall;
    function DetachStream: IOutputStream; safecall;
    property ByteOrder: ByteOrder read get_ByteOrder write put_ByteOrder;
    property UnicodeEncoding: UnicodeEncoding read get_UnicodeEncoding write put_UnicodeEncoding;
    property UnstoredBufferLength: Cardinal read get_UnstoredBufferLength;
  end;

  // DualAPI Interface
  // Windows.Storage.Streams.IDataWriterFactory
  [WinRTClassNameAttribute(SDataWriter)]
  IDataWriterFactory = interface(IInspectable)
  ['{338C67C2-8B84-4C2B-9C50-7B8767847A1F}']
    function CreateDataWriter(outputStream: IOutputStream): IDataWriter; safecall;
  end;

  // DualAPI Interface
  // Windows.Storage.Streams.IContentTypeProvider
  IContentTypeProvider = interface(IInspectable)
  ['{97D098A5-3B99-4DE9-88A5-E11D2F50C795}']
    function get_ContentType: HSTRING; safecall;
    property ContentType: HSTRING read get_ContentType;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Storage.Streams.IInputStream>
  AsyncOperationCompletedHandler_1__IInputStream = interface(IUnknown)
  ['{D0BD0125-9049-57A3-BD66-E2525D98C814}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IInputStream; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Storage.Streams.IInputStream>
  IAsyncOperation_1__IInputStream = interface(IInspectable)
  ['{A8FE0732-556D-5841-B7EE-B3450FB52666}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IInputStream); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IInputStream; safecall;
    function GetResults: IInputStream; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IInputStream read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Storage.Streams.IInputStreamReference
  IInputStreamReference = interface(IInspectable)
  ['{43929D18-5EC9-4B5A-919C-4205B0C804B6}']
    function OpenSequentialReadAsync: IAsyncOperation_1__IInputStream; safecall;
  end;

  // DualAPI Interface
  // Windows.Storage.Streams.IRandomAccessStreamReferenceStatics
  [WinRTClassNameAttribute(SRandomAccessStreamReference)]
  IRandomAccessStreamReferenceStatics = interface(IInspectable)
  ['{857309DC-3FBF-4E7D-986F-EF3B1A07A964}']
    function CreateFromFile(&file: IInspectable{IStorageFile}): IRandomAccessStreamReference; safecall;
    function CreateFromUri(uri: IUriRuntimeClass): IRandomAccessStreamReference; safecall;
    function CreateFromStream(stream: IRandomAccessStream): IRandomAccessStreamReference; safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Storage.Streams.IRandomAccessStream>
  IIterator_1__IRandomAccessStream = interface(IInspectable)
  ['{C875446A-587F-58DA-897E-3BBE5EC7C30B}']
    function get_Current: IRandomAccessStream; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIRandomAccessStream): Cardinal; safecall;
    property Current: IRandomAccessStream read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Storage.Streams.IRandomAccessStream>
  IIterable_1__IRandomAccessStream = interface(IInspectable)
  ['{BA666A00-1555-5DF4-81A5-07D23F7FFCEB}']
    function First: IIterator_1__IRandomAccessStream; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Storage.Streams.IRandomAccessStream>
  IVectorView_1__IRandomAccessStream = interface(IInspectable)
  ['{92CD0A46-2266-5CD6-9293-E111299F2793}']
    function GetAt(index: Cardinal): IRandomAccessStream; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IRandomAccessStream; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIRandomAccessStream): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Storage.Streams.IRandomAccessStream>
  IVector_1__IRandomAccessStream = interface(IInspectable)
  ['{2736B66B-DAA3-5E0C-9842-6A0F44B5440B}']
    function GetAt(index: Cardinal): IRandomAccessStream; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__IRandomAccessStream; safecall;
    function IndexOf(value: IRandomAccessStream; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: IRandomAccessStream); safecall;
    procedure InsertAt(index: Cardinal; value: IRandomAccessStream); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: IRandomAccessStream); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIRandomAccessStream): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PIRandomAccessStream); safecall;
    property Size: Cardinal read get_Size;
  end;


  // Emit Forwarded classes
  // Windows.Storage.Streams.DataReader
  // WinRT Only
  // WhiteListed
  TDataReader = class(TWinRTGenericImportFS<IDataReaderFactory, IDataReaderStatics>)
  public
    // -> IDataReaderStatics
    class function FromBuffer(buffer: IBuffer): IDataReader; static; inline;

    // -> IDataReaderFactory
    class function CreateDataReader(inputStream: IInputStream): IDataReader; static; inline;
  end;

  // Windows.Storage.Streams.DataWriter
  // WinRT Only
  // WhiteListed
  TDataWriter = class(TWinRTGenericImportFI<IDataWriterFactory, IDataWriter>)
  public
    // -> IDataWriterFactory
    class function CreateDataWriter(outputStream: IOutputStream): IDataWriter; static; inline;
  end;

  // Windows.Storage.Streams.RandomAccessStreamReference
  // WinRT Only
  // WhiteListed
  TRandomAccessStreamReference = class(TWinRTGenericImportS<IRandomAccessStreamReferenceStatics>)
  public
    // -> IRandomAccessStreamReferenceStatics
    class function CreateFromFile(&file: IInspectable{IStorageFile}): IRandomAccessStreamReference; static; inline;
    class function CreateFromUri(uri: IUriRuntimeClass): IRandomAccessStreamReference; static; inline;
    class function CreateFromStream(stream: IRandomAccessStream): IRandomAccessStreamReference; static; inline;
  end;


implementation

  // Emit Classes Implementation
 { TDataReader }

class function TDataReader.FromBuffer(buffer: IBuffer): IDataReader;
begin
  Result := Statics.FromBuffer(buffer);
end;

// Factories for : "DataReader"
// Factory: "Windows.Storage.Streams.IDataReaderFactory"
// -> IDataReaderFactory

class function TDataReader.CreateDataReader(inputStream: IInputStream): IDataReader;
begin
  Result := Factory.CreateDataReader(inputStream);
end;


 { TDataWriter }
// Factories for : "DataWriter"
// Factory: "Windows.Storage.Streams.IDataWriterFactory"
// -> IDataWriterFactory

class function TDataWriter.CreateDataWriter(outputStream: IOutputStream): IDataWriter;
begin
  Result := Factory.CreateDataWriter(outputStream);
end;


 { TRandomAccessStreamReference }

class function TRandomAccessStreamReference.CreateFromFile(&file: IInspectable{IStorageFile}): IRandomAccessStreamReference;
begin
  Result := Statics.CreateFromFile(&file);
end;

class function TRandomAccessStreamReference.CreateFromUri(uri: IUriRuntimeClass): IRandomAccessStreamReference;
begin
  Result := Statics.CreateFromUri(uri);
end;

class function TRandomAccessStreamReference.CreateFromStream(stream: IRandomAccessStream): IRandomAccessStreamReference;
begin
  Result := Statics.CreateFromStream(stream);
end;



end.
