{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Devices.Scanners;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  // Internal Uses...
  Winapi.Storage,
  Winapi.Foundation,
  Winapi.Storage.Streams,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Devices.Scanners Class Names
  // Windows.Devices.Scanners.ImageScannerAutoConfiguration
  // DualAPI
  SImageScannerAutoConfiguration = 'Windows.Devices.Scanners.ImageScannerAutoConfiguration';
  // Windows.Devices.Scanners.ImageScannerFlatbedConfiguration
  // DualAPI
  SImageScannerFlatbedConfiguration = 'Windows.Devices.Scanners.ImageScannerFlatbedConfiguration';
  // Windows.Devices.Scanners.ImageScannerFeederConfiguration
  // DualAPI
  SImageScannerFeederConfiguration = 'Windows.Devices.Scanners.ImageScannerFeederConfiguration';
  // Windows.Devices.Scanners.ImageScannerScanResult
  // DualAPI
  SImageScannerScanResult = 'Windows.Devices.Scanners.ImageScannerScanResult';
  // Windows.Devices.Scanners.ImageScannerPreviewResult
  // DualAPI
  SImageScannerPreviewResult = 'Windows.Devices.Scanners.ImageScannerPreviewResult';
  // Windows.Devices.Scanners.ImageScanner
  // DualAPI
  SImageScanner = 'Windows.Devices.Scanners.ImageScanner';


type
  // Forward declare interfaces
  // Windows.Devices.Scanners.IImageScannerFormatConfiguration
  IImageScannerFormatConfiguration = interface;
  PIImageScannerFormatConfiguration = ^IImageScannerFormatConfiguration;

  // Windows.Devices.Scanners.IImageScannerSourceConfiguration
  IImageScannerSourceConfiguration = interface;
  PIImageScannerSourceConfiguration = ^IImageScannerSourceConfiguration;

  // Windows.Devices.Scanners.IImageScannerFeederConfiguration
  IImageScannerFeederConfiguration = interface;
  PIImageScannerFeederConfiguration = ^IImageScannerFeederConfiguration;

  // Windows.Devices.Scanners.IImageScannerScanResult
  IImageScannerScanResult = interface;
  PIImageScannerScanResult = ^IImageScannerScanResult;

  // Windows.Devices.Scanners.IImageScannerPreviewResult
  IImageScannerPreviewResult = interface;
  PIImageScannerPreviewResult = ^IImageScannerPreviewResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Scanners.IImageScannerPreviewResult>
  AsyncOperationCompletedHandler_1__IImageScannerPreviewResult = interface;
  PAsyncOperationCompletedHandler_1__IImageScannerPreviewResult = ^AsyncOperationCompletedHandler_1__IImageScannerPreviewResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Scanners.IImageScannerPreviewResult>
  IAsyncOperation_1__IImageScannerPreviewResult = interface;
  PIAsyncOperation_1__IImageScannerPreviewResult = ^IAsyncOperation_1__IImageScannerPreviewResult;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Devices.Scanners.IImageScannerScanResult,UInt32>
  AsyncOperationProgressHandler_2__IImageScannerScanResult__Cardinal = interface;
  PAsyncOperationProgressHandler_2__IImageScannerScanResult__Cardinal = ^AsyncOperationProgressHandler_2__IImageScannerScanResult__Cardinal;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Devices.Scanners.IImageScannerScanResult,UInt32>
  AsyncOperationWithProgressCompletedHandler_2__IImageScannerScanResult__Cardinal = interface;
  PAsyncOperationWithProgressCompletedHandler_2__IImageScannerScanResult__Cardinal = ^AsyncOperationWithProgressCompletedHandler_2__IImageScannerScanResult__Cardinal;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Devices.Scanners.IImageScannerScanResult,UInt32>
  IAsyncOperationWithProgress_2__IImageScannerScanResult__Cardinal = interface;
  PIAsyncOperationWithProgress_2__IImageScannerScanResult__Cardinal = ^IAsyncOperationWithProgress_2__IImageScannerScanResult__Cardinal;

  // Windows.Devices.Scanners.IImageScanner
  IImageScanner = interface;
  PIImageScanner = ^IImageScanner;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Scanners.IImageScanner>
  AsyncOperationCompletedHandler_1__IImageScanner = interface;
  PAsyncOperationCompletedHandler_1__IImageScanner = ^AsyncOperationCompletedHandler_1__IImageScanner;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Scanners.IImageScanner>
  IAsyncOperation_1__IImageScanner = interface;
  PIAsyncOperation_1__IImageScanner = ^IAsyncOperation_1__IImageScanner;

  // Windows.Devices.Scanners.IImageScannerStatics
  IImageScannerStatics = interface;
  PIImageScannerStatics = ^IImageScannerStatics;


  // Emit Forwarded interfaces
  // Windows.Devices.Scanners Interfaces
  // DualAPI Interface
  // Windows.Devices.Scanners.IImageScannerFormatConfiguration
  [WinRTClassNameAttribute(SImageScannerFlatbedConfiguration)]
  IImageScannerFormatConfiguration = interface(IInspectable)
  ['{AE275D11-DADF-4010-BF10-CCA5C83DCBB0}']
    function get_DefaultFormat: ImageScannerFormat; safecall;
    function get_Format: ImageScannerFormat; safecall;
    procedure put_Format(value: ImageScannerFormat); safecall;
    function IsFormatSupported(value: ImageScannerFormat): Boolean; safecall;
    property DefaultFormat: ImageScannerFormat read get_DefaultFormat;
    property Format: ImageScannerFormat read get_Format write put_Format;
  end;

  // DualAPI Interface
  // Windows.Devices.Scanners.IImageScannerSourceConfiguration
  IImageScannerSourceConfiguration = interface(IInspectable)
  ['{BFB50055-0B44-4C82-9E89-205F9C234E59}']
    function get_MinScanArea: TSizeF; safecall;
    function get_MaxScanArea: TSizeF; safecall;
    function get_SelectedScanRegion: TRectF; safecall;
    procedure put_SelectedScanRegion(value: TRectF); safecall;
    function get_AutoCroppingMode: ImageScannerAutoCroppingMode; safecall;
    procedure put_AutoCroppingMode(value: ImageScannerAutoCroppingMode); safecall;
    function IsAutoCroppingModeSupported(value: ImageScannerAutoCroppingMode): Boolean; safecall;
    function get_MinResolution: ImageScannerResolution; safecall;
    function get_MaxResolution: ImageScannerResolution; safecall;
    function get_OpticalResolution: ImageScannerResolution; safecall;
    function get_DesiredResolution: ImageScannerResolution; safecall;
    procedure put_DesiredResolution(value: ImageScannerResolution); safecall;
    function get_ActualResolution: ImageScannerResolution; safecall;
    function get_DefaultColorMode: ImageScannerColorMode; safecall;
    function get_ColorMode: ImageScannerColorMode; safecall;
    procedure put_ColorMode(value: ImageScannerColorMode); safecall;
    function IsColorModeSupported(value: ImageScannerColorMode): Boolean; safecall;
    function get_MinBrightness: Integer; safecall;
    function get_MaxBrightness: Integer; safecall;
    function get_BrightnessStep: Cardinal; safecall;
    function get_DefaultBrightness: Integer; safecall;
    function get_Brightness: Integer; safecall;
    procedure put_Brightness(value: Integer); safecall;
    function get_MinContrast: Integer; safecall;
    function get_MaxContrast: Integer; safecall;
    function get_ContrastStep: Cardinal; safecall;
    function get_DefaultContrast: Integer; safecall;
    function get_Contrast: Integer; safecall;
    procedure put_Contrast(value: Integer); safecall;
    property ActualResolution: ImageScannerResolution read get_ActualResolution;
    property AutoCroppingMode: ImageScannerAutoCroppingMode read get_AutoCroppingMode write put_AutoCroppingMode;
    property Brightness: Integer read get_Brightness write put_Brightness;
    property BrightnessStep: Cardinal read get_BrightnessStep;
    property ColorMode: ImageScannerColorMode read get_ColorMode write put_ColorMode;
    property Contrast: Integer read get_Contrast write put_Contrast;
    property ContrastStep: Cardinal read get_ContrastStep;
    property DefaultBrightness: Integer read get_DefaultBrightness;
    property DefaultColorMode: ImageScannerColorMode read get_DefaultColorMode;
    property DefaultContrast: Integer read get_DefaultContrast;
    property DesiredResolution: ImageScannerResolution read get_DesiredResolution write put_DesiredResolution;
    property MaxBrightness: Integer read get_MaxBrightness;
    property MaxContrast: Integer read get_MaxContrast;
    property MaxResolution: ImageScannerResolution read get_MaxResolution;
    property MaxScanArea: TSizeF read get_MaxScanArea;
    property MinBrightness: Integer read get_MinBrightness;
    property MinContrast: Integer read get_MinContrast;
    property MinResolution: ImageScannerResolution read get_MinResolution;
    property MinScanArea: TSizeF read get_MinScanArea;
    property OpticalResolution: ImageScannerResolution read get_OpticalResolution;
    property SelectedScanRegion: TRectF read get_SelectedScanRegion write put_SelectedScanRegion;
  end;

  // DualAPI Interface
  // Windows.Devices.Scanners.IImageScannerFeederConfiguration
  [WinRTClassNameAttribute(SImageScannerFeederConfiguration)]
  IImageScannerFeederConfiguration = interface(IInspectable)
  ['{74BDACEE-FA97-4C17-8280-40E39C6DCC67}']
    function get_CanAutoDetectPageSize: Boolean; safecall;
    function get_AutoDetectPageSize: Boolean; safecall;
    procedure put_AutoDetectPageSize(value: Boolean); safecall;
    function get_PageSize: Printing_PrintMediaSize; safecall;
    procedure put_PageSize(value: Printing_PrintMediaSize); safecall;
    function get_PageOrientation: Printing_PrintOrientation; safecall;
    procedure put_PageOrientation(value: Printing_PrintOrientation); safecall;
    function get_PageSizeDimensions: TSizeF; safecall;
    function IsPageSizeSupported(pageSize: Printing_PrintMediaSize; pageOrientation: Printing_PrintOrientation): Boolean; safecall;
    function get_MaxNumberOfPages: Cardinal; safecall;
    procedure put_MaxNumberOfPages(value: Cardinal); safecall;
    function get_CanScanDuplex: Boolean; safecall;
    function get_Duplex: Boolean; safecall;
    procedure put_Duplex(value: Boolean); safecall;
    function get_CanScanAhead: Boolean; safecall;
    function get_ScanAhead: Boolean; safecall;
    procedure put_ScanAhead(value: Boolean); safecall;
    property AutoDetectPageSize: Boolean read get_AutoDetectPageSize write put_AutoDetectPageSize;
    property CanAutoDetectPageSize: Boolean read get_CanAutoDetectPageSize;
    property CanScanAhead: Boolean read get_CanScanAhead;
    property CanScanDuplex: Boolean read get_CanScanDuplex;
    property Duplex: Boolean read get_Duplex write put_Duplex;
    property MaxNumberOfPages: Cardinal read get_MaxNumberOfPages write put_MaxNumberOfPages;
    property PageOrientation: Printing_PrintOrientation read get_PageOrientation write put_PageOrientation;
    property PageSize: Printing_PrintMediaSize read get_PageSize write put_PageSize;
    property PageSizeDimensions: TSizeF read get_PageSizeDimensions;
    property ScanAhead: Boolean read get_ScanAhead write put_ScanAhead;
  end;

  // DualAPI Interface
  // Windows.Devices.Scanners.IImageScannerScanResult
  [WinRTClassNameAttribute(SImageScannerScanResult)]
  IImageScannerScanResult = interface(IInspectable)
  ['{C91624CD-9037-4E48-84C1-AC0975076BC5}']
    function get_ScannedFiles: IVectorView_1__IStorageFile; safecall;
    property ScannedFiles: IVectorView_1__IStorageFile read get_ScannedFiles;
  end;

  // DualAPI Interface
  // Windows.Devices.Scanners.IImageScannerPreviewResult
  [WinRTClassNameAttribute(SImageScannerPreviewResult)]
  IImageScannerPreviewResult = interface(IInspectable)
  ['{08B7FE8E-8891-441D-BE9C-176FA109C8BB}']
    function get_Succeeded: Boolean; safecall;
    function get_Format: ImageScannerFormat; safecall;
    property Format: ImageScannerFormat read get_Format;
    property Succeeded: Boolean read get_Succeeded;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Scanners.IImageScannerPreviewResult>
  AsyncOperationCompletedHandler_1__IImageScannerPreviewResult = interface(IUnknown)
  ['{96C784BC-119C-557A-8D28-405AF877D7B2}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IImageScannerPreviewResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Scanners.IImageScannerPreviewResult>
  IAsyncOperation_1__IImageScannerPreviewResult = interface(IInspectable)
  ['{2EE5CD44-9985-5C27-9C6A-32A92405B896}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IImageScannerPreviewResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IImageScannerPreviewResult; safecall;
    function GetResults: IImageScannerPreviewResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IImageScannerPreviewResult read get_Completed write put_Completed;
  end;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Devices.Scanners.IImageScannerScanResult,UInt32>
  AsyncOperationProgressHandler_2__IImageScannerScanResult__Cardinal = interface(IUnknown)
  ['{55F1599D-3490-5BF9-95C5-320EF1652B30}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__IImageScannerScanResult__Cardinal; progressInfo: Cardinal); safecall;
  end;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Devices.Scanners.IImageScannerScanResult,UInt32>
  AsyncOperationWithProgressCompletedHandler_2__IImageScannerScanResult__Cardinal = interface(IUnknown)
  ['{0089CC7A-21E3-5AED-B565-F2FB72A84119}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__IImageScannerScanResult__Cardinal; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Devices.Scanners.IImageScannerScanResult,UInt32>
  IAsyncOperationWithProgress_2__IImageScannerScanResult__Cardinal = interface(IInspectable)
  ['{F6E8107E-475B-577F-8806-8B6B046E5833}']
    procedure put_Progress(handler: AsyncOperationProgressHandler_2__IImageScannerScanResult__Cardinal); safecall;
    function get_Progress: AsyncOperationProgressHandler_2__IImageScannerScanResult__Cardinal; safecall;
    procedure put_Completed(handler: AsyncOperationWithProgressCompletedHandler_2__IImageScannerScanResult__Cardinal); safecall;
    function get_Completed: AsyncOperationWithProgressCompletedHandler_2__IImageScannerScanResult__Cardinal; safecall;
    function GetResults: IImageScannerScanResult; safecall;
    property Progress: AsyncOperationProgressHandler_2__IImageScannerScanResult__Cardinal read get_Progress write put_Progress;
    property Completed: AsyncOperationWithProgressCompletedHandler_2__IImageScannerScanResult__Cardinal read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.Scanners.IImageScanner
  [WinRTClassNameAttribute(SImageScanner)]
  IImageScanner = interface(IInspectable)
  ['{53A88F78-5298-48A0-8DA3-8087519665E0}']
    function get_DeviceId: HSTRING; safecall;
    function get_DefaultScanSource: ImageScannerScanSource; safecall;
    function IsScanSourceSupported(value: ImageScannerScanSource): Boolean; safecall;
    function get_FlatbedConfiguration: IImageScannerFormatConfiguration; safecall;
    function get_FeederConfiguration: IImageScannerFormatConfiguration; safecall;
    function get_AutoConfiguration: IImageScannerFormatConfiguration; safecall;
    function IsPreviewSupported(scanSource: ImageScannerScanSource): Boolean; safecall;
    function ScanPreviewToStreamAsync(scanSource: ImageScannerScanSource; targetStream: IRandomAccessStream): IAsyncOperation_1__IImageScannerPreviewResult; safecall;
    function ScanFilesToFolderAsync(scanSource: ImageScannerScanSource; storageFolder: IStorageFolder): IAsyncOperationWithProgress_2__IImageScannerScanResult__Cardinal; safecall;
    property AutoConfiguration: IImageScannerFormatConfiguration read get_AutoConfiguration;
    property DefaultScanSource: ImageScannerScanSource read get_DefaultScanSource;
    property DeviceId: HSTRING read get_DeviceId;
    property FeederConfiguration: IImageScannerFormatConfiguration read get_FeederConfiguration;
    property FlatbedConfiguration: IImageScannerFormatConfiguration read get_FlatbedConfiguration;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Devices.Scanners.IImageScanner>
  AsyncOperationCompletedHandler_1__IImageScanner = interface(IUnknown)
  ['{60E91BF4-CA9E-57D7-AC8C-BA5180FFAECD}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IImageScanner; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Devices.Scanners.IImageScanner>
  IAsyncOperation_1__IImageScanner = interface(IInspectable)
  ['{279D0851-470C-54D1-8873-F2C5FD62A1DB}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IImageScanner); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IImageScanner; safecall;
    function GetResults: IImageScanner; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IImageScanner read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Devices.Scanners.IImageScannerStatics
  [WinRTClassNameAttribute(SImageScanner)]
  IImageScannerStatics = interface(IInspectable)
  ['{BC57E70E-D804-4477-9FB5-B911B5473897}']
    function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IImageScanner; safecall;
    function GetDeviceSelector: HSTRING; safecall;
  end;


  // Emit Forwarded classes
  // Windows.Devices.Scanners.ImageScannerAutoConfiguration
  // DualAPI

  // Windows.Devices.Scanners.ImageScannerFlatbedConfiguration
  // DualAPI

  // Windows.Devices.Scanners.ImageScannerFeederConfiguration
  // DualAPI

  // Windows.Devices.Scanners.ImageScannerScanResult
  // DualAPI

  // Windows.Devices.Scanners.ImageScannerPreviewResult
  // DualAPI

  // Windows.Devices.Scanners.ImageScanner
  // DualAPI
  TImageScanner = class(TWinRTGenericImportS<IImageScannerStatics>)
  public
    // -> IImageScannerStatics
    class function FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IImageScanner; static; inline;
    class function GetDeviceSelector: HSTRING; static; inline;
  end;


implementation

  // Emit Classes Implementation
 { TImageScanner }

class function TImageScanner.FromIdAsync(deviceId: HSTRING): IAsyncOperation_1__IImageScanner;
begin
  Result := Statics.FromIdAsync(deviceId);
end;

class function TImageScanner.GetDeviceSelector: HSTRING;
begin
  Result := Statics.GetDeviceSelector;
end;



end.
