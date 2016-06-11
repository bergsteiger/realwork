{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Devices.PointOfService;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.GraphicsRT,
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

const
  // Windows.Devices.PointOfService Class Names
  // Windows.Devices.PointOfService.PosPrinterCharacterSetIds
  // DualAPI
  SPosPrinterCharacterSetIds = 'Windows.Devices.PointOfService.PosPrinterCharacterSetIds';
  // Windows.Devices.PointOfService.ReceiptPrinterCapabilities
  // DualAPI
  SReceiptPrinterCapabilities = 'Windows.Devices.PointOfService.ReceiptPrinterCapabilities';
  // Windows.Devices.PointOfService.SlipPrinterCapabilities
  // DualAPI
  SSlipPrinterCapabilities = 'Windows.Devices.PointOfService.SlipPrinterCapabilities';
  // Windows.Devices.PointOfService.JournalPrinterCapabilities
  // DualAPI
  SJournalPrinterCapabilities = 'Windows.Devices.PointOfService.JournalPrinterCapabilities';
  // Windows.Devices.PointOfService.PosPrinterCapabilities
  // DualAPI
  SPosPrinterCapabilities = 'Windows.Devices.PointOfService.PosPrinterCapabilities';
  // Windows.Devices.PointOfService.PosPrinterStatus
  // DualAPI
  SPosPrinterStatus = 'Windows.Devices.PointOfService.PosPrinterStatus';
  // Windows.Devices.PointOfService.PosPrinterStatusUpdatedEventArgs
  // DualAPI
  SPosPrinterStatusUpdatedEventArgs = 'Windows.Devices.PointOfService.PosPrinterStatusUpdatedEventArgs';
  // Windows.Devices.PointOfService.PosPrinterReleaseDeviceRequestedEventArgs
  // DualAPI
  SPosPrinterReleaseDeviceRequestedEventArgs = 'Windows.Devices.PointOfService.PosPrinterReleaseDeviceRequestedEventArgs';
  // Windows.Devices.PointOfService.PosPrinter
  // DualAPI
  SPosPrinter = 'Windows.Devices.PointOfService.PosPrinter';
  // Windows.Devices.PointOfService.ClaimedPosPrinter
  // DualAPI
  SClaimedPosPrinter = 'Windows.Devices.PointOfService.ClaimedPosPrinter';
  // Windows.Devices.PointOfService.ReceiptPrintJob
  // DualAPI
  SReceiptPrintJob = 'Windows.Devices.PointOfService.ReceiptPrintJob';
  // Windows.Devices.PointOfService.SlipPrintJob
  // DualAPI
  SSlipPrintJob = 'Windows.Devices.PointOfService.SlipPrintJob';
  // Windows.Devices.PointOfService.JournalPrintJob
  // DualAPI
  SJournalPrintJob = 'Windows.Devices.PointOfService.JournalPrintJob';
  // Windows.Devices.PointOfService.ClaimedReceiptPrinter
  // DualAPI
  SClaimedReceiptPrinter = 'Windows.Devices.PointOfService.ClaimedReceiptPrinter';
  // Windows.Devices.PointOfService.ClaimedSlipPrinter
  // DualAPI
  SClaimedSlipPrinter = 'Windows.Devices.PointOfService.ClaimedSlipPrinter';
  // Windows.Devices.PointOfService.ClaimedJournalPrinter
  // DualAPI
  SClaimedJournalPrinter = 'Windows.Devices.PointOfService.ClaimedJournalPrinter';
  // Windows.Devices.PointOfService.CashDrawerStatus
  // DualAPI
  SCashDrawerStatus = 'Windows.Devices.PointOfService.CashDrawerStatus';
  // Windows.Devices.PointOfService.CashDrawerStatusUpdatedEventArgs
  // DualAPI
  SCashDrawerStatusUpdatedEventArgs = 'Windows.Devices.PointOfService.CashDrawerStatusUpdatedEventArgs';
  // Windows.Devices.PointOfService.CashDrawerCapabilities
  // DualAPI
  SCashDrawerCapabilities = 'Windows.Devices.PointOfService.CashDrawerCapabilities';
  // Windows.Devices.PointOfService.CashDrawer
  // DualAPI
  SCashDrawer = 'Windows.Devices.PointOfService.CashDrawer';
  // Windows.Devices.PointOfService.CashDrawerClosedEventArgs
  // DualAPI
  SCashDrawerClosedEventArgs = 'Windows.Devices.PointOfService.CashDrawerClosedEventArgs';
  // Windows.Devices.PointOfService.CashDrawerOpenedEventArgs
  // DualAPI
  SCashDrawerOpenedEventArgs = 'Windows.Devices.PointOfService.CashDrawerOpenedEventArgs';
  // Windows.Devices.PointOfService.CashDrawerEventSource
  // DualAPI
  SCashDrawerEventSource = 'Windows.Devices.PointOfService.CashDrawerEventSource';
  // Windows.Devices.PointOfService.ClaimedCashDrawer
  // DualAPI
  SClaimedCashDrawer = 'Windows.Devices.PointOfService.ClaimedCashDrawer';
  // Windows.Devices.PointOfService.CashDrawerCloseAlarm
  // DualAPI
  SCashDrawerCloseAlarm = 'Windows.Devices.PointOfService.CashDrawerCloseAlarm';


type
  // Forward declare interfaces
  // Windows.Devices.PointOfService.IPosPrinterCharacterSetIdsStatics
  IPosPrinterCharacterSetIdsStatics = interface;
  PIPosPrinterCharacterSetIdsStatics = ^IPosPrinterCharacterSetIdsStatics;

  // Windows.Devices.PointOfService.ICommonPosPrintStationCapabilities
  ICommonPosPrintStationCapabilities = interface;
  PICommonPosPrintStationCapabilities = ^ICommonPosPrintStationCapabilities;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.PointOfService.PosPrinterRotation>
  IIterator_1__PosPrinterRotation = interface;
  PIIterator_1__PosPrinterRotation = ^IIterator_1__PosPrinterRotation;

  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.PointOfService.PosPrinterRotation>
  IIterable_1__PosPrinterRotation = interface;
  PIIterable_1__PosPrinterRotation = ^IIterable_1__PosPrinterRotation;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.PointOfService.PosPrinterRotation>
  IVectorView_1__PosPrinterRotation = interface;
  PIVectorView_1__PosPrinterRotation = ^IVectorView_1__PosPrinterRotation;

  // Windows.Devices.PointOfService.ICommonReceiptSlipCapabilities
  ICommonReceiptSlipCapabilities = interface;
  PICommonReceiptSlipCapabilities = ^ICommonReceiptSlipCapabilities;

  // Windows.Devices.PointOfService.IReceiptPrinterCapabilities
  IReceiptPrinterCapabilities = interface;
  PIReceiptPrinterCapabilities = ^IReceiptPrinterCapabilities;

  // Windows.Devices.PointOfService.ISlipPrinterCapabilities
  ISlipPrinterCapabilities = interface;
  PISlipPrinterCapabilities = ^ISlipPrinterCapabilities;

  // Windows.Devices.PointOfService.IJournalPrinterCapabilities
  IJournalPrinterCapabilities = interface;
  PIJournalPrinterCapabilities = ^IJournalPrinterCapabilities;

  // Windows.Devices.PointOfService.IPosPrinterCapabilities
  IPosPrinterCapabilities = interface;
  PIPosPrinterCapabilities = ^IPosPrinterCapabilities;

  // Windows.Devices.PointOfService.IPosPrinterStatus
  IPosPrinterStatus = interface;
  PIPosPrinterStatus = ^IPosPrinterStatus;

  // Windows.Devices.PointOfService.IPosPrinterStatusUpdatedEventArgs
  IPosPrinterStatusUpdatedEventArgs = interface;
  PIPosPrinterStatusUpdatedEventArgs = ^IPosPrinterStatusUpdatedEventArgs;

  // Windows.Devices.PointOfService.IPosPrinterReleaseDeviceRequestedEventArgs
  IPosPrinterReleaseDeviceRequestedEventArgs = interface;
  PIPosPrinterReleaseDeviceRequestedEventArgs = ^IPosPrinterReleaseDeviceRequestedEventArgs;

  // Windows.Devices.PointOfService.ICommonClaimedPosPrinterStation
  ICommonClaimedPosPrinterStation = interface;
  PICommonClaimedPosPrinterStation = ^ICommonClaimedPosPrinterStation;

  // Windows.Devices.PointOfService.IPosPrinterJob
  IPosPrinterJob = interface;
  PIPosPrinterJob = ^IPosPrinterJob;

  // Windows.Devices.PointOfService.IReceiptOrSlipJob
  IReceiptOrSlipJob = interface;
  PIReceiptOrSlipJob = ^IReceiptOrSlipJob;

  // Windows.Devices.PointOfService.IReceiptPrintJob
  IReceiptPrintJob = interface;
  PIReceiptPrintJob = ^IReceiptPrintJob;

  // Windows.Devices.PointOfService.IClaimedReceiptPrinter
  IClaimedReceiptPrinter = interface;
  PIClaimedReceiptPrinter = ^IClaimedReceiptPrinter;

  // Windows.Devices.PointOfService.IClaimedSlipPrinter
  IClaimedSlipPrinter = interface;
  PIClaimedSlipPrinter = ^IClaimedSlipPrinter;

  // Windows.Devices.PointOfService.IClaimedJournalPrinter
  IClaimedJournalPrinter = interface;
  PIClaimedJournalPrinter = ^IClaimedJournalPrinter;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.IClaimedPosPrinter,Windows.Devices.PointOfService.IPosPrinterReleaseDeviceRequestedEventArgs>
  TypedEventHandler_2__IClaimedPosPrinter__IPosPrinterReleaseDeviceRequestedEventArgs = interface;
  PTypedEventHandler_2__IClaimedPosPrinter__IPosPrinterReleaseDeviceRequestedEventArgs = ^TypedEventHandler_2__IClaimedPosPrinter__IPosPrinterReleaseDeviceRequestedEventArgs;

  // Windows.Devices.PointOfService.IClaimedPosPrinter
  IClaimedPosPrinter = interface;
  PIClaimedPosPrinter = ^IClaimedPosPrinter;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.PointOfService.IClaimedPosPrinter>
  AsyncOperationCompletedHandler_1__IClaimedPosPrinter = interface;
  PAsyncOperationCompletedHandler_1__IClaimedPosPrinter = ^AsyncOperationCompletedHandler_1__IClaimedPosPrinter;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.PointOfService.IClaimedPosPrinter>
  IAsyncOperation_1__IClaimedPosPrinter = interface;
  PIAsyncOperation_1__IClaimedPosPrinter = ^IAsyncOperation_1__IClaimedPosPrinter;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.IPosPrinter,Windows.Devices.PointOfService.IPosPrinterStatusUpdatedEventArgs>
  TypedEventHandler_2__IPosPrinter__IPosPrinterStatusUpdatedEventArgs = interface;
  PTypedEventHandler_2__IPosPrinter__IPosPrinterStatusUpdatedEventArgs = ^TypedEventHandler_2__IPosPrinter__IPosPrinterStatusUpdatedEventArgs;

  // Windows.Devices.PointOfService.IPosPrinter
  IPosPrinter = interface;
  PIPosPrinter = ^IPosPrinter;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.PointOfService.IPosPrinter>
  AsyncOperationCompletedHandler_1__IPosPrinter = interface;
  PAsyncOperationCompletedHandler_1__IPosPrinter = ^AsyncOperationCompletedHandler_1__IPosPrinter;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.PointOfService.IPosPrinter>
  IAsyncOperation_1__IPosPrinter = interface;
  PIAsyncOperation_1__IPosPrinter = ^IAsyncOperation_1__IPosPrinter;

  // Windows.Devices.PointOfService.IPosPrinterStatics
  IPosPrinterStatics = interface;
  PIPosPrinterStatics = ^IPosPrinterStatics;

  // Windows.Devices.PointOfService.ICashDrawerStatus
  ICashDrawerStatus = interface;
  PICashDrawerStatus = ^ICashDrawerStatus;

  // Windows.Devices.PointOfService.ICashDrawerStatusUpdatedEventArgs
  ICashDrawerStatusUpdatedEventArgs = interface;
  PICashDrawerStatusUpdatedEventArgs = ^ICashDrawerStatusUpdatedEventArgs;

  // Windows.Devices.PointOfService.ICashDrawerCapabilities
  ICashDrawerCapabilities = interface;
  PICashDrawerCapabilities = ^ICashDrawerCapabilities;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.ICashDrawerEventSource,Windows.Devices.PointOfService.ICashDrawerEventSourceEventArgs>
  TypedEventHandler_2__ICashDrawerEventSource__ICashDrawerEventSourceEventArgs = interface;
  PTypedEventHandler_2__ICashDrawerEventSource__ICashDrawerEventSourceEventArgs = ^TypedEventHandler_2__ICashDrawerEventSource__ICashDrawerEventSourceEventArgs;

  // Windows.Devices.PointOfService.ICashDrawerEventSource
  ICashDrawerEventSource = interface;
  PICashDrawerEventSource = ^ICashDrawerEventSource;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.ICashDrawerCloseAlarm,Object>
  TypedEventHandler_2__ICashDrawerCloseAlarm__IInspectable = interface;
  PTypedEventHandler_2__ICashDrawerCloseAlarm__IInspectable = ^TypedEventHandler_2__ICashDrawerCloseAlarm__IInspectable;

  // Windows.Devices.PointOfService.ICashDrawerCloseAlarm
  ICashDrawerCloseAlarm = interface;
  PICashDrawerCloseAlarm = ^ICashDrawerCloseAlarm;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.IClaimedCashDrawer,Object>
  TypedEventHandler_2__IClaimedCashDrawer__IInspectable = interface;
  PTypedEventHandler_2__IClaimedCashDrawer__IInspectable = ^TypedEventHandler_2__IClaimedCashDrawer__IInspectable;

  // Windows.Devices.PointOfService.IClaimedCashDrawer
  IClaimedCashDrawer = interface;
  PIClaimedCashDrawer = ^IClaimedCashDrawer;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.PointOfService.IClaimedCashDrawer>
  AsyncOperationCompletedHandler_1__IClaimedCashDrawer = interface;
  PAsyncOperationCompletedHandler_1__IClaimedCashDrawer = ^AsyncOperationCompletedHandler_1__IClaimedCashDrawer;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.PointOfService.IClaimedCashDrawer>
  IAsyncOperation_1__IClaimedCashDrawer = interface;
  PIAsyncOperation_1__IClaimedCashDrawer = ^IAsyncOperation_1__IClaimedCashDrawer;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.ICashDrawer,Windows.Devices.PointOfService.ICashDrawerStatusUpdatedEventArgs>
  TypedEventHandler_2__ICashDrawer__ICashDrawerStatusUpdatedEventArgs = interface;
  PTypedEventHandler_2__ICashDrawer__ICashDrawerStatusUpdatedEventArgs = ^TypedEventHandler_2__ICashDrawer__ICashDrawerStatusUpdatedEventArgs;

  // Windows.Devices.PointOfService.ICashDrawer
  ICashDrawer = interface;
  PICashDrawer = ^ICashDrawer;

  // Windows.Devices.PointOfService.ICashDrawerEventSourceEventArgs
  ICashDrawerEventSourceEventArgs = interface;
  PICashDrawerEventSourceEventArgs = ^ICashDrawerEventSourceEventArgs;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.PointOfService.ICashDrawer>
  AsyncOperationCompletedHandler_1__ICashDrawer = interface;
  PAsyncOperationCompletedHandler_1__ICashDrawer = ^AsyncOperationCompletedHandler_1__ICashDrawer;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.PointOfService.ICashDrawer>
  IAsyncOperation_1__ICashDrawer = interface;
  PIAsyncOperation_1__ICashDrawer = ^IAsyncOperation_1__ICashDrawer;

  // Windows.Devices.PointOfService.ICashDrawerStatics
  ICashDrawerStatics = interface;
  PICashDrawerStatics = ^ICashDrawerStatics;


  // Emit Forwarded interfaces
  // Windows.Devices.PointOfService Interfaces
  // DualAPI Interface
  // Windows.Devices.PointOfService.IPosPrinterCharacterSetIdsStatics
  [WinRTClassNameAttribute(SPosPrinterCharacterSetIds)]
  IPosPrinterCharacterSetIdsStatics = interface(IInspectable)
  ['{5C709EFF-709A-4FE7-B215-06A748A38B39}']
    function get_Utf16LE: Cardinal; safecall;
    function get_Ascii: Cardinal; safecall;
    function get_Ansi: Cardinal; safecall;
    property Ansi: Cardinal read get_Ansi;
    property Ascii: Cardinal read get_Ascii;
    property Utf16LE: Cardinal read get_Utf16LE;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.ICommonPosPrintStationCapabilities
  ICommonPosPrintStationCapabilities = interface(IInspectable)
  ['{DE5B52CA-E02E-40E9-9E5E-1B488E6AACFC}']
    function get_IsPrinterPresent: Boolean; safecall;
    function get_IsDualColorSupported: Boolean; safecall;
    function get_ColorCartridgeCapabilities: PosPrinterColorCapabilities; safecall;
    function get_CartridgeSensors: PosPrinterCartridgeSensors; safecall;
    function get_IsBoldSupported: Boolean; safecall;
    function get_IsItalicSupported: Boolean; safecall;
    function get_IsUnderlineSupported: Boolean; safecall;
    function get_IsDoubleHighPrintSupported: Boolean; safecall;
    function get_IsDoubleWidePrintSupported: Boolean; safecall;
    function get_IsDoubleHighDoubleWidePrintSupported: Boolean; safecall;
    function get_IsPaperEmptySensorSupported: Boolean; safecall;
    function get_IsPaperNearEndSensorSupported: Boolean; safecall;
    function get_SupportedCharactersPerLine: IVectorView_1__Cardinal; safecall;
    property CartridgeSensors: PosPrinterCartridgeSensors read get_CartridgeSensors;
    property ColorCartridgeCapabilities: PosPrinterColorCapabilities read get_ColorCartridgeCapabilities;
    property IsBoldSupported: Boolean read get_IsBoldSupported;
    property IsDoubleHighDoubleWidePrintSupported: Boolean read get_IsDoubleHighDoubleWidePrintSupported;
    property IsDoubleHighPrintSupported: Boolean read get_IsDoubleHighPrintSupported;
    property IsDoubleWidePrintSupported: Boolean read get_IsDoubleWidePrintSupported;
    property IsDualColorSupported: Boolean read get_IsDualColorSupported;
    property IsItalicSupported: Boolean read get_IsItalicSupported;
    property IsPaperEmptySensorSupported: Boolean read get_IsPaperEmptySensorSupported;
    property IsPaperNearEndSensorSupported: Boolean read get_IsPaperNearEndSensorSupported;
    property IsPrinterPresent: Boolean read get_IsPrinterPresent;
    property IsUnderlineSupported: Boolean read get_IsUnderlineSupported;
    property SupportedCharactersPerLine: IVectorView_1__Cardinal read get_SupportedCharactersPerLine;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Devices.PointOfService.PosPrinterRotation>
  IIterator_1__PosPrinterRotation = interface(IInspectable)
  ['{752850B9-5ED2-5655-8DE2-262EFC26CF39}']
    function get_Current: PosPrinterRotation; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PPosPrinterRotation): Cardinal; safecall;
    property Current: PosPrinterRotation read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.PointOfService.PosPrinterRotation>
  IIterable_1__PosPrinterRotation_Base = interface(IInspectable)
  ['{1B1E4D8D-15F5-5802-9B23-8B75CE2A58C5}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Devices.PointOfService.PosPrinterRotation>
  IIterable_1__PosPrinterRotation = interface(IIterable_1__PosPrinterRotation_Base)
  ['{1B6614A1-8FC5-567D-9157-410A9E0ECBC5}']
    function First: IIterator_1__PosPrinterRotation; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Devices.PointOfService.PosPrinterRotation>
  IVectorView_1__PosPrinterRotation = interface(IInspectable)
  ['{86D0B56E-CB4E-58F0-B9A2-1528619DCD26}']
    function GetAt(index: Cardinal): PosPrinterRotation; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: PosPrinterRotation; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PPosPrinterRotation): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.ICommonReceiptSlipCapabilities
  ICommonReceiptSlipCapabilities = interface(IInspectable)
  ['{09286B8B-9873-4D05-BFBE-4727A6038F69}']
    function get_IsBarcodeSupported: Boolean; safecall;
    function get_IsBitmapSupported: Boolean; safecall;
    function get_IsLeft90RotationSupported: Boolean; safecall;
    function get_IsRight90RotationSupported: Boolean; safecall;
    function get_Is180RotationSupported: Boolean; safecall;
    function get_IsPrintAreaSupported: Boolean; safecall;
    function get_RuledLineCapabilities: PosPrinterRuledLineCapabilities; safecall;
    function get_SupportedBarcodeRotations: IVectorView_1__PosPrinterRotation; safecall;
    function get_SupportedBitmapRotations: IVectorView_1__PosPrinterRotation; safecall;
    property Is180RotationSupported: Boolean read get_Is180RotationSupported;
    property IsBarcodeSupported: Boolean read get_IsBarcodeSupported;
    property IsBitmapSupported: Boolean read get_IsBitmapSupported;
    property IsLeft90RotationSupported: Boolean read get_IsLeft90RotationSupported;
    property IsPrintAreaSupported: Boolean read get_IsPrintAreaSupported;
    property IsRight90RotationSupported: Boolean read get_IsRight90RotationSupported;
    property RuledLineCapabilities: PosPrinterRuledLineCapabilities read get_RuledLineCapabilities;
    property SupportedBarcodeRotations: IVectorView_1__PosPrinterRotation read get_SupportedBarcodeRotations;
    property SupportedBitmapRotations: IVectorView_1__PosPrinterRotation read get_SupportedBitmapRotations;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.IReceiptPrinterCapabilities
  [WinRTClassNameAttribute(SReceiptPrinterCapabilities)]
  IReceiptPrinterCapabilities = interface(IInspectable)
  ['{B8F0B58F-51A8-43FC-9BD5-8DE272A6415B}']
    function get_CanCutPaper: Boolean; safecall;
    function get_IsStampSupported: Boolean; safecall;
    function get_MarkFeedCapabilities: PosPrinterMarkFeedCapabilities; safecall;
    property CanCutPaper: Boolean read get_CanCutPaper;
    property IsStampSupported: Boolean read get_IsStampSupported;
    property MarkFeedCapabilities: PosPrinterMarkFeedCapabilities read get_MarkFeedCapabilities;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.ISlipPrinterCapabilities
  [WinRTClassNameAttribute(SSlipPrinterCapabilities)]
  ISlipPrinterCapabilities = interface(IInspectable)
  ['{99B16399-488C-4157-8AC2-9F57F708D3DB}']
    function get_IsFullLengthSupported: Boolean; safecall;
    function get_IsBothSidesPrintingSupported: Boolean; safecall;
    property IsBothSidesPrintingSupported: Boolean read get_IsBothSidesPrintingSupported;
    property IsFullLengthSupported: Boolean read get_IsFullLengthSupported;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.IJournalPrinterCapabilities
  [WinRTClassNameAttribute(SJournalPrinterCapabilities)]
  IJournalPrinterCapabilities = interface(IInspectable)
  ['{3B5CCC43-E047-4463-BB58-17B5BA1D8056}']
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.IPosPrinterCapabilities
  [WinRTClassNameAttribute(SPosPrinterCapabilities)]
  IPosPrinterCapabilities = interface(IInspectable)
  ['{CDE95721-4380-4985-ADC5-39DB30CD93BC}']
    function get_PowerReportingType: UnifiedPosPowerReportingType; safecall;
    function get_IsStatisticsReportingSupported: Boolean; safecall;
    function get_IsStatisticsUpdatingSupported: Boolean; safecall;
    function get_DefaultCharacterSet: Cardinal; safecall;
    function get_HasCoverSensor: Boolean; safecall;
    function get_CanMapCharacterSet: Boolean; safecall;
    function get_IsTransactionSupported: Boolean; safecall;
    function get_Receipt: IReceiptPrinterCapabilities; safecall;
    function get_Slip: ISlipPrinterCapabilities; safecall;
    function get_Journal: IJournalPrinterCapabilities; safecall;
    property CanMapCharacterSet: Boolean read get_CanMapCharacterSet;
    property DefaultCharacterSet: Cardinal read get_DefaultCharacterSet;
    property HasCoverSensor: Boolean read get_HasCoverSensor;
    property IsStatisticsReportingSupported: Boolean read get_IsStatisticsReportingSupported;
    property IsStatisticsUpdatingSupported: Boolean read get_IsStatisticsUpdatingSupported;
    property IsTransactionSupported: Boolean read get_IsTransactionSupported;
    property Journal: IJournalPrinterCapabilities read get_Journal;
    property PowerReportingType: UnifiedPosPowerReportingType read get_PowerReportingType;
    property Receipt: IReceiptPrinterCapabilities read get_Receipt;
    property Slip: ISlipPrinterCapabilities read get_Slip;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.IPosPrinterStatus
  [WinRTClassNameAttribute(SPosPrinterStatus)]
  IPosPrinterStatus = interface(IInspectable)
  ['{D1F0C730-DA40-4328-BF76-5156FA33B747}']
    function get_StatusKind: PosPrinterStatusKind; safecall;
    function get_ExtendedStatus: Cardinal; safecall;
    property ExtendedStatus: Cardinal read get_ExtendedStatus;
    property StatusKind: PosPrinterStatusKind read get_StatusKind;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.IPosPrinterStatusUpdatedEventArgs
  [WinRTClassNameAttribute(SPosPrinterStatusUpdatedEventArgs)]
  IPosPrinterStatusUpdatedEventArgs = interface(IInspectable)
  ['{2EDB87DF-13A6-428D-BA81-B0E7C3E5A3CD}']
    function get_Status: IPosPrinterStatus; safecall;
    property Status: IPosPrinterStatus read get_Status;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.IPosPrinterReleaseDeviceRequestedEventArgs
  [WinRTClassNameAttribute(SPosPrinterReleaseDeviceRequestedEventArgs)]
  IPosPrinterReleaseDeviceRequestedEventArgs = interface(IInspectable)
  ['{2BCBA359-1CEF-40B2-9ECB-F927F856AE3C}']
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.ICommonClaimedPosPrinterStation
  ICommonClaimedPosPrinterStation = interface(IInspectable)
  ['{B7EB66A8-FE8A-4CFB-8B42-E35B280CB27C}']
    procedure put_CharactersPerLine(value: Cardinal); safecall;
    function get_CharactersPerLine: Cardinal; safecall;
    procedure put_LineHeight(value: Cardinal); safecall;
    function get_LineHeight: Cardinal; safecall;
    procedure put_LineSpacing(value: Cardinal); safecall;
    function get_LineSpacing: Cardinal; safecall;
    function get_LineWidth: Cardinal; safecall;
    procedure put_IsLetterQuality(value: Boolean); safecall;
    function get_IsLetterQuality: Boolean; safecall;
    function get_IsPaperNearEnd: Boolean; safecall;
    procedure put_ColorCartridge(value: PosPrinterColorCartridge); safecall;
    function get_ColorCartridge: PosPrinterColorCartridge; safecall;
    function get_IsCoverOpen: Boolean; safecall;
    function get_IsCartridgeRemoved: Boolean; safecall;
    function get_IsCartridgeEmpty: Boolean; safecall;
    function get_IsHeadCleaning: Boolean; safecall;
    function get_IsPaperEmpty: Boolean; safecall;
    function get_IsReadyToPrint: Boolean; safecall;
    function ValidateData(data: HSTRING): Boolean; safecall;
    property CharactersPerLine: Cardinal read get_CharactersPerLine write put_CharactersPerLine;
    property ColorCartridge: PosPrinterColorCartridge read get_ColorCartridge write put_ColorCartridge;
    property IsCartridgeEmpty: Boolean read get_IsCartridgeEmpty;
    property IsCartridgeRemoved: Boolean read get_IsCartridgeRemoved;
    property IsCoverOpen: Boolean read get_IsCoverOpen;
    property IsHeadCleaning: Boolean read get_IsHeadCleaning;
    property IsLetterQuality: Boolean read get_IsLetterQuality write put_IsLetterQuality;
    property IsPaperEmpty: Boolean read get_IsPaperEmpty;
    property IsPaperNearEnd: Boolean read get_IsPaperNearEnd;
    property IsReadyToPrint: Boolean read get_IsReadyToPrint;
    property LineHeight: Cardinal read get_LineHeight write put_LineHeight;
    property LineSpacing: Cardinal read get_LineSpacing write put_LineSpacing;
    property LineWidth: Cardinal read get_LineWidth;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.IPosPrinterJob
  [WinRTClassNameAttribute(SJournalPrintJob)]
  IPosPrinterJob = interface(IInspectable)
  ['{9A94005C-0615-4591-A58F-30F87EDFE2E4}']
    procedure Print(data: HSTRING); safecall;
    procedure PrintLine(data: HSTRING); overload; safecall;
    procedure PrintLine; overload; safecall;
    function ExecuteAsync: IAsyncOperation_1__Boolean; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.IReceiptOrSlipJob
  [WinRTClassNameAttribute(SSlipPrintJob)]
  IReceiptOrSlipJob = interface(IInspectable)
  ['{532199BE-C8C3-4DC2-89E9-5C4A37B34DDC}']
    procedure SetBarcodeRotation(value: PosPrinterRotation); safecall;
    procedure SetPrintRotation(value: PosPrinterRotation; includeBitmaps: Boolean); safecall;
    procedure SetPrintArea(value: TRectF); safecall;
    procedure SetBitmap(bitmapNumber: Cardinal; bitmap: Imaging_IBitmapFrame; alignment: PosPrinterAlignment); overload; safecall;
    procedure SetBitmap(bitmapNumber: Cardinal; bitmap: Imaging_IBitmapFrame; alignment: PosPrinterAlignment; width: Cardinal); overload; safecall;
    procedure SetCustomAlignedBitmap(bitmapNumber: Cardinal; bitmap: Imaging_IBitmapFrame; alignmentDistance: Cardinal); overload; safecall;
    procedure SetCustomAlignedBitmap(bitmapNumber: Cardinal; bitmap: Imaging_IBitmapFrame; alignmentDistance: Cardinal; width: Cardinal); overload; safecall;
    procedure PrintSavedBitmap(bitmapNumber: Cardinal); safecall;
    procedure DrawRuledLine(positionList: HSTRING; lineDirection: PosPrinterLineDirection; lineWidth: Cardinal; lineStyle: PosPrinterLineStyle; lineColor: Cardinal); safecall;
    procedure PrintBarcode(data: HSTRING; symbology: Cardinal; height: Cardinal; width: Cardinal; textPosition: PosPrinterBarcodeTextPosition; alignment: PosPrinterAlignment); safecall;
    procedure PrintBarcodeCustomAlign(data: HSTRING; symbology: Cardinal; height: Cardinal; width: Cardinal; textPosition: PosPrinterBarcodeTextPosition; alignmentDistance: Cardinal); safecall;
    procedure PrintBitmap(bitmap: Imaging_IBitmapFrame; alignment: PosPrinterAlignment); overload; safecall;
    procedure PrintBitmap(bitmap: Imaging_IBitmapFrame; alignment: PosPrinterAlignment; width: Cardinal); overload; safecall;
    procedure PrintCustomAlignedBitmap(bitmap: Imaging_IBitmapFrame; alignmentDistance: Cardinal); overload; safecall;
    procedure PrintCustomAlignedBitmap(bitmap: Imaging_IBitmapFrame; alignmentDistance: Cardinal; width: Cardinal); overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.IReceiptPrintJob
  [WinRTClassNameAttribute(SReceiptPrintJob)]
  IReceiptPrintJob = interface(IInspectable)
  ['{AA96066E-ACAD-4B79-9D0F-C0CFC08DC77B}']
    procedure MarkFeed(kind: PosPrinterMarkFeedKind); safecall;
    procedure CutPaper(percentage: Double); overload; safecall;
    procedure CutPaper; overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.IClaimedReceiptPrinter
  [WinRTClassNameAttribute(SClaimedReceiptPrinter)]
  IClaimedReceiptPrinter = interface(IInspectable)
  ['{9AD27A74-DD61-4EE2-9837-5B5D72D538B9}']
    function get_SidewaysMaxLines: Cardinal; safecall;
    function get_SidewaysMaxChars: Cardinal; safecall;
    function get_LinesToPaperCut: Cardinal; safecall;
    function get_PageSize: TSizeF; safecall;
    function get_PrintArea: TRectF; safecall;
    function CreateJob: IReceiptPrintJob; safecall;
    property LinesToPaperCut: Cardinal read get_LinesToPaperCut;
    property PageSize: TSizeF read get_PageSize;
    property PrintArea: TRectF read get_PrintArea;
    property SidewaysMaxChars: Cardinal read get_SidewaysMaxChars;
    property SidewaysMaxLines: Cardinal read get_SidewaysMaxLines;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.IClaimedSlipPrinter
  [WinRTClassNameAttribute(SClaimedSlipPrinter)]
  IClaimedSlipPrinter = interface(IInspectable)
  ['{BD5DEFF2-AF90-4E8A-B77B-E3AE9CA63A7F}']
    function get_SidewaysMaxLines: Cardinal; safecall;
    function get_SidewaysMaxChars: Cardinal; safecall;
    function get_MaxLines: Cardinal; safecall;
    function get_LinesNearEndToEnd: Cardinal; safecall;
    function get_PrintSide: PosPrinterPrintSide; safecall;
    function get_PageSize: TSizeF; safecall;
    function get_PrintArea: TRectF; safecall;
    procedure OpenJaws; safecall;
    procedure CloseJaws; safecall;
    function InsertSlipAsync(timeout: TimeSpan): IAsyncOperation_1__Boolean; safecall;
    function RemoveSlipAsync(timeout: TimeSpan): IAsyncOperation_1__Boolean; safecall;
    procedure ChangePrintSide(printSide: PosPrinterPrintSide); safecall;
    function CreateJob: IReceiptOrSlipJob; safecall;
    property LinesNearEndToEnd: Cardinal read get_LinesNearEndToEnd;
    property MaxLines: Cardinal read get_MaxLines;
    property PageSize: TSizeF read get_PageSize;
    property PrintArea: TRectF read get_PrintArea;
    property PrintSide: PosPrinterPrintSide read get_PrintSide;
    property SidewaysMaxChars: Cardinal read get_SidewaysMaxChars;
    property SidewaysMaxLines: Cardinal read get_SidewaysMaxLines;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.IClaimedJournalPrinter
  [WinRTClassNameAttribute(SClaimedJournalPrinter)]
  IClaimedJournalPrinter = interface(IInspectable)
  ['{67EA0630-517D-487F-9FDF-D2E0A0A264A5}']
    function CreateJob: IPosPrinterJob; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.IClaimedPosPrinter,Windows.Devices.PointOfService.IPosPrinterReleaseDeviceRequestedEventArgs>
  TypedEventHandler_2__IClaimedPosPrinter__IPosPrinterReleaseDeviceRequestedEventArgs_Delegate_Base = interface(IUnknown)
  ['{31424F6F-CFEB-5031-8A95-BEA59B09E584}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.IClaimedPosPrinter,Windows.Devices.PointOfService.IPosPrinterReleaseDeviceRequestedEventArgs>
  TypedEventHandler_2__IClaimedPosPrinter__IPosPrinterReleaseDeviceRequestedEventArgs = interface(TypedEventHandler_2__IClaimedPosPrinter__IPosPrinterReleaseDeviceRequestedEventArgs_Delegate_Base)
  ['{2651A22A-9DCF-598E-B807-BE46B471C78C}']
    procedure Invoke(sender: IClaimedPosPrinter; args: IPosPrinterReleaseDeviceRequestedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.IClaimedPosPrinter
  [WinRTClassNameAttribute(SClaimedPosPrinter)]
  IClaimedPosPrinter = interface(IInspectable)
  ['{6D64CE0C-E03E-4B14-A38E-C28C34B86353}']
    function get_DeviceId: HSTRING; safecall;
    function get_IsEnabled: Boolean; safecall;
    procedure put_CharacterSet(value: Cardinal); safecall;
    function get_CharacterSet: Cardinal; safecall;
    function get_IsCoverOpen: Boolean; safecall;
    procedure put_IsCharacterSetMappingEnabled(value: Boolean); safecall;
    function get_IsCharacterSetMappingEnabled: Boolean; safecall;
    procedure put_MapMode(value: PosPrinterMapMode); safecall;
    function get_MapMode: PosPrinterMapMode; safecall;
    function get_Receipt: IClaimedReceiptPrinter; safecall;
    function get_Slip: IClaimedSlipPrinter; safecall;
    function get_Journal: IClaimedJournalPrinter; safecall;
    function EnableAsync: IAsyncOperation_1__Boolean; safecall;
    function DisableAsync: IAsyncOperation_1__Boolean; safecall;
    function RetainDeviceAsync: IAsyncOperation_1__Boolean; safecall;
    function ResetStatisticsAsync(statisticsCategories: IIterable_1__HSTRING): IAsyncOperation_1__Boolean; safecall;
    function UpdateStatisticsAsync(statistics: IIterable_1__IKeyValuePair_2__HSTRING__HSTRING): IAsyncOperation_1__Boolean; safecall;
    function add_ReleaseDeviceRequested(handler: TypedEventHandler_2__IClaimedPosPrinter__IPosPrinterReleaseDeviceRequestedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ReleaseDeviceRequested(token: EventRegistrationToken); safecall;
    property CharacterSet: Cardinal read get_CharacterSet write put_CharacterSet;
    property DeviceId: HSTRING read get_DeviceId;
    property IsCharacterSetMappingEnabled: Boolean read get_IsCharacterSetMappingEnabled write put_IsCharacterSetMappingEnabled;
    property IsCoverOpen: Boolean read get_IsCoverOpen;
    property IsEnabled: Boolean read get_IsEnabled;
    property Journal: IClaimedJournalPrinter read get_Journal;
    property MapMode: PosPrinterMapMode read get_MapMode write put_MapMode;
    property Receipt: IClaimedReceiptPrinter read get_Receipt;
    property Slip: IClaimedSlipPrinter read get_Slip;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.PointOfService.IClaimedPosPrinter>
  AsyncOperationCompletedHandler_1__IClaimedPosPrinter_Delegate_Base = interface(IUnknown)
  ['{01EB0DC3-3C30-5EEA-9FCE-EFB398E0BE34}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.PointOfService.IClaimedPosPrinter>
  AsyncOperationCompletedHandler_1__IClaimedPosPrinter = interface(AsyncOperationCompletedHandler_1__IClaimedPosPrinter_Delegate_Base)
  ['{DCC034BC-9B93-5E70-B7F3-5E11F87E91C7}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IClaimedPosPrinter; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.PointOfService.IClaimedPosPrinter>
  IAsyncOperation_1__IClaimedPosPrinter_Base = interface(IInspectable)
  ['{B4476F95-355A-503D-B844-1756C8CFDA98}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.PointOfService.IClaimedPosPrinter>
  IAsyncOperation_1__IClaimedPosPrinter = interface(IAsyncOperation_1__IClaimedPosPrinter_Base)
  ['{2A715D99-81DD-5476-AC64-BD33873E6B59}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IClaimedPosPrinter); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IClaimedPosPrinter; safecall;
    function GetResults: IClaimedPosPrinter; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IClaimedPosPrinter read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.IPosPrinter,Windows.Devices.PointOfService.IPosPrinterStatusUpdatedEventArgs>
  TypedEventHandler_2__IPosPrinter__IPosPrinterStatusUpdatedEventArgs_Delegate_Base = interface(IUnknown)
  ['{20B0C66A-5F41-5A32-B45A-344F12E70A34}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.IPosPrinter,Windows.Devices.PointOfService.IPosPrinterStatusUpdatedEventArgs>
  TypedEventHandler_2__IPosPrinter__IPosPrinterStatusUpdatedEventArgs = interface(TypedEventHandler_2__IPosPrinter__IPosPrinterStatusUpdatedEventArgs_Delegate_Base)
  ['{B8F0D464-440B-5A73-A838-BCF474C8C9B2}']
    procedure Invoke(sender: IPosPrinter; args: IPosPrinterStatusUpdatedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.IPosPrinter
  [WinRTClassNameAttribute(SPosPrinter)]
  IPosPrinter = interface(IInspectable)
  ['{2A03C10E-9A19-4A01-994F-12DFAD6ADCBF}']
    function get_DeviceId: HSTRING; safecall;
    function get_Capabilities: IPosPrinterCapabilities; safecall;
    function get_SupportedCharacterSets: IVectorView_1__Cardinal; safecall;
    function get_SupportedTypeFaces: IVectorView_1__HSTRING; safecall;
    function get_Status: IPosPrinterStatus; safecall;
    function ClaimPrinterAsync: IAsyncOperation_1__IClaimedPosPrinter; safecall;
    function CheckHealthAsync(level: UnifiedPosHealthCheckLevel): IAsyncOperation_1__HSTRING; safecall;
    function GetStatisticsAsync(statisticsCategories: IIterable_1__HSTRING): IAsyncOperation_1__HSTRING; safecall;
    function add_StatusUpdated(handler: TypedEventHandler_2__IPosPrinter__IPosPrinterStatusUpdatedEventArgs): EventRegistrationToken; safecall;
    procedure remove_StatusUpdated(token: EventRegistrationToken); safecall;
    property Capabilities: IPosPrinterCapabilities read get_Capabilities;
    property DeviceId: HSTRING read get_DeviceId;
    property Status: IPosPrinterStatus read get_Status;
    property SupportedCharacterSets: IVectorView_1__Cardinal read get_SupportedCharacterSets;
    property SupportedTypeFaces: IVectorView_1__HSTRING read get_SupportedTypeFaces;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.PointOfService.IPosPrinter>
  AsyncOperationCompletedHandler_1__IPosPrinter_Delegate_Base = interface(IUnknown)
  ['{5E8DBBC8-8B60-5881-8B6E-F699B4949DBA}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.PointOfService.IPosPrinter>
  AsyncOperationCompletedHandler_1__IPosPrinter = interface(AsyncOperationCompletedHandler_1__IPosPrinter_Delegate_Base)
  ['{4DE49EF9-FF09-5C67-85BE-85D97904662B}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IPosPrinter; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.PointOfService.IPosPrinter>
  IAsyncOperation_1__IPosPrinter_Base = interface(IInspectable)
  ['{024F77CE-51C3-5AFC-9F30-24B3C0F3B25A}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.PointOfService.IPosPrinter>
  IAsyncOperation_1__IPosPrinter = interface(IAsyncOperation_1__IPosPrinter_Base)
  ['{57F34381-BA47-5A19-B7FE-8E940C7C0FCB}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IPosPrinter); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IPosPrinter; safecall;
    function GetResults: IPosPrinter; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IPosPrinter read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.IPosPrinterStatics
  [WinRTClassNameAttribute(SPosPrinter)]
  IPosPrinterStatics = interface(IInspectable)
  ['{8CE0D4EA-132F-4CDF-A64A-2D0D7C96A85B}']
    function GetDefaultAsync: IAsyncOperation_1__IPosPrinter; safecall;
    function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IPosPrinter; safecall;
    function GetDeviceSelector: HSTRING; safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.ICashDrawerStatus
  [WinRTClassNameAttribute(SCashDrawerStatus)]
  ICashDrawerStatus = interface(IInspectable)
  ['{6BBD78BF-DCA1-4E06-99EB-5AF6A5AEC108}']
    function get_StatusKind: CashDrawerStatusKind; safecall;
    function get_ExtendedStatus: Cardinal; safecall;
    property ExtendedStatus: Cardinal read get_ExtendedStatus;
    property StatusKind: CashDrawerStatusKind read get_StatusKind;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.ICashDrawerStatusUpdatedEventArgs
  [WinRTClassNameAttribute(SCashDrawerStatusUpdatedEventArgs)]
  ICashDrawerStatusUpdatedEventArgs = interface(IInspectable)
  ['{30AAE98A-0D70-459C-9553-87E124C52488}']
    function get_Status: ICashDrawerStatus; safecall;
    property Status: ICashDrawerStatus read get_Status;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.ICashDrawerCapabilities
  [WinRTClassNameAttribute(SCashDrawerCapabilities)]
  ICashDrawerCapabilities = interface(IInspectable)
  ['{0BC6DE0B-E8E7-4B1F-B1D1-3E501AD08247}']
    function get_PowerReportingType: UnifiedPosPowerReportingType; safecall;
    function get_IsStatisticsReportingSupported: Boolean; safecall;
    function get_IsStatisticsUpdatingSupported: Boolean; safecall;
    function get_IsStatusReportingSupported: Boolean; safecall;
    function get_IsStatusMultiDrawerDetectSupported: Boolean; safecall;
    function get_IsDrawerOpenSensorAvailable: Boolean; safecall;
    property IsDrawerOpenSensorAvailable: Boolean read get_IsDrawerOpenSensorAvailable;
    property IsStatisticsReportingSupported: Boolean read get_IsStatisticsReportingSupported;
    property IsStatisticsUpdatingSupported: Boolean read get_IsStatisticsUpdatingSupported;
    property IsStatusMultiDrawerDetectSupported: Boolean read get_IsStatusMultiDrawerDetectSupported;
    property IsStatusReportingSupported: Boolean read get_IsStatusReportingSupported;
    property PowerReportingType: UnifiedPosPowerReportingType read get_PowerReportingType;
  end;

  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.ICashDrawerEventSource,Windows.Devices.PointOfService.ICashDrawerEventSourceEventArgs>
  TypedEventHandler_2__ICashDrawerEventSource__ICashDrawerEventSourceEventArgs = interface(IUnknown)
  ['{D1995B24-A22E-5BB0-8C77-00AE74F2AB29}']
    procedure Invoke(sender: ICashDrawerEventSource; args: ICashDrawerEventSourceEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.ICashDrawerEventSource
  [WinRTClassNameAttribute(SCashDrawerEventSource)]
  ICashDrawerEventSource = interface(IInspectable)
  ['{E006E46C-F2F9-442F-8DD6-06C10A4227BA}']
    function add_DrawerClosed(handler: TypedEventHandler_2__ICashDrawerEventSource__ICashDrawerEventSourceEventArgs): EventRegistrationToken; safecall;
    procedure remove_DrawerClosed(token: EventRegistrationToken); safecall;
    function add_DrawerOpened(handler: TypedEventHandler_2__ICashDrawerEventSource__ICashDrawerEventSourceEventArgs): EventRegistrationToken; safecall;
    procedure remove_DrawerOpened(token: EventRegistrationToken); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.ICashDrawerCloseAlarm,Object>
  TypedEventHandler_2__ICashDrawerCloseAlarm__IInspectable_Delegate_Base = interface(IUnknown)
  ['{C54FBDA4-5E0B-54C3-94F2-83351E41C46F}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.ICashDrawerCloseAlarm,Object>
  TypedEventHandler_2__ICashDrawerCloseAlarm__IInspectable = interface(TypedEventHandler_2__ICashDrawerCloseAlarm__IInspectable_Delegate_Base)
  ['{5D7EA46E-5DE1-5491-98E1-E554C6EDE1EC}']
    procedure Invoke(sender: ICashDrawerCloseAlarm; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.ICashDrawerCloseAlarm
  [WinRTClassNameAttribute(SCashDrawerCloseAlarm)]
  ICashDrawerCloseAlarm = interface(IInspectable)
  ['{6BF88CC7-6F63-430E-AB3B-95D75FFBE87F}']
    procedure put_AlarmTimeout(value: TimeSpan); safecall;
    function get_AlarmTimeout: TimeSpan; safecall;
    procedure put_BeepFrequency(value: Cardinal); safecall;
    function get_BeepFrequency: Cardinal; safecall;
    procedure put_BeepDuration(value: TimeSpan); safecall;
    function get_BeepDuration: TimeSpan; safecall;
    procedure put_BeepDelay(value: TimeSpan); safecall;
    function get_BeepDelay: TimeSpan; safecall;
    function add_AlarmTimeoutExpired(handler: TypedEventHandler_2__ICashDrawerCloseAlarm__IInspectable): EventRegistrationToken; safecall;
    procedure remove_AlarmTimeoutExpired(token: EventRegistrationToken); safecall;
    function StartAsync: IAsyncOperation_1__Boolean; safecall;
    property AlarmTimeout: TimeSpan read get_AlarmTimeout write put_AlarmTimeout;
    property BeepDelay: TimeSpan read get_BeepDelay write put_BeepDelay;
    property BeepDuration: TimeSpan read get_BeepDuration write put_BeepDuration;
    property BeepFrequency: Cardinal read get_BeepFrequency write put_BeepFrequency;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.IClaimedCashDrawer,Object>
  TypedEventHandler_2__IClaimedCashDrawer__IInspectable_Delegate_Base = interface(IUnknown)
  ['{DB886581-2462-5C81-880C-06112CA70012}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.IClaimedCashDrawer,Object>
  TypedEventHandler_2__IClaimedCashDrawer__IInspectable = interface(TypedEventHandler_2__IClaimedCashDrawer__IInspectable_Delegate_Base)
  ['{A39ABF81-03ED-5140-831E-33396C6B2E7C}']
    procedure Invoke(sender: IClaimedCashDrawer; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.IClaimedCashDrawer
  [WinRTClassNameAttribute(SClaimedCashDrawer)]
  IClaimedCashDrawer = interface(IInspectable)
  ['{CA3F99AF-ABB8-42C1-8A84-5C66512F5A75}']
    function get_DeviceId: HSTRING; safecall;
    function get_IsEnabled: Boolean; safecall;
    function get_IsDrawerOpen: Boolean; safecall;
    function get_CloseAlarm: ICashDrawerCloseAlarm; safecall;
    function OpenDrawerAsync: IAsyncOperation_1__Boolean; safecall;
    function EnableAsync: IAsyncOperation_1__Boolean; safecall;
    function DisableAsync: IAsyncOperation_1__Boolean; safecall;
    function RetainDeviceAsync: IAsyncOperation_1__Boolean; safecall;
    function ResetStatisticsAsync(statisticsCategories: IIterable_1__HSTRING): IAsyncOperation_1__Boolean; safecall;
    function UpdateStatisticsAsync(statistics: IIterable_1__IKeyValuePair_2__HSTRING__HSTRING): IAsyncOperation_1__Boolean; safecall;
    function add_ReleaseDeviceRequested(handler: TypedEventHandler_2__IClaimedCashDrawer__IInspectable): EventRegistrationToken; safecall;
    procedure remove_ReleaseDeviceRequested(token: EventRegistrationToken); safecall;
    property CloseAlarm: ICashDrawerCloseAlarm read get_CloseAlarm;
    property DeviceId: HSTRING read get_DeviceId;
    property IsDrawerOpen: Boolean read get_IsDrawerOpen;
    property IsEnabled: Boolean read get_IsEnabled;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.PointOfService.IClaimedCashDrawer>
  AsyncOperationCompletedHandler_1__IClaimedCashDrawer_Delegate_Base = interface(IUnknown)
  ['{E68C3736-FDE7-5CFB-B22F-92119723E729}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.PointOfService.IClaimedCashDrawer>
  AsyncOperationCompletedHandler_1__IClaimedCashDrawer = interface(AsyncOperationCompletedHandler_1__IClaimedCashDrawer_Delegate_Base)
  ['{E8192C0D-7D61-53CB-AC73-B8619B1C0121}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IClaimedCashDrawer; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.PointOfService.IClaimedCashDrawer>
  IAsyncOperation_1__IClaimedCashDrawer_Base = interface(IInspectable)
  ['{9230E7AA-20A0-5752-9C20-4BF44934A87E}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.PointOfService.IClaimedCashDrawer>
  IAsyncOperation_1__IClaimedCashDrawer = interface(IAsyncOperation_1__IClaimedCashDrawer_Base)
  ['{DD547670-8167-5132-B38F-2B2590B3D847}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IClaimedCashDrawer); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IClaimedCashDrawer; safecall;
    function GetResults: IClaimedCashDrawer; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IClaimedCashDrawer read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.ICashDrawer,Windows.Devices.PointOfService.ICashDrawerStatusUpdatedEventArgs>
  TypedEventHandler_2__ICashDrawer__ICashDrawerStatusUpdatedEventArgs_Delegate_Base = interface(IUnknown)
  ['{64662EF4-CB0E-5C6F-A820-7D0A769554C9}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Devices.PointOfService.ICashDrawer,Windows.Devices.PointOfService.ICashDrawerStatusUpdatedEventArgs>
  TypedEventHandler_2__ICashDrawer__ICashDrawerStatusUpdatedEventArgs = interface(TypedEventHandler_2__ICashDrawer__ICashDrawerStatusUpdatedEventArgs_Delegate_Base)
  ['{518BE39A-2654-5D10-8426-B50C2B52B087}']
    procedure Invoke(sender: ICashDrawer; args: ICashDrawerStatusUpdatedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.ICashDrawer
  [WinRTClassNameAttribute(SCashDrawer)]
  ICashDrawer = interface(IInspectable)
  ['{9F88F5C8-DE54-4AEE-A890-920BCBFE30FC}']
    function get_DeviceId: HSTRING; safecall;
    function get_Capabilities: ICashDrawerCapabilities; safecall;
    function get_Status: ICashDrawerStatus; safecall;
    function get_IsDrawerOpen: Boolean; safecall;
    function get_DrawerEventSource: ICashDrawerEventSource; safecall;
    function ClaimDrawerAsync: IAsyncOperation_1__IClaimedCashDrawer; safecall;
    function CheckHealthAsync(level: UnifiedPosHealthCheckLevel): IAsyncOperation_1__HSTRING; safecall;
    function GetStatisticsAsync(statisticsCategories: IIterable_1__HSTRING): IAsyncOperation_1__HSTRING; safecall;
    function add_StatusUpdated(handler: TypedEventHandler_2__ICashDrawer__ICashDrawerStatusUpdatedEventArgs): EventRegistrationToken; safecall;
    procedure remove_StatusUpdated(token: EventRegistrationToken); safecall;
    property Capabilities: ICashDrawerCapabilities read get_Capabilities;
    property DeviceId: HSTRING read get_DeviceId;
    property DrawerEventSource: ICashDrawerEventSource read get_DrawerEventSource;
    property IsDrawerOpen: Boolean read get_IsDrawerOpen;
    property Status: ICashDrawerStatus read get_Status;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.ICashDrawerEventSourceEventArgs
  [WinRTClassNameAttribute(SCashDrawerOpenedEventArgs)]
  ICashDrawerEventSourceEventArgs = interface(IInspectable)
  ['{69CB3BC1-147F-421C-9C23-090123BB786C}']
    function get_CashDrawer: ICashDrawer; safecall;
    property CashDrawer: ICashDrawer read get_CashDrawer;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.PointOfService.ICashDrawer>
  AsyncOperationCompletedHandler_1__ICashDrawer_Delegate_Base = interface(IUnknown)
  ['{57836710-F186-5636-891D-F8C5398EA6DF}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.PointOfService.ICashDrawer>
  AsyncOperationCompletedHandler_1__ICashDrawer = interface(AsyncOperationCompletedHandler_1__ICashDrawer_Delegate_Base)
  ['{2B5A22BA-CB98-5A1C-BED6-09440AC4C5D9}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__ICashDrawer; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.PointOfService.ICashDrawer>
  IAsyncOperation_1__ICashDrawer_Base = interface(IInspectable)
  ['{45007467-92F2-5BFF-B191-AA5000FEDD9E}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.PointOfService.ICashDrawer>
  IAsyncOperation_1__ICashDrawer = interface(IAsyncOperation_1__ICashDrawer_Base)
  ['{F0126938-62B0-590E-AE08-DA21554EAD22}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__ICashDrawer); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__ICashDrawer; safecall;
    function GetResults: ICashDrawer; safecall;
    property Completed: AsyncOperationCompletedHandler_1__ICashDrawer read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.PointOfService.ICashDrawerStatics
  [WinRTClassNameAttribute(SCashDrawer)]
  ICashDrawerStatics = interface(IInspectable)
  ['{DFA0955A-D437-4FFF-B547-DDA969A4F883}']
    function GetDefaultAsync: IAsyncOperation_1__ICashDrawer; safecall;
    function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__ICashDrawer; safecall;
    function GetDeviceSelector: HSTRING; safecall;
  end;


  // Emit Forwarded classes
  // Windows.Devices.PointOfService.PosPrinterCharacterSetIds
  // DualAPI
  TPosPrinterCharacterSetIds = class(TWinRTGenericImportS<IPosPrinterCharacterSetIdsStatics>)
  public
    // -> IPosPrinterCharacterSetIdsStatics
    class function get_Utf16LE: Cardinal; static; inline;
    class function get_Ascii: Cardinal; static; inline;
    class function get_Ansi: Cardinal; static; inline;
    class property Ansi: Cardinal read get_Ansi;
    class property Ascii: Cardinal read get_Ascii;
    class property Utf16LE: Cardinal read get_Utf16LE;
  end;

  // Windows.Devices.PointOfService.ReceiptPrinterCapabilities
  // DualAPI

  // Windows.Devices.PointOfService.SlipPrinterCapabilities
  // DualAPI

  // Windows.Devices.PointOfService.JournalPrinterCapabilities
  // DualAPI

  // Windows.Devices.PointOfService.PosPrinterCapabilities
  // DualAPI

  // Windows.Devices.PointOfService.PosPrinterStatus
  // DualAPI

  // Windows.Devices.PointOfService.PosPrinterStatusUpdatedEventArgs
  // DualAPI

  // Windows.Devices.PointOfService.PosPrinterReleaseDeviceRequestedEventArgs
  // DualAPI

  // Windows.Devices.PointOfService.PosPrinter
  // DualAPI
  TPosPrinter = class(TWinRTGenericImportS<IPosPrinterStatics>)
  public
    // -> IPosPrinterStatics
    class function GetDefaultAsync: IAsyncOperation_1__IPosPrinter; static; inline;
    class function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IPosPrinter; static; inline;
    class function GetDeviceSelector: HSTRING; static; inline;
  end;

  // Windows.Devices.PointOfService.ClaimedPosPrinter
  // DualAPI

  // Windows.Devices.PointOfService.ReceiptPrintJob
  // DualAPI

  // Windows.Devices.PointOfService.SlipPrintJob
  // DualAPI

  // Windows.Devices.PointOfService.JournalPrintJob
  // DualAPI

  // Windows.Devices.PointOfService.ClaimedReceiptPrinter
  // DualAPI

  // Windows.Devices.PointOfService.ClaimedSlipPrinter
  // DualAPI

  // Windows.Devices.PointOfService.ClaimedJournalPrinter
  // DualAPI

  // Windows.Devices.PointOfService.CashDrawerStatus
  // DualAPI

  // Windows.Devices.PointOfService.CashDrawerStatusUpdatedEventArgs
  // DualAPI

  // Windows.Devices.PointOfService.CashDrawerCapabilities
  // DualAPI

  // Windows.Devices.PointOfService.CashDrawer
  // DualAPI
  TCashDrawer = class(TWinRTGenericImportS<ICashDrawerStatics>)
  public
    // -> ICashDrawerStatics
    class function GetDefaultAsync: IAsyncOperation_1__ICashDrawer; static; inline;
    class function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__ICashDrawer; static; inline;
    class function GetDeviceSelector: HSTRING; static; inline;
  end;

  // Windows.Devices.PointOfService.CashDrawerClosedEventArgs
  // DualAPI

  // Windows.Devices.PointOfService.CashDrawerOpenedEventArgs
  // DualAPI

  // Windows.Devices.PointOfService.CashDrawerEventSource
  // DualAPI

  // Windows.Devices.PointOfService.ClaimedCashDrawer
  // DualAPI

  // Windows.Devices.PointOfService.CashDrawerCloseAlarm
  // DualAPI


implementation

  // Emit Classes Implementation
 { TPosPrinterCharacterSetIds }

class function TPosPrinterCharacterSetIds.get_Utf16LE: Cardinal;
begin
  Result := Statics.get_Utf16LE;
end;

class function TPosPrinterCharacterSetIds.get_Ascii: Cardinal;
begin
  Result := Statics.get_Ascii;
end;

class function TPosPrinterCharacterSetIds.get_Ansi: Cardinal;
begin
  Result := Statics.get_Ansi;
end;


 { TPosPrinter }

class function TPosPrinter.GetDefaultAsync: IAsyncOperation_1__IPosPrinter;
begin
  Result := Statics.GetDefaultAsync;
end;

class function TPosPrinter.FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IPosPrinter;
begin
  Result := Statics.FromIdAsync(deviceId);
end;

class function TPosPrinter.GetDeviceSelector: HSTRING;
begin
  Result := Statics.GetDeviceSelector;
end;


 { TCashDrawer }

class function TCashDrawer.GetDefaultAsync: IAsyncOperation_1__ICashDrawer;
begin
  Result := Statics.GetDefaultAsync;
end;

class function TCashDrawer.FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__ICashDrawer;
begin
  Result := Statics.FromIdAsync(deviceId);
end;

class function TCashDrawer.GetDeviceSelector: HSTRING;
begin
  Result := Statics.GetDeviceSelector;
end;



end.
