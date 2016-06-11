{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Devices.Bluetooth;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.Networking,
  Winapi.Networking.Sockets,
  // Internal Uses...
  Winapi.Storage.Streams,
  Winapi.Foundation,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Devices.Bluetooth Class Names
  // Windows.Devices.Bluetooth.BluetoothClassOfDevice
  // DualAPI
  SBluetoothClassOfDevice = 'Windows.Devices.Bluetooth.BluetoothClassOfDevice';
  // Windows.Devices.Bluetooth.Rfcomm.RfcommDeviceService
  // DualAPI
  SRfcomm_RfcommDeviceService = 'Windows.Devices.Bluetooth.Rfcomm.RfcommDeviceService';
  // Windows.Devices.Bluetooth.BluetoothDevice
  // DualAPI
  SBluetoothDevice = 'Windows.Devices.Bluetooth.BluetoothDevice';
  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattDeviceService
  // DualAPI
  SGenericAttributeProfile_GattDeviceService = 'Windows.Devices.Bluetooth.GenericAttributeProfile.GattDeviceService';
  // Windows.Devices.Bluetooth.BluetoothLEDevice
  // DualAPI
  SBluetoothLEDevice = 'Windows.Devices.Bluetooth.BluetoothLEDevice';
  // Windows.Devices.Bluetooth.BluetoothSignalStrengthFilter
  // DualAPI
  SBluetoothSignalStrengthFilter = 'Windows.Devices.Bluetooth.BluetoothSignalStrengthFilter';
  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattCharacteristic
  // DualAPI
  SGenericAttributeProfile_GattCharacteristic = 'Windows.Devices.Bluetooth.GenericAttributeProfile.GattCharacteristic';
  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattDescriptor
  // DualAPI
  SGenericAttributeProfile_GattDescriptor = 'Windows.Devices.Bluetooth.GenericAttributeProfile.GattDescriptor';
  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattPresentationFormat
  // DualAPI
  SGenericAttributeProfile_GattPresentationFormat = 'Windows.Devices.Bluetooth.GenericAttributeProfile.GattPresentationFormat';
  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattReadResult
  // DualAPI
  SGenericAttributeProfile_GattReadResult = 'Windows.Devices.Bluetooth.GenericAttributeProfile.GattReadResult';
  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattReadClientCharacteristicConfigurationDescriptorResult
  // DualAPI
  SGenericAttributeProfile_GattReadClientCharacteristicConfigurationDescriptorResult = 'Windows.Devices.Bluetooth.GenericAttributeProfile.GattReadClientCharacteristicConfigurationDescriptorResult';
  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattValueChangedEventArgs
  // DualAPI
  SGenericAttributeProfile_GattValueChangedEventArgs = 'Windows.Devices.Bluetooth.GenericAttributeProfile.GattValueChangedEventArgs';
  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattServiceUuids
  // DualAPI
  SGenericAttributeProfile_GattServiceUuids = 'Windows.Devices.Bluetooth.GenericAttributeProfile.GattServiceUuids';
  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattCharacteristicUuids
  // DualAPI
  SGenericAttributeProfile_GattCharacteristicUuids = 'Windows.Devices.Bluetooth.GenericAttributeProfile.GattCharacteristicUuids';
  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattDescriptorUuids
  // DualAPI
  SGenericAttributeProfile_GattDescriptorUuids = 'Windows.Devices.Bluetooth.GenericAttributeProfile.GattDescriptorUuids';
  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattReliableWriteTransaction
  // DualAPI
  SGenericAttributeProfile_GattReliableWriteTransaction = 'Windows.Devices.Bluetooth.GenericAttributeProfile.GattReliableWriteTransaction';
  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattPresentationFormatTypes
  // DualAPI
  SGenericAttributeProfile_GattPresentationFormatTypes = 'Windows.Devices.Bluetooth.GenericAttributeProfile.GattPresentationFormatTypes';
  // Windows.Devices.Bluetooth.Rfcomm.RfcommServiceId
  // DualAPI
  SRfcomm_RfcommServiceId = 'Windows.Devices.Bluetooth.Rfcomm.RfcommServiceId';
  // Windows.Devices.Bluetooth.Rfcomm.RfcommServiceProvider
  // DualAPI
  SRfcomm_RfcommServiceProvider = 'Windows.Devices.Bluetooth.Rfcomm.RfcommServiceProvider';


type
  // Forward declare interfaces
  // Windows.Devices.Bluetooth.Rfcomm.IRfcommServiceId
  Rfcomm_IRfcommServiceId = interface;
  PRfcomm_IRfcommServiceId = ^Rfcomm_IRfcommServiceId;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReadResult
  GenericAttributeProfile_IGattReadResult = interface;
  PGenericAttributeProfile_IGattReadResult = ^GenericAttributeProfile_IGattReadResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReadResult>
  AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadResult = interface;
  PAsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadResult = ^AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReadResult>
  IAsyncOperation_1__GenericAttributeProfile_IGattReadResult = interface;
  PIAsyncOperation_1__GenericAttributeProfile_IGattReadResult = ^IAsyncOperation_1__GenericAttributeProfile_IGattReadResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.GenericAttributeProfile.GattCommunicationStatus>
  AsyncOperationCompletedHandler_1__GenericAttributeProfile_GattCommunicationStatus = interface;
  PAsyncOperationCompletedHandler_1__GenericAttributeProfile_GattCommunicationStatus = ^AsyncOperationCompletedHandler_1__GenericAttributeProfile_GattCommunicationStatus;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.GenericAttributeProfile.GattCommunicationStatus>
  IAsyncOperation_1__GenericAttributeProfile_GattCommunicationStatus = interface;
  PIAsyncOperation_1__GenericAttributeProfile_GattCommunicationStatus = ^IAsyncOperation_1__GenericAttributeProfile_GattCommunicationStatus;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDescriptor
  GenericAttributeProfile_IGattDescriptor = interface;
  PGenericAttributeProfile_IGattDescriptor = ^GenericAttributeProfile_IGattDescriptor;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDescriptor>
  IIterator_1__GenericAttributeProfile_IGattDescriptor = interface;
  PIIterator_1__GenericAttributeProfile_IGattDescriptor = ^IIterator_1__GenericAttributeProfile_IGattDescriptor;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDescriptor>
  IIterable_1__GenericAttributeProfile_IGattDescriptor = interface;
  PIIterable_1__GenericAttributeProfile_IGattDescriptor = ^IIterable_1__GenericAttributeProfile_IGattDescriptor;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDescriptor>
  IVectorView_1__GenericAttributeProfile_IGattDescriptor = interface;
  PIVectorView_1__GenericAttributeProfile_IGattDescriptor = ^IVectorView_1__GenericAttributeProfile_IGattDescriptor;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattPresentationFormat
  GenericAttributeProfile_IGattPresentationFormat = interface;
  PGenericAttributeProfile_IGattPresentationFormat = ^GenericAttributeProfile_IGattPresentationFormat;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattPresentationFormat>
  IIterator_1__GenericAttributeProfile_IGattPresentationFormat = interface;
  PIIterator_1__GenericAttributeProfile_IGattPresentationFormat = ^IIterator_1__GenericAttributeProfile_IGattPresentationFormat;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattPresentationFormat>
  IIterable_1__GenericAttributeProfile_IGattPresentationFormat = interface;
  PIIterable_1__GenericAttributeProfile_IGattPresentationFormat = ^IIterable_1__GenericAttributeProfile_IGattPresentationFormat;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattPresentationFormat>
  IVectorView_1__GenericAttributeProfile_IGattPresentationFormat = interface;
  PIVectorView_1__GenericAttributeProfile_IGattPresentationFormat = ^IVectorView_1__GenericAttributeProfile_IGattPresentationFormat;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReadClientCharacteristicConfigurationDescriptorResult
  GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult = interface;
  PGenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult = ^GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReadClientCharacteristicConfigurationDescriptorResult>
  AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult = interface;
  PAsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult = ^AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReadClientCharacteristicConfigurationDescriptorResult>
  IAsyncOperation_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult = interface;
  PIAsyncOperation_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult = ^IAsyncOperation_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattValueChangedEventArgs
  GenericAttributeProfile_IGattValueChangedEventArgs = interface;
  PGenericAttributeProfile_IGattValueChangedEventArgs = ^GenericAttributeProfile_IGattValueChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristic,Windows.Devices.Bluetooth.GenericAttributeProfile.IGattValueChangedEventArgs>
  TypedEventHandler_2__GenericAttributeProfile_IGattCharacteristic__GenericAttributeProfile_IGattValueChangedEventArgs = interface;
  PTypedEventHandler_2__GenericAttributeProfile_IGattCharacteristic__GenericAttributeProfile_IGattValueChangedEventArgs = ^TypedEventHandler_2__GenericAttributeProfile_IGattCharacteristic__GenericAttributeProfile_IGattValueChangedEventArgs;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristic
  GenericAttributeProfile_IGattCharacteristic = interface;
  PGenericAttributeProfile_IGattCharacteristic = ^GenericAttributeProfile_IGattCharacteristic;

  // Windows.Devices.Bluetooth.IBluetoothSignalStrengthFilter
  IBluetoothSignalStrengthFilter = interface;
  PIBluetoothSignalStrengthFilter = ^IBluetoothSignalStrengthFilter;

  // Windows.Devices.Bluetooth.IBluetoothClassOfDevice
  IBluetoothClassOfDevice = interface;
  PIBluetoothClassOfDevice = ^IBluetoothClassOfDevice;

  // Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService
  Rfcomm_IRfcommDeviceService = interface;
  PRfcomm_IRfcommDeviceService = ^Rfcomm_IRfcommDeviceService;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService>
  IIterator_1__Rfcomm_IRfcommDeviceService = interface;
  PIIterator_1__Rfcomm_IRfcommDeviceService = ^IIterator_1__Rfcomm_IRfcommDeviceService;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService>
  IIterable_1__Rfcomm_IRfcommDeviceService = interface;
  PIIterable_1__Rfcomm_IRfcommDeviceService = ^IIterable_1__Rfcomm_IRfcommDeviceService;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService>
  IVectorView_1__Rfcomm_IRfcommDeviceService = interface;
  PIVectorView_1__Rfcomm_IRfcommDeviceService = ^IVectorView_1__Rfcomm_IRfcommDeviceService;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.IBluetoothDevice,Object>
  TypedEventHandler_2__IBluetoothDevice__IInspectable = interface;
  PTypedEventHandler_2__IBluetoothDevice__IInspectable = ^TypedEventHandler_2__IBluetoothDevice__IInspectable;

  // Windows.Devices.Bluetooth.IBluetoothDevice
  IBluetoothDevice = interface;
  PIBluetoothDevice = ^IBluetoothDevice;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.IBluetoothDevice>
  AsyncOperationCompletedHandler_1__IBluetoothDevice = interface;
  PAsyncOperationCompletedHandler_1__IBluetoothDevice = ^AsyncOperationCompletedHandler_1__IBluetoothDevice;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.IBluetoothDevice>
  IAsyncOperation_1__IBluetoothDevice = interface;
  PIAsyncOperation_1__IBluetoothDevice = ^IAsyncOperation_1__IBluetoothDevice;

  // Windows.Devices.Bluetooth.IBluetoothDeviceStatics
  IBluetoothDeviceStatics = interface;
  PIBluetoothDeviceStatics = ^IBluetoothDeviceStatics;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristic>
  IIterator_1__GenericAttributeProfile_IGattCharacteristic = interface;
  PIIterator_1__GenericAttributeProfile_IGattCharacteristic = ^IIterator_1__GenericAttributeProfile_IGattCharacteristic;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristic>
  IIterable_1__GenericAttributeProfile_IGattCharacteristic = interface;
  PIIterable_1__GenericAttributeProfile_IGattCharacteristic = ^IIterable_1__GenericAttributeProfile_IGattCharacteristic;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristic>
  IVectorView_1__GenericAttributeProfile_IGattCharacteristic = interface;
  PIVectorView_1__GenericAttributeProfile_IGattCharacteristic = ^IVectorView_1__GenericAttributeProfile_IGattCharacteristic;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService
  GenericAttributeProfile_IGattDeviceService = interface;
  PGenericAttributeProfile_IGattDeviceService = ^GenericAttributeProfile_IGattDeviceService;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService>
  IIterator_1__GenericAttributeProfile_IGattDeviceService = interface;
  PIIterator_1__GenericAttributeProfile_IGattDeviceService = ^IIterator_1__GenericAttributeProfile_IGattDeviceService;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService>
  IIterable_1__GenericAttributeProfile_IGattDeviceService = interface;
  PIIterable_1__GenericAttributeProfile_IGattDeviceService = ^IIterable_1__GenericAttributeProfile_IGattDeviceService;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService>
  IVectorView_1__GenericAttributeProfile_IGattDeviceService = interface;
  PIVectorView_1__GenericAttributeProfile_IGattDeviceService = ^IVectorView_1__GenericAttributeProfile_IGattDeviceService;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.IBluetoothLEDevice,Object>
  TypedEventHandler_2__IBluetoothLEDevice__IInspectable = interface;
  PTypedEventHandler_2__IBluetoothLEDevice__IInspectable = ^TypedEventHandler_2__IBluetoothLEDevice__IInspectable;

  // Windows.Devices.Bluetooth.IBluetoothLEDevice
  IBluetoothLEDevice = interface;
  PIBluetoothLEDevice = ^IBluetoothLEDevice;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.IBluetoothLEDevice>
  AsyncOperationCompletedHandler_1__IBluetoothLEDevice = interface;
  PAsyncOperationCompletedHandler_1__IBluetoothLEDevice = ^AsyncOperationCompletedHandler_1__IBluetoothLEDevice;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.IBluetoothLEDevice>
  IAsyncOperation_1__IBluetoothLEDevice = interface;
  PIAsyncOperation_1__IBluetoothLEDevice = ^IAsyncOperation_1__IBluetoothLEDevice;

  // Windows.Devices.Bluetooth.IBluetoothLEDeviceStatics
  IBluetoothLEDeviceStatics = interface;
  PIBluetoothLEDeviceStatics = ^IBluetoothLEDeviceStatics;

  // Windows.Devices.Bluetooth.IBluetoothClassOfDeviceStatics
  IBluetoothClassOfDeviceStatics = interface;
  PIBluetoothClassOfDeviceStatics = ^IBluetoothClassOfDeviceStatics;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService>
  AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattDeviceService = interface;
  PAsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattDeviceService = ^AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattDeviceService;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService>
  IAsyncOperation_1__GenericAttributeProfile_IGattDeviceService = interface;
  PIAsyncOperation_1__GenericAttributeProfile_IGattDeviceService = ^IAsyncOperation_1__GenericAttributeProfile_IGattDeviceService;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceServiceStatics
  GenericAttributeProfile_IGattDeviceServiceStatics = interface;
  PGenericAttributeProfile_IGattDeviceServiceStatics = ^GenericAttributeProfile_IGattDeviceServiceStatics;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristicStatics
  GenericAttributeProfile_IGattCharacteristicStatics = interface;
  PGenericAttributeProfile_IGattCharacteristicStatics = ^GenericAttributeProfile_IGattCharacteristicStatics;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristic2
  GenericAttributeProfile_IGattCharacteristic2 = interface;
  PGenericAttributeProfile_IGattCharacteristic2 = ^GenericAttributeProfile_IGattCharacteristic2;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDescriptorStatics
  GenericAttributeProfile_IGattDescriptorStatics = interface;
  PGenericAttributeProfile_IGattDescriptorStatics = ^GenericAttributeProfile_IGattDescriptorStatics;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattPresentationFormatStatics
  GenericAttributeProfile_IGattPresentationFormatStatics = interface;
  PGenericAttributeProfile_IGattPresentationFormatStatics = ^GenericAttributeProfile_IGattPresentationFormatStatics;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattPresentationFormatTypesStatics
  GenericAttributeProfile_IGattPresentationFormatTypesStatics = interface;
  PGenericAttributeProfile_IGattPresentationFormatTypesStatics = ^GenericAttributeProfile_IGattPresentationFormatTypesStatics;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattServiceUuidsStatics
  GenericAttributeProfile_IGattServiceUuidsStatics = interface;
  PGenericAttributeProfile_IGattServiceUuidsStatics = ^GenericAttributeProfile_IGattServiceUuidsStatics;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattServiceUuidsStatics2
  GenericAttributeProfile_IGattServiceUuidsStatics2 = interface;
  PGenericAttributeProfile_IGattServiceUuidsStatics2 = ^GenericAttributeProfile_IGattServiceUuidsStatics2;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristicUuidsStatics
  GenericAttributeProfile_IGattCharacteristicUuidsStatics = interface;
  PGenericAttributeProfile_IGattCharacteristicUuidsStatics = ^GenericAttributeProfile_IGattCharacteristicUuidsStatics;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristicUuidsStatics2
  GenericAttributeProfile_IGattCharacteristicUuidsStatics2 = interface;
  PGenericAttributeProfile_IGattCharacteristicUuidsStatics2 = ^GenericAttributeProfile_IGattCharacteristicUuidsStatics2;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDescriptorUuidsStatics
  GenericAttributeProfile_IGattDescriptorUuidsStatics = interface;
  PGenericAttributeProfile_IGattDescriptorUuidsStatics = ^GenericAttributeProfile_IGattDescriptorUuidsStatics;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReliableWriteTransaction
  GenericAttributeProfile_IGattReliableWriteTransaction = interface;
  PGenericAttributeProfile_IGattReliableWriteTransaction = ^GenericAttributeProfile_IGattReliableWriteTransaction;

  // Windows.Devices.Bluetooth.Rfcomm.IRfcommServiceIdStatics
  Rfcomm_IRfcommServiceIdStatics = interface;
  PRfcomm_IRfcommServiceIdStatics = ^Rfcomm_IRfcommServiceIdStatics;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService>
  AsyncOperationCompletedHandler_1__Rfcomm_IRfcommDeviceService = interface;
  PAsyncOperationCompletedHandler_1__Rfcomm_IRfcommDeviceService = ^AsyncOperationCompletedHandler_1__Rfcomm_IRfcommDeviceService;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService>
  IAsyncOperation_1__Rfcomm_IRfcommDeviceService = interface;
  PIAsyncOperation_1__Rfcomm_IRfcommDeviceService = ^IAsyncOperation_1__Rfcomm_IRfcommDeviceService;

  // Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceServiceStatics
  Rfcomm_IRfcommDeviceServiceStatics = interface;
  PRfcomm_IRfcommDeviceServiceStatics = ^Rfcomm_IRfcommDeviceServiceStatics;

  // Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService2
  Rfcomm_IRfcommDeviceService2 = interface;
  PRfcomm_IRfcommDeviceService2 = ^Rfcomm_IRfcommDeviceService2;

  // Windows.Devices.Bluetooth.Rfcomm.IRfcommServiceProvider
  Rfcomm_IRfcommServiceProvider = interface;
  PRfcomm_IRfcommServiceProvider = ^Rfcomm_IRfcommServiceProvider;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommServiceProvider>
  AsyncOperationCompletedHandler_1__Rfcomm_IRfcommServiceProvider = interface;
  PAsyncOperationCompletedHandler_1__Rfcomm_IRfcommServiceProvider = ^AsyncOperationCompletedHandler_1__Rfcomm_IRfcommServiceProvider;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommServiceProvider>
  IAsyncOperation_1__Rfcomm_IRfcommServiceProvider = interface;
  PIAsyncOperation_1__Rfcomm_IRfcommServiceProvider = ^IAsyncOperation_1__Rfcomm_IRfcommServiceProvider;

  // Windows.Devices.Bluetooth.Rfcomm.IRfcommServiceProviderStatics
  Rfcomm_IRfcommServiceProviderStatics = interface;
  PRfcomm_IRfcommServiceProviderStatics = ^Rfcomm_IRfcommServiceProviderStatics;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService2
  GenericAttributeProfile_IGattDeviceService2 = interface;
  PGenericAttributeProfile_IGattDeviceService2 = ^GenericAttributeProfile_IGattDeviceService2;


  // Emit Forwarded interfaces
  // Windows.Devices.Bluetooth Interfaces
  // DualAPI Interface
  // Windows.Devices.Bluetooth.Rfcomm.IRfcommServiceId
  [WinRTClassNameAttribute(SRfcomm_RfcommServiceId)]
  Rfcomm_IRfcommServiceId = interface(IInspectable)
  ['{22629204-7E02-4017-8136-DA1B6A1B9BBF}']
    function get_Uuid: TGuid; safecall;
    function AsShortId: Cardinal; safecall;
    function AsString: HSTRING; safecall;
    property Uuid: TGuid read get_Uuid;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReadResult
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattReadResult)]
  GenericAttributeProfile_IGattReadResult = interface(IInspectable)
  ['{63A66F08-1AEA-4C4C-A50F-97BAE474B348}']
    function get_Status: GenericAttributeProfile_GattCommunicationStatus; safecall;
    function get_Value: IBuffer; safecall;
    property Status: GenericAttributeProfile_GattCommunicationStatus read get_Status;
    property Value: IBuffer read get_Value;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReadResult>
  AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadResult_Delegate_Base = interface(IUnknown)
  ['{D8992AA0-EAC2-55B7-92C5-894886BEB0CA}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReadResult>
  AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadResult = interface(AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadResult_Delegate_Base)
  ['{303B29E1-492A-5B34-8342-81B827B67051}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__GenericAttributeProfile_IGattReadResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReadResult>
  IAsyncOperation_1__GenericAttributeProfile_IGattReadResult_Base = interface(IInspectable)
  ['{D40432A8-1E14-51D0-B49B-AE2CE1AA05E5}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReadResult>
  IAsyncOperation_1__GenericAttributeProfile_IGattReadResult = interface(IAsyncOperation_1__GenericAttributeProfile_IGattReadResult_Base)
  ['{55FC83CB-542E-5E30-AF71-8E8CD0BD3DEB}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadResult; safecall;
    function GetResults: GenericAttributeProfile_IGattReadResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadResult read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.GenericAttributeProfile.GattCommunicationStatus>
  AsyncOperationCompletedHandler_1__GenericAttributeProfile_GattCommunicationStatus_Delegate_Base = interface(IUnknown)
  ['{2154117A-978D-59DB-99CF-6B690CB3389B}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.GenericAttributeProfile.GattCommunicationStatus>
  AsyncOperationCompletedHandler_1__GenericAttributeProfile_GattCommunicationStatus = interface(AsyncOperationCompletedHandler_1__GenericAttributeProfile_GattCommunicationStatus_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__GenericAttributeProfile_GattCommunicationStatus; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.GenericAttributeProfile.GattCommunicationStatus>
  IAsyncOperation_1__GenericAttributeProfile_GattCommunicationStatus_Base = interface(IInspectable)
  ['{3FF69516-1BFB-52E9-9EE6-E5CDB78E1683}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.GenericAttributeProfile.GattCommunicationStatus>
  IAsyncOperation_1__GenericAttributeProfile_GattCommunicationStatus = interface(IAsyncOperation_1__GenericAttributeProfile_GattCommunicationStatus_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__GenericAttributeProfile_GattCommunicationStatus); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__GenericAttributeProfile_GattCommunicationStatus; safecall;
    function GetResults: GenericAttributeProfile_GattCommunicationStatus; safecall;
    property Completed: AsyncOperationCompletedHandler_1__GenericAttributeProfile_GattCommunicationStatus read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDescriptor
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattDescriptor)]
  GenericAttributeProfile_IGattDescriptor = interface(IInspectable)
  ['{92055F2B-8084-4344-B4C2-284DE19A8506}']
    function get_ProtectionLevel: GenericAttributeProfile_GattProtectionLevel; safecall;
    procedure put_ProtectionLevel(value: GenericAttributeProfile_GattProtectionLevel); safecall;
    function get_Uuid: TGuid; safecall;
    function get_AttributeHandle: Word; safecall;
    function ReadValueAsync: IAsyncOperation_1__GenericAttributeProfile_IGattReadResult; overload; safecall;
    function ReadValueAsync(cacheMode: BluetoothCacheMode): IAsyncOperation_1__GenericAttributeProfile_IGattReadResult; overload; safecall;
    function WriteValueAsync(value: IBuffer): IAsyncOperation_1__GenericAttributeProfile_GattCommunicationStatus; safecall;
    property AttributeHandle: Word read get_AttributeHandle;
    property ProtectionLevel: GenericAttributeProfile_GattProtectionLevel read get_ProtectionLevel write put_ProtectionLevel;
    property Uuid: TGuid read get_Uuid;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDescriptor>
  IIterator_1__GenericAttributeProfile_IGattDescriptor = interface(IInspectable)
  ['{D69006B8-AE84-5F9F-8AE8-6E247776A601}']
    function get_Current: GenericAttributeProfile_IGattDescriptor; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PGenericAttributeProfile_IGattDescriptor): Cardinal; safecall;
    property Current: GenericAttributeProfile_IGattDescriptor read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDescriptor>
  IIterable_1__GenericAttributeProfile_IGattDescriptor_Base = interface(IInspectable)
  ['{30E2FFC4-3AA3-5219-9A18-CA2D0B6562E8}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDescriptor>
  IIterable_1__GenericAttributeProfile_IGattDescriptor = interface(IIterable_1__GenericAttributeProfile_IGattDescriptor_Base)
  ['{FFADB7B1-7363-520B-AAE6-9C4076F019D2}']
    function First: IIterator_1__GenericAttributeProfile_IGattDescriptor; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDescriptor>
  IVectorView_1__GenericAttributeProfile_IGattDescriptor = interface(IInspectable)
  ['{F23D1B8A-27DF-547D-9482-1DD9089D8A99}']
    function GetAt(index: Cardinal): GenericAttributeProfile_IGattDescriptor; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: GenericAttributeProfile_IGattDescriptor; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PGenericAttributeProfile_IGattDescriptor): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattPresentationFormat
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattPresentationFormat)]
  GenericAttributeProfile_IGattPresentationFormat = interface(IInspectable)
  ['{196D0021-FAAD-45DC-AE5B-2AC3184E84DB}']
    function get_FormatType: Byte; safecall;
    function get_Exponent: Integer; safecall;
    function get_Unit: Word; safecall;
    function get_Namespace: Byte; safecall;
    function get_Description: Word; safecall;
    property Description: Word read get_Description;
    property Exponent: Integer read get_Exponent;
    property FormatType: Byte read get_FormatType;
    property Namespace: Byte read get_Namespace;
    property &Unit: Word read get_Unit;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattPresentationFormat>
  IIterator_1__GenericAttributeProfile_IGattPresentationFormat = interface(IInspectable)
  ['{5ACD2F6A-F8C6-59BD-A0D2-A103C4CA22AA}']
    function get_Current: GenericAttributeProfile_IGattPresentationFormat; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PGenericAttributeProfile_IGattPresentationFormat): Cardinal; safecall;
    property Current: GenericAttributeProfile_IGattPresentationFormat read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattPresentationFormat>
  IIterable_1__GenericAttributeProfile_IGattPresentationFormat_Base = interface(IInspectable)
  ['{D75FCEF1-C10E-5B7B-B130-F5A00314D35D}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattPresentationFormat>
  IIterable_1__GenericAttributeProfile_IGattPresentationFormat = interface(IIterable_1__GenericAttributeProfile_IGattPresentationFormat_Base)
  ['{14DBBC80-0C57-5698-BFFE-F7B532896AB3}']
    function First: IIterator_1__GenericAttributeProfile_IGattPresentationFormat; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattPresentationFormat>
  IVectorView_1__GenericAttributeProfile_IGattPresentationFormat = interface(IInspectable)
  ['{E606B52C-CE92-5CAC-A4C3-6BED39EBB7D2}']
    function GetAt(index: Cardinal): GenericAttributeProfile_IGattPresentationFormat; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: GenericAttributeProfile_IGattPresentationFormat; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PGenericAttributeProfile_IGattPresentationFormat): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReadClientCharacteristicConfigurationDescriptorResult
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattReadClientCharacteristicConfigurationDescriptorResult)]
  GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult = interface(IInspectable)
  ['{63A66F09-1AEA-4C4C-A50F-97BAE474B348}']
    function get_Status: GenericAttributeProfile_GattCommunicationStatus; safecall;
    function get_ClientCharacteristicConfigurationDescriptor: GenericAttributeProfile_GattClientCharacteristicConfigurationDescriptorValue; safecall;
    property ClientCharacteristicConfigurationDescriptor: GenericAttributeProfile_GattClientCharacteristicConfigurationDescriptorValue read get_ClientCharacteristicConfigurationDescriptor;
    property Status: GenericAttributeProfile_GattCommunicationStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReadClientCharacteristicConfigurationDescriptorResult>
  AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult_Delegate_Base = interface(IUnknown)
  ['{98F9A6F3-4D29-5351-8B12-751DC977A331}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReadClientCharacteristicConfigurationDescriptorResult>
  AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult = interface(AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult_Delegate_Base)
  ['{A42294DB-768D-50EC-AA7C-F4AB7815980F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReadClientCharacteristicConfigurationDescriptorResult>
  IAsyncOperation_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult_Base = interface(IInspectable)
  ['{CF4444CC-4077-5719-8366-46E86B983685}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReadClientCharacteristicConfigurationDescriptorResult>
  IAsyncOperation_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult = interface(IAsyncOperation_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult_Base)
  ['{8B916488-861B-5537-A189-0239B2B84D64}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult; safecall;
    function GetResults: GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattValueChangedEventArgs
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattValueChangedEventArgs)]
  GenericAttributeProfile_IGattValueChangedEventArgs = interface(IInspectable)
  ['{D21BDB54-06E3-4ED8-A263-ACFAC8BA7313}']
    function get_CharacteristicValue: IBuffer; safecall;
    function get_Timestamp: DateTime; safecall;
    property CharacteristicValue: IBuffer read get_CharacteristicValue;
    property Timestamp: DateTime read get_Timestamp;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristic,Windows.Devices.Bluetooth.GenericAttributeProfile.IGattValueChangedEventArgs>
  TypedEventHandler_2__GenericAttributeProfile_IGattCharacteristic__GenericAttributeProfile_IGattValueChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{C1F420F6-6292-5760-A2C9-9DDF98683CFC}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristic,Windows.Devices.Bluetooth.GenericAttributeProfile.IGattValueChangedEventArgs>
  TypedEventHandler_2__GenericAttributeProfile_IGattCharacteristic__GenericAttributeProfile_IGattValueChangedEventArgs = interface(TypedEventHandler_2__GenericAttributeProfile_IGattCharacteristic__GenericAttributeProfile_IGattValueChangedEventArgs_Delegate_Base)
  ['{42B52484-A834-51A1-A02F-AC8EC8535CA6}']
    procedure Invoke(sender: GenericAttributeProfile_IGattCharacteristic; args: GenericAttributeProfile_IGattValueChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristic
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattCharacteristic)]
  GenericAttributeProfile_IGattCharacteristic = interface(IInspectable)
  ['{59CB50C1-5934-4F68-A198-EB864FA44E6B}']
    function GetDescriptors(descriptorUuid: TGuid): IVectorView_1__GenericAttributeProfile_IGattDescriptor; safecall;
    function get_CharacteristicProperties: GenericAttributeProfile_GattCharacteristicProperties; safecall;
    function get_ProtectionLevel: GenericAttributeProfile_GattProtectionLevel; safecall;
    procedure put_ProtectionLevel(value: GenericAttributeProfile_GattProtectionLevel); safecall;
    function get_UserDescription: HSTRING; safecall;
    function get_Uuid: TGuid; safecall;
    function get_AttributeHandle: Word; safecall;
    function get_PresentationFormats: IVectorView_1__GenericAttributeProfile_IGattPresentationFormat; safecall;
    function ReadValueAsync: IAsyncOperation_1__GenericAttributeProfile_IGattReadResult; overload; safecall;
    function ReadValueAsync(cacheMode: BluetoothCacheMode): IAsyncOperation_1__GenericAttributeProfile_IGattReadResult; overload; safecall;
    function WriteValueAsync(value: IBuffer): IAsyncOperation_1__GenericAttributeProfile_GattCommunicationStatus; overload; safecall;
    function WriteValueAsync(value: IBuffer; writeOption: GenericAttributeProfile_GattWriteOption): IAsyncOperation_1__GenericAttributeProfile_GattCommunicationStatus; overload; safecall;
    function ReadClientCharacteristicConfigurationDescriptorAsync: IAsyncOperation_1__GenericAttributeProfile_IGattReadClientCharacteristicConfigurationDescriptorResult; safecall;
    function WriteClientCharacteristicConfigurationDescriptorAsync(clientCharacteristicConfigurationDescriptorValue: GenericAttributeProfile_GattClientCharacteristicConfigurationDescriptorValue): IAsyncOperation_1__GenericAttributeProfile_GattCommunicationStatus; safecall;
    function add_ValueChanged(valueChangedHandler: TypedEventHandler_2__GenericAttributeProfile_IGattCharacteristic__GenericAttributeProfile_IGattValueChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ValueChanged(valueChangedEventCookie: EventRegistrationToken); safecall;
    property AttributeHandle: Word read get_AttributeHandle;
    property CharacteristicProperties: GenericAttributeProfile_GattCharacteristicProperties read get_CharacteristicProperties;
    property PresentationFormats: IVectorView_1__GenericAttributeProfile_IGattPresentationFormat read get_PresentationFormats;
    property ProtectionLevel: GenericAttributeProfile_GattProtectionLevel read get_ProtectionLevel write put_ProtectionLevel;
    property UserDescription: HSTRING read get_UserDescription;
    property Uuid: TGuid read get_Uuid;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.IBluetoothSignalStrengthFilter
  [WinRTClassNameAttribute(SBluetoothSignalStrengthFilter)]
  IBluetoothSignalStrengthFilter = interface(IInspectable)
  ['{DF7B7391-6BB5-4CFE-90B1-5D7324EDCF7F}']
    function get_InRangeThresholdInDBm: IReference_1__SmallInt; safecall;
    procedure put_InRangeThresholdInDBm(value: IReference_1__SmallInt); safecall;
    function get_OutOfRangeThresholdInDBm: IReference_1__SmallInt; safecall;
    procedure put_OutOfRangeThresholdInDBm(value: IReference_1__SmallInt); safecall;
    function get_OutOfRangeTimeout: IReference_1__TimeSpan; safecall;
    procedure put_OutOfRangeTimeout(value: IReference_1__TimeSpan); safecall;
    function get_SamplingInterval: IReference_1__TimeSpan; safecall;
    procedure put_SamplingInterval(value: IReference_1__TimeSpan); safecall;
    property InRangeThresholdInDBm: IReference_1__SmallInt read get_InRangeThresholdInDBm write put_InRangeThresholdInDBm;
    property OutOfRangeThresholdInDBm: IReference_1__SmallInt read get_OutOfRangeThresholdInDBm write put_OutOfRangeThresholdInDBm;
    property OutOfRangeTimeout: IReference_1__TimeSpan read get_OutOfRangeTimeout write put_OutOfRangeTimeout;
    property SamplingInterval: IReference_1__TimeSpan read get_SamplingInterval write put_SamplingInterval;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.IBluetoothClassOfDevice
  [WinRTClassNameAttribute(SBluetoothClassOfDevice)]
  IBluetoothClassOfDevice = interface(IInspectable)
  ['{D640227E-D7D7-4661-9454-65039CA17A2B}']
    function get_RawValue: Cardinal; safecall;
    function get_MajorClass: BluetoothMajorClass; safecall;
    function get_MinorClass: BluetoothMinorClass; safecall;
    function get_ServiceCapabilities: BluetoothServiceCapabilities; safecall;
    property MajorClass: BluetoothMajorClass read get_MajorClass;
    property MinorClass: BluetoothMinorClass read get_MinorClass;
    property RawValue: Cardinal read get_RawValue;
    property ServiceCapabilities: BluetoothServiceCapabilities read get_ServiceCapabilities;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService
  [WinRTClassNameAttribute(SRfcomm_RfcommDeviceService)]
  Rfcomm_IRfcommDeviceService = interface(IInspectable)
  ['{AE81FF1F-C5A1-4C40-8C28-F3EFD69062F3}']
    function get_ConnectionHostName: IHostName; safecall;
    function get_ConnectionServiceName: HSTRING; safecall;
    function get_ServiceId: Rfcomm_IRfcommServiceId; safecall;
    function get_ProtectionLevel: SocketProtectionLevel; safecall;
    function get_MaxProtectionLevel: SocketProtectionLevel; safecall;
    function GetSdpRawAttributesAsync: IAsyncOperation_1__IMapView_2__Cardinal__IBuffer; overload; safecall;
    function GetSdpRawAttributesAsync(cacheMode: BluetoothCacheMode): IAsyncOperation_1__IMapView_2__Cardinal__IBuffer; overload; safecall;
    property ConnectionHostName: IHostName read get_ConnectionHostName;
    property ConnectionServiceName: HSTRING read get_ConnectionServiceName;
    property MaxProtectionLevel: SocketProtectionLevel read get_MaxProtectionLevel;
    property ProtectionLevel: SocketProtectionLevel read get_ProtectionLevel;
    property ServiceId: Rfcomm_IRfcommServiceId read get_ServiceId;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService>
  IIterator_1__Rfcomm_IRfcommDeviceService = interface(IInspectable)
  ['{F00FFD9B-BCA7-5F4D-867A-4B48841290B0}']
    function get_Current: Rfcomm_IRfcommDeviceService; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PRfcomm_IRfcommDeviceService): Cardinal; safecall;
    property Current: Rfcomm_IRfcommDeviceService read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService>
  IIterable_1__Rfcomm_IRfcommDeviceService_Base = interface(IInspectable)
  ['{3378E9A6-F6E2-50EA-BFEE-B8109631FECA}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService>
  IIterable_1__Rfcomm_IRfcommDeviceService = interface(IIterable_1__Rfcomm_IRfcommDeviceService_Base)
  ['{97D4D552-D3D3-58F3-8898-94F214591AFF}']
    function First: IIterator_1__Rfcomm_IRfcommDeviceService; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService>
  IVectorView_1__Rfcomm_IRfcommDeviceService = interface(IInspectable)
  ['{DB646C4B-561D-568C-96C9-A904005738D7}']
    function GetAt(index: Cardinal): Rfcomm_IRfcommDeviceService; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Rfcomm_IRfcommDeviceService; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PRfcomm_IRfcommDeviceService): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.IBluetoothDevice,Object>
  TypedEventHandler_2__IBluetoothDevice__IInspectable_Delegate_Base = interface(IUnknown)
  ['{DB56CE1C-5E9F-5138-9227-B1A66D60BC1B}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.IBluetoothDevice,Object>
  TypedEventHandler_2__IBluetoothDevice__IInspectable = interface(TypedEventHandler_2__IBluetoothDevice__IInspectable_Delegate_Base)
  ['{E3343193-1080-53E0-9056-4FDA6A561704}']
    procedure Invoke(sender: IBluetoothDevice; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.IBluetoothDevice
  [WinRTClassNameAttribute(SBluetoothDevice)]
  IBluetoothDevice = interface(IInspectable)
  ['{2335B156-90D2-4A04-AEF5-0E20B9E6B707}']
    function get_DeviceId: HSTRING; safecall;
    function get_HostName: IHostName; safecall;
    function get_Name: HSTRING; safecall;
    function get_ClassOfDevice: IBluetoothClassOfDevice; safecall;
    function get_SdpRecords: IVectorView_1__IBuffer; safecall;
    function get_RfcommServices: IVectorView_1__Rfcomm_IRfcommDeviceService; safecall;
    function get_ConnectionStatus: BluetoothConnectionStatus; safecall;
    function get_BluetoothAddress: UInt64; safecall;
    function add_NameChanged(handler: TypedEventHandler_2__IBluetoothDevice__IInspectable): EventRegistrationToken; safecall;
    procedure remove_NameChanged(token: EventRegistrationToken); safecall;
    function add_SdpRecordsChanged(handler: TypedEventHandler_2__IBluetoothDevice__IInspectable): EventRegistrationToken; safecall;
    procedure remove_SdpRecordsChanged(token: EventRegistrationToken); safecall;
    function add_ConnectionStatusChanged(handler: TypedEventHandler_2__IBluetoothDevice__IInspectable): EventRegistrationToken; safecall;
    procedure remove_ConnectionStatusChanged(token: EventRegistrationToken); safecall;
    property BluetoothAddress: UInt64 read get_BluetoothAddress;
    property ClassOfDevice: IBluetoothClassOfDevice read get_ClassOfDevice;
    property ConnectionStatus: BluetoothConnectionStatus read get_ConnectionStatus;
    property DeviceId: HSTRING read get_DeviceId;
    property HostName: IHostName read get_HostName;
    property Name: HSTRING read get_Name;
    property RfcommServices: IVectorView_1__Rfcomm_IRfcommDeviceService read get_RfcommServices;
    property SdpRecords: IVectorView_1__IBuffer read get_SdpRecords;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.IBluetoothDevice>
  AsyncOperationCompletedHandler_1__IBluetoothDevice_Delegate_Base = interface(IUnknown)
  ['{B2E8CDD1-66AA-5892-85A3-8F0B165E43FC}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.IBluetoothDevice>
  AsyncOperationCompletedHandler_1__IBluetoothDevice = interface(AsyncOperationCompletedHandler_1__IBluetoothDevice_Delegate_Base)
  ['{BCF1744C-5B01-5A78-A60C-5C4356372057}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IBluetoothDevice; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.IBluetoothDevice>
  IAsyncOperation_1__IBluetoothDevice_Base = interface(IInspectable)
  ['{B58D8D19-44BD-5AC0-A0D6-1B50800F3181}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.IBluetoothDevice>
  IAsyncOperation_1__IBluetoothDevice = interface(IAsyncOperation_1__IBluetoothDevice_Base)
  ['{7D9DE800-D40C-5FE7-B81B-8B7F489BF3D5}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IBluetoothDevice); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IBluetoothDevice; safecall;
    function GetResults: IBluetoothDevice; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IBluetoothDevice read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.IBluetoothDeviceStatics
  [WinRTClassNameAttribute(SBluetoothDevice)]
  IBluetoothDeviceStatics = interface(IInspectable)
  ['{0991DF51-57DB-4725-BBD7-84F64327EC2C}']
    function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IBluetoothDevice; safecall;
    function FromHostNameAsync(hostName: IHostName): IAsyncOperation_1__IBluetoothDevice; safecall;
    function FromBluetoothAddressAsync(address: UInt64): IAsyncOperation_1__IBluetoothDevice; safecall;
    function GetDeviceSelector: HSTRING; safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristic>
  IIterator_1__GenericAttributeProfile_IGattCharacteristic = interface(IInspectable)
  ['{DBDCBD08-FD03-5CD2-AC27-CB4C8637755A}']
    function get_Current: GenericAttributeProfile_IGattCharacteristic; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PGenericAttributeProfile_IGattCharacteristic): Cardinal; safecall;
    property Current: GenericAttributeProfile_IGattCharacteristic read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristic>
  IIterable_1__GenericAttributeProfile_IGattCharacteristic_Base = interface(IInspectable)
  ['{E3C56728-7F2D-5A0D-AD38-030D39C60F9F}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristic>
  IIterable_1__GenericAttributeProfile_IGattCharacteristic = interface(IIterable_1__GenericAttributeProfile_IGattCharacteristic_Base)
  ['{0A1F6ACA-8DFF-58A2-A505-86D7FF7F4592}']
    function First: IIterator_1__GenericAttributeProfile_IGattCharacteristic; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristic>
  IVectorView_1__GenericAttributeProfile_IGattCharacteristic = interface(IInspectable)
  ['{F5A70A0F-15F4-57EE-9FE7-0CE390AE530B}']
    function GetAt(index: Cardinal): GenericAttributeProfile_IGattCharacteristic; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: GenericAttributeProfile_IGattCharacteristic; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PGenericAttributeProfile_IGattCharacteristic): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattDeviceService)]
  GenericAttributeProfile_IGattDeviceService = interface(IInspectable)
  ['{AC7B7C05-B33C-47CF-990F-6B8F5577DF71}']
    function GetCharacteristics(characteristicUuid: TGuid): IVectorView_1__GenericAttributeProfile_IGattCharacteristic; safecall;
    function GetIncludedServices(serviceUuid: TGuid): IVectorView_1__GenericAttributeProfile_IGattDeviceService; safecall;
    function get_DeviceId: HSTRING; safecall;
    function get_Uuid: TGuid; safecall;
    function get_AttributeHandle: Word; safecall;
    property AttributeHandle: Word read get_AttributeHandle;
    property DeviceId: HSTRING read get_DeviceId;
    property Uuid: TGuid read get_Uuid;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService>
  IIterator_1__GenericAttributeProfile_IGattDeviceService = interface(IInspectable)
  ['{C0BFCA7A-4010-5A3E-A5B7-4A093B0D983C}']
    function get_Current: GenericAttributeProfile_IGattDeviceService; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PGenericAttributeProfile_IGattDeviceService): Cardinal; safecall;
    property Current: GenericAttributeProfile_IGattDeviceService read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService>
  IIterable_1__GenericAttributeProfile_IGattDeviceService_Base = interface(IInspectable)
  ['{4B192E23-4893-56B2-8EFF-439C3AB7FD1F}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService>
  IIterable_1__GenericAttributeProfile_IGattDeviceService = interface(IIterable_1__GenericAttributeProfile_IGattDeviceService_Base)
  ['{35D49B12-34FE-5300-9A6C-05963EAA1B1C}']
    function First: IIterator_1__GenericAttributeProfile_IGattDeviceService; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService>
  IVectorView_1__GenericAttributeProfile_IGattDeviceService = interface(IInspectable)
  ['{C44B7FD0-1C4C-56D8-A640-C159C17F1CF9}']
    function GetAt(index: Cardinal): GenericAttributeProfile_IGattDeviceService; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: GenericAttributeProfile_IGattDeviceService; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PGenericAttributeProfile_IGattDeviceService): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.IBluetoothLEDevice,Object>
  TypedEventHandler_2__IBluetoothLEDevice__IInspectable_Delegate_Base = interface(IUnknown)
  ['{A90661E2-372E-5D1E-BBBB-B8A2CE0E7C4D}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.Bluetooth.IBluetoothLEDevice,Object>
  TypedEventHandler_2__IBluetoothLEDevice__IInspectable = interface(TypedEventHandler_2__IBluetoothLEDevice__IInspectable_Delegate_Base)
  ['{68B7E600-528B-5EE6-BEE1-1A4B917B2AA8}']
    procedure Invoke(sender: IBluetoothLEDevice; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.IBluetoothLEDevice
  [WinRTClassNameAttribute(SBluetoothLEDevice)]
  IBluetoothLEDevice = interface(IInspectable)
  ['{B5EE2F7B-4AD8-4642-AC48-80A0B500E887}']
    function get_DeviceId: HSTRING; safecall;
    function get_Name: HSTRING; safecall;
    function get_GattServices: IVectorView_1__GenericAttributeProfile_IGattDeviceService; safecall;
    function get_ConnectionStatus: BluetoothConnectionStatus; safecall;
    function get_BluetoothAddress: UInt64; safecall;
    function GetGattService(serviceUuid: TGuid): GenericAttributeProfile_IGattDeviceService; safecall;
    function add_NameChanged(handler: TypedEventHandler_2__IBluetoothLEDevice__IInspectable): EventRegistrationToken; safecall;
    procedure remove_NameChanged(token: EventRegistrationToken); safecall;
    function add_GattServicesChanged(handler: TypedEventHandler_2__IBluetoothLEDevice__IInspectable): EventRegistrationToken; safecall;
    procedure remove_GattServicesChanged(token: EventRegistrationToken); safecall;
    function add_ConnectionStatusChanged(handler: TypedEventHandler_2__IBluetoothLEDevice__IInspectable): EventRegistrationToken; safecall;
    procedure remove_ConnectionStatusChanged(token: EventRegistrationToken); safecall;
    property BluetoothAddress: UInt64 read get_BluetoothAddress;
    property ConnectionStatus: BluetoothConnectionStatus read get_ConnectionStatus;
    property DeviceId: HSTRING read get_DeviceId;
    property GattServices: IVectorView_1__GenericAttributeProfile_IGattDeviceService read get_GattServices;
    property Name: HSTRING read get_Name;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.IBluetoothLEDevice>
  AsyncOperationCompletedHandler_1__IBluetoothLEDevice_Delegate_Base = interface(IUnknown)
  ['{9156B79F-C54A-5277-8F8B-D2CC43C7E004}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.IBluetoothLEDevice>
  AsyncOperationCompletedHandler_1__IBluetoothLEDevice = interface(AsyncOperationCompletedHandler_1__IBluetoothLEDevice_Delegate_Base)
  ['{C419959E-2699-526E-BB76-574BFD539521}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IBluetoothLEDevice; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.IBluetoothLEDevice>
  IAsyncOperation_1__IBluetoothLEDevice_Base = interface(IInspectable)
  ['{375F9D67-74A2-5F91-A11D-169093718D41}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.IBluetoothLEDevice>
  IAsyncOperation_1__IBluetoothLEDevice = interface(IAsyncOperation_1__IBluetoothLEDevice_Base)
  ['{495928B4-715C-587B-9A94-65741C303185}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IBluetoothLEDevice); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IBluetoothLEDevice; safecall;
    function GetResults: IBluetoothLEDevice; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IBluetoothLEDevice read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.IBluetoothLEDeviceStatics
  [WinRTClassNameAttribute(SBluetoothLEDevice)]
  IBluetoothLEDeviceStatics = interface(IInspectable)
  ['{C8CF1A19-F0B6-4BF0-8689-41303DE2D9F4}']
    function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IBluetoothLEDevice; safecall;
    function FromBluetoothAddressAsync(bluetoothAddress: UInt64): IAsyncOperation_1__IBluetoothLEDevice; safecall;
    function GetDeviceSelector: HSTRING; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.IBluetoothClassOfDeviceStatics
  [WinRTClassNameAttribute(SBluetoothClassOfDevice)]
  IBluetoothClassOfDeviceStatics = interface(IInspectable)
  ['{E46135BD-0FA2-416C-91B4-C1E48CA061C1}']
    function FromRawValue(rawValue: Cardinal): IBluetoothClassOfDevice; safecall;
    function FromParts(majorClass: BluetoothMajorClass; minorClass: BluetoothMinorClass; serviceCapabilities: BluetoothServiceCapabilities): IBluetoothClassOfDevice; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService>
  AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattDeviceService_Delegate_Base = interface(IUnknown)
  ['{2DBCF64A-262B-5708-ADB1-C3B8750BD680}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService>
  AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattDeviceService = interface(AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattDeviceService_Delegate_Base)
  ['{0B5712A5-4883-5B7C-AE40-D4AD0F0E8D95}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__GenericAttributeProfile_IGattDeviceService; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService>
  IAsyncOperation_1__GenericAttributeProfile_IGattDeviceService_Base = interface(IInspectable)
  ['{E5E90272-408F-5055-9BD3-88408982D301}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService>
  IAsyncOperation_1__GenericAttributeProfile_IGattDeviceService = interface(IAsyncOperation_1__GenericAttributeProfile_IGattDeviceService_Base)
  ['{6816BA80-95DD-57CC-9053-513BA84FEC1D}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattDeviceService); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattDeviceService; safecall;
    function GetResults: GenericAttributeProfile_IGattDeviceService; safecall;
    property Completed: AsyncOperationCompletedHandler_1__GenericAttributeProfile_IGattDeviceService read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceServiceStatics
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattDeviceService)]
  GenericAttributeProfile_IGattDeviceServiceStatics = interface(IInspectable)
  ['{196D0022-FAAD-45DC-AE5B-2AC3184E84DB}']
    function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__GenericAttributeProfile_IGattDeviceService; safecall;
    function GetDeviceSelectorFromUuid(serviceUuid: TGuid): HSTRING; safecall;
    function GetDeviceSelectorFromShortId(serviceShortId: Word): HSTRING; safecall;
    function ConvertShortIdToUuid(shortId: Word): TGuid; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristicStatics
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattCharacteristic)]
  GenericAttributeProfile_IGattCharacteristicStatics = interface(IInspectable)
  ['{59CB50C3-5934-4F68-A198-EB864FA44E6B}']
    function ConvertShortIdToUuid(shortId: Word): TGuid; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristic2
  GenericAttributeProfile_IGattCharacteristic2 = interface(IInspectable)
  ['{AE1AB578-EC06-4764-B780-9835A1D35D6E}']
    function get_Service: GenericAttributeProfile_IGattDeviceService; safecall;
    function GetAllDescriptors: IVectorView_1__GenericAttributeProfile_IGattDescriptor; safecall;
    property Service: GenericAttributeProfile_IGattDeviceService read get_Service;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDescriptorStatics
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattDescriptor)]
  GenericAttributeProfile_IGattDescriptorStatics = interface(IInspectable)
  ['{92055F2D-8084-4344-B4C2-284DE19A8506}']
    function ConvertShortIdToUuid(shortId: Word): TGuid; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattPresentationFormatStatics
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattPresentationFormat)]
  GenericAttributeProfile_IGattPresentationFormatStatics = interface(IInspectable)
  ['{196D0020-FAAD-45DC-AE5B-2AC3184E84DB}']
    function get_BluetoothSigAssignedNumbers: Byte; safecall;
    property BluetoothSigAssignedNumbers: Byte read get_BluetoothSigAssignedNumbers;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattPresentationFormatTypesStatics
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattPresentationFormatTypes)]
  GenericAttributeProfile_IGattPresentationFormatTypesStatics = interface(IInspectable)
  ['{FAF1BA0A-30BA-409C-BEF7-CFFB6D03B8FB}']
    function get_Boolean: Byte; safecall;
    function get_Bit2: Byte; safecall;
    function get_Nibble: Byte; safecall;
    function get_UInt8: Byte; safecall;
    function get_UInt12: Byte; safecall;
    function get_UInt16: Byte; safecall;
    function get_UInt24: Byte; safecall;
    function get_UInt32: Byte; safecall;
    function get_UInt48: Byte; safecall;
    function get_UInt64: Byte; safecall;
    function get_UInt128: Byte; safecall;
    function get_SInt8: Byte; safecall;
    function get_SInt12: Byte; safecall;
    function get_SInt16: Byte; safecall;
    function get_SInt24: Byte; safecall;
    function get_SInt32: Byte; safecall;
    function get_SInt48: Byte; safecall;
    function get_SInt64: Byte; safecall;
    function get_SInt128: Byte; safecall;
    function get_Float32: Byte; safecall;
    function get_Float64: Byte; safecall;
    function get_SFloat: Byte; safecall;
    function get_Float: Byte; safecall;
    function get_DUInt16: Byte; safecall;
    function get_Utf8: Byte; safecall;
    function get_Utf16: Byte; safecall;
    function get_Struct: Byte; safecall;
    property Bit2: Byte read get_Bit2;
    property Boolean: Byte read get_Boolean;
    property DUInt16: Byte read get_DUInt16;
    property Float: Byte read get_Float;
    property Float32: Byte read get_Float32;
    property Float64: Byte read get_Float64;
    property Nibble: Byte read get_Nibble;
    property SFloat: Byte read get_SFloat;
    property SInt12: Byte read get_SInt12;
    property SInt128: Byte read get_SInt128;
    property SInt16: Byte read get_SInt16;
    property SInt24: Byte read get_SInt24;
    property SInt32: Byte read get_SInt32;
    property SInt48: Byte read get_SInt48;
    property SInt64: Byte read get_SInt64;
    property SInt8: Byte read get_SInt8;
    property Struct: Byte read get_Struct;
    property UInt12: Byte read get_UInt12;
    property UInt128: Byte read get_UInt128;
    property UInt16: Byte read get_UInt16;
    property UInt24: Byte read get_UInt24;
    property UInt32: Byte read get_UInt32;
    property UInt48: Byte read get_UInt48;
    property UInt64: Byte read get_UInt64;
    property UInt8: Byte read get_UInt8;
    property Utf16: Byte read get_Utf16;
    property Utf8: Byte read get_Utf8;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattServiceUuidsStatics
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattServiceUuids)]
  GenericAttributeProfile_IGattServiceUuidsStatics = interface(IInspectable)
  ['{6DC57058-9ABA-4417-B8F2-DCE016D34EE2}']
    function get_Battery: TGuid; safecall;
    function get_BloodPressure: TGuid; safecall;
    function get_CyclingSpeedAndCadence: TGuid; safecall;
    function get_GenericAccess: TGuid; safecall;
    function get_GenericAttribute: TGuid; safecall;
    function get_Glucose: TGuid; safecall;
    function get_HealthThermometer: TGuid; safecall;
    function get_HeartRate: TGuid; safecall;
    function get_RunningSpeedAndCadence: TGuid; safecall;
    property Battery: TGuid read get_Battery;
    property BloodPressure: TGuid read get_BloodPressure;
    property CyclingSpeedAndCadence: TGuid read get_CyclingSpeedAndCadence;
    property GenericAccess: TGuid read get_GenericAccess;
    property GenericAttribute: TGuid read get_GenericAttribute;
    property Glucose: TGuid read get_Glucose;
    property HealthThermometer: TGuid read get_HealthThermometer;
    property HeartRate: TGuid read get_HeartRate;
    property RunningSpeedAndCadence: TGuid read get_RunningSpeedAndCadence;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattServiceUuidsStatics2
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattServiceUuids)]
  GenericAttributeProfile_IGattServiceUuidsStatics2 = interface(IInspectable)
  ['{D2AE94F5-3D15-4F79-9C0C-EAAFA675155C}']
    function get_AlertNotification: TGuid; safecall;
    function get_CurrentTime: TGuid; safecall;
    function get_CyclingPower: TGuid; safecall;
    function get_DeviceInformation: TGuid; safecall;
    function get_HumanInterfaceDevice: TGuid; safecall;
    function get_ImmediateAlert: TGuid; safecall;
    function get_LinkLoss: TGuid; safecall;
    function get_LocationAndNavigation: TGuid; safecall;
    function get_NextDstChange: TGuid; safecall;
    function get_PhoneAlertStatus: TGuid; safecall;
    function get_ReferenceTimeUpdate: TGuid; safecall;
    function get_ScanParameters: TGuid; safecall;
    function get_TxPower: TGuid; safecall;
    property AlertNotification: TGuid read get_AlertNotification;
    property CurrentTime: TGuid read get_CurrentTime;
    property CyclingPower: TGuid read get_CyclingPower;
    property DeviceInformation: TGuid read get_DeviceInformation;
    property HumanInterfaceDevice: TGuid read get_HumanInterfaceDevice;
    property ImmediateAlert: TGuid read get_ImmediateAlert;
    property LinkLoss: TGuid read get_LinkLoss;
    property LocationAndNavigation: TGuid read get_LocationAndNavigation;
    property NextDstChange: TGuid read get_NextDstChange;
    property PhoneAlertStatus: TGuid read get_PhoneAlertStatus;
    property ReferenceTimeUpdate: TGuid read get_ReferenceTimeUpdate;
    property ScanParameters: TGuid read get_ScanParameters;
    property TxPower: TGuid read get_TxPower;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristicUuidsStatics
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattCharacteristicUuids)]
  GenericAttributeProfile_IGattCharacteristicUuidsStatics = interface(IInspectable)
  ['{58FA4586-B1DE-470C-B7DE-0D11FF44F4B7}']
    function get_BatteryLevel: TGuid; safecall;
    function get_BloodPressureFeature: TGuid; safecall;
    function get_BloodPressureMeasurement: TGuid; safecall;
    function get_BodySensorLocation: TGuid; safecall;
    function get_CscFeature: TGuid; safecall;
    function get_CscMeasurement: TGuid; safecall;
    function get_GlucoseFeature: TGuid; safecall;
    function get_GlucoseMeasurement: TGuid; safecall;
    function get_GlucoseMeasurementContext: TGuid; safecall;
    function get_HeartRateControlPoint: TGuid; safecall;
    function get_HeartRateMeasurement: TGuid; safecall;
    function get_IntermediateCuffPressure: TGuid; safecall;
    function get_IntermediateTemperature: TGuid; safecall;
    function get_MeasurementInterval: TGuid; safecall;
    function get_RecordAccessControlPoint: TGuid; safecall;
    function get_RscFeature: TGuid; safecall;
    function get_RscMeasurement: TGuid; safecall;
    function get_SCControlPoint: TGuid; safecall;
    function get_SensorLocation: TGuid; safecall;
    function get_TemperatureMeasurement: TGuid; safecall;
    function get_TemperatureType: TGuid; safecall;
    property BatteryLevel: TGuid read get_BatteryLevel;
    property BloodPressureFeature: TGuid read get_BloodPressureFeature;
    property BloodPressureMeasurement: TGuid read get_BloodPressureMeasurement;
    property BodySensorLocation: TGuid read get_BodySensorLocation;
    property CscFeature: TGuid read get_CscFeature;
    property CscMeasurement: TGuid read get_CscMeasurement;
    property GlucoseFeature: TGuid read get_GlucoseFeature;
    property GlucoseMeasurement: TGuid read get_GlucoseMeasurement;
    property GlucoseMeasurementContext: TGuid read get_GlucoseMeasurementContext;
    property HeartRateControlPoint: TGuid read get_HeartRateControlPoint;
    property HeartRateMeasurement: TGuid read get_HeartRateMeasurement;
    property IntermediateCuffPressure: TGuid read get_IntermediateCuffPressure;
    property IntermediateTemperature: TGuid read get_IntermediateTemperature;
    property MeasurementInterval: TGuid read get_MeasurementInterval;
    property RecordAccessControlPoint: TGuid read get_RecordAccessControlPoint;
    property RscFeature: TGuid read get_RscFeature;
    property RscMeasurement: TGuid read get_RscMeasurement;
    property SCControlPoint: TGuid read get_SCControlPoint;
    property SensorLocation: TGuid read get_SensorLocation;
    property TemperatureMeasurement: TGuid read get_TemperatureMeasurement;
    property TemperatureType: TGuid read get_TemperatureType;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattCharacteristicUuidsStatics2
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattCharacteristicUuids)]
  GenericAttributeProfile_IGattCharacteristicUuidsStatics2 = interface(IInspectable)
  ['{1855B425-D46E-4A2C-9C3F-ED6DEA29E7BE}']
    function get_AlertCategoryId: TGuid; safecall;
    function get_AlertCategoryIdBitMask: TGuid; safecall;
    function get_AlertLevel: TGuid; safecall;
    function get_AlertNotificationControlPoint: TGuid; safecall;
    function get_AlertStatus: TGuid; safecall;
    function get_GapAppearance: TGuid; safecall;
    function get_BootKeyboardInputReport: TGuid; safecall;
    function get_BootKeyboardOutputReport: TGuid; safecall;
    function get_BootMouseInputReport: TGuid; safecall;
    function get_CurrentTime: TGuid; safecall;
    function get_CyclingPowerControlPoint: TGuid; safecall;
    function get_CyclingPowerFeature: TGuid; safecall;
    function get_CyclingPowerMeasurement: TGuid; safecall;
    function get_CyclingPowerVector: TGuid; safecall;
    function get_DateTime: TGuid; safecall;
    function get_DayDateTime: TGuid; safecall;
    function get_DayOfWeek: TGuid; safecall;
    function get_GapDeviceName: TGuid; safecall;
    function get_DstOffset: TGuid; safecall;
    function get_ExactTime256: TGuid; safecall;
    function get_FirmwareRevisionString: TGuid; safecall;
    function get_HardwareRevisionString: TGuid; safecall;
    function get_HidControlPoint: TGuid; safecall;
    function get_HidInformation: TGuid; safecall;
    function get_Ieee1107320601RegulatoryCertificationDataList: TGuid; safecall;
    function get_LnControlPoint: TGuid; safecall;
    function get_LnFeature: TGuid; safecall;
    function get_LocalTimeInformation: TGuid; safecall;
    function get_LocationAndSpeed: TGuid; safecall;
    function get_ManufacturerNameString: TGuid; safecall;
    function get_ModelNumberString: TGuid; safecall;
    function get_Navigation: TGuid; safecall;
    function get_NewAlert: TGuid; safecall;
    function get_GapPeripheralPreferredConnectionParameters: TGuid; safecall;
    function get_GapPeripheralPrivacyFlag: TGuid; safecall;
    function get_PnpId: TGuid; safecall;
    function get_PositionQuality: TGuid; safecall;
    function get_ProtocolMode: TGuid; safecall;
    function get_GapReconnectionAddress: TGuid; safecall;
    function get_ReferenceTimeInformation: TGuid; safecall;
    function get_Report: TGuid; safecall;
    function get_ReportMap: TGuid; safecall;
    function get_RingerControlPoint: TGuid; safecall;
    function get_RingerSetting: TGuid; safecall;
    function get_ScanIntervalWindow: TGuid; safecall;
    function get_ScanRefresh: TGuid; safecall;
    function get_SerialNumberString: TGuid; safecall;
    function get_GattServiceChanged: TGuid; safecall;
    function get_SoftwareRevisionString: TGuid; safecall;
    function get_SupportedNewAlertCategory: TGuid; safecall;
    function get_SupportUnreadAlertCategory: TGuid; safecall;
    function get_SystemId: TGuid; safecall;
    function get_TimeAccuracy: TGuid; safecall;
    function get_TimeSource: TGuid; safecall;
    function get_TimeUpdateControlPoint: TGuid; safecall;
    function get_TimeUpdateState: TGuid; safecall;
    function get_TimeWithDst: TGuid; safecall;
    function get_TimeZone: TGuid; safecall;
    function get_TxPowerLevel: TGuid; safecall;
    function get_UnreadAlertStatus: TGuid; safecall;
    property AlertCategoryId: TGuid read get_AlertCategoryId;
    property AlertCategoryIdBitMask: TGuid read get_AlertCategoryIdBitMask;
    property AlertLevel: TGuid read get_AlertLevel;
    property AlertNotificationControlPoint: TGuid read get_AlertNotificationControlPoint;
    property AlertStatus: TGuid read get_AlertStatus;
    property BootKeyboardInputReport: TGuid read get_BootKeyboardInputReport;
    property BootKeyboardOutputReport: TGuid read get_BootKeyboardOutputReport;
    property BootMouseInputReport: TGuid read get_BootMouseInputReport;
    property CurrentTime: TGuid read get_CurrentTime;
    property CyclingPowerControlPoint: TGuid read get_CyclingPowerControlPoint;
    property CyclingPowerFeature: TGuid read get_CyclingPowerFeature;
    property CyclingPowerMeasurement: TGuid read get_CyclingPowerMeasurement;
    property CyclingPowerVector: TGuid read get_CyclingPowerVector;
    property DateTime: TGuid read get_DateTime;
    property DayDateTime: TGuid read get_DayDateTime;
    property DayOfWeek: TGuid read get_DayOfWeek;
    property DstOffset: TGuid read get_DstOffset;
    property ExactTime256: TGuid read get_ExactTime256;
    property FirmwareRevisionString: TGuid read get_FirmwareRevisionString;
    property GapAppearance: TGuid read get_GapAppearance;
    property GapDeviceName: TGuid read get_GapDeviceName;
    property GapPeripheralPreferredConnectionParameters: TGuid read get_GapPeripheralPreferredConnectionParameters;
    property GapPeripheralPrivacyFlag: TGuid read get_GapPeripheralPrivacyFlag;
    property GapReconnectionAddress: TGuid read get_GapReconnectionAddress;
    property GattServiceChanged: TGuid read get_GattServiceChanged;
    property HardwareRevisionString: TGuid read get_HardwareRevisionString;
    property HidControlPoint: TGuid read get_HidControlPoint;
    property HidInformation: TGuid read get_HidInformation;
    property Ieee1107320601RegulatoryCertificationDataList: TGuid read get_Ieee1107320601RegulatoryCertificationDataList;
    property LnControlPoint: TGuid read get_LnControlPoint;
    property LnFeature: TGuid read get_LnFeature;
    property LocalTimeInformation: TGuid read get_LocalTimeInformation;
    property LocationAndSpeed: TGuid read get_LocationAndSpeed;
    property ManufacturerNameString: TGuid read get_ManufacturerNameString;
    property ModelNumberString: TGuid read get_ModelNumberString;
    property Navigation: TGuid read get_Navigation;
    property NewAlert: TGuid read get_NewAlert;
    property PnpId: TGuid read get_PnpId;
    property PositionQuality: TGuid read get_PositionQuality;
    property ProtocolMode: TGuid read get_ProtocolMode;
    property ReferenceTimeInformation: TGuid read get_ReferenceTimeInformation;
    property Report: TGuid read get_Report;
    property ReportMap: TGuid read get_ReportMap;
    property RingerControlPoint: TGuid read get_RingerControlPoint;
    property RingerSetting: TGuid read get_RingerSetting;
    property ScanIntervalWindow: TGuid read get_ScanIntervalWindow;
    property ScanRefresh: TGuid read get_ScanRefresh;
    property SerialNumberString: TGuid read get_SerialNumberString;
    property SoftwareRevisionString: TGuid read get_SoftwareRevisionString;
    property SupportUnreadAlertCategory: TGuid read get_SupportUnreadAlertCategory;
    property SupportedNewAlertCategory: TGuid read get_SupportedNewAlertCategory;
    property SystemId: TGuid read get_SystemId;
    property TimeAccuracy: TGuid read get_TimeAccuracy;
    property TimeSource: TGuid read get_TimeSource;
    property TimeUpdateControlPoint: TGuid read get_TimeUpdateControlPoint;
    property TimeUpdateState: TGuid read get_TimeUpdateState;
    property TimeWithDst: TGuid read get_TimeWithDst;
    property TimeZone: TGuid read get_TimeZone;
    property TxPowerLevel: TGuid read get_TxPowerLevel;
    property UnreadAlertStatus: TGuid read get_UnreadAlertStatus;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDescriptorUuidsStatics
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattDescriptorUuids)]
  GenericAttributeProfile_IGattDescriptorUuidsStatics = interface(IInspectable)
  ['{A6F862CE-9CFC-42F1-9185-FF37B75181D3}']
    function get_CharacteristicAggregateFormat: TGuid; safecall;
    function get_CharacteristicExtendedProperties: TGuid; safecall;
    function get_CharacteristicPresentationFormat: TGuid; safecall;
    function get_CharacteristicUserDescription: TGuid; safecall;
    function get_ClientCharacteristicConfiguration: TGuid; safecall;
    function get_ServerCharacteristicConfiguration: TGuid; safecall;
    property CharacteristicAggregateFormat: TGuid read get_CharacteristicAggregateFormat;
    property CharacteristicExtendedProperties: TGuid read get_CharacteristicExtendedProperties;
    property CharacteristicPresentationFormat: TGuid read get_CharacteristicPresentationFormat;
    property CharacteristicUserDescription: TGuid read get_CharacteristicUserDescription;
    property ClientCharacteristicConfiguration: TGuid read get_ClientCharacteristicConfiguration;
    property ServerCharacteristicConfiguration: TGuid read get_ServerCharacteristicConfiguration;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattReliableWriteTransaction
  [WinRTClassNameAttribute(SGenericAttributeProfile_GattReliableWriteTransaction)]
  GenericAttributeProfile_IGattReliableWriteTransaction = interface(IInspectable)
  ['{63A66F07-1AEA-4C4C-A50F-97BAE474B348}']
    procedure WriteValue(characteristic: GenericAttributeProfile_IGattCharacteristic; value: IBuffer); safecall;
    function CommitAsync: IAsyncOperation_1__GenericAttributeProfile_GattCommunicationStatus; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Rfcomm.IRfcommServiceIdStatics
  [WinRTClassNameAttribute(SRfcomm_RfcommServiceId)]
  Rfcomm_IRfcommServiceIdStatics = interface(IInspectable)
  ['{2A179EBA-A975-46E3-B56B-08FFD783A5FE}']
    function FromUuid(uuid: TGuid): Rfcomm_IRfcommServiceId; safecall;
    function FromShortId(shortId: Cardinal): Rfcomm_IRfcommServiceId; safecall;
    function get_SerialPort: Rfcomm_IRfcommServiceId; safecall;
    function get_ObexObjectPush: Rfcomm_IRfcommServiceId; safecall;
    function get_ObexFileTransfer: Rfcomm_IRfcommServiceId; safecall;
    function get_PhoneBookAccessPce: Rfcomm_IRfcommServiceId; safecall;
    function get_PhoneBookAccessPse: Rfcomm_IRfcommServiceId; safecall;
    function get_GenericFileTransfer: Rfcomm_IRfcommServiceId; safecall;
    property GenericFileTransfer: Rfcomm_IRfcommServiceId read get_GenericFileTransfer;
    property ObexFileTransfer: Rfcomm_IRfcommServiceId read get_ObexFileTransfer;
    property ObexObjectPush: Rfcomm_IRfcommServiceId read get_ObexObjectPush;
    property PhoneBookAccessPce: Rfcomm_IRfcommServiceId read get_PhoneBookAccessPce;
    property PhoneBookAccessPse: Rfcomm_IRfcommServiceId read get_PhoneBookAccessPse;
    property SerialPort: Rfcomm_IRfcommServiceId read get_SerialPort;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService>
  AsyncOperationCompletedHandler_1__Rfcomm_IRfcommDeviceService_Delegate_Base = interface(IUnknown)
  ['{5C772518-442F-58ED-80CB-538D34B88295}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService>
  AsyncOperationCompletedHandler_1__Rfcomm_IRfcommDeviceService = interface(AsyncOperationCompletedHandler_1__Rfcomm_IRfcommDeviceService_Delegate_Base)
  ['{B50BCE04-E854-5D91-AB6E-BB395E2FB295}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Rfcomm_IRfcommDeviceService; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService>
  IAsyncOperation_1__Rfcomm_IRfcommDeviceService_Base = interface(IInspectable)
  ['{0DF56BD7-C8F6-5C32-9644-AA0BCF28D78C}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService>
  IAsyncOperation_1__Rfcomm_IRfcommDeviceService = interface(IAsyncOperation_1__Rfcomm_IRfcommDeviceService_Base)
  ['{298F527C-1155-5B54-AEEC-EE74805C54CC}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Rfcomm_IRfcommDeviceService); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Rfcomm_IRfcommDeviceService; safecall;
    function GetResults: Rfcomm_IRfcommDeviceService; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Rfcomm_IRfcommDeviceService read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceServiceStatics
  [WinRTClassNameAttribute(SRfcomm_RfcommDeviceService)]
  Rfcomm_IRfcommDeviceServiceStatics = interface(IInspectable)
  ['{A4A149EF-626D-41AC-B253-87AC5C27E28A}']
    function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__Rfcomm_IRfcommDeviceService; safecall;
    function GetDeviceSelector(serviceId: Rfcomm_IRfcommServiceId): HSTRING; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Rfcomm.IRfcommDeviceService2
  Rfcomm_IRfcommDeviceService2 = interface(IInspectable)
  ['{536CED14-EBCD-49FE-BF9F-40EFC689B20D}']
    function get_Device: IBluetoothDevice; safecall;
    property Device: IBluetoothDevice read get_Device;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Rfcomm.IRfcommServiceProvider
  [WinRTClassNameAttribute(SRfcomm_RfcommServiceProvider)]
  Rfcomm_IRfcommServiceProvider = interface(IInspectable)
  ['{EADBFDC4-B1F6-44FF-9F7C-E7A82AB86821}']
    function get_ServiceId: Rfcomm_IRfcommServiceId; safecall;
    function get_SdpRawAttributes: IMap_2__Cardinal__IBuffer; safecall;
    procedure StartAdvertising(listener: IStreamSocketListener); safecall;
    procedure StopAdvertising; safecall;
    property SdpRawAttributes: IMap_2__Cardinal__IBuffer read get_SdpRawAttributes;
    property ServiceId: Rfcomm_IRfcommServiceId read get_ServiceId;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommServiceProvider>
  AsyncOperationCompletedHandler_1__Rfcomm_IRfcommServiceProvider_Delegate_Base = interface(IUnknown)
  ['{446A7F50-8F2E-51F0-AEBB-1BC3D192905F}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommServiceProvider>
  AsyncOperationCompletedHandler_1__Rfcomm_IRfcommServiceProvider = interface(AsyncOperationCompletedHandler_1__Rfcomm_IRfcommServiceProvider_Delegate_Base)
  ['{45D3CA57-9754-58BF-BC45-851E07061D01}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Rfcomm_IRfcommServiceProvider; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommServiceProvider>
  IAsyncOperation_1__Rfcomm_IRfcommServiceProvider_Base = interface(IInspectable)
  ['{FED44828-E232-554D-85D1-2F04D1322E69}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Bluetooth.Rfcomm.IRfcommServiceProvider>
  IAsyncOperation_1__Rfcomm_IRfcommServiceProvider = interface(IAsyncOperation_1__Rfcomm_IRfcommServiceProvider_Base)
  ['{049FA020-5F01-5D52-B724-C34021660BEB}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Rfcomm_IRfcommServiceProvider); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Rfcomm_IRfcommServiceProvider; safecall;
    function GetResults: Rfcomm_IRfcommServiceProvider; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Rfcomm_IRfcommServiceProvider read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.Rfcomm.IRfcommServiceProviderStatics
  [WinRTClassNameAttribute(SRfcomm_RfcommServiceProvider)]
  Rfcomm_IRfcommServiceProviderStatics = interface(IInspectable)
  ['{98888303-69CA-413A-84F7-4344C7292997}']
    function CreateAsync(serviceId: Rfcomm_IRfcommServiceId): IAsyncOperation_1__Rfcomm_IRfcommServiceProvider; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.Bluetooth.GenericAttributeProfile.IGattDeviceService2
  GenericAttributeProfile_IGattDeviceService2 = interface(IInspectable)
  ['{FC54520B-0B0D-4708-BAE0-9FFD9489BC59}']
    function get_Device: IBluetoothLEDevice; safecall;
    function get_ParentServices: IVectorView_1__GenericAttributeProfile_IGattDeviceService; safecall;
    function GetAllCharacteristics: IVectorView_1__GenericAttributeProfile_IGattCharacteristic; safecall;
    function GetAllIncludedServices: IVectorView_1__GenericAttributeProfile_IGattDeviceService; safecall;
    property Device: IBluetoothLEDevice read get_Device;
    property ParentServices: IVectorView_1__GenericAttributeProfile_IGattDeviceService read get_ParentServices;
  end;


  // Emit Forwarded classes
  // Windows.Devices.Bluetooth.BluetoothClassOfDevice
  // DualAPI
  TBluetoothClassOfDevice = class(TWinRTGenericImportS<IBluetoothClassOfDeviceStatics>)
  public
    // -> IBluetoothClassOfDeviceStatics
    class function FromRawValue(rawValue: Cardinal): IBluetoothClassOfDevice; static; inline;
    class function FromParts(majorClass: BluetoothMajorClass; minorClass: BluetoothMinorClass; serviceCapabilities: BluetoothServiceCapabilities): IBluetoothClassOfDevice; static; inline;
  end;

  // Windows.Devices.Bluetooth.Rfcomm.RfcommDeviceService
  // DualAPI
  TRfcomm_RfcommDeviceService = class(TWinRTGenericImportS<Rfcomm_IRfcommDeviceServiceStatics>)
  public
    // -> Rfcomm_IRfcommDeviceServiceStatics
    class function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__Rfcomm_IRfcommDeviceService; static; inline;
    class function GetDeviceSelector(serviceId: Rfcomm_IRfcommServiceId): HSTRING; static; inline;
  end;

  // Windows.Devices.Bluetooth.BluetoothDevice
  // DualAPI
  TBluetoothDevice = class(TWinRTGenericImportS<IBluetoothDeviceStatics>)
  public
    // -> IBluetoothDeviceStatics
    class function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IBluetoothDevice; static; inline;
    class function FromHostNameAsync(hostName: IHostName): IAsyncOperation_1__IBluetoothDevice; static; inline;
    class function FromBluetoothAddressAsync(address: UInt64): IAsyncOperation_1__IBluetoothDevice; static; inline;
    class function GetDeviceSelector: HSTRING; static; inline;
  end;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattDeviceService
  // DualAPI
  TGenericAttributeProfile_GattDeviceService = class(TWinRTGenericImportS<GenericAttributeProfile_IGattDeviceServiceStatics>)
  public
    // -> GenericAttributeProfile_IGattDeviceServiceStatics
    class function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__GenericAttributeProfile_IGattDeviceService; static; inline;
    class function GetDeviceSelectorFromUuid(serviceUuid: TGuid): HSTRING; static; inline;
    class function GetDeviceSelectorFromShortId(serviceShortId: Word): HSTRING; static; inline;
    class function ConvertShortIdToUuid(shortId: Word): TGuid; static; inline;
  end;

  // Windows.Devices.Bluetooth.BluetoothLEDevice
  // DualAPI
  TBluetoothLEDevice = class(TWinRTGenericImportS<IBluetoothLEDeviceStatics>)
  public
    // -> IBluetoothLEDeviceStatics
    class function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IBluetoothLEDevice; static; inline;
    class function FromBluetoothAddressAsync(bluetoothAddress: UInt64): IAsyncOperation_1__IBluetoothLEDevice; static; inline;
    class function GetDeviceSelector: HSTRING; static; inline;
  end;

  // Windows.Devices.Bluetooth.BluetoothSignalStrengthFilter
  // DualAPI
  TBluetoothSignalStrengthFilter = class(TWinRTGenericImportI<IBluetoothSignalStrengthFilter>) end;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattCharacteristic
  // DualAPI
  TGenericAttributeProfile_GattCharacteristic = class(TWinRTGenericImportS<GenericAttributeProfile_IGattCharacteristicStatics>)
  public
    // -> GenericAttributeProfile_IGattCharacteristicStatics
    class function ConvertShortIdToUuid(shortId: Word): TGuid; static; inline;
  end;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattDescriptor
  // DualAPI
  TGenericAttributeProfile_GattDescriptor = class(TWinRTGenericImportS<GenericAttributeProfile_IGattDescriptorStatics>)
  public
    // -> GenericAttributeProfile_IGattDescriptorStatics
    class function ConvertShortIdToUuid(shortId: Word): TGuid; static; inline;
  end;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattPresentationFormat
  // DualAPI
  TGenericAttributeProfile_GattPresentationFormat = class(TWinRTGenericImportS<GenericAttributeProfile_IGattPresentationFormatStatics>)
  public
    // -> GenericAttributeProfile_IGattPresentationFormatStatics
    class function get_BluetoothSigAssignedNumbers: Byte; static; inline;
    class property BluetoothSigAssignedNumbers: Byte read get_BluetoothSigAssignedNumbers;
  end;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattReadResult
  // DualAPI

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattReadClientCharacteristicConfigurationDescriptorResult
  // DualAPI

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattValueChangedEventArgs
  // DualAPI

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattServiceUuids
  // DualAPI
  TGenericAttributeProfile_GattServiceUuids = class(TWinRTGenericImportS2<GenericAttributeProfile_IGattServiceUuidsStatics, GenericAttributeProfile_IGattServiceUuidsStatics2>)
  public
    // -> GenericAttributeProfile_IGattServiceUuidsStatics
    class function get_Battery: TGuid; static; inline;
    class function get_BloodPressure: TGuid; static; inline;
    class function get_CyclingSpeedAndCadence: TGuid; static; inline;
    class function get_GenericAccess: TGuid; static; inline;
    class function get_GenericAttribute: TGuid; static; inline;
    class function get_Glucose: TGuid; static; inline;
    class function get_HealthThermometer: TGuid; static; inline;
    class function get_HeartRate: TGuid; static; inline;
    class function get_RunningSpeedAndCadence: TGuid; static; inline;
    class property Battery: TGuid read get_Battery;
    class property BloodPressure: TGuid read get_BloodPressure;
    class property CyclingSpeedAndCadence: TGuid read get_CyclingSpeedAndCadence;
    class property GenericAccess: TGuid read get_GenericAccess;
    class property GenericAttribute: TGuid read get_GenericAttribute;
    class property Glucose: TGuid read get_Glucose;
    class property HealthThermometer: TGuid read get_HealthThermometer;
    class property HeartRate: TGuid read get_HeartRate;
    class property RunningSpeedAndCadence: TGuid read get_RunningSpeedAndCadence;

    // -> GenericAttributeProfile_IGattServiceUuidsStatics2
    class function get_AlertNotification: TGuid; static; inline;
    class function get_CurrentTime: TGuid; static; inline;
    class function get_CyclingPower: TGuid; static; inline;
    class function get_DeviceInformation: TGuid; static; inline;
    class function get_HumanInterfaceDevice: TGuid; static; inline;
    class function get_ImmediateAlert: TGuid; static; inline;
    class function get_LinkLoss: TGuid; static; inline;
    class function get_LocationAndNavigation: TGuid; static; inline;
    class function get_NextDstChange: TGuid; static; inline;
    class function get_PhoneAlertStatus: TGuid; static; inline;
    class function get_ReferenceTimeUpdate: TGuid; static; inline;
    class function get_ScanParameters: TGuid; static; inline;
    class function get_TxPower: TGuid; static; inline;
    class property AlertNotification: TGuid read get_AlertNotification;
    class property CurrentTime: TGuid read get_CurrentTime;
    class property CyclingPower: TGuid read get_CyclingPower;
    class property DeviceInformation: TGuid read get_DeviceInformation;
    class property HumanInterfaceDevice: TGuid read get_HumanInterfaceDevice;
    class property ImmediateAlert: TGuid read get_ImmediateAlert;
    class property LinkLoss: TGuid read get_LinkLoss;
    class property LocationAndNavigation: TGuid read get_LocationAndNavigation;
    class property NextDstChange: TGuid read get_NextDstChange;
    class property PhoneAlertStatus: TGuid read get_PhoneAlertStatus;
    class property ReferenceTimeUpdate: TGuid read get_ReferenceTimeUpdate;
    class property ScanParameters: TGuid read get_ScanParameters;
    class property TxPower: TGuid read get_TxPower;
  end;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattCharacteristicUuids
  // DualAPI
  TGenericAttributeProfile_GattCharacteristicUuids = class(TWinRTGenericImportS2<GenericAttributeProfile_IGattCharacteristicUuidsStatics, GenericAttributeProfile_IGattCharacteristicUuidsStatics2>)
  public
    // -> GenericAttributeProfile_IGattCharacteristicUuidsStatics
    class function get_BatteryLevel: TGuid; static; inline;
    class function get_BloodPressureFeature: TGuid; static; inline;
    class function get_BloodPressureMeasurement: TGuid; static; inline;
    class function get_BodySensorLocation: TGuid; static; inline;
    class function get_CscFeature: TGuid; static; inline;
    class function get_CscMeasurement: TGuid; static; inline;
    class function get_GlucoseFeature: TGuid; static; inline;
    class function get_GlucoseMeasurement: TGuid; static; inline;
    class function get_GlucoseMeasurementContext: TGuid; static; inline;
    class function get_HeartRateControlPoint: TGuid; static; inline;
    class function get_HeartRateMeasurement: TGuid; static; inline;
    class function get_IntermediateCuffPressure: TGuid; static; inline;
    class function get_IntermediateTemperature: TGuid; static; inline;
    class function get_MeasurementInterval: TGuid; static; inline;
    class function get_RecordAccessControlPoint: TGuid; static; inline;
    class function get_RscFeature: TGuid; static; inline;
    class function get_RscMeasurement: TGuid; static; inline;
    class function get_SCControlPoint: TGuid; static; inline;
    class function get_SensorLocation: TGuid; static; inline;
    class function get_TemperatureMeasurement: TGuid; static; inline;
    class function get_TemperatureType: TGuid; static; inline;
    class property BatteryLevel: TGuid read get_BatteryLevel;
    class property BloodPressureFeature: TGuid read get_BloodPressureFeature;
    class property BloodPressureMeasurement: TGuid read get_BloodPressureMeasurement;
    class property BodySensorLocation: TGuid read get_BodySensorLocation;
    class property CscFeature: TGuid read get_CscFeature;
    class property CscMeasurement: TGuid read get_CscMeasurement;
    class property GlucoseFeature: TGuid read get_GlucoseFeature;
    class property GlucoseMeasurement: TGuid read get_GlucoseMeasurement;
    class property GlucoseMeasurementContext: TGuid read get_GlucoseMeasurementContext;
    class property HeartRateControlPoint: TGuid read get_HeartRateControlPoint;
    class property HeartRateMeasurement: TGuid read get_HeartRateMeasurement;
    class property IntermediateCuffPressure: TGuid read get_IntermediateCuffPressure;
    class property IntermediateTemperature: TGuid read get_IntermediateTemperature;
    class property MeasurementInterval: TGuid read get_MeasurementInterval;
    class property RecordAccessControlPoint: TGuid read get_RecordAccessControlPoint;
    class property RscFeature: TGuid read get_RscFeature;
    class property RscMeasurement: TGuid read get_RscMeasurement;
    class property SCControlPoint: TGuid read get_SCControlPoint;
    class property SensorLocation: TGuid read get_SensorLocation;
    class property TemperatureMeasurement: TGuid read get_TemperatureMeasurement;
    class property TemperatureType: TGuid read get_TemperatureType;

    // -> GenericAttributeProfile_IGattCharacteristicUuidsStatics2
    class function get_AlertCategoryId: TGuid; static; inline;
    class function get_AlertCategoryIdBitMask: TGuid; static; inline;
    class function get_AlertLevel: TGuid; static; inline;
    class function get_AlertNotificationControlPoint: TGuid; static; inline;
    class function get_AlertStatus: TGuid; static; inline;
    class function get_GapAppearance: TGuid; static; inline;
    class function get_BootKeyboardInputReport: TGuid; static; inline;
    class function get_BootKeyboardOutputReport: TGuid; static; inline;
    class function get_BootMouseInputReport: TGuid; static; inline;
    class function get_CurrentTime: TGuid; static; inline;
    class function get_CyclingPowerControlPoint: TGuid; static; inline;
    class function get_CyclingPowerFeature: TGuid; static; inline;
    class function get_CyclingPowerMeasurement: TGuid; static; inline;
    class function get_CyclingPowerVector: TGuid; static; inline;
    class function get_DateTime: TGuid; static; inline;
    class function get_DayDateTime: TGuid; static; inline;
    class function get_DayOfWeek: TGuid; static; inline;
    class function get_GapDeviceName: TGuid; static; inline;
    class function get_DstOffset: TGuid; static; inline;
    class function get_ExactTime256: TGuid; static; inline;
    class function get_FirmwareRevisionString: TGuid; static; inline;
    class function get_HardwareRevisionString: TGuid; static; inline;
    class function get_HidControlPoint: TGuid; static; inline;
    class function get_HidInformation: TGuid; static; inline;
    class function get_Ieee1107320601RegulatoryCertificationDataList: TGuid; static; inline;
    class function get_LnControlPoint: TGuid; static; inline;
    class function get_LnFeature: TGuid; static; inline;
    class function get_LocalTimeInformation: TGuid; static; inline;
    class function get_LocationAndSpeed: TGuid; static; inline;
    class function get_ManufacturerNameString: TGuid; static; inline;
    class function get_ModelNumberString: TGuid; static; inline;
    class function get_Navigation: TGuid; static; inline;
    class function get_NewAlert: TGuid; static; inline;
    class function get_GapPeripheralPreferredConnectionParameters: TGuid; static; inline;
    class function get_GapPeripheralPrivacyFlag: TGuid; static; inline;
    class function get_PnpId: TGuid; static; inline;
    class function get_PositionQuality: TGuid; static; inline;
    class function get_ProtocolMode: TGuid; static; inline;
    class function get_GapReconnectionAddress: TGuid; static; inline;
    class function get_ReferenceTimeInformation: TGuid; static; inline;
    class function get_Report: TGuid; static; inline;
    class function get_ReportMap: TGuid; static; inline;
    class function get_RingerControlPoint: TGuid; static; inline;
    class function get_RingerSetting: TGuid; static; inline;
    class function get_ScanIntervalWindow: TGuid; static; inline;
    class function get_ScanRefresh: TGuid; static; inline;
    class function get_SerialNumberString: TGuid; static; inline;
    class function get_GattServiceChanged: TGuid; static; inline;
    class function get_SoftwareRevisionString: TGuid; static; inline;
    class function get_SupportedNewAlertCategory: TGuid; static; inline;
    class function get_SupportUnreadAlertCategory: TGuid; static; inline;
    class function get_SystemId: TGuid; static; inline;
    class function get_TimeAccuracy: TGuid; static; inline;
    class function get_TimeSource: TGuid; static; inline;
    class function get_TimeUpdateControlPoint: TGuid; static; inline;
    class function get_TimeUpdateState: TGuid; static; inline;
    class function get_TimeWithDst: TGuid; static; inline;
    class function get_TimeZone: TGuid; static; inline;
    class function get_TxPowerLevel: TGuid; static; inline;
    class function get_UnreadAlertStatus: TGuid; static; inline;
    class property AlertCategoryId: TGuid read get_AlertCategoryId;
    class property AlertCategoryIdBitMask: TGuid read get_AlertCategoryIdBitMask;
    class property AlertLevel: TGuid read get_AlertLevel;
    class property AlertNotificationControlPoint: TGuid read get_AlertNotificationControlPoint;
    class property AlertStatus: TGuid read get_AlertStatus;
    class property BootKeyboardInputReport: TGuid read get_BootKeyboardInputReport;
    class property BootKeyboardOutputReport: TGuid read get_BootKeyboardOutputReport;
    class property BootMouseInputReport: TGuid read get_BootMouseInputReport;
    class property CurrentTime: TGuid read get_CurrentTime;
    class property CyclingPowerControlPoint: TGuid read get_CyclingPowerControlPoint;
    class property CyclingPowerFeature: TGuid read get_CyclingPowerFeature;
    class property CyclingPowerMeasurement: TGuid read get_CyclingPowerMeasurement;
    class property CyclingPowerVector: TGuid read get_CyclingPowerVector;
    class property DateTime: TGuid read get_DateTime;
    class property DayDateTime: TGuid read get_DayDateTime;
    class property DayOfWeek: TGuid read get_DayOfWeek;
    class property DstOffset: TGuid read get_DstOffset;
    class property ExactTime256: TGuid read get_ExactTime256;
    class property FirmwareRevisionString: TGuid read get_FirmwareRevisionString;
    class property GapAppearance: TGuid read get_GapAppearance;
    class property GapDeviceName: TGuid read get_GapDeviceName;
    class property GapPeripheralPreferredConnectionParameters: TGuid read get_GapPeripheralPreferredConnectionParameters;
    class property GapPeripheralPrivacyFlag: TGuid read get_GapPeripheralPrivacyFlag;
    class property GapReconnectionAddress: TGuid read get_GapReconnectionAddress;
    class property GattServiceChanged: TGuid read get_GattServiceChanged;
    class property HardwareRevisionString: TGuid read get_HardwareRevisionString;
    class property HidControlPoint: TGuid read get_HidControlPoint;
    class property HidInformation: TGuid read get_HidInformation;
    class property Ieee1107320601RegulatoryCertificationDataList: TGuid read get_Ieee1107320601RegulatoryCertificationDataList;
    class property LnControlPoint: TGuid read get_LnControlPoint;
    class property LnFeature: TGuid read get_LnFeature;
    class property LocalTimeInformation: TGuid read get_LocalTimeInformation;
    class property LocationAndSpeed: TGuid read get_LocationAndSpeed;
    class property ManufacturerNameString: TGuid read get_ManufacturerNameString;
    class property ModelNumberString: TGuid read get_ModelNumberString;
    class property Navigation: TGuid read get_Navigation;
    class property NewAlert: TGuid read get_NewAlert;
    class property PnpId: TGuid read get_PnpId;
    class property PositionQuality: TGuid read get_PositionQuality;
    class property ProtocolMode: TGuid read get_ProtocolMode;
    class property ReferenceTimeInformation: TGuid read get_ReferenceTimeInformation;
    class property Report: TGuid read get_Report;
    class property ReportMap: TGuid read get_ReportMap;
    class property RingerControlPoint: TGuid read get_RingerControlPoint;
    class property RingerSetting: TGuid read get_RingerSetting;
    class property ScanIntervalWindow: TGuid read get_ScanIntervalWindow;
    class property ScanRefresh: TGuid read get_ScanRefresh;
    class property SerialNumberString: TGuid read get_SerialNumberString;
    class property SoftwareRevisionString: TGuid read get_SoftwareRevisionString;
    class property SupportUnreadAlertCategory: TGuid read get_SupportUnreadAlertCategory;
    class property SupportedNewAlertCategory: TGuid read get_SupportedNewAlertCategory;
    class property SystemId: TGuid read get_SystemId;
    class property TimeAccuracy: TGuid read get_TimeAccuracy;
    class property TimeSource: TGuid read get_TimeSource;
    class property TimeUpdateControlPoint: TGuid read get_TimeUpdateControlPoint;
    class property TimeUpdateState: TGuid read get_TimeUpdateState;
    class property TimeWithDst: TGuid read get_TimeWithDst;
    class property TimeZone: TGuid read get_TimeZone;
    class property TxPowerLevel: TGuid read get_TxPowerLevel;
    class property UnreadAlertStatus: TGuid read get_UnreadAlertStatus;
  end;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattDescriptorUuids
  // DualAPI
  TGenericAttributeProfile_GattDescriptorUuids = class(TWinRTGenericImportS<GenericAttributeProfile_IGattDescriptorUuidsStatics>)
  public
    // -> GenericAttributeProfile_IGattDescriptorUuidsStatics
    class function get_CharacteristicAggregateFormat: TGuid; static; inline;
    class function get_CharacteristicExtendedProperties: TGuid; static; inline;
    class function get_CharacteristicPresentationFormat: TGuid; static; inline;
    class function get_CharacteristicUserDescription: TGuid; static; inline;
    class function get_ClientCharacteristicConfiguration: TGuid; static; inline;
    class function get_ServerCharacteristicConfiguration: TGuid; static; inline;
    class property CharacteristicAggregateFormat: TGuid read get_CharacteristicAggregateFormat;
    class property CharacteristicExtendedProperties: TGuid read get_CharacteristicExtendedProperties;
    class property CharacteristicPresentationFormat: TGuid read get_CharacteristicPresentationFormat;
    class property CharacteristicUserDescription: TGuid read get_CharacteristicUserDescription;
    class property ClientCharacteristicConfiguration: TGuid read get_ClientCharacteristicConfiguration;
    class property ServerCharacteristicConfiguration: TGuid read get_ServerCharacteristicConfiguration;
  end;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattReliableWriteTransaction
  // DualAPI
  TGenericAttributeProfile_GattReliableWriteTransaction = class(TWinRTGenericImportI<GenericAttributeProfile_IGattReliableWriteTransaction>) end;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattPresentationFormatTypes
  // DualAPI
  TGenericAttributeProfile_GattPresentationFormatTypes = class(TWinRTGenericImportS<GenericAttributeProfile_IGattPresentationFormatTypesStatics>)
  public
    // -> GenericAttributeProfile_IGattPresentationFormatTypesStatics
    class function get_Boolean: Byte; static; inline;
    class function get_Bit2: Byte; static; inline;
    class function get_Nibble: Byte; static; inline;
    class function get_UInt8: Byte; static; inline;
    class function get_UInt12: Byte; static; inline;
    class function get_UInt16: Byte; static; inline;
    class function get_UInt24: Byte; static; inline;
    class function get_UInt32: Byte; static; inline;
    class function get_UInt48: Byte; static; inline;
    class function get_UInt64: Byte; static; inline;
    class function get_UInt128: Byte; static; inline;
    class function get_SInt8: Byte; static; inline;
    class function get_SInt12: Byte; static; inline;
    class function get_SInt16: Byte; static; inline;
    class function get_SInt24: Byte; static; inline;
    class function get_SInt32: Byte; static; inline;
    class function get_SInt48: Byte; static; inline;
    class function get_SInt64: Byte; static; inline;
    class function get_SInt128: Byte; static; inline;
    class function get_Float32: Byte; static; inline;
    class function get_Float64: Byte; static; inline;
    class function get_SFloat: Byte; static; inline;
    class function get_Float: Byte; static; inline;
    class function get_DUInt16: Byte; static; inline;
    class function get_Utf8: Byte; static; inline;
    class function get_Utf16: Byte; static; inline;
    class function get_Struct: Byte; static; inline;
    class property Bit2: Byte read get_Bit2;
    class property Boolean: Byte read get_Boolean;
    class property DUInt16: Byte read get_DUInt16;
    class property Float: Byte read get_Float;
    class property Float32: Byte read get_Float32;
    class property Float64: Byte read get_Float64;
    class property Nibble: Byte read get_Nibble;
    class property SFloat: Byte read get_SFloat;
    class property SInt12: Byte read get_SInt12;
    class property SInt128: Byte read get_SInt128;
    class property SInt16: Byte read get_SInt16;
    class property SInt24: Byte read get_SInt24;
    class property SInt32: Byte read get_SInt32;
    class property SInt48: Byte read get_SInt48;
    class property SInt64: Byte read get_SInt64;
    class property SInt8: Byte read get_SInt8;
    class property Struct: Byte read get_Struct;
    class property UInt12: Byte read get_UInt12;
    class property UInt128: Byte read get_UInt128;
    class property UInt16: Byte read get_UInt16;
    class property UInt24: Byte read get_UInt24;
    class property UInt32: Byte read get_UInt32;
    class property UInt48: Byte read get_UInt48;
    class property UInt64: Byte read get_UInt64;
    class property UInt8: Byte read get_UInt8;
    class property Utf16: Byte read get_Utf16;
    class property Utf8: Byte read get_Utf8;
  end;

  // Windows.Devices.Bluetooth.Rfcomm.RfcommServiceId
  // DualAPI
  TRfcomm_RfcommServiceId = class(TWinRTGenericImportS<Rfcomm_IRfcommServiceIdStatics>)
  public
    // -> Rfcomm_IRfcommServiceIdStatics
    class function FromUuid(uuid: TGuid): Rfcomm_IRfcommServiceId; static; inline;
    class function FromShortId(shortId: Cardinal): Rfcomm_IRfcommServiceId; static; inline;
    class function get_SerialPort: Rfcomm_IRfcommServiceId; static; inline;
    class function get_ObexObjectPush: Rfcomm_IRfcommServiceId; static; inline;
    class function get_ObexFileTransfer: Rfcomm_IRfcommServiceId; static; inline;
    class function get_PhoneBookAccessPce: Rfcomm_IRfcommServiceId; static; inline;
    class function get_PhoneBookAccessPse: Rfcomm_IRfcommServiceId; static; inline;
    class function get_GenericFileTransfer: Rfcomm_IRfcommServiceId; static; inline;
    class property GenericFileTransfer: Rfcomm_IRfcommServiceId read get_GenericFileTransfer;
    class property ObexFileTransfer: Rfcomm_IRfcommServiceId read get_ObexFileTransfer;
    class property ObexObjectPush: Rfcomm_IRfcommServiceId read get_ObexObjectPush;
    class property PhoneBookAccessPce: Rfcomm_IRfcommServiceId read get_PhoneBookAccessPce;
    class property PhoneBookAccessPse: Rfcomm_IRfcommServiceId read get_PhoneBookAccessPse;
    class property SerialPort: Rfcomm_IRfcommServiceId read get_SerialPort;
  end;

  // Windows.Devices.Bluetooth.Rfcomm.RfcommServiceProvider
  // DualAPI
  TRfcomm_RfcommServiceProvider = class(TWinRTGenericImportS<Rfcomm_IRfcommServiceProviderStatics>)
  public
    // -> Rfcomm_IRfcommServiceProviderStatics
    class function CreateAsync(serviceId: Rfcomm_IRfcommServiceId): IAsyncOperation_1__Rfcomm_IRfcommServiceProvider; static; inline;
  end;


implementation

  // Emit Classes Implementation
 { TBluetoothClassOfDevice }

class function TBluetoothClassOfDevice.FromRawValue(rawValue: Cardinal): IBluetoothClassOfDevice;
begin
  Result := Statics.FromRawValue(rawValue);
end;

class function TBluetoothClassOfDevice.FromParts(majorClass: BluetoothMajorClass; minorClass: BluetoothMinorClass; serviceCapabilities: BluetoothServiceCapabilities): IBluetoothClassOfDevice;
begin
  Result := Statics.FromParts(majorClass, minorClass, serviceCapabilities);
end;


 { TRfcomm_RfcommDeviceService }

class function TRfcomm_RfcommDeviceService.FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__Rfcomm_IRfcommDeviceService;
begin
  Result := Statics.FromIdAsync(deviceId);
end;

class function TRfcomm_RfcommDeviceService.GetDeviceSelector(serviceId: Rfcomm_IRfcommServiceId): HSTRING;
begin
  Result := Statics.GetDeviceSelector(serviceId);
end;


 { TBluetoothDevice }

class function TBluetoothDevice.FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IBluetoothDevice;
begin
  Result := Statics.FromIdAsync(deviceId);
end;

class function TBluetoothDevice.FromHostNameAsync(hostName: IHostName): IAsyncOperation_1__IBluetoothDevice;
begin
  Result := Statics.FromHostNameAsync(hostName);
end;

class function TBluetoothDevice.FromBluetoothAddressAsync(address: UInt64): IAsyncOperation_1__IBluetoothDevice;
begin
  Result := Statics.FromBluetoothAddressAsync(address);
end;

class function TBluetoothDevice.GetDeviceSelector: HSTRING;
begin
  Result := Statics.GetDeviceSelector;
end;


 { TGenericAttributeProfile_GattDeviceService }

class function TGenericAttributeProfile_GattDeviceService.FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__GenericAttributeProfile_IGattDeviceService;
begin
  Result := Statics.FromIdAsync(deviceId);
end;

class function TGenericAttributeProfile_GattDeviceService.GetDeviceSelectorFromUuid(serviceUuid: TGuid): HSTRING;
begin
  Result := Statics.GetDeviceSelectorFromUuid(serviceUuid);
end;

class function TGenericAttributeProfile_GattDeviceService.GetDeviceSelectorFromShortId(serviceShortId: Word): HSTRING;
begin
  Result := Statics.GetDeviceSelectorFromShortId(serviceShortId);
end;

class function TGenericAttributeProfile_GattDeviceService.ConvertShortIdToUuid(shortId: Word): TGuid;
begin
  Result := Statics.ConvertShortIdToUuid(shortId);
end;


 { TBluetoothLEDevice }

class function TBluetoothLEDevice.FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IBluetoothLEDevice;
begin
  Result := Statics.FromIdAsync(deviceId);
end;

class function TBluetoothLEDevice.FromBluetoothAddressAsync(bluetoothAddress: UInt64): IAsyncOperation_1__IBluetoothLEDevice;
begin
  Result := Statics.FromBluetoothAddressAsync(bluetoothAddress);
end;

class function TBluetoothLEDevice.GetDeviceSelector: HSTRING;
begin
  Result := Statics.GetDeviceSelector;
end;


 { TBluetoothSignalStrengthFilter }

 { TGenericAttributeProfile_GattCharacteristic }

class function TGenericAttributeProfile_GattCharacteristic.ConvertShortIdToUuid(shortId: Word): TGuid;
begin
  Result := Statics.ConvertShortIdToUuid(shortId);
end;


 { TGenericAttributeProfile_GattDescriptor }

class function TGenericAttributeProfile_GattDescriptor.ConvertShortIdToUuid(shortId: Word): TGuid;
begin
  Result := Statics.ConvertShortIdToUuid(shortId);
end;


 { TGenericAttributeProfile_GattPresentationFormat }

class function TGenericAttributeProfile_GattPresentationFormat.get_BluetoothSigAssignedNumbers: Byte;
begin
  Result := Statics.get_BluetoothSigAssignedNumbers;
end;


 { TGenericAttributeProfile_GattServiceUuids }

class function TGenericAttributeProfile_GattServiceUuids.get_Battery: TGuid;
begin
  Result := Statics.get_Battery;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_BloodPressure: TGuid;
begin
  Result := Statics.get_BloodPressure;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_CyclingSpeedAndCadence: TGuid;
begin
  Result := Statics.get_CyclingSpeedAndCadence;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_GenericAccess: TGuid;
begin
  Result := Statics.get_GenericAccess;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_GenericAttribute: TGuid;
begin
  Result := Statics.get_GenericAttribute;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_Glucose: TGuid;
begin
  Result := Statics.get_Glucose;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_HealthThermometer: TGuid;
begin
  Result := Statics.get_HealthThermometer;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_HeartRate: TGuid;
begin
  Result := Statics.get_HeartRate;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_RunningSpeedAndCadence: TGuid;
begin
  Result := Statics.get_RunningSpeedAndCadence;
end;


class function TGenericAttributeProfile_GattServiceUuids.get_AlertNotification: TGuid;
begin
  Result := Statics2.get_AlertNotification;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_CurrentTime: TGuid;
begin
  Result := Statics2.get_CurrentTime;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_CyclingPower: TGuid;
begin
  Result := Statics2.get_CyclingPower;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_DeviceInformation: TGuid;
begin
  Result := Statics2.get_DeviceInformation;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_HumanInterfaceDevice: TGuid;
begin
  Result := Statics2.get_HumanInterfaceDevice;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_ImmediateAlert: TGuid;
begin
  Result := Statics2.get_ImmediateAlert;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_LinkLoss: TGuid;
begin
  Result := Statics2.get_LinkLoss;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_LocationAndNavigation: TGuid;
begin
  Result := Statics2.get_LocationAndNavigation;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_NextDstChange: TGuid;
begin
  Result := Statics2.get_NextDstChange;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_PhoneAlertStatus: TGuid;
begin
  Result := Statics2.get_PhoneAlertStatus;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_ReferenceTimeUpdate: TGuid;
begin
  Result := Statics2.get_ReferenceTimeUpdate;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_ScanParameters: TGuid;
begin
  Result := Statics2.get_ScanParameters;
end;

class function TGenericAttributeProfile_GattServiceUuids.get_TxPower: TGuid;
begin
  Result := Statics2.get_TxPower;
end;


 { TGenericAttributeProfile_GattCharacteristicUuids }

class function TGenericAttributeProfile_GattCharacteristicUuids.get_BatteryLevel: TGuid;
begin
  Result := Statics.get_BatteryLevel;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_BloodPressureFeature: TGuid;
begin
  Result := Statics.get_BloodPressureFeature;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_BloodPressureMeasurement: TGuid;
begin
  Result := Statics.get_BloodPressureMeasurement;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_BodySensorLocation: TGuid;
begin
  Result := Statics.get_BodySensorLocation;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_CscFeature: TGuid;
begin
  Result := Statics.get_CscFeature;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_CscMeasurement: TGuid;
begin
  Result := Statics.get_CscMeasurement;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_GlucoseFeature: TGuid;
begin
  Result := Statics.get_GlucoseFeature;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_GlucoseMeasurement: TGuid;
begin
  Result := Statics.get_GlucoseMeasurement;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_GlucoseMeasurementContext: TGuid;
begin
  Result := Statics.get_GlucoseMeasurementContext;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_HeartRateControlPoint: TGuid;
begin
  Result := Statics.get_HeartRateControlPoint;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_HeartRateMeasurement: TGuid;
begin
  Result := Statics.get_HeartRateMeasurement;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_IntermediateCuffPressure: TGuid;
begin
  Result := Statics.get_IntermediateCuffPressure;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_IntermediateTemperature: TGuid;
begin
  Result := Statics.get_IntermediateTemperature;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_MeasurementInterval: TGuid;
begin
  Result := Statics.get_MeasurementInterval;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_RecordAccessControlPoint: TGuid;
begin
  Result := Statics.get_RecordAccessControlPoint;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_RscFeature: TGuid;
begin
  Result := Statics.get_RscFeature;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_RscMeasurement: TGuid;
begin
  Result := Statics.get_RscMeasurement;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_SCControlPoint: TGuid;
begin
  Result := Statics.get_SCControlPoint;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_SensorLocation: TGuid;
begin
  Result := Statics.get_SensorLocation;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_TemperatureMeasurement: TGuid;
begin
  Result := Statics.get_TemperatureMeasurement;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_TemperatureType: TGuid;
begin
  Result := Statics.get_TemperatureType;
end;


class function TGenericAttributeProfile_GattCharacteristicUuids.get_AlertCategoryId: TGuid;
begin
  Result := Statics2.get_AlertCategoryId;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_AlertCategoryIdBitMask: TGuid;
begin
  Result := Statics2.get_AlertCategoryIdBitMask;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_AlertLevel: TGuid;
begin
  Result := Statics2.get_AlertLevel;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_AlertNotificationControlPoint: TGuid;
begin
  Result := Statics2.get_AlertNotificationControlPoint;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_AlertStatus: TGuid;
begin
  Result := Statics2.get_AlertStatus;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_GapAppearance: TGuid;
begin
  Result := Statics2.get_GapAppearance;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_BootKeyboardInputReport: TGuid;
begin
  Result := Statics2.get_BootKeyboardInputReport;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_BootKeyboardOutputReport: TGuid;
begin
  Result := Statics2.get_BootKeyboardOutputReport;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_BootMouseInputReport: TGuid;
begin
  Result := Statics2.get_BootMouseInputReport;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_CurrentTime: TGuid;
begin
  Result := Statics2.get_CurrentTime;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_CyclingPowerControlPoint: TGuid;
begin
  Result := Statics2.get_CyclingPowerControlPoint;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_CyclingPowerFeature: TGuid;
begin
  Result := Statics2.get_CyclingPowerFeature;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_CyclingPowerMeasurement: TGuid;
begin
  Result := Statics2.get_CyclingPowerMeasurement;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_CyclingPowerVector: TGuid;
begin
  Result := Statics2.get_CyclingPowerVector;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_DateTime: TGuid;
begin
  Result := Statics2.get_DateTime;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_DayDateTime: TGuid;
begin
  Result := Statics2.get_DayDateTime;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_DayOfWeek: TGuid;
begin
  Result := Statics2.get_DayOfWeek;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_GapDeviceName: TGuid;
begin
  Result := Statics2.get_GapDeviceName;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_DstOffset: TGuid;
begin
  Result := Statics2.get_DstOffset;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_ExactTime256: TGuid;
begin
  Result := Statics2.get_ExactTime256;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_FirmwareRevisionString: TGuid;
begin
  Result := Statics2.get_FirmwareRevisionString;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_HardwareRevisionString: TGuid;
begin
  Result := Statics2.get_HardwareRevisionString;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_HidControlPoint: TGuid;
begin
  Result := Statics2.get_HidControlPoint;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_HidInformation: TGuid;
begin
  Result := Statics2.get_HidInformation;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_Ieee1107320601RegulatoryCertificationDataList: TGuid;
begin
  Result := Statics2.get_Ieee1107320601RegulatoryCertificationDataList;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_LnControlPoint: TGuid;
begin
  Result := Statics2.get_LnControlPoint;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_LnFeature: TGuid;
begin
  Result := Statics2.get_LnFeature;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_LocalTimeInformation: TGuid;
begin
  Result := Statics2.get_LocalTimeInformation;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_LocationAndSpeed: TGuid;
begin
  Result := Statics2.get_LocationAndSpeed;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_ManufacturerNameString: TGuid;
begin
  Result := Statics2.get_ManufacturerNameString;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_ModelNumberString: TGuid;
begin
  Result := Statics2.get_ModelNumberString;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_Navigation: TGuid;
begin
  Result := Statics2.get_Navigation;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_NewAlert: TGuid;
begin
  Result := Statics2.get_NewAlert;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_GapPeripheralPreferredConnectionParameters: TGuid;
begin
  Result := Statics2.get_GapPeripheralPreferredConnectionParameters;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_GapPeripheralPrivacyFlag: TGuid;
begin
  Result := Statics2.get_GapPeripheralPrivacyFlag;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_PnpId: TGuid;
begin
  Result := Statics2.get_PnpId;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_PositionQuality: TGuid;
begin
  Result := Statics2.get_PositionQuality;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_ProtocolMode: TGuid;
begin
  Result := Statics2.get_ProtocolMode;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_GapReconnectionAddress: TGuid;
begin
  Result := Statics2.get_GapReconnectionAddress;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_ReferenceTimeInformation: TGuid;
begin
  Result := Statics2.get_ReferenceTimeInformation;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_Report: TGuid;
begin
  Result := Statics2.get_Report;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_ReportMap: TGuid;
begin
  Result := Statics2.get_ReportMap;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_RingerControlPoint: TGuid;
begin
  Result := Statics2.get_RingerControlPoint;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_RingerSetting: TGuid;
begin
  Result := Statics2.get_RingerSetting;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_ScanIntervalWindow: TGuid;
begin
  Result := Statics2.get_ScanIntervalWindow;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_ScanRefresh: TGuid;
begin
  Result := Statics2.get_ScanRefresh;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_SerialNumberString: TGuid;
begin
  Result := Statics2.get_SerialNumberString;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_GattServiceChanged: TGuid;
begin
  Result := Statics2.get_GattServiceChanged;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_SoftwareRevisionString: TGuid;
begin
  Result := Statics2.get_SoftwareRevisionString;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_SupportedNewAlertCategory: TGuid;
begin
  Result := Statics2.get_SupportedNewAlertCategory;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_SupportUnreadAlertCategory: TGuid;
begin
  Result := Statics2.get_SupportUnreadAlertCategory;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_SystemId: TGuid;
begin
  Result := Statics2.get_SystemId;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_TimeAccuracy: TGuid;
begin
  Result := Statics2.get_TimeAccuracy;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_TimeSource: TGuid;
begin
  Result := Statics2.get_TimeSource;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_TimeUpdateControlPoint: TGuid;
begin
  Result := Statics2.get_TimeUpdateControlPoint;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_TimeUpdateState: TGuid;
begin
  Result := Statics2.get_TimeUpdateState;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_TimeWithDst: TGuid;
begin
  Result := Statics2.get_TimeWithDst;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_TimeZone: TGuid;
begin
  Result := Statics2.get_TimeZone;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_TxPowerLevel: TGuid;
begin
  Result := Statics2.get_TxPowerLevel;
end;

class function TGenericAttributeProfile_GattCharacteristicUuids.get_UnreadAlertStatus: TGuid;
begin
  Result := Statics2.get_UnreadAlertStatus;
end;


 { TGenericAttributeProfile_GattDescriptorUuids }

class function TGenericAttributeProfile_GattDescriptorUuids.get_CharacteristicAggregateFormat: TGuid;
begin
  Result := Statics.get_CharacteristicAggregateFormat;
end;

class function TGenericAttributeProfile_GattDescriptorUuids.get_CharacteristicExtendedProperties: TGuid;
begin
  Result := Statics.get_CharacteristicExtendedProperties;
end;

class function TGenericAttributeProfile_GattDescriptorUuids.get_CharacteristicPresentationFormat: TGuid;
begin
  Result := Statics.get_CharacteristicPresentationFormat;
end;

class function TGenericAttributeProfile_GattDescriptorUuids.get_CharacteristicUserDescription: TGuid;
begin
  Result := Statics.get_CharacteristicUserDescription;
end;

class function TGenericAttributeProfile_GattDescriptorUuids.get_ClientCharacteristicConfiguration: TGuid;
begin
  Result := Statics.get_ClientCharacteristicConfiguration;
end;

class function TGenericAttributeProfile_GattDescriptorUuids.get_ServerCharacteristicConfiguration: TGuid;
begin
  Result := Statics.get_ServerCharacteristicConfiguration;
end;


 { TGenericAttributeProfile_GattReliableWriteTransaction }

 { TGenericAttributeProfile_GattPresentationFormatTypes }

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_Boolean: Byte;
begin
  Result := Statics.get_Boolean;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_Bit2: Byte;
begin
  Result := Statics.get_Bit2;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_Nibble: Byte;
begin
  Result := Statics.get_Nibble;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_UInt8: Byte;
begin
  Result := Statics.get_UInt8;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_UInt12: Byte;
begin
  Result := Statics.get_UInt12;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_UInt16: Byte;
begin
  Result := Statics.get_UInt16;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_UInt24: Byte;
begin
  Result := Statics.get_UInt24;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_UInt32: Byte;
begin
  Result := Statics.get_UInt32;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_UInt48: Byte;
begin
  Result := Statics.get_UInt48;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_UInt64: Byte;
begin
  Result := Statics.get_UInt64;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_UInt128: Byte;
begin
  Result := Statics.get_UInt128;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_SInt8: Byte;
begin
  Result := Statics.get_SInt8;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_SInt12: Byte;
begin
  Result := Statics.get_SInt12;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_SInt16: Byte;
begin
  Result := Statics.get_SInt16;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_SInt24: Byte;
begin
  Result := Statics.get_SInt24;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_SInt32: Byte;
begin
  Result := Statics.get_SInt32;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_SInt48: Byte;
begin
  Result := Statics.get_SInt48;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_SInt64: Byte;
begin
  Result := Statics.get_SInt64;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_SInt128: Byte;
begin
  Result := Statics.get_SInt128;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_Float32: Byte;
begin
  Result := Statics.get_Float32;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_Float64: Byte;
begin
  Result := Statics.get_Float64;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_SFloat: Byte;
begin
  Result := Statics.get_SFloat;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_Float: Byte;
begin
  Result := Statics.get_Float;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_DUInt16: Byte;
begin
  Result := Statics.get_DUInt16;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_Utf8: Byte;
begin
  Result := Statics.get_Utf8;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_Utf16: Byte;
begin
  Result := Statics.get_Utf16;
end;

class function TGenericAttributeProfile_GattPresentationFormatTypes.get_Struct: Byte;
begin
  Result := Statics.get_Struct;
end;


 { TRfcomm_RfcommServiceId }

class function TRfcomm_RfcommServiceId.FromUuid(uuid: TGuid): Rfcomm_IRfcommServiceId;
begin
  Result := Statics.FromUuid(uuid);
end;

class function TRfcomm_RfcommServiceId.FromShortId(shortId: Cardinal): Rfcomm_IRfcommServiceId;
begin
  Result := Statics.FromShortId(shortId);
end;

class function TRfcomm_RfcommServiceId.get_SerialPort: Rfcomm_IRfcommServiceId;
begin
  Result := Statics.get_SerialPort;
end;

class function TRfcomm_RfcommServiceId.get_ObexObjectPush: Rfcomm_IRfcommServiceId;
begin
  Result := Statics.get_ObexObjectPush;
end;

class function TRfcomm_RfcommServiceId.get_ObexFileTransfer: Rfcomm_IRfcommServiceId;
begin
  Result := Statics.get_ObexFileTransfer;
end;

class function TRfcomm_RfcommServiceId.get_PhoneBookAccessPce: Rfcomm_IRfcommServiceId;
begin
  Result := Statics.get_PhoneBookAccessPce;
end;

class function TRfcomm_RfcommServiceId.get_PhoneBookAccessPse: Rfcomm_IRfcommServiceId;
begin
  Result := Statics.get_PhoneBookAccessPse;
end;

class function TRfcomm_RfcommServiceId.get_GenericFileTransfer: Rfcomm_IRfcommServiceId;
begin
  Result := Statics.get_GenericFileTransfer;
end;


 { TRfcomm_RfcommServiceProvider }

class function TRfcomm_RfcommServiceProvider.CreateAsync(serviceId: Rfcomm_IRfcommServiceId): IAsyncOperation_1__Rfcomm_IRfcommServiceProvider;
begin
  Result := Statics.CreateAsync(serviceId);
end;



end.
