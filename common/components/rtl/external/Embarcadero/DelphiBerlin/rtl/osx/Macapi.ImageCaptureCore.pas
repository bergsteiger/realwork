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
// Interfaces for Cocoa framework ImageCaptureCore
//

unit Macapi.ImageCaptureCore;

interface

uses
  Macapi.CocoaTypes,
  Macapi.Foundation,
  Macapi.ObjectiveC;

const
  ICDeviceTypeCamera = 1;
  {$EXTERNALSYM ICDeviceTypeCamera}
  ICDeviceTypeScanner = 2;
  {$EXTERNALSYM ICDeviceTypeScanner}
  ICDeviceLocationTypeLocal = 256;
  {$EXTERNALSYM ICDeviceLocationTypeLocal}
  ICDeviceLocationTypeShared = 512;
  {$EXTERNALSYM ICDeviceLocationTypeShared}
  ICDeviceLocationTypeBonjour = 1024;
  {$EXTERNALSYM ICDeviceLocationTypeBonjour}
  ICDeviceLocationTypeBluetooth = 2048;
  {$EXTERNALSYM ICDeviceLocationTypeBluetooth}
  ICDeviceTypeMaskCamera = 1;
  {$EXTERNALSYM ICDeviceTypeMaskCamera}
  ICDeviceTypeMaskScanner = 2;
  {$EXTERNALSYM ICDeviceTypeMaskScanner}
  ICDeviceLocationTypeMaskLocal = 256;
  {$EXTERNALSYM ICDeviceLocationTypeMaskLocal}
  ICDeviceLocationTypeMaskShared = 512;
  {$EXTERNALSYM ICDeviceLocationTypeMaskShared}
  ICDeviceLocationTypeMaskBonjour = 1024;
  {$EXTERNALSYM ICDeviceLocationTypeMaskBonjour}
  ICDeviceLocationTypeMaskBluetooth = 2048;
  {$EXTERNALSYM ICDeviceLocationTypeMaskBluetooth}
  ICDeviceLocationTypeMaskRemote = 65024;
  {$EXTERNALSYM ICDeviceLocationTypeMaskRemote}
  ICEXIFOrientation1 = 1;
  {$EXTERNALSYM ICEXIFOrientation1}
  ICEXIFOrientation2 = 2;
  {$EXTERNALSYM ICEXIFOrientation2}
  ICEXIFOrientation3 = 3;
  {$EXTERNALSYM ICEXIFOrientation3}
  ICEXIFOrientation4 = 4;
  {$EXTERNALSYM ICEXIFOrientation4}
  ICEXIFOrientation5 = 5;
  {$EXTERNALSYM ICEXIFOrientation5}
  ICEXIFOrientation6 = 6;
  {$EXTERNALSYM ICEXIFOrientation6}
  ICEXIFOrientation7 = 7;
  {$EXTERNALSYM ICEXIFOrientation7}
  ICEXIFOrientation8 = 8;
  {$EXTERNALSYM ICEXIFOrientation8}
  ICReturnSuccess = 0;
  {$EXTERNALSYM ICReturnSuccess}
  ICReturnInvalidParam = -9922;
  {$EXTERNALSYM ICReturnInvalidParam}
  ICReturnCommunicationTimedOut = -9923;
  {$EXTERNALSYM ICReturnCommunicationTimedOut}
  ICReturnScanOperationCanceled = -9924;
  {$EXTERNALSYM ICReturnScanOperationCanceled}
  ICReturnScannerInUseByLocalUser = -9925;
  {$EXTERNALSYM ICReturnScannerInUseByLocalUser}
  ICReturnScannerInUseByRemoteUser = -9926;
  {$EXTERNALSYM ICReturnScannerInUseByRemoteUser}
  ICReturnDeviceFailedToOpenSession = -9927;
  {$EXTERNALSYM ICReturnDeviceFailedToOpenSession}
  ICReturnDeviceFailedToCloseSession = -9928;
  {$EXTERNALSYM ICReturnDeviceFailedToCloseSession}
  ICReturnScannerFailedToSelectFunctionalUnit = -9929;
  {$EXTERNALSYM ICReturnScannerFailedToSelectFunctionalUnit}
  ICReturnScannerFailedToCompleteOverviewScan = -9930;
  {$EXTERNALSYM ICReturnScannerFailedToCompleteOverviewScan}
  ICReturnScannerFailedToCompleteScan = -9931;
  {$EXTERNALSYM ICReturnScannerFailedToCompleteScan}
  ICReturnReceivedUnsolicitedScannerStatusInfo = -9932;
  {$EXTERNALSYM ICReturnReceivedUnsolicitedScannerStatusInfo}
  ICReturnReceivedUnsolicitedScannerErrorInfo = -9933;
  {$EXTERNALSYM ICReturnReceivedUnsolicitedScannerErrorInfo}
  ICReturnDownloadFailed = -9934;
  {$EXTERNALSYM ICReturnDownloadFailed}
  ICReturnUploadFailed = -9935;
  {$EXTERNALSYM ICReturnUploadFailed}
  ICReturnFailedToCompletePassThroughCommand = -9936;
  {$EXTERNALSYM ICReturnFailedToCompletePassThroughCommand}
  ICReturnDownloadCanceled = -9937;
  {$EXTERNALSYM ICReturnDownloadCanceled}
  ICReturnFailedToEnabeTethering = -9938;
  {$EXTERNALSYM ICReturnFailedToEnabeTethering}
  ICReturnFailedToDisabeTethering = -9939;
  {$EXTERNALSYM ICReturnFailedToDisabeTethering}
  ICReturnFailedToCompleteSendMessageRequest = -9940;
  {$EXTERNALSYM ICReturnFailedToCompleteSendMessageRequest}
  ICReturnDeleteFilesFailed = -9941;
  {$EXTERNALSYM ICReturnDeleteFilesFailed}
  ICReturnDeleteFilesCanceled = -9942;
  {$EXTERNALSYM ICReturnDeleteFilesCanceled}
  ICReturnDeviceIsPasscodeLocked = -9943;
  {$EXTERNALSYM ICReturnDeviceIsPasscodeLocked}
  ICReturnDeviceFailedToTakePicture = -9944;
  {$EXTERNALSYM ICReturnDeviceFailedToTakePicture}
  ICReturnDeviceSoftwareNotInstalled = -9945;
  {$EXTERNALSYM ICReturnDeviceSoftwareNotInstalled}
  ICReturnDeviceSoftwareIsBeingInstalled = -9946;
  {$EXTERNALSYM ICReturnDeviceSoftwareIsBeingInstalled}
  ICReturnDeviceSoftwareInstallationCompleted = -9947;
  {$EXTERNALSYM ICReturnDeviceSoftwareInstallationCompleted}
  ICReturnDeviceSoftwareInstallationCanceled = -9948;
  {$EXTERNALSYM ICReturnDeviceSoftwareInstallationCanceled}
  ICReturnDeviceSoftwareInstallationFailed = -9949;
  {$EXTERNALSYM ICReturnDeviceSoftwareInstallationFailed}
  ICReturnDeviceSoftwareNotAvailable = -9950;
  {$EXTERNALSYM ICReturnDeviceSoftwareNotAvailable}
  ICScannerFunctionalUnitTypeFlatbed = 0;
  {$EXTERNALSYM ICScannerFunctionalUnitTypeFlatbed}
  ICScannerFunctionalUnitTypePositiveTransparency = 1;
  {$EXTERNALSYM ICScannerFunctionalUnitTypePositiveTransparency}
  ICScannerFunctionalUnitTypeNegativeTransparency = 2;
  {$EXTERNALSYM ICScannerFunctionalUnitTypeNegativeTransparency}
  ICScannerFunctionalUnitTypeDocumentFeeder = 3;
  {$EXTERNALSYM ICScannerFunctionalUnitTypeDocumentFeeder}
  ICScannerMeasurementUnitInches = 0;
  {$EXTERNALSYM ICScannerMeasurementUnitInches}
  ICScannerMeasurementUnitCentimeters = 1;
  {$EXTERNALSYM ICScannerMeasurementUnitCentimeters}
  ICScannerMeasurementUnitPicas = 2;
  {$EXTERNALSYM ICScannerMeasurementUnitPicas}
  ICScannerMeasurementUnitPoints = 3;
  {$EXTERNALSYM ICScannerMeasurementUnitPoints}
  ICScannerMeasurementUnitTwips = 4;
  {$EXTERNALSYM ICScannerMeasurementUnitTwips}
  ICScannerMeasurementUnitPixels = 5;
  {$EXTERNALSYM ICScannerMeasurementUnitPixels}
  ICScannerBitDepth1Bit = 1;
  {$EXTERNALSYM ICScannerBitDepth1Bit}
  ICScannerBitDepth8Bits = 8;
  {$EXTERNALSYM ICScannerBitDepth8Bits}
  ICScannerBitDepth16Bits = 16;
  {$EXTERNALSYM ICScannerBitDepth16Bits}
  ICScannerColorDataFormatTypeChunky = 0;
  {$EXTERNALSYM ICScannerColorDataFormatTypeChunky}
  ICScannerColorDataFormatTypePlanar = 1;
  {$EXTERNALSYM ICScannerColorDataFormatTypePlanar}
  ICScannerPixelDataTypeBW = 0;
  {$EXTERNALSYM ICScannerPixelDataTypeBW}
  ICScannerPixelDataTypeGray = 1;
  {$EXTERNALSYM ICScannerPixelDataTypeGray}
  ICScannerPixelDataTypeRGB = 2;
  {$EXTERNALSYM ICScannerPixelDataTypeRGB}
  ICScannerPixelDataTypePalette = 3;
  {$EXTERNALSYM ICScannerPixelDataTypePalette}
  ICScannerPixelDataTypeCMY = 4;
  {$EXTERNALSYM ICScannerPixelDataTypeCMY}
  ICScannerPixelDataTypeCMYK = 5;
  {$EXTERNALSYM ICScannerPixelDataTypeCMYK}
  ICScannerPixelDataTypeYUV = 6;
  {$EXTERNALSYM ICScannerPixelDataTypeYUV}
  ICScannerPixelDataTypeYUVK = 7;
  {$EXTERNALSYM ICScannerPixelDataTypeYUVK}
  ICScannerPixelDataTypeCIEXYZ = 8;
  {$EXTERNALSYM ICScannerPixelDataTypeCIEXYZ}
  ICScannerDocumentTypeDefault = 0;
  {$EXTERNALSYM ICScannerDocumentTypeDefault}
  ICScannerDocumentTypeA4 = 1;
  {$EXTERNALSYM ICScannerDocumentTypeA4}
  ICScannerDocumentTypeB5 = 2;
  {$EXTERNALSYM ICScannerDocumentTypeB5}
  ICScannerDocumentTypeUSLetter = 3;
  {$EXTERNALSYM ICScannerDocumentTypeUSLetter}
  ICScannerDocumentTypeUSLegal = 4;
  {$EXTERNALSYM ICScannerDocumentTypeUSLegal}
  ICScannerDocumentTypeA5 = 5;
  {$EXTERNALSYM ICScannerDocumentTypeA5}
  ICScannerDocumentTypeISOB4 = 6;
  {$EXTERNALSYM ICScannerDocumentTypeISOB4}
  ICScannerDocumentTypeISOB6 = 7;
  {$EXTERNALSYM ICScannerDocumentTypeISOB6}
  ICScannerDocumentTypeUSLedger = 9;
  {$EXTERNALSYM ICScannerDocumentTypeUSLedger}
  ICScannerDocumentTypeUSExecutive = 10;
  {$EXTERNALSYM ICScannerDocumentTypeUSExecutive}
  ICScannerDocumentTypeA3 = 11;
  {$EXTERNALSYM ICScannerDocumentTypeA3}
  ICScannerDocumentTypeISOB3 = 12;
  {$EXTERNALSYM ICScannerDocumentTypeISOB3}
  ICScannerDocumentTypeA6 = 13;
  {$EXTERNALSYM ICScannerDocumentTypeA6}
  ICScannerDocumentTypeC4 = 14;
  {$EXTERNALSYM ICScannerDocumentTypeC4}
  ICScannerDocumentTypeC5 = 15;
  {$EXTERNALSYM ICScannerDocumentTypeC5}
  ICScannerDocumentTypeC6 = 16;
  {$EXTERNALSYM ICScannerDocumentTypeC6}
  ICScannerDocumentType4A0 = 17;
  {$EXTERNALSYM ICScannerDocumentType4A0}
  ICScannerDocumentType2A0 = 18;
  {$EXTERNALSYM ICScannerDocumentType2A0}
  ICScannerDocumentTypeA0 = 19;
  {$EXTERNALSYM ICScannerDocumentTypeA0}
  ICScannerDocumentTypeA1 = 20;
  {$EXTERNALSYM ICScannerDocumentTypeA1}
  ICScannerDocumentTypeA2 = 21;
  {$EXTERNALSYM ICScannerDocumentTypeA2}
  ICScannerDocumentTypeA7 = 22;
  {$EXTERNALSYM ICScannerDocumentTypeA7}
  ICScannerDocumentTypeA8 = 23;
  {$EXTERNALSYM ICScannerDocumentTypeA8}
  ICScannerDocumentTypeA9 = 24;
  {$EXTERNALSYM ICScannerDocumentTypeA9}
  ICScannerDocumentType10 = 25;
  {$EXTERNALSYM ICScannerDocumentType10}
  ICScannerDocumentTypeISOB0 = 26;
  {$EXTERNALSYM ICScannerDocumentTypeISOB0}
  ICScannerDocumentTypeISOB1 = 27;
  {$EXTERNALSYM ICScannerDocumentTypeISOB1}
  ICScannerDocumentTypeISOB2 = 28;
  {$EXTERNALSYM ICScannerDocumentTypeISOB2}
  ICScannerDocumentTypeISOB5 = 29;
  {$EXTERNALSYM ICScannerDocumentTypeISOB5}
  ICScannerDocumentTypeISOB7 = 30;
  {$EXTERNALSYM ICScannerDocumentTypeISOB7}
  ICScannerDocumentTypeISOB8 = 31;
  {$EXTERNALSYM ICScannerDocumentTypeISOB8}
  ICScannerDocumentTypeISOB9 = 32;
  {$EXTERNALSYM ICScannerDocumentTypeISOB9}
  ICScannerDocumentTypeISOB10 = 33;
  {$EXTERNALSYM ICScannerDocumentTypeISOB10}
  ICScannerDocumentTypeJISB0 = 34;
  {$EXTERNALSYM ICScannerDocumentTypeJISB0}
  ICScannerDocumentTypeJISB1 = 35;
  {$EXTERNALSYM ICScannerDocumentTypeJISB1}
  ICScannerDocumentTypeJISB2 = 36;
  {$EXTERNALSYM ICScannerDocumentTypeJISB2}
  ICScannerDocumentTypeJISB3 = 37;
  {$EXTERNALSYM ICScannerDocumentTypeJISB3}
  ICScannerDocumentTypeJISB4 = 38;
  {$EXTERNALSYM ICScannerDocumentTypeJISB4}
  ICScannerDocumentTypeJISB6 = 39;
  {$EXTERNALSYM ICScannerDocumentTypeJISB6}
  ICScannerDocumentTypeJISB7 = 40;
  {$EXTERNALSYM ICScannerDocumentTypeJISB7}
  ICScannerDocumentTypeJISB8 = 41;
  {$EXTERNALSYM ICScannerDocumentTypeJISB8}
  ICScannerDocumentTypeJISB9 = 42;
  {$EXTERNALSYM ICScannerDocumentTypeJISB9}
  ICScannerDocumentTypeJISB10 = 43;
  {$EXTERNALSYM ICScannerDocumentTypeJISB10}
  ICScannerDocumentTypeC0 = 44;
  {$EXTERNALSYM ICScannerDocumentTypeC0}
  ICScannerDocumentTypeC1 = 45;
  {$EXTERNALSYM ICScannerDocumentTypeC1}
  ICScannerDocumentTypeC2 = 46;
  {$EXTERNALSYM ICScannerDocumentTypeC2}
  ICScannerDocumentTypeC3 = 47;
  {$EXTERNALSYM ICScannerDocumentTypeC3}
  ICScannerDocumentTypeC7 = 48;
  {$EXTERNALSYM ICScannerDocumentTypeC7}
  ICScannerDocumentTypeC8 = 49;
  {$EXTERNALSYM ICScannerDocumentTypeC8}
  ICScannerDocumentTypeC9 = 50;
  {$EXTERNALSYM ICScannerDocumentTypeC9}
  ICScannerDocumentTypeC10 = 51;
  {$EXTERNALSYM ICScannerDocumentTypeC10}
  ICScannerDocumentTypeUSStatement = 52;
  {$EXTERNALSYM ICScannerDocumentTypeUSStatement}
  ICScannerDocumentTypeBusinessCard = 53;
  {$EXTERNALSYM ICScannerDocumentTypeBusinessCard}
  ICScannerDocumentTypeE = 60;
  {$EXTERNALSYM ICScannerDocumentTypeE}
  ICScannerDocumentType3R = 61;
  {$EXTERNALSYM ICScannerDocumentType3R}
  ICScannerDocumentType4R = 62;
  {$EXTERNALSYM ICScannerDocumentType4R}
  ICScannerDocumentType5R = 63;
  {$EXTERNALSYM ICScannerDocumentType5R}
  ICScannerDocumentType6R = 64;
  {$EXTERNALSYM ICScannerDocumentType6R}
  ICScannerDocumentType8R = 65;
  {$EXTERNALSYM ICScannerDocumentType8R}
  ICScannerDocumentTypeS8R = 66;
  {$EXTERNALSYM ICScannerDocumentTypeS8R}
  ICScannerDocumentType10R = 67;
  {$EXTERNALSYM ICScannerDocumentType10R}
  ICScannerDocumentTypeS10R = 68;
  {$EXTERNALSYM ICScannerDocumentTypeS10R}
  ICScannerDocumentType11R = 69;
  {$EXTERNALSYM ICScannerDocumentType11R}
  ICScannerDocumentType12R = 70;
  {$EXTERNALSYM ICScannerDocumentType12R}
  ICScannerDocumentTypeS12R = 71;
  {$EXTERNALSYM ICScannerDocumentTypeS12R}
  ICScannerDocumentType110 = 72;
  {$EXTERNALSYM ICScannerDocumentType110}
  ICScannerDocumentTypeAPSH = 73;
  {$EXTERNALSYM ICScannerDocumentTypeAPSH}
  ICScannerDocumentTypeAPSC = 74;
  {$EXTERNALSYM ICScannerDocumentTypeAPSC}
  ICScannerDocumentTypeAPSP = 75;
  {$EXTERNALSYM ICScannerDocumentTypeAPSP}
  ICScannerDocumentType135 = 76;
  {$EXTERNALSYM ICScannerDocumentType135}
  ICScannerDocumentTypeMF = 77;
  {$EXTERNALSYM ICScannerDocumentTypeMF}
  ICScannerDocumentTypeLF = 78;
  {$EXTERNALSYM ICScannerDocumentTypeLF}
  ICScannerFunctionalUnitStateReady = (1 shl 0);
  {$EXTERNALSYM ICScannerFunctionalUnitStateReady}
  ICScannerFunctionalUnitStateScanInProgress = (1 shl 1);
  {$EXTERNALSYM ICScannerFunctionalUnitStateScanInProgress}
  ICScannerFunctionalUnitStateOverviewScanInProgress = (1 shl 2);
  {$EXTERNALSYM ICScannerFunctionalUnitStateOverviewScanInProgress}
  ICScannerFeatureTypeEnumeration = 0;
  {$EXTERNALSYM ICScannerFeatureTypeEnumeration}
  ICScannerFeatureTypeRange = 1;
  {$EXTERNALSYM ICScannerFeatureTypeRange}
  ICScannerFeatureTypeBoolean = 2;
  {$EXTERNALSYM ICScannerFeatureTypeBoolean}
  ICScannerFeatureTypeTemplate = 3;
  {$EXTERNALSYM ICScannerFeatureTypeTemplate}
  ICScannerTransferModeFileBased = 0;
  {$EXTERNALSYM ICScannerTransferModeFileBased}
  ICScannerTransferModeMemoryBased = 1;
  {$EXTERNALSYM ICScannerTransferModeMemoryBased}

type

  // ===== Forward declarations =====
  {$M+}
  ICDevice = interface;
  ICDeviceDelegate = interface;
  ICCameraDevice = interface;
  ICCameraFolder = interface;
  ICCameraItem = interface;
  ICCameraFile = interface;
  ICCameraDeviceDelegate = interface;
  ICCameraDeviceDownloadDelegate = interface;
  ICDeviceBrowser = interface;
  ICDeviceBrowserDelegate = interface;
  ICScannerFeature = interface;
  ICScannerFeatureEnumeration = interface;
  ICScannerFeatureRange = interface;
  ICScannerFeatureBoolean = interface;
  ICScannerFeatureTemplate = interface;
  ICScannerFunctionalUnit = interface;
  ICScannerFunctionalUnitFlatbed = interface;
  ICScannerFunctionalUnitPositiveTransparency = interface;
  ICScannerFunctionalUnitNegativeTransparency = interface;
  ICScannerFunctionalUnitDocumentFeeder = interface;
  ICScannerBandData = interface;
  ICScannerDevice = interface;
  ICScannerDeviceDelegate = interface;

  // ===== Framework typedefs =====
  {$M+}
  ICDeviceType = NSUInteger;
  {$EXTERNALSYM ICDeviceType}
  ICDeviceLocationType = NSUInteger;
  {$EXTERNALSYM ICDeviceLocationType}
  ICDeviceTypeMask = NSUInteger;
  {$EXTERNALSYM ICDeviceTypeMask}
  ICDeviceLocationTypeMask = NSUInteger;
  {$EXTERNALSYM ICDeviceLocationTypeMask}
  ICEXIFOrientationType = NSUInteger;
  {$EXTERNALSYM ICEXIFOrientationType}
  ICReturnCode = Integer;
  {$EXTERNALSYM ICReturnCode}
  ICScannerFunctionalUnitType = NSUInteger;
  {$EXTERNALSYM ICScannerFunctionalUnitType}
  ICScannerMeasurementUnit = NSUInteger;
  {$EXTERNALSYM ICScannerMeasurementUnit}
  ICScannerBitDepth = NSUInteger;
  {$EXTERNALSYM ICScannerBitDepth}
  ICScannerColorDataFormatType = NSUInteger;
  {$EXTERNALSYM ICScannerColorDataFormatType}
  ICScannerPixelDataType = NSUInteger;
  {$EXTERNALSYM ICScannerPixelDataType}
  ICScannerDocumentType = NSUInteger;
  {$EXTERNALSYM ICScannerDocumentType}
  ICScannerFunctionalUnitState = Cardinal;
  {$EXTERNALSYM ICScannerFunctionalUnitState}
  ICScannerFeatureType = NSUInteger;
  {$EXTERNALSYM ICScannerFeatureType}
  ICScannerTransferMode = NSUInteger;
  {$EXTERNALSYM ICScannerTransferMode}
  // ===== Interface declarations =====

  ICDeviceClass = interface(NSObjectClass)
    ['{C46C0868-82B2-405B-A5F7-4043FA56D804}']
  end;
  ICDevice = interface(NSObject)
    ['{F5D26182-53C1-4D91-AD50-EBA724D8E371}']
    procedure setDelegate(delegate: Pointer); cdecl;
    function delegate: Pointer; cdecl;
    function &type: ICDeviceType; cdecl;
    function name: NSString; cdecl;
    function icon: CGImageRef; cdecl;
    function capabilities: NSArray; cdecl;
    function modulePath: NSString; cdecl;
    function moduleVersion: NSString; cdecl;
    function moduleExecutableArchitecture: Integer; cdecl;
    function isRemote: Boolean; cdecl;
    function isShared: Boolean; cdecl;
    function hasConfigurableWiFiInterface: Boolean; cdecl;
    function transportType: NSString; cdecl;
    function usbLocationID: Integer; cdecl;
    function usbProductID: Integer; cdecl;
    function usbVendorID: Integer; cdecl;
    function fwGUID: Int64; cdecl;
    function serialNumberString: NSString; cdecl;
    function locationDescription: NSString; cdecl;
    function hasOpenSession: Boolean; cdecl;
    function UUIDString: NSString; cdecl;
    function persistentIDString: NSString; cdecl;
    function buttonPressed: NSString; cdecl;
    procedure setAutolaunchApplicationPath(autolaunchApplicationPath: NSString); cdecl;
    function autolaunchApplicationPath: NSString; cdecl;
    function userData: NSMutableDictionary; cdecl;
    procedure requestOpenSession; cdecl;
    procedure requestCloseSession; cdecl;
    procedure requestYield; cdecl;
    procedure requestSendMessage(messageCode: Cardinal; outData: NSData; maxReturnedDataSize: Cardinal;
      sendMessageDelegate: Pointer; didSendMessageSelector: SEL; contextInfo: Pointer); cdecl;
    procedure requestEjectOrDisconnect; cdecl;
  end;

  TICDevice = class(TOCGenericImport<ICDeviceClass, ICDevice>)
  end;
  PICDevice = Pointer;

  ICCameraDeviceClass = interface(ICDeviceClass)
    ['{A0ADD5C7-5B37-4F5B-B7DD-C397DFBEA033}']
  end;
  ICCameraDevice = interface(ICDevice)
    ['{3A1713B6-2565-40E1-84AF-023FAFD8ED8F}']
    function batteryLevelAvailable: Boolean; cdecl;
    function batteryLevel: NSUInteger; cdecl;
    function contentCatalogPercentCompleted: NSUInteger; cdecl;
    function contents: NSArray; cdecl;
    function mediaFiles: NSArray; cdecl;
    function timeOffset: NSTimeInterval; cdecl;
    function isAccessRestrictedAppleDevice: Boolean; cdecl;
    function mountPoint: NSString; cdecl;
    procedure setTetheredCaptureEnabled(tetheredCaptureEnabled: Boolean); cdecl;
    function tetheredCaptureEnabled: Boolean; cdecl;
    function filesOfType(fileUTType: NSString): NSArray; cdecl;
    procedure requestSyncClock; cdecl;
    procedure requestEnableTethering; cdecl;
    procedure requestDisableTethering; cdecl;
    procedure requestTakePicture; cdecl;
    procedure requestDeleteFiles(files: NSArray); cdecl;
    procedure cancelDelete; cdecl;
    procedure requestDownloadFile(&file: ICCameraFile; options: NSDictionary; downloadDelegate: Pointer;
      didDownloadSelector: SEL; contextInfo: Pointer); cdecl;
    procedure cancelDownload; cdecl;
    procedure requestUploadFile(fileURL: NSURL; options: NSDictionary; uploadDelegate: Pointer; didUploadSelector: SEL;
      contextInfo: Pointer); cdecl;
    procedure requestReadDataFromFile(&file: ICCameraFile; atOffset: Integer; length: Integer; readDelegate: Pointer;
      didReadDataSelector: SEL; contextInfo: Pointer); cdecl;
    procedure requestSendPTPCommand(command: NSData; outData: NSData; sendCommandDelegate: Pointer;
      didSendCommandSelector: SEL; contextInfo: Pointer); cdecl;
  end;

  TICCameraDevice = class(TOCGenericImport<ICCameraDeviceClass, ICCameraDevice>)
  end;
  PICCameraDevice = Pointer;

  ICCameraItemClass = interface(NSObjectClass)
    ['{A833437E-7AE2-4134-BD4F-607E513C488C}']
  end;
  ICCameraItem = interface(NSObject)
    ['{A831A694-4E3A-4B11-B76B-0ED8B4E5E7A8}']
    function device: ICCameraDevice; cdecl;
    function parentFolder: ICCameraFolder; cdecl;
    function name: NSString; cdecl;
    function UTI: NSString; cdecl;
    function fileSystemPath: NSString; cdecl;
    function isLocked: Boolean; cdecl;
    function isRaw: Boolean; cdecl;
    function isInTemporaryStore: Boolean; cdecl;
    function creationDate: NSDate; cdecl;
    function modificationDate: NSDate; cdecl;
    function thumbnailIfAvailable: CGImageRef; cdecl;
    function largeThumbnailIfAvailable: CGImageRef; cdecl;
    function metadataIfAvailable: NSDictionary; cdecl;
    function userData: NSMutableDictionary; cdecl;
    function ptpObjectHandle: Cardinal; cdecl;
    function wasAddedAfterContentCatalogCompleted: Boolean; cdecl;
  end;

  TICCameraItem = class(TOCGenericImport<ICCameraItemClass, ICCameraItem>)
  end;
  PICCameraItem = Pointer;

  ICCameraFolderClass = interface(ICCameraItemClass)
    ['{C6EC84BF-9675-4912-A4E1-891CF9E88047}']
  end;
  ICCameraFolder = interface(ICCameraItem)
    ['{783618E8-AEAD-4690-96B2-E9C62EB2E601}']
    function contents: NSArray; cdecl;
  end;

  TICCameraFolder = class(TOCGenericImport<ICCameraFolderClass, ICCameraFolder>)
  end;
  PICCameraFolder = Pointer;

  ICCameraFileClass = interface(ICCameraItemClass)
    ['{9C71F2B9-4136-4C36-A080-AF76AAC29A27}']
  end;
  ICCameraFile = interface(ICCameraItem)
    ['{520BD034-C51F-425E-89F1-6254796CA41F}']
    function fileSize: Integer; cdecl;
    procedure setOrientation(orientation: ICEXIFOrientationType); cdecl;
    function orientation: ICEXIFOrientationType; cdecl;
    function duration: Double; cdecl;
    function sidecarFiles: NSArray; cdecl;
  end;

  TICCameraFile = class(TOCGenericImport<ICCameraFileClass, ICCameraFile>)
  end;
  PICCameraFile = Pointer;

  ICDeviceBrowserClass = interface(NSObjectClass)
    ['{AC652CEF-8C87-4497-9E32-A2150876F99D}']
  end;
  ICDeviceBrowser = interface(NSObject)
    ['{8C2DA7D6-3220-4AB2-801F-4E8FDB0EE90B}']
    procedure setDelegate(delegate: Pointer); cdecl;
    function delegate: Pointer; cdecl;
    function isBrowsing: Boolean; cdecl;
    procedure setBrowsedDeviceTypeMask(browsedDeviceTypeMask: ICDeviceTypeMask); cdecl;
    function browsedDeviceTypeMask: ICDeviceTypeMask; cdecl;
    function devices: NSArray; cdecl;
    function preferredDevice: ICDevice; cdecl;
    function init: Pointer; cdecl;
    procedure start; cdecl;
    procedure stop; cdecl;
  end;

  TICDeviceBrowser = class(TOCGenericImport<ICDeviceBrowserClass, ICDeviceBrowser>)
  end;
  PICDeviceBrowser = Pointer;

  ICScannerFeatureClass = interface(NSObjectClass)
    ['{AE4C4BE3-5C08-4430-A51A-02B51B4B94E6}']
  end;
  ICScannerFeature = interface(NSObject)
    ['{E867632B-A4C9-49DC-9966-5C6BF827249B}']
    function &type: ICScannerFeatureType; cdecl;
    function internalName: NSString; cdecl;
    function humanReadableName: NSString; cdecl;
    function tooltip: NSString; cdecl;
  end;

  TICScannerFeature = class(TOCGenericImport<ICScannerFeatureClass, ICScannerFeature>)
  end;
  PICScannerFeature = Pointer;

  ICScannerFeatureEnumerationClass = interface(ICScannerFeatureClass)
    ['{934A95FE-7515-481F-8535-0CD1420768F4}']
  end;
  ICScannerFeatureEnumeration = interface(ICScannerFeature)
    ['{89084881-9A5E-4793-8E3B-B7FC577E8CC1}']
    procedure setCurrentValue(currentValue: Pointer); cdecl;
    function currentValue: Pointer; cdecl;
    function defaultValue: Pointer; cdecl;
    function values: NSArray; cdecl;
    function menuItemLabels: NSArray; cdecl;
    function menuItemLabelsTooltips: NSArray; cdecl;
  end;

  TICScannerFeatureEnumeration = class(TOCGenericImport<ICScannerFeatureEnumerationClass, ICScannerFeatureEnumeration>)
  end;
  PICScannerFeatureEnumeration = Pointer;

  ICScannerFeatureRangeClass = interface(ICScannerFeatureClass)
    ['{88F5F998-A05F-4E4E-8C23-9CEAFC09E164}']
  end;
  ICScannerFeatureRange = interface(ICScannerFeature)
    ['{2486AA15-6356-4BB4-AFB7-48211D795150}']
    procedure setCurrentValue(currentValue: CGFloat); cdecl;
    function currentValue: CGFloat; cdecl;
    function defaultValue: CGFloat; cdecl;
    function minValue: CGFloat; cdecl;
    function maxValue: CGFloat; cdecl;
    function stepSize: CGFloat; cdecl;
  end;

  TICScannerFeatureRange = class(TOCGenericImport<ICScannerFeatureRangeClass, ICScannerFeatureRange>)
  end;
  PICScannerFeatureRange = Pointer;

  ICScannerFeatureBooleanClass = interface(ICScannerFeatureClass)
    ['{777AF2B2-C414-403D-86C8-B5B6C5FAD634}']
  end;
  ICScannerFeatureBoolean = interface(ICScannerFeature)
    ['{7D90CCE7-8EF9-4C1C-9B7E-00A02308923D}']
    procedure setValue(value: Boolean); cdecl;
    function value: Boolean; cdecl;
  end;

  TICScannerFeatureBoolean = class(TOCGenericImport<ICScannerFeatureBooleanClass, ICScannerFeatureBoolean>)
  end;
  PICScannerFeatureBoolean = Pointer;

  ICScannerFeatureTemplateClass = interface(ICScannerFeatureClass)
    ['{1BA6F4B3-6D09-450E-BF59-625CB78AB102}']
  end;
  ICScannerFeatureTemplate = interface(ICScannerFeature)
    ['{B416C3AD-A2EF-4922-B9FC-1E9F120A80A5}']
    function targets: NSArray; cdecl;
  end;

  TICScannerFeatureTemplate = class(TOCGenericImport<ICScannerFeatureTemplateClass, ICScannerFeatureTemplate>)
  end;
  PICScannerFeatureTemplate = Pointer;

  ICScannerFunctionalUnitClass = interface(NSObjectClass)
    ['{EAF39309-E2B5-4CFA-A3D3-32F083F24455}']
  end;
  ICScannerFunctionalUnit = interface(NSObject)
    ['{13440AB0-ACD3-47B7-9797-4F6C4DD29B52}']
    function &type: ICScannerFunctionalUnitType; cdecl;
    procedure setPixelDataType(pixelDataType: ICScannerPixelDataType); cdecl;
    function pixelDataType: ICScannerPixelDataType; cdecl;
    function supportedBitDepths: NSIndexSet; cdecl;
    procedure setBitDepth(bitDepth: ICScannerBitDepth); cdecl;
    function bitDepth: ICScannerBitDepth; cdecl;
    function supportedMeasurementUnits: NSIndexSet; cdecl;
    procedure setMeasurementUnit(measurementUnit: ICScannerMeasurementUnit); cdecl;
    function measurementUnit: ICScannerMeasurementUnit; cdecl;
    function supportedResolutions: NSIndexSet; cdecl;
    function preferredResolutions: NSIndexSet; cdecl;
    procedure setResolution(resolution: NSUInteger); cdecl;
    function resolution: NSUInteger; cdecl;
    function nativeXResolution: NSUInteger; cdecl;
    function nativeYResolution: NSUInteger; cdecl;
    function supportedScaleFactors: NSIndexSet; cdecl;
    function preferredScaleFactors: NSIndexSet; cdecl;
    procedure setScaleFactor(scaleFactor: NSUInteger); cdecl;
    function scaleFactor: NSUInteger; cdecl;
    function templates: NSArray; cdecl;
    function vendorFeatures: NSArray; cdecl;
    function physicalSize: NSSize; cdecl;
    procedure setScanArea(scanArea: NSRect); cdecl;
    function scanArea: NSRect; cdecl;
    procedure setScanAreaOrientation(scanAreaOrientation: ICEXIFOrientationType); cdecl;
    function scanAreaOrientation: ICEXIFOrientationType; cdecl;
    function acceptsThresholdForBlackAndWhiteScanning: Boolean; cdecl;
    procedure setUsesThresholdForBlackAndWhiteScanning(usesThresholdForBlackAndWhiteScanning: Boolean); cdecl;
    function usesThresholdForBlackAndWhiteScanning: Boolean; cdecl;
    function defaultThresholdForBlackAndWhiteScanning: Byte; cdecl;
    procedure setThresholdForBlackAndWhiteScanning(thresholdForBlackAndWhiteScanning: Byte); cdecl;
    function thresholdForBlackAndWhiteScanning: Byte; cdecl;
    function state: ICScannerFunctionalUnitState; cdecl;
    function scanInProgress: Boolean; cdecl;
    function scanProgressPercentDone: CGFloat; cdecl;
    function canPerformOverviewScan: Boolean; cdecl;
    function overviewScanInProgress: Boolean; cdecl;
    function overviewImage: CGImageRef; cdecl;
    procedure setOverviewResolution(overviewResolution: NSUInteger); cdecl;
    function overviewResolution: NSUInteger; cdecl;
  end;

  TICScannerFunctionalUnit = class(TOCGenericImport<ICScannerFunctionalUnitClass, ICScannerFunctionalUnit>)
  end;
  PICScannerFunctionalUnit = Pointer;

  ICScannerFunctionalUnitFlatbedClass = interface(ICScannerFunctionalUnitClass)
    ['{19120AF6-D2CD-469A-A75C-BB27F955C614}']
  end;
  ICScannerFunctionalUnitFlatbed = interface(ICScannerFunctionalUnit)
    ['{9DA6747D-CAC3-483A-B92D-2C68746913BE}']
    function supportedDocumentTypes: NSIndexSet; cdecl;
    procedure setDocumentType(documentType: ICScannerDocumentType); cdecl;
    function documentType: ICScannerDocumentType; cdecl;
    function documentSize: NSSize; cdecl;
  end;

  TICScannerFunctionalUnitFlatbed = class(TOCGenericImport<ICScannerFunctionalUnitFlatbedClass,
    ICScannerFunctionalUnitFlatbed>)
  end;
  PICScannerFunctionalUnitFlatbed = Pointer;

  ICScannerFunctionalUnitPositiveTransparencyClass = interface(ICScannerFunctionalUnitClass)
    ['{C54424AA-A0A0-4F42-96F8-2AD6F7A90DB3}']
  end;
  ICScannerFunctionalUnitPositiveTransparency = interface(ICScannerFunctionalUnit)
    ['{05CA0431-764B-4543-A109-217135DC4CBE}']
    function supportedDocumentTypes: NSIndexSet; cdecl;
    procedure setDocumentType(documentType: ICScannerDocumentType); cdecl;
    function documentType: ICScannerDocumentType; cdecl;
    function documentSize: NSSize; cdecl;
  end;

  TICScannerFunctionalUnitPositiveTransparency = class
    (TOCGenericImport<ICScannerFunctionalUnitPositiveTransparencyClass, ICScannerFunctionalUnitPositiveTransparency>)
  end;
  PICScannerFunctionalUnitPositiveTransparency = Pointer;

  ICScannerFunctionalUnitNegativeTransparencyClass = interface(ICScannerFunctionalUnitClass)
    ['{3BD6C2AA-3E9E-4D95-8EF7-8FCCED857B18}']
  end;
  ICScannerFunctionalUnitNegativeTransparency = interface(ICScannerFunctionalUnit)
    ['{9F3AE277-1E33-4A7D-8D60-5026B10DF3EE}']
    function supportedDocumentTypes: NSIndexSet; cdecl;
    procedure setDocumentType(documentType: ICScannerDocumentType); cdecl;
    function documentType: ICScannerDocumentType; cdecl;
    function documentSize: NSSize; cdecl;
  end;

  TICScannerFunctionalUnitNegativeTransparency = class
    (TOCGenericImport<ICScannerFunctionalUnitNegativeTransparencyClass, ICScannerFunctionalUnitNegativeTransparency>)
  end;
  PICScannerFunctionalUnitNegativeTransparency = Pointer;

  ICScannerFunctionalUnitDocumentFeederClass = interface(ICScannerFunctionalUnitClass)
    ['{1E422E03-2D5D-4002-AADF-01F687C9700E}']
  end;
  ICScannerFunctionalUnitDocumentFeeder = interface(ICScannerFunctionalUnit)
    ['{D1357766-35C1-473B-93F9-D6D64E6D53C3}']
    function supportedDocumentTypes: NSIndexSet; cdecl;
    procedure setDocumentType(documentType: ICScannerDocumentType); cdecl;
    function documentType: ICScannerDocumentType; cdecl;
    function documentSize: NSSize; cdecl;
    function supportsDuplexScanning: Boolean; cdecl;
    procedure setDuplexScanningEnabled(duplexScanningEnabled: Boolean); cdecl;
    function duplexScanningEnabled: Boolean; cdecl;
    function documentLoaded: Boolean; cdecl;
    procedure setOddPageOrientation(oddPageOrientation: ICEXIFOrientationType); cdecl;
    function oddPageOrientation: ICEXIFOrientationType; cdecl;
    procedure setEvenPageOrientation(evenPageOrientation: ICEXIFOrientationType); cdecl;
    function evenPageOrientation: ICEXIFOrientationType; cdecl;
    function reverseFeederPageOrder: Boolean; cdecl;
  end;

  TICScannerFunctionalUnitDocumentFeeder = class(TOCGenericImport<ICScannerFunctionalUnitDocumentFeederClass,
    ICScannerFunctionalUnitDocumentFeeder>)
  end;
  PICScannerFunctionalUnitDocumentFeeder = Pointer;

  ICScannerBandDataClass = interface(NSObjectClass)
    ['{0DDE0209-38D2-46D6-92BA-F506F25F987B}']
  end;
  ICScannerBandData = interface(NSObject)
    ['{E778686A-D18B-40F9-896C-27B2E06BEFAB}']
    function fullImageWidth: NSUInteger; cdecl;
    function fullImageHeight: NSUInteger; cdecl;
    function bitsPerPixel: NSUInteger; cdecl;
    function bitsPerComponent: NSUInteger; cdecl;
    function numComponents: NSUInteger; cdecl;
    function isBigEndian: Boolean; cdecl;
    function pixelDataType: ICScannerPixelDataType; cdecl;
    function colorSyncProfilePath: NSString; cdecl;
    function bytesPerRow: NSUInteger; cdecl;
    function dataStartRow: NSUInteger; cdecl;
    function dataNumRows: NSUInteger; cdecl;
    function dataSize: NSUInteger; cdecl;
    function dataBuffer: NSData; cdecl;
  end;

  TICScannerBandData = class(TOCGenericImport<ICScannerBandDataClass, ICScannerBandData>)
  end;
  PICScannerBandData = Pointer;

  ICScannerDeviceClass = interface(ICDeviceClass)
    ['{7D11FF5F-1A99-4D75-8BFD-EDF6A5C7D8FF}']
  end;
  ICScannerDevice = interface(ICDevice)
    ['{0C3E38A7-BED0-4D02-943C-578DC5561249}']
    function availableFunctionalUnitTypes: NSArray; cdecl;
    function selectedFunctionalUnit: ICScannerFunctionalUnit; cdecl;
    procedure setTransferMode(transferMode: ICScannerTransferMode); cdecl;
    function transferMode: ICScannerTransferMode; cdecl;
    procedure setMaxMemoryBandSize(maxMemoryBandSize: UInt32); cdecl;
    function maxMemoryBandSize: UInt32; cdecl;
    procedure setDownloadsDirectory(downloadsDirectory: NSURL); cdecl;
    function downloadsDirectory: NSURL; cdecl;
    procedure setDocumentName(documentName: NSString); cdecl;
    function documentName: NSString; cdecl;
    procedure setDocumentUTI(documentUTI: NSString); cdecl;
    function documentUTI: NSString; cdecl;
    procedure requestSelectFunctionalUnit(&type: ICScannerFunctionalUnitType); cdecl;
    procedure requestOverviewScan; cdecl;
    procedure requestScan; cdecl;
    procedure cancelScan; cdecl;
  end;

  TICScannerDevice = class(TOCGenericImport<ICScannerDeviceClass, ICScannerDevice>)
  end;
  PICScannerDevice = Pointer;

  // ===== Protocol declarations =====

  ICDeviceDelegate = interface(IObjectiveC)
    ['{086C6FA2-C444-4035-A382-10A4B4ABA03F}']
    procedure didRemoveDevice(device: ICDevice); cdecl;
    [MethodName('device:didOpenSessionWithError:')]
    procedure deviceDidOpenSessionWithError(device: ICDevice; didOpenSessionWithError: NSError); cdecl;
    procedure deviceDidBecomeReady(device: ICDevice); cdecl;
    [MethodName('device:didCloseSessionWithError:')]
    procedure deviceDidCloseSessionWithError(device: ICDevice; didCloseSessionWithError: NSError); cdecl;
    procedure deviceDidChangeName(device: ICDevice); cdecl;
    procedure deviceDidChangeSharingState(device: ICDevice); cdecl;
    [MethodName('device:didReceiveStatusInformation:')]
    procedure deviceDidReceiveStatusInformation(device: ICDevice; didReceiveStatusInformation: NSDictionary); cdecl;
    [MethodName('device:didEncounterError:')]
    procedure deviceDidEncounterError(device: ICDevice; didEncounterError: NSError); cdecl;
    [MethodName('device:didReceiveButtonPress:')]
    procedure deviceDidReceiveButtonPress(device: ICDevice; didReceiveButtonPress: NSString); cdecl;
    [MethodName('device:didReceiveCustomNotification:data:')]
    procedure deviceDidReceiveCustomNotificationData(device: ICDevice; didReceiveCustomNotification: NSDictionary;
      data: NSData); cdecl;
  end;

  ICCameraDeviceDelegate = interface(IObjectiveC)
    ['{4DCCB201-E897-4334-8B32-80111DCE4617}']
    [MethodName('cameraDevice:didAddItem:')]
    procedure cameraDeviceDidAddItem(camera: ICCameraDevice; didAddItem: ICCameraItem); cdecl;
    [MethodName('cameraDevice:didAddItems:')]
    procedure cameraDeviceDidAddItems(camera: ICCameraDevice; didAddItems: NSArray); cdecl;
    [MethodName('cameraDevice:didRemoveItem:')]
    procedure cameraDeviceDidRemoveItem(camera: ICCameraDevice; didRemoveItem: ICCameraItem); cdecl;
    [MethodName('cameraDevice:didRemoveItems:')]
    procedure cameraDeviceDidRemoveItems(camera: ICCameraDevice; didRemoveItems: NSArray); cdecl;
    [MethodName('cameraDevice:didRenameItems:')]
    procedure cameraDeviceDidRenameItems(camera: ICCameraDevice; didRenameItems: NSArray); cdecl;
    [MethodName('cameraDevice:didCompleteDeleteFilesWithError:')]
    procedure cameraDeviceDidCompleteDeleteFilesWithError(scanner: ICCameraDevice;
      didCompleteDeleteFilesWithError: NSError); cdecl;
    procedure cameraDeviceDidChangeCapability(camera: ICCameraDevice); cdecl;
    [MethodName('cameraDevice:didReceiveThumbnailForItem:')]
    procedure cameraDeviceDidReceiveThumbnailForItem(camera: ICCameraDevice;
      didReceiveThumbnailForItem: ICCameraItem); cdecl;
    [MethodName('cameraDevice:didReceiveMetadataForItem:')]
    procedure cameraDeviceDidReceiveMetadataForItem(camera: ICCameraDevice;
      didReceiveMetadataForItem: ICCameraItem); cdecl;
    [MethodName('cameraDevice:didReceivePTPEvent:')]
    procedure cameraDeviceDidReceivePTPEvent(camera: ICCameraDevice; didReceivePTPEvent: NSData); cdecl;
    procedure deviceDidBecomeReadyWithCompleteContentCatalog(device: ICDevice); cdecl;
  end;

  ICCameraDeviceDownloadDelegate = interface(IObjectiveC)
    ['{7EB2A053-B031-4EAC-B976-D47F29DEBF61}']
    procedure didDownloadFile(&file: ICCameraFile; error: NSError; options: NSDictionary; contextInfo: Pointer); cdecl;
    procedure didReceiveDownloadProgressForFile(&file: ICCameraFile; downloadedBytes: Integer;
      maxBytes: Integer); cdecl;
  end;

  ICDeviceBrowserDelegate = interface(IObjectiveC)
    ['{9F28EA26-3A8D-4517-B5EB-A774D1887F31}']
    [MethodName('deviceBrowser:didAddDevice:moreComing:')]
    procedure deviceBrowserDidAddDeviceMoreComing(browser: ICDeviceBrowser; didAddDevice: ICDevice;
      moreComing: Boolean); cdecl;
    [MethodName('deviceBrowser:didRemoveDevice:moreGoing:')]
    procedure deviceBrowserDidRemoveDeviceMoreGoing(browser: ICDeviceBrowser; didRemoveDevice: ICDevice;
      moreGoing: Boolean); cdecl;
    [MethodName('deviceBrowser:deviceDidChangeName:')]
    procedure deviceBrowserDeviceDidChangeName(browser: ICDeviceBrowser; deviceDidChangeName: ICDevice); cdecl;
    [MethodName('deviceBrowser:deviceDidChangeSharingState:')]
    procedure deviceBrowserDeviceDidChangeSharingState(browser: ICDeviceBrowser;
      deviceDidChangeSharingState: ICDevice); cdecl;
    [MethodName('deviceBrowser:requestsSelectDevice:')]
    procedure deviceBrowserRequestsSelectDevice(browser: ICDeviceBrowser; requestsSelectDevice: ICDevice); cdecl;
    procedure deviceBrowserDidEnumerateLocalDevices(browser: ICDeviceBrowser); cdecl;
  end;

  ICScannerDeviceDelegate = interface(IObjectiveC)
    ['{62812373-C80B-4D5E-AC76-79032218F117}']
    procedure scannerDeviceDidBecomeAvailable(scanner: ICScannerDevice); cdecl;
    [MethodName('scannerDevice:didSelectFunctionalUnit:error:')]
    procedure scannerDeviceDidSelectFunctionalUnitError(scanner: ICScannerDevice;
      didSelectFunctionalUnit: ICScannerFunctionalUnit; error: NSError); cdecl;
    [MethodName('scannerDevice:didScanToURL:data:')]
    procedure scannerDeviceDidScanToURLData(scanner: ICScannerDevice; didScanToURL: NSURL; data: NSData); cdecl;
    [MethodName('scannerDevice:didScanToURL:')]
    procedure scannerDeviceDidScanToURL(scanner: ICScannerDevice; didScanToURL: NSURL); cdecl;
    [MethodName('scannerDevice:didScanToBandData:')]
    procedure scannerDeviceDidScanToBandData(scanner: ICScannerDevice; didScanToBandData: ICScannerBandData); cdecl;
    [MethodName('scannerDevice:didCompleteOverviewScanWithError:')]
    procedure scannerDeviceDidCompleteOverviewScanWithError(scanner: ICScannerDevice;
      didCompleteOverviewScanWithError: NSError); cdecl;
    [MethodName('scannerDevice:didCompleteScanWithError:')]
    procedure scannerDeviceDidCompleteScanWithError(scanner: ICScannerDevice; didCompleteScanWithError: NSError); cdecl;
  end;

  // ===== Exported string consts =====

function ICTransportTypeUSB: NSString;
function ICTransportTypeFireWire: NSString;
function ICTransportTypeBluetooth: NSString;
function ICTransportTypeTCPIP: NSString;
function ICTransportTypeMassStorage: NSString;
function ICDeviceLocationDescriptionUSB: NSString;
function ICDeviceLocationDescriptionFireWire: NSString;
function ICDeviceLocationDescriptionBluetooth: NSString;
function ICDeviceLocationDescriptionMassStorage: NSString;
function ICButtonTypeScan: NSString;
function ICButtonTypeMail: NSString;
function ICButtonTypeCopy: NSString;
function ICButtonTypeWeb: NSString;
function ICButtonTypePrint: NSString;
function ICButtonTypeTransfer: NSString;
function ICStatusNotificationKey: NSString;
function ICStatusCodeKey: NSString;
function ICLocalizedStatusNotificationKey: NSString;
function ICDeviceCanEjectOrDisconnect: NSString;
function ICCameraDeviceCanTakePicture: NSString;
function ICCameraDeviceCanTakePictureUsingShutterReleaseOnCamera: NSString;
function ICCameraDeviceCanDeleteOneFile: NSString;
function ICCameraDeviceCanDeleteAllFiles: NSString;
function ICCameraDeviceCanSyncClock: NSString;
function ICCameraDeviceCanReceiveFile: NSString;
function ICCameraDeviceCanAcceptPTPCommands: NSString;
function ICDownloadsDirectoryURL: NSString;
function ICSaveAsFilename: NSString;
function ICSavedFilename: NSString;
function ICSavedAncillaryFiles: NSString;
function ICOverwrite: NSString;
function ICDeleteAfterSuccessfulDownload: NSString;
function ICDownloadSidecarFiles: NSString;
function ICScannerStatusWarmingUp: NSString;
function ICScannerStatusWarmUpDone: NSString;
function ICScannerStatusRequestsOverviewScan: NSString;


// ===== External functions =====

const
  libImageCaptureCore = '/System/Library/Frameworks/ImageCaptureCore.framework/ImageCaptureCore';

implementation

uses System.SysUtils;

var
  ImageCaptureModule: HMODULE;

function ICTransportTypeUSB: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICTransportTypeUSB');
end;

function ICTransportTypeFireWire: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICTransportTypeFireWire');
end;

function ICTransportTypeBluetooth: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICTransportTypeBluetooth');
end;

function ICTransportTypeTCPIP: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICTransportTypeTCPIP');
end;

function ICTransportTypeMassStorage: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICTransportTypeMassStorage');
end;

function ICDeviceLocationDescriptionUSB: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICDeviceLocationDescriptionUSB');
end;

function ICDeviceLocationDescriptionFireWire: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICDeviceLocationDescriptionFireWire');
end;

function ICDeviceLocationDescriptionBluetooth: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICDeviceLocationDescriptionBluetooth');
end;

function ICDeviceLocationDescriptionMassStorage: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICDeviceLocationDescriptionMassStorage');
end;

function ICButtonTypeScan: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICButtonTypeScan');
end;

function ICButtonTypeMail: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICButtonTypeMail');
end;

function ICButtonTypeCopy: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICButtonTypeCopy');
end;

function ICButtonTypeWeb: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICButtonTypeWeb');
end;

function ICButtonTypePrint: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICButtonTypePrint');
end;

function ICButtonTypeTransfer: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICButtonTypeTransfer');
end;

function ICStatusNotificationKey: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICStatusNotificationKey');
end;

function ICStatusCodeKey: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICStatusCodeKey');
end;

function ICLocalizedStatusNotificationKey: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICLocalizedStatusNotificationKey');
end;

function ICDeviceCanEjectOrDisconnect: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICDeviceCanEjectOrDisconnect');
end;

function ICCameraDeviceCanTakePicture: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICCameraDeviceCanTakePicture');
end;

function ICCameraDeviceCanTakePictureUsingShutterReleaseOnCamera: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICCameraDeviceCanTakePictureUsingShutterReleaseOnCamera');
end;

function ICCameraDeviceCanDeleteOneFile: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICCameraDeviceCanDeleteOneFile');
end;

function ICCameraDeviceCanDeleteAllFiles: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICCameraDeviceCanDeleteAllFiles');
end;

function ICCameraDeviceCanSyncClock: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICCameraDeviceCanSyncClock');
end;

function ICCameraDeviceCanReceiveFile: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICCameraDeviceCanReceiveFile');
end;

function ICCameraDeviceCanAcceptPTPCommands: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICCameraDeviceCanAcceptPTPCommands');
end;

function ICDownloadsDirectoryURL: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICDownloadsDirectoryURL');
end;

function ICSaveAsFilename: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICSaveAsFilename');
end;

function ICSavedFilename: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICSavedFilename');
end;

function ICSavedAncillaryFiles: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICSavedAncillaryFiles');
end;

function ICOverwrite: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICOverwrite');
end;

function ICDeleteAfterSuccessfulDownload: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICDeleteAfterSuccessfulDownload');
end;

function ICDownloadSidecarFiles: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICDownloadSidecarFiles');
end;

function ICScannerStatusWarmingUp: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICScannerStatusWarmingUp');
end;

function ICScannerStatusWarmUpDone: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICScannerStatusWarmUpDone');
end;

function ICScannerStatusRequestsOverviewScan: NSString;
begin
  Result := CocoaNSStringConst(libImageCaptureCore, 'ICScannerStatusRequestsOverviewScan');
end;

initialization
  ImageCaptureModule := LoadLibrary(libImageCaptureCore);

finalization
  if ImageCaptureModule <> 0 then
    FreeLibrary(ImageCaptureModule);
end.


end.
